unit frmCustomFieldValue;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, ExtCtrls, Grids, Wwdbigrd, Wwdbgrid, DNMPanel, DB,
  MemDS, DBAccess, MyAccess, ERPdbComponents, wwdbdatetimepicker, StdCtrls,
  Mask, wwdbedit, Wwdotdot, Wwdbcomb , BaseInputForm, Busobjcustomfields , busobjbase, busobjconst,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, DNMSpeedButton,
  ProgressDialog;

type


  TfmCustomFieldValue = class(TBaseInputGUI)
    QryCustomfieldValues: TERPQuery;
    dsCustomfieldValues: TDataSource;
    QryCustomfieldValuesglobalref: TWideStringField;
    QryCustomfieldValuesId: TIntegerField;
    QryCustomfieldValuesMasterID: TIntegerField;
    QryCustomfieldValuesCustomFieldlistId: TIntegerField;
    QryCustomfieldValuesValue: TWideStringField;
    QryCustomfieldValuesmstimestamp: TDateTimeField;
    qryCustomFieldList: TERPQuery;
    qryCustomFieldListCFID: TIntegerField;
    qryCustomFieldListDescription: TWideStringField;
    QryCustomfieldValuescustomfield: TStringField;
    pnlMain: TDNMPanel;
    grdMain: TwwDBGrid;
    CboDropDownValues: TwwDBComboBox;
    dtpicker: TwwDBDateTimePicker;
    edtNumber: TwwDBEdit;
    DNMPanel1: TDNMPanel;
    cmdCustomLabelsOld: TDNMSpeedButton;
    procedure cmdCustomLabelsOldClick(Sender: TObject);
    procedure CboDropDownValuesCloseUp(Sender: TwwDBComboBox; Select: Boolean);
    procedure dtpickerCloseUp(Sender: TObject);
    procedure dtpickerChange(Sender: TObject);
    procedure dtpickerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure QryCustomfieldValuesBeforeInsert(DataSet: TDataSet);
  private
    fConnection: TERPConnection;
    fCustomFieldListtype: TListType;
    fiMasterID: Integer;
    CustomFieldValues :TCustomFieldValues;
    AllLinesValid:Boolean;
    Changingdate:Boolean;
    Procedure MakeCustomFieldForm(ParentPanel:TDNMPanel);
    Procedure ValidateDatacallback(const Sender: TBusObj; var Abort: Boolean);
    procedure PopulateCombo(const Sender: TBusObj; var Abort: Boolean);
    procedure ClearCustomControls;
    procedure beforeshowCustomfieldList(Sender: TObject);
    procedure SetCustomFieldListtype(const Value: TListType);
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    Procedure Makecustomcontrols;Virtual;
  public
    procedure InitThisInstance(Category :TListType;Connection:TERPConnection;MasterId:Integer;ParentPanel:TDNMPanel; fCustomFieldListtype:TListType);virtual;
    Property CustomFieldValueConnection: TERPConnection read fConnection write fConnection;
    Property CustomFieldListtype :TListType read fCustomFieldListtype Write SetCustomFieldListtype;
    Property CustomFieldValueMasterID :Integer read fiMasterID Write fiMasterId;
    Class Function  Instance(Category :TListType;Connection:TERPConnection;MasterId:Integer;ParentPanel:TDNMPanel; CustomFieldListtype:TListType):TfmCustomFieldValue;virtual;
    Function Save:Boolean;
    Procedure OnIdchange(KeyID:Integer);
  end;

implementation

uses CommonFormLib, tcConst, CommonLib, frmCustomfieldList ;



{$R *.dfm}

{ TfmCustomFieldValue }

procedure TfmCustomFieldValue.CboDropDownValuesCloseUp(Sender: TwwDBComboBox;
  Select: Boolean);
begin
  inherited;
  CustomFieldValues.Value :=CboDropDownValues.text;
  CustomFieldValues.PostDB;
end;

procedure TfmCustomFieldValue.cmdCustomLabelsOldClick(Sender: TObject);
begin
  inherited;
  if OpenERPFormModal('TfmCustomfieldList',0 , beforeshowCustomfieldList) >=0  then begin
    CustomFieldValues.PopulateAll(CustomFieldValueMasterID);
    qryCustomFieldList.Refresh;
    CustomFieldValues.Dataset.Refresh;
  end;
end;

procedure TfmCustomFieldValue.beforeshowCustomfieldList(Sender :TObject);
begin
  if not(Sender is TfmCustomfieldList) then exit;
  TfmCustomfieldList(Sender).ListType  :=CustomFieldListtype;
