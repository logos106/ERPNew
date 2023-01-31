unit SummarysheetCategory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SummarySheets, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  AdvSplitter, BaseListingForm, CustomInputBox, wwclearbuttongroup, wwradiogroup,
  GIFImg;

type
  TSummarysheetCategoryGUI = class(TSummarySheetsGUI)
    qryMainAmt35: TFloatField;
    qryMainAmt36: TFloatField;
    qryMainAmt37: TFloatField;
    qryMainAmt38: TFloatField;
    Shader1: TShader;
    lblActiveForm: TLabel;
    pnlCategories: TDNMPanel;
    btnGeneral: TDNMSpeedButton;
    btnPayables: TDNMSpeedButton;
    btnReceivables: TDNMSpeedButton;
    btnLastWeek: TDNMSpeedButton;
    btnLastMonth: TDNMSpeedButton;
    btnLast3Months: TDNMSpeedButton;
    btnLast12Months: TDNMSpeedButton;
    btnAll: TDNMSpeedButton;
    btnOpenList: TDNMSpeedButton;
    pnlFxTrading: TDNMPanel;
    Splitter: TAdvSplitter;
    Shader2: TShader;
    Label4: TLabel;
    btnRefresh: TDNMSpeedButton;
    btnLast6Months: TDNMSpeedButton;
    pnlcustomDate: TPanel;
    Label2: TLabel;
    dtcustomFrom: TwwDBDateTimePicker;
    shpcustmdate: TShape;
    lblcurrencyhint: TLabel;
    btnHowTo: TDNMSpeedButton;
    DNMSpeedButton1: TDNMSpeedButton;
    procedure mainbuttonclick(Sender: TObject);
    procedure btnOpenListClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DoCustomDatechange(Sender: TObject);
    procedure shpcustmdateMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DoCustomDate(Sender: TObject);
    procedure btnHowToClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
  private
    fFxTradingList : TBaseListingGUI;
    procedure beforeshowSummarySheets(Sender: TObject);
    function FxTradingList: TBaseListingGUI;
    Procedure ShowFXTradingList;
    Procedure SetPageno(const Value:Integer);
    procedure initCaption;
    Procedure CheckclosingDates;
  Protected
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    Function CustomRangeFrom:Tdatetime;Override;
    function customDateCaption:String;Override;
    procedure beforeshowSummarySheet(Sender: TObject);Override;
  public
    Procedure RefreshQuery;Override;
  end;

implementation

uses dateutils, CommonFormLib, CommonLib, SummarySheetObj, frmSummarySheetFrm,
  AppEnvironment, DbSharedObjectsObj, CommonDbLib, tcConst, DocReaderObj;

{$R *.dfm}

procedure TSummarysheetCategoryGUI.mainbuttonclick(Sender: TObject);
begin
  inherited;
  if not (sender is TDNMSpeedbutton) then Exit;
  highlightcontrol(TDNMSpeedbutton(Sender));
  HighlightextraControl1(Panel1);
  With TDNMSpeedbutton(Sender) do begin
    fiPageno := tag;
    Setupgrid;
    initCaption;
    if isformshown then
      if (TDNMSpeedbutton(Sender).tag-3>=1) and (TDNMSpeedbutton(Sender).tag-3<=5) and (TDNMSpeedbutton(Sender).hint <> '') then
        if incSecond(incday(filterDateto , 0-SummarySheetParamObj.days[TDNMSpeedbutton(Sender).tag-3] ),1) <= AppEnv.CompanyPrefs.ClosingDate then
          MessageDlgXP_vista('This is the Summary '+ trim(TDNMSpeedbutton(Sender).hint)+'.'+NL+NL+
                           'To Cross Check the Values in the Detail Reports, Please Choose the Same Date Range.'+NL+
                           'Choose ''Include data Prior to Closing Date'' if Applicable.', mtInformation, [mbOK], 0);
  end;

end;

procedure TSummarysheetCategoryGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if GuiPrefs.Node['Options.FXPanelHeight'].asInteger <> 0 then  (*grdMain*)pnlFxTrading.height := GuiPrefs.Node['Options.FXPanelHeight'].asInteger;
  if GuiPrefs.Node.Exists('Options.customFrom') then dtcustomFrom.Datetime := GuiPrefs.Node['Options.customFrom'].asDatetime;
  SetPageNo(GuiPrefs.Node['Options.PAgeNo'].asInteger);
end;

