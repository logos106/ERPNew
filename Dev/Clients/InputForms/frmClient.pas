unit frmClient;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls;

type
  TfmClient = class(TBaseInputGUI)
  private
  Protected
    procedure CommitTransaction; Override;
    Function ClientId :Integer;Virtual; abstract;
  public

  end;


implementation

uses AppEnvironment, BusObjClient;

{$R *.dfm}

{ TfmClient }

procedure TfmClient.CommitTransaction;
begin
  inherited;
  if appenv.companyprefs.MakeMcforClients then
    TClient.MakeMarketingcontact(Self, ConnInTrans , DoBusinessObjectEvent , ClientId);
end;

end.
