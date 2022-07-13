program KCLog;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MainForm},
  _LogFile in '_LogFile.pas',
  _UOperater in '_UOperater.pas',
  _LogFiles in '_LogFiles.pas',
  _Event in '_Event.pas',
  _EventType in '_EventType.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
