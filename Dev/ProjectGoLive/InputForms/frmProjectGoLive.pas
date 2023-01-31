unit frmProjectGoLive;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase, BusObjGoLive, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, Mask, wwdbedit, wwdblook, BusObjEmployee, TrainingLib, ActnList,
  DNMAction, Wwdbspin, wwcheckbox;

type
  TfmProjectGoLive = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    grdGoLive: TwwDBGrid;
    btnDelete: TwwIButton;
    qrygolive: TERPQuery;
    qrygoliveGlobalRef: TWideStringField;
    qrygoliveGoLiveId: TIntegerField;
    qrygoliveEmployeeId: TIntegerField;
    qrygoliveModuleId: TIntegerField;
    qrygolivedays: TFloatField;
    qrygoliveDoneAt: TDatetimeField;
    qrygoliveStartedAt: TDatetimeField;
    qrygoliveAddition: TWideStringField;
    qrygoliveDescription: TWideStringField;
    qrygoliveStepNo: TIntegerField;
    qrygoliveOrderNo: TIntegerField;
    qrygoliveAttachmentName: TWideStringField;
    qrygolivemsTimeStamp: TDateTimeField;
    qrygolivemsUpdateSiteCode: TWideStringField;
    lblcompany: TLabel;
    edtcompany: TEdit;
    dsgolive: TDataSource;
    qrygoliveEmployeeName: TWideStringField;
    cboEmployeeLookup: TERPQuery;
    cboEmployee: TwwDBLookupCombo;
    qrygoliveModuleemployees: TWideStringField;
    qrygoliveHours: TLargeintField;
    qrygoliveModuleName: TWideStringField;
    qryTrainingModules: TERPQuery;
    cboTrainingModules: TwwDBLookupCombo;
    qryTrainingModulesTrainingModuleId: TIntegerField;
    qryTrainingModulesTrainingModuleName: TWideStringField;
    lblMsg: TLabel;
    DNMPanel4: TDNMPanel;
    btndown: TDNMSpeedButton;
    btnup: TDNMSpeedButton;
    btnERPPopulateERPDefault: TDNMSpeedButton;
    Actionlist: TActionList;
    actERPPopulateERPDefault: TDNMAction;
    qrygoliveDone: TWideStringField;
    qrygoliveStarted: TWideStringField;
    qrygoliveStepType: TIntegerField;
    btnCalendar: TDNMSpeedButton;
    btnEmail: TDNMSpeedButton;
    btnSchedule: TDNMSpeedButton;
    qrygoliveRequiredBy: TDateTimeField;
    btnScript: TDNMSpeedButton;
    btnEmployees: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    mnuNewOptions: TAdvPopupMenu;
    Module1: TMenuItem;
    ask1: TMenuItem;
    Addition1: TMenuItem;
    Summary1: TMenuItem;
    raining1: TMenuItem;
    SaveDialog1: TSaveDialog;
    qrygoliveCategoryNo: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure grdGoLiveDblClick(Sender: TObject);
    procedure grdGoLiveColEnter(Sender: TObject);
    //procedure btnAddModuleClick(Sender: TObject);
    procedure btnAddTaskClick(Sender: TObject);
    procedure btnAddAdditionClick(Sender: TObject);
    procedure btnAddSummaryClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdGoLiveCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdGoLiveEnter(Sender: TObject);
    procedure btnupClick(Sender: TObject);
    procedure btndownClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure actERPPopulateERPDefaultExecute(Sender: TObject);
    procedure btnCalendarClick(Sender: TObject);
    procedure btnEmailClick(Sender: TObject);
    procedure btnScheduleClick(Sender: TObject);
    procedure btnScriptClick(Sender: TObject);
    procedure btnEmployeesClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnAddTrainingclick(Sender: TObject);
  private
    ObjGoLive: TGoLive;
    EmployeeObj :TEmployee;
    fiReSchedAppt, fiNewAppt :Integer;
    fbEmailreportSummary:boolean;
    dt:Tdatetime;
    stscript: TStringlist;
    fbEmployeeForAllModules :Boolean;
    fsEmailSentList , fsEmailNotSentList :String;
    function SaveRecord: Boolean;
    Procedure Openrec;
    procedure NewBusObjinstance;
//    procedure NewRecord;
    procedure FilterSelectedEmployees(Sender: TObject);
    procedure SelectEmployeeForModule(Sender: twwdbgrid);
    procedure SelectEmployeeForModules(Sender: twwdbgrid);
    procedure GridColumnChecks;
    procedure AddorRemoveEmployees(const Sender: TBusObj; var Abort: boolean);
    procedure MakeAppointment(const Sender: TBusObj; var Abort: boolean);
    procedure NewCategoryItem(const Value: tSteptype);
    procedure MoveItem(direction: TMoveModule);
    procedure EmailGoLive(Sender: TObject);
    procedure PrintGoLive(Sender: TObject);
    procedure EmailGoLivecallback (const Sender: TBusObj; var Abort: boolean);
    procedure ShowAttachments(fbDragnDropping: boolean);
    procedure OnAttachmentSave(Sender: TObject);
    procedure AddAttachment(Sender: TObject);
    procedure AusoSchedulecallback(const Sender: TBusObj; var Abort: boolean);
    procedure ScriptCallback(const Sender: TBusObj; var Abort: boolean);
    procedure PrinttoPDFGoLive(Sender: TObject);
    function PrintSummary(Sender: TObject): Boolean;
    procedure DoOnDoNotAskMsgCheck(Sender: TObject);
    procedure InitreportOptionsform(Sender: TObject);
    function Emailreportname(isEmailreportSummary: Boolean): String;
    procedure MakeTaskMenuforGroups(const Sender: TBusObj; var Abort: boolean);
    procedure MakeTrainingMenuforGroups(const Sender: TBusObj; var Abort: boolean);
    procedure NewSubItem(Sender: TObject; const aSteptype :TSTeptype);
    procedure DoShowpopupmenu(Sender: TObject);
    procedure PositionREcinGrid(const Value: TSteptype);
    function NextCategoryNo: Integer;
    procedure InitTemplatenamensql(DoPrintsummary:Boolean; var sSQL, fsREport: String; sWhere:String='');



  Protected
    procedure CommitAndNotify;override;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, BusObjConst, AppEnvironment, CommonFormLib, BaseListingForm,
  tcConst, GridLib, sndkey32,EmployeeExpresslist, DbSharedObjectsObj,
  ERPErrorEmailUtils, CommonDbLib, AppDatabase, BusObjAppointments,
  BusObjClient, DateUtils, frmReportingOptions, frmAttachments,
  BusObjAttachment, CorrespondenceObj, SystemLib, (*frmProjectGoLiveEdit,*)
 ShellAPI,  MySQLConst, LogLib, commonGuiLib, MainformLib, ERPVersionConst,
  tcDataUtils;

