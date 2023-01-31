unit PaySundriesFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, wwdblook, wwcheckbox, Buttons, Wwdbigrd,
  Grids, Wwdbgrid, DB, MemDS, DBAccess, MyAccess,ERPdbComponents, ExtCtrls, DNMPanel,BusObjPaybase,
  Mask, wwdbedit,BusObjBase, frmPayFormsBase, ProgressDialog, ImgList, AdvMenus,
  DataState, AppEvnts, SelectionDialog, Menus;

type
  TfrmPaySundries = Class(TfmPayFormsBase)
    DNMPanel1: TDNMPanel;
    Bevel1: TBevel;
    qryEmployeeSundries: TERPQuery;
    DSPaySundries: TDataSource;
    qrySundryDesc: TERPQuery;
    qryJobs: TERPQuery;
    qryDepartment: TERPQuery;
    grdSundries: TwwDBGrid;
    btnSundriesDelete: TwwIButton;
    chkTaxSundries: TwwCheckBox;
    cboDescription: TwwDBLookupCombo;
    AdjJob: TwwDBLookupCombo;
    cboSundryDept: TwwDBLookupCombo;
    edAmount: TwwDBEdit;
    procedure cboDescriptionCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure btnSundriesDeleteClick(Sender: TObject);
    procedure SetSubPay(Const Value :Tpaybase );
    procedure grdSundriesEnter(Sender: TObject);
  private
    fSubPay:Tpaybase;
    fInformedAlternative:Boolean;
    procedure HandlePaySundriesErrors;
  Protected
    Procedure InitForDefaultOptionsGrid;Override;
  public
    property SubPay:Tpaybase  read fSubPay write SetSubPay ;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  end;

implementation

{$R *.dfm}
uses
  CommonLib,BusObjConst;

  procedure TfrmPaySundries.SetSubPay(Const Value :Tpaybase);
begin
  fSubPay := Value;
end;

procedure TfrmPaySundries.HandlePaySundriesErrors ;
var
  FatalStatusItem: TResultStatusItem;
begin
  if not Assigned(SubPay) then exit;
  FatalStatusItem := SubPay.PaySundries.ResultStatus.GetLastFatalStatusItem;
  if Assigned(FatalStatusItem) then begin
    SetControlFocus(grdSundries);
    case FatalStatusItem.Code of
      BOR_PaySundries_Err_NoDescription  : begin
                                             grdSundries.SetActiveField('Sundry');
                                           end;
      BOR_PaySundries_Err_NoAmount       : begin
                                             grdSundries.SetActiveField('Amount');
                                           end;
      BOR_PaySundries_Err_NoDepartment   : begin
                                             grdSundries.SetActiveField('ClassName');
                                           end;
    end;
  end;
end;

procedure TfrmPaySundries.InitForDefaultOptionsGrid;
begin
  inherited;
  IncludeForDefaultOptions(grdSundries);
end;

procedure TfrmPaySundries.cboDescriptionCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
 if not qrySundryDesc.Locate('SundryDesc',cboDescription.Text,[]) then begin
  qrySundryDesc.Insert;
  qrySundryDesc.FieldByName('SundryDesc').AsString := cboDescription.Text;
  qrySundryDesc.Post;
 end;
end;

procedure TfrmPaySundries.btnSundriesDeleteClick(Sender: TObject);
begin
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      if not Assigned(SubPay) then exit;
      SubPay.PaySundries.Delete;
      SubPay.RecalcAll;
    finally
    end;
  end;  
end;

procedure TfrmPaySundries.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited ;
  if Value = BusobjEventVal_FailedSundriesValidateData then begin
    HandlePaySundriesErrors;
  end;
end;

procedure TfrmPaySundries.grdSundriesEnter(Sender: TObject);
begin
  inherited;
  if not fInformedAlternative then begin
    fInformedAlternative := True;
    CommonLib.MessageDlgXP_Vista('Any reimbursments entered here will be posted to payroll accounts.' +
       ' Alternatively use the Bill system if you want to post the expenses to non payroll accounts.', mtInformation, [mbOK], 0);
  end;
end;

initialization
RegisterClassOnce(TfrmPaySundries);
end.
