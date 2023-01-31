{***************************************************************************
 sgcWebSocket component

 written by eSeGeCe
            copyright © 2013
            Email : info@esegece.com
            Web : http://www.esegece.com
***************************************************************************}

unit sgcWebSocket_Protocol_Dataset_Message;

interface

uses
  Classes, SysUtils, DB, Variants,
  sgcWebSocket_Protocol_sgc_message;

type
  TsgcWSMessageDataset = class(TsgcWSMessage)

  { dataset }
  private
    FDataSet: TDataSet;
  protected
    procedure SetDataSet(const Value: TDataSet);
  public
    property DataSet: TDataSet read FDataSet write SetDataSet;
  { dataset }

  protected
    procedure DoJSONRecord;
  protected
    function FindRecord: Boolean;
    procedure DoAssignRecord;
    procedure DoDeleteRecord;
    procedure DoNewRecord;
    procedure DoUpdateRecord;
  protected
    function GetJSONValue(const aFieldName: String): Variant;
  public
    destructor Destroy; override;
  public
    procedure Read(const aMessage: String); override;
    function Write: string; override;

  { key fields }
  private
    FKeyFields: TFields;
    procedure DoAddKeyField(aField: TField);
    function GetKeyFields: TFields;
  protected
    procedure DoKeyFields;
    function GetKeyFieldsAsString: string;
    function GetKeyValuesAsVariant: Variant;
  public
    property KeyFields: TFields read GetKeyFields write FKeyFields;
  { key fields }

  { events }
  private
    FOnAfterDeleteRecord: TNotifyEvent;
    FOnAfterNewRecord: TNotifyEvent;
    FOnAfterUpdateRecord: TNotifyEvent;
  protected
    procedure DoAfterNewRecordEvent;
    procedure DoAfterUpdateRecordEvent;
    procedure DoAfterDeleteRecordEvent;
  published
    property OnAfterDeleteRecord: TNotifyEvent read FOnAfterDeleteRecord write
        FOnAfterDeleteRecord;
    property OnAfterNewRecord: TNotifyEvent read FOnAfterNewRecord write
        FOnAfterNewRecord;
    property OnAfterUpdateRecord: TNotifyEvent read FOnAfterUpdateRecord write
        FOnAfterUpdateRecord;
  { events }
  end;

implementation

uses sgcWebSocket_Const, sgcJSON;

destructor TsgcWSMessageDataset.Destroy;
begin
  FDataset := nil;
  FreeAndNil(FKeyFields);
  inherited;
end;

procedure TsgcWSMessageDataset.DoAddKeyField(aField: TField);
var
  oField: TField;
begin
  oField := TField.Create(self);
  oField.FieldName := aField.FieldName;

  KeyFields.Add(oField);
end;

procedure TsgcWSMessageDataset.DoAfterDeleteRecordEvent;
begin
  if Assigned(FOnAfterDeleteRecord) then FOnAfterDeleteRecord(self);
end;

procedure TsgcWSMessageDataset.DoAfterNewRecordEvent;
begin
  if Assigned(FOnAfterNewRecord) then FOnAfterNewRecord(self);
end;

procedure TsgcWSMessageDataset.DoAfterUpdateRecordEvent;
begin
  if Assigned(FOnAfterUpdateRecord) then FOnAfterUpdateRecord(self);
end;

procedure TsgcWSMessageDataset.DoAssignRecord;
var
  i: Integer;
begin
  With DataSet do
  begin
    for i := 0 to Fields.count - 1 do
      Fields[i].Value := GetJSONValue(Fields[i].FieldName);
  end;
end;

procedure TsgcWSMessageDataset.DoDeleteRecord;
begin
  if FindRecord then
  begin
    DataSet.Delete;
    DoAfterDeleteRecordEvent;
  end;
end;

procedure TsgcWSMessageDataset.DoJSONRecord;
var
  i: Integer;
  oJSONObject: TsgcObjectJSON;
