unit GoogleAnalysisReport_DayofWeek;

interface
{since all other reports of 'TGoogleAnalysisReportBaseGUI' are orderd by the visists and this is on dayno,
the qrymain.sql is locally changed. any changes done to the qrymain.SQL should copied into this report manually}
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GoogleAnalysisReportBase, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  DNMPanel, StdCtrls, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader;

type
  TGoogleAnalysisReport_DayofWeekGUI = class(TGoogleAnalysisReportBaseGUI)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses CommonLib;

{$R *.dfm}
procedure TGoogleAnalysisReport_DayofWeekGUI.FormCreate(Sender: TObject);
begin
  GAR_Category :='DayofWeek';
  inherited;
end;

initialization
  RegisterClassOnce(TGoogleAnalysisReport_DayofWeekGUI);

end.

