unit POSList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel;

type
  TPOSListGUI = class(TBaseListingGUI)
    qryMainSaleId: TIntegerField;
    qryMainCustomerName: TWideStringField;
    qryMainTotalAmountinc: TFloatField;
    qryMainTotalAmount: TFloatField;
    qryMainSaleDate: TDateField;
    qryMainshipdate: TDateField;
    qryMainComments: TWideMemoField;
    qryMainISInPOS: TWideStringField;
  private
    { Private declarations }
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib;

{$R *.dfm}

{ TPOSListGUI }

procedure TPOSListGUI.RefreshQuery;
begin
  Qrymain.ParamByName('Datefrom').AsDateTime := filterdateFrom;
  Qrymain.ParamByName('DateTo').AsDateTime   := filterdateto;
  inherited;

end;

initialization
  RegisterClassOnce(TPOSListGUI);

end.
