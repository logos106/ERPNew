unit BaseListUtilsObj;

interface

uses
  ERPDbComponents, Types;

type

  TBaseListUtils = class(TObject)
  public
    { return true if foreign currency fields found }
    class function InitFCFields(var AmountFieldList, AmountCaptionList: TStringDynArray;
      const FormID: integer; conn: TERPConnection; UseDeptName: boolean = false): boolean; overload;
    class function InitFCFields(var AmountFieldList, AmountCaptionList: TStringDynArray;
      const FormName: string; conn: TERPConnection; UseDeptName: boolean = false): boolean; overload;
  end;


implementation

uses
  (*BusObjBase, BusObjFCOnReport, *)SysUtils, DbSharedObjectsObj,
  AppEnvironmentVirtual;

{ TBaseListUtils }

class function TBaseListUtils.InitFCFields(var AmountFieldList,
  AmountCaptionList: TStringDynArray; const FormID: integer;
  conn: TERPConnection; UseDeptName: boolean): boolean;
var
  FCFields: TERPQuery;//TForeignCurrencyFieldsonReport;
  ctr: integer;
  qry: TERPQuery;
begin
  result := false;
  SetLength(AmountFieldList,0);
  SetLength(AmountCaptionList,0);
  qry := nil;
  FCFields := DbSharedObjectsObj.DbSharedObj.GetQuery(TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']));//TForeignCurrencyFieldsonReport.Create(nil);
  try
    //FCFields.Connection := TMyDacDataConnection.Create(FCFields);
    //FCFields.Connection.Connection := conn;
    //FCFields.LoadSelect('formId = ' + IntToStr(FormId));
    if FCFields.Active then FCFields.Close;
    FCFields.SQL.Text :='SELECT * FROM tblforeigncurrencyfieldsonreport where formId = ' + IntToStr(FormId);
    FCFields.Open;
    if FCFields.recordCount = 0 then exit;
    result := True;
    FCFields.first;
    ctr := 0;
    while FCFields.eof = false do begin
      if not FCFields.Fieldbyname('IsDeptRelated').asBoolean then begin
        Setlength(AmountFieldList, ctr + 1);
        Setlength(AmountCaptionList, ctr + 1);
        AmountFieldList[ctr] := FCFields.Fieldbyname('AmountfieldName').asString;
        AmountCaptionList[ctr] := FCFields.Fieldbyname('AmountCaption').AsString;
        ctr := ctr + 1;
      end else begin
        if not Assigned(qry) then begin
          qry := TERPQuery.Create(nil);
          qry.Connection := conn;
          qry.SQL.Text :=
            'select ClassID, ClassName from tblclass ' +
            'where active = "T" and ifnull(ClassName , "") <> ""';
          qry.Open;
        end;
        if qry.RecordCount > 0 then begin
          qry.first;
          while qry.eof = false do begin
            Setlength(AmountFieldList, ctr + 1);
            Setlength(AmountCaptionList, ctr + 1);
            if UseDeptName then begin
              AmountFieldList[ctr] :=
                Trim(qry.FieldByName('ClassName').AsString) + '_' + FCFields.Fieldbyname('AmountfieldName').asString;
              AmountCaptionList[ctr] :=
                Trim(qry.FieldByName('ClassName').AsString) + ' ' + FCFields.Fieldbyname('AmountfieldName').AsString;
            end
            else begin
              AmountFieldList[ctr] :=
                Trim(inttostr(qry.FieldByName('classId').asInteger)) + '_' + FCFields.Fieldbyname('AmountfieldName').AsString;
              AmountCaptionList[ctr] :=
                Trim(inttostr(qry.FieldByName('classId').asInteger)) + ' ' + FCFields.Fieldbyname('AmountfieldName').asString;
            end;
            ctr := ctr + 1;
            qry.Next;
          end;
        end;
      end;
      FCFields.Next;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(FCFields);
  end;
end;

class function TBaseListUtils.InitFCFields(var AmountFieldList,
  AmountCaptionList: TStringDynArray;
  const FormName: string; conn: TERPConnection; UseDeptName: boolean): boolean;
var
  qry: TERPQuery;
begin
  result := true;
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := conn;
    qry.SQL.Text := 'SELECT FormID FROM tblforms WHERE FormName = ' + QuotedStr(FormName);
    qry.Open;
    if not qry.IsEmpty then
      Result := InitFCFields(AmountFieldList, AmountCaptionList, qry.FieldByName('FormID').AsInteger, Conn, UseDeptName);
  finally
    qry.Free;
  end;

end;

end.
