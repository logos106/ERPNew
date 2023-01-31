unit frmStockAdjustEntry;

interface

Uses TypesLib,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ComCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, DB,
  MemDS, DBAccess, MyAccess,ERPdbComponents, StdCtrls, wwcheckbox, DBCtrls, Mask,
  wwdbdatetimepicker, DNMSpeedButton, ExtCtrls, wwdblook, Shader, DNMPanel,
  Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, BusobjStockAdjustEntry, BusobjBase,
  ImgList, ProgressDialog, ERPDbLookupCombo;
{TfmStockAdjustEntry
  ------TfmStockAdjustEntryflat
  ------TfmStockAdjustEntryTree
  ------------TfmStockAdjustEntryBase
  -----------------TfmStockAdjustEntryBatch
  -----------------TfmStockAdjustEntryBins
  -----------------TfmStockAdjustEntrySN}

type
  TfmStockAdjustEntry = class(TBaseInputGUI)
    qryStockAdjustEntry: TERPQuery;
    qryStockAdjustEntryGlobalRef: TWideStringField;
    qryStockAdjustEntryStockAdjustEntryID: TIntegerField;
    qryStockAdjustEntryCreationDate: TDateField;
    qryStockAdjustEntryAccountID: TIntegerField;
    qryStockAdjustEntryAccountname: TWideStringField;
    qryStockAdjustEntryNotes: TWideMemoField;
    qryStockAdjustEntryIsStocktake: TWideStringField;
    qryStockAdjustEntryEmployee: TWideStringField;
    qryStockAdjustEntryDeleted: TWideStringField;
    qryStockAdjustEntrymsTimeStamp: TDateTimeField;
    dsStockAdjustEntry: TDataSource;
    qryStockAdjustEntryLines: TERPQuery;
    qryStockAdjustEntryLinesGlobalRef: TWideStringField;
    qryStockAdjustEntryLinesStockAdjustEntryLinesID: TIntegerField;
    qryStockAdjustEntryLinesStockAdjustEntryID: TIntegerField;
    qryStockAdjustEntryLinesProductID: TIntegerField;
    qryStockAdjustEntryLinesProductName: TWideStringField;
    qryStockAdjustEntryLinesDescription: TWideStringField;
    qryStockAdjustEntryLinesClassName: TWideStringField;
    qryStockAdjustEntryLinesAvailableQty: TFloatField;
    qryStockAdjustEntryLinesFinalQty: TFloatField;
    qryStockAdjustEntryLinesAdjustQty: TFloatField;
    qryStockAdjustEntryLinesAvailableUOMQty: TFloatField;
    qryStockAdjustEntryLinesFinalUOMQty: TFloatField;
    qryStockAdjustEntryLinesAdjustUOMQty: TFloatField;
    qryStockAdjustEntryLinesBatchNo: TWideStringField;
    qryStockAdjustEntryLinesExpirydate: TDateTimeField;
    qryStockAdjustEntryLinesBinLocation: TWideStringField;
    qryStockAdjustEntryLinesBinNumber: TWideStringField;
    qryStockAdjustEntryLinesSerialNumber: TWideStringField;
    qryStockAdjustEntryLinesAllocationAvailableQty: TFloatField;
    qryStockAdjustEntryLinesAllocationFinalqty: TFloatField;
    qryStockAdjustEntryLinesAllocationAdjustQty: TFloatField;
    qryStockAdjustEntryLinesAllocationAvailableUOMQty: TFloatField;
    qryStockAdjustEntryLinesAllocationFinalUOMQty: TFloatField;
    qryStockAdjustEntryLinesAllocationAdjustUOMQty: TFloatField;
    qryStockAdjustEntryLinesCost: TFloatField;
    qryStockAdjustEntryLinesUOM: TWideStringField;
    qryStockAdjustEntryLinesUOMMultiplier: TFloatField;
    qryStockAdjustEntryLinesDeleted: TWideStringField;
    qryStockAdjustEntryLinesUOMID: TIntegerField;
    qryStockAdjustEntryLinesmsTimeStamp: TDateTimeField;
    qryStockAdjustEntryLinesInStockUOMQty: TFloatField;
    qryStockAdjustEntryLinesPartBarcode: TWideStringField;
    qryStockAdjustEntryLinesFormulaQtyValue1: TFloatField;
    qryStockAdjustEntryLinesFormulaQtyValue2: TFloatField;
    qryStockAdjustEntryLinesFormulaQtyValue3: TFloatField;
    qryStockAdjustEntryLinesFormulaQtyValue4: TFloatField;
    qryStockAdjustEntryLinesFormulaQtyValue5: TFloatField;
    qryStockAdjustEntryLinesFormulaQtyValue: TFloatField;
    dsStockAdjustEntryLines: TDataSource;
    DNMPanel2: TDNMPanel;
    ProgressBar: TProgressBar;
    cboProductQry: TERPQuery;
    cboClassQry: TERPQuery;
    QryUOM: TERPQuery;
    QryUOMUnitname: TWideStringField;
    QryUOMmultiplier: TFloatField;
    QryUOMUnitId: TIntegerField;
    cboAccountQry: TERPQuery;
    cboEmployeeLookup: TERPQuery;
    cboProduct: TERPDbLookupCombo;
    cboClass: TwwDBLookupCombo;
    cboUOM: TwwDBLookupCombo;
    lblProgressbar: TLabel;
    grdTransactions: TwwDBGrid;
    btnDelete: TwwIButton;
    DNMPanel1: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Label160: TLabel;
    txtCustomID: TDBEdit;
    Label1: TLabel;
    cboAccount: TwwDBLookupCombo;
    Label48: TLabel;
    cboEmployee: TwwDBLookupCombo;
    btnToggleMode: TDNMSpeedButton;
    lblStockDate: TLabel;
    cboDBStockDate: TwwDBDateTimePicker;
    DNMPanel3: TDNMPanel;
    DNMPanel4: TDNMPanel;
    DNMPanel5: TDNMPanel;
    btnCompleted: TDNMSpeedButton;
    btnImport: TDNMSpeedButton;
    btnExport: TDNMSpeedButton;
    btnPrint: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    edtReason: TDBMemo;
    lbMemo: TLabel;
    chkDeleted: TwwCheckBox;
    lblDeleted: TLabel;
    qryStockAdjustEntryAdjustmentdate: TDateTimeField;
    qryStockAdjustEntryEnforceUOM: TWideStringField;
    qryStockAdjustEntryAdjustmentOnInstock: TWideStringField;
    Bevel1: TBevel;
    Bevel2: TBevel;
    lblEnforceUOM: TLabel;
    chkEnforceUOM: TwwCheckBox;
    lblAdjustmentOnInstock: TLabel;
    chkAdjustmentOnInstock: TwwCheckBox;
    qryStockAdjustEntryImportgroupOriginalno: TWideStringField;
    lblprocessed: TLabel;
    qryStockAdjustEntryApproved: TWideStringField;
    chkApproved: TwwCheckBox;
    qryStockAdjustEntryLinesProductPrintName: TWideStringField;
    cboPrintProduct: TERPDbLookupCombo;
    qryStockAdjustEntryLinesNotes: TWideStringField;
    DefaultOrder1: TMenuItem;
    qryStockAdjustEntryLinesJobID: TIntegerField;
    qryStockAdjustEntryLinesJobName: TWideStringField;
    qryStockAdjustEntryLinesClassID: TIntegerField;
    cboJob: TwwDBLookupCombo;
    qryJob: TERPQuery;
    qryJobJobId: TIntegerField;
    qryJobJobName: TWideStringField;
    qryJobCompany: TWideStringField;
    qryJobPrintName: TWideStringField;
    qryJobJobNumber: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OverrideAccessLevel(Sender: TObject);
    procedure Setaccesslevel(Sender: TObject);
    procedure chkDeletedEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdTransactionsExit(Sender: TObject);
    procedure qryStockAdjustEntryAdjustmentOnInstockChange(Sender: TField);
    procedure btnImportClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure chkEnforceUOMClick(Sender: TObject);
    procedure grdTransactionsKeyDown1(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdTransactionsEnter(Sender: TObject);
    procedure qryStockAdjustEntryLinesAdjustUOMQtyChange(Sender: TField);
    procedure chkDeletedClick(Sender: TObject);
    procedure btnCompletedEnter(Sender: TObject);
    procedure chkEnforceUOMEnter(Sender: TObject);
    procedure grdTransactionsCalcTitleAttributes(Sender: TObject;
      AFieldName: string; AFont: TFont; ABrush: TBrush;
      var ATitleAlignment: TAlignment);
    procedure grdTransactionsDblClick(Sender: TObject);
    procedure grdTransactionsCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure chkApprovedClick(Sender: TObject);
    procedure DefaultOrder1Click(Sender: TObject);
    procedure qryJobAfterInsert(DataSet: TDataSet);
    (*procedure cboBarcodeNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: String; var Accept: Boolean);*)
  private
    fbisStockTake     : Boolean;
    fiProductID       : Integer;
    TotalCost:Double;
    Newbarcode:String;
    barCodeCreated:Boolean;
    flistProgressBar: TProgressBar;
    fListShowStatus: TGeneralStringProc;

    (*fbAllocationMode: Boolean;*)
    Procedure LockAdjustQty(Const Value :Boolean);
    Procedure LockAllocAdjustQty(Const Value :Boolean);
    Procedure CalcfooterValue;
    Procedure Calcfootervaluecallback(Const Sender: Tbusobj; Var Abort :Boolean);
    Procedure CreateBarCode(Sender:TObject); Overload;
    Procedure CreateBarcode(NewValue: String);Overload;
    procedure LockPartCalcformulafields(const Sender: TDatasetBusObj);
    function Showformuladetails: Boolean;

  Protected
    SavedAccessLevel  : Integer;
    LockedAdjustQty:Boolean;
    LockedAdjustAllocQty:Boolean;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string); Override;
    Procedure checkWriteStatus(fsFieldname:String); virtual; abstract;
    Procedure UpdateBarcode(const Barcode:String);virtual;abstract;
    procedure SetMatrixDetails(sMatrixDesc, sMatrixRef: String;dMatrixPrice: double);Virtual;
    Procedure Hidecolumns;virtual;
    Procedure AfterFormShow; override;
    procedure InitProductLookupQry;virtual;
    Procedure InitERPLookupCombonFields; Override;
  public
    StockAdjust :TStockAdjustEntry;
    Property isStockTake :Boolean read fbisStockTake write fbisStockTake;
    Property ProductId :Integer Read fiProductID write fiProductID;
    procedure Setcolumn(columnVisible: Boolean; columnName: string);
    Property ListProgressBar: TProgressBar read fListProgressBar write fListProgressBar;
    Property ListShowStatus  : TGeneralStringProc REad fListShowStatus  write fListShowStatus;
    (*Property AllocationMode :Boolean Read fbAllocationMode write fbAllocationMode;*)


  end;

