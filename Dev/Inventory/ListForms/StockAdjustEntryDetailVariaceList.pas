unit StockAdjustEntryDetailVariaceList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StockAdjustEntryDetailList, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  ComCtrls, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TStockAdjustEntryDetailVariaceListGUI = class(TStockAdjustEntryDetailListGUI)
    qryMainAdjustmentdate: TDateTimeField;
    qryMainInstockQty: TFloatField;
    qryMainInstockUOMQty: TFloatField;
    qryMainBatchInstockUOMQty: TFloatField;
    qryMainBinInstockUOMQty: TFloatField;
    qryMainSNInstockUOMQty: TFloatField;
    qryMainAvgCost: TFloatField;
    qryMainBatchNo: TWideStringField;
    qryMainExpiryDate: TDateTimeField;
    qryMainBinlocation: TWideStringField;
    qryMainBinnumber: TWideStringField;
    qryMainSerialnumber: TWideStringField;
    qryMainCounter: TIntegerField;
    qryMainVarianceQty: TFloatField;
    qryMainBatchVarianceQty: TFloatField;
    qryMainBinVarianceQty: TFloatField;
    qryMainSNVarianceQty: TFloatField;
    qryMainVarianceCost: TFloatField;
    qryMainEmployeename: TWideStringField;
    qryMainPrDescription: TWideStringField;
    qryMainPrintName: TWideStringField;
    qryMainNotes: TWideStringField;
    optAdj: TwwRadioGroup;
    qrymainBatchFinalUOMQty: TFloatField;
    qryMainSNFinalUOMQty: TFloatField;
    qryMainBinFinalUOMQty: TFloatField;
    qryMainBAtchVarianceCost: TFloatField;
    qryMainBinVarianceCost: TFloatField;
    qryMainSNVarianceCost: TFloatField;
    qryMainPartsNum: TIntegerField;
    qryMainClassNum: TIntegerField;
    qryMainUOMNum: TIntegerField;
    qryMainBatchNum: TIntegerField;
    qryMainBinNum: TIntegerField;
    qryMainSNNum: TIntegerField;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure optAdjClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
  private
    fsTablename :String;
    procedure CreateTable;
    procedure initpartsform(Sender: TObject);
  Protected
    procedure SetGridColumns; Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, CommonFormLib, CommonDbLib, tcConst, LogLib, ProductQtyLib,
  MySQLConst, frmPartsFrm, ProductMovementList, BaseListingForm;

{$R *.dfm}
Procedure TStockAdjustEntryDetailVariaceListGUI.CreateTable;
begin
  With Scriptmain do begin
    SQL.clear;
    SQL.Add('Drop table if exists '+ fstablename +';');
    SQL.Add('CREATE TABLE '+ fstablename +' ( ');
    SQL.Add(' ID                INT(11) NOT NULL AUTO_INCREMENT, ');
    SQL.Add(' PartsId           INT(11) NOT NULL DEFAULT 0 , ');
    SQL.Add(' AccountID         INT(11) NOT NULL DEFAULT 0 , ');
    SQL.Add(' Partname          VARCHAR(255) NOT NULL DEFAULT 0 , ');
    SQL.Add(' PreferedSupplier  VARCHAR(255) NULL DEFAULT NULL, ');
    SQL.Add(' SAID              INT(11) NOT NULL DEFAULT 0 , ');
    SQL.Add(' Adjusttype        VARCHAR(10) NOT NULL DEFAULT 0 , ');
    SQL.Add(' Adjustmentdate    DATETIME NULL DEFAULT NULL, ');
    SQL.Add(' Description       VARCHAR(255) NULL DEFAULT NULL, ');
    SQL.Add(' ClassID           INT(11) NULL DEFAULT NULL, ');
    SQL.Add(' ClassName         VARCHAR(255) NULL DEFAULT NULL, ');
    SQL.Add(' FinalQty          Double Not Null Default 0 , ');
    SQL.Add(' AdjustQty         Double Not Null Default 0 , ');
    SQL.Add(' AvailableQty      Double Not Null Default 0 , ');
    SQL.Add(' InstockQty        Double Not Null Default 0 , ');
    SQL.Add(' FinalUOMQty       Double Not Null Default 0 , ');
    SQL.Add(' AdjustUOMQty      Double Not Null Default 0 , ');
    SQL.Add(' AvailableUOMQty   Double Not Null Default 0 , ');
    SQL.Add(' InstockUOMQty     Double Not Null Default 0 , ');
    SQL.Add(' BatchInstockUOMQty  Double Not Null Default 0 , ');
    SQL.Add(' BinInstockUOMQty    Double Not Null Default 0 , ');
    SQL.Add(' SNInstockUOMQty     Double Not Null Default 0 , ');
    SQL.Add(' BatchFinalUOMQty  Double Not Null Default 0 , ');
    SQL.Add(' BinFinalUOMQty    Double Not Null Default 0 , ');
    SQL.Add(' SNFinalUOMQty     Double Not Null Default 0 , ');
    SQL.Add(' AdjCost           DOUBLE NULL DEFAULT 0 , ');
    SQL.Add(' AvgCost           DOUBLE NULL DEFAULT 0 , ');
    SQL.Add(' UOM               VARCHAR(255) NULL DEFAULT NULL, ');
    SQL.Add(' UOMMultiplier     DOUBLE NULL DEFAULT 0 , ');
    SQL.Add(' UOMId             INT(11) NOT NULL DEFAULT 0 , ');
    SQL.Add(' BatchNo           VARCHAR(100) NOT NULL DEFAULT "", ');
    SQL.Add(' ExpiryDate        DATETIME NULL DEFAULT NULL, ');
    SQL.Add(' Binlocation       VARCHAR(30) NOT NULL DEFAULT "", ');
    SQL.Add(' Binnumber         VARCHAR(30) NOT NULL DEFAULT "", ');
    SQL.Add(' Serialnumber      VARCHAR(100) NOT NULL DEFAULT "", ');
    SQL.Add(' Employeename      VARCHAR(255) NOT NULL DEFAULT "", ');
    SQL.Add(' PrDescription     VARCHAR(255) NOT NULL DEFAULT "", ');
    SQL.Add(' PrintName         VARCHAR(255) NOT NULL DEFAULT "", ');
    SQL.Add(' Notes             VARCHAR(255) NOT NULL DEFAULT "", ');
    SQL.Add(' Counter           INT(11) NOT NULL DEFAULT 0 , ');
    SQL.Add(' PartsNum          INT(11) NOT NULL DEFAULT 0 , ');
    SQL.Add(' ClassNum          INT(11) NOT NULL DEFAULT 0 , ');
    SQL.Add(' UOMNum            INT(11) NOT NULL DEFAULT 0 , ');
    SQL.Add(' BatchNum          INT(11) NOT NULL DEFAULT 0 , ');
    SQL.Add(' BinNum            INT(11) NOT NULL DEFAULT 0 , ');
    SQL.Add(' SNNum             INT(11) NOT NULL DEFAULT 0 , ');
    SQL.Add(' PRIMARY KEY (ID) ) COLLATE="utf8_general_ci" ENGINE=MyIsam ; ' );
    SQL.Add(' ALTER TABLE ' + fstablename +'	ADD INDEX `mixidx` (`PartsId`, `ClassID`, `UOMId`, `BatchNo`, `ExpiryDate`, `Binlocation`, `Binnumber`, `Serialnumber`);');
    clog(SQL.text);
    Execute;
  end;
