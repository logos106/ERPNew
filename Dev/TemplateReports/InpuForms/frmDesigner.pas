unit frmDesigner;

interface

uses
  Windows , ComCtrls, SysUtils, Messages, Classes , Graphics, Controls,
  Forms   , Dialogs , StdCtrls, ExtCtrls, Grids   , DBGrids , DBCtrls, Db, DBTables,
  Buttons , Tabs    , IniFiles, Mask    ,
  ppViewr , ppTypes , ppForms , ppPrvDlg, ppUtils , ppEndUsr, ppReport,
  daDBBDE , ppBands , ppCache , ppClass , ppComm  , ppProd  , ppCTMain,
  ppCTDsgn, ppRelatv, ppDBPipe, ppPrnabl, ppCtrls , ppParameter, ppModule,
  {raCodMod,} ppVar   , ppDsgner ;


type
  TfmDesigner = class(TppDesignerWindow)
  private
    { Private declarations }
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  end;


implementation


{$R *.dfm}
{ TfmDesigner }

constructor TfmDesigner.Create(aOwner: TComponent);
begin
  inherited;

end;

destructor TfmDesigner.Destroy;
begin
  inherited;
end;

initialization
//  RegisterClassOnce(TfmDesigner);
end.
