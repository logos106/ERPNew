unit ProductionTonnesDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListExpressDetails, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  BaseListDetails , ProductionTonnesBase, wwclearbuttongroup, wwradiogroup,
  GIFImg;

type
  TProductionTonnesDetailsGUI = class(TProductionTonnesBaseGUI)
    qryMainCaption: TWideStringfield;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  Protected
    Function ExpressDetailListName:String;Override;
  public
  end;


implementation

uses CommonLib, tcConst;

{$R *.dfm}
{ TProductionTonnesDetailsGUI }

function TProductionTonnesDetailsGUI.ExpressDetailListName: String;
begin
  Result := 'TProductionTonnesGUI';
end;

procedure TProductionTonnesDetailsGUI.FormCreate(Sender: TObject);
begin
  Self.caption := 'Production Tonnes Report - Main Product and Raw Materials';
  inherited;
end;

procedure TProductionTonnesDetailsGUI.FormShow(Sender: TObject);
begin
  inherited;
  TitleLabel.caption := 'Production Tonnes Report'+NL+'Main Product and Raw Materials';
end;

initialization
  RegisterClassOnce(TProductionTonnesDetailsGUI);

end.
