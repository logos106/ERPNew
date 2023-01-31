unit ProfitandLossPeriodCompare;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ProfitandLossPeriodReportBase, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  ReportSQLProfitAndLossPeriod, CustomInputBox, wwclearbuttongroup,
  wwradiogroup, GIFImg;

type
  TProfitandLossPeriodCompareGUI = class(TProfitLossPeriodBase)
    grdSelectedRecstoCompare: TwwDBGrid;
    wwIButton1: TwwIButton;
    QrySelectedRecstoCompare: TERPQuery;
    dsaccounts: TDataSource;
    Panel4: TPanel;
    lblClassTitle: TLabel;
    btnAcountSelect: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dtFromChange(Sender: TObject);
    procedure dtToChange(Sender: TObject);
    procedure btnAcountSelectClick(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure QrySelectedRecstoCompareAfterOpen(DataSet: TDataSet);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainCalcTitleAttributes(Sender: TObject; AFieldName: string; AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
  private
    SelectedPnLIds:String;
    xSelectedPnLIds :String;
    procedure OnSelectAccountIDs(Sender: TwwDbGrid);
    procedure InitSelectAccountIDForm(Sender: TObject);
  Protected
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; override;
    Procedure AddExtrafields(pColumn: pColumnRec);override;
    Procedure ToBeRefreshed;Override;
  public
    Procedure RefreshAll;Override;
  end;


implementation

uses AppEnvironment, CommonLib, BaseListingForm, CommonFormLib, ProfitandLossPeriodCompareAccSelection, tcConst, types , StrUtils;

{$R *.dfm}

procedure TProfitandLossPeriodCompareGUI.AddExtrafields(pColumn: pColumnRec);
var
  s:String;
begin
  inherited;
  With TProfitandLossPeriodCompare(ReportSQLObj) do begin
        if QryAccounts.recordcount >0 then begin
            grdMain.TitleLines := 4;
            QryAccounts.first;
            While QryAccounts.eof =False do begin
              s:=QryAccounts.fieldbyname('Description').asString;
              TFloatfield(Qrymain.findfield(  AccnameFldName(s , pColumn^.ColumnNo, QryAccounts.recno) + '_amt')).currency := True;
              AddGridSelectedfield('`' +      AccnameFldName(s , pColumn^.ColumnNo, QryAccounts.recno) + '_Percent`'  ,getColWidth('_Percent'),   'Percentage on'+'~' +s , pColumn^.ColumnName  );
              TFloatfield(Qrymain.fieldbyname(AccnameFldName(s , pColumn^.ColumnNo, QryAccounts.recno) + '_Percent')).displayformat := '#0.0#%';
              QryAccounts.Next;
            end;
        end;
  end;
end;

procedure TProfitandLossPeriodCompareGUI.btnAcountSelectClick(Sender: TObject);
begin
  inherited;
  OpenERPListFormultiselectModal('TProfitandLossPeriodCompareAccSelectionGUI' , InitSelectAccountIDForm , OnSelectAccountIDs);
  RefreshQuery;
end;
procedure TProfitandLossPeriodCompareGUI.InitSelectAccountIDForm(Sender: TObject);
begin
  if not(Sender is TProfitandLossPeriodCompareAccSelectionGUI) then exit;
  TProfitandLossPeriodCompareAccSelectionGUI(Sender).ProfitandLossPeriodComparemaintablename := TProfitandLossPeriodCompare(ReportSQLobj).Qrymaintablename;
  TProfitandLossPeriodCompareAccSelectionGUI(Sender).SelectedPnLIds :=  TProfitandLossPeriodCompare(ReportSQLobj).SelectedPnLIds;
end;

procedure TProfitandLossPeriodCompareGUI.OnSelectAccountIDs(Sender: TwwDbGrid);
var
  s:String;
begin
  s:= '';
  if Assigned(Sender.Owner) then
    if sender.Owner is TBaseListingGUI then
      s := TBaseListingGUI(Sender.Owner).SelectedIDs('ID' , True);
  if sametext(s, SelectedPnLIds) then exit;
  SelectedPnLIds := s;
  if SelectedPnLIds = '' then SelectedPnLIds := '0';
  TProfitandLossPeriodCompare(ReportSQLobj).SelectedPnLIds := SelectedPnLIds;
  RefreshQuery;
end;

procedure TProfitandLossPeriodCompareGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  closeDB(QrySelectedRecstoCompare);
  QrySelectedRecstoCompare.SQL.Clear;
  if (SelectedPnLIds ='') or (SelectedPnLIds ='0') then SelectedPnLIds := TProfitandLossPeriodCompare(ReportSQLobj).SelectedPnLIds;
  if SelectedPnLIds = '' then SelectedPnLIds := '0';
  QrySelectedRecstoCompare.SQL.Text := 'Select * from ' +TProfitandLossPeriodCompare(ReportSQLobj).Qrymaintablename +
                                          ' where Id in (' + SelectedPnLIds+') and ifnull(AccountName, "")<> "" order by AccountName';
  opendb(QrySelectedRecstoCompare);
  splMultiSelectList.Visible :=   QrySelectedRecstoCompare.RecordCount>0;
  grdSelectedRecstoCompare.Visible :=   QrySelectedRecstoCompare.RecordCount>0;
  splMultiSelectList.refresh;
  xSelectedPnLIds:= SelectedPnLIds;
end;

procedure TProfitandLossPeriodCompareGUI.QrySelectedRecstoCompareAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FieldList := TStringList.Create;
  try
    {dene asked to display only account name on the grid}
    AddGridSelectedfield('AccountName'  ,15,  'Account~Name');
    grdSelectedRecstoCompare.selected.text := fieldList.text;
    grdSelectedRecstoCompare.ApplySelected;
    fieldlist.clear;
  finally
    Freeandnil(fieldlist);
  end;
end;

procedure TProfitandLossPeriodCompareGUI.dtFromChange(Sender: TObject);
begin
  inherited;
  ToBeRefreshed;

end;

procedure TProfitandLossPeriodCompareGUI.dtToChange(Sender: TObject);
begin
  inherited;
  ToBeRefreshed;
end;

procedure TProfitandLossPeriodCompareGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  WriteGuiPref;
  inherited;
end;

procedure TProfitandLossPeriodCompareGUI.FormCreate(Sender: TObject);
begin
  fReportSQLObj := TProfitandLossPeriodCompare.Create(Self);
  ReportSQLobj.employeeID := Appenv.Employee.EmployeeID;
  xSelectedPnLIds:= '';
  Tablename := ReportSQLObj.Temptablename ;
  inherited;
  SearchMode:= smFullList;
  reportCaption :='Profit and Loss Compare';
  grdSelectedRecstoCompare.TitleColor := Self.Color;
  grdSelectedRecstoCompare.FooterColor := Self.Color;
  btnAcountSelect.hint := 'Accounts select to compare will show 100%.' +NL+'Other accounts will be a percentage of the comparing accounts' +NL + NL+ 'If none selected, ''Sales'' will be used to calculate the percentage on'+NL;
  grdSelectedRecstoCompare.hint := 'Accounts select to compare will show 100%.' +NL+'Other accounts will be a percentage of the comparing accounts' +NL + NL+ 'If none selected, ''Sales'' will be used to calculate the percentage on'+NL;
  btnAcountSelect.showhint := True;
  grdSelectedRecstoCompare.showhint := True;
end;

procedure TProfitandLossPeriodCompareGUI.FormShow(Sender: TObject);
begin
//  ReadGuipref;
  inherited;
  WindowState := wsMaximized;
end;


procedure TProfitandLossPeriodCompareGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
var
  fsFieldname:String;
  StrArray : TStringDynArray;
begin
  inherited;
  fsFieldname := Field.fieldname;
  StrArray := SplitString(fsFieldname,'_');
  if length(StrArray) = 1 then
  else begin
    if ISEvenNo(StrArray[1]) then ABrush.color := $00E4EDDC else ABrush.color := $00E8DBEE;
    if (field is TFloatfield) and (StrToFloatDef(Field.asString,0) =0) then Afont.color :=ABrush.color else Afont.color :=clblack;
  end;
end;

procedure TProfitandLossPeriodCompareGUI.grdMainCalcTitleAttributes(Sender: TObject; AFieldName: string; AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
var
  StrArray : TStringDynArray;
begin
  inherited;
  StrArray := SplitString(AFieldName,'_');
  if length(StrArray) = 1 then
  else if ISEvenNo(StrArray[1]) then ABrush.color := $00E4EDDC else ABrush.color := $00E8DBEE;
end;

procedure TProfitandLossPeriodCompareGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if GuiPrefs.Node.Exists('SelectedRecstoCompare') then
    SelectedPnLIds := GuiPrefs.Node['SelectedRecstoCompare.SelectedIds'].asString;
  TProfitandLossPeriodCompare(ReportSQLobj).SelectedPnLIds := SelectedPnLIds;
  if GuiPrefs.Node.Exists('SelectedRecstoCompare') then
    grdSelectedRecstoCompare.Width := GuiPrefs.Node['SelectedRecstoCompare.RightPanelWidth'].asInteger;
  if splMultiSelectList.left > grdSelectedRecstoCompare.left then
    grdSelectedRecstoCompare.left :=splMultiSelectList.left;
end;

procedure TProfitandLossPeriodCompareGUI.RefreshAll;
begin
  Try
      inherited;
  EXcept
    on E:Exception do begin
      if devmode then
        MessageDlgXP_vista(Qrymain.SQL.text +NL + E.message, mtWarning, [mbOK], 0);
    end;
  End;
end;

procedure TProfitandLossPeriodCompareGUI.ToBeRefreshed;
begin
  inherited;
  if lblREfreshInfo.visible then Exit;
  lblREfreshInfo.visible := not(sametext(xSelectedPnLIds, SelectedPnLIds));
end;

//procedure TProfitandLossPeriodCompareGUI.WriteGuiPref;
//begin
//  inherited;
//  GuiPrefs.Node['SelectedRecstoCompare.SelectedIds'].asString := SelectedPnLIds ;
//  GuiPrefs.Node['SelectedRecstoCompare.RightPanelWidth'].asInteger := grdSelectedRecstoCompare.Width;
//end;

procedure TProfitandLossPeriodCompareGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['SelectedRecstoCompare.SelectedIds'].asString := SelectedPnLIds ;
  GuiPrefs.Node['SelectedRecstoCompare.RightPanelWidth'].asInteger := grdSelectedRecstoCompare.Width;
end;

initialization
  RegisterClassOnce(TProfitandLossPeriodCompareGUI);

end.

