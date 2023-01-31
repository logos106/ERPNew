unit WagesJournal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, wwdblook, MyAccess,ERPdbComponents, MemDS,
  DBAccess, wwdbdatetimepicker, ProgressDialog,  Shader,
  kbmMemTable, DAScript, MyScript, CustomInputBox, wwcheckbox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TWagesJournalReportGUI = class(TBaseListingGUI)
    Label4: TLabel;
    cboDepartments: TwwDBLookupCombo;
    chkAllDepartments: TCheckBox;
    Label5: TLabel;
    qryMainType: TWideStringField;
    qryMainDate: TDateTimeField;
    qryMainClassID: TIntegerField;
    qryMainClassName: TWideStringField;
    qryMainCredit: TFloatField;
    qryMainDebit: TFloatField;
    qryMainDescription: TWideStringField;
    qryMainEmpName: TWideStringField;
    qryClass: TERPQuery;
    qryMainEmployeeID: TIntegerField;
    qryMainGlobalRef: TWideStringField;
    qryMainAccountDescription: TWideStringField;
    qryMainPayNo: TIntegerField;
    qryMainDEtails: TLargeintField;
    procedure chkAllDepartmentsClick(Sender: TObject);
    procedure cboDepartmentsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure actExecuteFilterExecute(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure qryMainBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }

  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    function GetReportTypeID: integer; override;

  public
    { Public declarations }

  end;

implementation

uses
  CommonDbLib, CommonLib, FastFuncs, tcConst;

{$R *.dfm}

{ TWagesJournalReportGUI }

function TWagesJournalReportGUI.GetReportTypeID: integer;
begin
  Result := 55;
end;

procedure TWagesJournalReportGUI.RefreshQuery;
begin
  qryMain.Close;
  qryMain.SQL.Clear;
  qryMain.SQL.Add('SELECT ');
  qryMain.SQL.Add('2 as DEtails,');
  qryMain.SQL.Add('PT.GlobalRef as GlobalRef,');
  qryMain.SQL.Add('PT.Type as Type, ');
  qryMain.SQL.Add('PT.Date as Date, ');
  qryMain.SQL.Add('PT.ClassID as ClassID, ');
  qryMain.SQL.Add('C.ClassName as ClassName,');
  qryMain.SQL.Add('P.PayID as PayID,');
  qryMain.SQL.Add('P.PayID as PayNo,');
  qryMain.SQL.Add('If(PT.Amount>0 ,PT.Amount,0.00)+0.00 as Credit,');
  qryMain.SQL.Add('If(PT.Amount<0 ,-PT.Amount,0.00)+0.00 as Debit,');
  qryMain.SQL.Add('PT.AccountName AS AccountDescription, ');
  qryMain.SQL.Add('PT.Description as Description, ');
  qryMain.SQL.Add('P.EmpName as EmpName, ');
  qryMain.SQL.Add('P.EmployeeID as EmployeeID');
  qryMain.SQL.Add('FROM tblpaystransactions AS PT');
  qryMain.SQL.Add('INNER JOIN tblpays AS P on P.PayID = PT.PayID');
  qryMain.SQL.Add('LEFT JOIN tblclass AS C on PT.ClassID = C.ClassID');
  if not chkAllDepartments.Checked then begin
    qryMain.SQL.Add('WHERE C.ClassName = :xClassName AND (PT.Date BETWEEN :xDate1 AND :xDate2)');
  end else begin
    qryMain.SQL.Add('WHERE PT.Date BETWEEN :xDate1 AND :xDate2');
  end;
  (*if chkIgnoreDates.Checked then begin
    qryMain.Params.ParamByName('xDate1').asDate := 0;
    qryMain.Params.ParamByName('xDate2').asDate := MaxDateTime;
  end
  else begin
    qryMain.Params.ParamByName('xDate1').asDate := dtFrom.DateTime;
    qryMain.Params.ParamByName('xDate2').asDate := dtTo.DateTime;
  end;*)

  qryMain.SQL.Add('Union all ');
  qryMain.SQL.Add('SELECT 1 as DEtails,');
  qryMain.SQL.Add('"" as GlobalRef,');
  qryMain.SQL.Add('"" as Type, ');
  qryMain.SQL.Add('PT.Date as Date, ');
  qryMain.SQL.Add('PT.ClassID as ClassID, ');
  qryMain.SQL.Add('C.ClassName as ClassName,');
  qryMain.SQL.Add('P.PayID as PayID,');
  qryMain.SQL.Add('P.PayID as PayNo,');
  qryMain.SQL.Add('Sum(If(PT.Amount>0 ,PT.Amount,0.00)+0.00) as Credit,');
  qryMain.SQL.Add('Sum(If(PT.Amount<0 ,-PT.Amount,0.00)+0.00) as Debit,');
  qryMain.SQL.Add('"" AS AccountDescription, ');
  qryMain.SQL.Add('" " as Description, ');
  qryMain.SQL.Add('P.EmpName as EmpName, ');
  qryMain.SQL.Add('P.EmployeeID as EmployeeID');
  qryMain.SQL.Add('FROM tblpaystransactions AS PT');
  qryMain.SQL.Add('INNER JOIN tblpays AS P on P.PayID = PT.PayID');
  qryMain.SQL.Add('LEFT JOIN tblclass AS C on PT.ClassID = C.ClassID');
  if not chkAllDepartments.Checked then begin
    qryMain.SQL.Add('WHERE C.ClassName = :xClassName AND (PT.Date BETWEEN :xDate1 AND :xDate2)');
  end else begin
    qryMain.SQL.Add('WHERE PT.Date BETWEEN :xDate1 AND :xDate2');
  end;
  qryMain.SQL.Add('GROUP BY P.PAYID');
  qryMain.SQL.Add('ORDER BY EmployeeID, Date, PAYID, Details');
  qryMain.Params.ParamByName('xDate1').asDateTime := FilterDatefrom;
  qryMain.Params.ParamByName('xDate2').asDateTime := FilterDateTo;
  if not chkAllDepartments.Checked then begin
    qryMain.Params.ParamByName('xClassName').asString := cboDepartments.Text;
  end;

