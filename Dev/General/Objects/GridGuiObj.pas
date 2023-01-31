unit GridGuiObj;

interface

uses WwDBGrid ,ERPdbComponents,classes;

type

  TGEneralProc = procedure of object;
  TGridGuiObj = Class(TComponent)
  Private
    fGrid: TwwDBGrid;
  Public
    Constructor Create(AOwner:Tcomponent);Override;
    Property Grid :TwwDBGrid read fGrid write fGrid;
    procedure GridTitleButtonClick(Sender: TObject; AFieldName: string; var SortColumnName:String; var BaseIndexFieldNames:String; var ColumnOrderMode:String; var SwapBaseIndexFieldPriority :boolean; var SecondaryIndexFieldNames:String;BaseIndexfields:String =''; Doqryafteropen :TGeneralProc = nil);
    procedure AddBasEindexfields(BaseIndexfields:String;var Indexfields: String);
  End;

implementation

uses FastFuncs, sysutils , forms , db, CommonLib;

{ TGridGuiObj }

procedure TGridGuiObj.AddBasEindexfields(BaseIndexfields:String;var Indexfields: String);
begin
  if BaseIndexfields <> '' then
    if (SameText(Indexfields ,Quotedstr(BaseIndexfields))) or  (pos(uppercase(Quotedstr(BaseIndexfields)) ,uppercase(Indexfields))=1) then
    else if Indexfields <> '' then
      Indexfields := BaseIndexfields +',' + Indexfields
    else Indexfields := BaseIndexfields;

end;

constructor TGridGuiObj.Create(AOwner: Tcomponent);
begin
  inherited;
  fGrid := nil;
end;

procedure TGridGuiObj.GridTitleButtonClick(Sender: TObject; AFieldName: string; var SortColumnName:String; var BaseIndexFieldNames:String; var ColumnOrderMode:String; var SwapBaseIndexFieldPriority :boolean; var SecondaryIndexFieldNames:String;BaseIndexfields:String =''; Doqryafteropen :TGeneralProc = nil);
var
  tmpIndex: string;
  slColumnSortOrder: TStringList;
  function Qry :TERPQuery;
  begin
    REsult := TERPQuery(TwwDBGrid(Sender).Datasource.dataset);
  end;
  function IsFieldNameInBaseFieldIndexes(const sFieldIndexPattern: string; const slColumnSortOrder: TStringList): boolean;
  var
    iX: integer;
  begin
    Result := false;
    for iX := 0 to slColumnSortOrder.Count - 1 do begin
      if FastFuncs.PosEx(sFieldIndexPattern, slColumnSortOrder.Strings[iX]) <> 0 then begin
        Result := True;
        exit;
      end;
    end;
  end;

  function BuildBaseIndexes(const slColumnSortOrder: TStringList): string;
  var
    iX: integer;
  begin
    Result := '';
    for iX := 0 to slColumnSortOrder.Count - 1 do begin
      if iX = 0 then Result := slColumnSortOrder.Strings[0]
      else Result := Result + '; ' + slColumnSortOrder.Strings[iX];
    end;
  end;

  procedure ChangeFieldSortOrder(const sFieldName, sNewOrder: string; const slColumnSortOrder: TStringList);
  var
    iX: integer;
    Buffer: array [0 .. 255] of char;
    Field: array [0 .. 255] of char;
  begin
    StrPCopy(Field, sFieldName);
    StrLower(Field);
    for iX := 0 to slColumnSortOrder.Count - 1 do begin
      StrPCopy(Buffer, slColumnSortOrder.Strings[iX]);
      StrLower(Buffer);
      if FastFuncs.PosEx(string(Field), string(Buffer)) <> 0 then begin
        // We do this twice to ensure no matter what it is it will update
        // to the new requested search order.
        slColumnSortOrder.Strings[iX] := StringReplace(slColumnSortOrder.Strings[iX], ' ASC ', sNewOrder, [rfReplaceAll, rfIgnoreCase]);
        slColumnSortOrder.Strings[iX] := StringReplace(slColumnSortOrder.Strings[iX], ' DESC ', sNewOrder, [rfReplaceAll, rfIgnoreCase]);
        exit;
      end;
    end;
  end;

