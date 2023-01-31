unit QuickBooksList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, SelectionDialog, Menus, ExtCtrls, StdCtrls, ComCtrls,
  DNMPanel, Shader , BaseListingForm, DNMSpeedButton,db, GuiPrefsObj , wwDbGrid;

type
  TGetSynchDataEvent = function(const SynchType: string; var Ok: boolean): string of object;

  TQuickBooksListGUI = class(TBaseForm)
    pnlFooter: TDNMPanel;
    pnlHeader: TDNMPanel;
    PgLists: TPageControl;
    TabAccounts: TTabSheet;
    tabTaxCodes: TTabSheet;
    TabTerms: TTabSheet;
    Panel1: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    pnlAccounts: TDNMPanel;
    pnlTaxcodes: TDNMPanel;
    pnlTerms: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    btnRequery: TDNMSpeedButton;
    btnunlink: TDNMSpeedButton;
    TabTaxrates: TTabSheet;
    pnlTaxRates: TDNMPanel;
    lblMsg: TLabel;
    tabPaymethods: TTabSheet;
    pnlPaymethods: TDNMPanel;
    btntest: TDNMSpeedButton;
    procedure FormResize(Sender: TObject);
    procedure PgListsResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdCloseClick(Sender: TObject);
    procedure btnRequeryClick(Sender: TObject);
    procedure PgListsChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnunlinkClick(Sender: TObject);
    procedure btntestClick(Sender: TObject);
  private
    fTaxcodes: TBaseListingGUI;
    fTerms: TBaseListingGUI;
    fAccounts: TBaseListingGUI;
    fPaymethods: TBaseListingGUI;
    fTaxRates: TBaseListingGUI;
    //fTaxCodeRates: TBaseListingGUI;
    fOnGetSynchData: TGetSynchDataEvent;
    GuiPrefs: TFormGuiPrefs;
    fDataOk: boolean;

    Function GetSynchdata(Synchtype :String): String;
    Function ActiveQBListform :TBaseListingGUI;
    procedure OnListDataScroll(Sender: TDataSet);
    function getAccountsTablename: String;
    function getPaymethodsTablename: String;
    function getTaxcodesTablename: String;
    function getTaxRatesTablename: String;
    function getTermsTablename: String;
  Protected
    procedure AfterFormShow;Override;
  public
    property OnGetSynchData: TGetSynchDataEvent read fOnGetSynchData write fOnGetSynchData;
    property AccountsTablename :String read getAccountsTablename;
    property PaymethodsTablename :String read getPaymethodsTablename;
    property TaxCodesTablename :String read getTaxcodesTablename;
    property TaxratesTablename :String read getTaxRatesTablename;
    property TermsTablename    :String read getTermsTablename;

    property AccountsForm :TBaseListingGUI read fAccounts;
    property PaymethodsForm :TBaseListingGUI read fPaymethods;
    property TaxCodesForm :TBaseListingGUI read fTaxcodes;
    property TaxratesForm :TBaseListingGUI read fTaxRates;
    property TermsForm    :TBaseListingGUI read fTerms;

  end;


implementation

uses CommonLib, DNMLib, QuickBooksAccountsList, QuickBooksPaymethodsList, QuickBooksTaxCodesList,
  QuickBooksTermsList, CommonFormLib, QuickBooksListBase, LogLib,
  ProgressDialog, QuickBooksTaxRateList, tcConst;

const
  tabAccountsidx  = 0;
  tabPaymethodsidx= 1;
  tabTaxCodesidx  = 2;
  TabTaxratesidx  = 3;
  tabTermsidx     = 4;

{$R *.dfm}

procedure TQuickBooksListGUI.btnunlinkClick(Sender: TObject);
begin
  inherited;
  if ActiveQBListform = nil then exit;
  TQuickBooksListBaseGUI(ActiveQBListform).RemoveXRef;
end;

procedure TQuickBooksListGUI.btnRequeryClick(Sender: TObject);
var
  ctr:Integer;
  fi:Integer;
begin
  inherited;
  fDataOk := true;
  fi := PgLists.tabindex;
  try
      Processingcursor(true);
      try
        DoShowProgressbar(PgLists.PageCount, WAITMSG);
        try
          for ctr := 0 to PgLists.PageCount-1 do begin
            PgLists.tabindex := ctr;
            if ActiveQBListform = nil then continue;
            TQuickBooksListBaseGUI(ActiveQBListform).Data := GetSynchdata(TQuickBooksListBaseGUI(ActiveQBListform).jsonListName);
            if not fDataOk then
              break;
            DoStepProgressbar(PgLists.ActivePage.caption);
          end;
        finally
          DoHideProgressbar;
        end;
      finally
        Processingcursor(False);
      end;
  finally
    PgLists.tabindex := fi;
  end;
end;

procedure TQuickBooksListGUI.btntestClick(Sender: TObject);
var
  ctr:Integer;
  fi:Integer;
begin
  inherited;
  fi := PgLists.tabindex;
  try
      Processingcursor(true);
      try
        DoShowProgressbar(PgLists.PageCount, WAITMSG);
        try
          for ctr := 0 to PgLists.PageCount-1 do begin
            PgLists.tabindex := ctr;
            if ActiveQBListform = nil then continue;
            TQuickBooksListBaseGUI(ActiveQBListform).btntest.click;
            DoStepProgressbar(PgLists.ActivePage.caption);
          end;
        finally
          DoHideProgressbar;
        end;
      finally
        Processingcursor(False);
      end;
  finally
    PgLists.tabindex := fi;
  end;
end;

procedure TQuickBooksListGUI.cmdCloseClick(Sender: TObject);
begin
  inherited;
  Self.close;
