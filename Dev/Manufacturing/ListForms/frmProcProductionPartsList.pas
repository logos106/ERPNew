unit frmProcProductionPartsList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton, DAScript,
  MyScript, CustomInputBox, wwcheckbox;

type
  TfmProcProductionPartsList = class(TBaseListingGUI)
    actCreateSmartOrder: TAction;
    actCreatePickingList: TAction;
    btnPickingSlip: TDNMSpeedButton;
    btnSmartOrder: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure actCreateSmartOrderExecute(Sender: TObject);
    procedure actCreatePickingListExecute(Sender: TObject);
  private
    TempTableName: string;
    procedure MakeQrymain;
    function CreateSmartOrder: integer;
  protected
    procedure RefreshQuery; override;
  public
    procedure UpdateMe; override;
  end;

var
  fmProcProductionPartsList: TfmProcProductionPartsList;

implementation

{$R *.dfm}

uses
  ProcessDataUtils, CommonLib, CommonDbLib, FastFuncs, BusObjSmartOrder,
  BusObjBase, BaseInputForm, frmProcCapacityPlanningPick;


{ TfmProcProductionPartsList }

procedure TfmProcProductionPartsList.RefreshQuery;
begin
  inherited;
end;

procedure TfmProcProductionPartsList.FormCreate(Sender: TObject);
begin
  TempTableName:= GetUserTemporaryTableName('ProcessPartList');
  MakeQrymain;
  inherited;
  dtFrom.Date:= now;
  dtTo.Date:= now;
end;

procedure TfmProcProductionPartsList.FormShow(Sender: TObject);
begin
  ProcessDataUtils.BuildProductionRequirementsList(TempTableName);
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('ProdSaleId,TreeProductId,LineProductId');
end;

procedure TfmProcProductionPartsList.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(TempTableName);
  inherited;
end;

procedure TfmProcProductionPartsList.MakeQrymain;
begin
  closedb(qryMain);
  qryMain.SQL.Clear;
  qryMain.SQL.Add('SELECT');
  qryMain.SQL.Add('SaleId           as ProdSaleId, ');
  qryMain.SQL.Add('ProcItemPartsId  as TreeProductId, ');
  qryMain.SQL.Add('LineProductId    as LineProductId, ');
  qryMain.SQL.Add('ProcItem         as PartName, ');
  qryMain.SQL.Add('ProcItemDescription as PartDescription,');
  qryMain.SQL.Add('ProjectedQty     as ProjectedQty, ');
  qryMain.SQL.Add('ProcItemPartLeadTime as LeadTime,');
  qryMain.SQL.Add('LastOrderDate    as CriticalOrderDate,');
  qryMain.SQL.Add('ProcItemTotalQty as TotalQty,');
  qryMain.SQL.Add('ProcItemPartUom  as Uom, ');
  qryMain.SQL.Add('ProcItemPartsId  as PartsId,');
  qryMain.SQL.Add('StepTimeStart    as ProcessStart, ');
  qryMain.SQL.Add('StepDescription  as Process, ');
  qryMain.SQL.Add('StepStatus       as ProcessStatus,');
  qryMain.SQL.Add('LineProductName  as LineProductName, ');
  qryMain.SQL.Add('LineProductDescription as LineProductDescription, ');
  qryMain.SQL.Add('LineQuantity     as LineQuantity, ');
  qryMain.SQL.Add('LineShipDate     as LineShipDate,');
  qryMain.SQL.Add('SaleDocNumber    as SaleDocNumber, ');
  qryMain.SQL.Add('CustomerName     as CustomerName, ');
  qryMain.SQL.Add('SaleShipDate     as SaleShipDate');
  qryMain.SQL.Add('FROM ' + TempTableName);
  qryMain.SQL.Add('WHERE ProcItemPartsId > 0 AND ProcItemRoot = "F"');
  qryMain.SQL.Add('AND ProcItemPartType = "INV"');
