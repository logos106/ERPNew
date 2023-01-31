unit RAPPendingInvoices;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls, DNMSpeedButton, CustomInputBox, wwdblook,
  Shader;

type
  TRAPPendingInvoiceGUI = class(TBaseListingGUI)
    qryMainSaleId: TIntegerField;
    qryMainShipDate: TDateField;
    qryMainPriorApprovalRefNo: TStringField;
    qryMainDVADeliveryCode: TStringField;
    qryMainVeteranName: TStringField;
    cmdSelect: TDNMSpeedButton;
    qryMainCategory: TStringField;
    DNMSpeedButton1: TDNMSpeedButton;
    procedure cmdCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmdSelectClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
  private
    fsSelectedSaleIDs :String;
  Protected
    Procedure RefreshQuery; Override;
  public
    Property SelectedSaleIDs :String read fsSelectedSaleIDs Write fsSelectedSaleIDs;
  end;

implementation

uses CommonLib;

{$R *.dfm}
Procedure TRAPPendingInvoiceGUI.RefreshQuery;
begin
    if fsSelectedSaleIDs <> '' then begin
        fsSelectedSaleIDs := ReplaceStr(fsSelectedSaleIDs , '(' , 'SaleID <> ');
        fsSelectedSaleIDs := ReplaceStr(fsSelectedSaleIDs , ')' , '');
        fsSelectedSaleIDs := ReplaceStr(fsSelectedSaleIDs , ',' , ' AND SaleId <>');
        GroupFilterString :=fsSelectedSaleIDs;
    end;
        //GroupFilterString := 'not (SaleId  in ' + fsSelectedSaleIDs +')';
    inherited;
end;
procedure TRAPPendingInvoiceGUI.cmdCloseClick(Sender: TObject);
begin
  inherited;
    fsSelectedSaleIDs := '';
    ModalResult := mrCancel;
end;
procedure TRAPPendingInvoiceGUI.FormCreate(Sender: TObject);
begin
  NoDateRange := true;
  IsGridcustomisable      := False;
  CanCreatecustomReport   := False;
  ReportonForeignCurrency := False;
  inherited;
    fsSelectedSaleIDs := '';
    LabelGridFromFieldNames := False;
end;

procedure TRAPPendingInvoiceGUI.cmdSelectClick(Sender: TObject);
var
    i :Integer;
begin
  inherited;
  fsSelectedSaleIDs := '';
  for i := 0 to grdMain.SelectedList.Count - 1 do begin
    qryMain.GotoBookmark(grdMain.SelectedList.Items[i]);
    if fsSelectedSaleIDs <> '' then fsSelectedSaleIDs := fsSelectedSaleIDs + ',';
    fsSelectedSaleIDs := fsSelectedSaleIDs + qryMainSaleId.asString;
  end;
  If (fsSelectedSaleIDs<>'') then
    fsSelectedSaleIDs := '(' + fsSelectedSaleIDs +')';

  ModalResult := mrOk;

end;

procedure TRAPPendingInvoiceGUI.FormShow(Sender: TObject);
begin
  inherited;
    HeaderPanel.Height := headerPanel.Height - Panel2.Height - Panel3.Height;
    pnlHeader.height := 50;
end;

procedure TRAPPendingInvoiceGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  grdMain.SelectAll;
end;

initialization
  RegisterClassOnce(TRAPPendingInvoiceGUI);
end.
