unit frmRepAbilityList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton;

type
  TfmRepAbilityList = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainAbilityID: TIntegerField;
    qryMainAbilityDesc: TWideStringField;
    qryMainAbilityValue: TIntegerField;
    qryMainActive: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRepAbilityList: TfmRepAbilityList;

implementation

{$R *.dfm}

uses
  BaseInputForm, CommonLib;

procedure TfmRepAbilityList.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('AbilityID,GlobalRef');

end;

procedure TfmRepAbilityList.cmdNewClick(Sender: TObject);
var 
  Form: TBaseInputGUI;
begin
  DisableForm;
  try
    inherited;
    Form := TBaseInputGUI(GetComponentByClassName('TfmRepAbilityEdit'));
    if Assigned(Form) then begin //if has acess
      Form.AttachObserver(Self);
      Form.FormStyle := fsMDIChild;
      Form.BringToFront;
    end;
  finally
    EnableForm;
  end;
end;

initialization
  RegisterClass(TfmRepAbilityList);

end.
