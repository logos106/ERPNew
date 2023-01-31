
unit frmEdiOrderList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel, ComCtrls, AdvProgr;

type
  TfmEdiOrderList = class(TBaseListingGUI)
    qryMainDocumentDate: TDateTimeField;
    qryMainDocumentUpdatedDate: TDateTimeField;
    qryMainDocumentRef: TWideStringField;
    qryMainEDIParty: TWideStringField;
    qryMainStatus: TWideStringField;
    qryMainSalesOrderID: TIntegerField;
    qryMainReceiveDate: TDateTimeField;
    pnlExtraButtons: TDNMPanel;
    btnrecreateTable: TDNMSpeedButton;
    btnSynchOrders: TDNMSpeedButton;
    btnAcknowledgeOrders: TDNMSpeedButton;
    btnCancelOrders: TDNMSpeedButton;
    btnShipOrders: TDNMSpeedButton;
    btnMakeERPOrders: TDNMSpeedButton;
    btnrefund: TDNMSpeedButton;
    pnlRequerytmr: TPanel;
    Shape1: TShape;
    lblhint: TLabel;
    lblcheckPref: TLabel;
    pbRequery: TAdvProgress;
    qryMainInvoiceID: TIntegerField;
    qryMainSOGlobalRef: TWideStringField;
    qryMainInvoiceGlobalRef: TWideStringField;
    RequeryTimer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fEDIParty: string;
  protected
    procedure RefreshQuery; override;
  public
    property EDIParty: string read fEDIParty write fEDIParty;
  end;

var
  fmEdiOrderList: TfmEdiOrderList;

implementation

{$R *.dfm}

{ TfmEdiOrderList }

procedure TfmEdiOrderList.FormCreate(Sender: TObject);
begin
  inherited;
  fEDIParty := '';
end;

procedure TfmEdiOrderList.FormShow(Sender: TObject);
begin
  inherited;
//  pnlRequerytmr.Left := edtSearch.Left + edtSearch.Width + 10;
//  pnlRequerytmr.Width := self.ClientWidth - pnlRequerytmr.Left - 20;
  pnlRequerytmr.Width := 400;
  pbRequery.align := altop;
  lblhint.Width := pnlRequeryTmr.Width - lblCheckPref.Width - 5;

end;

procedure TfmEdiOrderList.RefreshQuery;
begin
  qryMain.Close;
  if chkIgnoreDates.Checked then begin
    qryMain.ParamByName('dtFrom').AsDate := 0;
    qryMain.ParamByName('dtTo').AsDate := MaxDateTime;
  end
  else begin
    qryMain.ParamByName('dtFrom').AsDate := dtFrom.Date;
    qryMain.ParamByName('dtTo').AsDate := dtTo.Date;
  end;
  qryMain.ParamByName('EDIParty').AsString := EDIParty;
  inherited;

end;

initialization
  RegisterClass(TfmEdiOrderList);

end.
