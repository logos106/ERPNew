unit frmTransApproval;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjApprovals, ActnList, Grids, Wwdbigrd, Wwdbgrid, BusObjBase,ApprovalCheckObj;

type
  TfmTransApproval = class(TBaseInputGUI)
    Actionlist: TActionList;
    dsApprovalList: TDataSource;
    qryApprovalList: TERPQuery;
    qryApprovalListALID: TIntegerField;
    qryApprovalListApprovalType: TWideStringField;
    qryApprovalListEmployeeID: TIntegerField;
    qryApprovalListEmployeeName: TWideStringField;
    qryApprovalListValueFrom: TFloatField;
    qryApprovalListValueTo: TFloatField;
    qryApprovalListValueLeeway: TFloatField;
    qryApprovalListEnteredByEmployeeName: TWideStringField;
    qryApprovalListTransType: TWideStringField;
    qryApprovalListTransID: TIntegerField;
    qryApprovalListApproved: TWideStringField;
    qryApprovalListApprovedOn: TDateTimeField;
    qryApprovalListApprovedby: TWideStringField;
    qryApprovalListTAID: TIntegerField;
    qryApprovalListApprovedbyID: TIntegerField;
    qryApprovalListCanApprove: TWideStringField;
    qryApprovalListApprovalOrder: TLargeintField;
    pnlMain: TDNMPanel;
    pnlDetails: TDNMPanel;
    lblTimerMsg: TLabel;
    grdmain: TwwDBGrid;
    pnlBottom: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    btnApprove: TDNMSpeedButton;
    Shbox: TShape;
    lblcheckPref: TLabel;
    Shape1: TShape;
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdmainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure btnApproveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdmainDblClick(Sender: TObject);
    procedure lblcheckPrefClick(Sender: TObject);
    procedure qryApprovalListApprovedChange(Sender: TField);
  private
    fTransApprovals: TTransApprovals;
    fdTotalAmount: double;
    fiNextToApprove:Integer;
    fbIsAllApproved:Boolean;
    fbIsAanyApproved:Boolean;
    fbIsToOpenPreferanceonClose: boolean;
    fApprovalcheckObj       : TApprovalcheck;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    function SaveRecord: Boolean;
    procedure SetTransApprovals(const Value: TTransApprovals);
    function DoApprove: boolean;
    procedure InitGrid;
    function IsApproved: Boolean;
    procedure IsApprovedCallback(const Sender: TBusObj; var Abort: Boolean);
    procedure Initform;
    Function DoApproveCurrent:boolean;
    procedure UndoApprove(ExceptID: Integer);
    procedure UndoDoApproveCallbak(const Sender: TBusObj; var Abort: Boolean);
    function CurrentRecEmployeename: String;
    procedure CheckforApprover;

    procedure UnApproveGridCurrentRecordCallback(const Sender: TBusObj;var Abort: Boolean);
    procedure UnApproveGridCurrentRecord;
  Protected
  public
    Property TransApprovals : TTransApprovals read fTransApprovals write SetTransApprovals;
    Property TotalAmount : double read fdTotalAmount write fdTotalAmount;
    Class Function  ApproveTrans(AOwner:TBaseInputGUI;aTransApprovals :TTransApprovals; aTotalAmount :double; aApprovalcheckObj: TApprovalcheck):Boolean;
    Property IsToOpenPreferanceonClose : boolean read fbIsToOpenPreferanceonClose;
  end;


implementation

uses CommonLib, BusObjConst, AppEnvironment, AppEnvVirtualObj, tcConst, LogLib;

{$R *.dfm}

procedure TfmTransApproval.cmdCancelClick(Sender: TObject);
begin
  inherited;
  //Self.Close;
end;

Function TfmTransApproval.SaveRecord :Boolean;
begin
  result:= False;
  fTransApprovals.PostDB;
  if not(fTransApprovals.Save) then exit;
  Result:= True;
end;


procedure TfmTransApproval.SetTransApprovals(const Value: TTransApprovals);
begin
  fTransApprovals := Value;
end;

procedure TfmTransApproval.grdmainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
      if qryApprovalListEmployeeid.asInteger =Appenv.employee.employeeId  then begin
        ABrush.color := $00FFFF80;//clwhite; //Current User
      end else if (fiNextToApprove>0) and (fiNextToApprove = qryApprovalListTAID.asinteger) then begin
        ABrush.color := $00B3FFB3;//$00D9FFD9; // next one to approve
      end else if not(qryApprovalListCanApprove.asBoolean) then begin
        ABrush.color := clWhite; Afont.color := clgray; // not allowed to approve
      end else begin
        ABrush.color := $00CCFFFF; // allow to approve
      end;
      if (qryApprovalListCanApprove.asBoolean = False) and sametext(Field.fieldname ,qryApprovalListApprovalOrder.fieldname) then Afont.color := aBrush.color
