unit frmBarcodePickingEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, StdCtrls, Buttons, DNMSpeedButton, ExtCtrls, DNMPanel,
  SelectionDialog, AppEvnts, DB,   Wwdbigrd, Grids, Wwdbgrid,
  Mask, DBCtrls, wwdblook, wwcheckbox, wwdbdatetimepicker, DBAccess,
  MyAccess,ERPdbComponents, DataState, MemDS, Menus, AdvMenus, Shader, ImgList, ProgressDialog;

type
  TBarcodePickingEditGUI = class(TBaseInputGUI)
    tblDetails: TERPQuery;
    tblMaster: TERPQuery;
    DSMaster: TDataSource;
    DSDetails: TDataSource;
    pnlDetail: TDNMPanel;
    grdTransactions: TwwDBGrid;
    btnDelete: TwwIButton;
    tblMasterPickingAssemblyID: TAutoIncField;
    tblMasterSaleID: TIntegerField;
    tblMasterBarcode: TWideStringField;
    tblMasterPickingEmployeeID: TIntegerField;
    tblMasterStartPicking: TWideStringField;
    tblMasterStartPickingTime: TDateTimeField;
    tblMasterFinishedPicking: TWideStringField;
    tblMasterFinishedPickingTime: TDateTimeField;
    tblMasterPackingEmployeeID: TIntegerField;
    tblMasterStartPacking: TWideStringField;
    tblMasterStartPackingTime: TDateTimeField;
    tblMasterFinishedPacking: TWideStringField;
    tblMasterFinishedPackingTime: TDateTimeField;
    tblDetailsPickingAssemblylinesID: TAutoIncField;
    tblDetailsPickingAssemblyID: TIntegerField;
    tblDetailsProductID: TIntegerField;
    tblDetailsProductName: TWideStringField;
    tblDetailsPackNumber: TIntegerField;
    Label1: TLabel;
    PickingAssemblyID: TDBEdit;
    Label2: TLabel;
    Barcode: TDBEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    StartPickingTime: TwwDBDateTimePicker;
    FinishedPickingTime: TwwDBDateTimePicker;
    FinishedPackingTime: TwwDBDateTimePicker;
    StartPackingTime: TwwDBDateTimePicker;
    StartPicking: TwwCheckBox;
    FinishedPicking: TwwCheckBox;
    StartPacking: TwwCheckBox;
    FinishedPacking: TwwCheckBox;
    PickingEmployeeID: TwwDBLookupCombo;
    PackingEmployeeID: TwwDBLookupCombo;
    cboEmployeeLookup: TERPQuery;
    DSEmployeeLookup: TDataSource;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel1: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    DNMPanel2: TDNMPanel;
    cmdCancel: TDNMSpeedButton;
    cmdPrint: TDNMSpeedButton;
    cmdOk: TDNMSpeedButton;
    cmdDeliveryDocket: TDNMSpeedButton;
    cmdPrintPick: TDNMSpeedButton;
    Button1: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    tblDetailsQty: TFloatField;
    procedure cmdCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure cmdOkClick(Sender: TObject);
    procedure PickingEmployeeIDCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure PackingEmployeeIDCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure FormCreate(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure cmdPrintPickClick(Sender: TObject);
    procedure cmdDeliveryDocketClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  private
    { Private declarations }
    procedure SaveTransaction;
  public
    { Public declarations }
    
  end;

implementation
   
uses FormFactory, CommonDbLib, AuditObj, DnMlib, MAIN, CommonLib,
  ProductQtyLib, frmPrintPickingSlips, Appenvironment, FastFuncs;

{$R *.dfm}

{ TBarcodePickingEditGUI }

procedure TBarcodePickingEditGUI.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TBarcodePickingEditGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  Action := caFree;
//  BarcodePickingEditGUI := nil;
end;

procedure TBarcodePickingEditGUI.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen: array of string;
begin
  DisableForm;
  try
    Processingcursor(True);
    try
      inherited;
      // open queries
      Setlength(QueryNamesNotToOpen, 2);
      QueryNamesNotToOpen[0] := 'tblMaster';
      QueryNamesNotToOpen[1] := 'tblDetails';
      OpenQueries(QueryNamesNotToOpen);

      tblMaster.Connection := CommonDbLib.GetSharedMyDacConnection;

      tblMaster.ParamByName('ID').asInteger := KeyID;
      tblDetails.ParamByName('ID').asInteger := KeyID;


      tblMaster.Open;
      tblDetails.Open;

      if KeyID <> 0 then begin
        EditNoAbort(tblMaster);
        EditNoAbort(tblDetails);
      end else begin
        tblMaster.Insert;
        tblDetails.Insert;
      end;

      Top  := ((MainForm.ClientHeight - MainForm.MainToolBar.Height - 20) - Self.Height) div 2;
      Left := (MainForm.ClientWidth - Self.Width) div 2;


    finally
      Processingcursor(False);
    end;
  finally
    EnableForm;
  end;
end;  


procedure TBarcodePickingEditGUI.cmdOkClick(Sender: TObject);
begin
  inherited;
  SaveTransaction;
  Self.Close;
end;

procedure TBarcodePickingEditGUI.SaveTransaction;
begin
  if (MyConnection.intransaction) then begin
    try
      with tblMaster do try
          if State <> dsBrowse then begin
            Post;
          end;
        except
          raise;
        end;

      with tblDetails do try
          if grdTransactions.Fields[0].AsString <> '' then begin
            if State in [dsEdit, dsInsert] then
              Post;
          end;
        except
          raise;
        end;

    except
      on e: Exception do begin
        Audit.AddEntry(e, Self);
        RollbackTransaction;
        raise Exception.Create(e.Message + Chr(13) + 'Errors occured in ' + Self.ClassName);
      end;
    end;
    CommitTransaction;
    Notify;
  end;
end;

procedure TBarcodePickingEditGUI.PickingEmployeeIDCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
  Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  if not LookupTable.Locate('EmployeeName', PickingEmployeeID.Text, [loCaseInsensitive]) then begin
    Exit;
  end;
  FillTable.FieldByName('PickingEmployeeID').AsInteger := LookupTable.FieldByName('EmployeeID').AsInteger;
end;

procedure TBarcodePickingEditGUI.PackingEmployeeIDCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
  Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  if not LookupTable.Locate('EmployeeName', PackingEmployeeID.Text, [loCaseInsensitive]) then begin
    Exit;
  end;
  FillTable.FieldByName('PackingEmployeeID').AsInteger := LookupTable.FieldByName('EmployeeID').AsInteger;
end;

procedure TBarcodePickingEditGUI.FormCreate(Sender: TObject);
begin
  Processingcursor(True);
  try
    inherited;
    SetConnectionString(false);
    tblMaster.Connection     := MyConnection;
    tblDetails.Connection    := MyConnection;
    MyConnection.Connected := true;
    if not MyConnection.intransaction then begin
      BeginTransaction;
    end;
  finally
    Processingcursor(False);
  end;
end;


procedure TBarcodePickingEditGUI.cmdPrintClick(Sender: TObject);
var
  sSQL: string;
begin
  DisableForm;
  try
    inherited;
    SaveTransaction;
    sSQL := 'Where PA.PickingAssemblyID=' + tblMasterPickingAssemblyID.AsString + ';';
    PrintTemplateReport('Picking Assembly', sSQL, not(appEnv.Employee.PreviewAllreport), 1);
    Self.Close;
  finally
    EnableForm;
  end;  
end;

procedure TBarcodePickingEditGUI.cmdPrintPickClick(Sender: TObject);
var
  sSQL: string;
  reportname:String;
begin
  reportName := 'Pick Slip with Barcodes';
  DisableForm;
  try
    inherited;
    SaveTransaction;
    fbReportSQLSupplied := true;
    sSQL := '{UOMs}SELECT ' +
        ' SL.SaleLineID, uom.UnitId, uom.UnitName, uom.UnitDescription,   CONCAT("USL-",uom.UnitId,"-",SL.SaleLineId) as LineUnitsBarcode ' +
        '  FROM tblsaleslines AS SL inner JOIN tblsales AS S ON  SL.SaleID = S.SaleID ' +
        ' left join tblUnitsOfMeasure uom on (uom.PartId = SL.ProductId or uom.PartId = 0) ' +
        ' WHERE  (SL.SaleLineID= :SaleLineId) order by Unitname';
    sSQL :=TfmPrintPickingSlips.SQL4PickingSlipreport(reportName,IntToStr(tblMasterSaleID.AsInteger), SalesTransTypes, '', sSQL);
    PrintTemplateReport(reportname, sSQL, not(appEnv.Employee.PreviewAllreport), 1);
    Self.Close;
  finally
    EnableForm;
  end;  
end;

procedure TBarcodePickingEditGUI.cmdDeliveryDocketClick(Sender: TObject);
var
  sSQL: string;
begin
  DisableForm;
  try
    inherited;
    SaveTransaction;
//    sSQL := '~|||~Where PA.PickingAssemblyID=' + tblMasterPickingAssemblyID.AsString + ';'+
//            '~|||~Where PickingAssemblyID=' + tblMasterPickingAssemblyID.AsString + ';';
    sSQL := 'Where PA.PickingAssemblyID=' + tblMasterPickingAssemblyID.AsString + ';';
    PrintTemplateReport('Picking Delivery Docket', sSQL, not(appEnv.Employee.PreviewAllreport), 1);
    Self.Close;
  finally
    EnableForm;
  end;  
end;

procedure TBarcodePickingEditGUI.Button1Click(Sender: TObject);
var
  sSQL: string;
begin
  DisableForm;
  try
    inherited;
    SaveTransaction;
    sSQL := 'Where PA.PickingAssemblyID=' + tblMasterPickingAssemblyID.AsString + ';';
    PrintTemplateReport('Picking ConNote', sSQL, not(appEnv.Employee.PreviewAllreport), 1);
    Self.Close;
  finally
    EnableForm;
  end;  
end;

procedure TBarcodePickingEditGUI.btnDeleteClick(Sender: TObject);
begin
  inherited;
  DeleteRecord(grdTransactions.DataSource.DataSet);
end;

initialization
  RegisterClassOnce(TBarcodePickingEditGUI);
  (*FormFact.RegisterMe(TBarcodePickingEditGUI, 'TBarcodePickingListGUI_*_Picked=PickingAssemblyID');
  FormFact.RegisterMe(TBarcodePickingEditGUI, 'TBarcodePickListGUI_*=PickingAssemblyID');*)
end.
