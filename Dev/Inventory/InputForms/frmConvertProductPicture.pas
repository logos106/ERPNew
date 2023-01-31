unit frmConvertProductPicture;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, Menus, ExtCtrls, StdCtrls, DNMSpeedButton, Shader, DNMPanel;

type
  TfmConvertProductPicture = class(TfrmBaseGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    cbofrom: TComboBox;
    cboTo: TComboBox;
    Label3: TLabel;
    btnClose: TDNMSpeedButton;
    btnCompleted: TDNMSpeedButton;
    procedure btnCompletedClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    function getConvertFromType: String;
    function getConvertToType: String;
    procedure setConvertFromType(const Value: String);
    procedure setConvertToType(const Value: String);

  public
    Property ConvertFromType :String read getConvertFromType write setConvertFromType;
    Property ConvertToType :String read getConvertToType write setConvertToType;
  end;
implementation
uses CommonLib;

{$R *.dfm}

{ TfmConvertProductPicture }

procedure TfmConvertProductPicture.btnCloseClick(Sender: TObject);
begin
  inherited;
  modalresult := mrCancel;
end;

procedure TfmConvertProductPicture.btnCompletedClick(Sender: TObject);
begin
  inherited;
  if trim(Cbofrom.Text)='' then begin
    MessageDlgXP_Vista('Please Select a Image Type to ''Convert from''', mtWarning, [mbOK], 0);
    Setcontrolfocus( Cbofrom);
    Exit;
  end;
  if trim(cboto.Text)='' then begin
    MessageDlgXP_Vista('Please Select a Image Type to ''Convert to''', mtWarning, [mbOK], 0);
    Setcontrolfocus( Cboto);
    Exit;
  end;
  if Sametext(cbofrom.Text , cboto.Text) then begin
    MessageDlgXP_Vista('Please Select different Image Types to ''Convert from'' and ''Convert to''', mtWarning, [mbOK], 0);
    Setcontrolfocus( Cbofrom);
    Exit;
  end;
  modalresult := mrok;
end;

function TfmConvertProductPicture.getConvertFromType: String;begin  result := cboFrom.Text ;end;
function TfmConvertProductPicture.getConvertToType: String;begin  result := cboTo.Text;end;
procedure TfmConvertProductPicture.setConvertFromType(const Value: String);begin  cbofrom.Text :=Value;end;
procedure TfmConvertProductPicture.setConvertToType(const Value: String);begin  cboto.Text :=Value;end;

end.

