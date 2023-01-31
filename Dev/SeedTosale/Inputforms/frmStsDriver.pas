unit frmStsDriver;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmEmployeeInfo, DB, ProgressDialog, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, Wwdotdot, Wwdbcomb, StdCtrls, wwclearbuttongroup,
  wwradiogroup, wwdbdatetimepicker, wwdbedit, Mask, DBCtrls,
  DNMSpeedButton, Shader, DNMPanel;

type
  TfrmStsDriverInfo = class(TfmEmployeeInfo)
    pnlDriver: TDNMPanel;
    lbDriverLic: TLabel;
    dbedtDriverLic: TDBEdit;
    QryemployeeCUSTFLD1: TWideStringField;
    QryemployeeCUSTFLD2: TWideStringField;
    dbedtIsDriver: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}


procedure TfrmStsDriverInfo.FormCreate(Sender: TObject);
begin
  inherited;
  FormColor := $0091C8FF;
end;

procedure TfrmStsDriverInfo.FormShow(Sender: TObject);
begin
  inherited;

  with TitleShader do begin
    FromColor       := clWhite;
    FromColorMirror := clWhite;
    ToColor         := clWhite;
    ToColorMirror   := clWhite;
  end;

end;

end.
