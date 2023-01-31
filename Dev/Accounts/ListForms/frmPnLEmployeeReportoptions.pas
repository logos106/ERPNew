unit frmPnLEmployeeReportoptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, Shader, ExtCtrls, StdCtrls, DNMSpeedButton, DNMPanel;

type
  TfmPnLEmployeeReportoptions = class(TBaseForm)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cmdClose: TDNMSpeedButton;
    DNMSpeedButton1: TDNMSpeedButton;
    chkPO: TCheckBox;
    chkLayby: TCheckBox;
    chkcheque: TCheckBox;
    chkBills: TCheckBox;
    chkCredits: TCheckBox;
    chkInvoice: TCheckBox;
    chkPOS: TCheckBox;
    chkSO: TCheckBox;
    chkCashSale: TCheckBox;
    chkRefunds: TCheckBox;
    label1: TLabel;
    Label2: TLabel;
    optCategory: TRadioGroup;
    lblCategory: TLabel;
    Label4: TLabel;
    chkJE: TCheckBox;
    chkVoucher: TCheckBox;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    procedure FormShow(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
  private
    fInitOptionsform: TnotifyEvent;
    fInitOptionsFromform: TNotifyEvent;
    { Private declarations }
  public
    Property InitOptionsform :TnotifyEvent read fInitOptionsform write fInitOptionsform;
    Property InitOptionsFromform :TNotifyEvent Read fInitOptionsFromform write fInitOptionsFromform;
  end;


implementation

uses PnLEmployeeReport, CommonLib;

{$R *.dfm}

procedure TfmPnLEmployeeReportoptions.cmdCloseClick(Sender: TObject);
begin
  inherited;
  Self.close;
end;

procedure TfmPnLEmployeeReportoptions.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
    if assigned(fInitOptionsFromform) then fInitOptionsFromform(Self);
    Self.close;

end;

procedure TfmPnLEmployeeReportoptions.FormShow(Sender: TObject);
begin
  inherited;
  if assigned(fInitOptionsform) then fInitOptionsform(Self);
end;
initialization
  RegisterClassOnce(TfmPnLEmployeeReportoptions);

end.

