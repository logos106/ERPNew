{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 09/11/05  1.00.01 BJ   Implemented the advance Printing option
                        New template type created - sumary sheet
                        and the advance printing lists all the reports of the type
                        to choose from
}
unit frmSummarySheetFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB,  ExtCtrls,
  StdCtrls, Grids, ComCtrls,AdvOfficeStatusBar, DBClient, DBGrids, Provider,
  DNMPanel, PrintDAT, EditJust, kbmMemTable, Buttons, DNMSpeedButton, MemDS,
  DBAccess, MyAccess,ERPdbComponents, DataState, Menus, AdvMenus, Shader,
  ImgList, ProgressDialog, wwdbdatetimepicker, SummarySheetObj;

const
  SX_DatechangeMsg = WM_USER + 140;

type
  TfrmSummarySheetGUI = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    pdtExport: TPdtPrintDAT;
    dlgSave: TSaveDialog;
    Bevel2: TDNMPanel;
    cdsProfit: TkbmMemTable;
    qryTransactions: TERPQuery;
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Label1: TLabel;
    dtTo: TDateTimePicker;
    dtFrom: TDateTimePicker;
    DNMPanel3: TDNMPanel;
    Bevel4: TBevel;
    lbc1: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    edc1r5: TEditJust;
    edc1r6: TEditJust;
    edc1r7: TEditJust;
    edc1r8: TEditJust;
    lbc2: TLabel;
    edc2r5: TEditJust;
    edc2r6: TEditJust;
    edc2r7: TEditJust;
    edc2r8: TEditJust;
    lbc3: TLabel;
    edc3r5: TEditJust;
    edc3r6: TEditJust;
    edc3r7: TEditJust;
    edc3r8: TEditJust;
    lbc4: TLabel;
    edc4r5: TEditJust;
    edc4r6: TEditJust;
    edc4r7: TEditJust;
    edc4r8: TEditJust;
    lbC5: TLabel;
    edc5r5: TEditJust;
    edc5r6: TEditJust;
    edc5r7: TEditJust;
    edc5r8: TEditJust;
    lbC6: TLabel;
    edc6r5: TEditJust;
    edc6r6: TEditJust;
    edc6r7: TEditJust;
    edc6r8: TEditJust;
    DNMPanel4: TDNMPanel;
    btnClose: TDNMSpeedButton;
    cmdPrint: TDNMSpeedButton;
    cmdExport: TDNMSpeedButton;
    pnlAdvPrinting: TDNMPanel;
    LblChooseTemplate: TLabel;
    LblShowPreview: TLabel;
    ChkChooseRpt: TCheckBox;
    chkPreview: TCheckBox;
    Label6: TLabel;
    edc4r4: TEditJust;
    edc4r3: TEditJust;
    Label5: TLabel;
    Label4: TLabel;
    edc4r2: TEditJust;
    edc4r1: TEditJust;
    Label3: TLabel;
    Label22: TLabel;
    ejForthAgeAR: TEditJust;
    lblARForthPercent: TLabel;
    lblARThirdPercent: TLabel;
    ejThirdAgeAR: TEditJust;
    Label19: TLabel;
    Label18: TLabel;
    ejSecondAgeAR: TEditJust;
    lblARSecondPercent: TLabel;
    lblARFirstPercent: TLabel;
    ejFirstAgeAR: TEditJust;
    Label17: TLabel;
    Label16: TLabel;
    ejCurrentAR: TEditJust;
    lblARCurPercent: TLabel;
    Label7: TLabel;
    Label2: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ejCurrentAP: TEditJust;
    lblAPCurPercent: TLabel;
    lblAPFirstPercent: TLabel;
    ejFirstAgeAP: TEditJust;
    Label10: TLabel;
    ejSecondAgeAP: TEditJust;
    lblAPSecondPercent: TLabel;
    Label15: TLabel;
    ejThirdAgeAP: TEditJust;
    lblAPThirdPercent: TLabel;
    Label20: TLabel;
    ejForthAgeAP: TEditJust;
    lblAPForthPercent: TLabel;
    Bevel1: TBevel;
    bvl6: TBevel;
    bvl1: TBevel;
    bvl2: TBevel;
    bvl3: TBevel;
    bvl4: TBevel;
    bvl5: TBevel;
    lblDatabase: TLabel;
    Bevel10: TBevel;
    Bevel11: TBevel;
    Bevel12: TBevel;
    Bevel13: TBevel;
    Bevel14: TBevel;
    Bevel15: TBevel;
    dtcustomFrom: TwwDBDateTimePicker;
    lblcustomFrom: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdCloseClick(Sender: TObject);
    procedure cdsProfitoldFilterRecord(DataSet: TDataSet; var Accept: boolean);
    procedure dtToChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grd1DrawCell(Sender: TObject; ACol, ARow: integer; Rect: TRect; State: TGridDrawState);
    procedure cmdPrintClick(Sender: TObject);
    procedure pdtPrintAfterOptionsLoaded(Sender: TObject; var ReportSettings: TpdtReportSettings);
    procedure cmdExportClick(Sender: TObject);
    procedure pdtExportAfterOptionsLoaded(Sender: TObject; var ReportSettings: TpdtReportSettings);
    procedure ProfitDblClick(Sender: TObject);
    procedure edc4r4DblClick(Sender: TObject);
    procedure PLDblClick(Sender: TObject);
    procedure DateChange(var Message: TMessage); message SX_DatechangeMsg;
    procedure Button1Click(Sender: TObject);
    procedure edc4r3DblClick(Sender: TObject);
    procedure edc4r2DblClick(Sender: TObject);
    procedure edc1r8DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MyConnectionBeforeConnect(Sender: TObject);
  private
    { Private declarations }
    PrevDate: TDateTime;
    PrevCustomDate: TDateTime;
    ExportFileName: string;
    sSQL: string;
    fsdatabasename: String;
