unit frmPadPrintOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmPrintRepots, DB, ProgressDialog, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, DNMSpeedButton, Shader, StdCtrls, wwdblook, Grids, Wwdbigrd,
  Wwdbgrid, DNMPanel, DBCtrls , BusobjTemplateOptions;

type
  TfmPadPrintOptions = class(TfmPrintRepots)
  private
    { Private declarations }
  public
    class Procedure  DoPadPrintreports(AOwner:Tcomponent;aTemplatetype, aformname :string; OnPrint:TPrintTemplateEvent);
  end;


implementation

uses CommonLib;

{$R *.dfm}

{ TfmPadPrintOptions }


{ TfmPadPrintOptions }

class procedure TfmPadPrintOptions.DoPadPrintreports(AOwner: Tcomponent;  aTemplatetype, aformname: string; OnPrint: TPrintTemplateEvent);
var
  form : TfmPadPrintOptions;
begin
  form := TfmPadPrintOptions.Create(AOwner);
  try
    form.Printreports(aTemplatetype, aformname , OnPrint );
  finally
    Freeandnil(form);
  end;

end;

initialization
  RegisterClassOnce(TfmPadPrintOptions);

end.
