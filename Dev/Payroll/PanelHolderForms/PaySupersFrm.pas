unit PaySupersFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,BusObjPaybase, ExtCtrls, DNMPanel, StdCtrls,
  wwcheckbox, Mask, wwdbedit, Wwdotdot, Wwdbcomb, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, DB, MemDS, DBAccess, MyAccess,ERPdbComponents, wwdblook, BusObjBase,
  wwdbdatetimepicker, frmPayFormsBase, ProgressDialog, ImgList, AdvMenus,
  DataState, AppEvnts, SelectionDialog, Menus;

type
  TfrmPaySupers = Class(TfmPayFormsBase)
    DNMPanel2: TDNMPanel;
    Bevel2: TBevel;
    DSpaysbenefits: TDataSource;
    qryDepartment: TERPQuery;
    DSPaySuper: TDataSource;
    qrySuperType: TERPQuery;
    qrySuppliers: TERPQuery;
    cboSuperType: TwwDBLookupCombo;
    cboSuperFund: TwwDBLookupCombo;
    edAmount: TwwDBEdit;
    DateJoined: TwwDBDateTimePicker;
    cboDP: TwwDBComboBox;
    cboSuperDepartment: TwwDBLookupCombo;
    grdSuperannuation: TwwDBGrid;
    grdSuperannuationIButton: TwwIButton;
    Label1: TLabel;
    QryAreaCodes: TERPQuery;
    QryAreaCodesAreaCode: TWideStringField;
    QryAreaCodesAreaName: TWideStringField;
    cboAreaCode: TwwDBLookupCombo;
    procedure SetSubPay(Const Value :Tpaybase );
    procedure btnSuperDeleteClick(Sender: TObject);
    procedure grdSuperannuationIButtonClick(Sender: TObject);
  private
    fSubPay:Tpaybase;
    procedure HandleSuperErrors;
  Protected
    Procedure InitForDefaultOptionsGrid;Override;
  public
    property SubPay:Tpaybase  read fSubPay write SetSubPay ;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  end;

implementation

{$R *.dfm}
uses
  BusObjConst,CommonLib;

procedure TfrmPaySupers.SetSubPay(Const Value :Tpaybase);
begin
  fSubPay := Value;
end;

procedure TfrmPaySupers.HandleSuperErrors ;
begin
  if not Assigned(SubPay) then exit;

end;


procedure TfrmPaySupers.InitForDefaultOptionsGrid;
begin
  inherited;
  IncludeForDefaultOptions(grdSuperannuation);
end;

procedure TfrmPaySupers.btnSuperDeleteClick(Sender: TObject);
begin
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      if not Assigned(SubPay) then exit;
      SubPay.PayBenefits.Delete;
    finally
    end;
  end;
end;

procedure TfrmPaySupers.grdSuperannuationIButtonClick(Sender: TObject);
begin
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      SubPay.PayBenefits.Delete;
      SubPay.RecalcAll;
    finally
    end;
  end;
end;

procedure TfrmPaySupers.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited ;
  if Value = BusobjEventVal_FailedSuperannuationValidateData then begin
    HandleSuperErrors;
  end;
end;

initialization
RegisterClassOnce(TfrmPaySupers);
end.
