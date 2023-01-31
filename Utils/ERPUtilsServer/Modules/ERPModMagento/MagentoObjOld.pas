unit MagentoObjOld;

interface

uses
  LogThreadBase, LogMessageTypes, magento_v2_soap, ERPDbComponents,
  JsonDbPrefsConfigObj, JsonObject, MyAccess,
  MagentoAttributeSetList;

type

  MagentoConfig = class(TJsonDbPefConfig)
  private
    procedure SetERPDatabase(const Value: string);
    procedure SetMagentoKey(const Value: string);
    procedure SetMagentoUserName(const Value: string);
    procedure SetStoreURL(const Value: string);
    function GetERPDatabase: string;
    function GetMagentoKey: string;
    function GetMagentoUserName: string;
    function GetStoreURL: string;
    function GetUpdateTimes: TJsonObject;
    function GetStoreId: string;
    procedure SetStoreId(const Value: string);
    function GetDefaultAttributeSetName: string;
    procedure SetDefaultAttributeSetName(const Value: string);
    procedure SetDefaults;
  public
    constructor Create;
    procedure Load(connection: TMyConnection); overload;
    property StoreURL: string read GetStoreURL write SetStoreURL;
    property StoreID: string read GetStoreId write SetStoreId;
    property MagentoUserName: string read GetMagentoUserName write SetMagentoUserName;
    property MagentoKey: string read GetMagentoKey write SetMagentoKey;
    property ERPDatabase: string read GetERPDatabase write SetERPDatabase;
    property UpdateTimes: TJsonObject read GetUpdateTimes;
    property DefaultAttributeSetName: string read GetDefaultAttributeSetName write SetDefaultAttributeSetName;
  end;

  TMagento = class
  private
    fLogger: TLoggerBase;
    fConfig: MagentoConfig;
    fOnLogEvent: LogThreadBase.TOnLogEvent;
    fSessionId: string;
    SaveStoreURL: string;
    SaveMagentoUserName: string;
    SaveMagentoKey: string;
    SaveERPDatabase: string;
    fMage: Mage_Api_Model_Server_V2_HandlerPortType;
    fConnection: TERPConnection;
    fXRefQry: TERPQuery;
    fXRefCmd: TERPCommand;
    fStoreEnt: storeEntity;
    AttributeSetList: TMageAttributeSetList;

    procedure Log(const aMsg: string; const aType: TLogMessageType);
    function GetSessionId: string;
    function Connection: TERPConnection;
    function SynchProductToSore(ProductId: integer; var ChangesMade: Boolean): boolean;
    function XRefShopInstID(OpjectName: string; ERPInstId: integer): string;
    procedure XRefDelete(OpjectName: string; ERPInstId: integer);
    procedure XReffUpdate(OpjectName, ShopInstId: string; ERPInstId: integer);
    function XRefQry: TERPQuery;
    function XRefCmd: TERPCommand;
    function StoreEnt: storeEntity;
    procedure Reset;
    function MakeURLKey(s: string): string;
    procedure FlagChangeTriggerAsDone(const Id: integer);
  public
    constructor Create;
    destructor Destroy; override;
    function Mage: Mage_Api_Model_Server_V2_HandlerPortType;
    property Logger: TLoggerBase read fLogger write fLogger;
    property OnLogEvent: LogThreadBase.TOnLogEvent read fOnLogEvent write fOnLogEvent;
    property Config: MagentoConfig read fConfig;
    property SessionId: string read GetSessionId;
    function SynchProductsToStore(var msg: string): boolean;
    function SynchAttributeSets(var msg: string): boolean;
  end;

implementation

uses
  MySQLUtils, UpdateTriggersObj, DbSharedObjectsObj, SysUtils, Classes, Types,
  StrUtils;

const
  API_URL = 'api/v2_soap';
  FaultProductNotExists = 'Product not exists';

{ MagentoConfig }

constructor MagentoConfig.Create;
begin
  inherited;
  SetDefaults;
end;

function MagentoConfig.GetDefaultAttributeSetName: string;
begin
  result := S['DefaultAttributeSetName'];
end;

function MagentoConfig.GetERPDatabase: string;
begin
  result := S['ERPDatabase'];
end;

function MagentoConfig.GetMagentoKey: string;
begin
  result := S['MagentoKey'];
end;

function MagentoConfig.GetMagentoUserName: string;
begin
  result := S['MagentoUserName'];
end;

function MagentoConfig.GetStoreId: string;
begin
  result := S['StoreId'];
end;

