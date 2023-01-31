unit ProductionJobStatus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, DNMAction, ActnList,
  PrintDAT, ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, StdCtrls, wwdblook, Shader, AdvOfficeStatusBar,
  IntegerListObj, DNMPanel, DNMSpeedButton, ProductionJobStatusConverted,
  frmProcCapacityPlanningWork, BusObjBase,ProductionJobStatusbase, DAScript,
  MyScript, wwcheckbox, CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TProductionJobStatusGUI = class(TProductionJobStatusbaseGUI)
    DNMSpeedButton1: TDNMSpeedButton;
    btnfinalise: TDNMSpeedButton;
    btnSelect: TDNMSpeedButton;
    btnPrintDetails: TDNMSpeedButton;
    DNMSpeedButton2: TDNMSpeedButton;
    ERPQuery1: TERPQuery;
    DNMSpeedButton3: TDNMSpeedButton;
    DNMSpeedButton4: TDNMSpeedButton;
    actSmartOrder: TDNMAction;
    qryMaininvoicedQty: TFloatField;
    qryMainQtyTobeInvoiced: TFloatField;
    btnworkorder: TDNMSpeedButton;
    procedure btnOtherListClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure actfinaliseExecute(Sender: TObject);
    procedure btnPrintDetailsClick(Sender: TObject);
    procedure DNMSpeedButton2Click(Sender: TObject);
    procedure DNMSpeedButton3Click(Sender: TObject);
    procedure actSmartOrderExecute(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);override;
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure btnworkorderClick(Sender: TObject);
  private
    allComplete:Boolean;
    IdListManufacture: TIntegerList;
    IDListFromStock: TIntegerList;
    AllRecordsValid:Boolean;
    SmartOrderId:Integer;
    SaleIDs,SaleLineIds:TIntegerList;
    fbIncludeUnScheduled :Boolean;
    //Msg:String;
    ProcCapacityPlanningWorkForm: TfmProcCapacityPlanningWork;
    ADateFrom, ADateto :TDateTime;

    Procedure SelectAll;
    (* Procedure convertSalesTomanufacture; *)
    Function NonSchedulesSelected:Boolean;
    Procedure UnSelectNonScheduled;
    Procedure ReadAllSteps(Const ProcTreeId:Integer);
    function GetSelectedSalesIdList: string;
    procedure DoManufactureAll;
    procedure SmartOrderCallback(const Sender: TBusObj; var Abort: Boolean);
    procedure MakeSmartOrder(SOID: Integer);
    procedure intBOMSalesPieceRateConf(Sender: TObject);
  Protected
    procedure IterateselectedRecordsCallback(var abort: Boolean;SelIndex:Integer);override;
    Procedure SetGridColumns;override;
  public
    Procedure RefreshQuery; Override;
  end;


implementation

uses FastFuncs, CommonFormLib,commonLib, ProcessDataUtils, BusObjSales,
  ProcCapacityPlanningObj, CommonDbLib, BaseListingForm, BaseFormForm,
  ProcessUtils,frmBarCodeManufacturing, MySQLConst, UserLockObj,
  BusObjProcess, tcConst, ManufactureLib, tcDataUtils, frmWorkOrder, BOMLib;


{$R *.dfm}
procedure TProductionJobStatusGUI.SmartOrderCallback(const Sender: TBusObj; var Abort: Boolean);
var
  Tree: TSalesLineProcTree;
begin

  if not(Sender is TSalesorderline) then exit;
  DoStepProgressbar(TSalesorderline(Sender).ProductName +' of # ' + inttostr(TSalesorderline(Sender).SaleId));
  Tree:= TSalesLineProcTree(TSalesorderline(Sender).Container.ItemByClass(TSalesLineProcTree,false));
  if Assigned(Tree) then
    if not Tree.doorder(SaleLineIds) then begin
      Abort := True;
      AllREcordsValid := False;
    end else begin
      (*if Msg <> '' Then Msg := Msg + chr(13);
      Msg := Msg +'Smart Order # ' +inttostr(Tree.SmartOrderID) + ' ->  '+ TSalesorderline(Sender).productname ;*)
      if Tree.SmartOrderID<>0 then SmartOrderId:= Tree.SmartOrderID;
    end;
end;

procedure TProductionJobStatusGUI.actSmartOrderExecute(Sender: TObject);
var
  ctr:Integer;
begin
  SaleIDs:=TIntegerList.Create;
  SaleLineIds:=TIntegerList.Create;
  SmartOrderId:= 0;
  try
    SelectedIDs('SaleId', SaleIDs , True);
    SelectedIds('SaleLineId' , SaleLineIds , true);
    if SaleIDs.Count=0 then exit;
    if SaleLineIds.count=0 then exit;
    for ctr := 0 to SaleIDs.Count-1 do begin
      MakeSmartOrder(SaleIDs[ctr]);
    end;
  finally
    Freeandnil(SaleIDs);
    FreeandNil(SaleLineIds);
  end;
  (*IterateProcNo := 7;
  IterateSelectedRecords;*)
