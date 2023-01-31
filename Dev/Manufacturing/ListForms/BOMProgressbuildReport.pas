unit BOMProgressbuildReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TBOMProgressbuildReportGUI = class(TBaseListingGUI)
    qryMainsaleId: TIntegerField;
    qryMainsaleLineId: TIntegerField;
    qryMainproductname: TWideStringField;
    qryMaincaption: tWideStringfield;
    qryMainsubProductName: TWideStringField;
    qryMainoutcounts: TLargeintField;
    qryMainincounts: TLargeintField;
    QryIns: TERPQuery;
    dsIns: TDataSource;
    qryMainproctreeId: TIntegerField;
    qryMainproctreepartId: TIntegerField;
    QryOut: TERPQuery;
    dsOut: TDataSource;
    DNMPanel1: TDNMPanel;
    pnlin: TwwDBGrid;
    wwIButton1: TwwIButton;
    pnlout: TDNMPanel;
    wwDBGrid2: TwwDBGrid;
    wwIButton2: TwwIButton;
    lblout: TLabel;
    lblins: TLabel;
    report2n3: TSplitter;
    Splitter1: TSplitter;
    DNMSpeedButton1: TDNMSpeedButton;
    qryMainTreepartuomtotalqty: TFloatField;
    QryOutProcProgressID: TIntegerField;
    QryOutProcTreeId: TIntegerField;
    QryOutProcTreePartID: TIntegerField;
    QryOutcaption: tWideStringfield;
    QryOutProgressdate: TDateTimeField;
    QryOutUOMQty: TFloatField;
    QryOutBuildStatus: TWideStringField;
    QryOutAlloctype: TWideStringField;
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure qryMainBeforeOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure qryMainAfterScroll(DataSet: TDataSet);
  private
    fisaleId: Integer;
    procedure onselectsale(Sender: TWwDBGrid);
    procedure SetsaleId(const Value: Integer);
  Protected
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    procedure SetGridColumns; Override;
  public
    Property SaleId :Integer read fisaleId write SetsaleId;
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonDbLib, CommonLib, CommonFormLib;

{$R *.dfm}

procedure TBOMProgressbuildReportGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
      OpenERPListFormSingleselectModal('TBOMOrdersGUI' , onselectsale);
end;
procedure TBOMProgressbuildReportGUI.onselectsale(Sender :TWwDBGrid);
begin
try
  saleId := Sender.DataSource.DataSet.FieldByName('saleID').AsInteger;
except

end;
end;
procedure TBOMProgressbuildReportGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fisaleId:=0;
  HaveDateRangeSelection := False;
end;

procedure TBOMProgressbuildReportGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  opendb(QryOut);
  opendb(QryIns);
end;

procedure TBOMProgressbuildReportGUI.qryMainAfterScroll(DataSet: TDataSet);
begin
  inherited;
  lblins.caption := ' Total records  # ' + inttostr(Qryins.RecordCount);
  lblout.caption := ' Total records  # ' + inttostr(Qryout.RecordCount);
end;

procedure TBOMProgressbuildReportGUI.qryMainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  Closedb(QryIns);
  Closedb(QryOut);
end;

procedure TBOMProgressbuildReportGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
    if GuiPrefs.Node.Exists('Options.SaleId') then saleID:=  GuiPrefs.Node['Options.SaleID'].asInteger;
    if GuiPrefs.Node.Exists('Options.pnlin.left') then pnlin.left:=  GuiPrefs.Node['Options.pnlin.left'].asInteger;
    if GuiPrefs.Node.Exists('Options.pnlout.left') then pnlout.left:=  GuiPrefs.Node['Options.pnlout.left'].asInteger;
end;

procedure TBOMProgressbuildReportGUI.RefreshQuery;
begin
  Qrymain.parambyname('SaleID').asInteger := SAleID;
  inherited;
end;

procedure TBOMProgressbuildReportGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainproctreeId.fieldname);
  RemoveFieldfromGrid(qryMainproctreepartId.fieldname);
end;

procedure TBOMProgressbuildReportGUI.SetsaleId(const Value: Integer);
begin
  fisaleId := Value;
  if isFormshown then RefreshQuery;
end;

procedure TBOMProgressbuildReportGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.SaleID'].asInteger     := saleId;
  GuiPrefs.Node['Options.pnlin.left'].asInteger := pnlin.left;
  GuiPrefs.Node['Options.pnlout.left'].asInteger:= pnlout.left;
end;

initialization
  RegisterClassOnce(TBOMProgressbuildReportGUI);
end.
