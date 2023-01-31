unit frameButtonArray;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, AdvSmoothButton, JsonObject;

type
  TArrayButtonClickEvent = procedure (Button: TAdvSmoothButton; FunctionType, FunctionValue: string) of object;

  TfrButtonArray = class(TFrame)
    Button_0_0: TAdvSmoothButton;
    Button_0_1: TAdvSmoothButton;
    Button_0_2: TAdvSmoothButton;
    Button_0_3: TAdvSmoothButton;
    Button_0_4: TAdvSmoothButton;
    Button_1_0: TAdvSmoothButton;
    Button_1_1: TAdvSmoothButton;
    Button_1_2: TAdvSmoothButton;
    Button_1_3: TAdvSmoothButton;
    Button_1_4: TAdvSmoothButton;
    Button_2_0: TAdvSmoothButton;
    Button_2_1: TAdvSmoothButton;
    Button_2_2: TAdvSmoothButton;
    Button_2_3: TAdvSmoothButton;
    Button_2_4: TAdvSmoothButton;
    Button_3_0: TAdvSmoothButton;
    Button_3_1: TAdvSmoothButton;
    Button_3_2: TAdvSmoothButton;
    Button_3_3: TAdvSmoothButton;
    Button_3_4: TAdvSmoothButton;
    Button_4_0: TAdvSmoothButton;
    Button_4_1: TAdvSmoothButton;
    Button_4_2: TAdvSmoothButton;
    Button_4_3: TAdvSmoothButton;
    Button_4_4: TAdvSmoothButton;
    Button_0_5: TAdvSmoothButton;
    Button_1_5: TAdvSmoothButton;
    Button_2_5: TAdvSmoothButton;
    Button_3_5: TAdvSmoothButton;
    Button_4_5: TAdvSmoothButton;
    Button_5_0: TAdvSmoothButton;
    Button_5_1: TAdvSmoothButton;
    Button_5_2: TAdvSmoothButton;
    Button_5_3: TAdvSmoothButton;
    Button_5_4: TAdvSmoothButton;
    Button_5_5: TAdvSmoothButton;
    procedure FrameResize(Sender: TObject);
  private
    fOnButtonClick: TArrayButtonClickEvent;
    fDesignMode: boolean;
    fSelectedButton: TAdvSmoothButton;
    FConfig: TJsonObject;
    fSelectedKeypad: TJsonObject;
    DefaultButtonConfig: TJsonObject;
    fOnKeypadSelect: TNotifyEvent;
    fOnConfigAssign: TNotifyEvent;
    procedure ButtonClick(Sender: TObject);
    function GetButtonConfig(aButton: TAdvSmoothButton): TJsonObject;
    procedure SetButtonConfig(aButton: TAdvSmoothButton;
      const Value: TJsonObject);
    procedure ClearSelected;
    function GetSelectedButtonConfig: TJsonObject;
    procedure SetConfig(const Value: TJsonObject);
    function GetSelectedKeypadName: string;
    procedure SetSelectedKeypadName(const Value: string);
    procedure KeypadToButtons;
    procedure ButtonsToKeypad;
    function KeypadByName(aKeypadName: string): TJsonObject;
    procedure RevertAllButtons;
    procedure OrganiseButtons;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    property Config: TJsonObject read FConfig write SetConfig;
    property ButtonConfig[aButton: TAdvSmoothButton]: TJsonObject read GetButtonConfig write SetButtonConfig;
    property SelectedKeypadName: string read GetSelectedKeypadName write SetSelectedKeypadName;
    property SelectedKeypad: TJsonObject read fSelectedKeypad;
    function AddKeypad(aKeypadName: string): boolean;
    procedure PopulateKeypadNames(strings: TStrings; ExcludeSelected: boolean = false);
    procedure ResetButton(aButton: TAdvSmoothButton);
    function DeleteKeypad(aKeypadName: string): boolean;
  published
    property OnButtonClick: TArrayButtonClickEvent read fOnButtonClick write fOnButtonClick;
    property OnKeypadSelect: TNotifyEvent read fOnKeypadSelect write fOnKeypadSelect;
    property OnConfigAssign: TNotifyEvent read fOnConfigAssign write fOnConfigAssign;
    property DesignMode: boolean read fDesignMode write fDesignMode;
    property SelectedButton: TAdvSmoothButton read fSelectedButton;
    property SelectedButtonConfig: TJsonObject read GetSelectedButtonConfig; // write SetSelectedButtonConfig;
  end;

