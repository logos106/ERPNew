unit ProjectedManufacturingQty;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, DNMPanel , frmBaselistingSelectionLookup, GIFImg;

type
  TProjectedManufacturingQtyGUI = class(TBaseListingGUI)
    qryMainDetails: TIntegerField;
    qryMainSequencedown: TIntegerField;
    qryMainMainPartsID: TIntegerField;
    qryMainRawMaterialPartsID: TIntegerField;
    qryMainMainproductname: TWideStringField;
    qryMainRawMaterialName: TWideStringField;
    qryMainCRawMaterialName: TWideStringField;
    qryMainHasChildren: TWideStringField;
    qryMainMainProductTotalQty: TFloatField;
    qryMainRequiredQty: TFloatField;
    qryMainInStock: TFloatField;
    qryMainAvailable: TFloatField;
    qryMainProjectedQty: TFloatField;
    btnChooseProducts: TDNMSpeedButton;
    qryMainInputType: TWideStringField;
    qryMainSelected: TWideStringField;
    qryMainMPProductPrintName: TWideStringField;
    qryMainMPPARTSDESCRIPTION: TWideStringField;
    qryMainMPBARCODE: TWideStringField;
    qryMainMPCUSTFLD1: TWideStringField;
    qryMainMPCUSTFLD2: TWideStringField;
    qryMainMPCUSTFLD3: TWideStringField;
    qryMainMPCUSTFLD4: TWideStringField;
    qryMainMPCUSTFLD5: TWideStringField;
    qryMainMPCUSTFLD6: TWideStringField;
    qryMainMPCUSTFLD7: TWideStringField;
    qryMainMPCUSTFLD8: TWideStringField;
    qryMainMPCUSTFLD9: TWideStringField;
    qryMainMPCUSTFLD10: TWideStringField;
    qryMainMPCUSTFLD11: TWideStringField;
    qryMainMPCUSTFLD12: TWideStringField;
    qryMainMPCUSTFLD13: TWideStringField;
    qryMainMPCUSTFLD14: TWideStringField;
    qryMainMPCUSTFLD15: TWideStringField;
    qryMainMPCUSTDATE1: TDateTimeField;
    qryMainMPCUSTDATE2: TDateTimeField;
    qryMainMPCUSTDATE3: TDateTimeField;
    qryMainMPFirstColumn: TWideStringField;
    qryMainMPSecondColumn: TWideStringField;
    qryMainMPThirdColumn: TWideStringField;
    qryMainTreePProductPrintName: TWideStringField;
    qryMainTreePPARTSDESCRIPTION: TWideStringField;
    qryMainTreePBARCODE: TWideStringField;
    qryMainTreePCUSTFLD1: TWideStringField;
    qryMainTreePCUSTFLD2: TWideStringField;
    qryMainTreePCUSTFLD3: TWideStringField;
    qryMainTreePCUSTFLD4: TWideStringField;
    qryMainTreePCUSTFLD5: TWideStringField;
    qryMainTreePCUSTFLD6: TWideStringField;
    qryMainTreePCUSTFLD7: TWideStringField;
    qryMainTreePCUSTFLD8: TWideStringField;
    qryMainTreePCUSTFLD9: TWideStringField;
    qryMainTreePCUSTFLD10: TWideStringField;
    qryMainTreePCUSTFLD11: TWideStringField;
    qryMainTreePCUSTFLD12: TWideStringField;
    qryMainTreePCUSTFLD13: TWideStringField;
    qryMainTreePCUSTFLD14: TWideStringField;
    qryMainTreePCUSTFLD15: TWideStringField;
    qryMainTreePCUSTDATE1: TDateTimeField;
    qryMainTreePCUSTDATE2: TDateTimeField;
    qryMainTreePCUSTDATE3: TDateTimeField;
    qryMainTreePFirstColumn: TWideStringField;
    qryMainTreePSecondColumn: TWideStringField;
    qryMainTreePThirdColumn: TWideStringField;
    qryMainProjectedQtyOnAv: TFloatField;
    qryMainProjectedQtyOnIS: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);override;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure btnChooseProductsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fsTablename :String;
    SelectedProductIDs :String;
    procedure DoOnProdListShow(Sender: TObject);
    procedure ProductGridDataSelect(Sender: TwwDbGrid);
  Protected
    procedure SetGridColumns; Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    procedure AdjustDisplayLabels(tmpField :TField; Var s:String);Override;
    //Procedure SelectionOptionQry(Lookupform:TfmBaselistingSelectionLookup; cboQry:TERPQuery);Override;
  public
    Procedure RefreshQuery; Override;
  end;

