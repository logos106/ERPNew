unit Globalsearch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, BaseInputForm, DAScript,
  MyScript, wwcheckbox, CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg,
  GlobalSearchSQL;

type

  TGlobalsearchGUI = class(TBaseListingGUI)
    qryMainclientId: TIntegerField;
    qryMainId: TIntegerField;
    qryMaincompany: TWideStringField;
    qryMainCatgDesc: TWideStringField;
    qryMainType: TWideStringField;
    qryMainGlobalref: TWideStringField;
    qryMainTransDate: TDateTimeField;
    qryMainCatg: TLargeintField;
    qryMainSaleID: TLargeintField;
    qryMainPurchaseOrderID: TLargeintField;
    qryMainPaymentID: TLargeintField;
    qryMainPrepaymentID: TLargeintField;
    qryMainFixedAssetID: TLargeintField;
    qryMainTransId: TIntegerField;
    qryMainPartsId: TLargeintField;
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fsSearchName: String;
    //fsSQLSearchName: String;
    fQuerySearchMode: TBaseListingSearchMode;
    //fsSearchhint:String;
    Report: TGlobalSearchReport;
    procedure SetSearchName(const Value: String);
    procedure MakeQrymain;
  Protected
    Procedure AssignKeyId(Popupform :TBaseInputGUI); override;
    procedure SetGridColumns; override;
  public
    Procedure RefreshQuery; override;
    Property SearchName:String Read fsSearchName Write SetSearchName;
    property QuerySearchMode: TBaseListingSearchMode read fQuerySearchMode write fQuerySearchMode;
  end;

implementation

uses
  CommonLib, FastStringFuncs, FastFuncs , SyncReportTableObj, AppEnvironment,
  BusObjSaleBase, SalesConst, tcDataUtils, ProductQtyLib, tcConst, LogLib ;

{$R *.dfm}
{ TGlobalsearchGUI }

Procedure TGlobalsearchGUI.MakeQrymain;
var
  msg: string;
begin
  if Qrymain.active then Qrymain.close;
  Report.SearchName := SearchName;
  Report.QuerySearchMode := SearchModeToStr(fQuerySearchMode);
  Report.PopulateReportSQL(qryMain.SQL, msg);
  qryMain.SQL.text := ChangeQuery(qryMain.SQL.text);
  clog(qryMain.SQL.text);
end;


procedure TGlobalsearchGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fsSearchName:= '';
  //fsSQLSearchName := '';
  fQuerySearchMode := smNone;
  //NonSearchReport := True;
  SearchMode:= smFullList;
  Report := TGlobalSearchReport.Create;
end;

procedure TGlobalsearchGUI.FormDestroy(Sender: TObject);
begin
   Report.Free;
   inherited;
end;

procedure TGlobalsearchGUI.RefreshQuery;
begin
    TitleLabel.Caption :=  fsSearchName;
      if qrymain.active then qrymain.close;
      qrymain.SQL.clear;
      MakeQrymain;
      RefreshOrignalSQL;
      inherited;
end;

procedure TGlobalsearchGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainId.fieldname);
  RemoveFieldfromGrid(QrymainclientId.fieldname);
  RemoveFieldfromGrid(QrymainCatg.fieldname);
  if not devmode then
    RemoveFieldfromGrid(QrymainCatgdesc.fieldname);
end;

procedure TGlobalsearchGUI.SetSearchName(const Value: String);
begin
  fsSearchName := Value;
  //fsSQLSearchName := StringReplace(fsSearchName,'\','\\',[rfREplaceAll]);
end;

procedure TGlobalsearchGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + StringReplace(qryMain.Fields.FieldByName('Type').AsString, '-' , '' , [rfReplaceAll]);
  if sametext(SubsequentID , '_Contact') then begin
    SubsequentID := Chr(95) + tcdatautils.clienttypename(ContactClientID(QrymainclientID.asInteger))
  end else if SameText(qryMain.Fields.FieldByName('Type').AsString,'Cash Sale') then begin
    case TSalesBase.GetSaleType(qryMain.Fields.FieldByName('SaleID').AsInteger) of
      stPOS,
      stPOSLayby,
      stPOSLaybyPayment,
      stPOSCashSale: SubsequentID := Chr(95) + 'POS';
    end;
  end else if sametext(SubsequentID , '_Account') then begin
    //SubsequentID := Chr(95) + tcdatautils.clienttypename(ContactClientID(qryMain.Fields.FieldByName('PartsId').AsInteger))
  end else if qryMain.Fields.FieldByName('PartsId').AsInteger > 0 then begin
    SubsequentId := Chr(95) + 'Product';
  end;
  inherited;
end;

procedure TGlobalsearchGUI.AssignKeyId(Popupform: TBaseInputGUI);
begin
  if qryMainCatg.asInteger = report.GlobalSearchCatgNo(gscClients) then  Popupform.KeyId := qryMainclientId.asInteger;
(*  else
    Popupform.KeyId := qryMainTransID.asInteger;*)
  if Popupform.KeyId = 0 then inherited;
end;

procedure TGlobalsearchGUI.FormShow(Sender: TObject);
begin
  inherited;
   GuiPrefs.DbGridElement[grdMain].RemoveFields('SaleID');
   GuiPrefs.DbGridElement[grdMain].RemoveFields('TransID');
   GuiPrefs.DbGridElement[grdMain].RemoveFields('PurchaseOrderID');
   GuiPrefs.DbGridElement[grdMain].RemoveFields('PaymentID');
   GuiPrefs.DbGridElement[grdMain].RemoveFields('PrepaymentID');
   GuiPrefs.DbGridElement[grdMain].RemoveFields('FixedAssetID');
end;

initialization
  RegisterClassOnce(TGlobalsearchGUI);

end.
