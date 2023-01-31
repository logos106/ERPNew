unit DutynHandlingList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TDutynHandlingListGUI = class(TBaseListingGUI)
    qryMainPartname: TWideStringField;
    dsduty: TDataSource;
    Qryduty: TERPQuery;
    dsHandling: TDataSource;
    QryHandling: TERPQuery;
    qryMainPartsId: TIntegerField;
    QryHandlingPartsID: TIntegerField;
    QryHandlingSupplier: TWideStringField;
    QryHandlingcountry: TWideStringField;
    QryHandlinghandling: TFloatField;
    QrydutyPartsID: TIntegerField;
    QrydutySupplier: TWideStringField;
    Qrydutycountry: TWideStringField;
    QrydutyDuty: TFloatField;
    DNMPanel2: TDNMPanel;
    grdhandling: TwwDBGrid;
    wwIButton1: TwwIButton;
    DNMPanel1: TDNMPanel;
    grdDuty: TwwDBGrid;
    wwIButton2: TwwIButton;
    Label2: TLabel;
    Label4: TLabel;
    lblDuty: TLabel;
    lblHandling: TLabel;
    QryHandlingIPID: TIntegerField;
    QrydutyIPID: TIntegerField;
    QrydutyClientID: TIntegerField;
    QryHandlingClientID: TIntegerField;
    Qrydutypartname: TWideStringField;
    QryHandlingpartname: TWideStringField;
    lblMsg: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure grdhandlingCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdDutyCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdDutyDblClick(Sender: TObject);
    procedure grdhandlingDblClick(Sender: TObject);
  private
    fidutyId, fiHandlingId :Integer;
    fsPOProductIds: String;
    fdSelctedDuty,fdSelctedHandling: Double;
    fiSelctedHandlingSupplier: Integer;
    fiSelctedDutySupplier: Integer;
    procedure SetPOProductIds(const Value: String);
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery; Override;
    Property SelctedDuty :Double read fdSelctedDuty;
    Property SelctedHandling :Double read fdSelctedHandling;
    Property SelctedDutySupplier :Integer read fiSelctedDutySupplier;
    Property SelctedHandlingSupplier :Integer read fiSelctedHandlingSupplier;
    Property POProductIds :String read fsPOProductIds write SetPOProductIds;
  end;


implementation

uses CommonLib, tcConst;

{$R *.dfm}
procedure TDutynHandlingListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection:= False;
  fidutyId:= 0;
  fiHandlingId :=0;
  fdSelctedHandling:= 0;
  fiSelctedHandlingSupplier := 0;
  fiSelctedDutySupplier:= 0;
  grdDuty.TitleColor := Self.Color;   grdDuty.FooterColor := Self.Color;
  grdHandling.TitleColor := Self.Color;   grdHandling.FooterColor := Self.Color;
  lblMsg.caption := 'On one of the Product(s) on this Purchase Order, There are Multiple Choices for Duty / Handling per Product. ' +NL+
                    'If There is Only 1 Choice for Duty / Handling per product, These will be Selected Automatically';
end;

procedure TDutynHandlingListGUI.RefreshQuery;
begin
  Closedb(Qryduty);
  Closedb(QryHandling);
  inherited;
  opendb(Qryduty);
  opendb(QryHandling);
end;

procedure TDutynHandlingListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymainpartsid.fieldname);
end;


