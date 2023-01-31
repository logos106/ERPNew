unit ObjGuiBindingObj;

interface

uses
  classes, contnrs;

type

  TObjGuiBinding = class;
  TObjGuiBindings = class(TComponent)
  private
    fObj: TObject;
    fList,
    fEventList: TObjectList;
    fPopulatingGui: boolean;
    procedure DoOnNotify(Sender : TObject);
    function BindingByComponent(aComponent: TComponent): TObjGuiBinding;
//    procedure ClearEvents;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Obj: TObject read fObj write fObj;
    procedure AddBinding(aComponent: TComponent; aPropName: string; aObj: TObject); overload;
    procedure AddBinding(aComponent: TComponent; aPropName: string); overload;
    procedure PopulateGUI;
    procedure AutoLoad;
    procedure Clear;
  end;

  TObjGuiBinding = class(TObject)
  public
    Component: TComponent;
    Obj: TObject;
    ObjPropertyName: string;
  end;

  TEventType = (etOnChange, etOnClick);

  TEventRec = class(TObject)
  public
    Component: TComponent;
    EventType: TEventType;
    Method: TMethod;
//    Code,
//    Data: Pointer;
  end;

implementation

uses
  stdCtrls, typinfo, sysUtils, Controls,
  wwCheckBox,
  AdvEdit, AdvSpin;

{ TObjGuiBindings }

procedure TObjGuiBindings.AddBinding(aComponent: TComponent; aPropName: string;
  aObj: TObject);
var
  bind: TObjGuiBinding;
  eventRec: TEventRec;
begin
  bind := TObjGuiBinding.Create;
  bind.Component := aComponent;
  bind.Obj := aObj;
  bind.ObjPropertyName := aPropName;
  if aComponent is TEdit then begin
    { save assigned events }
    if Assigned(Tedit(aComponent).OnChange) then begin
      eventRec := TEventRec.Create;
      eventRec.Component := aComponent;
      eventRec.Method := TMethod(TEdit(aComponent).OnChange);
      eventRec.EventType := etOnChange;
      fEventList.Add(eventRec);
    end;
    Tedit(aComponent).OnChange := DoOnNotify;
  end
  else if aComponent is TCheckBox then begin
    { save assigned events }
    if Assigned(TCheckBox(aComponent).OnClick) then begin
      eventRec := TEventRec.Create;
      eventRec.Component := aComponent;
      eventRec.Method := TMethod(TCheckBox(aComponent).OnClick);
      eventRec.EventType := etOnClick;
      fEventList.Add(eventRec);
    end;
    TCheckBox(aComponent).OnClick := DoOnNotify;
  end
  else if aComponent is TwwCheckBox then begin
    { save assigned events }
    if Assigned(TwwCheckBox(aComponent).OnClick) then begin
      eventRec := TEventRec.Create;
      eventRec.Component := aComponent;
      eventRec.Method := TMethod(TwwCheckBox(aComponent).OnClick);
      eventRec.EventType := etOnClick;
      fEventList.Add(eventRec);
    end;
    TwwCheckBox(aComponent).OnClick := DoOnNotify;
  end
  else if aComponent is TComboBox then begin
    { save assigned events }
    if Assigned(TComboBox(aComponent).OnChange) then begin
      eventRec := TEventRec.Create;
      eventRec.Component := aComponent;
      eventRec.Method := TMethod(TComboBox(aComponent).OnChange);
      eventRec.EventType := etOnChange;
      fEventList.Add(eventRec);
    end;
    TComboBox(aComponent).OnChange := DoOnNotify;
  end
  else if aComponent is TAdvEdit then begin
    { save assigned events }
    if Assigned(TAdvEdit(aComponent).OnChange) then begin
      eventRec := TEventRec.Create;
      eventRec.Component := aComponent;
      eventRec.Method := TMethod(TAdvEdit(aComponent).OnChange);
      eventRec.EventType := etOnChange;
      fEventList.Add(eventRec);
    end;
    TAdvEdit(aComponent).OnChange := DoOnNotify;
  end
  else if aComponent is TAdvSpinEdit then begin
    { save assigned events }
    if Assigned(TAdvSpinEdit(aComponent).OnChange) then begin
      eventRec := TEventRec.Create;
      eventRec.Component := aComponent;
      eventRec.Method := TMethod(TAdvSpinEdit(aComponent).OnChange);
      eventRec.EventType := etOnChange;
      fEventList.Add(eventRec);
    end;
    TAdvSpinEdit(aComponent).OnChange := DoOnNotify;
  end
  else if aComponent is TMemo then begin
    { save assigned events }
    if Assigned(TMemo(aComponent).OnChange) then begin
      eventRec := TEventRec.Create;
      eventRec.Component := aComponent;
      eventRec.Method := TMethod(TMemo(aComponent).OnChange);
      eventRec.EventType := etOnChange;
      fEventList.Add(eventRec);
    end;
    TMemo(aComponent).OnChange := DoOnNotify;
  end;


  fList.Add(bind);
