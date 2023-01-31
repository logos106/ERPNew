unit ClassificationExtraPayratesFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, wwdblook, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, DB, MemDS, DBAccess, MyAccess,ERPdbComponents, ExtCtrls, DNMPanel,
  Mask, wwdbedit,BusObjAwards,BusObjBase, wwcheckbox, frmBase, Menus;

type
  TfrmClassificationExtraPayRates = class(TfrmBaseGUI)
    DNMPanel1: TDNMPanel;
    DSExtraRates: TDataSource;
    qryPayRateType: TERPQuery;
    grdExtraPayRates: TwwDBGrid;
    btnClassificationExtraPayrates: TwwIButton;
    ExtraPayRate: TwwDBLookupCombo;
    cboTypeID: TwwDBLookupCombo;
    edAmount: TwwDBEdit;
    edWorked: TwwDBEdit;
    qryExtraPayRates: TERPQuery;
    chkSuper: TwwCheckBox;
    procedure btnClassificationExtraPayratesClick(Sender: TObject);
  private
    fSubSubAward:TAward;
    procedure SetSubSubAward(Const Value :TAward);
  public
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);override;
    procedure HandleClassificationExtraErrors;
    property SubSubAward:TAward read fSubSubAward write SetSubSubAward ;
  end;


implementation
uses
  CommonLib,BusObjConst;

procedure TfrmClassificationExtraPayRates.SetSubSubAward(Const Value :TAward);
begin
  fSubSubAward := Value;
end;
{$R *.dfm}

procedure TfrmClassificationExtraPayRates.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited ;
  if Eventtype = BusobjEventVal_HandleIncompleteRecord then begin
    HandleClassificationExtraErrors;
  end;
end;


procedure TfrmClassificationExtraPayRates.HandleClassificationExtraErrors;
var
  FatalStatusItem: TResultStatusItem;
begin
  FatalStatusItem :=  SubSubAward.AwardClassifications.ClassificationExtraPayrates.ResultStatus.GetLastFatalStatusItem;
  if Assigned(FatalStatusItem) then begin
    case FatalStatusItem.Code of
      BOR_ClassificationExtraPayRates_Err_NoPayRate : begin
                                                        grdExtraPayRates.SetActiveField('ExtraPayRate');
                                                        SetControlFocus(ExtraPayRate);
                                                        exit;
                                                      end;
      BOR_ClassificationExtraPayRates_Err_NoAmount  : begin
                                                        grdExtraPayRates.SetActiveField('Amount');
                                                        SetControlFocus(edAmount);
                                                        exit;
                                                      end;
      BOR_ClassificationExtraPayRates_Err_NoWorked :  begin
                                                        grdExtraPayRates.SetActiveField('Worked');
                                                        SetControlFocus(edWorked);
                                                        exit;
                                                      end;
      BOR_ClassificationExtraPayRates_Err_NoType  :  begin
                                                        grdExtraPayRates.SetActiveField('PayRateType');
                                                        SetControlFocus(cboTypeID);
                                                        exit;
                                                      end;
    end;
  end;
end;

procedure TfrmClassificationExtraPayRates.btnClassificationExtraPayratesClick(
  Sender: TObject);
begin
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      SubSubAward.AwardClassifications.ClassificationExtraPayrates.Delete;
    finally
    end;
  end;
end;

initialization
RegisterClassOnce(TfrmClassificationExtraPayRates);
end.