begin
  JSONResult.Clear;
  JSONResult.JSONObject.Add(CS_METHOD, CS_SGC_DATASET);
  JSONResult.JSONObject.Add(CS_CHANNEL, Channel);
  oJSONObject := JSONResult.JSONObject.Add;
  oJSONObject.Name := CS_DATASET;
  With oJSONObject do
  begin
    for i := 0 to DataSet.Fields.Count - 1 do
    begin
      case DataSet.Fields[i].DataType of
        ftString, ftWideString:
          DoWriteJSONValue(DataSet.Fields[i].FieldName, DataSet.Fields[i].AsString, oJSONObject);
        ftInteger, ftSmallint, ftWord, ftAutoInc:
          DoWriteJSONValue(DataSet.Fields[i].FieldName, DataSet.Fields[i].AsInteger, oJSONObject);
        ftFloat, ftCurrency:
          DoWriteJSONValue(DataSet.Fields[i].FieldName, DataSet.Fields[i].AsFloat, oJSONObject);
        ftBoolean:
          DoWriteJSONValue(DataSet.Fields[i].FieldName, DataSet.Fields[i].AsBoolean, oJSONObject);
      end;
    end;
  end;
end;

procedure TsgcWSMessageDataset.DoKeyFields;
var
  i: Integer;
begin
  KeyFields.Clear;
  if Assigned(DataSet) then
  begin
    With DataSet do
    begin
      for i := 0 to Fields.Count - 1 do
      begin
        if FJSON.Node[CS_RESULT] <> nil then
          if FJSON.Node[CS_RESULT].Node[CS_DATASET] <> nil then
            if FJSON.Node[CS_RESULT].Node[CS_DATASET].Node[Fields[i].FieldName] <> nil then
              if pfInKey in Fields[i].ProviderFlags then
                DoAddKeyField(Fields[i]);
      end;
    end;
  end;
end;

procedure TsgcWSMessageDataset.DoNewRecord;
begin
  With DataSet do
  begin
    Append;
    DoAssignRecord;
    Post;
    DoAfterNewRecordEvent;
  end;
end;

procedure TsgcWSMessageDataset.DoUpdateRecord;
begin
  if FindRecord then
  begin
    With DataSet do
    begin
      Edit;
      DoAssignRecord;
      Post;
      DoAfterUpdateRecordEvent;      
    end;
  end
  else
    DoNewRecord;
end;

function TsgcWSMessageDataset.FindRecord: Boolean;
var
  vValues: Variant;
begin
  vValues := GetKeyValuesAsVariant;
  result := DataSet.Locate(GetKeyFieldsAsString, VarArrayOf(vValues), []);
end;

function TsgcWSMessageDataset.GetJSONValue(const aFieldName: String): Variant;
begin
  result := VarNull;
  if FJSON.Node[CS_RESULT] <> nil then
    if FJSON.Node[CS_RESULT].Node[CS_DATASET] <> nil then
      result := FJSON.Node[CS_RESULT].Node[CS_DATASET].Node[aFieldName].Value;
end;

function TsgcWSMessageDataset.GetKeyFields: TFields;
begin
  if not Assigned(FKeyFields) then
  begin
    FKeyFields := TFields.Create(nil);
    DoKeyFields;
  end;
  Result := FKeyFields;
end;

function TsgcWSMessageDataset.GetKeyFieldsAsString: string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to KeyFields.Count - 1 do
  begin
    if result = '' then
      result := KeyFields.Fields[i].FieldName
    else
      result := result + ',' +  KeyFields.Fields[i].FieldName;
  end;
end;

function TsgcWSMessageDataset.GetKeyValuesAsVariant: Variant;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to KeyFields.Count - 1 do
  begin
    if result = '' then
      result := GetJSONValue(KeyFields.Fields[i].FieldName)
    else
      result := result + ',' + GetJSONValue(KeyFields.Fields[i].FieldName);
  end;
end;

procedure TsgcWSMessageDataset.Read(const aMessage: String);
begin
  if Assigned(DataSet) then
  begin
    // ... enter read
    DoEnterRead(aMessage);

    if FJSON.Node[CS_RESULT] <> nil then
      channel := DoReadJSONValue(CS_CHANNEL, FJSON.Node[CS_RESULT]);
    // ... dataset
    if Channel = CS_SGC_DATASET_NEW then
      DoNewRecord
    else if Channel = CS_SGC_DATASET_UPDATE then
      DoUpdateRecord
    else if Channel = CS_SGC_DATASET_DELETE then
      DoDeleteRecord;
  end;
  inherited;
end;

procedure TsgcWSMessageDataset.SetDataSet(const Value: TDataSet);
begin
  if FDataSet <> Value then
  begin
    FreeAndNil(FKeyFields);
    FDataSet := Value;
  end;
end;

function TsgcWSMessageDataset.Write: string;
begin
  DoEnterWrite;
  DoJSONRecord;
  result := inherited Write;
end;

end.
