unit PQAList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript,
  CustomInputBox, wwcheckbox;

type
  TPQAListGUI = class(TBaseListingGUI)
    cboPartsQry: TERPQuery;
    Panel4: TPanel;
    lblClassTitle: TLabel;
    cboPart: TwwDBLookupCombo;
    qryMainPQAID: TIntegerField;
    qryMainTransLineID: TIntegerField;
    qryMainTransType: TWideStringField;
    qryMainTransDate: TDateTimeField;
    qryMainAlloctype: TWideStringField;
    qryMainIsBO: TWideStringField;
    qryMainQty: TFloatField;
    qryMainUOMQty: TFloatField;
    qryMainUOM: TWideStringField;
    qryMainUOMMultiplier: TFloatField;
    qryMainProductName: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainTransID: TLargeintField;
    qryMainGlobalRef: TWideStringField;
    qryMainUOMID: TIntegerField;
    qryMainDepartmentID: TIntegerField;
    qryMainProductID: TIntegerField;
    qryMainReserved: TWideStringField;
    qryMainmsTimeStamp: TDateTimeField;
    qryMainMatrixRef: TWideMemoField;
    qryMainAvailable: TFloatField;
    qryMainInStock: TFloatField;
    qryMainBuilding: TFloatField;
    qryMainInvBo: TFloatField;
    qryMainSo: TFloatField;
    qryMainPOBO: TFloatField;
    qryMainOnBuild: TFloatField;
    qryMainuomAvailable: TFloatField;
    qryMainuomInStock: TFloatField;
    qryMainuomBuilding: TFloatField;
    qryMainuomInvBo: TFloatField;
    qryMainuomSo: TFloatField;
    qryMainuomPOBO: TFloatField;
    qryMainuomOnBuild: TFloatField;
    qryMainQtyDiff: TFloatField;
    qryMainUOMQtyDiff: TFloatField;
    procedure cboPartCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
      modified: Boolean);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormCreate(Sender: TObject);
  private
    fiProductId: Integer;
    procedure SetProductID(const Value: Integer);
    procedure MakeQry;
    { Private declarations }
  public
    Property ProductId :Integer REad fiProductId Write SetProductID;
    Procedure RefreshQuery; override;
  end;


implementation

uses pqalib,CommonLib, ProductQtyLib, AppEnvironment, tcConst;

{$R *.dfm}
{ TPQAListGUI }
procedure TPQAListGUI.cboPartCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  ProductId := cboPartsQry.fieldbyname('PartsId').asInteger;
end;

procedure TPQAListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  FilterString :='available <> 0 '+
                 ' or instock <> 0 '+
                 ' or onbuild <> 0 '+
                 ' or invbo <> 0 '+
                 ' or So <> 0 '+
                 ' or Building <> 0 '+
                 ' or uomavailable <> 0 '+
                 ' or uominstock <> 0 '+
                 ' or uomonbuild <> 0 '+
                 ' or uominvbo <> 0 '+
                 ' or uomSo <> 0 '+
                 ' or uomBuilding <> 0';
end;

procedure TPQAListGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if (QrymainQtydiff.asFloat <> 0) or (QrymainuomQtyDiff.asfloat <> 0) then
    ABrush.color := clred;
       if SameText(Field.fieldname,'available')     and (field.AsFloat =0) then Afont.color := aBrush.color
  else if SameText(Field.fieldname,'instock')       and (field.AsFloat =0) then Afont.color := aBrush.color
  else if SameText(Field.fieldname,'onbuild')       and (field.AsFloat =0) then Afont.color := aBrush.color
  else if SameText(Field.fieldname,'invbo')         and (field.AsFloat =0) then Afont.color := aBrush.color
  else if SameText(Field.fieldname,'So')            and (field.AsFloat =0) then Afont.color := aBrush.color
  else if SameText(Field.fieldname,'POBO')          and (field.AsFloat =0) then Afont.color := aBrush.color
  else if SameText(Field.fieldname,'Building')      and (field.AsFloat =0) then Afont.color := aBrush.color
  else if SameText(Field.fieldname,'QtyDiff')       and (field.AsFloat =0) then Afont.color := aBrush.color
  else if SameText(Field.fieldname,'uomavailable')  and (field.AsFloat =0) then Afont.color := aBrush.color
  else if SameText(Field.fieldname,'uominstock')    and (field.AsFloat =0) then Afont.color := aBrush.color
  else if SameText(Field.fieldname,'uomonbuild')    and (field.AsFloat =0) then Afont.color := aBrush.color
  else if SameText(Field.fieldname,'uominvbo')      and (field.AsFloat =0) then Afont.color := aBrush.color
  else if SameText(Field.fieldname,'uomSo')         and (field.AsFloat =0) then Afont.color := aBrush.color
  else if SameText(Field.fieldname,'uomPOBO')       and (field.AsFloat =0) then Afont.color := aBrush.color
  else if SameText(Field.fieldname,'uomQtyDiff')    and (field.AsFloat =0) then Afont.color := aBrush.color
  else if SameText(Field.fieldname,'uomBuilding')   and (field.AsFloat =0) then Afont.color := aBrush.color;
