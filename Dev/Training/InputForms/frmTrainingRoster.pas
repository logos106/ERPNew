unit frmTrainingRoster;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DNMSpeedButton, Planner, DBPlanner, ComCtrls,
  Grids, BaseGrid, AdvGrid, StdCtrls, Shader, ExtCtrls, DNMPanel, DB,
  MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus,
  DataState, SelectionDialog, AppEvnts, frmBaseTraining, wwdblook,
  BusobjTraining,wwdbdatetimepicker, Wwdbigrd, Wwdbgrid, Buttons, BaseInputForm,
  BusObjBase, ProgressDialog;

type
  TMoveDate = (mmPrevious=1, mmNext=2);

  TItemProperties = class(TObject)  //used to add extra properties to a planner item
  private
    fiTRainingmoduleID: integer;
    fsTRainingmoduleName: String;
    fbTypeCatagory: string;
    firosterId: Integer;
  public
    property TRainingmoduleID:integer read fiTRainingmoduleID write fiTRainingmoduleID;
    property TRainingmoduleName:String read fsTRainingmoduleName write fsTRainingmoduleName;
    property TypeCatagory : string read fbTypeCatagory write fbTypeCatagory;
    property RosterId :Integer read firosterId write firosterID;


  end;

  TfmTrainingRoster = class(TfmBaseTraining)
    Qrymodules: TERPQuery;
    QrymodulesTrainingModuleID: TIntegerField;
    QrymodulesTrainingModuleName: TWideStringField;
    QrymodulesTrainingHrs: TFloatField;
    dsmodules: TDataSource;
    lstColorBox: TListBox;
    QryRoster: TERPQuery;
    QryRosterRosterID: TIntegerField;
    QryRosterGlobalRef: TWideStringField;
    QryRosterPlannerID: TWideStringField;
    QryRosterType: TWideStringField;
    QryRosterEmployeeID: TIntegerField;
    QryRosterClassID: TIntegerField;
    QryRosterNotes: TWideStringField;
    QryRosterStartTime: TDateTimeField;
    QryRosterEndTime: TDateTimeField;
    QryRosterEditedFlag: TWideStringField;
    QryRosterClockedOff: TWideStringField;
    QryRosterTypeCatagory: TWideStringField;
    QryRosterHours: TFloatField;
    QryRosterDate: TDateField;
    QryRosterIsClocked: TWideStringField;
    dsDayRoster: TDataSource;
    dsWeekRoster: TDataSource;
    DaySource: TDBDaySource;
    WeekSource: TDBWeekSource;
    PopupMenuPlannerItem: TAdvPopupMenu;
    PopupMenu: TAdvPopupMenu;
    QryRosterTRainingModuleId: TLargeintField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    PageControl1: TPageControl;
    tabWeekly: TTabSheet;
    tabDaily: TTabSheet;
    lblItemDetails: TLabel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    dtpMonth: TwwDBDateTimePicker;
    plannerWeek: TDBPlanner;
    QryTrainingEmployeeModules: TERPQuery;
    QryTrainingEmployeeModulesEmployeeName: TWideStringField;
    QryTrainingEmployeeModulesBasicFeatures: TWideStringField;
    QryTrainingEmployeeModulesEmployee: TWideStringField;
    QryTrainingEmployeeModulesAccounts: TWideStringField;
    QryTrainingEmployeeModulesInventory_Basics: TWideStringField;
    QryTrainingEmployeeModulesFileMaintenance: TWideStringField;
    QryTrainingEmployeeModulesPurchase: TWideStringField;
    QryTrainingEmployeeModulesCRM: TWideStringField;
    QryTrainingEmployeeModulesMarketing: TWideStringField;
    QryTrainingEmployeeModulesSales: TWideStringField;
    QryTrainingEmployeeModulesPos: TWideStringField;
    QryTrainingEmployeeModulesBanking: TWideStringField;
    QryTrainingEmployeeModulesReports: TWideStringField;
    QryTrainingEmployeeModulesGeneral_Templates: TWideStringField;
    QryTrainingEmployeeModulesUtilities: TWideStringField;
    QryTrainingEmployeeModulesInventory_Advanced: TWideStringField;
    QryTrainingEmployeeModulesCustomerPayments: TWideStringField;
    QryTrainingEmployeeModulesSupplierPayments: TWideStringField;
    QryTrainingEmployeeModulesManufacturing: TWideStringField;
    QryTrainingEmployeeModulesAppointments: TWideStringField;
    QryTrainingEmployeeModulesPayroll: TWideStringField;
    QryTrainingEmployeeModulesFixedAssets: TWideStringField;
    QryTrainingEmployeeModulesWorkshop: TWideStringField;
    QryTrainingEmployeeModulesbudgets: TWideStringField;
    QryTrainingEmployeeModulesDelivery: TWideStringField;
    QryTrainingEmployeeModulesMatrix: TWideStringField;
    QryTrainingEmployeeModulesMoreTraining: TWideStringField;
    QryTrainingEmployeeModulesMoreTrainingDetails: TWideStringField;
    QryTrainingEmployeeModulesTrainingID: TLargeintField;
    QryTrainingEmployeeModulesGlobalRef: TWideStringField;
    QryTrainingEmployeeModulesTrainingEmployeeModuleID: TIntegerField;
    QryTrainingEmployeeModulesEmployeeId: TIntegerField;
    QryTrainingEmployeeModulesDateCreated: TDateTimeField;
    QryTrainingEmployeeModulesEnteredby: TIntegerField;
    QryTrainingEmployeeModulesmstimestamp: TDateTimeField;
    dsTrainingEmployeeModules: TDataSource;
    DNMSpeedButton1: TDNMSpeedButton;
    DNMSpeedButton2: TDNMSpeedButton;
    btnPrint: TDNMSpeedButton;
    plannerDay: TDBPlanner;
    Label11: TLabel;
    cboTraining: TwwDBLookupCombo;
    qryTrainingLookup: TERPQuery;
    WideStringField2: TWideStringField;
    WideStringField1: TWideStringField;
    LargeintField1: TLargeintField;
    DateField1: TDateField;
    DateTimeField1: TDateTimeField;
    IntegerField1: TIntegerField;
    WideStringField3: TWideStringField;
    TimeField1: TTimeField;
    TimeField2: TTimeField;
    FloatField1: TFloatField;
    QryTrainingEmployeeModulesFieldName: TWordField;
    QryTrainingEmployeeModulesDataImport: TWideStringField;
    QryTrainingEmployeeModulesERPSetup: TWideStringField;
    QryTrainingEmployeeModulesmsUpdateSiteCode: TWideStringField;
    grdmodules: TwwDBGrid;
    grdmodulesIButton: TwwIButton;
    QryTrainingEmployeeModulesPurchase_FX: TWideStringField;
    procedure grdmodulesCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QryRosterAfterInsert(DataSet: TDataSet);
    procedure plannerDayPlannerKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState; Position, FromSel, FromSelPrecis, ToSel,
      ToSelPrecis: Integer);
    procedure plannerWeekPlannerKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState; Position, FromSel, FromSelPrecis, ToSel,
      ToSelPrecis: Integer);
    procedure SourceItemToFields(Sender: TObject; Fields: TFields;
      Item: TPlannerItem);
    procedure btnSaveClick(Sender: TObject);
    procedure dtpMonthChange(Sender: TObject);
    procedure SourceFieldsToItem(Sender: TObject; Fields: TFields;
      Item: TPlannerItem);
    procedure grdmodulesDblClick(Sender: TObject);
    procedure plannerWeekItemSelect(Sender: TObject; Item: TPlannerItem);
    procedure plannerWeekItemExit(Sender: TObject; Item: TPlannerItem);
    procedure QryRosterAfterPost(DataSet: TDataSet);
    procedure SourceResourceToPosition(Sender: TObject; Field: TField;
      var Position: Integer; var Accept: Boolean);
    procedure PositionToResource(Sender: TObject; Field: TField;
      Position: Integer);
    procedure plannerWeekItemDblClick(Sender: TObject; Item: TPlannerItem);
    procedure DNMSpeedButton2Click(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure PopupMenuPlannerItemPopup(Sender: TObject);
    procedure PopupMenuPopup(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure cboTrainingCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure PageControl1Resize(Sender: TObject);
  private
    bIsPlannersReady: boolean;
    EmployeeIDs :Array of Integer;
    SelectedItemrosterID:Integer;
    breakstarttime,breakEndtime:TdateTime;
    AlllinesOk:Boolean;
    ctr:Integer;
    //btnPreviousDate, FNextDate :TDnmspeedButton;//TAdvSpeedButton;
    procedure InitPlanners;
    procedure SetWeeklySelect(Const dtDate: TDateTime);
    procedure UpdateHeaders(const planner: TDBPlanner);
    function GetDateFromWeeklyPlanner: TDateTime;
    Procedure Populateoptions;
    procedure PopupMenuHandler(Sender: TObject);
    procedure PopupMenuDeleteClick(Sender: TObject);
    procedure InsertBreakClick(Sender: TObject);
    procedure DeleteItems;
    function GetPlanner: TDBPlanner;
    procedure SetItemColor(Const item: TPlannerItem; Const colour: TColor);
    function GetColor(const sDescription:string): TColor;
    function OkToCreate(Const iBegin, iEnd, iPos: integer): boolean;
    function GetEmployeeFromPosition(const iPosition: integer): integer;
    function GetPositionFromemployee(const iEmployeeId: integer): integer;
    Function EmployeeSelectedForModule(const TRainingmoduleName:String; const EmployeeID:Integer):Boolean;
    Procedure InitEmployeeIDs;
    function GetAvailabletimeforEmployee(const CurDate:TDatetime; EmployeeID:Integer):TDateTime;
    Procedure MoveDate(direction:tMoveDate);
    Procedure BreakRoster(Const Sender: TBusObj; var Abort: boolean);
    procedure Refreshform(Sender: TObject);
  Protected
    TEM :TTrainingEmployeeModules;
    Training :TTraining;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string); Override;
  public
    fdtStartDate: TDateTime;
  end;

implementation

uses DNMExceptions, CommonLib, CommonDbLib, AppEnvironment,
  TrainingLib, tcDataUtils,dateutils, Math, MySQLConst,
  CommonFormLib, BusObjRoster;


{$R *.dfm}

procedure TfmTrainingRoster.grdmodulesCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
var
  ctr:Integer;
begin
  inherited;
  ctr := Qrymodules.RecNo;

  while ctr > lstColorBox.count-1 do ctr := ctr-lstColorBox.count;

  try
    AFont.Color :=StringToColor(lstColorBox.Items[ctr]);
  Except
      on E:Exception do begin
          showmessage(IntToStr(ctr)+':' +IntToStr(lstColorBox.count))
      end;
  end;
end;

procedure TfmTrainingRoster.FormShow(Sender: TObject);
begin
  Refreshform(Sender);
  (*PlayERPVideo(exedir+'videos\Step 9 Roster.avi' );*)
end;
procedure TfmTrainingRoster.Refreshform(Sender: TObject);
begin
  OpenDb(qryTrainingLookup);
  if KeyId = 0 then begin
    KeyId := qryTrainingLookup.FieldByName('TrainingId').AsInteger;
  end
  else begin
    qryTrainingLookup.Locate('TrainingId', KeyId,[]);
  end;
  if assigned(TEm) then
    TEm.closedb;
  Training.LoadSelect('TrainingId=' + IntToStr(KeyId));
  cboTraining.Text := qryTrainingLookup.FieldByName('Description').AsString;


  TEm :=  Training.TrainingEmployeeModules;
  DisableForm;
  try
    KeyID := 1;
    try

      inherited;
      DaySource.Active := True;
      WeekSource.Active := True;
      BeginTransaction;
      PageControl1.ActivePage := tabWeekly;
      OpenQueries;

      PageControl1.ActivePageIndex:= 1;
      SetControlfocus(Plannerday);
      dtpMonth.Date := Date;


      InitPlanners;
      if TEM.count> 0 then begin
        try
          PageControl1Change(Sender);
        Except
            // kill the exception
        end;
        if AppEnv.Employee.Calender24hr then begin
          plannerDay.HourType := ht24hrs;
        end else begin
          plannerDay.HourType := ht12hrs;
        end;
        Application.ProcessMessages;
        if QryRoster.recordcount > 0 then begin
          QryRoster.First;
          dtpMonth.Date := QryRosterDate.asDateTime;
        end;
        dtpMonth.Date := dtpMonth.Date+1;
        dtpMonth.Date := dtpMonth.Date-1;
        tabDaily.Caption := formatdateTime('dddd   ' + FormatSettings.ShortDateformat ,dtpMonth.Date);

      end else begin
        OpenERPForm('TfmTrainingAssignment',0);
        Self.Close;
      end;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;

  finally
    EnableForm;
  end;


  
end;

procedure TfmTrainingRoster.btnCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfmTrainingRoster.btnPrintClick(Sender: TObject);
var
  qry: TERPQuery;
begin
  inherited;
  if self.SelectedItemrosterID > 0 then begin
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select TrainingID, EmployeeID, TrainingModuleID from tblroster');
    qry.SQL.Add('where RosterID = ' + IntToStr(SelectedItemrosterID));
    qry.Open;
    PrintTemplateReport('TrainingQuestions' ,
                  '~|||~Where TEMS.EmployeeId = ' + IntToStr(qry.FieldByName('EmployeeID').AsInteger) +
                  ' and TEMS.TrainingID = ' + IntToStr(qry.FieldByName('TrainingId').AsInteger) +
                  ' and TEMS.ModuleId = ' +IntToStr(qry.FieldByName('TrainingModuleId').AsInteger) +
                  ' order by SeqNo' , not(Appenv.Employee.ShowPreview) ,0 );

    finally
      qry.Free;
    end;
  end;
end;

procedure TfmTrainingRoster.InitPlanners;
begin
  Populateoptions;
  WeekSource.NumberOfResources := TEM.count;//QryTrainingEmployeeModules.RecordCount;
  DaySource.NumberOfResources := TEM.count;//QryTrainingEmployeeModules.RecordCount;
  plannerWeek.PositionWidth := 30;

  plannerDay.PositionWidth := 30;
  plannerDay.GridLeftCol := 14;

  plannerWeek.MultiSelect := true;
  try
    plannerWeek.Display.DisplayEnd := 31;
  except

  end;
  plannerWeek.Caption.Title := 'Roster By Week';
  plannerWeek.Display.ShowCurrent := true;

  plannerDay.MultiSelect := true;
  plannerDay.Caption.Title := 'Day Roster';

  if fdtStartDate = 0 then begin
    dtpMonth.Date := Date;  // Week Source date is set via the dtp's OnChange event
  end else begin
    dtpMonth.Date := fdtStartDate;  // Week Source date is set via the dtp's OnChange event
  end;

  // Show selected cell at todays day
  SetWeeklySelect(dtpMonth.Date);

  UpdateHeaders(plannerDay);
  UpdateHeaders(plannerWeek);
  InitEmployeeIDs;
  


  bIsPlannersReady := true;

  // Do we have any employee's to show on the roster?
  if TEM.count = 0 then begin
    // No report error to user.
    CommonLib.MessageDlgXP_Vista('No Employee''s have been Selected For Training.' , mtInformation, [mbOK], 0);
    //Self.Close;
  end;
end;

procedure TfmTrainingRoster.SetWeeklySelect(const dtDate: TDateTime);
var
  iCol: integer;
begin
  iCol := plannerWeek.AbsTimeToCell((*dtpMonth.Date*)dtDate);
  plannerWeek.SelectCells(iCol, iCol, 0);
end;

procedure TfmTrainingRoster.UpdateHeaders(const planner: TDBPlanner);
begin
  planner.Header.Height := 100;
  planner.Header.TextHeight := 100;
  planner.Header.Color := $00FFDDC6;
  planner.Header.Captions.Clear;
  planner.Header.Captions.Add('');
  planner.ItemGap := 0;

  with TEM.Dataset do begin
    First;
    while not Eof do begin
      planner.Header.Captions.Add(FieldByName('EmployeeName').AsString);
      Next;
    end;
  end;

end;

procedure TfmTrainingRoster.FormCreate(Sender: TObject);
begin
  inherited;
  btnPrint.Enabled := false;
  Training:=TTraining.create(Self);
  Training.connection := TMydacdataconnection.create(TEM);
  Training.connection.connection := Self.myconnection;
  Training.BusObjEvent := DoBusinessObjectEvent;


  fdtStartDate := 0;
  bIsPlannersReady := false;
  lblItemDetails.Caption := '';
end;

procedure TfmTrainingRoster.PageControl1Change(Sender: TObject);
begin
  inherited;
  if bIsPlannersReady then begin
    if PageControl1.ActivePage = tabWeekly then begin
      dtpMonth.DisplayFormat := 'mmmm yyyy';
      DaySource.Active := false;
      WeekSource.Active := true;
      SetWeeklySelect(dtpMonth.Date);
      tabDaily.Caption := 'Daily';
      tabWeekly.Caption := FormatDateTime('mmmm' , dtpMonth.Date) ;
      //plannerWeek.
    end else if PageControl1.ActivePage = tabDaily then begin
      dtpMonth.Date := GetDateFromWeeklyPlanner;
      try
        dtpMonth.DisplayFormat := 'dd mmmm yyyy';
      except
          // kill the exception
      end;
      DaySource.Active := true;
      WeekSource.Active := false;
      tabDaily.Caption := formatdateTime('dddd   ' + FormatSettings.ShortDateformat ,dtpMonth.Date);
      tabWeekly.Caption := 'Weekly';
    end;
  end;
end;

procedure TfmTrainingRoster.PageControl1Resize(Sender: TObject);
begin
  inherited;
  PageControl1.TabWidth := Trunc(PageControl1.Width / 2) - 2;
end;

function TfmTrainingRoster.GetDateFromWeeklyPlanner: TDateTime;
var
  iCol: integer;
  dtDummy: TDateTime;   // not used
begin
  iCol := plannerWeek.SelItemBegin;
  plannerWeek.CellToAbsTime(iCol, Result, dtDummy);
  if dtDummy = 0 then // prevents silly delphi hint
    dtDummy := date;
end;

procedure TfmTrainingRoster.Populateoptions;
var
  i         :Integer;
  (*iRowCount :Integer;*)
  MenuItem: TMenuItem;

  procedure AddMenuItemToPopup(const Popup: TAdvPopupMenu; const iTag: integer; const sName: string);
  begin
    MenuItem := TMenuItem.Create(self);
    MenuItem.Caption := sName;
    MenuItem.Tag := iTag;
    MenuItem.OnClick := PopupMenuHandler;
    Popup.Items.Add(MenuItem);
  end;


  procedure AddMenuItem(const iTag: integer; const sName: string);
  begin
    AddMenuItemToPopup(PopupMenu, iTag, sName);
    AddMenuItemToPopup(PopupMenuPlannerItem, iTag, sName);
  end;
begin

{Clear Menus}
    PopupMenu.Items.Clear;
    PopupMenuPlannerItem.Items.Clear;



    MenuItem         := TMenuItem.Create(self);
    MenuItem.Caption := 'Delete';
    MenuItem.OnClick := PopupMenuDeleteClick;
    PopupMenuPlannerItem.Items.Add(MenuItem);

    MenuItem         := TMenuItem.Create(self);
    MenuItem.Caption := '-';
    PopupMenuPlannerItem.Items.Add(MenuItem);

    MenuItem         := TMenuItem.Create(self);
    MenuItem.Caption := 'Insert Break';
    MenuItem.OnClick := InsertBreakClick;
    MenuItem.Name := 'PopupMenuPlannerItemInsertBreak';
    PopupMenuPlannerItem.Items.Add(MenuItem);
    MenuItem         := TMenuItem.Create(self);
    MenuItem.Caption := '-';
    PopupMenuPlannerItem.Items.Add(MenuItem);

    MenuItem         := TMenuItem.Create(self);
    MenuItem.Caption := 'Insert Break';
    MenuItem.OnClick := InsertBreakClick;
    MenuItem.Name    := 'PopupMenuInsertBreak';
    PopupMenu.Items.Add(MenuItem);
    MenuItem         := TMenuItem.Create(self);
    MenuItem.Caption := '-';
    PopupMenu.Items.Add(MenuItem);


    i := 0;
    (*iRowCount := 0;*)
    Qrymodules.First;
    while not Qrymodules.Eof do begin

      // fill in popupmenu items
      AddMenuItem(Qrymodules.FieldByName('TrainingModuleId').AsInteger,
        Qrymodules.FieldByName('TrainingModulename').AsString);
      //store in list to use later
      Qrymodules.Next;
      (*iRowCount := iRowcount + 1;*)
      i := i +1;
      if i > 20 then i := 0;
    end;

end;

procedure TfmTrainingRoster.PopupMenuHandler(Sender: TObject);
var
  MenuItem: TMenuItem;
  iDayCnt, iNumDays: integer;
  iCurrentCell, iPos: integer;
  oItem: TPlannerItem;
  dtDate: TDateTime;
  planner: TDBPlanner;
  ItemProperties :tItemProperties;
  bFoundASelectedItem:Boolean;
  TrainingmoduleId:Integer;
  TrainingTimeinMinutes:Integer;
  timetoStart:TDatetime;
  EmployeeID:Integer;

  procedure FillCellDetails(ItemProperties:TItemProperties);
  var
    sText: string;
  begin
    sText := StringReplace(MenuItem.Caption, '&', '', [rfReplaceAll,rfIgnoreCase]);
    ItemProperties.TRainingmoduleName := sText;
    ItemProperties.TypeCatagory := 'Training';
    ItemProperties.TRainingmoduleID:= MenuItem.Tag;//oItem.Tag;

    if MenuItem.Tag <> 0 then begin
      // get here if an allocation or clocked
      oItem.Tag := MenuItem.Tag;  // Set class ID
      SetItemColor(oItem, GetColor(sText));
        oItem.Shape := psRounded;  // allocation
        oItem.BrushStyle := bsSolid;
    end else begin
      sText := StringReplace(MenuItem.Caption, '&', '', [rfReplaceAll,rfIgnoreCase]);
      oItem.Background := false;
      SetItemColor(oItem, GetColor(sText));

      oItem.CaptionText  := MenuItem.Caption;
      oItem.AllowOverlap := false;
      oItem.Shape        := psHexagon;
      oItem.BrushStyle   := bsSolid;
    end;
  end;
  Function HourToMin(const Value:Double):Integer;
  begin
     REsult := TRunc(Value*60);
  end;
begin   // PopupMenuHandler(Sender: TObject)
  inherited;
  MenuItem := TMenuItem(Sender);
  planner := GetPlanner;
  bFoundASelectedItem := False;

  EmployeeID := GetEmployeeFromPosition(planner.SelPosition);
  if EmployeeID = 0 then exit;

  TrainingmoduleId := tcdatautils.GetTrainingModuleID(StringReplace(MenuItem.Caption, '&', '', [rfReplaceAll,rfIgnoreCase]));
  if not Qrymodules.locate('TRainingmoduleID' ,TrainingmoduleId,[]) then exit;
  TrainingTimeinMinutes:= trunc(QrymodulesTrainingHrs.asFloat*60);

  if not EmployeeSelectedForModule(StringReplace(MenuItem.Caption, '&', '', [rfReplaceAll,rfIgnoreCase]) ,  EmployeeID) then begin
    MessageDlgXP_Vista(Quotedstr(getemployeeName(EmployeeID))+
          ' is Not Assigned to be Trained on' +chr(13) +
          QuotedStr(StringReplace(MenuItem.Caption, '&', '', [rfReplaceAll,rfIgnoreCase])) , mtInformation , [mbok] , 0);
    exit;
  end;
    if (planner = plannerWeek) and
      (planner.SelPosition <= TEM.count - 1) then begin
      planner.Items.BeginUpdate;
      iCurrentCell := planner.SelItemBegin;
      iPos := planner.SelPosition;
      iNumDays := (planner.SelItemEnd - planner.SelItemBegin) + 1;
      iDayCnt := 0;
      while (iDayCnt < iNumDays - 1) and (TrainingTimeinMinutes >0) do begin

        planner.SelectCells(iCurrentCell + iDayCnt, iCurrentCell + iDayCnt, iPos);
        oItem := planner.CreateItemAtSelection;
        bFoundASelectedItem := True;
        ItemProperties := TItemProperties.Create;
        oItem.ItemObject :=  ItemProperties;  // assign object to item

        oItem.Tag :=  TrainingmoduleId;
        TItemProperties(oItem.ItemObject).TRainingmoduleID := oItem.Tag;

        dtDate := oItem.ItemStartTime;
        TimetoStart := GetAvailabletimeforEmployee(dtDate ,  GetEmployeeFromPosition(iPos));
        if TimetoStart = 0 then begin
          planner.FreeItem(OItem);
          planner.Update;
          continue;
        end;

        oItem.ItemStartTime :=TimetoStart;

        if IncMinute(oItem.ItemStartTime ,TrainingTimeinMinutes) <= dtDate+TRaining.EndOftheDay then
             oItem.ItemEndTime := IncMinute(oItem.ItemStartTime ,TrainingTimeinMinutes)
        else oItem.ItemEndTime :=dtDate+Training.EndOftheDay;

        TrainingTimeinMinutes := TrainingTimeinMinutes - (MinutesBetween(oItem.ItemstartTime , oItem.ItemEndTime)+1);

        FillCellDetails(ItemProperties);
        oItem.Update;
        Inc(iDayCnt);
      end;
      planner.Items.EndUpdate;
      if TrainingTimeinMinutes >0 then begin
        MessageDlgXP_Vista(QrymodulesTrainingModuleName.asString +' Requires ' +FloatToStr(QrymodulesTrainingHrs.asFloat) +' hour(s).  The Selected Range Doesn''t Have Enough Time Available For '+getemployeeName(GetEmployeeFromPosition(iPos))+'.  ' +FloatToStr(Round(TrainingTimeinMinutes/60,CurrencyRoundPlaces))+' Hour(s)  To Be Alocated' , mtInformation, [mbok],0);
      end;
    end else if planner = plannerDay then begin
      if OkToCreate(planner.SelItemBegin, planner.SelItemEnd, planner.SelPosition) then begin
        oItem := planner.CreateItemAtSelection;

        ItemProperties := TItemProperties.Create;
        oItem.ItemObject :=  ItemProperties;  // assign object to item

          oItem.Tag := TrainingmoduleId;
          TItemProperties(oItem.ItemObject).TRainingmoduleID := oItem.Tag;

        FillCellDetails(ItemProperties);
        oItem.Update;
      end;
    end;
  planner.Items.UnSelectAll;
  if not bFoundASelectedItem then ShowMessage('Select an item');

end;

procedure TfmTrainingRoster.PopupMenuDeleteClick(Sender: TObject);
begin
  DeleteItems;
end;

procedure TfmTrainingRoster.DeleteItems;
var
  i: integer;
  bAllDeleted: boolean;
  planner: TDBPlanner;
begin
  // All I want to do here is delete all the selected items, but there seems to
  // .. be no easy way to do this that I can find.
  // So we must go thru all the items looking for selcted ones and tagging them
  // .. for deletion.  We cannot delete them as we go at this stage cuz when you
  // .. delete an item the selection is shifted to the next item, and we would therefore
  // .. end up deleting all the items


  planner := GetPlanner;


  planner.Items.BeginUpdate;

  // tag all the selected items for deletion
  for i := 0 to planner.Items.Count - 1 do begin
    if planner.Items.Items[i].Selected then begin
      planner.Items.Items[i].Tag := -999;  // tag item for deletion (ClassID = -999 is safe)
    end;
  end;


  // now delete all the selcted items.
  // We have to restart after each delete cuz the item count changes  aftter each delete
  bAllDeleted := false;
  while not bAllDeleted do begin
    bAllDeleted := true;   // assume we've got them all at this stage
    for i := 0 to planner.Items.Count - 1 do begin
      if planner.Items.Items[i].Tag = -999 then begin
        planner.FreeItem(planner.Items.Items[i]);
        planner.Update;
        bAllDeleted := false;
        Break;
      end;
    end;
  end;

  planner.Items.EndUpdate;
end;

function TfmTrainingRoster.GetPlanner: TDBPlanner;
begin
  if PageControl1.ActivePage = tabWeekly then begin
    Result := plannerWeek;
  end else begin
    Result := plannerDay;
  end;

end;

procedure TfmTrainingRoster.SetItemColor(const item: TPlannerItem;
  const colour: TColor);
begin
  item.Color := colour;
end;

function TfmTrainingRoster.GetColor(const sDescription: string): TColor;
var
  i: integer;
begin
  Result := clBlack;
  if Qrymodules.Locate('Trainingmodulename' , sDescription, []) then begin
    i:=Qrymodules.recno;
    while i > lstColorBox.count-1 do i := i-lstColorBox.count;
    result :=StringToColor(lstColorBox.Items[i]);
  end;

end;

function TfmTrainingRoster.OkToCreate(const iBegin, iEnd,
  iPos: integer): boolean;
var
  oItem: TPlannerItem;
  planner: TDBPlanner;
begin
  Result := true;
  planner := GetPlanner;
  oItem := planner.Items.FindFirst(iBegin, iEnd, iPos);
  while oItem <> nil do begin
    if (not oItem.AllowOverlap) then begin
      Result := false;
      Break;
    end;
    oItem := planner.Items.FindNext(iBegin, iEnd, iPos)
  end;
end;

procedure TfmTrainingRoster.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  (*CloseERPVideo;*)
  Action := caFree;
end;

procedure TfmTrainingRoster.QryRosterAfterInsert(DataSet: TDataSet);
begin
  inherited;
 QryRosterType.asString := 'Training';
 QryRosterClassID.asInteger := tcDataUtils.GetDeptID(Appenv.DefaultClass.DefaultClassname);
 QryRosterTypeCatagory.AsString := 'Training';
end;

procedure TfmTrainingRoster.plannerDayPlannerKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState; Position, FromSel, FromSelPrecis,
  ToSel, ToSelPrecis: Integer);
