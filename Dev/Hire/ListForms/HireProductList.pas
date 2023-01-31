unit HireProductList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ProductListExpressForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  BaseListingForm, DBCtrls, ErpTimeCombo;

type
  THireProductListGUI = class(TBaseListingGUI)
    qryMainQty: TFloatField;
    qryMainUOMQty: TFloatField;
    qryMainPARTSID: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainFirstColumn: TWideStringField;
    qryMainSecondColumn: TWideStringField;
    qryMainThirdColumn: TWideStringField;
    qryMainSalesDescription: TWideStringField;
    qryMainPURCHASEDESC: TWideStringField;
    qryMainPartType: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainSNtracking: TWideStringField;
    qryMainArea: TWideStringField;
    qryMainPreferedSupp: TWideStringField;
    qryMainEquipmentName: TWideStringField;
    qryMainSerialNumber: TWideStringField;
    qryMainequipmentID: TLargeintField;
    qryMainStatus: TStringField;
    cboTime: TErpTimeCombo;
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure grpFiltersClick(Sender: TObject); override;
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure dtToChange(Sender: TObject);
  private
    Tablename :String;
    Procedure MakeQry;
    procedure initHireHistoryForProduct(Sender: TObject);
    function Details: Boolean;

  protected
    procedure RefreshQuery; override;
    procedure SetGridColumns; override;
    Function getFilterdateto:TDatetime;override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, ProductQtyLib, LogLib, PQALib, CommonDbLib, AppEnvironment,
  CommonFormLib, HireHistoryForProduct, tcConst ,dateutils;

{$R *.dfm}
{ THireProductListGUI }

function THireProductListGUI.getFilterdateto: TDatetime;
begin
  //Result := inherited;
  Result := Dateof(dtTo.Date)+ cbotime.asTime;
end;

