unit StatementListForm;

{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 15/07/05  1.00.01 IJB  Added GlobalRef to list.
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList,
  Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, DNMPanel, MemDS, DBAccess,
  MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog,  wwdblook,
  Shader, kbmMemTable, DAScript, MyScript, CustomInputBox, wwcheckbox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TStatementListGUI = class(TBaseListingGUI)
    qryMainTransactionDate: TDateField;
    qryMainCustomerName: TWideStringField;
    qryMainInvoiceNumber: TWideStringField;
    qryMainType: TWideStringField;
    qryMainStatus: TWideStringField;
    qryMainTransactionDueDate: TDateField;
    qryMainDaysOutstanding: TLargeIntField;
    qryMainTotalAmount: TFloatField;
    qryMainSaleID: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainWithinTerms: TFloatField;
    qryMain_Days1to7: TFloatField;
    qryMain_Days7to14: TFloatField;
    qryMain_Days14to21: TFloatField;
    qryMain_morethan21: TFloatField;
    qryMain_Days1to30: TFloatField;
    qryMain_Days30to60: TFloatField;
    qryMain_Days60to90: TFloatField;
    qryMain_morethan90: TFloatField;
    qryMainGlobalRef: TWideStringField;
    qryMainDetails: TLargeintField;
    qryMainPrepayamt: TFloatField;
    qryMainOutstandingAmount: TFloatField;
    qryMainReceiptNo: TIntegerField;
    qryMainConNote: TWideStringField;
    qryMainEmployeeName: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure PreparedStatementsTable;
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grpViewClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    procedure CalcFooter; override;
    procedure SetGridColumns; override;
  public
    { Public declarations }
  end;

implementation
    
uses Forms, AppEnvironment, CommonLib, MySQLConst;
{$R *.dfm}

procedure TStatementListGUI.RefreshQuery;
begin
  With qryMain.Params do begin
    ParamByName('dtFrom').AsString := FormatDateTime(MysqlDateFormat, filterdateFrom);
    ParamByName('dtTo').AsString   := FormatDateTime(MysqlDateFormat, filterDateTo);
  end;
  inherited;
  RefreshTotals;
end;

procedure TStatementListGUI.RefreshTotals;
begin
   CalcnshowFooter;
end;

procedure TStatementListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymaindetails.FieldName);
  RemoveFieldfromGrid(qrymainGlobalref.FieldName);
  RemoveFieldfromGrid(qrymainclientID.FieldName);
end;

procedure TStatementListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:GroupFilterString := 'Details =1';
    1:GroupFilterString := 'Details =2 or Details =1';
    2:GroupFilterString := 'Details =3 or Details =1';
  end;
  inherited;
end;

procedure TStatementListGUI.grpViewClick(Sender: TObject);
begin
  if grpView.ItemIndex = 0 then
    if grpfilters.ItemIndex <> 0 then begin
      grpfilters.ItemIndex := 0; // chart should be viewed for summary
      TimerMsg(lblNote , 'Chart is for the summary data, so the report is changed into ''Summary''');
    end;
  inherited;

end;

procedure TStatementListGUI.FormShow(Sender: TObject);
begin
  inherited;
  if fbFormOpenedOk then begin
    if not (Parent is TDNMPanel) then begin // don't wipe out filter provided by owner form
      grpFiltersClick(Sender);
    end;
  end;
end;

procedure TStatementListGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if grpfilters.ItemIndex <> 0 then
    if qrymaindetails.AsInteger = 1 then
      Afont.Style := Afont.Style  + [fsBold];
end;

procedure TStatementListGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMain.FieldByName('Type').AsString;
  inherited;
end;

procedure TStatementListGUI.PreparedStatementsTable;
begin
  /////Sql To qryMain
end;

procedure TStatementListGUI.CalcFooter;
begin
  if grpfilters.ItemIndex <> 0 then
    if qrymaindetails.AsInteger = 1 then exit;
  inherited;
end;

procedure TStatementListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  AddCalcColumn(qryMainWithinTerms.Fieldname, True);
  AddCalcColumn(qryMain_Days1to7.Fieldname, True);
  AddCalcColumn(qryMain_Days7to14.Fieldname, True);
  AddCalcColumn(qryMain_Days14to21.Fieldname, True);
  AddCalcColumn(qryMain_morethan21.Fieldname, True);
  AddCalcColumn(qryMain_Days1to30.Fieldname, True);
  AddCalcColumn(qryMain_Days30to60.Fieldname, True);
  AddCalcColumn(qryMain_Days60to90.Fieldname, True);
  AddCalcColumn(qryMain_morethan90.Fieldname, True);
  AddCalcColumn(qryMainPrepayamt.Fieldname, True);
  AddCalcColumn(qryMainOutstandingAmount.Fieldname, True);
  ShowChartViewOnPopup := True;
  DisableSortoncolumtitleclick:= TRue;
end;

initialization
  RegisterClassOnce(TStatementListGUI);
end.

