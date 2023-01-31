unit SubtaxSummaryreport_SubTaxCode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SubtaxSummaryreport, BaseListingForm, DAScript, MyScript,
  ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook,
  DNMSpeedButton, Shader, DNMPanel, CustomInputBox, wwclearbuttongroup,
  wwradiogroup;

type
  TSubtaxSummaryreport_SubTaxCodeGUI = class(TSubtaxSummaryreportGUI)
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
  Protected
    function CreateTaxSummaryTempTable(const DateFrom,DateTo: TDateTime): Boolean;override;
    function tablenamePrefix:String;Override;
    procedure MakeQrymain;Override;
  public
  end;


implementation

uses CommonDbLib, CommonLib, tcConst;

{$R *.dfm}
function TSubtaxSummaryreport_SubTaxCodeGUI.CreateTaxSummaryTempTable(Const DateFrom, DateTo: TDateTime):Boolean;
begin
  result := inherited CreateTaxSummaryTempTable(DateFrom,DateTo);
  With ScriptMain do begin
    SQL.clear;
    SQL.add('Drop table if Exists ' +tablename +'1;');
    Sql.Add('CREATE TABLE ' + TableName + '1 ( ');
    Sql.Add('`ID` int(11) NOT NULL auto_increment,  ');
    SQL.add('Details int(11) NOT NULL , ' );
    SQL.add('type varchar(10),  ' );
    SQL.add('TransID int(11) NOT NULL default 0,  ' );
    SQL.add('Taxcode varchar(20), ' );
    SQL.add('subTaxCode varchar(20), ' );
    SQL.add('INPUT_AmountEx double NOT NULL default 0, ' );
    SQL.add('INPUT_AmountInc double NOT NULL default 0, ' );
    SQL.add('OUTPUT_AmountEx double NOT NULL default 0, ' );
    SQL.add('OUTPUT_AmountInc double NOT NULL default 0, ' );
    SQL.add('totalNet  double NOT NULL default 0, ' );
    SQL.add('TotalTax  double NOT NULL default 0, ' );
    SQL.add('Percentage  double NOT NULL default 0,' );
    Sql.Add('PRIMARY KEY  (`ID`)) ENGINE=MyISAM; ');
    Sql.Add('ALTER TABLE '+ tablename +'1 ADD INDEX `OrderFldsIdx` (type, TransID, Taxcode, details, subtaxcode);');

    SQL.add('insert into ' +tablename +'1  (details,  type,transID,taxcode,subtaxcode , INPUT_AmountEx,INPUT_AmountInc,OUTPUT_AmountEx ,OUTPUT_AmountInc, totalNet,TotalTax,Percentage)');
    SQL.add('select ' );
    SQL.add('1                      as Details, ' );
    SQL.add('"Sales"                as type,  ' );
    SQL.add('0               as TransID,  ' );
    SQL.add('NULL              as Taxcode, ' );
    SQL.add('STL.SubTaxCode         as subTaxCode , ' );
