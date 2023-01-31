unit frmPriceUpdateSelection;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 11/02/09  1.00.01 RM   Almost direct copy and paste of frmMarketingContactSelectionRange
                        except just used to create extra filters with custom fields. Still uses
                        frameSQLSelectBuilder but only a few of its features
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm,  DBAccess, MyAccess,ERPdbComponents, SelectionDialog,
  AppEvnts, DB,  StdCtrls, Mask, DBCtrls, wwcheckbox, Buttons, DNMSpeedButton,
  ExtCtrls, DNMPanel, ActnList, XMLDataObj, frameSQLSelectBuilder, MemDS,
  wwdbedit, Wwdbgrid, Menus, AdvMenus, Shader, BusobjRangeSelection, BusObjBase,
  Grids, Wwdbigrd, DataState, ImgList, wwdbdatetimepicker, ProgressDialog ;

type
  TfmPriceUpdateSelection = class(TBaseInputGUI)
    pnlBottom: TDNMPanel;
    Label50: TLabel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    pnlTop: TDNMPanel;
    alMain: TActionList;
    actMainSave: TAction;
    actMainNew: TAction;
    actMainCancel: TAction;
    actDeleteListItem: TAction;
    actAddListItem: TAction;
    QueryBuilder: TfrSQLSelectBuilder;
    qryMaster: TERPQuery;
    dsMaster: TDataSource;
    dlgMemo: TwwMemoDialog;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryDetails: TERPQuery;
    dsDetails: TDataSource;
    qryMasterRangeSelectionId: TIntegerField;
    qryMasterRangeDescription: TWideStringField;
    qryMasterXMLData: TWideMemoField;
    qryMasterActive: TWideStringField;
    qryMasterGlobalRef: TWideStringField;
    qryMastermsTimeStamp: TDateTimeField;
    qryDetailsMessageID: TIntegerField;
    qryDetailsGlobalRef: TWideStringField;
    qryDetailsRangeSelectionID: TIntegerField;
    qryDetailsMessage: TWideMemoField;
    qryDetailsActive: TWideStringField;
    qryDetailsmsTimeStamp: TDateTimeField;
    qryCustomFields: TERPQuery;
    qryCustomFieldsCFProduct1: TWideStringField;
    qryCustomFieldsCFProduct2: TWideStringField;
    qryCustomFieldsCFProduct3: TWideStringField;
    qryCustomFieldsCFProduct4: TWideStringField;
    qryCustomFieldsCFProduct5: TWideStringField;
    qryCustomFieldsCFProduct6: TWideStringField;
    qryCustomFieldsCFProduct7: TWideStringField;
    qryCustomFieldsCFProduct8: TWideStringField;
    qryCustomFieldsCFProduct9: TWideStringField;
    qryCustomFieldsCFProduct10: TWideStringField;
    qryCustomFieldsCFProduct11: TWideStringField;
    qryCustomFieldsCFProduct12: TWideStringField;
    qryCustomFieldsCFProduct13: TWideStringField;
    qryCustomFieldsCFProduct14: TWideStringField;
    qryCustomFieldsCFProduct15: TWideStringField;
    qryCustomFieldsCFProduct16: TWideStringField;
    qryCustomFieldsCFProduct17: TWideStringField;
    qryCustomFieldsCFProduct18: TWideStringField;
    qryCustomFieldsCFLabel1: TWideStringField;
    qryCustomFieldsCFLabel2: TWideStringField;
    qryCustomFieldsCFLabel3: TWideStringField;
    qryCustomFieldsCFLabel4: TWideStringField;
    qryCustomFieldsCFLabel5: TWideStringField;
    qryCustomFieldsCFLabel6: TWideStringField;
    qryCustomFieldsCFLabel7: TWideStringField;
    qryCustomFieldsCFLabel8: TWideStringField;
    qryCustomFieldsCFLabel9: TWideStringField;
    qryCustomFieldsCFLabel10: TWideStringField;
    qryCustomFieldsCFLabel11: TWideStringField;
    qryCustomFieldsCFLabel12: TWideStringField;
    qryCustomFieldsCFLabel13: TWideStringField;
    qryCustomFieldsCFLabel14: TWideStringField;
    qryCustomFieldsCFLabel15: TWideStringField;
    qryCustomFieldsCFLabel16: TWideStringField;
    qryCustomFieldsCFlabel17: TWideStringField;
    qryCustomFieldsCFLabel18: TWideStringField;
    dtpValue: TwwDBDateTimePicker;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actMainSaveExecute(Sender: TObject);
    procedure actMainCancelExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure QueryBuilderbtnAddListItemClick(Sender: TObject);
    procedure qryMasterBeforePost(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure QueryBuildercboFieldCloseUp(Sender: TObject);
    procedure dtpValueCloseUp(Sender: TObject);
  private
    procedure SetDefaults;
    procedure LoadFieldsToCombo;
    function ConvertToCustomSQL(sSQL:string):String;
    function IsDateField(sFieldName:String):Boolean;
  public
    { Public declarations }
    XMLData: TXMLData;
  end;

type
  TCustomFieldRec = class(TObject)
  private
  public
    sFieldLabel: string;
    sFieldName: string;
    bIsDate:Boolean;
  end;  

  function DoBuildPriceUpdateSelection(var FilterStr: string): boolean;

var
  CustomFieldRecList: TList;

implementation

{$R *.dfm}

uses
  FormFactory, CommonLib, BusObjConst, FastFuncs,StrUtils,tcConst ;

function DoBuildPriceUpdateSelection(var FilterStr: string): boolean;
var
  form: TfmPriceUpdateSelection;
begin
  form:= TfmPriceUpdateSelection.Create(nil);
  try
    form.QueryBuilder.lstLines.Items.Text:= FilterStr;
    result:= form.ShowModal = mrOk;
    if result then
      FilterStr:= form.ConvertToCustomSQL(form.QueryBuilder.XMLData.Node['SQLSelect'].Attribute['SQL'].AsString);
  finally
    form.Free;
  end;
end;

function TfmPriceUpdateSelection.ConvertToCustomSQL(sSQL:string):string;
var
  i,iPos,iLength:integer;
  tmpStr,tmpPartialStr,sFinalStr:string;  
begin
  tmpStr := sSQL;
    //replace field labels with actual field names
  for i := 0 to CustomFieldRecList.Count - 1 do begin
    tmpStr := AnsiReplaceText(tmpStr,TCustomFieldRec(CustomFieldRecList[i]).sFieldLabel,TCustomFieldRec(CustomFieldRecList[i]).sFieldName);
  end;
  // insert 'AND' between fields
  iLength := char_length(tmpStr);
  tmpPartialStr := tmpStr;
  sFinalStr := '';
  iPos := Pos(#13#10,tmpStr);
  While iPos > 0 do begin
    sFinalStr     := sFinalStr + Copy(tmpPartialStr,0,iPos - 1);
    tmpPartialStr := Copy(tmpPartialStr,iPos,iLength - iPos + 1);
    tmpPartialStr[ pos( #13, tmpPartialStr ) ] := ' ';  //take out first linefeed and caraige return
    tmpPartialStr[ pos( #10, tmpPartialStr ) ] := ' ';

    iPos := Pos(#13#10,tmpPartialStr);
  end;          
  Result := sFinalStr +  tmpPartialStr;
end;


procedure TfmPriceUpdateSelection.SetDefaults;
begin
  // set the columns the user can choose from
  QueryBuilder.XMLData.DeleteNode('SQLSelect.Tables');
end;
// ---------- Form Events ------------------------------------------------------
procedure TfmPriceUpdateSelection.FormCreate(Sender: TObject);
begin
  inherited;
  if ErrorOccurred then Exit;
  XMLData := TXMLData.Create(self);
  CustomFieldRecList := TList.Create;
end;
procedure TfmPriceUpdateSelection.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    if ErrorOccurred then Exit;

    if Self.AccessLevel = 5 then begin
      QueryBuilder.IsReadOnly := true;
      btnSave.Enabled := false;
    end;

    SetDefaults;
    LoadFieldsToCombo;
  finally
    EnableForm;
  end;   
end;

// ---------- Main Actions ---------- //

procedure TfmPriceUpdateSelection.actMainSaveExecute(Sender: TObject);
begin
  inherited;
  if QueryBuilder.XMLData.Node['SQLSelect'].Attribute['SQL'].AsString = '' then
    CommonLib.MessageDlgXP_Vista('No Custom Fields were selected.', mtInformation, [mbOK], 0);
end;

procedure TfmPriceUpdateSelection.actMainCancelExecute(Sender: TObject);
begin
  inherited;
//  Close;
end;

// ---------- Form Methods/Functions -------------------------------------------

procedure TfmPriceUpdateSelection.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if ErrorOccurred then Exit;
  CanClose := True;
end;

procedure TfmPriceUpdateSelection.QueryBuilderbtnAddListItemClick(Sender: TObject);
begin
  inherited;
  QueryBuilder.btnAddListItemClick(Sender);
end;

procedure TfmPriceUpdateSelection.qryMasterBeforePost(DataSet: TDataSet);
begin
  inherited;
  if not QueryBuilder.ValidateData then Abort;
end;

procedure TfmPriceUpdateSelection.LoadFieldsToCombo;
var
  i:integer;
  sTempFieldName,sTempLabelName:string;
  CustomFieldRec:TCustomFieldRec;
begin
  inherited;     
  if not qryCustomFields.Active then qryCustomFields.Open;
  qryCustomFields.First;
  queryBuilder.cboField.Items.Clear;
  for i := 1 to 18 do begin
    sTempFieldName := 'CFProduct' + IntToStr(i );
    sTempLabelName := 'CFLabel' + IntToStr(i);
    if qryCustomFields.FieldByName(sTempFieldName).AsString = 'T' then begin
      queryBuilder.cboField.Items.Add(qryCustomFields.FieldByName(sTempLabelName).AsString) ;
      CustomFieldRec := TCustomFieldRec.Create;
      CustomFieldRec.sFieldLabel := qryCustomFields.FieldByName(sTempLabelName).AsString;
      if i < 16 then begin
        CustomFieldRec.sFieldName  := 'CUSTFLD' + intToStr(i);
        CustomFieldRec.bIsDate     := False;
      end else begin
        CustomFieldRec.sFieldName  := 'CUSTDATE' + intToStr(i - 15);
        CustomFieldRec.bIsDate     := True;
      end;
      CustomFieldRecList.Add(CustomFieldRec);
    end;
  end; 
end;    

procedure TfmPriceUpdateSelection.FormDestroy(Sender: TObject);
begin
  while CustomFieldRecList.Count > 0 do begin
    TCustomFieldRec(CustomFieldRecList[0]).Free;
    CustomFieldRecList.Delete(0);
  end;
  inherited;
end;

procedure TfmPriceUpdateSelection.QueryBuildercboFieldCloseUp(
  Sender: TObject);
begin
  inherited;
  if IsDateField(QueryBuilder.cboField.Text) then begin
    dtpValue.Visible := True; 
  end else begin
    dtpValue.Visible := False;
    queryBuilder.edtConstValue.Text := '';
  end;
end;

function TfmPriceUpdateSelection.IsDateField(sFieldName:String):Boolean;
var
  i:integer;
begin
  Result := False;
  for i := 0 to CustomFieldRecList.Count - 1 do begin
    if TCustomFieldRec(CustomFieldRecList[i]).sFieldLabel = sFieldName then
      if TCustomFieldRec(CustomFieldRecList[i]).bIsDate then Result := True;
  end;
end;

procedure TfmPriceUpdateSelection.dtpValueCloseUp(Sender: TObject);
begin
  inherited;
  queryBuilder.edtConstValue.Text := FormatDateTime('yyyy-mm-dd 00:00:00', dtpValue.Date);
end;

initialization
  RegisterClassOnce(TfmPriceUpdateSelection);
end.
