unit StsTransferPackageList;

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
  TTransferDirection = (trdOut, trdIn);

  TfrmTransferPackageList = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainSource: TWideStringField;
    qryMainDestination: TWideStringField;
    qryMainTransferType: TWideStringField;
    qryMainRoute: TWideStringField;
    qryMainEstDeparture: TDateTimeField;
    qryMainEstArrival: TDateTimeField;
    qryMainDriver: TWideStringField;
    qryMainCreateDate: TDateTimeField;
    qryDepartment: TERPQuery;
    lbDepartment: TLabel;
    qryDepartmentClassID: TIntegerField;
    qryDepartmentClassName: TWideStringField;
    qryMainDone: TWideStringField;
    qryMainDriverLicense: TWideStringField;
    dsDepartment: TDataSource;
    dblkcbbDepartment: TDBLookupComboBox;
    grpDirection: TwwRadioGroup;
    procedure cmdNewClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dblkcbbDepartmentCloseUp(Sender: TObject);
    procedure grpDirectionClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FDirection: TTransferDirection;
  private
    procedure SetQryMainSQL(ADirection: TTransferDirection);
  protected
    procedure SetGridColumns; override;
  public
    constructor Create(AOwner: TComponent; ADirection: TTransferDirection); reintroduce;
    Procedure RefreshQuery; override;
  end;


implementation

{$R *.dfm}

uses
  CommonLib, CommonFormLib, LogLib, frmStSTransferPackage;

{ TfrmTransferPackageList }

procedure TfrmTransferPackageList.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TfmStSTransferPackage' , 0);
end;

procedure TfrmTransferPackageList.cmdPrintClick(Sender: TObject);
const
  cMain    = '{Main}SELECT * FROM tblststransferpackage WHERE ID=%d';
  cSrcDep  = '{SrcDep}SELECT stc.ClassId, stc.LicenseNumber, stc.PrincipleContactPhone FROM tblstsclass stc INNER JOIN tblclass tc ON stc.ClassId=tc.ClassId WHERE stc.ClassId=%d';
  cDestDep = '{DestDep}SELECT stc.ClassId, stc.LicenseNumber, stc.PrincipleContactPhone FROM tblstsclass stc INNER JOIN tblclass tc ON stc.ClassId=tc.ClassId WHERE stc.ClassId=%d';
  cVehicle = '{Vehicle}SELECT AssetID, CONCAT_WS(", ", Manufacture, Model, Serial) AS ConcatData FROM tblfixedassets WHERE (PartName="STSVEHICLE") AND (AssetID=%d)';
  cDriver  = '{Driver}SELECT EmployeeID, CONCAT_WS(" ", FirstName, MiddleName, LastName) AS Name, COALESCE(CUSTFLD1, "") AS DriverLic, COALESCE(Mobile, Phone, AltPhone, "") AS DriverPhone FROM tblemployees WHERE EmployeeID=%d';
  cDetail  = '{Detail}SELECT TPL.*, P.PackageName FROM tblststransferpackagelines TPL LEFT JOIN tblstspackage P ON TPL.PackageID = P.ID  WHERE TPL.TransferID=%d';
var
  sSQL, sMain, sSrcDep, sDestDep, sVehicle, sDriver, sDetail: string;
  iID, iSrcDep, iDestDep, iVehicle, iDriver: Integer;
begin

  if qryMain.RecordCount = 0 then begin
    MessageDlgXP_Vista('No print data', mtInformation, [mbOK], 0);
    Exit;
  end;

  iID := 0; iSrcDep := 0; iDestDep := 0; iVehicle := 0; iDriver := 0;

  with qryMain do begin
    if not FieldByName('ID').IsNull           then iID      := FieldByName('ID').AsInteger;
    if not FieldByName('SourceDeptID').IsNull then iSrcDep  := FieldByName('SourceDeptID').AsInteger;
    if not FieldByName('DestDeptID').IsNull   then iDestDep := FieldByName('DestDeptID').AsInteger;
    if not FieldByName('VehicleID').IsNull    then iVehicle := FieldByName('VehicleID').AsInteger;
    if not FieldByName('DriverID').IsNull     then iDriver  := FieldByName('DriverID').AsInteger;
  end;

  sMain    := Format(cMain,    [iID]);
  sSrcDep  := Format(cSrcDep,  [iSrcDep]);
  sDestDep := Format(cDestDep, [iDestDep]);
  sVehicle := Format(cVehicle, [iVehicle]);
  sDriver  := Format(cDriver,  [iDriver]);
  sDetail  := Format(cDetail,  [iID]);

  sSQL := Format('%s~|||~%s~|||~%s~|||~%s~|||~%s~|||~%s', [sMain, sSrcDep, sDestDep, sVehicle, sDriver, sDetail]);

  PrintTemplate.ReportSQLSupplied := True;
  PrintTemplate.ShowCancelPreviewBtninReportPreview := True;
  PrintTemplate.PrintTemplateReport('StsTransferManifest', sSQL, False, 1);

end;

constructor TfrmTransferPackageList.Create(AOwner: TComponent; ADirection: TTransferDirection);
begin
  inherited Create(AOwner);
  FDirection := ADirection;
end;

