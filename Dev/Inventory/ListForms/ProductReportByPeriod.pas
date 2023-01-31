unit ProductReportByPeriod;

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
  kbmMemTable, DAScript, MyScript, wwcheckbox, SalesSummarybyPeriodBase, CustomInputBox;


type
  TProductReportByPeriodGUI = class(TSalesSummarybyPeriodBaseGUI)
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
  protected
  public
  end;

implementation

uses CommonLib;

{$R *.dfm}
procedure TProductReportByPeriodGUI.FormCreate(Sender: TObject);
begin
  ReportCategory := rcProduct;
  inherited;

end;

procedure TProductReportByPeriodGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  grdMain.ColumnByName('ProductName').DisplayWidth := 15;
end;

initialization
  RegisterClassOnce(TProductReportByPeriodGUI);


end.
