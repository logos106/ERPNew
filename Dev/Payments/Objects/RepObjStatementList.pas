unit RepObjStatementList;

interface

uses
  RepObjBase, Generics.Collections, DB, JsonObject;

type
//  TStatementLine = class;

  TRepObjStatementList = class(TRepObjBase)
  protected
    function GetReportName: string; override;
//    procedure SetDateFrom(const Value: TDateTime); override;
//    procedure SetDateTo(const Value: TDateTime); override;
//    procedure SetIgnoreDates(const Value: boolean); override;
    function GetJson: TJsonObject; override;
    procedure SetParams(const Value: TJsonObject); override;
    procedure LoadJson(obj: TJsonObject); override;
  public
    constructor Create;
    destructor Destroy; override;
  published
//    Lines: TObjectList<TStatementLine>;
  end;

(*
  TStatementLine = class(TObject)
  private
    FPrepayamt: double;
    FDaysOutstanding: integer;
    FDetails: integer;
    FDays60to90: double;
    FWithinTerms: double;
    FSaleID: integer;
    FMoreThan90: double;
    FDays30to60: double;
    FDays14to21: double;
    Fmorethan21: double;
    FCustomerName: string;
    FClientId: integer;
    FTransactionDueDate: TDateTime;
    FDays1to30: double;
    FTransType: string;
    FInvoiceNumber: string;
    FOutstandingAmount: double;
    FStatus: string;
    FTransactionDate: TDateTime;
    FDays7to14: double;
    FDays1to7: double;
    FReceiptNo: integer;
    FGlobalRef: string;
    FTotalAmount: double;
    procedure SetClientId(const Value: integer);
    procedure SetCustomerName(const Value: string);
    procedure SetDays14to21(const Value: double);
    procedure SetDays1to30(const Value: double);
    procedure SetDays1to7(const Value: double);
    procedure SetDays30to60(const Value: double);
    procedure SetDays60to90(const Value: double);
    procedure SetDays7to14(const Value: double);
    procedure SetDaysOutstanding(const Value: integer);
    procedure SetDetails(const Value: integer);
    procedure SetGlobalRef(const Value: string);
    procedure SetInvoiceNumber(const Value: string);
    procedure Setmorethan21(const Value: double);
    procedure SetMoreThan90(const Value: double);
    procedure SetOutstandingAmount(const Value: double);
    procedure SetPrepayamt(const Value: double);
    procedure SetReceiptNo(const Value: integer);
    procedure SetSaleID(const Value: integer);
    procedure SetStatus(const Value: string);
    procedure SetTotalAmount(const Value: double);
    procedure SetTransactionDate(const Value: TDateTime);
    procedure SetTransactionDueDate(const Value: TDateTime);
    procedure SetTransType(const Value: string);
    procedure SetWithinTerms(const Value: double);
  public
    procedure Load(ds: TDataset);
  published
    property TransactionDate: TDateTime read FTransactionDate write SetTransactionDate;
    property CustomerName: string read FCustomerName write SetCustomerName;
    property ReceiptNo: integer read FReceiptNo write SetReceiptNo;
    property InvoiceNumber: string read FInvoiceNumber write SetInvoiceNumber;
    property TransType: string read FTransType write SetTransType;
    property Status: string read FStatus write SetStatus;
    property TransactionDueDate: TDateTime read FTransactionDueDate write SetTransactionDueDate;
    property DaysOutstanding: integer read FDaysOutstanding write SetDaysOutstanding;
    property TotalAmount: double read FTotalAmount write SetTotalAmount;
    property PrepayAmount: double read FPrepayAmt write SetPrepayAmt;
    property OutstandingAmount: double read FOutstandingAmount write SetOutstandingAmount;
    property WithinTerms: double read FWithinTerms write SetWithinTerms;
    property Days1to7: double read FDays1to7 write SetDays1to7;
    property Days7to14: double read FDays7to14 write SetDays7to14;
    property Days14to21: double read FDays14to21 write SetDays14to21;
    property morethan21: double read Fmorethan21 write Setmorethan21;
    property Days1to30: double read FDays1to30 write SetDays1to30;
    property Days30to60: double read FDays30to60 write SetDays30to60;
    property Days60to90: double read FDays60to90 write SetDays60to90;
    property MoreThan90: double read FMoreThan90 write SetMoreThan90;
    property SaleID: integer read FSaleID write SetSaleID;
    property ClientId: integer read FClientId write SetClientId;
    property Details: integer read FDetails write SetDetails;
    property GlobalRef: string read FGlobalRef write SetGlobalRef;
  end;
*)

implementation

uses
  StatementListDM, SysUtils, JsonToDatasetFuncs, Classes;

{ TRepObjStatementList }

constructor TRepObjStatementList.Create;
//var
//  dm: TStatementListDat;
begin
  inherited;
//  Lines := TObjectList<TStatementLine>.Create;
//  dm := TStatementListDat.Create(nil);
//  try
//
//
//  finally
//    dm.Free;
//  end;
end;

destructor TRepObjStatementList.Destroy;
begin
//  Lines.Free;
  inherited;
end;

function TRepObjStatementList.GetJson: TJsonObject;
begin
  result := inherited;
end;

function TRepObjStatementList.GetReportName: string;
begin
  result := 'Statement List';
end;

