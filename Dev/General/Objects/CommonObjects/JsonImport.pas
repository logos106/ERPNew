unit JsonImport;

interface

procedure ImportSalesListJson;

implementation
uses
  SysUtils, Dialogs, Classes, ProgressDialog,
  JSonObject, ObjectSerialiser, JsonObjectUtils,
  CommonDBLib, BusObjSaleBase, MemoDialog;

procedure ImportSalesListJson;
var
  od: TOpenDialog;
  jsonFileName: string;
  list, errList, json: TJsonObject;
  x: integer;
  JSONDesrialiser: TJSONDeserialiser;
  obj: TObject;
  errMsg: TStringList;
  prog: TProgressDialog;

  procedure AddErr(msg: string; j: TJsonObject);
  begin
    if not Assigned(errMsg) then errMsg := TStringList.Create;
    if not Assigned(errList) then errList := JO;
    if errMsg.Count > 0 then errMsg.Add('');
    errMsg.Add(msg);
    if Assigned(j) then
      errList.A['List'].Add(j);
  end;

begin
  od := TOpenDialog.Create(nil);
  try
    od.Filter := 'JSON files (*.json)|*.JSON|All files (*.*)|*.*';
    if od.Execute then
      jsonFileName := od.FileName
    else
      exit;
  finally
    od.Free;
  end;

  list := JO;
  JSONDesrialiser:= TJSONDeserialiser.Create;
  prog := TProgressDialog.Create(nil);
  try
    JSONDesrialiser.DatabaseConnection := CommonDbLib.GetNewMyDacConnection(nil);
    JSONDesrialiser.RawMode := true;
    try
      list.LoadFromFile(jsonFileName);
      prog.Caption := 'Importing Sales as JSON';
      prog.MaxValue := List.A['List'].Count + 1;
      prog.Step := 1;
      prog.Value := 1;
      prog.Message := 'Importing JSON ..';
      prog.Execute;
      json := nil;
      for x := 0 to list.A['List'].Count -1 do begin
        if not JSONDesrialiser.DatabaseConnection.InTransaction then
          JSONDesrialiser.DatabaseConnection.StartTransaction;
        try
          json := list.A['List'].Items[x].AsObject;

          Obj:= JSONDesrialiser.DeserialiseObject(json);
          if not JSONDesrialiser.IsConsistent then begin
            JSONDesrialiser.DatabaseConnection.Rollback;
            AddErr('Error populating object: ' + JSONDesrialiser.Messages.CommaText, json);
            continue;
          end;

          if Assigned(Obj) then begin
            if Obj is TSalesBase then begin
              if not TSalesBase(Obj).Save then begin
                JSONDesrialiser.DatabaseConnection.Rollback;
                AddErr('Error Saving Sale: ' + TSalesBase(Obj).ResultStatus.Messages, json);
                continue;
              end;
            end
            else begin
              JSONDesrialiser.DatabaseConnection.Rollback;
              AddErr('Error - Unknown data type: ' + obj.ClassName, json);
              continue;
            end;
          end;


          if JSONDesrialiser.DatabaseConnection.InTransaction then
            JSONDesrialiser.DatabaseConnection.Commit;
        except
          on e: exception do begin
            if JSONDesrialiser.DatabaseConnection.InTransaction then
              JSONDesrialiser.DatabaseConnection.Rollback;
            AddErr('Exception processing sale: ' + e.Message, json);
          end;

        end;

        prog.StepIt;
      end;
      prog.CloseDialog;
    finally
      if JSONDesrialiser.DatabaseConnection.InTransaction then
        JSONDesrialiser.DatabaseConnection.Rollback;
    end;

    if Assigned(errMsg) then begin
      JsonFileName := ChangeFileExt(JsonFileName,'_error.json');
      JsonToFileFormated(errList,JsonFileName);

      errMsg.Insert(0, '');
      errMsg.Insert(0, 'The following errors occured while importing the list of sales. ' +
        'The unprocessed sales have been saved into the following file:' + #13#10 + JsonFileName);
      TfrmMemoDialog.Memopopup(errMsg.Text,'Import Errors');
    end;

  finally
    list.Free;
    errList.Free;
    errMsg.Free;
    JSONDesrialiser.DatabaseConnection.Free;
    JSONDesrialiser.Free;
    prog.Free;
  end;
end;

end.
