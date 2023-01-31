unit SalesConvertedtoList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, wwcheckbox;

type
  TsalesConvertedtoListGUI = class(TBaseListingGUI)
    qryMainSaleID: TIntegerField;
    qryMainGlobalRef: TWideStringField;
    qryMainInvoiceDocNumber: TWideStringField;
    qryMainOriginalNo: TWideStringField;
    qryMainBaseNo: TWideStringField;
    qryMainBOID: TWideStringField;
    qryMainCustomerName: TWideStringField;
    qryMainSaleDate: TDateField;
    qryMainTotalAmount: TFloatField;
    qryMainTotalAmountInc: TFloatField;
    qryMainEmployeeName: TWideStringField;
    qryMainDeleted: TWideStringField;
    qryMainEnteredBy: TWideStringField;
    qryMainTranstype: TWideStringField;
    procedure grdMainDblClick(Sender: TObject); override;
  private
    fsConvertingFromRef: String;
    fiConvertingFromId: Integer;
    procedure setConvertingFromId(const Value: Integer);
    procedure setConvertingFromRef(const Value: String);

  Protected
    { Private declarations }
  public
    Procedure RefreshQuery;Override;
    Property ConvertingFromRef :String read fsConvertingFromRef write setConvertingFromRef;
    Property ConvertingFromId:Integer read fiConvertingFromId write setConvertingFromId;
  end;


implementation

{$R *.dfm}

{ TsalesConvertedtoListGUI }

procedure TsalesConvertedtoListGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMainTranstype.AsString;
  inherited;

end;

procedure TsalesConvertedtoListGUI.RefreshQuery;
begin
  inherited;
end;

procedure TsalesConvertedtoListGUI.setConvertingFromId(const Value: Integer);
begin
  fiConvertingFromId := Value;
end;

procedure TsalesConvertedtoListGUI.setConvertingFromRef(const Value: String);
begin
  fsConvertingFromRef := Value;
  Qrymain.Parambyname('ConvertingFromRef').asString := Value;
end;

end.

