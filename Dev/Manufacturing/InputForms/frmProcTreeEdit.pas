unit frmProcTreeEdit;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 12/06/07 1.00.01  DSP - Initial version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DB, DBAccess, MyAccess,ERPdbComponents,
  SelectionDialog, AppEvnts, ExtCtrls, TreeFrame, DNMPanel, DNMSpeedButton,
  StdCtrls, Shader, ImgList, MemDS, ProgressDialog;

type
  TfmProcTreeEdit = class(TBaseInputGUI)
    pnlMain: TDNMPanel;
    timrefresh: TTimer;
    DNMPanel1: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    lblLockStatus: TLabel;
    btnMode: TDNMSpeedButton;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    chkHide: TCheckBox;
    cmdPrint: TDNMSpeedButton;
    chkChooseRpt: TCheckBox;
    tmr: TTimer;
    btnrefresh: TButton;
    tmrOpenTreeFromSalesOrder: TTimer;
    btnAttachments: TDNMSpeedButton;

    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnModeClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure timrefreshTimer(Sender: TObject);
    procedure chkHideClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure tmrTimer(Sender: TObject);
    procedure btnrefreshClick(Sender: TObject);
    procedure tmrOpenTreeFromSalesOrderTimer(Sender: TObject);
    procedure btnAttachmentsClick(Sender: TObject);
  private
    FTree: TframeTree;
    fsReadonlyMsg: String;
    fbAutoPopup: boolean;
    fbOpenSmartOrderWhenclosed :Boolean;
    fiTreecolumn: Integer;
    fbShowProductselection: Boolean;
    function InTransSave: boolean;
    procedure setReadonlyMsg(const Value: String);
    procedure RefreshTreeHeader;
    procedure setAutoPopup(const Value: boolean);
    procedure TreeFrameEventProc(const Value: TTreeFrameEvent);
    Procedure ReadGuiPrefs;
    Procedure WriteGuiPrefs;
  Protected
    function GetReportTypeID: integer; Override;
  public
    procedure SaveData;
    property Tree: TframeTree read FTree;
    Property ReadonlyMsg:String read fsReadonlyMsg Write setReadonlyMsg;
    Property AutoPopup:boolean read fbAutoPopup write setAutoPopup;
    Property OpenSmartOrderWhenclosed:Boolean read fbOpenSmartOrderWhenclosed write fbOpenSmartOrderWhenclosed;
    Property Treecolumn :Integer read fiTreecolumn Write fiTreecolumn;
    Property ShowProductselection :Boolean read fbShowProductselection write fbShowProductselection;

  end;

var
  fmProcTreeEdit: TfmProcTreeEdit;

implementation

uses
  CommonLib, CommonDBLib, FastFuncs, DNMLib, AppEnvironment, JSONObject, BusObjNDSBase,
  tcDataUtils, frmAttachments;

{$R *.dfm}
procedure TfmProcTreeEdit.TreeFrameEventProc(const Value : TTreeFrameEvent);
begin
  if Value = tfeSaveandOpenSmartOrder then begin
    if not InTransSave then exit;
    OpenSmartOrderWhenclosed := TRue;
    ModalResult := mrOK;
  end;
end;

procedure TfmProcTreeEdit.WriteGuiPrefs;
begin
  GuiPrefs.Node['Options.ChooseReport'].asBoolean := chkChooseRpt.checked;
end;

procedure TfmProcTreeEdit.FormCreate(Sender: TObject);
begin
  inherited;
  ShowProductselection := False;
  fbOpenSmartOrderWhenclosed := False;
  FTree := TframeTree.Create(Self);
  FTree.TreeFrameEventProc :=   TreeFrameEventProc;
  FTree.Parent := pnlMain;
  FTree.AlignWithMargins := True;
  FTree.Align := alClient;
  FTree.Margins.Left:= 3;
  FTree.Margins.right:= 3;
  FTree.Margins.top:= 3;
  FTree.Margins.bottom:= 3;
  FTree.vstProcessPart.TabOrder := 0;
  (*TitleShader.FromColor := GetGradientColor(ClassName).Color;
  TitleShader.ToColorMirror := TitleShader.FromColor;*)
  fsReadonlyMsg := '';
  fbAutoPopup:= False;;
  fiTreecolumn := -1;
  //Logeventtime('FormCreate');

end;

procedure TfmProcTreeEdit.btnAttachmentsClick(Sender: TObject);
var
  tmpComponent: TComponent;
