unit FrmEmployeeLookup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, StdCtrls, wwdblook, wwcheckbox, ExtCtrls, DB, MemDS,
  DBAccess, MyAccess, ERPdbComponents, Menus, GuiPrefsObj , frmBaselistingSelectionLookup;

type
  TFmEmployeeLookup = class(TfmBaselistingSelectionLookup)
    procedure cboQryBeforeOpen(DataSet: TDataSet);
  private
  Protected
    function DefaultID :Integer; override;
  public
    Class Function  MakeInstance(AOwner:TComponent; AParent :TWIncontrol; fiLeft,fiTop, fiHeight:Integer;aAlign :TAlign;fGuiPrefs: TFormGuiPrefs;fOnSelection: TNotifyEvent;UseAll,selectedID:Integer):TFmEmployeeLookup;
  end;

implementation

uses AppEnvironment, CommonDbLib, CommonLib;

{$R *.dfm}

procedure TFmEmployeeLookup.cboQryBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  cboqry.ParamByName('ShowInactive').AsBoolean := ShowInactive;
  cboqry.ParamByName('lookupID').AsInteger := LookupID;
end;

function TFmEmployeeLookup.DefaultID: Integer;
begin
  result := Appenv.Employee.EmployeeID;
end;

class Function  TFmEmployeeLookup.MakeInstance(AOwner:TComponent; AParent :TWIncontrol; fiLeft,fiTop, fiHeight:Integer;aAlign :TAlign;fGuiPrefs: TFormGuiPrefs;fOnSelection: TNotifyEvent;UseAll,selectedID:Integer):TFmEmployeeLookup;
begin
  Result := TFmEmployeeLookup.Create(AOwner);
  Result.InitInstance(AParent,fiLeft,fiTop, fiHeight,aAlign,fGuiPrefs,fOnSelection,UseAll,SelectedID);
end;

end.