(*    SQL.add('NULL                   as INPUT_AmountEx, ' );
    SQL.add('NULL                   as INPUT_AmountInc, ' );
    SQL.add('sum(OUTPUT_AmountEx)   as OUTPUT_AmountEx, ' );
    SQL.add('sum(OUTPUT_AmountInc)  as OUTPUT_AmountInc, ' );*)
    SQL.add('sum(INPUT_AmountEx)    as INPUT_AmountEx, ' );
    SQL.add('sum(INPUT_AmountInc)   as INPUT_AmountInc, ' );
    SQL.add('sum(OUTPUT_AmountEx)   as OUTPUT_AmountEx, ' );
    SQL.add('sum(OUTPUT_AmountInc)  as OUTPUT_AmountInc, ' );
    (*SQL.add('sum(0- STL.TaxAmount)  as totalNet , ' );
    SQL.add('sum(0- STL.TaxAmount)  as TotalTax , ' );*)
    SQL.add('sum(TotalNet)          as TotalNet, ' );
    SQL.add('sum(0- (if(ifnull(STL.ID,0)=0 , SL.LineTax , STL.TaxAmount)))          as TotalTax, ' );
    SQL.add('STL.Percentage         as Percentage ' );
    SQL.add('from ' + tablename +'  T ' );
    SQL.add('inner join  tblsaleslines SL on T.SaleId = Sl.saleId and T.salelineId = sl.salelineId and ifnull(T.salelineId,0)<>0' );
    SQL.add('inner join tblsalestaxcodes ST on SL.SaleId = ST.SaleId and SL.SaleLineID = ST.SaleLineId ' );
    SQL.add('inner join tblsalestaxcodelines STL on ST.ID = STL.SalesTaxCodeID ' );
    SQL.add('group by STL.SubTaxCode ;' );
    //SQL.add('union all ' );
    SQL.add('insert into ' +tablename +'1  (details,  type,transID,taxcode,subtaxcode , INPUT_AmountEx,INPUT_AmountInc,OUTPUT_AmountEx ,OUTPUT_AmountInc, totalNet,TotalTax,Percentage)');
    SQL.add('select ' );
    SQL.add('1                      as Details,' );
    SQL.add('"PO"                   as type,  ' );
    SQL.add('0               as TransID,  ' );
    SQL.add('NULL              as Taxcode, ' );
    SQL.add('PTL.SubTaxCode         as subTaxCode , ' );
    SQL.add('sum(INPUT_AmountEx)    as INPUT_AmountEx, ' );
    SQL.add('sum(INPUT_AmountInc)   as INPUT_AmountInc, ' );
    SQL.add('sum(OUTPUT_AmountEx)   as OUTPUT_AmountEx, ' );
    SQL.add('sum(OUTPUT_AmountInc)  as OUTPUT_AmountInc, ' );
    (*SQL.add('Sum(PTL.TaxAmount)     as totalNet ,  ' );
    SQL.add('Sum(PTL.TaxAmount)     as TotalTax, ' );*)
    SQL.add('sum(TotalNet)          as TotalNet, ' );
    SQL.add('sum((if(ifnull(PTL.ID,0)=0 , PL.LineTax , PTL.TaxAmount)))          as TotalTax, ' );
    SQL.add('PTL.Percentage         as Percentage ' );
    SQL.add('from ' + tablename +'  T ' );
    SQL.add('inner join  tblpurchaselines PL on pl.purchaseorderId = t.purchaseorderId and Pl.purchaselineId = t.purchaselineId and ifnull(T.purchaselineId,0)<>0' );
    SQL.add('inner  join tblpurchasetaxcodes PT on PL.PurchaseORderID = PT.PurchaseORderID and PL.PurchaseLineID= PT.PurchaseLineId ' );
    SQL.add('inner  join tblpurchasetaxcodelines PTL on PT.ID = PTL.PurchaseTaxCodeID ' );
    SQL.add('group by PTL.SubTaxCode;' );

    //SQL.add('union all ' );
    SQL.add('insert into ' +tablename +'1  (details,  type,transID,taxcode,subtaxcode , INPUT_AmountEx,INPUT_AmountInc,OUTPUT_AmountEx ,OUTPUT_AmountInc, totalNet,TotalTax,Percentage)');
    SQL.add('select ' );
    SQL.add('2                      as Details, ' );
    SQL.add('"Sales"                as type,  ' );
    SQL.add('0               as TransID,  ' );
    SQL.add('t.Taxcode              as Taxcode, ' );
    SQL.add('STL.SubTaxCode         as subTaxCode , ' );
