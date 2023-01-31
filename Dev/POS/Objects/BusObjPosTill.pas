unit BusObjPosTill;

interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;

type
  TPosTill = class(TMSBusObj)
  private
    function GetTillName: string;
    function GetPrimaryPadID: Integer;
    function GetActive: Boolean;
    function GetUseDefaultPrinter: Boolean;
    function GetReceiptPrinterOn: Boolean;
    function GetReceiptPrinterPort: string;
    function GetReceiptPrinterType: string;
    function GetReceiptPrinterToggled: Boolean;
    function GetComputerName: string;
    function GetEftNextID: Integer;
    function GetEftInProgress: Boolean;
    function GetUseCashDrawerOnly: Boolean;
    function GetRemoteReceipt: string;
    function GetPrintRemoteReceipt: Boolean;
    function GetIsPrintSpooler: Boolean;
    function GetUsePrintSpooler: Boolean;
    function GetKickRemoteDrawer: Boolean;
    function GetUseLocalDrawer: Boolean;
    function GetClassID: Integer;
    function GetEnableKickRemoteDrawer: Boolean;
    function GetEnableCustomerDisplay: Boolean;
    function GetEnablePPScreenSaver: Boolean;
    function GetPPPathFileName: string;
    function GetPPTransitionEffect: Integer;
    function GetPPTransitionSpeed: Integer;
    function GetPPSlideCycle: Integer;
    function GetIdleWait: Integer;
    function GetDefaultTemplateID: Integer;
    function GetDefaultA4TemplateID: Integer;
    function GetCompany: string;
    function GetAddress1: string;
    function GetAddress2: string;
    function GetState: string;
    function GetPostCode: string;
    function GetCITY: string;
    function GetPHONENUMBER: string;
    function GetFAXNUMBER: string;
    function GetUSBPrinterName: string;
    function GetUsePoledisplay: Boolean;
    function GetPolePort: string;
    function GetUseScale: Boolean;
    function GetUseScanner: Boolean;
    function GetScaleDeviceName: string;
    function GetScannerDeviceName: string;
    function GetPoleDisplayName: string;
    procedure SetTillName(const Value: string);
    procedure SetPrimaryPadID(const Value: Integer);
    procedure SetActive(const Value: Boolean);
    procedure SetUseDefaultPrinter(const Value: Boolean);
    procedure SetReceiptPrinterOn(const Value: Boolean);
    procedure SetReceiptPrinterPort(const Value: string);
    procedure SetReceiptPrinterType(const Value: string);
    procedure SetReceiptPrinterToggled(const Value: Boolean);
    procedure SetComputerName(const Value: string);
    procedure SetEftNextID(const Value: Integer);
    procedure SetEftInProgress(const Value: Boolean);
    procedure SetUseCashDrawerOnly(const Value: Boolean);
    procedure SetRemoteTillID(const Value: Integer);
    procedure SetRemoteReceipt(const Value: string);
    procedure SetPrintRemoteReceipt(const Value: Boolean);
    procedure SetIsPrintSpooler(const Value: Boolean);
    procedure SetUsePrintSpooler(const Value: Boolean);
    procedure SetKickRemoteDrawer(const Value: Boolean);
    procedure SetUseLocalDrawer(const Value: Boolean);
    procedure SetClassID(const Value: Integer);
    procedure SetEnableKickRemoteDrawer(const Value: Boolean);
    procedure SetEnableCustomerDisplay(const Value: Boolean);
    procedure SetEnablePPScreenSaver(const Value: Boolean);
    procedure SetPPPathFileName(const Value: string);
    procedure SetPPTransitionEffect(const Value: Integer);
    procedure SetPPTransitionSpeed(const Value: Integer);
    procedure SetPPSlideCycle(const Value: Integer);
    procedure SetIdleWait(const Value: Integer);
    procedure SetDefaultTemplateID(const Value: Integer);
    procedure SetDefaultA4TemplateID(const Value: Integer);
    procedure SetPOSPrintReceiptOnlyOnCompleteSale(const Value: Boolean);
    procedure SetPOSPrintDescriptionMultipleLines(const Value: Boolean);
    procedure SetCompany(const Value: string);
    procedure SetAddress1(const Value: string);
    procedure SetAddress2(const Value: string);
    procedure SetState(const Value: string);
    procedure SetPostCode(const Value: string);
    procedure SetCITY(const Value: string);
    procedure SetPHONENUMBER(const Value: string);
    procedure SetFAXNUMBER(const Value: string);
    procedure SetUSBPrinterName(const Value: string);
    procedure SetUsePoledisplay(const Value: Boolean);
    procedure SetPolePort(const Value: string);
    procedure SetUseScale(const Value: Boolean);
    procedure SetUseScanner(const Value: Boolean);
    procedure SetScaleDeviceName(const Value: string);
    procedure SetScannerDeviceName(const Value: string);
    procedure SetPoleDisplayName(const Value: string);
    function GetDeptClassName: string;
    procedure SetDeptClassName(const Value: string);
    function GetRemoteTillName: string;
    procedure SetRemoteTillName(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function GetRemoteTillID: Integer;Virtual;
    function GetPOSPrintReceiptOnlyOnCompleteSale: Boolean;Virtual;
    function GetPOSPrintDescriptionMultipleLines: Boolean;Virtual;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    { NOTE warning the user can change the till name! }
    { .. so we can use this as a key property  }
    //class function GetKeyStringProperty: string; override;
    { .. but still need key field for IDToggle! }
    class function GetKeyStringField: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    class function _Schema: string; override;
  published
    property TillName: string read GetTillName write SetTillName;
    property PrimaryPadID: Integer read GetPrimaryPadID write SetPrimaryPadID;
    property Active: Boolean read GetActive write SetActive;
    property UseDefaultPrinter: Boolean read GetUseDefaultPrinter write SetUseDefaultPrinter;
    property ReceiptPrinterOn: Boolean read GetReceiptPrinterOn write SetReceiptPrinterOn;
    property ReceiptPrinterPort: string read GetReceiptPrinterPort write SetReceiptPrinterPort;
    property ReceiptPrinterType: string read GetReceiptPrinterType write SetReceiptPrinterType;
    property ReceiptPrinterToggled: Boolean read GetReceiptPrinterToggled write SetReceiptPrinterToggled;
    property ComputerName: string read GetComputerName write SetComputerName;
    property EftNextID: Integer read GetEftNextID write SetEftNextID;
    property EftInProgress: Boolean read GetEftInProgress write SetEftInProgress;
    property UseCashDrawerOnly: Boolean read GetUseCashDrawerOnly write SetUseCashDrawerOnly;
    property RemoteTillID: Integer read GetRemoteTillID write SetRemoteTillID;
    property RemoteTillName: string read GetRemoteTillName write SetRemoteTillName;
    property RemoteReceipt: string read GetRemoteReceipt write SetRemoteReceipt;
    property PrintRemoteReceipt: Boolean read GetPrintRemoteReceipt write SetPrintRemoteReceipt;
    property IsPrintSpooler: Boolean read GetIsPrintSpooler write SetIsPrintSpooler;
    property UsePrintSpooler: Boolean read GetUsePrintSpooler write SetUsePrintSpooler;
    property KickRemoteDrawer: Boolean read GetKickRemoteDrawer write SetKickRemoteDrawer;
    property UseLocalDrawer: Boolean read GetUseLocalDrawer write SetUseLocalDrawer;
    property ClassID: Integer read GetClassID write SetClassID;
    property DeptClassName: string read GetDeptClassName write SetDeptClassName;
    property EnableKickRemoteDrawer: Boolean read GetEnableKickRemoteDrawer write SetEnableKickRemoteDrawer;
    property EnableCustomerDisplay: Boolean read GetEnableCustomerDisplay write SetEnableCustomerDisplay;
    property EnablePPScreenSaver: Boolean read GetEnablePPScreenSaver write SetEnablePPScreenSaver;
    property PPPathFileName: string read GetPPPathFileName write SetPPPathFileName;
    property PPTransitionEffect: Integer read GetPPTransitionEffect write SetPPTransitionEffect;
    property PPTransitionSpeed: Integer read GetPPTransitionSpeed write SetPPTransitionSpeed;
    property PPSlideCycle: Integer read GetPPSlideCycle write SetPPSlideCycle;
    property IdleWait: Integer read GetIdleWait write SetIdleWait;
    property DefaultTemplateID: Integer read GetDefaultTemplateID write SetDefaultTemplateID;
    property DefaultA4TemplateID: Integer read GetDefaultA4TemplateID write SetDefaultA4TemplateID;
    property POSPrintReceiptOnlyOnCompleteSale: Boolean read GetPOSPrintReceiptOnlyOnCompleteSale write SetPOSPrintReceiptOnlyOnCompleteSale;
    property POSPrintDescriptionMultipleLines: Boolean read GetPOSPrintDescriptionMultipleLines write SetPOSPrintDescriptionMultipleLines;
    property Company: string read GetCompany write SetCompany;
    property Address1: string read GetAddress1 write SetAddress1;
    property Address2: string read GetAddress2 write SetAddress2;
    property State: string read GetState write SetState;
    property PostCode: string read GetPostCode write SetPostCode;
    property City: string read GetCITY write SetCITY;
    property PhoneNumber: string read GetPHONENUMBER write SetPHONENUMBER;
    property FaxNumber: string read GetFAXNUMBER write SetFAXNUMBER;
    property USBPrinterName: string read GetUSBPrinterName write SetUSBPrinterName;
    property UsePoledisplay: Boolean read GetUsePoledisplay write SetUsePoledisplay;
    property PolePort: string read GetPolePort write SetPolePort;
    property UseScale: Boolean read GetUseScale write SetUseScale;
    property UseScanner: Boolean read GetUseScanner write SetUseScanner;
    property ScaleDeviceName: string read GetScaleDeviceName write SetScaleDeviceName;
    property ScannerDeviceName: string read GetScannerDeviceName write SetScannerDeviceName;
    property PoleDisplayName: string read GetPoleDisplayName write SetPoleDisplayName;
  end;
  TPosTillDetails = Class(TPosTill)
    Private
    Protected
      function GetRemoteTillID: Integer;Override;
      function GetPOSPrintReceiptOnlyOnCompleteSale: Boolean;Override;
      function GetPOSPrintDescriptionMultipleLines: Boolean;Override;
    Public
  End;

implementation

uses tcDataUtils, CommonLib, BusObjSchemaLib, BusObjClass, ERPDbComponents, SysUtils,
  AppEnvironment;

{ TPosTill }

constructor TPosTill.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'PoTtill';
  fSQL := 'SELECT * FROM tblpostills';
  ExportExcludeList.Add('classid');
  ExportExcludeList.Add('remotetillid');
end;

destructor TPosTill.Destroy;
begin
  inherited;
end;

procedure TPosTill.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'TillName');
  SetPropertyFromNode(node, 'PrimaryPadID');
  SetBooleanPropertyFromNode(node, 'Active');
  SetBooleanPropertyFromNode(node, 'UseDefaultPrinter');
  SetBooleanPropertyFromNode(node, 'ReceiptPrinterOn');
  SetPropertyFromNode(node, 'ReceiptPrinterPort');
  SetPropertyFromNode(node, 'ReceiptPrinterType');
  SetBooleanPropertyFromNode(node, 'ReceiptPrinterToggled');
  SetPropertyFromNode(node, 'ComputerName');
  SetPropertyFromNode(node, 'EftNextID');
  SetBooleanPropertyFromNode(node, 'EftInProgress');
  SetBooleanPropertyFromNode(node, 'UseCashDrawerOnly');
  SetPropertyFromNode(node, 'RemoteTillID');
  SetPropertyFromNode(node, 'RemoteReceipt');
  SetBooleanPropertyFromNode(node, 'PrintRemoteReceipt');
  SetBooleanPropertyFromNode(node, 'IsPrintSpooler');
  SetBooleanPropertyFromNode(node, 'UsePrintSpooler');
  SetBooleanPropertyFromNode(node, 'KickRemoteDrawer');
  SetBooleanPropertyFromNode(node, 'UseLocalDrawer');
  SetPropertyFromNode(node, 'ClassID');
  SetBooleanPropertyFromNode(node, 'EnableKickRemoteDrawer');
  SetBooleanPropertyFromNode(node, 'EnableCustomerDisplay');
  SetBooleanPropertyFromNode(node, 'EnablePPScreenSaver');
  SetPropertyFromNode(node, 'PPPathFileName');
  SetPropertyFromNode(node, 'PPTransitionEffect');
  SetPropertyFromNode(node, 'PPTransitionSpeed');
  SetPropertyFromNode(node, 'PPSlideCycle');
  SetPropertyFromNode(node, 'IdleWait');
  SetPropertyFromNode(node, 'DefaultTemplateID');
  SetPropertyFromNode(node, 'DefaultA4TemplateID');
  SetBooleanPropertyFromNode(node, 'POSPrintReceiptOnlyOnCompleteSale');
  SetBooleanPropertyFromNode(node, 'POSPrintDescriptionMultipleLines');
  SetPropertyFromNode(node, 'Company');
  SetPropertyFromNode(node, 'Address1');
  SetPropertyFromNode(node, 'Address2');
  SetPropertyFromNode(node, 'State');
  SetPropertyFromNode(node, 'PostCode');
  SetPropertyFromNode(node, 'CITY');
  SetPropertyFromNode(node, 'PHONENUMBER');
  SetPropertyFromNode(node, 'FAXNUMBER');
  SetPropertyFromNode(node, 'USBPrinterName');
  SetBooleanPropertyFromNode(node, 'UsePoledisplay');
  SetPropertyFromNode(node, 'PolePort');
  SetBooleanPropertyFromNode(node, 'UseScale');
  SetBooleanPropertyFromNode(node, 'UseScanner');
  SetPropertyFromNode(node, 'ScaleDeviceName');
  SetPropertyFromNode(node, 'ScannerDeviceName');
  SetPropertyFromNode(node, 'PoleDisplayName');
