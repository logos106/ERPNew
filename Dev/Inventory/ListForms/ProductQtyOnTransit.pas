unit ProductQtyOnTransit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TProductQtyOnTransitGUI = class(TBaseListingGUI)
    qryMainTransferEntryID: TIntegerField;
    qryMainDateTransferred: TDateTimeField;
    qryMainEmployeeName: TWideStringField;
    qryMainTransferFrom: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainClassNameTo: TWideStringField;
    qryMainUOMTransferQty: TFloatField;
    qryMainTransferUOM: TWideStringField;
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormCreate(Sender: TObject);
  private
    fiProductId: Integer;
  public
    Property ProductId :Integer read fiProductId write fiProductId;
    Procedure RefreshQuery;Override;
  end;

implementation

uses tcDataUtils, CommonLib;

{$R *.dfm}

procedure TProductQtyOnTransitGUI.FormCreate(Sender: TObject);
begin
  ProductId := 0;
  inherited;

end;

procedure TProductQtyOnTransitGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + TransferType(qryMainTransferEntryID.asInteger) ;
  inherited;

end;

procedure TProductQtyOnTransitGUI.RefreshQuery;
begin
  Qrymain.parambyname('ProductID').AsInteger := ProductID;
  inherited;
end;
initialization
  RegisterClassOnce(TProductQtyOnTransitGUI);

end.
