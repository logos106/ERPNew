unit DeliveryObj;

interface

uses
  Classes, SysUtils, Windows, MyAccess, DateUtils, Wwdbigrd, Grids, Wwdbgrid,
  kbmMemTable, DB, ClientDiscountObj, Dialogs;

const
  MAX_SCHEDULED_DATES = 64;

type
  PDateReturn = ^TDateReturn;
  TDateReturn = record
    Date: TDateTime;
  end;

type
  TDeliveryObj = class(TObject)
    // Private declarations
  private

    // protected declarations
  protected

    // public declarations
  public
    oClientDiscount: TClientDiscountObj;
    ScheduledTimes: array[1..MAX_SCHEDULED_DATES] of TDateTime;
    BackTimes: array[1..MAX_SCHEDULED_DATES] of TDateTime;
    constructor Create;
    destructor Destroy; override;
    function DoesCustomerHaveSequenceNumber(const iClientID: integer; const MyData: TDataSet): integer; overload;
    function DoesCustomerHaveSequenceNumber(const iClientID: integer; const sClientName: string;
      const MyData: TDataSet): boolean; overload;
    function DoesCustomerHaveSequenceNumber(const iRunID, iClientID: integer): integer; overload;
    function GetClientDeliveryNotes(const iClientID: integer): string;
    function GetClientDepositsHeld(const iClientID: integer): double;
    function GetDDTemporaryTableName: string;
    function GetInternalCompanyShipToAddress: string;
    function GetNextDeliveryDate(const iClientID, iRunID: integer): TDateTime;
    function GetNextSequenceNumber(const MyData: TDataSet): integer;
    function GetSOTemporaryTableName: string;
    function GetTotalTrackedNotReturned(const iClientID: integer; const dtDate, dtRunDate: TDateTime): double;
    function IsClientProductAlreadyOnRun(const iClientID, iRunID, iProductID: integer): boolean;
    procedure CalcScheduledBackDates(const dFreqInterval: integer; const sFreqType: string; const dtFromDate: TDateTime);
    procedure CalcScheduledDates(const dFreqInterval: integer; const sFreqType: string; const dtStartDate: TDateTime);
    procedure CreateDDTemporaryTable;
    procedure CreateSOTemporaryTable;
    procedure DeleteDDTemporaryTableContents;
    procedure DeleteSOTemporaryTableContents;
    procedure DropDDTemporaryTable;
    procedure DropSOTemporaryTable;
    procedure RecheckEnteredPrices(const MyData: TDataSet; const dtRunDate: TDateTime; const iClassID: integer);
    procedure SetNewCustomerAgainstSequenceID(const MyData: TKbmMemTable; const iSequence: integer;
      const CustomerInfo: TDataSet);
  end;

var
  Delivery: TDeliveryObj;

implementation

uses
  CommonDbLib, DNMLib, FastFuncs;

{ TDeliveryObj }

destructor TDeliveryObj.Destroy;
begin
  // Release our used objects.
  if Assigned(oClientDiscount) then
    FreeandNil(oClientDiscount);
  // Destroy our temporary tables.
  DropDDTemporaryTable;
  DropSOTemporaryTable;

  // Now destroy whatever remains via system.
  inherited;
end;

constructor TDeliveryObj.Create;
var
  iX: integer;
begin
  inherited;
  for iX := 1 to MAX_SCHEDULED_DATES do begin
    ScheduledTimes[iX] := 0;
  end;

  CreateSOTemporaryTable;
  CreateDDTemporaryTable;

  // Create our discount object.
  oClientDiscount := TClientDiscountObj.Create;
end;

function TDeliveryObj.GetNextDeliveryDate(const iClientID, iRunID: integer): TDateTime;
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  Result := 0;
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.ParamCheck := true;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT Min(NextRunDate) AS "NextRunDate" FROM tblrunslines');
    qry.SQL.Add('WHERE RunID = :xRunID AND ClientID = :xClientID AND FreqType <> ''Time Only''');
    qry.SQL.Add('GROUP BY ClientID;');
    qry.Params.ParamByName('xRunID').AsInteger    := iRunID;
    qry.Params.ParamByName('xClientID').AsInteger := iClientID;
    qry.Open;

    if qry.RecordCount > 0 then begin
      Result := qry.FieldByName('NextRunDate').AsDateTime;
    end;

    // Close query.
    qry.Close;
  finally
    // Free our used objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

