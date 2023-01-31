unit FuncRoomList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls, StdCtrls, ExtCtrls, DNMPanel, DBAccess, MyAccess, MemDS,
  wwdbdatetimepicker, ProgressDialog;

type
  TfrmFuncRoomListGUI = class(TBaseListingGUI)
    qryMainRoomName: TStringField;
    qryMainCapacity: TIntegerField;
    qryMainResetTime: TDateTimeField;
    qryMainPerDay: TFloatField;
    qryMainPerHalfDay: TFloatField;
    qryMainPerHour: TFloatField;
    qryMainParentRoom: TStringField;
    qryMainActive: TStringField;
    qryMainRoomID: TIntegerField;
    qryMainGlobalRef: TStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  frmFuncRoomListGUI: TfrmFuncRoomListGUI;

implementation

{$R *.dfm}

uses
  FuncRoomForm, DateUtils, CommonLib;

procedure TfrmFuncRoomListGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  Form := GetComponentByClassName('TfrmFuncRoomGUI');
  if Assigned(Form) then begin //if has acess
    with TfrmFuncRoomGUI(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;  
end;

procedure TfrmFuncRoomListGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
//  frmFuncRoomListGUI := nil;
end;

procedure TfrmFuncRoomListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  // Disable our DataTime Controls as they are not
  // .. required here.
  lblFrom.Visible := false;
  dtFrom.Visible := false;
  lblTo.Visible := false;
  dtTo.Visible := false;
end;

initialization
  RegisterClassOnce(TfrmFuncRoomListGUI);
end.
