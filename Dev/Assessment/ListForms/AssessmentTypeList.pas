unit AssessmentTypeList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton, CustomInputBox, wwdblook,
  Shader, kbmMemTable;

type
  TAssessmentTypeListGUI = class(TBaseListingGUI)
    qryMainTypeID: TIntegerField;
    qryMainTypeName: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainProduct: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure cmdNewClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
  
uses CommonLib, AssessmentTypeGUI, Forms;
{$R *.dfm}

procedure TAssessmentTypeListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin
        GroupFilterString := 'Active = ' + QuotedStr('T');
      end;
    1: 
      begin
        GroupFilterString := 'Active = ' + QuotedStr('F');
      end;
    2: 
      begin
      end;
  end;
  inherited;
end;

procedure TAssessmentTypeListGUI.cmdNewClick(Sender: TObject);
var 
  Form: TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TAssessmentTypeGUI');
  if Assigned(Form) then begin //if has acess
    with TAssessmentTypeGUI(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;  
end;

initialization
  RegisterClassOnce(TAssessmentTypeListGUI);
end.
