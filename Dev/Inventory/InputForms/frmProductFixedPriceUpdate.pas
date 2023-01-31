unit frmProductFixedPriceUpdate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ExtCtrls,
  DNMPanel, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, DB,  MemDS,
  StdCtrls, DataState, Menus, AdvMenus, Shader, ImgList, ProgressDialog;

type
  TfrmProductFixedPrice = class(TBaseInputGUI)
    DNMPanel2: TDNMPanel;
    grdEditor: TwwDBGrid;
    btnDeleteSellPrice: TwwIButton;
    DNMPanel3: TDNMPanel;
    dsEditor: TDataSource;
    qryEditor: TERPQuery;
    qryEditorID: TIntegerField;
    qryEditorClientTypeID: TIntegerField;
    qryEditorClientType: TWideStringField;
    qryEditorUOMID: TIntegerField;
    qryEditorUOMName: TWideStringField;
    qryEditorQtyPercent1: TFloatField;
    qryEditorPrice1Ex: TFloatField;
    qryEditorQtyPercent2: TFloatField;
    qryEditorPrice2Ex: TFloatField;
    qryEditorQtyPercent3: TFloatField;
    qryEditorPrice3Ex: TFloatField;
    qryEditorPrice1Inc: TFloatField;
    qryEditorPrice2Inc: TFloatField;
    qryEditorPrice3Inc: TFloatField;
    btnUpdate: TDNMSpeedButton;
    tbnClose: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdEditorCalcTitleAttributes(Sender: TObject; AFieldName: string; AFont: TFont;
      ABrush: TBrush; var ATitleAlignment: TAlignment);
    procedure grdEditorTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure qryEditorPrice1ExChange(Sender: TField);
    procedure qryEditorPrice2ExChange(Sender: TField);
    procedure qryEditorPrice3ExChange(Sender: TField);
    procedure qryEditorPrice1IncChange(Sender: TField);
    procedure qryEditorPrice2IncChange(Sender: TField);
    procedure qryEditorPrice3IncChange(Sender: TField);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnDeleteSellPriceClick(Sender: TObject);
    procedure qryEditorAfterOpen(DataSet: TDataSet);
    procedure qryEditorBeforeInsert(DataSet: TDataSet);

  private
    { Private declarations }
    fsTempTableName: string;
    fsClientType: string;
    fsUOM: string;
    fbUpdating: boolean;
    fbMainPriceMode: boolean;
    
  public
    { Public declarations }
    
    property TempTableName: string read fsTempTableName write fsTempTableName;
    property ClientType: string read fsClientType write fsClientType;
    property UOM: string read fsUOM write fsUOM;
    property MainSellPriceMode: boolean read fbMainPriceMode write fbMainPriceMode stored false;
  end;

implementation

{$R *.dfm}

uses
  DNMExceptions, DNMLib, CommonLib;
procedure TfrmProductFixedPrice.FormCreate(Sender: TObject);
begin
  inherited;
  // Ensure there was inheritance error.
  if ErrorOccurred then Exit;
  fbUpdating := false;
end;

procedure TfrmProductFixedPrice.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;

      // Determine our main queries SQL.
      qryEditor.SQL.Clear;
      if MainSellPriceMode then begin
        qryEditor.SQL.Add('SELECT * FROM `' + TempTableName + '` LIMIT 1;');
      end else begin
        qryEditor.SQL.Add('SELECT * FROM `' + TempTableName + '`;');
      end;

      OpenQueries;

      if qryEditor.RecordCount < 1 then begin
        CommonLib.MessageDlgXP_Vista('Client Type and Unit of Measure combination results no records!'#13#10#13#10'Cannot allocate fixed prices!',
          mtWarning, [mbOK], 0);
        PostMessage(Self.Handle, WM_CLOSE, 0, 0);
        Exit;
      end;

      if MainSellPriceMode then begin
        grdEditor.RemoveField('ClientType');
        grdEditor.RemoveField('UOMName');
        grdEditor.ColumnByName('Price1Inc').DisplayWidth := 20;
        grdEditor.ColumnByName('Price2Inc').DisplayWidth := 20;
        grdEditor.ColumnByName('Price3Inc').DisplayWidth := 20;
        TitleLabel.Caption := 'Main Product Fixed Sell Price Update';
        Self.Caption := 'Main Product Fixed Sell Price Update';
      end;

      // Exception Handler.
    except
      on EAbort do HandleEAbortException;

      // Access Denied
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmProductFixedPrice.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Free up the form from memory.
  Action := caFree;
  inherited;
end;

