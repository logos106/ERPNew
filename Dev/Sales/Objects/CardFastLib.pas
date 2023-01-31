unit CardFastLib;

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 23/06/05  1.00.00 DSP  Initial verson. This class exports data to a csv
  //                        file, after using a table for temporary storage.  The
  //                        csv file is used by the NAB CardFast system for
  //                        receiving client payments.

interface

uses
  MyAccess, Classes, SysUtils, LbClass;

const
  cNABCardFast       = 'NAB CardFast';
  cFieldCount        = 8;
  cMerchantNumberMsg = 'Please enter an NAB CardFast Merchant Number on the preferences form';
  cCardNumberMsg     = 'Please enter a credit card number for this customer';
  cCardExpiredMsg    = 'The credit card for this customer has expired';
  cFieldItems: array[1..cFieldCount] of string = ('CardHolderName', 'TxReference', 'MerchantID',
                        'TxType', 'Amount', 'CardNumber', 'ExpiryDate','AuthID');

type
  TCardFast = class(TObject)
  private
    fFileName: string;
    fFieldList: TStringList;
    fDBQuery: TMyQuery;
    fDBConnection: TMyConnection;
    fBlowFish: TLbBlowFish;
  protected
    function FormatExpiryDate(const ExpiryDate: string): string; 
    procedure RemoveProcessedRecords; 
  public
    constructor Create(const DBConnection: TMyConnection);
    destructor Destroy; override;
    function VerifyCustomerInfo(const ClientID: integer; out ErrorMsg: string): boolean;
    procedure CreatePayment(const SaleID, ClientID: integer; Amount: currency);
    function ExportPayments: boolean;
    property FileName: string read FFileName write FFileName;
  end;

implementation

uses
  CommonDBLib,AppEnvironment, FastFuncs;

const
  cAmountStr         = 'Amount';
  cCardNumberStr     = 'CardNumber';
  cExpiryDateStr     = 'ExpiryDate';

constructor TCardFast.Create(const DBConnection: TMyConnection);
begin
  inherited Create;
  fFileName := '';
  fFieldList := TStringList.Create;
  fDBQuery := TMyQuery.Create(nil);
  fDBQuery.Options.FlatBuffers := True;
  fBlowFish := TLbBlowFish.Create(nil);

  //
  // Use the DB connection if assigned, otherwise use the shared MyDAC
  // connection
  //
  if Assigned(DBConnection) then fDBConnection := DBConnection
  else fDBConnection := CommonDbLib.GetSharedMyDacConnection;

  fDBQuery.Connection := fDBConnection;
end;

destructor TCardFast.Destroy;
begin
  FreeandNil(fFieldList);
  FreeandNil(fDBQuery);
  FreeandNil(fBlowFish);
  inherited Destroy;
end;

function TCardFast.VerifyCustomerInfo(const ClientID: integer; out ErrorMsg: string): boolean;
var
  CurrentDate: string;
  MonthYear: string;
  SeparatorIndex: integer;
begin
  Result := true;
  ErrorMsg := '';

  with fDBQuery do begin
    //
    // Check that a merchant number has been entered and set the error message
    // if it has not
    //
    if AppEnv.CompanyPrefs.NABCardFastMerchantNumber  = '' then begin
      ErrorMsg := cMerchantNumberMsg;
      Result := false;
    end;

    SQL.Clear;
    SQL.Add('SELECT * FROM tblclients WHERE ClientID=' + FastFuncs.IntToStr(ClientID));
    Open;

    //
    // Check that a credit card number has been supplied for this client and
    // set the error message if it has not
    //
    if FieldByName('CreditCardNumber').AsString = '' then begin
      if ErrorMsg <> '' then ErrorMsg := ErrorMsg + sLineBreak + cCardNumberMsg
      else ErrorMsg := cCardNumberMsg;

      Result := false;
    end else begin
      //
      // Determines if the credit card number has expired
      //
      CurrentDate := DateToStr(Now);
      SeparatorIndex := FastFuncs.PosEx(DateSeparator, CurrentDate);
      MonthYear := Copy(CurrentDate, SeparatorIndex,FastFuncs.StrLength(CurrentDate) - SeparatorIndex + 1);

      //
      // Set error message if card has expired
      //
      if (StrToDate('1' + DateSeparator + FieldByName('CreditCardExpiryDate').AsString)) < StrToDate('1' + MonthYear) then
      begin
        if ErrorMsg <> '' then ErrorMsg := ErrorMsg + sLineBreak + cCardExpiredMsg
        else ErrorMsg := cCardExpiredMsg;

        Result := false;
      end;
    end;
  end;
end;

procedure TCardFast.CreatePayment(const SaleID, ClientID: integer; Amount: currency);
var
  CardHolderName: string;
  CardNumber: string;
  CardExpiryDate: string;
  MerchantID: string;
  TxType: char;
