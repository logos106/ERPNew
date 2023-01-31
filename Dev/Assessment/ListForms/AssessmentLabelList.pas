unit AssessmentLabelList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton, CustomInputBox, wwdblook,
  Shader, kbmMemTable;

type
  TAssessmentLabelsList = class(TBaseListingGUI)
    qryMainLabelId: TIntegerField;
    qryMainLabel: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainOtherOption: TWideStringField;
    qryMainCategory: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure grdMainDblClick(Sender: TObject);Override; 
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
  
uses CommonLib, AssessmentLabelsGUI, Forms;
{$R *.dfm}

procedure TAssessmentLabelsList.cmdNewClick(Sender: TObject);
var 
  Form: TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TAssessmentLabelsGUI');
  if Assigned(Form) then begin //if has acess
    with TAssessmentLabelsGUI(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

procedure TAssessmentLabelsList.grpFiltersClick(Sender: TObject);
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

procedure TAssessmentLabelsList.grdMainDblClick(Sender: TObject);
var 
  Form: TComponent;
begin
  //inherited;
  Form := GetComponentByClassName('TAssessmentLabelsGUI');
  if Assigned(Form) then begin //if has acess
    with TAssessmentLabelsGUI(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

initialization
  RegisterClassOnce(TAssessmentLabelsList);
end.
