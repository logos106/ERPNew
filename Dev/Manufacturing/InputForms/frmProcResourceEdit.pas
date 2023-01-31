unit frmProcResourceEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, AdvMenus, DataState, DB, DBAccess, MyAccess,ERPdbComponents,
  SelectionDialog, AppEvnts, ExtCtrls, ActnList, StdCtrls, wwcheckbox,
  DNMSpeedButton, Shader, DNMPanel, MemDS, Mask,
  wwdbedit, wwdblook, Grids, Wwdbigrd, Wwdbgrid, Buttons,
  BusObjBase, ImgList, AdvEdit, DBAdvEd, wwdbdatetimepicker, ProgressDialog,
  DBCtrls, ComCtrls , frmProcResourceBase;

type
  TfmProcResourceEdit = class(TfmProcResourceBase)
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    grdSteps: TwwDBGrid;
    btnDelete: TwwIButton;
    Label8: TLabel;
    Label9: TLabel;
    edSetupHours: TMaskEdit;
    edBreakdownHours: TMaskEdit;
    Bevel1: TBevel;
    Label6: TLabel;
    edtHourlyRate: TwwDBEdit;
    Label7: TLabel;
    edtHourlyOverheadRate: TwwDBEdit;
    chkMonday: TwwCheckBox;
    chkTuesday: TwwCheckBox;
    chkWednesday: TwwCheckBox;
    chkThursday: TwwCheckBox;
    chkSunday: TwwCheckBox;
    chkSaturday: TwwCheckBox;
    chkfriday: TwwCheckBox;
    edtSundayCapacityHrs: TMaskEdit;
    edtmondayCapacityHrs: TMaskEdit;
    edtTuesdayCapacityHrs: TMaskEdit;
    edtWednesdayCapacityHrs: TMaskEdit;
    edtThursdayCapacityHrs: TMaskEdit;
    edtFridayCapacityHrs: TMaskEdit;
    edtSAturdayCapacityHrs: TMaskEdit;
    mnuRepeatUnavailability: TAdvPopupMenu;
    mnuRepeatUnavailabilityWeek: TMenuItem;
    mnuRepeatUnavailabilityMonth: TMenuItem;
    mnuRepeatUnavailabilityYEar: TMenuItem;
    Bevel4: TBevel;
    dtSundayStartAt: TwwDBDateTimePicker;
    dtTuesdayStartAt: TwwDBDateTimePicker;
    dtWednesdayStartAt: TwwDBDateTimePicker;
    dtThursdayStartAt: TwwDBDateTimePicker;
    dtFridayStartAt: TwwDBDateTimePicker;
    dtSaturdayStartAt: TwwDBDateTimePicker;
    dtMondayStartAt: TwwDBDateTimePicker;
    Label18: TLabel;
    btnCopyTime: TDNMSpeedButton;
    Label19: TLabel;
    edtResourceCount: TwwDBEdit;
    
    Bevel3: TBevel;
    Bevel2: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    cboFixedAsset: TwwDBLookupCombo;
    Label10: TLabel;
    DNMPanel1: TDNMPanel;
    grdProcResourceDetails: TwwDBGrid;
    wwIButton1: TwwIButton;
    pnlResDetDet: TDNMPanel;
    DBText1: TDBText;
    edtTotSundayCapacityHrs: TEDit;
    edtTotmondayCapacityHrs: TEDit;
    edttotTuesdayCapacityHrs: TEDit;
    edttotWednesdayCapacityHrs: TEDit;
    edttotThursdayCapacityHrs: TEDit;
    edttotFridayCapacityHrs: TEDit;
    edttotSAturdayCapacityHrs: TEDit;
    Label11: TLabel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    Bevel9: TBevel;
    pgResDetailsRelated: TPageControl;
    tabUnavailaibility: TTabSheet;
    TabProducts: TTabSheet;
    grdUnavailaibility: TwwDBGrid;
    wwIButton2: TwwIButton;
    cboUnitOfMeasure: TwwDBLookupCombo;
    chkAvailable: TDBCheckBox;
    DBCheckBox1: TDBCheckBox;
    btnAutoSelect: TDNMSpeedButton;
    qryProcResourcedaysSundayTotCapacityHoursDay: TFloatField;
    qryProcResourcedaysMondayTotCapacityHoursDay: TFloatField;
    qryProcResourcedaysTuesdayTotCapacityHoursDay: TFloatField;
    qryProcResourcedaysWednesdayTotCapacityHoursDay: TFloatField;
    qryProcResourcedaysThursdayTotCapacityHoursDay: TFloatField;
    qryProcResourcedaysFridayTotCapacityHoursDay: TFloatField;
    qryProcResourcedaysSaturdayTotCapacityHoursDay: TFloatField;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure grdStepsExit(Sender: TObject);
    procedure cboStepDescriptionBeforeDropDown(Sender: TObject);
    procedure cboStepDescriptionNotInList(Sender: TObject;
      LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
    procedure edSetupHoursExit(Sender: TObject);
    procedure edBreakdownHoursExit(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure edtSundayCapacityHrsExit(Sender: TObject);
    procedure edtmondayCapacityHrsExit(Sender: TObject);
    procedure edtTuesdayCapacityHrsExit(Sender: TObject);
    procedure edtWednesdayCapacityHrsExit(Sender: TObject);
    procedure edtThursdayCapacityHrsExit(Sender: TObject);
    procedure edtFridayCapacityHrsExit(Sender: TObject);
    procedure edtSAturdayCapacityHrsExit(Sender: TObject);
    procedure edtSundayCapacityHrsChange(Sender: TObject);
    procedure edtSundayCapacityHrsEnter(Sender: TObject);
    procedure dtFridayStartAtExit(Sender: TObject);
    procedure dtMondayStartAtExit(Sender: TObject);
    procedure dtSaturdayStartAtExit(Sender: TObject);
    procedure dtSundayStartAtExit(Sender: TObject);
    procedure dtThursdayStartAtExit(Sender: TObject);
    procedure dtTuesdayStartAtExit(Sender: TObject);
    procedure dtWednesdayStartAtExit(Sender: TObject);
    procedure dtSundayStartAtDblClick(Sender: TObject);
    procedure dtMondayStartAtDblClick(Sender: TObject);
    procedure dtTuesdayStartAtDblClick(Sender: TObject);
    procedure dtWednesdayStartAtDblClick(Sender: TObject);
    procedure dtThursdayStartAtDblClick(Sender: TObject);
    procedure dtFridayStartAtDblClick(Sender: TObject);
    procedure dtSaturdayStartAtDblClick(Sender: TObject);
    procedure dtSundayStartAtEnter(Sender: TObject);
    procedure grdStepsEnter(Sender: TObject);
    procedure edSetupHoursEnter(Sender: TObject);
    procedure edBreakdownHoursEnter(Sender: TObject);
    procedure edtHourlyRateEnter(Sender: TObject);
    procedure edtHourlyOverheadRateEnter(Sender: TObject);
    procedure edtDescriptionEnter(Sender: TObject);
    procedure btnCopyTimeClick(Sender: TObject);
    procedure wwIButton1Click(Sender: TObject);
    procedure wwIButton2Click(Sender: TObject);
    procedure btnAutoSelectClick(Sender: TObject);
    procedure mnuRepeatUnavailabilityPopup(Sender: TObject);
    procedure RepeatUnAvailability(Sender: TObject);
    procedure cboUnitOfMeasureNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: string; var Accept: Boolean);
    procedure cboUnitOfMeasureCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure FormResize(Sender: TObject);
    procedure pgResDetailsRelatedResize(Sender: TObject);
    procedure qryProcResourcedaysCalcFields(DataSet: TDataSet);
  private
    DayName: string;
    fiProcessStepId: Integer;
    NewProductName: string;
    procedure GetCapacityTimes;
    function MaskeditTextTodouble(Sender: TObject;DayStartAt:TObject;change:String='Hr'): double;
    procedure RefreshAllCapacity;
    procedure ValidateCapacityformat(Sender: TMaskEdit);
    procedure SetProcessStepId(const Value: Integer);
    procedure RecalculateBOMcostnPrice;
    procedure RefreshtotalCapacity;
    function ShowcolorDetails: Boolean;
    procedure ShowColorDetailComponents;
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    procedure UpdateMe(const Cancelled: Boolean; const aObject: TObject = nil); override;
    function DoAfterSave: Boolean;Override;
  public
    Property ProcessStepId :Integer read fiProcessStepId  write SetProcessStepId ;
  end;

implementation

uses
  DNMExceptions, FormFactory, CommonLib, BusObjConst, ProcessDataUtils,
  BusObjProcessStep, ProcessUtils, FastFuncs, tcConst, AppEnvironment,
  TypInfo, tcDataUtils,dateutils , math, DbSharedObjectsObj, CommonDbLib,
  BOMCostnPriceLib, DNMLib, BusObjProcResource;

{$R *.dfm}
Function TfmProcResourceEdit.ShowcolorDetails:Boolean;
begin
  Result := procResource.UsedWithProductsInSeq;
end;
procedure TfmProcResourceEdit.FormCreate(Sender: TObject);
begin
  inherited;
  Label9.caption := 'Note: '+NL+
                    'Available capacity equals capacity minus setup and breakdown.' +NL+NL+
                    'Capacity times are in hh:mm:ss format';
  DayName := '';
  btnCopyTime.Enabled := false;
  pnlcolorDetails.Parent := TabProducts;
  pnlcolorDetails.Align := alclient;
end;
Procedure TfmProcResourceEdit.ShowColorDetailComponents;
begin
  pgResDetailsRelated.visible                 := ShowcolorDetails;
  qryProcResourceDetailsNoOfResources.visible := ShowcolorDetails;
  qryProcResourceDetailsUOMQty.visible        := ShowcolorDetails;
  qryProcResourceDetailsUOMDetails.visible    := ShowcolorDetails;
  qryProcResourceDetailsUOMMult.visible       := ShowcolorDetails;
  if not ShowcolorDetails then grdUnavailaibility.Parent := pnlResDetDet
  else grdUnavailaibility.Parent := tabUnavailaibility;
end;
procedure TfmProcResourceEdit.FormResize(Sender: TObject);
begin
  inherited;
  RealignTabControl(pgResDetailsRelated, 1);
end;

procedure TfmProcResourceEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  RollbackTransaction;
  Action := caFree;
  inherited;
end;

procedure TfmProcResourceEdit.FormShow(Sender: TObject);
begin
  DisableForm;
  try
      inherited;
      if (ProcessStepId <> 0) and (not(IsFormReadOnly)) then begin
          ProcResource.Processes.New;
          ProcResource.Processes.ProcessStepId := ProcessStepID;
          ProcResource.Processes.PostDb;
      end;
      ProcessStepId := 0;

      ProcResource.ProcResourceDays;
      ProcResource.Processes;
      if AccessLevel <=3 then begin
        if ProcResource.Processes.Count > 0 then begin
          qryProcessStep.Close;
          qryProcessStep.ParamByName('Id').AsInteger := ProcResource.Processes.ProcessStepId;
          qryProcessStep.Open;
          qryResourceProcessStep.First;
          qryResourceProcessStep.IndexFieldNames:= 'ProcessStepDescription ASC';
        end;
      end;
      GetCapacityTimes;
      ProcResource.ProcResourceDetails;
      opendb(qryfixedassets);

  finally
    RealignTabControl(pgResDetailsRelated, 1);
    EnableForm;
  end;
end;



procedure TfmProcResourceEdit.SetProcessStepId(const Value: Integer);
begin
  fiProcessStepId := Value;
  if (Value <> 0) and (not(IsFormReadOnly)) and (ProcResource.ID>0) then begin
          ProcResource.Processes.New;
          ProcResource.Processes.ProcessStepId := ProcessStepID;
          ProcResource.Processes.PostDb;
          fiProcessStepId := 0;
  end;
end;


Function TfmProcResourceEdit.DoAfterSave :Boolean;
begin
  REsult := True;
  if not samevalue(ProcResource.CleanHourlyLabourRate , ProcResource.HourlyLabourRate , AppEnv.RegionalOptions.DecimalPlaces) then
    if Appenv.Employee.RunManufacturingUpdateBatch  then
      if MessageDlgXP_Vista('Hourly Rate is Changed. '+NL+
                            'Do you wish to Update all BOMs for the new Rate? '+NL+''+NL+
                            '(Only the Product Card will be Changed, not the Existing Orders)', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      RecalculateBOMcostnPrice;

end;
procedure TfmProcResourceEdit.RecalculateBOMcostnPrice;
var
  updatePrice, UpdateCost :Boolean;
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  With qry do try
    SQL.Add('select  P.PartsId, P.PartName, PT.ProcTreeId , P.BOMPriceCalculatedfromTree , '+
            ' P.BOMCostCalculatedFromTree '+
            ' from tblparts P '+
            ' inner join tblproctree PT on P.partsId = PT.MasterId and PT.MasterType = "mtProduct" and ifnull(PT.ParentId,0)=0');
    Open;
    if recordcount =0 then exit;
    First;
    DoshowProgressbar(REcordcount, 'Updating BOM Cost and Price');
    try
      While Eof = False do begin
          DoStepProgressbar(fieldbyname('Partname').AsString);
          updatePrice := (fieldbyname('BOMPriceCalculatedfromTree').asBoolean) ;
          UpdateCost :=  (fieldbyname('BOMCostCalculatedFromTree').asBoolean)  ;

          BOMCostnPriceLib.RecalculateBOMcostnPrice(Fieldbyname('PartsID').AsInteger ,
                                   Fieldbyname('ProcTreeId').AsInteger  ,
                                   updatePrice ,UpdateCost);
          Next;
      end;
    finally
      DoHideProgressbar;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure TfmProcResourceEdit.actCancelExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmProcResourceEdit.btnAutoSelectClick(Sender: TObject);
begin
  inherited;
  if ProcResource.AnyRostered then
    if MessageDlgXP_Vista('This Resource is already Rostdred.'+NL+
                          'This Will delete all existing Roster and Create New based on the Week days and time selected.'+NL+NL+
                          'Do you wish to Continue?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;

end;

procedure TfmProcResourceEdit.btnCopyTimeClick(Sender: TObject);
var
  CapacityHoursDay: double;
  DayStartAt: TDateTime;
begin
  inherited;
  if DayName <> '' then begin
    if MessageDlgXP_Vista('Do you want to copy the values from ' + DayName + ' to all other days?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then begin
      CapacityHoursDay := TypInfo.GetFloatProp(ProcResource.ProcResourceDays, DayName + 'CapacityHoursDay');
      DayStartAt := TypInfo.GetFloatProp(ProcResource.ProcResourceDays, DayName + 'StartAt');
      if ProcResource.ProcResourceDays.Sunday then begin
        ProcResource.ProcResourceDays.SundayCapacityHoursDay := CapacityHoursDay;
        ProcResource.ProcResourceDays.SundayStartAt := DayStartAt;
      end;
      if ProcResource.ProcResourceDays.Monday then begin
        ProcResource.ProcResourceDays.MondayCapacityHoursDay := CapacityHoursDay;
        ProcResource.ProcResourceDays.MondayStartAt := DayStartAt;
      end;

      if ProcResource.ProcResourceDays.Tuesday then begin
        ProcResource.ProcResourceDays.TuesdayCapacityHoursDay := CapacityHoursDay;
        ProcResource.ProcResourceDays.TuesdayStartAt := DayStartAt;
      end;

      if ProcResource.ProcResourceDays.Wednesday then begin
        ProcResource.ProcResourceDays.WednesdayCapacityHoursDay := CapacityHoursDay;
        ProcResource.ProcResourceDays.WednesdayStartAt := DayStartAt;
      end;

      if ProcResource.ProcResourceDays.Thursday then begin
        ProcResource.ProcResourceDays.ThursdayCapacityHoursDay := CapacityHoursDay;
        ProcResource.ProcResourceDays.ThursdayStartAt := DayStartAt;
      end;

      if ProcResource.ProcResourceDays.Friday then begin
        ProcResource.ProcResourceDays.FridayCapacityHoursDay := CapacityHoursDay;
        ProcResource.ProcResourceDays.FridayStartAt := DayStartAt;
      end;

      if ProcResource.ProcResourceDays.Saturday then begin
        ProcResource.ProcResourceDays.SaturdayCapacityHoursDay := CapacityHoursDay;
        ProcResource.ProcResourceDays.SaturdayStartAt := DayStartAt;
      end;

      RefreshAllCapacity;
    end;
  end;
end;

procedure TfmProcResourceEdit.btnDeleteClick(Sender: TObject);
var
 s: string;
begin
  inherited;
  if (not ProcessDataUtils.ProcessStepInUse(ProcResource.Processes.ProcessStepId)) or {not used in sales}
    (ProcResource.ProcessUsedByOtherResource(ProcResource.Processes.ProcessStepId, s)) or {is linked to other resources}
    (not(ProcResource.Processes.ISunique(ProcResource.Processes.ID, 'ProcessStepId = ' + inttostr(ProcResource.Processes.ProcessStepId), ProcResource.connection.Connection))){is a duplicate for this resouce } then begin
    ProcResource.Processes.Delete;
  end  else begin
    MessageDlgXP_Vista('Can not delete this Process Step as it is being used on Sales Orders that are currently in production.',
    mtInformation, [mbOk], 0);
  end;
end;



procedure TfmProcResourceEdit.ActionListUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  grdSteps.Enabled:= ProcResource.ResourceName <> '';
end;

procedure TfmProcResourceEdit.DoBusinessObjectEvent( const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Change) and (Value = BusObjEvent_ResourceCapacity) then begin
    RefreshAllCapacity;
  end  else if EventType = BusObjEvent_GUIFocusField then begin
         if Value = 'ResourceName' then edtName.SetFocus
    else if Value = 'SundayCapacityHours'     then SetControlFocus(edtSundayCapacityHrs)
    else if Value = 'MondayCapacityHours'     then SetControlFocus(edtMondayCapacityHrs)
    else if Value = 'TuesdayCapacityHours'    then SetControlFocus(edtTuesdayCapacityHrs)
    else if Value = 'WednesdayCapacityHours'  then SetControlFocus(edtwednesdayCapacityHrs)
    else if Value = 'ThursdayCapacityHours'   then SetControlFocus(edtThursdayCapacityHrs)
    else if Value = 'FridayCapacityHours'     then SetControlFocus(edtFridayCapacityHrs)
    else if Value = 'SaturdayCapacityHours'   then SetControlFocus(edtSAturdayCapacityHrs)
    else if Value = 'SundayStartAt'     then SetControlFocus(dtSundayStartAt)
    else if Value = 'MondayStartAt'     then SetControlFocus(dtMondayStartAt)
    else if Value = 'TuesdayStartAt'    then SetControlFocus(dtTuesdayStartAt)
    else if Value = 'WednesdayStartAt'  then SetControlFocus(dtwednesdayStartAt)
    else if Value = 'ThursdayStartAt'   then SetControlFocus(dtThursdayStartAt)
    else if Value = 'FridayStartAt'     then SetControlFocus(dtFridayStartAt)
    else if Value = 'SaturdayStartAt'   then SetControlFocus(dtSAturdayStartAt);
  end else if (Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterOpen) and (Sender is TProcResource) then begin
    ShowColorDetailComponents;
  end;
end;
procedure TfmProcResourceEdit.grdStepsEnter(Sender: TObject);
begin
  inherited;
  DayName := '';
  btnCopyTime.Enabled := false;
end;

procedure TfmProcResourceEdit.grdStepsExit(Sender: TObject);
begin
  inherited;
  if qryResourceProcessStep.State in [dsEdit, dsInsert] then
    qryResourceProcessStep.Post;
end;






procedure TfmProcResourceEdit.cboStepDescriptionBeforeDropDown(
  Sender: TObject);
begin
  inherited;
  qryProcessStep.Close;
  qryProcessStep.ParamByName('Id').AsInteger := ProcResource.Processes.ProcessStepId;
  qryProcessStep.Open;
end;

procedure TfmProcResourceEdit.cboStepDescriptionNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
var
  ProcStep: TProcessStep;
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('Selection NOT in list, Create New?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin

    ProcStep:= TProcessStep.Create(nil);
    try
      ProcStep.Connection := TMyDacDataConnection.Create(ProcResource);
      ProcStep.Connection.MyDacConnection:= MyConnection;
      ProcStep.New;
      ProcStep.Description:= NewValue;
      ProcStep.ResultStatus.Clear;
      if ProcStep.Save then begin
        qryProcessStep.Close;
        qryProcessStep.Open;
        ProcResource.Processes.ProcessStepId:= ProcStep.Id;
        Accept:= true;
      end
      else begin
        CommonLib.MessageDlgXP_Vista(ProcStep.ResultStatus.Messages,
          mtInformation, [mbOk], 0);
        Accept:= false;
      end;
    finally
      ProcStep.Free;
    end;
  end
  else
    Accept:= false;
end;

procedure TfmProcResourceEdit.cboUnitOfMeasureCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  ProcResource.ProcresourceDetails.UOMID :=  qryUnitOfMeasureUnitID.asInteger;
  ProcResource.ProcresourceDetails.UOMMult :=  qryUnitOfMeasureMultiplier.asFloat;
  ProcResource.ProcresourceDetails.PostDB;
end;

procedure TfmProcResourceEdit.cboUnitOfMeasureNotInList(Sender: TObject;  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
  inherited;
  Accept := False;
end;

procedure TfmProcResourceEdit.GetCapacityTimes;
begin
  (* edCapacityHours.Text:= ProcTimeToStr(ProcResource.CapacityHoursDay); *)
  edtSundayCapacityHrs.Text   := ProcTimeToStr(ProcResource.ProcResourceDays.SundayCapacityHoursDay   );
  edtmondayCapacityHrs.Text   := ProcTimeToStr(ProcResource.ProcResourceDays.MondayCapacityHoursDay   );
  edtTuesdayCapacityHrs.Text  := ProcTimeToStr(ProcResource.ProcResourceDays.TuesdayCapacityHoursDay  );
  edtWednesdayCapacityHrs.Text:= ProcTimeToStr(ProcResource.ProcResourceDays.WednesdayCapacityHoursDay);
  edtThursdayCapacityHrs.Text := ProcTimeToStr(ProcResource.ProcResourceDays.ThursdayCapacityHoursDay );
  edtFridayCapacityHrs.Text   := ProcTimeToStr(ProcResource.ProcResourceDays.FridayCapacityHoursDay   );
  edtSAturdayCapacityHrs.Text := ProcTimeToStr(ProcResource.ProcResourceDays.SAturdayCapacityHoursDay );

  (*edtTotSundayCapacityHrs.Text   := ProcTimeToStr(ProcResource.ProcResourceDays.SundayTotCapacityHoursDay   );
  edtTotmondayCapacityHrs.Text   := ProcTimeToStr(ProcResource.ProcResourceDays.MondayTotCapacityHoursDay   );
  edtTotTuesdayCapacityHrs.Text  := ProcTimeToStr(ProcResource.ProcResourceDays.TuesdayTotCapacityHoursDay  );
  edtTotWednesdayCapacityHrs.Text:= ProcTimeToStr(ProcResource.ProcResourceDays.WednesdayTotCapacityHoursDay);
  edtTotThursdayCapacityHrs.Text := ProcTimeToStr(ProcResource.ProcResourceDays.ThursdayTotCapacityHoursDay );
  edtTotFridayCapacityHrs.Text   := ProcTimeToStr(ProcResource.ProcResourceDays.FridayTotCapacityHoursDay   );
  edtTotSAturdayCapacityHrs.Text := ProcTimeToStr(ProcResource.ProcResourceDays.SAturdayTotCapacityHoursDay );*)


  edSetupHours.Text:= ProcTimeToStr(ProcResource.SetupHoursDay);
  edBreakdownHours.Text:= ProcTimeToStr(ProcResource.BreakdownHoursDay);
end;

procedure TfmProcResourceEdit.edSetupHoursEnter(Sender: TObject);
begin
  inherited;
  DayName := '';
  btnCopyTime.Enabled := false;
end;

procedure TfmProcResourceEdit.edSetupHoursExit(Sender: TObject);
begin
  inherited;
  TMaskEdit(Sender).Text:=
    StringReplace(TMaskEdit(Sender).Text,' ','0',[rfReplaceAll]);
  ProcResource.SetupHoursDay:= StrToProcTime(TMaskEdit(Sender).Text);
end;


procedure TfmProcResourceEdit.edBreakdownHoursEnter(Sender: TObject);
begin
  inherited;
  DayName := '';
  btnCopyTime.Enabled := false;
end;

procedure TfmProcResourceEdit.edBreakdownHoursExit(Sender: TObject);
begin
  inherited;
  TMaskEdit(Sender).Text:=
    StringReplace(TMaskEdit(Sender).Text,' ','0',[rfReplaceAll]);
  ProcResource.BreakdownHoursDay:= StrToProcTime(TMaskEdit(Sender).Text);
end;

procedure TfmProcResourceEdit.ValidateCapacityformat(Sender:TMaskEdit);
var
  str1, str2:String;
begin
  if Sender.Text = '  :  :  ' then sender.text := '00:00:00';
  if length(sender.text)>8 then Sender.text := copy(Sender.text,1,8);
  str1:= '';str2:= '';
  try
    if (length(sender.text)>=1) and (not(isinteger(Copy(sender.text,1,1)))) then str1 := '0' else str1:=Copy(sender.text,1,1);
    if (length(sender.text)>=2) and (not(isinteger(Copy(sender.text,2,1)))) then str1 := str1+ '0' else str1:=str1+Copy(sender.text,2,1);
    //if strtoint(str1)>24 then str1:= '24';
    str1 := str1+ ':' ;
    str2:= str1;
    str1:= '';
    if (length(sender.text)>=4) and (not(isinteger(Copy(sender.text,4,1)))) then str1 := str1+ '0' else str1:=str1+Copy(sender.text,4,1);
    if (length(sender.text)>=5) and (not(isinteger(Copy(sender.text,5,1)))) then str1 := str1+ '0' else str1:=str1+Copy(sender.text,5,1);
    if strtoint(str1)>59 then str1:= '59';
    str1 := str1+ ':' ;
    str2:= str2+str1;
    str1:= '';
    if (length(sender.text)>=7) and (not(isinteger(Copy(sender.text,7,1)))) then str1 := str1+ '0' else str1:=str1+Copy(sender.text,7,1);
    if (length(sender.text)>=8) and (not(isinteger(Copy(sender.text,8,1)))) then str1 := str1+ '0' else str1:=str1+Copy(sender.text,8,1);
    if strtoint(str1)>59 then str1:= '59';
    str2:= str2+str1;

  finally
    sender.text:= str2;
  end;
end;
procedure TfmProcResourceEdit.wwIButton1Click(Sender: TObject);
begin
  inherited;
  if ProcResource.ProcResourceDetails.Id =0 then Exit;
  if MessageDlgXP_Vista('Are you sure you want to delete '+ Quotedstr(ProcResource.ProcResourceDetails.Description)+' ?', mtconfirmation, [mbyes,mbNo], 0) = mryes then begin
    if ProcResourceDetailsUsed(ProcResource.ProcResourceDetails.ID) then begin
      ProcResource.ProcResourceDetails.active := False;
      ProcResource.ProcResourceDetails.ResourceAvailable := False;
      ProcResource.ProcResourceDetails.PostDB;
    end else if ProcResource.ResourceCount = 1 then begin
      ProcResource.ProcResourceDetails.active := False;
      ProcResource.ProcResourceDetails.ResourceAvailable := False;
      ProcResource.ProcResourceDetails.PostDB;
    end else begin
      ProcResource.ProcResourceDetails.Delete;
    end;
  end;
end;

procedure TfmProcResourceEdit.wwIButton2Click(Sender: TObject);
begin
  inherited;
  if ProcResource.ProcResourceDetails.ProcResourceUnAvailability.Id =0 then exit;
  ProcResource.ProcResourceDetails.ProcResourceUnAvailability.Delete;
end;

procedure TfmProcResourceEdit.ApplicationEvents1Exception(Sender: TObject;  E: Exception);
begin
  inherited;
  if E is EDBEditError then begin
    if ActiveControl is TMaskEdit then begin
      ValidateCapacityformat(TMaskEdit(ActiveControl));
      if (TMaskEdit(ActiveControl).text = '00:00:00') or ((StrToProcTime(TMaskEdit(ActiveControl).Text)> 0) and (StrToProcTime(TMaskEdit(ActiveControl).Text)<=24*60*60 )) then begin
        exit;
      end;
    end;
    if ActiveControl = edSetupHours then
      MessageDlgXP_Vista('Setup time format is not correct (must be hh:mm:ss)'(*+ ', use Esc to cancel changes.' *),mtInformation,[mbOk],0)
    else if ActiveControl = edBreakdownHours then
      MessageDlgXP_Vista('Breakdown time format is not correct (must be hh:mm:ss)'(* +', use Esc to cancel changes.' *),mtInformation,[mbOk],0)
    else  if (ActiveControl = edtSundayCapacityHrs)
          or (ActiveControl = edtmondayCapacityHrs)
          or (ActiveControl = edtTuesdayCapacityHrs)
          or (ActiveControl = edtWednesdayCapacityHrs)
          or (ActiveControl = edtThursdayCapacityHrs)
          or (ActiveControl = edtFridayCapacityHrs)
          or (ActiveControl = edtSAturdayCapacityHrs) then
      MessageDlgXP_Vista('Capacity time format is not correct (must be hh:mm:ss)'(* +', use Esc to cancel changes.' *),mtInformation,[mbOk],0)
  else
    raise E;
  end;
end;
procedure TfmProcResourceEdit.edtSundayCapacityHrsChange(Sender: TObject);
begin
  inherited;
  ValidateCapacityformat(TMaskEdit(Sender));
end;

procedure TfmProcResourceEdit.edtSundayCapacityHrsEnter(Sender: TObject);
begin
  inherited;
  TMaskEdit(ActiveControl).selstart := 0;
  TMaskEdit(ActiveControl).Sellength :=0;
  DayName := StringReplace(TMaskEdit(Sender).Name,'edt','',[rfIgnoreCAse]);
  DayName := StringReplace(DayName,'CapacityHrs','',[rfIgnoreCAse]);
  btnCopyTime.Enabled := true;
end;

procedure TfmProcResourceEdit.edtSundayCapacityHrsExit    (Sender: TObject);begin  ProcResource.ProcResourceDays.SundayCapacityHoursDay   :=MaskeditTextTodouble(sender, dtSundayStartAt)     ;ProcResource.ProcResourceDays.SundaystartAt := dtSundayStartAt.Time; ProcResource.ProcResourceDays.postDB; end;
procedure TfmProcResourceEdit.edtmondayCapacityHrsExit    (Sender: TObject);begin  ProcResource.ProcResourceDays.MondayCapacityHoursDay   :=MaskeditTextTodouble(sender, dtMondayStartAt)     ;ProcResource.ProcResourceDays.SundaystartAt := dtSundayStartAt.Time; ProcResource.ProcResourceDays.postDB; end;
procedure TfmProcResourceEdit.edtTuesdayCapacityHrsExit   (Sender: TObject);begin  ProcResource.ProcResourceDays.TuesdayCapacityHoursDay  :=MaskeditTextTodouble(sender, dtTuesdayStartAt)    ;ProcResource.ProcResourceDays.SundaystartAt := dtSundayStartAt.Time; ProcResource.ProcResourceDays.postDB; end;
procedure TfmProcResourceEdit.edtWednesdayCapacityHrsExit (Sender: TObject);begin  ProcResource.ProcResourceDays.WednesdayCapacityHoursDay:=MaskeditTextTodouble(sender, dtWednesdayStartAt)  ;ProcResource.ProcResourceDays.SundaystartAt := dtSundayStartAt.Time; ProcResource.ProcResourceDays.postDB; end;
procedure TfmProcResourceEdit.edtThursdayCapacityHrsExit  (Sender: TObject);begin  ProcResource.ProcResourceDays.ThursdayCapacityHoursDay :=MaskeditTextTodouble(sender, dtThursdayStartAt)   ;ProcResource.ProcResourceDays.SundaystartAt := dtSundayStartAt.Time; ProcResource.ProcResourceDays.postDB; end;
procedure TfmProcResourceEdit.edtDescriptionEnter(Sender: TObject);
begin
  inherited;
  DayName := '';
  btnCopyTime.Enabled := false;
end;

procedure TfmProcResourceEdit.edtFridayCapacityHrsExit    (Sender: TObject);begin  ProcResource.ProcResourceDays.FridayCapacityHoursDay   :=MaskeditTextTodouble(sender, dtFridayStartAt)     ;ProcResource.ProcResourceDays.SundaystartAt := dtSundayStartAt.Time; ProcResource.ProcResourceDays.postDB; end;
procedure TfmProcResourceEdit.edtHourlyOverheadRateEnter(Sender: TObject);
begin
  inherited;
  DayName := '';
  btnCopyTime.Enabled := false;
end;

procedure TfmProcResourceEdit.edtHourlyRateEnter(Sender: TObject);
begin
  inherited;
  DayName := '';
  btnCopyTime.Enabled := false;
end;

procedure TfmProcResourceEdit.edtSAturdayCapacityHrsExit  (Sender: TObject);begin ProcResource.ProcResourceDays.SAturdayCapacityHoursDay  :=MaskeditTextTodouble(sender, dtSaturdayStartAt)   ;ProcResource.ProcResourceDays.SundaystartAt := dtSundayStartAt.Time; ProcResource.ProcResourceDays.postDB; end;

procedure TfmProcResourceEdit.dtSundayStartAtEnter(Sender: TObject);
begin
  inherited;
  DayName := StringReplace(TMaskEdit(Sender).Name,'dt','',[rfIgnoreCAse]);
  DayName := StringReplace(DayName,'StartAt','',[rfIgnoreCAse]);
  btnCopyTime.Enabled := true;
end;

procedure TfmProcResourceEdit.dtSundayStartAtExit    (Sender: TObject);begin  ProcResource.ProcResourceDays.SundayCapacityHoursDay   :=MaskeditTextTodouble(edtSundayCapacityHrs    , Sender, 'Tm') ;ProcResource.ProcResourceDays.SundaystartAt    := dtSundayStartAt.Time   ; ProcResource.ProcResourceDays.postDB; end;
procedure TfmProcResourceEdit.dtMondayStartAtExit    (Sender: TObject);begin  ProcResource.ProcResourceDays.MondayCapacityHoursDay   :=MaskeditTextTodouble(edtmondayCapacityHrs    , Sender, 'Tm') ;ProcResource.ProcResourceDays.MondaystartAt    := dtMondayStartAt.Time   ; ProcResource.ProcResourceDays.postDB; end;
procedure TfmProcResourceEdit.dtTuesdayStartAtExit   (Sender: TObject);begin  ProcResource.ProcResourceDays.TuesdayCapacityHoursDay  :=MaskeditTextTodouble(edtTuesdayCapacityHrs   , Sender, 'Tm') ;ProcResource.ProcResourceDays.TuesdaystartAt   := dtTuesdayStartAt.Time  ; ProcResource.ProcResourceDays.postDB; end;
procedure TfmProcResourceEdit.dtWednesdayStartAtExit (Sender: TObject);begin  ProcResource.ProcResourceDays.WednesdayCapacityHoursDay:=MaskeditTextTodouble(edtwednesdayCapacityHrs , Sender, 'Tm') ;ProcResource.ProcResourceDays.WednesdaystartAt := dtWednesdayStartAt.Time; ProcResource.ProcResourceDays.postDB; end;
procedure TfmProcResourceEdit.dtThursdayStartAtExit  (Sender: TObject);begin  ProcResource.ProcResourceDays.ThursdayCapacityHoursDay :=MaskeditTextTodouble(edtthursdayCapacityHrs  , Sender, 'Tm') ;ProcResource.ProcResourceDays.ThursdaystartAt  := dtThursdayStartAt.Time ; ProcResource.ProcResourceDays.postDB; end;
procedure TfmProcResourceEdit.dtFridayStartAtExit    (Sender: TObject);begin  ProcResource.ProcResourceDays.FridayCapacityHoursDay   :=MaskeditTextTodouble(edtfridayCapacityHrs    , Sender, 'Tm') ;ProcResource.ProcResourceDays.FridaystartAt    := dtFridayStartAt.Time   ; ProcResource.ProcResourceDays.postDB; end;
procedure TfmProcResourceEdit.dtSaturdayStartAtExit  (Sender: TObject);begin  ProcResource.ProcResourceDays.SAturdayCapacityHoursDay :=MaskeditTextTodouble(edtSaturdayCapacityHrs  , Sender, 'Tm') ;ProcResource.ProcResourceDays.SaturdaystartAt  := dtSaturdayStartAt.Time ; ProcResource.ProcResourceDays.postDB; end;

procedure TfmProcResourceEdit.dtSundayStartAtDblClick   (Sender: TObject);begin  if (Sender is TwwDBDateTimePicker) and (TwwDBDateTimePicker(Sender).text = '') then ProcResource.ProcResourceDays.SundayStartAt   := Appenv.CompanyPrefs.StartOfDay;end;
procedure TfmProcResourceEdit.dtMondayStartAtDblClick   (Sender: TObject);begin  if (Sender is TwwDBDateTimePicker) and (TwwDBDateTimePicker(Sender).text = '') then ProcResource.ProcResourceDays.MondayStartAt   := Appenv.CompanyPrefs.StartOfDay;end;
procedure TfmProcResourceEdit.dtTuesdayStartAtDblClick  (Sender: TObject);begin  if (Sender is TwwDBDateTimePicker) and (TwwDBDateTimePicker(Sender).text = '') then ProcResource.ProcResourceDays.TuesdayStartAt  := Appenv.CompanyPrefs.StartOfDay;end;
procedure TfmProcResourceEdit.dtWednesdayStartAtDblClick(Sender: TObject);begin  if (Sender is TwwDBDateTimePicker) and (TwwDBDateTimePicker(Sender).text = '') then ProcResource.ProcResourceDays.WednesdayStartAt:= Appenv.CompanyPrefs.StartOfDay;end;
procedure TfmProcResourceEdit.dtThursdayStartAtDblClick (Sender: TObject);begin  if (Sender is TwwDBDateTimePicker) and (TwwDBDateTimePicker(Sender).text = '') then ProcResource.ProcResourceDays.ThursdayStartAt := Appenv.CompanyPrefs.StartOfDay;end;
procedure TfmProcResourceEdit.dtFridayStartAtDblClick   (Sender: TObject);begin  if (Sender is TwwDBDateTimePicker) and (TwwDBDateTimePicker(Sender).text = '') then ProcResource.ProcResourceDays.FridayStartAt   := Appenv.CompanyPrefs.StartOfDay;end;
procedure TfmProcResourceEdit.dtSaturdayStartAtDblClick (Sender: TObject);begin  if (Sender is TwwDBDateTimePicker) and (TwwDBDateTimePicker(Sender).text = '') then ProcResource.ProcResourceDays.SaturdayStartAt := Appenv.CompanyPrefs.StartOfDay;end;

Procedure TfmProcResourceEdit.RefreshAllCapacity;
begin
  edtSundayCapacityHrs.Text   := ProcTimeToStr(ProcResource.ProcResourceDays.SundayCapacityHoursDay   );
  edtmondayCapacityHrs.Text   := ProcTimeToStr(ProcResource.ProcResourceDays.MondayCapacityHoursDay   );
  edtTuesdayCapacityHrs.Text  := ProcTimeToStr(ProcResource.ProcResourceDays.TuesdayCapacityHoursDay  );
  edtWednesdayCapacityHrs.Text:= ProcTimeToStr(ProcResource.ProcResourceDays.WednesdayCapacityHoursDay);
  edtThursdayCapacityHrs.Text := ProcTimeToStr(ProcResource.ProcResourceDays.ThursdayCapacityHoursDay );
  edtFridayCapacityHrs.Text   := ProcTimeToStr(ProcResource.ProcResourceDays.FridayCapacityHoursDay   );
  edtSAturdayCapacityHrs.Text := ProcTimeToStr(ProcResource.ProcResourceDays.SAturdayCapacityHoursDay );

  edSetupHours.Text:= ProcTimeToStr(ProcResource.SetupHoursDay);
  edBreakdownHours.Text:= ProcTimeToStr(ProcResource.BreakdownHoursDay);
end;
Procedure TfmProcResourceEdit.RefreshtotalCapacity;
begin
  edtTotSundayCapacityHrs.Text   := ProcTimeToStr(ProcResource.ProcResourceDays.SundayTotCapacityHoursDay   );
  edtTotmondayCapacityHrs.Text   := ProcTimeToStr(ProcResource.ProcResourceDays.MondayTotCapacityHoursDay   );
  edtTotTuesdayCapacityHrs.Text  := ProcTimeToStr(ProcResource.ProcResourceDays.TuesdayTotCapacityHoursDay  );
  edtTotWednesdayCapacityHrs.Text:= ProcTimeToStr(ProcResource.ProcResourceDays.WednesdayTotCapacityHoursDay);
  edtTotThursdayCapacityHrs.Text := ProcTimeToStr(ProcResource.ProcResourceDays.ThursdayTotCapacityHoursDay );
  edtTotFridayCapacityHrs.Text   := ProcTimeToStr(ProcResource.ProcResourceDays.FridayTotCapacityHoursDay   );
  edtTotSAturdayCapacityHrs.Text := ProcTimeToStr(ProcResource.ProcResourceDays.SAturdayTotCapacityHoursDay );
end;

procedure TfmProcResourceEdit.RepeatUnAvailability(Sender: TObject);
var
  dt1, dt2:TDateTime;
  s:String;
begin
  inherited;
  if Sender = mnuRepeatUnavailabilityWeek then begin
    dt1:= incWeek(ProcResource.ProcResourceDetails.ProcResourceUnAvailability.TimeStart , 1);
    dt2:= incWeek(ProcResource.ProcResourceDetails.ProcResourceUnAvailability.TimeEnd , 1);
  end else if Sender = mnuRepeatUnavailabilityMonth then begin
    dt1:= incmonth(ProcResource.ProcResourceDetails.ProcResourceUnAvailability.TimeStart , 1);
    dt2:= incmonth(ProcResource.ProcResourceDetails.ProcResourceUnAvailability.TimeEnd , 1);
  end else if Sender = mnuRepeatUnavailabilityYear then begin
    dt1:= incyear(ProcResource.ProcResourceDetails.ProcResourceUnAvailability.TimeStart , 1);
    dt2:= incyear(ProcResource.ProcResourceDetails.ProcResourceUnAvailability.TimeEnd , 1);
  end else begin
    Exit;
  end;
  if (dt1<>0) and (dt2<>0) then begin
    s:= ProcResource.ProcResourceDetails.ProcResourceUnAvailability.Description;
    ProcResource.ProcResourceDetails.ProcResourceUnAvailability.New;
    ProcResource.ProcResourceDetails.ProcResourceUnAvailability.timeStart:= dt1;
    ProcResource.ProcResourceDetails.ProcResourceUnAvailability.TimeEnd := dt2;
    ProcResource.ProcResourceDetails.ProcResourceUnAvailability.Description := s;
    ProcResource.ProcResourceDetails.ProcResourceUnAvailability.PostDB;
  end;
end;

function TfmProcResourceEdit.MaskeditTextTodouble(Sender: TObject;DayStartAt:tObject;change:String='Hr'):double;
(*var
  Capacity :Double;
  StartAt :TTime;*)
begin
  Result  := 0;
  if not(Sender is TMaskEdit) then exit;
  TMaskEdit(Sender).Text:=StringReplace(TMaskEdit(Sender).Text,' ','0',[rfReplaceAll]);
  ValidateCapacityformat(TMaskEdit(Sender));
  {this is the validation for 24 hours day - which is not applicable as there can be multiple people working in the resource}
  (*Capacity :=StrToProcTime(TMaskEdit(Sender).Text);
  StartAt :=TwwDBDateTimePicker(DayStartAt).Time;
  ProcResource.ValidateHrs(Capacity , StartAt ,  ProcResource.SetupHoursDay, ProcResource.BreakdownHoursDay , change );
  TMaskEdit(Sender).Text    := ProcTimeToStr(Capacity);
  TwwDBDateTimePicker(DayStartAt).Time := StartAt;*)
  Result:= StrToProcTime(TMaskEdit(Sender).Text);
end;

procedure TfmProcResourceEdit.mnuRepeatUnavailabilityPopup(Sender: TObject);
begin
  inherited;
  mnuRepeatUnavailabilityWeek.visible := (ProcResource.ProcResourceDetails.ProcResourceUnAvailability.ID<>0) and (Accesslevel <=3);
  mnuRepeatUnavailabilityMonth.visible:= (ProcResource.ProcResourceDetails.ProcResourceUnAvailability.ID<>0) and (Accesslevel <=3);
  mnuRepeatUnavailabilityYEar.visible := (ProcResource.ProcResourceDetails.ProcResourceUnAvailability.ID<>0) and (Accesslevel <=3);
end;
procedure TfmProcResourceEdit.pgResDetailsRelatedResize(Sender: TObject);
begin
  inherited;
  RealignTabControl(pgResDetailsRelated, 1);
end;


procedure TfmProcResourceEdit.qryProcResourcedaysCalcFields(DataSet: TDataSet);
begin
  inherited;
    qryProcResourcedaysSundayTotCapacityHoursDay.asFloat    := qryProcResourceResourceCount.AsInteger * qryProcResourcedaysSundayCapacityHoursDay.asFloat   ;
    qryProcResourcedaysMondayTotCapacityHoursDay.asFloat    := qryProcResourceResourceCount.AsInteger * qryProcResourcedaysMondayCapacityHoursDay.asFloat   ;
    qryProcResourcedaysTuesdayTotCapacityHoursDay.asFloat   := qryProcResourceResourceCount.AsInteger * qryProcResourcedaysTuesdayCapacityHoursDay.asFloat  ;
    qryProcResourcedaysWednesdayTotCapacityHoursDay.asFloat := qryProcResourceResourceCount.AsInteger * qryProcResourcedaysWednesdayCapacityHoursDay.asFloat;
    qryProcResourcedaysThursdayTotCapacityHoursDay.asFloat  := qryProcResourceResourceCount.AsInteger * qryProcResourcedaysThursdayCapacityHoursDay.asFloat ;
    qryProcResourcedaysFridayTotCapacityHoursDay.asFloat    := qryProcResourceResourceCount.AsInteger * qryProcResourcedaysFridayCapacityHoursDay.asFloat   ;
    qryProcResourcedaysSaturdayTotCapacityHoursDay.asFloat  := qryProcResourceResourceCount.AsInteger * qryProcResourcedaysSaturdayCapacityHoursDay.asFloat ;

    RefreshtotalCapacity;

end;

procedure TfmProcResourceEdit.UpdateMe(const Cancelled: Boolean;
  const aObject: TObject);
begin
  if Cancelled then begin
    Exit;
  end else begin
      if LastComboAccessed = cboProductName then begin
        closenopendb(LastComboAccessed.LookupTable);
        if LastComboAccessed.LookupTable.Locate('Name', NewProductName, []) then begin
          ProcResource.ProcResourceDetails.ProcResourceProducts.ProductName := NewProductName;
          ProcResource.ProcResourceDetails.ProcResourceProducts.PostDB;
        end;
      end;
  end;
end;

initialization

  RegisterClassOnce(TfmProcResourceEdit);
  with FormFact do begin
    // register all columns on course list form to open this form on DblClick
    RegisterMe(TfmProcResourceEdit, 'TfmProcResourceList_*_F=ProcResourceId');
  end;


end.
