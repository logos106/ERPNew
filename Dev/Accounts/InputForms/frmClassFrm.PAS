unit frmClassFrm;
{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 ??/??/?? 1.00.01  ???  Initial Version
 19/12/05 1.00.02  AL   Removed "Instance", added RegisterClass  *Task306*
 30/01/06 1.00.03  AL   Prevent making inactive a class if it has anything in stock
}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, StdCtrls, Mask, DBCtrls, ExtCtrls,   BaseInputForm,
  DNMPanel, wwcheckbox, wwdbedit, Wwdbspin, ComCtrls,AdvOfficeStatusBar, kbmMemTable, wwdblook, Buttons, DNMSpeedButton,
  DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, DataState, MemDS, Menus, AdvMenus,
  Shader, ImgList, ProgressDialog, Wwdbigrd, Grids, Wwdbgrid, ERPDbLookupCombo;

type
  TfrmClass = class(TBaseInputGUI)
    frmClassSrc: TDataSource;
    qryClass: TERPQuery;
    qryClass2: TERPQuery;
    memQryClass: TkbmMemTable;
    qryAccLevel3: TERPQuery;
    qryAccLevel2: TERPQuery;
    qryAccLevel1: TERPQuery;
    DataSource6: TDataSource;
    qryProductLevels: TERPQuery;
    DataSource4: TDataSource;
    DataSource5: TDataSource;
    SuburbQry: TERPQuery;
    qryClassGlobalRef: TWideStringField;
    qryClassClassID: TIntegerField;
    qryClassClassName: TWideStringField;
    qryClassClassGroup: TWideStringField;
    qryClassDescription: TWideStringField;
    qryClassActive: TWideStringField;
    qryClassSubClass: TWideStringField;
    qryClassEditedFlag: TWideStringField;
    qryClassSubClassOf: TWideStringField;
    qryClassClassPercent: TFloatField;
    qryClassLevel1: TWideStringField;
    qryClassLevel2: TWideStringField;
    qryClassLevel3: TWideStringField;
    qryClassLevel4: TWideStringField;
    qryClassAutoCreateSmartOrders: TWideStringField;
    qryClassAutoCreateRepairs: TWideStringField;
    qryClassmsTimeStamp: TDateTimeField;
    qryClassUseAddress: TWideStringField;
    qryClassStreet: TWideStringField;
    qryClassStreet2: TWideStringField;
    qryClassSuburb: TWideStringField;
    qryClassState: TWideStringField;
    qryClassPostcode: TWideStringField;
    qryClassStreet3: TWideStringField;
    qryClassCountry: TWideStringField;
    qryClassLocationCode: TWideStringField;
    qryClassSiteCode: TWideStringField;
    DNMPanel1: TDNMPanel;
    DNMPanel3: TDNMPanel;
    DNMPanel4: TDNMPanel;
    qryCurrencyConversions: TERPQuery;
    qryCurrencyConversionsCurrencyID: TAutoIncField;
    qryCurrencyConversionsCountry: TWideStringField;
    qryCurrencyConversionsCurrency: TWideStringField;
    qryCurrencyConversionsCode: TWideStringField;
    qryCurrencyConversionsBuyRate: TFloatField;
    qryCurrencyConversionsSellRate: TFloatField;
    cmdNew: TDNMSpeedButton;
    cmdOk: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    chkActive: TDBCheckbox;
    ERPQuery1: TERPQuery;
    AutoIncField1: TAutoIncField;
    WideStringField1: TWideStringField;
    WideStringField2: TWideStringField;
    WideStringField3: TWideStringField;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    PgMain: TPageControl;
    TabMain: TTabSheet;
    TabStS: TTabSheet;
    DNMPanel2: TDNMPanel;
    Description_Label: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    lblAddress1: TLabel;
    lblAddress2: TLabel;
    lblSuburb: TLabel;
    lblState: TLabel;
    lblPostcode: TLabel;
    lblAddress3: TLabel;
    lblCountry: TLabel;
    Label9: TLabel;
    edtDescription: TDBEdit;
    cboAccLevel1: TwwDBLookupCombo;
    cboAccLevel2: TwwDBLookupCombo;
    cboAccLevel3: TwwDBLookupCombo;
    edtClassName: TwwDBEdit;
    AccountTreeView: TTreeView;
    chkAutoCreateSmartOrders: TDBCheckbox;
    chkAutoCreateRepairs: TDBCheckbox;
    chkUseAddress: TDBCheckbox;
    edtStreet: TDBEdit;
    edtStreet2: TDBEdit;
    cboSuburb: TwwDBLookupCombo;
    edtState: TDBEdit;
    edtPostcode: TDBEdit;
    edtStreet3: TDBEdit;
    edtCountry: TDBEdit;
    edtSiteCode: TwwDBEdit;
    qrystsClass: TERPQuery;
    dsstsClass: TDataSource;
    qrystsClassID: TIntegerField;
    qrystsClassGlobalRef: TWideStringField;
    qrystsClassClassId: TIntegerField;
    qrystsClassPrincipleContactID: TIntegerField;
    qrystsClassPrincipleContact: TWideStringField;
    qrystsClassPrincipleContactPhone: TWideStringField;
    qrystsClassLicenseNumber: TWideStringField;
    qrystsClassmstimestamp: TDateTimeField;
    qrystsClassmsUpdatesitecode: TWideStringField;
    cboEmployeeLookup: TERPQuery;
    Label1: TLabel;
    cboPrincipleContact: TwwDBLookupCombo;
    cboEmployeeLookupEmployeeID: TIntegerField;
    cboEmployeeLookupEmployeeName: TWideStringField;
    Label4: TLabel;
    edtPrincipleContactPhone: TwwDBEdit;
    Label6: TLabel;
    edtLicenseNumber: TwwDBEdit;
    qryTaxCodes: TERPQuery;
    qryTaxCodesTaxname: TWideStringField;
    qryTaxCodesDescription: TWideStringField;
    qryTaxCodesLocation: TWideStringField;
    qryTaxCodescRate: TFloatField;
    qryTaxCodesTaxCodeID: TIntegerField;
    qryTaxCodesRate: TFloatField;
    qryDepttaxexceptionproducts: TERPQuery;
    dsDepttaxexceptionproducts: TDataSource;
    qryDepttaxexceptionproductsID: TIntegerField;
    qryDepttaxexceptionproductsglobalref: TWideStringField;
    qryDepttaxexceptionproductsDeptID: TIntegerField;
    qryDepttaxexceptionproductsDeptName: TWideStringField;
    qryDepttaxexceptionproductsProductId: TIntegerField;
    qryDepttaxexceptionproductsProductName: TWideStringField;
    qryDepttaxexceptionproductsActive: TWideStringField;
    qryDepttaxexceptionproductsmsTimeStamp: TDateTimeField;
    qryDepttaxexceptionproductsmsUpdatesitecode: TWideStringField;
    DNMPanel5: TDNMPanel;
    Label11: TLabel;
    Label13: TLabel;
    cboTaxExceptionProduct: TERPDbLookupCombo;
    qryClassTaxname: TWideStringField;
    qryClassTAXID: TIntegerField;
    cboTaxCode: TERPDbLookupCombo;
    grdTaxExceptionProducts: TwwDBGrid;
    delTaxExceptionProducts: TwwIButton;
    QryProduct: TERPQuery;
    QryProductPARTSID: TIntegerField;
    QryProductPARTNAME: TWideStringField;
    QryProductPARTTYPE: TWideStringField;
    QryProductPRODUCTGROUP: TWideStringField;
    QryProductPARTSDESCRIPTION: TWideStringField;
    QryProductINCOMEACCNT: TWideStringField;
    QryProductASSETACCNT: TWideStringField;
    QryProductCOGSACCNT: TWideStringField;
    QryProductBARCODE: TWideStringField;
    QryProductPRODUCTCODE: TWideStringField;
    QryProductTAXCODE: TWideStringField;
    QryProductSpecialDiscount: TWideStringField;
    QryProductSNTracking: TWideStringField;
    QryProductBuyQTY1: TIntegerField;
    QryProductBuyQTY2: TIntegerField;
    QryProductBuyQTY3: TIntegerField;
    QryProductCOST1: TFloatField;
    QryProductCOST2: TFloatField;
    QryProductCOST3: TFloatField;
    QryProductSellQTY1: TIntegerField;
    QryProductSellQTY2: TIntegerField;
    QryProductSellQTY3: TIntegerField;
    QryProductPRICE1: TFloatField;
    QryProductPRICE2: TFloatField;
    QryProductPRICE3: TFloatField;
    QryProductWHOLESALEPRICE: TFloatField;
    QryProductActive: TWideStringField;
    QryProductEditedFlag: TWideStringField;
    lblLocationCode: TLabel;
    edtLocationCode: TwwDBEdit;
    QryBin: TERPQuery;
    QryBinbinlocation: TWideStringField;
    QryBinbinId: TIntegerField;
    lblbin: TLabel;
    cbobinLocation: TwwDBLookupCombo;
    qrystsClassDefaultStSBinID: TIntegerField;
    procedure cmdOkClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qryClassAfterInsert(DataSet: TDataSet);
    procedure qryClassAfterOpen(DataSet: TDataSet);
    procedure cboAccLevel1Change(Sender: TObject);
    procedure cboAccLevel2Change(Sender: TObject);
    procedure cboAccLevel3Change(Sender: TObject);
    procedure edtClassNameChange(Sender: TObject);
    procedure cboAccLevel1Exit(Sender: TObject);
    procedure cboAccLevel2Exit(Sender: TObject);
    procedure chkUseAddressClick(Sender: TObject);
    procedure cboSuburbCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure chkActiveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SuburbQryBeforeOpen(DataSet: TDataSet);
    procedure qryClassAfterPost(DataSet: TDataSet);
    procedure qryClassSiteCodeSetText(Sender: TField; const Text: String);
    procedure qryClassClassNameChange(Sender: TField);
    procedure FormResize(Sender: TObject);
    procedure PgMainResize(Sender: TObject);
    procedure qrystsClassBeforeOpen(DataSet: TDataSet);
    procedure cboPrincipleContactCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure qrystsClassAfterInsert(DataSet: TDataSet);
    procedure qryClassBeforeClose(DataSet: TDataSet);
    procedure qryTaxCodesBeforeOpen(DataSet: TDataSet);
    procedure grdTaxExceptionProductsDblClick(Sender: TObject);
    procedure qryDepttaxexceptionproductsAfterInsert(DataSet: TDataSet);
    procedure qryDepttaxexceptionproductsBeforePost(DataSet: TDataSet);
    procedure cboTaxCodeNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: string; var Accept: Boolean);
    procedure cboTaxExceptionProductChange(Sender: TObject);
    procedure cboTaxExceptionProductCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure arambyn(DataSet: TDataSet);
    procedure PgMainChanging(Sender: TObject; var AllowChange: Boolean);
    procedure PgMainChange(Sender: TObject);
    procedure cbobinLocationEnter(Sender: TObject);
    procedure QryBinBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
    fbClosingForm: boolean;
    fbInitStsClassMode: boolean;
    procedure AccountTreeOrder;
    procedure AccountLevelCombosRefresh;
    function AccountGroupJoin: string;
    function ValidateData: boolean;
    function SaveData: boolean;
    function IsDefaultclassforAnyemp(classID:Integer):Boolean;
  Protected
    procedure CommitTransaction; Override;
    procedure AftershowPopupform(frmPopup: TBaseInputGUI); Override;
    procedure InitPopupform(frmPopup: TBaseInputGUI); Override;
  public
    Property InitStsClassMode :Boolean read fbInitStsClassMode write fbInitStsClassMode;


  end;

