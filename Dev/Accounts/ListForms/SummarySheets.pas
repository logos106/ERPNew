unit SummarySheets;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TSummarySheetsGUI = class(TBaseListingGUI)
    btnSelectDbs: TDNMSpeedButton;
    qryMainID: TIntegerField;
    qryMainDbName: TWideStringField;
    qryMainAmt1: TFloatField;
    qryMainAmt2: TFloatField;
    qryMainAmt3: TFloatField;
    qryMainAmt4: TFloatField;
    qryMainAmt5: TFloatField;
    qryMainAmt6: TFloatField;
    qryMainAmt7: TFloatField;
    qryMainAmt8: TFloatField;
    qryMainAmt9: TFloatField;
    qryMainAmt10: TFloatField;
    qryMainAmt11: TFloatField;
    qryMainAmt12: TFloatField;
    qryMainAmt13: TFloatField;
    qryMainAmt14: TFloatField;
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
    qryMainAmt31: TFloatField;
    qryMainAmt32: TFloatField;
    qryMainAmt33: TFloatField;
    qryMainAmt34: TFloatField;

    qryMainAmt5Percent: TFloatField;
    qryMainAmt6Percent: TFloatField;
    qryMainAmt7Percent: TFloatField;
    qryMainAmt8Percent: TFloatField;
    qryMainAmt9Percent: TFloatField;
    qryMainAmt10Percent: TFloatField;
    qryMainAmt11Percent: TFloatField;
    qryMainAmt12Percent: TFloatField;
    qryMainAmt13Percent: TFloatField;
    qryMainAmt14Percent: TFloatField;
    qryMainAPtotal: TFloatField;
    qryMainARTotal: TFloatField;
    N1: TMenuItem;
    DefaultCustomisation1: TMenuItem;
    chkHidePercentage: TCheckBox;
    qryMainExchangeRate: TFloatField;
    qryMainclosingdate: TDateTimeField;
    qryMainLastBankRecDate: TDateTimeField;
    procedure btnSelectDbsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DefaultCustomisation1Click(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
    procedure chkHidePercentageClick(Sender: TObject);
    procedure qryMainBeforeOpen(DataSet: TDataSet);
  private
    fsDatabases :String;
    function getDatabases: String;
    procedure SetDatabases(const Value: String);
  Protected
    fiPageno:Integer;
    Tablename :String;
    procedure AddGridField(const fsfieldName: string; const fidisplaywidth: integer; const fsDisplayLabel: string);
    procedure SetupGrid;virtual;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    function GetReportTypeID: integer; override;
    Procedure RefreshTotals;override;
    Function CustomRangeFrom:Tdatetime;Virtual;
    function customDateCaption:String;Virtual;
    procedure beforeshowSummarySheet(Sender: TObject);Virtual;
    Procedure ExtraFields;Virtual;
    Procedure MakeQrymain;Virtual;
  public
    Property  Databases :String read getDatabases write SetDatabases;
    Procedure RefreshQuery;Override;
    Procedure Refreshfooter;
  end;


implementation

uses CommonLib, frmdatabaseSelection, SummarySheetObj, CommonDbLib, AppEnvironment, MySQLConst,dateutils, frmSummarySheetFrm, CommonFormLib, AppEnvironmentVirtual, MySQLUtils,
  TemplateReportsLib;

{$R *.dfm}
procedure TSummarySheetsGUI.btnSelectDbsClick(Sender: TObject);
begin
  inherited;
  Databases := selectDatabases(databases);
  if Databases = '' then Databases := Appenv.AppDb.Database;
  Qrymain.DisableControls;
  Try
    closeDb(Qrymain);
    MakeQrymain;
    opendb(qrymain);
  Finally
    Qrymain.EnableControls;
  End;

end;

procedure TSummarySheetsGUI.chkHidePercentageClick(Sender: TObject);
begin
  inherited;
  SetupGrid;
end;

procedure TSummarySheetsGUI.cmdPrintClick(Sender: TObject);
begin
  ReportSQLSupplied:= True;
  TemplateSQL:=           companyInfoSQL +
          ' ~|||~{Detail}Select * from ' + tablename+
          '~|||~{Params}Select convert(' + Quotedstr(formatdateTime(MysqlDateTimeFormat , SummarySheetParamObj.CustomRangeFrom ))+',date) as CustomRangeFrom , ' +
                                'convert('+  Quotedstr(formatdateTime(MysqlDateTimeFormat , SummarySheetParamObj.Reportdate ))+',date) as Reportdate';
  inherited;

end;

function TSummarySheetsGUI.customDateCaption: String;
begin
  REsult := '';
end;

function TSummarySheetsGUI.CustomRangeFrom: Tdatetime;
begin
  REsult := 0;
end;

procedure TSummarySheetsGUI.DefaultCustomisation1Click(Sender: TObject);
begin
  inherited;
  SetupGrid;
end;

procedure TSummarySheetsGUI.ExtraFields;
begin

end;

procedure TSummarySheetsGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TSummarySheetsGUI.FormCreate(Sender: TObject);
var
  ctr:Integer;
begin
  HaveOnlyToDate['As Of'] := true;
  chkIgnoreDates.Visible := False;
  fiPageno:=0;
  IsGridcustomisable      := false;
  CanCreatecustomReport   := false;
  ReportonForeignCurrency := not(Self.ClassNameIs('TSummarySheetsGUI'));
  Databases:= '';
  Tablename := commondbLib.CreateUserTemporaryTable('tmp_SummarySheets' , '');
  Qrymain.SQL.Text := 'Select * from ' + tablename ;
  NonSearchMode:= true;
  inherited;
  SetupGrid;
  for ctr:= 0 to Qrymain.FieldCount-1 do
    if (qrymain.fields[ctr] is TFloatfield) and (qrymain.fields[ctr] <> qryMainExchangeRate) then
        if Pos('Percent' ,qrymain.fields[ctr].fieldname )=0 then // don;t need total of percentage
          Addcalccolumn(qrymain.fields[ctr].fieldname, true);
end;

procedure TSummarySheetsGUI.FormShow(Sender: TObject);
begin
  dtFrom.DateTime := 0;
  dtTo.DateTime := Date;
  inherited;
  dtFrom.DateTime := 0;
  dtTo.Date := Date;
  RefreshQuery;
end;

function TSummarySheetsGUI.getDatabases: String;
begin
  if fsDatabases = '' then fsDatabases := Appenv.AppDb.Database;
  result:= fsDatabases;
end;

function TSummarySheetsGUI.GetReportTypeID: integer;
begin
  REsult:= 120;
end;

procedure TSummarySheetsGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  try
  if gdFixed in state   then ABrush.Color := clwhite
  else if sametext(field.FieldName , 'Amt1') or
          sametext(field.FieldName , 'Amt2') or
          sametext(field.FieldName , 'Amt3') or
          sametext(field.FieldName , 'Amt4') then ABrush.Color := $00C6C6FF
  else if sametext(field.FieldName , 'Amt5') or
          sametext(field.FieldName , 'Amt6') or
          sametext(field.FieldName , 'Amt7') or
          sametext(field.FieldName , 'Amt8') or
          sametext(field.FieldName , 'Amt9') or
          sametext(field.FieldName , 'APTotal') or
          sametext(field.FieldName , 'Amt5Percent') or
          sametext(field.FieldName , 'Amt6Percent') or
          sametext(field.FieldName , 'Amt7Percent') or
          sametext(field.FieldName , 'Amt8Percent') or
          sametext(field.FieldName , 'Amt9Percent') then ABrush.Color := $00B7FFFF
  else if sametext(field.FieldName , 'Amt10') or
          sametext(field.FieldName , 'Amt11') or
          sametext(field.FieldName , 'Amt12') or
          sametext(field.FieldName , 'Amt13') or
          sametext(field.FieldName , 'Amt14') or
          sametext(field.FieldName , 'ARTotal') or
          sametext(field.FieldName , 'Amt10Percent') or
          sametext(field.FieldName , 'Amt11Percent') or
          sametext(field.FieldName , 'Amt12Percent') or
          sametext(field.FieldName , 'Amt13Percent') or
          sametext(field.FieldName , 'Amt14Percent') then ABrush.Color := $00B0FFB0
  else if sametext(field.FieldName , 'Amt15') or
          sametext(field.FieldName , 'Amt16') or
          sametext(field.FieldName , 'Amt17') or
          sametext(field.FieldName , 'Amt18') then ABrush.Color :=  $00FFFFC4
  else if sametext(field.FieldName , 'Amt19') or
          sametext(field.FieldName , 'Amt20') or
          sametext(field.FieldName , 'Amt21') or
          sametext(field.FieldName , 'Amt22') then ABrush.Color :=  $00EAD5FF
  else if sametext(field.FieldName , 'Amt23') or
          sametext(field.FieldName , 'Amt24') or
          sametext(field.FieldName , 'Amt25') or
          sametext(field.FieldName , 'Amt26') then ABrush.Color := $00FFBFBF
  else if sametext(field.FieldName , 'Amt27') or
          sametext(field.FieldName , 'Amt28') or
          sametext(field.FieldName , 'Amt29') or
          sametext(field.FieldName , 'Amt30') then ABrush.Color := $00FFCEFF
  else if sametext(field.FieldName , 'Amt31') or
          sametext(field.FieldName , 'Amt32') or
          sametext(field.FieldName , 'Amt33') or
          sametext(field.FieldName , 'Amt34') then ABrush.Color := $00FFCEFF
  else if sametext(field.FieldName , 'Amt35') or
          sametext(field.FieldName , 'Amt36') or
          sametext(field.FieldName , 'Amt37') or
          sametext(field.FieldName , 'Amt38') then ABrush.Color := $00FFCEFF;


  if      sametext(field.FieldName , 'Amt5Percent') or
          sametext(field.FieldName , 'Amt6Percent') or
          sametext(field.FieldName , 'Amt7Percent') or
          sametext(field.FieldName , 'Amt8Percent') or
          sametext(field.FieldName , 'Amt9Percent') or
          sametext(field.FieldName , 'Amt10Percent') or
          sametext(field.FieldName , 'Amt11Percent') or
          sametext(field.FieldName , 'Amt12Percent') or
          sametext(field.FieldName , 'Amt13Percent') or
          sametext(field.FieldName , 'Amt14Percent') then AFont.Color := clGray;
  Except
    on E:Exception do begin
    end;

  end;

end;


procedure TSummarySheetsGUI.MakeQrymain;
begin
    SummarySheetObj.makeQry(Self, Tablename, Databases , filterDateTo , ReportonForeignCurrency , FCOnReport, CustomRangeFrom);
end;
procedure TSummarySheetsGUI.qryMainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  SetIndicatorbutton;
end;

procedure TSummarySheetsGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  Databases :=  GuiPrefs.Node['Options.Databases'].asString;
  chkHidePercentage.Checked :=  GuiPrefs.Node['Options.HidePercentage'].asboolean;
end;


procedure TSummarySheetsGUI.Refreshfooter;
begin
  CalcnShowFooter;
end;

procedure TSummarySheetsGUI.RefreshQuery;
begin
  Qrymain.DisableControls;
  Try
    closeDb(Qrymain);
    MakeQrymain;
    inherited;
    SetupGrid;
  Finally
    Qrymain.EnableControls;
  End;
end;

procedure TSummarySheetsGUI.RefreshTotals;
begin
  inherited;
  CalcnShowFooter;
end;

procedure TSummarySheetsGUI.AddGridField(const fsfieldName: string; const fidisplaywidth: integer; const fsDisplayLabel: string );
begin
  if ReportonForeignCurrency and (FConReport.recordcount>0) then begin
    FConReport.first;
    AddGridSelectedfield(fsfieldName         ,fidisplaywidth ,  appenv.RegionalOptions.ForeignExDefault, ReplaceStr(fsDisplayLabel , '~' , ' '));
    while FConReport.eof = false do begin
      AddGridSelectedfield(FConReportCode.asString +'_' + fsfieldName         ,fidisplaywidth ,FConReportCode.asString, ReplaceStr(fsDisplayLabel , '~' , ' '));
      FConReport.Next;
    end;
  end else begin
    AddGridSelectedfield(fsfieldName         ,fidisplaywidth ,fsDisplayLabel);
  end;
end;
procedure TSummarySheetsGUI.SetDatabases(const Value: String);
var
  st:TStringlist;
  ctr:Integer;
begin
  fsDatabases := Value;

  st:= TStringlist.create;
  try
    st.commatext :=fsDatabases;
    if st.count >0 then
      for ctr:= st.count-1 downto 0 do
        if not IsERPDatabase(st[ctr]) then st.Delete(ctr);
  finally
    fsDatabases := st.commatext;
    FreeandNil(St);
  end;
end;

procedure TSummarySheetsGUI.SetupGrid;
begin
  FieldList := TStringList.Create;
  try
      AddGridSelectedfield('DbName'       ,20 ,'Database');
      AddGridSelectedfield('ClosingDate'  ,10 ,'Closing~Date'       );
      if (fiPageno = 1) then begin
        grdmain.titlelines := 2;
        AddGridField('ExchangeRate' ,10 ,'Ex Rate'            );
        AddGridField('Amt1'         ,12 ,'Cash in~Hand'       );
        AddGridField('Amt2'         ,12 ,'Accounts~Receivable');
        AddGridField('Amt3'         ,12 ,'Accounts~Payable'   );
        AddGridField('Amt4'         ,12 ,'Balance~Sheet'      );
      end else if (fiPageno = 2) then begin
        grdmain.titlelines := 2;
        AddGridField('ExchangeRate' ,10 ,'Ex Rate'            );
        AddGridField('Amt5'         ,12 ,'Current'            );
        if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt5Percent'  ,6  ,'%'                  );
        AddGridField('Amt6'         ,12 ,'1 - 30'             );
        if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt6Percent'  ,6  ,'%'                  );
        AddGridField('Amt7'         ,12 ,'31 - 60'            );
        if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt7Percent'  ,6  ,'%'                  );
        AddGridField('Amt8'         ,12 ,'61 - 90'            );
        if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt8Percent'  ,6  ,'%'                  );
        AddGridField('Amt9'         ,12 ,'90 +'               );
        if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt9Percent'  ,6  ,'%'                  );
        AddGridField('APtotal'      ,12 ,'Total'              );
      end else if (fiPageno = 3) then begin
        grdmain.titlelines := 2;
        AddGridField('ExchangeRate' ,10 ,'Ex Rate'            );
        AddGridField('Amt10'        ,12 ,'Current'            );
        if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt10Percent' ,6  ,'%'                  );
        AddGridField('Amt11'        ,12 ,'1 - 30'             );
        if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt11Percent' ,6  ,'%'                  );
        AddGridField('Amt12'        ,12 ,'31 - 60'            );
        if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt12Percent' ,6  ,'%'                  );
        AddGridField('Amt13'        ,12 ,'61 - 90'            );
        if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt13Percent' ,6  ,'%'                  );
        AddGridField('Amt14'        ,12 ,'90 +'               );
        if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt14Percent' ,6  ,'%'                  );
        AddGridField('ARtotal'      ,12 ,'Total'              );
      end else if (fiPageno = 4) then begin
        grdmain.titlelines := 2;
        AddGridField('ExchangeRate' ,10 ,'Ex Rate'            );
        AddGridField('Amt15'        ,12 ,'Sales'              );
        AddGridField('Amt16'        ,12 ,'Cost of Goods'      );
        AddGridField('Amt17'        ,12 ,'Expenses'           );
        AddGridField('Amt18'        ,12 ,'Profit & Loss'      );
      end else if (fiPageno = 5) then begin
        grdmain.titlelines := 2;
        AddGridField('ExchangeRate' ,10 ,'Ex Rate'            );
        AddGridField('Amt19'        ,12 ,'Sales'              );
        AddGridField('Amt20'        ,12 ,'Cost of Goods'      );
        AddGridField('Amt21'        ,12 ,'Expenses'           );
        AddGridField('Amt22'        ,12 ,'Profit & Loss'      );
      end else if (fiPageno = 6) then begin
        grdmain.titlelines := 2;
        AddGridField('ExchangeRate' ,10 ,'Ex Rate'            );
        AddGridField('Amt23'        ,12 ,'Sales'              );
        AddGridField('Amt24'        ,12 ,'Cost of Goods'      );
        AddGridField('Amt25'        ,12 ,'Expenses'           );
        AddGridField('Amt26'        ,12 ,'Profit & Loss'      );
      end else if (fiPageno = 7) then begin
        grdmain.titlelines := 2;
        AddGridField('ExchangeRate' ,10 ,'Ex Rate'            );
        AddGridField('Amt27'        ,12 ,'Sales'              );
        AddGridField('Amt28'        ,12 ,'Cost of Goods'      );
        AddGridField('Amt29'        ,12 ,'Expenses'           );
        AddGridField('Amt30'        ,12 ,'Profit & loss'      );
      end else if (fiPageno = 8) then begin
        grdmain.titlelines := 2;
        AddGridField('ExchangeRate' ,10 ,'Ex Rate'            );
        AddGridField('Amt31'        ,12 ,'Sales'              );
        AddGridField('Amt32'        ,12 ,'Cost of Goods'      );
        AddGridField('Amt33'        ,12 ,'Expenses'           );
        AddGridField('Amt34'        ,12 ,'Profit & loss'      );
      end else if (fiPageno = 9) then begin
        grdmain.titlelines := 2;
        AddGridField('ExchangeRate' ,10 ,'Ex Rate'            );
        AddGridField('Amt35'        ,12 ,'Sales'              );
        AddGridField('Amt36'        ,12 ,'Cost of Goods'      );
        AddGridField('Amt37'        ,12 ,'Expenses'           );
        AddGridField('Amt38'        ,12 ,'Profit & loss'      );
      end else if fiPageno = 0 then begin
          grdmain.titlelines := 4;
          AddGridSelectedfield('ExchangeRate' ,10 ,'Ex Rate'            ,'General');
          AddGridSelectedfield('Amt1'         ,12 ,'Cash in~Hand'       ,'General');
          AddGridSelectedfield('Amt2'         ,12 ,'Accounts~Receivable','General');
          AddGridSelectedfield('Amt3'         ,12 ,'Accounts~Payable'   ,'General');
          AddGridSelectedfield('Amt4'         ,12 ,'Balance~Sheet'      ,'General');

          AddGridSelectedfield('Amt5'         ,12 ,'Current'            ,'Payables');
          if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt5Percent'  ,6  ,'%'                  ,'Payables');
          AddGridSelectedfield('Amt6'         ,12 ,'1 - 30'             ,'Payables');
          if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt6Percent'  ,6  ,'%'                  ,'Payables');
          AddGridSelectedfield('Amt7'         ,12 ,'31 - 60'            ,'Payables');
          if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt7Percent'  ,6  ,'%'                  ,'Payables');
          AddGridSelectedfield('Amt8'         ,12 ,'61 - 90'            ,'Payables');
          if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt8Percent'  ,6  ,'%'                  ,'Payables');
          AddGridSelectedfield('Amt9'         ,12 ,'90 +'               ,'Payables');
          if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt9Percent'  ,6  ,'%'                  ,'Payables');
          AddGridSelectedfield('APtotal'      ,12 ,'Total'              ,'Payables');

          AddGridSelectedfield('Amt10'        ,12 ,'Current'            ,'Receivables');
          if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt10Percent' ,6  ,'%'                  ,'Receivables');
          AddGridSelectedfield('Amt11'        ,12 ,'1 - 30'             ,'Receivables');
          if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt11Percent' ,6  ,'%'                  ,'Receivables');
          AddGridSelectedfield('Amt12'        ,12 ,'31 - 60'            ,'Receivables');
          if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt12Percent' ,6  ,'%'                  ,'Receivables');
          AddGridSelectedfield('Amt13'        ,12 ,'61 - 90'            ,'Receivables');
          if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt13Percent' ,6  ,'%'                  ,'Receivables');
          AddGridSelectedfield('Amt14'        ,12 ,'90 +'               ,'Receivables');
          if chkHidePercentage.Checked = False then AddGridSelectedfield('Amt14Percent' ,6  ,'%'                  ,'Receivables');
          AddGridSelectedfield('ARtotal'      ,12 ,'Total'              ,'Receivables');

          AddGridSelectedfield('Amt15'        ,12 ,'Sales'              ,'Last Week (ex)');
          AddGridSelectedfield('Amt16'        ,12 ,'Cost of Goods'      ,'Last Week (ex)');
          AddGridSelectedfield('Amt17'        ,12 ,'Expenses'           ,'Last Week (ex)');
          AddGridSelectedfield('Amt18'        ,12 ,'Profit & Loss'      ,'Last Week (ex)');

          AddGridSelectedfield('Amt19'        ,12 ,'Sales'              ,'Last Month (ex)');
          AddGridSelectedfield('Amt20'        ,12 ,'Cost of Goods'      ,'Last Month (ex)');
          AddGridSelectedfield('Amt21'        ,12 ,'Expenses'           ,'Last Month (ex)');
          AddGridSelectedfield('Amt22'        ,12 ,'Profit & Loss'      ,'Last Month (ex)');

          AddGridSelectedfield('Amt23'        ,12 ,'Sales'              ,'Last 3 Months (ex)');
          AddGridSelectedfield('Amt24'        ,12 ,'Cost of Goods'      ,'Last 3 Months (ex)');
          AddGridSelectedfield('Amt25'        ,12 ,'Expenses'           ,'Last 3 Months (ex)');
          AddGridSelectedfield('Amt26'        ,12 ,'Profit & Loss'      ,'Last 3 Months (ex)');

          AddGridSelectedfield('Amt27'        ,12 ,'Sales'              ,'Last 6 Months (Ex)');
          AddGridSelectedfield('Amt28'        ,12 ,'Cost of Goods'      ,'Last 6 Months (Ex)');
          AddGridSelectedfield('Amt29'        ,12 ,'Expenses'           ,'Last 6 Months (Ex)');
          AddGridSelectedfield('Amt30'        ,12 ,'Profit & loss'      ,'Last 6 Months (Ex)');

          AddGridSelectedfield('Amt31'        ,12 ,'Sales'              ,'Last 12 Months (Ex)');
          AddGridSelectedfield('Amt32'        ,12 ,'Cost of Goods'      ,'Last 12 Months (Ex)');
          AddGridSelectedfield('Amt33'        ,12 ,'Expenses'           ,'Last 12 Months (Ex)');
          AddGridSelectedfield('Amt34'        ,12 ,'Profit & loss'      ,'Last 12 Months (Ex)');

          AddGridSelectedfield('Amt35'        ,12 ,'Sales'              ,customDateCaption);
          AddGridSelectedfield('Amt36'        ,12 ,'Cost of Goods'      ,customDateCaption);
          AddGridSelectedfield('Amt37'        ,12 ,'Expenses'           ,customDateCaption);
          AddGridSelectedfield('Amt38'        ,12 ,'Profit & loss'      ,customDateCaption);

      end;
      ExtraFields;
      AddGridSelectedfield('LastBankRecDate'  ,10 ,'Bank Rec~Date'       );
      grdMain.Selected := FieldList;
      grdMain.ApplySelected;
      closedb(qrymain);
      try
        opendb(qrymain);
        CalcnShowFooter;
      Except
      end;
    if assigned(GuiPrefs) and GuiPrefs.Active then begin
      GuiPrefs.DbGridElement[grdmain].GetColumnSettings(False);
      GuiPrefs.SavePrefs;
      GuiPrefs.ApplyGuiPrefs;
      GuiPrefs.SavePrefs;
    end;
  finally
    Freeandnil(FieldList);
  end;
end;

procedure TSummarySheetsGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.Databases'].asString:= Databases;
  GuiPrefs.Node['Options.HidePercentage'].asboolean := chkHidePercentage.Checked ;
end;
procedure TSummarySheetsGUI.grdMainDblClick(Sender: TObject);
begin
  //inherited;
  OpenERPForm('TfrmSummarySheetGUI' , 0 , nil, beforeshowSummarySheet);
end;
procedure TSummarySheetsGUI.beforeshowSummarySheet(Sender:TObject);
begin
  if not(Sender is TfrmSummarySheetGUI) then exit;
  TfrmSummarySheetGUI(Sender).Databasename := Qrymain.FieldByName('dbname').AsString ;
  TfrmSummarySheetGUI(Sender).dtTo.dateTime := FilterdateTo;
end;

initialization
  RegisterClass(TSummarySheetsGUI);
end.

