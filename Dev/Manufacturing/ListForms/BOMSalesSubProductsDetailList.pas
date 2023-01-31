unit BOMSalesSubProductsDetailList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BOMSalesSubProductsList, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, DNMPanel , BaseListDetails, GIFImg;


type


  TBOMSalesSubProductsDetailListGUI = class(TBOMSalesSubProductsListGUI)
    qryMaindueDate: TDateTimeField;
    qryMainShipdate: TDateTimeField;
    qryMainLevel: TIntegerField;
    qryMainMaxLevel: TIntegerField;
    qryMainEmployeeName: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure qryMainBeforeClose(DataSet: TDataSet);
  private
    fsTablename :String;
    procedure WriteGuiPrefDynfields;
    procedure ReadGuiPrefDynfields;
  Protected
    procedure PopulateData;Override;
    Function extraFields:String;Override;
    Function ExtraTables:String;Override;
    procedure SetGridColumns; Override;
    Function ExpressDetailListName:String;Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
  public
    Procedure RefreshQuery; Override;
  end;


implementation

uses tcDataUtils, CommonDbLib, LogLib, CommonLib, tcConst, MySQLConst,
  AppEnvironment, ManufactureLib;

{$R *.dfm}

{ TBOMSalesSubProductsDetailListGUI }

procedure TBOMSalesSubProductsDetailListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fsTablename := Tablename +'1';
  //DisableSortoncolumtitleclick:= True;
end;

procedure TBOMSalesSubProductsDetailListGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(fsTablename);
  inherited;

end;

procedure TBOMSalesSubProductsDetailListGUI.PopulateData;
var
  //fiBomLevels , level , sublevel:Integer;
  fiBomLevels , level :Integer;
