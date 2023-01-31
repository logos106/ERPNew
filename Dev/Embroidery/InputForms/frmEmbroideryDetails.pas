unit frmEmbroideryDetails;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 10/11/06  1.00.01 DSP  First version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, DB, DBAccess, MyAccess, ExtCtrls, DNMPanel, DNMSpeedButton,
  Grids, Wwdbigrd, Wwdbgrid, MemDS, StdCtrls, wwdblook, MessageConst, 
  kbmMemTable, Buttons, Mask, wwdbedit, Shader;

type
  TEmbroideryDetailsGUI = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    grdMain: TwwDBGrid;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    qryMain: TMyQuery;
    dsMain: TDataSource;
    qryMainProductName: TStringField;
    qryMainQty: TFloatField;
    qryMainPosition: TStringField;
    qryMainName: TStringField;
    qryMainStitches: TIntegerField;
    qryMainMemo: TMemoField;
    qryProduct: TMyQuery;
    cboProduct: TwwDBLookupCombo;
    qryMainSaleLineID: TIntegerField;
    qryMainProductID: TIntegerField;
    qryProductProductID: TIntegerField;
    qryProductProductName: TStringField;
    Label1: TLabel;
    lblEmbroideryType: TLabel;
    qryMainEmbroideryDetailsID: TIntegerField;
    qryMainGlobalRef: TStringField;
    qryMainActive: TStringField;
    qryMainmsTimeStamp: TDateTimeField;
    qryPrice: TMyQuery;
    qryAxes: TMyQuery;
    btnAddItems: TDNMSpeedButton;
    cboPosition: TwwDBLookupCombo;
    qryPosition: TMyQuery;
    qryPositionDescription: TStringField;
    qryPositionImage: TBlobField;
    qryDetails: TMyQuery;
    qryDetailsSaleLineID: TIntegerField;
    qryDetailsProductID: TIntegerField;
    qryDetailsProductName: TStringField;
    qryDetailsQty: TFloatField;
    qryDetailsPosition: TStringField;
    qryDetailsName: TStringField;
    qryDetailsStitches: TIntegerField;
    qryDetailsMemo: TMemoField;
    qryDetailsImage: TBlobField;
    qryDetailsImageID: TIntegerField;
    qryMainImageID: TIntegerField;
    qryPositionEmbroideryPositionID: TIntegerField;
    memMain: TkbmMemTable;
    qryDetailsEmbroideryDetailsID: TIntegerField;
    grdMainIButton: TwwIButton;
    dbeMemo: TwwDBEdit;
    qryDetailsPrice: TFloatField;
    qryDetailsTotalPrice: TFloatField;
    qryMainPrice: TFloatField;
    qryMainTotalPrice: TFloatField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cboProductCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure btnAddItemsClick(Sender: TObject);
    procedure cboPositionCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure memMainBeforeDelete(DataSet: TDataSet);
    procedure grdMainIButtonClick(Sender: TObject);
  private
    fSaleID: Integer;
    fSourceDataSet: TDataSet;
    fSourceConnection: TCustomMyConnection;
    procedure SetPriceValue(Sender: TField);
    procedure SetNewPriceValue(Sender: TField);
    function IsValueInRange(const Value: Integer; const RangeStr: string): Boolean;
    procedure PopulateMemoryTable;
    procedure SaveMemoryTable;
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
  public
    { Public declarations }
  end;

implementation

uses
  CommonLib, tcTypes, FastFuncs;

{$R *.dfm}

{ TEmbroideryGUI }

procedure TEmbroideryDetailsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fbTabSettingEnabled := False;
  fSourceDataSet := nil;
  fSourceConnection := nil;
end;

procedure TEmbroideryDetailsGUI.PerformStartup(var Msg: TMessage);
var
  qrySave: TMyQuery;
begin
  lblEmbroideryType.Caption := PEmbroideryData(Msg.WParam).Caption;
  fSourceDataSet := PEmbroideryData(Msg.WParam).DataSet;
  fSourceConnection := TCustomMyConnection(TMyQuery(PEmbroideryData(Msg.WParam).DataSet).Connection);
  KeyID := fSourceDataSet.FieldByName('SaleLineID').AsInteger;
  fSaleID := fSourceDataSet.FieldByName('SaleID').AsInteger;
  qryMain.Connection := fSourceConnection;
  qryDetails.Connection := fSourceConnection;
  qryMain.ParamByName('SaleLineID').asInteger := KeyID;
  qryDetails.ParamByName('SaleLineID').asInteger := KeyID;
  qryMain.Open;
  qryDetails.Open;
  qryProduct.Open;
  qryPosition.Open;
  PopulateMemoryTable;
  qrySave := TMyQuery.Create(nil);

  try
    qrySave.Connection := fSourceConnection;
    qrySave.SQL.Text := 'SAVEPOINT ' + Name;
    qrySave.Execute;
  finally
    FreeandNil(qrySave);
  end;

  btnAddItems.Click;