implementation

uses
  FormFactory, DNMLib, DNMExceptions,
  CommonLib,  AppEnvironment, CommonDbLib, BusObjDeletedItem, frmMessageBase, frmMessageWithList,
  tcConst, frmBinLocation;

{$R *.DFM}

var

  Flag: integer; // FLAG is for use when counting records that have any precentage variance. (See OnFormShow)

procedure TfrmClass.cmdOkClick(Sender: TObject);
begin
  try
    if SaveData then begin
      self.CommitTransaction;
      Notify(False);
      Close;
    end;
  except
    on EAbort do HandleEAbortException;
    else raise;
  end;
end;

procedure TfrmClass.cmdCancelClick(Sender: TObject);
begin
  Notify(true);
  Self.Close;
end;

procedure TfrmClass.cmdNewClick(Sender: TObject);
begin
  try
    if not Empty(edtClassName.Text) then begin
      if SaveData then begin
        self.CommitTransaction;
        Notify(False);
      end
      else
        exit;

      self.BeginTransaction;

      KeyID := 0;
      cboAccLevel1.Enabled := true;
      cboAccLevel2.Enabled := true;
      cboAccLevel3.Enabled := true;
      edtClassName.Enabled := true;
      CloseQueries;
      Application.ProcessMessages;
      FormShow(nil);

      edtClassName.ReadOnly := false;
      SetControlFocus(cboAccLevel1);
    end else begin
      CommonLib.MessageDlgXP_Vista('Class name cannot be blank.', mtWarning, [mbOK], 0);
      SetControlFocus(cboAccLevel1);
    end;
  except
    on EAbort do HandleEAbortException;
    else raise;
  end;
