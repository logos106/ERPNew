unit PayEmployeeDetailsObj;

interface

uses
  Classes, DB;

type
  TEmployeeDetails = class(TObject)
  private
    foOwner: TObject;
    fsEmployeeName: string;
    fsTaxFileNumber: string;
    fdDOB: TDateTime;
    fsSex: string; {Male , Female}
    fdtDateStarted: TDateTime;
    fsEmployeeNo: string;
    fsStreet: string;
    fsStreet2: string;
    fsSuburb: string;
    fsState: string;
    fsPostcode: string;
    fbIsTerminated: boolean;
  public
    procedure PopulateMe;
    constructor Create(const Owner: TObject);
    property Owner: TObject read foOwner;
    property EmployeeName: string read fsEmployeeName;
    property TaxFileNumber: string read fsTaxFileNumber;
    property DOB: TDateTime read fdDOB;
    property Sex: string read fsSex;
    property DateStarted: TDateTime read fdtDateStarted;
    property EmployeeNo: string read fsEmployeeNo;
    property Street: string read fsStreet;
    property Street2: string read fsStreet2;
    property Suburb: string read fsSuburb;
    property State: string read fsState;
    property Postcode: string read fsPostcode;
    property IsTerminated: boolean read fbIsTerminated;
  end;

implementation
  
uses PayCommon, PayObj;

{ TEmployeeDetails }

constructor TEmployeeDetails.Create(const Owner: TObject);
begin
  inherited Create;
  foOwner := Owner;
end;

procedure TEmployeeDetails.PopulateMe;
begin
  if DatasetOk(TPayObj(Self.Owner).Employee.DataSet) then begin
    with TPayObj(Self.Owner).Employee.DataSet do begin
      fsEmployeeName := FieldByName('EmployeeName').AsString;
      fsTaxFileNumber := FieldByName('TFN').AsString;
      fdDOB := FieldByName('DOB').AsDateTime;
      fsSex := FieldByName('Sex').AsString;
      fdtDateStarted := FieldByName('DateStarted').AsDateTime;
      fsEmployeeNo := FieldByName('EmployeeNo').AsString;
      fsStreet := FieldByName('Street').AsString;
      fsStreet2 := FieldByName('Street2').AsString;
      fsSuburb := FieldByName('Suburb').AsString;
      fsState := FieldByName('State').AsString;
      fsPostcode := FieldByName('Postcode').AsString;
      fbIsTerminated := (FieldByName('IsTerminated').AsString = 'T');
    end;
  end;
end;

end.
