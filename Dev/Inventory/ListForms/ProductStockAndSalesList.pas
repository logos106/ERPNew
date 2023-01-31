unit ProductStockAndSalesList;

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
  TProductStockAndSalesListGUI = class(TBaseListingGUI)
    qryMainPartsID: TIntegerField;
    qryMainPartType: TWideStringField;
    qryMainProductGroup: TWideStringField;
    qryMainPartName: TWideStringField;
    qryMainProductPrintName: TWideStringField;
    qryMainPartsDescription: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainDiscontinued: TWideStringField;
    qryMainTotalInStock: TFloatField;
    qryMainTotalOnOrder: TFloatField;
    qryMainTotalAvailable: TFloatField;
    qryMainSalesPeriod1: TFloatField;
    qryMainSalesPeriod2: TFloatField;
    qryMainSalesPeriod3: TFloatField;
    grpExtraFilters: TwwRadioGroup;
    lblDepartment: TLabel;
    cboDepartments: TwwDBLookupCombo;
    chkAllDepartments: TCheckBox;
    Label5: TLabel;
    qryClass: TERPQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject); override;
    procedure grdMainDblClick(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    (*procedure chkAllDepartmentsClick(Sender: TObject);*)
    (*procedure cboDepartmentsCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);*)
  private
    DepartmentList: TStringList;
    procedure CreateTempTable;
    procedure SetGroupings;
    procedure ProductsaleslistBeforeShow(Sender: TObject);
    function SalesPeriod1DateFrom: TDatetime;
    function SalesPeriod2DateFrom: TDatetime;
    function SalesPeriod3DateFrom: TDatetime;
  protected
    Procedure InitGroupFilterString; overload;
    Procedure WriteGuiPrefExtra; override;
    procedure ReadnApplyGuiPrefExtra; Override;
    procedure RefreshQuery; override;
  public
    { Public declarations }
  end;

var
  ProductStockAndSalesListGUI: TProductStockAndSalesListGUI;

implementation

{$R *.dfm}

uses
  TempTableUtils, CommonDbLib, PQALib, DateUtils, GridFieldsObj,
  SyncReportTableObj, AppEnvironment, ProductQtylib, tcConst, MySQLConst,
  LogLib, CommonLib, CommonFormLib, Productsaleslist;

{ TProductStockAndSalesListGUI }

(*procedure TProductStockAndSalesListGUI.cboDepartmentsCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if not chkAllDepartments.Checked then begin
//    CreateTempTable;
    RefreshQuery;
  end;
end;*)

(*procedure TProductStockAndSalesListGUI.chkAllDepartmentsClick(Sender: TObject);
begin
  inherited;
  if chkAllDepartments.Checked then begin
    lblDepartment.Enabled := false;
    cboDepartments.Enabled := false;
  end
  else begin
    lblDepartment.Enabled := true;
    cboDepartments.Enabled := true;
    if cboDepartments.Text = '' then begin
      if cboDepartments.LookupTable.RecordCount > 0 then begin
        cboDepartments.LookupTable.First;
        cboDepartments.Text := cboDepartments.LookupTable.FieldByName(cboDepartments.LookupField).AsString;
      end;
    end;
  end;
//  CreateTempTable;
  RefreshQuery;
end;*)

procedure TProductStockAndSalesListGUI.CreateTempTable;
var
  TempTable: string;
  cmd: TERPCommand;
  qry: TERPQuery;
//  sl: TStringList;
  field: TFloatField;
  fieldName: string;
  QueryChanged: boolean;
  x: integer;
  fld: TField;
