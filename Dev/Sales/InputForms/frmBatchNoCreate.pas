unit frmBatchNoCreate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase , BusObjSalesBatches, Mask, wwdbedit,
  wwdbdatetimepicker, AdvEdit, Grids, Wwdbigrd, Wwdbgrid , BusObjSales, busobjPQA,
  wwclearbuttongroup, wwradiogroup ;

type
  TfmBatchNoCreate = class(TBaseInputGUI)
    pnltop: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    pnlSalesBatchRelated: TDNMPanel;
    dssaleaBatch: TDataSource;
    dsSalesBatchRelated: TDataSource;
    QrySalesBatchRelated: TERPQuery;
    DNMPanel4: TDNMPanel;
    Label1: TLabel;
    edtBatchSeqno: tDBEdit;
    pnlSeqno: TDNMPanel;
    edtSeqno: tDBEdit;
    QrySalesBatchRelatedID: TIntegerField;
    QrySalesBatchRelatedSaleLineId: TIntegerField;
    QrySalesBatchRelatedRelatedParentLineRef: TWideStringField;
    QrySalesBatchRelatedManPQADetailsId: TIntegerField;
    QrySalesBatchRelatedProductId: TIntegerField;
    QrySalesBatchRelatedProductName: TWideStringField;
    QrySalesBatchRelatedRelatedProductQty: TFloatField;
    QrySalesBatchRelatedSalesRelatedProductQty: TFloatField;
    QrySalesBatchRelatedmstimestamp: TDateTimeField;
    QrySalesBatchRelatedmsupdatesitecode: TWideStringField;
    QrySalesBatchRelatedUom: TWideStringField;
    QrySalesBatchRelateddateCreated: TDateTimeField;
    grdSalesBatchRelated: TwwDBGrid;
    QrySalesBatchRelatedProductDescription: TWideStringField;
    QrySalesBatchRelatedUOMID: TIntegerField;
    QrySalesBatchRelatedUOMWeight: TFloatField;
    QrySalesBatchRelatedTotalWeight: TFloatField;
    QrySalesBatchRelatedUOMMult: TFloatField;
    QryUOM: TERPQuery;
    dsUOM: TDataSource;
    QryUOMunitId: TIntegerField;
    QryUOMweight: TFloatField;
    QryUOMtotalWeight: TFloatField;
    dsPQA: TDataSource;
    qrySales: TERPQuery;
    dsSales: TDataSource;
    qrySalesPONumber: TWideStringField;
    DNMPanel9: TDNMPanel;
    Label7: TLabel;
    DBEdit1: TDBEdit;
    qrySalessaleId: TIntegerField;
    pnlFooter: TDNMPanel;
    cmdCancel: TDNMSpeedButton;
    btnfinalise: TDNMSpeedButton;
    btnPrintunallocated: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    cmdClose: TDNMSpeedButton;
    pnlWeight: TDNMPanel;
    pnlAdvPrinting: TDNMPanel;
    ChkChooseRpt: TCheckBox;
    chkPreview: TCheckBox;
    chkShowBOQuantity: TCheckBox;
    chkShowExpiry: TCheckBox;
    DNMPanel3: TDNMPanel;
    Label4: TLabel;
    edtCUSTFLD5: TDBEdit;
    btnContacts: TDNMSpeedButton;
    btnNextPallet: TDNMSpeedButton;
    DNMPanel8: TDNMPanel;
    Label6: TLabel;
    edtNetWeight: TwwDBEdit;
    DNMPanel11: TDNMPanel;
    Label8: TLabel;
    edtTotalWeight: TwwDBEdit;
    pnlBatch: TDNMPanel;
    lblBatchNo: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    edtBatchNo: TDBEdit;
    edtWeight: TDBEdit;
    edtBatchQty: TDBEdit;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    DNMPanel1: TDNMPanel;
    Label9: TLabel;
    pnlUOMDetails: TDNMPanel;
    lblUOMDetails: TLabel;
    DNMPanel5: TDNMPanel;
    pnlLabels: TDNMPanel;
    DNMPanel12: TDNMPanel;
    lblUnits: TLabel;
    DNMPanel13: TDNMPanel;
    lblUOM: TLabel;
    DNMPanel14: TDNMPanel;
    pnlExpiryDate: TDNMPanel;
    DNMPanel16: TDNMPanel;
    wwDBDateTimePicker1: TwwDBDateTimePicker;
    DNMPanel17: TDNMPanel;
    lblExpiryDate: TLabel;
    pnlBOQty: TDNMPanel;
    DNMPanel22: TDNMPanel;
    edtBOQty: TDBEdit;
    DNMPanel23: TDNMPanel;
    edtUOMBOQty: TDBEdit;
    DNMPanel24: TDNMPanel;
    Label5: TLabel;
    pnlQty: TDNMPanel;
    DNMPanel25: TDNMPanel;
    edtUOMQty: TDBEdit;
    DNMPanel26: TDNMPanel;
    lblQty: TLabel;
    DNMPanel27: TDNMPanel;
    edtQty: TDBEdit;
    DNMPanel6: TDNMPanel;
    lblRelatedQtybasedon: TLabel;
    grpFilters: TwwRadioGroup;
    DNMPanel2: TDNMPanel;
    pnlcustFld1: TDNMPanel;
    pnlcustfld4: TDNMPanel;
    lblPQADEtailsCUSTFLD4: TLabel;
    edtPQACUSTFLD4: TDBEdit;
    EdtPQACUSTFLD1: TDBEdit;
    lblPQADEtailsCUSTFLD1: TLabel;
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure chkShowBOQuantityClick(Sender: TObject);
    procedure chkShowExpiryClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdSalesBatchRelatedCalcTitleAttributes(Sender: TObject;
      AFieldName: string; AFont: TFont; ABrush: TBrush;
      var ATitleAlignment: TAlignment);
    procedure grpFiltersClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnfinaliseClick(Sender: TObject);
    procedure QrySalesBatchRelatedBeforeOpen(DataSet: TDataSet);
    procedure QrySalesBatchRelatedCalcFields(DataSet: TDataSet);
    procedure grdSalesBatchRelatedCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure btnContactsClick(Sender: TObject);
    procedure edtCUSTFLD5Exit(Sender: TObject);
    procedure btnNextPalletClick(Sender: TObject);
    procedure btnPrintunallocatedClick(Sender: TObject);
    procedure edtBatchQtyExit(Sender: TObject);
    procedure edtTotalWeightEnter(Sender: TObject);
    procedure edtTotalWeightExit(Sender: TObject);
    procedure edtBatchQtyEnter(Sender: TObject);
    procedure edtBatchQtyChange(Sender: TObject);
    procedure edtTotalWeightChange(Sender: TObject);
    procedure edtNetWeightChange(Sender: TObject);
    procedure edtNetWeightEnter(Sender: TObject);
    procedure edtNetWeightExit(Sender: TObject);
  private
    SalesBatchRelated: TSalesBatches;
    fisaleId: Integer;
    fiSaleLineId: Integer;
    fsSaleLineref: String;
    fSaleLine: TSalesOrderLine;
    fiManPQADetailsId: Integer;
    fsRelatedParentLineRef :String;