implementation

uses BusObjConst, CommonLib, FastFuncs, (*frmBarcodePopUp, *)BaseFormForm,
  BusObjStock, ProductListExpressForm, frmPartsFrm, tcDataUtils, tcConst,
  PartCalcFormulaObj, AppEnvironment,  frmStockAdjustEntryBatch,
  frmStockAdjustEntryBins, frmStockAdjustEntrySN, BusObjApprovals;

{$R *.dfm}

{ TfmStockAdjustEntry }

procedure TfmStockAdjustEntry.DefaultOrder1Click(Sender: TObject);
begin
  inherited;
  TMyQuery(grdTransactions.Datasource.DataSet).IndexFieldNames := '';
  grdTransactions.Datasource.DataSet.Refresh;
  if guiprefs <> nil then
    if guiprefs.Active then
      if guiprefs.DbGridElement[grdTransactions] <> nil then
        guiprefs.DbGridElement[grdTransactions].Node['IndexFieldNames'].asString :=
          TMyQuery(grdTransactions.Datasource.DataSet).IndexFieldNames;
end;

procedure TfmStockAdjustEntry.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
    inherited;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TStockAdjustEntry      then TStockAdjustEntry(Sender).DataSet     := qryStockAdjustEntry;
    end else if(Eventtype = BusObjEvent_Change) and (Value = BusobjEventVal_StockAdjustproduct) then begin
        if StockAdjust.Lines.ProductID<> 0 then begin
          if QryUOM.active then QryUOM.Close;
          QryUOM.Params.ParamByName('KeyID').AsInteger       := StockAdjust.Lines.ProductID;
          QryUOM.open;
        end;
        if (Sender  = StockAdjust.Lines)  then begin
          LockPartCalcformulafields(sender);
          if StockAdjust.Lines.Hasformula then   begin
            StockAdjust.Lines.FormulaQtyValue := 1;
            With TPartCalcFormula.Create(Self) do try InitformulaQtyValues(StockAdjust.Lines);finally Free;end;
          end;
        end else if (Sender  = StockAdjust.LineProducts)  then begin
          LockPartCalcformulafields(sender);
          if StockAdjust.LineProducts.Hasformula then   begin
            StockAdjust.LineProducts.FormulaQtyValue := 1;
            With TPartCalcFormula.Create(Self) do try InitformulaQtyValues(StockAdjust.LineProducts);finally Free;end;
          end;
        end;
    end else if (EventType = BusobjEvent_ToDo) and (Value = BusObjEvent_PartBarcodeNotfound)  then begin
      Createbarcode(StockAdjust.lines.Partbarcode);
    end;
    BusobjProgressbarEvent(sender, eventtype, value);
