unit EmployeeSkillListFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton;

type
  TEmployeeSkillListGUI = class(TBaseListingGUI)
    qryMaincategory: TLargeintField;
    qryMainEmployeeID: TIntegerField;
    qryMainEmployeeName: TWideStringField;
    qryMainSkillName: TWideStringField;
    qryMainSkillExpDate: TDateField;
    qryMainSecurityLevel: TIntegerField;
    qryMainSecurityExpDate: TDateField;
    qryMainProviderName: TWideStringField;
    qryMainTestMethod: TWideStringField;
    qryMainCertificate: TWideStringField;
    qryMainScheduledDate: TDateField;
    qryMainCompletedDate: TDateField;
    qryMainRenewalDate: TDateField;
    qryMainRenewed: TWideStringField;
    qryMainComments: TWideStringField;
    qryMainSkillLevel: TWideStringField;
    qryMainRenewalOptions: TWideStringField;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
  Protected
    procedure SetGridColumns;Override;
  public

  end;


implementation

uses CommonLib;

{$R *.dfm}

procedure TEmployeeSkillListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  //if field = nil then exit;
  if qryMaincategory.asInteger = 1 then begin
    if sameText(field.fieldname , 'Employeename') then
      Afont.style := Afont.style  +[fsbold]
    else Afont.color := aBrush.color;
  end;
end;
procedure TEmployeeSkillListGUI.SetGridColumns;
begin
  RemoveFieldfromGrid('Category');
  RemoveFieldfromGrid('EmployeeId');
end;

initialization
  RegisterClassOnce(TEmployeeSkillListGUI);
end.
