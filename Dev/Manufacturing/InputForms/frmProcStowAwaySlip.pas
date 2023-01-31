unit frmProcStowAwaySlip;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DB, DBAccess,
  MyAccess, SelectionDialog, AppEvnts, ExtCtrls, StdCtrls, Mask, wwdbedit,
  MemDS, Grids, Wwdbigrd, Wwdbgrid, Shader, ActnList, DNMSpeedButton,
  DNMPanel, BusObjProcPickSlip, wwcheckbox, BusObjBase;

type
  TfmProcStowAwaySlip = class(TBaseInputGUI)
    pnlBottom: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    ActionList: TActionList;
    actOk: TAction;
    actCancel: TAction;
    pnlTop: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Grid: TwwDBGrid;
    qryPickSlip: TMyQuery;
    qryPickSlipLines: TMyQuery;
    dsPickSlip: TDataSource;
    dsPickSlipLines: TDataSource;
    edtDate: TwwDBEdit;
    Label2: TLabel;
    Label1: TLabel;
    edtDescription: TwwDBEdit;
    qryPickSlipLinesProcPickSlipLineId: TIntegerField;
    qryPickSlipLinesProcPickSlipId: TIntegerField;
    qryPickSlipLinesProcTreeId: TIntegerField;
    qryPickSlipLinesSaleId: TIntegerField;
    qryPickSlipLinesSaleDocNumber: TStringField;
    qryPickSlipLinesSaleCustomerName: TStringField;
    qryPickSlipLinesSaleLineId: TIntegerField;
    qryPickSlipLinesSaleLineProductName: TStringField;
    qryPickSlipLinesSaleLineProductDescription: TStringField;
    qryPickSlipLinesSaleLineQuantity: TFloatField;
    qryPickSlipLinesStepDescription: TStringField;
    qryPickSlipLinesItemRoot: TStringField;
    qryPickSlipLinesItemCaption: TStringField;
    qryPickSlipLinesItemDescription: TStringField;
    qryPickSlipLinesItemTotalQty: TFloatField;
    qryPickSlipLinesItemTotalQtyOriginal: TFloatField;
    qryPickSlipLinesItemTotalQtyUsed: TFloatField;
    qryPickSlipLinesItemPartId: TIntegerField;
    qryPickSlipLinesItemPartUom: TStringField;
    Label3: TLabel;
    wwDBEdit1: TwwDBEdit;
    chkPicked: TwwCheckBox;
    btnPickAll: TDNMSpeedButton;
    actPickAll: TAction;
    actPrint: TAction;
    btnPrint: TDNMSpeedButton;
    chkPreview: TwwCheckBox;
    qryPickSlipLinesSaleShipDate: TDateField;
    qryPickSlipLinesSaleLineShipDate: TDateField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actOkExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure chkPickedClick(Sender: TObject);
    procedure GridFieldChanged(Sender: TObject; Field: TField);
    procedure actPickAllExecute(Sender: TObject);
    procedure ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure actPrintExecute(Sender: TObject);
  private
    StowSlip: TProcStowAwaySlip;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string); //virtual;
  public
    { Public declarations }
  end;

var
  fmProcPickingSlip: TfmProcStowAwaySlip;

implementation

{$R *.dfm}

uses
  DNMExceptions, FormFactory, CommonLib, (*frmBins_Batches,*)
  FastFuncs, BusObjConst(*, SerialNoObj*);


procedure TfmProcStowAwaySlip.FormCreate(Sender: TObject);
begin
  Self.fbIgnoreAccessLevels := true;
  inherited;
  StowSlip:= TProcStowAwaySlip.Create(self);
  StowSlip.Connection := TMyDacDataConnection.Create(StowSlip);
  StowSlip.Connection.MyDacConnection := MyConnection;
  StowSlip.BusObjEvent := DoBusinessObjectEvent;
end;

procedure TfmProcStowAwaySlip.FormShow(Sender: TObject);
var x: integer;
begin
  try
    inherited;

    // Roll back any existing transaction
    RollbackTransaction;


    // Put our Database Connection into transaction mode.
    BeginTransaction;


    if KeyID = 0 then begin

    end else begin
      StowSlip.Load(KeyId);
      StowSlip.Lines;
    end;

    for x:= 0 to Grid.GetColCount -1 do begin
      if Grid.Columns[x].FieldName <> 'ItemTotalQtyUsed' then
        Grid.Columns[x].ReadOnly:= true;
    end;


    // Exception Handler
  except
    // Handle these known exceptions.
    on EAbort do HandleEAbortException;
    on e: ENoAccess do HandleNoAccessException(e);
    else raise;
  end;
end;

procedure TfmProcStowAwaySlip.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if StowSlip.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if StowSlip.Save then CommitTransaction
          else CanClose:= false;
        end;
      mrNo:
        begin

        end;
      mrCancel:
        begin
          CanClose:= false;
        end;
    end;
  end;