procedure TDeliveryObj.CalcScheduledDates(const dFreqInterval: integer; const sFreqType: string;
  const dtStartDate: TDateTime);
var
  iX: integer;
  wDay, wMonth, wYear, wMaxDays: word;
  dtNewDate, dtTest: TDateTime;
begin
  // If the type is one time or the interval value is 0 then don't bother.
  ZeroMemory(@ScheduledTimes, SizeOf(ScheduledTimes));
  if (sFreqType = 'Time Only') or (sFreqType = '') then Exit;
  if dFreqInterval = 0 then Exit;

  // Set Base Date.
  dtNewDate := dtStartDate;

  // Calculate list of scheduled dates.
  for iX := 1 to MAX_SCHEDULED_DATES do begin
    ////////////////////////////////////////////
    // Is the interval based on Days?
    ////////////////////////////////////////////
    if sFreqType = 'Day(s)' then begin
      // Yes, set new date.
      dtNewDate := dtNewDate + dFreqInterval;

      ////////////////////////////////////////////
      // Is the interval based on weeks?
      ////////////////////////////////////////////
    end else if sFreqType = 'Week(s)' then begin
      // Yes, set new date.
      dtNewDate := dtNewDate + (dFreqInterval * 7.0);

      ////////////////////////////////////////////
      // Is the interval based on months?
      ////////////////////////////////////////////
    end else if sFreqType = 'Month(s)' then begin
      DecodeDate(dtNewDate, wYear, wMonth, wDay);
      wMonth := wMonth + dFreqInterval;
      while wMonth > 12 do begin
        Inc(wYear);
        Dec(wMonth, 12);
      end;

      // Make sure date parameters are valid.
      dtTest := EncodeDate(wYear, wMonth, 1);
      wMaxDays := DaysInMonth(dtTest);
      if wDay > wMaxDays then begin
        wDay := wMaxDays;
      end;

      // Encode new run date.
      dtNewDate := EncodeDate(wYear, wMonth, wDay);

      ////////////////////////////////////////////
      // Is the interval based on years?
      ////////////////////////////////////////////
    end else if sFreqType = 'Year(s)' then begin
      DecodeDate(dtNewDate, wYear, wMonth, wDay);
      wYear := wYear + dFreqInterval;
      dtNewDate := EncodeDate(wYear, wMonth, wDay);
    end;

    // Save new scheduled date.
    ScheduledTimes[iX] := dtNewDate;
  end;
end;

procedure TDeliveryObj.CalcScheduledBackDates(const dFreqInterval: integer; const sFreqType: string;
  const dtFromDate: TDateTime);
var
  iX, iY: integer;
  wDay, wMonth, wYear, wMaxDays: word;
  dtNewDate, dtTest: TDateTime;
begin
  // If the type is one time or the interval value is 0 then don't bother.
  ZeroMemory(@BackTimes, SizeOf(BackTimes));
  if (sFreqType = 'Time Only') or (sFreqType = '') then Exit;
  if dFreqInterval = 0 then Exit;

  // Set Base Date.
  dtNewDate := dtFromDate;

  // Calculate list of scheduled dates.
  iY := 1;
  for iX := MAX_SCHEDULED_DATES downto 1 do begin
    ////////////////////////////////////////////
    // Is the interval based on Days?
    ////////////////////////////////////////////
    if sFreqType = 'Day(s)' then begin
      // Yes, set new date.
      dtNewDate := dtNewDate - dFreqInterval;

      ////////////////////////////////////////////
      // Is the interval based on weeks?
      ////////////////////////////////////////////
    end else if sFreqType = 'Week(s)' then begin
      // Yes, set new date.
      dtNewDate := dtNewDate - (dFreqInterval * 7.0);

      ////////////////////////////////////////////
      // Is the interval based on months?
      ////////////////////////////////////////////
    end else if sFreqType = 'Month(s)' then begin
      DecodeDate(dtNewDate, wYear, wMonth, wDay);
      wMonth := wMonth - dFreqInterval;
      while wMonth < 1 do begin
        Dec(wYear);
        Inc(wMonth, 12);
      end;

      // Make sure date parameters are valid.
      dtTest := EncodeDate(wYear, wMonth, 1);
      wMaxDays := DaysInMonth(dtTest);
      if wDay > wMaxDays then begin
        wDay := wMaxDays;
      end;

      // Encode new run date.
      dtNewDate := EncodeDate(wYear, wMonth, wDay);

      ////////////////////////////////////////////
      // Is the interval based on years?
      ////////////////////////////////////////////
    end else if sFreqType = 'Year(s)' then begin
      DecodeDate(dtNewDate, wYear, wMonth, wDay);
      wYear := wYear - dFreqInterval;
      dtNewDate := EncodeDate(wYear, wMonth, wDay);
    end;

    // Save back dated scheduled date.
    BackTimes[iY] := dtNewDate;
    Inc(iY);
  end;