begin
  ProcessingCursor(True);
  try
    clog('');
    CloseDb(qryMain);
    x:= 0;
    while x < qryMain.FieldCount do begin
      fld := qryMain.Fields[x];
  //    if qryMain.Fields[x].Tag = 99 then begin
      if Pos('Department',fld.FieldName) = 1 then begin
        qryMain.Fields.Remove(fld);
        fld.Free;
      end
      else
        Inc(x);
    end;

    TempTable := CreateUserTemporaryTable(GetSharedMydacConnection,'tmp_StockAndSales');
    cmd := TERPCommand.Create(nil);
    qry := TERPQuery.Create(nil);
    try
      cmd.Connection := GetSharedMydacConnection;
      qry.Connection := GetSharedMydacConnection;
      cmd.SQL.Add('insert into ' + TempTable);
      cmd.SQL.Add('(PartsID,PartType,ProductGroup,PartName,ProductPrintName,PartsDescription,Active,Discontinued)');
      cmd.SQL.Add('(select PartsID,PartType,ProductGroup,PartName,ProductPrintName,PartsDescription,Active,Discontinued');
      cmd.SQL.Add('from tblparts');
      if selectedProductId <> 0 then cmd.SQL.Add('where partsId = ' + inttostr(selectedProductID));
      cmd.SQL.Add(')');
      Logtext(cmd.SQL.text);
      cmd.Execute;

      qry.SQL.Text := 'select * from tblclass where Active = "T"';
      (*if (not chkAllDepartments.Checked) and qryClass.Active then
        qry.SQL.Add('and ClassID = ' + IntToStr(qryClass.FieldByName('ClassID').AsInteger));*)
      if SelectedClassId<> 0 then qry.SQL.Add('and ClassID = ' + IntToStr(selectedClassId));
      qry.Open;
      try
        while not qry.Eof  do begin
          fieldName := 'Department' + IntToStr(qry.FieldByName('ClassID').AsInteger);
          DepartmentList.Add(FieldName);
          cmd.SQL.Text := 'alter table '+ TempTable + ' add column ' + FieldName + ' double null default null;';
          Logtext(cmd.SQL.text);
          cmd.Execute;
          field := TFloatField.Create(qryMain);
          field.Tag := 99;
          field.FieldName := FieldName;
          field.DisplayLabel := qry.FieldByName('ClassName').AsString;
          field.DataSet := qryMain;

          { adda data .. }
          cmd.SQL.Clear;
          cmd.SQL.Add('update ' + TempTable + ' as TMP');
          cmd.SQL.Add('inner join');
          cmd.SQL.Add('(select');
          cmd.SQL.Add('P.PartsID as PartsID,');
  //        cmd.SQL.Add(SQL4QtyField(tInStock) +' as InStockQty');
          cmd.SQL.Add( 'Round(IF(P.PartType = "INV",' +ProductQtylib.SQL4Qty(tInStock) +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')  as "InStockQty"');
          cmd.SQL.Add('from tblparts  p inner join tblpqa pqa on pqa.ProductID = p.partsid');
          cmd.SQL.Add('where pqa.DepartmentID = ' + IntToStr(qry.FieldByName('ClassID').AsInteger));
          cmd.SQL.Add('and PQA.transdate <=' + Quotedstr(formatdatetime( MysqlDateTimeFormat , FilterdateTo)));
          if selectedProductId <> 0 then cmd.SQL.Add('and P.partsId = ' + inttostr(selectedProductID));
          cmd.SQL.Add('group by p.partsID, pqa.DepartmentID');

          cmd.SQL.Add(') as S on S.PartsID = TMP.PartsID');
          cmd.SQL.Add('set TMP.' + FieldName + ' = S.InStockQty');
          cmd.SQL.Text := SyncReportObj.ChangeQuery(cmd.SQL.Text,QueryChanged);
          Logtext(cmd.SQL.text);
          cmd.Execute;

          qry.Next;
        end;
      finally
        qry.Close;
      end;

      { Totals .. }
      cmd.SQL.Clear;
      cmd.SQL.Add('update ' + TempTable + ' as TMP');
      cmd.SQL.Add('inner join');
      cmd.SQL.Add('(select');
      cmd.SQL.Add('P.PartsID as PartsID,');
  //    cmd.SQL.Add(SQL4QtyField(tInStock) +' as InStockQty,');
  //    cmd.SQL.Add(SQL4QtyField(tAvailable) +' as AvailableQty,');
      cmd.SQL.Add( 'Round(IF(P.PartType = "INV",' +ProductQtylib.SQL4Qty(tInstock   ) +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')  as "InStockQty",');
      if AppEnv.CompanyPrefs.CountSOBOInAvailable  then begin
        cmd.SQL.Add( 'Round(IF(P.PartType = "INV",' +ProductQtylib.SQL4Qty(tAvailable ) +' - ' +
          ProductQtylib.SQL4Qty(tsobo ) +',0.0), ' + IntToStr(tcConst.GeneralRoundPlaces)+')  as "AvailableQty",');
      end
      else
        cmd.SQL.Add( 'Round(IF(P.PartType = "INV",' +ProductQtylib.SQL4Qty(tAvailable ) +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')  as "AvailableQty",');
  //    cmd.SQL.Add(SQL4QtyField(tPOBO) +' as POBOQty');
      cmd.SQL.Add( 'Round(IF(P.PartType = "INV",' +ProductQtylib.SQL4Qty(tPOBO      ) +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')  as "POBOQty"');
      cmd.SQL.Add('from tblparts  p inner join tblpqa pqa on pqa.ProductID = p.partsid');
      cmd.SQL.Add('and PQA.transdate <=' + Quotedstr(formatdatetime( MysqlDateTimeFormat , FilterdateTo)));
      if selectedProductId <> 0 then cmd.SQL.Add('and P.partsId = ' + inttostr(selectedProductID));
      cmd.SQL.Add('group by p.partsID');

      cmd.SQL.Add(') as S on S.PartsID = TMP.PartsID');
      cmd.SQL.Add('set TMP.TotalInStock = S.InStockQty,');
      cmd.SQL.Add('TMP.TotalOnOrder = S.POBOQty,');
      cmd.SQL.Add('TMP.TotalAvailable = S.AvailableQty');
      cmd.SQL.Text :=  SyncReportObj.ChangeQuery(cmd.SQL.Text,QueryChanged);
      Logtext(cmd.SQL.text);
      cmd.Execute;

      { Sales last 12 Months ..}
      cmd.SQL.Clear;
      cmd.SQL.Add('update ' + TempTable + ' as TMP');
      cmd.SQL.Add('inner join');
      cmd.SQL.Add('(select');
      cmd.SQL.Add('P.PartsID as PartsID,');
  //    cmd.SQL.Add(SQL4QtyField(tTotSales) +' as TotSalesQty');
      cmd.SQL.Add( 'Round(IF(P.PartType = "INV",' +ProductQtylib.SQL4Qty(tTotSales) +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')  as "TotSalesQty"');
      cmd.SQL.Add('from tblparts  p inner join tblpqa pqa on pqa.ProductID = p.partsid');
      cmd.SQL.Add('where pqa.TransDate between ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,SalesPeriod1DateFrom)) + ' and ' +
        QuotedStr(FormatDateTime(MysqlDateTimeFormat,FilterdateTo)));
      if selectedProductId <> 0 then cmd.SQL.Add('and P.partsId = ' + inttostr(selectedProductID));
