unit CustomAccountsReportObj;

interface

uses ERPdbComponents , GuiPrefsObj , Classes;

type

  TERPQueryProc       = Procedure (const Value:TERPQuery) of Object;

  TCustomAccountsReportObj =   class(TObject)
    Private
      fiFormId: Integer;
      fdReportAsOn: Tdatetime;
      fsTablename: String;
      fsSelectedClasses: String;
      fQryClasses: TERPQuery;
      fbIsBalanceSheet: Boolean;
      fGuiPrefs: TFormGuiPrefs;
      fbUSeGroupcolours: Boolean;
      fbBlankwhen0: Boolean;
      //fiAmountcolumnwidth :Integer;
      //fSelectedDepartmentList: TStringlist;
      fbHidetotals: Boolean;
      function getQryClasses: TERPQuery;
      function ClassIDFieldPrefix(classno:integer=0):String;
      Function Balance(CreditFiled, Debitfield , Typefield:String):String;
      //function getSelectedDepartmentList: TStringlist;
      function getDebitsExField:String;
      function getCreditsExField:String;
      function getDebitsIncField:String;
      function getCreditsIncField:String;
      procedure SetSelectedClasses(const Value: String);

    Public
      Property FormId :Integer read fiFormId write fiFormId;
      Property ReportAsOn :Tdatetime read fdReportAsOn write fdReportAsOn;
      Property Tablename:String read fsTablename write fsTablename;
      Property SelectedClasses :String read fsSelectedClasses write SetSelectedClasses;
      Property IsBalanceSheet :Boolean read fbIsBalanceSheet write fbIsBalanceSheet;
      constructor Create;
      DEstructor Destroy; Override;
      Procedure RefreshTable;
      Function ReportSQL:String;
      function ClassnamesReportSQL:String;
      Property QryClasses :TERPQuery read getQryClasses;
      Property GuiPrefs: TFormGuiPrefs read fGuiPrefs write fGuiPrefs;
      Property USeGroupcolours :Boolean read fbUSeGroupcolours write fbUSeGroupcolours;
      Property Blankwhen0 :Boolean read fbBlankwhen0 write fbBlankwhen0;
      Property Hidetotals :Boolean read fbHidetotals write fbHidetotals;
      Procedure IterateClassQuery(Proc : TERPQueryProc ; RunonSelectedclass:Boolean);
      Function ClassFields(const sSQL:String):String;
      Property DebitsExField:String read getDebitsExField;
      Property CreditsExField:String read getCreditsExField;
      Property DebitsIncField:String read getDebitsIncField;
      Property CreditsIncField:String read getCreditsIncField;
      Class Function GuiprefName:String;
  end;
implementation

uses sysutils, DbSharedObjectsObj, CommonDbLib, LogLib,
  MySQLConst, tcConst, UtilsLib, AppEnvironment, CommonLib ;

{ TCustomAccountsReportObj }

function TCustomAccountsReportObj.ClassFields(const sSQL: String): String;
begin
  REsult := '';
  if QryClasses.recordcount > 0 then begin
        QryClasses.first;
        while QryClasses.Eof = False do begin
          result := result + replacestr(ssql ,'"ClassIDFieldPrefix"' , ClassIDFieldPrefix);
          QryClasses.Next;
        end;
      end;
end;


constructor TCustomAccountsReportObj.Create;
begin
      fiFormId:=0;
      fdReportAsOn:=Date;
      fsSelectedClasses:= '';
      fbIsBalanceSheet := False;
      fQryClasses := nil;
end;

destructor TCustomAccountsReportObj.Destroy;
begin
  DbSharedObj.ReleaseObj(fQryClasses);
  //FreeandNil(fSelectedDepartmentList)
end;

function TCustomAccountsReportObj.getQryClasses: TERPQuery;
var
  s:String;
begin
  s:= 'Select classId, classname , '+
      ' if(classid in ('+iif(fsSelectedClasses ='' , '0' , fsSelectedClasses)+') , "T" , "F") ClassSelected '+
      ' from tblclass  '+
      ' Where active ="T" '+
      ' Order by classname';
  if fQryClasses = nil then begin
          fQryClasses := DbSharedObj.GetQuery(GetSharedMyDacConnection);
  end;
  if not(Sametext(trim(fQryClasses.SQL.text) , trim(s))) or (fQryClasses.active =False) then begin
    CloseDB(fQryClasses);
    fQryClasses.SQL.text := s;
  end;
  if fQryClasses.Active =False then fQryClasses.Open;
  result := fQryClasses;
end;
class function TCustomAccountsReportObj.GuiprefName: String;
begin
    REsult := 'TCustomAccountsReport';
end;

procedure TCustomAccountsReportObj.IterateClassQuery(Proc: TERPQueryProc; RunonSelectedclass:Boolean);
begin
  if QryClasses.recordcount > 0 then begin
        QryClasses.first;
        while QryClasses.Eof = False do begin
          if (RunonSelectedclass =False) or (QryClasses.FieldByName('ClassSelected').AsBoolean) then
            Proc(QryClasses);
          QryClasses.Next;
        end;
  end;
end;

Function TCustomAccountsReportObj.Balance(CreditFiled, Debitfield , Typefield:String):String;
begin
  if IsBalanceSheet =False then
    REsult :=  CreditFiled +'-' +Debitfield
  else
    REsult := 'If(' + Typefield +'="CCARD" OR ' + Typefield +' = "EQUITY" OR ' + Typefield +' = "INC" '+'OR ' + Typefield +' = "OCLIAB",Sum(' + CreditFiled +'-' + Debitfield +'),Sum(' + Debitfield +'-' + CreditFiled +')) ';
