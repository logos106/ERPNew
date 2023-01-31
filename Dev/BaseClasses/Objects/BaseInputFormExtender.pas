unit BaseInputFormExtender;

interface
uses
  Classes, MyAccess,ERPdbComponents, BaseInputForm, Forms;

type

  TBaseInputFormExtender = class(TComponent)
  private
    fIsFirstShow: boolean;
    SavedFormShowHandler: TNotifyEvent;
    SavedFormCloseHandler: TCloseEvent;
    SavedFormCloseQueryHandler: TCloseQueryEvent;
  protected
    MyConnection: TERPConnection;
    Form: TBaseInputGUI;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FirstFormShow(Sender: TObject); //virtual;
    procedure DoFormClose(Sender: TObject); virtual;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DoFormCloseQuery(Sender: TObject; var CanClose: Boolean); virtual;
    Function ReadGuipref(Const Prefname:String):String; virtual;
    Procedure WriteGuiPref(Const Prefname:String;Value:String); virtual;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;


implementation

uses
  CommonLib, GlobalEventsObj;
  
{ TBaseInputFormExtender }

constructor TBaseInputFormExtender.Create(AOwner: TComponent);
begin
  inherited;
  fIsFirstShow:= true;
  If Assigned(Owner) then Begin
    Form:= TBaseInputGUI(Owner);
    MyConnection:= TERPConnection(FindChildComponent(Form, 'MyConnection'));
    SavedFormShowHandler:= Form.OnShow;
    Form.OnShow:= FormShow;
    SavedFormCloseHandler:= Form.OnClose;
    Form.OnClose:= FormClose;
    SavedFormCloseQueryHandler:= Form.OnCloseQuery;
    Form.OnCloseQuery:= FormCloseQuery;
  end else
    Form := nil;
end;

procedure TBaseInputFormExtender.FormShow(Sender: TObject);
begin
  if Assigned(SavedFormShowHandler) then begin
    SavedFormShowHandler(Sender);
  end;
  if fIsFirstShow then begin
    fIsFirstShow:= false;
    FirstFormShow(Sender);
  end;
end;

procedure TBaseInputFormExtender.FirstFormShow(Sender: TObject);
begin

end;

procedure TBaseInputFormExtender.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DoFormClose(Sender);
  if Assigned(SavedFormCloseHandler) then
    SavedFormCloseHandler(Sender, Action);

end;

destructor TBaseInputFormExtender.Destroy;
begin
  GlobalEvents.DeregisterHandlers(self);
  inherited;
end;

procedure TBaseInputFormExtender.DoFormClose(Sender: TObject);
begin

end;

procedure TBaseInputFormExtender.DoFormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin

end;

procedure TBaseInputFormExtender.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  DoFormCloseQuery(Sender, CanClose);
  if CanClose then begin
    if Assigned(SavedFormCloseQueryHandler) then
      SavedFormCloseQueryHandler(Sender, CanClose);
  end;    
end;

Function TBaseInputFormExtender.ReadGuipref(const Prefname: String):String;
begin
  Result := '';
  if assigned(Owner) then
    if Owner is TBaseInputGUI then begin
      TBaseInputGUI(Owner).ActivateGuiPrefs(True);
      Result := TBaseInputGUI(Owner).ReadGuipref('Options.'+Prefname);
    end;
end;

procedure TBaseInputFormExtender.WriteGuiPref(const Prefname: String;Value: String);
begin
  TBaseInputGUI(Owner).WriteGuiPref('Options.'+Prefname , Value);
end;

end.
