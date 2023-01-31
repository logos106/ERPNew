unit CustomerReturnList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  CustomInputBox;

type
  TCustomerReturnListGUI = class(TBaseListingGUI)
    qryMainSaleno: TWideStringField;
    qryMainSaleId: TIntegerField;
    qryMainCustomerName: TWideStringField;
    qryMainTotalAmountinc: TFloatField;
    qryMainTotalAmount: TFloatField;
    qryMainSaleDate: TDateField;
    qryMainDone: TWideStringField;
    qryMainStatus: TWideStringField;
    qryMainshipdate: TDateField;
    qryMainComments: TWideMemoField;
    qryMainconverted: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    fiCustomerId:Integer;
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;Override;
    Property CustomerId :Integer read fiCustomerId write fiCustomerId;
  end;

implementation

uses CommonLib, CommonFormLib;

{$R *.dfm}
procedure TCustomerReturnListGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TfmCustomerReturn' , 0);
end;

procedure TCustomerReturnListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  CustomerId:= 0;
end;

procedure TCustomerReturnListGUI.RefreshQuery;
begin
  Qrymain.Parambyname('DateFrom').asDateTime := filterdateFrom;
  Qrymain.Parambyname('Dateto').asDateTime := filterdateto;
  Qrymain.Parambyname('CustomerId').asInteger := CustomerId;
  inherited;
end;

procedure TCustomerReturnListGUI.SetGridColumns;
begin
  inherited;
end;

initialization
  RegisterClassOnce(TCustomerReturnListGUI);

end.

