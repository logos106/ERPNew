unit CustomAccountsReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel , CustomAccountsReportObj, wwclearbuttongroup, wwradiogroup, GIFImg ;

type
  TCustomAccountsReportGUI = class(TBaseListingGUI)
    chkTreeMode: TCheckBox;
    btnOptions: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdMainCalcTitleAttributes(Sender: TObject; AFieldName: string;
      AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
    procedure chkTreeModeClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure btnOptionsClick(Sender: TObject);
  private
    Tablename :String;
    highestLevel :Integer;
    fCustomAccountsReportObj :TCustomAccountsReportObj;
    procedure ReFreshReport(Sender: TObject);
    procedure setSelectedDepartments(const Value: String);
    Function CustomAccountsReportObj :TCustomAccountsReportObj;
    procedure initCustomAccountsReportTree(Sender: TObject);
    procedure InitcustomAccountsReportOptions(Sender: TObject);
    procedure ShowclassColumns(const Qry:TERPQuery);
    procedure Initgridcolumns;
  Protected
    procedure SetGridColumns; Override;
    function GetReportTypeID: integer; Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    Function GuiprefName:String;override;
  public
    Procedure RefreshQuery;Override;
    Property SelectedDepartments:String Write setSelectedDepartments;
  end;


implementation

uses CommonLib, CommonFormLib, AppEnvironment, FrmChartofAccountsReportTree,
  CommonDbLib, LogLib, DbSharedObjectsObj, MySQLConst , (*TimedHint,*)
  CustomAccountsReportTree, frmcustomAccountsReportOptions,
  AppEnvironmentVirtual;

{$R *.dfm}
procedure TCustomAccountsReportGUI.chkTreeModeClick(Sender: TObject);
begin
  inherited;
    if sender <> chkTreemode then exit;
    //if Assigned(fTimedHint) then  fTimedHint.HidehintformForm(Self);
    WriteGuiPrefExtra;
    GuiPrefs.SavePrefs;
    OpenERPForm('TCustomAccountsReportTreeGUI' , 0 , nil, initCustomAccountsReportTree);
    Self.Close;
end;
procedure TCustomAccountsReportGUI.initCustomAccountsReportTree(Sender: TObject);
begin
  if not(Sender is TCustomAccountsReportTreeGUI) then exit;
  TCustomAccountsReportTreeGUI(Sender).dtTo.Date := DtTo.Date;
  TCustomAccountsReportTreeGUI(Sender).SelectedDepartments := CustomAccountsReportObj.SelectedClasses;
end;

procedure TCustomAccountsReportGUI.Initgridcolumns;
begin
    Tfloatfield(Qrymain.Fieldbyname('DebitsEx')).currency := true;
    Tfloatfield(Qrymain.Fieldbyname('creditsEx')).currency := true;
    Tfloatfield(Qrymain.Fieldbyname('DebitsInc')).currency := true;
    Tfloatfield(Qrymain.Fieldbyname('creditsInc')).currency := true;
    Tfloatfield(Qrymain.Fieldbyname('BalanceEx')).currency := true;
    Tfloatfield(Qrymain.Fieldbyname('BalanceInc')).currency := true;


  FieldList := TStringList.Create;
  try
    AddGridSelectedfield('ReportCaption', 20, 'Account name');
    CustomAccountsReportObj.IterateClassQuery(ShowclassColumns, true);
    AddGridSelectedfield('DebitsEx'   , 20, 'Debit(Ex)'  , 'Total of all ' + Appenv.DefaultClass.ClassHeading);
    AddGridSelectedfield('creditsEx'  , 20, 'Credit(Ex)' , 'Total of all ' + Appenv.DefaultClass.ClassHeading);
    AddGridSelectedfield('DebitsInc'  , 20, 'Debit(Inc)' , 'Total of all ' + Appenv.DefaultClass.ClassHeading);
    AddGridSelectedfield('creditsInc' , 20, 'Credit(Inc)', 'Total of all ' + Appenv.DefaultClass.ClassHeading);
    AddGridSelectedfield('BalanceEx'  , 20, 'Ex'        , 'Balance of all ' + Appenv.DefaultClass.ClassHeading);
    AddGridSelectedfield('BalanceInc' , 20, 'Inc'       , 'Balance of all ' + Appenv.DefaultClass.ClassHeading);
    if devmode then AddGridSelectedfield('Levelno', 20, 'Level');
    grdmain.Selected.Text := Fieldlist.Text;
    grdmain.ApplySelected;
  finally
    FreeandNil(FieldList);
  end;
end;
procedure TCustomAccountsReportGUI.ShowclassColumns(const Qry: TERPQuery);
begin
    Tfloatfield(Qrymain.Fieldbyname(CustomAccountsReportObj.DebitsExField)).currency := true;
    Tfloatfield(Qrymain.Fieldbyname(CustomAccountsReportObj.CreditsExField)).currency := true;
    Tfloatfield(Qrymain.Fieldbyname(CustomAccountsReportObj.DebitsIncField)).currency := true;
    Tfloatfield(Qrymain.Fieldbyname(CustomAccountsReportObj.CreditsIncField)).currency := true;

    AddGridSelectedfield(CustomAccountsReportObj.DebitsExField, 20, 'Debit Ex' , CustomAccountsReportObj.QryClasses.Fieldbyname('Classname').asString);
    AddGridSelectedfield(CustomAccountsReportObj.CreditsExField, 20, 'Credit Ex' , CustomAccountsReportObj.QryClasses.Fieldbyname('Classname').asString);
    AddGridSelectedfield(CustomAccountsReportObj.DebitsIncField, 20, 'Debit Inc' , CustomAccountsReportObj.QryClasses.Fieldbyname('Classname').asString);
    AddGridSelectedfield(CustomAccountsReportObj.CreditsIncField, 20, 'Credit Inc' , CustomAccountsReportObj.QryClasses.Fieldbyname('Classname').asString);
end;

procedure TCustomAccountsReportGUI.cmdPrintClick(Sender: TObject);
begin
  TemplateSQL :=  '{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, CO.PhoneNumber AS PhoneNumber, CO.FaxNumber AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO '+
                  ' ~|||~ {Details} ' +CustomAccountsReportObj.ReportSQL;
  ReportSQLSupplied := True;
  clog( TemplateSQL);
  inherited;

end;

function TCustomAccountsReportGUI.CustomAccountsReportObj: TCustomAccountsReportObj;
begin
    if fCustomAccountsReportObj = nil then begin
        fCustomAccountsReportObj := TCustomAccountsReportObj.create;
        fCustomAccountsReportObj.FormId          := Self.FormID;
        fCustomAccountsReportObj.Tablename       := Tablename;
        fCustomAccountsReportObj.GuiPrefs        := GuiPrefs;
    end;
    result := fCustomAccountsReportObj;

end;

procedure TCustomAccountsReportGUI.FormCreate(Sender: TObject);
begin
  TableName := GetUserTemporaryTableName('CustomAccountReport');
  fCustomAccountsReportObj := nil;
  Qrymain.SQL.Clear;
  //Qrymain.SQL.Text := TCustomAccountsReportObj.ReportSQL(Tablename);
  Qrymain.SQL.Text := 'select * from ' + Tablename+' order by sortorder';
  clog(Qrymain.SQL.Text);
  NonSearchMode:= true;
  inherited;
  DisableSortoncolumtitleclick:= TRue;
  CustomAccountsReportObj;// form create will create and init the guiprefs, so is ok to access this object here
  IsGridcustomisable := False;
end;

procedure TCustomAccountsReportGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(Tablename);
  FreeandNil(fCustomAccountsReportObj);
  inherited;

end;

procedure TCustomAccountsReportGUI.FormShow(Sender: TObject);
begin
  dtFrom.Date       := 0;
  inherited;
  dtFrom.Date       := 0;
  btnOptions.hint :=  'Please ''Customise'' to choose the accounts for the report';
  //ShowTimedHint(btnOptions ,  btnOptions.hint , true );
  btnCustomize.enabled := False;
end;

function TCustomAccountsReportGUI.GetReportTypeID: integer;
begin
  REsult := 139;
end;

procedure TCustomAccountsReportGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if CustomAccountsReportObj.USeGroupcolours then begin
    if Qrymain.fieldbyname('levelno').asInteger = highestlevel-4 then begin
      Afont.Color := clnavy;
    end else if Qrymain.fieldbyname('levelno').asInteger = highestlevel-3 then begin
      Afont.Color := clBlack;
    end else if Qrymain.fieldbyname('levelno').asInteger = highestlevel-2 then begin
      Afont.Color := clBlue;
    end else if Qrymain.fieldbyname('levelno').asInteger = highestlevel-1 then begin
      Afont.Color := clGreen;
    end else if Qrymain.fieldbyname('levelno').asInteger = highestlevel then begin
      Afont.Color := clRed;
    end else begin
    end;
  end;

    if (CustomAccountsReportObj.Blankwhen0) and (Field is TFloatfield) and (Tfloatfield(Field).asFloat =0) then
        AFont.Color := ABrush.Color;
end;

procedure TCustomAccountsReportGUI.grdMainCalcTitleAttributes(Sender: TObject;
  AFieldName: string; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  inherited;
     if sametext(AFieldName , Qrymain.fieldbyname('Balanceinc').fieldname) or
        sametext(AFieldName , Qrymain.fieldbyname('Balanceex').fieldname) or
        sametext(AFieldName , Qrymain.fieldbyname('debitsinc').fieldname) or
        sametext(AFieldName , Qrymain.fieldbyname('creditsinc').fieldname) or
        sametext(AFieldName , Qrymain.fieldbyname('DebitsEx').fieldname) or
        sametext(AFieldName , Qrymain.fieldbyname('CreditsInc').fieldname)  then
      ATitleAlignment  := taCenter;
end;

function TCustomAccountsReportGUI.GuiprefName: String;
begin
  REsult := TCustomAccountsReportObj.GuiprefName;
end;

procedure TCustomAccountsReportGUI.qryMainAfterOpen(DataSet: TDataSet);
var
  Qry :TERPQuery;
begin
  inherited;
  Qry := DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    Qry.SQL.Clear;
    Qry.SQL.Add('select Max(if(level4<> "", 5 , if(level3<> "", 4 ,if(level2<> "", 3 , if(level1<> "", 2 , 1)))))  Levelno from '+tablename );
    Qry.open;
    highestlevel := Qry.Fieldbyname('Levelno').asInteger;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;
end;

procedure TCustomAccountsReportGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  CustomAccountsReportObj.USeGroupcolours     := GuiPrefs.Node['Options.USeGroupcolours'].AsBoolean;
  CustomAccountsReportObj.Blankwhen0         := GuiPrefs.Node['Options.Blankwhen0'].AsBoolean;
  CustomAccountsReportObj.SelectedClasses := GuiPrefs.Node['Options.SelectedDepartments'].asString;

  chkAdvancedPrinting.checked   := GuiPrefs.Node['Options.AdvancedPrinting'].AsBoolean;
end;

procedure TCustomAccountsReportGUI.RefreshQuery;
begin
  Processingcursor(True);
  try
    dtFrom.Date       := 0;
    CustomAccountsReportObj.ReportAsOn      := Self.filterdateto;
    CustomAccountsReportObj.IsBalancesheet  := False;
    CustomAccountsReportObj.RefreshTable;
    inherited;
    Initgridcolumns;
  finally
    Processingcursor(False);
  end;
end;

procedure TCustomAccountsReportGUI.ReFreshReport(Sender: TObject);
begin
  if Sender is TfmcustomAccountsReportOptions then begin

  end;

  RefreshQuery;
end;
procedure TCustomAccountsReportGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(Qrymain.fieldbyname('ID').fieldname);
  RemoveFieldfromGrid(Qrymain.fieldbyname('accountId').fieldname);
  RemoveFieldfromGrid(Qrymain.fieldbyname('category').fieldname);
  RemoveFieldfromGrid(Qrymain.fieldbyname('levelno').fieldname);
end;


procedure TCustomAccountsReportGUI.setSelectedDepartments(const Value: String);
begin
  CustomAccountsReportObj.SelectedClasses := Value;
  GuiPrefs.Node['Options.SelectedDepartmentList'].asString := CustomAccountsReportObj.SelectedClasses;
end;


procedure TCustomAccountsReportGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.USeGroupcolours'].AsBoolean     := CustomAccountsReportObj.USeGroupcolours;
  GuiPrefs.Node['Options.Blankwhen0'].AsBoolean          := CustomAccountsReportObj.Blankwhen0;
  GuiPrefs.Node['Options.SelectedDepartments'].asString  := CustomAccountsReportObj.SelectedClasses;
  GuiPrefs.Node['Options.AdvancedPrinting'].AsBoolean    := chkAdvancedPrinting.checked;
end;

procedure TCustomAccountsReportGUI.btnOptionsClick(Sender: TObject);
begin
  inherited;
  OpenERPFormModal('TfmcustomAccountsReportOptions' , 0 , InitcustomAccountsReportOptions, true , Refreshreport);
end;

procedure TCustomAccountsReportGUI.InitcustomAccountsReportOptions(Sender: TObject);
begin
   if not(Sender is TfmcustomAccountsReportOptions) then exit;
   TfmcustomAccountsReportOptions(Sender).CustomAccountsReportObj := CustomAccountsReportObj;
end;

initialization
  RegisterClassOnce(TCustomAccountsReportGUI);
end.