implementation

uses ProductQtyLib, PQALib, AppEnvironment, tcConst, CommonLib, MySQLConst,
  LogLib, CommonDbLib, FrmProductLookup , CommonFormLib;

{$R *.dfm}

{ TProjectedManufacturingQtyGUI }

procedure TProjectedManufacturingQtyGUI.AdjustDisplayLabels(tmpField: TField;var s: String);
var
  FirstColumn: string;
  SecondColumn: string;
  ThirdColumn: string;
begin
  inherited;
  FirstColumn := AppEnv.DefaultClass.FirstColumn;
  SecondColumn := AppEnv.DefaultClass.SecondColumn;
  ThirdColumn := AppEnv.DefaultClass.ThirdColumn;
    if not empty(FirstColumn) then begin
      s := ChangeDisplayLabel(s, 'MPFirstColumn'    , FirstColumn);
      s := ChangeDisplayLabel(s, 'TreePFirstColumn' , FirstColumn);
    end;
    if not empty(SecondColumn) then begin
      s := ChangeDisplayLabel(s, 'MPSecondColumn'   , SecondColumn);
      s := ChangeDisplayLabel(s, 'TreePSecondColumn', SecondColumn);
    end;
    if not empty(ThirdColumn) then begin
      s := ChangeDisplayLabel(s, 'MPThirdColumn'    , ThirdColumn);
      s := ChangeDisplayLabel(s, 'TreePThirdColumn' , ThirdColumn);
    end;

end;

procedure TProjectedManufacturingQtyGUI.btnChooseProductsClick(Sender: TObject);
begin
  inherited;
  CommonFormLib.OpenERPListFormultiselectModal('TProductListExpressGUI',DoOnProdListShow , ProductGridDataSelect)
end;
procedure TProjectedManufacturingQtyGUI.DoOnProdListShow(Sender: TObject);
begin
  TBaseListingGUI(Sender).FilterString := 'PartType = "INV" and Discontinued = "F" and Active = "T"';
  TBaseListingGUI(Sender).SearchMode := smFullList;
  TBaseListingGUI(Sender).Selectrecordsfieldname := 'PartsId';
  TBaseListingGUI(Sender).SelectrecordsValues := SelectedProductIDs;
end;

