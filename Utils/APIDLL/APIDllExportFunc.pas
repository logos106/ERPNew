unit APIDllExportFunc;

interface

uses
  ALXMLDoc, Classes, APIDllExportFuncType, windows, Forms, myAccess;

  procedure Execute(const inReqNode, outRspNode: TALXMLNode; MainApp: TApplication = nil);
  function OpenCompany(const User:String;const  Pass:String;const  dbname: string;
                     Server: string = ''; ServerPort: integer = 0): boolean;
  function OpenForUser(var fcon :TMyconnection; const  dbname: string;const User:String='';
                     Server: string = ''; ServerPort: integer = 0): boolean;
  function DoOpen(var fcon :TMyconnection; const User:String;const  Pass:String;const  dbname: string;
                     Server: string = ''; ServerPort: integer = 0; AcceptBlankPassword :Boolean = False ): boolean;
  Function CurConnection :TMyconnection;
  Function GetBusobj(Const ComponentClassName: string;
                                 Const SingleInstance: boolean = true;
                                 Const Owner: TComponent = nil;
                                 Const CheckAccessLevel:Boolean=true;
                                 Const showErrorMsg :Boolean = True;
                                 Const iTag: Integer = 0): TComponent;
  procedure CloseCompany();
//  procedure ProcessXMLRequestNode(const InNode, OutNode: TALXMLNode);
//  procedure ProcessXML(const inBlock, outBlock: TALXMLNode);
  procedure GetClassPropertyList(const ClassName: string; const PropListStream: TMemoryStream);

  function AddResult(const ParentNode: TALXMLNode;
                    const Status: string;
                    const Ref: string = '';
                    const Command: string = '';
                    const DataObject: string = '';
                    const UID: string = '';
                    const Desc: string = ''): TALXMLNode;

implementation

uses
  BusObjConst,BusObjBase, CommonLib, AppEnvironment, AppDatabase, SysUtils,
  tcDataUtils, AppXMLCmndProcObj, TypInfo, LogLib, Variants,
  XMLRequestUtils, XMLRequestConst,
  CommonDbLib, APIDllCmdProc, LogThreadLib, LogMessageTypes;


function AddResult(const ParentNode: TALXMLNode;
                    const Status: string;
                    const Ref: string = '';
                    const Command: string = '';
                    const DataObject: string = '';
                    const UID: string = '';
                    const Desc: string = ''): TALXMLNode;
var
  node: TALXMLNode;
begin
  result:= ParentNode.AddChild('Result');
  if Status <> '' then  result.Attributes['Status']:= Status;
  if Status <> '' then  result.Attributes['Ref']:= Ref;
  if Command <> '' then  result.Attributes['Command']:= Command;
  if DataObject <> '' then  result.Attributes['DataObject']:= DataObject;
  if UID <> '' then  result.Attributes['UID']:= UID;

  if Desc <> '' then begin
    node:= result.AddChild('Desc');
    node.Text:= Desc;
  end;
end;
Function GetBusobj(Const ComponentClassName: string;
                   Const SingleInstance: boolean = true;
                   Const Owner: TComponent = nil;
                   Const CheckAccessLevel:Boolean=true;
                   Const showErrorMsg :Boolean = True;
                   Const iTag: Integer = 0): TComponent;
begin
    Result := CommonLib.GetComponentByClassName(ComponentClassName,SingleInstance,Owner,CheckAccessLevel,showErrorMsg,iTag);
    {DLL is not checking the accesslevel}
    if Assigned(REsult) then
      if result is TBusObj then begin
        TBusobj(Result).IgnoreAccesslevel := True;
        if not(Assigned(TBusobj(Result).Connection)) then begin
            TBusobj(Result).Connection := TMyDacDataConnection.Create(TBusobj(Result));
            TBusobj(Result).connection.Connection := GetSharedMyDacConnection;
        end;
      end;
end;

