unit BOMSalesOrders;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup;

type
  TBOMSalesOrdersGUI = class(TBaseListingGUI)
    qryMainSaleId: TIntegerField;
    qryMainproductname: TWideStringField;
    qryMainconverted: TWideStringField;
    qryMainProgressbuilding: TWideStringField;
    qryMainUOM: TWideStringField;
    qryMainUnitofMeasureQtySold: TFloatField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainUnitofMeasureBackorder: TFloatField;
    qryMainsaleDate: TDateField;
    btnfinalise: TDNMSpeedButton;
    btnCalcPrice: TDNMSpeedButton;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure cmdNewClick(Sender: TObject);
    procedure btnfinaliseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCalcPriceClick(Sender: TObject);
  private
    procedure FinaliseSO(const SaleID: Integer);
    procedure initSOForm(Sender: TObject);
    procedure closeSOform;
  Protected
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
  public
    Procedure RefreshQuery; Override;
  end;

implementation

uses CommonLib, CommonFormLib, frmSalesOrder;

{$R *.dfm}
{ TBOMSalesOrdersGUI }

procedure TBOMSalesOrdersGUI.btnCalcPriceClick(Sender: TObject);
begin
  inherited;
  if FormStillOpen('TSalesOrderGUI') then TForm(FindExistingComponent('TSalesOrderGUI')).Close;
  IterateProcno := 2;
  IterateSelectedRecords;
  closeSOform;
end;

procedure TBOMSalesOrdersGUI.btnfinaliseClick(Sender: TObject);
begin
  inherited;
  if FormStillOpen('TSalesOrderGUI') then TForm(FindExistingComponent('TSalesOrderGUI')).Close;
  IterateProcno := 1;
  IterateSelectedRecords;
  closeSOform;
  closedb(Qrymain);
  RefreshQuery;
end;
procedure TBOMSalesOrdersGUI.closeSOform;
var
  fr: TForm;
begin
    if FormStillOpen('TSalesOrderGUI')  then begin
        fr := TForm(FindExistingComponent('TSalesOrderGUI'));
        //While FormStillOpen('TSalesOrderGUI') do sleep(10);
        try Freeandnil(fr); except end;
    end;
end;
procedure TBOMSalesOrdersGUI.IterateselectedRecordsCallback(var Abort: boolean;  SelIndex: Integer);
begin
  inherited;
  if (IterateProcno = 1) or (IterateProcno = 2) then begin
    FinaliseSO(QrymainsaleId.asInteger);
    closeSOform;
  end;
end;
procedure TBOMSalesOrdersGUI.initSOForm(Sender:TObject);
begin
  if Sender is  TSalesOrderGUI then begin
    if IterateProcno = 1 then TSalesOrderGUI(Sender).DofinalisenClose := true;
    if IterateProcno = 2 then TSalesOrderGUI(Sender).DoCalcTreePrice := true;
  end;
end;
procedure TBOMSalesOrdersGUI.FinaliseSO(const SaleID:Integer);
begin
 OpenERPForm('TSalesOrderGUI' , SaleID , nil, initSOForm);
(*var
  Salesorder:TSalesorder;
begin
  Salesorder := TSalesorder.CreateWithNewConn(Self);
  try
    Salesorder.Load(SaleID);
    if Salesorder.count =0 then begin
      MessageDlgXP_vista('Order # ' + inttostr(SalesOrder.ID(+' not found.', mtWarning, [mbOK], 0);
      Exit;
    end;


    if not Salesorder.Lock then begin
      MessageDlgXP_vista('The Order # ' + inttostr(SalesOrder.ID(+' is Locked.'+NL+NL+
                      SalesOrder.Userlock.lockMessage, mtWarning, [mbOK], 0);
      Exit;
    end;

    if Salesorder.Converted then begin
      MessageDlgXP_vista('The Order # ' + inttostr(SalesOrder.ID(+' is already Converted', mtWarning, [mbOK], 0);
      Exit;
    end;


    if Salesorder.AnyLineHasTree = False then begin
      MessageDlgXP_vista('The Order has no BOM Product', mtWarning, [mbOK], 0);
      Exit;
    end;

    if not SOCompleted then exit;
    Result := True;
    if CloseAfteFinalize then Self.Close;
  finally
    Freeandnil(Salesorder);
  end;*)
end;

procedure TBOMSalesOrdersGUI.FormShow(Sender: TObject);
begin
  inherited;
  EnableMultiSelect('Select Sales to Finlaise');
end;

procedure TBOMSalesOrdersGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TSalesOrderGUI' , 0);
end;

procedure TBOMSalesOrdersGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Converted' , ['T','F','']);
  inherited;
end;


procedure TBOMSalesOrdersGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  inherited;
end;

initialization
  RegisterClassOnce(TBOMSalesOrdersGUI);

end.
