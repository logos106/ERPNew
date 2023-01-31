unit CustomerBalanceDetailForm;

{ Date     Version Who  What
 -------- -------- ---  --------------------------------------------------------
 07/09/05  1.00.01 IJB  Modified to use new filtering on base listing.
 }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB, 
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, DNMPanel, MemDS, DBAccess, MyAccess,ERPdbComponents,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, wwcheckbox;

type
  TCustomerBalanceDetailGUI = class(TBaseListingGUI)
    qryMainCustomerName: TWideStringField;
    qryMainType: TWideStringField;
    qryMainDate: TDateField;
    qryMainTransactionNumber: TWideStringField;
    qryMainDebits: TFloatField;
    qryMainCredits: TFloatField;
    qryMainSaleID: TLargeIntField;
    qryMainDetails: TLargeIntField;
    qryMainPaymentID: TLargeIntField;
    qryMainClientID: TIntegerField;
    qryMainName: TWideStringField;
    qryMainPrepaymentID: TLargeIntField;
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState;
      Highlight: boolean; AFont: TFont; ABrush: TBrush);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure cmdPrintClick(Sender: TObject);
  private
    { Private declarations }
  Protected
    procedure SetGridColumns; Override;
  public
    { Public declarations }
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
  end;

//var
//  CustomerBalanceDetailGUI: TCustomerBalanceDetailGUI;

implementation
  
uses Forms, CommonLib, tcConst;
{$R *.dfm}

procedure TCustomerBalanceDetailGUI.FormCreate(Sender: TObject);
begin
  inherited;
  if ErrorOccurred then Exit;
end;

procedure TCustomerBalanceDetailGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('txtfrom1').AsDate := filterDateFrom;
  qryMain.Params.ParamByName('txtto1').AsDate := filterDateTo;
  qryMain.Params.ParamByName('txtfrom2').AsDate := filterDateFrom;
  qryMain.Params.ParamByName('txtto2').AsDate := filterDateTo;
  qryMain.Params.ParamByName('txtfrom3').AsDate := filterDateFrom;
  qryMain.Params.ParamByName('txtto3').AsDate := filterDateTo;
  inherited;
end;

procedure TCustomerBalanceDetailGUI.RefreshTotals;
var
  Debits, Credits: double;
  bm: TBookmark;
begin
  Debits := 0;
  Credits := 0;

  with qryMain do begin
    bm := GetBookmark;
    DisableControls;
    First;
    while not Eof do begin
      if qryMainDetails.AsInteger = 0 then begin
        Debits := Debits + qryMainDebits.AsCurrency;
        Credits := Credits + qryMainCredits.AsCurrency;
      end;

      Next;
    end;

    EnableControls;
    GotoBookmark(bm);
    FreeBookmark(bm);
  end;
  grdMain.ColumnByName('Debits').FooterValue := FloatToStrF(Debits, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Credits').FooterValue := FloatToStrF(Credits, ffCurrency, 15, CurrencyRoundPlaces);
end;


procedure TCustomerBalanceDetailGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainClientID.fieldname);
  RemoveFieldfromGrid(QrymainDetails.fieldname);
end;

procedure TCustomerBalanceDetailGUI.grdMainDblClick(Sender: TObject);
begin
  if (qryMainSaleID.AsInteger > 0) or (qryMainPaymentID.AsInteger > 0) or (qryMainPrepaymentID.AsInteger > 0) then begin
    SubsequentID := Chr(95) + qryMain.FieldByName('Type').AsString;
    inherited;
  end;
end;

procedure TCustomerBalanceDetailGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if (QrymainDetails.asInteger = 0) and (grpFilters.itemindex <> 0) then
    AFont.Style := AFont.Style + [fsBold];

  if QrymainDetails.asInteger <> 0 then
    if sameText(field.fieldName , Qrymaincustomername.fieldname) then
      AFont.Color := ABrush.color;
end;

procedure TCustomerBalanceDetailGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin {Summary}
        GroupFilterString := 'Details = 0';
      end;

    1: 
      begin {Details}
        GroupFilterString := '(Details <> 2)';
      end;

    2: 
      begin  {Extra Details}
        GroupFilterString := '(Details <> 1 )';
      end;
  end;
  inherited;
end;


procedure TCustomerBalanceDetailGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end; 
end;

initialization
  RegisterClassOnce(TCustomerBalanceDetailGUI);
end.
