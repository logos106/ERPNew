unit BusobjCustomFilter;
{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 10/05/07           BJ  initial version

                    TCustomFilter can be used without connecting to the dataset for handling the filters,
                    in which case the filter is stored in fsfilterstring. When need to store into the
                    database, connect to the dataset and move fsFilterString to the filterstatement
}
interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;

type
   TFiltertype = (unAssigned=0 ,AndFilter=1, OrFilter=2,AddPartial=3, OrPartial=4, AndExclude=5, OrExclude=6, AndPartialExclude=7, OrPartialExclude=8);

   TCustomFilter = class(TMSBusObj)
   private
      fsfilterString                    :String    ;
      fReportList                       :Tcomponent;

      Function  GetFilterName           :String    ;
      Function  GetReportname           :String    ;
      Function  GetFilterstatement      :String    ;
      Function  GetActive               :Boolean   ;
      Function  GetAllusers             :Boolean   ;
      Function  GetDefaultFilter        :Boolean   ;
      Function  GetUserid               :Integer   ;

      Procedure SetFilterName           (Const Value :String    );
      Procedure SetReportname           (Const Value :String    );
      Procedure SetFilterstatement      (Const Value :String    );
      Procedure SetActive               (Const Value :Boolean   );
      Procedure SetAllusers             (Const Value :Boolean   );
      Procedure SetDefaultFilter        (Const Value :Boolean   );
      Procedure SetUserid               (Const Value :Integer   );

   Protected
      procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);   Override;
      procedure DoFieldOnChange(Sender: TField);                           Override;
      Function  GetSQL : String;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
      Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean;            Override;
      Function  DoBeforeInsert(Sender :TDatasetBusObj ):Boolean;           Override;
   Public
      class function GetIDField: string; override;
      class function GetBusObjectTablename: string; Override;
      Constructor  Create(AOwner: TComponent);                             override;
      Destructor   Destroy;                                                override;
      Procedure    LoadFromXMLNode(Const node: IXMLNode);                  override;
      Procedure    SaveToXMLNode(Const node: IXMLNode);                    override;
      Function     ValidateData :Boolean ;                                 Override;
      Function     Save :Boolean ;                                         Override;

      Procedure   Addfilter(const Filterfield:TField; const FilterType :TFiltertype; filterValue :String ='');overload;
      Procedure   AddFilter(const FilterToAdd:String;const FilterType :TFiltertype);overload;
      Procedure   StartSection;
      Procedure   EndSection;
      Function    ValidateFilter:Boolean;
      Procedure   Preview;
      procedure   New; override;
   Published
      Property FilterName       :String  Read getFilterName      Write SetFilterName     ;
      Property Reportname       :String  Read getReportname      Write SetReportname     ;
      Property Filterstatement  :String  Read getFilterstatement Write SetFilterstatement;
      Property Active           :Boolean Read getActive          Write SetActive         ;
      Property Allusers         :Boolean Read getAllusers        Write SetAllusers       ;
      Property DefaultFilter    :Boolean Read getDefaultFilter   Write SetDefaultFilter  ;
      Property Userid           :Integer Read getUserid          Write SetUserid         ;
      Property ReportList       :TComponent REad fReportList     Write fReportList;
   End;


implementation

uses FastFuncs,tcDataUtils, sysutils, BaseListingForm,
   AppEnvironment, CommonLib;


{========================================================
         TCustomFilter
========================================================}
constructor TCustomFilter.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   fSQL := 'SELECT * FROM tblCustomFilters';
   fsfilterString := '';
end;


destructor TCustomFilter.Destroy;
begin
   inherited;
   fReportList := nil;
end;


procedure   TCustomFilter.LoadFromXMLNode(Const node: IXMLNode);
begin
   inherited;
    SetPropertyFromNode(Node,'FilterName');
    SetPropertyFromNode(Node,'Reportname');
    SetPropertyFromNode(Node,'Filterstatement');
    SetBooleanPropertyFromNode(Node,'Active');
    SetBooleanPropertyFromNode(Node,'Allusers');
    SetBooleanPropertyFromNode(Node,'DefaultFilter');
    SetPropertyFromNode(Node,'Userid');
end;