function MagentoConfig.GetStoreURL: string;
begin
  result := s['StoreURL'];
end;

function MagentoConfig.GetUpdateTimes: TJsonObject;
begin
  result := O['UpdateTimes'];
end;

procedure MagentoConfig.Load(connection: TMyConnection);
begin
  inherited;
  SetDefaults;
end;

procedure MagentoConfig.SetDefaultAttributeSetName(const Value: string);
begin
  S['DefaultAttributeSetName'] := Value;
end;

procedure MagentoConfig.SetDefaults;
begin
  if S['DefaultAttributeSetName'] = '' then
    S['DefaultAttributeSetName'] := 'Default';
end;

procedure MagentoConfig.SetERPDatabase(const Value: string);
begin
  S['ERPDatabase'] := Value;
end;

procedure MagentoConfig.SetMagentoKey(const Value: string);
begin
  S['MagentoKey'] := Value;
end;

procedure MagentoConfig.SetMagentoUserName(const Value: string);
begin
  S['MagentoUserName'] := Value;
end;

procedure MagentoConfig.SetStoreId(const Value: string);
begin
  S['StoreId'] := Value;
end;

procedure MagentoConfig.SetStoreURL(const Value: string);
begin
  S['StoreURL'] := Value;
end;

{ TMagento }

function TMagento.Connection: TERPConnection;
begin
  if (not Assigned(fConnection)) or (SaveERPDatabase <> Config.ERPDatabase) then begin
    if Assigned(fConnection) and fConnection.Connected and fConnection.InTransaction then
      fConnection.Rollback;
    if not Assigned(fConnection) then begin
      fConnection := TERPConnection.Create(nil);
      SetConnectionProps(fConnection);
    end;
    if fConnection.Connected then fConnection.Disconnect;
    fConnection.Database := Config.ERPDatabase;
    fConnection.Connect;
    SaveERPDatabase := Config.ERPDatabase;
  end;
  result := fConnection;
end;

constructor TMagento.Create;
begin
  fConfig := MagentoConfig.Create;
  fSessionId := '';
  AttributeSetList := TMageAttributeSetList.Create(self);
end;

destructor TMagento.Destroy;
begin
  Reset;
  AttributeSetList.Free;
  if (fSessionId <> '') and Assigned(fMage) then
    fMage.endSession(fSessionId);
  fMage := nil;
  fConfig.Free;
  fXRefQry.Free;
  fXRefCmd.Free;
  fConnection.Free;
  inherited;
end;

procedure TMagento.FlagChangeTriggerAsDone(const Id: integer);
var
  scr: TERPScript;
begin
  scr := DbSharedObjectsObj.DbSharedObj.GetScript(Connection);
  try
    scr.SQL.Add('insert into tblchangetriggerdone (Id,TriggerFor,ObjectType,InstId,msTimeStamp,msUpdateSiteCode,Processed)');
    scr.SQL.Add('(select Id,TriggerFor,ObjectType,InstId,msTimeStamp,msUpdateSiteCode,Now()');
    scr.SQL.Add('from tblchangetrigger where Id = ' + IntToStr(Id) + ');');
    scr.SQL.Add('delete from tblchangetrigger where Id = ' + IntToStr(Id) + ';');
    scr.Execute;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(scr);
  end;
end;

function TMagento.GetSessionId: string;
var
  s: string;
begin
  if (fSessionId = '') then begin
    fSessionId := Mage.login(Config.MagentoUserName, Config.MagentoKey);
  end;
  result := fSessionId;
end;

procedure TMagento.Log(const aMsg: string; const aType: TLogMessageType);
begin
  if Assigned(fLogger) then fLogger.Log(aMsg, aType);
  if Assigned(fOnLogEvent) then fOnLogEvent(aMsg, aType);
end;

function TMagento.Mage: Mage_Api_Model_Server_V2_HandlerPortType;
var
  s: string;
begin
  if  (SaveStoreURL <> Config.StoreURL) or
      (SaveMagentoUserName <> Config.MagentoUserName) or
      (SaveMagentoKey <> Config.MagentoKey) then begin
    if (fSessionId <> '') and Assigned(fMage) then
      fMage.endSession(fSessionId);
    fMage := nil;
    fSessionId := '';
    Reset;
    s := Config.StoreURL;
    if Copy(s,Length(s),1) <> '/' then
      s := s  + '/';
    s := s + API_URL;
    fMage := GetMage_Api_Model_Server_V2_HandlerPortType(false, s);
    SaveStoreURL := Config.StoreURL;
    SaveMagentoUserName := Config.MagentoUserName;
    SaveMagentoKey := Config.MagentoKey;
  end;
  result := FMage;