//    fdBatchQtyPercent :Double;
    DoPrintSalesDispatchBarcode :Boolean;
    fpqa: TPQA;
    fBusObjEvent  : TBusObjEvent;
    fdsaleQty :Double;
    fiParentProductID :Integer;
    fEnableFinaliseSales: Boolean;
    fEnableNew: Boolean;
    fdTotalWeight:Double;
    UpdatingSalesBatchRelated:Boolean;
    fdCleanGrossWeight :Double;
    fdCleanNetWeight :Double;
    fdCleanQty :Double;
    fbGrossWeighttoQty :Boolean;
    //fiIterateProcno :Integer;
    fbCalculatingWeight : Boolean;

    function SaveRecord: Boolean;
    procedure NewBusObjinstance;
    procedure SetSaleLine(const Value: TSalesOrderLine);
    Procedure MakeRelatedItems(const Sender: TBusObj; var Abort: Boolean);
    Procedure UpdateQty(const Sender: TBusObj; var Abort: Boolean);

    function PQA: TPQA;
    procedure Panels;
    procedure PrintSalesDispatchBarcode;
    procedure ReadnApplyGuiPref;
    function SaveData: Boolean;
    procedure UpdatesalesQty;
    procedure NewBatch;
    procedure OpenSalesBatchRelated;
    procedure SetEnableFinaliseSales(const Value: Boolean);
    procedure SetEnableNew(const Value: Boolean);
    procedure OpenExtraQuries;
    procedure CalcWeight;
    procedure CalcnshowFooter;
    procedure CalcnshowFooterCallback(const Sender: TBusObj;
      var Abort: Boolean);
    procedure initform;
    procedure intTransPalletsList(Sender: TObject);
    procedure onSelectPallet(Sender: TwwDbGrid);
    function PalletNo(Nextno :Boolean =False): String;
    function GrossWeight :Double;
    function NetWeight :Double;
    Procedure GrossWeighttoQty;
    Procedure NetWeighttoQty;
    function IsGrossEntered:Boolean ;
    function IsNetEntered:Boolean ;
    procedure SetPQAbatchQty(const Value: Double);
    procedure QtyGrossWeight;
    procedure QtyNetWeight;
    //procedure QtytoGrossWeight;
    //procedure QtytoNetWeight;
    function ReCalculateQty(ChangingQty: double): Boolean;
    procedure ShowBatchNetnGross;
    procedure initforSelectedSaleLine;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    Property ManPQADetailsId :Integer read fiManPQADetailsId write fiManPQADetailsId;
    Property SaleLine: TSalesOrderLine read fSaleLine write SetSaleLine;
    Property SaleId :Integer read fisaleId write fiSaleId;
    Property SaleLineId :Integer read fiSaleLineId write fiSaleLineId;
    Property SaleLineref :String read fsSaleLineref write fsSaleLineref;
    Property EnableFinaliseSales :Boolean read fEnableFinaliseSales write SetEnableFinaliseSales;
    Property EnableNew :Boolean read fEnableNew write SetEnableNew;
  end;

function DoBatch(aManPQADetailsId: integer; aSaleLine: TSalesOrderLine;fconn :TERPConnection; aEnableFinaliseSales :Boolean; aEnableNew :Boolean): TModalResult;

implementation

uses CommonLib, BusObjConst, AppEnvironment , CommonDbLib, DbSharedObjectsObj,
  BusObjSaleBase, BusobjUOM, saleslib, CommonFormLib, tcConst, tcDataUtils,
  JSONObject, TransPallets , StringUtils ,math, LogLib, BusObjProcPrefs;

{$R *.dfm}
Procedure TfmBatchNoCreate.Panels;
begin
  pnlExpiryDate.Left :=0;
  pnlcustfld4.Left :=0;
  pnlcustFld1.Left :=0;
  pnlBOQty.Left :=0;
  pnlQty.Left :=0;
  pnlLabels.Left :=0;
end;
Function TfmBatchNoCreate.PQA:TPQA;
begin
  REsult := nil;
  try
    if fpqa = nil then begin
      if (SaleLine is TSalesOrderLine) and (TSalesOrderLine(SaleLine).manPQA.count <> 0) then begin
        fPQa :=TSalesOrderLine(SaleLine).manPQA;
        exit;
      end;
      fPQa :=SaleLine.PQA;
    end;
  finally
    result := fpqa;
  end;
end;

procedure TfmBatchNoCreate.btnContactsClick(Sender: TObject);
begin
  inherited;
  OpenERPListFormSingleselectModal('TTransPalletsGUI' , onSelectPallet, intTransPalletsList );
end;
procedure TfmBatchNoCreate.intTransPalletsList(Sender: TObject);
begin
   if sender is TTransPalletsGUI then begin
     TTransPalletsGUI(Sender).transId := PQA.TransId;
     TTransPalletsGUI(Sender).transtype := PQA.TransType;
   end;
end;
function TfmBatchNoCreate.IsGrossEntered: Boolean;
begin
  result := GuiPrefs.Node.Exists('Options.Entrypoint')     and (GuiPrefs.Node['Options.Entrypoint'].asInteger = 2) ;
end;
function TfmBatchNoCreate.IsNetEntered: Boolean;
begin
  result := GuiPrefs.Node.Exists('Options.Entrypoint')     and (GuiPrefs.Node['Options.Entrypoint'].asInteger = 3) ;
end;

procedure TfmBatchNoCreate.onSelectPallet(Sender: TwwDbGrid);
begin
  PQa.pqabatch.CustFld5:= Sender.DataSource.DataSet.fieldbyname('Pallet').asString;
  PQa.pqabatch.PostDB;
end;
procedure TfmBatchNoCreate.btnfinaliseClick(Sender: TObject);
begin
  inherited;
  if not SaveData then exit;
  SaleLine.Connection.CommitNestedTransaction;
  ModalResult := mrYesToAll;

  (*if Assigned(EnableFinaliseSales) then begin
    SaleLine.Connection.CommitTransaction;
    EnableFinaliseSales(Sender);
    ModalResult := mrOK;
  end;*)
end;

procedure TfmBatchNoCreate.btnNewClick(Sender: TObject);
begin
  inherited;
(*  if not SaveData then exit;
  SaleLine.Connection.CommitNestedTransaction;
  SaleLine.Connection.CommitTransaction;
  SaleLine.Connection.BeginTransaction;
  SaleLine.Connection.BeginNestedTransaction;
  NewBatch;
  OpenSalesBatchRelated;
  Setcontrolfocus(edtBatchQty);*)
  if not SaveData then exit;
  SaleLine.Connection.CommitNestedTransaction;
  ModalResult := mrYes;
end;

procedure TfmBatchNoCreate.btnNextPalletClick(Sender: TObject);
begin
  inherited;
  try PQA.PQABatch.CustFld5 := PalletNo(true) ;PQA.PQABatch.PostDB;Except end;
end;

procedure TfmBatchNoCreate.btnPrintunallocatedClick(Sender: TObject);
var
  s:String;
begin
  inherited;
  s := UnAllocatedBatchByPalletSQL(SaleLine.SaleId, SaleLine.Id, SaleLine.ProductId, 1);
  fbReportSQLSupplied := TRue;
  PrintTemplateReport(TemplateToPrint('UnAllocatedSalesPallet', chkChooseRpt.checked , GetDefaultTemplate('UnAllocatedSalesPallet'))  , s , PrintReport(chkPreview) , 0 );

