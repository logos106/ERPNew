unit frmStateFreightList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TfmStateFreightList = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainState: TWideStringField;
    qryMainPercent: TFloatField;
    qryMainFixedAmount: TFloatField;
    qryMainActive: TWideStringField;
    procedure qryMainBeforeOpen(DataSet: TDataSet);
    procedure cmdNewClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);override;
  private
  protected
    procedure ApplyQueryFilter; override;
  public
    { Public declarations }
  end;

implementation

uses
  AppEnvironment, frmStateFreightEdit, CommonLib;

{$R *.dfm}

procedure TfmStateFreightList.ApplyQueryFilter;
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin {Active}
        GroupFilterString := '(Active = "T")';
      end;
    1:
      begin {Inactive}
        GroupFilterString := '(Active = "T")';
      end;
    2:
      begin {All}
        GroupFilterString := '';
      end;
  end;
  inherited;

end;

procedure TfmStateFreightList.cmdNewClick(Sender: TObject);
var
  form: TfmStateFreightEdit;
begin
  inherited;
  form := TfmStateFreightEdit(GetComponentByClassName(TfmStateFreightEdit.ClassName));
  If not Assigned(form) then Exit;
  form.AttachObserver(Self);
  form.FormStyle := fsMDIChild;
  form.BringToFront;
end;

procedure TfmStateFreightList.grdMainDblClick(Sender: TObject);
begin
  inherited;
 //
end;

procedure TfmStateFreightList.qryMainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.Params.ParamByName('RegionID').AsInteger := AppEnv.RegionalOptions.ID;
end;

initialization
  RegisterClass(TfmStateFreightList);

end.