end;
procedure TStockAdjustEntryDetailVariaceListGUI.FormCreate(Sender: TObject);
begin
  InitWwRadioGroup(optAdj);
  fstablename := commondblib.GetUserTemporaryTableName('SALVariance');
  CreateTable;
  Qrymain.SQL.clear;
  Qrymain.SQL.add('Select ');
  Qrymain.SQL.add('*,');

    Qrymain.SQL.add('PartsId            as ProductID, ');
    Qrymain.SQL.add('Partname           as ProductName , ');
    Qrymain.SQL.add('SAID               as StockAdjustEntryID , ');
    Qrymain.SQL.add('AdjCost            as Cost , ');
  Qrymain.SQL.add(' ""                 as accountname, ');
  Qrymain.SQL.add(' ""                 as Globalref, ');
  Qrymain.SQL.add(' "F"                as Processed,');
  Qrymain.SQL.add(' "F"                as deleted , ');
  Qrymain.SQL.add(' if(ifnull( SAID,0)=0 , 0-InstockUOMQty , FinalUOMQty- InstockUOMQty) as VarianceQty,');
  Qrymain.SQL.add(' if(ifnull( SAID,0)=0 , 0-InstockUOMQty , FinalUOMQty- InstockUOMQty)* AvgCost as VarianceCost , ');

  Qrymain.SQL.add(' if(ifnull(BatchNo,"")<>"" and ifnull( SAID,0)=0 , 0-BAtchInstockUOMQty , BAtchFinalUOMQty- BAtchInstockUOMQty) as BAtchVarianceQty,');
  Qrymain.SQL.add(' if(ifnull(BatchNo,"")<>"" and ifnull( SAID,0)=0 , 0-BAtchInstockUOMQty , BAtchFinalUOMQty- BAtchInstockUOMQty)* AvgCost as BAtchVarianceCost , ');

  Qrymain.SQL.add(' if(ifnull(Binlocation,"")<>"" and ifnull( SAID,0)=0 , 0-BinInstockUOMQty , BinFinalUOMQty- BinInstockUOMQty) as BinVarianceQty,');
  Qrymain.SQL.add(' if(ifnull(Binlocation,"")<>"" and ifnull( SAID,0)=0 , 0-BinInstockUOMQty , BinFinalUOMQty- BinInstockUOMQty)* AvgCost as BinVarianceCost , ');

  Qrymain.SQL.add(' if(ifnull(Serialnumber,"")<>"" and ifnull( SAID,0)=0 , 0-SNInstockUOMQty , SNFinalUOMQty- SNInstockUOMQty) as SNVarianceQty,');
  Qrymain.SQL.add(' if(ifnull(Serialnumber,"")<>"" and ifnull( SAID,0)=0 , 0-SNInstockUOMQty , SNFinalUOMQty- SNInstockUOMQty)* AvgCost as SNVarianceCost  ');

  Qrymain.SQL.add('from  '+ fsTablename );
  Qrymain.SQL.add('Order by Partname ,ClassName ,UOM,   BatchNo , ExpiryDate ,Binlocation , Binnumber , Serialnumber , counter, PartsNum, ClassNum , UOMNum , Batchnum, binnum, snnum, Adjustmentdate desc ');

    logtext(Qrymain.SQL.text);
  inherited;
  DisableSortoncolumtitleclick:= TRue;
  SelectionOption := soClass;
end;

procedure TStockAdjustEntryDetailVariaceListGUI.FormDestroy(Sender: TObject);
begin
  DeleteTable(fstablename);
  inherited;

end;

procedure TStockAdjustEntryDetailVariaceListGUI.FormShow(Sender: TObject);
begin
  showcontrolhint(grdmain , 'Rows in RED color Are Products having Multiple Pending Adjustments within the Date Range Selected' + NL +
                            'Rows in GREEN color Are Products having No Pending Adjustments within the Date Range Selected' +Nl+NL+
                            'Variance Qty = Final Qty - Instock.  It is -(Instock) when there is no Adjustment'+NL+
                            'Variance Cost = Variance Qty  X Product''s Average Cost'  );
  showcontrolhint(optAdj , optAdj.items[0] +' : List of Products with no Pending Stock Adjustments'+NL+
                           optAdj.items[1] +' : List of Products with Multiple Pending Stock Adjustments'+NL+
                           optAdj.items[2] +' : List of Products with single Pending Stock Adjustments'+NL);
  SearchMode := smFullList;
  inherited;
  optAdj.itemindex := optAdj.items.count-1;
end;

procedure TStockAdjustEntryDetailVariaceListGUI.grdMainCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean;
  AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if optAdj.itemindex = optAdj.items.count-1 then begin
         if QrymainCounter.asInteger =0 then DoGreenhighlight(Afont, Abrush )
    else if QrymainCounter.asInteger >1 then Doredhighlight(Afont, Abrush );
  end;
  if Sametext(field.fieldname , qryMainStockAdjustEntryID.fieldname) and (qryMainStockAdjustEntryID.asInteger =0) then DoHide(Field,State,Afont, Abrush );
  if Sametext(field.fieldname , QrymainCounter.fieldname)            and (QrymainCounter.asInteger =0)            then DoHide(Field,State,Afont, Abrush );

  if qryMainPartsNum.asInteger >1 then
    if Sametext(field.fieldname , QrymainProductname.fieldname) or
        Sametext(field.fieldname , qryMainDescription.fieldname) or
        Sametext(field.fieldname , qryMainPrintName.fieldname) or
        Sametext(field.fieldname , qryMainPreferedSupplier.fieldname) Or
        Sametext(field.fieldname , qryMainAvgCost.fieldname) OR
        Sametext(field.fieldname , qryMainTotalCost.fieldname) OR
        Sametext(field.fieldname , qryMainVarianceQty.fieldname) OR
        Sametext(field.fieldname , qryMainVarianceCost.fieldname) then  DoHide(Field,State,Afont, Abrush );
  if qryMainclassNum.asInteger >1 then
    if Sametext(field.fieldname , Qrymainclassname.fieldname) then  DoHide(Field,State,Afont, Abrush );
  if qryMainuomnum.asInteger >1 then
    if Sametext(field.fieldname , Qrymainuom.fieldname) then  DoHide(Field,State,Afont, Abrush );

  if (qryMainPartsNum.asInteger >1) Or
     (qryMainclassNum.asInteger >1) Or
     (qryMainuomnum.asInteger >1) then
      if Sametext(field.fieldname , QrymainAvailableUOMQty.fieldname) Or
          Sametext(field.fieldname , QrymainInStockUOMQty.fieldname) Or
          Sametext(field.fieldname , QrymainFinalUOMQty.fieldname) Or
          Sametext(field.fieldname , QrymainAdjustUOMQty.fieldname) then
        DoHide(Field,State,Afont, Abrush );
  if qrymainBatchNum.asInteger >1 then
    if Sametext(field.fieldname , QrymainBAtchno.fieldname) or
       Sametext(field.fieldname , QrymainExpiryDate.fieldname) or
       Sametext(field.fieldname , QrymainBAtchVarianceQty.fieldname) or
       Sametext(field.fieldname , QrymainBAtchVarianceCost.fieldname) then  DoHide(Field,State,Afont, Abrush );
  if qrymainBinnum.asInteger >1 then
    if Sametext(field.fieldname , QrymainBinlocation.fieldname) or
       Sametext(field.fieldname , QrymainBinnumber.fieldname) or
       Sametext(field.fieldname , QrymainBinVarianceQty.fieldname) or
       Sametext(field.fieldname , QrymainBinVarianceCost.fieldname) then  DoHide(Field,State,Afont, Abrush );
  if qrymainsnnum.asInteger >1 then
    if Sametext(field.fieldname , Qrymainserialnumber.fieldname) or
       Sametext(field.fieldname , QrymainSNVarianceQty.fieldname) or
       Sametext(field.fieldname , QrymainSNVarianceCost.fieldname) then  DoHide(Field,State,Afont, Abrush );


end;

procedure TStockAdjustEntryDetailVariaceListGUI.grdMainDblClick(Sender: TObject);
begin
  if sametext(activeFieldname , qrymainproductname.fieldname) and (qryMainProductID.asInteger <> 0 ) then begin
    OpenERPForm('TfrmParts' , qryMainProductID.asInteger , initpartsform );
    Exit;
  end else if sametext(activeFieldname , qryMainInstockQty.fieldname) or sametext(activeFieldname , qryMainInstockUOMQty.fieldname)  or
              sametext(activeFieldname , qryMainAvailableQty.fieldname) or sametext(activeFieldname , qryMainAvailableUOMQty.fieldname) then begin
      TProductMovementForm.showList(Self, qryMainProductID.asInteger, 0);
      Exit;
  end;
  inherited;

end;
procedure TStockAdjustEntryDetailVariaceListGUI.initpartsform( Sender: TObject);
begin
  if sender is TfrmParts then begin
      TfrmParts(Sender).pageControl.ActivePage := TTabSheet(TfrmParts(Sender).Main);
      Setcontrolfocus(TfrmParts(Sender).grdProductClasses);
  end;
