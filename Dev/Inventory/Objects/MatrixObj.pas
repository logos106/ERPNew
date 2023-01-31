unit MatrixObj;

interface
  uses ERPdbComponents, classes, JSONObject;
type
  TMatrixsale = class(TComponent)
    Private
      fiSaleId :Integer;
      figroupID :Integer;
      fsMatrixtablename:String;
      fconn : TERPConnection;
      fQryMatrix :TERPQuery;
      fQrynames :TERPQuery;
      fQryBOM :TERPQuery;
      fQryYCaptions :TERPQuery;
      ExtraAttribs :Integer;
      YAttribs :Integer;
      fbDeleteMatrixTableOnDestroy:Boolean;
      fbYMode:Boolean;
      //Json :TJsonObject ;
      Procedure YCaptionsRec(PAGID:Integer; PAGName:String;YAxisID:Integer);
      Procedure MatrixRecs(PAGID:Integer; PAGName:String);
      function NewQuery:TERPQuery;
      function getconn: TERPConnection;
      Function QryMatrix :TERPQuery;
      Function Qrynames :TERPQuery;
      Function QryBOM :TERPQuery;
      Function QryYCaptions :TERPQuery;
      function YValueToNo(const YValue: String; PAGID: Integer): Integer;
      procedure MakeQry(var Qry: TERPQuery; SQL: String);
      function ProductIDToNo(const ProductID: Integer; PAGID: Integer): Integer;
      Procedure UpdateYValues(const PAGID:Integer);
      Procedure SalesMatrix;
      function ExtraFields:String;
      Function Yfieldcond(const Value:String):String;
      Procedure makeBOMTable;
    Protected

    Public
      constructor Create(AOwner:TComponent);override;
      Destructor Destroy;override;
      Procedure NamesRec(PAGID:Integer);
      Procedure MakeMatrixTables;
      Procedure EmptyTables;
      Property SaleID :Integer read fiSaleId write fiSaleId;
      Property groupID :Integer read figroupID write figroupID;
      Property Matrixtablename :String read fsMatrixtablename;
      Property conn : TERPConnection read getconn write fconn;
      Procedure MakeMatrixTable(IsYMode:Boolean);
      Property DeleteMatrixTableOnDestroy :Boolean read fbDeleteMatrixTableOnDestroy write fbDeleteMatrixTableOnDestroy;
      Function SalesMatrixReportSQL(IsInvoice:Boolean;IncludeBOM:Boolean ):string;
      Function MatrixReportSQL:String;
      Property YMode :Boolean read fbYMode write fbYMode;
      function YFields:String;
      Function xValues(delimeterPrefix:boolean;delimeter:String):String;
      function SaleaMtrixMasterDetailLink(IncludeBOM:Boolean): TJsonObject;
  end;




implementation

uses CommonDbLib, CommonLib ,SysUtils, variants, tcConst, AppEnvironment;

constructor TMatrixsale.create(AOwner: TComponent);
begin
  inherited;
  fisaleID:= 0;
  figroupID:= 0;
  fconn := nil;
  fQryMatrix := Nil;
  fQrynames := Nil;
  fQryBOm := nil;
  fQryYCaptions:= Nil;
  fsMatrixtablename := '';
  fbDeleteMatrixTableOnDestroy := True;
  fbYMode:= True;
  //Json:= nil;
end;

destructor TMatrixsale.destroy;
begin
  if DeleteMatrixTableOnDestroy then begin
    DestroyUserTemporaryTable(fsMatrixtablename);
    DestroyUserTemporaryTable(fsMatrixtablename+'BOM');
  end;
  DestroyUserTemporaryTable(fsMatrixtablename+'YCaptions');
  DestroyUserTemporaryTable(fsMatrixtablename+'Names');
  //if assigned(Json) then Json.Free;
  inherited;
end;

function TMatrixsale.getconn: TERPConnection;
begin
  if not Assigned(fconn) then fconn := GetNewMyDacConnection(Self)
  else if FConn.Connected =False then fconn.Connected:= True;
  if FConn.Connected =False then fconn := GetNewMyDacConnection(Self);
  Result := fconn;
end;

Procedure  TMatrixsale.MakeMatrixTable(IsYMode:Boolean);
var
  Qry:TERPQuery;
  GroupIds:String;
  SoldFields ,  ShippedFields  , BOFields:String;
  Taxfields, TotAmtFields,TotAmtIncFields:String;
  ctr:Integer;