begin
try
    slColumnSortOrder := TStringList.Create;
    slColumnSortOrder.Clear;
    if SortColumnName <> AFieldName then begin
      QRY.IndexFieldNames := BaseIndexFieldNames;
      ColumnOrderMode := 'ASC';
    end;

    if QRY.IndexFieldNames <> '' then begin
      ExtractStrings([';'], [' '], PChar(QRY.IndexFieldNames), slColumnSortOrder);
    end;

    if QRY.FindField(AFieldName) <> nil then begin
      if (QRY.FieldByName(AFieldName).fieldKind <> fkLookup) and (QRY.FieldByName(AFieldName).fieldKind <> fkCalculated) and (QRY.FieldByName(AFieldName).DataType <> ftWideMemo) and
        (QRY.FieldByName(AFieldName).DataType <> ftMemo) then begin
        QRY.DisableControls;

        if (IsFieldNameInBaseFieldIndexes(QuotedStr(AFieldName) + ' ASC CIS', slColumnSortOrder)) or (IsFieldNameInBaseFieldIndexes(AFieldName + ' ASC CIS', slColumnSortOrder)) then begin
          ChangeFieldSortOrder(AFieldName, ' DESC ', slColumnSortOrder);
          if (slColumnSortOrder.Count > 0) then begin
            if not(IsFieldNameInBaseFieldIndexes(AFieldName, slColumnSortOrder)) then begin
              if not SwapBaseIndexFieldPriority then begin
                tmpIndex := QuotedStr(AFieldName) + ' DESC CIS; ' + BuildBaseIndexes(slColumnSortOrder) + ';';
              end else begin
                tmpIndex := BuildBaseIndexes(slColumnSortOrder) + '; ' + QuotedStr(AFieldName) + ' DESC CIS;';
              end;
            end else begin
              tmpIndex := BuildBaseIndexes(slColumnSortOrder) + ';';
            end;
          end else begin
            if not empty(SecondaryIndexFieldNames) then begin
              tmpIndex := QuotedStr(AFieldName) + ' DESC CIS; ' + SecondaryIndexFieldNames + ' DESC CIS;';
            end else begin
              tmpIndex := QuotedStr(AFieldName) + ' DESC CIS;';
            end;
          end;

          ColumnOrderMode := 'DESC';
          SortColumnName := AFieldName;

          try
            QRY.IndexFieldNames := '';
            Application.ProcessMessages;
            addbaseindexfields(BaseIndexfields , tmpIndex);
            QRY.IndexFieldNames := tmpIndex;
            if assigned(Doqryafteropen) then Doqryafteropen;
          except
          end;
        end else begin
          if (ColumnOrderMode = '') or (ColumnOrderMode = 'ASC') then begin
            if (slColumnSortOrder.Count > 0) then begin
              if not(IsFieldNameInBaseFieldIndexes(AFieldName, slColumnSortOrder)) then begin
                if not SwapBaseIndexFieldPriority then begin
                  tmpIndex := QuotedStr(AFieldName) + ' DESC CIS; ' + BuildBaseIndexes(slColumnSortOrder) + ';';
                end else begin
                  tmpIndex := BuildBaseIndexes(slColumnSortOrder) + '; ' + QuotedStr(AFieldName) + ' DESC CIS;';
                end;
              end else begin
                ChangeFieldSortOrder(AFieldName, ' DESC ', slColumnSortOrder);
                tmpIndex := BuildBaseIndexes(slColumnSortOrder) + ';';
              end;
            end else begin
              if not empty(SecondaryIndexFieldNames) then begin
                tmpIndex := QuotedStr(AFieldName) + ' DESC CIS; ' + SecondaryIndexFieldNames + ' DESC CIS;';
              end else begin
                tmpIndex := QuotedStr(AFieldName) + ' DESC CIS;';
              end;
            end;
            ColumnOrderMode := 'DESC';
          end else begin
            if (ColumnOrderMode = 'DESC') then begin
              if (slColumnSortOrder.Count > 0) then begin
                if not(IsFieldNameInBaseFieldIndexes(AFieldName, slColumnSortOrder)) then begin
                  if not SwapBaseIndexFieldPriority then begin
                    tmpIndex := QuotedStr(AFieldName) + ' ASC CIS; ' + BuildBaseIndexes(slColumnSortOrder) + ';';
                  end else begin
                    tmpIndex := BuildBaseIndexes(slColumnSortOrder) + '; ' + QuotedStr(AFieldName) + ' ASC CIS;';
                  end;
                end else begin
                  ChangeFieldSortOrder(AFieldName, ' ASC ', slColumnSortOrder);
                  tmpIndex := BuildBaseIndexes(slColumnSortOrder) + ';';
                end;
              end else begin
                if not empty(SecondaryIndexFieldNames) then begin
                  tmpIndex := QuotedStr(AFieldName) + ' ASC CIS; ' + SecondaryIndexFieldNames + ' ASC CIS;';
                end else begin
                  tmpIndex := QuotedStr(AFieldName) + ' ASC CIS;';
                end;
              end;
              ColumnOrderMode := 'ASC';
            end;
          end;

          SortColumnName := AFieldName;

          try
            QRY.IndexFieldNames := '';
            Application.ProcessMessages;
            addbaseindexfields(BaseIndexfields , tmpIndex);
            QRY.IndexFieldNames := tmpIndex;
            if assigned(Doqryafteropen) then Doqryafteropen;
          except
          end;
        end;

        QRY.Enablecontrols;
      end;
    end;

  finally
    // Release our used objects.
    if Assigned(slColumnSortOrder) then FreeandNil(slColumnSortOrder);
    // Restore previous screen cursor.
  end;
end;

end.
