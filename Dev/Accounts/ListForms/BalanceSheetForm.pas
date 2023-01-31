unit BalanceSheetForm;

interface
{$I ERP.inc}
uses
  Messages, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList,
  Menus, AdvMenus, DB, Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls,
  ExtCtrls, DNMPanel, wwdblook, wwcheckbox, ReportTransactionsTable,
  SelectionDialog, wwDialog, Wwlocate, MemDS, DBAccess, MyAccess,ERPdbComponents,
  wwdbdatetimepicker, ProgressDialog,  Shader, kbmMemTable,
  DAScript, MyScript, (*ReportSQLBalanceSheet, *)CustomInputBox, wwclearbuttongroup,
  wwradiogroup, GIFImg, BalanceSheetSQL;

const
  SX_DatechangeMsg = WM_USER + 125;

type
  TBalanceSheetGUI = class(TBaseListingGUI)
    Panel4: TPanel;
    lblClassTitle: TLabel;
    Label4: TLabel;
    chkAllClass: TwwCheckBox;
    cboClass: TwwDBLookupCombo;
    cboClassQry: TERPQuery;
    cboClassQryClassID: TIntegerField;
    cboClassQryClassName: TWideStringField;
    qryMainID: TIntegerField;
    qryMainSortID: TIntegerField;
    qryMainTypeID: TWideStringField;
    qryMainACCNAME: TWideStringField;
    qryMainAccountNumber: TWideStringField;
    qryMainColumn1: TWideStringField;
    qryMainColumn2: TFloatField;
    qryMainColumn3: TFloatField;
    qryMainColumn4: TFloatField;
    qryMainColumn5: TFloatField;
    btnDeptSelect: TDNMSpeedButton;
    edtBalance: TEdit;
    lblbalance: TLabel;
    lblDepartments: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState;
      Highlight: boolean; AFont: TFont; ABrush: TBrush);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkAllClassClick(Sender: TObject);
    procedure cboClassChange(Sender: TObject);
    procedure DateChange(var Message: TMessage); message SX_DatechangeMsg;
    procedure cmdPrintClick(Sender: TObject);
    procedure qryMainBeforeClose(DataSet: TDataSet);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure cmdCloseClick(Sender: TObject);
    procedure actRefreshQryExecute(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure btnDeptSelectClick(Sender: TObject);
  private
    {Private declarations}
    fbOpenning: boolean;
    PrevDate: TDateTime;
    SelectedDepartments: TStrings;
    fDepartmentIDsString :String;
    BalSQLObj: TBalanceSheetReport;


    Procedure LabelChange;
    Procedure Calcdiff;
    procedure MakeBalancesheet;
    function getAssetValue(const AccName: String): Double;


  protected
    function GetReportTypeID: integer; override;
    procedure RefreshQuery; override;
    Procedure initFCFields; override;
    function DoDtToChange(Sender: TObject): boolean; override;
    Function DoEmailIfToBeEmailed:boolean;override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
  public
    class function BalTransListfilter(const sAccName, stype: String; DAteTo:TDateTime): String;
    property AssetValue[Const AccName: String]:Double read getAssetValue;
  end;

implementation

uses FastFuncs,Windows, SysUtils, DNMLIB, BalTransListForm, strUtils,
     DateUtils,CommonLib, Forms, AppEnvironment, tcConst,
  CommonDbLib, MySQLConst,frmPayDeptSelectionGUI, tcDataUtils;

{$R *.dfm}

{ TBalanceSheetGUI }

procedure TBalanceSheetGUI.FormCreate(Sender: TObject);
begin
  edtBalance.visible := devmode;
  lblbalance.visible := devmode;
  fbOpenning := true;
  IsGridcustomisable      := false;
  CanCreatecustomReport   := false;
  ReportonForeignCurrency := True;
  BalSQLObj := TBalanceSheetReport.Create;
  BalSQLObj.APIMode := false;
  BalSQLObj.ReportClassName := self.ClassName;
  inherited;
  BalSQLObj.UserLock := self.UserLock;
  SearchMode:= smFullList;
  StringListForSQL:=TStringList.create;
  ShowChartViewOnPopup := True;
  NonSearchReport := True;
  SelectedDepartments := TStringList.Create;
end;
Class function TBalanceSheetGUI.BalTransListfilter(const sAccName:String; const stype:String; DAteTo:TDateTime):String;
begin
      if not Empty(sType) and not Empty(sAccName) then begin
        Result :='(AccountType = "' + sType + '" AND AccountName = ' + QuotedStr(sAccName) + ')';
      end else if not Empty(sType) and Empty(sAccName) then begin
        Result :='(AccountType = "' + sType  + '")';
      end else if AnsiContainsText(sType, 'Total Other Current Liability') then begin
        Result :='(AccountType = "OCLIAB")';
      end else if AnsiContainsText(sAccName, 'Profit&Loss') or AnsiContainsText(sAccName, 'Retained Earnings') then begin
        Result :='((AccountType = "EXEXP" OR AccountType = "EXP" OR AccountType = "EXINC" OR AccountType = "INC" OR AccountType = "COGS") OR (AccountName="Retained Earnings") )';
      (*end else if AnsiContainsText(sAccName, 'Profit&Loss') then begin
        Result :='((AccountType = "EXEXP" OR AccountType = "EXP" OR AccountType = "EXINC" OR AccountType = "INC" OR AccountType = "COGS") OR (AccountName="Retained Earnings") )'+
          '/*AND Date Between ' + QuotedStr(FormatDateTime(MysqlDatetimeFormat, GetCurrentFiscalYearStart(DAteTo))) + ' AND ' + QuotedStr(FormatDateTime(MysqlDatetimeFormat, DAteTo)) + ' */';

      end else if AnsiContainsText(sAccName, 'Retained Earnings') then begin
        Result :=
          '((AccountType = "EXEXP" OR AccountType = "EXINC" OR AccountType = "EXP" OR AccountType = "INC" OR AccountType = "COGS") OR (AccountName="Retained Earnings")) '+
          '/*AND Date Between ' + QuotedStr(FormatDateTime(MysqlDateFormat, 0)) + ' AND ' + QuotedStr(FormatDateTime(MysqlDateFormat, IncDay(GetCurrentFiscalYearStart(DAteTo), - 1))) + '*/ ';*)

      end else if AnsiContainsText(sType, 'Total Other Asset') then begin
        Result :=
          '(AccountType = "OASSET")';
      end else if AnsiContainsText(sType, 'Total Other Current Asset') then begin
        Result :=
          '(AccountType = "OCASSET")';
      end else if AnsiContainsText(sType, 'TOTAL LIABILITIES & EQUITY') then begin
        Result :=
          '(AccountType = "AP" OR AccountType = "OCLIAB" OR AccountType = "EQUITY" OR AccountType = "CCARD" OR ' +
          'AccountType = "EXEXP" OR AccountType = "EXP" OR AccountType = "EXINC" OR AccountType = "INC" OR AccountType = "COGS")';
      end else if AnsiContainsText(sType, 'Total Fixed Asset') then begin
        Result :=
          '(AccountType = "FIXASSET")';
      end else if AnsiContainsText(sType, 'Total Current Liabilities') then begin
        Result :=
          '(AccountType = "AP" OR AccountType = "OCLIAB" OR AccountType = "EQUITY" OR AccountType = "CCARD")';
      end else if AnsiContainsText(sType, 'Total Current Assets') then begin
        Result :=
          '(AccountType = "AR" OR AccountType = "BANK" OR AccountType = "OCASSET")';
      end else if AnsiContainsText(sType, 'TOTAL ASSETS') then begin
        Result :=
          '(AccountType = "AR" OR AccountType = "BANK" OR ' +
          'AccountType = "OCASSET" OR AccountType = "OASSET" OR AccountType = "FIXASSET")';
      end else if AnsiContainsText(sType, 'Total Cheque or Saving') then begin
        Result :=
          '(AccountType = "BANK")';
      end else if AnsiContainsText(sType, 'Total Accounts Receivable') then begin
        Result :=
          '(AccountType = "AR")';
      end else if AnsiContainsText(sType, 'Total Accounts Payable') then begin
        Result :=
          '(AccountType = "AP")';
      end else begin
        REsult := '';
      end;
end;
procedure TBalanceSheetGUI.grdMainDblClick(Sender: TObject);
var
  sType, sFilter, sAccName: string;
  frmBalTransList: TComponent;
begin
  sFilter := '';
  sAccName := '';
  if Empty(TwwDBGrid(Sender).GetActiveField.AsString) then Exit;
  if not FormStillOpen('TBalTransListGUI') then begin
    frmBalTransList := GetComponentByClassName('TBalTransListGUI');
    if Assigned(frmBalTransList) then begin
      TBalTransListGUI(frmBalTransList).ToDate := dtTo.DateTime;
      sAccName := Trim(qryMain.FieldByName('AccName').AsString);
      sType    := Trim(qryMain.FieldByName('TypeID').AsString);
      TBalTransListGUI(frmBalTransList).IsRetainedEarnings:=AnsiContainsText(sAccName, 'Retained Earnings');
      TBalTransListGUI(frmBalTransList).IsProfitAndLoss:=AnsiContainsText(sAccName, 'Profit&Loss');
      sFilter := BalTranslistfilter(sAccname, stype, Filterdateto);
      if sfilter = '' then begin
        TForm(frmBalTransList).Close;
        Exit;
      end;
      if chkAllClass.Checked then begin
        TBalTransListGUI(frmBalTransList).Reportfilter :=  sFilter;
      end else begin
        (*TBalTransListGUI(frmBalTransList).qryMain.SQL.Add(' AND ' + fDepartmentIDsString + ' AND (' + sFilter + ') Group by TransID;');*)
        TBalTransListGUI(frmBalTransList).Reportfilter :=  fDepartmentIDsString + ' AND ' + sFilter;
      end;
      TForm(frmBalTransList).FormStyle := fsmdiChild;
    end;
  end else begin
    TForm(FindExistingComponent('TBalTransListGUI')).Show;
  end;
end;


procedure TBalanceSheetGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState;
  Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if (FastFuncs.PosEx('TOTAL', uppercase(Field.AsString)) > 0) then begin
    AFont.Style := AFont.Style + [fsBold];
  end else
  if (Field.FieldName = 'Column2') and Empty(qryMain.fieldbyname('ACCNAME').AsString) then begin
    AFont.Style := AFont.Style + [fsBold];
  end else
  if (Field.FieldName = 'Column3') and Empty(qryMain.fieldbyname('ACCNAME').AsString) then begin
    AFont.Style := AFont.Style + [fsBold];
  end else
  if (Field.FieldName = 'Column4') and Empty(qryMain.fieldbyname('ACCNAME').AsString) then begin
    AFont.Style := AFont.Style + [fsBold];
  end else
  if (Field.FieldName = 'Column5') and Empty(qryMain.fieldbyname('ACCNAME').AsString) then begin
    AFont.Style := AFont.Style + [fsBold];
  end;

end;

procedure TBalanceSheetGUI.FormDestroy(Sender: TObject);
begin
  BalSQLObj.Free;
  FreeAndNil(SelectedDepartments);
  inherited;
end;

procedure TBalanceSheetGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if devmode then begin
    if GuiPrefs.Node.Exists('Options.Dateto') and (dtTo.date <> GuiPrefs.Node['Options.Dateto'].asDateTime) then begin
      dtTo.date :=  GuiPrefs.Node['Options.Dateto'].asDateTime;
      fbDateRangeSupplied := true;
      actRefreshQryExecute(actRefreshQry);
    end;
  end;
end;

procedure TBalanceSheetGUI.RefreshQuery;
var
  msg: string;
begin
  if Qrymain.active then Qrymain.close;
  BalSQLObj.DateFrom := FilterDateFrom;
  BalSQLObj.DateTo := FilterDateTo;
  BalSQLObj.ReportonForeignCurrency := self.ReportonForeignCurrency;
  BalSQLObj.AllDepartments := chkAllClass.Checked;
  if not BalSQLObj.AllDepartments then
    BalSQLObj.SelectedDepartments := self.SelectedDepartments.CommaText;
  if not BalSQLObj.PopulateReportSQL(qryMain.SQL,msg) then begin
    MessageDlgXP_Vista(msg, mtWarning, [mbOK], 0);
    exit;
  end;

  RefreshOrignalSQL;
  inherited;
  LabelChange;
  Calcdiff;
end;

procedure TBalanceSheetGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.Dateto'].asDateTime := dtTo.date;
end;

Procedure TBalanceSheetGUI.LabelChange;
var
    ctr : integer;
    x_colWidth :Integer;

    Function  groupname :String;
    begin

           if ctr = 2 then result :='Sub~Account~Totals'
      else if ctr = 3 then result := 'Header~Account~Totals'
      else if ctr = 4 then result := 'Total Current~Assets &~Liabilities'
      else if ctr = 5 then result := 'Total ~Assets &~Liabilities';
      if ReportonForeignCurrency  then result := StringReplace(result, '~' , ' ' , [rfReplaceAll]);
    end;

    Procedure addForeigncurrencies;
    begin
        if ReportonForeignCurrency then begin
            FConReport.First;
            while FConReport.Eof = False do begin
                AddGridSelectedfield(FCOnReportCode.asString +'_Column' + Trim(IntToStr(ctr)) , x_colWidth ,
                            FCOnReportCode.asString , groupname);
                if qrymain.findfield(FCOnReportCode.asString +'_Column' + Trim(IntToStr(ctr))) <> nil then
                  TFloatfield(qrymain.findfield(FCOnReportCode.asString +'_Column' + Trim(IntToStr(ctr)))).displayformat :=FConReportSymbol.asString +'###,###,###,###';
                FConReport.Next;
            end;
        end;
    end;

begin
    x_colWidth := 15;
    fieldList := TStringList.create;
    try
        AddGridSelectedfield('column1' , 44 , 'Account Tree' );
        AddGridSelectedfield('AccountNumber' , 30 , 'Account No' );
        for ctr := 2 to 5 do begin
            if ReportonForeignCurrency then begin
                AddGridSelectedfield('Column' + Trim(IntToStr(ctr)) , x_colWidth,
                             Appenv.RegionalOptions.ForeignExDefault ,
                            groupname);
               addForeigncurrencies;
            end else Begin
                AddGridSelectedfield('Column' + Trim(IntToStr(ctr)) , x_colWidth , groupName );
                if Qrymain.findfield('Column' + Trim(IntToStr(ctr))) <> nil then
                   TFloatfield(Qrymain.findfield('Column' + Trim(IntToStr(ctr)))).displayformat := Appenv.RegionalOptions.CurrencySymbol +'###,###,###,###';

            end;
        end;
        grdMain.Selected := FieldList;
        grdMain.ApplySelected;
    finally
        freeandnil(fieldList);
    end;

end;

Procedure TBalanceSheetGUI.initFCFields;
begin
    Setlength(AmountFields ,4 );
    Setlength(AmountCaptions ,4 );
    AmountFields[0] := 'Column2'	; AmountCaptions[0] := 'Column2';
    AmountFields[1] := 'Column3'	; AmountCaptions[1] := 'Column3';
    AmountFields[2] := 'Column4'	; AmountCaptions[2] := 'Column4';
    AmountFields[3] := 'Column5'	; AmountCaptions[3] := 'Column5';
end;

procedure TBalanceSheetGUI.FormShow(Sender: TObject);
begin
  dtTo.DateTime := dateof(now);
  fbDateRangeSupplied:= TRue;
  MakeBalancesheet;
  inherited;
  LabelChange;
  if not ErrorOccurred then begin
    lblClassTitle.caption := AppEnv.DefaultClass.ClassHeading;
    cboClassQry.Connection := qryMain.Connection;
    cboClassQry.Active     := true;
    cboClassQry.Locate('ClassName', AppEnv.DefaultClass.DefaultClassName, [loCaseInsensitive]);
    cboClass.LookupValue := AppEnv.DefaultClass.DefaultClassName;
  end;
  fbOpenning := false;
end;

function TBalanceSheetGUI.getAssetValue(const AccName: String): Double;
begin
  REsult := 0;
  if  Qrymain.locate('typeID' , 'Total ' + AccName , []) then else
  if  Qrymain.locate('AccName',            AccName , []) then else
  if  Qrymain.locate('typeID' ,            AccName , []) then else exit;

         if Qrymain.fieldbyname('Column2').asFloat <> 0 then REsult := Qrymain.fieldbyname('Column2').asFloat
    else if Qrymain.fieldbyname('Column3').asFloat <> 0 then REsult := Qrymain.fieldbyname('Column3').asFloat
    else if Qrymain.fieldbyname('Column4').asFloat <> 0 then REsult := Qrymain.fieldbyname('Column4').asFloat
    else if Qrymain.fieldbyname('Column5').asFloat <> 0 then REsult := Qrymain.fieldbyname('Column5').asFloat;
end;

Procedure TBalanceSheetGUI.MakeBalancesheet;
begin
  if GuiPrefs.Node['DepartmentIDsString'].AsString = '' then begin
    chkAllClass.Checked := True;
  end else begin
    //load into SelectedDepartments
    SelectedDepartments.Text := GuiPrefs.Node['DepartmentsString'].AsString;
    lblDepartments.caption := 'Departments: ' + GuiPrefs.Node['DepartmentsString'].AsString;
    //load selected departments
    fDepartmentIDsString := GuiPrefs.Node['DepartmentIDsString'].AsString;
//    CreateTranstable;
    RefreshQuery;
  end;
end;

function TBalanceSheetGUI.DoEmailIfToBeEmailed:boolean;
begin
  DisableForm;
  try
    ReportSQLSupplied   := true;
    UseStringListForSQL := true;
    try
      StringListForSQL.Text :=  BalSQLObj.TemplateSQL;
      result:= inherited DoEmailIfToBeEmailed;
    finally
      ReportSQLSupplied   := false;
      UseStringListForSQL := false;
    end;
  finally
    EnableForm;
  end;
end;

procedure TBalanceSheetGUI.chkAllClassClick(Sender: TObject);
begin
  inherited;
  if chkAllClass.Checked then begin
    cboClass.Enabled := false;
    lblDepartments.caption := 'Departments: All';
    fDepartmentIdsString := '';
  end else begin
    if fDepartmentIdsString = '' then fDepartmentIdsString := 'classid = 0';
    cboClass.Enabled := true;
  end;
  if screen.activecontrol = sender then begin
    RefreshQuery;
  end;
end;

function TBalanceSheetGUI.DoDtToChange(Sender:TObject): boolean;
begin
  result:= false;
  if not dtTo.DroppedDown then begin
    if not (dtTo.DateTime = PrevDate) then begin
      PostMessage(self.Handle, SX_DatechangeMsg, 0, 0);
      result:= true;
    end;
    PrevDate := dtTo.DateTime;
  end;
end;

procedure TBalanceSheetGUI.cboClassChange(Sender: TObject);
begin
  inherited;
  if screen.activecontrol = sender then begin
    RefreshQuery;
  end;
end;

procedure TBalanceSheetGUI.DateChange(var Message: TMessage);
begin
  if screen.activecontrol = dtTo then    begin
    RefreshQuery;
  end;
end;

function TBalanceSheetGUI.GetReportTypeID: integer;
begin
  Result := BalSQLObj.ReportTypeID ;
end;

procedure TBalanceSheetGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    ReportSQLSupplied   := true;
    UseStringListForSQL := true;
    try
      StringListForSQL.Text :=  BalSQLObj.TemplateSQL;

      inherited;
    finally
      ReportSQLSupplied   := false;
      UseStringListForSQL := false;
    end;
  finally
    EnableForm;
  end;
end;
procedure TBalanceSheetGUI.qryMainBeforeClose(DataSet: TDataSet);
begin
  inherited;
  GuiPrefs.Active := false;
end;

procedure TBalanceSheetGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  GuiPrefs.Active := true;
  if filterdateto < Appenv.CompanyPrefs.closingDate then
    listTimerMsg('Balance Sheet As On Date Selected (' +Quotedstr(Formatdatetime(FormatSettings.shortdateformat  , Filterdateto)) +') is Prior to the closing date (' +Quotedstr(Formatdatetime(FormatSettings.shortdateformat  , Appenv.CompanyPrefs.closingDate)) +').'+
            '  Report is Blank.');
end;

procedure TBalanceSheetGUI.cmdCloseClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TBalanceSheetGUI.actRefreshQryExecute(Sender: TObject);
begin
  lblDepartments.caption:= 'Departments: ';
  MakeBalancesheet;
  inherited;
end;

procedure TBalanceSheetGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TBalanceSheetGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TBalanceSheetGUI.cmdNewClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TBalanceSheetGUI.btnDeptSelectClick(Sender: TObject);
var
  frmDeptSelectPopUp:TComponent;
  i,j,iPos:integer;
begin
  inherited;
  if FormStillOpen('TfrmPayDeptSelection') then
        TfrmPayDeptSelection(FindExistingComponent('TfrmPayDeptSelection')).Close;

  frmDeptSelectPopUp := GetComponentByClassName('TfrmPayDeptSelection');
  if Assigned(frmDeptSelectPopUp) then begin
    with TfrmPayDeptSelection(frmDeptSelectPopUp) do begin
      if ShowModal = mrOk then begin
        SelectedDepartments.Clear;

        //get departments from chkList
        for i := 0 to chkDepartments.Count - 1 do begin
          if chkDepartments.Checked[i] then begin
            SelectedDepartments.Add(chkDepartments.Items.Strings[i]);
          end;
        end;

        if SelectedDepartments.Count > 0 then begin
          fDepartmentIDsString := '';
          for j := 0 to SelectedDepartments.Count -1 do
          begin
            fDepartmentIDsString := fDepartmentIdsString +  ' or ClassID = ' + IntToStr(GetDeptID(SelectedDepartments.Strings[j])) ;
          end;

          //remove first 'or' from string
          iPos := Pos('or',fDepartmentIdsString);
          fDepartmentIdsString := Copy(fDepartmentIdsString,iPos + 2,char_length(fDepartmentIdsString) - iPos + 2);

          if chkAllClass.Checked then chkAllClass.Checked := False
          else LabelChange;

          RefreshQuery;

          lblDepartments.caption:= 'Departments: ';
          for j := 0 to SelectedDepartments.Count - 1 do
          begin
            lblDepartments.Caption := lblDepartments.Caption + SelectedDepartments.Strings[j] + ', ';
          end;
          Self.GuiPrefs.Node['DepartmentsString'].AsString:= SelectedDepartments.CommaText;
          Self.GuiPrefs.Node['DepartmentIDsString'].AsString:= fDepartmentIDsString;
        end;
      end else begin
        Exit;
      end;
    end;
  end;
end;

procedure TBalanceSheetGUI.Calcdiff;
{$IFDEF DevMode}
var
  fd:Double;
{$ENDIF}
begin
{$IFDEF DevMode}
  try
    fd:= 0;
    try
      With CommonDbLib.tempMyQuery do try
        SQL.add('select T.ACCOUNTTYPE , T.ACCOUNTNUMBER ,Sum(ifnull(column5,0)) amount from '+ BalSQLObj.TempTableName+' T Where ifnull(column5,0)<> 0 group by T.ACCOUNTTYPE , T.ACCOUNTNUMBER');
        open;
        if recordcount =0 then exit;
        First;
        fd:= Fieldbyname('Amount').asFloat;
        Next;
        if eof then exit;
        fd := fd-Fieldbyname('Amount').asFloat;
      finally
        if active then Close;
        free;
      end;
    finally
      edtBalance.Text:= FloatToStrF(fd, ffCurrency, 15, 2);
    end;
  except
  end;
{$ENDIF}
end;

initialization
  RegisterClassOnce(TBalanceSheetGUI);

end.






