unit frmProductformula;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DBAccess, MyAccess,ERPdbComponents,
  SelectionDialog, AppEvnts, DB,  ExtCtrls, MemDS, DNMSpeedButton,
  StdCtrls, wwcheckbox, DNMPanel, Mask, BusobjProductFormula, wwdbedit,
  Shader, dmGUIStylers, BusObjBase, ImgList, ProgressDialog, wwdblook, DBCtrls , frmProductFormulaTypesforFormula,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, ERPDbLookupCombo;

type
  TfmProductFormula = class(TBaseInputGUI)
    Image1: TImage;
    pnlHeader: TDNMPanel;
    pnlFooter: TDNMPanel;
    wwCheckBox1: TwwCheckBox;
    btnCompleted: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    qryformula: TERPQuery;
    dsformula: TDataSource;
    qryformulaFormulaID: TIntegerField;
    qryformulaFormulaName: TWideStringField;
    qryformulaFormula: TWideStringField;
    qryformulaActive: TWideStringField;
    chkActive: TwwCheckBox;
    qryformulaGlobalRef: TWideStringField;
    pnlDetails: TDNMPanel;
    Label2: TLabel;
    Label3: TLabel;
    edtformulaname: TwwDBEdit;
    edtFormula: TwwDBEdit;
    DNMSpeedButton1: TDNMSpeedButton;
    Label1: TLabel;
    pumFormula: TAdvPopupMenu;
    mnuColumns: TMenuItem;
    N5: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    multiply1: TMenuItem;
    divide1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    qryFeFormulaTypes: TERPQuery;
    qryformulaFormulaTypeID: TIntegerField;
    qryformulaFormulaType: TWideStringField;
    qryformulamsTimeStamp: TDateTimeField;
    qryformulamsUpdateSiteCode: TWideStringField;
    qryFeFormulaTypesFormulaType: TWideStringField;
    qryFeFormulaTypesFe1visible: TWideStringField;
    qryFeFormulaTypesFe2visible: TWideStringField;
    qryFeFormulaTypesFe3visible: TWideStringField;
    qryFeFormulaTypesFe4visible: TWideStringField;
    qryFeFormulaTypesFe5visible: TWideStringField;
    qryformulaComments: TWideStringField;
    Label9: TLabel;
    edtComments: TwwDBEdit;
    dsFeFormulaTypes: TDataSource;
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    Label11: TLabel;
    cboFormulaType: TwwDBLookupCombo;
    Label4: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    qryformulaHasFe1DefaultValue: TWideStringField;
    qryformulaHasFe2DefaultValue: TWideStringField;
    qryformulaHasFe3DefaultValue: TWideStringField;
    qryformulaHasFe4DefaultValue: TWideStringField;
    qryformulaHasFe5DefaultValue: TWideStringField;
    qryformulaFe1DefaultValue: TFloatField;
    qryformulaFe2DefaultValue: TFloatField;
    qryformulaFe3DefaultValue: TFloatField;
    qryformulaFe4DefaultValue: TFloatField;
    qryformulaFe5DefaultValue: TFloatField;
    Shape16: TShape;
    Shape17: TShape;
    Shape18: TShape;
    Shape19: TShape;
    qryFeFormulaTypesFormulaTypeID: TLargeintField;
    lblFormulatypehint: TLabel;
    DNMPanel4: TDNMPanel;
    pnlFeDefaultValue1: TDNMPanel;
    lblfedefaultValue1: TLabel;
    Shape6: TShape;
    Shape11: TShape;
    chkfeHasDefaultValue1: TwwCheckBox;
    edtfeDefaultValue1: TDBEdit;
    pnlFeDefaultValue2: TDNMPanel;
    lblfedefaultValue2: TLabel;
    Shape7: TShape;
    Shape12: TShape;
    chkfeHasDefaultValue2: TwwCheckBox;
    edtfeDefaultValue2: TDBEdit;
    pnlFeDefaultValue3: TDNMPanel;
    lblfedefaultValue3: TLabel;
    Shape8: TShape;
    Shape13: TShape;
    chkfeHasDefaultValue3: TwwCheckBox;
    edtfeDefaultValue3: TDBEdit;
    pnlFeDefaultValue4: TDNMPanel;
    lblfedefaultValue4: TLabel;
    Shape9: TShape;
    Shape14: TShape;
    chkfeHasDefaultValue4: TwwCheckBox;
    edtfeDefaultValue4: TDBEdit;
    pnlFeDefaultValue5: TDNMPanel;
    lblfedefaultValue5: TLabel;
    Shape10: TShape;
    Shape15: TShape;
    chkfeHasDefaultValue5: TwwCheckBox;
    edtfeDefaultValue5: TDBEdit;
    pnlFormulaTypeFlags: TDNMPanel;
    lblFormulatypeDesc: TLabel;
    Label5: TLabel;
    Shape1: TShape;
    btnFieldOrder: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    pnlRelated: TDNMPanel;
    Label6: TLabel;
    dsfeformularelatedproducts: TDataSource;
    qryfeformularelatedproducts: TERPQuery;
    qryfeformularelatedproductsID: TIntegerField;
    qryfeformularelatedproductsFormulaID: TIntegerField;
    qryfeformularelatedproductsProductID: TIntegerField;
    qryfeformularelatedproductsProductName: TWideStringField;
    qryfeformularelatedproductsProductQty: TFloatField;
    qryfeformularelatedproductsmsTimeStamp: TDateTimeField;
    qryfeformularelatedproductsmsUpdateSiteCode: TWideStringField;
    cboProductQry: TERPQuery;
    cboProductQryPARTNAME: TWideStringField;
    cboProductQryPartsDescription: TWideStringField;
    cboProductQryManuf: TWideStringField;
    cboProductQryType: TWideStringField;
    cboProductQryDept: TWideStringField;
    cboProductQryPARTSID: TIntegerField;
    cboProductQryPARTTYPE: TWideStringField;
    cboProductQryLatestCostPrice: TFloatField;
    cboProductQrySNTracking: TWideStringField;
    cboProductQryActive: TWideStringField;
    cboProductQryPreferedSupp: TWideStringField;
    cboProductQryPRODUCTGROUP: TWideStringField;
    cboProductQryINCOMEACCNT: TWideStringField;
    cboProductQryASSETACCNT: TWideStringField;
    cboProductQryCOGSACCNT: TWideStringField;
    cboProductQryBARCODE: TWideStringField;
    cboProductQryPRODUCTCODE: TWideStringField;
    cboProductQryTAXCODE: TWideStringField;
    cboProductQryBatch: TWideStringField;
    cboProductQryAutoBatch: TWideStringField;
    cboProductQryMultipleBins: TWideStringField;
    cboProductQrySpecialDiscount: TWideStringField;
    cboProductQryBuyQTY1: TIntegerField;
    cboProductQryBuyQTY2: TIntegerField;
    cboProductQryBuyQTY3: TIntegerField;
    cboProductQryCOST1: TFloatField;
    cboProductQryCOST2: TFloatField;
    cboProductQryCOST3: TFloatField;
    cboProductQrySellQTY1: TIntegerField;
    cboProductQrySellQTY2: TIntegerField;
    cboProductQrySellQTY3: TIntegerField;
    cboProductQryPRICE1: TFloatField;
    cboProductQryPRICE2: TFloatField;
    cboProductQryPRICE3: TFloatField;
    cboProductQryWHOLESALEPRICE: TFloatField;
    cboProductQryEditedFlag: TWideStringField;
    cboProductQryAvgCost: TFloatField;
    cboProductQryAttrib1Sale: TFloatField;
    cboProductQryAttrib2Sale: TFloatField;
    cboProductQryAttrib1SaleRate: TFloatField;
    cboProductQryDiscontinued: TWideStringField;
    cboProductQryCUSTFLD1: TWideStringField;
    cboProductQryCUSTFLD2: TWideStringField;
    cboProductQryCUSTFLD3: TWideStringField;
    cboProductQryCUSTFLD4: TWideStringField;
    cboProductQryCUSTFLD5: TWideStringField;
    cboProductQryCUSTFLD6: TWideStringField;
    cboProductQryCUSTFLD7: TWideStringField;
    cboProductQryCUSTFLD8: TWideStringField;
    cboProductQryCUSTFLD9: TWideStringField;
    cboProductQryCUSTFLD10: TWideStringField;
    cboProductQryCUSTFLD11: TWideStringField;
    cboProductQryCUSTFLD12: TWideStringField;
    cboProductQryCUSTFLD13: TWideStringField;
    cboProductQryCUSTFLD14: TWideStringField;
    cboProductQryCUSTFLD15: TWideStringField;
    cboProductQryCUSTDATE1: TDateTimeField;
    cboProductQryCUSTDATE2: TDateTimeField;
    cboProductQryCUSTDATE3: TDateTimeField;
    cboProductQrySupplierProductCode: TWideStringField;
    cboProductR: TERPDbLookupCombo;
    grdrelatedproducts: TwwDBGrid;
    btnDelete: TwwIButton;
    qryfeformularelatedproductsActive: TWideStringField;
    N6: TMenuItem;
    Extra1: TMenuItem;
    SquareFeetToSquaremeter: TMenuItem;
    SquareFeetToSquareCentiMeter: TMenuItem;
    SquareInchToSquareMeter: TMenuItem;
    SquareInchToSquareCentiMeter: TMenuItem;
    N7: TMenuItem;
    FeetToMeter: TMenuItem;
    FeetToCentiMeter: TMenuItem;
    InchtoMeter: TMenuItem;
    InchToCentiMeter: TMenuItem;
    MetricToNonMetric1: TMenuItem;
    SquareMeterToSquareFeet: TMenuItem;
    SquareCentiMeterToSquareFeet: TMenuItem;
    SquareMeterToSquareInch: TMenuItem;
    SquareCentiMeterToSquareInch: TMenuItem;
    N8: TMenuItem;
    MeterToFeet: TMenuItem;
    CentiMeterToFeet: TMenuItem;
    MeterToInch: TMenuItem;
    CentiMeterToInch: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure pumFormulaPopup(Sender: TObject);
    procedure qryFeFormulaTypesBeforeOpen(DataSet: TDataSet);
    procedure cboFormulaTypeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboFormulaTypeDblClick(Sender: TObject);
    procedure qryFeFormulaTypesAfterOpen(DataSet: TDataSet);
    procedure btnFieldOrderClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnDeleteClick(Sender: TObject);
    procedure qryfeformularelatedproductsAfterPost(DataSet: TDataSet);
    procedure ApplyconvertionValue(Sender: TObject);

  private
    Formula : TFormula;

    FormulaEntries: TListBox;
    ffmProductFormulaTypes : TfmProductFormulaTypesforFormula;
    fsFormulaTypeLockMsg: String;
    procedure Locateformula;

    function ProductFormulaTypesForm :TfmProductFormulaTypesforFormula;
    function SaveRecord: Boolean;
    procedure SetFormulatypeLockMsg(const Value: String);
    Procedure ShowFEFieldsCallback(Const Sender: TBusObj; var Abort: boolean);
    procedure RefreshFields(Sender: TObject);
    procedure initProductFormulaEntryOrder(Sender: TObject);
    function isRecordempty: Boolean;
  Protected
    Procedure InitERPLookupCombonFields; Override;
  public
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    Property FormulatypeLockMsg:String read fsFormulaTypeLockMsg write SetFormulatypeLockMsg;
  end;