begin
  if not(Assigned(FTree)) then exit;
  if not(Assigned(FTree.TreeNodeRoot)) then exit;
  if FTree.TreeNodeRoot.SaleLineId =0 then exit;

  tmpComponent := TfmAttachments(GetComponentByClassName('TfmAttachments', False, self));
  if not Assigned(tmpComponent) then Exit;
  with TfmAttachments(tmpComponent) do begin
    if assigned(Tree.TransConnection)  then
      DBConnection := Tree.TransConnection
    else DBConnection := Self.MyConnection;
    AttachObserver(Self);
    TableName := 'tblsaleslines';
    TableId := FTree.TreeNodeRoot.SaleLineId;
    DragnDropping :=true;
    PopulateListView;
    (*FormStyle := fsMDIChild;
    BringToFront;*)
    Showmodal;
  end;
end;

procedure TfmProcTreeEdit.btnCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TfmProcTreeEdit.btnSaveClick(Sender: TObject);
begin
  inherited;
  if not InTransSave then begin
    exit;
  end;
  ModalResult := mrOK;
end;

procedure TfmProcTreeEdit.chkHideClick(Sender: TObject);
begin
  inherited;
  if screen.ActiveControl = chkHide then Appenv.employee.OpenTreeFromSalesOrder := not(chkHide.checked);
end;

procedure TfmProcTreeEdit.cmdPrintClick(Sender: TObject);
var
  SQL:String;
  Json :TJsonObject ;
  function Mastertype:String ;
  begin
    if ftree.RootNodeData.MasterType = mtProduct then result :=' and PT.Mastertype = "mtProduct"'
    else result :=' and PT.Mastertype <> "mtProduct"'
  end;
begin
  inherited;

  if REportToPrint = '' then
    if not chkChooseRpt.Checked then ReportToPrint := tcdatautils.GetDefaultReport(GetReportTypeID);
    if chkChooseRpt.Checked or (ReportToPrint = '') then begin
      LoadReportTypes;
      if dlgReportSelect.Execute then
        ReportToPrint := dlgReportSelect.SelectedItems.Text;
    end;

  if ReportToPrint = '' then exit;


  SQL:= '~|||~Where PT.MasterId = ' + inttostr(ftree.RootNodeData.MasterId)+ MasterType +  ' order by BOMSequencedown'+
        '~|||~Where PT.MasterId = ' + inttostr(ftree.RootNodeData.MasterId)+ MasterType +
        '~|||~Where PT.MasterId = ' + inttostr(ftree.RootNodeData.MasterId)+ MasterType +  '  Order by ProcessStepSeq';
  Json :=JO;
  try
      Json.O['1'].S['master']:= 'TreeDetails';
      Json.O['1'].S['detail']:= 'Pictures';
      Json.O['1'].S['masterfields']:= 'ProctreeId';
      Json.O['1'].S['detailfields']:= 'PT.ProctreeId';

      Json.O['2'].S['master']:= 'TreeDetails';
      Json.O['2'].S['detail']:= 'Processes';
      Json.O['2'].S['masterfields']:= 'ProctreeId';
      Json.O['2'].S['detailfields']:= 'PT.ProctreeId';
      fbReportSQLSupplied:= False;
      PrintTemplateReport(ReportToPrint, SQL, not(Devmode) and not(appenv.Employee.ShowPreview) , 1 , Json);
  finally
    Json.free;
  end;

end;

procedure TfmProcTreeEdit.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
//  FTree.TreeNodeRoot.DoOrder;
end;

procedure TfmProcTreeEdit.FormShow(Sender: TObject);
var
  fbcheckOpenTreeFromSalesOrder:Boolean;
