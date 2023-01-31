unit HourlySalesReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel, jpeg, CustomInputBox;

type
  THourlySalesReportGUI = class(TBaseListingGUI)
    grpAmount: TRadioGroup;
    grdSalesCAtegory: TRadioGroup;
    btnPeriods: TDNMSpeedButton;
    DNMPanel1: TDNMPanel;
    Label4: TLabel;
    QrymainFooterTotals:TERPQuery;
    ChkshowSystemDate: TwwCheckBox;
    qryMainSaleDateTime: TDateTimeField;
    qryMainSaledate: TDateField;
    qryMainSaleType: TWideStringField;
    qryMainDocNumber: TWideStringField;
    qryMainCustomerName: TWideStringField;
    qryMainDepartment: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainProduct_Description: TWideStringField;
    qryMainShipped: TFloatField;
    qryMainSAleId: TLargeintField;
    qryMainSaleLineID: TLargeintField;
    lbltotalSales: TLabel;
    qryMainTotalSalesAmount: TFloatField;
    dtDaystart: TwwDBDateTimePicker;
    Label5: TLabel;
    QryfieldNames: TERPQuery;
    btnPreviousDay: TImage;
    btnNextDay: TImage;
    QrymainTotals: TERPQuery;
    Label6: TLabel;
    procedure grpFiltersClick(Sender: TObject); override;
    procedure FormShow(Sender: TObject);
    procedure ChkshowSystemDateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPeriodsClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure btnNextDayClick(Sender: TObject);
    procedure btnPreviousDayClick(Sender: TObject);
    procedure dtToChange(Sender: TObject);
    procedure dtFromChange(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);override;
  private
    fbdontRefresh:Boolean;
    function DoConfig: boolean;
    procedure DoGridcolumns;
    procedure AddFieldstoQrymain;
    function FieldNameSQL(const HavelineBreak:boolean = True): String;
    procedure CheckforPeriods;
    procedure MakeQrymain(const totalField: STring);
    function ISAmountField(const FieldName: String): Boolean;
    procedure ChangeDate(Dfrom, dto: TDateTime);
    Procedure BeforesalesreportDetailsShow(Sender:TObject);
  Protected
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    procedure SetGridColumns; Override;
    Procedure RefreshTotals;override;
    function GetReportTypeID: integer; override;
  public
    Procedure RefreshQuery;override;

  end;


implementation

uses CommonLib, DataTreeObj, MySQLConst, CommonDbLib,
  frmHourlySalesReportConfig, dateutils, AppEnvironment, 
  salesreportDetails, CommonFormLib, tcDataUtils;

{$R *.dfm}

procedure THourlySalesReportGUI.BeforesalesreportDetailsShow(Sender: TObject);
var
  s:String;
begin
  if not(Sender is TsalesreportDetailsGUI) then exit;
  TsalesreportDetailsGUI(Sender).ISOnlyPOS := grdSalesCAtegory.itemindex = 0;
  try
    s:=ActiveField.FieldName ;
    TsalesreportDetailsGUI(Sender).DateFrom:= 0;
    TsalesreportDetailsGUI(Sender).Dateto := QrymainSaledate.asDateTime +QryfieldNames.FieldByname(replaceStr(s ,'salesAmount_' , 'SalesAmounttimeTo_')).asDateTime ;
    TsalesreportDetailsGUI(Sender).DateFrom:= QrymainSaledate.asDateTime +QryfieldNames.FieldByname(replaceStr(s,'salesAmount_' , 'SalesAmounttime_')).asDateTime ;
  Except
    // kill the exception
  end;
  TsalesreportDetailsGUI(Sender).GrpfilterSupplied := true;
  TsalesreportDetailsGUI(Sender).fbDateRangeSupplied:= True;
end;

procedure THourlySalesReportGUI.btnNextDayClick(Sender: TObject);
var
  dFrom, dTo:TDatetime;
begin
  inherited;
  dFrom := incDay(DtFrom.DateTime,1);
  Dto:= incday(dtTo.DateTime,1);
  ChangeDate(Dfrom, DTo);
  ChkshowSystemDate.Checked := False;