end;

procedure TfmBatchNoCreate.chkShowBOQuantityClick(Sender: TObject);
begin
  inherited;
  pnlBOQty.visible := chkShowBOQuantity.Checked;
  Panels;
end;

procedure TfmBatchNoCreate.chkShowExpiryClick(Sender: TObject);
begin
  inherited;
  pnlExpiryDate.visible := chkShowExpiry.Checked;
  Panels;
end;

procedure TfmBatchNoCreate.cmdCancelClick(Sender: TObject);
begin
  inherited;
  PQA.PQABatch.CancelDb;
  SaleLine.Connection.RollbackNestedTransaction;
  ModalResult := mrCancel;
end;

Function TfmBatchNoCreate.SaveRecord :Boolean;
begin
  result:= False;
  if PQa.pqabatch.batchno = '' then begin
    MessageDlgxP_Vista('Please Provide a Batch No', mtWarning, [mbOK], 0);
    Exit;
  end;
  if PQa.pqabatch.Qty =0 then begin
    MessageDlgxP_Vista('Please Provide the Batch Quantity', mtWarning, [mbOK], 0);
    Exit;
  end;
  SalesBatchRelated.PostDB;
  if not(SalesBatchRelated.Save) then exit;
  Result:= True;

end;
Function TfmBatchNoCreate.PalletNo(Nextno :Boolean =False):String;
var
  qry: TERPQuery;
begin
  Result := '';
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(PQA.Connection.connection);
  try
    closedb(qry);
    qry.sql.text := 'Select Max(convert(CustFLD5 , DECIMAL)) CustFLD5 from tblpqadetails where pqaid = ' + inttostr(PQA.ID)+' and IsNumber(CustFLD5)';
    Opendb(qry);
    if (qry.recordcount >0) and (qry.fieldbyname('CustFLD5').asFloat <> 0 ) then begin
      Result := qry.fieldbyname('CustFLD5').AsString;
      if Nextno then REsult := incstr(REsult );
      exit;
    end;

    closedb(qry);
    qry.sql.text := 'Select CustFLD5 from tblpqadetails where pqaid = ' + inttostr(PQA.ID)+' and IsNumber(CustFLD5)  order by CUSTFLD5 desc limit 1';
    Opendb(qry);
    if (qry.recordcount >0)  and (qry.fieldbyname('CustFLD5').asString <> '' )  then begin
      Result := qry.fieldbyname('CustFLD5').AsString;
      if Nextno then REsult := incstr(REsult );
      exit;
    end;
    if result = '' then Result := incstr(edtCUSTFLD5.text);
    if result = '' then REsult :='1';

  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

Procedure TfmBatchNoCreate.NewBatch;
var
  newBatchNo: string;
begin
          newBatchNo := PQA.PQABatch.NextSeqBatchNo;
          PQA.PQABatch.New;
          PQA.PQABatch.BatchNo := newBatchNo;
          PQA.PQABatch.ExpiryDate := Date;
          PQA.PQABatch.Qty := 0;
          try PQA.PQABatch.CustFld3 := strToint(GetSequenceNumber(Self.Classname));Except end;
          try PQA.PQABatch.CustFld5 := PalletNo ;Except end;
          PQA.PQABatch.POStdb;
          fiManPQADetailsId :=PQA.PQABatch.ID;
end;
Procedure TfmBatchNoCreate.OpenExtraQuries;
begin
  closedb(QryUOM);
  QryUOM.SQL.Clear;
  QryUOM.SQL.text := 'Select unitId , weight from tblunitsofmeasure U where U.UnitID =  ' + inttostr(PQA.UnitOfMeasureID);
  Opendb(QryUOM);
  CalcWeight;

  closedb(qrySales);
  qrySales.parambyname('SaleId').asInteger := PQA.transId;
  Opendb(qrySales);

end;
Procedure TfmBatchNoCreate.OpenSalesBatchRelated;
begin
    dsPQA.dataset := PQA.dataset;
    dssaleaBatch.dataset := PQA.PQABatch.dataset;

    OpenExtraQuries;

    SalesBatchRelated.LoadSelect('ManPQADetailsId = '+ inttostr(PQA.PQABatch.ID));

    if SalesBatchRelated.count =0 then begin
      if fSaleLine.HasRelatedProducts then begin
        fsRelatedParentLineRef :=fSaleLine.Globalref;
        fiManPQADetailsId := PQA.PQABatch.ID;
        UpdatingSalesBatchRelated:=true;
        try
          fSaleLine.IterateRecords(MakeRelatedItems);
        finally
          UpdatingSalesBatchRelated:= False;
        end;

      end;
    end;

    if SalesBatchRelated.count =0 then begin
      grdSalesBatchRelated.Visible := False;
      Self.height := 383;
      //Self.Height := Self.Height - grdSalesBatchRelated.Height;
    end;

end;
procedure TfmBatchNoCreate.SetEnableFinaliseSales(const Value: Boolean);
begin
  fEnableFinaliseSales := Value;
  btnfinalise.Enabled := Value;
end;
procedure TfmBatchNoCreate.SetEnableNew(const Value: Boolean);
begin
  fEnableNew := Value;
  btnNew.Enabled := Value;
end;

procedure TfmBatchNoCreate.SetSaleLine(const Value: TSalesOrderLine);
begin
    fSaleLine := Value;
end;
procedure TfmBatchNoCreate.initforSelectedSaleLine;
begin
    fBusObjEvent := fSaleLine.BusObjEvent;
    fSaleLine.BusObjEvent :=DoBusinessObjectEvent;

    lblUOM.Caption := PQA.UnitOfMeasure;
    lblUnits.Caption := TUnitOfMeasure.UOMBaseUOM(PQA.UnitOfMeasureID);
    lblUOMDetails.Caption := TUnitOfMeasure.UOMDetails(PQA.UnitOfMeasureID);


      if (fiManPQADetailsId > 0 ) and (PQA.PQABatch.ID = fiManPQADetailsId) then
      else if (fiManPQADetailsId > 0 ) and (PQA.PQABatch.ID <> fiManPQADetailsId ) and (PQA.PQABatch.LocateId(fiManPQADetailsId)) then
      else NewBatch;

      OpenSalesBatchRelated;

   if not(sametext(PQA.UnitOfMeasure , Appenv.DefaultClass.DefaultUOM)) or (PQA.UOMMultiplier <>1) then begin
    lblUnits.visible := true ;
    edtQty.visible := true ;
    edtBOQty.visible := true ;
    lblUOMDetails.visible := true ;
   end else begin
    lblUnits.visible := False;
    edtQty.visible := False ;
    edtBOQty.visible := False;
    lblUOMDetails.visible := False;
   end;

