unit VTEditControl;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, VirtualTrees, Menus, AdvMenus, ExtCtrls, StdCtrls, DNMPanel, ComCtrls, AdvOfficeStatusBar, ActiveX, DNMSpeedButton,
  BusObjProcess, dmGUIStylers, AppEvnts, Wwdbgrid, MyAccess, ERPdbComponents, wwcheckbox , mask ;

const
      cInputTypeText: array [TNodeInputType] of string = ('None', 'User', 'Option', 'Custom');
(*      cSubBOMProcessOrderText: array [TSubBOMProcessOrderCode] of string = ('Use In-Stock Stock For the "From Stock" Option and then Build the Balance',
                                                                            'Use the "From Stock" First and then Build the Balance',
                                                                            'Build the "To Build" Option First and then Use "From Stock" Option');*)
      cSubBOMProcessOrderText: array [TSubBOMProcessOrderCode] of string = ('Use In-Stock First and then Build Balance',
                                                                            'Take From Stock Irrelevant of Qty on Hand',
                                                                            'Build First, then Use In-Stock');

      cSubBOMProcessOrderValue: array [TSubBOMProcessOrderCode] of string = ('ASB','SB','BS');

Type

  TEditControlType = (ectNone, ectEdit, ectCheckBox, ectComboBox, ectDatePicker, ectButton);
  TCustomEditAction = procedure(const ClassStr: string; const TreeNode: TProcTreeNode) of object;

  TVTEditControlbase = class(TInterfacedObject)
  private
    procedure SetEdit(const Value: TMaskEdit (*TEdit*));
    procedure SetCheckBox(const Value: TCheckBox);
    procedure SetComboBox(const Value: TComboBox);
    procedure SetDateTimePicker(const Value: TDateTimePicker);
    procedure SetButton(const Value: TDNMSpeedButton);

    Procedure DoEditchange(Sender: TObject);
    function getControlType: TEditControlType;
    procedure SetControlType(const Value: TEditControlType);
  Protected
    FEdit: TMaskEdit (*TEdit*);
    FCheckBox: TCheckBox;
    FComboBox: TComboBox;
    FDateTimePicker: TDateTimePicker;
    FButton: TDNMSpeedButton;
    FTree: TCustomVirtualStringTree;
    FNode: PVirtualNode;
    FColumn: TColumnIndex;
    FTextBounds: TRect;
    FStopping: Boolean;
    FControlType: TEditControlType;
    fCustomEditHandle: TCustomEditAction;

    function getEditcontrol(aColumn: TColumnIndex): TEditControlType; virtual;
    procedure HandleComboBoxCloseUp(Sender: TObject);virtual;
    Property Editcontrol[fColumn : TColumnIndex ] : TEditControlType read getEditcontrol;
    Function Getinputtype(const Text :String):TNodeinputType;Virtual;
    function GetSubBOMProcessOrdercODE(const Text: String): TSubBOMProcessOrderCode;
    function GetSubBOMProcessOrder(const Text: String): String;
  public
    constructor Create;
    destructor Destroy; override;
    function DoBeginEdit: Boolean;
    function DoCancelEdit: Boolean;
    function DoGetBounds: TRect;
    function DoPrepareEdit(Tree: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex): Boolean;
    procedure DoProcessMessage(var message: TMessage);
    procedure DoSetBounds(R: TRect);
    property Column: TColumnIndex read FColumn;
    property Edit: TMaskEdit (*TEdit*) read FEdit write SetEdit;
    property CheckBox: TCheckBox read FCheckBox write SetCheckBox;
    property ComboBox: TComboBox read FComboBox write SetComboBox;
    property DateTimePicker: TDateTimePicker read FDateTimePicker write SetDateTimePicker;
    property Button: TDNMSpeedButton read FButton write SetButton;
    property ControlType: TEditControlType read getControlType write SetControlType;
    property CustomEditHandle: TCustomEditAction read fCustomEditHandle write fCustomEditHandle;
  end;


implementation

uses LogUtils;
  { TVTEditControl }

function TVTEditControlbase.getControlType: TEditControlType;
begin
  result := fControlType;
end;

function TVTEditControlbase.getEditcontrol(aColumn: TColumnIndex): TEditControlType;
begin
  result := ectNone;
end;

function TVTEditControlbase.Getinputtype(const Text: String): TNodeinputType;
var
  index: TNodeInputType;
