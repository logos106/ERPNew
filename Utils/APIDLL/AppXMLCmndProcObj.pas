unit AppXMLCmndProcObj;

interface

uses
  ALXMLDoc, MyAccess;

type

  TAppXMLCmndProc = class(TObject)
  private
    function ProcessRequest(RequestNode, ResultNode: TALXMLNode;
      Conn: TMyConnection; StopOnError: boolean): boolean;
  public
    procedure ProcessXML(inRoot, outRoot: TALXMLNode); overload;
  end;

implementation

uses
  Classes, SysUtils,  CommonLib, BusObjConst,APIDllExportFunc,
  CommonDbLib, AppEnvironment, BusObjBase, Variants, XMLRequestUtils;

{ TAppXMLCmndProc }


procedure TAppXMLCmndProc.ProcessXML(inRoot, outRoot: TALXMLNode);
var
  inP1RequestCount, RequestCount: integer;
  inP1RequestNode, outP1RequestNode, RequestNode, ResultNode: TALXMLNode;
  StopOnError: boolean;
  DbConn: TMyConnection;
begin
  if inRoot.ChildNodes.Count > 0 then begin
    DbConn:= CommonDbLib.GetNewMyDacConnection(nil);
    try
      for inP1RequestCount:= 0 to inRoot.ChildNodes.Count -1 do begin
          inP1RequestNode:= inRoot.ChildNodes[inP1RequestCount];
          if inP1RequestNode.NodeType <> ntComment then begin
            outP1RequestNode:= outRoot.AddChild(inP1RequestNode.NodeName);

            if VarIsNull(inP1RequestNode.Attributes['OnError']) then begin
              AddResult(OutRoot,'Error','','','','','Attribute "OnError" missing from request.');
              break;
            end
            else if ((inP1RequestNode.Attributes['OnError'] <> 'Stop') and (inP1RequestNode.Attributes['OnError'] <> 'Continue')) then begin
              AddResult(OutRoot,'Error','','','','','Request attribute "OnError" value must be either True or False.');
              break;
            end;

            outP1RequestNode.Attributes['OnError']:= inP1RequestNode.Attributes['OnError'];
            StopOnError:= outP1RequestNode.Attributes['OnError'] = 'Stop';
            DbConn.StartTransaction;
            try
              for RequestCount:= 0 to inP1RequestNode.ChildNodes.Count -1 do begin
                RequestNode:= inP1RequestNode.ChildNodes[RequestCount];
                if RequestNode.NodeType <> ntComment then begin

                  ResultNode:= outP1RequestNode.AddChild('Result');
                  if RequestNode.HasAttribute('Command') then
                    ResultNode.Attributes['Command']:= RequestNode.Attributes['Command'];
                  if RequestNode.HasAttribute('DataObject') then
                    ResultNode.Attributes['DataObject']:= RequestNode.Attributes['DataObject'];
                  if RequestNode.HasAttribute('Ref') then
                    ResultNode.Attributes['Ref']:= RequestNode.Attributes['Ref'];
                  if RequestNode.HasAttribute('GlodalRef') then
                    ResultNode.Attributes['GlobalRef']:= RequestNode.Attributes['GlobalRef'];
                  if RequestNode.HasAttribute('RecId') then
                    ResultNode.Attributes['RecId']:= RequestNode.Attributes['RecId'];

                  if StopOnError then begin
                    if (not ProcessRequest(RequestNode, ResultNode, DbConn, StopOnError)) then begin
                      DbConn.Rollback;
                      break;
                    end;  
                  end
                  else begin
                    ProcessRequest(RequestNode, ResultNode, DbConn, StopOnError);
                  end;
                end;

              end;
            finally
              if DbConn.InTransaction then
                DbConn.Commit;
            end;
          end;

      end;
    finally
      DbConn.Free;
    end;
  end
  else begin
    AddResult(outRoot,'Ok','','','','','No commands where found to process.');
  end;
