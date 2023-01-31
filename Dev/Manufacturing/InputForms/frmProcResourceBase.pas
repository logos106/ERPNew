unit frmProcResourceBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls , BusObjProcResource, BusObjBase, Shader, DNMPanel,
  Mask, wwdbedit, wwcheckbox, DNMSpeedButton, ActnList, wwdblook, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, DBCtrls;

type
  TfmProcResourceBase = class(TBaseInputGUI)
    qryProcResourceProducts: TERPQuery;
    qryProcResourceProductsActive: TWideStringField;
    qryProcResourceProductsProductId: TIntegerField;
    qryProcResourceProductsProductName: TWideStringField;
    qryProcResourceProductsGlobalRef: TWideStringField;
    qryProcResourceProductsID: TIntegerField;
    qryProcResourceProductsmsTimeStamp: TDateTimeField;
    qryProcResourceProductsmsUpdateSiteCode: TWideStringField;
    qryProcResourceProductsNoOfResources: TIntegerField;
    qryProcResourceProductsProcresourcedetailID: TIntegerField;
    qryProcResourceProductsSeqno: TIntegerField;
    dsProcResource: TDataSource;
    dsProcResourceProducts: TDataSource;
    dsProcResourcedays: TDataSource;
    dsProcResourceDetails: TDataSource;
    dsprocresourceUnavailability: TDataSource;
    dsResourceProcessStep: TDataSource;
    qryProductName: TERPQuery;
    qryfixedassets: TERPQuery;
    qryProcessStep: TERPQuery;
    qryProcResource: TERPQuery;
    qryProcResourceActive: TWideStringField;
    qryProcResourceBreakdownHoursDay: TFloatField;
    qryProcResourcedays: TERPQuery;
    qryProcResourcedaysFriday: TWideStringField;
    qryProcResourcedaysFridayCapacityHoursDay: TFloatField;
    qryProcResourcedaysFridayStartAt: TTimeField;
    qryProcResourcedaysGlobalref: TWideStringField;
    qryProcResourcedaysID: TIntegerField;
    qryProcResourcedaysMonday: TWideStringField;
    qryProcResourcedaysMondayCapacityHoursDay: TFloatField;
    qryProcResourcedaysMondaystartAt: TTimeField;
    qryProcResourcedaysmsTimestamp: TDateTimeField;
    qryProcResourcedaysmsUpdateSiteCode: TWideStringField;
    qryProcResourcedaysProcResourceID: TIntegerField;
    qryProcResourcedaysSaturday: TWideStringField;
    qryProcResourcedaysSaturdayCapacityHoursDay: TFloatField;
    qryProcResourcedaysSaturdayStartAt: TTimeField;
    qryProcResourcedaysSunday: TWideStringField;
    qryProcResourcedaysSundayCapacityHoursDay: TFloatField;
    qryProcResourcedaysSundayStartAt: TTimeField;
    qryProcResourcedaysThursday: TWideStringField;
    qryProcResourcedaysThursdayCapacityHoursDay: TFloatField;
    qryProcResourcedaysThursdayStartAt: TTimeField;
    qryProcResourcedaysTuesday: TWideStringField;
    qryProcResourcedaysTuesdayCapacityHoursDay: TFloatField;
    qryProcResourcedaysTuesdayStartAt: TTimeField;
    qryProcResourcedaysWednesday: TWideStringField;
    qryProcResourcedaysWednesdayCapacityHoursDay: TFloatField;
    qryProcResourcedaysWednesdayStartAt: TTimeField;
    qryProcResourceDescription: TWideStringField;
    qryProcResourceDetails: TERPQuery;
    qryProcResourceDetailsActive: TWideStringField;
    qryProcResourceDetailsDescription: TWideStringField;
    qryProcResourceDetailsFixedAsset: TWideStringField;
    qryProcResourceDetailsFixedAssetID: TIntegerField;
    qryProcResourceDetailsGlobalRef: TWideStringField;
    qryProcResourceDetailsID: TIntegerField;
    qryProcResourceDetailsmsTimeStamp: TDateTimeField;
    qryProcResourceDetailsmsUpdateSiteCode: TWideStringField;
    qryProcResourceDetailsNoOfResources: TIntegerField;
    qryProcResourceDetailsProcResourceId: TIntegerField;
    qryProcResourceDetailsRDUnAvailDescriptionCaption: TStringField;
    qryProcResourceDetailsUOMDetails: TWideStringField;
    qryProcResourceDetailsUOMID: TIntegerField;
    qryProcResourceDetailsUOMMult: TFloatField;
    qryProcResourceDetailsUOMQty: TFloatField;
    qryProcResourceGlobalRef: TWideStringField;
    qryProcResourceHourlyLabourRate: TFloatField;
    qryProcResourceHourlyOverheadRate: TFloatField;
    qryProcResourcemsTimeStamp: TDateTimeField;
    qryProcResourcemsUpdateSiteCode: TWideStringField;
    qryProcResourceProcResourceId: TIntegerField;
    qryProcResourceResourceAvailable: TWideStringField;
    qryProcResourceResourceCount: TIntegerField;
    qryProcResourceResourceName: TWideStringField;
    qryProcResourceSetupHoursDay: TFloatField;
    qryprocresourceUnavailability: TERPQuery;
    qryprocresourceUnavailabilityDescription: TWideStringField;
    qryprocresourceUnavailabilityGlobalRef: TWideStringField;
    qryprocresourceUnavailabilitymsTimeStamp: TDateTimeField;
    qryprocresourceUnavailabilitymsUpdateSiteCode: TWideStringField;
    qryprocresourceUnavailabilityProcResourceDetailId: TIntegerField;
    qryprocresourceUnavailabilityProcResourceId: TIntegerField;
    qryprocresourceUnavailabilityProcResourceUnAvailabilityId: TIntegerField;
    qryprocresourceUnavailabilityTimeEnd: TDateTimeField;
    qryprocresourceUnavailabilityTimeStart: TDateTimeField;
    qryResourceProcessStep: TERPQuery;
    qryResourceProcessStepGlobalRef: TWideStringField;
    qryResourceProcessStepmsTimeStamp: TDateTimeField;
    qryResourceProcessStepmsUpdateSiteCode: TWideStringField;
    qryResourceProcessStepNoOfEmployeesReqd: TIntegerField;
    qryResourceProcessStepProcessStepActive: TWideStringField;
    qryResourceProcessStepProcessStepDescription: TWideStringField;
    qryResourceProcessStepProcessStepId: TIntegerField;
    qryResourceProcessStepProcResourceId: TIntegerField;
    qryResourceProcessStepProcResourceProcessId: TIntegerField;
    qryUnitOfMeasure: TERPQuery;
    qryUnitOfMeasureMultiplier: TFloatField;
    qryUnitOfMeasureUnitID: TIntegerField;
    qryUnitOfMeasureUnitName: TWideStringField;
    pnltop: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    PnlRes: TDNMPanel;
    Label2: TLabel;
    edtName: TwwDBEdit;
    Label1: TLabel;
    edtDescription: TwwDBEdit;
    pnlButtons: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    ActionList: TActionList;
    actSave: TAction;
    actCancel: TAction;
    actNew: TAction;
    cboProcessStepDesc: TwwDBLookupCombo;
    qryProcResourceStartOftheday: TFloatField;
    qryProcResourceClosedOnPublicHolidays: TWideStringField;
    pnlcolorDetails: TDNMPanel;
    lblNoOfResources: TLabel;
    cboProductName: TwwDBLookupCombo;
    pnlcolmove: TDNMPanel;
    btnup: TDNMSpeedButton;
    btndown: TDNMSpeedButton;
    grdProcResourceProducts: TwwDBGrid;
    wwIButton11xx: TwwIButton;
    qryProcResourceUsedWithProductsInSeq: TWideStringField;
    chkUsedWithProductsInSeq: TDBCheckBox;
    procedure qryProcResourceDetailsCalcFields(DataSet: TDataSet);
    procedure qryResourceProcessStepAfterScroll(DataSet: TDataSet);
    procedure actSaveExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
