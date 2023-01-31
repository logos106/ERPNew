unit BusObjPrejerenceToExport;

  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  03/09/18  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TPrejerenceToExport = class(TMSBusObj)
  private
    fbExternalTable :boolean;
    fsLocalSQL:String;
    function Getpage            : string    ;
    function GetDescription     : string    ;
    function GetPreftype        : string    ;
    function GetReftype         : string    ;
    function GetGroupDesc       : string    ;
    function GetPrefname        : string    ;
    function GetFieldtype       : string    ;
    function GetFieldValue      : string    ;
    function GetdefaultValue    : string    ;
    Function GetPreftypeno      : Integer;
    Function GetPrefID          : Integer;
    procedure InitTableSQL;
    procedure MakeTable;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    procedure Load(const fIsReadonly:boolean =False); override;
    class function PrefLisSQL(const aPrefname: String=''): String;
    class Function formatedfieldValue(Const aValue:String; const areftype:String;const afieldtype:String;aGroupDEsc:String =''; adescription :String =''):String;
  published
    property page             :string      read Getpage           ;
    property Description      :string      read GetDescription    ;
    property Preftype         :string      read GetPreftype       ;
    property Reftype          :string      read GetReftype        ;
    property GroupDesc        :string      read GetGroupDesc      ;
    property Prefname         :string      read GetPrefname       ;
    property Fieldtype        :string      read GetFieldtype      ;
    property FieldValue       :string      read GetFieldValue     ;
    property defaultValue     :string      read GetdefaultValue   ;
    Property Preftypeno       :Integer     read getPreftypeno;
    Property PrefID           :Integer     read getPrefID;

  end;


implementation


uses ERPdbComponents, tcDataUtils, CommonLib, AppEnvironment, DbSharedObjectsObj, CommonDbLib,sysutils,
  tcConst, LogLib;



  {TPrejerenceToExport}

constructor TPrejerenceToExport.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fbIsReadonly:= True;
  fBusObjectTypeDescription:= 'prejerencetoexport';
  fsql := 'Select * from '+ BusObjectTablename;
  MakeTable;

end;
Procedure TPrejerenceToExport.InitTableSQL;
begin
   fsLocalSQL :=PrefLisSQL;
end;
Class Function TPrejerenceToExport.PrefLisSQL(Const aPrefname:String = ''):String;
var
  qry: TERPQuery;
