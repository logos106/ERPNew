unit ApprovalLevelList;

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
  TApprovalLevelListGUI = class(TBaseListingGUI)
    qryMainApprovaltype: TWideStringField;
    qryMainEmployeeName: TWideStringField;
    qryMainValuefrom: TFloatField;
    qryMainValueTo: TFloatField;
    qryMainactive: TWideStringField;
    qryMainValueLeeway: TFloatField;
    qryMainEmployeeActive: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);override;
    procedure grdMainDblClick(Sender: TObject);override;
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
    fdApprovingAmount: double;
  public
    Property ApprovingAmount : double read fdApprovingAmount write fdApprovingAmount;
  end;


implementation

uses CommonLib;

{$R *.dfm}

procedure TApprovalLevelListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fdApprovingAmount := 0;
  HaveDateRangeSelection:= False;
end;

procedure TApprovalLevelListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if fdApprovingAmount <> 0 then
  if (fdApprovingAmount >= qrymainValuefrom.asFloat) and
     (fdApprovingAmount <= qrymainValueTo.asFloat) then
    DoGreenhighlight(AFont,ABrush);
end;

procedure TApprovalLevelListGUI.grdMainDblClick(Sender: TObject);
begin
  MessageDlgXP_Vista('Approval Levels can be changed from "Preference -> Payments"', mtInformation, [mbOK], 0);
end;

procedure TApprovalLevelListGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Active' , ['T','F','']);
  if groupfilterstring <> '' then groupfilterstring := groupfilterstring +
                                                       iif(grpfilters.itemindex=0 , ' and ', ' OR ')  +
                                                       replacestr(groupfilterstring, 'Active', 'EmployeeActive');
  inherited;
end;

initialization
  RegisterClassOnce(TApprovalLevelListGUI);

end.

