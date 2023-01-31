unit PQAMovement;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel;

type
  TPQAMovementGUI = class(TBaseListingGUI)
    qryMainPQAID: TIntegerField;
    qryMainTranstypeFrom: TWideStringField;
    qryMainTRansIDFrom: TLargeintField;
    qryMaintranslineIdFrom: TIntegerField;
    qryMainLinecost: TFloatField;
    qryMaininqty: TFloatField;
    qryMainActualtotalcost: TFloatField;
    qryMainTranstypeTo: TWideStringField;
    qryMainTRansIDTo: TLargeintField;
    qryMaintranslineIdTo: TIntegerField;
    qryMainUnitCostex: TFloatField;
    qryMainoutqty: TFloatField;
    qryMaintotalcostEx: TFloatField;
    qryMainRunningQty: TFloatField;
    qryMainRunningAmount: TFloatField;
    qryMainID: TIntegerField;
    qrymaincolorindex: TIntegerField;
    qryTemp: TERPQuery;
    qryTempPQAID: TIntegerField;
    qryTempTranstypeFrom: TWideStringField;
    qryTempTRansIDFrom: TLargeintField;
    qryTemptranslineIdFrom: TIntegerField;
    qryTempLinecost: TFloatField;
    qryTempinqty: TFloatField;
    qryTempActualtotalcost: TFloatField;
    qryTempTranstypeTo: TWideStringField;
    qryTempTRansIDTo: TLargeintField;
    qryTemptranslineIdTo: TIntegerField;
    qryTempUnitCostex: TFloatField;
    qryTempoutqty: TFloatField;
    qryTemptotalcostEx: TFloatField;
    qryTemprunningQty: TFloatField;
    qryTemprunningamount: TFloatField;
    qryTempsameINPQa: TWideStringField;
    qryMainsameINPQa: TWideStringField;
    qryTempID: TIntegerField;
    qryTempcolorindex: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
    Tablename :string;
    fiProductId: Integer;
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;Override;
    Property ProductID :Integer read fiProductId write fiProductId;
  end;


implementation

uses CommonDbLib,CommonLib, AppEnvironment;

{$R *.dfm}

{ TPQAMovementGUI }

procedure TPQAMovementGUI.FormCreate(Sender: TObject);
begin
  Tablename := getusertemporarytablename('PQAMovement');
  Qrymain.SQL.text := 'Select * from '+ tablename ;
  inherited;
  DisableSortoncolumtitleclick:= TRue;
end;

procedure TPQAMovementGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  //grouping the in-pqa that contributes to multiple out transactions
  if qrymaincolorindex.asInteger =1 then Abrush.color := $00E9FFD2 else abrush.color := $00ECD9FF;


  if qrymainRunningQty.AsFloat =0 then
    if qryMainRunningAmount.AsFloat <> 0 then Afont.color := clred;
  if qryMainsameINPQa.AsBoolean then
    if sametext(field.FieldName ,   qrymainTranstypeFrom.FieldName) or
       sametext(field.FieldName ,   qrymainTRansIDFrom.FieldName) or
       sametext(field.FieldName ,   qrymaininqty.FieldName) or
       sametext(field.FieldName ,   qrymainLinecost.FieldName) or
       sametext(field.FieldName ,   qrymainActualtotalcost.FieldName) then begin
        aBrush.color := clwhite;
        Afont.Color := aBrush.Color;
       end;

end;

procedure TPQAMovementGUI.RefreshQuery;
var
  runningQty , runningamount :double;
  PQAID:Integer;
  colorindex:Integer;
