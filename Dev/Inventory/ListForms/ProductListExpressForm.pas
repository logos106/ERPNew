unit ProductListExpressForm;

{
 -------- -------- ---  ------------------------------------------------------
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 13/05/05  1.00.00 DJH  Added the Matrix Report Button.  Also fixed an
                        Access Level Bug in regards to then Customise Button
 30/08/05  1.00.01 IJB  Modified btnCustomizeClick event: moved Inherited to
                        after code that removes column.
 04/01/06  1.00.02 DSP  Date combo-boxes are now hidden.
 05/01/06  1.00.03 BJ   when the form is called from build group by double clickin on
                        blank combo box, the form is opene with all group products where
                        isSegregatedProduct = F and isVariable = F. buildgroup form
                        sets an applicationontext variable when this form is called.
}
{$I ERP.inc}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, wwidlg, wwfltdlg, DBAccess,
  MyAccess,ERPdbComponents, MemDS, wwcheckbox, wwdbdatetimepicker, ProgressDialog,
  KbmMemTable,  wwdblook, Shader, DAScript, MyScript , BaseListExpress, CustomInputBox, wwradiogroup,
  wwclearbuttongroup, GIFImg;

type
  TCustomFieldRec = class(TObject)
  private
  public
    sFieldLabel: string;
    sFieldName: string;
    bIsDate:Boolean;
  end;