Function CurConnection :TMyconnection;
begin
    REsult := AppEnv.AppDb.Connection;
end;
function OpenForUser(var fcon :TMyconnection; const  dbname: string;const User:String='';
                     Server: string = ''; ServerPort: integer = 0): boolean;
var
  fsUser :String;
begin
    if USer = '' then fsUser := 'Admin' else fsUser := User;
    Result := DoOpen(fcon, fsUser, '', dbname , Server, serverPort, true);
end;


function OpenCompany(const User:String;const  Pass:String;const  dbname: string;
                     Server: string = ''; ServerPort: integer = 0): boolean;
var fcon :TMyconnection;
begin
   Result := DoOpen(fcon, User, Pass, dbname , Server, serverPort, False);
end;

function DoOpen(var fcon :TMyconnection; const User:String;const  Pass:String;const  dbname: string;
                     Server: string = ''; ServerPort: integer = 0; AcceptBlankPassword :Boolean = False ): boolean;

var
  Db: TAppDatabase;
  msg: string;
begin
  ///TLogger.Inst.Log('OpenCompany - Start', ltError);
  result:= false;
  msg:= '';
  db:= nil;
  try
    db:= AppEnv.AppDb;
    if db.Connection.Connected then begin
      if db.Connection.InTransaction then
        db.Connection.Rollback;
      db.Connection.Disconnect;
    end;
    if ServerPort > 0 then Db.ServerPort:= ServerPort;
    if Server <> '' then Db.Server:= Server;
    if not Db.ServerOk then
      raise Exception.Create('Can not connect to database server.');
    Db.Database:= dbname;
    if not Db.DatabaseOk then
      raise Exception.Create('Invalid server database.');
    if not Db.VersionOk then
      raise Exception.Create('Invalid database data version.');
    DB.AcceptBlankPassword := AcceptBlankPassword;
    try
      Db.ConnectUser(User, Pass);
    finally
        DB.AcceptBlankPassword := False;
    end;
    result:= Db.Connection.Connected;
    fcon :=Db.Connection;
    if not result then
      msg:= 'Open Company failed';
  except
    on E: Exception do begin
      msg:= 'Open Company failed with message: ' + e.Message;
      if Assigned(db) then
        db.Connection.Disconnect;
    end
  end;
  if result then
    ///TLogger.Inst.Log('OpenCompany - Opened ok', ltError)
  else
    ///TLogger.Inst.Log('OpenCompany - Opened Failed: '+Msg, ltError);
end;

procedure CloseCompany();
var
  aAppEnv: TAppEnvironment;
begin
  aAppEnv:= AppEnvList.AppEnvForThread(GetCurrentThreadID);
  if Assigned(aAppEnv) and aAppenv.AppDb.Connection.Connected then begin
    aAppenv.AppDb.Connection.Disconnect;
    { free the AppEnv instance for this thread }
    AppEnvList.RemoveAppEnvInstance;
  end;
end;


{  ProcessXMLRequest input/output nodes are the "block" part of the request
   ie the <xmlBlock> node from below:

<ERPxml>
	<xmlBlock ticket="0V8Ool3Ipx1nTAg" onError="continue">
		<request command=...>
                        ...
		</request>
	</xmlBlock>
</ERPxml> }

