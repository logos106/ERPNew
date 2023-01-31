unit CorrespondenceReferenceList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel, CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TCorrespondenceReferenceListGUI = class(TBaseListingGUI)
    qryMainId: TIntegerField;
    qryMainGlobalRef: TWideStringField;
    qryMainTypeCode: TWideStringField;
    qryMainReference: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainmsTimeStamp: TDateTimeField;
    qryMainmsUpdateSiteCode: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
  private
  protected
    procedure ApplyQueryFilter; override;
  public
    { Public declarations }
  end;

var
  CorrespondenceReferenceListGUI: TCorrespondenceReferenceListGUI;

implementation

{$R *.dfm}

uses
  BaseInputForm, CommonLib;

procedure TCorrespondenceReferenceListGUI.ApplyQueryFilter;
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

procedure TCorrespondenceReferenceListGUI.cmdNewClick(Sender: TObject);
var
  EditForm : TBaseInputGUI;
begin
  inherited;
  if self.ClassNameIs('TEmailCorrespondenceReferenceListGUI') then
    EditForm := TBaseInputGUI(GetComponentByClassName('TfmEmailCorrespondenceReference'))
  else if self.ClassNameIs('TLetterCorrespondenceReferenceListGUI') then
    EditForm := TBaseInputGUI(GetComponentByClassName('TfmLetterCorrespondenceReference'))
  else
    exit;
  if Assigned(EditForm) then begin
    with EditForm do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;

end;

procedure TCorrespondenceReferenceListGUI.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('Id,TypeCode,msTimeStamp,msUpdateSiteCode');
end;

end.