//  s:String;
begin
  if fsTablename = '' then fsTablename := commondblib.GetUserTemporaryTableName('BOMSub')+'1';
  With scriptmain do begin
    SQL.Clear;
    SQL.add(BOMTreeFlat(FilterdateFrom, filterDateto , fsTablename, 'Shipdate', 'S.IsSalesOrder ="T"'));
    SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'alter table '+fsTablename +' add column DueDate DateTime  ;');
    SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'alter table '+fsTablename +' add column ShipDate DateTime ;');
    SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'alter table '+fsTablename +' add column productName varchar(60) DEFAULT NULL;');
    SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'alter table '+fsTablename +' add column Shipped double NOT NULL DEFAULT 0  ;');

    SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'update ' + fsTablename +' T inner join tblsales         S on T.saleId    = S.SaleId Set T.DueDate = S.DueDate, T.shipdate = S.shipdate;');
    SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'update ' + fsTablename +' T inner join tblsaleslines SL on SL.saleLineId = T.SaleLineId Set T.Productname = SL.productname, T.Shipped = SL.UnitofMeasureShipped;');
    SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'alter table '+fsTablename +' Add column MaxLevel int(11)  Default 0;');

      fiBomLevels := BOMTreeLevels;
      for level := 1 to fiBomLevels do begin
        SQL.add('/*'+inttostr(SQL.count+1)  +'*/'+'alter table '+fsTablename +' ' +
                ' add column Caption'       + LvlNo(Level) +' varchar(255) DEFAULT NULL,' +
                ' add column Info'          + LvlNo(Level) +' varchar(255) DEFAULT NULL,' +
                ' add column infowithnoqty' + LvlNo(Level) +' varchar(255) DEFAULT NULL,' +
                ' add column TotalQty'      + LvlNo(Level) +' Double DEFAULT NULL,' +
                ' add column BTotal4SOQty'  + LvlNo(Level) +' Double DEFAULT NULL,' +
                ' add column STotal4SOQty'  + LvlNo(Level) +' Double DEFAULT NULL,' +
                ' add column Total4SOQty'   + LvlNo(Level) +' Double DEFAULT NULL,' +
                ' add column QtyPer'        + LvlNo(Level) +' Double DEFAULT NULL,' +
                ' add column Sequenceup'    + LvlNo(Level) +' int(11) DEFAULT 0 ;' );
        SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'update ' + fsTablename +' T inner join tblproctree PT on T.PTID'+LvlNo(Level)+'= PT.proctreeId Set  '+
                                                                                                                              'T.Caption'       +LvlNo(Level)+' = PT.Caption, '+
                                                                                                                              'T.Info'          +LvlNo(Level)+' = PT.Info, '+
                                                                                                                              'T.infowithnoqty' +LvlNo(Level)+' = PT.Info, '+
                                                                                                                              'T.TotalQty'      +LvlNo(Level)+' = PT.TotalQty, '+
                                                                                                                              //'T.QtyPer'        +LvlNo(Level)+' = PT.QtyPer, '+
                                                                                                                              'T.Sequenceup'    +LvlNo(Level)+' = PT.Sequenceup; ');
        SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'update ' + fsTablename +' T  Set T.infowithnoqty' +LvlNo(Level)+' = trim(replace(T.infowithnoqty' +LvlNo(Level)+' ,T.Caption'       +LvlNo(Level)+', ""));');

        if Sametext(Appenv.companyPrefs.Fe1Name ,Appenv.companyPrefs.FeQtyField) then begin
          SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'update ' + fsTablename +' T  inner join tblproctree PT on PT.ProctreeId = T.PTID'+LvlNo(Level)+' Set T.infowithnoqty' +LvlNo(Level)+' = replace(infowithnoqty' +LvlNo(Level)+' , Concat(' +Quotedstr(Appenv.companyPrefs.FeQtyFieldInfodisplayLabel) +'," ",BuildFormulaQtyValue1) , "" ) where ifnull(PT.Formulaid,0)<> 0 ;'+
                                                  'update ' + fsTablename +' T  inner join tblproctree PT on PT.ProctreeId = T.PTID'+LvlNo(Level)+' Set T.infowithnoqty' +LvlNo(Level)+' = replace(infowithnoqty' +LvlNo(Level)+' , Concat(' +Quotedstr(Appenv.companyPrefs.FeQtyFieldInfodisplayLabel) +'," ",FormulaQtyValue1) , "" ) where ifnull(PT.Formulaid,0)<> 0 ;');
          SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'update ' + fsTablename +' T  inner join tblsaleslines SL on SL.saleLineId = T.saleLineId inner join tblproctree PT on PT.ProctreeId = T.PTID'+LvlNo(Level)+' Set T.BTotal4SOQty' +LvlNo(Level)+' = if(ifnull(PT.BuildFormulaQtyValue1,0)=0 , PT.FormulaQtyValue1 ,PT.BuildFormulaQtyValue1) * SL.QtySold where /*ifnull(PT.Formulaid,0)<> 0 and*/ ifnull(PT.ManufactureQty,0)>0;'+
                                                  'update ' + fsTablename +' T  inner join tblproctree PT on PT.ProctreeId = T.PTID'+LvlNo(Level)+' Set T.QtyPer'       +LvlNo(Level)+' = ifnull(PT.FormulaQtyValue1,0)  where /*ifnull(PT.Formulaid,0)<> 0 and*/ (ifnull(PT.FromStockQty,0)>0 Or ifnull(PT.OnOrderQty,0)>0) ;'+
                                                  'update ' + fsTablename +' T  inner join tblsaleslines SL on SL.saleLineId = T.saleLineId inner join tblproctree PT on PT.ProctreeId = T.PTID'+LvlNo(Level)+' Set T.STotal4SOQty' +LvlNo(Level)+' = ifnull(PT.FormulaQtyValue1,0) * SL.QtySold where /*ifnull(PT.Formulaid,0)<> 0 and*/ (ifnull(PT.FromStockQty,0)>0 Or ifnull(PT.OnOrderQty,0)>0) ;');

        end else if Sametext(Appenv.companyPrefs.Fe2Name ,Appenv.companyPrefs.FeQtyField) then begin
          SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'update ' + fsTablename +' T  inner join tblproctree PT on PT.ProctreeId = T.PTID'+LvlNo(Level)+' Set T.infowithnoqty' +LvlNo(Level)+' = replace(infowithnoqty' +LvlNo(Level)+' , Concat(' +Quotedstr(Appenv.companyPrefs.FeQtyFieldInfodisplayLabel) +'," ",BuildFormulaQtyValue2) , "" ) where ifnull(PT.Formulaid,0)<> 0 ;'+
                                                  'update ' + fsTablename +' T  inner join tblproctree PT on PT.ProctreeId = T.PTID'+LvlNo(Level)+' Set T.infowithnoqty' +LvlNo(Level)+' = replace(infowithnoqty' +LvlNo(Level)+' , Concat(' +Quotedstr(Appenv.companyPrefs.FeQtyFieldInfodisplayLabel) +'," ",FormulaQtyValue2) , "" ) where ifnull(PT.Formulaid,0)<> 0 ;');

          SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'update ' + fsTablename +' T  inner join tblsaleslines SL on SL.saleLineId = T.saleLineId inner join tblproctree PT on PT.ProctreeId = T.PTID'+LvlNo(Level)+' Set T.BTotal4SOQty' +LvlNo(Level)+' = if(ifnull(PT.BuildFormulaQtyValue2,0)=0 , PT.FormulaQtyValue2 ,PT.BuildFormulaQtyValue2) * SL.QtySold where /*ifnull(PT.Formulaid,0)<> 0 and*/ ifnull(PT.ManufactureQty,0)>0;'+
                                                  'update ' + fsTablename +' T  inner join tblproctree PT on PT.ProctreeId = T.PTID'+LvlNo(Level)+' Set T.QtyPer' +LvlNo(Level)+' = ifnull(PT.FormulaQtyValue2,0) where /*ifnull(PT.Formulaid,0)<> 0 and*/ (ifnull(PT.FromStockQty,0)>0 Or ifnull(PT.OnOrderQty,0)>0);'+
                                                  'update ' + fsTablename +' T  inner join tblsaleslines SL on SL.saleLineId = T.saleLineId inner join tblproctree PT on PT.ProctreeId = T.PTID'+LvlNo(Level)+' Set T.STotal4SOQty' +LvlNo(Level)+' = ifnull(PT.FormulaQtyValue2,0) * SL.QtySold where /*ifnull(PT.Formulaid,0)<> 0 and*/ (ifnull(PT.FromStockQty,0)>0 Or ifnull(PT.OnOrderQty,0)>0);');

        end else if Sametext(Appenv.companyPrefs.Fe3Name ,Appenv.companyPrefs.FeQtyField) then begin
          SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'update ' + fsTablename +' T  inner join tblproctree PT on PT.ProctreeId = T.PTID'+LvlNo(Level)+' Set T.infowithnoqty' +LvlNo(Level)+' = replace(infowithnoqty' +LvlNo(Level)+' , Concat(' +Quotedstr(Appenv.companyPrefs.FeQtyFieldInfodisplayLabel) +'," ",BuildFormulaQtyValue3) , "" ) where ifnull(PT.Formulaid,0)<> 0 ;'+
                                                  'update ' + fsTablename +' T  inner join tblproctree PT on PT.ProctreeId = T.PTID'+LvlNo(Level)+' Set T.infowithnoqty' +LvlNo(Level)+' = replace(infowithnoqty' +LvlNo(Level)+' , Concat(' +Quotedstr(Appenv.companyPrefs.FeQtyFieldInfodisplayLabel) +'," ",FormulaQtyValue3) , "" ) where ifnull(PT.Formulaid,0)<> 0 ;');
          SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'update ' + fsTablename +' T  inner join tblsaleslines SL on SL.saleLineId = T.saleLineId inner join tblproctree PT on PT.ProctreeId = T.PTID'+LvlNo(Level)+' Set T.BTotal4SOQty' +LvlNo(Level)+' = if(ifnull(PT.BuildFormulaQtyValue3,0)=0 , PT.FormulaQtyValue3 ,PT.BuildFormulaQtyValue3) * SL.QtySold where /*ifnull(PT.Formulaid,0)<> 0 and*/ ifnull(PT.ManufactureQty,0)>0;'+
                                                  'update ' + fsTablename +' T  inner join tblproctree PT on PT.ProctreeId = T.PTID'+LvlNo(Level)+' Set T.QtyPer' +LvlNo(Level)+' = ifnull(PT.FormulaQtyValue3,0) where /*ifnull(PT.Formulaid,0)<> 0 and*/ (ifnull(PT.FromStockQty,0)>0 Or ifnull(PT.OnOrderQty,0)>0);'+
                                                  'update ' + fsTablename +' T  inner join tblsaleslines SL on SL.saleLineId = T.saleLineId inner join tblproctree PT on PT.ProctreeId = T.PTID'+LvlNo(Level)+' Set T.STotal4SOQty' +LvlNo(Level)+' = ifnull(PT.FormulaQtyValue3,0) * SL.QtySold where /*ifnull(PT.Formulaid,0)<> 0 and*/ (ifnull(PT.FromStockQty,0)>0 Or ifnull(PT.OnOrderQty,0)>0);');

        end else if Sametext(Appenv.companyPrefs.Fe4Name ,Appenv.companyPrefs.FeQtyField) then begin
          SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'update ' + fsTablename +' T  inner join tblproctree PT on PT.ProctreeId = T.PTID'+LvlNo(Level)+' Set T.infowithnoqty' +LvlNo(Level)+' = replace(infowithnoqty' +LvlNo(Level)+' , Concat(' +Quotedstr(Appenv.companyPrefs.FeQtyFieldInfodisplayLabel) +'," ",BuildFormulaQtyValue4) , "" ) where ifnull(PT.Formulaid,0)<> 0 ;'+
                                                  'update ' + fsTablename +' T  inner join tblproctree PT on PT.ProctreeId = T.PTID'+LvlNo(Level)+' Set T.infowithnoqty' +LvlNo(Level)+' = replace(infowithnoqty' +LvlNo(Level)+' , Concat(' +Quotedstr(Appenv.companyPrefs.FeQtyFieldInfodisplayLabel) +'," ",FormulaQtyValue4) , "" ) where ifnull(PT.Formulaid,0)<> 0 ;');
          SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'update ' + fsTablename +' T  inner join tblsaleslines SL on SL.saleLineId = T.saleLineId inner join tblproctree PT on PT.ProctreeId = T.PTID'+LvlNo(Level)+' Set T.BTotal4SOQty' +LvlNo(Level)+' = if(ifnull(PT.BuildFormulaQtyValue4,0)=0 , PT.FormulaQtyValue4 ,PT.BuildFormulaQtyValue4) * SL.QtySold where /*ifnull(PT.Formulaid,0)<> 0 and*/ ifnull(PT.ManufactureQty,0)>0;'+
                                                  'update ' + fsTablename +' T  inner join tblproctree PT on PT.ProctreeId = T.PTID'+LvlNo(Level)+' Set T.QtyPer' +LvlNo(Level)+' = ifnull(PT.FormulaQtyValue4,0) where /*ifnull(PT.Formulaid,0)<> 0 and*/ (ifnull(PT.FromStockQty,0)>0 Or ifnull(PT.OnOrderQty,0)>0);'+
                                                  'update ' + fsTablename +' T  inner join tblsaleslines SL on SL.saleLineId = T.saleLineId inner join tblproctree PT on PT.ProctreeId = T.PTID'+LvlNo(Level)+' Set T.STotal4SOQty' +LvlNo(Level)+' = ifnull(PT.FormulaQtyValue4,0) * SL.QtySold where /*ifnull(PT.Formulaid,0)<> 0 and*/ (ifnull(PT.FromStockQty,0)>0 Or ifnull(PT.OnOrderQty,0)>0);');

        end else if Sametext(Appenv.companyPrefs.Fe5Name ,Appenv.companyPrefs.FeQtyField) then begin
          SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'update ' + fsTablename +' T  inner join tblproctree PT on PT.ProctreeId = T.PTID'+LvlNo(Level)+' Set T.infowithnoqty' +LvlNo(Level)+' = replace(infowithnoqty' +LvlNo(Level)+' , Concat(' +Quotedstr(Appenv.companyPrefs.FeQtyFieldInfodisplayLabel) +'," ",BuildFormulaQtyValue5) , "" ) where ifnull(PT.Formulaid,0)<> 0 ;'+
                                                  'update ' + fsTablename +' T  inner join tblproctree PT on PT.ProctreeId = T.PTID'+LvlNo(Level)+' Set T.infowithnoqty' +LvlNo(Level)+' = replace(infowithnoqty' +LvlNo(Level)+' , Concat(' +Quotedstr(Appenv.companyPrefs.FeQtyFieldInfodisplayLabel) +'," ",FormulaQtyValue5) , "" ) where ifnull(PT.Formulaid,0)<> 0 ;');
          SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'update ' + fsTablename +' T  inner join tblsaleslines SL on SL.saleLineId = T.saleLineId inner join tblproctree PT on PT.ProctreeId = T.PTID'+LvlNo(Level)+' Set T.BTotal4SOQty' +LvlNo(Level)+' = if(ifnull(PT.BuildFormulaQtyValue5,0)=0 , PT.FormulaQtyValue5 ,PT.BuildFormulaQtyValue5) * SL.QtySold where /*ifnull(PT.Formulaid,0)<> 0 and*/ ifnull(PT.ManufactureQty,0)>0;'+
                                                  'update ' + fsTablename +' T  inner join tblproctree PT on PT.ProctreeId = T.PTID'+LvlNo(Level)+' Set T.QtyPer' +LvlNo(Level)+' = ifnull(PT.FormulaQtyValue5,0) where /*ifnull(PT.Formulaid,0)<> 0 and*/ (ifnull(PT.FromStockQty,0)>0 Or ifnull(PT.OnOrderQty,0)>0);'+
                                                  'update ' + fsTablename +' T  inner join tblsaleslines SL on SL.saleLineId = T.saleLineId inner join tblproctree PT on PT.ProctreeId = T.PTID'+LvlNo(Level)+' Set T.STotal4SOQty' +LvlNo(Level)+' = ifnull(PT.FormulaQtyValue5,0) * SL.QtySold where /*ifnull(PT.Formulaid,0)<> 0 and*/ (ifnull(PT.FromStockQty,0)>0 Or ifnull(PT.OnOrderQty,0)>0);');
        end;
        SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'update ' + fsTablename +' Set Total4SOQty' +LvlNo(Level)+' = if(ifnull(STotal4SOQty' +LvlNo(Level)+',0)=0 , BTotal4SOQty' +LvlNo(Level)+' , STotal4SOQty' +LvlNo(Level)+');');
    end;
    SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'ALTER TABLE ' + fsTablename + ' ADD INDEX `SaleLineIdidx`       ( SaleLineId);' );
    SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'Drop table if exists ' + fsTablename +'1;');
    SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'Create table ' + fsTablename +'1 Select SaleLineId , max(Level) as Level from ' + fsTablename +' group by SaleLineId;');
    SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'ALTER TABLE ' + fsTablename + '1 ADD INDEX `SaleLineIdidx`       ( SaleLineId);' );
    SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'update ' + fsTablename +' T inner join  ' + fsTablename +'1 T1 on T.SaleLineId = T1.SaleLineId Set T.MaxLevel =  T1.LEvel;');
    SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'Drop table if exists ' + fsTablename +'1;');
    SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'ALTER TABLE ' + fsTablename + ' add column Employeename varchar(255);');
    SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'update ' + fsTablename +' T inner join  tblsales S on T.saleId = S.saleId Set T.EmployeeName = S.EmployeeName;');

    inherited;

  end;