end;


procedure TfrmClass.FormShow(Sender: TObject);

  procedure CountUpZeroPercent;
  begin;
    Flag := 0;
    qryClass2.First;
    while not qryClass2.Eof do begin;
      if qryClass2.FieldByName('ClassPercent').AsFloat <> 0 then flag := 1;
      qryClass2.Next;
    end;
  end;
begin
  DisableForm;
  try
    try
      inherited;
      pgmain.activePageindex := 0;
      self.BeginTransaction;

      // Are we overriding auto class create features?
      if AppEnv.Employee.OverrideAutoSmartOrders then begin
        // Yes, disable these controls then.
        chkAutoCreateSmartOrders.Enabled := false;
      end;

      qryProductLevels.ParamByName('KeyID').asInteger := KeyID;
      qryClass.ParamByName('varClassID').asInteger := KeyID;
      OpenQueries;
      CountUpZeroPercent;
      if KeyID = 0 then begin
        qryClass.Insert;
        cboAccLevel1.Enabled := true;
        cboAccLevel2.Enabled := true;
        cboAccLevel3.Enabled := true;
        edtClassName.Enabled := true;
        chkUseAddress.Enabled := false;
      end else begin
        qryClass.Edit;
        cboAccLevel1.Enabled := true;
        cboAccLevel2.Enabled := true;
        cboAccLevel3.Enabled := true;
        edtClassName.Enabled := false;
      end;

      chkActive.Enabled := (AccessLevel <> 2) and (AccessLevel <> 3);
      AccountLevelCombosRefresh;
      cboAccLevel1.LookupValue := qryProductLevels.FieldByName('AccLevel1').AsString;
      cboAccLevel2.LookupValue := qryProductLevels.FieldByName('AccLevel2').AsString;
      cboAccLevel3.LookupValue := qryProductLevels.FieldByName('AccLevel3').AsString;
      AccountLevelCombosRefresh;
      AccountTreeOrder;
      if cboAccLevel1.Enabled then begin
        SetControlFocus(cboAccLevel1);
      end else begin
        SetControlFocus(cmdCancel);
      end;
      TabStS.TabVisible := Appenv.CompanyPrefs.UseSeedtoSale ;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmClass.grdTaxExceptionProductsDblClick(Sender: TObject);
