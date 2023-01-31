unit GoogleAnalysisReport_Campaign;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GoogleAnalysisReportBase, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  DNMPanel, StdCtrls, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader;

type

  TGoogleAnalysisReport_CampaignGUI = class(TGoogleAnalysisReportBaseGUI)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses CommonLib;

{$R *.dfm}
procedure TGoogleAnalysisReport_CampaignGUI.FormCreate(Sender: TObject);
begin
  GAR_Category :='Campaign';
  inherited;

end;

initialization
  RegisterClassOnce(TGoogleAnalysisReport_CampaignGUI);

end.

