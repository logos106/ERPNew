unit frmERPHelpOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, ImageDLLLib, Shader, DNMPanel, ActnList, DNMAction,
  DNMSpeedButton, busobjUDErpHelpDocs, Buttons;

type
  TfmERPHelpOptions = class(TBaseInputGUI)
    pnlOptions: TPanel;
    pnlfooter: TDnmPanel;
    DNMPanel3: TDnmPanel;
    pnlHeader: TDnmPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cmdClose: TDNMSpeedButton;
    pnl1: TDnmPanel;
    pnl2: TDnmPanel;
    pnl3: TDnmPanel;
    pnlControlOptions: TDnmPanel;
    pnl4: TDnmPanel;
    pnl5: TDnmPanel;
    pnl6: TDnmPanel;
    lblFormname: TLabel;
    btnEdit: TDNMSpeedButton;
    lblcontrolname: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    btnUDDs: TspeedButton;
    btnUDD: TDNMSpeedButton;
    mnuOptions: TAdvPopupMenu;
    mnuChoose: TMenuItem;
    mnuOpen: TMenuItem;
    mnuDelete: TMenuItem;
    lblNote: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnUDDsClick(Sender: TObject);
    procedure btnUDDClick(Sender: TObject);
    procedure mnuDeleteClick(Sender: TObject);
    procedure mnuChooseClick(Sender: TObject);
    procedure mnuOpenClick(Sender: TObject);
    procedure btnUDDMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    btnControlURL, btnControlvideo , btnControlHelpdoc : TERPMainSwitchMovingButton;
    btnFormURL, btnFormvideo , btnFormHelpdoc : TERPMainSwitchMovingButton;
    dtERPHelpobj : TDataModule;
    fOwnerformcolor: Tcolor;
    fDocReaderObj : TUDErpHelpDocs;
    procedure setOwnerformcolor(const Value: Tcolor);
    procedure InitColor;
    procedure CheckforLocalDoc;
    function DocReaderObj : TUDErpHelpDocs;
    procedure Openhelpdoc;
    procedure Choosehelpdoc;
    //procedure initERPUDHelpDocs(Sender: TObject);
  Protected
  public
    procedure initbuttons;
    Constructor Create(AOwner:TComponent);Override;
    Class Procedure ShowEPHelpOptions(Data:Integer);
    Procedure CloseIt(IsDoneOK: boolean = true); Override;
    Property Ownerformcolor :Tcolor read fOwnerformcolor write setOwnerformcolor;
  end;

var
  fmERPHelpOptions: TfmERPHelpOptions;

implementation

uses CommonDbLib, datERPHelp, WebHelpObj, ColourLib, ERPLib, CommonFormLib,
  ERPUDHelpDocs, FrmUDERPHelpDoc, DocReaderObj,
  tcDataUtils;

{$R *.dfm}

constructor TfmERPHelpOptions.Create(AOwner: TComponent);
begin
  inherited;
  dtERPHelpobj :=TdtERPHelp.create(Self);
  TdtERPHelp(dtERPHelpobj).ERPHelpOptions := Self;
end;

function TfmERPHelpOptions.DocReaderObj: TUDErpHelpDocs;
begin
  if fDocReaderObj = nil then begin
    fDocReaderObj := TUDErpHelpDocs.CreateWithNewConn(self);
    fDocReaderObj.LoadSelect('ContextId = ' + inttostr(TdtERPHelp(dtERPHelpobj).curform.helpcontext));
  end;
  if (fDocReaderobj.contextid <> TdtERPHelp(dtERPHelpobj).curform.helpcontext) and
    (fDocReaderobj.locate('contextID' , TdtERPHelp(dtERPHelpobj).curform.helpcontext , [])= false) then begin
    fDocReaderObj.closedb;
    fDocReaderObj.opendb;
  end;
  result := fDocReaderObj;
end;

procedure TfmERPHelpOptions.Openhelpdoc;
begin
  TDocReaderObj.ShowERPHelp(TERPQuery(DocReaderObj.Dataset), Self, true, DocReaderObj.Description);
  CheckforLocalDoc;
end;