end;
procedure TCustomAccountsReportObj.RefreshTable;
var
  fScript :TERPScript;
  s:String;
  ctr:Integer;
begin
  fScript := DbSharedObj.GetScript(GetSharedMyDacConnection);
  try
    With fScript do begin
      SQL.Clear;

    SQL.add('/*01*/Drop table if exists '+ Tablename +';');
    SQL.add('/*02*/CREATE TABLE `'+ Tablename +'` ( '+
            ' ID                INT NOT NULL AUTO_INCREMENT, '+
            ' AccountID         INT NOT NULL DEFAULT 0, '+
            ' Levelno           INT NOT NULL DEFAULT 0, '+
            ' category          VARCHAR(3), '+
            ' AccountName       VARCHAR(255) NOT NULL DEFAULT 0, '+
            ' ReportCaption     VARCHAR(255) NOT NULL DEFAULT 0, '+
            ' Balance           DOUBLE DEFAULT 0, '+
            ' DebitsEx          DOUBLE DEFAULT 0, '+
            ' CreditsEx         DOUBLE DEFAULT 0, '+
            ' DebitsInc         DOUBLE DEFAULT 0, '+
            ' CreditsInc        DOUBLE DEFAULT 0, '+
            ' Level1id          INT NOT NULL DEFAULT 0, '+
            ' Level2id          INT NOT NULL DEFAULT 0, '+
            ' Level3id          INT NOT NULL DEFAULT 0, '+
            ' Level4id          INT NOT NULL DEFAULT 0, '+
            ' Accounttype       VARCHAR(255) NOT NULL DEFAULT "", '+
            ' COAType           varchar(50) NOT NULL DEFAULT "", '+
            ' Level1            VARCHAR(255) NOT NULL DEFAULT "", '+
            ' Level2            VARCHAR(255) NOT NULL DEFAULT "", '+
            ' Level3            VARCHAR(255) NOT NULL DEFAULT "", '+
            ' Level4            VARCHAR(255) NOT NULL DEFAULT "", '+
            ' SortOrder         DOUBLE NOT NULL DEFAULT 0, '+
            ' ParentId          INT NOT NULL DEFAULT 0, '+
            ' Parentcategory    VARCHAR(3), '+
            ' childcount        int(11), '+
            ' PRIMARY KEY (ID), '+
            ' INDEX AccountID (AccountID) ) COLLATE="utf8_general_ci" ENGINE=MyISAM ;');
       {fields for the classes}
          SQL.Add(ClassFields('alter table '+ tablename +
                        ' Add column "ClassIDFieldPrefix"DebitsEx          DOUBLE DEFAULT 0, '+
                        ' Add column "ClassIDFieldPrefix"CreditsEx         DOUBLE DEFAULT 0, '+
                        ' Add column "ClassIDFieldPrefix"DebitsInc         DOUBLE DEFAULT 0, '+
                        ' Add column "ClassIDFieldPrefix"CreditsInc        DOUBLE DEFAULT 0; '));

//Accounts records
      SQL.add('/*03*/insert ignore into '+ Tablename +
              ' (AccountId, Accountname,COAType ,  Category, reportcaption, level1, level2, level3,level4, level1id, level2id, level3id,level4id, sortOrder ,parentID, parentCategory , Balance) ' +
              ' SELECT M.AccountId, ifnull(COA.accountname , M.ReportCaption), COA.AccountType, M.Category, M.reportcaption, ' +
              ' L1.accountName as level1, L2.accountName as level2, L3.accountName as level3,L4.accountName as level4, ' +
              ' M.Level1Id, ' +
              ' M.Level2Id, ' +
              ' M.Level3Id, ' +
              ' M.Level4Id, ' +
              ' M.sortOrder, M.ParentId, M.ParentCategory , COA.balance' +
              ' FROM `tblchartofaccountsreporttree` M ' +
              ' Left join tblchartofaccounts COA on M.accountID = COA.AccountId  and M.Category ="COA" ' +
              ' Left join tblchartofaccounts L1 on M.Level1ID = L1.accountID  and M.Category ="COA" ' +
              ' Left join tblchartofaccounts L2 on M.Level2ID = L2.accountID  and M.Category ="COA" ' +
              ' Left join tblchartofaccounts L3 on M.Level3ID = L3.accountID  and M.Category ="COA" ' +
              ' Left join tblchartofaccounts L4 on M.Level4ID = L4.accountID  and M.Category ="COA" ' +
              ' WHERE `showinthereport` ="T" and reportId =' + inttostr(FormID) +' ; ' );

// child count for each account
      SQL.add('/*04*/Drop table if exists '+ Tablename +'1;');
      SQL.add('/*05*/create table '+ Tablename +'1 Select ParentId, parentCategory, count(ID) ctr from '+ Tablename +' where ifnull(PArentID,0)<> 0 group by ParentId, parentCategory;');
      SQL.add('/*06*/update '+ Tablename +' T1 inner join '+ Tablename +'1 T2 on T1.AccountID = T2.parentId and T1.category = T2.parentCategory Set T1.childcount = T2.ctr;');
      SQL.add('/*07*/Drop table if exists '+ Tablename +'1;');

