unit CustomFieldListFormExtender;

interface

uses
  BaseInputFormExtender, classes, ComCtrls, frmCustomFieldValue;

type
  TCustomFieldListFormExtender = class(TBaseInputFormExtender)
    Private
       SavedOnChangeHandler: TNotifyEvent;
       SavedSaveOnClickHandler: TNotifyEvent;
       SavedNewOnClickHandler: TNotifyEvent;
       PageControl: TPageControl;
       CustomFieldValueForm :TfmCustomFieldValue;

       procedure DoPageControlOnChange(Sender: TObject);
       procedure DoSaveOnClick(Sender: TObject);
       procedure DoNewOnClick(Sender: TObject);
       Procedure InitForm;
       function SaveCustomFieldValue:Boolean;
    Protected

    Public
      constructor Create(AOwner: TComponent); override;
  end;

implementation

uses DNMPanel, DNMSpeedButton, CommonLib, Busobjcustomfields, ClassExtenderListObj, sysutils, frmCAROutComeReviewOptions;

{ TCustomFieldListFormExtender }

constructor TCustomFieldListFormExtender.Create(AOwner: TComponent);
var
  Button : TDNMSpeedButton;
begin
  inherited;
  If not Assigned(Form) then Exit;
  PageControl := TPageControl(FindChildComponent(Form,'TabCtl20'));
  if not Assigned(PageControl) then
    PageControl := TPageControl(FindChildComponent(Form,'pgeControl'));
  if not Assigned(PageControl) then
    PageControl := TPageControl(FindChildComponent(Form,'pageControl'));

  if Assigned(PageControl) then begin
    SavedOnChangeHandler := PageControl.OnChange;
    PageControl.OnChange := DoPageControlOnChange;
  end;

  Button := TDNMSpeedButton(FindChildComponent(Form,'cmdOk'));
  if not Assigned(Button) then
    Button := TDNMSpeedButton(FindChildComponent(Form,'btnCompleted'));
  if Assigned(Button) then begin
    SavedSaveOnClickHandler := Button.OnClick;
    Button.OnClick := DoSaveOnClick;
  end;

  Button := TDNMSpeedButton(FindChildComponent(Form,'cmdNew'));
  if Assigned(Button) then begin
    SavedNewOnClickHandler := Button.OnClick;
    Button.OnClick := DoNewOnClick;
  end;
end;

procedure TCustomFieldListFormExtender.DoNewOnClick(Sender: TObject);
begin
  if not SaveCustomFieldValue then
    exit;

  if Assigned(SavedNewOnClickHandler) then
    SavedNewOnClickHandler(Sender);

  initForm;

end;

procedure TCustomFieldListFormExtender.DoPageControlOnChange(Sender: TObject);
begin
  { call the saved event first }
  if Assigned(TNotifyEvent(SavedOnChangeHandler)) then
    TNotifyEvent(SavedOnChangeHandler)(Sender);

  if SameText(PageControl.ActivePage.Name,'Custom_Fields') then begin
    initform;

  end;
end;

procedure TCustomFieldListFormExtender.DoSaveOnClick(Sender: TObject);
begin
  if not SaveCustomFieldValue then
    exit;

  if Assigned(SavedSaveOnClickHandler) then
    SavedSaveOnClickHandler(Sender);

end;

procedure TCustomFieldListFormExtender.InitForm;
begin

  if assigned(CustomFieldValueForm) then
    CustomFieldValueForm.OnIdChange(Form.KeyId)
  else if Form.classnameis('TfrmCustomer')
    then CustomFieldValueForm := TfmCustomFieldValue.Instance(ltcustomer   ,MyConnection , Form.KeyId , TDNMPanel(Form.Findcomponent('pnlcustomfieldList')), Form.CustomFieldExtenderListtype)
  else if Form.classnameis('TfrmParts')
    then CustomFieldValueForm := TfmCustomFieldValue.Instance(ltProducts   ,MyConnection , Form.KeyId , TDNMPanel(Form.Findcomponent('pnlcustomfieldList')), Form.CustomFieldExtenderListtype)
  else if Form.classnameis('TfrmContact') then
    CustomFieldValueForm := TfmCustomFieldValue.Instance(ltcontact, MyConnection , Form.KeyId , TDNMPanel(Form.Findcomponent('pnlcustomfieldList')), Form.CustomFieldExtenderListtype)
  else if Form.classnameis('TJobGUI') then
    CustomFieldValueForm := TfmCustomFieldValue.Instance(ltcustomer   ,MyConnection , Form.KeyId , TDNMPanel(Form.Findcomponent('pnlcustomfieldList')), Form.CustomFieldExtenderListtype)
  else if Form.classnameis('TfmSupplier') then
    CustomFieldValueForm := TfmCustomFieldValue.Instance(ltsupplier   ,MyConnection , Form.KeyId , TDNMPanel(Form.Findcomponent('pnlcustomfieldList')), Form.CustomFieldExtenderListtype)
  else if Form.classnameis('TfmEquip')     then
    CustomFieldValueForm := TfmCustomFieldValue.Instance(ltEquipment  ,MyConnection , Form.KeyId , TDNMPanel(Form.Findcomponent('pnlcustomfieldList')), Form.CustomFieldExtenderListtype)
  else if Form.classnameis('TfmCAR')       then
    CustomFieldValueForm := TfmCAROutComeReviewOptions.Instance(ltCAR ,MyConnection , Form.KeyId , TDNMPanel(Form.Findcomponent('pnlcustomfieldList')), Form.CustomFieldExtenderListtype)
  else if Form.classnameis('TRepairsGUI')       then
    CustomFieldValueForm := TfmCustomFieldValue.Instance(ltRepair ,MyConnection , Form.KeyId , TDNMPanel(Form.Findcomponent('pnlcustomfieldList')), Form.CustomFieldExtenderListtype)
  else if Form.classnameis('TfmMarketingLead') then
    CustomFieldValueForm := TfmCustomFieldValue.Instance(ltLeads ,MyConnection , Form.KeyId , TDNMPanel(Form.Findcomponent('pnlcustomfieldList')), Form.CustomFieldExtenderListtype);

end;

function TCustomFieldListFormExtender.SaveCustomFieldValue: Boolean;
begin
  Result := True;
  if assigned(CustomFieldValueForm) then REsult := CustomFieldValueForm.Save;
end;

initialization
  RegisterClassOnce(TCustomFieldListFormExtender);
  ClassExtenderList.AddExtender('TfrmCustomer'    ,'TCustomFieldListFormExtender');
  ClassExtenderList.AddExtender('TfrmParts'       ,'TCustomFieldListFormExtender');
  ClassExtenderList.AddExtender('TfrmContact'     ,'TCustomFieldListFormExtender'); //@@@
  ClassExtenderList.AddExtender('TJobGUI'         ,'TCustomFieldListFormExtender');
  ClassExtenderList.AddExtender('TfmSupplier'    ,'TCustomFieldListFormExtender');
  ClassExtenderList.AddExtender('TfmEquip'        ,'TCustomFieldListFormExtender');
  ClassExtenderList.AddExtender('TfmCAR'          ,'TCustomFieldListFormExtender');
  ClassExtenderList.AddExtender('TRepairsGUI'     , 'TCustomFieldListFormExtender');
  ClassExtenderList.AddExtender('TfmMarketingLead', 'TCustomFieldListFormExtender');
end.

