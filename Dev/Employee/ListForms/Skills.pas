unit Skills;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, wwcheckbox,
  CustomInputBox;

type
  TSkillsGUI = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainSkillID: TIntegerField;
    qryMainSkill: TWideStringField;
    qryMainEditedFlag: TWideStringField;
    qryMainmsTimeStamp: TDateTimeField;
    qryMainActive: TWideStringField;
    qryMainmsUpdateSiteCode: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
  private
  protected
    procedure ApplyQueryFilter; override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, BaseInputForm;

{$R *.dfm}
procedure TSkillsGUI.ApplyQueryFilter;
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin {Active}
        GroupFilterString := '(Active = "T")';
      end;
    1:
      begin {Inactive}
        GroupFilterString := '(Active = "F")';
      end;
    2:
      begin {All}
        GroupFilterString := '';
      end;
  end;
  inherited;
end;

procedure TSkillsGUI.cmdNewClick(Sender: TObject);
var
  form :Tcomponent;
begin
  inherited;
  DisableForm;
  try
    inherited;
    Form := GetComponentByClassName('Tfmskills');
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
  RegisterClassOnce(TSkillsGUI);

end.
