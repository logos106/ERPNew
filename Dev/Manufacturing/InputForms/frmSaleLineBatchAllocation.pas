unit frmSaleLineBatchAllocation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, SelectionDialog, AppEvnts,
  Menus, ExtCtrls, StdCtrls, BusObjSales, DNMSpeedButton, Shader, DNMPanel,
  BusObjBase, Grids, Wwdbigrd, Wwdbgrid, Mask, wwdbedit, Buttons, wwcheckbox;

type
  TfmSaleLineBatchAllocation = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    qryPQADetail: TERPQuery;
    qryPQADetailGlobalRef: TWideStringField;
    qryPQADetailPQADetailID: TIntegerField;
    qryPQADetailPQAID: TIntegerField;
    qryPQADetailQty: TFloatField;
    qryPQADetailUOMQty: TFloatField;
    qryPQADetailBOQty: TFloatField;
    qryPQADetailBOUOMQty: TFloatField;
    qryPQADetailPQAType: TWideStringField;
    qryPQADetailParentRef: TWideStringField;
    qryPQADetailValue: TWideStringField;
    qryPQADetailExpiryDate: TDateTimeField;
    qryPQADetailActive: TWideStringField;
    qryPQADetailmsTimeStamp: TDateTimeField;
    qryPQADetailBinID: TIntegerField;
    qryPQADetailmsUpdateSiteCode: TWideStringField;
    grdBatch: TwwDBGrid;
    dsPQADetail: TDataSource;
    dsSale: TDataSource;
    dsSaleLine: TDataSource;
    Label1: TLabel;
    edtSaleId: TwwDBEdit;
    Label2: TLabel;
    wwDBEdit1: TwwDBEdit;
    Label3: TLabel;
    wwDBEdit2: TwwDBEdit;
    Label4: TLabel;
    wwDBEdit3: TwwDBEdit;
    Label5: TLabel;
    wwDBEdit4: TwwDBEdit;
    wwDBGrid1IButton: TwwIButton;
    cmdNew: TDNMSpeedButton;
    chkAllocated: TwwCheckBox;
    btnPrint: TDNMSpeedButton;
    pnlAdvPrinting: TDNMPanel;
    LblChooseTemplate: TLabel;
    LblShowPreview: TLabel;
    ChkChooseRpt: TCheckBox;
    chkPreview: TCheckBox;
    qryPQADetailTruckLoadNo: TWideStringField;
    qryPQADetailCUSTFLD4: TIntegerField;
    qryPQADetailCUSTFLD1: TFloatField;
    qryPQADetailCUSTFLD5: TWideStringField;
    btnPrintunallocated: TDNMSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure wwDBGrid1IButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure grdBatchDblClick(Sender: TObject);
    procedure chkAllocatedClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qryPQADetailAfterOpen(DataSet: TDataSet);
    procedure btnPrintunallocatedClick(Sender: TObject);
  private
    SalesOrder: TSalesOrder;
    function SaveRecord: Boolean;
    function GridDataset:TERPQuery;
    procedure InitAllocfieldNames;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    { Public declarations }
  end;

implementation

uses
  tcDataUtils, busobjPOS, BusObjCash, busobjvoucher, BusObjPOSSale,
  CommonLib, DbSharedObjectsObj, FormFactory, BusObjConst,
  BusObjPQA, (*frmBatchNoCreateAndPrint*)frmBatchNoCreate, IntegerListObj, CommonDbLib,
  AppEnvironment, saleslib, CommonFormLib, GridFieldsObj, JSONObject;

{$R *.dfm}

procedure TfmSaleLineBatchAllocation.btnPrintClick(Sender: TObject);
var
  s:String;
  Json: TJsonObject;
begin
  inherited;
  s:= commonlib.SelectedIDs(grdbatch , 'pqadetailID' , True);
  if s = '' then begin
    CommonLib.MessageDlgXP_Vista('There are no Batches seleted for printing.',mtInformation,[mbOk],0);
    Exit;
  end;

  s:= ProcTreePQABatchIdsToSLPQABatchIDs(s, TERPConnection (SalesOrder.Connection.Connection));

  if s = '' then begin
    CommonLib.MessageDlgXP_Vista('The Allocation is not correct. Please contact ERP',mtInformation,[mbOk],0);
    Exit;
  end;
    s:= SalesDispatchBarcodeSQL('' , '' , s  );