type
  TProductListExpressGUI = class(TBaseListExpressGUI)
    qryMainPARTSID: TAutoIncField;
    qryMainProductName: TWideStringField;
    qryMainFirstColumn: TWideStringField;
    qryMainSecondColumn: TWideStringField;
    qryMainThirdColumn: TWideStringField;
    qryMainSalesDescription: TWideStringField;
    qryMainPriceInc: TFloatField;
    qryMainPartType: TWideStringField;
    Timer1: TTimer;
    qryMainCUSTFLD1: TWideStringField;
    qryMainCUSTFLD2: TWideStringField;
    qryMainCUSTFLD3: TWideStringField;
    qryMainCUSTFLD4: TWideStringField;
    qryMainCUSTFLD5: TWideStringField;
    qryMainCUSTFLD6: TWideStringField;
    qryMainCUSTFLD7: TWideStringField;
    qryMainCUSTFLD8: TWideStringField;
    qryMainCUSTFLD9: TWideStringField;
    qryMainCUSTFLD10: TWideStringField;
    qryMainCUSTFLD11: TWideStringField;
    qryMainCUSTFLD12: TWideStringField;
    qryMainCUSTFLD13: TWideStringField;
    qryMainCUSTFLD14: TWideStringField;
    qryMainCUSTFLD15: TWideStringField;
    qryMainCUSTDATE1: TDateTimeField;
    qryMainCUSTDATE2: TDateTimeField;
    qryMainCUSTDATE3: TDateTimeField;
    btnProcess: TDNMSpeedButton;
    btnSelectall: TDNMSpeedButton;
    DNMSpeedButton1: TDNMSpeedButton;
    qryMainBARCODE: TWideStringField;
    DNMSpeedButton2: TDNMSpeedButton;
    btnqtyver: TDNMSpeedButton;
    btnListWithDept: TDNMSpeedButton;
    qryMainActive: TWideStringField;
    qryMainIsSystemProduct: TWideStringField;
    qryMainDiscontinued: TWideStringField;
    qryMainArea: TWideStringField;
    qryMainProductionNotes: TWideMemoField;
    qryMainGeneralNotes: TWideMemoField;
    qryMainBatch: TWideStringField;
    qryMainMultiplebins: TWideStringField;
    qryMainSNtracking: TWideStringField;
    btnUpdateAvgcost: TDNMSpeedButton;
    qryMainPURCHASEDESC: TWideStringField;
    qryMainPreferedSupp: TWideStringField;
    DNMSpeedButton3: TDNMSpeedButton;
    grpExtraFilters: TwwRadioGroup;
    qryMainProductPrintName: TWideStringField;
    qryMainHasProductOptions: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure Timer1Timer(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure btnProcessClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure btnSelectallClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure btnListWithDeptClick(Sender: TObject);
    procedure btnqtyverClick(Sender: TObject);
    procedure DNMSpeedButton2Click(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure btnUpdateAvgcostClick(Sender: TObject);
    procedure DNMSpeedButton3Click(Sender: TObject);
    procedure chkIgnoreCustomerAreafilterClick(Sender: TObject);
  private
    btnProcessonclick :TNotifyEvent;
  protected
    procedure RefreshQuery; override;
    Procedure SetGridColumns;override;
    procedure ExtraSetupFormInPanel;override;
    Function ExpressDetailListName:String;override;
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);Override;
    Procedure InitGroupFilterString; overload;virtual;
    Function DefaultAllClasses :Integer;Override;
    Procedure WriteGuiPrefExtra; override;
    procedure ReadnApplyGuiPrefExtra; Override;
    procedure Selectrecords;Override;
    Function ExtraCompsforPanelWidths :Integer; Override;
    //Procedure SetExtraCompsforPanelWidths(var ileft :Integer; var igap:Integer);Override;
    Procedure inPanelcomponents(const ficmpProcess :TcmpProcessNo);Override;
  public
    Procedure ExpresslistPopup(const ProcessCaption:String; Process:TNotifyEvent; EnableMultiSelect:Boolean =true);

  end;


implementation

uses
  BaseInputForm,

  CommonLib, AppContextObj, Forms,
  AppEnvironment, FastFuncs, ProductQtyLib, CommonFormLib, ProductQtys, BusObjStock, CommonDbLib, ProductStockReportLib, ProductMovementList,
  SystemLib, tcConst;

{$R *.dfm}

procedure TProductListExpressGUI.FormCreate(Sender: TObject);
begin
  fbEnableWebSearch := true;
  inherited;
  HaveDateRangeSelection := False;
  (*if Appenv.CompanyPrefs.ProductClassDefaultAll  then SelectionOption := soClass;
  qryMain.ParamByName('RegionID').AsInteger := AppEnv.RegionalOptions.ID;*)
  ShowChartViewOnPopup := True;
  btnProcessonclick := nil;
  grpExtraFilters.ItemIndex := 3;
  grpExtraFilters.Visible := false;

  btnqtyver.visible := devmode;
  btnUpdateAvgcost.Visible := Devmode;

  KeyIdfieldname := qryMainPARTSID.Fieldname;
  KeyNamefieldname := qryMainProductName.Fieldname;
end;

procedure TProductListExpressGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
end;

procedure TProductListExpressGUI.RefreshQuery;
begin
(*  qryMain.Params.ParamByName('IgnoreClassfilter').AsString := BooleanToStr(AppEnv.CompanyPrefs.ProductClassDefaultAll and AllClasses);
  qryMain.Params.ParamByName('ClassID').AsInteger := iif(AppEnv.CompanyPrefs.ProductClassDefaultAll  , SelectedClassID , appenv.Employee.DefaultClassID);*)
  inherited;
end;

procedure TProductListExpressGUI.cmdNewClick(Sender: TObject);
(*Var Form : TComponent;*)
begin
(*  DisableForm;
  try
    inherited;
    Form := GetComponentByClassName('TfrmParts');
    if Assigned(Form) then begin //if has acess
      with TBaseInputGUI(Form) do begin
        AttachObserver(Self);
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  finally
    EnableForm;
  end;*)
  OpenERPForm('TfrmParts', 0);
end;

procedure TProductListExpressGUI.FormShow(Sender: TObject);
begin
  inherited;

  if EmployeeHasAccess('CanViewInactiveProducts') = False then begin
     if grpFilters.itemindex <> 0 then grpFilters.itemindex := 0;
     grpFilters.visible := False;
  end;

  if ErrorOccurred then Exit;
  qryMain.First;
  PopulateFilterCombo;
  cboFilter.ItemIndex := 0;
  Timer1.Enabled := True;
  if AppEnv.CompanyPrefs.ProductClassDefaultAll then
    //TimerMsg(FilterLabel , 'The list shows Products of all ' + Appenv.DefaultClass.ClassHeading+'s based on the preference')
  else if Appenv.Employee.DefaultClassID =0 then
    TimerMsg(FilterLabel , 'The list shows Products of your Default ' + Appenv.DefaultClass.ClassHeading+' based on the preference. Your Default ' + Appenv.DefaultClass.ClassHeading+' is not selected')

  else
    TimerMsg(FilterLabel , 'The list shows Products of your Default ' + Appenv.DefaultClass.ClassHeading+' - '+ quotedstr(Appenv.Employee.DefaultClassName)+' based on the preference');

  if  (grdmain.SelectedList.Count >0) then begin
    qrymain.GoToBookmark(grdmain.SelectedList.Items[0]);
  end else if Appenv.CompanyPrefs.AutoLocateproductinList then
    if GuiPrefs.Node.Exists('Options.PartsID') then
      Qrymain.locate('PartsId',  GuiPrefs.Node['Options.PartsID'].asInteger , []);


end;

procedure TProductListExpressGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.IndexFieldNames := QuotedStr('ProductName') + ' ASC CIS';
  BaseIndexFieldNames := qryMain.IndexFieldNames;
end;

procedure TProductListExpressGUI.Timer1Timer(Sender: TObject);
begin
  inherited;           //ugly but only way I could force cursor to edtSearch
  if Timer1.Enabled = True then begin
    Timer1.Enabled := False;
    SetControlFocus(edtSearch);
  end;
end;

procedure TProductListExpressGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.PartsID'].asInteger := QrymainpartsID.asInteger;
end;

procedure TProductListExpressGUI.chkIgnoreCustomerAreafilterClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TProductListExpressGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TProductListExpressGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TProductListExpressGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TProductListExpressGUI.Selectrecords;
begin
  inherited;
end;

procedure TProductListExpressGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymainpartsID.fieldname);
  SetUpcustomFields('Product');
