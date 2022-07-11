unit KcLogFile;

interface

const
  RemoteSessionFileNameLength = 28;  // length of filename for log of remote session
  DateOffset = -7;
  Century0000 = 20000000;

type
  TLogFile = class(TObject)
    private
      Pin: byte;
      IsRemote: boolean;
      Date: integer;
    public
      constructor Create(const xPin: byte; const xIsRemote: boolean; const xDate: integer); overload;
      constructor Create(const FileName: string); overload;
  end;

implementation

uses
  System.SysUtils;


constructor TLogFile.Create(const xPin: byte; const xIsRemote: boolean; const xDate: integer);
begin
  inherited Create;
  Pin := xPin;
  IsRemote := xIsRemote;
  Date := xDate;
end;

constructor TLogFile.Create(const FileName: string);
begin
  Create(
    StrToInt(Copy(FileName,10,2)),
    Length(FileName) = RemoteSessionFileNameLength,
    Century0000 + StrToInt(Copy(FileName, Length(FileName) + DateOffset, 6)));
end;


end.
