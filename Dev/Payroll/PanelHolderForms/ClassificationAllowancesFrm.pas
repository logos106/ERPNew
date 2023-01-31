unit ClassificationAllowancesFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DNMPanel,Mask, wwdbedit,
  Wwdotdot, Wwdbcomb, StdCtrls, wwdblook, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, DB, MemDS, DBAccess, MyAccess,ERPdbComponents,BusObjAwards,BusObjBase, frmBase, Menus;

type
  TfrmClassificationAllowances = class(TfrmBaseGUI)
    DNMPanel1: TDNMPanel;
    DSAllowances2: TDataSource;
    grdAllowances: TwwDBGrid;
    grdAllowncesIButton: TwwIButton;
    cboAllowance: TwwDBLookupCombo;
    cboAllowCalcBy: TwwDBComboBox;
    cboBasedOn: TwwDBLookupCombo;
    edAmount: TwwDBEdit;
    qryAllowances: TERPQuery;
    qryAllowancesDescription: TWideStringField;
    qryAllowancesAllowanceID: TAutoIncField;
    qryAllowancesSuperInc: TWideStringField;
    qryAllowancesTaxExempt: TWideStringField;
    qryAllowancesPayrollTaxExempt: TWideStringField;
    qryAllowancesWorkcoverExempt: TWideStringField;
    qryAllowancesDisplayIn: TWideStringField;
    qryAllowancesAmount: TFloatField;
    qryAllowancesCalcBy: TWideStringField;
    qryAllowancesBasedOnID: TIntegerField;
    qryAllowancesActive: TWideStringField;
    qryBasedOn: TERPQuery;
    procedure grdAllowncesIButtonClick(Sender: TObject);
    procedure grdAllowancesEnter(Sender: TObject);
  private
    fSubSubAward:TAward;
    procedure SetSubSubAward(Const Value :TAward);
  public
    property SubSubAward:TAward read fSubSubAward write SetSubSubAward ;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    procedure HandleClassificationAllowErrors;
  end;

implementation
uses
  CommonLib,BusObjConst;

procedure TfrmClassificationAllowances.SetSubSubAward(Const Value :TAward);
begin
  fSubSubAward := Value;
end;
{$R *.dfm}

procedure TfrmClassificationAllowances.DoBusinessObjectEvent( const Sender: TDatasetBusObj; const EventType, Value: string);
  begin
  inherited ;
  if Eventtype = BusobjEventVal_HandleIncompleteRecord then begin
    HandleClassificationAllowErrors;
  end;
end;

procedure TfrmClassificationAllowances.HandleClassificationAllowErrors;
var
  FatalStatusItem: TResultStatusItem;
begin
  if not Assigned(SubSubAward) then exit;
  FatalStatusItem :=  SubSubAward.AwardClassifications.ClassificationAllowances.ResultStatus.GetLastFatalStatusItem;
  if Assigned(FatalStatusItem) then begin
    case FatalStatusItem.Code of
      BOR_ClassificationAllowance_Err_NoAllowance  : begin
                                                       grdAllowances.SetActiveField('lookupAllowance');
                                                       SetControlFocus(cboAllowance);
                                                       exit;
                                                     end;
      BOR_ClassificationAllowance_Err_NoAmount     : begin
                                                       grdAllowances.SetActiveField('Amount');
                                                       SetControlFocus(edAmount);
                                                       exit;
                                                     end;
      BOR_ClassificationAllowance_Err_NoBasedOn    : begin
                                                     grdAllowances.SetActiveField('lookupBasedOn');
                                                     SetControlFocus(cboBasedOn);
                                                     exit;
                                                     end;
    end;
  end;
end;

procedure TfrmClassificationAllowances.grdAllowncesIButtonClick(
  Sender: TObject);
begin
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      SubSubAward.AwardClassifications.ClassificationAllowances.Delete;
    finally
    end;
  end;
end;

procedure TfrmClassificationAllowances.grdAllowancesEnter(Sender: TObject);
begin
  if SubSubAward.AwardClassifications.Dataset.RecordCount = 0 then begin
    CommonLib.MessageDlgXP_Vista('First create a Classification .', mtWarning, [mbOK], 0);
    SubSubAward.SendEvent(BusobjEventVal_HandleResetFocus,BusObjEvent_Change );
  end;
end;

initialization
RegisterClassOnce(TfrmClassificationAllowances);
end.
