program KCLog;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MainForm},
  _LogFile in '_LogFile.pas',
  _UOperater in '_UOperater.pas',
  _LogFiles in '_LogFiles.pas',
  _LogEvent in '_LogEvent.pas',
  _EventType in '_EventType.pas',
  _LogEvents in '_LogEvents.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
