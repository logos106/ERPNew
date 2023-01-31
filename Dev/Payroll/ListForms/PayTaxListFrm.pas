unit PayTaxListFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TPayTaxListGUI = class(TBaseListingGUI)
    qryMainEmployeeName: TWideStringField;
    qryMainTotalTaxWithheld: TFloatField;
    qryMainAllowances: TFloatField;
    qryMainOther: TFloatField;
    qryMainGrossPayments: TFloatField;
    qryMainDeductions: TFloatField;
    qryMainWorkPlacegiving: TFloatField;
    qryMainUnionFees: TFloatField;
    qryMainTotalEmployeeTax: TFloatField;
    qryMainTotalCompanyTax: TFloatField;
    grdSummary: TwwDBGrid;
    wwIButton1: TwwIButton;
    qrySummary: TERPQuery;
    dsSummary: TDataSource;
    qrySummaryEmployee: TWideStringField;
    qrySummaryDatePaid: TWideStringField;
    qrySummaryCheckNum: TLargeintField;
    qrySummaryGross: TFloatField;
    qrySummarySocWages: TFloatField;
    qrySummarySocTax: TFloatField;
    qrySummaryMedWages: TFloatField;
    qrySummaryMedTax: TFloatField;
    qrySummaryMedOverWage: TFloatField;
    qrySummaryMedOverTax: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);

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
  PayTaxListGUI: TPayTaxListGUI;

implementation

uses
  DbSharedObjectsObj, AppEnvironment, CommonLib, CommonDbLib, FastFuncs, wwexport,
  SystemLib, tcConst;

{$R *.dfm}

{ TPayTaxListGUI }

procedure TPayTaxListGUI.cmdExportClick(Sender: TObject);
var
  fsFilename: string;
begin
  if grpFilters.ItemIndex = 0 then
    inherited
  else begin
    fsFilename:='';
    if AppEnv.CompanyPrefs.UseERPFilenameforDataExport then begin
      fsFilename := Exportdatafilename;
    end else begin
      dlgSave.Title := 'Export - ' + Caption;
      if dlgSave.Execute then fsFilename := dlgSave.FileName;
    end;
    if fsFilename <> '' then DoExportDetail(fsFilename);
  end;
end;

procedure TPayTaxListGUI.cmdPrintClick(Sender: TObject);
begin
  if grpFilters.ItemIndex = 1 then begin   // Summary
    dlgPrint.ObjectToPrint := grdSummary;
    dlgPrint.Print;
    dlgPrint.ObjectToPrint := grdMain;
  end
  else
    inherited;
end;

procedure TPayTaxListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  MakeQryMain;
  AddCalcColumn(qryMainTotalTaxWithheld.FieldName, true);
  AddCalcColumn(qryMainAllowances.FieldName, true);
  AddCalcColumn(qryMainOther.FieldName, true);
  AddCalcColumn(qryMainGrossPayments.FieldName, true);
  AddCalcColumn(qryMainDeductions.FieldName, true);
  AddCalcColumn(qryMainWorkPlacegiving.FieldName, true);
  AddCalcColumn(qryMainUnionFees.FieldName, true);
  AddCalcColumn(qryMainTotalEmployeeTax.FieldName, true);
  AddCalcColumn(qryMainTotalCompanyTax.FieldName, true);

//  AddCalcColumn(qryMainMedicareTax.FieldName, true);
//  AddCalcColumn(qryMainSocialSecurityTax.FieldName, true);

  grdSummary.TitleColor := Self.Color;
  grdSummary.FooterColor := Self.Color;
end;

procedure TPayTaxListGUI.grpFiltersClick(Sender: TObject);
begin
    case grpFilters.ItemIndex of
    0:
      begin
        grdMain.Visible := True;
        grdSummary.Visible := False;
      end;
    1:
      begin
        grdMain.Visible := False;
        grdSummary.Visible := True;
      end;
  end;

  inherited;
end;

