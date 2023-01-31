unit PaidLeave;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  02/04/22  1.00.00  AT  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  Tpaidleave = class(TMSBusObj)
  private
    function GetLeavePaidName                    : string    ;
    function GetLeavePaidUnits                   : string    ;
    function GetLeavePaidLeaveLoadingRate        : string    ;
    function GetLeavePaidNormalEntitlement       : string    ;
    function GetLeavePaidShowBalanceOnPayslip    : Boolean   ;
    function GetLeavePaidActive                  : Boolean   ;
    procedure SetLeavePaidName                    (const Value: string    );
    procedure SetLeavePaidUnits                   (const Value: string    );
    procedure SetLeavePaidLeaveLoadingRate        (const Value: string    );
    procedure SetLeavePaidNormalEntitlement       (const Value: string    );
    procedure SetLeavePaidShowBalanceOnPayslip    (const Value: Boolean   );
    procedure SetLeavePaidActive                  (const Value: Boolean   );
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
    property LeavePaidName                     :string      read GetLeavePaidName                   write SetLeavePaidName                ;
    property LeavePaidUnits                    :string      read GetLeavePaidUnits                  write SetLeavePaidUnits               ;
    property LeavePaidLeaveLoadingRate         :string      read GetLeavePaidLeaveLoadingRate       write SetLeavePaidLeaveLoadingRate    ;
    property LeavePaidNormalEntitlement        :string      read GetLeavePaidNormalEntitlement      write SetLeavePaidNormalEntitlement   ;
    property LeavePaidShowBalanceOnPayslip     :Boolean     read GetLeavePaidShowBalanceOnPayslip   write SetLeavePaidShowBalanceOnPayslip;
    property LeavePaidActive                   :Boolean     read GetLeavePaidActive                 write SetLeavePaidActive              ;
  end;


implementation


uses tcDataUtils, CommonLib;



  {Tpaidleave}

constructor Tpaidleave.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'paidleave';
  fSQL := 'SELECT * FROM tblpaidleave';
end;


destructor Tpaidleave.Destroy;
begin
  inherited;
end;


procedure Tpaidleave.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'LeavePaidName');
  SetPropertyFromNode(node,'LeavePaidUnits');
  SetPropertyFromNode(node,'LeavePaidLeaveLoadingRate');
  SetPropertyFromNode(node,'LeavePaidNormalEntitlement');
  SetBooleanPropertyFromNode(node,'LeavePaidShowBalanceOnPayslip');
  SetBooleanPropertyFromNode(node,'LeavePaidActive');
end;


procedure Tpaidleave.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'LeavePaidName' ,LeavePaidName);
  AddXMLNode(node,'LeavePaidUnits' ,LeavePaidUnits);
  AddXMLNode(node,'LeavePaidLeaveLoadingRate' ,LeavePaidLeaveLoadingRate);
  AddXMLNode(node,'LeavePaidNormalEntitlement' ,LeavePaidNormalEntitlement);
  AddXMLNode(node,'LeavePaidShowBalanceOnPayslip' ,LeavePaidShowBalanceOnPayslip);
  AddXMLNode(node,'LeavePaidActive' ,LeavePaidActive);
end;


function Tpaidleave.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Tpaidleave.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tpaidleave.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tpaidleave.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Tpaidleave.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tpaidleave.GetIDField: string;
begin
  Result := 'ID'
end;


class function Tpaidleave.GetBusObjectTablename: string;
begin
  Result:= 'tblpaidleave';
end;


function Tpaidleave.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Tpaidleave.GetLeavePaidName                : string    ; begin Result := GetStringField('LeavePaidName');end;
function  Tpaidleave.GetLeavePaidUnits               : string    ; begin Result := GetStringField('LeavePaidUnits');end;
function  Tpaidleave.GetLeavePaidLeaveLoadingRate    : string    ; begin Result := GetStringField('LeavePaidLeaveLoadingRate');end;
function  Tpaidleave.GetLeavePaidNormalEntitlement   : string    ; begin Result := GetStringField('LeavePaidNormalEntitlement');end;
function  Tpaidleave.GetLeavePaidShowBalanceOnPayslip: Boolean   ; begin Result := GetBooleanField('LeavePaidShowBalanceOnPayslip');end;
function  Tpaidleave.GetLeavePaidActive              : Boolean   ; begin Result := GetBooleanField('LeavePaidActive');end;
procedure Tpaidleave.SetLeavePaidName                (const Value: string    ); begin SetStringField('LeavePaidName'                 , Value);end;
procedure Tpaidleave.SetLeavePaidUnits               (const Value: string    ); begin SetStringField('LeavePaidUnits'                , Value);end;
procedure Tpaidleave.SetLeavePaidLeaveLoadingRate    (const Value: string    ); begin SetStringField('LeavePaidLeaveLoadingRate'     , Value);end;
procedure Tpaidleave.SetLeavePaidNormalEntitlement   (const Value: string    ); begin SetStringField('LeavePaidNormalEntitlement'    , Value);end;
procedure Tpaidleave.SetLeavePaidShowBalanceOnPayslip(const Value: Boolean   ); begin SetBooleanField('LeavePaidShowBalanceOnPayslip' , Value);end;
procedure Tpaidleave.SetLeavePaidActive              (const Value: Boolean   ); begin SetBooleanField('LeavePaidActive'               , Value);end;


initialization
  RegisterClass(Tpaidleave);


end.
