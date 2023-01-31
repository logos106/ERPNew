unit DailySalesStatisticsDetails;

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
  TDailySalesStatisticsDetailsGUI = class(TBaseListingGUI)
    qryMainDetails: TLargeintField;
    qryMainSaleId: TIntegerField;
    qryMaintimestlot: TWideStringField;
    qryMainCustomerName: TWideStringField;
    qryMainemployeeId: TIntegerField;
    qryMainEmployeeName: TWideStringField;
    qryMainsAleDatetime: TDateTimeField;
    qryMainPreviousSaleDateTime: TDateTimeField;
    qryMainProductName: TWideStringField;
    qryMainUOM: TWideStringField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainshipped: TFloatField;
    qryMainTotalAmount: TFloatField;
    qryMainTotalAmountInc: TFloatField;
    qryMainSecondsFromPreviousSale: TIntegerField;
    qryMainUnder5Secs: TBooleanField;
    qryMainUnder15Secs: TBooleanField;
    qryMainOver15secs: TBooleanField;
    procedure grpFiltersClick(Sender: TObject);override;
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
  private
    fiEmployeeId: Integer;
    Tablename :String;
    //fdReportAsOn: TDateTime;
    procedure setEmployeeID(const Value: Integer);
    //procedure setReportAsOn(const Value: TDateTime);
    Procedure MakeQrymain;
    procedure MakeTimeSumTable;
  Protected
    procedure SetGridColumns; Override;
    Procedure RefreshTotals;override;
    Procedure CalcFooter;override;
  public
    Property EmployeeId :Integer read fiEmployeeId write setEmployeeID;
    //Property ReportAsOn :TDateTime read fdReportAsOn write setReportAsOn;
    Procedure RefreshQuery;Override;
  end;

implementation

uses CommonLib, dateutils, CommonDbLib, POSLIB;

{$R *.dfm}

{ TDailySalesStatisticsDetailsGUI }

procedure TDailySalesStatisticsDetailsGUI.CalcFooter;
begin
  if (grpfilters.itemindex =1) and (Qrymaindetails.asInteger =1) then exit;
  inherited;

end;

procedure TDailySalesStatisticsDetailsGUI.FormCreate(Sender: TObject);
begin
  Tablename:= GetUserTemporaryTableName('DailyStatisticsDetails');
  MakeQrymain;
  inherited;
  DtTo.Date := Date;
  fbDateRangeSupplied := True;
  DisableSortoncolumtitleclick:= TRue;
  AddCalcColumn(qryMainUnitofMeasureShipped.fieldname, False);
  AddCalcColumn(qryMainshipped.fieldname, False);
  AddCalcColumn(qryMainTotalAmount.fieldname , true);
  AddCalcColumn(qryMainTotalAmountInc.fieldname, true);
(*  grdmain.hint := 'A -> No of Sales : Total Number of POS transactions made for the time Period' + NL+
                  'B -> No of Customers : Total Number of Customers in all POS transactions for the time Period' + NL+
                  'C -> No of Products : Total Number of Products sold in all POS transactions for the time Period' + NL+
                  'D -> No of Return Products : Total Number of Products Returned in all POS transactions for the time Period' + NL+
                  'E -> No of Return Sales : Total Number of Return POS transactions for the time Period' + NL+
                  'F -> Average Per Customers - No of Products Sold : (C) / (B) ie.  Total Number of Products in all POS transactions for the time Period / Total Number of Customers' + NL+
                  'G -> Average Per Customers - No of Sales : (A) / (B) ie.  Total Number of POS transactions for the time Period / Total Number of Customers' + NL+
                  'H -> Total Amount (Ex) : Total Ex amount of All POS transactions for the time Period' + NL+
                  'I -> Total Amount (Inc) : Total Inc amount of All POS transactions for the time Period' + NL+*)
end;

procedure TDailySalesStatisticsDetailsGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(TableName);
  inherited;
end;

procedure TDailySalesStatisticsDetailsGUI.FormShow(Sender: TObject);
begin
  inherited;
  if grpfilters.ItemIndex <0 then grpfilters.ItemIndex:= 0;
  grpfiltersclick(grpfilters);
end;

procedure TDailySalesStatisticsDetailsGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if grpfilters.ItemIndex = 0 then begin
    Afont.Style := Afont.Style - [fsbold];
  end else if grpfilters.ItemIndex = 1 then begin
    if qrymaindetails.AsInteger =1  then Afont.Style := Afont.Style + [fsbold];
    if (qrymaindetails.AsInteger =2) then begin
      if  Sametext(field.FieldName , qryMaintimestlot.FieldName)  then Afont.color := Abrush.Color;
      if  Sametext(field.FieldName , qryMainSaleID.FieldName)  then Afont.color := Abrush.Color;
      if  Sametext(field.FieldName , qryMainCustomername.FieldName)  then Afont.color := Abrush.Color;
      if  Sametext(field.FieldName , qryMainEmployeename.FieldName)  then Afont.color := Abrush.Color;
    end;
  end;
