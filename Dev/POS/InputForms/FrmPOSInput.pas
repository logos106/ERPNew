unit FrmPOSInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, POSChequeGUI, ExtCtrls, Shader, rwButtonArray, DNMPanel,
  DNMSpeedButton, StdCtrls, Mask, wwdbedit;

type
  TFmPOSInput = class(TPOSChequePopUp)
    Bevel3: TBevel;
    edtInput2: TwwDBEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    procedure FormShow(Sender: TObject);
  private
    fsCaption2: String;
    fsCaption1: String;
    fsEditMask2: String;
    fsEditMask1: String;
    procedure setCaption1(const Value: String);
    procedure setCaption2(const Value: String);
    procedure setEditMask1(const Value: String);
    procedure setEditMask2(const Value: String);
    function getValue1: Int64;
    function getValue2: Int64;
    procedure setValue1(const Value: Int64);
    procedure setValue2(const Value: Int64);
    { Private declarations }
  public
    Property Caption1: String read fsCaption1 write setCaption1;
    Property Caption2: String read fsCaption2 write setCaption2;
    Property EditMask1: String read fsEditMask1 write setEditMask1;
    Property EditMask2: String read fsEditMask2 write setEditMask2;
    Property Value1: Int64 read getValue1 write setValue1;
    Property Value2: Int64 read getValue2 write setValue2;

  end;

implementation

uses CommonLib;

{$R *.dfm}
{ TFmPOSInput }

procedure TFmPOSInput.setCaption1(const Value: String);
begin
  fsCaption1 := Value;
  lbl1.Caption := Value;
end;

procedure TFmPOSInput.setCaption2(const Value: String);
begin
  fsCaption2 := Value;
  lbl2.Caption := Value;
end;

procedure TFmPOSInput.setEditMask1(const Value: String);
begin
  fsEditMask1 := Value;
  edtInput1.picture.PictureMask := Value;
end;

procedure TFmPOSInput.setEditMask2(const Value: String);
begin
  fsEditMask2 := Value;
  edtInput2.picture.PictureMask := Value;
end;

procedure TFmPOSInput.FormShow(Sender: TObject);
begin
  inherited;
  Self.Caption := titleLabel.Caption;
end;

function TFmPOSInput.getValue1: Int64;
begin
  result := 0;
  if isinteger(edtInput1.Text) then
    result := strtoInt(edtInput1.Text);
end;

function TFmPOSInput.getValue2: Int64;
begin
  result := 0;
  if isinteger(edtInput2.Text) then
    result := strtoInt(edtInput2.Text);
end;

procedure TFmPOSInput.setValue1(const Value: Int64);
begin
  edtInput1.Text := inttostr(Value);
end;

procedure TFmPOSInput.setValue2(const Value: Int64);
begin
  edtInput2.Text := inttostr(Value);
end;

end.