end;

procedure TfmCustomFieldValue.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TCustomFieldValues  then TCustomFieldValues(Sender).Dataset  := QryCustomfieldValues;
  end else if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_IDChanged)  then begin
    Makecustomcontrols;
  end else if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_BeforeIDChanged)  then begin
    ClearCustomControls;
  end;
end;

procedure TfmCustomFieldValue.dtpickerChange(Sender: TObject);
begin
  inherited;
  if Changingdate then exit;
  if CustomFieldValues.Value = FormatDateTime(FormatSettings.ShortDateformat , dtpicker.Datetime) then exit;
  Changingdate:= True;
  try
    CustomFieldValues.Value :=FormatDateTime(FormatSettings.ShortDateformat , dtpicker.Datetime);
    CustomFieldValues.PostDB;
  finally
    Changingdate:= false;
  end;
end;

procedure TfmCustomFieldValue.dtpickerClick(Sender: TObject);
var
   dt:TDatetime;
begin
  inherited;
  if Changingdate then exit;
  Changingdate:= True;
  try
    if not dtpicker.DroppedDown then begin
      if (CustomFieldValues.Value <> '') and (isDate(CustomFieldValues.Value, dt)) then begin
        dtpicker.Date := dt;
      end else begin
        dtpicker.Date := 0;//Date;
      end;
      dtpicker.DropDown;
    end;
  finally
    Changingdate:= False;
  end;
end;

procedure TfmCustomFieldValue.dtpickerCloseUp(Sender: TObject);
begin
  inherited;
  CustomFieldValues.Value :=FormatDateTime(FormatSettings.ShortDateformat , dtpicker.Datetime);
  CustomFieldValues.PostDB;
end;

procedure TfmCustomFieldValue.FormCreate(Sender: TObject);
begin
  inherited;
  Changingdate:= False;
end;

procedure TfmCustomFieldValue.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  try
    inherited;

    if Field = nil then exit;

    if (sametext(Field.fieldname , 'Value')) and
      (Sametext(customfieldValues.CustomFieldEntry.Datatype , 'ftDateTime')) and
      (Sametext(Field.asString, formatDatetime(FormatSettings.shortdateformat , 0))) then
      Afont.color := aBrush.color;
  Except
  end;
end;
Procedure TfmCustomFieldValue.InitThisInstance(Category :TListType;Connection:TERPConnection;MasterId:Integer;ParentPanel:TDNMPanel; fCustomFieldListtype:TListType);
begin
  CustomFieldValueconnection := Connection;
  CustomFieldListtype := Category;
  CustomFieldValueMasterID := MAsterId;
  MakeCustomFieldForm(ParentPanel);
  CustomFieldListtype := fCustomFieldListtype;
end;
class Function TfmCustomFieldValue.Instance(Category: TListType; Connection:TERPConnection; MasterId: Integer;ParentPanel:TDNMPanel; CustomFieldListtype:TListType):TfmCustomFieldValue;
var
  Form :TfmCustomFieldValue;
begin
  REsult := nil;
  form :=TfmCustomFieldValue.create(ParentPanel.Owner);
  if not(Assigned(Form)) then exit;
  Form.InitThisInstance(Category,Connection,MasterId,ParentPanel,CustomFieldListtype);
  Result := Form;
end;

procedure TfmCustomFieldValue.Makecustomcontrols;
var
  dt:TDatetime;
begin
  QryCustomfieldValues.DisableControls;
  try
    (*if QryCustomfieldValues.bof then exit;
    if QryCustomfieldValues.Eof then exit;*)
    if QryCustomfieldValues.recordcount =0 then exit;

    try
      SetControlfocus(grdMain);
      grdMain.setActiveField('CustomField');
      grdMain.EditControlOptions :=  grdMain.EditControlOptions - [ecoDisableCustomControls];
      grdMain.BeginUpdate;
      Try
        grdMain.ControlType.Clear;
        if   CustomFieldValues.CustomFieldEntry.ISCombo then begin
            CboDropDownValues.Items.Clear;
            CustomFieldValues.CustomFieldEntry.DropDown.IterateRecords(PopulateCombo);
            grdMain.ControlType.Add('Value;CustomEdit;CboDropDownValues;F');
        end else if   sameText(CustomFieldValues.CustomFieldEntry.Datatype , 'ftDatetime') then begin
          grdMain.ControlType.Add('Value;CustomEdit;dtpicker;F');
          if (CustomFieldValues.Value <> '') and (isDate(CustomFieldValues.Value, dt)) then
            dtpicker.Date := dt
          else dtpicker.Date := 0;//Date;
        end else if   sameText(CustomFieldValues.CustomFieldEntry.Datatype , 'ftFloat') then begin
          grdMain.ControlType.Add('Value;CustomEdit;edtNumber;F');
        end else if   sameText(CustomFieldValues.CustomFieldEntry.Datatype , 'ftBoolean') then begin
          CboDropDownValues.Items.Clear;
          CboDropDownValues.Items.Add('True');
          CboDropDownValues.Items.Add('False');
          grdMain.ControlType.Add('Value;CustomEdit;CboDropDownValues;F');
        end;
      Finally
        grdMain.EndUpdate(True);
      End;
    Except
    end;
  finally
    grdMain.SetActivefield('Value');
    QryCustomfieldValues.EnableControls;
  end;
