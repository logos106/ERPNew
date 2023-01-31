unit frmWorkOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase, wwdbedit, Mask, wwdbdatetimepicker, Grids,
  Wwdbigrd, Wwdbgrid , busobjBOMSalesPieceRateConf , CustomfieldonGrid;

type
  TfmWorkOrder = class(TBaseInputGUI)
    pnlHeader: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    pnlFooter: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    tblMaster: TERPQuery;
    tblMasterSaleID: TIntegerField;
    tblMasterCustomerName: TWideStringField;
    tblMasterInvoiceTo: TWideStringField;
    tblMasterShipTo: TWideStringField;
    tblMasterEmployeeName: TWideStringField;
    tblMasterClass: TWideStringField;
    tblMasterPONumber: TWideStringField;
    tblMasterTerms: TWideStringField;
    tblMasterSalesCategory: TWideStringField;
    tblMasterQuoteStatus: TWideStringField;
    tblMasterDueDate: TDateField;
    tblMasterInvoiceDocNumber: TWideStringField;
    tblMasterSaleDate: TDateField;
    tblMasterShipDate: TDateField;
    DSMaster: TDataSource;
    tblDetails: TERPQuery;
    tblDetailsSaleLineID: TIntegerField;
    tblDetailsProductID: TIntegerField;
    tblDetailsProductName: TWideStringField;
    tblDetailsUnitofMeasureShipped: TFloatField;
    DSDetails: TDataSource;
    QryProcesses: TERPQuery;
    QryProcessestree: TWideStringField;
    QryProcessesProcessStep: TWideStringField;
    QryProcessesQtyPerCoupon: TFloatField;
    QryProcessesRAtePercoupon: TFloatField;
    QryProcessesMakeCoupons: TWideStringField;
    QryProcessesCouponLabelPrinted: TWideStringField;
    QryProcessesSequenceDown: TIntegerField;
    QryProcessesSeqno: TLargeintField;
    QryProcessesParentID: TIntegerField;
    QryProcessesrownum: TLargeintField;
    QryProcessesMasterID: TIntegerField;
    QryProcessesProctreeId: TIntegerField;
    QryProcessesProcessPartID: TIntegerField;
    QryProcessesNoOfchildNodes: TIntegerField;
    QryProcessesID: TIntegerField;
    dsProcesses: TDataSource;
    Label38: TLabel;
    SaleDate_Label: TLabel;
    Label160: TLabel;
    imgSearch: TImage;
    cboCreationDate: TwwDBDateTimePicker;
    txtCustomID: TDBEdit;
    cboClientR: TwwDBEdit;
    pnlSubboms: TDNMPanel;
    grdTransactions: TwwDBGrid;
    cmdPrint: TDNMSpeedButton;
    DNMSpeedButton2: TDNMSpeedButton;
    DNMSpeedButton1: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    DNMSpeedButton3: TDNMSpeedButton;
    tblDetailsProduct_Description: TWideStringField;
    tblDetailsTotalLineAmountInc: TFloatField;
    tblDetailsSalesLinesCustField1: TWideStringField;
    tblDetailsSalesLinesCustField2: TWideStringField;
    tblDetailsSalesLinesCustField3: TWideStringField;
    tblDetailsSalesLinesCustField4: TWideStringField;
    tblDetailsSalesLinesCustField5: TWideStringField;
    tblDetailsSalesLinesCustField6: TWideStringField;
    tblDetailsSalesLinesCustField7: TWideStringField;
    tblDetailsSalesLinesCustField8: TWideStringField;
    tblDetailsSalesLinesCustField9: TWideStringField;
    tblDetailsSalesLinesCustField10: TWideStringField;
    mnuDetails: TAdvPopupMenu;
    mnuPrintBarCode: TMenuItem;
    N1: TMenuItem;
    QryProcessesTreePartUOMTotalQty: TFloatField;
    QryProcessesManufactureUOMQty: TFloatField;
    QryProcessesOnOrderUOMQty: TFloatField;
    QryProcessesFromStockUOMQty: TFloatField;
    QryProcessesCouponsPerBundle: TFloatField;
    QryProcessesBundleQty: TFloatField;
    QryProcessesBundles: TFloatField;
    QryProcessesDuration: TFloatField;
    QryProcessesSetupduration: TFloatField;
    QryProcessesbreakdownduration: TFloatField;
    QryProcessesTotalDuration: TWideStringField;
    QryProcessesTotalSetupduration: TWideStringField;
    QryProcessesTotalbreakdownduration: TWideStringField;
    QryProcessesBundleDuration: TWideStringField;
    PNLHEADERDETAILS: TDNMPanel;
    Bevel1: TBevel;
    lblClientDetails: TLabel;
    Label43: TLabel;
    Bevel2: TBevel;
    Label79: TLabel;
    ClassLabel: TLabel;
    Label8: TLabel;
    lblStatus: TLabel;
    Label45: TLabel;
    Label1: TLabel;
    Bevel3: TBevel;
    txtClientDetails: TDBMemo;
    cboTerms: TwwDBEdit;
    txtPONumber: TDBEdit;
    cboClass: TwwDBEdit;
    cboDueDate: TwwDBDateTimePicker;
    cboCurrentStatus: TwwDBEdit;
    cboSalesCategory: TwwDBEdit;
    txtShipTo: TDBMemo;
    pnlSalesLines: TDNMPanel;
    grdSaleSLines: TwwDBGrid;
    btnCustomize: TDNMSpeedButton;
    pnlChooseRpt: TDNMPanel;
    chkChooseRpt: TCheckBox;
    pnlsales: TDNMPanel;
    Label6: TLabel;
    Product: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    cboEmployee: TwwDBEdit;
    wwDBEdit1: TwwDBEdit;
    wwDBEdit2: TwwDBEdit;
    edtBundleQty: TMaskEdit;
    edtNoOfBundles: TEdit;
    cboShipDate: TwwDBDateTimePicker;
    Label9: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure grdTransactionsCalcCellColors(Sender: TObject; Field: TField;State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure tblMasterBeforeOpen(DataSet: TDataSet);
    procedure pnlHeaderEnter(Sender: TObject);
    procedure tblDetailsBeforeOpen(DataSet: TDataSet);
    procedure cmdNewClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure DNMSpeedButton2Click(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure DNMSpeedButton3Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdSaleSLinesCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdSaleSLinesColEnter(Sender: TObject);
    procedure mnuPrintBarCodeClick(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure mnuDetailsPopup(Sender: TObject);
    procedure tblDetailsCalcFields(DataSet: TDataSet);
    procedure edtBundleQtyExit(Sender: TObject);
    procedure QryProcessesAfterOpen(DataSet: TDataSet);
  private
    fiSalesLineID: Integer;
    fiProctreeId: Integer;
    fisaleId: Integer;
    fCustomfieldonGrid: TCustomFieldonGrid;
    PrintBarcodeOfcurrentLine: Boolean;
    fID:Integer;
    sReportSQL:String;
    procedure ApplyCustomFieldsSettings;
    procedure beforeshowCustomfieldList(Sender: TObject);
    Function PrintBarCodes:Boolean;
    procedure PrintBarCodesCallback(const Sender: TBusObj; var Abort: Boolean);
    Function PrintBarCode(fiBOMSalesPieceRateConfID:Integer):Boolean;
    procedure Calcbundles;
  Protected
    BOMSalesPieceRateConf: TBOMSalesPieceRateConf;
    Procedure RefreshQuery;Virtual;
    function GetReportTypeID: integer; Override;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    function SaveRecord: Boolean;
  public
    Property SalesLineID :Integer read fiSalesLineID  write fiSalesLineID ;
    Property saleId :Integer read fisaleId  write fisaleId ;
    Property ProctreeId :Integer read fiProctreeId  write fiProctreeId ;
  end;


implementation

uses CommonLib, BusObjConst, CommonDbLib, ColourLib, DbSharedObjectsObj, LogLib,
  tcConst, Busobjcustomfields, BusObjSales, CommonFormLib, frmCustomfieldList,
  TemplateReportsLib, AppEnvironment, tcDataUtils,Math;

{$R *.dfm}

procedure TfmWorkOrder.btnCustomizeClick(Sender: TObject);
begin
  inherited;
  if OpenERPFormModal('TfmCustomfieldList', 0, beforeshowCustomfieldList)>=0  then begin
    fCustomfieldonGrid.ApplyCustomFieldsSettings;
  end;
end;
procedure TfmWorkOrder.beforeshowCustomfieldList(Sender: TObject);
begin
  if not(Sender is TfmCustomfieldList) then Exit;
  TfmCustomfieldList(Sender).ListType := ltSaleslines;
end;

procedure TfmWorkOrder.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

Function TfmWorkOrder.SaveRecord :Boolean;
begin
  result:= False;
  BOMSalesPieceRateConf.PostDB;
  BOMSalesPieceRateConf.SalesOrderLine.PostDB;
  if not(BOMSalesPieceRateConf.Save) then exit;
  Result:= True;
  BOMSalesPieceRateConf.Dirty := False;
end;

procedure TfmWorkOrder.tblDetailsBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  tbldetails.Parambyname('ID').AsInteger := saleslineId;
end;

procedure TfmWorkOrder.tblDetailsCalcFields(DataSet: TDataSet);
begin
  inherited;
(*  tblDetailsNoOfBundles.asInteger := 0;
  if (tblDetailsBundleQty.asFloat <>0) and ( tbldetailsUnitofMeasureShipped.asFloat <>0) then
    if tbldetailsUnitofMeasureShipped.asFloat / tblDetailsBundleQty.asFloat = trunc(tbldetailsUnitofMeasureShipped.asFloat / tblDetailsBundleQty.asFloat ) then
      tblDetailsNoOfBundles.asInteger :=trunc(tbldetailsUnitofMeasureShipped.asFloat / tblDetailsBundleQty.asFloat )
    else tblDetailsNoOfBundles.asInteger :=trunc(tbldetailsUnitofMeasureShipped.asFloat / tblDetailsBundleQty.asFloat )+1;*)
end;

procedure TfmWorkOrder.tblMasterBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  tblMaster.Parambyname('ID').AsInteger := saleId;
end;

procedure TfmWorkOrder.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if Accesslevel > 3 then begin
      Self.Close;
      exit;
  end;
  if not SaveRecord then exit;
  BOMSalesPieceRateConf.Connection.CommitTransaction;
  Self.Close;

end;

procedure TfmWorkOrder.cmdNewClick(Sender: TObject);
begin
  inherited;
  if Accesslevel > 3 then exit;
  BOMSalesPieceRateConf.SelectAll;
end;
procedure TfmWorkOrder.cmdPrintClick(Sender: TObject);
begin
  inherited;
  PrintBarcodeOfcurrentLine:= False;
  if PrintBarcodes then Self.close
  else MessageDlgXP_vista('Please Select Records for Making Coupons', mtWarning, [mbOK], 0);
end;

procedure TfmWorkOrder.pnlHeaderEnter(Sender: TObject);
begin
  inherited;
  Setcontrolfocus(edtBundleQty);
end;

procedure TfmWorkOrder.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  if Accesslevel > 3 then exit;
  BOMSalesPieceRateConf.SelectAllParts;
end;

procedure TfmWorkOrder.DNMSpeedButton2Click(Sender: TObject);
begin
  inherited;
  if Accesslevel > 3 then exit;
  BOMSalesPieceRateConf.SelectAllProcess;
end;

procedure TfmWorkOrder.DNMSpeedButton3Click(Sender: TObject);
begin
  inherited;
  if Accesslevel > 3 then exit;
  BOMSalesPieceRateConf.UnSelectAll;

end;

procedure TfmWorkOrder.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
    inherited;
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TBOMSalesPieceRateConf then TBOMSalesPieceRateConf(Sender).Dataset  := QryProcesses
        else if Sender is TsalesOrderLine then TsalesOrderLine(Sender).Dataset  := tblDetails;
     end;
end;

procedure TfmWorkOrder.edtBundleQtyExit(Sender: TObject);
var
  fdBundleQty:Double;
begin
  inherited;
    fdBundleQty := 0;
    try
      fdBundleQty := StrToFloat(edtBundleQty.text);
    Except
      // kill excetion
    end;
    if fdBundleQty <> 0 then begin
      QryProcesses.First;
      EditDB(QryProcesses);
      QryProcessesBundleQty.asFloat := fdBundleQty ;
      PostDB(QryProcesses);
    end;
    Calcbundles;
end;

procedure TfmWorkOrder.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if BOMSalesPieceRateConf = nil then begin
    Canclose:= True;
  end else if BOMSalesPieceRateConf.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveRecord then begin
            CommitAndNotify;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          BOMSalesPieceRateConf.Dirty := false;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
          cmdCancel.Enabled := True;
        end;
    end;
  end else begin
    CanClose := true;
    Notify(false);
  end;

end;

procedure TfmWorkOrder.FormCreate(Sender: TObject);
begin
  AllowCustomiseGrid := true;
  inherited;
  BOMSalesPieceRateConf := TBOMSalesPieceRateConf.Create(Self);
  BOMSalesPieceRateConf.Connection := TMydacdataconnection.Create(BOMSalesPieceRateConf);
  BOMSalesPieceRateConf.Connection.connection := Self.MyConnection;
  BOMSalesPieceRateConf.BusObjEvent := DoBusinessObjectEvent;
  BOMSalesPieceRateConf.DoInitFloatFieldDisplayFormat := TRue;

end;
procedure TfmWorkOrder.FormDestroy(Sender: TObject);
begin
  Freeandnil(fCustomfieldonGrid);
  inherited;

end;

Procedure TfmWorkOrder.Calcbundles;
var
    fdBundleQty, fdBundles:Double;
begin
    QryProcesses.First;
    fdBundleQty :=QryProcessesBundleQty.asFloat;
    if (fdBundleQty<=0) OR (tbldetailsUnitofMeasureShipped.asfloat <=0) then begin
      fdBundles := 0;
    end else begin
      if samevalue(tbldetailsUnitofMeasureShipped.asfloat / fdBundleQty , trunc(tbldetailsUnitofMeasureShipped.asfloat / fdBundleQty) ,0.00) then
           fdBundles :=trunc(tbldetailsUnitofMeasureShipped.asfloat / fdBundleQty)
      else fdBundles := trunc(tbldetailsUnitofMeasureShipped.asfloat / fdBundleQty)+1;
    end;

    edtBundleQty.text := FloattostrF(fdBundleQty , ffGeneral, 15,0);
    edtNoOfBundles.text := FloattostrF(fdBundles, ffGeneral, 15,0);
end;
procedure TfmWorkOrder.FormShow(Sender: TObject);
var
  s:String;
begin
  try
    inherited;
    RefreshQuery;
    BOMSalesPieceRateConf.connection.BeginTransaction;
    openQueries;
    ApplyCustomFieldsSettings;
    if BOMSalesPieceRateConf.Userlock.Enabled = False then BOMSalesPieceRateConf.Userlock.Enabled := true;
    if Accesslevel <= 3 then
      if not BOMSalesPieceRateConf.Userlock.Lock('tblSales' , saleId ) then begin
        AccessLevel := 5;
        s:=BOMSalesPieceRateConf.Userlock.LockMessage;
        s:= replacestr(BOMSalesPieceRateConf.Userlock.LockMessage , 'Unable to update data.', 'Unable to Make Workorder.');
        MessageDlgXP_Vista(s +NL+NL+'Access is changed to Read-Only', mtWarning, [mbok] , 0);
      end;
    CalcBundles;


    edtNoOfBundles.text

  Except
    on E:Exception do begin
      MessageDlgXP_vista(E.Message, mtWarning, [mbOK], 0);
    end;
  end;
end;
function TfmWorkOrder.GetReportTypeID: integer;
begin
  REsult := 149;
end;

procedure TfmWorkOrder.ApplyCustomFieldsSettings;
begin
  fCustomfieldonGrid := TCustomFieldonGrid.Create(Self,
    'SalesLinesCustField1,SalesLinesCustField2,SalesLinesCustField3,SalesLinesCustField4,SalesLinesCustField5,SalesLinesCustField6,SalesLinesCustField7,SalesLinesCustField8,SalesLinesCustField9,SalesLinesCustField10',
    ltSaleslines, grdSaleSLines, guiprefs, BOMSalesPieceRateConf.SalesOrderLine);
  fCustomfieldonGrid.ApplyCustomFieldsSettings;
end;

procedure TfmWorkOrder.grdSaleSLinesCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if Sametext(field.fieldname, tblDetailsProduct_Description.fieldname) or Sametext(field.fieldname, tblDetailsTotalLineAmountInc.fieldname) then begin
      ABrush.Color := GridColhighLightOrange;
      AFont.color := clBlack;
  end;

end;

procedure TfmWorkOrder.grdSaleSLinesColEnter(Sender: TObject);
begin
  inherited;
(*  if Sametext(TField(grdSaleSLines.GetActiveField).fieldname, tblDetailsProduct_Description.fieldname) or
     Sametext(TField(grdSaleSLines.GetActiveField).fieldname, tblDetailsTotalLineAmountInc.fieldname) then begin

  end;*)
end;

procedure TfmWorkOrder.grdTransactionsCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean;
  AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if QryProcessesSeqno.asInteger =1 then begin
    ABrush.Color := GridColhighLightYellow1; //AlternateColor(QryProcessesrownum.AsInteger);
    Afont.Style :=Afont.Style +[fsBold];
    aFont.color := clBlack;
  end;

  if QryProcessesSeqno.asInteger =2 then
    if sametext(field.fieldname , QryProcessesTree.fieldname) then Afont.color := ABrush.color;

  if sametext(field.fieldname , QryProcessesQtyPerCoupon.fieldname ) and (QryProcessesQtyPerCoupon.AsFloat  =0) then Afont.color := ABrush.color;
  if sametext(field.fieldname , QryProcessesRatePerCoupon.fieldname) and (QryProcessesRatePerCoupon.AsFloat=0) then Afont.color := ABrush.color;
  if QryProcessesProcessPartID.asInteger =0 then
    if sametext(field.fieldname , QryProcessesBundleQty.fieldname ) or
       sametext(field.fieldname , QryProcessesCouponsPerBundle.fieldname ) or
       sametext(field.fieldname , QryProcessesBundleDuration.fieldname ) or
       sametext(field.fieldname , QryProcessesBundleQty.fieldname ) then begin
         aFont.color :=   ABrush.Color ;
       end;

  if QryProcessesCouponLabelPrinted.asBoolean   then
    if sametext(field.fieldname , QryProcessesQtyPerCoupon.fieldname ) then begin
      ABrush.Color := GridColhighLightBlue;
      Afont.Style :=Afont.Style +[fsBold];
      AFont.color := clBlack;
    end;
end;

procedure TfmWorkOrder.mnuDetailsPopup(Sender: TObject);
begin
  inherited;
  mnuPrintBarCode.Visible := BOMSalesPieceRateConf.QtyPerCoupon > 0;
end;

procedure TfmWorkOrder.mnuPrintBarCodeClick(Sender: TObject);
begin
  inherited;
  PrintBarcodeOfcurrentLine:= True;
  try
    PrintBarcodes;
  finally
    PrintBarcodeOfcurrentLine:= False;
  end;
end;

Function TfmWorkOrder.PrintBarCode(fiBOMSalesPieceRateConfID: Integer):Boolean;
var
  Extrafields:String;
  ctr:Integer;
  Function BarCodeSQL:String;
  begin
      Result := Extrafields;
      result := replacestr(result , ':Ctr' , inttostr(ctr));
      if BOMSalesPieceRateConf.Seqno =1 then
           Result := ReplaceStr(result  , ':QtyPerCoupon' , 'PT.QtyPerCoupon')
      else Result := ReplaceStr(result  , ':QtyPerCoupon' , 'PP.QtyPerCoupon');

      if BOMSalesPieceRateConf.Seqno =1 then
           Result := ReplaceStr(result  , ':ProcessID' , '0')
      else Result := ReplaceStr(result  , ':ProcessID' , 'PP.ID');

  end;
begin
  REsult := False;
  if BOMSalesPieceRateConf.ID <>  fiBOMSalesPieceRateConfID then
    if not BOMSalesPieceRateConf.Locate(BOMSalesPieceRateConf.IDFieldname , fiBOMSalesPieceRateConfID , []) then exit;

  if BOMSalesPieceRateConf.ManufactureUOMQty =0 then exit;

  Extrafields:= 'concat("BXR-" , BXR.ID) as IDBarcode,BXR.intValue4 as Counter, '+
      'concat(BXR.intValue4," / " , BXR.intValue5) as Counterdesc, '+
      'BXR.intValue5 as BarcodeNos, '+
      'BXR.Barcode, '+
      //' concat_ws("-","P",PT.ProctreeId ,:ProcessID,:QtyPerCoupon,:ctr)  as Barcode, '+
      ' SL.SalesLinesCustField1,'+
      ' SL.SalesLinesCustField2,'+
      ' SL.SalesLinesCustField3,'+
      ' SL.SalesLinesCustField4,'+
      ' SL.SalesLinesCustField5,'+
      ' SL.SalesLinesCustField6,'+
      ' SL.SalesLinesCustField7,'+
      ' SL.SalesLinesCustField8,'+
      ' SL.SalesLinesCustField9,'+
      ' SL.SalesLinesCustField10,'+
      ' Sl.ProductName, '+
      ' SL.UnitofMeasureShipped as SaleQty,'+
      ' S.CustomerName, '+
      Quotedstr(BOMSalesPieceRateConf.BundleDuration)+' as BundleDuration , ' +
      Quotedstr(BOMSalesPieceRateConf.Bundles)+' as Bundles , ' +
      ' if(ifnull(TS.ID,0)<>0, "TimeSheet Done","") as TimeSheetCreated , ' +
      ' FormatSecondsTotime( PP.Duration*ManufactureUOMQty) TotalDuration, ';
  if BOMSalesPieceRateConf.Seqno =1 then begin
    Extrafields:=  BOMSalesPieceRateConf.ProcTreeSQL(Extrafields)+ ' inner join tblBarcodexRef BXR on BXR.intValue1 = PT.proctreeId and BXR.intValue2 = 0 and  BXR.Barcodetype = "btWorkOrder" '+
                                                           ' Left join tbltimesheets TS on TS.WorkOrderCouponID = BXR.Barcode  '+
                                                           ' where PT.ProctreeId = ' + inttostr(BOMSalesPieceRateConf.ProctreeId);
  end else begin
    Extrafields:=  BOMSalesPieceRateConf.ProcesSSQL(Extrafields)+ ' inner join tblBarcodexRef BXR on BXR.intValue1 = PT.proctreeId  and BXR.intValue2 = PP.ID  and  BXR.Barcodetype = "btWorkOrder" '+
                                                           ' Left join tbltimesheets TS on TS.WorkOrderCouponID = BXR.Barcode  '+
                                                           ' where PP.ID = ' + inttostr(BOMSalesPieceRateConf.ProcessPartID);
  end;
    if sReportSQL <> '' then sReportSQL := sReportSQL +' union all ';
    sReportSQL := sReportSQL +  Extrafields;

  BOMSalesPieceRateConf.CouponLabelPrinted := True;
  BOMSalesPieceRateConf.PostDB;


  (*fiCoupons:= BOMSalesPieceRateConf.ManufactureUOMQty /BOMSalesPieceRateConf.QtyPercoupon;
  if trunc(fiCoupons)<> fiCoupons then fiCoupons := trunc(fiCoupons+1);

  Extrafields:= ':Ctr as Counter, '+
      'concat(:Ctr," / " , ' + inttostr(trunc(fiCoupons))+') as Counterdesc, '+
      inttostr(trunc(fiCoupons))+' as BarcodeNos, '+
      ' concat_ws("-","P",PT.ProctreeId ,:ProcessID,:QtyPerCoupon,:ctr)  as Barcode, '+
      ' SL.SalesLinesCustField1,'+
      ' SL.SalesLinesCustField2,'+
      ' SL.SalesLinesCustField3,'+
      ' SL.SalesLinesCustField4,'+
      ' SL.SalesLinesCustField5,'+
      ' SL.SalesLinesCustField6,'+
      ' SL.SalesLinesCustField7,'+
      ' SL.SalesLinesCustField8,'+
      ' SL.SalesLinesCustField9,'+
      ' SL.SalesLinesCustField10,'+
      ' Sl.ProductName, '+
      ' SL.UnitofMeasureShipped as SaleQty,'+
      ' S.CustomerName, '+
      ' if(ifnull(TS.ID,0)<>0, "TimeSheet Done","") as TimeSheetCreated , ' ;

  if BOMSalesPieceRateConf.Seqno =1 then begin
    Extrafields :=BOMSalesPieceRateConf.ProcTreeSQL(Extrafields)+ ' Left join tbltimesheets TS on TS.WorkOrderCouponID = concat_ws("-","P",PT.ProctreeId ,:ProcessID,:QtyPerCoupon,:ctr)  where PT.ProctreeId = ' + inttostr(BOMSalesPieceRateConf.ProctreeId);
  end else begin
    Extrafields := BOMSalesPieceRateConf.ProcesSSQL(Extrafields)+ ' Left join tbltimesheets TS on TS.WorkOrderCouponID = concat_ws("-","P",PT.ProctreeId ,:ProcessID,:QtyPerCoupon,:ctr)   where PP.ID = ' + inttostr(BOMSalesPieceRateConf.ProcessPartID);
  end;

  //sReportSQL:= '';
  for ctr := 1 to trunc(fiCoupons) do begin
    if sReportSQL <> '' then sReportSQL := sReportSQL +' union all ';
    sReportSQL := sReportSQL +  BarCodeSQL;
  end;
  //sReportSQL:= companyInfoSQL +'~|||~'+ '{Details}'+sReportSQL ;
  //clog(sReportSQL);
  BOMSalesPieceRateConf.CouponLabelPrinted := TRue;
  BOMSalesPieceRateConf.PostDB;*)
  Result := TRue;
end;
Function  TfmWorkOrder.PrintBarCodes:Boolean;
begin
    result := False;
    if Accesslevel > 3 then begin
      MessageDlgXP_Vista('You don''t have access to Prin tthe Barcodes', mtWarning, [mbOK], 0);
      exit;
    end;
    if not(SaveRecord) then exit;
    BOMSalesPieceRateConf.Connection.CommitTransaction;
    try
      BOMSalesPieceRateConf.connection.BeginTransaction;
      try
        fID :=BOMSalesPieceRateConf.ID;
        ReportToPrint:= '';
        sReportSQL:='';
        BOMSalesPieceRateConf.IterateRecords(PrintBarCodesCallback);
        if sReportSQL <> '' then begin
          sReportSQL:= companyInfoSQL +'~|||~'+ '{Details}'+sReportSQL ;
          clog(sReportSQL);
          if ReportToPrint = '' then begin
            if chkChooseRpt.Checked then begin
              LoadReportTypes;
              if dlgReportSelect.Execute then ReportToPrint := dlgReportSelect.SelectedItems.Text else exit;
            end;
            if reporttoPrint = '' then  reporttoPrint := tcdatautils.GetDefaultReport(GetReportTypeID);
            if ReportToPrint ='' then begin
              MessageDlgXP_Vista('You have to choose a template to Print. Either Make a default Template or Select option to Choose template', mtWarning, [mbOK], 0);
              exit;
            end;
          end;
          fbReportSQLSupplied := tRue;
          try
            PrintTemplateReport(ReportToPrint , sReportSQL , not(Appenv.Employee.ShowPreview) and not(devmode) , 1 );
            if not(SaveRecord) then exit; // this is to save the CouponLabelPrinted
            result := true;
          finally
            fbReportSQLSupplied:= False;
          end;
        end;

      finally
        BOMSalesPieceRateConf.Connection.CommitTransaction;
      end;
    finally
      BOMSalesPieceRateConf.connection.BeginTransaction;
    end;
end;

Procedure TfmWorkOrder.PrintBarCodesCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if (PrintBarcodeOfcurrentLine =False) or (fID = BOMSalesPieceRateConf.ID) then begin
    if BOMSalesPieceRateConf.MakeCoupons then begin
      if (BOMSalesPieceRateConf.QtyPercoupon >0) and (BOMSalesPieceRateConf.ManufactureUOMQty>0) then begin
           if not PrintBarCode(BOMSalesPieceRateConf.ID) then abort := True;
      end;
    end;
  end;
end;

procedure TfmWorkOrder.QryProcessesAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if ProctreeId <> 0 then
    QryProcesses.locate(QryProcessesProctreeId.fieldname , ProctreeId , []);
end;

procedure TfmWorkOrder.RefreshQuery;
begin
  BOMSalesPieceRateConf.LoadForSaleLine(SalesLineId,0);
end;

initialization
  RegisterClassOnce(TfmWorkOrder);

end.

