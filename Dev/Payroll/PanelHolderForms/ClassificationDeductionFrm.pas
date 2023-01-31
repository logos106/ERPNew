unit ClassificationDeductionFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, wwdbedit, Wwdotdot, Wwdbcomb, StdCtrls,
  wwdblook, Buttons, Wwdbigrd, Grids, Wwdbgrid, DB, MemDS, DBAccess,
  MyAccess,ERPdbComponents, ExtCtrls, DNMPanel,BusObjAwards,BusObjBase, frmBase,
  Menus;

type
  TfrmClassificationDeductions = class(TfrmBaseGUI)
    DNMPanel1: TDNMPanel;
    dsClassDeductions: TDataSource;
    qryDeductions: TERPQuery;
    qryDeductionsDescription: TWideStringField;
    qryDeductionsGlobalRef: TWideStringField;
    qryDeductionsDeductionID: TAutoIncField;
    qryDeductionsTaxExempt: TWideStringField;
    qryDeductionsUnionFees: TWideStringField;
    qryDeductionsEditedFlag: TWideStringField;
    qryDeductionsActive: TWideStringField;
    qryDeductionsDisplayIn: TWideStringField;
    qryDeductionsAmount: TFloatField;
    qryDeductionsBasedOnID: TIntegerField;
    qryDeductionsCalcBy: TWideStringField;
    qryBasedOn: TERPQuery;
    grdDeductions: TwwDBGrid;
    grdDeductionsIButton: TwwIButton;
    cboDeduction: TwwDBLookupCombo;
    cboDeductCalcBy: TwwDBComboBox;
    cboBasedOnDeduct: TwwDBLookupCombo;
    edAmount: TwwDBEdit;
    procedure grdDeductionsIButtonClick(Sender: TObject);
  private
    fSubSubAward:TAward;
    procedure SetSubSubAward(Const Value :TAward);
  public
    property SubSubAward:TAward read fSubSubAward write SetSubSubAward ;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    procedure HandleClassificationDeductErrors;
  end;


implementation

uses
  CommonLib,BusObjConst;

procedure TfrmClassificationDeductions.SetSubSubAward(Const Value :TAward);
begin
  fSubSubAward := Value;
end;
{$R *.dfm}

 procedure TfrmClassificationDeductions.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
  begin
  inherited ;
  if Eventtype = BusobjEventVal_HandleIncompleteRecord then begin
      HandleClassificationDeductErrors;
  end;
end;

procedure TfrmClassificationDeductions.HandleClassificationDeductErrors;
var
  FatalStatusItem: TResultStatusItem;
begin
  FatalStatusItem :=  SubSubAward.AwardClassifications.ClassificationAllowances.ResultStatus.GetLastFatalStatusItem;
  if Assigned(FatalStatusItem) then begin
    case FatalStatusItem.Code of
      BOR_ClassificationDeduction_Err_NoDeduction  : begin
                                                       grdDeductions.SetActiveField('DeductionLookup');
                                                       SetControlFocus(cboDeduction);
                                                       exit;
                                                     end;
      BOR_ClassificationDeduction_Err_NoAmount     : begin
                                                       grdDeductions.SetActiveField('Amount');
                                                       SetControlFocus(edAmount);
                                                       exit;
                                                     end;
      BOR_ClassificationDeduction_Err_NoBasedOn    : begin
                                                     grdDeductions.SetActiveField('BasedOnLookup');
                                                     SetControlFocus(cboBasedOnDeduct);
                                                     exit;
                                                     end;
    end;
  end;
end;

procedure TfrmClassificationDeductions.grdDeductionsIButtonClick(
  Sender: TObject);
begin
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      SubSubAward.AwardClassifications.ClassificationDeductions.Delete;
    finally
    end;
  end;
end;

initialization
RegisterClassOnce(TfrmClassificationDeductions);
end.
