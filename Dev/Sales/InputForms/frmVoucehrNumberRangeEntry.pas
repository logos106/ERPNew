unit frmVoucehrNumberRangeEntry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, Shader, ExtCtrls, DNMPanel, StdCtrls, DNMSpeedButton, Mask,
  wwdbedit;

type
  TfmVoucehrNumberRangeEntry = class(TfrmBaseGUI)
    btnOk: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    edtVoucherNoto: twwDBEdit;
    lblto: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    edtVoucheramount: twwDBEdit;
    lblAmount: TLabel;
    edtVouchernumebrFrom: TwwDBEdit;
    lblfrom: TLabel;
    lblHint: TLabel;
    Bevel1: TBevel;
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtVoucherNotoExit(Sender: TObject);
    procedure edtVouchernumebrFromExit(Sender: TObject);
  private
    fiMaxVoucherscount: int64;
    fiNextVoucherno: int64;
    fiVouchernofrom: int64;
    fiVouchernoTo: int64;
    function getVoucheramount: double;
    function getVouchernofrom: int64;
    function getVouchernoTo: int64;
    function Validaterange: Boolean;
    function TextToint(Edit: TwwDBEdit): int64;
    { Private declarations }
  public
    property Voucheramount :double read getVoucheramount;
    Property Vouchernofrom :int64 read getVouchernofrom;
    Property VouchernoTo :int64 read getVouchernoTo;
    Property MaxVoucherscount :int64 read fiMaxVoucherscount write fiMaxVoucherscount;
    Property NextVoucherno :int64 read fiNextVoucherno write fiNextVoucherno;
  end;


implementation

uses CommonLib, VoucherLib, tcConst;

{$R *.dfm}

{ TfmVoucehrNumberRangeEntry }

procedure TfmVoucehrNumberRangeEntry.btnOkClick(Sender: TObject);
begin
  inherited;
  if voucheramount=0 then begin
      MessageDlgXP_Vista('Please provide the '+ Quotedstr(lblAmount.Caption)+'.', mtWarning, [mbOK], 0);
      SetControlfocus(edtVoucheramount);
      exit;
  end;
  if Vouchernofrom=0 then begin
      MessageDlgXP_Vista('Please provide the ' + quotedstr(lblfrom.caption)+ '.', mtWarning, [mbOK], 0);
      SetControlfocus(edtVouchernumebrFrom);
      exit;
  end;
  if VouchernoTo=0 then begin
      MessageDlgXP_Vista('Please provide the ' + quotedstr(lblto.caption)+ '.', mtWarning, [mbOK], 0);
      SetControlfocus(edtVoucherNoto);
      exit;
  end;
  if not Validaterange then exit;

  modalresult:= mrOk;
end;
function TfmVoucehrNumberRangeEntry.Validaterange:Boolean;
begin
  result:=  False;
  if VouchernoTo <Vouchernofrom then begin
      MessageDlgXP_Vista(quotedstr(lblto.caption)+ ' cannot be Less than '+ quotedstr(lblfrom.caption) +'.', mtWarning, [mbOK], 0);
      edtVoucherNoto.text:=inttostr(Vouchernofrom +100);
      SetControlfocus(edtVoucherNoto);
      exit;
  end;
  if  VouchernoTo - Vouchernofrom > MaxVoucherscount then begin
      MessageDlgXP_Vista('You can have a maximum of ' +inttostr(MaxRecordsToGenerate)+' records at a time.'+NL+
                        'This Voucher transaction already has '+inttostr(MaxRecordsToGenerate-MaxVoucherscount )+'.'+NL+
                        'You can only populate ' + inttostr(MaxVoucherscount) +' vouchers.', mtWarning, [mbOK], 0);
      edtVoucherNoto.text :=inttostr(Vouchernofrom + MaxVoucherscount);
      SetControlfocus(edtVoucherNoto);
      exit;
  end;
  result:= True;
end;

procedure TfmVoucehrNumberRangeEntry.edtVoucherNotoExit(Sender: TObject);
begin
  inherited;
  validateRange;
end;

procedure TfmVoucehrNumberRangeEntry.edtVouchernumebrFromExit(Sender: TObject);
begin
  inherited;
  validateRange;
end;

procedure TfmVoucehrNumberRangeEntry.FormCreate(Sender: TObject);
begin
  inherited;
  fiMaxVoucherscount := MaxRecordsToGenerate;
  fiNextVoucherno := 0;
end;

procedure TfmVoucehrNumberRangeEntry.FormShow(Sender: TObject);
begin
  inherited;
  edtVouchernumebrFrom.text := inttostr(fiNextVoucherno);
  edtVoucherNoto.Text :=inttostr(fiNextVoucherno+100);
end;

function TfmVoucehrNumberRangeEntry.getVoucheramount: double;
begin
  result:= 0;
  if isnumeric(edtVoucheramount.Text) then result := StrTofloat(edtVoucheramount.Text);
end;

function TfmVoucehrNumberRangeEntry.getVouchernofrom: int64;
begin
  result:= TextToint(edtVouchernumebrFrom);
  fiVouchernofrom:= result;
end;


function TfmVoucehrNumberRangeEntry.getVouchernoTo: int64;
begin
  result:= TextToint(edtVoucherNoto);
  fiVouchernoto:= result;
end;

function TfmVoucehrNumberRangeEntry.TextToint(Edit:TwwDBEdit): int64;
begin

  result:= 0;
  if length(Edit.Text)>17 then Edit.Text := copy(Edit.Text,1, 17);
    if isNumeric(Edit.Text) then
    try
        result := strToInt64(Edit.Text);
    except
      on E:EConvertError do begin
        if strtofloat(Edit.Text) >  99999999999999999 then begin
          result:= 99999999999999999;
          Edit.Text := '99999999999999999';
        end;
      end else raise;
    end;
end;
end.

