unit _EventType;

interface


type
  TEventType = (
    etWorkStart,
    etWorkEnd,
    etConversationStart,
    etConversationEnd,
    etSwitchStart,

    etSwitchPickDomain,
    etSwitchPickOperator,
    etSwitchSuccessDomain,
    etSwitchSuccessOperator,
    etSwitchInvalidDomain,

    etSwitchInvalidOperator,
    etSwitchOperatorSelf,
    etSwitchOperatorAbsent,
    etSwitchOperatorBussy,
    etSwitchInvalid,

    etResearchStart,
    etResearchEnd,
    etResearchAbandon,
    etMiniBreakStart,
    etIdleStart,
    etNil);


function GetEventType(aEventLabel: string): TEventType;
function GetEventTypeID(EventType: TEventType): integer;


implementation

uses
  System.SysUtils, System.StrUtils;


type
  TEventRecord = record
    ID: byte;
    EventLabel: string;
  end;

const
  Events : array[TEventType] of TEventRecord = (
    (ID: 11; EventLabel: 'po�etak rada'),
    (ID: 12; EventLabel: 'prekid rada'),
    (ID: 21; EventLabel: 'u�ao u razgovor sa strankom'),
    (ID: 22; EventLabel: 'prekinuo razgovor sa #'),
    (ID: 31; EventLabel: 'u�ao u prespajanje stranke -'),

    (ID: 32; EventLabel: 'prespajanje - podru�je'),
    (ID: 33; EventLabel: 'prespajanje za'),
    (ID: 34; EventLabel: 'uspje�no prespojeno'),
    (ID: 35; EventLabel: 'prespojeno na'),
    (ID: 41; EventLabel: 'prespajanje - podru�je - ne postoji'),

    (ID: 42; EventLabel: 'prespajanje za - ne postoji'),
    (ID: 43; EventLabel: 'probao prespojiti sam sebi, a ne ide'),
    (ID: 44; EventLabel: 'probao prespojiti suradniku koji trenutno ne radi'),
    (ID: 45; EventLabel: 'suradnika ve� netko �eka - nije prespojeno'),
    (ID: 46; EventLabel: 'neispravan poku�aj prespajanja'),

    (ID: 51; EventLabel: 'stavio stranku na �ekanje -'),
    (ID: 52; EventLabel: 'vratio stranku sa �ekanja -'),
    (ID: 53; EventLabel: 'stranka oti�la sa �ekanja - prekinula -'),
    (ID: 97; EventLabel: 'u�ao u pauzu izme�u razgovora'),
    (ID: 98; EventLabel: 'u�ao u �ekanje stranke'),
    (ID: 00; EventLabel: 'nil')
  );


function GetExceptionalEventType(aEventLabel: string): TEventType;
begin
  if LeftStr(aEventLabel, Length (Events[etSwitchPickDomain].EventLabel)) = Events[etSwitchPickDomain].EventLabel then
    Result := etSwitchInvalidDomain
  else
    if LeftStr(aEventLabel, Length (Events[etSwitchPickOperator].EventLabel)) = Events[etSwitchPickOperator].EventLabel then
      Result := etSwitchInvalidOperator
    else
      raise Exception.Create('Unknown event: ''' + aEventLabel + '''');
end;


function GetEventType(aEventLabel: string): TEventType;
var
  i: TEventType;
begin
  aEventLabel := Trim(AnsiLowerCase(aEventLabel)).Replace(#32#32,#32);
  i := Low(TEventType);
  while i < High(TEventType) do
    begin
      if aEventLabel = Events[i].EventLabel then
        begin
          Result := i;
          Exit;
        end;
      Inc(i);
    end;
  Result := GetExceptionalEventType(aEventLabel);
end;


function GetEventTypeID(EventType: TEventType): integer;
begin
  Result := Events[EventType].ID;
end;

end.
