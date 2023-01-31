unit StsPackageList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls,
  ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook,
  DNMSpeedButton, wwclearbuttongroup, wwradiogroup, Shader, GIFImg,
  DNMPanel, DBCtrls;

type
  TfrmStsPackageList = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainClassName: TWideStringField;
    qryMainStsTag: TWideStringField;
    qryMainPackageName: TWideStringField;
    qryMainPackageDate: TDateTimeField;
    lbDepartment: TLabel;
    dblkcbbDepartment: TDBLookupComboBox;
    qryDepartment: TERPQuery;
    qryDepartmentClassName: TWideStringField;
    qryDepartmentClassID: TIntegerField;
    dsDepartment: TDataSource;
    qryMainPackageType: TIntegerField;
    procedure FormShow(Sender: TObject);
    procedure dblkcbbDepartmentCloseUp(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);
  private
    procedure SetQryMainSQL;
  protected
    procedure SetGridColumns; override;
  public
    procedure RefreshQuery; override;
  end;


implementation

{$R *.dfm}

uses
  CommonLib, CommonFormLib, LogLib, frmStSCreatePackage;

procedure TfrmStsPackageList.dblkcbbDepartmentCloseUp(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfrmStsPackageList.FormShow(Sender: TObject);
begin
  inherited;

  with TitleShader do begin
    FromColor       := clWhite;
    FromColorMirror := clWhite;
    ToColor         := clWhite;
    ToColorMirror   := clWhite;
  end;

  cmdNew.Visible := False;

  TitleLabel.Caption := 'Package List';

  with qryDepartment do begin
    if Active and (RecordCount > 0) then begin
      First;
      dblkcbbDepartment.KeyValue := FieldByName('ClassID').AsInteger;
    end;
  end;
end;

procedure TfrmStsPackageList.grdMainDblClick(Sender: TObject);
var
  Mode:       TStSCreatePackageMode;
  idPackage:  Integer;
  frmPackage: TfmStSCreatePackage;
begin
  if qryMain.RecordCount > 0 then
  begin
    idPackage := qryMain.FieldByName('ID').AsInteger;

    Mode := modeUnknown;
    if not qryMain.FieldByName('PackageType').IsNull then
      Mode := TStSCreatePackageMode(qryMain.FieldByName('PackageType').AsInteger);

    frmPackage := TfmStSCreatePackage.Create(nil, Mode, idPackage);
    try
      frmPackage.ShowModal;
    finally
      FreeAndNil(frmPackage);
    end;
  end;
end;

procedure TfrmStsPackageList.RefreshQuery;
var
  iDep: Integer;
begin
  OpenDB(qryDepartment);
  SetQryMainSQL;
  InitDateFromnDateTo;

  iDep := 0;
  with qryDepartment do begin
    if Active and (RecordCount > 0) and not FieldByName('ClassID').IsNull then
      iDep := FieldByName('ClassID').AsInteger;
  end;

  qryMain.ParamByName('ClassID').AsInteger := iDep;
  inherited;
end;

procedure TfrmStsPackageList.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('PackageType');
end;

procedure TfrmStsPackageList.SetQryMainSQL;
const
  cSelect = 'SELECT P.ID, S.StsTag, P.PackageName, P.PackageDate, C.ClassName, P.PackageType ' +
            'FROM tblstspackage P ' + '' +
            '     INNER JOIN tblststags S ON P.StsTagsID = S.ID ' +
            '     INNER JOIN tblclass C ON S.DeptID = C.ClassID ' +
            'WHERE P.PackageDate BETWEEN :DateFrom and :DateTo AND (C.ClassID=:ClassID) ' +
            'ORDER BY P.PackageDate DESC, P.ID DESC;';
begin
  qryMain.SQL.Text := cSelect;
end;

initialization
  RegisterClassOnce(TfrmStsPackageList);

end.
