unit utSchema;

interface

uses
  ErpDbComponents;

type
  {$M+}
  TSchemaObjBase = class(TObject)
  private
    fERPVersion: string;
    fID: integer;
    fDirty: boolean;
    FDescription: string;
    FVisible: boolean;
    procedure SetERPVersion(const Value: string);
    procedure SetDescription(const Value: string);
    procedure SetVisible(const Value: boolean);
  public
    property Dirty: boolean read fDirty write fDirty;
  published
    property ERPVersion: string read fERPVersion write SetERPVersion;
    property ID: integer read fID write fID;
    property Description: string read FDescription write SetDescription; { user friendly description of object or field }
    property Visible: boolean read FVisible write SetVisible;   { users can only see data for visible = true objects and fields }
  end;

  TSchemaObject = class(TSchemaObjBase)
  private
    FTableName: string;
    FTableFilter: string;
    FObjectName: string;
    procedure SetObjectName(const Value: string);
    procedure SetTableFilter(const Value: string);
    procedure SetTableName(const Value: string);
  public
    class function UpdateProperties(const aVersion, aNewVersion, aObjectName, aTableName: string; conn: TERPConnection): boolean;
  published
    property TableName: string read FTableName write SetTableName;        { actual erp table used eg tblsales }
    property TableFilter: string read FTableFilter write SetTableFilter;      { eg IsInvoice = "T" }
    property ObjectName: string read FObjectName write SetObjectName;       { user friendly object name eg Invoice }
  end;

  TSchemaPropertyType = (ptField, ptObject, ptObjectList);

  TSchemaProperty = class(TSchemaObjBase)
  private
    FFieldFilter: string;
    FPropertyName: string;
    FFieldType: string;
    FFieldAllowNull: boolean;
    FObjectName: string;
    FFieldName: string;
    FPropertyType: integer;
    FFieldDefault: string;
    procedure SetFieldAllowNull(const Value: boolean);
    procedure SetFieldDefault(const Value: string);
    procedure SetFieldFilter(const Value: string);
    procedure SetFieldName(const Value: string);
    procedure SetFieldType(const Value: string);
    procedure SetPropertyName(const Value: string);
    procedure SetObjectName(const Value: string);
    procedure SetPropertyType(const Value: integer);
  published
    property ObjectName: string read FObjectName write SetObjectName;     { master SchemaObject Link }
    property PropertyType: integer read FPropertyType write SetPropertyType; { TSchemaPropertyType }
    property PropertyName: string read FPropertyName write SetPropertyName;          { user friendly name eg CustomerName }

    property FieldName: string read FFieldName write SetFieldName;     { mysql field name eg clientName }
    property FieldType: string read FFieldType write SetFieldType;       { mysql Type eg varchar(255) or enum('T','F') etc }
    property FieldAllowNull: boolean read FFieldAllowNull write SetFieldAllowNull;  { mysql Null YES/NO value }
    property FieldDefault: string read FFieldDefault write SetFieldDefault;  { mysql Default value eg F or 0 etc }

    property FieldFilter: string read FFieldFilter write SetFieldFilter;   { used for linking objects eg "SaleID = [SaleID]" (field names will be sutituted with header field values }
  end;
  {$M-}


implementation

uses
  SysUtils, MySQLUtils, DB;

const
  MappingDatabase = 'erpdocumentation';
  SchemaObjectCreateSQL =
    'CREATE TABLE if not exists `tblErpSchemaObject` (' +
    ' `ID` INT(11) NOT NULL AUTO_INCREMENT,' +
    ' `Version` VARCHAR(255) NOT NULL DEFAULT "2017.0000.0000.0000",' +
    ' `ERPVisible` ENUM("T","F") NOT NULL DEFAULT "F",' +
    ' `Description` TEXT NULL DEFAULT NULL,' +
    ' `ObjectName` VARCHAR(255) NULL DEFAULT NULL,' +
    ' `TableName` VARCHAR(255) NULL DEFAULT NULL,' +
    ' `TableFilter` VARCHAR(255) NULL DEFAULT "",' +
	  ' `msTimeStamp` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,' +
    ' PRIMARY KEY (`ID`),' +
    ' INDEX ObjectNameIdx (ObjectName),' +
    ' INDEX ERPVersionIdx (ERPVersion)' +
    ')ENGINE=MyISAM  COMMENT="TableVersion 1";';

  SchemaObjectMasterCreateSQL =
    'CREATE TABLE if not exists `tblErpSchemaObject_Master` (' +
    ' `ID` INT(11) NOT NULL AUTO_INCREMENT,' +
    ' `Version` VARCHAR(255) NOT NULL DEFAULT "2017.0000.0000.0000",' +
    ' `ERPVisible` ENUM("T","F") NOT NULL DEFAULT "F",' +
    ' `Description` TEXT NULL DEFAULT NULL,' +
    ' `ObjectName` VARCHAR(255) NULL DEFAULT NULL,' +
    ' `TableName` VARCHAR(255) NULL DEFAULT NULL,' +
    ' `TableFilter` VARCHAR(255) NULL DEFAULT "",' +
	  ' `msTimeStamp` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,' +
    ' PRIMARY KEY (`ID`),' +
    ' INDEX ObjectNameIdx (ObjectName),' +
    ' INDEX ERPVersionIdx (ERPVersion)' +
    ')ENGINE=INNODB  COMMENT="TableVersion 1";';

  SchemaPropertyCreateSQL =
    'CREATE TABLE if not exists `tblErpSchemaProperty` (' +
    ' `ID` INT(11) NOT NULL AUTO_INCREMENT,' +
    ' `ERPVersion` VARCHAR(255) NOT NULL DEFAULT "2017.0000.0000.0000",' +
    ' `Visible` ENUM("T","F") NOT NULL DEFAULT "F",' +
    ' `Description` TEXT NULL DEFAULT NULL,' +
    ' `ObjectName` VARCHAR(255) NULL DEFAULT NULL,' +
    ' `PropertyType` INT(11) NOT NULL DEFAULT 0,' +
    ' `PropertyName` VARCHAR(255) NULL DEFAULT NULL,' +
    ' `FieldName` VARCHAR(255) NULL DEFAULT NULL,' +
    ' `FieldType` VARCHAR(255) NULL DEFAULT NULL,' +
    ' `FieldDefault` VARCHAR(255) NULL DEFAULT NULL,' +
    ' `FieldAllowNull` ENUM("T","F") NULL DEFAULT NULL,' +
    ' `FieldFilter` VARCHAR(255) NULL DEFAULT "",' +
	  ' `msTimeStamp` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,' +
    ' PRIMARY KEY (`ID`),' +
    ' INDEX ObjectIdx (ObjectName),' +
    ' INDEX ERPVersionIdx (ERPVersion)' +
    ')ENGINE=MyISAM  COMMENT="TableVersion 1";';

  SchemaPropertyMasterCreateSQL =
    'CREATE TABLE if not exists `tblErpSchemaProperty_Master` (' +
    ' `ID` INT(11) NOT NULL AUTO_INCREMENT,' +
    ' `ERPVersion` VARCHAR(255) NOT NULL DEFAULT "2017.0000.0000.0000",' +
    ' `Visible` ENUM("T","F") NOT NULL DEFAULT "F",' +
    ' `Description` TEXT NULL DEFAULT NULL,' +
    ' `ObjectName` VARCHAR(255) NULL DEFAULT NULL,' +
    ' `PropertyType` INT(11) NOT NULL DEFAULT 0,' +
    ' `PropertyName` VARCHAR(255) NULL DEFAULT NULL,' +
    ' `FieldName` VARCHAR(255) NULL DEFAULT NULL,' +
    ' `FieldType` VARCHAR(255) NULL DEFAULT NULL,' +
    ' `FieldDefault` VARCHAR(255) NULL DEFAULT NULL,' +
    ' `FieldAllowNull` ENUM("T","F") NULL DEFAULT NULL,' +
    ' `FieldFilter` VARCHAR(255) NULL DEFAULT "",' +
	  ' `msTimeStamp` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,' +
    ' PRIMARY KEY (`ID`),' +
    ' INDEX ObjectIdx (ObjectID),' +
    ' INDEX ERPVersionIdx (ERPVersion)' +
    ')ENGINE=INNODB  COMMENT="TableVersion 1";';


{ TSchemaObjBase }

procedure TSchemaObjBase.SetDescription(const Value: string);
begin
  FDescription := Value;
  Dirty := true;
end;

procedure TSchemaObjBase.SetERPVersion(const Value: string);
begin
  fERPVersion := Value;
  Dirty := true;
end;

procedure TSchemaObjBase.SetVisible(const Value: boolean);
begin
  FVisible := Value;
  Dirty := true;
end;

{ TSchemaObject }

procedure TSchemaObject.SetObjectName(const Value: string);
begin
  FObjectName := Value;
  Dirty := true;
end;

procedure TSchemaObject.SetTableFilter(const Value: string);
begin
  FTableFilter := Value;
  Dirty := true;
end;

procedure TSchemaObject.SetTableName(const Value: string);
begin
  FTableName := Value;
  Dirty := true;
end;

class function TSchemaObject.UpdateProperties(const aVersion, aNewVersion,
  aObjectName, aTableName: string; conn: TERPConnection): boolean;
var
  qryExistProps: TERPQuery;
  qryDbFields: TERPQuery;
  ErpConn: TERPConnection;
  xVisible: boolean;
  xDescription: string;
  xPropertyName: string;
  xFieldFilter: string;

  function AllowNullToBool(const val: string): boolean;
  begin
    result := SameText(val,'YES');
  end;

begin
  result := false;
  qryExistProps := TERPQuery.Create(nil);
  ErpConn := TERPConnection.Create(nil);
  qryDbFields := TERPQuery.Create(nil);
  try
    qryExistProps.Connection := conn;
    qryExistProps.SQL.Add('select * from tblerpschemaproperty_master');
    qryExistProps.SQL.Add('where ObjectName = ' + QuotedStr(aObjectName));
    qryExistProps.SQL.Add('and ID = (select max(ID) from tblerpschemaproperty_master m where m.ObjectName = tblerpschemaproperty_master.ObjectName and m.ERPVersion <= :Version)');
    qryExistProps.ParamByName('Version').AsString := aVersion;
    qryExistProps.Open;
    SetConnectionProps(ErpConn,'erpnewdb',conn.Server);
    ErpConn.Connect;
    qryDbFields.Connection := ErpConn;
    qryDbFields.SQL.Text := 'show fields from ' + aTableName;
    qryDbFields.Open;
    while not qryDbFields.Eof do begin
      if qryExistProps.Locate('FieldName',qryDbFields.FieldByName('Field').AsString,[loCaseInsensitive]) then begin
        { found! .. check no db stuff has been changed .. }
        if (qryExistProps.FieldByName('FieldType').AsString <> qryDbFields.FieldByName('Type').AsString) or
           (qryExistProps.FieldByName('FieldAllowNull').AsBoolean <> AllowNullToBool(qryDbFields.FieldByName('Null').AsString)) or
           (qryExistProps.FieldByName('FieldDefault').AsString <> qryDbFields.FieldByName('Default').AsString) then begin
          { structure has changed so make a new version .. }
          result := true;
          xVisible := qryExistProps.FieldByName('Visible').Asboolean;
          xDescription := qryExistProps.FieldByName('Description').AsString;
          xPropertyName := qryExistProps.FieldByName('PropertyName').AsString;
          xFieldFilter := qryExistProps.FieldByName('FieldFilter').AsString;

          qryExistProps.Insert;
          qryExistProps.FieldByName('ERPVersion').AsString := aNewVersion;
          qryExistProps.FieldByName('Visible').Asboolean := xVisible;
          qryExistProps.FieldByName('ObjectName').AsString := aObjectName;
          qryExistProps.FieldByName('PropertyType').AsInteger := 0;  { simple property }
          qryExistProps.FieldByName('PropertyName').AsString := xPropertyName;
          qryExistProps.FieldByName('FieldName').AsString := qryDbFields.FieldByName('Field').AsString;
          qryExistProps.FieldByName('FieldType').AsString := qryDbFields.FieldByName('Type').AsString;
          qryExistProps.FieldByName('FieldDefault').AsString := qryDbFields.FieldByName('Default').AsString;
          if qryExistProps.FieldByName('Null').AsString = 'YES' then
            qryExistProps.FieldByName('FieldAllowNull').Asboolean := true
          else
            qryExistProps.FieldByName('FieldAllowNull').Asboolean := false;
          qryExistProps.FieldByName('FieldFilter').AsString := xFieldFilter;
          qryExistProps.FieldByName('Description').AsString := xDescription;
          qryExistProps.Post;
        end;
      end
      else begin
        { not found so create it .. }
        result := true;
        qryExistProps.Insert;
        qryExistProps.FieldByName('ERPVersion').AsString := aNewVersion;
        qryExistProps.FieldByName('Visible').Asboolean := false; {  hide it untill we have made user friendly }
        qryExistProps.FieldByName('ObjectName').AsString := aObjectName;
        qryExistProps.FieldByName('PropertyType').AsInteger := 0;  { simple property }
        qryExistProps.FieldByName('PropertyName').AsString := 'Field_' + qryDbFields.FieldByName('Field').AsString;
        qryExistProps.FieldByName('FieldName').AsString := qryDbFields.FieldByName('Field').AsString;
        qryExistProps.FieldByName('FieldType').AsString := qryDbFields.FieldByName('Type').AsString;
        qryExistProps.FieldByName('FieldDefault').AsString := qryDbFields.FieldByName('Default').AsString;
        if qryDbFields.FieldByName('Null').AsString = 'YES' then
          qryExistProps.FieldByName('FieldAllowNull').Asboolean := true
        else
          qryExistProps.FieldByName('FieldAllowNull').Asboolean := false;
        qryExistProps.FieldByName('FieldFilter').AsString := '';
          qryExistProps.FieldByName('Description').AsString := '';
        qryExistProps.Post;
      end;

      qryDbFields.Next;
    end;

  finally
    qryExistProps.Free;
    qryDbFields.Free;
    ErpConn.Free;
  end;

end;

{ TSchemaProperty }

procedure TSchemaProperty.SetFieldAllowNull(const Value: boolean);
begin
  FFieldAllowNull := Value;
  Dirty := true;
end;

procedure TSchemaProperty.SetFieldDefault(const Value: string);
begin
  FFieldDefault := Value;
  Dirty := true;
end;

procedure TSchemaProperty.SetFieldFilter(const Value: string);
begin
  FFieldFilter := Value;
  Dirty := true;
end;

procedure TSchemaProperty.SetFieldName(const Value: string);
begin
  FFieldName := Value;
  Dirty := true;
end;

procedure TSchemaProperty.SetFieldType(const Value: string);
begin
  FFieldType := Value;
  Dirty := true;
end;

procedure TSchemaProperty.SetPropertyName(const Value: string);
begin
  FPropertyName := Value;
  Dirty := true;
end;

procedure TSchemaProperty.SetObjectName(const Value: string);
begin
  FObjectName := Value;
  Dirty := true;
end;

procedure TSchemaProperty.SetPropertyType(const Value: integer);
begin
  FPropertyType := Value;
  Dirty := true;
end;

end.
