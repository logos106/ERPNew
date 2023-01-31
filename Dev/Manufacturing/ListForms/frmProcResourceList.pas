unit frmProcResourceList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB,  ProgressDialog, DBAccess,
  MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, StdCtrls, wwdblook, Shader, DNMPanel, ComCtrls,AdvOfficeStatusBar,
  DNMSpeedButton, kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox, wwradiogroup,
  wwclearbuttongroup, GIFImg;

type
  TfmProcResourceList = class(TBaseListingGUI)
    qryMainResourceName: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainResourceAvailable: TWideStringField;
    qryMainBreakdownHoursDay: TFloatField;
    qryMainHourlyLabourRate: TFloatField;
    qryMainHourlyOverheadRate: TFloatField;
    qryMainActive: TWideStringField;
    qryMainSetupHoursDay: TFloatField;
    qryMaincSundayCapacityHoursDay: TStringField;
    qryMaincMondayCapacityHoursDay: TStringField;
    qryMaincTuesdayCapacityHoursDay: TStringField;
    qryMaincwednesdayCapacityHoursDay: TStringField;
    qryMaincThursDayCapacityHoursDay: TStringField;
    qryMaincFridayCapacityHoursDay: TStringField;
    qryMaincSAturdayCapacityHoursDay: TStringField;
    qryMaincBreakdownHoursDay: TStringField;
    qryMaincSetupHoursDay: TStringField;
    qryMainSunday: TWideStringField;
    qryMainSundayCapacityHoursDay: TFloatField;
    qryMainMonday: TWideStringField;
    qryMainMondayCapacityHoursDay: TFloatField;
    qryMainTuesDay: TWideStringField;
    qryMainTuesdayCapacityHoursDay: TFloatField;
    qryMainWednesDay: TWideStringField;
    qryMainWednesdayCapacityHoursDay: TFloatField;
    qryMainThursday: TWideStringField;
    qryMainThursdayCapacityHoursDay: TFloatField;
    qryMainFriday: TWideStringField;
    qryMainFridayCapacityHoursDay: TFloatField;
    qryMainSAturday: TWideStringField;
    qryMainSaturdayCapacityHoursDay: TFloatField;
    qryMainDetails: TLargeintField;
    qryMainDetailName: TWideStringField;
    qryMainDetResourceAvailable: TWideStringField;
    qryMainDetActive: TWideStringField;
    grpExtraFilters: TwwRadioGroup;
    qryMainProcResourceId: TLargeintField;
    DNMSpeedButton1: TDNMSpeedButton;
    Qryprocesstime: TERPQuery;
    qryMainResDetailId: TIntegerField;
    QryProcResourceProcess: TERPQuery;
    qryMainResourceCount: TIntegerField;
    qryMainrownum: TLargeintField;
    qryMainUsedWithProductsInSeq: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainCalcTitleAttributes(Sender: TObject; AFieldName: string;
      AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);
  private
    function ResDetSNotUsed(const RDID: Integer): Boolean;
    function HasnoResProcess(const RID: Integer): Boolean;
  protected
    Procedure SetGridColumns;Override;
    procedure RefreshQuery; override;
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); override;
    procedure ReadnApplyGuiPrefExtra; OVERRIDE;
    Procedure WriteGuiPrefExtra; OVERRIDE;
  public
    { Public declarations }
  end;

implementation

uses
  CommonLib, BaseInputForm, ProcessUtils, ManufactureLib, SharedObjs, LogLib,
  tcConst;

{$R *.dfm}

{ TfmProcResourceList }

procedure TfmProcResourceList.ReadnApplyGuiPrefExtra;
begin
  inherited;
    if GuiPrefs.Node.Exists('Options.ExtraFilters') then
      grpExtraFilters.ItemIndex :=  GuiPrefs.Node['Options.ExtraFilters'].asInteger;

end;

procedure TfmProcResourceList.RefreshQuery;
begin
  inherited;
end;

