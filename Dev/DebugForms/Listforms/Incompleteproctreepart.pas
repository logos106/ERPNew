unit Incompleteproctreepart;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton;

type
  TIncompleteproctreepartGUI = class(TBaseListingGUI)
    qryMainSAleId: TIntegerField;
    qryMainProcTreePartId: TIntegerField;
    qryMainGlobalRef: TWideStringField;
    qryMainSaleId_1: TIntegerField;
    qryMainSaleLineId: TIntegerField;
    qryMainProductId: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainProcTreeId: TIntegerField;
    qryMainSerialNumbers: TWideMemoField;
    qryMainQty: TFloatField;
    qryMainUOMQty: TFloatField;
    qryMainUOMQtyOriginal: TFloatField;
    qryMainUOMQtyUsed: TFloatField;
    qryMainUnitOfMeasure: TWideStringField;
    qryMainUnitOfMeasureMultiplier: TFloatField;
    qryMainUnitOfMeasureId: TIntegerField;
    qryMainClassId: TIntegerField;
    qryMainDateRequired: TDateTimeField;
    qryMainActive: TWideStringField;
    qryMainmsTimeStamp: TDateTimeField;
    qryMainUseStock: TWideStringField;
    qryMaintype: TWideStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses CommonLib;

{$R *.dfm}
initialization
  RegisterClassOnce(TIncompleteproctreepartGUI);

end.
