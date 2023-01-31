unit BusObjAssessment;

interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TAssessmentGarage = class(TMSBusObj)
  private
    function GetCompany: string;
    procedure SetCompany(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
  public
    class function GetBusObjectTablename: string; override;
    class function GetIDField: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
  published
    property Company: string read GetCompany write SetCompany;
  end;

  TAssessmentLabels = class(TMSBusObj)
  private 
    function GetLabel: string;
    function GetActive: Boolean;
    function GetOtherOption: Boolean;
    procedure SetLabel(const Value: string);
    procedure SetOtherOption(const Value: Boolean);
    procedure SetActive(const Value: Boolean);
  protected 
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
  public
    class function GetBusObjectTablename: string; override;
    class function GetIDField: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
  published
    property labels: string read getLabel write SetLabel;
    property OtherOption: Boolean read getOtherOption write SetOtherOption;
    property Active: Boolean read getActive write SetActive;
  end;

  TAssessmentTypesDetails = class(TMSBusObj)
  private 
    function GetTypeid: Integer;
    function GetLabelid: Integer;
    function GetLabel: string;
    procedure SetTypeid(const Value: Integer);
    procedure SetLabelid(const Value: Integer);
    procedure SetLabel(const Value: string);
  protected 
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function ValidateXMLData(Const node :IXMLNode) :Boolean ; override;    
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
  public
    class function GetBusObjectTablename: string; override;
    class function GetIDField: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
  published
    property Typeid: Integer read getTypeid write SetTypeid;
    property Labelid: Integer read getLabelid write SetLabelid;
    property labels: string read getLabel write SetLabel;
  end;

  TAssessmentTypesOtherOptionDetails = class(TMSBusObj)
  private
    function GetTypeid: Integer;
    function GetLabelid: Integer;
    function GetLabel: string;
    procedure SetTypeid(const Value: Integer);
    procedure SetLabelid(const Value: Integer);
    procedure SetLabel(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function ValidateXMLData(Const node :IXMLNode) :Boolean ; override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
  public
    class function GetBusObjectTablename: string; override;
    class function GetIDField: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
  published
    property Typeid: Integer read getTypeid write SetTypeid;
    property Labelid: Integer read getLabelid write SetLabelid;
    property Labels: string read getLabel write SetLabel;
  end;

  TAssessmentTypes = class(TMSBusObj)
  private 
    //fLines: TAssessmentTypesDetails;
    //fOtherLines: TAssessmentTypesOtherOptionDetails;
    function GetTypename: string;
    function GetProductID: Integer;
    function GetActive: Boolean;
    function getProductName: String;
    procedure SetProductName(const Value: string);
    procedure SetTypename(const Value: string);
    procedure SetProductId(const Value: Integer);
    procedure SetActive(const Value: Boolean);
    function GetLines: TAssessmentTypesDetails;
    function GetOtherLines: TAssessmentTypesOtherOptionDetails;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean;override;
    function ImportsubClasses(const node: IXMLNode): Boolean; Override;
    function ExportsubClasses(Const node: IXMLNode) :Boolean; Override;
  public
    class function GetBusObjectTablename: string; override;
    class function GetIDField: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
  published
    property TypeName: string read getTypename write SetTypename;
    property ProductName: string read getProductName write SetProductName;
    property ProductID: Integer read GetProductID write SetProductId;
    property Active: Boolean read getActive write SetActive;
    property Lines: TAssessmentTypesDetails read GetLines;
    property OtherLines: TAssessmentTypesOtherOptionDetails read GetOtherLines;
  end;

  TAssessmentWeather = class(TMSBusObj)
  private 
    function GetDescription: string;
    function GetActive: Boolean;
    procedure SetDescription(const Value: string);
    procedure SetActive(const Value: Boolean);
  protected 
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
  public
    class function GetBusObjectTablename: string; override;
    class function GetIDField: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
  published
    property Description: string read getDescription write SetDescription;
    property Active: Boolean read getActive write SetActive;
  end;

  TAssessmentDetails = class(TMSBusObj)
  private
    function GetAssessmentid: Integer;
    function GetLabelid: Integer;
    function GetLabel: string;
    function GetResult: Integer;
    procedure SetAssessmentid(const Value: Integer);
    procedure SetLabelid(const Value: Integer);
    procedure SetLabel(const Value: string);
    procedure SetResult(const Value: Integer);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function ValidateXMLData(Const node :IXMLNode) :Boolean ; override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoBeforePost(Sender :TDatasetBusObj ):Boolean; override;
  public
    class function GetBusObjectTablename: string; override;
    class function GetIDField: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
  published
    property Assessmentid: Integer read getAssessmentid write SetAssessmentid;
    property Labelid: Integer read getLabelid write SetLabelid;
    property labels: string read getLabel write SetLabel;
    property Results: Integer read getResult write SetResult;
  end;

  TAssessmentOtherDetails = class(TMSBusObj)
  private
    function GetAssessmentid: Integer;
    function GetLabelid: Integer;
    function GetLabel: string;
    function GetResult: Boolean;
    procedure SetAssessmentid(const Value: Integer);
    procedure SetLabelid(const Value: Integer);
    procedure SetLabel(const Value: string);
    procedure SetResult(const Value: Boolean);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function ValidateXMLData(Const node :IXMLNode) :Boolean ; override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoBeforePost(Sender :TDatasetBusObj ):Boolean; override;
  public
    class function GetBusObjectTablename: string; override;
    class function GetIDField: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
  published
    property Assessmentid: Integer read getAssessmentid write SetAssessmentid;
    property Labelid: Integer read getLabelid write SetLabelid;
    property labels: string read getLabel write SetLabel;
    property Results: Boolean read getResult write SetResult;
  end;

  TAssessment = class(TMSBusObj)
  private 
    //fLines: TAssessmentDetails;
    //fOtherLines: TAssessmentOtherDetails;
    function GetTypeid: Integer;
    function GetTimeon: string;
    function GetTimeoff: string;
    function GetJourneyfrom: string;
    function GetJourneyto: string;
    function GetBusdestination: string;
    function GetWeathertype: string;
    function GetVehicletype: string;
    function GetFleetnumber: string;
    function GetRunningnumber: string;
    function GetRegnumber: string;
    function GetGarage: string;
    function GetRoute: string;
    function GetCovert: Boolean;
    function GetUniformworn: Boolean;
    function GetAssessmenttoday: Integer;
    function GetDate: TDatetime;
    function GetActive: Boolean;
    function GetConverted: Boolean;
    function GetDriverid: Integer;
    function GetDriver: string;
    function GetAssessorid: Integer;
    function GetAssessor: string;
    procedure SetAssessorid(const Value: Integer);
    procedure SetAssessor(const Value: string);
    procedure SetDriverid(const Value: Integer);
    procedure SetDriver(const Value: string);
    procedure SetTypeid(const Value: Integer);
    procedure SetTimeon(const Value: string);
    procedure SetTimeoff(const Value: string);
    procedure SetJourneyfrom(const Value: string);
    procedure SetJourneyto(const Value: string);
    procedure SetBusdestination(const Value: string);
    procedure SetWeathertype(const Value: string);
    procedure SetVehicletype(const Value: string);
    procedure SetFleetnumber(const Value: string);
    procedure SetRunningnumber(const Value: string);
    procedure SetRegnumber(const Value: string);
    procedure SetGarage(const Value: string);
    procedure SetRoute(const Value: string);
    procedure SetCovert(const Value: Boolean);
    procedure SetUniformworn(const Value: Boolean);
    procedure SetAssessmenttoday(const Value: Integer);
    procedure SetDate(const Value: TDatetime);
    procedure SetActive(const Value: Boolean);
    procedure SetConverted(const Value: Boolean);
    function GetLines: TAssessmentDetails;
    function GetOtherLines: TAssessmentOtherDetails;
    function getAssessmentType: string;
    procedure SetAssessmentType(const Value: string);
    function getNotes: string;
    procedure SetNotes(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function ImportsubClasses(const node: IXMLNode): Boolean; Override;
    function ExportsubClasses(Const node: IXMLNode) :Boolean; Override;
  public
    class function GetBusObjectTablename: string; override;
    class function GetIDField: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
  published    
    property Driverid: Integer read getDriverid write SetDriverid;
    property Driver: string read getDriver write SetDriver;
    property Assessorid: Integer read getAssessorid write SetAssessorid;
    property Assessor: string read getAssessor write SetAssessor;
    property Typeid: Integer read getTypeid write SetTypeid;
    property AssessmentType: string read getAssessmentType write SetAssessmentType;
    property Timeon: string read getTimeon write SetTimeon;
    property Timeoff: string read getTimeoff write SetTimeoff;
    property Journeyfrom: string read getJourneyfrom write SetJourneyfrom;
    property Journeyto: string read getJourneyto write SetJourneyto;
    property Busdestination: string read getBusdestination write SetBusdestination;
    property Weathertype: string read getWeathertype write SetWeathertype;
    property Vehicletype: string read getVehicletype write SetVehicletype;
    property Fleetnumber: string read getFleetnumber write SetFleetnumber;
    property Runningnumber: string read getRunningnumber write SetRunningnumber;
    property Regnumber: string read getRegnumber write SetRegnumber;
    property Garage: string read getGarage write SetGarage;
    property Route: string read getRoute write SetRoute;
    property Covert: Boolean read getCovert write SetCovert;
    property Uniformworn: Boolean read getUniformworn write SetUniformworn;
    property Assessmenttoday: Integer read getAssessmenttoday write SetAssessmenttoday;
    property Date: TDatetime read getDate write SetDate;
    property Active: Boolean read getActive write SetActive;
    property Converted: Boolean read getConverted write SetConverted;
    property Lines: TAssessmentDetails read GetLines;
    property OtherLines: TAssessmentOtherDetails read GetOtherLines;
    property Notes: string read getNotes write SetNotes;
  end;

implementation 

uses FastFuncs,tcDataUtils, SysUtils, CommonLib;
{========================================================Tassessmentlabels ========================================================} 
constructor Tassessmentlabels.Create(AOwner: TComponent);
begin 
  inherited Create(AOwner)
end;

destructor Tassessmentlabels.Destroy;
begin 
  inherited;
end;

procedure Tassessmentlabels.LoadFromXMLNode(const node: IXMLNode);
begin 
  inherited;
    SetPropertyFromNode(Node, 'Label');
    SetBooleanPropertyFromNode(Node, 'OtherOption');
    SetBooleanPropertyFromNode(Node, 'Active');
end;

procedure Tassessmentlabels.SaveToXMLNode(const node: IXMLNode);
begin 
  inherited;
  AddXMLNode(node, 'Label', labels);
  AddXMLNode(node, 'OtherOption', OtherOption);
  AddXMLNode(node, 'Active', Active);
end;

function Tassessmentlabels.ValidateData: Boolean;
begin
  Result := true;
end;

function Tassessmentlabels.Save: Boolean;
begin 
  Result := false;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure Tassessmentlabels.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin 
  inherited;
end;

procedure Tassessmentlabels.DoFieldOnChange(Sender: TField);
begin 
  inherited;
end;

function Tassessmentlabels.GetSQL: string;
begin 
  fSQL :=
    'SELECT * FROM tblassessmentlabels';
  Result := inherited GetSQL;
end;

class function Tassessmentlabels.GetBusObjectTablename: string;
begin
  Result := 'tblassessmentlabels';
end;

class function Tassessmentlabels.GetIDField: string;
begin 
  Result := 'Labelid'
end;

function Tassessmentlabels.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin 
  Result := inherited DoAfterPost(Sender);
end;

{Property functions}

function Tassessmentlabels.GetLabel: string;
begin 
  Result := GetStringField('Label');
end;

function Tassessmentlabels.GetActive: Boolean;
begin
  Result := GetBooleanField('Active');
end;

function Tassessmentlabels.GetOtherOption: Boolean;
begin
  Result := GetBooleanField('OtherOption');
end;

procedure Tassessmentlabels.SetLabel(const Value: string);
begin
  SetStringField('Label', Value);
end;

procedure Tassessmentlabels.SetOtherOption(const Value: Boolean);
begin
  SetBooleanField('OtherOption', Value);
end;

procedure Tassessmentlabels.SetActive(const Value: Boolean);
begin
  SetBooleanField('Label', Value);
end;

{=========== Tassessmentweather =================}
constructor Tassessmentweather.Create(AOwner: TComponent);
begin 
  inherited Create(AOwner)
end;

destructor Tassessmentweather.Destroy;
begin 
  inherited;
end;

procedure Tassessmentweather.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
    SetPropertyFromNode(Node, 'Description');
    SetBooleanPropertyFromNode(Node, 'Active');
end;

procedure Tassessmentweather.SaveToXMLNode(const node: IXMLNode);
begin 
  inherited;
  AddXMLNode(node, 'Description', Description);
  AddXMLNode(node, 'Active', Active);
end;

function Tassessmentweather.ValidateData: Boolean;
begin
  Result := true;
end;

function Tassessmentweather.Save: Boolean;
begin 
  Result := false;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure Tassessmentweather.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin 
  inherited;
end;

procedure Tassessmentweather.DoFieldOnChange(Sender: TField);
begin 
  inherited;
end;

function Tassessmentweather.GetSQL: string;
begin 
  fSQL :=
    'SELECT * FROM tblassessmentweather';
  Result := inherited GetSQL;
end;

class function Tassessmentweather.GetBusObjectTablename: string;
begin
  Result := 'tblassessmentweather';
end;

class function Tassessmentweather.GetIDField: string;
begin 
  Result := 'Weatherid'
end;

function Tassessmentweather.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin 
  Result := inherited DoAfterPost(Sender);
end;

{Property functions}

function Tassessmentweather.GetDescription: string;
begin 
  Result := GetStringField('Description');
end;

function Tassessmentweather.GetActive: Boolean;
begin
  Result := GetBooleanField('Active');
end;

procedure Tassessmentweather.SetDescription(const Value: string);
begin 
  SetStringField('Description', Value);
end;

procedure Tassessmentweather.SetActive(const Value: Boolean);
begin 
  SetBooleanField('Active', Value);
end;

{========================================================          Tassessmenttypes ========================================================}
constructor Tassessmenttypes.Create(AOwner: TComponent);
begin
  inherited Create(AOwner)
end;

destructor Tassessmenttypes.Destroy;
begin 
  inherited;
end;

procedure Tassessmenttypes.LoadFromXMLNode(const node: IXMLNode);
begin 
    SetPropertyFromNode(Node, 'Typename');
    SetPropertyFromNode(Node, 'ProductName');
    SetBooleanPropertyFromNode(Node, 'Active');
  inherited;
end;

procedure Tassessmenttypes.SaveToXMLNode(const node: IXMLNode);
begin 
  inherited;
  AddXMLNode(node, 'Typename', Typename);
  AddXMLNode(node, 'ProductName', ProductName);
  AddXMLNode(node, 'Active', Active);
  ExportsubClasses(node);
end;

function TAssessmentTypes.ImportsubClasses(const node: IXMLNode): Boolean;
var
  x:Integer;
  Singlerec :IXMLNode;
begin
  Result := False;
  ImportFailed := False;
  XMLPropertyName :='lines';
  XMLPropertyNode := node.ChildNodes.FindNode(XMLPropertyName);
  if Assigned(XMLPropertyNode) then begin
      for x := 0 to XMLPropertyNode.ChildNodes.Count - 1 do begin
          Lines.ImportingFromXMLFile := True;
          Singlerec:= XMLPropertyNode.ChildNodes[x];
          Lines.ImportFromXML(SingleRec);
          ImportFailed :=Lines.ImportFailed;
          if Error then Exit;
      end;
  end;
  XMLPropertyName :='OtherLines';
  XMLPropertyNode := node.ChildNodes.FindNode(XMLPropertyName);
  if Assigned(XMLPropertyNode) then begin
      for x := 0 to XMLPropertyNode.ChildNodes.Count - 1 do begin
          OtherLines.ImportingFromXMLFile := True;
          Singlerec:= XMLPropertyNode.ChildNodes[x];
          OtherLines.ImportFromXML(SingleRec);
          ImportFailed :=Lines.ImportFailed;
          if Error then Exit;
      end;
  end;
  ImportFailed := False;
  Result := True;
end;


function Tassessmenttypes.ValidateData: Boolean;
begin
  Result := true;
end;

function Tassessmenttypes.Save: Boolean;
begin 
  Result := false;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure Tassessmenttypes.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin 
  inherited;
end;

procedure Tassessmenttypes.DoFieldOnChange(Sender: TField);
begin 
  inherited;
end;

function Tassessmenttypes.GetSQL: string;
begin 
  fSQL := 'SELECT * FROM tblassessmenttypes';
  Result := inherited GetSQL;
end;

class function Tassessmenttypes.GetBusObjectTablename: string;
begin
  Result := 'tblassessmenttypes';
end;

class function Tassessmenttypes.GetIDField: string;
begin 
  Result := 'Typeid'
end;

function Tassessmenttypes.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin 
  Result := inherited DoAfterPost(Sender);
end;

{Property functions} 

function Tassessmenttypes.GetTypename: string;
begin 
  Result := GetStringField('Typename');
end;

function Tassessmenttypes.GetProductID: Integer;
begin 
  Result := GetIntegerField('Productid');
end;

function Tassessmenttypes.GetActive: Boolean;
begin 
  Result := GetBooleanField('Active');
end;

procedure Tassessmenttypes.SetTypename(const Value: string);
begin
  SetStringField('Typename', Value);
end;

procedure Tassessmenttypes.SetProductId(const Value: Integer);
begin
  SetIntegerField('Productid', Value);
end;

procedure Tassessmenttypes.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

{============= TAssessmentTypesDetails ===========================}
constructor Tassessmenttypesdetails.Create(AOwner: TComponent);
begin
  inherited Create(AOwner)
end;

destructor Tassessmenttypesdetails.Destroy;
begin
  inherited;
end;

procedure Tassessmenttypesdetails.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  If Assigned(Self.owner) then
    If Self.owner is TAssessmentTypes then
      Typeid := TAssessmentTypes(Self.owner).id;

    SetPropertyFromNode(Node, 'Label');
end;

procedure Tassessmenttypesdetails.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'TypeId', TypeId);
  AddXMLNode(node, 'Label', labels);
end;

function Tassessmenttypesdetails.ValidateData: Boolean;
begin
  Result := false;

  if Typeid = 0 then begin
    ResultStatus.AddItem(false, rssWarning, 0,'Assessment Type Unknown');
    exit;
  end;

  if Labelid = 0 then begin
    ResultStatus.AddItem(false, rssWarning, 0,'Label Unknown');
    exit;
  end;

  Result := true;
end;

function Tassessmenttypesdetails.Save: Boolean;
begin 
  Result := false;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure Tassessmenttypesdetails.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure Tassessmenttypesdetails.DoFieldOnChange(Sender: TField);
begin 
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.

  if Sysutils.SameText(Sender.FieldName , 'Label') then begin
    LabelId := getAssessmentLabelId(Self.Labels);
  end;
  inherited;
end;

function Tassessmenttypesdetails.GetSQL: string;
begin 
  fSQL := 'SELECT * FROM tblassessmenttypesdetails';
  Result := inherited GetSQL;
end;

class function Tassessmenttypesdetails.GetBusObjectTablename: string;
begin
  Result := 'tblassessmenttypesdetails';
end;

class function Tassessmenttypesdetails.GetIDField: string;
begin 
  Result := 'Typedetailsid'
end;

function Tassessmenttypesdetails.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{Property functions}

function Tassessmenttypesdetails.GetTypeid: Integer;
begin
  Result := GetIntegerField('Typeid');
end;

function Tassessmenttypesdetails.GetLabelid: Integer;
begin
  Result := GetIntegerField('Labelid');
end;

function Tassessmenttypesdetails.GetLabel: string;
begin
  Result := GetStringField('Label');
end;

procedure Tassessmenttypesdetails.SetTypeid(const Value: Integer);
begin
  SetIntegerField('Typeid', Value);
end;

procedure Tassessmenttypesdetails.SetLabelid(const Value: Integer);
begin
  SetIntegerField('Labelid', Value);
end;

procedure Tassessmenttypesdetails.SetLabel(const Value: string);
begin
  SetStringField('Label', Value);
end;


{============= TAssessmentTypesOtherOptionDetails ===========================}
constructor TAssessmentTypesOtherOptionDetails.Create(AOwner: TComponent);
begin
  inherited Create(AOwner)
end;

destructor TAssessmentTypesOtherOptionDetails.Destroy;
begin
  inherited;
end;

procedure TAssessmentTypesOtherOptionDetails.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  If Assigned(Self.owner) then
    If Self.owner is TAssessmentTypes then
      Typeid := TAssessmentTypes(Self.owner).id;

    SetPropertyFromNode(Node, 'Label');
end;

procedure TAssessmentTypesOtherOptionDetails.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'TypeId', TypeId);  
  AddXMLNode(node, 'Label', labels);
end;

function TAssessmentTypesOtherOptionDetails.ValidateData: Boolean;
begin
  Result := false;

  if Typeid = 0 then begin
    ResultStatus.AddItem(false, rssWarning, 0,'Assessment Type Unknown');
    exit;
  end;

  if Labelid = 0 then begin
    ResultStatus.AddItem(false, rssWarning, 0,'Label Unknown');
    exit;
  end;

  Result := true;
end;

function TAssessmentTypesOtherOptionDetails.Save: Boolean;
begin 
  Result := false;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TAssessmentTypesOtherOptionDetails.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TAssessmentTypesOtherOptionDetails.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.

  if Sysutils.SameText(Sender.FieldName , 'Label') then begin
    LabelId := getAssessmentLabelId(Self.Labels);
  end;
  inherited;
end;

function TAssessmentTypesOtherOptionDetails.GetSQL: string;
begin 
  fSQL := 'SELECT * FROM tblassessmenttypesotherdetails';
  Result := inherited GetSQL;
end;

class function TAssessmentTypesOtherOptionDetails.GetBusObjectTablename: string;
begin
  Result := 'tblassessmenttypesotherdetails';
end;

class function TAssessmentTypesOtherOptionDetails.GetIDField: string;
begin 
  Result := 'TypeOtherDetailsID'
end;

function TAssessmentTypesOtherOptionDetails.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{Property functions}

function TAssessmentTypesOtherOptionDetails.GetTypeid: Integer;
begin
  Result := GetIntegerField('Typeid');
end;

function TAssessmentTypesOtherOptionDetails.GetLabelid: Integer;
begin
  Result := GetIntegerField('Labelid');
end;

function TAssessmentTypesOtherOptionDetails.GetLabel: string;
begin
  Result := GetStringField('Label');
end;

procedure TAssessmentTypesOtherOptionDetails.SetTypeid(const Value: Integer);
begin
  SetIntegerField('Typeid', Value);
end;

procedure TAssessmentTypesOtherOptionDetails.SetLabelid(const Value: Integer);
begin
  SetIntegerField('Labelid', Value);
end;

procedure TAssessmentTypesOtherOptionDetails.SetLabel(const Value: string);
begin
  SetStringField('Label', Value);
end;

{========== TAssessment ==============}

constructor TAssessment.Create(AOwner: TComponent);
begin
  inherited Create(AOwner)
end;

destructor TAssessment.Destroy;
begin 
  inherited;
end;

procedure TAssessment.LoadFromXMLNode(const node: IXMLNode);
begin
    SetPropertyFromNode(Node, 'Assessor');
    SetPropertyFromNode(Node, 'Garage');
    SetPropertyFromNode(Node, 'Driver');
    SetPropertyFromNode(Node, 'AssessmentType');
    SetPropertyFromNode(Node, 'Timeon');
    SetPropertyFromNode(Node, 'Timeoff');
    SetPropertyFromNode(Node, 'Journeyfrom');
    SetPropertyFromNode(Node, 'Journeyto');
    SetPropertyFromNode(Node, 'Busdestination');
    SetPropertyFromNode(Node, 'Weathertype');
    SetPropertyFromNode(Node, 'Vehicletype');
    SetPropertyFromNode(Node, 'Fleetnumber');
    SetPropertyFromNode(Node, 'Runningnumber');
    SetPropertyFromNode(Node, 'Regnumber');
    SetPropertyFromNode(Node, 'Route');
    SetBooleanPropertyFromNode(Node, 'Covert');
    SetBooleanPropertyFromNode(Node, 'Uniformworn');
    SetPropertyFromNode(Node, 'Assessmenttoday');
    SetDateTimePropertyFromNode(Node, 'Date');
    SetPropertyFromNode(Node, 'Notes');
    SetBooleanPropertyFromNode(Node, 'Active');
    SetBooleanPropertyFromNode(Node, 'Converted');
  inherited;
end;

procedure TAssessment.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  if not SavingXMLTofile then begin
    AddXMLNode(node, 'Typeid', Typeid);
    AddXMLNode(node, 'Assessorid', Assessorid);
    AddXMLNode(node, 'Garage', Garage);
    AddXMLNode(node, 'Driverid', Driverid);
  end else begin
    AddXMLNode(node , 'AssessmentType', AssessmentType);
    AddXMLNode(node , 'Assessor', Assessor);
    AddXMLNode(node, 'Garage', Garage);
    AddXMLNode(node , 'Driver', Driver);
  end;
  AddXMLNode(node, 'Timeon', Timeon);
  AddXMLNode(node, 'Timeoff', Timeoff);
  AddXMLNode(node, 'Journeyfrom', Journeyfrom);
  AddXMLNode(node, 'Journeyto', Journeyto);
  AddXMLNode(node, 'Busdestination', Busdestination);
  AddXMLNode(node, 'Weathertype', Weathertype);
  AddXMLNode(node, 'Vehicletype', Vehicletype);
  AddXMLNode(node, 'Fleetnumber', Fleetnumber);
  AddXMLNode(node, 'Runningnumber', Runningnumber);
  AddXMLNode(node, 'Regnumber', Regnumber);
  AddXMLNode(node, 'Route', Route);
  AddXMLNode(node, 'Covert', Covert);
  AddXMLNode(node, 'Uniformworn', Uniformworn);
  AddXMLNode(node, 'Assessmenttoday', Assessmenttoday);
  AddXMLNode(node, 'Date', Date);
  AddXMLNode(node, 'Notes', Notes);
  AddXMLNode(node, 'Active', Active);
  AddXMLNode(node, 'Converted', Converted);
  ExportsubClasses(node);
end;



function TAssessment.ImportsubClasses(const node: IXMLNode): Boolean;
var
  x:Integer;
  Singlerec :IXMLNode;
begin
  Result := False;
  ImportFailed := False;
  XMLPropertyName :='lines';
  XMLPropertyNode := node.ChildNodes.FindNode(XMLPropertyName);
  if Assigned(XMLPropertyNode) then begin
      for x := 0 to XMLPropertyNode.ChildNodes.Count - 1 do begin
          Lines.ImportingFromXMLFile := True;
          Singlerec:= XMLPropertyNode.ChildNodes[x];
          Lines.ImportFromXML(SingleRec);
          ImportFailed :=Lines.ImportFailed;
          if Error then Exit;
      end;
  end;
  XMLPropertyName :='OtherLines';
  XMLPropertyNode := node.ChildNodes.FindNode(XMLPropertyName);
  if Assigned(XMLPropertyNode) then begin
      for x := 0 to XMLPropertyNode.ChildNodes.Count - 1 do begin
          OtherLines.ImportingFromXMLFile := True;
          Singlerec:= XMLPropertyNode.ChildNodes[x];
          OtherLines.ImportFromXML(SingleRec);
          ImportFailed :=Lines.ImportFailed;
          if Error then Exit;
      end;
  end;  
  ImportFailed := False;
  Result := True;
end;

function TAssessment.ValidateData: Boolean;
begin
  Result := false;

  if (Typeid = 0) AND not (AssessmentType<>'') then begin
    ResultStatus.AddItem(false, rssWarning, 0,'Assessment Type Unknown');
    exit;
  end;

  if (Assessorid = 0) AND not (Assessor<>'')  then begin
    ResultStatus.AddItem(false, rssWarning, 0,'Assessor Unknown');
    exit;
  end;

  if (Driverid = 0) AND not (Driver<>'') then begin
    ResultStatus.AddItem(false, rssWarning, 0,'Driver Unknown');
  end;

  Result := true;
end;

function TAssessment.Save: Boolean;
begin 
  Result := false;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TAssessment.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin 
  inherited;
end;

procedure TAssessment.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.

  if Sysutils.SameText(Sender.FieldName , 'Driver') then begin
    Driverid := getAssessmentDriverid(Driver,getclientID(Garage));
  end;

  if Sysutils.SameText(Sender.FieldName , 'Assessor') then begin
    Assessorid := getAssessmentAssessorid(Assessor);
  end;

  if Sysutils.SameText(Sender.FieldName , 'AssessmentType') then begin
    Typeid := getAssessmentTypeid(AssessmentType);
  end;

  inherited;

end;

function TAssessment.GetSQL: string;
begin
  fSQL := 'SELECT * FROM tblassessments';
  Result := inherited GetSQL;
end;

class function TAssessment.GetBusObjectTablename: string;
begin
  Result := 'tblassessments';
end;

class function TAssessment.GetIDField: string;
begin
  Result := 'Assessmentid'
end;

function TAssessment.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin 
  Result := inherited DoAfterPost(Sender);
end;

{Property functions}

function TAssessment.GetAssessorid: Integer;
begin
  Result := GetIntegerField('Assessorid');
end;

function TAssessment.GetDriverid: Integer;
begin
  Result := GetIntegerField('Driverid');
end;

function TAssessment.GetTypeid: Integer;
begin 
  Result := GetIntegerField('Typeid');
end;

function TAssessment.GetTimeon: string;
begin 
  Result := GetStringField('Timeon');
end;

function TAssessment.GetTimeoff: string;
begin 
  Result := GetStringField('Timeoff');
end;

function TAssessment.GetJourneyfrom: string;
begin 
  Result := GetStringField('Journeyfrom');
end;

function TAssessment.GetJourneyto: string;
begin 
  Result := GetStringField('Journeyto');
end;

function TAssessment.GetBusdestination: string;
begin 
  Result := GetStringField('Busdestination');
end;

function TAssessment.GetWeathertype: string;
begin 
  Result := GetStringField('Weathertype');
end;

function TAssessment.GetVehicletype: string;
begin 
  Result := GetStringField('Vehicletype');
end;

function TAssessment.GetFleetnumber: string;
begin 
  Result := GetStringField('Fleetnumber');
end;

function TAssessment.GetRunningnumber: string;
begin 
  Result := GetStringField('Runningnumber');
end;

function TAssessment.GetRegnumber: string;
begin 
  Result :=
    GetStringField('Regnumber');
end;

function TAssessment.GetGarage: string;
begin 
  Result := GetStringField('Garage');
end;

function TAssessment.GetRoute: string;
begin 
  Result := GetStringField('Route');
end;

function TAssessment.GetCovert: Boolean;
begin 
  Result :=
    GetBooleanField('Covert');
end;

function TAssessment.GetUniformworn: Boolean;
begin 
  Result := GetBooleanField('Uniformworn');
end;

function TAssessment.GetAssessmenttoday: Integer;
begin 
  Result := GetIntegerField('Assessmenttoday');
end;

function TAssessment.GetDate: TDatetime;
begin 
  Result := GetDatetimeField('Date');
end;

function TAssessment.GetActive: Boolean;
begin 
  Result := GetBooleanField('Active');
end;

function TAssessment.GetConverted: Boolean;
begin 
  Result := GetBooleanField('Converted');
end;

procedure TAssessment.SetAssessorid(const Value: Integer);
begin
  SetIntegerField('Assessorid', Value);
end;

procedure TAssessment.SetDriverid(const Value: Integer);
begin
  SetIntegerField('Driverid', Value);
end;

procedure TAssessment.SetTypeid(const Value: Integer);
begin 
  SetIntegerField('Typeid', Value);
end;

procedure TAssessment.SetTimeon(const Value: string);
begin 
  SetStringField('Timeon', Value);
end;

procedure TAssessment.SetTimeoff(const Value: string);
begin 
  SetStringField('Timeoff', Value);
end;

procedure TAssessment.SetJourneyfrom(const Value: string);
begin 
  SetStringField('Journeyfrom', Value);
end;

procedure TAssessment.SetJourneyto(const Value: string);
begin 
  SetStringField('Journeyto', Value);
end;

procedure TAssessment.SetBusdestination(const Value: string);
begin 
  SetStringField('Busdestination', Value);
end;

procedure TAssessment.SetWeathertype(const Value: string);
begin 
  SetStringField('Weathertype', Value);
end;

procedure TAssessment.SetVehicletype(const Value: string);
begin 
  SetStringField('Vehicletype', Value);
end;

procedure TAssessment.SetFleetnumber(const Value: string);
begin 
  SetStringField('Fleetnumber', Value);
end;

procedure TAssessment.SetRunningnumber(const Value: string);
begin 
  SetStringField('Runningnumber', Value);
end;

procedure TAssessment.SetRegnumber(const Value: string);
begin 
  SetStringField('Regnumber', Value);
end;

procedure TAssessment.SetGarage(const Value: string);
begin 
  SetStringField('Garage', Value);
end;

procedure TAssessment.SetRoute(const Value: string);
begin 
  SetStringField('Route', Value);
end;

procedure TAssessment.SetCovert(const Value: Boolean);
begin 
  SetBooleanField('Covert', Value);
end;

procedure TAssessment.SetUniformworn(const Value: Boolean);
begin 
  SetBooleanField('Uniformworn', Value);
end;

procedure TAssessment.SetAssessmenttoday(const Value: Integer);
begin 
  SetIntegerField('Assessmenttoday', Value);
end;

procedure TAssessment.SetDate(const Value: TDatetime);
begin 
  SetDatetimeField('Date', Value);
end;

procedure TAssessment.SetActive(const Value: Boolean);
begin 
  SetBooleanField('Active', Value);
end;

procedure TAssessment.SetConverted(const Value: Boolean);
begin 
  SetBooleanField('Converted', Value);
end;

{========== TAssessmentOtherDetails ===================}

constructor TAssessmentotherdetails.Create(AOwner: TComponent);
begin 
  inherited Create(AOwner)
end;

destructor TAssessmentotherdetails.Destroy;
begin
  inherited;
end;

procedure TAssessmentotherdetails.LoadFromXMLNode(const node: IXMLNode);
begin 
  inherited;
  If Assigned(Self.owner) then
    If Self.owner is TAssessment then
      Assessmentid := TAssessment(Self.owner).id;
    SetPropertyFromNode(Node, 'Label');
    SetBooleanPropertyFromNode(Node, 'Result');
end;

procedure TAssessmentotherdetails.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  if not SavingXMLTofile then begin
    AddXMLNode(node, 'AssessmentID', Assessmentid);
    AddXMLNode(node, 'Labelid', Labelid);
  end;
  AddXMLNode(node, 'Label', labels);
  AddXMLNode(node, 'Result', Results);
end;

function TAssessmentotherdetails.ValidateData: Boolean;
begin
  Result := false;

  if Labelid = 0 then begin
    ResultStatus.AddItem(false, rssWarning, 0,'Label Unknown');
    exit;
  end;

  Result := true;
end;

function TAssessmentotherdetails.Save: Boolean;
begin 
  Result := false;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TAssessmentotherdetails.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TAssessmentotherdetails.DoFieldOnChange(Sender: TField);
begin 
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.

  if Sysutils.SameText(Sender.FieldName , 'Label') then begin
    LabelId := getAssessmentLabelId(Self.Labels);
  end;
  inherited;
end;

function TAssessmentotherdetails.GetSQL: string;
begin 
  fSQL := 'SELECT * FROM tblassessmentsotherdetails';
  Result := inherited GetSQL;
end;

class function TAssessmentotherdetails.GetBusObjectTablename: string;
begin
  Result := 'tblassessmentsotherdetails';
end;

class function TAssessmentotherdetails.GetIDField: string;
begin
  Result := 'AssessmentotherDetailsID'
end;

function TAssessmentotherdetails.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
{Property functions}

function TAssessmentotherdetails.GetAssessmentid: Integer;
begin 
  Result := GetIntegerField('Assessmentid');
end;

function TAssessmentotherdetails.GetLabelid: Integer;
begin 
  Result := GetIntegerField('Labelid');
end;

function TAssessmentotherdetails.GetLabel: string;
begin 
  Result := GetStringField('Label');
end;

function TAssessmentotherdetails.GetResult: Boolean;
begin
  Result := GetBooleanField('Result');
end;

procedure TAssessmentotherdetails.SetAssessmentid(const Value: Integer);
begin 
  SetIntegerField('AssessmentID', Value);
end;

procedure TAssessmentotherdetails.SetLabelid(const Value: Integer);
begin
  SetIntegerField('Labelid', Value);
end;

procedure TAssessmentotherdetails.SetLabel(const Value: string);
var
  AssessmentLabel: TAssessmentLabels;
begin
  AssessmentLabel := TAssessmentLabels.Create(nil);
  Try
    AssessmentLabel.LoadSelect('Label = ' + QuotedStr(Value));
    SetIntegerField('LabelId', AssessmentLabel.ID);
    SetStringField('Label', Value);
  finally
    FreeAndNil(AssessmentLabel);
  end;
end;

procedure TAssessmentotherdetails.SetResult(const Value: Boolean);
begin
  SetBooleanField('Result', Value);
end;

function TAssessmentotherdetails.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  if Assigned(Self.Owner) then
    if Self.Owner is TAssessment then Begin
      if (TAssessment(Self.Owner).Dataset.State in [dsInsert]) then Begin
        TAssessment(Self.Owner).Dataset.Post;
        TAssessment(Self.Owner).Dataset.Edit;
      end;
      Self.Assessmentid := TAssessment(Self.Owner).ID;
    end;
  Result := True;
end;

{========== TAssessmentDetails ===================}

constructor TAssessmentdetails.Create(AOwner: TComponent);
begin 
  inherited Create(AOwner)
end;

destructor TAssessmentdetails.Destroy;
begin
  inherited;
end;

procedure TAssessmentdetails.LoadFromXMLNode(const node: IXMLNode);
begin 
  inherited;
  If Assigned(Self.owner) then
    If Self.owner is TAssessment then
      Assessmentid := TAssessment(Self.owner).id;
    SetPropertyFromNode(Node, 'Label');
    SetPropertyFromNode(Node, 'Result');
end;

procedure TAssessmentdetails.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  if not SavingXMLTofile then begin
    AddXMLNode(node, 'AssessmentID', Assessmentid);
    AddXMLNode(node, 'Labelid', Labelid);
  end;
  AddXMLNode(node, 'Label', labels);
  AddXMLNode(node, 'Result', Results);
end;

function TAssessmentdetails.ValidateData: Boolean;
begin
  Result := false;

  if Labelid = 0 then begin
    ResultStatus.AddItem(false, rssWarning, 0,'Label Unknown');
    exit;
  end;

  Result := true;
end;

function TAssessmentdetails.Save: Boolean;
begin 
  Result := false;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TAssessmentdetails.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TAssessmentdetails.DoFieldOnChange(Sender: TField);
begin 
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.

  if Sysutils.SameText(Sender.FieldName , 'Label') then begin
    LabelId := getAssessmentLabelId(Self.Labels);
  end;
  inherited;
end;

function TAssessmentdetails.GetSQL: string;
begin 
  fSQL := 'SELECT * FROM tblassessmentsdetails';
  Result := inherited GetSQL;
end;

class function TAssessmentdetails.GetBusObjectTablename: string;
begin
  Result := 'tblassessmentsdetails';
end;

class function TAssessmentdetails.GetIDField: string;
begin
  Result := 'Assessmentdetailsid'
end;

function TAssessmentdetails.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
{Property functions}

function TAssessmentdetails.GetAssessmentid: Integer;
begin 
  Result := GetIntegerField('Assessmentid');
end;

function TAssessmentdetails.GetLabelid: Integer;
begin 
  Result := GetIntegerField('Labelid');
end;

function TAssessmentdetails.GetLabel: string;
begin 
  Result := GetStringField('Label');
end;

function TAssessmentdetails.GetResult: Integer;
begin
  Result := GetIntegerField('Result');
end;

procedure TAssessmentdetails.SetAssessmentid(const Value: Integer);
begin 
  SetIntegerField('AssessmentID', Value);
end;

procedure TAssessmentdetails.SetLabelid(const Value: Integer);
begin
  SetIntegerField('Labelid', Value);
end;

procedure TAssessmentdetails.SetLabel(const Value: string);
var
  AssessmentLabel: TAssessmentLabels;
begin
  AssessmentLabel := TAssessmentLabels.Create(nil);
  Try
    AssessmentLabel.LoadSelect('Label = ' + QuotedStr(Value));
    SetIntegerField('LabelId', AssessmentLabel.ID);
    SetStringField('Label', Value);
  finally
    FreeAndNil(AssessmentLabel);
  end;
end;

procedure TAssessmentdetails.SetResult(const Value: Integer);
begin
  SetIntegerField('Result', Value);
end;

function TAssessmentTypes.GetOtherLines: TAssessmentTypesOtherOptionDetails;
begin 
  (*if not Assigned(fOtherLines) then begin
    fOtherLines := TAssessmentTypesOtherOptionDetails.Create(self);
    if Assigned(Self.Connection) then fOtherLines.connection := Self.connection;
  end;
  if (fOtherLines.SQLSelect <> 'Typeid = ' + FastFuncs.IntToStr(Self.Id)) or (fLines.Dataset.Active = false) then begin
    fOtherLines.LoadSelect('Typeid = ' + FastFuncs.IntToStr(Self.Id));
  end;
  Result := fOtherLines;*)
    result := TAssessmentTypesOtherOptionDetails(Getcontainercomponent(TAssessmentTypesOtherOptionDetails ,
                    'Typeid = ' + FastFuncs.IntToStr(Self.Id)));
end;

function TAssessmentTypes.GetLines: TAssessmentTypesDetails;
begin
(*  if not Assigned(fLines) then begin
    fLines := TAssessmentTypesDetails.Create(self);
    if Assigned(Self.Connection) then fLines.connection :=
        Self.connection;
  end;
  if (fLines.SQLSelect <> 'Typeid = ' + FastFuncs.IntToStr(Self.Id)) or (fLines.Dataset.Active = false) then begin
    fLines.LoadSelect('Typeid = ' + FastFuncs.IntToStr(Self.Id));
  end;
  Result := fLines;*)
  result := TAssessmentTypesDetails(Getcontainercomponent(TAssessmentTypesDetails ,'Typeid = ' + FastFuncs.IntToStr(Self.Id)));
end;

function TAssessment.GetLines: TAssessmentDetails;
begin 
  (*if not Assigned(fLines) then begin
    fLines := TAssessmentDetails.Create(self);
    if Assigned(Self.Connection) then fLines.connection := Self.connection;
  end;
  if (fLines.SQLSelect <> 'AssessmentID = ' + FastFuncs.IntToStr(Self.Id)) or (fLines.Dataset.Active = false) then begin
    fLines.LoadSelect('AssessmentID = ' + FastFuncs.IntToStr(Self.Id));
  end;
  Result := fLines;*)
  result := TAssessmentDetails(Getcontainercomponent(TAssessmentDetails ,'AssessmentID = ' + FastFuncs.IntToStr(Self.Id)));
end;

function TAssessment.GetOtherLines: TAssessmentOtherDetails;
begin
  (*if not Assigned(fOtherLines) then begin
    fOtherLines := TAssessmentOtherDetails.Create(self);
    if Assigned(Self.Connection) then fOtherLines.connection := Self.connection;
  end;
  if (fOtherLines.SQLSelect <> 'AssessmentID = ' + FastFuncs.IntToStr(Self.Id)) or (fOtherLines.Dataset.Active = false) then begin
    fOtherLines.LoadSelect('AssessmentID = ' + FastFuncs.IntToStr(Self.Id));
  end;
  Result := fOtherLines;*)
  result := TAssessmentOtherDetails(Getcontainercomponent(TAssessmentOtherDetails ,'AssessmentID = ' + FastFuncs.IntToStr(Self.Id)));
end;


function TAssessment.GetAssessor: string;
begin
  Result := GetEmployeeName(GetIntegerField('Assessorid'));
end;

procedure TAssessment.SetAssessor(const Value: string);
begin
  SetIntegerField('Assessorid', GetEmployeeID(Value));
end;

function TAssessment.GetDriver: string;
begin
  Result := getAssessmentDriver(GetIntegerField('Driverid'),getclientID(Garage));
end;

procedure TAssessment.SetDriver(const Value: string);
begin
  SetIntegerField('Driverid', getAssessmentDriverid(Value,getclientID(Garage)));
end;

function TAssessment.ExportsubClasses(const node: IXMLNode): Boolean;
begin
  Self.Lines.XMLPropertyNode := node.AddChild('lines');
  Self.Lines.XMLPropertyName:= Self.Lines.XMLNodeName+'Line';
  Self.Lines.IterateRecords(GetPropertyXMLCallback);
  Self.OtherLines.XMLPropertyNode := node.AddChild('OtherLines');
  Self.OtherLines.XMLPropertyName:= Self.OtherLines.XMLNodeName+'Line';
  Self.OtherLines.IterateRecords(GetPropertyXMLCallback);
  Result := True;
end;

function TAssessment.getAssessmentType: string;
var
  AssessmentType: TAssessmentTypes;
begin
  AssessmentType := TAssessmentTypes.Create(self);
  Try
    AssessmentType.LoadSelect('Typeid = ' + FastFuncs.IntToStr( GetIntegerField('Typeid')));
    Result := AssessmentType.TypeName;
  finally
    FreeAndNil(AssessmentType);
  end;
end;

procedure TAssessment.SetAssessmentType(const Value: string);
var
  AssessmentType: TAssessmentTypes;
begin
  AssessmentType := TAssessmentTypes.Create(self);
  Try
    AssessmentType.LoadSelect('TypeName = ' + QuotedStr(Value));
    SetIntegerField('Typeid', AssessmentType.Id);
  finally
    FreeAndNil(AssessmentType);
  end;
end;

function TAssessmentDetails.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  if Assigned(Self.Owner) then
    if Self.Owner is TAssessment then Begin
      if (TAssessment(Self.Owner).Dataset.State in [dsInsert]) then Begin
        TAssessment(Self.Owner).Dataset.Post;
        TAssessment(Self.Owner).Dataset.Edit;
      end;
      Self.Assessmentid := TAssessment(Self.Owner).ID;
    end;
  Result := True;
end;

{========== TAssessmentGarage ===================}
constructor TAssessmentGarage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner)
end;