end;

procedure TObjGuiBindings.AddBinding(aComponent: TComponent; aPropName: string);
begin
  AddBinding(aComponent, aPropName, fObj);
end;

procedure TObjGuiBindings.AutoLoad;

  procedure GetComponents(aComp: TComponent);
  var
    cmp: TComponent;
    x: integer;
  begin
    for x := 0 to aComp.ComponentCount -1 do begin
      cmp := aComp.Components[x];
      if (cmp is TControl) then begin
        if Assigned(GetPropInfo(fObj,cmp.Name)) then
          AddBinding(cmp,cmp.Name);
      end;
      GetComponents(cmp);
    end;
  end;

begin
  if Assigned(Owner) and Assigned(fObj) then begin
    GetComponents(Owner);
  end;
end;

function TObjGuiBindings.BindingByComponent(aComponent: TComponent): TObjGuiBinding;
var
  x: integer;
begin
  result := nil;
  for x := 0 to fList.Count -1 do begin
    if TObjGuiBinding(fList[x]).Component = aComponent then begin
      result := TObjGuiBinding(fList[x]);
      break;
    end;
  end;
end;

procedure TObjGuiBindings.Clear;
begin
  fEventList.Clear;

end;

//procedure TObjGuiBindings.ClearEvents;
//var
//  x: integer;
//  EventRec: TEventRec;
//begin
// while fEventList.Count > 0 do begin
//   EventRec := TEventRec(fEventList[0]);
//   if EventRec.Component is TEdit then begin
//     case EventRec.EventType of
//       etOnChange: TEdit(EventRec.Component).OnChange := TNotifyEvent(EventRec.Method);
//       etOnClick: ;
//     end;
//   end
//   else if EventRec.Component is TCheckBox then begin
//     case EventRec.EventType of
//       etOnChange: ;
//       etOnClick: TCheckBox(EventRec.Component).OnClick := TNotifyEvent(EventRec.Method);
//     end;
//   end
//   else if EventRec.Component is TwwCheckBox then begin
//     case EventRec.EventType of
//       etOnChange: ;
//       etOnClick: TwwCheckBox(EventRec.Component).OnClick := TNotifyEvent(EventRec.Method);
//     end;
//   end
//   else if EventRec.Component is TComboBox then begin
//     case EventRec.EventType of
//       etOnChange: TComboBox(EventRec.Component).OnChange := TNotifyEvent(EventRec.Method);
//       etOnClick: TComboBox(EventRec.Component).OnClick := TNotifyEvent(EventRec.Method);
//     end;
//   end
//   else if EventRec.Component is TAdvEdit then begin
//     case EventRec.EventType of
//       etOnChange: TAdvEdit(EventRec.Component).OnChange := TNotifyEvent(EventRec.Method);
//       etOnClick: TAdvEdit(EventRec.Component).OnClick := TNotifyEvent(EventRec.Method);
//     end;
//   end
//   else if EventRec.Component is TAdvSpinEdit then begin
//     case EventRec.EventType of
//       etOnChange: TAdvSpinEdit(EventRec.Component).OnChange := TNotifyEvent(EventRec.Method);
//       etOnClick: TAdvSpinEdit(EventRec.Component).OnClick := TNotifyEvent(EventRec.Method);
//     end;
//   end
//   else if EventRec.Component is TMemo then begin
//     case EventRec.EventType of
//       etOnChange: TMemo(EventRec.Component).OnChange := TNotifyEvent(EventRec.Method);
//       etOnClick: TMemo(EventRec.Component).OnClick := TNotifyEvent(EventRec.Method);
//     end;
//   end;
//   fEventList.Delete(0);
// end;
//end;

constructor TObjGuiBindings.Create(AOwner: TComponent);
begin
  inherited;
  fPopulatingGui := false;
  fList := TObjectList.Create;
  fEventList := TObjectList.Create;
