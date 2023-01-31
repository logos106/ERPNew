unit frmCustomerSpecialPricecopy;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, Menus, ExtCtrls, StdCtrls, CheckLst, DNMPanel,
  DNMSpeedButton, Shader;

type
  TfmCustomerSpecialPricecopy = class(TBaseForm)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cmdOk: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    chkGD: TCheckBox;
    chkSP: TCheckBox;
    chkPD: TCheckBox;
    chkSPD: TCheckBox;
  private
    function getCopyGroupDiscount: Boolean;
    function getCopyPermanentDiscount: Boolean;
    function getCopySpecialProductDiscount: Boolean;
    function getCopySpecialProducts: Boolean;
    { Private declarations }
  public
    Property CopyGroupDiscount :Boolean read getCopyGroupDiscount ;
    Property CopyPermanentDiscount :Boolean read getCopyPermanentDiscount ;
    Property CopySpecialProducts :Boolean read getCopySpecialProducts ;
    Property CopySpecialProductDiscount :Boolean read getCopySpecialProductDiscount ;
    procedure setCopyGroupDiscount(const Value: Boolean;const msg:String);
    procedure setCopyPermanentDiscount(const Value: Boolean;const msg:String);
    procedure setCopySpecialProductDiscount(const Value: Boolean;const msg:String);
    procedure setCopySpecialProducts(const Value: Boolean;const msg:String);


  end;


implementation

{$R *.dfm}

(*initialization
  RegisterClassOnce(TfmCustomerSpecialPricecopy);*)

{ TfmCustomerSpecialPricecopy }

function TfmCustomerSpecialPricecopy.getCopyGroupDiscount         : Boolean;begin  result := chkGD.Checked  ;end;
function TfmCustomerSpecialPricecopy.getCopyPermanentDiscount     : Boolean;begin  result := chkPD.Checked  ;end;
function TfmCustomerSpecialPricecopy.getCopySpecialProductDiscount: Boolean;begin  result := chkSPD.Checked ;end;
function TfmCustomerSpecialPricecopy.getCopySpecialProducts       : Boolean;begin  result := chkSP.Checked  ;end;

procedure TfmCustomerSpecialPricecopy.setCopyGroupDiscount          (const Value: Boolean;const msg:String);begin  chkGD.Enabled  := Value; if not(Value) and (msg <> '')  then chkGD.caption := chkGD.caption +'(' +Msg+')'; end;
procedure TfmCustomerSpecialPricecopy.setCopyPermanentDiscount      (const Value: Boolean;const msg:String);begin  chkPD.enabled  := Value; if not(Value) and (msg <> '')  then chkPD.caption := chkPD.caption +'(' +Msg+')'; end;
procedure TfmCustomerSpecialPricecopy.setCopySpecialProductDiscount (const Value: Boolean;const msg:String);begin  chkSPD.enabled := Value; if not(Value) and (msg <> '')  then chkSPD.caption:= chkSPD.caption +'(' +Msg+')'; end;
procedure TfmCustomerSpecialPricecopy.setCopySpecialProducts        (const Value: Boolean;const msg:String);begin  chkSP.enabled  := Value; if not(Value) and (msg <> '')  then chkSP.caption := chkSP.caption +'(' +Msg+')'; end;

end.
