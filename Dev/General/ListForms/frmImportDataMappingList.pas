unit frmImportDataMappingList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, CustomInputBox, wwcheckbox;

type
  TfmImportDataMappingList = class(TBaseListingGUI)
    qryMainImportDataMapID: TIntegerField;
    qryMainImportName: TWideStringField;
    qryMainImportFileName: TWideStringField;
    qryMainTypeName: TWideStringField;
    qryMainActive: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject); override;
  private
    { Private declarations }
  public
    Procedure RefreshQuery;Override;
  end;

implementation

{$R *.dfm}

uses
  frmImportDataMapping, CommonLib;

procedure TfmImportDataMappingList.cmdNewClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  DisableForm;
  try
    inherited;
    tmpComponent := GetComponentByClassName('TfmImportDataMapping');
    If not Assigned(tmpComponent) then Exit;
    with TfmImportDataMapping(tmpComponent) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfmImportDataMappingList.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields(
    'ImportDataMapID');
end;

procedure TfmImportDataMappingList.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Active' , ['T','F','']);
  inherited;

end;

procedure TfmImportDataMappingList.RefreshQuery;
begin
  if devmode then
        Qrymain.ParamByName('Devmode').AsString := 'T'
  else  Qrymain.ParamByName('Devmode').AsString := 'F';
  inherited;
end;

initialization
  RegisterClass(TfmImportDataMappingList);

end.
