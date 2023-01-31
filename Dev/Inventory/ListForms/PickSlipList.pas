{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
}
unit PickSlipList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, wwdblook,  kbmMemTable,
  Shader, DAScript, MyScript, CustomInputBox, wwcheckbox, wwclearbuttongroup,
  wwradiogroup, GIFImg;

type
  TPickSlipGUI = class(TBaseListingGUI)
    cboClassQry: TERPQuery;
    Panel4: TPanel;
    Label4: TLabel;
    cboClass: TwwDBLookupCombo;
    qrySales: TERPQuery;
    qryMainProductName: TWideStringField;
    qryMainThirdColumn: TWideStringField;
    qryMainSecondColumn: TWideStringField;
    qryMainFirstColumn: TWideStringField;
    qryMainSalesDescription: TWideStringField;
    qryMainSaleID: TIntegerField;
    qryMainSaleDate: TDateField;
    qryMainType: TWideStringField;
    qryMainShipping: TWideStringField;
    qryMainComments: TWideMemoField;
    qryMainPickPrintFlag: TWideStringField;
    qryMainArea: TWideStringField;
    qryMaincustomername: TWideStringField;
    qryMainShipdate: TDateTimeField;
    DNMSpeedButton1: TDNMSpeedButton;
    btnPrintpicking: TDNMSpeedButton;
    btnshipList: TDNMSpeedButton;
    qryMainInvoiceDocNumber: TWideStringField;
    qryMainStatus: TWideStringField;
    qryMainRequiresAssembly: TWideStringField;
    qryMainAssembled: TWideStringField;
    grpAssemblyfilter: TRadioGroup;
    btnAssembled: TDNMSpeedButton;
    qryMainSaleLineID: TIntegerField;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cmdNewClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    (*procedure PrintReport(const ReportName: string; const SaleID: integer);*)
    procedure cmdPrintClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure btnprintpickingClick(Sender: TObject);
    procedure btnshipListClick(Sender: TObject);
    procedure btnAssembledClick(Sender: TObject);
  private
  public
    { Public declarations }
  protected
    procedure RefreshQuery; override;
    procedure ReadnApplyGuiPrefExtra;override;
    Procedure WriteGuiPrefExtra; override;
    procedure SetGridColumns; override;
  end;

implementation

uses
  UnbalancedBinQty,
  frmPrintPickingSlips, CommonLib, Forms, AppEnvironment, CommonFormLib,
  DatasetExporter;

{$R *.dfm}
procedure TPickSlipGUI.RefreshQuery;
begin
  if QryMain.Active then QryMain.Close;
  if chkIgnoreDates.Checked then begin
    qryMain.Params.ParamByName('dtfrom').AsDate := 0;
    qryMain.Params.ParamByName('dtto').AsDate := MaxDateTime;
  end
  else begin
    qryMain.Params.ParamByName('dtfrom').AsDate := dtFrom.DateTime;
    qryMain.Params.ParamByName('dtto').AsDate := dtTo.DateTime;
  end;

  qrymain.Params.ParamByName('ClassID').AsString := cboClassQry.FieldByName('ClassID').AsString;
  inherited;
end;


procedure TPickSlipGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymainsalelineid.fieldname);
end;

procedure TPickSlipGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['grpAssemblyfilter.ItemIndex'].asInteger :=  grpAssemblyfilter.itemindex +1;
end;

procedure TPickSlipGUI.ReadnApplyGuiPrefExtra;
var
  x:Integer;
  oldIndex:Integer;