implementation

{$R *.dfm}

uses
  JsonToObject, Vista_MessageDlg;

function TfrButtonArray.AddKeypad(aKeypadName: string): boolean;
var
  x: integer;
  keypad: TJsonObject;
  ID: integer;
begin
  result:= false;
  if aKeypadNAme = '' then
    exit;
  if Assigned(fConfig) then begin
    ID:= 0;
    for x := 0 to fConfig.O['Keypads'].Count -1 do begin
      keypad:= fConfig.O['Keypads'].Items[x].Value.AsObject;
      if Lowercase(keypad.S['Name']) = Lowercase(aKeypadName) then begin
        MessageDlgXP_Vista('A keypad with the name "'  + keypad.S['Name'] + '" already exists.',
          mtInformation, [mbOk], 0);
        exit;
      end;
      if keypad.I['ID'] > ID then
        ID:= keypad.I['ID'];
    end;
    Inc(ID);
    keypad:= fConfig.O['Keypads'].O['Keypad_' + IntToStr(ID)];
    keypad.S['Name']:= aKeypadName;
    keypad.I['ID']:= ID;
    result:= true;
  end;
end;

procedure TfrButtonArray.ButtonClick(Sender: TObject);
begin
  if (not Assigned(fConfig)) or (not Assigned(fSelectedKeypad)) then
    exit;
  ClearSelected;
  fSelectedButton:= TAdvSmoothButton(Sender);
  if DesignMode then begin
    fSelectedButton.BevelColor:= clBlack;
    if Assigned(fOnButtonClick) then
      fOnButtonClick(TAdvSmoothButton(Sender),SelectedButtonConfig.S['FunctionType'],SelectedButtonConfig.S['FunctionValue']);
  end
  else begin
    { not design mode }
    if SelectedButtonConfig.S['FunctionType'] = 'Keypad' then begin
      { Change to that keypad ... }
      SelectedKeypadName:= SelectedButtonConfig.S['FunctionValue'];
    end
    else begin
      { Send the button ... }
      if Assigned(fOnButtonClick) then
        fOnButtonClick(TAdvSmoothButton(Sender),SelectedButtonConfig.S['FunctionType'],SelectedButtonConfig.S['FunctionValue']);
      if SelectedButtonConfig.B['HomeAfterClick'] then
        self.SelectedKeypadName:= 'Home';
    end;
  end;
end;

procedure TfrButtonArray.ButtonsToKeypad;
var
  x: integer;
  Button: TAdvSmoothButton;
begin
  for x := 0 to ComponentCount -1 do begin
    if Components[x] is TAdvSmoothButton then begin
      Button:= TAdvSmoothButton(Components[x]);
      { refresh JSON for each button }
      GetButtonConfig(Button);
    end;
  end;
end;

procedure TfrButtonArray.ClearSelected;
var
  x: integer;
begin
  fSelectedButton:= nil;
  if DesignMode then begin
    for x:= 0 to ComponentCount -1 do begin
      if Components[x] is TAdvSmoothButton then
        TAdvSmoothButton(Components[x]).BevelColor:= clWhite;
    end;
  end;
end;

constructor TfrButtonArray.Create(aOwner: TComponent);
var
  x: integer;
  obj: TJsonObject;