end;

function TMagento.MakeURLKey(s: string): string;
begin
  result := Lowercase(s);
  result := StringReplace(result,' ','-',[rfReplaceAll]);
end;

procedure TMagento.Reset;
var
  I: integer;
begin
  FreeAndNil(fStoreEnt);
  AttributeSetList.Invalidate;
end;

function TMagento.StoreEnt: storeEntity;
begin
  if not Assigned(fStoreEnt) then
    fStoreEnt := Mage.storeInfo(SessionId,Config.StoreID);
  result := fStoreEnt;
end;

function TMagento.SynchAttributeSets(var msg: string): boolean;
var
  qry: TERPQuery;
  DoneList: TStringList;
  ProdGroup: TStringDynArray;
  GroupName: string;
  I: integer;
  found: boolean;
begin
  result := true;
  try
    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Connection);
    DoneList := TStringList.Create;
    try
      DoneList.CaseSensitive := false;
      qry.SQL.Add('select distinct ProductGroup from tblparts');
      qry.SQL.Add('where PublishOnWeb = "T"');
      qry.SQL.Add('and Active = "T"');
      qry.SQL.Add('and Discontinued = "F"');
      qry.SQL.Add('and ProductGroup = ifnull(ProductGroup,"") <> ""');
      qry.Open;
      if AttributeSetList.DefaultAttributeSetId = 0 then
        raise Exception.Create('Could not find default ('+Config.DefaultAttributeSetName+') Attribute Set in Magento');
      found := false;
      while not qry.Eof do begin
        ProdGroup := SplitString(qry.FieldByName('ProductGroup').AsString,'^');
        GroupName := ProdGroup[0];
        if DoneList.IndexOf(GroupName) < 0 then begin
          if not AttributeSetList.SetNameExists(GroupName) then begin
            { create in Magento }
            found := true;
            Mage.catalogProductAttributeSetCreate(SessionId,GroupName,IntToStr(AttributeSetList.DefaultAttributeSetId));
            Log('Added Attribute Set "' + GroupName + '" to store.',ltDetail);
          end;
          DoneList.Add(GroupName);
        end;
        qry.Next;
      end;
      if not found then
        Log('No Product Groups found that need to be synchronized.', ltDetail);
    finally
      DoneList.Free;
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    end;
    AttributeSetList.Invalidate; { force reload if accessed later }
  except
    on e: exception do begin
      result := false;
      msg := 'Error while checking Magento Attribute Sets: ' + e.Message;
      Log(msg, ltError);
    end;
  end;
end;

function TMagento.SynchProductsToStore(var msg: string): boolean;
var
  qry: TERPQuery;
//  cmd: TERPCommand;
  found: boolean;
  ChangesMade: boolean;
begin
  result := true;
  TUpdateTriggers.GenerateTriggers(Config.ERPDatabase,'Magento.' +Config.StoreID,ObjectType_Product);
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Connection);
//  cmd := DbSharedObjectsObj.DbSharedObj.GetCommand(Connection);
  try
//    cmd.SQL.Add('delete from tblchangetrigger where Id = :Id');
    qry.SQL.Add('select * from tblchangetrigger');
    qry.SQL.Add('where TriggerFor = ' + QuotedStr('Magento.' + Config.StoreID));
    qry.SQL.Add('and ObjectType = ' + QuotedStr(ObjectType_Product));
    qry.Open;
    found:= false;
    ChangesMade:= false;
    while not qry.Eof do begin
      if SynchProductToSore(qry.FieldByName('InstId').AsInteger, ChangesMade) then begin
        FlagChangeTriggerAsDone(qry.FieldByName('Id').AsInteger);
        //cmd.ParamByName('Id').AsInteger := qry.FieldByName('Id').AsInteger;
        //cmd.Execute;
        if ChangesMade then
          found:= true;
      end
      else begin
        result := false;
        exit;
      end;
      qry.Next;
    end;
    if not found then
      Log('No products found that need to be synchronized.',ltDetail);
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    //DbSharedObjectsObj.DbSharedObj.ReleaseObj(cmd);
  end;
end;

function TMagento.SynchProductToSore(ProductId: integer; var ChangesMade: Boolean): boolean;
var
  qry: TERPQuery;
  ShopProductId: string;
  ProductActive: boolean;
  cpc: catalogProductCreateEntity;
  cpr: catalogProductReturnEntity;
  websites: ArrayOfString;
  sku: string;
  AttributeSetId: integer;
  ProdGroups: TStringDynArray;
