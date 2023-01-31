unit frmFrameIntumescentStripDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseProcTreeEdit, AppEvnts, ExtCtrls, DNMSpeedButton, StdCtrls,
  Shader, Grids, BaseGrid, AdvGrid, wwcheckbox, wwclearbuttongroup,
  wwradiogroup, DB, MemDS, DBAccess, MyAccess,ERPdbComponents, MessageConst, AdvEdit;

type
  TfrmFrameIntumescentStripDetailsGUI = class(TBaseProcTreeEditGUI)
    rdgStripPosition: TwwRadioGroup;
    chkIntumescentStripGroove: TwwCheckBox;
    chkIncludeGrooveCost: TwwCheckBox;
    chkIncludeISCost: TwwCheckBox;
    asgIntumescentStrips: TAdvStringGrid;
    Label1: TLabel;
    imgDelete: TImage;
    qryISDescriptions: TERPQuery;
    tmrFocus: TTimer;
    Label9: TLabel;
    edtTotalCost: TAdvEdit;
    procedure FormCreate(Sender: TObject);
    procedure asgIntumescentStripsGetEditorType(Sender: TObject; ACol,
      ARow: Integer; var AEditor: TEditorType);
    procedure tmrFocusTimer(Sender: TObject);
    procedure asgIntumescentStripsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure SetPositionComboList;
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
  protected
    procedure SetPropertyValue(Sender: TObject); override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  CommonLib, CommonDbLib;

const
  cStripCostCol = 1;
  cStripLengthCol = 2;
  cStripTotalCostCol = 3;
  cStripDescriptionCol = 4;

procedure TfrmFrameIntumescentStripDetailsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  asgIntumescentStrips.AddBitmap(0, 0, imgDelete.Picture.Bitmap, True, haCenter, vaCenter);
end;

procedure TfrmFrameIntumescentStripDetailsGUI.PerformStartup(var Msg: TMessage);
begin
  qryISDescriptions.Connection := GetSharedMyDacConnection;
  qryISDescriptions.Open;
  qryISDescriptions.FieldByName('Description').DisplayWidth := 20;
  SetPositionComboList;
  inherited;
end;

procedure TfrmFrameIntumescentStripDetailsGUI.SetPositionComboList;
begin
  qryISDescriptions.First;

  while not qryISDescriptions.Eof do begin
    asgIntumescentStrips.ComboBox.Items.Add(qryISDescriptions.FieldByName('Description').AsString);
    qryISDescriptions.Next;
  end;
end;

procedure TfrmFrameIntumescentStripDetailsGUI.asgIntumescentStripsGetEditorType(
  Sender: TObject; ACol, ARow: Integer; var AEditor: TEditorType);
begin
  inherited;
  case ACol of
    cStripCostCol:
    begin
      AEditor := edFloat;
    end;

    cStripLengthCol:
    begin
      AEditor := edPositiveNumeric;
    end;

    cStripTotalCostCol:
    begin
      AEditor := edFloat;
    end;

    cStripDescriptionCol:
    begin
      AEditor := edComboEdit;
      SetPositionComboList;
    end;
  end;
end;

procedure TfrmFrameIntumescentStripDetailsGUI.asgIntumescentStripsKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DOWN then
    tmrFocus.Enabled := True;
end;

procedure TfrmFrameIntumescentStripDetailsGUI.tmrFocusTimer(Sender: TObject);
begin
  inherited;

  //
  // Done due to bug in TAdvStringGrid where a cell loses focus after the first
  // cell change using arrow keys.
  //
  tmrFocus.Enabled := False;
  SetControlFocus(asgIntumescentStrips);
end;

procedure TfrmFrameIntumescentStripDetailsGUI.SetPropertyValue(Sender: TObject);
begin
  inherited;

  if Showing and (Sender is TAdvStringGrid) then begin
    NodePropLink.PerformCalculations;
    LoadGridFromProps(TAdvStringGrid(Sender));
  end;
end;

initialization
  RegisterClassOnce(TfrmFrameIntumescentStripDetailsGUI);
finalization
  UnregisterClass(TfrmFrameIntumescentStripDetailsGUI);
end.