begin
  try
    Result := itNone;
    index := low(TNodeInputType);

    while (index <= high(TNodeInputType)) and (not SysUtils.SameText(Text, cInputTypeText[index])) do index := Succ(index);

    if index <= high(TNodeInputType) then Result := index;
  except
    on E: Exception do begin
      LogD('TframeTree.GetInputType - Exception: ' + E.Message);
      raise;
    end;
  end;
end;
function TVTEditControlbase.GetSubBOMProcessOrder(const Text: String): String;
var
  index: TSubBOMProcessOrderCode;
begin
  try
    Result := cSubBOMProcessOrderValue[low(TSubBOMProcessOrderCode)];
    index := low(TSubBOMProcessOrderCode);

    while (index <= high(TSubBOMProcessOrderCode)) and (not SysUtils.SameText(Text, cSubBOMProcessOrderText[index])) do index := Succ(index);

    if index <= high(TSubBOMProcessOrderCode) then Result := cSubBOMProcessOrderValue[index];
  except
    on E: Exception do begin
      LogD('TframeTree.GetSubBOMProcessOrder - Exception: ' + E.Message);
      raise;
    end;
  end;
end;
function TVTEditControlbase.GetSubBOMProcessOrdercODE(const Text: String): TSubBOMProcessOrderCode;
var
  index: TSubBOMProcessOrderCode;
