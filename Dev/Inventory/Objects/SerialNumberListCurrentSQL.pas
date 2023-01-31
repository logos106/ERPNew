unit SerialNumberListCurrentSQL;

interface
uses
  classes, ReportBaseObj, Types, UserLockObj, UserLockBaseObj;

type

  TSerialNumberListCurrentReport = class(TReportBase)
  private
    fUserLock, fOwnedUserLock: TUserLock;
    fsSerialNumber: String;
    fiProductId: Integer;
    fiDepartmentID: Integer;
    fsAllocType: String;
    fdStatusDate: TDatetime;
    function GetTempTableName: string;
    function GetUserLock: TUserLock;
    procedure SetUserLock(const Value: TUserLock);
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    property TempTableName: string read GetTempTableName;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
    property UserLock: TUserLock read GetUserLock write SetUserLock;
  published
    Property ProductId :Integer read fiProductId write fiProductId;
    Property AllocType : String read fsAllocType write fsAllocType;
    Property DepartmentID :Integer read fiDepartmentID write fiDepartmentID;
    Property SerialNumber :String read fsSerialNumber write fsSerialNumber;
    Property StatusDate :TDatetime read fdStatusDate write fdStatusDate;
  end;


implementation

uses
  SysUtils, BarcodeConst, ProductQtyLib, ERPDbComponents, MySQLConst;

{ TSerialNumberListCurrentReport }

constructor TSerialNumberListCurrentReport.Create;
begin
  inherited;
  fUserLock := nil;
  fOwnedUserLock := nil;
  fsSerialNumber:='';
  fiProductId:=0;
  fiDepartmentID:=0;
  fsAllocType:='';
  fdStatusDate :=0;

end;

destructor TSerialNumberListCurrentReport.Destroy;
begin
  fOwnedUserLock.Free;
  inherited;
end;

function TSerialNumberListCurrentReport.GetTempTableName: string;
begin
  result := 'tblSerial_number_List';
end;

function TSerialNumberListCurrentReport.GetUserLock: TUserLock;
begin
  if Assigned(fUserLock) then
    result := fUserLock
  else begin
    if not Assigned(fOwnedUserLock) then
      fOwnedUserLock := TUserLock.Create(nil);
    result := fOwnedUserLock;
  end;
end;

function TSerialNumberListCurrentReport.PopulateReportSQL(SQL: TStrings;
  var msg: string): boolean;
var
  cmd: TERPCommand;
begin
  result := true;
  msg := '';

  if APIMode then begin
    if Userlock.Lock(GetTempTableName,0) then begin
      cmd := TERPCommand.Create(nil);
      try
        cmd.Connection := self.SharedConnection;
        cmd.SQL.add('call Update_Serial_Number_List();');
        cmd.Execute;
      finally
       Userlock.UnLock(GetTempTableName);
       cmd.Free;
      end;
    end
    else begin
      result := false;
      msg := CustomiseLockMessage(Userlock.LockMessage,
        ['Unable to update data.' ,'accessing this record','Record has been in use'],
        ['Unable to Run the Serial Number List.', 'Running the List''Record has been running']);
      exit;
    end;
  end;

  SQL.Clear;
  SQL.add('select');
  SQL.add('P.partsID          as PartsID,');
  SQL.add('T.DepartmentID     as DepartmentID,');
  SQL.add('T.UOMID            as UOMID,');
  SQL.add('UOM.UnitName       as UOM,');
  SQL.add('UOM.Multiplier     as UOMMultiplier ,');
  SQL.add('P.PARTNAME         as ProductName ,');
  SQL.add('0                  as gLevel,');
  SQL.add(Firstcolumn + '     as ProductColumn1,');
  SQL.add(Secondcolumn + '    as ProductColumn2,');
  SQL.add(Thirdcolumn + '     as ProductColumn3,');
  SQL.add('P.PARTSDESCRIPTION as PartsDescription,');
  SQL.add('C.classname        as ClassName,');
  SQL.add('T.Batchnumber      as BatchNumber ,');
  SQL.add('T.TruckLoadNo      as TruckLoadNo ,');
  SQL.add('DATE_FORMAT(T.Expirydate , ' + QuotedStr('%d/%m/%Y') +') as cBatchExpiryDate ,');
  SQL.add('T.Expirydate       as BatchExpiryDate ,');
  SQL.add('T.binLocation      as BinLocation,');
  SQL.add('T.Binnumber        as BinNumber,');
  SQL.add('T.serialnumber     as SerialNumber,');
  SQL.add('TT.DEscription     as Description,');
  SQL.add('PQA.Transdate      as TransDate,');
  SQL.add('concat(' +Quotedstr(Barcode_Prefix_PQASN)+',''-'' ,P.PartsId,''-'' ,T.Serialnumber) as BOMSerialNumber , ');
  SQL.add('P.Barcode          as Barcode,');
  SQL.add('P.TotalQty         as Quantity,');
  SQL.add('T.status           as AllocType');
  SQL.add(' from '+ TempTableName +' T');
  SQL.add(' inner join tblunitsofmeasure UOM on T.uomid = UOM.UnitID');
  SQL.add(' inner join tblparts P on P.partsId = T.productID');
  SQL.add('inner join tblclass C on C.classid = T.DepartmentID');
  SQL.add('inner join tblpqa pqa on pqa.PQAID = t.pqaid');
  SQL.add('Left  join `tblpqatranstypes` as TT on TT.TransType = T.TransType');
  SQL.add('Where T.ProductId <>0');
  if fiProductId    <> 0  then SQL.add('and T.ProductId = '     + inttostr(fiProductId));
  if fiDepartmentId <> 0  then SQL.add('and T.DepartmentId = '  + inttostr(fiDepartmentId));
  if fsserialnumber <> '' then SQL.add('and T.serialnumber = '  + Quotedstr(fsserialnumber));
  if fsAllocType    <> '' then SQL.add('and T.status = '        + Quotedstr(fsAllocType));
  if fdStatusDate   <> 0  then SQL.add('and PQA.Transdate <= '   + quotedstr(formatdatetime(mysqldatetimeformat, fdStatusDate)));
  SQL.add('Order by Serialnumber');

  if APIMode then begin
    SQL.Insert(0,
      'select ' +
      'PartsID,' +
      'DepartmentID,' +
      'UOMID,' +
      'UOM,' +
      'UOMMultiplier,' +
      'ProductName,' +
      'ProductColumn1,' +
      'ProductColumn2,' +
      'ProductColumn3,' +
      'PartsDescription,' +
      'ClassName as DepartmentName,' +
      'BatchNumber,' +
      'TruckLoadNo,' +
      'BatchExpiryDate,' +
      'BinLocation,' +
      'BinNumber,' +
      'SerialNumber,' +
      'Description,' +
      'TransDate,' +
      'BOMSerialNumber,' +
      'Barcode,' +
      'Quantity,' +
      'AllocType from ('
    );
    SQL.add(') as T');
  end;
end;

procedure TSerialNumberListCurrentReport.SetUserLock(const Value: TUserLock);
begin
  fUserLock := Value;
end;

initialization
  RegisterClass(TSerialNumberListCurrentReport);


end.
