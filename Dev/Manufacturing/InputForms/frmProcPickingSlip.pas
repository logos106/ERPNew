unit frmProcPickingSlip;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DB, DBAccess,
  MyAccess, SelectionDialog, AppEvnts, ExtCtrls, StdCtrls, Mask, wwdbedit,
  MemDS, Grids, Wwdbigrd, Wwdbgrid, Shader, ActnList, DNMSpeedButton,
  DNMPanel, BusObjProcPickSlip, wwcheckbox, BusObjBase;

type
  TfmProcPickingSlip = class(TBaseInputGUI)
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
    PickSlip: TProcPickSlip;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string); //virtual;
  public
    { Public declarations }
  end;

var
  fmProcPickingSlip: TfmProcPickingSlip;

implementation

{$R *.dfm}

uses
  DNMExceptions, FormFactory, CommonLib, (*frmBins_Batches,*)
  FastFuncs, BusObjConst(*, SerialNoObj*);


procedure TfmProcPickingSlip.FormCreate(Sender: TObject);
begin
  Self.fbIgnoreAccessLevels := true;
  inherited;
  PickSlip:= TProcPickSlip.Create(self);
  PickSlip.Connection := TMyDacDataConnection.Create(PickSlip);
  PickSlip.Connection.MyDacConnection := MyConnection;
//  PickSlip.Dataset:= qryPickSlip;
  PickSlip.BusObjEvent := DoBusinessObjectEvent;
end;

procedure TfmProcPickingSlip.FormShow(Sender: TObject);
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
      PickSlip.Load(KeyId);
//      PickSlip.Lines.Dataset:= qryPickSlipLines;
      PickSlip.Lines;
    end;

    for x:= 0 to Grid.GetColCount -1 do begin
      if Grid.Columns[x].FieldName <> 'ItemTotalQtyUsed' then
        Grid.Columns[x].ReadOnly:= true;
    end;

    //DataState.Activate;

    // Exception Handler
  except
    // Handle these known exceptions.
    on EAbort do HandleEAbortException;
    on e: ENoAccess do HandleNoAccessException(e);
    else raise;
  end;
end;

procedure TfmProcPickingSlip.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if PickSlip.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if PickSlip.Save then CommitTransaction
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

procedure TfmProcPickingSlip.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action:= caFree;
end;

procedure TfmProcPickingSlip.actOkExecute(Sender: TObject);
begin
  inherited;
  if PickSlip.Dirty then begin
    if not PickSlip.Save then Exit;
    CommitTransaction;
    Notify;
  end;  
  Close;
end;

procedure TfmProcPickingSlip.actCancelExecute(Sender: TObject);
begin
  inherited;
  RollbackTransaction;
  Close;
end;

procedure TfmProcPickingSlip.GridDblClick(Sender: TObject);
begin
  inherited;
  {TODO PQA}
  (*if Grid.SelectedField <> Grid.DataSource.DataSet.FieldByName('ItemTotalQtyUsed') then begin
    ClearSNRequest(PickSlip.Lines.ProcTreePart);
    SNRequest.TransId       := PickSlip.Id;
    SNRequest.TransLineId   := PickSlip.Lines.Id;
    SNRequest.client        := 0;
    if (PickSlip.Lines.ProcTreePart.UOMQty   = 0 ) then begin
        SNRequest.Restype       := 'M';
        SNRequest.SelectionMode := tManufacture;
        SNRequest.Assign        := false;
    end else  if (PickSlip.Lines.ProcTreePart.UOMQty  > 0 ) then begin
        SNRequest.Restype       := 'M';
        SNRequest.SelectionMode := tManufacture;
    end;
    DoBinBatchform(PickSlip.Lines.ProcTreePart, SNRequest);
  end*)
end;

procedure TfmProcPickingSlip.chkPickedClick(Sender: TObject);
begin
  inherited;
  if chkPicked.DataSource.DataSet.Active then begin
    if not (chkPicked.DataSource.DataSet.State in [dsEdit, dsInsert]) then
      chkPicked.DataSource.DataSet.Edit;
    if chkPicked.Checked then
      PickSlip.Picked:= true
    else
      PickSlip.Picked:= false;
  end;
end;

procedure TfmProcPickingSlip.GridFieldChanged(Sender: TObject;
  Field: TField);
begin
  inherited;
  {TODO PQA}
    (*ClearSNRequest(PickSlip.Lines.ProcTreePart);
    SNRequest.TransId       := PickSlip.Id;
    SNRequest.TransLineId   := PickSlip.Lines.Id;
    SNRequest.client        := 0;
    if (PickSlip.Lines.ProcTreePart.UOMQty   = 0 ) then begin
        SNRequest.Restype       := 'M';
        SNRequest.SelectionMode := tManufacture;
        SNRequest.Assign        := false;
    end else  if (PickSlip.Lines.ProcTreePart.UOMQty  > 0 ) then begin
        SNRequest.Restype       := 'M';
        SNRequest.SelectionMode := tManufacture;
    end;
  DoBinBatchform(PickSlip.Lines.ProcTreePart, SNRequest);*)
end;

procedure TfmProcPickingSlip.actPickAllExecute(Sender: TObject);
begin
  inherited;

  if CommonLib.MessageDlgXP_Vista('Set issued quantity on all lines to required quantity?',
    mtconfirmation , [mbOk, mbCancel] , 0) <> mrOk then
    exit;

  PickSlip.PickAll;
end;

procedure TfmProcPickingSlip.ActionListUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  actPickAll.Enabled:= not PickSlip.Picked;
  Grid.ReadOnly:= PickSlip.Picked;
end;

procedure TfmProcPickingSlip.actPrintExecute(Sender: TObject);
var
  ReportName, StrWhere: string;
begin
  inherited;
  if PickSlip.Dirty and (not PickSlip.Save) then Exit;
  ReportName := 'Production Picking Slip';
  StrWhere :=
    '~|||~AND PS.ProcPickSlipId = ' + FastFuncs.IntToStr(PickSlip.Id) +
    ' ORDER BY PSL.ItemPartId, PSL.StepDescription';
  PrintTemplateReport(ReportName, strWhere, chkPreview.Checked = false, 1);
end;

procedure TfmProcPickingSlip.DoBusinessObjectEvent(
  const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TProcPickSlip then TProcPickSlip(Sender).DataSet:= qryPickSlip;
    if Sender is TProcPickSlipLine then TProcPickSlipLine(Sender).DataSet := qryPickSlipLines;
  end;
end;

initialization

  RegisterClassOnce(TfmProcPickingSlip);
  with FormFact do begin
    // register all columns on course list form to open this form on DblClick
    RegisterMe(TfmProcPickingSlip, 'TfmProcPickingSlipList_*=SlipNumber');
  end;

end.
