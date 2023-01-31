unit ToDoListForm;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 07/09/05  1.00.01 ISB	Modified To Work With New Filtering on Baselisting.
 14/09/05  1.00.02 DMS  pnlAdvPrinting was set invisible. Printing will always
                        show preview.
 28/03/06  1.00.03 DSP  Replaced 'Employee Name' with 'E.EmployeeName' and
                        'Created By' with 'T.EmployeeName' in sSQL in the
                        cmdPrintClick procedure.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, StdCtrls, ExtCtrls, ComCtrls,AdvOfficeStatusBar,
  wwDialog, Wwlocate, SelectionDialog, DNMPanel, wwdblook, DateUtils,
  wwcheckbox, DBAccess, MyAccess,ERPdbComponents, MemDS, wwdbdatetimepicker, wwriched,
  ProgressDialog, StrUtils,  Shader, kbmMemTable, DAScript,
  Forms, MyScript, CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TToDoListGUI = class(TBaseListingGUI)
    chkAllEmployees: TCheckBox;
    cboEmployee: TwwDBLookupCombo;
    qryEmployees: TERPQuery;
    ChkCreatedBy: TwwCheckBox;
    Label4: TLabel;
    grdToDoLines: TwwDBGrid;
    ebToDoLines: TwwExpandButton;
    dsToDoLines: TDataSource;
    qryToDoLines: TERPQuery;
    qryMainToDoID: TIntegerField;
    qryMainDays: TLargeintField;
    qryMainResult: TWideStringField;
    qryMainDone: TWideStringField;
    qryToDoLinesDateCreated: TDateTimeField;
    qryToDoLinesResponded: TDateTimeField;
    qryToDoLinesResults: TWideMemoField;
    qryToDoLinesDone: TWideStringField;
    qryToDoLinesTotal: TWideStringField;
    qryMainToDoByDate: TDateTimeField;
    qryMainCreatedDate: TDateTimeField;
    qryMainCompleted: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryTestResult: TERPQuery;
    qryMainType: TWideStringField;
    qryMainOtherID: TIntegerField;
    qryMainEmployeeName: TWideStringField;
    qryMainCreatedBy: TWideStringField;
    qryMainDaysAllocated: TLargeintField;
    qryMainOverdueDays: TLargeintField;
    qryMainDaysToDue: TLargeintField;
    cmdEmail: TDNMSpeedButton;
    qryMainEmployeeID: TIntegerField;
    qryMainDescription: TWideMemoField;
    qryMaintodoPriority: TSmallintField;
    btnDelete: TDNMSpeedButton;
    qryMainLinkTo: TWideStringField;
    qryMainLinkToID: TIntegerField;
    procedure cmdNewClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
    procedure cboEmployeeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure chkAllEmployeesClick(Sender: TObject);
    procedure qryToDoLinesCalcFields(DataSet: TDataSet);
    procedure ebToDoLinesAfterCollapse(Sender: TObject);
    procedure ebToDoLinesBeforeExpand(Sender: TObject);
//    procedure dtToChange(Sender: TObject);
    procedure ChkCreatedByClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdEmailClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  private
    SelectedEmployees:String;
    totdays:Integer;
    Totrecs:Integer;
    Function HasVaildResult(Const ToDoID:Integer):Boolean;
    procedure FilterSelectedEmployees(Sender: TObject);
    procedure SelectEmployeeForEmail(Sender: twwdbgrid);
    function ReportSQL: String;

  protected
    procedure RefreshQuery; override;
    Procedure ReadnApplyGuiPrefExtra;override;
    Procedure WriteGuiPrefExtra;override;
    procedure SetGridColumns; override;
    Procedure RefreshTotals; override;
    procedure CalcFooter; override;
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;

  public
    { Public declarations }
  end;

implementation

uses FastFuncs,frmToDoFrm,  Commonlib,systemlib, AppEnvironment, CommonFormLib,
  CommonDbLib, BusObjToDo, tcConst, EmailExtraUtils, MAIN, MySQLConst;

{$R *.dfm}

procedure TToDoListGUI.cmdNewClick(Sender: TObject);
var
  Form: TComponent;
begin
  DisableForm;
  try
    inherited;
    Form := GetComponentByClassName('TfrmToDo');
    if Assigned(Form) then begin //if has acess
      with TfrmToDo(Form) do begin
        AttachObserver(Self);
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  finally
    EnableForm;
  end;
end;

