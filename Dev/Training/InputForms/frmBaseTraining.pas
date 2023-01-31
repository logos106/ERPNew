unit frmBaseTraining;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  BusobjTraining,BusObjBase, DNMPanel, DNMSpeedButton, StdCtrls, ProgressDialog;
const
    ERPHints :Array[1..11] of String =
    ({1}(*'First Thing To Do is'+*)'Select the Dates For Training.',
     {2}'After Selecting the Training Dates, ' +chr(13) +'Please Select ''Employees For Training'' (Tab Above The ''Training Scheduled For'')',
     {3}'''Choose Employees For Training'' by Selecting ' +chr(13) +'The Button Highlighted At The Bottom',
     {4}'''Auto Schedule'' : Schedule the Selected Employees For Training' +chr(13) +'on the Days Selected.',
     //'  The order of the modules Can be' +chr(13) +'             Viewed or Changed in ''Training Modules''         ' +
     //chr(13) +'''Save'' : Will Save the current Changes and close this                     ' +chr(13) +'      Form and will Take you to ERP''s Main Form         ',
     {5}'Select the Employees to Allocate for Training in ERP.  ' +chr(13) +'Hold Down CTRL to Select Multiple.',
     {6}'Select the Employees to Allocate for Training in ERP.  ' +chr(13) +'Hold Down CTRL to Select Multiple. ' +chr(13) +'''Close'' Will Assign the Selected Employees for Training',
     {7}'Double Click on ''Questions''(CTRL+D) Column To See The Details'+chr(13) +'Double Click on ''Watch Video''(CTRL+V) Column To View the Video'+chr(13) +chr(13)+'''Save'' Will Save the Changes And Close The form',
     {8}'''Show Video'' To View the Video of the Selected Module'+chr(13) +'''Save'' Will Save the Changes And Close The form',
     {9}'This Is Your Current Status',//+chr(13) +'Choose ''Show.....'' To Show the Progress of Current Employee or All Employees'+chr(13)+'''Print'' will Print the Current Status.',
     {10}'Auto Schedule Will Schedule the Training in this Order'+chr(13)+'Please Use the ''Up Arrow'' or ''Down Arrow'' to Change The Order' ,
          'First Thing To Do is To Select Times For a Normal Working Day.');

type
  TfmBaseTraining = class(TBaseInputGUI)
    Timer11: TTimer;
    pnlForm: TDNMPanel;
    pnlTop: TDNMPanel;
    pnlbottom: TDNMPanel;
    pnlmain: TDNMPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private

    Procedure ShowERPHint(Const Value:String); overload;

  Protected
    Procedure ShowERPHint(Const Value:Integer); overload;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string); Override;
    Procedure onShowERPHint(Const Value:Integer); virtual;

  public
    { Public declarations }
  end;


implementation

uses frmERPHint, BusObjConst, CommonLib, MAIN, MainSwitchFrm2, CommonFormLib;




{$R *.dfm}

procedure TfmBaseTraining.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
begin
  inherited ;
  // descendats will override
end;

procedure TfmBaseTraining.FormCreate(Sender: TObject);
begin
  inherited;
  fbTabSettingEnabled := False;
  HighlightedCurrentComponent:=nil;
  HighlightedExtraCurrentComponent1:=nil;
  HighlightedExtraCurrentComponent2:=nil;
end;

procedure TfmBaseTraining.ShowERPHint(const Value: String);
begin
  TfmERPHint.ShowERPHint(Value , self);
(*var
  Form :TfmERPHint;
begin
  form :=TfmERPHint(GetComponentByClassName('TfmERPHint'));
  if Assigned(form) THEN begin
    if form.visible = False then begin
      if self.FormStyle = fsmdichild then begin
        Form.Ownerformtop := Self.top;
        Form.formstyle := fsMdichild;
      end else begin
        form.Show;
        Form.Ownerformtop := Self.top;
      end;
      Form.Left := Self.Left+10;
      Form.width := Self.width-20;
      form.Top := Self.top;
      {if self.FormStyle = fsmdichild then
        Form.Ownerformtop :=Form.Ownerformtop +(trunc(MainForm.MainToolBar.Height*1.5));}
    end;
    if form.formOwnerform = '' then form.formOwnerform := Self.Classname;
    form.bringTofront;
    form.ShowERPHint(Value);
  end;
  form.bringTofront;*)
end;

procedure TfmBaseTraining.onShowERPHint(const Value: Integer);
begin
  HighlightControl;
  HighlightextraControl1;
end;

procedure TfmBaseTraining.ShowERPHint(const Value: Integer);
begin
  //if self.FormStyle = fsmdichild then exit;
  if (value <= high(ERPHints)) and (Value >= low(ERPHints)) then begin
    ShowERPHint(ERPHints[Value]);
    onShowERPHint(Value);
  end;
end;



procedure TfmBaseTraining.FormDestroy(Sender: TObject);
begin
  HideERPHint(Self);
(*var
  Form :TfmERPHint;
begin
  form := TfmERPHint(GetComponentByClassName('TfmERPHint'));
  if Assigned(form) THEN begin
    if form.formOwnerform = Self.Classname then begin
      form.close;
    end;
  end;*)

end;



end.
