unit ProductPurchaselist;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  CustomInputBox;

type
  TProductPurchaseListGUI = class(TBaseListingGUI)
    pnlProductFilter: TDNMPanel;
    lblProductfilter: TLabel;
    chkProdutfilter: TwwCheckBox;
    pnlclientfilter: TDNMPanel;
    lblclientFilter: TLabel;
    chkclientfilter: TwwCheckBox;
    qryMainPurchaseOrderID: TIntegerField;
    qryMainSupplierName: TWideStringField;
    qryMainOrderDate: TDateTimeField;
    qryMainProductID: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainUnitofMeasureQtySold: TFloatField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainUOM: TWideStringField;
    qryMainPurchaseLineID: TIntegerField;
    qryMainContactName: TWideStringField;
    qryMainProductPrintName: TWideStringField;
    procedure chkclientfilterClick(Sender: TObject);
    procedure chkProdutfilterClick(Sender: TObject);
  private
    fiProductID :Integer;
    fiClientID :Integer;
    procedure SetProductID(const Value: Integer);
    procedure SetClientID(const Value: Integer);
  Protected
    procedure SetGridColumns; override;
  public
    Property ProductID :Integer read fiProductID write SetProductID;
    Property ClientID :Integer read fiClientID write SetClientID;
    Procedure RefreshQuery;Override;
  end;

implementation

uses tcDataUtils, AppEnvironment, tcConst, CommonLib;

{$R *.dfm}
{ TProductPurchaseListGUI }

procedure TProductPurchaseListGUI.chkclientfilterClick(Sender: TObject);begin  inherited;  if screen.ActiveControl = Sender then RefreshQuery;end;
procedure TProductPurchaseListGUI.chkProdutfilterClick(Sender: TObject);begin  inherited;  if screen.ActiveControl = Sender then RefreshQuery;end;

procedure TProductPurchaseListGUI.RefreshQuery;
begin
  Qrymain.parambyname('dateFrom').asDatetime  := FilterDatefrom;
  Qrymain.parambyname('dateTo').asDatetime    := FilterDateTo;
  if (pnlclientfilter.visible ) and (chkclientfilter.checked) and (ClientID<>0) then
        Qrymain.parambyname('clientID').asInteger   := clientID
  else  Qrymain.parambyname('clientID').asInteger   := 0;
  if (pnlProductFilter.visible ) and (chkProdutfilter.checked) and (ProductID<>0) then
        Qrymain.parambyname('ProductID').asInteger  := ProductID
  else  Qrymain.parambyname('ProductID').asInteger  := 0;
  inherited;
end;


procedure TProductPurchaseListGUI.SetClientID(const Value: Integer);
begin
  fiClientID := Value;
  pnlClientFilter.visible := Value <>0;
  chkclientfilter.Checked:= Value <>0;
  if Value <> 0 then
    lblClientfilter.caption := 'List of ' + AppEnv.DefaultClass.PartColumn + NL +
                                tcdatautils.getClientName(Value);

end;

procedure TProductPurchaseListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainPurchaseLineID.FieldName);
  RemoveFieldfromGrid(qryMainProductID.FieldName);

end;

procedure TProductPurchaseListGUI.SetProductID(const Value: Integer);
begin
  fiProductID := Value;
  pnlProductFilter.visible := Value <>0;
  chkProdutfilter.Checked:= Value <>0;
  if Value <> 0 then
    lblProductfilter.caption := 'List of ' + AppEnv.DefaultClass.PartColumn + NL +
                                tcdatautils.getproduct(Value);
end;

initialization
  RegisterClassOnce(TProductPurchaseListGUI);

end.

