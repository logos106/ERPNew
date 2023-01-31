unit AreaPOLinesList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,BaseListExpress;

type
  TAreaPOLinesListGUI = class(TBaseListExpressGUI)
    qryMainDetails: TLargeintField;
    qryMainequipmentId: TIntegerField;
    qryMainEquipmentName: TWideStringField;
    qryMainOrderDate: TDateTimeField;
    qryMainAreaCode: TWideStringField;
    qryMainproductName: TWideStringField;
    qryMainQtySold: TFloatField;
    qryMainQtyShipped: TFloatField;
    qryMainQtybo: TFloatField;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormCreate(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure grdMainMultiSelectAllRecords(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
    procedure grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
    procedure FormShow(Sender: TObject);
  private
    function getDetails: Integer;
    function getAreaCode: String;
    function getProductName: String;
  Protected
    procedure SetGridColumns; Override;
    Function ExpressDetailListName:String;Override;
  public
    Procedure RefreshQuery;Override;
    Property Details :Integer read getDetails;
    Property AreaCode :String read getAreaCode;
    Property ProductName:String read getProductName;
    Procedure SelectAllDetailforArea(const Value:String);
  end;

implementation

uses AppEnvironment, CommonLib;

{$R *.dfm}

{ TBaseListingGUI3 }

function TAreaPOLinesListGUI.ExpressDetailListName: String;
begin
  REsult := 'TAreaPOLinesDetailsListGUI';
end;

procedure TAreaPOLinesListGUI.FormCreate(Sender: TObject);
begin
  grpfilters.items[0] := Appenv.companyprefs.Areacolumnname +' Summary';
  Self.Caption := Appenv.companyprefs.Areacolumnname +  ' Product List';
  TitleLabel.Caption := Appenv.companyprefs.Areacolumnname + ' Product List';
  grpFilters.Items[0] := Appenv.companyprefs.Areacolumnname + ' Summary';

  inherited;
end;

procedure TAreaPOLinesListGUI.FormShow(Sender: TObject);
begin
  inherited;
  if grpfilters.ItemIndex =-1 then grpfilters.ItemIndex := 0;
end;

function TAreaPOLinesListGUI.getAreaCode: String;
begin
  REsult := QrymainAreaCode.asString;
end;

function TAreaPOLinesListGUI.getDetails: Integer;
begin
  REsult := QrymainDetails.asInteger;
end;

function TAreaPOLinesListGUI.getProductName: String;
begin
  Result := QrymainproductName.AsString;
end;

procedure TAreaPOLinesListGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if grpfilters.ItemIndex = 1 then
    if QrymainDetails.AsInteger = 1 then begin
      AFont.Style := AFont.Style +[fsBold];
      ABrush.color := $00B3FFFF;
    end;
end;

procedure TAreaPOLinesListGUI.grdMainMultiSelectAllRecords(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  ACCEPT:=  (ProductName <> '') and (Areacode<>'');
end;

procedure TAreaPOLinesListGUI.grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  ACCEPT:=  (ProductName <> '') and (Areacode<>'');
end;

procedure TAreaPOLinesListGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Details' , ['1','2','3']);
  inherited;
end;

procedure TAreaPOLinesListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMainOrderDate.Displayformat := FormatSettings.Shortdateformat;
end;

procedure TAreaPOLinesListGUI.RefreshQuery;
begin
  //InitDateFromnDateto;
  inherited;
end;

procedure TAreaPOLinesListGUI.SelectAllDetailforArea(const Value: String);
begin
  grdmain.UnselectAll;
  if Qrymain.RecordCount=0 then exit;
  Qrymain.First;
  while Qrymain.Eof = False do begin
    if sametext(areacode, value) then grdmain.SelectRecord;
    Qrymain.Next;
  end;
end;

procedure TAreaPOLinesListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainDetails.fieldname);
  RemoveFieldfromGrid(qryMainequipmentId.fieldname);
end;

initialization
  RegisterClassOnce(TAreaPOLinesListGUI);

end.

