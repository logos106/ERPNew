unit ManifestRouteList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, DBAccess, MyAccess,ERPdbComponents, MemDS,
  wwdbdatetimepicker, ProgressDialog, kbmMemTable, 
  wwdblook, Shader, DAScript, MyScript, wwcheckbox;

type
  TManifestRouteListGUI = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainManifestRouteID: TIntegerField;
    qryMainFrom: TWideStringField;
    qryMainTo: TWideStringField;
    qryMainRouteDesc: TWideStringField;
    qryMainDistance: TIntegerField;
    qryMainPaletteRate: TFloatField;
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure cmdNewClick(Sender: TObject);
  private
  Protected
    procedure SetGridColumns; Override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  frmManifestRoute, CommonLib, Forms;

procedure TManifestRouteListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  TFloatField(qryMain.FieldByName('PaletteRate')).currency := true;
end;

procedure TManifestRouteListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainGlobalRef.FieldName);
  RemoveFieldfromGrid(qryMainManifestRouteID.FieldName);
end;

procedure TManifestRouteListGUI.cmdNewClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := GetComponentByClassName('TManifestRouteGUI');
  If not Assigned(tmpComponent) then Exit;
  with TManifestRouteGUI(tmpComponent) do begin
    AttachObserver(Self);
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

initialization
  RegisterClassOnce(TManifestRouteListGUI);
end.