//    fgrd: TStringGrid;
    SSO: TSummarySheetObj;
    procedure doCalc;
    procedure Setdatabasename(const Value: String);
    procedure ShowDBProp;
//    function grd: TStringGrid;
    Procedure ReadExtraGuipref;
    Procedure WriteExtraGuiPref;
    Procedure InitHints;
    function CustomDateFrom:TDateTime;
    Function DateTo:TDateTime;
    Function DateFrom :TDateTime;
  protected
    function GetReportTypeID: integer; override;
    procedure LoadTemplate(const bPrint, bSave: boolean; const DoClose: boolean = true; const FileName: string = '');      override;
  public
    Property Databasename:String read fsdatabasename write Setdatabasename;
  end;


implementation

uses FastFuncs,CommonDbLib, BalTransListForm,
  ProfitandLossReportForm, TransAccountDetailsForm, DNMExceptions,
  AR_APCalcUnit, CommonLib, BalanceSheetForm,
  AppEnvironment, MySQLConst , dateutils, TemplateReportsLib,
  LogLib, tcConst;

{$R *.dfm}
var
  acctFilterList: TStringList;
//  isInCalc: boolean;

procedure TfrmSummarySheetGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  cdsProfit.Close;
  CloseQueries;
  Action := caFree;
  WriteExtraGuiPref;
  inherited;
end;

procedure TfrmSummarySheetGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      if AccessLevel <> 6 then begin
        AccessLevel := 1; // we iether have access or we don't to this report
      end;

      inherited;
      acctFilterList := TStringList.Create;
      closedb(qryTransactions);
      qryTransactions.SQL.text := SummarySheetParamObj.TransQrySQL;
      OpenQueries;
      clog(qryTransactions.SQL.Text);
      cdsProfit.LoadFromDataSet(qryTransactions, [mtcpoStructure, mtcpoProperties, mtcpoFieldIndex]);

      doCalc;
      cmdPrint.Enabled := true;
      cmdExport.Enabled := true;
      ShowDBProp;
//      grd.visible := False;

      Inithints;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;
      else raise;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfrmSummarySheetGUI.ShowDBProp;
var
  s:String;
  tmpDate:TDateTime;
begin
  if sametext(Databasename , Appenv.AppDb.Database) then exit;

  pnlAdvPrinting.Visible := False;
  cmdPrint.Enabled := False;
  cmdExport.Enabled := False;

  with TempMyQuery(Myconnection) do try
    SQL.text := 'Select FieldValue from tbldbpreferences where name = ''TransactionTableLastUpdated''';
    open;
    s:= ' [' + Databasename +']';
    if recordcount =1 then begin
      try
        tmpDate :=StrToFloatDef(FieldByName('FieldValue').AsString, 0);
        s:= FormatDateTime(FormatSettings.ShortDateFormat + '" At "hh:mm AM/PM', tmpDate);
        s:= ' [' + Databasename + ' - ' + DoTranslate('Batch Transaction Last Update On : ') +  s +']';
      Except
      end;
    end;
    Self.Caption := 'Summary Sheet of ' +s;
  finally
    ClosenFree;
  end;
end;
procedure TfrmSummarySheetGUI.WriteExtraGuiPref;
begin
  GuiPrefs.Node['Options.customFrom'].AsDateTime := CustomDateFrom;
  fbIsLocalPrefChanged := True;
end;