end;
procedure TfmStockAdjustEntry.LockPartCalcformulafields(const Sender: TDatasetBusObj);
begin
  With TPartCalcFormula.Create(Self) do try
    if Sender =StockAdjust.Lines then
      LockPartCalcformulafields(grdTransactions , StockAdjust.Lines.Hasformula )
    else if sender = StockAdjust.LineProducts then
      LockPartCalcformulafields(grdTransactions , StockAdjust.LineProducts.Hasformula );
  finally
    Free;
  end;
end;
procedure TfmStockAdjustEntry.InitProductLookupQry;
var
  s:String;
begin
  s:= '';
       if Self is TfmStockAdjustEntryBatch  then s:= 'and P.batch ="T" and P.MultipleBins="F" and P.SNTracking = "F" '
  else if self is TfmStockAdjustEntryBins   then s:= 'and P.batch ="F" and P.MultipleBins="T" and P.SNTracking = "F" '
  else if self is TfmStockAdjustEntrySN     then s:= 'and P.batch ="F" and P.MultipleBins="F" and P.SNTracking = "T" '
  else exit;
  cboProductQry.SQL.text  := replacestr(cboProductQry.SQL.text , 'WHERE P.Active = "T"' ,'WHERE P.Active = "T" AND (PARTTYPE="INV")  ' + s);