begin
  inherited;
  if Key = VK_DELETE then begin
    DeleteItems;
  end;
end;

procedure TfmTrainingRoster.plannerWeekPlannerKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState; Position, FromSel, FromSelPrecis,
  ToSel, ToSelPrecis: Integer);
begin
  inherited;
  if Key = VK_DELETE then begin
    DeleteItems;
  end;

end;

procedure TfmTrainingRoster.SourceItemToFields(Sender: TObject;
  Fields: TFields; Item: TPlannerItem);
begin
  inherited;
  QryRoster.FieldByName('Date').AsDateTime := Trunc(QryRoster.FieldByName('StartTime').AsDateTime);
  QryRoster.FieldByName('Hours').AsFloat := HourSpan(QryRoster.FieldByName('EndTime').AsDateTime, QryRoster.FieldByName('StartTime').AsDateTime);
  QryRoster.FieldByName('Hours').AsFloat := RoundTo(QryRoster.FieldByName('Hours').AsFloat, - 3);
  QryRoster.FieldByName('EmployeeID').AsInteger := GetEmployeeFromPosition(Item.ItemPos);
  QryRoster.FieldByName('TRainingmoduleID').AsInteger := Item.TAG;
  QryRoster.FieldByName('EditedFlag').AsString := 'T';
