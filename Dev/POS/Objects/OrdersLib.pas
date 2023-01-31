unit OrdersLib;

interface

uses
  Graphics,  // TColor
  DB;        // TDataSet

type

  TProcessStepStatus     = (psNone, psWaiting, psStarted, psComplete);
  TProcessStepStatusDesc = array[Low(TProcessStepStatus)..High(TProcessStepStatus)] of string;
  TProcessStepColours    = array[Low(TProcessStepStatus)..High(TProcessStepStatus)] of TColor;

  // returned by function CreateOrderFromSale
  TOrderFromSale = record
    Success: boolean;
    OrderId: integer;
    CustDocketRef: integer;
    ContainsProcessedItems: boolean;
  end;

  TProcessStepInfo = record
    Id: integer;
    Description: string;
    Status: TProcessStepStatus;
  end;


function ProgressOrderLineProcess(Const OrderLineId: integer): TProcessStepInfo;
function RegressOrderLineProcess(Const OrderLineId: integer): TProcessStepInfo;

const
  ProcessStepStatusDesc: TProcessStepStatusDesc = ('None', 'Waiting', 'Started', 'Complete');

var
  // Global variable for set of process step colours.
  ProcessStepColours: TProcessStepColours = (clWhite, $00DDDDFF, clMoneyGreen, clBtnFace);


implementation

uses
  MyAccess,ERPdbComponents,  //MySQL MyDAC components
  SysUtils,
  
  CommonDbLib, FastFuncs, MySQLConst;


procedure GetPartProcessInfo(OrderLineId, PartId: integer; var NextStepID: integer; var ProcessedItem: boolean);
var
  qry: TERPQuery;
  ProcStep: integer;
begin
  NextStepId := 0;
  ProcessedItem := false;
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    if OrderLineId < 1 then begin
      // we don't have an order line so get first process step for this part
      qry.SQL.Text := 'SELECT * FROM tblProcessPart WHERE PartId = ' + IntToStr(PartId) + ' ORDER BY ProcessStepSeq';
      qry.Open;
      if qry.RecordCount > 0 then begin
        qry.First;
        NextStepId := qry.FieldByName('ProcessStepId').AsInteger;
        // records found so this must be an item that requires processing
        ProcessedItem := true;
      end;
      qry.Close;
    end else begin
      // get next after OrderLine current step

      // get current process step from order line
      ProcStep := 0;
      qry.SQL.Text := 'SELECT CurrentProcStep FROM tblOrderLines WHERE ID = ' + IntToStr(OrderLineId) + ')';
      qry.Open;
      if qry.RecordCount > 0 then ProcStep := qry.FieldByName('CurrentProcStep').AsInteger;
      qry.Close;

      // now get next step for this Part
      qry.SQL.Text := 'SELECT * FROM tblProcessPart WHERE PartId = ' + IntToStr(PartId) + ' ORDER BY ProcessStepSeq';
      qry.Open;
      if qry.RecordCount > 0 then begin
        // records found so this must be an item that requires processing
        ProcessedItem := true;

        // now get next step
        qry.First;
        while (not qry.Eof) and (qry.FieldByName('ProcessStepSeq').AsInteger <= ProcStep) do begin
          qry.Next;
        end;
        if qry.FieldByName('ProcessStepSeq').AsInteger <= ProcStep then
          NextStepId := qry.FieldByName('ProcessStepId').AsInteger;
      end;
      qry.Close;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function BooleanToTF(boolVal: boolean): string;
begin
  if boolVal then Result := 'T'
  else Result := 'F';
end;



{-------------------------------------------------------------------------------
  Progress or regress the processing of an OrderLine and return process step
  and status info in a record
  This will also
   - advance line onto next process step if current step complete
     or regress to prior step if waiting
   - complete line if no more process steps to do
   - set the order header start time if this is the first line to
     be started
   - set order header end time if all lines complete
     or cleare header end time
-------------------------------------------------------------------------------}
function AdvanceOrderLineProcess(Const OrderLineId: integer; Const AdvanceProcess: boolean): TProcessStepInfo;
type
  TGetStepType = (gsCurrent, gsNext, gsPrior);