end;

procedure TProductListExpressGUI.ExpresslistPopup(const ProcessCaption: String; Process: TNotifyEvent; EnableMultiSelect:Boolean =true);
begin
  btnProcess.Caption :=ProcessCaption;
  btnProcessonclick := Process;
  btnProcess.Enabled := True;
  btnProcess.Visible := true;
  cmdNew.Enabled := False;
  btnSelectall.enabled := true;
  btnExpressDetail.visible := False;
  btnListWithDept.visible := False;
  if EnableMultiSelect then begin
    grdMain.MultiSelectOptions := grdMain.MultiSelectOptions + [msoShiftSelect];
    grdMain.Options := grdMain.Options + [dgMultiSelect];
  end else begin
    grdMain.MultiSelectOptions := grdMain.MultiSelectOptions - [msoShiftSelect];
    grdMain.Options := grdMain.Options - [dgMultiSelect];
    grdMain.Options := grdMain.Options + [dgRowSelect];
  end;
  cmdExport.Enabled := False;
  cmdNew.Enabled := False;
  cmdPrint.Enabled := False;
  cmdClose.Enabled := False;
end;

procedure TProductListExpressGUI.ExtraSetupFormInPanel;
begin
  inherited;
  btnExpressDetail.Visible := False;
  btnRequery.visible := True;
  lblcustomReport.visible := True;
  cboCustomReports.visible := True;
  cboCustomReports.Width := lblcustomReport.Width;
  grpFilters.visible := EmployeeHasAccess('CanViewInactiveProducts');
  grpFilters.Parent := pnlbuttons;
  grpFilters.Align := alright;
  grpFilters.Width := 250;
  grpExtraFilters.Align := alright;
  grpExtraFilters.Width := 250;
end;

procedure TProductListExpressGUI.btnProcessClick(Sender: TObject);
begin
  inherited;
  if assigned(btnProcessonclick) then
    btnProcessonclick(grdmain);
  self.Close;
end;

procedure TProductListExpressGUI.grdMainDblClick(Sender: TObject);
begin
  if assigned(btnProcessonclick) then begin
    grdmain.SelectRecord;
    btnProcessonclick(grdmain);
    self.Close;
  end else
    inherited;

end;

procedure TProductListExpressGUI.grpFiltersClick(Sender: TObject);
var
  s:String;
begin
  if grpExtrafilters.ItemIndex = 0 then s:= 'Parttype = ' +Quotedstr('INV')
  else if grpExtrafilters.ItemIndex = 1 then s:= 'Parttype = ' +Quotedstr('NONINV')
  else if grpExtrafilters.ItemIndex = 2 then s:= 'Parttype <> ' +Quotedstr('NONINV') + ' and  Parttype <> ' +Quotedstr('INV')
  else s:= '';
  initGroupFilterString;
  if (s<> '') then begin
     if groupfilterString <> '' then groupfilterString := '('+ groupfilterString +') and ';
     groupfilterString := groupfilterString + '(' + s +')';
  end;
  inherited;
end;

procedure TProductListExpressGUI.btnSelectallClick(Sender: TObject);
begin
  inherited;
  if btnSelectall.Caption = 'Select All' then begin
    grdmain.SelectAll;
    btnSelectall.Caption := 'Unselect All'
  end else begin
    grdmain.UnSelectAll;
    btnSelectall.Caption := 'Select All'
  end;
end;

