unit DatasetExporter;
{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 01/10/11  1.00.01 BJ  First version.

 Query      : An external query can be set to the property in which case the data of that query(filters will be used as it is) will be exported.
 SQL        : If query is not set, SQL should be set in which case a new query is created.
 Connection : an option to set the connection as well, if connection is not set , shared connection will be used.If the query is set, connection is irrelevant
 GRID       : If GRID is set, GRID.SELECTED will be used for the field list and display labels.
}

interface
uses
  Wwdbgrid,ERPDBcomponents, windows, classes;

type
  TERPQueryExporter = Class(TComponent)
    Private

    fsSQL                   : String;
    fGrid                   : TwwDBGrid;
    fQuery                  : TERpQuery;
    fsfilename              : String;
    fsdelimeter             : STring;
    fConnection             : TERPConnection;
    fsTextQualifier         : String;
    fsDefaultFilename       : String;
    fsFieldsToexclude       : String;
    fsDefaultExtension      : String;
    fbIncludeColumnLabels   : Boolean;
    fbRemoveNonPrintablechar: Boolean;
    fbFieldNameAsColumnLabel: Boolean;


    function UserInputfilename(DefaultFilename,DefaultExtension:String): String;

    public
      Property SQL                    :String         read fsSQL                    write fsSQL                     ;
      Property Grid                   :TwwDBGrid      read fGrid                    write fGrid                     ;
      Property Query                  :TERpQuery      read fQuery                   write fQuery                    ;
      Property fileName               :String         read fsfilename               write fsfilename                ;
      Property delimeter              :STring         read fsdelimeter              write fsdelimeter               ;
      Property connection             :TERPConnection read fConnection              write fconnection ;
      Property TextQualifier          :String         read fsTextQualifier          write fsTextQualifier           ;
      Property DefaultFilename        :String         read fsDefaultFilename        write fsDefaultFilename         ;
      Property FieldsToexclude        :String         read fsFieldsToexclude        write fsFieldsToexclude         ;
      Property DefaultExtension       :String         read fsDefaultExtension       write fsDefaultExtension        ;
      Property IncludeColumnLabels    :Boolean        read fbIncludeColumnLabels    write fbIncludeColumnLabels     ;
      Property RemoveNonPrintablechar :Boolean        read fbRemoveNonPrintablechar write fbRemoveNonPrintablechar  ;
      Property FieldNameAsColumnLabel :Boolean        read fbFieldNameAsColumnLabel write fbFieldNameAsColumnLabel  ;


      constructor Create(Aowner:TComponent); override;
      destructor Destroy; override;

      function DoExport               :String;


  End;
implementation

uses TextFileObj, sysutils, variants, db, MySQLConst, Dialogs, CommonLib, Progressdialog , GridFieldsObj,
  CommonDbLib, tcConst;

{ TERPQueryExporter }
function TERPQueryExporter.UserInputfilename(DefaultFilename, DefaultExtension:String):String;
var
  SaveDialog: TSaveDialog;
begin
    SaveDialog:= TSaveDialog.create(nil);
    try
      SaveDialog.filename := DefaultFilename;
      if DefaultExtension <> '' then
        SaveDialog.DefaultExt := DefaultExtension
      else if pos('.' , DefaultFilename)<> 0 then
        SaveDialog.DefaultExt := Copy(DefaultFilename ,pos('.' , DefaultFilename) , length(DefaultFilename));
      if SaveDialog.Execute then Result := SaveDialog.FileName;
    finally
      FreeandNil(SaveDialog);
    end;
end;
constructor TERPQueryExporter.Create(Aowner: TComponent);
begin
  inherited;
  fsSQL                     := '';
  fGrid                     := nil;
  fQuery                    := nil;
  fsfilename                := '';
  fsdelimeter               := ',';
  fconnection               := nil;
  fsTextQualifier           := '"';
  fsDefaultFilename         := '';
  fsFieldsToexclude         := '';
  fsDefaultExtension        := '';
  fbIncludeColumnLabels     := True;
  fbRemoveNonPrintablechar  := False;
  fbFieldNameAsColumnLabel  := False;
end;

destructor TERPQueryExporter.Destroy;
begin
  if Assigned(Query) then if Assigned(Query.Owner) then if Query.Owner = Self then Query.closenFree;
  inherited;
end;