// Account sum from transaction table
s:= '/*08*/Create table '+ Tablename +'1  select  TR.accountId,  ' ;
      if QryClasses.recordcount > 0 then begin
        QryClasses.first;
        while QryClasses.Eof = False do begin
          s:= s+  ' sum(if(TR.ClassID =' + inttostr(QryClasses.FieldByName('Classid').AsInteger)+' , TR.creditsEx  , 0)) as '+ ClassIDFieldPrefix + 'creditsEx ,  ' ;
          s:= s+  ' sum(if(TR.ClassID =' + inttostr(QryClasses.FieldByName('Classid').AsInteger)+' , TR.DebitsEx   , 0)) as '+ ClassIDFieldPrefix + 'DebitsEx  ,  ' ;
          s:= s+  ' sum(if(TR.ClassID =' + inttostr(QryClasses.FieldByName('Classid').AsInteger)+' , TR.creditsinc , 0)) as '+ ClassIDFieldPrefix + 'creditsinc,  ' ;
          s:= s+  ' sum(if(TR.ClassID =' + inttostr(QryClasses.FieldByName('Classid').AsInteger)+' , TR.Debitsinc  , 0)) as '+ ClassIDFieldPrefix + 'Debitsinc ,  ' ;
          QryClasses.Next;
        end;
      end;
      s:= s+  ' sum(TR.creditsEx)   as creditsEx ,  ' +
              ' sum(TR.DebitsEx)    as DebitsEx,  ' +
              ' sum(TR.creditsinc)  as creditsinc ,  ' +
              ' sum(TR.Debitsinc)   as Debitsinc ' +
              ' from '+ iif(reportAsOn >= Appenv.CompanyPrefs.SummarisedTransDate(*ClosingDate*) ,'tblTRansactions' ,'tbltransactionsummarydetails') +
                '  TR  where TR.accountID  in (select AccountId from '+ Tablename +' T  where  T.category ="COA") ' +
              ' and  TR.date <= ' + Quotedstr(formatDateTime(MysqlDateTimeFormat , reportAsOn)) +'  ' +
              ' group by TR.accountId;';
      SQL.Add(s);




      SQL.add('/*10*/update '+ Tablename +' T1 inner join '+ Tablename +'1 T2 on T1.accountId = T2.accountId and t1.category ="COA" '+
                        ' Set T1.debitsex = T2.debitsEx,  '+
                        '     T1.Creditsex = T2.CreditsEx,  '+
                        '     T1.debitsinc = T2.debitsinc,  '+
                        '     T1.Creditsinc = T2.Creditsinc;');

      SQL.add(ClassFields('/*11*/update '+ Tablename +' T1 inner join '+ Tablename +'1 T2 on T1.accountId = T2.accountId and t1.category ="COA" '+
                        ' Set T1."ClassIDFieldPrefix"debitsex  = T2."ClassIDFieldPrefix"debitsEx,  '+
                        '     T1."ClassIDFieldPrefix"Creditsex = T2."ClassIDFieldPrefix"CreditsEx,  '+
                        '     T1."ClassIDFieldPrefix"debitsinc = T2."ClassIDFieldPrefix"debitsinc,  '+
                        '     T1."ClassIDFieldPrefix"Creditsinc= T2."ClassIDFieldPrefix"Creditsinc;'));


  // parent amount from sum(children)
      For ctr := 1 to 4 do begin
            SQL.add('/*11*/Drop table if exists '+ Tablename +'1;');
            s:= '/*15*/Create table '+ Tablename +'1 ' +
                    ' select  T.category , T.ParentID, T.PArentCategory,  ';
            s:= s + ClassFields( 'sum(T."ClassIDFieldPrefix"creditsEx ) as "ClassIDFieldPrefix"creditsEx , '+
                        'sum(T."ClassIDFieldPrefix"DebitsEx  ) as "ClassIDFieldPrefix"DebitsEx, '+
                        'sum(T."ClassIDFieldPrefix"creditsinc) as "ClassIDFieldPrefix"creditsinc , '+
                        'sum(T."ClassIDFieldPrefix"Debitsinc ) as "ClassIDFieldPrefix"Debitsinc,  ');

            s:= s + ' sum(T.creditsEx) as creditsEx ,  ' +
                    ' sum(T.DebitsEx) as DebitsEx,  ' +
                    ' sum(T.creditsinc) as creditsinc ,  ' +
                    ' sum(T.Debitsinc) as Debitsinc ' +
                    ' from '+ Tablename +' T  ';

            if ctr = 1 then s:= s+ ' where ifnull(Level4id,0)<> 0';
            if ctr = 2 then s:= s+ ' where ifnull(Level3id,0)<> 0 and ifnull(Level4id,0)= 0';
            if ctr = 3 then s:= s+ ' where ifnull(Level2id,0)<> 0 and ifnull(Level3id,0)= 0 and ifnull(Level4id,0)= 0';
            if ctr = 4 then s:= s+ ' where ifnull(Level1id,0)<> 0 and ifnull(Level2id,0)= 0 and ifnull(Level3id,0)= 0 and ifnull(Level4id,0)= 0';

            s:= s+ ' group by T.ParentID , T.category , T.PArentCategory;';
            SQL.add(s);

            s:= '/*16*/update '+ Tablename +' T1 ' +
                    ' inner join '+ Tablename +'1 T2 on T1.accountId = T2.ParentId and t1.category = T2.parentCategory ' +
                    ' Set ';
            s:= s + ClassFields('T1."ClassIDFieldPrefix"debitsex = T1."ClassIDFieldPrefix"debitsex  + T2."ClassIDFieldPrefix"debitsEx,  '+
                                'T1."ClassIDFieldPrefix"Creditsex = T1."ClassIDFieldPrefix"Creditsex + T2."ClassIDFieldPrefix"CreditsEx,  '+
                                'T1."ClassIDFieldPrefix"debitsinc = T1."ClassIDFieldPrefix"debitsinc + T2."ClassIDFieldPrefix"debitsinc,  '+
                                'T1."ClassIDFieldPrefix"Creditsinc = T1."ClassIDFieldPrefix"Creditsinc + T2."ClassIDFieldPrefix"Creditsinc, ');

            s:= s + ' T1.debitsex = T1.debitsex+ T2.debitsEx,  '+
                    ' T1.Creditsex = T1.Creditsex+T2.CreditsEx,  '+
                    ' T1.debitsinc = T1.debitsinc+ T2.debitsinc,  '+
                    ' T1.Creditsinc = T1.Creditsinc+ T2.Creditsinc;';
            SQL.add(s);
      end;


      SQL.add('/*26*/Drop table if exists '+ Tablename +'1;');

      //update Accounttype
      SQL.add('/*27*/update  '+Tablename +'  set Accounttype = "";');
      SQL.add('/*28*/update  '+Tablename +'  set Accounttype = Accountname where Category ="AT" and ifnull(ParentID,0) = 0;');
      SQL.add('/*29*/update  '+Tablename +' T1 inner join  '+Tablename +' T2  on T1.accountid = T2.parentId and T1.Category = T2.parentCategory '+
              ' Set T2.Accounttype  = T1.Accountname '+
              ' where ifnull(T2.Accounttype ,"")=""  and ifnull(T1.Accounttype ,"")<>"";');

      //update levelno - fro grid formating
      SQL.add('/*30*/update ' + tablename +'  T1 Set t1.Levelno = 0;');
      SQL.add('/*31*/Drop table if exists ' + tablename +'2;');
      SQL.add('/*32*/create table ' + tablename +'2 select Max(if(T1.level4<> "", 5 , if(T1.level3<> "", 4 ,if(T1.level2<> "", 3 , if(T1.level1<> "", 2 , 1) )  ) ))  as Levelno from ' + tablename +' t1;');
      SQL.add('/*33*/update ' + tablename +'  Set Levelno = (Select Levelno  from ' + tablename +'2) where ifnull(ParentId,0)=0;');
      SQL.add('/*35*/update ' + tablename +'  T1 ' +
              ' left join  ' + tablename +'  t2 on t1.accountId = t2.parentId and t1.category = t2.parentcategory ' +
              ' Set t1.Levelno = 1 where ifnull(t2.accountId,0)=0 and ifnull(t1.parentId,0)<>0;');
      SQL.add('/*36*/update ' + tablename +'  T1 left join  ' + tablename +'  t2 on t1.accountId = t2.parentId and t1.category = t2.parentcategory ' +
              ' Set t1.Levelno = t2.Levelno+1 where ifnull(t2.Levelno,0)<>0 and ifnull(t1.parentId,0)<>0;');
      SQL.add('/*37*/update ' + tablename +'  T1 left join  ' + tablename +'  t2 on t1.accountId = t2.parentId and t1.category = t2.parentcategory ' +
              ' Set t1.Levelno = t2.Levelno+1 where ifnull(t2.Levelno,0)<>0 and ifnull(t1.parentId,0)<>0;');
      SQL.add('/*38*/update ' + tablename +'  T1 left join  ' + tablename +'  t2 on t1.accountId = t2.parentId and t1.category = t2.parentcategory ' +
              ' Set t1.Levelno = t2.Levelno+1 where ifnull(t2.Levelno,0)<>0 and ifnull(t1.parentId,0)<>0;');
      SQL.add('/*39*/update ' + tablename +'  T1 left join  ' + tablename +'  t2 on t1.accountId = t2.parentId and t1.category = t2.parentcategory ' +
              ' Set t1.Levelno = t2.Levelno+1 where ifnull(t2.Levelno,0)<>0 and ifnull(t1.parentId,0)<>0;');
      SQL.add('/*40*/Drop table if exists ' + tablename +'2;');


      // data and sub totals
      SQL.add('/*41*/drop table if exists ' + tablename +'1;');
      s:= '/*42*/Create table ' + tablename +'1 '+
            ' Select distinct '+
                '"Data" as Recordtype, T1.childcount, '+
                'T1.Accountname , '+
                'T1.ParentID, T1.ParentCategory ,'+
                'T1.COAtype, '+
                'T1.ID as ID,'+
                'T1.SortOrder as SortOrder,'+
                'T1.accountId as accountId,'+
                'T1.category as category ,'+
                'if(ifnull(T1.Level1,"")="" ,T1.Accounttype , T1.Level1) as Level1,'+
                'if(ifnull(T1.Level2,"")="" and ifnull(T1.Level1,"")  <> "",T1.Accounttype , T1.Level1) as Level2,'+
                'if(ifnull(T1.Level3,"")="" and ifnull(T1.Level2,"")  <> "" and ifnull(T1.Level1,"") <> "",T1.Accounttype , T1.Level2) as Level3,'+
                'if(ifnull(T1.Level4,"")="" and ifnull(T1.Level3,"")  <> "" and ifnull(T1.Level2,"") <>"" and ifnull(T1.Level1,"") <> "",T1.Accounttype , T1.Level3) as Level4,'+
                'if(ifnull(T1.Level1,"")<>"" and ifnull(T1.Level2,"") <> "" and ifnull(T1.Level3,"") <>"" and ifnull(T1.Level4,"") <> "",T1.Accounttype , "") as Level5,'+
                'concat(if(T1.level4<> "", REPEAT("  ",16) , '+
                              'if(T1.level3<> "", REPEAT("  ",12) ,'+
                              'if(T1.level2<> "", REPEAT("  ",8) , '+
                              'if(T1.level1<> "", REPEAT("  ",4) , "")))),'+
                              'if(ifnull(T1.Reportcaption,"")="", T1.Accountname, T1.ReportCaption) ) as reportCaption,'+
                'T1.LevelNo as Levelno,'+
                'if(ifnull(T2.ID,0)=0, T1.Balance , 0) '               +' as balance, ' ;

      s:= s + ClassFields(' if(ifnull(T2.ID,0)=0, T1."ClassIDFieldPrefix"DebitsEx , 0) '               +' as "ClassIDFieldPrefix"DebitsEx, ' +
                          ' if(ifnull(T2.ID,0)=0, T1."ClassIDFieldPrefix"DebitsInc, 0) '               +' as "ClassIDFieldPrefix"DebitsInc,'+
                          ' if(ifnull(T2.ID,0)=0, T1."ClassIDFieldPrefix"CreditsEx, 0) '               +' as "ClassIDFieldPrefix"CreditsEx,'+
                          ' if(ifnull(T2.ID,0)=0, T1."ClassIDFieldPrefix"CreditsInc,0) '               +' as "ClassIDFieldPrefix"CreditsInc, '+

                          ' if(ifnull(T2.ID,0)=0, /*T1."ClassIDFieldPrefix"CreditsEx - T1."ClassIDFieldPrefix"DebitsEx*/'+ Balance('T1."ClassIDFieldPrefix"CreditsEx' ,'T1."ClassIDFieldPrefix"DebitsEx' ,'T1.COAType') +'  , 0) ' +' as "ClassIDFieldPrefix"BalanceEx,'+
                          ' if(ifnull(T2.ID,0)=0, /*T1."ClassIDFieldPrefix"CreditsInc- T1."ClassIDFieldPrefix"DebitsInc*/'+ Balance('T1."ClassIDFieldPrefix"CreditsInc' ,'T1."ClassIDFieldPrefix"DebitsInc' ,'T1.COAType') +' , 0) ' +' as "ClassIDFieldPrefix"BalanceInc,  ');


      s:= s +'if(ifnull(T2.ID,0)=0, T1.DebitsEx , 0) '               +' as DebitsEx, ' +
                  'if(ifnull(T2.ID,0)=0, T1.DebitsInc, 0) '               +' as DebitsInc,'+
                  'if(ifnull(T2.ID,0)=0, T1.CreditsEx, 0) '               +' as CreditsEx,'+
                  'if(ifnull(T2.ID,0)=0, T1.CreditsInc,0) '               +' as CreditsInc, '+
                  'if(ifnull(T2.ID,0)=0, /*T1.CreditsEx - T1.DebitsEx*/'+ Balance('T1.CreditsEx' ,'T1.DebitsEx' ,'T1.COAType') +'   , 0) ' +' as BalanceEx,'+
                  'if(ifnull(T2.ID,0)=0, /*T1.CreditsInc - T1.DebitsInc*/'+ Balance('T1.CreditsInc' ,'T1.DebitsInc' ,'T1.COAType') +' , 0) ' +' as BalanceInc, '+
                Quotedstr(FormatdateTime(MySQLdateTimeformat, ReportAsOn))+' as DateTo '+
                '  from  ' + fsTablename +' T1 '+
                 '  Left join  ' + fsTablename +' T2 on T1.accountId = T2.ParentId and T1.category = T2.parentCategory ' ;
      s:= s +' union all '+
                ' Select distinct'+
                ' "Total" as Recordtype,  T1.childcount, '+
                'T1.Accountname , '+
                'T1.ParentID, T1.ParentCategory ,'+
                'T1.COAtype, '+
                ' T1.ID as ID, '+
                ' NULL as SortOrder, '+
                ' T1.accountId as accountId, '+
                ' T1.category as category , '+
                ' if(ifnull(T1.Level1,"")="" ,T1.Accounttype , T1.Level1) as Level1, '+
                ' if(ifnull(T1.Level2,"")="" and ifnull(T1.Level1,"") <> "",T1.Accounttype , T1.Level1) as Level2, '+
                ' if(ifnull(T1.Level3,"")="" and ifnull(T1.Level2,"")<>"" and ifnull(T1.Level1,"") <> "",T1.Accounttype , T1.Level2) as Level3, '+
                ' if(ifnull(T1.Level4,"")="" and ifnull(T1.Level3,"")<>"" and ifnull(T1.Level2,"")<>"" and ifnull(T1.Level1,"") <> "",T1.Accounttype , T1.Level3) as Level4, '+
                ' if(ifnull(T1.Level1,"")<>"" and ifnull(T1.Level2,"")<>"" and ifnull(T1.Level3,"")<>"" and ifnull(T1.Level4,"")<>"" , T1.Accounttype , "") as Level5, '+
                ' concat( if(T1.level4<> "", REPEAT("  ",16) ,  '+
                                     ' if(T1.level3<> "", REPEAT("  ",12) , '+
                                     ' if(T1.level2<> "", REPEAT("  ",8) ,  '+
                                     ' if(T1.level1<> "", REPEAT("  ",4) , "")))), '+
                                     ' "Total of " , if(ifnull(T1.Reportcaption,"")="", T1.Accountname, T1.ReportCaption) ) as reportCaption, '+
                ' T1.LevelNo as Levelno,'+
                ' (T1.balance) as balance, ';
      s:= s + ClassFields( ' (T1."ClassIDFieldPrefix"DebitsEx) as "ClassIDFieldPrefix"DebitsEx, '+
                ' (T1."ClassIDFieldPrefix"DebitsInc) as "ClassIDFieldPrefix"DebitsInc, '+
                ' (T1."ClassIDFieldPrefix"CreditsEx) as "ClassIDFieldPrefix"CreditsEx, '+
                ' (T1."ClassIDFieldPrefix"CreditsInc) as "ClassIDFieldPrefix"CreditsInc, '+
                ' /*(T1."ClassIDFieldPrefix"CreditsEx - T1."ClassIDFieldPrefix"DebitsEx    )*/ '+ Balance('T1."ClassIDFieldPrefix"CreditsEx' ,' T1."ClassIDFieldPrefix"DebitsEx' ,'T1.COAType') +' as "ClassIDFieldPrefix"BalanceEx, '+
                ' /*(T1."ClassIDFieldPrefix"CreditsInc - T1."ClassIDFieldPrefix"DebitsInc  )*/ '+ Balance('T1."ClassIDFieldPrefix"CreditsInc' ,' T1."ClassIDFieldPrefix"DebitsInc' ,'T1.COAType') +'  as "ClassIDFieldPrefix"BalanceInc, ');

      s:= s +' (T1.DebitsEx) as DebitsEx, '+
                ' (T1.DebitsInc) as DebitsInc, '+
                ' (T1.CreditsEx) as CreditsEx, '+
                ' (T1.CreditsInc) as CreditsInc, '+
                ' /*(T1.CreditsEx - T1.DebitsEx    ) */ '+ Balance('T1.CreditsEx' ,' T1.DebitsEx' ,'T1.COAType') +' as BalanceEx, '+
                ' /*(T1.CreditsInc - T1.DebitsInc  ) */ '+ Balance('T1.CreditsInc' ,' T1.DebitsInc' ,'T1.COAType') +' as BalanceInc, '+
                Quotedstr(FormatdateTime(MySQLdateTimeformat, ReportAsOn))+' as DateTo '+
                '  from  ' + fsTablename +' T1 '+
                '  inner join  ' + fsTablename +' T2 on T1.accountId = T2.ParentId and T1.category = T2.parentCategory '+
                ' group by T2.ParentId , T2.parentCategory'+
                ' order by SortOrder;';
      SQL.add(s);