end;

procedure TPosTill.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'TillName', TillName);
  AddXMLNode(node, 'PrimaryPadID', PrimaryPadID);
  AddXMLNode(node, 'Active', Active);
  AddXMLNode(node, 'UseDefaultPrinter', UseDefaultPrinter);
  AddXMLNode(node, 'ReceiptPrinterOn', ReceiptPrinterOn);
  AddXMLNode(node, 'ReceiptPrinterPort', ReceiptPrinterPort);
  AddXMLNode(node, 'ReceiptPrinterType', ReceiptPrinterType);
  AddXMLNode(node, 'ReceiptPrinterToggled', ReceiptPrinterToggled);
  AddXMLNode(node, 'ComputerName', ComputerName);
  AddXMLNode(node, 'EftNextID', EftNextID);
  AddXMLNode(node, 'EftInProgress', EftInProgress);
  AddXMLNode(node, 'UseCashDrawerOnly', UseCashDrawerOnly);
  AddXMLNode(node, 'RemoteTillID', RemoteTillID);
  AddXMLNode(node, 'RemoteReceipt', RemoteReceipt);
  AddXMLNode(node, 'PrintRemoteReceipt', PrintRemoteReceipt);
  AddXMLNode(node, 'IsPrintSpooler', IsPrintSpooler);
  AddXMLNode(node, 'UsePrintSpooler', UsePrintSpooler);
  AddXMLNode(node, 'KickRemoteDrawer', KickRemoteDrawer);
  AddXMLNode(node, 'UseLocalDrawer', UseLocalDrawer);
  AddXMLNode(node, 'ClassID', ClassID);
  AddXMLNode(node, 'EnableKickRemoteDrawer', EnableKickRemoteDrawer);
  AddXMLNode(node, 'EnableCustomerDisplay', EnableCustomerDisplay);
  AddXMLNode(node, 'EnablePPScreenSaver', EnablePPScreenSaver);
  AddXMLNode(node, 'PPPathFileName', PPPathFileName);
  AddXMLNode(node, 'PPTransitionEffect', PPTransitionEffect);
  AddXMLNode(node, 'PPTransitionSpeed', PPTransitionSpeed);
  AddXMLNode(node, 'PPSlideCycle', PPSlideCycle);
  AddXMLNode(node, 'IdleWait', IdleWait);
  AddXMLNode(node, 'DefaultTemplateID', DefaultTemplateID);
  AddXMLNode(node, 'DefaultA4TemplateID', DefaultA4TemplateID);
  AddXMLNode(node, 'POSPrintReceiptOnlyOnCompleteSale', POSPrintReceiptOnlyOnCompleteSale);
  AddXMLNode(node, 'POSPrintDescriptionMultipleLines', POSPrintDescriptionMultipleLines);
  AddXMLNode(node, 'Company', Company);
  AddXMLNode(node, 'Address1', Address1);
  AddXMLNode(node, 'Address2', Address2);
  AddXMLNode(node, 'State', State);
  AddXMLNode(node, 'PostCode', PostCode);
  AddXMLNode(node, 'City', CITY);
  AddXMLNode(node, 'PhoneNumber', PHONENUMBER);
  AddXMLNode(node, 'FaxNumber', FAXNUMBER);
  AddXMLNode(node, 'USBPrinterName', USBPrinterName);
  AddXMLNode(node, 'UsePoleDisplay', UsePoledisplay);
  AddXMLNode(node, 'PolePort', PolePort);
  AddXMLNode(node, 'UseScale', UseScale);
  AddXMLNode(node, 'UseScanner', UseScanner);
  AddXMLNode(node, 'ScaleDeviceName', ScaleDeviceName);
  AddXMLNode(node, 'ScannerDeviceName', ScannerDeviceName);
  AddXMLNode(node, 'PoleDisplayName', PoleDisplayName);