begin
  YMode := ISYMode;
  MakeMatrixTables;
  if fsMatrixtablename = '' then exit;
  Qry:= NewQuery;
  try
    if SaleID <> 0 then begin
      Qry.SQL.text := 'Select Distinct PAG_ID from tblsaleslines SL inner join  tblproductattributeproducts PAP on SL.ProductId = PAP.ProductID where SL.saleId = ' + inttostr(SaleID);
      Qry.open;
      GroupIDs := Qry.groupconcat('PAG_ID');
    end else begin
      GroupIDs := inttostr(groupID);
    end;

    if GroupIDs = '' then exit;

    Qry.close;
    Qry.SQL.text := 'Select * from tblproductattributegroups where PAG_ID in (' +GroupIDs+')';
    Qry.open;
    if Qry.recordcount =0 then exit;

    Qry.first;
    While Qry.Eof = False do begin
      if YMode then YCaptionsRec(Qry.fieldbyname('PAG_ID').asInteger , Qry.fieldbyname('Name').AsString, Qry.fieldbyname('yAxisAttribute').asInteger)
      else YCaptionsRec(Qry.fieldbyname('PAG_ID').asInteger , Qry.fieldbyname('Name').AsString, Qry.fieldbyname('XAxisAttribute').asInteger);
      NamesRec(Qry.fieldbyname('PAG_ID').asInteger );
      MatrixRecs(Qry.fieldbyname('PAG_ID').asInteger , Qry.fieldbyname('Name').AsString);
      Qry.Next;
    end;
    if SaleID = 0 then exit;
    SalesMatrix;
  finally
    Qry.closenFree;
  end;

      SoldFields:= '';
      ShippedFields:= '';
      BOFields:='';
      Taxfields:= '';
      TotAmtFields:= '';
      TotAmtIncFields:='';
      for ctr:= 1 to YAttribs do begin
        if SoldFields   <> '' then SoldFields     := SoldFields    +'+'; SoldFields   := SoldFields   +' Sold'    + trim(inttostr(ctr));
        if ShippedFields<> '' then ShippedFields  := ShippedFields +'+'; shippedFields:= shippedFields+' shipped' + trim(inttostr(ctr));
        if BOFields     <> '' then BOFields       := BOFields      +'+'; BOFields     := BOFields     +' BO'      + trim(inttostr(ctr));
        if Taxfields     <> '' then Taxfields       := Taxfields      +'+'; Taxfields     := Taxfields     +' LineTax'      + trim(inttostr(ctr));
        if TotAmtFields     <> '' then TotAmtFields       := TotAmtFields      +'+'; TotAmtFields     := TotAmtFields     +' TotalLineAmount'      + trim(inttostr(ctr));
        if TotAmtIncFields     <> '' then TotAmtIncFields       := TotAmtIncFields      +'+'; TotAmtIncFields     := TotAmtIncFields     +' TotalLineAmountInc'      + trim(inttostr(ctr));


      end;

      with tempMyscript(conn) do try
        if (SoldFields<> '') and (ShippedFields<> '') and (BOFields<>'') then
          SQL.Add('update ' + fsMatrixtablename +' set sumSold = ' + SoldFields+',' + ' sumShipped = ' + ShippedFields+',' + ' sumBO = ' + BOFields+';');
        if (Taxfields<> '') and (TotAmtFields<> '') and (TotAmtIncFields<>'') then
          SQL.Add('update ' + fsMatrixtablename +' set sumLineTax = ' + Taxfields+',' + ' sumTotalLineAmount = ' + TotAmtFields+',' + ' sumTotalLineAmountInc = ' + TotAmtIncFields+';');
        if SQL.count >0 then Execute;
      finally
        Free;
      end;
end;


Procedure TMatrixsale.MatrixRecs(PAGID:Integer; PAGName:String);
var
  QryProducts,QryProductAttribs  :TERPQuery;
  sLocate1  :String;
  sLocate2:Array of variant;
  yValue:String;
begin
  QryProducts := Newquery;
  QryProductAttribs:= Newquery;
  try
    QryProducts.SQL.Text := 'Select distinct ProductName , ProductId  from tblproductattributeproducts where PAG_ID = ' + inttostr( PAGID);
    QryProducts.open;
    if QryProducts.recordcount =0 then exit;
    while QryProducts.Eof = False do begin
      closedb(QryProductAttribs);
      if YMode then
        QryProductAttribs.SQL.Text := 'select PAG.Name as Groupname, PAN.Name , PAV.Value , PAP.ProductID , PAP.ProductName  , PANY.Name as YName , if(PAG.XAxisAttribute = PAN.PAN_ID , "T", "F") IsX, if(PAG.YAxisAttribute = PAN.PAN_ID , "T", "F") IsY' +
                                    ' from   tblproductattributegroups PAG ' +
                                    ' inner join tblproductattributenames PAN  on PAG.PAG_ID = PAN.PAG_ID ' +
                                    ' Left join tblproductattributenames PANY  on PAG.PAG_ID = PAN.PAG_ID and PAG.YAxisAttribute =  PANY.PAN_ID ' +
                                    ' inner join tblproductattributevalues PAV on PAN.PAN_ID = PAV.PAN_ID ' +
                                    ' inner join tblproductattributeproducts PAP on PAP.PAG_ID = PAN.PAG_ID and PAP.AttribName = PAN.Name and PAP.AttribValue = PAV.Value ' +
                                    ' where  PAG.PAG_ID = ' +  inttostr(PAGID) +' and  PAP.ProductId = ' + IntToStr(QryProducts.FieldByName('ProductID').AsInteger)
      else
        QryProductAttribs.SQL.Text := 'select PAG.Name as Groupname, PAN.Name , PAV.Value , PAP.ProductID , PAP.ProductName  , PANY.Name as YName , if(PAG.YAxisAttribute = PAN.PAN_ID , "T", "F") IsX, if(PAG.XAxisAttribute = PAN.PAN_ID , "T", "F") IsY' +
                                    ' from   tblproductattributegroups PAG ' +
                                    ' inner join tblproductattributenames PAN  on PAG.PAG_ID = PAN.PAG_ID ' +
                                    ' Left join tblproductattributenames PANY  on PAG.PAG_ID = PAN.PAG_ID and PAG.XAxisAttribute =  PANY.PAN_ID ' +
                                    ' inner join tblproductattributevalues PAV on PAN.PAN_ID = PAV.PAN_ID ' +
                                    ' inner join tblproductattributeproducts PAP on PAP.PAG_ID = PAN.PAG_ID and PAP.AttribName = PAN.Name and PAP.AttribValue = PAV.Value ' +
                                    ' where  PAG.PAG_ID = ' +  inttostr(PAGID) +' and  PAP.ProductId = ' + IntToStr(QryProducts.FieldByName('ProductID').AsInteger);
      QryProductAttribs.open;
        if QryProductAttribs.recordcount >0 then begin
          QryProductAttribs.first;
          sLocate1:= 'PAG_ID';
          SetLength(sLocate2, 1); sLocate2[0] := PAGID;
          while QryProductAttribs.Eof = False do begin
            if QryProductAttribs.fieldByname('IsY').AsBoolean then begin
              yValue :=  QryProductAttribs.FieldByName('Value').AsString;
            end else if QryProductAttribs.fieldByname('IsX').AsBoolean then begin
              sLocate1 := sLocate1 +';';            sLocate1 := sLocate1 + 'xValue';
              SetLength (sLocate2 , length(sLocate2)+1);sLocate2[high(sLocate2)] := QryProductAttribs.FieldByName('Value').AsString;
            end else begin
              if Qrynames.Locate('PAG_ID;name' , varArrayof([PAGID , QryProductAttribs.FieldByName('name').AsString]) , []) then begin
                sLocate1 := sLocate1 +';';            sLocate1 := sLocate1 + 'ExValue'+trim(inttostr(Qrynames.fieldbyname('Seqno').AsInteger));
                SetLength (sLocate2 , length(sLocate2)+1);sLocate2[high(sLocate2)] := QryProductAttribs.FieldByName('Value').AsString;
              end;
            end;
            QryProductAttribs.Next;
          end;
        end;
        try
            if (sLocate1='') and (QryMatrix.recordcount>0) then
            else if (sLocate1 <> '') and (QryMatrix.Locate(sLocate1, sLocate2, [])) then
            else begin
              QryProductAttribs.first;
              QryMatrix.Append;
              QryMatrix.fieldbyname('PAG_ID').asInteger := PAGID;
              QryMatrix.fieldbyname('gROUPNAME').AsString := QryProductAttribs.fieldByname('Groupname').asString;
              UpdateYValues(PAGID);
              while QryProductAttribs.Eof = False do begin
                if QryProductAttribs.fieldByname('IsY').AsBoolean then begin
                    yValue :=  QryProductAttribs.FieldByName('Value').AsString;
                    QryMatrix.FieldByName('YName').AsString := QryProductAttribs.FieldByName('name').AsString;
                end else if QryProductAttribs.fieldByname('IsX').AsBoolean then begin
                  QryMatrix.FieldByName('xname').AsString := QryProductAttribs.FieldByName('name').AsString;
                  QryMatrix.FieldByName('xValue').AsString := QryProductAttribs.FieldByName('Value').AsString;
                end else begin
                  if Qrynames.Locate('Pag_ID;name' , VarArrayof([PAGID,QryProductAttribs.FieldByName('name').AsString]) , []) then begin
                    QryMatrix.FieldByName('Exname'+ trim(inttostr(Qrynames.fieldbyname('Seqno').AsInteger))).AsString := QryProductAttribs.FieldByName('name').AsString;
                    QryMatrix.FieldByName('ExValue'+ trim(inttostr(Qrynames.fieldbyname('Seqno').AsInteger))).AsString := QryProductAttribs.FieldByName('Value').AsString;
                  end;
                end;
                QryProductAttribs.Next;
              end;
            end;
        finally
          editDB(QryMatrix);
          QryMatrix.fieldByname('ProductID' + trim(inttostr(YValueToNo(yValue, PAGID)))).asInteger := QryProductAttribs.fieldByname('ProductID').AsInteger;
          PostDB(QryMatrix);
        end;
      QryProducts.Next;
    end;
  finally
    QryProducts.ClosenFree;
    QryProductAttribs.ClosenFree;
  end;
