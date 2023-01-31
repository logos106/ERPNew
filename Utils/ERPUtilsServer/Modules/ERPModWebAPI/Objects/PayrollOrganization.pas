unit PayrollOrganization;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  02/04/22  1.00.00  AT  Initial Version.
  }


interface


uses
  SysUtils, BusObjBase, DB, Classes, XMLDoc, XMLIntf, IdCoderMIME;

type
  Tpayrollorganization = class(TMSBusObj)
  private
    FLogoField: TBlobField;

    function Getattachment                               : string;
    function Getbankaccount                              : string    ;
    function Getpaygaacount                              : string    ;
    function GetWagesexpenseaccount                      : string    ;
    function Getwagespayablesaccount                     : string    ;
    function GetSuperlibaccount                          : string    ;
    function GetSupperexpaccount                         : string    ;
    function GetEmployeeGroup                            : string    ;
    function GetTimeSheetCategory                        : string    ;
    // function GetPayrollEmployeeGroup                  : string    ;
    // function GetPayrollTimesheetCategories            : string    ;
    function Getshowannualsalary                         : Boolean   ;
    function Getshowemployeebases                        : Boolean   ;

    procedure Setattachment                              (const Value: string    );
    procedure Setbankaccount                             (const Value: string    );
    procedure Setpaygaacount                             (const Value: string    );
    procedure SetWagesexpenseaccount                     (const Value: string    );
    procedure Setwagespayablesaccount                    (const Value: string    );
    procedure SetSuperlibaccount                         (const Value: string    );
    procedure SetSupperexpaccount                        (const Value: string    );
    procedure SetEmployeeGroup                           (const Value: string    );
    procedure SetTimeSheetCategory                       (const Value: string    );
    // procedure SetPayrollEmployeeGroup                 (const Value: string    );
    // procedure SetPayrollTimesheetCategories           (const Value: string    );
    procedure Setshowannualsalary                        (const Value: Boolean   );
    procedure Setshowemployeebases                       (const Value: Boolean   );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property attachment                                :string      read Getattachment write Setattachment;
    property bankaccount                               :string      read Getbankaccount                     write Setbankaccount                                         ;
    property paygaacount                               :string      read Getpaygaacount                     write Setpaygaacount                                ;
    property Wagesexpenseaccount                       :string      read GetWagesexpenseaccount             write SetWagesexpenseaccount                                 ;
    property wagespayablesaccount                      :string      read Getwagespayablesaccount            write Setwagespayablesaccount                                 ;
    property Superlibaccount                           :string      read GetSuperlibaccount                 write SetSuperlibaccount                      ;
    property Supperexpaccount                          :string      read GetSupperexpaccount                write SetSupperexpaccount                        ;
    property EmployeeGroup                             :string      read GetEmployeeGroup                   write SetEmployeeGroup                        ;
    property TimeSheetCategory                         :string      read GetTimeSheetCategory               write SetTimeSheetCategory                        ;
    // property PayrollEmployeeGroup                   :string      read GetPayrollEmployeeGroup            write SetPayrollEmployeeGroup                                       ;
    // property PayrollTimesheetCategories             :string      read GetPayrollTimesheetCategories      write SetPayrollTimesheetCategories                                 ;
    property showannualsalary                          :Boolean     read Getshowannualsalary                write Setshowannualsalary                                    ;
    property showemployeebases                         :Boolean     read Getshowemployeebases               write Setshowemployeebases                                 ;
  end;


implementation


uses
  tcDataUtils, CommonLib;

{Tpayrollorganization}

