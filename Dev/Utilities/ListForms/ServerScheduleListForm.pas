unit ServerScheduleListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls,
  DNMPanel, ComCtrls,AdvOfficeStatusBar, wwriched, ProgressDialog, CustomInputBox, wwdblook,
  Shader, kbmMemTable;

type
  TServerScheduleListGUI = class(TBaseListingGUI)
    ConnectionServices: TERPConnection;
    Label4: TLabel;
    qryMainID: TIntegerField;
    qryMainDue: TDateTimeField;
    qryMainDescription: TWideStringField;
    qryMainXml: TWideMemoField;
    qryMainLogWhenDone: TWideStringField;
    qryMainLogWhenDropped: TWideStringField;
    qryMainrepeatAlarmID: TIntegerField;
    Timer1: TTimer;
    qryMainMode: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGridClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
  public
    { Public declarations }
  end;

//var
//  ServerScheduleListGUI: TServerScheduleListGUI;

implementation

uses CommonDbLib, frmServerScheduleGUI, CommonLib;

{$R *.dfm}

procedure TServerScheduleListGUI.FormShow(Sender: TObject);
begin        
  ConnectionServices.Username := CommonDbLib.GetSharedMyDacConnection.Username;
  ConnectionServices.Server := CommonDbLib.GetSharedMyDacConnection.Server;
  ConnectionServices.Password := CommonDbLib.GetSharedMyDacConnection.Password;
  ConnectionServices.Port := CommonDbLib.GetSharedMyDacConnection.Port;
  ConnectionServices.Database := 'Services';
  ConnectionServices.Connect;
  qryMain.Connection := ConnectionServices;
  inherited;
  dtFrom.Date := Date;
  dtTo.Date := Date + 14;
end;

procedure TServerScheduleListGUI.cmdNewClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := GetComponentByClassName('TServerScheduleGUI');
  If not Assigned(tmpComponent) then Exit;
  with TServerScheduleGUI(tmpComponent) do begin
    AttachObserver(Self);
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

procedure TServerScheduleListGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
//  ServerScheduleListGUI := nil;
end;

procedure TServerScheduleListGUI.btnGridClick(Sender: TObject);
var 
  s: string;
begin
  if qryMainRepeatAlarmID.AsInteger > 0 then s := 'All Alarms'
  else s := 'This Alarm';

  if (CommonLib.MessageDlgXP_Vista('Delete ' + s + #13#10 + '" ' + qryMainDescription.AsString + ' "', mtConfirmation,
    [mbYes, mbCancel], 0) = mrYes) then begin
    if (qryMainrepeatAlarmID.AsInteger > 0) then begin
      ConnectionServices.ExecSQL('DELETE FROM tblschedule WHERE repeatalarmID = ' + qryMainrepeatAlarmID.AsString, []);

      ConnectionServices.ExecSQL('DELETE FROM tblrepeatalarms WHERE ID = ' + qryMainrepeatAlarmID.AsString, []);
      qryMain.Refresh;
    end else qryMain.Delete;
  end;
end;

procedure TServerScheduleListGUI.Timer1Timer(Sender: TObject);
begin
  qryMain.Refresh;
end;

procedure TServerScheduleListGUI.RefreshQuery;
begin
  qryMain.ParamByName('DatabaseName').AsString := CommonDbLib.GetSharedMyDacConnection.Database;
  qryMain.Params.ParamByName('txtfrom').AsDate := dtFrom.DateTime;
  qryMain.Params.ParamByName('txtto').AsDate := dtTo.DateTime;
  inherited;
end;

initialization
  RegisterClassOnce(TServerScheduleListGUI);

finalization
  UnRegisterClass(TServerScheduleListGUI);
end.


