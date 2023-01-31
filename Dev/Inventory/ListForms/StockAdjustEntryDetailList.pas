unit StockAdjustEntryDetailList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, ComCtrls, wwriched, DAScript, MyScript, wwcheckbox,
  CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TStockAdjustEntryDetailListGUI = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainStockAdjustEntryID: TIntegerField;
    qryMainAccountID: TIntegerField;
    qryMainAccountName: TWideStringField;
    qryMainProductID: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainClassID: TIntegerField;
    qryMainClassName: TWideStringField;
    qryMainAvailableQty: TFloatField;
    qryMainFinalQty: TFloatField;
    qryMainAdjustQty: TFloatField;
    qryMainAvailableUOMQty: TFloatField;
    qryMainFinalUOMQty: TFloatField;
    qryMainAdjustUOMQty: TFloatField;
    qryMainCost: TFloatField;
    qryMainUOM: TWideStringField;
    qryMainUOMMultiplier: TFloatField;
    qryMainDeleted: TWideStringField;
    qryMainUOMID: TIntegerField;
    qryMainTotalCost: TFloatField;
    qryMainUOMCost: TFloatField;
    qryMainProcessed: TWideStringField;
    qryMainAdjusttype: TWideStringField;
    qryMainPreferedSupplier: TWideStringField;
    btnSummary: TDNMSpeedButton;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure cmdNewClick(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure btnSummaryClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
  private
  Protected
      procedure SetGridColumns; Override;
    procedure CopyParamsto(Sender: TObject);Override;
    procedure ReadnApplyGuiPrefExtra; Override;
  public
    Procedure RefreshQuery; override;
  end;


implementation

uses CommonLib, StockAdjustEntryList,
  AppEnvironment, tcConst, frmStockAdjustEntryTree, CommonFormLib,
  StockAdjustEntryDetailVariaceList;

{$R *.dfm}
procedure TStockAdjustEntryDetailListGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMainAdjusttype.AsString;
  inherited;
end;

procedure TStockAdjustEntryDetailListGUI.grpFiltersClick(Sender: TObject);
begin
  if sender = grpFilters then begin
      if not isformshown then exit;
      if self.classnameis('TStockAdjustEntryDetailListGUI') then begin
        case grpFilters.ItemIndex of
          0:GroupFilterString := 'Processed <> ' + quotedStr('T') + ' and Deleted <> ' + quotedStr('T');
          1:GroupFilterString := 'Processed =  ' + quotedStr('T') + ' and Deleted <> ' + quotedStr('T');
          2:GroupFilterString := 'Deleted   =  ' + quotedStr('T');
          3: GroupFilterString := '';
          else begin
            OpenERpListForm('TStockAdjustEntryDetailVariaceListGUI', CopyParamsto);
            Self.close;
            Exit;
          end;
        end;
      end else if self.classnameis('TStockAdjustEntryDetailVariaceListGUI') then begin
        if grpFilters.ItemIndex  <> 4 then begin
          OpenERpListForm('TStockAdjustEntryDetailListGUI', CopyParamsto);
          Self.close;
          Exit;
        end;
      end;
  end;
  inherited;
end;

procedure TStockAdjustEntryDetailListGUI.CopyParamsto(Sender: TObject);
begin
  inherited;
       if sender is TStockAdjustEntryDetailVariaceListGUI then TStockAdjustEntryDetailVariaceListGUI(sender).grpfilters.itemindex := 4
  else if sender is TStockAdjustEntryDetailListGUI        then TStockAdjustEntryDetailListGUI(sender).grpfilters.itemindex := grpfilters.itemindex;
  TStockAdjustEntryDetailListGUI(sender).GrpfilterSupplied := True;
end;

procedure TStockAdjustEntryDetailListGUI.cmdNewClick(Sender: TObject);
begin
  OpenERPForm('TfmStockAdjustEntryTree' , 0);
end;
procedure TStockAdjustEntryDetailListGUI.qryMainCalcFields(
  DataSet: TDataSet);
begin
  inherited;
  qryMainTotalCost.asFloat  := round(qryMainCost.asFloat * qryMainAdjustQty.asFloat , CurrencyRoundPlaces);
  qryMainUOMCost.asFloat    := round(qryMainCost.asFloat * qryMainUOMMultiplier.asFloat , CurrencyRoundPlaces);
end;

procedure TStockAdjustEntryDetailListGUI.btnSummaryClick(Sender: TObject);
begin
  OpenERpListForm('TStockAdjustEntryListGUI', copyParamsto);
  CloseWait;
end;

procedure TStockAdjustEntryDetailListGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
       if Self.classnameis('TStockAdjustEntryDetailListGUI') and (grpfilters.itemindex >3) then grpfilters.itemindex := 3
  else if Self.classnameis('TStockAdjustEntryDetailVariaceListGUI') and (grpfilters.itemindex <4) then grpfilters.itemindex := 4;
end;

procedure TStockAdjustEntryDetailListGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  inherited;
end;

procedure TStockAdjustEntryDetailListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainAdjusttype.FieldName);
  //RemoveFieldfromGrid(qryMainStockAdjustentryID.FieldName);
  RemoveFieldfromGrid(qryMainAccountId.FieldName);
  RemoveFieldfromGrid(qryMainProductId.FieldName);
  RemoveFieldfromGrid(qryMainClassId.FieldName);
  RemoveFieldfromGrid(qryMainAvailableQty.FieldName);
  RemoveFieldfromGrid(qryMainfinalQty.FieldName);
  RemoveFieldfromGrid(qryMainAdjustQty.FieldName);
  RemoveFieldfromGrid(qryMainUOMMultiplier.FieldName);
  RemoveFieldfromGrid(qryMainDeleted.FieldName);
  RemoveFieldfromGrid(qryMainUOMID.FieldName);

  if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnAllowtoSeecostInStockforms')<> 1 then begin
      RemoveFieldfromGrid(qryMainCost.FieldName);
      RemoveFieldfromGrid(qryMainTotalCost.FieldName);
      RemoveFieldfromGrid(qryMainUOMCost.FieldName);
  end;
end;

initialization
  RegisterClassOnce(TStockAdjustEntryDetailListGUI);
end.