procedure TProductListExpressGUI.btnUpdateAvgcostClick(Sender: TObject);
begin
  inherited;
  IterateProcNo:= 1;
  IterateRecords(true);
end;
procedure TProductListExpressGUI.InitGroupFilterString;
begin
  InitGroupfilterString('Active' , ['T','F','']);
end;

procedure TProductListExpressGUI.inPanelcomponents( const ficmpProcess: TcmpProcessNo);
begin
  inherited;
  With grpExtraFilters       do begin
    if visible then begin
      if ficmpProcess = pn1 then begin iTotalHeaderComponentWidth := iTotalHeaderComponentWidth + Width; end;
      if ficmpProcess = pn2 then begin Left := iLeft; iLeft :=Left + Width + iGap; end;
      if ficmpProcess = pn3 then begin Top :=trunc(( pnlbuttons.height - Height)/2); end;
      if ficmpProcess = pn4 then begin if left < iLeft then Left :=iLeft+igap;iLeft:= left+width; end;
      if ficmpProcess = pn5 then begin iTotalHeaderComponentWidth := iTotalHeaderComponentWidth + Width; end;
      if ficmpProcess = pn6 then begin iTotalHeaderComponentWidth := iTotalHeaderComponentWidth + Width; end;
    end;
  end;

end;

procedure TProductListExpressGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer);
var
  Product :TProduct;
begin
  if IterateProcNo = 1 then begin
    Product := TProduct.CreateWithNewConn(Self);
    try
      Product.Load(Qrymainpartsid.AsInteger);
      Product.DoUpdateAvgCosts;
      Exit;
    finally
      Freeandnil(Product);
    end;
  end;
  inherited;
end;

function TProductListExpressGUI.DefaultAllClasses: Integer;
begin
  result := inherited DefaultAllClasses;
  if result <0 then
    if not Appenv.CompanyPrefs.ProductClassDefaultAll then result := 2 ;
end;

function TProductListExpressGUI.ExpressDetailListName: String;
begin
  Result:= 'TProductListGUI';
end;

procedure TProductListExpressGUI.DNMSpeedButton1Click(Sender: TObject);
var
  strSQL:String;
begin
  inherited;
  strSQL:=SelectedIDs('PartsID' );
  if strSQL = '' then strSQL := inttostr(QrymainpartsId.asinteger);
  if (strSQL = '') or (strSQL  ='0') then begin
    MessageDlgXP_Vista('Please Choose the Product to Print', mtWarning, [mbOK], 0);
    Exit;
  end;
  strSQL:= ProductPrintTreeSQL(strsql)+
          '~|||~{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, CO.PhoneNumber AS PhoneNumber, CO.FaxNumber AS FaxNumber, CO.ABN '+
          ' FROM tblCompanyInformation AS CO';
  ReportSQLSupplied := true;
  PrintTemplateReport('Product List(Tree)' , strSQL , False, 1);
end;

procedure TProductListExpressGUI.btnListWithDeptClick(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TProductListReorderGUI');
  Self.Close;
end;

procedure TProductListExpressGUI.btnqtyverClick(Sender: TObject);
var
  form :Tcomponent;
begin
  inherited;
  form := GetComponentByClassName('TfmProductQtys');
  if not assigned(form) then exit;
  TfmProductQtys(Form).PartsId := QrymainpartsId.AsInteger;
  TfmProductQtys(Form).formStyle := fsMDIChild;
  TfmProductQtys(Form).bringToFront;
end;

procedure TProductListExpressGUI.DNMSpeedButton2Click(Sender: TObject);
var
  strSQL:String;
begin
  inherited;
  strSQL:= '{CompanyInfo} SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode,' +
            ' Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN' +
            ' FROM tblCompanyInformation AS CO ~|||~{Details} ' + ManufactureSubProductSQL(QrymainpartsId.asInteger);
  ReportSQLSupplied := true;
  PrintTemplateReport('sub Product Tree' , strSQL , False, 1);
end;

procedure TProductListExpressGUI.DNMSpeedButton3Click(Sender: TObject);
var
  s:String;
begin
  inherited;
    s:= SelectedIDs('PartsID');
    if s = '' then exit;
    TProductMovementForm.showListforProducts(self, s);
end;
function TProductListExpressGUI.ExtraCompsforPanelWidths: Integer;
begin
  if grpExtraFilters.visible then
    REsult := grpExtraFilters.width
  else result := inherited ExtraCompsforPanelWidths;
end;

initialization
  RegisterClassOnce(TProductListExpressGUI);

finalization
  UnRegisterClass(TProductListExpressGUI);
end.


