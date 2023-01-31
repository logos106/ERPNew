unit AssessmentConvertObj;

interface

function ConvertAssessmentToInvoice(const iClientID: Integer; const AssessmentIDs: array of Integer): Integer;

implementation
  
uses FastFuncs,MyAccess,ERPdbComponents, DB, BusObjSales, CommonDbLib, 
  tcDataUtils, DNMLib, 
  SysUtils,  Dialogs, tcConst, 
  BusObjBase,  AppEnvironment, CommonLib;



function GetAssessmentTypeProductID(const AssessmentID: Integer): Integer;
var
  qryTemp: TERPQuery;
begin
  Result := 0;
  qryTemp := TERPQuery.Create(nil);
  try
    qryTemp.Options.FlatBuffers := True;
    qryTemp.Connection := commondblib.GetSharedMyDacConnection;
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT AssessmentID,ProductID ');
    qryTemp.SQL.Add('FROM tblassessments ');
    qryTemp.SQL.Add('Inner JOIN tblassessmenttypes USING(TypeID) ');
    qryTemp.SQL.Add('WHERE `AssessmentID` = ' + FastFuncs.IntToStr(AssessmentID) + ';');
    qryTemp.Open;
    if (qryTemp.RecordCount <> 0) then begin
      if qryTemp.FieldByName('ProductID').AsInteger <> 0 then begin
        Result := qryTemp.FieldByName('ProductID').AsInteger;
      end else Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure SetAssessmentConverted(const AssessmentIDs: array of Integer);
var
  qryTemp: TERPCommand;
  TmpStr: string;
  arrayLoop: Integer;
begin
  qryTemp := TERPCommand.Create(nil);
  try
    qryTemp.Connection := commondblib.GetSharedMyDacConnection;
    qryTemp.SQL.Clear;

    TmpStr := '(AssessmentID=';
    for arrayLoop := Low(AssessmentIDs) to High(AssessmentIDs) do begin
      TmpStr := TmpStr + FastFuncs.IntToStr(AssessmentIDs[arrayLoop]) + ' OR AssessmentID=';
    end;
    TmpStr := FastFuncs.LeftStr(TmpStr, Length(TmpStr) - 17) + ')';

    qryTemp.SQL.Add('UPDATE tblassessments SET Converted= "T" ');
    qryTemp.SQL.Add('WHERE ' + TmpStr);
    try
      qryTemp.Execute;
    except
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;
  