end;

procedure TfmTrainingRoster.btnSaveClick(Sender: TObject);
begin
  inherited;
  CommitTransaction;
  if fsModal in FormState then begin
    ModalResult := mrOk;
  end else begin
    Close;
  end;
end;

procedure TfmTrainingRoster.cboTrainingCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  KeyID := qryTrainingLookup.FieldByName('TrainingID').AsInteger;
  FormShow(nil);
end;

procedure TfmTrainingRoster.dtpMonthChange(Sender: TObject);
begin
  inherited;
  WeekSource.Month := MonthOfTheYear(dtpMonth.Date);
  WeekSource.Year := YearOf(dtpMonth.Date);
  WeekSource.UpdatePlanner;
  DaySource.Day := Dateof(dtpMonth.Date);
  SetWeeklySelect(StartOfAMonth(WeekSource.Year , WeekSource.Month));
  DaySource.Refresh;
end;

function TfmTrainingRoster.GetEmployeeFromPosition(const iPosition: integer): integer;
begin
  REsult := 0;
  if iPosition<0 then exit;

  if iPosition > high(employeeIDs) then
  else
   result := employeeIDs[iPosition];
end;
function TfmTrainingRoster.GetPositionFromemployee(const iEmployeeId: integer): integer;
var
  ctr:Integer;
