unit frmPCCDelivery;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DNMSpeedButton, ExtCtrls, DNMPanel, Menus, AdvMenus,
  DataState, DBAccess, MyAccess, SelectionDialog, AppEvnts, DB, 
  MemDS, StdCtrls, wwdbdatetimepicker, Mask, wwdbedit, wwdblook, wwcheckbox,
  Shader;

type
  TPCCDelivery = class(TBaseInputGUI)
    Bevel1: TBevel;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    wwDBDateTimePicker1: TwwDBDateTimePicker;
    qryDelivery: TMyQuery;
    dsDelivery: TDataSource;
    qryDeliveryTankNo: TIntegerField;
    qryDeliveryVolume: TFloatField;
    qryDeliveryDeliveryDateTime: TDateTimeField;
    qryTanks: TMyQuery;
    wwDBLookupCombo1: TwwDBLookupCombo;
    wwDBEdit1: TwwDBEdit;
    qryTanksTankNo: TIntegerField;
    qryTanksTankDescription: TStringField;
    cbActive: TwwCheckBox;
    qryDeliveryActive: TStringField;
    Label4: TLabel;
    Label5: TLabel;
    wwDBEdit2: TwwDBEdit;
    qryDeliveryInvoiceNo: TStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PCCDelivery: TPCCDelivery;

implementation

uses FormFactory, CommonLib;

{$R *.dfm}

procedure TPCCDelivery.FormCreate(Sender: TObject);
begin
  inherited;
  wwDBDateTimePicker1.DisplayFormat := ShortDateFormat + ' ' + LongTimeFormat;
end;

procedure TPCCDelivery.FormShow(Sender: TObject);
begin
  inherited;
  qryDelivery.ParamByName('DeliveryID').AsInteger := KeyID;
  OpenQueries;
  if KeyID = 0 then begin
    qryDelivery.Insert;
    qryDelivery.FieldByName('DeliveryDateTime').AsDateTime := Now;
    cbActive.Checked := true;
  end
  else begin
    qryDelivery.Edit;
  end;
end;

procedure TPCCDelivery.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TPCCDelivery.btnOKClick(Sender: TObject);
begin
  if qryDelivery.State in [dsEdit, dsInsert] then begin
    qryDelivery.Post;
  end;
  Notify;
  inherited;
  Close;
end;

procedure TPCCDelivery.btnCancelClick(Sender: TObject);
begin
  inherited;
  qryDelivery.Cancel;
  Close;
end;

initialization
  RegisterClassOnce(TPCCDelivery);
  FormFact.RegisterMe(TPCCDelivery, 'TPCCDeliveryList_*=PCCDeliveryID');

end.