procedure TfrmSummarySheetGUI.doCalc;
begin
  SSO.DateTo := dtTo.Date;
  SSO.DateFromCustom := dtCustomFrom.Date;
  SSO.LoadValues;

  edC4r1.Text := FloatToStrF(Round(SSO.TotalCashInBank,0), ffcurrency, 15, 2);
  edC4r2.Text := FloatToStrF(Round(SSO.TotalAR,0), ffcurrency, 15 , 2);
  edC4r3.Text := FloatToStrF(Round(SSO.TotalAP,0), ffcurrency, 15 , 2);
  edC4r4.Text := FloatToStrF(Round(SSO.TotalBalanceSheet,0), ffcurrency, 15 , 2);

  ejCurrentAR.Text := FormatFloat(AppEnv.RegionalOptions.CurrencySymbol+DOUBLE_FIELD_MASK, SSO.AR_Current);
  ejFirstAgeAR.Text := FormatFloat(AppEnv.RegionalOptions.CurrencySymbol+DOUBLE_FIELD_MASK, SSO.AR_1to30);
  ejSecondAgeAR.Text := FormatFloat(AppEnv.RegionalOptions.CurrencySymbol+DOUBLE_FIELD_MASK, SSO.AR_31to60);
  ejThirdAgeAR.Text := FormatFloat(AppEnv.RegionalOptions.CurrencySymbol+DOUBLE_FIELD_MASK, SSO.AR_61to90);
  ejForthAgeAR.Text := FormatFloat(AppEnv.RegionalOptions.CurrencySymbol+DOUBLE_FIELD_MASK, SSO.AR_90Plus);

  lblARCurPercent.caption := FloatToStr(SSO.AR_CurrentPercent) + '%';
  lblARFirstPercent.caption := FloatToStr(SSO.AR_1to30Percent) + '%';
  lblARSecondPercent.caption := FloatToStr(SSO.AR_31to60Percent) + '%';
  lblARThirdPercent.caption := FloatToStr(SSO.AR_61to90Percent) + '%';
  lblARForthPercent.caption := FloatToStr(SSO.AR_90PlusPercent) + '%';

  ejCurrentAP.Text := FormatFloat(AppEnv.RegionalOptions.CurrencySymbol+DOUBLE_FIELD_MASK, SSO.AP_Current);
  ejFirstAgeAP.Text := FormatFloat(AppEnv.RegionalOptions.CurrencySymbol+DOUBLE_FIELD_MASK, SSO.AP_1to30);
  ejSecondAgeAP.Text := FormatFloat(AppEnv.RegionalOptions.CurrencySymbol+DOUBLE_FIELD_MASK, SSO.AP_31to60);
  ejThirdAgeAP.Text := FormatFloat(AppEnv.RegionalOptions.CurrencySymbol+DOUBLE_FIELD_MASK, SSO.AP_61to90);
  ejForthAgeAP.Text := FormatFloat(AppEnv.RegionalOptions.CurrencySymbol+DOUBLE_FIELD_MASK, SSO.AP_90Plus);

  lblAPCurPercent.caption := FloatToStr(SSO.AP_CurrentPercent) + '%';
  lblAPFirstPercent.caption := FloatToStr(SSO.AP_1to30Percent) + '%';
  lblAPSecondPercent.caption := FloatToStr(SSO.AP_31to60Percent) + '%';
  lblAPThirdPercent.caption := FloatToStr(SSO.AP_61to90Percent) + '%';
  lblAPForthPercent.caption := FloatToStr(SSO.AP_90PlusPercent) + '%';

  edC1r5.Text := FloatToStrF(Round(SSO.Sales_Week, 0), ffcurrency, 15, 2);
  edC1r6.Text := FloatToStrF(Round(SSO.COGS_Week, 0), ffcurrency, 15, 2);
  edC1r7.Text := FloatToStrF(Round(SSO.Expenses_Week, 0), ffcurrency, 15, 2);
  edC1r8.Text := FloatToStrF(Round(SSO.PnL_Week, 0), ffcurrency, 15, 2);

  edC2r5.Text := FloatToStrF(Round(SSO.Sales_Month, 0), ffcurrency, 15, 2);
  edC2r6.Text := FloatToStrF(Round(SSO.COGS_Month, 0), ffcurrency, 15, 2);
  edC2r7.Text := FloatToStrF(Round(SSO.Expenses_Month, 0), ffcurrency, 15, 2);
  edC2r8.Text := FloatToStrF(Round(SSO.PnL_Month, 0), ffcurrency, 15, 2);

  edC3r5.Text := FloatToStrF(Round(SSO.Sales_Quarter, 0), ffcurrency, 15, 2);
  edC3r6.Text := FloatToStrF(Round(SSO.COGS_Quarter, 0), ffcurrency, 15, 2);
  edC3r7.Text := FloatToStrF(Round(SSO.Expenses_Quarter, 0), ffcurrency, 15, 2);
  edC3r8.Text := FloatToStrF(Round(SSO.PnL_Quarter, 0), ffcurrency, 15, 2);

  edC4r5.Text := FloatToStrF(Round(SSO.Sales_HalfYear, 0), ffcurrency, 15, 2);
  edC4r6.Text := FloatToStrF(Round(SSO.COGS_HalfYear, 0), ffcurrency, 15, 2);
  edC4r7.Text := FloatToStrF(Round(SSO.Expenses_HalfYear, 0), ffcurrency, 15, 2);
  edC4r8.Text := FloatToStrF(Round(SSO.Pnl_HalfYear, 0), ffcurrency, 15, 2);

  edC5r5.Text := FloatToStrF(Round(SSO.Sales_Year, 0), ffcurrency, 15, 2);
  edC5r6.Text := FloatToStrF(Round(SSO.COGS_Year, 0), ffcurrency, 15, 2);
  edC5r7.Text := FloatToStrF(Round(SSO.Expenses_Year, 0), ffcurrency, 15, 2);
  edC5r8.Text := FloatToStrF(Round(SSO.PnL_Year, 0), ffcurrency, 15, 2);

  edC6r5.Text := FloatToStrF(Round(SSO.Sales_Custom, 0), ffcurrency, 15, 2);
  edC6r6.Text := FloatToStrF(Round(SSO.COGS_Custom, 0), ffcurrency, 15, 2);
  edC6r7.Text := FloatToStrF(Round(SSO.Expenses_Custom, 0), ffcurrency, 15, 2);
  edC6r8.Text := FloatToStrF(Round(SSO.PnL_Custom, 0), ffcurrency, 15, 2);


