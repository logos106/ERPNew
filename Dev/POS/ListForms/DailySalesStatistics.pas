unit DailySalesStatistics;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel;

type
  TDailySalesStatisticsGUI = class(TBaseListingGUI)
    qryMainEmployeeId: TIntegerField;
    qryMainEmployeeName: TWideStringField;
    qryMainClassname: TWideStringField;
    qryMaintillname: TWideStringField;
    qryMainTimeint: TWideStringField;
    qryMainTimeIntfrom: TWideStringField;
    qryMainNoOfsales: TIntegerField;
    qryMainNoOfCustomers: TIntegerField;
    qryMainNoOfProducts: TIntegerField;
    qryMainNoOfReturns: TIntegerField;
    qryMainNoOfReturnProducts: TIntegerField;
    qryMainItemsPercustomer: TIntegerField;
    qryMainQtyPerCustomer: TFloatField;
    qryMainSalesPerCustomer: TIntegerField;
    qryMainTotalsalesAmount: TFloatField;
    qryMainQty: TFloatField;
    qryMainUOMQty: TFloatField;
    qryMainTotalsalesAmountInc: TFloatField;
    qryMainsalesAmountIncPerItem: TFloatField;
    qryMainGPPerCustomer: TFloatField;
    qryMainGrossProfit: TFloatField;
    qryMainGPPerProduct: TFloatField;
    qryMainStress15: TIntegerField;
    qryMainStress5: TIntegerField;
    qryMainStreemorethan15: TIntegerField;
    qryMaintimeFrom: TDateTimeField;
    qryMainTimeTo: TDateTimeField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure cmdPrintClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
  private
    Tablename :String;
    procedure initDailySalesStatisticsDetails(Sender: TObject);
  Protected
    function GetReportTypeID: integer; Override;
  public
    Procedure RefreshQuery;Override;
    procedure SetGridColumns; Override;
  end;


implementation

uses CommonDbLib, CommonLib, POSLIB, CommonFormLib, DailySalesStatisticsDetails,
  MySQLConst, DateUtils;

{$R *.dfm}

{ TDailySalesStatisticsGUI }

procedure TDailySalesStatisticsGUI.cmdPrintClick(Sender: TObject);
begin
  TemplateSQL:= DailyStatisticsReportSQL(Tablename, dateof(filterdateTo) , filterDateTo);
   (*'{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, CO.PhoneNumber AS PhoneNumber, '+
        ' CO.FaxNumber AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO'+
        '~|||~{Details} ' +Qrymain.SQL.text+
        '~|||~{DateRange} Select ' + quotedstr(formatdateTime(MySQLDatetimeformat , dateof(filterdateTo)))+' as Datefrom ,  ' +
          quotedstr(formatdateTime(MySQLDatetimeformat , filterdateTo))+' as DateTo  from DUAL'+
        '~|||~{best3}Select DATE_FORMAT(T.TimeFrom	,"%h %p") as TimeIntfrom, '+
              ' concat(DATE_FORMAT(T.TimeFrom	,"%h %p"), " - " , DATE_FORMAT(T.TimeTo	,"%h %p")) as Timeint  , '+
              ' sum(T.NoOfsales) totalSales from ' +tablename +' T group by timefrom order by totalSales desc  , TimeFrom limit 3'+
        '~|||~{worst3}Select DATE_FORMAT(T.TimeFrom	,"%h %p") as TimeIntfrom, '+
              ' concat(DATE_FORMAT(T.TimeFrom	,"%h %p"), " - " , DATE_FORMAT(T.TimeTo	,"%h %p")) as Timeint  , '+
              ' sum(T.NoOfsales) totalSales from ' +tablename +' T group by timefrom order by totalSales ,TimeFrom limit 3'+
        '~|||~{StaffPerformace}Select '+
              ' HSE.employeename highestSaleBy , HSE.noofsales HighestSale, '+
              ' LSE.employeename LowestSaleBy , LSE.noofsales LowestSale  from  '+
              ' (sELECT E.employeeName , noofsales FROM '+Tablename+' T inner join tblemployees E on T.employeeId = E.employeeId group by T.employeeID order by  noofsales desc limit 1) HSE , '+
              ' (sELECT E.employeeName , noofsales FROM '+Tablename+' T inner join tblemployees E on T.employeeId = E.employeeId group by T.employeeID order by  noofsales limit 1) LSE';*)

  ReportSQLSupplied := True;
  inherited;

end;

