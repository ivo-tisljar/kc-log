unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;


type
  TMainForm = class(TForm)
    Memo: TMemo;
    ButtonObrada: TButton;
    EditDirectory: TEdit;
    Label1: TLabel;
    LabelDirectory: TLabel;
    procedure ButtonObradaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;


implementation

uses
  _LogFiles;

{$R *.dfm}


procedure TMainForm.ButtonObradaClick(Sender: TObject);
begin
  ButtonObrada.Enabled := false;
  LogMemo := Memo;
  LoadNewLogFiles(EditDirectory.Text);
  ImportLogsIntoSQL;
end;


end.
