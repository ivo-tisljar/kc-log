program KCLog;

uses
  Vcl.Forms,
  KCLogMain in 'KCLogMain.pas' {Form1},
  KcLogFile in 'KcLogFile.pas',
  KcLogSavjetnik in 'KcLogSavjetnik.pas',
  KcLogFiles in 'KcLogFiles.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
