unit frmPayAllowancesReportList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, CustomInputBox, wwcheckbox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TfrmPayAllowancesReport = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainEmpName: TWideStringField;
    qryMainAmount: TFloatField;
    qryMainClassName: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainPayDate: TDateField;
    chkUseDatePaid: TCheckBox;
    qryMainDatePaid: TDateTimeField;
    grdSummary: TwwDBGrid;
    wwIButton1: TwwIButton;
    qrySummary: TERPQuery;
    dsSummary: TDataSource;
    qrySummaryEmpName: TWideStringField;
    qrySummaryExpType: TWideStringField;
    qrySummaryWorkDate: TDateField;
    qrySummaryCheckNum: TLargeintField;
    qrySummaryCost: TWideStringField;
    qrySummaryAmount: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure chkUseDatePaidClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);

  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
  public
    { Public declarations }

  end;

implementation

uses CommonLib;

{ TfmPayAllowancesReport }

procedure TfrmPayAllowancesReport.FormCreate(Sender: TObject);
begin
  inherited;
  DefaultMaxGridColumnWidth := 40;

  grdSummary.TitleColor := Self.Color;
  grdSummary.FooterColor := Self.Color;
end;

procedure TfrmPayAllowancesReport.grpFiltersClick(Sender: TObject);
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

{$R *.dfm}
procedure TfrmPayAllowancesReport.RefreshQuery;
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

procedure TfrmPayAllowancesReport.chkUseDatePaidClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

initialization
  RegisterClassOnce(TfrmPayAllowancesReport);
end.