end;

procedure TDailySalesStatisticsDetailsGUI.grpFiltersClick(Sender: TObject);
begin
  if grpfilters.itemindex =0 then GroupfilterString :='Details =1'
  else GroupfilterString :='';
  inherited;

end;

procedure TDailySalesStatisticsDetailsGUI.MakeQrymain;
begin
Qrymain.SQL.clear;
Qrymain.SQL.add('Select');
Qrymain.SQL.add('2 Details,');
Qrymain.SQL.add('s.saleId as SaleId,');
Qrymain.SQL.add('s.SaledateTime  as Saledate_Time,');
Qrymain.SQL.add('concat(DATE_FORMAT( S.SaleDatetime, "%h %p"), " - " , DATE_FORMAT( DAte_Add(S.SaleDatetime, interval 1 hour), "%h %p")) timestlot,');
Qrymain.SQL.add('S.CustomerName as CustomerName,');
Qrymain.SQL.add('s.employeeId as employeeId,');
Qrymain.SQL.add('E.EmployeeName as EmployeeName,');
Qrymain.SQL.add('S.sAleDatetime as sAleDatetime,');
Qrymain.SQL.add('SL.ProductName as ProductName,');
Qrymain.SQL.add('Concat(SL.UnitofMeasureSaleLines , " (" , SL.UnitofMeasureMultiplier , ")" ) as UOM,');
Qrymain.SQL.add('SL.UnitofMeasureShipped  as UnitofMeasureShipped ,');
Qrymain.SQL.add('SL.Shipped as shipped,');
Qrymain.SQL.add('SL.TotalLineAmount as TotalAmount,');
Qrymain.SQL.add('SL.TotalLineAmountInc as TotalAmountInc,');
Qrymain.SQL.add('(Select max(PS.saleDateTime) from '+ tablename +' PS where PS.classID = S.classId and PS.SaleDateTime< S.saledatetime) as PreviousSaleDateTime');
Qrymain.SQL.add('from tblsales S');
Qrymain.SQL.add('inner join tblsaleslines SL on SL.saleId = S.saleId');
Qrymain.SQL.add('inner join tblemployees E on S.employeeId= E.employeeId');
Qrymain.SQL.add('where S.saleDateTime between :dateFrom and :DateTo');
Qrymain.SQL.add('union all');
Qrymain.SQL.add('Select');
Qrymain.SQL.add('1 Details,');
Qrymain.SQL.add('s.saleId as SaleId,');
Qrymain.SQL.add('s.SaledateTime  as Saledate_Time,');
Qrymain.SQL.add('concat(DATE_FORMAT( S.SaleDatetime, "%h %p"), " - " , DATE_FORMAT( DAte_Add(S.SaleDatetime, interval 1 hour), "%h %p")) timestlot,');
Qrymain.SQL.add('S.CustomerName as CustomerName,');
Qrymain.SQL.add('s.employeeId as employeeId,');
Qrymain.SQL.add('E.EmployeeName as EmployeeName,');
Qrymain.SQL.add('S.sAleDatetime as sAleDatetime,');
Qrymain.SQL.add('NULL as ProductName,');
Qrymain.SQL.add('Null as UOM,');
Qrymain.SQL.add('NULL as UnitofMeasureShipped ,');
Qrymain.SQL.add('NULL as shipped,');
Qrymain.SQL.add('S.TotalAmount as TotalAmount,');
Qrymain.SQL.add('S.TotalAmountInc as TotalAmountInc,');
Qrymain.SQL.add('(Select max(PS.saleDateTime) from '+ tablename +' PS where PS.classID = S.classId and PS.SaleDateTime< S.saledatetime) as PreviousSaleDateTime');
Qrymain.SQL.add('from tblsales S');
Qrymain.SQL.add('inner join tblemployees E on S.employeeId= E.employeeId');
Qrymain.SQL.add('where S.saleDateTime between :dateFrom and :DateTo');
Qrymain.SQL.add('union all');
Qrymain.SQL.add('Select');
Qrymain.SQL.add('2 Details,');
Qrymain.SQL.add('s.saleId as SaleId,');
Qrymain.SQL.add('s.SaledateTime  as Saledate_Time,');
Qrymain.SQL.add('concat(DATE_FORMAT( S.SaleDatetime, "%h %p"), " - " , DATE_FORMAT( DAte_Add(S.SaleDatetime, interval 1 hour), "%h %p")) timestlot,');
Qrymain.SQL.add('S.CustomerName as CustomerName,');
Qrymain.SQL.add('s.employeeId as employeeId,');
Qrymain.SQL.add('E.EmployeeName as EmployeeName,');
Qrymain.SQL.add('S.sAleDatetime as sAleDatetime,');
Qrymain.SQL.add('SL.ProductName as ProductName,');
Qrymain.SQL.add('Concat(SL.UnitofMeasureSaleLines , " (" , SL.UnitofMeasureMultiplier , ")" ) as UOM,');
Qrymain.SQL.add('SL.UnitofMeasureShipped  as UnitofMeasureShipped ,');
Qrymain.SQL.add('SL.Shipped as shipped,');
Qrymain.SQL.add('SL.TotalLineAmount as TotalAmount,');
Qrymain.SQL.add('SL.TotalLineAmountInc as TotalAmountInc,');
Qrymain.SQL.add('(Select max(PS.saleDateTime) from '+ tablename +' PS where PS.classID = S.classId and PS.SaleDateTime< S.saledatetime) as PreviousSaleDateTime');
Qrymain.SQL.add('from tblsales_pos S');
Qrymain.SQL.add('inner join tblsaleslines_pos SL on SL.saleId = S.saleId');
Qrymain.SQL.add('inner join tblemployees E on S.employeeId= E.employeeId');
Qrymain.SQL.add('where S.saleDateTime between :dateFrom and :DateTo');
Qrymain.SQL.add('union all');
Qrymain.SQL.add('Select');
Qrymain.SQL.add('1 Details,');
Qrymain.SQL.add('s.saleId as SaleId,');
Qrymain.SQL.add('s.SaledateTime  as Saledate_Time,');
Qrymain.SQL.add('concat(DATE_FORMAT( S.SaleDatetime, "%h %p"), " - " , DATE_FORMAT( DAte_Add(S.SaleDatetime, interval 1 hour), "%h %p")) timestlot,');
Qrymain.SQL.add('S.CustomerName as CustomerName,');
Qrymain.SQL.add('s.employeeId as employeeId,');
Qrymain.SQL.add('E.EmployeeName as EmployeeName,');
Qrymain.SQL.add('S.sAleDatetime as sAleDatetime,');
Qrymain.SQL.add('NULL as ProductName,');
Qrymain.SQL.add('Null as UOM,');
Qrymain.SQL.add('NULL as UnitofMeasureShipped ,');
Qrymain.SQL.add('NULL as shipped,');
Qrymain.SQL.add('S.TotalAmount as TotalAmount,');
Qrymain.SQL.add('S.TotalAmountInc as TotalAmountInc,');
Qrymain.SQL.add('(Select max(PS.saleDateTime) from '+ tablename +' PS where PS.classID = S.classId and PS.SaleDateTime< S.saledatetime) as PreviousSaleDateTime');
Qrymain.SQL.add('from tblsales_pos S');
Qrymain.SQL.add('inner join tblemployees E on S.employeeId= E.employeeId');
Qrymain.SQL.add('where S.saleDateTime between :dateFrom and :DateTo');
Qrymain.SQL.add('order by  Saledate_Time,details');

