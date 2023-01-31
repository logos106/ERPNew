unit FrmWalmartBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, DNMPanel, Shader;

type
  TFmWalmartBase = class(TBaseInputGUI)
    pnlMain: TDNMPanel;
    pnlbottom: TDNMPanel;
    pnltop: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
  private
  Protected
    procedure LoginList(const Value: String; const ShowinList :Boolean = True);Virtual;
  public
    { Public declarations }
  end;


implementation

uses LogLib;

{$R *.dfm}
procedure TFmWalmartBase.LoginList(const Value: String; const ShowinList :Boolean = True);
begin
  Logtext(value );
end;

end.