begin
  result := true;
  try
    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Connection);
    cpr := nil;
    try
      qry.SQL.Add('select * from tblparts where partsid = ' + IntToStr(ProductId));
      qry.Open;
      ShopProductId := self.XRefShopInstID(ObjectType_Product,ProductId);
      ProductActive := qry.FieldByName('PublishOnWeb').AsBoolean and
                    qry.FieldByName('Active').AsBoolean and
                    (not qry.FieldByName('Discontinued').AsBoolean);

      if ProductActive then begin
        { we want this product in the online shop }
        sku := qry.FieldByName('PartName').AsString;
        if qry.FieldByName('ProductGroup').AsString = '' then begin
          result := false;
          Log('Could not synchronize product "' + sku +
            '" as it does not have any Product Group values assigned.',ltError);
          exit;
        end;

        { make sure we still have this product in Magento }
        if ShopProductId <> '' then begin
          try
            cpr := Mage.catalogProductInfo(SessionId,ShopProductId,'',nil,'');
          except
            on e: exception do begin
              if Pos(FaultProductNotExists, e.Message) > 0 then
                ShopProductId := ''
              else
                raise;
            end;
          end;
        end;

        if ShopProductId = '' then begin
          { add product to shop .. }
          cpc := catalogProductCreateEntity.Create;
          try
            //cpc.categories
            SetLength(websites,1);
            websites[0] := IntToStr(StoreEnt.website_id);
            cpc.websites := websites;
            cpc.name_ := qry.FieldByName('PartName').AsString;
            cpc.description := qry.FieldByName('PartsDescription').AsString;
            cpc.short_description := qry.FieldByName('PartsDescription').AsString;
            cpc.weight := qry.FieldByName('NetWeightKg').AsString;
            cpc.status := '1'; { enabled }
            cpc.url_key := MakeURLKey(qry.FieldByName('PartsDescription').AsString);
            cpc.url_path := cpc.url_key + '.html';
            cpc.visibility := '1';
            //cpc.category_ids
            cpc.website_ids := websites;
            cpc.has_options := '0';
            cpc.gift_message_available := '';
            cpc.price := FormatFloat('#0.00#;-#0.00#', qry.FieldByName('Price1').AsFloat);
            cpc.special_price := '';
            cpc.special_from_date := '';
            cpc.special_to_date := '';
            //cpc.tax_class_id :=
            //cpc.tier_price
            cpc.meta_title := '';
            cpc.meta_description := '';
            cpc.custom_design  := '';
            cpc.custom_layout_update := '';
            //cpc.options_container
            //cpc.additional_attributes
            //cpc.stock_data

            ProdGroups := SplitString(qry.FieldByName('ProductGroup').AsString,'^');
            AttributeSetId := AttributeSetList.IdForSetName(ProdGroups[0]);
            ShopProductId := IntToStr(Mage.catalogProductCreate(SessionId,'simple',IntToStr(AttributeSetId),sku,cpc,''));
            ChangesMade := true;
            Log('Added product "' + qry.FieldByName('PartName').AsString + '" to store.',ltDetail);
          finally
            cpc.Free;
          end;
        end
        else begin
          { update shop product .. }
         //function  catalogProductUpdate(const sessionId: string; const product: string; const productData: catalogProductCreateEntity; const storeView: string; const identifierType: string): Boolean; stdcall;
          cpc := catalogProductCreateEntity.Create;
          try
            //cpc.categories
            SetLength(websites,1);
            websites[0] := IntToStr(StoreEnt.website_id);
            cpc.websites := websites;
            cpc.name_ := qry.FieldByName('PartName').AsString;
            cpc.description := qry.FieldByName('PartsDescription').AsString;
            cpc.short_description := qry.FieldByName('PartsDescription').AsString;
            cpc.weight := qry.FieldByName('NetWeightKg').AsString;
            cpc.status := '1'; { enabled }
            //cpc.url_key := MakeURLKey(qry.FieldByName('PartsDescription').AsString);
            //cpc.url_path := cpc.url_key + '.html';
            cpc.visibility := '1';
            //cpc.category_ids
            //cpc.website_ids := websites;
            //cpc.has_options := '0';
            //cpc.gift_message_available := '';
            cpc.price := FormatFloat('#0.00#;-#0.00#', qry.FieldByName('Price1').AsFloat);
            //cpc.special_price := '';
            //cpc.special_from_date := '';
            //cpc.special_to_date := '';
            //cpc.tax_class_id :=
            //cpc.tier_price
            //cpc.meta_title := '';
            //cpc.meta_description := '';
            //cpc.custom_design  := '';
            //cpc.custom_layout_update := '';
            //cpc.options_container
            //cpc.additional_attributes
            //cpc.stock_data

            if not Mage.catalogProductUpdate(SessionId,ShopProductId,cpc,'','') then begin
              raise Exception.Create('Product update call to Magento failed.');
            end;
            ChangesMade := true;
            Log('Updated product "' + qry.FieldByName('PartName').AsString + '" on store.',ltDetail);
          finally
            cpc.Free;
          end;
        end;
        self.XReffUpdate(ObjectType_Product,ShopProductId,ProductId);
      end
      else begin
        { this product should not be in the shop }
        if ShopProductId <> '' then begin
          { remove from shop .. }
          if Mage.catalogProductDelete(SessionId,ShopProductId,'') = 1 then begin
            XRefDelete(ObjectType_Product,ProductId);
            ChangesMade := true;
            Log('Removed product "' + qry.FieldByName('PartName').AsString + '" from store.',ltDetail);
            exit;
          end
          else begin
            result := false;
            Log('Failed to remove product "' + qry.FieldByName('PartName').AsString +
              '" with Shop Id: ' + ShopProductId + ' from Shop', ltError);
            exit;
          end;
        end;
      end;
    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
      cpr.Free;
    end;
  except
    on e: exception do begin
      result := false;
      Log('Error updating product to store: ' + e.Message, ltError);
    end;
  end;