end;

procedure THourlySalesReportGUI.btnPeriodsClick(Sender: TObject);
begin
  inherited;
    if DoConfig then begin
      RefreshQuery;
    end;
end;
procedure THourlySalesReportGUI.btnPreviousDayClick(Sender: TObject);
var
  dFrom, dTo:TDatetime;
begin
  inherited;
  dFrom := incDay(DtFrom.DateTime,-1);
  Dto:= incday(dtTo.DateTime,-1);
  ChangeDate(Dfrom, DTo);
  ChkshowSystemDate.Checked := False;
end;

Procedure THourlySalesReportGUI.CheckforPeriods;
begin
  inherited;
    if GuiPrefs.Node.ItemByName['TimeList'].Count = 0 then begin
      TfmHourlySalesReportConfig.AutoPopulate(TDataTreeNode(GuiPrefs.Node.ItemByName['TimeList']));
    end;
      fbdontRefresh:= True;
      try
        ReadnApplyGuiPrefExtra;
      finally
        fbdontRefresh:= False;
        RefreshQuery;
      end;
end;
procedure THourlySalesReportGUI.ChkshowSystemDateClick(Sender: TObject);
var
  dFrom, dTo:TDatetime;
begin
  if ChkshowSystemDate.checked then begin
      if (dtDaystart.time >= strToTime('12:00:00 PM')) and (timeOf(Now) < strToTime('12:00:00 PM'))  then
           dFrom:= incday (date, -1) + dtDaystart.time
      else dFrom:= date + dtDaystart.time;
      dTo:= incsecond(incday(dFrom,1), -1);

      ChangeDate(Dfrom, DTo);
  end;
end;

procedure THourlySalesReportGUI.ChangeDate(Dfrom , dto:TDateTime);
var
  dtFromCloseup, dtTocloseup , dtFromChange, dtTochange:TNotifyEvent;
begin
  inherited;

    dtTochange  := DTTo.OnChange  ;DtFromChange   := dtFrom.OnChange;
    dtToCloseup := DTTo.OnCloseup ;DtFromCloseup  := dtFrom.OnCloseup;
    try
      DTTo.OnChange:= NIL; dtFrom.OnChange:= NIL;
      DTTo.OnCloseup := NIL;dtFrom.OnCloseup:= nil;

(*      if (dtDaystart.time >= strToTime('12:00:00 PM')) and (timeOf(Now) < strToTime('12:00:00 PM'))  then
        DtFrom.DateTime := incday (date, -1) + dtDaystart.time
      else
        DtFrom.DateTime := date + dtDaystart.time;

      dtTo.Datetime := incsecond(incday(DtFrom.DateTime), -1);*)
      dtFrom.dateTime := DFrom;
      DtTo.Datetime := dTo;
      RefreshQuery;
    finally
      DTTo.OnChange:= dtTochange; dtFrom.OnChange:= DtFromChange;
      DTTo.OnCloseup := dtToCloseup;dtFrom.OnCloseup:= DtFromCloseup;
    end;
end;

procedure THourlySalesReportGUI.cmdPrintClick(Sender: TObject);
var
  SQL:String;
begin
//  inherited;
  ReportToPrint :=    tcdatautils.GetDefaultReport(GetReportTypeID);
  if ReportToPrint ='' then ReportToPrint := 'Hourly Sales Report';
  SQL:= '{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, '+
        ' Concat("Phone :",CO.PhoneNumber) AS PhoneNumber, Concat("  Fax :",CO.FaxNumber) AS FaxNumber,  '+
        ' CO.ABN FROM tblCompanyInformation AS CO '+
        '~|||~{Details}' +Qrymain.SQL.Text+
        '~|||~{FieldNames}' + FieldNameSQL(False)+ ',' +quotedstr(lbltotalSales.caption) +' as TotalSales';
  ReportSQLSupplied:= True;
  PrintTemplateReport(ReportToPrint , SQL, not(Appenv.Employee.ShowPreview) ,1 );
end;

function THourlySalesReportGUI.DoConfig: boolean;
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