end;
procedure TStockAdjustEntryDetailVariaceListGUI.optAdjClick( Sender: TObject);
begin
  if optAdj.itemindex =0 then GroupfilterString :=  'Counter =0 '//+' or (PartsNum=1 and ClassNum=1 and UOMNum =1 and BatchNum =1 and BinNum = 1 and SNNum=1) '
  else if optAdj.itemindex =1 then GroupfilterString :=  'Counter >1 '//+' or (PartsNum=1 and ClassNum=1 and UOMNum =1 and BatchNum =1 and BinNum = 1 and SNNum=1) '
  else if optAdj.itemindex =2 then GroupfilterString :=  'Counter =1 '//+' or (PartsNum=1 and ClassNum=1 and UOMNum =1 and BatchNum =1 and BinNum = 1 and SNNum=1) '
  else GroupfilterString := '';
  inherited grpFiltersClick(Sender);
end;

procedure TStockAdjustEntryDetailVariaceListGUI.ReadnApplyGuiPrefExtra;
var
  x:Integer;
begin
  inherited;
        x := GuiPrefs.Node['optAdj.ItemIndex'].asInteger;
        if x > 0 then if optAdj.Items.Count >= x then optAdj.ItemIndex := x - 1;
end;

procedure TStockAdjustEntryDetailVariaceListGUI.RefreshQuery;
var
  s:String;
  ctr:Integer;
