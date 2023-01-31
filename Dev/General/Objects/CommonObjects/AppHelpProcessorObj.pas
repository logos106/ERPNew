unit AppHelpProcessorObj;

interface

uses
  classes, (*frmHelp,*)  WebHelpObj;

type

  TAppHelpProcessor = class(TComponent)
  private
    (*function HelpForm: TfmHelp;*)
    Function WebHelpObj:TWebHelpobj;
  public
    (*function DoAppOnHelp(Command: Word; Data: Longint; var CallHelp: Boolean): boolean;*)
    function DoAppOnWebHelp(Command: Word; Data: Longint; var CallHelp: Boolean): boolean;
    (*procedure ShowContents;*)
    (*procedure SearchContents(const SearchText: string);*)
    procedure ShowHelp(const aContextID: integer);
    constructor Create(aOwner: TComponent); override;
  end;

var
  AppHelpProcessor: TAppHelpProcessor;

implementation

uses
  Forms, sysutils, CommonLib, AppEnvironment, windows, hh_funcs, dialogs,
  frmERPHelpOptions;

{ AppHelpProcessor }

constructor TAppHelpProcessor.Create(aOwner: TComponent);
begin
  inherited;
  Application.OnHelp:= self.DoAppOnwebHelp;
end;

(*function TAppHelpProcessor.DoAppOnHelp(Command: Word; Data: Integer;
  var CallHelp: Boolean): boolean;
begin
  CallHelp:= false;
  result:= false;
  if Command = HELP_CONTEXT then begin
    if HelpForm.HelpActive then begin
      HelpForm.GotoHelpContext(Data);
    end;
    HelpForm.Show;
  end;
end;*)


(*function TAppHelpProcessor.HelpForm: TfmHelp;
begin
  result:= TfmHelp(CommonLib.GetComponentByClassName('TfmHelp',true,Application));
  if not result.HelpActive then begin
    result.db.Port:= 3309;
    result.db.Server:= AppEnv.AppDb.Server;
    result.OpenHelp;
  end;
end;*)

(*procedure TAppHelpProcessor.SearchContents(Const SearchText: string);
begin
  HelpForm.Show;
  HelpForm.TextSearch(SearchText);
end;*)

(*procedure TAppHelpProcessor.ShowContents;
begin
  HelpForm.ShowContents;
  HelpForm.Show;
end;*)

procedure TAppHelpProcessor.ShowHelp(const aContextID: integer);
begin
//  HelpForm.Show;
//  HelpForm.GotoHelpContext(aContextID);
  WebHelpObj.GotoHelpContext(aContextID);
end;

function TAppHelpProcessor.WebHelpObj: TWebHelpObj;
begin
  result:= WebHelpObjInst;
end;

function TAppHelpProcessor.DoAppOnWebHelp(Command: Word; Data: Integer;
  var CallHelp: Boolean): boolean;
begin
  result:= false;
  if Command = HELP_CONTEXT then begin
    TfmERPHelpOptions.ShowEPHelpOptions(Data);
    result:= true;
    Application.ProcessMessages;
    CallHelp:= False;
    //WebHelpObj.GotoHelpContext(Data);
//    HHelpContext(ExtractFilePath(Application.EXEName) + 'ERP Help.chm',372000,'', htHHAPI);
  end;
end;

initialization
  AppHelpProcessor:= TAppHelpProcessor.Create(Application);

end.