procedure THourlySalesReportGUI.FormCreate(Sender: TObject);
begin
  btnPreviousDay.visible:= Devmode;
  btnNextDay.visible:= Devmode;
  inherited;
  fbdontRefresh:=False;
end;

procedure THourlySalesReportGUI.FormShow(Sender: TObject);
begin
  fbDateRangeSupplied:= True;
  inherited;
  checkforPeriods;
  btnCustomize.Enabled:= False;
end;

function THourlySalesReportGUI.GetReportTypeID: integer;
begin
  REsult := 113;
end;

procedure THourlySalesReportGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  try
    if grpfilters.itemindex = 0 then
      if QrymainSaledate.asDateTime >0 then
        if ISAmountField(Field.fieldname) then begin
          if (QrymainSaledate.asDateTime +QryfieldNames.FieldByname(replaceStr(Field.fieldname ,'salesAmount_' , 'SalesAmounttime_')).asDateTime < DtFrom.DateTime) or
            (QrymainSaledate.asDateTime +QryfieldNames.FieldByname(replaceStr(Field.fieldname ,'salesAmount_' , 'SalesAmounttime_')).asDateTime > DtTo.DateTime) then
              ABrush.color := ClGray;
        end;
  Except
    // kill the exception
  end;
end;

procedure THourlySalesReportGUI.grdMainDblClick(Sender: TObject);
begin


  if QrymainSaleID.asInteger <> 0 then begin
    SubsequentID := Chr(95) + qryMainSaleType.AsString;
    inherited;
  end else begin
    if isAmountfield(activeField.Fieldname) then
      if activeField.Asfloat = 0 then else begin
        OpenERPListForm('TsalesreportDetailsGUI' , beforesalesreportDetailsshow);
        if not devmode then Self.Close;
      end;
  end;

end;

procedure THourlySalesReportGUI.grpFiltersClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure THourlySalesReportGUI.ReadnApplyGuiPrefExtra;
var
  x:Integer;
begin
  inherited;
      if GuiPrefs.Node.Exists('grpAmount') then begin
        x := GuiPrefs.Node['grpAmount.ItemIndex'].asInteger;
        if x > 0 then if grpAmount.Items.Count >= x then grpAmount.ItemIndex := x - 1;
      end;

      if GuiPrefs.Node.Exists('grdSalesCAtegory') then begin
        x := GuiPrefs.Node['grdSalesCAtegory.ItemIndex'].asInteger;
        if x > 0 then if grdSalesCAtegory.Items.Count >= x then grdSalesCAtegory.ItemIndex := x - 1;
      end;
      if GuiPrefs.Node.Exists('Options.InitToSystemDate') then begin
        ChkshowSystemDate.checked := GuiPrefs.Node['Options.InitToSystemDate'].asBoolean;
        ChkshowSystemDateClick(ChkshowSystemDate);
      end;
(*      if GuiPrefs.Node.Exists('Options.DateRange') then begin
        dtTo.Datetime := GuiPrefs.Node['Options.DateRange.ToDate'].AsDateTime;
        DtFrom.Datetime := GuiPrefs.Node['Options.DateRange.FromDate'].AsDateTime;
        dtDaystart.Time := GuiPrefs.Node['Options.DateRange.DayStart'].AsDateTime;
      end else begin
        dtTo.Datetime := incSecond( incday(Date,1), -1);
        DtFrom.DateTime := Date;
        dtDaystart.Time := strtoTime('12:00:00 AM');
      end;*)
      dtTo.Datetime := incSecond( incday(Date,1), -1);
      DtFrom.DateTime := Date;
      dtDaystart.Time := strtoTime('12:00:00 AM');
end;
Procedure THourlySalesReportGUI.MakeQrymain(const totalField:STring);
var
  node: TDataTreeNode;
  x:Integer;
  ctr:Integer;
  Qry:TERPQuery;
  timefrom, timeTo:TDateTime;
