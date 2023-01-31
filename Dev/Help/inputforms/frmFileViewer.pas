unit frmFileViewer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOleContainerViewer, ProgressDialog, DB, MemDS, DBAccess,
  MyAccess, ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts,
  SelectionDialog, Menus, ExtCtrls, Shader, DNMSpeedButton, OleCtnrs, DNMPanel,
  StdCtrls;

type
  TfmFileViewer = class(TBaseOleContainerViewerGUI)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses CommonLib;

{$R *.dfm}

initialization
  RegisterClassOnce(TfmFileViewer);

end.