begin
  With scriptmain do begin
    SQL.Clear;
    SQL.Add('/*1*/Truncate  table  '+ fstablename +';');
    SQL.Add('/*2*/insert ignore into  ' + fstablename +' (PartsId , Partname, Adjusttype, PreferedSupplier , SAID , Adjustmentdate , Description , '+
                                                    ' ClassID , classname, '+
                                                    ' FinalQty,AdjustQty,AvailableQty,InstockQty,FinalUOMQty,AdjustUOMQty,AvailableUOMQty,InstockUOMQty, '+
                                                    ' AdjCost,AvgCost, '+
                                                    ' UOM,UOMMultiplier,UOMId, '+
                                                    ' BatchNo,ExpiryDate,Binlocation,Binnumber,Serialnumber ,Counter,Employeename,Notes , Printname , PRDescription) ' + NL+
                  ' SELECT distinct ' +
                  ' P.partsId, ' +
                  ' P.partname , ' +
                  ' SL.Adjusttype , '+
                  ' P.PREFEREDSUPP , ' +
                  ' SL.StockAdjustEntryID, ' +
                  ' SL.Adjustmentdate , ' +
                  ' SLL.Description, ' +
                  ' SLL.ClassID, ' +
                  ' SLL.ClassName, ' +NL+
                  ' FinalQty         as FinalQty ,' +NL+
                  ' AdjustQty        as AdjustQty ,' +NL+
                  ' AvailableQty     as AvailableQty ,' +NL+
                  ' instockQty       as InstockQty,' +NL+
                  ' FinalUOMQty      as FinalUOMQty ,' +NL+
                  ' AdjustUOMQty     as AdjustUOMQty ,' +NL+
                  ' AvailableUOMQty  as AvailableUOMQty ,' +NL+
                  ' instockUOMQty    as InstockUOMQty,' +NL+
                  ' SLL.Cost, ' +
                  ' P.AvgCost  , ' +
                  ' SLL.UOM, ' +
                  ' SLL.UOMMultiplier, ' +
                  ' SLL.UOMID, ' +
                  ' null BatchNo , ' +
                  ' null expirydate, ' +
                  ' null binlocation, ' +
                  ' null binnumber, ' +
                  ' null serialnumber , ' +
                  ' if(ifnull(SL.StockAdjustEntryID,0)=0, 0 , 1), '+
                  ' SL.Employee as Employeename, SLL.Notes, P.ProductPrintName , P.PARTSDESCRIPTION' +
                  ' from tblParts P ' +
                  ' left  join (tblStockAdjustEntrylines as SLL ' +
                              ' inner join tblStockAdjustEntry as SL on SL.StockAdjustEntryID = SLL.StockAdjustEntryID ' +
                              ' and ifnull(SLL.Deleted,"F") <> "T" ' +
                              ' and ifnull(SL.Deleted,"F") <> "T" ' +
                              ' and ifnull(SL.Processed,"F") <> "T" ' +
                              ' and SL.Adjustmentdate  between ' + quotedstr(formatdatetime(mysqldatetimeformat , Filterdatefrom))+ ' and  ' + quotedstr(formatdatetime(mysqldatetimeformat , FilterdateTo))+ ' ) ' +
                  ' on SLL.ProductID = P.PartsID ' +
                  ' where p.parttype ="INV" '+
                  iif(SelectedClassid<> 0 , ' and SLL.ClassID = ' + inttostr(SelectedClassid) , '') +
                  ' and (( ifnull(SLL.BatchNo , "") = "" and ifnull(SLL.binlocation,"") = "" and ifnull(SLL.serialnumber, "") = "" ) Or (/*ifnull(FinalQty,0)<>0 or */ifnull(AdjustQty,0)<> 0) ) '+
                  iif(IsLimit0selection,' Limit 0 ' ,'')+
                  ';');

    SQL.Add('/*2-1*/insert ignore into  ' + fstablename +' (PartsId , Partname, Adjusttype, PreferedSupplier , SAID , Adjustmentdate , Description , '+
                                                    ' ClassID , classname, '+
                                                    ' FinalQty,AdjustQty,AvailableQty,InstockQty,FinalUOMQty,AdjustUOMQty,AvailableUOMQty,InstockUOMQty, '+
                                                    ' AdjCost,AvgCost, '+
                                                    ' UOM,UOMMultiplier,UOMId, '+
                                                    ' BatchNo,ExpiryDate,Binlocation,Binnumber,Serialnumber ,Counter,Employeename,Notes , Printname , PRDescription) ' + NL+
                  ' SELECT ' +
                  ' P.partsId, ' +
                  ' P.partname , ' +
                  ' SL.Adjusttype , '+
                  ' P.PREFEREDSUPP , ' +
                  ' SL.StockAdjustEntryID, ' +
                  ' SL.Adjustmentdate , ' +
                  ' SLL.Description, ' +
                  ' SLL.ClassID, ' +
                  ' SLL.ClassName, ' +NL+
                  ' if (ifnull(SLL.BatchNo , "") <> "" or ifnull(SLL.binlocation,"") <> "" or ifnull(SLL.serialnumber, "") <> "" , SLL.AllocationFinalqty       , FinalQty)         as FinalQty ,' +NL+
                  ' if (ifnull(SLL.BatchNo , "") <> "" or ifnull(SLL.binlocation,"") <> "" or ifnull(SLL.serialnumber, "") <> "" , SLL.AllocationAdjustqty      , AdjustQty)        as AdjustQty ,' +NL+
                  ' if (ifnull(SLL.BatchNo , "") <> "" or ifnull(SLL.binlocation,"") <> "" or ifnull(SLL.serialnumber, "") <> "" , SLL.AllocationAvailableqty   , AvailableQty)     as AvailableQty ,' +NL+
                  ' if (ifnull(SLL.BatchNo , "") <> "" or ifnull(SLL.binlocation,"") <> "" or ifnull(SLL.serialnumber, "") <> "" , SLL.Allocationinstockqty     , instockQty)       as InstockQty,' +NL+
                  ' if (ifnull(SLL.BatchNo , "") <> "" or ifnull(SLL.binlocation,"") <> "" or ifnull(SLL.serialnumber, "") <> "" , SLL.AllocationFinalUOMQty    , FinalUOMQty)      as FinalUOMQty ,' +NL+
                  ' if (ifnull(SLL.BatchNo , "") <> "" or ifnull(SLL.binlocation,"") <> "" or ifnull(SLL.serialnumber, "") <> "" , SLL.AllocationAdjustUOMQty   , AdjustUOMQty)     as AdjustUOMQty ,' +NL+
                  ' if (ifnull(SLL.BatchNo , "") <> "" or ifnull(SLL.binlocation,"") <> "" or ifnull(SLL.serialnumber, "") <> "" , SLL.AllocationAvailableUOMQty, AvailableUOMQty)  as AvailableUOMQty ,' +NL+
                  ' if (ifnull(SLL.BatchNo , "") <> "" or ifnull(SLL.binlocation,"") <> "" or ifnull(SLL.serialnumber, "") <> "" , SLL.AllocationinstockUOMQty  , instockUOMQty)    as InstockUOMQty,' +NL+
                  ' SLL.Cost, ' +
                  ' P.AvgCost  , ' +
                  ' SLL.UOM, ' +
                  ' SLL.UOMMultiplier, ' +
                  ' SLL.UOMID, ' +
                  ' SLL.BatchNo , ' +
                  ' SLL.expirydate, ' +
                  ' SLL.binlocation, ' +
                  ' SLL.binnumber, ' +
                  ' SLL.serialnumber , ' +
                  ' if(ifnull(SL.StockAdjustEntryID,0)=0, 0 , 1), '+
                  ' SL.Employee as Employeename, SLL.Notes, P.ProductPrintName , P.PARTSDESCRIPTION' +
                  ' from tblParts P ' +
                  ' left  join (tblStockAdjustEntrylines as SLL ' +
                              ' inner join tblStockAdjustEntry as SL on SL.StockAdjustEntryID = SLL.StockAdjustEntryID ' +
                              ' and ifnull(SLL.Deleted,"F") <> "T" ' +
                              ' and ifnull(SL.Deleted,"F") <> "T" ' +
                              ' and ifnull(SL.Processed,"F") <> "T" ' +
                              ' and SL.Adjustmentdate  between ' + quotedstr(formatdatetime(mysqldatetimeformat , Filterdatefrom))+ ' and  ' + quotedstr(formatdatetime(mysqldatetimeformat , FilterdateTo))+ ' ) ' +
                  ' on SLL.ProductID = P.PartsID ' +
                  ' where p.parttype ="INV" '+
                  iif(SelectedClassid<> 0 , ' and SLL.ClassID = ' + inttostr(SelectedClassid) , '') +
                  ' and ( ifnull(SLL.BatchNo , "") <> "" or ifnull(SLL.binlocation,"") <> "" or ifnull(SLL.serialnumber, "") <> "" ) '+
                  iif(IsLimit0selection,' Limit 0 ' ,'')+
                  ' ;');

   SQL.Add('/*2-1-1*/update  ' + fstablename +' Set AvailableQty    = 0 where ifnull(AvailableQty    ,0) < 0 and ifnull(Serialnumber,"")<> "" ;');
   SQL.Add('/*2-1-2*/update  ' + fstablename +' Set AvailableUOMQty = 0 where ifnull(AvailableUOMQty ,0) < 0 and ifnull(Serialnumber,"")<> "" ;');
   SQL.Add('/*2-1-3*/update  ' + fstablename +' Set InstockUOMQty   = 0 where ifnull(InstockUOMQty   ,0) < 0 and ifnull(Serialnumber,"")<> "" ;');
   SQL.Add('/*2-1-4*/update  ' + fstablename +' Set InstockQty      = 0 where ifnull(InstockQty      ,0) < 0 and ifnull(Serialnumber,"")<> "" ;');

    {count of Adjustments}
    SQL.Add('/*3*/Drop table if exists ' + fstablename +'1;');
    SQL.Add('/*4*/Create table ' + fstablename +'1 Select PartsId, ClassId , UOMID, batchno, ExpiryDate, binlocation , binnumber , Serialnumber  ,  '+
                                                    ' count(distinct SAID) as counter  '+
                                                    ' from ' + fstablename +' where ifnull(SAID,0)<> 0   '+
                                                    ' group by PartsId, ClassId , UOMID, batchno, ExpiryDate, binlocation , binnumber , Serialnumber  ;');
    SQL.Add('/*5*/ALTER TABLE ' + fstablename +'1	ADD INDEX `mixidx` (`PartsId`, `ClassID`, `UOMId`, `BatchNo`, `ExpiryDate`, `Binlocation`, `Binnumber`, `Serialnumber`);');
    SQL.Add('/*6*/update ' + fstablename +' T1 inner join ' + fstablename +'1 T2 on '+
                                                    ' T1.PartsId      = T2.PartsId      and '+
                                                    ' T1.ClassId      = T2.ClassId      and  '+
                                                    ' T1.UOMID        = T2.UOMID        and  '+
                                                    ' ifnull(T1.batchno     ,"")= ifnull(T2.batchno       ,"") and  '+
                                                    ' ifnull(T1.ExpiryDate  ,0) = ifnull(T2.ExpiryDate    ,0 ) and  '+
                                                    ' ifnull(T1.binlocation ,"")= ifnull(T2.binlocation   ,"") and '+
                                                    ' ifnull(T1.binnumber   ,"")= ifnull(T2.binnumber     ,"") and  '+
                                                    ' ifnull(T1.Serialnumber,"")= ifnull(T2.Serialnumber  ,"") '+
                                                    ' Set T1.Counter = T2.Counter;');

    {Batch total adjustemnt}
    SQL.Add('/*7*/Drop table if exists ' + fstablename +'1;');
    SQL.Add('/*8*/Create table ' + fstablename +'1 Select PartsId, ClassId , UOMID, batchno, ExpiryDate,  '+
                                                    ' Sum(InstockUOMQty) as InstockUOMQty , Sum(FinalUOMQty) as FinalUOMQty '+
                                                    ' from ' + fstablename +' where ifnull(SAID,0)<> 0 and ifnull(batchno  , "")<> ""  '+
                                                    ' group by PartsId, ClassId , UOMID, batchno, ExpiryDate;');
    SQL.Add('/*9*/ALTER TABLE ' + fstablename +'1	ADD INDEX `mixidx` (`PartsId`, `ClassID`, `UOMId`, `BatchNo`, `ExpiryDate`);');
    SQL.Add('/*10*/update ' + fstablename +' T1 inner join ' + fstablename +'1 T2 on '+
                                                    ' T1.PartsId      = T2.PartsId      and '+
                                                    ' T1.ClassId      = T2.ClassId      and  '+
                                                    ' T1.UOMID        = T2.UOMID        and  '+
                                                    ' ifnull(T1.batchno     ,"")= ifnull(T2.batchno       ,"") and  '+
                                                    ' ifnull(T1.ExpiryDate  ,0) = ifnull(T2.ExpiryDate    ,0 ) '+
                                                    ' Set T1.BAtchInstockUOMQty = T2.InstockUOMQty , T1.BatchFinalUOMQty = T2.FinalUOMQty ' +
                                                    ' where ifnull(T1.batchno , "")<> "";');

    {Bin total adjustemnt}
    SQL.Add('/*11*/Drop table if exists ' + fstablename +'1;');
    SQL.Add('/*12*/Create table ' + fstablename +'1 Select PartsId, ClassId , UOMID, batchno, ExpiryDate, binlocation , binnumber ,  '+
                                                    ' Sum(InstockUOMQty) as InstockUOMQty  , Sum(FinalUOMQty) as FinalUOMQty '+
                                                    ' from ' + fstablename +' where ifnull(SAID,0)<> 0  and ifnull(binlocation  , "")<> ""  '+
                                                    ' group by PartsId, ClassId , UOMID, batchno, ExpiryDate, binlocation , binnumber ;');
    SQL.Add('/*13*/ALTER TABLE ' + fstablename +'1	ADD INDEX `mixidx` (`PartsId`, `ClassID`, `UOMId`, `BatchNo`, `ExpiryDate`, binlocation , binnumber );');
    SQL.Add('/*14*/update ' + fstablename +' T1 inner join ' + fstablename +'1 T2 on '+
                                                    ' T1.PartsId      = T2.PartsId      and '+
                                                    ' T1.ClassId      = T2.ClassId      and  '+
                                                    ' T1.UOMID        = T2.UOMID        and  '+
                                                    ' ifnull(T1.batchno     ,"")= ifnull(T2.batchno       ,"") and  '+
                                                    ' ifnull(T1.ExpiryDate  ,0) = ifnull(T2.ExpiryDate    ,0 ) and  '+
                                                    ' ifnull(T1.binlocation ,"")= ifnull(T2.binlocation   ,"") and '+
                                                    ' ifnull(T1.binnumber   ,"")= ifnull(T2.binnumber     ,"")  '+
                                                    ' Set T1.BinInstockUOMQty = T2.InstockUOMQty, T1.BinFinalUOMQty = T2.FinalUOMQty ' +
                                                    ' where ifnull(T1.binlocation , "")<> "";');

    {SN total adjustemnt}
    SQL.Add('/*15*/Drop table if exists ' + fstablename +'1;');
    SQL.Add('/*16*/Create table ' + fstablename +'1 Select /*SAID , */PartsId, ClassId , UOMID, batchno, ExpiryDate, binlocation , binnumber ,Serialnumber,  '+
                                                    ' Sum(InstockUOMQty) as InstockUOMQty , Sum(FinalUOMQty) as FinalUOMQty  '+
                                                    ' from ' + fstablename +' where ifnull(SAID,0)<> 0   and ifnull(Serialnumber  , "")<> ""  '+
                                                    ' group by /*SAID ,*/ PartsId, ClassId , UOMID, batchno, ExpiryDate, binlocation , binnumber ,Serialnumber;');
    SQL.Add('/*17*/ALTER TABLE ' + fstablename +'1	ADD INDEX `mixidx` (/*SAID,*/`PartsId`, `ClassID`, `UOMId`, `BatchNo`, `ExpiryDate`, binlocation , binnumber , Serialnumber);');
    SQL.Add('/*18*/update ' + fstablename +' T1 inner join ' + fstablename +'1 T2 on '+
                                                    ' /*T1.SAID         = T2.SAID      and*/ '+
                                                    ' T1.PartsId      = T2.PartsId      and '+
                                                    ' T1.ClassId      = T2.ClassId      and  '+
                                                    ' T1.UOMID        = T2.UOMID        and  '+
                                                    ' ifnull(T1.batchno     ,"")= ifnull(T2.batchno       ,"") and  '+
                                                    ' ifnull(T1.ExpiryDate  ,0) = ifnull(T2.ExpiryDate    ,0 ) and  '+
                                                    ' ifnull(T1.binlocation ,"")= ifnull(T2.binlocation   ,"") and '+
                                                    ' ifnull(T1.binnumber   ,"")= ifnull(T2.binnumber     ,"") and  '+
                                                    ' ifnull(T1.Serialnumber,"")= ifnull(T2.Serialnumber  ,"") '+
                                                    ' Set T1.SNInstockUOMQty = T2.InstockUOMQty, T1.SNFinalUOMQty = T2.FinalUOMQty ' +
                                                    ' where ifnull(T1.Serialnumber , "")<> "";');

   {all products with no pending stock adjustment - ifnull(T.SAID , 0)=0 }
   //s:= StockQtyDetailswithSno(False, 0, 0, Filterdateto, False, False);
   s:= StockQty(False, 0,SelectedClassid,tDetailswithSno , filterdateto , True , True );