end;
Procedure TfmBatchNoCreate.MakeRelatedItems(const Sender: TBusObj; var Abort: Boolean);
begin
  if Sender is TSalesLine then begin
    if TSalesLine(Sender).RelatedParentLineRef = fsRelatedParentLineRef then begin
      SalesBatchRelated.New;
      SalesBatchRelated.SaleLineId            := TSalesLine(Sender).ID;
      SalesBatchRelated.RelatedParentLineRef  := fsRelatedParentLineRef;
      SalesBatchRelated.ProductId             := TSalesLine(Sender).ProductId;
      SalesBatchRelated.ProductName           := TSalesLine(Sender).ProductName;
      SalesBatchRelated.ProductDescription    := TSalesLine(Sender).ProductDescription;
      SalesBatchRelated.Uom                   := TSalesLine(Sender).UnitOfMeasure + ' (' + floattostr(TSalesLine(Sender).UOMMultiplier)+')';
      SalesBatchRelated.UOMID                 := TSalesLine(Sender).UnitOfMeasureID;
      SalesBatchRelated.UOMMult               := TSalesLine(Sender).UOMMultiplier;
      SalesBatchRelated.UOMWeight             := TSalesLine(Sender).SalesLinesUOMDetails.Weight;
      SalesBatchRelated.ManPQADetailsId       := fiManPQADetailsId;
      SalesBatchRelated.RelatedProductQty     := 0;
      SalesBatchRelated.SalesRelatedProductQty:= TSalesLine(Sender).RelatedProductQty;
      SalesBatchRelated.PostDb;
    end;
  end;
end;

procedure TfmBatchNoCreate.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveData then exit;
  SaleLine.Connection.CommitNestedTransaction;
  ModalResult := mrOk;
end;
Function TfmBatchNoCreate.SaveData :Boolean;
var
  fiSaleLineId :Integer;
begin
  REsult := False;
  PQA.PQAbatch.postdb;
  PQA.PostDb;
  if not PQA.Save then exit;
  if SalesBatchRelated.count > 0 then begin
    SalesBatchRelated.PostDB;
    fiSaleLineId :=fSaleLine.ID;
    try
      UpdatesalesQty;
    finally
      if fSaleLine.Id <>  fiSaleLineId then
        fSaleLine.Locate(fSaleLine.Idfieldname , fiSaleLineId , []);
    end;
  end;


  REsult := True;
end;
Procedure TfmBatchNoCreate.UpdatesalesQty;
var
  Qry :TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(fSaleLine.Connection.Connection);
  try
    qry.SQL.text := 'Select SaleLineId , Sum(RelatedProductQty) as RelatedProductQty from tblsalesbatches where RelatedParentLineRef = '+ Quotedstr(fSaleline.Globalref)+' group by  SaleLineId ';
    qry.open;
    if qry.recordcount > 0 then begin
      qry.first;
      while qry.Eof = False do begin
          if fSaleLine.Locate(fSaleLine.IDfieldname , Qry.fieldbyname('SaleLineId').asInteger , []) then begin
            if fSaleLine.UomQtysold <  Qry.fieldbyname('RelatedProductQty').asfloat then
              fSaleLine.UomQtysold  :=Qry.fieldbyname('RelatedProductQty').asfloat;
            if fSaleLine.UomQtyShipped <  Qry.fieldbyname('RelatedProductQty').asfloat then
              fSaleLine.UomQtyShipped  :=Qry.fieldbyname('RelatedProductQty').asfloat;
            fSaleLine.PostDb;
          end;
        qry.Next;
      end;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
procedure TfmBatchNoCreate.edtNetWeightChange(Sender: TObject);
begin
  inherited;
  if screen.ActiveControl = edtTotalWeight then GuiPrefs.Node['Options.Entrypoint'].asInteger := 3;
end;

procedure TfmBatchNoCreate.edtNetWeightEnter(Sender: TObject);
begin
  inherited;
  fdCleanNetWeight := NetWeight;
end;

procedure TfmBatchNoCreate.edtNetWeightExit(Sender: TObject);
begin
  inherited;
  if not(Samevalue(fdCleanNetWeight , NetWeight , SameValue_GeneralRound)) then begin
    GuiPrefs.Node['Options.Entrypoint'].asInteger := 3;
    PQA.PQABatch.CUSTFLD7 :=NetWeight;
    NEtWeighttoQty;
  end;

end;

procedure TfmBatchNoCreate.cmdNewClick(Sender: TObject);
begin
  inherited;
  DoPrintSalesDispatchBarcode := TRue;
  cmdClose.Click;
end;

Procedure TfmBatchNoCreate.CalcWeight;
begin
  if fbCalculatingWeight then exit;
  fbCalculatingWeight := True;
  try
             if QryUOM.active then begin
              EditDb(QryUOM);
              QryUOMtotalWeight.AsFloat := PQA.PQABatch.uomqty*//  SalesBatchRelated.RelatedProductQty*
                                           QryUOMweight.AsFloat;
             end;
  finally
    fbCalculatingWeight := False;
  end;
end;
procedure TfmBatchNoCreate.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
     if Assigned(fBusObjEvent) then fBusObjEvent(Sender , eventType, value);
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TSalesBatches then TSalesBatches(Sender).Dataset := QrySalesBatchRelated;
     end;
    if  (Sender is TPQABatch) then begin
      if((( Eventtype = BusobjEvent_Event) or ( Value = BusObjEventDataset_AfterOpen)) Or
             (( Eventtype = BusobjEvent_Event) or ( Value = BusObjEventDataset_AfterPost)) ) then begin
             calcWeight;
      end;
     if  (( Value = BusObjEvent_QtyChanged) or ( Value = BusObjEvent_CustFld4Changed)) then begin
        if not UpdatingSalesBatchRelated  then begin
            Sender.postdb;

            if IsGrossEntered then begin
              GrossWeighttoQty;
            end else begin
                if grpFilters.ItemIndex =0 then fdsaleQty := PQA.PQABatch.Qty
                else begin
                  fdsaleQty := PQA.PQABatch.CUSTFLD4;
                  if fdsaleQty =0 then fdsaleQty := PQA.PQABatch.Qty;
                end;
                fiParentProductID :=PQA.ProductId;
                UpdatingSalesBatchRelated := True;
                try
                  //if PQA.PQABatch.CUSTFLD6 =0 then PQA.PQABatch.CUSTFLD6 := QryUOMtotalWeight.AsFloat;
                  SalesBatchRelated.IterateRecords(UpdateQty);
                finally
                  UpdatingSalesBatchRelated := False;
                end;
            end;
        end;
     end;


    end;

     if (Sender is Tsalesbatches)  then begin
        if not(UpdatingSalesBatchRelated)  and (Value = BusObjEvent_QtyChanged+'_RelatedProductQty')  then begin
          UpdatingSalesBatchRelated := true;
          try
              if MessageDlgXP_Vista('Product Qty Changed for ' + SalesBatchRelated.ProductName+'.' +NL+'Do you wish to Keep it?', mtconfirmation, [mbyes, mbno], 0) =mrno then
                    SalesBatchRelated.Canceldb
              else begin
                SalesBatchRelated.PostDB;
                UpdatingSalesBatchRelated:= False;
                CalcnshowFooter;
              end;
                          (*          else if IsGrossEntered then begin
                                      SalesBatchRelated.PostDB;
                                      CalcnshowFooter;
                                      PQA.PQABatch.CUSTFLD6
                                    end;
                                    end;*)
          finally
            UpdatingSalesBatchRelated:= False;
          end;

    end;

        if ( Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterOpen)   then
                ShowBatchNetnGross;
        if ( Eventtype = BusobjEvent_Event) and(Value = BusObjEventDataset_AfterPost)  then
             CalcnshowFooter;

     end;