procedure TfmProcResourceList.SetGridColumns;
begin
  inherited;
    RemoveFieldfromGrid(Qrymainrownum.FieldName);
    RemoveFieldfromGrid(QrymainDetails.FieldName);
    RemoveFieldfromGrid(QrymainProcresourceID.FieldName);
    RemoveFieldfromGrid(qryMainSundayCapacityHoursDay.FieldName);
    RemoveFieldfromGrid(qryMainMondayCapacityHoursDay.FieldName);
    RemoveFieldfromGrid(qryMainTuesdayCapacityHoursDay.FieldName);
    RemoveFieldfromGrid(qryMainWednesdayCapacityHoursDay.FieldName);
    RemoveFieldfromGrid(qryMainThursdayCapacityHoursDay.FieldName);
    RemoveFieldfromGrid(qryMainFridayCapacityHoursDay.FieldName);
    RemoveFieldfromGrid(qryMainSaturdayCapacityHoursDay.FieldName);
    RemoveFieldfromGrid(QrymainBreakdownHoursDay.FieldName);
    RemoveFieldfromGrid(QrymainSetupHoursDay.FieldName);
end;

procedure TfmProcResourceList.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.ExtraFilters'].asInteger := grpExtraFilters.ItemIndex;
end;

procedure TfmProcResourceList.cmdNewClick(Sender: TObject);
var
  EditForm : TBaseInputGUI;
begin
  inherited;
  EditForm := TBaseInputGUI(GetComponentByClassName('TfmProcResourceEdit'));
  if Assigned(EditForm) then begin
    with EditForm do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

procedure TfmProcResourceList.DNMSpeedButton1Click(Sender: TObject);
var
  i :Integer;