begin
  inherited;
  EditDB(qryDepttaxexceptionproducts);
  qryDepttaxexceptionproductsActive.AsBoolean := True;
  PostDb(qryDepttaxexceptionproducts);

end;

procedure TfrmClass.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  fbClosingForm := true;
  CloseQueries;
  Action := caFree;
  self.RollbackTransaction;
end;

procedure TfrmClass.qryClassAfterInsert(DataSet: TDataSet);
begin
  inherited;
  Dataset.FieldByName('Active').AsBoolean := true;
end;

procedure TfrmClass.qryClassAfterOpen(DataSet: TDataSet);
begin
  inherited;
  Opendb(qryTaxCodes);
  LoadEditedFlagMemTable(qryClass, MemQryClass);
  closedb(qryDepttaxexceptionproducts);
  Opendb(qryDepttaxexceptionproducts);
end;

procedure TfrmClass.AccountLevelCombosRefresh;
var
  AccLvl1, AccLvl2, AccLvl3: string;
begin
  AccLvl1 := cboAccLevel1.Text;
  AccLvl2 := cboAccLevel2.Text;
  AccLvl3 := cboAccLevel3.Text;

  qryAccLevel1.Close;
  qryAccLevel1.ParamByName('CurrentClassID').asInteger := KeyID;
  qryAccLevel1.Open;

  qryAccLevel2.Close;
  qryAccLevel2.ParamByName('SubAcc').asString := AccLvl1;
  qryAccLevel2.ParamByName('CurrentClassID').asInteger := KeyID;
  qryAccLevel2.Open;

  qryAccLevel3.Close;
  qryAccLevel3.ParamByName('SubAcc').asString := AccLvl1 + '^' + AccLvl2;
  qryAccLevel3.ParamByName('CurrentClassID').asInteger := KeyID;
  qryAccLevel3.Open;

  cboAccLevel1.LookupValue := AccLvl1;
  cboAccLevel2.LookupValue := AccLvl2;
  cboAccLevel3.LookupValue := AccLvl3;
end;

procedure TfrmClass.AccountTreeOrder;
var
  Level1: TTreeNode;
  Level2: TTreeNode;
  Level3: TTreeNode;