procedure TToDoListGUI.cmdPrintClick(Sender: TObject);
begin
//inherited;
  ReportSQLSupplied := true;
  Self.PrintTemplateReport('ToDo List', reportsql, false, 1);
end;

procedure TToDoListGUI.grpFiltersClick(Sender: TObject);
begin
  RefreshQuery;
  inherited;
end;

procedure TToDoListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  AddCalcColumn(QrymainDays.FieldName,False);
end;

procedure TToDoListGUI.FormShow(Sender: TObject);
begin
  if qryEmployees.active = False then qryEmployees.open;
  if qryEmployees.Locate('EmployeeID', AppEnv.Employee.EmployeeID, [loCaseInsensitive]) then begin
    cboEmployee.Text := qryEmployees.FieldByName('EmployeeName').AsString;
  end;
  inherited;
  MainForm.StatusBar.Panels[7].Text := '<FONT COLOR="#000000" size=10><B>To Do List</B></FONT>';
  if not fbFormOpenedOk then Exit;
end;

procedure TToDoListGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if GuiPrefs.Node.Exists('Options') then begin
      ChkCreatedBy.checked               := StrToBoolean(GuiPrefs.Node['Options.Createdby'].AsString);
      chkAllEmployees.checked               := StrToBoolean(GuiPrefs.Node['Options.Allemployees'].AsString);
      if not(chkAllEmployees.checked) then begin
        opendb(qryEmployees);
        if (qryEmployees.Locate('EmployeeId' ,GuiPrefs.Node['Options.EmployeeID'].asInteger , [])) then
          cboEmployee.text :=qryEmployees.FieldByName('EmployeeName').asString
      end;
  end;
end;

procedure TToDoListGUI.RefreshQuery;
var
  iEmployeeID: integer;
begin
  if qryEmployees.active = False then qryEmployees.open;
  iEmployeeID := qryEmployees.FieldByName('EmployeeID').AsInteger;
  qryMain.Close;
  qryMain.SQL.Clear;
  qryMain.SQL.Add('SELECT');
  qryMain.SQL.Add('ToDoID             as ToDoID, ');
  qryMain.SQL.Add('C.GlobalRef        as GlobalRef, ');
  qryMain.SQL.Add('ToDoByDate         as ToDoByDate, ');
  qryMain.SQL.Add('Description        as Description, ');
  qryMain.SQL.Add('Result             as Result, ');
  qryMain.SQL.Add('E.EmployeeID       as EmployeeID,');
  qryMain.SQL.Add('E.EmployeeName     as EmployeeName,');
  qryMain.SQL.Add('C.EmployeeName     as "CreatedBy", ');
  qryMain.SQL.Add('CreatedDate        as CreatedDate, ');
  qryMain.SQL.Add('Done               as Done, ');
  qryMain.SQL.Add('T.Completed        as Completed, ');
  qryMain.SQL.Add('T.Active        as Active, ');
  qryMain.SQL.Add('T.Type             as Type, ');
  qryMain.SQL.Add('T.OtherID          as OtherID,');
  qryMain.SQL.Add('T.todoPriority     as todoPriority,');
  qryMain.SQL.Add('DateDiff(curdate(), T.CreatedDate) as Days,');
  qryMain.SQL.Add('if(ifnull(T.ToDoByDate,0)=0 or T.ToDoByDate > curdate() , 0 , DateDiff(curdate(), T.ToDoByDate)) as OverdueDays,');
  qryMain.SQL.Add('if(ifnull(T.ToDoByDate,0)=0 or T.ToDoByDate < curdate() , 0 , DateDiff(T.ToDoByDate,curdate())) as DaysToDue,');
  qryMain.SQL.Add('DateDiff(ifnull(T.ToDoByDate,curdate()), T.CreatedDate) as DaysAllocated,');
  qryMain.SQL.Add('T.LinkTo as LinkTo,');
  qryMain.SQL.Add('T.LinkToID as LinkToID');
  qryMain.SQL.Add('FROM tblToDo AS T');
  qryMain.SQL.Add('LEFT JOIN tblEmployees AS C ON C.EmployeeID = T.CreatedByEmployeeID');
  qryMain.SQL.Add('LEFT JOIN tblEmployees AS E ON E.EmployeeID = T.EmployeeID');

