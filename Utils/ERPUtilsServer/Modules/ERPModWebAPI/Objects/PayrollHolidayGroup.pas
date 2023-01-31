unit PayrollHolidayGroup;

{ Auto-generated: 20220624@150507.050 }
{ Special defines  }

interface

uses
  SysUtils, BusObjBase, DB, Classes, XMLDoc, XMLIntf, IdCoderMIME;

type
  TPayrollHolidayGroup = class(TMSBusObj)
  private
    function GetGroupname: String;
    function GetGroupdesc: String;

    procedure SetGroupname(const Value: String);
    procedure SetGroupdesc(const Value: String);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: String; override;
    function DoAfterPost(Sender:TDatasetBusObj): Boolean; override;
  public
    class function GetIDField: String; override;
    class function GetBusObjectTablename: String; override;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
  published
    property Groupname: String read GetGroupname write SetGroupname;
    property Groupdesc: String read GetGroupdesc write SetGroupdesc;
  end;

implementation

uses
  tcDataUtils, CommonLib;

{ TPayrollHolidayGroup }

constructor TPayrollHolidayGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBusObjectTypeDescription:= 'PayrollHolidayGroup';
  FSQL:= 'SELECT * FROM tblPayrollHolidayGroup';
end;

destructor TPayrollHolidayGroup.Destroy;
begin
  inherited;
end;

procedure TPayrollHolidayGroup.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

  SetPropertyFromNode(node, 'PayrollHolidayGroupGroupname');
  SetPropertyFromNode(node, 'PayrollHolidayGroupGroupdesc');
end;

procedure TPayrollHolidayGroup.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;

  AddXMLNode(node, 'Groupname', Groupname);
  AddXMLNode(node, 'Groupdesc', Groupdesc);
end;

function TPayrollHolidayGroup.ValidateData: Boolean;
begin
  Result:= False;
  Resultstatus.Clear;
  Result:= True;
end;

function TPayrollHolidayGroup.Save: Boolean;
begin
  Result:= False;
  if not ValidateData then
    Exit;

  Result:= inherited Save;
end;

procedure TPayrollHolidayGroup.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TPayrollHolidayGroup.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TPayrollHolidayGroup.GetSQL: String;
begin
  Result:= inherited GetSQL;
end;

class function TPayrollHolidayGroup.GetIDField: String;
begin
  Result:= 'ID';
end;

class function TPayrollHolidayGroup.GetBusObjectTablename: String;
begin
  Result:= 'tblPayrollHolidayGroup';
end;

function TPayrollHolidayGroup.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result:= inherited DoAfterPost(Sender);
end;

function TPayrollHolidayGroup.GetGroupname: String;
begin
  Result := GetStringField('Groupname');
end;

function TPayrollHolidayGroup.GetGroupdesc: String;
begin
  Result := GetStringField('Groupdesc');
end;

procedure TPayrollHolidayGroup.SetGroupname(const Value: String);
begin
  SetStringField('Groupname', Value);
end;

procedure TPayrollHolidayGroup.SetGroupdesc(const Value: String);
begin
  SetStringField('Groupdesc', Value);
end;

initialization
  RegisterClass(TPayrollHolidayGroup);

end.
