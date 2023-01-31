unit ERPMessages;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TERPMessagesGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainSubject: TWideStringField;
    qryMainDetails: TWideMemoField;
    qryMainHasSeen: TWideStringField;
    qryMainVersionno: TWideStringField;
    qryMainTaskNo: TIntegerField;
    btnPhone: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure btnPhoneClick(Sender: TObject);
  private
    procedure aftershowlist(Sender: TObject);
    procedure HowToAfterShow(Sender : TObject);
  Protected
    Tasktype:String;
    Tasktype2:String;
    procedure SetGridColumns; Override;

  public
    Procedure RefreshQuery;Override;

  end;

implementation

uses AppEnvironment, ERPTips, ERPChanges, ERPPopups, CommonFormLib, frmTasks,
  ERPWebSiteChanges, ERPTabletChanges, HowToListFrm, frmSHowMeERPOffices;

{$R *.dfm}

{ TERPMessagesGUI }

procedure TERPMessagesGUI.btnPhoneClick(Sender: TObject);
begin
  inherited;
  TfmShowMeERPOffices.ShowMe;
end;

procedure TERPMessagesGUI.FormCreate(Sender: TObject);
begin
  inherited;
  Tasktype:='';
  Tasktype2:='';
  BaseIndexfields:= 'Versionno';
end;

procedure TERPMessagesGUI.FormShow(Sender: TObject);
begin
  inherited;
       if (grpFilters.itemindex <> 0) and ((Self is TERPChangesGUI)) then grpFilters.itemindex := 0
  else if (grpFilters.itemindex <> 1) and ((Self is TERPTipsGUI))    then grpFilters.itemindex := 1
  else if (grpFilters.itemindex <> 2) and ((Self is TERPPopupsGUI))  then grpFilters.itemindex := 2;
end;

procedure TERPMessagesGUI.grdMainDblClick(Sender: TObject);
begin
  if not(Sametext(activefieldname , qryMainDetails.FieldName)) then inherited;
end;

procedure TERPMessagesGUI.grpFiltersClick(Sender: TObject);
begin
//  inherited;
  try
    if not(ISGrpfiltersfocussed) then exit;
  Except
    on E:Exception do begin
      Exit;
    end;
  end;
           if (grpFilters.itemindex =0)  then  OpenERPListForm('TERPTrainingVideosGUI' )
  else if (grpFilters.itemindex =1) and (not(Self is TERPChangesGUI))         then OpenERPListForm('TERPChangesGUI', nil, aftershowlist)
  else if (grpFilters.itemindex =2) and (not(Self is TERPWebSiteChangesGUI))  then OpenERPListForm('TERPWebSiteChangesGUI', nil, aftershowlist)
  else if (grpFilters.itemindex =3) and (not(Self is TERPTabletChangesGUI))   then OpenERPListForm('TERPTabletChangesGUI', nil, aftershowlist)
  else if (grpFilters.itemindex =4) and (not(Self is TERPTipsGUI))            then OpenERPListForm('TERPTipsGUI', nil, aftershowlist)
  else if (grpFilters.itemindex =5) and (not(Self is TERPPopupsGUI))          then OpenERPListForm('TERPPopupsGUI', nil, aftershowlist)
  else if (grpFilters.ItemIndex =6)   then OpenERPListForm('THowToListGUI', nil, HowToAfterShow)
  else exit;
  Self.close;
end;
procedure TERPMessagesGUI.HowToAfterShow(Sender: TObject);
begin
  if Sender is THowToListGUI then
    (Sender as THowToListGUI).SetGrpFilters;
end;

procedure TERPMessagesGUI.aftershowlist(Sender:TObject);
begin
  if not(Sender is TERPMessagesGUI) then exit;
  CopyParamsto(Sender);
end;
procedure TERPMessagesGUI.RefreshQuery;
begin
//  Qrymain.Parambyname('UserID').asString := Appenv.employee.EmployeeID;
  Qrymain.Parambyname('Tasktype').asString   := Tasktype;
  Qrymain.Parambyname('Tasktype2').asString   := Tasktype2;
  Qrymain.Parambyname('DateFrom').AsDateTime  := filterDateFrom;
  Qrymain.Parambyname('DateTo').AsDateTime    := filterDateTo;
  Qrymain.Parambyname('UserID').asInteger := Appenv.employee.employeeId;
  inherited;
end;

procedure TERPMessagesGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainID.FieldName);
  RemoveFieldfromGrid(qryMainHasSeen.FieldName);
end;

end.