end;

Procedure TfmTransApproval.UndoDoApproveCallbak(const Sender: TBusObj; var Abort: Boolean);
begin
  if TransApprovals.Approved then begin
    TransApprovals.Approved := False;
    TransApprovals.PostDB;
    CheckforApprover;
  end;
end;
Function  TfmTransApproval.CurrentRecEmployeename:String;
begin
  if qryApprovalListEmployeeId.asInteger = appenv.employee.EmployeeId then Result := 'You'
  else Result := qryApprovalListEmployeeName.asString;
end;

Function TfmTransApproval.DoApproveCurrent:Boolean;
begin
          Result := False;
          if TransApprovals.Locate('ID' , qryApprovalListTAID.asInteger , []) then begin
             if not Appenv.companyprefs.UseSteppedApproval then TransApprovals.Iteraterecords(UndoDoApproveCallbak);
              TransApprovals.Approved := true;
              TransApprovals.PostDB;
              CheckforApprover;
              closeDb(qryApprovalList);
              opendb(qryApprovalList);
              qryApprovalList.locate('TAID' , TransApprovals.ID , []);
              REsult := True;
              lbltimerMsg.caption :=  CurrentRecEmployeename + ' have Approved This ' + TransApprovals.Transtype+ '.  Please Choose Save to Approve Or Cancel to Ignore.' ;
          end;
end;
procedure TfmTransApproval.grdmainDblClick(Sender: TObject);
var
  bm:TBookmark;
begin
  inherited;
  qryApprovalList.disablecontrols;
  try
      bm:= qryApprovalList.getbookmark;
      try
        if Appenv.companyprefs.UseSteppedApproval then begin
          if (qryApprovalListEmployeeid.asInteger <>Appenv.employee.employeeId ) then begin
            MessageDlgXP_Vista('You can only Approve for Your Level.', mtWarning, [mbOK], 0);
            Exit;
          end else begin
             DoApprove;
          end;
        end else begin
          DoApproveCurrent;
        end;
      finally
        Closedb(qryApprovalList);
        opendb(qryApprovalList);
        qryApprovalList.gotobookmark(bm);
        qryApprovalList.freebookmark(bm);
      end;
  finally
    qryApprovalList.enablecontrols;
  end;
end;

procedure TfmTransApproval.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  //Self.Close;

end;
function TfmTransApproval.IsApproved:Boolean;
begin
 fbIsAllApproved := true;
 fbIsAanyApproved := False;
 TransApprovals.IterateRecords(IsApprovedCallback);
 if appenv.companyprefs.UseSteppedApproval then Result := fbIsAllApproved
 else result :=fbIsAanyApproved;
end;
Procedure TfmTransApproval.IsApprovedCallback(Const Sender: TBusObj; var Abort: Boolean);
begin
  if sender is TTransApprovals then begin
      if not TTransApprovals(Sender).approved then begin
        fbIsAllApproved := False;
      end else begin
        fbIsAanyApproved := true;
      end;
  end;
end;
procedure TfmTransApproval.lblcheckPrefClick(Sender: TObject);
var
  msgOption :Word;
begin
  inherited;
  msgOption := MessageDlgXP_Vista('This Will Close the Approvals. Do You wish To Continue? ', mtConfirmation, [mbCancel], 0 , nil , '','',false , nil ,'Save and Continue,Cancel and Continue' );
  if msgOption = mrCancel then exit;
  if msgOption = 100 then cmdClose.Click
  else if msgOption = 101 then cmdCancel.Click
  else exit;
  fbIsToOpenPreferanceonClose := True;
end;
Procedure TfmTransApproval.UnApproveGridCurrentRecord;
begin
 TransApprovals.IterateRecordsReverse(UnApproveGridCurrentRecordCallback);
end;
procedure TfmTransApproval.UnApproveGridCurrentRecordCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if qryApprovalListTAID.asinteger = TransApprovals.ID then begin
    if TransApprovals.EmployeeId <> Appenv.Employee.Employeeid then begin
      MessageDlgXP_Vista('You can only Un-approve for Your Level.', mtWarning, [mbOK], 0);
    end else begin
      TransApprovals.Approved := False;
      TransApprovals.PostDB;
    end;
    Abort := true;
  end;
  if TransApprovals.Approved then begin
     MessageDlgXP_Vista('You Cannot Un-Approve as Someone with higher approval level  has already approved it', mtWarning, [mbOK], 0);
     Abort := true;
  end;
end;
procedure TfmTransApproval.qryApprovalListApprovedChange(Sender: TField);
var
  Abort :Boolean;
  bm:TBookmark;
