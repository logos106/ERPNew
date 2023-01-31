unit BusObjProductOption;

{
   Date     Version  Who    What
  -------- -------- ---     ------------------------------------------------------
  08/12/22  1.00.00  Wang   Initial Version.
}

interface

uses
  MyAccess,ERPdbComponents, DB, Dialogs, SysUtils, Variants, Classes,
  BusObjBase, XMLDoc, XMLIntf, commonlib;

type

  TProductOptionDetail = class(TMSBusObj)
  private
    function GetHeaderID        : Integer;
    function GetOptionName      : String;
    function GetOptionAbbr      : String;
    function GetCost            : Double;
    function GetPrice           : Double;
    function GetActive          : Boolean;

    procedure SetHeaderID       (const Value: Integer);
    procedure SetOptionName     (const Value: String);
    procedure SetOptionAbbr     (const Value: String);
    procedure SetCost           (const Value: Double);
    procedure SetPrice          (const Value: Double);
    procedure SetActive         (const Value: Boolean);

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    Function  DoAfterDelete(Sender :TDatasetBusObj): Boolean;           override;
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

    property HeaderID       :Integer     read GetHeaderID     write SetHeaderID  ;

  published
    property OptionName         : String                read GetOptionName  write SetOptionName;
    property OptionAbbr         : String                read GetOptionAbbr  write SetOptionAbbr;
    property Cost               : Double                read GetCost        write SetCost;
    property Price              : Double                read GetPrice       write SetPrice;
    property Active             : Boolean               read GetActive      write SetActive;

  end;

  TProductOptionHeader = class(TMSBusObj)
  private
    AllLinesValid: Boolean;

    function GetHeaderID        : Integer;
    function GetTemplateName    : String;
    function GetTemplateDesc    : String;
    function GetDisplayType     : String;
    function GetActive          : Boolean;
    function GetLines           : TProductOptionDetail;

    procedure SetTemplateName   (const Value: String);
    procedure SetTemplateDesc   (const Value: String);
    procedure SetDisplayType    (const Value: String);
    procedure SetActive         (const VAlue: Boolean);

  protected
    function  DoAfterInsert(Sender: TDatasetBusObj) : Boolean;  override;
    function  DoAfterPost(Sender: TDatasetBusObj)   : Boolean;  override;
    function  DoBeforePost(Sender: TDatasetBusObj)  : Boolean;  override;
    function  GetSQL                                : String;   override;

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
    property    HeaderID  : Integer   Read GetHeaderID;

  Published
    property TemplateName   : String                read GetTemplateName  write SetTemplateName;
    property TemplateDesc   : String                read GetTemplateDesc  write SetTemplateDesc;
    property DisplayType    : String                read GetDisplayType   write SetDisplayType;
    property Active         : Boolean               read GetActive        write SetActive;
    property Lines          : TProductOptionDetail read GetLines;

  end;

implementation

uses
   tcDataUtils, AppEnvironment, BusObjRegionalOptions,
   CommonDbLib, BusObjConst,  DNMLib, BusObjectListObj, BusObjSchemaLib,
   BusobjCountries, BusObjLocation, DbSharedObjectsObj, tcConst, Controls;


 { TProductOptionHeader }

function TProductOptionHeader.GetLines: TProductOptionDetail;
begin
  Result := TProductOptionDetail(Getcontainercomponent(TProductOptionDetail, 'id_header = ' + IntToStr(ID)));
end;

Constructor TProductOptionHeader.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSql := 'SELECT * FROM tblproductoptionheader';
end;

destructor TProductOptionHeader.Destroy;
begin
  inherited;
end;

class function TProductOptionHeader.GetBusObjectTablename: string;
begin
  Result := 'tblproductoptionheader';
end;

class function  TProductOptionHeader.GetIDField :String;
begin
    Result := 'ID';
end;

procedure TProductOptionHeader.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.

  inherited;
end;

function TProductOptionHeader.GetSQL: String;   begin    Result := inherited GetSQL;  end;

procedure TProductOptionHeader.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;

  SetPropertyFromNode(Node, 'TemplateName');
  SetPropertyFromNode(Node, 'TemplateDesc');
  SetPropertyFromNode(Node, 'DisplayType');
  SetBooleanPropertyFromNode(Node, 'Active');
end;

procedure TProductOptionHeader.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;

  AddXMLNode(node, 'TemplateName', TemplateName);
  AddXMLNode(node, 'TemplateDesc', TemplateName);
  AddXMLNode(node, 'DisplayType', TemplateName);
  AddXMLNode(node, 'Active', TemplateName);
end;

function TProductOptionHeader.Save :Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

function TProductOptionHeader.ValidateData :Boolean ;
begin
  Result := inherited ValidateData;
  if not result then Exit;

  Result := False;
  Resultstatus.Clear;

  Result := True;
