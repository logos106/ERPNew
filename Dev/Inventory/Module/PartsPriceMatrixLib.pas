unit PartsPriceMatrixLib;

interface
uses   busobjPartsPriceMatrix;
procedure ReadDefaultPriceMethod(const sql:String; var MatrixDesc, MatrixRef: STring; var MatrixPrice: Double);
Procedure ReadSalesDefaultPriceMethod(const fiProductID:Integer; var MatrixDesc:String; var MatrixRef:STring; var MatrixPrice:Double);
Procedure ReadPurchaseDefaultPriceMethod(const fiProductID:Integer; var MatrixDesc:String; var MatrixRef:STring; var MatrixPrice:Double);
function ParthasPriceMatrix(const PartsID:Integer):Boolean;
Function MatrixValueReftoMatrixValue(const ValueRef:String;MatrixItemObj :TMatrixItemObj):String;


implementation

uses CommonLib, ERPdbComponents, sysutils, CommonDbLib , classes, idstrings;


Function MatrixValueReftoMatrixValue(const ValueRef:String; MatrixItemObj :TMatrixItemObj):String;
var
  ctr:Integer;
  st:TStringList;
begin
  result :='';
  st:= tStringList.create;
  Try
    st.commatext := ValueRef;
    if st.count =0 then exit;
    for ctr := 0 to st.count-1 do begin
      MatrixItemObj.RefData :=st[ctr];
      MatrixItemObj.Itemtype := 'R';
      if result<> '' then result := Result +',';
      result := result +MatrixItemObj.DescData;
    end;
  Finally
    Freeandnil(st);
  End;
end;


function ParthasPriceMatrix(const PartsID:Integer):Boolean;
begin
  With TempMyQuery do try
    SQL.add('SELECT * FROM tblpartspricemethod Where ProductId = ' +inttostr(PartsID));
    open;
    result := recordcount > 0;
  finally
    if active then close;
    Free;
  end;

end;

procedure ReadPurchaseDefaultPriceMethod(const fiProductID: Integer; var MatrixDesc, MatrixRef: STring; var MatrixPrice: Double);
var
  s:String;
begin
  s:= 'Select  '+
        ' concat("[" , Concat_ws(":",PME.ID , PMV.ID), "]") ref ,  '+
        ' concat("[" , Concat_ws(":",PME.Name , PMV.Value) , "]") as Description '+
        ' from tblpartspricemethod PM '+
        ' inner join tblpartspricemethodentries PME on PME.PriceMethodID = PM.ID '+
        ' inner join tblpartspricemethodvalues PMV on PME.ID = PMV.PriceEntryID '+
        ' Where PMV.PurchaseDefault = "T" '+
        ' and PM.ProductId = '+inttostr(fiProductID);
  ReadDefaultPriceMethod(s ,  MatrixDesc,   MatrixRef,  MatrixPrice);
end;

procedure ReadSalesDefaultPriceMethod(const fiProductID: Integer; var MatrixDesc, MatrixRef: STring; var MatrixPrice: Double);
var
  s:String;
begin
  s:= 'Select  '+
        ' concat("[" , Concat_ws(":",PME.ID , PMV.ID), "]") ref ,  '+
        ' concat("[" , Concat_ws(":",PME.Name , PMV.Value) , "]") as Description '+
        ' from tblpartspricemethod PM '+
        ' inner join tblpartspricemethodentries PME on PME.PriceMethodID = PM.ID '+
        ' inner join tblpartspricemethodvalues PMV on PME.ID = PMV.PriceEntryID '+
        ' Where PMV.SalesDefault = "T" '+
        ' and PM.ProductId = '+inttostr(fiProductID);
  ReadDefaultPriceMethod(s ,  MatrixDesc,   MatrixRef,  MatrixPrice);
  (*Qry := CommonDbLib.TempMyQuery;
  Try
    Qry.SQL.add(s);
    Qry.open;
    MatrixDesc := Qry.GroupConcat('Description');
    MatrixRef := Qry.GroupConcat('Ref');
    MatrixPrice:= 0;
    s:= Qry.GroupConcat('Ref' , '', False , ' and ' ,'EntrynValueRef like ''%' , '%''');
    if s= '' then exit;
    Qry.close;
    Qry.SQl.clear;
    Qry.sql.add('SELECT Price FROM tblpartspriceentry Where '+s);
    Qry.open;
    MatrixPrice:= Qry.Fieldbyname('Price').asFloat;
  Finally
    if Qry.active then Qry.close;
    Freeandnil(Qry);
  End;*)
end;
procedure ReadDefaultPriceMethod(const sql:String; var MatrixDesc, MatrixRef: STring; var MatrixPrice: Double);
var
  Qry :TERPQuery;
  s:String;
begin
  s:= SQL;
  Qry := CommonDbLib.TempMyQuery;
  Try
    Qry.SQL.add(s);
    Qry.open;
    MatrixDesc := Qry.GroupConcat('Description');
    MatrixRef := Qry.GroupConcat('Ref');
    MatrixPrice:= 0;
    s:= Qry.GroupConcat('Ref' , '', False , ' and ' ,'EntryValueRef like ''%' , '%''');
    if s= '' then exit;
    Qry.close;
    Qry.SQl.clear;
    Qry.sql.add('SELECT Price FROM tblpartspriceentry Where '+s);
    Qry.open;
    MatrixPrice:= Qry.Fieldbyname('Price').asFloat;
  Finally
    if Qry.active then Qry.close;
    Freeandnil(Qry);
  End;
end;

end.