end;

procedure TBOMSalesSubProductsDetailListGUI.ReadnApplyGuiPrefExtra;
var
  x:Integer;
begin
  inherited;
      if GuiPrefs.Node.Exists('grpExtrafilters') then begin
        x := GuiPrefs.Node['grpExtrafilters.ItemIndex'].asInteger;
        if x > 0 then if grpExtrafilters.Items.Count >= x then grpExtrafilters.ItemIndex := x - 1;
      end;

end;

procedure TBOMSalesSubProductsDetailListGUI.RefreshQuery;
var
  fiBomLevels , Level :Integer;
begin
  inherited;
  grpFiltersClick(grpFilters);

      fiBomLevels := BOMTreeLevels;
      for level := 1 to fiBomLevels do begin
        GuiPrefs.DbGridElement[grdmain].FieldGroupname['BTotal4SOQty'  + LvlNo(Level)] := Appenv.Companyprefs.FeQtyFieldInfodisplayLabel+' x Sales Qty';
        GuiPrefs.DbGridElement[grdmain].FieldGroupname['STotal4SOQty'  + LvlNo(Level)] := Appenv.Companyprefs.FeQtyFieldInfodisplayLabel+' x Sales Qty';
        GuiPrefs.DbGridElement[grdmain].FieldGroupname['Total4SOQty'  + LvlNo(Level)] := Appenv.Companyprefs.FeQtyFieldInfodisplayLabel+' x Sales Qty';
      end;