procedure TDutynHandlingListGUI.SetPOProductIds(const Value: String);
begin
  fsPOProductIds := Value;
  if fsPOProductIds = '' then fsPOProductIds := '0';
  Closedb(Qrymain);
  Qrymain.SQL.Clear;
  Qrymain.SQL.Add('select');
  Qrymain.SQL.Add('distinct');
  Qrymain.SQL.Add('P.partsID as PartsId,');
  Qrymain.SQL.Add('P.partname as Partname');
  Qrymain.SQL.Add('from tblImportProducts IP');
  Qrymain.SQL.Add('inner join tblParts P on P.partsId = IP.productId');
  Qrymain.SQL.Add('where (ifnull(IP.duty ,0)<>0 or ifnull(IP.handling ,0)<>0)');
  Qrymain.SQL.Add('and P.partsId in (' + value +')');
  Qrymain.SQL.Add('Order by partname');
  RefreshOrignalSQL(False);

 Closedb(Qryduty);
 Qryduty.SQL.Clear;
 Qryduty.SQL.Add('select');
 Qryduty.SQL.Add('Distinct');
 Qryduty.SQL.Add('IP.ID as IPID,');
 Qryduty.SQL.Add('P.PartsID ,');
 Qryduty.SQL.Add('P.partname as Partname,');
 Qryduty.SQL.Add('C.clientID as ClientID,');
 Qryduty.SQL.Add('C.company as Supplier,');
 Qryduty.SQL.Add('CT.Country as country,');
 Qryduty.SQL.Add('IP.Duty as Duty');
 Qryduty.SQL.Add('from tblImportProducts IP');
 Qryduty.SQL.Add('inner join tblParts P on P.partsId = IP.productId');
 Qryduty.SQL.Add('left join tblclients C on C.clientID = IP.supplierId');
 Qryduty.SQL.Add('left join tblcountries CT on CT.CountryId = IP.CountryofOriginId');
 Qryduty.SQL.Add('where ifnull(IP.Duty ,0)<> 0');
 Qrymain.SQL.Add('and P.partsId in (' + value +')');
 Qryduty.SQL.Add('Order by Partname, country , supplier');


 Closedb(QryHandling);
 QryHandling.SQL.Clear;
 QryHandling.SQL.Add('select');
 QryHandling.SQL.Add('Distinct');
 QryHandling.SQL.Add('IP.ID as IPID,');
 QryHandling.SQL.Add('P.PartsID ,');
 QryHandling.SQL.Add('P.partname as Partname,');
 QryHandling.SQL.Add('C.clientID as ClientID,');
 QryHandling.SQL.Add('C.company as Supplier,');
 QryHandling.SQL.Add('CT.Country as country,');
 QryHandling.SQL.Add('IP.Handling as Handling');
 QryHandling.SQL.Add('from tblImportProducts IP');
 QryHandling.SQL.Add('inner join tblParts P on P.partsId = IP.productId');
 QryHandling.SQL.Add('left join tblclients C on C.clientID = IP.supplierId');
 QryHandling.SQL.Add('left join tblcountries CT on CT.CountryId = IP.CountryofOriginId');
 QryHandling.SQL.Add('where ifnull(IP.Handling ,0)<> 0');
 Qrymain.SQL.Add('and P.partsId in (' + value +')');
 QryHandling.SQL.Add('Order by Partname, country , supplier');

end;

procedure TDutynHandlingListGUI.grdhandlingCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if QryHandlingIPID.asInteger = fiHandlingID then ABrush.Color := GridColhighLightGreen;
end;

procedure TDutynHandlingListGUI.grdhandlingDblClick(Sender: TObject);
begin
  inherited;
  if fiHandlingID = QryHandlingIPID.asInteger then begin
    fiHandlingID := 0;
    fdSelctedHandling:= 0;
    fiSelctedHandlingSupplier :=0;
    lblHandling.Caption := 'Double Click to Choose';
   end  else begin
    fiHandlingID :=QryHandlingIPID.asInteger ;
    fdSelctedHandling:=QryHandlingHandling.asfloat;
    fiSelctedHandlingSupplier:=QryHandlingclientID.asInteger;
    lblHandling.Caption := 'Selected Handling : '+FloattostrF(fdSelctedHandling , ffGeneral, 15,2) +' % for '+ quotedstr(QryHandlingSupplier.asString)
   end;
   grdhandling.Repaint;
end;

procedure TDutynHandlingListGUI.grdDutyCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if QrydutyIPID.asInteger = fiDutyID then ABrush.Color := GridColhighLightGreen;
end;

procedure TDutynHandlingListGUI.grdDutyDblClick(Sender: TObject);
begin
  inherited;
  if fiDutyID = QrydutyIPID.asInteger then begin
    fiDutyID := 0;
    fdSelctedDuty:= 0;
    fiSelctedDutySupplier:=0;
    lblDuty.Caption := 'Double Click to Choose';
   end  else begin
    fiDutyID :=QrydutyIPID.asInteger ;
    fdSelctedDuty:=QrydutyDuty.asfloat;
    fiSelctedDutySupplier:=QryDutyclientID.asInteger;
    lblDuty.Caption := 'Selected Duty : '+FloattostrF(fdSelctedDuty , ffGeneral, 15,2) +' % for '+ quotedstr(QrydutySupplier.asString);
   end;
   grdDuty.Repaint;
end;

Initialization
  RegisterClassOnce(TDutynHandlingListGUI);

end.
