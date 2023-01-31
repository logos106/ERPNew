unit frmProcCapacityPlanningPick;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DB, DBAccess,
  MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, ExtCtrls, ActnList, StdCtrls,
  Shader, DNMSpeedButton, DNMPanel, wwdbdatetimepicker,
  IntegerListObj, CheckLst, AdvGroupBox, wwcheckbox, ImgList, MemDS,
  ProgressDialog;

type
  TfmProcCapacityPlanningPick = class(TBaseInputGUI)
    pnlBottom: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    ActionList: TActionList;
    actGeneratePicking: TAction;
    actCancel: TAction;
    lstProcesses: TCheckListBox;
    grpDates: TAdvGroupBox;
    lblFrom: TLabel;
    dtFrom: TwwDBDateTimePicker;
    lblTo: TLabel;
    dtTo: TwwDBDateTimePicker;
    chkShowPickSlip: TCheckBox;
    chkUseDates: TwwCheckBox;
    procedure actCancelExecute(Sender: TObject);
    procedure actGeneratePickingExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure chkUseDatesClick(Sender: TObject);
  private
    TempTableName: string;
    function GetDateFrom: TDateTime;
    function GetDateTo: TDateTime;
    procedure SetDateFrom(const Value: TDateTime);
    procedure SetDateTo(const Value: TDateTime);
    procedure PopulateList;
  public
    ProcesstepIdList: TIntegerList;
    property DateFrom: TDateTime read GetDateFrom write SetDateFrom;
    property DateTo: TDateTime read GetDateTo write SetDateTo;
    procedure SelectAllProcessSteps;
  end;

var
  fmProcCapacityPlanningPick: TfmProcCapacityPlanningPick;

implementation

{$R *.dfm}

uses
  CommonDbLib, FastFuncs, ProcessDataUtils, MySQLConst;


procedure TfmProcCapacityPlanningPick.FormCreate(Sender: TObject);
begin
  fbIgnoreAccessLevels := true;
  inherited;
  ProcesstepIdList:= TIntegerList.Create;
  TempTableName:= GetUserTemporaryTableName('ProductionPickList');
  PopulateList;
end;

procedure TfmProcCapacityPlanningPick.FormDestroy(Sender: TObject);
begin
  inherited;
  ProcesstepIdList.Free;
  DestroyUserTemporaryTable(TempTableName);
end;

procedure TfmProcCapacityPlanningPick.FormShow(Sender: TObject);
begin
  inherited;
  self.BeginTransaction;
//  PopulateList;
end;

procedure TfmProcCapacityPlanningPick.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  self.RollbackTransaction;
  Action:= caFree;
end;

procedure TfmProcCapacityPlanningPick.actCancelExecute(Sender: TObject);
begin
  inherited;
  ModalResult:= mrCancel;
end;

procedure TfmProcCapacityPlanningPick.actGeneratePickingExecute(
  Sender: TObject);
var
  sql: string;
  x: integer;
//  ProcessSelected: boolean;
begin
  DisableForm;
  try
    inherited;
    sql:= '';

    ProcessDataUtils.BuildProductionRequirementsList(TempTableName);

  //  ProcessSelected:= false;
    for x:= 0 to lstProcesses.Count -1 do begin
      if lstProcesses.Checked[x] then begin
  //      ProcessSelected:= true;
        if sql <> '' then sql := sql + ' or';
        sql:= sql + ' (Locate("' + lstProcesses.Items[x] + '",pp.StepDescription) > 0)'
      end;
    end;

    if sql <> '' then
      sql:= ' and (' + sql + ')';

    sql:=
      '{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN ' +
      'FROM tblCompanyInformation AS CO'+
      '~|||~{ProcessParts}SELECT pp.*, p.* FROM ' + self.TempTableName + ' pp, tblParts p ' +
      'WHERE pp.ProcItemPartsId = p.PartsId ' +
      'AND pp.ProcItemPartsId > 0 AND pp.ProcItemRoot = "F" ' +
      'AND pp.ProcItemPartType = "INV"' +
      sql;

    if chkUseDates.Checked then begin
      sql:= sql + ' and (pp.StepTimeStart >= "' + FormatDateTime(MysqlDateFormat,dtFrom.DateTime) + '"' +
        ' and pp.StepTimeStart <= "' + FormatDateTime(MysqlDateFormat,dtTo.DateTime) + '")';
    end;

  //  if ProcessSelected then
  //    sql:= sql + ' order by pp.StepDescription, pp.ProcItemPartsId'
  //  else
      sql:= sql + ' order by pp.ProcItemPartsId';


    fbReportSQLSupplied:= true;
    fbTemplateUsesNonFormConnection := true;
    //self.PrintTemplateReport('Production Picking Slip',sql,false,1);
    self.PrintTemplateReport('Production Parts Picking Slip',sql,false,1);
  finally
    EnableForm;
  end; 
end;

function TfmProcCapacityPlanningPick.GetDateFrom: TDateTime;
begin
  result:= dtFrom.DateTime;
end;

function TfmProcCapacityPlanningPick.GetDateTo: TDateTime;
begin
  result:= dtTo.DateTime;
end;

procedure TfmProcCapacityPlanningPick.SetDateFrom(const Value: TDateTime);
begin
  dtFrom.DateTime:= Value;
end;

procedure TfmProcCapacityPlanningPick.SetDateTo(const Value: TDateTime);
begin
  dtTo.DateTime:= Value;
end;

procedure TfmProcCapacityPlanningPick.PopulateList;
var
  qry: TERPQuery;
  x: integer;
  posn: integer;
begin
  lstProcesses.Clear;
  qry:= CommonDbLib.TempMyQuery;
  try
    qry.SQL.Text:=
      'SELECT Id, Description FROM tblProcessStep ORDER BY Description';
    qry.Open;
    { add the selected Id's first at the top of the list }
    for x:= 0 to ProcesstepIdList.Count-1 do begin
      if qry.Locate('Id',ProcesstepIdList[x], []) then begin
        posn:= lstProcesses.Items.AddObject(qry.FieldByName('Description').AsString, TObject(ProcesstepIdList[x]));
        lstProcesses.Checked[posn]:= true;
      end
      else
        raise Exception.Create('TfmProcCapacityPlanningWork.PopulateList - Unable to locate record with Id: ' +
          IntToStr(ProcesstepIdList[x]));
    end;
    qry.First;
    while not qry.Eof do begin
      if lstProcesses.Items.IndexOfObject(TObject(qry.FieldByName('Id').AsInteger)) < 0 then begin
        posn:= lstProcesses.Items.AddObject(qry.FieldByName('Description').AsString, TObject(qry.FieldByName('Id').AsInteger));
        lstProcesses.Checked[posn]:= false;
      end;
      qry.Next;
    end;
  finally
    qry.Free;
  end;
end;

procedure TfmProcCapacityPlanningPick.chkUseDatesClick(Sender: TObject);
begin
  inherited;
  dtFrom.Enabled:= chkUseDates.Checked;
  dtTo.Enabled:= chkUseDates.Checked;
end;

procedure TfmProcCapacityPlanningPick.SelectAllProcessSteps;
var
  x: integer;
begin
  for x:= 0 to lstProcesses.Count -1 do begin
    lstProcesses.Checked[x]:= true;
  end;
end;

end.
