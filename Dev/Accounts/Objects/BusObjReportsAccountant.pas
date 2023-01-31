unit BusObjReportsAccountant;

{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 22/09/11  1.00.01 Wang  Added TReportsAccountant business object.
}

interface

uses
  MyAccess,ERPdbComponents, DB, Dialogs, SysUtils, Variants, Classes,
  BusObjBase, XMLDoc, XMLIntf, commonlib;

type

  TReportsAccountant = class(TMSBusObj)
  private
    function GetReportTitle         : String;
    function GetReportOrder         : String;
    function GetReportSummary       : String;
    function GetReportDeclaration   : String;
    function GetReportDescription   : String;
    function GetCreated             : TDateTime;
    function GetUpdated             : TDateTime;
    function GetActive              : Boolean;

    procedure SetReportTitle        (Const Value : String);
    procedure SetReportOrder        (Const Value : String);
    procedure SetReportSummary      (Const Value : String);
    procedure SetReportDeclaration  (Const Value : String);
    procedure SetReportDescription  (Const value : String);
    procedure SetCreated            (Const value : TDateTime);
    procedure SetUpdated            (Const Value : TDateTime);
    procedure SetActive             (Const Value : Boolean);

  protected
    function  DoAfterInsert(Sender: TDatasetBusObj)   : Boolean;    Override;
    function  DoAfterPost(Sender: TDatasetBusObj)     : Boolean;    Override;
    function  DoBeforePost(Sender: TDatasetBusObj)    : Boolean;    Override;
    function  GetSQL                                  : String;     Override;
    function  ValidateXMLData(Const Node :IXMLNode)   : Boolean;    Override;

  public
    Constructor     Create(AOwner: TComponent);             Override;
    destructor      Destroy;                                Override;
    procedure       DoFieldOnChange(Sender: TField);        Override;
    class function  GetBusObjectTablename: string;          Override;
    class function  GetIDField: string;                     Override;
    procedure       LoadFromXMLNode(Const node: IXMLNode);  Override;
    procedure       SaveToXMLNode(Const node: IXMLNode);    Override;
    function        ValidateData :Boolean ;                 Override;
    function        Save :Boolean ;                         Override;

  Published
    property ReportTitle        : String      Read GetReportTitle         Write SetReportTitle;
    property ReportOrder        : String      Read GetReportOrder         Write SetReportOrder;
    property ReportSummary      : String      Read GetReportSummary       Write SetReportSummary;
    Property ReportDeclaration  : String      Read GetReportDeclaration   Write SetReportDeclaration;
    Property ReportDescription  : String      Read GetReportDescription   Write SetReportDescription;
    Property Created            : TDateTime   Read GetCreated             Write SetCreated;
    Property Updated            : TDateTime   Read GetUpdated             Write SetUpdated;
    Property Active             : Boolean     Read GetActive              Write SetActive;

  end;

  TReportsAccountantCategory = class(TMSBusObj)
  private
    function GetFirstName     : String;
    function GetLastName      : String;
    function GetCompanyName   : String;
    function GetAddress       : String;
    function GetDocName       : String;
    function GetTownCity      : String;
    function GetPostalZip     : String;
    function GetStateRegion   : String;
    function GetCountry       : String;
    function GetActive        : Boolean;

    procedure SetFirstName    (Const Value : String);
    procedure SetLastName     (Const Value : String);
    procedure SetCompanyName  (Const Value : String);
    procedure SetAddress      (Const Value : String);
    procedure SetDocName      (Const value : String);
    procedure SetTownCity     (Const value : String);
    procedure SetPostalZip    (Const Value : String);
    procedure SetStateRegion  (Const Value : String);
    procedure SetCountry      (Const Value : String);
    procedure SetActive       (Const Value : Boolean);

  protected
    function  DoAfterInsert(Sender: TDatasetBusObj)   : Boolean;    Override;
    function  DoAfterPost(Sender: TDatasetBusObj)     : Boolean;    Override;
    function  DoBeforePost(Sender: TDatasetBusObj)    : Boolean;    Override;
    function  GetSQL                                  : String;     Override;

  public
    Constructor     Create(AOwner: TComponent);             Override;
    destructor      Destroy;                                Override;
    procedure       DoFieldOnChange(Sender: TField);        Override;
    class function  GetBusObjectTablename: string;          Override;
    class function  GetIDField: string;                     Override;
    procedure       LoadFromXMLNode(Const node: IXMLNode);  Override;
    procedure       SaveToXMLNode(Const node: IXMLNode);    Override;
    function        ValidateData :Boolean ;                 Override;
    function        Save :Boolean ;                         Override;

  Published
    property FirstName      : String      Read GetFirstName     Write SetFirstName;
    property LastName       : String      Read GetLastName      Write SetLastName;
    property CompanyName    : String      Read GetCompanyName   Write SetCompanyName;
    Property Address        : String      Read GetAddress       Write SetAddress;
    Property DocName        : String      Read GetDocName       Write SetDocName;
    Property TownCity       : String      Read GetTownCity      Write SetTownCity;
    Property PostalZip      : String      Read GetPostalZip     Write SetPostalZip;
    Property StateRegion    : String      Read GetStateRegion   Write SetStateRegion;
    Property Country        : String      Read GetCountry       Write SetCountry;
    Property Active         : Boolean     Read GetActive        Write SetActive;

  end;