Procedure TfmERPHelpOptions.Choosehelpdoc;
var
  UDERPHelpDoc : TfmUDERPHelpDoc;
begin
  UDERPHelpDoc := TfmUDERPHelpDoc.create(self);
  try
    with UDERPHelpDoc do begin
      FormCaption := lblFormname.Caption;
      ControlCaption := lblcontrolname.Caption;
      formContextId := TdtERPHelp(dtERPHelpobj).curform.helpcontext;
      ControlContextID := TdtERPHelp(dtERPHelpobj).ControlHelpcontextID;
      Doformshow;
      if Choosefile then Dosavenclose else DoCancelclose;
    end;
  finally
    Freeandnil(UDERPHelpDoc);
    CheckforLocalDoc;
  end;
end;

procedure TfmERPHelpOptions.mnuOpenClick(Sender: TObject);
begin
  inherited;
  Openhelpdoc;
end;

procedure TfmERPHelpOptions.btnUDDClick(Sender: TObject);
begin
  inherited;
    if DocReaderObj.count >0 then begin
      openhelpdoc;
      Exit;
    end;
  ChooseHelpDoc;
end;

procedure TfmERPHelpOptions.btnUDDMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if button = mbRight then
    mnuOptions.Popup(Mouse.CursorPos.x, Mouse.CursorPos.Y);
end;

procedure TfmERPHelpOptions.btnUDDsClick(Sender: TObject);
begin
  inherited;
  TERPUDHelpDocsGUI.showListFor(Self, TdtERPHelp(dtERPHelpobj).ControlHelpcontextID ,TdtERPHelp(dtERPHelpobj).curform.helpcontext , lblFormname.caption , lblcontrolname.caption);
end;
procedure TfmERPHelpOptions.CloseIt(IsDoneOK: boolean=true);
begin
  inherited;
end;

procedure TfmERPHelpOptions.cmdCloseClick(Sender: TObject);
begin
  inherited;
  closeit;
end;

procedure TfmERPHelpOptions.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := cafree;
end;

procedure TfmERPHelpOptions.FormCreate(Sender: TObject);
Function NewButton(btnCaption:String; pnl:TDnmPanel):TERPMainSwitchMovingButton;
begin
      Result := TERPMainSwitchMovingButton.Create(Self);
      Result.Parent := pnl;
      Result.Font.Style := Result.Font.Style - [fsBold];
      Result.Font.Size := 8;
      Result.align := alclient;
      Result.Caption := btnCaption;
      Result.AlignwithMargins := False;
end;
begin
  inherited;
      pnl1.width := trunc((pnl1.parent.width - 20)/3);
      pnl2.width := pnl1.width;
      pnl3.width := pnl1.width;

      btnFormURL     := NewButton('ERP Wiki', pnl1);
      btnFormvideo   := NewButton('Training Video',pnl2);
      btnFormHelpdoc := NewButton('Training Doc',pnl3);

      pnl4.width := trunc((pnl4.parent.width - 20)/3);
      pnl5.width := pnl4.width;
      pnl6.width := pnl4.width;

      btnControlURL     := NewButton('ERP Wiki', pnl4);
      btnControlvideo   := NewButton('Training Video',pnl5);
      btnControlHelpdoc := NewButton('Training Doc',pnl6);
      btnEdit.visible := IsERPHelpEditEnabled ;
      Setlength(Buttons , 0);
      if btnEdit.visible then begin
        Setlength(Buttons , Length(Buttons)+1);
        Buttons[high(Buttons)] := btnEdit.name;
      end;

      Setlength(Buttons , Length(Buttons)+1);
      Buttons[high(Buttons)] := btnUDD.name;
      Centralisebuttons(pnlfooter);

      Setlength(Buttons , Length(Buttons)+1);
      Buttons[high(Buttons)] := cmdClose.name;
      Centralisebuttons(pnlfooter);