end;
Procedure TfmBatchNoCreate.ShowBatchNetnGross;
begin
  if ProcPrefs.RoundBatchQtyinProgressBatchCreator  then
       edtTotalWeight.text := FloatToStrF(trunc(PQA.PQABatch.CUSTFLD6), ffGeneral, 15, 2)
  else edtTotalWeight.text := FloatToStrF(PQA.PQABatch.CUSTFLD6, ffGeneral, 15, 2);

  if ProcPrefs.RoundBatchQtyinProgressBatchCreator  then
       edtNetWeight.text := FloatToStrF(trunc(PQA.PQABatch.CUSTFLD7), ffGeneral, 15, 2)
  else edtNetWeight.text := FloatToStrF(PQA.PQABatch.CUSTFLD7, ffGeneral, 15, 2);

          {
          if ProcPrefs.RoundBatchQtyinProgressBatchCreator  then
                         edtTotalWeight.text := FloatToStrF(trunc((*fdTotalWeight +  QryUOMtotalWeight.AsFloat*)PQA.PQABatch.CUSTFLD6), ffGeneral, 15, 2)
          else edtTotalWeight.text := FloatToStrF((*fdTotalWeight +  QryUOMtotalWeight.AsFloat*)PQA.PQABatch.CUSTFLD6, ffGeneral, 15, 2);

          if ProcPrefs.RoundBatchQtyinProgressBatchCreator  then
               edtTotalWeight.text := FloatToStrF(trunc(fdTotalWeight +  QryUOMtotalWeight.AsFloat), ffGeneral, 15, 2)
          else edtTotalWeight.text := FloatToStrF(fdTotalWeight +  QryUOMtotalWeight.AsFloat, ffGeneral, 15, 2);

          if ProcPrefs.RoundBatchQtyinProgressBatchCreator  then
               edtTotalWeight.text := FloatToStrF(trunc((*fdTotalWeight +  QryUOMtotalWeight.AsFloat*)PQA.PQABatch.CUSTFLD6), ffGeneral, 15, 2)
          else edtTotalWeight.text := FloatToStrF((*fdTotalWeight +  QryUOMtotalWeight.AsFloat*)PQA.PQABatch.CUSTFLD6, ffGeneral, 15, 2);}

end;
procedure TfmBatchNoCreate.edtBatchQtyChange(Sender: TObject);
begin
  inherited;
  if screen.ActiveControl = edtBatchQty then GuiPrefs.Node['Options.Entrypoint'].asInteger := 1;
end;

procedure TfmBatchNoCreate.edtBatchQtyEnter(Sender: TObject);
begin
  inherited;
  fdCleanQty := PQA.PQAbatch.uomqty;
end;


procedure TfmBatchNoCreate.edtCUSTFLD5Exit(Sender: TObject);
begin
  inherited;
  PQa.pqabatch.PostDB;
end;

procedure TfmBatchNoCreate.edtTotalWeightChange(Sender: TObject);
begin
  inherited;
  if screen.ActiveControl = edtTotalWeight then GuiPrefs.Node['Options.Entrypoint'].asInteger := 2;
end;

procedure TfmBatchNoCreate.edtTotalWeightEnter(Sender: TObject);
begin
  inherited;
  fdCleanGrossWeight := GrossWeight;
end;

Procedure TfmBatchNoCreate.CalcnshowFooter;
begin
  if UpdatingSalesBatchRelated then exit;

  UpdatingSalesBatchRelated := True;
  try

        fdTotalWeight := 0;
        SalesBatchRelated.iteraterecords(CalcnshowFooterCallback);

        grdSalesBatchRelated.ColumnByName('TotalWeight').FooterValue := FloatToStrF(fdTotalWeight, ffGeneral, 15, 2);
        grdSalesBatchRelated.ColumnByName('RelatedProductQty').FooterValue := 'Total :';


        (*if not(IsGrossEntered) then begin
          if (PQA.PQABatch.uomqty <> 0)  then begin
                    PQA.PQABatch.CUSTFLD6 := QryUOMtotalWeight.AsFloat + fdTotalWeight ;
                    PQA.PQABatch.PostDB;
          end;
          ShowBatchNetnGross;
        end else begin
          if (PQA.PQABatch.CUSTFLD6<> 0) and (QryUOMweight.AsFloat<>0) then begin
                    {PQA.PQABatch.uomqty:= }SetPQAbatchQty(DivZer(PQA.PQABatch.CUSTFLD6 - fdTotalWeight , QryUOMweight.AsFloat));
                    PQA.PQABatch.PostDB;
          end;
          ShowBatchNetnGross;

        end;*)
        PQA.PQABatch.PostDB;
        ShowBatchNetnGross;
  finally
    UpdatingSalesBatchRelated := False;
  end;

end;
Procedure TfmBatchNoCreate.CalcnshowFooterCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if sender is Tsalesbatches then begin
     fdTotalWeight := fdTotalWeight + QrySalesBatchRelatedTotalWeight.asFloat;
  end;
end;
Procedure TfmBatchNoCreate.UpdateQty(const Sender: TBusObj; var Abort: Boolean);
begin
  if sender is Tsalesbatches then begin
      Tsalesbatches(Sender).RelatedProductQty := round(tcdatautils.AutoRoundRelatedQty(fdsaleQty, fiParentProductID , Tsalesbatches(Sender).ProductID) , TcConst.GeneralRoundPlaces);
      Tsalesbatches(Sender).PostDb;
  end;
end;
procedure TfmBatchNoCreate.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  GuiPrefs.Node['Options.ShowExpiry'].asBoolean     := chkShowExpiry.checked      ;
  GuiPrefs.Node['Options.ShowBOQuantity'].asBoolean := chkShowBOQuantity.checked  ;
  GuiPrefs.Node['Options.ChooseRpt'].asBoolean      := chkChooseRpt.checked       ;
  GuiPrefs.Node['Options.Preview'].asBoolean        := chkPreview.checked         ;
  GuiPrefs.Node['Options.grpFilters'].asInteger     := grpFilters.ItemIndex;
  fbIsLocalPrefChanged:= True;
  fSaleLine.BusObjEvent := fBusObjEvent;
  inherited;
end;

procedure TfmBatchNoCreate.FormCreate(Sender: TObject);
  Procedure lblhintncaption(Const lbl:TLabel ; value:String);
  begin
    lbl.caption := Value;
    Showcontrolhint(lbl, value);
  end;
begin
  inherited;
  fbCalculatingWeight := False;
  //fiIterateProcno := 0;
  fbTabSettingEnabled := False;
  fdCleanGrossWeight :=0;
  fdCleanNetWeight :=0;
  fdCleanQty :=0;
  fbGrossWeighttoQty := False;
  UpdatingSalesBatchRelated:= False;
  fEnableFinaliseSales :=False;
  fEnableNew :=False;