end;

procedure TfmProcStowAwaySlip.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action:= caFree;
end;

procedure TfmProcStowAwaySlip.actOkExecute(Sender: TObject);
begin
  inherited;
  if StowSlip.Dirty then begin
    if not StowSlip.Save then Exit;
    CommitTransaction;
    Notify;
  end;  
  Close;
end;

procedure TfmProcStowAwaySlip.actCancelExecute(Sender: TObject);
begin
  inherited;
  RollbackTransaction;
  Close;
end;

procedure TfmProcStowAwaySlip.GridDblClick(Sender: TObject);
begin
  inherited;
  {TODO PQA}
 (* if Grid.SelectedField <> Grid.DataSource.DataSet.FieldByName('ItemTotalQtyUsed') then begin
    ClearSNRequest(StowSlip.Lines.ProcTreePart);
    SNRequest.TransId       := StowSlip.Id;
    SNRequest.TransLineId   := StowSlip.Lines.Id;
    SNRequest.client        := 0;
    if (StowSlip.Lines.ProcTreePart.UOMQty   = 0 ) then begin
        SNRequest.Restype       := 'B';
        SNRequest.SelectionMode := tBuilt;
        SNRequest.Assign        := false;
    end else  if (StowSlip.Lines.ProcTreePart.UOMQty  > 0 ) then begin
        SNRequest.Restype       := 'B';
        SNRequest.SelectionMode := tBuilt;
    end;
    DoBinBatchform(StowSlip.Lines.ProcTreePart, SNRequest);
  end;*)
end;

procedure TfmProcStowAwaySlip.chkPickedClick(Sender: TObject);
begin
  inherited;
  if chkPicked.DataSource.DataSet.Active then begin
    if not (chkPicked.DataSource.DataSet.State in [dsEdit, dsInsert]) then
      chkPicked.DataSource.DataSet.Edit;
    if chkPicked.Checked then
      StowSlip.Picked:= true
    else
      StowSlip.Picked:= false;
  end;
end;

procedure TfmProcStowAwaySlip.GridFieldChanged(Sender: TObject;
  Field: TField);
begin
  inherited;
  {TODO PQA}
  (*ClearSNRequest(StowSlip.Lines.ProcTreePart);
  SNRequest.TransId       := StowSlip.Id;
  SNRequest.TransLineId   := StowSlip.Lines.Id;
  SNRequest.client        := 0;
  if (StowSlip.Lines.ProcTreePart.UOMQty   = 0 ) then begin
      SNRequest.Restype       := 'B';
      SNRequest.SelectionMode := tBuilt;
      SNRequest.Assign        := false;
  end else  if (StowSlip.Lines.ProcTreePart.UOMQty  > 0 ) then begin
      SNRequest.Restype       := 'B';
      SNRequest.SelectionMode := tBuilt;
  end;
  DoBinBatchform(StowSlip.Lines.ProcTreePart, SNRequest);*)
end;

procedure TfmProcStowAwaySlip.actPickAllExecute(Sender: TObject);
begin
  inherited;

  if CommonLib.MessageDlgXP_Vista('Set stowed quantity on all lines to planned quantity?',
    mtconfirmation , [mbOk, mbCancel] , 0) <> mrOk then
    exit;

  StowSlip.StowAll;
end;

procedure TfmProcStowAwaySlip.ActionListUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  actPickAll.Enabled:= not StowSlip.Picked;
  Grid.ReadOnly:= StowSlip.Picked;
end;

procedure TfmProcStowAwaySlip.actPrintExecute(Sender: TObject);
var
  ReportName, StrWhere: string;
begin
  inherited;
  if StowSlip.Dirty and (not StowSlip.Save) then Exit;
  ReportName := 'Production Stow Away Slip';
  StrWhere :=
    '~|||~AND S.ProcPickSlipId = ' + FastFuncs.IntToStr(StowSlip.Id) +
    ' ORDER BY SL.ItemPartId, SL.StepDescription';
  PrintTemplateReport(ReportName, strWhere, chkPreview.Checked = false, 1);
end;

procedure TfmProcStowAwaySlip.DoBusinessObjectEvent(
  const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TProcStowAwaySlip then TProcStowAwaySlip(Sender).DataSet:= qryPickSlip;
    if Sender is TProcPickSlipLine then TProcPickSlipLine(Sender).DataSet := qryPickSlipLines;
  end;
end;

initialization

  RegisterClassOnce(TfmProcStowAwaySlip);
  with FormFact do begin
    // register all columns on course list form to open this form on DblClick
    RegisterMe(TfmProcStowAwaySlip, 'TfmProcStowAwaySlipList_*=SlipNumber');
  end;

end.