procedure btnupClick(Sender: TObject);
procedure btndownClick(Sender: TObject);


  private
    procedure SwapSeq(MoveNext: Boolean);
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    Function DoAfterSave :Boolean; Virtual;
    function SaveData: boolean;
    procedure RefreshNoOfResourcesinProduct;Virtual;

  public
    ProcResource: TProcResource;
  end;


implementation

uses BusObjConst, tcConst, CommonLib, DNMExceptions;


{$R *.dfm}
procedure TfmProcResourceBase.qryProcResourceDetailsCalcFields(
  DataSet: TDataSet);
begin
  inherited;
  qryProcResourceDetailsRDUnAvailDescriptionCaption.AsString := qryProcResourceDetailsDescription.AsString +' : Unavailability';
(*  if UOMId =0 then qryProcResourceDetailsUOMDetails.AsString := ''
  else qryProcResourceDetailsUOMDetails.AsString :=TUnitOfMeasure.UOMDesc(qryProcResourceDetailsUOMID.asInteger);*)
end;
procedure TfmProcResourceBase.ActionListUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  actSave.Enabled:= ProcResource.Dirty;
end;

procedure TfmProcResourceBase.actNewExecute(Sender: TObject);
begin
  inherited;
  if ProcResource.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if not SaveData then Exit;
          self.CommitTransaction;
        end;
      mrNo:
        begin

        end;
      mrCancel:
        begin
          Exit;
        end;
    end;
  end;

  KeyID := 0;
  FormShow(nil);
  ProcResource.Dirty := false;

