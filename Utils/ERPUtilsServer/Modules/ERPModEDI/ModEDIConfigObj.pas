unit ModEDIConfigObj;

interface

uses
  JsonDbPrefsConfigObj, JsonObject;


type

  TModEDIConfig = class(TJsonDbPefConfig)
  private
    function GetActive: boolean;
    function GetTriggers: TJSONArray;
    procedure SetActive(const Value: boolean);
    function GetERPPass: string;
    function GetERPUser: string;
    procedure SetERPPass(const Value: string);
    procedure SetERPUSer(const Value: string);
  public
    property Active: boolean read GetActive write SetActive;
    property ERPUser: string read GetERPUser write SetERPUSer;
    property ERPPass: string read GetERPPass write SetERPPass;
    property Triggers: TJSONArray read GetTriggers;
  end;



implementation

{ TEDIConfig }

function TModEDIConfig.GetActive: boolean;
begin
  result := B['Active'];
end;

function TModEDIConfig.GetERPPass: string;
begin
  result := S['ERPPass'];
end;

function TModEDIConfig.GetERPUser: string;
begin
  result := S['ERPUser'];
end;

function TModEDIConfig.GetTriggers: TJSONArray;
begin
  result := A['Triggers'];
end;

procedure TModEDIConfig.SetActive(const Value: boolean);
begin
  B['Active'] := Value;
end;

procedure TModEDIConfig.SetERPPass(const Value: string);
begin
  S['ERPPass'] := Value;
end;

procedure TModEDIConfig.SetERPUSer(const Value: string);
begin
  S['ERPUser'] := Value;
end;

end.