procedure TProjectedManufacturingQtyGUI.FormCreate(Sender: TObject);
begin
  fsTablename := GetUserTemporaryTableName('tmp_PMQ');
  Qrymain.SQL.clear;
  Qrymain.SQL.Add('Select');
  Qrymain.SQL.Add('T.Details	as	Details	,');
  Qrymain.SQL.Add('T.Sequencedown	as	Sequencedown	,');
  Qrymain.SQL.Add('T.MainPartsID	as	MainPartsID	,');
  Qrymain.SQL.Add('T.RawMaterialPartsID	as	RawMaterialPartsID	,');
  Qrymain.SQL.Add('T.Mainproductname	as	Mainproductname	,');
  Qrymain.SQL.Add('T.RawMaterialName	as	RawMaterialName	,');
  Qrymain.SQL.Add('T.CRawMaterialName	as	CRawMaterialName	,');
  Qrymain.SQL.Add('T.HasChildren	as	HasChildren	,');
  Qrymain.SQL.Add('T.MainProductTotalQty	as	MainProductTotalQty	,');
  Qrymain.SQL.Add('T.RequiredQty	as	RequiredQty	,');
  Qrymain.SQL.Add('T.InStock	as	InStock	,');
  Qrymain.SQL.Add('T.Available	as	Available	,');
  Qrymain.SQL.Add('T.ProjectedQty	as	ProjectedQty	,');
  Qrymain.SQL.Add('T.ProjectedQtyOnAv  as ProjectedQtyOnAv,');
  Qrymain.SQL.Add('T.ProjectedQtyOnIS  as ProjectedQtyOnIS , ');
  Qrymain.SQL.Add('T.InputType	as	InputType	,');
  Qrymain.SQL.Add('T.Selected	as	Selected, ');
  Qrymain.SQL.Add('MP.ProductPrintName as MPProductPrintName,');
  Qrymain.SQL.Add('MP.PARTSDESCRIPTION as MPPARTSDESCRIPTION,');
  Qrymain.SQL.Add('MP.BARCODE as MPBARCODE,');
  Qrymain.SQL.Add('MP.CUSTFLD1  as MPCUSTFLD1,');
  Qrymain.SQL.Add('MP.CUSTFLD2  as MPCUSTFLD2,');
  Qrymain.SQL.Add('MP.CUSTFLD3  as MPCUSTFLD3,');
  Qrymain.SQL.Add('MP.CUSTFLD4  as MPCUSTFLD4,');
  Qrymain.SQL.Add('MP.CUSTFLD5  as MPCUSTFLD5,');
  Qrymain.SQL.Add('MP.CUSTFLD6  as MPCUSTFLD6,');
  Qrymain.SQL.Add('MP.CUSTFLD7  as MPCUSTFLD7,');
  Qrymain.SQL.Add('MP.CUSTFLD8  as MPCUSTFLD8,');
  Qrymain.SQL.Add('MP.CUSTFLD9  as MPCUSTFLD9,');
  Qrymain.SQL.Add('MP.CUSTFLD10 as MPCUSTFLD10,');
  Qrymain.SQL.Add('MP.CUSTFLD11 as MPCUSTFLD11,');
  Qrymain.SQL.Add('MP.CUSTFLD12 as MPCUSTFLD12,');
  Qrymain.SQL.Add('MP.CUSTFLD13 as MPCUSTFLD13,');
  Qrymain.SQL.Add('MP.CUSTFLD14 as MPCUSTFLD14,');
  Qrymain.SQL.Add('MP.CUSTFLD15 as MPCUSTFLD15,');
  Qrymain.SQL.Add('MP.CUSTDATE1 as MPCUSTDATE1,');
  Qrymain.SQL.Add('MP.CUSTDATE2 as MPCUSTDATE2,');
  Qrymain.SQL.Add('MP.CUSTDATE3 as MPCUSTDATE3,');
  Qrymain.SQL.Add(Firstcolumn('MP') + '  as MPFirstColumn, ');
  Qrymain.SQL.Add(Secondcolumn('MP')+ '  as MPSecondColumn, ');
  Qrymain.SQL.Add(Thirdcolumn('MP') + '  as MPThirdColumn, ');

  Qrymain.SQL.Add('TreeP.ProductPrintName as TreePProductPrintName,');
  Qrymain.SQL.Add('TreeP.PARTSDESCRIPTION as TreePPARTSDESCRIPTION,');
  Qrymain.SQL.Add('TreeP.BARCODE as TreePBARCODE,');
  Qrymain.SQL.Add('TreeP.CUSTFLD1  as TreePCUSTFLD1,');
  Qrymain.SQL.Add('TreeP.CUSTFLD2  as TreePCUSTFLD2,');
  Qrymain.SQL.Add('TreeP.CUSTFLD3  as TreePCUSTFLD3,');
  Qrymain.SQL.Add('TreeP.CUSTFLD4  as TreePCUSTFLD4,');
  Qrymain.SQL.Add('TreeP.CUSTFLD5  as TreePCUSTFLD5,');
  Qrymain.SQL.Add('TreeP.CUSTFLD6  as TreePCUSTFLD6,');
  Qrymain.SQL.Add('TreeP.CUSTFLD7  as TreePCUSTFLD7,');
  Qrymain.SQL.Add('TreeP.CUSTFLD8  as TreePCUSTFLD8,');
  Qrymain.SQL.Add('TreeP.CUSTFLD9  as TreePCUSTFLD9,');
  Qrymain.SQL.Add('TreeP.CUSTFLD10 as TreePCUSTFLD10,');
  Qrymain.SQL.Add('TreeP.CUSTFLD11 as TreePCUSTFLD11,');
  Qrymain.SQL.Add('TreeP.CUSTFLD12 as TreePCUSTFLD12,');
  Qrymain.SQL.Add('TreeP.CUSTFLD13 as TreePCUSTFLD13,');
  Qrymain.SQL.Add('TreeP.CUSTFLD14 as TreePCUSTFLD14,');
  Qrymain.SQL.Add('TreeP.CUSTFLD15 as TreePCUSTFLD15,');
  Qrymain.SQL.Add('TreeP.CUSTDATE1 as TreePCUSTDATE1,');
  Qrymain.SQL.Add('TreeP.CUSTDATE2 as TreePCUSTDATE2,');
  Qrymain.SQL.Add('TreeP.CUSTDATE3 as TreePCUSTDATE3,');
  Qrymain.SQL.Add(Firstcolumn('TreeP') + '  as TreePFirstColumn, ');
  Qrymain.SQL.Add(Secondcolumn('TreeP')+ '  as TreePSecondColumn, ');
  Qrymain.SQL.Add(Thirdcolumn('TreeP') + '  as TreePThirdColumn ');
  Qrymain.SQL.Add('From ' + fsTablename+' as T ' +
                  ' inner join tblparts MP on MP.partsId = T.MainPartsID  ' +
                  ' left join tblparts TreeP on T.RawMaterialPartsID = TreeP.partsId ');
  Qrymain.SQL.Add('Order by Mainproductname , Details , Sequencedown');
  cLog(Qrymain.sql.text);
  inherited;
  //SelectionOption := soProduct;
