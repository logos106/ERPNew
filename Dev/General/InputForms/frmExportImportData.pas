unit frmExportImportData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  StdCtrls, wwclearbuttongroup, wwradiogroup, Shader, DNMPanel,
  DNMSpeedButton, ComCtrls, AdvProgr, AdvProgressBar, ExportDataObj,
  HTMLDialog, HTMLabel, BaseListingForm, ProgressDialog;

type
  TfmExportImportData = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    rgOption: TwwRadioGroup;
    dlgSave: TSaveDialog;
    HTMLDialog: THTMLDialog;
    chkforceHeader: TCheckBox;
    DNMPanel1: TDNMPanel;
    Bevel2: TBevel;
    Letter_Label: TLabel;
    ProgBar: TAdvProgressBar;
    lblProgress: TLabel;
    btnImport: TDNMSpeedButton;
    btnExport: TDNMSpeedButton;
    txtFileName: TEdit;
    btnFile: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnFileClick(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure rgOptionChange(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure chkforceHeaderEnter(Sender: TObject);
  private
    Exporter: TDataExporter;
    Listing: TBaseListingGUI;
    procedure DoOnProgress(const desc: string; const RecNo, RecCount: integer);
    procedure DoExprtButtonClick(Sender: TObject);
    Procedure openfile;
    function NonERPItemSelected: Boolean;
  protected
    procedure Resize;override;
  public
    Function DoExport:boolean;Virtual;
    Function DoImport:boolean;Virtual;
    Function ListOpened:boolean; virtual;
  end;

var
  fmExportImportData: TfmExportImportData;

implementation

{$R *.dfm}

uses
  DNMExceptions, CommonLib, SystemLib, MemoDialog,
  Main, AppEnvironment, fmImportExportVideoChoice, BaseClassFuncs,
  BusObjectListObj, shellapi;

//const
//  Options: array[0..32, 0..2] of string = (
//    ('Account'                    ,'TAccount'                 ,'TChartOfAccountsListGUI'),
//    ('Account Type'               ,'TAccountType'             ,'TAccountTypesListGUI'),
//    ('Bank Code'                  ,'TBankCode'                ,'TfrmBankCodeList'),
//    ('Client Type'                ,'TClientType'              ,'TClientTypeListGUI'),
//    ('Contact'                    ,'TContact'                 ,'TContactListGUI'),
//    ('Customer'                   ,'TCustomer'                ,'TCustomerListGUI' ),
//    ('Department'                 ,'TDeptClass'               ,'TClassListGUI'),
//    ('Job'                        ,'TJob'                     ,'TJobListGUI'),
//    ('Locations'                  ,'TLocation'                ,'TLocationListGUI'),
//    ('Marketing Contact'          ,'TMarketingContact'        ,'TMarketingContactListGUI'),
//    ('Marketing Contact Contacts' ,'TMarketingContactContact' ,'TMarketingContactcontactListGUI'),
//    ('Marketing Contact Products' ,'TMarketingContactProduct' ,'TMarketingContactProductListGUI'),
//    ('Other Followup'             ,'TOtherFollowUps'          ,'TOtherfollowupsGUI'),
//    ('Product'                    ,'TProduct'                 ,'TProductListGUI'),
//    ('Product Class'              ,'TProductClass'            ,'TProductClassListGUI'),
//    ('Product Bin'                ,'TProductBin'              ,'TBinLocationListGUI'),
//    ('Product Group Discount'     ,'TProductGroupDiscount'    ,'TProductgroupdiscountListGUI'),
//    ('Product Process List'       ,'TProductProcessPart'      ,'TProductProcessListGUI'),
//    ('Product Specification'      ,'TProductSpecs'            ,'TProductSpecificationListGUI'),
//    ('Product Extra Buy'          ,'TProductExtraBuyPrice'    ,'TProductExtrabuyPricesGUI'),
//    ('Product Extra Sell'         ,'TProductExtraSellPrice'   ,'TProductExtraSellPriceGUI'),
//    ('Product Foreign Buy'        ,'TProductForeignBuyPrice'  ,'TProductExtrabuyPricesGUI'),
//    ('Product Foreign Sell'       ,'TProductForeignSellPrice' ,'TproductForeignSellPriceGUI' ),
//    ('Product Unit of Measure'    ,'TUnitOfMeasure'           ,'TUnitsOfMeasureListGUI'),
//    ('Prospect'                   ,'TProspect'                ,'TfrmOthersList'),
//    ('Related Customer'           ,'TRelatedCustomer'         ,'TRelatedCustomerListGUI'),
//    ('Related Product'            ,'TRelatedProduct'          ,'TRelatedProductsGUI'),
//    ('Shipping Method'            ,'TShippingMethod'          ,'TShippingMethodsGUI'),
//    ('Special Product'            ,'TSpecialProducts'         ,'TSpecialProductsGUI'),
//    ('Sub Taxcodes'               ,'TSubTaxCode'              ,'TSubTaxcodesGUI'),
//    ('Supplier'                   ,'TSupplier'                ,'TSupplierListGUI'),
//    ('Tax Code'                   ,'TTaxCode'                 ,'TTaxCodeListGUI'),
//    ('Terms'                      ,'TTerms'                   ,'TTermsListGUI')  );
//
//  Export_Only_Classes = 'TAccountType';

procedure TfmExportImportData.FormCreate(Sender: TObject);
var
  x: integer;
  sl: TStringList;
begin
  inherited;
  chkforceHeader.checked := True;//dene wants this to be checked by default
  lblProgress.Caption:= '';
  rgOption.Items.Clear;
  sl:= TStringList.Create;
  try
    sl.CommaText:= BusObjectListObj.TBusObjInfoList.Inst.NameList(true,[boExport]);
    for x:= 0 to sl.Count -1 do
      if not(sametext(sl[x] , 'Stock Adjustment')) then
        rgOption.Items.Add(sl[x]);
  finally
    sl.Free;
  end;

  Exporter:= TDataExporter.Create;
  Exporter.DataFormat:= dfCSV;
  Exporter.StopOnError:= false;
  Exporter.OnProgress:= self.DoOnProgress;
end;


procedure TfmExportImportData.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;
      on e: Exception do else raise;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfmExportImportData.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  try
    Exporter.Free;
  except
  end;
  Action := caFree;
end;

procedure TfmExportImportData.btnFileClick(Sender: TObject);
begin
  inherited;
  if dlgSave.Execute then begin
    txtFileName.Text := dlgSave.FileName;
  end;
end;

procedure TfmExportImportData.DoOnProgress(const desc: string; const RecNo,
  RecCount: integer);
var
  percent: integer;
begin
  percent:= System.Round((RecNo/RecCount) * 100);
  ProgBar.Position:= percent;
  lblProgress.Caption:= 'Record ' + FormatFloat('#,##0',RecNo) + ' of ' + FormatFloat('#,##0',RecCount);
  if not Showing then
    BringToFront;
  Application.ProcessMessages;
end;

procedure TfmExportImportData.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;
Function TfmExportImportData.NonERPItemSelected:Boolean;
begin
  result := sametext(rgOption.Items[rgOption.ItemIndex] , 'Non ERP Sales') or
            sametext(rgOption.Items[rgOption.ItemIndex] , 'Non ERP Purchases');
end;
procedure TfmExportImportData.rgOptionChange(Sender: TObject);
var
  aPath: string;
begin
  inherited;
  if rgOption.ItemIndex > -1 then begin
    if txtFileName.Text = '' then begin
      aPath:= SystemLib.GetDesktopDir;
      if (devmode) and (directoryExists(aPath+'\Binny-ERP-dataExport')) then aPath := aPath +'Binny-ERP-dataExport\';
    end else
      aPath:= ExtractFilePath(txtFileName.Text);
    txtFileName.Text:= aPath + rgOption.Items[rgOption.ItemIndex] + '.csv';
    if NonERPItemSelected then begin
      timermsg(lblProgress , quotedstr(rgOption.Items[rgOption.ItemIndex] ) + ' Cannot be Exported. This Will Let You Export Just the Header');
      chkforceHeader.Checked := True; // this is to enforce the header as this can only export header and no data
    end;
  end;
end;

procedure TfmExportImportData.btnExportClick(Sender: TObject);
var
  ObjClassName :STring;
begin
   if rgOption.ItemIndex <0 then exit;

    if NonERPItemSelected then
      if not chkforceHeader.Checked  then chkforceHeader.Checked := True; // this is to enforce the header as this can only export header and no data

  ObjClassName:= BusObjectListObj.TBusObjInfoList.Inst.ItemByName[rgOption.Items[rgOption.ItemIndex]].BusObjClassName;
  if ObjClassName <> '' then
    if AppEnv.AccessLevels.GetBusobjAccessLevel(ObjClassName) <> 1 then begin
      MessageDlgXP_vista('You don''t have access to export ' + rgOption.Items[rgOption.ItemIndex] , mtWarning, [mbOK], 0);
      exit;
    end;
  TfrmImportExportVideoChoice.OpenForm(Sender , DoExport);
end;

Function TfmExportImportData.DoExport:boolean;
var
  (* msg: string; *)
  databaseName: string;
  ObjClassName: string;
begin
    REsult := False;
  inherited;
  if rgOption.ItemIndex = -1 then begin
    MessageDlgXP_Vista('Please select an option to export.',mtInformation,[mbOk],0);
    exit;
  end;
  if txtFileName.Text = '' then begin
    MessageDlgXP_Vista('Please select a file name for the export.',mtInformation,[mbOk],0);
    exit;
  end;
  databaseName:= AppEnv.AppDb.Database;
  if not Mainform.RemoveAllConnectionsToDB(self.classname+',TfmERPSetup,TfrmImportExportVideoChoice') then exit;

    try
      try
        if FileExists(txtFileName.Text) and
          (MessageDlgXP_Vista('File already exists, is it ok to overwrite it?',mtConfirmation,[mbYes,mbNo],0) = mrNo) then
            exit;
//        HTMLDialog.ShowModal;

        if (BusObjectListObj.TBusObjInfoList.Inst.ItemByName[rgOption.Items[rgOption.ItemIndex]].ListFormClassName <> '') and
           (MessageDlgXP_Vista('On the Next Screen the Relevant List Will Open. Please Display the Records Using the "F5" Key and Then Filter the List as Required Using the "Right Mouse Click".'
                        +chr(13) +chr(13) +'Do you Wish to Skip the Selection List and Export All Records?',mtConfirmation,[mbNo,mbYes],0) = mrNo) then begin
          if ListOpened then begin
            result := true;
            Exit;
          end;
        end;
        Application.ProcessMessages;
        btnExport.Enabled:= false;
        btnImport.Enabled:= false;
        try
          ObjClassName:= BusObjectListObj.TBusObjInfoList.Inst.ItemByName[rgOption.Items[rgOption.ItemIndex]].BusObjClassName;
          Exporter.forceheader := chkforceHeader.Checked;
          Exporter.ExportDataToFile(ObjClassName,txtFileName.Text);
          result:= true;
          MessageDlgXP_Vista('Export Complete.',mtInformation,[mbOk],0);
          openfile;
        finally
          ProgBar.Position:= 0;
          btnExport.Enabled:= true;
          btnImport.Enabled:= true;
        end;
      except
        on e: exception do begin
          CommonLib.MessageDlgXP_Vista('Error exporting data with message: ' + e.Message, mtInformation, [mbOk], 0);
        end;
      end;
     finally
      lblProgress.Caption:= '';
    end;
end;

procedure TfmExportImportData.btnImportClick(Sender: TObject);
begin
  TfrmImportExportVideoChoice.OpenForm(Sender , DoImport);
end;

procedure TfmExportImportData.chkforceHeaderEnter(Sender: TObject);
begin
  inherited;
  if rgOption.ItemIndex <0 then exit;
  if NonERPItemSelected then begin
      timermsg(lblProgress , quotedstr(rgOption.Items[rgOption.ItemIndex] ) + ' Data Cannot be Exported. This Will Let You Export Just the Header. So "Export Header When No Data" has to be Selected for "Non ERP Sales" / "Non ERP Purchases"  Export');
      chkforceHeader.Checked := True; // this is to enforce the header as this can only export header and no data
      SetcontrolFocus(rgOption);
  end;
end;

Function TfmExportImportData.DoImport:Boolean;
var
  sl: TStringList;
  importOk: boolean;
  msg: string;
  databasename: string;
  BusObjInfo: TBusObjectInfo;
begin
  inherited;
  importOk := False;
  result:= importOk;
  try
    if rgOption.ItemIndex = -1 then begin
      MessageDlgXP_Vista('Please select an option to import.',mtInformation,[mbOk],0);
      exit;
    end;
    BusObjInfo:= BusObjectListObj.TBusObjInfoList.Inst.ItemByName[rgOption.Items[rgOption.ItemIndex]];

    if not (boImport in BusObjInfo.Options) then begin
      MessageDlgXP_Vista(BusObjInfo.Name + ' is for exporting only.',mtInformation,[mbOk],0);
      exit;
    end;
    if txtFileName.Text = '' then begin
      MessageDlgXP_Vista('Please select a file name for the import.',mtInformation,[mbOk],0);
      exit;
    end;
    if not FileExists(txtFileName.Text) then begin
      MessageDlgXP_Vista('File does not exist',mtInformation,[mbOk],0);
      exit;
    end;
    databasename:= AppEnv.AppDb.Database;
    if not Mainform.RemoveAllConnectionsToDB(self.classname+',TfmERPSetup,TfrmImportExportVideoChoice') then exit;
    if AppEnv.UtilsClient.LockLogon(msg, databasename, 'Performing Data Import') then begin
      try
//        HTMLDialog.ShowModal;
        Application.ProcessMessages;
        btnExport.Enabled:= false;
        btnImport.Enabled:= false;
        sl:= TStringList.Create;
        try
          importOk:= Exporter.ImportDataFromFile(BusObjInfo.busobjclassname,txtFileName.Text,sl);
          if importOk then begin
            if sl.Count = 0 then
              MessageDlgXP_Vista('Import Complete.',mtInformation,[mbOk],0)
            else begin
              MessageDlgXP_Vista('Import completed ok with some warnings.',mtInformation,[mbOk],0);
              MemoDialog.DoMemoDialog('Import Warnings',sl.Text,ssBoth);
            end;
          end
          else begin
            MessageDlgXP_Vista('Import completed with some errors.' +
            #13#10 + #13#10 +
            'The lines that could not be processed have been saved into the file: "'+
            Exporter.FailFileName + '".',mtWarning,[mbOk],0);
            MemoDialog.DoMemoDialog('Import Errors',sl.Text,ssBoth);
          end;
        finally
          sl.Free;
          ProgBar.Position:= 0;
          lblProgress.Caption:= '';
          btnExport.Enabled:= true;
          btnImport.Enabled:= true;
        end;
      finally
        AppEnv.UtilsClient.UnlockLogon;
      end;
    end
    else begin
      CommonLib.MessageDlgXP_Vista('Unable to import data, could not lock other users out of ERP: ' + msg, mtInformation, [mbOk], 0);
    end;
  finally
     result :=importOk;
  end;
end;

procedure TfmExportImportData.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if Exporter.Active then begin
    if CommonLib.MessageDlgXP_Vista('Are you sure you want to abort the current Import/Export?', mtConfirmation, [mbYes,mbNo], 0) = mrNo then
      CanClose:= false
    else begin
      Exporter.Active:= false;
      CanClose:= false;
    end;
  end;
end;

procedure TfmExportImportData.DoExprtButtonClick(Sender: TObject);
var
  BusObjInfo: TBusObjectInfo;
  IdField: TField;
  IdList: TStringList;
  x: integer;
begin
  if Assigned(Listing) then begin
    { if user has selected records in the grid filter on these }
    if Listing.grdMain.SelectedList.Count > 0 then begin
      { get the id field ... }
      IDList := TStringList.Create;
      try
        IdField := Listing.IdfieldFor(Self.classname);
        if not Assigned(IdField) then begin
          for x := 0 to Listing.qryMain.FieldCount -1 do begin
            if Listing.qryMain.Fields[x].AutoGenerateValue = arAutoInc then begin
              IdField := Listing.qryMain.Fields[x];
              break;
            end;
          end;
        end;
        if Assigned(IdField) then begin
          (*for x := 0 to Listing.grdMain.SelectedList.Count -1 do begin
            Listing.qryMain.GotoBookmark(Listing.grdMain.SelectedList[x]);
            IDList.Add(Listing.qryMain.FieldByName(IDField.FullName).AsString);
          end;*)
          SelectedIds(Listing.grdmain ,IdField.fieldname , IDList , true);
        end;
        if IdList.Count > 0 then begin
          Listing.qryMain.AddWhere(IDField.FullName + ' in (' + IdList.CommaText + ')');
          Listing.qryMain.Open;
        end;
      finally
        IdList.Free;
      end;

    end;
    self.BringToFront;
    try
      Application.ProcessMessages;
      btnExport.Enabled:= false;
      btnImport.Enabled:= false;
      try
        try
          BusObjInfo:= BusObjectListObj.TBusObjInfoList.Inst.ItemByName[rgOption.Items[rgOption.ItemIndex]];
          Listing.qryMain.DisableControls;
          Exporter.forceheader := chkforceHeader.Checked;
          Exporter.ExportDataToFile(BusObjInfo.BusObjClassName,txtFileName.Text,0,Listing.qryMain);
          MessageDlgXP_Vista('Export Complete.',mtInformation,[mbOk],0);
        except
          on E:Exception do begin
              MessageDlgXP_Vista('Export Failed.' +chr(13)+chr(13) +e.Message , mtWarning, [mbok],0);
          end;
        end;
      finally
        ProgBar.Position:= 0;
        btnExport.Enabled:= true;
        btnImport.Enabled:= true;
      end;
      Listing.Release;
      Listing:= nil;
    except
      on e: exception do begin
        CommonLib.MessageDlgXP_Vista('Error exporting data with message: ' + e.Message, mtInformation, [mbOk], 0);
      end;
    end;
  end;
end;

function TfmExportImportData.ListOpened: boolean;
var
  BusObjInfo: TBusObjectInfo;
begin
  result := False;
  BusObjInfo:= BusObjectListObj.TBusObjInfoList.Inst.ItemByName[rgOption.Items[rgOption.ItemIndex]];
  if Assigned(BusObjInfo) and (BusObjInfo.ListFormClassName <> '') then begin
    Listing:= GetBaseListingByClassName(BusObjInfo.ListFormClassName, true);
    if Assigned(Listing) then begin
      Listing.cmdExport.OnClick:= DoExprtButtonClick;
      Listing.cmdClose.OnClick:= DoExprtButtonClick;
      Listing.FormStyle:= fsMDIChild;
      Listing.BringToFront;
      result:= true;
    end;
  end;
end;

procedure TfmExportImportData.openfile;
var
  fsfilename:STring;
begin
  if not devmode then exit;
  fsfilename := txtFileName.text;
  ShellExecute(Handle, 'Open', PChar(fsfilename), '', '', SW_SHOWNORMAL);
end;

procedure TfmExportImportData.Resize;
begin
  inherited;
  rgOption.Top := pnlTitle.Top + pnlTitle.Height + 12;
end;

initialization
  RegisterClassOnce(TfmExportImportData);

end.
