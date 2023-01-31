unit frmHowToEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, HowToUtils, ERPCustomStepComponent, ERPStepEdit, Shader, DNMPanel,
  DNMSpeedButton, wwdblook, Wwdatsrc, Mask, wwdbedit, Wwdotdot, Wwdbcomb,
  ComCtrls, Grids, Wwdbigrd, Wwdbgrid;

type
  TfmHowToEdit = class(TBaseInputGUI)
    qryHowTo: TERPQuery;
    pnlBody: TDNMPanel;
    pnlBottom: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnAdd: TDNMSpeedButton;
    pnlTop: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    edtHowToHeader: TEdit;
    btnCancel: TDNMSpeedButton;
    ScrollBox1: TScrollBox;
    qryStaff: TERPQuery;
    dsStaff: TwwDataSource;
    cbCompany: TComboBox;
    cbStaff: TComboBox;
    OpenDialog: TOpenDialog;
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure edtHowToHeaderChange(Sender: TObject);
    procedure panelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    fSteps: THowToStepList;
    fProcessing: boolean;
    fSenderEdit: TStepEdit;
    lStep : TStepEdit;

    { Private declarations }
    function EditSize(aEdit : TEdit; const aText : string) : TSize;
    procedure FormClassClick(Sender : TObject);
    procedure FlowIdClick(Sender : TObject);
    procedure DeleteButtonClick(Sender : TObject);
    procedure DoNotify(ACancelled : boolean);
    procedure StepNoChange(Sender : TObject);
    procedure VideoClick(Sender : TObject);
    procedure ChooseVideo(Sender: TwwDbGrid);
    procedure locatevideo(Sender: TObject);
  protected
    procedure LoadData;
    procedure DrawHeader;
    procedure RecalcStepNumbers;
    procedure LoadCombos;
    procedure FormClassSelected(Sender : TObject);
    property Steps : THowToStepList read fSteps write fSteps;
    property Processing : boolean read fProcessing write fProcessing;
    property SenderEdit : TStepEdit read fSenderEdit write fSenderEdit;
  public
    { Public declarations }
    constructor Create(AOwner : TComponent);override;
    destructor Destroy; override;
  end;

implementation

{$R *.dfm}
uses
  CommonLib, FormFactory, frmButtonsList, HowToWorkflows, AppEnvironment, ObserverListObj,
  BaseListingForm, CommonFormLib, ERPVideos, tcDataUtils;

type
  TMoveHack = class(TControl);

function StepCompare(Item1, Item2: Pointer): Integer;
begin
  if TStepEdit(Item1).Visible and not (TStepEdit(Item2).Visible) then
    Result := -1
  else if not(TStepEdit(Item1).Visible) and TStepEdit(Item2).Visible then
    Result := 1
  else if TStepEdit(Item1).Top > TStepEdit(Item2).Top then
    Result := 1
  else if TStepEdit(Item1).Top < TStepEdit(Item2).Top then
    Result := -1
  else
    Result := 0;
end;

procedure TfmHowToEdit.btnAddClick(Sender: TObject);
var
  lStep : TStepEdit;
begin
  inherited;
  lStep := TStepEdit.Create(ScrollBox1);
  Steps.Add(lSTep);
  if Steps.Count > 1 then
  begin
    lStep.Top := TCustomStepDisplay(STeps[Steps.Count-2]).Top + TCustomStepDisplay(STeps[Steps.Count-2]).Height + 2;
    lStep.StepNo := TCustomStepDisplay(STeps[Steps.Count-2]).StepNo + 1;
  end
  else
    lStep.StepNo := 1;
  lStep.HowToId := Steps.HowToId;
  lStep.Align := alTop;
  lStep.Parent := ScrollBox1;

  lSTep.OnMouseDown := panelMouseDown;
  lStep.OnDeleteButtonClick :=  DeleteButtonClick;
  lStep.OnFormClassClick := FormClassClick;
  lSTep.OnFlowIdClick := FlowIdClick;
  lStep.OnStepNoChange := StepNoChange;
  lStep.OnVideoClick := VideoClick;
  ScrollBox1.Invalidate;

  lStep.SetFocus;

  Invalidate;
end;

procedure TfmHowToEdit.btnCancelClick(Sender: TObject);
begin
  inherited;
  DoNotify(true);
  FreeAndNil(fSteps);
  if fsModal in FormState then
    ModalResult := mrCancel
  else
    Close;
end;

procedure TfmHowToEdit.btnSaveClick(Sender: TObject);
var
  lForm : TBaseListingGUI;
