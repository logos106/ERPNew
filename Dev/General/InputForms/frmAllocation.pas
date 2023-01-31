unit frmAllocation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, wwdblook, DB, wwcheckbox, Grids, Wwdbigrd, Wwdbgrid,
  DBAccess, MyAccess,ERPdbComponents, MemDS, Buttons, ExtCtrls, DNMPanel, ComCtrls,
  treelist, busobjPQA, BaseInputForm, busobjbase, DNMSpeedButton,
  BaseFormForm, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  Shader, ImgList, ProgressDialog;
const
  SX_ExpandGrid = WM_USER + 140;
  SX_AutoCloseform = WM_USER + 150;

type
  TfmAllocation = class(TBaseInputGUI)
    dsbatch: TDataSource;
    dsbins: TDataSource;
    dssn: TDataSource;
    lbins: TERPQuery;
    qbatch: TERPQuery;
    qbatchcSnsofBatch: TWideStringField;
    qbatchcBinsofBatch: TWideStringField;
    qbatchValue: TWideStringField;
    qbatchExpiryDate: TDateTimeField;
    qbatchQty: TFloatField;
    qbatchGlobalRef: TWideStringField;
    qbatchPQADetailID: TIntegerField;
    qbatchPQAID: TIntegerField;
    qbatchPQAType: TWideStringField;
    qbatchParentRef: TWideStringField;
    qsn: TERPQuery;
    qsnValue: TWideStringField;
    qsnGlobalRef: TWideStringField;
    qsnQty: TFloatField;
    qsnPQADetailID: TIntegerField;
    qsnPQAID: TIntegerField;
    qsnPQAType: TWideStringField;
    qsnParentRef: TWideStringField;
    qsnExpiryDate: TDateTimeField;
    qsncsn: TWideStringField;
    qbatchUOMQty: TFloatField;
    qsnUOMQty: TFloatField;
    lbinsGlobalRef: TWideStringField;
    lbinsBinID: TIntegerField;
    lbinsClassId: TIntegerField;
    lbinsBinLocation: TWideStringField;
    lbinsBinNumber: TWideStringField;
    lbinsActive: TWideStringField;
    lbinsvolume: TFloatField;
    lbinsVolume_Used: TFloatField;
    lbinsmsTimeStamp: TDateTimeField;
    qbatchActive: TWideStringField;
    qsnActive: TWideStringField;
    qbins: TERPQuery;
    qbinscSnsofBin: TWideStringField;
    qbinsbinlocation: TWideStringField;
    qbinsBinnumber: TWideStringField;
    qbinsUOMQty: TFloatField;
    qbinsQty: TFloatField;
    qbinsParentRef: TWideStringField;
    qbinsGlobalRef: TWideStringField;
    qbinsPQAID: TIntegerField;
    qbinsValue: TWideStringField;
    qbinsPQADetailID: TIntegerField;
    qbinsPQAType: TWideStringField;
    qbinsExpiryDate: TDateTimeField;
    qbinsActive: TWideStringField;
    pnlBottom: TDNMPanel;
    btnclose: TDNMSpeedButton;
    btnDelete: TDNMSpeedButton;
    btncancel: TDNMSpeedButton;
    btnFill: TDNMSpeedButton;
    pnlDetails: TScrollBox;
    gbatch: TwwDBGrid;
    gbatchIButton: TwwIButton;
    gsn: TwwDBGrid;
    gbins: TwwDBGrid;
    gbinsIButton: TwwIButton;
    cbobinNumber: TwwDBLookupCombo;
    cbobinLocation: TwwDBLookupCombo;
    btnSnofBatch: TwwExpandButton;
    btnbinsofBatch: TwwExpandButton;
    btnSnofbin: TwwExpandButton;
    pnlProductDetails: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    lblTransaction: TLabel;
    lblProductName: TLabel;
    lblqty: TLabel;
    lblNote: TLabel;
    lbinsVolumeAvailable: TFloatField;
    lblExtra: TLabel;
    lbinNo: TERPQuery;
    lbinNoGlobalRef: TWideStringField;
    lbinNoBinID: TIntegerField;
    lbinNoClassId: TIntegerField;
    lbinNoBinLocation: TWideStringField;
    lbinNoBinNumber: TWideStringField;
    lbinNoActive: TWideStringField;
    lbinNovolume: TFloatField;
    lbinNoVolume_Used: TFloatField;
    lbinNomsTimeStamp: TDateTimeField;
    lbinNomsUpdateSiteCode: TWideStringField;
    lbinNoVolumeAvailable: TFloatField;
    qbatchBOQty: TFloatField;
    qbatchBOUOMQty: TFloatField;
    popBatch: TAdvPopupMenu;
    mnuCopytoClipboard: TMenuItem;
    mnuPastefromClipboard: TMenuItem;
    qbinsBinID: TIntegerField;
    qbatchTruckLoadNo: TWideStringField;
    qbatchCUSTFLD1: TFloatField;
    lblNote2: TLabel;
    btnPrint: TDNMSpeedButton;
    pnlChooseRpt: TDNMPanel;
    chkChooseRpt: TCheckBox;
    qbatchCUSTFLD2: TIntegerField;
    qbinsCUSTFLD2: TIntegerField;
    qsnCUSTFLD2: TIntegerField;
    popSN: TAdvPopupMenu;
    CopytoClipboard1: TMenuItem;
    PastefromClipboard1: TMenuItem;
    qbatchCUSTFLD3: TIntegerField;
    qbatchCUSTFLD4: TIntegerField;
    qbatchCUSTFLD5: TWideStringField;
    qbatchCUSTFLD6: TFloatField;
    qbatchCUSTFLD7: TFloatField;
    procedure cbobinLocationCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
      modified: Boolean);
    procedure btncloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSnofBatchBeforeExpand(Sender: TObject);
    procedure btnSnofbinBeforeExpand(Sender: TObject);
    procedure btnbinsofBatchBeforeExpand(Sender: TObject);
    procedure qbatchAfterInsert(DataSet: TDataSet);
    procedure qbinsAfterInsert(DataSet: TDataSet);
    procedure qsnAfterInsert(DataSet: TDataSet);
    procedure FormPaint(Sender: TObject);
    procedure gbatchEnter(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btncancelClick(Sender: TObject);
    procedure btnSnofBatchAfterCollapse(Sender: TObject);
    procedure gsnExit(Sender: TObject);
    procedure gbinsExit(Sender: TObject);
    procedure gbatchExit(Sender: TObject);
    procedure cbobinLocationNotInList(Sender: TObject;LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
    procedure btnFillClick(Sender: TObject);
    procedure qbatchBeforePost(DataSet: TDataSet);
    procedure qbinsBeforePost(DataSet: TDataSet);
    procedure qsnBeforePost(DataSet: TDataSet);
    procedure gbatchKeyPress(Sender: TObject; var Key: Char);
    procedure btnSnofBatchAfterExpand(Sender: TObject);
    procedure btnbinsofBatchAfterExpand(Sender: TObject);
    procedure KeyUpEvent(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure qbatchBeforeInsert(DataSet: TDataSet);
    procedure qbinsBeforeInsert(DataSet: TDataSet);
    procedure qsnBeforeInsert(DataSet: TDataSet);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure lbinsCalcFields(DataSet: TDataSet);
    procedure qbatchAfterPost(DataSet: TDataSet);
    procedure gbatchColExit(Sender: TObject);
    procedure qbatchBeforeOpen(DataSet: TDataSet);
    procedure qbinsBeforeOpen(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lbinNoCalcFields(DataSet: TDataSet);
    procedure cbobinLocationChange(Sender: TObject);
    procedure gbinsColExit(Sender: TObject);
    procedure gsnColExit(Sender: TObject);
    procedure gbatchBeforePaint(Sender: TObject);
    procedure mnuCopytoClipboardClick(Sender: TObject);
    procedure mnuPastefromClipboardClick(Sender: TObject);
    procedure qbatchAfterOpen(DataSet: TDataSet);
    procedure FormResize(Sender: TObject);
    procedure qbatchUOMQtyChange(Sender: TField);
    procedure qbatchBOUOMQtyChange(Sender: TField);
    procedure qbatchCUSTFLD1Change(Sender: TField);
    procedure btnPrintClick(Sender: TObject);
    procedure CopytoClipboard1Click(Sender: TObject);
    procedure PastefromClipboard1Click(Sender: TObject);
  private
    fLastcombo  : TwwDbLookupcombo;
    fPQABatch   : TPQABatch;
    fPQABins    : TPQABins;
    fPQASN      : TPQASN;
    fbissn      : Boolean;
    fbIsBatch   : Boolean;
    fbisbin     : Boolean;
    fdallocated : Double;
    fdTotal     : Double;
    fbformshowing: Boolean;
    autoSelect  : Boolean;
    prevBatch: string;
    PrevTruckNo:String;
    ProcessingKey:Boolean;
    fbbtnSaveclicked :Boolean;


    Procedure SetGridproperties(CurGrid:TwwDbGrid);
    Procedure EditDB(Ds:TDataset);
    Procedure postDB(ds:TDataset);
    function  GetPQA:TPQA;
    Procedure SetPQA(Const Value :TPQA);
    Function  AutoAlloc(const PQADetails :TPQADetails; const PQAtype :String; const ReqQty, ReqUOMQty :Double;  const ParentValue:String=''; const ParentExpiryDaye :TDatetime=0 ;const ParentPQAType:String=''):Boolean;
    Procedure REadtotalQty(Const Sender: TBusObj; var Abort: boolean);
    Procedure MoveForms(formExt: TForm);
    Procedure OpenAllocExt;
    procedure SetAllocRO(const Value: Boolean);
    procedure ExpandGrid(var Message: TMessage); message SX_ExpandGrid;
    procedure AutoCloseform(var Message: TMessage); message SX_AutoCloseform;
    procedure LocateInvalidRec;
    Procedure SerialNoSelected(Sender:TObject);
    procedure AddBatchNumberSuffix;
    (*procedure CreateBin(const fiClassID: Integer; var FsBinLocation,      fsBinnumber: String);Overload;*)
    procedure OnBinselect(Sender:TwwDBGrid);
    procedure beforeShowbiblist(Sender: TObject);
    Procedure ReadGuipref;
    Procedure WriteGuiPref;
    procedure Deleteifbinidis0(const Sender: TBusObj; var Abort: boolean);
    procedure ImportFromClipBoard;
    procedure CopyToClipBoard;
    procedure HandleGridPaint(var Msg: TMessage); message TX_GridPaint;
    Function NextNo(Value:String; var PrefixofNo:String; Var No:String; var errMsg:String):Boolean;
    procedure NextTruckNo;
    procedure UpdateBatchTotals;
    procedure DoUpdateBatchTotals;
    procedure ImportSNFromClipBoard;
    procedure CopySNToClipBoard;
    function SaveRecord: Boolean;
    //procedure InitformPosition(grd: TwwDBGrid);
  protected
    fPQA      :TPQA;
    procedure OnComboNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean); override;
    Procedure RefreshbinDet;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    Procedure CreateAllocObjects; virtual;
    Procedure LoadAllocObjects; virtual;
    function  getPQAforDEtails:TPQA;
    Procedure SetFormnGridWidth;
    procedure CreateBin(const fiClassID , fibinid: Integer);
    procedure DoFormSize(ChangeSize:Boolean);Override;
    function GetReportTypeID: integer; Override;
    Function SAAllocationTables:String ; Virtual;
  public
    allocated   : boolean;
    curGrid     : TwwDbgrid;
    procedure Centralisebuttons(OwnerPanel:TDnMPanel; leftmargin :Integer =0; rightMargin :Integer =0; btngap:Integer=4); override;
    function AddDEfaultbin(xPQABins :TPQABins):Boolean;
    Class Function    DoBinBatchform(PQA :TPQA; Sender:TBaseForm; IsLocked:Boolean=False;openFormanyway:Boolean =False ) :Boolean; virtual;
    Class Procedure   getAllocationform(Sender:TBaseForm; var form:TfmAllocation); virtual;
    Class Function    ShowProductDetails:Boolean; overload;
    Class Procedure   ShowProductDetails(const value :Boolean);overload;
    Property PQA     :TPQA      read GetPQA     write SetPQA;
    Property PQABatch:TPQABatch read fPQABatch  write fPQABatch;
    Property PQABins :TPQABins  read fPQABins   write fPQABins;
    Property PQASN   :TPQASN    read fPQASN     write fPQASN;
    Property isbatch :Boolean   read fbIsBatch  write fbIsBatch;
    Property isbin   :Boolean   read fbisbin    write fbisbin;
    Property issn    :Boolean   read fbissn     write fbissn;
    Property AllocRO :Boolean   Write SetAllocRO;

  end;

implementation

uses CommonLib, FastFuncs, BusObjConst, CommonDbLib,
  BusObjStock, AppEnvironment, frmBinLocation,
  DecimalRounding, AppContextObj, frmAllocationExtender,
  ProductQtyLib,  MySQLConst,
  frmAllocationSrjobnoExtender, frmBinLocations, BusObjProductbin,
  CommonFormLib, BinLocationList, tcDataUtils, tcConst, ClipBrd, Types, StrUtils,
  GridFieldsObj, BusObjProductClass, MAIN , StringUtils,
  TemplateReportsLib, BaseListingForm, AllocationLib;

{$R *.dfm}


function DateToString(aDate: TDateTime): string;
begin
  result := '';
  if aDate = 0 then exit;
  result := DateToStr(aDate);
end;




Class Function TfmAllocation.DoBinBatchform(PQA :TPQA; Sender:TBaseForm; IsLocked:Boolean=False;openFormanyway:Boolean =False) :Boolean;
var
    Form :TfmAllocation;
    fdVolume :Double;
(*    index :Integer;*)
begin
Result := True;
try
    if (not(Assigned(PQA))) or (PQA.id = 0) then exit;
    if (PQA.Product.Batch = False) and ( PQA.Product.Multiplebins = False) and ( PQA.Product.SnTracking = False) Then exit;
    if  (PQA.Qty = 0) and  (not(SameText(PQA.classname, 'TStockAdjustEntryPQA'))) then Exit;
//    if PQA.ISBo then exit;
    if PQA.CrossStockAdjustTransForinvoice then exit;
    if PQA.Product.MultipleBins then
        if AppEnv.CompanyPrefs.EnforceBinVolume then
            if PQA.Product.Volume = 0 then begin
                if CommonLib.MessageDlgXP_Vista(PQA.Product.Productname + ' uses Bins and the volume is not specified. Do you want to update the volume now?', mtconfirmation, [mbyes,mbNo], 0) = mrNo then begin
                    REsult := False;
                    Exit;
                End;
                if PQA.Product.Lock then begin
                    try
                        fdVolume := CustomInputFloat('Product Volume' , 'Enter volume of ' + PQA.Product.Productname);
                        if fdVolume > 0 then begin
                            PQA.Product.Volume := fdvolume;
                            PQA.Product.PostDB;
                            PQA.Product.Save;
                        end else begin
                            REsult := False;
                            Exit;
                        End;
                    finally
                      PQA.Product.UnLock;
                    end;
                end else begin
                    CommonLib.MessageDlgXP_Vista('Unable to update ' + PQA.Product.ProductName + '''s volume as ' +
                            'product is being updated by "' +PQA.Product.UserLock.LockInfo.UserName +
                            '" with: ' + PQA.Product.UserLock.LockInfo.LockingForm , mtWarning , [mbOK] , 0);
                    Result := False;
                    Exit;
                end;
            end;


    getAllocationform(Sender , Form);
    if not (Assigned(Form)) then exit;
    if (IsLocked = False) and (assigned(Sender)) and (sender is TBaseInputGUI) then IsLocked:= Sender.AccessLevel>=5;
    form.allocRO := IsLocked;
    form.Gbatch.UseTFields:= true;
    form.GBins.UseTFields := true;
    form.GSN.UseTFields   := true;
    try

        Form.PQA := PQA;
        Form.PQA.Connection.BeginNestedTransaction;
        Form.isbatch := PQA.Product.Batch;
        Form.isbin:= PQA.Product.Multiplebins;
        Form.issn:= PQA.Product.SnTracking;
        PQA.PostDB; // to ge the id
        if PQA.Alloctype = 'OUT' then
            if (PQA.Product.Batch) and (PQA.PQABatch.count = 0) then begin
                if PQA.Product.AutoAllocBatch then begin
                    if Form.AutoAlloc(PQA.PQAbatch , PQA.PQAbatch.PQADetailtype, PQA.Qty , PQA.UOMQty ) then
                      if (openFormanyway=False) and (Form.issn =False) then begin
                        PQA.doAfterAllocate;
                        form.PQA.connection.CommitNestedTransaction;
                        Exit;
                     end;
                end;
            end else if (PQA.Product.Multiplebins) and (PQA.PQABins.count =0) then begin
                if PQA.Product.Autoallocbin then begin
                    if Form.AutoAlloc(PQA.PQABins, PQA.PQABins.PQADetailtype, PQA.Qty , PQA.UOMQty ) then
                      if (openFormanyway =False) and (Form.issn=False) then begin
                        PQA.doAfterAllocate;
                        Form.PQA.connection.CommitNestedTransaction;
                        Exit;
                      end;
                end;
            end;

        if  Form.isbatch then
          Form.Qbatch.SQL.text :=  'Select * from tblPQADetails where PQAType = '+QuotedStr(TPQABatch.pqadetailtype) +  ' and  PQAID = ' + IntToStr(PQA.ID);
        if form.isbin then
          Form.Qbins.SQL.text :=  'Select * from tblPQADetails where PQAType = '+QuotedStr(TPQABins.pqadetailtype) +  ' and  PQAID = ' + IntToStr(PQA.ID);
        if  form.isSN then
          Form.QSN.SQL.text :=  'Select * from tblPQADetails where PQAType = '+QuotedStr(TPQASn.pqadetailtype) +  ' and  PQAID = ' + IntToStr(PQA.ID);

        if  Form.isbatch then begin
            Form.PQABatch.Dataset.Filter := (*'PQAID = ' + IntToStr(PQA.ID) +  ' and *)'(ParentREf = ' + QuotedStr('') + ' or ParentRef = null)';
            Form.PQABatch.Dataset.filtered := true;
            Form.gbatch.visible      := true;
            Form.qbatchTruckLoadNo.Visible:=  appenv.Companyprefs.ShowAllocationBatchTruckLoadNo;
            Form.qbatchExpiryDate.Visible:=  appenv.Companyprefs.ShowAllocationBatchExpiryDate;
            Form.qbatchcBinsofBatch.Visible:=  Form.isbin;
            Form.qbatchcSnsofBatch.Visible := ( Form.isSN = true) and ( form.isbin = False);
            Form.qbinscSnsofBin.Visible  :=  form.isSN;
            if ( form.isSN = true) and ( form.isbin = False) then
                Form.qsn.MasterSource := Form.dsbatch;
            //Form.SetFormnGridWidth;
        end else if  form.isbin then begin
            Form.qbins.mastersource := nil;
            Form.PQABins.Dataset.Filter := (*'PQAID = ' + IntToStr(PQA.ID) +  ' and*)' (ParentREf = ' + QuotedStr('') + ' or ParentRef = null)';
            Form.PQABins.Dataset.filtered := true;
            Form.gbatch.visible      := False;
            Form.btnbinsofBatch.grid := nil;
            Form.gbins.visible       := true;
            Form.qbinscSnsofBin.Visible  :=  form.isSN;
            //Form.SetFormnGridWidth;
        end else if  form.isSN then begin
            Form.qsn.mastersource := nil;
            Form.PQASN.Dataset.Filter := (*'PQAID = ' + IntToStr(PQA.ID) +  ' and*)' (ParentREf = ' + QuotedStr('') + ' or ParentRef = null)';
            Form.PQASN.Dataset.filtered := true;
            Form.gbatch.visible      := False;
            Form.gbins.visible       := False;
            Form.gsn.visible         := true;
            Form.btnSnofBatch.grid   := nil;
            Form.btnbinsofBatch.grid := nil;
            Form.btnSnofbin.grid     := nil;
            Form.btnbinsofBatch.grid := nil;
            //Form.SetFormnGridWidth;
        end else begin
          Form.PQA.connection.RollbackNestedTransaction;
          Exit;
        end;

     (* if Form.isbatch then begin
        if Form.pqabatch.count = 0 then begin
          index:= Form.PQA.POnumber;
          if index<> 0 then begin
            Form.pqabatch.New;
            Form.pqabatch.Batchno := 'PO-' + IntToStr(index);
                 if Form.qbatchcBinsofBatch.Visible  then Form.gbatch.SetActiveField('cBinsofBatch')
            else if Form.qbatchcSnsofBatch.Visible   then Form.gbatch.SetActiveField('cSnsofBatch')
            else Form.gbatch.SetActiveField('Value');
            Form.pqabatch.UOMQTY :=PQA.UOMQty;
            Form.pqabatch.PostDB;
            Form.gbatch.SetActiveField('UOMQTY');
          end;
        end;
        if (Form.isbin) and (Form.PQABins.count = 0 ) then
          if Form.AddDefaultbin  then begin
            if  ((Form.PQA.Product.Batch=false) OR (Form.PQA.Product.AutoAllocBatch)) and
                ((Form.PQA.Product.Multiplebins=false) OR (Form.PQA.Product.Autoallocbin)) then begin
                Form.PQA.connection.CommitNestedTransaction;
                Exit;
            end;
          end;
      end;*)

        (*form.Gbatch.UseTFields:= true;
        form.GBins.UseTFields:= true;
        form.GSN.UseTFields:= true;*)
        try
          Form.showmodal;
        Except
          on E:EXception do begin
            MessageDlgXP_Vista('3.' + E.Message, mtWarning, [mbOK], 0);
          end;
        end;
        Result := form.allocated;
        form.allocated := False;
    finally
        Freeandnil(Form)
    end;
Except
  on E:EXception do begin
    MessageDlgXP_Vista('2:' +E.Message, mtWarning, [mbOK], 0);
  end;
end;
end;

procedure TfmAllocation.cbobinLocationChange(Sender: TObject);
begin
  inherited;
  CloseDb(lbinNo);
  lbinNO.ParamByName('BinLocation').AsString := lbins.FieldByName('BinLocation').AsString;
  OpenDb(lbinNo);
end;

procedure TfmAllocation.cbobinLocationCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if Modified = false then Exit;
    Editdb(twwDBLookupcombo(Sender).Datasource.dataset);
    twwDBLookupcombo(Sender).Datasource.dataset.fieldByname('Value').asstring := LookupTable.FieldByName('BinID').asString;
    postdb(twwDBLookupcombo(Sender).Datasource.dataset);
end;
Procedure TfmAllocation.LocateInvalidRec;
var
  Shift:TShiftState;
  Key: Word;
begin
  {a complicated procedure to locate the invalid grid/record in the allocation form's master-detail grids.}
  if (PQA.InvalidDetailID = 0) or (PQA.InValidDetailtype = '') then Exit;

  if (curgrid = gsn) and (gbins.visible) then begin
      gbins.SetActiveField('cSnsofBin');
      btnSnofbin.Expanded := False;
  end;
  if (curgrid = gsn) and (gbatch.visible) then begin
      gbatch.SetActiveField('cSnsofBatch');
      btnSnofBatch.Expanded := False;
  end;
  if (curgrid = gbins) and (gbatch.visible) then begin
      gbatch.SetActiveField('cbinsofBatch');
      btnBinsofBatch.Expanded := False;
  end;
  Shift := [ssctrl] ;
  Key:=VK_DOWN;
  try
    if PQA.InValidDetailtype = TPQABatch.PQADetailtype then begin
      PQABatch.Dataset.Locate('PQADetailID' , PQA.InvalidDetailID , []);
      if PQA.ISParentInvalid then if issn then KeyUpEvent(gbatch, Key, Shift);
    end else if PQA.InValidDetailtype = TPQAbins.PQADetailtype then begin
      if isbatch then begin
        fPQABins := PQABatch.PQABins;
        PQABins.Dataset.Locate('PQADetailID' , PQA.InvalidDetailID , []);
        if PQAbatch.Dataset.Locate('GlobalRef' , PQAbins.ParentRef , []) then
          KeyUpEvent(gBatch, Key, Shift);
          if PQA.ISParentInvalid then if issn then KeyUpEvent(gbins, Key, Shift);
      end;
    end else if PQA.InValidDetailtype = TPQASN.PQADetailtype then begin
      if isbin and not(Isbatch) then begin
        fPQASN :=PQAbins.PQASN;
        PQASN.Dataset.Locate('PQADetailID' , PQA.InvalidDetailID , []);
        if PQAbins.Dataset.Locate('GlobalRef' , PQASN.ParentREf , []) then
          KeyUpEvent(gbins, Key, Shift);
      end else if isbatch  and not(isbin) then begin
        fPQASN :=PQABatch.PQASN;
        PQASN.Dataset.Locate('PQADetailID' , PQA.InvalidDetailID , []);
        if PQAbatch.Dataset.Locate('globalref' , PQASN.ParentREf , []) then
          KeyUpEvent(gBatch, Key, Shift);
      end else if isbatch  and (isbin) then begin
        PQABatch.dataset.first;
        While PQABatch.dataset.Eof = False do begin
          fPQABins := PQABatch.PQABins;
          PQAbins.dataset.first;
          While PQABins.dataset.Eof = False do begin
           fPQASN := PQABatch.PQABins.PQASN;
            if PQASN.Dataset.Locate('PQADetailID' , PQA.InvalidDetailID , []) then begin
              if PQAbins.Dataset.Locate('GlobalRef' , PQASN.ParentREf , []) then begin
                if PQAbatch.Dataset.Locate('GlobalRef' , PQAbins.ParentREf , []) then
                  KeyUpEvent(gBatch, Key, Shift);
                  KeyUpEvent(gbins, Key, Shift);
                Exit;
              end;
            end;
            PQABins.dataset.Next;
          end;
          PQABatch.dataset.Next;
        end;
      end else begin
        PQASN.Dataset.Locate('PQADetailID' , PQA.InvalidDetailID , []) ;
      end;
    end;
  Except
    // to kill the exception if sub object is not created at all.
    // eg: a bin batch product, only batch allocated and bin is not
  end;
end;

procedure TfmAllocation.mnuCopytoClipboardClick(Sender: TObject);
begin
  inherited;
  Self.CopyToClipBoard;
end;

procedure TfmAllocation.mnuPastefromClipboardClick(Sender: TObject);
begin
  inherited;
  self.ImportFromClipBoard;
end;

procedure TfmAllocation.btncloseClick(Sender: TObject);
begin
  if SaveRecord  then
    Self.Close;
end;

function TfmAllocation.SaveRecord :Boolean;
var
    oldsilentMode:Boolean;
    IsValid:Boolean;
begin
  result := False;
  DisableForm;
  try
    try
      if assigned(PQABatch) then PQABatch.PostDB;
      if assigned(PQAbins) then PQAbins.PostDB;
      if assigned(PQASn) then PQASn.PostDB;
    except
        //kill the exception - before post deletd the empty record and aborts
    end;
    PQA.Refreshall;
    oldsilentMode := PQA.silentMode;
    PQA.SilentMode := false;
    try
        IsValid :=   PQA.ValidateAllocation;
        if PQA.Errmsg <> ''  then    begin
          PQA.Resultstatus.AddItem(False, rssError, 0,PQA.Errmsg);
        end else
          if PQA.Warnmsg <> '' then
            if CommonLib.MessageDlgXP_Vista(PQA.Warnmsg+chr(13)+ chr(13)+chr(13)+'Do you wish to Fix it now?', mtconfirmation, [mbyes,mbNo], 0) = mrYes then
              isValid:= False;
        if IsValid then begin
          PQA.Save;
          PQA.doAfterAllocate;
          PQA.connection.CommitNestedTransaction;
          PQA.refreshall;
          allocated := true;
          if assigned(PQABatch) then PQABatch.dirty := False;
          if assigned(PQAbins) then PQAbins.dirty := FAlse;
          if assigned(PQASn) then PQASN.dirty := False;
          fbbtnSaveclicked:= True;
          result := True;
        end;
        PQA.Errmsg := '';
        PQA.Warnmsg := '';
        if isValid = False then
          LocateInvalidRec;
    Finally
        PQA.SilentMode := oldsilentMode;
    end;
  finally
    EnableForm;
  end;
end;

function TfmAllocation.GetPQA:TPQA;
begin
    result := fPQA;
end;
Procedure TfmAllocation.SetPQA(Const Value :TPQA);
var
  index:Integer;
begin
    if fPQA = Value then exit;

    fPQA:= Value;
    fPQA.name := 'PQA';
    if fPQA = nil then exit;

    CreateAllocObjects;

    PQABatch.connection := TMydacdataconnection.create(PQABatch);
    PQABins.connection  := TMydacdataconnection.create(PQABins);
    PQASN.connection    := TMydacdataconnection.create(PQASN);

    PQABatch.connection.connection:=PQA.connection.Connection;
    PQABins.connection.connection :=PQA.connection.Connection;
    PQASN.connection.connection   :=PQA.connection.Connection;

    PQABatch.BusObjEvent:=DoBusinessObjectEvent;
    PQABins.BusObjEvent :=DoBusinessObjectEvent;
    PQASN.BusObjEvent   :=DoBusinessObjectEvent;

    if lbins.Active then lbins.close;
    if lbinNo.Active then lbinNo.close;
    if PQA.DepartmentID <> 0 then begin
      lbins.Params.ParamByName('ClassId').asInteger:= PQA.DepartmentID;
      lbinNo.Params.ParamByName('ClassId').asInteger:= PQA.DepartmentID;
    end
    else begin
      lbins.Params.ParamByName('ClassId').asInteger := AppEnv.DefaultClass.ClassID;
      lbinNo.Params.ParamByName('ClassId').asInteger := AppEnv.DefaultClass.ClassID;
    end;


    for index := 0 to ComponentCount-1 do
      if Components[index] is TERPQuery then begin
        if TERPQuery(Components[index]).Connection <> PQA.connection.Connection then begin
          if TERPQuery(Components[index]).active then TERPQuery(Components[index]).close;
          TERPQuery(Components[index]).Connection := PQA.connection.Connection;
        end;
      end;
end;

procedure TfmAllocation.FormCreate(Sender: TObject);
begin
  inherited;
  fbbtnSaveclicked := False;
  ShowAtCursor:= True;
  ProcessingKey:= False;
  autoSelect := False;
  fbTabSettingEnabled := False;
  DoubleBuffered := False;
  Self.Color := GetGradientColor(Self.Owner.Classname).color;
  if assigned(fPQA) then begin
    fPQA.name := '';
    fPQA:= nil;
  end;
  fbformshowing := False;
  PrevTruckNo := '';
  AlignbuttonTopnHeight(pnlBottom);
end;

Procedure   TfmAllocation.EditDB(Ds:TDataset);
begin
  if ds.State in [dsEdit,dsInsert] then else ds.Edit;
end;
Procedure   TfmAllocation.postDB(ds:TDataset);
begin
  try
    if ds.State in [dsEdit,dsInsert] then ds.Post;
  except
      // kill the exception if post failed because of empty record
  end;
end;

Procedure TfmAllocation.SetFormnGridWidth;

var
  grid:TwwDbgrid;
  ctr :integer;
begin

    if  isbatch then begin
      SetControlFocus(gbatch);
           if qbatchcBinsofBatch.Visible  then gbatch.SetActiveField('cBinsofBatch')
      else if qbatchcSnsofBatch.Visible   then gbatch.SetActiveField('cSnsofBatch')
      else gbatch.SetActiveField('Value');
//      gbatch.SetActiveField('UOMQty');
    end else if isbin then begin
      SetControlFocus(gbins);
      gbins.SetActiveField('Binlocation');
    end else if issn then begin
      SetControlFocus(gsn);
      gsn.SetActiveField('Value');
    end;


    if isbatch then begin
      if isbin then begin
        gbins.width := gbatch.width-9;
        if issn then gsn.width := gbins.width-1;
      end else if issn then gsn.Width := gbatch.width-9;
    end else if isbin then begin
      gbins.width := gbatch.width-9;
    end;


  grid := nil;
  ctr := 0;
  if  isbatch    then Grid :=gbatch
  else if  isbin then Grid := gbins
  else if  isSN  then Grid := gSn;

  if  isbatch        then ctr:= ctr+1;
  if  isbin then ctr:= ctr+1;
  if  isSN   then ctr:= ctr+1;

  if ctr =0 then exit;
  if not (AssigneD(grid)) then exit;
  grid.top := 3;
  grid.left := 3;
  grid.width := pnlDetails.width - (6 + pnlDetails.Margins.left + pnlDetails.Margins.right);
  if gbatch.height< pnlDetails.height - (6 + pnlDetails.Margins.bottom + pnlDetails.Margins.top) then gbatch.height := pnlDetails.height - (6 + pnlDetails.Margins.bottom + pnlDetails.Margins.top);
  if gbins.height < gbatch.height then gbins.height := gbatch.height;
  if gsn.height   < gbatch.height then gsn.height   := gbatch.height;
  //grid.height := pnlDetails.height - 6;
  //Setcolwidth(grid , true);
(*  AdjustGridcols(gbatch, true);
  AdjustGridcols(gbins, true);
  AdjustGridcols(gsn, true);*)
    Self.width := 453;
    qbatchcBinsofBatch.DisplayWidth := 7;
    qbatchcSnsofBatch.DisplayWidth := 17;
    qbatchValue.DisplayWidth := 18;
    qbatchExpiryDate.DisplayWidth := 10;
    qbatchTruckLoadNo.DisplayWidth := 12;
    qbatchUOMQty.DisplayWidth := 10;
    qbatchBOUOMQty.DisplayWidth := 8;
    qbinscSnsofBin.DisplayWidth := 11;
    qbinsbinlocation.DisplayWidth := 19;
    qbinsBinnumber.DisplayWidth := 13;
    qbinsUOMQty.DisplayWidth := 12;
    qsnValue.DisplayWidth := 45;
    qsnCustFld2.DisplayWidth := 5;
    end;
(*procedure TfmAllocation.InitformPosition(grd:TwwDBGrid);
var
  p:TPoint;
  index :Integer;
  Procedure getgridPosition(grd:TwwDBGrid);
  var
    obj :Tcontrol;
  begin
    obj := grd;
    p.x := obj.Left;
    p.y := obj.top;
    while obj.parent <> nil do begin
      P := obj.parent.ScreenToClient(obj.ClientToScreen(p));
      obj := Tcontrol(obj.parent);
    end;
  end;
begin
      if assigned(grd)then begin
        getgridPosition(grd);
        p.y:= p.y+(grd.TitleLines*grd.RowHeights[0])+((grd.GetActiveRow+1) *grd.RowHeights[grd.GetActiveRow])+50;
        for index := 0 to grd.GetActiveCol do p.x := p.x + grd.ColWidths[index];

        P := Application.MainForm.ScreenToClient(TBaseInputGUI(Self.Owner).ClientToScreen(p));
        p.x:= (p.x+Application.MainForm.left)-60;
        p.y := p.y+Application.MainForm.top;
        if p.x +Self.Width> Application.MainForm.width+Application.MainForm.Left then p.x := (Application.MainForm.width+Application.MainForm.Left) - Self.Width;
        if p.y +Self.height> Application.MainForm.height+Application.MainForm.top then p.y := (Application.MainForm.height+Application.MainForm.top)- Self.height;
      end else begin
        p.x  := Mouse.CursorPos.X;
        p.y  := Mouse.CursorPos.Y;
      end;
      self.Left := p.x;
      self.Top := p.y;
end;*)
procedure TfmAllocation.FormShow(Sender: TObject);
var
  //grd:TwwDBGrid;
  index :Integer;
  Function getPQAbin :TPQABins;
  begin
    if Assigned(fPQABins) and isbatch then begin
      fPQABins.closedb;
      if fPQABins.owner = self then
        Freeandnil(fPQABins);
    end;
    if isbatch  then
      result :=  pqabatch.pqabins
    else Result := PQABins;
  end;
begin
  DisableForm;
  try
    inherited;
    cbobinNumber.OnDblClick:= nil;
    cbobinLocation.OnDblClick:= nil;
    LoadAllocObjects;
    for index := 0 to ComponentCount-1 do
      if Components[index] is TERPQuery then
        if TERPQuery(Components[index]).active = False then begin
               if (TERPQuery(Components[index]) = qbatch)  and (isbatch= false) then
          else if (TERPQuery(Components[index]) = qbins)   and (isbin  = false) then
          else if (TERPQuery(Components[index]) = qsn)     and (issn   = false) then
          else TERPQuery(Components[index]).open;
        end;
    if ShowProductDetails then begin
      lblTransaction.Caption := PQA.TransactionName;
      lblProductName.caption := PQA.ProductName;
      lblqty.Caption := 'Allocating ' + FloattoStr(PQA.UOMQty) + '  ' +PQA.UnitOfMeasure+'   ';
      Self.Height := Self.Height +pnlProductDetails.Height;
      pnlProductDetails.visible := true;
    end else begin
      pnlProductDetails.visible := false;
    end;

    if Assigned(PQA) then begin
      if isbatch then begin
        if pqabatch.count = 0 then begin
          index:= PQA.POnumber;
          if index<> 0 then begin
            pqabatch.New;
            pqabatch.Batchno := 'PO-' + IntToStr(index) + '-'+inttostr(PQA.TransLineId)+'-1';
            if qbatchcBinsofBatch.Visible  then gbatch.SetActiveField('cBinsofBatch')
            else if qbatchcSnsofBatch.Visible   then gbatch.SetActiveField('cSnsofBatch')
            else gbatch.SetActiveField('Value');
            if PQA.IsBO then
              pqabatch.BOUOMQty := PQA.UOMQty
            else
              pqabatch.UOMQTY :=PQA.UOMQty;
            pqabatch.PostDB;
//            gbatch.SetActiveField('UOMQTY');
          end;
        end;
        UpdateBatchTotals;
      end;
      if isbin then
        if  (isbatch = false) or  ( pqabatch.UOMQTY <> 0) then
          if AddDefaultbin(getPQAbin)  then
            PostMessage(Self.Handle, SX_AutoCloseform, 0, 0);

      (*grd := nil;
      if Self.Owner is TBaseForm then begin
        with TBaseForm(Self.Owner) do begin
          if TBaseForm(self.owner).Activecontrol is TwwDBGrid then
            grd :=TwwDBGrid(TBaseForm(self.owner).Activecontrol)
          else for index := 0 to ComponentCount-1 do
            if Components[index] is TwwDBGrid then begin
              grd :=TwwDBGrid(Components[index]);
              break;
            end;
        end;
      end;
      InitFormPosition(grd);*)
    end else begin
      if dgEditing      in gbatch.Options     then gbatch.Options   := gbatch.Options     - [dgEditing];
      if dgEditing      in gbins.Options      then gbatch.Options   := gbins.Options      - [dgEditing];
      if dgEditing      in gsn.Options        then gbatch.Options   := gsn.Options        - [dgEditing];
      if dgAllowInsert  in gbatch.KeyOptions  then gbatch.KeyOptions:= gbatch.KeyOptions  - [dgAllowInsert];
      if dgAllowInsert  in gbins.KeyOptions   then gbatch.KeyOptions:= gbins.KeyOptions   - [dgAllowInsert];
      if dgAllowInsert  in gsn.KeyOptions     then gbatch.KeyOptions:= gsn.KeyOptions     - [dgAllowInsert];
      Self.Align := alclient;
    end;
    {get default value for the batch of PO}
    //Centralisebuttons(pnlBottom);
(*    if  isbatch then begin
      SetControlFocus(gbatch);
           if qbatchcBinsofBatch.Visible  then gbatch.SetActiveField('cBinsofBatch')
      else if qbatchcSnsofBatch.Visible   then gbatch.SetActiveField('cSnsofBatch')
      else gbatch.SetActiveField('Value');
//      gbatch.SetActiveField('UOMQty');
    end else if isbin then begin
      SetControlFocus(gbins);
      gbins.SetActiveField('Binlocation');
    end else if issn then begin
      SetControlFocus(gsn);
      gsn.SetActiveField('Value');
    end;

    fbformshowing := True;
    if isbatch then begin
      if isbin then begin
        gbins.width := gbatch.width-9;
        if issn then gsn.width := gbins.width-1;
      end else if issn then gsn.Width := gbatch.width-9;
    end else if isbin then begin
      gbins.width := gbatch.width-9;
    end;*)
    SetFormnGridWidth;
    fbformshowing := True;
    LocateInvalidRec;
  finally
    ReadGuipref;
    Centralisebuttons(pnlBottom);
    if gsn.visible then SetFocusedcontrol(gsn)
    else if gbins.visible then SetFocusedcontrol(gbins)
    else if gbatch.visible then SetFocusedcontrol(gbatch);
    EnableForm;
    //TimerMsg(lblExtra , 'SHIFT + ALT + CTRL + RIGHT/LEFT to resize the form.' +NL+'Form size and column widths gets saved as user preference' , 10);
    TimerMsg(lblExtra , 'SHIFT + ALT + CTRL + RIGHT/LEFT to resize the form.' +NL+'Form size and column widths gets saved as user preference' , 10000000);
    //lblExtra.Caption :=  'SHIFT + ALT + CTRL + RIGHT/LEFT to resize the form.' +NL+'Form size and column widths gets saved as user preference';
    //lblExtra.Visible := true;
  end;
end;

procedure TfmAllocation.DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TPQABatch then
      TPQABatch(Sender).Dataset := qbatch
    else if Sender is TPQABins then
      TPQABins(Sender).Dataset := qbins
    else if Sender is TPQASN then
      TPQASN(Sender).Dataset := qsn;
  end else if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_SearchProductID) then begin
    if Sender is TPQADetails then TPQADetails(Sender).ProductIDfromform :=PQA.ProductID;
  end else if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_SearchDepartmentId) then begin
    if Sender is TPQADetails then TPQADetails(Sender).DepartmentIdfromform :=PQA.DepartmentId;
  end;
end;

procedure TfmAllocation.DoFormSize(ChangeSize: Boolean);
begin
  //inherited;
end;

procedure TfmAllocation.CreateBin(const fiClassID , fibinid: Integer);
var
  fsloc, fsnum:String;
  fdvol:Double;
begin
  with TProductBin.CreateWithNewConn(Self) do try
    Load(fiBinID);
    fsloc:= Binlocation;
    fsnum:=binnumber;
    fdvol:=binvolume;

    connection.BeginTransaction;
    New;
    binlocation := fsLoc;
    binnumber :=  fsNum;
    ClassId:=  fiClassID;
    BinVolume:=fdVol;
    PostDb;
    if not save then begin
      connection.RollbackTransaction;
      exit;
    end;
    connection.CommitTransaction;
  finally
    Free;
  end;
end;
(*procedure TfmAllocation.CreateBin(const fiClassID: Integer;var FsBinLocation, fsBinnumber: String);
begin
var
  Form : TfmbinLocation;
begin
 Form:= TfmbinLocation(GetComponentByClassName('TfmbinLocation',TRue, Self));
 try
        if Form.visible then Form.close;
        Form.Keyid               := 0;
        Form.Formcolor           := Self.Color;
        Form.ClassId             := fiClassID;
        Form.edtBinLocation.text := fsBinlocation;
        Form.edtBinnumber.text   := fsBinnumber;
        if Form.ShowModal = mrok then begin
          fsBinlocation := Form.BinLocation;
          fsBinnumber := Form.BinNumber;
        end;

 finally
     FreeandNil(Form);
 end;
end;*)
procedure TfmAllocation.qbatchAfterInsert(DataSet: TDataSet);

  function NextBatchNumber: string;
  var
    x: integer;
    s: string;
  begin
    s:= '';
    result:= '';
    for x := Length(prevBatch) downto 1 do begin
      if CharInSet(prevBatch[x],['0'..'9']) then
        s:= prevBatch[x] + s
      else
        Break;
    end;
    if s <> '' then
      result:= Copy(prevBatch,1,x) + IntToStr(StrToInt(s)+1);
  end;

begin
  inherited;
  if prevBatch <> '' then begin
    qbatchValue.AsString:= NextBatchNumber;
  end;
  PQA.PostDB;
  PQABatch.PQAID := PQA.ID;
  PQABatch.ParentRef := '';
  NextTruckNo;
end;
procedure TfmAllocation.qbatchAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qbatchValue.displaylabel      := AppEnv.DefaultClass.AllocationBatchnoName;
  qbatchExpiryDate.displaylabel := AppEnv.DefaultClass.AllocationExpiryDateName;
  qbatchTruckLoadNo.displaylabel:= AppEnv.DefaultClass.AllocationTruckLoadNoName;
  qbatchCUSTFLD1.displaylabel   := AppEnv.Companyprefs.PQADEtailsCUSTFLD1;
  qbatchCUSTFLD1.visible        := AppEnv.Companyprefs.EnablePQADEtailsCUSTFLD1;

end;

Procedure TfmAllocation.NextTruckNo;
var
  TrucknoPref:String;
  iNo:String;
  errMsg:String;
  Truckno:String;
begin
  if not Appenv.Companyprefs.ShowAllocationBatchTruckLoadNo then exit;
  if PrevTruckNo  = '' then exit;
  Truckno := '';
  if Appenv.CompanyPrefs.GenerateNextNoforAllocationBatchTruckLoadNo then if NextNo(PrevTruckNo , TrucknoPref , iNo , errMsg) then Truckno :=  (*TrucknoPref + Trim(IntToStr(iNo))*)TrucknoPref + iNo;
  if Appenv.CompanyPrefs.KeepSameNoforAllocationBatchTruckLoadNo then  Truckno := PrevTruckNo;;
  EditDb(qbatch);
  qbatchTruckLoadNo.asString := Truckno;
end;
procedure TfmAllocation.qbatchAfterPost(DataSet: TDataSet);
begin
  inherited;
  AddBatchNumberSuffix;
end;

procedure TfmAllocation.qbinsAfterInsert(DataSet: TDataSet);
begin
  inherited;
  PQA.PostDB;
  PQABins.PQAID := PQA.ID;
  if isbatch then begin
      PQABatch.PostDB;
      PQABins.ParentRef :=PQABatch.globalref;
  end else PQABins.ParentRef :='';
end;

procedure TfmAllocation.qsnAfterInsert(DataSet: TDataSet);
begin
  inherited;
  PQA.postDB;
  PQASN.PQAID := PQA.ID;
  if isbin then begin
    PQABins.PostDB;
    PQASN.ParentRef :=PQABins.globalref;
  end else if isbatch then begin
    PQABatch.PostDB;
    PQASN.ParentRef:=PQABatch.globalref;
  end else PQASN.ParentRef :='';
end;

procedure TfmAllocation.FormPaint(Sender: TObject);
begin
// kill formpaint which changes the color
//  inherited;
end;

procedure TfmAllocation.FormResize(Sender: TObject);
begin
  inherited;
//  if WindowState = wsMaximized then WindowState := wsnormal;
end;

procedure TfmAllocation.gbatchBeforePaint(Sender: TObject);
begin
  inherited;
  PostMessage(Handle, TX_GridPaint, TwwDbGrid(Sender).Handle, 0);
end;

procedure TfmAllocation.gbatchColExit(Sender: TObject);
begin
  inherited;
  if SameText(gBatch.GetActiveField.FieldName,'Value') then
    self.AddBatchNumberSuffix;
  lblExtra.Visible := false;
end;

procedure TfmAllocation.gbatchEnter(Sender: TObject);
var
  Key: Word;
  Shift:TShiftState;
begin
  inherited;
    curGrid := TwwdbGrid(Sender);
    if (gsn.visible) then
        if (PQA.InTrans)  and (*(PQA.PONumber <> 0) and*) (curGrid = gsn) then begin
            btnFill.Enabled := True;
        end else begin
            btnFill.Enabled := False;
        end;
    SetGridproperties(CurGrid);
    if not fbformshowing then
      if PQA.InTrans then begin
         if CurGrid.Datasource.Dataset.recordcount = 0 then begin
          autoSelect := True;
          Key := VK_f9;
          KeyUpEvent(curGrid, Key, Shift);
          AutoSelect := False;
        end;
      end;
    if (curGrid <> gsn) or (PQA.Alloctype = 'IN')  then  lblNote.caption := 'Press F9 to get the Available Allocation.'
    else lblNote.caption := 'F9 for the Available Allocation and F8 for the Serial/Job Number List.';
end;
procedure TfmAllocation.Centralisebuttons(OwnerPanel:TDnMPanel; leftmargin :Integer =0; rightMargin :Integer =0; btngap:Integer=4);
var
    ctr :Integer;
    Procedure Addbutton( button :TDnMspeedButton);
    begin
        if button.visible then begin
            ctr := ctr+1;
            Setlength(Buttons , ctr);
            Buttons[ctr-1] := button.Name;
        end;
    end;
begin
    ctr:= 0;
    Addbutton(btnclose);
    btnFill.visible := False;
    if (issn) and (PQA.intrans) then begin
      btnFill.visible := true;
      addbutton(btnFill);
      btnFill.Enabled :=  true;
    end else btnFill.Enabled :=  False;
    Addbutton(btnPrint);
    Addbutton(btnDelete);
    Addbutton(btncancel);
    inherited Centralisebuttons(pnlBottom);
    pnlBottom.paint;
end;

procedure TfmAllocation.CopySNToClipBoard;
var
  Buff: String;
  bm: TBookmark;
begin
  Buff := '';
  if (not gsn.Visible) or (PQASN.Count = 0) then exit;
//  Buff := '"Serial Number"' + #9 + '"Qty"' + #9 + '"BO Qty"' + #13#10;
  Buff := '"Serial Number"' + #13#10;

  bm := PQASN.Dataset.GetBookmark;
  try
    PQASN.Dataset.DisableControls;
    try
      PQASN.First;
      while not PQASN.EOF do begin
//        Buff := Buff + '"' + PQASN.SerialNumber + '"' + #9 +
//                       FloatToStr(PQASN.UOMQty) +  #9 +
//                       FloatToStr(PQASN.BOUOMQty) + #13#10;
        Buff := Buff + '"' + PQASN.SerialNumber + '"' + #13#10;
        PQASN.Next;
      end;
      PQASN.Dataset.GotoBookmark(bm);
    finally
      PQASN.Dataset.EnableControls;
    end;
  finally
    PQASN.FreeBookmark(bm);
  end;
  Clipboard.asText:= Buff;
end;

procedure TfmAllocation.CopyToClipBoard;
var
  Buff: String;
  bm: TBookmark;
begin
  Buff := '';
  if (not gbatch.Visible) or (PQABatch.Count = 0) then exit;
  Buff := '"Batch Number"' + #9 + '"Expiry Date"' + #9 + iif(qbatchtruckloadno.visible ,   '"' +qbatchtruckloadno.displaylabel +'"' + #9  , '')   + '"Qty"' + #9 + '"BO Qty"' + #13#10;

  bm := PQABatch.Dataset.GetBookmark;
  try
    PQABatch.Dataset.DisableControls;
    try
      PQABatch.First;
      while not PQABatch.EOF do begin
        Buff := Buff + '"' + PQABatch.Batchno + '"' + #9 +
                       '"' + DateToString(PQABatch.ExpiryDate) + '"' + #9 +
                       iif(qbatchtruckloadno.visible ,   '"' +qbatchtruckloadno.asString +'"' + #9  , '')   +
                       FloatToStr(PQABatch.UOMQty) +  #9 +
                       FloatToStr(PQABatch.BOUOMQty) + #13#10;
        PQABatch.Next;
      end;
      PQABatch.Dataset.GotoBookmark(bm);
    finally
      PQABatch.Dataset.EnableControls;
    end;
  finally
    PQABatch.FreeBookmark(bm);
  end;
  Clipboard.asText:= Buff;
end;

procedure TfmAllocation.CopytoClipboard1Click(Sender: TObject);
begin
  inherited;
  self.CopySNToClipBoard;
end;

procedure TfmAllocation.btnDeleteClick(Sender: TObject);
begin
    if not Assigned(curGrid) then exit;
    Postdb(curGrid.datasource.dataset);
    if CommonLib.MessageDlgXP_Vista('Do you wish to delete this record?' , mtConfirmation , [mbyes, mbno], 0) = mryes then begin
        PQA.refreshall;
        if curgrid = gbatch then begin
          PQAbatch.delete;
          UpdateBatchTotals;
        end
        else if curgrid = gbins then PQABins.Delete
        else if curgrid = gsn then PQASn.delete;
//        curGrid.Datasource.Dataset.close;
//        curGrid.Datasource.Dataset.open;
        curGrid.Datasource.Dataset.Refresh;
        SetFocusedcontrol(CurGrid);
    end;
end;
procedure TfmAllocation.btncancelClick(Sender: TObject);
begin
  inherited;
    Self.close;
end;

procedure TfmAllocation.btnSnofBatchAfterCollapse(Sender: TObject);
begin
    inherited;
    PostDB(TwwDbGrid(TwwExpandButton(Sender).Grid).Datasource.Dataset);
    btnFill.Enabled := False;
end;

procedure TfmAllocation.gsnColExit(Sender: TObject);
begin
  inherited;
  lblExtra.Visible := false;
end;

procedure TfmAllocation.gsnExit(Sender: TObject);
begin
    inherited;
    PQASN.postdb;
    lblNote.caption := 'Press F9 to get the Available Allocation.';
end;

procedure TfmAllocation.HandleGridPaint(var Msg: TMessage);
var
  Min: integer;
  Max: integer;
  LeftPos: integer;
  TopPos: integer;
  TmpBitmap: TBitmap;
  ControlCanvas: TControlCanvas;
  ScrollBarVisible: boolean;
  ScrollBarAdjust: integer;
begin
//  if (GuiPrefs.Node['SearchMode.type'].asString = 'Full') or (GuiPrefs.Node['SearchMode.type'].asString = '') or (NonSearchMode) then begin
//    grdMain.OnBeforePaint := nil;
//    exit;
//  end;

  if not gbatch.Visible then
    exit;
  if not(csDestroying in ComponentState) then begin
    inherited;
    TmpBitmap := TBitmap.Create;
    ControlCanvas := TControlCanvas.Create;
    try
      //
      // Determine if the horizontal scroll bar is visible and adjust the
      // vertical positioning of the watermark if it is
      //
      GetScrollRange(gbatch.Handle, SB_HORZ, Min, Max);
      ScrollBarVisible := (Min <> Max);
      if ScrollBarVisible then ScrollBarAdjust := 16
      else ScrollBarAdjust := 0;
      TmpBitmap.Transparent := True;
      TmpBitmap.TransparentColor := Self.Color;
      TmpBitmap.Width := gbatch.Width;
      TmpBitmap.Height := gbatch.Height;
      ControlCanvas.Control := gbatch;
      TmpBitmap.Canvas.CopyRect(Rect(0, 0, gbatch.Width, gbatch.Height), ControlCanvas, Rect(0, 0, gbatch.Width, gbatch.Height));
      //
      // Calculate the position to draw the watermark
      //
      LeftPos := (gbatch.Width - imgGridWatermark.Picture.Bitmap.Width - 20) div 2;
      TopPos := (gbatch.Height - imgGridWatermark.Picture.Bitmap.Height + gbatch.RowHeights[0] - ScrollBarAdjust) div 2;
      //
      // Draw watermark
      //
      ControlCanvas.Draw(LeftPos, TopPos, imgGridWatermark.Picture.Bitmap);
      //
      // Paint the grid over the watermark
      //
      ControlCanvas.Draw(0, 0, TmpBitmap);
    finally
      FreeandNil(TmpBitmap);
      FreeandNil(ControlCanvas);
      fPaintTimer.enabled := True;
    end;

  end;
end;

procedure TfmAllocation.ImportFromClipBoard;
var
  Buff: string;
  lines, line: TStringDynArray;
  x,y: integer;
  BatchNoField, ExpiryDateField, QtyField, BOQtyField, TruckLoadnoField: integer;
  UOMQty: double;
  BOUOMQty: double;

  function LineField(FieldNo: integer): string;
  begin
    result := '';
    if FieldNo <= High(line) then begin
      result := Trim(line[FieldNo]);
      if Pos('"', result) = 1 then result := Copy(result,2,Length(result));
      if Pos('"', result) = Length(result) then result := Copy(result,1,Length(result)-1);
      if Pos('''', result) = 1 then result := Copy(result,2,Length(result));
      if Pos('''', result) = Length(result) then result := Copy(result,1,Length(result)-1);
    end;
  end;

begin
  inherited;
  Buff:= Clipboard.asText;
  if Buff = '' then Exit;

  if abs(PQABatch.TotalAllocated) >= abs(PQA.UOMQty) then begin
    CommonLib.MessageDlgXP_Vista('The line quantity is already fully allocated to batches.' , mtInformation , [mbOK], 0);
    exit;
  end;
  BatchNoField := -1;
  ExpiryDateField := -1;
  QtyField := -1;
  BOQtyField:= -1;
  TruckLoadnoField := -1;

  lines := SplitString(Buff, #$D#$A);
  for x := Low(lines) to High(lines) do begin
    if Trim(lines[x]) = '' then
      continue;
    line := SplitString(lines[x], #9);
    if x = 0 then begin
      { captions .. }
      for y := Low(line) to High(line) do begin
        if SameText(LineField(y), 'Batch Number') then BatchNoField := y
        else if SameText(LineField(y), 'Batch No') then BatchNoField := y
        else if SameText(LineField(y), 'Expiry Date') then ExpiryDateField := y
        else if SameText(LineField(y), qbatchtruckloadno.displaylabel) then TruckLoadnoField := y
        else if SameText(LineField(y), 'Qty') then QtyField := y
        else if SameText(LineField(y), 'Quantity') then QtyField := y
        else if SameText(LineField(y), 'BO Qty') then BOQtyField := y
        else if SameText(LineField(y), 'BO Quantity') then BOQtyField := y;
      end;
      if BatchNoField < 0 then begin
        CommonLib.MessageDlgXP_Vista(Quotedstr(qbatchtruckloadno.displaylabel) +' column is missing from the data you are pasting' , mtInformation , [mbOK], 0);
        exit;
      end;
      if qbatchtruckloadno.visible and   (TruckLoadnoField <0) then begin
        CommonLib.MessageDlgXP_Vista('"Expiry Date" column is missing from the data you are pasting' , mtInformation , [mbOK], 0);
        exit;
      end;
      if ExpiryDateField < 0 then begin
        CommonLib.MessageDlgXP_Vista('"Expiry Date" column is missing from the data you are pasting' , mtInformation , [mbOK], 0);
        exit;
      end;
      if QtyField < 0 then begin
        CommonLib.MessageDlgXP_Vista('"Qty" column is missing from the data you are pasting' , mtInformation , [mbOK], 0);
        exit;
      end;
    end
    else begin
      { data ... }
      UOMQty := StrToFloatDef(LineField(QtyField),0);
      BOUOMQty := StrToFloatDef(LineField(BOQtyField),0);
      PQABatch.New;
      PQABatch.Batchno := LineField(BatchNoField);
      if TruckLoadnoField >=0 then
        PQABatch.truckLoadno := LineField(TruckLoadnoField);
      if LineField(ExpiryDateField) <> '' then begin
        try
          PQABatch.ExpiryDate := StrToDate(LineField(ExpiryDateField));
        except
          on e: exception do begin
            CommonLib.MessageDlgXP_Vista('The format of the Expiry Date (' + LineField(ExpiryDateField) + ') is not valid for Batch No ' + line[BatchNoField], mtWarning , [mbOK], 0);
            PQABatch.Cancel;
            exit;
          end;
        end;
      end;
      PQABatch.UOMQty := UOMQty;
      PQABatch.BOUOMQty := BOUOMQty;
      PQABatch.PostDb;
      UpdateBatchTotals;
    end;
  end;
(*
  sl:= TStringList.create;
  try
//    Buff:='"'+ StringReplace(StringReplace(Stripquotes(Buff), #$D#$A ,'","',[rfReplaceAll]), #9 , ',' , [rfReplaceAll])+'"';
//    Buff:= StringReplace(Buff, #9 , ',' , [rfReplaceAll]);
//    sl.Commatext := Buff;
    sl.Text := Buff;


  finally
    sl.Free;
  end;
*)
end;

procedure TfmAllocation.ImportSNFromClipBoard;
var
  Buff: string;
  lines, line: TStringDynArray;
  x,y: integer;
  SNField, QtyField, BOQtyField: integer;
  UOMQty: double;
  BOUOMQty: double;

  function LineField(FieldNo: integer): string;
  begin
    result := '';
    if FieldNo <= High(line) then begin
      result := Trim(line[FieldNo]);
      if Pos('"', result) = 1 then result := Copy(result,2,Length(result));
      if Pos('"', result) = Length(result) then result := Copy(result,1,Length(result)-1);
      if Pos('''', result) = 1 then result := Copy(result,2,Length(result));
      if Pos('''', result) = Length(result) then result := Copy(result,1,Length(result)-1);
    end;
  end;

begin
  inherited;
  Buff:= Clipboard.asText;
  if Buff = '' then Exit;

//  if abs(PQABatch.TotalAllocated) >= abs(PQA.UOMQty) then begin
//    CommonLib.MessageDlgXP_Vista('The line quantity is already fully allocated to batches.' , mtInformation , [mbOK], 0);
//    exit;
//  end;
  SNField := -1;
//  QtyField := -1;
//  BOQtyField:= -1;

  lines := SplitString(Buff, #$D#$A);
  for x := Low(lines) to High(lines) do begin
    if Trim(lines[x]) = '' then
      continue;
    if Pos(#9,lines[x]) > 0 then
      line := SplitString(lines[x], #9)
    else begin
      SetLength(line,1);
      line[0] := lines[x];
    end;
    if x = 0 then begin
      { captions .. }
      for y := Low(line) to High(line) do begin
        if SameText(LineField(y), 'Serial Number') then SNField := y;
//        else if SameText(LineField(y), 'Qty') then QtyField := y
//        else if SameText(LineField(y), 'Quantity') then QtyField := y
//        else if SameText(LineField(y), 'BO Qty') then BOQtyField := y
//        else if SameText(LineField(y), 'BO Quantity') then BOQtyField := y;
      end;
      if SNField < 0 then begin
        CommonLib.MessageDlgXP_Vista('"Serial Number" column is missing from the data you are pasting' , mtInformation , [mbOK], 0);
        exit;
      end;
    end
    else begin
      { data ... }
//      UOMQty := StrToFloatDef(LineField(QtyField),0);
//      BOUOMQty := StrToFloatDef(LineField(BOQtyField),0);
      PQASN.New;
      PQASN.SerialNumber := LineField(SNField);
//      PQASN.UOMQty := UOMQty;
//      PQASN.BOUOMQty := BOUOMQty;
      PQASN.PostDb;
    end;
  end;
end;

procedure TfmAllocation.gbinsColExit(Sender: TObject);
begin
  inherited;
  lblExtra.Visible := false;
end;

procedure TfmAllocation.gbinsExit(Sender: TObject);
begin
    inherited;
    PQABins.PostDB;
end;

procedure TfmAllocation.gbatchExit(Sender: TObject);
begin
    inherited;
    PQABatch.PostDB;
end;
Function TfmAllocation.AutoAlloc(const PQADetails :TPQADetails; const PQAtype :String; const ReqQty, ReqUOMQty :Double;
                                const ParentValue:String=''; const ParentExpiryDaye :TDatetime=0 ;const ParentPQAType:String=''):Boolean;
begin
  result := DoAutoAlloc(PQA, PQADetails ,PQAtype ,ReqQty, ReqUOMQty ,ParentValue,ParentExpiryDaye ,ParentPQAType);
end;
(*Function TfmAllocation.AutoAlloc(const PQADetails :TPQADetails; const PQAtype :String; const ReqQty, ReqUOMQty :Double;
                                const ParentValue:String=''; const ParentExpiryDaye :TDatetime=0 ;const ParentPQAType:String=''):Boolean;
var
    s:STring;
    ds :TDataset;
    QtyToAllocate :Double;
    UOMQtyToAllocate :Double;
    Function getParetRefs:String;
    begin
        Result:= '';
        if ParentValue = '' then Exit;
        s := 'Select Globalref from tblPQADetails ' +
            ' where Value = ' + quotedStr(ParentValue) +
            ' and ifnull(ExpiryDate, ' + quotedStr(FormatDateTime(MysqlDateFormat , ParentExpiryDaye)) +') = ' + quotedStr(FormatDateTime(MysqlDateFormat , ParentExpiryDaye))+
            ' and PQAType = ' + quotedStr(ParentPQAType);
        with PQA.getnewdataset(s, true) do try
            s:= '';
            if recordcount = 0 then exit;
            first;
            s := '';
            while Eof = false do begin
                if s <> '' then s := s +',';
                s:= s+QuotedStr(fieldbyname('Globalref').asString);
                next;
            end;
        finally
            if active then close;
            free;
        end;
        Result := s;
    end;
begin
    Result          := true;
    if PQA.Product.SnTracking then result := False;
    QtyToAllocate   := ReqQty;
    UOMQtyToAllocate:= ReqUOMQty;
    try
        if PQADetails.count > 0 then begin
            PQADetails.dataset.first;
            while PQADetails.Dataset.eof = False do begin
                QtyToAllocate := QtyToAllocate - PQADetails.Qty;
                UOMQtyToAllocate := UOMQtyToAllocate - PQADetails.UOMQty;
                PQADetails.Dataset.Next;
            end;
        end;

        if QtyToAllocate <= 0 then Exit; // nothing to allocate

        s := getParetRefs;
        if s <> '' then s := ' and Details.ParentRef in (' + s +')';

        s:= ' SELECT Details.Value,Details.ExpiryDate,PQA.UOM,PQA.UOMMultiplier,'+
            ' Sum(if(ifnull(PQA.Alloctype,"")="OUT",0-Details.Qty,Details.Qty) ) as Qty,'+
            ' Sum(if(ifnull(PQA.Alloctype,"")="OUT",0-Details.UOMQty,Details.UOMQty) ) as UOMQty,'+
            ' Sum(if(ifnull(PQA.Alloctype,"")="OUT",0-Details.CUSTFLD1,Details.CUSTFLD1) ) as CUSTFLD1Qty'+
            ' FROM tblpqadetails AS Details Inner Join tblpqa AS PQA ON Details.PQAID = PQA.PQAID'+
            ' WHERE Details.PQAType =  ' + QuotedStr(PQAType) +
            ' AND PQA.Active <>  "F" AND PQA.IsBO <>  "T"' + s;

        s := s + ' AND PQA.ProductID = ' + IntToStr(PQA.ProductID);
        s := s + ' AND ifnull(PQA.DepartmentID,0) = ' + IntToStr(PQA.DepartmentID);
        s := s + ' AND (Date(ifnull(PQA.TransDate,0)) <= ' + QuotedStr(FormatDateTime(MysqlDateFormat , PQA.TransDate)) +
                ' OR ifnull(PQA.Alloctype,"")="OUT")';
        if AppEnv.CompanyPrefs.MatchUOMinallocation then
            s := s + ' AND PQA.UOMID = ' + IntToStr(PQA.UnitOfMeasureID);

        s := s + ' group by Details.Value,Details.ExpiryDate,PQA.UOM,PQA.UOMMultiplier ';
        ds := PQA.GetNewDataset(s , true);
        try
            if ds.recordcount = 0 then begin
                exit;
            end;
            ds.first;
            while (ds.Eof = False) and (QtyToAllocate <> 0)   do begin
                if (ds.fieldByname('Qty').asfloat>0) then begin
                    PQADetails.New;
                    PQADetails.PQAValue :=ds.FieldByname('Value').asString;
                    if ds.fieldbyname('Expirydate').asdatetime <> 0 then
                        PQADetails.ExpiryDate :=ds.FieldByname('ExpiryDate').asDatetime;
                    if ds.fieldByname('Qty').asfloat <= QtyToAllocate then
                        PQADetails.Qty := ds.FieldByname('Qty').asFloat
                    else PQADetails.Qty :=QtyToAllocate;
                    PQADetails.CUSTFLD1 := ds.FieldByname('CUSTFLD1Qty').asFloat;
                    PQADetails.Dirty := true;
                    PQADetails.PostDB;
                    if PQAtype = TPQABatch.PQADetailtype then
                        if PQA.Product.multipleBins then
                            if PQA.Product.Autoallocbin then
                                AutoAlloc(TPQABatch(PQADetails).PQABins,TPQABatch(PQADetails).PQABins.PQADetailtype ,  TPQABatch(PQADetails).Qty,  TPQABatch(PQADetails).UOMQty  , TPQABatch(PQADetails).batchno, TPQABatch(PQADetails).ExpiryDate , TPQABatch(PQADetails).PQADetailtype);
                    QtyToAllocate := QtyToAllocate -PQADetails.Qty;
                end;
                ds.Next;
            end;
        finally
            if ds.Active then ds.close;
            Freeandnil(ds);
        end;
    Finally
        result := QtyToAllocate <=0;
    end;
end;*)
procedure TfmAllocation.OnComboNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
begin
    fLastcombo := twwDbLookupcombo(Sender);
    inherited;
end;
procedure TfmAllocation.RefreshbinDet;
begin
    if lbins.Active then lbins.Close;
    lbins.open;
    if lbins.Locate('BinID' ,TfmbinLocation(GetComponentByClassName('TfmbinLocation',TRue, Self)).KeyID , []) then begin
        if not (qbins.State  in [dsEdit,dsInsert]) then qbins.Edit;
        qbins.FieldByName('binlocation').AsString := lbins.FieldByName('Binlocation').AsSTring;
        qbins.FieldByName('Binnumber').AsString := lbins.FieldByName('Binnumber').AsSTring;
        cbobinLocationCloseUp(fLastcombo ,lbins , qbins, True);
    end;
end;
procedure TfmAllocation.cbobinLocationNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
begin
    inherited;
    with TfmbinLocation(GetComponentByClassName('TfmbinLocation',TRue, Self)) do begin
        AttachObserver(Self);
        Keyid := 0;
        Formcolor := Self.Color;
        if PQA.DepartmentID <> 0 then
            ClassId             := PQA.DepartmentID else classID := AppEnv.DefaultClass.ClassID;
        edtBinLocation.Text := cbobinLocation.Text;
        edtBinnumber.Text   := cbobinnumber.Text;
        Refreshdet := RefreshbinDet;
        ShowModal;
        if LookupTable.Locate('binId' , KeyId , []) then begin
          fdallocated :=0;
          fdTotal     :=0;
                    (*PQAbins.Iteraterecords(REadtotalQty);
                    if PQA.Product.Batch then fdTotal := PQABatch.uomQty else fdTotal := PQA.UOMQty;
                    fdTotal := fdTotal - fdallocated;*)
                    {binny- this is done for stock transfer - the allocation is copied from one department to the other,
                    if the bin doesn't exists in the second department, bin will be left blank and the allocation is copied across,
                    this is to avoid re-typing the Serial numbers}
                    if PQABins.UOMQTY =0 then begin
                      PQAbins.Iteraterecords(REadtotalQty);
                      fdTotal := fdTotal - fdallocated;
                      if PQA.Product.Batch then fdTotal := PQABatch.uomQty else fdTotal := PQA.UOMQty;
                    end else begin
                      fdTotal := PQABins.UOMQTY;
                      if (PQA.Product.Batch) and (fdTotal > PQABatch.uomQty) then  fdTotal := PQABatch.uomQty
                      else if not(PQA.Product.Batch) and (fdTotal > PQA.uomQty) then fdTotal := PQA.UOMQty;
                    end;

          PQABins.BinID := KeyId;
          PQABins.UOMQTY :=fdTotal;
          PQABins.PostDB;
        end;
    end;
end;
Function TfmAllocation.NextNo(Value:String; var PrefixofNo:String; Var No:String; var errMsg:String):Boolean;
var
    i:Integer;
begin
    REsult := False;
    PrefixofNo := '';
    No:= '';
    Value := Trim(Value);
    i := char_length(Trim(Value));
    while i >= 1 do begin
        if (Copy(Value, i, 1) >= '0') and (Copy(Value, i, 1) <= '9') then
            PrefixofNo:= Copy(Value, i, 1) + PrefixofNo
        else i := 0;
        i := i - 1;
    end;
    if PrefixofNo <> '' then begin
        try
          //No := FastFuncs.StrToInt(PrefixofNo)+1;
          No := incStr(PrefixofNo);
          Result := True;
        except
          on E:EConvertError do begin
            errMsg :=e.message;
            PrefixofNo := '';
            Exit;
          end;
        end;
        PrefixofNo:= Copy(Value, 1,FastFuncs.PosEx(PrefixofNo, Value) - 1);
      end;
end;
procedure TfmAllocation.btnFillClick(Sender: TObject);
var
  errMsg, s1,s2:String;
  srnos:Integer;
  ctr, ReqQty :Integer;
  Flag:Boolean;
begin
  DisableForm;
  try
    ProcessingCursor(True);
    try
        PQASN.PostDB;
        if PQASN.count = 0 then exit;
        qsn.first;
        if PQASN.Serialnumber = '' then Exit;
        s1:= PQASN.Serialnumber;

        srnos := PQASN.count;
        if isbin then ReqQty:= trunc(DecimalRounding.DecimalRoundDbl(PQAbins.UOMQTY, 2, drRndUp))
        else if isbatch then ReqQty:= trunc(DecimalRounding.DecimalRoundDbl(PQABatch.UOMQTY, 2, drRndUp))
        else ReqQty:= trunc(DecimalRounding.DecimalRoundDbl(PQA.UOMQTY, 2, drRndUp));
        DoShowProgressbar(ReqQty, WAITMSG);
        try
            for ctr := srnos+1 to ReqQty do begin
              flag := true;
              While Flag = true do begin
                s2:= incStr(s1);
                if (s2='') or (sametext(s2,s1)) then break;
                   Flag := qSn.Locate('value' , s2 , []);
                   if not(Flag) then Flag := not(TPQASN.ValidateSN(s2, 0, PQA.ProductID,PQA.DEpartmentId,  TERPconnection(PQA.Connection.Connection), PQA.InTrans, errMsg));
                   if Flag then s1:= s2;
              end;
              PQASN.New;
              PQASN.SerialNumber := s2;
              PQASN.PostDB;
              s1:= s2;
              DoStepProgressbar('Serial Number :' + quotedstr(s2));
            end;
        finally
          DoHideProgressbar;
        end;
    finally
      ProcessingCursor(False);
    end;
  finally
    Enableform;
  end;


(*var
    ReqQty :Integer;
    srnos  :Integer;
    csrno:String;
    srno:STring;
    isrno:String;
    flag :Boolean;
    ctr:Integer;
    ErrMsg:String ;
begin
  DisableForm;
  try
  {TODO PQA:display hrglass cursor while generating the Serialnos}
   PQASN.PostDB;
    if PQASN.count = 0 then exit;
    qsn.first;
    if PQASN.Serialnumber = '' then Exit;
    if not NextNo(PQASn.Serialnumber, csrno, isrno, errmsg) then begin
      CommonLib.MessageDlgXP_Vista('Auto Fill faield as next number cannot be generated from '+ PQASn.Serialnumber+'.' +chr(13) + chr(13) + errmsg, mtInformation, [mbok], 0);
      Exit;
    end;
    if isrno = '' then exit;

    srnos := PQASN.count;
    if isbin then ReqQty:= trunc(DecimalRounding.DecimalRoundDbl(PQAbins.UOMQTY, 2, drRndUp))
    else if isbatch then ReqQty:= trunc(DecimalRounding.DecimalRoundDbl(PQABatch.UOMQTY, 2, drRndUp))
    else ReqQty:= trunc(DecimalRounding.DecimalRoundDbl(PQA.UOMQTY, 2, drRndUp));
    for ctr := srnos+1 to ReqQty do begin
      flag := true;
      While Flag = true do begin
           srno := csrno + Trim(IntToStr(isrno;
           Flag := qSn.Locate('value' , srno , []);
           if not(Flag) then Flag := not(TPQASN.ValidateSN(srno, 0, PQA.ProductID,PQA.DEpartmentId,  TERPconnection(PQA.Connection.Connection), PQA.InTrans, errMsg));
           isrno := incStr(isrno);
      end;
      PQASN.New;
      PQASN.SerialNumber := srno;
      PQASN.PostDB;
    end;
  finally
    EnableForm;
  end;*)
end;

procedure TfmAllocation.btnPrintClick(Sender: TObject);
var
  strSQL:String;
begin
  inherited;
  if assigned(PQABatch) then PQABatch.PostDB;
  if assigned(PQAbins) then PQAbins.PostDB;
  if assigned(PQASn) then PQASn.PostDB;

  strSQL :=  companyInfoSQL('CompanyInfo') +
            NL+'~|||~{Details}Select  PQA.ProductName,  concat(PQA.uom , "(" , PQA.uommultiplier, ")") as UOM, ' +
            '  PQABatch.uomQty batchQty, PQAbins.uomQty binQty, PQASN.uomQty SNQty, ' +
            '  PQA.transId, PQA.TranslineId, PQA.transtype, pqa.transdate , ' +
            '  PQABatch.Value as Batchno, PQABatch.ExpiryDate, PQABatch.TruckLoadNo ,   ' +
            '  PBin.binLocation , PBin.BinNumber, ' +
            '  PQASN.value as Serialnumber , ' +
            '  P.PREFEREDSUPP as supplier ' +
            '  From '+            SAAllocationTables +
            ' where PQA.transID = '+ inttostr (PQA.TransID)+' and  PQA.transLineID = '+ inttostr (PQA.TransLineID)+ ' and  PQA.transtype = '+ Quotedstr (PQA.TransType)+
            ' order by PQA.PQAId , PQABatch.PQADetailId, PQAbins.PQAdetailID, PQASN.PQAdetailID';
  PrintTemplate.ReportSQLSupplied:= True;
  PrintTemplate.PrintTemplateReport(TemplateReportName[chkChooseRpt.Checked, ''], StrSQL, not AppEnv.Employee.ShowPreview and not devmode, 1, PQA.Dataset.Connection)
end;

procedure TfmAllocation.qbatchBeforePost(DataSet: TDataSet);
begin
  inherited;
    if PQABatch.batchno = '' then begin
        PQABatch.Delete;
        abort;
    end;
end;

procedure TfmAllocation.qbatchBOUOMQtyChange(Sender: TField);
begin
  inherited;
  UpdateBatchTotals;
end;

procedure TfmAllocation.qbatchCUSTFLD1Change(Sender: TField);
begin
  inherited;
  UpdateBatchTotals;
end;

procedure TfmAllocation.qbatchUOMQtyChange(Sender: TField);
begin
  inherited;
  UpdateBatchTotals;
end;

procedure TfmAllocation.qbinsBeforePost(DataSet: TDataSet);
begin
  inherited;
  if PQABins.BinID = 0 then begin
    PQABins.delete;
    abort;
  end;
end;

procedure TfmAllocation.qsnBeforePost(DataSet: TDataSet);
begin
  inherited;
    if PQASN.SerialNumber = '' then begin
        PQASN.Delete;
        abort;
    end;
end;
procedure TfmAllocation.btnSnofBatchBeforeExpand(Sender: TObject);
begin
    inherited;
    PQABatch.postdb;
    if PQABatch.Batchno = '' then begin
        gbatch.SetActiveField('Value');
        abort;
    end;
    try
      if assigned(fPQASN) then begin
        fPQASN.closeDB;
        if fPQASN.Owner = self then
          Freeandnil(fPQASN);
      end;
    Except
      //ignore the exception
    end;
    PQASN := PQABatch.PQASN;
    gsn.Width := gbatch.width-9;
    //Applyfilter(PQASN.Dataset , PQABatch.Globalref);
    //PQASN.Dataset.Refresh;
end;

procedure TfmAllocation.btnbinsofBatchBeforeExpand(Sender: TObject);
begin
  inherited;
  PQABatch.postdb;
  if PQABatch.Batchno = '' then begin
    gbatch.SetActiveField('Value');
    abort;
  end;
  try
    if assigned(fPQABins) then begin
      fPQABins.closeDB;
      if fPQABins.Owner = self then
        Freeandnil(fPQABins);
    end;
  except
    //ignore if there is an exception
  end;
  PQABins := PQABatch.PQABins;
  gbins.Width := gbatch.width-9;
  //Applyfilter(PQABins.Dataset , PQABatch.Globalref);
  //PQABins.Dataset.Refresh;

end;
procedure TfmAllocation.btnSnofbinBeforeExpand(Sender: TObject);
begin
    inherited;
    PQAbins.postdb;
    if PQAbins.BinLocation = '' then begin
        gbins.SetActiveField('Value');
        abort;
    end;
    try
      if assigned(fPQASN) then begin
        fPQASN.closeDB;
        if fPQASN.Owner = self then
          Freeandnil(fPQASN);
      end;
    Except
      //ignore the exception
    end;
    PQASN := PQAbins.PQASn;
    gsn.Width := gbins.width-9;
    //Applyfilter(PQASN.Dataset , PQAbins.Globalref);
    //PQASN.Dataset.Refresh;
end;
procedure TfmAllocation.gbatchKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if devmode then begin
    if key = #13   then  begin
      Key := #0;
        if (Sender = gBatch) and (isbin) and (PQABatch.UOMQTY<> 0) then begin
            gbatch.SetActiveField('cbinsofBatch');
            btnBinsofBatch.Expanded := True;
            if PQABins.count  = 0 then PQAbins.new;
        end else if (Sender   = gBatch) and (issn) and (PQABatch.UOMQTY <> 0) then begin
            gbatch.SetActiveField('cSnsofBatch');
            btnSnofBatch.Expanded   := true;
            if PQASN.count    = 0 then PQASn.new;
        end else  if (Sender  = gbins) and (issn)   and (PQAbins.UOMQty<>0) then begin
            gbins.SetActiveField('cSnsofBin');
            btnSnofbin.Expanded     := True;
            if PQASn.count = 0 then PQASN.new;
        end;
    end;
  end;
end;

procedure TfmAllocation.btnSnofBatchAfterExpand(Sender: TObject);
begin
  inherited;
  gsn.SetActiveField('Value');
  if pqasn.Count=0 then pqasn.New;
  openAllocExt;
end;

procedure TfmAllocation.btnbinsofBatchAfterExpand(Sender: TObject);
begin
  inherited;
  gbins.SetActiveField('Binlocation');
  if pqabins.Count=0 then pqabins.New;
  OpenAllocExt;
end;
Class Procedure TfmAllocation.ShowProductDetails(const value :Boolean);
begin
    if Value then AppContext[Self.Classname].VarByname['ShowProductDetails'] := 'T'
    else AppContext[Self.Classname].VarByname['ShowProductDetails'] := 'F';
end;
procedure TfmAllocation.UpdateBatchTotals;
begin
//  DoDelayObjectProcedure(DoUpdateBatchTotals,100, Self.classname +'.DoUpdateBatchTotals');
  DoUpdateBatchTotals;
end;

procedure TfmAllocation.DoUpdateBatchTotals;
begin
  PostDb(PQABatch.Dataset);
  PQABatch.RefreshTotals;
  gbatch.ColumnByName('UOMQty').FooterValue := FloatToStrF(PQABatch.TotalUOMQty, ffFixed, 15, 1);
  gbatch.ColumnByName('BOUOMQty').FooterValue := FloatToStrF(PQABatch.TotalBOUOMQty, ffFixed, 15, 1);
  gbatch.ColumnByName('CUSTFLD1').FooterValue := FloatToStrF(PQABatch.TotalCUSTFLD1Qty, ffFixed, 15, 1);
end;

procedure TfmAllocation.WriteGuiPref;
var
  ctr:Integer;
begin
  GuiPrefs.Node['Options.formWidth'].asInteger:= Self.Width;
  GuiPrefs.Node['Options.formHeight'].asInteger:= Self.Height;
  for ctr := 0 to Qbatch.FieldCount-1 do
    if  (Qbatch.fields[ctr].visible) then
      GuiPrefs.Node['Options.Batch.'+Qbatch.fields[ctr].fieldname].asInteger := Qbatch.fields[ctr].displaywidth ;
  for ctr := 0 to QBins.FieldCount-1 do
    if (QBins.fields[ctr].visible) then
      GuiPrefs.Node['Options.Bins.'+QBins.fields[ctr].fieldname].asInteger:= QBins.fields[ctr].displaywidth;
  for ctr := 0 to QSn.FieldCount-1 do
    if (QSn.fields[ctr].visible) then
      GuiPrefs.Node['Options.SN.'+QSn.fields[ctr].fieldname].asInteger:= QSn.fields[ctr].displaywidth;
end;


Class Function TfmAllocation.ShowProductDetails:Boolean;
begin
    Result := False;
    if AppContext.ContextExists(Self.Classname) then
        if AppContext[Self.Classname].VarExists('ShowProductDetails') then
            if AppContext[Self.Classname].VarExists('ShowProductDetails') then
                Result := AppContext[Self.Classname].VarByname['ShowProductDetails'] = 'T';
end;

procedure TfmAllocation.SetGridproperties(CurGrid: TwwDbGrid);
    Procedure SetHeight(ParentGrid: TwwDbGrid);
    var
        x:Integer;
    begin
        x:=ParentGrid.height - 75;
        if CurGrid.top + x > (ParentGrid.top+ParentGrid.height-10) then
            x :=  (ParentGrid.top+ParentGrid.height) - (CurGrid.top +50);
        CurGrid.height := x;
    end;
begin
    if curGrid = gbins then
        if isbatch then SetHeight(gbatch );
    if curGrid = gsn then
        if isbin then SetHeight(gbins )
        else if isbatch then SetHeight(gbatch );
end;


procedure TfmAllocation.CreateAllocObjects;
begin
  PQABatch:= TPQABatch.create(self);
  PQABins := TPQABins.create(self);
  PQASN   := TPQASN.create(self);
  PQABatch.PQA := fPQA;
  PQABins.PQA := fPQA;
  PQASN.PQA := fPQA;
  PQABatch.SQL:=  'Select * from tblPQADetails where PQAType = '+QuotedStr(TPQABatch.pqadetailtype) +  ' and  PQAID = ' + IntToStr(PQA.ID);
  PQABins.SQL :=  'Select * from tblPQADetails where PQAType = '+QuotedStr(TPQABins.pqadetailtype)  +  ' and  PQAID = ' + IntToStr(PQA.ID);
  PQASN.SQL   :=  'Select * from tblPQADetails where PQAType = '+QuotedStr(TPQASn.pqadetailtype)    +  ' and  PQAID = ' + IntToStr(PQA.ID);
  (*PQABatch.GUIPQA := getPQAforDEtails;
  PQABins.GUIPQA := getPQAforDEtails;
  PQASN.GUIPQA := getPQAforDEtails;*)
end;


procedure TfmAllocation.LoadAllocObjects;
begin
  if isbatch  then pqabatch.Load
  else if isbin    then pqabins.Load
  else if issn     then pqasn.load;

  if PQA.PQAbatch.Dirty then PQABatch.Dirty := True;
  if PQA.PQABins.Dirty  then PQABins.Dirty  := True;
  if PQA.PQASN.Dirty   then PQASN.Dirty    := True;
end;

class procedure TfmAllocation.getAllocationform(Sender: TBaseForm;var form: TfmAllocation);
begin
    form := TfmAllocation(GetComponentByClassType(TfmAllocation , False , Sender));
    if Assigned(form) then
      if Assigned(Sender) and (Sender.AccessLevel >= 5) then
        form.AccessLevel :=  Sender.AccessLevel
      else form.AccessLevel :=  1;
end;


function TfmAllocation.getPQAforDEtails: TPQA;
begin
  REsult := fPQA;
end;

function TfmAllocation.GetReportTypeID: integer;
begin
  REsult := 151;
end;

Procedure TFmAllocation.beforeShowbiblist(Sender:TObject);
begin
  if not(SEnder is TBinLocationListGUI) then exit;
  TBinLocationListGUI(Sender).SelectionOption := soNone;
  TBinLocationListGUI(Sender).FilterString :='classId = ' + inttostr(PQABins.DepartmentId);
  TBinLocationListGUI(Sender).ChangeNote('Please Double Click on the Bin Location Record to select or ''Close'' to Cancel which will create a new Bin Location for ' + Quotedstr(getClassname(PQABins.DepartmentId)) +' ' + AppEnv.DefaultClass.ClassHeading+'.',clred,12);
end;
Procedure TFmAllocation.OnBinselect(Sender:TwwDBGrid);
begin
  closedb(lbins);
  opendb(lbins);
  PQABins.BinID :=TProductBin.IDToggle(PQABins.DepartmentId, Sender.Datasource.dataset.FieldByname('binlocation').asString, Sender.Datasource.dataset.FieldByname('Binnumber').asString, PQABins.Connection.connection);
end;
procedure TfmAllocation.KeyUpEvent(Sender: TObject; var Key: Word;  Shift: TShiftState);
var
  form : TfmAllocationExt;
  i,xid:Integer;
  function SelectionDeptID:Integer;
  begin
    Result :=0;
    if form.qrymain.findfield('departmentID')<> nil then
      Result := form.qrymain.fieldbyname('departmentID').asInteger;
  end;
  function AddPQADetailClass(PQADetail :TPQADetails):Boolean;
  begin
    REsult := False;
    if form.qrymain.findfield('departmentID')<> nil then begin
      if form.qrymain.fieldbyname('departmentID').asInteger <>PQADetail.DepartmentID then begin
        if PQADetail.PQADetailsClass.count =0 then PQADetail.PQADetailsClass.New;
        PQADetail.PQADetailsClass.ClassId:=form.qrymain.fieldbyname('departmentID').asInteger;
        PQADetail.PQADetailsClass.UOMID := PQADetail.PQA.UnitOfMeasureID;
        PQADetail.PQADetailsClass.UOMQty :=PQADetail.UOMQTY;
        PQADetail.PQADetailsClass.Qty :=PQADetail.Qty;
        PQADetail.PQADetailsClass.Active := TRue;
        Result := TRue;
      end else begin
        (* if PQADetail.PQADetailsClass.count =0 then PQADetail.PQADetailsClass.Active:= False; *)
      end;
    end else begin
        (* if PQADetail.PQADetailsClass.count =0 then PQADetail.PQADetailsClass.Active:= False; *)
    end;
    PQADetail.PQADetailsClass.PostDB;
  end;

  function ClassID:Integer;
  begin
     Result := PQA.DepartmentID; ;
     if not(Sender is TwwDBGrid) then exit;
     if Sender = gbatch then exit;

     if Sender = gsn then
      if gbins.visible then begin
        if PQABins.PQADetailsClass.count> 0 then
          Result := PQABins.PQADetailsClass.ClassID;
        Exit;
      end;
     if (Sender = gbins) or (Sender = gsn ) then
      if gbatch.visible then begin
        if PQABatch.PQADetailsClass.count> 0 then
          Result := PQABatch.PQADetailsClass.ClassID;
        Exit;
      end;
  end;
  function BatchExists :Boolean;
  begin
    REsult := False;
    if PQABatch.count =0 then exit;
    PQABatch.First;
    While PQABatch.Eof = False do begin
      if (PQABatch.Batchno =   form.qrymain.fieldbyname('Batchno').Value) and
         (PQABatch.ExpiryDate =form.qrymain.fieldbyname('ExpiryDate').Value) and
         ((PQABatch.PQADetailsClass.count =0) or (PQABatch.PQADetailsClass.ClassId = form.qrymain.fieldbyname('ClassID').asInteger)) then begin
          Result:= True;
          Exit;
         end;
      PQABatch.Next;
    end;
  end;

  function binExists :Boolean;
  begin
    REsult := False;
    if PQABins.count =0 then exit;
    PQABins.First;
    While PQABins.Eof = False do begin
      if (PQABins.binID =   form.qrymain.fieldbyname('binid').asInteger) and
         ((PQABins.PQADetailsClass.count =0) or (PQABins.PQADetailsClass.ClassId = form.qrymain.fieldbyname('ClassID').asInteger)) then begin
          Result:= True;
          Exit;
         end;
      PQABins.Next;
    end;
  end;
  Procedure CreateBin4Class;
  var
    fsLoc, fsno:String;
    ans :Integer;
  begin
    Ans := MessageDlgXP_Vista('Bin Location - ' + quotedstr( form.qrymain.fieldbyname('binlocation').asString +' ' + form.qrymain.fieldbyname('binnumber').asString) + ' doesn''t exists for the '+ AppEnv.DefaultClass.ClassHeading +' ' + quotedstr(getclassname(PQABins.DepartmentId)) +'. '+
      ' Do you wish to select another Bin from the Bin Location List of ' + Quotedstr(getclassname(PQABins.DepartmentId)) +' or Create a new Bin Location for  ' +quotedstr(getclassname(PQABins.DepartmentId)) +'? ', mtconfirmation ,[], 0 , nil, '','',False, nil, 'Select From List,Create New Bin for '+quotedstr(getclassname(PQABins.DepartmentId))+'?');
    if Ans = 100 then begin
      PQABins.BinID :=0;
      OpenERPListFormSingleselectModal('TBinLocationListGUI' , onBinselect , beforeShowbiblist);
      if PQABins.BinID <> 0 then exit;
    end;
    fsLoc :=form.qrymain.fieldbyname('binlocation').asString ;
    fsNo  :=form.qrymain.fieldbyname('binnumber').asString;
    //Createbin(PQABins.DepartmentId ,fsLoc,fsno );
    CreateBin(PQABins.DepartmentId ,form.qrymain.fieldbyname('binId').AsInteger);
    closedb(lbins);
    opendb(lbins);
    PQABins.BinID :=TProductBin.IDToggle(PQABins.DepartmentId, fsLoc, fsno, PQABins.Connection.connection);
  end;
begin
  inherited;
  if ProcessingKey then exit;
  ProcessingKey:= true;
  try
    if (Key = VK_F8) and (curGrid = gsn) and (not (PQA.inTrans)) then begin
      WindowState := wsnormal;
      if PQA.Product.Multiplebins then fdTotal := PQABins.uomQty
      else if PQA.Product.Batch then fdTotal := PQABatch.uomQty
      else fdTotal := PQA.UOMQty;
      fdallocated := PQASN.count;
      if fdtotal-fdallocated >0 then
        (*TfmSerialjobNumbers.SerialNoList(Self, SerialNoSelected);*)
        TfmAllocationSrjobnoExtender.SerialNoList(Self,  PQA.ProductID,  SerialNoSelected);

    end else if ((Shift = [ssctrl]) and ((Chr(Key)='L') or (Chr(Key)='l'))) OR (Key = VK_F9) then begin
        if PQA.Alloctype = 'IN' then  if PQA.qty >0 then  if TwwDBGrid(Sender) = gsn  then Exit;
        fdallocated :=0;
        fdTotal     :=0;
        if AutoSelect and (curGrid = gbins) and (PQABins.count =0) then begin
            PQAbins.Iteraterecords(REadtotalQty);
            if AddDefaultbin(PQAbins) then Exit;
        end;
        form := TfmAllocationExt(commonlib.getcomponentByclassName('TfmAllocationExt' , True, Self, False)) ;
        try
          form.MoveForms := MoveForms;
          Form.MyConnection := TERPConnection(PQA.connection.Connection );
          form.ProductID    := PQA.ProductID;
          form.ClassID      := (* PQA.DepartmentID; *)ClassID;
          form.UOM          := PQA.UnitOfMeasure;
          form.AllocType    := PQA.AllocType;
          if (Sender is TwwDBGrid) then begin
            if TwwDBGrid(Sender) = gbatch then begin
              form.IsSubObject := False;
              form.PQAType := tDEtails;
              if PQABatch.uomqty = 0 then PQABatch.cancelDB else PQABatch.PostDB;
              PQABatch.Iteraterecords(ReadtotalQty);
              fdTotal := PQA.UOMQty;
            end else if TwwDBGrid(Sender) = gbins then begin
              form.PQAType := tExtraDetails;
              form.IsSubObject :=gbatch.visible;
              if gbatch.visible then begin
                if PQABatch.PQADetailsClass.count=1 then begin
                  form.Batchno    := PQABatch.PQADetailsClass.Batchno;
                  form.ExpiryDate := PQABatch.PQADetailsClass.ExpiryDate;
                end else begin
                  form.Batchno    := PQABatch.Batchno;
                  form.ExpiryDate := PQABatch.ExpiryDate;
                end;
              end;
              if PQABins.UOMQty = 0 then PQABins.Canceldb else PQABins.PostDB;
              PQAbins.Iteraterecords(REadtotalQty);
              if PQA.Product.Batch then fdTotal := PQABatch.uomQty else fdTotal := PQA.UOMQty;
            end else if TwwDBGrid(Sender) = gsn then begin
              form.PQAType := tDetailswithSno;
              form.IsSubObject :=(gbatch.visible) or (gbins.visible);
              if gbatch.visible then begin
                if PQABatch.PQADetailsClass.count=1 then begin
                  form.Batchno    := PQABatch.PQADetailsClass.Batchno;
                  form.ExpiryDate := PQABatch.PQADetailsClass.ExpiryDate;
                end else begin
                  form.Batchno    := PQABatch.Batchno;
                  form.ExpiryDate := PQABatch.ExpiryDate;
                end;
              end;
              if gbins.visible then begin
                if PQABins.PQADetailsClass.count=1 then begin
                  form.BinLocation:= PQABins.PQADetailsClass.binlocation;
                  form.Binnumber  := PQABins.PQADetailsClass.binnumber;
                end else begin
                  form.BinLocation:= PQABins.binlocation;
                  form.Binnumber  := PQABins.binnumber;
                end;
              end;
              if PQASN.Serialnumber = '' then PQASN.Canceldb else PQASN.PostDB;
              PQASN.Iteraterecords(REadtotalQty);
              if PQA.Product.Multiplebins then fdTotal := PQABins.UOMQty
              else if PQA.Product.Batch then fdTotal := PQABatch.uomQty
              else fdTotal := PQA.UOMQty;
            end;

            form.Qty := fdtotal-fdallocated;
            Form.AutoSelect := AutoSelect;
            btnclose.enabled := False;
            btnFill.enabled  := False;
            btnDelete.enabled:= False;
            btncancel.enabled:= False;
            try
              if autoSelect = False then form.showmodal
              else Form.formshow(Form);
              autoSelect := False;
            finally
              btnclose.enabled := True;
              btnFill.enabled  := issn;
              btnDelete.enabled:= True;
              btncancel.enabled:= True;
            end;

            if form.Modalresult = mrOk then begin
              for i := 0 to form.grdMain.SelectedList.Count - 1 do begin
                form.qrymain.GotoBookmark(form.grdMain.SelectedList.Items[i]);
                if TwwDBGrid(Sender) = gbatch then begin
                  if not BatchExists then begin
                    PQABatch.New;
                    PQABatch.Batchno :=form.qrymain.fieldbyname('Batchno').asString;
                    PQABatch.TruckLoadNo :=form.qrymain.fieldbyname('TruckLoadNo').asString;
                    if form.qrymain.fieldbyname('ExpiryDate').asDateTime <> 0 then
                      PQABatch.ExpiryDate:=form.qrymain.fieldbyname('ExpiryDate').asDatetime;
                    PQABatch.CUSTFLD1 := form.qrymain.fieldbyname('CUSTFLD1').AsFloat;
                    PQABatch.CUSTFLD2 := form.qrymain.fieldbyname('CUSTFLD2').asInteger;
                    PQABatch.CUSTFLD3 := form.qrymain.fieldbyname('CUSTFLD3').asInteger;
                    PQABatch.CUSTFLD4 := form.qrymain.fieldbyname('CUSTFLD4').asInteger;
                    PQABatch.CUSTFLD5 := form.qrymain.fieldbyname('CUSTFLD5').asString;
                    PQABatch.CUSTFLD6 := form.qrymain.fieldbyname('CUSTFLD6').AsFloat;
                    PQABatch.CUSTFLD7 := form.qrymain.fieldbyname('CUSTFLD7').AsFloat;
                  end;
                  if fdtotal > fdallocated then begin
                    if (PQA.Alloctype = 'OUT') and (form.qrymain.fieldbyname('UOMQty').asFloat<=0) then begin
                          PQABatch.UOMQty := 0;
                    end else if (PQA.Alloctype = 'OUT') and (form.qrymain.fieldbyname('UOMQty').asFloat <= fdtotal-fdallocated)  then begin
                          PQABatch.UOMQty := PQABatch.UOMQty + form.qrymain.fieldbyname('UOMQty').asFloat;
                          fdallocated     := fdallocated +form.qrymain.fieldbyname('UOMQty').asFloat;
                    end else begin
                          PQABatch.UOMQty := PQABatch.UOMQty +(fdtotal-fdallocated);
                          fdallocated     := fdallocated +(fdtotal-fdallocated);
                    end;
                  end;
                  PQABatch.PostDB;
                  if AddPQADetailClass(PQABatch) then begin
                    PQABatch.PQADetailsClass.Batchno := PQABatch.batchno;
                    PQABatch.PQADetailsClass.ExpiryDate := PQABatch.ExpiryDate;
                    PQABatch.PQADetailsClass.PostDB;
                  end;
                end else if TwwDBGrid(Sender) = gbins then begin
                  if not (BinExists) then begin
                    PQABins.New;
                    if (SelectionDeptID<>0) and (PQABins.DepartmentId =SelectionDeptID) then
                      PQABins.BinID :=form.qrymain.fieldbyname('binid').asInteger
                    else begin
                      xid:=TProductBin.IDToggle(PQABins.DepartmentId , form.qrymain.fieldbyname('binlocation').asString, form.qrymain.fieldbyname('binnumber').asString, PQABins.Connection.connection);
                      PQABins.BinID :=xid;
                      if PQABins.BinID =0 then begin
                        (* Createbin(PQABins.DepartmentId ,form.qrymain.fieldbyname('binlocation').asString , form.qrymain.fieldbyname('binnumber').asString);
                        closedb(lbins);
                        opendb(lbins);
                        PQABins.BinID :=TProductBin.IDToggle(PQABins.DepartmentId, form.qrymain.fieldbyname('binlocation').asString , form.qrymain.fieldbyname('binnumber').asString, PQABins.Connection.connection); *)
                        CreateBin4Class;
                      end;
                      if PQABins.BinID <>0 then lbins.locate('binID' , PQABins.BinID , []);
                      PQABins.PostDB;
                    end;
                  end;
                  if fdtotal > fdallocated then begin
                    if (PQA.Alloctype = 'OUT') and (form.qrymain.fieldbyname('UOMQty').asFloat<=0) then begin
                      PQABins.UOMQty :=0;
                    end else if (PQA.Alloctype = 'OUT') and (form.qrymain.fieldbyname('UOMQty').asFloat <= fdtotal-fdallocated) then begin
                      PQABins.UOMQty :=PQABins.UOMQty + form.qrymain.fieldbyname('UOMQty').asFloat;
                      fdallocated := fdallocated + form.qrymain.fieldbyname('UOMQty').asFloat;
                    end else begin
                      PQABins.UOMQty :=PQABins.UOMQty + (fdtotal-fdallocated);
                      fdallocated := fdallocated + (fdtotal-fdallocated);
                    end;
                  end;
                  PQABins.PostDB;
                  if AddPQADetailClass(PQAbins) then begin
                    PQAbins.PQADetailsClass.binID := tcdatautils.getbinId(form.qrymain.fieldbyname('binlocation').asString , form.qrymain.fieldbyname('binnumber').asString , form.qrymain.fieldbyname('DepartmentID').asInteger);
                    PQAbins.PQADetailsClass.binlocation :=form.qrymain.fieldbyname('binlocation').asString ;
                    PQAbins.PQADetailsClass.binNumber :=form.qrymain.fieldbyname('binnumber').asString;
                    PQAbins.PQADetailsClass.PostDB;
                  end;
                end else if TwwDBGrid(Sender) = gsn then begin
                    if (PQA.Alloctype = 'OUT') or ((PQA.Alloctype = 'IN') and ((PQA.Qty <0) {or (Owner.ClassNameIs('TfmStockAdjustEntryTree'))})) then
                      if PQASN.dataset.Locate('value' ,form.qrymain.fieldbyname('SerialNumber').asString , []) then else
                        if abs(fdtotal)-fdallocated >0 then begin
                          PQASN.New;
                          PQASN.SerialNumber :=form.qrymain.fieldbyname('SerialNumber').asString;
                          if (PQA.qty<0) and (PQa.IsBO =False) then PQASN.Qty := -1;
                          if (PQA.isbo) and (PQa.Qty=0) then PQASN.BoQty := -1;
                          PQASN.  PostDB;
                          if AddPQADetailClass(PQASN) then begin
                            PQASN.PQADetailsClass.PQAValue :=PQASN.Serialnumber;
                            PQASN.PQADetailsClass.PostDB;
                          end;
                          fdallocated := fdallocated +1;
                        end;
                end;
              end;
            end;
          end;
        finally
            FreeAndNil(Form);
        end;
    end else if (Shift = [ssctrl]) and (Key=VK_UP)  then begin
       if (curgrid = gBatch) then
       else  if (curgrid = gbins) and (gbatch.visible) then begin
            gbatch.SetActiveField('cbinsofBatch');
            btnBinsofBatch.Expanded := False;
       end else  if (curgrid = gsn) and (gbins.visible) then begin
            gbins.SetActiveField('cSnsofBin');
            btnSnofbin.Expanded := False;
       end else  if (curgrid = gsn) and (gbatch.visible) then begin
            gbatch.SetActiveField('cSnsofBatch');
            btnSnofBatch.Expanded := False;
       end;
    end else if (Shift = [ssctrl]) and (Key=VK_DOWN)  then begin
          if (Sender = gBatch) and (isbin) and (PQABatch.UOMQTY<> 0) then begin
              gbatch.SetActiveField('cbinsofBatch');
              btnBinsofBatch.Expanded := True;
              if PQABins.count  = 0 then PQAbins.new;
          end else if (Sender   = gBatch) and (issn) and (PQABatch.UOMQTY <> 0) then begin
              gbatch.SetActiveField('cSnsofBatch');
              btnSnofBatch.Expanded   := true;
              if PQASN.count    = 0 then PQASn.new;
          end else  if (Sender  = gbins) and (issn)   and (PQAbins.UOMQty<>0) then begin
              gbins.SetActiveField('cSnsofBin');
              btnSnofbin.Expanded     := True;
              if PQASn.count = 0 then PQASN.new;
          end;
    end else if (Key = VK_TAB) then begin
        (*if (Sender is TwwDBGrid) and (Sysutils.SameText(TwwDBGrid(Sender).GetActiveField.FieldName , 'UOMQty')) then begin
        TwwDBGrid(Sender).Datasource.Dataset.BeforeInsert(TwwDBGrid(Sender).Datasource.Dataset);
        Application.ProcessMessages;
      end; *)
    end;
  if ssCtrl in shift then
    if ActiveControl = gBatch then begin
      if (Key = ord('V')) or (Key =Ord('v')) then
        ImportFromClipBoard
      else if (Key = ord('C')) or (Key =Ord('c')) then
        CopyToClipBoard;
    end
    else if ActiveControl = gSN then begin
      if (Key = ord('V')) or (Key =Ord('v')) then
        ImportSNFromClipBoard
      else if (Key = ord('C')) or (Key =Ord('c')) then
        CopySNToClipBoard;
    end;
  finally
    ProcessingKey:= false;
  end;
end;

procedure TfmAllocation.ReadGuipref;
var
  ctr:Integer;
begin
  try
      GuiPrefs.Active := true;
      if GuiPrefs.Node.Exists('Options') then begin
        if GuiPrefs.Node['Options.formWidth'].asInteger <> 0 then Self.Width := GuiPrefs.Node['Options.formWidth'].asInteger;
        if GuiPrefs.Node['Options.formHeight'].asInteger <> 0 then Self.Height := GuiPrefs.Node['Options.formHeight'].asInteger;

        for ctr := 0 to Qbatch.FieldCount -1 do
            if GuiPrefs.Node['Options.Batch.'+Qbatch.fields[ctr].fieldname].asInteger <> 0 then
              Qbatch.fields[ctr].displaywidth :=GuiPrefs.Node['Options.Batch.'+Qbatch.fields[ctr].fieldname].asInteger;
        for ctr := 0 to QBins.FieldCount  -1 do
            if GuiPrefs.Node['Options.Bins.'+QBins.fields[ctr].fieldname].asInteger  <> 0 then
              QBins.fields[ctr].displaywidth  :=GuiPrefs.Node['Options.Bins.'+QBins.fields[ctr].fieldname].asInteger;
        for ctr := 0 to QSn.FieldCount    -1 do
            if GuiPrefs.Node['Options.SN.'+QSn.fields[ctr].fieldname].asInteger    <> 0 then
              QSn.fields[ctr].displaywidth    :=GuiPrefs.Node['Options.SN.'+QSn.fields[ctr].fieldname].asInteger;
      end;
  finally
    if mainform.width < Width+left then begin
      SetFormnGridWidth;
    end;
    if mainform.Height < Height+Top then begin
      if Top > mainform.Height /2 then Top := trunc(mainform.Height/2);
      if mainform.Height < Height+Top then  Height := Mainform.Height - Top;
    end;
  end;
end;

procedure TfmAllocation.REadtotalQty(const Sender: TBusObj;  var Abort: boolean);
begin
 if not(Sender is TPQADetails) then exit;
  fdallocated := fdallocated + TPQADetails(Sender).UOMqty;
end;

procedure TfmAllocation.MoveForms(formExt: TForm);
begin
  if formExt.Left +formExt.Width> Application.MainForm.width + abs(Application.MainForm.left) then begin
    formExt.Left := Self.Left - formExt.width;
  end;
end;

procedure TfmAllocation.OpenAllocExt;
var
  Shift: TShiftState;
  Key: Word;
begin
if curgrid = nil then exit;
  if (curgrid.Datasource.Dataset.recordcount = 0) and (PQA.POnumber = 0) then begin
    Shift := [];
    Key :=VK_F9;
    KeyUpEvent(curgrid, Key, Shift);
  end;
end;

procedure TfmAllocation.PastefromClipboard1Click(Sender: TObject);
begin
  inherited;
  self.ImportSNFromClipBoard;
end;

procedure TfmAllocation.FormActivate(Sender: TObject);
begin
  inherited;
  if  fbformshowing then exit;
  OpenAllocExt;
  fbformshowing := False;
end;

procedure TfmAllocation.SetAllocRO(const Value: Boolean);
begin
  if Value then begin
      gbatch.Options := gbatch.Options - [dgEditing];
      gbins.Options := gbins.Options - [dgEditing];
      gsn.Options := gsn.Options - [dgEditing];
      gbatch.OnBeforePaint:= GridBeforePaint;
      gbins.OnBeforePaint := GridBeforePaint;
      gsn.OnBeforePaint   := GridBeforePaint;
  end else begin
      gbatch.Options := gbatch.Options + [dgEditing];
      gbins.Options := gbins.Options + [dgEditing];
      gsn.Options := gsn.Options + [dgEditing];
  end;
end;

procedure TfmAllocation.qbatchBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  if abs(PQABatch.TotalAllocated) >= abs(PQA.UOMQty)  then begin
    PostMessage(Self.Handle, SX_ExpandGrid, 0, 0);
    abort;
    Exit;
  end;
  if PQABatch.count >0 then begin
    PQABatch.last;
    prevBatch:= qbatchValue.AsString;
    PrevTruckNo:= qbatchTruckLoadNo.AsString;
  end;
end;
procedure TfmAllocation.qbatchBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qbatchUOMQty.DisplayFormat := FloatFieldDisplayFormat;
end;

{}
procedure TfmAllocation.qbinsBeforeInsert(DataSet: TDataSet);
begin
  inherited;



//  if isbatch then PQAbins.TotalAllocated;
//  if (isbatch and (abs(PQAbins.fdTotalAllocated)>= abs(PQABatch.UOMqty))) OR
//  (not(isbatch) and (abs(PQAbins.fdTotalAllocated)>= abs(PQA.UOMqty))) then begin
//    PostMessage(Self.Handle, SX_ExpandGrid, 0, 0);
//    abort;
//    Exit;
//  end;
  if isbatch then PQABatch.PQABins.TotalAllocated;
  if (isbatch and (abs(PQABatch.PQABins.fdTotalAllocated)>= abs(PQABatch.UOMqty))) OR
  (not(isbatch) and (abs(PQAbins.fdTotalAllocated)>= abs(PQA.UOMqty))) then begin
    PostMessage(Self.Handle, SX_ExpandGrid, 0, 0);
    abort;
    Exit;
  end;

end;

procedure TfmAllocation.qbinsBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qbinsUOMQty.DisplayFormat := FloatFieldDisplayFormat;
end;

procedure TfmAllocation.qsnBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  if (isbin) or (isbatch) then PQASN.TotalAllocated;
  if ((isbin) and (abs(PQASN.fdTotalAllocated)>= abs(PQAbins.UOMqty))) OR
    ((not(isbin)) and (isbatch)      and (abs(PQASN.fdTotalAllocated)>= abs(PQABatch.UOMqty))) OR
    ((not(isbin)) and (not(isbatch)) and (abs(PQAbins.fdTotalAllocated)>= abs(PQA.UOMqty))) then begin
    PostMessage(Self.Handle, SX_ExpandGrid, 0, 0);
    abort;
    Exit;
  end;

end;

procedure TfmAllocation.ExpandGrid(var Message: TMessage);
var
    Key: Word;
    Shift:TShiftState;
begin
  Shift := [ssctrl] ;
  Key:=VK_DOWN;
  (*if (Screen.Activecontrol <> gbatch) and
      (Screen.Activecontrol <> gbins) and
      (Screen.Activecontrol <> gsn) then
        if gsn.visible then SetControlFocus(gsn)
        else if gbins.visible then SetControlFocus(gbins)
        else if gbatch.visible then SetControlFocus(gbatch);*)

  if Screen.Activecontrol = gbatch then begin
    if isbin or issn then
      KeyUpEvent(gbatch, Key, Shift);
  end else if Screen.Activecontrol = gbins then
    if issn then KeyUpEvent(gbins, Key, Shift);
end;

procedure TfmAllocation.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteGuiPref;
  inherited;
end;

procedure TfmAllocation.FormCloseQuery(Sender: TObject;  var CanClose: Boolean);
var
  msgOption:Word;
begin
    if (assigned(PQABatch) and PQABatch.dirty) or (assigned(PQAbins) and PQAbins.dirty) or ( assigned(PQASN) and PQASN.dirty) then begin
        msgOption:=commonlib.MessageDlgXP_Vista('Do you wish to Keep these changes?', mtConfirmation , [mbyes, mbno, mbcancel], 0);

      if msgOption = mrCancel then begin
          CanClose := False;
          Exit;
      end;

      if msgOption = mrno then begin
            if PQABatch <> nil then PQABatch.CancelDB;
            if PQAbins  <> nil then PQAbins.CancelDB;
            if PQASn    <> nil then PQASn.CancelDB;
          if PQAbins  <> nil then begin
              PQAbins.CancelDB;
              {this is for stock transfer - if copid the allocation and bins are blank as it doesn't exists in the second department, u have to create the bin, if not changed and cancelled the form, delete those records, which will delete serial numebrs underneth as well if any}
              PQAbins.iteraterecords(Deleteifbinidis0);
          end;
          if not (fbbtnSaveclicked) then begin
            PQA.connection.RollbackNestedTransaction;
            PQA.refreshall;
          end;
      end;

      if msgOption = mryes then begin
        Canclose := SaveRecord;
        if not(Canclose) then exit;
      end;

    end;
    //allocated := false;
  inherited;
end;
procedure TfmAllocation.Deleteifbinidis0(Const Sender: TBusObj; var Abort: boolean);
begin
  if not (Sender is TPQABins) then exit;
  if TPQABins(Sender).binID=0 then begin
    TPQABins(Sender).UOMQty := 0;
    TPQABins(Sender).PostDB;
    TPQABins(Sender).delete;
  end;
end;
procedure TfmAllocation.FormDestroy(Sender: TObject);
begin
  if Assigned(fPQA) then begin
    fPQA.name := '';
    fPQA := nil;
  end;
  inherited;
end;

procedure TfmAllocation.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
    if (ssShift in shift) and (ssAlt in shift) and (ssCtrl in Shift) then begin
      if key = VK_RIGHT then Self.Width := Self.Width +1
      else if key = VK_LEFT then Self.Width := Self.Width -1
      else if key = VK_DOWN then Self.Height := Self.Height +1
      else if key = VK_UP then Self.Height := Self.Height -1;
    end;
end;

procedure TfmAllocation.lbinNoCalcFields(DataSet: TDataSet);
begin
  inherited;
  lbinNoVolumeAvailable.asFloat := lbinNovolume.asFloat - lbinNoVolume_Used.asfloat;

end;

procedure TfmAllocation.lbinsCalcFields(DataSet: TDataSet);
begin
  inherited;
  lbinsVolumeAvailable.asFloat := lbinsvolume.asFloat - lbinsVolume_Used.asfloat;
end;

function TfmAllocation.SAAllocationTables: String;
begin
  REsult := AllocationTables;
end;

procedure TfmAllocation.SerialNoSelected(Sender: TObject);
var
  i:Integer;
  Procedure AddPQADetailClass(PQADetail :TPQADetails);
  begin
    if TwwDBGrid(Sender).Datasource.Dataset.findfield('departmentID')<> nil then begin
      if TwwDBGrid(Sender).Datasource.Dataset.fieldbyname('departmentID').asInteger <>PQADetail.PQA.DepartmentID then begin
        if PQADetail.PQADetailsClass.count =0 then PQADetail.PQADetailsClass.New;
        PQADetail.PQADetailsClass.ClassId:=TwwDBGrid(Sender).Datasource.Dataset.fieldbyname('departmentID').asInteger;
        PQADetail.PQADetailsClass.UOMID := PQADetail.PQA.UnitOfMeasureID;
        PQADetail.PQADetailsClass.UOMQty :=PQADetail.UOMQTY;
        PQADetail.PQADetailsClass.Qty :=PQADetail.Qty;
        PQADetail.PQADetailsClass.Active := TRue;

      end else begin
        if PQADetail.PQADetailsClass.count >0 then PQADetail.PQADetailsClass.Active:= False;
      end;
    end else begin
        if PQADetail.PQADetailsClass.count >0 then begin
          PQADetail.PQADetailsClass.Active:= False;
        end;
    end;
    PQADetail.PQADetailsClass.PostDB;
  end;

begin
  if not(Sender is TwwDBGrid) then exit;
  for i := 0 to TwwDBGrid(Sender).SelectedList.Count - 1 do begin
      TwwDBGrid(Sender).Datasource.Dataset.GotoBookmark(TwwDBGrid(Sender).SelectedList.Items[i]);
      if PQASN.dataset.Locate('value' ,TwwDBGrid(Sender).Datasource.Dataset.fieldByname('SerialNo').asString , []) then else
        if fdtotal-fdallocated >0 then begin
          PQASN.New;
          PQASN.SerialNumber :=TwwDBGrid(Sender).Datasource.Dataset.fieldByname('SerialNo').asString;
          PQASN.PostDB;
          AddPQADetailClass(PQASN);
          fdallocated := fdallocated +PQASN.UOMQty;
        end;
  end;
end;

procedure TfmAllocation.AddBatchNumberSuffix;
var
  bm: TBookmark;
  poRef, poRefFull: string;
  lineNo: integer;
  posRef: integer;
begin
  if (PQABatch.PQA.PONumber = 0) or ((qBatch.RecordCount = 0) and (not (qBatch.State in [dsInsert, dsEdit]))) or (not Appenv.CompanyPrefs.AutoAppendBatchNumber) then exit;
  qBatch.DisableControls;
  try
    bm:= qBatch.GetBookmark;
    qBatch.First;
    poRef:= 'PO-' + IntToStr(PQABatch.PQA.PONumber)+ '-'+inttostr(PQABatch.PQA.transLineID);
    lineNo:= 1;
    prevBatch:= '';
    while not qBatch.Eof do begin
      poRefFull:= poRef + '-' + IntToStr(lineNo);
      posRef:= Pos(poRef,qbatchValue.AsString);
      if posRef = 0 then begin
        if qbatchValue.AsString <> '' then begin
          { no suffix so add one }
          EditDb(qBatch);
          qbatchValue.AsString:= qbatchValue.AsString + ' ' + poRefFull;
          PostDb(qBatch);
        end;
      end
      else begin
        if Pos(poRefFull,qBatchValue.AsString) = 0 then begin
          { we have a po ref suffix but does not match, so replace it }
        EditDb(qBatch);
        qbatchValue.AsString:= Copy(qbatchValue.AsString,1,posRef -1) + ' ' + poRefFull;
        PostDb(qBatch);
        end;
      end;
      prevBatch:= qbatchValue.AsString;

      qBatch.Next;
      Inc(lineNo);
    end;
    qBatch.GotoBookmark(bm);
  finally
    qbatch.FreeBookmark(bm);
    qBatch.EnableControls;
  end;
end;

function TfmAllocation.AddDEfaultbin(xPQABins :TPQABins): Boolean;
var
  fdTotal:double;
  i:Integer;
begin
  result := false;
  if xPQABins.count <> 0 then exit;

  if PQA.Product.Batch then fdTotal := PQABatch.uomQty else fdTotal := PQA.UOMQty;
  i := TProductClass.DefaultbinId(PQA.ProductID , PQA.DepartmentID);
  if i <> 0 then begin
    xPQABins.New;
    xPQABins.BinID := i;
    xPQABins.UOMQTY :=fdTotal;
    xPQABins.PostDB;
    REsult := TRue;
  end;
end;

procedure TfmAllocation.AutoCloseform(var Message: TMessage);
var
  ctr:Integer;
begin
  ctr:= 0;
  if (issn = False) and (PQA.Product.autoallocbin) then begin
     btncloseClick(btnclose);
  end else begin
    if (Screen.Activecontrol <> gbatch) and
      (Screen.Activecontrol <> gbins) and
      (Screen.Activecontrol <> gsn) then
        if gsn.visible then SetControlFocus(gsn)
        else if gbins.visible then SetControlFocus(gbins)
        else if gbatch.visible then SetControlFocus(gbatch);

    if issn  then begin
      while (screen.ActiveControl<> gsn) and (ctr<3)  do begin
        PostMessage(Self.Handle, SX_ExpandGrid, 0, 0);
        ctr:= ctr+1;
      end;
    end else begin
      while (screen.ActiveControl<> gbins) and (ctr<2)  do begin
        PostMessage(Self.Handle, SX_ExpandGrid, 0, 0);
        ctr:= ctr+1;
      end;
    end;
  end;
end;

(*procedure TfmAllocation.Applyfilter(PQADetailDataset: TDataset;PQADetailParentRef: string);
begin
   PQADetailDataset.filtered := False;
   PQADetailDataset.Refresh;
   PQADetailDataset.filter := 'ParentREf = ' +quotedStr(PQADetailParentRef);
   PQADetailDataset.filtered := True;
end;*)

initialization
    RegisterClassOnce(TfmAllocation);
end.