procedure TDailySalesStatisticsGUI.FormCreate(Sender: TObject);
begin
  Tablename:= GetUserTemporaryTableName('DailyStatistics');
  Qrymain.sQL.clear;
  Qrymain.sQL.text := HourlySalesStatisticsSQL(Tablename );
  (*Qrymain.sQL.Add('select');
  Qrymain.sQL.Add('T.EmployeeId	          as EmployeeId         ,');
  Qrymain.sQL.Add('e.EmployeeName         as EmployeeName       ,');
  Qrymain.sQL.Add('DATE_FORMAT(T.TimeFrom	,"%h %p") as TimeIntfrom,');
  Qrymain.sQL.Add('concat(DATE_FORMAT(T.TimeFrom	,"%h %p"), " - " , DATE_FORMAT(T.TimeTo	,"%h %p")) as Timeint  ,');
  Qrymain.sQL.Add('T.NoOfsales	          as NoOfsales          ,');
  Qrymain.sQL.Add('T.NoOfCustomers	      as NoOfCustomers      ,');
  Qrymain.sQL.Add('T.NoOfProducts	        as NoOfProducts       ,');
  Qrymain.sQL.Add('T.NoOfReturns	        as NoOfReturns        ,');
  Qrymain.sQL.Add('T.NoOfReturnProducts	  as NoOfReturnProducts ,');
  Qrymain.sQL.Add('T.ItemsPercustomer	    as ItemsPercustomer   ,');
  Qrymain.sQL.Add('T.SalesPerCustomer	    as SalesPerCustomer   ,');
  Qrymain.sQL.Add('T.TotalsalesAmount	    as TotalsalesAmount   ,');
  Qrymain.sQL.Add('T.TotalsalesAmountInc  as TotalsalesAmountInc,');
  Qrymain.sQL.Add('T.GrossProfit	      as GrossProfit      ,');
  Qrymain.sQL.Add('T.GPPerCustomer	      as GPPerCustomer      ,');
  Qrymain.sQL.Add('T.GPPerProduct	        as GPPerProduct       ,');
  Qrymain.sQL.Add('T.Stress15	            as Stress15           ,');
  Qrymain.sQL.Add('T.Stress5	            as Stress5            ,');
  Qrymain.sQL.Add('T.Streemorethan15      as Streemorethan15'     );
  Qrymain.sQL.Add('from '+tablename+' T');
  Qrymain.sQL.Add('inner join tblemployees e on T.employeeId = E.employeeId');
  Qrymain.sQL.Add('order by employeename , timeFrom');*)
  inherited;
  DtTo.Date := Date;
  fbDateRangeSupplied := True;
  DisableSortoncolumtitleclick:= TRue;
  AddCalcColumn(qryMainNoOfsales.fieldname          , False);
  AddCalcColumn(qryMainNoOfCustomers.fieldname      , False);
  AddCalcColumn(qryMainNoOfProducts.fieldname       , False);
  AddCalcColumn(qryMainNoOfReturns.fieldname        , False);
  AddCalcColumn(qryMainNoOfReturnProducts.fieldname , False);
  AddCalcColumn(qryMainStress15.fieldname           , False);
  AddCalcColumn(qryMainStress5.fieldname            , False);
  AddCalcColumn(qryMainStreemorethan15.fieldname    , False);
  AddCalcColumn(qryMainTotalsalesAmount.fieldname   , True);
  AddCalcColumn(qryMainQty.fieldname   , False);
  AddCalcColumn(qryMainUOMQty.fieldname   , False);
  AddCalcColumn(qryMainTotalsalesAmountInc.fieldname, True);
(*  AddCalcColumn(qryMainsalesAmountIncPerItem.fieldname, True);*)
end;

procedure TDailySalesStatisticsGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(Tablename);
  inherited;

end;


procedure TDailySalesStatisticsGUI.FormShow(Sender: TObject);
begin
  DtTo.Date := Date;
  fbDateRangeSupplied := True;
  inherited;

end;

function TDailySalesStatisticsGUI.GetReportTypeID: integer;
begin
  Result := 141;
end;

procedure TDailySalesStatisticsGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if (Field is TFloatfield  ) and (Field.asfloat   =0) then Afont.color := Abrush.color;
  if (Field is TIntegerField) and (Field.asInteger =0) then Afont.color := Abrush.color;
end;

procedure TDailySalesStatisticsGUI.grdMainDblClick(Sender: TObject);
begin
//  inherited;
  OpenERPListForm('TDailySalesStatisticsDetailsGUI', initDailySalesStatisticsDetails );
end;
procedure TDailySalesStatisticsGUI.initDailySalesStatisticsDetails(Sender:TObject);
begin
  if not (Sender is   TDailySalesStatisticsDetailsGUI) then exit;
  TDailySalesStatisticsDetailsGUI(Sender).EmployeeId := QrymainEmployeeId.asInteger;
  //TDailySalesStatisticsDetailsGUI(Sender).ReportAsOn := FilterdateTo;
  TDailySalesStatisticsDetailsGUI(Sender).DtFrom.dateTime := 0;
  TDailySalesStatisticsDetailsGUI(Sender).DtTo.dateTime := QrymaintimeTo.asdateTime;
  TDailySalesStatisticsDetailsGUI(Sender).DtFrom.dateTime := QrymaintimeFrom.asdateTime;
  TDailySalesStatisticsDetailsGUI(Sender).fbdaterangesupplied := true;

end;
procedure TDailySalesStatisticsGUI.RefreshQuery;
begin
  MakeHourlySalesStatistics(Tablename , trunc(FilterDateTo) , filterdateTo , 0);
  inherited;

end;
procedure TDailySalesStatisticsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('Timefrom');
  RemoveFieldfromGrid('Timeto');
end;

initialization
  RegisterClassOnce(TDailySalesStatisticsGUI);

end.
