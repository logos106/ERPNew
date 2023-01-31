unit frmsummarySheets;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls, StdCtrls, DNMPanel, Shader,
  DNMSpeedButton, Buttons, Wwdbigrd, Grids, Wwdbgrid, DAScript, MyScript, wwdbdatetimepicker, AdvSplitter, BaseListingForm;

type

  TColumnRec = record
    ColumnName: string;
    totalamount :double;
  end;


  TfmsummarySheets = class(TBaseInputGUI)
    Bevel1: TBevel;
    Shader1: TShader;
    pnlActiveForm: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    sbButtons: TScrollBox;
    pnlButtons: TDNMPanel;
    btnSelectDbs: TDNMSpeedButton;
    cmdPrint: TDNMSpeedButton;
    cmdClose: TDNMSpeedButton;
    btnGeneral: TDNMSpeedButton;
    btnPayables: TDNMSpeedButton;
    btnReceivables: TDNMSpeedButton;
    DNMSpeedButton1: TDNMSpeedButton;
    DNMSpeedButton2: TDNMSpeedButton;
    DNMSpeedButton3: TDNMSpeedButton;
    DNMSpeedButton4: TDNMSpeedButton;
    DNMSpeedButton6: TDNMSpeedButton;
    qryMain: TERPQuery;
    qryMainDbName: TWideStringField;
    qryMainAmt1: TFloatField;
    qryMainAmt2: TFloatField;
    qryMainAmt3: TFloatField;
    qryMainAmt4: TFloatField;
    qryMainAmt5: TFloatField;
    qryMainAmt5Percent: TFloatField;
    qryMainAmt6: TFloatField;
    qryMainAmt6Percent: TFloatField;
    qryMainAmt7: TFloatField;
    qryMainAmt7Percent: TFloatField;
    qryMainAmt8: TFloatField;
    qryMainAmt8Percent: TFloatField;
    qryMainAmt9: TFloatField;
    qryMainAmt9Percent: TFloatField;
    qryMainAmt10: TFloatField;
    qryMainAmt10Percent: TFloatField;
    qryMainAmt11: TFloatField;
    qryMainAmt11Percent: TFloatField;
    qryMainAmt12: TFloatField;
    qryMainAmt12Percent: TFloatField;
    qryMainAmt13: TFloatField;
    qryMainAmt13Percent: TFloatField;
    qryMainAmt14: TFloatField;
    qryMainAmt14Percent: TFloatField;
    qryMainAmt15: TFloatField;
    qryMainAmt16: TFloatField;
    qryMainAmt17: TFloatField;
    qryMainAmt18: TFloatField;
    qryMainAmt19: TFloatField;
    qryMainAmt20: TFloatField;
    qryMainAmt21: TFloatField;
    qryMainAmt22: TFloatField;
    qryMainAmt23: TFloatField;
    qryMainAmt24: TFloatField;
    qryMainAmt25: TFloatField;
    qryMainAmt26: TFloatField;
    qryMainAmt27: TFloatField;
    qryMainAmt28: TFloatField;
    qryMainAmt29: TFloatField;
    qryMainAmt30: TFloatField;
    qryMainID: TIntegerField;
    qryMainAPtotal: TFloatField;
    qryMainARTotal: TFloatField;
    dsMain: TDataSource;
    ScriptMain: TERPScript;
    lblTo: TLabel;
    dtTo: TwwDBDateTimePicker;
    DNMSpeedButton7: TDNMSpeedButton;
    btnOpenList: TDNMSpeedButton;
    DNMPanel1: TDNMPanel;
    grdMain: TwwDBGrid;
    btnGrid: TwwIButton;
    pnlFxTrading: TDNMPanel;
    Splitter: TAdvSplitter;
    chkHidePercentage: TCheckBox;
    qryMainExchangeRate: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSelectDbsClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdPrintClick(Sender: TObject);
    procedure DNMSpeedButton7Click(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure Mainbuttonclick(Sender:TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainDblClick(Sender: TObject);
    procedure dtToChange(Sender: TObject);
    procedure btnOpenListClick(Sender: TObject);
    procedure chkHidePercentageClick(Sender: TObject);
  private
    Tablename :string;
    fsDatabases :String;
    FieldList : TStringList;
    fiPageno: Integer;
    Amttotals :Array of TColumnRec;
    fFxTradingList : TBaseListingGUI;
    Procedure MakeQrymain;
    function getDatabases: String;
    procedure AddGridSelectedfield(const fsfieldName: string; const fidisplaywidth: integer; const fsDisplayLabel: string; const fsGroupName: string = '');
    function filterDateto:TDatetime;
    procedure SetIndicatorbutton;
    function columntotal(Amtfield :String):double;
    procedure beforeshowSummarySheet(Sender: TObject);
    procedure setPageno(const Value: Integer);
    procedure Refreshfooter;
    procedure beforeshowSummarySheets(Sender: TObject);
    function FxTradingList: TBaseListingGUI;
    Procedure ShowFXTradingList;
    procedure Setupgrid;
  Protected
  public
    Property  Databases :String read getDatabases write fsDatabases;
    Property Pageno :Integer read fiPageno write setPageno;
  end;


implementation

uses SummarySheetObj, frmdatabaseSelection, AppEnvironment, MySQLConst, CommonDbLib,dateutils, Commonlib,systemlib, CommonFormLib, frmSummarySheetFrm, SummarySheets;

{$R *.dfm}
procedure TfmsummarySheets.btnOpenListClick(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TSummarySheetsGUI' ,beforeshowSummarySheets);
  Self.Close;
end;
procedure TfmsummarySheets.beforeshowSummarySheets(Sender: TObject);
begin
  if not(Sender is TSummarySheetsGUI) then exit;
  TSummarySheetsGUI(Sender).dtfrom.date :=0;
  TSummarySheetsGUI(Sender).dtTo.date :=filterdateTo;
  TSummarySheetsGUI(Sender).Databases := databases;
  TSummarySheetsGUI(Sender).fbDateRangeSupplied := TRue;
end;
procedure TfmsummarySheets.btnSelectDbsClick(Sender: TObject);
begin
  inherited;
  fsDatabases := selectDatabases(databases);
  if fsDatabases = '' then fsDatabases := Appenv.AppDb.Database;
  MakeQrymain;
end;

procedure TfmsummarySheets.chkHidePercentageClick(Sender: TObject);
begin
  inherited;
  Setupgrid;
end;

procedure TfmsummarySheets.cmdCloseClick(Sender: TObject);
begin
  inherited;
  self.close;
end;

procedure TfmsummarySheets.cmdPrintClick(Sender: TObject);
var
  SQL:String;
  fsReportName:String;
begin
  SQL:= '{CompanyInfo}SELECT convert(' + quotedstr(formatDatetime(MysqlDateTimeFormat , filterDateTo))+',dateTime) as FromDate, '+
                'CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, CO.PhoneNumber AS PhoneNumber, CO.FaxNumber AS FaxNumber,  '+
                'CO.ABN FROM tblCompanyInformation AS CO '+
                '~|||~{Details} Select * from '+ tablename;
  fsReportName := GetDefaultReport(120);
  if fsReportName ='' then exit;
  fbReportSQLSupplied:= True;
  PrintTemplateReport(fsReportName , SQL, not(appenv.employee.showPreview) , 1);
end;

function TfmsummarySheets.columntotal(Amtfield: String): double;
begin
  Result:= 0;
  if Qrymain.findfield(Amtfield) = nil then exit;
  with tempMyQuery do try
    SQL.add('Select sum(' +Amtfield+') as amt from ' + tablename );
    open;
    result := fieldbyname('amt').asFloat;
  finally

  end;
end;

procedure TfmsummarySheets.DNMSpeedButton7Click(Sender: TObject);
begin
  inherited;
  MakeQrymain;
end;

procedure TfmsummarySheets.dtToChange(Sender: TObject);
begin
  inherited;
  MakeQrymain;
end;

function TfmsummarySheets.filterDateto: TDatetime;
begin
  Result := IncSecond(IncDay(dateof(dtTo.DateTime), 1), -1);
end;

procedure TfmsummarySheets.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteGuiPref('Options.Databases', Databases);
  WriteGuiPref('Options.Pageno', inttostr(Pageno));
  WriteGuiPref('Options.FXPanelHeight', inttostr(pnlFxTrading.Height));
  WriteGuiPref('Options.HidePercentage', BooleanToStr(chkHidePercentage.Checked)  );

  inherited;
  Action := caFree;
end;

procedure TfmsummarySheets.FormCreate(Sender: TObject);
begin
  SetLength(Amttotals,0);
  inherited;
  Tablename := commondbLib.CreateUserTemporaryTable('tmp_SummarySheets' , '');
  Qrymain.SQL.Text := 'Select * from ' + tablename ;
  grdMain.TitleColor := Self.Color;
  grdMain.FooterColor := Self.Color;
end;

procedure TfmsummarySheets.SetIndicatorbutton;
begin
  if grdMain.TitleLines = 1 then btnGrid.Height := 22
  else if grdMain.TitleLines = 2 then btnGrid.Height := 34
  else if grdMain.TitleLines = 3 then btnGrid.Height := 49
  else if grdMain.TitleLines = 4 then btnGrid.Height := 64;
end;

procedure TfmsummarySheets.setPageno(const Value: Integer);
var
  ctr:Integer;
begin
  fiPageno := Value;
  for ctr:= 0 to componentcount-1 do begin
    if components[ctr] is tDNMSpeedbutton then
      if TDNMSpeedbutton(components[ctr]).Parent = pnlButtons then
        if TDNMSpeedbutton(components[ctr]).tag = Value then begin
          Mainbuttonclick(components[ctr]);
          Exit;
        end;
  end;
end;

function TfmsummarySheets.FxTradingList: TBaseListingGUI;
begin
  CreateHistorylistform('TFxTradingListGUI' ,Self, fFxTradingList );
  result := fFxTradingList;
end;

procedure TfmsummarySheets.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.active := True;
  Databases :=  GuiPrefs.Node['Options.Databases'].asString;
  dtTo.DateTime := Date;
  MakeQrymain;
  OpenQueries;
  if isinteger(GuiPrefs.Node['Options.Pageno'].asString)   then  Pageno := strtoint(GuiPrefs.Node['Options.Pageno'].asString);
  if GuiPrefs.Node['Options.FXPanelHeight'].asInteger <> 0 then  pnlFxTrading.Height := GuiPrefs.Node['Options.FXPanelHeight'].asInteger;
  chkHidePercentage.Checked := Sametext(GuiPrefs.Node['Options.HidePercentage'].asString , 'T');
  ShowFxTradingList;
end;

function TfmsummarySheets.getDatabases: String;
begin
  if fsDatabases = '' then fsDatabases := Appenv.AppDb.Database;
  result:= fsDatabases;

end;

procedure TfmsummarySheets.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if Field is TFloatfield then
    if TFloatfield(Field).asFloat = 0 then
      Afont.color := ABrush.color;
end;
procedure TfmsummarySheets.grdMainDblClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TfrmSummarySheetGUI' , 0 , nil, beforeshowSummarySheet)
end;
procedure TfmsummarySheets.beforeshowSummarySheet(Sender:TObject);
begin
  if not(Sender is TfrmSummarySheetGUI) then exit;
  TfrmSummarySheetGUI(Sender).Databasename := QrymainDBname.AsString ;
end;
procedure TfmsummarySheets.MakeQrymain;
begin
  SummarySheetObj.makeQry(Self, Tablename, Databases , filterDateTo, False , nil);
  closedb(qrymain);
  opendb(qrymain);
end;
(*procedure TfmsummarySheets.MakeQrymain;
var
  st:TStringlist;
  ctr:Integer;
  conn : TERPConnection;
  s:String;
  Total, fdValue:double;
begin
  With ScriptMain do begin
    connection := Qrymain.connection;
    SQL.clear;
    SQL.Add('truncate ' + tablename +';');
    st:= TStringlist.Create;
    try
      st.CommaText := Databases;
      for ctr:= 0 to st.count-1 do begin
        s := 'insert into ' + tablename +' set dbname = ' +quotedstr(st[ctr])+',';
        conn := GetNewMyDacConnection(self, st[ctr]);

        with TSummarySheetObj.create(self) do try
          connection := conn;
          DateTo := filterdateto;
          DoCalc;
          s:= s + 'Amt1 = ' +  FloatTostr(StringToFloat(Trim(valueGrid.Cells[4, 1])))+',';
          s:= s + 'Amt2 = ' +  FloatTostr(StringToFloat(Trim(valueGrid.Cells[4, 2])))+',';
          s:= s + 'Amt3 = ' +  FloatTostr(StringToFloat(Trim(valueGrid.Cells[4, 3])))+',';
          s:= s + 'Amt4 = ' +  FloatTostr(StringToFloat(Trim(valueGrid.Cells[4, 4])))+',';

          s:= s + 'Amt15 = ' +  FloatTostr(StringToFloat(Trim(valueGrid.Cells[1, 5])))+',';
          s:= s + 'Amt16 = ' +  FloatTostr(StringToFloat(Trim(valueGrid.Cells[1, 6])))+',';
          s:= s + 'Amt17 = ' +  FloatTostr(StringToFloat(Trim(valueGrid.Cells[1, 7])))+',';
          s:= s + 'Amt18 = ' +  FloatTostr(StringToFloat(Trim(valueGrid.Cells[1, 8])))+',';

          s:= s + 'Amt19 = ' +  FloatTostr(StringToFloat(Trim(valueGrid.Cells[2, 5])))+',';
          s:= s + 'Amt20 = ' +  FloatTostr(StringToFloat(Trim(valueGrid.Cells[2, 6])))+',';
          s:= s + 'Amt21 = ' +  FloatTostr(StringToFloat(Trim(valueGrid.Cells[2, 7])))+',';
          s:= s + 'Amt22 = ' +  FloatTostr(StringToFloat(Trim(valueGrid.Cells[2, 8])))+',';

          s:= s + 'Amt23 = ' +  FloatTostr(StringToFloat(Trim(valueGrid.Cells[3, 5])))+',';
          s:= s + 'Amt24 = ' +  FloatTostr(StringToFloat(Trim(valueGrid.Cells[3, 6])))+',';
          s:= s + 'Amt25 = ' +  FloatTostr(StringToFloat(Trim(valueGrid.Cells[3, 7])))+',';
          s:= s + 'Amt26 = ' +  FloatTostr(StringToFloat(Trim(valueGrid.Cells[3, 8])))+',';

          s:= s + 'Amt27 = ' +  FloatTostr(StringToFloat(Trim(valueGrid.Cells[4, 5])))+',';
          s:= s + 'Amt28 = ' +  FloatTostr(StringToFloat(Trim(valueGrid.Cells[4, 6])))+',';
          s:= s + 'Amt29 = ' +  FloatTostr(StringToFloat(Trim(valueGrid.Cells[4, 7])))+',';
          s:= s + 'Amt30 = ' +  FloatTostr(StringToFloat(Trim(valueGrid.Cells[4, 8])))+',';
        finally
          Free;
        end;

        Total   :=ReturnDueAccountsPayableTotal(filterdateto, conn);
        s:= s + 'APtotal = ' +FloatTostr( total)+',';
        fdValue :=ReturnDueAPTotalWithinRange(filterDateto, 0,  0 , Conn);        s:= s + 'Amt5 = ' +FloatTostr(fdValue)+',';        s:= s + 'Amt5Percent = ' +FloatTostr(CalcPercentage(fdValue, total))+',';
        fdValue :=ReturnDueAPTotalWithinRange(filterDateto, 0,  30, Conn);        s:= s + 'Amt6 = ' +FloatTostr(fdValue)+',';        s:= s + 'Amt6Percent = ' +FloatTostr(CalcPercentage(fdValue, total))+',';
        fdValue :=ReturnDueAPTotalWithinRange(filterDateto, 30, 60, Conn);        s:= s + 'Amt7 = ' +FloatTostr(fdValue)+',';        s:= s + 'Amt7Percent = ' +FloatTostr(CalcPercentage(fdValue, total))+',';
        fdValue :=ReturnDueAPTotalWithinRange(filterDateto, 60, 90, Conn);        s:= s + 'Amt8 = ' +FloatTostr(fdValue)+',';        s:= s + 'Amt8Percent = ' +FloatTostr(CalcPercentage(fdValue, total))+',';
        fdValue :=ReturnDueAPTotalWithinRange(filterDateto, 90, 99999999 , Conn); s:= s + 'Amt9 = ' +FloatTostr(fdValue)+',';        s:= s + 'Amt9Percent = ' +FloatTostr(CalcPercentage(fdValue, total))+',';

        Total   :=ReturnDueAccountsReceivableTotal(filterdateto, conn);
        s:= s + 'ARtotal = ' +FloatTostr( total)+',';
        fdValue :=ReturnDueARTotalWithinRange(filterDateto, 0,  0 , Conn);        s:= s + 'Amt10 = ' +FloatTostr(fdValue)+',';        s:= s + 'Amt10Percent = ' +FloatTostr(CalcPercentage(fdValue, total))+',';
        fdValue :=ReturnDueARTotalWithinRange(filterDateto, 0,  30, Conn);        s:= s + 'Amt11 = ' +FloatTostr(fdValue)+',';        s:= s + 'Amt11Percent = ' +FloatTostr(CalcPercentage(fdValue, total))+',';
        fdValue :=ReturnDueARTotalWithinRange(filterDateto, 30, 60, Conn);        s:= s + 'Amt12 = ' +FloatTostr(fdValue)+',';        s:= s + 'Amt12Percent = ' +FloatTostr(CalcPercentage(fdValue, total))+',';
        fdValue :=ReturnDueARTotalWithinRange(filterDateto, 60, 90, Conn);        s:= s + 'Amt13 = ' +FloatTostr(fdValue)+',';        s:= s + 'Amt13Percent = ' +FloatTostr(CalcPercentage(fdValue, total))+',';
        fdValue :=ReturnDueARTotalWithinRange(filterDateto, 90, 99999999 , Conn); s:= s + 'Amt14 = ' +FloatTostr(fdValue)+',';        s:= s + 'Amt14Percent = ' +FloatTostr(CalcPercentage(fdValue, total));
        SQL.add(s +';');
      end;
      Execute;
    finally
      Freeandnil(st);
    end;
    closedb(qrymain);
    opendb(qrymain);
  end;
end;*)
procedure TfmsummarySheets.Refreshfooter;
var
  ctr:Integer;
begin
  for ctr:= low(Amttotals) to high(Amttotals) do
    if Amttotals[ctr].totalamount =0 then
      grdmain.columnbyname(Amttotals[ctr].ColumnName).Footervalue := ''
    else
     grdmain.columnbyname(Amttotals[ctr].ColumnName).Footervalue := FloatToStrF(Amttotals[ctr].totalamount, ffCurrency, 15, CurrencyRoundPlaces);
end;
procedure TfmsummarySheets.qryMainAfterOpen(DataSet: TDataSet);
var
  ctr: Integer;
  amtfieldctr:Integer;
  fdtotal:double;
begin
  inherited;
  amtfieldctr:=0;
  SetLength(Amttotals,amtfieldctr);
  SetIndicatorbutton;
  DoShowProgressbar(Qrymain.fieldcount , 'Calculating Totals' );
  try
    for ctr:= 0 to Qrymain.fieldcount-1 do begin
      if qrymain.fields[ctr] = qryMainExchangeRate then continue;
      if qrymain.fields[ctr] is TFloatfield then begin
        if Pos('Percent' ,qrymain.fields[ctr].fieldname )=0 then begin
          fdTotal := columntotal(qrymain.fields[ctr].fieldname);
          if fdTotal =0 then
            grdmain.columnbyname(qrymain.fields[ctr].fieldname).Footervalue := ''
          else
            grdmain.columnbyname(qrymain.fields[ctr].fieldname).Footervalue := FloatToStrF(fdTotal, ffCurrency, 15, CurrencyRoundPlaces);
          amtfieldctr := amtfieldctr +1;
          SetLength(Amttotals,amtfieldctr);
          Amttotals[amtfieldctr-1].ColumnName := qrymain.fields[ctr].fieldname;
          Amttotals[amtfieldctr-1].totalamount:=fdtotal;
        end;
      end;
      DoStepProgressbar(qrymain.fields[ctr].fieldname);
    end;
  finally
    DoHideProgressbar;
  end;
end;

procedure TfmsummarySheets.Mainbuttonclick(Sender:TObject);
begin
  if not (sender is TDNMSpeedbutton) then Exit;
  With TDNMSpeedbutton(Sender) do begin
    pnlActiveForm.caption := Caption;
    fiPageno := tag;
    Setupgrid;
  end;
end ;
procedure TfmsummarySheets.Setupgrid;
begin
    FieldList := TStringList.Create;
    try
      AddGridSelectedfield('DbName'       ,20 ,'Database');
      if (fiPageno = 1) then begin
        grdmain.titlelines := 2;
        AddGridSelectedfield('ExchangeRate' ,10 ,'Ex Rate'            );
        AddGridSelectedfield('Amt1'         ,10 ,'Cash in~Hand'       );
        AddGridSelectedfield('Amt2'         ,10 ,'Accounts~Receivable');
        AddGridSelectedfield('Amt3'         ,10 ,'Accounts~Payable'   );
        AddGridSelectedfield('Amt4'         ,10 ,'Balance~Sheet'      );
      end else if (fiPageno = 2) then begin
        grdmain.titlelines := 1;
        AddGridSelectedfield('ExchangeRate' ,10 ,'Ex Rate'            );
        AddGridSelectedfield('Amt5'         ,10 ,'Current'            );
        if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt5Percent'  ,6  ,'%'                  );
        AddGridSelectedfield('Amt6'         ,10 ,'1 - 30'             );
        if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt6Percent'  ,6  ,'%'                  );
        AddGridSelectedfield('Amt7'         ,10 ,'31 - 60'            );
        if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt7Percent'  ,6  ,'%'                  );
        AddGridSelectedfield('Amt8'         ,10 ,'61 - 90'            );
        if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt8Percent'  ,6  ,'%'                  );
        AddGridSelectedfield('Amt9'         ,10 ,'90 +'               );
        if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt9Percent'  ,6  ,'%'                  );
        AddGridSelectedfield('APtotal'      ,12 ,'Total'              );
      end else if (fiPageno = 3) then begin
        grdmain.titlelines := 1;
        AddGridSelectedfield('ExchangeRate' ,10 ,'Ex Rate'            );
        AddGridSelectedfield('Amt10'        ,10 ,'Current'            );
        if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt10Percent' ,6  ,'%'                  );
        AddGridSelectedfield('Amt11'        ,10 ,'1 - 30'             );
        if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt11Percent' ,6  ,'%'                  );
        AddGridSelectedfield('Amt12'        ,10 ,'31 - 60'            );
        if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt12Percent' ,6  ,'%'                  );
        AddGridSelectedfield('Amt13'        ,10 ,'61 - 90'            );
        if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt13Percent' ,6  ,'%'                  );
        AddGridSelectedfield('Amt14'        ,10 ,'90 +'               );
        if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt14Percent' ,6  ,'%'                  );
        AddGridSelectedfield('ARtotal'      ,12 ,'Total'              );
      end else if (fiPageno = 4) then begin
        grdmain.titlelines := 1;
        AddGridSelectedfield('ExchangeRate' ,10 ,'Ex Rate'            );
        AddGridSelectedfield('Amt15'        ,10 ,'Sales'              );
        AddGridSelectedfield('Amt16'        ,10 ,'Cost of Goods'      );
        AddGridSelectedfield('Amt17'        ,10 ,'Expenses'           );
        AddGridSelectedfield('Amt18'        ,10 ,'Profit & Loss'      );
      end else if (fiPageno = 5) then begin
        grdmain.titlelines := 1;
        AddGridSelectedfield('ExchangeRate' ,10 ,'Ex Rate'            );
        AddGridSelectedfield('Amt19'        ,10 ,'Sales'              );
        AddGridSelectedfield('Amt20'        ,10 ,'Cost of Goods'      );
        AddGridSelectedfield('Amt21'        ,10 ,'Expenses'           );
        AddGridSelectedfield('Amt22'        ,10 ,'Profit & Loss'      );
      end else if (fiPageno = 6) then begin
        grdmain.titlelines := 1;
        AddGridSelectedfield('ExchangeRate' ,10 ,'Ex Rate'            );
        AddGridSelectedfield('Amt23'        ,10 ,'Sales'              );
        AddGridSelectedfield('Amt24'        ,10 ,'Cost of Goods'      );
        AddGridSelectedfield('Amt25'        ,10 ,'Expenses'           );
        AddGridSelectedfield('Amt26'        ,10 ,'Profit & Loss'      );
      end else if (fiPageno = 7) then begin
        grdmain.titlelines := 1;
        AddGridSelectedfield('ExchangeRate' ,10 ,'Ex Rate'            );
        AddGridSelectedfield('Amt27'        ,10 ,'Sales'              );
        AddGridSelectedfield('Amt28'        ,10 ,'Cost of Goods'      );
        AddGridSelectedfield('Amt29'        ,10 ,'Expenses'           );
        AddGridSelectedfield('Amt30'        ,10 ,'Profit & loss'      );
      end else if fiPageno = 0 then begin
        grdmain.titlelines := 4;
        AddGridSelectedfield('ExchangeRate' ,10 ,'Ex Rate'            ,'General');
        AddGridSelectedfield('Amt1'         ,10 ,'Cash in~Hand'       ,'General');
        AddGridSelectedfield('Amt2'         ,10 ,'Accounts~Receivable','General');
        AddGridSelectedfield('Amt3'         ,10 ,'Accounts~Payable'   ,'General');
        AddGridSelectedfield('Amt4'         ,10 ,'Balance~Sheet'      ,'General');

        AddGridSelectedfield('Amt5'         ,10 ,'Current'            ,'Payables');
        if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt5Percent'  ,6  ,'%'                  ,'Payables');
        AddGridSelectedfield('Amt6'         ,10 ,'1 - 30'             ,'Payables');
        if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt6Percent'  ,6  ,'%'                  ,'Payables');
        AddGridSelectedfield('Amt7'         ,10 ,'31 - 60'            ,'Payables');
        if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt7Percent'  ,6  ,'%'                  ,'Payables');
        AddGridSelectedfield('Amt8'         ,10 ,'61 - 90'            ,'Payables');
        if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt8Percent'  ,6  ,'%'                  ,'Payables');
        AddGridSelectedfield('Amt9'         ,10 ,'90 +'               ,'Payables');
        if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt9Percent'  ,6  ,'%'                  ,'Payables');
        AddGridSelectedfield('APtotal'      ,12 ,'Total'              ,'Payables');

        AddGridSelectedfield('Amt10'        ,10 ,'Current'            ,'Receivables');
        if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt10Percent' ,6  ,'%'                  ,'Receivables');
        AddGridSelectedfield('Amt11'        ,10 ,'1 - 30'             ,'Receivables');
        if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt11Percent' ,6  ,'%'                  ,'Receivables');
        AddGridSelectedfield('Amt12'        ,10 ,'31 - 60'            ,'Receivables');
        if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt12Percent' ,6  ,'%'                  ,'Receivables');
        AddGridSelectedfield('Amt13'        ,10 ,'61 - 90'            ,'Receivables');
        if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt13Percent' ,6  ,'%'                  ,'Receivables');
        AddGridSelectedfield('Amt14'        ,10 ,'90 +'               ,'Receivables');
        if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt14Percent' ,6  ,'%'                  ,'Receivables');
        AddGridSelectedfield('ARtotal'      ,12 ,'Total'              ,'Receivables');

        AddGridSelectedfield('Amt15'        ,10 ,'Sales'              ,'Last Week (ex)');
        AddGridSelectedfield('Amt16'        ,10 ,'Cost of Goods'      ,'Last Week (ex)');
        AddGridSelectedfield('Amt17'        ,10 ,'Expenses'           ,'Last Week (ex)');
        AddGridSelectedfield('Amt18'        ,10 ,'Profit & Loss'      ,'Last Week (ex)');

        AddGridSelectedfield('Amt19'        ,10 ,'Sales'              ,'Last Month (ex)');
        AddGridSelectedfield('Amt20'        ,10 ,'Cost of Goods'      ,'Last Month (ex)');
        AddGridSelectedfield('Amt21'        ,10 ,'Expenses'           ,'Last Month (ex)');
        AddGridSelectedfield('Amt22'        ,10 ,'Profit & Loss'      ,'Last Month (ex)');

        AddGridSelectedfield('Amt23'        ,10 ,'Sales'              ,'Last 3 Months (ex)');
        AddGridSelectedfield('Amt24'        ,10 ,'Cost of Goods'      ,'Last 3 Months (ex)');
        AddGridSelectedfield('Amt25'        ,10 ,'Expenses'           ,'Last 3 Months (ex)');
        AddGridSelectedfield('Amt26'        ,10 ,'Profit & Loss'      ,'Last 3 Months (ex)');

        AddGridSelectedfield('Amt27'        ,10 ,'Sales'              ,'Last 12 Months (Ex)');
        AddGridSelectedfield('Amt28'        ,10 ,'Cost of Goods'      ,'Last 12 Months (Ex)');
        AddGridSelectedfield('Amt29'        ,10 ,'Expenses'           ,'Last 12 Months (Ex)');
        AddGridSelectedfield('Amt30'        ,10 ,'Profit & loss'      ,'Last 12 Months (Ex)');
      end;
      grdMain.Selected := FieldList;
      grdMain.ApplySelected;
      closedb(qrymain);
      opendb(qrymain);
    finally
      Freeandnil(FieldList);
    end;
    Refreshfooter;
end;
procedure TfmsummarySheets.AddGridSelectedfield(const fsfieldName: string; const fidisplaywidth: integer; const fsDisplayLabel: string; const fsGroupName: string = '');
var
  str: string;
  fld: TField;
begin
//  if Qrymain.findfield(fsfieldName) <> nil then
//    if not(TField(Qrymain.findField(fsfieldName)).visible) then exit;
  fld:= QryMain.FindField(fsfieldName);
  if not Assigned(fld) then exit;
  if not fld.Visible then
    fld.Visible:= true;

  if not Assigned(FieldList) then exit;
  str := fsfieldName + #9 + IntToStr(fidisplaywidth) + #9 + DoTranslate(fsDisplayLabel) + #9;
  if fsGroupName <> '' then str := str + 'F' + #9 + fsGroupName
  else str := str + #9;
  FieldList.Add(str);
end;
Procedure TfmsummarySheets.ShowFXTradingList;
begin
    FxTradingList;
    if Assigned(fFxTradingList) then begin
      fFxTradingList.Parent := pnlFxTrading;
      fFxTradingList.BorderStyle := bsNone;
      fFxTradingList.fbIgnoreQuerySpeed := true;
      try
        fFxTradingList.Show;
        fFxTradingList.pnlButtons.visible := False;
        fFxTradingList.HeaderPanel.visible := False;
      except
        FreeAndNil(fFxTradingList);
      end;
    end;
end;

initialization
  RegisterClass(TfmsummarySheets);
end.

