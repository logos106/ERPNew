unit frmShowMe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, Menus, ExtCtrls, StdCtrls, DNMPanel , ShowMeVideoList ,BaseListingForm,
  DNMSpeedButton, GuiPrefsObj, AdvSmoothToggleButton, SelectionDialog;

type
  TfmShowMe = class(TBaseForm)
    pnlMain: TDNMPanel;
    DNMPanel1: TDNMPanel;
    btnvideos: TAdvSmoothToggleButton;
    btnHowTo: TAdvSmoothToggleButton;
    btnchanges: TAdvSmoothToggleButton;
    Chkhide: TCheckBox;
    btnList: TAdvSmoothToggleButton;
    lblListEmpty: TLabel;
    btnTips: TAdvSmoothToggleButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnVideosClick(Sender: TObject);
    procedure btnTipsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnchangesClick(Sender: TObject);
    procedure ChkhideClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnListClick(Sender: TObject);
    procedure tmrProcessMessageTimer(Sender: TObject);
    procedure btnHowToClick(Sender: TObject);
  private
    fShowMeVideoList: TBaseListingGUI;
    fsPageName: String;
    fiOptionIndex: Integer;
    GuiPrefs: TFormGuiPrefs;
    //Buttonsdone :Boolean;
    Function ShowMeVideoList: TShowMeVideoListGUI;
    procedure setPageName(const Value: String);
    procedure setOptionIndex(const Value: Integer);
    Procedure CloseFormclick(Sender:TObject);
    Procedure RefreshQuery;
    procedure Locaterecord(Sender: TObject);
    (*Function OptionName:String;*)
    //procedure initColours;
  Protected
    Procedure AfterFormShow; Override;
  public
    procedure DoShowMe(PageForList: String);
    Property PageName:String read fsPageName write setPageName;
    Property OptionIndex :Integer read fiOptionIndex write setOptionIndex;
    class Function ShowMe(PageForList:String) : TfmShowMe;
  end;

  var
  ShowMeForm:  TfmShowMe;

implementation

uses CommonFormLib, CommonLib , MAIN, AppEnvironment, ERPVideos, tcConst,
  ERPMessages, ERPTrainingVideos;


{$R *.dfm}

{ TfmShowMe }

procedure TfmShowMe.AfterformShow;
begin
  inherited;
  if GuiPrefs.Node.Exists('Options.OptionIndex') then
      OptionIndex:=  GuiPrefs.Node['Options.OptionIndex'].asInteger
  else OptionIndex:= 0;
  if GuiPrefs.Node.Exists('Options.Left') then Left:=  GuiPrefs.Node['Options.Left'].asInteger;
  if GuiPrefs.Node.Exists('Options.top')  then  Top:=  GuiPrefs.Node['Options.top'].asInteger;
  if  (Left <(Application.MainForm.Left)) then Left := (Application.MainForm.ClientWidth - Width ) -20;
  if  (top <(Application.MainForm.top  )) then Top  := (Application.MainForm.ClientHeight- height) -Mainform.maintoolbar.height-40 ;
end;

procedure TfmShowMe.btnchangesClick (Sender: TObject);
var
  ListForm: TERPTrainingVideosGUI;
begin
  optionIndex := 2;
  ListForm := TERPTrainingVideosGUI(CreatenOpenERPListForm('TERPTrainingVideosGUI',nil,true,Locaterecord));
  ListForm.grpFilters.ItemIndex := 1;
  ListForm.SelectMode;
end;

procedure TfmShowMe.btnHowToClick(Sender: TObject);
var
  ListForm: TERPTrainingVideosGUI;
begin
  optionIndex := 1;
  ListForm := TERPTrainingVideosGUI(CreatenOpenERPListForm('TERPTrainingVideosGUI',nil,true,Locaterecord));
  ListForm.grpFilters.ItemIndex := 6; //2;
  ListForm.SelectMode;
end;

procedure TfmShowMe.btnTipsClick    (Sender: TObject);
var
  ListForm: TERPTrainingVideosGUI;
begin
  optionIndex := 1;
  ListForm := TERPTrainingVideosGUI(CreatenOpenERPListForm('TERPTrainingVideosGUI',nil,true,Locaterecord));
  ListForm.grpFilters.ItemIndex := 4; //2;
  ListForm.SelectMode;
end;

procedure TfmShowMe.btnVideosClick  (Sender: TObject);
var
  ListForm: TERPTrainingVideosGUI;
begin
  OptionIndex := 0;
  ListForm := TERPTrainingVideosGUI(CreatenOpenERPListForm('TERPTrainingVideosGUI',nil,true,Locaterecord));
  ListForm.grpFilters.ItemIndex := 0;
  ListForm.SelectMode;
end;

procedure TfmShowMe.btnListClick(Sender: TObject);
begin
  inherited;