constructor Tpayrollorganization.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'payrollorganization';
  // fSQL := 'SELECT * FROM tblpayrollorganization';

  FSQL :=
    ' SELECT ' +
    '   ID, GlobalRef, mstimestamp, msUpdateSiteCode, ' +
    '   PayrollCompanyLogo attachment, ' +
    '   PayrollBankAccount bankaccount, ' +
    '   PayrollPaygLiabilityAccount paygaacount, ' +
    '   PayrollShowAnnualSalary showannualsalary, ' +
    '   PayrollShowEmploymentBasis showemployeebases, ' +
    '   PayrollSuperannuationLiabilityAccount Superlibaccount, ' +
    '   PayrollSuperannuationPayableAccount Supperexpaccount, ' +
    '   PayrollWagesExpenseAccount Wagesexpenseaccount, ' +
    '   PayrollWagesPayableAccount wagespayablesaccount, ' +
    '   PayrollEmployeeGroup EmployeeGroup, ' +
    '   PayrollTimeSheetCategories TimeSheetCategory ' +
    ' FROM tblpayrollorganization';
end;


destructor Tpayrollorganization.Destroy;
begin
  inherited;
end;


procedure Tpayrollorganization.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
//  SetPropertyFromNode(node, 'attachment');
//  SetPropertyFromNode(node, 'bankaccount');
//  SetPropertyFromNode(node, 'paygaacount');
//  SetPropertyFromNode(node, 'Wagesexpenseaccount');
//  SetPropertyFromNode(node, 'wagespayablesaccount');
//  SetPropertyFromNode(node, 'Superlibaccount');
//  SetPropertyFromNode(node, 'Supperexpaccount');
//  // SetPropertyFromNode(node, 'PayrollEmployeeGroup');
//  // SetPropertyFromNode(node, 'PayrollTimesheetCategories');
//  SetBooleanPropertyFromNode(node, 'showannualsalary');
//  SetBooleanPropertyFromNode(node, 'showemployeebases');
end;


procedure Tpayrollorganization.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
//  AddXMLNode(node, 'attachment', attachment);
//  AddXMLNode(node, 'bankaccount' ,bankaccount);
//  AddXMLNode(node, 'paygaacount' ,paygaacount);
//  AddXMLNode(node, 'Wagesexpenseaccount' ,Wagesexpenseaccount);
//  AddXMLNode(node, 'wagespayablesaccount' ,wagespayablesaccount);
//  AddXMLNode(node, 'Superlibaccount' ,Superlibaccount);
//  AddXMLNode(node, 'Supperexpaccount' ,Supperexpaccount);
//  // AddXMLNode(node, 'PayrollEmployeeGroup' ,PayrollEmployeeGroup);
//  // AddXMLNode(node, 'PayrollTimesheetCategories' ,PayrollTimesheetCategories);
//  AddXMLNode(node, 'showannualsalary' ,showannualsalary);
//  AddXMLNode(node, 'showemployeebases' ,showemployeebases);
end;


function Tpayrollorganization.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Tpayrollorganization.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tpayrollorganization.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tpayrollorganization.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Tpayrollorganization.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tpayrollorganization.GetIDField: string;
begin
  Result := 'ID'
end;


class function Tpayrollorganization.GetBusObjectTablename: string;
begin
  Result:= 'tblpayrollorganization';
end;


function Tpayrollorganization.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{Property Functions}
function Tpayrollorganization.Getattachment: string;
var
  EncodeMime: TIdEncoderMIME;
  LogoImageStream: TStream;
begin
  Result := '';

  if not dsReadOk then
    Exit;

  if (FLogoField = nil) then
    FLogoField := Dataset.FieldByName('attachment') as TBlobField;

  LogoImageStream := Dataset.CreateBlobStream(FLogoField, bmRead);
  if (LogoImageStream = nil) then
    Exit;

  EncodeMime := TIdEncoderMIME.Create(nil);
  try
    Result := EncodeMime.Encode(LogoImageStream);
  finally
    EncodeMime.Free;
    LogoImageStream.Free;
  end;
end;

procedure Tpayrollorganization.Setattachment(const Value: String);
var
  DecoderMIME: TIdDecoderMIME;
  LogoImageStream: TStream;