(*    SQL.add('NULL                   as INPUT_AmountEx, ' );
    SQL.add('NULL                   as INPUT_AmountInc, ' );
    SQL.add('NULL                   as OUTPUT_AmountEx, ' );
    SQL.add('NULL                   as OUTPUT_AmountInc, ' );*)
    SQL.add('sum(INPUT_AmountEx)    as INPUT_AmountEx, ' );
    SQL.add('sum(INPUT_AmountInc)   as INPUT_AmountInc, ' );
    SQL.add('sum(OUTPUT_AmountEx)   as OUTPUT_AmountEx, ' );
    SQL.add('sum(OUTPUT_AmountInc)  as OUTPUT_AmountInc, ' );
    //SQL.add('sum(0- STL.TaxAmount)  as totalNet , ' );
    SQL.add('sum(TotalNet)          as TotalNet, ' );
    //SQL.add('sum(0- STL.TaxAmount)  as TotalTax , ' );
    SQL.add('sum(0- (if(ifnull(STL.ID,0)=0 , SL.LineTax , STL.TaxAmount)))          as TotalTax, ' );
    SQL.add('STL.Percentage         as Percentage ' );
    SQL.add('from ' + tablename +'  T ' );
    SQL.add('inner join  tblsaleslines SL on T.SaleId = Sl.saleId and T.salelineId = sl.salelineId and ifnull(T.salelineId,0)<>0' );
    SQL.add('inner join tblsalestaxcodes ST on SL.SaleId = ST.SaleId and SL.SaleLineID = ST.SaleLineId ' );
    SQL.add('inner join tblsalestaxcodelines STL on ST.ID = STL.SalesTaxCodeID ' );
    SQL.add('group by STL.SubTaxCode , T.Taxcode;' );
    //SQL.add('union all ' );
    SQL.add('insert into ' +tablename +'1  (details,  type,transID,taxcode,subtaxcode , INPUT_AmountEx,INPUT_AmountInc,OUTPUT_AmountEx ,OUTPUT_AmountInc, totalNet,TotalTax,Percentage)');
    SQL.add('select ' );
    SQL.add('2                      as Details,' );
    SQL.add('"PO"                   as type,  ' );
    SQL.add('0               as TransID,  ' );
    SQL.add('T.Taxcode              as Taxcode, ' );
    SQL.add('PTL.SubTaxCode         as subTaxCode , ' );
(*    SQL.add('NULL                   as INPUT_AmountEx, ' );
    SQL.add('NULL                   as INPUT_AmountInc, ' );
    SQL.add('NULL                   as OUTPUT_AmountEx, ' );
    SQL.add('NULL                   as OUTPUT_AmountInc, ' );*)
    SQL.add('sum(INPUT_AmountEx)    as INPUT_AmountEx, ' );
    SQL.add('sum(INPUT_AmountInc)   as INPUT_AmountInc, ' );
    SQL.add('sum(OUTPUT_AmountEx)   as OUTPUT_AmountEx, ' );
    SQL.add('sum(OUTPUT_AmountInc)  as OUTPUT_AmountInc, ' );
    //SQL.add('Sum(PTL.TaxAmount)     as totalNet ,  ' );
    SQL.add('sum(TotalNet)          as TotalNet, ' );
    //SQL.add('Sum(PTL.TaxAmount)     as TotalTax, ' );
    SQL.add('sum((if(ifnull(PTL.ID,0)=0 , PL.LineTax , PTL.TaxAmount)))          as TotalTax, ' );
    SQL.add('PTL.Percentage         as Percentage ' );
    SQL.add('from ' + tablename +'  T ' );
    SQL.add('inner join  tblpurchaselines PL on pl.purchaseorderId = t.purchaseorderId and Pl.purchaselineId = t.purchaselineId and ifnull(T.purchaselineId,0)<>0' );
    SQL.add('inner  join tblpurchasetaxcodes PT on PL.PurchaseORderID = PT.PurchaseORderID and PL.PurchaseLineID= PT.PurchaseLineId ' );
    SQL.add('inner  join tblpurchasetaxcodelines PTL on PT.ID = PTL.PurchaseTaxCodeID ' );
    SQL.add('group by PTL.SubTaxCode, T.Taxcode;' );

    //SQL.add('union all ' );
    SQL.add('insert into ' +tablename +'1  (details,  type,transID,taxcode,subtaxcode , INPUT_AmountEx,INPUT_AmountInc,OUTPUT_AmountEx ,OUTPUT_AmountInc, totalNet,TotalTax,Percentage)');
    SQL.add('select ' );
    SQL.add('3                      as Details, ' );
    SQL.add('"Sales"                as type,  ' );
    SQL.add('T.SaleId               as TransID,  ' );
    SQL.add('t.Taxcode              as Taxcode, ' );
    SQL.add('STL.SubTaxCode         as subTaxCode , ' );
