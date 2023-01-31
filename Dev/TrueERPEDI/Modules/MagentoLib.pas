unit MagentoLib;

interface

Uses Classes;

Function ProductsForMagentoSQL(const FilterValue:String; const AServiceName: string; DetailsforList:Boolean = False):String;Overload;
Procedure ProductsForMagentoSQL(const FilterValue:String; AServiceName: string; DetailsforList:Boolean ; st:TStrings);Overload;

implementation

uses ProductQtyLib, utCoreEDIConst, BusobjExternalXRef, sysutils,
  AppEnvironment, PQALib, CommonLib;

Function ProductsForMagentoSQL(const FilterValue:String;const AServiceName: string; DetailsforList:Boolean = False):String;
var
  st:TStringList;
begin
  st:= TStringList.create;
  try
      ProductsForMagentoSQL(FilterValue,AServiceName,DetailsforList,st);
  finally
    Result := St.text;
    FreeandNil(st);
  end;
end;
Procedure ProductsForMagentoSQL(const FilterValue:String; AServiceName: string; DetailsforList:Boolean ; st:TStrings);
begin
            St.Clear;
            St.Add('SELECT distinct');
            St.Add('P.PARTSID                   as PARTSID,');
            St.Add('P.PARTNAME                  as ProductName,');
            if DetailsforList then begin
                  St.Add('P.ProductPrintName    as ProductPrintName,');
                  St.Add(Firstcolumn('P'  ) + ' AS FirstColumn,');
                  St.Add(Secondcolumn('P' ) + ' AS SecondColumn,');
                  St.Add(Thirdcolumn('P'  ) + ' AS ThirdColumn,');
                  St.Add('P.PARTSDESCRIPTION    as SalesDescription,');
                  St.Add('P.PURCHASEDESC        as PURCHASEDESC,');
                  St.Add('P.PRICEINC1           AS PriceInc,');
                  St.Add('P.Discontinued        AS Discontinued,');
                  St.Add('P.PartType            AS PartType,');
                  St.Add('P.CUSTFLD1            AS CUSTFLD1,');
                  St.Add('P.CUSTFLD2            AS CUSTFLD2,');
                  St.Add('P.CUSTFLD3            AS CUSTFLD3,');
                  St.Add('P.CUSTFLD4            AS CUSTFLD4,');
                  St.Add('P.CUSTFLD5            AS CUSTFLD5,');
                  St.Add('P.CUSTFLD6            AS CUSTFLD6,');
                  St.Add('P.CUSTFLD7            AS CUSTFLD7,');
                  St.Add('P.CUSTFLD8            AS CUSTFLD8,');
                  St.Add('P.CUSTFLD9            AS CUSTFLD9,');
                  St.Add('P.CUSTFLD10           AS CUSTFLD10,');
                  St.Add('P.CUSTFLD11           AS CUSTFLD11,');
                  St.Add('P.CUSTFLD12           AS CUSTFLD12,');
                  St.Add('P.CUSTFLD13           AS CUSTFLD13,');
                  St.Add('P.CUSTFLD14           AS CUSTFLD14,');
                  St.Add('P.CUSTFLD15           AS CUSTFLD15,');
                  St.Add('P.CUSTDATE1           AS CUSTDATE1,');
                  St.Add('P.CUSTDATE2           AS CUSTDATE2,');
                  St.Add('P.CUSTDATE3           AS CUSTDATE3,');
                  St.Add('P.BARCODE             AS BARCODE,');
                  St.Add('P.active              AS Active,');
                  St.Add('P.ProductionNotes     AS ProductionNotes,');
                  St.Add('P.GeneralNotes        AS GeneralNotes,');
                  St.Add('P.IsSystemProduct     AS IsSystemProduct,');
                  St.Add('P.Batch               AS Batch,');
                  St.Add('P.Multiplebins        AS Multiplebins ,');
                  St.Add('P.SNtracking          AS SNtracking,');
                  St.Add('P.Area                AS Area,');
                  St.Add('p.PREFEREDSUPP        AS PreferedSupp,');
            end;
            St.Add('If(IsNull(XRefS.ID),"F",'+
                   ' if(convert(GREATEST(P.mstimestamp,ifnull(pqa.mstimestamp,'+ quotedstr(formatDateTime('yyyy-mm-dd' , 0))+')) , DATETIME) >'+
                   ' convert(ifnull(XRefs.mstimeStamp,'+ quotedstr(formatDateTime('yyyy-mm-dd' , 0))+') , DATETIME) , "F" , "T")) AS SynchState,');

            St.Add('If(IsNull(XRefS.ID),"Not Synched",'+
                   ' if(P.mstimestamp>convert(ifnull(XRefs.mstimeStamp,'+ quotedstr(formatDateTime('yyyy-mm-dd' , 0))+') , DATETIME) , "Product changed" , '+
                   ' if(ifnull(pqa.mstimestamp,'+ quotedstr(formatDateTime('yyyy-mm-dd' , 0))+')>'+
                   ' convert(ifnull(XRefs.mstimeStamp,'+ quotedstr(formatDateTime('yyyy-mm-dd' , 0))+') , DATETIME),"Product Qty changed" , "Synched"))) AS SynchDesc,');

            St.Add('convert(If(IsNull(XRefS.ID),1,'+
                   ' if(P.mstimestamp>convert(ifnull(XRefs.mstimeStamp,'+ quotedstr(formatDateTime('yyyy-mm-dd' , 0))+') , DATETIME) , 2, '+
                   ' if(ifnull(pqa.mstimestamp,'+ quotedstr(formatDateTime('yyyy-mm-dd' , 0))+')>'+
                   ' convert(ifnull(XRefs.mstimeStamp,'+ quotedstr(formatDateTime('yyyy-mm-dd' , 0))+') , DATETIME),3 , 4))), signed) AS SynchDescNo,');

            if Appenv.companyprefs.DoUpdateProductQtySum  then
                  St.Add('pqa.Available AS AvailableQty')
            else  St.Add(SQL4Qty(tAvailable, 'PQA', 'Qty')+' AS AvailableQty');

            St.Add('FROM tblparts p');
            St.Add('Left JOIN tblExternalXRef XRefS'+
                   ' ON XRefS.ExternalType = '+Quotedstr(AServiceName) +
                   ' AND XRefS.ObjectType = '+quotedstr(ExRef_Objtype_Product)+
                   ' AND XRefS.ERPID = P.partsID');

            if Appenv.companyprefs.DoUpdateProductQtySum  then
              St.Add('Left join tblProductQtySum pqa on pqa.productId = P.partsiD')
            else St.Add('Left join tblpqa pqa on pqa.productId = P.partsiD');

            St.Add('Where   (char_length(p.PARTNAME) > 0 '+
                   ' AND not IsNull(p.PARTNAME) '+
                   ' and P.PublishOnWeb ="T" '+
                   ' and ((ifnull(P.SKU,"")<> "") or (ifnull(P.Globalref,"")<>""))) ');

            if FilterValue <> '' then
              St.Add(iif(sametext(uppercase(copy(trim(FilterValue),1,3)), 'AND'), '' , ' AND ' ) + '('+FilterValue+')');

            St.Add('group by P.partsId');
            St.Add('ORDER BY Partname');
end;
end.
