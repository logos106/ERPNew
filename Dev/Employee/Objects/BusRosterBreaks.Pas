unit BusRosterBreaks;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  16/04/15  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TRosterBreak = class(TMSBusObj)
  private
    function GetEmployeeID          : Integer   ;
    function GetRosterID            : Integer   ;
    function GetRosterBreaktype     : string    ;
    function GetStarttime           : TDateTime ;
    function GetEndtime             : TDateTime ;
    procedure SetEmployeeID          (const Value: Integer   );
    procedure SetRosterID            (const Value: Integer   );
    procedure SetRosterBreaktype     (const Value: string    );
    procedure SetStarttime           (const Value: TDateTime );
    procedure SetEndtime             (const Value: TDateTime );
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
    property EmployeeID           :Integer     read GetEmployeeID         write SetEmployeeID      ;
    property RosterID             :Integer     read GetRosterID           write SetRosterID        ;
    property RosterBreaktype      :string      read GetRosterBreaktype    write SetRosterBreaktype ;
    property Starttime            :TDateTime   read GetStarttime          write SetStarttime       ;
    property Endtime              :TDateTime   read GetEndtime            write SetEndtime         ;
  end;
  TCurrentRosterBreak = class(TRosterBreak)
    Private
    Protected
      function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;             override;
    Public
      constructor  Create(AOwner: TComponent);                            override;
  end;

implementation


uses tcDataUtils, CommonLib, BusObjRoster;



  {TRosterBreak}

constructor TRosterBreak.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'RosterBreak';
  fSQL := 'SELECT * FROM tblrosterbreak';
end;


destructor TRosterBreak.Destroy;
begin
  inherited;
end;


procedure TRosterBreak.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'EmployeeID');
  SetPropertyFromNode(node,'RosterID');
  SetPropertyFromNode(node,'RosterBreaktype');
  SetDateTimePropertyFromNode(node,'Starttime');
  SetDateTimePropertyFromNode(node,'Endtime');
end;


procedure TRosterBreak.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
  AddXMLNode(node,'RosterID' ,RosterID);
  AddXMLNode(node,'RosterBreaktype' ,RosterBreaktype);
  AddXMLNode(node,'Starttime' ,Starttime);
  AddXMLNode(node,'Endtime' ,Endtime);
end;


function TRosterBreak.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if EmployeeID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'EmployeeID should not be 0' , False );
    Exit;
  end;
  if RosterID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'RosterID should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function TRosterBreak.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TRosterBreak.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TRosterBreak.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TRosterBreak.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TRosterBreak.GetIDField: string;
begin
  Result := 'RosterBreakId'
end;


class function TRosterBreak.GetBusObjectTablename: string;
begin
  Result:= 'tblrosterbreak';
end;


function TRosterBreak.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TRosterBreak.GetEmployeeID      : Integer   ; begin Result := GetIntegerField('EmployeeID');end;
function  TRosterBreak.GetRosterID        : Integer   ; begin Result := GetIntegerField('RosterID');end;
function  TRosterBreak.GetRosterBreaktype : string    ; begin Result := GetStringField('RosterBreaktype');end;
function  TRosterBreak.GetStarttime       : TDateTime ; begin Result := GetDateTimeField('Starttime');end;
function  TRosterBreak.GetEndtime         : TDateTime ; begin Result := GetDateTimeField('Endtime');end;
procedure TRosterBreak.SetEmployeeID      (const Value: Integer   ); begin SetIntegerField('EmployeeID'       , Value);end;
procedure TRosterBreak.SetRosterID        (const Value: Integer   ); begin SetIntegerField('RosterID'         , Value);end;
procedure TRosterBreak.SetRosterBreaktype (const Value: string    ); begin SetStringField('RosterBreaktype' , Value);end;
procedure TRosterBreak.SetStarttime       (const Value: TDateTime ); begin SetDateTimeField('Starttime'        , Value);end;
procedure TRosterBreak.SetEndtime         (const Value: TDateTime ); begin SetDateTimeField('Endtime'          , Value);end;


{ TCurrentRosterBreak }

constructor TCurrentRosterBreak.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := 'SELECT * FROM tblrosterbreak where ifnull(Endtime,0)= "1899-12-30 00:00:00"';
  NullWhenDateIs0           := False;
end;

function TCurrentRosterBreak.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  Starttime :=0;
  Endtime :=0;
  if Assigned(Owner) then
    if Owner is TRoster then
      RosterID := TRoster(Owner).ID;
end;

initialization
  RegisterClass(TRosterBreak);


end.
