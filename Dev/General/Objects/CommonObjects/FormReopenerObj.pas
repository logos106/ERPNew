unit FormReopenerObj;

interface

uses
  contnrs, JsonObject, ObserverListObj, extctrls, forms, classes;


type

  TFormReopener = class(TComponent, IObserverUpdateMeList, IObserverUpdateMeEdit)
  private
    fParams: TJsonObject;
    FFormClassName: string;
    FPopupformClassname: string;
    FActive: boolean;
    procedure SetFormClassName(const Value: string);
    procedure SetPopupformClassname(const Value: string);
    procedure SetActive(const Value: boolean);
    function ReopenForm(SingleInstance: boolean = true): TForm;
    procedure DoUpdateMe;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property FormClassName: string read FFormClassName write SetFormClassName;
    property PopupformClassname: string read FPopupformClassname write SetPopupformClassname;
    property Params: TJsonObject read fParams;
    property Active: boolean read FActive write SetActive;
    procedure UpdateMe; overload;
    procedure UpdateMe(const Cancelled: boolean; const aObject: TObject = nil); overload;
  end;

  TFormReopenerList = class
  private
    List: TObjectList;
    fTimer: TTimer;
    procedure DoOnTimer(Sender: TObject);
    function GetItem(index: integer): TFormReopener;
    function getcount: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    property Items[index: integer]: TFormReopener read GetItem;
    Property count :Integer read getcount;
    function Add(aFormClassName: string; aPopupForm: TForm = nil): TFormReopener;
  end;

var
  FormReopenerList: TFormReopenerList;

implementation

uses
  CommonLib, BaseInputForm, BaseFormForm;

{ TFormReopener }

constructor TFormReopener.Create(AOwner: TComponent);
begin
  inherited;
  fParams:= TJsonObject.Create;
  fActive:= true;
end;

destructor TFormReopener.Destroy;
begin
  ObserverList.DetachAll(self);
  fParams.Free;
  inherited;
end;

procedure TFormReopener.DoUpdateMe;
var
  Form: TForm;
begin
  try
    if (not Active) or (Params.Count = 0) then exit;

    { reopen the form }
    Form:= ReopenForm;
    if Assigned(Form) then begin
      { need to rinstate forms previous state }
      Application.ProcessMessages;
      try
        if Form is TBaseInputGui then begin
          TBaseInputGui(Form).StateParams:= Params;
          TBaseInputGui(Form).StateParams:= nil;
        end;
      except
      end;
    end;
  finally
//    ObserverList.DetachAll(self);
    Active:= false;
  end;
end;

function TFormReopener.ReopenForm(SingleInstance: boolean = true): TForm;
var
  Form: TForm;
begin
  result := nil;
  if FormClassName = '' then exit;
  if SingleInstance then begin
    if FormStillOpen(FormClassname) then begin
       Form :=  TForm(FindExistingComponent(FormClassName));
       if Assigned(Form) then begin
         Form.Close;
        Application.ProcessMessages;
         if FormStillOpen(FormClassname) then
           exit;
       end
       else
         exit;
    end;
  end;

  Form := TForm(GetComponentByClassName(FormClassname , SingleInstance));
  if Assigned(Form) then begin //if has acess
    if Form is TBaseInputGUI then begin
      TBaseInputGUI(Form).KeyID := Params.I['KeyID'];
      TBaseInputGUI(Form).ReopeningForm:=true;
      TBaseInputGUI(Form).ReopeningFormClass := PopupformClassname;
    end;
    if form is TBaseForm then begin
      with TBaseForm(Form) do begin
        FormStyle := fsMDIChild ;
        BringToFront;
      end;
      result:= Form;
    end;
  end;
end;

procedure TFormReopener.SetActive(const Value: boolean);
begin
  FActive := Value;
end;

procedure TFormReopener.SetFormClassName(const Value: string);
begin
  FFormClassName := Value;
end;
procedure TFormReopener.SetPopupformClassname(const Value: string);
begin
  FPopupformClassname := Value;
end;

procedure TFormReopener.UpdateMe(const Cancelled: boolean;
  const aObject: TObject);
begin
  DoUpdateMe;
end;

procedure TFormReopener.UpdateMe;
begin
  DoUpdateMe;
end;

{ TFormReopenerList }

function TFormReopenerList.Add(aFormClassName: string; aPopupForm: TForm = nil): TFormReopener;
var
  NewReopener: TFormReopener;
begin
  NewReopener:= TFormReopener.Create(nil);
  NewReopener.FormClassName:= aFormClassName;
  if aPopupForm <> nil then NewReopener.PopupformClassname:= aPopupForm.ClassName else NewReopener.PopupformClassname:= '';
  if Assigned(aPopupForm) then
    ObserverList.Attach(NewReopener,aPopupForm);


  List.Add(NewReopener);
  result:= NewReopener;
end;

constructor TFormReopenerList.Create;
begin
  List:= TObjectList.Create(true);
  fTimer:= TTimer.Create(nil);
  fTimer.Interval:= 60 * 1000;
  fTimer.OnTimer:= DoOnTimer;
  fTimer.Enabled:= true;
end;

destructor TFormReopenerList.Destroy;
begin
  fTimer.Enabled:= false;
  fTimer.Free;
  List.Free;
  inherited;
end;

procedure TFormReopenerList.DoOnTimer(Sender: TObject);
var
  x: integer;
begin
  x:= 0;
  while x < List.Count do begin
    if not Items[x].Active then
      List.Delete(x)
    else
      Inc(x);
  end;
end;

function TFormReopenerList.getcount: Integer;
begin
  result:= 0;
  if assigned(List) then
    Result:= List.count;
end;

function TFormReopenerList.GetItem(index: integer): TFormReopener;
begin
  result:= TFormReopener(List[index]);
end;

initialization
  FormReopenerList:= TFormReopenerList.Create;

finalization
  FormReopenerList.Free;

end.
