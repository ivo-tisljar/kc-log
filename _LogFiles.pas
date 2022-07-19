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
      LogMemo: TMemo;
      procedure AppendToMemo (const LogFileName: string);
    public
      constructor Create (const aDirectoryName:string; const Memo: TMemo);
      procedure InsertNewLogsIntoSQLDatabase;
      procedure ReadLogFilesFromDisk;
  end;


procedure InsertNewLogFilesIntoSQLDatabase (const DirectoryName: string; const Memo: TMemo);


implementation

uses
  System.SysUtils, System.Classes,
  itSystem;


procedure InsertNewLogFilesIntoSQLDatabase (const DirectoryName: string; const Memo: TMemo);
var
  LogFiles: TLogFiles<TLogFile>;
begin
  LogFiles := TLogFiles<TLogFile>.Create (DirectoryName, Memo);
  LogFiles.ReadLogFilesFromDisk;
  LogFiles.InsertNewLogsIntoSQLDatabase;
  FreeAndNil (LogFiles);
end;


constructor TLogFiles<T>.Create (const aDirectoryName:string; const Memo: TMemo);
begin
  inherited Create;
  DirectoryName := aDirectoryName;
  LogMemo := Memo;
end;


procedure TLogFiles<T>.AppendToMemo (const LogFileName: string);
begin
  LogMemo.Text := LogMemo.Text + CrLf + LogFileName;
end;


procedure TLogFiles<T>.InsertNewLogsIntoSQLDatabase;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
    Items[i].InsertNewLogIntoSQLDatabase;
end;


procedure TLogFiles<T>.ReadLogFilesFromDisk;
var
  SearchRec: TSearchRec;
begin
  if FindFirst (DirectoryName + LogFileNameMask, faNormal, SearchRec) <> 0 then
    Exit;

  repeat
    Add (TLogFile.Create (DirectoryName, SearchRec.Name));
    AppendToMemo (SearchRec.Name);
  until FindNext (SearchRec) <> 0;

  findClose (SearchRec);
end;


end.

