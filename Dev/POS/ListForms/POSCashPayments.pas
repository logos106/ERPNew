unit POSCashPayments;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB, DAScript, MyScript, ERPdbComponents,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TPOSCashPaymentsGUI = class(TBaseListingGUI)
    qryMainCateogory: TLargeintField;
    qryMainSaleId: TIntegerField;
    qryMainTillName: TWideStringField;
    qryMainCustomerName: TWideStringField;
    qryMainsaleDate: TDateTimeField;
    qryMainAmount: TFloatField;
    qryMainOtherPayments: TFloatField;
    qryMainCashDropped: TFloatField;
    procedure FormCreate(Sender: TObject);
  private
  Protected
    Procedure RefreshTotals;Override;
    procedure SetGridColumns; Override;
  public
  end;

var
  POSCashPaymentsGUI: TPOSCashPaymentsGUI;

implementation

uses CommonLib;

{$R *.dfm}

procedure TPOSCashPaymentsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  AddCalccolumn(qryMainAmount.fieldname, true);
  AddCalccolumn(qryMainCashDropped.fieldname, true);
  AddCalccolumn(qryMainOtherPayments.fieldname, true);
  HaveDateRangeSelection := False;
end;

procedure TPOSCashPaymentsGUI.RefreshTotals;
begin
  inherited;
  CalcnShowFooter;

end;
procedure TPOSCashPaymentsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainCateogory.fieldname);
end;

initialization
  RegisterClassOnce(TPOSCashPaymentsGUI);

end.
