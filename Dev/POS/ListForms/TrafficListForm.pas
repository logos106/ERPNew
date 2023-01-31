unit TrafficListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, MemDS, DBAccess, MyAccess,ERPdbComponents,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable;

type
  TTrafficListGUI = class(TBaseListingGUI)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
  public
    { Public declarations }
  end;

var
  TrafficListGUI: TTrafficListGUI;

implementation

uses
  CommonLib;

{$R *.dfm}

procedure TTrafficListGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  TrafficListGUI := nil;
end;

procedure TTrafficListGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('txtFrom').AsDate := dtFrom.DateTime;
  qryMain.Params.ParamByName('txtTo').AsDate := dtTo.DateTime;
  inherited;
end;

procedure TTrafficListGUI.FormShow(Sender: TObject);
begin
  inherited;
  if fbFormOpenedOk then begin
    dtTo.Date := Date;
  end;
end;

initialization
  RegisterClassOnce(TTrafficListGUI);
end.
