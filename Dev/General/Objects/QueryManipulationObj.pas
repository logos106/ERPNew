unit QueryManipulationObj;
{IB 9/2003 - This object is used to Dissect SQL , to enable Rebuilding with Extra where Statement

Acceptable SQL Structure :    1 -  All Field Must Have "As"
                              2 -  Each Field End In  "#13#10"
                              3 -  UNION ALL - "UNION-SPACE-ALL" (ie One Space Between Words)
                              4 - FROM starts on new line  }


interface

uses
  Classes, Contnrs;

Const
  Limit0 = 'Limit 0';
  UNIONALL = 'UNION ALL';
  NewLine = #13#10;
  sqlFrom = 'FROM';
  sqlWhere = 'WHERE';
  sqlGroupBy = 'GROUP BY';
  sqlOrderBy ='ORDER BY';

type

  TQueryRec = class(TObject)
  private
  public
    FieldsDesc: TStringList;
    Fields: string;
    From: string;
    Where: string;
    GroupBy: string;
    OrderBy: string;
    constructor Create;
    destructor Destroy; override;
  end;

type

  TQueryManipulationObj = class(TObject)
  private
    ListQueryItems: TObjectList;
    OriginalQuery: string;
    fsModifiedSQL: string;
    fsModifiedSQLMaxRecords: string;
    fslFilterItems: TStringList;
    fsSearchcondition: String;
    procedure CreateFilterItems;
    procedure SetUpQueryInfo;
    procedure AddRecord(const slFieldsDesc: TStringList; const sFields: string; const sFrom: string;
      const sWhere: string; const sGroupBy: string; const sOrderBy: string);
    procedure SetFieldDescription(const FieldsStr: string; const FieldsDesc: TStringList);
    function VaildateExpressionForWhereClause(const Expression: string): boolean;
    function GetFieldExpression(const SearchField: string; const UnionNo: integer): string;
    {$HINTS OFF}function QueryManipulationToText:String;{$HINTS ON}
  public
    constructor Create(const OrignalSql: string);
    destructor Destroy; override;
    procedure RefreshOrignalSQL(const OrignalSql: string; Addlimit0:Boolean =True);
    procedure ProcessSQLMaxRecords;
    procedure ProcessSearch(const SearchField, SearchValue: string; const EqualTo: boolean = true); overload;
    procedure ProcessSearch(const SearchField, SearchValue, OverrideWhereArguments: string; const EqualTo: boolean = true);
      overload;
    procedure ProcessSearch(const ExtraWhereArguments: string); overload;
    procedure ProcessSearchOR(const SearchField, BaseWhereArguments: string; const SearchValue: TStringList);
    property InVaildFilterItems: TStringList read fslFilterItems;
    property ModifiedSQL: string read fsModifiedSQL;
    property OriginalSQL: string read OriginalQuery;
    property ModifiedSQLMaxRecords: string read fsModifiedSQLMaxRecords;
    Property QueryList : TObjectList read ListQueryItems;
    Function SQLWithCustomfilterApplied(Const Value:String):String;
    Property Searchcondition :String read fsSearchcondition;
    Procedure ClearSearchcondition;

  end;

implementation

uses StrUtils, SysUtils, Dialogs, CommonLib;


{ TQueryRec }

constructor TQueryRec.Create;
begin
  inherited;
  FieldsDesc := nil;
  Fields := '';
  From := '';
  Where := '';
  GroupBy := '';
  OrderBy := '';
end;

destructor TQueryRec.Destroy;
begin
  If Assigned(FieldsDesc) then FreeandNil(FieldsDesc);
  inherited;
end;

{ TQueryManipulationObj }

procedure TQueryManipulationObj.RefreshOrignalSQL(const OrignalSql: string; Addlimit0:Boolean =True);
var
  TempList: TStringList;
  Index: integer;
  TempStr: string;