(*  {for date range}
  if chkIgnoreDates.Checked = False then
    qryMain.SQL.Add('where  (T.ToDoByDate between "' + FormatDateTime(MySQLDateTimeFormat,dtFrom.Date) + '" and "' + FormatDateTime(MySQLDateTimeFormat,dtTo.Date) + '"')
  else qryMain.SQL.Add('where  (T.ToDoByDate >0');*)
  qryMain.SQL.Add('where  (T.ToDoByDate between "' + FormatDateTime(MySQLDateTimeFormat,filterdateFrom) + '" and "' + FormatDateTime(MySQLDateTimeFormat,FilterDateto) + '"');

  {for selected employee}
  if (not chkAllEmployees.Checked) and (iEmployeeID <> 0) then { single employee }
    if ChkCreatedBy.Checked then qryMain.SQL.Add(' and  T.CreatedByEmployeeID = ' + IntToStr(iEmployeeID)) else qryMain.SQL.Add('and T.EmployeeID = ' + IntToStr(iEmployeeID));

  {grpfilter selection}
  case grpFilters.ItemIndex of
    0: qryMain.SQL.Add('and Completed = "F" and T.Active ="T"');
    1: qryMain.SQL.Add('and Completed = "T" and T.Active ="T"');
    2: qryMain.SQL.Add('and T.Active = "F"');
  end;
  Qrymain.SQL.add(')');;


(*  {if employee Selected - report to Todos of the employee which are overdue }
  if (((not chkAllEmployees.Checked) and (iEmployeeID <> 0)) and (grpFilters.ItemIndex <> 1)) then begin
    Qrymain.SQL.add(' or (');;
   if ChkCreatedBy.Checked then qryMain.SQL.Add('C.ReportsTo = ' + IntToStr(iEmployeeID)) else qryMain.SQL.Add('E.ReportsTo = ' + IntToStr(iEmployeeID));
   qryMain.SQL.Add('and Now() > T.ToDoByDate and Completed = "F"');
   Qrymain.SQL.add(')');;
  end;*)

  qryMain.SQL.Add('order by ToDoByDate DESC');
  self.RefreshOrignalSQL;
  inherited;
end;

procedure TToDoListGUI.RefreshTotals;
begin
  inherited;
  totdays:= 0;
  Totrecs:= 0;
  CalcnShowfooter;
(*  if qryMainEmployeeName.Index < Qrymaindays.Index then
    grdMain.ColumnByName(qryMainEmployeeName.FieldName).FooterValue := 'Average Days :'
  else if Qrymaindays.Index > 0 then grdMain.Columns[Qrymaindays.Index-1].FooterValue := 'Average Days :';*)
  grdMain.ColumnByName(Qrymaindays.Fieldname).FooterValue := 'Avg  ' + FloatToStrF(round(FooterCalcfields[0].Total,2) , ffGeneral, 15, 2);
end;

procedure TToDoListGUI.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if grdmain.SelectedList.Count =0 then exit;

  if sametext(SelectedDatas(qrymaintype.FieldName , true) , 'Support') then begin
    MessageDlgXP_vista('You have only selected ''Support'' items, which cannot be deleted', mtWarning, [mbOK], 0);
    Exit;
  end;

  if MessageDlgXP_vista('Are you sure you want to flag all selected ''To Do'' entries as Inactive? ' + NL+
                        'Please note that the ''Support'' entries selected will not be deleted.', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
  IterateProcno := 1;
  IterateselectedRecords(true, 'Deleting the ToDos' );
  RefreshQuery;
end;
procedure TToDoListGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);
var
  todoobj :TToDo;
begin
  inherited;
  if iterateprocno = 1 then begin
    todoobj := TToDo.CreateWithNewConn(Self);
    try
      todoobj.Load(qryMainToDoID.AsInteger);
      if todoobj.count =0 then exit;
      if sametext(todoobj.ToDoType , 'Support') then exit;
      if not todoobj.Lock then exit;
      todoobj.Connection.BeginTransaction;
      try
        todoobj.Active := False;
        todoobj.PostDB;
        todoobj.Connection.CommitTransaction;
      Except
        on E:Exception do begin
          todoobj.Connection.RollbackTransaction;
        end;
      end;
    finally
      Freeandnil(todoobj);
    end;
  end;
end;

procedure TToDoListGUI.CalcFooter;
begin
  //inherited;
  totdays:= totdays + qryMainDays.AsInteger;
  Totrecs:= Totrecs +1;

  if (Totrecs <> 0) and (totdays<>0) then
    FooterCalcfields[0].Total := totdays/Totrecs
  else
    FooterCalcfields[0].Total := 0;
end;

procedure TToDoListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainGlobalRef.FieldName);
  RemoveFieldfromGrid(qryMainOtherID.FieldName);
  RemoveFieldfromGrid(qryMainEmployeeID.FieldName);