(*   s:= replacestr(s  , '`tblParts` as P' , fstablename +' T inner join `tblParts` as P on T.PartsId = P.partsId');
   s:= replacestr(s , 'inner join `tblPQA` as PQA on PQA.ProductId = P.PartsID' , 'inner join `tblPQA` as PQA on PQA.ProductId = P.PartsID and PQA.DepartmentId = T.classId and PQA.uomID = T.uomid');
   s:= replacestr(s , 'PQA.TransDate <' ,' ifnull(T.SAID , 0)=0 and PQA.TransDate <');
   s:= replacestr(s , 'and PQA.DepartmentId = T.classId and PQA.uomID = T.uomid ' , '');
   s:= replacestr(s , 'left join `tblPqaDetails` PQABatch  on PQABatch.PQAId 	= PQA.PQAID ' ,'left join `tblPqaDetails` PQABatch  on PQABatch.PQAId 	= PQA.PQAID  and PQABatch.Value = ifnull(T.BatchNo , "") and ifnull(PQABatch.ExpiryDate ,0)= ifnull(T.ExpiryDate,0)');
   s:= replacestr(s , 'Left join `tblProductBin` PBin     on PBin.binId 	= PQABins.BinID' , 'Left join `tblProductBin` PBin     on PBin.binId 	= PQABins.BinID and PBin.binlocation = ifnull(T.binlocation, "") and PBin.Binnumber = ifnull(T.Binnumber , "")');
   s:= replacestr(s , 'left join `tblPqaDetails` PQASN    on (PQASN.PQAId 	= PQA.PQAID ' , 'left join `tblPqaDetails` PQASN    on (PQASN.PQAId 	= PQA.PQAID  and PQASN.value = ifnull(T.Serialnumber, "")');*)
   s:= replacestr(s  , '"" as ExpiryDate' ,'Null as ExpiryDate');
   if IsLimit0selection then s := s+ ' Limit 0 ';

   SQL.Add('/*19*/Drop table if exists ' + fstablename +'2 ;');
   SQL.Add('Drop table if exists ' + fstablename +'2;');
