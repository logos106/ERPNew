unit PriceListForm;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 05/08/05  1.00.01 DSP  Added 'Special Products' and 'Group Discount'
                        information into the list.
 08/09/05  1.00.01 DSP  Added 'Permanent Discount', 'Special Product Discount'
                        and the normal price of all products.
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, wwdblook, wwcheckbox, MemDS, wwExport,
  DBAccess, MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog,
  Shader, kbmMemTable, DAScript, MyScript, CustomInputBox, frmReportingOptions,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TfrmPriceListGUI = class(TBaseListingGUI)
    qryClientTypes: TERPQuery;
    Panel4: TPanel;
    lblClassTitle: TLabel;
    Label4: TLabel;
    chkAllTypes: TwwCheckBox;
    cboClientType: TwwDBLookupCombo;
    qryMainCategory: TIntegerField;
    qryMainDetails: TIntegerField;
    qryMainPriceType: TWideStringField;
    qryMainProductBarCode: TWideStringField;
    qryMainPartsID: TIntegerField;
    qryMainClientId: TIntegerField;
    qryMainDiscount: TFloatField;
    qryMainPrice: TFloatField;
    qryMainUOM: TWideStringField;
    qryMainAllClients: TWideStringField;
    qryMainDateTo: TDateField;
    qryMainDateFrom: TDateField;
    qryMainExtraSellDesc: TWideStringField;
    qryMainPartname: TWideStringField;
    qryMainPartDescription: TWideStringField;
    qryMainCustomerType: TWideStringField;
    qryMainClientName: TWideStringField;
    qryMainLinePrice: TFloatField;
    qryMainOriginalPrice: TFloatField;
    qryMainProductcost: TFloatField;
    qryMainUsedInRun: TWideStringField;
    qryMainDiscountPercent: TFloatField;
    qryMainCol1: TWideStringField;
    qryMainCol2: TWideStringField;
    qryMainCol3: TWideStringField;
    qryMainPermanentDiscount: TFloatField;
    qryMainSpecialProductDiscount: TFloatField;
    chkHideInactiveProduct: TCheckBox;
    ChkhidesystemProducts: TCheckBox;
    chkhide0PricedProducts: TCheckBox;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    ExtraQuery: TERPQuery;
    qryWork: TERPQuery;
    qryMainProductPrintName: TWideStringField;
    btnPricelist: TDNMSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure chkAllTypesClick(Sender: TObject);
    procedure cboClientTypeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdMainEnter(Sender: TObject);
    procedure grdMainColEnter(Sender: TObject);
    procedure grdMainRowChanged(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormDestroy(Sender: TObject);
    procedure chkHideInactiveProductClick(Sender: TObject);
    procedure qryClientTypesBeforeOpen(DataSet: TDataSet);
    procedure HTMLExportClick(Sender: TObject);
    procedure cmdExportOptClick(Sender: TObject);
    procedure btnPricelistClick(Sender: TObject);

  private
    { Private declarations }
    iClientTypeID: integer;
    iCustomerID: integer;
    Tablename :String;
    fbCustomerPriceList: Boolean;
    Function FieldDescription(AFieldName: String;Transtype:String = ''):String;
    Procedure DisplayHint;
    procedure setCustomerID(const Value: integer);
    Procedure PopulateTempTable;
    function Pricetype: String;
    procedure InitPriceList(Sender: TObject);
  protected
    procedure RefreshQuery; override;
    procedure PopulateFilterCombo; override;
    Procedure ApplySpecialformfilter; Override;
    procedure SetGridColumns; Override;
    Procedure ShowControlhints;Override;
    procedure AfterPopup(Popupform:TComponent);Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    // Exports
    procedure DowwHtml(Sender : TObject);
    procedure DowwExportSYLK(Sender : TObject);
    procedure DowwExportTExt(Sender : TObject);
    procedure DowwExportCSV(Sender : TObject);
    procedure DowwExport(aExportType : TwwGridExportType;  aCSV : boolean = false);

    procedure BuildMainScript;
    procedure BuildMainScriptTail;

   // HTML Export
    function GetExtraFieldCount : integer;
    function GetExtraName(idx : integer) : string;
    function GetExtraData (idx, LinkId : integer) : TField;
    function GetExtraFileName(idx, LinkId : integer) : string;
  public
    { Public declarations }
    property ClientTypeID: integer read iClientTypeID write iClientTypeID;
    property CustomerID: integer read iCustomerID write setCustomerID;
    Property CustomerPriceList :Boolean read fbCustomerPriceList write fbCustomerPriceList;
  end;

implementation

uses
   AppEnvironment, CommonLib, FastFuncs, DefaultClassObj, ProductQtyLib,
  CommonDbLib, LogLib, tcConst, frmPartsFrm, frmCustomerFrm, HTMLExport,
  CommonFormLib, CustomerPriceListList;

{$R *.dfm}

procedure TfrmPriceListGUI.FormShow(Sender: TObject);
begin
  inherited;
  qryClientTypes.Open;
  if iClientTypeID<>0 then begin
    if qryClientTypes.Locate('ClientTypeID', iClientTypeID, [loCaseInsensitive]) then begin
      chkAllTypes.Checked := false;
      cboClientType.Text := qryClientTypes.FieldByName('TypeName').AsString;
    end;
  end else begin
    chkAllTypes.Checked := True;
  end;
  RefreshQuery;
end;

function TfrmPriceListGUI.GetExtraData(idx, linkId : integer): TField;
begin
  Result := nil;
  if ExtraQuery.State <> dsBrowse then
    exit;
  if ExtraQuery.RecordCount = 0 then
    exit;
  if not ExtraQuery.Locate('PartsId', linkId, [loCaseInsensitive]) then
    exit;
  // Only one field, so no idx analysis
  Result := ExtraQuery.FieldByName('PartPic');
end;

function TfrmPriceListGUI.GetExtraFieldCount: integer;
begin
  if ExtraQuery.State <> dsBrowse then
    Result := 0
  else
    Result := 1;  // one picture, that's all
end;

function TfrmPriceListGUI.GetExtraName(idx : integer): string;
begin
  // Only one field, so no idx analysis
  Result := 'Image';
end;

function TfrmPriceListGUI.GetExtraFileName(idx, linkId: integer): string;
begin
  Result := '';
  if ExtraQuery.State <> dsBrowse then
    exit;
  if ExtraQuery.RecordCount = 0 then
    exit;
  if not ExtraQuery.Locate('PartsId', linkId, [loCaseInsensitive]) then
    exit;
  // Only one field, so no idx analysis
  Result := ExtraQuery.FieldByName('PicName').AsString + '.' + ExtraQuery.FieldByName('PicType').AsString;
  Result := StringReplace(Result, ' ', '_', [rfReplaceAll, rfIgnoreCase]);
end;

procedure TfrmPriceListGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  opendb(qryClientTypes);
  if GuiPrefs.Node.Exists('Options.hidesystemProducts')  then ChkhidesystemProducts.checked  :=  GuiPrefs.Node['Options.hidesystemProducts'].AsBoolean;
  if GuiPrefs.Node.Exists('Options.hide0PricedProducts') then chkhide0PricedProducts.checked :=  GuiPrefs.Node['Options.hide0PricedProducts'].AsBoolean;
  if GuiPrefs.Node.Exists('Options.HideInactiveProduct') then chkHideInactiveProduct.checked :=  GuiPrefs.Node['Options.HideInactiveProduct'].AsBoolean;
  if GuiPrefs.Node.Exists('Options.AllTypes')            then chkAllTypes.checked            :=  GuiPrefs.Node['Options.AllTypes'].AsBoolean;
end;

procedure TfrmPriceListGUI.RefreshQuery;
begin
  closeDb(Qrymain);
  PopulateTempTable;
  inherited;
end;

procedure TfrmPriceListGUI.chkAllTypesClick(Sender: TObject);
var
  qry: TERPQuery;
begin
  inherited;
  OPENDB(qryClientTypes);
  if chkAllTypes.Checked then begin
    cboClientType.Enabled := false;
  end else begin
    cboClientType.Enabled := true;
    if cboClientType.text= '' then begin
      qryClientTypes.first;
      cboClientType.Text := qryClientTypes.FieldByName('TypeName').AsString;
    end;
  end;
  ChkhidesystemProducts.Enabled := chkAllTypes.Checked;
  chkhide0PricedProducts.Enabled := chkAllTypes.Checked;
  chkHideInactiveProduct.Enabled := chkAllTypes.Checked;
  RefreshQuery;
  if (CustomerID > 0) and (not chkAllTypes.Checked) then begin
    qry := TERPQuery.Create(nil);
    try
      qry.Connection := qryMain.Connection;
      qry.SQL.Text := 'select Company from tblClients where ClientID = ' + IntToStr(CustomerID);
      qry.Open;
      TitleLabel.Caption := qry.FieldByName('Company').AsString + ' Price List';
    finally
      qry.Free;
    end;
  end
  else begin
    TitleLabel.Caption := 'Customer Type Price List';
  end;
end;

procedure TfrmPriceListGUI.chkHideInactiveProductClick(Sender: TObject);
begin
  inherited;
  if Screen.activecontrol = Sender then
    RefreshQuery;
end;

procedure TfrmPriceListGUI.cmdExportOptClick(Sender: TObject);
var
  OptsForm: TfmReportingOptions;
begin
  if qryMain.RecordCount = 0 then
    exit;

  OptsForm := TfmReportingOptions.Create(nil);
  try

    OptsForm.ActionList.AddDivider('Export');
    OptsForm.ActionList.Add('Text File', 'Export List to a Text File', DowwExportText, false, true);
    OptsForm.ActionList.Add('CSV File', 'Export List to a CSV file', DowwExportCSV, false, true);
    OptsForm.ActionList.Add('SYLK File', 'Export List to a SYLK File', DowwExportSYLK, false, true);

    OptsForm.ActionList.AddDivider('HTML');
    OptsForm.ActionList.Add('HTML Price List', 'Export Grid with Correspondent Images', HTMLExportClick, false, true);
    OptsForm.ActionList.Add('Plain HTML', 'Export Grid as it is', DowwHTML, false, true);


    OptsForm.ShowModal;
  finally
    OptsForm.Free;
  end;

end;

procedure TfrmPriceListGUI.cboClientTypeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  RefreshQuery;
end;

procedure TfrmPriceListGUI.FormCreate(Sender: TObject);
begin
  fbCustomerPriceList := False;
  Tablename := commondblib.GetUserTemporaryTableName('Pricelist');
  Qrymain.SQl.clear;
  Qrymain.SQl.Add('Select');
  Qrymain.SQl.Add(' * ');
  Qrymain.SQl.Add('from '+Tablename+' ');
  Qrymain.SQl.Add('ORDER BY Pricetype , Details, PriceType, "PartDescription"	');
  inherited;
  BaseIndexfields:= 'Category,Details';
end;

procedure TfrmPriceListGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(Tablename);
  inherited;
end;

procedure TfrmPriceListGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfrmPriceListGUI.PopulateFilterCombo;
begin
  grdMain.ColumnByName('Col1').DisplayLabel := AppEnv.DefaultClass.FirstColumn;
  grdMain.ColumnByName('Col2').DisplayLabel := AppEnv.DefaultClass.SecondColumn;
  grdMain.ColumnByName('Col3').DisplayLabel := AppEnv.DefaultClass.ThirdColumn;
  inherited;
end;

Function TfrmPriceListGUI.FieldDescription(AFieldName: String;Transtype:String = ''):String;
  Procedure AddResult(Const Value:STring);
  begin
      if result <> '' then result := result +chr(13)+chr(13);
      result := result +Value;
  end;
begin
  REsult := '';
  if qryMainDetails.asInteger = 1 then exit;
  if (Sysutils.SameText(AFieldName ,'AllClients'))             and ((TransType = '') or (TRansType = 'Extra Sell'))        then begin AddResult('Extra Sell Price: Applicable to All clients or Selected Customer Type.'+chr(13)+'Product Form :Extra Sell Price Tab'); End;
  if (Sysutils.SameText(AFieldName ,'AllClients'))             and ((TransType = '') or (TRansType = 'Normal Price'))      then begin AddResult('Normal Price: True Allways'); End;
  if (Sysutils.SameText(AFieldName ,'DateTo'))                 and ((TransType = '') or (TRansType = 'Extra Sell'))        then begin AddResult('Extra Sell Price: Applicable for a Date Range.'+chr(13)+'Product Form :Extra Sell Price Tab'); End;
  if (Sysutils.SameText(AFieldName ,'DateFrom'))               and ((TransType = '') or (TRansType = 'Extra Sell'))        then begin AddResult('Extra Sell Price: Applicable for a Date Range.'+chr(13)+'Product Form :Extra Sell Price Tab'); End;
  if (Sysutils.SameText(AFieldName ,'ExtraSellDesc'))          and ((TransType = '') or (TRansType = 'Extra Sell'))        then begin AddResult('Extra Sell Price: Description.'+chr(13)+'Product Form :Extra Sell Price Tab'); End;

  if (Sysutils.SameText(AFieldName ,'LinePrice'))              and ((TransType = '') or (TRansType = 'Special Products'))  then begin AddResult('Special Products: Customer''s Special Product Discount.'+chr(13)+'Customer Form :Discount Tab'); End;
  if (Sysutils.SameText(AFieldName ,'LinePrice'))              and ((TransType = '') or (TRansType = 'Normal Price'))      then begin AddResult('Normal Price: Product''s Price1 (Inc).'+chr(13)+'Product Form :Main Tab'); End;


  if (Sysutils.SameText(AFieldName ,'Original Price'))          and ((TransType = '') or (TRansType = 'Extra Sell'))        then begin AddResult('Extra Sell Price: Product Price Before Discount.'+chr(13)+'Product Form :Main Tab'); End;
  if (Sysutils.SameText(AFieldName ,'Original Price'))          and ((TransType = '') or (TRansType = 'Special Products'))  then begin AddResult('Special Products: Product Price Before Discount.'+chr(13)+'Customer Form :Discount Tab'); End;
  if (Sysutils.SameText(AFieldName ,'Original Price'))          and ((TransType = '') or (TRansType = 'Normal Price'))      then begin AddResult('Normal Price: Product Price Before Discount.'+chr(13)+'Product Form :Main Tab'); End;

  if (Sysutils.SameText(AFieldName ,'CustomerType'))           and ((TransType = '') or (TRansType = 'Extra Sell'))        then begin AddResult('Extra Sell Price: Discount Applicable for Selected Customer Type.'+chr(13)+'Product Form :Extra Sell Price Tab'); End;
  if (Sysutils.SameText(AFieldName ,'CustomerType'))           and ((TransType = '') or (TRansType = 'Special Products'))  then begin AddResult('Special Products: Type of the Customer with the Special Discount.'+chr(13)+'Customer Form :Discount Tab'); End;
  if (Sysutils.SameText(AFieldName ,'CustomerType'))           and ((TransType = '') or (TRansType = 'Group Discount'))    then begin AddResult('Group Discount: Type of the Customer with the Group Discount.'+chr(13)+'Customer Form :Discount Tab'); End;

  if (Sysutils.SameText(AFieldName ,'DiscountPercent'))        and ((TransType = '') or (TRansType = 'Extra Sell'))        then begin AddResult('Extra Sell:Product''s Extra Sell Price Discount Percentage.'+chr(13)+'Product Form :Extra Sell Price Tab'); End;
  if (Sysutils.SameText(AFieldName ,'Price'))                  and ((TransType = '') or (TRansType = 'Extra Sell'))        then begin AddResult('Extra Sell:Product''s Extra Sell Price Discount Amount.'+chr(13)+'Product Form :Extra Sell Price Tab'); End;
  if (Sysutils.SameText(AFieldName ,'UOM'))                    and ((TransType = '') or (TRansType = 'Extra Sell'))        then begin AddResult('Extra Sell:Product''s Extra Sell Price Discount For Selected Unit Of Meassure.'+chr(13)+'Product Form :Extra Sell Price Tab'); End;

  if (Sysutils.SameText(AFieldName ,'Discount %'))               and ((TransType = '') or (TRansType = 'Group Discount'))    then begin AddResult('Group Discount:Customer''s Group Discount Percentage.'+chr(13)+'Customer Form :Discount Tab'); End;
  if (Sysutils.SameText(AFieldName ,'Permanent Discount'))      and ((TransType = '') or (TRansType = 'General Discounts')) then begin AddResult('General Discounts:Permanet Discount for a Customer.'+chr(13)+'Customer Form :Discount Tab'); End;
  if (Sysutils.SameText(AFieldName ,'Special Product Discount')) and ((TransType = '') or (TRansType = 'General Discounts')) then begin AddResult('General Discounts:Special Discount for a Customer for Selected Products.'+chr(13)+'Customer Form :Discount Tab'); End;

  if (Sysutils.SameText(AFieldName ,'Col1'))                   and (not(Sysutils.SameText(TransType , 'General Discounts'))) then begin AddResult('Product''s ' + AppEnv.DefaultClass.FirstColumn+'.'+chr(13)+'Product Form :Main Tab'); End;
  if (Sysutils.SameText(AFieldName ,'Col2'))                   and (not(Sysutils.SameText(TransType , 'General Discounts'))) then begin AddResult('Product''s ' + AppEnv.DefaultClass.SecondColumn+'.'+chr(13)+'Product Form :Main Tab'); End;
  if (Sysutils.SameText(AFieldName ,'Col3'))                   and (not(Sysutils.SameText(TransType , 'General Discounts'))) then begin AddResult('Product''s ' + AppEnv.DefaultClass.ThirdColumn+'.'+chr(13)+'Product Form :Main Tab'); End;
  if (Sysutils.SameText(AFieldName ,'Partname'))               and (not(Sysutils.SameText(TransType , 'General Discounts'))) then begin AddResult('Name of the Product'); End;
  if (Sysutils.SameText(AFieldName ,'ProductPrintName'))       and (not(Sysutils.SameText(TransType , 'General Discounts'))) then begin AddResult(AppEnv.CompanyPrefs.ProductPrintNameHeading); End;
  if (Sysutils.SameText(AFieldName ,'PartDescription'))        and (not(Sysutils.SameText(TransType , 'General Discounts'))) then begin AddResult('Product Description'); End;
end;

procedure TfrmPriceListGUI.grdMainEnter(Sender: TObject);
begin
  inherited;
  DisplayHint;
end;

procedure TfrmPriceListGUI.grdMainColEnter(Sender: TObject);
begin
  inherited;
  DisplayHint;
end;

procedure TfrmPriceListGUI.grdMainRowChanged(Sender: TObject);
begin
  inherited;
  DisplayHint;
end;

procedure TfrmPriceListGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Category' , ['1','2','3','4','5','']);
  inherited;
end;

procedure TfrmPriceListGUI.HTMLExportClick(Sender: TObject);
var
  lHtml : THTMLExport;
  lSql : string;
begin
  lSql := 'SELECT TT.PartsId, TT.PartName as PicName, PP.PicType, PP.PartPic FROM ' + tableName + ' TT ' +
          'inner join tblpartspics PP on TT.PartsId = PP.PartId';
  ExtraQuery.SQL.Text := lSQL;
  ExtraQuery.Open;

  lHTML := THTMLExport.Create(grdMain);
  try
    lHtml.LinkField := 'PartsId';   // ExtraQuery and qryMain will be linked on PartsID
    lHtml.OnGetExtraColumnCount := GetExtraFieldCount;
    lHtml.OnGetExtraColumnName := GetExtraName;
    lHtml.OnGetExtraColumnData := GetExtraData;
    lHtml.OnGetExtraFileName := GetExtraFileName;
    lHtml.Execute;
  finally
    lHtml.Free;
  end;
end;

procedure TfrmPriceListGUI.PopulateTempTable;
begin

//  try
    BuildMainScript;

    clog(SCriptMAin.SQL.Text);
    DoShowProgressbar(ScriptMain.SQL.Count ,  WAITMSG);
    try
      ScriptMain.Execute;

      BuildMainScriptTail;
      ScriptMain.Execute;
    finally
      DoHideProgressbar;
    end;
//  finally
//    SCriptMain.SQl.Clear;
//  end;
end;

procedure TfrmPriceListGUI.DisplayHint;
begin
  TimerMsg(lblDateComments ,  FieldDescription(grdmain.getactiveField.FieldName , Trim(QrymainPriceType.asString)));
end;

procedure TfrmPriceListGUI.DowwExport(aExportType: TwwGridExportType; aCSV : boolean = false);
begin
  dlgSave.Title := 'Export - ' + Caption;
  case aExportType of
    wwgetTxt: if aCsv then
                dlgSave.Filter := 'Comma Separated File|*.csv'
              else
                dlgSave.Filter := 'Tab Delimited Text File|*.txt';
    wwgetHTML: dlgSave.Filter := 'HTML File|*.htm;*.html';
    wwgetSYLK: dlgSave.Filter := 'SYLK File|*.slk';
  end;

  if dlgSave.FileName <> '' then
  begin
    case aExportType of
      wwgetTxt: if aCSV then
                  dlgSave.FileName := ChangeFileExt(dlgSave.FileName, '.csv')
                else
                  dlgSave.FileName := ChangeFileExt(dlgSave.FileName, '.txt');
      wwgetHTML: dlgSave.FileName := ChangeFileExt(dlgSave.FileName, '.html');
      wwgetSYLK: dlgSave.FileName := ChangeFileExt(dlgSave.FileName, '.slk');
      else
        exit;
    end;
  end;

  if dlgSave.Execute then begin
    grdMain.ExportOptions.FileName := dlgSave.FileName;
    grdMain.ExportOptions.TitleName := Self.Caption;
    case aExportType of
      wwgetTxt: begin
                  grdMain.ExportOptions.ExportType := wwgetTxt;
                  if aCsv then
                    grdMain.ExportOptions.Delimiter := ','
                  else
                    grdMain.ExportOptions.Delimiter := #9;
                end;
      else
               grdMain.ExportOptions.ExportType := aExportType;
    end;
    enabled := false;
    ExportDialog.Caption := 'Exporting ' + ReplaceStr(TitleLabel.Caption, '&&', '&');
    ExportDialog.Execute;
    try
      try
        grdMain.ExportOptions.Save;
      except
        on e: EFCreateError do begin
          CommonLib.MessageDlgXP_Vista(e.Message, mtWarning, [mbOK], 0);
        end;
      end;
    finally
      enabled := True;
      ExportDialog.CloseDialog;
    end;
  end;
end;

procedure TfrmPriceListGUI.DowwExportCSV(Sender: TObject);
begin
  DowwExport(wwgetTxt, true);
end;

procedure TfrmPriceListGUI.DowwExportSYLK(Sender: TObject);
begin
  DowwExport(wwGetSYLK);
end;

procedure TfrmPriceListGUI.DowwExportTExt(Sender: TObject);
begin
  DowwExport(wwgetTxt);
end;

procedure TfrmPriceListGUI.DowwHtml(Sender: TObject);
begin
  DowwExport(wwgetHtml);
end;

procedure TfrmPriceListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  Afont.color := clBlack;
  if Sysutils.SameText(PriceType, 'Extra Sell') then begin
    if  (qryMainDetails.asInteger = 1) OR (SameText(Field.Fieldname , QrymainPriceType.fieldname) or
        SameText(Field.Fieldname , QrymainProductBarCode.fieldname) or
        SameText(Field.Fieldname , QrymainDiscount.fieldname) or
        SameText(Field.Fieldname , QrymainPrice.fieldname) or
        SameText(Field.Fieldname , QrymainUOM.fieldname) or
        SameText(Field.Fieldname , QrymainAllClients.fieldname) or
        SameText(Field.Fieldname , QrymainDateTo.fieldname) or
        SameText(Field.Fieldname , QrymainDateFrom.fieldname) or
        SameText(Field.Fieldname , QrymainExtraSellDesc.fieldname) or
        SameText(Field.Fieldname , QrymainPartname.fieldname) or
        SameText(Field.Fieldname , QrymainProductPrintName.fieldname) or
        SameText(Field.Fieldname , QrymainPartDescription.fieldname) or
        SameText(Field.Fieldname , QrymainCustomerType.fieldname) or
        SameText(Field.Fieldname , QrymainOriginalPrice.fieldname) or
        SameText(Field.Fieldname , QrymainProductcost.fieldname) or
        SameText(Field.Fieldname , QrymainCol1.fieldname) or
        SameText(Field.Fieldname , QrymainCol2.fieldname) or
        SameText(Field.Fieldname , QrymainCol3.fieldname)) then
        ABrush.Color := GridColhighLightGreen
        else Afont.color := ABrush.color;
  end else if Sysutils.SameText(PriceType, 'Special Products') then begin
    if  (qryMainDetails.asInteger = 1) OR (SameText(Field.Fieldname , QrymainPriceType.fieldname) or
        SameText(Field.Fieldname , QrymainProductBarCode.fieldname) or
        SameText(Field.Fieldname , QrymainPartname.fieldname) or
        SameText(Field.Fieldname , QrymainProductPrintName.fieldname) or
        SameText(Field.Fieldname , QrymainPartDescription.fieldname) or
        SameText(Field.Fieldname , QrymainClientName.fieldname) or
        SameText(Field.Fieldname , QrymainLinePrice.fieldname) or
        SameText(Field.Fieldname , QrymainOriginalPrice.fieldname) or
        SameText(Field.Fieldname , QrymainProductcost.fieldname) or
        SameText(Field.Fieldname , QrymainUsedInRun.fieldname) or
        SameText(Field.Fieldname , QrymainCol1.fieldname) or
        SameText(Field.Fieldname , QrymainCol2.fieldname) or
        SameText(Field.Fieldname , QrymainCol3.fieldname)) then
        ABrush.Color := GridColhighLightYellow1
        else Afont.color := ABrush.color;
  end else if Sysutils.SameText(PriceType, 'Group Discount') then begin
    if  (qryMainDetails.asInteger = 1) OR (SameText(Field.Fieldname , QrymainPriceType.fieldname) or
        SameText(Field.Fieldname , QrymainProductBarCode.fieldname) or
        SameText(Field.Fieldname , QrymainPartname.fieldname) or
        SameText(Field.Fieldname , QrymainProductPrintName.fieldname) or
        SameText(Field.Fieldname , QrymainPartDescription.fieldname) or
        SameText(Field.Fieldname , QrymainLinePrice.fieldname) or
        SameText(Field.Fieldname , QrymainOriginalPrice.fieldname) or
        SameText(Field.Fieldname , QrymainProductcost.fieldname) or
        SameText(Field.Fieldname , QrymainClientName.fieldname) or
        SameText(Field.Fieldname , QrymainDiscountPercent.fieldname) or
        SameText(Field.Fieldname , QrymainCol1.fieldname) or
        SameText(Field.Fieldname , QrymainCol2.fieldname) or
        SameText(Field.Fieldname , QrymainCol3.fieldname)) then
        ABrush.Color := GridColhighLightBlue
        else Afont.color := ABrush.color;
  end else if Sysutils.SameText(PriceType, 'General Discounts') then begin
    if  (qryMainDetails.asInteger = 1) OR (SameText(Field.Fieldname , QrymainPriceType.fieldname) or
        SameText(Field.Fieldname , QrymainProductBarCode.fieldname) or
        SameText(Field.Fieldname , QrymainClientName.fieldname) or
        SameText(Field.Fieldname , QrymainPermanentDiscount.fieldname) or
        SameText(Field.Fieldname , QrymainSpecialProductDiscount.fieldname)) then
        ABrush.Color := GridColhighLightRed
        else Afont.color := ABrush.color;
  end else if Sysutils.SameText(PriceType, 'Normal Price') then begin
    if  (qryMainDetails.asInteger = 1) OR (SameText(Field.Fieldname , QrymainPriceType.fieldname) or
        SameText(Field.Fieldname , QrymainProductBarCode.fieldname) or
        SameText(Field.Fieldname , QrymainPartname.fieldname) or
        SameText(Field.Fieldname , QrymainProductPrintName.fieldname) or
        SameText(Field.Fieldname , QrymainPartDescription.fieldname) or
        SameText(Field.Fieldname , QrymainOriginalPrice.fieldname) or
        SameText(Field.Fieldname , QrymainProductcost.fieldname) or
        SameText(Field.Fieldname , QrymainCol1.fieldname) or
        SameText(Field.Fieldname , QrymainCol2.fieldname) or
        SameText(Field.Fieldname , QrymainCol3.fieldname)) then
        ABrush.Color := GridColhighLightOrange
        else Afont.color := ABrush.color;
  end;
  if qryMainDetails.asInteger = 1 then begin
    if Sysutils.SameText(Field.Fieldname , 'PriceType') then begin
      AFont.Style := AFont.Style + [fsBold];
    end else begin
      AFont.color := ABrush.color;
    end;
  end else if (qryMainDetails.asInteger = 2) and (Sysutils.SameText(Field.Fieldname , 'PriceType') ) then begin
      AFont.color := ABrush.color;
  end ;


end;

procedure TfrmPriceListGUI.AfterPopup(Popupform: TComponent);
begin
  inherited;

  if Sysutils.SameText(PriceType, 'Extra Sell') then begin
      if not(Popupform is TfrmParts) then exit;
      TfrmParts(Popupform).SetPagefocus(TfrmParts(Popupform).Pagecontrol ,TfrmParts(Popupform).Extra_Sell_Price ,nil);
      TfrmParts(Popupform).SetPagefocus(TfrmParts(Popupform).PageControlsellprice ,TfrmParts(Popupform).TabExtraSellPrice ,TfrmParts(Popupform).grdSellPrices);
  end else if Sysutils.SameText(PriceType, 'Special Products') then begin
    if not(Popupform is TfrmCustomer) then exit;
    TfrmParts(Popupform).SetPagefocus(TfrmCustomer(Popupform).TabCtl20 ,TfrmCustomer(Popupform).SpecialProds ,TfrmCustomer(Popupform).grdSpecials);
  end else if Sysutils.SameText(PriceType, 'Group Discount') then begin
    if not(Popupform is TfrmCustomer) then exit;
    TfrmParts(Popupform).SetPagefocus(TfrmCustomer(Popupform).TabCtl20 ,TfrmCustomer(Popupform).SpecialProds ,TfrmCustomer(Popupform).grdProdGroupDiscs);
  end else if Sysutils.SameText(PriceType, 'General Discounts') then begin
    if not(Popupform is TfrmCustomer) then exit;
    TfrmParts(Popupform).SetPagefocus(TfrmCustomer(Popupform).TabCtl20 ,TfrmCustomer(Popupform).SpecialProds ,TfrmCustomer(Popupform).edtDisc);
  end else if Sysutils.SameText(PriceType, 'Normal Price') then begin
    if not(Popupform is TfrmParts) then exit;
    TfrmParts(Popupform).SetPagefocus(TfrmParts(Popupform).Pagecontrol ,TfrmParts(Popupform).Main ,TfrmParts(Popupform).txtRetailPrice);
  end;
end;
Function TfrmPriceListGUI.Pricetype :String;
begin
  result:= Trim(QryMainPricetype.asString);
end;
procedure TfrmPriceListGUI.qryClientTypesBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  if qryClientTypes.connection = nil then
    qryClientTypes.connection := Qrymain.connection;
end;

procedure TfrmPriceListGUI.ApplySpecialformfilter;
begin
  inherited;
  if CustomFilterString <> '' then
    CustomFilterString := '(' +CustomFilterString+') or ( Details = 1)'
end;

procedure TfrmPriceListGUI.btnPricelistClick(Sender: TObject);
begin
  inherited;
  if CustomerPriceList then Appenv.Employee.CustomerPriceLsitOption := 1;
  OpenERPListForm('TCustomerPriceListGUI' , InitPriceList);
  Self.closewait;
end;
procedure TfrmPriceListGUI.InitPriceList(Sender: TObject);
begin
  if not(sender is TCustomerPriceListGUI) then exit;
  TCustomerPriceListGUI(Sender).CustomerTypeID  := ClientTypeID;
  TCustomerPriceListGUI(Sender).CustomerID := CustomerID ;
  TCustomerPriceListGUI(Sender).CustomerPriceList := CustomerPriceList;
end;

procedure TfrmPriceListGUI.BuildMainScript;
  Function Filterdata(CusIDField, typeIDgield: String; ExtraWhere: String = ''): String;
  begin
    result := '';
    if CusIDField <> '' then begin
        if CustomerID <>0 then begin
          if result <> '' then result := result +' and ' else result := ' where ';
          result := result + CusIDField +' = '+ inttostr(CustomerID);
        end;
    end;
    if typeIDgield <> '' then begin
        if not chkAllTypes.Checked then begin
            OPENDB(qryClientTypes);
            if result <> '' then result := result +' and ' else result := ' where ';
            result := result + ' ifnull('+ typeIDgield +',0) = ' + inttostr(qryClientTypes.FieldByName('ClientTypeID').AsInteger);
        end;
    end;
    if ExtraWhere <> '' then begin
      if result <> '' then result := result +' and ' else result := ' where ';
      result := result + ExtraWhere;
    end;
  end;

begin
  with ScriptMain do
  begin
    SQL.Add('/*1*/Drop TABLE if exists '+ tablename +';');
    SQL.Add('/*2*/CREATE TABLE '+ tablename +' ( '+
                             ' Category         INT(11)       NULL  DEFAULT 0   , '+
                             ' Details          INT(11)       NULL  DEFAULT 0   , '+
                             ' PriceType        VARCHAR(50)   NULL  DEFAULT ""  , '+
                             ' ProductBarCode   VARCHAR(255)  NULL  DEFAULT ""  , '+
                             ' PartsID          INT(11)                 DEFAULT NULL, '+
                             ' ClientId         INT(11)                 DEFAULT NULL, '+
                             ' Discount         DOUBLE        NULL  DEFAULT 0   , '+
                             ' Price            DOUBLE        NULL  DEFAULT 0   , '+
                             ' UOM              VARCHAR(100)            DEFAULT NULL, '+
                             ' AllClients       ENUM("T","F")           DEFAULT "F" , '+
                             ' DateTo           DATE                    DEFAULT NULL, '+
                             ' DateFrom         DATE                    DEFAULT NULL, '+
                             ' ExtraSellDesc    VARCHAR(255)            DEFAULT NULL, '+
                             ' Partname         VARCHAR(60)             DEFAULT NULL, '+
                             ' ProductPrintName VARCHAR(255)            DEFAULT NULL, '+
                             ' PartDescription  VARCHAR(255)            DEFAULT NULL, '+
                             ' CustomerType     VARCHAR(50)             DEFAULT NULL, '+
                             ' ClientName       VARCHAR(100)            DEFAULT NULL, '+
                             ' LinePrice        DOUBLE        NULL  DEFAULT 0.00, '+
                             ' OriginalPrice    DOUBLE        NULL  DEFAULT 0   , '+
                             ' Productcost      DOUBLE        NULL  DEFAULT 0   , '+
                             ' UsedInRun        ENUM("T","F")           DEFAULT "F" , '+
                             ' DiscountPercent  DOUBLE        NULL  DEFAULT 0.00, '+
                             ' Col1             VARCHAR(100)  NULL  DEFAULT ""  , '+
                             ' Col2             VARCHAR(100)  NULL  DEFAULT ""  , '+
                             ' Col3             VARCHAR(100)  NULL  DEFAULT ""  , '+
                             ' PermanentDiscount      DOUBLE  NULL  DEFAULT 0.00, '+
                             ' SpecialProductDiscount DOUBLE  NULL  DEFAULT 0.00  '+
                             ' ) ENGINE=MyISAM DEFAULT CHARSET=utf8;');

    SQL.Add('/*3*/Insert into '+ tablename +' (Category,Details,PriceType,ProductBarCode,PartsID,Discount,Price,UOM,AllClients,DateTo,DateFrom,ExtraSellDesc,Partname,ProductPrintName,PartDescription,CustomerType,OriginalPrice,Productcost,Col1,Col2,Col3) ' +
                                 '	SELECT	' +
                                 '	1                   as Category,	'+
                                 '	2                   as Details,	'+
                                 '	"Extra Sell"        as PriceType,	'+
                                 ' P.BARCODE            as BARCODE,'+
                                 '	EP.PartsID          as PartsID,	'+
                                 '	EP.QtyPercent1      as Discount,	'+
                                 '	EP.Price1           as Price,	'+
                                 '	EP.UOM              as UOM,	'+
                                 '	EP.AllClients       as AllClients,	'+
                                 '	EP.DateTo           as DateTo,	'+
                                 '	EP.DateFrom         as DateFrom,	'+
                                 '	EP.ExtraSellDesc    as ExtraSellDesc,	'+
                                 '	P.PARTNAME          AS "Partname",	'+
                                 '	P.ProductPrintName  AS ProductPrintName,	'+
                                 '	P.PARTSDESCRIPTION  AS "PartDescription",	'+
                                 '	CT.TypeName         AS "CustomerType",	'+
                                 '	P.PRICE1            AS OriginalPrice,	'+
                                 '	P.Cost1             AS Productcost,	'+
                                 Firstcolumn +'        as Col1,	'+
                                 Secondcolumn + '      AS Col2,	'+
                                 Thirdcolumn + '       AS Col3	'+
                                 '	From tblExtraPriceSell AS EP	'+
                                 '	left JOIN tblclienttype AS CT on EP.ClientTypeID = CT.ClientTypeID	'+
                                 '	INNER JOIN tblparts AS P on EP.PartsID = P.PartsID	'+
                                 iif(chkHideInactiveProduct.checked , ' and P.Active ="T" ' , '') +
                                 Filterdata('', 'ep.ClientTypeID')+';');

//if chkAllTypes.Checked then begin
    SQL.Add('/*4*/Insert into '+ tablename +' (Category,Details,PriceType,ProductBarCode,PartsID,ClientId,Partname,ProductPrintName,PartDescription,ClientName,LinePrice,OriginalPrice,Productcost,UsedInRun,Col1,Col2,Col3) ' +
                                 '	SELECT	'+
                                 '	2                   as Category,	'+
                                 '	2                   as Details,	'+
                                 '	"Special Products"  AS PriceType,	'+
                                 '  P.BARCODE           as BARCODE,'+
                                 '	ProductID           AS PartsID,	'+
                                 '  C.ClientId          As ClientId, ' +
                                 '	Name                AS "Partname",	'+
                                 '	P.ProductPrintName  AS ProductPrintName,	'+
                                 '	CL.Description      AS "PartDescription",	'+
                                 '	C.Company           AS "ClientName",	'+
                                 '	LinePrice           as LinePrice,	'+
                                 '	OrigPrice           AS "OriginalPrice",	'+
                                 '	P.Cost1             AS "Productcost",	'+
                                 '	IncludeInRun        AS "UsedInRun",	'+
                                 Firstcolumn +'        as Col1,	'+
                                 Secondcolumn + '      AS Col2,	'+
                                 Thirdcolumn + '       AS Col3	'+
                                 '	From  tblCustomerLines	CL '+
                                 '	INNER JOIN tblclients C ON CustomerID=C.ClientID	'+
                                 '	INNER JOIN tblparts AS P on CL.ProductID = P.PartsID	'+
                                 iif(chkHideInactiveProduct.checked , ' and P.Active ="T" ' , '') +
                                 Filterdata('CustomerID', '')+';');
    SQL.Add('/*5*/Insert into '+ tablename +' (Category,Details,PriceType,clientId, ClientName,DiscountPercent,Col1,Col2,Col3,ProductBarCode,PartsID , Partname,ProductPrintName,PartDescription,LinePrice,OriginalPrice,Productcost) ' +
                                 '	SELECT	'+
                                 '	3                   as Category ,	'+
                                 '	2                   as Details,	'+
                                 '	"Group Discount  "  AS PriceType,	'+
                                 '  C.clientId          as ClientId , '+
                                 '	C.company           AS "ClientName",	'+
                                 '	PGD.Discount        AS "DiscountPercent",	'+
                                 '	PGD.Col1            as Col1,	'+
                                 '	PGD.Col2            as Col2,	'+
                                 '	PGD.Col3            as Col3,	'+
                                 '  P.BARCODE           as BARCODE,'+
                                 '	P.PartsId           AS PartsID,	'+
                                 '	P.partName          AS Partname,	'+
                                 '	P.ProductPrintName  AS ProductPrintName,	'+
                                 '  P.PARTSDESCRIPTION  AS PartDescription,'+
                                 '  P.PRICE1 - (P.PRICE1* PGD.Discount / 100)   as LinePrice, '+
                                 '  P.PRICE1 , P.cost1 '+
                                 '	FROM tblprodgroupdiscs PGD	'+
                                 '	INNER JOIN tblclients C USING(ClientID)	'+
                                 '  inner join tblparts P on (( ifnull(PGD.col1,"")<> "" and '+ Firstcolumn('P')+ ' = PGD.col1) or  '+
                                                            '( ifnull(PGD.col2,"")<> "" and '+ Secondcolumn('P')+ ' = PGD.col2) or  '+
                                                            '( ifnull(PGD.col3,"")<> "" and '+ Thirdcolumn('P')+ ' = PGD.col3))' +
                                 iif(chkHideInactiveProduct.checked , ' and P.Active ="T" ' , '') +
                                 Filterdata('C.ClientID', '')+';');

    SQL.Add('/*6*/Insert into '+ tablename +' (Category,Details,PriceType,ClientId ,ClientName,PermanentDiscount,SpecialProductDiscount ) ' +
                                 '	SELECT	'+
                                 '	4                     as Category ,	'+
                                 '	2                     as Details,	'+
                                 '	"General Discounts "  AS PriceType,	'+
                                 '  C.clientId            as ClientID, '+
                                 '	C.Company             AS "ClientName",	'+
                                 '(Discount * 100)       AS "PermanentDiscount",	'+
                                 '(SpecialDiscount*100)  AS "SpecialProductDiscount"	'+
                                 '	From  tblclients C	'+
                                 Filterdata('C.ClientID', '' , '(ifnull(Discount,0) <> 0 or ifnull(SpecialDiscount,0) <> 0)')+' ;');
//end;


    SQL.Add('/*7*/Insert into '+ tablename +' (Category,Details,PriceType,ProductBarCode,PartsID,Partname,ProductPrintName,PartDescription,OriginalPrice,Productcost,Col1,Col2,Col3) ' +
                                 '	SELECT	'+
                                 '	5                   as Category,	'+
                                 '	2                   as Details,	'+
                                 '	"Normal Price"      AS PriceType,	'+
                                 '  ifnull(P.BARCODE, "") as BARCODE,'+
                                 '	P.PartsID           as PartsID,	'+
                                 '	PartName            AS Partname,	'+
                                 '	P.ProductPrintName  AS ProductPrintName,	'+
                                 '	PartsDescription    AS "PartDescription",	'+
                                 '	P.PRICE1            AS "OriginalPrice",	'+
                                 '	P.Cost1             AS "Productcost",	'+
                                 Firstcolumn +'        as Col1,	'+
                                 Secondcolumn + '      AS Col2,	'+
                                 Thirdcolumn + '       AS Col3	'+
                                 '	FROM tblparts P ' +
                                 '    left join tblExtraPriceSell EP on EP.PartsId = P.PartsId ' +
                                 'Where ifnull(Partname, "")<> "" ' +
                                 iif(ChkhidesystemProducts.checked , ' and IsSystemProduct ="F"' , '') +
                                 iif(chkHideInactiveProduct.checked , ' and P.Active ="T" ' , '') +
                                 iif(chkhide0PricedProducts.checked, ' and ifnull(P.PRICE1,0)<>0 ' , '') +
                                 ' and ifnull(EP.QtyPercent1, 0) = 0;');

   {
    SQL.Add('/*8*/Insert into '+ tablename +' (Category,Details,PriceType) ' +
                                ' Select Distinct Category , 1 , PriceType from '+tablename +';');
}
    (*
    // Correcting Normal Prices group
    if chkAllTypes.Checked then
    begin
      { Not working - cannot use the same table
      SQL.Add('Delete from ' + tableName + ' where Category = 5 and PartsId in ' +
              '(select distinct PartsId from ' + tableName + ' where Category in (2, 3, 4) );');
      }
      // remove Group Discount
      SQL.Add('Delete from ' + tableName + ' where Category = 5 and PartsId in ' +
              '(select distinct P.PartsId from tblprodgroupdiscs PGD ' +
              '	INNER JOIN tblclients C USING(ClientID)	'+
              '  Left join tblparts P on (( ifnull(PGD.col1,"")<> "" and '+ Firstcolumn('P')+ ' = PGD.col1) or  '+
                                         '( ifnull(PGD.col2,"")<> "" and '+ Secondcolumn('P')+ ' = PGD.col2) or  '+
                                         '( ifnull(PGD.col3,"")<> "" and '+ Thirdcolumn('P')+ ' = PGD.col3))' +
              Filterdata('C.ClientID', '')+');');
    end;
    *)
    end;
end;

procedure TfrmPriceListGUI.BuildMainScriptTail;
var
  idx : integer;
  s : string;

  procedure InsertGroup;
  begin
    if s = ''  then
      exit;
    s := '(' + copy(S,1, length(s)-2) + ');';
    ScriptMain.SQL.Add('DELETE FROM ' + TableName + ' WHERE Category = 5 and PartsId in');
    scriptMain.SQL.Add(s);
    s := '';
    idx := 0;
  end;

begin
  ScriptMain.SQL.Clear;

  qryWork.SQL.Clear;
  qryWork.SQL.Add('select distinct PartsId from ' + TableName);
  qryWork.SQL.Add('where Category in (2,3,4) and PartsId is not null');
  qryWork.Open;

  idx := 0;
  s := '';
  try
    while not qryWork.EOF do
    begin
      s := s + qryWork.Fields[0].asString + ', ';
      inc(idx);
      if idx = 30 then
        InsertGroup;
      qryWork.Next;
    end;
    InsertGroup;
  finally
    qryWork.Close;
  end;

  ScriptMain.SQL.Add('/*8*/Insert into '+ tablename +' (Category,Details,PriceType) ' +
                                ' Select Distinct Category , 1 , PriceType from '+tablename +';');

  LogText(scriptMain.SQLtext);
end;

procedure TfrmPriceListGUI.grdMainDblClick(Sender: TObject);
begin
  if Sysutils.SameText(PriceType, 'Extra Sell') or Sysutils.SameText(PriceType, 'Normal Price') then
    SubsequentID := Chr(95) + 'Product'
  else if Sysutils.SameText(PriceType, 'Special Products') or Sysutils.SameText(PriceType, 'Group Discount') or Sysutils.SameText(PriceType, 'General Discounts') then
    SubsequentID := Chr(95) + 'Client';
  Inherited;
end;

procedure TfrmPriceListGUI.setCustomerID(const Value: integer);
begin
  iCustomerID := Value;
  if Value <> 0 then
    chkAllTypes.Checked := True;
end;

procedure TfrmPriceListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainCategory.Fieldname);
  RemoveFieldfromGrid(QrymainDetails.Fieldname);
  RemoveFieldfromGrid(QrymainPartsID.Fieldname);
  RemoveFieldfromGrid(QrymainClientId.Fieldname);