end;

procedure TToDoListGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.Createdby'].AsString              := BooleanToStr(ChkCreatedBy.checked);
  GuiPrefs.Node['Options.Allemployees'].AsString           := BooleanToStr(chkAllEmployees.checked);
  GuiPrefs.Node['Options.EmployeeID'].asInteger            := qryEmployees.FieldByName('EmployeeId').asInteger;
end;


procedure TToDoListGUI.cboEmployeeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  if (fsShowing in Self.FormState) or (fsCreating in Self.FormState) then Exit;
  RefreshQuery;
end;

procedure TToDoListGUI.chkAllEmployeesClick(Sender: TObject);
begin
  inherited;
  if (fsShowing in Self.FormState) or (fsCreating in Self.FormState) then Exit;
  cboEmployee.Enabled := not chkAllEmployees.Checked;
  if screen.ActiveControl = chkAllEmployees then begin
    if chkAllEmployees.checked then ChkCreatedBy.checked :=False;
    RefreshQuery;
  end;

end;

procedure TToDoListGUI.qryToDoLinesCalcFields(DataSet: TDataSet);
var
  iDays: integer;
  iHours, iMinutes, iSeconds: int64;
  dtCreated, dtResponded: TDateTime;
  sResult, sHours, sMins, sSecs: string;
begin
  inherited;
  if (qryToDoLines.FieldByName('Responded').IsNull) or
    (qryToDoLines.FieldByName('Responded').AsDateTime < qryToDoLines.FieldByName('DateCreated').AsDateTime) then begin
    qryToDoLines.FieldByName('Total').AsString := 'N/A';
    Exit;
  end;

  dtResponded := qryToDoLines.FieldByName('Responded').AsDateTime;
  dtCreated := qryToDoLines.FieldByName('DateCreated').AsDateTime;
  iDays := DaysBetween(dtResponded, dtCreated);
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

  qryToDoLinesTotal.AsString := sResult + sHours + ':' + sMins + ':' + sSecs;
end;

procedure TToDoListGUI.ebToDoLinesAfterCollapse(Sender: TObject);
begin
  inherited;
  qryToDoLines.Close;
end;

procedure TToDoListGUI.ebToDoLinesBeforeExpand(Sender: TObject);
begin
  inherited;
  qryToDoLines.Close;
  qryToDoLines.Params.ParamByName('xID').AsInteger := qryMain.FieldByName('ToDoID').AsInteger;
  qryToDoLines.Open;
end;

function TToDoListGUI.ReportSQL:String;
var
  sl: TStringList;
  iEmployeeID: integer;
begin
  DisableForm;
  try
    sl:= TStringList.Create;
    try
      if qryEmployees.active = False then qryEmployees.open;
      iEmployeeID := qryEmployees.FieldByName('EmployeeID').AsInteger;
      sl.Add('{Company}SELECT');
      sl.Add(' * FROM tblCompanyInformation ');
      sl.Add('~|||~{Master} ');
      sl.Add('SELECT TD.ID LineId,T.ToDoID, T.CreatedDate, T.Description, T.ToDoByDate, ');
      sl.Add('Case T.Done WHEN "F" THEN "No" WHEN "T" THEN "Yes" END AS "Done", ');
      sl.Add('if(ifnull(T.ToDoByDate,0)=0 or T.ToDoByDate > curdate() , 0 , DateDiff(curdate(), T.ToDoByDate)) OverdueDays,');
      sl.Add('DateDiff(curdate(), T.CreatedDate) DaysSinceCreated,');
      sl.Add('if(ifnull(T.ToDoByDate,0)=0 or T.ToDoByDate < curdate() , 0 , DateDiff(T.ToDoByDate,curdate())) DaysToDue,');
      sl.Add('DateDiff(ifnull(T.ToDoByDate,curdate()), T.CreatedDate) DaysAllocated,');
      sl.Add('TD.DateCreated, TD.Responded, TD.Done AS "Completed", TD.Results, E.Title, E.Firstname, E.LastName, E.EmployeeName,');
      sl.Add('Floor((UNIX_TIMESTAMP(TD.Responded)-UNIX_TIMESTAMP(TD.DateCreated)) / 86400) AS Days, ');
      sl.Add('Floor(((UNIX_TIMESTAMP(TD.Responded)-UNIX_TIMESTAMP(TD.DateCreated)) % 86400) / 3600) AS Hours, ');
      sl.Add('Floor((((UNIX_TIMESTAMP(TD.Responded)-UNIX_TIMESTAMP(TD.DateCreated)) % 86400) % 3600) / 60 ) AS Mins, ');
      sl.Add('Floor((((UNIX_TIMESTAMP(TD.Responded)-UNIX_TIMESTAMP(TD.DateCreated)) % 86400) % 3600) % 60 ) AS Secs, ');
      SL.Add('T.Completed as TODOCompleted,');
      SL.Add('T.Active as TODOActive,');
      SL.Add('T.LinkTo as LinkTo,');
      SL.Add('T.LinkToID as LinkToID');
      sl.Add('FROM tbltodo T ');
      sl.Add('INNER JOIN tblemployees E on (E.EmployeeID = T.EmployeeID) ');
      sl.Add('LEFT JOIN tbltodolines TD on (T.ToDoID = TD.ToDoID) and TD.deleted ="F" ');
      sl.Add('LEFT JOIN tblEmployees C on (C.EmployeeID = T.CreatedByEmployeeID) ');

      {filter for daterange}