function ConvertAssessmentToInvoice(const iClientID: Integer; const AssessmentIDs: array of Integer): Integer;
var
  Invoice: TInvoice;
  qryParts: TERPQuery;
  arrayLoop: Integer;
  tmpComments: string;

  function GetPartDetails(const ProductID: Integer): Boolean;
  begin
    Result := true;
    qryParts := TERPQuery.Create(nil);
    with qryParts do begin
      Options.FlatBuffers := True;
      Connection := CommonDbLib.GetSharedMyDacConnection;
      Sql.Clear;
      Sql.Add('SELECT IncomeAccnt, AssetAccnt, COGSAccnt,PARTSID, PartName, ' +
        ' PartsDescription, PartType, tbltaxcodes.Name as TaxCode,PRICE1, Rate  ' +
        ' FROM tblParts  ' +
        ' LEFT JOIN tbltaxcodes ON tbltaxcodes.Name=TaxCode AND RegionID= ' +
        FastFuncs.IntToStr(AppEnv.RegionalOptions.ID) +
        ' Where PARTSID = ' + FastFuncs.IntToStr(ProductID) + ';');
      Open;
      if IsEmpty then begin
        Result := false;
        CommonLib.MessageDlgXP_Vista('Product not found. Cannot convert this transaction.',
          mtWarning, [mbOK], 0);
      end;
    end;
  end;

  function InsertLines(const ProductID: Integer): Boolean;
  begin
    Result := false;
    Invoice.Lines.New;
    if GetPartDetails(ProductID) = false then Exit;
    Invoice.Lines.SaleId := Invoice.ID;
    Invoice.Lines.IncomeAccount := qryParts.FieldByName('IncomeAccnt').AsString;
    Invoice.Lines.AssetAccount := qryParts.FieldByName('AssetAccnt').AsString;
    Invoice.Lines.CogsAccount := qryParts.FieldByName('COGSAccnt').AsString;
    Invoice.Lines.ProductType := qryParts.FieldByName('PartType').AsString;
    Invoice.Lines.ProductID := qryParts.FieldByName('PARTSID').AsInteger;
    Invoice.Lines.ProductName := qryParts.FieldByName('PartName').AsString;
    Invoice.Lines.ProductDescription := qryParts.FieldByName('PartsDescription').AsString;
    Invoice.Lines.LineTaxCode := qryParts.FieldByName('TaxCode').AsString;
    Invoice.Lines.LineTaxRate := qryParts.FieldByName('Rate').AsFloat;
    Invoice.Lines.UnitOfMeasure := Default_UOM;
    Invoice.Lines.UnitOfMeasureID := GetUnitOfMeasureID(DEFAULT_UOM);
    Invoice.Lines.Invoiced := true;
    Invoice.Lines.UOMMultiplier := 1;

    if Invoice.Lines.UnitOfMeasure = '' then begin
      Invoice.Lines.UnitOfMeasure   := 'Units';
      Invoice.Lines.UnitOfMeasureID := GetUnitOfMeasureID('Units', qryParts.FieldByName('PARTSID').AsInteger);
      Invoice.Lines.UOMMultiplier   := 1;
    end;

    Invoice.Lines.QtySold := 1;
    Invoice.Lines.QtyShipped := 1;
    Invoice.Lines.UOMQtySold := 1;
    Invoice.Lines.UOMQtyShipped := 1;

    if Invoice.Lines.Dataset.State in [dsEdit, dsInsert] then Invoice.Lines.Dataset.Post;
    Invoice.Lines.GlobalREf := AppEnv.Branch.SiteCode + FastFuncs.IntToStr(Invoice.Lines.ID);
    if Invoice.Lines.Dataset.State in [dsEdit, dsInsert] then Invoice.Lines.Dataset.Post;
    Result := true;
  end;
begin
  Result := 0;
  Invoice := TInvoice.Create(nil);
  Invoice.SilentMode := true;
  Invoice.Connection := TMyDacDataConnection.Create(Invoice);
  Invoice.Connection.Connection :=CommonDbLib.GetSharedMyDacConnection;;
  try
    Invoice.New;
    Invoice.GLAccountId   := AppEnv.CompanyPrefs.DefaultSalesAccount;
    Invoice.InvoiceToDesc := GetShippingAddress(iClientID);
    Invoice.ShipToDesc    := GetPhysicalAddress(iClientID);
    Invoice.SaleDate      := Now;
    Invoice.SaleClassId   := AppEnv.DefaultClass.ClassID;
    Invoice.ClientID      := iClientID;
    Invoice.CustomerName  := GetClientName(iClientID);
    if Invoice.Dataset.State in [dsEdit, dsInsert] then Invoice.Dataset.Post;
    Invoice.GlobalRef         := AppEnv.Branch.SiteCode + FastFuncs.IntToStr(Invoice.ID);
    Invoice.OriginalDocNumber := Invoice.GlobalRef;
    Invoice.Deleted           := false;
    Invoice.DocNumber         := FastFuncs.IntToStr(Invoice.ID);

    tmpComments := 'Invoice For Assessment No. (';
    for arrayLoop := Low(AssessmentIDs) to High(AssessmentIDs) do begin
      tmpComments := tmpComments + FastFuncs.IntToStr(AssessmentIDs[arrayLoop]) + '/';
    end;
    tmpComments      := FastFuncs.LeftStr(tmpComments, Length(tmpComments) - 1) + ')';
    Invoice.Comments := tmpComments;

    for arrayLoop := Low(AssessmentIDs) to High(AssessmentIDs) do begin
      if not InsertLines(GetAssessmentTypeProductID(AssessmentIDs[arrayLoop])) then Exit;
    end;

    if not Invoice.Save then begin
      CommonLib.MessageDlgXP_Vista('Convertion Failed. Cannot convert this transaction.',
        mtWarning, [mbOK], 0);
      Exit
    end;
    SetAssessmentConverted(AssessmentIDs);
    Result := invoice.ID;
  finally
    FreeAndNil(Invoice);
  end;
end;


end.
