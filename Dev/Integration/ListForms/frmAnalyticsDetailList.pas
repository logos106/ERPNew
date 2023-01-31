unit frmAnalyticsDetailList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript;

type
  TfmAnalyticsDetailList = class(TBaseListingGUI)
    qryMainAccountName: TWideStringField;
    qryMainTitle: TWideStringField;
    qryMainDateTime: TDateTimeField;
    qryMainKeyword: TWideStringField;
    qryMainCountry: TWideStringField;
    qryMainBrowser: TWideStringField;
    qryMainOperatingSystem: TWideStringField;
    qryMainVisits: TIntegerField;
    qryMainNewVisits: TIntegerField;
    qryMainPageViews: TIntegerField;
    qryMainTimeOnSite: TIntegerField;
  private
  protected
    procedure RefreshQuery; override;
  public
    { Public declarations }
  end;

var
  fmAnalyticsDetailList: TfmAnalyticsDetailList;

implementation

{$R *.dfm}

{ TfmAnalyticsDetailList }

procedure TfmAnalyticsDetailList.RefreshQuery;
begin
  qryMain.ParamByName('dtFrom').AsDate:= dtFrom.Date;
  qryMain.ParamByName('dtTo').AsDate:= dtTo.Date;
  inherited;
end;

initialization
  RegisterClass(TfmAnalyticsDetailList);

end.