end;

procedure TProductionJobStatusGUI.MakeSmartOrder(SOID:Integer);
var
  UserLock: TUserLock;
  SO:TSalesOrder;
begin
  inherited;
  UserLock:= TUserLock.create(Self);
  try
    Userlock.enabled := True;
    if Userlock.Lock('tblsales' ,SOID , Self.Caption) then begin
      try
        SO:= TSalesOrder.create(Self);
        try
          SO.connection := TMyDacDataConnection.create(SO);
          So.connection.Connection := GetNewMyDacConnection(Self);
          SO.Load(SOID);
          SO.InstantiateAllTrees;
          SO.SilentMode:= true;
          So.connection.BeginTransaction;
          AllREcordsValid := True;
          try
            DoShowProgressbar(SO.Lines.count , WaitMSG);
            try
              SO.Lines.Iteraterecords(SmartOrderCallback);
            finally
              DoHideProgressbar;
            end;
          finally
            if AllREcordsValid then begin
              SO.connection.CommitTransaction;
              SO.UserLock.UnlockAllCurrentInstance;

              if SmartOrderId=0 then
                MessageDlgXP_Vista('There is nothing to order in Sales order # ' +inttostr(SO.ID)+' of the lines selected', mtInformation, [mbOK], 0)
              else
                if MessageDlgXP_Vista('Smart Order # ' + inttostr(SmartOrderId) +' is created/updated for Sales Order # ' +inttostr(SO.ID) +NL +'Do you Wish to open this Smart Order?' , mtconfirmation, [mbyes,mbno], 0) = mrYes then
                  OpenERPFormModal('TSmartOrderGUI' , SmartOrderId);

            end else begin
              So.Connection.RollbackTransaction;
            end;
          end;

        finally
          Freeandnil(SO);
        end;
      finally
        Userlock.unlock('tblsales' , SOID , Self.Caption);
      end;
    end else begin
      MessageDlgXP_Vista(ReplaceStr(ReplaceStr(UserLock.LockMessage , 'Unable to update data.' , 'Unable to Create Smart Order')  , 'this record' , 'Production Sales record #' +inttostr(SOID)) ,mtWarning, [mbok],0);
    end;
  finally
    Freeandnil(UserLock);
  end;
end;

procedure TProductionJobStatusGUI.btnOtherListClick(Sender: TObject);
begin
  //inherited;
  if OpenERPListForm('TProductionJobStatusConvertedGUI') then
    Self.Close;
end;
Procedure TProductionJobStatusGUI.DoManufactureAll;
var
  UserLock: TUserLock;
  SO:TSalesOrder;
begin
  if Sysutils.SameText(qryMainProcessPartStatus.asString , PS_STR_NOTSCHEDULED) then begin
      UserLock:= TUserLock.create(Self);
      try
        Userlock.enabled := True;
        if Userlock.Lock('tblsales' ,QrymainSaleId.asInteger , Self.Caption) then begin
          try
            SO:= TSalesOrder.create(Self);
            try
              SO.connection := TMyDacDataConnection.create(SO);
              So.connection.Connection := GetNewMyDacConnection(Self);
              SO.Load(QrymainSaleId.asInteger);
              if SO is TSales then TSales(SO).InstantiateAllTrees; // load the trees to copy
              SO.SilentMode:= true;
              So.connection.BeginTransaction;
              SO.ChangePartSourceToManufacture(qryMainSaleLineId.asInteger);
              SO.PostDB;
              SO.Save;
              So.connection.CommitTransaction;
            finally
              Freeandnil(SO);
            end;
          finally
            Userlock.unlock('tblsales' , QrymainSaleId.asInteger , Self.Caption);
          end;
        end else begin
          MessageDlgXP_Vista(ReplaceStr(ReplaceStr(UserLock.LockMessage , 'Unable to update data.' , 'Unable to Manufacture')  , 'this record' , 'Production Sales record #' +inttostr(QrymainSaleID.asInteger)) ,mtWarning, [mbok],0);
        end;
      finally
        Freeandnil(UserLock);
      end;
  end else begin
        MessageDlgXP_Vista('Product ' +qryMainLineProductName.asString +' is already Scheduled/Started Building.'+chr(13) +
                'It is not possible to change the Quantities', mtWarning, [mbOK], 0);
  end;
end;
procedure TProductionJobStatusGUI.DNMSpeedButton1Click(Sender: TObject);
var
  Option:Word;
  conn :TERPConnection;
  count :Integer;
  msg: string;
  selectedIdList: string;
  UserLock: TUserLock;