//    with TStringLIst.Create do begin
//      Text := s;
//      savetofile('c:\temp\temp1.sql');
//    end;
    fbReportSQLSupplied :=  TRue;
    ConnectionFormReport := TERPConnection(SalesOrder.connection.connection);
    Json:= JO;
    try
        Json.O['0'].S['master']:= 'Details';
        Json.O['0'].S['detail']:= 'RelatedParts';
        Json.O['0'].S['masterfields']:='PQADetailID';
        Json.O['0'].S['detailfields']:= 'slpqad.PQADetailID';
        PrintTemplateReport(TemplateToPrint('Sales Dispatch Barcode', chkChooseRpt.checked , 'Sales Dispatch Barcode')  , s , PrintReport(chkPreview) , 1 ,Json);
    finally
      Json.Free;
    end;

end;

procedure TfmSaleLineBatchAllocation.btnPrintunallocatedClick(Sender: TObject);
var
  s:String;
begin
  inherited;
  s := UnAllocatedBatchByPalletSQL(SalesOrder.ID, SalesOrder.Lines.ID, SalesOrder.Lines.ProductId, 1);
  fbReportSQLSupplied := TRue;
  PrintTemplateReport(TemplateToPrint('UnAllocatedSalesPallet', chkChooseRpt.checked , GetDefaultTemplate('UnAllocatedSalesPallet'))  , s , PrintReport(chkPreview) , 0 );
end;

procedure TfmSaleLineBatchAllocation.chkAllocatedClick(Sender: TObject);
var
  lbl: string;
