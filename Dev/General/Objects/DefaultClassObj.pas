unit DefaultClassObj;

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 14/04/05 1.00.00  DJH  Added the ShipToAddress Property which the address
  //                        can be set in the frmClassFrm


interface

uses
  DB, Classes;

type
  TDefaultClassObj = class(TObject)
  private
    fiClassID: integer;
    fsFirstColumn, fsSecondColumn,
    fsThirdColumn, fsAllocationBatchnoName, fsAllocationExpiryDateName, fsEquipmentName,fsHireName,fsAllocationTruckLoadNoName,fsPartColumn,fsCustomerColumnName,fsSupplierColumnName,fsProspectColumnName,
    fsDefaultClassName,fsDefaultUOM, fsClassHeading: string;
    fsShipToAddress: string;
    function EmpdefaultClasExists: Boolean;

  public
    constructor Create;

    procedure PopulateMe;
    property ClassID: integer read fiClassID write fiClassID;
    property FirstColumn: string read fsFirstColumn write fsFirstColumn;
    property SecondColumn: string read fsSecondColumn write fsSecondColumn;
    property ThirdColumn: string read fsThirdColumn write fsThirdColumn;
    property AllocationBatchnoName: string read fsAllocationBatchnoName write fsAllocationBatchnoName;
    property AllocationExpiryDateName: string read fsAllocationExpiryDateName write fsAllocationExpiryDateName;
    property AllocationTruckLoadNoName: string read fsAllocationTruckLoadNoName write fsAllocationTruckLoadNoName;
    property EquipmentName: string read fsEquipmentName write fsEquipmentName;
    property HireName: string read fsHireName write fsHireName;
    property PartColumn: string read fsPartColumn write fsPartColumn;
    property CustomerColumnName: string read fsCustomerColumnName write fsCustomerColumnName;
    property SupplierColumnName: string read fsSupplierColumnName write fsSupplierColumnName;
    property ProspectColumnName: string read fsProspectColumnName write fsProspectColumnName;
    property DefaultClassName: string read fsDefaultClassName write fsDefaultClassName;
    property DefaultUOM: string read fsDefaultUOM write fsDefaultUOM;
    property ClassHeading: string read fsClassHeading write fsClassHeading;
    property ShipToAddress: string read fsShipToAddress write fsShipToAddress;
  end;


implementation

uses
  MyAccess,ERPdbComponents,  CommonDbLib, AppEnvironment, sysutils, tcConst;

function TDefaultClassObj.EmpdefaultClasExists:Boolean;
begin
  with TERPQuery.Create(nil) do try
      Connection := CommonDbLib.GetSharedMyDacConnection;
      SQL.Add('Select className, active  from tblclass where classId = ' + inttostr( AppEnv.Employee.DefaultClassID));
      open;
      result := (recordcount =1) and (FieldByname('Active').AsBoolean);
  finally
    ClosenFree;
  end;

