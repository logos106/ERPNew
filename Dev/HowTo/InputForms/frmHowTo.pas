unit frmHowTo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, HowToUtils, ERPCustomStepComponent, ERPStepDisplay, Shader, DNMPanel,
  DNMSpeedButton, ActnList;

type
  TfmHowTo = class(TBaseInputGUI)
    qryHowTo: TERPQuery;
    pnlBody: TDNMPanel;
    pnlTop: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    pnlBottom: TDNMPanel;
    btnEdit: TDNMSpeedButton;
    btnOK: TDNMSpeedButton;
    ScrollBox1: TScrollBox;
    btnAddToPage: TDNMSpeedButton;
    DNMSpeedButton1: TDNMSpeedButton;
    lblCompany: TLabel;
    lblAuthor: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnEditClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnAddToPageClick(Sender: TObject);
  private
    fSteps: THowToStepList;
    { Private declarations }
  protected
    procedure LoadData;
    procedure FlowButtonClick(Sender : TObject);
    procedure FormButtonClick(Sender : TObject);
    procedure VideoButtonClick(Sender : TObject);
    procedure SetKeyId(const Value: integer); override;
    function RunAction(const aActionName : string; aList : TActionList) : boolean;
    property Steps : THowToStepList read fSteps write fSteps;
  public
    { Public declarations }
    constructor Create(AOwner : TComponent);override;
    destructor Destroy; override;
  end;

implementation

{$R *.dfm}
uses
  FormFactory, frmHowToEdit, dmMainGui, CommonLib, frmWorkflowPlay,
  AddinPackageInfoObj, PackageControl, HowToAddToPage, frmVideoPlayer,
  ERPVideosLib, busobjERPVideo, tcDataUtils, FilesLib, AppEnvironment,
  CommonDbLib, AppDatabase, ERPErrorEmailUtils, ERPVersionConst;


procedure TfmHowTo.btnAddToPageClick(Sender: TObject);
var
  lForm : TfrmHowToAddToPage;
begin
  inherited;
  lForm := TfrmHowToAddToPage.Create(nil);
  try
    lForm.HowToId := STeps.HowToId;
    lForm.ShowModal;
  finally
    lForm.Free;
  end;
end;

procedure TfmHowTo.btnEditClick(Sender: TObject);
var
  lForm : TfmHowToEdit;
begin
  inherited;
//
  lForm := TfmHowToEdit.Create(nil);
  try
    // Cover this form completely
    lForm.Top := Self.Top;
    lForm.Left := Self.Left;
    lForm.Width := Self.Width;
    lForm.Height := Self.Height;

    lForm.KeyID := Steps.HowToId;
    if lForm.ShowModal = mrOK then
    begin
      FreeAndNil(fSteps);
      LoadData;
    end;
  finally
    lForm.Free;
  end;
end;

procedure TfmHowTo.btnOKClick(Sender: TObject);
begin
  inherited;
  Notify;
  Close;

end;

constructor TfmHowTo.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TfmHowTo.Destroy;
begin
  Steps.Free;
  inherited;
end;

procedure TfmHowTo.FlowButtonClick(Sender: TObject);
var
  lStep : TSTepDisplay;
begin
  if Sender is TStepDisplay then
    lStep := Sender as TStepDisplay
  else
    exit;
  if lStep.WorkFlowId > 0 then
    WorkflowPlayForm.Playworkflow(lStep.WorkflowId);
end;

procedure TfmHowTo.FormButtonClick(Sender: TObject);
var
  lStep : TStepDisplay;
  k,
  idx : integer;
//  lAction : TContainedAction; //TAction;
  lForm : TComponent;
  lAddinInfo: TAddinPackageInfo;
begin
  if Sender is TStepDisplay then
    lStep := Sender as TStepDisplay
  else
    exit;

  if (lStep.FormClassName = '') or (lStep.FormClassName = csFormClassName) then
    Exit;  // Action not defined - nothing to do

  if RunAction(lSTep.FormClassName, dtmMainGui.ActionList) then
    exit;

  for idx := 0 to AddinPackageList.Count - 1 do
  begin
    lAddinInfo := TAddinPackageInfo(AddinPackageList[idx]);

    if Assigned(lAddinInfo.GuiDataModule) then
    begin
        for k := 0 to  lAddinInfo.GuiDataModule.ComponentCount-1 do
        begin
            if lAddinInfo.GuiDataModule.Components[k] is TActionlist then
            begin
              if RunAction(lStep.FormClassName, lAddinInfo.GuiDataModule.Components[k] as TActionlist) then
                exit;
            end;
        end;
    end;
  end;

  // Check for Form

  lForm := GetComponentByClassName(lStep.FormClassName);
  if Assigned(lForm) then
  begin
    TForm(lForm).FormStyle := fsMDIChild;
    TForm(lForm).BringToFront;
  end;


end;