implementation

uses
   tcDataUtils, AppEnvironment, BusObjRegionalOptions,
   CommonDbLib, BusObjConst,  DNMLib, BusObjectListObj, BusObjSchemaLib,
   BusobjCountries, BusObjLocation, DbSharedObjectsObj, tcConst, Controls;


 { TReportsAccountant }
Constructor TReportsAccountant.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSql := 'SELECT * FROM tblReportsAccountant';
//  ExportExcludeList.Add('ID');
end;

destructor TReportsAccountant.Destroy;
begin
  inherited;
end;

class function TReportsAccountant.GetBusObjectTablename: string;
begin
  Result := 'tblReportsAccountant';
end;

function TReportsAccountant.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function  TReportsAccountant.GetIDField :String;
begin
    Result := 'ID';
end;

procedure TReportsAccountant.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.

  inherited;
end;

Function  TReportsAccountant.ValidateXMLData(Const Node :IXMLNode) :Boolean ;
var
    fiRegionId :Integer;
    fsForeignKey :String;
begin
    Result      := inherited ValidateXMLData(Node);
    fiRegionId  := 0;
    if not Result then Exit;
    if not ImportingFromXMLFile then Exit;
    XMLSearchRecorddesc := 'Name ='  + QuotedStr(GetXMLNodeStringValue(Node, 'CodeName')) +
                            ' and region = ' + GetXMLNodeStringValue(Node, 'RegionName');
    REsult      := False;
    //foreign key validations
    fsForeignKey :='RegionName';
    if GetXMLNodeStringValue(Node, fsForeignKey) <> '' then begin
        fiRegionId		:= tcDatautils.GetRegion(GetXMLNodeStringValue   (Node, fsForeignKey));
        if fiRegionId = 0 then begin
            ErrRecordNotfound(fsForeignKey , GetXMLNodeStringValue(Node, fsForeignKey));
            Exit;
        end;
    end;

    Result := true;
    XMLSearchRecord := 'Name ='  + QuotedStr(GetXMLNodeStringValue(Node, 'CodeName')) + ' and regionId = ' + IntToStr(fiRegionId) ;
    LocateXMLRecord;

end;

function TReportsAccountant.GetReportTitle:         String;   begin Result := GetStringField('ReportTitle');        end;
function TReportsAccountant.GetReportOrder:         String;   begin Result := GetStringField('ReportOrder');        end;
function TReportsAccountant.GetReportSummary:       String;   begin Result := GetStringField('ReportSummary');      end;
function TReportsAccountant.GetReportDeclaration:   String;   begin Result := GetStringField('ReportDeclaration');  end;
function TReportsAccountant.GetReportDescription:   String;   begin Result := GetStringField('ReportDescription');  end;
function TReportsAccountant.GetCreated:             TDateTime;    begin Result := GetDateTimeField('Created');          end;
function TReportsAccountant.GetUpdated:             TDateTime;    begin Result := GetDateTimeField('Updated');          end;
function TReportsAccountant.GetActive:              Boolean;  begin Result := GetBooleanField('Active');            end;

