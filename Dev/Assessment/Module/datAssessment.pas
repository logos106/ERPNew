unit datAssessment;

interface

uses
  
  SysUtils, Classes, ActnList, DNMAction, Menus, AdvMenus, DB, DBAccess, MyAccess,ERPdbComponents,
  BaseGUIDatamodule, ActionsObj, wwDbGrid, ImgList, Controls;

type
  TdmAssessmentAddin = class(TdtmGUI)
    MainMenu: TAdvMainMenu;
    ActionList: TActionList;
    actAssessmentType: TDNMAction;
    actAssessmentTypeList: TDNMAction;
    actAssessmentLabelsList: TDNMAction;
    actAssessmentList: TDNMAction;
    actAssessment: TDNMAction;
    actAssessmentLabels: TDNMAction;
    Assessment1: TMenuItem;
    Assessment2: TMenuItem;
    AssessmentList1: TMenuItem;
    AssessmentTypes1: TMenuItem;
    AssessmentTypeList1: TMenuItem;
    AssessmentLabels1: TMenuItem;
    AssessmentLabelsList1: TMenuItem;
    procedure DataModuleCreate(Sender: TObject);
  private

  public
    { Public declarations }
    procedure AssociateClassNamesWithActions; override;

  published
    function GetItem(const ActionName: string): TActionHelperItem;
  end;


implementation

uses FastFuncs, AddinPackageInfoObj;

{$R *.dfm}

{$M+}        {don't delete!}

function TdmAssessmentAddin.GetItem(const ActionName: string): TActionHelperItem;
var
  I: Integer;
begin
  Result := nil;
  if ActionHelper.Count > 0 then for I := 0 to ActionHelper.ActionCount - 1 do
      if Sysutils.SameText(ActionHelper.Items[I].ActionName, ActionName) then begin
        Result := ActionHelper.Items[I];
        Break;
      end;
end;

procedure TdmAssessmentAddin.AssociateClassNamesWithActions;
var
  i: Integer;
  Action: TDNMAction;
begin
  for i := 0 to ActionList.Actioncount - 1 do begin
    Action := TDNMAction(ActionList.Actions[I]);
    ActionHelper.AssociateActionWithClassName(Action.Name,
      Action.ClassExecute, Action.Description);
  end;
end;

procedure TdmAssessmentAddin.DataModuleCreate(Sender: TObject);
begin
  LoadImagefromAppMainImageList := True;
  inherited;
  PopulateActionHelper(Self.ActionList);
  AssociateClassNamesWithActions;
end;

initialization
  if Assigned(AddinInfo) then AddinInfo.GuiDataModuleClass := TdmAssessmentAddin;
end.
