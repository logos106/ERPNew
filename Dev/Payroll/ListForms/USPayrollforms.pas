unit USPayrollforms;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls,ReportTemplateList, DAScript, MyScript, kbmMemTable,
  CustomInputBox, wwDialog, Wwlocate, ActnList, PrintDAT, AdvOfficeStatusBar,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook,
  DNMSpeedButton, wwclearbuttongroup, wwradiogroup, Shader, GIFImg, DNMPanel,
  BaseListingForm;


type
  TUSPayrollformsGUI = class(TReportTemplateListGUI)
    procedure grdMainDblClick(Sender: TObject); override;
  private
  Protected
    Function TTTypeID :Integer ; Override;
  Public
    Procedure RefreshQuery; Override;

  end;

implementation

uses BusobjTemplateOptions, CommonLib;



{$R *.dfm}

{ TBaseInputGUI1 }

procedure TUSPayrollformsGUI.grdMainDblClick(Sender: TObject);
begin
//  inherited;
 cmdPrint.click;
end;

procedure TUSPayrollformsGUI.RefreshQuery;
begin
  Qrymain.parambyname('tttypeid2').asInteger := TtemplateType.USAPAYG;
  inherited;
end;

function TUSPayrollformsGUI.TTTypeID: Integer;
begin
  Result := TtemplateType.USA_Payroll_Forms;
end;
initialization
  RegisterClassOnce(TUSPayrollformsGUI);

end.
