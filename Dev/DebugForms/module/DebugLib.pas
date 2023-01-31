unit DebugLib;

interface


function FieldNames(const Target:String): String;
Function DuplicateTable(const source, target:String;CopyRecords:Boolean):String;
Procedure RecalculateProductAvgcost;
function DoBackuptables(const Tablenames:Array of string; Prefix:String; takeconfirmationtoOverwrite:Boolean):String;
function fixtablename(Const tablename:String;Prefix:String):String;
function IsDbSelected(const dbname:String):Boolean;
Function InsertUOMFromTransSQL(Tablename , PartsID , UOM, UOMMult , UOMID:String):String;
function CurDBVerno:String;
Function  LogObj(Obj :TObject;CSVLinedata:boolean):String;

implementation

uses CommonDbLib, CommonLib, BusObjStock, FastFuncs, AppEnvironment , SysUtils ,
     BusObjBase , Classes , Dialogs , progressdialog, controls, AppDatabase,
     tcConst, Typinfo , Variants, ERPVersionConst;

Function  LogObj(Obj :TObject;CSVLinedata:boolean):String;
var
  iIndex, Propcount: integer;
  PropList: PPropList ;
  s:String;
begin
                Result := '';
                s:= '';
                Propcount:= GetPropList(PTypeInfo(Obj.ClassInfo) , PropList);
                if (not(Assigned(PropList))) or (Propcount = 0 ) then Exit;

                for iIndex := 0 to Propcount-1 do begin
                    try
                        if (not (PropType( Obj ,String(Proplist[iIndex].name)) in [tkClass, tkMethod, tkArray, tkRecord, tkInterface])) and
                              Assigned(getPropInfo(Obj,String(Proplist[iIndex].name)).getproc )   then
                              try
                                if CSVLinedata then begin
                                  Result := result +varToStr(GetPropValue(Obj , String(Proplist[iIndex].name)))+',';
                                  s := s + string(Proplist[iIndex].name) +',';
                                end else begin
                                  Result := result + string(Proplist[iIndex].name) +':' +GetPropValue(Obj , String(Proplist[iIndex].name))+NL;
                                end;
                              Except
                              end;
                    Except
                        on E:Exception do begin
                        end;
                    end;
                end;
                if CSVLinedata then Result := s + NL+ REsult;
end;
Procedure RecalculateproductAvgcost;
var
  Product:TProduct;
  st:TStringlist;
  i:Integer;

  function nextupdatebatchno:Integer;
  begin
    try
        with CommonDbLib.TempMyQuery do try
          SQL.add('Select Max(updatebatchno) as updatebatchno from erpfix_parts');
          open;
          result := fieldbyname('updatebatchno').asInteger;
        finally
            if active then close;
            free;
        end;
    finally
        result := result +1;
    end;
  end;