(*      if chkIgnoreDates.Checked = False then
        sl.Add('where ( T.ToDoByDate between "' + FormatDateTime(MySQLDateTimeFormat,dtFrom.Date) + '" and "' + FormatDateTime(MySQLDateTimeFormat,dtTo.Date) + '"')
      else sl.Add('where ( T.ToDoByDate >0');*)
      sl.Add('where ( T.ToDoByDate between "' + FormatDateTime(MySQLDateTimeFormat,filterdatefrom) + '" and "' + FormatDateTime(MySQLDateTimeFormat,Filterdateto) + '"');

      {filter for selected Employee}
      if (not chkAllEmployees.Checked) and (iEmployeeID <> 0) then { single employee }
        if ChkCreatedBy.Checked then sl.Add('and T.CreatedByEmployeeID = ' + IntToStr(iEmployeeID)) else sl.Add('and T.EmployeeID = ' + IntToStr(iEmployeeID));

      {grpfilter selection}
      case grpFilters.ItemIndex of
        0: sl.Add('and  T.Completed = "F" and T.Active ="T"');
        1: sl.Add('and T.Completed = "T" and T.Active ="T"');
        2: sl.Add('and T.Active ="F"');
      end;
      sl.add(')');

      (*{if employee Selected - report to Todos of the employee which are overdue }
      if ((not chkAllEmployees.Checked) and (iEmployeeID <> 0)) and (grpFilters.ItemIndex <> 1)  then begin
        sl.Add(' Or (');
        if ChkCreatedBy.Checked then sl.Add('C.ReportsTo = ' + IntToStr(iEmployeeID)) else sl.Add(' E.ReportsTo = ' + IntToStr(iEmployeeID));
        sl.Add('and Now() > T.ToDoByDate and T.Completed = "F"');
        sl.Add(')');
      end;*)
      //sl.Add('order by ToDoByDate DESC');
      sl.Add('Order by    EmployeeName, DaysSinceCreated /*OverdueDays*/ desc ,todoid , DateCreated desc ');

      result:= Sl.text;
    finally
      sl.Free;
    end;
  finally
    EnableForm;
  end;
end;

//function TToDoListGUI.DoDtFromChange(Sender:TObject): boolean;
//begin
//  inherited;
//  if (fsShowing in Self.FormState) or (fsCreating in Self.FormState) then Exit;
//  RefreshQuery;
//end;

//procedure TToDoListGUI.dtToChange(Sender: TObject);
//begin
//  inherited;
//  if (fsShowing in Self.FormState) or (fsCreating in Self.FormState) then Exit;
//  RefreshQuery;
//end;

procedure TToDoListGUI.ChkCreatedByClick(Sender: TObject);
begin
  inherited;
  if (fsShowing in Self.FormState) or (fsCreating in Self.FormState) then Exit;
  if screen.ActiveControl = ChkCreatedBy then begin
    if ChkCreatedBy.checked then chkAllEmployees.checked :=False;
    RefreshQuery;
  end;
end;

function TToDoListGUI.HasVaildResult(const ToDoID: Integer): Boolean;
begin
  qryTestResult.Close;
  qryTestResult.Params.ParamByName('xID').AsInteger := ToDoID;
  qryTestResult.Open;
  Result := (qryTestResult.RecordCount<>0);
  qryTestResult.Close;
end;


