unit frmPayFormsBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  Menus, ExtCtrls, StdCtrls, BaseInputForm, ProgressDialog, DB, MemDS,
  DBAccess, MyAccess, ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts,
  SelectionDialog;

type
  TfmPayFormsBase = class(TBaseInputGUI)
    procedure FormCreate(Sender: TObject);
  private
  Protected
  public
  end;


implementation

{$R *.dfm}

{ TfmPayFormsBase }

procedure TfmPayFormsBase.FormCreate(Sender: TObject);
begin
  AllowCustomiseGrid := False;
  inherited;
end;

end.