begin
  if not Empty(cboAccLevel1.Text) then begin
    cboAccLevel2.Enabled := true;
    cboAccLevel3.Enabled := false;
  end else begin
    cboAccLevel2.Text    := '';
    cboAccLevel2.Enabled := false;
  end;

  if not Empty(cboAccLevel2.Text) and not Empty(cboAccLevel1.Text) then begin
    cboAccLevel3.Enabled := true;
  end else begin
    cboAccLevel3.Text    := '';
    cboAccLevel3.Enabled := false;
  end;
  AccountTreeView.Items.Clear;

  if Empty(cboAccLevel1.Text) then begin
    AccountTreeView.Items.Add(nil, edtClassName.Text);
  end else if Empty(cboAccLevel2.Text) then begin
    Level1 := AccountTreeView.Items.Add(nil, cboAccLevel1.Text);
    AccountTreeView.Items.AddChild(Level1, edtClassName.Text);
  end else if Empty(cboAccLevel3.Text) then begin
    Level1 := AccountTreeView.Items.Add(nil, cboAccLevel1.Text);
    Level2 := AccountTreeView.Items.AddChild(Level1, cboAccLevel2.Text);
    AccountTreeView.Items.AddChild(Level2, edtClassName.Text);
  end else begin
    Level1 := AccountTreeView.Items.Add(nil, cboAccLevel1.Text);
    Level2 := AccountTreeView.Items.AddChild(Level1, cboAccLevel2.Text);
    Level3 := AccountTreeView.Items.AddChild(Level2, cboAccLevel3.Text);
    AccountTreeView.Items.AddChild(Level3, edtClassName.Text);
  end;
  AccountTreeView.FullExpand;
  if not (KeyID = 0) then begin
    cboAccLevel1.Enabled   := true;
    cboAccLevel2.Enabled   := true;
    cboAccLevel3.Enabled   := true;
    edtClassName.Enabled := false;
  end;
end;

function TfrmClass.AccountGroupJoin: string;
begin
  if not empty(cboAccLevel1.Text) then begin
    if not empty(cboAccLevel2.Text) then begin
      if not empty(cboAccLevel3.Text) then begin
        Result := cboAccLevel1.Text + '^' + cboAccLevel2.Text + '^' + cboAccLevel3.Text;
      end else begin
        Result := cboAccLevel1.Text + '^' + cboAccLevel2.Text;
      end;
    end else begin
      Result := cboAccLevel1.Text;
    end;
  end else begin
    Result := '';
  end;
end;

procedure TfrmClass.cboAccLevel1Change(Sender: TObject);
begin
  inherited;
  AccountTreeOrder;
end;

procedure TfrmClass.cboAccLevel2Change(Sender: TObject);
begin
  inherited;
  AccountTreeOrder;
end;

procedure TfrmClass.cboAccLevel3Change(Sender: TObject);
begin
  inherited;
  AccountTreeOrder;
end;

procedure TfrmClass.cbobinLocationEnter(Sender: TObject);
begin
  inherited;
  if not(QryBin.active) or (QryBin.parambyname('ClassID').asInteger <> qryClassClassID.asInteger) then begin
    closedb(QryBin);
    opendb(QryBin);
  end;
end;

procedure TfrmClass.cboPrincipleContactCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  editDB(qrystsClass);
  qrystsClassPrincipleContactID.asInteger :=  cboEmployeeLookupEmployeeID.asInteger;
  PostDB(qrystsClass);
end;

procedure TfrmClass.edtClassNameChange(Sender: TObject);
begin
  inherited;
  AccountTreeOrder;
end;

procedure TfrmClass.cboAccLevel1Exit(Sender: TObject);
begin
  inherited;
  AccountLevelCombosRefresh;
end;

procedure TfrmClass.cboAccLevel2Exit(Sender: TObject);
begin
  inherited;
  AccountLevelCombosRefresh;
end;

procedure TfrmClass.chkUseAddressClick(Sender: TObject);
begin
  inherited;
  if chkUseAddress.Checked then begin
    lblAddress1.Enabled      := true;
    lblAddress2.Enabled     := true;
    edtStreet.Enabled   := true;
    chkActive.Enabled    := true;
    edtStreet2.Enabled  := true;
    lblAddress3.Enabled := true;
    edtStreet3.Enabled  := true;
    lblSuburb.Enabled   := true;
    cboSuburb.Enabled   := true;
    lblState.Enabled    := true;
    edtState.Enabled    := true;
    lblPostcode.Enabled := true;
    edtPostcode.Enabled := true;
    lblCountry.Enabled  := true;
    edtCountry.Enabled  := true;
    lblLocationCode.Enabled  := true;
    edtLocationCode.Enabled  := true;
  end else begin
    lblAddress1.Enabled      := false;
    lblAddress2.Enabled     := false;
    edtStreet.Enabled   := false;
    chkActive.Enabled    := false;
    edtStreet2.Enabled  := false;
    lblAddress3.Enabled := false;
    edtStreet3.Enabled  := false;
    lblSuburb.Enabled   := false;
    cboSuburb.Enabled   := false;
    lblState.Enabled    := false;
    edtState.Enabled    := false;
    lblPostcode.Enabled := false;
    edtPostcode.Enabled := false;
    lblCountry.Enabled  := false;
    edtCountry.Enabled  := false;
    lblLocationCode.Enabled  := false;
    edtLocationCode.Enabled  := false;
  end;
end;