procedure TToDoListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  If (sametext(Field.FieldName,'Result')) then begin
    If HasVaildResult(qryMain.FieldByName('ToDoID').AsInteger) then Begin
      ABrush.Color := clRed;
    end;
  end else If (sametext(Field.FieldName,'OverdueDays')) then  begin
    if QrymainOverdueDays.AsInteger<1 then
      afont.Color := Abrush.Color;
  (*end else If (sametext(Field.FieldName,qryMainDaysToDue.FieldName)) then  begin
    if qryMainDaysToDue.AsInteger<1 then
      afont.Color := Abrush.Color;*)
  end;
end;

procedure TToDoListGUI.grdMainDblClick(Sender: TObject);
begin
  if ((grdMain.SelectedField = qryMainLinkTo) or (grdMain.SelectedField = qryMainLinkToID)) and (qryMainLinkTo.AsString <> '')  then begin
    if SameText(qryMainLinkTo.AsString, 'Smart Order') then begin
      OpenERPForm('TSmartOrderGUI', qryMainLinkToID.AsInteger);
    end else if SameText(qryMainLinkTo.AsString, 'Purchase Order Change') then begin
      OpenERPForm('TfmPurchaseOrderChange', qryMainLinkToID.AsInteger);
    end else if SameText(qryMainLinkTo.AsString, 'Purchase Order') then begin
      OpenERPForm('TPurchaseGUI', qryMainLinkToID.AsInteger);
    end
    else if SameText(qryMainLinkTo.AsString, 'Credit') then begin
      OpenERPForm('TCreditGUI', qryMainLinkToID.AsInteger);
    end
    else if SameText(qryMainLinkTo.AsString, 'Bill') then begin
      OpenERPForm('TBillGUI', qryMainLinkToID.AsInteger);
    end;

    exit;
  end;

  if qryMainType.AsString = 'ToDo' then
    SubsequentID := ''
  else
    SubsequentID := '_' + qryMainType.AsString;
  inherited;
end;

procedure TToDoListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TToDoListGUI.FilterSelectedEmployees(Sender: TObject);
var
  s:String;
begin
  if not(Sender is TBaseListingGUI) then exit;
  s:= IDs('employeeID', true);
  if s= '' then s:= '0';
  s:= '([EmployeeID] = "' + replaceStr(s , ',' , '") or ([EmployeeID] = "') + '")';
  TBaseListingGUI(Sender).Initialfilter := s;
end;

procedure TToDoListGUI.SelectEmployeeForEmail(Sender: twwdbgrid);
begin
  SelectedEmployees :=TBaseListingGUI(Sender.Owner).SelectedIDs('employeeID' , true);
end;

procedure TToDoListGUI.cmdEmailClick(Sender: TObject);
var
  emails:String;
  qry : TERPQuery;
  lCount : integer;
  lSilent, lSecret : boolean;
begin
  inherited;
  lCount := 0;
  if qrymain.RecordCount =0 then begin
    MessageDlgXP_Vista('List is blank', mtInformation, [mbOK], 0);
    Exit;
  end;
  OpenERPListFormultiselectModal('TEmployeeExpresslistGUI' , FilterSelectedEmployees, SelectEmployeeForEmail);
  if SelectedEmployees  = '' then begin
    MessageDlgXP_Vista('You haven''t selected any employee to send email to', mtInformation, [mbOK], 0);
    Exit;
  end;
//  With TempMyQuery do try
  qry := tempMyQuery;
  try
    qry.SQL.Add('Select EmployeeID, EmployeeName, Email from tblemployees where employeeId in (' + SelectedEmployees+')');
    qry.open;
    emails:= qry.GroupConcat('Email' ,'' , False,  ';');
    if qry.RecordCount > 1 then
    begin
      lCount := CheckEmailAddresses(qry, 'Employee', 'EmployeeName', 'Email');
      if lCount = 0 then
        exit;
    end;
  finally
    if qry.active then qry.close;
    qry.free;
  end;
  (*
  if emails  = '' then begin
    MessageDlgXP_Vista('None of the selected employee(s) have email addresses', mtInformation, [mbOK], 0);
    Exit;
  end;
  *)

   if not EmailSilentSecret(lCount, false, lSilent, lSecret) then
   exit;

  PrintTemplate.ReportSQLSupplied := true;
  PrintTemplate.EmailTemplateReport('ToDo List', reportsql, emails, 'Todo List' , 'This is the ToDo List',
    nil, '', nil, '', lSilent, lSecret);
end;

procedure TToDoListGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

initialization
  RegisterClassOnce(TToDoListGUI);
end.
