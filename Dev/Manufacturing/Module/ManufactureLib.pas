unit ManufactureLib;

interface

uses ERPdbComponents,  BusObjNDSBase, classes, UserLockObj;

type
  TGoodRecdStatus = (grsunknown =0,grsNotOrdered=1, grsPartial=2,grsFull =3, grsNone=4);

  function GoodsOnOrderstatus(ParentID:Integer; connection:TERPConnection): String;Overload;
  function SQLToupdateOrderQtys(temptablename:String; SmartOrderQty, POshippedQty, POBackorderQty:String;UOMQty:boolean):String;
  procedure setGoodsOrderstatus(const Value: TGoodRecdStatus);
  Function IsWorkingday(Const aDate:Tdatetime):boolean;
  Function IsWeekendday(const Dayno:Integer):boolean;
  function DeleteCleanTree(Obj :TBusObjNDS): Boolean;
  function MakeCleanTree(Obj :TBusObjNDS): Boolean;
  function MakeCleanTreeCallback(Obj :TBusObjNDS;St:TStringList; tablename :string): Boolean;
  Procedure ChecknUpdateInTreeNodesSelected(tablename, checksttausfield :String; connection:TERPConnection = nil);
  Function LockCapacityplanner(UserLock:TUSerLock; LockGroup:String; description:String; ContinueRO:Boolean = True):boolean;
  function ProductJobDEtailsSQL(const fsTablename:sTring; const SaleLineID, ProductID:Integer; const LineQty :double):String;
  Procedure MakeBOMPickingtable(const SalelineIDs:String; tablename:String);
  function salesPrintTreeSQLWithNodeSelected(Tablename, strSQL:String):String;
  Function Leaves(Quoted:Boolean) :String;
  Function BOMTreeFlat(const Datefrom , DateTo:TDateTime ; Tablename:String; datefilterfield:String; ExtraWhere:String=''):String;
  Function LvlNo(const Value:Integer):String;

  (*Function ProctreeIDforprocesstimeID(Const ProcesstimeID:Integer):Integer;*)


implementation

uses CommonDbLib, sysutils, CommonLib, AppEnvironment, BusObjProcPrefs,DateUtils,
  BusObjProcess , TypInfo , Variants, MySQLConst , progressdialog,
  tcConst, dialogs, db, ProductQtyLib, SystemLib, DbSharedObjectsObj,
  tcDataUtils, Barcodeconst;

var
 fGoodsOrderstatus : TGoodRecdStatus;

function SQLToupdateOrderQtys(temptablename:String; SmartOrderQty, POshippedQty, POBackorderQty:String;UOMQty:boolean):String;
var
  st:TStringlist;
begin
  st:= TStringlist.Create;
  try
  {SmartOrderQty}
    St.add('ALTER TABLE ' +temptablename + ' ADD COLUMN ETADate DateTime default NULL;');
    St.add('Drop table if exists '+temptablename +'1;');
    St.add('Create table '+temptablename +'1 Select t.ProctreeId , ');
    if UOMQty then st.add('Sum(SOL.UnitofMeasureQty) Qty   ') else st.add('Sum(SOL.Qty) Qty   ');
    st.add(' from tblsmartOrderlines SOL   ');
    st.add(' inner join '+temptablename +' t on  SOL.ProctreeId   = T.ProctreeId group by t.ProctreeId ;');

    St.add('Alter table '+temptablename +'1 add index  ProctreeID (ProctreeID);');
    St.add('update '+temptablename +' t inner join '+temptablename +'1 T1 on T.procTreeID = T1.proctreeID Set T.' + SmartOrderQty +' = T1.Qty;');

    {POshippedQty}
    St.add('Truncate '+temptablename +'1;');
    St.add('insert into '+temptablename +'1 Select T.ProctreeId , ');
    if UOMQty then St.add('sum(POL.UnitofMeasureShipped)  Qty   ') else St.add('sum(POL.shipped)  Qty   ');
    St.add('from tblPurchaseLines POL    ');
    St.add('inner join tblsmartOrderlines SOL on POL.smartorderlineID =SOL.SmartOrderLinesID    ');
    St.add('inner join '+temptablename +' t on  SOL.ProctreeId   = T.ProctreeId     ');
    St.add('group by t.ProctreeID;');
    St.add('update '+temptablename +' t inner join '+temptablename +'1 T1 on T.procTreeID = T1.proctreeID Set T.' + POshippedQty +' = T1.Qty;');

    {POBackorderQty}
    St.add('Truncate '+temptablename +'1;');
    St.add('Alter table '+temptablename +'1 ADD COLUMN ETADate DateTime default NULL;');
    St.add('insert into '+temptablename +'1 Select T.ProctreeId , ');
    if UOMQty then St.add('sum(if(ifnull(POL.shipped,0) = 0 , POL.UnitofMeasureBackorder, 0))  Qty   ') else St.add('sum(if(ifnull(POL.shipped,0) = 0 , POL.Backorder, 0))  Qty  ');
    St.add(', min(ifnull(POL.ETADate, ifnull(PO.ETADate,0))) as ETADate  ');
    St.add('from tblPurchaseLines POL    ');
    St.add('inner join  tblpurchaseorders PO on POL.purchaseorderID = PO.purchaseorderID    ');
    St.add('inner join tblsmartOrderlines SOL on POL.smartorderlineID =SOL.SmartOrderLinesID   ');
    St.add('inner join '+temptablename +' t on  SOL.ProctreeId   = T.ProctreeId    ');
    st.Add('where ifnull(POL.shipped,0)=0 ' );
    St.add('group by t.ProctreeID;');
    St.add('update '+temptablename +' t inner join '+temptablename +'1 T1 on T.procTreeID = T1.proctreeID Set T.'+POBackorderQty+' = T1.Qty , T.ETADAte = T1.ETADAte;');
    St.add('Drop table if exists '+temptablename +'1;');
    REsult := st.Text;
  finally
    freeandnil(st);
  end;
end;
function GoodsOnOrderstatus(ParentID:Integer; connection:TERPConnection): String;
var
  QRY:TERPQuery;
  fdOnOrderQty,  fdSOQty,  fdshipped,  fdBackorder:Double;
  Tablename :String;
  //iResult:Integer;
begin
  SetGoodsOrderstatus(grsUnknown);
  Result := '';
  Tablename := commondbLib.GetUserTemporaryTableName('GoodsOnOrderstatus');
  With CommonDbLib.TempMyScript do try
    {proctreenodes of the parent}
    SQL.Add('Drop table if exists '+Tablename +';');
    SQL.Add('  CREATE TABLE '+Tablename + ' (');
    SQL.Add('  ParentId     int(11) NULL DEFAULT NULL ,');
    SQL.Add('  ProctreeID   int(11) NULL DEFAULT 0    ,');
    SQL.Add('  OnOrderQty   double  NULL DEFAULT NULL ,');
    SQL.Add('  SOQty        Double  NULL DEFAULT 0.0  ,');
    SQL.Add('  shipped      Double  NULL DEFAULT 0.0  ,');
    SQL.Add('  backorder    Double  NULL DEFAULT 0.0  ,');
//    SQL.Add('  ETADate      datetime     DEFAULT NULL ,');
    SQL.Add('  KEY ProctreeID (ProctreeID)');
    SQL.Add(') ENGINE=MyISAM DEFAULT CHARSET=utf8;');

    SQL.Add('insert into  '+Tablename +
            '(ParentId , ProctreeID  , OnOrderQty  ,SOQty , shipped, backorder)'+
            '  Select ParentId, PT.ProctreeID, PT.OnOrderQty OnOrderQty , '+
            ' 0.0 as SOQty, 0.0 as  shipped , 0.0 as backorder   '+
            ' From tblproctree PT   where ParentId = ' +inttostr(ParentId) +'  '+
            ' group by parentId, PT.ProctreeID order by PT.SequenceDown;');
