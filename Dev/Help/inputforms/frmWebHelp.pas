unit frmWebHelp;

interface
{$I ERP.inc}
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseWebBrowser, OleCtrls, SHDocVw, ExtCtrls, DB, DBAccess, MyAccess,
  ERPdbComponents, StdCtrls, DNMSpeedButton, DNMPanel, WebHelpObj, GuiPrefsObj;

type
  TfmWebHelp = class(TBaseWebBrowserGUI)
    DNMPanel1: TDNMPanel;
    btnEdit: TDNMSpeedButton;
    btnBack: TDNMSpeedButton;
    lblMsg: TLabel;
    lblurl: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnBackClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure WebBrowserNavigateError(ASender: TObject; const pDisp: IDispatch;
      var URL, Frame, StatusCode: OleVariant; var Cancel: WordBool);
  private
    fshelpmsg: String;
    ParentcontextID:Integer;
    compcontextID:Integer;
    fWebHelpObj: TWebHelpObj;
    GuiPrefs: TFormGuiPrefs;
    fsLangMsg: String;
    procedure setHelpMsg(const Value: String);
    procedure SetcontextID(const Value: Integer);
    Procedure ReadGuipref;
    Procedure WriteGuiPref;
    procedure Refreshmsg;
    procedure setLangMsg(const Value: String);

  Protected
    procedure setWebAddress(const Value: String);Override;
  public
    Property HelpMsg:String read fshelpmsg write setHelpMsg;
    Property LangMsg:String read fsLangMsg write setLangMsg;
    Property contextID :Integer read compcontextID write SetcontextID;
    Property objWebHelp :TWebHelpObj read fWebHelpObj Write fWebHelpObj;
  end;

  var
    WebHelpform :TfmWebHelp;

function WebHelpformInst:TfmWebHelp;

implementation

uses CommonLib, CommonDbLib, LogLib, frmWebHelpEntry, AppEnvironment;

{$R *.dfm}


function WebHelpformInst:TfmWebHelp;
begin
  if WebHelpform  = nil then
    WebHelpform:= TfmWebHelp(CommonLib.GetComponentByClassName('TfmWebHelp',true,Application));

  result := WebHelpform;

end;
{ TfmWebHelp }

{ TfmWebHelp }

procedure TfmWebHelp.btnBackClick(Sender: TObject);
begin
  inherited;
  if parentcontextId = 0 then exit;
  contextId :=parentcontextId;
end;

procedure TfmWebHelp.btnEditClick(Sender: TObject);
begin
  inherited;
    if (contextID<=0) then begin
      MessageDlgXP_Vista('Selected Component is not Assigned to Have Help.  Please Contact ERP' , mtWarning, [mbok],0);
    end else begin
      if not( SameText(ObjWebhelp.InputPassword , 'ERPHelpEdit')) then begin
        MessageDlgXP_Vista('Invalid Password.'+chr(13) + 'You Are Not Allowed to Add/Change the Help URL' , mtWarning, [mbok],0);
      end else begin
        With TfmWebHelpEntry(GetComponentByClassName('TfmWebHelpEntry')) do try
          objWebhelp := Self.objWebhelp;
          Showmodal;
        finally
          Free;
        end;
      end;
    end;
end;

procedure TfmWebHelp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteGuiPref;
  inherited;
  action := caFree;
end;

procedure TfmWebHelp.FormCreate(Sender: TObject);
begin
  inherited;
  ParentcontextID:=0;
  compcontextID:=0;
  GuiPrefs := TFormGuiPrefs.Create(Self);
  {$IFDEF DevMode}
    lblurl.visible:= True;
  {$ELSE}
    lblurl.visible:= False;
  {$ENDIF}


end;

procedure TfmWebHelp.FormDestroy(Sender: TObject);
begin
  WebHelpform := nil;
  inherited;
end;


procedure TfmWebHelp.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  {don;t inherit as the inherit is for help}
  if Key = VK_ESCAPE then Begin
    Key := 0;
    if Self.Enabled then begin
      if fsModal in FormState then Close
      else Release;
    end;
  end; //else inherited;
end;

procedure TfmWebHelp.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.active := TRue;
  ReadGuiPref;
end;

