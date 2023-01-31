unit BaseListExpressDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TBaseListExpressDetailsGUI = class(TBaseListingGUI)
    btnExpressDetail: TDNMSpeedButton;
    procedure btnExpressDetailClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  Protected
    procedure SetupFormInPanel; Override;
    Function ExpressDetailListName:String;Virtual;abstract;
    procedure beforeshowDetailsListName(Sender: TObject);Virtual;
  public
  end;

implementation

uses CommonFormLib;

{$R *.dfm}

procedure TBaseListExpressDetailsGUI.beforeshowDetailsListName(Sender: TObject);
begin
  CopyParamsto(Sender);

end;

procedure TBaseListExpressDetailsGUI.btnExpressDetailClick(Sender: TObject);
begin
  inherited;
  if ExpressDetailListName = '' then exit;
  OpenERpListForm(ExpressDetailListName, beforeshowDetailsListName);
  CloseWait;

end;

procedure TBaseListExpressDetailsGUI.FormShow(Sender: TObject);
begin
  inherited;
  btnExpressDetail.Enabled := not Assigned(fOnGridDataSelect) and (ExpressDetailListName<>'');
end;

procedure TBaseListExpressDetailsGUI.SetupFormInPanel;
begin
  inherited;
  btnExpressDetail.visible := False;

end;

end.