(*      if (not chkAllDepartments.Checked) and qryClass.Active then
        cmd.SQL.Add('and pqa.DepartmentID = ' + IntToStr(qryClass.FieldByName('ClassID').AsInteger));*)
        if SelectedClassId<> 0 then cmd.SQL.Add('and pqa.DepartmentID =  ' + IntToStr(selectedClassId));
      cmd.SQL.Add('group by p.partsID');
      cmd.SQL.Add(') as S on S.PartsID = TMP.PartsID');
      cmd.SQL.Add('set TMP.SalesPeriod1 = S.TotSalesQty');
      cmd.SQL.Text := SyncReportObj.ChangeQuery(cmd.SQL.Text,QueryChanged);
      Logtext(cmd.SQL.text);
      cmd.Execute;

      { Sales last 6 Months ..}
      cmd.SQL.Clear;
      cmd.SQL.Add('update ' + TempTable + ' as TMP');
      cmd.SQL.Add('inner join');
      cmd.SQL.Add('(select');
      cmd.SQL.Add('P.PartsID as PartsID,');
  //    cmd.SQL.Add(SQL4QtyField(tTotSales) +' as TotSalesQty');
      cmd.SQL.Add( 'Round(IF(P.PartType = "INV",' +ProductQtylib.SQL4Qty(tTotSales) +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')  as "TotSalesQty"');
      cmd.SQL.Add('from tblparts  p inner join tblpqa pqa on pqa.ProductID = p.partsid');
      cmd.SQL.Add('where pqa.TransDate between ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,SalesPeriod2DateFrom)) + ' and ' +
        QuotedStr(FormatDateTime(MysqlDateTimeFormat,FilterdateTo)));
      if selectedProductId <> 0 then cmd.SQL.Add('and P.partsId = ' + inttostr(selectedProductID));
      (*if (not chkAllDepartments.Checked) and qryClass.Active then
        cmd.SQL.Add('and pqa.DepartmentID = ' + IntToStr(qryClass.FieldByName('ClassID').AsInteger));*)
      if SelectedClassId<> 0 then cmd.SQL.Add('and pqa.DepartmentID =  ' + IntToStr(selectedClassId));
      cmd.SQL.Add('group by p.partsID');
      cmd.SQL.Add(') as S on S.PartsID = TMP.PartsID');
      cmd.SQL.Add('set TMP.SalesPeriod2 = S.TotSalesQty');
      cmd.SQL.Text := SyncReportObj.ChangeQuery(cmd.SQL.Text,QueryChanged);
      Logtext(cmd.SQL.text);
      cmd.Execute;

      { Sales last 4 Months ..}
      cmd.SQL.Clear;
      cmd.SQL.Add('update ' + TempTable + ' as TMP');
      cmd.SQL.Add('inner join');
      cmd.SQL.Add('(select');
      cmd.SQL.Add('P.PartsID as PartsID,');
  //    cmd.SQL.Add(SQL4QtyField(tTotSales) +' as TotSalesQty');
      cmd.SQL.Add( 'Round(IF(P.PartType = "INV",' +ProductQtylib.SQL4Qty(tTotSales) +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')  as "TotSalesQty"');
      cmd.SQL.Add('from tblparts  p inner join tblpqa pqa on pqa.ProductID = p.partsid');
      cmd.SQL.Add('where pqa.TransDate between ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,SalesPeriod3DateFrom)) + ' and ' +
        QuotedStr(FormatDateTime(MysqlDateTimeFormat,FilterdateTo)));
      if selectedProductId <> 0 then cmd.SQL.Add('and P.partsId = ' + inttostr(selectedProductID));
      (*if (not chkAllDepartments.Checked) and qryClass.Active then
        cmd.SQL.Add('and pqa.DepartmentID = ' + IntToStr(qryClass.FieldByName('ClassID').AsInteger));*)
      if SelectedClassId<> 0 then cmd.SQL.Add('and pqa.DepartmentID =  ' + IntToStr(selectedClassId));
      cmd.SQL.Add('group by p.partsID');
      cmd.SQL.Add(') as S on S.PartsID = TMP.PartsID');
      cmd.SQL.Add('set TMP.SalesPeriod3 = S.TotSalesQty');
      cmd.SQL.Text := SyncReportObj.ChangeQuery(cmd.SQL.Text,QueryChanged);
      Logtext(cmd.SQL.text);
      cmd.Execute;

    finally
      qry.Free;
      cmd.Free;
    end;
    qryMain.SQL.Clear;
    qryMain.SQL.Add('select * ');
    qryMain.SQL.Add('from ' + TempTable);
    qryMain.SQL.Add('order by ProductPrintName');

    self.RefreshOrignalSQL();

    qryMainSalesPeriod1.DisplayLabel := '12 Months';
    qryMainSalesPeriod2.DisplayLabel := '6 Months';
    qryMainSalesPeriod3.DisplayLabel := '4 Months';

  //  SetGroupings;
  finally
    Processingcursor(False);
  end;

