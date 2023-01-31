unit EmployeeTaxList;

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
  TEmployeeTaxListGUI = class(TBaseListingGUI)
    qryMainEmployeeID: TIntegerField;
    qryMainEmployeeName: TWideStringField;
    qryMainTotalTaxWithheld: TFloatField;
    qryMainAllowances: TFloatField;
    qryMainOther: TFloatField;
    qryMainGrossPayments: TFloatField;
    qryMainDeductions: TFloatField;
    qryMainUnionFees: TFloatField;
    qryMainFedTax: TFloatField;
    qryMainStateTax: TFloatField;
    qryMainmedicareTax: TFloatField;
    qryMainSocialSecurityTax: TFloatField;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
    Procedure RefreshTotals; override;
  public
    { Public declarations }
  end;

var
  EmployeeTaxListGUI: TEmployeeTaxListGUI;

implementation

{$R *.dfm}

{ TEmployeeTaxListGUI }

procedure TEmployeeTaxListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  AddCalcColumn(qryMainTotalTaxWithheld.FieldName, true);
  AddCalcColumn(qryMainAllowances.FieldName, true);
  AddCalcColumn(qryMainOther.FieldName, true);
  AddCalcColumn(qryMainGrossPayments.FieldName, true);
  AddCalcColumn(qryMainDeductions.FieldName, true);
  AddCalcColumn(qryMainUnionFees.FieldName, true);
  AddCalcColumn(qryMainFedTax.FieldName, true);
  AddCalcColumn(qryMainStateTax.FieldName, true);
  AddCalcColumn(qryMainMedicareTax.FieldName, true);
  AddCalcColumn(qryMainSocialSecurityTax.FieldName, true);

end;

procedure TEmployeeTaxListGUI.RefreshQuery;
begin
  if chkIgnoreDates.Checked then begin
    qryMain.ParamByName('txtfrom').AsDate := 0;
    qryMain.ParamByName('txtto').AsDate := SysUtils.MaxDateTime;
  end
  else begin
    qryMain.ParamByName('txtfrom').AsDateTime := FilterDatefrom;
    qryMain.ParamByName('txtto').AsDateTime := FilterDateTo;
  end;
  inherited;

end;

procedure TEmployeeTaxListGUI.RefreshTotals;
begin
  inherited;
  CalcnShowfooter;
end;

initialization
  RegisterClass(TEmployeeTaxListGUI);

end.
