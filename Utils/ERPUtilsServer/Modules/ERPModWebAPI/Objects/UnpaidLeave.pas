unit UnpaidLeave;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  02/04/22  1.00.00  AT  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  Tunpaidleave = class(TMSBusObj)
  private
    function GetLeaveUnpaidName                    : string    ;
    function GetLeaveUnpaidUnits                   : string    ;
    function GetLeaveUnpaidLeaveLoadingRate        : string    ;
    function GetLeaveUnpaidNormalEntitlement       : string    ;
    function GetLeaveUnpaidShowBalanceOnPayslip    : Boolean   ;
    function GetLeaveUnpaidActive                  : Boolean   ;
    procedure SetLeaveUnpaidName                    (const Value: string    );
    procedure SetLeaveUnpaidUnits                   (const Value: string    );
    procedure SetLeaveUnpaidLeaveLoadingRate        (const Value: string    );
    procedure SetLeaveUnpaidNormalEntitlement       (const Value: string    );
    procedure SetLeaveUnpaidShowBalanceOnPayslip    (const Value: Boolean   );
    procedure SetLeaveUnpaidActive                  (const Value: Boolean   );
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
    property LeaveUnpaidName                     :string      read GetLeaveUnpaidName                   write SetLeaveUnpaidName                ;
    property LeaveUnpaidUnits                    :string      read GetLeaveUnpaidUnits                  write SetLeaveUnpaidUnits               ;
    property LeaveUnpaidLeaveLoadingRate         :string      read GetLeaveUnpaidLeaveLoadingRate       write SetLeaveUnpaidLeaveLoadingRate    ;
    property LeaveUnpaidNormalEntitlement        :string      read GetLeaveUnpaidNormalEntitlement      write SetLeaveUnpaidNormalEntitlement   ;
    property LeaveUnpaidShowBalanceOnPayslip     :Boolean     read GetLeaveUnpaidShowBalanceOnPayslip   write SetLeaveUnpaidShowBalanceOnPayslip;
    property LeaveUnpaidActive                   :Boolean     read GetLeaveUnpaidActive                 write SetLeaveUnpaidActive              ;
  end;


implementation


uses tcDataUtils, CommonLib;



  {Tunpaidleave}

constructor Tunpaidleave.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'unpaidleave';
  fSQL := 'SELECT * FROM tblunpaidleave';
end;


destructor Tunpaidleave.Destroy;
begin
  inherited;
end;


procedure Tunpaidleave.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'LeaveUnpaidName');
  SetPropertyFromNode(node,'LeaveUnpaidUnits');
  SetPropertyFromNode(node,'LeaveUnpaidLeaveLoadingRate');
  SetPropertyFromNode(node,'LeaveUnpaidNormalEntitlement');
  SetBooleanPropertyFromNode(node,'LeaveUnpaidShowBalanceOnPayslip');
  SetBooleanPropertyFromNode(node,'LeaveUnpaidActive');
end;


procedure Tunpaidleave.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'LeaveUnpaidName' ,LeaveUnpaidName);
  AddXMLNode(node,'LeaveUnpaidUnits' ,LeaveUnpaidUnits);
  AddXMLNode(node,'LeaveUnpaidLeaveLoadingRate' ,LeaveUnpaidLeaveLoadingRate);
  AddXMLNode(node,'LeaveUnpaidNormalEntitlement' ,LeaveUnpaidNormalEntitlement);
  AddXMLNode(node,'LeaveUnpaidShowBalanceOnPayslip' ,LeaveUnpaidShowBalanceOnPayslip);
  AddXMLNode(node,'LeaveUnpaidActive' ,LeaveUnpaidActive);
end;


function Tunpaidleave.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Tunpaidleave.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tunpaidleave.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tunpaidleave.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Tunpaidleave.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tunpaidleave.GetIDField: string;
begin
  Result := 'ID'
end;


class function Tunpaidleave.GetBusObjectTablename: string;
begin
  Result:= 'tblunpaidleave';
end;


function Tunpaidleave.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Tunpaidleave.GetLeaveUnpaidName                : string    ; begin Result := GetStringField('LeaveUnpaidName');end;
function  Tunpaidleave.GetLeaveUnpaidUnits               : string    ; begin Result := GetStringField('LeaveUnpaidUnits');end;
function  Tunpaidleave.GetLeaveUnpaidLeaveLoadingRate    : string    ; begin Result := GetStringField('LeaveUnpaidLeaveLoadingRate');end;
function  Tunpaidleave.GetLeaveUnpaidNormalEntitlement   : string    ; begin Result := GetStringField('LeaveUnpaidNormalEntitlement');end;
function  Tunpaidleave.GetLeaveUnpaidShowBalanceOnPayslip: Boolean   ; begin Result := GetBooleanField('LeaveUnpaidShowBalanceOnPayslip');end;
function  Tunpaidleave.GetLeaveUnpaidActive              : Boolean   ; begin Result := GetBooleanField('LeaveUnpaidActive');end;
procedure Tunpaidleave.SetLeaveUnpaidName                (const Value: string    ); begin SetStringField('LeaveUnpaidName'                 , Value);end;
procedure Tunpaidleave.SetLeaveUnpaidUnits               (const Value: string    ); begin SetStringField('LeaveUnpaidUnits'                , Value);end;
procedure Tunpaidleave.SetLeaveUnpaidLeaveLoadingRate    (const Value: string    ); begin SetStringField('LeaveUnpaidLeaveLoadingRate'     , Value);end;
procedure Tunpaidleave.SetLeaveUnpaidNormalEntitlement   (const Value: string    ); begin SetStringField('LeaveUnpaidNormalEntitlement'    , Value);end;
procedure Tunpaidleave.SetLeaveUnpaidShowBalanceOnPayslip(const Value: Boolean   ); begin SetBooleanField('LeaveUnpaidShowBalanceOnPayslip' , Value);end;
procedure Tunpaidleave.SetLeaveUnpaidActive              (const Value: Boolean   ); begin SetBooleanField('LeaveUnpaidActive'               , Value);end;


initialization
  RegisterClass(Tunpaidleave);


end.
