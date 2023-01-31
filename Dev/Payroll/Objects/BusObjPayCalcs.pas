unit BusObjPayCalcs;

interface
uses
  BusObjBase,Classes,Dialogs;

type
   TPayCalcs = class(TMSBusObj)
   private
   public
     procedure RecalcAll  ; virtual;
   end;

type
    TPayCalcsUK = class(TPayCalcs)
      procedure RecalcAll; override;
    end;
    TPayCalcsAUS = class(TPayCalcs)
      procedure RecalcAll; override;
    end;

implementation
uses
  BusObjPaybase,CommonLib,SysUtils;

procedure TPayCalcs.RecalcAll; begin end;

procedure TPayCalcsAUS.RecalcAll;
begin
  try
    tpaybase(Self.Owner).RecalcInProgress := True;
    tpaybase(Self.Owner).PaysPayRates.Recalc;
   // tpaybase(Self.Owner).PayDeductions.Recalc;
   // tpaybase(Self.Owner).Pension.CalcContributions;    { TODO -oRobin : super }
    tpaybase(Self.Owner).Deductions := tpaybase(Self.Owner).PayDeductions.TotalDeductions;  //load property
    //.....

    tpaybase(Self.Owner).Gross := tpaybase(Self.Owner).Wages + tpaybase(Self.Owner).Deductions; //TO DO  Add Commissions etc to wages to get gross

    if not tpaybase(Self.Owner).ManualTax then tpaybase(Self.Owner).Tax := tpaybase(Self.Owner).Taxation.CalcTax;
    tpaybase(Self.Owner).PayBenefits.CalcContributions;

    tpaybase(Self.Owner).Net := tpaybase(Self.Owner).Gross - tpaybase(Self.Owner).Tax - tpaybase(Self.Owner).EmployeeNICsClass1 - tpaybase(Self.Owner).EmployeeNICsOther - tpaybase(Self.Owner).Deductions;

    //round all to 2 dec places
    tpaybase(Self.Owner).Gross := RoundCurrency(tpaybase(Self.Owner).Gross);
    tpaybase(Self.Owner).Tax   := RoundCurrency(tpaybase(Self.Owner).Tax);
    tpaybase(Self.Owner).Net   := RoundCurrency(tpaybase(Self.Owner).Net);
    tpaybase(Self.Owner).RecalcInProgress := False;
  except
    on e: Exception do begin
      raise Exception.Create(e.message);
    end;
  end;
end;


procedure TPayCalcsUK.RecalcAll;
begin
  try
    tpaybase(Self.Owner).RecalcInProgress := True;
    tpaybase(Self.Owner).PaysPayRates.Recalc;
//    tpaybase(Self.Owner).PayDeductions.Recalc;
 //   tpaybase(Self.Owner).Pension.  UKBenefits.Recalc;
    tpaybase(Self.Owner).Deductions := tpaybase(Self.Owner).PayDeductions.TotalDeductions;  //load property
    //.....

    tpaybase(Self.Owner).Gross := tpaybase(Self.Owner).Wages + tpaybase(Self.Owner).Deductions; //TO DO  Add Commissions etc to wages to get gross

    if not tpaybase(Self.Owner).ManualTax then tpaybase(Self.Owner).Tax := tpaybase(Self.Owner).Taxation.CalcTax;
    tpaybase(Self.Owner).PayBenefits.CalcContributions;         
    tpaybase(Self.Owner).EmployeeNICsClass1 := tpaybase(Self.Owner).EmployeeNICsTotal ;//+ tpaybase(Self.Owner).UKBenefits.TotalEmployeeNICsExtraClass1;
    //TO DO Decision keep extra class1 entirely seperate(manual) or add amounts to wage and put thru formulas

    tpaybase(Self.Owner).Net := tpaybase(Self.Owner).Gross - tpaybase(Self.Owner).Tax - tpaybase(Self.Owner).EmployeeNICsClass1 - tpaybase(Self.Owner).EmployeeNICsOther - tpaybase(Self.Owner).Deductions;

    //round all to 2 dec places
    tpaybase(Self.Owner).Gross := RoundCurrency(tpaybase(Self.Owner).Gross);
    tpaybase(Self.Owner).Tax   := RoundCurrency(tpaybase(Self.Owner).Tax);
    tpaybase(Self.Owner).Net   := RoundCurrency(tpaybase(Self.Owner).Net);
    tpaybase(Self.Owner).RecalcInProgress := False;

  except
    on e: Exception do begin
      raise Exception.Create(e.message);
    end;
  end;
end;

initialization
RegisterClass(TPayCalcs);
end.