begin
  inherited;
  try
        if grdmain.Selected.Count = 0 then exit;
        if NonSchedulesSelected then   begin
          (*if Commonlib.MessageDlgXP_Vista('Production Worksheet Can Be Printed for The Scheduled Items. Do You Wish To Un-Select The Non-Scheduled Items and Print the Production Work Sheet?', mtconfirmation, [mbyes, mbNo],0) = mrno then exit
          else UnSelectNonScheduled;*)
          Option := Commonlib.MessageDlgXP_Vista(  'You Have Selected Un-Scheduled Jobs.' +chr(13) +chr(13) +
                                          'Production Worksheet Prints The Scheduled Items.',
                                          mtconfirmation, [],0 , nil , '' , '' , False, nil,
                                          'Schedule,Print Only Scheduled,Include Unscheduled,Cancel');
          fbIncludeUnScheduled:= (option = 102);
          if (Option = 100) then begin
            selectedIdList:= GetSelectedSalesIdList;
            if selectedIdList = '' then begin
              MessageDlgXP_Vista('No Scheduled Job Has Been Selected.',mtInformation,[mbOk],0);
              exit;
            end;
            conn := CommonDbLib.GetNewMyDacConnection(Self);
            Try
              conn.StartTransaction;
              Try
                UserLock:= TUserLock.create(Self);
                try
                  Userlock.enabled := True;
                  if AutoScheduleProduction(msg, count, Conn, userlock, selectedIdList) then begin
                    if count > 0 then begin
                      conn.Commit;
                      RefreshQuery;
                      grdMain.UnselectAll;
                    end else
                      conn.Rollback;
                  end;
                finally
                  UserLock.Unlock(Copy(ClassName, 2, FastFuncs.Strlength(ClassName)));
                  UserLock.Unlock(Self.Caption);
                end;
              Except
                conn.Rollback;
              end;
            Finally
                Freeandnil(conn);
            end;
            Exit;
          end else if (Option = 101) or (Option = 102) then begin
             if Option <> 102 then UnSelectNonScheduled;
          end else exit;
       end;
        if grdMain.SelectedList.Count = 0 then begin
          MessageDlgXP_Vista('No Job Has Been Selected.',mtInformation,[mbOk],0);
          exit;
        end;
        ProcCapacityPlanningWorkForm:= TfmProcCapacityPlanningWork.Create(nil);
        ProcCapacityPlanningWorkForm.CallingFormname := Self.classname;
        IterateProcNo := 5;
        ADateFrom     := 0;
        ADateto       := Date;
        IterateselectedRecords;
        if ADateTo< ADatefrom then ADateTo := ADatefrom;
        if (option = 101 ) and ProcCapacityPlanningWorkForm.ProcesstepIdList.IsEmpty then begin
          MessageDlgXP_Vista('No Scheduled Job Has Been Selected.',mtInformation,[mbOk],0);
          ProcCapacityPlanningWorkForm.Free;
        end
        else begin
          ProcCapacityPlanningWorkForm.IncludeUnScheduled :=(option = 102 );
          ProcCapacityPlanningWorkForm.DateFrom := aDateFrom;
          ProcCapacityPlanningWorkForm.DateTo   := aDateTo;
          ProcCapacityPlanningWorkForm.ShowModal;
        end;
  finally
    fbIncludeUnScheduled := False;
  end;
end;

procedure TProductionJobStatusGUI.actfinaliseExecute(Sender: TObject);
var
  ConvertIncomplete:boolean;
  DoRefreshQuery:Boolean;
  msg: string;
begin
  inherited;
  DoRefreshQuery := False;
  try
    if grdmain.Selected.Count = 0 then exit;
    IterateProcNo := 1;
    allComplete := True;
    IterateselectedRecords;
    ConvertIncomplete:=False;
    if not allComplete then
         (*ConvertIncomplete:=
            MessageDlgXP_Vista('Production is Incomplete on Some of the Selected Jobs, ' +
              'Do You Wish to Finalise Them Anyway?',mtConfirmation,[mbYes,mbNo],0) = mrYes;*)

       case MessageDlgXP_Vista('Production is ''Incomplete'' or ''From Stock'' on Some of the Selected Jobs.' +chr(13)+chr(13) +
          'Do You Wish to Finalise the ''Incomplete'' Anyway?',mtConfirmation,[mbYes,mbNo,mbCancel],0) of
          mrcancel : Exit;
          mrYes:ConvertIncomplete:=True;
          else ConvertIncomplete:=False;
        end;
    IterateProcNo := 2;
    IdListManufacture:= TIntegerList.Create;
    IDListFromStock:= TIntegerlist.Create;
    try
      IterateselectedRecords;
      if IdListManufacture.count > 0 then
        if DoJobComplete(IdListManufacture,ConvertIncomplete, msg) then
          DoRefreshQuery := true;
      if IDListFromStock.count > 0 then
         if DoconvertSO(IDListFromStock) then
          DoRefreshQuery := true;
    finally
      if DoRefreshQuery then begin
        if msg <> '' then CommonLib.MessageDlgXP_Vista(msg,mtInformation,[mbOk],0);
      end else if msg <> '' then CommonLib.MessageDlgXP_Vista(msg,mtWarning,[mbOk],0);
      IdListManufacture.Free;
      IDListFromStock.Free;
    end;
  finally
      if DoRefreshQuery then
        self.RefreshQuery;
  end;
