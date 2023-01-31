unit SalesTaxReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel , JSONObject,
  CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TSalesTaxReportGUI = class(TBaseListingGUI)
    qryMaincountry: TWideStringField;
    qryMainState: TWideStringField;
    qryMainSaleID: TIntegerField;
    qryMainSaledate: TDateField;
    qryMaintotalAmountinc: TFloatField;
    qryMaintotalAmount: TFloatField;
    qryMainTaxablesales: TFloatField;
    qryMainnonTaxablesales: TFloatField;
    qryMainFreightTaxablesales: TFloatField;
    qryMainFreightnonTaxablesales: TFloatField;
    qryMainExcemptSales: TFloatField;
    qryMaintotalTax: TFloatField;
    qryMainLineTaxCode: TWideStringField;
    DNMPanel1: TDNMPanel;
    Label4: TLabel;
    chkTaxCode: TCheckBox;
    Label5: TLabel;
    cbTaxCodeQry: TERPQuery;
    cbTaxCodeQryTaxCodeID: TIntegerField;
    cbTaxCodeQryTaxcode: TWideStringField;
    cbTaxCodeQryDescription: TWideStringField;
    cbTaxCodeQryRate: TFloatField;
    cboTaxCode: TwwDBLookupCombo;
    qryMainSaletype: TWideStringField;
    QryStates: TERPQuery;
    DNMPanel2: TDNMPanel;
    Label6: TLabel;
    cboState: TwwDBLookupCombo;
    QryStatesstate: TWideStringField;
    Label7: TLabel;
    chkState: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure cbTaxCodeQryBeforeOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure cboTaxCodeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure chkTaxCodeClick(Sender: TObject);
    procedure cbTaxCodeQryAfterScroll(DataSet: TDataSet);
    procedure grdMainDblClick(Sender: TObject);override;
    procedure QryStatesBeforeOpen(DataSet: TDataSet);
    procedure cboStateCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure chkStateClick(Sender: TObject);
  private
    function getTaxcode: String;
    procedure setTaxcode(const Value: String);
    function MainSQL: String;
    function subSQL: String;
    function getstate: String;
    procedure setstate(const Value: String);
  Protected
    function GetReportTypeID: integer; Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
  public
    Procedure RefreshQuery;Override;
    Property TaxCode :String read getTaxcode write setTaxcode;
    Property State:String read getstate write setstate;
  end;


implementation

uses CommonLib , MySQLConst, AppEnvironment, tcTypes, ProductQtyLib;

{$R *.dfm}

{ TSalesTaxReportGUI }
function TSalesTaxReportGUI.getstate: String;
begin
  if chkState.Checked  then
    result:= ''
  else result := QryStates.FieldByname('state').asString;

end;

Function TSalesTaxReportGUI.getTaxcode :String;
begin
  if chkTaxCode.Checked  then
    result:= ''
  else result := cbTaxCodeQry.FieldByname('Taxcode').asString;
end;
procedure TSalesTaxReportGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + QrymainSaleType.AsString;
  inherited;
end;

procedure TSalesTaxReportGUI.QryStatesBeforeOpen(DataSet: TDataSet);
begin
  inherited;
    QryStates.ParamByName('xRegionID').AsInteger := Appenv.RegionalOptions.ID;
end;

procedure TSalesTaxReportGUI.cboStateCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if not(modified) then exit;
  chkState.Checked := False;
  RefreshQuery;
end;

procedure TSalesTaxReportGUI.cboTaxCodeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if not(modified) then exit;
  chkTaxcode.Checked := False;
  RefreshQuery;
end;

procedure TSalesTaxReportGUI.cbTaxCodeQryAfterScroll(DataSet: TDataSet);
begin
  inherited;
  cbotaxcode.Text := cbTaxCodeQryTaxCode.AsString;
end;

procedure TSalesTaxReportGUI.cbTaxCodeQryBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  cbTaxCodeQry.ParamByName('xRegionID').AsInteger := Appenv.RegionalOptions.ID;
end;

procedure TSalesTaxReportGUI.chkStateClick(Sender: TObject);
begin
  inherited;
  if Screen.activeControl = chkState then begin
    RefreshQuery;
    if chkState.Checked then cboState.Text := '';
  end;
end;

procedure TSalesTaxReportGUI.chkTaxCodeClick(Sender: TObject);
begin
  inherited;
  if Screen.activeControl = chkTaxcode then
    RefreshQuery;
end;

procedure TSalesTaxReportGUI.cmdPrintClick(Sender: TObject);
var
  strSQL:String;