procedure TfrmTransferPackageList.dblkcbbDepartmentCloseUp(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfrmTransferPackageList.FormCreate(Sender: TObject);
begin
  inherited;
  FormColor := clWhite;
end;

procedure TfrmTransferPackageList.FormShow(Sender: TObject);
begin
  inherited;

  with TitleShader do begin
    FromColor       := clWhite;
    FromColorMirror := clWhite;
    ToColor         := clWhite;
    ToColorMirror   := clWhite;
  end;

  with qryDepartment do begin
    if Active and (RecordCount > 0) then begin
      First;
      dblkcbbDepartment.KeyValue := FieldByName('ClassID').AsInteger;
    end;
  end;

  grpDirection.ItemIndex := Ord(FDirection);
end;

procedure TfrmTransferPackageList.grdMainDblClick(Sender: TObject);
var
  Mode:        TTransferMode;
  idTransfer:  Integer;
  frmTransfer: TfmStSTransferPackage;
begin
  if qryMain.RecordCount > 0 then
  begin
    idTransfer := qryMain.FieldByName('ID').AsInteger;

    Mode := trmdNewOut;
    case FDirection of
      trdIn:  Mode := trmdIn;
      trdOut: Mode := trmdOut;
    end;

    frmTransfer := TfmStSTransferPackage.Create(nil, Mode, idTransfer);
    try
      frmTransfer.ShowModal;
    finally
      FreeAndNil(frmTransfer);
    end;
  end;
end;

procedure TfrmTransferPackageList.grpDirectionClick(Sender: TObject);
begin
  inherited;
  FDirection := TTransferDirection(grpDirection.ItemIndex);
  RefreshQuery;
end;

procedure TfrmTransferPackageList.grpFiltersClick(Sender: TObject);
begin
  RefreshQuery;
end;

procedure TfrmTransferPackageList.RefreshQuery;
var
  iDep: Integer;
  sParamName: string;
begin
  case FDirection of
    trdIn:
      begin
        TitleLabel.Caption   := 'Incoming transfers';
        lbDepartment.Caption := 'Destination';
      end;

    trdOut:
      begin
        TitleLabel.Caption   := 'Outgoing transfers';
        lbDepartment.Caption := 'Source';
      end;
  end;

  OpenDB(qryDepartment);
  SetQryMainSQL(FDirection);
  InitDateFromnDateTo;

  case FDirection of
    trdIn:  sParamName := 'DestDeptID';
    trdOut: sParamName := 'SourceDeptID';
  end;

  Assert(Length(sParamName) > 0,               'ParamName is expected to be non-empty');
  Assert(qryMain.FindParam(sParamName) <> nil, 'Expecting qryMain has param ' + sParamName);
  Assert(qryDepartment.Active,                 'Expected qryDepartment is Active');

  iDep := 0;
  with qryDepartment do begin
    if Active and (RecordCount > 0) and not FieldByName('ClassID').IsNull then
      iDep := FieldByName('ClassID').AsInteger;
  end;

  qryMain.ParamByName(sParamName).AsInteger := iDep;

  Assert(Length(Trim(qryMain.SQL.Text)) > 0, 'Expecting qryMain.SQL.Text has content');
  inherited;
end;

procedure TfrmTransferPackageList.SetGridColumns;
begin
  inherited;
end;

procedure TfrmTransferPackageList.SetQryMainSQL(ADirection: TTransferDirection);
const
  cSelect = 'SELECT T.ID, T.Done, S.ClassName AS Source, D.ClassName AS Destination, T.TransferType, T.Route, T.EstDeparture, T.EstArrival,' +
            'CONCAT_WS(" ", E.FirstName, E.MiddleName, E.LastName) AS Driver, ' +
            'COALESCE(E.CUSTFLD1, "") AS DriverLicense,' +
            'CONCAT_WS(" ", FA.Manufacture, FA.Model, FA.Serial) AS Vehicle,' +
            'T.msTimeStamp AS CreateDate ' +
            'FROM tblststransferpackage T ' +
            'LEFT JOIN tblClass S ON T.SourceDeptID = S.ClassID ' +
            'LEFT JOIN tblClass D ON T.DestDeptID   = D.ClassID ' +
            'LEFT JOIN tblEmployees E ON T.DriverID = E.EmployeeID ' +
            'LEFT JOIN tblFixedAssets FA ON T.VehicleID = FA.AssetID '  +
            'WHERE T.msTimeStamp BETWEEN :DateFrom and :DateTo AND %s %s ' +
            'ORDER BY T.ID DESC;';
var
  sCondition1, sCondition2: string;
begin
  case ADirection of
    trdIn:  sCondition1 :=  ' T.DestDeptID   = :DestDeptID ';
    trdOut: sCondition1 :=  ' T.SourceDeptID = :SourceDeptID ';
  end;

  case grpFilters.ItemIndex of
    -1, 2: sCondition2 := ''; // all
     0:    sCondition2 := ' AND T.Done = "F"'; // not completed
     1:    sCondition2 := ' AND T.Done = "T"'; // completed
  end;

  qryMain.SQL.Text := Format(cSelect, [sCondition1, sCondition2]);
  Logtext(Format('TfrmTransferPackageList.SetQryMainSQL: %s', [qryMain.SQL.Text]),'', True);
end;

initialization
  RegisterClassOnce(TfrmTransferPackageList);

end.