end;
procedure TfmStockAdjustEntry.FormCreate(Sender: TObject);
begin
  //NamenPrintNameGridObj.AccountLookupQueryWithSearchengine(0, cboAccount);

  fListShowStatus := nil;
  fListProgressBar:= nil;
  cboDBStockDate.displayformat := AppEnv.RegionalOptions.ShortDateformat +' hh:nn:ss am/pm';
  Newbarcode:= '';
  barCodeCreated :=  false;
  AllowCustomiseGrid := True;
  inherited;
  cboAccount.Options := cboAccount.Options + [lotitles];
  cboAccount.Selected.Clear;
  cboAccount.Selected.Add(SelectedText('AccountName' , 'Account name', AppEnv.companyprefs.AccountNamecolumnDropdownWidth        , ''));
  cboAccount.Selected.Add(SelectedText('Type'        , 'Type'        , AppEnv.companyprefs.AccountTypecolumnDropdownWidth        , ''));
  cboAccount.Selected.Add(SelectedText('Description' , 'Description' , AppEnv.companyprefs.AccountDescriptioncolumnDropdownWidth , ''));


  fbTabSettingEnabled := False;
  isStockTake := False;
  ProductId := 0;
  LockedAdjustQty:= False;
  LockedAdjustAllocQty:= False;
  (*fbAllocationMode := False;*)
  //chkApproved.Visible := AppEnv.CompanyPrefs.UseApprovalLevels;
  TransApprovalInit(chkApproved ,  ApprovalTypeStockAdjustment , StockAdjust, 'TotalCostEx',true, nil,nil,nil);
  With TPartCalcFormula.Create(Self) do try    SetdisplayLabel(self);  finally    Free;  end;
end;

procedure TfmStockAdjustEntry.FormShow(Sender: TObject);
var
    QueryNamesNotToOpen: array of string;
begin
  btnExport.Hint := 'When the file is edited, it should be saved in a simple CSV format for importing into ERP.' +NL+
                    '       In Excel, Save as ''Text (MS-DOZ) (*.txt)''' +NL+
                    '       In Open Office, Save as ''Text csv (.csv) (*.csv)'''+NL+
                    'Please note that it should be TAB separated(not coma).' +NL;
  btnExport.showhint := True;
  DisableForm;
  try
    if not(Assigned(StockAdjust)) then begin
        StockAdjust := TStockAdjustEntry.create(Self);
        StockAdjust.confirmFromGUI :=confirmFromGUI;
 //       StockAdjust.Progressbar:= ListProgressBar;
        StockAdjust.connection := TMydacDataconnection.create(StockAdjust);
        StockAdjust.BusObjEvent := DoBusinessObjectEvent;
    end;
    StockAdjust.LockAdjustQty := LockAdjustQty;
    StockAdjust.LockAllocAdjustQty := LockAllocAdjustQty;
    cboProduct.enabled   := ProductID <> 0;
    StockAdjust.connection.connection :=Myconnection;

    GuiPrefs.DbGridElement[grdTransactions].RemoveFields('MatrixRef,MatrixPrice,Matrixdesc');

    inherited;
    //FormatProductCombo(cboProduct);
    Hidecolumns;
    Setlength(QueryNamesNotToOpen, 2);
    QueryNamesNotToOpen[0] := 'qryStockAdjustEntry';
    QueryNamesNotToOpen[1] := 'qryStockAdjustEntryLines';
    OpenQueries(QueryNamesNotToOpen);
    StockAdjust.Load(KeyId);
    GuiPrefs.Active := True;
    lblprocessed.visible := StockAdjust.Processed;
    if btnCompleted.enabled  then btnCompleted.enabled:=not (StockAdjust.Processed);


    if (StockAdjust.Processed) or (StockAdjust.Deleted) then begin
        AccessLevel             := 5;
        Self.Caption            := Self.Caption + '     { Already Processed ! - Cannot Modify }';
        btnDelete.Enabled := false;
    end
    else begin
    (*
      if not StockAdjust.Lock() then begin
          AccessLevel             := 5;
          grdTransactions.Options := grdTransactions.Options - [dgEditing];
          MessageDlgXP_Vista('Unable to make Stock Adjustments at this time as user "' +
          StockAdjust.UserLock.LockInfo.UserName + '" has a Stock Adjustment open ' +
          #13#10 +
          '(since ' + FormatDateTime('hh:mm dd/mm/yy',StockAdjust.UserLock.LockInfo.TimeLocked) +
          ')',mtInformation,[mbOk],0);

      end;
      *)
      btnDelete.Enabled := true;
    end;

    StockAdjust.connection.BeginTransaction;

   if KeyId = 0 then begin
      if AccessLevel <> 5 then begin
        StockAdjust.New;
        try
            chkEnforceUOMClick(chkEnforceUOM);
        except
              // kill the exception
        end;
        StockAdjust.PostDB;
        StockAdjust.Load(StockAdjust.ID) ;
        StockAdjust.isStockTake:= isStockTake;
      end;
    end else begin
      isStockTake := StockAdjust.isStockTake;
      CalcfooterValue;
    end;

    if not StockAdjust.Lock() then begin
      AccessLevel             := 5;
      grdTransactions.Options := grdTransactions.Options - [dgEditing];
      MessageDlgXP_Vista('Unable to make Stock Adjustments at this time as user "' +
          StockAdjust.UserLock.LockInfo.UserName + '" has a Stock Adjustment open ' +
          #13#10 +
          '(since ' + FormatDateTime('hh:mm dd/mm/yy',StockAdjust.UserLock.LockInfo.TimeLocked) +
          ')',mtInformation,[mbOk],0);

      end;

    if (isStockTake)  then begin
        TitleLabel.Caption := 'Stock Take';
        Caption := 'Stock Take';
    end;

    if StockAdjust.Processed and not(StockAdjust.Deleted) then btnCompleted.Caption := '&Save';
    btnCompleted.enabled := not(StockAdjust.Processed) or not(StockAdjust.Deleted);
    StockAdjust.dirty := False;