begin
  with ScriptMain do begin
    SQL.clear;
    SQL.add('Drop table if exists '+tablename+';');
    SQL.add('Create table '+ Tablename +
            ' select '+
            ' PQAGogs.Id as PQAGogsId, '+
            ' transPQAfrom.PQAID, '+
            ' transPQATo.PQAID toPQAID, '+
            ' transPQAfrom.TransDate, '+
            ' fromtype.Description as TranstypeFrom, '+
            ' transPQAfrom.TransId as TRansIDFrom, '+
            ' transPQAfrom.translineId as translineIdFrom, '+
            ' transPQAfrom.Linecost, '+
            '  if( transPQAfrom.transtype ="TRefundSaleLine", 0- transPQAfrom.Qty ,   transPQAfrom.Qty ) inqty ,  '+
            '  if( transPQAfrom.transtype ="TRefundSaleLine", 0- transPQAfrom.Actualtotalcost ,   transPQAfrom.Actualtotalcost ) Actualtotalcost,  '+
            //' transPQAfrom.Actualtotalcost, '+
            ' totype.Description as TranstypeTo, '+
            ' transPQATo.TransId as TRansIDTo, '+
            ' transPQATo.translineId as translineIdTo, '+
            ' PQAGogs.UnitCostex, '+
            ' PQAGogs.Qty outqty, '+
            ' PQAGogs.totalcostEx '+
            '  from '+
            ' tbltransactionpqacogsdetails  PQAGogs '+
            ' inner join tbltransactionpqas transPQAfrom  on transPQAfrom.PQAID = PQAGogs.PQAID2 '+
            ' inner join tblpqatranstypes fromtype on fromtype.Transtype = transPQAfrom.TransType '+
            ' inner join tbltransactionpqas transPQATo  on transPQATo.PQAID = PQAGogs.PQAID1 '+
            ' inner join tblpqatranstypes totype on totype.Transtype = transPQAto.TransType '+
            ' where PQAGogs.ProductID = ' + inttostr(ProductID) +' '+
            ' union all '+
            ' select '+
            ' (Select Max(ID)  from tbltransactionpqacogsdetails )+1 as PQAGogsId, '+
            ' TransPQA.PQAID, '+
            ' NULL toPQAID, '+
            ' TransPQA.TransDate, '+
            ' fromtype.Description as TranstypeFrom, '+
            ' TransPQA.TransId as TRansIDFrom, '+
            ' TransPQA.translineId as translineIdFrom, '+
            ' TransPQA.Linecost, '+
            '  if( TransPQA.transtype ="TRefundSaleLine", 0- TransPQA.Qty  ,   TransPQA.Qty  ) inqty ,  '+
            '  if( TransPQA.transtype ="TRefundSaleLine", 0- TransPQA.Actualtotalcost  ,   TransPQA.Actualtotalcost  ) Actualtotalcost ,  '+
            //' TransPQA.Actualtotalcost, '+
            ' null as TranstypeTo, '+
            ' null as TRansIDTo, '+
            ' null as translineIdTo, '+
            ' null as UnitCostex, '+
            ' null as outqty, '+
            ' null as totalcostEx '+
            '  from '+
            '  tbltransactionpqas TransPQA '+
            ' left join tbltransactionpqacogsdetails  PQAGogs  on TransPQA.PQAID = PQAGogs.PQAID2 '+
            ' inner join tblpqatranstypes fromtype on fromtype.Transtype = TransPQA.TransType '+
            ' where TransPQA.ProductID = ' + inttostr(ProductID) +' '+
            ' and ifnull(PQAGogs.Id,0)=0 '+
            ' and (((TransPQA.Alloctype = "IN"  and TransPQA.qty >0 '+
            ' and TransPQA.transtype <>"TRefundSaleLine" ) or (TransPQA.Alloctype = "OUT" '+
            ' and TransPQA.Qty <0) or (TransPQA.transtype ="TRefundSaleLine" and TransPQA.Qty <0)  ) '+
            ' and TransPQA.transtype <> "TProcTreePartIN" and TransPQA.transtype <> "TProcTreePartINDONE" and ifnull(TransPQA.StockQty,0) <>0   '+
            ' and TransPQA.IsSubBOM <> "T" ) '+
            ' union all '+
            ' select '+
            ' (Select Max(ID)  from tbltransactionpqacogsdetails )+2  as PQAGogsId, '+
            ' null PQAID, '+
            ' TransPQA.PQAID topqaid, '+
            ' TransPQA.TransDate, '+
            ' null as TranstypeFrom, '+
            ' null as TRansIDFrom, '+
            ' null as translineIdFrom, '+
            ' null, '+
            ' null inqty, '+
            ' null , '+
            ' fromtype.Description as TranstypeTo, '+
            ' TransPQA.TransId as TRansIDTo, '+
            ' TransPQA.translineId as translineIdTo, '+
            ' TransPQA.Linecost as UnitCostex, '+
            ' TransPQA.Qty as outqty, '+
            ' TransPQA.Actualtotalcost as totalcostEx '+
            '  from '+
            '  tbltransactionpqas TransPQA '+
            ' left join tbltransactionpqacogsdetails  PQAGogs  on TransPQA.PQAID = PQAGogs.PQAID1 '+
            ' inner join tblpqatranstypes fromtype on fromtype.Transtype = TransPQA.TransType '+
            ' where TransPQA.ProductID = ' + inttostr(ProductID) +' '+
            ' and ifnull(PQAGogs.Id,0)=0 '+
            ' and ( ((TransPQA.Alloctype = "OUT"   '+
            ' and TransPQA.qty >0) or (TransPQA.Alloctype = "IN" and TransPQA.Qty <0) or (TransPQA.transtype ="TRefundSaleLine"  '+
            ' and TransPQA.Qty >0) )  and ifnull(TransPQA.StockQty,0) <>0 and TransPQA.IsSubBOM <> "T") '+
            ' order by PQAGogsId, TransDate; ');

            (*' select '+
            ' transPQAfrom.PQAID, '+
            ' fromtype.Description as TranstypeFrom, '+
            ' transPQAfrom.TransId as TRansIDFrom, '+
            ' transPQAfrom.translineId as translineIdFrom, '+
            ' transPQAfrom.Linecost, '+
            ' transPQAfrom.Qty inqty, '+
            ' transPQAfrom.Actualtotalcost, '+
            ' totype.Description as TranstypeTo, '+
            ' transPQATo.TransId as TRansIDTo, '+
            ' transPQATo.translineId as translineIdTo, '+
            ' PQAGogs.UnitCostex, '+
            ' PQAGogs.Qty outqty, '+
            ' PQAGogs.totalcostEx '+
            '  from '+
            ' tbltransactionpqacogsdetails  PQAGogs '+
            ' inner join tbltransactionpqas transPQAfrom  on transPQAfrom.PQAID = PQAGogs.PQAID2 '+
            ' inner join tblpqatranstypes fromtype on fromtype.Transtype = transPQAfrom.TransType '+
            ' inner join tbltransactionpqas transPQATo  on transPQATo.PQAID = PQAGogs.PQAID1 '+
            ' inner join tblpqatranstypes totype on totype.Transtype = transPQAto.TransType'+
            ' where PQAGogs.ProductID = ' + inttostr(ProductID) +
            ' order by PQAGogs.ID;');*)



    SQL.Add('ALTER TABLE '+tablename +' 	ADD COLUMN `ID` INT(11) NOT NULL AUTO_INCREMENT FIRST, 	ADD PRIMARY KEY (`ID`);');
    SQL.Add('alter table '+ tablename +' add column colorindex int(11);');
    SQL.Add('alter table '+ tablename +' add column runningQty double;');
    SQL.Add('alter table '+ tablename +' add column runningamount double;');
    SQL.Add('alter table '+ tablename +' add column sameINPQa enum("T","F") default "F";');
    execute;
    SQL.clear;
  end;
    if qryTemp.active then qryTemp.close;
    qryTemp.SQL.clear;
    qryTemp.Sql.add('Select * from '+ tablename );
    qryTemp.open;
    if qryTemp.recordcount > 0 then begin
      qryTemp.First;
      runningQty := 0;
      runningamount := 0;
      PQAID := 0;
      colorindex := 1;
      While qryTemp.Eof = False do begin
        if PQAID<> qryTemp.fieldbyname('PQAID').AsInteger then begin
          runningQty := runningQty + qryTemp.fieldbyname('inQty').AsFloat;
          runningamount := runningamount + qryTemp.fieldbyname('Actualtotalcost').AsFloat;
          PQAID :=qryTemp.fieldbyname('PQAID').AsInteger ;
          if colorindex = 1 then colorindex := 2 else colorindex := 1;
        end else begin
          editDB(qryTemp);
          qryTemp.fieldbyname('sameINPQa').AsBoolean := True;
          Postdb(qryTemp);
        end;
        runningQty := runningQty - qryTemp.fieldbyname('outQty').AsFloat;
        runningamount := round(runningamount - qryTemp.fieldbyname('totalcostex').AsFloat, Appenv.RegionalOptions.DecimalPlaces);
        editDB(qryTemp);
        qryTemp.fieldbyname('runningQty').asFloat := runningQty;
        qryTemp.fieldbyname('runningamount').asFloat := runningamount;
        qryTemp.fieldbyname('colorindex').asInteger := colorindex;
        postDB(qryTemp);
        qryTemp.Next;
      end;

  end;
  inherited;

end;

procedure TPQAMovementGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainPQAID.fieldname);
  RemoveFieldfromGrid(qryMaintranslineIdFrom.fieldname);
  RemoveFieldfromGrid(qryMaintranslineIdTo.fieldname);
  RemoveFieldfromGrid(QrymainsameINPQa.fieldname);
  RemoveFieldfromGrid(QrymainId.fieldname);
end;
initialization
  RegisterClassOnce(TPQAMovementGUI);


end.
