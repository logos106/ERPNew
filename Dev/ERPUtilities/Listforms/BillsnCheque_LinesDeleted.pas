unit BillsnCheque_LinesDeleted;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  TransLockManagementObj, tcTypes, StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,
  DAScript, MyScript, wwcheckbox;

type
  TBillsnCheque_LinesDeletedGUI = class(TBaseListingGUI)
    qryMainPurchaseOrderID: TIntegerField;
    qryMainPurchaseOrderNumber: TWideStringField;
    qryMainSupplierName: TWideStringField;
    qryMainOrderDate: TDateTimeField;
    qryMainTotalAmount: TFloatField;
    qryMainTotalAmountInc: TFloatField;
    qryMainEmployeeName: TWideStringField;
    qryMaintype: TWideStringField;
    qryMainPayment: TFloatField;
    qryMainBalance: TFloatField;
    qryMainPaid: TWideStringField;
    qryMainLockstatus: TWideStringField;
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override; 
  private
      ftLockType: TTransLockType;
      PaymentsManagement : TLockManagement;
  public
    { Public declarations }
  end;

implementation

uses FastFuncs, CommonLib;

{$R *.dfm}

procedure TBillsnCheque_LinesDeletedGUI.qryMainCalcFields(
  DataSet: TDataSet);
begin
  inherited;
      if Sysutils.SameText(Qrymaintype.asString , 'Cheque') then begin
        PaymentsManagement.IsChequeLocked(QrymainpurchaseorderID.asInteger, ftLockType);
      end else begin
        PaymentsManagement.POHasPayment_Locked(QrymainpurchaseorderID.asInteger,ftLockType);
      end;
           if ftLockType = ltNone           then qryMainLockstatus.asString := 'None'
      else if ftLockType = ltReconciled     then qryMainLockstatus.asString := 'Reconciled'
      else if ftLockType = ltOnHoldRec      then qryMainLockstatus.asString := 'On hold'
      else if ftLockType = ltPaymentApplied then qryMainLockstatus.asString := 'Payments Applied';
end;

procedure TBillsnCheque_LinesDeletedGUI.FormCreate(Sender: TObject);
begin
  inherited;
  PaymentsManagement := TLockManagement.Create;
end;

procedure TBillsnCheque_LinesDeletedGUI.FormDestroy(Sender: TObject);
begin
  inherited;
  Freeandnil(PaymentsManagement);
end;
procedure TBillsnCheque_LinesDeletedGUI.grdMainDblClick(Sender: TObject);
begin
    SubsequentID := Chr(95) + qryMain.Fields.FieldByName('Type').AsString;
  inherited;

end;

initialization
  RegisterClassOnce(TBillsnCheque_LinesDeletedGUI);

end.
