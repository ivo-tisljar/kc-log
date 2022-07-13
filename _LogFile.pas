unit _LogFile;

interface

uses
  	System.Classes;


const
  RemoteSessionFileNameLength = 28;   // length of filename for log of remote session
  DateOffset = -9;                    // character offset (in filename) from the length to the beginning of the date
  Century0000 = 20000000;             // addition to date extracted from filename (in format yymmdd) to get date in format yyyymmdd

type
  TLogFile = class(TObject)
    private
      Pin: byte;
      IsRemote: boolean;
      Date: integer;
      constructor Create(const aPin: byte; const aIsRemote: boolean; const aDate: integer); overload;
      constructor Create(const FileName: string); overload;
      procedure   ParseLogFile(const DirectoryName, FileName: string);
      procedure   ParseStringList(const StringList: TStringList);
    public
      constructor Create(const DirectoryName, FileName: string); overload;
  end;


implementation

uses
  	System.SysUtils;


constructor TLogFile.Create(const aPin: byte; const aIsRemote: boolean; const aDate: integer);
begin
  inherited Create;
  Pin := aPin;
  IsRemote := aIsRemote;
  Date := aDate;
end;


constructor TLogFile.Create(const FileName: string);
begin
  Create(
    StrToInt(Copy(FileName,10,2)),
    Length(FileName) = RemoteSessionFileNameLength,
    Century0000 + StrToInt(Copy(FileName, Length(FileName) + DateOffset, 6)));
end;


constructor TLogFile.Create(const DirectoryName, FileName: string);
begin
  Create(FileName);
  ParseLogFile(DirectoryName, FileName);
end;


procedure TLogFile.ParseLogFile(const DirectoryName, FileName: string);
var
  StringList: TStringList;
begin
  StringList := TStringList.Create(true);
  StringList.LoadFromFile(DirectoryName + FileName);
  ParseStringList(StringList);
  FreeAndNil(StringList);
end;


procedure TLogFile.ParseStringList(const StringList: TStringList);
var
  i: integer;
begin
  for i := 0 to StringList.Count - 1 do
    begin

    end;
end;


end.