procedure TReportsAccountant.SetReportTitle       (Const Value: String);  begin SetStringField('ReportTitle', Value);         end;
procedure TReportsAccountant.SetReportOrder       (Const Value: String);  begin SetStringField('ReportOrder', Value);         end;
procedure TReportsAccountant.SetReportSummary     (Const Value: String);  begin SetStringField('ReportSummary', Value);       end;
procedure TReportsAccountant.SetReportDeclaration (Const Value: String);  begin SetStringField('ReportDeclaration', Value);  end;
procedure TReportsAccountant.SetReportDescription (Const Value: String);  begin SetStringField('ReportDescription', Value);   end;
procedure TReportsAccountant.SetCreated           (Const Value: TDateTime);   begin SetDateTimeField('Created', Value);            end;
procedure TReportsAccountant.SetUpdated           (Const Value: TDateTime);   begin SetDateTimeField('Updated', Value);             end;
procedure TReportsAccountant.SetActive            (Const Value: Boolean); begin SetBooleanField('Active', Value);              end;

procedure TReportsAccountant.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node, 'ReportTitle');
  SetPropertyFromNode(Node, 'ReportOrder');
  SetPropertyFromNode(Node, 'ReportSummary');
  SetPropertyFromNode(Node, 'ReportDeclaration');
  SetPropertyFromNode(Node, 'ReportDescription');
  SetPropertyFromNode(Node, 'Created');
  SetPropertyFromNode(Node, 'Updated');
  SetBooleanPropertyFromNode(Node, 'Active');
end;

procedure TReportsAccountant.SaveToXMLNode(Const node: IXMLNode);
begin
    inherited;
    AddXMLNode(node , 'ReportTitle',        ReportTitle);
    AddXMLNode(node , 'ReportOrder',        ReportOrder);
    AddXMLNode(node , 'ReportSummary',      ReportSummary);
    AddXMLNode(node , 'ReportDeclaration',  ReportDeclaration);
    AddXMLNode(node , 'ReportDescription',  ReportDescription);
    AddXMLNode(node , 'Created',            Created);
    AddXMLNode(Node , 'Updated',            Updated);
    AddXMLNode(Node , 'Active',             Active);
end;

function TReportsAccountant.ValidateData : Boolean;
var
  CleanCodeName: string;
begin
  Result := inherited ValidateData;
  if not Result then Exit;

  Result := False;
  Resultstatus.Clear;
  if Trim(ReportTitle) = '' then begin
    AddResult(False, rssWarning, 0, 'Report title should not be blank');
    Exit;
  end;

  Result := True;
end;

function TReportsAccountant.Save :Boolean ;
begin
    Result := False;
    if not ValidateData then Exit;
    result := inherited Save;
end;

function TReportsAccountant.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result:= inherited DoAfterInsert(Sender);
  if not Result then exit;
end;

function TReportsAccountant.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not Result then Exit;
end;

function TReportsAccountant.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not(Result) then Exit;
end;

 { TReportsAccountantCategory }
Constructor TReportsAccountantCategory.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSql := 'SELECT * FROM tblReportsAccountantCategory';
  ExportExcludeList.Add('ID');
end;

destructor TReportsAccountantCategory.Destroy;
begin
  inherited;
end;

class function TReportsAccountantCategory.GetBusObjectTablename: string;
begin
  Result := 'tblReportsAccountantCategory';
end;

function TReportsAccountantCategory.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function  TReportsAccountantCategory.GetIDField :String;
begin
  Result := 'ID';
end;

procedure TReportsAccountantCategory.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.

  inherited;
end;

