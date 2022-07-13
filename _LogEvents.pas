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


end.