end;

procedure TEmbroideryDetailsGUI.btnSaveClick(Sender: TObject);
var
  TotalPrice: Double;
begin
  inherited;

  if not memMain.IsEmpty then begin
    if memMain.State in [dsEdit, dsInsert] then
      memMain.Post;

    SaveMemoryTable;
  end;

  if Assigned(fSourceDataSet) then begin
    Hide;
    TotalPrice := 0;
    memMain.First;

    while not memMain.Eof do begin
      TotalPrice := TotalPrice + memMain.FieldByName('TotalPrice').AsFloat;
      memMain.Next;
    end;

    fSourceDataSet.Edit;

    if fSourceDataSet.FieldByName('UnitofMeasureQtySold').AsFloat <> 1 then
      fSourceDataSet.FieldByName('UnitofMeasureQtySold').AsFloat := 1;

    fSourceDataSet.FieldByName('LinePrice').AsFloat := TotalPrice;
  end;

  if fsModal in FormState then
    ModalResult := mrOK
  else
    Release;
end;

procedure TEmbroideryDetailsGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TEmbroideryDetailsGUI.FormClose(Sender: TObject; var Action: TCloseAction);
var
  qryRollback: TMyQuery;
begin
  inherited;

  if ModalResult in [mrNone, mrCancel] then begin
    if Assigned(fSourceConnection) then begin
      qryRollback := TMyQuery.Create(nil);

      try
        qryRollback.Connection := fSourceConnection;
        qryRollback.SQL.Text := 'ROLLBACK TO SAVEPOINT ' + Name;
        qryRollback.Execute;
      finally
        FreeandNil(qryRollback);
      end;
    end;

    if fsModal in FormState then
      ModalResult := mrCancel
    else
      Action := caFree;
  end;
end;

procedure TEmbroideryDetailsGUI.SetPriceValue(Sender: TField);
var
  Price: Double;
  Qty: Integer;
  Stitches: Integer;
  ColumnCount: Integer;
begin
  Qty := memMain.FieldByName('Qty').AsInteger;
  Stitches := memMain.FieldByName('Stitches').AsInteger;
  qryPrice.Open;
  qryPrice.First;

  while (not qryPrice.Eof) and (not IsValueInRange(Qty, qryPrice.FieldByName('RowHeader').AsString)) do
    qryPrice.Next;

  if not qryPrice.Eof then begin
    qryAxes.Open;
    qryAxes.First;

    while (not qryAxes.Eof) and (not IsValueInRange(Stitches, qryAxes.FieldByName('AxisValue').AsString)) do
      qryAxes.Next;

    if not qryAxes.Eof then begin
      ColumnCount := qryAxes.RecNo;
      Price := qryPrice.FieldByName('Col' + FastFuncs.IntToStr(ColumnCount)).AsFloat;
      memMain.Edit;
      memMain.FieldByName('Price').AsFloat := Price;
      memMain.FieldByName('TotalPrice').AsFloat := Price * Qty;
    end;
  end;

  qryPrice.Close;
  qryAxes.Close;
  grdMain.RefreshDisplay;
end;

function TEmbroideryDetailsGUI.IsValueInRange(const Value: Integer; const RangeStr: string): Boolean;
var
  Index: Integer;
  ValueStr: string;
  FirstValue: Integer;
  SecondValue: Integer;
  RangeLen: Integer;
  FoundValue: Boolean;
  CorruptValue: Boolean;
begin
  Result := False;
  Index := 1;
  ValueStr := '';
  FoundValue := False;
  RangeLen := FastFuncs.StrLength(RangeStr);

  while (Index <= RangeLen) and (not FoundValue) do begin
    if (RangeStr[Index] >= '0') and (RangeStr[Index] <= '9') then begin
      ValueStr := ValueStr + RangeStr[Index];
      Inc(Index);
    end
    else
      FoundValue := True;
  end;

  if FoundValue then begin
    while (Index <= RangeLen) and ((RangeStr[Index] < '0') or (RangeStr[Index] > '9')) do
      Inc(Index);

    if Index <= RangeLen then begin
      FirstValue := StrToIntDef(ValueStr, 0);
      ValueStr := '';
      CorruptValue := False;

      while (Index <= RangeLen) and (not CorruptValue) do begin
        if (RangeStr[Index] >= '0') and (RangeStr[Index] <= '9') then begin
          ValueStr := ValueStr + RangeStr[Index];
          Inc(Index);
        end
        else
          CorruptValue := True;
      end;

      if not CorruptValue then begin
        SecondValue := StrToIntDef(ValueStr, 0);

        if (Value >= FirstValue) and (Value <= SecondValue) then
          Result := True;
      end;
    end;
  end;
end;

procedure TEmbroideryDetailsGUI.cboProductCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;

  if modified and (not Empty(cboProduct.Text)) then begin
    FillTable.Edit;
    FillTable.FieldByName('ProductID').AsInteger := LookupTable.FieldByName('ProductID').AsInteger;
  end;