//  isInCalc := true;
//  ProcessingCursor(True);
////  sl := TStringList.Create;
//  try
////    sl.Add('Col,Row,Filter,Value,FromDate');
//    DoShowProgressbar(4, WAITMSG);
//    try
//        // Lets do the Age Report for Accounts Receivable and Payable.
//        ejCurrentAR.Text := FormatFloat(AppEnv.RegionalOptions.CurrencySymbol+DOUBLE_FIELD_MASK, ReturnDueARTotalWithinRange(DateTo, 0, 0, MyConnection));
//        ejFirstAgeAR.Text := FormatFloat(AppEnv.RegionalOptions.CurrencySymbol+DOUBLE_FIELD_MASK, ReturnDueARTotalWithinRange(DateTo, 0, 30, MyConnection));
//        ejSecondAgeAR.Text := FormatFloat(AppEnv.RegionalOptions.CurrencySymbol+DOUBLE_FIELD_MASK, ReturnDueARTotalWithinRange(DateTo, 30, 60, MyConnection));
//        ejThirdAgeAR.Text := FormatFloat(AppEnv.RegionalOptions.CurrencySymbol+DOUBLE_FIELD_MASK, ReturnDueARTotalWithinRange(DateTo, 60, 90, MyConnection));
//        ejForthAgeAR.Text := FormatFloat(AppEnv.RegionalOptions.CurrencySymbol+DOUBLE_FIELD_MASK, ReturnDueARTotalWithinRange(DateTo, 90, 99999999, MyConnection));
//
//        Total := ReturnDueAccountsReceivableTotal(DateTo, MyConnection);
//        lblARCurPercent.caption := FloatToStr(CalcPercentage(StrValue(ejCurrentAR.Text), Total)) + '%';
//        lblARFirstPercent.caption := FloatToStr(CalcPercentage(StrValue(ejFirstAgeAR.Text), Total)) + '%';
//        lblARSecondPercent.caption := FloatToStr(CalcPercentage(StrValue(ejSecondAgeAR.Text), Total)) + '%';
//        lblARThirdPercent.caption := FloatToStr(CalcPercentage(StrValue(ejThirdAgeAR.Text), Total)) + '%';
//        lblARForthPercent.caption := FloatToStr(CalcPercentage(StrValue(ejForthAgeAR.Text), Total)) + '%';
//
//        ejCurrentAP.Text := FormatFloat(AppEnv.RegionalOptions.CurrencySymbol+DOUBLE_FIELD_MASK, ReturnDueAPTotalWithinRange(DateTo, 0, 0, MyConnection));
//        ejFirstAgeAP.Text := FormatFloat(AppEnv.RegionalOptions.CurrencySymbol+DOUBLE_FIELD_MASK, ReturnDueAPTotalWithinRange(DateTo, 0, 30, MyConnection));
//        ejSecondAgeAP.Text := FormatFloat(AppEnv.RegionalOptions.CurrencySymbol+DOUBLE_FIELD_MASK, ReturnDueAPTotalWithinRange(DateTo, 30, 60, MyConnection));
//        ejThirdAgeAP.Text := FormatFloat(AppEnv.RegionalOptions.CurrencySymbol+DOUBLE_FIELD_MASK, ReturnDueAPTotalWithinRange(DateTo, 60, 90, MyConnection));
//        ejForthAgeAP.Text := FormatFloat(AppEnv.RegionalOptions.CurrencySymbol+DOUBLE_FIELD_MASK, ReturnDueAPTotalWithinRange(DateTo, 90, 99999999, MyConnection));
//
//        Total := ReturnDueAccountsPayableTotal(DateTo, MyConnection);
//        lblAPCurPercent.caption := FloatToStr(CalcPercentage(StrValue(ejCurrentAP.Text), Total)) + '%';
//        lblAPFirstPercent.caption := FloatToStr(CalcPercentage(StrValue(ejFirstAgeAP.Text), Total)) + '%';
//        lblAPSecondPercent.caption := FloatToStr(CalcPercentage(StrValue(ejSecondAgeAP.Text), Total)) + '%';
//        lblAPThirdPercent.caption := FloatToStr(CalcPercentage(StrValue(ejThirdAgeAP.Text), Total)) + '%';
//        lblAPForthPercent.caption := FloatToStr(CalcPercentage(StrValue(ejForthAgeAP.Text), Total)) + '%';
//        DoStepProgressbar();
//        // Now perform other calculations.
//        for r := 1 to 8 do begin
//          grd.Cells[0, r] := rowText[r];
//          for c := 1 to 6 do begin
//            if r = 1 then begin
//              grd.Cells[c, 0] := SummarySheetParamObj(DateTo , CustomDateFrom).colText[c];
//            end;
//            SetPL(c, r);
//          end;
//        end;
//
//        DoStepProgressbar();
//        lbc1.caption := grd.Cells[1, 0];
//        lbc2.caption := grd.Cells[2, 0];
//        lbc3.caption := grd.Cells[3, 0];
//        lbc4.caption := grd.Cells[4, 0];
//        lbc5.caption := grd.Cells[5, 0];
//        lbc6.caption := grd.Cells[6, 0];
//        showcontrolhint(lbc6 , 'From '+ grd.Cells[6, 0]) ;
//
//        edC4r1.Text := GridValuetocurrency(6,1);
//        edC4r2.Text := GridValuetocurrency(6,2);
//        edC4r3.Text := GridValuetocurrency(6,3);
//        edC4r4.Text := GridValuetocurrency(6,4);
//
//        edC1r5.Text := GridValuetocurrency(1,5);
//        edC1r6.Text := GridValuetocurrency(1,6);
//        edC1r7.Text := GridValuetocurrency(1,7);
//        edC1r8.Text := GridValuetocurrency(1,8);
//
//        edC2r5.Text := GridValuetocurrency(2,5);
//        edC2r6.Text := GridValuetocurrency(2,6);
//        edC2r7.Text := GridValuetocurrency(2,7);
//        edC2r8.Text := GridValuetocurrency(2,8);
//
//        edC3r5.Text := GridValuetocurrency(3,5);
//        edC3r6.Text := GridValuetocurrency(3,6);
//        edC3r7.Text := GridValuetocurrency(3,7);
//        edC3r8.Text := GridValuetocurrency(3,8);
//
//        edC4r5.Text := GridValuetocurrency(4,5);
//        edC4r6.Text := GridValuetocurrency(4,6);
//        edC4r7.Text := GridValuetocurrency(4,7);
//        edC4r8.Text := GridValuetocurrency(4,8);
//
//        edC5r5.Text := GridValuetocurrency(5,5);
//        edC5r6.Text := GridValuetocurrency(5,6);
//        edC5r7.Text := GridValuetocurrency(5,7);
//        edC5r8.Text := GridValuetocurrency(5,8);
//
//        edC6r5.Text := GridValuetocurrency(6,5);
//        edC6r6.Text := GridValuetocurrency(6,6);
//        edC6r7.Text := GridValuetocurrency(6,7);
//        edC6r8.Text := GridValuetocurrency(6,8);
//        DoStepProgressbar();
//    finally
//      DoHideProgressbar;
//    end;
//
////    sl.SaveToFile('c:\temp\summsheet.csv');
//  finally
////    sl.Free;
//    ProcessingCursor(False);
//  end;
//  isInCalc := false;
end;

