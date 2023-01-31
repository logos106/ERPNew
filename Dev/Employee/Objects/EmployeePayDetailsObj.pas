unit EmployeePayDetailsObj;

interface

uses
  Classes, SysUtils, Graphics, Controls, MyAccess;

type
  TEmployeePayDetailsObj = class(TObject)
  private
    fsEmpName: string;
    fsPay: string;
    fsPayPeriod: string;
    fsPayDate: TDate;
    fsLastPaid: TDate;
    fsEmployementBasis: string;
    fsTotalCommission: double;
    fsWages: double;
    fsDeductions: double;
    fsAllowances: double;
    fsSundries: double;
    fsSuperannuation: double;
    fsGross: double;
    //   fsTax: double;
    fsNet: double;
    fsAward: string;
    fsActive: string;
    fiEmployeeID: integer;
    fsUseAward: string;
    fdCommissionRate: double;
    fsCommissionOnPaid: string;
    fsCommissionOnValue: string;
    fsCommissionLastPaid: TDate;
    fsCommissionOnGross: double;
    fdTaxScaleID: double;
    {More fields to be added on a needs basis}
    //INTERNAL VARS FOR CALCULATION PURPOSES
    // sSalePaid: String;
    dTmpCommission: double;
    dTmpAllowances: double;
    // dSuperAmount:double;
    dSuperCalcOn: double;
    dTmpSuper: double;
    dTmpDeductions: double;
    sCommissionPaid: string;
    dtSaleDate: TDate;
    class procedure Instance;
  public
    property EmpName: string read fsEmpName;
    property PayPeriod: string read fsPayPeriod;
    property Pay: string read fsPay;
    property PayDate: TDate read fsPayDate;
    property LastPaid: TDate read fsLastPaid;
    property EmployementBasis: string read fsEmployementBasis;
    property TotalCommission: double read fsTotalCommission;
    property Wages: double read fsWages;
    property Deductions: double read fsDeductions;
    property AllowancesNonAward: double read fsAllowances;
    property Sundries: double read fsSundries;
    property Superannuation: double read fsSuperannuation;
    property Gross: double read fsGross;
    //   property Tax: double read fsTax;
    property Net: double read fsNet;
    property Award: string read fsAward;
    property Active: string read fsActive;
    property EmployeeID: integer read fiEmployeeID;
    property UseAward: string read fsUseAward;
    property CommissionRate: double read fdCommissionRate;
    property CommissionOnPaid: string read fsCommissionOnPaid;
    property CommissionOnValue: string read fsCommissionOnValue;
    property CommissionLastPaid: TDate read fsCommissionLastPaid;
    property TaxScaleID: double read fdTaxScaleID;
    property CommissionOnGross: double read fsCommissionOnGross;
    {More fields to be added on a needs basis}

    procedure PopulateMe(iEmployeeID: integer);
  end;

var
  EmployeePay: TEmployeePayDetailsObj;

implementation

uses
   DB, Dialogs, CommonDbLib;

procedure TEmployeePayDetailsObj.PopulateMe(iEmployeeID: integer);
var
  qryEmployee: TMyQuery;
  qryPayDetails: TMyQuery;
  qryCommission: TMyQuery;
  qrySuper: TMyQuery;
  qryWages: TMyQuery;
  qryAllowances: TMyQuery;
  qryDeductions: TMyQuery;
  i: integer;
  dAmount: currency;

  procedure FindCommissionDetails;
  var
    sSQL: string;
  begin
    with qryCommission do begin
      sSQL := 'select s.EmployeeID,s.SaleID, L.SaleID,L.TotalLineAmount,L.LineCost,s.SaleDate,' +
        ' s.Paid,s.CommissionPaid from tblsales s Inner join  tblsaleslines L using(SaleID)' + ' where s.EmployeeID = :xEmployeeID';
      Sql.Add(sSQL);
      Params.ParamByName('xEmployeeID').AsInteger := iEmployeeID;
      Open;
    end;
  end;

  procedure FindEmployeeDetails;
  begin
    with qryEmployee do begin
      Sql.Add('SELECT e.EmployeeName, e.Active,e.Super,e.Gross,e.Tax,e.Net,e.LastPaid,' +
        'e.PayPeriod,e.Wages,e.Deductions,e.Allowances,e.Sundries,e.UseAward, ' +
        'e.Commission,e.CommissionOnPaid,e.CommissionOnValue,e.TaxScaleID,e.CommissionLastPaid ' +
        'FROM tblemployees e WHERE EmployeeID = :xEmployeeID');
      Params.ParamByName('xEmployeeID').AsInteger := iEmployeeID;
      Open;
    end;
  end;

  procedure FindPayDetails;
  begin
    with qryPayDetails do begin
      Sql.Add('SELECT PayDate,Pay,EmployeeID FROM tblPays WHERE EmployeeID = :xEmployeeID');
      Params.ParamByName('xEmployeeID').AsInteger := iEmployeeID;
      Open;
    end;
  end;

  procedure FindSuperDetails;
  begin
    with qrySuper do begin
      Sql.Add('SELECT EmployeeID, Amount,CalcBy FROM tblsuperannuation WHERE EmployeeID = :xEmployeeID');
      Params.ParamByName('xEmployeeID').AsInteger := iEmployeeID;
      Open;
    end;
  end;

  procedure FindWages;
  begin
    with qryWages do begin
      Sql.Add('SELECT EmployeeID, Amount,Super FROM tblemployeepayrates WHERE EmployeeID = :xEmployeeID');
      Params.ParamByName('xEmployeeID').AsInteger := iEmployeeID;
      Open;
    end;
  end;

  procedure FindAllowances;
  begin
    with qryAllowances do begin
      Sql.Add('SELECT EmployeeID, Amount, CalcBy, Qty, TaxExempt FROM tblemployeeallowances WHERE EmployeeID = :xEmployeeID');
      Params.ParamByName('xEmployeeID').AsInteger := iEmployeeID;
      Open;
    end;
  end;

  procedure FindDeductions;
  begin
    with qryDeductions do begin
      Sql.Add('SELECT EmployeeID, Amount, CalcBy, Qty, TaxExempt FROM tblemployeedeductions WHERE EmployeeID = :xEmployeeID');
      Params.ParamByName('xEmployeeID').AsInteger := iEmployeeID;
      Open;
    end;
  end;
