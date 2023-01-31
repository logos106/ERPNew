unit ReconRulesListForm;

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
  TReconRulesListFormGUI = class(TBaseListingGUI)
    cboClientLookup: TERPQuery;
    DSClientLookup: TDataSource;
    cboCustomerJob: TwwDBLookupCombo;
    qryMainStatementDesc: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainPayee: TWideStringField;
    qryMainid: TIntegerField;
    qryMainglobalref: TWideStringField;
    qryMainmstimestamp: TDateTimeField;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdMainKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdMainKeyPress(Sender: TObject; var Key: Char);
    procedure cmdNewClick(Sender: TObject);
    procedure qryMainNewRecord(DataSet: TDataSet);
    procedure btnGridClick(Sender: TObject);
  private

    { Private declarations }
  protected
    procedure RefreshQuery; override;
    procedure SetGridColumns; override;
  public
    { Public declarations }
  end;

implementation

uses ReconciliationForm, CommonLib, Forms, DateUtils, AppEnvironment,
  CommonFormLib, BusobjReconciliation;

{$R *.dfm}

procedure TReconRulesListFormGUI.grdMainKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//

end;

procedure TReconRulesListFormGUI.grdMainKeyPress(Sender: TObject;
  var Key: Char);
begin
//

end;

procedure TReconRulesListFormGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin
        GroupFilterString := 'Active = ' + QuotedStr('T');
      end;
    1:
      begin
        GroupFilterString := 'Active <> ' + QuotedStr('T');
      end;
  end;
  inherited;
end;

procedure TReconRulesListFormGUI.qryMainNewRecord(DataSet: TDataSet);
begin
  inherited;
  qryMain.FieldByName('Active').AsString := 'T';
end;

procedure TReconRulesListFormGUI.RefreshQuery;
begin
  inherited;
end;

procedure TReconRulesListFormGUI.SetGridColumns;
begin
  inherited;
end;

procedure TReconRulesListFormGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TReconRulesListFormGUI.btnGridClick(Sender: TObject);
begin
  inherited;
  if qryMain.recordCount = 0 then exit;
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      qryMain.Delete;
    except
      {Do nothing - raise a silent exception}
    end;
  end;
end;

procedure TReconRulesListFormGUI.cmdExportClick(Sender: TObject);
begin
  if qryMain.FieldByName('StatementDesc').AsString = '' then begin
     CommonLib.MessageDlgXP_Vista('Statement Description cannot be empty.', mtInformation, [mbOK], 0);
     exit;
  end;
  if qryMain.FieldByName('Payee').AsString = '' then begin
     CommonLib.MessageDlgXP_Vista('Payee cannot be empty.', mtInformation, [mbOK], 0);
     exit;
  end;
  if qryMain.State in [dsEdit, dsInsert] then qryMain.Post;
  Close;
end;

procedure TReconRulesListFormGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  qryMain.Append;
end;

procedure TReconRulesListFormGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TReconRulesListFormGUI.FormShow(Sender: TObject);
begin
  //AllowCustomiseGrid         := true;
  inherited;
  //GuiPrefs.Elements.Add('TwwDbGridGuiElement', grdMain);
  grdMain.KeyOptions := [dgAllowDelete, dgAllowInsert];
  grdMain.Options := [dgEditing,dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgTabs,dgConfirmDelete,dgCancelOnExit,dgWordWrap,dgPerfectRowFit,dgRowResize];
  //fbTabSettingEnabled        := False;
  cmdExport.Caption := 'Save';
  cboClientLookup.Active := True;
  qryMain.Active    := True;

end;

initialization
  RegisterClassOnce(TReconRulesListFormGUI);
end.
