unit EmailsReport;

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 13/07/05  1.00.01 DSP  Changed the list sort order from Date to ReportListID
  //                        so the most recent entry would be displayed at the top
  //                        of the list 

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB, 
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, DNMPanel, DBAccess, MyAccess,ERPdbComponents, MemDS,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable;

type
  TEmailedReportsList = class(TBaseListingGUI)
    procedure grdMainDblClick(Sender: TObject);Override; 
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses CommonLib;

{$R *.dfm}

procedure TEmailedReportsList.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMain.Fields.FieldByName('Report Type').AsString;
  inherited;
end;
initialization
  RegisterClassOnce(TEmailedReportsList);
end.
