unit AttributeProductSalesSummary;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ProductSalesSummary, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TAttributeProductSalesSummaryGUI = class(TProductSummaryGUI)
    qryMainAttribDetails: TWideStringField;
    qryMainAGname: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
  private
    function TablEnameAttrib :String;
  Protected
    Procedure ExtraTablejoins4Parts(SQL: TStrings;Const PartsTablealias :String ='P'); Override;
    Procedure Extrafields(SQL:TStrings);Override;
    Procedure ExtraUpdate(SQL:TStrings);Override;
    Procedure ExtraFieldForQrymain(SQL:TStrings);Override;
    Procedure ExtraSQLForQrymain;Override;
  public
  end;

implementation

uses CommonLib, CommonDbLib;

{$R *.dfm}

{ TProductSummaryGUI1 }
procedure TAttributeProductSalesSummaryGUI.ExtraSQLForQrymain;
begin
Qrymain.SQL.add('Select');
  Qrymain.SQL.add(inttostr(NextSeqno)+' as Seqno,');
  Qrymain.SQL.add('NULL	as	Category	,');
  Qrymain.SQL.add('NULL	as	SaleDate	,');
  Qrymain.SQL.add('NULL	as	Product_Description	,');
  Qrymain.SQL.add('NULL	as	Product_Description_Memo	,');
  Qrymain.SQL.Add('NULL	as AttribDetails,');
  Qrymain.SQL.Add('AGname as AGname,');
  Qrymain.SQL.add('NULL	as	firstColumn	,');
  Qrymain.SQL.add('NULL	as	Secondcolumn	,');
  Qrymain.SQL.add('NULL	as	Thirdcolumn	,');
  Qrymain.SQL.add('NULL	as	ProductName	,');
  Qrymain.SQL.add('NULL	as	Classname	,');
  Qrymain.SQL.add('NULL	as	CustomerName	,');
  Qrymain.SQL.add('Sum(Qty)	as	Qty	,');
  Qrymain.SQL.add('Sum(TotalAmountEx)	as	TotalAmountEx,');
  Qrymain.SQL.add('Sum(TotalProfitEx)	as	TotalProfitEx,');
  Qrymain.SQL.add('Sum(TotalProfitInc)	as	TotalProfitInc,');
  Qrymain.SQL.add('Sum(TotalAmountInc)	as	TotalAmountInc	,');
  Qrymain.SQL.add('Sum(GrossProfitTotal)	as	GrossProfitTotal	,');
  Qrymain.SQL.add('Sum(LineCostEx)	as	LineCostEx	,');
  Qrymain.SQL.add('NULL	as	ProductId	,');
  Qrymain.SQL.add('NULL	as	IsSpecial	,');
  qrymain.SQL.Add('NULL	as SalesCategory,');
  Qrymain.SQL.add('NULL	as	TypeName	,');
  Qrymain.SQL.add('NULL	as	CUSTFLD1	,');
  Qrymain.SQL.add('NULL	as	CUSTFLD2	,');
  Qrymain.SQL.add('NULL	as	CUSTFLD3	,');
  Qrymain.SQL.add('NULL	as	CUSTFLD4	,');
  Qrymain.SQL.add('NULL	as	CUSTFLD5	,');
  Qrymain.SQL.add('NULL	as	CUSTFLD6	,');
  Qrymain.SQL.add('NULL	as	CUSTFLD7	,');
  Qrymain.SQL.add('NULL	as	CUSTFLD8	,');
  Qrymain.SQL.add('NULL	as	CUSTFLD9	,');
  Qrymain.SQL.add('NULL	as	CUSTFLD10	,');
  Qrymain.SQL.add('NULL	as	CUSTFLD11	,');
  Qrymain.SQL.add('NULL	as	CUSTFLD12	,');
  Qrymain.SQL.add('NULL	as	CUSTFLD13	,');
  Qrymain.SQL.add('NULL	as	CUSTFLD14	,');
  Qrymain.SQL.add('NULL	as	CUSTFLD15	,');
  Qrymain.SQL.add('NULL	as	CUSTDATE1	,');
  Qrymain.SQL.add('NULL	as	CUSTDATE2	,');
  Qrymain.SQL.add('NULL	as	CUSTDATE3	,');
  Qrymain.SQL.add('NULL	as	Avgcost	,');
  Qrymain.SQL.add('NULL	as	PreferredSupplier	,');
  Qrymain.SQL.add('instockQty	as	instockQty	,');
  Qrymain.SQL.add('AvailableQty	as	AvailableQty	,');
  Qrymain.SQL.add('LastSoldDays	as	LastSoldDays');
  Qrymain.SQL.add('from ' +tablename +'');
  Qrymain.SQL.add('Group by AGname');

  Qrymain.SQL.add('union all');
