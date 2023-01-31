unit frmERPHint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, StdCtrls, Shader, ExtCtrls, DNMPanel,
  GradientLabel, frmshape;
const
  Hintcolors :Array[1..12] of TColor=($0091FFFF,$0051FFFF,$0028FFFF,$0000FBFB,$0050F8DE,$0010F5D3,$0009D5B6,$0010F5D3,$0050F8DE,$0000FBFB,$0028FFFF,$0051FFFF);
  fontcolors :Array[1..2] of TColor=(ClNavy, clMaroon);
type
  TfmERPHint = class(TBaseForm)
    Timer1: TTimer;
    lblTraining: TGradientLabel;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CreateParams(var Params: TCreateParams);Override;
  private
    fiOwnerformtop: Integer;
    colorIndex:Integer;
    fsformOwnerform: String;

    { Private declarations }
  public
    Procedure ShowERPHint(Const Value:String);
    Property Ownerformtop :Integer read fiOwnerformtop write fiOwnerformtop;
    Property formOwnerform:String read fsformOwnerform Write fsformOwnerform;
  end;


implementation

uses CommonLib;

{$R *.dfm}
{ TfmERPHint }

procedure TfmERPHint.ShowERPHint(const Value: String);
begin
  lblTraining.caption := Value;
  Self.Height :=   CharCounter(chr(13), Value)*35;
  if fiOwnerformtop -Self.Height<0 then
    Self.top :=  0
  else
  Self.top :=  fiOwnerformtop -Self.Height;
end;

procedure TfmERPHint.FormCreate(Sender: TObject);
begin
  inherited;
  fiOwnerformtop:= 0;
  colorIndex:= 1;
  fsformOwnerform:= '';
end;

procedure TfmERPHint.Timer1Timer(Sender: TObject);
begin
  inherited;
  lblTraining.color :=Hintcolors[colorIndex];
  if colorIndex <high(Hintcolors) then colorIndex := colorIndex +1 else colorIndex:= low(Hintcolors);
  //lblTraining.font.Color :=fontcolors[colorIndex];
end;

procedure TfmERPHint.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;
procedure TfmERPHint.CreateParams(var Params: TCreateParams) ;
 begin
 inherited;
   Params.style := Params.style and not WS_CAPTION;
 end;
initialization
  RegisterClassOnce(TfmERPHint);

end.
