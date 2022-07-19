unit _DataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;


type
  TDataLink = class (TDataModule)
    private
      FDConnection: TFDConnection;
      FDQuery: TFDQuery;
    public
      procedure ExecCommand (const SQL: string);
      function  ExecCommandAndReturnInteger (const SQL, FieldName: string): integer;
  end;


var
  DataLink: TDataLink;


implementation

uses
  itSystem;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


procedure TDataLink.ExecCommand (const SQL: string);
begin
  try
    FDQuery.ExecSQL (SQL);
  except
    on E:Exception do
      raise Exception.Create ('ExecCommand SQL: ' + SQL + CrLf + CrLf + E.Message);
  end;
end;


function TDataLink.ExecCommandAndReturnInteger (const SQL, FieldName: string): integer;
begin
  try
    FDQuery.Open (SQL);
    Result := FDQuery.FieldByName (FieldName).AsInteger;
    FDQuery.Close;
  except
    on E:Exception do
      raise Exception.Create ('ExecCommandAndReturnInteger SQL: ' + SQL + CrLf + CrLf + E.Message);
  end;
end;


end.
