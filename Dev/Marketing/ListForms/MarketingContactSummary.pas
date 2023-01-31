unit MarketingContactSummary;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, DB, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls,
  DNMPanel, ComCtrls,AdvOfficeStatusBar, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, wwcheckbox;

type
  TMarketingContactSummaryGUI = class(TBaseListingGUI)
    qryMainId: TIntegerField;
    qryMainCompany: TWideStringField;
    qryMainCompanyTypeName: TWideStringField;
    qryMainState: TWideStringField;
    qryMainSuburb: TWideStringField;
    qryMainEmployeeName: TWideStringField;
    qryMainFollowUpDate: TDateTimeField;
    qryMainDuration: TWideStringField;
    qryMainDone: TWideStringField;
    qryMainCreationDate: TDateTimeField;
    qryMainTypeName: TWideStringField;
    qryMainResultTypeName: TWideStringField;
    qryMainFollowUpID: TIntegerField;
    qryMainSource: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainDetails: TLargeIntField;
    qryMainDoesNotQualify: TWideStringField;
    qryMainEntryCount: TIntegerField;
    qryMainStreet: TWideStringField;
    qryMainPostcode: TWideStringField;
    qryMainCountry: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainMobile: TWideStringField;
    qryMainAltPhone: TWideStringField;
    qryMainEmail: TWideStringField;
    qryMainFaxNumber: TWideStringField;
    qryMainFollowupNotes: TWideMemoField;
    qryMainContactNotes: TWideMemoField;
    qryMainStreet2: TWideStringField;
    qryMainStreet3: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure grpFiltersClick(Sender: TObject);Override; 

  private
    { Private declarations }

  public
    { Public declarations }
    procedure RefreshQuery; override;
    
  end;


implementation

uses CommonLib;

{$R *.dfm}

procedure TMarketingContactSummaryGUI.FormCreate(Sender: TObject);
begin
  inherited;
  if Self.ErrorOccurred then Exit;
end;

procedure TMarketingContactSummaryGUI.FormShow(Sender: TObject);
begin
  inherited;
  if Self.ErrorOccurred then Exit;
end;

procedure TMarketingContactSummaryGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.IndexFieldNames := 'Company ASC CIS; CreationDate ASC CIS';
end;

procedure TMarketingContactSummaryGUI.RefreshQuery;
begin
  if Self.ErrorOccurred then Exit;
  qryMain.Close;
  qryMain.Params.ParamByName('xDate1a').AsString := FormatDateTime('yyyy-mm-dd 0:00:00', dtfrom.DateTime);
  qryMain.Params.ParamByName('xDate1b').AsString := FormatDateTime('yyyy-mm-dd 0:00:00', dtfrom.DateTime);
  qryMain.Params.ParamByName('xDate2a').AsString := FormatDateTime('yyyy-mm-dd 23:59:59', dtto.DateTime);
  qryMain.Params.ParamByName('xDate2b').AsString := FormatDateTime('yyyy-mm-dd 23:59:59', dtto.DateTime);
  inherited;
  grpFiltersClick(nil);
end;

procedure TMarketingContactSummaryGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin {Summary}
        GroupFilterString := '(Details = 1)';
      end;
    1:
      begin {Details}
        GroupFilterString := '(Details = 2)';;
      end;

  end;
  inherited;
end;

initialization
  RegisterClassOnce(TMarketingContactSummaryGUI);
end.
