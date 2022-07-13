unit KcLogFiles;

interface

uses
  System.Generics.Collections,
  Vcl.StdCtrls, Vcl.Forms,
  KcLogFile;


const
  LogFileNameMask = 'SURADNIK*.LOG';    // filename mask so that I would fetch log files ONLY

type
  TLogFiles<T: TLogFile> = class (TObjectList<T>)
    private
      DirectoryName: string;
    public
      constructor Create(const aDirectoryName:string);
      procedure LoadNewLogFiles;
  end;

var
  LogFiles: TLogFiles<TLogFile>;
  LogMemo: TMemo;
  LogForm: TForm;

procedure LoadNewLogFiles(const DirectoryName:string);


implementation

uses
  System.SysUtils, System.Classes,
  System.Threading;


procedure LoadNewLogFiles(const DirectoryName:string);
begin
  if LogFiles = nil then
    LogFiles := TLogFiles<TLogFile>.Create(DirectoryName);

  LogFiles.LoadNewLogFiles;
end;


constructor TLogFiles<T>.Create(const aDirectoryName:string);
begin
  inherited Create;
  DirectoryName := aDirectoryName;
end;


procedure TLogFiles<T>.LoadNewLogFiles;
var
  SearchRec: TSearchRec;
begin
  if FindFirst(DirectoryName + LogFileNameMask, faNormal, SearchRec) <> 0 then
    Exit;

  repeat
    Add(TLogFile.Create(DirectoryName, SearchRec.Name));
    LogMemo.Text := LogMemo.Text + #13#10 + SearchRec.Name;
  until FindNext(SearchRec) <> 0;

  findClose(SearchRec);
end;


initialization
  LogFiles := nil;


finalization
  FreeAndNil(LogFiles);


end.

(*
    TTask.Run(
      procedure
      begin
        Add(TLogFile.Create(DirectoryName, SearchRec.Name));
        TThread.Synchronize(nil,
          procedure
          begin
            LogMemo.Text := LogMemo.Text + #13#10 + SearchRec.Name;

          end);
      end);
*)
