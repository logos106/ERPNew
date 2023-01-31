unit PayBankingFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DNMPanel,BusObjPaybase, Buttons, Wwdbigrd,
  Grids, Wwdbgrid, wwdblook, StdCtrls, Mask, wwdbedit, Wwdotdot, Wwdbcomb,
  DB, MemDS, DBAccess, MyAccess,ERPdbComponents, BusObjBase, frmPayFormsBase, Menus,
  ProgressDialog, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog;

type
  TfrmPayBanking = Class(TfmPayFormsBase)
    DNMPanel1: TDNMPanel;
    Bevel1: TBevel;
    DSPayPaySplits: TDataSource;
    qryBankCodes: TERPQuery;
    cboSplitType: TwwDBComboBox;
    cboSplitBank: TwwDBLookupCombo;
    cboPaySplit: TwwDBComboBox;
    grdBanking: TwwDBGrid;
    grdBankingIButton: TwwIButton;
    edBranch: TwwDBEdit;
    edBsb: TwwDBEdit;
    edAccountName: TwwDBEdit;
    edAccountNo: TwwDBEdit;
    edAmount: TwwDBEdit;
    procedure grdBankingIButtonClick(Sender: TObject);
    procedure SetSubPay(Const Value :Tpaybase );
    procedure qryBankCodesBeforeOpen(DataSet: TDataSet);
  private
    fSubPay:Tpaybase;
    procedure HandlePayBankingErrors;
  Protected
    Procedure InitForDefaultOptionsGrid;Override;
  public
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    property SubPay:Tpaybase  read fSubPay write SetSubPay ;

  end;

implementation

{$R *.dfm}

uses
  BusObjConst,CommonLib, AppEnvironment;

procedure TfrmPayBanking.SetSubPay(Const Value :Tpaybase);
begin
  fSubPay := Value;
end;

procedure TfrmPayBanking.HandlePayBankingErrors ;
var
  FatalStatusItem: TResultStatusItem;
begin
  if not Assigned(SubPay) then exit;
  FatalStatusItem := SubPay.PayPaysplits.ResultStatus.GetLastFatalStatusItem;
  if Assigned(FatalStatusItem) then begin
    SetControlFocus(grdBanking);
    case FatalStatusItem.Code of
      BOR_PaySplits_Err_NoSplitType      : begin
                                             SetControlFocus(cboSplitType);
                                           end;
      BOR_PaySplits_Err_NoSplit          : begin
                                             grdBanking.SetActiveField('Split');
                                           end;
      BOR_PaySplits_Err_NoBranch         : begin
                                             grdBanking.SetActiveField('Branch');
                                           end;
      BOR_PaySplits_Err_NoBsb            : begin
                                             grdBanking.SetActiveField('Bsb');
                                           end;
      BOR_PaySplits_Err_NoAccountNo      : begin
                                             grdBanking.SetActiveField('AccountNo');
                                           end;
      BOR_PaySplits_Err_NoAmount         : begin
                                             grdBanking.SetActiveField('Amount');
                                           end;
      BOR_PaySplits_Err_NoAccountName    : begin
                                             grdBanking.SetActiveField('AccountName');
                                           end;
      BOR_PaySplits_Err_NoBankID         : begin
                                             grdBanking.SetActiveField('Bank');
                                           end;
      BOR_PaySplits_Err_RemainderWithOneRec : begin
                                                grdBanking.SetActiveField('Type');
                                              end;
    end;
  end;
end;

procedure TfrmPayBanking.InitForDefaultOptionsGrid;
begin
  inherited;
  IncludeForDefaultOptions(grdBanking);
end;

procedure TfrmPayBanking.qryBankCodesBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  TERPQuery(Dataset).Params.ParamByName('XRegionID').AsInteger := AppEnv.RegionalOptions.ID;
end;

procedure TfrmPayBanking.grdBankingIButtonClick(Sender: TObject);
begin
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      if not Assigned(SubPay) then exit;
      SubPay.PayPaysplits.Delete;
    finally
    end;
  end;
end;

procedure TfrmPayBanking.DoBusinessObjectEvent( const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited ;
  if Value = BusobjEventVal_FailedBankingValidateData then begin
    HandlePayBankingErrors;
  end;

end;

initialization
RegisterClassOnce(TfrmPayBanking);
end.