begin
  oldIndex:=grpFilters.itemindex ;
  x:= GuiPrefs.Node['Grpfilters.ItemIndex'].asInteger;
  if (x > 0) (*and (X<3)*) and (grpFilters.Items.count >= x) then
    grpFilters.itemindex := x-1
  else begin
    grpFilters.itemindex  := 0;
    if grpFilters.itemindex  <> oldIndex then grpFilters.itemindex  := oldIndex;
  end;

  oldIndex:=grpAssemblyfilter.itemindex ;
  if (oldIndex <0) or (oldIndex>=2) then  oldIndex:= 0;
  x:= GuiPrefs.Node['grpAssemblyfilter.ItemIndex'].asInteger;
  if (x > 0) and (X<2) and (grpAssemblyfilter.Items.count >= x) then
    grpAssemblyfilter.itemindex := x-1
  else begin
    grpAssemblyfilter.itemindex  := 0;
    if grpAssemblyfilter.itemindex  <> oldIndex then grpAssemblyfilter.itemindex  := oldIndex;
  end;
end;

procedure TPickSlipGUI.grpFiltersClick(Sender: TObject);
begin
  if (Self.classnameis('TPickSlipGUI')) and (Sender=grpAssemblyfilter) and (grpAssemblyfilter.ItemIndex  = 2) then begin
    OpenErpListform('TUnbalancedBinQtyGUI');
    Close;
    Exit;
  end;
  GroupFilterString:= '';
       if grpAssemblyfilter.ItemIndex =0 then GroupFilterString:= 'PickPrintFlag =' +quotedstr('F')
  else if grpAssemblyfilter.ItemIndex =1 then GroupFilterString:= 'PickPrintFlag =' +quotedstr('T');

  if (grpFilters.ItemIndex>=0 ) and (grpFilters.ItemIndex <4) then begin
    if   GroupFilterString <> '' then GroupFilterString := GroupFilterString +' and ';
         if grpFilters.ItemIndex =0 then GroupFilterString := GroupFilterString + ' RequiresAssembly =' + Quotedstr('T') + ' and Assembled = ' +quotedstr('T')
    else if grpFilters.ItemIndex =1 then GroupFilterString := GroupFilterString + ' RequiresAssembly =' + Quotedstr('T') + ' and Assembled = ' +quotedstr('F')
    else if grpFilters.ItemIndex =2 then GroupFilterString := GroupFilterString + ' RequiresAssembly =' + Quotedstr('T')
    else if grpFilters.ItemIndex =3 then GroupFilterString := GroupFilterString + ' RequiresAssembly =' + Quotedstr('F');
  end;
  inherited;
end;

procedure TPickSlipGUI.FormShow(Sender: TObject);
begin
  cboClassQry.Open;
  cboClassQry.Locate('ClassName', AppEnv.DefaultClass.DefaultClassName, [loCaseInsensitive]);
  cboClass.LookupValue := AppEnv.DefaultClass.DefaultClassName;
  qryMain.Close;
  inherited;
  if grpFilters.itemindex        <0 then grpFilters.itemindex       := 0;
  if grpAssemblyfilter.itemindex <0 then grpAssemblyfilter.itemindex:= 0;
  if grpAssemblyfilter.visible =false then HeaderPanel.height := HeaderPanel.height - grpAssemblyfilter.height;
end;

procedure TPickSlipGUI.FormCreate(Sender: TObject);
begin
  inherited;
  cboClassQry.Connection := qryMain.Connection;
end;

procedure TPickSlipGUI.btnAssembledClick(Sender: TObject);
var
  i, ctr:Integer;
begin
  inherited;
  ctr:= 0;
  if grdMain.SelectedList.Count = 0 then Exit;
  With Scriptmain do begin
    SQL.Clear;
    try
      for I := 0 to grdMain.SelectedList.Count - 1 do begin
        qryMain.GotoBookmark(grdMain.SelectedList.Items[i]);
        if not QrymainRequiresAssembly.AsBoolean then continue;
        if QrymainAssembled.AsBoolean then continue;
        if not Userlock.Lock('tblSales', QrymainSaleId.AsInteger, 'Assembling') then continue;
        SQL.Add('update tblsaleslines Set Assembled ="T" where saleLineId =' + inttostr(QrymainsalelineID.AsInteger)+';' );
        ctr:= ctr+1;
      end;
    finally
      if SQL.Count > 0 then begin
        Execute;
        Userlock.UnlockAllCurrentInstance;//UnlockAllCurrentUser //Binny -UnlockAllCurrentUser removes locking from other forms are well;
        RefreshQuery;
        MessageDlgXP_Vista(inttostr(ctr)+' Product(s) are flagged as assembled.', mtWarning, [mbOK], 0);
      end;
    end;
  end;
