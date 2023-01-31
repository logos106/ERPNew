unit frmHourlySalesReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton, DAScript,
  MyScript, wwcheckbox;

type
  TfmHourlySalesReport = class(TBaseListingGUI)
    DNMSpeedButton1: TDNMSpeedButton;
    grpFilters3: TRadioGroup;
    grpFilters2: TRadioGroup;
    procedure cmdNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure grpFilters2Click(Sender: TObject);
    procedure grpFilters3Click(Sender: TObject);
  private
    procedure BuildQuery;
    function DoConfig: boolean;
    procedure ShowHideColumns;
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;    
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}


uses
  frmHourlySalesReportConfig, DataTreeObj, CommonLib, FastFuncs, MySQLConst;

{ TfmHourlySalesReport }

procedure TfmHourlySalesReport.BuildQuery;
var
  node: TDataTreeNode;
  x: integer;
  totalField: string;
begin
  qryMain.Close;
  qryMain.SQL.Clear;
  qryMain.SQL.Add('SELECT');
  qryMain.SQL.Add('CASE WHEN s.IsPOS = "T" THEN "POS" ' +
                       'WHEN s.IsCashSale = "T" THEN "Cash Sale" '+
                       'WHEN s.IsInvoice = "T" THEN "Invoice" END as "SaleType",');
  qryMain.SQL.Add('s.SaleDateTime, s.InvoiceDocNumber as DocNumber, s.CustomerName, s.Class as Department');
  if grpFilters.ItemIndex = 0 then begin
    {summary}
    if grpFilters2.ItemIndex = 0 then begin
      { inc tax}
      totalField:= 's.TotalAmountInc';
    end
    else begin
      {ex tax}
      totalField:= 's.TotalAmount';
    end;
  end
  else begin
    {detail}
    if grpFilters2.ItemIndex = 0 then begin
      { inc tax}
      totalField:= 'sl.TotalLineAmountInc';
    end
    else begin
      {ex tax}
      totalField:= 'sl.TotalLineAmount';
    end;
//    qryMain.SQL.Add(',sl.ProductName, sl.Product_Description, sl.Shipped');
  end;
  qryMain.SQL.Add(',sl.ProductName, sl.Product_Description, sl.Shipped');
  node:= TDataTreeNode(GuiPrefs.Node.ItemByName['TimeList']);
  if node.Count > 0 then begin
    for x:= 0 to node.Count -1 do begin
//      qryMain.SQL.Add(', IF(Time(s.SaleDateTime) >= ' +
//        QuotedStr(FormatDateTime(MysqlTimeFormat,node.Items[x]['TimeFrom'].AsDateTime)) +
//        ' AND Time(s.SaleDateTime) < ' +
//        QuotedStr(FormatDateTime(MysqlTimeFormat,node.Items[x]['TimeTo'].AsDateTime)) +
//        ', ' + totalField +', CAST( NULL as Decimal)) as "Sales ' +
//        FormatDateTime('hh:nn',node.Items[x]['TimeFrom'].AsDateTime)+'"');

      qryMain.SQL.Add(',IF(s.IsPOS = "T",' +
        { if IsPOs }

          ' IF(STR_TO_DATE(s.TimeOfSale,"%h:%i:%s %p") >= ' +
          QuotedStr(FormatDateTime(MysqlTimeFormat,node.Items[x]['TimeFrom'].AsDateTime)) +
          ' AND STR_TO_DATE(s.TimeOfSale,"%h:%i:%s %p") < ' +
          QuotedStr(FormatDateTime(MysqlTimeFormat,node.Items[x]['TimeTo'].AsDateTime)) +
          ', ' + totalField +', CAST( NULL as Decimal))' +

        ',' + { not pos }

          ' IF(Time(s.SaleDateTime) >= ' +
          QuotedStr(FormatDateTime(MysqlTimeFormat,node.Items[x]['TimeFrom'].AsDateTime)) +
          ' AND Time(s.SaleDateTime) < ' +
          QuotedStr(FormatDateTime(MysqlTimeFormat,node.Items[x]['TimeTo'].AsDateTime)) +
          ', ' + totalField +', CAST( NULL as Decimal))' +

        ') as "Sales ' + FormatDateTime('hh:nn',node.Items[x]['TimeFrom'].AsDateTime)+'"');

    end;
  end;
  qryMain.SQL.Add('FROM tblSales s ');
  qryMain.SQL.Add('INNER JOIN tblSalesLines sl USING(SaleId) ');
  qryMain.SQL.Add('WHERE s.SaleId = sl.SaleId');
  if grpFilters3.ItemIndex = 0 then begin
    {POS}
    qryMain.SQL.Add('AND (s.IsPos = "T")');

  end
  else begin
    {all sale types}
    qryMain.SQL.Add('AND (s.IsPos = "T" OR s.IsCashSAle = "T" OR s.IsInvoice = "T")');
  end;
  qryMain.SQL.Add('AND s.SaleDateTime >= ' + QuotedStr(FormatDateTime(MysqlDateFormat,dtFrom.Date)));
  qryMain.SQL.Add('AND s.SaleDateTime <= ' + QuotedStr(FormatDateTime(MysqlDateFormat,dtTo.Date)));
  qryMain.SQL.Add('ORDER BY s.SaleDateTime');
  RefreshOrignalSQL;