begin
  inherited;
  fSelectedButton:= nil;
  OrganiseButtons;
  DefaultButtonConfig:= TJsonObject.Create;
  obj:= DefaultButtonConfig.O['Button'];
  ObjToJson(Button_0_0.Appearance, obj.O['Appearance']);
  obj.S['Caption']:= Button_0_0.Caption;
  obj.I['Color']:= Button_0_0.Color;


  fConfig:= nil;
  fSelectedKeypad:= nil;
  fDesignMode:= false;
  for x := 0 to ComponentCount -1 do begin
    if Components[x] is TAdvSmoothButton then
      TAdvSmoothButton(Components[x]).OnClick:= ButtonClick;
  end;
end;

function TfrButtonArray.DeleteKeypad(aKeypadName: string): boolean;
var
  x: integer;
  keypad: TJsonObject;
begin
  result:= false;
  if aKeypadNAme = 'Home' then begin
    MessageDlgXP_Vista('The Home keypad can not be deleted.', mtInformation, [mbOK],0);
    exit;
  end;
  if MessageDlgXP_Vista('Are you sure you want to delete keypad "'  + aKeypadName + '"?',
          mtInformation, [mbOk, mbNo], 0) <> mrOk then
    exit;
  if Assigned(fConfig) then begin
    for x:= 0 to fConfig.O['Keypads'].Count -1 do begin
      keypad:= fConfig.O['Keypads'].Items[x].Value.AsObject;
      if Lowercase(keypad.S['Name']) = Lowercase(aKeypadName) then begin
        { if we are deleting the current page, change to somthing else }
        if keypad = fSelectedKeypad then
          SelectedKeypadName:= 'Home';
        fConfig.O['Keypads'].Delete(x);
        result:= true;
        fSelectedButton:= nil;
        fSelectedKeypad:= nil;
        exit;
      end;
    end;
  end;
end;

destructor TfrButtonArray.Destroy;
begin
//  fKeypadConfig.Free;
  DefaultButtonConfig.Free;
  inherited;
end;

procedure TfrButtonArray.FrameResize(Sender: TObject);
begin
  OrganiseButtons;
end;

function TfrButtonArray.GetButtonConfig(aButton: TAdvSmoothButton): TJsonObject;
var
  obj: TJsonObject;
begin
  result:= nil;
  if Assigned(fSelectedKeypad) then begin
    { save the properties we need from button into JSON }
    result:=fSelectedKeypad.O['Buttons'].O[aButton.Name];
    obj:= result.O['Button'];
    ObjToJson(aButton.Appearance, obj.O['Appearance']);
    obj.S['Caption']:= aButton.Caption;
    obj.I['Color']:= aButton.Color;
  end;
end;

function TfrButtonArray.GetSelectedButtonConfig: TJsonObject;
begin
  result:= nil;
  if Assigned(SelectedButton) then
    result:= ButtonConfig[SelectedButton];
end;

function TfrButtonArray.GetSelectedKeypadName: string;
begin
  result:= '';
  if Assigned(SelectedKeypad) then
    result:= SelectedKeypad.S['Name'];
end;

function TfrButtonArray.KeypadByName(aKeypadName: string): TJsonObject;
var
  x: integer;
  keypad: TJsonObject;
begin
  result:= nil;
  if Assigned(fConfig) then begin
    for x := 0 to fConfig.O['Keypads'].Count -1 do begin
      keypad:= fConfig.O['Keypads'].Items[x].Value.AsObject;
      if Lowercase(keypad.S['Name']) = Lowercase(aKeypadName) then begin
        result:= keypad;
        break;
      end;
    end;
  end;
end;

procedure TfrButtonArray.KeypadToButtons;
var
  x: integer;
  Button: TAdvSmoothButton;
begin
  for x := 0 to ComponentCount -1 do begin
    if Components[x] is TAdvSmoothButton then begin
      Button:= TAdvSmoothButton(Components[x]);
      ButtonConfig[Button]:= fSelectedKeypad.O['Buttons'].O[Button.Name];
    end;
  end;
end;

procedure TfrButtonArray.OrganiseButtons;
var
  newWidth, newHeight: integer;
  x,y: integer;
  ctrl: TControl;

  function ControlByName(aName: string): TControl;
  var i: integer;
  begin
    result:= nil;
    for i := 0 to Controlcount-1 do begin
      if Controls[i].Name = aName then begin
        result:= Controls[i];
        break;
      end;
    end;
  end;

