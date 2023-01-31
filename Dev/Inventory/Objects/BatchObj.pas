unit BatchObj;


interface

uses
    MyAccess,ERPdbComponents, DB, Forms, Variants;

type
  TBatchObj = class(TObject)
  private
    fADOConnection: TCustomMyConnection;
  public
    constructor Create(const Connection: TCustomMyConnection);

    procedure RemoveBinLine(const SalelineGlobalRef, POlineGlobalRef, BinID: string);
    procedure RemovePartLocation(const SalelineGlobalRef: string = ''; const POlineGlobalRef: string = '');
    procedure RemovePartLocationLine(const SalelineGlobalRef: string = ''; const POlineGlobalRef: string = '');

    procedure ResetBinQty(const PartID, ClassID: integer);

    function BinQty(const PartID, ClassID, BinID: integer): double;

    procedure Add(const PartID, ClassID, POID: integer; const Qty: double; const SalelineGlobalRef: string = '';
      const POlineGlobalRef: string = '');
    procedure AddBin(const PartID, ClassID, POID, BinID: integer; const Qty: double;
      const SalelineGlobalRef: string = ''; const POlineGlobalRef: string = '');


    function SoldFifo(const PartID, ClassID, SalesID: integer; const Qtys: double; const ttype: string;
      const SalelineGlobalRef: string = ''; const POlineGlobalRef: string = ''): boolean;
    function SoldSelect(const Form: TForm; const PartID, ClassID, SalesID: integer; const Qty: double;
      const ttype: string; const SalelineGlobalRef: string = ''; const POlineGlobalRef: string = ''): boolean;

  end;


implementation

uses
  SysUtils, AuditObj, frmSelectBatches, Controls, Dialogs, CommonDbLib,
  FastFuncs, CommonLib;

constructor TBatchObj.Create(const Connection: TCustomMyConnection);
begin
  inherited Create;
  fADOConnection := Connection;
end;

procedure TBatchObj.Add(const PartID, ClassID, POID: integer; const Qty: double;
  const SalelineGlobalRef: string = ''; const POlineGlobalRef: string = '');
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  with qry do try
      qry.Connection := fADOConnection;
      try
        SQL.Text := Format('INSERT HIGH_PRIORITY INTO tblPartsBatches ' +
          ' (PartsID, ClassID, QtyOnHand, PurchaseOrderID,SaleLinesGlobalRef,POLinesGlobalRef ) ' +
          'VALUES (%d, %d, %g, %d,''%s'',''%s'')', [PartID, ClassID, Qty, POID, SalelineGlobalRef, POlineGlobalRef]);
        Execute;
      except
        on e: Exception do begin
          Audit.AddEntry(e, Self);
          raise;
        end;
      end;
    finally
      Free;
    end;
end;

procedure TBatchObj.AddBin(const PartID, ClassID, POID, BinID: integer; const Qty: double;
  const SalelineGlobalRef: string = ''; const POlineGlobalRef: string = '');
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  with qry do try
      qry.Connection := fADOConnection;
      try
        SQL.Text := Format('INSERT HIGH_PRIORITY INTO tblPartsBatches ' +
          ' (PartsID, ClassID, QtyOnHand, PurchaseOrderID, BinID,SaleLinesGlobalRef,POLinesGlobalRef ) ' +
          'VALUES (%d, %d, %g, %d, %d,''%s'',''%s'')', [PartID, ClassID, Qty, POID, BinID, SalelineGlobalRef, POlineGlobalRef]);
        Execute;
      except
        on e: Exception do begin
          Audit.AddEntry(e, Self);
          raise;
        end;
      end;
    finally
      Free;
    end;
end;

function TBatchObj.SoldSelect(const Form: TForm; const PartID, ClassID, SalesID: integer;
  const Qty: double; const ttype: string; const SalelineGlobalRef: string = ''; const POlineGlobalRef: string = ''): boolean;
var 
  qry1: TERPCommand;
  qry2: TERPCommand;
  qry3: TERPQuery;
