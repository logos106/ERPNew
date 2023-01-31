unit frmEmpRosterBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase, Planner, DBPlanner, wwdbdatetimepicker , frmRosterBase,
  ComCtrls, DataSourcePrefs;

type
  TRosterBaseObj = class(TObject)
  Private
    fsGlobalRef: String;
    fiID: Integer;
    fsItemCaption: String;
  Protected
  Public
    Property ID :Integer read fiID write fiID;
    Property GlobalRef:String read fsGlobalRef write fsGlobalRef;
    Property ItemCaption:String read fsItemCaption write fsItemCaption;

  end;

  TfmEmpRosterBase = class(TfmRosterBaseGUI)
    QryProcessEmployees: TERPQuery;
    QryProcessEmployeesEmployeeID: TIntegerField;
    QryProcessEmployeesEmployeeName: TWideStringField;
    dsProcessEmployees: TDataSource;
    QryProcessEmployeesEmpPosNo: TLargeintField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure RosterFieldsToItem(Sender: TObject; Fields: TFields;Item: TPlannerItem);
    procedure RosterItemToField(Sender: TObject; Fields: TFields;Item: TPlannerItem);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure Initform;

  Protected
    ItemProperties : TRosterBaseObj;

    function busobj: TMSBusObj;virtual; abstract;
    Procedure NewItemProperty; virtual; abstract;
    Procedure InitItemProperties(Fields: TFields);Virtual;
    Procedure InitPlanner;virtual;

    function PlannerEmployeeId:Integer;Virtual;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    function SaveRecord: Boolean;Virtual;
    Procedure LoadBusObj;Virtual;
    Procedure MakeNewEntry(oItem : TPlannerItem; Sender:TObject);Virtual;
    function StartDate:TDateTime; Virtual;
    Procedure RefreshQuery; Virtual;
    function GetEmployeeFromPosition(const iPosition: integer): integer;Virtual;
    function GetPositionFromEmployee(const fiEmployeeId: integer): integer;Virtual;

    Procedure OnCellPopup(Sender: TObject); Override;
    Procedure OnDatechange (Sender:TObject);Override;

  public
    { Public declarations }
  end;


implementation

uses CommonLib, CommonDbLib, RosterLib, LogLib, AppEnvironment;

{$R *.dfm}

procedure TfmEmpRosterBase.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

Function TfmEmpRosterBase.SaveRecord :Boolean;
begin
  result:= False;
  busobj.PostDB;
  if not(busobj.Save) then exit;
  Result:= True;

end;

function TfmEmpRosterBase.StartDate: TDateTime;
begin
  Result := Date;
end;

procedure TfmEmpRosterBase.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  busobj.Connection.CommitTransaction;
  Self.Close;
end;

procedure TfmEmpRosterBase.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
end;

function TfmEmpRosterBase.PlannerEmployeeId: Integer;
begin
  Result := 0;
  if (planner.SelPosition <= QryProcessEmployees.RecordCount - 1) then begin
    QryProcessEmployees.First;
    QryProcessEmployees.MoveBy(planner.SelPosition);
    Result := QryProcessEmployeesemployeeId.AsInteger;
  end;
end;

procedure TfmEmpRosterBase.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmEmpRosterBase.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  if ErrorOccurred then Exit;

  CanClose := false;
  if busobj.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveRecord then begin
            busobj.Connection.CommitTransaction;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          busobj.Connection.RollbackTransaction;
          busobj.Dirty := false;
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

procedure TfmEmpRosterBase.FormCreate(Sender: TObject);
begin
  RosterSource.Planner :=  Planner;
  inherited;
  RosterDatePicker.StartDate :=StartDate;
  Initform;
end;
Procedure TfmEmpRosterBase.Initform;
begin
  if planner.PositionWidth  < 30 then planner.PositionWidth := 30;
  planner.GridLeftCol := 14;
  planner.MultiSelect := true;

  if AppEnv.Employee.Calender24hr then planner.HourType := ht24hrs else planner.HourType := ht12hrs;

  planner.Header.Height := planner.Width;
  planner.Header.TextHeight := 100;
  planner.Header.Color := $00FFDDC6;
  planner.Header.Captions.Clear;
  planner.Header.Captions.Add('');
  planner.ItemGap := 0;

   planner.Display.DisplayUnit := 30; // 30 min steps
   planner.Display.DisplayEnd := 47; // 48 * 30 = full day
   planner.Display.DisplayScale := 28;
   planner.Display.DisplayText := 0;
   planner.Sidebar.Width := 40;
   planner.Sidebar.DateTimeFormat := FormatSettings.ShortDateFormat;