begin
  inherited;
  if qryApprovalListApproved.asBoolean then begin
    grdmainDblClick(grdmain);
  end else begin
    bm :=qryApprovalList.getbookmark;
    try
      if not Appenv.companyprefs.UseSteppedApproval then UndoDoApproveCallbak(TransApprovals,Abort)
      else if (fiNextToApprove<>0) and (fiNextToApprove = qryApprovalListTAID.asinteger) then UndoDoApproveCallbak(TransApprovals,Abort)
      else UnApproveGridCurrentRecord ;
    finally
      Closedb(qryApprovalList);
      opendb(qryApprovalList);
      qryApprovalList.gotobookmark(bm);
      qryApprovalList.freebookmark(bm);
    end;
  end;
end;

class function TfmTransApproval.ApproveTrans(AOwner:TBaseInputGUI;aTransApprovals: TTransApprovals; aTotalAmount: double; aApprovalcheckObj: TApprovalcheck): Boolean;
begin
  with TfmTransApproval.create(AOwner) do try
    aTransApprovals.connection.beginnestedTransaction;
    try
      TransApprovals :=aTransApprovals;
      TotalAmount := aTotalAmount;
      fApprovalcheckObj := aApprovalcheckObj;
      if ShowModal = mrCancel then
           aTransApprovals.connection.RollbacknestedTransaction
      else aTransApprovals.connection.CommitnestedTransaction;

      REsult := IsApproved;
      LogCurrenttime('form closed');
      if fbIsToOpenPreferanceonClose then begin
        LogCurrenttime('Checking for flag');
        AOwner.ShowUserApprovalPref;
        LogCurrenttime('Added Delayed Proc');
      end;
    Except
      on E:Exception do begin
        aTransApprovals.connection.RollbacknestedTransaction;
      end;
    end;
  finally
    Free;
  end;
end;

procedure TfmTransApproval.btnApproveClick(Sender: TObject);
begin
  DoApprove;
end;
Procedure TfmTransApproval.UndoApprove(ExceptID:Integer);
begin
          {user user approval, if user approved, untick all others}
          qryApprovalList.first;
          While qryApprovalList.EOF = False do begin
            if qryApprovalListTAID.asInteger =ExceptID then else begin
              if TransApprovals.Locate('ID' , qryApprovalListTAID.asInteger , []) then begin
                  TransApprovals.Approved := False;
                  TransApprovals.PostDB;
                  CheckforApprover;
              end;
            end;
            qryApprovalList.Next;
          end;
            closeDb(qryApprovalList);
            opendb(qryApprovalList);
end;
Function TfmTransApproval.DoApprove:boolean;
var
  fbFlag :Boolean;
begin
  inherited;
  result := False;
  fiNextToApprove := 0;
  if TransApprovals.count =0 then exit;

  if Appenv.companyprefs.UseSteppedApproval then begin
      {Stepped approval, see if the current user is the enxt in the order}
      qryApprovalList.first;
      While qryApprovalList.EOF = False do begin
        if qryApprovalListEmployeeid.asInteger =Appenv.employee.employeeId then begin
          result := DoApproveCurrent;
          if result then break;
        end;
        if (qryApprovalListapproved.AsBoolean = False) and
            TransApprovals.Locate('ID' , qryApprovalListTAID.asInteger , []) and
           (qryApprovalListValueFrom.asfloat <= TotalAmount) and (qryApprovalListValueTo.asFloat >=TotalAmount) then begin
            TimerMsg(lbltimerMsg, 'You Cannot Approve This ' + TransApprovals.Transtype+ ' Until  '+ qryApprovalListEmployeeName.asString +' Approves it.', 30);
            fiNextToApprove :=TransApprovals.ID;
            Break;
        end;

        qryApprovalList.Next;
      end;
  end else begin
      {single user approval - approve for the currenct user }
      qryApprovalList.first;
      While qryApprovalList.EOF = False do begin
        if qryApprovalListEmployeeid.asInteger =Appenv.employee.employeeId then begin
          if TransApprovals.Locate('ID' , qryApprovalListTAID.asInteger , []) then begin
              DoApproveCurrent;
              break;
          end;
        end;
        qryApprovalList.Next;
      end;
  end;
end;

procedure TfmTransApproval.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin

     end;
end;

procedure TfmTransApproval.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := cafree;
end;

procedure TfmTransApproval.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if fTransApprovals.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveRecord then begin
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          fTransApprovals.Dirty := false;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
          cmdCancel.Enabled := True;
        end;
    end;
  end else begin
    CanClose := true;
    Notify(false);
  end;

end;

