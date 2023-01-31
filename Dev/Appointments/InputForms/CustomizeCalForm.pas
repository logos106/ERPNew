unit CustomizeCalForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB,  StdCtrls,
  ExtCtrls, DNMPanel, Buttons, DNMSpeedButton, CheckLst, DBAccess, MyAccess,ERPdbComponents, DataState,
  MemDS, Menus, AdvMenus, Shader, ImgList, ProgressDialog, ComCtrls;

type
  TCustomizeCalGUI = class(TBaseInputGUI)
    lstReps: TCheckListBox;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Label1: TLabel;
    qryCalPrefs: TERPQuery;
    qryReps: TERPQuery;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Label2: TLabel;
    lstZones: TListView;
    mnuTimeZone: TPopupMenu;
    mnuAddTimeZone: TMenuItem;
    mnuEditTimeZone: TMenuItem;
    mnuDeleteTimeZone: TMenuItem;
    Label3: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure mnuAddTimeZoneClick(Sender: TObject);
    procedure mnuEditTimeZoneClick(Sender: TObject);
    procedure mnuDeleteTimeZoneClick(Sender: TObject);
    procedure lstZonesDblClick(Sender: TObject);
  private
    { Private declarations }
    lstRepIDs: TStringList;
    procedure PopulateRepGrid;
    function InList(iEmployeeID: integer): boolean;
    procedure DisplayTimeZones;
  public
    { Public declarations }
  end;

implementation

uses FastFuncs, AppEnvironment, CommonLib, frmTimeZoneEdit,JsonObject,
  PreferancesLib;

{$R *.dfm}

{ TCustomizeCalGUI }

procedure TCustomizeCalGUI.DisplayTimeZones;
var
  x: integer;
  itm: TListItem;
  s: string;
  o: TJsonObject;
const
  OneHour = 1/24;
begin
  lstZones.Clear;
  for x := 0 to AppEnv.Employee.CalendarTimeZones.A['Zones'].Count -1 do begin
    itm := lstZones.Items.Add;
    o := AppEnv.Employee.CalendarTimeZones.A['Zones'].Items[x].AsObject;
    itm.Caption := o.S['Name'];
    if o.F['Offset'] = 0 then s := 'UTC'
    else if o.F['Offset'] < 0 then  s:= 'UTC - ' + FormatDateTime('hh:nn',Abs(o.F['Offset']) * OneHour)
    else s:= 'UTC + ' + FormatDateTime('hh:nn',Abs(o.F['Offset']) * OneHour);
    itm.SubItems.AddObject(s,TObject(x));
    itm.SubItems.Add(o.S['ShortName']);
    if o.B['DST'] then
      itm.SubItems.Add('Yes');
  end;


end;

procedure TCustomizeCalGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  Action := caFree;
end;

procedure TCustomizeCalGUI.FormCreate(Sender: TObject);
begin
  fbIgnoreAccessLevels := true;
  inherited;
  lstRepIDs := TStringList.Create;
end;

procedure TCustomizeCalGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    qryCalPrefs.ParamByName('xEmployeeID').asInteger := AppEnv.Employee.EmployeeID;
    OpenQueries;
    lstRepIDs.CommaText := qryCalPrefs.FieldByName('CalendarReps').AsString;
    lstRepIDs.Sort;
    PopulateRepGrid;
    DisplayTimeZones;
  finally
    EnableForm;
  end;
end;

procedure TCustomizeCalGUI.PopulateRepGrid;
var
  iIndex: integer;
begin
  lstReps.Clear;
  if not qryReps.IsEmpty then begin
    qryReps.First;
    while not qryReps.Eof do begin
      iIndex := lstReps.Items.Add(qryReps.FieldByName('EmployeeName').AsString);
      if InList(qryReps.FieldByName('EmployeeID').AsInteger) then begin
        lstReps.Checked[iIndex] := true;
      end;
      qryReps.Next;
    end;
  end;
end;