//  qryMain.Params.ParamByName('xDate1').asDate := dtFrom.DateTime;
//  qryMain.Params.ParamByName('xDate2').asDate := dtTo.DateTime;
//  if not chkAllDepartments.Checked then begin
//    qryMain.Params.ParamByName('xClassName').asString := cboDepartments.Text;
//  end;
  inherited;
  grdMain.ColumnByName('EmpName').DisplayLabel := 'Employee';
end;

procedure TWagesJournalReportGUI.RefreshTotals;
var
  dCredit, dDebit: double;
  bm: TBookmark;
begin
  dCredit := 0;
  dDebit := 0;
  bm := qryMain.GetBookmark;
  qryMain.DisableControls;
  Try
    qryMain.First;
    // Calculate totals.
    while not qryMain.Eof do begin
      if qryMainDEtails.asInteger = 2 then begin
        dCredit := dCredit + qryMain.FieldByName('Credit').AsFloat;
        dDebit  := dDebit + qryMain.FieldByName('Debit').AsFloat;
      end;
      qryMain.Next;
    end;

  finally
    qryMain.GotoBookmark(bm);
    qryMain.FreeBookmark(bm);
    qryMain.EnableControls;
  end;
  grdMain.ColumnByName('Credit').FooterValue := FloatToStrF(dCredit, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Debit').FooterValue := FloatToStrF(dDebit, ffCurrency, 15, CurrencyRoundPlaces);
end;

procedure TWagesJournalReportGUI.chkAllDepartmentsClick(Sender: TObject);
begin
  inherited;
  if chkAllDepartments.Checked then begin
    Label4.Enabled         := false;
    cboDepartments.Enabled := false;
  end else begin
    Label4.Enabled         := true;
    cboDepartments.Enabled := true;
  end;

  RefreshQuery;
  RefreshTotals;
end;

procedure TWagesJournalReportGUI.cboDepartmentsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  RefreshQuery;
  RefreshTotals;
end;

procedure TWagesJournalReportGUI.FormCreate(Sender: TObject);
begin
  inherited;
  if ErrorOccurred then Exit;
  qryClass.Connection := CommonDbLib.GetSharedMyDacConnection;
end;

procedure TWagesJournalReportGUI.FormShow(Sender: TObject);
begin
  inherited;
  if ErrorOccurred then Exit;
  qryClass.Open;
end;

procedure TWagesJournalReportGUI.cmdPrintClick(Sender: TObject);
var
  wYear, wMonth, wDay: word;
  sDateFrom, sDateTo: string;
  sMyDateFrom, sMyDateTo: string;
begin
  if chkAdvancedPrinting.Checked then begin
    ReportSQLSupplied := true;
    DecodeDate(dtFrom.DateTime, wYear, wMonth, wDay);
    sDateFrom   := IntToStr(wDay) + '/' + IntToStr(wMonth) + '/' + IntToStr(wYear);
    sMyDateFrom := IntToStr(wYear) + '-' + IntToStr(wMonth) + '-' + IntToStr(wDay);
    DecodeDate(dtTo.DateTime, wYear, wMonth, wDay);
    sDateTo   := IntToStr(wDay) + '/' + IntToStr(wMonth) + '/' + IntToStr(wYear);
    sMyDateTo := IntToStr(wYear) + '-' + IntToStr(wMonth) + '-' + IntToStr(wDay);

    TemplateSQL := 'SELECT PT.Type AS Type, PT.Date AS "Entry Date", PT.ClassID, C.ClassName AS Department, ';
    TemplateSQL := TemplateSQL + 'IF(PT.AccountType = ''OCLIAB'' OR PT.AccountType = ''BANK'', PT.Amount, 0.00) AS Credit, ';
    TemplateSQL := TemplateSQL + 'IF(PT.AccountType = ''EXP'', PT.Amount * -1, 0.00) AS Debit, ';
    TemplateSQL := TemplateSQL + QuotedStr(sDateFrom) + ' AS DateFrom, ' + QuotedStr(sDateTo) + ' AS DateTo, ';
    TemplateSQL := TemplateSQL + 'PT.AccountName AS Account, PT.Description, P.EmpName AS Employee ';
    TemplateSQL := TemplateSQL + 'FROM tblpaystransactions AS PT ';
    TemplateSQL := TemplateSQL + 'LEFT JOIN tblpays AS P on P.PayID = PT.PayID ';
    TemplateSQL := TemplateSQL + 'LEFT JOIN tblclass AS C on PT.ClassID = C.ClassID ';

    if not chkAllDepartments.Checked then begin
      TemplateSQL := TemplateSQL + 'WHERE C.ClassName = ' + QuotedStr(cboDepartments.Text) + ' AND (PT.Date BETWEEN ' + QuotedStr(sMyDateFrom) + ' AND ' + QuotedStr(sMyDateTo) + ') ';
    end else begin
      TemplateSQL := TemplateSQL + 'WHERE PT.Date BETWEEN ' + QuotedStr(sMyDateFrom) + ' AND ' + QuotedStr(sMyDateTo) + ' ';
    end;

    TemplateSQL := TemplateSQL + 'ORDER BY PT.ClassID, PT.EmployeeID, PT.Date ';
  end;

  inherited;
  ReportSQLSupplied := false;
end;

procedure TWagesJournalReportGUI.actExecuteFilterExecute(Sender: TObject);
begin
  inherited;
  RefreshTotals;
end;

procedure TWagesJournalReportGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if QrymainDetails.asInteger = 1 then begin
      Afont.Style := Afont.Style + [fsBold];
      if (Sysutils.SameText(Field.fieldName ,'Credit')) or (Sysutils.SameText(Field.fieldName ,'Debit')) then
        AFont.color := ABrush.color; 
  end;
end;

procedure TWagesJournalReportGUI.qryMainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryMainDate.displayformat := ShortDateformat;
end;

initialization
  RegisterClassOnce(TWagesJournalReportGUI);
end.
