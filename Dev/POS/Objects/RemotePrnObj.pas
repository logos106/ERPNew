unit RemotePrnObj;

interface

uses
  Windows, SysUtils, ReceiptPrinterObj, Classes, MyAccess,ERPdbComponents;

type
  TRemotePrn = class(TReceiptPrinter)
  private
    flstReceipt: TStringList;
    fConnection: TCustomMyConnection;
    fiTillID: integer;
    fiRemoteTillID: integer;
    fiFlushMaxOccurances: integer;
    fsFlushText: string;
    function IsFlushRequired(const sRcptText: string): boolean;
  protected
    procedure Send(const sText: string); override;
  public
    constructor Create(iTillID, iRemoteTillID: integer; connection: TCustomMyConnection); reintroduce; virtual;
    destructor Destroy; override;
    procedure Initialize; override;
    procedure OpenCashDrawer; override;
    procedure Format(const cFormat: char); override;
    procedure Print(const sText: string); override;
    procedure PrintNoLf(const sText: string); override;
    procedure NewLine(const iLines: integer); override;
    procedure DoCR; override;
    procedure FeedPaperForCut; override;
    procedure OpenPort; override;
    procedure ClosePort; override;
    procedure SetFlushTrigger(const sText: string; const iMaxOccurences: integer);
  end;

implementation

{ TRemotePrn }

procedure TRemotePrn.ClosePort;
  // ClosePort will write the text to the backend's 'Remote Receipt' field.
  // Note that if the backend field already contains an unprinted receipt
  // (PrintRemoteReceipt = "T") then we append to the existing receipt.
var
  qry: TERPQuery;
  sText: string;
begin
  { if this is called from TReceiptPrinter.Destroy then flstReceipt has already
    been Destroyed and niled so just exit (else AV)  }
  if not Assigned(flstReceipt) then
    exit;

  qry := TERPQuery.Create(nil);
  try
    qry.Connection := fConnection;
    qry.SQL.Add('SELECT TillID, RemoteReceipt FROM tblPOSTills ' +
      'WHERE TillID = :xTillID AND PrintRemoteReceipt = "T"');
    qry.ParamByName('xTillID').asInteger := fiTillID;
    qry.Open;
    if qry.RecordCount > 0 then begin
      if IsFlushRequired(qry.FieldByName('RemoteReceipt').AsString) then begin
        sText := '******* Flushed ********';   // too many receipts - start afresh
      end else begin
        sText := qry.FieldByName('RemoteReceipt').AsString; // will append to end of these receipts
      end;
      flstReceipt.Text := sText + flstReceipt.Text;
    end;
    qry.Close;

    qry.SQL.Clear;
    qry.SQL.Add('UPDATE tblPOSTills ' +
      'SET RemoteReceipt = :xText, PrintRemoteReceipt = "T", ' +
      ' RemoteTillId = :xRemoteTillId ' +
      'WHERE TillID = :xTillID');

    qry.ParamByName('xTillID').asInteger       := fiTillID;
    qry.ParamByName('xRemoteTillID').asInteger := fiRemoteTillID;
    qry.ParamByName('xText').asString         := flstReceipt.Text;
    qry.Execute;
  finally
    FreeAndNil(qry);
  end;
end;

constructor TRemotePrn.Create(iTillID, iRemoteTillId: integer; connection: TCustomMyConnection);
begin
  inherited Create;
  fiTillID := iTillID;
  fiRemoteTillId := iRemoteTillId;
  fConnection := connection;
  InitBuf;
  flstReceipt := TStringList.Create;
  fiFlushMaxOccurances := 0;
  fsFlushText := '';
end;

destructor TRemotePrn.Destroy;
begin
  FreeAndNil(flstReceipt);
  inherited;   
end;

procedure TRemotePrn.DoCR;
begin
  inherited;
  fiIndex := 1;
end;

procedure TRemotePrn.FeedPaperForCut;
begin
  inherited;
  if Length(fsBuffer) <> 0 then begin
    Send(fsBuffer);
    InitBuf;
  end;
  Send('~C');
end;

procedure TRemotePrn.Format(const cFormat: char);
begin
  inherited;
  if Length(SysUtils.Trim(fsBuffer)) <> 0 then begin
    Send(fsBuffer);
    InitBuf;
  end;
  Send('~F' + cFormat);
  if (integer(cFormat) and FMT_WIDE) <> 0 then begin
    fiWidth := WIDE_CHR_WIDTH;
  end else begin
    fiWidth := NORM_CHR_WIDTH;
  end;
end;

procedure TRemotePrn.Initialize;
begin
  inherited;
  flstReceipt.Clear;
end;

function TRemotePrn.IsFlushRequired(const sRcptText: string): boolean;
var
  iCnt, i: integer;
  lstRcpt: TStringList;
begin
  Result := false;
  if fiFlushMaxOccurances <= 0 then begin
    Exit;
  end;

  iCnt := 0;
  lstRcpt := TStringList.Create;
  lstRcpt.Text := sRcptText;
  for i := 0 to lstRcpt.Count - 1 do begin
    if fsFlushText = SysUtils.Trim(lstRcpt.Strings[i]) then begin
      Inc(iCnt);
    end;
  end;

  if iCnt >= fiFlushMaxOccurances then begin
    Result := true;
  end;
end;

procedure TRemotePrn.NewLine(const iLines: integer);
var
  i, iStart: integer;
begin
  if Length(fsBuffer) <> 0 then begin
    Send(fsBuffer);
    InitBuf;
    iStart := 2;
  end else begin
    iStart := 1;
  end;
  for i := iStart to iLines do begin
    Send('');
  end;
end;

procedure TRemotePrn.OpenCashDrawer;
begin
  inherited;; //forget for now
end;

procedure TRemotePrn.OpenPort;
begin
  flstReceipt.Clear;
end;

procedure TRemotePrn.Print(const sText: string);
begin
  PrintNoLF(sText);
  NewLine(1);
end;

procedure TRemotePrn.PrintNoLf(const sText: string);
begin
  case fiJustification of
    LJ: LoadBuf(sText);
    RJ: LoadBuf(StrRJ(sText, fiWidth));
    CJ: LoadBuf(StrCJ(sText, fiWidth));
    else LoadBuf(sText);
  end;
end;

procedure TRemotePrn.Send(const sText: string);
begin
  flstReceipt.Add(sText);
end;

procedure TRemotePrn.SetFlushTrigger(const sText: string; const iMaxOccurences: integer);
  // we clear the receipt buffer if fsFlushText occurs more than iMaxOccurences times in the buffer
  // You should set  fsFlushText to some unique text that occurs only once in a receipt. That way
  // .. iMaxOccurences will represent the max number of receipts to Save in the buffer.
begin
  fsFlushText := sText;
  fiFlushMaxOccurances := iMaxOccurences;
end;

end.

