unit frmStockTransferEntry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmStockTransferEntryBase, DB, MemDS, DBAccess, MyAccess,ERPdbComponents, DNMSpeedButton,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, Mask, DBCtrls,
  StdCtrls, wwdblook, Shader, ExtCtrls, DNMPanel, Menus, AdvMenus,
  DataState, SelectionDialog, AppEvnts, busobjStockTransferEntry,BusObjBase,
  wwcheckbox, ImgList, wwdbedit, ProgressDialog, BaseInputForm, ERPDbLookupCombo;

type
  TfmStockTransferEntry = class(TfmStockTransferEntryBase)
    QryBatchnoTo: TERPQuery;
    QryBatchNoTobatchnumber: TWideStringField;
    QryBatchNoFrom: TERPQuery;
    QryBatchNoFrombatchnumber: TWideStringField;
    qryBinLocationFrom: TERPQuery;
    qryBinLocationFromBinLocation: TWideStringField;
    QrybinLocationTo: TERPQuery;
    QrybinLocationToBinLocation: TWideStringField;
    qryBinLocationFromBinnumber: TWideStringField;
    QrybinLocationToBinnumber: TWideStringField;
    QryBatchNoFromExpiryDate: TWideStringField;
    QryBatchnoToExpiryDate: TWideStringField;
    cboBatchnumberFrom: TwwDBLookupCombo;
    cbobatchnumberto: TwwDBLookupCombo;
    cboBinLocation: TwwDBLookupCombo;
    cboBinLocationTo: TwwDBLookupCombo;
    btnAutoFill: TDNMSpeedButton;
    tblDetailsBatchNoFrom: TWideStringField;
    tblDetailsexpiryDateFrom: TDateTimeField;
    tblDetailsBinLocationFrom: TWideStringField;
    tblDetailsBinNumberFrom: TWideStringField;
    tblDetailsBatchNoTo: TWideStringField;
    tblDetailsexpiryDateTo: TDateTimeField;
    tblDetailsBinLocationTo: TWideStringField;
    tblDetailsBinNumberTo: TWideStringField;
    tblDetailsAllocatedQty: TFloatField;
    tblDetailsTransferAllocatedQty: TFloatField;
    tblDetailsSerialNumber: TWideStringField;
    tblDetailsUOMAllocatedQty: TFloatField;
    tblDetailsTransferUOMAllocatedQty: TFloatField;
    chkhideBarcode: TwwCheckBox;
    Bevel3: TBevel;
    Label7: TLabel;
    tblDetailsProductPrintName: TWideStringField;
    tblDetailsSerialnos: TWideMemoField;
    procedure FormCreate(Sender: TObject);
    procedure cbobatchnumbertoCloseUp(Sender: TObject; LookupTable,FillTable: TDataSet; modified: Boolean);
    procedure cboBatchnumberFromCloseUp(Sender: TObject; LookupTable,FillTable: TDataSet; modified: Boolean);
    procedure cboBinLocationCloseUp(Sender: TObject; LookupTable,FillTable: TDataSet; modified: Boolean);
    procedure cboBinLocationToCloseUp(Sender: TObject; LookupTable,FillTable: TDataSet; modified: Boolean);
    procedure SubformDetailsIButtonClick(Sender: TObject);
    procedure cboBinLocationNotInList(Sender: TObject;LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
    procedure cboBinLocationToNotInList(Sender: TObject;LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
    procedure btnAutoFillClick(Sender: TObject);
    procedure tblMasterAfterInsert(DataSet: TDataSet);
    procedure chkhideBarcodeClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure tblDetailsAfterOpen(DataSet: TDataSet);
(*    procedure cboBarcodeNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: String; var Accept: Boolean);*)
  private
    (*Procedure CreateBin(Const ForFromBin :Boolean);overload;*)
    Procedure CreateBin(Const fiClassID:Integer; const FsBinLocation:STring; const fsBinnumber :String; LookupQry :TERPQuery);
    Procedure AutoTransferDeptList;
    procedure initclasslist(Sender: TObject);
    procedure SelectclassIDs(Sender: TwwDbGrid);
  Protected
    Procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    Procedure ShowStatus(Const Value :STring);override;
    Procedure OpenLookups;override;
    procedure SetGridColumns;Override;
    procedure Initform;Override;
    procedure initStockQtysLocationsReport(Sender: TObject);Override;
    Procedure AfterFormShow; override;
    (*function StockTransferLines :TSTELines;Override;*)

  public
    class function AutoTransfer(xProductID, xDefaultclassId: Integer;AssetAccountname: String;ClassIDs:String; IgnoreAvailable: boolean = false): Boolean;
    procedure Setcolumn(columnVisible: Boolean; columnName: string; displaylabel:String = '');
  end;

implementation

uses BusObjConst, frmBinLocation, CommonLib,
  StockQtysLocationsReport, ClassListForm, AppEnvironment,
  (*frmBarcodePopUp, *)FormFactory, busobjPQA, FastFuncs, frmAllocationExtender,
  ProductQtyLib, DefaultClassObj, BusObjStock, tcDataUtils,
  ProductListExpressForm, frmPartsFrm , tcConst, PartsPriceMatrixLib,
  frmpartsPriceMatrixInput, BusObjProductbin, PartCalcFormulaObj, StockLib, CommonFormLib;


{$R *.dfm}

procedure TfmStockTransferEntry.DoBusinessObjectEvent(const Sender: TDatasetBusObj;
  const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Change) and (Value = BusObjEventVal_ProductBinNotFound) then begin
    if sender is TPQABins then begin {this is for the stockmovement when processing}
      CreateBin(TPQABins(Sender).DepartmentID ,TPQABins(Sender).fsbinlocation, TPQABins(Sender).fsBinnumber, nil);
      TPQABins(Sender).BinId := TProductBin.IDToggle(TPQABins(Sender).DepartmentID ,TPQABins(Sender).fsbinlocation, TPQABins(Sender).fsBinnumber);
    end;
  end;
end;
procedure TfmStockTransferEntry.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  GuiPrefs.Node['Options.HideBarcode'].asBoolean := chkhideBarcode.checked;
end;

procedure TfmStockTransferEntry.FormCreate(Sender: TObject);
begin
  inherited;
  StockTransfer.AutoTransferDeptList  := AutoTransferDeptList;
  cboAccount.Options := cboAccount.Options + [lotitles];
  cboAccount.Selected.Clear;
  cboAccount.Selected.Add(SelectedText('AccountName' , 'Account name', AppEnv.companyprefs.AccountNamecolumnDropdownWidth        , ''));
  cboAccount.Selected.Add(SelectedText('Type'        , 'Type'        , AppEnv.companyprefs.AccountTypecolumnDropdownWidth        , ''));
  cboAccount.Selected.Add(SelectedText('Description' , 'Description' , AppEnv.companyprefs.AccountDescriptioncolumnDropdownWidth , ''));
end;

procedure TfmStockTransferEntry.FormShow(Sender: TObject);
begin
  inherited;
  chkhideBarcode.checked :=GuiPrefs.Node['Options.HideBarcode'].asBoolean;
  chkhideBarcodeClick(chkhideBarcode);
end;

procedure TfmStockTransferEntry.SetGridColumns;
begin
  inherited;
  (*GuiPrefs.DbGridElement[SubformDetails].RemoveField(tbldetailsAllocatedQty.fieldname);
  GuiPrefs.DbGridElement[SubformDetails].RemoveField(tbldetailstransferAllocatedQty.fieldname);*)
end;


(*procedure TfmStockTransferEntry.CreateBin(Const ForFromBin :Boolean);
var
   BinForm :TfmbinLocation;
begin
    BinForm := TfmbinLocation(GetComponentByClassName('TfmbinLocation'));
    if not assigned(BinForm) then exit;
    BinForm.Keyid := 0;
    BinForm.pnlHeader.color         := subformDetails.titlecolor;
    BinForm.pnlsingleBin.color      := subformDetails.titlecolor;
    BinForm.pnlGenerateBin.color    := subformDetails.titlecolor;
    BinForm.pnlFooter.color         := subformDetails.titlecolor;
    if ForFromBin then begin
      BinForm.ClassId               := StockTransfer.Lines.classidFrom;
      BinForm.edtBinLocation.Text   := StockTransfer.Lines.BinLocationFrom;
      BinForm.edtBinnumber.Text     := StockTransfer.Lines.binNumberfrom;
    end else begin
      BinForm.ClassId               := StockTransfer.Lines.classIdTo;
      BinForm.edtBinLocation.Text   := StockTransfer.Lines.BinLocationTo;
      BinForm.edtBinnumber.Text     := StockTransfer.Lines.binNumberTo;
    end;
    BinForm.ShowModal;
end;*)

procedure TfmStockTransferEntry.OpenLookups;
begin
  inherited;
  With QryBatchNoFrom do  begin
    if Active then Close;
    SQL.clear;
    SQl.add('select Distinct tblPQADetails.value as Batchnumber,');
    SQl.add('DATE_FORMAT(ifnull(tblPQADetails.expiryDate , 0),'+ QuotedStr(GetDate_FormatofMYSQL)+') as ExpiryDate');
    SQl.add('from tblPQADetails inner join tblPQA on  tblPQA.PQAID = tblPQADetails.PQAID');
    SQl.add('where tblPQADetails.PQAtype = "Batch"');
    SQl.add('and tblPQA.ProductID =  ' + IntToStr(StockTransfer.Lines.ProductID));
    SQl.add('and tblPQA.DepartmentID = ' + IntToStr(StockTransfer.Lines.ClassIDFrom));
    Open;
  end;

  With QryBatchNoTo do begin
    if Active then Close;
    SQL.clear;
    SQl.add('select Distinct tblPQADetails.value as Batchnumber,');
    SQl.add('DATE_FORMAT(ifnull(tblPQADetails.expiryDate , 0),'+ QuotedStr(GetDate_FormatofMYSQL)+') as ExpiryDate');
    SQl.add('from tblPQADetails inner join tblPQA on  tblPQA.PQAID = tblPQADetails.PQAID');
    SQl.add('where tblPQADetails.PQAtype = "Batch"');
    SQl.add('and tblPQA.ProductID =  ' + IntToStr(StockTransfer.Lines.ProductID));
    SQl.add('and tblPQA.DepartmentID = ' + IntToStr(StockTransfer.Lines.ClassIDTo));
    Open;
  end;
  With qryBinLocationFrom do
    if (Params.ParamByName('ClassID').AsInteger <> StockTransfer.Lines.ClassIDFrom) or
         (Params.ParamByName('PartsId').AsInteger <> StockTransfer.Lines.ProductID) then begin
      if Active then Close;
      Params.ParamByName('ClassID').AsInteger := StockTransfer.Lines.ClassIDFrom;
      Params.ParamByName('PartsId').AsInteger := StockTransfer.Lines.ProductID;
      Open;
    End;

  With qryBinLocationto do
    if (Params.ParamByName('ClassID').AsInteger <> StockTransfer.lines.ClassIDTo)  then begin
      if Active then Close;
      Params.ParamByName('ClassID').AsInteger := StockTransfer.lines.ClassIDTo;
      Open;
    End;
  if (TSTELinesFlat(StockTransfer.Lines).BinLocationTo = '') and (TSTELinesFlat(StockTransfer.Lines).BinLocationFrom<>'') then begin
     if qryBinLocationto.Locate('binlocation;binnumber' , vararrayof([TSTELinesFlat(StockTransfer.Lines).BinLocationFrom,TSTELinesFlat(StockTransfer.Lines).BinnumberFrom]), []) then begin
      TSTELinesFlat(StockTransfer.Lines).BinLocationTo := TSTELinesFlat(StockTransfer.Lines).BinLocationFrom;
      TSTELinesFlat(StockTransfer.Lines).BinnumberTo := TSTELinesFlat(StockTransfer.Lines).BinnumberFrom;
     end else if qryBinLocationto.recordcount > 0 then begin
       qryBinLocationto.First;
       TSTELinesFlat(StockTransfer.Lines).BinLocationTo := qryBinLocationtoBinLocation.asString;
       TSTELinesFlat(StockTransfer.Lines).BinnumberTo := qryBinLocationtoBinNumber.asString;
     end;
  end;
end;

procedure TfmStockTransferEntry.cbobatchnumbertoCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
    TSTELinesFlat(StockTransfer.Lines).BatchNoto:= Lookuptable.FieldByname('Batchnumber').asString;
    if Lookuptable.FieldByname('ExpiryDate').asString <> '' then
      TSTELinesFlat(StockTransfer.Lines).expiryDateto := strToDate(Lookuptable.FieldByname('ExpiryDate').asString)
    else begin
      StockTransfer.Lines.NullWhenDateIs0:= True;
      TSTELinesFlat(StockTransfer.Lines).expiryDateto := 0;

    end;
end;

procedure TfmStockTransferEntry.cboBatchnumberFromCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
    TSTELinesFlat(StockTransfer.Lines).BatchNoFrom:= Lookuptable.FieldByname('Batchnumber').asString;
    if Lookuptable.FieldByname('ExpiryDate').Asstring <> '' then
      TSTELinesFlat(StockTransfer.Lines).expiryDateFrom := StrtoDate(Lookuptable.FieldByname('ExpiryDate').Asstring)
    else begin
      StockTransfer.Lines.NullWhenDateIs0:= True;
      TSTELinesFlat(StockTransfer.Lines).expiryDateFRom := 0;
    end;
end;

procedure TfmStockTransferEntry.cboBinLocationCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
    TSTELinesFlat(StockTransfer.Lines).binlocationFrom := LookupTable.Fieldbyname('Binlocation').asString;
    TSTELinesFlat(StockTransfer.Lines).BinNumberFrom := LookupTable.Fieldbyname('binnumber').asString;
end;

procedure TfmStockTransferEntry.cboBinLocationToCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
  TSTELinesFlat(StockTransfer.Lines).binlocationTo := LookupTable.Fieldbyname('Binlocation').asString;
  TSTELinesFlat(StockTransfer.Lines).BinNumberto := LookupTable.Fieldbyname('binnumber').asString;

end;

Procedure TfmStockTransferEntry.AutoTransferDeptList;
begin
    (*With TClassListGUI(GetcomponentbyclassName('TClassListGUI' , False, nil , False)) do try
        Transferfromclass := cboClassFromQry.FieldByName('ClassID').AsInteger;
        SpecialNote := 'Hold Down CTRL to select multiple ' + AppEnv.DefaultClass.ClassHeading + ' for Autostock transfer.';
        grdmain.Options :=grdmain.Options + [dgMultiselect];
        Caption := AppEnv.DefaultClass.ClassHeading + ' for Autostock Transfer';
        showModal;
        StockTransfer.AutoTransfertoClassIDs  :=SelectedClassIDs;
    finally
        Free;
    end;*)
    OpenERPListFormSingleselectModal('TClassListGUI',SelectclassIDs , initclasslist);
end;
procedure TfmStockTransferEntry.SelectclassIDs(Sender: TwwDbGrid);
begin
  if not (Sender.owner is   TClassListGUI) then exit;
  StockTransfer.AutoTransfertoClassIDs  :=TClassListGUI(Sender.Owner).selectedIds('clasSID');
end;
procedure TfmStockTransferEntry.initclasslist(Sender: TObject);
begin
  if not(Sender is  TClassListGUI) then exit;
  TClassListGUI(Sender).Transferfromclass := Stocktransfer.TransferfromClassId;//cboClassFromQry.FieldByName('ClassID').AsInteger;
  TClassListGUI(Sender).SpecialNote := 'Hold Down CTRL to select multiple ' + AppEnv.DefaultClass.ClassHeading + ' for Autostock transfer.';
  TClassListGUI(Sender).grdmain.Options := TClassListGUI(Sender).grdmain.Options + [dgMultiselect];
  TClassListGUI(Sender).Caption := AppEnv.DefaultClass.ClassHeading + ' for Autostock Transfer';
end;
procedure TfmStockTransferEntry.btnAutoFillClick(Sender: TObject);
begin
  inherited;
    lblMessage.Caption := 'Stock transfer in Process....';
    lblMessage.visible := true;
    lblNote.visible := False;
    Try
        if  StockTransfer.AutoTransfer(true)  then
            if StockTransfer.Lines.count > 0 then begin
              Exit;
            end;
        CommonLib.MessageDlgXP_Vista('It would appear that there are no items to be added to the Stock Transfer.' + chr(13)+chr(13)+
            'Have you checked the following things?'+chr(13)+chr(13) +
            '1) Setting of the re-order points, preferred amounts and re-order amounts.' + chr(13)+
            '2) You do not have enough stock to give to the other departments' + chr(13)+
            '3) The Department you are transferring to does not know about the' + chr(13)+
            '     products you are trying to transfer.' + chr(13)+chr(13)+
            'If one of the above options applies to you, You can update ' + chr(13)+
            '    Option 1 in the Product form.  ' + chr(13)+
            '    Option 2 requires you to Purchase Products via Purchase or Smart Orders and ' + chr(13)+
            '    Option 3 can be done through the Price Update System.', mtWarning, [mbOK], 0, nil , '', '', false, nil , '' , '' , 500);
    Finally
        lblMessage.visible := False;
        lblNote.Visible := true;
    end;
end;

procedure TfmStockTransferEntry.AfterformShow;
begin
  inherited;
  if StockTransfer.processed then btnhold.caption := '&Save' else btnhold.caption := '&Hold';
end;

Class Function TfmStockTransferEntry.AutoTransfer(xProductID:Integer; xDefaultclassId:Integer; AssetAccountname:String;ClassIDs:String; IgnoreAvailable: boolean):Boolean;
var
  Form:TfmStockTransferEntry;
begin
//DENE:  IGNORE the check for available qty in the transferfrom Department
//This is set from both frmparts and the frm stock transfer

  Try
    Result := True;
    Form := TfmStockTransferEntry(getcomponentbyclassname('TfmStockTransferEntry'));
    if not (Assigned(Form)) then exit;
    if Form.visible then begin
        MessageDlgXP_Vista('Please Close the Stock Transfer Before Auto Transfer' , mtWarning , [mbok] , 0);
        Form.BringtoFront;
        Exit;
    end;
    Form.keyID := 0;
    Form.FormStyle := fsMDIChild;
    Form.BringtoFront;
    if (xProductID=0) and ( xDefaultclassId=0) then begin
        Form.btnAutoFill.click;
    end else begin
      Form.StockTransfer.TransferFromClassId := xDefaultclassId;
      Form.StockTransfer.TransferFromClassName := tcDataUtils.GetClassName(xDefaultclassId);
      Form.StockTransfer.Accountname := AssetAccountname;
      Form.StockTransfer.Lines.New;
      Form.StockTransfer.Lines.ProductID := xProductID;
      Form.StockTransfer.AutoTransfertoClassIDs  := ClassIDs; //   '(' +ClassIDs+')';
      Form.StockTransfer.DoAutoTransfer(IgnoreAvailable);
    end;
  Except
      on E:Exception do begin
          Result := False;
      end;
  end;
end;
procedure TfmStockTransferEntry.ShowStatus(const Value: STring);
begin
  lbltimerMsg := lblMessage;
  inherited;
end;

(*function TfmStockTransferEntry.StockTransferLines: TSTELines;
begin
  REsult :=StockTransfer.Lines;
end;*)

procedure TfmStockTransferEntry.SubformDetailsIButtonClick(
  Sender: TObject);
begin
  //inherited;
  if CommonLib.MessageDlgXP_Vista('Do you wish to delete this record?', mtconfirmation, [mbYes, mbNo], 0)  = mrNo then exit;
  StockTransfer.Lines.Deleted := true;
  StockTransfer.Lines.PostDB;
end;

procedure TfmStockTransferEntry.tblDetailsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if StockTransfer.Transfertype = StockTransfertypetoStr(sttGen) then
     if StockTransfer.AnylinehasSerialNos then begin
      tblDetailsserialnos.visible := true;
      GuiPrefs.DbGridElement[SubformDetails].UnHideField(tblDetailsserialnos.fieldname);
     end;
end;

procedure TfmStockTransferEntry.tblMasterAfterInsert(DataSet: TDataSet);
begin
  inherited;
  StockTransfer.Transfertype := StockTransfertypetoStr(sttGen);
end;

procedure TfmStockTransferEntry.Setcolumn(columnVisible: Boolean; columnName, displaylabel: String);
begin
  if columnVisible then begin
    if displaylabel <> '' then begin
      if SubformDetails.ColumnByName(columnName) = nil then begin
        if tbldetails.findfield(columnName) <> nil then
          tbldetails.fieldbyname(columnName).DisplayLabel :=DisplayLabel;
      end else begin
        SubformDetails.ColumnByName(columnName).DisplayLabel := DisplayLabel;
      end;
    end;
  end else begin
    guiprefs.DbGridElement[SubformDetails].RemoveField(columnName);
  end;
end;

procedure TfmStockTransferEntry.cboBinLocationNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
begin
  inherited;
  CreateBin(StockTransfer.Lines.classidFrom, TSTELinesFlat(StockTransfer.Lines).BinLocationFrom, TSTELinesFlat(StockTransfer.Lines).binNumberfrom, TERPQuery(cboBinLocation.lookuptable))
end;

procedure TfmStockTransferEntry.cboBinLocationToNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
begin
  inherited;
  CreateBin(StockTransfer.Lines.classIdTo, TSTELinesFlat(StockTransfer.Lines).BinLocationTo, TSTELinesFlat(StockTransfer.Lines).binNumberTo ,TERPQuery(cboBinLocationTo.lookuptable));
end;

procedure TfmStockTransferEntry.chkhideBarcodeClick(Sender: TObject);
begin
  inherited;
  if chkhideBarcode.checked then begin
    tblDetailsPartBarcode.Visible := False;
  end else begin
    tblDetailsPartBarcode.Visible := TRue;
    tblDetailsPartBarcode.Index :=0;
  end;
end;

procedure TfmStockTransferEntry.CreateBin(const fiClassID: Integer;const FsBinLocation, fsBinnumber: String; LookupQry :TERPQuery);
var
  Form : TfmbinLocation;
begin
 Form:= TfmbinLocation(GetComponentByClassName('TfmbinLocation',TRue, Self));
 try
        //AttachObserver(Self);
        if Form.visible then
          Form.close;
        Form.Keyid               := 0;
        Form.Formcolor           := Self.Color;
        Form.ClassId             := fiClassID;
        Form.edtBinLocation.text := fsBinlocation;
        Form.edtBinnumber.text   := fsBinnumber;
        Form.ShowModal;
        if LookupQry <> nil then begin
          closeDB(LookupQry);
          OpenDB(LookupQry);
        end;
 finally
     FreeandNil(Form);
 end;
end;

procedure TfmStockTransferEntry.Initform;
var
  QueryNamesNotToOpen: array of string;
begin
      Setlength(QueryNamesNotToOpen, 2);
      QueryNamesNotToOpen[0] := 'tblMaster';
      QueryNamesNotToOpen[1] := 'tblDetails';
      OpenQueries;
      StockTransfer.Load(KeyID);
      StockTransfer.Lines.Dataset.Filter:= 'Deleted <> ' + QuotedStr('T');
      StockTransfer.Lines.Dataset.Filtered:= true;
      inherited;
      if StockTransfer.Transfertype = StockTransfertypetoStr(sttGen) then
         if StockTransfer.AnylinehasSerialNos then begin
          tblDetailsserialnos.visible := true;
          GuiPrefs.DbGridElement[SubformDetails].UnHideField(tblDetailsserialnos.fieldname);
         end;
end;

procedure TfmStockTransferEntry.initStockQtysLocationsReport(Sender: TObject);
begin
  inherited;
  TStockQtysLocationsReportGUI(Sender).grpFilters.ItemIndex := 2;
end;

(*procedure TfmStockTransferEntry.cboBarcodeNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
begin
  inherited;
  Newbarcode := NewValue;
  if CommonLib.MessageDlgXP_Vista('No product has the Barcode of ' + Newvalue +
              #10#13'Do you wish to assign this Barcode to a Product?', mtWarning, [mbYes, mbNo], 0) = mrno then begin
    Accept := false;
  end;
  with TProductListExpressGUI(GetComponentByClassName('TProductListExpressGUI', true)) do begin
        ExpresslistPopup('Choose Product' , CreateBarCode, False);
        Showmodal;
        Accept := false;
        if barCodeCreated then begin
            Qrybarcode.refresh;
            if Qrybarcode.locate('barcode' , newValue, []) then begin
              Accept := true;
              StockTransfer.Lines.PartBarcode := NewValue;
            end;
        end;
  end;
end;*)


initialization
  with FormFact do begin
    RegisterMe(TfmStockTransferEntry, 'TStockTransferEntryListGUI_*_Gen=TransferEntryID');
    RegisterMe(TfmStockTransferEntry, 'TProductQtyOnTransitGUI_*_Gen=TransferEntryID');
    RegisterMe(TfmStockTransferEntry, 'TSalesStockTransferListGUI_*_Gen=TransferEntryID');
    RegisterMe(TfmStockTransferEntry, 'TGlobalsearchGUI_*_Stock Transfer=TransferEntryID');
    RegisterMe(TfmStockTransferEntry, 'TSerialNumberHistoryGUI_transtype_GenStockTransferEntry=StockAdjustEntryID');
    RegisterMe(TfmStockTransferEntry, 'TBalTransListGUI_*_GenStock Transfer=StockTransferEntryID');
    RegisterMe(TfmStockTransferEntry, 'TInventoryAssetVsStockStautsGUI_*_Stock Transfer=StockTransferEntryID');
    RegisterMe(TfmStockTransferEntry, 'TToBeReconciledGUI_*_GenStock Transfer=StockTransferEntryID');
    RegisterMe(TfmStockTransferEntry, 'TTransactionListGUI_*_GenStock Transfer=StockTransferEntryID');
    RegisterMe(TfmStockTransferEntry, 'TBASTransReturnListGUI_*_GenStock Transfer=StockTransferEntryID');
    RegisterMe(TfmStockTransferEntry, 'TNZTransReturnListGUI_*_GenStock Transfer=StockTransferEntryID');
    RegisterMe(TfmStockTransferEntry, 'TVATTransReturnListGUI_*_GenStock Transfer=StockTransferEntryID');
    RegisterMe(TfmStockTransferEntry, 'TTransAccountDetailsGUI_*_GenStock Transfer=StockTransferEntryID');
    RegisterMe(TfmStockTransferEntry, 'TGeneralLedgerReportGUI_*_Stock Transfer=StockTransferEntryID');
    RegisterMe(TfmStockTransferEntry, 'TExpenseClaimListGUI_*_GenStockTransfer=StockTransferEntryID');
    RegisterMe(TfmStockTransferEntry, 'TStockStatusReportGUI_*_GenStock Transfer=StockTransferEntryID');
    RegisterMe(TfmStockTransferEntry, 'TStockStatusRoling_*_GenStock Transfer=StockTransferEntryID');
  end;
  RegisterClassOnce(TfmStockTransferEntry);
end.
