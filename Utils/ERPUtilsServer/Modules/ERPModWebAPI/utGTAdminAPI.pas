unit utGTAdminAPI;

interface

Uses JsonObject,ERPDbComponents,LogThreadBase, Classes, utAPIBaseObj,WebAPIThreadObj, utServerTask, WebAPILib;

Type
  TGTAdminAPI = class(TAPIBaseObj)
  Private
  Protected
  Public
    class function DoCloudRequest(InJson, OutJson: TJsonObject; var OutStream: TStream; DbConn: TERPConnection; aLogger: TLoggerBase = nil; aTaskRecID:Integer =0): boolean;
  Published
  end;

  TGTCloudTaskThread = class(TWebAPIThreadBase)
  Private
    TaskRec: TServerTaskRec;
    fCommand,
    fParams: string;
    fconn :TERPConnection;
    fThreadParams: TJsonObject;
    Function Initconn:Boolean;
    Procedure GT_InitDBForStS;
    Procedure GT_AllocatePlantTag;
    function ThreadParams: TJsonObject;
  Protected
    procedure Execute; override;
  Public
    constructor Create(aCommand: string; aDBConn: TERPConnection; OnEvent:TEventProc;  params: string = '';aLogger: TLoggerBase=nil);
    destructor Destroy; override;
  Published
  end;
implementation

uses utGTConst, sysutils, utCloudconst , ActiveX, AppEnvironment, StSConst,
  BusObjClient, BusobjProduct, BusObjGLAccount, BusobjUOM, BusObjClass,
  BusObjSeedToSale, WebApiConst, utVS1Const;

{ TGTAdminAPI }

constructor TGTCloudTaskThread.Create(aCommand: string; aDBConn: TERPConnection; OnEvent:TEventProc;  params: string = '';aLogger: TLoggerBase=nil);
begin
  inherited Create(aLogger, False);
  fCommand := aCommand;
  fConn := aDBConn;
  fParams := params;
  TaskRec := TServerTaskRec.New(fCommand, fConn.Server);
  TaskRec.TaskStatus := 'Unknown';
  TaskRec.Save;
  FreeOnTerminate := true;
  fOnEvent:= OnEvent;
  fThreadParams := nil;

end;

class function TGTAdminAPI.DoCloudRequest(InJson, OutJson: TJsonObject;var OutStream: TStream; DbConn: TERPConnection; aLogger: TLoggerBase;aTaskRecID: Integer): boolean;
var
  MethodJson: TJsonObject;
  Function IsGT_cloudAuthRequest :Boolean;
  begin
    result :=
      SameText(InJson.S[TAG_ERPUserName], ERP_CLOUD_ADMIN_USER) and
      SameText(InJson.S[TAG_ERPPassword], ERP_CLOUD_ADMIN_TOKEN);
  end;
begin
   result := False;
    with TGTAdminAPI.Create do
      try
        TaskRecID := aTaskRecID;
        fLogger   := aLogger;

        if (InJson.A[TAG_URIParts].Count < 3) then Exit;

        result := SameText(InJson.A[TAG_URIParts][2].AsString, GT_Cloud_Task);

        if not result then Exit;
        if InJson.S['Command'] = 'GET' then begin

        end else if InJson.S['Command'] = 'POST' then begin
          { ------ } if SameText(InJson.A[TAG_URIParts][2].AsString, GT_Cloud_Task) then begin
                        OutJson.I[TAG_ResponseNo] := VS1_HTTP_Success_Code; { "OK" }
                        try
                          if (InJson.A[TAG_URIParts].Count >= 4) then begin
                            if SameText(InJson.A[TAG_URIParts][3].AsString, TAG_Method) then begin
                              MethodJson := InJson;//JO(InJson.O[TAG_JsonIN].AsString);
                              try
                                while MethodJson.exists(TAG_JsonIN) do MethodJson := JO(MethodJson.O[TAG_JsonIN].AsString);

                                fiThreadProgresscount := 0;
                                if MethodJson.exists(TAG_Methodname) then begin
                                    MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPUserName] := InJson.S[TAG_ERPUserName];
                                    MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPPassword] := InJson.S[TAG_ERPPassword];
                                    {Init Sts Dabase preference}
                         { ------ } if  sametext(MethodJson.S[TAG_Methodname],TASK_GT_InitDBForStS) then begin
                                        OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TGTCloudTaskThread.Create(TASK_GT_InitDBForStS, DbConn, DoEvent, MethodJson.AsString , aLogger ).TaskRec.ID;
                                        While ThreadRunning do;
                                        OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].AsString := fOutJson.AsString;
                                    end else if  sametext(MethodJson.S[TAG_Methodname],TASK_GT_AllocatePlantTag) then begin
                                        OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TGTCloudTaskThread.Create(TASK_GT_AllocatePlantTag, DbConn, DoEvent, MethodJson.AsString , aLogger ).TaskRec.ID;
                                        While ThreadRunning do;
                                        OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].AsString := fOutJson.AsString;
                                    end;
                                end;
                              finally

                              end;
                            end;
                          end;
                        finally
                        end;
                     end;
        end;
      finally

      end;
