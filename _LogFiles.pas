unit _LogFiles;

interface

uses
  System.Generics.Collections,
  Vcl.StdCtrls, Vcl.Forms,
  _LogFile;


const
  LogFileNameMask = 'SURADNIK*.LOG';    // filename mask so that I would fetch log files ONLY

type
  TLogFiles<T: TLogFile> = class (TObjectList<T>)
    private
      DirectoryName: string;
    public
      constructor Create (const aDirectoryName:string);
      procedure ImportLogsIntoSQL;
      procedure LoadNewLogFiles;
  end;

var
  LogFiles: TLogFiles<TLogFile>;
  LogMemo: TMemo;
  LogForm: TForm;


procedure CloseLogFiles;
procedure ImportLogsIntoSQL;
procedure LoadNewLogFiles (const DirectoryName:string);


implementation

uses
  System.SysUtils, System.Classes,
  itSystem;


procedure CloseLogFiles;
begin
  FreeAndNil (LogFiles);
end;


procedure ImportLogsIntoSQL;
begin
  LogFiles.ImportLogsIntoSQL;
end;


procedure LoadNewLogFiles (const DirectoryName:string);
begin
  if LogFiles = nil then
    LogFiles := TLogFiles<TLogFile>.Create (DirectoryName);

  LogFiles.LoadNewLogFiles;
end;


constructor TLogFiles<T>.Create (const aDirectoryName:string);
begin
  inherited Create;
  DirectoryName := aDirectoryName;
end;


procedure TLogFiles<T>.ImportLogsIntoSQL;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
    Items[i].ImportLogIntoSQL;
end;


procedure TLogFiles<T>.LoadNewLogFiles;
var
  SearchRec: TSearchRec;
begin
  if FindFirst (DirectoryName + LogFileNameMask, faNormal, SearchRec) <> 0 then
    Exit;

  repeat
    Add (TLogFile.Create (DirectoryName, SearchRec.Name));
    LogMemo.Text := LogMemo.Text + CrLf + SearchRec.Name;
  until FindNext (SearchRec) <> 0;

  findClose (SearchRec);
end;


initialization
  LogFiles := nil;


end.

