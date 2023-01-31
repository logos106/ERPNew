unit PayrollNotes;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  03/04/22  1.00.00  AT  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  Tpayrollnotes_vs1 = class(TMSBusObj)
  private
    function GetPayrollSettingsNote        : string    ;
    function GetPayrollSettingsNoteDate    : TDateTime ;
    function GetPayrollSettingsNoteUser    : string    ;
    procedure SetPayrollSettingsNote        (const Value: string    );
    procedure SetPayrollSettingsNoteDate    (const Value: TDateTime );
    procedure SetPayrollSettingsNoteUser    (const Value: string    );
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
    property PayrollSettingsNote         :string      read GetPayrollSettingsNote       write SetPayrollSettingsNote    ;
    property PayrollSettingsNoteDate     :TDateTime   read GetPayrollSettingsNoteDate   write SetPayrollSettingsNoteDate;
    property PayrollSettingsNoteUser     :string      read GetPayrollSettingsNoteUser   write SetPayrollSettingsNoteUser;
  end;


implementation


uses tcDataUtils, CommonLib;



  {Tpayrollnotes_vs1}

constructor Tpayrollnotes_vs1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'payrollnotes_vs1';
  fSQL := 'SELECT * FROM tblpayrollnotes_vs1';
end;


destructor Tpayrollnotes_vs1.Destroy;
begin
  inherited;
end;


procedure Tpayrollnotes_vs1.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'PayrollSettingsNote');
  SetDateTimePropertyFromNode(node,'PayrollSettingsNoteDate');
  SetPropertyFromNode(node,'PayrollSettingsNoteUser');
end;


procedure Tpayrollnotes_vs1.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'PayrollSettingsNote' ,PayrollSettingsNote);
  AddXMLNode(node,'PayrollSettingsNoteDate' ,PayrollSettingsNoteDate);
  AddXMLNode(node,'PayrollSettingsNoteUser' ,PayrollSettingsNoteUser);
end;


function Tpayrollnotes_vs1.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Tpayrollnotes_vs1.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tpayrollnotes_vs1.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tpayrollnotes_vs1.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Tpayrollnotes_vs1.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tpayrollnotes_vs1.GetIDField: string;
begin
  Result := 'PayrollNotesID'
end;


class function Tpayrollnotes_vs1.GetBusObjectTablename: string;
begin
  Result:= 'tblpayrollnotes_vs1';
end;


function Tpayrollnotes_vs1.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Tpayrollnotes_vs1.GetPayrollSettingsNote    : string    ; begin Result := GetStringField('PayrollSettingsNote');end;
function  Tpayrollnotes_vs1.GetPayrollSettingsNoteDate: TDateTime ; begin Result := GetDateTimeField('PayrollSettingsNoteDate');end;
function  Tpayrollnotes_vs1.GetPayrollSettingsNoteUser: string    ; begin Result := GetStringField('PayrollSettingsNoteUser');end;
procedure Tpayrollnotes_vs1.SetPayrollSettingsNote    (const Value: string    ); begin SetStringField('PayrollSettingsNote'     , Value);end;
procedure Tpayrollnotes_vs1.SetPayrollSettingsNoteDate(const Value: TDateTime ); begin SetDateTimeField('PayrollSettingsNoteDate' , Value);end;
procedure Tpayrollnotes_vs1.SetPayrollSettingsNoteUser(const Value: string    ); begin SetStringField('PayrollSettingsNoteUser' , Value);end;


initialization
  RegisterClass(Tpayrollnotes_vs1);


end.
