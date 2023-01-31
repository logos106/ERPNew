unit ApiFuncManufacture;

interface

uses
  ApiFuncObj, ERPDbComponents, JsonObject;

type
  TFunc_Manufacture = class(TApiFunc)
  private
    ProcProgID: integer;
    procedure PrintReports(Arr: TJsonArray);
  public
    procedure Execute; override;
  end;

implementation

uses
  SysUtils, Classes, BusObjBOMSalesOrder, PrintTemplateBaseObj, SystemLib,
  BusObjProcSummary;


(* Request body structure ..
  {
    "Command":"Complete",                        // complete manufacture
    "BuildQty": 2                                // Quantity to build
    "SaleOrderLineID": 123,                      // Sale Order line ID to complete

    "ProcTreeID": 0,                             // Optional ProcTreeID for sub-builds
    "BatchNoFormat": "",                         // Optional
    "SNFormat": "",                              // Optional

    "Reports": [
      {
        "TemplateName":"Progress Build Serial Number", // template name
        "TypeName":"",                                 // optional to get default template
        "ID": 0,                                       // the optional ID of the transaction to print
        "IDRef", "ProcProgID"                          // optional name of val/variable to get ID from
      }
    ]
  }
*)


{ TFunc_Manufacture }

procedure TFunc_Manufacture.Execute;
var
  BOMSalesOrder: TBOMSalesOrder;
  qry: TERPQuery;
  ProcSummary: TProcSummary;
begin
  try
    inherited;
    if SameText(JsonIn.S['Command'],'Complete') then begin
      if (not JsonIn.IntegerExists('SaleOrderLineID')) or (JsonIn.I['SaleOrderLineID'] = 0) then begin
        ResponceNo := 406; { "Not Acceptable" }
        ErrorMessage := 'SaleOrderLineID not provided.';
        exit;
      end;
      if (not JsonIn.FloatExists('BuildQty')) or (JsonIn.F['BuildQty'] = 0) then begin
        ResponceNo := 406; { "Not Acceptable" }
        ErrorMessage := 'BuildQty not provided.';
        exit;
      end;
      BOMSalesOrder := TBOMSalesOrder.CreateWithNewConn(nil);
      qry := TERPQuery.Create(nil);
      try
        qry.Connection := BOMSalesOrder.Connection.Connection;
        qry.SQL.Text := 'select SaleID from tblsaleslines where SaleLineID = ' + IntToStr(JsonIn.I['SaleOrderLineID']);
        qry.Open;
        BOMSalesOrder.SilentMode := true;
        BOMSalesOrder.Load(qry.FieldByName('SaleID').AsInteger);
        if BOMSalesOrder.DoPartialBuild(
          JsonIn.I['SaleOrderLineID'],
          JsonIn.I['ProcTreeID'],
          JsonIn.F['BuildQty'],
          JsonIn.S['BatchNoFormat'],
          JsonIn.S['SNFormat'],
          ProcProgID) then
        begin
          BOMSalesOrder.Connection.CommitTransaction;
          JsonOut.I['ProcProgID'] := ProcProgID;
          ProcSummary := TProcSummary.Create(nil);
          try
            ProcSummary.Connection := BOMSalesOrder.Connection;
            ProcSummary.Load(JsonIn.I['SaleOrderLineID']);
            JsonOut.I['SaleID'] := ProcSummary.SaleID;
            JsonOut.I['SaleLineID'] := ProcSummary.SaleLineID;
            JsonOut.I['ProductID'] := ProcSummary.ProductID;
            JsonOut.S['ProductName'] := ProcSummary.ProductName;
            JsonOut.S['ProductPrintName'] := ProcSummary.ProductPrintName;
            JsonOut.F['UOMQtySold'] := ProcSummary.UOMQtySold;
            JsonOut.F['UOMQtyBuilt'] := ProcSummary.UOMQtyBuilt;
          finally
            ProcSummary.Free;
          end;
          qry.Close;
          qry.SQL.Clear;
          qry.SQL.Add('select pqaDetails.Value from tblpqa pqa');
          qry.SQL.Add('inner join tblpqadetails pqaDetails on pqaDetails.PQAID = pqa.PQAID');
          qry.SQL.Add('where pqa.TransLineID = ' + IntToStr(ProcProgID) + ' and pqa.TransType = "TProcProgressIn"');
          qry.Open;
          JsonOut.A['SerialNumbers'];
          while not qry.Eof do begin
            JsonOut.A['SerialNumbers'].Add(qry.FieldByName('Value').AsString);
            qry.Next;
          end;

          if JsonIn.ArrayExists('Reports') then
            PrintReports(JsonIn.A['Reports']);
        end
        else begin
          ResponceNo := 406; { "Not Acceptable" }
          ErrorMessage := BOMSalesOrder.ResultStatus.Messages;
          exit;
        end;
      finally
        qry.Free;
        if BOMSalesOrder.Connection.InTransaction then
          BOMSalesOrder.Connection.RollbackTransaction;
        BOMSalesOrder.Free;
      end;

    end
    else begin
      ResponceNo := 406; { "Not Acceptable" }
      ErrorMessage := 'Unknown command: "' + JsonIn.S['Command'] + '"';
      exit;
    end;
  except
    on e: exception do begin
      ResponceNo := 500; { "" }
      ErrorMessage := e.Message;
    end;
  end;