end;

function TDeliveryObj.IsClientProductAlreadyOnRun(const iClientID, iRunID, iProductID: integer): boolean;
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.ParamCheck := true;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT DISTINCT RunDate');
    qry.SQL.Add('FROM tbldespatchruns AS DR');
    qry.SQL.Add('INNER JOIN tbldespatchrunlines AS DRL on DR.RunID = DRL.RunID');
    qry.SQL.Add('WHERE DRL.ClientID = :xCID AND DRL.RunID = :xRID AND DRL.ProductID = :xPID');
    qry.SQL.Add('ORDER BY RunDate;');

    // Did we find the product on a scheduled run?
    if qry.RecordCount > 0 then begin
      // Yes, return true
      Result := true;
    end else begin
      // No, return false.
      Result := false;
    end;

    // Close database connection.
    qry.Close;

  finally
    // Free used objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

function TDeliveryObj.GetClientDeliveryNotes(const iClientID: integer): string;
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.paramCheck := true;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT ClientID, DeliveryNotes FROM tblclients WHERE (ClientID = :xCID);');
    qry.params.ParamByName('xCID').AsInteger := iClientID;
    qry.Open;

    if qry.RecordCount > 0 then begin
      // Fetch client delivery notes.
      Result := qry.FieldByName('DeliveryNotes').AsString;
    end else begin
      Result := '';
    end;

    qry.Close;
  finally
    // Free our used object.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

function TDeliveryObj.GetClientDepositsHeld(const iClientID: integer): double;
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.paramCheck := true;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT SUM(Deposits) AS Deposits FROM tbldespatchrunlines WHERE (ClientID = :xCID);');
    qry.params.ParamByName('xCID').AsInteger := iClientID;
    qry.Open;

    if qry.RecordCount > 0 then begin
      // Fetch client delivery notes.
      Result := qry.FieldByName('Deposits').AsFloat;
    end else begin
      Result := 0;
    end;

    qry.Close;
  finally
    // Free our used object.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

function TDeliveryObj.GetTotalTrackedNotReturned(const iClientID: integer; const dtDate, dtRunDate: TDateTime): double;
var
  qry: TMyQuery;
  wYear, wMonth, wDay: word;
  sDate, sOrigRunDate: string;
begin
  DecodeDate(dtDate, wYear, wMonth, wDay);
  sDate := FastFuncs.IntToStr(wYear) + '-' + FastFuncs.IntToStr(wMonth) + '-' + FastFuncs.IntToStr(wDay);
  DecodeDate(dtRunDate, wYear, wMonth, wDay);
  sOrigRunDate := FastFuncs.IntToStr(wYear) + '-' + FastFuncs.IntToStr(wMonth) + '-' + FastFuncs.IntToStr(wDay);

  qry := TMyQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.paramCheck := true;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT SUM(DRL.TakenQty - DRL.ReturnQty) AS "Outstanding"');
    qry.SQL.Add('FROM tbldespatchrunlines AS DRL');
    qry.SQL.Add('INNER JOIN tbldespatchruns AS DR on DR.DespatchID = DRL.DespatchID');
    qry.SQL.Add('WHERE (DRL.ClientID = :xCID AND DRL.Track = "T" AND DR.RunDate < ' + QuotedStr(sDate));
    qry.SQL.Add('AND DR.RunDate <> ' + QuotedStr(sOrigRunDate) + ');');
    qry.params.ParamByName('xCID').AsInteger := iClientID;
    qry.Open;

    if qry.RecordCount > 0 then begin
      // Fetch client delivery notes.
      Result := qry.FieldByName('Outstanding').AsFloat;
    end else begin
      Result := 0;
    end;

    qry.Close;
  finally
    // Free our used object.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