{$R *.dfm}

procedure TfmProjectGoLive.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

Function TfmProjectGoLive.SaveRecord :Boolean;
begin
  result:= False;
  ObjGoLive.PostDB;
  if not(ObjGoLive.Save) then exit;
  Result:= True;

end;

procedure TfmProjectGoLive.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  ObjGoLive.Connection.CommitTransaction;
  Self.Close;
end;

procedure TfmProjectGoLive.CommitAndNotify;
begin
  inherited;
  CommitTransaction;

  Notify;

end;

procedure TfmProjectGoLive.btnScheduleClick(Sender: TObject);
begin
  inherited;
  ObjGoLive.first;
  if ObjGoLive.REquiredby =0 then dt := DayStart(incday(date,1)) else dt := ObjGoLive.Requiredby;
  ObjGoLive.Iteraterecords(AusoSchedulecallback);
end;
procedure TfmProjectGoLive.btnScriptClick(Sender: TObject);
begin
  inherited;
  stscript:= TStringlist.create;
  try
    stscript.add('truncate erpnewdb.tblgolive ;');
     ObjGoLive.Iteraterecords(ScriptCallback);
  finally
    clog(stscript.text);
    Freeandnil(stscript);
  end;
end;
procedure TfmProjectGoLive.ScriptCallback(const Sender: TBusObj; var Abort: boolean);
var
  ctr:Integer;
  s:String;
begin
  s:= '';
  for ctr:= 0 to ObjGoLive.Dataset.fields.count-1 do begin
         if sametext(ObjGoLive.Dataset.fields[ctr].Fieldname ,qrygoliveGlobalRef.fieldname) then
    else if sametext(ObjGoLive.Dataset.fields[ctr].Fieldname ,qrygolivemstimestamp.fieldname) then
    else if sametext(ObjGoLive.Dataset.fields[ctr].Fieldname ,qrygolivemsupdatesitecode.fieldname) then
    else if (ObjGoLive.Dataset.fields[ctr].fieldkind = fkdata) and (ObjGoLive.Dataset.fields[ctr].value <> null) then begin
      if s<> '' then s:= s +',' ;
        if (ObjGoLive.Dataset.fields[ctr] is TIntegerField) or (ObjGoLive.Dataset.fields[ctr] is TLargeIntField) then
            s:=s+ ObjGoLive.Dataset.fields[ctr].fieldname +'=' + inttostr(ObjGoLive.Dataset.fields[ctr].asInteger)
        else if (ObjGoLive.Dataset.fields[ctr] is TdateTimefield) then
          s:=s+ ObjGoLive.Dataset.fields[ctr].fieldname +'=' + Quotedstr(formatdatetime(MysqlDateTimeFormat , ObjGoLive.Dataset.fields[ctr].asDatetime))
        else if (ObjGoLive.Dataset.fields[ctr] is TFloatfield) then
          s:=s+ ObjGoLive.Dataset.fields[ctr].fieldname +'=' + Floattostr(ObjGoLive.Dataset.fields[ctr].asfloat)
        else
          s:=s+ ObjGoLive.Dataset.fields[ctr].fieldname +'=' + Quotedstr(ObjGoLive.Dataset.fields[ctr].asString);
    end;
  end;
  if s<> '' then
    stscript.add( 'INSERT INTO erpnewdb.tblgolive  Set ' + s+';');

end;
procedure TfmProjectGoLive.AusoSchedulecallback(const Sender: TBusObj; var Abort: boolean);
  var
    fi:Integer;
begin
  if sender is TGoLive then begin
    if (*(ObjGoLive.ModuleStepType = stSummary) or*) (ObjGoLive.ModuleStepType = stAddition) then exit;
    if (ObjGoLive.REquiredby =0) then begin
      //if ObjGoLive.Days =0 then ObjGoLive.Days := 1;
      //ObjGoLive.REquiredby := inchour(dt,trunc(ObjGoLive.hours));
      if ObjGoLive.Days >0 then begin
        if trunc(ObjGoLive.Days) =ObjGoLive.Days then
          ObjGoLive.Requiredby := incday(dt,trunc(ObjGoLive.Days))
        else ObjGoLive.Requiredby := inchour(dt,trunc(commonlib.round(ObjGoLive.Days* Appenv.Companyprefs.HoursinaDay,0)));

        While ObjGoLive.Requiredby > DayEnd(Dateof(ObjGoLive.Requiredby)) do begin
          fi :=MinutesBetween(ObjGoLive.Requiredby,DayEnd(Dateof(ObjGoLive.Requiredby)));
          if fi=0 then break;
          dt:=DayStart(incday(Dateof(ObjGoLive.Requiredby),1));
          ObjGoLive.Requiredby := IncMinute(dt, fi);
        end;




        While dt <= ObjGoLive.Requiredby do begin // check if any of the day is a holiday
          if IsDateholiday(dt) then ObjGoLive.Requiredby := incday(ObjGoLive.Requiredby,1);
          dt := incday(dt);
        end;

        dt:=ObjGoLive.REquiredby;
      end;
    end;
    //(*if dt<ObjGoLive.REquiredby then *)dt:=ObjGoLive.REquiredby;
  end;