//procedure ProcessXML(const inBlock, outBlock: TALXMLNode);
//var
//  DbConn: TMyConnection;
//  requestNode, responceNode: IXMLNode;
//  x: integer;
//  StopOnError: boolean;
//begin
//  { set up connection to be used by all requests inside block }
//  if AppEnv.AppDb.Connection.Connected then begin
//    StopOnError:= NodeAttStr(inBlock,XMLAttOnError) = XMLOnErrorStop;
//    DbConn:= CommonDbLib.GetNewMyDacConnection(nil);
//    try
//      for x:= 0 to inBlock.ChildNodes.Count -1 do begin
//        requestNode:= inBlock.ChildNodes[x];
//        if (requestNode.NodeType <> ntComment) then begin
//          { create responce node in outbut block }
//          responceNode:= AddResponceNode(outBlock, requestNode,XMLResultNone);
//          { process this request node }
//          if not DoXMLRequest(requestNode,responceNode,DbConn,StopOnError) then begin
//            if StopOnError then begin
//              { rollback and stop any further processing }
//              DbConn.Rollback;
//              break;
//            end
//            else begin
//              { not stopOnError so continue processing next request ... }
//              { Node: logic in DoXMLRequest will rollback nested transaction
//                      for this request. }
//            end;
//          end;
//        end;
//      end;
//      DbConn.Commit;
//    finally
//      DbConn.Rollback;
//      DbConn.Free;
//    end;
//  end
//  else begin
//    AddResponceNode(outBlock,nil,XMLResultFail,XMLFailReasonCompanyNotOpen,'','Company not open');
//  end;
//end;

procedure Execute(const inReqNode, outRspNode: TALXMLNode; MainApp: TApplication = nil);
var
  DbConn: TMyConnection;
  DoneOk, InTransNode: boolean;
  comp: integer;

  function CheckCompanyOpen(responceNode: TALXMLNode): boolean;
  begin
    result:= true;
    if (not Assigned(DbConn)) or (not DbConn.Connected) then begin
      responceNode.Attributes[XMLAttResult]:= XMLResultFail;
      responceNode.Attributes[XMLAttFailReason]:= XMLFailReasonCompanyNotOpen;
      responceNode.AddChild(XMLNodeDesc).Text:= FmtRespStr('Company not open');
      result:= false;
    end;
  end;

  { function to loop through requests and recursivly call its self for
    "nested" type requests }
  function DoReqNode(inNode, outNode: TALXMLNode): boolean;
  var
    req, res, subReq, subRes: TALXMLNode;
    x, i: integer;
    command: string;
    StopOnError: boolean;
    msg: string;
  begin
    ///TLogger.Inst.Log('DoReqNode - Start', ltDetail);
    result:= true;
    for x:= 0 to inNode.ChildNodes.Count -1 do begin
      ///TLogger.Inst.Log('DoReqNode - Processing node ' + IntToStr(x+1) + ' of ' + IntToStr(inNode.ChildNodes.Count), ltDetail);