end;
procedure TfmEmpRosterBase.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen: array of string;
begin
  inherited;
  Setlength(QueryNamesNotToOpen, 1);
  QueryNamesNotToOpen[0] := 'QryRoster';
  openQueries(QueryNamesNotToOpen);
  InitPlanner;
  if RosterSource.active = False then RosterSource.active := True;
  RefreshQuery;
end;

function TfmEmpRosterBase.GetEmployeeFromPosition(  const iPosition: integer): integer;
begin
  if QryProcessEmployees.Locate('EmpPosNo', iPosition+1, [loCaseInsensitive]) then begin
    Result := QryProcessEmployees.FieldByName('EmployeeID').AsInteger;
  end else begin
    Result := 0;
  end;

end;

function TfmEmpRosterBase.GetPositionFromEmployee(
  const fiEmployeeId: integer): integer;
begin
  if QryProcessEmployees.Locate('EmployeeID', fiEmployeeId, [loCaseInsensitive]) then begin
    Result := QryProcessEmployees.FieldByName('EmpPosNo').AsInteger-1;
  end else begin
    Result := 0;
  end;

end;

procedure TfmEmpRosterBase.InitItemProperties(Fields: TFields);
begin
  (*if ItemProperties = nil then *)NewItemProperty;
  ItemProperties.ID       := Fields.FieldByName('ID').asInteger;
  ItemProperties.globalref:= Fields.FieldByName('GlobalRef').asString;
end;

procedure TfmEmpRosterBase.InitPlanner;
begin
  opendb(QryProcessEmployees);
  RosterSource.NumberOfResources := QryProcessEmployees.RecordCount;
  (*if planner.PositionWidth  < 30 then planner.PositionWidth := 30;
  planner.GridLeftCol := 14;
  planner.MultiSelect := true;

  if AppEnv.Employee.Calender24hr then planner.HourType := ht24hrs else planner.HourType := ht12hrs;

  planner.Header.Height := 100;
  planner.Header.TextHeight := 100;
  planner.Header.Color := $00FFDDC6;
  planner.Header.Captions.Clear;
  planner.Header.Captions.Add('');
  planner.ItemGap := 0;

   planner.Display.DisplayUnit := 30; // 30 min steps
   planner.Display.DisplayEnd := 47; // 48 * 30 = full day
   planner.Display.DisplayScale := 28;
   planner.Display.DisplayText := 0;
   planner.Sidebar.Width := 40;
   planner.Sidebar.DateTimeFormat := FormatSettings.ShortDateFormat;*)

  planner.Header.Captions.Clear;
  planner.Header.Captions.Add('');
  with QryProcessEmployees do begin
    First;
    while not Eof do begin
      planner.Header.Captions.Add(FieldByName('EmployeeName').AsString);
      Next;
    end;
  end;
end;


procedure TfmEmpRosterBase.LoadBusObj;
begin

end;

procedure TfmEmpRosterBase.MakeNewEntry(oItem : TPlannerItem; Sender:TObject);
begin

end;



procedure TfmEmpRosterBase.OnCellPopup(Sender: TObject);
var
  oItem: TPlannerItem;
begin
  inherited;
  if (planner.SelPosition <= QryProcessEmployees.RecordCount - 1) then begin

        planner.SelectCells(planner.SelItemBegin , planner.SelItemEnd-1 , planner.SelPosition);
        oItem := planner.CreateItemAtSelection;
        MakeNewEntry(oItem, sender);
        oItem.ItemObject :=  ItemProperties;
        oItem.Update;
  end;
end;

procedure TfmEmpRosterBase.OnDatechange(Sender: TObject);
begin
  inherited;
  if not (Isformshown) then exit;
  RefreshQuery;
end;

procedure TfmEmpRosterBase.RefreshQuery;
begin

end;

procedure TfmEmpRosterBase.RosterFieldsToItem(Sender: TObject;
  Fields: TFields; Item: TPlannerItem);
begin
  inherited;
  Item.TrackVisible := False;
  Item.visible := True;
  Item.BorderColor := clwhite;
  InitItemProperties(Fields);
  Item.ItemObject := ItemProperties;
end;

procedure TfmEmpRosterBase.RosterItemToField(Sender: TObject;
  Fields: TFields; Item: TPlannerItem);
begin
  inherited;
//
end;

initialization
  RegisterClassOnce(TfmEmpRosterBase);

end.