procedure TfrmClass.cboSuburbCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  if Modified then begin
    FillTable.Edit;
    FillTable.FieldByName('State').AsString       := LookupTable.FieldByName('State').AsString;
    FillTable.FieldByName('Postcode').AsString    := LookupTable.FieldByName('Postcode').AsString;
    FillTable.FieldByName('Country').asString     := LookupTable.FieldByName('Country').asString;
    FillTable.FieldByName('LocationCode').asString:= LookupTable.FieldByName('Code').asString;
  end;
end;
procedure TfrmClass.cboTaxCodeNotInList(Sender: TObject; LookupTable: TDataSet;
  NewValue: string; var Accept: Boolean);
begin
  inherited;
  accept := false;
  self.NotInListWarning(Sender);
end;

procedure TfrmClass.cboTaxExceptionProductChange(Sender: TObject);
begin
  inherited;
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
end;

procedure TfrmClass.cboTaxExceptionProductCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if not Modified then Exit;
    SaveLastComboAccessed(fLastComboAccessed ,Sender);

end;
procedure TfrmClass.InitPopupform(frmPopup: TBaseInputGUI);
begin
  if frmPopup is TfmbinLocation then begin
    {save to save the new class as binlocation needs to use the class }
    if not savedata then exit;
    CommitTransaction;
    beginTransaction;

    TfmbinLocation(frmPopup).BinlocationCaption := 'Room';
    if Assigned(fLastComboAccessed) and (fLastComboAccessed = cbobinLocation) then begin
      if TfmbinLocation(frmPopup).KeyId = 0 then begin
        TfmbinLocation(frmPopup).MakeBinforClass(qryClassClassID.asInteger ,cbobinLocation.text , '1');
        Exit;
      end;
    end;
  end;
  inherited;
end;
procedure TfrmClass.AftershowPopupform(frmPopup: TBaseInputGUI);
begin
  inherited;
end;
procedure TfrmClass.CommitTransaction;
begin

  With TempMyquery(TERPconnection(Qryclass.connection)) do try
    SQL.Text := 'Select (SELECT DefaultClass FROM tblColumnHeadings) as DefaultClass ,  (Select sitecode from tblmsbackendid where BEDefault="T")  as Defaultsitecode';
    open;
    if Sametext(fieldbyname('DefaultClass').asString , Qryclassclassname.asString) then
      if not (Sametext(fieldByname('Defaultsitecode').asString , QryclasssiteCode.asString)) then begin
        appenv.Branch.SiteCode := QryclasssiteCode.asString;
        With TempMyScript(TERPconnection(Qryclass.connection)) do try
          SQL.Text := 'update tblmsbackendid set sitecode = '+quotedstr(QryclasssiteCode.asString)+' where BEDefault ="T";';
          execute;
        finally
          Free;
        end;
      end;
  finally
    ClosenFree;
  end;

  inherited CommitTransaction;
end;
function TfrmClass.IsDefaultclassforAnyemp(classID:Integer):Boolean;
var
  ds:TERPQuery;
begin
  result:= False;
  ds:= TempMyQuery;
  try
    ds.SQL.text := 'Select employeeName from tblemployees where defaultclassID = '  + inttostr(ClassID) +' order by EmployeeName';
    ds.Open;
    if ds.RecordCount >0 then begin
      result:= True;
      InitMsgParams;
            PopupMsgParams.Msgcaption := 'Warning';
            PopupMsgParams.Msgds := ds;
            PopupMsgParams.fieldnames := 'employeename';
            PopupMsgParams.displayLabels:= 'Employee';
            PopupMsgParams.Custombuttons := 'OK';
            PopupMsgParams.Msg1:= QryclassClassname.AsString + ' is the Default ' + Appenv.DefaultClass.classheading +' for the following Employee(s).';
            PopupMsgParams.Msg2 := 'It is not possible to delete ' + Quotedstr(Qryclassclassname.AsString);
            PopupMsgParams.MsgColor := Self.Color;
            TfmMessageWithList.MsgDlg;
    end;
  finally
    ds.closenFree;
  end;

end;
procedure TfrmClass.PgMainChange(Sender: TObject);
begin
  inherited;
  PostDB(qryClass);
  if qrystsClass.parambyname('ClassID').asInteger<> qryClassClassID.asInteger then begin
    closedb(qrystsClass);
    Opendb(qrystsClass);
  end;
end;

procedure TfrmClass.PgMainChanging(Sender: TObject; var AllowChange: Boolean);
begin
  inherited;
  PostDB(qryClass);
  Allowchange := (pgmain.activePageindex >0) or (qryClassClassID.asInteger <>0);
end;

procedure TfrmClass.PgMainResize(Sender: TObject);
begin
  inherited;
  RealignTabControl(PgMain,1);
end;

procedure TfrmClass.QryBinBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  QryBin.parambyname('ClassID').asInteger := qryClassClassID.asInteger;