procedure TRepObjStatementList.LoadJson(obj: TJsonObject);
var
  dm: TStatementListDat;
  line: TJsonObject;
begin
  inherited;

  obj.S['GroupFilter'] := '';
  { populate data }
  dm := TStatementListDat.Create(nil);
  try
    dm.IgnoreDates := true;
    if Assigned(Params) then begin
      if Params.Exists('IgnoreDates') then begin
        dm.IgnoreDates := Params.ItemByName['IgnoreDates'].Value.AsBoolean;
      end;
      if not dm.IgnoreDates then begin
        if Params.Exists('DateFrom') then
          dm.DateFrom := Params.DT['DateFrom'];
        if Params.Exists('DateTo') then
          dm.DateTo := Params.DT['DateTo'];
      end;
    end;
    dm.qryMain.Open;
    if Assigned(Params) then begin
      if Params.Exists('GroupFilter') then begin
        if SameText(Params.S['GroupFilter'],'Summary') then
          dm.Filter := 'Details = 1'
        else if SameText(Params.S['GroupFilter'],'Details') then
          dm.Filter := 'Details = 2 or Details = 1'
        else if SameText(Params.S['GroupFilter'],'ExtraDetails') then
          dm.Filter := 'Details = 3 or Details = 1'
        else
          dm.Filter := '';
        obj.S['GroupFilter'] := Params.S['GroupFilter'];
      end;
    end;
    obj.B['IgnoreDates'] := dm.IgnoreDates;
    if not dm.IgnoreDates then begin
      obj.DT['DateFrom'] := dm.DateFrom;
      obj.DT['DateTo'] := dm.DateTo;
    end;

    while not dm.qryMain.Eof do begin
      line := JO;
      DatasetToJson(dm.qryMain,line);
      obj.A['Lines'].Add(line);
      dm.qryMain.Next;
    end;

  finally
    dm.Free;
  end;
end;

procedure TRepObjStatementList.SetParams(const Value: TJsonObject);
begin
  inherited;

end;

(*
procedure TRepObjStatementList.SetDateFrom(const Value: TDateTime);
begin
  inherited;

end;

procedure TRepObjStatementList.SetDateTo(const Value: TDateTime);
begin
  inherited;

end;

procedure TRepObjStatementList.SetIgnoreDates(const Value: boolean);
begin
  inherited;

end;
*)

{ TStatementLine }

(*
procedure TStatementLine.Load(ds: TDataset);
begin
  self.FPrepayamt := ds.FieldByName('PrepayAmt').AsFloat;
end;

procedure TStatementLine.SetClientId(const Value: integer);
begin
  FClientId := Value;
end;

procedure TStatementLine.SetCustomerName(const Value: string);
begin
  FCustomerName := Value;
end;

procedure TStatementLine.SetDays14to21(const Value: double);
begin
  FDays14to21 := Value;
end;

procedure TStatementLine.SetDays1to30(const Value: double);
begin
  FDays1to30 := Value;
end;

procedure TStatementLine.SetDays1to7(const Value: double);
begin
  FDays1to7 := Value;
end;

procedure TStatementLine.SetDays30to60(const Value: double);
begin
  FDays30to60 := Value;
end;

procedure TStatementLine.SetDays60to90(const Value: double);
begin
  FDays60to90 := Value;
end;

procedure TStatementLine.SetDays7to14(const Value: double);
begin
  FDays7to14 := Value;
end;

procedure TStatementLine.SetDaysOutstanding(const Value: integer);
begin
  FDaysOutstanding := Value;
end;

procedure TStatementLine.SetDetails(const Value: integer);
begin
  FDetails := Value;
end;

procedure TStatementLine.SetGlobalRef(const Value: string);
begin
  FGlobalRef := Value;
end;

procedure TStatementLine.SetInvoiceNumber(const Value: string);
begin
  FInvoiceNumber := Value;
end;

procedure TStatementLine.Setmorethan21(const Value: double);
begin
  Fmorethan21 := Value;
end;

procedure TStatementLine.SetMoreThan90(const Value: double);
begin
  FMoreThan90 := Value;
end;

procedure TStatementLine.SetOutstandingAmount(const Value: double);
begin
  FOutstandingAmount := Value;
end;

procedure TStatementLine.SetPrepayamt(const Value: double);
begin
  FPrepayamt := Value;
end;

procedure TStatementLine.SetReceiptNo(const Value: integer);
begin
  FReceiptNo := Value;
end;

procedure TStatementLine.SetSaleID(const Value: integer);
begin
  FSaleID := Value;
end;

procedure TStatementLine.SetStatus(const Value: string);
begin
  FStatus := Value;
end;

procedure TStatementLine.SetTotalAmount(const Value: double);
begin
  FTotalAmount := Value;
end;

procedure TStatementLine.SetTransactionDate(const Value: TDateTime);
begin
  FTransactionDate := Value;
end;

procedure TStatementLine.SetTransactionDueDate(const Value: TDateTime);
begin
  FTransactionDueDate := Value;
end;

procedure TStatementLine.SetTransType(const Value: string);
begin
  FTransType := Value;
end;

procedure TStatementLine.SetWithinTerms(const Value: double);
begin
  FWithinTerms := Value;
end;
*)

initialization
  Classes.RegisterClass(TRepObjStatementList);


end.