end;

destructor TGTCloudTaskThread.Destroy;
begin
  if assigned(fOnEvent) then fOnEvent('ThreadEvent','Oncomplete');
  if fThreadParams <> nil then fThreadParams.free;
  TaskRec.Free;
  inherited;
end;

procedure TGTCloudTaskThread.Execute;
begin
  CoInitialize(nil);
  try
    if not Initconn then Terminate;
             if SameText(fCommand, TASK_GT_InitDBForStS)          then begin GT_InitDBForStS;
        end else if SameText(fCommand, TASK_GT_AllocatePlantTag)  then begin GT_AllocatePlantTag;

        end;
    if not TaskRec.Complete then begin
      TaskRec.Complete := true;
      TaskRec.Save;
    end;
  finally
    CoUninitialize;
  end;
end;
Function TGTCloudTaskThread.ThreadParams:TJsonObject;
begin
  if fThreadParams = nil then begin
    fThreadParams :=JO(fParams);
  end;
  result := fThreadParams.O[TAG_CLOUD_Params];
end;
function TGTCloudTaskThread.Initconn: Boolean;
begin
        Result := False;
        if not(SameText(AppEnv.AppDb.Database, fconn.Database)) or (not(AppEnv.AppDb.Connection.Connected)) then begin
          AppEnv.AppDb.Database:= '';
          AppEnv.AppDb.Server := fconn.Server;
          AppEnv.AppDb.Database:= fconn.Database;
          try
            AppEnv.AppDb.ConnectUser(ThreadParams.S[TAG_ERPUserName], ThreadParams.S[TAG_ERPPassword]);
            Result := True;
          except
            on eusr: exception do begin
              if assigned(fOnEvent) then fOnEvent('Initconn Error',eusr.Message);
              exit;
            end;
          end;
        end;
end;

procedure TGTCloudTaskThread.GT_AllocatePlantTag;
var
  params : TJsonObject;
  StSTag : TStSTags;
  Procedure InvalidRequest(Const Msg:String);
  begin
          AddEventdata(fOnEvent ,TAG_ResponseNo , VS1_HTTP_Failed_STRCode, true);
          AddEventdata(fOnEvent ,TAG_ResponseStatus , Msg, true);
          AddEventdata(fOnEvent ,TAG_ResponseError  , Msg, true);
  end;