//    SQL.Add('Alter table '+Tablename +' add index  ProctreeID (ProctreeID);');

    SQL.Add(SQLToUpdateOrderQtys(Tablename , 'SOQty' , 'Shipped' , 'Backorder' , false));
    Execute;

  finally
    Free;
  end;
  QRY:=TempMyQuery;//(connection);
  try
    (* QRY.SQL.add(' Select  ');
    QRY.SQL.add(' Sum(PT.OnOrderQty) OnOrderQty,');
    QRY.SQL.add(' Sum(SOL.Qty) SOQty ,');
    QRY.SQL.add(' Sum(POL.shipped)  shipped,');
    QRY.SQL.add(' Sum(if(ifnull(POL.shipped,0) = 0 , POL.Backorder, 0)) Backorder');
    QRY.SQL.add(' From tblproctree PT');
    QRY.SQL.add(' Left join tblSmartOrderLines SOL on PT.ProcTreeId = SOL.ProcTreeId');
    QRY.SQL.add(' left join tblPurchaseLines POL on POL.smartorderlineID =SOL.SmartOrderLinesID');
    QRY.SQL.add(' Where PT.ParentId in (' +inttostr(ParentId) +' )');
    QRY.SQL.add(' order by PT.SequenceDown'); *)
    (*QRY.SQL.add('   Select');
    QRY.SQL.add(' ParentId,');
    QRY.SQL.add(' PT.ProctreeID,');
    QRY.SQL.add(' PT.OnOrderQty OnOrderQty,');
    QRY.SQL.add(' (Select Sum(Qty) from tblsmartOrderlines where ProctreeId = Pt.ProctreeId)  SOQty,');
    QRY.SQL.add(' (Select sum(shipped) from tblPurchaseLines POL where  POL.smartorderlineID =SOL.SmartOrderLinesID) shipped,');
    QRY.SQL.add(' (Select sum(if(ifnull(POL.shipped,0) = 0 , POL.Backorder, 0)) from tblPurchaseLines POL where POL.smartorderlineID =SOL.SmartOrderLinesID) backorder');
    QRY.SQL.add(' From tblproctree PT');
    QRY.SQL.add(' Left join tblSmartOrderLines SOL on PT.ProcTreeId = SOL.ProcTreeId');
    QRY.SQL.add(' left join tblPurchaseLines POL on POL.smartorderlineID =SOL.SmartOrderLinesID');
    QRY.SQL.add(' where parentId in (' +inttostr(ParentId) +' )');
    QRY.SQL.add(' group by parentId, PT.ProctreeID');
    QRY.SQL.add(' order by PT.SequenceDown');*)
    Qry.SQL.Add('Select * from ' + Tablename  );
    QRY.Open;

    fGoodsOrderstatus := grsUnknown;
    fdOnOrderQty      := 0;
    fdSOQty           := 0;
    fdshipped         := 0;
    fdBackorder       := 0;

    if Qry.RecordCount>0 then begin
      Qry.First;
      while Qry.Eof = False do begin
        fdOnOrderQty  := fdOnOrderQty + Qry.fieldbyname('OnorderQty').asFloat ;
        fdSOQty       := fdSOQty      + Qry.fieldbyname('SOQty').asFloat ;
        fdshipped     := fdshipped    + Qry.fieldbyname('shipped').asFloat ;
        fdBackorder   := fdBackorder  + Qry.fieldbyname('Backorder').asFloat ;
        Qry.Next;
      end;
    end;
  finally
    Qry.ClosenFree;
    commondblib.DestroyUserTemporaryTable(Tablename);
  end;

  if fdOnorderQty <> 0 then begin
         if fdSOQty =0                                                          then setGoodsOrderstatus(grsNotOrdered)
    else if fdOnorderQty <= fdShipped                                           then setGoodsOrderstatus(grsFull)
    else if (fdBackorder <> 0) and (fdShipped<>0)                               then setGoodsOrderstatus(grsPartial)
    else if (fdShipped=0)                                                       then setGoodsOrderstatus(grsnone)
    else if (fdBackorder = 0) and (fdShipped<>0) and (fdOnorderQty = fdShipped) then setGoodsOrderstatus(grsFull)
    else if (fdShipped<>0)                                                      then setGoodsOrderstatus(grsPartial);
  end;

       if fGoodsOrderstatus = grsUnknown    then result := ''
  else if fGoodsOrderStatus = grsNotOrdered then result := 'Not Ordered'
  else if fGoodsOrderstatus = grsPartial    then Result := 'Partially Recd'
  else if fGoodsOrderstatus = grsFull       then Result := 'Recd'
  else if fGoodsOrderstatus = grsNone       then Result := 'Not Received';

end;

procedure setGoodsOrderstatus(const Value: TGoodRecdStatus);
begin
  if (fGoodsOrderstatus = grsPartial) or (fGoodsOrderstatus = Value) or (Value = grsUnknown ) then exit;
       if (fGoodsOrderstatus = grsUnknown) then fGoodsOrderstatus := Value
  else if (Value = grsPartial)              then fGoodsOrderstatus := Value
  else fGoodsOrderstatus :=grsPartial;
end;
Function IsWeekendday(const Dayno:Integer):boolean;
var
  ctr:Integer;
  xDayno:Integer;
begin
  REsult := False;
  for ctr:= 1 to Appenv.companyprefs.NoofWeekendDays do begin
    xDayno := Skipdays(Appenv.companyprefs.StartWorkWeekDay , 0-ctr);
         If (Dayno = xDayno)   then begin Result := true;Exit;
    end else if (Dayno = xDayno)  then begin Result := true; exit;
    end;
  end;
end;
Function IsWorkingday(Const aDate:Tdatetime):boolean;
var
  ctr:Integer;
  Dayno, xDayno:Integer;
begin
  REsult := True;
  Dayno :=DayOftheWeek(aDate);
  for ctr:= 1 to Appenv.companyprefs.NoofWeekendDays do begin
    xDayno := Skipdays(Appenv.companyprefs.StartWorkWeekDay , 0-ctr);
         If (Dayno = xDayno)   and not(ProcPrefs.ScheduleProductionOnWeekendDays) then begin Result := False;Exit;
    end else if (Dayno = xDayno) and not(ProcPrefs.ScheduleProductionOnWeekendDays) then begin Result := False; exit;
    end;
  end;

end;




function DeleteCleanTree(Obj :TBusObjNDS): Boolean;
var
  //st:TStringList;
  s:String;
begin
  REsult := TRue;
  if not(obj is Tproctreenode ) then exit;

  With TempMyQuery(obj.Storer.Connection) do try
     SQL.add('Select ProctreeId from tblProcTreeClean where masterId = ' +inttostr(Tproctreenode(Obj).masterID));
     Open;
     s:= groupConcat('ProctreeId');
     if s='' then exit;
   finally
     ClosenFree;
   end;
   DeleteallusingDs('Select * from  tblprocesspartClean where proctreeId in (' + s +');'  ,obj.Storer.Connection );
   DeleteallusingDs('Select * from  tblProcTreeClean where proctreeId in (' + s +');'     ,obj.Storer.Connection );

  (*st:= TStringlist.Create;
  try
     With TempMyQuery(obj.Storer.Connection) do try
       SQL.add('Select ProctreeId from tblProcTreeClean where masterId = ' +inttostr(Tproctreenode(Obj).masterID));
       Open;
       s:= groupConcat('ProctreeId');
       if s='' then exit;
       st.Add('delete from  tblprocesspartClean where proctreeId in (' + s +');');
       st.Add('delete from  tblProcTreeClean where proctreeId in (' + s +');');
     finally
       ClosenFree;
     end;

    if st.Count>0 then begin
      with TempMyScript(obj.Storer.Connection ) do try
        SQL.Add(st.Text);
        try
          Execute;
        except
          on e: exception do begin
            sleep(15000);
            Execute;
          end;
        end;

      finally
        Free;
      end;
    end;
  finally
    FreeandNil(st);
  end;*)
