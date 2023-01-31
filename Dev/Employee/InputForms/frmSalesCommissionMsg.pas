unit frmSalesCommissionMsg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, StdCtrls, rtflabel, DNMSpeedButton, ExtCtrls;

type
  TfmSalesCommissionMsg = class(TBaseForm)
    GeneralNote: TRTFLabel;
    Label1: TLabel;
    cmdNew: TDNMSpeedButton;
    Bevel1: TBevel;
    procedure cmdNewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSalesCommissionMsg: TfmSalesCommissionMsg;

implementation

uses CommonLib;

{$R *.dfm}

procedure TfmSalesCommissionMsg.cmdNewClick(Sender: TObject);
begin
  inherited;
  Self.close;
end;

procedure TfmSalesCommissionMsg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;
initialization
  RegisterClass(TfmSalesCommissionMsg);

end.
