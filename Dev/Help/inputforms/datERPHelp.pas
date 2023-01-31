unit datERPHelp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  frmERPHelpOptions,Dialogs, BaseGUIDatamodule, ActnList, DNMAction ;

type
  TdtERPHelp = class(TdtmGUI)
    ActionList: TActionList;
    actTrainingDocs: TDNMAction;
    actTrainingVideo: TDNMAction;
    actWiki: TDNMAction;
    actformWiki: TDNMAction;
    actFormTrainingVideo: TDNMAction;
    actFormTrainingDocs: TDNMAction;
    actEdit: TDNMAction;
    procedure actTrainingDocsExecute(Sender: TObject);
    procedure actTrainingVideoExecute(Sender: TObject);
    procedure actWikiExecute(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure actformWikiExecute(Sender: TObject);
    procedure actFormTrainingVideoExecute(Sender: TObject);
    procedure actFormTrainingDocsExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
  private
    fiControlHelpcontextID: Integer;fiformHelpcontextID : Integer;
    fsControlURL          : String ;fsFormURL           : String;
    fsControlTrainingDoc  : String ;fsFormTrainingDoc   : String;
    fiControlTrainingvidoeID: Integer; fiFormTrainingvidoeID: Integer;
    fERPHelpOptions: TfmERPHelpOptions;
    fCurcontrol: Tcomponent;
    fCurform: Tform;
    procedure setControlURL(const Value: String);
    procedure setFormURL(const Value: String);
    procedure setControlTrainingDoc(const Value: String);
    procedure setFormTrainingDoc(const Value: String);
    procedure setControlTrainingvidoeID(const Value: Integer);
    procedure setFormTrainingvidoeID(const Value: Integer);
    function CheckforActionProperty(Sender: TObject): Boolean;
    function HintForHelpAction(Missing:Boolean; HelpCaption: String): String;
    function getCurcontrolDisplayname: String;
    function getCurformDisplayName: String;
    Procedure initDM;Override;
  public
    Property ControlHelpcontextID:Integer read fiControlHelpcontextID write fiControlHelpcontextID(*SetControlHelpcontextID*);
    Property formHelpcontextID:Integer read fiformHelpcontextID write fiformHelpcontextID(*SetformHelpcontextID*);
    Property ControlURL:String read fsControlURL write setControlURL;
    Property FormURL:String read fsFormURL write setFormURL;
    Property ControlTrainingDoc:String read fsControlTrainingDoc write setControlTrainingDoc;
    Property FormTrainingDoc:String read fsFormTrainingDoc write setFormTrainingDoc;
    Property ControlTrainingvidoeID:Integer read fiControlTrainingvidoeID write setControlTrainingvidoeID;
    Property FormTrainingvidoeID:Integer read fiFormTrainingvidoeID write setFormTrainingvidoeID;
    procedure InitAll;

    (*Property Activeformname :String read fsActiveformname write fsActiveformname;
    Property Activecontrolname:String read fsActivecontrolname write fsActivecontrolname;*)
    Property ERPHelpOptions : TfmERPHelpOptions read fERPHelpOptions write fERPHelpOptions;
    Property Curcontrol: Tcomponent read fCurcontrol write fCurcontrol;
    Property Curform: Tform read fCurform write fCurform;
    Property CurcontrolDisplayname:String read getCurcontrolDisplayname;
    Property CurformDisplayName :String read getCurformDisplayName;
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses  ERPdbComponents, DbSharedObjectsObj, WebHelpObj, CommonDbLib,
  DocReaderObj, ERPVideosLib, busobjERPVideo, FilesLib, CommonLib, tcDataUtils,
   ERPErrorEmailUtils, AppEnvironment, ERPVersionConst, tcConst, ERPLib,
  AppContextObj, frmBase, LogLib;

{$R *.dfm}
{ TdtERPHelp }



Function TdtERPHelp.CheckforActionProperty(Sender:TObject):Boolean;

  function IsControlOptionAndBlank:Boolean;
  begin
       result := ((Sender = actWiki         ) and (ControlURL             = '')) or
                 ((Sender = actTrainingDocs ) and (ControlTrainingDoc     = '')) or
                 ((Sender = actTrainingVideo) and (ControlTrainingvidoeID = 0));
  end;

  function IsFormOptionAndBlank:Boolean;
  begin
    Result :=  ((Sender = actformWiki         ) and (FormURL            = '')) or
               ((Sender = actFormTrainingDocs ) and (FormTrainingDoc    = '')) or
               ((Sender = actFormTrainingVideo) and (FormTrainingvidoeID= 0));
  end;

begin
  result := True;
  if  IsControlOptionAndBlank OR IsFormOptionAndBlank then begin
    (* if IsERPCustomEnabled then begin
        AppContext['WebHelpEntry'].VarByname['NewWebHelpEntry'] := 'T';
        if IsControlOptionAndBlank then
          WebHelpObjInst.GotoHelpContextWait(ControlHelpcontextID)
        else WebHelpObjInst.GotoHelpContextWait(formHelpcontextID);
        REsult := False;
        Exit;
     end;*)
     Processingcursor(true);
     try

        SendEmailtoErp('Request for '+ TDnmAction(Sender).caption+' :  ' + Appenv.Employee.EmployeeName+' ('+ Appenv.CompanyInfo.Companyname+')',
                                          'From     : ' + Appenv.CompanyInfo.Companyname+ chr(13) +
                                          'User     : ' + Appenv.Employee.EmployeeName+ chr(13) +
                                          'Version  : ' +TABLE_VERSION+chr(13) +
                                          'Date     : ' +formatDateTime('dd-mm-yyyy hh:nn' , now())+ chr(13) + chr(13) +
                                          'ERP Form Name : ' +Curform.name+
                                            iif(IsControlOptionAndBlank , '.' +Curcontrol.name, '')+ chr(13) +
                                          'Help context :' + iif(IsControlOptionAndBlank ,inttostr(ControlHelpcontextID) , inttostr(formHelpcontextID)) , '');

        result := False;
     finally
        Processingcursor(False);
        MessageDlgXP_vista('An email has been Sent to ERP for this '+ TDnmAction(Sender).caption+'.', mtInformation, [mbOK], 0);
     end;
  end;

end;

constructor TdtERPHelp.Create(AOwner: TComponent);
begin
  inherited;

end;

procedure TdtERPHelp.DataModuleCreate(Sender: TObject);
begin
  inherited;
  fCurcontrol:=nil;
  fCurform:=nil;
  fERPHelpOptions := nil;
  fCurcontrol:= screen.activecontrol;
  fCurform:= screen.activeForm;
  actEdit.visible := IsERPHelpEditEnabled ;
end;

Procedure TdtERPHelp.InitAll;
var
  Qry :TERPQuery;
  function GetParentControlHelpcontextID(aCurcontrol :TWincontrol):Integer;
  begin
     if Assigned(aCurcontrol) and (aCurcontrol.helpcontext <> 0) then begin
       Result :=aCurcontrol.helpcontext ;
       Exit;
     end;
     if aCurcontrol.parent <> nil then
      result := GetParentControlHelpcontextID(aCurcontrol.parent);
  end;
begin
  {colours}
  if Assigned(CurForm) then begin
    ERPHelpOptions.Ownerformcolor :=CurForm.color;
  end;
  {control}
  if Assigned(Curcontrol) then begin
    fiControlHelpcontextID := TWincontrol(Curcontrol).helpcontext;
    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    try
       closedb(qry);
       qry.SQL.text := 'Select * from erplanguages.helptreeurls where ContextId =' + inttostr(fiControlHelpcontextID);
       opendb(qry);
       {error tracker had Field 'erphelpdocName' not found error few times - }
       try ControlURL:=Qry.fieldbyname('URL').asString;                    Except on E:Exception do begin exit; end; end;
       try ControlTrainingDoc:=Qry.fieldbyname('erphelpdocName').asString; Except on E:Exception do begin exit; end; end;
       try ControlTrainingvidoeID :=Qry.fieldbyname('VideoID').asInteger;  Except on E:Exception do begin exit; end; end;
    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    end;
    if NewwebHelpentry then begin
      if (fiControlHelpcontextID =0) and (TWincontrol(Curcontrol).parent <> nil) then
        fiControlHelpcontextID := GetParentControlHelpcontextID(TWincontrol(Curcontrol).parent);
      if (fiControlHelpcontextID <> 0) then
        WebHelpObjInst.AddOrEditHelpcontext(fiControlHelpcontextID);
    end;

  end;

  {form}
  if Assigned(CurForm) then begin
    fiFormHelpcontextID := Tform(CurForm).helpcontext;
    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    try
       closedb(qry);
       qry.SQL.text := 'Select * from erplanguages.helptreeurls where ContextId =' + inttostr(fiFormHelpcontextID);
       opendb(qry);
       FormURL:=Qry.fieldbyname('URL').asString;
       FormTrainingDoc:=Qry.fieldbyname('erphelpdocName').asString;
       FormTrainingvidoeID :=Qry.fieldbyname('VideoID').asInteger;
    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    end;
    if NewwebHelpentry and (fiFormHelpcontextID <> 0) then begin
      WebHelpObjInst.AddOrEditHelpcontext(fiFormHelpcontextID);
    end;
  end;
  ERPHelpOptions.initbuttons;
end;
procedure TdtERPHelp.initDM;
begin
  inherited;
  fbREgisterEvents:= False;
  fbRegister4ReportSelector := False;

end;

function TdtERPHelp.HintForHelpAction(Missing:Boolean; HelpCaption:String):String;
begin
  if Missing then begin
      result :='No '+Quotedstr(HelpCaption)+' Available for the Selected Option.'+NL;
      if IsERPCustomEnabled then
           Result := Result + 'Please Choose to Add the Help Links'
      else Result := Result + 'Please Choose to Send a Request to ERP for a '+Quotedstr(HelpCaption);
  end else begin
      result :='Please Choose for '+quotedstr(HelpCaption);
  end;
  result := result +'.';
end;

function TdtERPHelp.getCurcontrolDisplayname: String;
begin
  REsult := '';
  if not Assigned(Fcurcontrol) then exit;
  result := TfrmBaseGUI(fcurform).ControlDisplayName(Fcurcontrol);
end;

function TdtERPHelp.getCurformDisplayName: String;
begin
  result := '';
  if not (Assigned(fcurform)) then exit;
  if fcurform is TfrmBaseGUI then result := TfrmBaseGUI(fcurform).DisplayCaption
  else result := fcurform.caption;
end;

procedure TdtERPHelp.setControlURL            (const Value: String );begin  fsControlURL            := Value;  actWiki.hint             := HintForHelpAction((value = '' ) , actWiki.caption)             ;end;
procedure TdtERPHelp.setFormURL               (const Value: String );begin  fsFormURL               := Value;  actformWiki.hint         := HintForHelpAction((value = '' ) , actformWiki.caption)         ;end;
procedure TdtERPHelp.setControlTrainingDoc    (const Value: String );begin  fsControlTrainingDoc    := Value;  actTrainingDocs.hint     := HintForHelpAction((value = '' ) , actTrainingDocs.caption)     ;end;
procedure TdtERPHelp.setFormTrainingDoc       (const Value: String );begin  fsFormTrainingDoc       := Value;  actFormTrainingDocs.hint := HintForHelpAction((value = '' ) , actFormTrainingDocs.caption) ;end;
procedure TdtERPHelp.setControlTrainingvidoeID(const Value: Integer);begin  fiControlTrainingvidoeID:= Value;  actTrainingVideo.hint    := HintForHelpAction((value = 0  ) , actTrainingVideo.caption)    ;end;
procedure TdtERPHelp.setFormTrainingvidoeID   (const Value: Integer);begin  fiFormTrainingvidoeID   := Value;  actFormTrainingVideo.hint:= HintForHelpAction((value = 0  ) , actFormTrainingVideo.caption);end;

{action events}
procedure TdtERPHelp.actWikiExecute(Sender: TObject);
begin
  inherited;
    if not CheckforActionProperty(Sender) then exit;
    WebHelpObjInst.GotoHelpContext(ControlHelpcontextID);
end;
procedure TdtERPHelp.actTrainingVideoExecute(Sender: TObject);
var
  Filename:String;
begin
    if not CheckforActionProperty(Sender) then exit;
    try
      if ControlTrainingvidoeID = 0 then begin
        MessageDlgXP_Vista('Missing Video', mtWarning, [mbOK], 0);
      end else if DownloadVideo(ControlTrainingvidoeID)  then begin
        Filename := VideofilenamewithPath(Videofilename(ControlTrainingvidoeID));
        if Filename = '' then begin
          MessageDlgXP_Vista('Missing Video', mtWarning, [mbOK], 0);
          exit;
        end;
        fileslib.Openfile(filename, ERPHelpOptions.Handle , 'Training video');
      end else MessageDlgXP_Vista('Failed to Play the Video', mtWarning, [mbOK], 0);
    Except
      // kill the exception
    end;
end;
procedure TdtERPHelp.actTrainingDocsExecute(Sender: TObject);
begin
  inherited;
    if not CheckforActionProperty(Sender) then exit;
    TDocReaderObj.ShowERPHelp(nil, Self, true, ControlTrainingDoc);
end;
procedure TdtERPHelp.actformWikiExecute(Sender: TObject);
begin
  inherited;
    if not CheckforActionProperty(Sender) then exit;
    WebHelpObjInst.GotoHelpContext(Curform.HelpContext);
end;
procedure TdtERPHelp.actFormTrainingVideoExecute(Sender: TObject);
var
  Filename:String;
begin
    if not CheckforActionProperty(Sender) then exit;
    try
      if FormTrainingvidoeID = 0 then begin
        MessageDlgXP_Vista('Missing Video', mtWarning, [mbOK], 0);
      end else if DownloadVideo(FormTrainingvidoeID)  then begin
        Filename := VideofilenamewithPath(Videofilename(FormTrainingvidoeID));
        if Filename = '' then begin
          MessageDlgXP_Vista('Missing Video', mtWarning, [mbOK], 0);
          exit;
        end;
        fileslib.Openfile(filename, ERPHelpOptions.Handle , 'Training video');
      end else MessageDlgXP_Vista('Failed to Play the Video', mtWarning, [mbOK], 0);
    Except
      // kill the exception
    end;
end;
procedure TdtERPHelp.actEditExecute(Sender: TObject);
begin
  inherited;
  WebHelpObjInst.GotoHelpContextWait(ControlHelpcontextID);
  fERPHelpOptions.closeit;
end;

procedure TdtERPHelp.actFormTrainingDocsExecute(Sender: TObject);
begin
  inherited;
    if not CheckforActionProperty(Sender) then exit;
    TDocReaderObj.ShowERPHelp(nil, Self, true, FormTrainingDoc);
end;

end.