end;
procedure TProjectedManufacturingQtyGUI.ProductGridDataSelect(Sender: TwwDbGrid);
begin
  inherited;
  SelectedProductIDs := commonlib.SelectedIDs(sender, 'PartsId');
  RefreshQuery;
end;
procedure TProjectedManufacturingQtyGUI.FormDestroy(Sender: TObject);
begin
  DeleteTable(fstablename);
  inherited;
end;

procedure TProjectedManufacturingQtyGUI.FormShow(Sender: TObject);
begin
  inherited;
  grpFiltersClick(grpFilters);
end;

procedure TProjectedManufacturingQtyGUI.grdMainCalcCellColors(Sender: TObject;Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;ABrush: TBrush);
begin
  inherited;
  if qryMainDetails.AsInteger in [1] then begin
    if grpfilters.ItemIndex =1 then Dobold(Afont, Abrush ); // high light bom product
    if sametext(field.FieldName  , qrymainMainproductname.FieldName) or
       sametext(field.FieldName  , qrymainProjectedQty.FieldName) Or
       sametext(field.FieldName  , qrymainAvailable.FieldName) then
       else DoHide(Field,State,Afont, ABrush ); // hide detail fields for main line
  end;

  if (qryMainDetails.AsInteger = 2 )  then begin
    if sametext(field.FieldName  , qrymainProjectedQty.FieldName) and (qrymainProjectedQty.asFloat <=0) then DoHide(Field,State,Afont, ABrush );

    if qryMainHasChildren.AsBoolean then
        if sametext(Field.FieldName ,qrymainCRawMaterialName.FieldName) then
               DoGrayout(AFont,ABrush)
        else   DoHide(Field,State,Afont, ABrush ) // hide detail fields for main line
    else  if sametext(Field.FieldName ,qrymainMainproductname.FieldName ) or
             sametext(Field.FieldName ,QrymainMPProductPrintName.FieldName ) or
             sametext(Field.FieldName ,QrymainMPBARCODE.FieldName ) or
             sametext(Field.FieldName ,QrymainMPCUSTFLD1.FieldName ) or
             sametext(Field.FieldName ,QrymainMPCUSTFLD2.FieldName ) or
             sametext(Field.FieldName ,QrymainMPCUSTFLD3.FieldName ) or
             sametext(Field.FieldName ,QrymainMPCUSTFLD4.FieldName ) or
             sametext(Field.FieldName ,QrymainMPCUSTFLD5.FieldName ) or
             sametext(Field.FieldName ,QrymainMPCUSTFLD6.FieldName ) or
             sametext(Field.FieldName ,QrymainMPCUSTFLD7.FieldName ) or
             sametext(Field.FieldName ,QrymainMPCUSTFLD8.FieldName ) or
             sametext(Field.FieldName ,QrymainMPCUSTFLD9.FieldName ) or
             sametext(Field.FieldName ,QrymainMPCUSTFLD10.FieldName ) or
             sametext(Field.FieldName ,QrymainMPCUSTFLD11.FieldName ) or
             sametext(Field.FieldName ,QrymainMPCUSTFLD12.FieldName ) or
             sametext(Field.FieldName ,QrymainMPCUSTFLD13.FieldName ) or
             sametext(Field.FieldName ,QrymainMPCUSTFLD14.FieldName ) or
             sametext(Field.FieldName ,QrymainMPCUSTFLD15.FieldName ) or
             sametext(Field.FieldName ,QrymainMPCUSTDATE1.FieldName ) or
             sametext(Field.FieldName ,QrymainMPCUSTDATE2.FieldName ) or
             sametext(Field.FieldName ,QrymainMPCUSTDATE3.FieldName ) or
             sametext(Field.FieldName ,QrymainMPPARTSDESCRIPTION.FieldName ) then  DoHide(Field,State,Afont, ABrush )
    else  if not(qrymainselected.asboolean) and (qryMainInputType.asString = 'itOption')  then  DoGrayout(Afont, ABrush ); // hide detail fields for main line
  end;