function TERPQueryExporter.DoExport:String;
var
  ctr:Integer;
  s:String;
  TF:TTextfile;
  FieldsToexcludeList :TStringList;
  fsFieldname:String;


  FieldList : Array of Array[0..1] of string;

  function FieldtobeExcluded(const Value:String):boolean;
  var
    i:Integer;
  begin
    Result := False;
    if FieldsToexcludeList.count =0 then exit;
    for i := 0 to FieldsToexcludeList.count-1 do
      if Sametext(FieldsToexcludeList[i], value) then begin
        Result := True;
        exit;
      end;
  end;

  function makefieldList:Boolean;
  var
    selectedList : TGridFieldList;
    ctr:Integer;
    Fieldcount:Integer;
  begin
    Result := false;
    FieldsToexcludeList := TStringList.Create;
    try
      FieldsToexcludeList.commatext := FieldsToexclude;
      if grid <> nil then begin
        {read from gui Prefs}
        selectedList := TGridFieldList.Create;
        try
          selectedList.LoadFromGrid(Grid);
          Fieldcount :=0;
          For ctr := 0 to selectedList.count-1 do begin
            if Query.findfield(selectedList.Items[ctr].fieldName)<> nil then begin
              if not(FieldtobeExcluded(selectedList.Items[ctr].fieldName)) then begin
                SetLength(FieldList , Fieldcount+1);
                FieldList[high(FieldList) , 0] :=selectedList.Items[ctr].fieldName;
                FieldList[high(FieldList) , 1] :=selectedList.Items[ctr].DisplayLabel;
                if selectedList.Items[ctr].groupname <> '' then FieldList[high(FieldList) , 1] := selectedList.Items[ctr].groupname + ' ' +FieldList[high(FieldList) , 1];
                Fieldcount:= Fieldcount+1;
                Result := True;
              end;
            end;
          end;
        finally
          Freeandnil(selectedList);
        end;
      end else begin
        {read from dataset and exclude the fields to be excluded}
          Fieldcount:= 0;
          for ctr:= 0 to Query.fieldcount-1 do begin
              fsFieldname :=Query.Fields[ctr].fieldname;
              if not(FieldtobeExcluded(fsFieldname)) then begin
                  SetLength(FieldList , Fieldcount+1);
                  FieldList[high(FieldList) , 0] :=fsFieldname;
                  FieldList[high(FieldList) , 1] :=Query.Fields[ctr].DisplayLabel;
                  Fieldcount:= Fieldcount+1;
                  Result := True;
              end;
          end;
      end;
    finally
      Freeandnil(FieldsToexcludeList);
    end;
  end;

  function Formatdata(const Value:String):String;
  var
    i:Integer;
  begin
    Result := Value ;
    if RemoveNonPrintablechar then begin
      Result:=replacestr(Result, #13#10, ' ');
      for i := 0 to 31 do Result:=replacestr(Result, chr(i),'');
    end;
    if TextQualifier = '"' then Result := replacestr(Result,TextQualifier , '''')
    else Result := replacestr(Result,TextQualifier , '');
  end;
begin
  Result := '';
  if (Query = nil) and (fsSQL='') then exit;

    if delimeter = '' then delimeter := ',';
    if TextQualifier = '' then TextQualifier := '"';
    if filename = '' then filename:= USerinputfileName(DefaultFilename, DefaultExtension);
    if filename = '' then exit;

    if Query = nil then begin
      query := TERpQuery.Create(Self);
      if fconnection = nil then Query.connection := GetSharedMyDacConnection else Query.connection := fconnection;
      Query.SQL.add(fsSQL);
    end;
    if Query.active = False then Query.open;

    if FileExists(FileName) then sysutils.DeleteFile(FileName);

    if not MakefieldList then exit;

    TF:=TTextfile.create(FileName, tfmCreate);
    try
      if IncludeColumnLabels then begin
        s:= '';
        for ctr:= Low(fieldList) to high(fieldList) do begin
            if s<> '' then s:= s+  delimeter;
            if FieldNameAsColumnLabel then s:= s + TextQualifier +FieldList[ctr,0] +TextQualifier
            else s:= s + TextQualifier +FieldList[ctr,1] +TextQualifier;
        end;
        TF.WriteLine(s);
      end;

      if Query.recordcount =0 then exit;
      Query.First;
      DoShowProgressbar(Query.Recordcount , waitMSg);
      try
        While Query.Eof = False do begin
          s:= '';
          for ctr:= Low(fieldList) to high(fieldList) do begin
            if Query.findfield(fieldList[ctr,0]) <> nil then begin
              if s<> '' then s:= s+  delimeter;
              with Query.Fieldbyname(fieldList[ctr,0]) do begin
                if value = NULL then begin
                end else if (DataType = ftDate) or (DataType = ftDateTime) then begin
                  if AsDateTime <> 0 then s := s + TextQualifier+ FormatDateTime(MysqlDateFormat, AsDateTime) + TextQualifier;
                end else begin
                  s := s + TextQualifier+ FormatData(AsString) + TextQualifier ;
                end;
              end;
            end;
          end;
          TF.WriteLine(s);
          Query.Next;
          DoStepProgressbar;
        end;
      Finally
        DoHideProgressbar;
      end;
      Result := filename;
    finally
      Freeandnil(TF);
    end;
end;

end.