(*  pnlFooter.height := 450;
  grdSalesBatchRelated.height := 320;*)

  NewBusObjinstance;
  fPQA:=nil;
  lblhintncaption(lblBatchNo, AppEnv.DefaultClass.AllocationBatchnoName);
  lblhintncaption(lblExpiryDate,AppEnv.DefaultClass.AllocationExpiryDateName);
  DoPrintSalesDispatchBarcode := False;
  lblhintncaption(lblPQADEtailsCUSTFLD1,Appenv.CompanyPrefs.PQADEtailsCUSTFLD1);
  lblPQADEtailsCUSTFLD1.Enabled := Appenv.CompanyPrefs.EnablePQADEtailsCUSTFLD1;
  EdtPQACUSTFLD1.Enabled        := Appenv.CompanyPrefs.EnablePQADEtailsCUSTFLD1;

  lblhintncaption(lblPQADEtailsCUSTFLD4,Appenv.CompanyPrefs.PQADEtailsCUSTFLD4);
  lblPQADEtailsCUSTFLD4.Enabled := Appenv.CompanyPrefs.EnablePQADEtailsCUSTFLD4;
  EdtPQACUSTFLD4.Enabled        := Appenv.CompanyPrefs.EnablePQADEtailsCUSTFLD4;
  initform;
end;

procedure TfmBatchNoCreate.FormShow(Sender: TObject);
begin
  inherited;
  ReadnApplyGuiPref;
  Setcontrolfocus(edtUOMQty);
  grpFilters.items[0] := lblQty.Caption;
  grpFilters.items[1] := lblPQADEtailsCUSTFLD4.Caption;
  SaleLine.Connection.BeginNestedTransaction;
  initforSelectedSaleLine;
  //Setcontrolfocus(edtBatchQty);
  if GuiPrefs.Node.Exists('Options.Entrypoint')     and (GuiPrefs.Node['Options.Entrypoint'].asInteger = 2) then begin
    Setcontrolfocus(edtTotalWeight);
  end else if GuiPrefs.Node.Exists('Options.Entrypoint')     and (GuiPrefs.Node['Options.Entrypoint'].asInteger = 3) then begin
    Setcontrolfocus(edtNetWeight);
  end else begin
    Setcontrolfocus(edtBatchQty) ;
  end;
  CalcnshowFooter;
(*  // Dene doesn't want to see the qty/boqty customfields etc. and make the grid taller to see more related products
  grdSalesBatchRelated.height := 300;
  pnlFooter.top := 0;
  grdSalesBatchRelated.top := 0;*)
end;
Procedure TfmBatchNoCreate.initform;
begin
  //if devmode then begin
    edtWeight.color := GridColBrushInactive;
    //edtTotalWeight.color := GridColBrushInactive;
  //end;
  grdSalesBatchRelated.selected.clear;
  grdSalesBatchRelated.selected.add(SelectedText('ProductName'        ,AppEnv.DefaultClass.PartColumn ,14, '' , true));
  grdSalesBatchRelated.selected.add(SelectedText('ProductDescription' ,'Description'                   ,19, '' , true));
  grdSalesBatchRelated.selected.add(SelectedText('Uom'                ,'Uom'                          ,9 , '' , true));
  grdSalesBatchRelated.selected.add(SelectedText('RelatedProductQty'  ,'Qty'                          ,7 , '' ));
  grdSalesBatchRelated.selected.add(SelectedText('TotalWeight'        ,'Tare Weight'                  ,10, '', true ));
  grdSalesBatchRelated.ApplySelected;

end;
procedure TfmBatchNoCreate.grdSalesBatchRelatedCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  //if devmode then begin
    if sametext(field.fieldname , QrySalesBatchRelatedRelatedProductQty.fieldname) then
    else Abrush.color := GridColBrushInactive;
  //end;
end;