procedure   TCustomFilter.SaveToXMLNode(Const node: IXMLNode);
begin
   inherited;
      AddXMLNode(node,'FilterName' ,FilterName);
      AddXMLNode(node,'Reportname' ,Reportname);
      AddXMLNode(node,'Filterstatement' ,Filterstatement);
      AddXMLNode(node,'Active' ,Active);
      AddXMLNode(node,'Allusers' ,Allusers);
      AddXMLNode(node,'DefaultFilter' ,DefaultFilter);
      AddXMLNode(node,'Userid' ,Userid);
end;


function    TCustomFilter.ValidateData :Boolean ;
begin
   Result := False;
   Resultstatus.Clear;
   if Trim(Reportname) = '' then begin
      Resultstatus.AddItem(False , rssError , 0,  'Reportname should not be blank' );
      Exit;
   end;
   if Trim(FilterName) = '' then begin
      Resultstatus.AddItem(False , rssError , 0,  'FilterName should not be blank' );
      Exit;
   end;
   if Trim(Filterstatement) = '' then begin
      Resultstatus.AddItem(False , rssError , 0,  'Filterstatement should not be blank'  );
      Exit;
   end;
   if not ValidateFilter then Exit;
   Result := true;
end;


function    TCustomFilter.Save :Boolean ;
var
  ds: TDataset;
  sql: string;
begin
   Result := False;
   if not ValidateData then Exit;
   Result := Inherited Save;

   {there can be only one default filter for a form}
   if Defaultfilter then begin
      ds:= GetNewDataset('select id from tblcustomfilters where id <> ' +
                         IntToStr(ID) +
                         ' and reportname = ' + quotedStr(ReportName) +
                         ' and Defaultfilter = "T"', true);
      try
        if ds.RecordCount > 0 then begin
          while not ds.Eof do begin
            if sql <> '' then sql:= sql + #13#10;
            sql:= sql + 'update tblcustomfilters set Defaultfilter = "F" ' +
                        'where id = ' + ds.FieldByName('id').AsString + '; ';
            ds.Next;
          end;
          with GetNewDataset(sql,true) do
            free;
        end;
      finally
        ds.Free;
      end;
   end;
end;


procedure TCustomFilter.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;


procedure TCustomFilter.DoFieldOnChange(Sender: TField);
begin
   inherited;
end;


Function TCustomFilter.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;


class function  TCustomFilter.GetIDField : String;
begin
   Result := 'Id'
end;
class function TCustomFilter.GetBusObjectTablename: string;
begin
  Result := 'tblCustomFilters';
end;

Function  TCustomFilter.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;
Function  TCustomFilter.DoBeforeInsert(Sender :TDatasetBusObj ):Boolean;
begin
  Result := inherited DoBeforeInsert(sender);
  if not Result then Exit;
  Connection.BeginTransaction;
end;
Function  TCustomFilter.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
  Result := inherited DoAfterInsert(sender);
  if not Result then Exit;
  if Assigned(Self.Owner) and Assigned(ReportList) then  Reportname := ReportList.ClassName;
  Filterstatement  := ' ' + fsFilterstring;
  Active           := True;
  Allusers         := False;
  DefaultFilter    := False;
  UserId           := AppEnv.Employee.EmployeeID;
  filtername       := ' ';
  PostDB;
  editdb;
end;

{Property functions}
Function  TCustomFilter.GetReportname     :String    ; begin Result := GetStringField('Reportname');End;
Function  TCustomFilter.GetFilterName     :String    ; begin Result := GetStringField('FilterName');End;
Function  TCustomFilter.GetFilterstatement:String    ;
begin
    if DatasetAssigned then
        Result := GetStringField('Filterstatement')
    else Result := fsfilterString ;
End;

Function  TCustomFilter.GetActive         :Boolean   ; begin Result := GetBooleanField('Active');End;
Function  TCustomFilter.GetAllusers       :Boolean   ; begin Result := GetBooleanField('Allusers');End;
Function  TCustomFilter.GetDefaultFilter  :Boolean   ; begin Result := GetBooleanField('DefaultFilter');End;
Function  TCustomFilter.GetUserid         :Integer   ; begin Result := GetIntegerField('Userid');End;
Procedure TCustomFilter.SetReportname     (Const Value :String    ); begin SetStringField('Reportname'      , Value);End;
Procedure TCustomFilter.SetFilterName     (Const Value :String    ); begin SetStringField('FilterName'      , Value);End;
Procedure TCustomFilter.SetFilterstatement(Const Value :String    );
begin
    if DatasetAssigned then
        SetStringField('Filterstatement'      , Value)
    else
        fsfilterString := Value;