begin
  DoShowProgressbar(10 , 'Calculating Product Avgcost' , '');
  try
  {recalculate product's avg cost}
    if (Sysutils.SameText(appenv.AppDb.Database , 'techinc')) or
      (Sysutils.SameText(appenv.AppDb.Database , 'distinctive_accessories_pty_ltd')) then begin
        IF TableExists('erpfix_parts') then exit;
      DoStepProgressbar('Backing Up Products');
      With CommonDbLib.TempMyScript do try
        SQl.add('CREATE TABLE if not exists `erpfix_parts` (' );
        SQl.add('`ID` int(10) unsigned NOT NULL auto_increment,' );
        SQL.add('updatebatchno int(11),');
        SQl.add('`PartsId` int(10) unsigned default NULL,' );
        SQl.add('`PartName` varchar(255) default NULL,' );
        SQl.add('`AvgCost` double unsigned default NULL,' );
        SQl.add('`Date` date default NULL,' );
        SQl.add('PRIMARY KEY  (`ID`),' );
        SQl.add('UNIQUE KEY `uniqueidx` (`PartsId`,`AvgCost`,`Date`)' );
        SQl.add(') ENGINE=MyISAM ;' );
        Execute;
        DoStepProgressbar('Backing Up Products');
        i:=nextupdatebatchno;
        SQL.clear;
        SQL.add('insert ignore into erpfix_parts(updatebatchno , PartsId ,Partname , avgcost,Date) ' );
        SQL.add('Select ' + IntToStr(i) + ',PartsId, Partname , Avgcost , CURDATE() from tblParts;');
        Execute;
      finally
          Free;
      end;
      With TempMyQuery do try
        DoStepProgressbar('Calculation in Progress.....');
        SQL.add('Select * from erpfix_parts where  updatebatchno = ' +IntToStr(i));
        open;
        Product := TProduct.Create(nil);
        try
          Product.connection :=TMyDacDataConnection.create(Product);
          Product.connection.Connection := GetNewMyDacConnection(Product);
          DoStepProgressbar('Calculation in Progress.....');
          Product.Load;
          if Product.count = 0 then exit;
          DoHideProgressbar;
          DoShowProgressbar(Product.count , 'Calculating Product Avgcost' , '');
          Product.first;
          st:=TStringlist.create;
          try
            while Product.eof =False do begin
              if Product.UserLock.Lock(Product.BusObjectTableName , Product.Id) then begin
                try
                  Product.DoUpdateAvgCosts;
                  if Locate('PartsId' , Product.ID , []) then
                    if product.AverageCost = FieldByname('Avgcost').asfloat then
                      Delete;
                finally
                  Product.userlock.unLock(Product.BusObjectTableName , Product.Id);
                  DoStepProgressbar(Product.Productname);
                end;
              end else st.add(Product.ProductName);

              Product.Next;
            end;
          finally
            if st.count> 0 then
              MessageDlgXP_Vista('Updating the Avg cost in The Following Product(s) Failed as They Are Locked By Some Modules in ERP.' +chr(13) + chr(13)+ st.Text , mtwarning, [mbok] , 0);
              Freeandnil(st);
          end;

        finally
            FreeandNil(Product);
        end;
      finally
          if active then close;
          free;
      end;
    end;
  finally
      DoHideProgressbar;
  end;
end;

function FieldNames(const Target:String): String;
begin
  Result := '';
  try
    try
      with TempMyQuery do try
        SQL.add('Desc ' + Target);
        open;
        if recordcount = 0 then exit;
        first;
        while Eof = False do begin
          if result <> '' then result := result +',';
          result := result +'`' + fieldbyname('field').asString +'`';
          Next;
        end;
      finally
          if Active then close;
          free;
      end;
    except
        if result = '' then result := '*';
    end;
  finally
      if result = '' then result := '*';
  end;


end;

function DuplicateTable(const source,
  target: String;CopyRecords:Boolean): String;
var
  s:String;
  fs:String;
begin
  s:= '';
  With commondblib.TempMyQuery do try
    SQL.add('show create table '+source);
    open;
    s:= '';
    if TableExists(target) then begin
      s:= 'Drop table if exists tmp_1;' ;
      s:= s+ ReplaceStr(Fields[1].asString , source , 'tmp_1')+';' ;

      if CopyRecords then begin
        fs:= fieldnames(target);
        s:= s+ ' insert ignore into tmp_1 (' +fs+' )  select ' +fs+'  from ' +Target+';';
      end;

      s:= s+  'Drop table if exists ' +target+';' ;
      s:= s+ ' rename table tmp_1 to ' +target+';'

    end else begin
     s:= s+ ReplaceStr(Fields[1].asString , source , target)+';';
    end;
    if CopyRecords then s := s  +chr(13) +' insert ignore into ' +target +' select * from ' +source+';';
  finally
    if active then close;
    Free;
  end;
  result := s;
end;
function IsDbSelected(const dbname:String):Boolean;
begin
  with GetSharedMyDacConnection do begin
    result:= sametext(dbname , database) or sametext(dbname , copy(database , 1, length(dbname)));
  end;
end;
function fixtablename(Const tablename:String;Prefix:String):String;
begin
    result := 'erpfix'+ Prefix+'_' +tablename + replacestr(TABLE_VERSION,'.','');
end;
function DoBackuptables(const Tablenames:Array of string; Prefix:String; takeconfirmationtoOverwrite:Boolean):String;
var
  ctr:Integer;
  Flag:Boolean;
begin
  result:= '';
  if length(Tablenames) =0 then exit;
  if takeconfirmationtoOverwrite then begin
      Flag := False;
      for ctr:= low(Tablenames) to high(Tablenames) do
        if Tableexists(fixtablename(Tablenames[ctr], Prefix)) then begin
          flag:= True;
          break;
        end;
      if Flag and (MessageDlgXP_Vista('Do you wish to re-create the backup tables?', mtConfirmation, [mbYes, mbNo], 0)= mrno) then exit;
  end;
  Result:= '';
  for ctr:= low(Tablenames) to high(Tablenames) do begin
    Result:= result +
              iif(takeconfirmationtoOverwrite , 'Drop table if exists erpfix' +Prefix +'_' +Tablenames[ctr] +';', '') +
              'create table if not exists '+ fixtablename(Tablenames[ctr], prefix)  +' like ' +Tablenames[ctr] +';'+
              'insert ignore into '+ fixtablename(Tablenames[ctr],prefix) +' select * from ' +Tablenames[ctr] +';';
  end;
end;
function CurDBVerno:String;
begin
  result := replacestr(TABLE_VERSION , '.' , '');
end;
Function InsertUOMFromTransSQL(Tablename , PartsID , UOM, UOMMult , UOMID:String):String;
var
  s:String;
begin
  s:= 'erpfix_' + replacestr(tablename , 'tbl' , '')+ '_' + curdbverno;
  result := 'create table if not exists ' + s +' like ' + Tablename +';'+NL;
  result := result + 'insert ignore into ' + s + ' select * from ' + Tablename +';'+NL;

  result := result + 'insert ignore into tblunitsofmeasure '+
            ' (PartID , unitname ,unitDescription, Multiplier , baseUnitname , baseunitID, active , height , width , Length , weight , Volume , unitProductKeyname) '+
            ' select distinct   '+
            ' Trans.' + PartsID+' ,    '+
            ' puom.unitname ,  '+
            ' puom.unitDescription,  '+
            ' Max(puom.Multiplier) Multiplier ,  '+
            ' puom.baseUnitname ,  '+
            ' puom.baseunitID,  '+
            ' puom.active ,   '+
            ' max(ifnull(puom.height,0)) height,  '+
            ' max(ifnull(puom.width,0)) width,  '+
            ' max(ifnull(puom.Length,0)) Length,  '+
            ' max(ifnull(puom.weight,0)) weight,  '+
            ' max(ifnull(puom.Volume,0)) Volume ,    '+
            ' concat(puom.unitname, ":", p.partname) unitProductKeyname '+
            ' from ' + Tablename +' Trans '+
            ' inner join tblparts P on p.partsId = Trans.' + PartsID+'  '+
            ' Left join tblunitsofmeasure uom on Trans.' + UOM+'  = uom.UnitName  ';
  if UOMMult <> '' then result := result +' and  Trans.' + UOMMult+'  = uom.Multiplier ';
  result := result +' and Trans.' + PartsID+'  = uom.PartID  inner join tblunitsofmeasure puom on Trans.' + UOMID+'  = puom.UnitID and  Trans.' + UOM+'  = puom.UnitName  ';
  if UOMMult <> '' then result := result +' and  Trans.' + UOMMult+' = puom.Multiplier ';
  result := result +' where ifnull(uom.unitID,0)=0   group by PartsID,  puom.unitname;'+NL;

  Result := result +'update ignore ' +Tablename +' as Trans   inner join tblunitsofmeasure uom  on Trans.' + UOM+' = uom.UnitName    ';
  if UOMMult <> '' then result := result +' and  Trans.' + UOMMult+' = uom.Multiplier ';
  Result := result +' and Trans.' + PartsID+'= uom.PartID Set Trans.' + UOMID+' =  uom.UnitID where Trans.' + UOMID+' <> uom.UnitID ;';

  Result := result +'update ignore ' +Tablename +' as Trans   inner join tblunitsofmeasure uom  on Trans.' + UOMID+' =  uom.UnitID';
  if UOMMult <> '' then result := result +' and  Trans.' + UOMMult+' = uom.Multiplier ';
  Result := result +' and Trans.' + PartsID+'= uom.PartID Set Trans.' + UOM+' = uom.UnitName    where Trans.' + UOM+' <> uom.UnitName ;';


end;

end.