end;

procedure TfmProcResourceBase.actSaveExecute(Sender: TObject);
begin
  inherited;
  if not SaveData then Exit;
  CommitTransaction;
  if not DoAfterSave then Exit;
  ProcResource.Dirty := False;
  Notify;
  Close;

end;

procedure TfmProcResourceBase.btnCancelClick(Sender: TObject);
begin
  inherited;
  CloseIt(False);
end;

function TfmProcResourceBase.DoAfterSave: Boolean;
begin
  REsult := True;
end;

procedure TfmProcResourceBase.DoBusinessObjectEvent(
  const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TProcResource                then TProcResource(Sender).DataSet              := qryProcResource
    else if Sender is TProcResourceDays            then TProcResourceDays(Sender).DataSet          := qryProcResourcedays
    else if Sender is TProcResourceProcess         then TProcResourceProcess(Sender).DataSet       := qryResourceProcessStep
    else if Sender is TProcResourceDetails         then TProcResourceDetails(Sender).DataSet       := qryProcResourceDetails
    else if Sender is TProcResourceUnAvailability  then TProcResourceUnAvailability(Sender).DataSet:= QryprocresourceUnavailability
    else if Sender is TProcResourceProductList     then TProcResourceProductList(Sender).DataSet   := qryProcResourceProducts;
  end  else if (Eventtype = BusObjEvent_Change) and (Value = BusObjEvent_ResourceCount) then begin
    closedb(qryProcResourcedays);
    ProcResource.PostDB;
    ProcResource.ProcResourceDays;
  end  else if (EventType = BusObjEvent_Dataset) and (Sender.IsdataIdchangeEvent(Value) ) then begin
    if Sender is TProcResourceDetails  then begin
      closedB(QryprocresourceUnavailability);
      TProcResourceDetails(Sender).ProcResourceUnAvailability;
    end;
  end else if (Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterPost) and (Sender is TProcResourceProductList) then begin
    RefreshNoOfResourcesinProduct;
  end else if (Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterOpen) and (Sender is TProcResourceDetails) then begin
    Closedb(qryProcResourceProducts);
    ProcResource.ProcResourceDetails.ProcResourceProducts;
    RefreshNoOfResourcesinProduct;
  end else if (Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_dataIdchange_dcLoad) and (Sender is TProcResourceDetails) then begin
    Closedb(qryProcResourceProducts);
    ProcResource.ProcResourceDetails.ProcResourceProducts;
    RefreshNoOfResourcesinProduct;
  end;

end;

procedure TfmProcResourceBase.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if ProcResource.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveData then begin
            ProcResource.Connection.CommitTransaction;
            ProcResource.Dirty := false;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          ProcResource.Dirty := false;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
        end;
    end;
  end else begin
    CanClose := true;
    Notify(false);
  end;


end;

procedure TfmProcResourceBase.FormCreate(Sender: TObject);
begin
  btnSave.onclick := actSaveExecute;
  inherited;
  ProcResource:= TProcResource.Create(self);
  ProcResource.Connection := TMyDacDataConnection.Create(ProcResource);
  ProcResource.Connection.MyDacConnection := MyConnection;
  ProcResource.BusObjEvent := DoBusinessObjectEvent;
end;

procedure TfmProcResourceBase.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen: Array of String;
begin
  inherited;
    try
      Setlength(QueryNamesNotToOpen, 4);
      QueryNamesNotToOpen[0] := 'qryProcResource';
      QueryNamesNotToOpen[1] := 'qryProcResourcedays';
      QueryNamesNotToOpen[2] := 'qryResourceProcessStep';
      QueryNamesNotToOpen[3] := 'qryProcResourceDetails';
      OpenQueries(QueryNamesNotToOpen);
      RollbackTransaction;
      BeginTransaction;
      ProcResource.Load(KeyId);

      if KeyID = 0 then begin
        ProcResource.New;
        ProcResource.PostDB;
      end else  if not ProcResource.Lock then begin
        AccessLevel := 5; // read only
        CommonLib.MessageDlgXP_Vista(ProcResource.UserLock.LockMessage + #13 + #10 + #13 + #10 + 'Access has been changed to read-only.',
          mtWarning, [mbOK], 0);
      end;
      if ProcResource.ProcResourceDetails.count =0 then begin
        ProcResource.ProcResourceDetails.new;
        ProcResource.ProcResourceDetails.PostDB;
      end;
      ProcResource.ProcResourceDetails.ProcResourceProducts;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;

end;

procedure TfmProcResourceBase.qryResourceProcessStepAfterScroll(DataSet: TDataSet);
begin
  inherited;
  qryProcessStep.Close;
  qryProcessStep.ParamByName('Id').AsInteger := ProcResource.Processes.ProcessStepId;
  qryProcessStep.Open;
end;

procedure TfmProcResourceBase.RefreshNoOfResourcesinProduct;
begin
  lblNoOfResources.caption :=  'No of Resources in Product : ' + inttostr(ProcResource.ProcresourceDetails.TotNoOfResourcesinProduct) +' of ' + inttostr(ProcResource.ProcresourceDetails.NoOfResources);
end;

function TfmProcResourceBase.SaveData: boolean;
begin
  result:= true;
  if qryResourceProcessStep.State in [dsInsert, dsEdit] then
    qryResourceProcessStep.post;
  ProcResource.POSTDB;
  ProcResource.Processes.postdb;
  ProcResource.ProcResourceDays.POSTDB;
  ProcResource.ProcResourceDetails.POSTDB;
  ProcResource.ProcResourceDetails.ProcResourceUnAvailability.POSTDB;
  { validate data and return tru if all ok }
  if ProcResource.Dirty then begin
    if not ProcResource.Save then
      result:= false;
  end;
end;
procedure TfmProcResourceBase.btnupClick(Sender: TObject);begin  SwapSeq(False);end;
procedure TfmProcResourceBase.btndownClick(Sender: TObject);begin  SwapSeq(True);end;
Procedure TfmProcResourceBase.SwapSeq(MoveNext:Boolean);
var
  fiseqno1, fiseqno2:Integer;
  fiID1,fiID2:Integer;
begin
  inherited;
  ProcResource.ProcResourceDetails.ProcResourceProducts.PostDB;
  if ProcResource.ProcResourceDetails.ProcResourceProducts.id =0 then exit;

  if not(MoveNext) and (ProcResource.ProcResourceDetails.ProcResourceProducts.recno =  1) then exit;
  if MoveNext and (ProcResource.ProcResourceDetails.ProcResourceProducts.recno =  ProcResource.ProcResourceDetails.ProcResourceProducts.count) then exit;

  if ProcResource.ProcResourceDetails.ProcResourceProducts.count = 1 then exit;

  fiseqno1:= ProcResource.ProcResourceDetails.ProcResourceProducts.Seqno;
  fiID1:= ProcResource.ProcResourceDetails.ProcResourceProducts.ID;

  if MoveNext then ProcResource.ProcResourceDetails.ProcResourceProducts.Next
  else ProcResource.ProcResourceDetails.ProcResourceProducts.Prior;

  fiseqno2:= ProcResource.ProcResourceDetails.ProcResourceProducts.Seqno;
  fiID2:= ProcResource.ProcResourceDetails.ProcResourceProducts.ID;
  if (fiID1 =0) or (fiID2 =0) or (fiseqno1=0) or (fiseqno2=0 ) then exit;
  ProcResource.ProcResourceDetails.ProcResourceProducts.Connection.beginnestedtransaction;
  try
    if ProcResource.ProcResourceDetails.ProcResourceProducts.Locate('ID', fiID2, []) then begin
      ProcResource.ProcResourceDetails.ProcResourceProducts.Seqno := fiseqno1;
      ProcResource.ProcResourceDetails.ProcResourceProducts.PostDB;
    end;
    if ProcResource.ProcResourceDetails.ProcResourceProducts.Locate('ID', fiID1, []) then begin
      ProcResource.ProcResourceDetails.ProcResourceProducts.Seqno := fiseqno2;
      ProcResource.ProcResourceDetails.ProcResourceProducts.PostDB;
    end;
    ProcResource.ProcResourceDetails.ProcResourceProducts.Connection.CommitnestedTransaction;
    ProcResource.ProcResourceDetails.ProcResourceProducts.closedb;
    ProcResource.ProcResourceDetails.ProcResourceProducts;
    ProcResource.ProcResourceDetails.ProcResourceProducts.Locate('ID', fiID1, []);

  Except
    on E:Exception do begin
      ProcResource.ProcResourceDetails.ProcResourceProducts.Connection.RollbacknestedTransaction;
    end;
  end;
end;

end.