end;
function TMatrixsale.MatrixReportSQL: String;
begin
    result := '{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, CO.PhoneNumber AS PhoneNumber,  '+
                        ' CO.FaxNumber AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO';
    result := result + '~|||~{MatrixDetails}select  T.*, '+
                    'PAG.CUSTFLD1,PAG.CUSTFLD2,PAG.CUSTFLD3,PAG.CUSTFLD4,PAG.CUSTFLD5,'+
                    'PAG.CUSTFLD6,PAG.CUSTFLD7,PAG.CUSTFLD8,PAG.CUSTFLD9,PAG.CUSTFLD10,'+
                    'PAG.CUSTFLD11,PAG.CUSTFLD12,PAG.CUSTFLD13,PAG.CUSTFLD14,PAG.CUSTFLD15,'+
                    'PAG.CUSTDATE1,PAG.CUSTDATE2,PAG.CUSTDATE3';
    result := result + ' from ' +Matrixtablename +' as T'+
                  ' inner join tblproductattributegroups PAG on T.pag_Id = PAg.PAG_ID ';
    result := result + ' order by T.PAG_ID, '+ExtraFields+'xvalue' ;
end;

Function TMatrixsale.ProductIDToNo(const ProductID:Integer; PAGID:Integer):Integer;
var
  ctr:Integer;
begin
  REsult:= 0;
  if QryMatrix.Locate('PAG_ID' , PAGID , []) then
    for ctr:= 0 to QryMatrix.FieldCount-1 do begin
      if Sametext(copy(QryMatrix.fields[ctr].fieldname , 1,9 ), 'ProductID') then
        if QryMatrix.Locate('PAG_ID;'+QryMatrix.fields[ctr].fieldname, VarArrayof([PAGID,ProductID]) , []) then begin
          REsult :=strtoint(replaceStr(QryMatrix.fields[ctr].fieldname , 'ProductID', ''));
          Exit;
        end;
    end;

end;

Function TMatrixsale.YValueToNo(const YValue:String; PAGID:Integer):Integer;
var
  ctr:Integer;
begin
  REsult:= 1;
  if Qryycaptions.Locate('PAG_ID' , PAGID , []) then
    for ctr:= 0 to Qryycaptions.FieldCount-1 do begin
      if Sametext(copy(QryYCaptions.fields[ctr].fieldname , 1,6 ), 'Column') then
        if sametext(QryYCaptions.fields[ctr].asString , yvalue) then begin
          REsult :=strtoint(replaceStr(QryYCaptions.fields[ctr].fieldname , 'Column', ''));
          Exit;
        end;
    end;
end;
Procedure TMatrixsale.NamesRec(PAGID:Integer);
var
  ctr:Integer;