procedure TfmWebHelp.ReadGuipref;
begin
  if GuiPrefs.Node.Exists('FormSize') then begin
    Self.Height :=GuiPrefs.Node['FormSize.height'].AsInteger;
    Self.Width :=GuiPrefs.Node['FormSize.width'].AsInteger;
    Self.Top :=GuiPrefs.Node['FormSize.Top'].AsInteger;
    Self.Left :=GuiPrefs.Node['FormSize.Left'].AsInteger;
  end;
end;

procedure TfmWebHelp.SetcontextID(const Value: Integer);
var
  s:String;

begin
  compcontextID := Value;
  if compcontextID > 1000 then ParentcontextID := compcontextID div 1000*1000
  else ParentcontextID := 0;
  if ParentcontextID =  compcontextID then ParentcontextID:= 0;

  s:= 'Select 1 as ctr, concat(' +quotedstr(objwebhelp.MainPageURL) +',' +Quotedstr('/') + ',url) url from helptreeurls where ifnull(ContextId,0) = '+inttostr(compcontextID) +' and ifnull(url,"")<> "" ' +
          ' union Select 2 as ctr, concat(' +quotedstr(objwebhelp.MainPageURL) +',' +Quotedstr('/') + ',url) url  from helptreeurls where ifnull(ContextId,0) like '+inttostr(ParentcontextID) +' and ifnull(url,"")<> "" ' +
          ' union Select 3 as ctr, url from helptreeurls where `ID` = 1 and parentId = 0 ' +
          ' order by ctr';
  With TempMyQuery do try
    connection := GetNewERPLanguageConnection(Self);
    SQL.add(s);
    open;
    if fieldbyname('url').asString <> '' then begin
         WebAddress :=fieldbyname('url').asString+objWebhelp.LanguageSufix;
         AltWebAddress :=fieldbyname('url').asString;
                if fieldbyname('ctr').asInteger = 3 then helpMsg := 'For The Selected Component / Form'
           else if fieldbyname('ctr').asInteger = 2 then helpMsg := 'For The Selected Component'
           else helpMsg := '';
         btnBack.visible := fieldbyname('ctr').asInteger = 1;
         btnEdit.visible := fieldbyname('ctr').asInteger <> 3;
    end;
  finally
    if active then close;
    connection.free;
    free;
  end;

end;

procedure TfmWebHelp.setHelpMsg(const Value: String);
begin
  fshelpmsg := Value;
  Refreshmsg;
end;
procedure TfmWebHelp.setLangMsg(const Value: String);
begin
  fsLangMsg := Value;
  Refreshmsg;
end;

procedure TfmWebHelp.Refreshmsg;
var
  s:String;
begin
  s:= 'Help Not Found ';
  if fshelpmsg <> '' then s:= s + fshelpmsg;

  if fsLangMsg <> '' then begin
    if s<> '' then s:= s+' and ';
    s:= s+ fsLangMsg;
  end;
  if s= 'Help Not Found ' then s:= 'Help Not Found.  Please Contact ERP';
  lblMsg.Caption := s;
  lblMsg.visible := lblMsg.Caption <> '';
  lblMsg.refresh;
end;


procedure TfmWebHelp.setWebAddress(const Value: String);
begin
  if fsWebAddress = Value then exit;
  inherited;
  lblurl.caption :=fsWebAddress;
end;

procedure TfmWebHelp.WebBrowserNavigateError(ASender: TObject;
  const pDisp: IDispatch; var URL, Frame, StatusCode: OleVariant;
  var Cancel: WordBool);
begin
  if (StatusCode = 404) and (fsAltWebAddress <> '') and (ObjWebhelp.LanguageName <> '') then
      LangMsg := 'In ' +Quotedstr(ObjWebhelp.LanguageName) else LangMsg := '';
  inherited;
end;

procedure TfmWebHelp.WriteGuiPref;
begin
  GuiPrefs.Node['FormSize.height'].asInteger := self.Height;
  GuiPrefs.Node['FormSize.width'].asInteger := self.Width;
  GuiPrefs.Node['FormSize.Top'].asInteger := self.Top;
  GuiPrefs.Node['FormSize.Left'].asInteger := self.Left;
end;

initialization
  RegisterClass(TfmWebHelp);
  WebHelpform:= nil;
finalization
  FreeandNil(WebHelpform);
end.