end;

procedure TProjectedManufacturingQtyGUI.grpFiltersClick(Sender: TObject);
begin
  //InitGroupfilterString(QrymainDetails.fieldname , ['1',''], true);
  GroupfilterString := '';
  if Grpfilters.itemindex =0 then GroupfilterString := 'Details = 1 or Details =3';
  inherited;
end;

procedure TProjectedManufacturingQtyGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  SelectedProductIDs  := GuiPrefs.Node['Options.SelectedProductIDs'].asString;
end;

procedure TProjectedManufacturingQtyGUI.RefreshQuery;
begin
  With Scriptmain do begin
    SQL.clear;
    SQL.add('/*1*/Drop table if exists ' + fstablename +';');
    SQL.add('/*2*/CREATE TABLE ' + fstablename +' ( '+
            ' ID INT(11) NOT NULL AUTO_INCREMENT, '+
            ' Details INT(11) NOT NULL DEFAULT 0, '+
            ' Sequencedown INT(11) NOT NULL DEFAULT 0, '+
            ' MainPartsID INT(11) NULL DEFAULT 0, '+
            ' RawMaterialPartsID INT(11) NULL DEFAULT 0, '+
            ' Mainproductname VARCHAR(255) NULL DEFAULT NULL, '+
            ' RawMaterialName VARCHAR(255) NULL DEFAULT NULL, '+
            ' CRawMaterialName VARCHAR(255) NULL DEFAULT NULL, '+
            ' HasChildren ENUM("T","F") NULL DEFAULT "F", '+
            ' MainProductTotalQty DOUBLE NULL DEFAULT 0, '+
            ' RequiredQty DOUBLE NULL DEFAULT 0, '+
            ' InStock DOUBLE NULL DEFAULT 0, '+
            ' Available DOUBLE NULL DEFAULT 0, '+
            ' ProjectedQty DOUBLE NULL DEFAULT 0, '+
            ' ProjectedQtyOnAv DOUBLE NULL DEFAULT 0, '+
            ' ProjectedQtyOnIS DOUBLE NULL DEFAULT 0, '+
            ' InputType VARCHAR(255) NULL DEFAULT NULL, '+
            ' Selected ENUM("T","F") NULL DEFAULT "F", '+
            ' PRIMARY KEY (ID), '+
            ' INDEX MainPartsID (MainPartsID), '+
            ' INDEX RawMaterialPartsID (RawMaterialPartsID) ) '+
            ' COLLATE="utf8_general_ci" ENGINE=MyIsam;');

    SQL.add('/*3*/insert ignore into ' + fstablename +' (Details, MainPartsId,  Mainproductname , MainProductTotalQty , Sequencedown) '+
            ' Select distinct '+
            ' 1 as Details, '+
            ' PT.PartsId, '+
            ' PT.caption  Mainproductname, '+
            ' PT.TotalQty MainProductTotalQty  , '+
            ' PT.SequenceDown '+
            ' from tblproctree PT '+
            ' where PT.mastertype = "mtProduct" and ifnull(PT.ParentId,0)=0 '+
            iif(SelectedProductIDs<> '' , ' and  ifnull(PT.PartsId , 0) in ( ' + SelectedProductIDs+')' , '') +';');

    SQL.add('/*4*/insert ignore into ' + fstablename +' (Details, MainPartsId,  Mainproductname ,RawMaterialPartsID, RawMaterialName , CRawMaterialName , HasChildren,  MainProductTotalQty , RequiredQty , SequenceDown, Inputtype, Selected) '+
            ' Select distinct '+
            ' 2 as Details, '+
            ' PT.PartsId, '+
            ' PT.caption  , '+
            ' RawPT.PartsId, '+
            ' RawPT.Caption , '+
            ' Convert(TreeNodeCaption(RawPT.Level, RawPT.caption ) , char(255)), '+
            ' if( ifnull(ChildPT.ProcTreeId,0)=0 , "F" , "T") as HasChildren , '+
            ' 0 as TotalQty, '+
            ' RawPT.TotalQty as RequiredQty, '+
            ' RawPT.SequenceDown , PPT.Inputtype, RawPT.Selected'+
            ' from tblproctree PT '+
            ' inner join tblproctree RawPT on PT.TreeRootId = RawPT.TreeRootId '+
            ' inner join tblproctree PPT on PPT.ProctreeId = RawPT.ParentId '+
            ' left join tblproctree ChildPT on ChildPT.ParentId = RawPT.ProcTreeId '+
            ' Left join tblparts P on P.partsId = RawPT.PartsId and P.parttype ="INV" '+
            ' where PT.mastertype = "mtProduct" and ifnull(PT.ParentId,0)=0   and ifnull(RawPT.ParentId,0)<>0   '+
            iif(SelectedProductIDs<> '' , ' and  ifnull(PT.PartsId , 0) in ( ' + SelectedProductIDs+')' , '') +';');

    SQL.add('/*5*/insert ignore into ' + fstablename +' (Details, MainPartsId,  Mainproductname ) '+
            ' Select distinct '+
            ' 3 as Details, '+
            ' P.PartsId, '+
            ' P.partname '+
            ' from tblparts P '+
            ' Left join tblproctree PT on P.partsId = PT.PartsId and PT.mastertype = "mtProduct"   '+
            ' where ifnull(PT.proctreeId,0)=0 and P.parttype ="INV" '+
            iif(SelectedProductIDs<> '' , ' and  ifnull(P.PartsId , 0) in ( ' + SelectedProductIDs+')' , '') +';');

     SQL.add('/*6*/Drop table if exists ' + fsTablename +'2; ');
     SQL.add('/*7*/Create table ' + fsTablename +'2  '+
                ' select distinct '+
                ' P.RawMaterialPartsID  '+
                ' from ' + fstablename +' P ;');

     SQL.add('/*7-1*/ALTER TABLE ' + fsTablename +'2 	ADD INDEX `RawMaterialPartsID` (`RawMaterialPartsID`);');

     SQL.add('/*8*/Drop table if exists ' + fsTablename +'1; ');
     SQL.add('/*9*/CREATE TABLE ' + fsTablename +'1 (   ' +
               ' ID               INT(11) NOT NULL AUTO_INCREMENT,  ' +
               ' partsId          INT(11) DEFAULT NULL, ' +
               ' InStock          DOUBLE  DEFAULT NULL, ' +
               ' Available        DOUBLE  DEFAULT NULL, ' +
               ' PRIMARY KEY (ID) ,  ' +
               ' Index PartsId (PartsID)  ' +
               ' ) ENGINE=InnoDB DEFAULT CHARSET=utf8; ');

     SQL.add('/*10*/insert into ' + fsTablename +'1 (PartsID , InStock,Available) '+
                ' select '+
                ' P.RawMaterialPartsID , '+
                 ProductQtylib.SQL4Qty(tInstock   ) +'  as "InStock",'+ NL+
                 ProductQtylib.SQL4Qty(tAvailable ) +
                          iif(AppEnv.CompanyPrefs.CountSOBOInAvailable, ' - ' +ProductQtylib.SQL4Qty(tsobo ) , '') +
                        '  as "Available"' +NL+
                ' from ' + fstablename +'2  P '+
                ' inner join tblPQA  as PQA on P.RawMaterialPartsID = PQA.ProductID and PQA.transdate <=' + Quotedstr(formatdatetime( MysqlDateTimeFormat , FilterdateTo))+
                //' where P.HasChildren ="F" '+
                ' group by p.RawMaterialPartsID; ');

     SQL.add('/*11*/update ' + fsTablename +' t1 inner join ' + fsTablename +'1 t2 on t1.RawMaterialPartsID = t2.partsId '+
                ' Set '+
                ' T1.InStock = t2.InStock, '+
                ' T1.Available = t2.Available ' +
                ' where T1.details = 2 and  HasChildren ="F"; ');

     SQL.add('/*12*/Drop table if exists ' + fsTablename +'1; ');
     SQL.add('/*13*/update ' + fsTablename +' t Set ProjectedQty = TRUNCATE(Available/RequiredQty ,0) where Details = 2 and HasChildren ="F" ;  ');
     SQL.add('/*14*/Create table ' + fsTablename +'1 Select MainPartsId , min(ProjectedQty) as ProjectedQty from ' + fstablename +' where details = 2 and HasChildren ="F"  and (inputtype <> "itOption" or Selected ="T")  group by MainPartsId; ');
     SQL.add('/*14-1*/ALTER TABLE ' + fsTablename +'1 	ADD INDEX `MainPartsId` (`MainPartsId`);');
     SQL.add('/*15*/update ' + fsTablename +' t1 inner join ' + fsTablename +'1 t2 on t1.MainPartsId = t2.MainPartsId '+
                ' Set '+
                ' T1.ProjectedQty = t2.ProjectedQty where T1.DEtails = 1 and ifnull(t2.ProjectedQty,0)>=0; ');
     SQL.add('/*16*/update ' + fsTablename +' Set Available   = 0 where ifnull(Available,0)   = 0;');
     SQL.add('/*17*/update ' + fsTablename +' Set instock     = 0 where ifnull(instock,0)     = 0;');
     SQL.add('/*18*/update ' + fsTablename +' Set ProjectedQty= 0 where ifnull(ProjectedQty,0)= 0;');
     SQL.add('/*19*/update ' + fsTablename +' Set ProjectedQtyOnAv  = if(Available <ProjectedQty , Available,ProjectedQty);');
     SQL.add('/*20*/update ' + fsTablename +' Set ProjectedQtyOnIS  = if(instock <ProjectedQty , instock,ProjectedQty);');
     SQL.add('/*21*/update ' + fsTablename +' Set ProjectedQtyOnAv  = 0 WHERE  ProjectedQtyOnAv<0 ;');
     SQL.add('/*22*/update ' + fsTablename +' Set ProjectedQtyOnIS  = 0 WHERE  ProjectedQtyOnIS<0 ;');

     logtext(Sql.text);
     showProgressbar(WAITMSG , SQL.count);
     try
      Execute;
     finally
       DoHideProgressbar;
     end;
  end;
  inherited;