(*    SQL.add('NULL                   as INPUT_AmountEx, ' );
    SQL.add('NULL                   as INPUT_AmountInc, ' );
    SQL.add('NULL                   as OUTPUT_AmountEx, ' );
    SQL.add('NULL                   as OUTPUT_AmountInc, ' );*)
    SQL.add('sum(INPUT_AmountEx)    as INPUT_AmountEx, ' );
    SQL.add('sum(INPUT_AmountInc)   as INPUT_AmountInc, ' );
    SQL.add('sum(OUTPUT_AmountEx)   as OUTPUT_AmountEx, ' );
    SQL.add('sum(OUTPUT_AmountInc)  as OUTPUT_AmountInc, ' );
    //SQL.add('sum(0- STL.TaxAmount)  as totalNet , ' );
    SQL.add('sum(TotalNet)          as TotalNet, ' );
    //SQL.add('sum(0- STL.TaxAmount)  as TotalTax , ' );
    SQL.add('sum(0- (if(ifnull(STL.ID,0)=0 , SL.LineTax , STL.TaxAmount)))          as TotalTax, ' );
    SQL.add('STL.Percentage         as Percentage ' );
    SQL.add('from ' + tablename +'  T ' );
    SQL.add('inner join  tblsaleslines SL on T.SaleId = Sl.saleId and T.salelineId = sl.salelineId and ifnull(T.salelineId,0)<>0' );
    SQL.add('inner join tblsalestaxcodes ST on SL.SaleId = ST.SaleId and SL.SaleLineID = ST.SaleLineId ' );
    SQL.add('inner join tblsalestaxcodelines STL on ST.ID = STL.SalesTaxCodeID ' );
    SQL.add('group by STL.SubTaxCode , T.Taxcode ,T.saleID ;' );
    //SQL.add('union all ' );
    SQL.add('insert into ' +tablename +'1  (details,  type,transID,taxcode,subtaxcode , INPUT_AmountEx,INPUT_AmountInc,OUTPUT_AmountEx ,OUTPUT_AmountInc, totalNet,TotalTax,Percentage)');
    SQL.add('select ' );
    SQL.add('3                      as Details,' );
    SQL.add('"PO"                   as type,  ' );
    SQL.add('T.purchaseOrderID      as TransID,  ' );
    SQL.add('T.Taxcode              as Taxcode, ' );
    SQL.add('PTL.SubTaxCode         as subTaxCode , ' );
(*    SQL.add('NULL                   as INPUT_AmountEx, ' );
    SQL.add('NULL                   as INPUT_AmountInc, ' );
    SQL.add('NULL                   as OUTPUT_AmountEx, ' );
    SQL.add('NULL                   as OUTPUT_AmountInc, ' );*)
    SQL.add('sum(INPUT_AmountEx)    as INPUT_AmountEx, ' );
    SQL.add('sum(INPUT_AmountInc)   as INPUT_AmountInc, ' );
    SQL.add('sum(OUTPUT_AmountEx)   as OUTPUT_AmountEx, ' );
    SQL.add('sum(OUTPUT_AmountInc)  as OUTPUT_AmountInc, ' );
    //SQL.add('Sum(PTL.TaxAmount)     as totalNet ,  ' );
    SQL.add('sum(TotalNet)          as TotalNet, ' );
    //SQL.add('Sum(PTL.TaxAmount)     as TotalTax, ' );
    SQL.add('sum((if(ifnull(PTL.ID,0)=0 , PL.LineTax , PTL.TaxAmount)))          as TotalTax, ' );
    SQL.add('PTL.Percentage         as Percentage ' );
    SQL.add('from ' + tablename +'  T ' );
    SQL.add('inner join  tblpurchaselines PL on pl.purchaseorderId = t.purchaseorderId and Pl.purchaselineId = t.purchaselineId and ifnull(T.purchaselineId,0)<>0' );
    SQL.add('inner  join tblpurchasetaxcodes PT on PL.PurchaseORderID = PT.PurchaseORderID and PL.PurchaseLineID= PT.PurchaseLineId ' );
    SQL.add('inner  join tblpurchasetaxcodelines PTL on PT.ID = PTL.PurchaseTaxCodeID ' );
    SQL.add('group by PTL.SubTaxCode, T.Taxcode, T.purchaseORderId' );
    SQL.add('/*order by type, TransID, Taxcode, details, subtaxcode*/');
    sql.Savetofile('c:\temp\temp.sql');
    doShowProgressbar(10, WAITMSG);
    try
      Execute;
    finally
      DoHideProgressbar;
    end;
  end;
