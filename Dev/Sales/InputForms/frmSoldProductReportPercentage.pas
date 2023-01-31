unit frmSoldProductReportPercentage;

{ Date     Version Who  What
 -------- -------- ---  --------------------------------------------------------
 30/05/06  1.00.01  AL  Initial Version

 }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DBAccess, MyAccess,ERPdbComponents,
  SelectionDialog, AppEvnts, DB,  ExtCtrls, StdCtrls, DNMSpeedButton,
  wwdbedit, Wwdbspin, Mask, AdvSpin, DBAdvSp, DNMPanel, Shader, ImgList,
  MemDS;

type
  TReportPercentage = class(TBaseInputGUI)
    Label1: TLabel;
    Label2: TLabel;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Bevel1: TBevel;
    edtRP: TEdit;
    edtPL: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure edtRPKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ReportPercentage: TReportPercentage;

implementation

uses CommonLib;

{$R *.dfm}

procedure TReportPercentage.edtRPKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not CharInSet(Key,['0','1','2','3','4','5','6','7','8','9',#8]) then
    Key := #0;
end;

initialization
  RegisterClassOnce(TReportPercentage);

end.
