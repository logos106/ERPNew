unit PQAMissingTransList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB, kbmMemTable,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton;

type
  TPQAMissingTransListGUI = class(TBaseListingGUI)
    qryMainTransDate: TDateTimeField;
    qryMainactive: TWideStringField;
    qryMainProductId: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainTransID: TLargeintField;
    qryMaintranslineId: TIntegerField;
    qryMainalloctype: TWideStringField;
    qryMainTransType: TWideStringField;
    qryMainQty: TFloatField;
    qryMainSalelineId: TIntegerField;
    qryMainpurchaseLineId: TIntegerField;
    qryMainproctreePartID: TIntegerField;
    qryMainStockmovementLinesID: TIntegerField;
    qryMainRepairPartsID: TIntegerField;
    qryMainproctreePArtIDIn: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses CommonLib;

{$R *.dfm}
initialization
  RegisterClassOnce(TPQAMissingTransListGUI);

end.