procedure TfmHowTo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmHowTo.FormShow(Sender: TObject);
begin
  inherited;
  if KeyId = 0 then
    exit;

  LoadData;

end;

procedure TfmHowTo.LoadData;
var
  idx : integer;
  size : TSize;
  lStep : TStepDisplay;
begin
  if KeyId = 0 then
    exit;

  Steps := THowToStepList.Create(KeyId);
  if Steps.Header <> '' then
  begin
    size := TitleLabel.Canvas.TextExtent(Steps.Header);
    pnlTitle.Width := size.cx + 16;
    TitleLabel.Caption := Steps.Header;
  end;

  lblAuthor.Caption := 'Author: ' + Steps.AuthorName;
  lblCompany.Caption := 'Company: ' + Steps.CompanyName;
  Size := lblAuthor.Canvas.TextExtent(lblAuthor.Caption);
  lblAuthor.Width := Size.cx + 4;
  lblAuthor.Left := 22;
  Size := lblAuthor.Canvas.TextExtent(lblCompany.Caption);
  lblCompany.Width := Size.cx + 4;
  lblCompany.Left := pnlTop.Width - lblCompany.Width - 22;


  pnlTitle.Left := (Self.ClientWidth - pnlTitle.Width) div 2;

  Steps.Load(TStepDisplay, ScrollBox1);
  for idx := 0 to Steps.Count - 1 do
  begin
    lStep := TStepDisplay(Steps[idx]);
    lStep.Parent := ScrollBox1;
    if idx > 0 then
      lStep.Top := TCustomStepDisplay(Steps[idx - 1]).Top + TCustomStepDisplay(Steps[idx - 1]).Height + 2;
    lStep.Align := alTop;
    lStep.OnFormButtonClick := FormButtonClick;
    lStep.OnFlowButtonClick := FlowButtonClick;
    lStep.OnVideoButtonClick := VideoButtonClick;
  end;
end;

function TfmHowTo.RunAction(const aActionName: string; aList : TActionList): boolean;
var
  lAction : TContainedAction;
  idx : integer;
begin
  lAction := nil;
  try
//    for idx := 0 to dtmMainGui.ActionList.ActionCount - 1 do
    for idx := 0 to aList.ActionCount - 1 do
      if SameText(aActionName, aList.Actions[idx].Name) then
      begin
        lAction := aList.Actions[idx];
        Break;
      end;

    if Assigned(lAction) then
    begin
      lAction.Execute;
    end;
  finally
    Result := Assigned(lAction);
  end;
end;

procedure TfmHowTo.SetKeyId(const Value: integer);
begin
  inherited;
end;

procedure TfmHowTo.VideoButtonClick(Sender: TObject);
var
  lStep : TStepDisplay;
  Filename:String;
  //lVideo : string;
begin
  if not (Sender is TStepDisplay) then     exit;

   lStep := Sender as TStepDisplay;

    if trim(lStep.VideoFile) = '' then begin
      MessageDlgXP_Vista('Missing Video ', mtWarning, [mbok],0);
    end else if VideoID(lStep.VideoText , lStep.VideoFile ) = 0 then begin
      MessageDlgXP_Vista('Training Video ' + quotedstr(lStep.VideoText) + ' is Missing.  Please Contact ERP', mtWarning, [mbOK], 0);
        SendEmailtoErp('Video File Missing : ' ,
                            '    Video       :'  + quotedstr(lStep.VideoText) + ' , ' + quotedstr(lStep.VideoFile) + chr(13) +
                            '    Company     :' + Appenv.CompanyInfo.Companyname + chr(13) +
                            '    Server      :' + GetSharedMyDacConnection.Server + chr(13) +
                            '    Datase      :' + GetSharedMyDacConnection.Database + chr(13) +
                            '    Version     :' + TABLE_VERSION + chr(13) +
                            '    Failed From :' + Self.ClassName+'.Paly Video Button Click', 'sendemail');
    end else if DownloadVideo(VideoID(lStep.VideoText , lStep.VideoFile ))  then begin
      Filename := VideofilenamewithPath(VideoFilename(lStep.VideoText , lStep.VideoFile ));
      Fileslib.Openfile(Filename, self.Handle , 'How To video');
    end else MessageDlgXP_Vista('Failed to Play the Video', mtWarning, [mbOK], 0);



  (*lVideo := lStep.VideoFile;
  if lVideo = '' then
    exit;
  if not FileExists(lVideo) then
  begin
    MessageDlgXP_Vista('File ' + lVideo + ' Not Found' , mtWarning, [mbok],0);
    exit;
  end;

  PlayERPVideo(lVideo);*)

end;

initialization
  RegisterClass(TfmHowTo);
  with FormFact do begin
    RegisterMe(TfmHowTo, 'THowToListGUI_*=HowToId');
    RegisterMe(TfmHowTo, 'TTrainingDocsGUI_*=Id');
  end;

end.
