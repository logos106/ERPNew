unit frmPadChooseSimpletype;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmChooseSimpletype, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  SelectionDialog, Menus, ExtCtrls, StdCtrls, Shader, DNMSpeedButton, DNMPanel,
  ProgressDialog, ImgList, AdvMenus, DataState, AppEvnts;

type
  TfmPadChooseSimpletype = class(TfmChooseSimpletype)
  private
  public
    Class Procedure DoChooseSimpletype(AOwner:TComponent; Var   aDescription  , aSimpletype:String ; const aSimpletypeCode:String; ahasDescription :Boolean);
  end;


implementation

{$R *.dfm}

{ TfmPadChooseSimpletype }

class procedure TfmPadChooseSimpletype.DoChooseSimpletype(AOwner: TComponent;  var aDescription, aSimpletype: String; const aSimpletypeCode: String;  ahasDescription: Boolean);
var
  form :TfmPadChooseSimpletype;
begin
  form := TfmPadChooseSimpletype.Create(AOwner);
  try
      Form.ChooseSimpletype(aDescription,  aSimpletype, aSimpletypeCode, ahasDescription);
  finally
    Freeandnil(form);
  end;


end;

end.