end;


function TAppXMLCmndProc.ProcessRequest(RequestNode,
  ResultNode: TALXMLNode; Conn: TMyConnection; StopOnError: boolean): boolean;
var
  s: string;
  BusObj: TBusObj;
  DataObject: string;
  Command: string;
  SelectStr: string;
  StructNode: TALXMLNode;
  NewResultNode: TALXMLNode;
  SubNode, FilterNode: TALXMLNode;
  SubNodeIdx: integer;

  function GetBusObjInst: TBusObj;
  begin
    result:= nil;
    if RequestNode.HasAttribute('DataObject') then begin
      DataObject:= RequestNode.Attributes['DataObject'];
      result := TBusObj(GetComponentByClassName(DataObject, false , nil , False , False));
      if not Assigned(result) then
        raise Exception.Create('Not a valid ERP registered business object: "' + DataObject + '"');
    end;
  end;

begin
  result:= true;
  try
    if RequestNode.HasAttribute('Command') then
      Command:= RequestNode.Attributes['Command']
    else begin
      result:= false;
      ResultNode.Attributes['Result']:= 'Error';
      ResultNode.AddChild('Desc').Text:= 'Request does not have a command.';
      exit;
    end;

    if Command = XMLCommandSetFieldList then begin
      for SubNodeIdx:= 0 to RequestNode.ChildNodes.Count -1 do begin
        SubNode:= RequestNode.ChildNodes[SubNodeIdx];
        if (SubNode.NodeType <> ntComment) and (SubNode.NodeName = 'FieldList') then begin
          if not SubNode.HasAttribute('DataObject') then begin
            result:= false;
            ResultNode.Attributes['Result']:= 'Error';
            ResultNode.AddChild('Desc').Text:= 'DataObject missing from FieldList line.';
            exit;
          end;
          if not SubNode.HasAttribute('Option') then begin
            result:= false;
            ResultNode.Attributes['Result']:= 'Error';
            ResultNode.AddChild('Desc').Text:= 'Option missing from FieldList line.';
            exit;
          end;
          if SubNode.Attributes['Option'] = 'Add' then begin
            AppEnv.BusObjFieldList.LoadObjectDefaults(SubNode.Attributes['DataObject']);
            AppEnv.BusObjFieldList.AddObjectFields(SubNode.Attributes['DataObject'], SubNode.Text);
          end
          else if SubNode.Attributes['Option'] = 'Replace' then begin
            AppEnv.BusObjFieldList.ClearObjectFields(SubNode.Attributes['DataObject']);
            AppEnv.BusObjFieldList.AddObjectFields(SubNode.Attributes['DataObject'], SubNode.Text);
          end
          else begin
            result:= false;
            ResultNode.Attributes['Result']:= 'Error';
            ResultNode.AddChild('Desc').Text:= 'Invalid Option "' +
              SubNode.Attributes['Option'] + '" on FieldList line.';
            exit;
          end;
        end;
      end;
      ResultNode.Attributes['Result']:= 'Ok';

    end
    else if Command = XMLCommandExport then begin
      BusObj:= GetBusObjInst;
      try
        BusObj.Connection := TMydacDataConnection.Create(TBusObj(BusObj));
        BusObj.Connection.MyDacConnection:= Conn;

        BusObj.LimitXMLFieldsOnSave:= true;  // Default

        SubNode:= RequestNode.ChildNodes.FindNode('LimitFieldList');
        if Assigned(SubNode) then begin
          BusObj.LimitXMLFieldsOnSave:= not (LowerCase(SubNode.Text) = 'false');
        end;

        SelectStr:= '';
        {  check to see if user is requesting a specific GlobalRef }
        if RequestNode.HasAttribute('GlobalRef') then begin
          SelectStr:= 'GlobalRef = "' + RequestNode.Attributes['GlobalRef'] + '"';
          BusObj.LoadSelect(SelectStr);
        end
        else if RequestNode.HasAttribute('RecId') then begin
          BusObj.Load(RequestNode.Attributes['RecId']);
        end
        else begin
          { do we include "Inactive" records }
          SubNode:= RequestNode.ChildNodes.FindNode('ExcludeInactive');
          if Assigned(SubNode) then
            BusObj.ExcludeInactive:= (LowerCase(SubNode.Text) = 'true')
          else
            BusObj.ExcludeInactive:= false;

          { do we have a limit info }
          SubNode:= RequestNode.ChildNodes.FindNode('LimitFrom');
          if Assigned(SubNode) then
            BusObj.LimitFrom:= SubNode.NodeValue;
          SubNode:= RequestNode.ChildNodes.FindNode('LimitCount');
          if Assigned(SubNode) then
            BusObj.LimitCount:= SubNode.NodeValue;


          { do we have a load select ... }
          SubNode:= RequestNode.ChildNodes.FindNode('Select');
          { do we have a filter ... }
          FilterNode:= RequestNode.ChildNodes.FindNode('Filter');
          if Assigned(SubNode) then
            BusObj.LoadSelect(SubNode.Text)
          else if Assigned(FilterNode) then
            BusObj.FilterSelect(FilterNode)
          else
            { load all }
            BusObj.Load;
        end;

        { check it loaded without error }
        if not BusObj.ResultStatus.OperationOk then begin
          result:= false;
          ResultNode.Attributes['Result']:= 'Error';
          ResultNode.AddChild('Desc').Text:= BusObj.ResultStatus.Messages;
          exit;
        end;
        if BusObj.Count > 0 then begin
          { add each instance to output xml }
          while not BusObj.EOF do begin
            if BusObj.BOF then
              NewResultNode:= ResultNode
            else begin
              NewResultNode:= CopyNode(ResultNode, ResultNode.ParentNode);//ResultNode.CloneNode(false);