procedure TPayTaxListGUI.MakeQryMain;
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
    qryMain.SQL.Add('e.EmployeeName as EmployeeName,');
    qryMain.SQL.Add('SUM(P.Tax) AS TotalTaxWithheld,');
    qryMain.SQL.Add('SUM(P.Allowances) AS Allowances,');
    qryMain.SQL.Add('SUM(P.Commission) + IF(SUN.TaxExempt = "F", Sum(SUN.Amount), 0) AS Other,');
    qryMain.SQL.Add('SUM(P.Wages) - Sum(P.CDEPGross) + Sum(P.Commission) AS GrossPayments,');
    qryMain.SQL.Add('SUM(IF(PD.IsWorkPlacegiving ="F" and PD.UnionFees = "F", PD.Amount, 0)) AS Deductions,');
    qryMain.SQL.Add('SUM(IF(PD.IsWorkPlacegiving ="F" and PD.UnionFees = "T", PD.Amount, 0)) AS UnionFees,');
    qryMain.SQL.Add('SUM(IF(PD.IsWorkPlacegiving = "T", PD.Amount, 0)) AS WorkPlacegiving,');
    qryMain.SQL.Add('SUM(p.Tax) as TotalEmployeeTax,');
    qryMain.SQL.Add('SUM(p.CompanyTax) as TotalCompanyTax');
    while not qry.EOF do begin
      tbl := 't' + IntToStr(qry.FieldByName('Id').AsInteger);
      qryMain.SQL.Add(',sum('+tbl+'.Amount) as `' + qry.FieldByName('TaxName').AsString + '`');
      qry.Next;
    end;
    qryMain.SQL.Add('from tblpays p');
    qryMain.SQL.Add('inner join tblemployees e on e.EmployeeID = p.EmployeeID');
    qryMain.SQL.Add('LEFT JOIN tblpaysdeductions AS PD on P.PayID = PD.PayID');
    qryMain.SQL.Add('LEFT JOIN tbldeductions AS D on D.DeductionID = PD.DeductionID');
    qryMain.SQL.Add('LEFT JOIN tblpayssundries AS SUN on P.PayID = SUN.PayID');
    qry.First;
    while not qry.EOF do begin
      tbl := 't' + IntToStr(qry.FieldByName('Id').AsInteger);
      qryMain.SQL.Add('left join tblpaytax ' + tbl + ' on ' + tbl + '.PayTaxConfigId = ' +
        IntToStr(qry.FieldByName('Id').AsInteger) + ' and ' + tbl + '.PayId = p.PayId');
      qry.Next;
    end;
    qryMain.SQL.Add('where p.Paid = "T"');
    qryMain.SQL.Add('and p.Deleted = "F"');
    qryMain.SQL.Add('and (p.PayDate BETWEEN :datefrom AND :dateto)');
    qryMain.SQL.Add('group by e.EmployeeID');
    qryMain.SQL.Add('order by e.EmployeeName');

    RefreshOrignalSQL;

    qry.First;
    while not qry.Eof do begin

      with TFloatField.Create(Self) do begin
        Currency := True;
        fieldKind := fkData;
        fieldname := qry.FieldByName('TaxName').AsString;
        AddCalcColumn(fieldName, true);
        name := ComponentName(self, ReplaceStr(ReplaceStr('qryMain'+fieldname, '-','_'),' ','_'));
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

procedure TPayTaxListGUI.RefreshQuery;
begin
  if chkIgnoreDates.Checked then begin
    qryMain.ParamByName('datefrom').AsDate := 0;
    qryMain.ParamByName('dateto').AsDate := SysUtils.MaxDateTime;
  end
  else begin
    qryMain.ParamByName('datefrom').AsDate := dtFrom.Date;
    qryMain.ParamByName('dateto').AsDate := dtTo.Date;
  end;

  // Summary
  qrySummary.Close;

  qrySummary.ParambyName('dtFrom').AsDateTime := FilterdateFrom;
  qrySummary.ParambyName('dtTo').AsDateTime := FilterDateto;

  qrySummary.Open;

  inherited;
end;

procedure TPayTaxListGUI.RefreshTotals;
begin
  inherited;
  CalcnShowfooter;
end;

procedure TPayTaxListGUI.DoExportDetail(const Exportfilename: string);
var
  sFileExt: string;
begin
  grdSummary.ExportOptions.FileName := Exportfilename;
  grdSummary.ExportOptions.TitleName := Self.Caption;
  sFileExt := ExtractFileExt(Exportfilename);
  if SysUtils.SameText(FastFuncs.LowerCase(sFileExt), '.txt') then begin
    grdSummary.ExportOptions.ExportType := wwgetTxt;
    grdSummary.ExportOptions.Delimiter := #9;
  end
  else if SysUtils.SameText(FastFuncs.LowerCase(sFileExt), '.csv') then begin
    grdSummary.ExportOptions.ExportType := wwgetTxt;
    grdSummary.ExportOptions.Delimiter := ',';
  end
  else if SysUtils.SameText(FastFuncs.LowerCase(sFileExt), '.slk') then begin
    grdSummary.ExportOptions.ExportType := wwgetSYLK;
  end
  else if SysUtils.SameText(FastFuncs.LowerCase(sFileExt), '.html') then begin
    grdSummary.ExportOptions.ExportType := wwgetHTML;
  end else begin
    CommonLib.MessageDlgXP_Vista('Unsupported Export Format.' + #13 + #10 + '' + #13 + #10 + 'Defaulted To Text (*.TXT) Format Export.', mtWarning, [mbOK], 0);
    grdSummary.ExportOptions.ExportType := wwgetTxt;
    grdSummary.ExportOptions.Delimiter := #9;
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
          grdSummary.ExportOptions.Save;
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

function TPayTaxListGUI.ExportDataFileName: string;
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
  RegisterClass(TPayTaxListGUI);

end.
