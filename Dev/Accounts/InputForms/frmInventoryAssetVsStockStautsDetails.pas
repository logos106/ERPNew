unit frmInventoryAssetVsStockStautsDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, SelectionDialog, Menus, ExtCtrls, StdCtrls,
  DNMSpeedButton, Shader, DNMPanel, ComCtrls ,InventoryAssetVsStockStautsDetailsBase ,BaseListingForm;

type
  TfmInventoryAssetVsStockStautsDetails = class(TBaseForm)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cmdClose: TDNMSpeedButton;
    pgeControl: TPageControl;
    tabSummary: TTabSheet;
    tabPQa: TTabSheet;
    tabBal: TTabSheet;
    btnExpressDetail: TDNMSpeedButton;
    procedure FormResize(Sender: TObject);
    procedure tabBalResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExpressDetailClick(Sender: TObject);
  private
    fsTableName: String;
    fiTransID: Integer;
    fsTranstype: String;
    fListSummary, fListPQA, fListBal : TBaseListingGUI;
    procedure initList(Sender: TObject);
    function ListSummary: TInventoryAssetVsStockStautsDetailsBaseGUI;
    function ListPQA: TInventoryAssetVsStockStautsDetailsBaseGUI;
    function ListBal: TInventoryAssetVsStockStautsDetailsBaseGUI;
    Procedure ShowList;
  public
    Property TableName :String read fsTableName write fsTableName;
    Property Transtype :String read fsTranstype write fsTranstype;
    Property TransID   :Integer read fiTransID write fiTransID;
  end;


implementation

uses CommonLib, CommonFormLib, InventoryAssetVsStockStautsDetails, DNMLib;

{$R *.dfm}

procedure TfmInventoryAssetVsStockStautsDetails.FormResize(Sender: TObject);
begin
  inherited;
  RealignTabControl(pgeControl, 1);
end;

procedure TfmInventoryAssetVsStockStautsDetails.FormShow(Sender: TObject);
begin
  inherited;
  RealignTabControl(pgeControl, 1);
  ShowList;
end;

procedure TfmInventoryAssetVsStockStautsDetails.tabBalResize(Sender: TObject);
begin
  inherited;
  RealignTabControl(pgeControl, 1);
end;
Procedure TfmInventoryAssetVsStockStautsDetails.initList(Sender:TObject);
begin
   if (Sender is TInventoryAssetVsStockStautsDetailsBaseGUI) then begin
     TInventoryAssetVsStockStautsDetailsBaseGUI(Sender).TableName := TableName;
     TInventoryAssetVsStockStautsDetailsBaseGUI(Sender).Transtype := Transtype;
     TInventoryAssetVsStockStautsDetailsBaseGUI(Sender).TransID   := TransID;
   end else if sender is TInventoryAssetVsStockStautsDetailsGUI then begin
     TInventoryAssetVsStockStautsDetailsGUI(Sender).TableName := TableName;
     TInventoryAssetVsStockStautsDetailsGUI(Sender).Transtype := Transtype;
     TInventoryAssetVsStockStautsDetailsGUI(Sender).TransID   := TransID;
   end;
end;
function TfmInventoryAssetVsStockStautsDetails.ListSummary : TInventoryAssetVsStockStautsDetailsBaseGUI;
begin
  CreateHistorylistform('TInventoryAssetVsStockStautsDetailsSummaryGUI' ,Self, fListSummary,'','',initList );
  result := TInventoryAssetVsStockStautsDetailsBaseGUI(fListSummary);
end;
function TfmInventoryAssetVsStockStautsDetails.ListPQA: TInventoryAssetVsStockStautsDetailsBaseGUI;
begin
  CreateHistorylistform('TInventoryAssetVsStockStautsDetailsPQAGUI' ,Self, fListPQA,'','',initList );
  result := TInventoryAssetVsStockStautsDetailsBaseGUI(fListPQA);
end;

function TfmInventoryAssetVsStockStautsDetails.ListBal: TInventoryAssetVsStockStautsDetailsBaseGUI;
begin
  CreateHistorylistform('TInventoryAssetVsStockStautsDetailsBalGUI' ,Self, fListBal,'','',initList );
  result := TInventoryAssetVsStockStautsDetailsBaseGUI(fListBal);
end;
procedure TfmInventoryAssetVsStockStautsDetails.ShowList;
begin
   with ListSummary do begin
          Parent := tabSummary;
          align := alclient;
          BorderStyle := bsNone;
          fbIgnoreQuerySpeed := true;
          try Show; except FreeAndNil(fListSummary); end;
   end;

   with ListBal do begin
          Parent := tabBal;
          align := alclient;
          BorderStyle := bsNone;
          fbIgnoreQuerySpeed := true;
          try Show; except FreeAndNil(fListBal); end;
   end;

   with ListPQA do begin
          Parent := tabPQa;
          align := alclient;
          BorderStyle := bsNone;
          fbIgnoreQuerySpeed := true;
          try Show; except FreeAndNil(fListPQA); end;
   end;
end;
procedure TfmInventoryAssetVsStockStautsDetails.btnExpressDetailClick(Sender: TObject);
begin
  inherited;
  OpenERpListForm('TInventoryAssetVsStockStautsDetailsGUI', initList);
  Self.close;
end;


initialization
  RegisterClassOnce(TfmInventoryAssetVsStockStautsDetails);

end.

