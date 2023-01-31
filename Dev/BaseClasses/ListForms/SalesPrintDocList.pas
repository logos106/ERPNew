unit SalesPrintDocList;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 08/12/06  1.00.01 DSP  First version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton, (*QueryLoadObj,*)
  BusObjPrintDoc, wwdblook, Shader, kbmMemTable, DAScript,
  MyScript, wwcheckbox, CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TSalesPrintDocListGUI = class(TBaseListingGUI)
    qryMainSaleDate: TDateField;
    qryMainType: TWideStringField;
    qryMainTransNo: TWideStringField;
    qryMainCustomer: TWideStringField;
    qryMainSaleID: TIntegerField;
    qryMainPrintDate: TDateTimeField;
    Print: TDNMSpeedButton;
    qryMainClientID: TIntegerField;
    qryMainBOID: TWideStringField;
    qryMainHoldSale: TWideStringField;
    qryMainIsInvoice: TWideStringField;
    qryMainIsSalesOrder: TWideStringField;
    qryMainIsCashSale: TWideStringField;
    qryLookupformname: TERPQuery;
    qryLookupformnamePrintDocID: TIntegerField;
    qryLookupformnameDescription: TWideStringField;
    qryMainPrintdocId: TIntegerField;
    qryMainformName: TStringField;
    qryMainPrintcount: TFloatField;
    qryMainTotalcount: TFloatField;
    qryMainPreviewcount: TFloatField;
    qryMainEmailcount: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure qryMainBeforeOpen(DataSet: TDataSet);

  private
    fPrintDoc:TBusObjPrintDoc;
    (*FQueryLoad: TQueryLoad;*)
  protected
    procedure RefreshTotals; override;
    procedure RefreshQuery; override;
    Procedure SetGridColumns;Override;
    Function PrintDoc:TBusObjPrintDoc;
  public
    { Public declarations }
  end;

implementation

uses FastFuncs;

{$R *.dfm}

procedure TSalesPrintDocListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:GroupFilterString := 'printcount <> 0';
    1:GroupFilterString := 'Printcount =0';
    2:GroupFilterString := 'EmailCount<>0';
    3:GroupFilterString := 'Emailcount =0';
    4:GroupFilterString := '';
  end;
  inherited;
end;


procedure TSalesPrintDocListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fPrintDoc:= nil;
end;

procedure TSalesPrintDocListGUI.FormDestroy(Sender: TObject);
begin
  FreeandNil(fPrintDoc);
  inherited;
end;

procedure TSalesPrintDocListGUI.RefreshTotals;
begin
  inherited;
  lblTotal.Caption := IntToStr(qryMain.RecordCount);
end;

procedure TSalesPrintDocListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('ClientId');
  RemoveFieldfromGrid('BOID');
  RemoveFieldfromGrid('HoldSale');
  RemoveFieldfromGrid('IsInvoice');
  RemoveFieldfromGrid('IsSalesOrder');
  RemoveFieldfromGrid('IsCashSale');
end;

procedure TSalesPrintDocListGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('DateFrom').AsDate := FilterDateFRom;
  qryMain.Params.ParamByName('DateTo').AsDate := FilterDateTo;
  inherited;
end;

procedure TSalesPrintDocListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if SameText(Field.fieldName , 'PrintDate') then
    if QrymainPrintDate.asDatetime =0 then
      Afont.color := ABrush.color;
end;

procedure TSalesPrintDocListGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMain.Fields.FieldByName('Type').AsString;
  inherited;

end;


procedure TSalesPrintDocListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TSalesPrintDocListGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TSalesPrintDocListGUI.cmdNewClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TSalesPrintDocListGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;


function TSalesPrintDocListGUI.PrintDoc: TBusObjPrintDoc;
begin
  if not (Assigned(fPrintdoc)) then
    fPrintdoc := TBusObjPrintDoc.CreateWithNewConn(Self);
  result :=fPrintdoc;
end;

procedure TSalesPrintDocListGUI.qryMainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  if qryLookupformname.active then qryLookupformname.close;
  qryLookupformname.open;
end;


procedure TSalesPrintDocListGUI.cmdCloseClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

end.
