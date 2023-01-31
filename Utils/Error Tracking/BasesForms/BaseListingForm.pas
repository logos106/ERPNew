unit BaseListingForm;
interface

uses
 Windows, BaseForm, DB, Classes, ActnList, Menus, ImgList, Controls,
 PrintDAT, Dialogs, Buttons, Wwdbigrd, Grids, Wwdbgrid, StdCtrls,
 ComCtrls, ExtCtrls, Forms, Graphics, SysUtils, wwdbdatetimepicker,
 DNMPanel, MemDS, DBAccess, MyAccess, wwdblook, CustomInputBox,
 wwclearbuttongroup, wwradiogroup, GuiPrefsObj, Shader, DNMSpeedButton;

type
  TBaseListingGUI = class(TBaseFormGUI)
    Panel1: TDNMPanel;
    dsMain: TDataSource;
    grdMain: TwwDBGrid;
    dlgSave: TSaveDialog;
    mnuFilter: TPopupMenu;
    AddFilter: TMenuItem;
    mnuExecute: TMenuItem;
    actlstFilters: TActionList;
    actAddFilter: TAction;
    actClearFilter: TAction;
    qryListData: TMyQuery;
    HeaderPanel: TDNMPanel;
    lblFrom: TLabel;
    lblTo: TLabel;
    cboDateRange: TComboBox;
    dtFrom: TwwDBDateTimePicker;
    dtTo: TwwDBDateTimePicker;
    FooterPanel: TDNMPanel;
    Label3: TLabel;
    lblTotal: TLabel;
    Lin3: TMenuItem;
    AddCustomFilter1: TMenuItem;
    cboCustomFilter: TwwDBLookupCombo;
    Label1: TLabel;
    qryCustomFilter: TMyQuery;
    ExcludeinFilter: TMenuItem;
    AddPartialtoFilter: TMenuItem;
    ExcludePartialFilter: TMenuItem;
    CustomInputBox1: TCustomInputBox;
    actExcludeinFilter: TAction;
    actAddPartialtoFilter: TAction;
    actExcludePartialFilter: TAction;
    Lin2: TMenuItem;
    Requery: TMenuItem;
    actRequery: TAction;
    pnlfilter: TDNMPanel;
    Label2: TLabel;
    Label4: TLabel;
    cboFilter: TComboBox;
    edtSearch: TEdit;
    DNMPanel1: TDNMPanel;
    rgOptions: TwwRadioGroup;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnCustomize: TDNMSpeedButton;
    cmdClose: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    cmdPrint: TDNMSpeedButton;
    cmdExport: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdCloseClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure grdMainTitleButtonClick(Sender: TObject; Const AFieldName: String);
    procedure grdMainCalcTitleImage(Sender: TObject; Field: TField; var TitleImageAttributes: TwwTitleImageAttributes);
    procedure dtFromChange(Sender: TObject);
    procedure dtToChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure grdMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actClearFilterExecute(Sender: TObject);
    procedure actAddFilterExecute(Sender: TObject);
    procedure cboDateRangeChange(Sender: TObject);
    procedure cmdPrintMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure AddCustomFilter1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cboCustomFilterChange(Sender: TObject);
    procedure actExcludePartialFilterExecute(Sender: TObject);
    procedure actAddPartialtoFilterExecute(Sender: TObject);
    procedure actExcludeinFilterExecute(Sender: TObject);
    procedure actRequeryExecute(Sender: TObject);
    procedure grdMainColEnter(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure rgOptionsChange(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
  private
    { Private declarations }
    ToPrevDate:TDateTime;
    FromPrevDate:TDateTime;    
    HIGHLIGHTLOCATE : TColor;
    fsSubsequentID: String;
    Sort: String;
    flstFilter: TStringList;
    NoCustomFilterChange: Boolean;
    procedure FilterExecute;
    function GetFilter: TStringList;
    function GetFilterString: string;
    procedure PopulateFilterCombo;
  protected
    bmBookmark: TBookmark;
    PermFilterString,DateFilterString: String;
    fiGuiID: Integer;
    fbDateRangeSupplied: boolean;
    GuiPrefs: TFormGuiPrefs;
    procedure RefreshQuery; virtual;
    procedure RefreshTotals; virtual;
    procedure HandleUnknownException(const e: Exception);
    procedure HandleEAbortException;
    procedure HandleNoAccessException(const e: Exception);
    property FilterList: TStringList read GetFilter write flstFilter;
  public
    { Public declarations }
    AllowAssignUser: Boolean;
    procedure UpdateMe;
  end;

implementation
Uses
  BaseDataMod,FormFactory,Main,FuncLib,StrUtils,DateUtils,BaseInputForm,
  UserInfoObj,CustomFilterGUI,wwexport, FastFuncs;
{$R *.dfm}

Const
  GRID_FONT = 'GridFont';
  GRID_FONT_SIZE = 'GridFontSize';
  GRID_FONT_COLOR = 'GridFontColor';
  TITLE_FONT = 'TitleFont';
  TITLE_FONT_SIZE = 'TitleFontSize';
  TITLE_FONT_COLOR = 'TitleFontColor';
  HIGHLIGHTLOCATEDEF = $00DFFFFE;  // a very light yellow rw

procedure TBaseListingGUI.FormCreate(Sender: TObject);
var
  SavedCursor: TCursor;
begin
  AllowAssignUser := False;
  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    qryListData.Connection := BaseDataModule.NonTransDBConnection; 
    fbDateRangeSupplied := False;
    NoCustomFilterChange := False;
    fiGuiID := 0;
    HIGHLIGHTLOCATE := HIGHLIGHTLOCATEDEF;
    GuiPrefs:= TFormGuiPrefs.Create(self);
    GuiPrefs.Elements.Add('TwwDbGridGuiElement', grdMain);
    SetButtonProperties(Self);
  finally
    Screen.Cursor := SavedCursor;
  end;
end;

procedure TBaseListingGUI.FormShow(Sender: TObject);
var
  SavedCursor: TCursor;
  FilterName: String;
begin //---->> TBaseListingGUI.FormShow
  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    try
      TitleLabel.Caption := Self.Caption;
      dtFrom.Date := StartOfTheMonth(Date);
      dtTo.Date := IncDay(IncMonth(dtFrom.Date), -1);
      dtFromChange(nil);
      dtToChange(nil);
      Top := ((MainGUI.ClientHeight - MainGUI.StatusBar.Height) - Self.Height) div 2;
      Left := (MainGUI.ClientWidth - Self.Width) div 2;
      Application.ProcessMessages;
      actClearFilter.Enabled := Not Empty(GetFilterString);
      qryCustomFilter.Close;
      qryCustomFilter.Params.ParamByName('xUserID').asInteger := UserInfo.UserID;
      qryCustomFilter.Params.ParamByName('xClassName').asString := Self.ClassName;
      qryCustomFilter.Open;

      FilterName := GetDefaultFilter(Self.ClassName);
      If Empty(FilterName) then FilterName := 'None';
      qryCustomFilter.Locate('FilterName',FilterName,[loCaseInsensitive]);
      cboCustomFilter.Text := FilterName;

      RefreshQuery;

      GuiPrefs.Active:= true;
      PopulateFilterCombo;

    except
      on EAbort do HandleEAbortException;
    end;
  finally
    Screen.Cursor := SavedCursor;
  end;
end;

procedure TBaseListingGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TBaseListingGUI.cmdCloseClick(Sender: TObject);
begin
  Self.qryListData.Close;
  Self.Close;
end;

procedure TBaseListingGUI.RefreshQuery;
var
  iIndex: Integer;
begin //-->RefreshQuery
  Self.qryListData.Close;
  Self.qryListData.Open;
  If cboCustomFilter.Visible AND qryCustomFilter.Active then cboCustomFilterChange(cboCustomFilter);
  for iIndex := 0 to Self.qryListData.fields.count - 1 do begin
      if Self.qryListData.fields[iIndex].DisplayWidth > 20 then begin
        Self.qryListData.fields[iIndex].DisplayWidth := 20;
      end;
  end;
  PopulateFilterCombo;
  lblTotal.Caption := FastFuncs.IntToStr(Self.qryListData.RecordCount);
  RefreshTotals;
  grdMain.UnselectAll;
  GuiPrefs.ApplyGuiPrefs;
end;

procedure TBaseListingGUI.RefreshTotals;
begin
  //Doesn't do anything here, refreshes totals in descendant classes where necessary !
end;

procedure TBaseListingGUI.grdMainDblClick(Sender: TObject);
Var
  frmPopup: TBaseInputGUI;
  SavedCursor: TCursor;
begin
  inherited;
  if (grdMain.GetActiveField.DataType =ftMemo) then Exit;
  if not Empty(grdMain.GetActiveField.AsString) then begin
    bmBookmark := qryListData.GetBookmark;
      {Create the appropriate form to display}
      FormFact.FieldName := grdMain.GetActiveField.FieldName;
      SavedCursor := Screen.Cursor;
      Screen.Cursor := crHourGlass;    { Show hourglass cursor }
      try
        frmPopup := FormFact.CreateForm[ClassName + chr(95) +
                                        grdMain.GetActiveField.FieldName + fsSubsequentID];

        if assigned(frmPopup) then begin
          with frmPopup do try
            if IsInteger(Self.qryListData.Fields.fieldbyname(FormFact.Identifier).AsString) then Begin {This Is An Attempt to handle GlobalRef's}
              frmPopup.KeyID := Self.qryListData.Fields.fieldbyname(FormFact.Identifier).AsInteger;
            end;

            frmPopup.AttachObserver(Self);

            if not frmPopup.Visible then begin
              frmPopup.FormStyle := fsMDIChild; //Shows the form in MDIChild mode.
            end else begin
              frmPopup.OnShow(Self); //Needs this to refresh itself when a new KeyID is selected
            end;

            frmPopup.BringToFront;
          except
            on e: exception do begin
              raise exception.Create(e.message);
            end;
          end;
        end else begin
          MessageDlg('No further information available on this column. ', mtInformation, [mbOK], 0);
        end;
      finally
        Screen.Cursor := SavedCursor;
      end;
    end;
end;

procedure TBaseListingGUI.cmdExportClick(Sender: TObject);
Var
  sFileExt: String;
begin
  dlgSave.Title := 'Export - ' + Caption;
  if dlgSave.Execute then begin
    grdMain.ExportOptions.Delimiter := #9;
    grdMain.ExportOptions.FileName := dlgSave.FileName;
    grdMain.ExportOptions.TitleName := Self.Caption;
    sFileExt := ExtractFileExt(dlgSave.FileName);
    if FastFuncs.SameText(FastFuncs.LowerCase(sFileExt), '.txt') then begin
      grdMain.ExportOptions.ExportType := wwgetTxt;
      grdMain.ExportOptions.Delimiter := #9;
    end else if FastFuncs.SameText(FastFuncs.LowerCase(sFileExt), '.csv') then begin
      grdMain.ExportOptions.ExportType := wwgetTxt;
      grdMain.ExportOptions.Delimiter := ',';
    end else if FastFuncs.SameText(FastFuncs.LowerCase(sFileExt), '.slk') then begin
      grdMain.ExportOptions.ExportType := wwgetSYLK;
    end else if FastFuncs.SameText(FastFuncs.LowerCase(sFileExt), '.html') then begin
      grdMain.ExportOptions.ExportType := wwgetHTML;
    end else  begin
      MessageDlg('Unsupported Export Format.' + #13 + #10 + '' + #13 + #10 + 'Defaulted To Text (*.TXT) Format Export.', mtWarning, [mbOK], 0);
      grdMain.ExportOptions.ExportType := wwgetTxt;
      grdMain.ExportOptions.Delimiter := #9;
    end;
    grdMain.ExportOptions.Save;
  end;
end;

procedure TBaseListingGUI.cmdPrintClick(Sender: TObject);
var
  SavedCursor: TCursor;
begin
  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    If not Empty(ReportName) Then Begin
      If cmdPrint.Caption = 'Designer' then Begin
        DesignReport;
        cmdPrint.Caption := 'Print';
      end else If cmdPrint.Caption = 'Import' then Begin
        ImportReport;
        cmdPrint.Caption := 'Print';
      end else If cmdPrint.Caption = 'Export' then Begin
        ExportReport;
        cmdPrint.Caption := 'Print';
      end else begin
        PrintReport;
      end;
    end;
  finally
    ReportName := '';
    Screen.Cursor := SavedCursor;
  end;
end;

procedure TBaseListingGUI.UpdateMe;
Var
  TmpFilter: String;
begin
  NoCustomFilterChange := True;
  TmpFilter := cboCustomFilter.Text;
  qryCustomFilter.Close;
  qryCustomFilter.Open;
  NoCustomFilterChange := False;
  If cboCustomFilter.LookupTable.Locate('FilterName',TmpFilter,[loCaseInsensitive]) then
    cboCustomFilter.Text :=  TmpFilter;
  Self.RefreshQuery;
  if Assigned(grdMain) And (qryListData.RecordCount<>0) then begin
     if qryListData.BookmarkValid(bmBookmark) then begin
       try
        qryListData.GotoBookmark(bmBookmark);
       except
       end;
     end;
  end;
end;

procedure TBaseListingGUI.grdMainTitleButtonClick(Sender: TObject; Const AFieldName: String);
begin
  if (qryListData.fieldbyname(AFieldName).FieldKind <> fkLookup) and (qryListData.fieldbyname(AFieldName).DataType <> ftMemo)
     And (qryListData.fieldbyname(AFieldName).FieldKind <> fkCalculated)  then begin
    if FastFuncs.PosEx(QuotedStr(AFieldName)+' ASC CIS', Sort) <> 0 then begin
      Sort := QuotedStr(AFieldName)+' DESC CIS';
      qryListData.IndexFieldNames := Sort;
    end else begin
      Sort := QuotedStr(AFieldName) + ' ASC CIS';
      qryListData.IndexFieldNames := Sort;
    end;
  end;
end;

procedure TBaseListingGUI.grdMainCalcTitleImage(Sender: TObject;  Field: TField; var TitleImageAttributes: TwwTitleImageAttributes);
begin
  if FastFuncs.PosEx(QuotedStr(Field.FieldName) + ' ASC CIS', Sort) > 0 then begin
    TitleImageAttributes.ImageIndex := 2;
  end else if FastFuncs.PosEx(QuotedStr(Field.FieldName) + ' DESC CIS', Sort) > 0 then begin
    TitleImageAttributes.ImageIndex := 3;
  end else begin
    TitleImageAttributes.ImageIndex := -1;
  end;
end;

procedure TBaseListingGUI.dtFromChange(Sender: TObject);
begin
 If (fsShowing in Self.FormState) OR (fsCreating in Self.FormState) then Exit;
 If not dtFrom.DroppedDown Then Begin
   If Not (dtFrom.DateTime=FromPrevDate) then Begin
      DateFilterString := 'Date >='+QuotedStr(DateToStr(dtFrom.DateTime))+' AND Date <='+QuotedStr(DateToStr(dtTo.DateTime));
   end;
   FromPrevDate := dtFrom.DateTime;
 end;
 RefreshQuery;
end;

procedure TBaseListingGUI.dtToChange(Sender: TObject);
begin
 If (fsShowing in Self.FormState) OR (fsCreating in Self.FormState) then Exit;
 If not dtTo.DroppedDown Then Begin
   If Not (dtTo.DateTime=ToPrevDate) then Begin
      DateFilterString := '[Date]>='+QuotedStr(DateToStr(dtFrom.DateTime))+' AND [Date]<='+QuotedStr(DateToStr(dtTo.DateTime));
   end;
   ToPrevDate:= dtTo.DateTime;
 end;
 RefreshQuery;
end;

procedure TBaseListingGUI.HandleUnknownException(const e: Exception);
begin
  MessageDlg(e.Message + chr(13) + 'Errors occured in ' + Self.ClassName, mtError, [mbOK], 0);
  Self.Close; {Don't open the form if errors occur, too risky!!}
end;

procedure TBaseListingGUI.HandleEAbortException;
begin
  {Aborting used to manage access levels - Caught the exception, but don't do anything with it}
end;

procedure TBaseListingGUI.HandleNoAccessException(const e: Exception);
begin
  {User doesn't have access to this form}
  MessageDlg(e.Message, mtInformation, [mbOK], 0);
  Self.Close;
end;

procedure TBaseListingGUI.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
  begin
    // Clear the keycode to ensure we dont get a repeats.
    Key := 0;
    // Close the MDI window.
    Close;
  end;
end;

procedure TBaseListingGUI.grdMainKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // Was the return key pressed? if so,
  // then show selected record.
  if Key = VK_RETURN then
  begin
    // Show Current Selected Record.
    grdMainDblClick(Sender);
    Key := 0;
    exit;
  end;
end;

procedure TBaseListingGUI.cboDateRangeChange(Sender: TObject);
const
  // Date Range Combo values
  TODAY         = 0;
  YESTEDAY      = 1;
  LAST_WEEK     = 2;
  LAST_MONTH    = 3;
  LAST_QUARTER  = 4;
  LAST_12_MONTHS = 5;
  PREV_WEEK =     6;
  PREV_MONTH =    7;
  PREV_QUARTER =   8;
  PREV_FINANCIAL_YEAR = 9;
  THIS_WEEK      = 10;
  THIS_MONTH     = 11;
  THIS_QUARTER   = 12;
  THIS_FINANCIAL_YEAR = 13;


  function StartOfTheQuarter(const dtDate: TDateTime): TDateTime;
  var
    iMonth: Integer;
    iQuater: Integer;
    iStartMonth: Integer;
  begin
    iMonth := MonthOfTheYear(dtDate);
    iQuater := (iMonth - 1) div 3 + 1;
    iStartMonth :=  (iQuater - 1) * 3 + 1;
    Result := StartOfTheMonth(RecodeMonth(dtDate, iStartMonth));
  end;

begin
  inherited;
  case cboDateRange.ItemIndex of
    TODAY:  begin
      dtFrom.Date := Date;
      dtTo.Date := Date;
    end;
    YESTEDAY:  begin
      dtFrom.Date := IncDay(Date, -1);
      dtTo.Date := IncDay(Date, -1);
    end;
    LAST_WEEK: begin
      dtFrom.Date := IncDay(Date, -6);
      dtTo.Date := Date;
    end;
    LAST_MONTH: begin
      dtFrom.Date := IncDay(IncMonth(Date, -1));
      dtTo.Date := Date;
    end;
    LAST_QUARTER: begin
      dtFrom.Date := IncDay(IncMonth(Date, -3));
      dtTo.Date := Date;
    end;
    LAST_12_MONTHS: begin
      dtFrom.Date := IncDay(IncYear(Date, -1));
      dtTo.Date := Date;
    end;
    PREV_WEEK: begin
      dtFrom.Date := IncWeek(StartOfTheWeek(Date), -1);
      dtTo.Date := IncDay(dtFrom.Date, 6);
    end;
    PREV_MONTH: begin
      dtFrom.Date := IncMonth(StartOfTheMonth(Date), -1);
      dtTo.Date := IncDay(IncMonth(dtFrom.Date), -1);
    end;
    PREV_QUARTER: begin
      dtFrom.Date := IncMonth(StartOfTheQuarter(Date), -3);
      dtTo.Date := IncDay(IncMonth(dtFrom.Date, 3), -1);
    end;
    PREV_FINANCIAL_YEAR: begin
      if MonthOfTheYear(Date) <= 6 then begin
        dtFrom.Date := IncYear(IncMonth(StartOfTheYear(IncYear(Date, -1)), 6), -1);
      end else begin
        dtFrom.Date := IncYear(IncMonth(StartOfTheYear(Date), 6), -1);
      end;
      dtTo.Date := IncDay(IncYear(dtFrom.Date), -1);
    end;
    THIS_WEEK: begin
      dtFrom.Date := StartOfTheWeek(Date);
      dtTo.Date := IncDay(dtFrom.Date, 6);
    end;
    THIS_MONTH: begin
      dtFrom.Date := StartOfTheMonth(Date);
      dtTo.Date := IncDay(IncMonth(dtFrom.Date), -1);
    end;
    THIS_QUARTER: begin
      dtFrom.Date := StartOfTheQuarter(Date);
      dtTo.Date := IncDay(IncMonth(dtFrom.Date, 3), -1);
    end;
    THIS_FINANCIAL_YEAR: begin
      if MonthOfTheYear(Date) <= 6 then begin
        dtFrom.Date := IncMonth(StartOfTheYear(IncYear(Date, -1)), 6);
      end else begin
        dtFrom.Date := IncMonth(StartOfTheYear(Date), 6);
      end;
      dtTo.Date := IncDay(IncYear(dtFrom.Date), -1);
    end;
  end;
  dtFromChange(nil);
  dtToChange(nil);
end;

procedure TBaseListingGUI.cmdPrintMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if (Shift=[ssCtrl]) then begin
     cmdPrint.Caption := 'Designer';
  end else if (Shift=[ssCtrl,ssShift]) then begin
     cmdPrint.Caption := 'Export';
  end else if (Shift=[ssCtrl,ssAlt]) then begin
     cmdPrint.Caption := 'Import';
  end else Begin
     cmdPrint.Caption := 'Print';
  end;
end;

procedure TBaseListingGUI.AddCustomFilter1Click(Sender: TObject);
begin
  inherited;
  with TCustomFilter(TCustomFilter.Instance) do begin
    ListUserID := UserInfo.UserID;
    ListFilter := GetFilter.Text;
    ListClassName := Self.ClassName;
    ListName := Self.pnlHeader.Caption;
    AttachObserver(Self);
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

function TBaseListingGUI.GetFilter: TStringList;
begin
  if not Assigned(flstFilter) then begin
    flstFilter:= TStringList.Create;
    flstFilter.Sorted := true;
    flstFilter.Duplicates := dupError;
  end;
  Result := flstFilter;
end;

procedure TBaseListingGUI.FormDestroy(Sender: TObject);
begin
  if Assigned(flstFilter) then
    FreeAndNil(flstFilter);
  inherited;
end;

function TBaseListingGUI.GetFilterString: string;
var
  iIndex: Integer;
begin
  result:= '';
  for iIndex := 0 to FilterList.Count - 1 do
  begin
    if iIndex > 0 then begin
      if (FilterList.Names[iIndex] = FilterList.Names[iIndex -1]) and (FastFuncs.PosEx('<>',FilterList.Strings[iIndex])=0) then
        result:= result + ' OR '
      else
        result:= result + ' AND ';

    end;
    if ((iIndex < FilterList.Count - 1) and
        (FilterList.Names[iIndex] = FilterList.Names[iIndex +1])) then begin
      if not ((iIndex > 0) and (FilterList.Names[iIndex] = FilterList.Names[iIndex -1])) then
        result:= result + '(';
    end;

    result:= result + FilterList.Strings[iIndex];

    if (iIndex > 0) and
       (FilterList.Names[iIndex] = FilterList.Names[iIndex -1]) then begin
      if (iIndex = FilterList.Count - 1) or
         (FilterList.Names[iIndex] <> FilterList.Names[iIndex +1]) then
        result:= result + ')';
    end;
  end;
  if FilterList.Count > 1 then
    result:= '(' + result + ')';

  If FastFuncs.SameText(result,'(') then result := '';  

end;

procedure TBaseListingGUI.cboCustomFilterChange(Sender: TObject);
Var
  fsFilterString: String;
begin
  If NoCustomFilterChange then Exit;
  try
    inherited;
    If (cboCustomFilter.LookupTable.FieldByName('CustomFilterID').AsInteger=0) then Begin
      FilterList.Clear;
      qryListData.Filtered := False;
      qryListData.Filter := '';
    end else begin
      GetFilter.Text := cboCustomFilter.LookupTable.FieldByName('Filter').AsString;
      fsFilterString := GetFilterString;
      if not Empty(fsFilterString) then begin
        qryListData.Filtered := False;
        qryListData.Filter := fsFilterString;
        qryListData.Filtered := True;
      end;
    end;
  except
    on e: exception do begin
      raise Exception.Create(e.Message + chr(13) + 'Please review your filter and try again.');
    end;
  end;
  lblTotal.Caption := FastFuncs.IntToStr(qryListData.RecordCount);
  RefreshTotals;
  actClearFilter.Enabled := Not Empty(fsFilterString);
end;


procedure TBaseListingGUI.actClearFilterExecute(Sender: TObject);
begin
  FilterList.Clear;
  qryListData.Filtered := False;
  qryListData.Filter := '';
  lblTotal.Caption := FastFuncs.IntToStr(qryListData.RecordCount);
  RefreshTotals;
  actClearFilter.Enabled := Not Empty(GetFilterString);
end;

procedure TBaseListingGUI.FilterExecute;
Var
  fsFilterString: String;
begin
  try
    fsFilterString := GetFilterString;
    if not Empty(fsFilterString) then begin
      qryListData.Filtered := False;
      qryListData.Filter := fsFilterString;
      qryListData.Filtered := True;
    end;
  except
    on e: exception do begin
      raise Exception.Create(e.Message + chr(13) + 'Please review your filter and try again.');
    end;
  end;
  lblTotal.Caption := FastFuncs.IntToStr(qryListData.RecordCount);
  RefreshTotals;
  actClearFilter.Enabled := Not Empty(fsFilterString);
end;

procedure TBaseListingGUI.actAddFilterExecute(Sender: TObject);
begin
  If Empty(FastFuncs.Trim(grdMain.GetActiveField.AsString)) then Exit;
  FilterList.Add('[' + grdMain.GetActiveField.FieldName + ']=' + QuotedStr(grdMain.GetActiveField.AsString));
  FilterExecute;
end;

procedure TBaseListingGUI.actExcludeinFilterExecute(Sender: TObject);
begin
  inherited;
  If Empty(FastFuncs.Trim(grdMain.GetActiveField.AsString)) then Exit;
  FilterList.Add('[' + grdMain.GetActiveField.FieldName + ']<>' + QuotedStr(grdMain.GetActiveField.AsString));
  FilterExecute;
end;

procedure TBaseListingGUI.actAddPartialtoFilterExecute(Sender: TObject);
Var
  PartialString:String;
  ModifyPartialString: TCustomInputBox;
begin
  inherited;
  If Empty(FastFuncs.Trim(grdMain.GetActiveField.AsString)) then Exit;
  PartialString := grdMain.GetActiveField.AsString;
  ModifyPartialString := TCustomInputBox.Create(Self);
  Try
    ModifyPartialString.Caption :=  'Add Partial Filter';
    ModifyPartialString.Message := 'Enter Filter';
    ModifyPartialString.EditBoxFont.Name := 'Arial';
    ModifyPartialString.EditBoxFont.Size := 14;
    ModifyPartialString.DefaultString := PartialString;
    ModifyPartialString.MessageFont.Name := 'Arial';
    ModifyPartialString.MessageFont.Size := 12;
    ModifyPartialString.MessageFont.Style := [fsBold];
    ModifyPartialString.Height := 110;
    If ModifyPartialString.Execute then begin
      PartialString := ModifyPartialString.InputResult;
      FilterList.Add('[' + grdMain.GetActiveField.FieldName + ']=' + QuotedStr(PartialString+'*'));
      FilterExecute;
    End;
  finally
    ModifyPartialString.Free;
  end;
end;


procedure TBaseListingGUI.actExcludePartialFilterExecute(Sender: TObject);
Var
  PartialString:String;
  ModifyPartialString: TCustomInputBox;
begin
  inherited;
  If Empty(FastFuncs.Trim(grdMain.GetActiveField.AsString)) then Exit;
  PartialString := grdMain.GetActiveField.AsString;
  ModifyPartialString := TCustomInputBox.Create(Self);
  Try
    ModifyPartialString.Caption :=  'Exclude Partial Filter';
    ModifyPartialString.Message := 'Enter Filter';
    ModifyPartialString.EditBoxFont.Name := 'Arial';
    ModifyPartialString.EditBoxFont.Size := 14;
    ModifyPartialString.DefaultString := PartialString;
    ModifyPartialString.MessageFont.Name := 'Arial';
    ModifyPartialString.MessageFont.Size := 12;
    ModifyPartialString.MessageFont.Style := [fsBold];
    ModifyPartialString.Height := 110;
    If ModifyPartialString.Execute then begin
      PartialString := ModifyPartialString.InputResult;
      FilterList.Add('[' + grdMain.GetActiveField.FieldName + ']<>' + QuotedStr(PartialString+'*'));
      FilterExecute;
    End;
  finally
    ModifyPartialString.Free;
  end;
end;

procedure TBaseListingGUI.actRequeryExecute(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TBaseListingGUI.PopulateFilterCombo;
var
  iIndex: Integer;
  sLabel: string;
begin
  cboFilter.Items.Clear;
  for iIndex := 0 to qryListData.fields.count - 1 do begin
    if (qryListData.fields[iIndex].Visible) and
      ((qryListData.Fields[iIndex].DataType = ftString) or
      (qryListData.Fields[iIndex].DataType = ftWideString) or
      (qryListData.Fields[iIndex].DataType = ftMemo) or
      (qryListData.Fields[iIndex].DataType = ftLargeint) or      
      (qryListData.Fields[iIndex].DataType = ftInteger))
      and (qryListData.Fields[iIndex].FieldKind <> fkLookup) then begin
      sLabel := grdMain.ColumnByName(qryListData.Fields[iIndex].FieldName).DisplayLabel;
      if not Empty(sLabel) and (qryListData.Fields[iIndex].Visible) then begin
        cboFilter.Items.AddObject(sLabel, qryListData.Fields[iIndex]);
      end;
    end;
  end;
  cboFilter.Refresh;
  cboFilter.ItemIndex := 0;
end;

procedure TBaseListingGUI.grdMainColEnter(Sender: TObject);
var
  iIndex: Integer;
begin
  inherited;
  try
    iIndex := cboFilter.Items.IndexOf(TwwDBGrid(Sender).ColumnByName(TwwDBGrid(Sender).GetActiveField.FieldName).DisplayLabel);
    if iIndex <> -1 then
      cboFilter.ItemIndex := iIndex;
  except
  end;
end;


procedure TBaseListingGUI.edtSearchChange(Sender: TObject);
var
  sFieldName: string;
  tmpIndex: string;
begin
  inherited;
  if (edtSearch.text <> '') and (cboFilter.Text <> '') then begin
    sFieldName := TField(cboFilter.Items.Objects[cboFilter.ItemIndex]).FieldName;
    if dsMain.Dataset.FindField(sFieldName) <> nil then begin
      try
        tmpIndex := QuotedStr(sFieldName) + ' ASC CIS;';
        qryListData.IndexFieldNames := tmpIndex;
        dsMain.Dataset.Locate(sFieldName, ReplaceStr(ReplaceStr(edtSearch.text, '%', ''), '*', ''), [loCaseInsensitive, loPartialKey]);
      except
      end;
    end;
  end;
end;
  
procedure TBaseListingGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if (not Empty(cboFilter.Text)) and (cboFilter.ItemIndex >= 0) and (not (gdSelected in State) or not TwwDBGrid(Sender).Focused) then begin
    try
      if (FastFuncs.PosEx(FastFuncs.UpperCase(ReplaceStr(ReplaceStr(edtSearch.text, '%', ''), '*', '')),
      FastFuncs.UpperCase(TField(cboFilter.Items.Objects[cboFilter.ItemIndex]).AsString)) = 1) then
      begin
        ABrush.Color := HIGHLIGHTLOCATE;
      end;
    except
    end;
  end;
end;

procedure TBaseListingGUI.rgOptionsChange(Sender: TObject);
begin
  inherited;
  Self.RefreshQuery;
end;

procedure TBaseListingGUI.btnCustomizeClick(Sender: TObject);
begin
  inherited;
  GuiPrefs.ShowCustomiseForm;
end;

end.


