unit EmployeeDetails;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  03/04/22  1.00.00  AT  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  Temployeedetails_vs1 = class(TMSBusObj)
  private
    function GetEmployeeName            : string    ;
    function GetEmployeeAnnualSalary    : Double    ;
    function GetEmployeeEarningsYtd     : Double    ;
    function GetEmployeeNextPayDay      : TDateTime ;
    procedure SetEmployeeName            (const Value: string    );
    procedure SetEmployeeAnnualSalary    (const Value: Double    );
    procedure SetEmployeeEarningsYtd     (const Value: Double    );
    procedure SetEmployeeNextPayDay      (const Value: TDateTime );
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
    property EmployeeName             :string      read GetEmployeeName           write SetEmployeeName        ;
    property EmployeeAnnualSalary     :Double      read GetEmployeeAnnualSalary   write SetEmployeeAnnualSalary;
    property EmployeeEarningsYtd      :Double      read GetEmployeeEarningsYtd    write SetEmployeeEarningsYtd ;
    property EmployeeNextPayDay       :TDateTime   read GetEmployeeNextPayDay     write SetEmployeeNextPayDay  ;
  end;


implementation


uses tcDataUtils, CommonLib;



  {Temployeedetails_vs1}

constructor Temployeedetails_vs1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'employeedetails_vs1';
  fSQL := 'SELECT * FROM tblemployeedetails_vs1';
end;


destructor Temployeedetails_vs1.Destroy;
begin
  inherited;
end;


procedure Temployeedetails_vs1.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'EmployeeName');
  SetPropertyFromNode(node,'EmployeeAnnualSalary');
  SetPropertyFromNode(node,'EmployeeEarningsYtd');
  SetDateTimePropertyFromNode(node,'EmployeeNextPayDay');
end;


procedure Temployeedetails_vs1.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'EmployeeName' ,EmployeeName);
  AddXMLNode(node,'EmployeeAnnualSalary' ,EmployeeAnnualSalary);
  AddXMLNode(node,'EmployeeEarningsYtd' ,EmployeeEarningsYtd);
  AddXMLNode(node,'EmployeeNextPayDay' ,EmployeeNextPayDay);
end;


function Temployeedetails_vs1.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Temployeedetails_vs1.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Temployeedetails_vs1.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Temployeedetails_vs1.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Temployeedetails_vs1.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Temployeedetails_vs1.GetIDField: string;
begin
  Result := 'EmployeeID'
end;


class function Temployeedetails_vs1.GetBusObjectTablename: string;
begin
  Result:= 'tblemployeedetails_vs1';
end;


function Temployeedetails_vs1.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Temployeedetails_vs1.GetEmployeeName        : string    ; begin Result := GetStringField('EmployeeName');end;
function  Temployeedetails_vs1.GetEmployeeAnnualSalary: Double    ; begin Result := GetFloatField('EmployeeAnnualSalary');end;
function  Temployeedetails_vs1.GetEmployeeEarningsYtd : Double    ; begin Result := GetFloatField('EmployeeEarningsYtd');end;
function  Temployeedetails_vs1.GetEmployeeNextPayDay  : TDateTime ; begin Result := GetDateTimeField('EmployeeNextPayDay');end;
procedure Temployeedetails_vs1.SetEmployeeName        (const Value: string    ); begin SetStringField('EmployeeName'         , Value);end;
procedure Temployeedetails_vs1.SetEmployeeAnnualSalary(const Value: Double    ); begin SetFloatField('EmployeeAnnualSalary' , Value);end;
procedure Temployeedetails_vs1.SetEmployeeEarningsYtd (const Value: Double    ); begin SetFloatField('EmployeeEarningsYtd' , Value);end;
procedure Temployeedetails_vs1.SetEmployeeNextPayDay  (const Value: TDateTime ); begin SetDateTimeField('EmployeeNextPayDay'   , Value);end;


initialization
  RegisterClass(Temployeedetails_vs1);


end.