begin
  {tbldbpreferences}
  Result := 'select  @rownum:=@rownum+1 ID, ' +
          ' 1 as Preftypeno, ' +
          ' P.PrefId as PrefId , '+
          ' P.Preftype as Preftype, ' +
          ' P.Reftype as Reftype, ' +
          ' substring(Page,2,Length(Page)-Length("PrefsGUI")-1) as page, ' +
          ' PD.Description as Description, ' +
          ' PD.GroupDesc as GroupDesc, ' +
          ' P.name as Prefname, ' +
          ' P.fieldValue as FieldValue, ' +
          ' P.defaultValue as defaultValue, ' +
          ' P.mstimeStamp as mstimeStamp ,' +
          ' PreftypeToSQLType(P.FieldType) as FieldType '+
          ' from tbldbpreference_description PD ' +
          ' inner join tbldbpreferences  P on PD.Name = P.name  and not(PD.Preftype in ("ptcolumnHeadings" , "ptemployees")),  ' +
          ' (SELECT @rownum:=0) r ' +
          ' where PD.IsERPInternalPreference ="F" and PD.IsNOtinUse ="F" ' ;
  if aPrefname <> '' then REsult := Result + ' and PD.name = '+quotedstr(aPrefname) ;

    {tblpersonalPreferences - employee}
    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    try
      qry.sql.text := 'select distinct ' +
                  'concat('+quotedstr('select @rownum:=@rownum+1 ID, 2 as Preftypeno,PD.PrefID as PrefID,  PD.Preftype as Preftype,null as reftype, '+
                                              'substring(PD.Page,2,Length(PD.Page)-Length("PrefsGUI")-1) as page,  '+
                                              'PD.Description as Description,'+
                                              'PD.GroupDesc as GroupDesc,'+
                                              'PD.name as Prefname, '+
                                              'convert(PP.prefvalue, char(255)) as FieldValue,'+
                                              'NULL as defaultValue,'+
                                              'NULL as mstimeStamp, '+
                                              'Field_Type("tblpersonalpreferences" ,  "' + AppEnv.AppDb.Database+'" , '+' name '+') as fieldtype  '+
                                              ' from tbldbpreference_description PD ,')+
                              ','+
                              Quotedstr('(Select ')+
                              ', name ,'+
                              quotedstr(' as PrefValue , '+
                                                            'mstimeStamp '+
                                                            'From tblpersonalpreferences '+
                                                            'where (EmployeeId =1 ) '+
                                                            'order by EmployeeId  desc limit 1) PP ')+
                              ',' +
                              Quotedstr(' where PD.name = "')+
                              ' , name, '+
                              quotedstr('" and Preftype ="ptemployees" and PD.IsERPInternalPreference ="F" and PD.IsNOtinUse ="F" ')+
                             ') details  '+
                             ' from tbldbpreference_description  '+
                             ' where  '+
                             iif(aprefname <>'' , 'name = '+quotedstr(aprefname) , ' ifnull(name,"")<>""  ')+
                             ' and  Preftype = "ptemployees"   '+
                             ' and IsERPInternalPreference ="F"  '+
                             ' and IsNOtinUse ="F" ';
      qry.open;
      if qry.recordcount > 0 then
      Result := Result +NL+' union all ' + qry.GroupConcat('details' ,'', False, NL+ ' Union All  ' );

    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    end;

    {tblcolumn headings}
    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    try
      qry.sql.text := 'select distinct ' +
                  'concat('+quotedstr('select @rownum:=@rownum+1 ID, 3 as Preftypeno,PD.PrefID as PrefID, PD.Preftype as Preftype,null as reftype, '+
                                              'substring(PD.Page,2,Length(PD.Page)-Length("PrefsGUI")-1) as page,  '+
                                              'PD.Description as Description,'+
                                              'PD.GroupDesc as GroupDesc,'+
                                              'PD.name as Prefname, '+
                                              'convert(PP.prefvalue, char(255)) as FieldValue,'+
                                              'NULL as defaultValue,'+
                                              'NULL as mstimeStamp, '+
                                              'Field_Type("tblcolumnheadings" ,  "' + AppEnv.AppDb.Database+'" , '+' name '+') as fieldtype  '+
                                              ' from tbldbpreference_description PD ,'+
                                              '(Select ')+ ', name ,'+quotedstr(' as PrefValue , '+
                                                            'mstimeStamp '+
                                                            'From tblcolumnheadings ) PP '+
                                              ' where PD.name = "')+' , name, '+quotedstr('" and Preftype ="ptcolumnHeadings" and PD.IsERPInternalPreference ="F" and PD.IsNOtinUse ="F" ')+
                             ') details  from tbldbpreference_description '+
                             ' where  '+
                             iif(aprefname <>'' , 'name = '+quotedstr(aprefname) , ' ifnull(name,"")<>""  ')+
                             ' and Preftype = "ptcolumnHeadings"   '+
                             'and IsERPInternalPreference ="F"  '+
                             'and IsNOtinUse ="F" ';
      qry.open;
      if qry.recordcount > 0 then
      Result := Result +NL+' union all ' + qry.GroupConcat('details' ,'', False, NL+ ' Union All  ' );
    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    end;
end;


destructor TPrejerenceToExport.Destroy;
begin
  DestroyUserTemporaryTable(BusObjectTablename);
  inherited;
end;

Procedure TPrejerenceToExport.MakeTable;
var
  scr :TERPScript;
  fieldname :String;
  ctr:Integer;