procedure TfmTransApproval.FormCreate(Sender: TObject);
begin
  inherited;
  fbIsToOpenPreferanceonClose := False;
  ShowAtCursor := true;
  IgnoreAccessLevels := True;
end;

procedure TfmTransApproval.FormShow(Sender: TObject);
begin
  InitForm;
  inherited;
  InitGrid;
  closedb(qryApprovalList);
  qryApprovalList.parambyname('TransID').asInteger    :=TransApprovals.TransId;
  qryApprovalList.parambyname('Approvaltype').asString:=TransApprovals.TransType;
  qryApprovalList.parambyname('Amount').asfloat       := TotalAmount;
  qryApprovalList.connection := TransApprovals.connection.connection;
  Opendb(qryApprovalList);
  fiNextToApprove := 0;
  if not DoApprove then begin
    highlightcontrol(cmdCancel);
    Setcontrolfocus(cmdCancel);
  end else begin
    highlightcontrol(cmdClose);
    Setcontrolfocus(cmdClose);
  end;
  caption := 'Amount To Approve :  '+ floattostrF(TotalAmount , ffcurrency,15,2);
end;
Procedure TfmTransApproval.Initform;
begin
  try
    Self.Color := TBaseInputGUI(Owner).Color;
    Shbox.pen.Color := clBlack;
  Except
    on E:Exception do begin

    end;
  end;
  Shbox.Width  := self.Width-1;
  Shbox.height := self.height -1;
  Shbox.left :=0;
  Shbox.top :=0;
  Shbox.Anchors := [akleft,aktop,akright,akbottom];

  pnlDetails.AlignWithMargins := false;
  pnlBottom.AlignWithMargins := false;
  with pnlMain do begin
    AlignWithMargins := true;
    Margins.top := 1;
    Margins.Left := 1;
    Margins.right := 1;
    Margins.Bottom := 1;
  end;
end;
procedure TfmTransApproval.InitGrid;
begin
  inherited;
  grdmain.selected.clear;
  grdmain.selected.add(SelectedText(qryApprovalListEmployeeName.fieldname , qryApprovalListEmployeeName.displaylabel  ,qryApprovalListEmployeeName.displaywidth , '', True));
  if Appenv.companyprefs.UseSteppedApproval then grdmain.selected.add(SelectedText(qryApprovalListApprovalOrder.fieldname, qryApprovalListApprovalOrder.displaylabel ,qryApprovalListApprovalOrder.displaywidth, ''  , True))
  else self.width := self.width  - qryApprovalListApprovalOrder.Displaywidth;
  grdmain.selected.add(SelectedText(qryApprovalListApproved.fieldname     , qryApprovalListApproved.displaylabel      ,qryApprovalListApproved.displaywidth     , ''  , False));


  grdmain.selected.add(SelectedText(qryApprovalListValueFrom.fieldname    , qryApprovalListValueFrom.displaylabel     ,qryApprovalListValueFrom.displaywidth    , 'Approval Levels', True));
  grdmain.selected.add(SelectedText(qryApprovalListValueTo.fieldname      , qryApprovalListValueTo.displaylabel       ,qryApprovalListValueTo.displaywidth      , 'Approval Levels', True));
  grdmain.selected.add(SelectedText(qryApprovalListApprovedby.fieldname   , qryApprovalListApprovedby.displaylabel    ,qryApprovalListApprovedby.displaywidth   , 'Approval Done'  , True));
  grdmain.selected.add(SelectedText(qryApprovalListApprovedOn.fieldname   , qryApprovalListApprovedOn.displaylabel    ,qryApprovalListApprovedOn.displaywidth   , 'Approval Done'  , True));
  grdmain.Applyselected;
end;
procedure TfmTransApproval.CheckforApprover;
begin
    if assigned(fApprovalcheckObj.Approvercombo) then begin
      if TransApprovals.approved then begin
        try
          fApprovalcheckObj.Busobj.Editdb;
          fApprovalcheckObj.Approvercombo.datasource.dataset.findfield(fApprovalcheckObj.Approvercombo.datafield).asInteger := TransApprovals.employeeId;
          fApprovalcheckObj.Busobj.PostDB;
        Except end;
      end else begin
        try
          if fApprovalcheckObj.Approvercombo.datasource.dataset.findfield(fApprovalcheckObj.Approvercombo.datafield).asInteger = TransApprovals.employeeId then begin
        try
          fApprovalcheckObj.Busobj.Editdb;
          fApprovalcheckObj.Approvercombo.datasource.dataset.findfield(fApprovalcheckObj.Approvercombo.datafield).asInteger :=0;
          fApprovalcheckObj.Busobj.PostDB;
        Except end;
          end;
        Except end;
      end;
    end;
end;
initialization
  RegisterClassOnce(TfmTransApproval);

end.

