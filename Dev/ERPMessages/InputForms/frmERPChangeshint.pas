unit frmERPChangeshint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, Menus, ExtCtrls, StdCtrls, DNMSpeedButton, DNMPanel, Shader,
  SelectionDialog, ComCtrls, ad3RichEdit, rtflabel;

type
  TfmERPChangeshint = class(TBaseForm)
    DNMPanel1: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel2: TDNMPanel;
    GeneralNote: TRTFLabel;
    procedure cmdCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses CommonLib;

{$R *.dfm}

procedure TfmERPChangeshint.cmdCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;

end;
initialization
  RegisterClassOnce(TfmERPChangeshint);

end.