begin
  InitTableSQL;
  scr := DbSharedObj.GetScript(commondblib.GetSharedMyDacConnection);
  try
    With scr do begin
      SQL.Clear;
      SQL.Add('DROP Table if exists ' + BusObjectTablename +';');
      SQL.Add('CREATE TABLE  ' + BusObjectTablename +' ( ' +NL+
            ' ID            INT(11) NOT NULL AUTO_INCREMENT, ' +NL+
            ' Preftypeno    INT(11) Null Default 0,'+NL+
            ' PrefID        INT(11) Null Default 0,'+NL+
            ' reftype       VARCHAR(255) NULL DEFAULT NULL, ' +NL+
            ' Preftype      VARCHAR(255) NULL DEFAULT NULL, ' +NL+
            ' page          VARCHAR(255) NULL DEFAULT NULL, ' +NL+
            ' Description   VARCHAR(255) NULL DEFAULT NULL, ' +NL+
            ' GroupDesc     VARCHAR(255) NULL DEFAULT NULL, ' +NL+
            ' Prefname      VARCHAR(255) NULL DEFAULT NULL, ' +NL+
            ' FieldValue    MEDIUMTEXT NULL, ' +NL+
            ' defaultValue  MEDIUMTEXT NULL, ' +NL+
(*            ' cFieldValue    MEDIUMTEXT NULL, ' +NL+
            ' cdefaultValue  MEDIUMTEXT NULL, ' +NL+*)
            ' mstimeStamp   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, ' +NL+
            ' FieldType     VARCHAR(255) NULL DEFAULT NULL, ' +NL+
            ' PRIMARY KEY (ID) ) COLLATE="utf8_general_ci" ENGINE=MyISAM ;');

       SQL.Add('insert ignore into ' + BusObjectTablename + '(ID,Preftypeno,PrefID,Preftype, reftype, page, Description , GroupDesc, Prefname, FieldValue, defaultValue, mstimeStamp, FieldType) ' +
              fsLocalSQL);
      SQL.Add('Order by page , GroupDesc ,Description;' );


      {for those preferences thats commin in employee and company,
      get the Reftype from the companypref for the employee type as the employee pref(tblpersonalpreferences) doesn't have reftype
      eg: Liability Allowances (Default) (AllowanceLiabilityAccountID) }

      SQL.Add('Drop table if exists  ' + BusObjectTablename +'_1;');
      SQL.Add('Create table  ' + BusObjectTablename +'_1 Select  t2.id, t2.Prefname , t2.preftype , P.reftype ' +
              ' from ' + BusObjectTablename +' t1 ' +
              ' inner join ' + BusObjectTablename +' t2 on t1.Prefname = t2.Prefname ' +
              ' inner join tbldbpreferences P on t1.Prefname = P.name ' +
              ' where not(t1.preftype in ("ptcolumnHeadings" , "ptemployees")) ' +
              ' and (t2.preftype in ("ptcolumnHeadings" , "ptemployees"));');
      SQL.Add('update  ' + BusObjectTablename +'_1 T1 inner join ' + BusObjectTablename +' T2 on T1.Id = T2.Id set T2.reftype = T1.reftype;');
      SQL.Add('Drop table if exists  ' + BusObjectTablename +'_1;');

      {Format Values to user readable format}
      for ctr := 1 to 2 do begin
        if ctr =1 then fieldname := 'FieldValue' else fieldname := 'DefaultValue';
(*          SQL.Add('Update  ' + BusObjectTablename +' Set '+ FieldName+' = PrefDateToDate('+ FieldName+') where Fieldtype ="date";');
          SQL.Add('Update  ' + BusObjectTablename +' Set '+ FieldName+' = PrefDateTimeToDateTime('+ FieldName+') where Fieldtype ="datetime";');*)
          SQL.Add('Update  ' + BusObjectTablename +' Set '+ FieldName+' = "True" where Fieldtype ="enum" and '+ FieldName+'="T";');
          SQL.Add('Update  ' + BusObjectTablename +' Set '+ FieldName+' = "False" where Fieldtype ="enum" and '+ FieldName+'="F";');
          SQL.Add('Update   ' + BusObjectTablename +' T inner join tblChartofaccounts COA on Convert(T.'+ FieldName+', UNSIGNED) = COA.accountId '+
                                      ' Set T.'+ FieldName+' = COA.Accountname, T.fieldtype="varchar" '+
                                      ' where (T.Fieldtype="int" or T.fieldtype = "bigint") and (T.reftype="Account") and (T.'+ FieldName+'<>"");');
          SQL.Add('Update    ' + BusObjectTablename +'  T '+
                                      ' Set T.'+ FieldName+' = "N/A" , T.fieldtype="varchar"'+
                                      ' where (T.GroupDEsc ="Days in Advance for Reminder to Appear") and (T.'+ FieldName+'="-999999999");');
      end;
      clog(SQL.text);
      showProgress( waitmsg , SQL.Count);
      try
        stepProgress;
        Execute;
      finally
        HideProgress;
      end;
    end;
  finally
    DbSharedObj.ReleaseObj(scr);
  end;
end;
procedure TPrejerenceToExport.Load(const fIsReadonly: boolean);
begin
  inherited;
end;

procedure TPrejerenceToExport.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
end;


