unit BusObjPayLine;

interface

uses
 BusObjBase;

type

  TPayLine = class(TMSBusObj)
   private
    function GetLineType: string;
    function GetPayId: integer;
    function GetAmount: double;
    procedure SetLineType(const Value: string);
    procedure SetPayId(const Value: integer);
    procedure SetAmount(const Value: double);
    function GetValByType(aTypeName: string): double;
    procedure SetValByType(aTypeName: string; const Value: double);
   protected
    function DoAfterInsert(Sender :TDatasetBusObj): Boolean; override;
   public
     class function GetIDField: string; override;
     class function GetBusObjectTablename: string; Override;
     property ValByType[aTypeName: string]: double read GetValByType write SetValByType;
   published
     property PayID: integer read GetPayId write SetPayId;
     property LineType: string read GetLineType write SetLineType;
     property Amount: double read GetAmount write SetAmount;
   end;

const
  FedTaxType = 'FedTax';
  StateTaxType = 'StateTax';
  SocialSecurityTaxType = 'SocialSecurityTax';
  MedicareTaxType = 'MedicareTax';

implementation

uses
  BusObjPayBase, DB;

{ TPayLine }

function TPayLine.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
  if Assigned(Owner) and (Owner is Tpaybase) then
    self.PayID := Tpaybase(Owner).PayID;
end;

class function TPayLine.GetBusObjectTablename: string;
begin
  result := 'tblpayline';
end;

class function TPayLine.GetIDField: string;
begin
  result := 'PayLineID';
end;

function TPayLine.GetLineType: string;
begin
  result := GetStringField('LineType');
end;

function TPayLine.GetPayId: integer;
begin
  result := GetIntegerField('PayId');
end;

function TPayLine.GetValByType(aTypeName: string): double;
begin
  if Dataset.Locate('LineType', aTypeName, [loCaseInsensitive]) then
    result := Amount
  else
    result := 0;
end;

function TPayLine.GetAmount: double;
begin
  result := GetFloatField('Amount');
end;

procedure TPayLine.SetLineType(const Value: string);
begin
  SetStringField('LineType', Value);
end;

procedure TPayLine.SetPayId(const Value: integer);
begin
  SetIntegerField('PayId', Value);
end;

procedure TPayLine.SetValByType(aTypeName: string; const Value: double);
begin
  if Dataset.Locate('LineType', aTypeName, [loCaseInsensitive]) then
    Amount := Value
  else
  begin
    self.New;
    LineType := aTypeName;
    Amount := Value;
    PostDB;
  end;
end;

procedure TPayLine.SetAmount(const Value: double);
begin
  SetFloatField('Amount', Value);
end;

end.