begin
  // Clear line items list
  ListQueryItems.Clear;
  fslFilterItems.Clear;
  //Remove Remarks ( Line That Start With '#')
  TempList := TStringList.Create;
  try
    TempList.Text := OrignalSql;
    index         := 0;
    while ((TempList.Count - 1) >= Index) do begin
      TempStr := LeftStr(TempList.Strings[index], 1);
      if (TempStr = '#') then begin
        TempList.Delete(index);
      end else begin
        Inc(index);
      end;
    end;
    //OriginalQuery := ReplaceStr(TempList.Text, ';', '') ;
    OriginalQuery := ReplaceStr(ReplaceStr(TempList.Text, ';', '') , Limit0 , '');
  finally
    FreeAndNil(TempList);
  end;
  SetUpQueryInfo;
  CreateFilterItems;

  if  (fsModifiedSQL ='') or (Sametext(trim(fsModifiedSQL) ,Limit0+';')) then
    fsModifiedSQL := OriginalQuery;

  if Addlimit0 then begin
    if Pos(Limit0, OriginalQuery) = 0 then begin
      fsModifiedSQL := ReplaceStr(OriginalQuery, UNIONALL, ' '+Limit0+' '+UNIONALL+' ');
      fsModifiedSQL := fsModifiedSQL + ' '+Limit0+';';
      fsModifiedSQL := ReplaceStr(OriginalQuery, ') '+Limit0, Limit0+' )');
    end;
  end else begin
    if Pos(Limit0, OriginalQuery) <> 0 then begin
      fsModifiedSQL := ReplaceStr(OriginalQuery, ' '+Limit0+' '+UNIONALL+' ', UNIONALL);
      fsModifiedSQL := ReplaceStr(OriginalQuery, ' '+Limit0+' )', ' )');
      fsModifiedSQL := ReplaceStr(fsModifiedSQL , ' '+Limit0+';',';');
    end;
  end;
end;



procedure TQueryManipulationObj.ClearSearchcondition;
begin
  fsSearchcondition := '';
end;

constructor TQueryManipulationObj.Create(const OrignalSql: string);
begin
  inherited Create;
  fsSearchcondition := '';
  ListQueryItems := TObjectList.Create(True);
  fslFilterItems := TStringList.Create;
  RefreshOrignalSQL(OrignalSql);
end;

destructor TQueryManipulationObj.Destroy;
begin
  FreeAndNil(ListQueryItems);
  FreeAndNil(fslFilterItems);
  inherited;
end;

procedure TQueryManipulationObj.AddRecord(const slFieldsDesc: TStringList;
  const sFields, sFrom, sWhere, sGroupBy, sOrderBy: string);
var
  QueryItem: TQueryRec;
begin
  QueryItem := TQueryRec.Create;
  with QueryItem do begin
    FieldsDesc := slFieldsDesc;
    Fields     := sFields;
    From       := sFrom;
    Where      := sWhere;
    GroupBy    := sGroupBy;
    OrderBy    := sOrderBy;
  end;
  ListQueryItems.Add(QueryItem);
end;

procedure TQueryManipulationObj.SetUpQueryInfo;
var
  x: integer;
  QuerySegmentCount: integer;
  slFieldsDesc: TStringList;
  QuerySegment, sFields, sFrom, sWhere, sGroupBy, sOrderBy, TempSQL: string;
begin
  QuerySegmentCount := CharCounter(UNIONALL, uppercase(OriginalQuery)); //Count Seperate Queries If Union
  for x := 1 to QuerySegmentCount do begin
    slFieldsDesc := TStringList.Create;
    //Get Query
    QuerySegment := ExtractStrPortion(uppercase(OriginalQuery), UNIONALL, x);
    TempSQL      := ReplaceText(QuerySegment,Limit0,'');
    //Fields
    {"select " on the first line and fields starting from seond line}
    sFields := Trim(ExtractStrPortion(ExtractStrPortion(QuerySegment, NewLine+'' + sqlFrom +' ', 1), 'SELECT '+NewLine, 2));
    if sFields = '' then
        {"select" on the first line and fields starting from seond line}
       sFields := Trim(ExtractStrPortion(ExtractStrPortion(QuerySegment, NewLine+'' + sqlFrom +' ', 1), 'SELECT'+NewLine, 2));
    if sFields = '' then
      {"select " and fields starting from first line}
      sFields := Trim(ExtractStrPortion(ExtractStrPortion(QuerySegment, NewLine+'' + sqlFrom +' ', 1), 'SELECT ', 2));

    TempSQL := Trim(ReplaceStr(ReplaceStr(QuerySegment, sFields, ''), 'SELECT ', ''));
    TempSQL := Trim(ReplaceStr(ReplaceStr(QuerySegment, sFields, ''), 'SELECT'+NewLine, ''));
    //Set Fields And Descriptions
    SetFieldDescription(sFields, slFieldsDesc);
    //Order By Statement
    sOrderBy := (*Trim(*)ExtractStrPortion(TempSQL, '' + sqlOrderBy +' ', 2)(*)*);
    TempSQL  := Trim(ReplaceStr(TempSQL, '' + sqlOrderBy +' ' + sOrderBy, ''));
    //Group By Statement
    sGroupBy := (*Trim(*)ExtractStrPortion(TempSQL, '' + sqlGroupBy +' ', 2)(*)*);
    TempSQL  := Trim(ReplaceStr(TempSQL, '' + sqlGroupBy +' ' + sGroupBy, ''));
    //From Where
    sWhere  := (*Trim(*)ExtractStrPortion(TempSQL, '' + sqlWhere +' ', 2)(*)*);
    TempSQL := Trim(ReplaceStr(TempSQL, '' + sqlWhere +' ' + sWhere, ''));
    //From Statement
    sFrom := Trim(ExtractStrPortion(TempSQL, '' + sqlFrom +' ', 2));
    //Add Query Details
    AddRecord(slFieldsDesc, sFields, sFrom, sWhere, sGroupBy, sOrderBy);
  end;
