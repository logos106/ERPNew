unit ChequeDetailsListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton,  wwdblook,
  Shader, kbmMemTable, DAScript, MyScript, CustomInputBox, wwcheckbox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TChequeDetailsListGUI = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainPurchaseOrderID: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainCompany: TWideStringField;
    qryMainPONum: TWideStringField;
    qryMainOrderDate: TDateTimeField;
    qryMainComments: TWideStringField;
    qryMainAccountName: TWideStringField;
    qryMainTaxCode: TWideStringField;
    qryMainTax: TFloatField;
    qryMainAmountEx: TFloatField;
    qryMainAmountInc: TFloatField;
    qryMainContact1: TWideStringField;
    qryMainETADate: TDateField;
    qryMainPhone: TWideStringField;
    qryMainInvoiced: TWideStringField;
    qryMainChequeNumber: TWideStringField;
    qryMainDeleted: TWideStringField;
    qryMainSalesComments: TWideStringField;
    qryMainReferenceNo: TWideStringField;
    qryMainCustomerJob: TWideStringField;
    qryMainCustomerJobID: TIntegerField;
    qryMainDepartment: TWideStringField;
    qryMainDescription: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
  public
    { Public declarations }
  end;

var
  ChequeDetailsListGUI: TChequeDetailsListGUI;

implementation

uses frmCheque, CommonLib, CommonFormLib;

{$R *.dfm}

procedure TChequeDetailsListGUI.cmdNewClick(Sender: TObject);
begin
  OpenERPForm('TfmCheque' , 0);
(*var tmpComponent:TComponent;
begin
  inherited;

  tmpComponent:=GetComponentByClassName('TfmCheque');
  if not assigned(tmpComponent) then exit;
  with TfmCheque(tmpComponent) do begin
    AttachObserver(Self);
    FormStyle := fsMDIChild;
    BringToFront;
  end;

  //  MainForm.Cheque1Click(Sender);*)
end;

procedure TChequeDetailsListGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('dtFrom').AsDate := filterDateFrom;
  qryMain.Params.ParamByName('dtTo').AsDate := FilterDateTo;
  inherited;
end;

procedure TChequeDetailsListGUI.FormCreate(Sender: TObject);
begin
  fbEnableWebSearch := true;
  inherited;
end;

initialization
  RegisterClassOnce(TChequeDetailsListGUI);
end.
