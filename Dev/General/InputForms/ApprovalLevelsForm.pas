unit ApprovalLevelsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DB, DBAccess, MyAccess,ERPdbComponents,
  SelectionDialog, AppEvnts, ExtCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  StdCtrls, DNMSpeedButton, MemDS, Shader, DNMPanel, BusObjApprovals, Mask,
  BusObjBase, wwdbedit, Wwdotdot, Wwdbcomb, wwdblook, ImgList, ProgressDialog , GridGuiObj;

type
  TApprovalLevelsGUI = class(TBaseInputGUI)
    grdApprovals: TwwDBGrid;
    grdFollowupsIButton: TwwIButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryApprovals: TERPQuery;
    btnOk: TDNMSpeedButton;
    cmdClose: TDNMSpeedButton;
    chkShowInactive: TCheckBox;
    dsMain: TDataSource;
    qryApprovalsGlobalRef: TWideStringField;
    qryApprovalsID: TIntegerField;
    qryApprovalsLevel: TIntegerField;
    qryApprovalsApprovalType: TWideStringField;
    qryApprovalsEmployeeID: TIntegerField;
    qryApprovalsEmployeeName: TWideStringField;
    qryApprovalsValueFrom: TFloatField;
    qryApprovalsValueTo: TFloatField;
    qryApprovalsEnteredByEmployeeID: TIntegerField;
    qryApprovalsEnteredByEmployeeName: TWideStringField;
    qryApprovalsActive: TWideStringField;
    cboApprovalType: TwwDBComboBox;
    qryEmployeeLookup: TERPQuery;
    dsEmployeeLookup: TDataSource;
    cboEmployee: TwwDBLookupCombo;
    Label1: TLabel;
    qryApprovalsValueLeeway: TFloatField;
    qryApprovalsmstimeStamp: TDateTimeField;
    qryApprovalsmsUpdateSiteCode: TWideStringField;
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkShowInactiveClick(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure grdFollowupsIButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure grdApprovalsTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure FormDestroy(Sender: TObject);
  private
    ApprovalLevels: TApprovalLevels;
    fGridGuiObj : TGridGuiObj;
    fsSortColumnName:String;
    fsBaseIndexFieldNames:String;
    fsColumnOrderMode:String;
    fbSwapBaseIndexFieldPriority:Boolean;
    fsSecondaryIndexFieldNames:String;

    function GridGuiObj : TGridGuiObj;
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string); Override;
  public
    { Public declarations }
  end;


implementation

uses
  DNMLib, DNMExceptions, CommonLib, CommonDbLib, BusObjConst, PreferancesLib;

{$R *.dfm}

procedure TApprovalLevelsGUI.btnOkClick(Sender: TObject);
begin
  try
    ApprovalLevels.PostDb;
  except
    on EAbort do begin end;
  end;
  if ApprovalLevels.Save then begin
    PreferancesLib.DoPrefAuditTrail;
    ApprovalLevels.connection.CommitTransaction;
    Close;
  end;
end;

procedure TApprovalLevelsGUI.FormCreate(Sender: TObject);
begin
  fGridGuiObj :=nil;
  AllowCustomiseGrid := true;
  inherited;
  ApprovalLevels := TApprovalLevels.Create(Self);
  ApprovalLevels.Connection := TMyDacDataConnection.Create(ApprovalLevels);
  ApprovalLevels.Connection.Connection := MyConnection;
  ApprovalLevels.BusObjEvent := DoBusinessObjectEvent;

  cboApprovalType.Items.Add(ApprovalTypeBill);
  cboApprovalType.Items.Add(ApprovalTypeCredit);
  cboApprovalType.Items.Add(ApprovalTypeExpenseClaim);
  cboApprovalType.Items.Add(ApprovalTypeJournalEntry);
  cboApprovalType.Items.Add(ApprovalTypePurchaseOrder);
  cboApprovalType.Items.Add(ApprovalTypeSmartOrder);
  cboApprovalType.Items.Add(ApprovalTypeStockAdjustment);