begin
  inherited;

  if SelectedRecords  =0 then begin
    MessageDlgXP_Vista('Please Choose the Resources to be Deleted', mtWarning, [mbOK], 0);
    Exit;
  end;

  if grpExtraFilters.itemIndex = 0 then
    if MessageDlgXP_vista('Please Note that the Resource can be deleted only if there is no ''Resource Details'' Associated with it.'+NL+NL+
                        'Select ''Details'' Option to Get the List with Resource Details.'+NL+NL+NL+
                        'Do you wish to continue with the current Selection?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;

  ScriptMain.SQL.Clear;
  i := 0;
  try
    ScriptMain.SQL.Add(ERPFixtableSQL('tblempresprocschedule' , 'Del_PS'));
    ScriptMain.SQL.Add(ERPFixtableSQL('tblprocresourcedetails', 'Del_PS'));
    ScriptMain.SQL.Add(ERPFixtableSQL('tblProcResource'       , 'Del_PS'));
    ScriptMain.SQL.Add(ERPFixtableSQL('tblProcResourceProcess', 'Del_PS'));

    i := ScriptMain.SQL.Count;

    IterateProcNo := 1;
    IterateselectedRecords(True);

    IterateProcNo := 2;
    IterateselectedRecords(True);
  finally
    if ScriptMain.SQL.Count >i then begin
      clog(ScriptMain.SQL.Text);
      ScriptMain.Execute;
      RefreshQuery;
    end;
  end;
end;

procedure TfmProcResourceList.IterateselectedRecordsCallback(var Abort: boolean;SelIndex: Integer);
begin
  inherited;
  If IterateProcno = 1 then begin
     if qryMainResDetailId.AsInteger <> 0 then begin
      if ResDetSNotUsed(qryMainResDetailId.AsInteger) then begin
        ScriptMain.SQL.Add('Delete from tblempresprocschedule where ResourcedetailId  = ' +inttostr(qryMainResDetailId.AsInteger)+' ;');
        ScriptMain.SQL.Add('Delete from tblprocresourcedetails where ID = ' +inttostr(qryMainResDetailId.AsInteger)+' ;');
      end;
     end;
  end else If IterateProcno = 2 then begin
     if qryMainProcResourceId.AsInteger <> 0 then begin
      if HasnoResProcess(qryMainProcResourceId.AsInteger) then
        ScriptMain.SQL.Add('Delete from tblProcResource where ProcResourceId = ' + inttostr(qryMainProcResourceId.AsInteger)+' and ProcResourceId not in (Select ProcResourceId from tblprocresourcedetails);');
      ScriptMain.SQL.Add('update tblProcResource PR Set ResourceCount = (Select count(ID) from tblprocresourcedetails PD where PD.ProcResourceId = PR.ProcResourceId) where ProcResourceId = ' + inttostr(qryMainProcResourceId.AsInteger)+' ;');
     end;
  end;
end;

procedure TfmProcResourceList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmProcResourceList.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
(*  if (QrymainDetails.AsInteger=2) and (QrymainRownum.AsInteger>1) then
    if (SameText(Field.fieldname , QrymainDetailName.FieldName)) or
       (SameText(Field.fieldname , QrymainDetResourceAvailable.FieldName)) or
       (SameText(Field.fieldname , QrymainDetActive.FieldName))  then else Afont.Color := ABrush.Color;*)

       if (SameText(Field.fieldname , 'sunday')     or SameText(Field.fieldname , 'cSundayCapacityHoursDay'))     and (IsWeekendday(7)) then ABrush.Color:= $00CEFFFF
  else if (SameText(Field.fieldname , 'Monday')     or SameText(Field.fieldname , 'cMondayCapacityHoursDay'))     and (IsWeekendday(1)) then ABrush.Color:= $00CEFFFF
  else if (SameText(Field.fieldname , 'Tuesday')    or SameText(Field.fieldname , 'cTuesdayCapacityHoursDay'))    and (IsWeekendday(2)) then ABrush.Color:= $00CEFFFF
  else if (SameText(Field.fieldname , 'Wednesday')  or SameText(Field.fieldname , 'cWednesdayCapacityHoursDay'))  and (IsWeekendday(3)) then ABrush.Color:= $00CEFFFF
  else if (SameText(Field.fieldname , 'Thursday')   or SameText(Field.fieldname , 'cThursdayCapacityHoursDay'))   and (IsWeekendday(4)) then ABrush.Color:= $00CEFFFF
  else if (SameText(Field.fieldname , 'Friday')     or SameText(Field.fieldname , 'cFridayCapacityHoursDay'))     and (IsWeekendday(5)) then ABrush.Color:= $00CEFFFF
  else if (SameText(Field.fieldname , 'SAturday')   or SameText(Field.fieldname , 'cSaturdayCapacityHoursDay'))   and (IsWeekendday(6)) then ABrush.Color:= $00CEFFFF
  else if SameText(Field.fieldname , 'cSundayCapacityHoursDay')     or
          SameText(Field.fieldname , 'cMondayCapacityHoursDay')     or
          SameText(Field.fieldname , 'cTuesdayCapacityHoursDay')    or
          SameText(Field.fieldname , 'cWednesdayCapacityHoursDay')  or
          SameText(Field.fieldname , 'cThursdayCapacityHoursDay')   or
          SameText(Field.fieldname , 'cFridayCapacityHoursDay')     or
          SameText(Field.fieldname , 'cSaturdayCapacityHoursDay')   or
          SameText(Field.fieldname , 'cSetupHoursDay')              or
          SameText(Field.fieldname , 'cBreakdownHoursDay')   then
end;

procedure TfmProcResourceList.grdMainCalcTitleAttributes(Sender: TObject;
  AFieldName: string; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  inherited;
       if (SameText(AFieldName , 'sunday')     or SameText(AFieldName , 'cSundayCapacityHoursDay'))     and (IsWeekendday(7)) then ABrush.Color:= $00CEFFFF
  else if (SameText(AFieldName , 'Monday')     or SameText(AFieldName , 'cMondayCapacityHoursDay'))     and (IsWeekendday(1)) then ABrush.Color:= $00CEFFFF
  else if (SameText(AFieldName , 'Tuesday')    or SameText(AFieldName , 'cTuesdayCapacityHoursDay'))    and (IsWeekendday(2)) then ABrush.Color:= $00CEFFFF
  else if (SameText(AFieldName , 'Wednesday')  or SameText(AFieldName , 'cWednesdayCapacityHoursDay'))  and (IsWeekendday(3)) then ABrush.Color:= $00CEFFFF
  else if (SameText(AFieldName , 'Thursday')   or SameText(AFieldName , 'cThursdayCapacityHoursDay'))   and (IsWeekendday(4)) then ABrush.Color:= $00CEFFFF
  else if (SameText(AFieldName , 'Friday')     or SameText(AFieldName , 'cFridayCapacityHoursDay'))     and (IsWeekendday(5)) then ABrush.Color:= $00CEFFFF
  else if (SameText(AFieldName , 'SAturday')   or SameText(AFieldName , 'cSaturdayCapacityHoursDay'))   and (IsWeekendday(6)) then ABrush.Color:= $00CEFFFF;
end;

procedure TfmProcResourceList.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMainUsedWithProductsInSeq.AsString;
  inherited;
end;

procedure TfmProcResourceList.grpFiltersClick(Sender: TObject);
var
  s1, s2:String;
begin
  InitGroupfilterString(qryMainActive.fieldname  , ['T','F' , '']);
  s1:= groupfilterstring;
  InitGroupfilterString(qryMainDetails.fieldname  , ['1','2'], true ,grpExtraFilters );
  s2:= groupfilterstring;
  if (s1<> '') and (s2<> '') then groupfilterstring := '('+s1+') and ('+s2+')'
  else if s1<> '' then groupfilterString := s1
  else groupfilterString := s2;
  inherited;
  (*if grpExtraFilters.Itemindex =0 then begin
    RemoveFieldfromGrid(qryMainDetailName.fieldname);
    RemoveFieldfromGrid(qryMainDetResourceAvailable.fieldname);
    RemoveFieldfromGrid(qryMainDetActive.fieldname);
  end else begin
    AddFieldtoGrid(qryMainDetailName.fieldname , grdmain.selected.count);
    AddFieldtoGrid(qryMainDetResourceAvailable.fieldname, grdmain.selected.count);
    AddFieldtoGrid(qryMainDetActive.fieldname, grdmain.selected.count);
  end;*)
  if grpExtraFilters.itemindex = 0 then begin
    grdmain.Linecolors.Groupingcolor := clsilver;
    grdmain.Groupfieldname:= '';
  end else begin
    grdmain.Linecolors.Groupingcolor := clDkGray;
    grdmain.Groupfieldname:= 'ResourceName';
  end;
end;
function TfmProcResourceList.HasnoResProcess(const RID: Integer): Boolean;
begin
  if (QryProcResourceProcess.active =False) or (QryProcResourceProcess.Parambyname('RID').asInteger <> RID) then begin
    CloseDB(QryProcResourceProcess);
    QryProcResourceProcess.Parambyname('RID').asInteger :=  RID;
    OpenDB(QryProcResourceProcess);
  end;
  Result := QryProcResourceProcess.RecordCount=0;
end;
Function TfmProcResourceList.ResDetSNotUsed(const RDID:Integer):Boolean;
begin
  if (Qryprocesstime.active =False) or (Qryprocesstime.Parambyname('RDID').asInteger <> RDID) then begin
    CloseDB(Qryprocesstime);
    Qryprocesstime.Parambyname('RDID').asInteger :=  RDID;
    OpenDB(Qryprocesstime);
  end;
  Result := Qryprocesstime.RecordCount=0;
end;

procedure TfmProcResourceList.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  QrymaincSundayCapacityHoursDay.asString := ProcTimeToStr(QrymainSundayCapacityHoursDay.asFloat,true);
  QrymaincMondayCapacityHoursDay.asString := ProcTimeToStr(QrymainMondayCapacityHoursDay.asFloat,true);
  QrymaincTuesdayCapacityHoursDay.asString := ProcTimeToStr(QrymainTuesdayCapacityHoursDay.asFloat,true);
  QrymaincWednesdayCapacityHoursDay.asString := ProcTimeToStr(QrymainWednesdayCapacityHoursDay.asFloat,true);
  QrymaincThursdayCapacityHoursDay.asString := ProcTimeToStr(QrymainThursdayCapacityHoursDay.asFloat,true);
  QrymaincFridayCapacityHoursDay.asString := ProcTimeToStr(QrymainFridayCapacityHoursDay.asFloat,true);
  QrymaincSaturdayCapacityHoursDay.asString := ProcTimeToStr(QrymainSaturdayCapacityHoursDay.asFloat,true);
  QrymaincBreakdownHoursDay.asString := ProcTimeToStr(QrymainBreakdownHoursDay.asFloat,true);
  QrymaincSetupHoursDay.asString := ProcTimeToStr(QrymainSetupHoursDay.asFloat,true);
end;

initialization
  RegisterClassOnce(TfmProcResourceList);


end.