end;
(*function DeleteCleanTreeCallback(Obj :TBusObjNDS;St:TStringList; tablename :string): Boolean;
var
  x:Integer;
begin
  st.Add( 'delete from ' + tablename +' where ' +Obj.IDFieldName +' = ' + inttostr(Obj.Id)+';');
    if obj is Tproctreenode  then begin
      if Tproctreenode(obj).ProcessStepList.Count>0 then
        for x:= 0 to Tproctreenode(obj).ProcessStepList.Count -1 do begin
          DeleteCleanTreeCallback(Tproctreenode(obj).ProcessStepList[x] , St , 'tblprocesspartClean');
        end;
      for x:= 0 to Tproctreenode(obj).Children.Count -1 do
        if Tproctreenode(obj).Children[x] is Tproctreenode then
          DeleteCleanTreeCallback(Tproctreenode(obj).Children[x] , st , tablename);
    end;
  result := TRue;
end;*)

function MakeCleanTree(Obj :TBusObjNDS): Boolean;
var
  st:TStringList;
begin
  ST:= TStringlist.Create;
  try
    MakeCleanTreeCallback(obj, St , 'tblProcTreeClean');
    if st.Count>0 then begin
      with TempMyScript(obj.Storer.Connection ) do try
        SQL.Add(st.Text);
        Execute;
      finally
        Free;
      end;
    end;
  finally
    Freeandnil(St);
  end;
  REsult := TRue;
end;

function MakeCleanTreeCallback(Obj :TBusObjNDS;St:TStringList; tablename :string): Boolean;
var
  PropList: PPropList;
  count, x :Integer;
  val: Variant;
  valStr: string;
  QuoteValue: boolean;
  s:String;
begin
    REsult := true;
    Count := GetPropList(obj.ClassInfo, PropList);
    s:= '';
    for x:= 0 to Count -1 do begin
      QuoteValue:= true;
      if (String(PropList[x].Name) = 'Name') or (String(PropList[x].Name) = 'Tag') or (PropList[x].SetProc = nil) then
        Continue;
      val:= GetPropValue(obj, String(PropList[x].Name));
      if (not VarIsNull(val)) then begin
        if {VarIsType(val, varDate) or} (PropList[x].PropType^ = TypeInfo(TDateTime)) then
          valStr:= FormatDateTime(MysqlDateTimeFormat, val)
        else begin
          if VarIsType(val, varDouble) then
            QuoteValue:= false;

          if PropList[x].PropType^.Kind = tkEnumeration then begin
            if Val = 'True' then ValStr:= 'T'
            else if Val = 'False' then ValStr:= 'F'
            else ValStr:= val;
          end
          else
            valStr:= val;
        end;

        if s <> '' then s:= s + ', ';
        if Sametext(String(PropList[x].Name) , 'ID') then
             s:= s + '`' +obj.idfieldname +'` = '+ valStr
        else if QuoteValue then
          s:= s + '`' + String(PropList[x].Name) + '` = ' + QuotedStr(valStr)
        else
          s:= s + '`' + String(PropList[x].Name) + '` = ' + valStr;
      end;
    end;

    if s <> '' then begin
        s:= 'INSERT IGNORE INTO `' + tablename +'` SET ' + s+';';
        st.Add(s);
        s:= '';
    end;

    if obj is Tproctreenode  then   begin
      if Tproctreenode(obj).ProcessStepList.Count>0 then
        for x:= 0 to Tproctreenode(obj).ProcessStepList.Count -1 do begin
          MakeCleanTreeCallback(Tproctreenode(obj).ProcessStepList[x] , St , 'tblprocesspartClean');
        end;
      for x:= 0 to Tproctreenode(obj).Children.Count -1 do
        if Tproctreenode(obj).Children[x] is Tproctreenode then
          MakeCleanTreeCallback(Tproctreenode(obj).Children[x] , st , tablename);
    end;
end;
(*Function ProctreeIDforprocesstimeID(Const ProcesstimeID:Integer):Integer;
begin
   With TempMyquery do try
      sql.Add('Select PT.proctreeID ' +
              ' From tblProcesstime PPT ' +
              ' inner join tblProcessPart PP on PPT.ProcessPartID = PP.ID ' +
              ' inner join  tblProcTree PT on PT.ProctreeId = PP.proctreeID ' +
              ' where PPT.ProcessTimeID = '+ INTTOSTR(ProcesstimeID));
      open;
   finally
     ClosenFree;
   end;
end;*)
function salesPrintTreeSQLWithNodeSelected(Tablename, strSQL:String):String;
begin
  With TempMyScript do try
    SQL.Add(' drop table if exists ' + tablename+';' );
    SQL.Add(' Create table  ' + tablename+' ' + strSQL+';' );
    SQL.Add('Alter table ' +tablename +' add column nodeselected Enum("T","F") default "F";');
//    SQL.Savetofile('c:\temp\temp.sql');
    Execute;
  finally
    Free;
  end;

  ChecknUpdateInTreeNodesSelected(Tablename  , 'nodeselected');
  Result := 'Select * from ' + tablename +' where nodeselected ="T"';
end;

Procedure ChecknUpdateInTreeNodesSelected(tablename, checksttausfield :String; connection:TERPConnection = nil);
var
  s:String;
  Qry:TERPQuery;
  flag:Boolean;
  SelectedIDs, notSelectedIDs:String;
