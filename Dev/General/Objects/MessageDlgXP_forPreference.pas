unit MessageDlgXP_forPreference;

interface

uses Dialogs , taskdialog , classes;

type
  TPrefOptionObj = Class(Tcomponent)
    Private
    fsTextSearch: string;
    fsinitMsg: string;
    fsSinglePanelToshow: string;
    fsSinglebuttonCaption: String;
    fiAccesslevel: Integer;
    fbOpenAsModel: boolean;
    fsfocuscontrolName: string;
    fsMsgOption: string;
    function getMsgOption: string;
    Public
      Property SinglebuttonCaption:String read fsSinglebuttonCaption write fsSinglebuttonCaption;
      Property focuscontrolName: string read fsfocuscontrolName write fsfocuscontrolName;
      Property Accesslevel:Integer  read fiAccesslevel write fiAccesslevel;
      Property OpenAsModel: boolean read fbOpenAsModel write fbOpenAsModel;
      Property TextSearch: string read fsTextSearch write fsTextSearch;
      Property SinglePanelToshow: string  read fsSinglePanelToshow write fsSinglePanelToshow;
      Property initMsg: string read fsinitMsg write fsinitMsg;
      Property MsgOption: string read getMsgOption write fsMsgOption;

      constructor Create(AOwner:TComponent);Override;
      Procedure InitItBlank;
      Procedure InitIt(aSinglebuttonCaption: string;
                        afocuscontrolName: string;
                        aAccesslevel:Integer = 0;
                        aOpenAsModel: boolean = true;
                        aTextSearch: string = '';
                        aSinglePanelToshow: string = '';
                        ainitMsg: string='';
                        aMsgOption: string='');
  end;

function MessageDlgXP_VistaWithPrefoption(const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint;
        const aPrefOptionObj:TPrefOptionObj;
        const Owner: TComponent=nil;
        const Instruction: string = '';
        const VerifyText: string = '';
        const VerifyChecked: boolean = false;
        OnVerifyClick: TTaskDialogVerifyClickEvent = nil;
        const CustomButtonsStr :String = '';
        Soundfilename:String = '';MsgBoxWidth:Integer=0): Word;
function  NewPrefOptionObj(AOwner:TComponent) : TPrefOptionObj;
function  PrefOptionObj(AOwner:TComponent; aSinglebuttonCaption: string;
                        afocuscontrolName: string;
                        aAccesslevel:Integer = 0;
                        aOpenAsModel: boolean = true;
                        aTextSearch: string = '';
                        aSinglePanelToshow: string = '';
                        ainitMsg: string='';
                        aMsgOption: string='') : TPrefOptionObj;



implementation

uses Preferences, CommonLib;
{ TPrefOptionObj }
constructor TPrefOptionObj.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  inititblank;
end;
procedure TPrefOptionObj.InitItBlank;begin  InitIt('','',0,True,'','','');end;
function TPrefOptionObj.getMsgOption: string;
begin
  Result := fsMsgOption;
  if REsult = '' then result := 'Open Preference Form';
end;

procedure TPrefOptionObj.InitIt(aSinglebuttonCaption, afocuscontrolName: string;aAccesslevel: Integer; aOpenAsModel: boolean; aTextSearch, aSinglePanelToshow,ainitMsg,aMsgOption: string);
begin
  SinglebuttonCaption:= aSinglebuttonCaption;
  focuscontrolName   := afocuscontrolName;
  Accesslevel        := aAccesslevel;
  OpenAsModel        := aOpenAsModel;
  TextSearch         := aTextSearch;
  SinglePanelToshow  := aSinglePanelToshow;
  initMsg            := ainitMsg;
  MsgOption          := aMsgOption;
end;

{ General functions }
function MessageDlgXP_VistaWithPrefoption(const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint;
        const aPrefOptionObj:TPrefOptionObj;
        const Owner: TComponent=nil;
        const Instruction: string = '';
        const VerifyText: string = '';
        const VerifyChecked: boolean = false;
        OnVerifyClick: TTaskDialogVerifyClickEvent = nil;
        const CustomButtonsStr :String = '';
        Soundfilename:String = '';MsgBoxWidth:Integer=0): Word;
begin
   if (aPrefOptionObj<> nil) and (aPrefOptionObj.SinglebuttonCaption <> '') then begin
      result :=  MessageDlgXP_Vista(Msg,DlgType,Buttons,HelpCtx,Owner,Instruction,VerifyText,VerifyChecked,OnVerifyClick,aPrefOptionObj.MsgOption,Soundfilename,MsgBoxWidth );
      if result = 100 then
        OpenPrefform(aPrefOptionObj.SinglebuttonCaption,
                      aPrefOptionObj.focuscontrolName,
                      aPrefOptionObj.Accesslevel,
                      aPrefOptionObj.OpenAsModel,
                      aPrefOptionObj.TextSearch,
                      aPrefOptionObj.SinglePanelToshow,
                      aPrefOptionObj.initMsg);
        try if aPrefOptionObj.owner = nil then aPrefOptionObj.Free; Except end;
   end else begin
      result :=  MessageDlgXP_Vista(Msg,DlgType,Buttons,HelpCtx,Owner,Instruction,VerifyText,VerifyChecked,OnVerifyClick,CustomButtonsStr,Soundfilename,MsgBoxWidth);
   end;
end;
function  PrefOptionObj(AOwner:TComponent;
                        aSinglebuttonCaption: string;
                        afocuscontrolName: string;
                        aAccesslevel:Integer = 0;
                        aOpenAsModel: boolean = true;
                        aTextSearch: string = '';
                        aSinglePanelToshow: string = '';
                        ainitMsg: string='';
                        aMsgOption: string='') : TPrefOptionObj;
begin
  Result :=   TPrefOptionObj.create(AOwner);
  Result.InitIt(aSinglebuttonCaption,afocuscontrolName,aAccesslevel,aOpenAsModel,aTextSearch,aSinglePanelToshow,ainitMsg,aMsgOption);
end;

function  NewPrefOptionObj(AOwner:TComponent) : TPrefOptionObj;begin  Result :=PrefOptionObj(AOwner, '','');end;

end.
