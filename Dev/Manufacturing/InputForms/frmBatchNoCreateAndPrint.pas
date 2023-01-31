unit frmBatchNoCreateAndPrint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, ExtCtrls, StdCtrls, DNMSpeedButton, Shader,
  DNMPanel, BusObjSales, AdvEdit, ComCtrls, wwdbdatetimepicker,
  DB, MemDS, DBAccess, MyAccess, ERPdbComponents, BaseFormForm,
  busobjPQA, ProgressDialog, ImgList, AdvMenus, DataState, SelectionDialog, AppEvnts;

type
  TfmBatchNoCreateAndPrint = class(TBaseInputGUI)
    qrySales: TERPQuery;
    DNMPanel2: TDNMPanel;
    pnlbaseuom: TDNMPanel;
    DNMPanel5: TDNMPanel;
    lblUOM: TLabel;
    edtUOMQty: TAdvEdit;
    edtUOMBOQty: TAdvEdit;
    lblUnits: TLabel;
    lblExpiryDate: TLabel;
    lblPQADEtailsCUSTFLD1: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    DNMPanel4: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    pnlSeqno: TDNMPanel;
    edtSeqno: TEdit;
    DNMPanel1: TDNMPanel;
    Label1: TLabel;
    edtBatchSeqno: TEdit;
    lblBatchNo: TLabel;
    edtBatchNo: TEdit;
    DNMPanel6: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdPrint: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    pnlAdvPrinting: TDNMPanel;
    ChkChooseRpt: TCheckBox;
    chkPreview: TCheckBox;
    edtBOQty: TAdvEdit;
    edtQty: TAdvEdit;
    pnlUOMDetails: TDNMPanel;
    lblUOMDetails: TLabel;
    lblPQADEtailsCUSTFLD4: TLabel;
    EdtPQACUSTFLD1: TAdvEdit;
    edtPQACUSTFLD4: TAdvEdit;
    edtExpiryDate: TwwDBDateTimePicker;
    chkShowBOQuantity: TCheckBox;
    chkShowExpiry: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtBatchNoChange(Sender: TObject);
    procedure edtUOMQtyChange(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure edtExpiryDateChange(Sender: TObject);
    procedure edtUOMBOQtyChange(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure EdtPQACUSTFLD1Change(Sender: TObject);
    procedure edtQty1Change(Sender: TObject);
    procedure edtBOQty1Change(Sender: TObject);
    procedure edtQtyChange(Sender: TObject);
    procedure edtBOQtyChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure edtPQACUSTFLD4Change(Sender: TObject);
    procedure chkShowBOQuantityClick(Sender: TObject);
    procedure chkShowExpiryClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    TransActive: boolean;
    fPQA:TPQA;
    DoPrintSalesDispatchBarcode :Boolean;
    OnChangeData:boolean;
    function PQA: TPQA;
    procedure PrintSalesDispatchBarcode;
    procedure MoveCheckBoxes;
    procedure ReadnApplyGuiPref;

  public
    SaleLine: TSalesOrderLine;
  end;

function DoBatch(aManPQADetailsId: integer; aSaleLine: TSalesOrderLine;fconn :TERPConnection): boolean;

implementation

uses
  CommonLib, DbSharedObjectsObj, CommonDbLib, AppEnvironment, saleslib,
  CommonFormLib, BusobjUOM, JSONObject;

{$R *.dfm}

function DoBatch(aManPQADetailsId: integer; aSaleLine: TSalesOrderLine;fconn :TERPConnection): boolean;
var
  form: TfmBatchNoCreateAndPrint;
  newBatchNo: string;
  fPQA:TPQA;
//  PQAID:Integer;

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
  REsult := False;
  fPQA:= nil;
  form := TfmBatchNoCreateAndPrint.Create(nil);
  try
    form.ConnectionFormReport := fconn;
    form.fbTemplateUsesNonFormConnection := Assigned(fconn);
    form.SaleLine := aSaleLine;
    if aManPQADetailsId > 0 then begin
      if PQA.PQABatch.ID <> aManPQADetailsId then begin
        if not PQA.PQABatch.LocateId(aManPQADetailsId) then begin
          CommonLib.MessageDlgXP_Vista('Could not find PQA Batch ID',mtError,[mbOk],0);
          exit;
        end;
      end;
    end
    else begin
      { new batch }
      newBatchNo := PQA.PQABatch.NextSeqBatchNo;
      PQA.PQABatch.New;
      PQA.PQABatch.BatchNo := newBatchNo;
      PQA.PQABatch.ExpiryDate := Date;
      try PQA.PQABatch.CustFld3 := strToint(GetSequenceNumber(form.Classname));Except end;
(*      PQA.PQABatch.UOMQty   := PQA.UOMQty - PQA.TotalUOMBatchAllocatedQty;
      PQA.PQABatch.BOUOMQty := PQA.BOUOMQty - PQA.TotalBOUOMBatchAllocatedQty;*)
    end;
    form.lblUOM.Caption := PQA.UnitOfMeasure;
    form.lblUnits.Caption := Appenv.DefaultClass.DefaultUOM;
    form.lblUOMDetails.Caption := TUnitOfMeasure.UOMDetails(PQA.UnitOfMeasureID);//'1 ' + PQA.UnitOfMeasure +' = ' + FloattoStrF(PQA.UOMMultiplier , ffGeneral, 15,2)+' '+ Appenv.DefaultClass.DefaultUOM;
    form.pnlbaseuom.Visible := not(sametext(PQA.UnitOfMeasure , Appenv.DefaultClass.DefaultUOM)) or (PQA.UOMMultiplier <>1);
    form.pnlUOMDetails.Visible := form.pnlbaseuom.Visible;

    form.edtBatchNo.Text := PQA.PQABatch.BatchNo;
    if PQA.PQABatch.ExpiryDate > 0 then begin
      form.edtExpiryDate.Date := PQA.PQABatch.ExpiryDate;
    end
    else begin
      form.edtExpiryDate.Date := 0;
    end;
    form.edtUOMQty.FloatValue := PQA.PQABatch.UOMQty;
    form.edtQty.FloatValue    := PQA.PQABatch.Qty;
    form.edtUOMBOQty.FloatValue := PQA.PQABatch.BOUOMQty;
    form.edtBOQty.FloatValue    := PQA.PQABatch.BOQty;

    form.EdtPQACUSTFLD1.FloatValue := PQA.PQABatch.CUSTFLD1;

    result := form.ShowModal = mrOk;
    if result then begin
//      PQAID:= aSaleLine.PQA.ID;
//      PQA.CopyAllocation(PQAID, false);
      if form.DoPrintSalesDispatchBarcode then
        form.PrintSalesDispatchBarcode;
      PQA.PQAbatch.RefreshDb;
    end;
  finally
    form.Free;
  end;
end;

Function TfmBatchNoCreateAndPrint.PQA:TPQA;
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


procedure TfmBatchNoCreateAndPrint.chkShowBOQuantityClick(Sender: TObject);
var
  lShift : integer;
begin
  inherited;
  lShift := edtUOMBOQty.Width + 14;
  if chkShowBOQuantity.Checked then
  begin
    edtUOMBOQty.Visible := true;
    Label4.Visible := true;
    edtPQACUSTFLD1.Left := edtPQACUSTFLD1.Left + lShift;
    edtPQACustFLD4.Left := edtPQACUSTFLD4.Left + lShift;
    edtExpiryDate.Left := edtExpiryDate.Left + lShift;
    lblPQADetailsCUSTFLD1.Left := lblPQADetailsCUSTFLD1.Left + lShift;
    lblPQADetailsCUSTFLD4.Left := lblPQADetailsCUSTFLD4.Left + lShift;
    lblExpiryDate.Left := lblExpiryDate.Left + lShift;
    Self.Width := Self.Width + lShift;
  end
  else
  begin
    edtUOMBOQty.Visible := false;
    Label4.Visible := false;
    edtPQACUSTFLD1.Left := edtPQACUSTFLD1.Left - lShift;
    edtPQACustFLD4.Left := edtPQACUSTFLD4.Left - lShift;
    edtExpiryDate.Left := edtExpiryDate.Left - lShift;
    lblPQADetailsCUSTFLD1.Left := lblPQADetailsCUSTFLD1.Left - lShift;
    lblPQADetailsCUSTFLD4.Left := lblPQADetailsCUSTFLD4.Left - lShift;
    lblExpiryDate.Left := lblExpiryDate.Left - lShift;
    Self.Width := Self.Width - lShift;
  end;
  MoveCheckBoxes;
end;

procedure TfmBatchNoCreateAndPrint.chkShowExpiryClick(Sender: TObject);
begin
  inherited;
  if chkSHowExpiry.Checked then
  begin
    lblExpiryDate.Visible := true;
    edtExpiryDate.Visible := true;
    edtExpiryDate.Left := edtPQACustFld4.Left + edtPQACustFld4.Width + 14;
    lblExpiryDate.Left := edtExpiryDate.Left;
    self.Width := Self.Width + edtExpiryDate.Width;
    MoveCheckBoxes;
  end
  else
  begin
    lblExpiryDate.Visible := false;
    edtExpiryDate.Visible := false;
    self.Width := Self.Width - edtExpiryDate.Width;
    MoveCheckBoxes;
  end;
end;

procedure TfmBatchNoCreateAndPrint.cmdCancelClick(Sender: TObject);
begin
  inherited;
  if TransActive then begin
    PQA.PQABatch.CancelDb;
    SaleLine.Connection.RollbackNestedTransaction;
    TransActive := false;
  end;
  ModalResult := mrCancel;
end;

procedure TfmBatchNoCreateAndPrint.cmdCloseClick(Sender: TObject);
begin
  inherited;
//  PQA.PQABatch.PostDb;
//  if not PQA.PQABatch.ValidateData then
//    exit;
  if not PQA.Save then
    exit;
  SaleLine.Connection.CommitNestedTransaction;
  TransActive := false;
  ModalResult := mrOk;
end;

procedure TfmBatchNoCreateAndPrint.cmdPrintClick(Sender: TObject);
begin
  inherited;
  DoPrintSalesDispatchBarcode := TRue;
  cmdClose.Click;
end;

procedure TfmBatchNoCreateAndPrint.PrintSalesDispatchBarcode;
var
  sSQL:string;
  Json: TJsonObject;
begin
    sSQL:= ProcTreePQABatchIdsToSLPQABatchIDs(inttostr(Pqa.PQAbatch.ID), TERPConnection (PQA.Connection.Connection));
    if sSQL = '' then exit;
    sSQL:= SalesDispatchBarcodeSQL('' , '' , sSQL );
    fbReportSQLSupplied := True;
    Json:= JO;
    try
        Json.O['0'].S['master']:= 'Details';
        Json.O['0'].S['detail']:= 'RelatedParts';
        Json.O['0'].S['masterfields']:='PQADetailID';
        Json.O['0'].S['detailfields']:= 'slpqad.PQADetailID';
        PrintTemplateReport(TemplateToPrint('Sales Dispatch Barcode', chkChooseRpt.checked , 'Sales Dispatch Barcode')  , ssql , PrintReport(chkPreview) , 1 ,Json);
    finally
      Json.Free;
    end;


end;

procedure TfmBatchNoCreateAndPrint.ReadnApplyGuiPref;
begin
  if not  GuiPrefs.active then GuiPrefs.Active := True;
  if GuiPrefs.Node.Exists('Options.ShowExpiry')     then chkShowExpiry.checked      := GuiPrefs.Node['Options.ShowExpiry'].asBoolean;
  if GuiPrefs.Node.Exists('Options.ShowBOQuantity') then chkShowBOQuantity.checked  := GuiPrefs.Node['Options.ShowBOQuantity'].asBoolean;
  if GuiPrefs.Node.Exists('Options.ChooseRpt')      then chkChooseRpt.checked       := GuiPrefs.Node['Options.ChooseRpt'].asBoolean;
  if GuiPrefs.Node.Exists('Options.Preview')        then chkPreview.checked         := GuiPrefs.Node['Options.Preview'].asBoolean;
end;

procedure TfmBatchNoCreateAndPrint.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  GuiPrefs.Node['Options.ShowExpiry'].asBoolean     := chkShowExpiry.checked      ;
  GuiPrefs.Node['Options.ShowBOQuantity'].asBoolean := chkShowBOQuantity.checked  ;
  GuiPrefs.Node['Options.ChooseRpt'].asBoolean      := chkChooseRpt.checked       ;
  GuiPrefs.Node['Options.Preview'].asBoolean        := chkPreview.checked         ;
  fbIsLocalPrefChanged:= True;
  inherited;
end;

procedure TfmBatchNoCreateAndPrint.FormCreate(Sender: TObject);
  Procedure lblhintncaption(Const lbl:TLabel ; value:String);
  begin
    lbl.caption := Value;
    Showcontrolhint(lbl, value);
  end;

begin
  inherited;
  OnChangeData:=False;
  TransActive := false;
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

end;

procedure TfmBatchNoCreateAndPrint.FormDestroy(Sender: TObject);
begin
  inherited;
  if TransActive then begin
    PQA.PQABatch.CancelDb;
    SaleLine.Connection.RollbackNestedTransaction;
    TransActive := false;
  end;
end;

procedure TfmBatchNoCreateAndPrint.FormResize(Sender: TObject);
var
  idx : integer;
begin
  inherited;
//
//  pnlTitle.Width := TitleLabel.Canvas.TextWidth(TitleLabel.Caption) + 16;
  pnlTitle.Left := (Self.ClientWidth - pnlTitle.Width) div 2;

  idx := lblpqadetailscustfld4.canvas.textwidth(lblpqadetailscustfld4.caption);
  if idx > edtPQACUSTFLD4.Width then
    lblpqadetailscustfld4.Width := edtPQACUSTFLD4.Width;

end;

procedure TfmBatchNoCreateAndPrint.FormShow(Sender: TObject);
begin
  inherited;
  SaleLine.Connection.BeginNestedTransaction;
  TransActive := true;
  edtSeqno.text := inttostr(PQA.PQABatch.CUSTFLD2);
  edtBatchSeqno.text := inttostr(PQA.PQABatch.CUSTFLD3);
  pnlSeqno.visible := devmode;
  ReadnApplyGuiPref;
end;


procedure TfmBatchNoCreateAndPrint.MoveCheckBoxes;
begin
  (*if lblExpiryDate.Visible then
  begin
    chkShowBOQuantity.Left := edtExpiryDate.Left + DNMPanel5.Left;
    chkShowExpiry.Left := edtExpiryDate.Left + DNMPanel5.Left;
  end
  else
  begin
    chkShowBOQuantity.Left := edtPQACustFld4.Left + DNMPanel5.Left;
    chkShowExpiry.Left := edtPQACustFld4.Left + DNMPanel5.Left;
  end;*)
end;

procedure TfmBatchNoCreateAndPrint.edtBatchNoChange(Sender: TObject);
begin
  if OnChangeData then exit;
  OnChangeData:= True;
  try
    inherited;
    PQA.PQABatch.BatchNo := edtBatchNo.Text;
  finally
    OnChangeData:= False;
  end;
end;

procedure TfmBatchNoCreateAndPrint.edtExpiryDateChange(Sender: TObject);
begin
  if OnChangeData then exit;
  OnChangeData:= True;
  try
    inherited;
    PQA.PQABatch.ExpiryDate := edtExpiryDate.Date;
  finally
    OnChangeData:= False;
  end;
end;

procedure TfmBatchNoCreateAndPrint.EdtPQACUSTFLD1Change(Sender: TObject);
begin
  if OnChangeData then exit;
  OnChangeData:= True;
  try
    inherited;
    PQA.PQABatch.CUSTFLD1 := EdtPQACUSTFLD1.FloatValue;
  finally
    OnChangeData:= False;
  end;
end;

procedure TfmBatchNoCreateAndPrint.edtUOMQtyChange(Sender: TObject);
begin
  if OnChangeData then exit;
  OnChangeData:= True;
  try
    inherited;
    PQA.PQABatch.UOMQty := edtUOMQty.FloatValue;
    edtQty.FloatValue    := PQA.PQABatch.Qty;
  finally
    OnChangeData:= False;
  end;
end;
procedure TfmBatchNoCreateAndPrint.edtPQACUSTFLD4Change(Sender: TObject);
begin
  if OnChangeData then exit;
  OnChangeData:= True;
  try
    inherited;
    PQA.PQABatch.CUSTFLD4 := EdtPQACUSTFLD4.IntValue;
  finally
    OnChangeData:= False;
  end;
end;

procedure TfmBatchNoCreateAndPrint.edtQty1Change(Sender: TObject);
begin
  if OnChangeData then exit;
  OnChangeData:= True;
  try
    inherited;
    PQA.PQABatch.Qty := edtQty.FloatValue;
    edtUOMQty.FloatValue := PQA.PQABatch.UOMQty;
  finally
    OnChangeData:= False;
  end;
end;
procedure TfmBatchNoCreateAndPrint.edtQtyChange(Sender: TObject);
begin
  if OnChangeData then exit;
  OnChangeData:= True;
  try
    inherited;
    PQA.PQABatch.Qty := edtQty.FloatValue;
    edtUOMQty.FloatValue    := PQA.PQABatch.UOMQty;
  finally
    OnChangeData:= False;
  end;
end;

procedure TfmBatchNoCreateAndPrint.edtUOMBOQtyChange(Sender: TObject);
begin
  if OnChangeData then exit;
  OnChangeData:= True;
  try
    inherited;
    PQA.PQABatch.BOUOMQty := edtUOMBOQty.FloatValue;
    edtBOQty.FloatValue    := PQA.PQABatch.BOQty;
  finally
    OnChangeData:= False;
  end;
end;
procedure TfmBatchNoCreateAndPrint.edtBOQty1Change(Sender: TObject);
begin
  if OnChangeData then exit;
  OnChangeData:= True;
  try
    inherited;
    PQA.PQABatch.BOQty := edtBOQty.FloatValue;
    edtUOMBOQty.FloatValue := PQA.PQABatch.BOUOMQty;
  finally
    OnChangeData:= False;
  end;
end;

procedure TfmBatchNoCreateAndPrint.edtBOQtyChange(Sender: TObject);
begin
  inherited;
  if OnChangeData then exit;
  OnChangeData:= True;
  try
    inherited;
    PQA.PQABatch.BOQty := edtBOQty.FloatValue;
    edtUOMBOQty.FloatValue    := PQA.PQABatch.BOUOMQty;
  finally
    OnChangeData:= False;
  end;

end;

end.
