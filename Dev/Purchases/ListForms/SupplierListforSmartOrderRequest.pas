unit SupplierListforSmartOrderRequest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TSupplierListforSmartOrderRequestgui = class(TBaseListingGUI)
    qryMainPARTSNAME: TWideStringField;
    qryMainQty: TFloatField;
    qryMainSupplierProductCode: TWideStringField;
    qryMainSupplierProductName: TWideStringField;
    qryMainsuppliername: TWideStringField;
    qryMainCOSTINC1: TFloatField;
    qryMainCOST1: TFloatField;
    qryMainExtraBuyPrice: TFloatField;
    qryMainEmail: TWideStringField;
    qryMainClientID: TIntegerField;
    procedure FormCreate(Sender: TObject);
  private
    fiSmartOrderID:Integer;
  Protected
    procedure SetGridColumns; Override;
  public
    Property SmartOrderID :Integer read fiSmartOrderID write fiSmartOrderID;
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib;

{$R *.dfm}
procedure TSupplierListforSmartOrderRequestgui.FormCreate(Sender: TObject);
begin
  inherited;
  SmartOrderID:=0;
end;

procedure TSupplierListforSmartOrderRequestgui.RefreshQuery;
begin
  Qrymain.Parambyname('SmartOrderID').AsInteger := SmartOrderID;
  inherited;

end;

procedure TSupplierListforSmartOrderRequestgui.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainclientID.fieldname);
end;

initialization
  RegisterClassOnce(TSupplierListforSmartOrderRequestgui);

end.