end;

procedure TProductStockAndSalesListGUI.FormCreate(Sender: TObject);
begin
  DepartmentList := TStringList.Create;
//  dtTo.Date := Date + 1;
//  CreateTempTable;
HaveOnlyToDate['As On '] := true;
  inherited;
  //HasAsondateRange:= True;
  SelectionOption :=soclassnProduct;
end;

procedure TProductStockAndSalesListGUI.FormDestroy(Sender: TObject);
begin
  inherited;
  DepartmentList.Free;
end;

procedure TProductStockAndSalesListGUI.FormShow(Sender: TObject);
begin
  qryClass.Open;
  inherited;
  (*if (GuiPrefs.Node['cbDepartments.Department'].AsString <> '') then begin
    cboDepartments.LookupTable.Locate('ClassName',GuiPrefs.Node['cbDepartments.Department'].AsString,[]);
    if cboDepartments.Text <> cboDepartments.LookupTable.FieldByName('ClassName').AsString then
      cboDepartments.Text := cboDepartments.LookupTable.FieldByName('ClassName').AsString;
  end;*)
end;

procedure TProductStockAndSalesListGUI.grdMainDblClick(Sender: TObject);
begin
  if sametext(Activefieldname, qryMainSalesPeriod1.fieldname) or
    sametext(Activefieldname, qryMainSalesPeriod2.fieldname) or
    sametext(Activefieldname, qryMainSalesPeriod3.fieldname) then begin
      OpenERPListForm('TProductsaleslistsGUI', ProductsaleslistBeforeShow);
      exit;
    end;
  inherited;
end;
procedure TProductStockAndSalesListGUI.ProductsaleslistBeforeShow(Sender: TObject);
begin
  if sender is  TProductsaleslistsGUI then begin
    TProductsaleslistsGUI(Sender).dtFrom.Date := 0;
    TProductsaleslistsGUI(Sender).dtto.Date := filterDateto;
     if sametext(Activefieldname, qryMainSalesPeriod1.fieldname)  then  TProductsaleslistsGUI(Sender).dtFrom.Date :=SalesPeriod1DateFrom
  else if sametext(Activefieldname, qryMainSalesPeriod2.fieldname) then TProductsaleslistsGUI(Sender).dtFrom.Date :=SalesPeriod2DateFrom
  else if sametext(Activefieldname, qryMainSalesPeriod3.fieldname) then TProductsaleslistsGUI(Sender).dtFrom.Date :=SalesPeriod3DateFrom;
  TProductsaleslistsGUI(Sender).fbDateRangeSupplied := TRue;
  TProductsaleslistsGUI(Sender).ProductId := SelectedProductID;
  TProductsaleslistsGUI(Sender).ClassId := SelectedClassId;

  end;