end;

procedure TProductionJobStatusGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fbRemeberIgnoreDateSelection := True;
  btnfinalise.hint := 'To Complete and Convert Selected Sales.' +chr(13) +
                      'Converted Sales will Disappear From the List.';
  fbIncludeUnScheduled:= False;
end;

function TProductionJobStatusGUI.GetSelectedSalesIdList: string;
var
  i: integer;
begin
  result:= '';
  for i := 0 to grdMain.SelectedList.Count - 1 do begin
    qryMain.GotoBookmark(grdMain.SelectedList.Items[i]);
    if result <> '' then result:= result + ',';
    result:= result + self.qryMainSaleId.AsString;
  end;
end;

procedure TProductionJobStatusGUI.btnSelectClick(Sender: TObject);
begin
  inherited;
  if Sysutils.SameText(btnSelect.caption , 'Select All')  then begin
    SelectAll;
    btnSelect.Caption := 'UnSelect';
  end else begin
    grdMain.UnselectAll;
    btnSelect.Caption := 'Select All';
  end;

end;

procedure TProductionJobStatusGUI.SelectAll;
begin
  grdMain.UnselectAll;
  qrymain.First;
  while Qrymain.eof = False do begin
    if not(Sysutils.SameText(qryMainProcessPartStatus.asString , '')) then
      grdmain.SelectRecord;
    Qrymain.Next;
  end;

end;

procedure TProductionJobStatusGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('ClientId');
  RemoveFieldfromGrid('ProductId');
end;

procedure TProductionJobStatusGUI.grdMainDblClick(Sender: TObject);
begin
  (* if (Sysutils.SameText(grdmain.getactivefield.fieldName , 'CStatus')) and
    (Sysutils.SameText(qryMainStatus.asString , 'From Stock')) then begin
    if MessageDlgXP_Vista(qryMainLineProductName.asString + ' For ' +
                        qryMainSaleCustomerName.asString +' in Sale#' +
                        qryMainSaleDocNumber.asString + ' is Taken From Stock.'+chr(13)+
                        'Do You Wish to Change It into Manufacture?' , mtconfirmation  , [mbyes, mbno] , 0) = mrno then exit;
    convertSalesTomanufacture;
    RefreshQuery;
  end else    *)if (Sysutils.SameText(grdmain.SelectedField.fieldname , qryMainLineProductName.fieldName )) or
      (Sysutils.SameText(grdmain.SelectedField.fieldname , qryMainLineQty.fieldName )) or
      (Sysutils.SameText(grdmain.SelectedField.fieldname , qryMainProcessPartStatus.fieldName )) or
      (Sysutils.SameText(grdmain.SelectedField.fieldname , qryMainLineProductDescription.fieldName )) then begin
      TfmBarCodeManufacturing.OpenForsale(qryMainSaleId.asInteger);
  end else
    inherited;
end;

procedure TProductionJobStatusGUI.grpFiltersClick(Sender: TObject);
begin
  inherited;

end;

(* procedure TProductionJobStatusGUI.convertSalesTomanufacture;
var
  SO:TSalesOrder;
begin
      SO:= TSalesOrder.create(Self);
      try
        SO.connection := TMyDacDataConnection.create(SO);
        So.connection.Connection := GetNewMyDacConnection(nil);
        SO.Load(QrymainSaleId.asInteger);
        SO.SilentMode:= true;
        So.connection.BeginTransaction;
        SO.ChangePartSourceToManufacture(qryMainSaleLineId.asInteger);
        SO.PostDB;
        SO.Save;
        So.connection.CommitTransaction;
      finally
        Freeandnil(SO);
      end;
end; *)

function TProductionJobStatusGUI.NonSchedulesSelected: Boolean;
begin
   IterateProcNo := 3;
   AllRecordsValid := true;
   IterateselectedRecords;
   Result := not AllRecordsValid;

end;

procedure TProductionJobStatusGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryMainQtyTobeInvoiced.AsFloat := qryMainLineQty.AsFloat - qryMaininvoicedQty.AsFloat;
end;

procedure TProductionJobStatusGUI.ReadAllSteps(const ProcTreeId: Integer);
begin
  With CommonDbLib.TempMyQuery do try
    SQL.add('Select SaleLineID, TimeStart, TimeEnd , ppd.ProcessStepID' +
            ' from tblProcTree ptd' +
            ' Inner JOIN tblProcessPart PPd on PPd.ProcTreeId = PTd.ProcTreeId' +
            ' where  '+ iif(fbIncludeUnScheduled , '', ' ppd.status = "psScheduled" and ')+
            ' ptd.MasterType = "mtSalesOrder"' +
            ' and (PTd.ProcTreeId = '+IntToStr(ProcTreeId) +
            ' or PTd.ParentId = '+IntToStr(ProcTreeId) + ')');

    Open;
    if recordcount = 0 then exit;
    First;
    if ADatefrom = 0 then ADatefrom :=Fieldbyname('timestart').asDAtetime ;