var
  qryLine, qry: TERPQuery;
  con: TERPConnection;
  CurrentStatus: TProcessStepStatus;
  NextStepId, PriorStepId: integer;
  StepDesc: string;

  function GetNextOrPriorStep(GetStepType: TGetStepType; var Desc: string): integer;
  var 
    found: boolean;
  begin
    Result := 0;
    desc := '';
    qry.SQL.Text := 'SELECT' + ' tblProcessPart.ProcessStepId,' + ' tblProcessStep.Description' +
      ' FROM tblProcessPart, tblOrderLines, tblProcessStep WHERE' + ' tblProcessPart.PartId = tblOrderLines.PartID AND' +
      ' tblProcessPart.ProcessStepId = tblProcessStep.ID AND' + ' tblOrderLines.ID = ' + IntToStr(OrderLineId)
      + ' ORDER BY tblProcessPart.ProcessStepSeq';
    qry.Open;
    found := false;
    if GetStepType = gsNext then begin
      qry.First;
      while (not qry.Eof) and (not found) do begin
        if qry.FieldByName('ProcessStepId').AsInteger =
          qryLine.FieldByName('CurrentProcStep').AsInteger then found := true;
        qry.Next; // get the next one
      end;
      if not qry.Eof then begin
        // the next processing step id
        Result := qry.FieldByName('ProcessStepId').AsInteger;
        Desc := qry.FieldByName('Description').AsString;
      end;
    end else if GetStepType = gsPrior then begin
      qry.Last;
      while (not qry.Bof) and (not found) do begin
        if qry.FieldByName('ProcessStepId').AsInteger =
          qryLine.FieldByName('CurrentProcStep').AsInteger then found := true;
        qry.Prior; // get the previous one
      end;
      if not qry.Bof then begin
        // the next processing step id
        Result := qry.FieldByName('ProcessStepId').AsInteger;
        Desc := qry.FieldByName('Description').AsString;
      end;
    end else if GetStepType = gsCurrent then begin
      qry.First;
      while (not qry.Eof) and (not found) do begin
        if qry.FieldByName('ProcessStepId').AsInteger =
          qryLine.FieldByName('CurrentProcStep').AsInteger then begin
          found := true;
          Result := qry.FieldByName('ProcessStepId').AsInteger;
          Desc := qry.FieldByName('Description').AsString;
        end else qry.Next; // get the next one
      end;
    end;
    qry.Close;
  end;

  function AllLinesComplete(OrderId: integer): boolean;
  begin
    qry.SQL.Text := 'SELECT COUNT(ID) FROM tblOrderLines' + ' WHERE OrderId = ''' + IntToStr(OrderId) +
      '''' + ' AND Complete <> ''T''';
    qry.Open;
    Result := (qry.Fields[0].AsInteger = 0);
    qry.Close;
  end;