begin
    With TempMyQuery do try
      if YMode then
        SQl.Text := 'select PAG.PAG_ID, PAG.Name groupname,  PAN.* , if(PAG.XAxisAttribute = PAN.PAN_ID , "T", "F") IsX , if(PAG.YAxisAttribute = PAN.PAN_ID , "T", "F") IsY from tblproductattributegroups PAG ' +
                  ' inner join tblproductattributenames PAN  on PAG.PAG_ID = PAN.PAG_ID ' +
                  ' where PAN.Active ="T" and PAN.PAG_ID = '+ inttostr(PAGID)+' order by isX , PAN_ID'
      else
        SQl.Text := 'select PAG.PAG_ID, PAG.Name groupname,  PAN.* , if(PAG.XAxisAttribute = PAN.PAN_ID , "T", "F") IsY , if(PAG.YAxisAttribute = PAN.PAN_ID , "T", "F") IsX from tblproductattributegroups PAG ' +
                  ' inner join tblproductattributenames PAN  on PAG.PAG_ID = PAN.PAG_ID ' +
                  ' where PAN.Active ="T" and PAN.PAG_ID = '+ inttostr(PAGID)+' order by isX , PAN_ID';
      open;
      if recordcount =0 then exit;
      first;
      ctr:=0;
      While Eof = False do begin
        if fieldbyname('IsY').asBoolean =False then begin
          Qrynames.Append;
          Qrynames.fieldbyname('Groupname').AsString := fieldbyname('groupname').AsString;
          Qrynames.fieldbyname('PAG_ID').asInteger := fieldbyname('PAG_ID').asInteger;
          Qrynames.fieldbyname('Seqno').AsInteger := ExtraAttribs-ctr;
          Qrynames.fieldbyname('Name').AsString := fieldbyname('Name').AsString;
          Qrynames.fieldbyname('IsX').AsBoolean := fieldbyname('IsX').AsBoolean;
          Qrynames.Post;
          ctr:= ctr+1;
        end;
        Next;
      end;
    finally
      closenFree;
    end;
end;

function TMatrixsale.NewQuery: TERPQuery;
begin
  result := TempMyQuery(conn, self);
end;
Procedure TMatrixsale.MakeQry(var Qry:TERPQuery; SQL:String);
begin
  if Qry = nil then begin
    Qry := NewQuery;
    Qry.SQL.Text    := SQL;
  end;
  if Qry.active =False then Qry.Open;
end;

function TMatrixsale.QryMatrix    : TERPQuery; begin  MakeQry(fQryMatrix    ,   'Select * from '+ fsMatrixtablename             );  result :=fQryMatrix   ;end;
function TMatrixsale.Qrynames     : TERPQuery; begin  MakeQry(fQrynames     ,   'Select * from '+ fsMatrixtablename +'Names'    );  result :=fQrynames    ;end;
function TMatrixsale.QryYCaptions : TERPQuery; begin  MakeQry(fQryYCaptions ,   'Select * from '+ fsMatrixtablename +'YCaptions');  result :=fQryYCaptions;end;
function TMatrixsale.QryBOM       : TERPQuery; begin  MakeQry(fQryBOM       ,   'Select * from '+ fsMatrixtablename +'BOM'      );  result :=fQryBOM      ;end;

function TMatrixsale.SalesMatrixReportSQL(IsInvoice: Boolean;IncludeBOM:Boolean ): string;
var
  ctr:Integer;
begin
{1: CompanyInfo}
    result := '{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, CO.PhoneNumber AS PhoneNumber,  '+
                        ' CO.FaxNumber AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO';

{2: MatrixDetails}
    if includeBOM then makeBOMTable;
    result := result + '~|||~{MatrixDetails}select  T.*, '+
                    'PAG.CUSTFLD1,PAG.CUSTFLD2,PAG.CUSTFLD3,PAG.CUSTFLD4,PAG.CUSTFLD5,'+
                    'PAG.CUSTFLD6,PAG.CUSTFLD7,PAG.CUSTFLD8,PAG.CUSTFLD9,PAG.CUSTFLD10,'+
                    'PAG.CUSTFLD11,PAG.CUSTFLD12,PAG.CUSTFLD13,PAG.CUSTFLD14,PAG.CUSTFLD15,'+
                    'PAG.CUSTDATE1,PAG.CUSTDATE2,PAG.CUSTDATE3';
    if includeBOM then
      for ctr := 1 to yattribs do
        result := result + ',BOM.BOM' + trim(inttostr(ctr))+', '+
                           'BOM.tree' + trim(inttostr(ctr))+','+
                           'BOM.BOMQty' + trim(inttostr(ctr))+',  '+
                           'BOM.BOMtotalQty' + trim(inttostr(ctr))+','+
                           'BOM.BOMProductID' + trim(inttostr(ctr));
    result := result + ' from ' +Matrixtablename +' as T'+
                  ' inner join tblproductattributegroups PAG on T.pag_Id = PAg.PAG_ID ';
    if includeBOM then result :=result + ' left join  ' + Matrixtablename +'BOM as BOM on T.Id = BOM.Matrix_ID ';

    if Appenv.companyprefs.HideMatrixLineWithnoQty then result := result + Yfieldcond('<> 0');
    result := result + ' order by T.PAG_ID, '+ExtraFields+'xvalue' ;
    if includeBOM then begin
      result := result + ',matrix_Id';
      for ctr := 1 to yattribs do result := result + ',Sequencedown'+trim(inttostr(ctr));
    end;

