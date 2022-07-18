unit _LogFile;

interface

uses
  	System.Classes,
    _LogEvents, _LogEvent;


const
  RemoteSessionFileNameLength = 28;   // length of filename for log of remote session
  DateOffset = -9;                    // character offset (in filename) from the length to the beginning of the date
  Century0000 = 20000000;             // addition to date extracted from filename (in format yymmdd) to get date in format yyyymmdd

type
  TLogFile = class (TObject)
    private
      Pin: byte;
      IsRemote: boolean;
      Date: integer;
      LogEvents: TLogEvents<TLogEvent>;
      constructor Create (const aPin: byte; const aIsRemote: boolean; const aDate: integer); overload;
      constructor Create (const FileName: string); overload;
      function    GetDoesLogFileExistsSQL: string;
      function    GetInsertSQL: string;
      function    GetInsertedIDSQL: string;
      function    LogFileExists: boolean;
      procedure   ParseLogFile (const DirectoryName, FileName: string);
      procedure   ParseStringList (const StringList: TStringList);
    public
      constructor Create (const DirectoryName, FileName: string); overload;
      destructor  Destroy; override;
      procedure   ImportLogIntoSQL;
  end;


implementation

uses
  	System.SysUtils,
    _DataModule,
    itSystem;


constructor TLogFile.Create (const aPin: byte; const aIsRemote: boolean; const aDate: integer);
begin
  inherited Create;
  Pin := aPin;
  IsRemote := aIsRemote;
  Date := aDate;
  LogEvents := TLogEvents<TLogEvent>.Create;
end;


constructor TLogFile.Create (const FileName: string);
begin
  Create (
    StrToInt (Copy (FileName,10,2)),
    Length (FileName) = RemoteSessionFileNameLength,
    Century0000 + StrToInt (Copy (FileName, Length (FileName) + DateOffset, 6)));
end;


constructor TLogFile.Create (const DirectoryName, FileName: string);
begin
  Create (FileName);
  ParseLogFile (DirectoryName, FileName);
end;


destructor TLogFile.Destroy;
begin
  FreeAndNil (LogEvents);
  inherited Destroy;
end;


function TLogFile.GetDoesLogFileExistsSQL: string;
begin
  Result := 'SELECT ' +
                'Count (*) AS RecCount ' +
            'FROM ' +
                'LogFile ' +
            'WHERE ' +
                'PinID = ' + IntToStr (Pin) + ' And Date = ' + IntToStr (Date) + ' And IsRemote = ' + IntToStr (Ord (IsRemote)) + ';';
end;


function TLogFile.GetInsertSQL: string;
begin
  Result := 'INSERT INTO LogFile (PinID, IsRemote, Date) Values (' +
    IntToStr (Pin) + ',' +
    IntToStr (Ord (IsRemote)) + ',' +
    IntToStr (Date) + ');';
end;


function TLogFile.GetInsertedIDSQL: string;
begin
  Result := 'SELECT SCOPE_IDENTITY () AS LogFileID;';
end;


procedure TLogFile.ImportLogIntoSQL;
var
  LogFileID: integer;
begin
  if LogFileExists then
    Exit;
  LogFileID := DataLink.ExecCommandAndReturnInteger (GetInsertSQL + GetInsertedIDSQL, 'LogFileID');
  DataLink.ExecCommand (LogEvents.GetInsertSQL (LogFileID));
end;


function TLogFile.LogFileExists: boolean;
begin
  Result := (DataLink.ExecCommandAndReturnInteger (GetDoesLogFileExistsSQL, 'RecCount') <> 0);
end;


procedure TLogFile.ParseLogFile (const DirectoryName, FileName: string);
var
  StringList: TStringList;
begin
  try
    try
      StringList := TStringList.Create (true);
      StringList.LoadFromFile (DirectoryName + FileName);
      ParseStringList (StringList);
    except
      on E:Exception do
        raise Exception.Create ('. File: ' + FileName + CrLf + CrLf + E.Message);
    end;
  finally
    FreeAndNil (StringList);
  end;
end;


procedure TLogFile.ParseStringList (const StringList: TStringList);
var
  i: integer;
begin
  for i := 0 to StringList.Count - 1 do
    LogEvents.AddEvent (StringList[i]);
end;


end.