end;

procedure TfrmClass.chkActiveClick(Sender: TObject);
begin
  inherited;
  if fbClosingForm then Exit;
  If not qryClass.active then Exit;
  if not chkActive.Checked then begin
    if AppEnv.DefaultClass.ClassID = KeyID then begin
      CommonLib.MessageDlgXP_Vista('This Class is currently set as your default class and may not be made inactive at this time!',
        mtWarning, [mbOK], 0);
      qryClass.Edit;
      qryClass.FieldByName('Active').AsString := 'T';
      Exit;
    end;
  end;
  if Screen.ActiveControl = chkActive then
      if IsDefaultclassforAnyemp(KeyID) then begin
          qryClass.Edit;
          qryClass.FieldByName('Active').AsString := 'T';
          Exit;
      end;
end;

procedure TfrmClass.FormCreate(Sender: TObject);
begin
  inherited;
  InitStsClassMode := False;
  fbClosingForm := false;
  RealignTabControl(PgMain,1);
  chkAutoCreateSmartOrders.Caption := '  Allow the Creation of Smart Orders When '+NL+
                                      '  Converting a Quote to a Sales Order.';
  chkAutoCreateRepairs.Caption     := '  Auto Create Repair when converting  '+NL+
                                      '  Quote to Sales Order.';
end;

procedure TfrmClass.FormResize(Sender: TObject);
begin
  inherited;
  RealignTabControl(PgMain,1);
end;

procedure TfrmClass.SuburbQryBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  SuburbQry.Params.ParamByName('xRegionID').AsInteger := AppEnv.RegionalOptions.ID;
end;

procedure TfrmClass.qryClassAfterPost(DataSet: TDataSet);
begin
  inherited;
  if Dataset.FieldByName('GlobalRef').AsString = '' then begin
    EditDB(Dataset);
    Dataset.FieldByName('GlobalRef').AsString:=
      AppEnv.Branch.SiteCode + Dataset.FieldByName('ClassID').AsString;
    PostDb(Dataset);
  end;
  if qryDepttaxexceptionproducts.parambyname('xDeptID').asInteger <> qryClassClassID.asInteger  then begin
    closedb(qryDepttaxexceptionproducts);
    Opendb(qryDepttaxexceptionproducts);
  end;
end;

procedure TfrmClass.qryClassBeforeClose(DataSet: TDataSet);
begin
  inherited;
  closedb(qryTaxCodes);
end;

procedure TfrmClass.qryClassClassNameChange(Sender: TField);
begin
  inherited;
    if qryClassClassName.asString <> trim(qryClassClassName.asString) then begin
      Editdb(qryClass);
      qryClassClassName.asString :=trim(qryClassClassName.asString) ;
      edtClassName.text :=qryClassClassName.asString ;
      Postdb(qryClass);
      Editdb(qryClass);
    end;
end;

function TfrmClass.ValidateData: boolean;

  function SiteCodeUnique: boolean;
  var qry: TERPQuery;
  begin
    qry:= TERPQuery.Create(nil);
    try
      qry.Connection:= MyConnection;
      qry.SQL.Add('select * from tblclass');
      qry.SQL.Add('where SiteCode = ' + QuotedStr(qryClassSiteCode.AsString));
      qry.SQL.Add('and ClassId <> ' + inttostr(qryClassClassID.asInteger));
      qry.Open;
      result:= qry.IsEmpty;
    finally
      qry.Free;
    end;
  end;

begin
  result:= false;
  if Empty(edtClassName.Text) then begin
    CommonLib.MessageDlgXP_Vista('Class name cannot be blank.', mtInformation, [mbOK], 0);
    SetControlFocus(cboAccLevel1);
    exit;
  end;

  if qryClassSiteCode.AsString = '' then begin
    MessageDlgXP_Vista('Please enter a unique Site Code.',mtInformation,[mbOk],0);
    SetControlFocus(edtSiteCode);
    exit;
  end;

  if (*(qryClassClassID.asinteger > 0) and *)(not SiteCodeUnique) then begin
    MessageDlgXP_Vista('Please enter a unique Site Code for this ' +
      TitleLabel.Caption + '.', mtInformation,[mbOk],0);
    SetControlFocus(edtSiteCode);
    exit;
  end;

  result:= true;
end;

procedure TfrmClass.qryClassSiteCodeSetText(Sender: TField;
  const Text: String);
begin
  inherited;
  Sender.AsString:= Uppercase(Text);
end;

procedure TfrmClass.qryDepttaxexceptionproductsAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qryDepttaxexceptionproductsDeptID.AsInteger   := qryClassClassId.AsInteger;
  qryDepttaxexceptionproductsDeptName.AsString  := qryClassClassname.AsString;
  qryDepttaxexceptionproductsActive.AsBoolean   := True;