end;

function TProductOptionHeader.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
end;

function TProductOptionHeader.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

function TProductOptionHeader.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not(Result) then Exit;
end;

class function TProductOptionHeader.GetKeyStringField: string;
begin
  Result := '';
end;

function TProductOptionHeader.GetHeaderID       : Integer;    begin  Result := GetIntegerField('ID');end;
function TProductOptionHeader.GetTemplateName   : String;     begin Result := GetStringField('OptionTemplateName'); end;
function TProductOptionHeader.GetTemplateDesc   : String;     begin Result := GetStringField('OptionTemplateDesc'); end;
function TProductOptionHeader.GetDisplayType    : String;     begin Result := GetStringField('DisplayType');        end;
function TProductOptionHeader.GetActive         : Boolean;    begin Result := GetBooleanField('Active');            end;

procedure TProductOptionHeader.SetTemplateName  (const Value: String);    begin SetStringField('OptionTemplateName', Value);  end;
procedure TProductOptionHeader.SetTemplateDesc  (const Value: String);    begin SetStringField('OptionTemplateDesc', Value);  end;
procedure TProductOptionHeader.SetDisplayType   (const Value: String);    begin SetStringField('DisplayType', Value);         end;
procedure TProductOptionHeader.SetActive        (const Value: Boolean);   begin SetBooleanField('Active', Value);             end;


 {TProductOptionDetail.}
constructor TProductOptionDetail.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'Product Option Details';
  fSQL := 'SELECT * FROM tblproductoptiondetails';
  fIsList := True;
end;

destructor TProductOptionDetail.Destroy;
begin
  inherited;
end;

procedure TProductOptionDetail.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

  SetPropertyFromNode(node, 'OptionName');
  SetPropertyFromNode(node, 'OptionAbbr');
  SetPropertyFromNode(node, 'Cost');
  SetPropertyFromNode(node, 'Price');
  SetBooleanPropertyFromNode(node, 'Active');
end;

procedure TProductOptionDetail.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;

  AddXMLNode(node, 'OptionName', OptionName);
  AddXMLNode(node,'OptionAbbr', OptionAbbr);
  AddXMLNode(node,'Cost', Cost);
  AddXMLNode(node,'Price', Price);
  AddXMLNode(node,'Active', Active);
end;

function TProductOptionDetail.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;

  Result := True;
end;

function TProductOptionDetail.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;

  Result := inherited Save;
end;

procedure TProductOptionDetail.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TProductOptionDetail.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
end;

function TProductOptionDetail.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TProductOptionDetail.GetIDField: string;
begin
  Result := 'ID'
end;

class function TProductOptionDetail.GetBusObjectTablename: string;
begin
  Result:= 'tblproductoptiondetails';
end;

function TProductOptionDetail.DoAfterDelete(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterDelete(Sender);
end;

function TProductOptionDetail.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoAfterInsert(Sender);
  if not result then exit;
  if Assigned(Owner) then
    if Owner is TProductOptionHeader then
      HeaderID := TProductOptionHeader(Owner).ID;
end;

function TProductOptionDetail.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

function TProductOptionDetail.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoBeforePost(Sender);
  if not result then exit;
end;

{Property Functions}
function TProductOptionDetail.GetHeaderID     : Integer;    begin Result := GetIntegerField('id_header');         end;
function TProductOptionDetail.GetOptionName   : String;     begin Result := GetStringField('OptionName');         end;
function TProductOptionDetail.GetOptionAbbr   : String;     begin Result := GetStringField('OptionAbbreviation'); end;
function TProductOptionDetail.GetCost         : Double;     begin Result := GetFloatField('Cost');                end;
function TProductOptionDetail.GetPrice        : Double;     begin Result := GetFloatField('Price');               end;
function TProductOptionDetail.GetActive       : Boolean;    begin Result := GetBooleanField('Active');            end;

procedure TProductOptionDetail.SetHeaderID    (const Value: Integer);   begin SetIntegerField('id_header', Value);          end;
procedure TProductOptionDetail.SetOptionName  (const Value: String);    begin SetStringField('OptionName', Value);          end;
procedure TProductOptionDetail.SetOptionAbbr  (const Value: String);    begin SetStringField('OptionAbbreviation', Value);  end;
procedure TProductOptionDetail.Setcost        (const Value: Double);    begin SetFloatField('Cost', Value);                 end;
procedure TProductOptionDetail.SetPrice       (const Value: Double);    begin SetFloatField('Price', Value);                end;
procedure TProductOptionDetail.SetActive      (const Value: Boolean);   begin SetBooleanField('Active', Value);             end;


initialization
  RegisterClassOnce(TProductOptionHeader);
  RegisterClass(TProductOptionDetail);
end.


