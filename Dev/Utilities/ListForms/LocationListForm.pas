unit LocationListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB, 
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, StdCtrls, ExtCtrls, ComCtrls,AdvOfficeStatusBar,
  DBAccess, MyAccess,ERPdbComponents, MemDS, wwDialog, Wwlocate,
  SelectionDialog, DNMPanel, wwdbdatetimepicker, ProgressDialog,
   wwdblook, Shader, kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox;

type
  TLocationListGUI = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainLocationID: TIntegerField;
    qryMainCity_Sub: TWideStringField;
    qryMainState: TWideStringField;
    qryMainPostcode: TWideStringField;
    qryMainCountry: TWideStringField;
    qryMainCode: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure qryMainBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses frmLocationFrm, CommonLib,  AppEnvironment;
{$R *.dfm}

procedure TLocationListGUI.cmdNewClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := GetComponentByClassName('TfrmLocation');
  If not Assigned(tmpComponent) then Exit;
  with TfrmLocation(tmpComponent) do begin
    AttachObserver(Self);
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

procedure TLocationListGUI.qryMainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.Params.ParamByName('xRegionID').AsInteger := AppEnv.RegionalOptions.ID;
end;

initialization
  RegisterClassOnce(TLocationListGUI);
end.