begin
  //Logeventtime('FormShow');
  fbcheckOpenTreeFromSalesOrder := False;
  btnrefresh.visible := Devmode;
  DisableForm;
  try
    inherited;
    BeginTransaction;
    btnSave.Enabled:= true;
    SetControlFocus(FTree.vstProcessPart);
    FTree.TreeReadOnly:= AccessLevel = 5;
    ReadGuiPrefs;
    Tmr.enabled := Treecolumn >=0;
    if ShowProductselection then begin
      ShowProductselection := False;
      FTree.MultiSelectProduct;
      FTree.vstProcessPart.Refresh;
      fbCheckOpenTreeFromSalesOrder := True;

    end;
    (*////// {BOM speeed Fix} *)FTree.TreeNodeRoot.Savenocheck;
  finally
    EnableForm;
    if fbcheckOpenTreeFromSalesOrder and not(Appenv.employee.OpenTreeFromSalesOrder) then tmrOpenTreeFromSalesOrder.enabled:= True
    else timrefresh.enabled:= True;
  end;
  //Logeventtime('FormShow-Done');
end;
function TfmProcTreeEdit.GetReportTypeID: integer;
begin
  REsult := 137;
end;

procedure TfmProcTreeEdit.ReadGuiPrefs;
begin
  ActivateGuiPrefs(true);
    chkChooseRpt.checked := GuiPrefs.Node['Options.ChooseReport'].asBoolean ;
end;

Procedure TfmProcTreeEdit.RefreshTreeHeader;
var
  ctr:Integer;
begin
  for ctr := 0 to ftree.vstProcessPart.header.columns.Count - 1 do
    ftree.vstProcessPart.header.columns[ctr].Width :=ftree.vstProcessPart.header.columns[ctr].Width+10;

  for ctr := 0 to ftree.vstProcessPart.header.columns.Count - 1 do
    ftree.vstProcessPart.header.columns[ctr].Width :=ftree.vstProcessPart.header.columns[ctr].Width-10;
end;
procedure TfmProcTreeEdit.btnModeClick(Sender: TObject);
begin
  inherited;
  if Sysutils.SameText(btnMode.Caption, 'Template') then begin
    btnMode.Caption := 'Input';
    FTree.TreeMode := tmTemplate;
  end
  else begin
    btnMode.Caption := 'Template';
    FTree.TreeMode := tmInput;
  end;
end;

procedure TfmProcTreeEdit.btnrefreshClick(Sender: TObject);
begin
  inherited;
  FTree.vstProcessPart.Refresh;
end;

procedure TfmProcTreeEdit.SaveData;
begin
  FTree.TreeNodeRoot.CalcPrice;
  FTree.TreeNodeRoot.BuildDetails;
  FTree.SaveTree;
end;

procedure TfmProcTreeEdit.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  Response: TModalResult;
begin
  inherited;
  FTree.vstProcessPart.EndEditNode;

  if (FTree.TreeNodeRoot.TreeDirty or FTree.PopupModified) and (ModalResult <> mrOK) then begin
    Response := CommonLib.MessageDlgXP_Vista('Save any changes made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);

    case Response of
      mrYes:
      begin
        if not InTransSave then begin
          CanClose:= false;
          exit;
        end;
        ModalResult := mrOK;
      end;

      mrNo:
      begin
        if Assigned(TransConnection) and TransConnection.InTransaction then
          TransConnection.Rollback;
        FTree.TreeNodeRoot.Children.Clear;
        FTree.TreeNodeRoot.LoadTree;
        ModalResult := mrCancel;
      end;

      mrCancel:
      begin
        CanClose := False;
      end;
    end;
  end;
end;

procedure TfmProcTreeEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  WriteGuiPrefs;
  if Assigned(TransConnection) and TransConnection.InTransaction then
    TransConnection.Rollback;
end;

function TfmProcTreeEdit.InTransSave: boolean;
begin
  result:= true;
    if FTree.TreeNodeRoot.Children.Count =0 then
      if MessageDlgXP_Vista('The Tree is Deleted. Saving Will Delete the Tree and and save as a Simple Product. Do you wish to continue?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then begin
        REsult := False;
        exit;
      end;

  if Assigned(TransConnection) and TransConnection.InTransaction then begin
    if FTree.TreeNodeRoot.Save then
      TransConnection.Commit
    else
      result:= false;
  end;
end;

procedure TfmProcTreeEdit.setAutoPopup(const Value: boolean);
begin
  fbAutoPopup := Value;
  chkHide.Visible := Value;
end;

procedure TfmProcTreeEdit.setReadonlyMsg(const Value: String);
begin
  fsReadonlyMsg := Value;
  if Value <> '' then begin
      lblLockStatus.visible := True;
      lblLockStatus.Caption := Value;
  end;
end;
procedure TfmProcTreeEdit.timrefreshTimer(Sender: TObject);
begin
  inherited;
   RefreshTreeHeader;
  timrefresh.enabled := False;
end;

procedure TfmProcTreeEdit.tmrOpenTreeFromSalesOrderTimer(Sender: TObject);
begin
  inherited;
  if not(Appenv.employee.OpenTreeFromSalesOrder) then btnSave.click;
  tmrOpenTreeFromSalesOrder.enabled:= False;
end;

procedure TfmProcTreeEdit.tmrTimer(Sender: TObject);
begin
  inherited;
  try
  if Treecolumn >=0 then begin
    SetControlFocus(FTree.vstProcessPart);
    FTree.Treecolumn[FTree.vstProcessPart.RootNode.FirstChild] := Treecolumn;
    Treecolumn := -1;
    tmr.Enabled := False;
  end;
  Except

  end;
end;

initialization
  RegisterClassOnce(TfmProcTreeEdit);
finalization
  UnregisterClass(TfmProcTreeEdit);
end.
