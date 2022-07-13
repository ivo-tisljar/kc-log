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
    etSwitchNoDomain,
    etSwitchPickOperator,
    etSwitchNoOperator,
    etSwitchSuccessDomain,
    etSwitchSuccessOperator,
    etSwitchOperatorSelf,
    etSwitchOperatorAbsent,
    etSwitchOperatorBussy,
    etSwitchInvalid,
    etResearchStart,
    etResearchEnd,
    etResearchAbandon,
    etMiniBreakStart,
    etIdleStart,
    etExotic01,
    etExotic02,
    etExotic03,
    etExotic04,
    etExotic05,
    etExotic06,
    etExotic07,
    etExotic08,
    etExotic09,
    etExotic10,
    etExotic11,
    etExotic12,
    etExotic13,
    etExotic14,
    etExotic15,
    etNil);

const
  EventLabel : array[TEventType] of string = (
    'po�etak rada',
    'prekid rada',
    'u�ao u razgovor sa strankom',
    'prekinuo razgovor sa #',
    'u�ao u prespajanje stranke -',
    'prespajanje - podru�je',
    'prespajanje - podru�je #',
    'prespajanje za',
    'prespajanje za #',
    'uspje�no prespojeno',
    'prespojeno na',
    'probao prespojiti sam sebi, a ne ide',
    'probao prespojiti suradniku koji trenutno ne radi',
    'suradnika ve� netko �eka - nije prespojeno',
    'neispravan poku�aj prespajanja',
    'stavio stranku na �ekanje -',
    'vratio stranku sa �ekanja -',
    'stranka oti�la sa �ekanja - prekinula -',
    'u�ao u pauzu izme�u razgovora',
    'u�ao u �ekanje stranke',
    'prespajanje za 1#',
    'prespajanje za 2#',
    'prespajanje za 3#',
    'prespajanje za 4#',
    'prespajanje za 5#',
    'prespajanje za 9#',
    'prespajanje za ##',
    'prespajanje za 1c',
    'prespajanje za 3',
    'prespajanje za 1*',
    'prespajanje za 3*',
    'prespajanje za 9*',
    'prespajanje za *',
    'prespajanje - podru�je a',
    'prespajanje - podru�je c',
    'nil'
  );


function GetEventType(aEventLabel: string): TEventType;


implementation

uses
  System.SysUtils;


function GetEventType(aEventLabel: string): TEventType;
var
  i: TEventType;
begin
  aEventLabel := Trim(AnsiLowerCase(aEventLabel)).Replace(#32#32,#32);
  Result := etNil;
  i := Low(TEventType);
  while i < High(TEventType) do
    begin
      if aEventLabel = EventLabel[i] then
        begin
          Result := i;
          Exit;
        end;
      Inc(i);
    end;
  raise Exception.Create('Unknown event: ''' + aEventLabel + '''');
end;


end.
