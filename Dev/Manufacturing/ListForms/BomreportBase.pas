unit BomreportBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, StdCtrls, Buttons, Wwdbigrd,
  Grids, Wwdbgrid, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader , IntegerListObj,
  DNMAction,BusObjProcess, BusObjSales,  BusObjBase, wwcheckbox, CustomInputBox,
  wwclearbuttongroup, wwradiogroup;

type
  TBomreportBaseGUI = class(TBaseListingGUI)
    btnSO: TDNMSpeedButton;
    ActionList1: TActionList;
    actSmartOrder: TDNMAction;
    actUnGroup: TDNMAction;
    procedure actSmartOrderExecute(Sender: TObject);
  private

  Protected
    SaleIds:TIntegerList;
    ProctreeIDs:TIntegerList;
    SmartOrderId:Integer;
    AllREcordsValid:Boolean;
    function TeeRootID: Integer;virtual;

    procedure DoOrder(SOID: Integer);virtual;
    procedure SmartOrderCallback(const Sender: TBusObj; var Abort: Boolean);virtual;
    Function OpenProductTree(const SaleLine :TSalesorderline ; const iTreeRootID:Integer;salerecLocked:Boolean =False):Boolean;Overload;virtual;
    Function OpenProductTree(const iSaleID, iTreeRootID:Integer;salerecLocked:Boolean =False):Boolean;Overload;virtual;
    function ProcTree(const SaleLine: TSalesorderline): TSalesLineProcTree;virtual;
  public
    { Public declarations }
  end;

implementation

uses tcConst, UserLockObj, CommonDbLib, CommonLib,
  CommonFormLib, AppEnvironment, frmProcTreeEdit, TreeFrame;

{$R *.dfm}

procedure TBomreportBaseGUI.actSmartOrderExecute(Sender: TObject);
var
  ctr:Integer;
begin
  inherited;
  if grdmain.Selected.Count =0 then exit;

  SaleIds:=TIntegerList.Create;
  ProctreeIDs:=TIntegerList.Create;
  SmartOrderId:= 0;
  try
    SelectedIDs('SaleID' , SaleIDs, true );
    SelectedIDs('ProctreeID' ,ProctreeIDs ,  true);
    if SaleIDs.Count =0 then exit;
    if ProctreeIDs.Count =0 then exit;
    DoShowProgressbar(SaleIds.Count , WAITMSG);
    try
      for ctr:= 0 to SaleIds.Count -1 do begin
        DoOrder(saleIDs[ctr]);
        DoStepProgressbar;
      end;
    finally
      DoHideProgressbar
    end;
  finally
    Freeandnil(SaleIds);
    Freeandnil(ProctreeIDs);
  end;
end;
procedure TBomreportBaseGUI.DoOrder(SOID :Integer);
var
  UserLock: TUserLock;
  SO:TSalesOrder;
  AnySocreated:Boolean;
begin
  inherited;
    AnySocreated:=False;
    try
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
                SO.Lines.Iteraterecords(SmartOrderCallback);
              finally
                if AllREcordsValid then begin
                  SO.connection.CommitTransaction;
                  if SmartOrderId>0 then begin
                    if MessageDlgXP_Vista('Smart Order # ' + inttostr(SmartOrderId) +' is created/updated for Sales Order # ' +inttostr(SO.ID) +NL +'Do you Wish to open this Smart Order?' , mtconfirmation, [mbyes,mbno], 0) = mrYes then
                      OpenERPFormModal('TSmartOrderGUI' , SmartOrderId);
                    AnySocreated:=true;
                  end;
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
    finally
      if AnySocreated = False then
        MessageDlgXP_Vista('Selected records of Sales Order #' + inttostr(SOID) +' have nothing to Order' ,mtWarning, [mbok],0);
    end;

end;
procedure TBomreportBaseGUI.SmartOrderCallback(const Sender: TBusObj; var Abort: Boolean);
var
  Tree: TSalesLineProcTree;
  TreeSaved:Boolean;