function TReportsAccountantCategory.GetFirstName:         String;   begin Result := GetStringField('FirstName');              end;
function TReportsAccountantCategory.GetLastName:          String;   begin Result := GetStringField('LastName');               end;
function TReportsAccountantCategory.GetCompanyName:       String;   begin Result := GetStringField('CompanyName');            end;
function TReportsAccountantCategory.GetAddress:           String;   begin Result := GetStringField('Address');                end;
function TReportsAccountantCategory.GetDocName:           String;   begin Result := GetStringField('DocName');                end;
function TReportsAccountantCategory.GetTownCity:          String;   begin Result := GetStringField('TownCity');               end;
function TReportsAccountantCategory.GetPostalZip:         String;   begin Result := GetStringField('PostalZip');              end;
function TReportsAccountantCategory.GetStateRegion:       String;   begin Result := GetStringField('StateRegion');            end;
function TReportsAccountantCategory.GetCountry:           String;   begin Result := GetStringField('Country');                end;
function TReportsAccountantCategory.GetActive:            Boolean;  begin Result := GetBooleanField('Active');                end;

procedure TReportsAccountantCategory.SetFirstName         (Const Value: String);  begin SetStringField('FirstName', Value);   end;
procedure TReportsAccountantCategory.SetLastName          (Const Value: String);  begin SetStringField('LastName', Value);    end;
procedure TReportsAccountantCategory.SetCompanyName       (Const Value: String);  begin SetStringField('CompanyName', Value); end;
procedure TReportsAccountantCategory.SetAddress           (Const Value: String);  begin SetStringField('Address', Value);     end;
procedure TReportsAccountantCategory.SetDocName           (Const Value: String);  begin SetStringField('DocName', Value);     end;
procedure TReportsAccountantCategory.SetTownCity          (Const Value: String);  begin SetStringField('TownCity', Value);    end;
procedure TReportsAccountantCategory.SetPostalZip         (Const Value: String);  begin SetStringField('PostalZip', Value);   end;
procedure TReportsAccountantCategory.SetStateRegion       (Const Value: String);  begin SetStringField('StateRegion', Value); end;
procedure TReportsAccountantCategory.SetCountry           (Const Value: String);  begin SetStringField('Country', Value);     end;
procedure TReportsAccountantCategory.SetActive            (Const Value: Boolean); begin SetBooleanField('Active', Value);     end;

procedure TReportsAccountantCategory.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node, 'FirstName');
  SetPropertyFromNode(Node, 'LastName');
  SetPropertyFromNode(Node, 'CompanyName');
  SetPropertyFromNode(Node, 'Address');
  SetPropertyFromNode(Node, 'DocName');
  SetPropertyFromNode(Node, 'TownCity');
  SetPropertyFromNode(Node, 'PostalZip');
  SetPropertyFromNode(Node, 'StateRegion');
  SetPropertyFromNode(Node, 'Country');
  SetBooleanPropertyFromNode(Node, 'Active');
end;

procedure TReportsAccountantCategory.SaveToXMLNode(Const node: IXMLNode);
begin
    inherited;
    AddXMLNode(node , 'FirstName',    FirstName);
    AddXMLNode(node , 'LastName',     LastName);
    AddXMLNode(node , 'CompanyName',  CompanyName);
    AddXMLNode(node , 'Address',      Address);
    AddXMLNode(node , 'DocName',      DocName);
    AddXMLNode(node , 'TownCity',     TownCity);
    AddXMLNode(Node , 'PostalZip',    PostalZip);
    AddXMLNode(Node , 'StateRegion',  StateRegion);
    AddXMLNode(Node , 'Country',      Country);
    AddXMLNode(Node , 'Active',       Active);
end;

function TReportsAccountantCategory.ValidateData : Boolean;
var
  CleanCodeName: string;
begin
  Result := inherited ValidateData;
  if not Result then Exit;

  Result := False;
  Resultstatus.Clear;

  if Trim(FirstName) = '' then begin
    AddResult(False, rssWarning, 0, 'First name should not be blank');
    Exit;
  end;

  Result := True;
end;

function TReportsAccountantCategory.Save :Boolean ;
begin
    Result := False;
    if not ValidateData then Exit;

    Result := inherited Save;
end;

function TReportsAccountantCategory.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result:= inherited DoAfterInsert(Sender);
  if not Result then Exit;
end;

function TReportsAccountantCategory.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not Result then Exit;
end;

function TReportsAccountantCategory.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not(Result) then Exit;
end;



initialization
  RegisterClassOnce(TReportsAccountant);
  RegisterClassOnce(TReportsAccountantCategory);
end.