{accounttype (root) balance from its child accounts}
      SQL.add('/*43*/drop table if exists ' + tablename +'2 ;');
      s:= '/*44*/Create table ' + tablename +'2  select distinct T1.AccountId, T1.category , ' +
                ' T2.balance as Balance,';

      s:= s + ClassFields( '/*(T2."ClassIDFieldPrefix"CreditsEx - T2."ClassIDFieldPrefix"DebitsEx  )*/ '+ Balance('T2."ClassIDFieldPrefix"CreditsEx' ,' T2."ClassIDFieldPrefix"DebitsEx' ,'T2.COAType') +'  as "ClassIDFieldPrefix"BalanceEx, '+
                           '/*(T2."ClassIDFieldPrefix"CreditsInc- T2."ClassIDFieldPrefix"DebitsInc )*/ '+ Balance('T2."ClassIDFieldPrefix"CreditsInc' ,' T2."ClassIDFieldPrefix"DebitsInc' ,'T2.COAType') +'  as "ClassIDFieldPrefix"BalanceInc ,');


      s:= s + ' /*(T2.CreditsEx - T2.DebitsEx  )*/ '+ Balance('T2.CreditsEx' ,' T2.DebitsEx' ,'T1.COAType') +'  as BalanceEx, '+
              ' /*(T2.CreditsInc- T2.DebitsInc )*/ '+ Balance('T2.CreditsInc' ,' T2.DebitsInc' ,'T1.COAType') +'  as BalanceInc '+
              ' from '+ tablename +'1 T1 inner join '+ tablename +'1  t2 on T1.accountId = T2.ParentId and T1.category = T2.parentCategory ' +
              ' where T1.category ="AT" and ((T1.RecordType ="Data" and T1.childcount =0 ) or (T1.RecordType ="Total" and T1.childcount >0 ));' ;
      SQL.add(s);


      SQL.add('/*43*/drop table if exists ' + tablename +'3 ;');
      s:= '/*44*/Create table ' + tablename +'3  select AccountId, category , ' ;

      s:= s + ClassFields( 'SUM("ClassIDFieldPrefix"BalanceEx) as "ClassIDFieldPrefix"BalanceEx, ' +
                           'SUM("ClassIDFieldPrefix"BalanceInc) as "ClassIDFieldPrefix"BalanceInc,  ');

      s:= s +   ' SUM(BalanceEx) as BalanceEx, ' +
                ' SUM(BalanceInc) as BalanceInc,  ' +
                'sum(balance) as Balance '+
                ' from '+ tablename +'2' +
                ' group by AccountId, category;' ;
      SQL.add(s);

      s:= '/*45*/Update ' + tablename +'1 T1 inner join '+ tablename +'3 T2 on T1.AccountId = T2.AccountId and T1.Category = T2.Category '+
                  ' Set  ' ;

      s:= s + ClassFields( 'T1."ClassIDFieldPrefix"balanceEx = T2."ClassIDFieldPrefix"Balanceex, '+
                           'T1."ClassIDFieldPrefix"balanceInc = T2."ClassIDFieldPrefix"BalanceInc ,  ');

      s:= s +   '   T1.balance = T2.balance ,  '+
                  ' T1.balanceEx = T2.Balanceex, '+
                  ' T1.balanceInc = T2.BalanceInc  '+
                  ' Where T1.recordtype ="Total"; ' ;
      SQL.add(s);

      SQL.add('/*46*/drop table if exists ' + tablename +'2 ;');
      SQL.add('/*46*/drop table if exists ' + tablename +'3 ;');

