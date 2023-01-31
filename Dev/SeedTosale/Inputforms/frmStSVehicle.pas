unit frmStSVehicle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmStSInputBase, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, Shader, DNMSpeedButton, DNMPanel, StdCtrls, Mask,
  DBCtrls, BusObjBase, BusObjSeedToSale;

type
  TfmStsVehicle = class(TfmStSInputBase)
    lbManufacture: TLabel;
    lb1: TLabel;
    lb2: TLabel;
    dbedtManufacture: TDBEdit;
    dbedtModel: TDBEdit;
    dbedtPlateNum: TDBEdit;
    dsVehicle: TDataSource;
    qryVehicle: TERPQuery;
    qryVehicleAssetID: TIntegerField;
    qryVehicleManufacture: TWideStringField;
    qryVehicleModel: TWideStringField;
    qryVehicleSerial: TWideStringField;
    qryVehiclePartName: TWideStringField;
    dbedtPartName: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
  private
    FVehicle: TStSVehicle;
  protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string); override;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses
  BusObjConst;

{ TfmStsVehicle }

procedure TfmStsVehicle.btnCompletedClick(Sender: TObject);
begin
  inherited;

  if not FVehicle.Save then Exit;

  FVehicle.Connection.CommitTransaction;
  ModalResult := mrOK;
end;

procedure TfmStsVehicle.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;

  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
      if Sender is TStSVehicle then TStSVehicle(Sender).Dataset:= qryVehicle;
  end;
end;

procedure TfmStsVehicle.FormCreate(Sender: TObject);
begin
  inherited;
  FormColor := $0091C8FF;
  FVehicle := TStSVehicle.Create(Self);
  FVehicle.connection := TMyDacDataConnection.create(FVehicle);
  FVehicle.connection.Connection := Self.MyConnection;
  FVehicle.BusObjEvent := DoBusinessObjectEvent;
end;

procedure TfmStsVehicle.FormShow(Sender: TObject);
begin
  inherited;

  with TitleShader do begin
    FromColor       := clWhite;
    FromColorMirror := clWhite;
    ToColor         := clWhite;
    ToColorMirror   := clWhite;
  end;

  FVehicle.Load(KeyID);
  FVehicle.Connection.BeginTransaction;

  if KeyId = 0 then FVehicle.New;

  OpenQueries;
end;

end.