procedure TfrmSummarySheetGUI.cdsProfitoldFilterRecord(DataSet: TDataSet; var Accept: boolean);
begin
  Accept :=
    (cdsProfit.FieldByName('Date').AsDateTime >= DateFrom) and
    (cdsProfit.FieldByName('Date').AsDateTime <= DateTo) and
    (acctFilterList.IndexOf(cdsProfit.FieldByName('AccountType').AsString) >= 0);
end;

procedure TfrmSummarySheetGUI.dtToChange(Sender: TObject);
begin
  if not (DateTo = PrevDate) or not (DateFrom = PrevCustomDate) then begin
    PostMessage(self.Handle, SX_DatechangeMsg, 0, 0);
  end;
  PrevDate := DateTo;
  PrevCustomDate := CustomDateFrom;
end;

procedure TfrmSummarySheetGUI.cmdCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSummarySheetGUI.FormDestroy(Sender: TObject);
begin
  FreeandNil(acctFilterList);
  inherited;
end;

//function TfrmSummarySheetGUI.grd: TStringGrid;
//begin
//  if fgrd = nil then begin
//    fgrd:= TStringGrid.Create(Self);
//    fgrd.DefaultColWidth := 100;
//    fgrd.RowCount := 9;
//    fgrd.Options := [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine];
//    fgrd.Visible := False;
//    fgrd.ColCount := 7;
//  end;
//  Result:=fgrd;
//end;

procedure TfrmSummarySheetGUI.grd1DrawCell(Sender: TObject; ACol, ARow: integer; Rect: TRect; State: TGridDrawState);
//var
//  w: integer;
begin
//  inherited;
//  with grd.Canvas do begin
//    if (ARow > 0) and (ARow < 5) and (ACol > 0) and (ACol < 6) then begin
//      Brush.Color := grd.FixedColor;
//      FillRect(Rect);
//    end;
//
//    w := TextWidth(grd.Cells[ACol, ARow]);
//    if (w > 0) and (ACol > 0) then if ARow > 0 then TextRect(Rect, Rect.Right - w - 2, Rect.Top + 3,
//          Format('%9.0n', [StrToFloat(grd.Cells[ACol, ARow])]))
//      else TextRect(Rect, Rect.Right - w - 2, Rect.Top + 3, grd.Cells[ACol, ARow]);
//  end;
end;

procedure TfrmSummarySheetGUI.InitHints;
begin
      showcontrolhint(bvl1 , 'From '+ FormatDatetime(FormatSettings.ShortDateFormat , incday(dtTo.Date , 0-SummarySheetParamObj.days[1] )) +' to ' + FormatDatetime(FormatSettings.ShortDateFormat , dtTo.Date)) ;
      showcontrolhint(bvl2 , 'From '+ FormatDatetime(FormatSettings.ShortDateFormat , incday(dtTo.Date , 0-SummarySheetParamObj.days[2] )) +' to ' + FormatDatetime(FormatSettings.ShortDateFormat , dtTo.Date)) ;
      showcontrolhint(bvl3 , 'From '+ FormatDatetime(FormatSettings.ShortDateFormat , incday(dtTo.Date , 0-SummarySheetParamObj.days[3] )) +' to ' + FormatDatetime(FormatSettings.ShortDateFormat , dtTo.Date)) ;
      showcontrolhint(bvl4 , 'From '+ FormatDatetime(FormatSettings.ShortDateFormat , incday(dtTo.Date , 0-SummarySheetParamObj.days[4] )) +' to ' + FormatDatetime(FormatSettings.ShortDateFormat , dtTo.Date)) ;
      showcontrolhint(bvl5 , 'From '+ FormatDatetime(FormatSettings.ShortDateFormat , incday(dtTo.Date , 0-SummarySheetParamObj.days[5] )) +' to ' + FormatDatetime(FormatSettings.ShortDateFormat , dtTo.Date)) ;
      showcontrolhint(bvl6 ,  lbc6.hint) ;
      showcontrolhint(lbc1,bvl1.Hint) ;showcontrolhint(edc1r5,bvl1.Hint) ;showcontrolhint(edc1r6,bvl1.Hint) ;showcontrolhint(edc1r7,bvl1.Hint) ;showcontrolhint(edc1r8,bvl1.Hint) ;
      showcontrolhint(lbc2,bvl2.Hint) ;showcontrolhint(edc2r5,bvl2.Hint) ;showcontrolhint(edc2r6,bvl2.Hint) ;showcontrolhint(edc2r7,bvl2.Hint) ;showcontrolhint(edc2r8,bvl2.Hint) ;
      showcontrolhint(lbc3,bvl3.Hint) ;showcontrolhint(edc3r5,bvl3.Hint) ;showcontrolhint(edc3r6,bvl3.Hint) ;showcontrolhint(edc3r7,bvl3.Hint) ;showcontrolhint(edc3r8,bvl3.Hint) ;
      showcontrolhint(lbc4,bvl4.Hint) ;showcontrolhint(edc4r5,bvl4.Hint) ;showcontrolhint(edc4r6,bvl4.Hint) ;showcontrolhint(edc4r7,bvl4.Hint) ;showcontrolhint(edc4r8,bvl4.Hint) ;
      showcontrolhint(lbc5,bvl5.Hint) ;showcontrolhint(edc5r5,bvl5.Hint) ;showcontrolhint(edc5r6,bvl5.Hint) ;showcontrolhint(edc5r7,bvl5.Hint) ;showcontrolhint(edc5r8,bvl5.Hint) ;
      showcontrolhint(edc6r5,bvl6.Hint) ;showcontrolhint(edc6r6,bvl6.Hint) ;showcontrolhint(edc6r7,bvl6.Hint) ;showcontrolhint(edc6r8,bvl6.Hint) ; showcontrolhint(dtcustomFrom,bvl6.Hint) ; showcontrolhint(lblcustomFrom,bvl6.Hint) ;
end;