end;

function TPosTill.ValidateData: Boolean;
var
  qry: TERPQuery;
begin
  Result := False;
  ResultStatus.Clear;
  if TillName = '' then begin
    AddResult(False, rssWarning, 0, 'Till name is blank.');
    Exit;
  end;
  if self.PrimaryPadID < 1 then begin
    AddResult(False, rssWarning, 0, 'Primary Keypad not selected.');
    Exit;
  end;
  qry:= TERPQuery.Create(nil);
  try
    qry.Connection:= Connection.Connection;
    qry.SQL.Add('select * from tblposkeypads where KeypadID = ' + IntToStr(PrimaryPadID));
    qry.Open;
    if qry.IsEmpty then begin
      AddResult(False, rssWarning, 0, 'Primary Keypad not found for ID: ' + IntToStr(PrimaryPadID));
      Exit;
    end
    else begin
      if not qry.FieldByName('Active').AsBoolean then begin
        AddResult(False, rssWarning, 0, 'Selected Primary Keypad is not Active.');
        Exit;
      end;
    end;
  finally
    qry.Free;
  end;
  Result := True;
end;

class function TPosTill._Schema: string;
begin
  Result := inherited;
  TBOSchema.AddRefType(result,'TPosKeypad','KeypadObj','PrimaryPadID','ID');
  TBOSchema.AddRefType(result,'TPosTill','TillObj','RemoteTillID','ID');
  TBOSchema.AddRefType(result,'TDeptClass','DeptClassObj','DeptClassName','DeptClassName');