function TCustomizeCalGUI.InList(iEmployeeID: integer): boolean;
var
  iDummy: integer;
begin
  if lstRepIDs.Count = 0 then begin
    Result := true;
  end else begin
    Result := lstRepIDs.Find(IntToStr(iEmployeeID), iDummy);
  end;
end;

procedure TCustomizeCalGUI.lstZonesDblClick(Sender: TObject);
begin
  inherited;
  mnuEditTimeZoneClick(nil);
end;

procedure TCustomizeCalGUI.mnuAddTimeZoneClick(Sender: TObject);
var
  aName, aDisplay, aShortName: string;
  offset: double;
  DST: boolean;
  o: TJsonObject;
begin
  inherited;
  if SelectTimeZone(aName, aDisplay, aShortName, DST, offset) then begin
    o := JO;
    o.S['Name'] := aName;
    o.S['Display'] := aDisplay;
    o.S['ShortName'] := aShortName;
    o.B['DST'] := DST;
    o.F['Offset'] := offset;
    AppEnv.Employee.CalendarTimeZones.A['Zones'].Add(o);
    AppEnv.Employee.SaveCalendarTimeZones;
    DisplayTimeZones;
  end;

end;

procedure TCustomizeCalGUI.mnuDeleteTimeZoneClick(Sender: TObject);
var
  itm: TListItem;
begin
  inherited;
  itm := lstZones.Selected;
  if Assigned(itm) then begin
    AppEnv.Employee.CalendarTimeZones.A['Zones'].Delete(Integer(itm.SubItems.Objects[0]));
    AppEnv.Employee.SaveCalendarTimeZones;
    DisplayTimeZones;
  end;
end;

procedure TCustomizeCalGUI.mnuEditTimeZoneClick(Sender: TObject);
var
  itm: TListItem;
  o: TJsonObject;
  aName, aDisplay,aShortName: string;
  DST: boolean;
  offset: double;
begin
  inherited;
  itm := lstZones.Selected;
  if Assigned(itm) then begin
    o := AppEnv.Employee.CalendarTimeZones.A['Zones'].Items[Integer(itm.SubItems.Objects[0])].AsObject;
    aName := o.S['Name'];
    aDisplay := o.S['Display'];
    aShortName:= o.S['ShortName'];
    DST := o.B['DST'];
    offset := o.F['Offset'];
    if SelectTimeZone(aName, aDisplay, aShortName, DST, offset) then begin
      o.S['Name'] := aName;
      o.S['Display'] := aDisplay;
      o.S['ShortName'] := aShortName;
      o.B['DST'] := DST;
      o.F['Offset'] := offset;
      AppEnv.Employee.SaveCalendarTimeZones;
      DisplayTimeZones;
    end;
  end;
end;

procedure TCustomizeCalGUI.FormDestroy(Sender: TObject);
begin
  FreeandNil(lstRepIDs);
  inherited;
end;

procedure TCustomizeCalGUI.btnOKClick(Sender: TObject);
var
  i: integer;
begin
  inherited;
  lstRepIDs.Clear;
  for i := 0 to lstReps.Count - 1 do begin
    if lstReps.Checked[i] then begin
      if qryReps.Locate('EmployeeName', lstReps.Items[i], [loCaseInsensitive]) then begin
        lstRepIDs.Add(qryReps.FieldByName('EmployeeID').AsString);
      end;
    end;
  end;
  if qryCalPrefs.IsEmpty then begin
    qryCalPrefs.Insert;
  end else begin
    qryCalPrefs.Edit;
  end;
  qryCalPrefs.FieldByName('EmployeeID').AsInteger := AppEnv.Employee.EmployeeID;
  qryCalPrefs.FieldByName('CalendarReps').AsString := lstRepIDs.CommaText;
  qryCalPrefs.Post;
  PreferancesLib.DoPrefAuditTrail;
end;

initialization
  RegisterClassOnce(TCustomizeCalGUI);

end.
