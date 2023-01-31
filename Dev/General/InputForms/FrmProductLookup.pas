unit FrmProductLookup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBaselistingSelectionLookup, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, Menus, ExtCtrls, StdCtrls, wwdblook, GuiPrefsObj , wwcheckbox;

type
  TFmProductLookup = class(TfmBaselistingSelectionLookup)
    procedure FormCreate(Sender: TObject);
    procedure cboQryBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    Class Function  MakeInstance(AOwner:TComponent; AParent :TWIncontrol; fiLeft,fiTop, fiHeight:Integer;aAlign :TAlign;fGuiPrefs: TFormGuiPrefs;fOnSelection: TNotifyEvent;UseAll,SelectedID:Integer):TFmProductLookup;
  end;


implementation

uses AppEnvironment;

{$R *.dfm}

{ TFmProductLookup }

procedure TFmProductLookup.cboQryBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  cboQry.ParamByName('ShowInactive').AsBoolean := ShowInactive;
  cboQry.ParamByName('PartsId').AsInteger := LookupID;
end;

procedure TFmProductLookup.FormCreate(Sender: TObject);
begin
  inherited;
  lbltitle.Caption := AppEnv.DefaultClass.PartColumn;
end;

class function TFmProductLookup.MakeInstance(AOwner: TComponent;AParent: TWIncontrol; fiLeft, fiTop, fiHeight: Integer; aAlign: TAlign;fGuiPrefs: TFormGuiPrefs; fOnSelection: TNotifyEvent; UseAll,SelectedID: Integer): TFmProductLookup;
begin
  Result := TFmProductLookup.Create(AOwner);
  Result.InitInstance(AParent,fiLeft,fiTop, fiHeight,aAlign,fGuiPrefs,fOnSelection,UseAll,SelectedID);
end;

end.