//      req:= nil;
      req:= inNode.ChildNodes[x];
      if Assigned(req) then
        ///TLogger.Inst.Log('DoReqNode - Node is assigned', ltDetail)
      else
        ///TLogger.Inst.Log('DoReqNode - Node NOT assigned', ltDetail);
      ///TLogger.Inst.Log('DoReqNode - Node XML: ' + req.XML, ltDetail);
      if (req.NodeType <> ntComment) and (req.NodeName = XMLNodeRequest) then begin
        res:= AddResponceNode(outNode,req);
        command:= NodeAttStr(req, XMLAttCommand);
        ///TLogger.Inst.Log('DoReqNode - Command = ' + command, ltDetail);
        if command = XMLCmdTransaction then begin
          if InTransNode then begin
            res.Attributes[XMLAttResult]:= XMLResultFail;
            res.Attributes[XMLAttFailReason]:= XMLFailReasonGeneral;
            res.AddChild(XMLNodeDesc).Text:= FmtRespStr('Already inside transaction block, can not nest transactions');
            result:= false;
            ///TLogger.Inst.Log('DoReqNode - Fail: ' + res.ChildNodes[0].Text, ltError);
            exit;
          end;
          if not CheckCompanyOpen(res) then begin
            result:= false;
            exit;
          end;
          StopOnError:= NodeAttStr(req,XMLAttOnError) = XMLOnErrorStop;
          InTransNode:= true;
          if Assigned(DbConn) and DbConn.Connected then begin
            ///TLogger.Inst.Log('DoReqNode - Starting database transaction', ltDetail);
            DbConn.StartTransaction;
          end
          else begin
            ///TLogger.Inst.Log('DoReqNode - Not connected to database', ltDetail);
          end;
          try
            for i:= 0 to req.ChildNodes.Count -1 do begin
              subReq:= req.ChildNodes[i];
              if (subReq.NodeType <> ntComment) and (subReq.NodeName = XMLNodeRequest) then begin
                subRes:= AddResponceNode(res,subReq);
                ///TLogger.Inst.Log('DoReqNode - Calling DoXMLRequest', ltDetail);
                if not DoXMLRequest(subReq,subRes,DbConn,StopOnError) then begin
                  ///TLogger.Inst.Log('DoReqNode - DoXMLRequest failed', ltDetail);
                  if StopOnError then begin
                    if Assigned(DbConn) and DbConn.Connected then begin
                      ///TLogger.Inst.Log('DoReqNode - Rolling back database transaction', ltDetail);
                      DbConn.Rollback;
                    end;
                    res.Attributes[XMLAttResult]:= XMLResultFail;
                    res.Attributes[XMLAttFailReason]:= XMLFailReasonTransactionErrors;
                    result:= false;
                    ///TLogger.Inst.Log('DoReqNode - Fail: Transaction errors', ltError);
                    break;
                  end
                  else begin
                    { don't stop on error, just update transaction result node }
                    res.Attributes[XMLAttResult]:= XMLResultWarning;
                    res.Attributes[XMLAttFailReason]:= XMLFailReasonTransactionErrors;
                    ///TLogger.Inst.Log('DoReqNode - Warning: Transaction errors', ltError);
                  end;
                end
                else begin
                  ///TLogger.Inst.Log('DoReqNode - DoXMLRequest processed ok', ltDetail);
                end;
              end;
            end;
            if Assigned(DbConn) and DbConn.Connected then begin
              DbConn.Commit;
              ///TLogger.Inst.Log('DoReqNode - Committing transaction', ltDetail);
            end
            else begin
              ///TLogger.Inst.Log('DoReqNode - Not connected', ltDetail);
            end;
          finally
            if Assigned(DbConn) and DbConn.Connected then
              DbConn.Rollback;
            InTransNode:= false;
          end;
        end
        else if command = XMLCmdOpenCompany then begin
          if Assigned(DbConn) then begin
            if DbConn.Connected and DbConn.InTransaction then begin
              DbConn.Rollback;
              ///TLogger.Inst.Log('DoReqNode - Rolled back database connection' + msg, ltDetail);
            end;
            DbConn.Free;
            DbConn:= nil;
            ///TLogger.Inst.Log('DoReqNode - Freeed database connection' + msg, ltDetail);
          end;
          if OpenCompany((*msg,*)
                       SubNodeStr(req, XMLNodeUser),
                       SubNodeStr(req, XMLNodePass),
                       SubNodeStr(req, XMLNodeDatabase),
                       SubNodeStr(req, XMLNodeDataServer),
                       StrToIntDef(SubNodeStr(req, XMLNodeDataServerPort),0)) then begin
            { company opened ok }
            res.Attributes[XMLAttResult]:= XMLResultOk;
            DbConn:= CommonDbLib.GetNewMyDacConnection(nil);
            ///TLogger.Inst.Log('DoReqNode - Opened company and got new database connection' + msg, ltDetail);
          end
          else begin
            if Assigned(DbConn) then begin
              DbConn.Free;
              DbConn:= nil;
            end;
            res.Attributes[XMLAttResult]:= XMLResultFail;
            res.Attributes[XMLAttFailReason]:= XMLFailReasonDbConnectFail;
            res.AddChild(XMLNodeDesc).Text:= FmtRespStr(msg);
            result:= false;
            ///TLogger.Inst.Log('DoReqNode - Fail: ' + msg, ltError);
            exit;
          end;
        end
        else if command = XMLCmdCloseCompany then begin
          if Assigned(DbConn) then begin
            if DbConn.Connected and DbConn.InTransaction then begin
              DbConn.Rollback;
              ///TLogger.Inst.Log('DoReqNode - Rolled back database connection' + msg, ltDetail);
            end;
            DbConn.Free;
            DbConn:= nil;
            ///TLogger.Inst.Log('DoReqNode - Freeed database connection' + msg, ltDetail);
          end;
          res.Attributes[XMLAttResult]:= XMLResultOk;
        end
        else begin
          {pass command to business object logic to process}
          if not CheckCompanyOpen(res) then begin
            result:= false;
            exit;
          end;
          ///TLogger.Inst.Log('DoReqNode - Calling DoXMLRequest', ltDetail);
          result:= DoXMLRequest(req,res,DbConn,true);
          if Assigned(DbConn) and DbConn.Connected and DbConn.InTransaction then begin
            if result then begin
              DbConn.Commit;
              ///TLogger.Inst.Log('DoReqNode - Commited database changes', ltDetail);
            end
            else begin
              DbConn.Rollback;
              ///TLogger.Inst.Log('DoReqNode - Rolled back database changes', ltDetail);
            end;
          end;
        end;
      end;
    end;
  end;


begin
  if Assigned(MainApp) then begin
    if not Assigned(Logger) then begin
      for comp:= 0 to MainApp.ComponentCount -1 do begin
        if MainApp.Components[comp].ClassName = 'TLogger' then begin
          Logger:= TLogger(MainApp.Components[comp]);
          break;
        end;
      end
    end;
  end;
  ///TLogger.Inst.Log('Execute - Start', ltDetail);
  DoneOk:= false;
  ///TLogger.Inst.Log('Execute - DoneOk set to false', ltDetail);
  InTransNode:= false;
  ///TLogger.Inst.Log('Execute - InTransMode set to false', ltDetail);
  DbConn:= nil;
  ///TLogger.Inst.Log('Execute - DbConn set to nil', ltDetail);
  try
    try
      if AppEnv.AppDb.Connection.Connected then begin
        ///TLogger.Inst.Log('Execute - Database already connected, getting new connection instance', ltDetail);
        DbConn:= CommonDbLib.GetNewMyDacConnection(nil);
      end;
      ///TLogger.Inst.Log('Execute - About to call DoReqNode', ltDetail);
      DoneOk:= DoReqNode(inReqNode,outRspNode);
    except
      on e: exception do begin
        DoneOk:= false;
        outRspNode.Attributes[XMLAttResult]:= XMLResultFail;
        outRspNode.Attributes[XMLAttFailReason]:= XMLFailReasonException;
        outRspNode.AddChild(XMLNodeDesc).Text:= FmtRespStr(e.Message);
        ///TLogger.Inst.Log('Execute - Exception: ' + outRspNode.ChildNodes[0].Text, ltError);
      end;
    end;
  finally
    if DoneOk then begin
      if Assigned(DbConn) and DbConn.InTransaction then
        DbConn.Commit;
      outRspNode.Attributes[XMLAttResult]:= XMLResultOk;
    end
    else begin
      if Assigned(DbConn) and DbConn.InTransaction then
        DbConn.Rollback;
      outRspNode.Attributes[XMLAttResult]:= XMLResultFail;
    end;
    if Assigned(DbConn) then
      DbConn.Free;
  end;
end;

//procedure ProcessXMLRequestNode(const InNode, OutNode: TALXMLNode);
//var
//  DataServer, Database, User, Pass, DBVersion: string;
//  CommandProc: TAppXMLCmndProc;
//  StartTime: TDateTime;
//
//  function TimeRequest: boolean;
//  begin
//    result:= Assigned(InNode) and
//      InNode.HasAttribute('RequestTiming') and
//      (InNode.Attributes['RequestTiming'] = 'On');
//  end;
//
//
//begin
//  StartTime:= now;
//
//  if not Assigned(InNode) then begin
//    AddResult(OutNode,'Error','','','','','Invalid input XML structure, Root node not found.');
//    exit;
//  end;
//
//  try
//
//    if not VarIsNull(InNode.Attributes['DataServer']) then
//      DataServer:= InNode.Attributes['DataServer'];
//    if DataServer = '' then
//      DataServer:= 'localhost';
//    Database:= InNode.Attributes['Database'];
//    User:= InNode.Attributes['User'];
//    Pass:= InNode.Attributes['Pass'];
//
//    if (Database = '') then begin
//      AddResult(OutNode,'Error','','','','','No database name provided.');
//      exit;
//    end
//    else if (User = '') then begin
//      AddResult(OutNode,'Error','','','','','No database user name provided.');
//      exit;
//    end
//    else if (Pass = '') then begin
//      AddResult(OutNode,'Error','','','','','No database user password provided.');
//      exit;
//    end;
//
//    try
//      AppEnv.AppDb.Server  := DataServer;
//      if not AppEnv.AppDb.ServerOk then
//        raise Exception.Create('Can not connect to database server.');
//      AppEnv.AppDb.Database := Database;
//      if not AppEnv.AppDb.DatabaseOk then
//        raise Exception.Create('Invalid server database.');
//      if not AppEnv.AppDb.VersionOk then
//        raise Exception.Create('Invalid database data version.');
//      Log('ProcessXMLRequest - AppEnv.AppDb.Server: "' + AppEnv.AppDb.Server +
//        '" AppEnv.AppDb.Database: "' + AppEnv.AppDb.Database + '" User: "' + User + '" Pass: "' + Pass + '"', 'Info');
//      AppEnv.AppDb.ConnectUser(User,Pass);
//    except
//      on E: Exception do begin
//        AddResult(OutNode,'Error','','','','','Error connecting to database: ' + E.Message);
//        exit;
//      end;
//    end;
//
//    DbVersion:= InNode.Attributes['DataVersion'];
//    if DbVersion = '' then begin
//      AddResult(OutNode,'Error','','','','','DataVersion not provided.');
//      exit;
//    end;
//
//    if DbVersion <> getUserVersion then begin
//      AddResult(OutNode,'Error','','','','','DataVersion Incompatible.');
//      exit;
//    end;
//
//    CommandProc:= TAppXMLCmndProc.Create;
//    try
//      CommandProc.ProcessXML(InNode, OutNode);
//
//    finally
//      CommandProc.Free;
//    end;
//
//
//  finally
//    if TimeRequest then
//      OutNode.Attributes['RequestExecutionTime']:= FormatDateTime('hh:nn:ss:zzz', now - StartTime);
//    SharedDataConnList.RemoveSharedDataConnInstance;
//    AppEnvList.RemoveAppEnvInstance;
//  end;
//end;

procedure GetClassPropertyList(const ClassName: string; const PropListStream: TMemoryStream);
var
  SL: TStringList;
  count, x: integer;
  aClass: TPersistentClass;
  PropList: PPropList;
begin
  aClass:= GetClass(ClassName);
  if Assigned(aClass) then begin
    Count := GetPropList(aClass.ClassInfo, tkProperties, nil);
    GetMem(PropList, Count * SizeOf(PPropInfo));
    SL:= TStringList.Create;
    try
      GetPropList(aClass.ClassInfo, tkProperties, PropList);
      for x := 0 to Count -1 do
        SL.Add(PropList[x].Name);
      SL.SaveToFile('temp.txt');
      //SL.SaveToStream(PropListStream);
      PropListStream.LoadFromFile('temp.txt');
    finally
      FreeMem(PropList, Count * SizeOf(PPropInfo));
      SL.Free;
    end;

  end;
end;

initialization

finalization

end.