SQL.Add('CREATE TABLE ' + fstablename +'2 ('+
          'ID INT(11) NOT NULL AUTO_INCREMENT, '+
          '  PartsId          int(11) NOT NULL DEFAULT 0,'+
          '  DepartmentID     int(11) DEFAULT NULL,'+
          '  UOMID            int(11) DEFAULT NULL,'+
          '  UOM              varchar(255) NOT NULL DEFAULT "",'+
          '  UOMMultiplier    double NOT NULL DEFAULT 0,'+
          '  gLevel           int(11) NOT NULL DEFAULT 0  ,'+
          '  ProductName      varchar(255) DEFAULT NULL,'+
          '  ProductColumn1   varchar(255) DEFAULT NULL,'+
          '  ProductColumn2   varchar(255) DEFAULT NULL,'+
          '  ProductColumn3   varchar(255) DEFAULT NULL,'+
          '  PartsDescription varchar(255) DEFAULT NULL,'+
          '  Classname        varchar(255) DEFAULT NULL,'+
          '  Batchnumber      varchar(100) DEFAULT NULL,'+
          '  TruckLoadNo      varchar(10) DEFAULT NULL,'+
          '  ExpiryDate       varchar(50), /*Datetime DEFAULT NULL,*/'+
          '  BatchExpiryDate  datetime DEFAULT NULL,'+
          '  Binlocation      varchar(100) DEFAULT NULL,'+
          '  Binnumber        varchar(100) DEFAULT NULL,'+
          '  Serialnumber     varchar(255) DEFAULT NULL,'+
          '  UOMQty           double DEFAULT NULL,'+
          '  Qty              double DEFAULT NULL,'+
          '  CUSTFLD1         varchar(255) NOT NULL DEFAULT "",'+
          '  InstockUOMQty    double DEFAULT NULL,'+
          '  InstockQty       double DEFAULT NULL,'+
          '  ActStockwithManUOMQty  double DEFAULT NULL,'+
          '  ActStockwithManQty     double DEFAULT NULL,'+
          '  Cost                   double NOT NULL DEFAULT 0,'+
          '  Value                  double DEFAULT NULL, '+
          ' PRIMARY KEY (ID) '+
          ' ) ENGINE=InnoDB DEFAULT CHARSET=utf8;');

   SQL.Add('/*20-1*/insert into  ' + fstablename +'2 (PartsId,DepartmentID,UOMID,UOM,UOMMultiplier,gLevel,ProductName,ProductColumn1,ProductColumn2,ProductColumn3, '+
          ' PartsDescription,Classname,Batchnumber,TruckLoadNo,ExpiryDate,BatchExpiryDate,Binlocation,Binnumber,Serialnumber, '+
          ' UOMQty,Qty,CUSTFLD1,InstockUOMQty,InstockQty,ActStockwithManUOMQty,ActStockwithManQty,Cost,Value) '+ s +';');

   SQL.Add('/*20-1-2*/update  ' + fstablename +'2 Set UOMQty               = 0 where ifnull(UOMQty               ,0) < 0 and ifnull(Serialnumber,"")<> "" ;');
   SQL.Add('/*20-1-3*/update  ' + fstablename +'2 Set Qty                  = 0 where ifnull(Qty                  ,0) < 0 and ifnull(Serialnumber,"")<> "" ;');
   SQL.Add('/*20-1-4*/update  ' + fstablename +'2 Set InstockUOMQty        = 0 where ifnull(InstockUOMQty        ,0) < 0 and ifnull(Serialnumber,"")<> "" ;');
   SQL.Add('/*20-1-5*/update  ' + fstablename +'2 Set InstockQty           = 0 where ifnull(InstockQty           ,0) < 0 and ifnull(Serialnumber,"")<> "" ;');
   SQL.Add('/*20-1-6*/update  ' + fstablename +'2 Set ActStockwithManUOMQty= 0 where ifnull(ActStockwithManUOMQty,0) < 0 and ifnull(Serialnumber,"")<> "" ;');
   SQL.Add('/*20-1-7*/update  ' + fstablename +'2 Set ActStockwithManQty   = 0 where ifnull(ActStockwithManQty   ,0) < 0 and ifnull(Serialnumber,"")<> "" ;');

   SQL.Add('/*20-11*/update ' + fstablename +'2  Set ActStockwithManQty =0 , ActStockwithManUOMQty = 0   where ifnull(Serialnumber,"")<> "" and ifnull(ActStockwithManUOMQty,0)<0;');
   SQL.Add('/*20-12*/delete from ' + fstablename +'2 where (ifnull(Batchnumber,"")<> "" or ifnull(binlocation,"") <> "" or ifnull(Serialnumber,"") <> "") and ifnull(ActStockwithManUOMQty,0)=0;');

    SQL.Add('/*20-2*/Drop table if exists ' + fstablename +'1 ;');
    SQL.Add('/*20-3*/Create table ' + fstablename +'1 Select T2.* from ' + fstablename +'2 T2 left join ' + fstablename +' t on T2.PartsId = T.partsId ' +
                                                                                                                        ' and T2.DepartmentId = T.classid' +
                                                                                                                        ' and T2.uomid = T.uomid' +
                                                                                                                        ' and ifnull(T2.Batchnumber,"") = ifnull(T.Batchno,"") and ifnull(T.expirydate,0) = ifnull(T2.expirydate,0)' +
                                                                                                                        ' and ifnull(T2.binlocation,"") = ifnull(T.binlocation,"") and ifnull(T.binnumber,"") = ifnull(T2.binnumber,"")' +
                                                                                                                        ' and ifnull(T2.Serialnumber,"") = ifnull(T.Serialnumber,"")' +
                                                                                                                        ' where ifnull(T.id,0)=0;');
    //SQL.Add('/*20-4*/update ' + fstablename +'1  Set ActStockwithManQty =0 , ActStockwithManUOMQty = 0   where ifnull(Serialnumber,"")<> "" and ifnull(ActStockwithManUOMQty,0)<0;');
    SQL.Add('/*20-5*/update ' + fstablename +'1  Set Qty =0 , UOMQty = 0   where ifnull(Serialnumber,"")<> "" and ifnull(UOMQty,0)<0;');
    SQL.Add('update ' + fsTablename +'1  set expirydate =  null where ifnull(expirydate,"") ="";');
    SQL.Add('/*21*/insert ignore into '+fstablename+' '+
            ' ( PartsId , Partname, ClassID , ClassName, '+
            '   FinalQty , AvailableQty, InstockQty , FinalUOMQty , AvailableUOMQty , InstockUOMQty ,  '+
            '   BatchInstockUOMQty , BinInstockUOMQty , SNInstockUOMQty , BatchFinalUOMQty , BinFinalUOMQty , SNFinalUOMQty ,  '+
            '   AvgCost , UOM , UOMMultiplier , UOMId , BatchNo , ExpiryDate , Binlocation , Binnumber , Serialnumber , PrDescription , PrintName ) '+NL+
            ' select  T.PartsId , T.Productname, T.DepartmentId , T.ClassName,  '+
            '   sum(T.ActStockwithManQty), sum(T.Qty), sum(T.ActStockwithManQty) , sum(T.ActStockwithManUOMQty) , sum(T.UOMQty) , sum(T.ActStockwithManUOMQty) , 0 , 0, 0, 0, 0, 0,  '+
            '   P.AvgCost , T.UOM , T.UOMMultiplier , T.UOMId , "" , 0, "", "", "", P.PARTSDESCRIPTION , P.productprintname   '+
            '   from '+fstablename+'1 T inner join tblparts P on T.partsId= P.partsId   '+
            ' where  ifnull(T.BatchNumber , "")= ""  and ifnull(T.Binlocation ,"") ="" and   ifnull(T.Serialnumber ,"") ="" ' +
            '   group by T.partsId, T.departmentId , T.uomId  '+NL+
            '   union all '+
            ' select  T.PartsId , T.Productname, T.DepartmentId , T.ClassName,  '+
            '   0 , 0, 0, 0, 0, 0, sum(T.ActStockwithManUOMQty), 0,0 , /*sum(T.ActStockwithManUOMQty)*/0, 0,0,  '+
            '   P.AvgCost , T.UOM , T.UOMMultiplier , T.UOMId , T.BatchNumber , T.ExpiryDate , "", "" , "", P.PARTSDESCRIPTION , P.productprintname   '+
            '   from '+fstablename+'1 T inner join tblparts P on T.partsId= P.partsId   '+
            '   where ifnull(T.BatchNumber , "")<> ""  and ifnull(T.Binlocation ,"") ="" and   ifnull(T.Serialnumber ,"") =""'+
            '   group by T.partsId, T.departmentId , T.uomId, T.BatchNumber , T.ExpiryDate   '+NL+
            '   union all '+
            ' select  T.PartsId , T.Productname, T.DepartmentId , T.ClassName,  '+
            '   0 , 0, 0, 0, 0, 0, 0, sum(T.ActStockwithManUOMQty),0 , 0, /*sum(T.ActStockwithManUOMQty)*/0,0,   '+
            '   P.AvgCost , T.UOM , T.UOMMultiplier , T.UOMId , T.BatchNumber , T.ExpiryDate , T.Binlocation , T.Binnumber , "" , P.PARTSDESCRIPTION , P.productprintname   '+
            '   from '+fstablename+'1 T inner join tblparts P on T.partsId= P.partsId   '+
            '   where ifnull(T.Binlocation ,"")<> ""  and  ifnull(T.Serialnumber ,"") =""'+
            '   group by T.partsId, T.departmentId , T.uomId , T.BatchNumber , T.ExpiryDate , T.Binlocation , T.Binnumber  '+NL+
            '   union all '+
            ' select  T.PartsId , T.Productname, T.DepartmentId , T.ClassName,   '+
            '   0 , 0, 0, 0, 0, 0, 0, 0, sum(T.ActStockwithManUOMQty), 0, 0, /*sum(T.ActStockwithManUOMQty)*/0,  '+
            '   P.AvgCost , T.UOM , T.UOMMultiplier , T.UOMId , T.BatchNumber , T.ExpiryDate , T.Binlocation , T.Binnumber , T.Serialnumber , P.PARTSDESCRIPTION , P.productprintname   '+
            '   from '+fstablename+'1 T inner join tblparts P on T.partsId= P.partsId   '+
            '   where ifnull(T.Serialnumber ,"")<> ""  '+
            '   group by T.partsId, T.departmentId , T.uomId, T.BatchNumber , T.ExpiryDate , T.Binlocation , T.Binnumber , T.Serialnumber; ');