implementation

uses FastFuncs, FormFactory, CommonLib, BusObjConst, AppEnvironment,
  CommonFormLib, UserLockBaseObj, tcConst, frmProductFormulaEntryOrder,
  CommonDbLib;

{$R *.dfm}

procedure TfmProductFormula.FormCreate(Sender: TObject);
begin
    inherited;
    ffmProductFormulaTypes := nil;
    Formula := TFormula.Create(Self);
    Formula.connection := TMyDAcDataConnection.Create(Formula);
    Formula.Connection.Connection := Self.MyConnection;
    Formula.BusObjEvent := DoBusinessObjectEvent;
    FormulaEntries := nil;
end;

procedure TfmProductFormula.FormDestroy(Sender: TObject);
begin
  freeandnil(Formula);
  freeandnil(FormulaEntries);
  inherited;
end;

procedure TfmProductFormula.btnCompletedClick(Sender: TObject);
begin
  inherited;
    if SaveRecord then begin
        Notify;
        Self.Close;
    end;
end;

procedure TfmProductFormula.btnDeleteClick(Sender: TObject);
begin
  inherited;
  Formula.FormulaRelatedProducts.postdb;
  if Formula.FormulaRelatedProducts.count =0 then exit;
  if Isrecordempty or (MessageDlgXP_Vista('Do you Wish to Remove ' +Quotedstr(Formula.FormulaRelatedProducts.ProductName)+' from the Related Products List? ', mtConfirmation, [mbYes, mbNo], 0) = mrYes)  then
    Formula.FormulaRelatedProducts.Delete;

