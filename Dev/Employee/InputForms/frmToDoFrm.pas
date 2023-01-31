unit frmToDoFrm;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 06/09/05  1.00.01 DSP  Set ecoDisableDateTimePicker in EditControlOptions on
                        the grdLines control to 'True'.
 19/10/05  1.00.02 DLS  Added RegisterClass

}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, StdCtrls, Mask, DBCtrls, ExtCtrls,
  wwdblook, BaseInputForm, Buttons, DNMSpeedButton, wwdbdatetimepicker, kbmMemTable, Grids,
  Wwdbigrd, Wwdbgrid, DataState, DBAccess, MyAccess,ERPdbComponents, SelectionDialog,
  AppEvnts, DateUtils, Variants, ComCtrls,AdvOfficeStatusBar, wwriched, Menus, AdvMenus, MemDS, Shader,
  DNMPanel, ImgList, BusObjToDo,BusObjBase, BusObjConst, ProgressDialog, wwdbedit, Wwdbspin , MessageInterface,
  DMComps;

type
  TfrmToDo = class(TBaseInputGUI)
    frmToDoSrc: TDataSource;
    qryToDo: TERPQuery;
    cboEmployeeLookup: TERPQuery;
    DSEmployeeLookup: TDataSource;
    memQryTodo: TkbmMemTable;
    qryEmployees2: TERPQuery;
    qryToDoLines: TERPQuery;
    dsToDoLines: TDataSource;
    qryToDoLinesID: TAutoIncField;
    qryToDoLinesToDoID: TIntegerField;
    qryToDoLinesDateCreated: TDateTimeField;
    qryToDoLinesResponded: TDateTimeField;
    qryToDoLinesResults: TWideMemoField;
    qryToDoLinesDone: TWideStringField;
    qryToDoLinesTotal: TWideStringField;
    qryToDoToDoID: TAutoIncField;
    qryToDoCreatedDate: TDateTimeField;
    qryToDoEmployeeID: TIntegerField;
    qryToDoToDoByDate: TDateTimeField;
    qryToDoEditedFlag: TWideStringField;
    qryToDoAppearDays: TIntegerField;
    qryToDoResult: TWideStringField;
    qryToDoCreatedByEmployeeID: TIntegerField;
    qryToDoCompleted: TWideStringField;
    qryToDoActive: TWideStringField;
    pnlButtons: TDNMPanel;
    cmdOK: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    cmdPrint: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    pnlResults: TDNMPanel;
    Label4: TLabel;
    pnlTop: TDNMPanel;
    pnlResult: TDNMPanel;
    Label6: TLabel;
    pnlDescription: TDNMPanel;
    Label1: TLabel;
    edtDescription: TDBMemo;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Label29: TLabel;
    dtpCreatedDate: TwwDBDateTimePicker;
    Label34: TLabel;
    cboEmployee: TwwDBLookupCombo;
    Label2: TLabel;
    cboCreatedBy: TwwDBLookupCombo;
    Label32: TLabel;
    dtpToDoByDate: TwwDBDateTimePicker;
    qryToDoDone: TWideStringField;
    btnRepeat: TDNMSpeedButton;
    memResult: TDBMemo;
    grdLines: TwwDBGrid;
    btnDelete: TwwIButton;
    qryToDoLinesDeleted: TWideStringField;
    btnEmail: TDNMSpeedButton;
    qryToDoShowReminder: TWideStringField;
    Label8: TLabel;
    wwDBDateTimePicker1: TwwDBDateTimePicker;
    Label9: TLabel;
    wwDBDateTimePicker2: TwwDBDateTimePicker;
    qryToDoDescription: TWideMemoField;
    qryToDoSynchWithGoogle: TWideStringField;
    qryToDoGoogleId: TWideStringField;
    qryToDoMasterGoogleId: TWideStringField;
    edtToDoPriority: TwwDBSpinEdit;
    Label11: TLabel;
    qryToDoToDoPriority: TSmallintField;
    DNMPanel1: TDNMPanel;
    DBCheckBox1: TDBCheckBox;
    DNMPanel2: TDNMPanel;
    chkShowReminder: TDBCheckBox;
    DNMPanel4: TDNMPanel;
    chkCompleted: TDBCheckBox;
    DNMPanel3: TDNMPanel;
    DBCheckBox2: TDBCheckBox;
    btnPreview: TDNMSpeedButton;
    DMTextTargetToDo: TDMTextTarget;
    btnAttachments: TDNMSpeedButton;
    qryToDoGlobalRef: TWideStringField;
    qryToDoPOID: TIntegerField;
    qryToDomsTimeStamp: TDateTimeField;
    qryToDoType: TWideStringField;
    qryToDoOtherID: TIntegerField;
    qryToDoClientID: TIntegerField;
    qryToDomsUpdateSiteCode: TWideStringField;
    qryToDoGoogleUpdated: TDateTimeField;
    qryToDoMasterGoogleUpdated: TDateTimeField;
    qryToDoLinkTo: TWideStringField;
    qryToDoLinkToID: TIntegerField;
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdOkClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdPrintClick(Sender: TObject);
    procedure qryToDoLinesCalcFields(DataSet: TDataSet);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnRepeatClick(Sender: TObject);
    procedure grdLinesDblClick(Sender: TObject);
    procedure memResultChange(Sender: TObject);
    procedure btnEmailClick(Sender: TObject);
    procedure DMTextTargetToDoDrop(Sender: TObject; Acceptor: TWinControl;
      const DropText: string; X, Y: Integer);
    procedure btnAttachmentsClick(Sender: TObject);

  private
    ObjToDo :TToDo;