end;

procedure TAttributeProductSalesSummaryGUI.ExtraFieldForQrymain(SQL: TStrings);
begin
  inherited;
  SQL.Add('AttribDetails as AttribDetails,');
  SQL.Add('AGname as AGname,');
end;

procedure TAttributeProductSalesSummaryGUI.Extrafields(SQL: TStrings);
begin
  inherited;
  SQL.Add('AP.AttribDetails as AttribDetails,');
  SQL.Add('AP.AGname as AGname,');
end;

Procedure TAttributeProductSalesSummaryGUI.ExtraTablejoins4Parts(SQL: TStrings;Const PartsTablealias :String ='P');
begin
  SQL.add('inner join ' + TablenameAttrib + ' AP on AP.ProductId = ' + PartsTablealias+'.PartsID');
end;
procedure TAttributeProductSalesSummaryGUI.ExtraUpdate(SQL: TStrings);
begin
  inherited;
  SQL.add('Alter table '+tablename +'  add column AttribDetails varchar(255);');
  SQL.add('Alter table '+tablename +'  add column AGname varchar(255);');
  SQL.add('update '+tablename +' T1 inner join '+ TablEnameAttrib +' T2 on T1.productId = T2.productId Set T1.AttribDetails = T2.AttribDetails , T1.AGname = T2.AGname;');
end;

procedure TAttributeProductSalesSummaryGUI.FormCreate(Sender: TObject);
begin
  inherited;
  with Scriptmain do begin
    SQL.Clear;
    SQL.Add('drop table if exists ' + TablenameAttrib + ' ;');
    SQL.Add('CREATE TABLE ' + TablenameAttrib +  ' ( '+
	          '   id INT(11) NOT NULL AUTO_INCREMENT, '+
            '  AGname varchar(255) Null Default null ,' +
	          ' 	ProductId INT(11) NULL DEFAULT NULL, '+
	          ' 	productname VARCHAR(255) NULL DEFAULT NULL, '+
	          ' 	AttribDetails TEXT NULL, '+
	          ' 	PRIMARY KEY (id), '+
	          ' 	INDEX ProductId (ProductId) '+
	          ' ) ENGINE=Myisam;');

    SQL.Add('insert ignore into ' + TablenameAttrib +  ' (Agname, ProductId, Productname, Attribdetails) '+
	          '   SELECT '+
            '   AG.name, '+
	          '   AP.ProductId as ProductId, '+
	          '   AP.productname, '+
	          '   group_concat(concat(AP.AttribName , ":" , AP.AttribValue)) as AttribDetails '+
	          '   FROM tblproductattributegroups AG '+
	          '   inner join tblproductattributeproducts AP on AP.PAG_ID = AG.PAG_ID '+
	          '   group by AP.ProductID;');
    Execute;
  end;
end;

procedure TAttributeProductSalesSummaryGUI.FormDestroy(Sender: TObject);
begin
  CommonDbLib.DestroyUserTemporaryTable(tablename+'Attrib');
  inherited;

end;

procedure TAttributeProductSalesSummaryGUI.grpFiltersClick(Sender: TObject);
begin
  if grpfilters.itemindex =0 then
    if not(Iscolvisible(qryMainAGname.fieldname)) then begin
        grdmain.AddField(qryMainAGname.FieldName);
        guiprefs.DbGridElement[grdmain].AddField(qryMainAGname.FieldName);
        qryMainAGname.index := 0;
    end;
  inherited;
end;

function TAttributeProductSalesSummaryGUI.TablEnameAttrib: String;
begin
  Result := tablename+'Attrib';
end;

initialization
  RegisterClassOnce(TAttributeProductSalesSummaryGUI);

end.
