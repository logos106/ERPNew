unit APIDllCmdProc;

interface

uses
  ALXMLDoc, MyAccess;

  function DoXMLRequest(req, res: TALXMLNode; dbConn: TMyConnection; stopOnError: boolean): boolean;

implementation

uses
  XMLRequestConst, XMLRequestUtils, sysUtils, AppEnvironment, BusObjBase,
  CommonLib, LogThreadLib, LogMessageTypes, classes;

function DoXMLRequest(req, res: TALXMLNode; dbConn: TMyConnection; stopOnError: boolean): boolean;
var
  command: string;
  subNodeIdx: integer;
  subNode, filterNode, limitNode, sortNode, responceNode, structNode: TALXMLNode;
  BusObjClassName: string;
  BusObj: TBusObj;
  SelectStr: string;
  ObjectNumber: integer;
  x: integer;
  sortList: TStringList;
  s: string;

  function GetBusObjInst: TBusObj;
  begin
    result:= nil;
    BusObjClassName:= NodeAttStr(req, XMLAttDataObject);
    if BusObjClassName <> '' then begin
      BusObjClassName:= 'T' + BusObjClassName;
      result:= TBusObj(GetComponentByClassName(BusObjClassName, false , nil , False , False));
      if not Assigned(result) then begin
         { unknown object }
        res.Attributes[XMLAttResult]:= XMLResultFail;
        res.Attributes[XMLAttFailReason]:= XMLFailReasonUnknownDataObject;
        res.AddChild(XMLNodeDesc).Text:= FmtRespStr('Unknown data object');
      end;
    end
    else begin
      { dataObject name missing }
      res.Attributes[XMLAttResult]:= XMLResultFail;
      res.Attributes[XMLAttFailReason]:= XMLFailReasonNoDataObject;
      res.AddChild(XMLNodeDesc).Text:= FmtRespStr('Missing data object name');
    end;
  end;