end;

procedure TfmHourlySalesReport.cmdNewClick(Sender: TObject);
begin
  inherited;
  if DoConfig then
    RefreshQuery;
end;

procedure TfmHourlySalesReport.RefreshQuery;
var
  x: integer;
begin
  BuildQuery;
  inherited;
  for x:= 0 to qryMain.Fields.Count -1 do begin
    if (qryMain.Fields[x] is TFloatField) and (FastFuncs.posex('Sales',qryMain.Fields[x].FieldName) = 1) then
      TFloatField(qryMain.Fields[x]).currency:= true;
  end;
  ShowHideColumns;
end;

procedure TfmHourlySalesReport.FormShow(Sender: TObject);
begin
  inherited;
  if GuiPrefs.Node.ItemByName['TimeList'].Count = 0 then begin
    CommonLib.MessageDlgXP_Vista('Please define the list of periods for the report.',mtInformation,[mbOk],0);
    DoConfig;
  end;
  RefreshQuery;
end;

function TfmHourlySalesReport.DoConfig: boolean;
var
  config: TfmHourlySalesReportConfig;
begin
  inherited;
  config:= TfmHourlySalesReportConfig.Create(nil);
  try
    config.Load(TDataTreeNode(GuiPrefs.Node.ItemByName['TimeList']));
    result:= config.ShowModal = mrOk;
    if result then
      GuiPrefs.SavePrefs;
  finally
    config.Free;
  end;
end;

procedure TfmHourlySalesReport.grpFiltersClick(Sender: TObject);
begin
  inherited;
  ShowHideColumns;
end;

procedure TfmHourlySalesReport.ShowHideColumns;
begin
  if qryMain.Active then begin
    qryMain.FieldByName('SaleType').Visible:= grpFilters3.ItemIndex = 1;
    qryMain.FieldByName('ProductName').Visible:= grpFilters.ItemIndex = 1;
    qryMain.FieldByName('Product_Description').Visible:= grpFilters.ItemIndex = 1;
    qryMain.FieldByName('Shipped').Visible:= grpFilters.ItemIndex = 1;
  end;  
end;

procedure TfmHourlySalesReport.grpFilters2Click(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfmHourlySalesReport.grpFilters3Click(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfmHourlySalesReport.RefreshTotals;
var
  oRecPointer: TBookmark;
  x,FloatFieldCount :Integer;
  FieldList: array of TFloatField;
  SumFloat: array of currency;
begin
  SumFloat := nil;
  FieldList := nil;
  FloatFieldCount := 0;
  qryMain.DisableControls;
  oRecPointer := qryMain.GetBookmark;
  Try
    for x:= 0 to qryMain.Fields.Count -1 do begin
      if (qryMain.Fields[x] is TFloatField) and (FastFuncs.posex('Sales',qryMain.Fields[x].FieldName) = 1) then Begin
        Inc(FloatFieldCount);
      end;
    end;
    If FloatFieldCount=0 then Exit;
    Setlength(FieldList, FloatFieldCount+1);
    FloatFieldCount := 0;
    for x:= 0 to qryMain.Fields.Count -1 do begin
      if (qryMain.Fields[x] is TFloatField) and (FastFuncs.posex('Sales',qryMain.Fields[x].FieldName) = 1) then Begin
        Inc(FloatFieldCount);
        FieldList[FloatFieldCount] := TFloatField(qryMain.Fields[x]);
      end;
    end;
    Setlength(SumFloat, FloatFieldCount+1);

    for x:= 1 to FloatFieldCount do
      SumFloat[x]:= 0;
    qryMain.First;
    while not qryMain.Eof do begin
      for x:= 1 to FloatFieldCount do
        SumFloat[x] := SumFloat[x] + FieldList[x].AsFloat;
      qryMain.Next;
    end;
  Finally
    qryMain.GoToBookmark(oRecPointer);
    qryMain.FreeBookmark(oRecPointer);
    qryMain.EnableControls;
    for x:= 1 to FloatFieldCount do
      grdMain.ColumnByName(FieldList[x].FieldName).FooterValue := FloatToStrF(SumFloat[x], ffCurrency, 15, CurrencyRoundPlaces);
  end;
end;

initialization
  RegisterClassOnce(TfmHourlySalesReport);

end.