begin
  DisableForm;
  try
    ReportSQLSupplied   := true;
    UseStringListForSQL := False;
    try
      strSQL := ' ~|||~{Details}' +MainSQL + ' ~|||~{SubTaxDetails}' +subSQL;
      strSQL := ' {CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, CO.PhoneNumber AS PhoneNumber, ' +
                     ' CO.FaxNumber AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO  ' +
                      strSQL +
                     '~|||~{ReportRange} Select ' + Quotedstr(formatDateTime(FormatSettings.shortdateFormat , filterdateFrom)) +' as DateFrom ,' +
                                                    Quotedstr(formatDateTime(FormatSettings.shortdateFormat , filterdateto)) +'  as DateTo';
      if chkState.checked = False then begin
        TemplateSQL := replacestr(strSQL , ':DateFrom' , Quotedstr(formatDateTime(MysqlDateTimeFormat , filterdateFrom)));
        TemplateSQL := replacestr( TemplateSQL, ':DateTo'   , Quotedstr(formatDateTime(MysqlDateTimeFormat , filterdateTo)));
        TemplateSQL := replacestr( TemplateSQL, ':State'   , Quotedstr(state));
        fbShowCancelPreviewBtninReportPreview:= False;
        inherited;
      end else begin
        Qrymain.disablecontrols;
        try
          chkState.checked:= False;
          try
            fbShowCancelPreviewBtninReportPreview:=True;
            QryStates.first;
            While QryStates.eof = False do begin
              cboState.text :=QryStatesstate.asString;
              RefreshQuery;
              if Qrymain.recordcount >0 then begin
                  TemplateSQL := replacestr(strSQL ,':DateFrom', Quotedstr(formatDateTime(MysqlDateTimeFormat , filterdateFrom)));
                  TemplateSQL := replacestr(TemplateSQL ,':DateTo'  , Quotedstr(formatDateTime(MysqlDateTimeFormat , filterdateTo)));
                  TemplateSQL := replacestr(TemplateSQL ,':State'   , Quotedstr(state));
                  inherited;
                  if PrintTemplate.CancelPreviewAll then exit;
              end;
              QryStates.Next;
            end;
          finally
            fbShowCancelPreviewBtninReportPreview:= False;
            chkState.checked:= True;
            RefreshQuery;
          end;

        finally
          Qrymain.Enablecontrols;
        end;
      end;
    finally
      ReportSQLSupplied   := false;
    end;
  finally
    EnableForm;
  end;
end;
function TSalesTaxReportGUI.subSQL: String;
begin
  Result := 'Select  ' +
            's.SaleDate, if(ifnull(SA.ShipState,"")="", C.State ,SA.ShipState ) as State,  ' +
            ' s.SAleId,STC.Code , STC.Description ,   ' +
            SubTaxcodeCategory('STC') + '  as Category,  ' +
            'concat(STC.Code , "- " , ' + SubTaxcodeCategory('STC') + ')  as CodeCat,  ' +
            ' sum(SL.TotalLineAmount) as totalAmount ,  ' +
            ' sum(SL.TotalLineAmountInc) as totalAmountinc ,  ' +
            ' sum( if( SL.LineTax<>0, SL.TotalLineAmountInc , 0)) as Taxablesales,  ' +
            ' sum( if (SL.LineTax=0, SL.TotalLineAmountInc , 0)) as nonTaxablesales ,  ' +
            ' sum( if( SL.LineTax<>0 and Productname like "%Freight%", SL.TotalLineAmountInc , 0)) as FreightTaxablesales,  ' +
            ' sum( if( SL.LineTax=0 and Productname like "%Freight%", SL.TotalLineAmountInc , 0)) as FreightnonTaxablesales,  ' +
            ' sum( if( TC.description like "%Exempt%" , SL.TotalLineAmountInc , 0)) as ExcemptSales,  ' +
            ' sum(STL.TaxAmount) as totalTax  ' +
            ' from tblsales S  ' +
            ' inner join tblsaleslines SL on S.SAleId = SL.saleId  ' +
            ' inner join tblsalestaxcodes ST on ST.SaleID = SL.SaleId and ST.SaleLineId = SL.sAleLineID  ' +
            ' inner join tblsalestaxcodelines STL on STL.SalesTaxCodeID = ST.ID  ' +
            ' inner join tblsubtaxcode STC ON STC.ID = STL.SubTaxID  ' +
            ' Left join tbltaxcodes TC on TC.Name = SL.LineTaxCode  ' +
            ' Left join tblshippingaddress SA on SA.ShipAddressID =  S.ShipToID  ' +
            ' inner join tblclients C on S.ClientID = C.ClientID  ' +
            ' Where S.SaleDate between :DateFrom and :DateTo'+
            ' and   (S.IsInvoice ="T" or S.ISCashSale ="T" or S.IsRefund ="T" or S.ISPOS ="T")'+
            ' and (:State="" or if(ifnull(SA.ShipState,"")="", C.State ,SA.ShipState ) =:State)'+
            ' group by STC.Code, S.SaleId ' +
            ' order by state , ' + SubTaxcodeCategoryNO('STC') +' , Code, saleDate';
end;