function TDeliveryObj.GetInternalCompanyShipToAddress: string;
var
  qry: TMyQuery;
begin
  Result := 'Not Specified';
  qry := TMyQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT CompanyName, Address, Address2, City, State, Postcode, ABN, PhoneNumber FROM tblCompanyInformation');
    qry.Open;

    if qry.RecordCount > 0 then begin
      Result := qry.FieldByName('CompanyName').AsString + Chr(13) + Chr(10);
      if qry.FieldByName('Address').AsString <> '' then begin
        Result := Result + qry.FieldByName('Address').AsString + Chr(13) + Chr(10);
      end;

      if qry.FieldByName('Address2').AsString <> '' then begin
        Result := Result + qry.FieldByName('Address2').AsString + Chr(13) + Chr(10);
      end;

      Result := Result + qry.FieldByName('City').AsString + ' ' + qry.FieldByName('State').AsString +
        ' ' + qry.FieldByName('Postcode').AsString + Chr(13) + Chr(10);

      Result := Result + 'ABN: ' + qry.FieldByName('ABN').AsString + Chr(13) + Chr(10);
      Result := Result + 'PH: ' + qry.FieldByName('PhoneNumber').AsString;
    end;

    qry.Close;
  finally
    // Free used objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

function TDeliveryObj.DoesCustomerHaveSequenceNumber(const iClientID: integer; const MyData: TDataSet): integer;
var
  memCopy: TKbmMemTable;
begin
  memCopy := TKbmMemTable.Create(nil);
  Result := 0;
  try
    // Get original copy of run list.
    memCopy.LoadFromDataSet(MyData, [mtcpoStructure, mtcpoProperties]);
    memCopy.Filtered := false;
    memCopy.Filter   := 'ClientID = ' + QuotedStr(FastFuncs.IntToStr(iClientID));
    memCopy.Filtered := true;

    if memCopy.RecordCount > 0 then begin
      Result := memCopy.FieldByName('Sequence').AsInteger;
    end;

  finally
    if Assigned(memCopy) then
      FreeandNil(memCopy);
  end;
end;

function TDeliveryObj.GetNextSequenceNumber(const MyData: TDataSet): integer;
var
  memCopy: TKbmMemTable;
begin
  memCopy := TKbmMemTable.Create(nil);
  try
    // Get original copy of run list.
    memCopy.LoadFromDataSet(MyData, [mtcpoStructure, mtcpoProperties]);
    memCopy.SortFields := 'Sequence';
    memCopy.Sort([]);
    memCopy.Last;
    Result := memCopy.FieldByName('Sequence').AsInteger + 1;
  finally
    if Assigned(memCopy) then
      FreeandNil(memCopy);
  end;
end;

procedure TDeliveryObj.CreateSOTemporaryTable;
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('CREATE TABLE IF NOT EXISTS `' + Self.GetSOTemporaryTableName + '` (');
    qry.SQL.Add('`ID` int(11) NOT NULL auto_increment,');
    qry.SQL.Add('`RunID` int(11) default "0",');
    qry.SQL.Add('`ClientID` int(11) default "0",');
    qry.SQL.Add('`Sequence` int(11) default "0",');
    qry.SQL.Add('`ClientName` varchar(255) default NULL,');
    qry.SQL.Add('`Address` varchar(255) default NULL,');
    qry.SQL.Add('`Phone` varchar(255) default NULL,');
    qry.SQL.Add('`Mobile` varchar(255) default NULL,');
    qry.SQL.Add('`Company` varchar(255) default NULL,');
    qry.SQL.Add('`ExcludeFrom` date default NULL,');
    qry.SQL.Add('`ExcludeTo` date default NULL,');
    qry.SQL.Add('`Exclude` enum("T","F") default "F",');
    qry.SQL.Add('`OrderQty` double default "0",');
    qry.SQL.Add('`OrderValue` double default "0",');
    qry.SQL.Add('`TakenQty` double default "0",');
    qry.SQL.Add('`TakenValue` double default "0",');
    qry.SQL.Add('`ReturnQty` double default "0",');
    qry.SQL.Add('`ProductID` int(11) default "0",');
    qry.SQL.Add('`ProductName` varchar(255) default NULL,');
    qry.SQL.Add('`TaxCode` varchar(255) default NULL,');
    qry.SQL.Add('`TaxAmount` double default "0",');
    qry.SQL.Add('`PaymentMethodID` int(11) default "0",');
    qry.SQL.Add('`PaymentMethodName` varchar(255) default NULL,');
    qry.SQL.Add('`DespatchID` int(11) default "0",');
    qry.SQL.Add('`GlobalRef` varchar(255) default NULL,');
    qry.SQL.Add('`PreferedSupp` varchar(255) default NULL,');
    qry.SQL.Add('`UnitExPrice` double default "0",');
    qry.SQL.Add('`SalesID` int(11) default "0",');
    qry.SQL.Add('`OriginalExPrice` double default "0",');
    qry.SQL.Add('`Discount` double default "0",');
    qry.SQL.Add('`Payments` double default "0",');
    qry.SQL.Add('`Deposits` double default "0",');
    qry.SQL.Add('`FreqInterval` int(11) default "0",');
    qry.SQL.Add('`FreqType` varchar(255) default NULL,');
    qry.SQL.Add('`StartDate` date default NULL,');
    qry.SQL.Add('`HistoryQty1` double default "0",');
    qry.SQL.Add('`HistoryQty2` double default "0",');
    qry.SQL.Add('`HistoryQty3` double default "0",');
    qry.SQL.Add('PRIMARY KEY  (`ID`)');
    qry.SQL.Add(') TYPE=InnoDB;');
    qry.Execute;

  finally
    // Free our used objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