(*    if ADateTo = 0 then ADateTo := DAte;
    if ADateTo< ADatefrom then ADateTo := ADatefrom;*)
    while Eof = False do begin
        if Fieldbyname('timestart').asDAtetime < ADatefrom  then aDatefrom := Fieldbyname('timestart').asDatetime ;
        if Fieldbyname('TimeEnd').asDAtetime   > ADateto    then aDateto   := Fieldbyname('timeend').asDatetime ;
        if Fieldbyname('timestart').asDAtetime > aDateto    then aDateto   := Fieldbyname('timestart').asDatetime ;
        ProcCapacityPlanningWorkForm.ProcesstepIdList.AddIfNotInList(FieldByname('ProcessStepID').asInteger);
        ProcCapacityPlanningWorkForm.SaleLineIDList.AddIfNotInList  (FieldByname('SalelineId').asInteger);
        Next;
    end;
  finally
      if active then close;
      Free;
  end;
end;


procedure TProductionJobStatusGUI.UnSelectNonScheduled;
begin
 IterateProcNo := 4;
 IterateselectedRecordsReverse;

end;

procedure TProductionJobStatusGUI.IterateselectedRecordsCallback(var abort: Boolean;SelIndex:Integer);
begin
  inherited;
  if IterateProcNo = 1 then begin
    if (qryMainComplete.asBoolean =false) and (not(sameText(qryMainProcessPartStatus.asString , PS_STR_COMPLETE))) then begin
      allComplete := false;
      Abort:= true;
    end;
  end else if IterateProcNo = 2 then begin
    if Sysutils.SameText(qryMainProcessPartStatus.asString , '') then
          IDListFromStock.AddIfNotInList(QrymainSaleId.AsInteger)
    else IdListManufacture.AddIfNotInList(QrymainSaleId.AsInteger);
  end else if IterateProcNo = 3 then begin
    if Sysutils.SameText(qryMainProcessPartStatus.asString , PS_STR_NOTSCHEDULED) then begin
      AllRecordsValid:=  False;
      abort := true;
    end;
  end else if IterateProcNo = 4 then begin
    (*if qryMainCStatus.asString <> 'Scheduled' then*)
    if Sysutils.SameText(qryMainProcessPartStatus.asString , PS_STR_NOTSCHEDULED) then
      grdmain.UnselectRecord;
  end else if IterateProcNo = 5 then begin
    if (Sysutils.SameText(qryMainProcessPartStatus.asString , PS_STR_NOTSCHEDULED) or Sysutils.SameText(qryMainProcessPartStatus.asString , PS_STR_COMPLETE)) and (not(fbIncludeUnScheduled)) then
          grdmain.UnselectRecord
    else  ReadAllSteps(qryMainProcTreeId.asInteger);
  end else if IterateProcNo = 6 then begin
    DoManufactureAll;
  (*end else if IterateProcNo = 7 then begin
    MakeSmartOrder(qryMainSaleId.AsInteger);*)
  end else begin
    abort := true;
  end;
end;


procedure TProductionJobStatusGUI.btnworkorderClick(Sender: TObject);
begin
  inherited;
  if grdmain.Selectedlist.Count = 0 then begin
    MessageDlgXP_Vista('Please Select the Product', mtInformation, [mbOK], 0);
    Exit;
  end;
  if grdmain.Selectedlist.Count >1  then begin
    MessageDlgXP_Vista('Please Select only ONE Product', mtInformation, [mbOK], 0);
    Exit;
  end;
  qryMain.GotoBookmark(grdMain.SelectedList[0]);
  if sametext(QrymainProcessPartStatus.asString , PS_STR_COMPLETE) then begin
    MessageDlgXP_Vista('This Product is already completed', mtInformation, [mbOK], 0);
    Exit;
  end;
  OpenERPFormModal('TfmWorkOrder' , 0 , intBOMSalesPieceRateConf);

end;
procedure TProductionJobStatusGUI.intBOMSalesPieceRateConf(Sender: TObject);
begin
  if not (sender is TfmWorkOrder) then exit;
  TfmWorkOrder(Sender).SalesLineId := QrymainSaleLineId.asInteger;
  TfmWorkOrder(Sender).saleId := QrymainSaleId.asInteger;
end;
procedure TProductionJobStatusGUI.btnPrintDetailsClick(Sender: TObject);
var
  StrSQL:String;
  fsTablename :String;
