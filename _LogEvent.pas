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
      InfoIsNull: boolean;
      Info: byte;
      function ExtractInfo(const EventString: string; const InfoStringLength: integer): byte;
      function GetInfoStringLength(const EventString: string): byte;
    public
      constructor Create(const EventString: string);
      function GetInsertSQL(const LogFileID, DailyIndex: integer): string;
  end;


implementation

uses
  System.SysUtils,
  itSystem;


constructor TLogEvent.Create(const EventString: string);
var
  InfoStringLength: integer;
begin
  inherited Create;
  Time := StrToInt(Copy(EventString, 1, TimeStringLength));
  InfoStringLength := GetInfoStringLength(EventString);
  InfoIsNull := (InfoStringLength = 0);
  Info := ExtractInfo(EventString, InfoStringLength);
  EventType := GetEventType(Copy(EventString,
                                 1 + TimeStringLength,
                                 Length(EventString) - TimeStringLength - InfoStringLength));
end;


function TLogEvent.ExtractInfo(const EventString: string; const InfoStringLength: integer): byte;
var
  ResultTemp: word;
begin
  Result := 0;
  if InfoStringLength = 0 then
    Exit;
  ResultTemp := StrToInt(Copy(EventString,
                              Length(EventString) - InfoStringLength + 1,
                              InfoStringLength));
  Result := ResultTemp Mod 100;
end;


function TLogEvent.GetInsertSQL(const LogFileID, DailyIndex: integer): string;
begin
  Result := 'INSERT INTO Event(LogFileID, DailyIndex, Time, EventTypeID, Info) Values (' +
    IntToStr(LogFileID) + ',' +
    IntToStr(DailyIndex) + ',' +
    IntToStr(Time) + ',' +
    IntToStr(Ord(GetEventTypeID(EventType))) + ',' +
    IfStr(InfoIsNull, 'null', IntToStr(Info)) + ');';
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
