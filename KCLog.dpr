program KCLog;

uses
  Vcl.Forms,
  KCLogMain in 'KCLogMain.pas' {MainForm},
  KcLogFile in 'KcLogFile.pas',
  KcLogSavjetnik in 'KcLogSavjetnik.pas',
  KcLogFiles in 'KcLogFiles.pas',
  KcLogEvent in 'KcLogEvent.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
