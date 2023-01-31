unit AwardDetailsFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs,Forms,BusObjAwards, ExtCtrls, DNMPanel, StdCtrls,
  wwcheckbox, wwdbedit, DBCtrls, wwdblook, Mask, DB, MemDS, DBAccess,
  MyAccess,ERPdbComponents, frmBase, Menus, BaseInputForm, ProgressDialog, ImgList, AdvMenus, DataState, SelectionDialog, AppEvnts;

type
  TfrmAwardDetails = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DSAwards: TDataSource;
    qryDepartments: TERPQuery;
    DNMPanel2: TDNMPanel;
    AwardName: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    cboDepartment: TwwDBLookupCombo;
    PayPeriod: TDBComboBox;
    Label3: TLabel;
    DNMPanel3: TDNMPanel;
    Label12: TLabel;
    edSickDaysThreshold: TwwDBEdit;
    Label7: TLabel;
    edMealBreakHrs: TwwDBEdit;
    Label8: TLabel;
    edMealBreakThreshold: TwwDBEdit;
    DNMPanel4: TDNMPanel;
    DNMPanel7: TDNMPanel;
    SuperType: TDBComboBox;
    Label13: TLabel;
    Label14: TLabel;
    SuperValue: TwwDBEdit;
    chkDefaultSuperThreshold: TwwCheckBox;
    txtSuperThresholdAmount: TwwDBEdit;
    chkSuperOnLeaveLoading: TwwCheckBox;
    Label17: TLabel;
    Label4: TLabel;
    QryAreaCodes: TERPQuery;
    QryAreaCodesAreaCode: TWideStringField;
    QryAreaCodesAreaName: TWideStringField;
    Label5: TLabel;
    cboAreaCode: TwwDBLookupCombo;
    procedure AwardNameExit(Sender: TObject);
    procedure SetSubAward(Const Value :TAward);
    procedure chkDefaultSuperThresholdClick(Sender: TObject);
  private
    fSubAward:TAward;
  public
    property SubAward:TAward read fSubaward write SetSubAward ;
    procedure HandleAwardDetailErrors;
  end;

implementation

uses
  BusObjConst,BusObjBase,CommonLib,AppEnvironment,tcTypes;

procedure TfrmAwardDetails.SetSubAward(Const Value :TAward);
begin
  fSubAward := Value;
end;
{$R *.dfm}


procedure TfrmAwardDetails.HandleAwardDetailErrors ;
var
  FatalStatusItem: TResultStatusItem;
begin
  try
    if not Assigned(SubAward) then exit;
    FatalStatusItem :=  SubAward.ResultStatus.GetLastFatalStatusItem;
    if Assigned(FatalStatusItem) then begin
      case FatalStatusItem.Code of
        BOR_Award_Err_NoDescription        : begin
                                               SetControlFocus(AwardName);
                                               exit;
                                             end;
        BOR_Award_Err_NoDepartment         : begin
                                               SetControlFocus(cboDepartment);
                                               exit;
                                             end;
        BOR_Award_Err_NoPayPeriod          : begin
                                               SetControlFocus(PayPeriod);
                                               exit;
                                             end;
        BOR_Award_Err_NoSickLeaveThreshold : begin
                                               SetControlFocus(edSickDaysThreshold);
                                               exit;
                                             end;
        BOR_Award_Err_NoMealBreakHrs       : begin
                                               SetControlFocus(edMealBreakHrs);
                                               exit;
                                             end;
        BOR_Award_Err_NoMealBreakThreshold : begin
                                               SetControlFocus(edMealBreakThreshold);
                                               exit;
                                             end;
        BOR_Award_Err_NoSuperType          : begin
                                               SetControlFocus(SuperType);
                                               exit;
                                             end;
        BOR_Award_Err_NoSuperValue         : begin
                                               SetControlFocus(SuperValue);
                                               exit;
                                             end;
      end;
    end;
    except
    on e: Exception do begin
      raise Exception.Create(e.message);
    end;
  end;
end;

procedure TfrmAwardDetails.AwardNameExit(Sender: TObject);
begin      
  if AwardName.Text = '0' then begin

  end;
end;

procedure TfrmAwardDetails.chkDefaultSuperThresholdClick(Sender: TObject);
begin
  if chkDefaultSuperThreshold.Checked then txtSuperThresholdAmount.Text := '$0.00';
  txtSuperThresholdAmount.Enabled := not chkDefaultSuperThreshold.Checked;     
end;

initialization
RegisterClassOnce(TfrmAwardDetails);

end.