procedure THireProductListGUI.dtToChange(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure THireProductListGUI.FormCreate(Sender: TObject);
begin
  cbotime.asTime :=  appenv.CompanyPrefs.StartOfDay;
  TableName := GetUserTemporaryTableName('Hire');
  MakeQry;
  inherited;
  dtTo.Displayformat := FormatSettings.ShortDateFormat
end;

procedure THireProductListGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(Tablename);
  DestroyUserTemporaryTable(Tablename+'1');
  inherited;
end;

procedure THireProductListGUI.grdMainDblClick(Sender: TObject);
begin
  if Sametext(ActiveFieldname , QrymainQty.FieldName) or
     Sametext(ActiveFieldname , QrymainUomQty.FieldName) then begin
        OpenERPListForm('THireHistoryForProductGUI' , initHireHistoryForProduct);
        Exit;
     end;
  inherited;

end;
procedure THireProductListGUI.grpFiltersClick(Sender: TObject);
begin
  //inherited;
  RefreshQuery;
end;

procedure THireProductListGUI.initHireHistoryForProduct(Sender:TObject);
begin
   if not(Sender is THireHistoryForProductGUI) then exit;
   if Details then
    THireHistoryForProductGUI(Sender).EquipmentId := qryMainequipmentID.AsInteger
   else THireHistoryForProductGUI(Sender).ProductId := qryMainPartsID.AsInteger;
   THireHistoryForProductGUI(Sender).StatusDateAsOn := (*Dateof(*)filterDateTo;
end;
procedure THireProductListGUI.MakeQry;
begin
  Closedb(Qrymain);
  Qrymain.sQL.clear;
  Qrymain.sQL.Add('SELECT distinct');
  if Details then begin
    Qrymain.sQL.Add('convert(E.equipmentID ,signed)   as equipmentID ,');
    Qrymain.sQL.Add('E.EquipmentName  as EquipmentName ,');
    Qrymain.sQL.Add('E.SerialNumber   as SerialNumber,');
  end else begin
    Qrymain.sQL.Add('convert(0,signed) as equipmentID ,');
    Qrymain.sQL.Add('"" as EquipmentName ,');
    Qrymain.sQL.Add('"" as SerialNumber,');
  end;
  Qrymain.sQL.Add('P.PARTSID as PARTSID,');
  Qrymain.sQL.Add('P.PARTNAME as ProductName,');
  Qrymain.sQL.Add(Firstcolumn + ' AS FirstColumn,');
  Qrymain.sQL.Add(Secondcolumn + ' AS SecondColumn,');
  Qrymain.sQL.Add(Thirdcolumn + ' AS ThirdColumn,');
  Qrymain.sQL.Add('PARTSDESCRIPTION as SalesDescription,');
  Qrymain.sQL.Add('PURCHASEDESC as PURCHASEDESC,');
  Qrymain.sQL.Add('PartType as PartType,');
  Qrymain.sQL.Add('P.active as Active,');
  Qrymain.sQL.Add('P.SNtracking,');
  Qrymain.sQL.Add('P.Area as Area,');
  Qrymain.sQL.Add('p.PREFEREDSUPP as PreferedSupp,');
  Qrymain.sQL.Add('TPQA.Qty as Qty,');
  Qrymain.sQL.Add('TPQA.UOMQty as UOMQty');
  Qrymain.sQL.Add('FROM tblequipment E');
  Qrymain.sQL.Add('inner join tblParts P on E.ProductID = P.partsId');
  Qrymain.sQL.Add(' Left join ' +   Tablename + ' TPQA on TPQA.PartsId = P.PartsID '  +iif(Details , '  and ((ifnull(E.SerialNumber,"") <> "" and TPQA.Serialnumber = E.SerialNumber)  or (ifnull(E.SerialNumber,"") = ""))' , ''));
  Qrymain.sQL.Add('WHERE E.OnHire ="T" and  E.active ="T" and char_length(p.PARTNAME) > 0 AND not IsNull(p.PARTNAME)');
end;
procedure THireProductListGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  if Qrymainqty.AsFloat >0 then qryMainStatus.AsString := 'Available as on ' + Quotedstr(Formatdatetime(FormatSettings.shortdateformat, (*Dateof(*)filterDateTo));
end;

Function THireProductListGUI.Details :Boolean;
begin
  result := grpfilters.itemindex = 1;
end;
procedure THireProductListGUI.RefreshQuery;
begin
  with ScriptMain do begin
    SQL.Clear;
    SQL.Add('Drop TABLE if exists '+ Tablename +'1;');
    SQL.Add('Create TABLE  '+ Tablename +'1 ' +replacestr(SQL4ProductQty((*Dateof(*)filterDateTo , '' , tDetailswithSno , 0 , 0 , '' , 0 , '' , '' , '' , tAvailable, '' , '' , 0, (*includeDeptFields*)False , False,False , True , True),
                                'FROM `tblParts` as P' ,
                                'From (select distinct ProductId from tblequipment) E inner join `tblParts` as P on E.ProductID = P.partsId')+';');
    SQL.add('ALTER TABLE '  + Tablename +'1  ADD COLUMN `id` INT(10) NULL AUTO_INCREMENT ,  ADD PRIMARY KEY (`id`);');
    SQL.add('alter TABLE '  + Tablename +'1  add index PartsID (PartsID);');
    SQL.add('ALTER TABLE '  + Tablename +'1  ADD COLUMN `EquipmentID` INT(11) NULL ;');
    SQL.add('update '       + Tablename +'1   T inner join tblequipment E on T.PartsId = E.ProductId and ifnull(E.Serialnumber,"") = ifnull(T.Serialnumber,"") Set T.EquipmentId = E.EquipmentId;');
    SQL.add('update '       + Tablename +'1    T inner join tblequipment E on T.PartsId = E.ProductId and ifnull(E.Serialnumber,"") <> "" and  ifnull(T.Serialnumber,"") = "" Set T.EquipmentId = -1;');
    SQL.add('update '       + Tablename +'1    Set UOMQty = 0 WHERE UOMQty = -1 AND ifnull(SerialNumber,"")<> "";');
    SQL.add('update '       + Tablename +'1    Set Qty    = 0 WHERE Qty    = -1 AND ifnull(SerialNumber,"")<> "";');
    SQL.add('delete from '  + Tablename +'1  where ifnull(Serialnumber,"")<> "" and ifnull(EquipmentId,0)=0;');
    SQL.add('delete from  ' + Tablename +'1  where ifnull(Serialnumber,"")= "" and ifnull(EquipmentId,0)=-1;');
    SQL.Add('Drop TABLE if exists '+ Tablename +';');
    if DEtails then SQL.add('Create table '+ Tablename +' Select PartsID,'+'Serialnumber        ,Qty     ,UOMQty  from '+Tablename +'1 ;')
               else SQL.add('Create table '+ Tablename +' Select PartsID,'+'" " as Serialnumber,sum(Qty) qty,sum(UOMQty) UOMqty  from '+Tablename +'1 group by PartsID;');
    doshowProgressbar(3, WaitMSg);
    try
      Execute;
    finally
      doHideProgressbar;
    end;
    clog(SQL.Text);
  end;
  MakeQry;
  inherited;
  logtext(Qrymain.SQLtext);
end;

procedure THireProductListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainequipmentID.fieldname);
  RemoveFieldfromGrid(qryMainQty.fieldname);
  RemoveFieldfromGrid(qryMainPartsId.fieldname);
end;

initialization
  RegisterClassOnce(THireProductListGUI);

end.