begin
   REsult := -1;
   for ctr := low(employeeIDs) to high(employeeIDs) do
    if employeeIDs[ctr] = iEmployeeId then begin
        result := ctr;
        exit;
    end;
end;

procedure TfmTrainingRoster.InitEmployeeIDs;
var
  ctr:Integer;
begin
   Setlength(employeeIDs , TEM.count);
   TEM.first;
   ctr:= 0;
   While TEM.eof = False do begin
    employeeIDs[ctr] := TEM.EmployeeID;
    TEM.Next;
    ctr:= ctr+1;
   end;
end;

procedure TfmTrainingRoster.SourceFieldsToItem(Sender: TObject;
  Fields: TFields; Item: TPlannerItem);
var
  ItemProperties:TItemProperties;
begin
  inherited;

  Item.Shape := psHexagon;
  ItemProperties := TItemProperties.Create;

  ItemProperties.TrainingModuleId := Fields.FieldByName('TrainingModuleId').AsInteger;
  if Qrymodules.Locate('TRainingmoduleID' ,Fields.FieldByName('TrainingModuleId').AsInteger , []) then
    ItemProperties.TRainingmoduleName :=QrymodulesTrainingModuleName.asString;
  ItemProperties.TypeCatagory :=  Trim(Fields.FieldByName('TypeCatagory').AsString);
  ItemProperties.RosterId := Fields.FieldByName('rosterID').asInteger;

  Item.ItemObject := ItemProperties;

  SetItemColor(Item,GetColor(ItemProperties.TRainingmoduleName));

  if TItemSource(Sender) = WeekSource then begin
    Item.FixedSize := true;
  end else begin
    Item.FixedSize := false;
  end;

  Item.FixedPos := (AccessLevel <> 1);
  Item.FixedSize := (AccessLevel <> 1);