end;

procedure TProductStockAndSalesListGUI.grpFiltersClick(Sender: TObject);
var
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
  end;
  inherited;
end;

procedure TProductStockAndSalesListGUI.InitGroupFilterString;
begin
  InitGroupfilterString('Active' , ['T','F','']);
end;

procedure TProductStockAndSalesListGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if grpExtraFilters.ItemIndex <> GuiPrefs.Node['grpExtraFilters.ItemIndex'].asInteger then
    grpExtraFilters.ItemIndex := GuiPrefs.Node['grpExtraFilters.ItemIndex'].asInteger;
    if GuiPrefs.Node.Exists('Options.Dateto') then begin
      dtto.date:=  GuiPrefs.Node['Options.Dateto'].asDatetime;
      fbDateRangeSupplied := true;
    end;

(*  if chkAllDepartments.Checked <> GuiPrefs.Node['chkAllDepartments.Checked'].AsBoolean then
    chkAllDepartments.Checked := GuiPrefs.Node['chkAllDepartments.Checked'].AsBoolean;*)
//  if GuiPrefs.Node['cbDepartments.Department'].AsString <> '' then begin
//    cboDepartments.LookupTable.Locate('ClassName',GuiPrefs.Node['cbDepartments.Department'].AsString,[]);
//  end;
end;

procedure TProductStockAndSalesListGUI.RefreshQuery;
begin
  CreateTempTable;
  inherited;
  SetGroupings;
end;

procedure TProductStockAndSalesListGUI.SetGroupings;
var
  x: integer;
begin
  TGridFieldList.SetFieldGroup(grdMain,'SalesPeriod1','Sales');
  TGridFieldList.SetFieldGroup(grdMain,'SalesPeriod2','Sales');
  TGridFieldList.SetFieldGroup(grdMain,'SalesPeriod3','Sales');

  TGridFieldList.SetFieldGroup(grdMain,'TotalInStock','Total');
  TGridFieldList.SetFieldGroup(grdMain,'TotalOnOrder','Total');
  TGridFieldList.SetFieldGroup(grdMain,'TotalAvailable','Total');

  for x := 0 to DepartmentList.Count -1 do begin
    TGridFieldList.SetFieldGroup(grdMain,DepartmentList[x],'Dept Stock');
  end;
end;

procedure TProductStockAndSalesListGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['grpExtraFilters.ItemIndex'].asInteger := grpExtraFilters.ItemIndex;
  GuiPrefs.Node['Options.Dateto'].asDatetime := FilterDateto;
  //GuiPrefs.Node['chkAllDepartments.Checked'].AsBoolean := chkAllDepartments.Checked;
(*  GuiPrefs.Node['cbDepartments.Department'].AsString :=
    cboDepartments.LookupTable.FieldByName(cboDepartments.LookupField).AsString;*)
end;
function TProductStockAndSalesListGUI.SalesPeriod1DateFrom:TDatetime; begin result := incSecond(endofthemonth(IncYear(FilterDateto , -1)),1)(*IncYear (FilterdateTo, -1)*); end;
function TProductStockAndSalesListGUI.SalesPeriod2DateFrom:TDatetime; begin result := incSecond(endofthemonth(incmonth(FilterDateto , -6)),1)(*IncMonth(FilterdateTo, -6)*); end;
function TProductStockAndSalesListGUI.SalesPeriod3DateFrom:TDatetime; begin result := incSecond(endofthemonth(incmonth(FilterDateto , -4)),1)(*IncMonth(FilterdateTo, -4)*); end;
procedure TProductStockAndSalesListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  showcontrolhint(grdmain,
    qryMainSalesPeriod1.displayname +' :' + Formatdatetime(shortdateformat , SalesPeriod1DateFrom)+' to ' + Formatdatetime(shortdateformat , Filterdateto) +' ( 1 Year )' + NL +
    qryMainSalesPeriod2.displayname +' :' + Formatdatetime(shortdateformat , SalesPeriod2DateFrom)+' to ' + Formatdatetime(shortdateformat , Filterdateto) +' ( 6 Months)' + NL +
    qryMainSalesPeriod3.displayname +' :' + Formatdatetime(shortdateformat , SalesPeriod3DateFrom)+' to ' + Formatdatetime(shortdateformat , Filterdateto) +' ( 4 Months)');
end;

initialization
  RegisterClass(TProductStockAndSalesListGUI);

end.
