unit frmPayDeductionsReportList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TfmPayDeductionsReportList = class(TBaseListingGUI)
    chkUseDatePaid: TCheckBox;
    qrySummary: TERPQuery;
    grdSummary: TwwDBGrid;
    dsSummary: TDataSource;
    qryMainGlobalRef: TWideStringField;
    qryMainEmpName: TWideStringField;
    qryMainAmount: TFloatField;
    qryMainClassName: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainPayDate: TDateField;
    qryMainDatePaid: TDateTimeField;
    qryMainTaxExempt: TWideStringField;
    qryMainIsWorkPlacegiving: TWideStringField;
    qryMainEmployeeID: TIntegerField;
    btnPrintDetail: TDNMSpeedButton;
    qrySummaryEmployee: TWideStringField;
    qrySummaryDType: TWideStringField;
    qrySummaryDatePaid: TWideStringField;
    qrySummaryCheckNum: TLargeintField;
    qrySummaryAmount: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure chkUseDatePaidClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);

  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
    Procedure RefreshTotals;Override;
  public
    { Public declarations }
  end;

implementation

uses CommonLib;

{$R *.dfm}


{ TfmPayDeductionsReportList }
procedure TfmPayDeductionsReportList.cmdPrintClick(Sender: TObject);
begin
  dlgPrint.ObjectToPrint := grdSummary;
  dlgPrint.Print;
  dlgPrint.ObjectToPrint := grdMain;
end;

procedure TfmPayDeductionsReportList.FormCreate(Sender: TObject);
begin
  inherited;
  AddCalccolumn(QrymainAmount.fieldname, true);
  DefaultMaxGridColumnWidth := 40;

  grdSummary.TitleColor := Self.Color;
  grdSummary.FooterColor := Self.Color;
end;

procedure TfmPayDeductionsReportList.grpFiltersClick(Sender: TObject);
begin
  case grpFilters.ItemIndex of
    0:
      begin
        grdMain.Visible := True;
        grdSummary.Visible := False;
      end;
    1:
      begin
        grdMain.Visible := False;
        grdSummary.Visible := True;
      end;
  end;

  inherited;
end;

procedure TfmPayDeductionsReportList.RefreshQuery;
begin
  qryMain.Close;
  qryMain.ParambyName('dtFrom').AsDateTime := FilterdateFrom;
  qryMain.ParambyName('dtTo').AsDateTime := FilterDateto;

  if chkUseDatePaid.Checked then qryMain.ParambyName('DatePaidchk').AsString := 'F'
  else qryMain.ParambyName('DatePaidchk').AsString := 'T';

  // Summary
  qrySummary.Close;

  qrySummary.ParambyName('dtFrom').AsDateTime := FilterdateFrom;
  qrySummary.ParambyName('dtTo').AsDateTime := FilterDateto;

  qrySummary.Open;

  inherited;
end;

procedure TfmPayDeductionsReportList.RefreshTotals;
begin
  inherited;
  CalcnShowFooter;
end;

procedure TfmPayDeductionsReportList.chkUseDatePaidClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;


initialization
  RegisterClassOnce(TfmPayDeductionsReportList);
end.