end;

procedure TfmTrainingRoster.grdmodulesDblClick(Sender: TObject);
var
  ctr:Integer;
begin
  for ctr := 0 to PopupMenuPlannerItem.Items.Count-1 do begin
    if SameText(PopupMenuPlannerItem.items[ctr].Caption , QrymodulesTrainingModuleName.asString) then begin
        PopupMenuHandler(PopupMenuPlannerItem.items[ctr]);
        Exit;
    end;
  end;
end;

function TfmTrainingRoster.EmployeeSelectedForModule(const TRainingmoduleName:String; const EmployeeID:Integer):Boolean;
begin
  result := False;
  if not TEM.Locate('EmployeeId' , EmployeeId , []) then exit;
  REsult := TEM.IsModuleAssigned(TRainingmoduleName );
end;

procedure TfmTrainingRoster.plannerWeekItemSelect(Sender: TObject;
  Item: TPlannerItem);
begin
  inherited;
  With TEm.GetNewDataset('SELECT PlannerID,EmployeeID,TrainingmoduleId FROM tblroster WHERE PlannerID = '+
      QuotedStr(Item.DBKey)) do try
    if RecordCount > 0 then begin
        Item.Tag:= FieldByName('TrainingmoduleId').AsInteger;
    end;
  finally
    if Active then close;
    Free;
  end;


  // select the planner cell of the selected item (assume one day only)
  Item.Planner.SelectCells(Item.ItemBegin, Item.ItemBegin, Item.ItemPos);

  SelectedItemrosterID := QryRosterRosterID.asInteger;
  btnPrint.Enabled := true;
  lblItemDetails.Caption := '';

  lblItemDetails.Caption := tItemProperties(Item.ItemObject).TRainingmoduleName + ' - ' +
                            FloattoStr(QryRosterHours.asFloat)+' Hour(s)  on ' +
                            Trim(formatdatetime('dddd   dd-mmm' ,  QryRosterStartTime.asDateTime)) +'  '+
                            Trim(formatdatetime('hh:nn am/pm' ,  QryRosterStartTime.asDateTime))+
                            ' to ' +Trim(formatdatetime('hh:nn am/pm' ,  QryRosterEndTime.asDateTime)) ;
