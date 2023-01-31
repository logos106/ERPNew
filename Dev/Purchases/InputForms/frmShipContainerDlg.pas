unit frmShipContainerDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DB, DBAccess,
  MyAccess, SelectionDialog, AppEvnts, ExtCtrls, DNMSpeedButton, DNMPanel,
  ActnList, StdCtrls, wwdblook, MemDS,BusObjShippingContainer, Shader,
  Mask, wwdbedit, Wwdotdot, Wwdbcomb;

type
  TfrmShipContainerDialog = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    qryShipContainer: TMyQuery;
    qryShipContainerContainerName: TStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cboShipContainer: TwwDBComboBox;
    procedure actCancelExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure cboShipContainerCloseUp(Sender: TwwDBComboBox;
      Select: Boolean);
    procedure FormDestroy(Sender: TObject);
  private
    fAssignedShipContainerID:integer;
    fPurchaseLineID:integer;
    fExistingAssignment:string;
    ShipContainer:TShippingContainer;
    fconnection: TMyconnection;
    function SaveData: boolean;
  public
    Property PurchaseLineID :integer read fPurchaseLineID write fPurchaseLineID;
    property ExistingAssignment :String read fExistingAssignment write fExistingAssignment;
    property Connection :TMyConnection Read fconnection write fconnection;
  end;

function ShipContainerModified(iPurchaseLineID: Integer;sExistingContainerName:String;cConnection:TMyConnection): boolean;

implementation

{$R *.dfm}
uses
  CommonLib,tcDataUtils,BusObjBase ;


function ShipContainerModified(iPurchaseLineID: Integer;sExistingContainerName:String;cConnection:TMyConnection): boolean;
var
  form: TfrmShipContainerDialog;
begin
  result:= false;
  form:= TfrmShipContainerDialog.Create(nil);
  try    
    form.PurchaseLineID         := iPurchaseLineID;
    form.ExistingAssignment     := sExistingContainerName;
    form.Connection             := cConnection;
    if form.ShowModal = mrOk then begin
      result                    := true;
    end;
  finally
    form.Release;
  end;
end;

procedure TfrmShipContainerDialog.actCancelExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmShipContainerDialog.FormShow(Sender: TObject);
begin
  inherited;
  ShipContainer:= TShippingContainer.Create(self);
  ShipContainer.Connection := TMyDacDataConnection.Create(ShipContainer);
  ShipContainer.Connection.MyDacConnection := Connection;
  qryShipContainer.Open;
  qryShipContainer.First;
  while not qryShipContainer.Eof do begin
    cboShipContainer.Items.Add(qryShipContainer.FieldByName('ContainerName').AsString);
    qryShipContainer.Next;
  end;

  if ExistingAssignment <> '' then begin
    fAssignedShipContainerID := tcDataUtils.getShipContainerID(ExistingAssignment);
    ShipContainer.Load(fAssignedShipContainerID);
    ShipContainer.ContainerDetails;
  end;  
end;

function TfrmShipContainerDialog.SaveData: boolean;
begin
  result:= true;
  if ShipContainer.Dirty then begin
    if not ShipContainer.Save then
      result:= false;
  end;
end;


procedure TfrmShipContainerDialog.actSaveExecute(Sender: TObject);
begin
  inherited;
  if not SaveData then begin
  //  HandleContainerErrors;
    Exit;
  end;
  Close;
end;

procedure TfrmShipContainerDialog.cboShipContainerCloseUp(
  Sender: TwwDBComboBox; Select: Boolean);
begin
  inherited;
  if cboShipContainer.Text = Self.ExistingAssignment then exit;
  {if existing assignment delete }
  if fAssignedShipContainerID <> 0 then begin
    ShipContainer.Load(fAssignedShipContainerID);
    ShipContainer.ContainerDetails;
    ShipContainer.ContainerDetails.Dataset.Locate('PurchaseLineID',PurchaseLineID,[loCaseInsensitive]);
    ShipContainer.ContainerDetails.Delete;
    ShipContainer.Save;
  end;
  {add new assignment }
  fAssignedShipContainerID := tcDataUtils.getShipContainerID(cboShipContainer.Text);
  ShipContainer.Load(fAssignedShipContainerID);
  ShipContainer.ContainerDetails;

  ShipContainer.ContainerDetails.New;
  ShipContainer.ContainerDetails.PurchaseLineID := PurchaseLineID;
  ShipContainer.Save;
end;

procedure TfrmShipContainerDialog.FormDestroy(Sender: TObject);
begin
  FreeAndNil(ShipContainer);
  inherited;

end;

initialization
  RegisterClassOnce(TfrmShipContainerDialog);
end.