begin
  inherited;
  Steps.Header := edtHowToHeader.Text;
  Steps.AuthorName := cbStaff.Text; //.Items[cbStaff.ItemIndex];
  Steps.CompanyName := cbCompany.Text;
  Steps.Save;
  lForm := TBaseListingGUI(FindExistingComponent('THowToListGUI'));
  if assigned(lForm) then
    lForm.UpdateMe;
  KeyId := Steps.HowToId;
  DoNotify(false);
  if fsModal in FormState then
    ModalResult := mrOK
  else
   Close;
end;

constructor TfmHowToEdit.Create(AOwner: TComponent);
begin
  inherited;

end;

procedure TfmHowToEdit.DeleteButtonClick(Sender: TObject);
begin
//
  if (Sender is TStepEdit)  then
  begin
    Steps.Delete((Sender as TStepEdit));
    RecalcStepNumbers;
  end;
end;

destructor TfmHowToEdit.Destroy;
begin
  Steps.Free;
  inherited;
end;

procedure TfmHowToEdit.DoNotify(ACancelled: boolean);
var
  lSavedNotifyList : boolean;
begin
  lSavedNotifyList := ObserverList.DisableNotifyLists;
  ObserverList.DisableNotifyLists := False;
  Notify(ACancelled);
  ObserverList.DisableNotifyLists := lSavedNotifyList;
end;

procedure TfmHowToEdit.DrawHeader;
var
  lSize : TSize;
begin
    if Steps.Header <> '' then
    begin
      lsize := EditSize(edtHowToHeader, Steps.Header);
      pnlTitle.Width := lsize.cx + 16;
      edtHowToHeader.Text := Steps.Header;
    end
    else
    begin
      lsize := EditSize(edtHowToHeader, edtHowToHeader.Text);
      pnlTitle.Width := lsize.cx + 16;
    end;

    pnlTitle.Left := (Self.ClientWidth - pnlTitle.Width) div 2;
end;

function TfmHowToEdit.EditSize(aEdit : TEdit; const aText : string) : TSize;
var
  lCanvas : TCanvas;
begin
  lCanvas := TCanvas.Create;
  try
    lCanvas.Handle := GetDC(aEdit.Handle);
    lCanvas.Font := aEdit.Font;
    Result := lCanvas.TextExtent(aText + 'W');
  finally
    ReleaseDC(aEdit.Handle, lCanvas.Handle);
    lCanvas.Free;
  end;
end;

procedure TfmHowToEdit.edtHowToHeaderChange(Sender: TObject);
begin
  inherited;
//
  if not (fsShowing in FormState) then
    Steps.Header := edtHowToHeader.Text;
  DrawHeader;
end;

procedure TfmHowToEdit.FlowIdClick(Sender: TObject);
var
  lForm : TfrmHowToWorkflows;
  lSTep : TStepEdit;
begin
//
  if Sender is TStepEdit then
    lStep := sender as TStepEdit
  else
    exit;

  lForm := TfrmHowToWorkflows.Create(nil);
  try
    if lForm.ShowModal = mrOK then
    begin
      lStep.WorkFlowId := lForm.WorkflowId;
      lStep.WorkFlowText := lForm.WorkFlowDescription;
    end;
  finally
    lForm.Free;
  end;

end;

procedure TfmHowToEdit.FormClassClick(Sender: TObject);
var
  lForm : TfmButtonsListFrm;
begin
//
  SenderEdit := Sender as TStepEdit;
  lForm := TfmButtonsListFrm.Create(nil);
  try
    lForm.Left := Self.Left + Self.Width + 4;
    lForm.OnSelected := FormClassSelected;
    if lForm.ShowModal = mrOK then
    begin
      if Sender is TStepEdit then
      begin
        (Sender as TStepEdit).SetAction(lForm.Text, lForm.ActionCaption, lForm.GlyphIndex);
      end;
    end;
  finally
    lForm.Free;
    SenderEdit := nil;
  end;
end;

procedure TfmHowToEdit.FormClassSelected(Sender: TObject);
var
  lForm : TfmButtonsListFrm;
begin
  if Assigned(SenderEdit) then
  begin
    lForm :=  Sender as TfmButtonsListFrm;
    SenderEdit.SetAction(lForm.Text, lForm.ActionCaption, lForm.GlyphIndex);
    SenderEdit.FormGlyph := lForm.ActionGlyph;
  end;
end;

procedure TfmHowToEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  ACtion := caFree;
end;

procedure TfmHowToEdit.FormShow(Sender: TObject);
begin
  inherited;
//  cbCompany.Parent := Self;
  LoadData;
  LoadCombos;
  cbStaff.Left := 16;
  cbCompany.Left := pnlTop.Width - cbCompany.Width - 16;
end;