end;
procedure TBOMSalesSubProductsDetailListGUI.SetGridColumns;
var
  fiBomLevels , level :Integer;
begin
  fiBomLevels := BOMTreeLevels;
  for level := 1 to fiBomLevels do begin
    RemoveFieldfromGrid('PTID'+LvlNo(Level));
    RemoveFieldfromGrid('totalQty'+LvlNo(Level));
    RemoveFieldfromGrid('SequenceUp'+LvlNo(Level));
    RemoveFieldfromGrid('ParentID'+LvlNo(Level));
  end;
  RemoveFieldfromGrid('Level');
  RemoveFieldfromGrid('MaxLevel');
end;

procedure TBOMSalesSubProductsDetailListGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['grpExtrafilters.ItemIndex'].asInteger := grpExtrafilters.ItemIndex + 1;
  WriteGuiPrefDynfields;
end;

function TBOMSalesSubProductsDetailListGUI.ExpressDetailListName: String;
begin
  Result := 'TBOMSalesSubProductsListGUI';
end;

Function TBOMSalesSubProductsDetailListGUI.extraFields:String;
var
  fiBomLevels , level :Integer;
  s:String;
begin
  fiBomLevels := BOMTreeLevels;
  result :='T.Duedate   as Duedate, '+NL+
           'T.shipdate  as shipdate,'+NL+
           'T.Level     as Level,'+NL+
           'T.MaxLevel  as MaxLevel,'+NL+
           'T.EmployeeName as EmployeeName, '+NL;
  for level := 1 to fiBomLevels do begin
    result := result +' T.caption'      +LvlNo(Level)+' as caption'      +LvlNo(Level)+','+NL+
                      ' T.Info'         +LvlNo(Level)+' as Info'         +LvlNo(Level)+','+NL+
                      ' T.infowithnoqty'+LvlNo(Level)+' as infowithnoqty'+LvlNo(Level)+','+NL+
                      ' T.PTID'         +LvlNo(Level)+' as PTID'         +LvlNo(Level)+','+NL+
                      ' T.totalQty'     +LvlNo(Level)+' as totalQty'     +LvlNo(Level)+','+NL+
                      ' T.BTotal4SOQty' +LvlNo(Level)+' as BTotal4SOQty' +LvlNo(Level)+','+NL+
                      //' T.OTotal4SOQty' +LvlNo(Level)+' as OTotal4SOQty' +LvlNo(Level)+','+NL+
                      ' T.STotal4SOQty' +LvlNo(Level)+' as STotal4SOQty' +LvlNo(Level)+','+NL+
                      ' T.Total4SOQty' +LvlNo(Level)+' as Total4SOQty' +LvlNo(Level)+','+NL+
                      ' T.QtyPer'       +LvlNo(Level)+' as QtyPer'       +LvlNo(Level)+','+NL+
                      ' T.SequenceUp'   +LvlNo(Level)+' as SequenceUp'   +LvlNo(Level)+','+NL+
                      ' T.ParentID'     +LvlNo(Level)+' as ParentID'     +LvlNo(Level)+',';
      s:= 'caption'+LvlNo(Level);
      if Qrymain.findfield(s) = nil then
          with TWideStringfield.Create(Self) do begin
            fieldKind := fkData;
            fieldname := s;
            name := ComponentName(self, 'Qrymain'+fieldname);
            DataSet := qryMain;
            visible := True;
            Displaywidth := 20;
            DisplayLabel := 'Item-'+LvlNo(Level);
          end;
      s:= 'Info'+LvlNo(Level);
      if Qrymain.findfield(s) = nil then
          with TWideStringfield.Create(Self) do begin
            fieldKind := fkData;
            fieldname := s;
            name := ComponentName(self, 'Qrymain'+fieldname);
            DataSet := qryMain;
            visible := True;
            Displaywidth := 20;
            DisplayLabel := 'Info-'+LvlNo(Level);
          end;
      s:= 'infowithnoqty'+LvlNo(Level);
      if Qrymain.findfield(s) = nil then
          with TWideStringfield.Create(Self) do begin
            fieldKind := fkData;
            fieldname := s;
            name := ComponentName(self, 'Qrymain'+fieldname);
            DataSet := qryMain;
            visible := True;
            Displaywidth := 20;
            DisplayLabel := 'infowithnoqty-'+LvlNo(Level);
          end;
      s:='PTID'+LvlNo(Level);
      if Qrymain.findfield(s) = nil then
          with TIntegerfield.Create(Self) do begin
            fieldKind := fkData;
            fieldname := s;
            name := ComponentName(self, 'Qrymain'+fieldname);
            DataSet := qryMain;
            visible := False;
          end;
      s:= 'totalQty'+LvlNo(Level);
      if Qrymain.findfield(s) = nil then
          with TFloatfield.Create(Self) do begin
            fieldKind := fkData;
            fieldname := s;
            name := ComponentName(self, 'Qrymain'+fieldname);
            DataSet := qryMain;
            visible := False;
          end;
      s:= 'BTotal4SOQty'+LvlNo(Level);
      if Qrymain.findfield(s) = nil then
          with TFloatfield.Create(Self) do begin
            fieldKind := fkData;
            fieldname := s;
            name := ComponentName(self, 'Qrymain'+fieldname);
            DataSet := qryMain;
            visible := True;
          end;
      s:= 'STotal4SOQty'+LvlNo(Level);
      if Qrymain.findfield(s) = nil then
          with TFloatfield.Create(Self) do begin
            fieldKind := fkData;
            fieldname := s;
            name := ComponentName(self, 'Qrymain'+fieldname);
            DataSet := qryMain;
            visible := True;
          end;
      s:= 'Total4SOQty'+LvlNo(Level);
      if Qrymain.findfield(s) = nil then
          with TFloatfield.Create(Self) do begin
            fieldKind := fkData;
            fieldname := s;
            name := ComponentName(self, 'Qrymain'+fieldname);
            DataSet := qryMain;
            visible := True;
          end;
      s:=  'QtyPer'+LvlNo(Level);
      if Qrymain.findfield(s) = nil then
          with TFloatfield.Create(Self) do begin
            fieldKind := fkData;
            fieldname := s;
            name := ComponentName(self, 'Qrymain'+fieldname);
            DataSet := qryMain;
            visible := True;
            Displaylabel :='Qty Per-'+LvlNo(Level);
            DisplayWidth :=10;
          end;
      s:= 'SequenceUp'+LvlNo(Level);
      if Qrymain.findfield(s) = nil then
          with TIntegerfield.Create(Self) do begin
            fieldKind := fkData;
            fieldname := s;
            name := ComponentName(self, 'Qrymain'+fieldname);
            DataSet := qryMain;
            visible := False;
          end;
      s:= 'ParentID'+LvlNo(Level);
      if Qrymain.findfield(s) = nil then
          with TIntegerfield.Create(Self) do begin
            fieldKind := fkData;
            fieldname := s;
            name := ComponentName(self, 'Qrymain'+fieldname);
            DataSet := qryMain;
            visible := False;
          end;
      inherited;
  end;