begin
  newWidth:= Trunc(Width / 6);
  newHeight:= Trunc(Height / 6);
  for x := 0 to 5 do begin
    for y := 0 to 5 do begin
      ctrl:= ControlByName('Button_' + IntToStr(x) + '_' + IntToStr(y));
      ctrl.Width:= newWidth;
      ctrl.Height:= newHeight;
      ctrl.Left:= x * newWidth;
      ctrl.Top:= y * newHeight;
    end;
  end;
end;

procedure TfrButtonArray.PopulateKeypadNames(strings: TStrings;
  ExcludeSelected: boolean);
var
  x: integer;
  keypad: TJsonObject;
begin
  strings.Clear;
  if Assigned(fConfig) then begin
    for x := 0 to fConfig.O['Keypads'].Count -1 do begin
      keypad:= fConfig.O['Keypads'].Items[x].Value.AsObject;
      if ExcludeSelected and (Lowercase(keypad.S['Name']) = Lowercase(self.SelectedKeypadName)) then
        continue
      else
        strings.Add(keypad.S['Name']);
    end;
  end;
end;

procedure TfrButtonArray.RevertAllButtons;
var
  x: integer;
  obj: TJsonObject;
  Button: TAdvSmoothButton;
begin
  for x := 0 to ComponentCount-1 do begin
    if Components[x] is TAdvSmoothButton then begin
      Button:= TAdvSmoothButton(Components[x]);
      obj:= DefaultButtonConfig.O['Button'];
      JsonToObj(obj.O['Appearance'], Button.Appearance);
      Button.Caption:= obj.S['Caption'];
      Button.Color:= obj.I['Color'];
    end;
  end;
end;

procedure TfrButtonArray.ResetButton(aButton: TAdvSmoothButton);
var
  obj: TJsonObject;
begin
  if Assigned(fConfig) then begin
    obj:= ButtonConfig[aButton];
    obj.Clear;
    obj.Assign(DefaultButtonConfig);
    ButtonConfig[aButton]:= obj;
  end;
end;

procedure TfrButtonArray.SetButtonConfig(aButton: TAdvSmoothButton;
  const Value: TJsonObject);
var
  obj: TJsonObject;
begin
  { set the button properties we need from JSON }
  obj:= Value.O['Button'];
  if obj.Count > 0 then begin
    JsonToObj(obj.O['Appearance'],aButton.Appearance);
    aButton.Caption:= obj.S['Caption'];
    aButton.Color:= obj.I['Color'];
  end;
  if not DesignMode then
    aButton.Enabled:= Value.S['FunctionType'] <> ''
end;

procedure TfrButtonArray.SetConfig(const Value: TJsonObject);
begin
  fSelectedKeypad:= nil;
  FConfig := Value;
  ClearSelected;
  if Assigned(fConfig) then  begin
    { make sure we at least have a Home keypad }
    if fConfig.O['Keypads'].Count = 0 then begin
      fConfig.O['Keypads'].O['Keypad_1'].S['Name']:= 'Home';
      fConfig.O['Keypads'].O['Keypad_1'].I['ID']:= 1;
    end;
  end;
  if Assigned(fOnConfigAssign) then
    fOnConfigAssign(self);
end;

procedure TfrButtonArray.SetSelectedKeypadName(const Value: string);
var
  (* x: integer; *)
  keypad: TJsonObject;
begin
  if Assigned(Config) then begin
    { if we are in design mode save the current keypad back to json first }
    if DesignMode then
      ButtonsToKeypad;
    keypad:= KeypadByName(Value);
    if Assigned(keypad) then begin
      fSelectedKeypad:= keypad;
      RevertAllButtons;
      ClearSelected;
      KeypadToButtons;
      if Assigned(fOnKeypadSelect) then
        fOnKeypadSelect(self);
    end;
  end;
end;

end.