(*    SQL.Add('/*21*/update ' + fstablename +' T1 inner join ' + fstablename +'1 as T2 on T1.PartsId = T2.partsId and T1.ClassId = T2.departmentId  and T1.uomid = T2.uomId ' +
                                                                      'Set T1.AvailableQty = T2.Qty , T1.InstockQty = T2.InstockQty , ' +
                                                                      'T1.AvailableuomQty = T2.uomQty , T1.InstockuomQty = T2.InstockUOMQty;');*)
    SQL.Add('update  ' + fstablename +' set Expirydate = Null where expirydate = "0000-00-00 00:00:00";');  // null expiry is changed to 000 in one of the query.. temp solution
    SQL.Add('/*22*/Drop table if exists ' + fstablename +'1 ;');

    SQL.Add('CREATE TABLE  ' + fstablename +'1  ( ' +
        ' PartsNum double DEFAULT NULL, ' +
        ' ClassNum double DEFAULT NULL, ' +
        ' UOMNum double DEFAULT NULL, ' +
        ' Batchnum double DEFAULT NULL, ' +
        ' binnum double DEFAULT NULL, ' +
        ' snnum double DEFAULT NULL, ' +
        ' Counter int(11) NOT NULL DEFAULT 0 , ' +
        ' ProductID int(11) NOT NULL DEFAULT 0 , ' +
        ' ProductName varchar(255) NOT NULL DEFAULT 0 , ' +
        ' PreferedSupplier varchar(255) DEFAULT NULL, ' +
        ' StockAdjustEntryID int(11) NOT NULL DEFAULT 0 , ' +
        ' Adjusttype varchar(10) NOT NULL DEFAULT 0 , ' +
        ' Adjustmentdate datetime DEFAULT NULL, ' +
        ' Description varchar(255) DEFAULT NULL, ' +
        ' classid int(11) DEFAULT NULL, ' +
        ' ClassName varchar(255) DEFAULT NULL, ' +
        ' FinalUOMQty double NOT NULL DEFAULT 0 , ' +
        ' AdjustUOMQty double NOT NULL DEFAULT 0 , ' +
        ' AvailableUOMQty double NOT NULL DEFAULT 0 , ' +
        ' InstockUOMQty double NOT NULL DEFAULT 0 , ' +
        ' BatchInstockUOMQty double NOT NULL DEFAULT 0 , ' +
        ' BinInstockUOMQty double NOT NULL DEFAULT 0 , ' +
        ' SNInstockUOMQty double NOT NULL DEFAULT 0 , ' +
        ' FinalQty double NOT NULL DEFAULT 0 , ' +
        ' AdjustQty double NOT NULL DEFAULT 0 , ' +
        ' AvailableQty double NOT NULL DEFAULT 0 , ' +
        ' InstockQty double NOT NULL DEFAULT 0 , ' +
        ' UOMMultiplier double DEFAULT 0 , ' +
        ' UOMID int(11) NOT NULL DEFAULT 0 , ' +
        ' Cost double DEFAULT 0 , ' +
        ' AvgCost double DEFAULT 0 , ' +
        ' UOM varchar(279) DEFAULT NULL, ' +
        ' BatchNo varchar(100) NOT NULL DEFAULT "", ' +
        ' ExpiryDate datetime DEFAULT NULL, ' +
        ' Binlocation varchar(30) NOT NULL DEFAULT "", ' +
        ' Binnumber varchar(30) NOT NULL DEFAULT "", ' +
        ' Serialnumber varchar(100) NOT NULL DEFAULT "", ' +
        ' AccountID int(11) NOT NULL DEFAULT 0 , ' +
        ' BAtchFinalUOMQty double NOT NULL DEFAULT 0 , ' +
        ' BinFinalUOMQty double NOT NULL DEFAULT 0 , ' +
        ' SNFinalUOMQty double NOT NULL DEFAULT 0 , ' +
        ' Employeename varchar(255) NOT NULL DEFAULT "", ' +
        ' PrDescription varchar(255) NOT NULL DEFAULT "", ' +
        ' PrintName varchar(255) NOT NULL DEFAULT "", ' +
        ' Notes varchar(255) NOT NULL DEFAULT "" ' +
        ' ) ENGINE=InnoDB DEFAULT CHARSET=utf8;');

    for ctr := 0 to 2 do begin
        SQL.Add('/*23-' + inttostr(ctr+1)+'*/insert ignore into ' + fstablename +'1 ' +
        ' (PartsNum, ClassNum , UOMNum , Batchnum, binnum, snnum , ' +
        ' ProductID, ProductName , PreferedSupplier , StockAdjustEntryID , Adjusttype , Adjustmentdate , Description , classid,ClassName , ' +
        ' FinalUOMQty , AdjustUOMQty , AvailableUOMQty , InstockUOMQty , BatchInstockUOMQty,BinInstockUOMQty ,SNInstockUOMQty , FinalQty , AdjustQty , AvailableQty , InstockQty , ' +
        ' UOMMultiplier, UOMID, Cost , AvgCost , UOM, BatchNo , ExpiryDate , Binlocation , Binnumber , Serialnumber , ' +
        ' Counter ,AccountID, BAtchFinalUOMQty, BinFinalUOMQty ,SNFinalUOMQty , Employeename ,PrDescription ,PrintName ,Notes) ' +
        ' Select PartsNum, ClassNum , UOMNum , Batchnum, binnum, snnum , ' +
        ' ProductID, ProductName , PreferedSupplier , StockAdjustEntryID , Adjusttype , Adjustmentdate , Description , classid,ClassName , ' +
        ' FinalUOMQty , AdjustUOMQty , AvailableUOMQty , InstockUOMQty , BatchInstockUOMQty,BinInstockUOMQty ,SNInstockUOMQty , FinalQty , AdjustQty , AvailableQty , InstockQty , ' +
        ' UOMMultiplier, UOMID, Cost , AvgCost , UOM, BatchNo , ExpiryDate , Binlocation , Binnumber , Serialnumber , ' +
        ' Counter ,AccountID, BAtchFinalUOMQty, BinFinalUOMQty ,SNFinalUOMQty , Employeename ,PrDescription ,PrintName ,Notes ' + NL+
        ' From (Select ' +
        '   @PartsNum :=if(                                                                                  @PartsId <> PartsId,                @PartsNum:= 1 ,  @PartsNum+1) PartsNum ,'+
        '   @ClassNum :=if(@PartsNum =1                                                                   or @ClassId <> ClassId,                                 @ClassNum:= 1 ,  @ClassNum+1) ClassNum ,'+
        '   @UOMNum   :=if(@PartsNum =1 or @ClassNum =1                                                   OR @UOMId   <> UOMId  ,                                 @UOMNum  := 1 ,  @UOMNum  +1) UOMNum   ,'+
        '   @BatchNum :=if(@BatchId <> concat(ifnull(PartsId,0) , "-" ,' + 'ifnull(ClassId,0) , "-" ,' + ' ifnull(uomID,0) , "-",   ifnull(batchno,"") , "-" ,' + ' ifnull(ExpiryDate,0)),' + '@BatchNum:= 1 ,  @BatchNum+1) as BatchNum ,'+
        '   @BinNum   :=if(@BinId   <> concat(ifnull(PartsId,0) , "-" ,' + 'ifnull(ClassId,0) , "-" ,' + ' ifnull(uomID,0) , "-",   ifnull(batchno,"") , "-" ,' + ' ifnull(ExpiryDate,0) , "-" ,' + ' ifnull(Binlocation, "") , "-" ,' + ' ifnull(binnumber,"")),  ' + '@BinNum  := 1 ,  @BinNum  +1) as BinNum   ,'+
        '   @SNNum    :=if(@SNId    <> concat(ifnull(PartsId,0) , "-" ,' + 'ifnull(ClassId,0) , "-" ,' + ' ifnull(uomID,0) , "-",   ifnull(batchno,"") , "-" ,' + ' ifnull(ExpiryDate,0) , "-" ,' + ' ifnull(Binlocation, "") , "-" ,' + ' ifnull(binnumber,""), "-" ,' + ' ifnull(Serialnumber, "")) , ' + ' @SNNum   := 1 ,  @SNNum   +1) as SNNum    ,'+NL+
        '   @PartsId := PartsId,'+
        '   @ClassId := ClassId,'+
        '   @UOMId   := UOMId  ,'+
        '   @BatchId :=  concat(ifnull(PartsId,0) , "-" ,' + 'ifnull(ClassId,0) , "-" ,' + ' ifnull(uomID,0) , "-",   ifnull(batchno,"") , "-" ,' + ' ifnull(ExpiryDate,0)),'+
        '   @BinId   :=  concat(ifnull(PartsId,0) , "-" ,' + 'ifnull(ClassId,0) , "-" ,' + ' ifnull(uomID,0) , "-",   ifnull(batchno,"") , "-" ,' + ' ifnull(ExpiryDate,0) , "-" ,' + ' ifnull(Binlocation, "") , "-" ,' + ' ifnull(binnumber,"")),'+
        '   @SNId   :=  concat(ifnull(PartsId,0) , "-" ,' + 'ifnull(ClassId,0) , "-" ,' + ' ifnull(uomID,0) , "-",   ifnull(batchno,"") , "-" ,' + ' ifnull(ExpiryDate,0) , "-" ,' + ' ifnull(Binlocation, "") , "-" ,' + ' ifnull(binnumber,""), "-" ,' + ' ifnull(Serialnumber, "")),'+NL+
        ' PartsId            as ProductID, ' +
        ' Partname           as ProductName , ' +
        ' PreferedSupplier   as PreferedSupplier , ' +
        ' SAID               as StockAdjustEntryID , ' +
        ' Adjusttype         as Adjusttype , ' +
        ' Adjustmentdate     as Adjustmentdate , ' +
        ' Description        as Description , ' +
        ' classid            as classid,' +
        ' ClassName          as ClassName , ' +
        ' FinalUOMQty        as FinalUOMQty , ' +
        ' AdjustUOMQty       as AdjustUOMQty , ' +
        ' AvailableUOMQty    as AvailableUOMQty , ' +
        ' InstockUOMQty      as InstockUOMQty , ' +
        ' BatchInstockUOMQty as BatchInstockUOMQty,' +
        ' BinInstockUOMQty   as BinInstockUOMQty , ' +
        ' SNInstockUOMQty    as SNInstockUOMQty , ' +
        ' FinalQty           as FinalQty , ' +
        ' AdjustQty          as AdjustQty , ' +
        ' AvailableQty       as AvailableQty , ' +
        ' InstockQty         as InstockQty , ' +
        ' UOMMultiplier      as UOMMultiplier, ' +
        ' UOMID              as UOMID, ' +
        ' AdjCost            as Cost , ' +
        ' AvgCost            as AvgCost , ' +
        ' concat(UOM , "(" , UOMMultiplier  , ")") as UOM, ' +
        ' BatchNo            as BatchNo , ' +
        ' ExpiryDate         as ExpiryDate , ' +
        ' Binlocation        as Binlocation , ' +
        ' Binnumber          as Binnumber , ' +
        ' Serialnumber       as Serialnumber , ' +
        ' Counter            as Counter ,' +
        ' AccountID          as AccountID, ' +
        ' BAtchFinalUOMQty   as BAtchFinalUOMQty, ' +
        ' BinFinalUOMQty     as BinFinalUOMQty , '+
        ' SNFinalUOMQty      as SNFinalUOMQty , '+
        ' Employeename       as Employeename ,' +
        ' PrDescription      as PrDescription ,' +
        ' PrintName          as PrintName ,' +
        ' Notes              as Notes ' +
        ' From ' +NL+
        '  (SELECT @PartsNum :=0) pr  ,(SELECT @PartsId  :=0 ) pid,' +NL+
        '  (SELECT @ClassNum :=0) cr  ,(SELECT @ClassId  :=0 ) cid,' +NL+
        '  (SELECT @UOMNum   :=0) ur  ,(SELECT @UOMId    :=0 ) uid,' +NL+
        '  (SELECT @BatchNum :=0) bar ,(SELECT @BatchId  :="") baid,' +NL+
        '  (SELECT @BinNum   :=0) bir ,(SELECT @BinId    :="") biid,' +NL+
        '  (SELECT @SNNum    :=0) SNr ,(SELECT @SNId     :="") SNid,' +NL+
        fsTablename  +' where ifnull(PartsId,0)<> 0 and ifnull(classid,0)<> 0 and ifnull(UOMID,0)<>0 '+
         iif(ctr<=1 , ' and counter  = ' +inttostr(ctr) ,' and counter  > 1') +
        ' Order by ifnull(Partname,"") ,'+
                 ' ifnull(ClassName,"") ,'+
                 ' ifnull(UOM,""),  '+
                 ' ifnull(BatchNo,"") , '+
                 ' ifnull(ExpiryDate,0) ,'+
                 ' ifnull(Binlocation,"") , '+
                 ' ifnull(Binnumber,"") , '+
                 ' ifnull(Serialnumber,"") ,  '+
                 ' ifnull(Adjustmentdate,0) ) Details ;' );
    end;


    SQL.Add('/*24*/Truncate ' + fstablename +' ;');
    SQL.Add('/*25*/insert ignore into ' + fstablename  +  NL+
            ' ( PartsNum ,ClassNum ,UOMNum,BatchNum,BinNum,SNNum,  PartsId,Partname,PreferedSupplier,SAID,Adjusttype,Adjustmentdate,Description,classid,ClassName, ' +
                'FinalUOMQty,AdjustUOMQty,AvailableUOMQty,InstockUOMQty,' +
                'BatchInstockUOMQty,BinInstockUOMQty,SNInstockUOMQty,' +
                'BatchFinalUOMQty,BinFinalUOMQty,SNFinalUOMQty,' +
                'FinalQty ,AdjustQty,AvailableQty,InstockQty,UOMMultiplier,UOMID,AdjCost,AvgCost,UOM,BatchNo,ExpiryDate,Binlocation,Binnumber,Serialnumber,Counter,AccountID,' +
                'Employeename,PrDescription,PrintName,Notes )' +     NL+
    ' Select PartsNum ,ClassNum ,UOMNum,BatchNum,BinNum,SNNum, ' +
    ' ProductID, ' +
    ' ProductName , ' +
    ' PreferedSupplier , ' +
    ' StockAdjustEntryID , ' +
    ' Adjusttype , ' +
    ' Adjustmentdate , ' +
    ' Description , ' +
    ' classid,' +
    ' ClassName , ' +
    ' FinalUOMQty , ' +
    ' AdjustUOMQty , ' +
    ' AvailableUOMQty , ' +
    ' InstockUOMQty , ' +
    ' BatchInstockUOMQty,' +
    ' BinInstockUOMQty , ' +
    ' SNInstockUOMQty , ' +
    ' BatchFinalUOMQty,' +
    ' BinFinalUOMQty , ' +
    ' SNFinalUOMQty , ' +
    ' FinalQty , ' +
    ' AdjustQty , ' +
    ' AvailableQty , ' +
    ' InstockQty , ' +
    ' UOMMultiplier, ' +
    ' UOMID, ' +
    ' Cost , ' +
    ' AvgCost , ' +
    ' UOM, ' +
    ' BatchNo , ' +
    ' ExpiryDate , ' +
    ' Binlocation , ' +
    ' Binnumber , ' +
    ' Serialnumber , ' +
    ' Counter ,' +
    ' AccountID, ' +
    ' Employeename ,' +
    ' PrDescription ,' +
    ' PrintName ,' +
    ' Notes ' +NL+
    ' From ' + fsTablename  +'1 ;');
    SQL.Add('/*26*/Drop table if exists ' + fstablename +'1 ;');
    SQL.Add('/*27*/update  ' + fstablename +' Set SNInstockUOMQty = 0 where ifnull(SNInstockUOMQty,0) = -1 ;');
    showProgressbar(WAITMSG, SQL.count);
    try
      logtext(SQL.Text);
      Execute;
    finally
      HideProgressbar;
    end;
  end;
  inherited;

end;

procedure TStockAdjustEntryDetailVariaceListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainAdjusttype.FieldName);
  RemoveFieldfromGrid(qryMainaccountname.FieldName);
  RemoveFieldfromGrid(qryMainGlobalref.FieldName);
  RemoveFieldfromGrid(qryMainAccountID.FieldName);
  RemoveFieldfromGrid(qryMainProcessed.FieldName);
  RemoveFieldfromGrid(qryMaindeleted.FieldName);
  if not devmode then begin
    RemoveFieldfromGrid(qryMainPartsNum.FieldName);
    RemoveFieldfromGrid(qryMainClassNum.FieldName);
    RemoveFieldfromGrid(qryMainUOMNum.FieldName);
    RemoveFieldfromGrid(qryMainBatchNum.FieldName);
    RemoveFieldfromGrid(qryMainBinNum.FieldName);
    RemoveFieldfromGrid(qryMainSNNum.FieldName);
  end;
end;

procedure TStockAdjustEntryDetailVariaceListGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['optAdj.ItemIndex'].asInteger := optAdj.ItemIndex + 1;
end;

initialization
  RegisterClassOnce(TStockAdjustEntryDetailVariaceListGUI);

end.