end;

procedure TPickSlipGUI.btnprintpickingClick(Sender: TObject);
var
  strSql: string;
  I: integer;
  PrintPickingSlips: TComponent;
begin
  (*if (AppEnv.CompanyPrefs.PickingSlipOrder = 2) or (AppEnv.CompanyPrefs.PickingSlipOrder = 3)
     or (AppEnv.CompanyPrefs.PickingSlipOrder = 4) then begin
     PrintReport('Picking Slip Group By Col1',qryMainSaleId.AsInteger);
     Exit;
  end;*)

  strSql:= '';
  if grdMain.SelectedList.Count = 0 then Exit;
  for I := 0 to grdMain.SelectedList.Count - 1 do begin
    qryMain.GotoBookmark(grdMain.SelectedList.Items[i]);
    if strSql <> '' then strSql := strSql + ' OR ';
    strSql := strSql + ' SalesId = ' + inttostr(qryMainSaleId.asInteger);
  end;

  if strSql = '' then Exit;

  PrintPickingSlips := GetComponentByClassName('TfmPrintPickingSlips');

  if Assigned(PrintPickingSlips) then begin
    TfmPrintPickingSlips(PrintPickingSlips).SalesIdsToProcess := strSql;
    TfmPrintPickingSlips(PrintPickingSlips).ShowModal;
  end;
end;

procedure TPickSlipGUI.btnshipListClick(Sender: TObject);
var
  s:String;
  DE:TERPQueryExporter;
