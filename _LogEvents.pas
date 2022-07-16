unit _LogEvents;

interface

uses
  System.Generics.Collections,
  _LogEvent;


type
  TLogEvents<T: TLogEvent> = class(TObjectList<T>)
    private
    public
      procedure AddEvent(const EventString: string);
      function  GetInsertSQL(const LogFileID: integer): string;
  end;


implementation

uses
  System.SysUtils, System.Classes;


procedure TLogEvents<T>.AddEvent(const EventString: string);
begin
  try
    Add(TLogEvent.Create(Trim(EventString)));
  except
    on E:Exception do
      raise Exception.Create('Event: ''' + EventString + ''''#13#10#13#10 + E.Message);
  end;
end;


function TLogEvents<T>.GetInsertSQL(const LogFileID: integer): string;
var
  i: integer;
begin
  Result := '';
  for i := 0 to Count - 1 do
    Result := Result + Items[i].GetInsertSQL(LogFileID, i) + #13#10;
end;


end.