end;

function TQueryManipulationObj.SQLWithCustomfilterApplied(const Value: String): String;

var
  i: integer;
  QueryItem: TQueryRec;
  AllSQL, TempSQLString: string;
  xWhere:String;
  FilterValue:String;
  fieldname:String;
  s:String;
begin
  AllSQL := '';
  for i := 0 to ListQueryItems.Count - 1 do begin
    FilterValue:= Value;
    QueryItem := TQueryRec(ListQueryItems[i]);
    with QueryItem do begin
      TempSQLString := 'SELECT' + ' ' + Fields ;
      TempSQLString := TempSQLString + NewLine +'' + sqlFrom +' ' + From;

      While (Pos('[' , FilterValue)>0) and ( POs(']' , FilterValue) > Pos('[' , FilterValue) ) do begin
          fieldname := copy(FilterValue ,Pos('[' , FilterValue)+1 ,Pos(']' , FilterValue)- Pos('[' , FilterValue)-1);
          s:= GetFieldExpression(fieldname,i);
          if s <> '' then FilterValue := replaceStr(FilterValue , '[' +fieldname + ']' ,   s);
      end;

      if Where <> '' then xWhere := ' ' + sqlWhere +' (' + where +') and (' + FilterValue +')'
      else xWhere := ' ' + sqlWhere +' ' + FilterValue + ' ';


      TempSQLString := TempSQLString + NewLine + trim(xWhere);
      if not Empty(GroupBy) then begin
        TempSQLString := TempSQLString + NewLine +  '' + sqlGroupBy +' ' + GroupBy;
      end;

      if not Empty(OrderBy) then begin
        TempSQLString := TempSQLString + NewLine +  '' + sqlOrderBy +' ' + OrderBy;
      end;
    end;
  
    AllSQL := AllSQL + NewLine + TempSQLString;

    if not (i = ListQueryItems.Count - 1) then AllSQL := AllSQL + NewLine +  UNIONALL+' ';
  end;
  result := AllSQL;
end;

procedure TQueryManipulationObj.SetFieldDescription(const FieldsStr: string; const FieldsDesc: TStringList);
var
  i: integer;
  FieldCount: integer;
  Field, FieldName, FieldExpression: string;
begin
  FieldCount := CharCounter(NewLine, FieldsStr);
  for i := 1 to FieldCount do begin
    Field           := Trim(ExtractStrPortion(FieldsStr, NewLine, i));
    FieldExpression := Trim(ExtractStrPortion(Field, ' AS ', 1));
    FieldName       := Trim(ExtractStrPortion(Field, ' AS ', 2));
    if Empty(FieldName) then begin
      FieldName := FieldExpression;
    end;
    if not (FieldCount = i) then begin
      FieldName := LeftStr(FieldName, char_length(FieldName) - 1);
    end;
    FieldsDesc.Add(FieldName + '~@~' + FieldExpression);
  end;
end;

procedure TQueryManipulationObj.CreateFilterItems;
var
  i, j: integer;
  QueryItem: TQueryRec;
  TempString: string;
  FieldName, FieldExpression: string;