//              ResultNode.ParentNode.ChildNodes.Add(NewResultNode);
            end;

            BusObj.SaveToXMLNode(NewResultNode.AddChild(BusObj.XMLNodeName));
            NewResultNode.Attributes['Result']:= 'Ok';
            if BusObj is TMSBusObj then begin
              NewResultNode.Attributes['GlobalRef']:= TMSBusObj(BusObj).GlobalRef;
              NewResultNode.Attributes['ID']:= IntToStr(TMSBusObj(BusObj).Id);
            end;

            BusObj.Next;
          end;
        end
        else begin
          ResultNode.Attributes['Result']:= 'NoRecords';
          ResultNode.AddChild('Desc').Text:= 'No match found.';
        end;

      finally
        BusObj.Free;
      end;
    end
    else begin
      { Add, Update, Edit, Delete, Restore  }

      if (Command <> XMLCommandModify) and (Command <> XMLCommandNew) then begin
        result:= false;
        ResultNode.Attributes['Result']:= 'Error';
        ResultNode.AddChild('Desc').Text:= 'Unsupported object request: "' + Command + '"';
        exit;
      end;
      BusObj:= GetBusObjInst;
      try
        BusObj.Connection := TMydacDataConnection.Create(TBusObj(BusObj));
        BusObj.Connection.MyDacConnection:= Conn;

        BusObj.Connection.BeginNestedTransaction;
        try
          StructNode:= RequestNode.ChildNodes.FindNode(BusObj.XMLNodeName);
          if not Assigned(StructNode) then begin
            result:= false;
            ResultNode.Attributes['Result']:= 'Error';
            ResultNode.AddChild('Desc').Text:= 'Missing data structure for ' + BusObj.XMLNodeName + ' object.';
            BusObj.Connection.RollbackNestedTransaction;
            exit;
          end;

          BusObj.SilentMode:= true;
          BusObj.ResultStatus.Clear;

          if (Command = XMLCommandNew) then begin
            { adding a new record }
            BusObj.New;
            { check ststus in case user does not have create rights etc }
            if not BusObj.ResultStatus.OperationOk then begin
              result:= false;
              ResultNode.Attributes['Result']:= 'Error';
              ResultNode.AddChild('Desc').Text:= BusObj.ResultStatus.Messages;
              BusObj.Connection.RollbackNestedTransaction;
              exit;
            end;
          end
          else if  (Command = XMLCommandModify) then begin
            { updating an existion record }
            if RequestNode.HasAttribute('GlobalRef') then begin
              SelectStr:= 'GlobalRef = "' + RequestNode.Attributes['GlobalRef'] + '"';
              BusObj.LoadSelect(SelectStr);
            end
            else if RequestNode.HasAttribute('RecId') then begin
              BusObj.Load(RequestNode.Attributes['RecId']);
            end
            else begin
              result:= false;
              ResultNode.Attributes['Result']:= 'Error';
              ResultNode.AddChild('Desc').Text:= 'Missing Object GlobalRef from request.';
              BusObj.Connection.RollbackNestedTransaction;
              exit;
            end;

            if BusObj.Count = 0 then begin {nothing found}
              result:= false;
              ResultNode.Attributes['Result']:= 'Error';
              ResultNode.AddChild('Desc').Text:= 'No Object found for GlobalRef.';
              BusObj.Connection.RollbackNestedTransaction;
              exit;
            end;
            BusObj.Edit;
            { check ststus in case user does not have edit rights etc }
            if not BusObj.ResultStatus.OperationOk then begin
              result:= false;
              ResultNode.Attributes['Result']:= 'Error';
              ResultNode.AddChild('Desc').Text:= BusObj.ResultStatus.Messages;
              BusObj.Connection.RollbackNestedTransaction;
              exit;
            end;
          end;

          If not BusObj.Lock then begin
            result:= false;
            ResultNode.Attributes['Result']:= 'Error';
            ResultNode.AddChild('Desc').Text:=
              'Unable to update ' + BusObj.BusObjectTypeDescription +
              ' as record is being updated by "' + BusObj.UserLock.LockInfo.UserName + '"';
            BusObj.Connection.RollbackNestedTransaction;
            exit;
          end;

          BusObj.LoadFromXMLNode(StructNode);
          { check for errors that may have occured during population of object properties }
          if not BusObj.ResultStatus.OperationOk then begin
            result:= false;
            ResultNode.Attributes['Result']:= 'Error';
            ResultNode.AddChild('Desc').Text:= BusObj.ResultStatus.Messages;
            BusObj.Connection.RollbackNestedTransaction;
            exit;
          end;
          BusObj.Save;

          { check for errors that where when object called validate during save process }
          if not BusObj.ResultStatus.OperationOk then begin
            result:= false;
            ResultNode.Attributes['Result']:= 'Error';
            ResultNode.AddChild('Desc').Text:= BusObj.ResultStatus.Messages;
            BusObj.Connection.RollbackNestedTransaction;
            exit;
          end;

          ResultNode.Attributes['Result']:= 'Ok';
          BusObj.Connection.CommitNestedTransaction;
        except
          BusObj.Connection.RollbackNestedTransaction;
          raise;
        end;

        if BusObj is TMSBusObj then begin
          ResultNode.Attributes['GlobalRef']:= TMSBusObj(BusObj).GlobalRef;
          ResultNode.Attributes['RecId']:= IntToStr(TMSBusObj(BusObj).Id);
        end;
      finally
        BusObj.Free;
      end;
    end;




  except
    on E: Exception do begin
      ResultNode.Attributes['Result']:= 'Error';
      s:= E.Message;
      if StopOnError then begin
        s:= s + ' Changes rolled back.';
        Conn.Rollback;
      end;
      ResultNode.AddChild('Desc').Text:= s;
      result:= false;
    end;
  end;
end;


end.