end;
procedure TfmERPHelpOptions.initbuttons;
begin
      btnControlURL.dnmAction    := TdtERPHelp(dtERPHelpobj).actWiki;
      btnControlvideo.dnmAction  := TdtERPHelp(dtERPHelpobj).actTrainingVideo;
      btnControlHelpdoc.dnmAction:= TdtERPHelp(dtERPHelpobj).actTrainingDocs;

      btnFormURL.dnmAction    := TdtERPHelp(dtERPHelpobj).actformWiki;
      btnFormvideo.dnmAction  := TdtERPHelp(dtERPHelpobj).actformTrainingVideo;
      btnFormHelpdoc.dnmAction:= TdtERPHelp(dtERPHelpobj).actformTrainingDocs;
      btnEdit.action :=TdtERPHelp(dtERPHelpobj).actEdit;
end;

procedure TfmERPHelpOptions.setOwnerformcolor(const Value: Tcolor);
begin
  fOwnerformcolor := Value;
  InitColor;
end;
procedure TfmERPHelpOptions.InitColor;
begin
  Self.color := fOwnerformcolor;
  fbInitToTabcolor := False;
  ReloadFormColor;
end;
procedure TfmERPHelpOptions.mnuChooseClick(Sender: TObject);
begin
  inherited;
  Choosehelpdoc;
end;

procedure TfmERPHelpOptions.mnuDeleteClick(Sender: TObject);
begin
  inherited;
  if DocReaderObj.count >0 then begin
    DocReaderObj.Delete;
    CheckforLocalDoc;
  end;
end;

procedure TfmERPHelpOptions.CheckforLocalDoc;
begin
  if (*HasLocalDoc(TdtERPHelp(dtERPHelpobj).curform.helpcontext)*)DocReaderObj.count >0 then begin
    //btnUDD.Font.Color := clGreen;
    DnmButton( btnUDD,clwhite ,btnUDD.HotTrackColor,clGreen);
    mnuDelete.visible := True;
    mnuOpen.visible := True;
  end else begin
    DnmButton( btnUDD,clwhite ,btnUDD.HotTrackColor,clRed);
    mnuDelete.visible := False;
    mnuOpen.visible := False;
  end;
end;
procedure TfmERPHelpOptions.FormDestroy(Sender: TObject);
begin
  Freeandnil(btnControlURL);
  Freeandnil(btnControlvideo);
  Freeandnil(btnControlHelpdoc);

  Freeandnil(btnFormURL);
  Freeandnil(btnFormvideo);
  Freeandnil(btnFormHelpdoc);

  Freeandnil(dtERPHelpobj);
  Freeandnil(fDocReaderObj);
  inherited;
end;

procedure TfmERPHelpOptions.FormShow(Sender: TObject);
var
  s1, s2:String;
begin
  inherited;
  s1 :=  trim(TdtERPHelp(dtERPHelpobj).CurformDisplayName);
  s2:= TdtERPHelp(dtERPHelpobj).CurcontrolDisplayname;
  lblcontrolname.caption :=  'Component on Form (' + trim(s1+ '.'+s2)+')';
  lblFormname.caption :=  s1;//'Main Form (' + s1+')';
  lblcontrolname.visible := True;
  lblFormname.visible := True;
  if s1 = '' then begin
    pnlOptions.visible := False;
    Self.height :=Self.height -pnlOptions.height;
  end;
  if s2 = '' then begin
    pnlControlOptions.visible := False;
    lblcontrolname.visible := False;
    Self.height :=Self.height -pnlControlOptions.height - lblcontrolname.height;
  end;
  InitColor;
  CheckforLocalDoc;
  //line.top :=0;
end;

Class procedure TfmERPHelpOptions.ShowEPHelpOptions(Data: Integer);
var
  fmERPHelpOptions: TfmERPHelpOptions;
begin
  fmERPHelpOptions:= TfmERPHelpOptions.create(nil);
  //TdtERPHelp(fmERPHelpOptions.dtERPHelpobj).ControlHelpcontextID := Data;
  TdtERPHelp(fmERPHelpOptions.dtERPHelpobj).InitAll;
  fmERPHelpOptions.Showmodal;
end;
initialization
  fmERPHelpOptions:= nil;
finalization
  if fmERPHelpOptions <> nil then freeandnil(fmERPHelpOptions);

end.