(*    Application.ShowHint      := true;
    Application.HintPause     := 100;
    Application.HintHidePause := 10000;*)
    chkEnforceUOM.ShowHint    := true;
    chkEnforceUOM.hint        :=
          'When Ticked:This is only showing the Quantity of the selected Unit of Measure.  It is not'+chr(13)+
          'displaying the Quantity of any other Unit of Measure for this product, as it is expecting'+chr(13)+
          'you to count the Quantities separately.  ie.If You have 2 Cartons and 8 singles,it will only'+chr(13)+
          'display as 2 Cartons.'+chr(13)+chr(13)+
          'When not Ticked:This will display the Quantity in the select Unit of Measure of the selected '+chr(13)+
          'Product as a total of all Units of Measure. ie. If You have 2 Cartons and 8 singles,it will'+chr(13)+
          'display as 2.8 Cartons';
    chkAdjustmentOnInstock.showHint := True;
    chkAdjustmentOnInstock.hint  :=
          'When Ticked: This will calculate the values in-stock based on the ''In-Stock'' column' + chr(13)+
          'When not Ticked: This will calculate the values in-stock bases on the ''Available'' Column.'+chr(13) +
          'ie. If you have 100 in stock and 20 on Sales Order, with the option ticked, it will base the ' +chr(13)+
          'adjustment on 100. If the option is not ticked, it will base the adjustment on 80';
    SavedAccessLevel := AccessLevel;
    if StockAdjust.Deleted then SetControlFocus(btnClose);
    With TPartCalcFormula.Create(Self) do try ShowFormulaQtyFields(Self);finally Free;end;
    SetControlfocus(grdTransactions);
  finally
 //   StockAdjust.Progressbar:= ProgressBar;
    EnableForm;
  end;
end;

procedure TfmStockAdjustEntry.OverrideAccessLevel(Sender: TObject);
begin
  inherited;
    SavedAccessLevel := Accesslevel;
    AccessLevel := AppEnv.AccessLevels.GetEmployeeAccessLevel(Self.ClassName) ;
    if assigned(StockAdjust) then
        StockAdjust.AccessManager.AccessLevel := AccessLevel;
end;

procedure TfmStockAdjustEntry.Setaccesslevel(Sender: TObject);
begin
  inherited;
  if Accesslevel = SavedAccessLevel then Exit;
    if assigned(StockAdjust) then     begin
        StockAdjust.postDB;
        StockAdjust.AccessManager.AccessLevel := SavedAccessLevel;
    end;
    AccessLevel := SavedAccessLevel;
end;


procedure TfmStockAdjustEntry.SetMatrixDetails(sMatrixDesc, sMatrixRef: String;
  dMatrixPrice: double);
begin

end;

procedure TfmStockAdjustEntry.chkDeletedEnter(Sender: TObject);
begin
  inherited;
    if StockAdjust.Deleted and StockAdjust.StockMovement.Deleted then exit;
    OverrideAccessLevel(sender);
end;

procedure TfmStockAdjustEntry.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    Action := cafree;
  inherited;
end;

procedure TfmStockAdjustEntry.AfterformShow;
begin
  inherited;
  if StockAdjust.processed then btnCompleted.caption := '&Save' else btnCompleted.caption := '&Hold';
end;

procedure TfmStockAdjustEntry.btnCloseClick(Sender: TObject);
begin
  inherited;
  Application.processmessages;
  Self.Close;
end;

procedure TfmStockAdjustEntry.btnCompletedClick(Sender: TObject);
begin
  inherited;
  Self.close;
end;

