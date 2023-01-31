unit ApprovalCheckObj;

interface

uses wwdblook, wwcheckbox, Busobjbase, classes, StdCtrls, AdvMenus;

Type

  TApprovalcheck = record
    checkApproved :Twwcheckbox;
    checkboxclickEvent: TNotifyEvent;
    TransType:String;
    Busobj :TDatasetBusObj;
    AmtName:String;
    Approvercombo :TwwDBLookupcombo;
  end;

  TApprovalcheckObj = Class(TComponent)
    Private
    fApprovalcheckObj       : TApprovalcheck;
    fbOncheckApprovedclick :Boolean;
    popApprovers: TAdvPopupMenu;
    function IsAllApproved(aApprovalcheck: TApprovalcheck): Boolean;
    procedure UnApproveTrans(aApprovalcheck: TApprovalcheck);
(*    procedure ApproverClick(Sender: TObject);*)
    Protected
    Public
      Constructor Create(AOwner:TComponent);Override;
      Destructor Destroy;override;
      procedure OncheckApprovedclick(Sender: TObject);
      procedure AddcheckBox(acheckApproved: TwwCheckBox; aTranstype:String; aBusobj:TDatasetBusObj; aAmtName:String;AssignOnclick :Boolean = False;aApprovercombo :TwwDBLookupcombo =nil; aApproverlbl:TLabel = nil; aApprovernotify : Twwcheckbox = nil);
      Procedure OnTransApproverIDChange(aBusobj:TDatasetBusObj);
    Published
  End;
implementation

uses sysutils, ObjectStorer, BusObjApprovals, AppEnvironment, frmTransApproval,
  ERPdbComponents, BaseInputForm, CommonDbLib, TypInfo, DbSharedObjectsObj,
  EmployeeAccesses, menus;

constructor TApprovalcheckObj.Create(AOwner: TComponent);
begin
  inherited;
      fApprovalcheckObj.checkApproved    := nil;
      fApprovalcheckObj.Transtype        := '';
      fApprovalcheckObj.Busobj           := nil;
      fApprovalcheckObj.AmtName          := '';
      fApprovalcheckObj.Approvercombo    := nil;
      //popApprovers.onpopup := ApproverClick;
end;
destructor TApprovalcheckObj.Destroy;
begin
  Freeandnil(popApprovers);
  inherited;
end;

(*Procedure TApprovalcheckObj.ApproverClick(Sender:TObject);
var
  Qry :TERPQuery;
  NewItem :TMenuItem;
begin
   popApprovers.Items.Clear;
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(fApprovalcheckObj.Busobj.Connection.Connection);
  try
    qry.SQL.TExt:= 'SELECT E.employeename , TS.approved '+
                    ' FROM tbltransapprovals TS INNER JOIN tblemployees E ON TS.employeeId = E.EmployeeId '+
                    ' WHERE TS.transtype ='+quotedstr(fApprovalcheckObj.transtype)+
                    ' AND TS.transid = '+inttostr(fApprovalcheckObj.Busobj.id)+' AND approved ="T"';
    qry.open;
    if qry.recordcount >0 then begin
          NewItem         := TMenuItem.Create(popApprovers);
          NewItem.Caption := 'Approver(s)';
          popApprovers.Items.Add( NewItem);
      qry.first;
      While qry.EOF = False do begin
          NewItem         := TMenuItem.Create(popApprovers);
          NewItem.Caption := '  -> ' +Qry.FieldByName('employeename').asString;
          popApprovers.Items.Add( NewItem);
          qry.Next;
      end;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;

end;*)
Procedure TApprovalcheckObj.AddcheckBox(acheckApproved: TwwCheckBox; aTranstype:String; aBusobj:TDatasetBusObj; aAmtName:String;AssignOnclick :Boolean = False;aApprovercombo :TwwDBLookupcombo =nil; aApproverlbl:TLabel = nil; aApprovernotify : Twwcheckbox = nil);
var
    NewItem :TMenuItem;
begin
      fApprovalcheckObj.checkApproved    := acheckApproved;
      fApprovalcheckObj.checkboxclickEvent := acheckApproved.onclick;
      fApprovalcheckObj.Transtype        := aTranstype;
      fApprovalcheckObj.Busobj           := aBusobj;
      fApprovalcheckObj.AmtName          := aAmtName;
      fApprovalcheckObj.Approvercombo    := aApprovercombo;

      If Not Appenv.CompanyPrefs.UseApprovalLevels Then acheckApproved.visible := false
      Else If not(CanApproveTran) then acheckApproved.Enabled                  := false;

       if Appenv.CompanyPrefs.UseSteppedApproval then begin
          if aApprovercombo <> nil then aApprovercombo.Visible := False;
          if aApproverlbl   <> nil then aApproverlbl.Visible := False;
          if aApprovernotify<> nil then aApprovernotify.Visible := False;
       end;

      if AssignOnclick then begin
        acheckApproved.OnClick := OncheckApprovedclick;
      end;
      if Appenv.CompanyPrefs.UseSteppedApproval or Appenv.CompanyPrefs.UseSinglePersonApproval then begin
        fbOncheckApprovedclick := False;
        popApprovers:= TAdvPopupMenu.create(self);
        popApprovers.Version := '2.5.3.4';
        NewItem         := TMenuItem.Create(popApprovers);
        NewItem.Caption := 'Approvers';
        NewItem.onclick := OncheckApprovedclick;
        popApprovers.Items.Add( NewItem);
        if acheckApproved <> nil then acheckApproved.popupmenu := popApprovers;
        if aApprovercombo <> nil then aApprovercombo.popupmenu := popApprovers;
      end;
end;
Function TApprovalcheckObj.IsAllApproved(aApprovalcheck :TApprovalcheck):Boolean;
var
  TransApprovals :TTransApprovals;