end;

(*procedure TProjectedManufacturingQtyGUI.SelectionOptionQry(Lookupform: TfmBaselistingSelectionLookup; cboQry: TERPQuery);
var
  fiId:Integer;
begin
  inherited;
  if Lookupform is TFmProductLookup then begin
    fiID := cboQry.fieldbyname('ID').asInteger;
    Closedb(cboQry);
    try
      cboQry.SQL.clear;
      cboQry.SQL.Add('SELECT Distinct P.PartsID AS ID, P.Partname AS Name');
      cboQry.SQL.Add('FROM tblparts P');
      cboQry.SQL.Add('INNER JOIN tblProctree PT ON P.partsId = PT.partsId AND IFNULL(PT.parentId,0)=0');
      cboQry.SQL.Add('WHERE P.Partname IS NOT NULL');
      cboQry.SQL.Add('And (P.Active<>"F" or :ShowInactive ="T" or P.PartsId = :PartsId )');
      cboQry.SQL.Add('ORDER BY Partname;');
    finally
      OpenDB(cboQry);
      cboQry.locate('ID' , fiid, []);
    end;

  end;

end;*)

procedure TProjectedManufacturingQtyGUI.SetGridColumns;
begin
  inherited;
  SetUpcustomFields('Product' , 'MP');
  SetUpcustomFields('Product' , 'TreeP');
  RemoveFieldfromGrid(qryMainDetails.fieldname);
  RemoveFieldfromGrid(qryMainSequencedown.fieldname);
  RemoveFieldfromGrid(qryMainMainPartsID.fieldname);
  RemoveFieldfromGrid(qryMainRawMaterialPartsID.fieldname);
  RemoveFieldfromGrid(qryMainRawMaterialName.fieldname);
  RemoveFieldfromGrid(qryMainHasChildren.fieldname);
  RemoveFieldfromGrid(qryMainMainProductTotalQty.fieldname);
  RemoveFieldfromGrid(qryMainInStock.fieldname);
  RemoveFieldfromGrid(qryMainInputType.fieldname);
  RemoveFieldfromGrid(qryMainSelected.fieldname);
end;

procedure TProjectedManufacturingQtyGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.SelectedProductIDs'].asString := SelectedProductIDs;
end;

initialization
  RegisterClassOnce(TProjectedManufacturingQtyGUI);
end.