End;
Procedure TCustomFilter.SetActive         (Const Value :Boolean   ); begin SetBooleanField('Active'          , Value);End;
Procedure TCustomFilter.SetAllusers       (Const Value :Boolean   ); begin SetBooleanField('Allusers'        , Value);End;
Procedure TCustomFilter.SetDefaultFilter  (Const Value :Boolean   ); begin SetBooleanField('DefaultFilter'        , Value);End;
Procedure TCustomFilter.SetUserid         (Const Value :Integer   ); begin SetIntegerField('Userid'          , Value);End;

Procedure TCustomFilter.AddFilter(const FilterToAdd:String;const FilterType :TFiltertype );
begin
      if FilterToAdd <> '' then begin
        FilterStatement := Trim(FilterStatement);
        if (FilterStatement <> '') and (copy(Trim(FilterStatement),char_length(Trim(FilterStatement)) , 1) <> '(') then
            case FilterType of
                AndFilter,AddPartial,AndExclude,AndPartialExclude: FilterStatement := FilterStatement + ' AND ';
                OrFilter,OrPartial,OrExclude,OrPartialExclude: FilterStatement     := FilterStatement+ ' OR ';
            End;
        FilterStatement:= FilterStatement+ FilterToAdd;
      end;
end;
Procedure TCustomFilter.Addfilter(const Filterfield:TField; const FilterType :TFiltertype; filterValue :String ='');
var
    FilterToAdd:String;
begin
{}
    if not Assigned(Filterfield)                          then Exit;
    if filterfield.fieldKind in [fkLookup , fkCalculated] then Exit;
    if FilterType = unAssigned                            then exit;

    FilterToAdd := '';

    if filterValue = '' then filterValue := FilterField.asString;
    case FilterType of
        AndFilter,OrFilter  : FilterToAdd :=  '([' + FilterField.fieldName +'] = '  + QuotedStr(filterValue) +')';
        AddPartial,OrPartial: FilterToAdd :=  '([' + FilterField.fieldName +'] like '  + QuotedStr('*'+filterValue+'*') + ')';
        AndExclude,OrExclude: FilterToAdd :=  '([' + FilterField.fieldName +'] <> '  + QuotedStr(filterValue) + ')';
        AndPartialExclude,OrPartialExclude: FilterToAdd :=  '(not([' + FilterField.fieldName +'] like '  + QuotedStr(filterValue+'*') + '))';
    End;
    FilterStatement := Trim(FilterStatement);
    if FilterToAdd <> '' then begin
        if (FilterStatement <> '') and (copy(Trim(FilterStatement),char_length(Trim(FilterStatement)) , 1) <> '(') then
            case FilterType of
                AndFilter,AddPartial,AndExclude,AndPartialExclude: FilterStatement := FilterStatement + ' AND ';
                OrFilter,OrPartial,OrExclude,OrPartialExclude: FilterStatement     := FilterStatement+ ' OR ';
            End;
        {Cater For Empty String/Null Fields}
        filterValue  := Trim(filterValue);
        if (filterValue='') then
          FilterToAdd := '('+FilterToAdd+' OR ' + StringReplace(FilterToAdd,QuotedStr(filterValue),'Null',[rfReplaceAll, rfIgnoreCase])+')';

        FilterStatement:= FilterStatement+ FilterToAdd;
    end;
end;
Procedure TCustomFilter.StartSection;
begin
    if Trim(FilterStatement) <> '' then FilterStatement := FilterStatement+ ' AND ';
    FilterStatement:= FilterStatement+ '(';
end;

Procedure TCustomFilter.EndSection;
begin
    FilterStatement:= FilterStatement+ ')';
end;
function TCustomFilter.ValidateFilter:Boolean;
begin
    Resultstatus.Clear;
    result := CommonLib.StringCount(FilterStatement, '(' ) =CommonLib.StringCount(FilterStatement, ')' );
    if not result then Resultstatus.AddItem(False , rssError , 0,  'Open and close brackets don''t match' );
end;

procedure   TCustomFilter.New;
begin

    if not DatasetAssigned then
        Filterstatement := ''
    else begin
         inherited New;
         fsfilterString := '';
    end;
end;
Procedure TCustomFilter.Preview;
begin
    if ValidateFilter then
        if Assigned(Self.Owner) then
            if Self.Owner is TBaseListingGUI then
                TBaseListingGUI(Self.Owner).Qrymain.FilterSQL := FilterStatement;
end;

initialization
    RegisterClassOnce(TCustomFilter);

end.

