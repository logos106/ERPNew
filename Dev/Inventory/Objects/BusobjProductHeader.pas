unit BusObjProductHeader;

{
   Date     Version  Who    What
  -------- -------- ---     ------------------------------------------------------
  09/12/22  1.00.00  Wang   Initial Version.
}

interface

uses
  MyAccess,ERPdbComponents, DB, Dialogs, SysUtils, Variants, Classes,
  BusObjBase, XMLDoc, XMLIntf, commonlib;

type

  TProductHeaderDetail = class(TMSBusObj)
  private
//    function GetHeaderID      : Integer;
    function GetParentID      : Integer;
    function GetProductID     : Integer;
    function GetOptionName    : String;
    function GetOptionAbbrev  : String;
    function GetOptionCost    : Double;
    function GetOptionPrice   : Double;
    function GetObjectType    : String;
    function GetTemplateName  : String;
    function GetTemplateDesc  : String;
    function GetActive        : Boolean;

    procedure SetParentID     (const Value: Integer);
    procedure SetProductID    (const Value: Integer);
    procedure SetOptionName   (const Value: String);
    procedure SetOptionAbbrev (const Value: String);
    procedure SetOptionCost   (const Value: Double);
    procedure SetOptionPrice  (const Value: Double);
    procedure SetObjectType   (const Value: String);
    procedure SetTemplateName (const Value: String);
    procedure SetTemplateDesc (const Value: String);
    procedure SetActive       (const VAlue: Boolean);

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoBeforePost(Sender:TDatasetBusObj) : Boolean;            override;

  public
    procedure DoFieldOnChange(Sender: TField);                          override;
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;

//    property HeaderID       :Integer     read GetHeaderID     write SetHeaderID  ;

  published
    property ParentID     : Integer   read GetParentID      write SetParentID;
    property OptionName   : String    read GetOptionName    write SetOptionName;
    property OptionCost   : Double    read GetOptionCost    write SetOptionCost;
    property OptionPrice  : Double    read GetOptionPrice   write SetOptionPrice;
    property OptionAbbrev : String    read GetOptionAbbrev  write SetOptionAbbrev;
    property ObjectType   : String    read GetObjectType    write SetObjectType;
    property ProductID    : Integer   read GetProductID     write SetProductID;
    property TemplateName : String    read GetTemplateName  write SetTemplateName;
    property TemplateDesc : String    read GetTemplateDesc  write SetTemplateDesc;
    property Active       : Boolean   read GetActive        write SetActive;

  end;

  TProductHeader = class(TMSBusObj)
  private
    AllLinesValid: Boolean;

    function GetProductID   : Integer;
    function GetActive      : Boolean;
    function GetLines           : TProductHeaderDetail;

    procedure SetProductID  (const Value: Integer);
    procedure SetActive     (const VAlue: Boolean);

  protected
    function    DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function    DoAfterPost(Sender: TDatasetBusObj)  : Boolean; override;
    function    DoBeforePost(Sender: TDatasetBusObj) : Boolean; override;
    function    GetSQL                              : String;       Override;

  public
    procedure   DoFieldOnChange(Sender: TField);                    Override;
    class function GetBusObjectTablename: string; override;
    class function  GetIDField: string;                                   override;
    class function GetKeyStringField: string; override;
    Constructor Create(AOwner: TComponent);     Override;
    destructor  Destroy;                        Override;
    Procedure   LoadFromXMLNode(Const node: IXMLNode);Override;
    procedure   SaveToXMLNode(Const node: IXMLNode);  Override;
    function    ValidateData :Boolean ;         Override;
    function    Save :Boolean ;                 Override;

  Published
    property ProductID  : Integer               read GetProductID   write SetProductID;
    property Active     : Boolean               read GetActive      write SetActive;
    property Lines          : TProductHeaderDetail read GetLines;

  end;

implementation

uses
   tcDataUtils, AppEnvironment, BusObjRegionalOptions,
   CommonDbLib, BusObjConst,  DNMLib, BusObjectListObj, BusObjSchemaLib,
   BusobjCountries, BusObjLocation, DbSharedObjectsObj, tcConst, Controls;


 { TProductHeader }

function TProductHeader.GetLines: TProductHeaderDetail;
begin
  Result := TProductHeaderDetail(Getcontainercomponent(TProductHeaderDetail, 'h.id = ' + IntToStr(ID)));
end;

Constructor TProductHeader.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSql := 'SELECT * FROM tblproductheader';
end;

destructor TProductHeader.Destroy;
begin
  inherited;
end;

class function TProductHeader.GetBusObjectTablename: string;
begin
  Result := 'tblproductheader';
end;

class function  TProductHeader.GetIDField :String;
begin
    Result := 'ID';
end;

procedure TProductHeader.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.

  inherited;
end;

function TProductHeader.GetSQL: String;   begin    Result := inherited GetSQL;  end;

procedure TProductHeader.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;

  SetPropertyFromNode(Node, 'ProductID');
  SetPropertyFromNode(Node, 'Active');
end;

procedure TProductHeader.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;

  AddXMLNode(node, 'ProductID', ProductID);
  AddXMLNode(node, 'Active', Active);
end;

function TProductHeader.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  result := inherited Save;
end;

function TProductHeader.ValidateData :Boolean ;
begin
  result := inherited ValidateData;
  if not result then Exit;

  Result := False;
  Resultstatus.Clear;

  Result := True;
end;

function TProductHeader.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result:= inherited DoAfterInsert(Sender);
  if not Result then Exit;
end;

function TProductHeader.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

function TProductHeader.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not(Result) then Exit;
end;

class function TProductHeader.GetKeyStringField: string;
begin
  Result := '';
