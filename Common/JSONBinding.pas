unit JSONBinding;

interface

uses
  Classes, Controls, JsonObject, ConTnrs;

type

  TJSONBindings = class;

  TJsonBinding = class
  private
    FControl: TControl;
    Bindings: TJSONBindings;
    FJSONValuePair: TJSONValuePair;
    procedure SetControl(const Value: TControl);
    procedure SetJSONValuePair(const Value: TJSONValuePair);
    procedure ActivateBinding;
    procedure DoOnChange(Sender: TObject);
    procedure DoOnClick(Sender: TObject);
  public
    constructor Create(aBindings: TJSONBindings);
    property JSONValuePair: TJSONValuePair read FJSONValuePair write SetJSONValuePair;
    property Control: TControl read FControl write SetControl;
  end;

  TJSONBindings = class(TComponent)
  private
    fList: TObjectList;
    fJSONObject: TJsonObject;
    fDirty: boolean;
    fOnChange: TNotifyEvent;
    procedure SetJSONObject(const Value: TJsonObject);
    procedure SetDirty(const Value: boolean);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property JSONObject: TJsonObject read fJSONObject write SetJSONObject;
    procedure AddBinding(const aJSONValuePair: TJSONValuePair; aControl: TControl); overload;
    procedure AddBinding(const aValueName: string; aValueType: TJSONValueType; aControl: TControl); overload;
    property Dirty: boolean read fDirty write SetDirty;
    property OnChange: TNotifyEvent read fOnChange write fOnChange;
  end;

implementation

uses
  SysUtils, StdCtrls, AdvEdit, wwdbdatetimepicker;

{ TJsonBinding }

procedure TJsonBinding.ActivateBinding;
begin
  if Assigned(fControl) and Assigned(FJSONValuePair) then begin
    if fControl is TEdit then begin
      TEdit(fControl).Text := FJSONValuePair.Value.AsString;
      TEdit(fControl).OnChange := DoOnChange;
    end
    else if fControl is TAdvEdit then begin
      TAdvEdit(fControl).Text := FJSONValuePair.Value.AsString;
      TAdvEdit(fControl).OnChange := DoOnChange;
    end
    else if fControl is TComboBox then begin
      TComboBox(fControl).ItemIndex := TComboBox(fControl).Items.IndexOf(FJSONValuePair.Value.AsString);
      TComboBox(fControl).OnChange := DoOnChange;
    end
    else if fControl is TCheckBox then begin
      TCheckBox(fControl).Checked := FJSONValuePair.Value.AsBoolean;
      TCheckBox(fControl).OnClick := DoOnClick;
    end
    else if fControl is TLabel then begin
      TLabel(fControl).Caption := FJSONValuePair.Value.AsString;
    end
    else if fControl is TwwDBDateTimePicker then begin
      TwwDBDateTimePicker(fControl).DateTime := FJSONValuePair.Value.AsDateTime;
      TwwDBDateTimePicker(fControl).OnChange := DoOnChange;
    end
  end;

end;

constructor TJsonBinding.Create(aBindings: TJSONBindings);
begin
  Bindings := aBindings;
end;

procedure TJsonBinding.DoOnChange(Sender: TObject);
begin
  if Assigned(fControl) and Assigned(FJSONValuePair) then begin
    if Sender is Tedit then begin
      if not SameText(FJSONValuePair.Value.AsString, TEdit(Sender).Text) then begin
        FJSONValuePair.Value.AsString :=  TEdit(Sender).Text;
        Bindings.Dirty := true;
      end;
    end
    else if Sender is TAdvEdit then begin
      if not SameText(FJSONValuePair.Value.AsString, TAdvEdit(Sender).Text) then begin
        FJSONValuePair.Value.AsString :=  TAdvEdit(Sender).Text;
        Bindings.Dirty := true;
      end;
    end
    else if Sender is TComboBox then begin
      FJSONValuePair.Value.AsString :=  TComboBox(Sender).Text;
      Bindings.Dirty := true;
    end
    else if Sender is TwwDBDateTimePicker then begin
      if FJSONValuePair.Value.AsDateTime <> TwwDBDateTimePicker(Sender).DateTime then begin
        FJSONValuePair.Value.AsDateTime:=  TwwDBDateTimePicker(Sender).DateTime;
        Bindings.Dirty := true;
      end;
    end
  end;
end;

procedure TJsonBinding.DoOnClick(Sender: TObject);
begin
  if Assigned(fControl) and Assigned(FJSONValuePair) then begin
    if Sender is TCheckBox then begin
      if FJSONValuePair.Value.AsBoolean <> TCheckBox(Sender).Checked then begin
        FJSONValuePair.Value.AsBoolean := TCheckBox(Sender).Checked;
        Bindings.Dirty := true;
      end;
    end;
  end;
end;

procedure TJsonBinding.SetControl(const Value: TControl);
begin
  FControl := Value;
  ActivateBinding;
end;

procedure TJsonBinding.SetJSONValuePair(const Value: TJSONValuePair);
begin
  FJSONValuePair := Value;
  ActivateBinding;
end;

{ TJSONBindings }

procedure TJSONBindings.AddBinding(const aJSONValuePair: TJSONValuePair;
  aControl: TControl);
var
  NewBinding: TJsonBinding;
begin
  if not Assigned(aJSONValuePair) then
    raise Exception.Create(self.Classname + ' - JSONValue is nil');
  if not Assigned(aControl) then
    raise Exception.Create(self.Classname + ' - Control is nil');
  NewBinding := TJsonBinding.Create(self);
  NewBinding.JSONValuePair := aJSONValuePair;
  NewBinding.Control := aControl;
  fList.Add(NewBinding);
end;

procedure TJSONBindings.AddBinding(const aValueName: string;
  aValueType: TJSONValueType; aControl: TControl);
var
  ValPair: TJSONValuePair;
begin
  ValPair := fJSONObject.ItemByName[aValueName];
  if not assigned(ValPair) then begin
    { force creation of json value }
    case aValueType of
      valNone:;
      valString: fJSONObject.S[aValueName];
      valNumber: fJSONObject.F[aValueName];
      valObject: fJSONObject.O[aValueName];
      valArray: fJSONObject.A[aValueName];
      valNull:;
      valBoolean: fJSONObject.B[aValueName];
    end;
  end;
  ValPair := fJSONObject.ItemByName[aValueName];
  AddBinding(ValPair, aControl);
end;

constructor TJSONBindings.Create(AOwner: TComponent);
begin
  inherited;
  fList := TObjectList.Create;
end;

destructor TJSONBindings.Destroy;
begin
  fList.Free;
  inherited;
end;

procedure TJSONBindings.SetDirty(const Value: boolean);
begin
  fDirty := Value;
  if fDirty then begin
    if Assigned(fOnChange) then
      fOnChange(self);
  end;
end;

procedure TJSONBindings.SetJSONObject(const Value: TJsonObject);
begin
  fJSONObject := Value;
end;

end.
