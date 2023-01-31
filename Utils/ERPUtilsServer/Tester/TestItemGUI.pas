unit TestItemGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, TesterObj, ExtCtrls, Buttons;

type
  TTestItemFrame = class(TFrame)
    lblCaption: TLabel;
    Bevel1: TBevel;
    btnResult: TBitBtn;
    procedure btnResultClick(Sender: TObject);
  private
    fExpanded: boolean;
    fTestStep: TTestStep;
    fUnexpandedHeight: integer;
    procedure SetExpanded(const Value: boolean);
    procedure SetTestStep(const Value: TTestStep);
    procedure UpdateDisplay;
    procedure AdjustParent;
    procedure DoOnTestStart(Step: TTestStep);
    procedure DoOnTestFinish(Step: TTestStep);
    procedure DoOnStatusChange(Step: TTestStep);
    procedure DoOnClick(Sender: TObject);
    procedure DoOnMouseEnter(Sender: TObject);
    procedure DoOnMouseLeave(Sender: TObject);

  public
    constructor Create(AOwner: TComponent); override;
    property Expanded: boolean read fExpanded write SetExpanded;
    property TestStep: TTestStep read fTestStep write SetTestStep;
  end;

implementation

{$R *.dfm}

uses
  ShellAPI;

{ TTestItemFrame }

procedure TTestItemFrame.AdjustParent;
var
  x: integer;
  lastFrame: TTestItemFrame;
begin
  if Assigned(Parent) then begin
    lastFrame := nil;
    for x := 0 to Parent.ControlCount -1 do begin
      if Parent.Controls[x] is TTestItemFrame then begin
        TTestItemFrame(Parent.Controls[x]).Width := Parent.ClientWidth;
        if Assigned(lastFrame) then
          TTestItemFrame(Parent.Controls[x]).Top := lastFrame.Top + lastFrame.Height
        else
          TTestItemFrame(Parent.Controls[x]).Top := 0 - TScrollBox(Parent).VertScrollBar.Position;
        lastFrame := TTestItemFrame(Parent.Controls[x]);
      end;
    end;
  end;
end;

procedure TTestItemFrame.btnResultClick(Sender: TObject);
begin
  Expanded := not Expanded;
  Width := Width + 1;
  Width := Width - 1;
end;

constructor TTestItemFrame.Create(AOwner: TComponent);
begin
  inherited;
  fExpanded := false;
  fUnexpandedHeight := self.Height;
  fTestStep := nil;
end;

procedure TTestItemFrame.DoOnClick(Sender: TObject);
begin
  if (Sender is TLabel) then begin
    if Pos('http',Trim(TLabel(Sender).Caption)) = 1 then begin
      ShellExecute(self.WindowHandle,'open',PChar(Trim(TLabel(Sender).Caption)),nil,nil, SW_SHOWNORMAL);

    end;

  end;

end;

procedure TTestItemFrame.DoOnMouseEnter(Sender: TObject);
begin
  Screen.Cursor := crHandPoint;
end;

procedure TTestItemFrame.DoOnMouseLeave(Sender: TObject);
begin
  Screen.Cursor := crDefault;
end;

procedure TTestItemFrame.DoOnStatusChange(Step: TTestStep);
begin
  self.UpdateDisplay;
end;

procedure TTestItemFrame.DoOnTestFinish(Step: TTestStep);
begin
  self.UpdateDisplay;
end;

procedure TTestItemFrame.DoOnTestStart(Step: TTestStep);
begin
  self.UpdateDisplay;
end;

procedure TTestItemFrame.SetExpanded(const Value: boolean);
var
  x: integer;
  lbl, lastLbl: TLabel;
begin
  lbl := nil;
  lastLbl := nil;
  if fExpanded <> Value then begin
    fExpanded := Value;
    if fExpanded then begin
      { expand }
      if Assigned(TestStep) then begin
        for x := 0 to TestStep.Details.Count -1 do begin
          lbl:= TLabel.Create(self);
          lbl.Parent := self;
          lbl.Name := 'lblDetail' + IntToStr(x);
          lbl.AutoSize := false;
          lbl.WordWrap := false;
          lbl.Font.Name := 'Consolas'; //'Courier New';
          lbl.Font.Size := 10;
          lbl.Left := lblCaption.Left + 20;
          lbl.Width := (btnResult.Left + btnResult.Width) - lblCaption.Left - 20;
          if Assigned(lastLbl) then
            lbl.Top := lastLbl.Top + lastLbl.Height + 2
          else
            lbl.Top := lblCaption.Top + lblCaption.Height + 10;
          lastLbl := lbl;
          lbl.Caption := TestStep.Details[x];
          if (Pos('http',Trim(lbl.Caption)) = 1) then begin
            lbl.Font.Color := clBlue;
            lbl.Font.Style := lbl.Font.Style + [fsUnderline];
            lbl.OnClick := DoOnClick;
            lbl.OnMouseEnter := DoOnMouseEnter;
            lbl.OnMouseLeave := DoOnMouseLeave;
          end;

          lbl.Anchors:= [akLeft,akRight,akTop];
        end;
        if Assigned(lbl) then begin
          self.Height := self.Height + (TestStep.Details.Count * lbl.Height) + ((TestStep.Details.Count -1) * 2);
          AdjustParent;
        end;
      end;
    end
    else begin
      { contract }
     x:= 0;
     while x < self.ControlCount do begin
       if (Controls[x] is TLabel) and (Pos('lblDetail', Controls[x].Name) = 1) then
         Controls[x].Free
       else
         Inc(x);
     end;
     self.Height := fUnexpandedHeight;
     AdjustParent;
    end;
  end;
end;

procedure TTestItemFrame.SetTestStep(const Value: TTestStep);
begin
  fTestStep := Value;
  fTestStep.OnTestStepStart := DoOnTestStart;
  fTestStep.OnTestStepFinish := DoOnTestFinish;
  fTestStep.OnStatusChange := DoOnStatusChange;
  UpdateDisplay;
end;

procedure TTestItemFrame.UpdateDisplay;
begin
  if Assigned(TestStep) then begin
    lblCaption.Caption := IntToStr(TestStep.StepNumber) + ')  ' +  TestStep.Caption;
    case TestStep.Status of
      tssUntested:
        begin
          btnResult.Caption := 'Not Tested';
          btnResult.Font.Color := clBlack;
        end;
      tssTesting:
        begin
          btnResult.Caption := 'Testing';
          btnResult.Font.Color := clBlue;
        end;
      tssPass:
        begin
          btnResult.Caption := 'Pass';
          btnResult.Font.Color := clGreen;
        end;
      tssFail:
        begin
          btnResult.Caption := 'Fail';
          btnResult.Font.Color := clRed;
        end;
      tssWarn:
        begin
          btnResult.Caption := 'Warning';
          btnResult.Font.Color := $000080FF;
        end;
    end;
  end
  else begin
    lblCaption.Caption := 'Unknown';
    btnResult.Caption := 'Not Tested';
    btnResult.Font.Color := clBlack;
  end;
  if Expanded then begin
    Expanded:= false;
    Expanded:= true;
    Parent.Width := Parent.Width + 1;
    Parent.Width := Parent.Width - 1;
  end;
  Application.ProcessMessages;
end;

end.