begin
  inherited;
  lbl := 'Batch';
  if not chkAllocated.Focused then exit;
  if self.IsFlag('Allocate') then exit;
  self.AddFlag('Allocate');
  try
    if chkAllocated.Checked then begin
      if (SalesOrder is TSales) and TSales(SalesOrder).Converted then
        exit;
      SalesOrder.Lines.ManPQA.PQABatch.PostDb;
      SalesOrder.Lines.ManPQA.PQABatch.RefreshTotals;
      if ((not AppEnv.CompanyPrefs.UseCustFld1ForSaleLineBatchAllocation) and
          (SalesOrder.Lines.UOMQtyShipped <> SalesOrder.Lines.ManPQA.PQABatch.TotalUOMQty)) or
         ((AppEnv.CompanyPrefs.UseCustFld1ForSaleLineBatchAllocation) and
          (SalesOrder.Lines.UOMQtyShipped <> SalesOrder.Lines.ManPQA.PQABatch.TotalCUSTFLD1Qty))  then begin
        if AppEnv.CompanyPrefs.UseCustFld1ForSaleLineBatchAllocation then
          lbl := AppEnv.CompanyPrefs.PQADEtailsCUSTFLD1;
        case CommonLib.MessageDlgXP_Vista('Do you wish to update the Line Qty to match the Total '+lbl+' Allocation?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
          mrYes:
            begin
              if SalesOrder.Lines is TSalesLine then begin
                if AppEnv.CompanyPrefs.UseCustFld1ForSaleLineBatchAllocation then
                  TSalesLine(SalesOrder.Lines).Tree.QtyVariation := TSalesLine(SalesOrder.Lines).Tree.QtyVariation +
                    (SalesOrder.Lines.UOMQtyShipped - SalesOrder.Lines.ManPQA.PQABatch.TotalCUSTFLD1Qty)
                else
                  TSalesLine(SalesOrder.Lines).Tree.QtyVariation := TSalesLine(SalesOrder.Lines).Tree.QtyVariation +
                    (SalesOrder.Lines.UOMQtyShipped - SalesOrder.Lines.ManPQA.PQABatch.TotalUOMQty);
              end;

              if SalesOrder.Lines.ManPQA.PQABatch.TotalUOMQty > SalesOrder.Lines.UOMQtyShipped then begin
                if AppEnv.CompanyPrefs.UseCustFld1ForSaleLineBatchAllocation then begin
                  SalesOrder.Lines.UOMOrderQty := SalesOrder.Lines.ManPQA.PQABatch.TotalCUSTFLD1Qty;
                  SalesOrder.Lines.UOMQtyShipped := SalesOrder.Lines.ManPQA.PQABatch.TotalCUSTFLD1Qty;
                end
                else begin
                  SalesOrder.Lines.UOMOrderQty := SalesOrder.Lines.ManPQA.PQABatch.TotalUOMQty;
                  SalesOrder.Lines.UOMQtyShipped := SalesOrder.Lines.ManPQA.PQABatch.TotalUOMQty;
                end;
              end
              else begin
                if AppEnv.CompanyPrefs.UseCustFld1ForSaleLineBatchAllocation then begin
                  SalesOrder.Lines.UOMQtyShipped := SalesOrder.Lines.ManPQA.PQABatch.TotalCUSTFLD1Qty;
                  SalesOrder.Lines.UOMOrderQty := SalesOrder.Lines.ManPQA.PQABatch.TotalCUSTFLD1Qty;
                end
                else begin
                  SalesOrder.Lines.UOMQtyShipped := SalesOrder.Lines.ManPQA.PQABatch.TotalUOMQty;
                  SalesOrder.Lines.UOMOrderQty := SalesOrder.Lines.ManPQA.PQABatch.TotalUOMQty;
                end;
              end;

              if SalesOrder.Save then begin
                SalesOrder.Dirty := false;
                SalesOrder.Connection.CommitTransaction;
                Notify(false);
                if (fsModal in FormState) then
                  ModalResult := mrOk
                else
                  Self.Close;
              end
              else
                exit;
            end;
          mrNo:; { do nothing }
          mrCancel:
            begin
              chkAllocated.Checked := false;
              exit;
            end;
        end;


      end;
    end;
  finally
    self.RemoveFlag('Allocate');
  end;
end;

procedure TfmSaleLineBatchAllocation.cmdCancelClick(Sender: TObject);
begin
  inherited;
  if (fsModal in FormState) then
    ModalResult := mrCancel
  else
    Self.Close;
end;

procedure TfmSaleLineBatchAllocation.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  SalesOrder.Connection.CommitTransaction;
  Notify(false);
  if (fsModal in FormState) then
    ModalResult := mrOk
  else
    Self.Close;
end;

procedure TfmSaleLineBatchAllocation.cmdNewClick(Sender: TObject);
Procedure DoGridDatasetRefresh;
begin
          GridDataset.Refresh;
          SalesOrder.Lines.ManPQA.PQABatch.RefreshTotals;
          grdBatch.ColumnByName('UOMQty').FooterValue := FormatFloat('#0.00#',SalesOrder.Lines.ManPQA.PQABatch.TotalUOMQty);
          grdBatch.ColumnByName('BOUOMQty').FooterValue := FormatFloat('#0.00#',SalesOrder.Lines.ManPQA.PQABatch.TotalBOUOMQty);
          grdBatch.ColumnByName('CUSTFLD1').FooterValue := FormatFloat('#0.00#',SalesOrder.Lines.ManPQA.PQABatch.TotalCustFld1Qty);
          grdBatch.ColumnByName('CUSTFLD4').FooterValue := FormatFloat('#0.00#',SalesOrder.Lines.ManPQA.PQABatch.TotalCustFld4Qty);
end;
begin
  inherited;
  if SalesOrder.Lines.BatchAllocated then begin
    CommonLib.MessageDlgXP_Vista('Line is flagged as Allocated.', mtInformation, [mbOk], 0);
    exit;
  end;
  CAse DoBatch(0,SalesOrder.Lines, TERPConnection(SalesOrder.Connection.Connection), true, true) of
      mrok : begin
          DoGridDatasetRefresh;
        end;
      mrYesToAll : begin
          DoGridDatasetRefresh;
          Setcontrolfocus(chkAllocated);
          chkAllocated.checked := True;
        end;
      mrYes : begin
          DoGridDatasetRefresh;
          cmdNew.Click;
        end;
      mrCancel : begin
          DoGridDatasetRefresh;
      end;
  end;
end;

procedure TfmSaleLineBatchAllocation.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
begin
   inherited;
   if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
   end else if (Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterOpen) then begin
    if (Sender is TPQABatch) then InitAllocfieldNames;
   end;
end;

procedure TfmSaleLineBatchAllocation.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmSaleLineBatchAllocation.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ErrorOccurred then Exit;

  CanClose := false;
  if SalesOrder.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveRecord then begin
            CommitAndNotify;
            CanClose := true;
            Notify(false);
          end;
        end;
      mrNo:
        begin
          RollbackTransaction;
          SalesOrder.Dirty := false;
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

procedure TfmSaleLineBatchAllocation.FormCreate(Sender: TObject);
begin
  inherited;
  qryPQADetailCUSTFLD1.visible := Appenv.companyprefs.EnablePQADEtailsCUSTFLD1;
  qryPQADetailCUSTFLD1.displayLabel := Appenv.companyprefs.PQADEtailsCUSTFLD1;

  qryPQADetailCUSTFLD4.visible := Appenv.companyprefs.EnablePQADEtailsCUSTFLD4;
  qryPQADetailCUSTFLD4.displayLabel := Appenv.companyprefs.PQADEtailsCUSTFLD4;

end;

procedure TfmSaleLineBatchAllocation.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(SalesOrder);
end;

procedure TfmSaleLineBatchAllocation.FormShow(Sender: TObject);
var
  qry: TERPQuery;
  msg: string;
begin
  { NOTE: KeyId is SalesLineId }

  inherited;
  if KeyId > 0 then begin
    if not Assigned(SalesOrder) then begin
      qry := DbSharedObj.GetQuery(MyConnection);
      try
        qry.SQL.Add('select SaleId from tblsaleslines where SaleLineId = ' + IntToStr(KeyID));
        qry.Open;
        SalesOrder := TSalesOrder.CreateWithNewConn(self);
        SalesOrder.Connection.connection := Self.MyConnection;
        SalesOrder.BusObjEvent := DoBusinessObjectEvent;
        SalesOrder.Load(qry.FieldByName('SaleID').AsInteger);
        SalesOrder.Lines.LocateId(KeyId);
        SalesOrder.Lines.ManPQA.PQABatch;
        grdBatch.DataSource.DataSet := GridDataset;
        if not SalesOrder.LockTrans(msg) then begin
          CommonLib.MessageDlgXP_Vista('Unable to lock SalesOrder for editing: '+ msg, mtInformation, [mbOk], 0);
          AccessLevel := 5;
        end;
      finally
        DbSharedObj.ReleaseObj(qry);
      end;
    end;


  end;

  dsSale.DataSet := SalesOrder.Dataset;
  dsSaleLine.DataSet := SalesOrder.Lines.Dataset;
  SalesOrder.connection.BeginTransaction;
  OpenQueries;

  SalesOrder.Lines.ManPQA.PQABatch.RefreshTotals;
  grdBatch.ColumnByName('UOMQty').FooterValue := FormatFloat('#0.00#',SalesOrder.Lines.ManPQA.PQABatch.TotalUOMQty);
  grdBatch.ColumnByName('BOUOMQty').FooterValue := FormatFloat('#0.00#',SalesOrder.Lines.ManPQA.PQABatch.TotalBOUOMQty);
  grdBatch.ColumnByName('CUSTFLD1').FooterValue := FormatFloat('#0.00#',SalesOrder.Lines.ManPQA.PQABatch.TotalCustFld1Qty);

end;

function TfmSaleLineBatchAllocation.SaveRecord: Boolean;
begin
  result:= False;
  SalesOrder.Lines.PostDB;
  //SalesOrder.Lines.PQA.PQABatch.RefreshDB;
  SalesOrder.Lines.manPQA.PQABatch.RefreshDB;
  if (not SalesOrder.Lines.ValidateData) or (not SalesOrder.Lines.Save) then exit;
  SalesOrder.Dirty := false;
  Result:= True;
end;

procedure TfmSaleLineBatchAllocation.grdBatchDblClick(Sender: TObject);
begin
  inherited;
  if SalesOrder.Lines.BatchAllocated then
    exit;
  if GridDataset.RecordCount > 0 then begin
    case DoBatch(SalesOrder.Lines.ManPQA.PQABatch.ID, SalesOrder.Lines, TERPConnection(SalesOrder.Connection.Connection), true , True) of
    mrok : begin
          GridDataset.Refresh;
          SalesOrder.Lines.ManPQA.PQABatch.RefreshTotals;
          grdBatch.ColumnByName('UOMQty').FooterValue := FormatFloat('#0.00#',SalesOrder.Lines.ManPQA.PQABatch.TotalUOMQty);
          grdBatch.ColumnByName('BOUOMQty').FooterValue := FormatFloat('#0.00#',SalesOrder.Lines.ManPQA.PQABatch.TotalBOUOMQty);
          grdBatch.ColumnByName('CUSTFLD1').FooterValue := FormatFloat('#0.00#',SalesOrder.Lines.ManPQA.PQABatch.TotalCustFld1Qty);
        end;
    mrYesToAll : begin
          GridDataset.Refresh;
          SalesOrder.Lines.ManPQA.PQABatch.RefreshTotals;
          grdBatch.ColumnByName('UOMQty').FooterValue := FormatFloat('#0.00#',SalesOrder.Lines.ManPQA.PQABatch.TotalUOMQty);
          grdBatch.ColumnByName('BOUOMQty').FooterValue := FormatFloat('#0.00#',SalesOrder.Lines.ManPQA.PQABatch.TotalBOUOMQty);
          grdBatch.ColumnByName('CUSTFLD1').FooterValue := FormatFloat('#0.00#',SalesOrder.Lines.ManPQA.PQABatch.TotalCustFld1Qty);
            Setcontrolfocus(chkAllocated);
            chkAllocated.checked := True;
            //chkAllocatedClick(chkAllocated);
          end;
      mrYes : begin
          GridDataset.Refresh;
          SalesOrder.Lines.ManPQA.PQABatch.RefreshTotals;
          grdBatch.ColumnByName('UOMQty').FooterValue := FormatFloat('#0.00#',SalesOrder.Lines.ManPQA.PQABatch.TotalUOMQty);
          grdBatch.ColumnByName('BOUOMQty').FooterValue := FormatFloat('#0.00#',SalesOrder.Lines.ManPQA.PQABatch.TotalBOUOMQty);
          grdBatch.ColumnByName('CUSTFLD1').FooterValue := FormatFloat('#0.00#',SalesOrder.Lines.ManPQA.PQABatch.TotalCustFld1Qty);
        cmdNew.Click
      end;
    end;

  end;
end;

function TfmSaleLineBatchAllocation.GridDataset: TERPQuery;
begin
  Result := TERPQuery(SalesOrder.Lines.ManPQA.PQABatch.Dataset);
end;

procedure TfmSaleLineBatchAllocation.InitAllocfieldNames;
begin
  GridDataset.Fieldbyname('Value').displayLabel       := AppEnv.DefaultClass.AllocationBatchnoName;
  GridDataset.Fieldbyname('ExpiryDate').displayLabel  := AppEnv.DefaultClass.AllocationExpiryDateName;
  GridDataset.Fieldbyname('TruckLoadNo').displayLabel := AppEnv.DefaultClass.AllocationTruckLoadNoName;
end;

procedure TfmSaleLineBatchAllocation.qryPQADetailAfterOpen(DataSet: TDataSet);
begin
  inherited;
    qryPQADetailCUSTFLD1.visible := Appenv.companyprefs.EnablePQADEtailsCUSTFLD1;
    qryPQADetailCUSTFLD1.displayLabel := Appenv.companyprefs.PQADEtailsCUSTFLD1;

    qryPQADetailCUSTFLD4.visible := Appenv.companyprefs.EnablePQADEtailsCUSTFLD4;
    qryPQADetailCUSTFLD4.displayLabel := Appenv.companyprefs.PQADEtailsCUSTFLD4;

  if Appenv.companyprefs.EnablePQADEtailsCUSTFLD1 then TGridFieldList.AddField(grdBatch, qryPQADetailCUSTFLD1)
  else TGridFieldList.RemoveField(grdBatch, qryPQADetailCUSTFLD1);

  if Appenv.companyprefs.EnablePQADEtailsCUSTFLD4 then TGridFieldList.AddField(grdBatch, qryPQADetailCUSTFLD4)
  else TGridFieldList.RemoveField(grdBatch, qryPQADetailCUSTFLD4);
end;

procedure TfmSaleLineBatchAllocation.wwDBGrid1IButtonClick(Sender: TObject);
begin
  inherited;
  if GridDataset.RecordCount > 0 then begin
    if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this Batch Number?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
      SalesOrder.Lines.ManPQA.PQABatch.Delete;
      SalesOrder.Lines.ManPQA.PQABatch.PostDb;
      GridDataset.Refresh;
    end;
  end;
end;

initialization
  RegisterClass(TfmSaleLineBatchAllocation);
  with FormFact do begin
    RegisterMe(TfmSaleLineBatchAllocation, 'TUnallocatedBatchSalesListGUI_*_BOM Sales Order=SaleLineID');
  end;
end.
