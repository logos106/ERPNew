unit ReorderLib;

interface

uses ERPdbComponents;

Procedure MakeQryParts(QryParts:TERPQuery; TempTablename:String; BasesonitemIndex:Integer = -1; classId :Integer =-1; PreferredSupp:String ='');

implementation

uses CommonDbLib, LogLib, ProductQtyLib, PQALib, DateTimeUtils , dateutils, sysutils;

Procedure MakeQryParts(QryParts:TERPQuery; TempTablename:String; BasesonitemIndex:Integer = -1; classId :Integer =-1; PreferredSupp:String ='');

  Function IsBasedonitemSelected(ItemIndex :Integer):Boolean;
  begin
    result := (BasesonitemIndex = -1) or (BasesonitemIndex = ItemIndex);
  end;

begin
            closedb(qryParts);
            qryParts.sQl.clear;
            qryParts.sQl.add('Select ');
            qryParts.sQl.add('PC.ProductID as ProductId,');
            qryParts.sQl.add('if(ifnull(PT.proctreeId,0)=0 , "F" , "T") as IsBOM,');
            qryParts.sQl.add('P.PREFEREDSUPP as PREFEREDSUPP,');
            qryParts.sQl.add('P.PURCHTAXCODE as PURCHTAXCODE,');
            qryParts.sQl.add('PC.ClassID as ClassID,');
            qryParts.sQl.add('if(ifnull(R.PointId,0)<>0 and PC.Useproductforecastformula="T" , R.ReorderAmount ,  PC.ReorderAmount ) as ReorderAmount,');
            qryParts.sQl.add('if(ifnull(R.PointId,0)<>0 and PC.Useproductforecastformula="T" , R.ReOrderPoint  ,  PC.ReOrderPoint  ) as ReOrderPoint,');
            qryParts.sQl.add('if(ifnull(R.PointId,0)<>0 and PC.Useproductforecastformula="T" , R.PreferredLevel,  PC.PreferredLevel) as PreferredLevel,');
            qryParts.sQl.add('PC.Useproductforecastformula as Useproductforecastformula , ');

            if IsBasedonitemSelected(0) then
              qryParts.sQl.add(        ProductQtylib.SQL4Qty(tInstock   )+
              ' as Qty1,');
            if IsBasedonitemSelected(1) then
              qryParts.sQl.add(        ProductQtylib.SQL4Qty(tAvailable )+
              '+' + ProductQtylib.SQL4Qty(tpobo) +
              ' as qty2,');
            if IsBasedonitemSelected(2) then
              qryParts.sQl.add('(' +   ProductQtylib.SQL4Qty(tAvailable )+
              '-' + ProductQtylib.SQL4Qty(tSOBO ) +') +' + ProductQtylib.SQL4Qty(tpobo) +
              ' as qty3,');
            if IsBasedonitemSelected(3) then
              qryParts.sQl.add('((' +  ProductQtylib.SQL4Qty(tInstock   )+') + '+
              ' ( ' +ProductQtylib.SQL4Qty(tBuilding,  'PQA' , 'if(S.IsInternalOrder="T" , PQA.Qty , 0)' )+') +'+
              ' ( ' +ProductQtylib.SQL4Qty(tSOBO    ,  'PQA' , 'if(S.IsInternalOrder="T" , PQA.Qty , 0)' )+'))'+
              '  as qty4,');
            if IsBasedonitemSelected(4) then
              qryParts.sQl.add(        ProductQtylib.SQL4Qty(tAvailable )+
              '+' + ProductQtylib.SQL4Qty(tpobo) +
              ' + ' +ProductQtylib.SQL4Qty(tBuilding,  'PQA' , 'if(S.IsInternalOrder="T" , PQA.Qty , 0)' )+  //') '+
//              ' ( ' +ProductQtylib.SQL4Qty(tSO    ,  'PQA' , 'if(S.IsInternalOrder="T" , PQA.Qty , 0)' )+'))'+
              '  as qty5,');

            qryParts.sQl.add(' PC.Productname , ');
            qryParts.sQl.add(' PC.ClassName ,');
            qryParts.sQl.add(' "F" as Done');

            qryParts.sQl.add(' FROM ' + ProductQtylib.ProductTables(tProductList));
            if TempTablename <> '' then  qryParts.sQl.add(' inner join ' + TempTableName + ' as TT on P.PartsID = TT.PartsID');
            qryParts.sQl.add(' Left join tblProctree PT on PT.masterId =P.PartsID  and PT.mastertype = "mtProduct"  and ifnull(PT.treerootId,0) = ifnull(PT.proctreeId,0)');
            qryParts.sQl.add(' left join tblReorderPoints R on R.ClassId = PC.ClassId and R.ProductId=PC.ProductId and  R.OrderMonth = "' + csMonths[MonthOf(Today())-1] + '"');
            if IsBasedonitemSelected(3) or IsBasedonitemSelected(4) then qryParts.sQl.add(' left join tblsales S on S.IsSalesOrder = "T" and S.IsInternalOrder = "T" and S.SaleID = PQA.TransID');

            qryParts.sQl.add(' WHERE P.Active="T" and ifnull(P.Discontinued, "F") = "F" ');
            if TempTablename <> '' then  else qryParts.sQl.add(' AND P.AutoReorder = "T" ');
            if classID >0 then qryParts.sQl.add(' AND PC.ClassID = ' + IntToStr(classId) );
            if PreferredSupp <> '' then  qryParts.sQl.add(' AND P.PreferedSupp = ' + QuotedStr(PreferredSupp) );
            qryParts.sQl.add(' group by  PC.ProductID, PC.ClassID ' );



            clog(qryParts.SQL.Text);

end;

end.