{get sort order for the sub totals to be placed after the details records}
      SQL.add('/*47*/drop table if exists ' + tablename +'2 ;');
      SQL.add('/*48*/Create table ' + tablename +'2 '+
                ' select '+
                ' t1.AccountId, t1.category , max(T2.sortOrder) sortOrder '+
                ' from ' + tablename +'1 T1 inner join ' + tablename +'1 T2  on T1.accountId = T2.ParentId and T1.category = T2.parentCategory  /*and ifnull(t1.sortOrder,0)=0*/   group by t1.AccountId, t1.category ;');


      SQL.add('/*49*/update ' + tablename +'1 t1 inner join ' + tablename +'2 t2 on '+
                ' t1.AccountId = t2.AccountId and  t1.category =  t2.category  and t1.recordtype ="Total" '+
                ' Set t1.sortorder = t2.sortorder +0.01;');


      SQL.add('/*50*/drop table if exists ' + tablename +'2 ;');
      SQL.add('/*51*/Create table ' + tablename +'2 '+
                ' select '+
                ' t1.AccountId, t1.category , max(T2.sortOrder) sortOrder '+
                ' from ' + tablename +'1 T1 inner join ' + tablename +'1 T2  on T1.accountId = T2.ParentId and T1.category = T2.parentCategory  /*and ifnull(t1.sortOrder,0)=0*/   group by t1.AccountId, t1.category ;');

      SQL.add('/*52*/update ' + tablename +'1 t1 inner join ' + tablename +'2 t2 on '+
                ' t1.AccountId = t2.AccountId and  t1.category =  t2.category  and t1.recordtype ="Total" '+
                ' Set t1.sortorder = t2.sortorder +0.01;');


      SQL.add('/*53*/drop table if exists ' + tablename +'2 ;');
      SQL.add('/*54*/Create table ' + tablename +'2 '+
                ' select '+
                ' t1.AccountId, t1.category , max(T2.sortOrder) sortOrder '+
                ' from ' + tablename +'1 T1 inner join ' + tablename +'1 T2  on T1.accountId = T2.ParentId and T1.category = T2.parentCategory  /*and ifnull(t1.sortOrder,0)=0*/  group by t1.AccountId, t1.category ;');

      SQL.add('/*55*/update ' + tablename +'1 t1 inner join ' + tablename +'2 t2 on '+
                ' t1.AccountId = t2.AccountId and  t1.category =  t2.category  and t1.recordtype ="Total" '+
                ' Set t1.sortorder = t2.sortorder +0.01;');

      SQL.add('/*56*/drop table if exists ' + tablename +'2 ;');
      SQL.add('/*57*/Create table ' + tablename +'2 '+
                ' select '+
                ' t1.AccountId, t1.category , max(T2.sortOrder) sortOrder '+
                ' from ' + tablename +'1 T1 inner join ' + tablename +'1 T2  on T1.accountId = T2.ParentId and T1.category = T2.parentCategory  /*and ifnull(t1.sortOrder,0)=0*/   group by t1.AccountId, t1.category ;');

      SQL.add('/*58*/update ' + tablename +'1 t1 inner join ' + tablename +'2 t2 on '+
                ' t1.AccountId = t2.AccountId and  t1.category =  t2.category  and t1.recordtype ="Total" '+
                ' Set t1.sortorder = t2.sortorder +0.01;');

      SQL.add('/*59*/drop table if exists ' + tablename +'2 ;');
      SQL.add('/*60*/Create table ' + tablename +'2 '+
                ' select '+
                ' t1.AccountId, t1.category , max(T2.sortOrder) sortOrder '+
                ' from ' + tablename +'1 T1 inner join ' + tablename +'1 T2  on T1.accountId = T2.ParentId and T1.category = T2.parentCategory  /*and ifnull(t1.sortOrder,0)=0*/   group by t1.AccountId, t1.category ;');

      SQL.add('/*61*/update ' + tablename +'1 t1 inner join ' + tablename +'2 t2 on '+
                ' t1.AccountId = t2.AccountId and  t1.category =  t2.category  and t1.recordtype ="Total" '+
                ' Set t1.sortorder = t2.sortorder +0.01;');

      SQL.add('/*62*/drop table if exists ' + tablename +'2 ;');
      SQL.add('/*63*/drop table if exists ' + tablename +';');
      SQL.add('/*64*/rename table ' + tablename +'1 to ' + tablename +';');

      s:= '/*65*/Create table '+ Tablename +'1  select  TR.accountId,  ' ;
      if QryClasses.recordcount > 0 then begin
        QryClasses.first;
        while QryClasses.Eof = False do begin
          s:= s+  ' sum(if(TR.ClassID =' + inttostr(QryClasses.FieldByName('Classid').AsInteger)+' , TR.creditsEx  , 0)) as '+ ClassIDFieldPrefix + 'creditsEx ,  ' ;
          s:= s+  ' sum(if(TR.ClassID =' + inttostr(QryClasses.FieldByName('Classid').AsInteger)+' , TR.DebitsEx   , 0)) as '+ ClassIDFieldPrefix + 'DebitsEx  ,  ' ;
          s:= s+  ' sum(if(TR.ClassID =' + inttostr(QryClasses.FieldByName('Classid').AsInteger)+' , TR.creditsinc , 0)) as '+ ClassIDFieldPrefix + 'creditsinc,  ' ;
          s:= s+  ' sum(if(TR.ClassID =' + inttostr(QryClasses.FieldByName('Classid').AsInteger)+' , TR.Debitsinc  , 0)) as '+ ClassIDFieldPrefix + 'Debitsinc ,  ' ;
          QryClasses.Next;
        end;
      end;
      s:= s+  ' sum(TR.creditsEx)   as creditsEx ,  ' +
              ' sum(TR.DebitsEx)    as DebitsEx,  ' +
              ' sum(TR.creditsinc)  as creditsinc ,  ' +
              ' sum(TR.Debitsinc)   as Debitsinc ' +
              ' from '+ iif(reportAsOn >= Appenv.CompanyPrefs.SummarisedTransDate(*ClosingDate*) ,'tblTRansactions' ,'tbltransactionsummarydetails') +
              '  TR  where TR.accountID  in (select AccountId from '+ Tablename +' T  where  T.category ="COA") ' +
              ' and  TR.date <= ' + Quotedstr(formatDateTime(MysqlDateTimeFormat , reportAsOn)) +'  ' +
              ' group by TR.accountId;';
      SQL.Add(s);
      SQL.add('/*66*/update '+ Tablename +' T1 inner join '+ Tablename +'1 T2 on T1.accountId = T2.accountId and t1.category ="COA"  and T1.recordtype ="Data" '+
                        ' Set T1.debitsex = T2.debitsEx,  '+
                        '     T1.Creditsex = T2.CreditsEx,  '+
                        '     T1.debitsinc = T2.debitsinc,  '+
                        '     T1.Creditsinc = T2.Creditsinc;');

      SQL.add(ClassFields('/*67*/update '+ Tablename +' T1 inner join '+ Tablename +'1 T2 on T1.accountId = T2.accountId and t1.category ="COA" and T1.recordtype ="Data"  '+
                        ' Set T1."ClassIDFieldPrefix"debitsex  = T2."ClassIDFieldPrefix"debitsEx,  '+
                        '     T1."ClassIDFieldPrefix"Creditsex = T2."ClassIDFieldPrefix"CreditsEx,  '+
                        '     T1."ClassIDFieldPrefix"debitsinc = T2."ClassIDFieldPrefix"debitsinc,  '+
                        '     T1."ClassIDFieldPrefix"Creditsinc= T2."ClassIDFieldPrefix"Creditsinc;'));
      clog(SQl.text);
      Execute;
    end;
  finally
    DbSharedObj.ReleaseObj(fScript);
  end;

