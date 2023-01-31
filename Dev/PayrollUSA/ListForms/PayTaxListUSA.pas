unit PayTaxListUSA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, wwexport, GIFImg;

type
  TPayTaxListGUI2 = class(TBaseListingGUI)
    qryDetail: TERPQuery;
    dsDetail: TDataSource;
    grdDetail: TwwDBGrid;
    wwIButton1: TwwIButton;
    ebnDetail: TwwExpandButton;
    qryDetailDP: TWideStringField;
    qryDetailCheckNum: TLargeintField;
    qryDetailGrossWage: TFloatField;
    qryDetailSocWage: TFloatField;
    qryDetailSocTax: TFloatField;
    qryDetailMedWage: TFloatField;
    qryDetailMedTax: TFloatField;
    qryMainDetail: TWideStringField;
    qryMainEmployeeName: TWideStringField;
    qryMainEmployeeID: TIntegerField;
    qryMainTotalTaxWithheld: TFloatField;
    qryMainAllowances: TFloatField;
    qryMainOther: TFloatField;
    qryMainGrossPayments: TFloatField;
    qryMainDeductions: TFloatField;
    qryMainUnionFees: TFloatField;
    qryMainTotalEmployeeTax: TFloatField;
    qryMainTotalCompanyTax: TFloatField;
    btnPrintDetail: TDNMSpeedButton;
    btnExportDetail: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure ebnDetailBeforeExpand(Sender: TObject);
    procedure btnPrintDetailClick(Sender: TObject);
    procedure btnExportDetailClick(Sender: TObject);

  private
    procedure MakeQryMain;
    procedure DoExportDetail(const Exportfilename: String);
    function ExportDataFileName: string;

  protected
    procedure RefreshQuery; override;
    Procedure RefreshTotals; override;

  public
    { Public declarations }
  end;

var
  PayTaxListGUI: TPayTaxListGUI2;

implementation

uses
  DbSharedObjectsObj, AppEnvironment, CommonLib, CommonDbLib, FastFuncs,
  tcConst, SystemLib;

{$R *.dfm}

{ TPayTaxListGUI2 }

procedure TPayTaxListGUI2.FormCreate(Sender: TObject);
begin
  inherited;

  MakeQryMain;

  AddCalcColumn(qryMainTotalTaxWithheld.FieldName, true);
  AddCalcColumn(qryMainAllowances.FieldName, true);
  AddCalcColumn(qryMainOther.FieldName, true);
  AddCalcColumn(qryMainGrossPayments.FieldName, true);
  AddCalcColumn(qryMainDeductions.FieldName, true);
  AddCalcColumn(qryMainUnionFees.FieldName, true);
  AddCalcColumn(qryMainTotalEmployeeTax.FieldName, true);
  AddCalcColumn(qryMainTotalCompanyTax.FieldName, true);

  grdDetail.TitleColor := Self.Color;
  grdDetail.FooterColor := Self.Color;
end;

procedure TPayTaxListGUI2.MakeQryMain;
var
  qry: TERPQuery;
  tbl: string;
