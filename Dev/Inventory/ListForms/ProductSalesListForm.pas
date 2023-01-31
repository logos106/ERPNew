unit ProductSalesListForm;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 13/10/05  1.00.01 DSP  Added new calculated column 'Monthly Average Activity
                        Quantity'. Added grpPreferredLevel. Added ability to
                        multi-select rows. Fixed fault with 'Preferred Level'
                        field.
 04/11/05  1.00.02 MV   Added Product Type description to details list.
 08/11/05  1.00.03 MV   Modified the method for the sales projection.
 08/11/05  1.00.04 MV   Modified description for updating the preferred level.
 03/02/06  1.00.04 DSP  Changed the visible property of LinesID to false.
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, ExtCtrls, ComCtrls,AdvOfficeStatusBar, ImgList, Menus, AdvMenus, PrintDAT,
  ActnList, wwdblook, wwcheckbox, kbmMemTable, Provider, DBClient,
  wwDialog, Wwlocate, SelectionDialog, DNMPanel, MemDS, DBAccess, MyAccess,ERPdbComponents,
  wwdbdatetimepicker, ProgressDialog,  Shader, DAScript, MyScript, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TProductSalesListGUI = class(TBaseListingGUI)
    lbPeriod: TLabel;
    Panel4: TPanel;
    lblClassTitle: TLabel;
    cboClass: TwwDBLookupCombo;
    cboClassSrc: TDataSource;
    qryMainPartsID: TIntegerField;
    qryMainPartName: TWideStringField;
    qryMainShipped: TFloatField;
    qryMainAvgPrice: TFloatField;
    qryMainAvgCost: TFloatField;
    qryMainMarkup: TFloatField;
    qryMainMargin: TFloatField;
    qryMainFirstColumn: TWideStringField;
    qryMainSecondColumn: TWideStringField;
    qryMainThirdColumn: TWideStringField;
    qryMainSalesOrders: TFloatField;
    qryMainInvoiceBO: TFloatField;
    kbmNotSold: TkbmMemTable;
    dskbmNotSold: TDataSource;
    kbmNotSoldPartsID: TIntegerField;
    kbmNotSoldPartName: TWideStringField;
    kbmNotSoldAvailableQty: TFloatField;
    kbmNotSoldLastSold: TDateField;
    kbmNotSoldStockValue: TCurrencyField;
    kbmNotSoldPrice: TCurrencyField;
    kbmNotSoldCost: TCurrencyField;
    kbmNotSoldDaysAgo: TFloatField;
    kbmNotSoldPreferedSupplier: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainAttrib1: TFloatField;
    qryMainAttrib2Sale: TFloatField;
    qryMainAttrib1SaleRate: TFloatField;
    cboClassQry: TERPQuery;
    qryMainMonthlyAverageActivityQuantity: TFloatField;
    grpPreferredLevel: TRadioGroup;
    qryMainPreferredLevel: TFloatField;
    btnUpdate: TDNMSpeedButton;
    qryMainPartType: TWideStringField;
    qryMainLinesID: TIntegerField;
    qryMainProjectedWeeklyUnits: TFloatField;
    qryMainProjectedWeeklyProfit: TCurrencyField;
    qryMainProjectedMonthlyUnits: TFloatField;
    qryMainProjectedMonthlyProfit: TCurrencyField;
    qryMainProjectedAnnualUnits: TFloatField;
    qryMainProjectedAnnualProfit: TCurrencyField;
    qryMainReorderPoint: TFloatField;
    qryMainReorderAmount: TFloatField;
    qryMainPREFEREDSUPP: TWideStringField;
    lblREfreshInfo: TLabel;
    qryMainClassId: TIntegerField;
    qryMainClassname: TWideStringField;
    qryMainInStockQty: TFloatField;
    qryMainAvailableQty: TFloatField;
    kbmNotSoldInStockQty: TFloatField;
    procedure FormShow(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure grdMainTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure grdMainCalcTitleImage(Sender: TObject; Field: TField; var TitleImageAttributes: TwwTitleImageAttributes);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure qryMainFilterRecord(DataSet: TDataSet; var Accept: boolean);
    procedure btnUpdateClick(Sender: TObject);
    procedure actRefreshQryExecute(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FirstOpen: boolean;
    xDateFrom:TDateTime;
    xdateTo   :Tdatetime;
    xclassID :Integer;

    (* procedure GetShippedAverage(var AvgUnits: double; var Profit: double; Product: integer;
      FromDate: TDateTime; ToDate: TDateTime); *)
    Procedure PopulateQryMain;
    Procedure InitQrymainParams;
    Procedure ToBeRefreshed;


  protected
    procedure RefreshQuery; override;
    function DoDtFromChange(Sender:Tobject): boolean; override;
    procedure RefreshTotals; override;
    procedure RefreshAll;override;
    procedure SetGridColumns; Override;
  end;


implementation

{$R *.dfm}

uses pqalib,
   frmPartsFrm, AppContextObj, DateUtils, CommonDbLib,
  CommonLib, StrUtils,FastFuncs, AppEnvironment, ProductQtyLib, tcConst;


procedure TProductSalesListGUI.RefreshQuery;
begin
  if Searching then RefreshAll else ToBeRefreshed;
end;
procedure TProductSalesListGUI.RefreshAll;
begin
  Processingcursor(True);
  qryMain.DisableControls;
  try

    lbPeriod.Caption := Format('Period: %1.1f Weeks', [(dtto.DateTime - dtfrom.DateTime) / 7]);
    //PopulateQrymain;
    InitQrymainParams;
    inherited RefreshQuery;

    TobeRefreshed;
  finally
    qryMain.EnableControls;
    Processingcursor(False);
  end;
  PopulateFilterCombo;
end;

procedure TProductSalesListGUI.RefreshTotals;
begin
  if DoingFormShow then
    exit;
  inherited;
  CalcnShowFooter;
end;

procedure TProductSalesListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('Classid');
  RemoveFieldfromGrid('LinesID');
  RemoveFieldfromGrid('PArtsID');
  RemoveFieldfromGrid('ProjectedWeeklyUnits');
  RemoveFieldfromGrid('ProjectedWeeklyProfit');
  RemoveFieldfromGrid('ProjectedMonthlyUnits');
  RemoveFieldfromGrid('ProjectedMonthlyProfit');
  RemoveFieldfromGrid('ProjectedAnnualUnits');
  RemoveFieldfromGrid('ProjectedAnnualProfit');
  RemoveFieldfromGrid('MonthlyAverageActivityQuantity');
end;

procedure TProductSalesListGUI.ToBeRefreshed;
begin
  lblREfreshInfo.visible :=
              ( xDateFrom <> filterdatefrom) or
              (xdateTo   <> Filterdateto) or
              (xclassID <> cboClassQry.Fieldbyname('classId').asInteger);
end;

procedure TProductSalesListGUI.FormShow(Sender: TObject);
begin
  Inc(FormShowCount);
  try
    cboClassQry.Open;
    cboClassQry.Locate('ClassName', AppEnv.DefaultClass.DefaultClassName, [loCaseInsensitive]);
    cboClass.Value := AppEnv.DefaultClass.DefaultClassName;
    inherited;
    refreshall;
    if fbFormOpenedOk then begin
      if not fbDateRangeSupplied then begin
        dtto.DateTime := Date;
        dtfrom.DateTime := Date - 8 * 7; // two months
      end;

      FirstOpen := false;
      grpFiltersClick(Sender);
    end;
  finally
    if FormShowCount > 0 then
      Dec(FormShowCount);
  end;
end;

function TProductSalesListGUI.DoDtFromChange(Sender:TObject): boolean;
begin
  result:= true;
  grpFiltersClick(nil);
end;

procedure TProductSalesListGUI.grpFiltersClick(Sender: TObject);
var
  i: integer;

  procedure LoadFromParts;
  var
    qry, qry1: TERPQuery;
  begin
    qry := TERPQuery.Create(nil);
    qry1 := TERPQuery.Create(nil);

    try
      qry.Connection  := qryMain.Connection;
      qry1.Connection := qryMain.Connection;
      qry1.SQL.Text   := 'SELECT A.SaleDate, L.ProductID ' + 'FROM tblsaleslines L, tblsales A ' +
        'WHERE A.SaleID = L.SaleID ' + 'AND A.Deleted <> ''T'' ' + 'AND (A.IsInvoice = ''T'' OR A.IsCashSale=''T'') ' +
        'ORDER BY A.SaleDate desc';
      qry1.Open;

      qry.SQL.Text := 'SELECT P.PartsID, P.PartName, P.Cost1, P.Price1,PC.ClassID, P.PREFEREDSUPP, '+
          SQL4Qty(tInStock)+' as InStockQty,  '+
          SQL4Qty(tAvailable)+' as AvailableQty '+
          ' From ' + ProductTables(tSummary) ;
      qry.SQL.add(' Where PC.ClassID = '+IntToStr(cboClassQry.FieldByName('ClassID').asInteger));
      qry.SQL.Add('GROUP BY P.PartsID, PC.ClassID' );
      qry.Open;
      qry.filter := ' InStockQty > 0';
      qry.filtered := true;

      while not qry.Eof do begin
        if not qryMain.Locate('PartsID', qry.FieldByName('PartsID').AsInteger, [loCaseInsensitive]) then begin
          kbmNotSold.Insert;
          kbmNotSold.FieldByName('PartsID').AsInteger := qry.FieldByName('PartsID').AsInteger;
          kbmNotSold.FieldByName('PartName').AsString := qry.FieldByName('PartName').AsString;
          kbmNotSold.FieldByName('InStockQty').AsFloat := qry.FieldByName('InStockQty').AsFloat;
          kbmNotSold.FieldByName('AvailableQty').AsFloat := qry.FieldByName('AvailableQty').AsFloat;
          kbmNotSold.FieldByName('PreferedSupplier').AsString:= qry.FieldByName('PREFEREDSUPP').AsString;

          if qry1.Locate('ProductID', qry.FieldByName('PartsID').AsInteger, [loCaseInsensitive]) then begin
            kbmNotSold.FieldByName('LastSold').AsDateTime := qry1.FieldByName('SaleDate').AsDateTime;
            kbmNotSold.FieldByName('DaysAgo').AsFloat :=
              Date - kbmNotSold.FieldByName('LastSold').AsDateTime;
          end;

          kbmNotSold.FieldByName('Price').AsCurrency := qry.FieldByName('Price1').AsCurrency;
          kbmNotSold.FieldByName('Cost').AsCurrency := qry.FieldByName('Cost1').AsCurrency;
          kbmNotSold.FieldByName('StockValue').AsCurrency := kbmNotSold.FieldByName('Cost').AsCurrency *
            kbmNotSold.FieldByName('InStockQty').AsFloat;
          kbmNotSold.Post;
        end;

        qry.Next;
      end;
    finally
      FreeAndNil(qry);
      FreeAndNil(qry1);
    end;
  end; //LoadFromParts
begin
  inherited;

  if FirstOpen then Exit;

  Processingcursor(True);
  try
    PopulateFilterCombo;

    if grpFilters.ItemIndex = 0 then begin
      grdMain.DataSource := dsMain;
      kbmNotSold.Close;
      lblTotal.Caption := IntToStr(qryMain.RecordCount);
      if grpPreferredLevel.ItemIndex in [1, 2] then qryMain.Filtered := true;
      RefreshQuery;
    end else begin
      RefreshQuery;
      kbmNotSold.EmptyTable;
      kbmNotSold.SortFields := '';
      kbmNotSold.Open;
      LoadFromParts;
      grdMain.ClearLastBookmarks;
      grdMain.DataSource := dskbmNotSold;

      for i := grdMain.FieldCount to kbmNotSold.FieldCount - 1 do //?
        grdMain.AddField(kbmNotSold.Fields[i].FieldName);

      lblTotal.Caption      := IntToStr(kbmNotSold.RecordCount);
      kbmNotSold.SortFields := '[StockValue] ASC';                 // force into
      grdMainTitleButtonClick(Sender, 'StockValue');                // descending
      kbmNotSold.First;
    end;

    btnCustomize.Enabled := (grpFilters.ItemIndex = 0);
    cboFilter.Enabled := (grpFilters.ItemIndex = 0);
    edtSearch.Enabled := (grpFilters.ItemIndex = 0);
    btnAddFilter.Enabled := (grpFilters.ItemIndex = 0);
    grpPreferredLevel.Enabled := (grpFilters.ItemIndex = 0);
  finally
    Processingcursor(False);
  end;
end;


procedure TProductSalesListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  FormShowCount:= 0;
  xDateFrom:= 0;
  xdateTo   :=0;
  xclassID :=0;
//  AddCalccolumn(QrymainStockValue.fieldName   , True);
  AddCalccolumn(QrymainShipped.fieldName      , False);
//  AddCalccolumn(QrymainInStockQty.fieldName   , False);
//  AddCalccolumn(QrymainAvailableQty.fieldName , False);
//  AddCalccolumn(QrymainOnOrder.fieldName      , False);
  AddCalccolumn(QrymainSalesOrders.fieldName  , False);
  AddCalccolumn(QrymainInvoiceBO.fieldName    , False);
  (* AddCalccolumn(qryMainProjectedWeeklyUnits.fieldName    , False);
  AddCalccolumn(qryMainProjectedWeeklyProfit.fieldName   , True);
  AddCalccolumn(qryMainProjectedMonthlyUnits.fieldName    , False);
  AddCalccolumn(qryMainProjectedMonthlyProfit.fieldName   , True);
  AddCalccolumn(qryMainProjectedAnnualUnits.fieldName    , False);
  AddCalccolumn(qryMainProjectedAnnualProfit.fieldName   , True); *)
  ShowChartViewOnPopup := True;
  cboClassQry.Connection := qryMain.Connection;
  FirstOpen := true;
  PopulateQrymain;
end;

procedure TProductSalesListGUI.FormKeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
var
  s:String;
begin
  s:=QueryManipulationObj.ModifiedSQL;
  inherited;
  if (Qrymain.Active = False) or (s <> QueryManipulationObj.ModifiedSQL) then begin
    if s <> QueryManipulationObj.ModifiedSQL then begin
      CloseDB(Qrymain);
      if ((SearchMode = smSearchEngineLike) or (SearchMode = smSearchEngine)) AND (SearchMode <> smFullList) then
        qryMain.SQL.Text := QueryManipulationObj.ModifiedSQL;
    end;
    RefreshAll;
  end;
end;

procedure TProductSalesListGUI.grdMainDblClick(Sender: TObject);
Var Form : TComponent;
begin
  if grpFilters.ItemIndex = 0 then begin
    if TField(grdMain.GetActiveField).FieldName = 'On Order' then begin
        AppContext['PartDrillInfo'].IntVar['Department'] := cboClassQry.FieldByName('ClassID').AsInteger;
    end else if TField(grdMain.GetActiveField).FieldName = 'Sales Orders' then begin
        AppContext['PartDrillInfo'].IntVar['Department'] := cboClassQry.FieldByName('ClassID').AsInteger;
    end else if TField(grdMain.GetActiveField).FieldName = 'Invoice BO' then begin
        AppContext['PartDrillInfo'].IntVar['Department'] := cboClassQry.FieldByName('ClassID').AsInteger;
    end;

    inherited
  end else begin
    Form := GetComponentByClassName('TfrmParts');
    if Assigned(Form) then begin //if has acess
      with TfrmParts(Form) do begin
        KeyID := kbmNotSold.FieldByName('PartsID').AsInteger;
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;  
  end;
end;

procedure TProductSalesListGUI.grdMainTitleButtonClick(Sender: TObject; AFieldName: string);
begin
  if grpFilters.ItemIndex = 0 then inherited
  else begin
    if FastFuncs.PosEx('[' + AFieldName + ']' + ' ASC', kbmNotSold.SortFields) <> 0 then begin
      kbmNotSold.SortFields := '[' + AFieldName + ']' + ' DESC';
      kbmNotSold.SortOn(AFieldName, [mtcoDescending, mtcoCaseInsensitive]);
    end else begin
      kbmNotSold.SortFields := '[' + AFieldName + ']' + ' ASC';
      kbmNotSold.SortOn(AFieldName, [mtcoCaseInsensitive]);
    end;
  end
end;

procedure TProductSalesListGUI.grdMainCalcTitleImage(Sender: TObject; Field: TField;
  var TitleImageAttributes: TwwTitleImageAttributes);
begin
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if grpFilters.ItemIndex = 0 then inherited
  else begin
    if FastFuncs.PosEx('[' + Field.FieldName + ']' + ' ASC', kbmNotSold.SortFields) > 0 then TitleImageAttributes.ImageIndex := 3
    else if FastFuncs.PosEx('[' + Field.FieldName + ']' + ' DESC', kbmNotSold.SortFields) > 0 then TitleImageAttributes.ImageIndex := 4
    else TitleImageAttributes.ImageIndex := -1;
  end;
end;

procedure TProductSalesListGUI.qryMainCalcFields(DataSet: TDataSet);
begin
{projected qtys are removed as this procedure was just too slow on mybookstore database
the fields are made invisible in 'SetGridColumns'}
(*var
  Shipped: double;
  InvoiceBO: double;
  SalesOrder: double;
  Product: integer;
  AvgUnits: double;
  Profit: double;
begin
  inherited;
   Shipped := DataSet.FieldByName('Shipped').AsFloat;
  InvoiceBO := DataSet.FieldByName('Invoice BO').AsFloat;
  SalesOrder := DataSet.FieldByName('Sales Orders').AsFloat;
  Product := DataSet.FieldByName('PartsID').AsInteger;
  AvgUnits := 0;
  Profit := 0;

  DataSet.FieldByName('MonthlyAverageActivityQuantity').AsFloat :=
    divzer((Shipped + InvoiceBO + SalesOrder) * 30, (dtTo.Date - dtFrom.Date));

  // Calculate projected fields
  GetShippedAverage(AvgUnits, Profit, Product, IncDay(IncMonth(dtFrom.Date, - 1)), dtFrom.Date);
  DataSet.FieldByName('ProjectedWeeklyUnits').AsFloat := AvgUnits;
  DataSet.FieldByName('ProjectedWeeklyProfit').AsFloat := Profit;

  GetShippedAverage(AvgUnits, Profit, Product, IncDay(IncMonth(dtFrom.Date, - 3)), dtFrom.Date);
  DataSet.FieldByName('ProjectedMonthlyUnits').AsFloat := AvgUnits;
  DataSet.FieldByName('ProjectedMonthlyProfit').AsFloat := Profit;

  GetShippedAverage(AvgUnits, Profit, Product, IncDay(IncMonth(dtFrom.Date, - 12)), dtFrom.Date);
  DataSet.FieldByName('ProjectedAnnualUnits').AsFloat := AvgUnits;
  DataSet.FieldByName('ProjectedAnnualProfit').AsFloat := Profit; *)
end;

procedure TProductSalesListGUI.qryMainFilterRecord(DataSet: TDataSet; var Accept: boolean);
var
  PreferredLevel: double;
  Shipped: double;
  InvoiceBO: double;
  SalesOrders: double;
begin
  inherited;
  Accept := false;

  if grpFilters.ItemIndex = 0 then begin
    PreferredLevel := DataSet.FieldByName('PreferredLevel').AsFloat;
    Shipped        := DataSet.FieldByName('Shipped').AsFloat;
    InvoiceBO      := DataSet.FieldByName('Invoice BO').AsFloat;
    SalesOrders    := DataSet.FieldByName('Sales Orders').AsFloat;

    case grpPreferredLevel.ItemIndex of
      1:
        begin
          if PreferredLevel < ((Shipped + InvoiceBO + SalesOrders) * 30 / (dtTo.Date - dtFrom.Date)) then Accept := true;
        end;

      2:
        begin
          if PreferredLevel > ((Shipped + InvoiceBO + SalesOrders) * 30 / (dtTo.Date - dtFrom.Date)) then Accept := true;
        end;

      else Accept := true;
    end;
  end;
end;

procedure TProductSalesListGUI.actRefreshQryExecute(Sender: TObject);
begin
  if grpFilters.ItemIndex = 0 then
    RefreshAll
  else
    grpFiltersClick(grpFilters);
end;

procedure TProductSalesListGUI.btnUpdateClick(Sender: TObject);
var
  MAAQValue: double;
  LinesID: integer;
  UpdateStr: string;
  ErrorPos: integer;
  QueryResult: boolean;
  ResultValue: integer;
  qryUpdate: TERPQuery;
  x: integer;
begin
  inherited;
  UpdateStr := IntToStr(AppEnv.CompanyPrefs.MonthsStockRetained);

  repeat
    ResultValue := 0;
    QueryResult := InputQuery('Update Preferred Level',
      'Update selected record(s) with the Monthly Average Activity Quantity ?', UpdateStr);

    if QueryResult then begin
      Val(UpdateStr, ResultValue, ErrorPos);

      if (ErrorPos > 0) or (ResultValue <= 0) then CommonLib.MessageDlgXP_Vista('Invalid value entered, please re-enter.', mtWarning, [mbOK], 0);
    end;
  until (QueryResult = false) or ((ErrorPos = 0) and (ResultValue > 0));

  if QueryResult then begin
    Processingcursor(True);
    AppEnv.CompanyPrefs.MonthsStockRetained := ResultValue;
    qryMain.DisableControls;
    qryUpdate := TERPQuery.Create(nil);

    try
      qryUpdate.Connection := CommonDbLib.GetSharedMyDacConnection;
      qryUpdate.SQL.Text := 'SELECT ID, PreferredLevel FROM tblProductClasses';
      qryUpdate.Open;

      for x:= 0 to grdMain.SelectedList.Count -1 do begin
        grdMain.DataSource.DataSet.GotoBookmark(grdMain.SelectedList[x]);
        grdMain.DataSource.DataSet.FreeBookmark(grdMain.SelectedList[x]);
        MAAQValue := grdMain.DataSource.DataSet.FieldByName('MonthlyAverageActivityQuantity').AsFloat;
        LinesID := grdMain.DataSource.DataSet.FieldByName('LinesID').AsInteger;

        if qryUpdate.Locate('ID', VarArrayOf([LinesID]), []) then begin
          qryUpdate.Edit;
          qryUpdate.FieldByName('PreferredLevel').AsFloat := MAAQValue * AppEnv.CompanyPrefs.MonthsStockRetained;
          qryUpdate.Post;
        end;
      end;
      grdMain.SelectedList.Clear;
      RefreshQuery;
    finally
      FreeAndNil(qryUpdate);
      qryMain.EnableControls;
      Processingcursor(False);
    end;
  end;
end;

(* procedure TProductSalesListGUI.GetShippedAverage(var AvgUnits: double; var Profit: double;
  Product: integer; FromDate: TDateTime; ToDate: TDateTime);
var
  tmpQuery: TERPQuery;
begin
  // Create tmpQuery
  tmpQuery := TERPQuery.Create(nil);
  try
    // Connect and define Query SQl
    tmpQuery.Connection := CommonDbLib.GetSharedMyDacConnection;
    tmpQuery.SQL.Add(' SELECT ProductID, Shipped, A.SaleDate, ');
    tmpQuery.SQL.Add(' AVG(Shipped) as AvgShipped, ');
    tmpQuery.SQL.Add(' AVG((LinePrice-LineCost)*Shipped) as Profit ');
    tmpQuery.SQL.Add(' FROM tblSalesLines ');
    tmpQuery.SQL.Add(' INNER JOIN tblSales A ON A.SaleID = tblSalesLines.SaleID ');
    tmpQuery.SQL.Add(' WHERE ProductID = :xID ');
    tmpQuery.SQL.Add(' AND A.SaleDate Between  :txtfrom  And  :txtto ');
    tmpQuery.SQL.Add(' GROUP BY ProductID ');
    tmpQuery.Params.ParamByName('xID').AsInteger := Product;
    tmpQuery.Params.ParamByName('txtfrom').AsDate := FromDate;
    tmpQuery.Params.ParamByName('txtto').AsDate := ToDate;

    tmpQuery.Execute;

    // Find and return Averages for projected fields
    if tmpQuery.RecordCount > 0 then begin
      tmpQuery.First;
      AvgUnits := tmpQuery.FieldByName('AvgShipped').AsFloat;
      Profit := tmpQuery.FieldByName('Profit').AsFloat;
    end;

    tmpQuery.Close;

  finally
    FreeAndNil(tmpQuery);
  end;
end; *)

procedure TProductSalesListGUI.PopulateQryMain;
begin
  qrymain.DisableControls;
  try
    if qrymain.active then Qrymain.close;
    Qrymain.SQL.clear;
    Qrymain.SQl.add('SELECT');
    Qrymain.SQl.add('PC.ID AS LinesID,');
    Qrymain.SQl.add('PC.Classname as Classname,');
    Qrymain.SQl.add('PC.ClassId as ClassId,');
    Qrymain.SQl.add('P.PartsID AS PartsID,');
    Qrymain.SQl.add('P.PREFEREDSUPP as PREFEREDSUPP,');
    Qrymain.SQl.add('PartName AS PartName,');
    Qrymain.SQl.add('PARTSDESCRIPTION AS Description,');
    Qrymain.SQl.add(Firstcolumn +' as col1, ');
    Qrymain.SQl.add(Secondcolumn +' as col2, ');
    Qrymain.SQl.add(Thirdcolumn +' as col3, ');
    Qrymain.SQl.add('PT.TypeDesc AS PartType,');
    Qrymain.SQl.add('Sum(SL.Shipped) AS Shipped,');
    Qrymain.SQl.add('Avg(SL.LinePrice) AS "Avg Price",');
    Qrymain.SQl.add('Avg(SL.LineCost) AS "Avg Cost",');
    Qrymain.SQl.add('if (Sum(SL.LineCost) > 0, (Sum(SL.LinePrice)-Sum(SL.LineCost))  / Sum(SL.LineCost) * 100, 0) AS "Markup",');
    Qrymain.SQl.add('(Sum(SL.LinePrice-SL.LineCost))  / Sum(SL.LinePrice) * 100 AS "Margin",');
    Qrymain.SQl.add(Firstcolumn + ' AS "FirstColumn",');
    Qrymain.SQl.add(Secondcolumn + ' AS "SecondColumn",');
    Qrymain.SQl.add(Thirdcolumn + ' AS "ThirdColumn",');
//    Qrymain.SQl.add(SQL4Qty(tPOBO   )+' as "On Order",');
    Qrymain.SQl.add(SQL4Qty(tInStock)+' as InStockQty,');
    Qrymain.SQl.add(SQL4Qty(tAvailable)+' as AvailableQty,');
    Qrymain.SQl.add(SQL4Qty(tSO     )+' as "Sales Orders",');
    Qrymain.SQl.add(SQL4Qty(tInvBO  )+' as "Invoice BO",');
//    Qrymain.SQl.add('(' +SQL4Qty(tInStock)+')*Avg(SL.LinePrice) as StockValue,');
    Qrymain.SQl.add('PC.ReorderPoint AS "Reorder Point",');
    Qrymain.SQl.add('PC.PreferredLevel AS PreferredLevel,');
    Qrymain.SQl.add('PC.ReorderAmount AS "Reorder Amount",');
    Qrymain.SQl.add('SL.Attrib1Sale as Attrib1Sale,');
    Qrymain.SQl.add('SL.Attrib2Sale as Attrib2Sale,');
    Qrymain.SQl.add('SL.Attrib1SaleRate as Attrib1SaleRate');
    Qrymain.SQl.add('From ' + ProductTables(tSummary));
    Qrymain.SQl.add('INNER JOIN tblSalesLines SL ON PQA.TransLineID = SL.SaleLineID ');
    Qrymain.SQl.add('and PQA.transtype in (' + SalesTransTypes +')');
    Qrymain.SQl.add('INNER JOIN tblSales S ON S.SaleID = SL.SaleID');
    Qrymain.SQl.add('INNER JOIN tblparttypes PT ON P.PARTTYPE = PT.TypeCode');
    Qrymain.SQl.add('WHERE P.Active = "T"');
    Qrymain.SQl.add('AND S.Deleted <> "T"');
    Qrymain.SQl.add('AND (PC.ClassID = :ClassID or :ClassID=0)');
    (* Qrymain.SQl.add('AND S.ClassID = PC.ClassID'); *)
//    Qrymain.SQl.add('AND (S.IsInvoice = "T" OR S.IsCashSale="T")');
    (*Qrymain.SQl.add('AND (S.SaleDate Between  ' +QuotedStr(FormatDateTime(MysqlDateFormat , IncDay(IncYear(dtfrom.DateTime, - 1)))) );
    Qrymain.SQl.add('And  ' + QuotedStr(FormatDateTime(MysqlDateFormat ,dtto.DateTime)) +')');*)
    Qrymain.SQl.add('AND (S.SaleDate Between  :Datefrom And  :Dateto)');
    Qrymain.SQl.add('GROUP BY PartsID, ClassID');
    Qrymain.SQl.add('ORDER BY "Weekly Profit" desc');
    RefreshOrignalSQL;
  finally
    qrymain.EnableControls;
  end;
end;
procedure TProductSalesListGUI.InitQrymainParams;
begin
  Qrymain.ParamByname('ClassID').asInteger := cboClassQry.FieldByName('ClassID').asInteger;
  Qrymain.ParamByname('Datefrom').AsDatetime  := FilterDateFrom;
  Qrymain.ParamByname('Dateto').AsDatetime    := FilterDateTo;
  xDateFrom := Qrymain.ParamByname('Datefrom').AsDatetime   ;
  xdateTo   := Qrymain.ParamByname('DateTo').AsDatetime ;
  xclassID  := Qrymain.ParamByname('ClassID').asInteger ;
end;

initialization
  RegisterClassOnce(TProductSalesListGUI);
end.
