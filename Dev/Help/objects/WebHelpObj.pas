unit WebHelpObj;

interface
{$I ERP.inc}
uses classes, forms ,  IdHTTP, extctrls;

Type
  TWebHelpObj = class(TComponent)
    private
    fCurcomp: Tcomponent;
    fCurform: Tform;
    fsMainPageURL:String;
    fsLanguagePageURL:String;
    fsLanguagePage:String;
    fsLanguagesufix:String;
    fsLanguagename:String;
    objIdHTTP: TIdHTTP;
    CurcontextID:Integer;
    tmrHelpContextWait:TTimer;
    (*Function NewWebHelpentry:Boolean;*)
    function getMainPageURL: String;
    function getLanguagesufix: String;
    Procedure REadLang;
    function getLanguageName: String;
    function findUrl(const contextId: Integer): String;
    function IdHTTP: TIdHTTP;
    function UrlExists(const url: String; DEscription:STring): boolean;
    function getLanguageMainPageURL: String;
    procedure tmrHelpContextWaittimer(sender: TObject);

    public
      Function AddOrEditHelpcontext(xcontextID: Integer):Boolean;
      Procedure GotoHelpContext(xcontextID:Integer);
      Procedure GotoHelpContextWait(xcontextID:Integer);
      Property Curcomp: Tcomponent read fCurcomp write fCurcomp;
      Property Curform: Tform read fCurform write fCurform;
      constructor Create(AOwner :Tcomponent);override;
      DEstructor Destroy;override;
      function InputPassword: String;
      Property MainPageURL:String read getMainPageURL;
      Property LanguageSufix :String read getLanguagesufix;
      Property LanguageName :String read getLanguageName;
      Property LanguageMainPageURL:String read getLanguageMainPageURL;

    end;

  var
    helpobj: TWebHelpObj;

    function WebHelpObjInst:TWebHelpObj;
implementation

uses
  ERPdbComponents, CommonDbLib, (*frmWebHelp,*) frmWebHelpEntry, sysutils,
  CommonLib, AppContextObj,  graphics, dialogs, AppEnvironment,
  controls, shellapi, windows, LanguageTransLationObj, Progressdialog, tcConst,
  AppDatabase, HTTPConst;

var
  HelpEditAccessOk: boolean = false;


{ TWebHelpObj }
function TWebHelpObj.IdHTTP: TIdHTTP;
begin
  if objIdHTTP = nil then begin
    objIdHTTP :=TIdHTTP.create(self);
    objIdHTTP.Request.UserAgent := HTTPConst.TrueERPUserAgent;
    objIdHTTP.HandleRedirects := True;
  end;
  result := objIdHTTP;
end;


function TWebHelpObj.InputPassword: String;
var
  s:String;
begin
  {$IFDEF DevMode}
    s:= 'ERPHelpEdit';
  {$ELSE}
    s:= '';
  {$ENDIF}
  result := CustomInputPassword('Password', 'Please Enter the Password To Add/Change the Help URL',s);
end;

constructor TWebHelpObj.Create(AOwner: Tcomponent);
begin
  inherited;
  fCurcomp:=nil;
  fCurform:=nil;
  fsMainPageURL:= '';
  fsLanguagePageURL:= '';
  fsLanguagePage:= '';
  objIdHTTP := nil;
  CurcontextID:= 0;
  tmrHelpContextWait:=TTimer.Create(self);
  tmrHelpContextWait.Enabled := False;
  tmrHelpContextWait.Interval := 300;
  tmrHelpContextWait.OnTimer := tmrHelpContextWaittimer;
end;
destructor TWebHelpObj.Destroy;
var
  s:String;
begin
  s:= Self.ClassName;
  try
    FreeandNil(objIdHTTP);
    inherited;
    helpobj:= nil;
  Except
     on E:Exception do begin
     end;
  end;
end;

function TWebHelpObj.getLanguageName: String;
begin
  if fsLanguagename = '' then readLang;
  result := fsLanguagename;

end;

function TWebHelpObj.getLanguagesufix: String;
begin
  if fsLanguagesufix = '' then readLang;
  result := fsLanguagesufix;
end;