begin
  if not(Sender is TSalesorderline) then exit;

  TreeSaved:= False;
  if Qrymain.Locate('SaleLineId' , TSalesorderline(Sender).ID , [] ) then begin
    Tree:= TSalesLineProcTree(TSalesorderline(Sender).Container.ItemByClass(TSalesLineProcTree,false));
    if Assigned(Tree) and (Tree.HasOnOrderQty) then begin
          if Assigned(TSalesLineProcTree(TSalesorderline(Sender).Container.ItemByClass(TSalesLineProcTree,false))) then
            if Appenv.companyprefs.OpenTreeOnSmartOrdercreation then
               TreeSaved:= OpenProductTree(TSalesorderline(Sender) , (*TSalesLineProcTree(TSalesorderline(Sender).Container.ItemByClass(TSalesLineProcTree,false)).RootNode.Id*)TeeRootID , True);

          Tree.Load(TSalesLineProcTree(TSalesorderline(Sender).Container.ItemByClass(TSalesLineProcTree,false)).RootNode.Id);

          if not (TreeSaved) then begin
              if not Tree.doorder(nil,ProctreeIDs) then begin
                Abort := True;
                AllREcordsValid := False;
              end else begin
                if Tree.SmartOrderID<> 0 then
                  SmartOrderId:= Tree.SmartOrderID
                else
                  SmartOrderId:= 0;
              end;
          end else begin
            if not Tree.doorder(nil,ProctreeIDs) then begin
              Abort := True;
              AllREcordsValid := False;
            end else begin
              if Tree.SmartOrderID<> 0 then
                SmartOrderId:= Tree.SmartOrderID;
            end;
          end;
    end;
  end;
end;
function TBOMReportBaseGUI.TeeRootID:Integer;
begin
  result:=0;
  if  qryMain.findfield('TreeRootID') <> nil then
     result:= qryMain.FieldByname('TreeRootID').asInteger;
end;
function TBomreportBaseGUI.OpenProductTree(const iSaleID, iTreeRootID: Integer;salerecLocked: Boolean): Boolean;
var
  SO:TSalesOrder;
begin
  REsult := False;
  inherited;
  SO:= TSalesOrder.create(Self);
  try
    SO.connection := TMyDacDataConnection.create(SO);
    So.connection.Connection := GetNewMyDacConnection(Self);
    SO.Load(iSaleID);
    if SO is TSales then TSales(SO).InstantiateAllTrees;
    SO.SilentMode:= true;
    So.connection.BeginTransaction;
    if SO.Lines.Locate('SaleLineId' , Qrymain.FieldByName('SaleLineId').AsInteger, []) then begin
      OpenProductTree(SO.Lines, iTreeRootID  , salerecLocked);
      REsult := True;
    end;
  finally
    Freeandnil(SO);
  end;
end;
function TBomreportBaseGUI.ProcTree(  const SaleLine: TSalesorderline): TSalesLineProcTree;
begin
  result:= TSalesLineProcTree(SaleLine.Container.ItemByClass(TSalesLineProcTree));
end;

function TBomreportBaseGUI.OpenProductTree(const SaleLine :TSalesorderline ; const iTreeRootID:Integer;salerecLocked:Boolean =False):Boolean;
var
  TreeForm: TfmProcTreeEdit;
  SalesRecLocked:Boolean;
begin
  SalesRecLocked:= False;
  inherited;
  TreeForm:= TfmProcTreeEdit.Create(self);
  try
    { does not use this but set here to stop "read-only" message from poping up }
    TreeForm.KeyID:= 1;
    { need all of the following to allow editing and saving of Info column in tree }
    TreeForm.Tree.TreeNodeRoot := ProcTree(SaleLine);
    TreeForm.TransConnection:= TreeForm.MyConnection;
    TreeForm.TransConnection.Connect;
    TreeForm.TransConnection.StartTransaction;
    TreeForm.Tree.TransConnection:= TreeForm.TransConnection;
    TreeForm.Tree.ProcessTreeID:= iTreeRootID;
    TreeForm.Tree.TreeMode:= tminput ;
    TreeForm.Tree.vstProcessPart.Visible:= true;

    if (salerecLocked =False ) then
      if (not(Userlock.Lock('tblsales' ,SaleLine.SaleID , Self.Caption))) then begin
        TreeForm.AccessLevel:= 5;
      end else begin
        SalesRecLocked:= True;
      end;
    TreeForm.ShowModal;
    result := TreeForm.Modalresult = mrOK;
  finally
    if SalesRecLocked then
      Userlock.unLock('tblsales' ,SaleLine.SaleID , Self.Caption);
    TreeForm.Free;
  end;
end;
end.