end;

procedure TPQAListGUI.MakeQry;
var
  QtyRoundTo:Integer;
begin
     QtyRoundTo:= (*appEnv.CompanyPrefs.QtyRoundTo*)tcConst.GeneralRoundPlaces;
     closedb(Qrymain);
     Qrymain.SQL.clear;
     Qrymain.SQL.add('SELECT');
     Qrymain.SQL.add('PQA.*,');
     Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tAvailable)+',0.0),' + IntToStr(QtyRoundTo)+') AS "Available",');
     Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tInstock)  +',0.0),' + IntToStr(QtyRoundTo)+') AS "InStock",');
     Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tSO)       +',0.0),' + IntToStr(QtyRoundTo)+') AS "so",');
     Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tInvBO)    +',0.0),' + IntToStr(QtyRoundTo)+') AS "InvBo",');
     Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tPOBO)     +',0.0),' + IntToStr(QtyRoundTo)+') AS "POBO",');
     Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tOnBuild)  +',0.0),' + IntToStr(QtyRoundTo)+') AS "OnBuild",');
     Qrymain.SQL.Add( '0-Round(IF(P.PARTTYPE="INV",' +ProductQtylib.SQL4Qty(tBuilding) +',0.0),' + IntToStr(QtyRoundTo)+') AS "Building",');

     Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tAvailable   ,'PQA', 'PQA.UOMQTY' ) +',0.0),' + IntToStr(QtyRoundTo)+') AS "uomAvailable",');
     Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tInstock     ,'PQA', 'PQA.UOMQTY') +',0.0),' + IntToStr(QtyRoundTo)+') AS "uomInStock",');
     Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tSO          ,'PQA', 'PQA.UOMQTY') +',0.0),' + IntToStr(QtyRoundTo)+') AS "uomSO",');
     Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tInvBO       ,'PQA', 'PQA.UOMQTY') +',0.0),' + IntToStr(QtyRoundTo)+') AS "uominvbo",');
     Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tPOBO        ,'PQA', 'PQA.UOMQTY') +',0.0),' + IntToStr(QtyRoundTo)+') AS "uomPOBO",');
     Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tOnBuild     ,'PQA', 'PQA.UOMQTY') +',0.0),' + IntToStr(QtyRoundTo)+') AS "uomOnBuild",');
     Qrymain.SQL.Add( '0-Round(IF(P.PARTTYPE="INV",' +ProductQtylib.SQL4Qty(tBuilding    ,'PQA', 'PQA.UOMQTY') +',0.0),' + IntToStr(QtyRoundTo)+') AS "uomBuilding"');
     Qrymain.SQL.add('FROM `tblParts` as P');
     Qrymain.SQL.add('left join `tblPQA` as PQA on P.PartsId = PQa.ProductId');
     Qrymain.SQL.add('Where P.partsId = :ProductID');
     Qrymain.SQL.add('GROUP BY PQA.PQAID');
     Qrymain.SQL.add('order by transType, active ,isbo');
end;
procedure TPQAListGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  QrymainQtydiff.asFloat    := Qrymainavailable.asFloat   - (Qrymaininstock.asFloat   +Qrymainonbuild.asFloat   -Qrymaininvbo.asFloat   -QrymainSo.asFloat    - QrymainBuilding.asFloat);
  QrymainuomQtydiff.asFloat := Qrymainuomavailable.asFloat- (Qrymainuominstock.asFloat+Qrymainuomonbuild.asFloat-Qrymainuominvbo.asFloat-QrymainuomSo.asFloat - QrymainuomBuilding.asFloat);
end;

procedure TPQAListGUI.RefreshQuery;
begin
  opendb(cboPartsQry);
  Qrymain.Parambyname('ProductId').asInteger :=    cboPartsQry.fieldbyname('PartsId').asInteger;
  inherited;
end;

procedure TPQAListGUI.SetProductID(const Value: Integer);
begin
  fiProductId := Value;
  if not(Screen.activecontrol = cboPart) then begin
    OpenDb(cboPart.Lookuptable);
    cboPart.LookupTable.Locate('PartsID' , value , []);
  end;
  Qrymain.Disablecontrols;
  Try
    MakeQry;
    RefreshQuery;
  Finally
    Qrymain.enablecontrols;
  End;
end;

initialization
  RegisterClassOnce(TPQAListGUI);

end.