function TWebHelpObj.getMainPageURL: String;
begin
(*  if fsMainPageURL = '' then
    fsMainPageURL := getLanguageMainPageURL;*)
  if fsMainPageURL = '' then begin
    With TempMyQuery do try
      connection := GetNewERPLanguageConnection(Self);
      SQL.add('Select url from helptreeurls where `ID` = 1 and parentId = 0');
      open;
      fsMainPageURL := fieldbyname('url').asString;
    finally
      if active then close;
      connection.free;
      free;
    end;
  end;
  result := fsMainPageURL;
end;
function TWebHelpObj.getLanguageMainPageURL: String;
begin
  if fsLanguagePageURL = '' then begin
    With TempMyQuery do try
      connection := GetNewERPLanguageConnection(Self);
      SQL.add('Select Language , baseurl from languages where `ID` = ' + inttostr(TLanguageTranslationObj.Inst.UserLanguage_EnglishWhenBlank_Id));
      open;
      fsLanguagePageURL := fieldbyname('baseurl').asString;
      fsLanguagePage := fieldbyname('Language').asString;
    finally
      if active then close;
      connection.free;
      free;
    end;
  end;
  result := fsLanguagePageURL;
end;

Function  TWebHelpObj.findUrl(const contextId: Integer):String;
var
  s:String;
  ParentcontextID:Integer;
   sUrl:String;    (*EmailText:String;*)
  Procedure AddSQL(Const Value:String); begin if s<> '' then s:= s +' union '; s:= s + Value; end;