procedure TSummarysheetCategoryGUI.RefreshQuery;
begin
  inherited;
  showcontrolhint(btnLastWeek     , 'From '+ FormatDatetime(FormatSettings.ShortDateFormat , incSecond(incday(filterDateto , 0-SummarySheetParamObj.days[1] ),1)) +' to ' + FormatDatetime(FormatSettings.ShortDateFormat , filterDateto)) ;
  showcontrolhint(btnLastMonth    , 'From '+ FormatDatetime(FormatSettings.ShortDateFormat , incSecond(incday(filterDateto , 0-SummarySheetParamObj.days[2] ),1)) +' to ' + FormatDatetime(FormatSettings.ShortDateFormat , filterDateto)) ;
  showcontrolhint(btnLast3Months  , 'From '+ FormatDatetime(FormatSettings.ShortDateFormat , incSecond(incday(filterDateto , 0-SummarySheetParamObj.days[3] ),1)) +' to ' + FormatDatetime(FormatSettings.ShortDateFormat , filterDateto)) ;
  showcontrolhint(btnLast6Months  , 'From '+ FormatDatetime(FormatSettings.ShortDateFormat , incSecond(incday(filterDateto , 0-SummarySheetParamObj.days[4] ),1)) +' to ' + FormatDatetime(FormatSettings.ShortDateFormat , filterDateto)) ;
  showcontrolhint(btnLast12Months , 'From '+ FormatDatetime(FormatSettings.ShortDateFormat , incSecond(incday(filterDateto , 0-SummarySheetParamObj.days[5] ),1)) +' to ' + FormatDatetime(FormatSettings.ShortDateFormat , filterDateto)) ;
  showcontrolhint(pnlcustomDate , customDateCaption) ;
  initCaption;
end;

procedure TSummarysheetCategoryGUI.SetPageno(const Value: Integer);
var
  ctr:Integer;
begin
  if Value = dtcustomFrom.Tag then begin
    SetcontrolFocus(dtcustomFrom);
    DoCustomDate(dtcustomFrom);
  end;
  for ctr:= 0 to componentcount-1 do
    if components[ctr] is TDNMSpeedbutton then
      if TDNMSpeedbutton(components[ctr]).parent = pnlCategories then
        if TDNMSpeedbutton(components[ctr]).tag = Value then begin
          TDNMSpeedbutton(components[ctr]).click;
          Exit;
        end;
end;


procedure TSummarysheetCategoryGUI.initCaption;
var
  btn:TDnmSpeedbutton ;
begin
  inherited;
  btn := nil;
  lblActiveForm.caption := '';
  case fiPageno of
    0 : btn := btnall;
    1 : btn := btnGeneral;
    2 : btn := btnPayables;
    3 : btn := btnReceivables;
    4 : btn := btnLastWeek;
    5 : btn := btnLastMonth;
    6 : btn := btnLast3Months;
    7 : btn := btnLast6Months;
    8 : btn := btnLast12Months;
    else lblActiveForm.Caption := customdatecaption;//pnlActiveForm.caption :=customdatecaption;
  end;
  if btn <> nil then
    with btn do
      if hint <> '' then
        lblActiveForm.caption := Caption + ' ' + Copy(hint, 1, length(Hint) - 1)
      else     //pnlActiveForm.caption := Caption;
       lblActiveForm.Caption := Caption;
end;

procedure TSummarysheetCategoryGUI.ShowFXTradingList;
begin
    FxTradingList;
    if Assigned(fFxTradingList) then begin
      fFxTradingList.Parent := pnlFxTrading;
      fFxTradingList.BorderStyle := bsNone;
      fFxTradingList.fbIgnoreQuerySpeed := true;
      try
        fFxTradingList.show;
        fFxTradingList.height := 0;
        fFxTradingList.width :=0;

        fFxTradingList.grdmain.Parent := pnlFxTrading;
        fFxTradingList.grdmain.Align := alclient;
        fFxTradingList.grdmain.AlignWithMargins := TRue;
        fFxTradingList.grdmain.Margins.Left := 3;
        fFxTradingList.grdmain.Margins.Right := 3;
        fFxTradingList.grdmain.Margins.Top := 3;
        fFxTradingList.grdmain.Margins.Bottom := 3;

        fFxTradingList.Grdmain.TitleColor:= Self.Color;
        fFxTradingList.Grdmain.BorderStyle := bsSingle;
        fFxTradingList.Grdmain.Footercolor:= Self.Color;

(*        fFxTradingList.pnlButtons.visible := False;
        fFxTradingList.HeaderPanel.visible := False;*)
      except
        FreeAndNil(fFxTradingList);
      end;
    end;
end;

procedure TSummarysheetCategoryGUI.shpcustmdateMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  DoCustomDate(Sender);
end;

procedure TSummarysheetCategoryGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.FXPanelHeight'].asInteger:= (*grdMain*)pnlFxTrading.height;
  GuiPrefs.Node['Options.PageNo'].asInteger:= fiPageno;
  GuiPrefs.Node['Options.customFrom'].asDatetime := dtcustomFrom.Datetime;