procedure TfmStockAdjustEntry.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ErrorOccurred then Exit;

  CanClose := false;
  if assigned(StockAdjust) and (StockAdjust.Dirty) then begin
      case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
        mrYes:begin
            OverrideAccessLevel(nil); // if readonly and set deleted
            try
              if StockAdjust.Save then begin
                StockAdjust.Connection.CommitTransaction;
                CanClose := true;
              end;
            finally
                Setaccesslevel(Nil);
            end;
          end;
        mrNo:begin
            StockAdjust.Connection.RollbackTransaction;
            StockAdjust.Dirty := false;
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

procedure TfmStockAdjustEntry.LockAdjustQty(const Value: Boolean);
begin
  grdTransactions.ColumnByName('AdjustuomQty').ReadOnly := Value;
  grdTransactions.ColumnByName('finalUomQty').ReadOnly  := Value;
  LockedAdjustQty := Value;
end;

procedure TfmStockAdjustEntry.LockAllocAdjustQty(const Value: Boolean);
begin
  grdTransactions.ColumnByName('AllocationAdjustUOMQty').ReadOnly := Value;
  grdTransactions.ColumnByName('allocationfinalUomQty').ReadOnly  := Value;
  LockedAdjustAllocQty := Value;
end;

procedure TfmStockAdjustEntry.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
(*var
  ProductId:Integer;
  ProductName: string;*)
begin
  inherited;
  if StockAdjust.Processed then exit;
(*  if (Key = 192) and (not (ssAlt in Shift)) then begin  // ~ key
    ProductId := TfmBarcodePopUp.GetProductID('', ProductName);
    if ProductId > 0 then begin
      if StockAdjust.Lines.ProductID> 0 then StockAdjust.Lines.New;
      StockAdjust.Lines.ProductID := ProductId;
      cboProduct.LookupTable.Locate('PARTSID', ProductId, []);
      cboProduct.Text := ProductName;
      SetControlFocus(grdTransactions);
      Key := 0;
    end;
  end;*)
end;

procedure TfmStockAdjustEntry.grdTransactionsExit(Sender:TObject);
begin
  inherited;
  StockAdjust.Lines.PostDB;
end;

procedure TfmStockAdjustEntry.qryJobAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qryStockAdjustEntryLinesJobID.AsInteger := qryJobJobID.AsInteger;
end;

procedure TfmStockAdjustEntry.qryStockAdjustEntryAdjustmentOnInstockChange(
  Sender: TField);
begin
  inherited;
  grdTransactionsEnter(grdTransactions);
end;

procedure TfmStockAdjustEntry.btnImportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfmStockAdjustEntry.btnPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfmStockAdjustEntry.btnExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfmStockAdjustEntry.chkEnforceUOMClick(Sender: TObject);
var
  FieldList:TStringList;