end;
procedure TfmProjectGoLive.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
             if Sender is TGoLive        then TGoLive(Sender).Dataset  := qrygolive(*
        else if Sender is TGoLiveModules then TGoLive(Sender).Dataset  := qrygolivemodules*);
     end else if (Sender is TGoLive) and
                ( ((EventType = BusObjEvent_Dataset) and (Sender.IsdataIdchangeEvent(Value))) Or
                ((EventType = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterPost)) or
                ((EventType = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterOpen))  ) then begin
      ObjGoLive.GoLiveModules;
      //qrygoliveAddition.Readonly :=  ((ObjGoLive.ModuleStepType <> stAddition) and (ObjGoLive.ModuleStepType <> stSummary)) or (Accesslevel >3);
      //qrygoliveDone.Readonly :=  ((ObjGoLive.ModuleStepType <> stSummary)) or (Accesslevel >3);
     end;
end;

procedure TfmProjectGoLive.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TfmProjectGoLive.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if ObjGoLive.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveRecord then begin
            CommitAndNotify;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          ObjGoLive.Dirty := false;
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

procedure TfmProjectGoLive.FormCreate(Sender: TObject);
begin
  inherited;
  fbEmployeeForAllModules := False;
  fbEmailreportSummary := False;
   NewBusObjinstance;
   //GuiPrefs.AddFieldPair(qrygolivedays.FieldName, qrygoliveHours.FieldName, qrygolive);
end;
procedure TfmProjectGoLive.FormShow(Sender: TObject);
begin
  edtcompany.Text := Appenv.CompanyInfo.CompanyName ;
  inherited;
  OpenRec;
  btnScript.visible := Devmode;
end;

procedure TfmProjectGoLive.grdGoLiveCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if Field.readonly then AFont.color := GridcolInactive;
  Afont.Color := clblack;
  if ObjGoLive.ModuleStepType = stTask     then begin
      if sametext(field.Fieldname , qrygolivedescription.Fieldname) then ABrush.Color := GridColhighLightGreen;
  end else if ObjGoLive.ModuleStepType = stTraining then begin
      if sametext(field.Fieldname , qrygolivedescription.Fieldname) then ABrush.Color := GridColhighLightBlue;
  end else if ObjGoLive.ModuleStepType = stSummary  then begin
      ABrush.Color := GridColhighLightRed;
      Afont.Style :=  Afont.Style + [fsBold];
      Afont.Color := clblack;
  end else if ObjGoLive.ModuleStepType = stAddition then begin
      ABrush.Color := GridColHighLightDarkGreen;
      Afont.Style :=  Afont.Style + [fsBold];
      Afont.Color := clblack;
  end;
  if sametext(field.Fieldname , qrygoliveStepno.Fieldname) then
    if (qrygoliveStepno.asInteger = 0) or (ObjGoLive.ModuleStepType = stSummary) then
      Afont.color := ABrush.Color;

  if (ObjGoLive.ModuleStepType = stAddition) or (ObjGoLive.ModuleStepType = stSummary)  then begin
  {hide Stepno from details}
    if Sametext(Field.fieldname ,qrygoliveStepno.fieldname) then   AFont.color := ABrush.color;
  end else begin
  {hide the group heading from details}
    if Sametext(Field.fieldname ,qrygoliveAddition.fieldname) then   AFont.color := ABrush.color;
  end;


end;

procedure TfmProjectGoLive.grdGoLiveColEnter(Sender: TObject);
begin
  inherited;
  GridColumnChecks;
end;
procedure TfmProjectGoLive.btnCalendarClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  ObjGoLive.Connection.CommitTransaction;
  ObjGoLive.Connection.BeginTransaction;
  try
    fiReSchedAppt := 0;
    fiNewAppt := 0;
    DoShowProgressbar(ObjGoLive.count,WAitMsg);
    try
      ObjGoLive.Iteraterecords(MakeAppointment);
    finally
      DoHideProgressbar;
    end;
  finally
    ObjGoLive.Connection.CommitTransaction;
    ObjGoLive.Connection.BeginTransaction;
  end;
end;

procedure TfmProjectGoLive.MakeAppointment(const Sender: TBusObj;var Abort: boolean);
var
  App : TAppointment;
begin
  DoStepProgressbar;
  if sender is TGoLive then begin
   if  (TGoLive(Sender).RequiredBy <>0) and (ObjGoLive.days>0) then begin
      TGoLive(Sender).GoLiveModules.Iteraterecords(MakeAppointment);
   end;
  end else if sender is TGoLiveModules then begin
        App := TAppointment.Create(nil);
        try
          App.Connection := TMyDacDataConnection.Create(App);
          App.Connection.Connection := MyConnection;

          if TGoLiveModules(Sender).AppointmentId > 0 then begin
            App.Load(TGoLiveModules(Sender).AppointmentId);
            fiReSchedAppt :=fiReSchedAppt+1;
          end else begin
            App.New;
            fiNewAppt := fiNewAppt +1;
          end;
          App.AppDate := ObjGoLive.RequiredBy;
          App.CreationDate := Date;
          App.LocalApp := true;
          App.ClientId := TClient.CmpanyInfoClientID(self, True, False, False);
          App.EndTime   := ObjGoLive.RequiredBy;
          if trunc(ObjGoLive.Days) =ObjGoLive.Days then App.StartTime := incday(App.EndTime ,   trunc(0-ObjGoLive.days))
          else App.StartTime := inchour(App.EndTime,0-trunc(commonlib.round(ObjGoLive.Days* Appenv.Companyprefs.HoursinaDay,0)));
          App.TrainerID := TGoLiveModules(Sender).EmployeeId;
          App.LastTrainerID := TGoLiveModules(Sender).EmployeeId;
          App.CustomerDetails := 'Training Session on ' + ObjgoLive.ModuleName;
          App.Notes := 'GoLive:' + NL+ Trim(ObjGoLive.Addition +NL+ObjGoLive.Description);
          App.Save;
          if (App.ID > 0) and (TGoLiveModules(Sender).AppointmentId <> App.ID )then begin
            TGoLiveModules(Sender).AppointmentId := App.ID;
            TGoLiveModules(Sender).PostDB;
          end;
        finally
          Freeandnil(App);
        end;
  end;