begin
  qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Add('SELECT * FROM tblpaytaxconfig');
    qry.SQL.Add('WHERE RegionId = ' + IntToStr(AppEnv.RegionalOptions.Id));
    qry.SQL.Add('AND Active = "T"');
    qry.Open;

    qryMain.SQL.Clear;
    qryMain.SQL.Add('SELECT');
    qryMain.SQL.Add('"Exp" AS Detail, ');
    qryMain.SQL.Add('e.EmployeeName AS EmployeeName, e.EmployeeID AS EmployeeID, ');
    qryMain.SQL.Add('SUM(P.Tax) AS TotalTaxWithheld, ');
    qryMain.SQL.Add('SUM(P.Allowances) AS Allowances,');
    qryMain.SQL.Add('SUM(P.Commission) + IF(SUN.TaxExempt = "F", Sum(SUN.Amount), 0) AS Other,') ;
    qryMain.SQL.Add('SUM(P.Wages) - Sum(P.CDEPGross) + SUM(P.Commission) AS GrossPayments,');
    qryMain.SQL.Add('SUM(IF(PD.IsWorkPlacegiving = "F" AND PD.UnionFees = "F", PD.Amount, 0)) AS Deductions,');
    qryMain.SQL.Add('SUM(IF(PD.IsWorkPlacegiving = "F" AND PD.UnionFees = "T", PD.Amount, 0)) AS UnionFees,');
    qryMain.SQL.Add('SUM(IF(PD.IsWorkPlacegiving = "T", PD.Amount, 0)) AS WorkPlacegiving,');
    qryMain.SQL.Add('SUM(p.Tax) as TotalEmployeeTax,');
    qryMain.SQL.Add('SUM(p.CompanyTax) as TotalCompanyTax');
    while not qry.EOF do begin
      tbl := 't' + IntToStr(qry.FieldByName('Id').AsInteger);
      qryMain.SQL.Add(',sum('+tbl+'.Amount) as `' + qry.FieldByName('TaxName').AsString + '`');
      qry.Next;
    end;
    qryMain.SQL.Add('FROM tblpays p');
    qryMain.SQL.Add('INNER JOIN tblemployees e on e.EmployeeID = p.EmployeeID');
    qryMain.SQL.Add('LEFT JOIN tblpaysdeductions AS PD on P.PayID = PD.PayID');
    qryMain.SQL.Add('LEFT JOIN tbldeductions AS D on D.DeductionID = PD.DeductionID');
    qryMain.SQL.Add('LEFT JOIN tblpayssundries AS SUN on P.PayID = SUN.PayID');
    qry.First;
    while not qry.EOF do begin
      tbl := 't' + IntToStr(qry.FieldByName('Id').AsInteger);
      qryMain.SQL.Add('LEFT JOIN tblpaytax ' + tbl + ' ON ' + tbl + '.PayTaxConfigId = ' +
        IntToStr(qry.FieldByName('Id').AsInteger) + ' AND ' + tbl + '.PayId = p.PayId');
      qry.Next;
    end;
    qryMain.SQL.Add('WHERE p.Paid = "T"');
    qryMain.SQL.Add('AND p.Deleted = "F"');
    qryMain.SQL.Add('AND (p.PayDate BETWEEN :dtFrom AND :dtTo)');
    qryMain.SQL.Add('GROUP BY e.EmployeeID');
    qryMain.SQL.Add('ORDER BY e.EmployeeName');

    RefreshOrignalSQL;

    qry.First;
    while not qry.Eof do begin
      with TFloatField.Create(Self) do begin
        Currency := True;
        fieldKind := fkData;
        fieldname := qry.FieldByName('TaxName').AsString;
        AddCalcColumn(fieldName, true);
        name := ComponentName(self, ReplaceStr(ReplaceStr('qryMain' + fieldname, '-','_'),' ','_'));
        DisplayLabel := qry.FieldByName('TaxName').AsString;
        DataSet := qryMain;
        visible := True;
      end;
      qry.Next;
    end;

  finally
    DbSharedObj.ReleaseObj(qry);
  end;

end;

procedure TPayTaxListGUI2.RefreshQuery;
begin
  if chkIgnoreDates.Checked then begin
    qryMain.ParamByName('dtFrom').AsDate := 0;
    qryMain.ParamByName('dtTo').AsDate := SysUtils.MaxDateTime;

    qryDetail.ParamByName('dtFrom').AsDate := 0;
    qryDetail.ParamByName('dtTo').AsDate := SysUtils.MaxDateTime;
  end
  else begin
    qryMain.ParamByName('dtFrom').AsDate := dtFrom.Date;
    qryMain.ParamByName('dtTo').AsDate := dtTo.Date;

    qryDetail.ParamByName('dtFrom').AsDate := dtFrom.Date;
    qryDetail.ParamByName('dtTo').AsDate := dtTo.Date;
  end;

  inherited;
end;

procedure TPayTaxListGUI2.RefreshTotals;
begin
  inherited;
  CalcnShowfooter;
end;

procedure TPayTaxListGUI2.btnExportDetailClick(Sender: TObject);
var
  fsFilename:String;
begin
  fsFilename:='';
  if AppEnv.CompanyPrefs.UseERPFilenameforDataExport then begin
    fsFilename := Exportdatafilename;
  end else begin
    dlgSave.Title := 'Export - ' + Caption;
    if dlgSave.Execute then fsFilename := dlgSave.FileName;
  end;
  if fsFilename <> '' then DoExportDetail(fsFilename);

end;