begin
  try
    Result := snpoASB;
    index := low(TSubBOMProcessOrderCode);

    while (index <= high(TSubBOMProcessOrderCode)) and (not SysUtils.SameText(Text, cSubBOMProcessOrderText[index])) do index := Succ(index);

    if index <= high(TSubBOMProcessOrderCode) then Result := index;
  except
    on E: Exception do begin
      LogD('TframeTree.GetSubBOMProcessOrder - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

function TVTEditControlBase.DoBeginEdit: Boolean;
begin
  REsult := True;
end;

function TVTEditControlBase.DoCancelEdit: Boolean;
begin
 try
    Result := not FStopping;

    if Result then begin
      FStopping := True;

      case ControlType of
        ectEdit: begin
            FEdit.Hide;
          end;

        ectCheckBox: begin
            FCheckBox.Hide;
          end;

        ectComboBox: begin
            FComboBox.Hide;
          end;

        ectDatePicker: begin
            FDateTimePicker.Hide;
          end;

        ectButton: begin
            FButton.Hide;
          end;
      end;

      FTree.CancelEditNode;
    end;
  except
    on E: Exception do begin
      LogD('TVTEditControl.CancelEdit - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

constructor TVTEditControlBase.Create;
begin
  try
    inherited;
    FControlType := ectNone;
    FEdit := TMaskEdit (*TEdit*).Create(nil);
    FCheckBox := TCheckBox.Create(nil);
    FComboBox := TComboBox.Create(nil);
    FDateTimePicker := TDateTimePicker.Create(nil);
    FButton := TDNMSpeedButton.Create(nil);
    FEdit.Hide;
    FCheckBox.Hide;
    FComboBox.Hide;
    FDateTimePicker.Hide;
    FButton.Hide;

  except
    on E: Exception do begin
      LogD('TVTEditControlBase.Create - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

destructor TVTEditControlBase.Destroy;
begin
  try
    FreeandNil(FEdit);
    FreeandNil(FCheckBox);
    FreeandNil(FComboBox);
    FreeandNil(FDateTimePicker);
    FreeandNil(FButton);
    inherited;
  except
    on E: Exception do begin
      LogD('TVTEditControlBase.Destroy - Exception: ' + E.Message);
      raise;
    end;
  end;
end;


function TVTEditControlBase.DoGetBounds: TRect;
begin
  try
    case ControlType of
      ectEdit: begin
          Result := FEdit.BoundsRect;
        end;

      ectCheckBox: begin
          Result := FCheckBox.BoundsRect;
        end;

      ectComboBox: begin
          Result := FComboBox.BoundsRect;
        end;

      ectDatePicker: begin
          Result := FDateTimePicker.BoundsRect;
        end;

      ectButton: begin
          Result := FButton.BoundsRect;
        end;
    else Result := Rect(0, 0, 0, 0);
    end;
  except
    on E: Exception do begin
      LogD('TVTEditControlBase.DoGetBounds - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

function TVTEditControlBase.DoPrepareEdit(Tree: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex): Boolean;
var
{$IFDEF COMPILER_22_UP}
  Text: string;
{$ELSE}
  Text: string;
{$ENDIF}
  Date: TDateTime;
begin
  try
    Result := Tree is TCustomVirtualStringTree;

    if Result then begin
      FNode := Node;
      FColumn := Column;
      FTree := TCustomVirtualStringTree(Tree);
      ControlType := Editcontrol[fColumn];

      case ControlType of
        ectEdit: begin
            FTree.GetTextInfo(Node, Column, FEdit.Font, FTextBounds, Text);
            FEdit.Onchange := DoEditchange;
            FEdit.Text := Text;
          end;

        ectCheckBox: begin
            FTree.GetTextInfo(Node, Column, FCheckBox.Font, FTextBounds, Text);
            FCheckBox.Checked := SysUtils.SameText(Text, 'Yes'  );
          end;

        ectComboBox: begin
            FTree.GetTextInfo(Node, Column, FComboBox.Font, FTextBounds, Text);
            FComboBox.ItemIndex := FComboBox.Items.IndexOf(Text);
          end;

        ectDatePicker: begin
            FTree.GetTextInfo(Node, Column, FDateTimePicker.Font, FTextBounds, Text);

            if TryStrToDate(Text, Date) then FDateTimePicker.Date := Date;
          end;

      end;
    end;
  except
    on E: Exception do begin
      LogD('TVTEditControlBase.DoPrepareEdit - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TVTEditControlBase.DoProcessMessage(var message: TMessage);
begin
  // Not used.
end;

procedure TVTEditControlBase.DoSetBounds(R: TRect);
begin
  try
    case ControlType of
      ectEdit: begin
          FEdit.BoundsRect := R;
        end;

      ectCheckBox: begin
          FCheckBox.BoundsRect := R;
        end;

      ectComboBox: begin
          FComboBox.BoundsRect := R;
        end;

      ectDatePicker: begin
          FDateTimePicker.BoundsRect := R;
        end;

      ectButton: begin
          FButton.BoundsRect := R;
          FButton.Width := R.Bottom - R.Top;
          R.Left := R.Left - 4;
          FButton.Left := R.Left + ((R.Right - R.Left - FButton.Width) div 2);
        end;
    end;
  except
    on E: Exception do begin
      LogD('TVTEditControlBase.DoSetBounds - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TVTEditControlBase.SetEdit(const Value: TMaskEdit (*TEdit*));
begin
  try
    if Value <> FEdit then begin
      FEdit.Free;
      FEdit := Value;
    end;
  except
    on E: Exception do begin
      LogD('TVTEditControlBase.SetEdit - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

(*procedure TVTEditControlBase.WaterMarkMsg(const value: String; parentObj:TObject);
begin
  if Assigned(parentObj) and (parentObj is Tcomponent) then
    if Assigned(TComponent(parentObj).owner) then
      if TComponent(parentObj).owner is TframeTree then
        TframeTree(TComponent(parentObj).Owner).WaterMarkMsg(Value);
end;*)

procedure TVTEditControlBase.SetCheckBox(const Value: TCheckBox);
begin
  try
    if Value <> FCheckBox then begin
      FCheckBox.Free;
      FCheckBox := Value;
    end;
  except
    on E: Exception do begin
      LogD('TVTEditControlBase.SetCheckBox - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TVTEditControlBase.SetComboBox(const Value: TComboBox);
begin
  try
    if Value <> FComboBox then begin
      FComboBox.Free;
      FComboBox := Value;
    end;
  except
    on E: Exception do begin
      LogD('TVTEditControlBase.SetComboBox - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TVTEditControlbase.SetControlType(const Value: TEditControlType);
begin
  fControlType := Value;
end;

procedure TVTEditControlBase.SetDateTimePicker(const Value: TDateTimePicker);
begin
  try
    if Value <> FDateTimePicker then begin
      FDateTimePicker.Free;
      FDateTimePicker := Value;
    end;
  except
    on E: Exception do begin
      LogD('TVTEditControlBase.SetDateTimePicker - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TVTEditControlBase.SetButton(const Value: TDNMSpeedButton);
begin
  try
    if Value <> FButton then begin
      FButton.Free;
      FButton := Value;
    end;
  except
    on E: Exception do begin
      LogD('TVTEditControlBase.SetButton - Exception: ' + E.Message);
      raise;
    end;
  end;
end;


Procedure TVTEditControlBase.DoEditchange(Sender: TObject);
begin

end;

procedure TVTEditControlBase.HandleComboBoxCloseUp(Sender: TObject);
begin

end;

end.
