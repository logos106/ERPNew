unit StockLib;

interface

type
  TStockAdjustmenttype = (satGen=1, satBin=2, satBatch=3, satSN=4, satNone=5);
  TStockTransfertype   = (sttGen=1, sttBin=2, sttBatch=3, sttSN=4, sttTree=5, sttNone=6);


Function StockAdjustmenttypetoStr(Const Value :TStockAdjustmenttype):String;
function StrtoStockAdjustmenttype(const Value :String):TStockAdjustmenttype;
Function StockTransfertypetoStr(Const Value :TStockTransfertype):String;
function StrtoStockTransfertype(const Value :String):TStockTransfertype;

implementation

Function StockAdjustmenttypetoStr(Const Value :TStockAdjustmenttype):String;
begin
       if Value = satGen then Result := 'Gen'
  else if Value = satBin then Result := 'Bin'
  else if Value = satBatch then Result := 'Batch'
  else if Value = satSN then Result := 'SN'
  else Result := '';
end;
function StrtoStockAdjustmenttype(const Value :String):TStockAdjustmenttype;
begin
       if Value = 'Gen' then result := satGen
  else if Value = 'Bin' then result :=  satBin
  else if Value = 'Batch'  then result := satBatch
  else if Value = 'SN'  then result := satSN
  else Result := satNone;
end;

Function StockTransfertypetoStr(Const Value :TStockTransfertype):String;
begin
       if Value = sttGen then Result := 'Gen'
  else if Value = sttBin then Result := 'Bin'
  else if Value = sttBatch then Result := 'Batch'
  else if Value = sttSN then Result := 'SN'
  else if Value = sttTree then Result := 'Tree'
  else Result := '';
end;
function StrtoStockTransfertype(const Value :String):TStockTransfertype;
begin
       if Value = 'Gen' then result := sttGen
  else if Value = 'Bin' then result :=  sttBin
  else if Value = 'Batch'  then result := sttBatch
  else if Value = 'SN'  then result := sttSN
  else if Value = 'Tree'  then result := sttTree
  else Result := sttNone;
end;

end.