end;

procedure TSummarysheetCategoryGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  OpenERpListForm('TSummarysheetCategoryDetailsGUI', CopyParamsto);
  CloseWait;
end;

procedure TSummarysheetCategoryGUI.DoCustomDate(Sender: TObject);
begin
  inherited;
  HighlightextraControl1(Panel1);
  highlightcontrol(pnlcustomDate);
//  pnlActiveForm.caption := customDateCaption;
  lblActiveForm.Caption := customDateCaption;
  fiPageno := 9;
  Setupgrid;
end;

procedure TSummarysheetCategoryGUI.DoCustomDatechange(Sender: TObject);
begin
  inherited;
  if not(dtcustomFrom.DroppedDown)  then begin
    RefreshQuery;
    DoCustomDate(Sender);
  end;
end;

procedure TSummarysheetCategoryGUI.btnCustomizeClick(Sender: TObject);
begin
  if fipageno <> 0 then begin
    inherited;
    Setupgrid;
  end else
    MessageDlgXP_Vista('Multiple Currencies cannot be selected when All categories are selected', mtInformation, [mbOK], 0);

end;

procedure TSummarysheetCategoryGUI.btnHowToClick(Sender: TObject);
begin
  inherited;
  TDocReaderObj.ShowERPHelp(nil, Self, true, 'Cross Company Stock');
end;

procedure TSummarysheetCategoryGUI.btnOpenListClick(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TSummarySheetsGUI' ,beforeshowSummarySheets);
  Self.Close;

end;
procedure TSummarysheetCategoryGUI.CheckclosingDates;
var
  Qry:TERPQuery;
begin
  inherited;
  Qry := dbsharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
     Qry.SQL.Text := ' Select min(closingdate) as Minclosingdate, MAx(closingdate) as Maxclosingdate from '     +Tablename;
     Qry.Open;
     if Qry.FieldByName('Minclosingdate').AsDateTime <> Qry.FieldByName('Maxclosingdate').AsDateTime then begin
      MessageDlgXP_Vista('Closing Date is not Same in All Selected Companies.'+NL+NL+
                         'For the Accuracy of Data in this Report, All the Selected Companies Should Have the Same Closing Date.', mtWarning, [mbOK], 0);
     end;
  finally
    Dbsharedobj.ReleaseObj(Qry);
  end;

end;

function TSummarysheetCategoryGUI.customDateCaption: String;
begin
  REsult := 'From '+ FormatDatetime(FormatSettings.ShortDateFormat , dtcustomFrom.Date) +' to ' + FormatDatetime(FormatSettings.ShortDateFormat , filterDateto) ;
end;

function TSummarysheetCategoryGUI.CustomRangeFrom: Tdatetime;
begin
  REsult := dtcustomFrom.DateTime;
end;

procedure TSummarysheetCategoryGUI.FormCreate(Sender: TObject);
begin
  inherited;
  TallerForm(650);
  btnRequery.parent := pnlCategories;
  btnRequery.top := btnRefresh.Top;
  btnRequery.Left := btnRefresh.Left;
  btnRequery.width := btnRefresh.Width;
  btnRequery.height := btnRefresh.height;
  btnRequery.visible := True;
  lblcurrencyhint.Caption := 'All Amounts are in ' + Quotedstr(Appenv.RegionalOptions.ForeignExDefault);
  grdmain.hint := lblcurrencyhint.Caption ;
end;

procedure TSummarysheetCategoryGUI.FormShow(Sender: TObject);
begin
  inherited;
  ShowFxTradingList;
  checkclosingDates;
end;

function TSummarysheetCategoryGUI.FxTradingList: TBaseListingGUI;
begin
  CreateHistorylistform('TFxTradingListGUI' ,Self, fFxTradingList );
  result := fFxTradingList;
end;

procedure TSummarysheetCategoryGUI.beforeshowSummarySheet(Sender: TObject);
begin
  inherited;
  TfrmSummarySheetGUI(Sender).dtcustomFrom.DateTime := dtcustomFrom.datetime
end;

procedure TSummarysheetCategoryGUI.beforeshowSummarySheets(Sender: TObject);
begin
  if not(Sender is TSummarySheetsGUI) then exit;
  TSummarySheetsGUI(Sender).dtfrom.date :=0;
  TSummarySheetsGUI(Sender).dtTo.date :=filterdateTo;
  TSummarySheetsGUI(Sender).Databases := databases;
  TSummarySheetsGUI(Sender).fbDateRangeSupplied := TRue;
end;
initialization
  RegisterClass(TSummarysheetCategoryGUI);
end.