begin
      AddEventdata(fOnEvent ,TAG_ResponseTask     , TASK_GT_AllocatePlantTag, true);
      Params := ThreadParams;
      if Params.asString = '' then exit;
      if not (Params.Exists(GT_TAG_StSTag          )) Then begin InvalidRequest('TAG missing'); exit; end;
      if not (Params.Exists(GT_TAG_StrainName      )) Then begin InvalidRequest('Strain name Missing'); exit; end;
      if not (Params.Exists(GT_TAG_Sourcetype      )) Then begin InvalidRequest('Source Type Missing'); exit; end;
      if not (Params.Exists(GT_TAG_Plantcount      )) Then begin InvalidRequest('Plant Count Missing'); exit; end;
      if not (Params.Exists(GT_TAG_StSPhase        )) Then begin InvalidRequest('Plant Phase Missing'); exit; end;
      if not (Params.Exists(GT_TAG_UsedOn          )) Then begin Params.DT[GT_TAG_UsedOn]:= Now; end;

      if Appenv.Companyprefs.StsConfig.StSUsesBins then begin
        if not (Params.Exists(GT_TAG_RoomLocation    )) Then begin InvalidRequest('Room Location for the Plant is Missing'); exit; end;
        if not (Params.Exists(GT_TAG_RoomNumber      )) Then begin InvalidRequest('Room Location for the Plant is Missing'); exit; end;
      end;

      StSTag := TStSTags.CreateWithNewConn(nil);
      try
        StSTag.LoadSelect('StsTag =' + quotedstr(Params.S[GT_TAG_StSTag]));
        if StSTag.count >0 then begin
           InvalidRequest('Tag ' + quotedstr(Params.S[GT_TAG_StSTag])+' is Already Allocated');
           Exit;
        end;
        StSTag.connection.BeginTransaction;
        try
              StSTag.New;
              StSTag.StSTag		    := Params.S[GT_TAG_StSTag];
              StSTag.StrainName		:= Params.S[GT_TAG_StrainName];
              StSTag.Sourcetype		:= Params.S[GT_TAG_Sourcetype];
              StSTag.Plantcount		:= Params.I[GT_TAG_Plantcount];
              StSTag.StSPhase		  := Params.S[GT_TAG_StSPhase];
              StSTag.UsedOn		    := Params.DT[GT_TAG_UsedOn];
              StSTag.RoomLocation	:= Params.S[GT_TAG_RoomLocation];
              StSTag.RoomNumber		:= Params.S[GT_TAG_RoomNumber];
              if not StSTag.UseTagnMakePlant then begin
                 InvalidRequest('Tag ' + quotedstr(Params.S[GT_TAG_StSTag])+' - Failed to Allocate.  ' + StSTag.REsultStatus.Messages);
                 StSTag.Connection.RollbackTransaction;
                 Exit;
              end;
              AddEventdata(fOnEvent ,TAG_ResponseTask     , 'Tag #' +StSTag.StSTag +' is used for  '+ inttostr(StSTag.Plantcount) +' Plants from ' +  StSTag.Sourcetype+ ' of ' + StSTag.StrainName +'.' , true);
              StSTag.Connection.commitTransaction;
        Except
          on E:Exception do begin
            InvalidRequest('Tag ' + quotedstr(Params.S[GT_TAG_StSTag])+' - Failed to Allocate.  ' + E.Message);
            StSTag.Connection.RollbackTransaction;
          end;
        End;

      finally
        FreeandNil(StSTag);
      end;
end;

procedure TGTCloudTaskThread.GT_InitDBForStS;
var
  params : TJsonObject;
  fs:String;
begin
      AddEventdata(fOnEvent ,TAG_ResponseTask     , TASK_GT_InitDBForStS);
      Params := ThreadParams;
      if Params.asString = '' then exit;

      if Params.Exists(GT_TAG_StSUseSeedtoSale) Then
        if Params.B[GT_TAG_StSUseSeedtoSale] =False then begin
          AddEventdata(fOnEvent ,TAG_ResponseNo , VS1_HTTP_Failed_STRCode, true);
          AddEventdata(fOnEvent ,TAG_ResponseStatus , 'Found STS as Disabled in StS DAtabase Creation', true);
          AddEventdata(fOnEvent ,TAG_ResponseError , 'Found STS as Disabled in StS DAtabase Creation', true);
          Exit;
        end;
      if Params.Exists(GT_TAG_StSInitWithDefaults) and Params.B[GT_TAG_StSInitWithDefaults] then begin