begin
  with TfrmSelectBatchesGUI.Create(Form) do begin
    Result := UserPick(PartID, ClassID, SalesID, Qty, ttype);
    ShowModal;
    if OK then begin
      qry1 := TERPCommand.Create(nil);
      qry2 := TERPCommand.Create(nil);
      qry3 := TERPQuery.Create(nil);
      try
        try
          qry1.Connection := CommonDbLib.GetSharedMyDacConnection;
          qry2.Connection := CommonDbLib.GetSharedMyDacConnection;
          qry3.Connection := CommonDbLib.GetSharedMyDacConnection;
          kbBatches.First;
          while not kbBatches.Eof do begin
            if kbBatches.FieldByName('Selected Qty').AsFloat > 0 then begin
              if kbBatches.FieldByName('Qty Available').AsFloat = kbBatches.FieldByName('Selected Qty').AsFloat then begin
                qry1.SQL.Text := Format('DELETE FROM tblPartsBatches WHERE BatchID = %d',
                  [kbBatches.FieldByName('BatchID').AsInteger]);
                qry1.Execute;
              end else begin
                qry3.Close;
                qry3.SQL.Text := Format('SELECT BatchID, QtyOnHand, EditedFlag FROM tblPartsBatches ' + 'WHERE BatchID = %d',
                  [kbBatches.FieldByName('BatchID').AsInteger]);
                qry3.Open;
                if qry3.RecordCount = 1 then begin
                  qry3.Edit;
                  qry3.FieldByName('QtyOnHand').AsFloat := qry3.FieldByName('QtyOnHand').AsFloat -
                    kbBatches.FieldByName('Selected Qty').AsFloat;
                  qry3.FieldByName('EditedFlag').AsString := 'T';
                  qry3.Post;
                end;
              end;
              qry2.SQL.Text := Format('INSERT HIGH_PRIORITY INTO tblPartsBatches ' +
                '(PartsID, ClassID, QtySold, PurchaseOrderID, SalesID, BinID, Type,SaleLinesGlobalRef,POLinesGlobalRef) ' +
                'VALUES (%d, %d, %g, %d, %d, %d, ''%s'',''%s'',''%s'')', [PartID, ClassID,
                kbBatches.FieldByName('Selected Qty').AsFloat, kbBatches.FieldByName('PurchaseOrder ID').AsInteger,
                SalesID, kbBatches.FieldByName('BinID').AsInteger, ttype, SalelineGlobalRef, POlineGlobalRef]);
              qry2.Execute;
              qry3.Close;
              qry3.SQL.Text := Format('SELECT BinID, QtyOnHand, EditedFlag FROM tblPartsLocations ' + 'WHERE BinID = %d',
                [kbBatches.FieldByName('BinID').AsInteger]);
              qry3.Open;
              if qry3.RecordCount = 1 then begin
                qry3.Edit;
                qry3.FieldByName('QtyOnHand').AsFloat := qry3.FieldByName('QtyOnHand').AsFloat -
                  kbBatches.FieldByName('Selected Qty').AsFloat;
                qry3.FieldByName('EditedFlag').AsString := 'T';
                qry3.Post;
              end;
            end;
            kbBatches.Next;
          end;
        except
          on e: Exception do begin
            Audit.AddEntry(e, Self);
            raise;
          end;
        end;
      finally
        FreeAndNil(qry1);
        FreeAndNil(qry2);
        FreeAndNil(qry3);
      end;
    end;
  end;
end; //SoldFifo

{turn oldest Batches qtyOnHand (smallest POID) into QtySold}
function TBatchObj.SoldFifo(const PartID, ClassID, SalesID: integer; const Qtys: double;
  const ttype: string; const SalelineGlobalRef: string = ''; const POlineGlobalRef: string = ''): boolean;
var
  qry1: TERPQuery;
  qry2: TERPCommand;
  qry3: TERPQuery;
  POID, BinID: integer;
  restQty, batchQty: double;
  Qty: double;
begin
  Result := false;
  Qty := Qtys;
  qry1 := TERPQuery.Create(nil);
  qry2 := TERPCommand.Create(nil);
  qry3 := TERPQuery.Create(nil);
  try
    try
      qry1.Connection := CommonDbLib.GetSharedMyDacConnection;
      qry2.Connection := CommonDbLib.GetSharedMyDacConnection;
      qry3.Connection := CommonDbLib.GetSharedMyDacConnection;
      qry1.SQL.Text := Format('SELECT QtyOnHand, PurchaseOrderID, BinID,SaleLinesGlobalRef,POLinesGlobalRef  FROM tblPartsBatches ' +
        'WHERE PartsID = %d AND ClassID = %d AND (SalesID is null ' + 'OR SalesID < 0) ' + 'ORDER BY PurchaseOrderID',
        [PartID, ClassID]);
      qry1.Open;
      qry1.First;
      while not qry1.Eof and (Qty <> 0) do begin
        batchQty := qry1.FieldByName('QtyOnHand').AsFloat;
        POID := qry1.FieldByName('PurchaseOrderID').AsInteger;
        BinID := qry1.FieldByName('BinID').AsInteger;
        restQty := batchQty - Qty;
        if restQty > 0 then begin
          qry1.Edit;                      // so change to restQty
          qry1.FieldByName('QtyOnHand').AsFloat := restQty;
          qry1.Post;          
          batchQty := Qty;
          Qty := 0;
          qry1.Next;
        end else begin
          qry1.Delete;
          Qty := Qty - batchQty;
        end;
        qry2.SQL.Clear;
        qry2.SQL.Add(Format('INSERT HIGH_PRIORITY INTO tblPartsBatches ' +
          '(PartsID, ClassID, QtySold, PurchaseOrderID, SalesID, BinID, Type, SalelinesGlobalRef, POlinesGlobalRef ) ' +
          'VALUES (%d, %d, %g, %d, %d, %d, ''%s'',''%s'',''%s'')',
          [PartID, ClassID, batchQty, POID, SalesID, BinID, ttype, SalelineGlobalRef, POlineGlobalRef]));
        qry2.Execute;
        qry3.Close;
        qry3.SQL.Text := Format('SELECT BinID, QtyOnHand, EditedFlag FROM tblPartsLocations ' + 'WHERE BinID = %d', [BinID]);
        qry3.Open;
        if qry3.RecordCount = 1 then begin
          qry3.Edit;
          qry3.FieldByName('QtyOnHand').AsFloat := qry3.FieldByName('QtyOnHand').AsFloat - batchQty;
          qry3.FieldByName('EditedFlag').AsString := 'T';
          qry3.Post;
        end;
      end;
      Result := qty = 0;
    except
      on e: Exception do begin
        Audit.AddEntry(e, Self);
        raise;
      end;
    end;
  finally
    FreeAndNil(qry1);
    FreeAndNil(qry2);
    FreeAndNil(qry3);
  end;