end;

function TMagento.XRefCmd: TERPCommand;
begin
  if not Assigned(fXRefCmd) then begin
    fXRefCmd := TERPCommand.Create(nil);
    fXRefCmd.Connection := Connection;
    fXRefCmd.SQL.Add('insert into tblshopxref (ShopId,ObjectName,ShopInstId,ERPInstId)' );
    fXRefCmd.SQL.Add('values (:ShopId,:ObjectName,:ShopInstId,:ERPInstId)');
    fXRefCmd.SQL.Add('on duplicate key update ShopInstId = :ShopInstId');
  end;
  result := fXRefCmd;
end;

procedure TMagento.XRefDelete(OpjectName: string; ERPInstId: integer);
var
  cmd: TERPCommand;
begin
  cmd := DbSharedObjectsObj.DbSharedObj.GetCommand(Connection);
  try
    cmd.SQL.Add('delete from tblshopxref');
    cmd.SQL.Add('where ShopId = ' + QuotedStr(Config.StoreId));
    cmd.SQL.Add('and ObjectName = ' + QuotedStr(OpjectName));
    cmd.SQL.Add('and ERPInstId = ' + IntToStr(ERPInstId));
    cmd.Execute;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(cmd);
  end;
end;

procedure TMagento.XReffUpdate(OpjectName, ShopInstId: string;
  ERPInstId: integer);
begin
  XRefCmd.ParamByName('ShopId').AsString := Config.StoreID;
  XRefCmd.ParamByName('ObjectName').AsString := OpjectName;
  XRefCmd.ParamByName('ShopInstId').AsString := ShopInstId;
  XRefCmd.ParamByName('ERPInstId').AsInteger := ERPInstId;
  XRefCmd.Execute;
end;

function TMagento.XRefQry: TERPQuery;
begin
  if not Assigned(fXRefQry) then begin
    fXRefQry := TERPQuery.Create(nil);
    fXRefQry.Connection := Connection;
//    fXRefQry.SQL.Add('select * tblshopxref (ShopId,ObjectName,ShopInstId,ERPInstId)' );
//    fXRefQry.SQL.Add('values (:ShopId,:ObjectName,:ShopInstId,:ERPInstId)');
//    fXRefQry.SQL.Add('on duplicate key update ShopInstId = :ShopInstId');
  end;
  result := fXRefQry;
end;

function TMagento.XRefShopInstID(OpjectName: string;
  ERPInstId: integer): string;
begin
  XRefQry.SQL.Clear;
  XRefQry.SQL.Add('select ShopInstId from tblshopxref');
  XRefQry.SQL.Add('where ShopId = ' + QuotedStr(Config.StoreID));
  XRefQry.SQL.Add('and ObjectName = ' + QuotedStr(OpjectName));
  XRefQry.SQL.Add('and ERPInstId = ' + IntToStr(ERPInstId));
  XRefQry.Open;
  result := XRefQry.FieldByName('ShopInstId').AsString;
  XRefQry.Close;
end;

end.
