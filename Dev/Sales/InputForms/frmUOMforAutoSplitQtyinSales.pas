unit frmUOMforAutoSplitQtyinSales;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase, Buttons, Wwdbigrd, Grids, Wwdbgrid, BusobjUOM;

type
  TfmUOMforAutoSplitQtyinSales = class(TBaseInputGUI)
    qryUOM: TERPQuery;
    dsUOM: TDataSource;
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Box20: TBevel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    qryUOMunitId: TIntegerField;
    qryUOMUnitName: TWideStringField;
    qryUOMMultiplier: TFloatField;
    qryUOMbaseunitname: TWideStringField;
    qryUOMUseforAutoSplitQtyinSales: TWideStringField;
    grdTransactions: TwwDBGrid;
    qryUOMUOMMult: TStringField;
    qryUOMGlobalRef: TWideStringField;
    qryUOMUnitDescription: TWideStringField;
    qryUOMEditedFlag: TWideStringField;
    qryUOMBaseUnitID: TIntegerField;
    qryUOMmsTimeStamp: TDateTimeField;
    qryUOMActive: TWideStringField;
    qryUOMPartID: TIntegerField;
    qryUOMSalesDefault: TWideStringField;
    qryUOMPurchasesDefault: TWideStringField;
    qryUOMHeight: TFloatField;
    qryUOMWidth: TFloatField;
    qryUOMLength: TFloatField;
    qryUOMWeight: TFloatField;
    qryUOMVolume: TFloatField;
    qryUOMNoOfBoxes: TIntegerField;
    qryUOMUnitProductKeyName: TWideStringField;
    qryUOMmsUpdateSiteCode: TWideStringField;
    cmdNew: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure qryUOMCalcFields(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdNewClick(Sender: TObject);
  private
    UOMObj: TUnitOfMeasure;
    fiProductID :Integer;
    fbAnyUOMSelectedforAutoSplit:Boolean;
    function SaveRecord: Boolean;
    Procedure LocalallCallback(const Sender: TBusObj; var Abort: Boolean);
    Procedure AnyUOMSelectedforAutoSplitCallback(const Sender: TBusObj; var Abort: Boolean);

    function AnyUOMSelectedforAutoSplit: Boolean;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    Property ProductID:Integer read fiProductID write fiProductID;
  end;


implementation

uses CommonLib, BusObjConst , tcConst, CommonFormLib;

{$R *.dfm}

procedure TfmUOMforAutoSplitQtyinSales.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

Function TfmUOMforAutoSplitQtyinSales.SaveRecord :Boolean;
begin
  result:= False;
  UOMObj.PostDB;
  if not(UOMObj.Save) then exit;
  Result:= True;
end;
Procedure TfmUOMforAutoSplitQtyinSales.AnyUOMSelectedforAutoSplitCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TUnitOfMeasure) then exit;
  if TUnitOfMeasure(Sender).UseforAutoSplitQtyinSales then begin
     fbAnyUOMSelectedforAutoSplit:= True;
     Abort := True;
  end;
end;
function TfmUOMforAutoSplitQtyinSales.AnyUOMSelectedforAutoSplit:Boolean;
begin
  fbAnyUOMSelectedforAutoSplit:=false;
  UOMobj.iteraterecords(AnyUOMSelectedforAutoSplitCallback);
  result:=fbAnyUOMSelectedforAutoSplit;
end;
procedure TfmUOMforAutoSplitQtyinSales.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  if AnyUOMSelectedforAutoSplit =False then
    if MessageDlgXP_Vista('You haven''t selected any UOM for ''Auto Split''. Do you want to save it?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
  UOMObj.Connection.CommitNestedTransaction;
  UOMObj.Dirty := false;
  Self.Close;
end;

procedure TfmUOMforAutoSplitQtyinSales.cmdNewClick(Sender: TObject);
var
  fiID:Integer;
begin
  inherited;
  fiID:= UOMObj.ID;
  try
    OpenERPFormModal('TUnitsOfMeasureGUI' , 0 );
    UOMObj.Closedb;
    UOMObj.Opendb;
  finally
    UOMObj.Locate(UOMObj.IDFieldname , fiID, []);
  end;
end;

procedure TfmUOMforAutoSplitQtyinSales.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
     inherited ;
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TUnitOfMeasure then TUnitOfMeasure(Sender).Dataset  := qryUOM;
     end;
end;

procedure TfmUOMforAutoSplitQtyinSales.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TfmUOMforAutoSplitQtyinSales.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if UOMObj.Dirty then begin
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
          UOMObj.Dirty := false;
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

procedure TfmUOMforAutoSplitQtyinSales.FormCreate(Sender: TObject);
begin
  inherited;
  UOMObj := TUnitOfMeasure.CreateWithNewConn(Self);
  UOMObj.Connection.connection := Self.MyConnection;
  UOMObj.BusObjEvent := DoBusinessObjectEvent;
end;
procedure TfmUOMforAutoSplitQtyinSales.FormShow(Sender: TObject);
begin
  inherited;
  SetTransconenctiontoQueries;
  if TransConnection <> nil then UOMObj.Connection.Connection := TransConnection;
  UOMObj.LoadSelect('partId = ' + inttostr(ProductID)+'  order by multiplier DEsc ');
  UOMObj.IterateRecords(LocalallCallback);
  if accesslevel < 5 then UOMObj.connection.BeginNestedTransaction;
  openQueries;
end;

procedure TfmUOMforAutoSplitQtyinSales.LocalallCallback(const Sender: TBusObj; var Abort: Boolean);
var
  s:String;
begin
  if not(Sender is TUnitOfMeasure) then exit;
  if not (Sender.Lock) then begin
    Accesslevel := 5;
    abort := True;
    s:= Sender.UserLock.LockMessage;
    s:= ReplaceStr(s,'Unable to update data.' , 'Unable to Select UOM for Auto Split Qty.' );
    s:= ReplaceStr(s, 'accessing this record' , 'accessing UOM ' +quotedstr(TUnitOfMeasure(Sender).UOMName));
    s:= s +NL+NL+'Access is changed to Read-Only';
    MessageDlgXP_Vista(s, mtWarning, [mbOK], 0);
  end;
end;

procedure TfmUOMforAutoSplitQtyinSales.qryUOMCalcFields(DataSet: TDataSet);
begin
  inherited;
  if qryUOMMultiplier.AsFloat = 1 then
      qryUOMUOMMult.AsString := floattostr(qryUOMMultiplier.AsFloat)
  else
      qryUOMUOMMult.AsString := floattostr(qryUOMMultiplier.AsFloat) +  ' ( ' +qryUOMbaseunitname.AsString +')';
end;

initialization
  RegisterClassOnce(TfmUOMforAutoSplitQtyinSales);

end.