begin
  inherited;

  if grdmain.SelectedList.count >1 then
    if CommonLib.MessageDlgXP_Vista('Multiple Jobs are Selected.' +chr(13) +
                                    'Details Can be Printed for only One Job At a time. ' +chr(13) +chr(13) +
                                    'Do you Wish to Print the Details of Currently Selected Job:' + qryMainLineProductName.asString+'?' ,
                                    mtconfirmation , [mbYes,mbNo] , 0) = mrNo then exit;

  {calculate Total quantity for the items on the tree}
  fsTablename := commondblib.GetUserTemporaryTableName('ProductDetailreport');
  StrSQL :=ProductJobDEtailsSQL(fsTablename,  qryMainSaleLineId.AsInteger,  qryMainProductId.AsInteger ,qryMainLineQty.asfloat);
  ReportSQLSupplied := True;
  PrintTemplateReport('Product Job Details' , strSQL , not(chkPreview.checked) and not(Devmode), 1);
  DeleteTable(fsTablename);
(*var
  StrSQL:String;
  fsTablename :String;
  QryProcess:TERPQuery;
  totQty:double;
  bm:TBookmark;
  function TotalQty:Double;
  begin
      if QryProcess.Locate('ProcTreeId' , QryProcess.fieldByname('ParentId').asInteger , []) then
        result := QryProcess.fieldByname('TotalQty').asfloat
      else Result := qryMainLineQty.asfloat;
  end;

begin
  inherited;

  if grdmain.SelectedList.count >1 then
    if CommonLib.MessageDlgXP_Vista('Multiple Jobs are Selected.' +chr(13) +
                                    'Details Can be Printed for only One Job At a time. ' +chr(13) +chr(13) +
                                    'Do you Wish to Print the Details of Currently Selected Job:' + qryMainLineProductName.asString+'?' ,
                                    mtconfirmation , [mbYes,mbNo] , 0) = mrNo then exit;

  {calculate Total quantity for the items on the tree}
  fsTablename := commondblib.GetUserTemporaryTableName('ProductDetailreport');
  StrSQL := 'Drop table if exists ' + fsTablename +';' +
          ' Create table ' + fsTablename +
          ' SELECT   sl.saleId, sl.SaleLineId, pt.partsID,  ptd.ProcTreeId , ptd.ParentId,ptd.SequenceDown , PT.Complete ,' +
          ' ifnull((Select group_concat(distinct ppd.Status) from tblProcTree ptd ' +
          ' Inner JOIN tblProcessPart PPd on PPd.ProcTreeId = PTd.ProcTreeId ' +
          ' where  ptd.MasterId = sl.SaleLineId and ptd.MasterType = "mtSalesOrder"  ),"From Stock")  as Status , ' +
          ' Convert(TreeNodeCaption(PT.Level, PT.caption ) ,char(255)) as Productname,' +
          ' ptd.description as Itemdescription, ' +
          ' ptd.Quantity, P.ProductionNotes ,  P.GeneralNotes   , ' +
          ' PtdP.PREFEREDSUPP ,  ' +
          ' ptd.Quantity as TotalQty ,  ' +
          ' ptd.Quantity/ptd.treepartuommultiplier as UOMTotalQty ,  ' +
          ' ptd.treepartuommultiplier as Multiplier, '+
          ' concat(ptd.treepartuom," (" , ptd.treepartuommultiplier,  ")") as uom,' +
          ' space(100) as Description,' +
          ' space(100) as uomDescription' +
          ' FROM tblSales s' +
          ' inner join  tblSalesLines sl on sl.SaleId = s.SaleId' +
          ' Inner join  tblProcTree pt on pt.MasterId = sl.SaleLineId and PT.ParentId = 0 and pt.MasterType = "mtSalesOrder"' +
          ' inner join  tblProcTree ptd on ptd.MasterId = sl.SaleLineId and PTd.ParentId <> 0 and ptd.MasterType = "mtSalesOrder"  and ptd.Quantity <> 0' +
          ' Left join tblParts PtdP on PtdP.PartsId = ptd.PartsId' +
          ' inner join tblParts P on P.PartsId = Sl.ProductID' +
          ' Inner join tblparttypes PAT on PAT.typeCode = P.PartType' +
          ' Where SL.SaleLineId = ' +IntToStr(QrymainSaleLineId.asInteger) +
          ' order by ptd.SequenceDown';
  ExecuteSQL(strSQL);
  QryProcess:= CommonDbLib.TempMyQuery;
  Try
    QryProcess.SQL.add('select * from ' +fsTablename +' order by SequenceDown');
    QryProcess.open;
    if QryProcess.recordcount > 0 then begin
        QryProcess.First;
        While QryProcess.Eof = False do begin
          bm := QryProcess.GetBookmark;
          try
            totQty :=TotalQty;
          finally
              QryProcess.GotoBookmark(bm);
              QryProcess.FreeBookmark(bm);
          end;
          EditDB(QryProcess);
          QryProcess.FieldByName('TotalQty').asFloat    := totQty *QryProcess.FieldByName('Quantity').asFloat;
          QryProcess.FieldByName('UOMTotalQty').asFloat := divzer( QryProcess.FieldByName('TotalQty').asFloat , QryProcess.FieldByName('Multiplier').asFloat);
          QryProcess.FieldByName('Description').asString    := FloatToStrF(QryProcess.FieldByName('Quantity').asFloat    , ffnumber ,15,5 ) +' X ' + FloatToStrF(totQty , ffnumber ,15,5 );
          QryProcess.FieldByName('UOMDescription').asString := FloatToStrF(DivZer(QryProcess.FieldByName('Quantity').asFloat , QryProcess.FieldByName('Multiplier').asFloat) , ffnumber ,15,5 )+ ' ' + QryProcess.FieldByName('uom').asString  +' X ' + FloatToStrF(totQty  , ffnumber ,15,5 );
          PostDB(QryProcess);
          QryProcess.Next;
        end;
    end;
  finally
      if QryProcess.active then QryProcess.close;      FreeandNil(QryProcess);
  end;

  {Report SQL}
  strSQL:= '{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, ' +
          ' CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, ' +
          ' Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO' ;
  strSQL:= strSQL+ ' ~|||~{Details} '+
          ' Select T.* , PP.partPic from ' + fstablename +' T Left  join tblpartspics PP on T.partsID = PP.partID and PP.isDefault ="T" ';
  strSQL:= strSQL+ ' ~|||~{Manufacture}' +
          ' SELECT  PAT.typeDESC as PartType, s.SaleId, s.InvoiceDocNumber as SaleDocNumber, ' +
          ' s.CustomerName as SaleCustomerName, s.ClassId as SaleClassId, ' +
          ' s.ShipDate as SaleShipDate, s.SaleDate,S.ShipTo , s.InvoiceTo, ' +
          ' S.PickupFrom, sl.SaleLineId, sl.ProductName as LineProductName, ' +
          ' sl.Product_Description as LineProductDescription, ' +
          ' sl.UnitOfMeasureShipped as LineQty, sl.ShipDate as LineShipDate,' +
          ' P.ProductionNotes ,  P.GeneralNotes' +
          ' FROM tblSales s' +
          ' inner join  tblSalesLines sl on sl.SaleId = s.SaleId' +
          ' inner join tblParts P on P.PartsId = Sl.ProductID' +
          ' Inner join tblparttypes PAT on PAT.typeCode = P.PartType' +
          ' Where SL.SaleLineId = ' +IntToStr(QrymainSaleLineId.asInteger) ;
  strSQL:= strSQL+ ' ~|||~{Notes}' +
          ' Select Notes  from tblPartsNotes PN  where PN.active = "T"' +
          ' AND PN.PartsID = ' + IntToStr(QrymainProductID.asInteger);
  strSQL:= strSQL+ ' ~|||~{Allocation}Select PBin.Binlocation, PBin.binnumber,PQABatch.Value as batchno, ' +
          ' PQABatch.ExpiryDate, if(ifnull(PQASN.PQADEtailID,0)<>0 , PQASN.UOMQty ,' +
          ' if (ifnull(PQABins.PQADEtailID,0)<>0 , PQABins.UOMQty , PQABatch.UOMQty)) as Qty,' +
          ' PQASN.Value' +
          ' From  tblSaleslines SL' +
          ' inner join tblParts P  on SL.ProductId = P.PartsId' +
          ' inner join tblPQA PQA on PQa.TransId = SL.SaleId ' +
          ' and PQA.TransLineId = SL.SaleLineId and PQa.Transtype in ("TInvoiceLine" , "TSalesOrderline")' +
          ' left join tblPqaDetails PQABatch  on PQABatch.PQAId 	= PQA.PQAID and PQABatch.PQAType = "Batch"  ' +
          ' and PQABatch.Active= "T"' +
          ' left join tblPqaDetails PQABins  on PQABins.PQAId 	= PQA.PQAID' +
          ' and PQABins.PQAType = "Bin" and PQABins.Active = "T" and' +
          ' ((PQABatch.globalref = IFNULL(PQABins.ParentRef,"") and P.Batch="T"' +
          ' and P.multiplebins = "T") or (ifnull(PQABins.Parentref ,"") = "" AND P.Batch="F" and P.multiplebins = "T"))' +
          ' Left join tblProductBin PBin     on PBin.binId 	= PQABins.BinID' +
          ' left join tblPqaDetails PQASN    on (PQASN.PQAId 	= PQA.PQAID and PQASN.PQAType = "SN"   and PQASN.Active = "T"' +
          ' and ((PQABatch.globalref = IFNULL(PQASN.ParentRef,"") and P.Batch="T" and P.multiplebins = "F" and P.SNTracking = "T")' +
          ' or (PQAbins.Globalref = IFNULL(PQASn.ParentRef,"") and P.Multiplebins = "T" and P.SNTracking = "T") or' +
          ' (ifnull(PQASN.Parentref ,"") = "") and P.Batch="F" and P.Multiplebins = "F" and P.SNTracking = "T" ))' +
          ' Where SL.SaleLineId = ' +IntToStr(QrymainSaleLineId.asInteger) ;
  ReportSQLSupplied := True;
  PrintTemplateReport('Product Job Details' , strSQL , not(chkPreview.checked) and not(Devmode), 1);
  DeleteTable(fsTablename);*)