begin
  result := '';
  if contextId > 1000 then ParentcontextID := contextId div 1000*1000
  else ParentcontextID := 0;
  if ParentcontextID =  contextId then ParentcontextID:= 0;

  { special case for Logon Form (we don't have db connection yet) }
  if (ParentcontextID = 305000) or (ContextID = 305000) then begin
    result:= 'http://www.trueerp.com/wiki/Logon_Screen';
    exit;
  end;
  LanguageMainPageURL;
  MainPageURL;
  {Dene doesn't want to display the help from the English site at all when the language selected is not english
  Items #3, #4 and #6 are commented off for that reason}
  if  (fsLanguagePageURL <> '') and not(Sametext(fsLanguagePageURL ,fsMainPageURL)) then begin
      //AddSQL('Select 1 as ctr, concat(' +quotedstr(LanguageMainPageURL) (*+',' +Quotedstr('/')*) + ',url) as url, '+Quotedstr('Help for Item in ' + Quotedstr((*fsLanguagePage*)fsLanguagePageURL))  +' as description from helptreeurlslocal where ifnull(ContextId,0) = '+inttostr(contextId) +' and ifnull(url,"")<> "" ') ;
      AddSQL('Select 2 as ctr, concat(' +quotedstr(LanguageMainPageURL) (*+',' +Quotedstr('/')*) + ',url) as url, '+Quotedstr('Help for Item in ' + Quotedstr((*fsLanguagePage*)fsLanguagePageURL))  +' as description from helptreeurls where ifnull(ContextId,0) = '+inttostr(contextId) +' and ifnull(url,"")<> "" ');
  end;
{  if fsMainPageURL <> '' then
      AddSQL(' Select 3 as ctr, concat(' +quotedstr(MainPageURL        ) +',' +Quotedstr('/') + ',url) as url , '+Quotedstr('Help for Item in ' + Quotedstr((*'English'*)fsMainPageURL))      +' as description from helptreeurls where ifnull(ContextId,0) = '+inttostr(contextId) +' and ifnull(url,"")<> "" ');}

  if ParentcontextID <> 0 then begin
    if  (fsLanguagePageURL <> '') and not(Sametext(fsLanguagePageURL ,fsMainPageURL)) then begin
        //AddSQL('Select 4 as ctr, concat(' +quotedstr(LanguageMainPageURL) (*+',' +Quotedstr('/')*) + ',url) as url  , '+Quotedstr('Help for Form in ' + Quotedstr((*fsLanguagePage*)fsLanguagePageURL))+' as description from helptreeurlslocal where ifnull(ContextId,0) like '+inttostr(ParentcontextID) +' and ifnull(url,"")<> "" ');
        AddSQL('Select 5 as ctr, concat(' +quotedstr(LanguageMainPageURL) (*+',' +Quotedstr('/')*) + ',url) as url  , '+Quotedstr('Help for Form in ' + Quotedstr((*fsLanguagePage*)fsLanguagePageURL))+' as description from helptreeurls where ifnull(ContextId,0) like '+inttostr(ParentcontextID) +' and ifnull(url,"")<> "" ');
    end;
{    if fsMainPageURL <> '' then
        AddSQL(' Select 6 as ctr, concat(' +quotedstr(MainPageURL        ) +',' +Quotedstr('/') + ',url) as url  , '+Quotedstr('Help for Form in ' + Quotedstr((*'English'*)fsMainPageURL))     +' as description from helptreeurls where ifnull(ContextId,0) like '+inttostr(ParentcontextID) +' and ifnull(url,"")<> "" ');}
  end;
  if  (fsLanguagePageURL <> '') and not(Sametext(fsLanguagePageURL ,fsMainPageURL)) then
      AddSQL('Select 7 as ctr,        ' +quotedstr(LanguageMainPageURL)                            +' as URL , '+Quotedstr('ERP Main Help Page in ' + Quotedstr((*fsLanguagePage*)fsLanguagePageURL) )+' as description ');
{  if fsMainPageURL <> '' then
      AddSQL(' Select 8 as ctr,        ' +quotedstr(MainPageURL        )                            +' as URL , '+Quotedstr('ERP Main Help Page in' + Quotedstr((*'English'*)fsMainPageURL)      )+' as description ');}
  s:= s + ' order by ctr';


  With TempMyQuery do try
    connection := GetNewERPLanguageConnection(nil);
    SQL.add(s);
    open;
    first;
    s:='';
    (*emailText := '';
    try
      if not locate('ctr',1, []) then emailText := emailText + NL + 'Help for Item missing in ' + LanguageName +' ';
      if not locate('ctr',2, []) then emailText := emailText + NL + 'Help for Item missing in English ';
      if not locate('ctr',3, []) then emailText := emailText + NL + 'Help for Form missing in ' + LanguageName +' ';
      if not locate('ctr',4, []) then emailText := emailText + NL + 'Help for Form missing in English ';*)

  With TProgressDialog.NewProgressbar(WAITMSG, recordcount+4,1,1) do try
      While (Eof = False) do begin
          if fieldbyname('Description').asString <> '' then Message := fieldbyname('Description').asString;
          StepIt;
          surl := fieldbyname('url').asString;
          if surl <> '' then begin
            if urlExists(surl , fieldbyname('Description').asString) then begin
              result := surl;
              Exit;
            end else begin
              try
                SubMessage := surl +' - doesn''t Exists'+NL;
              Except
                // kill the exception
              end;
              //EmailText := EmailText + NL + fieldByname('description').asString + ' :->  ' + sUrl;
            end;
          end;
          Next;
      end;
  finally
    Free;
  end;
(*    finally
      if EmailText <> '' then begin
        EmailText := 'Language :' + LanguageName+chr(13) +
                     'Help Context ID : ' + inttostr(ContextID) +chr(13) +
                     'Form Help context Id : ' + inttostr(ParentcontextID)+ chr(13) +chr(13) +

                '    Company     :' +appenv.CompanyInfo.Companyname          +chr(13) +
                '    Server      :' +GetSharedMyDacConnection.Server  +chr(13) +
                '    Datase      :' +GetSharedMyDacConnection.Database+chr(13) +
                '    Version     :' +TABLE_VERSION+chr(13) +
                '    User        :' +appenv.employee.employeeNAme +chr(13) +chr(13) +

                     EmailText;

        SendEmailtoErp('Wiki : Missing Help' , EmailText );
      end;
    end;*)
    MessageDlgXP_Vista('Help file Not Found.  Please Contact ERP' , mtWarning, [mbok],0);
  finally
    if active then close;
    connection.free;
    free;
  end;
end;

function TWebHelpObj.UrlExists(const url:String; DEscription:STring):boolean;
begin
(*  With TProgressDialog.NewProgressbar(WAITMSG, 5,1,1) do try
    if Description <> '' then Message := Description;*)
    result := false;
    if url = '' then exit;
    try
      IdHTTP.head(url);
      result:=True;
      (*IdHTTP.Get(Url);
      RESULT := IdHTTP.ResponseCode = 200;*)

    except
      on E:Exception do begin
        try
          IdHTTP.get(url);
          result:=True;
        Except
          on E:Exception do begin
          end;
        end;

         //MessageDlgXP_Vista(inttostr(IdHTTP.ResponseCode), mtWarning, [mbOK], 0);
      end;
    end;
(*  finally
    free;
  end;*)
end;
Procedure TWebHelpObj.GotoHelpContextWait(xcontextID:Integer);
begin
  CurcontextID :=  xcontextID;
  tmrHelpContextWait.Enabled := True;
end;
Procedure TWebHelpObj.tmrHelpContextWaittimer(sender:TObject);
begin
  tmrHelpContextWait.Enabled := False;
  //GotoHelpContext(CurcontextID);
  AddOrEditHelpcontext(CurcontextID );
end;
function  TWebHelpObj.AddOrEditHelpcontext(xcontextID: Integer):Boolean;
begin
  Result := False;
  try

  fCurcomp:= screen.activecontrol;
  fCurform:= screen.activeForm;

    if (xcontextID<=0) then begin
      if fCurform.helpcontext <> 0 then begin
        if MessageDlgXP_Vista('Selected Component is not Assigned to Have Help.  Do You Wish To Create Help for the Form?' , mtconfirmation, [mbyes,mbno],0)= mrno then exit;
        xcontextID:=fCurform.helpcontext;
      end else begin
        MessageDlgXP_Vista('Selected Component is not Assigned to Have Help.  Please Contact ERP' , mtWarning, [mbok],0);
        Exit;
      end;
    end;

    if (xcontextID<=0) then exit;

    if (not HelpEditAccessOk) and (not ( SameText(InputPassword , 'ERPHelpEdit'))) then begin
      MessageDlgXP_Vista('Invalid Password.'+chr(13) + 'You Are Not Allowed to Add/Change the Help URL' , mtWarning, [mbok],0);
      Exit;
    end else begin
      HelpEditAccessOk := true;
      if not TfmWebHelpEntry.NewEntry(Self) then exit;
    end;
    result := True;
  finally
    AppContext.DeleteContext('WebHelpEntry')
  end;
end;
Procedure TWebHelpObj.GotoHelpContext(xcontextID: Integer);
var
  url:String;
begin
  {help is called twice :-(second from D6ObHelpfix) - don't assign the form second time}
(*  if screen.activeForm is TfmWebHelp then exit;
  if Screen.activeform is TfmWebHelpEntry  then exit;*)

  if (NewwebHelpentry) then
    if not AddOrEditHelpcontext(xcontextID) then exit;

  if CurcontextID = xcontextID then exit;
  CurcontextID := xcontextID;
  url:=findUrl( xcontextID);
  if url<> '' then ShellExecute(0, nil, pchar(url), '','', SW_SHOWDEFAULT);
end;
function WebHelpObjInst:TWebHelpObj;
begin
  if helpobj = nil then begin
    helpobj:= TWebHelpObj(CommonLib.GetComponentByClassName('TWebHelpObj',true,nil));
  end;
  result := helpobj;
end;

(*function TWebHelpObj.NewWebHelpentry: Boolean;
begin
  Result := False;
    if AppContext.ContextExists('WebHelpEntry') then
        if AppContext['WebHelpEntry'].VarExists('NewWebHelpEntry') then
            if AppContext['WebHelpEntry'].VarExists('NewWebHelpEntry') then
                Result := AppContext['WebHelpEntry'].VarByname['NewWebHelpEntry'] = 'T';
  AppContext['WebHelpEntry'].VarByname['NewWebHelpEntry']:= 'F';
end;*)

procedure TWebHelpObj.REadLang;
begin
    With TempMyQuery do try
      connection := GetNewERPLanguageConnection(Self);
      SQL.add('Select Language , Languagecode from languages where Id = ' + inttostr(TLanguageTranslationObj.Inst.UserLanguage_EnglishWhenBlank_Id));
      open;
      fsLanguagesufix := fieldbyname('Languagecode').asString;
      fsLanguagename := fieldbyname('Language').asString;
    finally
      if active then close;
      connection.free;
      free;
    end;
end;

initialization
  RegisterClassOnce(TWebHelpObj);
  helpobj:= nil;
finalization
  if helpobj <> nil then begin
    Freeandnil(helpobj);
    helpobj:= nil;
  end;
end.
