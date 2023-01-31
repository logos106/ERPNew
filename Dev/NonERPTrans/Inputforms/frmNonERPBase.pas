unit frmNonERPBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase , Mask, wwdbedit, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, BusobjNonERPTrans;

type
  TfmNonERPBase = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    qryMaster: TERPQuery;
    qrydetails: TERPQuery;
    dsMaster: TDataSource;
    dsdetails: TDataSource;
    DNMPanel4: TDNMPanel;
    Label38: TLabel;
    edtBaseExchangeRate: TwwDBEdit;
    SaleDate_Label: TLabel;
    cboCreationDate: TwwDBDateTimePicker;
    grdTransactions: TwwDBGrid;
    btnDelete: TwwIButton;
    DNMPanel5: TDNMPanel;
    Label56: TLabel;
    txtTotalAmount: TDBEdit;
    qryMasterGlobalref: TWideStringField;
    qryMasterClientID: TIntegerField;
    qryMasterTotalAmountInc: TFloatField;
    qryMasterEmployeeName: TWideStringField;
    qryMasterEmployeeID: TIntegerField;
    qryMasterComments: TWideMemoField;
    qryMasterEnteredBy: TWideStringField;
    qryMasterEnteredAt: TDateTimeField;
    qryMastermstimestamp: TDateTimeField;
    qryMastermsupdateSitecode: TWideStringField;
    qryMasterSource: TWideStringField;
    qrydetailsGlobalRef: TWideStringField;
    qrydetailsProductID: TIntegerField;
    qrydetailsProductName: TWideStringField;
    qrydetailsProductPrintName: TWideStringField;
    qrydetailsProduct_Description: TWideStringField;
    qrydetailsShipped: TFloatField;
    qrydetailsTotalLineAmountInc: TFloatField;
    qrydetailsmstimestamp: TDateTimeField;
    qrydetailsmsupdateSitecode: TWideStringField;
    qryMasterterms: TWideStringField;
    qryMasterStatus: TWideStringField;
    Label1: TLabel;
    wwDBEdit1: TwwDBEdit;
    wwDBEdit2: TwwDBEdit;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    Procedure Openrec;
  Protected
    NonERPTransObj :TNonERPTrans;
    procedure NewBusObjinstance;virtual;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    procedure CommitAndNotify;override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, BusObjConst, AppEnvironment , FormFactory;

{$R *.dfm}

procedure TfmNonERPBase.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfmNonERPBase.cmdCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfmNonERPBase.CommitAndNotify;
begin
end;

procedure TfmNonERPBase.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
     inherited ;
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
             if Sender is TNonERPTrans      then TNonERPTrans(Sender).Dataset     := qryMaster
        else if Sender is TNonERPTransLines then TNonERPTransLines(Sender).Dataset:= qrydetails;
     end;
end;

procedure TfmNonERPBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  action := cafree;
end;

procedure TfmNonERPBase.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  CanClose := true;
end;

procedure TfmNonERPBase.FormCreate(Sender: TObject);
begin
  inherited;
   NewBusObjinstance;
end;
procedure TfmNonERPBase.FormShow(Sender: TObject);
begin
  inherited;
  OpenRec;
  AccessLevel := 5;// this is a readonly form to view the nonerp slaes data
end;

procedure TfmNonERPBase.NewBusObjinstance;
begin

end;

procedure TfmNonERPBase.Openrec;
begin
  NonERPTransObj.Load(KeyID);
  NonERPTransObj.Lines;
  openQueries;
end;

end.