destructor TAssessmentGarage.Destroy;
begin
  inherited;
end;

procedure TAssessmentGarage.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
    SetPropertyFromNode(Node, 'Company');
end;

procedure TAssessmentGarage.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'Company', Company);
end;

function TAssessmentGarage.ValidateData: Boolean;
begin

  Result := true;
end;

function TAssessmentGarage.Save: Boolean;
begin 
  Result := false;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TAssessmentGarage.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin 
  inherited;
end;

procedure TAssessmentGarage.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TAssessmentGarage.GetSQL: string;
begin
  fSQL := 'SELECT * FROM tblclients WHERE Customer="T" AND Active="T"';
  Result := inherited GetSQL;
end;

class function TAssessmentGarage.GetBusObjectTablename: string;
begin
  Result := 'tblclients';
end;

class function TAssessmentGarage.GetIDField: string;
begin
  Result := 'Clientid'
end;

function TAssessmentGarage.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin 
  Result := inherited DoAfterPost(Sender);
end;

function TAssessmentGarage.GetCompany: string;
begin
  Result := GetStringField('Company');
end;


procedure TAssessmentGarage.SetCompany(const Value: string);
begin
  SetStringField('Company', Value);
end;

function TAssessmentTypes.ExportsubClasses(const node: IXMLNode): Boolean;
begin
  Self.Lines.XMLPropertyNode := node.AddChild('lines');
  Self.Lines.XMLPropertyName:= Self.Lines.XMLNodeName+'Line';
  Self.Lines.IterateRecords(GetPropertyXMLCallback);

  Self.OtherLines.XMLPropertyNode := node.AddChild('OtherLines');
  Self.OtherLines.XMLPropertyName:= Self.OtherLines.XMLNodeName+'Line';
  Self.OtherLines.IterateRecords(GetPropertyXMLCallback);
  Result := True;
