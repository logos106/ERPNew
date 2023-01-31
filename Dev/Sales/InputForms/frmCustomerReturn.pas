unit frmCustomerReturn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmRefund, ProgressDialog, ImgList, DB, Menus, AdvMenus, DNMAction, ActnList, DataState, DBAccess, MyAccess, ERPdbComponents, SelectionDialog, AppEvnts, MemDS, ExtCtrls, Buttons, Wwdbigrd,
  Grids, Wwdbgrid, ERPDbLookupCombo, Shader, wwdbedit, StdCtrls, wwdblook, wwdbdatetimepicker, DBCtrls, DNMSpeedButton, Mask, DNMPanel, BusobjCash,
  wwcheckbox, Wwdotdot, Wwdbcomb;

type
  TfmCustomerReturn = class(TRefundGUI)
    DNMSpeedButton1: TDNMSpeedButton;
    tblMasterIsCustomerReturn: TWideStringField;
    lblConverted: TLabel;
    pnlDeleted: TDNMPanel;
    chkDeleted: TwwCheckBox;
    tblDetailsMemoLine: TWideMemoField;
    cbStatus: TwwDBComboBox;
    tblDetailsReturnStatus: TWideStringField;
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tblMasterAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    CustomerReturn : TCustomerReturn;
  Protected
    procedure NewTransBusObjinstance;override;
    function TransStatustype:String ;override;
    function GetReportTypeID: integer; override;
  public
  end;


implementation

uses CommonLib, FormFactory, CommonFormLib, tcconst, busobjOrders;

{$R *.dfm}
{ TfmCustomerReturn }

procedure TfmCustomerReturn.DNMSpeedButton1Click(Sender: TObject);
var
  RefundID:Integer;
begin
  inherited;
  DisableForm;
  try
    if not CustomerReturn.Save then Exit;
    CommitAndNotify;
    BeginTransaction;

    if CustomerReturn.count       = 0 then exit;
    if CustomerReturn.lines.count = 0 then exit;

    if CustomerReturn.converted then begin
        if MessageDlgXP_Vista('A Refund is already created for this Customer Return.' +chr(13)+chr(13)+'Do You Wish To Create Another Refund?' , mtConfirmation , [mbyes,mbno] , 0) = mrno then Exit;
    end else
        if MessageDlgXP_Vista('Do You Wish To Create a Refund for this Customer Return?' , mtConfirmation , [mbyes,mbno] , 0) = mrno then Exit;

    RefundID:= CustomerReturn.ConvertTorefund;
    if RefundID <> 0 then begin
      OpenERPForm('TRefundGUI' , RefundID);
      NewAuditTrialentry('Refund Created');
    end else if CustomerReturn.ObjInstanceToClone.ResultStatus.getLastFatalStatusItem<> nil then
      MessageDlgXP_Vista('Refund Creation Failed.' + chr(13) +CustomerReturn.ObjInstanceToClone.ResultStatus.getLastFatalStatusItem.Message , mtWarning, [mbok] , 0)
    else MessageDlgXP_Vista('refund Creation Failed.' , mtWarning, [mbok] , 0);
    CustomerReturn.Dirty := False;
    Self.Close;
  finally
    EnableForm;
    CustomerReturn.ResultStatus.Clear;
  end;

end;

procedure TfmCustomerReturn.FormCreate(Sender: TObject);
begin
  AllowCustomiseGrid := True;
  inherited;
  cbStatus.Items.CommaText:= RALineStatusCommaText;
  cbStatus.Items.Add('');
end;

procedure TfmCustomerReturn.FormShow(Sender: TObject);
begin
  inherited;
  grdTransactions.RemoveField(tblDetailsPQA.fieldname);
  GuiPrefs.DbGridElement[grdTransactions].HideField(tblDetailsPQA.fieldname);
end;

function TfmCustomerReturn.GetReportTypeID: integer;
begin
  REsult := 125;
end;

procedure TfmCustomerReturn.NewTransBusObjinstance;
begin
  Freeandnil(CustomerReturn);
  CustomerReturn := TCustomerReturn.Create(Self);
  CustomerReturn.Name:= 'CustomerReturn';
  REfund := CustomerReturn;
  inherited;
end;

procedure TfmCustomerReturn.tblMasterAfterOpen(DataSet: TDataSet);
begin
  inherited;
  lblConverted.Visible := tblMaster.FieldByName('Converted').AsBoolean;
end;

function TfmCustomerReturn.TransStatustype: String;
begin
  REsult:= SimpleTypes_CustomerReturnStatus;
end;

initialization
  RegisterClassOnce(TfmCustomerReturn);

  with FormFact do begin
    RegisterMe(TfmCustomerReturn, 'TCustomerReturnListGUI_*=SaleID');
    RegisterMe(TfmCustomerReturn, 'TRefundSalesListGUI_*_Customer Return=RefundID');
  end;

end.

