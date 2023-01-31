unit frmProductFormulaTypesforFormula;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmProductFormulaTypes, DB, ProgressDialog, MemDS, DBAccess,
  MyAccess, ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts,
  SelectionDialog, Menus, ExtCtrls, StdCtrls, DBCtrls, Mask, wwdbedit,
  DNMSpeedButton, Shader, DNMPanel;

type
  TfmProductFormulaTypesforFormula = class(TfmProductFormulaTypes)
    DNMPanel4: TDNMPanel;
    Label2: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
