unit ProductionJobStatusbase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,
  DNMAction, DAScript, MyScript, wwcheckbox, CustomInputBox, wwclearbuttongroup,
  wwradiogroup, GIFImg;

type
  TProductionJobStatusbaseGUI = class(TBaseListingGUI)
    chkIncludesoldfromStock: TCheckBox;
    Label4: TLabel;
    Bevel1: TBevel;
    actfinalise: TDNMAction;
    btnOtherList: TDNMSpeedButton;
    qryMainclientID: TIntegerField;
    qryMainProductId: TIntegerField;
    qryMainSaleId: TIntegerField;
    qryMainSaleDocNumber: TWideStringField;
    qryMainSaleCustomerName: TWideStringField;
    qryMainSaleClassId: TIntegerField;
    qryMainSaleShipDate: TDateField;
    qryMainSaleDate: TDateField;
    qryMainSaleLineId: TIntegerField;
    qryMainLineProductName: TWideStringField;
    qryMainLineProductDescription: TWideStringField;
    qryMainLineQty: TFloatField;
    qryMainLineShipDate: TDateTimeField;
    qryMainProcTreeId: TIntegerField;
    qryMainComplete: TWideStringField;
    qryMainProcessPartStatus: TWideMemoField;
    qryMainDetails: TIntegerField;
    qryMainFromStockUOMQty: TFloatField;
    qryMainManufactureUOMQty: TFloatField;
    qryMainOnOrderUOMQty: TFloatField;
    procedure FormShow(Sender: TObject);
    procedure chkIncludesoldfromStockClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure actfinaliseUpdate(Sender: TObject);
    procedure grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean;
      var Accept: Boolean);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private



  Protected
      tablename:String;
    Procedure SetGridColumns;Override;

  public
    Procedure RefreshQuery; override;
  end;


implementation

uses CommonFormLib,commonLib, FastFuncs, ProcessUtils, CommonDbLib,
  StoredProcedures;



{$R *.dfm}

procedure TProductionJobStatusbaseGUI.RefreshQuery;
begin
(*  closeDB(Qrymain);
  Qrymain.Params.Parambyname('FromDate').asDatetime := FilterDateFrom;
  Qrymain.Params.Parambyname('ToDate').asDatetime   := FilterDateTo;*)
  inherited;
end;
procedure TProductionJobStatusbaseGUI.FormShow(Sender: TObject);
begin
  inherited;
  chkIncludesoldfromStockClick(chkIncludesoldfromStock);
end;

procedure TProductionJobStatusbaseGUI.chkIncludesoldfromStockClick(Sender: TObject);
begin
  inherited;
  grpFiltersClick(grpFilters);
end;

procedure TProductionJobStatusbaseGUI.grpFiltersClick(Sender: TObject);
  Procedure Addfilter(const value:String);
  begin
    if value = '' then exit;
    if GroupFilterString <> '' then GroupFilterString := GroupFilterString + ' and ';
    GroupFilterString := GroupFilterString + value;
  end;
begin
  inherited;
  GroupFilterString := '';
  if grpFilters.visible then begin
       if chkincludeSoldFromStock.checked = False then Addfilter('ManufactureUOMQty <> 0');
       if grpFilters.Itemindex = 0                then Addfilter ('ProcessPartStatus <>'+QuotedStr(PS_STR_COMPLETE))
  else if grpFilters.ItemIndex = 1                then Addfilter ('ProcessPartStatus ='+QuotedStr(PS_STR_COMPLETE));
  inherited grpFiltersClick(Sender);
  end;
end;

procedure TProductionJobStatusbaseGUI.actfinaliseUpdate(Sender: TObject);
begin
  inherited;
  actfinalise.enabled := grdmain.Selected.Count > 0;
end;

procedure TProductionJobStatusbaseGUI.grdMainMultiSelectRecord(Grid: TwwDBGrid;
  Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
(*  accept := not(Sysutils.SameText(qryMainStatus.asString , 'From Stock'));*)
  (*if not accept then
    MessageDlgXP_Vista(qryMainLineProductName.asString + ' For ' +
                        qryMainSaleCustomerName.asString +' in Sale#' +
                        qryMainSaleDocNumber.asString + ' is Taken From Stock.'+
                        '  Its Not Possible to Finalise' , mtInformation , [mbok] , 0);*)
end;

procedure TProductionJobStatusbaseGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('Details');
  RemoveFieldfromGrid('ProcTreeId');
  RemoveFieldfromGrid('SaleClassId');
  RemoveFieldfromGrid('SaleID');
  RemoveFieldfromGrid('SaleLineId');
  //RemoveFieldfromGrid('Status');
end;



procedure TProductionJobStatusbaseGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
(*   if Sysutils.SameText(qryMainStatus.asString , '') then
    AFont.Color := clInactiveCaption; *)
end;

procedure TProductionJobStatusbaseGUI.FormCreate(Sender: TObject);
begin
  CreateSP('ProcessStatus');
  tablename := GetUserTemporaryTableName('tmp_'+Self.Classname);
  Qrymain.SQL.clear;
  Qrymain.SQL.Add('Select *');
  Qrymain.SQL.Add('From '+Tablename+' order by saleId desc');
  inherited;
end;

procedure TProductionJobStatusbaseGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(tablename);
  inherited;

end;

end.