end;


function TAssessmentTypesOtherOptionDetails.ValidateXMLData(const node: IXMLNode): Boolean;
begin
  Result := inherited ValidateXMLData(node);
  if not Result then Exit;
  if not ImportingFromXMLFile then Exit;
  Result := False;
  {Foreign key validation}
  XMLSearchRecordDesc := 'Label ='  + quotedstr(GetXMLNodeStringValue(Node, 'Label'));  
  if GetXMLNodeStringValue(Node, 'Label')<>'' then begin
    If getAssessmentLabelId(GetXMLNodeStringValue(Node, 'Label'))=0 then begin
      ErrRecordNotfound('Label' , GetXMLNodeStringValue(Node, 'Label'));
      Exit;
    end;
  end;
  Result := true;
end;

function TAssessmentTypes.getProductName: String;
begin
  Result := GetProduct(GetIntegerField('Productid'));
end;

procedure TAssessmentTypes.SetProductName(const Value: string);
begin
  SetIntegerField('Productid', GetProduct(Value));
end;

function TAssessmentTypesDetails.ValidateXMLData(const node: IXMLNode): Boolean;
begin
  Result := inherited ValidateXMLData(node);
  if not Result then Exit;
  if not ImportingFromXMLFile then Exit;
  Result := False;
  {Foreign key validation}
  XMLSearchRecordDesc := 'Label ='  + quotedstr(GetXMLNodeStringValue(Node, 'Label'));
  if GetXMLNodeStringValue(Node, 'Label')<>'' then begin
    If getAssessmentLabelId(GetXMLNodeStringValue(Node, 'Label'))=0 then begin
      ErrRecordNotfound('Label' , GetXMLNodeStringValue(Node, 'Label'));
      Exit;
    end;
  end;
  Result := true;