end;

procedure TfrmClass.arambyn(DataSet: TDataSet);
begin
  inherited;
  qryDepttaxexceptionproducts.parambyname('xDeptID').asInteger :=qryClassClassID.asInteger ;
end;

procedure TfrmClass.qryDepttaxexceptionproductsBeforePost(DataSet: TDataSet);
begin
  inherited;
  if (qryDepttaxexceptionproductsDeptID.AsInteger =0) or (qryDepttaxexceptionproductsProductId.AsInteger =0) then begin
    qryDepttaxexceptionproducts.Cancel;
    abort;
  end;

end;

procedure TfrmClass.qrystsClassAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qrystsClassClassId.asInteger := qryClassClassID.asInteger;
end;

procedure TfrmClass.qrystsClassBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qrystsClass.parambyname('ClassID').asInteger:= qryClassClassID.asInteger;
end;

procedure TfrmClass.qryTaxCodesBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryTaxCodes.ParamByName('RegionID').asInteger             := AppEnv.RegionalOptions.ID;
(*  qryTaxCodes.ParamByName('Clientcountry').asString         := qryClassCountry.asString;
  qryTaxCodes.ParamByName('ClientState').asString           := qryClassState.AsString;
  qryTaxCodes.ParamByName('clientLocation').asString        := qryClassSuburb.asString;
  qryTaxCodes.ParamByName('ClientPostcode').asString        := qryClassPostcode.asString;*)
end;

function TfrmClass.SaveData: boolean;
var
  msg: string;
begin
  result:= ValidateData;
  if not result then exit;
  PostDB(qrystsClass);
  if not (qryClass.State in [dsBrowse]) then begin
    qryClass.FieldByName('ClassGroup').AsString := AccountGroupJoin;
    ProcessEditedFlag('Main', Self, memQryClass, QryClass, nil);
    qryClass.Edit;
    qryClass.Post;
    if KeyId = 0 then KeyId:= qryClass.FieldByname('ClassID').asInteger;
  end;
  if qryClassActive.asBoolean =False then begin
      With CommonDbLib.TempMyQuery do try
        SQL.add('Select * from tblpartsclasspreferences where classname = ' +quotedStr(qryClassClassName.asString));
        open;
        if recordcount > 0 then begin
          if not TDeletedItem.AddDeleted('tblpartsclasspreferences','',FieldByName('GlobalRef').AsString, FieldByName('ID').AsInteger,MyConnection,msg) then begin
            result := false;
            MessageDlgXP_Vista('Could not delete Parts Class Preference ' + FieldByName('GlobalRef').AsString + ': ' + msg,mtWarning,[mbOk],0);
          end;

        end;
      finally
          if active then Close;
          free;
      end;
  end;
  if REsult then
    if InitStsClassMode then begin
      PostDB(qrystsClass);
      if qrystsClass.recordcount =0 then begin
        REsult := False;
        MessageDlgXP_Vista('Please Provide the Seed To Sale Details', mtWarning, [mbOK], 0);
        pgmain.activePageindex:= 1;
        SetcontrolFocus(cboPrincipleContact);
      end;
    end;
end;

initialization
  RegisterClassOnce(TfrmClass);
  with FormFact do begin
    RegisterMe(TfrmClass, 'TClassListGUI_*=ClassID');
    RegisterMe(TfrmClass, 'TStSClassListGUI_*=ClassID');
    RegisterMe(TfrmClass, 'TClassExpressListGUI_*=ClassID');
    RegisterMe(TfrmClass, 'TAppointmentListGUI_ClassName=ClassID');
    RegisterMe(TfrmClass, 'TSalesReportGUI_Class Name_Invoice=ClassID');
    RegisterMe(TfrmClass, 'TSalesReportGUI_Class Name_Cash Sale=ClassID');
    RegisterMe(TfrmClass, 'TSalesReportGUI_Class Name_Refund=ClassID');
    RegisterMe(TfrmClass, 'TSalesReportGUI_Class Name_POS=ClassID');
    RegisterMe(TfrmClass, 'TSalesReportGUI_Class Name_Unknown=ClassID');
    RegisterControl(TfrmClass, '*_cboClass=ClassID');
    RegisterControl(TfrmClass, '*_cboDepartment=ClassID');
    RegisterControl(TfrmClass, '*_cboClassFrom=ClassID');
    RegisterControl(TfrmClass, '*_cboClassTo=ClassID');
    RegisterControl(TfrmClass, '*_cboClassName=ClassID');
    RegisterControl(TfrmClass, 'TfrmParts_cboGotoClassQty=ClassID'); // :-o

  end;
end.
