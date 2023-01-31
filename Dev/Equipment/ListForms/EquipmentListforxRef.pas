unit EquipmentListforxRef;

interface

Uses TypesLib,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, EquipmentListForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,
  BusObjClient, BusObjEquipment, busobjbase, DAScript, MyScript, CustomInputBox,
  wwcheckbox;

type
  TEquipmentListforxRefGUI = class(TEquipmentListGUI)
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure cmdNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fRefreshEquipmentLookup :TGeneralProc;
    fEquipmentxRef          :TEquipmentxRef;
    EquipmentIDstoexclude   :String;
    fCustomerEquipment      :TCustomerEquipment;
    ficlientId              :Integer;

  public

   class Procedure EquipmentListForxRef(xClientID:Integer;RefreshEquipmentLookup:TGeneralProc; EquipmentxRef:TEquipmentxRef);
   Procedure  RefreshQuery; override;
   property   clientID  :Integer read ficlientId write ficlientId;
   Procedure  getEquipmentIDstoexclude(const Sender: TBusObj;var Abort: boolean);

  end;


implementation

uses
  CommonLib, tcConst, FastFuncs, CommonDbLib, AppEnvironment;

{$R *.dfm}

{ TEquipmentListGUI1 }

class procedure TEquipmentListforxRefGUI.EquipmentListForxRef(xClientID: Integer;
  RefreshEquipmentLookup: TGeneralProc; EquipmentxRef: TEquipmentxRef);
var
  List:TComponent;
begin
  List := GetComponentByClassName('TEquipmentListforxRefGUI');
  if assigned(List) then
    With TEquipmentListforxRefGUI(List) do try
      fRefreshEquipmentLookup := RefreshEquipmentLookup;
      fEquipmentxRef          := EquipmentxRef;
      clientID                := xclientID;
      fCustomerEquipment:= TCustomerEquipment.create(nil);
      try
        fCustomerEquipment.connection := TMyDacDataConnection.create(fCustomerEquipment);
        fCustomerEquipment.connection.Connection := CommonDbLib.GetNewMyDacConnection(fCustomerEquipment);
        fCustomerEquipment.LoadSelect('ClientID= ' +IntToStr(xClientID));

        showmodal;
      finally
          Freeandnil(fCustomerEquipment);
      end;
    finally
      freeandNil(List);
    end;

end;

procedure TEquipmentListforxRefGUI.getEquipmentIDstoexclude(
  const Sender: TBusObj; var Abort: boolean);
begin
  if EquipmentIDstoexclude <> '' then EquipmentIDstoexclude := EquipmentIDstoexclude+',';
  EquipmentIDstoexclude:= EquipmentIDstoexclude + IntToStr(fCustomerEquipment.EquipmentId);
end;

procedure TEquipmentListforxRefGUI.RefreshQuery;
begin
  inherited;
end;

procedure TEquipmentListforxRefGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fCustomerEquipment      := nil;
  fiClientID              := 0;
  fEquipmentxRef          := nil;
  fRefreshEquipmentLookup := nil;
  EquipmentIDstoexclude := '';
end;

procedure TEquipmentListforxRefGUI.FormShow(Sender: TObject);
begin
  if (fCustomerEquipment <> nil) and (EquipmentIDstoexclude = '') and (fCustomerEquipment.count> 0) then begin
     EquipmentIDstoexclude := '';
     fCustomerEquipment.iteraterecords(getEquipmentIDstoexclude);
     if EquipmentIDstoexclude <> '' then begin
         EquipmentIDstoexclude := 'EquipmentId not in (' + EquipmentIDstoexclude +')';
         closedb(Qrymain);
         Qrymain.SQl.add('and  ' +EquipmentIDstoexclude +' group by E.EquipmentID');
     end else Qrymain.SQl.add(' group by E.EquipmentID');
  end else Qrymain.SQl.add(' group by E.EquipmentID');
  RefreshOrignalSQL;
  inherited;

end;

procedure TEquipmentListforxRefGUI.grdMainDblClick(Sender: TObject);
begin
  if assigned(fRefreshEquipmentLookup) then begin
      fCustomerEquipment.Connection.BeginTransaction;
      fCustomerEquipment.New;
      fCustomerEquipment.clientID          := fiClientID;
      fCustomerEquipment.Equipmentid       := qrymainEquipmentID.asInteger;
      fCustomerEquipment.Equipname         := qrymainEquipmentName.AsString;
      fCustomerEquipment.Description       := qrymainEquipmentDescription.AsString;
      fCustomerEquipment.Quantity          := 1;
      fCustomerEquipment.UOM               := AppEnv.DefaultClass.DefaultUOM;
      fCustomerEquipment.UOMQty            := 1;
      fCustomerEquipment.manufacture       := qryMainManufacture.asString;
      fCustomerEquipment.Model             := qryMainModel.asString; 
      fCustomerEquipment.postdb;
      fCustomerEquipment.Connection.CommitTransaction;

      fRefreshEquipmentLookup;
      fEquipmentxRef.New;
      fEquipmentxRef.CustomerEquipmentid :=fCustomerEquipment.ID;
      fEquipmentxRef.PostDB;
    Self.Close;
  end else inherited;

end;
procedure TEquipmentListforxRefGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
//
end;

initialization
  RegisterClassOnce(TEquipmentListforxRefGUI);

end.
