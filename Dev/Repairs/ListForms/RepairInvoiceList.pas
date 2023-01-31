unit RepairInvoiceList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, wwcheckbox, DAScript,
  MyScript, CustomInputBox;

type
  TRepairInvoiceListGUI = class(TBaseListingGUI)
    qryMainRepairID: TIntegerField;
    qryMainGlobalRef: TWideStringField;
    qryMainCreationDate: TDateField;
    qryMainDone: TWideStringField;
    qryMainNotes: TWideMemoField;
    qryMainFeedbackNotes: TWideMemoField;
    qryMainCustomerDetails: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainAltPhone: TWideStringField;
    qryMainMobile: TWideStringField;
    qryMainFax: TWideStringField;
    qryMainJobDueDate: TDateTimeField;
    qryMainConverted: TWideStringField;
    qryMainStatus: TWideStringField;
    qryMainBillToCustomerDetails: TWideStringField;
    qryMainBillCusID: TIntegerField;
    qryMainUseBillCust: TWideStringField;
    qryMainBillPhone: TWideStringField;
    qryMainBillAltPhone: TWideStringField;
    qryMainBillFax: TWideStringField;
    qryMainSOGlobalRef: TWideStringField;
    qryMainQuoteGlobalRef: TWideStringField;
    qryMainCustomerPONumber: TWideStringField;
    qryMainCompletionTime: TWideStringField;
    qryMainShipping: TWideStringField;
    qryMainAllocatedEmployeeID: TIntegerField;
    qryMainTerms: TWideStringField;
    qryMainBillMobile: TWideStringField;
    qryMainQuotedAmount: TFloatField;
    qryMainQuotedAmountinc: TFloatField;
    qryMainRepairClient: TWideStringField;
    qryMainBilltoclient: TWideStringField;
    qryMainRepName: TWideStringField;
    qryMainClassName: TWideStringField;
    qryMainInvoiceDocNumber: TWideStringField;
    Panel4: TPanel;
    lblClassTitle: TLabel;
    Label4: TLabel;
    chkAllClass: TwwCheckBox;
    cboClass: TwwDBLookupCombo;
    cboClassQry: TERPQuery;
    cboClassQryClassID: TIntegerField;
    cboClassQryClassName: TWideStringField;
    qryMainSaleId: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fiRepairId: Integer;
    { Private declarations }
  public
   Procedure RefreshQuery; override;
   Property RepairId :Integer read fiRepairId Write fiRepairId ;
  end;

implementation

uses FastFuncs, CommonLib, AppEnvironment;

{$R *.dfm}

{ TBaseListingGUI1 }

procedure TRepairInvoiceListGUI.RefreshQuery;
var
  Value: string;
begin
  qryMain.Close;
  qryMain.ParamCheck := true;
  if chkIgnoreDates.Checked then
  begin
    qryMain.Params.ParamByName('dtfrom').AsString := FormatDateTime('yyyy-mm-dd 0:00:00', 0); //dtfrom.DateTime);
    qryMain.Params.ParamByName('dtto').AsString := FormatDateTime('yyyy-mm-dd 23:59:59', Date()); //dtto.DateTime);
  end
  else
  begin
    qryMain.Params.ParamByName('dtfrom').AsString := FormatDateTime('yyyy-mm-dd 0:00:00', dtfrom.DateTime);
    qryMain.Params.ParamByName('dtto').AsString := FormatDateTime('yyyy-mm-dd 23:59:59', dtto.DateTime);
  end;

  if not chkAllClass.Checked then Value := cboClassQryClassID.asSTring else Value := '%';
  qryMain.Params.ParamByName('ClassID').AsString := Value;

  if fiRepairId <> 0 then   Value := IntToStr(fiRepairId) else Value := '%';
  qryMain.Params.ParamByName('RepairId').AsString := Value;
  inherited;
end;

procedure TRepairInvoiceListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fiRepairId := 0;
end;
procedure TRepairInvoiceListGUI.FormShow(Sender: TObject);
begin
  cboClassQry.Open;
  cboClassQry.Locate('ClassName', AppEnv.DefaultClass.DefaultClassName, [loCaseInsensitive]);
  cboClass.LookupValue := IntToStr(AppEnv.DefaultClass.ClassID);
  cboClass.Text := AppEnv.DefaultClass.DefaultClassName;
  inherited;

end;

initialization
  RegisterClassOnce(TRepairInvoiceListGUI);

end.
