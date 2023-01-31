unit frmSalesAnalysisManual;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, ExtCtrls, StdCtrls, Shader, DNMPanel, DNMSpeedButton,
  wwdbdatetimepicker , BusobjSalesAnalysisManual ,BusObjBase, wwdblook, DBCtrls, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwcheckbox, Mask, wwdbedit;

type
  TfmSalesAnalysisManual = class(TBaseInputGUI)
    pnltop: TDNMPanel;
    pnlMain: TDNMPanel;
    pnlbottom: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnNext: TDNMSpeedButton;
    btnCompleted: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    btnPreview: TDNMSpeedButton;
    btnPrint: TDNMSpeedButton;
    pnlheader: TDNMPanel;
    tblMaster: TERPQuery;
    DSMaster: TDataSource;
    DSDetails: TDataSource;
    tblDetails: TERPQuery;
    tblDetailsID: TIntegerField;
    tblDetailsGlobalref: TWideStringField;
    tblDetailsSalesAnalysisID: TIntegerField;
    tblDetailsEmployeeId: TIntegerField;
    tblDetailsEmployeeName: TWideStringField;
    tblDetailsColdCalls: TIntegerField;
    tblDetailsContact: TIntegerField;
    tblDetailsFirstDemo: TIntegerField;
    tblDetailsSecondDemo: TIntegerField;
    tblDetailsQuotes: TIntegerField;
    tblDetailsSalesOrders: TIntegerField;
    tblDetailsSales: TIntegerField;
    tblDetailsmsTimeStamp: TDateTimeField;
    tblDetailsmsUpdateSiteCode: TWideStringField;
    SaleDate_Label: TLabel;
    dtDateofReport: TwwDBDateTimePicker;
    dtDateFrom: TwwDBDateTimePicker;
    Label1: TLabel;
    dtDateTo: TwwDBDateTimePicker;
    Label2: TLabel;
    QryEmployee: TERPQuery;
    Label3: TLabel;
    cboEmployee: TwwDBLookupCombo;
    QryEmployeeemployeeId: TIntegerField;
    QryEmployeeEmployeename: TWideStringField;
    QryEmployeeactive: TWideStringField;
    Label4: TLabel;
    txtComments: TDBMemo;
    QryReportingemployee: TERPQuery;
    cboreportingEmployee: TwwDBLookupCombo;
    tblDetailsDeleted: TWideStringField;
    Label5: TLabel;
    chkActive: TwwCheckBox;
    pnlChooseRpt: TDNMPanel;
    lblChooseRpt: TLabel;
    chkChooseRpt: TCheckBox;
    lblTmr: TLabel;
    tblMasterID: TIntegerField;
    tblMasterGlobalref: TWideStringField;
    tblMasterDateofReport: TDateField;
    tblMasterDateFrom: TDateField;
    tblMasterDateTo: TDateField;
    tblMasterCreatedby: TIntegerField;
    tblMasterCreatedOn: TDateField;
    tblMastercomments: TWideMemoField;
    tblMastermsTimeStamp: TDateTimeField;
    tblMastermsUpdatesiteCode: TWideStringField;
    tblMasterActive: TWideStringField;
    tblMasterCreatedByEmployee: TStringField;
    QryReportingemployeeemployeeId: TIntegerField;
    QryReportingemployeeEmployeename: TWideStringField;
    QryReportingemployeeactive: TWideStringField;
    tblMasterGooglevisitcount: TIntegerField;
    Label6: TLabel;
    wwDBEdit1: TwwDBEdit;
    tblDetailsBudgetIncome: TFloatField;
    tblDetailsBudgetcost: TFloatField;
    grdTransactions: TwwDBGrid;
    btnDelete: TwwIButton;
    tblDetailscomments: TWideMemoField;
    edtcomments: TwwDBEdit;
    tblDetailsRatio: TFloatField;
    tblDetailsCOS: TFloatField;
    qryMedia: TERPQuery;
    qryMediaMediaType: TWideStringField;
    tblDetailsSource: TWideStringField;
    cboSource: TwwDBLookupCombo;
    procedure QryEmployeeBeforeOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnPrintClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdTransactionsEnter(Sender: TObject);
    procedure cboreportingEmployeeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure qryMediaBeforeOpen(DataSet: TDataSet);
    procedure cboSourceDropDown(Sender: TObject);
  private
    Reporting : TSalesAnalysisManual;
  Protected
    function GetReportTypeID: integer; Override;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib  , BusObjConst, AppEnvironment, FormFactory, tcDataUtils;

{$R *.dfm}
procedure TfmSalesAnalysisManual.btnCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfmSalesAnalysisManual.btnCompletedClick(Sender: TObject);
begin
  inherited;
  if not(Reporting.Save) then exit;
  Reporting.connection.CommitTransaction;
  Reporting.Dirty := False;
  Self.Close;
end;

procedure TfmSalesAnalysisManual.btnDeleteClick(Sender: TObject);
begin
  inherited;
  Reporting.Lines.PostDB;
  if Reporting.Lines.count > 0 then begin
    Reporting.Lines.Deleted:= True;
    Reporting.Lines.PostDB;
  end;
end;

