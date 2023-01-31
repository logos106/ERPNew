unit BusObjPayCommissionsAUS;

interface
{$I ERP.inc}

uses
  BusObjPayCommissionsBASE,Classes,BusObjBase;
type
   TPayCommissionsAUS = class(Tpayscommission)
   private
     fdTotalIncludedInSuper:double;

     procedure RecalcCallbackProc(const Sender: TBusObj; var Abort: Boolean);
   public
     Constructor  Create(AOwner: TComponent);                             override;
     Destructor   Destroy;                                                override;
     property TotalIncludedInSuper:double read fdTotalIncludedInSuper write fdTotalIncludedInSuper;
     procedure ReCalc;

     function CalcTax:double; override;
   end;
implementation

uses
  SysUtils,BusObjPaybase,PayCommon, MyAccess,ERPdbComponents, CommonLib,
  DbSharedObjectsObj, CommonDbLib, AppEnvironment, PayTaxableTotalObj;

constructor TPayCommissionsAUS.Create(AOwner: TComponent);
begin
   inherited Create(AOwner) ;
end;

destructor TPayCommissionsAUS.Destroy;
begin
   inherited;
end;

function TPayCommissionsAUS.CalcTax: double;
var
  dTotalTax,
//  dCommissionPerPeriod,
  dCommissionPerWeek,
  dTaxableGrossNoCommission,
//  dNoCommissionTax: double;
  dNoCommissionTaxWeek: double;
  qry: TERPQuery;
  taRec: TTaxAmount;
begin
  result := 0;
//  dTaxableGrossNoCommission := Tpaybase(Self.Owner).PayTotals.GrossTaxable - Tpaybase(Self.Owner).PayCommissions.TotalBeforeTax;
  dTaxableGrossNoCommission := divzer(Tpaybase(Self.Owner).PayTotals.GrossTaxable - Tpaybase(Self.Owner).PayCommissions.TotalBeforeTax,
    GetPayPeriodWeeks(Tpaybase(Self.Owner).EmployeePaySettings.Payperiod));

  //  dNoCommissionTax := GetTaxComponent(Tpaybase(Self.Owner).EmployeeDetails.Taxscaleid,
//    dTaxableGrossNoCommission, Tpaybase(Self.Owner).EmployeePaySettings.Payperiod,Tpaybase(Self.Owner).IsPayVerify);
(*
  dNoCommissionTaxWeek := GetTaxComponent(Tpaybase(Self.Owner).EmployeeDetails.Taxscaleid,
    dTaxableGrossNoCommission, 'Weekly',Tpaybase(Self.Owner).IsPayVerify);
*)
  dCommissionPerWeek := DivZer(Self.TotalBeforeTax,GetPayPeriodWeeks(Trim(GetCommissionPeriod(PeriodID))));
  dCommissionPerWeek := System.Round(dCommissionPerWeek);
  qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Add('select * from tblPayTaxScaleConfig');
    qry.SQL.Add('inner join tblpaytaxconfig on tblpaytaxconfig.ID = tblPayTaxScaleConfig.PayTaxConfigId and tblpaytaxconfig.RegionId = '+
	  IntToStr(AppEnv.RegionalOptions.Id)+' and tblpaytaxconfig.Active = "T"');
    qry.SQL.Add('where tblPayTaxScaleConfig.TaxScaleId > 0');
    qry.SQL.Add('and tblPayTaxScaleConfig.EmployeeId = ' + IntToStr(Tpaybase(Self.Owner).EmployeeId));
    qry.Open;
	  while not qry.EOF do begin
//      dTotalTax := GetTaxComponent(qry.FieldByName('TaxSCaleId').AsInteger,
//        dTaxableGrossNoCommission + dCommissionPerWeek,Tpaybase(Self.Owner).EmployeePaySettings.Payperiod,
//        Tpaybase(Self.Owner).IsPayVerify);

(*
      if qry.FieldByName('PrimaryTax').AsBoolean then begin
        { only apply extra tax to primary tax }
        if dNoCommissionTaxWeek > 0 then begin
          { Extra Tax }
          if FindInSet(Trim(Tpaybase(Self.Owner).EmployeeDetails.ExtraTaxOptions), '$') then begin
            dNoCommissionTaxWeek := dNoCommissionTaxWeek + Tpaybase(Self.Owner).EmployeeDetails.ExtraTax;
          end
          else if FindInSet(Trim(Tpaybase(Self.Owner).EmployeeDetails.ExtraTaxOptions), '%') then begin
            dNoCommissionTaxWeek := dNoCommissionTaxWeek + (dNoCommissionTaxWeek * Tpaybase(Self.Owner).EmployeeDetails.ExtraTax / 100);
          end
          else if FindInSet(Trim(Tpaybase(Self.Owner).EmployeeDetails.ExtraTaxOptions), 'Fixed') then begin
            dNoCommissionTaxWeek := Tpaybase(Self.Owner).EmployeeDetails.ExtraTax;
          end;
        end;
      end;
*)
      dTotalTax := GetTaxComponent(qry.FieldByName('TaxSCaleId').AsInteger,
        dTaxableGrossNoCommission + dCommissionPerWeek,'Weekly',
        Tpaybase(Self.Owner).IsPayVerify,
        qry.FieldByName('AllowanceQty').AsInteger * qry.FieldByName('AllowanceAmount').AsFloat);
//      dTotalTax := dTotalTax - dNoCommissionTax;

      dNoCommissionTaxWeek := 0;
      taRec := Tpaybase(Self.Owner).PayTotals.TaxableTotals.TaxList.ItemByTaxConfigId(qry.FieldByName('PayTaxConfigId').AsInteger);
      if Assigned(taRec) then
        dNoCommissionTaxWeek := DivZer(taRec.TaxAmount, GetPayPeriodWeeks(Tpaybase(Self.Owner).EmployeePaySettings.Payperiod));


      dTotalTax := dTotalTax - dNoCommissionTaxWeek;
      dTotalTax := dTotalTax * GetPayPeriodWeeks(Trim(GetCommissionPeriod(PeriodID)));
      if dTotalTax < 0 then dTotalTax := 0;
//      taRec := Tpaybase(Self.Owner).PayTotals.TaxableTotals.TaxList.ItemByTaxConfigId(qry.FieldByName('PayTaxConfigId').AsInteger);
      if not Assigned(taRec) then
        Tpaybase(Self.Owner).PayTotals.TaxableTotals.TaxList.AddItem(qry.FieldByName('PayTaxConfigId').AsInteger,dTotalTax,qry.FieldByName('TaxType').AsString)
      else
        taRec.TaxAmount := taRec.TaxAmount + dTotalTax;
      result := result + dTotalTax;
      qry.Next;
    end;

  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;


procedure TPayCommissionsAUS.ReCalc;
begin
  fdTotalIncludedInSuper := 0.00;
  Self.IterateRecords(RecalcCallbackProc,False);
end;

procedure TPayCommissionsAUS.RecalcCallbackProc(const Sender: TBusObj; var Abort: Boolean);
begin
  if Self.Superinc then fdTotalIncludedInSuper := fdTotalIncludedInSuper + Self.Gross;
end;

initialization
RegisterClassOnce(TpaycommissionsAUS);
end.