begin
  ///TLogger.Inst.Log('DoXMLRequest - Start', ltDetail);
  result:= false;
  try
    command:= NodeAttStr(req,XMLAttCommand);
    if command <> '' then begin
      { Set fileds command }
      if command = XMLCmdSetFields then begin
        for subNodeIdx:= 0 to req.ChildNodes.Count -1 do begin
          subNode:= req.ChildNodes[subNodeIdx];
          if (subNode.NodeType <> ntComment) and (subNode.NodeName = XMLNodeFieldList) then begin
            if (NodeAttStr(subNode,XMLAttDataObject) = '') then begin
              res.Attributes[XMLAttResult]:= XMLResultFail;
              res.Attributes[XMLAttFailReason]:= XMLFailReasonNoDataObject;
              res.AddChild(XMLNodeDesc).Text:= FmtRespStr('Data Object not specified');
              exit;
            end;
            if (NodeAttStr(subNode,XMLAttOption) = '') then begin
              res.Attributes[XMLAttResult]:= XMLResultFail;
              res.Attributes[XMLAttFailReason]:= XMLFailReasonNoOption;
              res.AddChild(XMLNodeDesc).Text:= FmtRespStr('Option not specified');
              exit;
            end;

            BusObjClassName:= NodeAttStr(subNode,XMLAttDataObject);
            if BusObjClassName <> '' then begin
              BusObjClassName:= 'T' + BusObjClassName;
              try
                if NodeAttStr(subNode,XMLAttOption) = XMLOptionAdd then begin
                  AppEnv.BusObjFieldList.LoadObjectDefaults(BusObjClassName);
                  AppEnv.BusObjFieldList.AddObjectFields(BusObjClassName, subNode.Text);
                end
                else if NodeAttStr(subNode,XMLAttOption) = XMLOptionReplace then begin
                  AppEnv.BusObjFieldList.ClearObjectFields(BusObjClassName);
                  AppEnv.BusObjFieldList.AddObjectFields(BusObjClassName, subNode.Text);
                end
                else begin
                  { unknown option }
                  res.Attributes[XMLAttResult]:= XMLResultFail;
                  res.Attributes[XMLAttFailReason]:= XMLFailReasonInvalidOption;
                  res.AddChild(XMLNodeDesc).Text:= FmtRespStr('Invalid option');
                  exit;
                end;
              except
                on e: Exception do begin
                  res.Attributes[XMLAttResult]:= XMLResultFail;
                  res.Attributes[XMLAttFailReason]:= XMLFailReasonException;
                  res.AddChild(XMLNodeDesc).Text:= FmtRespStr(e.Message);
                  exit;
                end;
              end;
            end
            else begin
              { blank bus obj name }
              res.Attributes[XMLAttResult]:= XMLResultFail;
              res.Attributes[XMLAttFailReason]:= XMLFailReasonNoDataObject;
              res.AddChild(XMLNodeDesc).Text:= FmtRespStr('Missing data object name');
              exit;
            end;
          end;
        end;
        res.Attributes[XMLAttResult]:= XMLResultOk;
        result:= true;
      end
      else if command = XMLCmdRead then begin
        BusObj:= GetBusObjInst;
        if not Assigned(BusObj) then
          exit;
        try
          BusObj.Connection := TMydacDataConnection.Create(TBusObj(BusObj));
          BusObj.Connection.MyDacConnection:= dbConn;

          { limit fields }
          BusObj.LimitXMLFieldsOnSave:= NodeAttStr(req,XMLAttLimitFieldList) = XMLValTrue;
          { exclude inative }
          BusObj.ExcludeInactive:= NodeAttStr(req,XMLAttExcludeInactive) = XMLValTrue;

          SelectStr:= '';
          {  check to see if user is requesting a specific GlobalRef }
          if req.HasAttribute(XMLAttGlobalRef) then begin
            SelectStr:= 'GlobalRef = "' + req.Attributes[XMLAttGlobalRef] + '"';
            BusObj.LoadSelect(SelectStr);
          end
          else if req.HasAttribute(XMLAttRecId) then begin
            BusObj.Load(req.Attributes[XMLAttRecId]);
          end
          else begin

            { do we have a limit info }
            limitNode:= req.ChildNodes.FindNode(XMLNodeLimit);
            if Assigned(limitNode) then begin
              BusObj.LimitFrom:= StrToIntDef(SubNodeStr(limitNode,XMLNodeLimitFrom),0);
              BusObj.LimitCount:= StrToIntDef(SubNodeStr(limitNode,XMLNodeLimitCount),0);
            end;

            { do we have a filter ... }
            filterNode:= req.ChildNodes.FindNode(XMLNodeFilter);
            { do we have a load select ... }
            subNode:= req.ChildNodes.FindNode(XMLNodeSelect);
            { do we have sorting ... }
            sortNode:= req.ChildNodes.FindNode(XMLNodeSort);
            if assigned(sortNode) then begin
              sortList:= TStringList.Create;
              try
                sortlist.CommaText:= NodeAttStr(sortNode,XMLAttSortList);
                if sortList.Count > 0 then begin
                  BusObj.Load(0);
                  try
                    for x:= 0 to sortList.Count -1 do begin
                      s:= busObj.PropertyNameToFieldName(sortList[x]);
                      if s <> '' then
                        sortList[x]:= s
                      else begin
                        { problem obtaining databse field name from prioperty name }
                        res.Attributes[XMLAttResult]:= XMLResultFail;
                        res.Attributes[XMLAttFailReason]:= XMLFailReasonInvalidSort;
                        res.AddChild(XMLNodeDesc).Text:= FmtRespStr('Invalid sort value: "' + sortList[x] + '"');
                        exit;
                      end;
                    end;
                  finally
                    busObj.Close(true);
                  end;
                  if sortList.Count > 0 then
                    busObj.SQLOrder:= sortList.CommaText;
                end;
              finally
                sortList.Free;
              end;
            end;

            if Assigned(FilterNode) then begin
              ///TLogger.Inst.Log('DoXMLRequest - Filter has been specified', ltDetail);
              //BusObj.FilterSelect(FilterNode)
              BusObj.LoadParamList.Clear;
              for x:= 0 to req.ChildNodes.Count -1 do begin
                if req.ChildNodes[x].NodeName = XMLNodeFilter then begin