begin
  if self.ActiveControl <> Sender then exit;
  inherited;
  FieldList := TStringList.create;
  try
    FieldList.text := grdTransactions.Selected.text;
    StockAdjust.EnforceUOM := chkEnforceUOM.checked;
    StockAdjust.PostDB;
    StockAdjust.EditDB;
    if StockAdjust.EnforceUOM then begin
      FieldList.text := StringReplace(FieldList.text , #9+'Quantity' , #9+'UOM Quantity as Bought and Sold' , [rfReplaceAll, rfIgnoreCase]);
      FieldList.text := StringReplace(FieldList.text , #9+'Product''s total Quantity read as UOM' ,#9+'UOM Quantity as Bought and Sold' , [rfReplaceAll, rfIgnoreCase]);
    end else begin
      FieldList.text := StringReplace(FieldList.text , #9+'Quantity' , #9+'Product''s total Quantity read as UOM' , [rfReplaceAll, rfIgnoreCase]);
      FieldList.text := StringReplace(FieldList.text , #9+'UOM Quantity as Bought and Sold' , #9+'Product''s total Quantity read as UOM', [rfReplaceAll, rfIgnoreCase]);
    end;
    grdTransactions.Selected := FieldList;
    grdTransactions.refresh;
    //grdTransactions.RedrawGrid;
  finally
    freeandnil(fieldList);
  end;
end;

procedure TfmStockAdjustEntry.grdTransactionsKeyDown1(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  fsFieldname :String;
begin
  if ((SameText(ActiveField(Sender).FieldName , 'MatrixDesc')) or (SameText(ActiveField(Sender).FieldName , 'MatrixPrice'))) and (key <> vk_return) and (Key <> vk_tab) then begin
    Key:=0;
    exit;
  end;
  inherited;
  if ((key>=43) and (key<=57)) or ((Key >=96) and (Key <=105)) then begin
    fsfieldName := grdTransactions.GetActiveField.FieldName;
    checkWriteStatus(fsFieldname);
  end;
end;

procedure TfmStockAdjustEntry.Hidecolumns;
begin
    SetColumn(False, qryStockAdjustEntryLinesGlobalRef.Fieldname);
    SetColumn(False, qryStockAdjustEntryLinesStockAdjustEntryLinesID.Fieldname);
    SetColumn(False, qryStockAdjustEntryLinesStockAdjustEntryID.Fieldname);
    SetColumn(False, qryStockAdjustEntryLinesProductID.Fieldname);
    SetColumn(False, qryStockAdjustEntryLinesClassID.Fieldname);
    SetColumn(False, qryStockAdjustEntryLinesAvailableQty.Fieldname);
    SetColumn(False, qryStockAdjustEntryLinesFinalQty.Fieldname);
    SetColumn(False, qryStockAdjustEntryLinesAdjustQty.Fieldname);
    SetColumn(False, qryStockAdjustEntryLinesAllocationAvailableQty.Fieldname);
    SetColumn(False, qryStockAdjustEntryLinesAllocationFinalqty.Fieldname);
    SetColumn(False, qryStockAdjustEntryLinesAllocationAdjustQty.Fieldname);
    SetColumn(False, qryStockAdjustEntryLinesDeleted.Fieldname);
    SetColumn(False, qryStockAdjustEntryLinesUOMID.Fieldname);
    SetColumn(False, qryStockAdjustEntryLinesmsTimeStamp.Fieldname);
    //if AppEnv.CompanyPrefs.HidecostFromStockforms then
    if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnAllowtoSeecostInStockforms')<> 1 then begin
      SetColumn(False, qryStockAdjustEntryLinesCost.Fieldname);
    end;
end;

procedure TfmStockAdjustEntry.grdTransactionsCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  try
    With TPartCalcFormula.create(Self) do try   gridCalcCellColors(StockAdjust.lines.Hasformula  , Sender,Field,State,Highlight,AFont,ABrush);  finally    Free;  end;
  Except
    //kill the exception
  end;
end;

procedure TfmStockAdjustEntry.grdTransactionsCalcTitleAttributes(
  Sender: TObject; AFieldName: string; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  inherited;
  With TPartCalcFormula.create(Self) do try   gridCalcTitleAttributes(Sender,AFieldName,AFont,ABrush,ATitleAlignment );  finally   Free;  end;
end;

procedure TfmStockAdjustEntry.grdTransactionsDblClick(Sender: TObject);
begin
  inherited;
  if showformuladetails then exit;
end;
procedure TfmStockAdjustEntry.Setcolumn(columnVisible: Boolean; columnName: String);
begin
  if columnVisible then begin
    (*if displaylabel <> '' then begin
      if grdTransactions.ColumnByName(columnName) = nil then begin
        if qryStockAdjustEntryLines.findfield(columnName) <> nil then
          qryStockAdjustEntryLines.fieldbyname(columnName).DisplayLabel :=DisplayLabel;
      end else begin
        grdTransactions.ColumnByName(columnName).DisplayLabel := DisplayLabel;
      end;
    end;*)
    grdTransactions.AddField(columnName);
  end else begin
    guiprefs.DbGridElement[grdTransactions].RemoveField(columnName);
    GuiPrefs.DbGridElement[grdTransactions].HideField(columnName);
  end;
end;

procedure TfmStockAdjustEntry.grdTransactionsEnter(Sender: TObject);
begin
  inherited;
//
end;

procedure TfmStockAdjustEntry.qryStockAdjustEntryLinesAdjustUOMQtyChange(
  Sender: TField);
begin
  inherited;
  CalcfooterValue;
end;

procedure TfmStockAdjustEntry.CalcfooterValue;
begin
  totalcost := 0;
  StockAdjust.Lines.Iteraterecords(Calcfootervaluecallback);
  grdTransactions.columnbyname('totalcost').FooterValue :=FloatToStrF(Totalcost, ffCurrency, 15, CurrencyRoundPlaces);
end;

procedure TfmStockAdjustEntry.Calcfootervaluecallback(
  const Sender: Tbusobj; var Abort: Boolean);
begin
  if not (sender is TSAELines) then exit;
  TotalCost := totalcost +TSAELines(sender).totalcost
end;

procedure TfmStockAdjustEntry.chkApprovedClick(Sender: TObject);
begin
  inherited;
(*  if TwwCheckBox(Sender).Focused then
    TwwCheckBox(Sender).DataSource.DataSet.FieldByName(TwwCheckBox(Sender).DataField).AsBoolean := TwwCheckBox(Sender).Checked;*)
end;

procedure TfmStockAdjustEntry.chkDeletedClick(Sender: TObject);
begin
  inherited;
  if screen.activecontrol <> sender then exit;
  if self.visible = false then exit;
  if StockAdjust.Deleted and (not StockAdjust.StockMovement.Deleted) then begin
    CommonLib.MessageDlgXP_Vista('This Stock Adjustment is flagged as deleted but it''s linked Stock Movement record is not deleted.' + #13#10 + #13#10 +
      'This will be corrected by flagging this Stock Adjustment as not deleted.',mtwarning,[mbOk],0);
    StockAdjust.Deleted := false;
    StockAdjust.PostDb;
    StockAdjust.Connection.Connection.Commit;
    StockAdjust.Connection.Connection.StartTransaction;
    chkDeleted.Checked := false;
    exit;
  end;

  if StockAdjust.Deleted <>  chkDeleted.Checked then StockAdjust.Deleted := chkDeleted.Checked;
  SetControlFocus(btnCompleted);
end;

procedure TfmStockAdjustEntry.btnCompletedEnter(Sender: TObject);
begin
  inherited;
  StockAdjust.PostDB;
  if StockAdjust.Deleted then btnCompleted.caption := '&Save';
end;

procedure TfmStockAdjustEntry.chkEnforceUOMEnter(Sender: TObject);
begin
  inherited;
    accessLevel := 5;
    lblEnforceUOM.Enabled := False;
    chkEnforceUOM.Enabled := False;
    chkAdjustmentOnInstock.Enabled := False;
    lblAdjustmentOnInstock.Enabled := False;
    cboDBStockDate.Enabled := False;
    lblStockDate.Enabled := False;
end;

(*procedure TfmStockAdjustEntry.cboBarcodeNotInList(Sender: TObject;
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
              updatebarcode(NewValue);
            end;
        end;
  end;
end;*)

(*procedure TfmStockAdjustEntry.CreateBarCode(Sender: TObject);
begin
  with TwwDBGrid(Sender).Datasource.dataset do begin
    if active      = False then exit;
    if RecordCount = 0 then exit;
    if findfield('PartsId') = nil then exit;
    if fieldByname('PartsID').asInteger = 0 then exit;
    barCodeCreated:=  TProduct.AssignBarCode(fieldByname('PartsID').asInteger, Newbarcode);
  end;

end;*)
procedure TfmStockAdjustEntry.CreateBarcode(Sender: TObject);
begin
  with TwwDBGrid(Sender).Datasource.dataset do begin
    if active      = False then exit;
    if RecordCount = 0 then exit;
    if findfield('PartsId') = nil then exit;
    if fieldByname('PartsID').asInteger = 0 then exit;
    TProduct.AssignBarCode(fieldByname('PartsID').asInteger, StockAdjust.Lines.partbarcode);
  end;
end;

Procedure TfmStockAdjustEntry.CreateBarcode(NewValue: String);
var
  frm  :TfrmParts;
  ans :word;
begin
  inherited;
  ans:= CommonLib.MessageDlgXP_Vista('This Barcode not found. Would you like to create?',
      mtConfirmation, [], 0  , nil , '' , '' , False, nil , 'Create New Product,Add Barcode to a Product,Cancel');
      try
  if ans = 102 then begin
  end else if ans = 101 then begin
    with TProductListExpressGUI(GetComponentByClassName('TProductListExpressGUI', true)) do begin
          ExpresslistPopup('Choose Product' , CreateBarCode, False);
          Showmodal;
    end;
  end else begin
        if TfrmParts.FormActive then begin
          TfrmParts.CloseMe;
        end;

        frm := TfrmParts(GetComponentByClassName('TfrmParts'));
        if assigned(frm) then begin
            TfrmParts(frm).fsBarcode := StockAdjust.lines.Partbarcode;
            frm.Position := poScreenCenter;
            if not frm.Visible then  frm.ShowModal;
        end;
    end
  finally
    StockAdjust.Lines.productname := tcdatautils.GetProductForbarCode(StockAdjust.lines.Partbarcode);
    if StockAdjust.Lines.productname = '' then StockAdjust.lines.Partbarcode:= '';
  end;
end;
function TfmStockAdjustEntry.showformuladetails: Boolean;
begin
  Result := False;
    if StockAdjust.lines.hasformula = False then exit;
    if  (grdTransactions.GetActiveField = qryStockAdjustEntryLines.findfield('UnitOfMeasureQty'))  or
        (grdTransactions.GetActiveField = qryStockAdjustEntryLines.findfield('FormulaQtyValue'))  or
        (grdTransactions.GetActiveField = qryStockAdjustEntryLines.findfield('FormulaQtyValue1'))  or
        (grdTransactions.GetActiveField = qryStockAdjustEntryLines.findfield('FormulaQtyValue2'))  or
        (grdTransactions.GetActiveField = qryStockAdjustEntryLines.findfield('FormulaQtyValue3'))  or
        (grdTransactions.GetActiveField = qryStockAdjustEntryLines.findfield('FormulaQtyValue4'))  or
        (grdTransactions.GetActiveField = qryStockAdjustEntryLines.findfield('FormulaQtyValue5'))  then begin
        Result := true;
        With TPartCalcFormula.Create(Self) do try          FormulaDetails(StockAdjust.Lines , StockAdjust.Lines.Product , False);        finally          Free;        end;
    end;
end;
procedure TfmStockAdjustEntry.InitERPLookupCombonFields;
begin
  inherited;
  SetupProductNamenPrintNameinGrid(cboProduct ,cboPrintProduct ,'ProductName' , 'ProductPrintName' , 'PARTSDESCRIPTION' , grdTransactions );
  InitProductLookupQry;
end;

end.
