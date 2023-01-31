unit BusObjEmployeeAttachment;

interface

uses
  Classes, BusObjBase, BusObjAttachment;

type

  TEmployeeAttachment = class(TAttachment)
  private
    function GetEmployeeName: string;
    procedure SetEmployeeName(const Value: string);
  protected
    procedure SetTableName(const Value: string); override;
    function GetTableName: string; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
  published
  public
    constructor Create(AOwner: TComponent); override;
    function ValidateData: Boolean; override;
    { move these 2 props from publised to public }
    property TableName;
    property TableId;
  published
    property EmployeeName: string read GetEmployeeName write SetEmployeeName;
  end;

implementation

uses
  BusObjEmployee;

{ TEmployeeAttachment }

constructor TEmployeeAttachment.Create(AOwner: TComponent);
begin
  inherited;
  fBusObjectTypeDescription := 'EmployeeAttachment';
  fSQL := 'SELECT * FROM tblattachments where TableName = "tblemployees"';
  ExportExcludeList.Add('tablename');
  ExportExcludeList.Add('tableid');
end;

function TEmployeeAttachment.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
  SetStringField('TableName','tblemployees');
end;

function TEmployeeAttachment.GetEmployeeName: string;
begin
  result := TEmployee.IDToggle(TableId, Connection.Connection);
end;

function TEmployeeAttachment.GetTableName: string;
begin
  result := 'tblemployees';
end;

procedure TEmployeeAttachment.SetEmployeeName(const Value: string);
begin
  TableID := TEmployee.IDToggle(Value, Connection.Connection);
end;

procedure TEmployeeAttachment.SetTableName(const Value: string);
begin
  { don't allow change }
end;

function TEmployeeAttachment.ValidateData: Boolean;
begin
  result := false;
  if TableId = 0 then begin
    AddResult(False, rssError, 0, 'Employee should not be blank.');
    exit;
  end;
  result := inherited;
end;

initialization
  RegisterClass(TEmployeeAttachment);

end.