end;

procedure TProductionJobStatusGUI.DNMSpeedButton2Click(Sender: TObject);
begin
  inherited;
    IterateProcNo := 6;
    IterateselectedRecords(True , 'Updating Sales Orders to Manufacture');
    RefreshQuery;
end;

procedure TProductionJobStatusGUI.DNMSpeedButton3Click(Sender: TObject);
var
  conn :TERPConnection;
  msg:String;
  count :Integer;
  selectedIdList: string;
  UserLock: TUserLock;
begin
      selectedIdList:= GetSelectedSalesIdList;
      if selectedIdList = '' then begin
        MessageDlgXP_Vista('No Job Has Been Selected.',mtInformation,[mbOk],0);
        exit;
      end;
      conn := CommonDbLib.GetNewMyDacConnection(Self);
      Try
        conn.StartTransaction;
        Try
          UserLock:= TUserLock.create(Self);
          try
            Userlock.enabled := True;
            if AutoScheduleProduction(msg, count, Conn, Userlock, GetSelectedSalesIdList) then begin
              if count > 0 then begin
                conn.Commit;
                RefreshQuery;
                grdMain.UnselectAll;
              end else
                conn.Rollback;
            end;
          finally
            UserLock.Unlock(Copy(ClassName, 2, FastFuncs.Strlength(ClassName)));
            UserLock.Unlock(Self.Caption);
          end;
        Except
          conn.Rollback;
        end;
      Finally
          Freeandnil(conn);
      end;