procedure TDeliveryObj.CreateDDTemporaryTable;
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('CREATE TABLE IF NOT EXISTS `' + Self.GetDDTemporaryTableName + '` (');
    qry.SQL.Add('`ID` INT(11) NOT NULL AUTO_INCREMENT, `BillTo` TEXT, ');
    qry.SQL.Add('`DeliveryTo` TEXT, ');
    qry.SQL.Add('`Sequence` INT (11) DEFAULT "0", ');
    qry.SQL.Add('`FreqInterval` INT (11) DEFAULT "0", `FreqType` VARCHAR (255), ');
    qry.SQL.Add('`LastDelivery` DATE, `BottlesHeld` INT (11), `DepositHeld` DOUBLE DEFAULT "0",');
    qry.SQL.Add('`DeliveryDate` DATE, `DeliveryNotes` TEXT, `ClientName` VARCHAR (255), `Company` VARCHAR (255),');
    qry.SQL.Add('`CompanyDetails` TEXT, `Qty` DOUBLE DEFAULT "0", `Product` VARCHAR (255),');
    qry.SQL.Add('`Amount` DOUBLE DEFAULT "0", `LineTotal` DOUBLE DEFAULT "0",');
    qry.SQL.Add('`HistoryQty1` INT (11) DEFAULT "0", `HistoryQty2` INT (11) DEFAULT "0",');
    qry.SQL.Add('`HistoryQty3` INT (11) DEFAULT "0",');
    qry.SQL.Add('`Outstanding Amount` DOUBLE DEFAULT "0",`WithinTerms` DOUBLE DEFAULT "0", `UpTo30Days` DOUBLE DEFAULT "0",');
    qry.SQL.Add('`From30to60Days` DOUBLE DEFAULT "0", `From60to90Days` DOUBLE DEFAULT "0",');
    qry.SQL.Add('`Over90Days` DOUBLE DEFAULT "0", `Docket Number` VARCHAR (255),');
    qry.SQL.Add('PRIMARY KEY(`ID`))  TYPE = InnoDB');
    qry.Execute;
  finally
    // Free our used objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

procedure TDeliveryObj.DeleteSOTemporaryTableContents;
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('DELETE FROM `' + GetSOTemporaryTableName + '` WHERE (ClientID <> 0);');
    qry.Execute;
  finally
    // Free our used objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

procedure TDeliveryObj.DeleteDDTemporaryTableContents;
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('DELETE FROM `' + GetDDTemporaryTableName + '` WHERE (ID <> 0);');
    qry.Execute;
  finally
    // Free our used objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;


procedure TDeliveryObj.DropSOTemporaryTable;
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('DROP TABLE IF EXISTS `' + GetSOTemporaryTableName + '`;');
    qry.Execute;
  finally
    // Free our used objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

procedure TDeliveryObj.DropDDTemporaryTable;
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('DROP TABLE IF EXISTS `' + GetDDTemporaryTableName + '`;');
    qry.Execute;
  finally
    // Free our used objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