//        if Params.Exists(GT_TAG_StSDefaultClass) and (Trim(Params.S[GT_TAG_StSDefaultClass] )<>'') Then  begin
//          if TDeptClass.IDToggle(Trim(Params.S[GT_TAG_StSDefaultClass] )) =0 then begin
//            {save Preference without the default class}
//            AddEventdata(fOnEvent ,TAG_ResponseStatus , AppEnv.DefaultClass.ClassHeading +' ('+Trim(Params.S[GT_TAG_StSDefaultClass] )+')Doesn''t Exists, Not Possible to Use this as Seed To Sale Default '+ AppEnv.DefaultClass.ClassHeading+'.', true);
//            AddEventdata(fOnEvent ,TAG_ResponseError  , AppEnv.DefaultClass.ClassHeading +' ('+Trim(Params.S[GT_TAG_StSDefaultClass] )+')Doesn''t Exists, Not Possible to Use this as Seed To Sale Default '+ AppEnv.DefaultClass.ClassHeading+'.', true);
//            Params.S[GT_TAG_StSDefaultClass] := '';
//          end;
//        end;
      fs:= Params.S[GT_TAG_StSDefaultClass];
      if (Trim(fs) <> '')  then begin
        if TDeptClass.MakeDeptClass(fs, '') <> 0 then begin
          AppEnv.Companyprefs.StSConfig.StSDefaultClass       := fs;
        end;
      end;

        {checking for STS Tag suppleir - default to metrc if blank}
        if not Params.Exists(GT_TAG_StSSupplier) or (Trim(Params.S[GT_TAG_StSSupplier] )='') Then
              Params.S[GT_TAG_StSSupplier] :=STS_METRC_Supplier;
        TSupplier.MakeSupplier(nil, Params.S[GT_TAG_StSSupplier], true);

        if not Params.Exists(GT_TAG_StSPackageTagProduct) or (Trim(Params.S[GT_TAG_StSPackageTagProduct] )='') Then  begin
            Params.S[GT_TAG_StSPackageTagProduct]  := STS_PACKAGE_TAG_PRODUCT;
        end;

        if not Params.Exists(GT_TAG_StSPlantTagProduct) or (Trim(Params.S[GT_TAG_StSPlantTagProduct] )='') Then  begin
            Params.S[GT_TAG_StSPlantTagProduct]  := STS_PLANT_TAG_PRODUCT;
        end;

        if not Params.Exists(GT_TAG_StSStockAccount) or (Trim(Params.S[GT_TAG_StSStockAccount] )='') Then  begin
            Params.S[GT_TAG_StSStockAccount]  := STS_PLANT_STOCK_ACCOUNT;
        end;
        if not Params.Exists(GT_TAG_StSUsesBins)  Then  begin
            Params.B[GT_TAG_StSUsesBins]  := True;
        end;
        Params.B[GT_TAG_StSSimpleMode]  := True;
      end;
      AppEnv.Companyprefs.StSConfig.UseSeedtoSale         := True;


      fs:= Params.S[GT_TAG_StSPlantTagProduct];
      if (Trim(fs) <> '') then begin
          if TProductSimple.MakeProduct(fs,nil,False,False,true,False, Params.S[GT_TAG_StSSupplier], 'StS^Tag') then begin
            AppEnv.Companyprefs.StSConfig.StSPlantTagProduct    := fs;
          end;
      end;

      fs := Params.S[GT_TAG_StSPackageTagProduct];
      if (Trim(fs) <> '')  then begin
          if TProductSimple.MakeProduct(fs,nil,False,False,true, False,Params.S[GT_TAG_StSSupplier], 'StS^Tag') then begin
            AppEnv.Companyprefs.StSConfig.StSPackageTagProduct  := fs;
          end;
      end;

      fs:= Params.S[GT_TAG_StSStockAccount];
      if (Trim(fs) <> '')  then begin
        if TAccount.MakeAccount(nil, fs, '', 'EXP', true) <> 0 then begin
          AppEnv.Companyprefs.StSConfig.StSStockAccount       := Params.S[GT_TAG_StSStockAccount];
        end;
      end;


      fs:= Params.S[GT_TAG_StSDefaultWeightUOM];
      if (Trim(fs) <> '')  then begin
        if TUnitOfMeasure.CreateNewUOM(nil, 0, fs)<> 0 then begin
          AppEnv.Companyprefs.StSConfig.StSDefaultWeightUOM   := fs;
        end;
      end;

      AppEnv.Companyprefs.StSConfig.StSSupplier           := Params.S[GT_TAG_StSSupplier];
      AppEnv.Companyprefs.StSConfig.StSUsesBins           := Params.B[GT_TAG_StSUsesBins];
      AppEnv.Companyprefs.StSConfig.StSSimpleMode         := Params.B[GT_TAG_StSSimpleMode];
      AppEnv.CompanyPrefs.StsConfig.Save(fconn);
      AddEventdata(fOnEvent ,TAG_ResponseNo     , VS1_HTTP_Success_STRCode, true);
      AddEventdata(fOnEvent ,TAG_ResponseStatus , 'OK', true);
      Terminate;

end;

end.