end;
procedure TApprovalLevelsGUI.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fGridGuiObj);
  inherited;

end;

procedure TApprovalLevelsGUI.DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);
begin
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TApprovalLevels         then TApprovalLevels(Sender).DataSet     := qryApprovals;
    end;
end;
procedure TApprovalLevelsGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      GuiPrefs.Active := True;
      ApprovalLevels.SQLOrder := 'Approvaltype,Employeename';
      ApprovalLevels.load;//LoadSelect('Active = "T"');
      OpenQueries;
      ApprovalLevels.connection.BeginTransaction;

      ApprovalLevels.DataSet.Filter := 'Active = ' + QuotedStr('T');
      ApprovalLevels.DataSet.Filtered := true;

      if ApprovalLevels.count = 0 then ApprovalLevels.new;

      GuiPrefs.DbGridElement[grdApprovals].RemoveField(qryApprovalsLevel.fieldname);
      GuiPrefs.DbGridElement[grdApprovals].RemoveField(qryApprovalsEnteredByEmployeeName.fieldname);
      GuiPrefs.DbGridElement[grdApprovals].RemoveField(qryApprovalsEnteredByEmployeeID.fieldname);
      GuiPrefs.DbGridElement[grdApprovals].RemoveField(qryApprovalsEmployeeID.fieldname);
      GuiPrefs.DbGridElement[grdApprovals].RemoveField(qryApprovalsGlobalref.fieldname);
      GuiPrefs.DbGridElement[grdApprovals].RemoveField(qryApprovalsId.fieldname);
      GuiPrefs.DbGridElement[grdApprovals].RemoveField(qryApprovalsmstimeStamp.fieldname);
      GuiPrefs.DbGridElement[grdApprovals].RemoveField(qryApprovalsmsUpdateSiteCode.fieldname);

    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;
      else raise;
    end;
    SetControlFocus(grdApprovals);
  finally
    EnableForm;
  end;
end;


procedure TApprovalLevelsGUI.chkShowInactiveClick(Sender: TObject);
begin
  ApprovalLevels.DataSet.Filtered := not(chkShowInactive.Checked);
  (*try
    ApprovalLevels.PostDb;
  except
    on EAbort do begin end;
  end;
  if chkShowInactive.Checked then begin
    if ApprovalLevels.SQLSelect = 'Active = "T"' then begin
      ApprovalLevels.LoadSelect('');
    end;
  end else if ApprovalLevels.SQLSelect = '' then
    ApprovalLevels.LoadSelect('Active = "T"');*)
end;

procedure TApprovalLevelsGUI.cmdCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TApprovalLevelsGUI.grdApprovalsTitleButtonClick(Sender: TObject;  AFieldName: string);
begin
  inherited;
  Processingcursor(True);
  try
    GridGuiObj.GridTitleButtonClick(Sender, AFieldname, fsSortColumnName , fsBaseIndexFieldNames , fsColumnOrderMode , fbSwapBaseIndexFieldPriority, fsSecondaryIndexFieldNames , '', nil);
  finally
    Processingcursor(False);
  end;

end;

procedure TApprovalLevelsGUI.grdFollowupsIButtonClick(Sender: TObject);
begin
  ApprovalLevels.DeleteLine;
end;

procedure TApprovalLevelsGUI.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TApprovalLevelsGUI.FormCloseQuery(Sender: TObject;   var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if ApprovalLevels.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if ApprovalLevels.Save then begin
            ApprovalLevels.connection.CommitTransaction;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          ApprovalLevels.connection.RollbackTransaction;
          ApprovalLevels.Dirty := false;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
          cmdClose.Enabled := True;
        end;
    end;
  end else begin
    CanClose := true;
    Notify(false);
  end;

end;
function TApprovalLevelsGUI.GridGuiObj: TGridGuiObj;
begin
  if fGridGuiObj = nil then begin
    fGridGuiObj := TGridGuiObj.create(self);
    fGridGuiObj.grid := grdApprovals;
  end;
  Result := fGridGuiObj;
end;

initialization
  RegisterClassOnce(TApprovalLevelsGUI);
end.