end;

procedure TCustomAccountsReportObj.SetSelectedClasses(const Value: String);
begin
  fsSelectedClasses := Value;
  //fSelectedDepartmentList.commatext:=Value;
end;

function TCustomAccountsReportObj.ClassIDFieldPrefix(classno:integer=0):String;  begin result := 'Class' + trim(inttostr(iif(classno=0,QryClasses.REcno,classno)));end;
function TCustomAccountsReportObj.getDebitsExField   :String;  begin result := ClassIDFieldPrefix+'DebitsEx'  ;end;
function TCustomAccountsReportObj.getCreditsExField  :String;  begin result := ClassIDFieldPrefix+'CreditsEx' ;end;
function TCustomAccountsReportObj.getDebitsIncField  :String;  begin result := ClassIDFieldPrefix+'DebitsInc' ;end;
function TCustomAccountsReportObj.getCreditsIncField :String;  begin result := ClassIDFieldPrefix+'CreditsInc';end;
function TCustomAccountsReportObj.ClassnamesReportSQL: String;
begin
  REsult := '';
  With QryClasses do begin
    if recordcount > 0 then begin
        first;
        while Eof = False do begin
          if (FieldByName('ClassSelected').AsBoolean) then begin
            if result <> '' then result := result +',' ;
            result := result +Quotedstr(FieldByName('Classname').asString)+' as Classname'+ inttostr(recno);
          end;
          Next;
        end;
        result := 'Select '+ result +' From Dual';
    end;
  end;