end;

procedure TProductionJobStatusGUI.RefreshQuery;
var s:STring;
  function OrderProcessStatus:String;
  begin
    REsult := 'if(ppd.status = "psComplete" , 1 , ' +
                ' if(ppd.status = "psScheduled" , 2, ' +
                ' if(ppd.status = "psStarted" ,3 , ' +
                ' if(ppd.status = "psnotScheduled" , 4, ' +
                ' if(ppd.stats ="psQualityAssurance" , 5, 6) ))))';
  end;
begin
  Processingcursor(True);
  try
     CloseDB(Qrymain);
     DestroyUserTemporaryTable(tablename);
     s:= 'create table '+tablename +'  '+
          'SELECT  S.clientID as clientID,' +
          ' 1 as Details ,' +
          ' SL.ProductId as ProductId,' +
          ' s.SaleId as SaleId,' +
          ' s.InvoiceDocNumber as SaleDocNumber,' +
          ' s.CustomerName as SaleCustomerName,' +
          ' s.ClassId as SaleClassId,' +
          ' s.ShipDate as SaleShipDate,' +
          ' s.SaleDate as SaleDate,' +
          ' sl.SaleLineId as SaleLineId,' +
          ' sl.ProductName as LineProductName,' +
          ' sl.Product_Description as LineProductDescription,' +
          ' sl.UnitOfMeasureShipped as LineQty,' +
          '(Select sum(SOIL.uomQty) from tblsalesOrderInvoices SOI inner join tblsalesOrderInvoiceLines SOIL on SOIL.SOInvoiceID = SOI.SOINvoiceID   where S.saleId = SOI.salesorderID  and SOIL.SalesorderLineID = SL.SaleLineID) as invoicedQty,' +
          ' sl.ShipDate as LineShipDate,' +
          ' pt.ProcTreeId as ProcTreeId,' +
          ' PT.Complete as Complete,' +
          'PT.FromStockUOMQty,'+
          'PT.ManufactureUOMQty,'+
          'PT.OnOrderUOMQty,'+
          ' ProcessStatus(SL.SaleLineID) as ProcessPartStatus ' +
          ' FROM  tblSales s' +
          ' inner join  tblSalesLines sl on sl.SaleId = s.SaleId' +
          ' inner join  tblProcTree pt on pt.MasterId = sl.SaleLineId and PT.ParentId = 0 and pt.MasterType = "mtSalesOrder" and PT.ManufactureQty<>0' +
          ' where  s.SaleDate between '+Quotedstr(FormatDateTime(MysqlDateFormat , FilterDateFrom)) +
          ' AND '+Quotedstr(FormatDateTime(MysqlDateFormat , FilterDateTo)) +' and S.converted = "F"' +
          ' and  (SL.BOMProductionLine ="T" or SL.BOMGroupedLine="F")';
     ExecuteSQL(s);
  inherited;
  finally
    Processingcursor(False);
  end;
end;

initialization
  RegisterClassOnce(TProductionJobStatusGUI);

end.