begin
  REsult := False;
  if appenv.companyprefs.UseSteppedApproval or appenv.companyprefs.UseSinglePersonApproval then begin
    TransApprovals := TTransApprovals.InitTrans(aApprovalcheck.TransType,aApprovalcheck.Busobj,TypInfo.GetFloatProp(aApprovalcheck.Busobj, aApprovalcheck.AmtName));
    if aApprovalcheck.Approvercombo <> nil then
          try TransApprovals.TransApproverID := aApprovalcheck.Approvercombo.datasource.dataset.findfield(aApprovalcheck.Approvercombo.datafield).asInteger; Except end;
    if TfmTransApproval.ApproveTrans(TBaseInputGUI(Self.Owner),TransApprovals,TypInfo.GetFloatProp(aApprovalcheck.Busobj, aApprovalcheck.AmtName), fApprovalcheckObj) then result := True;
  end else begin
    result :=  True;
  end;
end;
procedure TApprovalcheckObj.UnApproveTrans(aApprovalcheck:TApprovalcheck);
var
  sct :TERPScript;
begin
  if not AppEnv.CompanyPrefs.UseApprovalLevels then exit;
  if appenv.companyprefs.UseSinglePersonApproval then
  if aApprovalcheck.TransType = '' then exit;
    sct :=aApprovalcheck.Busobj.getSharedScript('update  tbltransapprovals TA Set Approved ="F" WHERE  TA.TransType = '+Quotedstr(aApprovalcheck.TransType)+' AND TA.TransID = '+inttostr(aApprovalcheck.Busobj.ID)+' AND approved ="T"', true);
    Try
      sct.Execute;
    finally
      DbSharedObj.ReleaseObj(sct);
    end;
    if aApprovalcheck.Approvercombo <> nil then
    if aApprovalcheck.Busobj.dataset.findfield(aApprovalcheck.Approvercombo.datafield) <> nil then begin
        EditDB(aApprovalcheck.Busobj.dataset);
        aApprovalcheck.Busobj.dataset.FieldByName(aApprovalcheck.Approvercombo.datafield).asInteger := 0;
        PostDB(aApprovalcheck.Busobj.dataset);
    end;
end;

procedure TApprovalcheckObj.OncheckApprovedclick(Sender:TObject);
begin
  if fbOncheckApprovedclick then Exit;
  fbOncheckApprovedclick:= true;
  try
      if (fApprovalcheckObj.checkApproved.Focused) or (Sender is TMenuItem) then begin
        //if fApprovalcheckObj.checkApproved =TwwCheckbox(Sender) then begin
          if fApprovalcheckObj.checkApproved.Checked or (Sender is TMenuItem)  then begin
            if not IsAllApproved(fApprovalcheckObj) then begin
              fApprovalcheckObj.Busobj.ResultStatus.AddItem(False, rssWarning, 0 , fApprovalcheckObj.TransType+'-> Stepped Approval Enabled and Not All Employees have Approved the Transaction' );
              fApprovalcheckObj.checkApproved.Checked :=  false;
              EditDB(fApprovalcheckObj.checkApproved.datasource.dataset);
                fApprovalcheckObj.checkApproved.datasource.dataset.FieldByName(fApprovalcheckObj.checkApproved.datafield).asBoolean:= False;
              if assigned(fApprovalcheckObj.Approvercombo) then
                fApprovalcheckObj.checkApproved.datasource.dataset.FieldByName(fApprovalcheckObj.Approvercombo.datafield).asInteger := 0;
              PostDB(fApprovalcheckObj.checkApproved.datasource.dataset);
            end else begin
              fApprovalcheckObj.checkApproved.Checked :=  True;
            end;
          end else begin
            UnApproveTrans(fApprovalcheckObj);
          end;
          try
            EditDB(fApprovalcheckObj.checkApproved.DataSource.DataSet);
            fApprovalcheckObj.checkApproved.DataSource.DataSet.FieldByName(fApprovalcheckObj.checkApproved.DataField).AsBoolean := fApprovalcheckObj.checkApproved.Checked;
            PostDB(fApprovalcheckObj.checkApproved.DataSource.DataSet);
          Except
          end;
        //end;
      end;
  finally
    if assigned(fApprovalcheckObj.checkboxclickEvent) then
      fApprovalcheckObj.checkboxclickEvent(Sender);
    fbOncheckApprovedclick := False;
  end;
end;

procedure TApprovalcheckObj.OnTransApproverIDChange(aBusobj: TDatasetBusObj);
var
  TransApprovals :TTransApprovals;
  fiTransApproverID:Integer;
begin
  if appenv.companyprefs.UseSinglePersonApproval then begin
    try
      fiTransApproverID:= fApprovalcheckObj.Approvercombo.datasource.dataset.findfield(fApprovalcheckObj.Approvercombo.datafield).asInteger;
      if (fApprovalcheckObj.Approvercombo <> nil) and (fiTransApproverID<>0) then begin
            TransApprovals := TTransApprovals.InitTrans(fApprovalcheckObj.TransType,fApprovalcheckObj.Busobj,TypInfo.GetFloatProp(fApprovalcheckObj.Busobj, fApprovalcheckObj.AmtName) , fiTransApproverID);
            TransApprovals.TransApproverID := fiTransApproverID;
            if fiTransApproverID <> 0 then
              if fApprovalcheckObj.checkApproved<> nil then begin
                fApprovalcheckObj.checkApproved.datasource.dataset.findfield(fApprovalcheckObj.checkApproved.datafield).asBoolean := True;
                fApprovalcheckObj.Busobj.PostDB;
              end;
      end;
    Except

    end;
  end;
end;

end.
