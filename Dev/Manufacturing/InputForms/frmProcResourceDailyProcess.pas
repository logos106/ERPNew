unit frmProcResourceDailyProcess;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase, ActnList , BusObjProcResource, Wwdbspin,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdblook, Mask, wwdbedit , frmProcResourceBase,
  wwcheckbox, wwdbdatetimepicker;

type
  TfmProcResourceDailyProcess = class(TfmProcResourceBase)
    cboUnitOfMeasure: TwwDBLookupCombo;
    Label5: TLabel;
    wwDBEdit1: TwwDBEdit;
    wwDBSpinEdit1: TwwDBSpinEdit;
    Label3: TLabel;
    Label6: TLabel;
    Label4: TLabel;
    QryProductNameProductId: TIntegerField;
    QryProductNameProductname: TWideStringField;
    qryProcResourceProductsResourceDate: TDateTimeField;
    lblMsg: TLabel;
    btnChooseProducts: TDNMSpeedButton;
    btncleanup: TDNMSpeedButton;
    qryProcResourceProductscSeqno: TIntegerField;
    qryProcResourceProductClean: TERPQuery;
    dsProcResourceProductClean: TDataSource;
    qryProcResourceProductCleanID: TIntegerField;
    qryProcResourceProductCleanGlobalRef: TWideStringField;
    qryProcResourceProductCleanProcresourcedetailID: TIntegerField;
    qryProcResourceProductCleanProductId: TIntegerField;
    qryProcResourceProductCleanProductName: TWideStringField;
    qryProcResourceProductCleanSeqno: TIntegerField;
    qryProcResourceProductCleanNoOfResources: TIntegerField;
    qryProcResourceProductCleanActive: TWideStringField;
    qryProcResourceProductCleanResourceDate: TDateTimeField;
    qryProcResourceProductCleanmsTimeStamp: TDateTimeField;
    qryProcResourceProductCleanmsUpdateSiteCode: TWideStringField;
    DNMPanel1: TDNMPanel;
    Label8: TLabel;
    wwDBEdit2: TwwDBEdit;
    dtResourceDate: TwwDBDAteTimePicker;
    Label9: TLabel;
    Label7: TLabel;
    wwDBLookupCombo1: TwwDBLookupCombo;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actSaveExecute(Sender: TObject);
    procedure btnupClick(Sender: TObject);
    procedure btndownClick(Sender: TObject);
    procedure actnewexecute(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnChooseProductsClick(Sender: TObject);
    procedure btncleanupClick(Sender: TObject);
    procedure cboUnitOfMeasureCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure qryProcResourceProductsCalcFields(DataSet: TDataSet);
    procedure grdProcResourceProductsEnter(Sender: TObject);
    procedure wwIButton11xxClick(Sender: TObject);
  private
    ProcResObj: TProcResource;
    dtResourceCleanup:TDatetime;
    SelectedProducts:Integer;
    SelectedDupProducts:Integer;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    function SaveRecord: Boolean;
    Procedure Openrec;
    procedure NewBusObjinstance;
    procedure NewRecord;
    procedure SelectProduct(Sender: TwwDbGrid);
    procedure CleanupCallback(const Sender: TBusObj; var Abort: boolean);
  Protected
    procedure CommitAndNotify;override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, BusObjConst, AppEnvironment, FormFactory, CommonFormLib,
  CommonDbLib, DbSharedObjectsObj, frmDateInputBox, dateutils, tcConst;

{$R *.dfm}

Function TfmProcResourceDailyProcess.SaveRecord :Boolean;
begin
  result:= False;
  ProcResObj.PostDB;
  if not(ProcResObj.Save) then exit;
  Result:= True;

end;

procedure TfmProcResourceDailyProcess.actnewexecute(Sender: TObject);
begin
  inherited;
//
end;

procedure TfmProcResourceDailyProcess.actSaveExecute(Sender: TObject);
begin
  inherited;
//
end;

procedure TfmProcResourceDailyProcess.btnCancelClick(Sender: TObject);
begin
  inherited;
//
end;

procedure TfmProcResourceDailyProcess.btnChooseProductsClick(Sender: TObject);
begin
  inherited;
  SelectedProducts := 0;
  SelectedDupProducts := 0;
  OpenERPListFormultiselect('TManufactureProductListGUI', nil, true, SelectProduct);
end;

procedure TfmProcResourceDailyProcess.btncleanupClick(Sender: TObject);
var
  qry: TERPQuery;
  fbcheckOption:Boolean;
begin
  if MessageDlgXP_Vista('This will Save the current Changes. Do You wish to continue? ', mtConfirmation, [mbYes, mbNo], 0) =mrno then exit;
  if not SaveData then Exit;
  CommitTransaction;
  beginTransaction;
  try
    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(commondblib.GetSharedMyDacConnection);
    try
      qry.SQL.text := 'SELECT Min(Seqno) as  Seqno , MAX(ResourceDate) as ResourceDate FROM tblprocresourceproducts WHERE  ProcresourcedetailId = ' + inttostr(ProcResource.ProcResourceDetails.ID);
      qry.open;
      if qry.recordcount >0 then dtResourceCleanup:= qry.fieldbyname('ResourceDate').asDateTime else dtResourceCleanup:= incday(dtResourceCleanup,1);
      if TfmDateInputBox.InputValue('Choose Cleanup Date','Date Available after cleanup',dtResourceCleanup,Self.Color ) then begin
        ProcResource.ProcResourceDetails.ProcResourceProducts.iterateRecords(CleanupCallback);
        if ProcResource.ProcResourceDetails.ProcResourceProductClean.Locate('seqno', Qry.fieldbyname('Seqno').asInteger, []) then begin
          ProcResource.ProcResourceDetails.ProcResourceProductClean.NoOfREsources := ProcResource.ProcResourceDetails.NoOfResources;
          ProcResource.ProcResourceDetails.ProcResourceProductClean.ResourceDate := dtResourceCleanup;
          ProcResource.ProcResourceDetails.ProcResourceProductClean.PostDB;
        end;
      end;
    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    end;
  finally
    ProcResource.ProcResourceDetails.ProcResourceProducts.First;
    SetControlFocus(grdProcResourceProducts);
  end;
end;
procedure TfmProcResourceDailyProcess.CleanupCallback(Const Sender: TBusObj; var Abort: boolean);
begin
  if sender is  TProcResourceProductList then begin
        TProcResourceProductList(Sender).NoOfREsources := 0;
        TProcResourceProductList(Sender).ResourceDate := dtResourceCleanup;
        TProcResourceProductList(Sender).PostDB;
  end;
end;
procedure TfmProcResourceDailyProcess.SelectProduct(Sender: TwwDbGrid);
var
  i: integer;
  bm:TBookmark;
begin
  if Sender.SelectedList.Count > 0 then begin
    for i := 0 to Sender.SelectedList.Count - 1 do begin
      sender.DataSource.DataSet.GoToBookmark(Sender.SelectedList.Items[i]);
      if not ProcResource.ProcResourceDetails.ProcResourceProducts.Locate('ProductID' , Sender.datasource.dataset.Fieldbyname('PartsID').asInteger , []) then begin
        ProcResource.ProcResourceDetails.ProcResourceProducts.New;
        ProcResource.ProcResourceDetails.ProcResourceProducts.ProductName := Sender.datasource.dataset.Fieldbyname('PARTNAME').asString;
        ProcResource.ProcResourceDetails.ProcResourceProducts.PostDB;
        SelectedProducts := SelectedProducts +1;
      end else begin
        SelectedDupProducts := SelectedDupProducts +1;
      end;
    end;
    MessageDlgXP_Vista(inttostr(SelectedProducts) +' New Product(s) Linked'+
                      iif(SelectedDupProducts=0,'.',' and '+ NL + inttostr(SelectedDupProducts) +' Selected Product(s) were already Linked.'), mtInformation, [mbOK], 0);
  end;
end;
procedure TfmProcResourceDailyProcess.wwIButton11xxClick(Sender: TObject);
begin
  inherited;
  ProcResource.ProcResourceDetails.ProcResourceProducts.postdb;
  if ProcResource.ProcResourceDetails.ProcResourceProducts.count =0 then exit;
  ProcResource.ProcResourceDetails.ProcResourceProducts.Delete;
  ProcResource.ProcResourceDetails.ProcResourceProducts.PostDB;
  Setcontrolfocus(grdProcResourceProducts);
end;

procedure TfmProcResourceDailyProcess.btndownClick(Sender: TObject);
begin
  inherited;
//
end;

procedure TfmProcResourceDailyProcess.btnSaveClick(Sender: TObject);
begin
  ProcResource.ProcResourceDetails.ProcResourceProductClean.PostDB;
  ProcResource.ProcResourceDetails.ProcResourceProducts.PostDB;
  inherited;
//
end;

procedure TfmProcResourceDailyProcess.btnupClick(Sender: TObject);
begin
  inherited;
//
end;

procedure TfmProcResourceDailyProcess.cboUnitOfMeasureCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  ProcResObj.ProcResourcedetails.UOMId :=  LookupTable.Fieldbyname('UnitID').asInteger;
end;

procedure TfmProcResourceDailyProcess.CommitAndNotify;
begin
  inherited;
  CommitTransaction;
  Notify;

end;

procedure TfmProcResourceDailyProcess.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Change) and (Value = BusObjEventVal_DuplicateProduct) and (Sender is TProcResourceProductList) then begin
    TimerMsg(lblmsg, 'This Product ('+ TProcResourceProductList(Sender).Productname +')is Already Selected for the Sequence.');
  end;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TProcResourceProductClean     then TProcResourceProductClean(Sender).DataSet   := qryProcResourceProductClean;
  end else if (Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterOpen) and (Sender is TProcResourceDetails) then begin
    Closedb(qryProcResourceProductClean);
    ProcResource.ProcResourceDetails.ProcResourceProductclean;
  end;