begin
  if not dsWriteOK then
    Exit;

  if (FLogoField = nil) then
    FLogoField := Dataset.FieldByName('attachment') as TBlobField;

  LogoImageStream := Dataset.CreateBlobStream(FLogoField, bmReadWrite);
  if (LogoImageStream = nil) then
    Exit;

  Dataset.Edit;
  DecoderMIME := TIdDecoderMIME.Create(nil);
  try
    DecoderMIME.DecodeBegin(LogoImageStream);
    try
      DecoderMIME.Decode(Value);
    finally
      DecoderMIME.DecodeEnd;
    end;
  finally
    DecoderMIME.Free;
    LogoImageStream.Free;
  end;
end;

function  Tpayrollorganization.Getbankaccount                          : string    ; begin Result := GetStringField('bankaccount');end;
function  Tpayrollorganization.Getpaygaacount                          : string    ; begin Result := GetStringField('paygaacount');end;
function  Tpayrollorganization.GetWagesexpenseaccount                  : string    ; begin Result := GetStringField('Wagesexpenseaccount');end;
function  Tpayrollorganization.Getwagespayablesaccount                 : string    ; begin Result := GetStringField('wagespayablesaccount');end;
function  Tpayrollorganization.GetSuperlibaccount                      : string    ; begin Result := GetStringField('Superlibaccount');end;
function  Tpayrollorganization.GetSupperexpaccount                     : string    ; begin Result := GetStringField('Supperexpaccount');end;
function  Tpayrollorganization.GetEmployeeGroup                        : string    ; begin Result := GetStringField('EmployeeGroup');end;
function  Tpayrollorganization.GetTimeSheetCategory                    : string    ; begin Result := GetStringField('TimeSheetCategory');end;
// function  Tpayrollorganization.GetPayrollEmployeeGroup              : string    ; begin Result := GetStringField('PayrollEmployeeGroup');end;
// function  Tpayrollorganization.GetPayrollTimesheetCategories        : string    ; begin Result := GetStringField('PayrollTimesheetCategories');end;
function  Tpayrollorganization.Getshowannualsalary                     : Boolean   ; begin Result := GetBooleanField('showannualsalary');end;
function  Tpayrollorganization.Getshowemployeebases                    : Boolean   ; begin Result := GetBooleanField('showemployeebases');end;

procedure Tpayrollorganization.Setbankaccount                          (const Value: string    ); begin SetStringField('bankaccount'                  , Value);end;
procedure Tpayrollorganization.Setpaygaacount                          (const Value: string    ); begin SetStringField('paygaacount'                  , Value);end;
procedure Tpayrollorganization.SetWagesexpenseaccount                  (const Value: string    ); begin SetStringField('Wagesexpenseaccount'          , Value);end;
procedure Tpayrollorganization.Setwagespayablesaccount                 (const Value: string    ); begin SetStringField('wagespayablesaccount'         , Value);end;
procedure Tpayrollorganization.SetSuperlibaccount                      (const Value: string    ); begin SetStringField('Superlibaccount'              , Value);end;
procedure Tpayrollorganization.SetSupperexpaccount                     (const Value: string    ); begin SetStringField('Supperexpaccount'             , Value);end;
procedure Tpayrollorganization.SetEmployeeGroup                        (const Value: string    ); begin SetStringField('EmployeeGroup'                , Value);end;
procedure Tpayrollorganization.SetTimeSheetCategory                     (const Value: string    ); begin SetStringField('TimeSheetCategory'            , Value);end;
// procedure Tpayrollorganization.SetPayrollEmployeeGroup              (const Value: string    ); begin SetStringField('PayrollEmployeeGroup'         , Value);end;
// procedure Tpayrollorganization.SetPayrollTimesheetCategories        (const Value: string    ); begin SetStringField('PayrollTimesheetCategories'   , Value);end;
procedure Tpayrollorganization.Setshowannualsalary                     (const Value: Boolean   ); begin SetBooleanField('showannualsalary'            , Value);end;
procedure Tpayrollorganization.Setshowemployeebases                    (const Value: Boolean   ); begin SetBooleanField('showemployeebases'           , Value);end;


initialization
  RegisterClass(Tpayrollorganization);


end.