procedure TfrmSummarySheetGUI.cmdPrintClick(Sender: TObject);
var
  Tablename: string;
//  c,
  r: integer;
  s:String;
begin
  DisableForm;
  try
    TableName := GetUserTemporaryTableName('Summary');
    with TERPQuery.Create(nil) do try
        Options.FlatBuffers := True;
        Connection := MyConnection;
        SQl.add('Drop table if exists ' + Tablename + ';');
        SQL.add(' Create Table ' + tablename);
        SQL.add('(`Accountname` VARCHAR (100), ');
        SQL.add('`Last_Week_Ex` double, ');
        SQL.add('`Last_month_Ex` double, ');
        SQL.add('`Last_3_Month_Ex` double, ');
        SQL.add('`Last_6_Month_Ex` double, ');
        SQL.add('`Last_12_Month_Ex` double,');
        SQL.add('`custom` double);');
        for r := 1 to 8 do begin
          s := '"' + rowText[r] + '",';
          case r of
            1: begin
                 s := s + '0,0,0,0,0,' + FloatToStr(SSO.TotalCashInBank);
               end;
            2: begin
                 s := s + '0,0,0,0,0,' + FloatToStr(SSO.TotalAR);
               end;
            3: begin
                 s := s + '0,0,0,0,0,' + FloatToStr(SSO.TotalAP);
               end;
            4: begin
                 s := s + '0,0,0,0,0,' + FloatToStr(SSO.TotalBalanceSheet);
               end;
            5: begin
                 s := s +
                   FloatToStr(SSO.Sales_Week) + ',' +
                   FloatToStr(SSO.Sales_Month) + ',' +
                   FloatToStr(SSO.Sales_Quarter) + ',' +
                   FloatToStr(SSO.Sales_HalfYear) + ',' +
                   FloatToStr(SSO.Sales_Year) + ',' +
                   FloatToStr(SSO.Sales_Custom);
               end;
            6: begin
                 s := s +
                   FloatToStr(SSO.COGS_Week) + ',' +
                   FloatToStr(SSO.COGS_Month) + ',' +
                   FloatToStr(SSO.COGS_Quarter) + ',' +
                   FloatToStr(SSO.COGS_HalfYear) + ',' +
                   FloatToStr(SSO.COGS_Year) + ',' +
                   FloatToStr(SSO.COGS_Custom);
               end;
            7: begin
                 s := s +
                   FloatToStr(SSO.Expenses_Week) + ',' +
                   FloatToStr(SSO.Expenses_Month) + ',' +
                   FloatToStr(SSO.Expenses_Quarter) + ',' +
                   FloatToStr(SSO.Expenses_HalfYear) + ',' +
                   FloatToStr(SSO.Expenses_Year) + ',' +
                   FloatToStr(SSO.Expenses_Custom);
               end;
            8: begin
                 s := s +
                   FloatToStr(SSO.PnL_Week) + ',' +
                   FloatToStr(SSO.PnL_Month) + ',' +
                   FloatToStr(SSO.PnL_Quarter) + ',' +
                   FloatToStr(SSO.PnL_HalfYear) + ',' +
                   FloatToStr(SSO.PnL_Year) + ',' +
                   FloatToStr(SSO.PnL_Custom);
               end;
          end;


//          grd.Cells[0, r] := rowText[r];
//          s:= '';
//          for c := 0 to 6 do begin
//            If StrValue(grd.Cells[c, r])=0 then Begin
//              If (C=0) then {name colomn}
//                s:= s +QuotedStr( grd.Cells[c, r])
//              else
//                s:= s +'0';
//            end else Begin
//              s:= s +QuotedStr(FloatToStr(StrValue(grd.Cells[c, r])));
//            end;
//            if c <> 6 then s:= s +',';
//          end;
          SQL.add(' INSERT HIGH_PRIORITY INTO ' + tablename +
                  ' (Accountname,Last_Week_Ex,Last_month_Ex,Last_3_Month_Ex,Last_6_Month_Ex, Last_12_Month_Ex,Custom)' +
                  ' Values (' + s +');');
        end;

        clog( SQL.Text);
        Execute;
        sSQL :=
          companyInfoSQL +
          ' ~|||~{Detail}Select Accountname, Last_Week_Ex, Last_month_Ex, Last_3_Month_Ex, Last_6_Month_Ex , Last_12_Month_Ex , Custom from ' + tablename+
          '~|||~{Params}Select ' + Quotedstr(formatdateTime(MysqlDateTimeFormat , SummarySheetParamObj.CustomRangeFrom ))+' as CustomRangeFrom , ' +
                                  Quotedstr(formatdateTime(MysqlDateTimeFormat , SummarySheetParamObj.Reportdate ))+' as Reportdate';
        LoadTemplate(true, false);
      finally
        if active then Close;
        DestroyUserTemporaryTable(TableName);
        Free;
      end;
  finally
    EnableForm;
  end;
end;

function TfrmSummarySheetGUI.GetReportTypeID: integer;
begin
  Result := 78;
end;



procedure TfrmSummarySheetGUI.LoadTemplate(const bPrint, bSave: boolean; const DoClose: boolean = true;
  const FileName: string = '');
begin
  if chkChooseRpt.Checked then begin
    LoadReportTypes;
    if dlgReportSelect.Execute then begin
      ReportToPrint := dlgReportSelect.SelectedItems.Text;
      inherited;
    end;
  end else begin
    inherited;
  end;

  fbReportSQLSupplied := true;
  PrintTemplateReport(ReportToPrint, sSQL, chkPreview.Checked = false, 1);
  ReportToPrint := '';
end;

procedure TfrmSummarySheetGUI.MyConnectionBeforeConnect(Sender: TObject);
begin
  inherited;
  if Databasename <> '' then MyConnection.Database := databasename
  else Databasename := MyConnection.Database ;