end;

procedure TfmTrainingRoster.plannerWeekItemExit(Sender: TObject;
  Item: TPlannerItem);
begin
  inherited;
 lblItemDetails.Caption := '';
 SelectedItemrosterID := 0;
 btnPrint.Enabled := false;
end;



function TfmTrainingRoster.GetAvailabletimeforEmployee(
  const CurDate: TDatetime; EmployeeID: Integer): TDateTime;
var
  strSQl:String;
begin
  result := 0;
  strSQL:= 'Select max(Endtime) endtime '+
            ' from tblroster  '+
            ' where Type = ''Training''  '+
            ' and Date =' +QuotedStr(FormatDateTime(mysqlDateFormat, Dateof(CurDate)))+
            ' and EmployeeId = ' + IntToStr(EmployeeID)+
            ' and rosterID <> ' + IntToStr(SelectedItemrosterID);

  With TEm.GetNewDataSet(strSQL, true) do try
      if (recordcount > 0) and (fieldbyname('endtime').asDatetime<> 0) then
        result := fieldbyname('endtime').asDatetime;//incminute(fieldbyname('endtime').asDatetime,1);
  finally
      if active then close;
      Free;
  end;
  if result = 0 then
    result := Curdate + TRaining.StartOfTheDay;
  if result > Curdate +TRaining.EndOftheDay then
    result := 0;