{3: SalesDetails}
    result := result + '~|||~{SalesDetails}Select * from tblsales where SaleId = ' + inttostr(SaleID);
{4: NonMatrixProducts}
    result := result + '~|||~{NonMatrixProducts}select distinct SL.* from tblsaleslines SL   '+
                        ' left join tblproductattributeproducts PAP on SL.ProductID = PAP.ProductID   '+
                        ' where ifnull(PAP.PAG_ID,0)=0 and SL.saleId= ' + inttostr(SaleID);
{5: EarlyPayment}
    if IsInvoice then
      result := result + '~|||~{EarlyPayment} Select S.SAleID  ,abs(totallineamountinc) EarlyPaymentDiscountAmount ,   '+
                        ' if(ifnull(SL.SaleLineId,0)=0 , if(ifnull(T.EarlyPaymentDiscount ,0)=0 , 0 , S.totalamountinc*T.EarlyPaymentDiscount/100) , 0)      '+
                        ' from tblSales S   Left join tblsaleslines SL on  Sl.ProductName = '+Quotedstr(EARLY_PAYMENT_DISCOUNT_PRODUCT) +'  '+
                        ' and SL.sAleId = s.SAleID     Left join tblterms T on S.Terms = T.Terms where S.SaleId = ' + inttostr(SaleID);
{6: ShippingAddress}
    result := result + '~|||~{ShippingAddress}select SA.* from tblsales S inner join tblshippingaddress SA on S.ShipToID = SA.ShipAddressID Where S.SaleId = ' + inttostr(SaleID);
{7: ShippingDetails}
    result := result + '~|||~{ShippingDetails}Select * from  tblsalesshippingdetails where salesid = ' + inttostr(SaleID);
{8: Matrixsummary}
    result := result + '~|||~{Matrixsummary}select   GroupName, PAG_ID ';
    result := result +xValues(true, ',');//for ctr:= 1 to  ExtraAttribs do result := result +',exvalue' + trim(inttostr(ctr));
    for ctr := 1 to yattribs     do result := result +',Sum(Sold' + trim(inttostr(ctr))+') as Sold' + trim(inttostr(ctr))+', '+
                                                      'sum(Shipped' + trim(inttostr(ctr))+') as Shipped' + trim(inttostr(ctr))+',  '+
                                                      'Sum(BO' + trim(inttostr(ctr))+') as BO' + trim(inttostr(ctr))+',  '+
                                                      'Sum(LineTax' + trim(inttostr(ctr))+') as LineTax' + trim(inttostr(ctr))+',  '+
                                                      'Sum(TotalLineAmount' + trim(inttostr(ctr))+') as TotalLineAmount' + trim(inttostr(ctr))+',  '+
                                                      'Sum(TotalLineAmountInc' + trim(inttostr(ctr))+') as TotalLineAmountInc' + trim(inttostr(ctr));
    result := result +' from ' +Matrixtablename +'  as T  group by PAG_ID' ;
    result := result +xValues(true,',');//for ctr:= 1 to  ExtraAttribs do result := result +',exvalue' + trim(inttostr(ctr));
{9: Group details}
    result := Result +'~|||~{GroupDetails}select distinct * from tblproductattributegroups  where PAG_ID in (Select PAG_ID from ' +Matrixtablename +' T  )';
{10: Customfields}
  result := Result +'~|||~{Customfields}Select  /*if(CFProduct1 ="T",CFLabel1  , "") as */CFLabel1 ,'+
                                              ' /*if(CFProduct2 ="T",CFLabel2  , "") as */CFLabel2 ,'+
                                              ' /*if(CFProduct3 ="T",CFLabel3  , "") as */CFLabel3 ,'+
                                              ' /*if(CFProduct4 ="T",CFLabel4  , "") as */CFLabel4 ,'+
                                              ' /*if(CFProduct5 ="T",CFLabel5  , "") as */CFLabel5 ,'+
                                              ' /*if(CFProduct6 ="T",CFLabel6  , "") as */CFLabel6 ,'+
                                              ' /*if(CFProduct7 ="T",CFLabel7  , "") as */CFLabel7 ,'+
                                              ' /*if(CFProduct8 ="T",CFLabel8  , "") as */CFLabel8 ,'+
                                              ' /*if(CFProduct9 ="T",CFLabel9  , "") as */CFLabel9 ,'+
                                              ' /*if(CFProduct10="T",CFLabel10 , "") as */CFLabel10,'+
                                              ' /*if(CFProduct11="T",CFLabel11 , "") as */CFLabel11,'+
                                              ' /*if(CFProduct12="T",CFLabel12 , "") as */CFLabel12,'+
                                              ' /*if(CFProduct13="T",CFLabel13 , "") as */CFLabel13,'+
                                              ' /*if(CFProduct14="T",CFLabel14 , "") as */CFLabel14,'+
                                              ' /*if(CFProduct15="T",CFLabel15 , "") as */CFLabel15,'+
                                              ' /*if(CFProduct16="T",CFLabel16 , "") as */CFLabel16,'+
                                              ' /*if(CFProduct17="T",CFLabel17 , "") as */CFLabel17,'+
                                              ' /*if(CFProduct18="T",CFLabel18 , "") as */CFLabel18'+
                                              ' from tblcustomfields';

end;
procedure TMatrixsale.makeBOMTable;
var
  ctr:Integer;
begin
 for ctr := 1 to yattribs do begin
  QryMatrix.first;
  while QryMatrix.eof = False do begin
    if QryMatrix.fieldbyname('saleLineId' + trim(inttostr(ctr))).asInteger <> 0 then begin
            with NewQuery do begin
              SQL.add('Select PT.Caption as BOM, '+
                           ' Convert(TreeNodeCaption(PT.Level, PT.caption ), char(255)) tree,'+
                           ' PT.Quantity BOMQty,  '+
                           ' PT.TotalQty BOMtotalQty, '+
                           ' PT.SequenceDown , '+
                           ' PT.PartsId as BOMProductID '+
                           ' from tblproctree PT'+
                           ' where ParentId>0 and MasterType <> "mtProduct" and MasterId  = '+ inttostr(QryMatrix.fieldbyname('saleLineId' + trim(inttostr(ctr))).asInteger) );
              if Appenv.companyprefs.HideNonProductBOMEnrties then SQL.add('  and ifnull(PartsId,0)<>0');
              SQL.add('Order by Sequencedown');
              open;
              if recordcount >0 then begin
                First;
                while Eof = False do begin
                  QRYBOM.first;
                  if QRYBOM.Locate('Matrix_ID;BOM'+ trim(inttostr(ctr)), vararrayof([QryMatrix.fieldbyname('ID').asInteger , '']), [])=False then
                  if QRYBOM.Locate('Matrix_ID;BOM'+ trim(inttostr(ctr)), vararrayof([QryMatrix.fieldbyname('ID').asInteger , NULL]), [])=False then begin
                    QRYBOM.append;
                    QRYBOM.fieldbyname('Matrix_ID').asInteger :=QryMatrix.fieldbyname('ID').asInteger;
                    PostDB(QRYBOM);
                  end;
                  editDB(QRYBOM);
                  QRYBOM.fieldbyname('BOM'          + trim(inttostr(ctr))).asString   := FieldByname('BOM').asString;
                  QRYBOM.fieldbyname('Tree'         + trim(inttostr(ctr))).asString   := FieldByname('Tree').asString;
                  QRYBOM.fieldbyname('BOMQty'       + trim(inttostr(ctr))).asfloat    := FieldByname('BOMQty').asFloat;
                  QRYBOM.fieldbyname('BOMtotalQty'  + trim(inttostr(ctr))).asfloat    := FieldByname('BOMtotalQty').asFloat;
                  QRYBOM.fieldbyname('sequencedown' + trim(inttostr(ctr))).asInteger  := FieldByname('sequencedown').asInteger;
                  QRYBOM.fieldbyname('BOMProductID' + trim(inttostr(ctr))).asInteger  := FieldByname('BOMProductID').asInteger;
                  PostDB(QRYBOM);
                  Next;
                end;
              end;
            end;
    end;
    QryMatrix.Next;
  end;
 end;