end;

procedure TfmProcResourceDailyProcess.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := cafree;
end;

procedure TfmProcResourceDailyProcess.FormCreate(Sender: TObject);
begin
  inherited;
   NewBusObjinstance;
   lblMsg.Visible := False;
end;
procedure TfmProcResourceDailyProcess.FormShow(Sender: TObject);
begin
  inherited;
  OpenRec;
end;

procedure TfmProcResourceDailyProcess.grdProcResourceProductsEnter(
  Sender: TObject);
begin
  inherited;
  ProcResource.ProcResourceDetails.ProcResourceProductClean.PostDB;
end;

procedure TfmProcResourceDailyProcess.NewBusObjinstance;
begin
  {$WARNINGS OFF}
  ProcResObj := TProcResource.CreateWithNewConn(Self);
  ProcResObj.Connection.connection := Self.MyConnection;
  ProcResObj.BusObjEvent := DoBusinessObjectEvent;
  {$WARNINGS ON}
end;

procedure TfmProcResourceDailyProcess.NewRecord;
begin
    CloseQueries;
    KeyID:= 0;
    NewBusObjinstance;
    AccessLevel:= AppEnv.AccessLevels.GetEmployeeAccessLevel(Self.ClassName);
    self.BeginTransaction;
    OpenRec;
    Caption:= TitleLabel.Caption + AppEnv.AccessLevels.GetAccessLevelDescription(AccessLevel);
    //Setcontrolfocus(edtName);
end;

procedure TfmProcResourceDailyProcess.Openrec;
begin
  ProcResObj.Load(KeyID);
  ProcResObj.connection.BeginTransaction;
  if ProcResObj.count=0 then ProcResObj.new;
  openQueries;
  ProcResObj.Dirty := false;
end;

procedure TfmProcResourceDailyProcess.qryProcResourceProductsCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryProcResourceProductscSeqno.asInteger := qryProcResourceProductsSeqno.asInteger -1;
end;

initialization
  RegisterClassOnce(TfmProcResourceDailyProcess);
  with FormFact do begin
    RegisterMe(TfmProcResourceDailyProcess, 'TfmProcResourceList_*_T=ProcResourceId');
  end;
end.

