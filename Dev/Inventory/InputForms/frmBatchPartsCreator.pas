unit frmBatchPartsCreator;


{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 01/09/05  1.00.01 DSP  Removed the use of GetRowCount since it only returns the
                        number of grid rows displayed not the complete number
                        of rows.
 19/10/05  1.00.02 DLS  Added RegisterClass

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB,  Buttons, DNMSpeedButton,
  Wwdbigrd, Grids, Wwdbgrid, ExtCtrls, StdCtrls, DNMPanel, DBCtrls,
  ProgressDialog, Mask, wwdbedit, Wwdotdot, Wwdbcomb, wwdblook, MemDS,
  DBAccess, MyAccess,ERPdbComponents, kbmMemTable, DataState, Menus, AdvMenus, Shader,
  ImgList;

type
  TPanelInfo = record
    Panel: TDNMPanel;
    Grid: TwwDBGrid;
    Query: TERPQuery;
    SelecTDNMSpeedButton: TDNMSpeedButton;
    PanelCaption :String;
  end;

type
  TfrmBatchParts = class(TBaseInputGUI)
    dsParts: TDataSource;
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    btnCompleted: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    Label2: TLabel;
    lblPartAbbrev: TLabel;
    edtPartAbbrev: TEdit;
    dsCatID: TDataSource;
    qrySetupID: TERPQuery;
    dsCatagory2: TDataSource;
    dsCatagory1: TDataSource;
    dsCatagory3: TDataSource;
    dsCatagory4: TDataSource;
    dsCatagory5: TDataSource;
    lblProductDescription: TLabel;
    DNMPanel4: TDNMPanel;
    DNMPanel5: TDNMPanel;
    lblCatagory5: TLabel;
    wwDBGrid5: TwwDBGrid;
    DNMPanel6: TDNMPanel;
    lblCatagory4: TLabel;
    wwDBGrid2: TwwDBGrid;
    DNMPanel7: TDNMPanel;
    lblCatagory3: TLabel;
    wwDBGrid3: TwwDBGrid;
    DNMPanel8: TDNMPanel;
    lblCatagory2: TLabel;
    wwDBGrid4: TwwDBGrid;
    DNMPanel9: TDNMPanel;
    lblCatagory1: TLabel;
    wwDBGrid1: TwwDBGrid;
    tmrControlMonitor: TTimer;
    btnDelete: TDNMSpeedButton;
    btnAbbreviator: TDNMSpeedButton;
    Label3: TLabel;
    btnSelectAll1: TDNMSpeedButton;
    btnSelectAll2: TDNMSpeedButton;
    btnSelectAll3: TDNMSpeedButton;
    btnSelectAll4: TDNMSpeedButton;
    btnSelectAll5: TDNMSpeedButton;
    dsBatchSaves: TDataSource;
    cboKnownBatchs: TComboBox;
    btnSave: TDNMSpeedButton;
    Label4: TLabel;
    qryParts: TERPQuery;
    qryPartQtyLines: TERPQuery;
    qryPartChecker: TERPQuery;
    qryNewPart: TERPQuery;
    qryNewPartLines: TERPQuery;
    qryBatchSaves: TERPQuery;
    qryBatchInsert: TERPQuery;
    qryBatchChecker: TERPQuery;
    qryCatagory1: TERPQuery;
    qryCatagory1DescriptionAttribValue: TWideStringField;
    qryCatagory1DescriptionAttribAbbrev: TWideStringField;
    qryCatagory2: TERPQuery;
    StringField1: TWideStringField;
    StringField2: TWideStringField;
    qryCatagory3: TERPQuery;
    StringField3: TWideStringField;
    StringField4: TWideStringField;
    qryCatagory4: TERPQuery;
    StringField5: TWideStringField;
    StringField6: TWideStringField;
    qryCatagory5: TERPQuery;
    StringField7: TWideStringField;
    StringField8: TWideStringField;
    edtSearchFilter: TEdit;
    cboPartName: TwwDBLookupCombo;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DNMPanel9DragOver(Sender, Source: TObject; X, Y: integer; State: TDragState; var Accept: boolean);
    procedure DNMPanel9DragDrop(Sender, Source: TObject; X, Y: integer);
    procedure DNMPanel8DragDrop(Sender, Source: TObject; X, Y: integer);
    procedure DNMPanel8DragOver(Sender, Source: TObject; X, Y: integer; State: TDragState; var Accept: boolean);
    procedure DNMPanel7DragDrop(Sender, Source: TObject; X, Y: integer);
    procedure DNMPanel6DragDrop(Sender, Source: TObject; X, Y: integer);
    procedure DNMPanel5DragDrop(Sender, Source: TObject; X, Y: integer);
    procedure DNMPanel5DragOver(Sender, Source: TObject; X, Y: integer; State: TDragState; var Accept: boolean);
    procedure DNMPanel6DragOver(Sender, Source: TObject; X, Y: integer; State: TDragState; var Accept: boolean);
    procedure DNMPanel7DragOver(Sender, Source: TObject; X, Y: integer; State: TDragState; var Accept: boolean);
    procedure DNMPanel9StartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure DNMPanel8StartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure DNMPanel7StartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure DNMPanel6StartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure DNMPanel5StartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure btnAbbreviatorClick(Sender: TObject);
    procedure tmrControlMonitorTimer(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure btnSelectAll1Click(Sender: TObject);
    procedure btnSelectAll2Click(Sender: TObject);
    procedure btnSelectAll3Click(Sender: TObject);
    procedure btnSelectAll4Click(Sender: TObject);
    procedure btnSelectAll5Click(Sender: TObject);
    procedure cboPartName2CloseUp(Sender: TObject);
    procedure cboKnownBatchsCloseUp(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure cboPartNameNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure cboPartNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure edtSearchFilterExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);

  private
    { Private declarations }
    iMovingPanel, iPanelLocation: integer;
    aryPanelOrder: array[1..5] of TDNMPanel;
    aryPanelInfo: array[1..5] of TPanelInfo;
    MyProgressDialog: TProgressDialog;
    bBatchSaveOverride: boolean;
    bRequireAbbrev: boolean;
    bCompleteOverride: boolean;
    iMaxEntries: integer;

    function FindPanel(const ThisPanel: TDNMPanel): integer;
    procedure AdjustPanelOrderListViaLeft(const iPositionEntry: integer; const pnlAdjust: TDNMPanel);
    procedure AdjustPanelOrderListViaRight(const iPositionEntry: integer; const pnlAdjust: TDNMPanel);
    procedure EnableGrids;
    procedure DisableGrids;
    procedure CreateNewProduct(const strProductName, strDescription: string);
    function CreateProductName(const MyList: TStringList): string;

  public
    { Public declarations }
    iEnabledPanels: integer;
    
    procedure RefilterParts;
    procedure BuildKnownBatchList;
  end;

const
  USE_DELIMITER: string = '|';

implementation

uses
  CommonDbLib, DNMLib, DNMExceptions, frmPartsFrm, frmProductCodeAbbrev, 
  CommonLib, AppEnvironment, FastFuncs, MySQLConst;

{$R *.dfm}

procedure TfrmBatchParts.FormShow(Sender: TObject);
var
  iX, intID: integer;
  QueriesNotToOpen: array of string;
begin
  DisableForm;
  try
    try
      inherited;

      aryPanelOrder[1] := DNMPanel9;
      aryPanelOrder[2] := DNMPanel8;
      aryPanelOrder[3] := DNMPanel7;
      aryPanelOrder[4] := DNMPanel6;
      aryPanelOrder[5] := DNMPanel5;

      for iX := 1 to 5 do begin
        aryPanelInfo[iX].Panel := aryPanelOrder[iX];
        if aryPanelOrder[iX] = DNMPanel9 then begin
          aryPanelInfo[iX].Grid := wwDBGrid1;
          aryPanelInfo[iX].Query := qryCatagory1;
          aryPanelInfo[iX].PanelCaption := lblCatagory1.Caption;
          aryPanelInfo[iX].SelecTDNMSpeedButton := btnSelectAll1;
        end else if aryPanelOrder[iX] = DNMPanel8 then begin
          aryPanelInfo[iX].Grid := wwDBGrid4;
          aryPanelInfo[iX].Query := qryCatagory2;
          aryPanelInfo[iX].PanelCaption := lblCatagory2.Caption;
          aryPanelInfo[iX].SelecTDNMSpeedButton := btnSelectAll2;
        end else if aryPanelOrder[iX] = DNMPanel7 then begin
          aryPanelInfo[iX].Grid := wwDBGrid3;
          aryPanelInfo[iX].Query := qryCatagory3;
          aryPanelInfo[iX].PanelCaption := lblCatagory3.Caption;
          aryPanelInfo[iX].SelecTDNMSpeedButton := btnSelectAll3;
        end else if aryPanelOrder[iX] = DNMPanel6 then begin
          aryPanelInfo[iX].Grid := wwDBGrid2;
          aryPanelInfo[iX].Query := qryCatagory4;
          aryPanelInfo[iX].PanelCaption := lblCatagory4.Caption;
          aryPanelInfo[iX].SelecTDNMSpeedButton := btnSelectAll4;
        end else begin
          aryPanelInfo[iX].Grid := wwDBGrid5;
          aryPanelInfo[iX].Query := qryCatagory5;
          aryPanelInfo[iX].PanelCaption := lblCatagory5.Caption;
          aryPanelInfo[iX].SelecTDNMSpeedButton := btnSelectAll5;
        end;
      end;

      bRequireAbbrev := false;

      Setlength(QueriesNotToOpen, 7);
      QueriesNotToOpen[0] := 'qryPartChecker';
      QueriesNotToOpen[1] := 'qryPartQtyLines';
      QueriesNotToOpen[2] := 'qryNewPart';
      QueriesNotToOpen[3] := 'qryNewPartLine';
      QueriesNotToOpen[4] := 'qryBatchChecker';
      QueriesNotToOpen[5] := 'qryBatchInsert';
      QueriesNotToOpen[6] := 'qryParts';

      OpenQueries(QueriesNotToOpen);

        edtSearchFilter.Top := cboPartName.Top;
        edtSearchFilter.Left := cboPartName.Left;
        edtSearchFilter.Width := cboPartName.Width;
        cboPartName.Visible := false;
        edtSearchFilter.Visible := true;
        SetControlFocus(edtSearchFilter);
        Label2.Caption := 'Enter Search Criteria :';
//      end else begin
//        RefilterParts;
//      end;

      qryCatagory1.Active  := false;
      qryCatagory2.Active  := false;
      qryCatagory3.Active  := false;
      qryCatagory4.Active  := false;
      qryCatagory5.Active  := false;
      lblCatagory1.Enabled := false;
      lblCatagory1.Caption := '';
      lblCatagory2.Enabled := false;
      lblCatagory2.Caption := '';
      lblCatagory3.Enabled := false;
      lblCatagory3.Caption := '';
      lblCatagory4.Enabled := false;
      lblCatagory4.Caption := '';
      lblCatagory5.Enabled := false;
      lblCatagory5.Caption := '';

      intID := 1;
      qrySetupID.First;
      iEnabledPanels := 0;
      while not qrySetupID.Eof do begin
        with qrySetupID do begin
          if FieldByName('Active').AsString = 'T' then begin
            aryPanelInfo[intID].PanelCaption := FieldByName('CatagoryName').AsString;
            case intID of
              1:
                begin
                  qryCatagory1.Active := true;
                  lblCatagory1.Caption := FieldByName('CatagoryName').AsString;
                  lblCatagory1.Enabled := true;
                  DNMPanel9.Enabled := true;
                  Inc(iEnabledPanels);
                  btnSelectAll1.Enabled := true;
                end;

              2:
                begin
                  qryCatagory2.Active := true;
                  lblCatagory2.Caption := FieldByName('CatagoryName').AsString;
                  lblCatagory2.Enabled := true;
                  DNMPanel8.Enabled := true;
                  Inc(iEnabledPanels);
                  btnSelectAll2.Enabled := true;
                end;

              3:
                begin
                  qryCatagory3.Active := true;
                  lblCatagory3.Caption := FieldByName('CatagoryName').AsString;
                  lblCatagory3.Enabled := true;
                  DNMPanel7.Enabled := true;
                  Inc(iEnabledPanels);
                  btnSelectAll3.Enabled := true;
                end;

              4:
                begin
                  qryCatagory4.Active := true;
                  lblCatagory4.Caption := FieldByName('CatagoryName').AsString;
                  lblCatagory4.Enabled := true;
                  DNMPanel6.Enabled := true;
                  Inc(iEnabledPanels);
                  btnSelectAll4.Enabled := true;
                end;

              5:
                begin
                  qryCatagory5.Active := true;
                  lblCatagory5.Caption := FieldByName('CatagoryName').AsString;
                  lblCatagory5.Enabled := true;
                  DNMPanel5.Enabled := true;
                  Inc(iEnabledPanels);
                  btnSelectAll5.Enabled := true;
                end;
            end;
          end;
        end;

        qrySetupID.Next;
        Inc(intID);
      end;

    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmBatchParts.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  Action := caFree;
end;

procedure TfrmBatchParts.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmBatchParts.FormCreate(Sender: TObject);
begin
  inherited;
  BuildKnownBatchList;
  bBatchSaveOverride := false;
  qryParts.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryNewPart.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryPartChecker.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryNewPartLines.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryPartQtyLines.Connection := CommonDbLib.GetSharedMyDacConnection;
end;

procedure TfrmBatchParts.DNMPanel9DragDrop(Sender, Source: TObject; X, Y: integer);
begin
  inherited;
  iPanelLocation := FindPanel(DNMPanel9);
  if iMovingPanel = iPanelLocation then Exit;
  if iMovingPanel < iPanelLocation then begin
    AdjustPanelOrderListViaLeft(iPanelLocation, aryPanelOrder[iMovingPanel]);
  end else begin
    AdjustPanelOrderListViaRight(iPanelLocation, aryPanelOrder[iMovingPanel]);
  end;
end;

procedure TfrmBatchParts.DNMPanel8DragDrop(Sender, Source: TObject; X, Y: integer);
begin
  inherited;
  iPanelLocation := FindPanel(DNMPanel8);
  if iMovingPanel = iPanelLocation then Exit;
  if iMovingPanel < iPanelLocation then begin
    AdjustPanelOrderListViaLeft(iPanelLocation, aryPanelOrder[iMovingPanel]);
  end else begin
    AdjustPanelOrderListViaRight(iPanelLocation, aryPanelOrder[iMovingPanel]);
  end;
end;

procedure TfrmBatchParts.DNMPanel7DragDrop(Sender, Source: TObject; X, Y: integer);
begin
  inherited;
  iPanelLocation := FindPanel(DNMPanel7);
  if iMovingPanel = iPanelLocation then Exit;
  if iMovingPanel < iPanelLocation then begin
    AdjustPanelOrderListViaLeft(iPanelLocation, aryPanelOrder[iMovingPanel]);
  end else begin
    AdjustPanelOrderListViaRight(iPanelLocation, aryPanelOrder[iMovingPanel]);
  end;
end;

procedure TfrmBatchParts.DNMPanel6DragDrop(Sender, Source: TObject; X, Y: integer);
begin
  inherited;
  iPanelLocation := FindPanel(DNMPanel6);
  if iMovingPanel = iPanelLocation then Exit;
  if iMovingPanel < iPanelLocation then begin
    AdjustPanelOrderListViaLeft(iPanelLocation, aryPanelOrder[iMovingPanel]);
  end else begin
    AdjustPanelOrderListViaRight(iPanelLocation, aryPanelOrder[iMovingPanel]);
  end;
end;

procedure TfrmBatchParts.DNMPanel5DragDrop(Sender, Source: TObject; X, Y: integer);
begin
  inherited;
  iPanelLocation := FindPanel(DNMPanel5);
  if iMovingPanel = iPanelLocation then Exit;
  if iMovingPanel < iPanelLocation then begin
    AdjustPanelOrderListViaLeft(iPanelLocation, aryPanelOrder[iMovingPanel]);
  end else begin
    AdjustPanelOrderListViaRight(iPanelLocation, aryPanelOrder[iMovingPanel]);
  end;
end;

procedure TfrmBatchParts.DNMPanel9DragOver(Sender, Source: TObject; X, Y: integer; State: TDragState; var Accept: boolean);
begin
  inherited;
  Accept := true;
end;

procedure TfrmBatchParts.DNMPanel8DragOver(Sender, Source: TObject; X, Y: integer; State: TDragState; var Accept: boolean);
begin
  inherited;
  Accept := true;
end;

procedure TfrmBatchParts.DNMPanel5DragOver(Sender, Source: TObject; X, Y: integer; State: TDragState; var Accept: boolean);
begin
  inherited;
  Accept := true;
end;

procedure TfrmBatchParts.DNMPanel6DragOver(Sender, Source: TObject; X, Y: integer; State: TDragState; var Accept: boolean);
begin
  inherited;
  Accept := true;
end;

procedure TfrmBatchParts.DNMPanel7DragOver(Sender, Source: TObject; X, Y: integer; State: TDragState; var Accept: boolean);
begin
  inherited;
  Accept := true;
end;

procedure TfrmBatchParts.DNMPanel9StartDrag(Sender: TObject; var DragObject: TDragObject);
begin
  iMovingPanel := FindPanel(DNMPanel9);
end;

procedure TfrmBatchParts.DNMPanel8StartDrag(Sender: TObject; var DragObject: TDragObject);
begin
  iMovingPanel := FindPanel(DNMPanel8);
end;

procedure TfrmBatchParts.DNMPanel7StartDrag(Sender: TObject; var DragObject: TDragObject);
begin
  iMovingPanel := FindPanel(DNMPanel7);
end;

procedure TfrmBatchParts.DNMPanel6StartDrag(Sender: TObject; var DragObject: TDragObject);
begin
  iMovingPanel := FindPanel(DNMPanel6);
end;

procedure TfrmBatchParts.DNMPanel5StartDrag(Sender: TObject; var DragObject: TDragObject);
begin
  iMovingPanel := FindPanel(DNMPanel5);
end;

function TfrmBatchParts.FindPanel(const ThisPanel: TDNMPanel): integer;
var
  iX: integer;
begin
  Result := 0;
  for iX := 1 to 5 do begin
    if aryPanelOrder[iX] = ThisPanel then begin
      Result := iX;
      Exit;
    end;
  end;
end;

procedure TfrmBatchParts.AdjustPanelOrderListViaLeft(const iPositionEntry: integer; const pnlAdjust: TDNMPanel);
var
  iBaseLeft, iX, iCurPosition, iWidth: integer;
  aryLefts: array[1..5] of integer;
begin
  iBaseLeft := -4;
  iWidth := DNMPanel9.Width;

  for iX := 1 to 5 do begin
    aryLefts[iX] := iBaseLeft + ((iX - 1) * iWidth);
  end;

  iCurPosition := 1;

  for iX := 1 to iPositionEntry do begin
    if iX = iMovingPanel then Continue;
    aryPanelOrder[iCurPosition] := aryPanelOrder[iX];
    Inc(iCurPosition);
  end;

  aryPanelOrder[iPositionEntry] := pnlAdjust;

  for iX := 1 to 5 do begin
    aryPanelOrder[iX].Left := aryLefts[iX];
  end;

  for iX := 1 to 5 do begin
    aryPanelInfo[iX].Panel := aryPanelOrder[iX];
    if aryPanelOrder[iX] = DNMPanel9 then begin
      aryPanelInfo[iX].Grid := wwDBGrid1;
      aryPanelInfo[iX].Query := qryCatagory1;
      aryPanelInfo[iX].PanelCaption := lblCatagory1.Caption;
    end else if aryPanelOrder[iX] = DNMPanel8 then begin
      aryPanelInfo[iX].Grid := wwDBGrid4;
      aryPanelInfo[iX].Query := qryCatagory2;
      aryPanelInfo[iX].PanelCaption := lblCatagory2.Caption;
    end else if aryPanelOrder[iX] = DNMPanel7 then begin
      aryPanelInfo[iX].Grid := wwDBGrid3;
      aryPanelInfo[iX].Query := qryCatagory3;
      aryPanelInfo[iX].PanelCaption := lblCatagory3.Caption;
    end else if aryPanelOrder[iX] = DNMPanel6 then begin
      aryPanelInfo[iX].Grid := wwDBGrid2;
      aryPanelInfo[iX].Query := qryCatagory4;
      aryPanelInfo[iX].PanelCaption := lblCatagory4.Caption;
    end else begin
      aryPanelInfo[iX].Grid := wwDBGrid5;
      aryPanelInfo[iX].Query := qryCatagory5;
      aryPanelInfo[iX].PanelCaption := lblCatagory5.Caption;
    end;
  end;
end;

procedure TfrmBatchParts.AdjustPanelOrderListViaRight(const iPositionEntry: integer; const pnlAdjust: TDNMPanel);
var
  iBaseLeft, iX, iCurPosition, iWidth: integer;
  aryLefts: array[1..5] of integer;
begin
  iBaseLeft := -4;

  iWidth := DNMPanel9.Width;

  for iX := 1 to 5 do begin
    aryLefts[iX] := iBaseLeft + ((iX - 1) * iWidth);
  end;

  iCurPosition := 5;

  for iX := 5 downto iPositionEntry do begin
    if iX = iMovingPanel then Continue;

    aryPanelOrder[iCurPosition] := aryPanelOrder[iX];
    Dec(iCurPosition);
  end;

  aryPanelOrder[iPositionEntry] := pnlAdjust;

  for iX := 1 to 5 do begin
    aryPanelOrder[iX].Left := aryLefts[iX];
  end;

  for iX := 1 to 5 do begin
    aryPanelInfo[iX].Panel := aryPanelOrder[iX];
    if aryPanelOrder[iX] = DNMPanel9 then begin
      aryPanelInfo[iX].Grid := wwDBGrid1;
      aryPanelInfo[iX].Query := qryCatagory1;
      aryPanelInfo[iX].PanelCaption := lblCatagory1.Caption;
    end else if aryPanelOrder[iX] = DNMPanel8 then begin
      aryPanelInfo[iX].Grid := wwDBGrid4;
      aryPanelInfo[iX].Query := qryCatagory2;
      aryPanelInfo[iX].PanelCaption := lblCatagory2.Caption;
    end else if aryPanelOrder[iX] = DNMPanel7 then begin
      aryPanelInfo[iX].Grid := wwDBGrid3;
      aryPanelInfo[iX].Query := qryCatagory3;
      aryPanelInfo[iX].PanelCaption := lblCatagory3.Caption;
    end else if aryPanelOrder[iX] = DNMPanel6 then begin
      aryPanelInfo[iX].Grid := wwDBGrid2;
      aryPanelInfo[iX].Query := qryCatagory4;
      aryPanelInfo[iX].PanelCaption := lblCatagory4.Caption;
    end else begin
      aryPanelInfo[iX].Grid := wwDBGrid5;
      aryPanelInfo[iX].Query := qryCatagory5;
      aryPanelInfo[iX].PanelCaption := lblCatagory5.Caption;
    end;
  end;
end;

procedure TfrmBatchParts.btnAbbreviatorClick(Sender: TObject);
Var Form : TComponent;
begin
  Form := GetComponentByClassName('TProductCodeAbbrevGUI');
  if Assigned(Form) then begin
    with TProductCodeAbbrevGUI(Form) do begin
      FormStyle := fsNormal;
      Position  := poScreenCenter;
      ShowModal;
    end;
  end;  
end;

procedure TfrmBatchParts.tmrControlMonitorTimer(Sender: TObject);
begin
  inherited;
  if not bCompleteOverride then begin
    if (cboPartName.Text <> '') then begin
      if (bRequireAbbrev) then begin
        if edtPartAbbrev.Text <> '' then begin
          if not btnCompleted.Enabled then btnCompleted.Enabled := true;
          if not btnDelete.Enabled then btnDelete.Enabled := true;
        end else begin
          if btnCompleted.Enabled then btnCompleted.Enabled := false;
          if btnDelete.Enabled then btnDelete.Enabled := false;
        end;
      end else begin
        if not btnCompleted.Enabled then btnCompleted.Enabled := true;
        if not btnDelete.Enabled then btnDelete.Enabled := true;
      end;
    end else begin
      if btnCompleted.Enabled then btnCompleted.Enabled := false;
      if btnDelete.Enabled then btnDelete.Enabled := false;
    end;
  end else begin
    if btnCompleted.Enabled then btnCompleted.Enabled := false;
  end;

  if bBatchSaveOverride then begin
    if btnSave.Enabled then btnSave.Enabled := false;
  end else begin
    if cboKnownBatchs.Text = '' then begin
      if btnSave.Enabled then btnSave.Enabled := false;
    end else begin
      if not btnSave.Enabled then btnSave.Enabled := true;
    end;
  end;

  Application.ProcessMessages;
end;

procedure TfrmBatchParts.DisableGrids;
begin
  wwDBGrid1.Visible := false;
  wwDBGrid2.Visible := false;
  wwDBGrid3.Visible := false;
  wwDBGrid4.Visible := false;
  wwDBGrid5.Visible := false;

  if aryPanelInfo[1].Panel.Enabled then begin
    aryPanelInfo[1].SelecTDNMSpeedButton.Enabled := false;
  end;

  if aryPanelInfo[2].Panel.Enabled then begin
    aryPanelInfo[2].SelecTDNMSpeedButton.Enabled := false;
  end;

  if aryPanelInfo[3].Panel.Enabled then begin
    aryPanelInfo[3].SelecTDNMSpeedButton.Enabled := false;
  end;

  if aryPanelInfo[4].Panel.Enabled then begin
    aryPanelInfo[4].SelecTDNMSpeedButton.Enabled := false;
  end;

  if aryPanelInfo[5].Panel.Enabled then begin
    aryPanelInfo[5].SelecTDNMSpeedButton.Enabled := false;
  end;

  bCompleteOverride := true;
  btnCompleted.Enabled := false;
  btnAbbreviator.Enabled := false;
  bBatchSaveOverride := true;
  btnClose.Enabled := false;
  Self.Update;
end;

procedure TfrmBatchParts.EnableGrids;
begin
  wwDBGrid1.Visible := true;
  wwDBGrid2.Visible := true;
  wwDBGrid3.Visible := true;
  wwDBGrid4.Visible := true;
  wwDBGrid5.Visible := true;

  if aryPanelInfo[1].Panel.Enabled then begin
    aryPanelInfo[1].SelecTDNMSpeedButton.Enabled := true;
    aryPanelInfo[1].Query.First;
  end;

  if aryPanelInfo[2].Panel.Enabled then begin
    aryPanelInfo[2].SelecTDNMSpeedButton.Enabled := true;
    aryPanelInfo[2].Query.First;
  end;

  if aryPanelInfo[3].Panel.Enabled then begin
    aryPanelInfo[3].SelecTDNMSpeedButton.Enabled := true;
    aryPanelInfo[3].Query.First;
  end;

  if aryPanelInfo[4].Panel.Enabled then begin
    aryPanelInfo[4].SelecTDNMSpeedButton.Enabled := true;
    aryPanelInfo[4].Query.First;
  end;

  if aryPanelInfo[5].Panel.Enabled then begin
    aryPanelInfo[5].SelecTDNMSpeedButton.Enabled := true;
    aryPanelInfo[5].Query.First;
  end;

  bCompleteOverride := false;
  btnCompleted.Enabled := true;
  btnAbbreviator.Enabled := true;
  bBatchSaveOverride := false;
  btnClose.Enabled := true;
  Self.Update;  
end;

procedure TfrmBatchParts.btnCompletedClick(Sender: TObject);
var
  iV, iW, iX, iY, iZ, iCount: integer;
  iSelectionID: integer;
  aryPanelIndexes: array[1..5] of integer;
  Selection1: TStringList;
  Selection2: TStringList;
  Selection3: TStringList;
  Selection4: TStringList;
  Selection5: TStringList;
  ThisSelection: TStringList;
  ProductName: TStringList;
  strGeneratedProductName, strPartName, strDescription: string;
  iPartID: integer;
  Query: TERPQuery;
begin
  inherited;
  for iX := 1 to 5 do begin
    aryPanelInfo[iX].Panel := aryPanelOrder[iX];
    if aryPanelOrder[iX] = DNMPanel9 then begin
      aryPanelInfo[iX].PanelCaption := lblCatagory1.Caption;
    end else if aryPanelOrder[iX] = DNMPanel8 then begin
      aryPanelInfo[iX].PanelCaption := lblCatagory2.Caption;
    end else if aryPanelOrder[iX] = DNMPanel7 then begin
      aryPanelInfo[iX].PanelCaption := lblCatagory3.Caption;
    end else if aryPanelOrder[iX] = DNMPanel6 then begin
      aryPanelInfo[iX].PanelCaption := lblCatagory4.Caption;
    end else begin
      aryPanelInfo[iX].PanelCaption := lblCatagory5.Caption;
    end;
  end;

  iCount := 0;
  for iX := 1 to 5 do begin
    if (aryPanelInfo[iX].Panel.Enabled) then begin
      Inc(iCount);
    end;
  end;

  if iCount = 0 then Exit;

  DisableGrids;

  Selection1 := TStringList.Create;
  Selection2 := TStringList.Create;
  Selection3 := TStringList.Create;
  Selection4 := TStringList.Create;
  Selection5 := TStringList.Create;
  MyProgressDialog := TProgressDialog.Create(nil);
  ProductName := TStringList.Create;
  tmrControlMonitor.Enabled := false;
  try
    iSelectionID := 1;
    ZeroMemory(@aryPanelIndexes, SizeOf(aryPanelIndexes));
    strPartName := cboPartName.Text;

    for iX := 1 to iCount do begin
      if not aryPanelInfo[iX].Query.Active then Continue;
      Query := aryPanelInfo[iX].Query;
      ThisSelection := nil;
      Query.First;

      while not Query.Eof do begin
        if aryPanelInfo[iX].Grid.IsSelectedRecord then begin
          case iSelectionID of
            1: ThisSelection := Selection1;
            2: ThisSelection := Selection2;
            3: ThisSelection := Selection3;
            4: ThisSelection := Selection4;
            5: ThisSelection := Selection5;
          end;
          ThisSelection.Add(aryPanelInfo[iX].Grid.GetFieldValue(0));
        end;
        Query.Next;
      end;

      if (Assigned(ThisSelection) and (ThisSelection.Count <> 0)) then begin
        aryPanelIndexes[iSelectionID] := iX;
        Inc(iSelectionID);
      end;
    end;

    iMaxEntries := 0;
    for iX := 1 to iCount do begin
      case iX of
        1: if Selection1.Count <> 0 then iMaxEntries := Selection1.Count;
        2: if Selection2.Count <> 0 then iMaxEntries := iMaxEntries * Selection2.Count;
        3: if Selection3.Count <> 0 then iMaxEntries := iMaxEntries * Selection3.Count;
        4: if Selection4.Count <> 0 then iMaxEntries := iMaxEntries * Selection4.Count;
        5: if Selection5.Count <> 0 then iMaxEntries := iMaxEntries * Selection5.Count;
      end;
    end;

    if iMaxEntries = 0 then begin
      EnableGrids;
      cboPartName.Text := strPartName;
      Exit;
    end;

    DisableGrids;
    qryCatagory1.DisableControls;
    qryCatagory2.DisableControls;
    qryCatagory3.DisableControls;
    qryCatagory4.DisableControls;
    qryCatagory5.DisableControls;

    Processingcursor(True);
    MyProgressDialog.Caption := 'Working .......';
    MyProgressDialog.MinValue := 0;
    MyProgressDialog.MaxValue := iMaxEntries;
    MyProgressDialog.Step  := 1;
    MyProgressDialog.Value := 0;
    MyProgressDialog.Execute;

    qryParts.Filtered := false;
    qryParts.Filter   := 'PARTNAME = ' + QuotedStr(cboPartName.Text);
    qryParts.Filtered := true;
    iPartID           := qryParts.FieldByName('PartsID').AsInteger;

    strDescription := '';
    for iV := 0 to Selection1.Count - 1 do begin
      ProductName.Clear;
      if bRequireAbbrev then begin
        ProductName.Add(edtPartAbbrev.Text);
      end else begin
        ProductName.Add(cboPartName.Text);
      end;

      strDescription := aryPanelInfo[aryPanelIndexes[1]].PanelCaption + ': ' + Selection1.Strings[iV];
      aryPanelInfo[aryPanelIndexes[1]].Query.Filtered := false;
      aryPanelInfo[aryPanelIndexes[1]].Query.Filter := 'DescriptionAttribValue = ' + QuotedStr(Selection1.Strings[iV]);
      aryPanelInfo[aryPanelIndexes[1]].Query.Filtered := true;

      ProductName.Add(aryPanelInfo[aryPanelIndexes[1]].Query.FieldByName('DescriptionAttribAbbrev').AsString);
      if (aryPanelInfo[aryPanelIndexes[2]].Query.Active) and (Selection2.Count > 0) then begin
        for iW := 0 to Selection2.Count - 1 do begin
          strDescription := aryPanelInfo[aryPanelIndexes[1]].PanelCaption + ': ' + Selection1.Strings[iV] + ', ' +
                            aryPanelInfo[aryPanelIndexes[2]].PanelCaption + ': ' + Selection2.Strings[iW];

          aryPanelInfo[aryPanelIndexes[2]].Query.Filtered := false;
          aryPanelInfo[aryPanelIndexes[2]].Query.Filter := 'DescriptionAttribValue = ' + QuotedStr(Selection2.Strings[iW]);
          aryPanelInfo[aryPanelIndexes[2]].Query.Filtered := true;
          ProductName.Add(aryPanelInfo[aryPanelIndexes[2]].Query.FieldByName('DescriptionAttribAbbrev').AsString);

          if (aryPanelInfo[aryPanelIndexes[3]].Query.Active) and (Selection3.Count > 0) then begin
            for iX := 0 to Selection3.Count - 1 do begin
              strDescription := aryPanelInfo[aryPanelIndexes[1]].PanelCaption + ': ' + Selection1.Strings[iV] + ', ' +
                                aryPanelInfo[aryPanelIndexes[2]].PanelCaption + ': ' + Selection2.Strings[iW]+ ', ' +
                                aryPanelInfo[aryPanelIndexes[3]].PanelCaption + ': ' + Selection3.Strings[iX];


              aryPanelInfo[aryPanelIndexes[3]].Query.Filtered := false;
              aryPanelInfo[aryPanelIndexes[3]].Query.Filter := 'DescriptionAttribValue = ' + QuotedStr(Selection3.Strings[iX]);
              aryPanelInfo[aryPanelIndexes[3]].Query.Filtered := true;
              ProductName.Add(aryPanelInfo[aryPanelIndexes[3]].Query.FieldByName('DescriptionAttribAbbrev').AsString);

              if (aryPanelInfo[aryPanelIndexes[4]].Query.Active) and (Selection4.Count > 0) then begin
                for iY := 0 to Selection4.Count - 1 do begin
                    strDescription := aryPanelInfo[aryPanelIndexes[1]].PanelCaption + ': ' + Selection1.Strings[iV] + ', ' +
                                aryPanelInfo[aryPanelIndexes[2]].PanelCaption + ': ' + Selection2.Strings[iW]+ ', ' +
                                aryPanelInfo[aryPanelIndexes[3]].PanelCaption + ': ' + Selection3.Strings[iX]+ ', ' +
                                aryPanelInfo[aryPanelIndexes[4]].PanelCaption + ': ' + Selection4.Strings[iY];


                  aryPanelInfo[aryPanelIndexes[4]].Query.Filtered := false;
                  aryPanelInfo[aryPanelIndexes[4]].Query.Filter :=
                    'DescriptionAttribValue = ' + QuotedStr(Selection4.Strings[iY]);
                  aryPanelInfo[aryPanelIndexes[4]].Query.Filtered := true;
                  ProductName.Add(aryPanelInfo[aryPanelIndexes[4]].Query.FieldByName('DescriptionAttribAbbrev').AsString);

                  if (aryPanelInfo[5].Query.Active) and (Selection5.Count > 0) then begin
                    for iZ := 0 to Selection5.Count - 1 do begin
                        strDescription := aryPanelInfo[aryPanelIndexes[1]].PanelCaption + ': ' + Selection1.Strings[iV] + ', ' +
                                aryPanelInfo[aryPanelIndexes[2]].PanelCaption + ': ' + Selection2.Strings[iW]+ ', ' +
                                aryPanelInfo[aryPanelIndexes[3]].PanelCaption + ': ' + Selection3.Strings[iX]+ ', ' +
                                aryPanelInfo[aryPanelIndexes[4]].PanelCaption + ': ' + Selection4.Strings[iY]+ ', ' +
                                aryPanelInfo[aryPanelIndexes[5]].PanelCaption + ': ' + Selection5.Strings[iZ];

                      aryPanelInfo[aryPanelIndexes[5]].Query.Filtered := false;
                      aryPanelInfo[aryPanelIndexes[5]].Query.Filter :=
                        'DescriptionAttribValue = ' + QuotedStr(Selection5.Strings[iZ]);
                      aryPanelInfo[aryPanelIndexes[5]].Query.Filtered := true;
                      ProductName.Add(aryPanelInfo[aryPanelIndexes[5]].Query.FieldByName('DescriptionAttribAbbrev').AsString);

                      strGeneratedProductName := CreateProductName(ProductName);

                      CreateNewProduct(strGeneratedProductName, strDescription);
                      strDescription := '';

                      MyProgressDialog.StepIt;
                      Application.ProcessMessages;

                      ProductName.Delete(ProductName.Count - 1);
                    end;

                    ProductName.Delete(ProductName.Count - 1);
                  end else begin
                    strGeneratedProductName := CreateProductName(ProductName);

                    CreateNewProduct(strGeneratedProductName, strDescription);
                    strDescription := '';

                    MyProgressDialog.StepIt;
                    Application.ProcessMessages;

                    ProductName.Delete(ProductName.Count - 1);
                  end;
                end;

                ProductName.Delete(ProductName.Count - 1);
              end else begin
                strGeneratedProductName := CreateProductName(ProductName);
                CreateNewProduct(strGeneratedProductName, strDescription);
                strDescription := '';
                MyProgressDialog.StepIt;
                Application.ProcessMessages;
                ProductName.Delete(ProductName.Count - 1);
              end;
            end;
            ProductName.Delete(ProductName.Count - 1);
          end else begin
            strGeneratedProductName := CreateProductName(ProductName);
            CreateNewProduct(strGeneratedProductName, strDescription);
            strDescription := '';
            MyProgressDialog.StepIt;
            Application.ProcessMessages;
            ProductName.Delete(ProductName.Count - 1);
          end;
        end;
        ProductName.Delete(ProductName.Count - 1);
      end else begin
        strGeneratedProductName := CreateProductName(ProductName);
        CreateNewProduct(strGeneratedProductName, strDescription);
        MyProgressDialog.StepIt;
        Application.ProcessMessages;
        strDescription := '';
      end;
    end;

    for iX := 1 to 5 do begin
      if aryPanelInfo[iX].Query.Active then begin
        aryPanelInfo[iX].Query.Filtered := false;
      end;
    end;

    qryParts.Filtered := false;
    qryCatagory1.EnableControls;
    qryCatagory2.EnableControls;
    qryCatagory3.EnableControls;
    qryCatagory4.EnableControls;
    qryCatagory5.EnableControls;
    EnableGrids;
    RefilterParts;
    if qryParts.Locate('PartsID', iPartID, [loCaseInsensitive]) then begin
      cboPartName.Text := strPartName;
    end;
  finally
    FreeAndNil(Selection1);
    FreeAndNil(Selection2);
    FreeAndNil(Selection3);
    FreeAndNil(Selection4);
    FreeAndNil(Selection5);
    FreeAndNil(ProductName);
    FreeAndNil(MyProgressDialog);
    Processingcursor(False);
    tmrControlMonitor.Enabled := true;
  end;
end;

procedure TfrmBatchParts.CreateNewProduct(const strProductName, strDescription: string);
var
  iID, iThisID: integer;
begin
  iID := 0;
  Self.Update;
  try
    with qryNewPart do begin
      SQL.Clear;
      SQL.Add('INSERT HIGH_PRIORITY INTO tblparts (PARTTYPE, PRODUCTGROUP, PARTNAME,');
      SQL.Add('PARTSDESCRIPTION, PURCHASEDESC, INCOMEACCNT, ASSETACCNT, COGSACCNT,');
      SQL.Add('PRODUCTCODE, TAXCODE, PURCHTAXCODE, PREFEREDSUPP, SpecialDiscount, SNTracking,');
      SQL.Add('MultipleBins, Batch, AutoBatch, AutoReorder, ');
      SQL.Add('BuyQTY1, BuyQTY2, BuyQTY3,');
      SQL.Add('COST1, COST2, COST3, COSTINC1, COSTINC2, COSTINC3,AvgCost, ');
      SQL.Add('SellQTY1, SellQTY2, SellQTY3, ');
      SQL.Add('PRICE1, PRICE2, PRICE3,PRICEINC1, PRICEINC2, PRICEINC3,');
      SQL.Add('OrgPrice1, OrgPrice2, OrgPrice3, WHOLESALEPRICE, Active, EditedFlag,'); //, UnitofMeasure, UnitofMeasureID, UnitofMeasureSales, UnitofMeasureIDSales,
      SQL.Add('ProductComment,');
      SQL.Add('Attrib1Sale, Attrib2Sale, Attrib1SaleRate, Attrib1Purchase, Attrib2Purchase, Attrib1PurchaseRate,');
      SQL.Add('SupplierProductCode, Required, DateCreated, DateUpdated, ShowProductPopUp, ProductPopUpNotes) VALUES (');
      SQL.Add(QuotedStr(qryParts.FieldByName('PartType').AsString) + ', ' +
        QuotedStr(qryParts.FieldByName('ProductGroup').AsString));
      SQL.Add(', ' + QuotedStr(strProductName) + ', ' + QuotedStr(qryParts.FieldByName('PartsDescription').AsString +
        ' - ' + strProductName + ': (' + strDescription + ')'));
      SQL.Add(', ' + QuotedStr(strProductName + ': (' + strDescription + ')') + ', ' +
        QuotedStr(qryParts.FieldByName('IncomeAccnt').AsString));
      SQL.Add(', ' + QuotedStr(qryParts.FieldByName('AssetAccnt').AsString) + ', ' +
        QuotedStr(qryParts.FieldByName('COGSAccnt').AsString));
      SQL.Add(', ' + QuotedStr(qryParts.FieldByName('ProductCode').AsString));
      SQL.Add(', ' + QuotedStr(qryParts.FieldByName('Taxcode').AsString) + ', ' +
        QuotedStr(qryParts.FieldByName('PurchTaxCode').AsString));
      SQL.Add(', ' + QuotedStr(qryParts.FieldByName('PreferedSupp').AsString) + ', ' +
        QuotedStr(qryParts.FieldByName('SpecialDiscount').AsString));
      SQL.Add(', ' + QuotedStr(qryParts.FieldByName('SNTracking').AsString) + ', ' +
        QuotedStr(qryParts.FieldByName('MultipleBins').AsString));
      SQL.Add(', ' + QuotedStr(qryParts.FieldByName('Batch').AsString) + ', ' +
        QuotedStr(qryParts.FieldByName('AutoBatch').AsString));
      SQL.Add(', ' + QuotedStr(qryParts.FieldByName('AutoReorder').AsString));
      SQL.Add(', ' + QuotedStr(qryParts.FieldByName('BuyQTY1').AsString) + ', ' +
        QuotedStr(qryParts.FieldByName('BuyQTY2').AsString) + ', ' + QuotedStr(qryParts.FieldByName('BuyQTY3').AsString));
      SQL.Add(', ' + QuotedStr(FloatToStr(qryParts.FieldByName('Cost1').AsFloat)) + ', ' +
        QuotedStr(FloatToStr(qryParts.FieldByName('Cost2').AsFloat)) + ', ' +
        QuotedStr(FloatToStr(qryParts.FieldByName('Cost3').AsFloat)));
      SQL.Add(', ' + QuotedStr(FloatToStr(qryParts.FieldByName('Costinc1').AsFloat)) + ', ' +
        QuotedStr(FloatToStr(qryParts.FieldByName('Costinc2').AsFloat)) + ', ' +
        QuotedStr(FloatToStr(qryParts.FieldByName('Costinc3').AsFloat)));
      SQL.Add(', ' + QuotedStr(FloatToStr(qryParts.FieldByName('AvgCost').AsFloat)));
      SQL.Add(', ' + QuotedStr(qryParts.FieldByName('SellQTY1').AsString) + ', ' +
        QuotedStr(qryParts.FieldByName('SellQTY2').AsString) + ', ' + QuotedStr(qryParts.FieldByName('SellQTY3').AsString));
      SQL.Add(', ' + QuotedStr(FloatToStr(qryParts.FieldByName('Price1').AsFloat)) + ', ' +
        QuotedStr(FloatToStr(qryParts.FieldByName('Price2').AsFloat)) + ', ' +
        QuotedStr(FloatToStr(qryParts.FieldByName('Price3').AsFloat)));
      SQL.Add(', ' + QuotedStr(FloatToStr(qryParts.FieldByName('Priceinc1').AsFloat)) + ', ' +
        QuotedStr(FloatToStr(qryParts.FieldByName('Priceinc2').AsFloat)) + ', ' +
        QuotedStr(FloatToStr(qryParts.FieldByName('Priceinc3').AsFloat)));
      SQL.Add(', ' + QuotedStr(FloatToStr(qryParts.FieldByName('OrgPrice1').AsFloat)) + ', ' +
        QuotedStr(FloatToStr(qryParts.FieldByName('OrgPrice2').AsFloat)) + ', ' +
        QuotedStr(FloatToStr(qryParts.FieldByName('OrgPrice3').AsFloat)));
      SQL.Add(', ' + QuotedStr(FloatToStr(qryParts.FieldByName('Wholesaleprice').AsFloat)));
      SQL.Add(', ' + QuotedStr(qryParts.FieldByName('Active').AsString) + ', ' +
        QuotedStr(qryParts.FieldByName('EditedFlag').AsString));
      SQL.Add(', ' + QuotedStr(qryParts.FieldByName('ProductComment').AsString));
      SQL.Add(', ' + QuotedStr(FloatToStr(qryParts.FieldByName('Attrib1Sale').AsFloat)) + ', ' +
        QuotedStr(FloatToStr(qryParts.FieldByName('Attrib2Sale').AsFloat)));
      SQL.Add(', ' + QuotedStr(FloatToStr(qryParts.FieldByName('Attrib1SaleRate').AsFloat)));
      SQL.Add(', ' + QuotedStr(FloatToStr(qryParts.FieldByName('Attrib1Purchase').AsFloat)) +
        ', ' + QuotedStr(FloatToStr(qryParts.FieldByName('Attrib2Purchase').AsFloat)));
      SQL.Add(', ' + QuotedStr(FloatToStr(qryParts.FieldByName('Attrib1PurchaseRate').AsFloat)));
      SQL.Add(', ' + QuotedStr(qryParts.FieldByName('SupplierProductCode').AsString) + ', ' +
        QuotedStr(qryParts.FieldByName('Required').AsString));
      SQL.Add(', ' + QuotedStr(FormatDateTime(MysqlDateFormat, Now())) + ', ' + QuotedStr(FormatDateTime(MysqlDateFormat, Now())));
      SQL.Add(', ' + QuotedStr(qryParts.FieldByName('ShowProductPopup').AsString) + ', ' +
        QuotedStr(qryParts.FieldByName('ProductPopUpNotes').AsString));
      SQL.Add(')');
      Execute;

      iThisID := GetLastRecordPostID('tblparts');
      iID := iThisID;
    end;
  except
    iThisID := 0;
  end;

  if iThisID = 0 then begin
    qryNewPart.Close;
    qryNewPart.SQL.Clear;
    qryNewPart.SQL.Add('SELECT PartsID, PartsDescription, PURCHASEDESC FROM tblparts WHERE (PartName = ' +
      QuotedStr(strProductName) + ')');
    qryNewPart.Open;
    if qryNewPart.RecordCount > 0 then begin
      iThisID := qryNewPart.FieldByName('PARTSID').AsInteger;
      iID := iThisID;
      qryNewPart.Edit;
      qryNewPart.FieldByName('PURCHASEDESC').AsString := qryParts.FieldByName('PartsDescription').AsString +
        ' - ' + strProductName + ': (' + strDescription + ')';
      qryNewPart.FieldByName('PartsDescription').AsString := qryParts.FieldByName('PartsDescription').AsString +
        ' - ' + strProductName + ': (' + strDescription + ')';
      qryNewPart.Post;
    end else begin
      Exit;
    end;
  end;

  try
    with qryPartQtyLines do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM tblproductclasses WHERE (ProductID = ' + qryParts.FieldByName('PartsID').AsString + ')');
      Open;
    end;

    if qryPartQtyLines.RecordCount > 0 then begin
      while not qryPartQtyLines.Eof do begin
        with qryNewPartLines do begin
          SQL.Clear;
          SQL.Add('INSERT HIGH_PRIORITY INTO tblproductclasses ');
          SQL.Add('( ProductID, ProductName, ProductGroup, ClassID, ClassName');
          SQL.Add(', ReOrderPoint, PreferredLevel, ReOrderAmount,');
          SQL.Add('LastAdj, LastAdjAccount, ClassPriceVariance, VariantPrice) ');
          SQL.Add('VALUES ('+QuotedStr(IntToStr(iID)) + ', ' + QuotedStr(strProductName));
          SQL.Add(', ' + QuotedStr(qryPartQtyLines.FieldByName('ProductGroup').AsString) + ', ' +
            QuotedStr(qryPartQtyLines.FieldByName('ClassID').AsString));
          SQL.Add(', ' + QuotedStr(qryPartQtyLines.FieldByName('ClassName').AsString)+', ' );
          (*SQL.Add(' 0, 0, 0, 0,');*)
          SQL.Add( QuotedStr(FloatToStr(qryPartQtyLines.FieldByName('ReOrderPoint').AsFloat))
            + ', ' + QuotedStr(FloatToStr(qryPartQtyLines.FieldByName('PreferredLevel').AsFloat)));
          SQL.Add(', ' + QuotedStr(FloatToStr(qryPartQtyLines.FieldByName('ReOrderAmount').AsFloat)) +
            ', 0, 0, ' );
          SQL.Add( QuotedStr(FloatToStr(qryPartQtyLines.FieldByName('ClassPriceVariance').AsFloat))
            + ', ' + QuotedStr(FloatToStr(qryPartQtyLines.FieldByName('VariantPrice').AsFloat)));
          SQL.Add(')');
          Execute;
        end;
        qryPartQtyLines.Next;
      end;
    end;
  except 
  end;

  try
    with qryPartQtyLines do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM tblextrapricesell WHERE (PartsID = ' + qryParts.FieldByName('PartsID').AsString + ')');
      Open;
    end;

    if qryPartQtyLines.RecordCount > 0 then begin
      while not qryPartQtyLines.Eof do begin
        with qryNewPartLines do begin
          SQL.Clear;
          SQL.Add('INSERT HIGH_PRIORITY INTO tblextrapricesell (GlobalRef, PriceID, ClientTypeID, PartsID, QtyPercent1, ');
(*          SQL.Add('QtyPercent2, QtyPercent3, EditedFlag, ');*)
          SQL.Add('DateFrom, DateTo, AllClients, ExtraSellDesc, Price1 ');
          (*SQL.Add(',Price2, Price3');*)
          SQL.Add(') VALUES (NULL, NULL, ');
          SQL.Add(QuotedStr(qryPartQtyLines.FieldByName('ClientTypeID').AsString) + ', ' + QuotedStr(IntToStr(iID)) + ', ');
          SQL.Add(QuotedStr(FloatToStr(qryPartQtyLines.FieldByName('QtyPercent1').AsFloat)) + ', ');
          (*SQL.Add(QuotedStr(FloatToStr(qryPartQtyLines.FieldByName('QtyPercent2').AsFloat)) + ', ');
          SQL.Add(QuotedStr(FloatToStr(qryPartQtyLines.FieldByName('QtyPercent3').AsFloat)) + ', ');*)
          (*SQL.Add(QuotedStr(qryPartQtyLines.FieldByName('EditedFlag').AsString) + ', ');*)
          if not Empty(qryPartQtyLines.FieldByName('DateFrom').AsString) then begin
            SQL.Add(QuotedStr(FormatDateTime(MysqlDateFormat, qryPartQtyLines.FieldByName('DateFrom').AsFloat)) + ', ');
          end else begin
            SQL.Add('NULL, ');
          end;

          if not Empty(qryPartQtyLines.FieldByName('DateFrom').AsString) then begin
            SQL.Add(QuotedStr(FormatDateTime(MysqlDateFormat, qryPartQtyLines.FieldByName('DateTo').AsFloat)) + ', ');
          end else begin
            SQL.Add('NULL, ');
          end;

          SQL.Add(QuotedStr(qryPartQtyLines.FieldByName('AllClients').AsString) + ', ');
          SQL.Add(QuotedStr(qryPartQtyLines.FieldByName('ExtraSellDesc').AsString) + ', ');
          SQL.Add(QuotedStr(FloatToStr(qryPartQtyLines.FieldByName('Price1').AsFloat)) );
          (*SQL.Add(', '+ QuotedStr(FloatToStr(qryPartQtyLines.FieldByName('Price2').AsFloat)) + ', ');
          SQL.Add(QuotedStr(FloatToStr(qryPartQtyLines.FieldByName('Price1').AsFloat)) );*)
          SQL.Add(')');
          Execute;
        end;
        qryPartQtyLines.Next;
      end;
    end;
  except 
  end;

  try
    with qryPartQtyLines do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM tblforeignprice WHERE (PartsID = ' + qryParts.FieldByName('PartsID').AsString + ')');
      Open;
    end;

    if qryPartQtyLines.RecordCount > 0 then begin
      while not qryPartQtyLines.Eof do begin
        with qryNewPartLines do begin
          SQL.Clear;
          SQL.Add('INSERT HIGH_PRIORITY INTO tblforeignprice (GlobalRef, ForeignPriceID, PartsID, SupplierID, PartName, ');
          SQL.Add('Buy1, Buy2, Buy3, Price1, Price2, Price3, SupplierProductCode, SupplierProductName, ');
          SQL.Add('EditedFlag) VALUES ( NULL, NULL, ');
          SQL.Add(QuotedStr(IntToStr(iID)) + ', ' + QuotedStr(qryPartQtyLines.FieldByName('SupplierID').AsString) + ', ');
          SQL.Add(QuotedStr(qryPartQtyLines.FieldByName('PartName').AsString) + ', ');
          SQL.Add(QuotedStr(qryPartQtyLines.FieldByName('Buy1').AsString) + ', ');
          SQL.Add(QuotedStr(qryPartQtyLines.FieldByName('Buy2').AsString) + ', ');
          SQL.Add(QuotedStr(qryPartQtyLines.FieldByName('Buy3').AsString) + ', ');
          SQL.Add(QuotedStr(FloatToStr(qryPartQtyLines.FieldByName('Price1').AsFloat)) + ', ');
          SQL.Add(QuotedStr(FloatToStr(qryPartQtyLines.FieldByName('Price2').AsFloat)) + ', ');
          SQL.Add(QuotedStr(FloatToStr(qryPartQtyLines.FieldByName('Price3').AsFloat)) + ', ');
          SQL.Add(QuotedStr(qryPartQtyLines.FieldByName('SupplierProductCode').AsString) + ', ');
          SQL.Add(QuotedStr(qryPartQtyLines.FieldByName('SupplierProductName').AsString) + ', ');
          SQL.Add(QuotedStr(qryPartQtyLines.FieldByName('EditedFlag').AsString) + ')');
          Execute;
        end;
        qryPartQtyLines.Next;
      end;
    end;
  except 
  end;
end;

function TfrmBatchParts.CreateProductName(const MyList: TStringList): string;
var
  iX: integer;
begin
  Result := '';
  for iX := 0 to MyList.Count - 1 do begin
    Result := Result + MyList.Strings[iX]
  end;
end;

procedure TfrmBatchParts.btnSelectAll1Click(Sender: TObject);
begin
  inherited;
  wwDBGrid1.SelectAll;
end;

procedure TfrmBatchParts.btnSelectAll2Click(Sender: TObject);
begin
  inherited;
  wwDBGrid4.SelectAll;
end;

procedure TfrmBatchParts.btnSelectAll3Click(Sender: TObject);
begin
  inherited;
  wwDBGrid3.SelectAll;
end;

procedure TfrmBatchParts.btnSelectAll4Click(Sender: TObject);
begin
  inherited;
  wwDBGrid2.SelectAll;
end;

procedure TfrmBatchParts.btnSelectAll5Click(Sender: TObject);
begin
  inherited;
  wwDBGrid5.SelectAll;
end;

procedure TfrmBatchParts.cboPartName2CloseUp(Sender: TObject);
var
  aycPartBuffer: array[0..40] of char;
  iCharLength: cardinal;
begin
  inherited;
  iCharLength := 40 - (iEnabledPanels * 3) + 1;
  if  FastFuncs.StrLen(PChar(cboPartName.Text)) > iCharLength then begin
    bRequireAbbrev        := true;
    lblPartAbbrev.Enabled := true;
    edtPartAbbrev.Enabled := true;
    CommonLib.MessageDlgXP_Vista('You must shorten this part name to ' + IntToStr(iCharLength) +
      ' characters or less.  Please specify an abbreviated name for this product.', mtWarning, [mbOK], 0);
    StrPLCopy(aycPartBuffer, cboPartName.Text, iCharLength);
    edtPartAbbrev.Text := string(aycPartBuffer);
    SetControlFocus(edtPartAbbrev);
  end else begin
    bRequireAbbrev        := false;
    lblPartAbbrev.Enabled := false;
    edtPartAbbrev.Text    := '';
    edtPartAbbrev.Enabled := false;
  end;
end;

procedure TfrmBatchParts.BuildKnownBatchList;
begin
  qryBatchSaves.Close;
  qryBatchSaves.SQL.Clear;
  qryBatchSaves.SQL.Add('SELECT BatchName FROM tblbatchsaves ORDER BY BatchName;');
  qryBatchSaves.Open;
  cboKnownBatchs.Clear;
  while not qryBatchSaves.Eof do begin
    cboKnownBatchs.Items.Add(qryBatchSaves.FieldByName('BatchName').AsString);
    qryBatchSaves.Next;
  end;
end;

procedure TfrmBatchParts.cboKnownBatchsCloseUp(Sender: TObject);
var
  iX, iY, iWidth, iBaseLeft: integer;
  aryLefts: array[1..5] of integer;
  slPanelOrder: TStringList;
  slAttrib1: TStringList;
  slAttrib2: TStringList;
  slAttrib3: TStringList;
  slAttrib4: TStringList;
  slAttrib5: TStringList;
  strContent: string;
begin
  inherited;
  qryBatchSaves.Close;
  qryBatchSaves.SQL.Clear;
  qryBatchSaves.SQL.Add('SELECT * FROM tblbatchsaves WHERE (BatchName = ' + QuotedStr(cboKnownBatchs.Text) + ')');
  qryBatchSaves.Open;
  if qryBatchSaves.RecordCount < 1 then Exit;

  slPanelOrder := TStringList.Create;
  slAttrib1 := TStringList.Create;
  slAttrib2 := TStringList.Create;
  slAttrib3 := TStringList.Create;
  slAttrib4 := TStringList.Create;
  slAttrib5 := TStringList.Create;
  try
    strContent := qryBatchSaves.FieldByName('PanelOrder').AsString;
    ExtractStrings(['|'], [' '], PChar(strContent), slPanelOrder);

    strContent := qryBatchSaves.FieldByName('Attributes1').AsString;
    ExtractStrings(['|'], [' '], PChar(strContent), slAttrib1);

    strContent := qryBatchSaves.FieldByName('Attributes2').AsString;
    ExtractStrings(['|'], [' '], PChar(strContent), slAttrib2);

    strContent := qryBatchSaves.FieldByName('Attributes3').AsString;
    ExtractStrings(['|'], [' '], PChar(strContent), slAttrib3);

    strContent := qryBatchSaves.FieldByName('Attributes4').AsString;
    ExtractStrings(['|'], [' '], PChar(strContent), slAttrib4);

    strContent := qryBatchSaves.FieldByName('Attributes5').AsString;
    ExtractStrings(['|'], [' '], PChar(strContent), slAttrib5);

    for iX := 0 to slPanelOrder.Count - 1 do begin
      iY := FastFuncs.StrToInt(slPanelOrder.Strings[iX]);
      case iY of
        1: aryPanelOrder[ix + 1] := DNMPanel9;
        2: aryPanelOrder[ix + 1] := DNMPanel8;
        3: aryPanelOrder[ix + 1] := DNMPanel7;
        4: aryPanelOrder[ix + 1] := DNMPanel6;
        5: aryPanelOrder[ix + 1] := DNMPanel5;
      end;
    end;

    for iX := 1 to 5 do begin
      aryPanelInfo[iX].Panel := aryPanelOrder[iX];
      if aryPanelOrder[iX] = DNMPanel9 then begin
        aryPanelInfo[iX].Grid := wwDBGrid1;
        aryPanelInfo[iX].Query := qryCatagory1;
      end else if aryPanelOrder[iX] = DNMPanel8 then begin
        aryPanelInfo[iX].Grid := wwDBGrid4;
        aryPanelInfo[iX].Query := qryCatagory2;
      end else if aryPanelOrder[iX] = DNMPanel7 then begin
        aryPanelInfo[iX].Grid := wwDBGrid3;
        aryPanelInfo[iX].Query := qryCatagory3;
      end else if aryPanelOrder[iX] = DNMPanel6 then begin
        aryPanelInfo[iX].Grid := wwDBGrid2;
        aryPanelInfo[iX].Query := qryCatagory4;
      end else begin
        aryPanelInfo[iX].Grid := wwDBGrid5;
        aryPanelInfo[iX].Query := qryCatagory5;
      end;
    end;

    iBaseLeft := -4;

    iWidth := DNMPanel9.Width;

    for iX := 1 to 5 do begin
      aryLefts[iX] := iBaseLeft + ((iX - 1) * iWidth);
    end;

    for iX := 1 to 5 do begin
      aryPanelOrder[iX].Left := aryLefts[iX];
    end;

    aryPanelInfo[1].Grid.UnselectAll;
    for iX := 0 to slAttrib1.Count - 1 do begin
      aryPanelInfo[1].Query.First;

      while not aryPanelInfo[1].Query.Eof do begin
        if aryPanelInfo[1].Grid.GetFieldValue(0) = slAttrib1.Strings[iX] then begin
          aryPanelInfo[1].Grid.SelectRecord;
          aryPanelInfo[1].Query.Next;
          Continue;
        end;

        aryPanelInfo[1].Query.Next;
      end;
    end;

    aryPanelInfo[2].Grid.UnselectAll;
    for iX := 0 to slAttrib2.Count - 1 do begin
      aryPanelInfo[2].Query.First;

      while not aryPanelInfo[2].Query.Eof do begin
        if aryPanelInfo[2].Grid.GetFieldValue(0) = slAttrib2.Strings[iX] then begin
          aryPanelInfo[2].Grid.SelectRecord;
          aryPanelInfo[2].Query.Next;
          Continue;
        end;

        aryPanelInfo[2].Query.Next;
      end;
    end;

    aryPanelInfo[3].Grid.UnselectAll;
    for iX := 0 to slAttrib3.Count - 1 do begin
      aryPanelInfo[3].Query.First;

      while not aryPanelInfo[3].Query.Eof do begin
        if aryPanelInfo[3].Grid.GetFieldValue(0) = slAttrib3.Strings[iX] then begin
          aryPanelInfo[3].Grid.SelectRecord;
          aryPanelInfo[3].Query.Next;
          Continue;
        end;

        aryPanelInfo[3].Query.Next;
      end;
    end;

    aryPanelInfo[4].Grid.UnselectAll;
    for iX := 0 to slAttrib4.Count - 1 do begin
      aryPanelInfo[4].Query.First;

      while not aryPanelInfo[4].Query.Eof do begin
        if aryPanelInfo[4].Grid.GetFieldValue(0) = slAttrib4.Strings[iX] then begin
          aryPanelInfo[4].Grid.SelectRecord;
          aryPanelInfo[4].Query.Next;
          Continue;
        end;

        aryPanelInfo[4].Query.Next;
      end;
    end;

    aryPanelInfo[5].Grid.UnselectAll;
    for iX := 0 to slAttrib5.Count - 1 do begin
      aryPanelInfo[5].Query.First;

      while not aryPanelInfo[5].Query.Eof do begin
        if aryPanelInfo[5].Grid.GetFieldValue(0) = slAttrib5.Strings[iX] then begin
          aryPanelInfo[5].Grid.SelectRecord;
          aryPanelInfo[5].Query.Next;
          Continue;
        end;

        aryPanelInfo[5].Query.Next;
      end;
    end;

    EnableGrids;
  finally
    FreeAndNil(slPanelOrder);
    FreeAndNil(slAttrib1);
    FreeAndNil(slAttrib2);
    FreeAndNil(slAttrib3);
    FreeAndNil(slAttrib4);
    FreeAndNil(slAttrib5);
  end;
end;

procedure TfrmBatchParts.btnSaveClick(Sender: TObject);
var
  iX, iY, iCount: integer;
  strPanelOrder, strBatchName: string;
  strAttrib1, strAttrib2, strAttrib3, strAttrib4, strAttrib5: string;
  Selection1: TStringList;
  Selection2: TStringList;
  Selection3: TStringList;
  Selection4: TStringList;
  Selection5: TStringList;
  ThisSelection: TStringList;
begin
  DisableForm;
  try
    inherited;

    with qryBatchChecker do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT BatchName FROM tblBatchSaves WHERE (BAtchName = ' + QuotedStr(cboKnownBatchs.Text) + ')');
      Open;
      if RecordCount > 0 then begin
        CommonLib.MessageDlgXP_Vista('This Batch Save already exists! - Please choose a different name.', mtWarning, [mbOK, mbCancel], 0);
        Exit;
      end;
    end;

    iCount := 5;

    DisableGrids;

    Selection1 := TStringList.Create;
    Selection2 := TStringList.Create;
    Selection3 := TStringList.Create;
    Selection4 := TStringList.Create;
    Selection5 := TStringList.Create;
    try
      for iX := 1 to iCount do begin
        if not aryPanelInfo[iX].Query.Active then Continue;

        ThisSelection := nil;
        aryPanelInfo[iX].Query.First;

        while not aryPanelInfo[iX].Query.Eof do begin
          case iX of
            1: ThisSelection := Selection1;
            2: ThisSelection := Selection2;
            3: ThisSelection := Selection3;
            4: ThisSelection := Selection4;
            5: ThisSelection := Selection5;
          end;
          if aryPanelInfo[iX].Grid.IsSelectedRecord then begin
            ThisSelection.Add(aryPanelInfo[iX].Grid.GetFieldValue(0));
          end;

          aryPanelInfo[iX].Query.Next;
        end;
      end;

      if ((Selection1.Count = 0) and (Selection2.Count = 0) and (Selection3.Count = 0) and
        (Selection4.Count = 0) and (Selection5.Count = 0)) then begin
        CommonLib.MessageDlgXP_Vista('You cannot Save empty batch profiles.  Please make your selections from the appropriate catagories and retry again.',
          mtWarning, [mbOK], 0);
        EnableGrids;
        Exit;
      end;

      strBatchName := cboKnownBatchs.Text;

      strPanelOrder := '';
      for iX := 1 to 5 do begin
        iY := 0;
        if aryPanelOrder[iX] = DNMPanel9 then iY := 1;
        if aryPanelOrder[iX] = DNMPanel8 then iY := 2;
        if aryPanelOrder[iX] = DNMPanel7 then iY := 3;
        if aryPanelOrder[iX] = DNMPanel6 then iY := 4;
        if aryPanelOrder[iX] = DNMPanel5 then iY := 5;

        if iX = 1 then begin
          strPanelOrder := IntToStr(iY);
        end else begin
          strPanelOrder := strPanelOrder + '|' + IntToStr(iY);
        end;
      end;

      strAttrib1 := '';
      for iX := 0 to Selection1.Count - 1 do begin
        if iX = 0 then begin
          strAttrib1 := Selection1.Strings[iX];
        end else begin
          strAttrib1 := strAttrib1 + '|' + Selection1.Strings[iX];
        end;
      end;

      strAttrib2 := '';
      for iX := 0 to Selection2.Count - 1 do begin
        if iX = 0 then begin
          strAttrib2 := Selection2.Strings[iX];
        end else begin
          strAttrib2 := strAttrib2 + '|' + Selection2.Strings[iX];
        end;
      end;

      strAttrib3 := '';
      for iX := 0 to Selection3.Count - 1 do begin
        if iX = 0 then begin
          strAttrib3 := Selection3.Strings[iX];
        end else begin
          strAttrib3 := strAttrib3 + '|' + Selection3.Strings[iX];
        end;
      end;

      strAttrib4 := '';
      for iX := 0 to Selection4.Count - 1 do begin
        if iX = 0 then begin
          strAttrib4 := Selection4.Strings[iX];
        end else begin
          strAttrib4 := strAttrib4 + '|' + Selection4.Strings[iX];
        end;
      end;

      strAttrib5 := '';
      for iX := 0 to Selection5.Count - 1 do begin
        if iX = 0 then begin
          strAttrib5 := Selection5.Strings[iX];
        end else begin
          strAttrib5 := strAttrib5 + '|' + Selection5.Strings[iX];
        end;
      end;

      with qryBatchInsert do begin
        SQL.Clear;
        SQL.Add('INSERT HIGH_PRIORITY INTO tblbatchsaves (GlobalRef, ID, BatchName, PanelOrder, Attributes1, ');
        SQL.Add('Attributes2, Attributes3, Attributes4, Attributes5, Active, EditedFlag) ');
        SQL.Add('VALUES (NULL, NULL, ' + QuotedStr(strBatchName));
        SQL.Add(', ' + QuotedStr(strPanelOrder) + ', ' + QuotedStr(strAttrib1));
        SQL.Add(', ' + QuotedStr(strAttrib2) + ', ' + QuotedStr(strAttrib3));
        SQL.Add(', ' + QuotedStr(strAttrib4) + ', ' + QuotedStr(strAttrib5));
        SQL.Add(', ' + QuotedStr('T') + ', ' + QuotedStr('T'));
        SQL.Add(')');
        Execute;
      end;

      BuildKnownBatchList;

      EnableGrids;

      cboKnownBatchs.Text := strBatchName;
    finally
      FreeAndNil(Selection1);
      FreeAndNil(Selection2);
      FreeAndNil(Selection3);
      FreeAndNil(Selection4);
      FreeAndNil(Selection5);
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmBatchParts.cboPartNameNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string;
  var Accept: boolean);
begin
  inherited;
  Accept := false;
end;

procedure TfrmBatchParts.RefilterParts;
begin
    if edtSearchFilter.Text = '' then Exit;
    qryParts.Close;
    qryParts.SQL.Clear;
    qryParts.SQL.Add('SELECT * FROM tblparts WHERE (PARTNAME LIKE ' + QuotedStr(edtSearchFilter.Text + '%') +
      ' AND (PartType = ' + QuotedStr('OTHER') +
      ' OR PartType=' + QuotedStr('INV') + ' OR PartType=' + QuotedStr('NONINV') +
      ')) ORDER BY PartName;');
//  end else begin
//    qryParts.Close;
//    qryParts.SQL.Clear;
//    qryParts.SQL.Add('SELECT * FROM tblparts WHERE (PartType = ' + QuotedStr('OTHER') +
//      ' OR PartType=' + QuotedStr('INV') + ' OR PartType=' + QuotedStr('NONINV') +
//      ') ORDER BY PartName;');
//  end;

  qryParts.Open;
end;

procedure TfrmBatchParts.cboPartNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
var
  aycPartBuffer: array[0..40] of char;
  iCharLength: cardinal;
begin
  if not Modified then Exit;
  inherited;
  iCharLength := 40 - (iEnabledPanels * 3) + 1;
  if  FastFuncs.StrLen(PChar(cboPartName.Text)) > iCharLength then begin
    bRequireAbbrev        := true;
    lblPartAbbrev.Enabled := true;
    edtPartAbbrev.Enabled := true;
    CommonLib.MessageDlgXP_Vista('You must shorten this part name to ' + IntToStr(iCharLength) +
      ' characters or less.  Please specify an abbreviated name for this product.', mtWarning, [mbOK], 0);
    StrPLCopy(aycPartBuffer, cboPartName.Text, iCharLength);
    edtPartAbbrev.Text := string(aycPartBuffer);
    SetControlFocus(edtPartAbbrev);
  end else begin
    bRequireAbbrev        := false;
    lblPartAbbrev.Enabled := false;
    edtPartAbbrev.Text    := '';
    edtPartAbbrev.Enabled := false;
  end;
end;

procedure TfrmBatchParts.edtSearchFilterExit(Sender: TObject);
begin
  inherited;
  if edtSearchFilter.Text = '' then Exit;
  RefilterParts;
  if qryParts.RecordCount = 0 then begin
    CommonLib.MessageDlgXP_Vista('Your Search Criteria yielded no results - Please respecify search criteria.', mtWarning, [mbOK], 0);
    if (edtSearchFilter.Visible) and (edtSearchFilter.Enabled) then begin
      SetControlFocus(edtSearchFilter);
      edtSearchFilter.SelectAll;
    end;
    Exit;
  end;

  edtSearchFilter.Visible := false;
  cboPartName.Visible := true;
  Label2.Caption := 'Selected Product (F6):';
  cboPartName.DropDown;
end;

procedure TfrmBatchParts.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  inherited;
    if Key = VK_F6 then begin
      if not qryParts.Active then Exit;
      if edtSearchFilter.Visible then begin
        RefilterParts;
        edtSearchFilter.Visible := false;
        cboPartName.Visible := true;
        Label2.Caption := 'Selected Product (F6):';
      end else begin
        cboPartName.Visible := false;
        edtSearchFilter.Visible := true;
        Label2.Caption := 'Enter Search Criteria (F6):';
      end;
    end;
//  end;
end;

initialization
  RegisterClassOnce(tfrmBatchParts);
end.