end;
function TCustomAccountsReportObj.ReportSQL:String;
var
  ctr:Integer;
  fsClassnames, fsDetails:String;
begin
  REsult := '';
  fsClassnames := '';
  fsDetails:= '';
  ctr :=1;
  With QryClasses do begin
    if recordcount > 0 then begin
        first;
        while (Eof = False) or (ctr<=10) do begin
          if (FieldByName('ClassSelected').AsBoolean) then begin
            if fsClassnames <> '' then fsClassnames := fsClassnames +',' ;
            fsClassnames := fsClassnames +Quotedstr(iif(eof ,'' , FieldByName('Classname').asString))+' as Classname'+ inttostr(ctr);

            if fsDetails<> '' then fsDetails := fsDetails +',';
            fsDetails:= fsDetails + iif(eof ,'0.00' , DebitsExfield)    + ' as  '+  ClassIDFieldPrefix(ctr)+'debitsEx,' +
                      iif(eof ,'0.00' , CreditsExfield)   + ' as  '+  ClassIDFieldPrefix(ctr)+'creditsEx,' +
                      iif(eof ,'0.00' , DebitsIncfield)   + ' as  '+  ClassIDFieldPrefix(ctr)+'debitsinc,' +
                      iif(eof ,'0.00' , CreditsIncfield)  + ' as  '+  ClassIDFieldPrefix(ctr)+'Creditsinc,' +
                      iif(eof ,'0.00' , Balance(CreditsExfield ,DebitsExfield ,'COAType') )  + ' as  '+  ClassIDFieldPrefix(ctr)+'BalanceEx,' +
                      iif(eof ,'0.00' , Balance(Creditsincfield ,Debitsincfield ,'COAType'))  + ' as  '+  ClassIDFieldPrefix(ctr)+'Balanceinc'  ;
            ctr:= ctr+1;
          end;
          if not eof then Next;
        end;
        fsClassnames := 'Select '+ fsClassnames +','+
                    Quotedstr(formatDateTime(MysqlDateTimeFormat , reportAsOn))+' as DAteTo  From Dual';
        fsDetails:= 'Select AccountName, Level1, Level2, Level3, Level4, Level5, ReportCaption , '+
                    fsDetails +' ,DebitsEx, DebitsInc, CreditsEx, CreditsInc, BalanceEx, balanceInc '+
                    ' from ' +tablename +' order by SortOrder';
        Result := fsDetails +' ~|||~ {Classnames}'+fsClassnames;
    end;

  end;

    //fsClassnames := 'Select * from ' +fsTablename +' Order by SortOrder';
end;

end.