//    FirstLineChange: boolean;
    AutoAddedLineId: integer;
    ResultEdited: boolean;
    DescriptionHeight,
    DescriptionHeightPercent: integer;
    ResultHeight,
    ResultHeightPercent: integer;
    Procedure NewTODO;
    function SaveData: boolean;
    procedure RefreshFooter;
    function SQLForReport: string;
    procedure ShowAttachments(fbDragnDropping :boolean);
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    TDID: integer;
  Published
    function InitialiseCustomerID(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;

  end;

implementation

uses
  FormFactory, DNMLib,
  DNMExceptions, CommonLib, AppEnvironment, FastFuncs, CompanyPrefObj,
  frmRepeat, CommonDbLib, EmailUtils, BusObjEmployee, tcConst, tcDataUtils,
  CorrespondenceObj, frmAttachments, EmailExtraUtils;

{$R *.DFM}


procedure TfrmToDo.cmdCancelClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmToDo.cmdOkClick(Sender: TObject);
var
  bSavedDisableNotifyListsPref:Boolean;
begin
  if not SaveData then exit;
  Objtodo.Connection.CommitTransaction;
  Objtodo.Dirty := FAlse;
  bSavedDisableNotifyListsPref := AppEnv.CompanyPrefs.DisableNotifyLists;
  AppEnv.CompanyPrefs.DisableNotifyLists := False;
  AppEnv.GoogleUpdater.UpdateToDo(ObjToDo.ID, AppEnv.ServerID);
  Notify;
  AppEnv.CompanyPrefs.DisableNotifyLists := bSavedDisableNotifyListsPref;
  Self.Close;
end;

procedure TfrmToDo.cmdNewClick(Sender: TObject);
begin
  if not SaveData then exit;

  Objtodo.Connection.CommitTransaction;
  Notify;
  NewtoDo;
end;

procedure TfrmToDo.FormShow(Sender: TObject);
var
  dt:TDatetime;
begin
  DisableForm;
  try
    try
      inherited;
      ObjToDo.Load(KeyID);
      BeginTransaction;
      if KeyId = 0 then NewtoDo;
      ObjTodo.Lines.Dataset.Filter:= 'Deleted <> ' + QuotedStr('T');
      ObjTodo.Lines.Dataset.Filtered:= true;
      OpenQueries;

      grdLines.ReadOnly   := AccessLevel > 2;
      if AccessLevel >= 2 then begin
        grdLines.KeyOptions := grdLines.KeyOptions - [dgAllowDelete];
        btnDelete.Enabled := false;
      end;

      if AccessLevel > 2 then begin
        grdLines.KeyOptions := grdLines.KeyOptions - [dgAllowInsert];
        dtpCreatedDate.ReadOnly := true;
        cboEmployee.ReadOnly := true;
        cboCreatedBy.ReadOnly := true;
        dtpToDoByDate.ReadOnly := true;
        edtDescription.ReadOnly := true;
        cmdNew.Enabled := false;
        cmdOk.Enabled := false;
      end
      else begin
        dt:=ObjToDo.LastResponsedate;
        ObjToDo.Lines.New;
        ObjToDo.Lines.DateCreated := dt;
        ObjToDo.Lines.Responded := now;
        ObjToDo.Lines.PostnEditDB;
        AutoAddedLineId := ObjToDo.Lines.ID;
        ResultEdited := false;
      end;

      DMTextTargetToDo.AcceptorControl := nil;
      DMTextTargetToDo.AcceptorControl := edtDescription;
      if (Accesslevel<=3) and (not(edtDescription.ReadOnly)) and (objtodo.isSmartorPurchaseOrderToDO) then
        edtDescription.ReadOnly:= TRue;

    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmToDo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  Action := caFree;
end;

procedure TfrmToDo.cmdPrintClick(Sender: TObject);
var
  sReportName, sSQL: string;
begin
  DisableForm;
  try
    if not ObjToDo.Save then exit;
    fbReportSQLSupplied := true;

    sSQL := SQLForReport;

    sReportName := 'To Do';
    fbTemplateUsesNonFormConnection := false;
    PrintTemplateReport(sReportName, sSQL, (Sender <>btnPreview) , 1);
    fbReportSQLSupplied := false;
    fbTemplateUsesNonFormConnection := true;
  finally
    ObjToDo.ResultStatus.Clear;
    EnableForm;
  end;
end;

procedure TfrmToDo.DMTextTargetToDoDrop(Sender: TObject; Acceptor: TWinControl;  const DropText: string; X, Y: Integer);
var
  Form: TComponent;
begin
  inherited;
  if qryToDoToDoID.AsInteger < 1 then Exit; // need todo id

  ShowAttachments(true);
  Form := TfmAttachments(GetComponentByClassName('TfmAttachments', true));
  if Assigned(Form) then // if has acess
      TfmAttachments(Form).DMTextTargetDrop(Sender, Acceptor, DropText, X, Y);
end;

procedure TfrmToDo.qryToDoLinesCalcFields(DataSet: TDataSet);
(*var
  iDays: integer;
  iHours, iMinutes, iSeconds: int64;
  dtCreated, dtResponded: TDateTime;
  sResult, sHours, sMins, sSecs: string;*)
begin
  inherited;
  if (ObjToDo.Lines.Responded=0) or
    (ObjToDo.Lines.Responded < ObjToDo.Lines.DateCreated) then begin
    ObjToDo.Lines.Total := 'N/A';
    Exit;
  end;

  (*dtResponded := ObjToDo.Lines.Responded;
  dtCreated := ObjToDo.Lines.DateCreated;*)
  if ObjToDo.Lines.DateCreated =0 then begin
    ObjToDo.Lines.Total:= '';
  end else begin
      ObjToDo.Lines.Total:= SecondsToTime(SecondsBetween(ObjToDo.Lines.DateCreated, ObjToDo.Lines.Responded) ,True);
    (*iDays := DaysBetween(dtResponded, dtCreated);
    iHours := HoursBetween(dtResponded, dtCreated);
    iHours := iHours mod 24;
    iMinutes := MinutesBetween(dtResponded, dtCreated);
    iMinutes := iMinutes mod 60;
    iSeconds := SecondsBetween(dtResponded, dtCreated);
    iSeconds := iSeconds mod 60;

    sResult := IntToStr(iDays) + 'D ';
    if iHours < 10 then begin
      sHours := '0' + IntToStr(iHours);
    end else begin
      sHours := IntToStr(iHours);
    end;

    if iMinutes < 10 then begin
      sMins := '0' + IntToStr(iMinutes);
    end else begin
      sMins := IntToStr(iMinutes);
    end;

    if iSeconds < 10 then begin
      sSecs := '0' + IntToStr(iSeconds);
    end else begin
      sSecs := IntToStr(iSeconds);
    end;
    ObjToDo.Lines.Total:= sResult + sHours + ':' + sMins + ':' + sSecs;*)
  end;

end;

procedure TfrmToDo.btnAttachmentsClick(Sender: TObject);
begin
  inherited;
  ShowAttachments(False);
end;
procedure TfrmToDo.ShowAttachments(fbDragnDropping :boolean);
var
  tmpComponent: TComponent;
begin
  if qryToDoToDoID.AsInteger < 1 then Exit; // need todo id
  tmpComponent := TfmAttachments(GetComponentByClassName('TfmAttachments', False, self));
  if not Assigned(tmpComponent) then Exit;
  with TfmAttachments(tmpComponent) do begin
    DBConnection := Self.MyConnection;
    AttachObserver(Self);
    TableName := 'tbltodo';
    TableId := qryToDoToDoID.AsInteger;
    DragnDropping :=fbDragnDropping;
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

procedure TfrmToDo.btnDeleteClick(Sender: TObject);
var
  dt1, dt2:TDatetime;
begin
  inherited;
  dt1:=ObjToDo.Lines.DateCreated;
  dt2:= ObjToDo.Lines.Responded;
  ObjToDo.Lines.Deleted := True;
  ObjToDo.Lines.PostDB;
  if ObjToDo.Lines.Locate('DateCreated;deleted' , vararrayof([dt2,'F']), []) then begin
    ObjToDo.Lines.DateCreated := dt1;
    ObjToDo.Lines.postdb;
  end;
end;

procedure TfrmToDo.grdLinesDblClick(Sender: TObject);
begin
  inherited;
  if grdLines.GetActiveField = qryToDoLinesResults then begin
    FocusControl(memResult);
  end;
end;

function TfrmToDo.InitialiseCustomerID(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
begin
  ObjToDo.clientID := MsgObj.IntValue;
  Result := True;
end;

procedure TfrmToDo.memResultChange(Sender: TObject);
begin
  inherited;
//  if (not FirstLineChange) and (memResult.Focused) then begin
//    FirstLineChange := true;
//    PostDb(qryToDoLines);
//    qryToDoLines.Append;
//  end;
  ResultEdited:= true;
  if qryToDoLinesResponded.AsDateTime = 0 then
    if qryToDoLines.State in [dsInsert, dsEdit] then
      qryToDoLinesResponded.AsDateTime:= now;
end;

function TfrmToDo.SaveData: boolean;
begin
  PostDb(qryToDoLines);
  if (not ResultEdited) and (AutoAddedLineId > 0) then begin
    if qryToDoLines.Locate('ID',AutoAddedLineId,[]) then
      qryToDoLines.Delete;
    ResultEdited := false;
    AutoAddedLineId := 0;
  end;
  result:= ObjTodo.Save;
  ObjToDo.ResultStatus.Clear;
end;

function TfrmToDo.SQLForReport: string;
begin
  result := '{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, '+
            'Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN '+
            ' FROM     tblCompanyInformation AS CO  ~|||~ ';
  result := result + '{Master}SELECT ';
  result := result + 'TODO.CreatedDate, TODO.ToDoByDate, TODO.Done,  TODO.Description, ';
  result := result + 'TODO.EmployeeID,TODO.Result,  EMP.FirstName, EMP.LastName ';
  result := result + 'FROM tbltodo AS TODO ';
  result := result + 'INNER JOIN tblemployees AS EMP USING (EmployeeID) ';
  result := result + 'WHERE ToDoID = ' + qryToDo.FieldByName('ToDoID').AsString + ' ';
  result := result + '~|||~{Details}SELECT *, ';
  result := result + 'Floor((UNIX_TIMESTAMP(Responded)-UNIX_TIMESTAMP(DateCreated)) / 86400) AS Days, ';
  result := result + 'Floor(((UNIX_TIMESTAMP(Responded)-UNIX_TIMESTAMP(DateCreated)) % 86400) / 3600) AS Hours, ';
  result := result + 'Floor((((UNIX_TIMESTAMP(Responded)-UNIX_TIMESTAMP(DateCreated)) % 86400) % 3600) / 60 ) AS Mins, ';
  result := result + 'Floor((((UNIX_TIMESTAMP(Responded)-UNIX_TIMESTAMP(DateCreated)) % 86400) % 3600) % 60 ) AS Secs ';
  result := result + 'FROM tbltodolines ';
  result := result + 'WHERE deleted ="F" and ToDoID = ' + qryToDo.FieldByName('ToDoID').AsString;

end;

procedure TfrmToDo.FormResize(Sender: TObject);
begin
  inherited;
//  pnlDescription.Height:=
//    Trunc((ClientHeight - pnlTop.Height - pnlResults.Height - pnlButtons.Height)/2);
  if Height > 600 then begin
    pnlDescription.Height := Trunc(ClientHeight * (DescriptionHeightPercent / 100));
    pnlResult.Height := Trunc(ClientHeight * (ResultHeightPercent / 100));

  end
  else begin
    pnlDescription.Height := DescriptionHeight;
    pnlResult.Height := ResultHeight;
  end;
end;

procedure TfrmToDo.FormCreate(Sender: TObject);
begin
  inherited;
  ObjToDo :=TToDo.create(Self);
  ObjToDo.connection := TMyDacDataconnection.create(ObjToDo);
  ObjtoDo.connection.connection := Self.MyConnection;
  ObjtoDO.BusObjEvent := DoBusinessObjectEvent;
  ObjToDo.Lines;
  AutoAddedLineId:= 0;
  DescriptionHeight := pnlDescription.Height;
  DescriptionHeightPercent := Trunc((DescriptionHeight / ClientHeight) * 100);
  ResultHeight := pnlResult.Height;
  ResultHeightPercent := Trunc((ResultHeight / ClientHeight) * 100);
end;

procedure TfrmToDo.RefreshFooter;
begin
  //grdLines.ColumnByName('total').FooterValue := SecondsToTime(ObjTodo.totalTime , true);
end;
procedure TfrmToDo.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TtoDo then TtoDo(Sender).Dataset := qryToDo
        else if Sender is TToDoLines then TToDoLines(Sender).Dataset := qryToDoLines;
    end else if (Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterPost) then begin
      RefreshFooter;
    end else if (Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterOpen) then begin
      RefreshFooter;
    end;
end;

procedure TfrmToDo.NewTODO;
begin
  ObjTodo.New;
  ObjTodo.PostDB;
  ObjTodo.Lines;
end;

procedure TfrmToDo.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  iExitResult: integer;
begin
  inherited;
  canclose:= true;
  if ObjToDo.dirty then begin
    try
      iExitResult := CommonLib.MessageDlgXP_Vista('Do you wish to keep these changes you Have Made?', mtConfirmation,[mbYes, mbNo, mbCancel], 0);
      case iExitResult of
        mrYes: begin
            if not ObjTodo.Save then begin
              Canclose:= False;
              exit;
            End;
            ObjToDo.Connection.CommitTransaction;
          end;
        mrNo:
          begin
            ObjToDo.Cancel;
            ObjToDo.connection.RollbackTransaction;
          end;
        mrCancel: Canclose:= False;
      end;
    finally
      ObjToDo.ResultStatus.Clear;
    end;
  end;
end;


procedure TfrmToDo.btnEmailClick(Sender: TObject);
var
  sReportName, sSQL: string;
  TempFileName: string;
  Corres: TCorrespondenceGui;
  lSilent,
  lSecret : boolean;
begin
  DisableForm;
  try
    if not ObjToDo.Save then exit;
    fbReportSQLSupplied := true;

    sSQL := SQLForReport;

    sReportName := 'To Do';
    fbTemplateUsesNonFormConnection := false;
    TempFileNAme := 'ToDoReport';
    self.SaveTemplateReport(sReportName,sSQL,false,'PDF',TempFileName);
    fbReportSQLSupplied := false;
    fbTemplateUsesNonFormConnection := true;

    Corres := TCorrespondenceGui.Create;
    try
      Corres.RecipientList := TEmployee.EmailForEmployeeID(ObjToDo.EmployeeID,ObjToDo.Connection.Connection);
      Corres.EmployeeId := ObjToDo.EmployeeID;
      Corres.Subject := 'To-do';
      //MailSender.EmailBody.Add('<html><head></head><body>' + ObjToDo.Description + '</body></html>');
      Corres.MessageText := 'Hi ' + getemployeeFirstName(ObjToDo.EmployeeID) + #13#10 + #13#10 + ObjToDo.Description;
      Corres.AttachmentList.Add(Commonlib.TempDir + TempFileName+ '.pdf');
      if not EmailShortSendMode(lSilent, lSecret) then
        exit;
      Corres.Execute();

    finally
      Corres.Free;
    end;
  finally
    ObjToDo.ResultStatus.Clear;
    EnableForm;
  end;
end;

procedure TfrmToDo.btnRepeatClick(Sender: TObject);
var
  Description:String;
  employeeID:Integer;
  ctr:Integer;
begin
  inherited;
  try
    if ObjToDo.dirty then
      if not ObjToDo.Save then exit;
  finally
    ObjToDo.ResultStatus.Clear;
  end;
  Objtodo.Connection.CommitTransaction;
  if objtodo.Count = 0 then exit;
  Description:= Objtodo.Description;
  employeeID:= ObjTodo.EmployeeID;


  with TRepeatFrm.Create(self, CommonDbLib.GetSharedMyDacConnection.Database) do begin
    try
      Caption := 'Repeat ToDo';
      ShowModal;
      if ModalResult = mrOk then begin
        Objtodo.connection.BeginTransaction;
        showProgressbar('Creating ToDos' , high(Dates));
        try
          for ctr := Low(dates) to high(Dates) do begin
            NewTODO;
            ObjtoDo.Description := Description;
            Objtodo.EmployeeID := employeeID;
            Objtodo.ToDoByDate := Dates[ctr];
            Objtodo.postDB;
            stepProgressbar;
          end;
          ObjToDo.Connection.CommitTransaction;
          ObjToDo.dirty := False;
          Self.Close;
        finally
            HideProgressbar;
        end;
      end;
      finally
        Free;
      end;
  end;
end;

initialization
  RegisterClassOnce(TFrmToDo);
  FormFact.RegisterMe(TfrmToDo, 'TToDoListGUI_*=ToDoID');
  (*FormFact.RegisterMe(TfrmToDo, 'TRemindersListGUI_*_ToDo=ID');*)
  FormFact.RegisterMe(TfrmToDo, 'TfmMarketingLead_*_ToDo=ActionID');
end.

