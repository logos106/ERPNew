unit BusObjRep;

interface

uses
  BusObjEmployee, BusObjBase, Classes, BusObjRepServices;

type
  TRep = class(TEmployee)
  private
    function GetRepServices: TRepServices;
  protected
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    procedure InitializeNewObject; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Services: TRepServices read GetRepServices;
  end;


implementation

uses
  CommonLib, sysutils;

{ TRep }

constructor TRep.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := 'SELECT * FROM tblemployees where `Rep` = "T"';
end;

function TRep.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  self.InitializeNewObject;
end;

function TRep.GetRepServices: TRepServices;
begin
  result:= TRepServices(GetContainerComponent(TRepServices,'EmployeeID = ' + IntToStr(ID)));
end;

procedure TRep.InitializeNewObject;
begin
  inherited;
  self.Rep := true;
end;

initialization

RegisterClassOnce(TRep);

end.