begin
  con := CommonDbLib.GetNewMyDacConnection(nil);
  qryLine := TERPQuery.Create(nil);
  qryLine.Options.FlatBuffers := True;
  qryLine.Connection := con;
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  qry.Connection := con;
  try
    con.Open;
    con.StartTransaction;

    try
      //get current order line
      qryLine.SQL.Text := 'SELECT * from tblOrderLines WHERE ID = ' + IntToStr(OrderLineId);
      qryLine.Open;

      CurrentStatus := TProcessStepStatus(qryLine.FieldByName('Status').AsInteger);
      Result.Status := CurrentStatus;
      Result.Id := qryLine.FieldByName('CurrentProcStep').AsInteger;

      case CurrentStatus of
        psNone: 
          begin
            // a line should never have a status of none
          end;
        psWaiting: 
          begin
            if AdvanceProcess then begin // forward a step
              Result.Status := psStarted;
              qryLine.Edit;
              qryLine.FieldByName('Status').AsInteger := Ord(Result.Status);
              qryLine.Post;
            end else begin // go back a step
              PriorStepId := GetNextOrPriorStep(gsPrior, StepDesc);
              if PriorStepId <> 0 then begin
                Result.Status := psStarted;
                qryLine.Edit;
                qryLine.FieldByName('Status').AsInteger := Ord(Result.Status);
                qryLine.FieldByName('CurrentProcStep').AsInteger := PriorStepId;
                qryLine.Post;
              end;
            end;
          end;
        psStarted: 
          begin
            if AdvanceProcess then begin // forward a step
              NextStepId := GetNextOrPriorStep(gsNext, StepDesc);
              if NextStepId <> 0 then begin // found a new step
                Result.Status := psWaiting;
                qryLine.Edit;
                qryLine.FieldByName('Status').AsInteger := Ord(Result.Status);
                qryLine.FieldByName('CurrentProcStep').AsInteger := NextStepId;
                qryLine.Post;
              end else begin  // this was the last step so just complete it
                Result.Status := psComplete;
                qryLine.Edit;
                qryLine.FieldByName('Status').AsInteger := Ord(Result.Status);
                qryLine.FieldByName('Complete').AsBoolean := true;
                qryLine.Post;

                // ... and update header if need be
                if AllLinesComplete(qryLine.FieldByName('OrderId').AsInteger) then begin
                  qry.SQL.Text := 'UPDATE tblOrder SET EndTime = ''' + FormatDateTime(MysqlDateTimeFormat,
                    Now) + '''' + ' ,Complete = ''T''' + ' WHERE ID = ' + qryLine.FieldByName('OrderId').AsString + ' AND EndTime = 0';
                  qry.Execute;
                  qry.Close;
                end;
              end;
            end else begin // go back a step
              Result.Status := psWaiting;
              qryLine.Edit;
              qryLine.FieldByName('Status').AsInteger := Ord(Result.Status);
              qryLine.Post;

              // update header if need be
                        { Do nothing at this stage.
                          This would require checking each line to see if it was
                          on first process step and that step had not started yet }
            end;
          end;
        psComplete: 
          begin
            if AdvanceProcess then begin // forward a step
              // don't do anything ... should only be complete if all steps complete
            end else begin // go back a step
              Result.Status := psStarted;
              qryLine.Edit;
              qryLine.FieldByName('Status').AsInteger := Ord(Result.Status);
              qryLine.FieldByName('Complete').AsBoolean := false;
              qryLine.Post;

              // update header if need be
              qry.SQL.Text := 'UPDATE tblOrder SET EndTime = 0' + ' ,Complete = ''F''' + ' WHERE ID = ' +
                qryLine.FieldByName('OrderId').AsString + ' AND EndTime <> 0';
              qry.Execute;
              qry.Close;
            end;
          end;
      end; // case


      // return the id and description for the updated line
      NextStepId := GetNextOrPriorStep(gsCurrent, StepDesc);
      if NextStepId > 0 then begin
        Result.Id := NextStepId;
        Result.Description := StepDesc;
      end;

      qryLine.Close;
    except
      con.Rollback;
      raise;
    end;
    con.Commit;
    con.Close;
  finally
    FreeAndNil(qryLine);
    FreeAndNil(qry);
    FreeAndNil(con);
  end;
end;

function ProgressOrderLineProcess(Const OrderLineId: integer): TProcessStepInfo;
begin
  Result := AdvanceOrderLineProcess(OrderLineId, true);
end;

function RegressOrderLineProcess(Const OrderLineId: integer): TProcessStepInfo;
begin
  Result := AdvanceOrderLineProcess(OrderLineId, false);
end;

end.
