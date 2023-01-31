unit UOMProductList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,
  DAScript, MyScript, CustomInputBox, wwcheckbox;

type
  TUOMProductListGUI = class(TBaseListingGUI)
    qryMainPartsId: TIntegerField;
    qryMainPartname: TWideStringField;
    qryMainParttype: TWideStringField;
    qryMainPurchaseUOM: TWideStringField;
    qryMainSalesUOM: TWideStringField;
    qryMainPurchaseUOMID: TLargeIntField;
    qryMainSalesUOMID: TLargeIntField;
  private
    { Private declarations }
  public
    Procedure RefreshQuery; override;
  end;


implementation

uses CommonLib, tcConst, AppEnvironment;

{$R *.dfm}
{ TUOMProductListGUI }

procedure TUOMProductListGUI.RefreshQuery;
begin
  Qrymain.Parambyname('DefaultUOM').asString := AppEnv.DefaultClass.DefaultUOM;
  inherited;

end;

initialization
  RegisterClassOnce(TUOMProductListGUI);

end.