end;

procedure TQuickBooksListGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //GuiPrefs.Node['Options.TaxCodeRates.Width'].asInteger := pnlTaxCodeRate.Width ;
  inherited;
  action := cafree;
end;
procedure TQuickBooksListGUI.FormCreate(Sender: TObject);
(*  procedure showbtntext(btn:TDnmSpeedbutton);
  begin
      btn.Parent := pnlFooter;
      btn.Left := 10;
      btn.top := btnRequery.top;
  end;*)
  Procedure makenshowSubform(aFormName :String; var aFormInst: TBaseListingGUI; apnl:TDnmPanel);
  begin
    CreateHistorylistform(aFormName ,Self, aFormInst,'','');
    if Assigned(aFormInst) then begin
      aFormInst.align := alclient;
      aFormInst.BorderStyle := bsNone;
      aFormInst.Parent := apnl;
      aFormInst.fbIgnoreQuerySpeed := true;
      aFormInst.Show;
      if aFormInst is TQuickBooksListBaseGUI then begin
        //showbtntext(TQuickBooksListBaseGUI(aFormInst).btntest);
        aFormInst.OnDataScroll := OnListDataScroll;
      end;
    end;
  end;
begin
  inherited;
  //fTaxCodeRates := nil;
  btntest.visible := devmode;
  GuiPrefs := TFormGuiPrefs.Create(Self);
  GuiPrefs.PrefsName := Classname;
  GuiPrefs.Active := True;
  makenshowSubform('TQuickBooksAccountsListGUI' ,fAccounts,pnlaccounts);
  makenshowSubform('TQuickBooksPaymethodsListGUI' ,fPaymethods,pnlPaymethods);
  makenshowSubform('TQuickBooksTaxCodesListGUI' ,fTaxcodes,pnlTaxcodes);
  makenshowSubform('TQuickBooksTaxRateListGUI' ,fTaxRates,pnlTaxRates);
  makenshowSubform('TQuickBooksTermsListGUI' ,fTerms,pnlTerms);
end;

procedure TQuickBooksListGUI.OnListDataScroll(Sender: TDataSet);
begin
  btnunlink.Enabled := Sender.fieldbyname('ERPID').asInteger <> 0;
end;
function TQuickBooksListGUI.ActiveQBListform: TBaseListingGUI;
begin
       if PgLists.tabindex =tabAccountsidx    then result := fAccounts
  else if PgLists.tabindex =tabPaymethodsidx  then result := fPaymethods
  else if PgLists.tabindex =tabTaxCodesidx    then result := fTaxcodes
  else if PgLists.tabindex =TabTaxratesidx    then result := fTaxRates
  else if PgLists.tabindex =tabTermsidx       then result := fTerms
  else result := nil;
end;

procedure TQuickBooksListGUI.AfterFormShow;
begin
  inherited;
  RealignTabControl(PgLists, 1);
end;
procedure TQuickBooksListGUI.FormResize(Sender: TObject);
begin
  inherited;
  RealignTabControl(PgLists, 1);
end;

procedure TQuickBooksListGUI.FormShow(Sender: TObject);
begin
  inherited;
  PgLists.tabindex := PgLists.pagecount-1;
  PgLists.tabindex := tabAccountsidx;
  PgListsChange(PgLists);
end;


function TQuickBooksListGUI.GetSynchdata(Synchtype: String): String;
begin
  result := '';
  if not fDataOk then
    exit;
  if Assigned(fOnGetSynchData) then begin
    result := fOnGetSynchData(Synchtype, fDataOk);
    exit;
  end;
end;

function TQuickBooksListGUI.getAccountsTablename: String;begin   Result := '';   if assigned(fAccounts) then result := TQuickBooksListBaseGUI(fAccounts).reporttablename; end;
function TQuickBooksListGUI.getPaymethodsTablename: String;begin   Result := '';   if assigned(fPaymethods) then result := TQuickBooksListBaseGUI(fPaymethods).reporttablename; end;
function TQuickBooksListGUI.getTaxcodesTablename: String;begin   Result := '';   if assigned(fTaxcodes) then result := TQuickBooksListBaseGUI(fTaxcodes).reporttablename; end;
function TQuickBooksListGUI.getTaxRatesTablename: String;begin   Result := '';   if assigned(fTaxRates) then result := TQuickBooksListBaseGUI(fTaxRates).reporttablename; end;
function TQuickBooksListGUI.getTermsTablename   : String;begin   Result := '';   if assigned(fTerms)    then result := TQuickBooksListBaseGUI(fTerms).reporttablename; end;

procedure TQuickBooksListGUI.PgListsChange(Sender: TObject);
begin
  inherited;
    TQuickBooksListBaseGUI(fAccounts).btntest.visible := devmode and (PgLists.tabindex = tabAccountsidx);
    TQuickBooksListBaseGUI(fPaymethods).btntest.visible := devmode and (PgLists.tabindex = tabPaymethodsidx);
    TQuickBooksListBaseGUI(fTaxcodes).btntest.visible := devmode and (PgLists.tabindex = tabTaxCodesidx);
    TQuickBooksListBaseGUI(ftaxrates).btntest.visible := devmode and (PgLists.tabindex = tabtaxratesidx);
    TQuickBooksListBaseGUI(fTerms).btntest.visible    := devmode and (PgLists.tabindex = tabTermsidx);
end;

procedure TQuickBooksListGUI.PgListsResize(Sender: TObject);
begin
  inherited;
  RealignTabControl(PgLists, 1);
end;

initialization
  RegisterClassOnce(TQuickBooksListGUI);

end.
