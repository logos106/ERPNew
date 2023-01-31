unit GoogleLeads;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader;

type
  TGoogleLeadsGUI = class(TBaseListingGUI)
    qryMainId: TIntegerField;
    qryMainCOMPANY: TWideStringField;
    qryMainStreet: TWideStringField;
    qryMainStreet2: TWideStringField;
    qryMainStreet3: TWideStringField;
    qryMainSUBURB: TWideStringField;
    qryMainSTATE: TWideStringField;
    qryMainDateEntered: TDateTimeField;
    qryMainPhone: TWideStringField;
    qryMainlastcontactedon: TDateTimeField;
    qryMainAltPhone: TWideStringField;
    qryMainMobile: TWideStringField;
    qryMainsource: TWideStringField;
    procedure grdMainDblClick(Sender: TObject);Override;
  private
    procedure beforeshowMarketingLeadLines(Sender: TObject);
  Protected
    Procedure RefreshQuery; Override;
    procedure SetGridColumns; Override;
  public

  end;

implementation

uses CommonLib, MemoDialog, CommonFormLib, MarketingLeadLines;

{$R *.dfm}

{ TGoogleLeadsGUI }

procedure TGoogleLeadsGUI.grdMainDblClick(Sender: TObject);
begin
  if (SameText(ActiveFieldname , 'lastcontactedon')) and (Qrymainlastcontactedon.AsDateTime<>0) then begin
    OpenERPListForm('TMarketingLeadLinesGUI' , beforeshowMarketingLeadLines)
  end else inherited;
end;
procedure TGoogleLeadsGUI.beforeshowMarketingLeadLines(Sender: TObject);
begin
  if not (Sender is TMarketingLeadLinesGUI) then exit;
  TMarketingLeadLinesGUI(Sender).MarketingcontactID := QrymainID.AsInteger;
end;

procedure TGoogleLeadsGUI.RefreshQuery;
begin
  Qrymain.Parambyname('Datefrom').asDatetime:= FilterDateFrom;
  Qrymain.Parambyname('DateTo').asDatetime  := FilterDateTo;
  inherited;
end;

procedure TGoogleLeadsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainId.fieldname);
end;

initialization
  RegisterClassOnce(TGoogleLeadsGUI);
end.