end;

procedure TBatchObj.RemoveBinLine(const SalelineGlobalRef, POlineGlobalRef, BinID: string);
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  with qry do try
      qry.Connection := fADOConnection;
      try
        if Empty(BinID) then begin
          if not Empty(POlineGlobalRef) then begin
            SQL.Text := 'DELETE FROM tblPartsBatches WHERE POLinesGlobalRef="' + POlineGlobalRef + '";';
            Execute;
          end;
          if not Empty(SalelineGlobalRef) then begin
            SQL.Text := 'DELETE FROM tblPartsBatches WHERE SaleLinesGlobalRef="' + SalelineGlobalRef + '";';
            Execute;
          end;
        end else begin
          if not Empty(POlineGlobalRef) then begin
            SQL.Text := 'DELETE FROM tblPartsBatches WHERE POLinesGlobalRef="' + POlineGlobalRef +
              '" And BinID =' + BinID + ';';
            Execute;
          end;
          if not Empty(SalelineGlobalRef) then begin
            SQL.Text := 'DELETE FROM tblPartsBatches WHERE SaleLinesGlobalRef="' + SalelineGlobalRef +
              '" And BinID =' + BinID + ';';
            Execute;
          end;
        end;
      except
      end;
    finally
      Free;
    end;
end;

procedure TBatchObj.RemovePartLocation(const SalelineGlobalRef, POlineGlobalRef: string);
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  with qry do try
      qry.Connection := fADOConnection;
      try
        if not Empty(POlineGlobalRef) then begin
          SQL.Text := 'DELETE FROM tblpartslocations WHERE PL_POLinesGlobalRef="' + POlineGlobalRef + '";';
          Execute;
        end;
        if not Empty(SalelineGlobalRef) then begin
          SQL.Text := 'DELETE FROM tblpartslocations WHERE PL_SaleLinesGlobalRef="' + SalelineGlobalRef + '";';
          Execute;
        end;
      except
      end;
    finally
      Free;
    end;
end;

procedure TBatchObj.RemovePartLocationLine(const SalelineGlobalRef, POlineGlobalRef: string);
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  with qry do try
      qry.Connection := fADOConnection;
      try
        if not Empty(POlineGlobalRef) then begin
          SQL.Text := 'DELETE FROM tblpartslocationchanges WHERE PLC_POLinesGlobalRef="' + POlineGlobalRef + '";';
          Execute;
        end;
        if not Empty(SalelineGlobalRef) then begin
          SQL.Text := 'DELETE FROM tblpartslocationchanges WHERE PLC_SaleLinesGlobalRef="' + SalelineGlobalRef + '";';
          Execute;
        end;
      except
      end;
    finally
      Free;
    end;
end;

procedure TBatchObj.ResetBinQty(const PartID, ClassID: integer);
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  with qry do try
      qry.Connection := fADOConnection;
      try
        Sql.Clear;
        Sql.Text := 'SELECT BinID,QtyOnHand FROM tblpartslocations Where PARTSID=' + IntToStr(PartID) +
          ' AND ClassID=' + IntToStr(ClassID) + ';';
        Open;
        First;
        while not Eof do begin
          Edit;
          FieldByName('QtyOnHand').AsFloat := BinQty(PartID, ClassID, FieldByName('BinID').AsInteger);
          Post;
          Next;
        end;
      except
      end;
    finally
      Free;
    end;
end;

function TBatchObj.BinQty(const PartID, ClassID, BinID: integer): double;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  with qry do try
      Connection := fADOConnection;
      Sql.Clear;
      Sql.Text := 'SELECT  Sum(AddQty) as Qty FROM tblpartslocationchanges ' + 'Where PARTSID=' +
        IntToStr(PartID) + ' AND ClassID=' + IntToStr(ClassID) + ' AND BinID=' + IntToStr(BinID) + ';';
      Active := true;

      if not qry.IsEmpty then begin
        Result := qry.FieldByName('Qty').AsFloat;
      end else begin
        Result := 0.00;
      end;
        
    finally
      Free;
    end;
end;

end.
