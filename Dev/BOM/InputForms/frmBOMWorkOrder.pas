unit frmBOMWorkOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase ,BusobjBOMWorkOrders, Grids, Wwdbigrd, Wwdbgrid;

type
  TfmBOMWorkOrder = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    pnlTop: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    pnlBottom: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    dsBOMWorkOrder: TDataSource;
    dsBOMWorkOrderLines: TDataSource;
    qryBOMWorkOrderLines: TERPQuery;
    qryBOMWorkOrder: TERPQuery;
    grdBOMWorkOrder: TwwDBGrid;
    qryEmployees: TERPQuery;
    qryEmployeesEmployeeId: TIntegerField;
    qryEmployeesemployeeName: TWideStringField;
    qryBOMWorkOrderLinesID: TIntegerField;
    qryBOMWorkOrderLinesGlobalRef: TWideStringField;
    qryBOMWorkOrderLinesBOMWorkOrderID: TIntegerField;
    qryBOMWorkOrderLinesEmployeeId: TIntegerField;
    qryBOMWorkOrderLinesDuration: TIntegerField;
    qryBOMWorkOrderLinesmstimeStamp: TDateTimeField;
    qryBOMWorkOrderLinesmsUpdatesitecode: TWideStringField;
    qryBOMWorkOrderID: TIntegerField;
    qryBOMWorkOrderGlobalRef: TWideStringField;
    qryBOMWorkOrderEmployeeId: TIntegerField;
    qryBOMWorkOrdermstimeStamp: TDateTimeField;
    qryBOMWorkOrdermsUpdatesitecode: TWideStringField;
    qryBOMWorkOrderLinesEmployeeName: TStringField;
    qryBOMWorkOrderLinesProcessStepID: TIntegerField;
    qryBOMWorkOrderLinesProctreeID: TIntegerField;
    qryBOMWorkOrderLinesProcessPartID: TIntegerField;
    qryprocessstep: TERPQuery;
    qryprocessstepID: TIntegerField;
    qryprocessstepDescription: TWideStringField;
    qryBOMWorkOrderLinesProcessStep: TStringField;
    QryProctree: TERPQuery;
    QryProctreeProctreeId: TIntegerField;
    QryProctreeCaption: TWideStringField;
    QryProctreeParentId: TIntegerField;
    QryProctreeTree: TWideMemoField;
    qryBOMWorkOrderLinesProctreeCaption: TStringField;
    qryBOMWorkOrderLinesProctreeTree: TStringField;
    qryBOMWorkOrderCreatedOn: TDateTimeField;
    qryBOMWorkOrderLinesScheduledFrom: TDateTimeField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    BOMWorkOrder: TBOMWorkOrder;
    function SaveRecord: Boolean;
  public
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    Procedure Allocate(PPID, PSID, PTID, employeeId :Integer; aDate:TDate; aDuration:Integer);
  end;


implementation

uses CommonLib, BusObjConst;

{$R *.dfm}

procedure TfmBOMWorkOrder.Allocate(PPID, PSID, PTID, employeeId: Integer; aDate:TDate; aDuration:Integer);
begin
  if BOMWorkOrder.Count =0 then begin
    BOMWorkOrder.New;
    BOMWorkOrder.PostDB;
  end;
  BOMWorkOrder.Lines.ProcessStepID  := PSID;
  BOMWorkOrder.Lines.ProctreeID     := PTID;
  BOMWorkOrder.Lines.ProcessPartID  := PPID;
  BOMWorkOrder.Lines.EmployeeId     := employeeId;
  BOMWorkOrder.Lines.ScheduledFrom  := aDate;
  BOMWorkOrder.Lines.Duration       := aDuration;

end;

procedure TfmBOMWorkOrder.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

Function TfmBOMWorkOrder.SaveRecord :Boolean;
begin
  result:= False;
  BOMWorkOrder.PostDB;
  if not(BOMWorkOrder.Save) then exit;
  Result:= True;

end;

procedure TfmBOMWorkOrder.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  BOMWorkOrder.Connection.CommitTransaction;
  Self.Close;

end;

procedure TfmBOMWorkOrder.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
      inherited;
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
             if Sender is TBOMWorkOrder       then TBOMWorkOrder(Sender).Dataset  := qryBOMWorkOrder
        else if Sender is TBOMWorkOrderLines  then TBOMWorkOrder(Sender).Dataset  := qryBOMWorkOrderLines;
     end;
end;

procedure TfmBOMWorkOrder.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if BOMWorkOrder.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveRecord then begin
            CommitAndNotify;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          BOMWorkOrder.Dirty := false;
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

procedure TfmBOMWorkOrder.FormCreate(Sender: TObject);
begin
  inherited;
  BOMWorkOrder := TBOMWorkOrder.CreateWithNewConn(Self);
  BOMWorkOrder.Connection.connection := Self.MyConnection;
  BOMWorkOrder.BusObjEvent := DoBusinessObjectEvent;
end;
procedure TfmBOMWorkOrder.FormShow(Sender: TObject);
begin
  inherited;
  BOMWorkOrder.Load(KeyID);
  BOMWorkOrder.connection.BeginTransaction;
  if BOMWorkOrder.count=0 then BOMWorkOrder.new;
  openQueries;
end;

initialization
  RegisterClassOnce(TfmBOMWorkOrder);

end.