end;

procedure TfmCustomFieldValue.MakeCustomFieldForm(ParentPanel: TDNMPanel);
begin
  closedb(QryCustomfieldValues);
  Closedb(qryCustomFieldList);
  qryCustomFieldList.connection := CustomFieldValueconnection;
  QryCustomfieldValues.connection := CustomFieldValueconnection;
       if (CustomFieldListtype = ltCustomer ) then CustomFieldValues := TCustomerCustomFieldValues.create(Self)
  else if (CustomFieldListtype = ltProducts ) then CustomFieldValues := TProductCustomFieldValues.create(Self)
  else if (CustomFieldListtype = ltSupplier ) then CustomFieldValues := TSupplierCustomFieldValues.create(Self)
  else if (CustomFieldlisttype = ltEquipment) then CustomfieldValues := TEquipmentCustomFieldValues.Create(self)
  else if (CustomFieldlisttype = ltCAR      ) then CustomfieldValues := TCAROutComeReviewOptions.Create(self)
  else if (CustomFieldListType = ltContact  ) then CustomFieldValues := TContactCustomFieldValues.Create(Self)
  else if (CustomFieldListType = ltRepair   ) then CustomFieldValues := TRepairCustomFieldValues.Create(Self)
  else if (CustomFieldListType = ltLeads    ) then CustomFieldValues := TLeadCustomfieldValues.Create(Self);



  CustomFieldValues.Connection := TMydacDataconnection.Create(CustomFieldValues);
  CustomFieldValues.Connection.Connection := CustomFieldValueconnection;
  CustomFieldValues.BusobjEvent := DoBusinessObjectEvent;

  OnIdchange(CustomFieldValueMasterID);
  pnlMain.Parent := ParentPanel;
end;

procedure TfmCustomFieldValue.OnIdchange(KeyID:Integer);
begin
  if KeyID =0 then exit;
  CustomFieldValueMasterID:= KeyID;
  CustomFieldValues.LoadSelect ('MasterId = ' +inttostr(CustomFieldValueMasterID));
  CustomFieldValues.PopulateAll(CustomFieldValueMasterID);
  OpenQueries;
end;

procedure TfmCustomFieldValue.PopulateCombo(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TCustomFieldListDropDown) then exit;
  CboDropDownValues.Items.add(TCustomFieldListDropDown(Sender).text);
end;

procedure TfmCustomFieldValue.QryCustomfieldValuesBeforeInsert(
  DataSet: TDataSet);
begin
  inherited;
  if not(CustomFieldValues.PopulatingAll) then
    Abort;
end;

procedure TfmCustomFieldValue.ClearCustomControls;
begin
  inherited;
   grdMain.BeginUpdate;
    Try
      grdMain.ControlType.Clear;
      dtpicker.Datasource := nil;
      edtNumber.Datasource:= nil;
      dtpicker.Datafield  := '';
      edtNumber.Datafield := '';
    Finally
      grdMain.EndUpdate(True);
    End;
end;

function TfmCustomFieldValue.Save: Boolean;
begin
  Result := False;
  CustomFieldValues.PostDB;
  AllLinesValid := True;
  CustomFieldValues.Iteraterecords(ValidateDatacallback);
  if not(AllLinesValid) then exit;
  REsult := True;
end;

procedure TfmCustomFieldValue.SetCustomFieldListtype(const Value: TListType);
begin
  fCustomFieldListtype := Value;
end;

procedure TfmCustomFieldValue.ValidateDatacallback(const Sender: TBusObj;var Abort: Boolean);
begin
  if not (Sender.Validatedata) then begin
    AllLinesValid := False;
    Abort := True;
  end;
end;

end.

