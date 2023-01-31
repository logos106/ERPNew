unit frmBarcodePicking2;
{$I ERP.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DB, DBAccess,
  MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, ExtCtrls, DNMSpeedButton, StdCtrls,
  Shader, DNMPanel,
  BusObjPickingAssembly2,
  MemDS, BusObjBase, Grids, Wwdbigrd, Wwdbgrid,
  BusObjEmployeeDetails, Mask, wwdbedit, AdvEdit, Contnrs,
  ProgressDialog,kbmMemTable, BusObjProductPicture, ImgList;

const
    Barcode_Prefix_Pick = 'PICK';
    Barcode_Prefix_Pack = 'PACK';
    Barcode_Start       = 'START';
    Barcode_Stop        = 'STOP';
    Barcode_NewPack     = 'NEWPACK';

type
  Tpickingstate =(tNew=0,tLoggedin=1,tPackingfinished=2,tSaleSelected=3,tPickingStarted=4,tPickingfinished=5,tPackingStarted=6);

  TfmBarcodePicking2 = class(TBaseInputGUI)
    pnlButtons: TDNMPanel;
    btnStartNewPicking: TDNMSpeedButton;
    Label4: TLabel;
    btnCancel: TDNMSpeedButton;
    qryPickingAssembly: TERPQuery;
    qryPickingAssemblyLines: TERPQuery;
    dsPixkingAssembly: TDataSource;
    dsPickingAssemblyLine: TDataSource;
    pnlMaster: TDNMPanel;
    pnlDetail: TDNMPanel;
    grdLines: TwwDBGrid;
    lblEmployee: TLabel;
    lblEmployeeName: TLabel;
    Label5: TLabel;
    lblSale: TLabel;
    Label3: TLabel;
    lblStatus: TLabel;
    Label6: TLabel;
    lblPickStart: TLabel;
    Label7: TLabel;
    lblPickFinish: TLabel;
    Label8: TLabel;
    lblPackStart: TLabel;
    Label10: TLabel;
    lblPackFinish: TLabel;
    qryPickingAssemblyLinesGlobalRef: TWideStringField;
    qryPickingAssemblyLinesPickingAssemblylinesID: TIntegerField;
    qryPickingAssemblyLinesPickingAssemblyID: TIntegerField;
    qryPickingAssemblyLinesProductID: TIntegerField;
    qryPickingAssemblyLinesProductName: TWideStringField;
    qryPickingAssemblyLinesDescription: TWideStringField;
    qryPickingAssemblyLinesUOM: TWideStringField;
    qryPickingAssemblyLinesUOMID: TIntegerField;
    qryPickingAssemblyLinesPackNumber: TIntegerField;
    lblSale2: TLabel;
    qryPickingAssemblyLinesQtyMultiplier: TFloatField;
    edtBarcodeInput: TEdit;
    edtQty: TAdvEdit;
    memSummary: TkbmMemTable;
    pnlSummaryHeader: TDNMPanel;
    pnlSummary: TDNMPanel;
    grdSummary: TwwDBGrid;
    Splitter1: TSplitter;
    dsSummary: TDataSource;
    memSummaryProductId: TIntegerField;
    memSummaryProductName: TWideStringField;
    memSummaryProductDescription: TWideStringField;
    memSummaryQtyRequired: TFloatField;
    memSummaryQtyPacked: TFloatField;
    memSummaryDone: TBooleanField;
    Label1: TLabel;
    imgProduct: TImage;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnConNote: TDNMSpeedButton;
    btnControlBarCodes: TDNMSpeedButton;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    DNMPanel4: TDNMPanel;
    DNMPanel5: TDNMPanel;
    Label2: TLabel;
    memSummaryUOM: TWideStringField;
    Label9: TLabel;
    lblLastProduct: TLabel;
    lblCountSummary: TLabel;
    lblPacknoCaption: TLabel;
    lblPackno: TLabel;
    Label11: TLabel;
    qryPickingAssemblyLinesQty: TFloatField;
    memsummaryreturn: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure edtBarcodeInputKeyPress(Sender: TObject; var Key: Char);
    procedure edtQtyKeyPress(Sender: TObject; var Key: Char);
    procedure BeforeDataChange(DataSet: TDataSet);
    procedure btnStartNewPickingClick(Sender: TObject);
    procedure grdLinesRowChanged(Sender: TObject);
    procedure btnConNoteClick(Sender: TObject);
    procedure btnControlBarCodesClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdSummaryCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure edtBarcodeInputKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtBarcodeInputExit(Sender: TObject);
    procedure edtQtyKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtQtyExit(Sender: TObject);
    procedure grdSummaryDblClick(Sender: TObject);
    procedure grdLinesCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure grdLinesCalcTitleAttributes(Sender: TObject;
      AFieldName: String; AFont: TFont; ABrush: TBrush;
      var ATitleAlignment: TAlignment);
    procedure grdSummaryCalcTitleAttributes(Sender: TObject;
      AFieldName: String; AFont: TFont; ABrush: TBrush;
      var ATitleAlignment: TAlignment);
    procedure grdLinesDblClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    PickAssy: TPickingAssembly2;
    CurrentEmployee: TEmployeeDetails;
    ProcessingBarcode: boolean;
    fiPackNumber: integer;
    Status: String;
    TempSaleID: integer;
    ConvertedSOInvoiceID: integer;
    ProductPicture: TProductPicture;
    TotalQty,
    TotalPackedQty: double;
    ProgressDialog: TProgressDialog;
    fpickingstate :Tpickingstate;
    procedure ProcessBarcode(const codeStr: string);
    procedure ProcessQuantity(const aQty: double);
    Procedure Processqty;
    procedure UpdateDisplay;
    function SaveCurrentPicking: boolean;
    function LoadPickingForSaleId(const aSaleId: integer): boolean;
    function StartPacking: boolean;
    function AddOrUpdateLine(const aQty: double;
                             const aMultiplier: double;
                             const aProductID: integer = 0;
                             const aUOMId: integer = 0;
                             const aPackNumber: integer = 0): boolean;
    function GetNextPickingSlipSaleID: integer;

    procedure PrintSO(const SaleID: integer);
    procedure PrintInvoice(const SaleID: integer);
    procedure PrintDeliveryDocket(const PickingAssemblyID: integer);
    procedure PrintPickingConNote(const PickingAssemblyID: integer);
    function ModifySale: boolean;
    procedure CancelChanges;
    procedure CreateMemSummaryStructure;
    procedure PopulateProductSummary;
    procedure GetProductPicture(const aProductId: integer);
//    procedure TabKey( Var msg: TCMDialogKey ); message CM_DIALOGKEY;
    function AllPickingDone: boolean;
    Procedure DoAfterFinish;
    function getisSaleInvoice: Boolean;
    function getIsSaleSaleSOrder: Boolean;
    Procedure updateForm;
    procedure setpickingstate(const Value: Tpickingstate);
    Procedure RefreshGridstatus(Sender:TObject;AFont: TFont);
    procedure setPackNumber(const Value: Integer);

    Property pickingstate :Tpickingstate read fpickingstate Write setpickingstate;
    Property PackNumber:Integer read fiPackNumber Write setPackNumber;

  protected
    procedure LoadTemplate(const bPrint, bSave: boolean;const DoClose: boolean = true;const FileName: string = ''); override;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    procedure AfterFinishProcess(Printsale, PrintDeldocket, PrintCNode :Boolean);
    Property IsSaleSalesOrder:Boolean read getIsSaleSaleSOrder;
    Property IsSaleInvoice  :Boolean read getisSaleInvoice;
  end;
(*
var
  fmBarcodePicking2: TfmBarcodePicking2;*)


implementation

{$R *.dfm}

uses
  DNMExceptions, CommonLib, BusObjConst,
  FastFuncs, tcDataUtils, BusObjStock, CommonDbLib,
   frmBarcodePickingConNoteEdit, AppEnvironment,
  BusObjPickingAssemblyLine, BusObjSales, {frmPrintPickingSlips,}
  ProductQtyLib, busobjPQA, frmBarcodeAfterPacked, BusobjSaleBase,
  Barcodeconst(*, MMSystem*), JSONObject, PrintPickingSlipsLib;

 { TfmBarcodePicking2 }

procedure TfmBarcodePicking2.FormCreate(Sender: TObject);
begin
  inherited;
  Status:= 'Waiting For Input';
  TotalQty:= 0;
  TotalPackedQty:= 0;
  lblLastProduct.Caption:= '';
  lblPackno.Caption := '';
  lblCountSummary.Caption:= '';
  CurrentEmployee:= TEmployeeDetails.Create(self);
  ProcessingBarcode:= false;
  ProductPicture:= TProductPicture.Create(nil);
  CreateMemSummaryStructure;
  PickAssy:= TPickingAssembly2.Create(self);
  PickAssy.Connection := TMyDacDataConnection.Create(PickAssy);
  PickAssy.Connection.MyDacConnection := MyConnection;
  PickAssy.BusObjEvent := DoBusinessObjectEvent;
  PickAssy.Load(0);
  UpdateDisplay;
  btnConNote.Enabled:= self.AccessLevel < 5;
  btnStartNewPicking.Enabled:= self.AccessLevel < 5;
end;

procedure TfmBarcodePicking2.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      pickingstate := tNew;
      (*updateForm;*)

    except
      // Handle these known exceptions.
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;   
end;

procedure TfmBarcodePicking2.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
//
end;

procedure TfmBarcodePicking2.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  RollbackTransaction;
  Action := caFree;
end;

procedure TfmBarcodePicking2.FormDestroy(Sender: TObject);
begin
  ProductPicture.Free;
  inherited;
end;

procedure TfmBarcodePicking2.edtBarcodeInputKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not ProcessingBarcode then
    Try
      ProcessingBarcode := true;
      if (Key = Chr(VK_RETURN)) or (Key = Chr(VK_TAB)) then begin
        Key := #0;   // eat VK_RETURN
        ProcessBarcode(Uppercase(edtBarcodeInput.Text));
        edtBarcodeInput.Text := '';
      end;
    Finally
      ProcessingBarcode := False;
    end;
  if (Key = Chr(VK_RETURN)) or (Key = Chr(VK_TAB)) then
    Key := #0;
end;

procedure TfmBarcodePicking2.edtQtyKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (Key = Chr(VK_RETURN)) or (Key = Chr(VK_TAB)) then begin
    Key := #0;   // eat VK_RETURN
    //ProcessQuantity(edtQty.FloatValue);
    //edtQty.Text:= '';
    ProcessQty;
    Key := #0;
    //edtBarcodeInput.SetFocus;
  end;
end;

procedure TfmBarcodePicking2.ProcessBarcode(const codeStr: string);
var
  sl: TStringList;
  Id, LineId, SaleId, UOMId, ProdId: integer;
  s: string;
  Procedure ProcessEmployee;
  begin
        Id:= 0;
        if (sl.Count > 1) then Id:= StrToIntDef(sl[1],0);
        if (Id > 0) then begin
          if CurrentEmployee.Id <> Id then begin

            if CurrentEmployee.Id > 0 then begin
              { clear current picking }
              PickAssy.Load(0);
              PopulateProductSummary;
            end;

            { select new employee }
            CurrentEmployee.Load(Id);
            Status:= 'Employee Selected';
            pickingstate := tLoggedin;
          end;
        end else begin
          CommonLib.MessageDlgXP_Vista('Invalid employee scan',mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
          exit;
        end;
  end;
  Procedure ProcessUOM;
  begin
{ barcode contains UOMId and SalesLineId }
        LineId:= 0;
        UOMId:= 0;
        if (sl.Count = 3) then begin
          UOMId:= StrToIntDef(sl[1],0);
          LineId:= StrToIntDef(sl[2],0);
        end;
        if (UOMId > 0) and (LineId > 0) then begin
          SaleId:= tcDataUtils.GetSaleIdForSaleLineId(LineId);
          if PickAssy.SaleID <> SaleId then begin
            { load existing or create new PickingAssembly for this sale }
            if not LoadPickingForSaleId(SaleId) then
              exit;
            UpdateDisplay;
          end;
          if PickAssy.FinishedPacking then begin
            CommonLib.MessageDlgXP_Vista('Packing has already been finished for this sale',mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
            exit;
          end
          else if not StartPacking then begin
            exit;
          end;
          { get product ID from sales line }
          if PickAssy.Sale.Lines.Dataset.Locate('SaleLineId',LineId,[]) then begin
            if PickAssy.Sale.Lines.Product.UOMList.LocateByID(UOMID) then begin
              if not AddOrUpdateLine(1,PickAssy.Sale.Lines.Product.UOMList.Multiplier,
                              PickAssy.Sale.Lines.ProductId, UOMId, PackNumber) then
                exit;
            end
            else begin
              CommonLib.MessageDlgXP_Vista('Unit of Measure ID on sale line does not match scanned Unit of Measure ID',mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
              exit;
            end;
          end
          else begin
            CommonLib.MessageDlgXP_Vista('Could not locate this line on sale',mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
            exit;
          end;
        end
        else begin
          CommonLib.MessageDlgXP_Vista('Invalid sale line scan: "' + codeStr + '"',mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
          exit;
        end;
  end;
  Procedure ProcessSales;
  begin
        Id:= 0;
        if (sl.Count > 1) then Id:= StrToIntDef(sl[1],0);
        if (Id > 0) then begin

          if self.LoadPickingForSaleId(Id) then
            Status:= 'Continuing Existing Picking/Packing';
        end
        else begin
          CommonLib.MessageDlgXP_Vista('Invalid sale Id scan',mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
          exit;
        end;
  end;
  Procedure ProcessPicking;
  begin
{ Picking }
        s:= '';
        if (sl.Count > 1) then s:= sl[1];
        if (s <> '') then begin
          { starting or stopping picking }
          if PickAssy.Id <> 0 then begin
            if s = Barcode_Start then begin
              if CurrentEmployee.Id <> 0 then begin
                if not PickAssy.StartPicking then begin
                  PickAssy.StartPicking:= true;
                  PickAssy.StartPickingTime:= now;
                  PickAssy.PickingEmployeeID:= CurrentEmployee.Id;
                  pickingstate := tPickingStarted;
                  if not SaveCurrentPicking then
                    exit;
                  Status:= PickAssy.StatusText;
                end
                else begin
                  CommonLib.MessageDlgXP_Vista('Can not start picking: ' + PickAssy.StatusText,mtInformation,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
                  exit;
                end;
              end
              else begin
                CommonLib.MessageDlgXP_Vista('No employee selected',mtInformation,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
                exit;
              end;
            end
            else if s = Barcode_Stop then begin
              if not PickAssy.FinishedPicking then begin
                if not PickAssy.StartPicking then begin
                  if CurrentEmployee.Id <> 0 then begin
                    PickAssy.PickingEmployeeID:= CurrentEmployee.Id;
                    PickAssy.StartPickingTime:= now;
                    PickAssy.StartPicking:= true;
                  end
                  else begin
                    CommonLib.MessageDlgXP_Vista('No employee selected',mtInformation,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
                    exit;
                  end;
                end;
                PickAssy.FinishedPicking:= true;
                PickAssy.FinishedPickingTime:= now;
                pickingstate := tPickingfinished;
                if not SaveCurrentPicking then
                  exit;
                Status:= PickAssy.StatusText;
              end
              else begin
                CommonLib.MessageDlgXP_Vista('Can not finish picking: ' + PickAssy.StatusText,mtInformation,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
                exit;
              end;
            end;
          end
          else begin
            CommonLib.MessageDlgXP_Vista('No sale selected',mtInformation,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
            exit;
          end;
        end
        else begin
          CommonLib.MessageDlgXP_Vista('Invalid pick bar code "'+ codeStr+'"',mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
          exit;
        end;
  end;
  Function finishPacking:Boolean;
  begin
    result := False;
      if not PickAssy.FinishedPacking then begin
        if  (not AllPickingDone) then
          if CommonLib.MessageDlgXP_Vista('All items on this order have not been packed, are you sure you want to complete packing?',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
        PickAssy.ResultStatus.Clear;
        if not PickAssy.ValidateData then exit;
        if not PickAssy.Save then exit;

        ConvertedSOInvoiceID := 0;
        if AppEnv.CompanyPrefs.AutoEditInvoiceBarcodePick then begin
            if not ModifySale then exit;
        end;

        PickAssy.FinishedPacking:= true;
        PickAssy.FinishedPackingTime:= now;
        PickAssy.PostDB;

        Result := SaveCurrentPicking;
        if result then begin
          DoAfterFinish;
          Status:= PickAssy.StatusText;
          pickingstate := tPackingfinished;
        end;
      end;
end;
  function ProcessPacking:Boolean;
  begin
{ Packing }
        result := true;
        s:= '';
        if (sl.Count > 1) then s:= sl[1];
        if (s <> '') then begin
          { starting or stopping packing }
          if PickAssy.Id <> 0 then begin
            if s = Barcode_Start then begin
              if not StartPacking then
                exit;
            end else if s = Barcode_Stop then begin
              Result := FinishPacking;
            end else if s = Barcode_NewPack then begin
              PackNumber:= PickAssy.MaxLinePackNumber;
              PackNumber:= PackNumber +1;
              pickingstate := tPackingStarted;
            end;
          end else begin
            CommonLib.MessageDlgXP_Vista('No sale selected',mtInformation,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
            exit;
          end;
        end  else begin
          CommonLib.MessageDlgXP_Vista('Invalid pack bar code "'+ codeStr+'"',mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
          exit;
        end;
  end;
  Procedure ProcessBarCode;
  begin
{ check for product barcode }
      ProdId:= TProduct.ProductIdForBarcode(codeStr);
      if ProdId > 0 then begin
        if PickAssy.Id > 0 then begin
          if (not PickAssy.FinishedPacking) and StartPacking then begin
            { is this product on current sale .. }
            if PickAssy.Sale.Lines.Dataset.Locate('ProductId',ProdId,[]) then begin
//              AddOrUpdateLine(1, PickAssy.Sale.Lines.UOMMultiplier, ProdId,
//                PickAssy.Sale.Lines.Product.UOMList.BaseUnitID, PackNumber);
//              AddOrUpdateLine(1, 1, ProdId,
//                PickAssy.Sale.Lines.Product.UOMList.BaseUnitID, PackNumber);
              AddOrUpdateLine(1, PickAssy.Sale.Lines.UOMMultiplier, ProdId,
                PickAssy.Sale.Lines.UnitOfMeasureID, PackNumber);
            end
            else begin
              CommonLib.MessageDlgXP_Vista('Product is not on sale' ,mtInformation,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
              exit;
            end;
          end
          else begin
            CommonLib.MessageDlgXP_Vista('Can only change quantity while order is being packed' ,mtInformation,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
            exit;
          end;
        end
        else begin
          CommonLib.MessageDlgXP_Vista('No sale selected' ,mtInformation,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
          exit;
        end;
      end else begin
        CommonLib.MessageDlgXP_Vista('Unknown bar code: "'+ codeStr +'"',mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
        exit;
      end;
  end;
begin
  lblLastProduct.Caption:= '';
  lblCountSummary.Caption:= '';
  sl:= TStringList.Create;
  try
    fastfuncs.Split(codeStr,Barcode_SepChar,sl);
    if sl.Count > 1 then begin
      if sl[0] = Barcode_Prefix_Employee then begin
        ProcessEmployee;
      end  else if sl[0] = Barcode_Prefix_UOMSalesLine then begin
        ProcessUOM;
      end else if (sl[0] = Barcode_Prefix_Sale) then begin
        Processsales;
      end else if sl[0] = Barcode_Prefix_Pick then begin
        ProcessPicking;
      end else if sl[0] = Barcode_Prefix_Pack then begin
        if not ProcessPacking then exit;
      end;
    end else begin
      ProcessBarCode;
    end;
    UpdateDisplay;
    (*updateForm;*)
  finally
    sl.Free;
  end;
end;

procedure TfmBarcodePicking2.DoBusinessObjectEvent( const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TPickingAssembly2 then
      TPickingAssembly2(Sender).DataSet:= qryPickingAssembly
    else if Sender is TPickingAssemblyLine2 then
      TPickingAssemblyLine2(Sender).DataSet := qryPickingAssemblyLines
  end
  else if EventType = BusObjEvent_GUIFocusField then begin

  end;
end;

procedure TfmBarcodePicking2.UpdateDisplay;
begin
  lblStatus.Caption:= Status;
  lblEmployeeName.Caption:= CurrentEmployee.Employeename;

  if Assigned(PickAssy.Sale) then begin
    if PickAssy.Sale.IsInvoice then begin
      lblSale.Caption:= 'Invoice ' + PickAssy.Sale.GlobalRef;
      lblSale2.Caption:= PickAssy.Sale.CustomerName;
    end
    else if PickAssy.Sale.IsSalesOrder then begin
      lblSale.Caption:= 'Sales Order ' + PickAssy.Sale.GlobalRef;
      lblSale2.Caption:= PickAssy.Sale.CustomerName;
    end
  end
  else begin
    lblSale.Caption:= '';
    lblSale2.Caption:= '';
  end;

  if PickAssy.StartPickingTime > 0 then lblPickStart.Caption:= FormatDateTime('dd/mm/yy hh:nn',PickAssy.StartPickingTime)
  else lblPickStart.Caption:= '';

  if PickAssy.FinishedPickingTime > 0 then lblPickFinish.Caption:= FormatDateTime('dd/mm/yy hh:nn',PickAssy.FinishedPickingTime)
  else lblPickFinish.Caption:= '';

  if PickAssy.StartPackingTime > 0 then lblPackStart.Caption:= FormatDateTime('dd/mm/yy hh:nn',PickAssy.StartPackingTime)
  else lblPackStart.Caption:= '';

  if PickAssy.FinishedPackingTime > 0 then lblPackFinish.Caption:= FormatDateTime('dd/mm/yy hh:nn',PickAssy.FinishedPackingTime)
  else lblPackFinish.Caption:= '';

end;

function TfmBarcodePicking2.SaveCurrentPicking: boolean;
begin
  PickAssy.Lines.PostDb;
  PickAssy.ResultStatus.Clear;
  result:= PickAssy.ValidateData;
  if result then
    result:= PickAssy.Save;
  if not result then begin
    CommonLib.MessageDlgXP_Vista('Could not Save picking info: '+PickAssy.ResultStatus.Messages ,mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
    CancelChanges;
  end
  else
    self.CommitTransaction;
end;

procedure TfmBarcodePicking2.ProcessQuantity(const aQty: double);
begin
  if PickAssy.Id > 0 then begin
    if PickAssy.StartPacking and (not PickAssy.FinishedPacking) then begin
      if PickAssy.Lines.Count > 0 then begin
        AddOrUpdateLine(aQty, PickAssy.Lines.QtyMultiplier);

      end
      else begin
        CommonLib.MessageDlgXP_Vista('A line must be added befor the quantity can be changed' ,mtInformation,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
      end;
    end
    else begin
      CommonLib.MessageDlgXP_Vista('Can only change quantity while order is being packed' ,mtInformation,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
    end;
  end
  else begin
    CommonLib.MessageDlgXP_Vista('No sale selected' ,mtInformation,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
  end;
end;

function TfmBarcodePicking2.LoadPickingForSaleId(
  const aSaleId: integer): boolean;
begin
  result:= false;
  if not TPickingAssembly2.IsComplete(aSaleId) then begin
    PickAssy.LoadSelect('SaleId = ' + IntToStr(aSaleId));
    if PickAssy.Id = 0 then begin
      PickAssy.New;
      PickAssy.SaleID:= aSaleId;
      PickAssy.Barcode:=  AppEnv.Branch.SiteCode + '-' + IntToStr(aSaleId);
      if not SaveCurrentPicking then
        exit;
      Status:= 'New Picking';
      pickingstate:=tSaleSelected;
    end
    else begin
      { get the pack number we are currently up to }
      if PickAssy.StartPacking then begin
        PackNumber:= PickAssy.MaxLinePackNumber;
        if PackNumber = 0 then
          PackNumber:= 1;
        CurrentEmployee.Load(PickAssy.PackingEmployeeID);
        pickingstate:=tPackingStarted;
      end
      else if PickAssy.StartPicking then begin
        CurrentEmployee.Load(PickAssy.PickingEmployeeID);
        pickingstate:=tPickingStarted;
      end
      else begin
//        CurrentEmployee.Load(0);
      end;
    end;
    PopulateProductSummary;
    result:= true;
  end
  else begin
    pickingstate:=tPackingfinished;
    CommonLib.MessageDlgXP_Vista('Picking is complete for this sale',mtInformation,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
    exit;
  end;
end;

function TfmBarcodePicking2.StartPacking: boolean;
begin
  result:= true;
  if PickAssy.StartPacking then
    exit;
  if CurrentEmployee.Id <> 0 then begin
    if not PickAssy.StartPacking then begin
      if not PickAssy.StartPicking then begin
        PickAssy.StartPickingTime:= now;
        PickAssy.PickingEmployeeID:= CurrentEmployee.Id;
        PickAssy.StartPicking:= true;
      end;
      if not PickAssy.FinishedPicking then begin
        PickAssy.FinishedPickingTime:= now;
        PickAssy.FinishedPicking:= true;
      end;
      PickAssy.StartPacking:= true;
      PickAssy.StartPackingTime:= now;
      PickAssy.PackingEmployeeID:= CurrentEmployee.Id;
      PackNumber:= 1;
      if not SaveCurrentPicking then begin
        result:= false;
        exit;
      end;
      Status:= PickAssy.StatusText;
      pickingstate:= tPackingStarted;
    end
    else begin
      result:= false;
      CommonLib.MessageDlgXP_Vista('Can not start packing: ' + PickAssy.StatusText,mtInformation,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
      exit;
    end;
    result:= true;
  end
  else begin
    result:= false;
    CommonLib.MessageDlgXP_Vista('No employee selected',mtInformation,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
    exit;
  end;
end;

function TfmBarcodePicking2.AddOrUpdateLine(const aQty: double;
                             const aMultiplier: double;
                             const aProductID: integer = 0;
                             const aUOMId: integer = 0;
                             const aPackNumber: integer = 0): boolean;
var
  SaleTotQty, PackTotQty, addQty: double;
  ProdId: integer;
begin
  result:= false;
  if aProductId > 0 then ProdId:= aProductId
  else ProdId:= PickAssy.Lines.ProductID;
  { total shipped qty of this product on the sale }

  SaleTotQty:= PickAssy.Sale.QtyShippedForProduct(ProdId);
  { total qty packed so far for this product }
  PackTotQty:= PickAssy.QtyPackedForProduct(ProdId);

  if aProductId = 0 then
    {updating qty on existing line}
    addQty:= (aQty * aMultiplier) - (PickAssy.Lines.Qty * aMultiplier)
  else
    {addin a new line}
    addQty:= (aQty * aMultiplier);

  if (PackTotQty + addQty) <= SaleTotQty then begin
    if aProductId = 0 then begin
      { update existing ... }
      if aQty <> 0 then
        PickAssy.Lines.Qty:= aQty
      else begin
        if CommonLib.MessageDlgXP_Vista('OK to delete picking line for "' +
          PickAssy.Lines.ProductName + '"?', mtInformation, [mbYes,mbNo],0) = mrYes then
        PickAssy.Lines.Delete;
      end;
    end
    else begin
      {add new line ...}
      PickAssy.Lines.New;
      PickAssy.Lines.ProductID:= ProdId;
      PickAssy.Lines.UOMID:= aUOMId;
      PickAssy.Lines.QtyMultiplier:= aMultiplier;
      PickAssy.Lines.Qty:= aQty;
      PickAssy.Lines.PackNumber:= aPackNumber;
    end;
    if memSummary.Locate('ProductId',ProdId,[]) then begin
      memSummary.Edit;
      memSummary.FieldByName('QtyPacked').AsFloat:= memSummary.FieldByName('QtyPacked').AsFloat + addQty;
      TotalPackedQty:= TotalPackedQty + addQty;
      memSummary.FieldByName('Done').AsBoolean:=
        memSummary.FieldByName('QtyPacked').AsFloat >= memSummary.FieldByName('QtyRequired').AsFloat;
      memSummary.Post;
      lblLastProduct.Caption:=
        memSummary.FieldByName('ProductName').AsString + ' - ' +
        'Req: ' + memSummary.FieldByName('QtyRequired').AsString + '  ' +
        'Pkd: ' + memSummary.FieldByName('QtyPacked').AsString;
      lblCountSummary.Caption:= FloatToStr(TotalPackedQty) + ' out of ' +
        FloatToStr(TotalQty) + ' packed';
      (*Setcontrolfocus(edtQty);*)
      Setcontrolfocus(edtBarcodeInput);
    end
    else begin
      CommonLib.MessageDlgXP_Vista('Error locating Packing Summary record',mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
      CancelChanges;
      exit;
    end;
    if not SaveCurrentPicking then
      exit;
    edtQty.FloatValue:= aQty;

//    GetProductPicture(ProdId);

    result:= true;
  end
  else begin
    { over shipped }
    CommonLib.MessageDlgXP_Vista('Quantity exceeds sale quantity',mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
    exit;
  end;
end;
procedure TfmBarcodePicking2.BeforeDataChange(DataSet: TDataSet);
begin
  inherited;
  self.BeginTransaction;
end;

procedure TfmBarcodePicking2.btnStartNewPickingClick(Sender: TObject);
var
  MoreSlipsToPrint: boolean;
begin
  inherited;
  lblLastProduct.Caption:= '';
  lblCountSummary.Caption:= '';
  TotalQty:= 0;
  TotalPackedQty:= 0;
  MoreSlipsToPrint:= true;
  btnStartNewPicking.Enabled := false;
  try
    TempSaleID := GetNextPickingSlipSaleID;
    if TempSaleID = 0 then begin
      (*sndPlaySound('C:\P1\Dev\Wav\doh.wav',SND_ASYNC );*)
      CommonLib.MessageDlgXP_Vista('No New Picking Slips To Pick',mtInformation,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
      MoreSlipsToPrint:= false;
      SetControlFocus(edtBarcodeInput);
    end
    else begin
      LoadTemplate(not(appEnv.Employee.PreviewAllreport), false);
      LoadPickingForSaleId(TempSaleID);
      SetControlFocus(edtBarcodeInput);
      pickingstate:=tSaleSelected;
    end;
  finally
    btnStartNewPicking.Enabled:= MoreSlipsToPrint;
  end;
  UpdateDisplay;
end;

function TfmBarcodePicking2.GetNextPickingSlipSaleID: integer;
var
  qry: TERPQuery;
begin
  qry:= CommonDbLib.TempMyQuery;
  try
    qry.SQL.Add('SELECT tblSales.SaleID,PickingPriority,SaleDate FROM tblSales');
    qry.SQL.Add('INNER JOIN tblClients ON tblClients.ClientID= tblSales.ClientID');
    qry.SQL.Add('LEFT JOIN tblpickingassembly ON tblSales.SaleID=tblpickingassembly.SaleID');
    qry.SQL.Add('WHERE IsBarcodePicking="T" AND BarcodePickingDone <> "T"');
    if AppEnv.CompanyPrefs.BarcodePickingInSOMode then
      qry.SQL.Add('AND (IsSalesOrder = "T")')
    else
      qry.SQL.Add('AND (IsInvoice = "T")');
    { only include sales that have at least one line with a shipped qty <> 0}
    qry.SQL.Add('AND tblSales.SaleID in');
    qry.SQL.Add('(select distinct s.saleId  from tblSales s, tblSalesLines sl');
    qry.SQL.Add('where s.SaleId = sl.SaleId');
    if AppEnv.CompanyPrefs.BarcodePickingInSOMode then
      qry.SQL.Add('and s.IsSalesOrder = "T"')
    else
      qry.SQL.Add('and s.IsInvoice = "T"');
    qry.SQL.Add('and s.IsBarcodePicking="T" AND s.BarcodePickingDone <> "T"');
    qry.SQL.Add('and sl.shipped <> 0)');

    qry.SQL.Add('AND ISNULL(tblpickingassembly.SaleID)');
    qry.SQL.Add('Order by PickingPriority Desc, SaleDate;');
    qry.Open;
    result:= qry.FieldByName('SaleId').AsInteger;
  finally
    qry.Free;
  end;
end;

procedure TfmBarcodePicking2.LoadTemplate(const bPrint, bSave,DoClose: boolean; const FileName: string);
var
  sSQL: string;
  reportname :string;
  Json: TJsonObject;
begin
  reportname := 'Pick Slip with Barcodes';
  fbReportSQLSupplied := true;
  sSQL := '{UOMs}SELECT ' +
      ' SL.SaleLineID, uom.UnitId, uom.UnitName, uom.UnitDescription,   CONCAT("USL-",uom.UnitId,"-",SL.SaleLineId) as LineUnitsBarcode ' +
      '  FROM tblsaleslines AS SL inner JOIN tblsales AS S ON  SL.SaleID = S.SaleID ' +
      ' left join tblUnitsOfMeasure uom on (uom.PartId = SL.ProductId or uom.PartId = 0) ' +
      ' WHERE  (SL.SaleLineID= :SaleLineId) order by Unitname';
  sSQL :=PrintPickingSlipsLib.SQL4PickingSlipreport(reportname,Json, IntToStr(TempSaleID), SalesTransTypes, '' , sSQL);
  PrintTemplateReport(reportname, sSQL, not(appEnv.Employee.PreviewAllreport), 1 , Json);
  fbReportSQLSupplied := false;
end;

procedure TfmBarcodePicking2.DoAfterFinish;
begin
  TfmBarcodeAfterPacked(commonlib.GetComponentByClassName('TfmBarcodeAfterPacked' , true , self)).ShowModal;
  PickAssy.PostDB;
  PickAssy.Load(0);
  PopulateProductSummary;
end;

procedure TfmBarcodePicking2.AfterFinishProcess(Printsale, PrintDeldocket, PrintCNode :Boolean);
begin
  ProgressDialog := TProgressDialog.Create(nil);
  try
    ProgressDialog.Caption  := 'Please Wait ...';
    ProgressDialog.MinValue := 0;
    ProgressDialog.MaxValue := 3;
    ProgressDialog.Value:= 0;
    ProgressDialog.Execute;
//    ConvertedSOInvoiceID := 0;
    if Printsale then begin
       ProgressDialog.Value:= 1;
       ProgressDialog.Caption  := 'Printing Transaction ...';
       if PickAssy.Sale.IsInvoice then PrintInvoice(PickAssy.Sale.SaleId)
       else if ConvertedSOInvoiceID<> 0 then PrintInvoice(ConvertedSOInvoiceID)
       else PrintSO(PickAssy.Sale.SaleId);
    end;
    if PrintDeldocket then begin
      ProgressDialog.Value:= 2;
      ProgressDialog.Caption  := 'Printing Delivery Docket ...';
      PrintDeliveryDocket(PickAssy.ID);
    end;
    if PrintCNode then begin
      ProgressDialog.Value:= 3;
      ProgressDialog.Caption  := 'Printing Consignment Note ...';
      PrintPickingConNote(PickAssy.ID);
    end;
    
    (*if AppEnv.CompanyPrefs.PrintInvoiceBarcodePick then begin
      if AppEnv.CompanyPrefs.BarcodePickingInSOMode then begin
        ProgressDialog.Caption  := 'Printing Invoice ...';
        PrintInvoice(ConvertedSOInvoiceID);
        ProgressDialog.Value:= 1;
        ProgressDialog.Caption  := 'Printing Sales Order ...';
        PrintSO(PickAssy.SaleID);
        ProgressDialog.Value:= 2;
      end else begin
        ProgressDialog.Caption  := 'Printing Invoice ...';
        PrintInvoice(PickAssy.SaleID);
        ProgressDialog.Value:= 2;
      end;
    end;*)
    (*if AppEnv.CompanyPrefs.PrintDelDocketBarcodePick then begin
      ProgressDialog.Caption  := 'Printing Delivery Docket ...';
      PrintDeliveryDocket(PickAssy.ID);
      ProgressDialog.Value:= 3;
    end;*)
    (*if AppEnv.CompanyPrefs.PrintConNotesBarcodePick then begin
      ProgressDialog.Caption  := 'Printing Consignment Note ...';
      PrintPickingConNote(PickAssy.ID);
    end;*)
    ProgressDialog.Value:= 5;
  finally
    ProgressDialog.Free;
  end;
end;

procedure TfmBarcodePicking2.PrintDeliveryDocket(const PickingAssemblyID: integer);
var
  sSQL: string;
begin
  inherited;
  fbReportSQLSupplied := false;
//  sSQL := '~|||~Where PA.PickingAssemblyID=' + IntToStr(PickingAssemblyID) +
//    ' ORDER BY PAL.PackNumber, PAL.ProductId;'+
//  '~|||~Where PickingAssemblyID=' + IntToStr(PickingAssemblyID) + ';';
  sSQL := 'Where PA.PickingAssemblyID=' + IntToStr(PickingAssemblyID) +
    ' ORDER BY PAL.PackNumber, PAL.ProductId;';
  PrintTemplateReport('Picking Delivery Docket', sSQL, not(appEnv.Employee.PreviewAllreport), 1);
end;

procedure TfmBarcodePicking2.PrintInvoice(const SaleID: integer);
var
  sSQL: string;
begin
  inherited;
  fbReportSQLSupplied := false;
  sSQL := ' AND d2.SaleID=' + IntToStr(SaleID) + ';';
  PrintTemplateReport(tcdatautils.GetDefaultReport(11), sSQL, not(appEnv.Employee.PreviewAllreport), 1);
end;

procedure TfmBarcodePicking2.PrintPickingConNote(
  const PickingAssemblyID: integer);
var
  sSQL: string;
begin
  inherited;
  fbReportSQLSupplied := false;
  sSQL := ' Where PA.PickingAssemblyID=' + IntToStr(PickingAssemblyID) + 
    ' ORDER BY PAL.PackNumber, PAL.ProductId;';
  PrintTemplateReport('Picking ConNote', sSQL, not(appEnv.Employee.PreviewAllreport), 1);
end;

procedure TfmBarcodePicking2.PrintSO(const SaleID: integer);
var
  sSQL: string;
begin
  inherited;
  fbReportSQLSupplied := false;
  sSQL := ' AND d2.SaleID=' + IntToStr(SaleID) + ';';
  PrintTemplateReport(tcdatautils.GetDefaultReport(25), sSQL, not(appEnv.Employee.PreviewAllreport), 1);
end;

function TfmBarcodePicking2.ModifySale: boolean;
var
  bm: TBookmark;
  diff: double;
  SaleModified: boolean;
  MainId: integer;
  ProgressDialog: TProgressDialog;
begin                       
  result:= true;
  if memSummary.RecordCount = 0 then
    exit;

  if PickAssy.Sale.IsInvoice then begin
    if (PickAssy.Sale.TotalPaid <> 0) or (PickAssy.Sale.IsPaid) then begin
      CommonLib.MessageDlgXP_Vista('Can not update invoice as payments have been made',mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
      result:= false;
      exit;
    end
    else if (PickAssy.Sale.SaleDate <= AppEnv.CompanyPrefs.ClosingDateAR) then begin
      CommonLib.MessageDlgXP_Vista('Can not update invoice as period has been closed',mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
      result:= false;
      exit;
    end;
  end;

  { Update shipped qty on sale to match packed qty }
  SaleModified:= false;
  beginTransaction;
  try
  ProgressDialog:= TProgressDialog.Create(nil);
  try
      ProgressDialog.Caption  := 'Updating Sale ...';
      ProgressDialog.MinValue := 0;
      ProgressDialog.MaxValue := memSummary.RecordCount;
      ProgressDialog.Step     := 1;
      ProgressDialog.Execute;
      memSummary.DisableControls;
      try
        bm:= memSummary.GetBookmark;
        try
          memSummary.First;
          while not memSummary.Eof do begin
            diff:= memSummary.FieldByName('QtyRequired').AsFloat - memSummary.FieldByName('QtyPacked').AsFloat;
            if diff <> 0 then begin
              PickAssy.Sale.Lines.First;
              while not PickAssy.Sale.Lines.EOF do begin
                if PickAssy.Sale.Lines.ProductId = memSummary.FieldByName('ProductId').AsInteger then begin
                  if PickAssy.Sale.Lines.QtyShipped > diff then begin
                    PickAssy.Sale.Lines.QtyShipped:= PickAssy.Sale.Lines.QtyShipped - diff;
                    SaleModified:= true;
                    break;
                  end
                  else begin
                    diff:= diff - PickAssy.Sale.Lines.QtyShipped;
                    PickAssy.Sale.Lines.QtyShipped:= 0;
                    SaleModified:= true;
                  end;
                end;  
                PickAssy.Sale.Lines.Next;
              end;
            end;
            memSummary.Next;
            ProgressDialog.StepIt;
          end;
          memSummary.GotoBookmark(bm);
        finally
          memSummary.FreeBookmark(bm);
        end;
      finally
        memSummary.EnableControls;
      end;

      if SaleModified then begin
        if (not PickAssy.Sale.ValidateData) or (not PickAssy.Sale.Save) then begin
          CommonLib.MessageDlgXP_Vista('Could not update sales shipped quantities: '+PickAssy.Sale.ResultStatus.Messages ,mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
          CancelChanges;
          result:= false;
          exit;
        end;
      end;

    { If sales order, do we need to convert to invoice .. }
    if PickAssy.Sale.IsSalesOrder and
      AppEnv.CompanyPrefs.AutoConvertSOtoInvoiceBarcodePick then begin
      ProgressDialog.Caption:= 'Concerting Sales Order to Invoice ...';
      ProgressDialog.Value:= 0;
      if TSalesOrder(PickAssy.Sale).IsBO then
        MainId:= TSalesOrder(PickAssy.Sale).GetBackOrderMainSOId
      else
        MainId:= TSalesOrder(PickAssy.Sale).Id;

      PickAssy.Sale.ResultStatus.Clear;
      {ConvertedSOInvoiceID:= TSalesOrder(PickAssy.Sale).CopySalesOrderToInvoice(MainId);}
      ConvertedSOInvoiceID:= TSalesOrder(PickAssy.Sale).CopyToInvoice(MainID);
      if not PickAssy.Sale.ResultStatus.OperationOk then begin
        CommonLib.MessageDlgXP_Vista('Could not convert sales order to invoice: '+
          PickAssy.Sale.ResultStatus.Messages ,mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
        result:= false;
        CancelChanges;
        exit;
      end;
      if (not PickAssy.Sale.ValidateData) or (not PickAssy.Sale.Save) then begin
        CommonLib.MessageDlgXP_Vista('Could not Save changes to sales order: '+PickAssy.Sale.ResultStatus.Messages ,mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
        CancelChanges;
        result:= false;
        exit;
      end;
    end;
    CommitTransaction;
    finally
      ProgressDialog.Free;
    end;
  Except
    RollbackTransaction;
  end;
end;

procedure TfmBarcodePicking2.CancelChanges;
var
  Id: integer;
begin
  Id:= PickAssy.Id;
  self.RollbackTransaction;
  PickAssy.Closedb;
  PickAssy.Load(Id);
  PopulateProductSummary;
end;

procedure TfmBarcodePicking2.CreateMemSummaryStructure;
begin
  memSummary.Close;
  memSummary.FieldDefs.Clear;
  with memSummary.FieldDefs.AddFieldDef do begin
    Name     := 'ProductId';
    DataType := ftLargeint;
  end;
  with memSummary.FieldDefs.AddFieldDef do begin
    Name     := 'ProductName';
    DataType := ftString;
    Size     := 255;
  end;
  with memSummary.FieldDefs.AddFieldDef do begin
    Name     := 'ProductDescription';
    DataType := ftString;
    Size     := 255;
  end;
  with memSummary.FieldDefs.AddFieldDef do begin
    Name     := 'QtyRequired';
    DataType := ftFloat;
  end;
  with memSummary.FieldDefs.AddFieldDef do begin
    Name     := 'QtyPacked';
    DataType := ftFloat;
  end;
  with memSummary.FieldDefs.AddFieldDef do begin
    Name     := 'UOM';
    DataType := ftString;
    Size     := 255;
  end;
  with memSummary.FieldDefs.AddFieldDef do begin
    Name     := 'UOMId';
    DataType := ftLargeint;
  end;
  with memSummary.FieldDefs.AddFieldDef do begin
    Name     := 'UOMMultiplier';
    DataType := ftFloat;
  end;
  with memSummary.FieldDefs.AddFieldDef do begin
    Name     := 'Done';
    DataType := ftBoolean;
  end;
  memSummary.CreateTable;
  memSummary.Open;
  memSummary.Emptytable;
end;

procedure TfmBarcodePicking2.PopulateProductSummary;
var
  bm: TBookmark;
begin
  { build mem table summary of products/qty required for current sale }
  memSummary.DisableControls;
  try
    memSummary.EmptyTable;
    if Assigned(PickAssy.Sale) then begin
      bm:= PickAssy.Sale.Lines.Dataset.GetBookmark;
      try
        PickAssy.Sale.Lines.Dataset.First;
        TotalQty:= 0;
        TotalPackedQty:= 0;
        while not PickAssy.Sale.Lines.Dataset.Eof do begin
          if memSummary.Locate('ProductId',PickAssy.Sale.Lines.ProductId,[]) then begin
            memSummary.Edit;
            memSummary.FieldByName('qtyRequired').AsFloat:=
              memSummary.FieldByName('qtyRequired').AsFloat + PickAssy.Sale.Lines.QtyShipped;
            memSummary.FieldByName('Done').AsBoolean:=
              memSummary.FieldByName('qtyPacked').AsFloat >= memSummary.FieldByName('qtyRequired').AsFloat;
            memSummary.Post;
            TotalQty:= TotalQty + PickAssy.Sale.Lines.QtyShipped;
          end
          else begin
            memSummary.Insert;
            memSummary.FieldByName('ProductId').AsInteger:= PickAssy.Sale.Lines.ProductId;
            memSummary.FieldByName('ProductName').AsString:= PickAssy.Sale.Lines.ProductName;
            memSummary.FieldByName('ProductDescription').AsString:= PickAssy.Sale.Lines.ProductDescription;
            memSummary.FieldByName('qtyRequired').AsFloat:= PickAssy.Sale.Lines.QtyShipped;
            TotalQty:= TotalQty + PickAssy.Sale.Lines.QtyShipped;
            if PickAssy.Lines.Count > 0 then begin
              memSummary.FieldByName('qtyPacked').AsFloat:=
                PickAssy.QtyPackedForProduct(PickAssy.Sale.Lines.ProductId);
              TotalPackedQty:= TotalPackedQty + memSummary.FieldByName('qtyPacked').AsFloat;
            end
            else
              memSummary.FieldByName('qtyPacked').AsFloat:= 0;

            (*memSummary.FieldByName('UOM').AsString:= PickAssy.Sale.Lines.Product.UOMList.BaseUnitName;*)
//            With  PickAssy.Sale.Lines.Product.UOMList do begin
//              if PickAssy.Sale.Lines.Product.UOMList.BaseUnitName <> '' then
//                memSummary.FieldByName('UOM').AsString:=BaseUnitName
//              else memSummary.FieldByName('UOM').AsString:=UOMName;
//            end;
            memSummary.FieldByName('UOMID').AsInteger := PickAssy.Sale.Lines.UnitOfMeasureID;
            memSummary.FieldByName('UOM').AsString := PickAssy.Sale.Lines.UnitOfMeasure;
            memSummary.FieldByName('UOMMultiplier').AsFloat := PickAssy.Sale.Lines.UOMMultiplier;

            memSummary.FieldByName('Done').AsBoolean:=
              (memSummary.FieldByName('qtyPacked').AsFloat >= memSummary.FieldByName('qtyRequired').AsFloat) and (memSummary.FieldByName('qtyRequired').AsFloat <>0);
            memSummary.Post;
          end;
          PickAssy.Sale.Lines.Dataset.Next;
        end;
        PickAssy.Sale.Lines.Dataset.GotoBookmark(bm);
      finally
        PickAssy.Sale.Lines.Dataset.FreeBookmark(bm);
      end;
    end;  
  finally
    memSummary.EnableControls;
  end;
end;

procedure TfmBarcodePicking2.GetProductPicture(const aProductId: integer);
begin
  if aProductId <> ProductPicture.ProductID then begin
    ProductPicture.LoadSelect('partId = ' + IntToStr(aProductId));
    if (ProductPicture.Count > 0) and Assigned(ProductPicture.PictureStream) and (ProductPicture.PictureStream.Size > 0) then begin
      imgProduct.Picture.Bitmap.LoadFromStream(ProductPicture.PictureStream);
    end else
      imgProduct.Picture:= nil;
  end;
end;

procedure TfmBarcodePicking2.grdLinesRowChanged(Sender: TObject);
begin
  inherited;
  GetProductPicture(qryPickingAssemblyLinesProductID.AsInteger);
end;

procedure TfmBarcodePicking2.btnConNoteClick(Sender: TObject);
begin
  inherited;
  if Assigned(PickAssy.Sale) then begin
    self.BeginTransaction;
    if UpdateSaleConsignmentDetails(PickAssy.Sale) then begin
      PickAssy.Sale.PostDB;
      self.CommitTransaction;
      (*with TProgressDialog.NewProgressbar do try
        StepIt;
        if (not PickAssy.Sale.ValidateData) or (not PickAssy.Sale.Save) then begin
          CommonLib.MessageDlgXP_Vista('Could not update sale consignment details: '+PickAssy.Sale.ResultStatus.Messages ,mtWarning,[mbOk],0, nil, '' , '', False, nil, '', appenv.Soundobj.DonkSoundFilename);
          CancelChanges;
        end;
      finally
          CloseDialog;
          Free;
      end;*)
    end
    else begin
      self.RollbackTransaction;
    end;
  end;
  edtBarcodeInput.SetFocus;
end;

procedure TfmBarcodePicking2.btnControlBarCodesClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    PrintTemplateReport('Pick and Pack Control Barcodes', '', not(appEnv.Employee.PreviewAllreport), 1);
  finally
    EnableForm;
  end;   
end;

procedure TfmBarcodePicking2.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmBarcodePicking2.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = VK_RETURN) and (Shift = [ssCtrl]) and (btnStartNewPicking.Enabled) then begin
    btnStartNewPickingClick(btnStartNewPicking);
  end;
end;

procedure TfmBarcodePicking2.grdSummaryCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if memSummary.Active then
    if memSummary.FieldByName('Done').AsBoolean then
      ABrush.Color:= $0080FF80; { light green }
    if memSummary.FieldByName('qtyRequired').AsFloat =0 then
      ABrush.Color:= $00A8FFFF; { light yellow }
  if grdSummary.Enabled = false then
    AFont.Color := clGray
  else    AFont.Color := clBlack;
end;

procedure TfmBarcodePicking2.edtBarcodeInputKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  edtBarcodeInput.Modified:= true;
end;

procedure TfmBarcodePicking2.edtBarcodeInputExit(Sender: TObject);
var
  keyChar: char;
begin
  inherited;
  if TEdit(Sender).Modified then begin
    TEdit(Sender).Modified:= false;
    keyChar:= chr(VK_RETURN);
    self.edtBarcodeInputKeyPress(edtBarcodeInput, keyChar);
  end;
end;

procedure TfmBarcodePicking2.edtQtyKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  edtQty.Modified:= true;
end;

procedure TfmBarcodePicking2.edtQtyExit(Sender: TObject);
(*var
  keyChar: char;*)
begin
  inherited;
  if edtQty.Modified then begin
    edtQty.Modified:= false;
    (*keyChar:= chr(VK_RETURN);
    self.edtQtyKeyPress(edtBarcodeInput, keyChar);*)
    ProcessQty;
  end;
end;

procedure TfmBarcodePicking2.grdSummaryDblClick(Sender: TObject);
begin
  inherited;
  if not memSummary.FieldByName('Done').AsBoolean then begin
    if PickAssy.Sale.Lines.Dataset.Locate('ProductId',memSummary.FieldByName('ProductId').AsInteger,[]) then begin

//      with PickAssy.Sale.Lines.Product.UOMList do
//        if   BaseUnitID <> 0 then
//          AddOrUpdateLine(memSummary.FieldByName('QtyRequired').AsFloat -memSummary.FieldByName('QtyPacked').AsFloat,1, PickAssy.Sale.Lines.ProductId,BaseUnitID, PackNumber)
//        else
//          AddOrUpdateLine(memSummary.FieldByName('QtyRequired').AsFloat -memSummary.FieldByName('QtyPacked').AsFloat,1, PickAssy.Sale.Lines.ProductId,UnitId, PackNumber);

      AddOrUpdateLine(memSummary.FieldByName('QtyRequired').AsFloat -memSummary.FieldByName('QtyPacked').AsFloat,memSummary.FieldByName('UOMMultiplier').AsFloat, PickAssy.Sale.Lines.ProductId,memSummary.FieldByName('UOMID').asInteger, PackNumber);


     (* AddOrUpdateLine(memSummary.FieldByName('QtyRequired').AsFloat -
        memSummary.FieldByName('QtyPacked').AsFloat,
        1, PickAssy.Sale.Lines.ProductId,
        PickAssy.Sale.Lines.Product.UOMList.BaseUnitID, PackNumber);*)
    end;
  end;
end;

function TfmBarcodePicking2.AllPickingDone: boolean;
var
  bm: TBookmark;
begin
  result:= true;
  if memSummary.Active and (not memSummary.IsEmpty) then begin
    memSummary.DisableControls;
    bm:= memSummary.GetBookmark;
    try
      memSummary.First;
      while not memSummary.Eof do begin
        if not memSummary.FieldByName('Done').AsBoolean then begin
          result:= false;
          break;
        end;
        memSummary.Next;
      end;
    finally;
      memSummary.GotoBookmark(bm);
      memSummary.FreeBookmark(bm);
      memSummary.EnableControls;
    end;
  end;
end;


function TfmBarcodePicking2.getisSaleInvoice: Boolean;
begin
  result := PickAssy.Sale.IsInvoice;
end;

function TfmBarcodePicking2.getIsSaleSaleSOrder: Boolean;
begin
  result := PickAssy.Sale.IsSalesOrder;
end;


procedure TfmBarcodePicking2.updateForm;
begin
  grdSummary.enabled        := pickingstate>=tPackingStarted;
  grdLines.enabled          := pickingstate>=tPackingStarted;
  edtBarcodeInput.enabled   := pickingstate>=tNew;
  btnStartNewPicking.enabled:= pickingstate>=tLoggedin;
  btnConNote.enabled        := pickingstate>=tSaleSelected;
  edtQty.enabled            := pickingstate>=tPackingStarted;
  lblPackno.visible         := pickingstate=tPackingStarted;
  lblPacknoCaption.visible  := pickingstate=tPackingStarted;
  grdLines.Repaint;
  grdSummary.Repaint;
end;

procedure TfmBarcodePicking2.setpickingstate(const Value: Tpickingstate);
begin
  fpickingstate := Value;
  updateForm;
end;

procedure TfmBarcodePicking2.grdLinesCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  RefreshGridstatus(Sender, AFont);
end;

procedure TfmBarcodePicking2.grdLinesCalcTitleAttributes(Sender: TObject;
  AFieldName: String; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  inherited;
  RefreshGridstatus(Sender, AFont);
end;

procedure TfmBarcodePicking2.grdSummaryCalcTitleAttributes(Sender: TObject;
  AFieldName: String; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  inherited;
  RefreshGridstatus(Sender, AFont);
end;

procedure TfmBarcodePicking2.RefreshGridstatus(Sender: TObject;AFont: TFont);
begin
  if not(sender is twwDBGrid) then exit;
  if twwDBGrid(Sender).Enabled = false then
    AFont.Color := clGray
  else    AFont.Color := clBlack;
end;

procedure TfmBarcodePicking2.grdLinesDblClick(Sender: TObject);
begin
  inherited;
  PackNumber := qryPickingAssemblyLinesPackNumber.AsInteger;
end;

procedure TfmBarcodePicking2.setPackNumber(const Value: Integer);
begin
  fiPackNumber := Value;
  lblPackno.Caption := IntToStr(Packnumber);
end;

procedure TfmBarcodePicking2.Processqty;
begin
    ProcessQuantity(edtQty.FloatValue);
    edtQty.Text:= '';
    edtBarcodeInput.SetFocus;
end;

procedure TfmBarcodePicking2.FormResize(Sender: TObject);
begin
  inherited;
  pnlDetail.Height:=
    Trunc((ClientHeight - pnlMaster.Height - pnlButtons.Height) / 2);
end;

initialization

  RegisterClassOnce(TfmBarcodePicking2);

end.



