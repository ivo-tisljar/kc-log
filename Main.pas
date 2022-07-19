unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;


type
  TMainForm = class (TForm)
    private
      MemoLogFiles: TMemo;
      ButtonLoadAndImport: TButton;
      EditDirectory: TEdit;
      LabelLogFiles: TLabel;
      LabelDirectory: TLabel;
      procedure ButtonLoadAndImportClick (Sender: TObject);
    public
  end;


var
  MainForm: TMainForm;


implementation

uses
  _LogFiles;

{$R *.dfm}


procedure TMainForm.ButtonLoadAndImportClick (Sender: TObject);
begin
  ButtonLoadAndImport.Enabled := false;
  InsertNewLogFilesIntoSQLDatabase (EditDirectory.Text, MemoLogFiles);
  ButtonLoadAndImport.Enabled := true;
end;


end.
