unit frmdebugScrollbox;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, StdCtrls, ExtCtrls, DNMPanel, AdvScrollBox, Menus, DNMSpeedButton, ImageScroll;

type
  TfmdebugScrollbox = class(TfrmBaseGUI)
    sbPrefs: TAdvScrollBox;
    AdvScrollBox1: TAdvScrollBox;
    DNMSpeedButton1: TDNMSpeedButton;
    DNMSpeedButton2: TDNMSpeedButton;
    DNMSpeedButton3: TDNMSpeedButton;
    DNMSpeedButton4: TDNMSpeedButton;
    DNMSpeedButton5: TDNMSpeedButton;
    DNMSpeedButton6: TDNMSpeedButton;
    DNMSpeedButton7: TDNMSpeedButton;
    DNMSpeedButton8: TDNMSpeedButton;
    DNMSpeedButton9: TDNMSpeedButton;
    DNMSpeedButton10: TDNMSpeedButton;
    DNMSpeedButton11: TDNMSpeedButton;
    DNMSpeedButton12: TDNMSpeedButton;
    DNMSpeedButton13: TDNMSpeedButton;
    DNMSpeedButton14: TDNMSpeedButton;
    DNMSpeedButton15: TDNMSpeedButton;
    DNMSpeedButton16: TDNMSpeedButton;
    DNMSpeedButton17: TDNMSpeedButton;
    imgPrefs: TImage;
    ImageScroll: TImageScroll;
    procedure FormCreate(Sender: TObject);
    procedure buttonclick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses CommonLib, frmdebugScrollboxpanels, ImagesLib;

{$R *.dfm}


procedure TfmdebugScrollbox.buttonclick(Sender: TObject);
var
  comp :TComponent;
  x:Integer;
  ControlTop, ControlHeight   , NewPosition:Integer;
begin
  inherited;
  comp := FindExistingComponentbyname(Self, replacestr(TDNMSpeedbutton(sender).name, 'DNMSpeedButton' , 'DnmPanel' ), true);
        if Assigned(comp)  and (comp is TwinControl) then begin
            ControlTop := TwinControl(Comp).Top + TwinControl(Comp).Controls[2].Top;
            //Changecontrolfont(TwinControl(Comp).controls[controlindex]);
            ControlHeight := TwinControl(Comp).Controls[2].Height;
            NewPosition := System.Round((ControlTop - ((sbPrefs.ClientHeight - ControlHeight) / 2)) / ImageScrollHeightFactor(ImageScroll));

            if NewPosition > imgPrefs.ClientHeight then
              ImageScroll.PerformScroll(imgPrefs.ClientHeight)
            else if NewPosition > 0 then
              ImageScroll.PerformScroll(NewPosition);
            SetControlFocus(TwinControl(Comp));
        end;

      exit;


(*  if Assigned(comp)  and (comp is TControl) then begin
    x:= TControl(comp).top;
    if x> sbPrefs.Height then begin
    end;
  end;
  exit;*)

  if Assigned(comp)  and (comp is TControl) then
    if (TControl(Comp).parent = sbPrefs) then begin
      ImageScroll.Scrollbox := nil;
      try
        TScrollbox(sbPrefs).ScrollInView(TControl(Comp));
        TScrollbox(sbPrefs).VertScrollBar.Visible := True;
      finally
        x:= TScrollbox(sbPrefs).VertScrollBar.position;
        ImageScroll.PerformScroll(x);
        ImageScroll.Scrollbox := sbPrefs;
        ImageScroll.PerformScroll(x);
        TScrollbox(sbPrefs).VertScrollBar.Visible := True;
      end;
    end;
end;

procedure TfmdebugScrollbox.FormCreate(Sender: TObject);
var
  ctr:Integer;
  form :Tcomponent;
begin
  inherited;
  form := getcomponentbyclassname('TfmdebugScrollboxpanels' , true, self);
  if form = nil then exit;
  for ctr:= 0 to TfmdebugScrollboxpanels(Form).componentcount-1 do begin
    if TfmdebugScrollboxpanels(Form).Components[ctr] is TDNMpanel then begin
      TDNMpanel(TfmdebugScrollboxpanels(Form).Components[ctr]).Parent :=  sbPrefs;
      TDNMpanel(TfmdebugScrollboxpanels(Form).Components[ctr]).Align := alTop;
      TDNMpanel(TfmdebugScrollboxpanels(Form).Components[ctr]).Visible := True;
    end else if (TfmdebugScrollboxpanels(Form).Components[ctr] is TLabel) and (TLabel(TfmdebugScrollboxpanels(Form).Components[ctr]).Parent is TDNMPanel) then begin
//      TLabel(TfmdebugScrollboxpanels(Form).Components[ctr]).name :='label'+inttostr(ctr);
      TLabel(TfmdebugScrollboxpanels(Form).Components[ctr]).Caption := TDNMPanel(TLabel(TfmdebugScrollboxpanels(Form).Components[ctr]).Parent).Name +'.' +TLabel(TfmdebugScrollboxpanels(Form).Components[ctr]).name;
    end else if (TfmdebugScrollboxpanels(Form).Components[ctr] is TEdit) and (TEdit(TfmdebugScrollboxpanels(Form).Components[ctr]).Parent is TDNMPanel) then begin
//      TEdit(TfmdebugScrollboxpanels(Form).Components[ctr]).Name := 'Edit'+inttostr(ctr);
      TEdit(TfmdebugScrollboxpanels(Form).Components[ctr]).text := TDNMPanel(TLabel(TfmdebugScrollboxpanels(Form).Components[ctr]).Parent).Name +'.' +TEdit(TfmdebugScrollboxpanels(Form).Components[ctr]).Name ;
    end;
  end;
  for ctr:= 0 to componentcount-1 do begin
    if Components[ctr] is TDNMSpeedbutton  then begin
        TDNMSpeedbutton(Components[ctr]).Caption := replacestr(TDNMSpeedbutton(Components[ctr]).name, 'DNMSpeedButton' , '');
    end;
  end;
end;
initialization
  RegisterClassOnce(TfmdebugScrollbox);

end.

