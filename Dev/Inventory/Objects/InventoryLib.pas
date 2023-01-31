unit InventoryLib;

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 20/04/05  1.00.00 IJB  Initial version.
  // 07/07/05  1.00.01 DMS  1. Added 2 SetUseBins... procedures.
  // 07/07/05  1.00.02 DMS  1. Added SetReOrderDataForClass procedure.

interface

uses SysUtils, MyAccess,ERPdbComponents , StdCtrls;

procedure SetReOrderDataForClass(Const AClassName,sFilter: string; const ReOrderPoint, PreferredLevel, ReOrderAmount: integer);
procedure SetUseBinsForAllProducts(const Value: boolean; const ActiveRecordsOnly: boolean = true);
procedure SetUseBinsForProduct(const AProductID: integer; const Value: boolean);
function DiscountOverrideHint:String;
function BinAdjhint(Const IsStockAdjust :Boolean) :String;
function BatchAdjhint(Const IsStockAdjust :Boolean) :String;
function SNAdjhint(Const IsStockAdjust :Boolean) :String;
function Adjhint(IsStockAdjust:Boolean; Batch,Bin,SN:Boolean) :String;
procedure LineNumbers(const cbo : TComboBox);


implementation

uses CommonDBLib, Controls, Forms, FastFuncs, CommonLib, tcConst,
  DbSharedObjectsObj;

function DiscountOverrideHint:String;
begin
    Result := 'Discount Override Works in This Order'+chr(13)+
              '(Don''t Recommend  you Mix - See Help F1)'+chr(13)+chr(13)+
              '     1.  Product''s Extra Sell Price'+chr(13)+
              '     2.  Customer''s Special Product Price'+chr(13)+
              '     3.  Customer''s Group Discount'+chr(13)+
              '     4.  Special Product Price Overrides All Discounts '+chr(13)+
              '           For All customers(Company Preference).'+chr(13)+chr(13);
end;
procedure SetReOrderDataForClass(Const AClassName,sFilter: string; const ReOrderPoint, PreferredLevel, ReOrderAmount: integer);
var
  fsFilter: string;
begin
  fsFilter := sFilter;
  with TERPCommand.Create(nil) do try
      Connection := GetSharedMyDacConnection;
      SQL.Add('UPDATE tblProductclasses ');
      SQL.Add('Inner Join tblparts ON tblProductclasses.ProductID = tblparts.PARTSID ');
      SQL.Add('SET tblProductclasses.ReOrderPoint = ' + floattoStr(ReOrderPoint) +',');
      SQL.Add('tblProductclasses.PreferredLevel   = ' + floatToStr(PreferredLevel) +', ');
      SQL.Add('tblProductclasses.ReOrderAmount    = ' +floattoStr(ReOrderAmount));
      SQL.Add('WHERE tblProductclasses.ClassName  = ' +quotedStr(AClassName));
      If not (Trim(fsFilter) =  '') then  SQL.Add('AND '+fsFilter);
      Execute;
    finally
      Free;
    end;
end;

procedure SetUseBinsForProduct(const AProductID: integer; const Value: boolean);
var
  BinsValue: string;
begin
  with TERPQuery.Create(nil) do try
      Connection := GetSharedMyDacConnection;
      SQL.Add('UPDATE tblparts SET MultipleBins = :BinsValue');
      SQL.Add('WHERE PartsID = :ProductID');
      if Value then SQL.Add('AND ((PARTTYPE = "INV") or (PARTTYPE = "GRP"))');
      
      ParamByName('ProductID').AsInteger := AProductID;
      BinsValue := 'T';
      if not Value then BinsValue := 'F';
      ParamByName('BinsValue').AsString := BinsValue;
      Execute;
    finally
      Free;
    end;
end;

procedure SetUseBinsForAllProducts(const Value: boolean; const ActiveRecordsOnly: boolean = true);
var
  BinsValue: string;
begin
  with TERPQuery.Create(nil) do try
      Processingcursor(True);
      Connection := GetSharedMyDacConnection;
      SQL.Add('UPDATE tblparts SET MultipleBins = :BinsValue');

      if ActiveRecordsOnly then begin
        SQL.Add('WHERE Active = :IsActive AND ((PARTTYPE = "INV") or (PARTTYPE = "GRP"))');
        ParamByName('IsActive').AsString := 'T';
      end else SQL.Add('WHERE ((PARTTYPE = "INV") or (PARTTYPE = "GRP"))');

      BinsValue := 'T';
      if not Value then BinsValue := 'F';
      ParamByName('BinsValue').AsString := BinsValue;

      Execute;
    finally
      Processingcursor(False);
      Free;
    end;
end;

function BinAdjhint(Const IsStockAdjust :Boolean) :String;begin  Result := Adjhint(IsStockAdjust , false,True,False);end;
function BatchAdjhint(Const IsStockAdjust :Boolean) :String;begin  Result := Adjhint(IsStockAdjust , True,False,False);end;
function SNAdjhint(Const IsStockAdjust :Boolean) :String;begin  Result := Adjhint(IsStockAdjust , false,False, TRue);end;

function Adjhint(IsStockAdjust:Boolean; Batch,Bin,SN:Boolean) :String;
  Function AllocType        :String;begin  result := iif(Batch , 'Batch' , iif(Bin , 'Bin' , 'Serial Number'));                               end;
  Function OtherAllocTypes  :String;begin  result := iif(Batch , 'Bin / Serial Number' , iif(Bin , 'Batch / Serila number' , 'Batch / Bin')); end;
  function AllAdjform       :String;begin  if IsStockAdjust then Result := 'Stock Adjustment'  else Result := 'Stock Transfer';               end;

begin
  Result := AllocType + ' ' + iif(IsStockAdjust , 'Stock Adjustment' , 'Stock Transfer') +' Allows you to select Products that are Just ' + Quotedstr(AllocType)+' Enabled.'+NL+
          'Please choose ' + Quotedstr(AllAdjform) +' for Products that have Combination (Bin/Batch/Serial Number) Enabled.';
end;
procedure LineNumbers(const cbo : TComboBox);
var
  qry: TERPQuery;
begin
  cbo.items.clear;
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    closedb(qry);
    qry.sql.text :=' SELECT DISTINCT BuildLineNo   as Value FROM tblproctree  where ifnull(BuildLineNo   ,0)<> 0 Order by BuildLineNo';
    OpenDB(qry);
    if qry.recordcount > 0 then begin
      While qry.eof = false do begin
        cbo.items.add(inttostr(Qry.fieldbyname('Value').asInteger));
        qry.next;
      end;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
end.