begin
  with fDBQuery do begin
    if Amount >= 0 then TxType := 'P'
    else begin
      TxType := 'R';
      Amount := Abs(Amount);
    end;

    SQL.Clear;
    SQL.Add('SELECT * FROM tblclients WHERE ClientID=' + FastFuncs.IntToStr(ClientID));
    Open;
    CardHolderName := FieldByName('CreditCardCardHolderName').AsString;
    CardNumber     := FieldByName('CreditCardNumber').AsString;
    CardExpiryDate := FieldByName('CreditCardExpiryDate').AsString;
    Close;

    MerchantID := AppEnv.CompanyPrefs.NABCardFastMerchantNumber;


    SQL.Clear;
    SQL.Add('INSERT HIGH_PRIORITY INTO tblcardfast (CardHolderName, TxReference, MerchantID, TxType, Amount, CardNumber, ExpiryDate, AuthID, Apply, Processed)');
    SQL.Add('VALUES (' + QuotedStr(CardHolderName) + ', ' + QuotedStr(FastFuncs.IntToStr(SaleID)) + ', ' +
      QuotedStr(MerchantID) + ', ' +
      QuotedStr(TxType) + ', ' + QuotedStr(FloatToStr(Amount)) + ', ' + QuotedStr(CardNumber) +
      ', ' + QuotedStr(CardExpiryDate) +
      ', ''''' + ', ' + '''F'', ' + '''F''' + ')');
    Execute;
  end;
end;

function TCardFast.ExportPayments: boolean;
var
  RecordStr: string;
  FieldIndex: integer;
begin
  Result := false;
  fDBConnection.Open;

  if FileName <> '' then begin
    try
      if fDBConnection.InTransaction then fDBConnection.Rollback;

      fDBConnection.StartTransaction;
      fFieldList.Clear;

      with fDBQuery do begin
        SQL.Clear;
        SQL.Add('SELECT * FROM tblcardfast');
        Open;
        First;

        //
        // Export each record with 'Apply' tagged and which has not yet been
        // processed
        //
        while not Eof do begin
          if (FieldByName('Apply').AsString = 'T') and (FieldByName('Processed').AsString = 'F') then begin
            RecordStr := '';

            //
            // Build RecordStr from the fields of the table
            //
            for FieldIndex := 1 to cFieldCount do begin
              if FastFuncs.SameText(cFieldItems[FieldIndex], cAmountStr) then
                RecordStr := RecordStr + '"' + FastFuncs.IntToStr(Trunc(FieldByName(cFieldItems[FieldIndex]).AsFloat * 100)) + '",'
              else if FastFuncs.SameText(cFieldItems[FieldIndex], cCardNumberStr) then
                RecordStr := RecordStr + '"' + fBlowFish.DecryptString(FieldByName(cFieldItems[FieldIndex]).AsString) + '",'
              else if FastFuncs.SameText(cFieldItems[FieldIndex], cExpiryDateStr) then
                RecordStr := RecordStr + '"' + FormatExpiryDate(FieldByName(cFieldItems[FieldIndex]).AsString) + '",'
              else RecordStr := RecordStr + '"' + FieldByName(cFieldItems[FieldIndex]).AsString + '",';
            end;

            //
            // Remove the terminating comma and then save the record in a 
            // string list
            //
            SetLength(RecordStr,FastFuncs.StrLength(RecordStr) - 1);
            fFieldList.Add(RecordStr);
            Edit;
            FieldByName('Processed').AsString := 'T';
          end;

          Next;
        end;
      end;

      //
      // Save the list of records to a file and then commit the transactions
      //
      fFieldList.SaveToFile(FileName);
      fDBConnection.Commit;
      Result := true;
    except
      fDBConnection.Rollback;
    end;

    if Result = true then RemoveProcessedRecords;
  end;
end;

procedure TCardFast.RemoveProcessedRecords;
begin
  with fDBQuery do begin
    SQL.Clear;
    SQL.Add('DELETE FROM tblcardfast WHERE Processed=''T''');
    Execute;
  end;
end;

function TCardFast.FormatExpiryDate(const ExpiryDate: string): string;
var
  SeparatorPos: integer;
  MonthStr: string;
  YearStr: string;
begin
  SeparatorPos := FastFuncs.PosEx('/', ExpiryDate);
  MonthStr := Copy(ExpiryDate, 1, SeparatorPos - 1);
  YearStr := Copy(ExpiryDate, SeparatorPos + 1,FastFuncs.StrLength(ExpiryDate) - SeparatorPos);
  Result := Format('%.2d/%.2d', [StrToIntDef(MonthStr, 0), StrToIntDef(YearStr, 0)]);
end;

end.
