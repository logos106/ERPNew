unit PaymentsLibGUI;
 { GUI Payment library functions. }

{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 30/09/05  1.00.00 IJB  Initial version, created new funtions to remove GUI
                        stuff from TransLockManagementObj.

}

interface

procedure ShowDepositedListForm(const PaymentID: integer; const TranType: string='');
procedure ShowReconciledListForm(const ID: integer; const TranType: string);


implementation

uses
  TransLockManagementObj, BaseClassFuncs, BaseListingForm, TypInfo, MyAccess,ERPdbComponents,
  Forms, SysUtils;


procedure ShowDepositedListForm(const PaymentID: integer; const TranType: string);
var
  PaymentsManagement: TLockManagement;
  DepositedListForm: TBaseListingGUI;
begin
  DepositedListForm := GetBaseListingByClassName('TDepositedListGUI', false);
  PaymentsManagement := TLockManagement.Create;
  try
{    TERPQuery(DepositedListForm.FindComponent('qryMainSub')).SQL.Text :=
      PaymentsManagement.GetDepositedListSQL(PaymentID,TranType);}
    TERPQuery(DepositedListForm.FindComponent('qryMain')).SQL.Text :=
      PaymentsManagement.GetDepositedListSQL(PaymentID,TranType);
  finally
    FreeAndNil(PaymentsManagement);
  end;
  {TypInfo.SetPropValue(DepositedListForm, 'UseMainSub', true);}
  DepositedListForm.FormStyle := fsMdiChild;
  DepositedListForm.BringToFront;
end;

procedure ShowReconciledListForm(const ID: integer; const TranType: string);
var
  PaymentsManagement: TLockManagement;
  ReconciledListForm: TBaseListingGUI;
begin
  ReconciledListForm := GetBaseListingByClassName('TTransRecListGUI', false);
  PaymentsManagement := TLockManagement.Create;
  try
    ReconciledListForm.qryMain.SQL.Text :=
      PaymentsManagement.GetReconciledListSQL(ID, TranType);
    ReconciledListForm.RefreshOrignalSQL;
  finally
    FreeAndNil(PaymentsManagement);
  end;
  ReconciledListForm.FormStyle := fsMdiChild;
  ReconciledListForm.BringToFront;
end;

end.