end;

procedure TfrmPriceListGUI.ShowControlhints;
var
  s:String;
begin
  inherited;
  s:= 'Extra Sell : ' + AppEnv.DefaultClass.PartColumn +' Card -> Extra Sell Prices '+NL+
      'Special Products : Customer Card -> Discounts -> Special Products '+NL+
      'Group Discount: Customer Card -> Discounts -> Group Discounts '+NL+
      'General Discounts :Customer Card -> Discounts -> Permanent Discount (%) & Special Product Discount (%) '+NL+
      'Normal Price : ' + AppEnv.DefaultClass.PartColumn +' Card -> Price1. (The list excludes inactive ' + AppEnv.DefaultClass.PartColumn +'(s), System ' + AppEnv.DefaultClass.PartColumn +'(s) and the ' + AppEnv.DefaultClass.PartColumn +'(s) with 0 Price)'+NL;
  ShowControlhint(grpfilters , s);
  s:= 'These Options are applicable for the ' + Qrymainpricetype.DisplayLabel +' "Normal Price" only';
  ShowControlhint(chkhide0PricedProducts , s);
  ShowControlhint(chkHideInactiveProduct , s);
  ShowControlhint(ChkhidesystemProducts , s);

end;

procedure TfrmPriceListGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.hidesystemProducts'].AsBoolean  := ChkhidesystemProducts.checked ;
  GuiPrefs.Node['Options.hide0PricedProducts'].AsBoolean := chkhide0PricedProducts.checked;
  GuiPrefs.Node['Options.HideInactiveProduct'].AsBoolean := chkHideInactiveProduct.checked;
  GuiPrefs.Node['Options.AllTypes'].AsBoolean            := chkAllTypes.checked ;
end;

initialization
  RegisterClassOnce(TfrmPriceListGUI);
end.
