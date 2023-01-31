unit ERPTips;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ERPMessages, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,
  CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList,
  AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TERPTipsGUI = class(TERPMessagesGUI)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
  private
    { Private declarations }
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses ERPMessageTypes, CommonLib, ERPMessageGUILib;

{$R *.dfm}

{ TERPMessagesGUI1 }

procedure TERPTipsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  Tasktype:=ERPMESSAGE_TIP;
end;

procedure TERPTipsGUI.FormShow(Sender: TObject);
begin
  inherited;
    grpfilters.itemindex := 5;
end;

procedure TERPTipsGUI.grdMainDblClick(Sender: TObject);
begin
      ShowERPTip(qryMainID.AsInteger);
      Exit;
(*  if devmode then
    if not(Sametext(activefieldname , qryMainDetails.FieldName)) then  begin
      ShowERPTip(qryMainID.AsInteger);
      Exit;
    end;
  inherited;*)

end;

procedure TERPTipsGUI.RefreshQuery;
begin
  inherited;

end;

initialization
  RegisterClassOnce(TERPTipsGUI);

end.