end;

procedure TSubtaxSummaryreport_SubTaxCodeGUI.grdMainCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean;
  AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if (*(grpfilters.Itemindex = 0) and*) (Qrymaindetails.AsInteger =1) then begin
          if Sametext(Field.fieldname , qrymaintype.fieldname) then Afont.color := ABrush.color
    else  if Sametext(Field.fieldname , qrymaintransId.fieldname) then Afont.color := ABrush.color
    else  if Sametext(Field.fieldname , qrymaintaxcode.fieldname) then Afont.color := ABrush.color;
  end else   if (*(grpfilters.Itemindex =1) and*) (Qrymaindetails.AsInteger =2) then begin
          if Sametext(Field.fieldname , qrymaintype.fieldname)              then Afont.color := ABrush.color
    else  if Sametext(Field.fieldname , qrymaintransId.fieldname)           then Afont.color := ABrush.color
    else  if Sametext(Field.fieldname , qryMainINPUT_AmountEx.fieldname)    and (qryMainINPUT_AmountEx.asFloat    =0) then Afont.color := ABrush.color
    else  if Sametext(Field.fieldname , qryMainINPUT_AmountInc.fieldname)   and (qryMainINPUT_AmountInc.asFloat   =0) then Afont.color := ABrush.color
    else  if Sametext(Field.fieldname , qryMainOUTPUT_AmountEx.fieldname)   and (qryMainOUTPUT_AmountEx.asFloat   =0) then Afont.color := ABrush.color
    else  if Sametext(Field.fieldname , qryMainOUTPUT_AmountInc.fieldname)  and (qryMainOUTPUT_AmountInc.asFloat  =0) then Afont.color := ABrush.color;
  end else   if (*(grpfilters.Itemindex =2) and*) (Qrymaindetails.AsInteger =3) then begin
          if Sametext(Field.fieldname , qryMainINPUT_AmountEx.fieldname)    and (qryMainINPUT_AmountEx.asFloat    =0) then Afont.color := ABrush.color
    else  if Sametext(Field.fieldname , qryMainINPUT_AmountInc.fieldname)   and (qryMainINPUT_AmountInc.asFloat   =0) then Afont.color := ABrush.color
    else  if Sametext(Field.fieldname , qryMainOUTPUT_AmountEx.fieldname)   and (qryMainOUTPUT_AmountEx.asFloat   =0) then Afont.color := ABrush.color
    else  if Sametext(Field.fieldname , qryMainOUTPUT_AmountInc.fieldname)  and (qryMainOUTPUT_AmountInc.asFloat  =0) then Afont.color := ABrush.color;
  end;

end;

procedure TSubtaxSummaryreport_SubTaxCodeGUI.MakeQrymain;
begin
  inherited;
  Qrymain.SQL.add('order by subtaxcode, Taxcode, type, TransID ');
end;

function TSubtaxSummaryreport_SubTaxCodeGUI.tablenamePrefix: String;
begin
  REsult:= 'Sub';
end;

initialization
  RegisterClassOnce(TSubtaxSummaryreport_SubTaxCodeGUI);

end.

