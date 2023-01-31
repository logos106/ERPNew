unit BusObjBOMSalesOrder;

interface

Uses BusObjsales, Types;

Type
  TBOMSalesOrder = Class(TSalesOrder)
  private
  Protected
  Public
    function DoPartialBuild(Const aSaleLineID: Integer;
      aProcTreeID: Integer; ToBuildQty: Double; BatchNoFormat: TStringDynArray;
      SNFormat: TStringDynArray; var ProcProgID: Integer): Boolean; overload;
    function DoPartialBuild(Const aSaleLineID: Integer;
      aProcTreeID: Integer; ToBuildQty: Double; BatchNoFormat: string;
      SNFormat: string; var ProcProgID: Integer): Boolean; overload;
  end;

implementation

uses BusobjProctree, AppEnvironment, ProcProgressLib,
  CommonLib, Barcodeconst, BusObjBase, sysutils, tcDataUtils, dateutils,
  BusObjConst, tcConst, StrUtils, LogLib;

Function TBOMSAlesORder.DoPartialBuild(Const aSaleLineID: Integer;
  aProcTreeID: Integer; ToBuildQty: Double; BatchNoFormat: TStringDynArray;
  SNFormat: TStringDynArray; var ProcProgID: Integer): Boolean;
var
  proctree: Tproctree;
  InvoicedOn: TDateTime;
  aPPGMsg :String;


  function MakeInvoice: Boolean;
  var
    InvoiceObj: TInvoice;
  begin
    InvoiceObj := TInvoice.Create(nil);
    try
      InvoiceObj.IgnoreAccesslevel := TRue;
      InvoiceObj.CreatingsalesOrderInvoice := TRue;
      InvoiceObj.silentMode := TRue;
      InvoiceObj.Connection := Self.Connection;
      InvoiceObj.Load(0);
      InvoiceObj.New;
      InvoicedOn := incsecond(InvoicedOn);
      copyobjRec('Saledatetime', InvoicedOn, InvoiceObj);
      InvoiceObj.DocNumber := inttostr(InvoiceObj.ID);
      InvoiceObj.Saledatetime := InvoicedOn;
      InvoiceObj.PostDB;
      InvoiceObj.SaleDate := InvoicedOn;
      InvoiceObj.PostDB;
      InvoiceObj.SalesOrderGlobalRef := globalref; // SOGlobalRef;
      InvoiceObj.RepairGlobalref := RepairGlobalref;
      // if repair's Salesorder is converted the invoice should also be linked to the sales order
      InvoiceObj.IsSalesOrder := False;
      InvoiceObj.IsInvoice := TRue;
      InvoiceObj.OriginalDocNumber := '';
      InvoiceObj.BaseNo := '';
      InvoiceObj.BackOrderGlobalRef := '';
      InvoiceObj.Comments := 'Sales Order # ' + Quotedstr(globalref) + ' is partially invoiced' + NL
        + InvoiceObj.Comments;
      if AppEnv.CompanyPrefs.UseBarcodePicking and
        not(AppEnv.CompanyPrefs.BarcodePickingInSOMode) then
        InvoiceObj.IsBarcodePicking := TRue;
      if InvoiceObj.ShipDate < InvoiceObj.SaleDate then
        InvoiceObj.ShipDate := InvoiceObj.SaleDate;
      InvoiceObj.PostDB;
      InvoiceObj.Lines.New;
      InvoiceObj.Lines.PPGInvoiced := TRue;
      InvoiceObj.Lines.PPGRef := proctree.ProcTreePart.ManufacturedProgress.globalref;
      InvoiceObj.Lines.ProductId := proctree.ProcTreePart.ManufacturedProgress.ProductId;
      InvoiceObj.Lines.UnitOfMeasureID := proctree.ProcTreePart.ManufacturedProgress.uomid;
      InvoiceObj.Lines.QtySold := proctree.ProcTreePart.ManufacturedProgress.Qty;
      InvoiceObj.Lines.QtyShipped := proctree.ProcTreePart.ManufacturedProgress.Qty;
      InvoiceObj.Lines.Linecost := Lines.Linecost;
      InvoiceObj.Lines.LinePriceinc := Divzer(Lines.TotalLineamountinc, Lines.QtyShipped);
      InvoiceObj.Lines.PostDB;
      InvoiceObj.Lines.CalcLineTotals;
      InvoiceObj.CalcOrdertotals;
      result := InvoiceObj.Save;
      if result then
      else if InvoiceObj.REsultStatus.HasError then
        InvoiceObj.REsultStatus.AddItem(False, rssWarning, 0, InvoiceObj.REsultStatus.Allmessages);

      if AppEnv.CompanyPrefs.ApplyPrepaymentsOnSOConversion then
        ApplyPrepayment(InvoiceObj);

    finally
      FreeandNil(InvoiceObj);
    end;
  end;