end;

procedure TfrmSummarySheetGUI.pdtPrintAfterOptionsLoaded(Sender: TObject; var ReportSettings: TpdtReportSettings);
begin
  with ReportSettings.RptMemo[rmRptHdr] do begin
    MemoBuf       := CommonDbLib.GetCompanyName + #13#10 + 'Summary Sheet';
    MemoXPosPer   := 15;
    MemoWidPer    := 70;
    MemoAlignment := taCenter;
    MemoVisible   := true;
  end;

  with ReportSettings.RptMemo[rmRptFtr] do begin
    MemoBuf       := 'Data as of ' + FormatDateTime('dd.mm.yy', DateTo);
    MemoXPosPer   := 15;
    MemoWidPer    := 70;
    MemoAlignment := taCenter;
    MemoVisible   := true;
  end;
end;

procedure TfrmSummarySheetGUI.cmdExportClick(Sender: TObject);
var
  sFileExt: string;
begin
  DisableForm;
  try
    dlgSave.Title := 'Export - ' + Caption;
    if dlgSave.Execute then begin
      ExportFileName := dlgSave.FileName;
      sFileExt       := ExtractFileExt(dlgSave.FileName);
      if uppercase(sFileExt) <> '.TXT' then CommonLib.MessageDlgXP_Vista('Unsupported export format. Valid format text only.',
          mtWarning, [mbOK], 0)
      else pdtExport.Print;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfrmSummarySheetGUI.pdtExportAfterOptionsLoaded(Sender: TObject; var ReportSettings: TpdtReportSettings);
begin
  ReportSettings.OutputFileName := ExportFileName;
  ReportSettings.OutputDest := odExportFile;
  ReportSettings.ExportFieldDelim := #9;
  ReportSettings.PreviewFirst := false;
  ReportSettings.DisplayReportOptionsWin := false;
end;

procedure TfrmSummarySheetGUI.ProfitDblClick(Sender: TObject);
var
  sFilter: string;
  frmBalTransList: TComponent;
begin                        // BANK
  sFilter := '';
  if not FormStillOpen('TBalTransListGUI') then begin
    frmBalTransList := GetComponentByClassName('TBalTransListGUI');
    if Assigned(frmBalTransList) then begin
      with TBalTransListGUI(frmBalTransList) do begin
        TBalTransListGUI(frmBalTransList).ToDate := Self.DateTo;
        if Sender = edc4r1 then sFilter := '(AccountType = ''BANK'') OR (AccountType = ''CCARD'')'
        else if Sender = edc4r2 then sFilter := '(AccountType = ''AR'')'
        else if Sender = edc4r3 then sFilter := '(AccountType = ''AP'')';
        TBalTransListGUI(frmBalTransList).Reportfilter :=sFilter;
        FormStyle := fsmdiChild;
      end;
    end;
  end else begin
    frmBalTransList := FindExistingComponent('TBalTransListGUI');
    TForm(frmBalTransList).Show;
  end;
end;

procedure TfrmSummarySheetGUI.ReadExtraGuipref;
begin
  if GuiPrefs.Active = False then GuiPrefs.Active := TRue;
  if GuiPrefs.Node.Exists('Options.customFrom') then
    dtcustomFrom.DateTime := GuiPrefs.Node['Options.customFrom'].AsDateTime
  else dtcustomFrom.DateTime := incmonth(Date , -6);
end;

procedure TfrmSummarySheetGUI.Setdatabasename(const Value: String);
begin
  fsdatabasename := Value;
  if MyConnection.connected then MyConnection.Disconnect;
  MyConnection.Database := Value;
  MyConnection.connect;
  lblDatabase.Caption := 'Database : ' + Value;
end;

procedure TfrmSummarySheetGUI.edc4r4DblClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  if not FormStillOpen('TBalanceSheetGUI') then begin
    Form := GetComponentByClassName('TBalanceSheetGUI');
    if Assigned(Form) then begin
      With TBalanceSheetGUI(Form) do Begin
        FormStyle := fsmdiChild;
        dtTo.DateTime := Self.DateTo;
        BringToFront;
      end;
    end;
  end else begin
    With TBalanceSheetGUI(FindExistingComponent('TBalanceSheetGUI')) do Begin
      dtTo.DateTime := Self.DateTo;
      Show;
      BringToFront;
    end;
  end;
end;

procedure TfrmSummarySheetGUI.PLDblClick(Sender: TObject);
var
  sFilter: string;
  frmTransAccountDetails : TComponent;