end;

function TMatrixsale.SaleaMtrixMasterDetailLink(IncludeBOM:Boolean): TJsonObject;
begin
      //if assigned(Json) then Json.Free;
      (*Json*)Result:= JO;
      (*Json*)Result.O['1'].S['master']:= 'MatrixDetails';
      (*Json*)Result.O['1'].S['detail']:= 'GroupDetails';
      (*Json*)Result.O['1'].S['masterfields']:= 'PAG_ID';
      (*Json*)Result.O['1'].S['detailfields']:= 'PAG_ID';
      if IncludeBOM then begin
        (*Json*)Result.O['2'].S['master']:= 'MatrixDetails';
        (*Json*)Result.O['2'].S['detail']:= 'Matrixsummary';
        (*Json*)Result.O['2'].S['masterfields']:= 'PAG_ID'+ xValues(true,';');
        (*Json*)Result.O['2'].S['detailfields']:= 'PAG_ID'+ xValues(true,';');
      end;
end;

procedure TMatrixsale.SalesMatrix;
var
  QrySaleSLines :TERPQuery;
  ctr:Integer;
begin
  if saleId =0 then exit;
  if fsMatrixtablename = '' then exit;
  Qrysaleslines := NewQuery;
  try
    QrysalesLines.SQL.Text := ' select distinct SL.SaleLineId , SL.productname, SL.ProductId , '+
                               ' concat(SL.UnitofMeasureSaleLines , "(" , SL.UnitofMeasureMultiplier , ")") as UOM,   '+
                               ' SL.UnitofMeasureShipped , SL.UnitofMeasureQtySold , SL.UnitofMeasureBackorder , '+
                               ' PAP.PAG_ID , SL.LinePrice , SL.LinePriceInc , SL.LineTax , SL.TotalLineAmount, SL.TotalLineAmountInc '+
                               ' from tblsaleslines SL '+
                               ' left join tblproductattributeproducts PAP on SL.ProductID = PAP.ProductID '+
                               ' where SL.saleId =  '+ inttostr(SaleID) +
                               ' order by PAG_ID';
    QrysalesLines.open;
    if QrysalesLines.recordcount =0 then exit;

    QrysalesLines.first;
    While QrysalesLines.eof = False do begin
      ctr:=ProductIDToNo(QrysalesLines.fieldByname('ProductID').asInteger , QrysalesLines.fieldByname('PAG_ID').asInteger);
      if ctr > 0 then begin
        EditDB(QryMatrix);
        QryMatrix.fieldByname('SaleLineId' +TRim(inttostr(ctr))).asfloat:= QrysalesLines.fieldbyname('SaleLineId').AsInteger;
        QryMatrix.fieldByname('Sold' +TRim(inttostr(ctr))).asfloat      := QryMatrix.fieldByname('Sold' +TRim(inttostr(ctr))).asfloat     + QrysalesLines.fieldbyname('UnitofMeasureQtySold').asfloat;
        QryMatrix.fieldByname('shipped' +TRim(inttostr(ctr))).asfloat   := QryMatrix.fieldByname('shipped' +TRim(inttostr(ctr))).asfloat  + QrysalesLines.fieldbyname('UnitofMeasureShipped').asfloat;
        QryMatrix.fieldByname('BO' +TRim(inttostr(ctr))).asfloat        := QryMatrix.fieldByname('BO' +TRim(inttostr(ctr))).asfloat       + QrysalesLines.fieldbyname('UnitofMeasureBackorder').asfloat;
        QryMatrix.fieldByname('UOM' +TRim(inttostr(ctr))).asString      := QrysalesLines.fieldbyname('UOM').asString;
        QryMatrix.fieldByname('LinePrice' +TRim(inttostr(ctr))).asfloat := QrysalesLines.fieldbyname('LinePrice').asFloat;
        QryMatrix.fieldByname('LinePriceInc' +TRim(inttostr(ctr))).asfloat := QrysalesLines.fieldbyname('LinePriceInc').asFloat;
        QryMatrix.fieldByname('LineTax' +TRim(inttostr(ctr))).asfloat           := QryMatrix.fieldByname('LineTax' +TRim(inttostr(ctr))).asfloat            + QrysalesLines.fieldbyname('LineTax').asFloat;
        QryMatrix.fieldByname('TotalLineAmount' +TRim(inttostr(ctr))).asfloat   := QryMatrix.fieldByname('TotalLineAmount' +TRim(inttostr(ctr))).asfloat    + QrysalesLines.fieldbyname('TotalLineAmount').asFloat;
        QryMatrix.fieldByname('TotalLineAmountInc' +TRim(inttostr(ctr))).asfloat:= QryMatrix.fieldByname('TotalLineAmountInc' +TRim(inttostr(ctr))).asfloat + QrysalesLines.fieldbyname('TotalLineAmountInc').asFloat;
        PostDB(QryMatrix);
      end;
      QrysalesLines.next;
    end;
  finally
    QrysalesLines.ClosenFree;
  end;
end;

procedure TMatrixsale.UpdateYValues(const PAGID:Integer);
var
  ctr:Integer;
begin
    editDB(QryMatrix);
    if QryYCaptions.Locate('PAG_ID' ,PAGID , []) then
      for ctr:= 0 to Qryycaptions.FieldCount-1 do
        if Sametext(copy(QryYCaptions.fields[ctr].fieldname , 1,6 ), 'Column') then
          QryMatrix.fieldByname('YValue' + trim(replacestr(QryYCaptions.fields[ctr].fieldname,'column' , ''))).asString :=  QryYCaptions.fields[ctr].AsString;
