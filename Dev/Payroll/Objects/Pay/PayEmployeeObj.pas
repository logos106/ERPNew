unit PayEmployeeObj;

interface

uses
  Classes, DB, PayEmployeeDetailsObj, PayEmployeeSettingsObj;

type
  TPayEmployeeObj = class(TObject)
  private
    foOwner: TObject;
    fiEmployeeID: integer;
    FDSEmployee: TDataset;
    FEmployeeDetails: TEmployeeDetails;
    FEmployeeSettings: TEmployeeSettings;
  public
    constructor Create(const Owner: TObject);
    destructor Destroy; override;
    procedure PopulateMe;
    property Owner: TObject read foOwner;
    property EmployeeID: integer read fiEmployeeID write fiEmployeeID;  
    property DataSet: TDataset read FDSEmployee write FDSEmployee;
    property EmployeeDetails: TEmployeeDetails read FEmployeeDetails write FEmployeeDetails;
    property EmployeeSettings: TEmployeeSettings read FEmployeeSettings write FEmployeeSettings;
  end;

implementation
  
uses SysUtils, PayCommon;

{ TPayEmployeeObj }

constructor TPayEmployeeObj.Create(const Owner: TObject);
begin
  inherited Create;
  foOwner := Owner;
  FEmployeeDetails := TEmployeeDetails.Create(Self.Owner);
  FEmployeeSettings := TEmployeeSettings.Create(Self.Owner);
end;

destructor TPayEmployeeObj.Destroy;
begin
  FreeAndNil(FEmployeeDetails);
  FreeAndNil(FEmployeeSettings);
  inherited;
end;

procedure TPayEmployeeObj.PopulateMe;
begin
  if DatasetOk(FDSEmployee) then begin
    with FDSEmployee do begin
      fiEmployeeID := FieldByName('EmployeeID').AsInteger;
    end;
  end;
  FEmployeeDetails.PopulateMe;
  FEmployeeSettings.PopulateMe;
end;

end.
