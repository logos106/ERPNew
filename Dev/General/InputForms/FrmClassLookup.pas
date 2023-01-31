unit FrmClassLookup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, StdCtrls, wwdblook, wwcheckbox, ExtCtrls, DB, MemDS,
  DBAccess, MyAccess, ERPdbComponents, Menus, GuiPrefsObj , frmBaselistingSelectionLookup;

type
  TFmClassLookup = class(TfmBaselistingSelectionLookup)
    procedure FormCreate(Sender: TObject);
    procedure cboQryBeforeOpen(DataSet: TDataSet);
  private
  Protected
    function DefaultID :Integer; override;
  public
    Class Function  MakeInstance(AOwner:TComponent; AParent :TWIncontrol; fiLeft,fiTop, fiHeight:Integer;aAlign :TAlign;fGuiPrefs: TFormGuiPrefs;fOnSelection: TNotifyEvent;UseAll,SelectedID:Integer):TFmClassLookup;
  end;

implementation

uses AppEnvironment, CommonDbLib, CommonLib;

{$R *.dfm}

procedure TFmClassLookup.cboQryBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  cboQry.ParamByName('ShowInactive').AsBoolean := ShowInactive;
  cboQry.ParamByName('LookupID').AsInteger := LookupID;
end;

function TFmClassLookup.DefaultID: Integer;
begin
  result := Appenv.DefaultClass.ClassID;
end;

procedure TFmClassLookup.FormCreate(Sender: TObject);
begin
  inherited;
  lbltitle.Caption := Appenv.DefaultClass.ClassHeading;
end;


class Function  TFmClassLookup.MakeInstance(AOwner:TComponent; AParent :TWIncontrol; fiLeft,fiTop, fiHeight:Integer;aAlign :TAlign;fGuiPrefs: TFormGuiPrefs;fOnSelection: TNotifyEvent;UseAll,SelectedID:Integer):TFmClassLookup;
begin
  Result := TFmClassLookup.Create(AOwner);
  Result.InitInstance(AParent,fiLeft,fiTop, fiHeight,aAlign,fGuiPrefs,fOnSelection,UseAll,SelectedID);
end;

end.
