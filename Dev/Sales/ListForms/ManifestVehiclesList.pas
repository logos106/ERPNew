unit ManifestVehiclesList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, DBAccess, MyAccess,ERPdbComponents, MemDS,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, wwcheckbox;

type
  TManifestVehiclesListGUI = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainVehicleID: TIntegerField;
    qryMainVehicleName: TWideStringField;
    qryMainOwnerName: TWideStringField;
    qryMainDriver: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainRegistrationNo: TWideStringField;
    qryMainTrailer: TWideStringField;
    qryMainNotes: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainRate: TFloatField;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure cmdNewClick(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  Protected
    procedure SetGridColumns; Override;
  public
    { Public declarations }
  end;

implementation
  
uses frmManifestVehicles, CommonLib, Forms;
{$R *.dfm}

procedure TManifestVehiclesListGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Active' , ['T','F','']);
  inherited;
end;

procedure TManifestVehiclesListGUI.cmdNewClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := GetComponentByClassName('TManifestVehicleGUI');
  If not Assigned(tmpComponent) then Exit;
  with TManifestVehicleGUI(tmpComponent) do begin
    AttachObserver(Self);
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

procedure TManifestVehiclesListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  TFloatField(qryMain.FieldByName('Rate (%)')).DisplayFormat := '#.#%';
end;

procedure TManifestVehiclesListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainGlobalRef.Fieldname);
  RemoveFieldfromGrid(qryMainVehicleID.Fieldname);
end;

initialization
  RegisterClassOnce(TManifestVehiclesListGUI);
end.
