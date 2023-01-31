unit SkillProviders;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB, CustomInputBox, Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton;

type
  TSkillProviderGUI = class(TBaseListingGUI)
    qryMainskillProviderId: TIntegerField;
    qryMainSkillProviderName: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainSkill: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses CommonLib, BaseInputForm;

{$R *.dfm}
procedure TSkillProviderGUI.cmdNewClick(Sender: TObject);
var
  form :Tcomponent;
begin
  inherited;
  DisableForm;
  try
    inherited;
    Form := GetComponentByClassName('TfmskillProvider');
    if Assigned(Form) then begin //if has acess
      with TBaseInputGUI(Form) do begin
        AttachObserver(Self);
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  finally
    EnableForm;
  end;

end;

initialization
  RegisterClassOnce(TSkillProviderGUI);

end.
