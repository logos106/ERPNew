unit BaseOleContainerViewer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, Shader, DNMPanel, OleCtnrs, DNMSpeedButton,
  AdvScrollBox;

type
  TBaseOleContainerViewerGUI = class(TBaseInputGUI)
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    cmdCancel: TDNMSpeedButton;
    mnuMax: TAdvPopupMenu;
    Maximize1: TMenuItem;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    pnlContainer: TAdvScrollBox;
    Container: TOleContainer;
  private
  Protected
    Procedure SetOpenOption;
  public

  end;
implementation

{$R *.dfm}

{ TBaseOleContainerViewerGUI }

procedure TBaseOleContainerViewerGUI.SetOpenOption;
begin
  Container.PopupMenu := mnuMax;
end;

end.