begin
  fslFilterItems.Clear;
  for i := 0 to ListQueryItems.Count - 1 do begin
    QueryItem := TQueryRec(ListQueryItems[i]);
    for j := 0 to QueryItem.FieldsDesc.Count - 1 do begin
      TempString := QueryItem.FieldsDesc.Strings[j];
      FieldName := Trim(ExtractStrPortion(TempString, '~@~', 1));
      FieldExpression := Trim(ExtractStrPortion(TempString, '~@~', 2));
      //Test Expression
      if VaildateExpressionForWhereClause(FieldExpression) then begin
        fslFilterItems.Add(FieldName);
      end;
    end;
  end;
end;

function TQueryManipulationObj.VaildateExpressionForWhereClause(const Expression: string): boolean;
begin
  Result := false;
  if AnsiContainsText(uppercase(Expression), 'MAX(') or
    AnsiContainsText(uppercase(Expression), 'MIN(') or
    AnsiContainsText(uppercase(Expression), 'AVG(') or
    AnsiContainsText(uppercase(Expression), 'COUNT(') or
    AnsiContainsText(uppercase(Expression), 'SUM(') then Result := true;
end;

procedure TQueryManipulationObj.ProcessSearch(const SearchField, SearchValue: string; const EqualTo: boolean);
var
  i: integer;
  QueryItem: TQueryRec;
  AllSQL, TempSQLString, FieldExpression: string;
  SumInWhere: boolean;
  xWhere:String;
begin
  fsSearchcondition := '';
  AllSQL := '';
  SumInWhere := false;
  for i := 0 to ListQueryItems.Count - 1 do begin
    QueryItem := TQueryRec(ListQueryItems[i]);
    with QueryItem do begin
      TempSQLString := 'SELECT' + ' ' + Fields ;
      TempSQLString := TempSQLString + NewLine +'' + sqlFrom +' ' + From;
      xWhere := ' ' + sqlWhere +' ' + Where + ' ';
      if AnsiContainsText(GetFieldExpression(SearchField, i), 'SUM(') then SumInWhere := true;
      if not Empty(Where) and not AnsiContainsText(GetFieldExpression(SearchField, i), 'SUM(') then begin
        xWhere := xWhere + ' AND ';
      end;

      if not AnsiContainsText(GetFieldExpression(SearchField, i), 'SUM(') then begin
        FieldExpression := GetFieldExpression(SearchField, i);
        if Empty(FieldExpression) then FieldExpression := SearchField;
        if AnsiContainsText(SearchValue, '%') then begin
          if EqualTo then begin
            xWhere := xWhere + FieldExpression + ' LIKE ' + QuotedStr(SearchValue);
          end else begin
            xWhere := xWhere + FieldExpression + ' NOT LIKE ' + QuotedStr(SearchValue);
          end;
        end else begin
          if EqualTo then begin
            xWhere := xWhere + FieldExpression + ' = ' + QuotedStr(SearchValue);
          end else begin
            xWhere := xWhere + FieldExpression + ' <> ' + QuotedStr(SearchValue);
          end;
        end;
      end;
      //Where := replaceStr(xWhere , ' ' + sqlWhere +' ' , '');

      fsSearchcondition := replacestr(xWhere , ' ' + sqlWhere +' ' + Where + ' ','');

      TempSQLString := TempSQLString + NewLine + trim(xWhere);
      if not Empty(GroupBy) then begin
        TempSQLString := TempSQLString + NewLine +  '' + sqlGroupBy +' ' + GroupBy;
      end;

      if not Empty(OrderBy) then begin
        TempSQLString := TempSQLString + NewLine +  '' + sqlOrderBy +' ' + OrderBy;
      end;
    end;

    AllSQL := AllSQL + NewLine + TempSQLString;

    if not (i = ListQueryItems.Count - 1) then AllSQL := AllSQL + NewLine +  UNIONALL+' ';
  end;

  if SumInWhere then begin
    AllSQL := OriginalQuery + ' '+Limit0;
    CommonLib.MessageDlgXP_Vista('Cannot Search with Field "' + SearchField + '" in Search Engine.' + NewLine + NewLine +
      'It Is Aggregate Field.', mtInformation, [mbOK], 0);
  end;

  fsModifiedSQL := AllSQL;
end;

procedure TQueryManipulationObj.ProcessSearch(const SearchField, SearchValue, OverrideWhereArguments: string;
  const EqualTo: boolean);
var
  i: integer;
  QueryItem: TQueryRec;
  AllSQL, TempSQLString: string;
  FieldExpression : string;