end;
Function TBOMSalesSubProductsDetailListGUI.ExtraTables:String;
begin
  result :=' inner join '+fsTablename +' T  on PT.proctreeId = T.PTID';
end;


procedure TBOMSalesSubProductsDetailListGUI.ReadGuiPrefDynfields;
var
  fiBomLevels , level :Integer;
begin
  inherited;
  fiBomLevels := BOMTreeLevels;
  for level := 1 to fiBomLevels do begin
    if GuiPrefs.Node.Exists('Gridfield.caption'       +LvlNo(Level)) and not(GuiPrefs.Node['Gridfield.caption'      +LvlNo(Level)].AsBoolean) then Qrymain.fieldbyname('caption'      +LvlNo(Level)).visible := False;
    if GuiPrefs.Node.Exists('Gridfield.info'          +LvlNo(Level)) and not(GuiPrefs.Node['Gridfield.info'         +LvlNo(Level)].AsBoolean) then Qrymain.fieldbyname('info'         +LvlNo(Level)).visible := False;
    if GuiPrefs.Node.Exists('Gridfield.infowithnoqty' +LvlNo(Level)) and not(GuiPrefs.Node['Gridfield.infowithnoqty'+LvlNo(Level)].AsBoolean) then Qrymain.fieldbyname('infowithnoqty'+LvlNo(Level)).visible := False;
    if GuiPrefs.Node.Exists('Gridfield.qtyper'        +LvlNo(Level)) and not(GuiPrefs.Node['Gridfield.qtyper'       +LvlNo(Level)].AsBoolean) then Qrymain.fieldbyname('qtyper'       +LvlNo(Level)).visible := False;

    if GuiPrefs.Node.Exists('Gridfield.captiondl'       +LvlNo(Level)) and (GuiPrefs.Node['Gridfield.captiondl'       +LvlNo(Level)].asString<>'') then Qrymain.fieldbyname('caption'       +LvlNo(Level)).Displaylabel := GuiPrefs.Node['Gridfield.captiondl'      +LvlNo(Level)].asString;
    if GuiPrefs.Node.Exists('Gridfield.infodl'          +LvlNo(Level)) and (GuiPrefs.Node['Gridfield.infodl'          +LvlNo(Level)].asString<>'') then Qrymain.fieldbyname('info'          +LvlNo(Level)).Displaylabel := GuiPrefs.Node['Gridfield.infodl'         +LvlNo(Level)].asString;
    if GuiPrefs.Node.Exists('Gridfield.infowithnoqtydl' +LvlNo(Level)) and (GuiPrefs.Node['Gridfield.infowithnoqtydl' +LvlNo(Level)].asString<>'') then Qrymain.fieldbyname('infowithnoqty' +LvlNo(Level)).Displaylabel := GuiPrefs.Node['Gridfield.infowithnoqtydl'+LvlNo(Level)].asString;
    if GuiPrefs.Node.Exists('Gridfield.qtyperdl'        +LvlNo(Level)) and (GuiPrefs.Node['Gridfield.qtyperdl'        +LvlNo(Level)].AsString<>'') then Qrymain.fieldbyname('qtyper'        +LvlNo(Level)).DisplayLabel := GuiPrefs.Node['Gridfield.qtyperdl'       +LvlNo(Level)].AsString;

    if GuiPrefs.Node.Exists('Gridfield.captiondw'       +LvlNo(Level)) and (GuiPrefs.Node['Gridfield.captiondw'       +LvlNo(Level)].AsInteger <> 0) then Qrymain.fieldbyname('caption'       +LvlNo(Level)).DisplayWidth := GuiPrefs.Node['Gridfield.captiondw'      +LvlNo(Level)].AsInteger;
    if GuiPrefs.Node.Exists('Gridfield.infodw'          +LvlNo(Level)) and (GuiPrefs.Node['Gridfield.infodw'          +LvlNo(Level)].AsInteger <> 0) then Qrymain.fieldbyname('info'          +LvlNo(Level)).DisplayWidth := GuiPrefs.Node['Gridfield.infodw'         +LvlNo(Level)].AsInteger;
    if GuiPrefs.Node.Exists('Gridfield.infowithnoqtydw' +LvlNo(Level)) and (GuiPrefs.Node['Gridfield.infowithnoqtydw' +LvlNo(Level)].AsInteger <> 0) then Qrymain.fieldbyname('infowithnoqty' +LvlNo(Level)).DisplayWidth := GuiPrefs.Node['Gridfield.infowithnoqtydw'+LvlNo(Level)].AsInteger;
    if GuiPrefs.Node.Exists('Gridfield.qtyperdw'        +LvlNo(Level)) and (GuiPrefs.Node['Gridfield.qtyperdw'        +LvlNo(Level)].AsInteger <> 0) then Qrymain.fieldbyname('qtyper'        +LvlNo(Level)).DisplayWidth := GuiPrefs.Node['Gridfield.qtyperdw'       +LvlNo(Level)].AsInteger;

  end;