begin //--- Begin PopulateMe
  try
    qryEmployee := TMyQuery.Create(nil);
    qryEmployee.Connection := CommonDbLib.GetSharedMyDacConnection;
    FindEmployeeDetails;
    with qryEmployee do try
        fsEmpName := FieldByName('EmployeeName').AsString;
        fsActive := FieldByName('Active').AsString;
        fsLastPaid := FieldByName('LastPaid').AsDateTime;
        fsPayPeriod := FieldByName('PayPeriod').AsString;
        //   fsWages := FieldByName('Wages').AsCurrency ;
        //   fsDeductions := FieldByName('Deductions').AsCurrency;
        //   fsAllowances := FieldByName('Allowances').AsCurrency;
        //   fsSundries := FieldByName('Sundries').AsCurrency;
        //   fsSuperannuation := FieldByName('Super').AsCurrency;
        fsGross := FieldByName('Gross').AsCurrency;
        //   fsTax := FieldByName('Tax').AsCurrency;
        fsNet := FieldByName('Net').AsCurrency;
        fsUseAward := FieldByName('UseAward').AsString;
        fdCommissionRate := FieldByName('Commission').AsFloat;
        fsCommissionOnPaid := FieldByName('CommissionOnPaid').AsString;
        fsCommissionOnValue := FieldByName('CommissionOnValue').AsString;
        fsCommissionLastPaid := FieldByName('CommissionLastPaid').AsDateTime;
        fdTaxScaleID := FieldByName('TaxScaleID').AsInteger;
      finally
      end;
  except
    on e: Exception do begin
      raise Exception.Create(e.message);
    end;
  end;
  try
    qryPayDetails := TMyQuery.Create(nil);
    qryPayDetails.Connection := CommonDbLib.GetSharedMyDacConnection;
    FindPayDetails;
    with qryPayDetails do try
        if RecordCount = 1 then begin
          fsPayDate := FieldByName('PayDate').AsDateTime;
          fsPay := FieldByName('Pay').AsString;
        end;
      finally
      end;
  except
    on e: Exception do begin
      raise Exception.Create(e.message);
    end;
  end;

  try
    qryWages := TMyQuery.Create(nil);
    qryWages.Connection := CommonDbLib.GetSharedMyDacConnection;
    FindWages;
    with qryWages do try
        if RecordCount = 1 then begin
          //  fsPayDate := FieldByName('PayDate').AsDateTime;
          //  fsPay := FieldByName('Pay').AsString;
        end;
      finally
      end;
  except
    on e: Exception do begin
      raise Exception.Create(e.message);
    end;
  end;

  try
    qrySuper := TMyQuery.Create(nil);
    qrySuper.Connection := CommonDbLib.GetSharedMyDacConnection;
    FindSuperDetails;
    //   with qrySuper do try
    //   If RecordCount = 1 Then Begin
    //     dSuperAmount := FieldByName('Amount').AsFloat;
    //     sSuperCalcBy := FieldByName('CalcBy').AsString;
    //    end;
  except
    on e: Exception do begin
      raise Exception.Create(e.message);
    end;
  end;

  try
    qryCommission := TMyQuery.Create(nil);
    qryCommission.Connection := CommonDbLib.GetSharedMyDacConnection;
    FindCommissionDetails;
    with qryCommission do try
        sCommissionPaid := FieldByName('CommissionPaid').AsString;
        dtSaleDate := FieldByName('SaleDate').AsDateTime;
      finally
      end;
  except
    on e: Exception do begin
      raise Exception.Create(e.message);
    end;
  end;

  try
    qryAllowances := TMyQuery.Create(nil);
    qryAllowances.Connection := CommonDbLib.GetSharedMyDacConnection;
    FindAllowances;
    with qryAllowances do try
        //  fsCommissionOnPaid :=  FieldByName('CommissionOnPaid').AsString;
      finally
      end;
  except
    on e: Exception do begin
      raise Exception.Create(e.message);
    end;
  end;

  try
    qryDeductions := TMyQuery.Create(nil);
    qryDeductions.Connection := CommonDbLib.GetSharedMyDacConnection;
    FindDeductions;
    with qryDeductions do try
        //  fsCommissionOnPaid :=  FieldByName('CommissionOnPaid').AsString;
      finally
      end;
  except
    on e: Exception do begin
      raise Exception.Create(e.message);
    end;
  end;

  try                           //CALCULATIONS
    qryCommission.First;                                        //COMMISSIONS
    dTmpCommission := 0;
    if fsCommissionLastPaid <> 0 then begin
      for i := 1 to qryCommission.RecordCount do begin
        if fsCommissionOnPaid = 'T' then begin
          if (qryCommission.FieldByName('Paid').AsString = 'T') and (qryCommission.FieldByName('CommissionPaid').AsString = 'F') then
          begin
            if fsCommissionOnValue = 'TOTALSALE' then begin
              dTmpCommission := dTmpCommission + qryCommission.FieldByName('TotalLineAmount').AsFloat;
            end else begin
              dTmpCommission := dTmpCommission + (qryCommission.FieldByName('TotalLineAmount').AsFloat -
                qryCommission.FieldByName('LineCost').AsFloat);
            end;
          end;
        end else begin
          // TO DO process commission using paid on invoice
        end;
        qryCommission.Next;
      end;
      fsCommissionOnGross := dtmpCommission;
      fsTotalCommission := dtmpCommission * qryEmployee.FieldByName('Commission').AsFloat / 100;
    end;

    //SUPER & WAGES
    fsWages      := 0;
    dSuperCalcOn := 0;
    qryWages.First;
    for i := 1 to qryWages.RecordCount do begin
      if qryWages.FieldByName('Super').AsString = 'T' then begin
        dSuperCalcOn := dSuperCalcOn + qryWages.FieldByName('Amount').AsFloat;
      end;
      fsWages := fsWages + qryWages.FieldByName('Amount').AsFloat;
      qryWages.Next;
    end;
    dSuperCalcOn := dSuperCalcOn {+ fsTotalCommission + fsAllowances - fsDeductions};
    // should change this so that only pay super on allowances etc that are marked
    dTmpSuper := 0;
    qrySuper.First;
    for i := 1 to qrySuper.RecordCount do begin
      if qrySuper.FieldByName('CalcBy').AsString = '%' then begin
        dTmpSuper := dTmpSuper + qrySuper.FieldByName('Amount').AsFloat * dSuperCalcOn / 100;
      end else begin
        dTmpSuper := dTmpSuper + dSuperCalcOn;
      end;
    end;
    fsSuperannuation := dTmpSuper;

    qryDeductions.First;                                        //DEDUCTIONS
    dTmpDeductions := 0;
    for i := 1 to qryDeductions.RecordCount do begin
      if qryDeductions.FieldByName('CalcBy').AsString = '%' then begin
        dAmount := fsWages * qryDeductions.FieldByName('Amount').AsCurrency / 100;
      end else begin
        dAmount := qryDeductions.FieldByName('Amount').AsCurrency;
      end;
      dTmpDeductions := dTmpDeductions + (dAmount * qryDeductions.FieldByName('Qty').AsFloat);
      qryDeductions.Next;
    end;
    fsDeductions := dTmpDeductions;


    qryAllowances.First;                                        //ALLOWANCES
    dTmpAllowances := 0;
    for i := 1 to qryAllowances.RecordCount do begin
      if qryAllowances.FieldByName('CalcBy').AsString = '%' then begin
        dAmount := fsWages * qryAllowances.FieldByName('Amount').AsCurrency / 100;
      end else begin
        dAmount := qryAllowances.FieldByName('Amount').AsCurrency;
      end;
      dTmpAllowances := dTmpAllowances + (dAmount * qryAllowances.FieldByName('Qty').AsFloat);
      qryAllowances.Next;
    end;
    fsAllowances := dTmpAllowances;

  finally
    if Assigned(qryCommission) then begin
      FreeandNil(qryCommission);
    end;
    if Assigned(qryEmployee) then begin
      FreeandNil(qryEmployee);
    end;
    if Assigned(qryPayDetails) then begin
      FreeandNil(qryPayDetails);
    end;
    if Assigned(qrySuper) then begin
      FreeandNil(qrySuper);
    end;
    if Assigned(qryWages) then begin
      FreeandNil(qryWages);
    end;
    if Assigned(qryAllowances) then begin
      FreeandNil(qryAllowances);
    end;
    if Assigned(qryDeductions) then begin
      FreeandNil(qryDeductions);
    end;
  end;
end;

class procedure TEmployeePayDetailsObj.Instance;
begin
  if EmployeePay = nil then begin
    EmployeePay := TEmployeePayDetailsObj.Create;
  end;
end;

initialization
  TEmployeePayDetailsObj.Instance;

finalization
  if EmployeePay <> nil then begin
    FreeandNil(EmployeePay);
  end;
end.