begin
  AllSQL := '';
  for i := 0 to ListQueryItems.Count - 1 do begin
    QueryItem := TQueryRec(ListQueryItems[i]);
    with QueryItem do begin
      TempSQLString := 'SELECT' + ' ' + Fields + ' ' + sqlFrom +' ' + From;
      if Empty(OverrideWhereArguments) then begin
        TempSQLString := TempSQLString + ' ' + sqlWhere +' ' + Where + ' ';
      end else begin
        // Use our supplied Base Where Clause.
        TempSQLString := TempSQLString + ' ' + sqlWhere +' ' + OverrideWhereArguments + ' ';
      end;

      if not Empty(Where) and not Empty(SearchField) and not Empty(SearchValue) then begin
        TempSQLString := TempSQLString + ' AND ';
      end;

      if not Empty(SearchField) and not Empty(SearchValue) then begin
        FieldExpression := GetFieldExpression(SearchField, i);
        //if Empty(FieldExpression) then FieldExpression := SearchField;
        if AnsiContainsText(SearchValue, '%') then begin
          TempSQLString := TempSQLString + FieldExpression + ' LIKE ' + QuotedStr(SearchValue);
        end else begin
          TempSQLString := TempSQLString + FieldExpression + ' = ' + QuotedStr(SearchValue);
        end;
      end;

      if not Empty(GroupBy) then begin
        TempSQLString := TempSQLString + ' ' + sqlGroupBy +' ' + GroupBy;
      end;
      if not Empty(OrderBy) then begin
        TempSQLString := TempSQLString + ' ' + sqlOrderBy +' ' + OrderBy;
      end;
    end;

    AllSQL := AllSQL + TempSQLString;

    if not (i = ListQueryItems.Count - 1) then AllSQL := AllSQL + ' '+UNIONALL+' ';
  end;
  fsModifiedSQL := AllSQL;
end;

  ///////////////////////////////////////////////////////////////////
  // This Search method is when you are wanting to use the OR logic
  // operator within a WHERE Clause.
  ///////////////////////////////////////////////////////////////////
procedure TQueryManipulationObj.ProcessSearchOR(const SearchField, BaseWhereArguments: string;
  const SearchValue: TStringList);
var
  i, iX: integer;
  QueryItem: TQueryRec;
  AllSQL, TempSQLString: string;
begin
  AllSQL := '';
  for i := 0 to ListQueryItems.Count - 1 do begin
    QueryItem := TQueryRec(ListQueryItems[i]);
    with QueryItem do begin
      TempSQLString := 'SELECT' + ' ' + Fields + ' ' + sqlFrom +' ' + From;
      if BaseWhereArguments = '' then begin
        TempSQLString := TempSQLString + ' ' + sqlWhere +' ' + Where + ' ';
      end else begin
        // Use our supplied Base Where Clause.
        TempSQLString := TempSQLString + ' ' + sqlWhere +' ' + BaseWhereArguments + ' ';
      end;

      if not Empty(Where) then begin
        TempSQLString := TempSQLString + ' AND ';
      end;

      for iX := 0 to SearchValue.Count - 1 do begin
        if (iX = 0) and ((SearchValue.Count - 1) = 0) then begin
          TempSQLString := TempSQLString + '(' + GetFieldExpression(SearchField, i) + ' = ' +
            QuotedStr(SearchValue.Strings[iX]) + ')';
        end else if iX = 0 then begin
          TempSQLString := TempSQLString + '(' + GetFieldExpression(SearchField, i) + ' = ' +
            QuotedStr(SearchValue.Strings[iX]);
        end else if iX = (SearchValue.Count - 1) then begin
          TempSQLString := TempSQLString + ' OR ' + GetFieldExpression(SearchField, i) + ' = ' +
            QuotedStr(SearchValue.Strings[iX]) + ')';
        end else begin
          TempSQLString := TempSQLString + ' OR ' + GetFieldExpression(SearchField, i) + ' = ' +
            QuotedStr(SearchValue.Strings[iX]);
        end;
      end;

      if not Empty(GroupBy) then begin
        TempSQLString := TempSQLString + ' ' + sqlGroupBy +' ' + GroupBy;
      end;
      if not Empty(OrderBy) then begin
        TempSQLString := TempSQLString + ' ' + sqlOrderBy +' ' + OrderBy;
      end;
    end;

    AllSQL := AllSQL + TempSQLString;

    if not (i = ListQueryItems.Count - 1) then AllSQL := AllSQL + ' '+UNIONALL+' ';
  end;
  fsModifiedSQL := AllSQL;
