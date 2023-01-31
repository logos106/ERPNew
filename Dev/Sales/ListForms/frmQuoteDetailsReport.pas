unit frmQuoteDetailsReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton,  wwdblook,
  Shader, kbmMemTable, DAScript, MyScript;

type
  TQuoteDetailsReport = class(TBaseListingGUI)
    qryMainInvoiceDocNumber: TWideStringField;
    qryMainCustomerName: TWideStringField;
    qryMainEmployeeName: TWideStringField;
    qryMainConverted: TWideStringField;
    qryMainLinePrice: TFloatField;
    qryMainCustomField1: TWideStringField;
    qryMainCustomField2: TWideStringField;
    qryMainCustomField3: TWideStringField;
    qryMainCustomField4: TWideStringField;
    qryMainCustomField5: TWideStringField;
    qryMainCustomField6: TWideStringField;
    qryMainCustomField7: TWideStringField;
    qryMainCustomField8: TWideStringField;
    qryMainCustomField9: TWideStringField;
    qryMainCustomField10: TWideStringField;
    qryMainPartName: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainFirstColumn: TWideStringField;
    qryMainSecondColumn: TWideStringField;
    qryMainThirdColumn: TWideStringField;
    qryMainSaleID: TIntegerField;
    qryMainProduct_Description_Memo: TWideMemoField;
    qryMainQuantity: TFloatField;
    qryMainCOGSACCNT: TWideStringField;
    qryMainQuoteStatus: TWideStringField;
    qryMainLinecost: TFloatField;
    qryMainLinecostInc: TFloatField;
    qryMainLinePriceinc: TFloatField;
    qryMainTotalLineAmount: TFloatField;
    qryMainTotalLineAmountInc: TFloatField;
    qryMainSaleDate: TDateField;
    procedure FormCreate(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    procedure RefreshQuery; override;
    { Public declarations }
  end;

implementation

uses CommonLib, frmQuote, Forms, AppEnvironment, FastFuncs;

{$R *.dfm}

{ TQuoteDetailsReport }

procedure TQuoteDetailsReport.RefreshQuery;
begin
  qryMain.Params.ParamByName('txtfrom').AsDate := dtFrom.DateTime;
  qryMain.Params.ParamByName('txtto').AsDate := dtTo.DateTime;
  inherited;
end;

procedure TQuoteDetailsReport.FormCreate(Sender: TObject);
begin
  inherited;
  fbEnableWebSearch := true;
end;

procedure TQuoteDetailsReport.cmdNewClick(Sender: TObject);
var
  tmpComponent: TComponent;
begin
  tmpComponent := GetComponentByClassName('TQuoteGUI');
  if not Assigned(tmpComponent) then Exit;
  with TQuoteGUI(tmpComponent) do begin
    AttachObserver(Self);
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

procedure TQuoteDetailsReport.FormShow(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

initialization
  RegisterClassOnce(TQuoteDetailsReport);

end.