(*       if optionindex =0 then OpenERPListForm('TERPTrainingVideosGUI' , nil, Locaterecord)
  else if optionindex =1 then OpenERPListForm('TERPTipsGUI' , nil, Locaterecord)
  else if optionindex =2 then OpenERPListForm('TERPChangesGUI' , nil, Locaterecord)
  else exit;*)
  OpenERPListForm('TERPTrainingVideosGUI' , nil, Locaterecord);
  btnlist.down := False;
end;
procedure TfmShowMe.Locaterecord(Sender: TObject);
begin
    if fShowMeVideoList = nil then exit;
    if TShowMeVideoListGUI(fShowMeVideoList).qryMainID.asInteger =0 then exit;
  if Sender is TERPMessagesGUI then begin
    TERPMessagesGUI(Sender).qryMain.Locate('ID' , TShowMeVideoListGUI(fShowMeVideoList).qryMainID.asInteger , []);
  end else if sender is TERPTrainingVideosGUI then begin
    TERPTrainingVideosGUI(Sender).qryMain.Locate('ID' , TShowMeVideoListGUI(fShowMeVideoList).qryMainID.asInteger , []);
  end;
end;
procedure TfmShowMe.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  GuiPrefs.Node['Options.OptionIndex'].asInteger:= OptionIndex;
  GuiPrefs.Node['Options.Left'].asInteger:= Left;
  GuiPrefs.Node['Options.top'].asInteger := Top;
  try
    GuiPrefs.SavePrefs; except end;
  inherited;
  Action := caFree;
end;

procedure TfmShowMe.FormCreate(Sender: TObject);
begin
  //Buttonsdone := False;
  inherited;
  Chkhide.checked := AppEnv.Employee.ShowVideoMenuAtStartup;
  ShowControlhint(btnvideos,'Choose for the list of ''Training Videos'' ' +NL+
                    'of the Current Module Selected on the Mainmenu.' +NL+
                    'Choose ''List'' for the complete list ' +NL+
                    'of ''Training videos'' , ''Tips'' and ''Changes'''+NL);
  ShowControlhint(btnTips,'Choose for the list of ''Tips'' ' +NL+
                    'Choose ''List'' for the complete list ' +NL+
                    'of ''Training videos'' , ''Tips'' and ''Changes'''+NL);
  ShowControlhint(btnchanges,'Choose for the list of ''Changes'' ' +NL+
                    'of the Current Module Selected on the Mainmenu' +NL+
                    'Choose ''List'' for the complete list ' +NL+
                    'of ''Training videos'' , ''Tips'' and ''Changes'''+NL);
  ShowControlhint(btnList,  'Choose for the complete list ' +NL+
                    'of ''Training videos'' , ''Tips'' and ''Changes'''+NL);
  ShowControlHint(btnHowTo, 'Choose for the list of How To Examples');
end;

procedure TfmShowMe.FormDestroy(Sender: TObject);
begin
  freeandnil(fShowMeVideoList);
  inherited;
  ShowMeForm := nil;
end;



procedure TfmShowMe.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_ESCAPE then self.close;
end;

function TfmShowMe.ShowMeVideoList: TShowMeVideoListGUI;
begin
  CreateHistorylistform('TShowMeVideoListGUI' ,Self, fShowMeVideoList);
  fShowMeVideoList.ShowbuttonsinPanel := False;
  result := TShowMeVideoListGUI(fShowMeVideoList);
end;

procedure TfmShowMe.tmrProcessMessageTimer(Sender: TObject);
begin
  inherited;

end;

(*procedure TfmShowMe.initColours;
var
  ctr:Integer;
begin
  for ctr := 0 to componentcount-1 do begin
    if components[ctr] is TAdvSmoothToggleButton then  begin
      TAdvSmoothToggleButton(components[ctr]).BorderColor := Self.color;
      TAdvSmoothToggleButton(components[ctr]).BevelColorDown:= Self.color;
      TAdvSmoothToggleButton(components[ctr]).Appearance.FocusColor:= Self.color;
    end;
  end;
end;*)
procedure TfmShowMe.FormShow(Sender: TObject);
begin
  inherited;
  Left := (Application.MainForm.ClientWidth - Width ) -20;
  Top  := (Application.MainForm.ClientHeight- height) -Mainform.maintoolbar.height-40 ;
  ShowMeVideoList;
  if not(Assigned(fShowMeVideoList)) then exit;
  TShowMeVideoListGUI(fShowMeVideoList).ShowbuttonsinPanel := True;
  TShowMeVideoListGUI(fShowMeVideoList).Parent := pnlMain;
  TShowMeVideoListGUI(fShowMeVideoList).fbIgnoreQuerySpeed := true;
  TShowMeVideoListGUI(fShowMeVideoList).Show;
  TShowMeVideoListGUI(fShowMeVideoList).pnlButtons.visible := False;
  TShowMeVideoListGUI(fShowMeVideoList).cmdClose.left := TShowMeVideoListGUI(fShowMeVideoList).Width - TShowMeVideoListGUI(fShowMeVideoList).Cmdclose.width - 5;
  TShowMeVideoListGUI(fShowMeVideoList).btnPhone.left := TRunc(TShowMeVideoListGUI(fShowMeVideoList).Width /2)- TRunc(TShowMeVideoListGUI(fShowMeVideoList).btnPhone.width /2) ;
  TShowMeVideoListGUI(fShowMeVideoList).btnDownloadAll.left := 5;
  TShowMeVideoListGUI(fShowMeVideoList).cmdclose.Enabled := True;
  TShowMeVideoListGUI(fShowMeVideoList).cmdclose.OnClick := CloseFormclick;
  TShowMeVideoListGUI(fShowMeVideoList).barStatus.visible := devMode;
  TShowMeVideoListGUI(fShowMeVideoList).FooterPanel.height := 54;
  TShowMeVideoListGUI(fShowMeVideoList).grdmain.Hint := '';
  lblListEmpty.Parent := fShowMeVideoList.grdMain;
  GuiPrefs := TFormGuiPrefs.Create(Self);
  GuiPrefs.Active := TRue;