begin
  inherited;
  if grdMain.SelectedList.Count = 0 then begin
    if MessageDlgXP_Vista('You haven''''t selected the sales to print ship list. Do you wish to print for all sales? ', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
    GrdMain.SelectAll;
  end;
  if grdMain.SelectedList.Count  = 0 then exit;
  s:= ' Select ' +
    ' concat(if(S.IsInvoice="T" , "INV",if(S.IsSalesOrder="T" , "SO" ,if(S.IsCashSale="T" , "CS" ,if(S.IsPOS="T" ,"POS" ,"")) )),S.InvoiceDocNumber) as "Sales No", ' +
    ' 1 as "1", ' +
    ' S.CustomerName "Ship To Name",'+
    ' if(ifnull(SA.ShipAddress   ,"")<> "" , SA.ShipAddress  ,C.Street   ) "Ship To Address1", ' +
    ' if(ifnull(SA.ShipAddress1  ,"")<> "" , SA.ShipAddress1 ,C.Street2  ) "Ship To Address2", ' +
    ' if(ifnull(SA.ShipAddress2  ,"")<> "" , SA.ShipAddress2 ,C.Street3  ) "Ship To Address3", ' +
    ' if(ifnull(SA.ShipCity      ,"")<> "" , SA.ShipCity     ,C.Suburb   ) "Ship To Town", ' +
    ' if(ifnull(SA.ShipPostcode  ,"")<> "" , SA.ShipPostcode ,C.Postcode ) "Ship To PostCode", ' +
    ' S.NoOfBoxes "Number of Labels Required", ' +
    ' if(sum(SL.LineCostInc*SL.Shipped)<100 ,2, 1) as "Servce Level" ,' +
    ' SA.phone "Ship To Telephone Number", ' +
    ' Left(ifnull(PickMemo,""), 25)  as "Shipping Notes-1", '+
    ' substring(ifnull(PickMemo,""), 26, 25) "Shipping Notes-2",'+
    ' S.ConNote "Delivery Service Level" ' +
    ' From tblSales S ' +
    ' inner join tblSaleslines SL on S.SaleID = SL.SaleID ' +
    ' inner join tblclients C on c.clientId  = s.ClientID ' +
    ' Left join tblshippingaddress SA on SA.ShipAddressID = S.ShipToID '+
    ' where S.SaleID in (' + SelectedIDs('SaleID' , true) +')'+
    ' group by S.SaleId';
  DE:= TERPQueryExporter.create(Self);
  try
    DE.connection := TERPConnection(Qrymain.Connection);
    DE.SQL:= s;
    DE.Defaultfilename :='Import.txt';
    DE.DefaultExtension := 'txt';
    s := DE.DoExport;
    if s<> '' then begin
      MessageDlgXP_Vista('Ship list for the selected sales records are exported to ' + chr(13) + Quotedstr(s)+ '.', mtInformation, [mbOK], 0);
      grdMain.UnselectAll;
    end;
  finally
    Freeandnil(DE);
  end;

end;

procedure TPickSlipGUI.cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  RefreshQuery;
end;

procedure TPickSlipGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  if not FormStillOpen('TfrmParts') then begin
    Form := GetComponentByClassName('TfrmParts');
    if Assigned(Form) then begin //if has acess
      with TForm(Form) do begin
        FormStyle := fsmdiChild;
        BringToFront;
      end;
    end;
  end else begin
    with TForm(FindExistingComponent('TfrmParts')) do begin
      Show;
      BringToFront;
    end;
  end;
end;

procedure TPickSlipGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMain.FieldByName('Type').AsString;
  inherited;
end;


(*procedure TPickSlipGUI.PrintReport(const ReportName: string; const SaleID: integer);
  { Stolen from TBaseSaleGUI perhaps we should move it to Base trans}
var
  sSQL: string;
begin
  sSQL := Format('AND d2.SaleID = %d', [SaleID]);

  if ReportName = 'Picking Slip' then begin
    if AppEnv.CompanyPrefs.PickingSlipOrder = 1 then begin // Bins
      sSQL := sSQL + ' Group By BinLocation,GroupLine,PickSlipLinesID ORDER BY BinLocation,BinNumber,GroupLine;';
      PrintTemplateReport(ReportName, sSQL, not AppEnv.Employee.ShowPreview, 1);
    end;
    if AppEnv.CompanyPrefs.PickingSlipOrder = 0 then begin // Product
      sSQL := sSQL + ' Group By SaleLineID,BinLocation,GroupLine,PickSlipLinesID ORDER BY SaleLineID,GroupLine;';
      PrintTemplateReport(ReportName, sSQL, not AppEnv.Employee.ShowPreview, 1);
    end;
  end;

  if AppEnv.CompanyPrefs.PickingSlipOrder = 2 then begin // Col 1
    sSQL := ' WHERE S.SaleID = ' + qryMainSaleID.AsString;
    sSQL := sSQL + ' ORDER BY PartLevel1,Product_Description';
    PrintTemplateReport('Picking Slip Group By Col1', sSQL, not AppEnv.Employee.ShowPreview, 1);
  end;
  if AppEnv.CompanyPrefs.PickingSlipOrder = 3 then begin // Col 2
    sSQL := ' WHERE S.SaleID = ' + qryMainSaleID.AsString;
    sSQL := sSQL + ' ORDER BY PartLevel2,Product_Description';
    PrintTemplateReport('Picking Slip Group By Col2', sSQL, not AppEnv.Employee.ShowPreview, 1);
  end;
  if AppEnv.CompanyPrefs.PickingSlipOrder = 4 then begin // Col 3
    sSQL := ' WHERE S.SaleID = ' + qryMainSaleID.AsString;
    sSQL := sSQL + ' ORDER BY PartLevel3,Product_Description';
    PrintTemplateReport('Picking Slip Group By Col3', sSQL, not AppEnv.Employee.ShowPreview, 1);
  end;

end;*)
procedure TPickSlipGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TPickSlipGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  grdmain.SelectAll;
end;

initialization
  RegisterClassOnce(TPickSlipGUI);
end.

