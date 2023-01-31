unit frmMessagesList;
{ Date     Version Who What
 -------- -------- --- ------------------------------------------------------
 23/12/05  1.00.01 AL  Initial Version
 09/02/06  1.00.02 DSP Changed HiddenFields to HideField.

}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, wwdblook, DateUtils, DBCtrls,
  Forms,  Shader, kbmMemTable, wwcheckbox, DAScript, MyScript, CustomInputBox;

type
  TfrmMessagesListGUI = class(TBaseListingGUI)
    qryEmployee: TERPQuery;
    dblEmployee: TwwDBLookupCombo;
    Label4: TLabel;
    Label5: TLabel;
    cbAll: TCheckBox;
    qryEmployeeEmployeeID: TIntegerField;
    qryEmployeeName: TWideStringField;
    qryMainEmployeeName: TWideStringField;
    qryMainResponsedueOn: TDateField;
    qryMainMessagetype: TWideStringField;
    qryMainactiontype: TWideStringField;
    qryMaindone: TWideStringField;
    qryMainDetails: TWideMemoField;
    qryMainCompany: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainFax: TWideStringField;
    qryMainMobile: TWideStringField;
    qryMainEmail: TWideStringField;
    qryMainName: TWideStringField;
    qryMainLastName: TWideStringField;
    qryMainMessagesID: TIntegerField;
    qryMainDeptName: TWideStringField;
    Bevel1: TBevel;
    Bevel2: TBevel;
    cboClassQry: TERPQuery;
    cboClass: TwwDBLookupCombo;
    Label6: TLabel;
    chkAllClass: TwwCheckBox;
    lblClassTitle: TLabel;
    cboClassQryClassID: TIntegerField;
    cboClassQryClassName: TWideStringField;
    qryMainCallPriority: TWideStringField;
    qryMainCallBetween: TWideStringField;
    qryMainCallBetweenFrom: TWideStringField;
    qryMainCallBetweento: TWideStringField;
    qryMainCallOn: TDateField;
    qryMainTypeName: TWideStringField;
    qryMainTimeSinceLast: TDateTimeField;
    qryMainPeriodSinceLast: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure cboDateRangeCloseUp(Sender: TObject);
    procedure dblEmployeeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cbAllClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
      modified: Boolean);
    procedure chkAllClassClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure actRefreshQryExecute(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
  private
    PeriodChanging : boolean;
    TempTableName: string;
    Procedure ReadGuipref;
    Procedure WriteGuiPref;
    procedure PopulateTempTable;
  Protected

  public
    Procedure RefreshQuery; Override;
  end;

implementation

uses frmMessages, Commonlib,systemlib,  AppEnvironment, FastFuncs, CommonDbLib;

{$R *.dfm}

procedure TfrmMessagesListGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  WriteGuiPref;
  inherited;

end;

procedure TfrmMessagesListGUI.FormCreate(Sender: TObject);
begin
  PeriodChanging := false;
  TempTableName:= CommonDbLib.CreateUserTemporaryTable('tmp_messagelist');
  qryMain.SQL.Clear;
  qryMain.SQL.Add('SELECT ');
  qryMain.SQL.Add('*');
  qryMain.SQL.Add('FROM ' + TempTableName);
  qryMain.SQL.Add('WHERE (ifnull(ResponseDueOn,0) = 0 or ResponseDueOn BETWEEN :DateFrom AND :DateTo)');
  qryMain.SQL.Add('AND (EmployeeID = :EmployeeID or :EmployeeId = 0)');
  qryMain.SQL.Add('AND (DeptID = :DeptID or :DeptID = 0)');
  qryMain.SQL.Add('AND (Done = :Done or :Done = "")');
//  RefreshOrignalSQL;

  PopulateTempTable;
  inherited;
  GuiPrefs.DbGridElement[grdMain].HideFields('ToId,FromId,MessagesID,ClientId,ClientTypeId');
end;

procedure TfrmMessagesListGUI.PopulateTempTable;
var
  s:String;
  Tempfilename:String;
begin
  try
    s:=         //' insert into '  + TempTableName +
          ' Select ' +
          ' ML.EmployeeName, ' +
          ' ML.EmployeeID, ' +
          ' ML.ResponsedueOn, ' +
          ' if(ML.Messagetype="T" , "Telephoned" , "Called-In") as MessageType, ' +
          ' if(ML.actiontype="R" , "Please Ring" , "Will Ring Back") as ActionType, ' +
          ' ML.done, ' +
          ' ML.Details, ' +
          ' M.Company, ' +
          ' M.Phone, ' +
          ' M.Fax, ' +
          ' M.Mobile, ' +
          ' M.Email, ' +
          ' M.Name, ' +
          ' M.LastName, ' +
          ' M.MessagesID, ' +
          ' ML.DeptName, ' +
          ' ML.DeptID, ' +
          ' ML.ResponsedueOn as CallOn, ' +
          ' if(ifnull(ML.CallPriority,5)=0,"0  - Low" , if(ifnull(ML.CallPriority,5)=5,"5  - Standard" , if(ifnull(ML.CallPriority,5)=10,"10 - High" ,ML.CallPriority ))) as CallPriority, ' +
          ' Concat(Date_format(ML.ResponsedueTimeFrom,"%l:%i %p" ) , " and " , Date_format(ML.ResponsedueTimeTo,"%l:%i %p")) as CallBetween, ' +
          ' Date_format(ML.ResponsedueTimeFrom,"%l:%i %p" ) as CallBetweenFrom, ' +
          ' Date_format(ML.ResponsedueTimeTo,"%l:%i %p" ) as CallBetweento, ' +
          ' ML.TypeName, ' +
          ' ML.TimeSinceLast ' +
          ' FROM ' +
          ' tblMessages M ' +
          ' inner join tblMessagelines ML on M.MessagesID = ML.MessagesID ' +
          ' inner join '+TempTableName+'_1 T1 on T1.MaxMessageLineID =ML.ID and T1.messagesId = ML.messagesId' ;

    s:= 'Drop table if exists ' + TempTableName+'_1;'+
        'Create table '+TempTableName+'_1 Select messagesId , Max(Id) MaxMessageLineID from tblMessagelines  group by messagesId;'+
        'ALTER TABLE '+TempTableName+'_1   ADD PRIMARY KEY (`messagesId`),  ADD INDEX `MaxMessageLineID` (`MaxMessageLineID`);'+
        'truncate '+ TempTableName+';' +
        CreateTemporaryTableusingfile('' ,s,
                                'EmployeeName,EmployeeID,ResponsedueOn,MessageType,ActionType,done,Details,Company, ' +
                                'Phone,Fax,Mobile,Email,Name,LastName,MessagesID,DeptName,DeptID,CallOn,CallPriority, ' +
                                'CallBetween,CallBetweenFrom,CallBetweento,TypeName,TimeSinceLast' ,TempTableName ,Tempfilename);
    try
     executesql(s );
    Except
      on E:Exception do begin
        raise Exception.Create(E.Message+chr(13) + s);
      end;
    end;
     DestroyUserTemporaryTable(Tempfilename);
  finally
    AppEnv.UtilsClient.DeleteServerFiles(replaceStr(Tempfilename, '.tmp' , '*.tmp'));
  end;
end;



procedure TfrmMessagesListGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  if qryMainTimeSinceLast.AsDateTime > 0 then begin
    if qryMainTimeSinceLast.AsDateTime >= 1 then
      qryMainPeriodSinceLast.AsString := IntToStr(Trunc(qryMainTimeSinceLast.AsDateTime)) + ' ' +
        FormatDateTime('hh:nn:ss',qryMainTimeSinceLast.AsDateTime)
    else
      qryMainPeriodSinceLast.AsString :=
        FormatDateTime('hh:nn:ss',qryMainTimeSinceLast.AsDateTime);
  end;

end;

procedure TfrmMessagesListGUI.FormDestroy(Sender: TObject);
begin
  inherited;
  DestroyUserTemporaryTable(TempTableName+'_1');
  DestroyUserTemporaryTable(TempTableName);
end;

procedure TfrmMessagesListGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfrmMessagesGUI');
  if Assigned(Form) then begin //if has acess
    with TfrmMessagesGUI(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
    end;
  end;
end;

procedure TfrmMessagesListGUI.grdMainDblClick(Sender: TObject);
Var Form : TComponent;
begin
  if FormStillOpen('TfrmMessagesGUI') then TForm(FindExistingComponent('TfrmMessagesGUI')).Close;
  Form := GetComponentByClassName('TfrmMessagesGUI');
  if Assigned(Form) then begin //if has acess
    with TfrmMessagesGUI(Form) do begin
      TfrmMessagesGUI(Form).KeyID := qryMain.FieldByName('MessagesID').AsInteger;
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;


procedure TfrmMessagesListGUI.cboDateRangeCloseUp(Sender: TObject);
begin
  PeriodChanging := true;
  inherited;
  PeriodChanging := false;
end;



procedure TfrmMessagesListGUI.actRefreshQryExecute(Sender: TObject);
begin
  PopulateTempTable;
  inherited;
end;


procedure TfrmMessagesListGUI.FormShow(Sender: TObject);
begin
  qryEmployee.Open;
  cboClassQry.Open;
  qryEmployee.Locate('EmployeeID',AppEnv.Employee.EmployeeID,[loCaseInsensitive]);
  //dblEmployeeCloseUp(nil,nil,nil,true);
  dblEmployee.Text := qryEmployee.FieldByName('Name').AsString;
  qryMain.Close;
  //qryMain.ParamByName('EmployeeID').AsInteger := qryEmployee.FieldByName('EmployeeID').AsInteger;
  ReadGuipref;
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields(
    'TimeSinceLast');
  if self.ErrorOccurred then Exit;
end;


procedure TfrmMessagesListGUI.RefreshQuery;
begin
  closedb(Qrymain);
  qryMain.ParamByName('DateFrom').AsDateTime := FilterDateFrom;
  qryMain.ParamByName('Dateto').AsDateTime := FilterDateTo;
  {Employee filter}
  if not(cbAll.checked) then
    qryMain.ParamByName('EmployeeID').asInteger :=qryEmployeeEmployeeID.asInteger
  else qryMain.ParamByName('EmployeeID').asInteger := 0;
  {class filter}
  if not(chkAllClass.checked)     then
    qryMain.ParamByName('DeptID').asInteger     :=cboClassQryClassID.asInteger
  else
    qryMain.ParamByName('DeptID').asInteger     := 0;

       if grpFilters.itemindex =0 then qryMain.ParamByName('done').asString := 'T'
  else if grpFilters.itemindex =1 then qryMain.ParamByName('done').asString := 'F'
  else qryMain.ParamByName('done').asString:= '';
  inherited;
end;

procedure TfrmMessagesListGUI.WriteGuiPref;
begin
  GuiPrefs.Node['General.Datefrom'].AsString                  := DatetoStr(dtFrom.Date);
  GuiPrefs.Node['General.DateTo'].AsString                    := Datetostr(dtto.Date);
  GuiPrefs.Node['General.usedate'].AsString                   := BooleanToStr(chkIgnoreDates.checked);
  GuiPrefs.Node['General.FilterIndex'].asInteger              := grpFilters.itemindex;
  GuiPrefs.Node['Options.AllClasses'].AsString                := BooleanToStr(chkAllClass.checked);
  GuiPrefs.Node['Options.Allemployees'].AsString              := BooleanToStr(cbAll.checked);
  GuiPrefs.Node['Options.EmployeeID'].asInteger               := qryEmployeeEmployeeID.asInteger;
  GuiPrefs.Node['Options.ClassID'].asInteger                  := cboClassQryClassID.asInteger;
end;
procedure TfrmMessagesListGUI.ReadGuipref;
begin
    if GuiPrefs.Node.Exists('General') then begin
      (*dtFrom.Date :=0;
      dtto.Date                   := strTodate(GuiPrefs.Node['General.DateTo'].AsString);
      dtFrom.Date                 := strTodate(GuiPrefs.Node['General.Datefrom'].AsString);
      fbDateRangeSupplied         := true;*)
      chkIgnoreDates.checked      := StrToBoolean(GuiPrefs.Node['General.useDate'].AsString);
      grpFilters.itemindex        := GuiPrefs.Node['General.FilterIndex'].asInteger;

(*    end else begin
      dtFrom.Date                 := Date - appenv.Employee.ListDaysPast;
      dtTo.Date                   := Date + appenv.Employee.ListDaysFuture;*)
    end;
    if GuiPrefs.Node.Exists('Options') then begin
      cbAll.checked               := StrToBoolean(GuiPrefs.Node['Options.Allemployees'].AsString);
      if not(cbAll.checked) then begin
        opendb(cboClassQry);
        if (cboClassQry.Locate('ClassId' ,GuiPrefs.Node['Options.ClassID'].asInteger , [])) then
          cboClass.text :=cboClassQryclassname.text;
      end;

      chkAllClass.checked         := StrToBoolean(GuiPrefs.Node['Options.AllClasses'].AsString);
      if not(chkAllClass.checked) then begin
        opendb(qryEmployee);
        if qryEmployee.Locate('employeeID' ,GuiPrefs.Node['Options.EmployeeID'].asInteger , []) then
          dblEmployee.text :=qryEmployeeName.asString;
      end;
    end;
end;
procedure TfrmMessagesListGUI.cboClassCloseUp(Sender: TObject; LookupTable,  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  RefreshQuery;
end;
procedure TfrmMessagesListGUI.chkAllClassClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;
procedure TfrmMessagesListGUI.dblEmployeeCloseUp(Sender: TObject;  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  RefreshQuery;
end;
procedure TfrmMessagesListGUI.cbAllClick(Sender: TObject);
begin
  RefreshQuery;
end;
procedure TfrmMessagesListGUI.grpFiltersClick(Sender: TObject);
begin
  RefreshQuery;
end;

initialization
  RegisterClassOnce(TfrmMessagesListGUI);

end.
