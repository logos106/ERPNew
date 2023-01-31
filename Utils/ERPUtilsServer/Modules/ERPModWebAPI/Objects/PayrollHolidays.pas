unit PayrollHolidays;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  02/04/22  1.00.00  AT  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  Tpayrollholidays = class(TMSBusObj)
  private
    function GetPayrollHolidaysName                : string    ;
    function GetPayrollHolidaysDate                : TDateTime ;
    function GetPayrollHolidaysParentGroup         : string    ;
    function GetPayrollHolidaysGroupName           : string    ;
    function GetPayrollHolidaysActive              : Boolean   ;
    procedure SetPayrollHolidaysName                (const Value: string    );
    procedure SetPayrollHolidaysDate                (const Value: TDateTime );
    procedure SetPayrollHolidaysParentGroup         (const Value: string    );
    procedure SetPayrollHolidaysGroupName           (const Value: string    );
    procedure SetPayrollHolidaysActive              (const Value: Boolean   );
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
    property PayrollHolidaysName                 :string      read GetPayrollHolidaysName               write SetPayrollHolidaysName            ;
    property PayrollHolidaysDate                 :TDateTime   read GetPayrollHolidaysDate               write SetPayrollHolidaysDate            ;
    property PayrollHolidaysParentGroup          :string      read GetPayrollHolidaysParentGroup        write SetPayrollHolidaysParentGroup     ;
    property PayrollHolidaysGroupName            :string      read GetPayrollHolidaysGroupName          write SetPayrollHolidaysGroupName       ;
    property PayrollHolidaysActive               :Boolean     read GetPayrollHolidaysActive             write SetPayrollHolidaysActive          ;
  end;


implementation


uses tcDataUtils, CommonLib;



  {Tpayrollholidays}

constructor Tpayrollholidays.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'payrollholidays';
  fSQL := 'SELECT * FROM tblpayrollholidays';
end;


destructor Tpayrollholidays.Destroy;
begin
  inherited;
end;


procedure Tpayrollholidays.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'PayrollHolidaysName');
  SetDateTimePropertyFromNode(node,'PayrollHolidaysDate');
  SetPropertyFromNode(node,'PayrollHolidaysParentGroup');
  SetPropertyFromNode(node,'PayrollHolidaysGroupName');
  SetBooleanPropertyFromNode(node,'PayrollHolidaysActive');
end;


procedure Tpayrollholidays.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'PayrollHolidaysName' ,PayrollHolidaysName);
  AddXMLNode(node,'PayrollHolidaysDate' ,PayrollHolidaysDate);
  AddXMLNode(node,'PayrollHolidaysParentGroup' ,PayrollHolidaysParentGroup);
  AddXMLNode(node,'PayrollHolidaysGroupName' ,PayrollHolidaysGroupName);
  AddXMLNode(node,'PayrollHolidaysActive' ,PayrollHolidaysActive);
end;


function Tpayrollholidays.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Tpayrollholidays.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tpayrollholidays.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tpayrollholidays.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Tpayrollholidays.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tpayrollholidays.GetIDField: string;
begin
  Result := 'ID'
end;


class function Tpayrollholidays.GetBusObjectTablename: string;
begin
  Result:= 'tblpayrollholidays';
end;


function Tpayrollholidays.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Tpayrollholidays.GetPayrollHolidaysName            : string    ; begin Result := GetStringField('PayrollHolidaysName');end;
function  Tpayrollholidays.GetPayrollHolidaysDate            : TDateTime ; begin Result := GetDateTimeField('PayrollHolidaysDate');end;
function  Tpayrollholidays.GetPayrollHolidaysParentGroup     : string    ; begin Result := GetStringField('PayrollHolidaysParentGroup');end;
function  Tpayrollholidays.GetPayrollHolidaysGroupName       : string    ; begin Result := GetStringField('PayrollHolidaysGroupName');end;
function  Tpayrollholidays.GetPayrollHolidaysActive          : Boolean   ; begin Result := GetBooleanField('PayrollHolidaysActive');end;
procedure Tpayrollholidays.SetPayrollHolidaysName            (const Value: string    ); begin SetStringField('PayrollHolidaysName'             , Value);end;
procedure Tpayrollholidays.SetPayrollHolidaysDate            (const Value: TDateTime ); begin SetDateTimeField('PayrollHolidaysDate'             , Value);end;
procedure Tpayrollholidays.SetPayrollHolidaysParentGroup     (const Value: string    ); begin SetStringField('PayrollHolidaysParentGroup'      , Value);end;
procedure Tpayrollholidays.SetPayrollHolidaysGroupName       (const Value: string    ); begin SetStringField('PayrollHolidaysGroupName'        , Value);end;
procedure Tpayrollholidays.SetPayrollHolidaysActive          (const Value: Boolean   ); begin SetBooleanField('PayrollHolidaysActive'           , Value);end;


initialization
  RegisterClass(Tpayrollholidays);


end.
