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
    'poèetak rada',
    'prekid rada',
    'ušao u razgovor sa strankom',
    'prekinuo razgovor sa #',
    'ušao u prespajanje stranke -',
    'prespajanje - podruèje',
    'prespajanje - podruèje #',
    'prespajanje za',
    'prespajanje za #',
    'uspješno prespojeno',
    'prespojeno na',
    'probao prespojiti sam sebi, a ne ide',
    'probao prespojiti suradniku koji trenutno ne radi',
    'suradnika veæ netko èeka - nije prespojeno',
    'neispravan pokušaj prespajanja',
    'stavio stranku na èekanje -',
    'vratio stranku sa èekanja -',
    'stranka otišla sa èekanja - prekinula -',
    'ušao u pauzu izmeðu razgovora',
    'ušao u èekanje stranke',
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
    'prespajanje - podruèje a',
    'prespajanje - podruèje c',
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