function TSalesTaxReportGUI.MainSQL:String;
begin
  Result := 'Select'+ #13#10 +
            'SL.LineTaxCode,'+ #13#10 +
            'if(ifnull(SA.ShipCountry,"")="", C.Country ,SA.ShipCountry ) as country,'+ #13#10 +
            'if(ifnull(SA.ShipState,"")="", C.State ,SA.ShipState ) as State,'+ #13#10 +
            'S.sALeId ,'+ #13#10 +
             SaleType('S')+  '  as Saletype,'+ #13#10 +
            'S.SaleDate,'+ #13#10 +
            'sum(SL.TotalLineAmount) as totalAmount ,'+ #13#10 +
            'sum(SL.TotalLineAmountInc) as totalAmountinc ,'+ #13#10 +
            'Sum( if( SL.LineTax<>0, SL.TotalLineAmountInc , 0)) as Taxablesales,'+ #13#10 +
            'Sum( if (SL.LineTax=0, SL.TotalLineAmountInc , 0)) as nonTaxablesales ,'+ #13#10 +
            'Sum( if( SL.LineTax<>0 and Productname like "%Freight%", SL.TotalLineAmountInc , 0)) as FreightTaxablesales,'+ #13#10 +
            'Sum( if( SL.LineTax=0 and Productname like "%Freight%", SL.TotalLineAmountInc , 0)) as FreightnonTaxablesales,'+ #13#10 +
            'Sum( if( TC.description like "%Exempt%" , SL.TotalLineAmountInc , 0)) as ExcemptSales,'+ #13#10 +
            'Sum(SL.LineTax) as totalTax'+ #13#10 +
            'from tblsales S'+ #13#10 +
            'inner join tblsaleslines SL on S.SAleId = SL.saleId'+ #13#10 +
            'Left join tbltaxcodes TC on TC.Name = SL.LineTaxCode  and TC.RegionID = '+IntToStr(AppEnv.RegionalOptions.ID) + #13#10 +
            'inner join tblclients C on S.ClientID = C.ClientID'+ #13#10 +
            'Left join tblshippingaddress SA on SA.ShipAddressID =  S.ShipToID'+ #13#10 +
            'Where S.SAleDate between :DateFrom and :DateTo'+ #13#10 +
            'and   (S.IsInvoice ="T" or S.ISCashSale ="T" or S.IsRefund ="T" or S.ISPOS ="T")'+ #13#10 +
            'and (:State="" or if(ifnull(SA.ShipState,"")="", C.State ,SA.ShipState ) =:State)'+ #13#10 +
            //'and (:TaxCode="" or SL.LineTaxCode =:TaxCode)'+ #13#10 +
            'group by SaleDate , saleID , SL.LineTaxCode'+ #13#10 +
            'Order by LineTaxCode, State , SaleDate, saleID';
end;

procedure TSalesTaxReportGUI.FormCreate(Sender: TObject);
begin
  Qrymain.SQL.text :=MainSQL;
  inherited;
  chkAdvancedPrinting.Visible := appenv.RegionalOptions.RegionType <> rAUST;
  pnlAdvPrinting.Visible := appenv.RegionalOptions.RegionType <> rAUST;
  AddCalcColumn(QrymaintotalAmountinc.FieldName, true);
  AddCalcColumn(QrymainTaxablesales.FieldName, true);
  AddCalcColumn(QrymainnonTaxablesales.FieldName, true);
  AddCalcColumn(QrymainFreightTaxablesales.FieldName, true);
  AddCalcColumn(QrymainFreightnonTaxablesales.FieldName, true);
  AddCalcColumn(QrymainExcemptSales.FieldName, true);
  AddCalcColumn(QrymaintotalTax.FieldName, true);
end;


procedure TSalesTaxReportGUI.FormShow(Sender: TObject);
begin
  cbTaxCodeQry.Open;
  QryStates.open;
  inherited;
end;

function TSalesTaxReportGUI.GetReportTypeID: integer;
begin
  result := 118;
end;

procedure TSalesTaxReportGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  Taxcode :=  GuiPrefs.Node['Options.Taxcode'].AsString;
  state :=  GuiPrefs.Node['Options.State'].AsString;
end;

procedure TSalesTaxReportGUI.RefreshQuery;
begin
  Qrymain.ParamByName('DateFrom').asDatetime := filterdateFrom;
  Qrymain.ParamByName('DateTo').asDatetime := filterdateTo;
  Qrymain.ParamByName('State').asString := state;
  inherited;

end;

procedure TSalesTaxReportGUI.setstate(const Value: String);
begin
       if Value = '' then chkState.Checked := True
  else if QryStates.Locate('State', value, []) then begin
    ChkState.Checked := False;
    cboState.Text := QryStatesstate.AsString;
  end;
end;

procedure TSalesTaxReportGUI.setTaxcode(const Value: String);
begin
if Value = '' then chkTaxCode.Checked := True
else if cbTaxCodeQry.Locate('Taxcode', value, []) then chkTaxcode.Checked := False;
end;


procedure TSalesTaxReportGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.Taxcode'].AsString:= Taxcode;
  GuiPrefs.Node['Options.State'].AsString:= State;
end;

initialization
  RegisterClassOnce(TSalesTaxReportGUI);

end.

