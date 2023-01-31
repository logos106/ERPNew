unit UnPayBillsListForm;

{ Date     Version Who  What
 -------- -------- ---  --------------------------------------------------------
 07/09/05  1.00.01 IJB  Modified to use new filtering on base listing.
 14/09/05  1.00.02 DMS  Changed the default filter selection to 'Summary'.
 }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, ExtCtrls, ImgList, Menus, AdvMenus, ComCtrls,AdvOfficeStatusBar, PrintDAT,
  ActnList, DateUtils, wwDialog, Wwlocate,
  SelectionDialog, DNMPanel, MemDS, DBAccess, MyAccess,ERPdbComponents, wwdbdatetimepicker,
  ProgressDialog,  wwdblook, Shader, kbmMemTable, DAScript,
  MyScript, wwcheckbox, CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

const
  SX_DatechangeMsg = WM_USER + 125;

type
  TUnpaidBillGUI = class(TBaseListingGUI)
    BitBtn1: TDNMSpeedButton;
    qryMainSupplierName: TWideStringField;
    qryMainType: TWideStringField;
    qryMainOrderDate: TDateField;
    qryMainDueDate: TDateField;
    qryMainPONumber: TWideStringField;
    qryMainName: TWideStringField;
    qryMainOriginalAmount: TFloatField;
    qryMainAmountDue: TFloatField;
    qryMainPurchaseOrderID: TIntegerField;
    qryMainDetails: TLargeIntField;
    qryMainClientID: TIntegerField;
    qryMainInvoiceNumber: TWideStringField;
    qryMainInvoiceDate: TDateField;
    grpFilters2: TRadioGroup;
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure DateChange(var Message: TMessage); message SX_DatechangeMsg;
    procedure grpFilters2Click(Sender: TObject);
  private
    procedure CleanRefresh;
    { Private declarations }
//    PrevDateTo: TDateTime;
//    PrevDateFrom: TDateTime;


  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
//    function DoDtFromChange(Sender:Tobject): boolean; override;
//    function DoDtToChange(Sender: TObject): boolean; override;
  public
    { Public declarations }
  end;


implementation
    
uses Report_AP_Obj, Forms, CommonLib, tcConst;
{$R *.dfm}

procedure TUnpaidBillGUI.RefreshTotals;
var
  dAmountDue, dOriginalAmount: double;
  Bookmark: TBookmark;
begin
  inherited;
  dAmountDue := 0;
  dOriginalAmount := 0;
  qryMain.DisableControls;
  Bookmark := qryMain.GetBookmark;
  Try
  with qryMain do begin
    First;
    while not Eof do begin
      if (qryMainDetails.AsInteger = 0) then begin
        dOriginalAmount := dOriginalAmount + qryMainOriginalAmount.AsCurrency;
        dAmountDue := dAmountDue + qryMainAmountDue.AsCurrency;
      end;
      Next;
    end;
  end;
  finally
    qryMain.GotoBookmark(Bookmark);
    qryMain.FreeBookmark(Bookmark);
    qryMain.EnableControls;
  end;
  grdMain.ColumnByName('AmountDue').FooterValue := FloatToStrF(dAmountDue, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('OriginalAmount').FooterValue := FloatToStrF(dOriginalAmount, ffCurrency, 15, CurrencyRoundPlaces);
end;

procedure TUnpaidBillGUI.grdMainDblClick(Sender: TObject);
begin
  if qryMainPurchaseOrderID.AsInteger > 0 then begin
    SubsequentID := Chr(95) + qryMain.FieldByName('Type').AsString;
    inherited;
  end;
end;

procedure TUnpaidBillGUI.RefreshQuery;
begin
    qryMain.Params.ParamByName('txtfrom1').asDatetime:= filterdateFrom;
    qryMain.Params.ParamByName('txtto1').asDatetime  := filterdateTo;
    qryMain.Params.ParamByName('txtfrom2').asDatetime:= filterdateFrom;
    qryMain.Params.ParamByName('txtto2').asDatetime  := filterdateTo;
    qryMain.Params.ParamByName('txtfrom3').asDatetime:= filterdateFrom;
    qryMain.Params.ParamByName('txtto3').asDatetime  := filterdateTo;
  case grpFilters2.ItemIndex of
    0: qryMain.Params.ParamByName('IncludeType').AsString:= 'BillCredit';
    1: qryMain.Params.ParamByName('IncludeType').AsString:= 'All';
  end;

  inherited;
end;

procedure TUnpaidBillGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin {Summary}
        GroupFilterString := '(Details = 0)';
      end;
    1: 
      begin {Details}
        GroupFilterString := '(Details <> 2)';
      end;
    2: 
      begin  {Extra Details}
        GroupFilterString := '(Details <> 1)';
      end;
  end;
  inherited;
end;

procedure TUnpaidBillGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if not Empty(qryMainSupplierName.AsString) then begin
    AFont.Style := AFont.Style + [fsBold];
  end;
end;

procedure TUnpaidBillGUI.FormCreate(Sender: TObject);
begin
  //NoDateRange := true;
  inherited;
  if ErrorOccurred then Exit;
  CleanRefresh;
end;

procedure TUnpaidBillGUI.BitBtn1Click(Sender: TObject);
begin
  CleanRefresh;
end;
procedure TUnpaidBillGUI.CleanRefresh;
var
  AP_Report_Obj: TAP_Report_Obj;
begin
  AP_Report_Obj := TAP_Report_Obj.Create(True);
  try
    AP_Report_Obj.CleanRefresh_AP_Table(true, filterdateTo, 0, true,-1);
  finally
    FreeandNil(AP_Report_Obj);
  end;
  RefreshQuery;
end;

procedure TUnpaidBillGUI.DateChange(var Message: TMessage);
begin
  if not dtTo.DroppedDown then begin
    RefreshQuery;
  end;
end;

//function TUnpaidBillGUI.DoDtFromChange(Sender:TObject): boolean;
//begin
//  result:= false;
//  if not (dtFrom.DateTime = PrevDateFrom) then begin
//    PostMessage(self.Handle, SX_DatechangeMsg, 0, 0);
//    result:= true;
//  end;
//  PrevDateFrom := dtFrom.DateTime;
//end;

//function TUnpaidBillGUI.DoDtToChange(Sender:TObject): boolean;
//begin
//  result:= false;
//  if not (dtTo.DateTime = PrevDateTo) then begin
//    PostMessage(self.Handle, SX_DatechangeMsg, 0, 0);
//    result:= true;
//  end;
//  PrevDateTo := dtTo.DateTime;
//end;

procedure TUnpaidBillGUI.grpFilters2Click(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

initialization
  RegisterClassOnce(TUnpaidBillGUI);
end.