end;

procedure TfmProductFormula.cmdNewClick(Sender: TObject);
begin
  inherited;
    if SaveRecord then Formula.New;
    Notify;
    Setcontrolfocus(edtformulaname);
end;
Function TfmProductFormula.SaveRecord:Boolean;
begin
  REsult := Formula.Save;
  if Formula.FormulaTypeID <> 0 then
    ProductFormulaTypesForm.savenCommit;
  Formula.Connection.CommitTransaction;
end;
procedure TfmProductFormula.SetFormulatypeLockMsg(const Value: String);
begin
  fsFormulaTypeLockMsg := Value;
  if Value <> '' then
    lblFormulatypehint.caption := TRIM(CustomiseLockMessage(Value , ['Unable to update data.' + #13#10 ,'accessing this record','Record has been in use'],
                                                                   ['', 'Accessing this Formula Type','Formula Type has been in Use']))
  else
    lblFormulatypehint.caption :='Adjusting Visability Flags here will Adjust it'+NL+'for All Formulas of the Same Type';
  ffmProductFormulaTypes.pnlFormulaTypeFlags.enabled := trim(Value) ='';
end;

procedure TfmProductFormula.ApplyconvertionValue(Sender: TObject);
var
  value : double;
  s:string;
  x:Integer;
begin
  inherited;
       if Sender = SquareFeetToSquaremeter        Then Value := SqFtToSqM
  else if Sender = SquareFeetToSquareCentiMeter   Then Value := SqFtToSqCM
  else if Sender = SquareInchToSquareMeter        Then Value := SqinchtoSqM
  else if Sender = SquareInchToSquareCentiMeter   Then Value := SqinchtoSqcm
  else if Sender = FeetToMeter                    Then Value := FtToM
  else if Sender = FeetToCentiMeter               Then Value := FtTocM
  else if Sender = InchtoMeter                    Then Value := inchtoM
  else if Sender = InchToCentiMeter               Then Value := InchToCM
  else if Sender = SquareMeterToSquareFeet        Then Value := SqmtoSqF
  else if Sender = SquareCentiMeterToSquareFeet   Then Value := sqcmtosqf
  else if Sender = SquareMeterToSquareInch        Then Value := sqmtosqin
  else if Sender = SquareCentiMeterToSquareInch   Then Value := sqcmtosqinch
  else if Sender = MeterToFeet                    Then Value := mtoFeet
  else if Sender = CentiMeterToFeet               Then Value := cmtofeet
  else if Sender = MeterToInch                    Then Value := mtoinch
  else if Sender = CentiMeterToInch               Then Value := cmtoinch
  else Exit;

  s := edtFormula.Text;
  x := edtFormula.SelStart;
  Insert(Floattostr(Value), s, x + 1);
  edtFormula.Text     := s;

  Formula.formula := Trim(edtFormula.Text);
  Formula.PostDB;
  SetcontrolFocus(edtFormula);
  edtFormula.SelStart := char_length(edtFormula.text);
end;

procedure TfmProductFormula.btnCloseClick(Sender: TObject);
begin
  inherited;
    Notify;
    Self.Close;
end;

procedure TfmProductFormula.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    Formula.Load(keyID) ;
    Formula.FormulaRelatedProducts;
    openQueries;

    if KeyID<> 0 then
      if not Formula.LockInUse then begin
        AccessLevel := 5; // read only
        CommonLib.MessageDlgXP_Vista(UserLock.LockMessage + #13 + #10 + #13 + #10 + 'Access has been changed to read-only.', mtWarning, [mbOK], 0);
      end;

    if accesslevel <=3 then begin
      Formula.Connection.BeginTransaction;
      if KeyId <> 0 then else Formula.New;
    end;
    RefreshFields(self);

(*    lblfedefaultValue1.caption := AppEnv.CompanyPrefs.Fe1Name;pnlFeDefaultValue1.Visible := AppEnv.CompanyPrefs.Fe1Visible;chkfeHasDefaultValue1.left := 3;chkfeHasDefaultValue1.top := 26;
    lblfedefaultValue2.caption := AppEnv.CompanyPrefs.Fe2Name;pnlFeDefaultValue2.Visible := AppEnv.CompanyPrefs.Fe2Visible;chkfeHasDefaultValue2.left := 3;chkfeHasDefaultValue2.top := 26;
    lblfedefaultValue3.caption := AppEnv.CompanyPrefs.Fe3Name;pnlFeDefaultValue3.Visible := AppEnv.CompanyPrefs.Fe3Visible;chkfeHasDefaultValue3.left := 3;chkfeHasDefaultValue3.top := 26;
    lblfedefaultValue4.caption := AppEnv.CompanyPrefs.Fe4Name;pnlFeDefaultValue4.Visible := AppEnv.CompanyPrefs.Fe4Visible;chkfeHasDefaultValue4.left := 3;chkfeHasDefaultValue4.top := 26;
    lblfedefaultValue5.caption := AppEnv.CompanyPrefs.Fe5Name;pnlFeDefaultValue5.Visible := AppEnv.CompanyPrefs.Fe5Visible;chkfeHasDefaultValue5.left := 3;chkfeHasDefaultValue5.top := 26;*)

  finally
    EnableForm;
  end;
end;
procedure TfmProductFormula.InitERPLookupCombonFields;
begin
  inherited;
  SetupProductNamenPrintNameinGrid(cboProductR ,nil ,'ProductName' , '' , 'PARTSDESCRIPTION' , grdrelatedproducts );
end;

procedure TfmProductFormula.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
    Action := caFree;
end;

procedure TfmProductFormula.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose := false;
  if Formula.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
            Formula.Save;
            Formula.Connection.CommitTransaction;
            CanClose := true;
        end;
      mrNo:
        begin
          Formula.Connection.RollbackTransaction;
          Formula.Dirty := false;
          CanClose := true;
        end;
      mrCancel:
        begin
          CanClose := false;
        end;
    end;
  end else begin
    CanClose := true;
  end;
end;

procedure TfmProductFormula.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
    if Formula.ValidateData then
        CommonLib.MessageDlgXP_Vista('Formula is Valid' , mtInformation , [mbok] , 0);
end;

procedure TfmProductFormula.N1Click(Sender: TObject);
var
  s, InsertStr, MenuCaption: string;
  x: integer;
begin
  InsertStr := '';
  if TMenuItem(Sender).tag > 0 then begin
    MenuCaption := StringReplace(TMenuItem(Sender).Caption, '&', '',[rfReplaceAll,rfIgnoreCase]); // remove "&" added by delphi
    InsertStr :=Trim(copy(MenuCaption , 1, 8));
  end else begin
    MenuCaption := StringReplace(TMenuItem(Sender).Caption, '&', '',[rfReplaceAll,rfIgnoreCase]); // remove "&" added by delphi
         if sametext(MenuCaption , 'add' ) then InsertStr := '+'
    else if sametext(MenuCaption , 'subtract' ) then InsertStr := '-'
    else if sametext(MenuCaption , 'multiply' ) then InsertStr := '*'
    else if sametext(MenuCaption , 'divide' ) then InsertStr := '/'
    else if sametext(MenuCaption , '(' ) then InsertStr := '('
    else if sametext(MenuCaption , ')' ) then InsertStr := ')';
  end;
  if InsertStr <> '' then begin
    s := edtFormula.Text;
    x := edtFormula.SelStart;
    Insert(InsertStr, s, x + 1);
    edtFormula.Text     := s;
  end;
  Formula.formula := Trim(edtFormula.Text);
  Formula.PostDB;
  SetcontrolFocus(edtFormula);
  edtFormula.SelStart := char_length(edtFormula.text);
end;

procedure TfmProductFormula.pumFormulaPopup(Sender: TObject);
var
  item: TMenuItem;
begin
  // popuate menu with a list of fields that can be used in calculations
  mnuColumns.Clear;
  With TFormulaEntry.Create(Self) do Try
    if Dataset.Recordcount = 0 then Exit;
    Dataset.first;
    While Dataset.Eof = False do begin
        item := TMenuItem.Create(self);
        item.Caption := Copy('Field'+IntToStr(FormulaEntryNo)+'   ' ,1,8) + ' : ' + FormulaEntryName;
        item.Tag := integer(FormulaEntryNo);
        item.OnClick := N1Click;
        mnuColumns.Add(item);
        Dataset.Next;
    end;
  Finally
      Free;
  end;
end;


procedure TfmProductFormula.qryFeFormulaTypesBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryFeFormulaTypesFe1visible.DisplayLabel := AppEnv.CompanyPrefs.Fe1Name;
  qryFeFormulaTypesFe2visible.DisplayLabel := AppEnv.CompanyPrefs.Fe2Name;
  qryFeFormulaTypesFe3visible.DisplayLabel := AppEnv.CompanyPrefs.Fe3Name;
  qryFeFormulaTypesFe4visible.DisplayLabel := AppEnv.CompanyPrefs.Fe4Name;
  qryFeFormulaTypesFe5visible.DisplayLabel := AppEnv.CompanyPrefs.Fe5Name;

  qryFeFormulaTypesFe1visible.Visible := AppEnv.CompanyPrefs.Fe1Visible;
  qryFeFormulaTypesFe2visible.Visible := AppEnv.CompanyPrefs.Fe2Visible;
  qryFeFormulaTypesFe3visible.Visible := AppEnv.CompanyPrefs.Fe3Visible;
  qryFeFormulaTypesFe4visible.Visible := AppEnv.CompanyPrefs.Fe4Visible;
  qryFeFormulaTypesFe5visible.Visible := AppEnv.CompanyPrefs.Fe5Visible;
end;
Function TfmProductFormula.isRecordempty:Boolean;
begin
  result := Commondblib.Isrecordempty(qryfeformularelatedproducts ,  qryfeformularelatedproductsProductQty.FieldName +',' +
                                                  qryfeformularelatedproductsID.FieldName         +',' +
                                                  qryfeformularelatedproductsFormulaID.FieldName  +',' +
                                                  qryfeformularelatedproductsProductID.FieldName  +',' +
                                                  qryfeformularelatedproductsmsTimeStamp.FieldName+',' +
                                                  qryfeformularelatedproductsmsUpdateSiteCode.FieldName ) ;

end;
procedure TfmProductFormula.qryfeformularelatedproductsAfterPost(
  DataSet: TDataSet);
begin
  inherited;
  if Isrecordempty then btnDelete.Click;
end;

procedure TfmProductFormula.qryFeFormulaTypesAfterOpen(DataSet: TDataSet);
begin
  inherited;
  Locateformula;
end;
Procedure TfmProductFormula.Locateformula;
begin
    if Formula.formulaTypeId <> 0 then  begin
      opendb(qryFeFormulaTypes);
      qryFeFormulaTypes.locate('formulaTypeId' ,Formula.formulaTypeId , []);
    end;
end;
procedure TfmProductFormula.cboFormulaTypeCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  Formula.formulaTypeId := qryFeFormulaTypesFormulaTypeId.ASInteger;
end;

procedure TfmProductFormula.cboFormulaTypeDblClick(Sender: TObject);
begin
  inherited;
  if Formula.formulaTypeId =0 then exit;
  OpenERPFormModal('TfmProductFormulaTypesforFormula' ,Formula.formulaTypeId);
  closedb(qryFeFormulaTypes);
  opendb(qryFeFormulaTypes);
end;

procedure TfmProductFormula.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TFormula then TFormula(Sender).DataSet:= qryformula
    else if Sender is TFeFormulaRelatedProducts then TFeFormulaRelatedProducts(Sender).DataSet:= qryfeformularelatedproducts;
  end else if (Eventtype = BusObjEvent_Change) and (Value = BusObjEventVal_FormulaType) and (Sender is TFormula) then begin
    ProductFormulaTypesForm; // to change form
  end else if (Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterInsert) and (Sender is TFormula) then begin
    ProductFormulaTypesForm; // to change form
  end else if (Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterPost) and (Sender is TFormula) then begin
    Formula.FormulaRelatedProducts; // to make sure the data set is opened first time
  end else if TDatasetBusObj(Sender).IsdataIdchangeEvent(Value) and (Sender is TFormula) then begin
    ProductFormulaTypesForm; // to change form
    Formula.FormulaRelatedProducts;
  end;
end;

function TfmProductFormula.ProductFormulaTypesForm: TfmProductFormulaTypesforFormula;
begin
  LocateFormula;
  if (ffmProductFormulaTypes<> nil) and (ffmProductFormulaTypes.KeyId <> Formula.FormulaTypeID) then begin
    ffmProductFormulaTypes.CancelRec;
    ffmProductFormulaTypes.cmdCancel.Click;
    try Freeandnil(ffmProductFormulaTypes); except end;
  end;
  if ffmProductFormulaTypes = nil then begin
    ffmProductFormulaTypes := TfmProductFormulaTypesforFormula.create(Self);
    ffmProductFormulaTypes.KeyId := Formula.FormulaTypeID;
    ffmProductFormulaTypes.FormShow(ffmProductFormulaTypes);
    ffmProductFormulaTypes.pnlFormulaTypeFlags.parent := pnlFormulaTypeFlags;
    ffmProductFormulaTypes.pnlFormulaTypeFlags.Align := alclient;
    ffmProductFormulaTypes.pnlFormulaTypeFlags.Parentcolor := True;
    ffmProductFormulaTypes.pnlFormulaTypeFlags.Enabled := ffmProductFormulaTypes.pnlFormulaTypeFlags.Enabled and (Formula.FormulaTypeID <> 0);
    ffmProductFormulaTypes.RefreshFields(ffmProductFormulaTypes);
    cboFormulaType.onDblclick := nil;
    ffmProductFormulaTypes.visible := False;
  end;
  result := ffmProductFormulaTypes;
end;
procedure TfmProductFormula.btnFieldOrderClick(Sender: TObject);
begin
  inherited;
  OpenERPFormModal('TfmProductFormulaEntryOrder' ,0, initProductFormulaEntryOrder , False , RefreshFields);
end;
procedure TfmProductFormula.initProductFormulaEntryOrder(Sender: TObject);
begin
  if sender is TfmProductFormulaEntryOrder then
    TfmProductFormulaEntryOrder(sender).formulaId := Formula.ID;
end;
procedure TfmProductFormula.RefreshFields(Sender: TObject);
var
  FormulaEntry : TFieldFormulaEntry;
begin
    FormulaEntry := TFieldFormulaEntry.create(Self);
    try
      FormulaEntry.connection := Formula.connection;
      FormulaEntry.BusObjEvent := DoBusinessObjectEvent;
      //FormulaEntry.SQLOrder := 'FieldOrderno';
      //FormulaEntry.Loadselect('FEO.FormulaID = ' + inttostr(Formula.ID));
      FormulaEntry.sql := FormulaEntry.objSQL +' and FormulaID = ' + inttostr(Formula.ID) +' Order by ActualFieldOrderno';
      FormulaEntry.Load;
      FormulaEntry.IterateRecordsReverse(ShowFEFieldsCallback);
      if assigned(ffmProductFormulaTypes) then ffmProductFormulaTypes.RefreshFields(ffmProductFormulaTypes);
    finally
      freeandnil(FormulaEntry);
    end;
end;
Procedure TfmProductFormula.ShowFEFieldsCallback(Const Sender: TBusObj; var Abort: boolean);
begin
  if sender is TFieldFormulaEntry then begin
             if TFieldFormulaEntry(Sender).FormulaEntryNo = 1 then begin  lblfedefaultValue1.caption := AppEnv.CompanyPrefs.Fe1Name;pnlFeDefaultValue1.Visible := AppEnv.CompanyPrefs.Fe1Visible;chkfeHasDefaultValue1.left := 3;chkfeHasDefaultValue1.top := 26;pnlFeDefaultValue1.left:= 0;
    end else if TFieldFormulaEntry(Sender).FormulaEntryNo = 2 then begin  lblfedefaultValue2.caption := AppEnv.CompanyPrefs.Fe2Name;pnlFeDefaultValue2.Visible := AppEnv.CompanyPrefs.Fe2Visible;chkfeHasDefaultValue2.left := 3;chkfeHasDefaultValue2.top := 26;pnlFeDefaultValue2.left:= 0;
    end else if TFieldFormulaEntry(Sender).FormulaEntryNo = 3 then begin  lblfedefaultValue3.caption := AppEnv.CompanyPrefs.Fe3Name;pnlFeDefaultValue3.Visible := AppEnv.CompanyPrefs.Fe3Visible;chkfeHasDefaultValue3.left := 3;chkfeHasDefaultValue3.top := 26;pnlFeDefaultValue3.left:= 0;
    end else if TFieldFormulaEntry(Sender).FormulaEntryNo = 4 then begin  lblfedefaultValue4.caption := AppEnv.CompanyPrefs.Fe4Name;pnlFeDefaultValue4.Visible := AppEnv.CompanyPrefs.Fe4Visible;chkfeHasDefaultValue4.left := 3;chkfeHasDefaultValue4.top := 26;pnlFeDefaultValue4.left:= 0;
    end else if TFieldFormulaEntry(Sender).FormulaEntryNo = 5 then begin  lblfedefaultValue5.caption := AppEnv.CompanyPrefs.Fe5Name;pnlFeDefaultValue5.Visible := AppEnv.CompanyPrefs.Fe5Visible;chkfeHasDefaultValue5.left := 3;chkfeHasDefaultValue5.top := 26;pnlFeDefaultValue5.left:= 0;
    end;
  end;
end;

initialization
  RegisterClassOnce(TfmProductFormula);

  with FormFact do  begin
    RegisterMe(TfmProductFormula, 'TfmProductformulaList_*=FormulaID');
  end;
finalization
  UnRegisterClass(TfmProductFormula);

end.