end;

function TAssessmentDetails.ValidateXMLData(const node: IXMLNode): Boolean;
begin
  Result := inherited ValidateXMLData(node);
  if not Result then Exit;
  if not ImportingFromXMLFile then Exit;
  Result := False;
  {Foreign key validation}
  XMLSearchRecordDesc := 'Label ='  + quotedstr(GetXMLNodeStringValue(Node, 'Label'));
  if GetXMLNodeStringValue(Node, 'Label')<>'' then begin
    If getAssessmentLabelId(GetXMLNodeStringValue(Node, 'Label'))=0 then begin
      ErrRecordNotfound('Label' , GetXMLNodeStringValue(Node, 'Label'));
      Exit;
    end;
  end;
  Result := true;
end;

function TAssessmentOtherDetails.ValidateXMLData( const node: IXMLNode): Boolean;
begin
  Result := inherited ValidateXMLData(node);
  if not Result then Exit;
  if not ImportingFromXMLFile then Exit;
  Result := False;
  {Foreign key validation}
  XMLSearchRecordDesc := 'Label ='  + quotedstr(GetXMLNodeStringValue(Node, 'Label'));
  if GetXMLNodeStringValue(Node, 'Label')<>'' then begin
    If getAssessmentLabelId(GetXMLNodeStringValue(Node, 'Label'))=0 then begin
      ErrRecordNotfound('Label' , GetXMLNodeStringValue(Node, 'Label'));
      Exit;
    end;
  end;
  Result := true;
end;

function TAssessment.getNotes: string;
begin
  Result := GetStringField('Notes');
end;

procedure TAssessment.SetNotes(const Value: string);
begin
  SetStringField('Notes', Value);
end;

initialization
  RegisterClassOnce(TAssessmentLabels);
  RegisterClassOnce(TAssessmentWeather);
  RegisterClassOnce(TAssessmentTypes);
  RegisterClassOnce(TAssessmentTypesDetails);
  RegisterClassOnce(TAssessmentTypesOtherOptionDetails);
  RegisterClassOnce(TAssessment);
  RegisterClassOnce(TAssessmentDetails);
  RegisterClassOnce(TAssessmentOtherDetails);
  RegisterClassOnce(TAssessmentGarage);
end.
