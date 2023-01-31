unit frmDoorEditJoineryDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseProcTreeEdit, AppEvnts, ExtCtrls, DNMSpeedButton, StdCtrls,
  Shader, AdvEdit, Grids, BaseGrid, AdvGrid, DB, MemDS, DBAccess, MyAccess,ERPdbComponents,
  MessageConst;

type
  TfrmDoorEditJoineryDetailsGUI = class(TBaseProcTreeEditGUI)
    asgJoineryDetails: TAdvStringGrid;
    Label1: TLabel;
    edtTotalJoineryCost: TAdvEdit;
    imgDelete: TImage;
    tmrFocus: TTimer;
    qryJoinery: TERPQuery;
    procedure asgJoineryDetailsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tmrFocusTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure asgJoineryDetailsGetEditorType(Sender: TObject; ACol,
      ARow: Integer; var AEditor: TEditorType);
    procedure edtTotalJoineryCostEnter(Sender: TObject);
  private
    procedure SetColAlignment(const Row: Integer);
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
  protected
    procedure LoadGridFromProps(const Grid: TAdvStringGrid); override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  CommonLib, CommonDbLib;

const
  cQuantityCol = 1;
  cDescriptionCol = 2;
  cCostCol = 3;
  cUnitOfChargeCol = 4;

procedure TfrmDoorEditJoineryDetailsGUI.asgJoineryDetailsKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DOWN then
        tmrFocus.Enabled := True;
end;

procedure TfrmDoorEditJoineryDetailsGUI.tmrFocusTimer(Sender: TObject);
begin
  inherited;

  //
  // Done due to bug in TAdvStringGrid where a cell loses focus after the first
  // cell change using arrow keys.
  //
  tmrFocus.Enabled := False;
  SetControlFocus(asgJoineryDetails);
end;

procedure TfrmDoorEditJoineryDetailsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  asgJoineryDetails.AddBitmap(0, 0, imgDelete.Picture.Bitmap, True, haCenter, vaCenter);
end;

procedure TfrmDoorEditJoineryDetailsGUI.PerformStartup(var Msg: TMessage);
begin
  qryJoinery.Connection := GetSharedMyDacConnection;
  qryJoinery.Open;
  qryJoinery.First;
  qryJoinery.FieldByName('Description').DisplayWidth := 40;

  while not qryJoinery.Eof do begin
    asgJoineryDetails.ComboBox.Items.Add(qryJoinery.FieldByName('Description').AsString);
    qryJoinery.Next;
  end;

  inherited;
end;

procedure TfrmDoorEditJoineryDetailsGUI.asgJoineryDetailsGetEditorType(
  Sender: TObject; ACol, ARow: Integer; var AEditor: TEditorType);
begin
  inherited;
  case ACol of
    cQuantityCol,
    cUnitOfChargeCol:
    begin
      AEditor := edPositiveNumeric;
    end;

    cDescriptionCol:
    begin
      AEditor := edComboEdit;
    end;

    cCostCol:
    begin
      AEditor := edFloat;
    end;
  end;
end;

procedure TfrmDoorEditJoineryDetailsGUI.edtTotalJoineryCostEnter(Sender: TObject);
begin
  inherited;
  LoadGridFromProps(asgJoineryDetails);
end;

procedure TfrmDoorEditJoineryDetailsGUI.SetColAlignment(const Row: Integer);
var
  ColIndex: Integer;
begin
  for ColIndex := 1 to asgJoineryDetails.ColCount - 1 do begin
    if ColIndex in [cQuantityCol, cCostCol] then
      asgJoineryDetails.Alignments[ColIndex, Row] := taRightJustify;
  end;
end;

procedure TfrmDoorEditJoineryDetailsGUI.LoadGridFromProps(
  const Grid: TAdvStringGrid);
var
  RowIndex: Integer;
begin
  inherited;
  for RowIndex := 1 to asgJoineryDetails.RowCount - 1 do
    SetColAlignment(RowIndex);
end;
initialization
  RegisterClassOnce(TfrmDoorEditJoineryDetailsGUI);
finalization
  UnregisterClass(TfrmDoorEditJoineryDetailsGUI);
end.
