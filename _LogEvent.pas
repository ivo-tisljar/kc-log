unit _LogEvent;

interface

uses
  _EventType;


const
  TimeStringLength = 6;


type
  TLogEvent = class(TObject)
    private
      Time: integer;
      EventType: TEventType;
      Info: shortInt;
      function ExtractInfo(const EventString: string; const InfoStringLength: integer): integer;
      function GetInfoStringLength(const EventString: string): byte;
    public
      constructor Create(const EventString: string);
  end;


implementation

uses
  System.SysUtils;


constructor TLogEvent.Create(const EventString: string);
var
  InfoStringLength: integer;
begin
  inherited Create;
  Time := StrToInt(Copy(EventString, 1, TimeStringLength));
  InfoStringLength := GetInfoStringLength(EventString);
  Info := ExtractInfo(EventString, InfoStringLength);
  EventType := GetEventType(Copy(EventString,
                                 1 + TimeStringLength,
                                 Length(EventString) - TimeStringLength - InfoStringLength));
end;


function TLogEvent.ExtractInfo(const EventString: string; const InfoStringLength: integer): integer;
begin
  if InfoStringLength = 0 then
    Result := -1
  else
    Result := StrToInt(Copy(EventString,
                            Length(EventString) - InfoStringLength + 1,
                            InfoStringLength));
  Result := Result Mod 100;
end;


function TLogEvent.GetInfoStringLength(const EventString: string): byte;
var
  i: integer;
begin
  i := Length(EventString);
  while Ord(EventString[i]) in [48..57] do
    Dec(i);
  Result := Length(EventString) - i;
end;


end.