end;

procedure TfmTrainingRoster.QryRosterAfterPost(DataSet: TDataSet);
begin
  inherited;
  SelectedItemrosterID := QryRosterRosterID.asInteger;
  btnPrint.Enabled := true;
end;

procedure TfmTrainingRoster.SourceResourceToPosition(Sender: TObject;
  Field: TField; var Position: Integer; var Accept: Boolean);
begin
  inherited;
  Position := GetPositionFromemployee(Field.AsInteger);
end;


procedure TfmTrainingRoster.PositionToResource(Sender: TObject;
  Field: TField; Position: Integer);
begin
  inherited;
  field.AsInteger := GetEmployeeFromPosition(Position);
end;

procedure TfmTrainingRoster.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
begin
  inherited;
  if Sender is TTrainingEmployeeModules  then TTrainingEmployeeModules(Sender).Dataset := QryTrainingEmployeeModules;
end;

procedure TfmTrainingRoster.plannerWeekItemDblClick(Sender: TObject;
  Item: TPlannerItem);
var
  planner: TDBPlanner;
  EmployeeID:Integer;
begin
  inherited;
  planner := GetPlanner;
  EmployeeID:=GetEmployeeFromPosition(planner.SelPosition);
  if EmployeeID = 0 then exit;

end;

procedure TfmTrainingRoster.DNMSpeedButton2Click(Sender: TObject);
begin
  inherited;
  MoveDate(mmNext);
end;

procedure TfmTrainingRoster.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  MoveDate(mmPrevious);
end;