end;

function TProductHeader.GetProductID    : Integer;    begin Result := GetIntegerField('trueerp_product_id');            end;
function TProductHeader.GetActive       : Boolean;    begin Result := GetBooleanField('Active');                        end;

procedure TProductHeader.SetProductID   (const Value: Integer);   begin SetIntegerField('trueerp_product_id', Value);   end;
procedure TProductHeader.SetActive      (const Value: Boolean);   begin SetBooleanField('Active', Value);               end;


 {TProductHeaderDetail.}
constructor TProductHeaderDetail.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'Product Header Details';
  fSQL := 'SELECT * FROM tblproductheaderdetails d LEFT JOIN tblproductheader h ON d.id_product=h.trueerp_product_id';
  fIsList := True;
end;


destructor TProductHeaderDetail.Destroy;
begin
  inherited;
end;

procedure TProductHeaderDetail.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

  SetPropertyFromNode(node, 'ParentID');
  SetPropertyFromNode(node, 'ProductID');
  SetPropertyFromNode(node, 'OptionName');
  SetPropertyFromNode(node, 'OptionCost');
  SetPropertyFromNode(node, 'OptionPrice');
  SetPropertyFromNode(node, 'OptionAbbrev');
  SetPropertyFromNode(node, 'ObjectType');
  SetPropertyFromNode(node, 'TemplateName');
  SetPropertyFromNode(node, 'TemplateDesc');
  SetBooleanPropertyFromNode(node, 'Active');
end;

procedure TProductHeaderDetail.SaveToXMLNode(Const node: IXMLNode);
begin

  inherited;
  AddXMLNode(node, 'ParentID', ParentID);
  AddXMLNode(node, 'ProductID', OptionName);
  AddXMLNode(node, 'OptionName', OptionName);
  AddXMLNode(node, 'OptionCost', OptionName);
  AddXMLNode(node, 'OptionPrice', OptionName);
  AddXMLNode(node, 'OptionAbbrev', OptionName);
  AddXMLNode(node, 'ObjectType', OptionName);
  AddXMLNode(node, 'TemplateName', OptionName);
  AddXMLNode(node, 'TemplateDesc', OptionName);
  AddXMLNode(node, 'Active', OptionName);
end;

function TProductHeaderDetail.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;

  Result := True;
end;

function TProductHeaderDetail.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TProductHeaderDetail.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TProductHeaderDetail.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
end;

function TProductHeaderDetail.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TProductHeaderDetail.GetIDField: string;
begin
  Result := 'ID'
end;

class function TProductHeaderDetail.GetBusObjectTablename: string;
begin
  Result:= 'tblproductheaderdetails';
end;

function TProductHeaderDetail.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
//  if Assigned(Owner) then
//    if Owner is TProductHeader then
//      HeaderID := TProductHeader(Owner).ID;
end;

function TProductHeaderDetail.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

function TProductHeaderDetail.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not Result then Exit;
end;

{Property Functions}
//function TProductHeaderDetail.GetHeaderID     : Integer;    begin Result := GetIntegerField('id_header');         end;

function TProductHeaderDetail.GetParentID       : Integer;    begin Result := GetIntegerField('id_parent');     end;
function TProductHeaderDetail.GetProductID      : Integer;    begin Result := GetIntegerField('id_product');    end;
function TProductHeaderDetail.GetOptionName     : String;     begin Result := GetStringField('OptionName');     end;
function TProductHeaderDetail.GetOptionAbbrev   : String;     begin Result := GetStringField('OptionAbbrev');   end;
function TProductHeaderDetail.GetOptionCost     : Double;     begin Result := GetFloatField('OptionCost');      end;
function TProductHeaderDetail.GetOptionPrice    : Double;     begin Result := GetFloatField('OptionPrice');     end;
function TProductHeaderDetail.GetObjectType     : String;     begin Result := GetStringField('ObjectType');     end;
function TProductHeaderDetail.GetTemplateName   : String;     begin Result := GetStringField('TemplateName');  end;
function TProductHeaderDetail.GetTemplateDesc   : String;     begin Result := GetStringField('TemplateDesc');  end;
function TProductHeaderDetail.GetActive         : Boolean;    begin Result := GetBooleanField('Active');        end;

procedure TProductHeaderDetail.SetParentID      (const Value: Integer);   begin SetIntegerField('id_parent', Value);    end;
procedure TProductHeaderDetail.SetProductID     (const Value: Integer);   begin SetIntegerField('id_product', Value);   end;
procedure TProductHeaderDetail.SetOptionName    (const Value: String);    begin SetStringField('OptionName', Value);    end;
procedure TProductHeaderDetail.SetOptionAbbrev  (const Value: String);    begin SetStringField('OptionAbbrev', Value);  end;
procedure TProductHeaderDetail.SetOptionCost    (const Value: Double);    begin SetFloatField('OptionCost', Value);     end;
procedure TProductHeaderDetail.SetOptionPrice   (const Value: Double);    begin SetFloatField('OptionPrice', Value);    end;
procedure TProductHeaderDetail.SetObjectType    (const Value: String);    begin SetStringField('ObjectType', Value);    end;
procedure TProductHeaderDetail.SetTemplateName  (const Value: String);    begin SetstringField('TemplateName', Value); end;
procedure TProductHeaderDetail.SetTemplateDesc  (const Value: String);    begin SetStringField('TemplateDesc', Value); end;
procedure TProductHeaderDetail.SetActive        (const Value: Boolean);   begin SetBooleanField('Active', Value);       end;

initialization
  RegisterClassOnce(TProductHeader);
  RegisterClass(TProductHeaderDetail);
end.


