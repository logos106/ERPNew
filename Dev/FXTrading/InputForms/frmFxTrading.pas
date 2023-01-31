unit frmFxTrading;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase, BusObjFXTrading, wwdblook, Grids, Wwdbigrd, Wwdbgrid, Buttons;

type
  TfmFxTrading = class(TBaseInputGUI)
    qryFXTrading: TERPQuery;
    dsFXTrading: TDataSource;
    DNMPanel1: TDNMPanel;
    pnlHeader: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    qryFxTradinglines: TERPQuery;
    dsFxTradinglines: TDataSource;
    qryFXTradingID: TIntegerField;
    qryFXTradingGlobalRef: TWideStringField;
    qryFXTradingCurrencyID: TIntegerField;
    qryFXTradingCurrencyCode: TWideStringField;
    qryFXTradingEmployeeID: TIntegerField;
    qryFXTradingEmployeeName: TWideStringField;
    qryFXTradingmstimestamp: TDateTimeField;
    qryFXTradingMsUpdateSitecode: TWideStringField;
    qryFxTradinglinesID: TIntegerField;
    qryFxTradinglinesFxTradingID: TIntegerField;
    qryFxTradinglinesGlobalRef: TWideStringField;
    qryFxTradinglinesTransdate: TDateTimeField;
    qryFxTradinglinesAmount: TFloatField;
    qryFxTradinglinesBuyCurrencyID: TIntegerField;
    qryFxTradinglinesBuyCurrencyCode: TWideStringField;
    qryFxTradinglinesBuyRate: TFloatField;
    qryFxTradinglinesEmployeeID: TIntegerField;
    qryFxTradinglinesEmployeeName: TWideStringField;
    qryFxTradinglinesmsTimestamp: TDateTimeField;
    qryFxTradinglinesmsUpdateSiteCode: TWideStringField;
    pnlDetails: TDNMPanel;
    cboEmployeeLookup: TERPQuery;
    Label1: TLabel;
    cboEmployee: TwwDBLookupCombo;
    qryForeignCurrency: TERPQuery;
    lblBaseForeignCurrencyCode: TLabel;
    cboBaseForeignCurrencyCode: TwwDBLookupCombo;
    cbolinesEmployeeName: TwwDBLookupCombo;
    cbolinesEmployeeLookup: TERPQuery;
    qryBaseForeignCurrency: TERPQuery;
    cboBuyCurrencyCode: TwwDBLookupCombo;
    qryBaseForeignCurrencyCurrencyID: TIntegerField;
    qryBaseForeignCurrencyCountry: TWideStringField;
    qryBaseForeignCurrencyCurrency: TWideStringField;
    qryBaseForeignCurrencyCode: TWideStringField;
    qryBaseForeignCurrencyBuyRate: TFloatField;
    qryBaseForeignCurrencyActive: TWideStringField;
    cbolinesEmployeeLookupEmployeeID: TIntegerField;
    cbolinesEmployeeLookupEmployeeName: TWideStringField;
    grdTransactions: TwwDBGrid;
    btnDelete: TwwIButton;
    qryFxTradinglinesDeleted: TWideStringField;
    qryFxTradinglinesinLocalcurrency: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cboBuyCurrencyCodeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure cbolinesEmployeeNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDeleteClick(Sender: TObject);
    procedure qryFxTradinglinesCalcFields(DataSet: TDataSet);
  private
    FxTradingOBj: TFXTrading;
    function  SaveRecord: Boolean;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, BusObjConst, CommonDbLib, FormFactory, AppEnvironment;

{$R *.dfm}

procedure TfmFxTrading.btnDeleteClick(Sender: TObject);
begin
  inherited;
  FxTradingOBj.Lines.Deleted := True;
  FxTradingOBj.Lines.PostDB;
end;

procedure TfmFxTrading.cboBuyCurrencyCodeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  FxTradingOBj.Lines.BuyCurrencyID :=  qryBaseForeignCurrencyCurrencyID.AsInteger;
  FxTradingOBj.Lines.BuyRate := qryBaseForeignCurrencyBuyRate.AsFloat;
end;

procedure TfmFxTrading.cbolinesEmployeeNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  FxTradingOBj.Lines.EmployeeID := cbolinesEmployeeLookupEmployeeID.AsInteger;
end;

procedure TfmFxTrading.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

Function TfmFxTrading.SaveRecord :Boolean;
begin
  result:= False;
  FxTradingOBj.PostDB;
  if not(FxTradingOBj.Save) then exit;
  Result:= True;

end;

procedure TfmFxTrading.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  FxTradingOBj.Connection.CommitTransaction;
  FxTradingOBj.Dirty:= FAlse;
  Self.Close;
end;

procedure TfmFxTrading.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
    inherited;
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TFXTrading then TFXTRading(Sender).Dataset  := qryFXTrading
        else if Sender is TFXTradinglines then TFXTradinglines(Sender).Dataset  := qryFXTradinglines;
     end;
end;

procedure TfmFxTrading.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TfmFxTrading.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if FxTradingOBj.Dirty then begin
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
          FxTradingOBj.Dirty := false;
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

procedure TfmFxTrading.FormCreate(Sender: TObject);
begin
  inherited;
  qryFxTradinglinesinLocalcurrency.displayLabel := 'Amount in ' + appenv.RegionalOptions.ForeignExDefault;
  FxTradingOBj := TFXTRading.CreateWithNewConn(Self);
  FxTradingOBj.Connection.connection := Self.MyConnection;
  FxTradingOBj.BusObjEvent := DoBusinessObjectEvent;
end;
procedure TfmFxTrading.FormShow(Sender: TObject);
begin
  inherited;

  {binny : at the moment there will be only one record in this table, so just finding the id of the record to load}
  if KeyId =0 then
    With TempMyQuery do try
      SQL.Add('select Id from tblFXTrading order by ID');
      open;
      KeyId := fieldbyname('ID').AsInteger;
    finally
      closenFree;
    end;

  FxTradingOBj.Load(KeyID);
  FxTradingOBj.connection.BeginTransaction;
  if FxTradingOBj.count=0 then FxTradingOBj.new;
  FxTradingOBj.Lines;
  openQueries;
  cboBaseForeignCurrencyCode.enabled := False;
end;

procedure TfmFxTrading.qryFxTradinglinesCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryFxTradinglinesinLocalcurrency.AsFloat := qryFxTradinglinesAmount.AsFloat *qryFxTradinglinesBuyRate.AsFloat;
end;

initialization
  RegisterClassOnce(TfmFxTrading);
  With Formfact do begin
    RegisterMe(TfmFxTrading, 'TFxTradingListGUI_*=ID');
  end;
end.

