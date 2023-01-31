unit frmSalesDeliveryDetails;

interface

Uses TypesLib,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmExtrainfoPopupBase, DB, DNMSpeedButton, StdCtrls, Shader,
  ExtCtrls, DNMPanel , BusObjBase, BaseFormForm, wwdbdatetimepicker, DBCtrls,
  MemDS, DBAccess, MyAccess, ERPdbComponents, wwdblook, ImgList, Menus,
  AdvMenus, DataState, SelectionDialog, AppEvnts, ProgressDialog;

type
  TfmSalesDeliveryDetails = class(TfmExtrainfoPopupBase)
    cboPlannedDelfromTime: TDBComboBox;
    dtPlannedDelfromDt: TwwDBDateTimePicker;
    dtPlannedDelToDt: TwwDBDateTimePicker;
    cboPlannedDeltotime: TDBComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label3: TLabel;
    dtPromisedDelDt: TwwDBDateTimePicker;
    cboPromisedDeltime: TDBComboBox;
    Label4: TLabel;
    QryDelayreason: TERPQuery;
    cboDelayreson: TwwDBLookupCombo;
    Label6: TLabel;
    txtFeedBack: TDBMemo;
    Bevel4: TBevel;
    Bevel3: TBevel;
    Label5: TLabel;
    dtActualDelDt: TwwDBDateTimePicker;
    cboActualDeltime: TDBComboBox;
    Bevel5: TBevel;
    procedure cboDelayresonDblClick(Sender: TObject);
    procedure cboDelayresonNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: string; var Accept: Boolean);
    procedure cboDelayresonCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure FormShow(Sender: TObject);
    procedure chkHideClick(Sender: TObject);
  private
  Protected
  public
    class Procedure  DoExtrainfoPopup(Ownerform: TBaseForm;  busobj :TBusobj; PrintAction :TGeneralProc =nil);Override;
  end;
implementation

uses frmSimpleTypes, busobjSalesDelDetails, tcconst, CommonLib,
  timelib, AppEnvironment ;
{$R *.dfm}
{ TfmSalesDeliveryDetails }

procedure TfmSalesDeliveryDetails.cboDelayresonCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  TSalesDeliveryDetails(formObj).CauseofDelay :=QryDelayreason.fieldbyname('Name').asString;
  TSalesDeliveryDetails(formObj).CauseofDelayID :=QryDelayreason.fieldbyname('ID').asInteger;
end;

procedure TfmSalesDeliveryDetails.cboDelayresonDblClick(Sender: TObject);
begin
  inherited;
  //TfmSimpleTypes.DoSimpleTypesEdit(SimpleTypes_SalesDelDelayReason, TSalesDeliveryDetails(formObj).CauseofDelay);
  {call add new function to call as model as this form is modal. Addnew checks for the record before adding}
  TfmSimpleTypes.DoSimpleTypesAddNew(SimpleTypes_SalesDelDelayReason, TSalesDeliveryDetails(formObj).CauseofDelay);
end;

procedure TfmSalesDeliveryDetails.cboDelayresonNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('Selection NOT in list, Create New?', mtconfirmation, [mbyes, mbno], 0) = mrYes then begin
    TfmSimpleTypes.DoSimpleTypesAddNew(SimpleTypes_SalesDelDelayReason, NewValue);
    closenopendb(cboDelayreson.LookupTable);
    if cboDelayreson.LookupTable.Locate('Name', NewValue, []) then begin
           TSalesDeliveryDetails(formObj).CauseofDelay := NewValue;
           TSalesDeliveryDetails(formObj).PostDB;
           Accept:= True;
    end else begin
      Accept:= False;
    end;
  end;
end;

procedure TfmSalesDeliveryDetails.chkHideClick(Sender: TObject);
begin
  inherited;
  if Screen.ActiveControl = chkHide then begin
    Appenv.Employee.ShowDeliveryDetailsformonDeldocketprint := not(chkHide.checked);
  end;
end;

class procedure TfmSalesDeliveryDetails.DoExtrainfoPopup(Ownerform: TBaseForm;busobj: TBusobj; PrintAction :TGeneralProc =nil);
var
  form :TfmSalesDeliveryDetails;
begin
  form := TfmSalesDeliveryDetails.create(Ownerform);
  form.InitForm(Ownerform, busobj , PrintAction);
end;

procedure TfmSalesDeliveryDetails.FormShow(Sender: TObject);
begin
  inherited;
  PopulateTimecombo(cboPlannedDelfromTime);
  PopulateTimecombo(cboPlannedDeltotime);
  PopulateTimecombo(cboPromisedDeltime);
  PopulateTimecombo(cboActualDeltime);
end;


end.

