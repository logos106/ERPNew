unit EmployeeReportByPeriod;

{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 26/10/05 1.00.01  MV   Added Sales Target to report.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, DB, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls,
  DNMPanel, ComCtrls,AdvOfficeStatusBar, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, wwcheckbox,SalesSummarybyPeriodBase,
  CustomInputBox;

type
  TEmployeeReportByPeriodGUI = class(TSalesSummarybyPeriodBaseGUI)
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
  protected
  public
  end;


implementation

uses CommonLib;


{$R *.dfm}
procedure TEmployeeReportByPeriodGUI.FormCreate(Sender: TObject);
begin
  ReportCategory := rcEmployee;
  inherited;
end;

procedure TEmployeeReportByPeriodGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  grdMain.ColumnByName('EmployeeName').DisplayWidth := 15;
end;
initialization
  RegisterClassOnce(TEmployeeReportByPeriodGUI);


end.
