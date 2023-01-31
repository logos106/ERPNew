unit SupplierPaymentListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm,
  PrintDAT, ActnList, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids,
  Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, DNMPanel, MemDS, DBAccess, MyAccess,
  wwdbdatetimepicker, ProgressDialog, CustomInputBox, wwdblook, Shader,
  kbmMemTable;

type
  TSupplierPaymentListGUI = class(TBaseListingGUI)
    qryMainSupplierName: TStringField;
    qryMainOpeningBalance: TFloatField;
    qryMainPaymentAmount: TFloatField;
    qryMainPaymentMethod: TStringField;
    qryMainReferenceNo: TStringField;
    qryMainBankAccount: TStringField;
    qryMainDepartment: TStringField;
    qryMainNotes: TStringField;
    qryMainDeleted: TStringField;
    qryMainClassID: TIntegerField;
    qryMainClientID: TAutoIncField;
    qryMainPaymentID: TAutoIncField;
    qryMainEmployeeID: TIntegerField;
    qryMainAccountID: TIntegerField;
    qryMainReceiptNo: TStringField;
    qryMainGlobalRef: TStringField;
    qryMainPaymentDate: TDateField;
    procedure grpFiltersClick(Sender: TObject); override;
    procedure cmdNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;    
  public
    { Public declarations }
  end;

implementation

uses frmSuppPayments, CommonLib, Forms;

{$R *.dfm}

procedure TSupplierPaymentListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin
        GroupFilterString := 'Deleted <> ' + QuotedStr('T');
      end;
    1: 
      begin
        GroupFilterString := 'Deleted = ' + QuotedStr('T');
      end;
  end;
  inherited;
end;

procedure TSupplierPaymentListGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('txtfrom').AsDateTime := dtfrom.DateTime;
  qryMain.Params.ParamByName('txtto').AsDateTime := dtto.DateTime;
  inherited;
  qryMainReferenceNo.DisplayLabel := 'Chq / Reference #';
end;

procedure TSupplierPaymentListGUI.cmdNewClick(Sender: TObject);
var 
  tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := GetComponentByClassName('TfmSuppPayments');
  if not Assigned(tmpComponent) then Exit;
  with TfmSuppPayments(tmpComponent) do begin
    AttachObserver(Self);
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

procedure TSupplierPaymentListGUI.RefreshTotals;
var
  TotalPayments: double;
begin
  TotalPayments := 0;
  qryMain.DisableControls;
  with qryMain do begin
    First;
    while not Eof do begin
      TotalPayments := TotalPayments + qryMainPaymentAmount.AsCurrency;
      Next;
    end;
    First;
  end;
  qryMain.EnableControls;
  grdMain.ColumnByName('PaymentAmount').FooterValue := FloatToStrF(TotalPayments, ffCurrency, 15, 2);
end;

procedure TSupplierPaymentListGUI.FormCreate(Sender: TObject);
begin
  fbEnableWebSearch := true;
  inherited;
  ShowChartViewOnPopup := True;
end;

initialization
  RegisterClassOnce(TSupplierPaymentListGUI);
end.