end;

procedure TDailySalesStatisticsDetailsGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  if qryMainPreviousSaleDateTime.AsDateTime =0 then qryMainSecondsFromPreviousSale.asinteger :=  0 else
  qryMainSecondsFromPreviousSale.asinteger :=  SecondsBetween(qryMainsAleDatetime.AsDateTime,qryMainPreviousSaleDateTime.AsDateTime);
  qryMainUnder5Secs.AsBoolean   := qryMainSecondsFromPreviousSale.asinteger <=5;
  qryMainUnder15Secs.AsBoolean  := qryMainSecondsFromPreviousSale.asinteger <=15;
  qryMainOver15secs.AsBoolean   := qryMainSecondsFromPreviousSale.asinteger > 15;
end;
Procedure TDailySalesStatisticsDetailsGUI.MakeTimeSumTable;
begin
    With ScriptMain do try
      SQL.add(POSSalesTime(Tablename));
    finally
      Execute;
      SQL.Clear;
    end;

end;
procedure TDailySalesStatisticsDetailsGUI.RefreshQuery;
begin
  MakeTimesumTable;
  Qrymain.parambyname('DateTo').asDateTime := dtTo.dateTime;
  Qrymain.parambyname('DateFrom').asDateTime := dtFrom.dateTime;
  inherited;

end;

procedure TDailySalesStatisticsDetailsGUI.RefreshTotals;
begin
  CalcnShowfooter;

end;

procedure TDailySalesStatisticsDetailsGUI.setEmployeeID(const Value: Integer);
begin
  fiEmployeeId := Value;
  FilterString := 'EmployeeId ='+inttostr(Value);
end;

procedure TDailySalesStatisticsDetailsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainDetails.fieldname);
  RemoveFieldfromGrid(qryMainemployeeId.fieldname);
  RemoveFieldfromGrid(qryMaintimestlot.fieldname);
end;

(*procedure TDailySalesStatisticsDetailsGUI.setReportAsOn(const Value: TDateTime);
begin
  fdReportAsOn := Value;
  DtTo.Date := Value;
  fbDateRangeSupplied := True;
end;*)

initialization
  RegisterClassOnce(TDailySalesStatisticsDetailsGUI);
end.