end;

function TQueryManipulationObj.GetFieldExpression(const SearchField: string; const UnionNo: integer): string;
var
  j: integer;
  QueryItem: TQueryRec;
  TempString: string;
  FieldName, FieldExpression: string;
  function fieldnameToSearch:String; begin
    result := Trim(StringReplace(uppercase(SearchField), '`' ,'' , [rfReplaceAll]));
  end;
begin
  fslFilterItems.Clear;
  QueryItem := TQueryRec(ListQueryItems[UnionNo]);
  for j := 0 to QueryItem.FieldsDesc.Count - 1 do begin
    TempString      := QueryItem.FieldsDesc.Strings[j];
    FieldName       := Trim(ExtractStrPortion(TempString, '~@~', 1));
    FieldExpression := Trim(ExtractStrPortion(TempString, '~@~', 2));
    //Test FieldName
    if (Trim(uppercase(ReplaceStr(ReplaceStr(FieldName, #34, ''), #39, ''))) =  FieldnameToSearch) then begin

      Result := FieldExpression;
      Exit;
    end;
  end;
end;

function TQueryManipulationObj.QueryManipulationToText:String;
var
  i: integer;
  QueryItem: TQueryRec;
  s:String;
begin
  REsult := '';
  for i := 0 to ListQueryItems.Count - 1 do begin
    QueryItem := TQueryRec(ListQueryItems[i]);
    with QueryItem do begin
      s:= 'Query # ' +inttostr(i) + chr(13) + 'FieldsDesc:' + FieldsDesc.text +chr(13)+
          'Fields:' + Fields+chr(13)+
          '' + sqlFrom +':' +From+chr(13)+
          '' + sqlWhere +': ' +Where+chr(13)+
          'GroupBy: ' +GroupBy+chr(13)+
          'OrderBy: ' +OrderBy;
        Result := result +s+chr(13);
    end;
  end;
end;

procedure TQueryManipulationObj.ProcessSQLMaxRecords;
var
  i: integer;
  QueryItem: TQueryRec;
  AllSQL, TempSQLString: string;
begin
  AllSQL := '';
  for i := 0 to ListQueryItems.Count - 1 do begin
    QueryItem := TQueryRec(ListQueryItems[i]);
    with QueryItem do begin
      TempSQLString := 'SELECT COUNT(*) as MaxRecords FROM ' + From;

      if not Empty(Where) then begin
        TempSQLString := TempSQLString + ' ' + sqlWhere +' ' + Where + ' ';
      end;
    end;
    AllSQL := AllSQL + TempSQLString;
    if not (i = ListQueryItems.Count - 1) then AllSQL := AllSQL + ' '+UNIONALL+' ';
  end;
  fsModifiedSQLMaxRecords := AllSQL;
end;

procedure TQueryManipulationObj.ProcessSearch(const ExtraWhereArguments: string);
var
  i: integer;
  QueryItem: TQueryRec;
  AllSQL, TempSQLString: string;
begin
  AllSQL := '';
  for i := 0 to ListQueryItems.Count - 1 do begin
    QueryItem := TQueryRec(ListQueryItems[i]);
    with QueryItem do begin
      TempSQLString := 'SELECT' + ' ' + Fields + ' ' + sqlFrom +' ' + From;


      if not Empty(Where) then begin
        TempSQLString := TempSQLString + ' ' + sqlWhere +' ' + Where + ' ';
      end;

      if not Empty(ExtraWhereArguments) then begin
        TempSQLString := TempSQLString + ExtraWhereArguments + ' ';
      end;

      if not Empty(GroupBy) then begin
        TempSQLString := TempSQLString + ' ' + sqlGroupBy +' ' + GroupBy;
      end;
      if not Empty(OrderBy) then begin
        TempSQLString := TempSQLString + ' ' + sqlOrderBy +' ' + OrderBy;
      end;
    end;

    AllSQL := AllSQL + TempSQLString;

    if not (i = ListQueryItems.Count - 1) then AllSQL := AllSQL + ' '+UNIONALL+' ';
  end;
  fsModifiedSQL := AllSQL;
end;






end.