end;

function TMatrixsale.xValues(delimeterPrefix: boolean;delimeter:String): String;
var
  ctr:Integer;
begin
  result:= '';
  for ctr:= 1 to  ExtraAttribs do begin
    if delimeterPrefix or (result <> '') then result := result +delimeter;
    result := result +'exvalue' + trim(inttostr(ctr));
  end;
end;

procedure TMatrixsale.EmptyTables;
begin
  with tempMyscript(conn) do try
    try     SQL.text := 'truncate ' + fsMatrixtablename;execute; except end;
    try     SQL.text := 'truncate ' + fsMatrixtablename+'names';execute; except end;
    try     SQL.text := 'truncate ' + fsMatrixtablename+'YCaptions';execute; except end;
  finally
    Free;
  end;
end;

function TMatrixsale.ExtraFields: String;
var
  ctr:Integer;
begin
  result:= '';
  for ctr:= 1 to ExtraAttribs do begin
    result := result + 'exvalue'+ trim(inttostr(ctr))+',';
  end;
end;

Procedure TMatrixsale.YCaptionsRec(PAGID:Integer; PAGName:String; YAxisID:Integer);
var
  QryYValues:TERPQuery;
  ctr:Integer;
begin
      if QryYCaptions.Locate('PAG_ID' , PAGID , []) = False then begin
        QryYCaptions.Append;
        QryYCaptions.Fieldbyname('PAG_ID').AsInteger :=PAGID ;
        QryYCaptions.Fieldbyname('Groupname').asString  :=PAGName;
        QryYValues:= TempMyQuery;
        try
          QryYValues.SQL.Text := 'select * from tblproductattributevalues where PAN_ID = ' + inttostr(YAxisID);
          QryYValues.open;
          if QryYValues.recordcount >0 then begin
            QryYValues.First;
            ctr:= 1;
            while QryYValues.eof = False do begin
              QryYCaptions.Fieldbyname('Column' + trim(inttostr(ctr))).asString       := QryYValues.fieldbyname('Value').AsString;
              QryYCaptions.Fieldbyname('Abbreviation' + trim(inttostr(ctr))).asString  := QryYValues.fieldbyname('Abbreviation').AsString;
              ctr:= ctr+1;
              QryYValues.Next;
            end;
          end;
        finally
          QryYValues.closenfree;
        end;
        PostDB(QryYCaptions);
      end;
end;


function TMatrixsale.Yfieldcond(const Value: String): String;
var
  ctr:Integer;
begin
  REsult := '';
  if YAttribs =0 then exit;
  for ctr:= 1 to YAttribs do begin
    if result <> '' then result := result +' or ';
    result := result +'ifnull(Sold' + trim(inttostr(ctr))+',0)' +Value;
  end;
  if result <> '' then result := ' where ' + result ;
end;

function TMatrixsale.YFields: String;
begin

end;

Procedure TMatrixsale.MakeMatrixTables;
var
  QryAttribs :TERPQuery;
  conn : TERPConnection;
  ctr:Integer;
begin
  fsMatrixtablename  := '';
  YAttribs := 1;
  ExtraAttribs := 0;
  conn := GetSharedMyDacConnection;
  QryAttribs:= NewQuery;
  try
    QryAttribs.SQL.Text := 'select PAG_ID , count(PAN_ID) ctr from tblproductattributenames group by PAG_ID order by ctr desc limit 1';
    QryAttribs.open;
    if QryAttribs.Fieldbyname('ctr').asInteger >2 then ExtraAttribs := QryAttribs.Fieldbyname('ctr').asInteger -2;
    if QryAttribs.active then QryAttribs.close;
    QryAttribs.SQL.clear;
    if YMode then
      QryAttribs.SQL.text := 'Select PAG.PAG_ID , PAG.Name, count(PAV.PAV_ID) ctr ' +
            ' from tblproductattributegroups PAG ' +
            ' inner join tblproductattributenames PAN on PAG.YAxisAttribute = PAN.PAN_ID ' +
            ' inner join tblproductattributevalues PAV on PAN.PAN_ID = PAV.PAN_ID ' +
            ' group by PAG.PAG_ID ' +
            ' order by ctr desc limit 1'
    else
      QryAttribs.SQL.text := 'Select PAG.PAG_ID , PAG.Name, count(PAV.PAV_ID) ctr ' +
            ' from tblproductattributegroups PAG ' +
            ' inner join tblproductattributenames PAN on PAG.XAxisAttribute = PAN.PAN_ID ' +
            ' inner join tblproductattributevalues PAV on PAN.PAN_ID = PAV.PAN_ID ' +
            ' group by PAG.PAG_ID ' +
            ' order by ctr desc limit 1';
    QryAttribs.open;

    if QryAttribs.Fieldbyname('ctr').asInteger >=2 then YAttribs := QryAttribs.Fieldbyname('ctr').asInteger;
    if  (ExtraAttribs*2) +(YAttribs*6) > 250 then ExtraAttribs:=  trunc((200- (YAttribs*6))/2); // MySQL cannot handle more than 255 fields in the table
  finally
    QryAttribs.ClosenFree;
  end;


    { we don't need to append self, this makes the name to long when other stuff appended to make other
      tables. GetUserTemporaryTableName produces a unique name, it comtains a 8 char random sequence }
