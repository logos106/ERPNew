unit ERPPopups;

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
  TERPPopupsGUI = class(TERPMessagesGUI)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure btnPhoneClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses ERPMessageTypes, CommonLib, frmERPMessagePopup;

{$R *.dfm}

procedure TERPPopupsGUI.btnPhoneClick(Sender: TObject);
begin
  inherited;
//
end;

procedure TERPPopupsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  Tasktype:=ERPMESSAGE_Popup;
end;

procedure TERPPopupsGUI.FormShow(Sender: TObject);
begin
  inherited;
  grpfilters.itemindex := 5; //4;
end;

procedure TERPPopupsGUI.grdMainDblClick(Sender: TObject);
begin
      ShowaERPpopup(qryMainID.AsInteger);
      Exit;

(*  if devmode then
    if not(Sametext(activefieldname , qryMainDetails.FieldName)) then  begin
      ShowaERPpopup(qryMainID.AsInteger);
      Exit;
    end;
  inherited;*)
end;

initialization
  RegisterClassOnce(TERPPopupsGUI);
end.
