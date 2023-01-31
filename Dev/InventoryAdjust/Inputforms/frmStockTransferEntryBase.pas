unit frmStockTransferEntryBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess,ERPdbComponents, DNMSpeedButton,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, Mask, DBCtrls,
  StdCtrls, wwdblook, Shader, ExtCtrls, DNMPanel, Menus, AdvMenus,
  DataState, SelectionDialog, AppEvnts, busobjStockTransferEntry,BusObjBase,
  wwcheckbox, ImgList, wwdbedit, ProgressDialog, ERPDbLookupCombo;

type
  TfmStockTransferEntryBase = class(TBaseInputGUI)
    pnlDetail: TDNMPanel;
    SubformDetails: TwwDBGrid;
    SubformDetailsIButton: TwwIButton;
    cboProductQry: TERPQuery;
    cboClassToQry: TERPQuery;
    cboClientLookup: TERPQuery;
    cboClientLookupCompany: TWideStringField;
    cboClientLookupStopCreditImage: TIntegerField;
    cboClientLookupClientID: TAutoIncField;
    cboClientLookupStopCredit: TWideStringField;
    qryUOM: TERPQuery;
    qryUOMUnitName: TWideStringField;
    qryUOMMultiplier: TFloatField;
    qryUOMUnitID: TIntegerField;
    cboProduct: TERPDbLookupCombo;
    cboClassTo: TwwDBLookupCombo;
    cboClient: TwwDBLookupCombo;
    cboUOM: TwwDBLookupCombo;
    tblMaster: TERPQuery;
    tblDetails: TERPQuery;
    DSMaster: TDataSource;
    DSDetails: TDataSource;
    tblDetailsGlobalRef: TWideStringField;
    tblDetailsTransferEntryLinesID: TIntegerField;
    tblDetailsclientID: TIntegerField;
    tblDetailsAccountID: TIntegerField;
    tblDetailsAssetValue: TFloatField;
    tblDetailsCustomerName: TWideStringField;
    tblDetailsTransferEntryID: TIntegerField;
    tblDetailsClassIDTo: TIntegerField;
    tblDetailsClassNameTo: TWideStringField;
    tblDetailsEmployeeID: TIntegerField;
    tblDetailsProductID: TIntegerField;
    tblDetailsProductName: TWideStringField;
    tblDetailsProductDesc: TWideStringField;
    tblDetailsUOMID: TIntegerField;
    tblDetailsUOM: TWideStringField;
    tblDetailsUOMMultiplier: TFloatField;
    tblDetailsAvailableQty: TFloatField;
    tblDetailsUOMAvailableQty: TFloatField;
    tblDetailsTransferQty: TFloatField;
    tblDetailsUOMTransferQty: TFloatField;
    tblDetailsmsTimeStamp: TDateTimeField;
    tblDetailsDeleted: TWideStringField;
    lblNote: TLabel;
    cboClassFromQry: TERPQuery;
    tblMasterGlobalRef: TWideStringField;
    tblMasterTransferEntryID: TIntegerField;
    tblMasterTransferFromClassID: TIntegerField;
    tblMasterTransferFromClassName: TWideStringField;
    tblMasterEmployeeID: TIntegerField;
    tblMasterEmployeeName: TWideStringField;
    tblMasterDeleted: TWideStringField;
    tblMasterCreationDate: TDateField;
    tblMasterNotes: TWideMemoField;
    tblMasterProcessed: TWideStringField;
    tblMastermsTimeStamp: TDateTimeField;
    tblMasterDateTransferred: TDateTimeField;
    cboAccountQry: TERPQuery;
    tblMasterAccountID: TIntegerField;
    tblMasterAccountname: TWideStringField;
    tblMasterEnforceUOM: TWideStringField;
    cboEmployeeLookup: TERPQuery;
    tblDetailsUOMcost: TFloatField;
    tblDetailsTotalCost: TFloatField;
    tblDetailsPartBarcode: TWideStringField;
    tblDetailsParttype: TWideStringField;
    tblDetailsMatrixDesc: TWideMemoField;
    tblDetailsMatrixRef: TWideMemoField;
    tblDetailsMatrixPrice: TFloatField;
    tblMasterDescription: TWideStringField;
    tblDetailsFormulaQtyValue1: TFloatField;
    tblDetailsFormulaQtyValue2: TFloatField;
    tblDetailsFormulaQtyValue3: TFloatField;
    tblDetailsFormulaQtyValue4: TFloatField;
    tblDetailsFormulaQtyValue5: TFloatField;
    tblDetailsFormulaQtyValue: TFloatField;
    cboViaQry: TERPQuery;
    cboViaQryShippingMethod: TWideStringField;
    cboViaQryShippingMethodID: TAutoIncField;
    tblMasterShipping: TWideStringField;
    tblMasterStockMovementGlobalref: TWideStringField;
    tblMastermsUpdateSiteCode: TWideStringField;
    tblMasterSalesRef: TWideStringField;
    tblMasterTransferType: TWideStringField;
    DNMPanel1: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    lblprocessed: TLabel;
    Label160: TLabel;
    txtCustomID: TDBEdit;
    Label3: TLabel;
    wwDBDateTimePicker1: TwwDBDateTimePicker;
    chkEnforceUOM: TwwCheckBox;
    lblEnforceUOM: TLabel;
    Bevel2: TBevel;
    chkHideFormulacolumns: TwwCheckBox;
    Label6: TLabel;
    Bevel1: TBevel;
    cboVia: TwwDBLookupCombo;
    lblVia: TLabel;
    cboEmployee: TwwDBLookupCombo;
    Label48: TLabel;
    cboAccount: TwwDBLookupCombo;
    Label1: TLabel;
    cboClassFrom: TwwDBLookupCombo;
    lblTransferFrom: TLabel;
    DNMPanel2: TDNMPanel;
    Label5: TLabel;
    wwDBEdit1: TwwDBEdit;
    lbMemo: TLabel;
    DBMemo1: TDBMemo;
    btnCompleted: TDNMSpeedButton;
    btnhold: TDNMSpeedButton;
    btnPrint: TDNMSpeedButton;
    btncopy: TDNMSpeedButton;
    cmdPrintPick: TDNMSpeedButton;
    cmdDeliveryDocket: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    Label4: TLabel;
    wwCheckBox1: TwwCheckBox;
    pnlChooseRpt: TDNMPanel;
    chkChooseRpt: TCheckBox;
    lblMessage: TLabel;
    cboPrintProduct: TERPDbLookupCombo;
    procedure FormCreate(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnholdClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure SubformDetailsEnter(Sender: TObject);
    procedure cboClassFromCloseUp(Sender: TObject; LookupTable,FillTable: TDataSet; modified: Boolean);
    procedure SubformDetailsDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cboClassFromEnter(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure cboClassFromDropDown(Sender: TObject);
    procedure chkEnforceUOMExit(Sender: TObject);
    procedure chkEnforceUOMEnter(Sender: TObject);
    procedure tblDetailsCalcFields(DataSet: TDataSet);
    procedure txtCustomIDEnter(Sender: TObject);
    procedure wwCheckBox1Enter(Sender: TObject);
    procedure Setaccesslevel(Sender: TObject);
    procedure SubformDetailsDblClick(Sender: TObject);
    procedure SubformDetailsCalcTitleAttributes(Sender: TObject;AFieldName: string; AFont: TFont; ABrush: TBrush;var ATitleAlignment: TAlignment);
    procedure SubformDetailsCalcCellColors(Sender: TObject; Field: TField;State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure cmdPrintPickClick(Sender: TObject);
    procedure cmdDeliveryDocketClick(Sender: TObject);
    procedure btncopyClick(Sender: TObject);
    procedure chkHideFormulacolumnsClick(Sender: TObject);
    procedure SubformDetailsIButtonClick(Sender: TObject);
    procedure cboProductDblClick(Sender: TObject);
  private
    SavedAccessLevel:Integer;
    Newbarcode:String;
    barCodeCreated:Boolean;
    DelDoctoPrint :String;
    Picksliptoprint :String;

    Procedure SelectProductFromreport(Sender: TwwDBGrid);
    Procedure CreateBarCode(Sender:TObject); Overload;
    Procedure CreateBarcode(NewValue: String);Overload;
    procedure SetMatrixDetails(sMatrixDesc, sMatrixRef: String;dMatrixPrice: double);
    procedure LockPartCalcformulafields;
    function showformuladetails: Boolean;
    procedure HandleStockmovementErros(SM: TMsbusObj);
    function StockTransDeldocketSQL: String;
  Protected
    StockTransfer :TStockTransferEntry;
    Procedure shownote(ShowSNWarning:Boolean =False);
    Procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string); Override;
    procedure OverrideAccessLevel(Sender: TObject);
    Procedure ShowStatus(Const Value :STring);override;
    Procedure OpenLookups;virtual;
    procedure SetGridColumns;virtual;
    procedure Initform;virtual;
    procedure initStockQtysLocationsReport(Sender: TObject);virtual;
    Procedure Readguiprefs;virtual;
    Procedure WriteGuiprefs;virtual;
    Procedure InitProductLookupQry;Virtual;
    Procedure InitERPLookupCombonFields; Override;
    Procedure AfterFormShow; override;
    Procedure HideallocationFields;Virtual;

  public
    procedure Setcolumn(columnVisible: Boolean; columnName: string; displaylabel:String = '');
  end;

implementation

uses BusObjConst, frmBinLocation, CommonLib,
  StockQtysLocationsReport, ClassListForm, AppEnvironment,
  FormFactory, busobjPQA, FastFuncs, frmAllocationExtender,
  Productqtylib, DefaultClassObj, BusObjStock, tcDataUtils,
  ProductListExpressForm, frmPartsFrm , tcConst, PartsPriceMatrixLib,
  frmpartsPriceMatrixInput, BusObjProductbin, PartCalcFormulaObj, CommonFormLib, frmStockTransferEntryBatch, frmStockTransferEntryBin, frmStockTransferEntrySN,
  busobjStockMovement, LogLib, TemplateReportsLib;


{$R *.dfm}

procedure TfmStockTransferEntryBase.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
var
  MatrixDesc:String;
  MatrixRef:String;
  MatrixPrice:double;
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TStockTransferEntry      then TStockTransferEntry(Sender).DataSet      := tblMaster;
    if Sender is TSTELines then TSTELines(Sender).DataSet := tblDetails;
  end else if (EventType = BusobjEvent_ToDo) and (Value = BusObjEvent_PartBarcodeNotfound)  then begin
      Createbarcode(StockTransfer.Lines.Partbarcode);
  end else if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_ProductID)  then begin
        if not StockTransfer.Lines.deleted then begin
          ReadSalesDefaultPriceMethod(StockTransfer.Lines.ProductID,MatrixDesc, MatrixRef,MatrixPrice);
          SetMatrixDetails(MatrixDesc,MatrixRef ,MatrixPrice);
        end;
        if Sender  = StockTransfer.Lines then begin
            LockPartCalcformulafields;
            if StockTransfer.Lines.Hasformula then   begin
              StockTransfer.Lines.FormulaQtyValue := 1;
              With TPartCalcFormula.Create(Self) do try InitformulaQtyValues(StockTransfer.Lines);finally Free;end;
            end;
        end;

  end else if (EventType = BusobjEvent_ToDo) and (Value = BusObjEvent_IDChanged) then begin
    if (StockTransfer.Lines.ProductID > 0)  then Shownote((StockTransfer.Lines.Product.sntracking) and (StockTransfer.Lines.serialnumbers<> ''))
    else Shownote;
  end else if (EventType = BusobjEvent_ToDo) and (Value = BusObjEventVal_Changed) then begin
    Shownote((StockTransfer.Lines.Product.sntracking) and (StockTransfer.Lines.serialnumbers<> ''));
    end else if (EventType = BusObjEvent_Change) And (value = BusObjEventVal_uomChanged) then begin
      if QryUOMUnitID.AsInteger <> StockTransfer.Lines.UnitOfMeasureID then begin
         closedb(QryUOM);
         opendb(QryUOM);
         QryUOM.locate('unitID' , StockTransfer.Lines.UnitOfMeasureID , []);
      end;
  end;
end;
procedure TfmStockTransferEntryBase.LockPartCalcformulafields;
begin
  With TPartCalcFormula.Create(Self) do try
    LockPartCalcformulafields(SubformDetails , StockTransfer.Lines.Hasformula );
  finally
    Free;
  end;
end;

Procedure TfmStockTransferEntryBase.SetMatrixDetails(  sMatrixDesc:String;  sMatrixRef:String;  dMatrixPrice:double);
begin
    StockTransfer.Lines.MatrixDesc := sMatrixDesc;
    StockTransfer.Lines.MatrixRef  := sMatrixRef;
    StockTransfer.Lines.MatrixPrice:= dMatrixPrice;
    StockTransfer.Lines.PostDB;
end;


procedure TfmStockTransferEntryBase.FormCreate(Sender: TObject);
begin
  DelDoctoPrint := '';
  Picksliptoprint := '';
  AllowCustomiseGrid := True;
  ShowCustomisemenu:= False;
  Newbarcode:= '';
  barCodeCreated :=  false;
  AllowGridSorting  := True;
  InitProductLookupQry;
  inherited;
  fbTabSettingEnabled := False;
  StockTransfer := TStockTransferEntry.create(Self);
  StockTransfer.connection  := TMydacDataconnection.create(StockTransfer);
  StockTransfer.connection.connection := Self.MyConnection;
  StockTransfer.BusObjEvent           := DoBusinessObjectEvent;
  StockTransfer.OpenLookups           := OpenLookups;
  StockTransfer.ShowStatus            := ShowStatus;
  With TPartCalcFormula.Create(Self) do try    SetdisplayLabel(self);  finally    Free;  end;
end;

procedure TfmStockTransferEntryBase.btnCompletedClick(Sender: TObject);
begin
  inherited;
  if (StockTransfer.Processed) or (StockTransfer.deleted) then begin
    if not(StockTransfer.Save) then exit;
    StockTransfer.dirty := False;
    StockTransfer.Connection.CommitTransaction;
    self.Close;
    Exit;
  end;
  Processingcursor(True);
  DisableForm;
  try
    inherited;
    if not(StockTransfer.Save) then exit;
    StockTransfer.Connection.CommitTransaction;
    StockTransfer.Connection.BeginTransaction;
    lblMessage.Visible := True;
    lblNote.Visible           := False;
    lblMessage.Caption := 'Processing the stock transfer in Progress......';
    Try
      if not StockTransfer.Process then begin
        HandleStockmovementErros(StockTransfer.Stockmovement);
        StockTransfer.connection.RollbackTransaction;
        StockTransfer.connection.begintransaction;
        exit;
      end;
      StockTransfer.connection.CommitTransaction;
      Self.close;
    finally
      lblMessage.Visible := False;
      lblNote.Visible           := True;
    end;
  finally
    EnableForm;
    Processingcursor(False);
  end;
end;
Procedure TfmStockTransferEntryBase.HandleStockmovementErros(SM: TMsbusObj);
var
  FatalStatusItem: TResultStatusItem;
begin
  FatalStatusItem := SM.ResultStatus.GetLastFatalStatusItem;
  if Assigned(FatalStatusItem) then begin
    MessageDlgXP_Vista(FatalStatusItem.Message, mtWarning, [mbOK], 0);
  end;
end;

procedure TfmStockTransferEntryBase.HideallocationFields;
begin
  ShowStatus('You Don''t Have Access to See the Allocation (Batch / Bin / Serial Number)');
end;

procedure TfmStockTransferEntryBase.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
      //FormatProductCombo(cboProduct);
      GuiPrefs.active := TRue;
      ReadguiPrefs;
      GuiPrefs.DbGridElement[SubformDetails].RemoveFields('MatrixRef,MatrixPrice,Matrixdesc');
      chkHideFormulacolumnsClick(chkHideFormulacolumns);
      InitForm;

      if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnAllowtoSeecostInStockforms')<> 1 then begin
(*        tblDetailsUOMcost.visible   := fAlse;
        tblDetailsTotalCost.visible := fAlse;
        tblDetailsAssetValue.visible:= fAlse;*)
        SubformDetails.RemoveField(tblDetailsUOMcost.fieldname);
        SubformDetails.RemoveField(tblDetailsTotalCost.fieldname);
        SubformDetails.RemoveField(tblDetailsAssetValue.fieldname);
        GuiPrefs.DbGridElement[SubformDetails].HideField(tblDetailsUOMcost.fieldname);
        GuiPrefs.DbGridElement[SubformDetails].HideField(tblDetailsTotalCost.fieldname);
        GuiPrefs.DbGridElement[SubformDetails].HideField(tblDetailsAssetValue.fieldname);
      end;
    if not  EmployeeHasAccess('FnAllowAllocationinStockTransfer') then begin
      HideallocationFields;
    end;

  finally
    pnlDetail.Repaint;
    EnableForm;
  end;
  SetGridColumns;
  SetControlfocus(SubformDetails);
(*        if self is TfmStockTransferEntryBatch then lblMessage.caption :=  AppEnv.DefaultClass.PartColumn +' selection will only provide Batch Enabled ' + AppEnv.DefaultClass.PartColumn +'(s)'
  else  if self is TfmStockTransferEntryBin   then lblMessage.caption :=  AppEnv.DefaultClass.PartColumn +' selection will only provide ' + AppEnv.DefaultClass.PartColumn +'(s) using Multiple Bins '
  else  if self is TfmStockTransferEntrySN    then lblMessage.caption :=  AppEnv.DefaultClass.PartColumn +' selection will only provide ' + AppEnv.DefaultClass.PartColumn +'(s) with Serial Number Tracking'
  else  lblMessage.caption := '';*)
end;


Procedure TfmStockTransferEntryBase.Initform;
var
  msg:String;
begin
      (*
      if not StockTransfer.Lock then   begin
          AccessLevel := 5;
          Msg := 'Stock Transfer is Read-Only.'+chr(13) +
                'Currently the User "'+StockTransfer.UserLock.LockInfo.Username+'" is Accessing Stock Transfer Since : ' + FormatDateTime('dd/mm hh:nn:ss', StockTransfer.UserLock.LockInfo.TimeLocked)+'.' +chr(13) +
                'Only One Stock Transfer Can Be Opened At a time';

          MessageDlgXP_Vista( Msg, mtWarning, [mbok],0);
          Self.Caption := 'Stock Transfer {'+'"'+StockTransfer.UserLock.LockInfo.Username+'" is Accessing Stock Transfer:' + IntToStr(StockTransfer.UserLock.LockInfo.KeyID)+'}';
          Disablecontrols(btnClose);
      end else
      *)
      if (StockTransfer.Processed)  then begin
          AccessLevel := 5;
          Self.Caption := Self.Caption + '     { Already Processed ! - Cannot Modify }';
      end else if (StockTransfer.Deleted)  then begin
          AccessLevel := 5;
          Self.Caption := Self.Caption + '     { Already Deleted ! - Cannot Modify }';
      end else begin
          AccessLevel := 1;
          Self.Caption := 'Stock Transfer';
      end;
      lblprocessed.visible := StockTransfer.Processed;
      if btnCompleted.enabled  then btnCompleted.enabled:=not (StockTransfer.Processed);

      StockTransfer.connection.BeginTransaction;
      if AccessLevel=1 then begin
        if StockTransfer.count = 0 then begin
          StockTransfer.new;
          StockTransfer.Lines;
        end;
      end;
      shownote;
    chkEnforceUOM.ShowHint    := true;
    chkEnforceUOM.hint        :=
          'When Ticked:This is only showing the Quantity of the selected Unit of Measure.  It is not'+chr(13)+
          'displaying the Quantity of any other Unit of Measure for this product, as it is expecting'+chr(13)+
          'you to count the singles separately.  ie.If You have 2 Cartons and 8 singles,it will only'+chr(13)+
          'display as 2 Cartons.'+chr(13)+chr(13)+
          'When not Ticked:This will display the Quantity in the select Unit of Measure of the selected '+chr(13)+
          'Product as a total of all Units of Measure. ie. If You have 2 Cartons and 8 singles,it will'+chr(13)+
          'display as 2.8 Cartons';
    SavedAccessLevel := AccessLevel;
    With TPartCalcFormula.Create(Self) do try ShowFormulaQtyFields(Self);finally Free;end;
end;


procedure TfmStockTransferEntryBase.InitProductLookupQry;
var
  s:String;
begin
  s:= '';
       if Self is TfmStockTransferEntryBatch  then s:= 'and P.batch ="T" and P.MultipleBins="F" and P.SNTracking = "F" '
  else if self is TfmStockTransferEntryBin    then s:= 'and P.batch ="F" and P.MultipleBins="T" and P.SNTracking = "F" '
  else if self is TfmStockTransferEntrySN     then s:= 'and P.batch ="F" and P.MultipleBins="F" and P.SNTracking = "T" ';
  cboProductQry.SQL.text  := replacestr(cboProductQry.SQL.text , 'WHERE P.Active = "T"' ,'INNER Join tblProductclasses PC ON p.PARTSID = PC.ProductID WHERE P.Active = "T" AND (PARTTYPE="INV") And PC.ClassID = :ClassID ' + s);
end;

procedure TfmStockTransferEntryBase.SetGridColumns;
begin
end;



procedure TfmStockTransferEntryBase.OpenLookups;
begin
  if StockTransfer.Lines.cleanproductID <>StockTransfer.Lines.ProductId then begin
    QryUOM.Active := false;
    QryUOM.Params.ParamByName('xPartID').AsInteger := StockTransfer.Lines.ProductId;
    QryUOM.Active := true;
  End;

  With cboclientLookup    do if not Active then Open;
  With cboClassToqry      do if not Active then Open;

  With cboProductQry do
    if Params.ParamByName('ClassId').AsInteger <> StockTransfer.TransferfromClassID then begin
      if Active then Close;
      Params.ParamByName('ClassId').AsInteger := StockTransfer.TransferfromClassID;
      Active := true;
    end;
end;

procedure TfmStockTransferEntryBase.SelectProductFromreport(Sender: TwwDBGrid);
var
  ds:TDataset;
  grd :TwwDbGrid;
  form: TComponent;
  i :Integer;
  fiClassId:Integer;
begin
  if not(Sender is TwwDBGrid) then exit;
  try
    grd:=TwwDBGrid(Sender);         if not(Assigned(grd)) then exit;
    ds:= grd.Datasource.Dataset;    if not(Assigned(ds))  then exit;
    fiClassId :=StockTransfer.Lines.ClassIDTo;
    StockTransfer.Lines.PostDB;
    showProgressbar(WAITMSG, grd.SelectedList.Count);
    try
      for i := 0 to grd.SelectedList.Count - 1 do begin
        ds.GotoBookmark(grd.SelectedList.Items[i]);
        StockTransfer.Lines.New;
        StockTransfer.Lines.ClassIDTo     := fiClassId;
        StockTransfer.Lines.ProductName   := ds.fieldByname('ProductName').asString;
        StockTransfer.Lines.ProductID     := ds.fieldByname('PartsID').asInteger;
        StockTransfer.Lines.UnitOfMeasure := ds.fieldbyname('uom').asString;
        StockTransfer.Lines.UOMQty        := ds.FieldByName('InstockQty').AsFloat;
        if StockTransfer.Lines is TSTELinesFlat then begin
          if (ds.fieldByname('gLevel').asInteger > 1) and (StockTransfer.Lines.Product.Batch) then begin
              TSTELinesFlat(StockTransfer.Lines).BatchNoFrom      := ds.fieldbyname('Batchnumber').asString ;
              if ds.fieldbyname('BatchExpiryDate').asDatetime  <> 0 then
                TSTELinesFlat(StockTransfer.Lines).expiryDateFrom   :=  ds.fieldbyname('BatchExpiryDate').asDatetime ;
          end;
          if (ds.fieldByname('gLevel').asInteger > 2) and (TSTELinesFlat(StockTransfer.Lines).Product.Multiplebins) then begin
              TSTELinesFlat(StockTransfer.Lines).binLocationFrom  := ds.fieldbyname('binLocation').asString ;
              TSTELinesFlat(StockTransfer.Lines).BinnumberFrom    := ds.fieldbyname('Binnumber').asString ;
          end;
          if (ds.fieldByname('gLevel').asInteger > 3) and (TSTELinesFlat(StockTransfer.Lines).Product.Multiplebins) then begin
              TSTELinesFlat(StockTransfer.Lines).SerialNumbers  := ds.fieldbyname('Serialnumber').asString ;
          end;
          TSTELinesFlat(StockTransfer.Lines).PostDB;
          StepProgressbar;
        end;
      end;
    finally
      HideProgressbar;
    end;
  finally
    Form:= FindExistingComponent('TStockQtysLocationsReportGUI');
    if assigned(Form) then TStockQtysLocationsReportGUI(form).close;
  end;

end;

procedure TfmStockTransferEntryBase.shownote(ShowSNWarning:Boolean =False);
var
  s:String;
  function transferfrom :String; begin if StockTransfer.TransferFromClassName <> '' then result := StockTransfer.TransferFromClassName else result := 'Class' ; end;
begin
  s := '(Use ''~'' for Barcode Selection)'+chr(13)+
          '(Press F9 in the Grid to open the quantity Location report for ' + AppEnv.DefaultClass.ClassHeading+':' +  transferfrom +'. Press F9 in Serial number field to open a list of available serial numbers for the selected Batch / Bin.)';
  if ShowSNWarning then s:= s + NL+ StockTransfer.Lines.ProductName +' is Serialised and only Transfer 1 Serial number per line';
  lblNote.caption := s;
  lblNote.Visible := not(StockTransfer.Processed);
end;

procedure TfmStockTransferEntryBase.ShowStatus(const Value: STring);
begin
  lbltimerMsg := lblMessage;
  inherited;
end;

procedure TfmStockTransferEntryBase.btnholdClick(Sender: TObject);
var
  iAcesslevel:Integer;
begin
  inherited;
    iAcesslevel :=AccessLevel;
  if StockTransfer.Processed and StockTransfer.Deleted and not(StockTransfer.CleanDeleted) then AccessLevel := 1;
  try
    if not(StockTransfer.Save) then exit;
  finally
    AccessLevel := iAcesslevel;
  end;
  StockTransfer.Connection.CommitTransaction;
  StockTransfer.Dirty := false;
  self.Close;

end;

procedure TfmStockTransferEntryBase.btncopyClick(Sender: TObject);
var
  iNewID:Integer;
  Msg:String;
begin
  inherited;

  if not(StockTransfer.Save) then exit;
  StockTransfer.Connection.CommitTransaction;

  StockTransfer.Connection.begintransaction;
  iNewID:= StockTransfer.CopyStockTransfer(Msg);
  if iNewID <> 0 then begin
    MessageDlgXP_Vista('Stock transfer #' +inttostr(StockTransfer.Id) +' is copied into ' +inttostr(inewID) +'.', mtWarning, [mbOK], 0);
    StockTransfer.Connection.CommitTransaction;
    KeyId := iNewId;
    StockTransfer.closedb;
    btnCompleted.enabled:= True;
    Initform;
  end else begin
    MessageDlgXP_Vista('Copy Failed.'+NL+NL+Msg, mtWarning, [mbOK], 0);
  end;
end;

procedure TfmStockTransferEntryBase.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
  WriteGuiPrefs;
  inherited;
end;

procedure TfmStockTransferEntryBase.AfterFormShow;
begin
  inherited;
  if StockTransfer.processed then btnhold.caption := '&Save' else btnhold.caption := '&Hold';
end;

procedure TfmStockTransferEntryBase.btnCloseClick(Sender: TObject);
begin
  inherited;
  self.close;
end;

procedure TfmStockTransferEntryBase.SubformDetailsEnter(Sender: TObject);
begin
  inherited;
  if StockTransfer.Lines.count = 0 then StockTransfer.Lines.New;
end;

procedure TfmStockTransferEntryBase.SubformDetailsIButtonClick(Sender: TObject);
begin
  inherited;
  if accesslevel >2 then exit;

  if StockTransfer.Lines.count > 0 then
    if MessageDlgXP_Vista('Do you wish to delete '+ Stocktransfer.Lines.Productname +'?', mtConfirmation, [mbYes, mbNo], 0) = mryes then
      StockTransfer.Lines.Delete;
end;

procedure TfmStockTransferEntryBase.cboClassFromCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
  shownote;
  cboClassToQry.filter := 'ClassID <> '+ IntToStr(Stocktransfer.TransferFromClassID);
  cboClassToQry.Filtered := True;
  pnlDetail.Repaint;
end;

procedure TfmStockTransferEntryBase.SubformDetailsCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  With TPartCalcFormula.create(Self) do try   gridCalcCellColors(StockTransfer.Lines.Hasformula  , Sender,Field,State,Highlight,AFont,ABrush);  finally    Free;  end;
end;

procedure TfmStockTransferEntryBase.SubformDetailsCalcTitleAttributes(
  Sender: TObject; AFieldName: string; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  inherited;
  With TPartCalcFormula.create(Self) do try   gridCalcTitleAttributes(Sender,AFieldName,AFont,ABrush,ATitleAlignment );  finally   Free;  end;
end;

procedure TfmStockTransferEntryBase.SubformDetailsDblClick(Sender: TObject);
var
  sMatrixDesc:String;
  sMatrixRef:String;
  dMatrixPrice:double;
begin
  inherited;
  if showformuladetails then exit;

  if (Activefield(Sender).FieldName = 'MatrixDesc') or (Activefield(Sender).FieldName = 'MatrixPrice') then begin
    sMatrixDesc := StockTransfer.Lines.MatrixDesc;
    sMatrixRef  := StockTransfer.Lines.MatrixRef;
    dMatrixPrice:= StockTransfer.Lines.MatrixPrice;
    TfmpartsPriceMatrixInput.PriceMAtrix(Self, sMatrixRef , sMatrixDesc , dMatrixPrice, StockTransfer.Lines.ProductId, Myconnection);
    SetMatrixDetails(sMatrixDesc,sMatrixRef ,dMatrixPrice);
    Abort; // this is to cancel the memodialag popup for this field
  end;
end;
procedure TfmStockTransferEntryBase.Setcolumn(columnVisible: Boolean; columnName, displaylabel: String);
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

procedure TfmStockTransferEntryBase.SubformDetailsDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
var
  serialform : TfmAllocationExt;
(*  ProductId: integer;
  ProductName: string;*)
  i:Integer;
  s:String;
begin
  inherited;
  if StockTransfer.Processed then exit;
  if ((SameText(ActiveField(Sender).FieldName , 'MatrixDesc')) or (SameText(ActiveField(Sender).FieldName , 'MatrixPrice'))) and (key <> vk_return) and (Key <> vk_tab) then begin
    Key:=0;
    exit;
  end;

  (*  if (Key = 192) and (not (ssAlt in Shift)) then begin  // ~ key
    if Empty(cboClassFrom.Text)  then Begin
      CommonLib.MessageDlgXP_Vista('Stock Transfer Requires  ''Transfer From'' '+AppEnv.DefaultClass.ClassHeading+' to Proceed with Barcode Selection !', mtInformation, [mbOK], 0);
      Exit;
    end;
    ProductName := '';
    ProductId := TfmBarcodePopUp.GetProductID('', ProductName);
    if ProductId > 0 then begin
      if StockTransfer.Lines.ProductId <> 0 then StockTransfer.Lines.new;
      StockTransfer.Lines.ProductId:= ProductId;
      if ProductName <> '' then StockTransfer.Lines.Productname:= ProductName;
      cboProduct.LookupTable.Locate('PARTSID', ProductId, []);
      cboProduct.Text := ProductName;
      SetControlFocus(SubformDetails);
      cboProductCloseUp(cboProduct,cboProduct.LookupTable,cboProduct.DataSource.DataSet,True);
    end;
  end;  *)
  (*if Shift = [ssCtrl] then begin*)
    if StockTransfer.Lines.ClassIDFrom = 0 then exit;

    if Key = VK_F9 then begin
      if (Screen.Activecontrol = SubformDetails) and
        (Sysutils.SameText(SubformDetails.GetActiveField.fieldName, 'Serialnumber')) and
        (StockTransfer.Lines.ProductID <> 0) then begin
          serialform := TfmAllocationExt(commonlib.getcomponentByclassName('TfmAllocationExt' , True, Self, False)) ;
          try
            serialform.MyConnection := Myconnection;
            serialform.ProductID    := TSTELinesFlat(StockTransfer.Lines).ProductID;
            serialform.ClassID      := TSTELinesFlat(StockTransfer.Lines).ClassIDFrom;
            serialform.UOM          := TSTELinesFlat(StockTransfer.Lines).UnitOfMeasure;
            serialform.Batchno      := TSTELinesFlat(StockTransfer.Lines).BatchNoFrom;
            serialform.ExpiryDate   := TSTELinesFlat(StockTransfer.Lines).expiryDateFrom;
            serialform.BinLocation  := TSTELinesFlat(StockTransfer.Lines).BinLocationFrom;
            serialform.Binnumber    := TSTELinesFlat(StockTransfer.Lines).BinNumberFrom;
            serialform.PQAType      := tDetailswithSno;
            serialform.showmodal;
            if serialform.modalresult = mrOk then begin
                TSTELinesFlat(StockTransfer.Lines).SerialNumbers := '';
                if serialform.grdMain.SelectedList.Count>0 then begin
                    for i := 0 to serialform.grdMain.SelectedList.Count - 1 do begin
                      serialform.qrymain.GotoBookmark(serialform.grdMain.SelectedList.Items[i]);
                      if i > 0 then begin
                        s :=TSTELinesFlat(StockTransfer.Lines).XML;
                        TSTELinesFlat(StockTransfer.Lines).New;
                        TSTELinesFlat(StockTransfer.Lines).XML := s;
                      end;
                      TSTELinesFlat(StockTransfer.Lines).SerialNumbers :=serialform.qrymain.fieldbyname('Serialnumber').asString;
                      TSTELinesFlat(StockTransfer.Lines).UOMTransferQty := 1;
                      TSTELinesFlat(StockTransfer.Lines).TransferUOMAllocatedQty := 1;
                      TSTELinesFlat(StockTransfer.Lines).PostDB;
                    end;
                end;
                TSTELinesFlat(StockTransfer.Lines).UOMTransferQty := 1;
                TSTELinesFlat(StockTransfer.Lines).TransferUOMAllocatedQty := 1;
            end;
          finally
              FreeandNil(Serialform);
          end;
      end else begin
        OpenERPListFormultiselectModal('TStockQtysLocationsReportGUI' , initStockQtysLocationsReport , SelectProductFromreport);
      end;
    end;
  (*end;*)
  inherited;
end;
procedure TfmStockTransferEntryBase.initStockQtysLocationsReport(Sender:TObject);
begin
  if not(Sender is TStockQtysLocationsReportGUI) then exit;
  TStockQtysLocationsReportGUI(Sender).ProductId   := StockTransfer.Lines.ProductID;
  TStockQtysLocationsReportGUI(Sender).ClassID     := StockTransfer.Lines.ClassIDFrom;
end;
procedure TfmStockTransferEntryBase.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ErrorOccurred then Exit;

  CanClose := false;
  if Stocktransfer.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:begin
          if Stocktransfer.Save then begin
            Stocktransfer.Connection.CommitTransaction;
            CanClose := true;
          end;
        end;
      mrNo:begin
          Stocktransfer.Connection.RollbackTransaction;
          Stocktransfer.Dirty := false;
          CanClose := true;
        end;
      mrCancel: begin
          CanClose := false;
          btnClose.Enabled := True;
        end;
    end;
  end else begin
    CanClose := true;
  end;
end;

procedure TfmStockTransferEntryBase.cboProductDblClick(Sender: TObject);
begin
  inherited;
  if StockTransfer.Lines.productId =0 then exit;
  OpenERPForm('StockTransfer.Lines.', StockTransfer.Lines.productId  );
end;

procedure TfmStockTransferEntryBase.cboClassFromEnter(Sender: TObject);
begin
  inherited;

  cboClassFrom.readonly :=
    (StockTransfer.Lines.count > 0) and (not ((StockTransfer.Lines.count = 1) and (StockTransfer.Lines.ProductName = '')));
end;

procedure TfmStockTransferEntryBase.btnPrintClick(Sender: TObject);
var
  sSQL: string;
begin
  if chkChooseRpt.Checked then begin
      LoadReportTypes(TemplateTypeID('Stock Transfer'));
      if dlgReportSelect.Execute then
        ReportToPrint := dlgReportSelect.SelectedItems.Text;
  end;
  if ReportToPrint = '' then ReportToPrint :='Stock Transfer';


  DisableForm;
  try
    inherited;
    if not(StockTransfer.Save) then exit;
    StockTransfer.Connection.CommitTransaction;
    SSQL := '{CompanyInfo}Select * from tblCompanyInformation;~|||~{Detail}' +
            ' SELECT  STL.TransferEntryLinesID,ST.EmployeeName, ST.TransferEntryID, ST.DateTransferred, ' +
            ' Notes, FromClass.ClassName as TransferedFrom,ToClass.ClassName as TransferedTo, ' +
            ' STL.ProductName, ProductDesc, AvailableQty, TransferQty,' +
            ' STL.UOM,  UOMTransferQty,  UOMAvailableQty,STL.UOMMultiplier,' +
            Firstcolumn('P')+' as Partheader, '+
            Secondcolumn('P')+' as PartSubLevel1, '+
            Thirdcolumn('P')+' as PartSubLevel2, '+
            ' P.CUSTFLD1, P.CUSTFLD2, P.CUSTFLD3, P.CUSTFLD4, P.CUSTFLD5, P.CUSTFLD6, P.CUSTFLD7, ' +
            ' P.CUSTFLD8, P.CUSTFLD9, P.CUSTFLD10, P.CUSTFLD11, P.CUSTFLD12, P.CUSTFLD13, P.CUSTFLD14, P.CUSTFLD15, P.CUSTDATE1, P.CUSTDATE2, P.CUSTDATE3 ,' +
            ' Round(sum(if(ifnull(PQASN.PQADEtailID,0)<>0 , PQASN.UOMQty ,if (ifnull(PQABins.PQADEtailID,0)<>0 , PQABins.UOMQty , if(ifnull(PQABatch.UOMQty,0)<>0 , PQABatch.uomQty , 0)))), 5) as AllocQty   ,' +
            ' if(PQA.transtype = "TSTELinesTree"   , PQABatch.Value       , NULL) as batchfrom ,' +
            ' if(PQA.transtype = "TSTELinesTree"   , PQABatch.ExpiryDate  , NULL) as expirydatefrom ,' +
            ' if(PQA.transtype = "TSTELinesTree"   , PBin.BinLocation     , NULL) as BinLocationfrom,' +
            ' if(PQA.transtype = "TSTELinesTree"   , PBin.BinNumber       , NULL) as BinNumberfrom ,' +
            ' if(PQA.transtype = "TSTELinesTree"   , PQASN.Value          , NULL) as Serialnumberfrom ,' +
            ' if(PQA.transtype = "TSTELinesTreeIn" , PQABatch.Value       , NULL) as batchto ,' +
            ' if(PQA.transtype = "TSTELinesTreeIn" , PQABatch.ExpiryDate  , NULL) as expirydateto,' +
            ' if(PQA.transtype = "TSTELinesTreeIn" , PBin.BinLocation     , NULL) as BinLocationto,' +
            ' if(PQA.transtype = "TSTELinesTreeIn" , PBin.BinNumber       , NULL) as BinNumberto,' +
            ' if(PQA.transtype = "TSTELinesTreeIn" , PQASN.Value          , NULL) as Serialnumberto' +NL+
            ' FROM tblstocktransferEntry ST' +NL+
            ' INNER JOIN tblstocktransferEntrylines STL ON STL.TransferEntryID = ST.TransferEntryID' +NL+
            ' INNER JOIN tblClass as FromClass ON FromClass.ClassID = ST.TransferFromClassID' +NL+
            ' INNER JOIN tblClass as ToClass ON ToClass.ClassID = STL.ClassIDTo' +NL+
            ' INNER JOIN tblParts P on P.PartsId = STL.ProductId' +NL+
            ' LEFT JOIN tblstocktransferentrypqa as PQA on PQA.transid = ST.TransferEntryID and PQA.transLineId = STL.TransferEntryLinesID /*and PQA.transtype = "TSTELinesTreeIn"*/' +NL+
            ' LEFT JOIN tblstocktransferentrypqadetails PQABatch  on PQABatch.PQAId  = PQA.PQAID and PQABatch.PQAType = "Batch"  and PQABatch.Active= "T"' +NL+
            ' LEFT JOIN tblstocktransferentrypqadetails PQABins  on PQABins.PQAId  = PQA.PQAID   and PQABins.PQAType = "Bin" and PQABins.Active = "T"  ' +
            ' and    ( (PQABatch.globalref = IFNULL(PQABins.ParentRef,"") and P.Batch="T" and P.multiplebins = "T")  or (ifnull(PQABins.Parentref ,"") = "" AND P.Batch="F" and P.multiplebins = "T"))' +NL+
            ' LEFT JOIN tblproductbin PBin     on PBin.binId  = PQABins.BinID' +NL+
            ' LEFT JOIN tblstocktransferentrypqadetails PQASN    on (PQASN.PQAId  = PQA.PQAID and PQASN.PQAType = "SN"   and PQASN.Active = "T" and PQASN.Qty <> 0   ' +
            ' and ((PQABatch.globalref = IFNULL(PQASN.ParentRef,"") and P.Batch="T" and P.multiplebins = "F" and P.SNTracking = "T") ' +
            ' or  (PQAbins.Globalref = IFNULL(PQASn.ParentRef,"") and P.Multiplebins = "T" and P.SNTracking = "T")  ' +
            ' or  ((ifnull(PQASN.Parentref ,"") = "") and P.Batch="F" and P.Multiplebins = "F" and P.SNTracking = "T")))' +NL+
            ' Where ST.TransferEntryID = ' +inttostr(StockTransfer.Id) +NL+
            ' group by STL.TransferEntryLinesID , PQA.PQAID, PQABatch.PQADetailID, PQABins.PQADetailID , PQASN.PQADetailID' +NL+
            ' Order by STL.TransferEntryLinesID , pqa.pqaid,' +
            ' batchfrom , batchto, expirydatefrom , expirydateto, BinLocationfrom, BinLocationto, BinNumberfrom , BinNumberto, Serialnumberfrom ,Serialnumberto';

          clog(ssql);
    fbReportSQLSupplied := True;
    try
      PrintTemplateReport(ReportToPrint, sSQL, not(devmode) and (not AppEnv.Employee.ShowPreview), 1);
    Finally
      fbReportSQLSupplied := False;
    end;
    Self.close;
  
  finally
    EnableForm;
  end;
end;

procedure TfmStockTransferEntryBase.cboClassFromDropDown(Sender: TObject);
begin
  inherited;
  if cboClassFrom.readonly then begin
      MessageDlgXP_Vista('Transfer details(Products) are already selected, its not possible to change the ''Transfer From''.' +chr(13)+chr(13)+
                         'Please CANEL and CREATE a new ''Stock Transfer'' if necessory.' , mtInformation , [mbOk] , 0);
      abort;
  end;
end;

procedure TfmStockTransferEntryBase.chkEnforceUOMExit(Sender: TObject);
begin
  inherited;
  Application.ProcessMessages;
  if Accesslevel = SavedAccessLevel then Exit;

  AccessLevel := SavedAccessLevel;
  if assigned(StockTransfer) then     begin
    StockTransfer.AccessManager.AccessLevel := SavedAccessLevel;
    StockTransfer.postDB;
  end;

end;

procedure TfmStockTransferEntryBase.chkHideFormulacolumnsClick(Sender: TObject);
begin
  inherited;
  if chkHideFormulacolumns.checked then begin
    tblDetailsFormulaQtyValue1.Visible := False;
    tblDetailsFormulaQtyValue2.Visible := False;
    tblDetailsFormulaQtyValue3.Visible := False;
    tblDetailsFormulaQtyValue4.Visible := False;
    tblDetailsFormulaQtyValue5.Visible := False;
    tblDetailsFormulaQtyValue.Visible := False;
  end else begin
    tblDetailsFormulaQtyValue1.Visible := True;
    tblDetailsFormulaQtyValue2.Visible := True;
    tblDetailsFormulaQtyValue3.Visible := True;
    tblDetailsFormulaQtyValue4.Visible := True;
    tblDetailsFormulaQtyValue5.Visible := True;
    tblDetailsFormulaQtyValue.Visible := True;
  end;
end;
Function TfmStockTransferEntryBase.StockTransDeldocketSQL:String;
begin
  REsult := companyInfoSQL('CompanyInfo') +
            NL+'~|||~{Details}select   distinct St.shipping , ST.TransferEntryID,ST.EmployeeName,ST.DateTransferred,ST.Deleted,ST.CreationDate,ST.Notes,ST.Processed,ST.Accountname,ST.EnforceUOM,ST.Description,ST.SalesRef,     ' +
            ' STL.CustomerName,STL.ProductName,STL.ProductDesc,STL.DescAttrib1,STL.DescAttrib2,STL.DescAttrib3,STL.DescAttrib4,STL.DescAttrib5,STL.UOM,STL.UOMMultiplier,STL.AvailableQty,STL.UOMAvailableQty,STL.TransferQty,STL.UOMTransferQty,   ' +
            ' PQABatchOUT.value as BatchNo,PQABatchOUT.expirydate as expiryDate, PQABatchOUT.UOMQty as BatchQty, concat(PQABatchOUT.value ,"-",PQABatchOUT.expirydate ) as Batch,   ' +
            ' PBinOUT.binlocation as BinLocation, PBinOUT.binnumber as BinNumber,PQABinsOUT.UOMQty as BinQty, concat(PBinOUT.binlocation ,"-", PBinOUT.binnumber )as bin, ' +
            ' PQASNOUT.value as SRNO,   ' +
            ' STL.AllocatedQty,STL.UOMAllocatedQty,STL.TransferAllocatedQty,STL.TransferUOMAllocatedQty, ' +
            ' STL.Parttype,STL.MatrixDesc,STL.MatrixRef,STL.MatrixPrice, ' +
            ' STL.FormulaQtyValue1,STL.FormulaQtyValue2,STL.FormulaQtyValue3,STL.FormulaQtyValue4,STL.FormulaQtyValue5,STL.FormulaQtyValue,    ' +
            ' ST.TransferFromClassName,  Transferfrom.Street TransferFromStreet,  Transferfrom.Street2 TransferFromStreet2,  Transferfrom.Street3 TransferFromStreet3,   ' +
            ' Transferfrom.Suburb TransferFromSuburb,  Transferfrom.State TransferFromState,  Transferfrom.Postcode TransferFromPostcode,  Transferfrom.country TransferFromcountry,   ' +
            ' STL.ClassNameTo,  TransferTo.Street TransferToStreet,  TransferTo.Street2 TransferToStreet2,  TransferTo.Street3 TransferToStreet3,   ' +
            ' TransferTo.Suburb TransferToSuburb,  TransferTo.State TransferToState,  TransferTo.Postcode TransferToPostcode,  TransferTo.country TransferTocountry ' +
            ' from   tblparts as P ' +
            ' inner join tblstocktransferentrylines STL  on P.partsId = STL.productId ' +
            ' inner join tblstocktransferentry ST  on ST.TransferEntryID = STL.TransferEntryID ' +
            ' inner join tblclass Transferfrom on Transferfrom.ClassID = ST.TransferFromClassID ' +
            ' inner join tblclass TransferTo on  TransferTo.ClassID = STL.ClassIDTo ' +
            ' left join tblstocktransferentrypqa as PQAOUT on PQAOUT.ProductId = STL.ProductId and  PQAOUT.DepartmentID = ST.TransferFromClassID  and PQAOUT.TRansId = STL.TransferEntryID and PQAOUT.translineId = STL.TransferEntryLinesID  ' +
            ' and PQAOUT.transtype in ("TSTELinesTree")  and ((P.multiplebins = "F" and P.Batch="F" and P.SNTracking = "F") OR (PQAOUT.PQAID in (Select PQAID from `tblstocktransferentrypqaDetails`))) ' +
            ' left join tblstocktransferentrypqaDetails PQABatchOUT  on PQABatchOUT.PQAId  = PQAOUT.PQAID and PQABatchOUT.PQAType = "Batch"  and PQABatchOUT.Active= "T" ' +
            ' left join tblstocktransferentrypqaDetails PQABinsOUT  on PQABinsOUT.PQAId  = PQAOUT.PQAID   and PQABinsOUT.PQAType = "Bin" and PQABinsOUT.Active = "T" and     ' +
            ' ( (PQABatchOUT.globalref = IFNULL(PQABinsOUT.ParentRef,"") and P.Batch="T"   and P.multiplebins = "T") or (ifnull(PQABinsOUT.Parentref ,"") = "" AND P.Batch="F" and P.multiplebins = "T")) ' +
            ' Left join tblProductBin PBinOUT    on PBinOUT.binId  = PQABinsOUT.BinID ' +
            ' Left join tblstocktransferentrypqaDetails  PQASNOUT on PQASNOUT.pqaId = PQaOUT.PQAID and PQASNOUT.PQATYpe ="SN" and PQASNOUT.active ="T"  ' +
            ' and ( (PQABinsOUT.globalref = IFNULL(PQASNOUT.ParentRef,"") and P.multiplebins = "T" and P.SNTracking ="T") or   ' +
            ' (PQABatchOUT.globalref = IFNULL(PQASNOUT.ParentRef,"") and P.multiplebins = "F" and P.batch="T" and P.SNTracking ="T") or  ' +
            ' (ifnull(PQASNOUT.Parentref ,"") = "" AND P.Batch="F" and P.multiplebins = "F" and P.SNTracking ="T")) ' +
            ' Where ST.TransferEntryID = '+ inttostr(StockTransfer.Id)+'  and ST.processed ="F" ' +
            ' union all ' +
            ' select   distinct St.shipping , ST.TransferEntryID,ST.EmployeeName,ST.DateTransferred,ST.Deleted,ST.CreationDate,ST.Notes,ST.Processed,ST.Accountname,ST.EnforceUOM,ST.Description,ST.SalesRef,     ' +
            ' STL.CustomerName,STL.ProductName,STL.ProductDesc,STL.DescAttrib1,STL.DescAttrib2,STL.DescAttrib3,STL.DescAttrib4,STL.DescAttrib5,STL.UOM,STL.UOMMultiplier,STL.AvailableQty,STL.UOMAvailableQty,STL.TransferQty,STL.UOMTransferQty,   ' +
            ' PQABatchOUT.value as BatchNo,PQABatchOUT.expirydate as expiryDate, PQABatchOUT.UOMQty as BatchQty, concat(PQABatchOUT.value ,"-",PQABatchOUT.expirydate ) as Batch,   ' +
            ' PBinOUT.binlocation as BinLocation, PBinOUT.binnumber as BinNumber,PQABinsOUT.UOMQty as BinQty, concat(PBinOUT.binlocation ,"-", PBinOUT.binnumber )as bin,   ' +
            ' PQASNOUT.value as SRNO,   ' +
            ' STL.AllocatedQty,STL.UOMAllocatedQty,STL.TransferAllocatedQty,STL.TransferUOMAllocatedQty, ' +
            ' STL.Parttype,STL.MatrixDesc,STL.MatrixRef,STL.MatrixPrice, ' +
            ' STL.FormulaQtyValue1,STL.FormulaQtyValue2,STL.FormulaQtyValue3,STL.FormulaQtyValue4,STL.FormulaQtyValue5,STL.FormulaQtyValue,    ' +
            ' ST.TransferFromClassName,  Transferfrom.Street TransferFromStreet,  Transferfrom.Street2 TransferFromStreet2,  Transferfrom.Street3 TransferFromStreet3,   ' +
            ' Transferfrom.Suburb TransferFromSuburb,  Transferfrom.State TransferFromState,  Transferfrom.Postcode TransferFromPostcode,  Transferfrom.country TransferFromcountry,   ' +
            ' STL.ClassNameTo,  TransferTo.Street TransferToStreet,  TransferTo.Street2 TransferToStreet2,  TransferTo.Street3 TransferToStreet3,  TransferTo.Suburb TransferToSuburb,   ' +
            ' TransferTo.State TransferToState,  TransferTo.Postcode TransferToPostcode,  TransferTo.country TransferTocountry ' +
            ' from   tblparts as P ' +
            ' inner join tblstocktransferentrylines STL  on P.partsId = STL.productId ' +
            ' inner join tblstocktransferentry ST  on ST.TransferEntryID = STL.TransferEntryID ' +
            ' inner join tblclass Transferfrom on Transferfrom.ClassID = ST.TransferFromClassID ' +
            ' inner join tblclass TransferTo on  TransferTo.ClassID = STL.ClassIDTo ' +
            ' inner join tblstockmovement SM on SM.StockmovementEntryglobalref = ST.GlobalRef and SM.StockmovementEntryType= "StockTransferEntry" ' +
            ' inner join tblstockmovementlines SML on SM.StockmovementID = SML.StockmovementID and SML.StockmovementID and SML.ProductID = STL.ProductID and SML.ClassID = STL.ClassIDTo ' +
            ' left join tblpqa as PQAOUT on PQAOUT.ProductId = SML.ProductId and  PQAOUT.DepartmentID = SML.ClassID  and PQAOUT.TRansId = SML.StockmovementID ' +
            ' and PQAOUT.translineId = SML.StockmovementLinesID and PQAOUT.transtype in ("TStockMovementLines") ' +
            ' and ((P.multiplebins = "F" and P.Batch="F" and P.SNTracking = "F") OR (PQAOUT.PQAID in (Select PQAID from `tblpqaDetails`))) ' +
            ' left join tblpqaDetails PQABatchOUT  on PQABatchOUT.PQAId  = PQAOUT.PQAID and PQABatchOUT.PQAType = "Batch"  and PQABatchOUT.Active= "T" ' +
            ' left join tblpqaDetails PQABinsOUT  on PQABinsOUT.PQAId  = PQAOUT.PQAID   and PQABinsOUT.PQAType = "Bin" and PQABinsOUT.Active = "T"  ' +
            ' and    ( (PQABatchOUT.globalref = IFNULL(PQABinsOUT.ParentRef,"") and P.Batch="T"   and P.multiplebins = "T") or (ifnull(PQABinsOUT.Parentref ,"") = "" AND P.Batch="F" and P.multiplebins = "T")) ' +
            ' Left join tblProductBin PBinOUT    on PBinOUT.binId  = PQABinsOUT.BinID ' +
            ' Left join tblpqaDetails  PQASNOUT on PQASNOUT.pqaId = PQaOUT.PQAID and PQASNOUT.PQATYpe ="SN" and PQASNOUT.active ="T"  ' +
            ' and ( (PQABinsOUT.globalref = IFNULL(PQASNOUT.ParentRef,"") and P.multiplebins = "T" and P.SNTracking ="T")  ' +
            ' or  (PQABatchOUT.globalref = IFNULL(PQASNOUT.ParentRef,"") and P.multiplebins = "F" and P.batch="T" and P.SNTracking ="T")  ' +
            ' or (ifnull(PQASNOUT.Parentref ,"") = "" AND P.Batch="F" and P.multiplebins = "F" and P.SNTracking ="T")) ' +
            ' Where ST.TransferEntryID = '+ inttostr(StockTransfer.Id)+'  and Processed ="T" ' +
            ' order by ClassNameTo , ProductName ,BatchNo,expiryDate,BinLocation,BinNumber,SRNO ' ;


end;
procedure TfmStockTransferEntryBase.cmdDeliveryDocketClick(Sender: TObject);
begin
  inherited;
  if chkChooseRpt.Checked then begin
      LoadReportTypes(TemplateTypeID('Stock Transfer Del Docket'));
      if dlgReportSelect.Execute then
        DelDoctoPrint := dlgReportSelect.SelectedItems.Text;
  end;
  if DelDoctoPrint = '' then DelDoctoPrint :='Stock Transfer Delivery Docket';
  fbReportSQLSupplied := true;

  PrintTemplateReport(DelDoctoPrint , //'~|||~Where ST.TransferEntryID = ' + inttostr(StockTransfer.ID)+ ' order by ClassNameTo , ProductName ,BatchNo,expiryDate,BinLocation,BinNumber,SerialNumber ' ,
            StockTransDeldocketSQL,
          not(Appenv.Employee.ShowPreview) and not(devmode) , 1);
end;

procedure TfmStockTransferEntryBase.cmdPrintPickClick(Sender: TObject);
begin
  inherited;
  if chkChooseRpt.Checked then begin
      LoadReportTypes(TemplateTypeID('Stock Transfer Picking Slip'));
      if dlgReportSelect.Execute then
        Picksliptoprint := dlgReportSelect.SelectedItems.Text;
  end;
  if Picksliptoprint = '' then Picksliptoprint :='Stock Transfer Picking Slip';
  PrintTemplateReport(Picksliptoprint , '~|||~Where ST.TransferEntryID = ' + inttostr(StockTransfer.ID)+ ' order by TransferFromClassName, ProductName ,BatchNo,expiryDate,BinLocation,BinNumber,SerialNumber ' ,
                      not(Appenv.Employee.ShowPreview) and not(devmode) , 1);
end;

procedure TfmStockTransferEntryBase.chkEnforceUOMEnter(Sender: TObject);
begin
  inherited;
    SavedAccessLevel := AccessLevel;
    if StockTransfer.Lines.count = 0 then exit;
    StockTransfer.postDB;
    accessLevel := 5;
    lblEnforceUOM.Enabled := False;
    chkEnforceUOM.Enabled := False;
end;

procedure TfmStockTransferEntryBase.tblDetailsCalcFields(DataSet: TDataSet);
begin
  inherited;
  if tblDetails.RecordCount > 0 then begin
    tblDetailsTotalCost.asFloat  := round(tblDetailsAssetValue.asFloat * tblDetailsTransferQty.asFloat , CurrencyRoundPlaces);
    tblDetailsUOMCost.asFloat    := round(tblDetailsAssetValue.asFloat * tblDetailsUOMMultiplier.asFloat , CurrencyRoundPlaces);
  end;
end;

procedure TfmStockTransferEntryBase.txtCustomIDEnter(Sender: TObject);
begin
  inherited;
  pnlDetail.Repaint;
end;


procedure TfmStockTransferEntryBase.OverrideAccessLevel(Sender: TObject);
begin
    SavedAccessLevel := Accesslevel;
    if assigned(StockTransfer) then begin
        AccessLevel := 1;
        StockTransfer.AccessManager.AccessLevel := 1;
    End else
        AccessLevel := 1;

end;


procedure TfmStockTransferEntryBase.wwCheckBox1Enter(Sender: TObject);
begin
  inherited;
    if StockTransfer.Deleted then exit;
    OverrideAccessLevel(sender);
end;

procedure TfmStockTransferEntryBase.Setaccesslevel(Sender: TObject);
begin
  if Accesslevel = SavedAccessLevel then Exit;
    if assigned(StockTransfer) then     begin
        StockTransfer.postDB;
        StockTransfer.AccessManager.AccessLevel := SavedAccessLevel;
    end;
    AccessLevel := SavedAccessLevel;
end;

procedure TfmStockTransferEntryBase.CreateBarcode(Sender: TObject);
begin
  with TwwDBGrid(Sender).Datasource.dataset do begin
    if active      = False then exit;
    if RecordCount = 0 then exit;
    if findfield('PartsId') = nil then exit;
    if fieldByname('PartsID').asInteger = 0 then exit;
    TProduct.AssignBarCode(fieldByname('PartsID').asInteger, StockTransfer.Lines.partbarcode);
  end;
end;

Procedure TfmStockTransferEntryBase.CreateBarcode(NewValue: String);
var
  frm  :TfrmParts;
  ProdList: TProductListExpressGUI;
  ans :word;
begin
  inherited;
  ans:= CommonLib.MessageDlgXP_Vista('This Barcode not found. Would you like to create?',
      mtConfirmation, [], 0  , nil , '' , '' , False, nil , 'Create New Product,Add Barcode to a Product,Cancel');
      try
  if ans = 102 then begin
  end else if ans = 101 then begin
    ProdList := TProductListExpressGUI(GetComponentByClassName('TProductListExpressGUI', true));
    if Assigned(ProdList) then begin
      with ProdList do begin
        ExpresslistPopup('Choose Product' , CreateBarCode, False);
        Showmodal;
      end;
    end
    else begin
      CommonLIb.MessageDlgXP_Vista('Could not show the Product Express List',mtWarning,[mbOk],0);
      exit;
    end;
  end else begin
        if TfrmParts.FormActive then begin
          TfrmParts.CloseMe;
        end;

        frm := TfrmParts(GetComponentByClassName('TfrmParts'));
        if assigned(frm) then begin
            TfrmParts(frm).fsBarcode := StockTransfer.Lines.Partbarcode;
            frm.Position := poScreenCenter;
            if not frm.Visible then  frm.ShowModal;
        end;
    end
  finally
    StockTransfer.Lines.productname := tcdatautils.GetProductForbarCode(StockTransfer.Lines.Partbarcode);
    if StockTransfer.Lines.productname = '' then StockTransfer.Lines.Partbarcode:= '';
  end;
end;

function TfmStockTransferEntryBase.showformuladetails: Boolean;
begin
  Result := False;
    if StockTransfer.Lines.hasformula = False then exit;
    if  (SubformDetails.GetActiveField = tbldetails.findfield('UnitOfMeasureQty'))  or
        (SubformDetails.GetActiveField = tbldetails.findfield('FormulaQtyValue'))  or
        (SubformDetails.GetActiveField = tbldetails.findfield('FormulaQtyValue1'))  or
        (SubformDetails.GetActiveField = tbldetails.findfield('FormulaQtyValue2'))  or
        (SubformDetails.GetActiveField = tbldetails.findfield('FormulaQtyValue3'))  or
        (SubformDetails.GetActiveField = tbldetails.findfield('FormulaQtyValue4'))  or
        (SubformDetails.GetActiveField = tbldetails.findfield('FormulaQtyValue5'))  then begin
        Result := true;
        With TPartCalcFormula.Create(Self) do try          FormulaDetails(StockTransfer.Lines , StockTransfer.Lines.Product , False);        finally          Free;        end;
    end;
end;
procedure TfmStockTransferEntryBase.Readguiprefs;
begin
  if not GuiPrefs.Active then GuiPrefs.Active := True;

  DelDoctoPrint:= GuiPrefs.Node['Options.DelDoctoPrint'].asString;
  if DelDoctoPrint = '' then DelDoctoPrint :='Stock Transfer Delivery Docket';

  Picksliptoprint:= GuiPrefs.Node['Options.Picksliptoprint'].asString;
  if Picksliptoprint = '' then Picksliptoprint :='Stock Transfer Picking Slip';

  chkHideFormulacolumns.checked :=GuiPrefs.Node['Options.Hideformulacolumns'].asBoolean;
  cmdDeliveryDocket.Hint := 'Select to print ' + quotedstr(DelDoctoPrint) +' template.' + NL +'Select ''choose Template'' to select a different template to print' + NL;
  cmdPrintPick.Hint := 'Select to print ' + quotedstr(Picksliptoprint) +' template.' + NL +'Select ''choose Template'' to select a different template to print' + NL;

end;
procedure TfmStockTransferEntryBase.WriteGuiprefs;
begin
  GuiPrefs.Node['Options.Hideformulacolumns'].asBoolean := chkHideFormulacolumns.checked;
  GuiPrefs.Node['Options.DelDoctoPrint'].AsString := DelDoctoPrint;
  GuiPrefs.Node['Options.Picksliptoprint'].AsString := Picksliptoprint;
  GuiPrefs.SavePrefs;
end;
procedure TfmStockTransferEntryBase.InitERPLookupCombonFields;
begin
  inherited;
  SetupProductNamenPrintNameinGrid(cboProduct ,cboPrintProduct ,'ProductName' , 'ProductPrintName' , 'PARTSDESCRIPTION' , SubformDetails);
  InitProductLookupQry;
end;

end.