end;
procedure TDefaultClassObj.PopulateMe;
begin
  Inherited;
  if not CommonDbLib.GetSharedMyDacConnection.Connected then exit;

  with TERPQuery.Create(nil) do try
      Connection := CommonDbLib.GetSharedMyDacConnection;
      Sql.Add('SELECT FirstColumn, SecondColumnName, ThirdColumnName, AllocationBatchnoName, AllocationExpiryDateName,AllocationTruckLoadNoName,'+
                //'EquipmentName,'+
                'HireName,PartColumnName,CustomerColumnName,SupplierColumnName,ProspectColumnName,');
      Sql.Add('DefaultClass,DefaultUOM, ClassID as DefaultClassID, ClassHeading, tblclass.UseAddress, ');
      Sql.Add('tblclass.Street, tblclass.Street2, tblclass.Suburb, tblclass.State, tblclass.Postcode');
      Sql.Add('FROM tblColumnHeadings');
      Sql.Add('INNER JOIN tblclass on DefaultClass = ClassName');
      Open;

      while not Eof do begin
        fsFirstColumn := FieldByName('FirstColumn').AsString;
        fsSecondColumn := FieldByName('SecondColumnName').AsString;
        fsThirdColumn := FieldByName('ThirdColumnName').AsString;
        fsAllocationBatchnoName := FieldByName('AllocationBatchnoName').AsString;
        fsAllocationExpiryDateName := FieldByName('AllocationExpiryDateName').AsString;
        fsAllocationTruckLoadNoName := FieldByName('AllocationTruckLoadNoName').AsString;
        //fsEquipmentName := FieldByName('EquipmentName').AsString;
        fsHireName := FieldByName('HireName').AsString;
        fsdefaultUOM := FieldByName('defaultUOM').AsString;

        if fsFirstColumn = '' then fsFirstColumn := 'Col 1';
        if fsSecondColumn = '' then fsSecondColumn := 'Col 2';
        if fsThirdColumn = '' then fsThirdColumn := 'Col 3';
        if fsAllocationBatchnoName = '' then fsAllocationBatchnoName := 'Batch No';
        if fsAllocationExpiryDateName = '' then fsAllocationExpiryDateName := 'Expiry Date';
        if fsAllocationTruckLoadNoName = '' then fsAllocationTruckLoadNoName := 'Truck Load No';
        if fsEquipmentName = '' then fsEquipmentName := 'Equipment';
        if fsHireName = '' then fsHireName := 'Hire';

        fsPartColumn := FieldByName('PartColumnName').AsString;if fsPartColumn = '' then fsPartColumn := 'Product';  if fsPartColumn = '' then fsPartColumn := 'Product ID';
        fsCustomerColumnName := FieldByName('CustomerColumnName').AsString;if fsCustomerColumnName = '' then fsCustomerColumnName := 'Customer';if fsCustomerColumnName = '' then fsCustomerColumnName := 'Customer ID';
        fsSupplierColumnName := FieldByName('SupplierColumnName').AsString;if fsSupplierColumnName = '' then fsSupplierColumnName := 'Supplier';if fsSupplierColumnName = '' then fsSupplierColumnName := 'Supplier ID';
        fsProspectColumnName := FieldByName('ProspectColumnName').AsString;if fsProspectColumnName = '' then fsProspectColumnName := 'Prospect';if fsProspectColumnName = '' then fsProspectColumnName := 'Prospect ID';

        // Does this employee have a default class set?
        if AppEnv.Employee.DefaultClassID = 0 then begin
          // No, then standard default.
          fiClassID := FieldByName('DefaultClassID').AsInteger;
          fsDefaultClassName := GetClassName(FieldByName('DefaultClassID').AsInteger);
        end else if   not (EmpdefaultClasExists) then begin
          //MessageDlgXP_vista(AppEnv.Employee.EmployeeName+'''s Default ' + Appenv.DefaultClass.ClassHeading +' ' + Quotedstr(AppEnv.Employee.DefaultClassName) +' is either inactive or doesn''t exists.  Please fix this problem', mtWarning, [mbOK], 0);
          fiClassID := FieldByName('DefaultClassID').AsInteger;
          fsDefaultClassName := GetClassName(FieldByName('DefaultClassID').AsInteger);
        end else begin
          // Yes, then load their class name and set it.
          fsDefaultClassName := AppEnv.Employee.DefaultClassName;
          fiClassID := AppEnv.Employee.DefaultClassID;
        end;

        fsClassHeading := FieldByName('ClassHeading').AsString;
        Next;
      end;
      if fsClassHeading = '' then fsClassHeading := 'Class';

      // Here we need to determine if the class has an address
      // that needs to be used in the shipto address.  If so,
      // we will construct the address information here.
      if FieldByName('UseAddress').AsBoolean then begin
        fsShipToAddress := GetCompanyName + #13#10 + FieldByName('Street').AsString + #13#10 +
          FieldByName('Street2').AsString + #13#10 + FieldByName('Suburb').AsString + '  ' +
          FieldByName('State').AsString + '  ' + FieldByName('PostCode').AsString;
      end else begin
        fsShipToAddress := '';
      end;

    finally
//      DEFAULT_UOM := defaultUOM;
      Free;
    end;
end;

constructor TDefaultClassObj.Create;
begin
  inherited;
  PopulateMe;
end;

end.
