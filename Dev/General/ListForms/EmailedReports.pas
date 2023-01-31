unit EmailedReports;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TEmailedReportsGUI = class(TBaseListingGUI)
    qryMainDate: TDateField;
    qryMainReportType: TWideStringField;
    qryMainTransactionDescription: TWideStringField;
    qryMainStatus: TWideStringField;
    qryMainIsScheduledreport: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);Override;
  private
    { Private declarations }
  public
    Procedure RefreshQuery;Override;
  end;

var
  EmailedReportsGUI: TEmailedReportsGUI;

implementation

uses CommonLib;

{$R *.dfm}

procedure TEmailedReportsGUI.grpFiltersClick(Sender: TObject);
begin
       if grpfilters.itemindex =0 then GroupfilterString := 'IsScheduledreport  =' +quotedstr('T')
  else if grpfilters.itemindex =1 then GroupfilterString := 'IsScheduledreport  =' +quotedstr('F')
  else GroupfilterString := '';
  inherited;
end;

procedure TEmailedReportsGUI.RefreshQuery;
begin
  Qrymain.parambyname('DateFrom').asDatetime := filterDateFrom;
  Qrymain.parambyname('DateTo').asDatetime := filterDateTo;
  inherited;

end;
initialization
  RegisterClassOnce(TEmailedReportsGUI);

end.

