unit BusObjPublicHolidays;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  27/07/07  1.00.01  A  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TPublicHolidays = class(TMSBusObj)
  private
    function GetDay            : TDateTime ;
    function GetDescription    : string    ;
    procedure SetDay            (const Value: TDateTime );
    procedure SetDescription    (const Value: string    );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);   override;
    procedure DoFieldOnChange(Sender: TField);                           override;
    function  GetSQL: string;                                            override;
    function  DoAfterPost(Sender: TDatasetBusObj): Boolean;              override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; Override;
    constructor  Create(AOwner: TComponent);                             override;
    destructor   Destroy;                                                override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                  override;
    procedure    SaveToXMLNode(const node: IXMLNode);                    override;
    function     ValidateData: Boolean ;                                 override;
    function     Save: Boolean ;                                         override;
    function IsHoliday(const aDate: TDateTime): boolean; overload;
    function IsHoliday(const aDate: TDateTime; var Description: string): boolean; overload;
  published
    property Day             :TDateTime   read GetDay           write SetDay        ;
    property Description     :string      read GetDescription   write SetDescription;
  end;


implementation

uses
  CommonLib;






      {TPublicHolidays}

constructor TPublicHolidays.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'PublicHolidays';
  fSQL := 'SELECT * FROM tblpublicholidays';
end;


destructor TPublicHolidays.Destroy;
begin
  inherited;
end;


procedure TPublicHolidays.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Day');
  SetPropertyFromNode(node,'Description');
end;


procedure TPublicHolidays.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Day' ,Day);
  AddXMLNode(node,'Description' ,Description);
end;


function TPublicHolidays.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
  if self.Description = '' then begin
    resultStatus.AddItem(false,rssError,0,'Holiday description is missing.');
    result:= false;
  end;
end;


function TPublicHolidays.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TPublicHolidays.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TPublicHolidays.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TPublicHolidays.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TPublicHolidays.GetIDField: string;
begin
  Result := 'ID'
end;

class function TPublicHolidays.GetBusObjectTablename: string;
begin
  Result := 'tblpublicholidays';
end;

function TPublicHolidays.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property functions}
function  TPublicHolidays.GetDay        : TDateTime ; begin Result := GetDateTimeField('Day');end;
function  TPublicHolidays.GetDescription: string    ; begin Result := GetStringField('Description');end;
procedure TPublicHolidays.SetDay        (const Value: TDateTime ); begin SetDateTimeField('Day'         , Value);end;
procedure TPublicHolidays.SetDescription(const Value: string    ); begin SetStringField('Day'         , Value);end;


function TPublicHolidays.IsHoliday(const aDate: TDateTime): boolean;
begin
  result:= false;
  if Dataset.Locate('Day', Trunc(aDate), []) then begin
    result:= true;
  end;
end;

function TPublicHolidays.IsHoliday(const aDate: TDateTime;
  var Description: string): boolean;
begin
  result:= IsHoliday(aDate);
  if result then
    Description:= self.Description;
end;

initialization
  RegisterClassOnce(TPublicHolidays);


end.