end;

procedure TfmProcProductionPartsList.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin
      end;
    1:
      begin
        GroupFilterString := 'ProcessStart > 0';
      end;
    2:
      begin
      end;
  end;

  inherited;
end;

procedure TfmProcProductionPartsList.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if ((qryMain.FieldByName('CriticalOrderDate').AsDateTime > 0) and
      (qryMain.FieldByName('ProjectedQty').AsFloat < 0)) then
    AFont.Color:= clRed;
end;

procedure TfmProcProductionPartsList.actCreateSmartOrderExecute(
  Sender: TObject);
var
  SmartOrderId: integer;
  Form: TBaseInputGUI;
begin
    inherited;
    if grdMain.SelectedList.Count > 0 then begin
        SmartOrderId:= CreateSmartOrder;
        if SmartOrderId > 0 then begin
            Form := TBaseInputGUI(GetComponentByClassName('TSmartOrderGUI'));
            if Assigned(Form) then begin
                Form.KeyID := SmartOrderID;
                Form.FormStyle := fsMDIChild;
                Form.BringToFront;
            end;
            grdMain.SelectedList.Clear;
            RefreshQuery;
        end;
    end
    else begin
      CommonLib.MessageDlgXP_Vista('No lines selected',mtInformation,[mbOk],0);
    end;
end;

procedure TfmProcProductionPartsList.actCreatePickingListExecute(
  Sender: TObject);
var
  form: TfmProcCapacityPlanningPick;
begin
  inherited;
  form:= TfmProcCapacityPlanningPick.Create(nil);
  try
    form.DateFrom:= self.dtFrom.DateTime;
    form.DateTo:= self.dtTo.DateTime;
    form.SelectAllProcessSteps;

    form.ShowModal;
  finally
    form.Release;
  end;
end;

function TfmProcProductionPartsList.CreateSmartOrder: integer;
var
  x: integer;
  SmartOrd: TSmartOrder;
begin
  result:= 0;
  if grdMain.SelectedList.Count > 0 then begin
    grdMain.DataSource.DataSet.DisableControls;
    SmartOrd:= TSmartOrder.Create(nil);
    try
      SmartOrd.Connection           := TMyDacDataConnection.Create(SmartOrd);
      SmartOrd.Connection.Connection:= CommonDbLib.GetNewMyDacConnection(SmartOrd);
      SmartOrd.Connection.BeginTransaction;
      SmartOrd.Load(0);
      SmartOrd.New;
      SmartOrd.SmartOrderDesc:= 'Production Requirements';
      SmartOrd.PostDb;
      for x:= 0 to grdMain.SelectedList.Count -1 do begin
        grdMain.DataSource.DataSet.GotoBookmark(grdMain.SelectedList[x]);
        SmartOrd.Lines.New;
        SmartOrd.Lines.PARTSID      := grdMain.DataSource.DataSet.FieldByName('PartsId').AsInteger;
        SmartOrd.Lines.ToPurchaseQtyexWastagePercentage(*ToPurchaseQty*):= grdMain.DataSource.DataSet.FieldByName('TotalQty').AsFloat;
        SmartOrd.Lines.CusJobName   := grdMain.DataSource.DataSet.FieldByName('CustomerName').AsString;
        SmartOrd.Lines.PostDb;
      end;
      if SmartOrd.ValidateData and SmartOrd.Save then begin
        result:= SmartOrd.Id;
        SmartOrd.Connection.CommitTransaction;
      end;
    finally
      SmartOrd.Connection.RollbackTransaction;
      freeandnil(SmartOrd);
      grdMain.DataSource.DataSet.EnableControls;
    end;
  end;
end;

procedure TfmProcProductionPartsList.UpdateMe;
begin
  { stoppped inherited so closing parts form does not cause list refresh }
//  inherited;

end;

initialization
  RegisterClassOnce(TfmProcProductionPartsList);


end.