procedure TfmHowToEdit.LoadCombos;
var
  idx : integer;
  lStaff : TStringList;
  lCompany : TStringList;

  procedure SetValue(const aValue : string; lList : TStringList);
  begin
    if aValue <> '' then
      lList.Add(aValue);
  end;

begin
  lStaff := TStringList.Create;
  lStaff.Sorted := true;
  lStaff.Duplicates := dupIgnore;
  lStaff.CaseSensitive := false;

  lCompany := TStringList.Create;
  lCompany.Sorted := true;
  lCompany.Duplicates := dupIgnore;
  lCompany.CaseSensitive := false;

  try
    qryStaff.Close;
    qryStaff.SQL.Clear;
    qryStaff.SQL.Add('select distinct employeename from tblEmployees');
    qryStaff.Open;

    qryStaff.First;
    while not qryStaff.Eof  do
    begin
      SetValue(qryStaff.Fields[0].asString, lStaff);
      qryStaff.Next;
    end;

    qryStaff.Close;
    qryStaff.SQL.Clear;
//    qryStaff.SQL.Add('select distinct authorname from tblHowTo where authorname <> ""');
    qryStaff.SQL.Add('select AuthorName, CompanyName from tblHowTo');

    qryStaff.Open;
    while not qryStaff.Eof  do
    begin
      SetValue(qryStaff.Fields[0].asString, lStaff);
      SetValue(qryStaff.Fields[1].asString, lCompany);
      qryStaff.Next;
    end;

    SetValue(AppEnv.CompanyInfo.CompanyName, lCompany);

    qryStaff.Close;

    // Set staff index
    if Steps.AuthorName <> '' then
    begin
      idx := lStaff.IndexOf(Steps.AuthorName);
      if idx = -1 then
      begin
        lStaff.Add(Steps.AuthorName);
        idx := lStaff.IndexOf(Steps.AuthorName);
      end;
      cbStaff.Items.Text := lStaff.Text;
      cbStaff.ItemIndex := idx;
    end
    else
    begin
      cbStaff.Items.Text := lStaff.Text;
      cbStaff.ItemIndex := 0;
    end;

    // Set Company index
    if Steps.CompanyName = '' then
      Steps.CompanyName := AppEnv.CompanyInfo.CompanyName;
    idx := lCompany.IndexOf(Steps.CompanyName);
    if idx = -1 then
    begin
      lCompany.Add(Steps.CompanyName);
      idx := lCompany.IndexOf(Steps.CompanyName);
    end;
    cbCompany.Items.Text := lCompany.Text;
    cbCompany.ItemIndex := idx;

  finally
    lStaff.Free;
    lCompany.Free;
  end;
end;

procedure TfmHowToEdit.LoadData;
var
  idx : integer;
  lStep : TCustomStepDisplay;
begin
  if KeyId > 0 then
  begin

    Steps := THowToStepList.Create(KeyId);
    DrawHeader;

    Steps.Load(TStepEdit, ScrollBox1);

    for idx := 0 to Steps.Count - 1 do
    begin
      lStep := TCustomStepDisplay(Steps[idx]);
      if idx > 0 then
        lStep.Top := TCustomStepDisplay(Steps[idx - 1]).Top + TCustomStepDisplay(Steps[idx - 1]).Height + 2;
      lStep.Parent := ScrollBox1;
      lStep.Align := alTop;

      lStep.OnMouseDown := panelMouseDown;
      TStepEdit(lStep).OnFormClassClick := FormClassClick;
      TStepEdit(lSTep).OnFlowIdClick := FlowIdClick;
      TStepEdit(lStep).OnDeleteButtonClick := DeleteButtonClick;
      TStepEdit(lStep).OnStepNoChange := StepNoChange;
      TStepEdit(lStep).OnVideoClick := VideoClick;
    end;
  end
  else
  begin
    Steps := THowToStepList.Create(0);
    btnAddClick(Self);
    edtHowToHeader.Text := 'Enter the Header Here';
    DrawHeader;
  end;
end;

procedure TfmHowToEdit.panelMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const
  SC_DragMove = $F012;
begin
  inherited;
  if (ssCtrl in Shift) and (Button = mbLeft) and (Sender is TStepEdit) then
  begin
    ReleaseCapture;
    (Sender as TPanel).BringToFront;
    (Sender as TPanel).Perform(WM_SysCommand, SC_DragMove, 0);
    RecalcStepNumbers;
  end;
end;


procedure TfmHowToEdit.RecalcStepNumbers;
var
  idx : integer;
  num : integer;
