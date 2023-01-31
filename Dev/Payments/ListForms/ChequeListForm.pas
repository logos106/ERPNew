unit ChequeListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList,
  Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, DNMPanel, MemDS, DBAccess,
  MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog,  wwdblook,
  Shader, kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TChequeListGUI = class(TBaseListingGUI)
    qryMainPurchaseOrderID: TAutoIncField;
    qryMainClientID: TAutoIncField;
    qryMainCompany: TWideStringField;
    qryMainPONum: TWideStringField;
    qryMainOrderDate: TDateTimeField;
    qryMainComments: TWideStringField;
    qryMainContact1: TWideStringField;
    qryMainETADate: TDateField;
    qryMainPhone: TWideStringField;
    qryMainInvoiced: TWideStringField;
    qryMainDeleted: TWideStringField;
    qryMainSalesComments: TWideStringField;
    qryMainReferenceNo: TWideStringField;
    qryMainChequeNumber: TWideStringField;
    qryMainTotalAmountEx: TFloatField;
    qryMainTotalTax: TFloatField;
    qryMainTotalAmountInc: TFloatField;
    qryMainGlobalRef: TWideStringField;
    qryMainMemo: TWideStringField;
    btnPruintcheques: TDNMSpeedButton;
    procedure cmdNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPruintchequesClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);override;
    function GetReportTypeID: integer; override;
    procedure SetGridColumns; override;
  public
    { Public declarations }
  end;

implementation

uses Forms, frmCheque, CommonLib, AppEnvironment, chequeLib, CommonFormLib;

{$R *.dfm}

procedure TChequeListGUI.cmdNewClick(Sender: TObject);
begin
  OpenERPForm('TfmCheque' , 0);
(*var tmpComponent:TComponent;
begin
  DisableForm;
  try
    inherited;

    tmpComponent:=GetComponentByClassName('TfmCheque');
    if not assigned(tmpComponent) then exit;
    with TfmCheque(tmpComponent) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;

    //  MainForm.Cheque1Click(Sender);
  finally
    EnableForm;
  end;*)
end;

procedure TChequeListGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('dtFrom').AsDate := FilterDateFrom;
  qryMain.Params.ParamByName('dtTo').AsDate := FilterDateTo;
  inherited;
end;

procedure TChequeListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  if (not Assigned(Owner)) or (not (Owner is TForm)) then begin
    {only do this if the list not owned by another form, ie embeded}
    fbEnableWebSearch := true;
  end;
  AddCalccolumn('total amount (Ex)' , true);
  AddCalccolumn('Total Tax' , true);
  AddCalccolumn('Total Amount (Inc)' , true);
end;

procedure TChequeListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TChequeListGUI.btnPruintchequesClick(Sender: TObject);
begin
  inherited;
  ReportToPrint :=  ReportName;
  ReportSQLSupplied := true;
  IterateProcNo:= 1;
  try
    PrintTemplate.CancelPreviewAll:= False;
    try
      IterateselectedRecords;
    finally
      PrintTemplate.ShowCancelPreviewBtninReportPreview:=False;
    end;
  finally
    IterateProcNo:=0;
    ReportSQLSupplied := False;
    ReportToPrint:= '';
  end;
end;
procedure TChequeListGUI.IterateselectedRecordsCallback(var Abort: boolean;SelIndex:Integer);
var
  sSQL:String;
begin
  if IterateProcNo=1 then begin
    sSQL:= chequeSQL(QrymainpurchaseOrderID.AsInteger, QrymainTotalAmountInc.AsFloat);
    PrintTemplateReport(ReportToPrint, sSQL, chkPreview.Checked= False, 1, nil , '', true);
    if PrintTemplate.CancelPreviewAll then Abort := True;
  end;
end;

procedure TChequeListGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TChequeListGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TChequeListGUI.FormShow(Sender: TObject);
begin
  inherited;
  try  FocusControl(edtSearch); except end;
end;

function TChequeListGUI.GetReportTypeID: integer;
begin
  REsult:= 7;
end;

procedure TChequeListGUI.RefreshTotals;
begin
  inherited;
  CalcnShowFooter;
end;

procedure TChequeListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymainclientid.fieldname);
  RemoveFieldfromGrid(qryMainGlobalRef.fieldname);
  RemoveFieldfromGrid(qrymainPurchaseOrderId.fieldname);
end;

initialization
  RegisterClassOnce(TChequeListGUI);
end.
