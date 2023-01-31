unit ReconListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, ExtCtrls, ComCtrls,AdvOfficeStatusBar, ImgList, Menus, AdvMenus, PrintDAT,
  ActnList, wwDialog, Wwlocate, SelectionDialog, DNMPanel,
  MemDS, DBAccess, MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog,
   wwdblook, Shader, kbmMemTable, DAScript, MyScript, CustomInputBox, wwcheckbox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TReconListGUI = class(TBaseListingGUI)
    qryMainReconciliationID: TAutoIncField;
    qryMainReconciliationDate: TDateField;
    qryMainClassID: TIntegerField;
    qryMainClassName: TWideStringField;
    qryMainAccountID: TIntegerField;
    qryMainEmployeeID: TIntegerField;
    qryMainEmployeeName: TWideStringField;
    qryMainNotes: TWideStringField;
    qryMainOpenBalance: TFloatField;
    qryMainCloseBalance: TFloatField;
    qryMainDeleted: TWideStringField;
    qryMainFinished: TWideStringField;
    qryMainStatementNo: TWideStringField;
    qryMainAccountName: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure cmdNewClick(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FooterPanelDblClick(Sender: TObject);
  private

    { Private declarations }
  protected
    procedure RefreshQuery; override;
    function IsRecFormOpened: Boolean;
    procedure SetGridColumns; override;
    procedure IterateselectedRecordsCallback(var Abort: boolean;SelIndex:Integer);Override;
  public
    { Public declarations }
  end;

implementation

uses ReconciliationForm, CommonLib, Forms, DateUtils, AppEnvironment,
  CommonFormLib, BusobjReconciliation;

{$R *.dfm}

procedure TReconListGUI.grdMainDblClick(Sender: TObject);
begin
  if IsRecFormOpened then exit;

  if Qrymaindeleted.AsBoolean then
    if AppEnv.AccessLevels.GetEmployeeAccessLevel('TfmReconciliationVerify')= 1 then begin
      OpenERPForm('TfmReconciliationVerify' , qryMainReconciliationID.AsInteger, nil, nil, True, true);
      Exit;
    end;

  if qryMainFinished.AsBoolean then
    if AppEnv.AccessLevels.GetEmployeeAccessLevel('TfmReconciliationVerify')= 1 then begin
      OpenERPForm('TfmReconciliationVerify' , qryMainReconciliationID.AsInteger, nil, nil, True, true);
      Exit;
    end;

  inherited;
end;

procedure TReconListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin
        GroupFilterString := 'Deleted <> ' + QuotedStr('T');
      end;
    1: 
      begin
        GroupFilterString := 'Deleted = ' + QuotedStr('T');
      end;
  end;
  inherited;
end;

procedure TReconListGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('txtfrom').asDate :=  filterDateFrom;
  qryMain.Params.ParamByName('txtto').asDate := filterDateto;
  inherited;
end;

procedure TReconListGUI.SetGridColumns;
begin
  inherited;
end;

procedure TReconListGUI.cmdNewClick(Sender: TObject);
begin
      OpenERPForm('TReconciliationGUI' , 0);
end;
function TReconListGUI.IsRecFormOpened:Boolean;
var
  frm :TComponent;
begin
  REsult:= False;
  frm := FindExistingComponent('TReconciliationGUI');
  if Assigned(frm) then begin
    CommonLib.MessageDlgXP_Vista('The Reconciliation Form is already open.', mtWarning, [mbOK], 0);
    TForm(frm).BringToFront;
    REsult := True;
    Exit;
  end;

  frm := FindExistingComponent('TfmReconciliationReDelete');
  if Assigned(frm) then begin
    CommonLib.MessageDlgXP_Vista('The Reconciliation Form is already open.', mtWarning, [mbOK], 0);
    TForm(frm).BringToFront;
    REsult := True;
    Exit;
  end;


end;
procedure TReconListGUI.IterateselectedRecordsCallback(var Abort: boolean;  SelIndex: Integer);
var
  ReconciliationObj : TReconciliation;
begin
  inherited;
  if iterateProcno = 1 then begin
    ReconciliationObj := TReconciliation.CreateWithNewConn(Self);
    try
      ReconciliationObj.Load(qryMainReconciliationID.AsInteger);
      if ReconciliationObj.count =0 then exit;
      if ReconciliationObj.deleted then exit;
      ReconciliationObj.connection.begintransaction;
      try
        ReconciliationObj.deleted := true;
        ReconciliationObj.PostDB;
        if not ReconciliationObj.Save then begin
          ReconciliationObj.connection.Rollbacktransaction;
          Exit;
        end;
        ReconciliationObj.connection.CommitTransaction;
      Except
        on E:Exception do begin
          ReconciliationObj.connection.Rollbacktransaction;
        end;
      end;

    finally
      Freeandnil(ReconciliationObj);
    end;
  end;
end;

procedure TReconListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TReconListGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TReconListGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TReconListGUI.FooterPanelDblClick(Sender: TObject);
begin
  inherited;
  if not devmode then exit;
  if MessageDlgXP_Vista('Delete all?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
  IterateProcno := 1;
  IterateRecords(true);
end;

procedure TReconListGUI.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('ClassID,AccountID,EmployeeID,ReconciliationID');
end;

initialization
  RegisterClassOnce(TReconListGUI);
end.
