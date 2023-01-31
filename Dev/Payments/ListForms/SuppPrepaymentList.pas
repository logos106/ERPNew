unit SuppPrepaymentList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, MemDS, DBAccess, MyAccess,ERPdbComponents,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox;

type
  TSuppPrepaymentListGUI = class(TBaseListingGUI)
    qryMainPaymentDate: TDateField;
    qryMainAmount: TFloatField;
    qryMainReferenceNo: TWideStringField;
    qryMainDeleted: TWideStringField;
    qryMainPaymentMethod: TWideStringField;
    qryMainDepartment: TWideStringField;
    qryMainNotes: TWideStringField;
    qryMainEmployeeID: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainAccountNo: TWideStringField;
    qryMainReceiptNo: TIntegerField;
    qryMainGlobalRef: TWideStringField;
    qryMainSupplierName: TWideStringField;
    qryMainForeignAmount: TFloatField;
    qryMainCurrency: TWideStringField;
    qryMainChequePrinted: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure cmdNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    procedure SetGridColumns; override;
  public
    { Public declarations }
  end;

implementation
  
uses frmSuppPrepayments, CommonLib, Forms, AppEnvironment, tcConst;
{$R *.dfm}

{ TSuppPrepaymentListGUI }

procedure TSuppPrepaymentListGUI.RefreshQuery;
begin
  if chkIgnoreDates.Checked then begin
    qryMain.Params.ParamByName('txtfrom').AsDate := 0;
    qryMain.Params.ParamByName('txtto').AsDate := SysUtils.MaxDateTime;
  end
  else begin
    qryMain.Params.ParamByName('txtfrom').AsDate := dtFrom.DateTime;
    qryMain.Params.ParamByName('txtto').AsDate := dtTo.DateTime;
  end;
  inherited;
end;

procedure TSuppPrepaymentListGUI.RefreshTotals;
var
  TotalPayments: double;
  TotalForeignPayments: double;
begin
  TotalPayments := 0;
  TotalForeignPayments := 0;
  qryMain.DisableControls;
  with qryMain do begin
    First;
    while not Eof do begin
      TotalPayments := TotalPayments + qryMainAmount.AsCurrency;
      TotalForeignPayments := TotalForeignPayments + qryMainForeignAmount.AsCurrency;
      Next;
    end;
    First;
  end;

  qryMain.EnableControls;
  grdMain.ColumnByName('Amount').FooterValue := FloatToStrF(TotalPayments, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('ForeignAmount').FooterValue := FloatToStrF(TotalForeignPayments, ffNumber, 15, 2);
end;

procedure TSuppPrepaymentListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainclientID.fieldname);
  RemoveFieldfromGrid(QrymainEmployeeID.fieldname);
  RemoveFieldfromGrid(Qrymainglobalref.fieldname);
end;

procedure TSuppPrepaymentListGUI.FormCreate(Sender: TObject);
begin
  fbEnableWebSearch := true;
  inherited;
  ShowChartViewOnPopup := True;
end;

procedure TSuppPrepaymentListGUI.grpFiltersClick(Sender: TObject);
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

procedure TSuppPrepaymentListGUI.cmdNewClick(Sender: TObject);
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

procedure TSuppPrepaymentListGUI.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields(
    'EmployeeId,ClientId');
end;

initialization
  RegisterClassOnce(TSuppPrepaymentListGUI);
end.