begin                        // BANK
  sFilter := '';

  if not FormStillOpen('TTransAccountDetailsGUI') then begin
      frmTransAccountDetails := GetComponentByClassName('TTransAccountDetailsGUI');
    if Assigned(frmTransAccountDetails) then begin
      with  TTransAccountDetailsGUI(frmTransAccountDetails) do begin
        ToDate := Self.DateTo;
        With SummarySheetParamObj(DateTo , CustomDateFrom) do begin
                 if (Sender = edc1r5) or (Sender = edc1r6) or (Sender = edc1r7) or (Sender = edc1r8) then FromDate := self.DateTo - days[1]
            else if (Sender = edc2r5) or (Sender = edc2r6) or (Sender = edc2r7) or (Sender = edc2r8) then FromDate := self.DateTo - days[2]
            else if (Sender = edc3r5) or (Sender = edc3r6) or (Sender = edc3r7) or (Sender = edc3r8) then FromDate := self.DateTo - days[3]
            else if (Sender = edc4r5) or (Sender = edc4r6) or (Sender = edc4r7) or (Sender = edc4r8) then FromDate := self.DateTo - days[4]
            else if (Sender = edc5r5) or (Sender = edc5r6) or (Sender = edc5r7) or (Sender = edc5r8) then FromDate := self.DateTo - days[5]
            else if (Sender = edc6r5) or (Sender = edc6r6) or (Sender = edc6r7) or (Sender = edc6r8) then FromDate := self.DateTo - days[6];
        end;


             if (Sender = edc1r5) or (Sender = edc2r5) or (Sender = edc3r5) or (Sender = edc4r5) or (Sender = edc5r5) or (Sender = edc6r5) then sFilter := '(AccountType = "INC") OR (AccountType = "EXINC")'
        else if (Sender = edc1r6) or (Sender = edc2r6) or (Sender = edc3r6) or (Sender = edc4r6) or (Sender = edc5r6) or (Sender = edc6r6) then sFilter := '(AccountType = "COGS")'
        else if (Sender = edc1r7) or (Sender = edc2r7) or (Sender = edc3r7) or (Sender = edc4r7) or (Sender = edc5r7) or (Sender = edc6r7) then sFilter := '(AccountType = "EXP") OR (AccountType = "EXEXP")'
        else if (Sender = edc1r8) or (Sender = edc2r8) or (Sender = edc3r8) or (Sender = edc4r8) or (Sender = edc5r8) or (Sender = edc6r8) then sFilter := '(AccountType = "INC") OR (AccountType = "EXINC") OR (AccountType = "COGS") OR (AccountType = "EXP") OR (AccountType = "EXEXP")';

        WhereString := 'AND (' + sFilter + ') Group by TransID;';
        FormStyle := fsmdiChild;
        RefreshTotals;
      end;
    end;
  end else begin
    frmTransAccountDetails := FindExistingComponent('TTransAccountDetailsGUI');
    TForm(frmTransAccountDetails).Show;
    TTransAccountDetailsGUI(frmTransAccountDetails).RefreshTotals;
  end;
end;

procedure TfrmSummarySheetGUI.DateChange(var Message: TMessage);
begin
  if not(dtTo.DroppedDown) and not(dtcustomFrom.DroppedDown)  then begin
    doCalc;
    InitHints;
  end;
end;

procedure TfrmSummarySheetGUI.Button1Click(Sender: TObject);
begin
  inherited;
  doCalc;
  InitHints;
end;

procedure TfrmSummarySheetGUI.edc4r3DblClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  if not FormStillOpen('TAccountsPayListGUI') then begin
    Form := GetComponentByClassName('TAccountsPayListGUI');
    if Assigned(Form) then begin
      with TForm(Form) do begin
        FormStyle := fsmdiChild;
        BringToFront;
      end;
    end;
  end else begin
    with TForm(FindExistingComponent('TAccountsPayListGUI')) do begin
      Show;
      BringToFront;
    end;
  end;
end;

procedure TfrmSummarySheetGUI.edc4r2DblClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  if not FormStillOpen('TAccountsReceiveListGUI') then begin
    Form := GetComponentByClassName('TAccountsReceiveListGUI');
    if Assigned(Form) then begin
      with TForm(Form) do begin
        FormStyle := fsmdiChild;
        BringToFront;
      end;
    end;
  end else begin
    with TForm(FindExistingComponent('TAccountsReceiveListGUI')) do begin
      Show;
      BringToFront;
    end;
  end;
end;

procedure TfrmSummarySheetGUI.edc1r8DblClick(Sender: TObject);
var
  sFilter: string;
  frmProfitAndLoss: TComponent;
begin
  sFilter := '';

  if not FormStillOpen('TProfitandLossGUI') then begin
    frmProfitAndLoss := GetComponentByClassName('TProfitandLossGUI');
    if Assigned(frmProfitAndLoss) then begin
      with TProfitandLossGUI(frmProfitAndLoss)do begin
        ToDate := Self.DateTo;
        With SummarySheetParamObj(DateTo , CustomDateFrom) do begin
                 if (Sender = edc1r5) or (Sender = edc1r6) or (Sender = edc1r7) or (Sender = edc1r8) then FromDate := Self.DateTo - days[1]
            else if (Sender = edc2r5) or (Sender = edc2r6) or (Sender = edc2r7) or (Sender = edc2r8) then FromDate := Self.DateTo - days[2]
            else if (Sender = edc3r5) or (Sender = edc3r6) or (Sender = edc3r7) or (Sender = edc3r8) then FromDate := Self.DateTo - days[3]
            else if (Sender = edc4r5) or (Sender = edc4r6) or (Sender = edc4r7) or (Sender = edc4r8) then FromDate := Self.DateTo - days[4]
            else if (Sender = edc5r5) or (Sender = edc5r6) or (Sender = edc5r7) or (Sender = edc5r8) then FromDate := Self.DateTo - days[5]
            else if (Sender = edc6r5) or (Sender = edc6r6) or (Sender = edc6r7) or (Sender = edc6r8) then FromDate := Self.DateTo - days[6];
        end;

        FormStyle := fsmdiChild;
      end;
    end;
  end else begin
    TForm(FindExistingComponent('TProfitandLossGUI')).Show;
  end;
end;

procedure TfrmSummarySheetGUI.FormCreate(Sender: TObject);
begin
  inherited;
  chkPreview.Checked := AppEnv.Employee.ShowPreview;
  dtTo.DateTime := Date;
  ReadExtraGuipref;
//  fgrd:= Nil;
  SSO := TSummarySheetObj.Create(self);
end;

function TfrmSummarySheetGUI.CustomDateFrom: TDateTime;
begin
  Result := dateof(dtcustomFrom.DateTime);
end;

function TfrmSummarySheetGUI.DateTo: TDateTime;
begin
  Result := IncSecond(IncDay(dateof(dtTo.DateTime), 1), -1);
end;
function TfrmSummarySheetGUI.DateFrom: TDateTime;
begin
  Result := (*dateof(*)dtFrom.DateTime(*)*);
end;

initialization
  RegisterClassOnce(TfrmSummarySheetGUI);

end.