end;

procedure TfmProjectGoLive.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if MessageDlgXP_Vista('Delete This Entry?', mtConfirmation, [mbYes, mbNo], 0) = mryes then
    ObjGoLive.Delete;
end;

procedure TfmProjectGoLive.GridColumnChecks;
begin
  if sametext( GridLib.ActiveFieldname(grdGoLive), qrygoliveHours.FieldName) then begin
     if accesslevel <=3 then begin
        ObjGoLive.EditDB;
     end;
(*  end else if sametext(GridLib.ActiveFieldname(grdGoLive) , qrygoliveStepNo.fieldname) then begin
    if IsFormshown then SendKeys('{TAB}',True); // this is a readonly field*)
  end else if GridLib.ActiveField(grdGoLive).readonly then begin
    if IsFormshown then SendKeys('{TAB}',True);
  end;

end;
procedure TfmProjectGoLive.grdGoLiveDblClick(Sender: TObject);
begin
  inherited;
  if sametext( GridLib.ActiveFieldname(grdGoLive) , qrygoliveModuleemployees.FieldName) then begin
    if accesslevel <=3 then begin
        OpenERPListFormultiselectModal('TEmployeeExpresslistGUI' , FilterSelectedEmployees, SelectEmployeeForModule);
    end;
  end else if sametext( GridLib.ActiveFieldname(grdGoLive) , qrygoliveStarted.FieldName) Or
     sametext( GridLib.ActiveFieldname(grdGoLive) , qrygoliveStartedAt.FieldName)   then begin
        if ObjGoLive.ItemStarted = False then ObjGoLive.ItemStarted  := TRue;
        if ObjGoLive.StartedAt = 0 then ObjGoLive.StartedAt := now;
  end else if sametext( GridLib.ActiveFieldname(grdGoLive) , qrygoliveDone.FieldName) Or
     sametext( GridLib.ActiveFieldname(grdGoLive) , qrygoliveDoneAt.FieldName)   then begin
        if ObjGoLive.itemDone= False then ObjGoLive.itemDone  := TRue;
        if ObjGoLive.DoneAt = 0 then ObjGoLive.DoneAt:= now;
  end else if sametext( GridLib.ActiveFieldname(grdGoLive) , qrygoliveAttachmentname.FieldName) then begin
    ShowAttachments(False);
  (*end else begin
    if accesslevel <= 3 then begin
      With TfmProjectGoLiveEdit.create(Self) do try
        caption := ObjGoLive.SteptypeStr;
        ObjGoLive.Connection.begintransaction;
        ObjGoLive.Connection.beginnestedTransaction;
        if ShowModal = mrok then
          ObjGoLive.Connection.CommitnestedTransaction
        else
          ObjGoLive.Connection.RollbacknestedTransaction;

      finally
        Free;
      end;
    end;*)
  end;
end;
procedure TfmProjectGoLive.grdGoLiveEnter(Sender: TObject);
begin
  inherited;
  if  (ObjGoLive.count =0) and (ObjGoLive.Dataset.state = dsBrowse) then begin
      TimerMsg(lblMsg , 'Please Add a new Item - Module / task / Addition Or Summary');
      Setcontrolfocus(btnNew);
  end;
end;

procedure TfmProjectGoLive.FilterSelectedEmployees(Sender: TObject);
var
  s:String;
begin
  if not(Sender is TBaseListingGUI) then exit;
  s:= ObjGoLive.GoLiveModules.ModuleEmployeeIds;
  (*if s= '' then s:= '0';
  s:= '([EmployeeID] = "' + replaceStr(s , ',' , '") or ([EmployeeID] = "') + '")';
  TBaseListingGUI(Sender).Initialfilter := s;*)
  TBaseListingGUI(Sender).SearchMode := smFullList;
  TBaseListingGUI(Sender).Selectrecordsfieldname := 'EmployeeID';
  TBaseListingGUI(Sender).SelectrecordsValues := s;

end;
procedure TfmProjectGoLive.SelectEmployeeForModules(Sender: twwdbgrid);
begin
  fbEmployeeForAllModules := True;
  try
    SelectEmployeeForModule(Sender);
  finally
    fbEmployeeForAllModules := False;
  end;
end;
procedure TfmProjectGoLive.SelectEmployeeForModule(Sender: twwdbgrid);
var
  fsSelectedEmployees:String;
begin
  fsSelectedEmployees := TEmployeeExpresslistGUI(Sender.Owner).SelectedIDs('employeeId' , True );
  if fsSelectedEmployees = '' then fsSelectedEmployees := '0';

  EmployeeObj := TEmployee.create(self);
  with EmployeeObj do try
    Connection := ObjGoLive.Connection;
    LoadSelect('EmployeeID in (' +fsSelectedEmployees+')');
    if not fbEmployeeForAllModules then ObjGoLive.GoLiveModules.Iteraterecords(AddorRemoveEmployees); // remove the employees not selected
    if count >0 then
      if fbEmployeeForAllModules then ObjGoLive.Iteraterecords(AddorRemoveEmployees)
      else Iteraterecords(AddorRemoveEmployees);
    ObjGoLive.Moduleemployees :=ObjGoLive.GoLiveModules.GroupConcat('EmployeeName');
    ObjGoLive.PostDB;

  finally
    Free;
  end;


(*  if Sender.Datasource.dataset.findfield('Employeeid') <> nil then
    if Sender.Datasource.dataset.fieldbyname('Employeeid').asInteger <> 0 then
      if ObjGoLive.GoLiveModules.Locate('employeeId' ,Sender.Datasource.dataset.fieldbyname('Employeeid').asInteger , []) = False then begin
        ObjGoLive.GoLiveModules.New;
        ObjGoLive.GoLiveModules.EmployeeId :=Sender.Datasource.dataset.fieldbyname('Employeeid').asInteger;
        ObjGoLive.GoLiveModules.PostDB;
      end;*)
end;
procedure TfmProjectGoLive.actERPPopulateERPDefaultExecute(Sender: TObject);
var
  cmd :TERPCommand;
begin
  inherited;
  if ObjGoLive.count >0 then
    if MessageDlgXP_Vista('Do You wish to Delete All Existing Steps and Create the ERP Default List?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
  cmd := DbSharedObj.Getcommand(ObjGoLive.Connection.connection);
  try
    cmd.SQL.Clear;
    cmd.SQL.AdD('DROP table if exists `tblgolive`;');
    cmd.SQL.AdD('TRUNCATE `tblgolivemodules`;');
    cmd.SQL.AdD('Delete from tblattachments where TableName =' + quotedstr(objGoLive.BusObjectTablename)+';');

    cmd.SQL.AdD('create table `tblgolive` like erpnewdb.tblgolive;');
    cmd.SQL.AdD('Insert ignore into tblgolive Select * from erpnewdb.tblgolive;');

    try
      cmd.Execute;
      ObjGoLive.Closedb;
      ObjGoLive.Load;
      Setcontrolfocus(grdGoLive);
    Except
      on E:Exception do begin
        MessageDlgXP_Vista('Populating the Default List of Tasks Failed . Please contact ERP', mtWarning, [mbOK], 0);
            SendEmailtoErp('Error from GoLive', 'User :' + Appenv.Employee.EmployeeName +NL +
                                                  'Company     :' + Appenv.CompanyInfo.Companyname + NL +
                                                  'Server      :' + GetSharedMyDacConnection.Server + NL +
                                                  'Datase      :' + GetSharedMyDacConnection.Database + NL +
                                                  'Version     :' + TABLE_VERSION+NL+NL+
                                                  'Populating Default List' +NL+
                                                  e.Message);
      end;
    end;
  finally
    DbSharedObj.ReleaseObj(cmd);
  end;

end;

Procedure TfmProjectGoLive.AddorRemoveEmployees(Const Sender: TBusObj; var Abort: boolean);
begin
   if sender is TEmployee then begin
      if ObjGoLive.GoLiveModules.Locate('employeeId' ,TEmployee(Sender).ID , []) = False then begin
        ObjGoLive.GoLiveModules.New;
        ObjGoLive.GoLiveModules.EmployeeId :=TEmployee(Sender).ID;
        ObjGoLive.GoLiveModules.PostDB;
      end;
   end else if sender is TGoLive then begin
      if fbEmployeeForAllModules and ((ObjGoLive.ModuleStepType = stsummary) or (ObjGoLive.ModuleStepType =  stAddition)) then
      else EmployeeObj.Iteraterecords(AddorRemoveEmployees);
   end else if sender is TGoLiveModules then begin
    if not(EmployeeObj.Locate('EmployeeId' ,ObjGoLive.GoLiveModules.EmployeeId , [])) then
      ObjGoLive.GoLiveModules.Delete;
   end;
end;

procedure TfmProjectGoLive.NewBusObjinstance;
begin
  {$WARNINGS OFF}
  ObjGoLive := TGoLive.CreateWithNewConn(Self);
  ObjGoLive.Connection.connection := Self.MyConnection;
  ObjGoLive.BusObjEvent := DoBusinessObjectEvent;
  {$WARNINGS ON}
end;

(*
procedure TfmProjectGoLive.NewRecord;
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
*)

procedure TfmProjectGoLive.Openrec;
begin
  ObjGoLive.Load;
  ObjGoLive.connection.BeginTransaction;
  openQueries;
  ObjGoLive.Dirty := false;
end;
procedure TfmProjectGoLive.btndownClick(Sender: TObject);begin  inherited;  MoveItem(mmDown);end;
procedure TfmProjectGoLive.btnEmailClick(Sender: TObject);
var
  OptsForm: TfmReportingOptions;
begin
  inherited;

  OptsForm := TfmReportingOptions.Create(nil);
  try
    OptsForm.ActionList.AddDivider('Email');        OptsForm.ActionList.Add('Schedule'      , 'Send Personal Reminders (their own Schedule) to All Employees Listed ', EmailGoLive        , true, true, true);
                                                    OptsForm.ActionList.Add('Summary'       , 'Send Email Summary To All Emplyees Listed', EmailGoLive       , true, true, true);

    OptsForm.ActionList.AddDivider('Print');        OptsForm.ActionList.Add('Schedule', 'Print Complete Schedule'                        , PrintGoLive, true, true, true);
                                                    OptsForm.ActionList.Add('Summary' , 'Print Summary Report'                           , PrintGoLive , true, true, true);

    OptsForm.ActionList.AddDivider('Print to PDF'); OptsForm.ActionList.Add('Schedule', 'Export Complete Schedule to a PDF File'                        , PrinttoPDFGoLive, true, true, true);
                                                    OptsForm.ActionList.Add('Summary' , 'Export Summary Report to a PDF File'                           , PrinttoPDFGoLive , true, true, true);


    OptsForm.InitforParent := InitreportOptionsform;
    OptsForm.ShowModal;
  finally
    FreeAndNil(OptsForm);
  end;
end;
Procedure TfmProjectGoLive.DoOnDoNotAskMsgCheck(Sender:TObject);
begin
  if Sender is TwwCheckBox then
    GuiPrefs.Node['Options.confrimfileOpen'].asBoolean := not(TwwCheckBox(Sender).checked);
end;
Procedure TfmProjectGoLive.InitreportOptionsform(Sender:TObject);
begin
  inherited;
  if sender is TfmReportingOptions then begin
    TfmReportingOptions(Sender).chkEmailprogramconfrmation.visible := True;
    TfmReportingOptions(Sender).chkEmailprogramconfrmation.checked := GuiPrefs.Node.Exists('Options.confrimfileOpen') and not(GuiPrefs.Node['Options.confrimfileOpen'].asBoolean);
    TfmReportingOptions(Sender).chkEmailprogramconfrmation.onclick := DoOnDoNotAskMsgCheck;
    TfmReportingOptions(Sender).chkEmailprogramconfrmation.caption := 'Do not Show "Export To PDF" File Options';
  end;
end;

procedure TfmProjectGoLive.btnEmployeesClick(Sender: TObject);
begin
  inherited;
  OpenERPListFormultiselectModal('TEmployeeExpresslistGUI' , nil, SelectEmployeeForModules);
end;

procedure TfmProjectGoLive.btnNewClick(Sender: TObject);
var
  mnu : TMenuItem;
begin
  inherited;
  //mnuNewOptions.Popup(Mouse.CursorPos.x, Mouse.CursorPos.Y);
  mnuNewOptions.Items.Clear;

  mnu := TMenuItem.Create(self);
  mnu.Caption := 'Addition';
  mnu.OnClick := btnAddAdditionClick;
  mnuNewOptions.Items.Add(mnu);

  mnu := TMenuItem.Create(self);
  mnu.Caption := 'Summary';
  mnu.OnClick := btnAddSummaryClick;
  mnuNewOptions.Items.Add(mnu);

  mnu := TMenuItem.Create(self);
  mnu.Caption := '-';
  mnuNewOptions.Items.Add(mnu);

  mnu := TMenuItem.Create(self);
  mnu.Caption := 'New General Task';
  mnu.OnClick := DoShowpopupmenu;
  mnuNewOptions.Items.Add(mnu);
  ObjGoLive.IterateRecords(MakeTaskMenuforGroups);

  mnu := TMenuItem.Create(self);
  mnu.Caption := '-';
  mnuNewOptions.Items.Add(mnu);

  mnu := TMenuItem.Create(self);
  mnu.Caption := 'New Training Task';
  mnu.OnClick := DoShowpopupmenu;
  mnuNewOptions.Items.Add(mnu);
  ObjGoLive.IterateRecords(MakeTrainingMenuforGroups);

  DoShowpopupmenu(btnNew);
end;
Procedure TfmProjectGoLive.DoShowpopupmenu(Sender:TObject);
begin
  mnuNewOptions.Popup(controlLeft(btnNew)+Self.left+50 , ClientFormTop+controlTop(btnNew)+self.top+50 );
end;
Procedure TfmProjectGoLive.MakeTaskMenuforGroups(Const Sender: TBusObj; var Abort: boolean);
var
  mnu : TMenuItem;
begin
  if sender is TGoLive then
  if (TGoLive(SendeR).ModuleSteptype = stAddition) or
     (TGoLive(SendeR).ModuleSteptype = stSummary ) then begin
    mnu := TMenuItem.Create(self);
    mnu.Caption := '    ->' +TGoLive(SendeR).Category;
    mnu.Tag :=TGoLive(SendeR).ID;
    mnu.OnClick := btnAddTaskClick;
    mnuNewOptions.Items.Add(mnu);
  end;
end;
Procedure TfmProjectGoLive.MakeTrainingMenuforGroups(Const Sender: TBusObj; var Abort: boolean);
var
  mnu : TMenuItem;
begin
  if sender is TGoLive then
  if (TGoLive(SendeR).ModuleSteptype = stAddition) or
     (TGoLive(SendeR).ModuleSteptype = stSummary ) then begin
    mnu := TMenuItem.Create(self);
    mnu.Caption := '    ->' +TGoLive(SendeR).Category;
    mnu.Tag :=TGoLive(SendeR).ID;
    mnu.OnClick := btnAddTrainingClick;
    mnuNewOptions.Items.Add(mnu);
  end;
end;
Function TfmProjectGoLive.PrintSummary(Sender:TObject):Boolean;
begin
  result := False;
  if (Sender<> nil) and (sender is  TDNMSpeedButton) then
    result :=  sametext(TDNMSpeedButton(Sender).caption ,  'Summary');
end;
procedure TfmProjectGoLive.EmailGoLive(Sender: TObject);
var
  qry: TERPQuery;
  employeeIds:String;
  Emp:TEmployee;
  s:String;
begin
  DoShowProgressbar(10,WAitMsg);
  try
    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(ObjGolive.Connection.Connection);
    try
      Qry.SQL.text := 'Select distinct EmployeeId from tblgolivemodules';
      Qry.open;
      DoStepProgressbar;
      employeeIds:=Qry.GroupConcat('employeeId');
      if employeeIds = '' then begin
        MessageDlgXP_vista('Employees are Not Selected for GoLive Modules', mtWarning, [mbOK], 0);
        exit;
      end;
      fbEmailreportSummary := PrintSummary(Sender);
      Emp:= TEmployee.Create(Self);
      try
        DoStepProgressbar;
        EMP.LoadSelect('EmployeeID in (' +employeeIds+')' );
        DoStepProgressbar;
        fsEmailSentList := '';
        fsEmailNotSentList := '';
        try
          EMP.Iteraterecords(EmailGoLivecallback);
        finally
          if fsEmailSentList  <> '' then s:=trim(s + 'Email Sent to the Following '+ NL +fsEmailSentList);
          if fsEmailNotSentList <> '' then s:=trim(s +NL+NL + 'Email Not Sent to the Following as the Email Address is Missing in the Employee Card'+ Nl +fsEmailNotSentList);
          if trim(s) <> '' then begin
            s:= 'Report Name : '+ Emailreportname(fbEmailreportSummary) + NL+NL+ s;
            MessageDlgXP_Vista(s, mtinformation, [mbOK], 0);
          end;
        end;
      finally
        Freeandnil(Emp);
      end;

    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    end;
  finally
    DoHideProgressbar;
  end;
end;
procedure TfmProjectGoLive.InitTemplatenamensql(DoPrintsummary:Boolean;var sSQL:String;var fsREport:String; sWhere:String='');
begin
  if  DOPrintSummary then begin
    fsREport:= 'GoLive - Summary' ;
    ssql:= ssql+ '~|||~'+ sWhere +' Order by Categoryno, orderno , employeename, goliveID';
  end  else begin
    fsREport:= 'GoLive - Employee Schedule';
    ssql:= ssql+ '~|||~'+ sWhere +' Order by moduleemployee, Categoryno, orderno , goliveID';
  end;
end;

procedure TfmProjectGoLive.PrintGoLive (Sender: TObject);
var
  sSQL:String;
  fsREport:String;
begin
  InitTemplatenamensql(PrintSummary(sender),sSQL,fsREport);
  fbReportSQLSupplied := False;
  PrintTemplateReport(fsREport , ssql, not(devmode) and not(appenv.Employee.ShowPreview) ,1);
end;
procedure TfmProjectGoLive.PrinttoPDFGoLive (Sender: TObject);
var
  filename :String;
  sSQL:String;
  fsREport:String;
  msgoption :Word;
begin
  inherited;
  InitTemplatenamensql(PrintSummary(sender), sSQL,fsREport);

  SaveDialog1.FileName :='GoLive - '+fsREport+'.PDF';
  if SaveDialog1.Execute then begin
    filename :=  SaveDialog1.FileName;
  end else begin
    Exit;
  end;

  fbReportSQLSupplied := False;
  //PrintTemplateReport(fsREport , ssql, not(devmode) and not(appenv.Employee.ShowPreview) ,1);
  if SaveTemplateReport(fsREport, ssql, False, 'PDF',filename ) then begin
    if not(GuiPrefs.Node.Exists('Options.confrimfileOpen')) or (GuiPrefs.Node['Options.confrimfileOpen'].asBoolean) then begin
          msgoption := MessageDlgXP_Vista('The report is exported to ' + Quotedstr(FileName), mtInformation, [mbOK], 0 , nil , '' , '' , False, nil , 'Open File Location,Open File,Don''t Ask');
               if msgoption = 100 then ShellExecute(Handle, 'Open', PChar(ExtractFilePath(fileName)) , '', '', SW_SHOWNORMAL)
          else if msgoption = 101 then ShellExecute(Handle, 'Open', PChar(fileName) , '', '', SW_SHOWNORMAL)
          else if msgoption = 102 then  GuiPrefs.Node['Options.confrimfileOpen'].asBoolean := false;
    end;
  end;
end;
function TfmProjectGoLive.Emailreportname(isEmailreportSummary:Boolean):String;
begin
      if isEmailreportSummary then result :='GoLive - Summary'
      else result :=  'GoLive - Employee Schedule';
end;
procedure TfmProjectGoLive.EmailGoLivecallback(const Sender: TBusObj; var Abort: boolean);
var
  sSQL:String;
  fsreportname:String;
begin
  if sender is TEmployee then begin
    if TEmployee(Sender).Email <> '' then begin
      //ssql:= '~|||~ ';
      InitTemplatenamensql(fbEmailreportSummary, ssql, fsreportname, iif(not fbEmailreportSummary , ' AND GLM.employeeId = ' + inttostr(TEmployee(Sender).ID) , ''));
      //if not fbEmailreportSummary then ssql:= ssql+' AND GLM.employeeId = ' + inttostr(TEmployee(Sender).ID);
      //ssql:= ssql+ ' Order by moduleemployee, orderno , goliveID ';
      Emailreport(0 ,TEmployee(Sender).EmployeeName , TEmployee(Sender).email ,'GoLive' ,fsreportname(*Emailreportname(fbEmailreportSummary)*) , sSQL , False , True, True, TRue, true , AddAttachment );
      DoStepProgressbar(TEmployee(Sender).EmployeeName);
      if fsEmailSentList <> '' then fsEmailSentList := fsEmailSentList +NL;
      fsEmailSentList := fsEmailSentList + '    ->' +TEmployee(Sender).EmployeeName;
    end else begin
      timerMsg(lblMsg, 'Employee '+ quotedstr(TEmployee(Sender).EmployeeName)  +' Doesn''t have Email Address');
      if fsEmailNotSentList <> '' then fsEmailNotSentList := fsEmailNotSentList +NL;
      fsEmailNotSentList := fsEmailNotSentList + '    ->' +TEmployee(Sender).EmployeeName;
    end;
  end;
end;
procedure TfmProjectGoLive.AddAttachment(Sender:TObject);
var
  Att: TAttachment;
begin
  if sender is TCorrespondenceGui then begin
      Att := TAttachment.Create(nil);
      try
        Att.Connection := TMyDacDataConnection.Create(Att);
        Att.Connection.Connection := MyConnection;
        Att.LoadSelect('TableName = '+quotedstr(objGoLive.BusObjectTablename) +' and TableId = ' + inttostr(ObjGoLive.ID));
        if Att.Count > 0 then begin
            while not Att.EOF do begin
              Att.SaveToFile(WinTempDir + Att.AttachmentName);
              TCorrespondenceGui(Sender).AttachmentList.Add(WinTempDir + Att.AttachmentName);
              Att.Next;
            end;
        end;
      finally
        Att.Free;
      end;
  end;
end;

procedure TfmProjectGoLive.btnupClick  (Sender: TObject);begin  inherited;  MoveItem(mmUp  );end;
Procedure TfmProjectGoLive.MoveItem(direction :TMoveModule);
begin
  MoveRecEntry(Direction, ObjGoLive , 'OrderNo,stepno');
  grdGoLive.unselectall;
  grdGoLive.SelectRecord;
(*var
  bm:Tbookmark;
  s:String;
  id1, id2:Integer;
begin
  inherited;
  if (direction =mmUp)  and (ObjGoLive.BOF) then exit;
  if (direction =mmDown)  and (ObjGoLive.EOF) then exit;
  id1:= 0;
  ObjGoLive.Dataset.DisableControls;
  try
    bm := ObjGoLive.dataset.GetBookmark;
    try
      id1:= ObjGoLive.Id;
      if direction =mmUp then begin
        ObjGoLive.Prior;
      end else begin
        ObjGoLive.Next;
      end;
      id2:= ObjGoLive.ID;
      ObjGoLive.Connection.BeginNestedTransaction;
      try
        if direction =mmUp then begin
          s:='update ' + ObjGoLive.BusObjectTableName +' Set OrderNo  = OrderNo  -1 where ' +ObjGoLive.IDFieldName +' = ' +IntToStr(id1) +';'+
            'update ' + ObjGoLive.BusObjectTableName +' Set OrderNo  = OrderNo  +1 where ' +ObjGoLive.IDFieldName +' = ' +IntToStr(id2) +';';

        end else begin
          s:= 'update ' + ObjGoLive.BusObjectTableName +' Set OrderNo  = OrderNo  +1 where ' +ObjGoLive.IDFieldName +' = ' +IntToStr(id1) +';'+
              'update ' + ObjGoLive.BusObjectTableName +' Set OrderNo  = OrderNo  -1 where ' +ObjGoLive.IDFieldName +' = ' +IntToStr(id2) +';';
        end;
        ObjGoLive.GetNewDataSet(s,true);
        ObjGoLive.Connection.CommitNestedTransaction;
        ObjGoLive.closeDb;
        ObjGoLive.OpenDB;
      except
          on E:Exception do begin
              ObjGoLive.Connection.RollbackNestedTransaction;
          end;
      end;
    finally
        ObjGoLive.Dataset.RefreshGridnLocateRec(bm);
        ObjGoLive.Dataset.FreeBookmark(bm);
        if id1 <> 0 then ObjGoLive.Dataset.Locate(ObjGoLive.idfieldname , id1, []);
    end;
  finally
      ObjGoLive.dataset.enableControls;
  end;*)
end;
procedure TfmProjectGoLive.OnAttachmentSave(Sender:TObject);
begin
  objgoLive.Attachmentname := objgoLive.Attachmentnames;
  objgoLive.PostDB;
  objgoLive.EditDB;
end;
procedure TfmProjectGoLive.ShowAttachments(fbDragnDropping :boolean);
var
  tmpComponent: TComponent;
begin
  if objGoLive.ID < 1 then Exit; // need sales id
  tmpComponent := TfmAttachments(GetComponentByClassName('TfmAttachments', False, self));

  if not Assigned(tmpComponent) then Exit;
  with TfmAttachments(tmpComponent) do begin
    DBConnection := TERPConnection(objGoLive.connection.connection);
    AttachObserver(Self);
    TableName := objGoLive.BusObjectTablename;
    TableId := objGoLive.ID;
    DragnDropping :=fbDragnDropping;
    FormStyle := fsMDIChild;
    onSave := OnAttachmentSave;
    BringToFront;
  end;
end;
//procedure TfmProjectGoLive.btnAddTaskClick      (Sender: TObject);begin  inherited;  NewItem(stTask)      ;end;
//procedure TfmProjectGoLive.btnAddTrainingclick  (Sender: TObject);begin  inherited;  NewItem(stTraining)  ;end;

procedure TfmProjectGoLive.btnAddAdditionClick  (Sender: TObject);begin  NewCategoryItem(stAddition)            ;end;
//procedure TfmProjectGoLive.btnAddModuleClick    (Sender: TObject);begin  NewCategoryItem(stModule)              ;end;
procedure TfmProjectGoLive.btnAddSummaryClick   (Sender: TObject);begin  NewCategoryItem(stSummary)             ;end;
Procedure TfmProjectGoLive.btnAddTaskClick      (Sender: TObject);begin  NewSubItem(Sender,stTask)    ;end;
Procedure TfmProjectGoLive.btnAddTrainingClick  (Sender: TObject);begin  NewSubItem(Sender,stTraining);end;
procedure TfmProjectGoLive.NewCategoryItem(const Value: tSteptype);
begin
  ObjGoLive.NewItem(Value);
  ObjGoLive.CategoryNo := NextCategoryNo;
  ObjGoLive.PostDB;
  PositionRecinGrid(Value);
end;
Function TfmProjectGoLive.NextCategoryNo:Integer;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(ObjGoLive.Connection.Connection);
  try
    qry.sql.text := 'Select max(CategoryNo) as CategoryNo from tblgolive';
    qry.open;
    result := qry.fieldbyname('CategoryNo').asInteger +1;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;

end;
Procedure TfmProjectGoLive.NewSubItem(Sender:TObject; const aSteptype :TSTeptype);
begin
  ObjGoLive.NewItem(aSteptype);
  if Sender is TMenuItem then begin
    ObjGoLive.Addition   := GOLiveAddition(TMenuItem(Sender).Tag,ObjGoLive.connection.Connection);
    ObjGoLive.Categoryno := GOLiveCategoryno(TMenuItem(Sender).Tag,ObjGoLive.connection.Connection);
    PositionRecinGrid(aSteptype);
  end;
end;
Procedure TfmProjectGoLive.PositionREcinGrid(Const Value :TSteptype);
var
  aid:Integer;
begin
  objgoLive.PostDB;
  aid:=objgoLive.ID;
  objgoLive.RefreshDB;
  if objgoLive.Locate(objgoLive.IDFieldname, aid, []) then begin
    SetControlFocus(grdGoLive);
    Application.ProcessMessages;
    grdGoLive.setActiveField(qrygoliveEmployeeName.fieldname);
    (*if ObjGoLive.ModuleStepType = stModule   then begin
      grdGoLive.setActiveField(qrygoliveDescription.fieldname);
    end else *)if ObjGoLive.ModuleStepType = stTraining   then begin
      grdGoLive.setActiveField(qrygoliveDescription.fieldname);
    end else if ObjGoLive.ModuleStepType = stTask     then begin
      grdGoLive.setActiveField(qrygoliveDescription.fieldname);
    end else if ObjGoLive.ModuleStepType = stSummary  then begin
        grdGoLive.setActiveField(qrygoliveAddition.fieldname);
    end else if ObjGoLive.ModuleStepType = stAddition then begin
        grdGoLive.setActiveField(qrygoliveAddition.fieldname);
    end;
  end;
end;

initialization
  RegisterClassOnce(TfmProjectGoLive);

end.