end;

(*function TfmShowMe.OptionName: String;
begin
  result := '';
       if OptionIndex=0 then result :=  btnvideos.caption
  else if OptionIndex=1 then result :=  btnTips.caption
  else if OptionIndex=2 then result :=  btnchanges.caption;
end;*)

procedure TfmShowMe.ChkhideClick(Sender: TObject);
begin
  inherited;
  if screen.activecontrol <> Chkhide then exit;
  AppEnv.Employee.ShowVideoMenuAtStartup := Chkhide.checked;
end;

procedure TfmShowMe.CloseFormclick(Sender: TObject);
begin
  Self.Close;
end;
(*Class Procedure TfmShowMe.ListForPage(Value:String);
begin
  if not (FormstillOpen('TfmShowMe')) then exit;
  TfmShowMe(FindExistingComponent('TfmShowMe')).PageName :=Value;
end;*)
procedure TfmShowMe.setOptionIndex(const Value: Integer);
begin
  lblListEmpty.Visible := false;
  fiOptionIndex := Value;
  if not(Assigned(fShowMeVideoList)) then exit;
  btnVideos.Down  := Value =0;
  btnTips.Down    := Value =1;
  btnchanges.Down := Value =2;
  btnHowTo.Down   := Value = 3;
  RefreshQuery;
end;

procedure TfmShowMe.setPageName(const Value: String);
begin
  fsPageName := Value;
  RefreshQuery;
end;
procedure TfmShowMe.RefreshQuery;
begin
  fShowMeVideoList.grpfilters.itemindex := OptionIndex;
  TShowMeVideoListGUI(fShowMeVideoList).Pagename := Pagename;
  Self.caption := (*OptionName +' - ' +*)Pagename;
  if (OptionIndex = 2) and (fShowMeVideoList.qryMain.RecordCount = 0) then begin
    lblListEmpty.Caption := 'No Changes for this module. Try the list option.';
    lblListEmpty.Visible := true;
    lblListEmpty.Transparent := true;
//    lblListEmpty.BringToFront;
  end;
end;
(*procedure TfmShowMe.SetDefaultColor;
var
  ctr:Integer;
begin
  inherited;
  if Buttonsdone then exit;
  for ctr := 0 to componentcount-1 do begin
    if components[ctr] is TAdvSmoothToggleButton then  begin
      TAdvSmoothToggleButton(components[ctr]).BorderColor := Self.color;
      TAdvSmoothToggleButton(components[ctr]).BevelColorDown:= Self.color;
      TAdvSmoothToggleButton(components[ctr]).Appearance.FocusColor:= Self.color;
    end;
  end;
  Buttonsdone := True;
end;*)

Procedure TfmShowMe.DoShowMe(PageForList:String) ;
begin
  if not visible then begin
    //Visible := True;
    formstyle := fsmdiChild;
  end;
  BringToFront;
  lblListEmpty.Visible := false;
  PageName :=PageForList;
  if (OptionIndex = 2) and (fShowMeVideoList.qryMain.RecordCount = 0) then begin
    lblListEmpty.Caption := 'No Changes for this module. Try the list option.';
    lblListEmpty.Visible := true;
    lblListEmpty.Transparent := true;
//    lblListEmpty.BringToFront;
  end;
end;

class Function TfmShowMe.ShowMe(PageForList:String) : TfmShowMe;
begin
  if not Assigned(ShowMeForm) then
    ShowMeForm := TfmShowMe(GetComponentByClassName('TfmShowMe', True));
  result := ShowMeForm;
  result.DoShowMe(PageForList);
end;


initialization
  RegisterClassOnce(TfmShowMe);

end.
