unit PayrollCalendars;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  02/04/22  1.00.00  AT  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  Tpayrollcalendars = class(TMSBusObj)
  private
    function GetPayrollCalendarPayPeriod           : string    ;
    function GetPayrollCalendarName                : string    ;
    function GetPayrollCalendarStartDate           : TDateTime ;
    function GetPayrollCalendarFirstPaymentDate    : TDateTime ;
    function GetPayrollCalendarActive              : Boolean   ;
    procedure SetPayrollCalendarPayPeriod           (const Value: string    );
    procedure SetPayrollCalendarName                (const Value: string    );
    procedure SetPayrollCalendarStartDate           (const Value: TDateTime );
    procedure SetPayrollCalendarFirstPaymentDate    (const Value: TDateTime );
    procedure SetPayrollCalendarActive              (const Value: Boolean   );
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
    property PayrollCalendarPayPeriod            :string      read GetPayrollCalendarPayPeriod          write SetPayrollCalendarPayPeriod       ;
    property PayrollCalendarName                 :string      read GetPayrollCalendarName               write SetPayrollCalendarName            ;
    property PayrollCalendarStartDate            :TDateTime   read GetPayrollCalendarStartDate          write SetPayrollCalendarStartDate       ;
    property PayrollCalendarFirstPaymentDate     :TDateTime   read GetPayrollCalendarFirstPaymentDate   write SetPayrollCalendarFirstPaymentDate;
    property PayrollCalendarActive               :Boolean     read GetPayrollCalendarActive             write SetPayrollCalendarActive          ;
  end;


implementation


uses tcDataUtils, CommonLib;



  {Tpayrollcalendars}

constructor Tpayrollcalendars.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'payrollcalendars';
  fSQL := 'SELECT * FROM tblpayrollcalendars';
end;


destructor Tpayrollcalendars.Destroy;
begin
  inherited;
end;


procedure Tpayrollcalendars.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'PayrollCalendarPayPeriod');
  SetPropertyFromNode(node,'PayrollCalendarName');
  SetDateTimePropertyFromNode(node,'PayrollCalendarStartDate');
  SetDateTimePropertyFromNode(node,'PayrollCalendarFirstPaymentDate');
  SetBooleanPropertyFromNode(node,'PayrollCalendarActive');
end;


procedure Tpayrollcalendars.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'PayrollCalendarPayPeriod' ,PayrollCalendarPayPeriod);
  AddXMLNode(node,'PayrollCalendarName' ,PayrollCalendarName);
  AddXMLNode(node,'PayrollCalendarStartDate' ,PayrollCalendarStartDate);
  AddXMLNode(node,'PayrollCalendarFirstPaymentDate' ,PayrollCalendarFirstPaymentDate);
  AddXMLNode(node,'PayrollCalendarActive' ,PayrollCalendarActive);
end;


function Tpayrollcalendars.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Tpayrollcalendars.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tpayrollcalendars.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tpayrollcalendars.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Tpayrollcalendars.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tpayrollcalendars.GetIDField: string;
begin
  Result := 'ID'
end;


class function Tpayrollcalendars.GetBusObjectTablename: string;
begin
  Result:= 'tblpayrollcalendars';
end;


function Tpayrollcalendars.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Tpayrollcalendars.GetPayrollCalendarPayPeriod       : string    ; begin Result := GetStringField('PayrollCalendarPayPeriod');end;
function  Tpayrollcalendars.GetPayrollCalendarName            : string    ; begin Result := GetStringField('PayrollCalendarName');end;
function  Tpayrollcalendars.GetPayrollCalendarStartDate       : TDateTime ; begin Result := GetDateTimeField('PayrollCalendarStartDate');end;
function  Tpayrollcalendars.GetPayrollCalendarFirstPaymentDate: TDateTime ; begin Result := GetDateTimeField('PayrollCalendarFirstPaymentDate');end;
function  Tpayrollcalendars.GetPayrollCalendarActive          : Boolean   ; begin Result := GetBooleanField('PayrollCalendarActive');end;
procedure Tpayrollcalendars.SetPayrollCalendarPayPeriod       (const Value: string    ); begin SetStringField('PayrollCalendarPayPeriod'        , Value);end;
procedure Tpayrollcalendars.SetPayrollCalendarName            (const Value: string    ); begin SetStringField('PayrollCalendarName'             , Value);end;
procedure Tpayrollcalendars.SetPayrollCalendarStartDate       (const Value: TDateTime ); begin SetDateTimeField('PayrollCalendarStartDate'        , Value);end;
procedure Tpayrollcalendars.SetPayrollCalendarFirstPaymentDate(const Value: TDateTime ); begin SetDateTimeField('PayrollCalendarFirstPaymentDate' , Value);end;
procedure Tpayrollcalendars.SetPayrollCalendarActive          (const Value: Boolean   ); begin SetBooleanField('PayrollCalendarActive'           , Value);end;


initialization
  RegisterClass(Tpayrollcalendars);


end.
