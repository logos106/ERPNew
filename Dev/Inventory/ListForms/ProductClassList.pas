unit ProductClassList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB, kbmMemTable,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,
  DAScript, MyScript, CustomInputBox, wwcheckbox, wwclearbuttongroup,
  wwradiogroup, GIFImg , PartClassSQL;

type
  TProductClassListGUI = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainID: TIntegerField;
    qryMainProductID: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainProductGroup: TWideStringField;
    qryMainClassID: TIntegerField;
    qryMainClassName: TWideStringField;
    qryMainReOrderPoint: TFloatField;
    qryMainPreferredLevel: TFloatField;
    qryMainReOrderAmount: TFloatField;
    qryMainLastAdj: TFloatField;
    qryMainLastAdjAccount: TIntegerField;
    qryMainClassPriceVariance: TFloatField;
    qryMainVariantPrice: TFloatField;
    qryMainNextStocktakeDate: TDateField;
    qryMainActive: TWideStringField;
    qryMainDefaultbinlocation: TWideStringField;
    qryMaindefaultbinnumber: TWideStringField;
    qryMainSalesDescription: TWideStringField;
    qryMainCOST1: TFloatField;
    qryMainCOSTINC1: TFloatField;
    qryMainBuyQTY1: TIntegerField;
    qryMainCOST2: TFloatField;
    qryMainCOSTINC2: TFloatField;
    qryMainBuyQTY2: TIntegerField;
    qryMainCOST3: TFloatField;
    qryMainCOSTINC3: TFloatField;
    qryMainBuyQTY3: TIntegerField;
    qryMainPrice1: TFloatField;
    qryMainPriceINC1: TFloatField;
    qryMainSellQTY1: TIntegerField;
    qryMainPrice2: TFloatField;
    qryMainPriceINC2: TFloatField;
    qryMainSellQTY2: TIntegerField;
    qryMainPrice3: TFloatField;
    qryMainPriceINC3: TFloatField;
    qryMainSellQTY3: TIntegerField;
    qryMainPrimarybarcode: TWideStringField;
    qryMainProductActive: TWideStringField;
    qryMainProductClassActive: TWideStringField;
    qryMainMsTimeStamp: TDateTimeField;
    qryMainMsUpdateSiteCode: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    PartClass: TPartClass;
    procedure MakeQrymain;
  Protected
    Procedure SetGridColumns;Override;
  public
    { Public declarations }
  end;

implementation

uses CommonLib;

{$R *.dfm}


{ TProductClassListGUI }

procedure TProductClassListGUI.FormCreate(Sender: TObject);
begin
  PartClass := TPartClass.Create;
  makeQrymain;
  inherited;
end;

procedure TProductClassListGUI.FormDestroy(Sender: TObject);
begin
  PartClass.Free;
  inherited;

end;

procedure TProductClassListGUI.MakeQrymain;
var
  msg:String;
begin
  PartClass.PopulateReportSQL(qryMain.SQL, msg);
  self.RefreshOrignalSQL();
end;

procedure TProductClassListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('ClassId');
  RemoveFieldfromGrid('Globalref');
  RemoveFieldfromGrid('Id');
  RemoveFieldfromGrid('ProductId');
  RemoveFieldfromGrid('MsTimeStamp');
  RemoveFieldfromGrid('MsUpdateSiteCode');
end;

initialization
  RegisterClassOnce(TProductClassListGUI);

  end.
