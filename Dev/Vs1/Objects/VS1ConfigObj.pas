unit VS1ConfigObj;

interface

uses
  JsonDbPrefsConfigObj, MyAccess, DB;

type
  TVS1Config =  class(TJsonDbPefConfig)
  Private
    Function GetUseRegioncurrency         : Boolean;
    Procedure SetUseRegioncurrency        (Const Value: Boolean);
    function getDefaultCurrency: String;
    procedure setDefaultCurrency(const Value: String);
  Protected
  Public
    constructor Create; override;
    Property UseRegioncurrency: Boolean   read getUseRegioncurrency   Write SetUseRegioncurrency;
    Property DefaultCurrency  :String     read getDefaultCurrency     write setDefaultCurrency;
    procedure Save(connection: TMyConnection); Override;
  Published
  end;
implementation

constructor TVS1Config.Create;
begin
  inherited;
end;

function TVS1Config.getDefaultCurrency    : String ; begin result := S['DefaultCurrency']  ;end;
Function TVS1Config.GetUseRegioncurrency  : Boolean; begin result := B['UseRegioncurrency'];end;

procedure TVS1Config.Save(connection: TMyConnection);
begin
  inherited Save(Connection);
end;

procedure TVS1Config.setDefaultCurrency   (const Value: String ); begin S['DefaultCurrency']   := Value ; end;
Procedure TVS1Config.SetUseRegioncurrency (Const Value: Boolean); begin B['UseRegioncurrency'] := Value ; end;

end.
