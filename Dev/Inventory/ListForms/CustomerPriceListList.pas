unit CustomerPriceListList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, DNMPanel, GIFImg;

type
  TCustomerPriceListGUI = class(TBaseListingGUI)
    qryMainPARTSID: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainProductPrintName: TWideStringField;
    qryMainFirstColumn: TWideStringField;
    qryMainSecondColumn: TWideStringField;
    qryMainThirdColumn: TWideStringField;
    qryMainSalesDescription: TWideStringField;
    qryMainPURCHASEDESC: TWideStringField;
    qryMainPriceInc: TFloatField;
    qryMainDiscontinued: TWideStringField;
    qryMainPartType: TWideStringField;
    qryMainCUSTFLD1: TWideStringField;
    qryMainCUSTFLD2: TWideStringField;
    qryMainCUSTFLD3: TWideStringField;
    qryMainCUSTFLD4: TWideStringField;
    qryMainCUSTFLD5: TWideStringField;
    qryMainCUSTFLD6: TWideStringField;
    qryMainCUSTFLD7: TWideStringField;
    qryMainCUSTFLD8: TWideStringField;
    qryMainCUSTFLD9: TWideStringField;
    qryMainCUSTFLD10: TWideStringField;
    qryMainCUSTFLD11: TWideStringField;
    qryMainCUSTFLD12: TWideStringField;
    qryMainCUSTFLD13: TWideStringField;
    qryMainCUSTFLD14: TWideStringField;
    qryMainCUSTFLD15: TWideStringField;
    qryMainCUSTDATE1: TDateTimeField;
    qryMainCUSTDATE2: TDateTimeField;
    qryMainCUSTDATE3: TDateTimeField;
    qryMainBarcode: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainProductionNotes: TWideMemoField;
    qryMainGeneralNotes: TWideMemoField;
    qryMainIsSystemProduct: TWideStringField;
    qryMainBatch: TWideStringField;
    qryMainMultiplebins: TWideStringField;
    qryMainSnTracking: TWideStringField;
    qryMainArea: TWideStringField;
    qryMainPreferedSupp: TWideStringField;
    qryClientTypes: TERPQuery;
    Panel4: TPanel;
    lblClassTitle: TLabel;
    Label1: TLabel;
    chkAllTypes: TwwCheckBox;
    cboClientType: TwwDBLookupCombo;
    DNMPanel1: TDNMPanel;
    btnChooseUOM: TDNMSpeedButton;
    chkAllUOMs: TCheckBox;
    btnPricelist: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);
    procedure cboClientTypeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure chkAllTypesClick(Sender: TObject);
    procedure qryClientTypesBeforeOpen(DataSet: TDataSet);
    procedure btnChooseUOMClick(Sender: TObject);
    procedure chkAllUOMsClick(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure btnPricelistClick(Sender: TObject);
  private
    TempTableName: string;
    fiCustomerTypeID: Integer;
    fiCustomerID: Integer;
    fsUOMIds:String;
    fbCustomerPriceList: Boolean;
    procedure PopulateTemporyTable;
    procedure UpdateMainSQL;
    procedure setCustomerTypeID(const Value: Integer);
    procedure chooseuoms(Sender: TwwDBGrid);
    procedure initUnitsOfMeasuresList(Sender: TObject);
    Function AllProductsUOMIDs(aUOMNames:String):String;
    function SelectedUOMNames: String;
    procedure InitPriceList(Sender: TObject);
  protected
    Procedure SetGridColumns; override;
    Procedure InitGroupFilterString; overload; virtual;
    procedure RefreshQuery; override;
    procedure ReadnApplyGuiPrefExtra; override;
    Procedure WriteGuiPrefExtra; override;
  public
    Property CustomerTypeID :Integer read fiCustomerTypeID write setCustomerTypeID;
    Property CustomerID :Integer read fiCustomerID write fiCustomerID;
    Property CustomerPriceList:Boolean read fbCustomerPriceList write fbCustomerPriceList;
  end;

var
  CustomerPriceListGUI: TCustomerPriceListGUI;

implementation

{$R *.dfm}

uses
  TempTableUtils, CommonDbLib, Appenvironment, DbSharedObjectsObj, CommonLib,
  CommonFormLib, UnitsOfMeasureList, UnitsOfMeasuresummaryList, tcConst, LogLib,
  PriceListForm;


{ TCustomerPriceListGUI }

procedure TCustomerPriceListGUI.btnChooseUOMClick(Sender: TObject);
begin
  inherited;
  OpenERPListFormultiselectModal('TUnitsOfMeasuresummaryListGUI' , initUnitsOfMeasuresList , chooseuoms);
end;

procedure TCustomerPriceListGUI.btnPricelistClick(Sender: TObject);
begin
  inherited;
  if CustomerPriceList then Appenv.Employee.CustomerPriceLsitOption := 2;
  OpenERPListForm('TfrmPriceListGUI' , InitPriceList);
  Self.closewait;
end;
procedure TCustomerPriceListGUI.InitPriceList(Sender: TObject);
begin
  if not(sender is TfrmPriceListGUI) then exit;
  TfrmPriceListGUI(Sender).ClientTypeID := CustomerTypeID ;
  TfrmPriceListGUI(Sender).CustomerID := CustomerID ;
  TfrmPriceListGUI(Sender).CustomerPriceList := CustomerPriceList;
end;

procedure TCustomerPriceListGUI.initUnitsOfMeasuresList (Sender: TObject);
begin
    TUnitsOfMeasuresummaryListGUI(Sender).Selectrecordsfieldname :='unitId';
    TUnitsOfMeasuresummaryListGUI(Sender).SelectrecordsValues := fsUOMIDs;
end;
procedure TCustomerPriceListGUI.chooseuoms(Sender: TwwDBGrid);
var
  aUOMNames:String;
begin
  aUOMNames := commonlib.SelectedDatas(sender, 'Unitname', true);
  if aUOMNames = '' then ShowcontrolHint(btnChooseUOM , '') else ShowcontrolHint(btnChooseUOM , 'Selected Units :' + replacestr(aUOMNames  , ',' , NL ));
  if aUOMNames <> '' then fsUOMIds := AllProductsUOMIDs(aUOMNames);
  if   chkAllUOMs.checked   <> (fsUOMIds= '') then chkAllUOMs.checked :=trim(fsUOMIds) = '';
  RefreshQuery;
end;
procedure TCustomerPriceListGUI.cboClientTypeCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if not Modified then Exit;
  inherited;
  fiCustomerTypeID :=qryClientTypes.fieldbyname('ClientTypeID').asInteger;
  RefreshQuery;
end;

procedure TCustomerPriceListGUI.chkAllTypesClick(Sender: TObject);
(*var
  qry: TERPQuery;*)
begin
  inherited;
  if not isformshown then exit;
  OPENDB(qryClientTypes);

  if chkAllTypes.Checked then begin
    cboClientType.Enabled := false;
    fiCustomerTypeID :=0;
  end else begin
    cboClientType.Enabled := true;
    if cboClientType.text= '' then begin
      qryClientTypes.first;
      cboClientType.Text := qryClientTypes.FieldByName('TypeName').AsString;
      fiCustomerTypeID :=qryClientTypes.fieldbyname('ClientTypeID').asInteger;
    end;
  end;
(*  ChkhidesystemProducts.Enabled := chkAllTypes.Checked;
  chkhide0PricedProducts.Enabled := chkAllTypes.Checked;
  chkHideInactiveProduct.Enabled := chkAllTypes.Checked;*)
  RefreshQuery;
(*  if (CustomerID > 0) and (not chkAllTypes.Checked) then begin
    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(qryMain.Connection);
    try
      qry.SQL.Text := 'select Company from tblClients where ClientID = ' + IntToStr(CustomerID);
      qry.Open;
      TitleLabel.Caption := qry.FieldByName('Company').AsString + ' Price List';
    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    end;
  end
  else begin
    TitleLabel.Caption := 'Customer Type Price List';*)
end;

procedure TCustomerPriceListGUI.chkAllUOMsClick(Sender: TObject);
begin
  inherited;
  if not isformshown then exit;
  RefreshQuery;
end;

procedure TCustomerPriceListGUI.FormCreate(Sender: TObject);
begin
  CustomerPriceList  := False;
  fiCustomerTypeID :=0;
  fiCustomerID :=0;
  TempTableName := '';
  (*PopulateTemporyTable;
  UpdateMainSQL;*)
  HaveOnlyToDate['As On '] := true;
  inherited;
  //HasAsondateRange:= True;
end;

procedure TCustomerPriceListGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(TempTableName);
  inherited;

end;

procedure TCustomerPriceListGUI.grpFiltersClick(Sender: TObject);
(*var
  s:String;
begin
  if grpExtrafilters.ItemIndex = 0 then s:= 'Parttype = ' +Quotedstr('INV')
  else if grpExtrafilters.ItemIndex = 1 then s:= 'Parttype = ' +Quotedstr('NONINV')
  else if grpExtrafilters.ItemIndex = 2 then s:= 'Parttype <> ' +Quotedstr('NONINV') + ' and  Parttype <> ' +Quotedstr('INV')
  else s:= '';
  initGroupFilterString;
  if (s<> '') then begin
     if groupfilterString <> '' then groupfilterString := '('+ groupfilterString +') and ';
     groupfilterString := groupfilterString + '(' + s +')';
  end;*)
begin
  initGroupFilterString;
  inherited;
end;

procedure TCustomerPriceListGUI.InitGroupFilterString;
begin
  InitGroupfilterString('Active' , ['T','F','']);
end;

procedure TCustomerPriceListGUI.PopulateTemporyTable;
var
  qry: TERPQuery;
  cmd: TERPCommand;
  floatField: TFloatField;
  ColNo: integer;
  fsfieldname:String;
  fiIndex:Integer;
begin
   ColNo := 1;
   while true do begin
    fsFieldname := 'PriceCol'+IntToStr(ColNo);
     if Assigned(qryMain.FindField(fsFieldname)) then begin
        fiIndex:=qryMain.FindField(fsFieldname).index;
       GuiPrefs.DbGridElement[grdmain].RemoveFields(fsfieldname);
       qryMain.FindField(fsfieldname).Free;
       Inc(ColNo);
     end
     else
       break;
   end;

  if TempTableName = '' then
    TempTableName := TempTableUtils.UniqueTableName('UstPriceList');
  qry := TERPQuery.Create(nil);
  cmd := TERPCommand.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    cmd.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select distinct IfNull(tblclienttype.TypeName,"All") as TypeName, IfNull(UOM,"ALL") as UOM');
    qry.SQL.Add('from tblextrapricesell');
    qry.SQL.Add('left join tblclienttype on tblclienttype.ClientTypeID = tblextrapricesell.ClientTypeID');
    qry.SQL.Add('where tblextrapricesell.Active ="T"');
    if (qryClientTypes.fieldbyname('ClientTypeID').asInteger <> 0) and (chkAllTypes.checked=False) then qry.SQL.Add(' and tblextrapricesell.ClientTypeID =' + inttostr(qryClientTypes.fieldbyname('ClientTypeID').asInteger));
    if (fsUOMIds<>'') and (chkAllUOMs.checked=False) then qry.SQL.Add(' and  tblextrapricesell.UOMID in (' + fsUOMIds +')');
    qry.SQL.Add('order by TypeName,UOM');
    qry.Open;

    cmd.SQL.Add('Drop table if exists ' + TempTableName + ';');
    cmd.SQL.Add('create table ' + TempTableName + '(');
    cmd.SQL.Add('ProductID INT(11) not null');
    ColNo := 1;
    while not qry.Eof do begin
      //cmd.SQL.Add(',`' + qry.FieldByName('TypeName').AsString + '-' + qry.FieldByName('UOM').AsString + '` double null default null');
      cmd.SQL.Add(',PriceCol' + IntToStr(ColNo) + ' double null default null');
      floatField := TFloatField.Create(qryMain);
      floatField.fieldKind := fkData;
      floatField.currency := true;
      floatField.fieldName := 'PriceCol' + IntToStr(ColNo);
//      floatField.DisplayFormat := AppEnv.RegionalOptions.CurrencySymbol + '#,###,###,###,###,##0.00;(' + AppEnv.RegionalOptions.CurrencySymbol + '#,###,###,###,###,##0.00)';
      floatField.DataSet := qryMain;
      floatField.DisplayLabel := qry.FieldByName('TypeName').AsString + '-' + qry.FieldByName('UOM').AsString;
      floatField.index := fiIndex;
      //grdmain.Selected.add(SelectedText(floatField.fieldname, floatField.DisplayLabel , 10  , 'Type-UOM Prices' ));
      GuiPrefs.DbGridElement[grdmain].addfield(floatField.fieldname);
      //GuiPrefs.DbGridElement[grdmain].FieldGroupname[floatField.fieldname]:='Type-UOM Prices';
      //floatField.Tag := TAG_MASK_DC;
      floatField.Visible := true;
      Inc(ColNo);
      qry.Next;
    end;
    //grdmain.ApplySelected;


    cmd.SQL.Add(',PRIMARY KEY (ProductID)');
    cmd.SQL.Add(')ENGINE=MyISAM;');
    cmd.Execute;
    cmd.SQL.Clear;
    cmd.SQL.Add('insert into ' + TempTableName);
    cmd.SQL.Add('(ProductID) (select distinct PartsID from tblparts where PartsID > 0)');
    cmd.Execute;
    qry.First;
    ColNo := 1;
    while not qry.eof do begin
      cmd.SQL.Clear;
      cmd.SQL.Add('update ' + TempTableName + ' as T');
//      cmd.SQL.Add('set T.`' + qry.FieldByName('TypeName').AsString + '-' + qry.FieldByName('UOM').AsString + '` = ');
      cmd.SQL.Add('set T.PriceCol' + IntToStr(ColNo) + ' = ');
      cmd.SQL.Add('(select IfNull(Price1,0.0) from tblextrapricesell');
      cmd.SQL.Add('left join tblclienttype on tblclienttype.ClientTypeID = tblextrapricesell.ClientTypeID');
      cmd.SQL.Add('where T.ProductID = tblextrapricesell.PartsID');
      cmd.SQL.Add('and IfNull(tblclienttype.TypeName,"All") = ' + QuotedStr(qry.FieldByName('TypeName').AsString));
      cmd.SQL.Add('and IfNull(UOM,"ALL") = ' + QuotedStr(qry.FieldByName('UOM').AsString));
      cmd.SQL.Add('and ((IsNull(tblextrapricesell.DateFrom) or IsNull(tblextrapricesell.DateTo)) or (:Date between tblextrapricesell.DateFrom and tblextrapricesell.DateTo)))');
      cmd.ParamByName('Date').AsDateTime := filterDateto;
      cmd.Execute;
      Inc(ColNo);
      qry.Next;
    end;
  finally
    qry.Free;
    cmd.Free;
  end;

end;

procedure TCustomerPriceListGUI.qryClientTypesBeforeOpen(DataSet: TDataSet);
begin
  inherited;
    qryClientTypes.connection :=qrymain.connection;
end;


procedure TCustomerPriceListGUI.qryMainAfterOpen(DataSet: TDataSet);
var
  ColNo:Integer;
  fsFieldname:String;
begin
  inherited;
   ColNo := 1;
   while true do begin
     if Assigned(qryMain.FindField('PriceCol'+IntToStr(ColNo))) then begin
        fsFieldname := 'PriceCol'+IntToStr(ColNo);
        GuiPrefs.DbGridElement[grdmain].FieldGroupname[fsFieldname]:='Type-UOM Prices';
       Inc(ColNo);
     end
     else
       break;
   end;

end;

procedure TCustomerPriceListGUI.RefreshQuery;
var
  s:String;
begin
  opendb(qryClientTypes);
  closedb(qryMain);
  //TempTableName := '';
  PopulateTemporyTable;
  UpdateMainSQL;
  RefreshOrignalSQL();
  inherited;
  s:= '';
  s:= ' Client Type :' ;
  if (qryClientTypes.fieldbyname('ClientTypeID').asInteger <> 0) and (chkAllTypes.checked =false) then s:= s+Quotedstr(qryClientTypes.fieldbyname('Typename').asString) else s:= s +' All';
  s:= s + NL+NL +' UOM :' ;
  if (fsUOMIds <> '') and (chkAllUOMs.checked =false) then s:= s+ SelectedUOMNames else s:= s+' All';
  s := 'Customer Price list for ' + NL +NL + s;
  Showcontrolhint(grdmain, s);
end;

procedure TCustomerPriceListGUI.setCustomerTypeID(const Value: Integer);
begin
  fiCustomerTypeID := Value;
  opendb(qryClientTypes);
  if Value<>0 then begin
    if qryClientTypes.Locate('ClientTypeID', Value, [loCaseInsensitive]) then begin
      chkAllTypes.Checked := false;
      cboClientType.Text := qryClientTypes.FieldByName('TypeName').AsString;
    end;
  end else begin
    chkAllTypes.Checked := True;
  end;
end;

procedure TCustomerPriceListGUI.SetGridColumns;
begin
  inherited;
  SetUpcustomFields('Product');
end;

procedure TCustomerPriceListGUI.UpdateMainSQL;
begin
  qryMain.SQL.Clear;
  qryMain.SQL.Add('SELECT distinct');
  qryMain.SQL.Add('PARTSID as PARTSID,');
  qryMain.SQL.Add('PARTNAME as ProductName,');
  qryMain.SQL.Add('ProductPrintName as ProductPrintName,');
  qryMain.SQL.Add('Left(SUBSTRING_INDEX(P.ProductGroup,"^",1),255) AS FirstColumn,');
  qryMain.SQL.Add('Left(substring(substring_index(P.ProductGroup,"^",2),char_length(substring_index(P.ProductGroup,"^",1))+2),255) AS SecondColumn,');
  qryMain.SQL.Add('Left(substring(substring_index(P.ProductGroup,"^",3),char_length(substring_index(P.ProductGroup,"^",2))+2),255) AS ThirdColumn,');
  qryMain.SQL.Add('PARTSDESCRIPTION as SalesDescription,');
  qryMain.SQL.Add('PURCHASEDESC as PURCHASEDESC,');
  qryMain.SQL.Add('PRICEINC1 AS PriceInc,');
  qryMain.SQL.Add('Discontinued as Discontinued,');
  qryMain.SQL.Add('PartType as PartType,');
  qryMain.SQL.Add('CUSTFLD1 as CUSTFLD1,');
  qryMain.SQL.Add('CUSTFLD2 as CUSTFLD2,');
  qryMain.SQL.Add('CUSTFLD3 as CUSTFLD3,');
  qryMain.SQL.Add('CUSTFLD4 as CUSTFLD4,');
  qryMain.SQL.Add('CUSTFLD5 as CUSTFLD5,');
  qryMain.SQL.Add('CUSTFLD6 as CUSTFLD6,');
  qryMain.SQL.Add('CUSTFLD7 as CUSTFLD7,');
  qryMain.SQL.Add('CUSTFLD8 as CUSTFLD8,');
  qryMain.SQL.Add('CUSTFLD9 as CUSTFLD9,');
  qryMain.SQL.Add('CUSTFLD10 as CUSTFLD10,');
  qryMain.SQL.Add('CUSTFLD11 as CUSTFLD11,');
  qryMain.SQL.Add('CUSTFLD12 as CUSTFLD12,');
  qryMain.SQL.Add('CUSTFLD13 as CUSTFLD13,');
  qryMain.SQL.Add('CUSTFLD14 as CUSTFLD14,');
  qryMain.SQL.Add('CUSTFLD15 as CUSTFLD15,');
  qryMain.SQL.Add('CUSTDATE1 as CUSTDATE1,');
  qryMain.SQL.Add('CUSTDATE2 as CUSTDATE2,');
  qryMain.SQL.Add('CUSTDATE3 as CUSTDATE3,');
  qryMain.SQL.Add('P.BARCODE as Barcode,');
  qryMain.SQL.Add('P.active as Active,');
  qryMain.SQL.Add('P.ProductionNotes as ProductionNotes,');
  qryMain.SQL.Add('P.GeneralNotes as GeneralNotes,');
  qryMain.SQL.Add('P.IsSystemProduct as IsSystemProduct,');
  qryMain.SQL.Add('P.Batch,');
  qryMain.SQL.Add('P.Multiplebins,');
  qryMain.SQL.Add('P.SnTracking,');
  qryMain.SQL.Add('P.Area as Area,');
  qryMain.SQL.Add('p.PREFEREDSUPP as PreferedSupp,');
  qryMain.SQL.Add('T.*');
  qryMain.SQL.Add('FROM tblparts p');
  qryMain.SQL.Add('left join ' + TempTableName + ' T on T.ProductID = p.PartsID');
  qryMain.SQL.Add('Where char_length(p.PARTNAME) > 0 AND not IsNull(p.PARTNAME)');
end;

procedure TCustomerPriceListGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.chkAllTypes'].asBoolean := chkAllTypes.Checked;
  GuiPrefs.Node['Options.ClientTypeID'].asInteger := CustomerTypeID;
  GuiPrefs.Node['Options.UOMIds'].asString := fsUOMIds;
  GuiPrefs.Node['Options.chkAllUOMs'].asBoolean := chkAllUOMs.Checked;
end;
function TCustomerPriceListGUI.SelectedUOMNames:String;
var
  qry: TERPQuery;
begin
  result := '';
  if fsUOMIds ='' then exit;
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    qry.sql.text :='Select distinct unitname from tblunitsofmeasure where unitid in (' + fsUOMIds +')';
    qry.open;
    result := qry.groupconcat('unitname' ,'', False, NL);
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
procedure TCustomerPriceListGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if fiCustomerTypeID =0 then begin
    if GuiPrefs.Node.Exists('Options.ClientTypeID') then
     CustomerTypeID :=GuiPrefs.Node['Options.ClientTypeID'].asInteger;
    if GuiPrefs.Node.Exists('Options.chkAllTypes') then
      chkAllTypes.Checked :=  GuiPrefs.Node['Options.chkAllTypes'].asBoolean;
  end else begin
    cboClientType.enabled := true;
    chkAllTypes.Checked :=  False;
  end;
  if GuiPrefs.Node.Exists('Options.chkAllUOMs') then
      chkAllUOMs.Checked :=  GuiPrefs.Node['Options.chkAllUOMs'].asBoolean;
  if GuiPrefs.Node.Exists('Options.UOMIds') then
      fsUOMIds:=  GuiPrefs.Node['Options.UOMIds'].asString;
  if fsUOMIds ='' then begin
    chkAllTypes.Checked := TRue;
    ShowcontrolHint(btnChooseUOM , '') ;
  end else ShowcontrolHint(btnChooseUOM , 'Selected Units :' + replacestr(SelectedUOMNames  , ',' , NL ));;
end;

function TCustomerPriceListGUI.AllProductsUOMIDs(aUOMNames: String): String;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(qrymain.Connection);
  try
    qry.sql.text := 'Select unitId from tblunitsofmeasure where unitname in (select unitname from tblunitsofmeasure where unitname in (' +aUOMNames+'))';
    qry.open;
    result := qry.GroupConcat('unitId');
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

initialization
  RegisterClassOnce(TCustomerPriceListGUI);

end.

