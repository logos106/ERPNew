unit GoogleAnalysisReport_Browser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GoogleAnalysisReportBase, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  DNMPanel, StdCtrls, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader,
  CustomInputBox, wwcheckbox;

type
  TGoogleAnalysisReport_BrowserGUI = class(TGoogleAnalysisReportBaseGUI)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses CommonLib;

{$R *.dfm}
procedure TGoogleAnalysisReport_BrowserGUI.FormCreate(Sender: TObject);
begin
  GAR_Category :='Browser';
  inherited;

end;

initialization
  RegisterClassOnce(TGoogleAnalysisReport_BrowserGUI);

end.