function TDeliveryObj.GetSOTemporaryTableName: string;
begin
  Result := 'tmp_standingorders_' + GetMachineIdentification(true, true, true, true);
end;

function TDeliveryObj.GetDDTemporaryTableName: string;
begin
  Result := 'tmp_deliverydockets_' + GetMachineIdentification(true, true, true, true);
end;

procedure TDeliveryObj.RecheckEnteredPrices(const MyData: TDataSet; const dtRunDate: TDateTime; const iClassID: integer);
var
  dIncPrice, dPriceEx, dDiscount, dQty, dTax: double;
  sDescript, msg: string;
  bm: TBookmark;
  CustomAfterPost: TDataSetNotifyEvent;
begin
  // Now we need to pass this memory table to ensure that all
  // product prices are upto date with reflection to what is
  // set within the parts table.
  if not Assigned(MyData) or not (MyData.Active) then Exit;
  bm := MyData.GetBookmark;
  //MyData.DisableControls;  // Stuff Grid with memtable

  CustomAfterPost := nil;
  if Assigned(MyData.AfterPost) then begin
    CustomAfterPost  := MyData.AfterPost;
    MyData.AfterPost := nil;
  end;

  try
    MyData.First;
    while not MyData.Eof do begin
      if MyData.FieldByName('ProductID').AsInteger <> 0 then begin
        // Calculate me an ex price.
        oClientDiscount.ClientPrice_Discounts(MyData.FieldByName('ClientID').AsInteger, 0,
          MyData.FieldByName('ProductID').AsInteger, iClassID,
          MyData.FieldByName('OrderQty').AsFloat, dtRunDate, 1, '', '', '', '', '',
          false, dPriceEx, dDiscount, sDescript, msg);

        // Throw the Editor window into edit mode.
        MyData.Edit;

        // Calculate Ex Price Less Discount.
        MyData.FieldByName('OriginalExPrice').AsFloat := dPriceEx;
        MyData.FieldByName('Discount').AsFloat := dDiscount;
        dPriceEx := dPriceEx - (dPriceEx * dDiscount);

        // Store the Unit Ex Price.
        MyData.FieldByName('UnitExPrice').AsFloat := dPriceEx;

        // Calculate Inclusive Price from Ex Price.
        dIncPrice := GetAmountInc(dPriceEx, GetTaxRate(MyData.FieldByName('TaxCode').AsString));

        dQty := MyData.FieldByName('OrderQty').AsFloat;

        // Calculate now the tax amount if any.
        dTax := (dIncPrice - dPriceEx) * dQty;

        // Store calculate Tax Amount.
        MyData.FieldByName('TaxAmount').AsFloat := dTax;

        // Calculate Total Inclusive Price.
        dIncPrice := dIncPrice * dQty;
        MyData.FieldByName('OrderValue').AsFloat := RoundCurrency(dIncPrice);

        // Post calculated results to memory table.
        MyData.Post;
      end;

      // Fetch next record.
      MyData.Next;
    end;
  finally
    if Assigned(CustomAfterPost) then MyData.AfterPost := CustomAfterPost;
  end;

  // Restore memory table record cursor position to current or first record.
  if Assigned(bm) then // Goto Bookmark.
    MyData.GotoBookmark(bm)
  else // Otherwise fetch first record.
    MyData.First;

  // Re-enable all assigned data aware controls.
  // MyData.EnableControls;
end;

procedure TDeliveryObj.SetNewCustomerAgainstSequenceID(const MyData: TKbmMemTable; const iSequence: integer;
  const CustomerInfo: TDataSet);
var
  memCopy: TKbmMemTable;
  iClientID, iContactID: integer;
  iX: integer;