procedure TPayTaxListGUI2.btnPrintDetailClick(Sender: TObject);
begin
  dlgPrint.ObjectToPrint := grdDetail;
  dlgPrint.Print;
  dlgPrint.ObjectToPrint := grdMain;
end;

procedure TPayTaxListGUI2.ebnDetailBeforeExpand(Sender: TObject);
begin
  inherited;

  qryDetail.Close;
  qryDetail.ParamByName('empId').AsInteger := qryMainEmployeeID.AsInteger;
  qryDetail.Open;
end;

Procedure TPayTaxListGUI2.DoExportDetail(const Exportfilename: string);
var
  sFileExt: string;
begin
  grdDetail.ExportOptions.FileName := Exportfilename;
  grdDetail.ExportOptions.TitleName := Self.Caption;
  sFileExt := ExtractFileExt(Exportfilename);
  if SysUtils.SameText(FastFuncs.LowerCase(sFileExt), '.txt') then begin
    grdDetail.ExportOptions.ExportType := wwgetTxt;
    grdDetail.ExportOptions.Delimiter := #9;
  end
  else if SysUtils.SameText(FastFuncs.LowerCase(sFileExt), '.csv') then begin
    grdDetail.ExportOptions.ExportType := wwgetTxt;
    grdDetail.ExportOptions.Delimiter := ',';
  end
  else if SysUtils.SameText(FastFuncs.LowerCase(sFileExt), '.slk') then begin
    grdDetail.ExportOptions.ExportType := wwgetSYLK;
  end
  else if SysUtils.SameText(FastFuncs.LowerCase(sFileExt), '.html') then begin
    grdDetail.ExportOptions.ExportType := wwgetHTML;
  end else begin
    CommonLib.MessageDlgXP_Vista('Unsupported Export Format.' + #13 + #10 + '' + #13 + #10 + 'Defaulted To Text (*.TXT) Format Export.', mtWarning, [mbOK], 0);
    grdDetail.ExportOptions.ExportType := wwgetTxt;
    grdDetail.ExportOptions.Delimiter := #9;
  end;
  Enabled := false;
  ExportDialog.Caption := 'Exporting ' + ReplaceStr(TitleLabel.Caption, '&&', '&');
  ExportDialog.Execute;
  try
    //Exporting := True;
    try
      DoBeforeExport;
      try
        try
          grdDetail.ExportOptions.Save;
        Except
          on E:Exception do begin
            if pos('Out of Memory', E.message) > 0 then begin
              if MessageDlgXP_Vista('List Export Caused Out of Memory Error. Do you want to Try Dataset Export?', mtConfirmation, [mbYes, mbNo], 0) = mrok then DoGridExport;
            end else MessageDlgXP_Vista('List Export Caused Out of Memory Error.' + NL + NL + E.message, mtWarning, [mbOK], 0);
          end;
        end;
      finally
        DoAfterExport(Exportfilename);
      end;
    except
      on e: exception do begin
        if e is EFCreateError then begin
          CommonLib.MessageDlgXP_Vista(e.Message, mtWarning, [mbOK], 0);
        end
        else begin
          if Pos('Out of memory',e.Message) > 0 then begin
            CommonLib.MessageDlgXP_Vista('Out of memory.', mtWarning, [mbOK], 0);
          end;
        end;
      end;
//        on e: EFCreateError do begin
//          CommonLib.MessageDlgXP_Vista(e.Message, mtWarning, [mbOK], 0);
//        end;
    end;
  finally
    enabled := True;
    ExportDialog.CloseDialog;
//      Exporting := false;
  end;
end;

function TPayTaxListGUI2.ExportDataFileName: string;
begin
  Result := Self.Classname;
  if sametext(copy(result, 1, 1), 'T') then result := copy(result, 2, length(result));
  if sametext(copy(result, length(result) - 2, 3) ,'GUI') then result := copy(result, 0, length(result)-3)
  else if sametext(copy(result, length(result)-3,4) ,'LIST') then result := copy(result, 0, length(result)-4);
  Result := Result + '_' + FormatDateTime('dd-mm-yy_hh-nn-ss-zzz', now);
  Result := Result + '.' + AppEnv.CompanyPrefs.DataExportDefaultExtension;
  Result := GetMyDocumentsDir + Result;
end;

initialization
  RegisterClass(TPayTaxListGUI2);

end.
