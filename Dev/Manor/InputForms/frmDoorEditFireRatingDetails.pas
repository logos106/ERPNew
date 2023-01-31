unit frmDoorEditFireRatingDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseProcTreeEdit, StdCtrls, Shader, ExtCtrls, AppEvnts, 
  DNMSpeedButton, wwclearbuttongroup, wwradiogroup,
  wwcheckbox, AdvEdit, DB, DBAccess, MyAccess,ERPdbComponents, Grids,
  BaseGrid, AdvGrid, MemDS, MessageConst;

type
  TfrmDoorEditFireRatingDetailsGUI = class(TBaseProcTreeEditGUI)
    rdgGroovePlacement: TwwRadioGroup;
    asgFireRatingDetails: TAdvStringGrid;
    Label1: TLabel;
    qryISDescriptions: TERPQuery;
    rdgGrooveLocation: TwwRadioGroup;
    chkGrooveCostDoorPrice: TwwCheckBox;
    chkIntumStripProvided: TwwCheckBox;
    chkIntumStripDoorPrice: TwwCheckBox;
    Label3: TLabel;
    edtFireRatingCost: TAdvEdit;
    Label4: TLabel;
    edtGrooveCost: TAdvEdit;
    imgDelete: TImage;
    tmrFocus: TTimer;
    Shape1: TShape;
    procedure FormCreate(Sender: TObject);
    procedure asgFireRatingDetailsGetEditorType(Sender: TObject; ACol,
      ARow: Integer; var AEditor: TEditorType);
    procedure asgFireRatingDetailsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tmrFocusTimer(Sender: TObject);
  private
    procedure SetPositionComboList;
    procedure SetDescriptionComboList;
    procedure AddCheckBoxes(const CheckBoxRow: Integer);
    procedure SetDefaultGridValues(const ARow: Integer);
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
  protected
    procedure SetPropertyValue(Sender: TObject); override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  CommonDbLib, CommonLib;

const
  cStripPositionCol = 1;
  cOverPanelRailCol = 2;
  cOverPanelTopRailCol = 3;
  cOverPanelStileCol = 4;
  cConcealedCol = 5;
  cConcealedCostCol = 6;
  cStripLengthCol = 7;
  cStripCostCol = 8;
  cStripTotalCostCol = 9;
  cStripQuantity = 10;
  cMeetingStileNumber = 11;
  cStripDescriptionCol = 12;
  cMaxStripPosList = 4;
  cStripPositionList: array[0..4] of string = ('All Door Edges',
                                               'Door Width',
                                               'Door Height',
                                               'Door Mtg Stile',
                                               'Door Hanging Stile');

{ TfrmFireRatingDetailGUI }

procedure TfrmDoorEditFireRatingDetailsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  asgFireRatingDetails.CheckTrue := 'T';
  asgFireRatingDetails.CheckFalse := 'F';
  asgFireRatingDetails.AddBitmap(0, 0, imgDelete.Picture.Bitmap, True, haCenter, vaCenter);
end;

procedure TfrmDoorEditFireRatingDetailsGUI.PerformStartup(var Msg: TMessage);
var
  RowIndex: Integer;
begin
  qryISDescriptions.Connection := GetSharedMyDacConnection;
  qryISDescriptions.Open;
  qryISDescriptions.FieldByName('Description').DisplayWidth := 20;
  inherited;
  SetDefaultGridValues(1);

  for RowIndex := 1 to asgFireRatingDetails.RowCount - 1 do
    AddCheckBoxes(RowIndex);
end;

procedure TfrmDoorEditFireRatingDetailsGUI.asgFireRatingDetailsGetEditorType(
  Sender: TObject; ACol, ARow: Integer; var AEditor: TEditorType);
