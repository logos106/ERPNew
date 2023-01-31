unit SupplierPrepaymentList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, MemDS, DBAccess, MyAccess,
  wwdbdatetimepicker, ProgressDialog, CustomInputBox, wwdblook, Shader,
  kbmMemTable;

type
  TSupplierPrepaymentListGUI = class(TBaseListingGUI)
    qryMainCompanyName: TStringField;
    qryMainPaymentDate: TDateField;
    qryMainAmount: TFloatField;
    qryMainReferenceNo: TStringField;
    qryMainDeleted: TStringField;
    qryMainPaymentMethod: TStringField;
    qryMainDepartment: TStringField;
    qryMainNotes: TStringField;
    qryMainEmployeeID: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainAccountNo: TStringField;
    qryMainReceiptNo: TIntegerField;
    qryMainGlobalRef: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject); override;
    procedure cmdNewClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
  public
    { Public declarations }
  end;

implementation
  
uses frmSuppPrepayments, CommonLib, Forms;
{$R *.dfm}

{ TSupplierPrepaymentListGUI }

procedure TSupplierPrepaymentListGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('txtfrom').AsDate := dtFrom.DateTime;
  qryMain.Params.ParamByName('txtto').AsDate := dtTo.DateTime;
  inherited;
end;

procedure TSupplierPrepaymentListGUI.RefreshTotals;
var
  TotalPayments: double;
begin
  TotalPayments := 0;
  qryMain.DisableControls;
  with qryMain do begin
    First;
    while not Eof do begin
      TotalPayments := TotalPayments + qryMainAmount.AsCurrency;
      Next;
    end;
    First;
  end;

  qryMain.EnableControls;
  grdMain.ColumnByName('Amount').FooterValue := FloatToStrF(TotalPayments, ffCurrency, 15, 2);
end;

procedure TSupplierPrepaymentListGUI.FormCreate(Sender: TObject);
begin
  fbEnableWebSearch := true;
  inherited;
  ShowChartViewOnPopup := True;  
end;

procedure TSupplierPrepaymentListGUI.grpFiltersClick(Sender: TObject);
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

procedure TSupplierPrepaymentListGUI.cmdNewClick(Sender: TObject);
var 
  tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := GetComponentByClassName('TfmSuppPrepayments');
  if not Assigned(tmpComponent) then Exit;
  with TfmSuppPrepayments(tmpComponent) do begin
    AttachObserver(Self);
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

initialization
  RegisterClassOnce(TSupplierPrepaymentListGUI);
end.