end;

function TPosTill.Save: Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TPosTill.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TPosTill.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TPosTill.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TPosTill.GetIDField           : string;begin  Result := 'TillID'end;
class function TPosTill.GetBusObjectTablename: string;begin  Result := 'tblpostills';end;
class function TPosTill.GetKeyStringField    : string;begin  Result := 'TillName';end;
function TPosTill.DoAfterPost(Sender: TDatasetBusObj): Boolean;begin  Result := inherited DoAfterPost(Sender);end;
{ Property Functions }
function TPosTill.GetTillName                           : string ;begin  Result := GetStringField('TillName');end;
function TPosTill.GetPrimaryPadID                       : Integer;begin  Result := GetIntegerField('PrimaryPadID');end;
function TPosTill.GetActive                             : Boolean;begin  Result := GetBooleanField('Active');end;
function TPosTill.GetUseDefaultPrinter                  : Boolean;begin  Result := GetBooleanField('UseDefaultPrinter');end;
function TPosTill.GetReceiptPrinterOn                   : Boolean;begin  Result := GetBooleanField('ReceiptPrinterOn');end;
function TPosTill.GetReceiptPrinterPort                 : string ;begin  Result := GetStringField('ReceiptPrinterPort');end;
function TPosTill.GetReceiptPrinterType                 : string ;begin  Result := GetStringField('ReceiptPrinterType');end;
function TPosTill.GetReceiptPrinterToggled              : Boolean;begin  Result := GetBooleanField('ReceiptPrinterToggled');end;
function TPosTill.GetComputerName                       : string ;begin  Result := GetStringField('ComputerName');end;
function TPosTill.GetDeptClassName                      : string ;begin  Result := TDeptClass.IDToggle(ClassID, Connection.Connection);end;
function TPosTill.GetEftNextID                          : Integer;begin  Result := GetIntegerField('EftNextID');end;
function TPosTill.GetEftInProgress                      : Boolean;begin  Result := GetBooleanField('EftInProgress');end;
function TPosTill.GetUseCashDrawerOnly                  : Boolean;begin  Result := GetBooleanField('UseCashDrawerOnly');end;
function TPosTill.GetRemoteTillID                       : Integer;begin  Result := GetIntegerField('RemoteTillID');end;
function TPosTill.GetRemoteTillName                     : string ;begin  Result := TPosTill.IDToggle(RemoteTillID, Connection.Connection);end;
function TPosTill.GetRemoteReceipt                      : string ;begin  Result := GetStringField('RemoteReceipt');end;
function TPosTill.GetPrintRemoteReceipt                 : Boolean;begin  Result := GetBooleanField('PrintRemoteReceipt');end;
function TPosTill.GetIsPrintSpooler                     : Boolean;begin  Result := GetBooleanField('IsPrintSpooler');end;
function TPosTill.GetUsePrintSpooler                    : Boolean;begin  Result := GetBooleanField('UsePrintSpooler');    end;
function TPosTill.GetKickRemoteDrawer                   : Boolean;begin  Result := GetBooleanField('KickRemoteDrawer');end;
function TPosTill.GetUseLocalDrawer                     : Boolean;begin  Result := GetBooleanField('UseLocalDrawer');end;
function TPosTill.GetClassID                            : Integer;begin  Result := GetIntegerField('ClassID');end;
function TPosTill.GetEnableKickRemoteDrawer             : Boolean;begin  Result := GetBooleanField('EnableKickRemoteDrawer');end;
function TPosTill.GetEnableCustomerDisplay              : Boolean;begin  Result := GetBooleanField('EnableCustomerDisplay');end;
function TPosTill.GetEnablePPScreenSaver                : Boolean;begin  Result := GetBooleanField('EnablePPScreenSaver');end;
function TPosTill.GetPPPathFileName                     : string ;begin  Result := GetStringField('PPPathFileName');end;
function TPosTill.GetPPTransitionEffect                 : Integer;begin  Result := GetIntegerField('PPTransitionEffect');end;
function TPosTill.GetPPTransitionSpeed                  : Integer;begin  Result := GetIntegerField('PPTransitionSpeed');end;
function TPosTill.GetPPSlideCycle                       : Integer;begin  Result := GetIntegerField('PPSlideCycle');end;
function TPosTill.GetIdleWait                           : Integer;begin  Result := GetIntegerField('IdleWait');end;
function TPosTill.GetDefaultTemplateID                  : Integer;begin  Result := GetIntegerField('DefaultTemplateID');end;
function TPosTill.GetDefaultA4TemplateID                : Integer;begin  Result := GetIntegerField('DefaultA4TemplateID');end;
function TPosTill.GetPOSPrintReceiptOnlyOnCompleteSale  : Boolean;begin  Result := GetBooleanField('POSPrintReceiptOnlyOnCompleteSale');end;
function TPosTill.GetPOSPrintDescriptionMultipleLines   : Boolean;begin  Result := GetBooleanField('POSPrintDescriptionMultipleLines');end;
function TPosTill.GetCompany                            : string ;begin  Result := GetStringField('Company');end;
function TPosTill.GetAddress1                           : string ;begin  Result := GetStringField('Address1');end;
function TPosTill.GetAddress2                           : string ;begin  Result := GetStringField('Address2');end;
function TPosTill.GetState                              : string ;begin  Result := GetStringField('State');end;
function TPosTill.GetPostCode                           : string ;begin  Result := GetStringField('PostCode');end;
function TPosTill.GetCITY                               : string ;begin  Result := GetStringField('CITY');end;
function TPosTill.GetPHONENUMBER                        : string ;begin  Result := GetStringField('PHONENUMBER');end;
function TPosTill.GetFAXNUMBER                          : string ;begin  Result := GetStringField('FAXNUMBER');end;
function TPosTill.GetUSBPrinterName                     : string ;begin  Result := GetStringField('USBPrinterName');end;
function TPosTill.GetUsePoledisplay                     : Boolean;begin  Result := GetBooleanField('UsePoledisplay');end;
function TPosTill.GetPolePort                           : string ;begin  Result := GetStringField('PolePort');end;
function TPosTill.GetUseScale                           : Boolean;begin  Result := GetBooleanField('UseScale');end;
function TPosTill.GetUseScanner                         : Boolean;begin  Result := GetBooleanField('UseScanner');end;
function TPosTill.GetScaleDeviceName                    : string ;begin  Result := GetStringField('ScaleDeviceName');end;
function TPosTill.GetScannerDeviceName                  : string ;begin  Result := GetStringField('ScannerDeviceName');end;
function TPosTill.GetPoleDisplayName                    : string ;begin  Result := GetStringField('PoleDisplayName');end;
procedure TPosTill.SetTillName                          (const Value: string );begin  SetStringField('TillName', Value);end;
procedure TPosTill.SetPrimaryPadID                      (const Value: Integer);begin  SetIntegerField('PrimaryPadID', Value);end;
procedure TPosTill.SetActive                            (const Value: Boolean);begin  SetBooleanField('Active', Value);end;
procedure TPosTill.SetUseDefaultPrinter                 (const Value: Boolean);begin  SetBooleanField('UseDefaultPrinter', Value);end;
procedure TPosTill.SetReceiptPrinterOn                  (const Value: Boolean);begin  SetBooleanField('ReceiptPrinterOn', Value);end;
procedure TPosTill.SetReceiptPrinterPort                (const Value: string );begin  SetStringField('ReceiptPrinterPort', Value);end;
procedure TPosTill.SetReceiptPrinterType                (const Value: string );begin  SetStringField('ReceiptPrinterType', Value);end;
procedure TPosTill.SetReceiptPrinterToggled             (const Value: Boolean);begin  SetBooleanField('ReceiptPrinterToggled', Value);end;
procedure TPosTill.SetComputerName                      (const Value: string );begin  SetStringField('ComputerName', Value);end;
procedure TPosTill.SetDeptClassName                     (const Value: string );begin  ClassID:= TDeptClass.IDToggle(Value, Connection.Connection);end;
procedure TPosTill.SetEftNextID                         (const Value: Integer);begin  SetIntegerField('EftNextID', Value);end;
procedure TPosTill.SetEftInProgress                     (const Value: Boolean);begin  SetBooleanField('EftInProgress', Value);end;
procedure TPosTill.SetUseCashDrawerOnly                 (const Value: Boolean);begin  SetBooleanField('UseCashDrawerOnly', Value);end;
procedure TPosTill.SetRemoteTillID                      (const Value: Integer);begin  SetIntegerField('RemoteTillID', Value);end;
procedure TPosTill.SetRemoteTillName                    (const Value: string );begin  RemoteTillID:= TPosTill.IDToggle(Value, Connection.Connection);end;
procedure TPosTill.SetRemoteReceipt                     (const Value: string );begin  SetStringField('RemoteReceipt', Value);end;
procedure TPosTill.SetPrintRemoteReceipt                (const Value: Boolean);begin  SetBooleanField('PrintRemoteReceipt', Value);end;
procedure TPosTill.SetIsPrintSpooler                    (const Value: Boolean);begin  SetBooleanField('IsPrintSpooler', Value);end;
procedure TPosTill.SetUsePrintSpooler                   (const Value: Boolean);begin  SetBooleanField('UsePrintSpooler', Value);end;
procedure TPosTill.SetKickRemoteDrawer                  (const Value: Boolean);begin  SetBooleanField('KickRemoteDrawer', Value);end;
procedure TPosTill.SetUseLocalDrawer                    (const Value: Boolean);begin  SetBooleanField('UseLocalDrawer', Value);end;
procedure TPosTill.SetClassID                           (const Value: Integer);begin  SetIntegerField('ClassID', Value);end;
procedure TPosTill.SetEnableKickRemoteDrawer            (const Value: Boolean);begin  SetBooleanField('EnableKickRemoteDrawer', Value);end;
procedure TPosTill.SetEnableCustomerDisplay             (const Value: Boolean);begin  SetBooleanField('EnableCustomerDisplay', Value);end;
procedure TPosTill.SetEnablePPScreenSaver               (const Value: Boolean);begin  SetBooleanField('EnablePPScreenSaver', Value);end;
procedure TPosTill.SetPPPathFileName                    (const Value: string );begin  SetStringField('PPPathFileName', Value);end;
procedure TPosTill.SetPPTransitionEffect                (const Value: Integer);begin  SetIntegerField('PPTransitionEffect', Value);end;
procedure TPosTill.SetPPTransitionSpeed                 (const Value: Integer);begin  SetIntegerField('PPTransitionSpeed', Value);end;
procedure TPosTill.SetPPSlideCycle                      (const Value: Integer);begin  SetIntegerField('PPSlideCycle', Value);end;
procedure TPosTill.SetIdleWait                          (const Value: Integer);begin  SetIntegerField('IdleWait', Value);end;
procedure TPosTill.SetDefaultTemplateID                 (const Value: Integer);begin  SetIntegerField('DefaultTemplateID', Value);end;
procedure TPosTill.SetDefaultA4TemplateID               (const Value: Integer);begin  SetIntegerField('DefaultA4TemplateID', Value);end;
procedure TPosTill.SetPOSPrintReceiptOnlyOnCompleteSale (const Value: Boolean);begin  SetBooleanField('POSPrintReceiptOnlyOnCompleteSale', Value);end;
procedure TPosTill.SetPOSPrintDescriptionMultipleLines  (const Value: Boolean);begin  SetBooleanField('POSPrintDescriptionMultipleLines', Value);end;
procedure TPosTill.SetCompany                           (const Value: string );begin  SetStringField('Company', Value);end;
procedure TPosTill.SetAddress1                          (const Value: string );begin  SetStringField('Address1', Value);end;
procedure TPosTill.SetAddress2                          (const Value: string );begin  SetStringField('Address2', Value);end;
procedure TPosTill.SetState                             (const Value: string );begin  SetStringField('State', Value);end;
procedure TPosTill.SetPostCode                          (const Value: string );begin  SetStringField('PostCode', Value);end;
procedure TPosTill.SetCITY                              (const Value: string );begin  SetStringField('CITY', Value);end;
procedure TPosTill.SetPHONENUMBER                       (const Value: string );begin  SetStringField('PHONENUMBER', Value);end;
procedure TPosTill.SetFAXNUMBER                         (const Value: string );begin  SetStringField('FAXNUMBER', Value);end;
procedure TPosTill.SetUSBPrinterName                    (const Value: string );begin  SetStringField('USBPrinterName', Value);end;
procedure TPosTill.SetUsePoledisplay                    (const Value: Boolean);begin  SetBooleanField('UsePoledisplay', Value);end;
procedure TPosTill.SetPolePort                          (const Value: string );begin  SetStringField('PolePort', Value);end;
procedure TPosTill.SetUseScale                          (const Value: Boolean);begin  SetBooleanField('UseScale', Value);end;
procedure TPosTill.SetUseScanner                        (const Value: Boolean);begin  SetBooleanField('UseScanner', Value);end;
procedure TPosTill.SetScaleDeviceName                   (const Value: string );begin  SetStringField('ScaleDeviceName', Value);end;
procedure TPosTill.SetScannerDeviceName                 (const Value: string );begin  SetStringField('ScannerDeviceName', Value);end;
procedure TPosTill.SetPoleDisplayName                   (const Value: string );begin  SetStringField('PoleDisplayName', Value);end;

{ TPosTillDetails }
function TPosTillDetails.GetPOSPrintDescriptionMultipleLines: Boolean;
begin
  if count =0 then
    Result := AppEnv.CompanyPrefs.POSPrintDescriptionMultipleLines
  else result :=  inherited GetPOSPrintDescriptionMultipleLines;
end;

function TPosTillDetails.GetPOSPrintReceiptOnlyOnCompleteSale: Boolean;
begin
  if count =0 then
    Result := AppEnv.CompanyPrefs.POSPrintReceiptOnlyOnCompleteSale
  else result :=  inherited GetPOSPrintReceiptOnlyOnCompleteSale;
end;

function TPosTillDetails.getRemoteTillID: Integer;
begin
    if IsPrintSpooler then
      result := Id
    else result := inherited getRemoteTillID;
end;
initialization

RegisterClass(TPosTill);

end.
