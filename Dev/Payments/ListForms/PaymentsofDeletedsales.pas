unit PaymentsofDeletedsales;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton;

type
  TPaymentsofDeletedsalesGUI = class(TBaseListingGUI)
    qryMainPaymentId: TIntegerField;
    qryMainSaleId: TIntegerField;
    qryMaintotalamountINc: TFloatField;
    qryMainPayment: TFloatField;
    qryMainPaymentDate: TDateField;
    qryMainSaleDate: TDateField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses CommonLib;

{$R *.dfm}
initialization
  RegisterClassOnce(TPaymentsofDeletedsalesGUI);

end.