end;

procedure TFunc_Manufacture.PrintReports(Arr: TJsonArray);
var
  I: Integer;
  obj, OutObj: TJsonObject;
  PrintTemplate: TPrintTemplateBase;
  TemplateName: string;
  FileName: string;
  SelectSQL: string;
  aType: string;
begin
  PrintTemplate := TPrintTemplateBase.Create;
  try
    PrintTemplate.ReportSQLSupplied := false;

    for I := 0 to Arr.Count -1 do begin
      obj := Arr[I].AsObject;
      TemplateName := obj.S['TemplateName'];
      if TemplateName = '' then begin
        TemplateName := self.DefaultTemplateForType(obj.S['TypeName']);
        if TemplateName = '' then begin
          ResponceNo := 406; { "Not Acceptable" }
          ErrorMessage := 'Template Name or Type not found.';
          exit;
        end;
      end;
      if obj.I['ID'] < 1 then begin
        if obj.S['IDRef'] <> '' then begin
          if SameText(obj.S['IDRef'], 'ProcProgID') then
            obj.I['ID'] := ProcProgID
          else begin
            ResponceNo := 406; { "Not Acceptable" }
            ErrorMessage := 'IDRef type not recognised.';
            exit;
          end;
        end
        else begin
          ResponceNo := 406; { "Not Acceptable" }
          ErrorMessage := 'ID or IDRef not found.';
          exit;
        end;
      end;
      aType := obj.S['TypeName'];
      if aType = '' then
        aType := self.TemplateTypeNameForTemplateName(obj.S['TemplateName']);
      if SameText(aType,'Progress Build') then
        SelectSQL :=
          '~|||~Where PPG.ProcProgressID = ' + inttostr(ProcProgID) + ' ' +
          '~|||~Where PPG.InProcProgressId = ' + inttostr(ProcProgID)
      else begin
        ResponceNo := 406; { "Not Acceptable" }
        ErrorMessage := 'Report Type "' + aType + '" not supported.';
        exit;
      end;

      FileName := GetTempFileName('', '.PDF');
      if PrintTemplate.SaveReport(TemplateName,SelectSQL,false,'PDF',FileName) then begin
        OutObj := JO;
        OutObj.S['FileExt'] := 'PDF';
        OutObj.S['TemplateName'] := TemplateName;
        OutObj.S['TypeName'] := aType;
        OutObj.S['MimeEncodedFile'] := self.MimeEncodedFile(FileName);
        JsonOut.A['Reports'].Add(OutObj);
      end
      else begin
        ResponceNo := 406; { "Not Acceptable" }
        ErrorMessage := PrintTemplate.SaveReportErrorMsg;
        exit;
      end;
    end;
 finally
    PrintTemplate.Free;
  end;
end;

initialization
  RegisterClass(TFunc_Manufacture);


end.