procedure TfmBatchNoCreate.grdSalesBatchRelatedCalcTitleAttributes(
  Sender: TObject; AFieldName: string; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  inherited;
  ABrush.color :=GridColBrushInactive;
end;

procedure TfmBatchNoCreate.grpFiltersClick(Sender: TObject);
begin
  inherited;
  DoBusinessObjectEvent(PQA.PQABatch , BusObjEvent_Change, BusObjEvent_QtyChanged); // to reclculate based on the selection

  if grpFilters.itemindex = 0 then begin lblQty.font.color := GridColFontGreen; edtUOMQty.font.color := GridColFontGreen;edtQty.font.color := GridColFontGreen;   lblPQADEtailsCUSTFLD4.font.color := GridColFontBlack;edtPQACUSTFLD4.font.color := GridColFontBlack;
                          end else begin lblQty.font.color := GridColFontBlack; edtUOMQty.font.color := GridColFontBlack;edtQty.font.color := GridColFontBlack;   lblPQADEtailsCUSTFLD4.font.color := GridColFontGreen;edtPQACUSTFLD4.font.color := GridColFontGreen;

  end;
end;

procedure TfmBatchNoCreate.NewBusObjinstance;
begin
  SalesBatchRelated := TSalesBatches.CreateWithNewConn(Self);
  SalesBatchRelated.Connection.connection := Self.MyConnection;
  SalesBatchRelated.BusObjEvent := DoBusinessObjectEvent;

  fisaleId:=0;
  fiSaleLineId:=0;
  fsSaleLineref:='';

end;


function DoBatch(aManPQADetailsId: integer; aSaleLine: TSalesOrderLine;fconn :TERPConnection;aEnableFinaliseSales :Boolean; aEnableNew :Boolean): TModalResult;
var
  form: TfmBatchNoCreate;

  fPQA:TPQA;

  Function PQA:TPQA;
  begin
    REsult := nil;
    try
      if fpqa = nil then begin
        if (aSaleLine is TSalesOrderLine) and (TSalesOrderLine(aSaleLine).manPQA.count <> 0) then begin
          fPQa :=TSalesOrderLine(aSaleLine).manPQA;
          exit;
        end;
        fPQa :=aSaleLine.PQA;
      end;
    finally
      result := fpqa;
    end;

  end;
begin
  REsult := mrCancel;
  fPQA:= nil;
  form := TfmBatchNoCreate.Create(nil);
  try
    form.ConnectionFormReport := fconn;
    form.fbTemplateUsesNonFormConnection := Assigned(fconn);
    form.ManPQADetailsId := aManPQADetailsId;
    form.SaleLine := aSaleLine;
    form.EnableFinaliseSales :=aEnableFinaliseSales;
    form.EnableNew :=aEnableNew;

    result := form.ShowModal ;
    if (result = mrok)  then begin
      if form.DoPrintSalesDispatchBarcode then
        form.PrintSalesDispatchBarcode;
      PQA.PQAbatch.RefreshDb;
    end;
  finally
    form.Free;
  end;
end;
procedure TfmBatchNoCreate.PrintSalesDispatchBarcode;
var
  sSQL:string;
  Json: TJsonObject;
begin
    sSQL:= ProcTreePQABatchIdsToSLPQABatchIDs(inttostr(Pqa.PQAbatch.ID), TERPConnection (PQA.Connection.Connection));
    if sSQL = '' then exit;
    sSQL:= SalesDispatchBarcodeSQL('' , '' , sSQL );
    clog(sSQL);
    fbReportSQLSupplied := True;
    Json:= JO;
    try
        Json.O['0'].S['master']:= 'Details';
        Json.O['0'].S['detail']:= 'RelatedParts';
        Json.O['0'].S['masterfields']:='PQADetailID';
        Json.O['0'].S['detailfields']:= 'slpqad.PQADetailID';
        PrintTemplateReport(TemplateToPrint('Sales Dispatch Barcode', chkChooseRpt.checked , 'Sales Dispatch Barcode')  , ssql , PrintReport(chkPreview) , 1,Json );
    finally
      Json.Free;
    end;


end;
procedure TfmBatchNoCreate.QrySalesBatchRelatedBeforeOpen(DataSet: TDataSet);
(*var
  qry: TERPQuery;
  s:String;*)
begin
  inherited;
  (*qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    closedb(Qry);
    Qry.SQL.clear;
    Qry.SQL.add(SalesBatchRelated.SQL);
    Qry.SQL.text := replacestr(Qry.SQL.text , '*', 'Distinct UOMID');
    s:=Qry.groupconcat('UPMID');
    if s= '' then s:= '0';
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
  Closedb(QryUOM);
  QryUOM.SQL.Text := 'Select unitId , weight from tblunitsofmeasure where UnitID in (' + s +')';
  Opendb(QryUOM);*)
end;

procedure TfmBatchNoCreate.QrySalesBatchRelatedCalcFields(DataSet: TDataSet);
begin
  inherited;
  if QrySalesBatchRelated.active then
    QrySalesBatchRelatedTotalWeight.AsFloat :=    QrySalesBatchRelatedRelatedProductQty.AsFloat *
                                                  QrySalesBatchRelatedUOMWeight.AsFloat;
end;

procedure TfmBatchNoCreate.ReadnApplyGuiPref;
begin
  if not GuiPrefs.active then GuiPrefs.Active := True;
  if GuiPrefs.Node.Exists('Options.ShowExpiry')     then chkShowExpiry.checked      := GuiPrefs.Node['Options.ShowExpiry'].asBoolean;
  if GuiPrefs.Node.Exists('Options.ShowBOQuantity') then chkShowBOQuantity.checked  := GuiPrefs.Node['Options.ShowBOQuantity'].asBoolean;
  if GuiPrefs.Node.Exists('Options.ChooseRpt')      then chkChooseRpt.checked       := GuiPrefs.Node['Options.ChooseRpt'].asBoolean;
  if GuiPrefs.Node.Exists('Options.Preview')        then chkPreview.checked         := GuiPrefs.Node['Options.Preview'].asBoolean;
  if GuiPrefs.Node.Exists('Options.grpFilters')     then grpFilters.ItemIndex       := GuiPrefs.Node['Options.grpFilters'].asInteger;

end;
function TfmBatchNoCreate.GrossWeight: Double;
begin
  result := 0;
  try
    result := strTofloat(edtTotalWeight.Text);
  Except
   //
  end;
end;
function TfmBatchNoCreate.NetWeight: Double;
begin
  result := 0;
  try
    result := strTofloat(edtNetWeight.Text);
  Except
   //
  end;
end;
procedure TfmBatchNoCreate.NetWeighttoQty;
var
  fd:Double;
begin
(*  if not Appenv.companyprefs.GrossWeightnQtyRelated then exit;
  if (Appenv.Employee.ShowGrossWeightnQtyCalcMsg) then
      if (MessageDlgXP_Vista('Do You Wish To Calculate the Quantity Based on Gross Weight? ', mtConfirmation, [mbYes, mbNo], 0) = mrno) then Exit;*)
  if not ReCalculateQty(PQA.PQABatch.UOMQty) then Exit;

  fd:= PQA.pqabatch.CustFld7/QryUOMweight.asFloat;
  if ProcPrefs.RoundBatchQtyinProgressBatchCreator and (fd <> trunc(fd)) then
        SetPQAbatchQty(Trunc(fd)+1)
        else SetPQAbatchQty(fd);
  QtyGrossWeight;//QtytoGrossWeight;
end;
(*procedure TfmBatchNoCreate.QtytoGrossWeight;
begin
  PQA.pqabatch.CustFld7 := PQA.pqabatch.uomqty * QryUOMweight.asFloat;
end;*)
(*procedure TfmBatchNoCreate.QtytoNetWeight;
begin
  PQA.pqabatch.CustFld6 := PQA.pqabatch.uomqty * QryUOMweight.asFloat;
end;*)
procedure TfmBatchNoCreate.GrossWeighttoQty;
var
  qry :TERPQuery;
  fdGrossWeight :Double;
  fdQty, fdQty1, fdQty2, fdQtyDiff:Double;
  fiCalccond:integer;
  s1, s2:String;
begin
  if not ReCalculateQty(PQA.PQABatch.CUSTFLD6) then Exit;
  if GrossWeight =0 then exit;
  fbGrossWeighttoQty:= TRue;
  try
    fiCalccond:=0;
    fdGrossWeight:= GrossWeight;
    try
      qry := DbSharedObjectsObj.DbSharedObj.GetQuery(SaleLine.connection.Connection);
      try

        s1:= ' SELECT round(AutoRoundRelatedQty(:XQty, SL.productID, SB.ProductId) *if(ifnull(SB.UOMWeight,0)=0,1,SB.UOMWeight),5) as TotalWeight ' +
             ' FROM tblsalesbatches SB  inner join tblSaleslines SL on SB.RelatedParentLineRef = SL.Globalref ' +
             ' where SB.RelatedPArentLineRef = ' +quotedstr(fSaleLine.Globalref)+' and ManPQADetailsId = ' +inttostr(ManPQADetailsId) ;

        s2:= ' Select  :XQty*if(ifnull(UOM.Weight,0)=0,1,UOM.Weight) ' +
             ' from tblsaleslines SL inner join tblunitsofmeasure UOM on UOM.UnitID = SL.UnitOfMeasureID where SL.GlobalRef = ' +quotedstr(fSaleLine.Globalref);

        fdQty1:= fdGrossWeight;
        fdQty2:= 0;
        fdQtyDiff := 0;
        clog('fdQty,fdQty1,fdQty2,TotalWeight');
        qry.sql.text := 'select sum(TotalWeight) as TotalWeight from ( ' + s1+' ) T ' ;
        Qry.parambyname('XQty').asFloat :=  1;
        OpenDb(Qry);
        if Qry.Fieldbyname('TotalWeight').AsFloat >= fdQty1 then begin
          MessageDlgXP_Vista('The weight is more than the Raw Material Weight required for 1 final Prodict', mtWarning, [mbOK], 0);
          fdQty1 :=0;
          Exit;
        end;

        qry.sql.text := 'select sum(TotalWeight) as TotalWeight from ( ' + s1+' union all ' +s2+' ) T ' ;

        While True do begin
          if abs(fdqty1- fdqty2) <= SameValue_GeneralRound then begin fiCalccond:=1 ; break; end;
          if SameValue(fdQtyDiff , abs(fdQty1-fdQty2) ,SameValue_GeneralRound) then begin fiCalccond:=2 ; break; end;

              fdQtyDiff := abs(fdQty1-fdQty2);
              closeDb(Qry);
              Qry.parambyname('XQty').asFloat :=  fdQty1;
              OpenDb(Qry);
              logtext(Qry.SQLtext, 'd:\erp.log');
              Logtext(Floattostr(fdQty)+','+Floattostr(fdQty1)+','+Floattostr(fdQty2)+','+Floattostr(Qry.Fieldbyname('TotalWeight').AsFloat));

              if SameValue(Qry.Fieldbyname('TotalWeight').AsFloat ,fdGrossWeight , SameValue_GeneralRound) then begin
                fiCalccond:=3 ; break;
              end else if Round(Qry.Fieldbyname('TotalWeight').AsFloat , TcConst.GeneralRoundPlaces ) <  Round(fdGrossWeight , TcConst.GeneralRoundPlaces )  then begin
                fdQty := fdQty1;
                fdQty1 :=fdQty1  +abs(round((fdQty1-fdQty2)/2 ,TcConst.GeneralRoundPlaces));
                if not(sameValue(fdQty1,fdQty, SameValue_GeneralRound)) then fdQty2 := fdQty;
                if sameValue(fdQty1,fdQty2, SameValue_GeneralRound) then fdQty2 := +1;
              end else if Round(Qry.Fieldbyname('TotalWeight').AsFloat , TcConst.GeneralRoundPlaces ) >  Round(fdGrossWeight , TcConst.GeneralRoundPlaces )  then begin
                fdQty := fdQty1;
                fdQty1 :=fdQty1  - abs(round((fdQty1-fdQty2)/2 ,TcConst.GeneralRoundPlaces));
                if not(sameValue(fdQty1,fdQty, SameValue_GeneralRound)) then fdQty2 := fdQty;;
                if sameValue(fdQty1,fdQty2, SameValue_GeneralRound) then fdQty2 := -1;
              end else begin
                fiCalccond:=4 ; break;
              end
        end;

      finally
        DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
      end;
    finally
      Logtext(inttostr(fiCalccond));

      if fdQty1 <0 then fdQty1 := 0;

    UpdatingSalesBatchRelated := true;
    try
      if ProcPrefs.RoundBatchQtyinProgressBatchCreator and (fdQty1 <> trunc(fdQty1)) then
          SetPQAbatchQty(Trunc(fdQty1)+1)
          else SetPQAbatchQty(fdQty);

      PQA.PQABatch.PostDB;
      qry := DbSharedObjectsObj.DbSharedObj.GetQuery(SaleLine.connection.Connection);
        try
          closeDb(Qry);
          qry.sql.text := replacestr(s1, 'SELECT' ,'SELECT SB.* , ') ;
          Qry.parambyname('XQty').asFloat :=  fdQty1;
          OpenDb(Qry);
          if Qry.recordcount >0 then begin


                    // this query locks the SalesBatchRelated records..
                    // as a quick solution, populating the SQLs with values and close the query
                    s1 :='';
                    Qry.first;
                    While Qry.eof = False do begin
                      if s1 <> '' then s1 := s1 +' union ';
                      s1 := s1 +' Select ' +inttostr(Qry.fieldbyname('ID').AsInteger) + ' as ID,' +
                                            Floattostr(Qry.fieldbyname('TotalWeight').asfloat)+' as TotalWeight,'+
                                            Floattostr(Qry.fieldbyname('uomweight').asfloat)+' as uomweight'+
                                            ' FROM DUAL';
                      Qry.Next;
                    end;
                    if s1 <> '' then begin
                    closedb(Qry);
                    Qry.sql.text := s1;
                    opendb(Qry);


            Qry.first;
              While Qry.eof = False do begin
                if SalesBatchRelated.locate('ID', Qry.fieldbyname('ID').AsInteger , []) then begin
                  SalesBatchRelated.totalWeight := Qry.fieldbyname('TotalWeight').asfloat;
                  SalesBatchRelated.relatedProductqty := DivZer(Qry.fieldbyname('TotalWeight').asfloat ,Qry.fieldbyname('uomweight').asFloat);
                  SalesBatchRelated.Postdb;
                end;
                Qry.Next;
              end;
                    end;
          end;
        finally
            DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
        end;
      finally
        UpdatingSalesBatchRelated := False;
      end;
      CalcnshowFooter;
    end;
  finally
    QtyNetWeight;//QtytoNetWeight;
    fbGrossWeighttoQty := False;
  end;
end;

procedure TfmBatchNoCreate.edtTotalWeightExit(Sender: TObject);
begin
  inherited;
  if not(Samevalue(fdCleanGrossWeight , GrossWeight , SameValue_GeneralRound)) then begin
    GuiPrefs.Node['Options.Entrypoint'].asInteger := 2;
    PQA.PQABatch.CUSTFLD6 :=GrossWeight;
    GrossWeighttoQty;
  end;
end;
Function TfmBatchNoCreate.ReCalculateQty(ChangingQty:double) :Boolean;
begin
  if ChangingQty =0 then begin
    Result := TRue;
    Exit;
  end;
  if not Appenv.companyprefs.GrossWeightnQtyRelated then begin
    Result := False;
    Exit;
  end;
  if not (Appenv.Employee.ShowGrossWeightnQtyCalcMsg) then begin
    Result := TRue;
    Exit;
  end;
  Case MessageDlgXP_Vista('Do You Wish To Calculate the Net Weight Based on Quantity? ', mtConfirmation, [mbYes, mbNo], 0, nil , '' , '' , False, nil , 'Yes and Do Not Show Again,No and Do Not Show Again') of
    100: begin Appenv.Employee.ShowGrossWeightnQtyCalcMsg := False; Appenv.companyprefs.GrossWeightnQtyRelated := True; Result := True; end;
    101: begin Appenv.Employee.ShowGrossWeightnQtyCalcMsg := False; Appenv.companyprefs.GrossWeightnQtyRelated := False; Result := False; end;
    mrYes: begin Result := True; end;
    else begin Result := False; end;
  End;

end;
procedure TfmBatchNoCreate.QtyNetWeight;
begin
    if not ReCalculateQty(PQA.PQAbatch.CUSTFLD7 ) then Exit;
    PQA.PQAbatch.CUSTFLD7:=Round(PQA.PQAbatch.uomqty * QryUOMweight.asFloat,2);
    ShowBatchNetnGross;
end;
procedure TfmBatchNoCreate.QtyGrossWeight;
begin
    if not ReCalculateQty(PQA.PQAbatch.CUSTFLD6 ) then Exit;
    PQA.PQAbatch.CUSTFLD6:=Round(PQA.PQAbatch.uomqty * QryUOMweight.asFloat,2);
    ShowBatchNetnGross;
end;
procedure TfmBatchNoCreate.edtBatchQtyExit(Sender: TObject);
begin
  inherited;

  if fdCleanQty <> PQA.PQAbatch.uomqty then begin
    GuiPrefs.Node['Options.Entrypoint'].asInteger := 1;
    QtyGrossWeight;
    QtyNetWeight;
    CalcnshowFooter;
  end;


end;
Procedure TfmBatchNoCreate.SetPQAbatchQty(const Value:Double);
begin
    if ProcPrefs.RoundBatchQtyinProgressBatchCreator and (trunc(Value) <> Value) then
         PQA.PQABatch.uomqty := trunc(Value)+1
    else PQA.PQABatch.uomqty := Value;
end;
initialization
  RegisterClassOnce(TfmBatchNoCreate);

end.