begin
  iClientID := MyData.FieldByName('ClientID').AsInteger;
  iContactID := MyData.FieldByName('ContactID').AsInteger;

  //MyData.DisableControls;   // Stuff Grid with memtable
  memCopy := TkbmMemTable.Create(nil);

  try
    memCopy.LoadFromDataSet(MyData, [mtcpoStructure, mtcpoProperties, mtcpoFieldIndex]);
    memCopy.Filtered := false;
    memCopy.Filter   := 'ClientID = ' + QuotedStr(FastFuncs.IntToStr(iClientID)) + ' AND ContactID = ' + QuotedStr(FastFuncs.IntToStr(iContactID));
    memCopy.Filtered := true;
    memCopy.First;

    // Does this customer already exist within our run data?
    if memCopy.RecordCount = 0 then begin
      // No, update record only!
      MyData.Edit;
      MyData.FieldByName('Company').AsString := CustomerInfo.FieldByName('Company').AsString;
      MyData.FieldByName('ClientName').AsString := CustomerInfo.FieldByName('Customer').AsString;
      MyData.FieldByName('Address').AsString := CustomerInfo.FieldByName('Address').AsString;
      MyData.FieldByName('ClientID').AsInteger := CustomerInfo.FieldByName('ClientID').AsInteger;
      if CustomerInfo.FieldByName('Details').AsInteger = 1 then begin
        MyData.FieldByName('ContactID').AsInteger := CustomerInfo.FieldByName('ContactID').AsInteger;
        MyData.FieldByName('IsContact').AsString := 'T';
      end else begin
        MyData.FieldByName('IsContact').AsString := 'F';
        MyData.FieldByName('ContactID').AsInteger := 0;
      end;

      MyData.Post;
      memCopy.Filtered := false;
      memCopy.Filter := '';
      MyData.EnableControls;
      Exit;
      // Yes, update all relative customer records!
    end else begin
      ////////////////////////////////////////////////////////////
      // Dont use a WHILE Loop for this, it seems the memory
      // table reachs an EOF before getting past the last record.
      // Seems to be when you use a filter on a memory table.
      ////////////////////////////////////////////////////////////
      for iX := 1 to memCopy.RecordCount do begin
        memCopy.Edit;
        memCopy.FieldByName('Company').AsString := CustomerInfo.FieldByName('Company').AsString;
        memCopy.FieldByName('ClientName').AsString := CustomerInfo.FieldByName('Customer').AsString;
        memCopy.FieldByName('Address').AsString := CustomerInfo.FieldByName('Address').AsString;
        memCopy.FieldByName('ClientID').AsInteger := CustomerInfo.FieldByName('ClientID').AsInteger;
        if CustomerInfo.FieldByName('Details').AsInteger = 1 then begin
          memCopy.FieldByName('ContactID').AsInteger := CustomerInfo.FieldByName('ContactID').AsInteger;
          memCopy.FieldByName('IsContact').AsString := 'T';
        end else begin
          memCopy.FieldByName('IsContact').AsString := 'F';
          memCopy.FieldByName('ContactID').AsInteger := 0;
        end;

        memCopy.Post;

        // Fetch next record.
        memCopy.Next;
      end;
    end;

    memCopy.Filtered := false;
    memCopy.Filter   := '';

    MyData.LoadFromDataSet(memCopy, []);
    //MyData.EnableControls;

    MyData.Edit;
  finally
    // Free our used object.
    if Assigned(memCopy) then
      FreeandNil(memCopy);
  end;
end;

function TDeliveryObj.DoesCustomerHaveSequenceNumber(const iRunID, iClientID: integer): integer;
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.ParamCheck := true;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT ClientID, ClientName, Sequence FROM tblrunslines WHERE RunID = :xID AND ClientID = :xCID');
    qry.Params.ParamByName('xID').AsInteger  := iRunID;
    qry.Params.ParamByName('xCID').AsInteger := iClientID;
    qry.Open;

    if qry.RecordCount > 0 then begin
      Result := qry.FieldByName('Sequence').AsInteger;
    end else begin
      Result := 0;
    end;

  finally
    // Release our used objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

function TDeliveryObj.DoesCustomerHaveSequenceNumber(const iClientID: integer; const sClientName: string;
  const MyData: TDataSet): boolean;
var
  memCopy: TKbmMemTable;
begin
  memCopy := TKbmMemTable.Create(nil);
  Result := false;
  try
    // Get original copy of run list.
    memCopy.LoadFromDataSet(MyData, [mtcpoStructure, mtcpoProperties]);
    memCopy.Filtered := false;
    memCopy.Filter   := 'ClientID = ' + QuotedStr(FastFuncs.IntToStr(iClientID)) + ' AND ClientName = ' + QuotedStr(sClientName);
    memCopy.Filtered := true;

    if memCopy.RecordCount > 0 then begin
      Result := true;
    end;

  finally
    // Release our used objects.
    if Assigned(memCopy) then
      FreeandNil(memCopy);
  end;
end;

end.