end;

destructor TObjGuiBindings.Destroy;
begin
  fList.Free;
  fEventList.Free;
  inherited;
end;

procedure TObjGuiBindings.DoOnNotify(Sender: TObject);
var
  x: integer;
  eventRec: TEventRec;
  bind: TObjGuiBinding;
begin
  if fPopulatingGui then exit;

  { call any saved events }
  for x := 0 to fEventList.Count -1 do begin
    eventRec := TEventRec(fEventList[x]);
    if eventRec.Component = Sender then begin
      if (eventRec.EventType = etOnChange) or (eventRec.EventType = etOnClick) then
        TNotifyEvent(eventRec.Method)(Sender);


    end;
  end;
  { now handle the event }
  bind := nil;
  if Sender is TComponent then
    bind := self.BindingByComponent(TComponent(Sender));
  if Assigned(bind) then begin
    if Sender is TEdit then
      SetPropValue(bind.Obj,bind.ObjPropertyName,TEdit(Sender).Text)
    else if Sender is TCheckBox then begin
      if TCheckBox(Sender).Checked then
        SetEnumProp(Obj,bind.ObjPropertyName,'True')
      else
        SetEnumProp(Obj,bind.ObjPropertyName,'False');
    end
    else if Sender is TwwCheckBox then begin
      if TwwCheckBox(Sender).Checked then
        SetEnumProp(Obj,bind.ObjPropertyName,'True')
      else
        SetEnumProp(Obj,bind.ObjPropertyName,'False');
    end
    else if Sender is TComboBox then
      SetPropValue(bind.Obj,bind.ObjPropertyName,TComboBox(Sender).Text)
    else if Sender is TAdvEdit then begin
      if TAdvEdit(Sender).EditType in [etFloat, etMoney, etNumeric] then
        SetPropValue(bind.Obj,bind.ObjPropertyName,TAdvEdit(Sender).FloatValue)
      else
        SetPropValue(bind.Obj,bind.ObjPropertyName,TAdvEdit(Sender).Text);
    end
    else if Sender is TAdvSpinEdit then begin
      SetPropValue(bind.Obj,bind.ObjPropertyName,TAdvSpinEdit(Sender).Value)
    end
    else if Sender is TMemo then begin
      SetPropValue(bind.Obj,bind.ObjPropertyName,TMemo(Sender).Text)
    end;

  end;
end;

procedure TObjGuiBindings.PopulateGUI;
var
  x: integer;
  bind: TObjGuiBinding;
begin
  fPopulatingGui := true;
  try
    for x := 0 to fList.Count -1 do begin
      bind := TObjGuiBinding(fList[x]);
      if bind.Component is TEdit then
        TEdit(bind.Component).Text := GetPropValue(bind.Obj, bind.ObjPropertyName)
      else if bind.Component is TCheckBox then
        TCheckBox(bind.Component).Checked := SameText(GetEnumProp(bind.Obj, bind.ObjPropertyName), 'True')
      else if bind.Component is TwwCheckBox then
        TwwCheckBox(bind.Component).Checked := SameText(GetEnumProp(bind.Obj, bind.ObjPropertyName), 'True')
      else if bind.Component is TComboBox then begin
        if TComboBox(bind.Component).Style = csDropDownList then
          TComboBox(bind.Component).ItemIndex := TComboBox(bind.Component).Items.IndexOf(GetPropValue(bind.Obj, bind.ObjPropertyName))
        else
          TComboBox(bind.Component).Text := GetPropValue(bind.Obj, bind.ObjPropertyName);
      end
      else if bind.Component is TAdvEdit then begin
        if TAdvEdit(bind.Component).EditType in [etFloat, etMoney, etNumeric] then
          TAdvEdit(bind.Component).FloatValue := GetPropValue(bind.Obj, bind.ObjPropertyName)
        else
          TAdvEdit(bind.Component).Text := GetPropValue(bind.Obj, bind.ObjPropertyName);
      end
      else if bind.Component is TAdvSpinEdit then begin
        TAdvSpinEdit(bind.Component).Value := GetPropValue(bind.Obj, bind.ObjPropertyName)
      end
      else if bind.Component is TMemo then
        TMemo(bind.Component).Text := GetPropValue(bind.Obj, bind.ObjPropertyName);

    end;

  finally
    fPopulatingGui := false;
  end;
end;

end.