begin
    for ctr:= 1 to 2 do begin
          if ctr= 1 then Qry := Qrymain else Qry := QrymainTotals;
          Qry.SQL.clear;
          Qry.SQL.Add('Select ');
          if ctr = 1 then begin
            Qry.SQL.add('s.SaleDateTime as SaleDateTime, ');

            if grpfilters.ItemIndex =0 then begin
              Qry.SQL.Add('CAST( Null as SIGNED)    as SAleId, ');
              Qry.SQL.Add('CAST( Null as CHAR(100)) as SaleType, ');
              Qry.SQL.Add('CAST( Null as SIGNED)    as SaleLineID, ');
              Qry.SQL.Add('CAST( Null as CHAR(100)) as DocNumber, ');
              Qry.SQL.Add('CAST( Null as CHAR(100)) as CustomerName, ');
              Qry.SQL.Add('CAST( Null as CHAR(100)) as Department,');
              Qry.SQL.Add('CAST( NULL as CHAR(100)) as ProductName, ');
              Qry.SQL.Add('CAST( NULL as CHAR(100)) as Product_Description, ');
              Qry.SQL.Add('CAST( NULL as Decimal)   as Shipped ,');
            end else if grpfilters.Itemindex = 1 then begin
              Qry.SQL.Add('CAST( s.SAleId           as SIGNED)                as  SaleID, ');
              Qry.SQL.Add('CAST( if(s.IsPOS = "T", "POS", if(s.IsCashSale = "T" ,  "Cash Sale", if(s.IsInvoice = "T" , "Invoice" ,""))) as CHAR(100)) as "SaleType",');
              Qry.SQL.Add('CAST( Null as SIGNED)    as SaleLineID, ');
              Qry.SQL.Add('CAST( s.InvoiceDocNumber as CHAR(100)) as DocNumber,');
              Qry.SQL.Add('CAST( s.CustomerName     as CHAR(100)) as CustomerName, ');
              Qry.SQL.Add('CAST( s.Class            as CHAR(100)) as Department,');
              Qry.SQL.Add('CAST( NULL as CHAR(100)) as ProductName, ');
              Qry.SQL.Add('CAST( NULL as CHAR(100)) as Product_Description, ');
              Qry.SQL.Add('CAST( NULL as Decimal)   as Shipped ,');
            end else begin
              Qry.SQL.Add('CAST( s.SAleId           as SIGNED)  as SaleID,  ');
              Qry.SQL.Add('CAST( if(s.IsPOS = "T", "POS", if(s.IsCashSale = "T" ,  "Cash Sale", if(s.IsInvoice = "T" , "Invoice" ,""))) as CHAR(100)) as "SaleType",');
              Qry.SQL.Add('CAST( Sl.SaleLineID      as SIGNED) as SaleLineID,  ');
              Qry.SQL.Add('CAST( s.InvoiceDocNumber as CHAR(100))  as DocNumber,  ');
              Qry.SQL.Add('CAST( s.CustomerName     as CHAR(100))   as CustomerName,  ');
              Qry.SQL.Add('CAST( s.Class            as CHAR(100))   as Department,');
              Qry.SQL.Add('CAST( sl.ProductName     as CHAR(100))   as ProductName, ');
              Qry.SQL.Add('CAST( sl.Product_Description as CHAR(100))  as Product_Description, ');
              Qry.SQL.Add('CAST( sl.Shipped         as Decimal  )   as Shipped,');
            end;
          end;

          node:= TDataTreeNode(GuiPrefs.Node.ItemByName['TimeList']);
          timeFrom  := 0;
          Timeto    := 0;
          if node.Count > 0 then begin
            timeFrom  := node.Items[0]['TimeFrom'].AsDateTime;
            Timeto    := node.Items[0]['TimeTo'].AsDateTime;
            for x:= 0 to node.Count -1 do begin
                if timeFrom  > node.Items[x]['TimeFrom'].AsDateTime then timeFrom  := node.Items[x]['TimeFrom'].AsDateTime;
                if Timeto    < node.Items[x]['TimeTo'].AsDateTime   then Timeto    := node.Items[x]['TimeTo'].AsDateTime;

                Qry.SQL.Add(' Sum(IF(time(s.SaleDateTime ) >= ' + QuotedStr(FormatDateTime(MysqlTimeFormat,node.Items[x]['TimeFrom'].AsDateTime)) +
                  ' AND time(s.SaleDateTime ) < ' +QuotedStr(FormatDateTime(MysqlTimeFormat,node.Items[x]['TimeTo'].AsDateTime)) +
                  ', ' + totalField +', CAST( NULL as Decimal))'+
                    ') as SalesAmount_'+ inttostr(x)+',' );
            end;
          end;

          Qry.SQL.Add(' Sum(IF(time(s.SaleDateTime ) >= ' + QuotedStr(FormatDateTime(MysqlTimeFormat,TimeFrom)) +
                  ' AND time(s.SaleDateTime ) < ' +QuotedStr(FormatDateTime(MysqlTimeFormat,TimeTo)) +
                  ', ' + totalField +', CAST( NULL as Decimal))'+
                    ')   as TotalSalesAmount,' );

          if ctr = 1 then Qry.SQL.add('Date(s.SaleDateTime) Saledate')
          else Qry.SQL.add('Count(s.SaleID) as totalSales');

          Qry.SQL.Add('FROM tblSales s ');
          if grpFilters.ItemIndex >1   then Qry.SQL.Add('INNER JOIN tblSalesLines sl USING(SaleId) ');
          Qry.SQL.Add('WHERE S.Cancelled = "F" and S.Deleted ="F"  ');

          if grdSalesCAtegory.ItemIndex = 0 then begin
            Qry.SQL.Add('AND (s.IsPos = "T")');
          end  else begin
            Qry.SQL.Add('AND (s.IsPos = "T" OR s.IsCashSAle = "T" OR s.IsInvoice = "T")');
          end;

          Qry.SQL.Add('AND s.SaleDateTime >= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,iif(chkIgnoreDates.checked , filterDateFrom , DtFrom.DateTime))));
          Qry.SQL.Add('AND s.SaleDateTime < ' + QuotedStr(FormatDateTime(MysqlDatetimeFormat, iif(chkIgnoreDates.checked , filterDateTo , dtTo.DateTime))));

          if ctr = 1 then begin
            if grpFilters.itemindex = 0 then Qry.SQL.Add('Group by  date(SaleDateTime)')
            else if grpFilters.itemindex = 1 then Qry.SQL.Add('Group by  SaleID')
            else Qry.SQL.Add('Group by  SaleID, saleLineID')  ;

            Qry.SQL.Add('ORDER BY s.SaleDateTime, SAleID, Productname');
          end;
    end;
    TimerMsg(lblNote, 'List shows Sales from ' + Quotedstr(FormatdateTime(formatSettings.ShortDateFormat +' hh:nn:ss' , Dtfrom.DateTime)) +' to ' + Quotedstr(FormatdateTime(formatSettings.ShortDateFormat +' hh:nn:ss' , DtTo.DateTime)));
    QryfieldNames.SQL.Clear;
    QryfieldNames.SQL.Add(FieldNameSQL);
    opendb(QryfieldNames);
end;
procedure THourlySalesReportGUI.RefreshQuery;
var
  totalField:STring;
begin
  if fbdontRefresh then exit;
  Qrymain.DisableControls;
  try
    closeDB(Qrymain);
    closeDB(QrymainTotals);
    closedb(QryfieldNames);
    if grpFilters.ItemIndex <= 1 then begin
      if grpAmount.ItemIndex = 0 then totalField:= 's.TotalAmountInc' { inc tax}
      else totalField:= 's.TotalAmount';  {ex tax}
    end else begin
      if grpAmount.ItemIndex = 0 then totalField:= 'sl.TotalLineAmountInc' { inc tax}
      else totalField:= 'sl.TotalLineAmount'; {ex tax}
    end;
    MakeQrymain(Totalfield);

    AddFieldsToQrymain;
    RefreshOrignalSQL;
    inherited;
    DoGridcolumns;
    RefreshTotals;
  finally
    Qrymain.EnableControls;
  end;
end;
procedure THourlySalesReportGUI.RefreshTotals;
var
  x:Integer;
  s:String;
  totalSale:Double;
begin
  inherited;
  openDB(QrymainTotals);
  totalSale:= 0;
  try
    if QrymainTotals.RecordCount= 0 then exit;

    for x:= 0 to Qrymain.FieldCount-1 do begin
      s:= Qrymain.fields[x].fieldName;
      if isAmountfield(s)  or Sametext(s , 'TotalSalesAmount') then begin
        Grdmain.ColumnByName(s).FooterValue :=  FloatToStrF(QrymainTotals.fieldbyname(s).AsFloat , ffCurrency , 15,2);
        if isAmountfield(s)   then totalSale:= totalSale +QrymainTotals.fieldbyname(s).AsFloat ;
      end;
    end;

  finally
    lbltotalSales.caption :='Total Sale for the period Selected : ' + floattoStrf( totalSale, ffCurrency , 15,2);
  end;
end;

Function THourlySalesReportGUI.FieldNameSQL(const HavelineBreak:boolean = True):String;
var
  node: TDataTreeNode;
  x:Integer;
  function Linebreak :String;
  begin
   if HavelineBreak then result := '~' else result:= '';
  end;
begin
  node:= TDataTreeNode(GuiPrefs.Node.ItemByName['TimeList']);
  Result := 'Select ';
  if node.Count > 0 then begin
    for x:= 0 to node.Count -1 do begin
        if Result <> 'Select ' then Result := Result +',';
        Result := Result + Quotedstr(FormatDateTime(mysqlTimeformat, node.Items[x]['TimeFrom'].AsDateTime))+' as SalesAmounttime_' + inttostr(x)+',';
        Result := Result + Quotedstr(FormatDateTime(mysqlTimeformat, node.Items[x]['TimeTo'].AsDateTime))+' as SalesAmounttimeTo_' + inttostr(x)+',';
        Result := Result + Quotedstr(FormatDateTime('hh:nn am/pm',node.Items[x]['TimeFrom'].AsDateTime) + ' to ' + Linebreak +
                                     FormatDateTime('hh:nn am/pm',node.Items[x]['TimeTo'].AsDateTime)) +' as salesAmountCaption_' + inttostr(x);
    end;
  end;
end;
function THourlySalesReportGUI.ISAmountField(const FieldName:String):Boolean;
begin
    result:= Sametext(copy(FieldName+ Replicatestr(' ' , 12) , 1, 12) , 'SalesAmount_');
end;

Procedure THourlySalesReportGUI.AddFieldstoQrymain;
var
  node: TDataTreeNode;
  s:String;
  x:Integer;
  Field: TField;
  //fsfieldNameSQL:String;
begin
  //fsfieldNameSQL := FieldnameSQL;
  for x:= Qrymain.fieldcount -1 downto 0 do begin
    s:= Qrymain.fields[x].fieldName;
    if isAmountfield(s) then begin
      Field := Qrymain.fields[x];
      RemoveFieldfromGrid(s);
      if Assigned(Field) then Field.Free;
    end;
  end;

      //if Sametext(fsfieldNameSQL, 'Select ') then else begin
          node:= TDataTreeNode(GuiPrefs.Node.ItemByName['TimeList']);
          if node.Count > 0 then begin
            (*With TempMyQuery do try
              SQL.add(fsfieldNameSQL);
              open;*)
            openDB(QryfieldNames);
            with QryfieldNames do begin
              for x:= 0 to node.Count -1 do begin
                s:= 'SalesAmount_'+ inttostr(x) ;
                if Qrymain.Findfield(s) = nil then begin
                    with TFloatField.Create(Self) do begin
                      fieldKind := fkData;
                      fieldname := s;
                      name := 'Qrymain'+s;
                      Currency := True;
                      DataSet := qryMain;
                      visible := True;
                    end;
                end;
              end;
            (*finally
              ClosenFree;*)
            end;
          end;
      //end;
end;
Procedure THourlySalesReportGUI.DoGridcolumns;
var
  node: TDataTreeNode;
  s:String;
  x:Integer;
  //fsfieldNameSQL:String;
begin
    //fsfieldNameSQL := fieldNameSQL;
    fieldList := TStringList.create;
    try
      AddGridSelectedfield(QrymainSaleDate.Fieldname, 12, QrymainSaleDate.DisplayLabel);
      if (Grpfilters.itemindex = 2)  or (Grpfilters.itemindex = 1) then begin
          AddGridSelectedfield(QrymainDocNumber.Fieldname             , 10, QrymainDocNumber.DisplayLabel);
          AddGridSelectedfield(QrymainCustomerName.Fieldname          , 10, QrymainCustomerName.DisplayLabel);
          AddGridSelectedfield(QrymainDepartment.Fieldname            , 10, QrymainDepartment.DisplayLabel);
          AddGridSelectedfield(QrymainSAleId.Fieldname                , 10, QrymainSAleId.DisplayLabel);
          AddGridSelectedfield(QrymainSaleType.Fieldname              , 10, QrymainSaleType.DisplayLabel);
          if (Grpfilters.itemindex = 2) then begin
            AddGridSelectedfield(QrymainProductName.Fieldname         , 10, QrymainProductName.DisplayLabel);
            AddGridSelectedfield(QrymainProduct_Description.Fieldname , 10, QrymainProduct_Description.DisplayLabel);
            AddGridSelectedfield(QrymainShipped.Fieldname             , 10, QrymainShipped.DisplayLabel);
          end;
      end;
      //if Sametext(fsfieldNameSQL, 'Select ') then else begin
        node:= TDataTreeNode(GuiPrefs.Node.ItemByName['TimeList']);
        if node.Count > 0 then begin
          (*With TempMyQuery do try
            SQL.add(fsfieldNameSQL);
            open;*)
          opendb(QryfieldNames);
          With QryfieldNames do begin
            for x:= 0 to node.Count -1 do begin
              s:= 'SalesAmount_'+ inttostr(x) ;
              With TFloatField(Qrymain.Findfield(s)) do begin
                AddGridSelectedfield(s, 10, FieldByname('salesAmountCaption_'+ inttostr(x)).asString);
              end;
            end;
          (*finally
            ClosenFree;*)
          end;
        end;
      //end;
      AddGridSelectedfield(QrymainTotalSalesAmount.Fieldname             , 12, QrymainTotalSalesAmount.DisplayLabel);

      grdMain.Selected := FieldList;
      grdMain.ApplySelected;
    finally
      Freeandnil(fieldList);
    end;
end;
procedure THourlySalesReportGUI.dtFromChange(Sender: TObject);
begin
  inherited;
   if screen.ActiveControl = dtFrom then ChkshowSystemDate.Checked := False;
end;

procedure THourlySalesReportGUI.dtToChange(Sender: TObject);
begin
  inherited;
  if screen.ActiveControl = dtto then ChkshowSystemDate.Checked := False;
end;

procedure THourlySalesReportGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainSaleLineID.Fieldname);
end;

procedure THourlySalesReportGUI.WriteGuiPrefExtra;
begin
  inherited;
  if (grpAmount.Visible) and (grpAmount.Items.Count > 0) then begin
    GuiPrefs.Node['grpAmount.ItemIndex'].asInteger := grpAmount.ItemIndex + 1;
  end;
  if (grdSalesCAtegory.Visible) and (grdSalesCAtegory.Items.Count > 0) then begin
    GuiPrefs.Node['grdSalesCAtegory.ItemIndex'].asInteger := grdSalesCAtegory.ItemIndex + 1;
  end;
  GuiPrefs.Node['Options.InitToSystemDate'].asBoolean:= ChkshowSystemDate.checked;
  GuiPrefs.Node['Options.DateRange.ToDate'].AsDateTime:= dtTo.Datetime;
  GuiPrefs.Node['Options.DateRange.FromDate'].AsDateTime := DtFrom.Datetime;
  GuiPrefs.Node['Options.DateRange.DayStart'].AsDateTime := dtDaystart.Time;
end;

initialization
  RegisterClassOnce(THourlySalesReportGUI);
end.