begin
  inherited;
  Result := False;
  ProcProgID:=0;
  InvoicedOn := now;

  if not LockRec then begin
    ResultStatus.AddItem(False, rssWarning, 0, replacestr(UserLock.LockMessage,
      'Unable to update data.', 'Unable to Build #' + inttostr(ID) + '.'), true);
    Exit;
  end;
  try
    if Lines.locate(Lines.idfieldname, aSaleLineID, []) = False then begin
      ResultStatus.AddItem(False, rssWarning, 0, 'Sales Order Item Not found', TRue);
      Exit;
    end;

    SendEvent(BusObjEvent_UserInfoMessage, 'Building ' + Floattostr(ToBuildQty) + ' of ' + trim(Lines.ProductName) + '.');
    try
      if aProctreeID <> 0 then begin
        proctree := Lines.proctree;
        if not proctree.locate('proctreeId ', aProctreeID, []) then begin
          REsultStatus.AddItem(False, rssinfo, 0, 'BOM Item not found', TRue);
          Exit;
        end;
      end
      else
        proctree := Lines.Rootproctree;

      if proctree.count = 0 then begin
        REsultStatus.AddItem(False, rssinfo, 0, 'BOM Item not found', TRue);
        Exit;
      end;
      showProgress(WAITMSG, 10);
      try
          Connection.BeginTransaction;
          try
            if proctree.DoBuildaQty(dqtOk, InvoicedOn, ToBuildQty, BatchNoFormat, SNFormat, ProcProgID,aPPGMsg) then  begin
              if (proctree.ParentId = 0) and not(IsInternalOrder) then begin
                if not MakeInvoice then begin
                  ProcProgID := 0;
                  Connection.RollbackTransaction;
                  Exit;
                end;
              end
              else begin
              end;
              logtext(aPPGMsg);
              Connection.CommitTransaction;

              if (proctree.ParentId = 0) and not(IsInternalOrder) then
                REsultStatus.AddItem(TRue, rssinfo, 0, Floattostr(ToBuildQty) + ' of ' +
                  trim(proctree.caption) + ' is being Built and is Invoiced.', TRue)
              else
                REsultStatus.AddItem(TRue, rssinfo, 0, Floattostr(ToBuildQty) + ' of ' +
                  trim(proctree.caption) + ' is being Built and is Placed into Stock.', TRue);
              REsult := TRue;
            end
            else begin
              Connection.RollbackTransaction;
              ProcProgID  := 0;
            end;
          Except
            on E: Exception do begin
              REsultStatus.AddItem(False, rssinfo, 0, 'Building Process Failed.' + NL +
                E.message, TRue);
              Connection.RollbackTransaction;
              ProcProgID := 0;
              Exit;
            end;
          end;
      finally
        HideProgress;
      end;
    finally
      // Freeandnil(proctree);
    end;
  finally
    UserLock.UnLock(BusobjectTableName, ID, LockGroupName);
  end;
end;

function TBOMSalesOrder.DoPartialBuild(const aSaleLineID: Integer;
  aProcTreeID: Integer; ToBuildQty: Double; BatchNoFormat, SNFormat: string;
  var ProcProgID: Integer): Boolean;
var
  ArrBatchNoFormat, ArrSNFormat: TStringDynArray;
begin
  ArrBatchNoFormat := SplitString(BatchNoFormat,',');
  ArrSNFormat := SplitString(SNFormat,',');
  result :=
    DoPartialBuild(aSaleLineID, aProcTreeID, ToBuildQty, ArrBatchNoFormat, ArrSNFormat, ProcProgID);
end;

end.
