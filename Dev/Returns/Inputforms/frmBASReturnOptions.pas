unit frmBASReturnOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, ExtCtrls, DNMPanel, DNMSpeedButton, StdCtrls, Shader,
  frmBase, SelectionDialog, Menus;

type
  TfmBASReturnOptions = class(TBaseForm)
    pnltop: TDNMPanel;
    pnlBottom: TDNMPanel;
    pnlMain: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnCompleted: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    chkGST: TCheckBox;
    chkPaygw: TCheckBox;
    chkPaygI: TCheckBox;
    chkWnL  : TCheckBox;
    procedure btnCompletedClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    fbGSTEnabled  :Boolean;
    fbGIEnabled   :Boolean;
    fbGWEnabled   :Boolean;
    fbWnLEnabled  :Boolean;
    function getGSTEnabled: Boolean;
    function getPayGIEnabled: Boolean;
    function getPayGWEnabled: Boolean;
    function getWnLEnabled :boolean;
    procedure setGSTEnabled(const Value: Boolean);
    procedure setPayGIEnabled(const Value: Boolean);
    procedure setPayGWEnabled(const Value: Boolean);
    Procedure SetWnLEnabled(Const Value:boolean);
    { Private declarations }
  public
    Property GSTEnabled   :Boolean read getGSTEnabled   write setGSTEnabled;
    Property PayGWEnabled :Boolean read getPayGWEnabled write setPayGWEnabled;
    Property PayGIEnabled :Boolean read getPayGIEnabled write setPayGIEnabled;
    Property WnLEnabled   :Boolean read getWnLEnabled   write setWnLEnabled;

  end;


implementation

uses CommonLib;

{$R *.dfm}
{ TfmBASReturnOptions }

procedure TfmBASReturnOptions.btnCloseClick(Sender: TObject);
begin
    chkGST.checked    := fbGSTEnabled    ;
    chkPAYGI.checked  := fbGIEnabled;
    chkPAYGW.checked  := fbGWEnabled;
    chkWnL.checked    := fbWnLEnabled;
  inherited;
  if not(GSTEnabled) and  not(PayGWEnabled) and  not(PayGIEnabled)  and  not(WnLEnabled) then begin
    MessageDlgXP_Vista('Please Select at least one of the options as the BAS Return cannot be created without any of these option.', mtWarning, [mbOK], 0);
    Exit;
  end;
   Modalresult := mrOk;

end;

procedure TfmBASReturnOptions.btnCompletedClick(Sender: TObject);
begin
  inherited;
  if not(GSTEnabled) and  not(PayGWEnabled) and  not(PayGIEnabled) and  not(WnLEnabled)then begin
    MessageDlgXP_Vista('Please Select at least one of the options as the BAS Return cannot be created without any of these option.   ''Cancel'' will leave all options ''Unchanged'' ', mtWarning, [mbOK], 0);
    Exit;
  end;
  Modalresult := mrOk;
end;

procedure TfmBASReturnOptions.FormShow(Sender: TObject);
begin
  inherited;
    fbGSTEnabled  := chkGST.checked   ;
    fbGIEnabled   := chkPAYGI.checked ;
    fbGWEnabled   := chkPAYGW.checked ;
    fbWnLEnabled  := chkWnL.checked;
end;

function TfmBASReturnOptions.getGSTEnabled  : Boolean;begin  Result := chkGST.checked   ;end;
function TfmBASReturnOptions.getPayGIEnabled: Boolean;begin  Result := chkPAYGI.checked ;end;
function TfmBASReturnOptions.getWnLEnabled: Boolean;begin  Result := chkWnL.checked ;end;
function TfmBASReturnOptions.getPayGWEnabled: Boolean;begin  Result := chkPAYGW.checked ;end;
procedure TfmBASReturnOptions.setGSTEnabled   (const Value: Boolean);begin chkGST.checked   := Value; end;
procedure TfmBASReturnOptions.setPayGIEnabled (const Value: Boolean);begin chkPAYGI.checked := Value; end;
procedure TfmBASReturnOptions.setWnLEnabled (const Value: Boolean);begin chkWnL.checked := Value; end;
procedure TfmBASReturnOptions.setPayGWEnabled (const Value: Boolean);begin chkPAYGW.checked := Value;end;

initialization
  RegisterClassOnce(TfmBASReturnOptions);

end.

