unit frmManifest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB,   StdCtrls,
  wwclearbuttongroup, wwradiogroup, wwdbdatetimepicker, Buttons, DNMSpeedButton, Mask,
  DBCtrls, wwdblook, ExtCtrls, DNMPanel, Wwdbigrd, Grids, Wwdbgrid,
  wwcheckbox, kbmMemTable, {Psock,} ComCtrls,AdvOfficeStatusBar, DBAccess, MyAccess,ERPdbComponents,
  wwdbedit, Wwdotdot, Wwdbcomb, DataState, Menus, AdvMenus, MemDS, Shader,
  ImgList, BusObjManifest, busobjbase, ProgressDialog;

type
  TManifestGUI = class(TBaseInputGUI)
    tblMaster: TERPQuery;
    DSMaster: TDataSource;
    DSDetails: TDataSource;
    tblDetails: TERPQuery;
    pnlFooter: TDNMPanel;
    Label1: TLabel;
    txtComments: TDBMemo;
    pnlHeader: TDNMPanel;
    Label38: TLabel;
    Label160: TLabel;
    Label3: TLabel;
    txtCustomID: TDBEdit;
    btnNext: TDNMSpeedButton;
    btnCompleted: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    btnPreview: TDNMSpeedButton;
    btnPrint: TDNMSpeedButton;
    cboShipDate: TwwDBDateTimePicker;
    Label2: TLabel;
    Trailer: TwwRadioGroup;
    Label31: TLabel;
    Phone: TDBEdit;
    pnlDetail: TDNMPanel;
    grdTransactions: TwwDBGrid;
    btnDelete: TwwIButton;
    Bevel2: TBevel;
    Label6: TLabel;
    cboVehicle: TwwDBLookupCombo;
    Driver: TDBEdit;
    qryVehicles: TERPQuery;
    qryVehiclesVehicleID: TAutoIncField;
    qryVehiclesVehicleName: TWideStringField;
    qryVehiclesOwnerName: TWideStringField;
    qryVehiclesDriver: TWideStringField;
    qryVehiclesPhone: TWideStringField;
    qryVehiclesRegistrationNo: TWideStringField;
    qryVehiclesTrailer: TWideStringField;
    qryVehiclesNotes: TWideMemoField;
    qryVehiclesPercentageRate: TFloatField;
    DSVehicles: TDataSource;
    tblMasterManifestID: TAutoIncField;
    tblMasterDespatchDate: TDateField;
    tblMasterOwnerName: TWideStringField;
    tblMasterDriver: TWideStringField;
    tblMasterPhone: TWideStringField;
    tblMasterNotes: TWideMemoField;
    tblMasterVehicleID: TIntegerField;
    tblMasterTrailer: TWideStringField;
    tblMasterFromCity: TWideStringField;
    tblMasterFromPostcode: TWideStringField;
    tblMasterToCity: TWideStringField;
    tblMasterToPostcode: TWideStringField;
    tblMasterFromState: TWideStringField;
    tblMasterToState: TWideStringField;
    tblMasterCompleted: TWideStringField;
    tblMasterFinalETA: TDateField;
    tblMasterManifestRouteID: TIntegerField;
    tblMasterDistance: TIntegerField;
    tblMasterGlobalRef: TWideStringField;
    tblMasterEditedFlag: TWideStringField;
    tblMasterVehicleName: TWideStringField;
    tblMasterBillID: TIntegerField;
    tblMasterEmployeeId: TIntegerField;
    tblDetailsManifestLineID: TAutoIncField;
    tblDetailsManifestID: TIntegerField;
    tblDetailsETA: TDateField;
    tblDetailsPageNo: TIntegerField;
    tblDetailsGlobalRef: TWideStringField;
    tblDetailsEditedFlag: TWideStringField;
    tblDetailsPickupFrom: TWideStringField;
    tblDetailsShipTo: TWideStringField;
    tblDetailsProductName: TWideStringField;
    tblDetailsProduct_Description: TWideStringField;
    tblDetailsUnitOfMeasure: TWideStringField;
    tblDetailsQty: TFloatField;
    tblDetailsValue: TFloatField;
    tblDetailsAttrib1sale: TFloatField;
    tblDetailsAttrib2sale: TFloatField;
    tblDetailsAttrib1saleRate: TFloatField;
    tblDetailsmsTimeStamp: TDateTimeField;
    tblDetailsmsUpdateSiteCode: TWideStringField;
    tblDetailsDeleted: TWideStringField;
    cboETA: TwwDBDateTimePicker;
    pnlChooseRpt: TDNMPanel;
    lblChooseRpt: TLabel;
    chkChooseRpt: TCheckBox;
    chkCompleted: TwwCheckBox;
    Label4: TLabel;
    Bevel1: TBevel;
    Label5: TLabel;
    wwDBDateTimePicker1: TwwDBDateTimePicker;
    cboRoute: TwwDBLookupCombo;
    Label7: TLabel;
    qryRoutes: TERPQuery;
    DBEdit1: TDBEdit;
    Label8: TLabel;
    Bevel3: TBevel;
    qryOwners: TERPQuery;
    dsOwners: TDataSource;
    cboOwnerName: TwwDBLookupCombo;
    cmdEmail: TDNMSpeedButton;
    cmdFax: TDNMSpeedButton;
    btnCreateBill: TDNMSpeedButton;
    lblBill: TLabel;
    qryOwnersCompany: TWideStringField;
    qryOwnersSupplierID: TIntegerField;
    cboEmployee: TwwDBLookupCombo;
    qryEmployees: TERPQuery;
    QrySalesLookup: TERPQuery;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    QrySalesLookupGlobalRef: TWideStringField;
    QrySalesLookupManifestLineID: TIntegerField;
    QrySalesLookupManifestID: TIntegerField;
    QrySalesLookupETA: TDateField;
    QrySalesLookupPageNo: TIntegerField;
    QrySalesLookupPickupFrom: TWideStringField;
    QrySalesLookupShipTo: TWideStringField;
    QrySalesLookupInvoiceNumber: TWideStringField;
    QrySalesLookupProductName: TWideStringField;
    QrySalesLookupProduct_Description: TWideStringField;
    QrySalesLookupUnitOfMeasure: TWideStringField;
    QrySalesLookupQty: TFloatField;
    QrySalesLookupValue: TFloatField;
    QrySalesLookupAttrib1Sale: TFloatField;
    QrySalesLookupAttrib2Sale: TFloatField;
    QrySalesLookupAttrib1SaleRate: TFloatField;
    QrySalesLookupSaleID: TIntegerField;
    QrySalesLookupSaleLineID: TIntegerField;
    QrySalesLookupEditedFlag: TWideStringField;
    tblDetailsInvPickupFrom: TWideStringField;
    tblDetailsInvShipTo: TWideStringField;
    tblDetailsInvProductName: TWideStringField;
    tblDetailsInvUnitOfMeasure: TWideStringField;
    tblDetailsInvQty: TFloatField;
    tblDetailsInvValue: TFloatField;
    tblDetailsInvProduct_Description: TWideStringField;
    tblDetailsInvAttrib1sale: TFloatField;
    tblDetailsInvAttrib2sale: TFloatField;
    tblDetailsInvAttrib1saleRate: TFloatField;
    QryInvLookup: TERPQuery;
    QryInvLookupGlobalRef: TWideStringField;
    QryInvLookupManifestLineID: TIntegerField;
    QryInvLookupManifestID: TIntegerField;
    QryInvLookupETA: TDateField;
    QryInvLookupPageNo: TIntegerField;
    QryInvLookupPickupFrom: TWideStringField;
    QryInvLookupShipTo: TWideStringField;
    QryInvLookupInvoiceNumber: TWideStringField;
    QryInvLookupProductName: TWideStringField;
    QryInvLookupProduct_Description: TWideStringField;
    QryInvLookupUnitOfMeasure: TWideStringField;
    QryInvLookupQty: TFloatField;
    QryInvLookupValue: TFloatField;
    QryInvLookupAttrib1Sale: TFloatField;
    QryInvLookupAttrib2Sale: TFloatField;
    QryInvLookupAttrib1SaleRate: TFloatField;
    QryInvLookupSaleID: TIntegerField;
    QryInvLookupSaleLineID: TIntegerField;
    QryInvLookupEditedFlag: TWideStringField;
    tblDetailsSOID: TIntegerField;
    tblDetailsInvoiceID: TIntegerField;
    QrySalesLookupPreferedSupplier: TWideStringField;
    tblDetailsPreferedSupplier: TStringField;
    rbSummary: TRadioButton;
    rbDetails: TRadioButton;
    tblDetailsSaleLineId: TIntegerField;
    tblDetailsInvoiceLineId: TIntegerField;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure cboOwnerNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure qryVehiclesBeforeOpen(DataSet: TDataSet);
    procedure tblDetailsAfterPost(DataSet: TDataSet);
    procedure btnPreviewClick(Sender: TObject);
    procedure QrySalesLookupBeforeOpen(DataSet: TDataSet);
    procedure QryInvLookupBeforeOpen(DataSet: TDataSet);
    procedure tblDetailsBeforeOpen(DataSet: TDataSet);
    procedure grdTransactionsCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdTransactionsCalcTitleAttributes(Sender: TObject; AFieldName: string; AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
    procedure rbDetailsClick(Sender: TObject);
    procedure rbSummaryClick(Sender: TObject);
  private
    ManifestObj :TManifest;
    DeleteSaleID: integer;
    procedure UpdateFooter;
    function SaveRecord: Boolean;
    Procedure DeleteSalesfromManifest(const Sender: TBusObj; var Abort: Boolean);


  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    function GetReportTypeID: integer; override;
    procedure LoadTemplate(const bPrint, bSave: boolean; const DoClose: boolean = true; const FileName: string = ''); Override;
    procedure BuildMainQuery;
  public
    { Public declarations }
    iTotalPalettes, iTotalAttrib1: integer;
    fbBillChecked: boolean;
    

  end;

implementation

uses
  FormFactory,  AuditObj, CommonDbLib, DateUtils, DNMLib, DNMExceptions,

  MAIN, CommonLib, AppEnvironment, FastFuncs, tcConst , BusObjConst, BusObjSales;

{$R *.dfm}

{ TfrmManifestGUI }

procedure TManifestGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TManifestGUI.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TManifestGUI.FormCreate(Sender: TObject);
begin
  AllowCustomiseGrid:= True;
  DeleteSaleID:=0;
  Processingcursor(True);
  try
    inherited;
    ManifestObj := TManifest.CreateWithNewConn(Self);
    ManifestObj.Connection.connection := Self.MyConnection;
    ManifestObj.BusObjEvent := DoBusinessObjectEvent;
    tblDetailsPreferedSupplier.DisplayLabel := 'Preferred Supplier';

  finally
    Processingcursor(False);
  end;
end;

procedure TManifestGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
      inherited;

      ManifestObj.load(KeyID);
      ManifestObj.connection.begintransaction;
      if ManifestObj.count =0 then begin
        ManifestObj.New;
        ManifestObj.DespatchDate:= now;
        ManifestObj.PostDB;
      end;
      ManifestObj.Lines;
      if ManifestObj.Lock =False then Accesslevel := 5;
      OpenQueries;
      if not AppEnv.CompanyPrefs.ShowMeasurementAttributes then begin
        with grdTransactions do begin
          RemoveField('Attrib1Sale');
          RemoveField('Attrib2Sale');
          RemoveField('Attrib1SaleRate');
          btnCreateBill.Enabled := false;
        end;
      end else begin
        grdTransactions.ColumnByName('Attrib1Sale').DisplayLabel := AppEnv.CompanyPrefs.ProductAttrib1Name;
        grdTransactions.ColumnByName('Attrib2Sale').DisplayLabel := AppEnv.CompanyPrefs.ProductAttrib2Name;
        grdTransactions.ColumnByName('Attrib1SaleRate').DisplayLabel := 'Price / ' + AppEnv.CompanyPrefs.ProductAttrib1Name;
      end;
      GuiPrefs.Active := True;
      guiprefs.DbGridElement[grdTransactions].RemoveFields(tblDetailsDeleted.FieldName +',' +
                                                            tblDetailsmsTimeStamp.FieldName +',' +
                                                            tblDetailsmsUpdateSiteCode.FieldName +',' +
                                                            tblDetailsGlobalRef.FieldName +',' +
                                                            tblDetailsEditedFlag.FieldName +',' +
                                                            tblDetailsManifestLineID.FieldName +',' +
                                                            tblDetailsManifestID.FieldName +',' +
                                                            tblDetailsSaleLineID.FieldName +',' +
                                                            tblDetailsInvoiceLineID.FieldName);
      lblBill.Visible := ManifestObj.BillID<>0;
      grdTransactions.SetActiveField('Product');
      SetControlFocus(cboOwnerName);
  finally
    EnableForm;
  end;
end;

procedure TManifestGUI.btnCompletedClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  ManifestObj.dirty := false;
  ManifestObj.connection.CommitTransaction;
  Self.Close;
end;

function TManifestGUI.SaveRecord: Boolean;
begin
  result := false;
  if not ManifestObj.validatedata then exit;
  if not ManifestObj.save then exit;
  result := True;
end;


procedure TManifestGUI.tblDetailsAfterPost(DataSet: TDataSet);
begin
  inherited;
  UpdateFooter;
end;

procedure TManifestGUI.tblDetailsBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  opendb(qrySalesLookup);
  opendb(QryInvLookup);
end;

procedure TManifestGUI.btnNextClick(Sender: TObject);
begin
  if not SaveRecord then exit;
  ManifestObj.dirty := false;
  ManifestObj.connection.CommitTransaction;
  KeyId := 0;
  formShow(Self);
end;


procedure TManifestGUI.LoadTemplate(const bPrint, bSave: boolean; const DoClose: boolean = true; const FileName: string = '');
var
  sSQL :String;
begin
  sSQL := ' Where M.ManifestID=' + inttostr(ManifestObj.id);
  if chkChooseRpt.Checked then begin
    LoadReportTypes;
    if dlgReportSelect.Execute then begin
      ReportToPrint := dlgReportSelect.SelectedItems.Text;
      inherited;
      if SameText(ReportToPrint, 'Manifest Supplier') then
        sSQL := sSQL + ' Order by Supplier, Productname , PageNo'
      else if SameText(ReportToPrint, 'Manifest Address') then
        sSQL := sSQL + ' Order by ShipToAddress, Productname , PageNo'
      else
        sSQL := sSQL + ' Order By PageNo;';
    end;
  end else begin
    inherited;
    sSQL := sSQL + ' Order By PageNo;';
  end;
//  sSQL := ' Where M.ManifestID=' + inttostr(ManifestObj.id) + ' Order By PageNo;';

  PrintTemplateReport(ReportToPrint, sSQL, bPrint, 1);
  if DoClose then Self.Close;
  ReportToPrint := '';
end;

procedure TManifestGUI.QryInvLookupBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  QryInvLookup.ParamByName('ID').asInteger := ManifestObj.Id;
end;

procedure TManifestGUI.QrySalesLookupBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qrySalesLookup.ParamByName('ID').asInteger := ManifestObj.Id;
end;

function TManifestGUI.GetReportTypeID: integer;
begin
  Result := 39;
end;

procedure TManifestGUI.grdTransactionsCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if sametext(field.FieldName , tbldetailseta.FieldName) or sametext(field.FieldName , tbldetailspageno.FieldName) then
  else Afont.Color := clGray;
end;

procedure TManifestGUI.grdTransactionsCalcTitleAttributes(Sender: TObject; AFieldName: string; AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
begin
  inherited;
  if sametext(AFieldName , tbldetailseta.FieldName) or sametext(AFieldName , tbldetailspageno.FieldName) then
  else Afont.Color := clGray;
end;

procedure TManifestGUI.btnPreviewClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  ManifestObj.dirty := false;
  ManifestObj.connection.CommitTransaction;
  LoadTemplate(FAlse, False);
end;

procedure TManifestGUI.btnPrintClick(Sender: TObject);
begin
  if not SaveRecord then exit;
  ManifestObj.dirty := false;
  ManifestObj.connection.CommitTransaction;
  LoadTemplate(True, False);
end;

procedure TManifestGUI.BuildMainQuery;
begin
  tblDetails.Close;
  tblDetails.SQL.Clear;
  qrySalesLookup.Close;
  qryInvLookup.Close;
  if rbDetails.Checked then
  begin
  (*
    tblDetails.SQL.Add('SELECT');
    tblDetails.SQL.Add('*');
    tblDetails.SQL.Add('FROM');
    tblDetails.SQL.Add('tblmanifestlines ML');
    tblDetails.SQL.Add('Where ML.ManifestID= :ID');
  *)
    tblDetails.SQL.Add('select ML.GlobalRef,  ML.ManifestLineId,' ); // 0 as ManifestLineId,
    tblDetails.SQL.Add('ML.ManifestId, ML.SaleLineId, ML.InvoiceLineId, ML.ETA, ML.PageNo, ML.EditedFlag,');
    tblDetails.SQL.Add('ML.msTimeStamp, ML.Deleted, ML.msUpdateSiteCode');
    tblDetails.SQL.Add('from tblManifestLines ML');
    tblDetails.SQL.Add('Where ML.ManifestID= :ID');

    qryInvLookup.SQL.Text := 'SELECT';
    qryInvLookup.SQL.Add('tblmanifestlines.GlobalRef,');
    qryInvLookup.SQL.Add('ManifestLineID,');
    qryInvLookup.SQL.Add('ManifestID,');
    qryInvLookup.SQL.Add('ETA,');
    qryInvLookup.SQL.Add('PageNo,');
    qryInvLookup.SQL.Add('PickupFrom,');
    qryInvLookup.SQL.Add('ShipTo,');
    qryInvLookup.SQL.Add('InvoiceDocNumber as InvoiceNumber,');
    qryInvLookup.SQL.Add('ProductName,');
    qryInvLookup.SQL.Add('Product_Description,');
    qryInvLookup.SQL.Add('UnitofMeasureSaleLines as UnitOfMeasure,');
    qryInvLookup.SQL.Add('UnitofMeasureShipped as Qty,');
    qryInvLookup.SQL.Add('TotalLineAmountInc as Value,');
    qryInvLookup.SQL.Add('tblsaleslines.Attrib1Sale,');
    qryInvLookup.SQL.Add('tblsaleslines.Attrib2Sale,');
    qryInvLookup.SQL.Add('tblsaleslines.Attrib1SaleRate,');
    qryInvLookup.SQL.Add('tblsales.SaleID,');
    qryInvLookup.SQL.Add('tblsaleslines.SaleLineID,');
    qryInvLookup.SQL.Add('tblmanifestlines.EditedFlag');
    qryInvLookup.SQL.Add('FROM tblmanifestlines');
    qryInvLookup.SQL.Add('INNER JOIN tblsaleslines  on tblsaleslines.saleLineId = tblmanifestlines.InvoiceLineID');
    qryInvLookup.SQL.Add('INNER JOIN tblsales Using(SaleID)');
    qryInvLookup.SQL.Add('Where ManifestID= :ID');
    qryInvLookup.SQL.Add('ORDER BY tblsales.SaleID, tblsaleslines.SortID');

    qrySalesLookup.SQL.Text := 'SELECT';
    qrySalesLookup.SQL.Add('tblmanifestlines.GlobalRef,');
    qrySalesLookup.SQL.Add('ManifestLineID,');
    qrySalesLookup.SQL.Add('ManifestID,');
    qrySalesLookup.SQL.Add('ETA,');
    qrySalesLookup.SQL.Add('PageNo,');
    qrySalesLookup.SQL.Add('PickupFrom,');
    qrySalesLookup.SQL.Add('ShipTo,');
    qrySalesLookup.SQL.Add('InvoiceDocNumber as InvoiceNumber,');
    qrySalesLookup.SQL.Add('ProductName,');
    qrySalesLookup.SQL.Add('tblparts.PREFEREDSUPP as PreferedSupplier,');
    qrySalesLookup.SQL.Add('Product_Description,');
    qrySalesLookup.SQL.Add('UnitofMeasureSaleLines as UnitOfMeasure,');
    qrySalesLookup.SQL.Add('UnitofMeasureShipped as Qty,');
    qrySalesLookup.SQL.Add('TotalLineAmountInc as Value,');
    qrySalesLookup.SQL.Add('tblsaleslines.Attrib1Sale,');
    qrySalesLookup.SQL.Add('tblsaleslines.Attrib2Sale,');
    qrySalesLookup.SQL.Add('tblsaleslines.Attrib1SaleRate,');
    qrySalesLookup.SQL.Add('tblsales.SaleID,');
    qrySalesLookup.SQL.Add('tblsaleslines.SaleLineID,');
    qrySalesLookup.SQL.Add('tblmanifestlines.EditedFlag');
    qrySalesLookup.SQL.Add('FROM tblmanifestlines');
    qrySalesLookup.SQL.Add('INNER JOIN tblsaleslines Using(SaleLineID)');
    qrySalesLookup.SQL.Add('INNER JOIN tblsales Using(SaleID)');
    qrySalesLookup.SQL.Add('inner join tblparts on tblsaleslines.ProductID = tblparts.PARTSID');
    qrySalesLookup.SQL.Add('Where ManifestID = :ID');
    qrySalesLookup.SQL.Add('ORDER BY tblsales.SaleID, tblsaleslines.SortID');


  end
  else
  begin
    tblDetails.SQL.Add('select null as GlobalRef,  ML.ManifestLineId,' ); // 0 as ManifestLineId,
    tblDetails.SQL.Add('ML.ManifestId, ML.SaleLineId, ML.InvoiceLineId, ML.ETA, ML.PageNo, ML.EditedFlag,');
    tblDetails.SQL.Add('max(ML.msTimeStamp) as msTimeStamp, ML.Deleted, ML.msUpdateSiteCode');
    tblDetails.SQL.Add('from tblManifestLines ML');
    tblDetails.SQL.Add('Where ML.ManifestID= :ID');
    tblDetails.SQL.Add('group by ML.SOID, ML.InvoiceId');

    qryInvLookup.SQL.Text := 'SELECT';
    qryInvLookup.SQL.Add('tblmanifestlines.GlobalRef,');
    qryInvLookup.SQL.Add('ManifestLineID,');
    qryInvLookup.SQL.Add('ManifestID,');
    qryInvLookup.SQL.Add('ETA,');
    qryInvLookup.SQL.Add('PageNo,');
    qryInvLookup.SQL.Add('PickupFrom,');
    qryInvLookup.SQL.Add('ShipTo,');
    qryInvLookup.SQL.Add('InvoiceDocNumber as InvoiceNumber,');
    qryInvLookup.SQL.Add('null as ProductName,');
    qryInvLookup.SQL.Add('null as Product_Description,');
    qryInvLookup.SQL.Add('null as UnitOfMeasure,');
    qryInvLookup.SQL.Add('sum(UnitofMeasureShipped) as Qty,');
    qryInvLookup.SQL.Add('Sum(TotalLineAmountInc) as Value,');
    qryInvLookup.SQL.Add('tblsaleslines.Attrib1Sale,');
    qryInvLookup.SQL.Add('tblsaleslines.Attrib2Sale,');
    qryInvLookup.SQL.Add('tblsaleslines.Attrib1SaleRate,');
    qryInvLookup.SQL.Add('tblsales.SaleID,');
    qryInvLookup.SQL.Add('tblsaleslines.SaleLineID,');
    qryInvLookup.SQL.Add('tblmanifestlines.EditedFlag');
    qryInvLookup.SQL.Add('FROM tblmanifestlines');
    qryInvLookup.SQL.Add('INNER JOIN tblsaleslines  on tblsaleslines.saleLineId = tblmanifestlines.InvoiceLineID');
    qryInvLookup.SQL.Add('INNER JOIN tblsales Using(SaleID)');
    qryInvLookup.SQL.Add('Where ManifestID=:ID');
    qryInvLookup.SQL.Add('group by InvoiceNumber');
    qryInvLookup.SQL.Add('ORDER BY tblsales.SaleID, tblsaleslines.SortID');


    qrySalesLookup.SQL.Text :=  'SELECT';
    qrySalesLookup.SQL.Add('tblmanifestlines.GlobalRef,');
    qrySalesLookup.SQL.Add('ManifestLineID,');
    qrySalesLookup.SQL.Add('ManifestID,');
    qrySalesLookup.SQL.Add('ETA,');
    qrySalesLookup.SQL.Add('PageNo,');
    qrySalesLookup.SQL.Add('PickupFrom,');
    qrySalesLookup.SQL.Add('ShipTo,');
    qrySalesLookup.SQL.Add('InvoiceDocNumber as InvoiceNumber,');
    qrySalesLookup.SQL.Add('ProductName,');
    qrySalesLookup.SQL.Add('tblparts.PREFEREDSUPP as PreferedSupplier,');
    qrySalesLookup.SQL.Add('null as Product_Description,');
    qrySalesLookup.SQL.Add('null as UnitOfMeasure,');
    qrySalesLookup.SQL.Add('sum(UnitofMeasureShipped) as Qty,');
    qrySalesLookup.SQL.Add('sum(TotalLineAmountInc) as Value,');
    qrySalesLookup.SQL.Add('tblsaleslines.Attrib1Sale,');
    qrySalesLookup.SQL.Add('tblsaleslines.Attrib2Sale,');
    qrySalesLookup.SQL.Add('tblsaleslines.Attrib1SaleRate,');
    qrySalesLookup.SQL.Add('tblsales.SaleID,');
    qrySalesLookup.SQL.Add('tblsaleslines.SaleLineID,');
    qrySalesLookup.SQL.Add('tblmanifestlines.EditedFlag');
    qrySalesLookup.SQL.Add('FROM tblmanifestlines');
    qrySalesLookup.SQL.Add('INNER JOIN tblsaleslines Using(SaleLineID)');
    qrySalesLookup.SQL.Add('INNER JOIN tblsales Using(SaleID)');
    qrySalesLookup.SQL.Add('inner join tblparts on tblsaleslines.ProductID = tblparts.PARTSID');
    qrySalesLookup.SQL.Add('Where ManifestID = :ID');
    qrySalesLookup.SQL.Add('group by SaleId');
    qrySalesLookup.SQL.Add('ORDER BY tblsales.SaleID, tblsaleslines.SortID');


  end;
  qrySalesLookup.ParamByName('ID').asInteger := ManifestObj.Id;
  qryInvLookup.ParamByName('ID').asInteger := ManifestObj.Id;
  tblDetails.ParamByName('ID').asInteger := ManifestObj.Id;
  tblDetails.Open;
//  qrySalesLookup.Open;
//  qryInvLookup.Open;
end;

procedure TManifestGUI.DeleteSalesfromManifest(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TManifestLines) then exit;
  if TManifestLines(Sender).SaleID = DeleteSaleID then begin
     TManifestLines(Sender).Deleted := True;
     TManifestLines(Sender).PostDB;
  end;
end;

procedure TManifestGUI.btnDeleteClick(Sender: TObject);
var
  s:String;
  IsFiltered: boolean;
  function SalesObj:TSales;
  begin
    with ManifestObj.GetNewDataSet('Select SaleId, issalesorder from tblsales where saleId = ' + inttostr(DeleteSaleID) , true) do try
      if fieldbyname('issalesorder').AsBoolean then result := TSalesorder.Create(Self)
      else result := TInvoice.Create(Self);
    finally
      if active then close;
      Free;
    end;
  end;
begin
  if accesslevel <> 1 then exit;
      DeleteSaleID := ManifestObj.Lines.SaleID;
      if DeleteSaleID =0 then exit;
      if not ManifestObj.userlock.Lock('tblsales' , DeleteSaleID) then begin
          s:=ManifestObj.UserLock.LockMessage;
          s:= replaceStr(s , 'Unable to update data.' , 'Unable to delete Invoice # ' + inttostr(DeleteSaleID) + ' from Manifest.');
          MessageDlgXP_Vista(s, mtWarning, [mbOK], 0);
          Exit;
      end;
      try
        IsFiltered := ManifestObj.Lines.Dataset.Filtered;
        ManifestObj.Lines.Dataset.Filtered := false;
        try
          With salesobj do try
            if CommonLib.MessageDlgXP_Vista('Are You Sure You Want to Delete ' +XMLNodename +' # ' + inttostr(DeleteSaleID) + ' From Manifest ?',    mtConfirmation, [mbyes, mbno], 0) = mrno then Exit;
            ManifestObj.Lines.Iteraterecords(DeleteSalesfromManifest);
            Connection := ManifestObj.Connection;
            Load( DeleteSaleID);
            if count=1 then begin
              UsedOnManifest := False;
              PostDB;
            end;
          finally
            Free;
          end;
        finally
          ManifestObj.Lines.Dataset.Filtered :=IsFiltered;
          ManifestObj.Lines.RefreshDB;
        end;
      finally
        DeleteSaleID:= 0;
      end;

end;

procedure TManifestGUI.UpdateFooter;
var
  s:String;
begin
  s:= 'SELECT ' +
      ' Sum(tblsaleslines.Attrib1Sale) AS TotalAttrib1, ' +
      ' Sum(tblsaleslines.Attrib2Sale) AS TotalAttrib2, ' +
      ' Sum(tblsaleslines.Attrib1SaleRate) as TotalAttrib1Rate ' +
      ' FROM tblmanifestlines ' +
      ' INNER JOIN tblsaleslines Using(SaleLineID) ' +
      ' where ManifestID = ' + inttostr(ManifestObj.ID);
  with ManifestObj.getnewdataset(s, true) do try
    grdTransactions.ColumnByName('Attrib2Sale').FooterValue     := FloatToStrF(fieldByname('TotalAttrib2').asfloat, ffGeneral, 15, CurrencyRoundPlaces);
    grdTransactions.ColumnByName('Attrib1Sale').FooterValue     := FloatToStrF(fieldByname('TotalAttrib1').asfloat, ffGeneral, 15, CurrencyRoundPlaces);
    grdTransactions.ColumnByName('Attrib1SaleRate').FooterValue := FloatToStrF(fieldByname('TotalAttrib1Rate').asfloat,  ffCurrency, 15, CurrencyRoundPlaces);
  finally
    if Active then close;
    Free;
  end;

end;


procedure TManifestGUI.cboOwnerNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  Closedb(qryVehicles);
  openDb(qryVehicles);
end;

procedure TManifestGUI.qryVehiclesBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryVehicles.ParamByName('xOwner').asString := cboOwnerName.Text;
end;

procedure TManifestGUI.rbDetailsClick(Sender: TObject);
begin
  rbSummary.Checked := not rbDetails.Checked;
  BuildMainQuery;
end;

procedure TManifestGUI.rbSummaryClick(Sender: TObject);
begin
  inherited;
  rbDetails.Checked := not rbSummary.Checked;
  BuildMainQuery;
end;

procedure TManifestGUI.DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);
begin
     inherited ;
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TManifest then TManifest(Sender).Dataset  := tblMaster
        else if Sender is TManifestlines then TManifestlines(Sender).Dataset  := tblDetails;
     end;
end;

initialization
  RegisterClassOnce(TManifestGUI);
  with FormFact do begin
    RegisterMe(TManifestGUI, 'TManifestListGUI_*=ManifestID');
  end;
end.