begin
  DoShowProgressbar(10, 'This may take few minutes - started at :' + formatDateTime('hh:nn am/pm' , now)+'. ' + WAITMSG  , '' , False );
  try
    Qry:=  TempMyquery(connection);
    try
        {all rootnodes are selected}
        Qry.SQL.Add('Select distinct  ProctreeId from  '+tablename +'  where ifnull(parentID,0)=0;');
        Qry.open;
        if Qry.recordcount =0 then exit;
        s:= Qry.groupconcat('ProctreeId');
        if s <> '' then
          executeSQL('update ' +tablename +' set ' + checksttausfield +' = "T" where proctreeId in (' + s+');' , connection );

        SelectedIDs := s;
        notSelectedIDs:='';
        Flag:= True;
        While Flag do begin

          {all children of all levels of an unselected node is not selected}
          if notSelectedIDs <> '' then begin
            closedb(Qry);
            Qry.SQL.Clear;
            Qry.SQL.Add('Select distinct  T.ProctreeId from ' + Tablename +'   T ' +
                        ' where ifnull(T.ParentID,0) in (' +  notSelectedIDs +' ); ');
            Qry.Open;
            notSelectedIDs := Qry.GroupConcat('ProctreeId');
          end;


          if SelectedIDs <> '' then begin
            {if parent is option, then look for current node's selected, otherwise they are selected}
            closedb(Qry);
            Qry.SQL.Clear;
            Qry.SQL.Add('Select distinct  T.ProctreeId from ' + Tablename +'   P ' +
                        ' inner join ' + Tablename +'   T on T.parentId = P.proctreeID ' +
                        ' where ifnull(P.proctreeID,0) in (' +  SelectedIDs +' ) and if(P.nodeSelected="F" , "F" , if(P.inputType<>"itOption" , "T" , T.Selected )) ="F"');
            Qry.Open;
            if Qry.recordcount>0 then begin
              if notSelectedIDs <> '' then notSelectedIDs := notSelectedIDs +',' ;
              notSelectedIDs := notSelectedIDs + Qry.GroupConcat('ProctreeId');
            end;

            closedb(Qry);
            Qry.SQL.Clear;
            Qry.SQL.Add('Select distinct  T.ProctreeId from ' + Tablename +'   P ' +
                        ' inner join ' + Tablename +'   T on T.parentId = P.proctreeID ' +
                        ' where ifnull(P.proctreeID,0) in (' +  SelectedIDs +' ) and if(P.nodeSelected="F" , "F" , if(P.inputType<>"itOption" , "T" , T.Selected )) ="T"');
            Qry.Open;
            SelectedIDs := Qry.GroupConcat('ProctreeId');
          end;
          s:= '';
          if SelectedIDs <> '' then
            s:= 'update ' +tablename +' set ' + checksttausfield +' = "T" where proctreeId in (' + SelectedIDs+');';
          if notSelectedIDs <> '' then
            s:=s+  'update ' +tablename +' set ' + checksttausfield +' = "F" where proctreeId in (' + notSelectedIDs+');';
          DoStepProgressbar;
          if s<> '' then
            ExecuteSQL(s , connection)
          else Flag := False;
        end;
    finally
      Qry.ClosenFree;
    end;
  finally
    DoHideProgressbar;
  end;
end;

Function LockCapacityplanner(UserLock:TUSerLock; LockGroup:String; description:String; ContinueRO:Boolean = True):boolean;
function FormatLockMsg(Const Msg:String):String;
begin
  result:=Msg;
  result:= replacestr(Result , 'Unable to update data.'  + #13#10, 'Unable to ' + description+'.' + #13#10);
  //result:= replacestr(Result , ' with: ' +'Capacity Planning' , '');
  result:= replacestr(Result , 'this record' , Quotedstr('Capacity Planning'));
  result:= replacestr(Result , 'Record' ,Quotedstr('Capacity Planning'));
  result:= replacestr(Result ,  '(Whole Table Locked)' , '');
  //result:= replacestr(Result ,  Quotedstr('Capacity Planning') ,Quotedstr('Related Tables') );
  result:=  StringReplace(result, Quotedstr('Capacity Planning') , Quotedstr('Related Tables'),[rfIgnoreCase]);
  result:=  StringReplace(result, Quotedstr('Capacity Planning') , 'Module' ,[rfIgnoreCase]);
  if ContinueRO   then
    REsult:= Result + NL+NL+ 'Access will be changed to read-only.';
end;
begin
  result:= true;
  Userlock.Enabled := True;
  if not Userlock.Lock('Capacity Planning' , 0 , LockGroup) then begin
    result:= False;
    CommonLib.MessageDlgXP_Vista(FormatLockMsg(Userlock.lockMessage)  , mtWarning, [mbOK], 0);
  end;
end;

function ProductJobDEtailsSQL(const fsTablename:sTring; const SaleLineID, ProductID:Integer; const LineQty :double):String;
var
  StrSQL:String;
  QryProcess:TERPQuery;
  totQty:double;
  bm:TBookmark;
  function TotalQty:Double;
  begin
      if QryProcess.Locate('ProcTreeId' , QryProcess.fieldByname('ParentId').asInteger , []) then
        result := QryProcess.fieldByname('TotalQty').asfloat
      else Result := LineQty;
  end;

begin
  StrSQL := 'Drop table if exists ' + fsTablename +';' +
          ' Create table ' + fsTablename +
          ' SELECT   sl.saleId, sl.SaleLineId, pt.partsID,  ptd.ProcTreeId , ptd.ParentId,ptd.SequenceDown , PT.Complete ,' +

          ' ifnull((Select group_concat(distinct ppd.Status) from tblProcTree spt ' +
          ' Inner JOIN tblProcessPart PPd on PPd.ProcTreeId = spt.ProcTreeId ' +
          ' where  spt.MasterId = sl.SaleLineId and spt.MasterType = "mtSalesOrder" and spt.proctreeId = Ptd.proctreeId ),"From Stock")  as Status , ' +

          ' ifnull((Select group_concat(distinct ppd.ProcessStepExtraInfo) from tblProcTree spt ' +
          ' Inner JOIN tblProcessPart PPd on PPd.ProcTreeId = spt.ProcTreeId ' +
          ' where  spt.MasterId = sl.SaleLineId and spt.MasterType = "mtSalesOrder" and spt.proctreeId = Ptd.proctreeId ),"")  as ProcessStepExtraInfo , ' +

          ' ifnull((Select group_concat(distinct Ps.Description) from tblProcTree spt ' +
          ' Inner JOIN tblProcessPart PPd on PPd.ProcTreeId = spt.ProcTreeId ' +
          ' Left join tblProcessStep ps on PPD.ProcessStepId = PS.ID ' +
          ' where  spt.MasterId = sl.SaleLineId and spt.MasterType = "mtSalesOrder" and spt.proctreeId = Ptd.proctreeId ),"")  as ProcessSteps, ' +


          ' Convert(TreeNodeCaption(PT.Level, PT.caption ) ,char(255)) as Productname,' +
          ' ptd.description as Itemdescription, ' +
          ' ptd.Quantity, P.ProductionNotes ,  P.GeneralNotes   , ' +
          ' PtdP.PREFEREDSUPP ,  ' +
          '  ptd.totalQty as TotalQty ,  ' +
          '  ptd.treePartUOMtotalQty as UOMTotalQty ,  ' +
          '  ptd.inputtype, ptd.Selected,'+
          ' ptd.treepartuommultiplier as Multiplier, '+
          ' concat(ptd.treepartuom," (" , ptd.treepartuommultiplier,  ")") as uom,' +
          ' space(100) as Description,' +
          ' S.Comments as Salescomments, '+
          ' S.PickMemo as PickingInstructions, ' +
          ' SL.Product_Description as Product_Description, '+
          ' SL.Product_Description_memo as Product_Description_memo, '+
          ' space(100) as uomDescription, PT.info productiondesc , ptd.info linedesc, '+
          ' PtdP.PARTSDESCRIPTION as ProductDescription, ' +
          ' Ptd.Info as Info, ' +
          ' ptdPS.ExtraInfo as ProcessDetail, ' +
          ' concat(' +quotedstr(Barcode_Prefix_Proctree)+',"-",ptd.proctreeID) as Barcode_Proctree ' +
          ' FROM tblSales s' +
          ' inner join  tblSalesLines sl on sl.SaleId = s.SaleId' +
          ' Inner join  tblProcTree pt on pt.MasterId = sl.SaleLineId and PT.ParentId = 0 and pt.MasterType = "mtSalesOrder"' +
          ' inner join  tblProcTree ptd on ptd.MasterId = sl.SaleLineId  and ptd.MasterType = "mtSalesOrder"  and ptd.Quantity <> 0' +
          ' Left join tblParts PtdP on PtdP.PartsId = ptd.PartsId' +
          ' inner join tblParts P on P.PartsId = Sl.ProductID' +
          ' Inner join tblparttypes PAT on PAT.typeCode = P.PartType' +
          ' Left Join tblprocesspart ptdPP on ptd.ProcTreeId = ptdPP.ProcTreeID' +
          ' Left Join tblprocessstep ptdPS on ptdPP.ProcessStepID = ptdPS.ID' +
          ' Where SL.SaleLineId = ' +IntToStr(SaleLineID) +
          ' order by ptd.SequenceDown; ' +
          'ALTER TABLE '+fstablename+'   ADD COLUMN ID INT(11) NOT NULL AUTO_INCREMENT FIRST,   ADD PRIMARY KEY (ID);'+
          'ALTER TABLE '+fstablename+'   ADD COLUMN nodeselected Enum("T","F") Default "F";';
  ExecuteSQL(strSQL);
  ChecknUpdateInTreeNodesSelected(fstablename  , 'nodeselected');
  strSQL:= 'update  '+fstablename+'   Set TotalQty = if( nodeselected="T", TotalQty , 0);';
  strSQL:= 'update  '+fstablename+'   Set UOMTotalQty = if( nodeselected="T", UOMTotalQty , 0);';
  strSQL:= 'update  '+fstablename+'   Set Quantity = if( nodeselected="T", Quantity , 0);';
  ExecuteSQL(strSQL);

  QryProcess:= CommonDbLib.TempMyQuery;
  Try
    QryProcess.SQL.add('select * from ' +fsTablename +' order by SequenceDown');
    QryProcess.open;
    if QryProcess.recordcount > 0 then begin
        QryProcess.First;
        While QryProcess.Eof = False do begin
          bm := QryProcess.GetBookmark;
          try
            totQty :=TotalQty;
          finally
              QryProcess.GotoBookmark(bm);
              QryProcess.FreeBookmark(bm);
          end;
          EditDB(QryProcess);
          (*QryProcess.FieldByName('Quantity').asFloat    := totQty *QryProcess.FieldByName('Quantity').asFloat;*)
          (*QryProcess.FieldByName('UOMQuantity').asFloat := divzer( QryProcess.FieldByName('Quantity').asFloat , QryProcess.FieldByName('Multiplier').asFloat);*)

          QryProcess.FieldByName('Description').asString    := FloatToStrF(QryProcess.FieldByName('Quantity').asFloat    , ffnumber ,15,5 ) +' X ' + FloatToStrF(totQty , ffnumber ,15,5 );
          QryProcess.FieldByName('UOMDescription').asString := FloatToStrF(DivZer(QryProcess.FieldByName('Quantity').asFloat , QryProcess.FieldByName('Multiplier').asFloat) , ffnumber ,15,5 )+ ' ' + QryProcess.FieldByName('uom').asString  +' X ' + FloatToStrF(totQty  , ffnumber ,15,5 );
          PostDB(QryProcess);
          QryProcess.Next;
        end;
    end;
  finally
      if QryProcess.active then QryProcess.close;      FreeandNil(QryProcess);
  end;

  {Report SQL}
  strSQL:= '{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, ' +
          ' CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, ' +
          ' Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO' ;
  strSQL:= strSQL+ ' ~|||~{Details} '+
          ' Select T.* , PP.partPic , P.partname, PT.Quantity , PT.TotalQty , TreeNodeCaption(PT.Level, PT.Caption) TreeCaption '+
          ' from ' + fstablename +' T '+
          ' inner join tblproctree PT on PT.proctreeId = T.proctreeId  	'+
          ' Left join tblParts P on P.partsId = PT.PartsId 	'+
          ' Left  join tblpartspics PP on P.partsID = PP.partID and PP.isDefault ="T"  	'+
          ' where T.PArentID <>0; ';
  strSQL:= strSQL+ ' ~|||~{Manufacture}' +
          ' SELECT  concat(UnitofMeasureSaleLines , " (" , UnitofMeasureMultiplier , ")") as SalesUOM,' +
          ' PAT.typeDESC as PartType, s.SaleId, s.InvoiceDocNumber as SaleDocNumber, ' +
          ' s.CustomerName as SaleCustomerName, s.ClassId as SaleClassId, ' +
          ' s.ShipDate as SaleShipDate, s.SaleDate,S.ShipTo , s.InvoiceTo, ' +
          ' S.PickupFrom, sl.SaleLineId, sl.ProductName as LineProductName, ' +
          ' sl.Product_Description as LineProductDescription, ' +
          ' sl.UnitOfMeasureShipped as LineQty, sl.ShipDate as LineShipDate,' +
          ' P.ProductionNotes ,  P.GeneralNotes' +
          ' FROM tblSales s' +
          ' inner join  tblSalesLines sl on sl.SaleId = s.SaleId' +
          ' inner join tblParts P on P.PartsId = Sl.ProductID' +
          ' Inner join tblparttypes PAT on PAT.typeCode = P.PartType' +
          ' Where SL.SaleLineId = ' +IntToStr(SaleLineID) ;
  strSQL:= strSQL+ ' ~|||~{Notes}' +
          ' Select Notes  from tblPartsNotes PN  where PN.active = "T"' +
          ' AND PN.PartsID = ' + IntToStr(ProductID);
  strSQL:= strSQL+ ' ~|||~{Allocation}Select PBin.Binlocation, PBin.binnumber,PQABatch.Value as batchno,PQABatch.TruckLoadNo, ' +
          ' PQABatch.ExpiryDate, if(ifnull(PQASN.PQADEtailID,0)<>0 , PQASN.UOMQty ,' +
          ' if (ifnull(PQABins.PQADEtailID,0)<>0 , PQABins.UOMQty , PQABatch.UOMQty)) as Qty,' +
          ' PQASN.Value' +
          ' From  tblSaleslines SL' +
          ' inner join tblParts P  on SL.ProductId = P.PartsId' +
          ' inner join tblPQA PQA on PQa.TransId = SL.SaleId ' +
          ' and PQA.TransLineId = SL.SaleLineId and PQa.Transtype in ("TInvoiceLine" , "TSalesOrderline")' +
          ' left join tblPqaDetails PQABatch  on PQABatch.PQAId 	= PQA.PQAID and PQABatch.PQAType = "Batch"  ' +
          ' and PQABatch.Active= "T"' +
          ' left join tblPqaDetails PQABins  on PQABins.PQAId 	= PQA.PQAID' +
          ' and PQABins.PQAType = "Bin" and PQABins.Active = "T" and' +
          ' ((PQABatch.globalref = IFNULL(PQABins.ParentRef,"") and P.Batch="T"' +
          ' and P.multiplebins = "T") or (ifnull(PQABins.Parentref ,"") = "" AND P.Batch="F" and P.multiplebins = "T"))' +
          ' Left join tblProductBin PBin     on PBin.binId 	= PQABins.BinID' +
          ' left join tblPqaDetails PQASN    on (PQASN.PQAId 	= PQA.PQAID and PQASN.PQAType = "SN"   and PQASN.Active = "T"' +
          ' and ((PQABatch.globalref = IFNULL(PQASN.ParentRef,"") and P.Batch="T" and P.multiplebins = "F" and P.SNTracking = "T")' +
          ' or (PQAbins.Globalref = IFNULL(PQASn.ParentRef,"") and P.Multiplebins = "T" and P.SNTracking = "T") or' +
          ' (ifnull(PQASN.Parentref ,"") = "") and P.Batch="F" and P.Multiplebins = "F" and P.SNTracking = "T" ))' +
          ' Where SL.SaleLineId = ' +IntToStr(SaleLineId) ;
  strSQL:= strSQL+ ' ~|||~{BuildingProductDetails} '+
          ' Select T.* , PP.partPic from ' + fstablename +' T Left  join tblpartspics PP on T.partsID = PP.partID and PP.isDefault ="T" where T.PArentID =0; ';

  result:= strSQL;
end;
Procedure MakeBOMPickingtable(const SalelineIDs :String; tablename:String);
var
  s:String;
  ctr, SalelineId, ProctreeId, batchid, binsID:Integer;
  st:TStringlist;
  Serialno :String;
begin
  st:= tStringlist.create;
  try
    St.Add('Drop table if exists ' + tablename +';');
    St.Add('CREATE TABLE ' +tablename +' ('+
                '     ID                      INT(11)   NOT NULL AUTO_INCREMENT,'+
                '     SeqID                   INT(11)   NULL      DEFAULT 0,'+
                '     customername            VARCHAR(100)        DEFAULT NULL,'+
                '     saleId                  INT(11)   NULL      DEFAULT 0,'+
                '     SalelineID              INT(11)   NULL      DEFAULT 0,'+
                '     ProductName             VARCHAR(60)         DEFAULT NULL,'+
                '     PickMemo                Text, '+
                '     Product_Description     varchar(255),'+
                '     PURCHASEDESC            VARCHAR(255)        DEFAULT NULL,'+
                '     PRODUCTCODE             VARCHAR(255)        DEFAULT NULL,'+
                '     UnitofMeasureQtySold    DOUBLE    NULL      DEFAULT 0,'+
                '     UnitofMeasureShipped    DOUBLE    NULL      DEFAULT 0,'+
                '     UnitofMeasureBackorder  DOUBLE    NULL      DEFAULT 0,'+
                '     SalesUOM                VARCHAR(255)        DEFAULT NULL,'+
                '     Caption                 VARCHAR(255)        DEFAULT NULL,'+
                '     Linecaption             VARCHAR(255)        DEFAULT NULL,'+
                '     FromStockQty            DOUBLE    NULL      DEFAULT NULL,'+
                '     ManufactureQty          DOUBLE    NULL      DEFAULT NULL,'+
                '     OnOrderQty              DOUBLE    NULL      DEFAULT NULL,'+
                '     proctreeID              INT(11)   NULL      DEFAULT 0,'+
                '     partsID                 INT(11)   NULL      DEFAULT NULL,'+
                '     Sequencedown            INT(11)   NULL      DEFAULT 0,'+
                '     level                   INT(11)   NULL      DEFAULT NULL,'+
                '     parentID                INT(11)   NULL      DEFAULT NULL,'+
                '     treepartuomid           int(10)   NULL      DEFAULT NULL,'+
                '     treepartuommultiplier   DOUBLE    NULL      DEFAULT 1,'+
                '     treepartuom             VARCHAR(100) NULL   DEFAULT "Units",'+
                '     uomdetail               VARCHAR(255) NULL   DEFAULT NULL,'+
                '     ManufactureUOMQty       DOUBLE    NULL      DEFAULT NULL,'+
                '     FromStockUOMQty         DOUBLE    NULL      DEFAULT NULL,'+
                '     OnOrderUOMQty           DOUBLE    NULL      DEFAULT NULL,'+
                '     batchno                 VARCHAR(100) NULL   DEFAULT NULL,'+
                '     TruckLoadNo             VARCHAR(10)  NULL   DEFAULT NULL,'+
                '     Expirydate              DATETIME  NULL      DEFAULT NULL,'+
                '     batchQty                DOUBLE    NULL      DEFAULT NULL,'+
                '     binlocation             VARCHAR(30)  NULL   DEFAULT NULL,'+
                '     binnumber               VARCHAR(30)  NULL   DEFAULT NULL,'+
                '     inputtype               VARCHAR(50)  NULL  DEFAULT NULL,'+
                '     nodeselected            ENUM("T","F")       DEFAULT "F" ,'+
                '     selected                ENUM("T","F")       DEFAULT "F" ,'+
                '     binQty                  DOUBLE    NULL      DEFAULT NULL,'+
                '     sno                     VARCHAR(100) DEFAULT NULL,'+
                '     HideonPickSlip          Enum("T","F") default "F" ,' +
                '     PRIMARY KEY (ID)'+
                '   ) ENGINE=MyISAM DEFAULT CHARSET=utf8;');

      s:= 'Select S.customername , SL.saleId, SL.SalelineID, SL.productname, S.PickMemo, SL.Product_Description, P.PURCHASEDESC, P.PRODUCTCODE, SL.UnitofMeasureQtySold , SL.UnitofMeasureShipped , SL.UnitofMeasureBackorder , '+
                ' concat(SL.UnitofMeasureSaleLines , " (" , SL.UnitofMeasureMultiplier , ")" ) as SalesUOM, '+
                ' PT.Caption,  concat(REPEAT("     ",level) , caption ) as Linecaption,  PT.FromStockQty, '+
                ' PT.ManufactureQty, PT.OnOrderQty , PT.proctreeID , PT.partsID, PT.Sequencedown, PT.level,PT.parentID ,   '+
                ' PT.treepartuomid , PT.treepartuommultiplier , PT.treepartuom ,  PT.selected,PT.inputType, '+
                ' concat(PT.treepartuom  , " (" , PT.treepartuommultiplier , ")") as uomdetail,   '+
                ' PT.ManufactureUOMQty , PT.FromStockUOMQty , Pt.OnOrderUOMQty , '+
                ' PQABAtch.PQAdetailID batchid, '+
                ' pqabins.PQAdetailID binsid, '+
                ' PQABAtch.value as batchno, PQABAtch.TruckLoadNo, PQABAtch.Expirydate, PQABAtch.uomQty batchQty, '+
                ' pBin.binlocation, PBin.binnumber, pqaBins.uomQty binQty, '+
                ' PQASN.value as sno , P.HideonPickSlip '+
                ' from tblsales S inner join tblsaleslines SL  on S.SaleId = SL.saleId '+
                ' inner join tblProctree PT on SL.SaleLineID = PT.masterId and PT.mastertype <> "mtProduct"  '+
                ' Left join tblproctreepart        AS PTP  on PTP.proctreeID = PT.proctreeID '+
                ' left join  (' +  AllocationTables + ') on PTP.ProcTreePartId = PQA.TransLineID  and PQA.TRanstype = "TProcTreePart"   '+
                ' where SL.SaleLineID in ( ' + SalelineIDs+ ') ' +
                ' order by Sequencedown, batchno, TruckLoadNo , expirydate, binlocation, binnumber, sno;';

       SalelineId := 0;
       ProctreeId := 0;
       batchid    := 0;
       binsID     := 0;
       With TempMyQuery do try
         SQL.Add(s);
         open;
         if recordcount >0 then begin
           first;
           ctr:= 0;
           While Eof = False do begin
            if fieldbyname('HideonPickSlip').asboolean  then begin
              Next;
              continue;
            end;
             s:= 'insert into ' + tablename +' Set SeqID = ' + inttostr(ctr);
             //if SaleLineID <> fieldbyname('SAleLineID').AsInteger then begin
               s:= s +',saleId = '                 + inttostr(Fieldbyname('saleId').AsInteger) +
                      ',SalelineID = '             + inttostr(Fieldbyname('SalelineID').AsInteger) +
                      ',UnitofMeasureQtySold = '   + FloatTostr(Fieldbyname('UnitofMeasureQtySold').asFloat) +
                      ',UnitofMeasureShipped = '   + FloatTostr(Fieldbyname('UnitofMeasureShipped').asFloat) +
                      ',UnitofMeasureBackorder = ' + FloatTostr(Fieldbyname('UnitofMeasureBackorder').asFloat) +
                      ',ProductName = '            + Quotedstr(Fieldbyname('ProductName').asString) +
                      ',PickMemo = '               + Quotedstr(fieldbyname('PickMemo').AsString)+
                      ',Product_Description = '    + Quotedstr(fieldbyname('Product_Description').AsString)+
                      ', PURCHASEDESC = '          + Quotedstr(fieldbyname('PURCHASEDESC').AsString) +
                      ', PRODUCTCODE  = '          + Quotedstr(fieldbyname('PRODUCTCODE').AsString) +
                      ',proctreeID = '             + inttostr(Fieldbyname('proctreeID').AsInteger) +
                      ',SalesUOM = '               + Quotedstr(Fieldbyname('SalesUOM').asString)+
                      ', customername = '          + Quotedstr(fieldbyname('customername').asString )+
                      ',parentID = '               + inttostr(Fieldbyname('parentID').AsInteger)+
                      ',inputtype= '               + QuotedStr(Fieldbyname('InputType').asString)  +
                      ',selected = '               + QuotedStr(BooleantoStr(Fieldbyname('Selected').asBoolean))  ;
             if SaleLineID <> fieldbyname('SAleLineID').AsInteger then begin
               SaleLineId :=fieldbyname('SAleLineID').AsInteger;
               ProctreeID:=0;
               batchID:=0;
               binsID:=0;
             end;
             if ProctreeId <> fieldbyname('ProctreeID').AsInteger then begin
                s:=s +' ,Caption = '                + Quotedstr(Fieldbyname('Caption').asString) +
                      ' ,Linecaption = '            + Quotedstr(Fieldbyname('Linecaption').asString) +
                      ' ,treepartuom = '            + Quotedstr(Fieldbyname('treepartuom').asString) +
                      ' ,uomdetail = '              + Quotedstr(Fieldbyname('uomdetail').asString) +
                      ' ,partsID = '                + inttostr(Fieldbyname('partsID').AsInteger) +
                      ' ,Sequencedown = '           + inttostr(Fieldbyname('Sequencedown').AsInteger) +
                      ' ,level = '                  + inttostr(Fieldbyname('level').AsInteger) +
                      //' ,parentID = '               + inttostr(Fieldbyname('parentID').AsInteger) +
                      //' ,selected = '               + QuotedStr(BooleantoStr(Fieldbyname('Selected').asBoolean)) +
                      //' ,inputtype= '               + QuotedStr(Fieldbyname('InputType').asString) +
                      ' ,treepartuomid = '          + inttostr(Fieldbyname('treepartuomid').AsInteger) +
                      ' ,treepartuommultiplier = '  + FloatTostr(Fieldbyname('treepartuommultiplier').asFloat) +
                      ' ,FromStockQty = '           + FloatTostr(Fieldbyname('FromStockQty').asFloat) +
                      ' ,ManufactureQty = '         + FloatTostr(Fieldbyname('ManufactureQty').asFloat) +
                      ' ,OnOrderQty = '             + FloatTostr(Fieldbyname('OnOrderQty').asFloat) +
                      ' ,ManufactureUOMQty = '      + FloatTostr(Fieldbyname('ManufactureUOMQty').asFloat) +
                      ' ,FromStockUOMQty = '        + FloatTostr(Fieldbyname('FromStockUOMQty').asFloat) +
                      ' ,OnOrderUOMQty = '          + FloatTostr(Fieldbyname('OnOrderUOMQty').asFloat) ;
                ProctreeId :=  fieldbyname('ProctreeID').AsInteger;
                batchID :=0;
                binsID  :=0;
             end;
             if (batchId <> Fieldbyname('batchId').AsInteger) then begin
              if  (Fieldbyname('batchId').AsInteger <> 0) then begin
                s:=s +' , batchno = '               + Quotedstr(Fieldbyname('batchno').AsString)  ;
                s:=s +' , TruckLoadNo = '               + Quotedstr(Fieldbyname('TruckLoadNo').AsString)  ;
                if Fieldbyname('Expirydate').asDateTime <> 0 then
                  s:= s + ' ,  Expirydate = '       + Quotedstr(FormatDateTime(MysqlDateFormat, Fieldbyname('Expirydate').asDateTime));
                s:= s +' ,  batchQty = '            + floatToStr(Fieldbyname('batchQty').AsFloat);
              end;
              batchId := Fieldbyname('batchId').AsInteger;
              binsID :=0;
             end;

             if (binsID <> Fieldbyname('binsID').AsInteger) then begin
              if  (Fieldbyname('binsID').AsInteger <> 0) then begin
                s:=s +' , binlocation = '           + Quotedstr(Fieldbyname('binlocation').AsString)  +
                      ' , binnumber = '             + Quotedstr(Fieldbyname('binnumber').AsString) +
                      ' , binQty = '                + floatToStr(Fieldbyname('binQty').AsFloat);
              end;
              binsID :=  Fieldbyname('binsID').AsInteger;
             end;

             Serialno := '';
             while (EOF=False) and
                    (SaleLineID = fieldbyname('sAleLineID').AsInteger) and
                    (proctreeID = fieldbyname('ProctreeId').AsInteger) and
                    (batchID = fieldbyname('batchID').AsInteger) and
                    (binsID= fieldbyname('binsId').AsInteger)  and
                    (Fieldbyname('sno').asString <> '') do begin
                if Serialno <> '' then Serialno := Serialno +',' ;
                Serialno := Serialno +Fieldbyname('sno').asString;
                next;
             end;

             if Serialno <> '' then
                s:= s + ', sno =' + Quotedstr(Serialno)
             else next;
             st.Add(s+';');
             ctr:= ctr+1;
           end;
         end;
       finally
         closenFree;
       end;
       With tempMyScript do try
         SQL.Add(st.Text);
         SQL.add('update ' + tablename +' Set  UnitofMeasureQtySold = NULL where ifnull(UnitofMeasureQtySold,0) =0;');
         SQL.add('update ' + tablename +' Set  UnitofMeasureShipped = NULL where ifnull(UnitofMeasureShipped,0) =0;');
         SQL.add('update ' + tablename +' Set  UnitofMeasureBackorder = NULL where ifnull(UnitofMeasureBackorder,0) =0;');

         SQL.add('update ' + tablename +' Set  FromStockQty             = NULL where ifnull(FromStockQty,0) =0;');
         SQL.add('update ' + tablename +' Set  ManufactureQty           = NULL where ifnull(ManufactureQty,0) =0;');
         SQL.add('update ' + tablename +' Set  OnOrderQty               = NULL where ifnull(OnOrderQty,0) =0;');
         SQL.add('update ' + tablename +' Set  ManufactureUOMQty        = NULL where ifnull(ManufactureUOMQty,0) =0;');
         SQL.add('update ' + tablename +' Set  FromStockUOMQty          = NULL where ifnull(FromStockUOMQty,0) =0;');
         SQL.add('update ' + tablename +' Set  OnOrderUOMQty            = NULL where ifnull(OnOrderUOMQty,0) =0;');
         SQL.add('update ' + tablename +' Set  batchQty                 = NULL where ifnull(batchQty,0) =0;');
         SQL.add('update ' + tablename +' Set  binQty                   = NULL where ifnull(binQty,0) =0;');
         execute;
         ChecknUpdateInTreeNodesSelected(Tablename  , 'nodeselected');
         SQL.clear;
         SQL.add('delete from ' + tablename +' where nodeselected="F";');
         execute;
       finally
         Free;
       end;

  finally
    Freeandnil(st);
  end;

end;
(*Procedure CheckInTreeNodesSelected(tablename, checksttausfield :String; connection:TERPConnection = nil);
var
  Qry , qrytree:TERPQuery;
  fbCheckStatus :Boolean;
  s:String;
  st:TStringlist;
  TreeRootId:Integer;
begin
  Qry := Commondblib.tempMyquery(Connection);
  qrytree:= Commondblib.tempMyquery(Connection);
  try
    Qry.SQL.text := 'select * from ' +tablename +' order by TreeRootId  ';
    Qry.open;
    if Qry.recordcount=0 then exit;

    {s:= Qry.groupconcat('ProctreeId');
    qrytree.SQL.text := 'select * from tblproctree where proctreeId in (' +s+')';
    qrytree.open;}

    if Qry.findfield('ProctreeId') = nil then exit;
    if Qry.findfield(checksttausfield) = nil then exit;
    Qry.First;
    St:= TStringlist.Create;
    try
      DoShowProgressbar(Qry.RecordCount +1, 'This may take few minutes - started at :' + formatDateTime('hh:nn am/pm' , now)+'. ' + WAITMSG  , '' , False );
      try
        logtime('start');
        TreeRootId := 0;
        While Qry.Eof = False do begin
          if TreeRootId <> Qry.fieldByname('TreeRootId').AsInteger then begin
            Closedb(qrytree);
            qrytree.SQL.text := 'select * from tblproctree where TreeRootId  = ' +inttostr(Qry.fieldByname('TreeRootId').AsInteger);
            qrytree.open;
          end;
          fbCheckStatus :=CheckInTreeNodeSelected(QryTree , Qry.fieldByname('ProctreeId').asInteger, Qry.fieldByname('ParentID').asInteger);
          st.add('update ' +tablename +' Set   ' +checksttausfield +' = ' + Quotedstr(BooleanToStr(fbCheckStatus)) +' where proctreeId = ' +inttostr(Qry.fieldByname('ProctreeId').AsInteger)+';');
          Qry.Next;
          DoStepProgressbar;
        end;
        logtime('processed');
        if st.Count<> 0 then
          ExecuteSQL(st.Text  , qry.Connection );
        logtime('updated');
      finally
        DoHideProgressbar;
      end;
    finally
      Freeandnil(St);
    end;
  finally
    Qry.closenfree;
  end;
end;
function CheckInTreeNodeSelected(Qry:TERPQuery; ID, ParentID:Integer):Boolean;
var
  selected:Boolean;
begin
  if parentId =0 then begin
    Result:= True;
    Exit;
  end;
  Selected :=True;
  if (Qry.FieldByName('ProctreeID').AsInteger = ID) or (Qry.locate('ProctreeID' , ID , [])) then
    Selected :=   Qry.fieldbyname('Selected').asBoolean;

  if not(Qry.locate('ProctreeID' , parentID , [])) then begin
    result := True;
    Exit;
  end;

  if Qry.fieldbyname('InputType').asSTring ='itOption' then
  begin
    result:= selected;
    Exit;
  end;
  Result := CheckInTreeNodeSelected(Qry , Qry.fieldbyname('ProctreeId').asInteger , Qry.fieldbyname('ParentID').asInteger);
end;*)
Function Leaves(Quoted:Boolean) :String;
Var
  qryLeaves :TERPQuery;
begin
  result := '';
  qryLeaves := DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    closedb(qryLeaves);
    qryLeaves.SQL.Text := 'SELECT LeaveType FROM tblleavetypes WHERE Active = "T" order by LeaveType';
    opendb(qryLeaves);
    if qryLeaves.recordcount =0 then exit;
    Result :=qryLeaves.GroupConcat('LeaveType' , '' , False, ',' , '' , '', True);
  finally
    DbSharedObj.ReleaseObj(qryLeaves);
  end;

end;

Function BOMTreeFlat(const Datefrom , DateTo:TDateTime ; Tablename:String; datefilterfield:String; ExtraWhere:String=''):String;
var
  fiBomLevels , level , sublevel:Integer;
  s:String;
  st:TStringlist;
begin
  result := '';
  if tablename = '' then exit;
  st:= TStringlist.create;
  try
      fiBomLevels := BOMTreeLevels;

      With st do begin
        Clear;
        Add('/*1*/Drop table if exists '+ Tablename+';');
        s:= 'Create table '+ Tablename+''+
      ' (  ID int(11) NOT NULL AUTO_INCREMENT,  '+
      '   Level int(11) NULL DEFAULT 0 , '+
      '   SalesLevels int(11) NULL DEFAULT 0 , '+
      '   saleID int(11) NULL DEFAULT 0 , '+
      '   saleLineID int(11) NULL DEFAULT 0 , '+
      '   productID int(11) DEFAULT 0 , '+
      '   PTID int(11) NULL DEFAULT 0 ,'+
      '   Sequencedown int(11) NULL DEFAULT 0 ,'+NL;
      for level := 1 to fiBomLevels do
        s:= s + ' PTID'       + LvlNo(Level) +' int(11) NULL DEFAULT 0 ,' +
                ' parentId'   + LvlNo(Level) +' int(11) DEFAULT NULL ,'+NL;
      s:= s + '  PRIMARY KEY (ID) , '+
                ' KEY PTID        (PTID), '+
                ' Key SaleID      (SaleId) ,'+
                ' Key saleLineId  (saleLineId)';
      for level := 1 to fiBomLevels do
        s:= s + ' , KEY PTID'+ LvlNo(Level)+' (PTID'+ LvlNo(Level)+')';
      s:= s +' ) ENGINE=MyISAM DEFAULT CHARSET=utf8;';
      add('/*2*/'+s);

      add('/*5*/insert ignore into ' + tablename +
              ' ( Level, saleId , SaleLineId , ProductId, PTID , Sequencedown , PTID1 ,parentId1 )  '+
              ' select 1, s.saleId , sl.saleLineId , Sl.productId , PT.proctreeId ,PT.Sequencedown ,  PT.proctreeId , PT.parentID' +
              ' from  tblsales S   '+
              ' inner join tblsaleslines SL on S.saleId = Sl.saleId   '+
              ' inner join tblProcTree PT   on PT.MasterId = Sl.saleLineid and PT.Mastertype <> "mtProduct"   and ifnull(PT.parentId , 0)=0  '+
              ' where (S.'+ datefilterfield+' Between ' + QuotedStr(FormatDateTime(MysqlDateFormat, Datefrom)) + ' AND ' + QuotedStr(FormatDateTime(MysqlDateFormat, DateTo)) + ')'+
              iif(ExtraWhere <> '' , ' and ' + ExtraWhere , '')+ ' ;');

        for level := 2 to fiBomLevels do begin
            s:= 'insert ignore into  '+ tablename +'  ( Level, saleId , SaleLineId , ProductId, PTID, Sequencedown , PTID1 ,parentId1 ';

            for sublevel := 2 to level do
              s:= s + ',PTID' + LvlNo(sublevel) +',parentId' + LvlNo(sublevel) ;


            s:= s +')'+NL+' select ' + inttostr(level) +' , PT1.saleId , PT1.SaleLineId , PT1.ProductId, PT'+ LvlNo(Level)+'.proctreeId , PT'+ LvlNo(Level)+'.Sequencedown,  PT1.PTID1 ,PT1.parentId1 ';

            for sublevel := 2 to level do s:= s + ' ,PT'+ LvlNo(sublevel)+'.proctreeId , '+
                                                    'PT'+ LvlNo(sublevel)+'.parentID';
            s:= s +NL+'from  '+ tablename +'  PT1 ';
            for sublevel := 2 to level do s:= s + ' inner join tblproctree PT'+ LvlNo(sublevel)+' on PT1.PTID'+ LvlNo(subLevel-1)+' = PT'+ LvlNo(sublevel)+'.parentId '+
                                                                                                        iif(Sublevel>2 , 'and PT'+ LvlNo(sublevel)+'.ParentId = PT'+ LvlNo(subLevel-1)+'.ProctreeId   ' , '');

            s:= s +NL+ ' WHERE IFNULL(pt1.ptid1,0) <>0';

            for sublevel := 2 to level do s:= s + ' AND IFNULL(PT1.PTID'+ LvlNo(subLevel-1)+',0)<> 0';

            add('/*6-'+ inttostr(level)+'*/'+s+';');
        end;

        add('/*7*/ update ' + tablename +' T Set T.SalesLevels = '+
                                                  ' (Select max(PT.level)  '+
                                                  ' from tblsaleslines SL  '+
                                                  ' inner join tblproctree PT on SL.salelineId = PT.MasterId and PT.MasterType <> "mtProduct"  '+
                                                  ' where  SL.salelineId = T.salelineId )+1;');
        for level := fiBomLevels downto 2 do begin
          for SubLevel := fiBomLevels downto 1 do begin
          if SubLevel-(fiBomLevels- Level+1)>=1 then begin
            add('/*6-'+ inttostr(level)+'-'+ inttostr(SubLevel)+'*/ update ' +tablename +' Set ' +
                     'PTID'       + LvlNo(sublevel) +' = PTID'      + LvlNo(SubLevel-(fiBomLevels- Level+1)) +' ,'+
                     'parentId'   + LvlNo(sublevel) +' = parentId'  + LvlNo(SubLevel-(fiBomLevels- Level+1)) +' '+
                     ' where SalesLevels =' + inttostr(Level-1)+';');
          end else begin
            add('/*8-'+ inttostr(level)+'-0*/ update ' +tablename +' Set ' +
                   'PTID'       + LvlNo(sublevel) +' = NULL,'+
                   'parentId'   + LvlNo(sublevel) +' = NULL'+
                   ' where SalesLevels =' + inttostr(Level-1)+';');
          end;
          end;
        end;
      end;
  finally
    result := st.text;
    freeandNil(st);
  end;
end;
Function LvlNo(const Value:Integer):String;
begin
  REsult := Trim(Inttostr(Value));
end;
end.