end;

procedure TEmbroideryDetailsGUI.btnAddItemsClick(Sender: TObject);
var
  EmbSelForm: TForm;
  EmbData: TEmbroideryData;
begin
  inherited;
  EmbSelForm := TForm(GetComponentByClassName('TEmbroiderySelectionGUI'));

  if Assigned(EmbSelForm) then begin
    EmbData.Caption := '';
    EmbData.Connection := fSourceConnection;
    EmbData.DataSet := memMain;
    SendMessage(EmbSelForm.Handle, TX_PerformStartup, Integer(@EmbData), fSaleID);

    if EmbSelForm.ModalResult = mrNone then begin
      if EmbSelForm.ShowModal = mrOK then
        grdMain.RefreshDisplay;
    end;    
      
    EmbSelForm.Release;
  end;
end;

procedure TEmbroideryDetailsGUI.cboPositionCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;

  if modified and (not Empty(cboPosition.Text)) then begin
    FillTable.Edit;
    FillTable.FieldByName('Name').AsString := LookupTable.FieldByName('Description').AsString;
    FillTable.FieldByName('Image').AsVariant := LookupTable.FieldByName('Image').AsVariant;
    FillTable.FieldByName('ImageID').AsInteger := LookupTable.FieldByName('EmbroideryPositionID').AsInteger;
    FillTable.Post;
    FillTable.Edit;
  end;
end;

procedure TEmbroideryDetailsGUI.PopulateMemoryTable;
begin
  memMain.Close;
  memMain.EmptyTable;
  memMain.LoadFromDataSet(qryDetails, [mtcpoStructure, mtcpoProperties]);
  memMain.FieldByName('Qty').OnChange := SetPriceValue;
  memMain.FieldByName('Stitches').OnChange := SetPriceValue;
  memMain.FieldByName('Price').OnChange := SetNewPriceValue;
  memMain.Open;
end;

procedure TEmbroideryDetailsGUI.SaveMemoryTable;
var
  EmbDetailsID: Integer;
begin
  memMain.DisableControls;
  memMain.First;

  while not memMain.Eof do begin
    EmbDetailsID := memMain.FieldByName('EmbroideryDetailsID').AsInteger;

    if EmbDetailsID = 0 then
      qryMain.Append
    else begin
      qryMain.Locate('EmbroideryDetailsID', EmbDetailsID, [loCaseInsensitive]);
      qryMain.Edit;
    end;

    qryMain.FieldByName('ProductName').AsString := memMain.FieldByName('ProductName').AsString;
    qryMain.FieldByName('Qty').AsInteger := memMain.FieldByName('Qty').AsInteger;
    qryMain.FieldByName('Position').AsString := memMain.FieldByName('Position').AsString;
    qryMain.FieldByName('Name').AsString := memMain.FieldByName('Name').AsString;
    qryMain.FieldByName('Stitches').AsInteger := memMain.FieldByName('Stitches').AsInteger;
    qryMain.FieldByName('Price').AsFloat := memMain.FieldByName('Price').AsFloat;
    qryMain.FieldByName('TotalPrice').AsFloat := memMain.FieldByName('TotalPrice').AsFloat;
    qryMain.FieldByName('Memo').AsString := memMain.FieldByName('Memo').AsString;
    qryMain.FieldByName('ProductID').AsInteger := memMain.FieldByName('ProductID').AsInteger;
    qryMain.FieldByName('ImageID').AsInteger := memMain.FieldByName('ImageID').AsInteger;
    qryMain.FieldByName('SaleLineID').AsInteger := KeyID;
    qryMain.Post;
    memMain.Next;
  end;

  memMain.EnableControls;
end;

procedure TEmbroideryDetailsGUI.memMainBeforeDelete(DataSet: TDataSet);
var
  EmbDetailsID: Integer;
begin
  inherited;
  EmbDetailsID := DataSet.FieldByName('EmbroideryDetailsID').AsInteger;

  if EmbDetailsID > 0 then begin
    if qryMain.Locate('EmbroideryDetailsID', EmbDetailsID, [loCaseInsensitive]) then begin
      qryMain.Edit;
      qryMain.FieldByName('Active').AsString := 'F';
      qryMain.Post;
    end;
  end;
end;

procedure TEmbroideryDetailsGUI.grdMainIButtonClick(Sender: TObject);
begin
  inherited;

  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    memMain.Delete;
end;

procedure TEmbroideryDetailsGUI.SetNewPriceValue(Sender: TField);
begin
  memMain.Edit;
  memMain.FieldByName('TotalPrice').AsFloat := Sender.AsFloat * memMain.FieldByName('Qty').AsInteger;
  grdMain.RefreshDisplay;
end;

initialization
  RegisterClassOnce(TEmbroideryDetailsGUI);
finalization
  UnRegisterClass(TEmbroideryDetailsGUI);
end.
