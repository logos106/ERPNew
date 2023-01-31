unit utCloudAPI;

interface

uses
   Classes, JsonObject, ERPDbComponents, LogThreadBase, LogMessageTypes;

type

   TCloudAPI = class(TObject)
   private
      aLogger: TLoggerBase;
      (* procedure LogStr(const Value: String); *)
   public
      { returns true if request type is handled }
      class function DoCloudRequest(InJson, OutJson: TJsonObject; var OutStream: TStream;
        DbConn: TERPConnection; Logger: TLoggerBase = nil): boolean;
   end;


implementation

uses
   SysUtils, {ReportSQLBase,} JsonToDatasetFuncs, ReportBaseObj, BusObjBase, BusObjProfitLoss,
   SystemLib, MySQLUtils, utWebAPIFileStream (*, UserUtilsLib*) , utCloudconst, Dialogs;

{ TCloudAPI }
(* procedure TCloudAPI.LogStr(Const Value:String);
  begin
  if Assigned(aLogger) then aLogger.Log(Value, ltInfo);
  end; *)
class function TCloudAPI.DoCloudRequest(InJson, OutJson: TJsonObject; var OutStream: TStream;
  DbConn: TERPConnection; Logger: TLoggerBase): boolean;
var
   ResourceName: string;
   qry: TERPQuery;
   msg: string;
   Cls: TPersistentClass;

   Report: TReportBase;

   BusObj: TMSBusObj;

   BusObjPLL : TProfitLossLayout;

   TempFile: string;
   Writer: TStreamWriter;
   FileStream: TFileStream;
   Stream: TStream;
   OutConn: TERPConnection;
   OutQry: TERPQuery;

   s: string;
   s1: string;
   sCount: string;

   LimitFrom, LimitCount: Integer;
   // UserUtilsActions : TUserUtilsActions;
   nRecords: Integer;

   procedure Log(const msg: string; aType: TLogMessageType = ltNone);
   begin
      if Assigned(Logger) then
         Logger.Log(msg, aType);
   end;

   procedure AddResponseCode(const httpCode: Integer);
   begin
      OutJson.I[TAG_ResponseNo] := httpCode;
   end;

   procedure AddErrorResponse(const msg: string; const httpCode: Integer);
   begin
      Log(msg, ltError);
      AddResponseCode(httpCode);
      OutJson.s[TAG_ErrorMessage] := msg;
   end;

   Procedure ProcessuserUtilAction;
   begin
      (* UserUtilsActions := TUserUtilsActions.create;
        try
        REsult := UserUtilsActions.MakeNewDatabase(InJson.O[TAG_CLOUD_Params].S['NewDatabaseName'],InJson.O[TAG_CLOUD_Params].S['RegionforNewDB'], s);
        Writer := nil;
        try
        OutStream := TMemoryStream.Create;
        Writer := TStreamWriter.Create(OutStream);
        Writer.Write('{');
        if s <> '' then begin
        Writer.WriteLine;
        Writer.WriteLine(s+',');
        end;
        finally
        Writer.Free;
        end;

        finally
        UserUtilsActions.Free;
        end; *)
   end;

begin
  With TCloudAPI.Create do
    try
      aLogger := Logger;
      result := false; { not handled by default }
      if InJson.s['Command'] = 'GET' then begin
        ResourceName := InJson.A['URIParts'].Items[2].AsString;
        if sametext(ResourceName, 'TUserUtilsActions') then begin
          AddResponseCode(200);
          ProcessuserUtilAction;
        end
        else begin
          Cls := GetClass(ResourceName);
          if not Assigned(Cls) then
            Cls := GetClass('T' + ResourceName);

          if Assigned(Cls) then begin
            try
              if Cls.InheritsFrom(TReportBase) then begin
                Result := True;
                AddResponseCode(200);
                Report := TReportBaseClass(Cls).Create;
                try
                  Report.APIMode := True;
                  Report.AssignParams(InJson.O[TAG_CLOUD_Params]);
                  qry := TERPQuery.Create(nil);
                  try
                    qry.Connection := DbConn;
                    if not Report.PopulateReportSQL(qry.SQL, msg) then begin
                      AddErrorResponse(msg, 500);
                      Exit;
                    end;

                    // Count the records
                    qry.Open;
                    nRecords := qry.RecordCount;
                    qry.Close;

                    LimitFrom := 0;  // Wang
                    LImitCount := 0;
                    if InJson.Exists(TAG_CLOUD_Params) then begin
                      if InJson.O[TAG_CLOUD_Params].Exists('LimitFrom') then
                        LimitFrom := InJson.O[TAG_CLOUD_Params].I['LimitFrom'];
                      if InJson.O[TAG_CLOUD_Params].Exists('LimitCount') then
                        LimitCount := InJson.O[TAG_CLOUD_Params].I['LimitCount'];
                    end;

                    if (LimitFrom > 0) and (LimitCount > 0) then
                      qry.SQL.Add('LIMIT ' + IntToStr(LimitFrom) + ',' + IntToStr(LImitCount))
                    else if LimitCount > 0 then
                      qry.SQL.Add('LIMIT ' + IntToStr(LImitCount));

                    Writer := nil;
                    try
                      if nRecords <= 500000 then begin
                        { use memory stream .. faster }
                        OutStream := TMemoryStream.Create;
                      end
                      else begin
                        { use file stream stream .. prevents running out of memory }
                        TempFile := SystemLib.GetTempFileName('', '.tmp', True);
                        OutStream := TWebAPIFileStream.Create(TempFile, fmOpenReadWrite);
                      end;

                      Writer := TStreamWriter.Create(OutStream);
                      // Writer.WriteLine('{"' + ResourceName + '":[');
                      Writer.Write('{');
                      s := Report.PreDataJson;

                      if s <> '' then
                      begin
                        s1 := Copy(s, 1, Length(s) - 2);

                        if s1 = '{' then
                           sCount := sLineBreak + '"Count": ' + IntToStr(nRecords)
                        else
                           sCount := ',' + sLineBreak + '"Count": ' + IntToStr(nRecords);

                        Insert(sCount, s, Length(s) - 2);

                        Writer.WriteLine;
                        Writer.WriteLine('"Params":' + s + ',');
                      end;

                      Writer.WriteLine('"' + ResourceName + '":[');

                      qry.Open;
                      while not qry.Eof do
                      begin
                        if not qry.Bof then
                        begin
                           Writer.Write(',');
                           Writer.WriteLine;
                        end;
                        DatasetToJson(qry, Writer, '' (* , LogStr *) );
                        qry.Next;
                      end;
                      qry.Close;
                      Writer.WriteLine(']}');
                    finally
                       Writer.Free;
                    end;

                    finally
                      qry.Free;
                    end;
                  finally
                     Report.Free;
                  end;
                end
                except
                   on e: exception do
                   begin
                      AddErrorResponse(e.Message, 500);
                  end;
                end;
              end;
            end;
          end;
        finally
        end;
      end;

end.