procedure TfrmProductFixedPrice.grdEditorCalcTitleAttributes(Sender: TObject; AFieldName: string;
  AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
begin
  inherited;
  if (AFieldName = 'Price1Inc') or (AFieldName = 'Price2Inc') or (AFieldName = 'Price3Inc') or
    (AFieldName = 'Price1Ex') or (AFieldName = 'Price2Ex') or (AFieldName = 'Price3Ex') then begin
    ABrush.Color := clBtnFace;
  end;
end;

procedure TfrmProductFixedPrice.grdEditorTitleButtonClick(Sender: TObject; AFieldName: string);
var
  iPos: integer;
begin
  inherited;
  if (AFieldName = 'Price1Ex') or (AFieldName = 'Price2Ex') or (AFieldName = 'Price3Ex') then begin
    iPos := GetGridColumnIndex(grdEditor, 'Price3Ex');
    grdEditor.RemoveField('Price3Ex');
    grdEditor.AddField('Price3Inc', iPos, true);
    grdEditor.ColumnByName('Price3Inc').DisplayLabel := 'Price3 (Inc)';
    if not MainSellPriceMode then begin
      grdEditor.ColumnByName('Price3Inc').DisplayWidth := 12;
    end else begin
      grdEditor.ColumnByName('Price3Inc').DisplayWidth := 20;
    end;

    iPos := GetGridColumnIndex(grdEditor, 'Price2Ex');
    grdEditor.RemoveField('Price2Ex');
    grdEditor.AddField('Price2Inc', iPos, true);
    grdEditor.ColumnByName('Price2Inc').DisplayLabel := 'Price2 (Inc)';
    if not MainSellPriceMode then begin
      grdEditor.ColumnByName('Price2Inc').DisplayWidth := 12;
    end else begin
      grdEditor.ColumnByName('Price2Inc').DisplayWidth := 20;
    end;

    iPos := GetGridColumnIndex(grdEditor, 'Price1Ex');
    grdEditor.RemoveField('Price1Ex');
    grdEditor.AddField('Price1Inc', iPos, true);
    grdEditor.ColumnByName('Price1Inc').DisplayLabel := 'Price1 (Inc)';
    if not MainSellPriceMode then begin
      grdEditor.ColumnByName('Price1Inc').DisplayWidth := 12;
    end else begin
      grdEditor.ColumnByName('Price1Inc').DisplayWidth := 20;
    end;
  end else if (AFieldName = 'Price1Inc') or (AFieldName = 'Price2Inc') or (AFieldName = 'Price3Inc') then begin
    iPos := GetGridColumnIndex(grdEditor, 'Price3Inc');
    grdEditor.RemoveField('Price3Inc');
    grdEditor.AddField('Price3Ex', iPos, true);
    grdEditor.ColumnByName('Price3Ex').DisplayLabel := 'Price3 (Ex)';
    if not MainSellPriceMode then begin
      grdEditor.ColumnByName('Price3Ex').DisplayWidth := 12;
    end else begin
      grdEditor.ColumnByName('Price3Ex').DisplayWidth := 20;
    end;

    iPos := GetGridColumnIndex(grdEditor, 'Price2Inc');
    grdEditor.RemoveField('Price2Inc');
    grdEditor.AddField('Price2Ex', iPos, true);
    grdEditor.ColumnByName('Price2Ex').DisplayLabel := 'Price2 (Ex)';
    if not MainSellPriceMode then begin
      grdEditor.ColumnByName('Price2Ex').DisplayWidth := 12;
    end else begin
      grdEditor.ColumnByName('Price2Ex').DisplayWidth := 20;
    end;

    iPos := GetGridColumnIndex(grdEditor, 'Price1Inc');
    grdEditor.RemoveField('Price1Inc');
    grdEditor.AddField('Price1Ex', iPos, true);
    grdEditor.ColumnByName('Price1Ex').DisplayLabel := 'Price1 (Ex)';
    if not MainSellPriceMode then begin
      grdEditor.ColumnByName('Price1Ex').DisplayWidth := 12;
    end else begin
      grdEditor.ColumnByName('Price1Ex').DisplayWidth := 20;
    end;
  end;
end;


procedure TfrmProductFixedPrice.qryEditorPrice1ExChange(Sender: TField);
var
  dValue: double;
begin
  inherited;
  if fbUpdating then Exit;
  // We now need to calculate a Inc Price.
  fbUpdating := true;
  dValue := GetAmountInc(Sender.AsFloat, GetTaxRate('GST'));
  qryEditor.Edit;
  qryEditor.FieldByName('Price1Inc').AsFloat := dValue;
  if qryEditor.FieldByName('Price2Ex').AsFloat = 0 then begin
    qryEditor.FieldByName('Price2Ex').AsFloat  := Sender.AsFloat;
    qryEditor.FieldByName('Price2Inc').AsFloat := dValue;
    qryEditor.Post;
    qryEditor.Edit;
  end else begin
    if qryEditor.FieldByName('Price2Ex').AsFloat > Sender.AsFloat then begin
      qryEditor.FieldByName('Price2Ex').AsFloat := Sender.AsFloat;
      qryEditor.FieldByName('Price2Inc').AsFloat := dValue;
      if qryEditor.FieldByName('Price3Ex').AsFloat > Sender.AsFloat then begin
        qryEditor.FieldByName('Price3Ex').AsFloat := Sender.AsFloat;
        qryEditor.FieldByName('Price3Inc').AsFloat := dValue;
      end;
    end;
  end;

  if qryEditor.FieldByName('Price3Ex').AsFloat = 0 then begin
    qryEditor.FieldByName('Price3Ex').AsFloat  := Sender.AsFloat;
    qryEditor.FieldByName('Price3Inc').AsFloat := dValue;
    qryEditor.Post;
    qryEditor.Edit;
  end;

  fbUpdating := false;
end;

procedure TfrmProductFixedPrice.qryEditorPrice2ExChange(Sender: TField);
var
  dValue: double;
begin
  inherited;
  if fbUpdating then Exit;
  // We now need to calculate a Inc Price.
  fbUpdating := true;
  dValue := GetAmountInc(Sender.AsFloat, GetTaxRate('GST'));
  qryEditor.Edit;
  qryEditor.FieldByName('Price2Inc').AsFloat := dValue;
  if qryEditor.FieldByName('Price1Ex').AsFloat = 0 then begin
    qryEditor.FieldByName('Price1Ex').AsFloat  := Sender.AsFloat;
    qryEditor.FieldByName('Price1Inc').AsFloat := dValue;
    qryEditor.Post;
    qryEditor.Edit;
  end else begin
    if Sender.AsFloat > qryEditor.FieldByName('Price1Ex').AsFloat then begin
      CommonLib.MessageDlgXP_Vista('Price 2 (Ex) Must be less than Price 1 (Ex)', mtWarning, [mbOK], 0);
      fbUpdating := false;
      Abort;
    end;
  end;

  if qryEditor.FieldByName('Price3Ex').AsFloat = 0 then begin
    qryEditor.FieldByName('Price3Ex').AsFloat  := Sender.AsFloat;
    qryEditor.FieldByName('Price3Inc').AsFloat := dValue;
    qryEditor.Post;
    qryEditor.Edit;
  end;

  fbUpdating := false;
end;

procedure TfrmProductFixedPrice.qryEditorPrice3ExChange(Sender: TField);
var
  dValue: double;
begin
  inherited;
  if fbUpdating then Exit;

  // We now need to calculate a Inc Price.
  fbUpdating := true;
  dValue := GetAmountInc(Sender.AsFloat, GetTaxRate('GST'));
  qryEditor.Edit;
  qryEditor.FieldByName('Price3Inc').AsFloat := dValue;
  if qryEditor.FieldByName('Price1Ex').AsFloat = 0 then begin
    qryEditor.FieldByName('Price1Ex').AsFloat  := Sender.AsFloat;
    qryEditor.FieldByName('Price1Inc').AsFloat := dValue;
    qryEditor.Post;
    qryEditor.Edit;
  end;

  if qryEditor.FieldByName('Price2Ex').AsFloat = 0 then begin
    qryEditor.FieldByName('Price2Ex').AsFloat  := Sender.AsFloat;
    qryEditor.FieldByName('Price2Inc').AsFloat := dValue;
    qryEditor.Post;
    qryEditor.Edit;
  end else begin
    if Sender.AsFloat > qryEditor.FieldByName('Price2Ex').AsFloat then begin
      CommonLib.MessageDlgXP_Vista('Price 3 (Ex) Must be less than Price 2 (Ex)', mtWarning, [mbOK], 0);
      fbUpdating := false;
      Abort;
    end;
  end;

  fbUpdating := false;
end;

procedure TfrmProductFixedPrice.qryEditorPrice1IncChange(Sender: TField);
var
  dValue: double;
begin
  inherited;
  if fbUpdating then Exit;
  fbUpdating := true;
  dValue := GetAmountEx(Sender.AsFloat, GetTaxRate('GST'));
  qryEditor.Edit;
  qryEditor.FieldByName('Price1Ex').AsFloat := dValue;
  if qryEditor.FieldByName('Price2Ex').AsFloat = 0 then begin
    qryEditor.FieldByName('Price2Inc').AsFloat := Sender.AsFloat;
    qryEditor.FieldByName('Price2Ex').AsFloat  := dValue;
    qryEditor.Post;
    qryEditor.Edit;
  end else begin
    if qryEditor.FieldByName('Price2Inc').AsFloat > Sender.AsFloat then begin
      qryEditor.FieldByName('Price2Inc').AsFloat := Sender.AsFloat;
      qryEditor.FieldByName('Price2Ex').AsFloat := dValue;
      if qryEditor.FieldByName('Price3Inc').AsFloat > Sender.AsFloat then begin
        qryEditor.FieldByName('Price3Inc').AsFloat := Sender.AsFloat;
        qryEditor.FieldByName('Price3Ex').AsFloat := dValue;
      end;
    end;
  end;

  if qryEditor.FieldByName('Price3Ex').AsFloat = 0 then begin
    qryEditor.FieldByName('Price3Inc').AsFloat := Sender.AsFloat;
    qryEditor.FieldByName('Price3Ex').AsFloat  := dValue;
    qryEditor.Post;
    qryEditor.Edit;
  end;

  fbUpdating := false;
end;

procedure TfrmProductFixedPrice.qryEditorPrice2IncChange(Sender: TField);
var
  dValue: double;
begin
  inherited;
  if fbUpdating then Exit;
  fbUpdating := true;
  dValue := GetAmountEx(Sender.AsFloat, GetTaxRate('GST'));
  qryEditor.Edit;
  qryEditor.FieldByName('Price2Ex').AsFloat := dValue;
  if qryEditor.FieldByName('Price1Ex').AsFloat = 0 then begin
    qryEditor.FieldByName('Price1Inc').AsFloat := Sender.AsFloat;
    qryEditor.FieldByName('Price1Ex').AsFloat  := dValue;
    qryEditor.Post;
    qryEditor.Edit;
  end else begin
    if Sender.AsFloat > qryEditor.FieldByName('Price1Inc').AsFloat then begin
      CommonLib.MessageDlgXP_Vista('Price 2 (Inc) Must be less than Price 1 (Inc)', mtWarning, [mbOK], 0);
      fbUpdating := false;
      Abort;
    end else begin
      if qryEditor.FieldByName('Price3Inc').AsFloat > Sender.AsFloat then begin
        qryEditor.FieldByName('Price3Inc').AsFloat := Sender.AsFloat;
        qryEditor.FieldByName('Price3Ex').AsFloat := dValue;
        qryEditor.Post;
        qryEditor.Edit;
      end;
    end;
  end;

  if qryEditor.FieldByName('Price3Ex').AsFloat = 0 then begin
    qryEditor.FieldByName('Price3Inc').AsFloat := Sender.AsFloat;
    qryEditor.FieldByName('Price3Ex').AsFloat  := dValue;
    qryEditor.Post;
    qryEditor.Edit;
  end;

  fbUpdating := false;
end;

procedure TfrmProductFixedPrice.qryEditorPrice3IncChange(Sender: TField);
var
  dValue: double;
begin
  inherited;
  if fbUpdating then Exit;
  fbUpdating := true;
  dValue := GetAmountEx(Sender.AsFloat, GetTaxRate('GST'));
  qryEditor.Edit;
  qryEditor.FieldByName('Price3Ex').AsFloat := dValue;
  if qryEditor.FieldByName('Price2Ex').AsFloat = 0 then begin
    qryEditor.FieldByName('Price2Inc').AsFloat := Sender.AsFloat;
    qryEditor.FieldByName('Price2Ex').AsFloat  := dValue;
    qryEditor.Post;
    qryEditor.Edit;
  end else begin
    if Sender.AsFloat > qryEditor.FieldByName('Price2Inc').AsFloat then begin
      CommonLib.MessageDlgXP_Vista('Price 3 (Inc) Must be less than Price 2 (Inc)', mtWarning, [mbOK], 0);
      fbUpdating := false;
      Abort;
    end;
  end;

  if qryEditor.FieldByName('Price1Ex').AsFloat = 0 then begin
    qryEditor.FieldByName('Price1Inc').AsFloat := Sender.AsFloat;
    qryEditor.FieldByName('Price1Ex').AsFloat  := dValue;
    qryEditor.Post;
    qryEditor.Edit;
  end;

  fbUpdating := false;
end;

procedure TfrmProductFixedPrice.btnUpdateClick(Sender: TObject);
begin
  inherited;
  // Do this to ensure data is posted regardless of state.
  qryEditor.Last;
  qryEditor.First;
end;

procedure TfrmProductFixedPrice.btnDeleteSellPriceClick(Sender: TObject);
begin
  inherited;
  qryEditor.Delete;
end;

procedure TfrmProductFixedPrice.qryEditorAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if not MainSellPriceMode then begin
    qryEditor.IndexFieldNames := 'ClientType ASC CIS; UOMName ASC CIS';
  end;
end;

procedure TfrmProductFixedPrice.qryEditorBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  if MainSellPriceMode then begin
    if qryEditor.RecordCount > 0 then begin
      Abort;
    end;
  end;
end;

initialization
  RegisterClassOnce(TfrmProductFixedPrice);

end.