//    fsMatrixtablename  := GetUserTemporaryTableName('SalesMatrix')+'_'+ trim(inttostr(integer(Self)));
    fsMatrixtablename  := GetUserTemporaryTableName('SalesMatrix');

    with tempMyscript(conn) do try
      SQL.Add('drop table if exists ' + fsMatrixtablename +';');
      SQL.Add('CREATE TABLE ' + fsMatrixtablename +' (' +
              ' ID int(10) NOT NULL AUTO_INCREMENT,' +
              ' Groupname varchar(255) DEFAULT "",' +
              '   PAG_ID int(11) DEFAULT "0",' );
      if ExtraAttribs >0 then
        for ctr:= 1 to  ExtraAttribs do begin
          SQL.Add('   ExName'   + trim(inttostr(ctr)) +' varchar(255) DEFAULT "",' +
                  '   ExValue'  + trim(inttostr(ctr)) +' varchar(255) DEFAULT "",');
        end;
      SQL.Add('   xName   varchar(255) DEFAULT "",' +
              '   xValue  varchar(255) DEFAULT "",' +
              '   yName   varchar(255) DEFAULT "",' );
      if YAttribs =0 then begin
        SQL.Add('   yValue0     varchar(255) DEFAULT "",' +
                '   ProductID0  int(11) Default 0,' +
                '   SaleLineID0  int(11) Default 0,' +
                '   UOM0        varchar(100) DEFAULT "",'+
                '   Sold0       double Default 0,' +
                '   Shipped0    double Default 0,' +
                '   BO0         double  Default 0,'  );
      end else for ctr:= 1 to  YAttribs do begin
        SQL.Add('   yValue'     + trim(inttostr(ctr)) +' varchar(255) DEFAULT "",' +
                '   ProductID'  + trim(inttostr(ctr)) +' int(11) Default 0,'+
                '   SaleLineID' + trim(inttostr(ctr)) +' int(11) Default 0,'+
                '   UOM'        + trim(inttostr(ctr)) +' varchar(100) DEFAULT "",' +
                '   Sold'       + trim(inttostr(ctr)) +' double Default 0,' +
                '   Shipped'    + trim(inttostr(ctr)) +' double Default 0,' +
                '   BO'         + trim(inttostr(ctr)) +' double Default 0,' +
                '   LinePrice'          + trim(inttostr(ctr)) +' double Default 0,' +
                '   LinePriceInc'       + trim(inttostr(ctr)) +' double Default 0,' +
                '   LineTax'            + trim(inttostr(ctr)) +' double Default 0,' +
                '   TotalLineAmount'    + trim(inttostr(ctr)) +' double Default 0,' +
                '   TotalLineAmountInc' + trim(inttostr(ctr)) +' double Default 0,'  );
      end;
        SQL.Add('   sumSold       double Default 0,' +
                '   sumShipped    double Default 0,' +
                '   sumBO         double Default 0,'  );
        SQL.Add('   sumLineTax            double Default 0,' +
                '   sumTotalLineAmount    double Default 0,' +
                '   sumTotalLineAmountInc double Default 0,'  );
      SQL.Add('PRIMARY KEY (ID)) ENGINE=MyISAM DEFAULT CHARSET=utf8;');


      SQL.Add('drop table if exists ' + fsMatrixtablename +'BOM;');
      SQL.Add('CREATE TABLE ' + fsMatrixtablename +'BOM (' +
              ' ID int(10) NOT NULL AUTO_INCREMENT,' +
              ' Groupname varchar(255) DEFAULT "",' +
              '   PAG_ID int(11) DEFAULT "0",' +
              '   Matrix_ID int(11) DEFAULT "0",' );
      if YAttribs =0 then begin
        SQL.Add('   BOM0     varchar(255) DEFAULT "",' +
                '   Tree0     varchar(255) DEFAULT "",' +
                '   BOMQty0        double Default 0,'+
                '   BOMTotalQty0       double Default 0,');
      end else for ctr:= 1 to  YAttribs do begin
        SQL.Add('   BOMProductID'     + trim(inttostr(ctr)) +' int(11) default 0,' +
                '   BOM'     + trim(inttostr(ctr)) +' varchar(255) DEFAULT "",' +
                '   Tree'     + trim(inttostr(ctr)) +' varchar(255) DEFAULT "",' +
                '   sequencedown'     + trim(inttostr(ctr)) +' int(11) DEFAULT 0,' +
                '   BOMQty'       + trim(inttostr(ctr)) +' double Default 0,' +
                '   BOMTotalQty'         + trim(inttostr(ctr)) +' double Default 0,'  );
      end;
        SQL.Add('   sumBOMQty double Default 0,' +
                '   sumBOMtotalQty double Default 0,' );
      SQL.Add('PRIMARY KEY (ID)) ENGINE=MyISAM DEFAULT CHARSET=utf8;');



      if YAttribs =0 then begin
        SQL.Add(' alter table ' + fsMatrixtablename +' add index SaleLineID0 (SaleLineID0); ');
      end else for ctr:= 1 to  YAttribs do begin
        SQL.Add(' alter table ' + fsMatrixtablename +' add index SaleLineID'     + trim(inttostr(ctr)) +'  (SaleLineID'     + trim(inttostr(ctr)) +' ); ');
      end;

      SQL.add('drop table if exists ' + fsMatrixtablename+'Names;');
      SQL.add('CREATE TABLE ' + fsMatrixtablename+'Names ('+
              ' ID int(10) NOT NULL AUTO_INCREMENT,'+
              ' Groupname varchar(255) DEFAULT "",'+
              ' PAG_ID int(11) DEFAULT "0",'+
              ' Seqno int(11) DEFAULT "0",'+
              ' Name varchar(255) DEFAULT "",'+
              ' Value varchar(255) DEFAULT "",'+
              ' IsX Enum("T","F") default "F", '+
              ' PRIMARY KEY (ID)) ENGINE=MyISAM DEFAULT CHARSET=utf8;');

      SQL.add('drop table if exists ' + fsMatrixtablename+'YCaptions;');
      SQL.add('CREATE TABLE ' + fsMatrixtablename+'YCaptions ('+
              ' ID int(10) NOT NULL AUTO_INCREMENT,'+
              ' Groupname varchar(255) DEFAULT "",'+
              ' PAG_ID int(11) DEFAULT "0",');
      for ctr:= 1 to  YAttribs do begin
        SQL.add('Column' + Trim(inttostr(ctr)) +' varchar(255) DEFAULT "",');
        SQL.add('Abbreviation' + Trim(inttostr(ctr)) +' varchar(255) DEFAULT "",');
      end;
      SQL.Add('PRIMARY KEY (ID)) ENGINE=MyISAM DEFAULT CHARSET=utf8;');

      Execute;
    finally
      Free;
    end;

end;

end.