procedure TfmSalesAnalysisManual.btnNextClick(Sender: TObject);
begin
  inherited;
  if not(Reporting.Save) then exit;
  Reporting.Connection.CommitTransaction;
  Reporting.dirty := False;
  Reporting.Connection.BeginTransaction;
  Reporting.New;
  Reporting.Lines;
  Setcontrolfocus(dtDateofReport);
end;

procedure TfmSalesAnalysisManual.btnPreviewClick(Sender: TObject);
begin
  inherited;
  {disabled as the template is not created }
  if not(Reporting.Save) then exit;
  Reporting.Connection.CommitTransaction;
  Reporting.dirty := False;
  ReportToPrint:= '';
  if chkChooseRpt.Checked then begin
    LoadReportTypes;
    if dlgReportSelect.Execute then begin
      ReportToPrint := dlgReportSelect.SelectedItems.Text;
    end;
  end;
  if ReportToPrint = '' then ReportToPrint := tcdatautils.GetDefaultReport(GetReportTypeID);
  PrintTemplateReport(ReportToPrint , '~|||~R.Id = ' +inttostr(reporting.ID), (*not(Appenv.Employee.ShowPreview) and not(Devmode)*)False , 1);
  Self.Close;
end;

procedure TfmSalesAnalysisManual.btnPrintClick(Sender: TObject);
begin
  inherited;
  if not(Reporting.Save) then exit;
  Reporting.Connection.CommitTransaction;
  Reporting.dirty := False;
  ReportToPrint:= '';
  if chkChooseRpt.Checked then begin
    LoadReportTypes;
    if dlgReportSelect.Execute then begin
      ReportToPrint := dlgReportSelect.SelectedItems.Text;
    end;
  end;
  if ReportToPrint = '' then ReportToPrint := tcdatautils.GetDefaultReport(GetReportTypeID);
  PrintTemplateReport(ReportToPrint , '~|||~R.Id = ' +inttostr(reporting.ID), (*not(Appenv.Employee.ShowPreview) and not(Devmode)*)False , 1);
  Self.Close;

end;

procedure TfmSalesAnalysisManual.cboreportingEmployeeCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  Reporting.Lines.EmployeeId    := QryReportingemployeeemployeeId.AsInteger;
  Reporting.Lines.EmployeeName  := QryReportingemployeeEmployeename.AsString;
end;

procedure TfmSalesAnalysisManual.cboSourceDropDown(Sender: TObject);
begin
  inherited;
//
end;

procedure TfmSalesAnalysisManual.DoBusinessObjectEvent(const Sender: TDatasetBusObj;  const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
             if Sender is TSalesAnalysisManual      then TSalesAnalysisManual(Sender).Dataset       := tblmaster
        else if Sender is TSalesAnalysisManualLines then TSalesAnalysisManualLines(Sender).Dataset  := tbldetails;
  end;
end;

procedure TfmSalesAnalysisManual.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TfmSalesAnalysisManual.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ErrorOccurred then Exit;

  CanClose := false;
  if Reporting.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if Reporting.Save then begin
            Reporting.Connection.CommitTransaction;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          Reporting.Connection.RollbackTransaction;
          Reporting.Dirty := false;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
          btnClose.Enabled := True;
        end;
    end;
  end else begin
    CanClose := true;
    Notify(false);
  end;
end;

procedure TfmSalesAnalysisManual.FormCreate(Sender: TObject);
begin
  AllowCustomiseGrid := True;
  inherited;
  fbTabSettingEnabled := False;
  Reporting := TSalesAnalysisManual.Create(Self);
  Reporting.Connection := TMyDacDataConnection.Create(Reporting);
  Reporting.Connection.Connection := MyConnection;
  Reporting.BusObjEvent := DoBusinessObjectEvent;
end;

procedure TfmSalesAnalysisManual.FormShow(Sender: TObject);
begin
  inherited;
  Reporting.Load(KeyID);
  Reporting.Connection.BeginTransaction;
  if Reporting.count =0  then Reporting.New;
  Reporting.Lines;
  OpenQueries;

end;

function TfmSalesAnalysisManual.GetReportTypeID: integer;
begin
  Result:= 110;
end;

procedure TfmSalesAnalysisManual.grdTransactionsEnter(Sender: TObject);
begin
  inherited;
  Reporting.PostDb;
  if Reporting.count =0  then begin
    MessageDlgXP_Vista('Please provide the details for the header before selecting the employees', mtWarning, [mbOK], 0);
    Setcontrolfocus(dtDateofReport);
    Exit;
  end;
end;

procedure TfmSalesAnalysisManual.QryEmployeeBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  QryEmployee.ParamByName('EmployeeId').AsInteger := Reporting.Createdby;
end;

procedure TfmSalesAnalysisManual.qryMediaBeforeOpen(DataSet: TDataSet);
begin
  inherited;
//  qryMedia.ParamByName('MedTypeId').AsInteger := tblDetailsMedTypeId.AsInteger;
end;

initialization
  RegisterClassOnce(TfmSalesAnalysisManual);
  with FormFact do begin
        RegisterMe(TfmSalesAnalysisManual, 'TSalesAnalysisManualGUI_*=Id');
  end;
end.