end;

procedure TBOMSalesSubProductsDetailListGUI.WriteGuiPrefDynfields;
var
  fiBomLevels , level :Integer;
begin
  fiBomLevels := BOMTreeLevels;

  for level := 1 to fiBomLevels do begin
    GuiPrefs.Node['Gridfield.caption'+LvlNo(Level)].AsBoolean := Qrymain.fieldbyname('caption'+LvlNo(Level)).visible ;
    GuiPrefs.Node['Gridfield.info'   +LvlNo(Level)].AsBoolean := Qrymain.fieldbyname('Info'+LvlNo(Level)).visible ;
    GuiPrefs.Node['Gridfield.infowithnoqty'   +LvlNo(Level)].AsBoolean := Qrymain.fieldbyname('infowithnoqty'+LvlNo(Level)).visible ;
    GuiPrefs.Node['Gridfield.qtyper' +LvlNo(Level)].AsBoolean := Qrymain.fieldbyname('qtyper'+LvlNo(Level)).visible ;


    GuiPrefs.Node['Gridfield.captiondl'+LvlNo(Level)].AsString := Qrymain.fieldbyname('caption'+LvlNo(Level)).DisplayLabel;
    GuiPrefs.Node['Gridfield.infodl'   +LvlNo(Level)].AsString := Qrymain.fieldbyname('Info'+LvlNo(Level)).DisplayLabel;
    GuiPrefs.Node['Gridfield.infowithnoqtydl'   +LvlNo(Level)].AsString := Qrymain.fieldbyname('infowithnoqty'+LvlNo(Level)).DisplayLabel;
    GuiPrefs.Node['Gridfield.qtyperdl' +LvlNo(Level)].AsString := Qrymain.fieldbyname('qtyper'+LvlNo(Level)).DisplayLabel;


    GuiPrefs.Node['Gridfield.caption'+LvlNo(Level)].AsInteger := Qrymain.fieldbyname('caption'+LvlNo(Level)).DisplayWidth;
    GuiPrefs.Node['Gridfield.info'   +LvlNo(Level)].AsInteger := Qrymain.fieldbyname('Info'+LvlNo(Level)).DisplayWidth;
    GuiPrefs.Node['Gridfield.infowithnoqty'   +LvlNo(Level)].AsInteger := Qrymain.fieldbyname('infowithnoqty'+LvlNo(Level)).DisplayWidth;
    GuiPrefs.Node['Gridfield.qtyper' +LvlNo(Level)].AsInteger := Qrymain.fieldbyname('qtyper'+LvlNo(Level)).DisplayWidth;

  end;
end;
procedure TBOMSalesSubProductsDetailListGUI.qryMainBeforeClose(DataSet: TDataSet);
begin
  inherited;
  WriteGuiPrefDynfields;
end;

procedure TBOMSalesSubProductsDetailListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  ReadGuiPrefDynfields;
  qryMainShipdate.DisplayFormat := formatSettings.ShortDateFormat;
end;

initialization
  RegisterClassOnce(TBOMSalesSubProductsDetailListGUI);

end.