procedure TfmTrainingRoster.MoveDate(direction: tMoveDate);
begin
    if PageControl1.ActivePage = tabWeekly then begin
      if direction = mmNext then dtpMonth.Date := incmonth(dtpMonth.Date , 1)
      else dtpMonth.Date := incmonth(dtpMonth.Date , -1);
      SetWeeklySelect(dtpMonth.Date);
      tabWeekly.Caption := FormatDateTime('mmmm' , dtpMonth.Date) ;
    end else if PageControl1.ActivePage = tabDaily then begin
      if direction = mmNext then dtpMonth.Date := IncDay(dtpMonth.Date , 1)
      else dtpMonth.Date := IncDay(dtpMonth.Date , -1);
      tabDaily.Caption := formatdateTime('dddd   ' + FormatSettings.ShortDateformat ,dtpMonth.Date);
    end;
end;

procedure TfmTrainingRoster.PopupMenuPlannerItemPopup(Sender: TObject);
var
  planner: TDBPlanner;
  comp :Tcomponent;
begin
  inherited;
  planner := GetPlanner;
  comp :=FindComponent('PopupMenuPlannerItemInsertBreak');
  if (comp <> nil) and (comp is TMenuItem) then
    TMenuItem(comp).enabled := planner = plannerday;
end;

procedure TfmTrainingRoster.PopupMenuPopup(Sender: TObject);
var
  planner: TDBPlanner;
  comp :Tcomponent;

begin
  inherited;
  planner := GetPlanner;
  comp :=FindComponent('PopupMenuInsertBreak');
  if (comp <> nil) and (comp is TMenuItem) then  
    TMenuItem(comp).enabled := planner = plannerday;
end;

procedure TfmTrainingRoster.InsertBreakClick(Sender: TObject);
var
  planner: TDBPlanner;
  oItem: TPlannerItem;
  strSQL:string;
  TrainingRoster :TRoster;
begin
  planner := GetPlanner;
  oItem := planner.CreateItemAtSelection;
  breakstarttime := oItem.Itemstarttime;
  breakEndtime   := oItem.ItemEndtime;
  planner.FreeItem(oItem);
  TrainingRoster := TRoster.Create(Self);
  try
    Training.connection.CommitTransaction;{Save the changes and start a new transaction}
    Training.connection.BeginTransaction;
    try
      TrainingRoster.connection := TMydacdataconnection.Create(TrainingRoster);
      TrainingRoster.connection.connection := Self.myconnection;

      strSQL:= 'startTime < ' +QuotedStr(FormatDateTime (MysqlDateTimeFormat , breakStarttime)) +
              ' and endTime >' +QuotedStr(FormatDateTime (MysqlDateTimeFormat , breakStarttime));
      TrainingRoster.loadSelect(strSQL);
      AlllinesOk := True;
      ctr:= 1;
      TrainingRoster.Iteraterecords(BreakRoster);
      if not AlllinesOk then exit;
      TrainingRoster.closedb;
      TrainingRoster.loadSelect(strSQL);
      if TrainingRoster.count > 0 then exit;
      TrainingRoster.closedb;
      (*strSQL:= QuotedStr(formatDateTime(MysqlDateTimeFormat , breakStartTime)) +' between startTime and endTime ' +
                ' or ' + QuotedStr(formatDateTime(MysqlDateTimeFormat , breakendTime)) +' between startTime and endTime ' +
                ' or (startTime >= ' + QuotedStr(formatDateTime(MysqlDateTimeFormat , breakStartTime)) +
                      ' and endtime <= ' + QuotedStr(formatDateTime(MysqlDateTimeFormat , breakendTime)) +') ';*)
      strSQL:='startTime >' + QuotedStr(formatDateTime(MysqlDateTimeFormat , breakStartTime)) +
              ' or endTime >' + QuotedStr(formatDateTime(MysqlDateTimeFormat , breakStartTime)) ;
      TrainingRoster.loadSelect(strSQL);
      TrainingRoster.First;
      While TrainingRoster.Eof =False do begin
        TrainingRoster.Delete;
        TrainingRoster.First;
      end;
      Training.AutoScheduleFrom(breakendtime);
    finally
      Training.connection.CommitTransaction;
      Freeandnil(TrainingRoster);
      CloseQueries;
      Refreshform(Self);
    end;
  Except
    on E:Exception do begin
        Training.connection.RollbackTransaction;
    end;
  end;
end;

procedure TfmTrainingRoster.BreakRoster(const Sender: TBusObj;  var Abort: boolean);
var
  NewTrainingRoster :TRoster;
begin
  if not(Sender is Troster) then exit;
  if not((TRoster(Sender).StartTime < breakstarttime) and (TRoster(Sender).endtime >breakStarttime )) then exit;
  TRoster(Sender).connection.BeginNestedTransaction;
  try
    NewTrainingRoster := TRoster.Create(Self);
    Try
      NewTrainingRoster.connection := TRoster(Sender).connection;
      NewTrainingRoster.New;
      NewTrainingRoster.XML :=TRoster(Sender).XML;
      ctr:= ctr+1;
      NewTrainingRoster.PlannerId :=AppEnv.DefaultClass.DefaultClassName +
                                        FormatDateTime('yy:m:d:h:n:s:z', Now()) +
                                        IntToStr(ctr);
      NewTrainingRoster.StartTime := breakstarttime;
      NewTrainingRoster.PostDB;
      TRoster(Sender).EndTime := breakstarttime;
      TRoster(Sender).postDB;
      TRoster(Sender).Connection.CommitNestedTransaction;
    finally
        Freeandnil(NewTrainingRoster);
    end;
  except
    on E:Exception do begin
      AlllinesOk := False;
      TRoster(Sender).Connection.RollbackTransaction;
    end;
  end;
end;

initialization
  RegisterClassOnce(TfmTrainingRoster);
end.