begin
    Steps.Sort(StepCompare);
    num := 1;
    for idx := 0 to Steps.Count - 1 do
    begin
      TStepEdit(Steps[idx]).StepNo := num;
      if idx = 0 then
        TStepEdit(Steps[idx]).Top := 5
      else
        TStepEdit(Steps[idx]).Top := TStepEdit(Steps[idx-1]).Top + TStepEdit(Steps[idx-1]).Height + 2;
      num := num + 1;
    end;
end;


procedure TfmHowToEdit.StepNoChange(Sender: TObject);
var
  idx : integer;
  lSTep : TStepEdit;
  lStep1 : TStepEdit;
begin
  if not (Sender is TStepEdit) then
    exit;
  if Processing then
    exit;
  processing := true;
  try
    lStep := Sender as TSTepEdit;

    idx := Steps.IndexOf(Sender);
    STeps[idx] := nil;
    Steps.Pack;
    // if spin edit was cleared (backspace for example), the value is 1, but text is empty.
    // Need to re-set so it will display 1
    if (lStep.StepNo = 1) then
      lStep.StepNo := 1;
    if lStep.StepNo > Steps.Count then
      lStep.StepNo := STeps.Count + 1;
    Steps.Insert(lStep.StepNo - 1, lStep);
    // Need to cater for the list scrolled down - so that first step is invisible
    if Steps.Count = 1 then
    begin
      lStep.Top := 5;
      exit;
    end;

    if lStep.StepNo = Steps.Count then
      lStep.Top := TStepEdit(Steps[Steps.Count - 2]).Top + TStepEdit(Steps[Steps.Count - 2]).Height + 5
    else if lStep.StepNo = 1 then
    begin
      lStep.Top := TStepEdit(Steps[1]).Top - TStepEdit(Steps[1]).Height - 2;
    end;

      for idx := 1 to Steps.Count - 1 do
      begin
        lStep1 := TStepEdit(Steps[idx]);
        lSTep1.StepNo := idx + 1;
        lStep1.Top := TStepEdit(Steps[idx-1]).Top + TStepEdit(Steps[idx-1]).Height + 5;
      end;
  finally
    Processing := false;
  end;
end;
procedure TfmHowToEdit.ChooseVideo(Sender: TwwDbGrid);
begin
  if twwdbgrid(Sender).Datasource.Dataset.findfield('filename') <> nil then begin
    lStep.VideoFile := twwdbgrid(Sender).Datasource.Dataset.fieldbyname('VideoType').asString;
    lStep.VideoText :=twwdbgrid(Sender).Datasource.Dataset.fieldbyname('PageCaption').asString;
  end;
end;
procedure TfmHowToEdit.locatevideo(Sender: TObject);
begin
  if sender is TERPVideosGUI then
    TERPVideosGUI(Sender).VideoID := VideoID(lStep.VideoText , lStep.VideoFile ) ;
end;
procedure TfmHowToEdit.VideoClick(Sender: TObject);
begin
  lStep := Sender as TStepEdit;
  OpenERPListFormSingleselectModal('TERPVideosGUI' , ChooseVideo ,locatevideo );
(*var
  lFile : string;
  lLine : string;
  lStep : TStepEdit;
  idx : integer;
begin

  if not(Sender is TStepEdit) then
    exit;
  lStep := Sender as TStepEdit;
  if lStep.VideoFile <> '' then
    OpenDialog.FileName := lStep.VideoFile;
  if OpenDialog.Execute then
  begin
    lFile := OpenDialog.FileName;
    if SameText(ExtractFileExt(lFile), '.mp4') then
    begin
      if MessageDlgXP_Vista('Be Careful: If Your Media Player Vesion Less Than 12, You Cannot Play MP4 Files.'#13#10+
                    'Are You Sure You Want to Use This File?', mtWarning, [MBOK, MBCANCEL], 0) = mrCancel then

        exit;
    end;
    lStep.VideoFile := lFile;
    lFile := ExtractFileName(lFile);
    for idx := length(lFile) downto 1 do
    begin
      if lFile[idx] = '.' then
      begin
        lFile := copy(lFile, 1, idx - 1);
        break;
      end;
    end;
    lLine := '';
    for idx := 1 to Length(lFile) do
      if not CharInSet(lFile[idx], ['a'..'z', 'A'..'Z', '0'..'9']) then
        lLine := lLine + ' '
      else if (idx>1) and (CharInSet(lFile[idx], ['A'..'Z'])) then
      begin
        lLine := lLine + ' ' + lFile[idx]
      end
      else
        lLine := lLine + lFile[idx];

    lStep.VideoText := lLine;
  end;*)

end;

initialization
  RegisterClassOnce(TfmHowToEdit);
  FormFact.RegisterMe(TfmHowToEdit, 'TfmHowTo_*=HowToId');
end.