//                  ///TLogger.Inst.Log('DoXMLRequest - Adding filter:' + #13#10 + req.ChildNodes[x].XML, ltDetail);
                  BusObj.FilterAdd(req.ChildNodes[x]);
                  { check it loaded without error }
                  if not BusObj.ResultStatus.OperationOk then begin
                    res.Attributes[XMLAttResult]:= XMLResultFail;
                    res.Attributes[XMLAttFailReason]:= XMLFailReasonGeneral;
                    res.AddChild(XMLNodeDesc).Text:= FmtRespStr(BusObj.ResultStatus.Messages);
                    exit;
                  end;
                end;
              end;
              BusObj.Load;
              ///TLogger.Inst.Log('DoXMLRequest - Business Object Load return record count: ' + IntToStr(BusObj.Count), ltDetail);
            end
            else if Assigned(SubNode) then begin
              BusObj.LoadSelect(SubNode.Text);
              ///TLogger.Inst.Log('DoXMLRequest - Business Object LoadSelect return record count: ' + IntToStr(BusObj.Count), ltDetail);
            end
            else begin
              { load all }
              BusObj.Load;
              ///TLogger.Inst.Log('DoXMLRequest - Business Object Load (all) return record count: ' + IntToStr(BusObj.Count), ltDetail);
            end;
          end;

          { check it loaded without error }
          if not BusObj.ResultStatus.OperationOk then begin
            res.Attributes[XMLAttResult]:= XMLResultFail;
            res.Attributes[XMLAttFailReason]:= XMLFailReasonGeneral;
            res.AddChild(XMLNodeDesc).Text:= FmtRespStr(BusObj.ResultStatus.Messages);
            exit;
          end;
          result:= true;
          if BusObj.Count > 0 then begin
            { add each instance to output xml }
            ObjectNumber:= 1;
            res.Attributes[XMLAttObjectCount]:= BusObj.Count;
            responceNode:= nil;
            while not BusObj.EOF do begin
              if BusObj.BOF then
                responceNode:= res
              else begin
                responceNode:= CopyNode(responceNode, res.ParentNode);//responceNode.CloneNode(false);
              end;

              BusObj.SaveToXMLNode(responceNode.AddChild(BusObj.XMLNodeName));
              responceNode.Attributes[XMLAttResult]:= XMLResultOk;
              if BusObj is TMSBusObj then begin
                responceNode.Attributes[XMLAttGlobalRef]:= TMSBusObj(BusObj).GlobalRef;
                responceNode.Attributes[XMLAttRecId]:= IntToStr(TMSBusObj(BusObj).Id);
              end;

              responceNode.Attributes[XMLAttObjectNumber]:= ObjectNumber;
              Inc(ObjectNumber);
              BusObj.Next;
            end;
          end
          else begin
            res.Attributes[XMLAttResult]:= XMLResultNoData;
            res.AddChild(XMLNodeDesc).Text:= FmtRespStr('No matching records found');
          end;

        finally
          BusObj.Free;
        end;
      end
      else if (command = XMLCmdAdd) or (command = XMLCmdModify) then begin
        { Adding or Modifing a business object }

        BusObj:= GetBusObjInst;
        if not Assigned(BusObj) then
          exit;
        try
          BusObj.Connection := TMydacDataConnection.Create(TBusObj(BusObj));
          BusObj.Connection.MyDacConnection:= dbConn;

          BusObj.Connection.BeginNestedTransaction;
          try
            structNode:= req.ChildNodes.FindNode(BusObj.XMLNodeName);
            if not Assigned(StructNode) then begin
              result:= false;
              res.Attributes[XMLAttResult]:= XMLResultFail;
              res.Attributes[XMLAttFailReason]:= XMLFailReasonNoObjectStructure;
              res.AddChild(XMLNodeDesc).Text:= FmtRespStr('Missing object structure');
              BusObj.Connection.RollbackNestedTransaction;
              exit;
            end;

            BusObj.SilentMode:= true;
            BusObj.ResultStatus.Clear;

            if (Command = XMLCmdAdd) then begin
              { adding a new record }
              BusObj.New;
              { check ststus in case user does not have create rights etc }
              if not BusObj.ResultStatus.OperationOk then begin
                res.Attributes[XMLAttResult]:= XMLResultFail;
                res.Attributes[XMLAttFailReason]:= XMLFailReasonGeneral;
                res.AddChild(XMLNodeDesc).Text:= FmtRespStr(BusObj.ResultStatus.Messages);
                BusObj.Connection.RollbackNestedTransaction;
                exit;
              end;
            end
            else if  (Command = XMLCmdModify) then begin
              { updating an existion record }
              if req.HasAttribute(XMLAttGlobalRef) then begin
                SelectStr:= 'GlobalRef = "' + req.Attributes[XMLAttGlobalRef] + '"';
                BusObj.LoadSelect(SelectStr);
              end
              else if req.HasAttribute(XMLAttRecId) then begin
                BusObj.Load(req.Attributes[XMLAttRecId]);
              end
              else begin
                res.Attributes[XMLAttResult]:= XMLResultFail;
                res.Attributes[XMLAttFailReason]:= XMLFailReasonGeneral;
                res.AddChild(XMLNodeDesc).Text:= FmtRespStr('Missing GlobalRef or RecId from request');
                BusObj.Connection.RollbackNestedTransaction;
                exit;
              end;

              if BusObj.Count = 0 then begin {nothing found}
                res.Attributes[XMLAttResult]:= XMLResultFail;
                res.Attributes[XMLAttFailReason]:= XMLFailReasonObjectNotFound;
                res.AddChild(XMLNodeDesc).Text:= FmtRespStr('Object not found');
                BusObj.Connection.RollbackNestedTransaction;
                exit;
              end;
              BusObj.Edit;
              { check ststus in case user does not have edit rights etc }
              if not BusObj.ResultStatus.OperationOk then begin
                res.Attributes[XMLAttResult]:= XMLResultFail;
                res.Attributes[XMLAttFailReason]:= XMLFailReasonGeneral;
                res.AddChild(XMLNodeDesc).Text:= FmtRespStr(BusObj.ResultStatus.Messages);
                BusObj.Connection.RollbackNestedTransaction;
                exit;
              end;
            end;

            If not BusObj.Lock then begin
              res.Attributes[XMLAttResult]:= XMLResultFail;
              res.Attributes[XMLAttFailReason]:= XMLFailReasonGeneral;
              res.AddChild(XMLNodeDesc).Text:=
                FmtRespStr('Unable to update as record is being updated by "' + BusObj.UserLock.LockInfo.UserName + '"');
              BusObj.Connection.RollbackNestedTransaction;
              exit;
            end;

            BusObj.LoadFromXMLNode(StructNode);
            { check for errors that may have occured during population of object properties }
            if not BusObj.ResultStatus.OperationOk then begin
              res.Attributes[XMLAttResult]:= XMLResultFail;
              res.Attributes[XMLAttFailReason]:= XMLFailReasonGeneral;
              res.AddChild(XMLNodeDesc).Text:= FmtRespStr(BusObj.ResultStatus.Messages);
              BusObj.Connection.RollbackNestedTransaction;
              exit;
            end;
            BusObj.Save;

            { check for errors that where when object called validate during save process }
            if not BusObj.ResultStatus.OperationOk then begin
              res.Attributes[XMLAttResult]:= XMLResultFail;
              res.Attributes[XMLAttFailReason]:= XMLFailReasonGeneral;
              res.AddChild(XMLNodeDesc).Text:= FmtRespStr(BusObj.ResultStatus.Messages);
              BusObj.Connection.RollbackNestedTransaction;
              exit;
            end;

            BusObj.Connection.CommitNestedTransaction;
            res.Attributes[XMLAttResult]:= XMLResultOk;
            result:= true;
          except
            BusObj.Connection.RollbackNestedTransaction;
            raise;
          end;

          if BusObj is TMSBusObj then begin
            res.Attributes[XMLAttGlobalRef]:= TMSBusObj(BusObj).GlobalRef;
            res.Attributes[XMLAttRecId]:= IntToStr(TMSBusObj(BusObj).Id);
          end;
        finally
          BusObj.Free;
        end;


      end
      else begin
        res.Attributes[XMLAttResult]:= XMLResultFail;
        res.Attributes[XMLAttFailReason]:= XMLFailReasonUnknownCommand;
        res.AddChild(XMLNodeDesc).Text:= FmtRespStr('Unknown command');
      end;
    end
    else begin
      { no command }
      res.Attributes[XMLAttResult]:= XMLResultFail;
      res.Attributes[XMLAttFailReason]:= XMLFailReasonNoCommand;
      res.AddChild(XMLNodeDesc).Text:= FmtRespStr('No command found');
    end;
  except
    on e: Exception do begin
      result:= false;
      res.Attributes[XMLAttResult]:= XMLResultFail;
      res.Attributes[XMLAttFailReason]:= XMLFailReasonException;
      res.AddChild(XMLNodeDesc).Text:= FmtRespStr(e.Message);
    end;
  end;
end;

end.
