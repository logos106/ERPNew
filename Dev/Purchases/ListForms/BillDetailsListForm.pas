unit BillDetailsListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton,  wwdblook,
  Shader, kbmMemTable, DAScript, MyScript, CustomInputBox, wwcheckbox;

type
  TBillDetailsListGUI = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainPurchaseOrderID: TIntegerField;
    qryMainPurchaseLineID: TIntegerField;
    qryMainType: TWideStringField;
    qryMainClientID: TIntegerField;
    qryMainCompany: TWideStringField;
    qryMainBillNumber: TWideStringField;
    qryMainComments: TWideStringField;
    qryMainAccountName: TWideStringField;
    qryMainTaxCode: TWideStringField;
    qryMainTax: TFloatField;
    qryMainMemo: TWideStringField;
    qryMainAmountEx: TFloatField;
    qryMainAmountInc: TFloatField;
    qryMainContact: TWideStringField;
    qryMainETADate: TDateField;
    qryMainPhone: TWideStringField;
    qryMainInvoiced: TWideStringField;
    qryMainIsCredit: TWideStringField;
    qryMainInvoiceNumber: TWideStringField;
    qryMainIsRA: TWideStringField;
    qryMainDeleted: TWideStringField;
    qryMainSalesComments: TWideStringField;
    qryMainCustomerJob: TWideStringField;
    qryMainCustomerJobID: TIntegerField;
    qryMainDepartment: TWideStringField;
    qryMainOrderDate: TDateTimeField;
    qryMainBalance: TFloatField;
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure FormCreate(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override; 
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    Procedure SetGridColumns;override;
  public
    { Public declarations }
  end;

var
  BillDetailsListGUI: TBillDetailsListGUI;

implementation

uses frmBill, CommonLib, tcConst;

{$R *.dfm}

{ TBillDetailsListGUI }

procedure TBillDetailsListGUI.RefreshQuery;
begin
  if chkIgnoreDates.Checked then begin
    qryMain.Params.ParamByName('txtfrom').AsDate := 0;
    qryMain.Params.ParamByName('txtto').AsDate := MaxDateTime;
  end
  else begin
    qryMain.Params.ParamByName('txtfrom').AsDate := dtFrom.DateTime;
    qryMain.Params.ParamByName('txtto').AsDate := dtTo.DateTime;
  end;
  inherited;
  grdMain.ColumnByName('PurchaseOrderNumber').DisplayLabel := 'Bill Number';
  grdMain.ColumnByName('OrderDate').DisplayLabel := 'Bill Date';
  qryMain.First;
end;

procedure TBillDetailsListGUI.RefreshTotals;
var
  bm: TBookmark;
  TotalAmountEx: double;
  TotalTax: double;
  TotalAmountInc: double;
begin
{The Credits are negated for the total. But the records in the
Grid is not showing the negated amount so a direct total of the amount
in the grid may not match with the totals displayed at the bottom}
  inherited;
  bm := qryMain.GetBookmark;
  qryMain.DisableControls;
  Try
    with qryMain do begin
      First;
      TotalAmountEx  := 0;
      TotalTax       := 0;
      TotalAmountInc := 0;
      while not Eof do begin
        if FieldByName('IsCredit').AsString = 'T' then begin
          TotalAmountEx := TotalAmountEx - qryMain.FieldByName('Amount (Ex)').AsFloat;
          TotalTax := TotalTax - qryMain.FieldByName('Tax').AsFloat;
          TotalAmountInc := TotalAmountInc - qryMain.FieldByName('Amount (Inc)').AsFloat;
        end else begin
          TotalAmountEx := TotalAmountEx + qryMain.FieldByName('Amount (Ex)').AsFloat;
          TotalTax := TotalTax + qryMain.FieldByName('Tax').AsFloat;
          TotalAmountInc := TotalAmountInc + +qryMain.FieldByName('Amount (Inc)').AsFloat;
        end;
        Next;
      end;
    end;
  finally
    qryMain.GotoBookmark(bm);
    qryMain.FreeBookmark(bm);
    qryMain.EnableControls;
  end;
  grdMain.ColumnByName('Amount (Ex)').FooterValue := FloatToStrF(TotalAmountEx, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Tax').FooterValue := FloatToStrF(TotalTax, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Amount (Inc)').FooterValue := FloatToStrF(TotalAmountInc, ffCurrency, 15, CurrencyRoundPlaces);
end;

procedure TBillDetailsListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.IndexFieldNames := QuotedStr('OrderDate') + ' DESC CIS ; ' + QuotedStr('PurchaseLineID') + ' DESC CIS';
  BaseIndexFieldNames := QuotedStr('PurchaseLineID') + ' DESC CIS';
end;

procedure TBillDetailsListGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMain.Fields.FieldByName('Type').AsString;
  inherited;
end;

procedure TBillDetailsListGUI.FormCreate(Sender: TObject);
begin
  fbEnableWebSearch := True;
  inherited;
end;

procedure TBillDetailsListGUI.cmdNewClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  tmpComponent := GetComponentByClassName('TBillGUI');
  If not Assigned(tmpComponent) then Exit;
  with TBillGUI(tmpComponent) do begin
    AttachObserver(Self);
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

procedure TBillDetailsListGUI.grpFiltersClick(Sender: TObject);
begin
  if grpFilters.Itemindex = 0 then GroupFilterString := 'Balance =0'
  else if grpFilters.Itemindex = 1 then GroupFilterString := 'Balance <>0'
  else GroupFilterString := '';
  inherited;
end;

procedure TBillDetailsListGUI.SetGridColumns;
begin
  RemoveFieldfromGrid('Balance');
  inherited;
end;

initialization
  RegisterClassOnce(TBillDetailsListGUI);

end.