procedure TPrejerenceToExport.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'page' ,page);
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'Preftype' ,Preftype);
  AddXMLNode(node,'GroupDesc' ,GroupDesc);
  AddXMLNode(node,'Prefname' ,Prefname);
  AddXMLNode(node,'Fieldtype' ,Fieldtype);
  AddXMLNode(node,'FieldValue' ,FieldValue);
  AddXMLNode(node,'defaultValue' ,defaultValue);
  AddXMLNode(node,'Preftypeno' ,Preftypeno);
  AddXMLNode(node,'PrefID' ,PrefID);
end;


function TPrejerenceToExport.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TPrejerenceToExport.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TPrejerenceToExport.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TPrejerenceToExport.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TPrejerenceToExport.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TPrejerenceToExport.GetIDField: string;
begin
  Result := 'ID'
end;


class function TPrejerenceToExport.GetBusObjectTablename: string;
begin
  //Result:= '';
  result := 'tmp_PrejerenceToExport_'+inttostr(Appenv.Employee.EmployeeID);
end;


function TPrejerenceToExport.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TPrejerenceToExport.Getpage        : string    ; begin Result := GetStringField('page');end;
function  TPrejerenceToExport.GetDescription : string    ; begin Result := GetStringField('Description');end;
function  TPrejerenceToExport.GetPreftype    : string    ; begin Result := GetStringField('Preftype');end;
function  TPrejerenceToExport.GetReftype     : string    ; begin Result := GetStringField('Reftype');end;
function  TPrejerenceToExport.GetGroupDesc   : string    ; begin Result := GetStringField('GroupDesc');end;
function  TPrejerenceToExport.GetPrefname    : string    ; begin Result := GetStringField('Prefname');end;
function  TPrejerenceToExport.GetFieldtype   : string    ; begin Result := GetStringField('Fieldtype');end;
function  TPrejerenceToExport.GetdefaultValue: string    ; begin Result := GetStringField('defaultValue');end;
function  TPrejerenceToExport.getPreftypeno  : Integer   ; begin Result := GetIntegerField('Preftypeno');end;
function  TPrejerenceToExport.getPrefID      : Integer   ; begin Result := GetIntegerField('PrefID');end;


function  TPrejerenceToExport.GetFieldValue  : string    ;
begin
  REsult := FormatedFieldValue(GetStringField('FieldValue') , reftype, Fieldtype,GroupDEsc, description);
end;
Class function TPrejerenceToExport.formatedfieldValue(Const aValue:String; const areftype:String; const afieldtype:String;aGroupDEsc:String =''; adescription :String =''):String;
  function GetAsDateTime(Const Value:String): TDateTime;
  Begin
      If Value <> '' Then Result := StrToFloatDef(Value, 0) Else Result := 0;
  End;
begin
  REsult := aValue;
       if (Result ='') then
  else if sametext(aFieldtype , 'date'    ) then Result :=  SysUtils.formatDatetime(formatSettings.ShortDateFormat,  GetAsDateTime(Result ))
  else if sametext(aFieldtype , 'datetime') and (GetAsDateTime(Result ) <1) then Result :=  SysUtils.formatDatetime(formatSettings.ShortTimeFormat ,  GetAsDateTime(Result ))
  else if sametext(aFieldtype , 'datetime') then Result :=  SysUtils.formatDatetime(formatSettings.ShortDateFormat+' ' + formatSettings.ShortTimeFormat ,  GetAsDateTime(Result ))
  else if sametext(aFieldtype , 'enum'    ) and (sametext(result, 'T')) then Result :=  'True'
  else if sametext(aFieldtype , 'enum'    ) and (sametext(result, 'F')) then Result :=  'False'
  else if sametext(aFieldtype , 'double'  ) and (result<>'') then Result :=  FloatToStrF(Strtofloat(Result), ffGeneral, 15,2)
  else if (sametext(aFieldtype, 'int'     ) or (sametext(aFieldtype , 'bigint')))  and (sametext(areftype, 'Account')) and (result<>'') then Result :=  GetAccountName(strtoint(result))
  else if sametext(aGroupDEsc ,'Days in Advance for Reminder to Appear') and (sametext(AValue , '-999999999')) then Result := 'N/A'
  else if (Pos('Days in Advance for Reminder to Appear' , aGroupDEsc)>0) and (sametext(AValue , '-999999999')) then Result := 'N/A'
  else if sametext(aFieldtype , 'double') and (result='') then Result :=  '0.00';
end;

initialization
  RegisterClass(TPrejerenceToExport);
  //BusObjectListObj.TBusObjInfoList.Inst.Add('Preferences','TPrejerenceToExport','TPrejerenceToExportGUI');
end.