begin
  inherited;

  case ACol of
    cStripPositionCol:
    begin
      AEditor := edComboEdit;
      SetPositionComboList;
    end;

    cConcealedCostCol:
    begin
      AEditor := edFloat;
    end;

    cStripLengthCol:
    begin
      AEditor := edPositiveNumeric;
    end;

    cStripCostCol:
    begin
      AEditor := edFloat;
    end;

    cStripTotalCostCol:
    begin
      AEditor := edFloat;
    end;

    cStripQuantity:
    begin
      AEditor := edFloat;
    end;

    cMeetingStileNumber:
    begin
      AEditor := edFloat;
    end;

    cStripDescriptionCol:
    begin
      AEditor := edComboEdit;
      SetDescriptionComboList;
    end;
  end;
end;

procedure TfrmDoorEditFireRatingDetailsGUI.SetDescriptionComboList;
begin
  asgFireRatingDetails.ComboBox.Items.Clear;
  qryISDescriptions.First;

  while not qryISDescriptions.Eof do begin
    asgFireRatingDetails.ComboBox.Items.Add(qryISDescriptions.FieldByName('Description').AsString);
    qryISDescriptions.Next;
  end;
end;

procedure TfrmDoorEditFireRatingDetailsGUI.SetPositionComboList;
var
  Index: Integer;
begin
  asgFireRatingDetails.ComboBox.Items.Clear;

  for Index := 0 to cMaxStripPosList do
    asgFireRatingDetails.ComboBox.Items.Add(cStripPositionList[Index]);
end;

procedure TfrmDoorEditFireRatingDetailsGUI.asgFireRatingDetailsKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DOWN then
    tmrFocus.Enabled := True; 
end;

procedure TfrmDoorEditFireRatingDetailsGUI.tmrFocusTimer(Sender: TObject);
begin
  inherited;
  
  //
  // Done due to bug in TAdvStringGrid where a cell loses focus after the first
  // cell change using arrow keys.
  //
  tmrFocus.Enabled := False;
  SetControlFocus(asgFireRatingDetails);
end;

procedure TfrmDoorEditFireRatingDetailsGUI.AddCheckBoxes(const CheckBoxRow: Integer);
var
  ColIndex: Integer;
begin
  for ColIndex := cOverPanelRailCol to cConcealedCol do
    asgFireRatingDetails.AddCheckBox(ColIndex, CheckBoxRow, False, True);
end;

procedure TfrmDoorEditFireRatingDetailsGUI.SetDefaultGridValues(const ARow: Integer);
begin
//  asgFireRatingDetails.Cells[1, ARow] := TFireRatingDetails(NodePropLink).StripPosition[ARow - 1].Value;
//  asgFireRatingDetails.Cells[2, ARow] := TFireRatingDetails(NodePropLink).OverPanelRail[ARow - 1].Value;
//  asgFireRatingDetails.Cells[3, ARow] := TFireRatingDetails(NodePropLink).OverPanelTopRail[ARow - 1].Value;
//  asgFireRatingDetails.Cells[4, ARow] := TFireRatingDetails(NodePropLink).OverPanelStile[ARow - 1].Value;
//  asgFireRatingDetails.Cells[5, ARow] := TFireRatingDetails(NodePropLink).StripConcealed[ARow - 1].Value;
//  asgFireRatingDetails.Cells[6, ARow] := TFireRatingDetails(NodePropLink).StripLength[ARow - 1].Value;
//  asgFireRatingDetails.Cells[7, ARow] := TFireRatingDetails(NodePropLink).StripCost[ARow - 1].Value;
//  asgFireRatingDetails.Cells[8, ARow] := TFireRatingDetails(NodePropLink).StripDescription[ARow - 1].Value;
end;

procedure TfrmDoorEditFireRatingDetailsGUI.SetPropertyValue(Sender: TObject);
begin
  inherited;

  if Showing and (Sender is TAdvStringGrid) then begin
    NodePropLink.PerformCalculations;
    LoadGridFromProps(TAdvStringGrid(Sender));
  end;
end;

initialization
  RegisterClassOnce(TfrmDoorEditFireRatingDetailsGUI);
finalization
  UnregisterClass(TfrmDoorEditFireRatingDetailsGUI);
end.
