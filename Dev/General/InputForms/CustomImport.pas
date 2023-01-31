unit CustomImport;
{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 25/10/05  1.00.00 AL   Initial version.
                        GetImportCSVFileXML - importing comma delimited files only,
                        returns Request XML
                        Execute - does the import and returns Response XML if all is OK,
                        and empty string if failed.
                        XMLDefinition - property holds text of XML definition file
 26/10/05  1.00.01 AL   Added Total and Successful properties
                        Total - records processsed
                        Successful - records without errors
 31/10/05  1.00.02 AL   Rewrited GetImportCSVFileXML and Execute functions.
                        Now they use TXMLDocument for work with XML structure
 01/11/05  1.00.03 AL   Added possibility to GetImportCSVFileXML to work with CSV
                        files with Headers
 23/03/06  1.00.04 DSP  Added ImportFromXML function which allows direct
                        importing of data from an XML document without use of
                        a CSV file.
 10/08/06  1.00.05 BJ   name of the objectname attribute is changed from 'TargetObject' to 'DataObject'
 }

interface

uses Sysutils, Classes, Dialogs, ProgressDialog, Controls, XMLDoc, XMLIntf,
  MyAccess,ERPdbComponents;

type
  TCustomImport = class(TObject)
  private
    fXMLDefinition: string;
    fXMLData: string;
    fSuccessful, fTotal: integer;
    fsImportMsg :String;
    fbSilentMode :Boolean;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    function Execute(var responseXML: String): boolean;//returns the Response XML
    function ImportFromXML(var responseXML: String): boolean;
    Function ImportFromXMLFile(FileName :String; MyConnection :TERPConnection= nil):boolean;
    function GetImportCSVFileXML: String;
    Property ImportMsg      : String    Read    fsImportMsg;
    Property SilentMode     : Boolean   Write   fbSilentMode;
    property Successful     : Integer   Read    fSuccessful     Write fSuccessful;
    property Total          : Integer   Read    fTotal          Write fTotal;
    property XMLDefinition  : string    Read    fXMLDefinition  Write fXMLDefinition;
    property XMLData        : string    Read    fXMLData        Write fXMLData;
  end;

implementation

uses
  Forms, BusObjTimeSheet, BusObjBase, CommonDbLib ,BusObjConst,
  CommonLib, tcDataUtils, FastFuncs;

type
  TActionType = (atAdd, atChange);

{ TCustomImport }

constructor TCustomImport.Create;
begin
  Inherited;
  fSuccessful := 0;
  fTotal := 0;
  fbSilentMode := False;
  fsImportMsg := '';
end;

destructor TCustomImport.Destroy;
begin
  inherited;
end;

{============================= EXECUTE ========================================}

function TCustomImport.Execute(var responseXML: String): boolean;//True if all records posted
var
  TS: TTimeSheet;
  StopOnError: boolean;//StopOnError = true, ContinueOnError = false
  Messages: TStringList;
  i, RecCount: integer;
  TempXML: String;
  ProgressDialog: TProgressDialog;
  DefXMLDoc, ReqXMLDoc, ResXMLDoc, TempXMLDoc: IXMLDocument;
  dNode: IXMLNode;
  RS: TResultStatus;
  RequestID: integer;
  ImportCSV_XML: string;
  MyDacDataConnection :TMyDacDataConnection;
  DBConnection : TERPConnection;
begin
  Result := true;
  DefXMLdoc := TXMLDocument.Create(nil);
  RS := TResultStatus.Create(TResultStatusItem);
  Messages := TStringList.Create;
  ReqXMLdoc := TXMLDocument.Create(nil);
  ResXMLdoc := TXMLDocument.Create(nil);
  TempXMLdoc := TXMLDocument.Create(nil);
  TS := TTimeSheet.Create(nil);
  MyDacDataConnection := TMyDacDataConnection.Create(TS);
  DBConnection := CommonDbLib.GetNewMyDacConnection(TS);
  ProgressDialog := TProgressDialog.Create(Application.MainForm);
  try
    RequestID := 0;
    StopOnError := true;
    RS.Clear;
    DefXMLdoc.Options := [doNodeAutoIndent];
    DefXMLdoc.LoadFromXML(XMLDefinition);
    dNode := DefXMLdoc.DocumentElement.ChildNodes.FindNode('Options').ChildNodes.FindNode('OnError');
    if dNode.IsTextElement then begin
      StopOnError := (dNode.Text = 'StopOnError');
    end else begin
      //What code???
      RS.AddItem(true, rssWarning, 0, 'OnError section not found or does not contain text. Using StopOnError by default!');//OnError option does not exist, use StopOnError by default
    end;
    Total := 0;
    Successful := 0;
    Processingcursor(True);
    ProgressDialog.Caption  := 'Please Wait .......';
    ProgressDialog.MinValue := 0;
    ProgressDialog.Step     := 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    if DefXMLdoc.DocumentElement.ChildNodes.FindNode('Source').ChildNodes.FindNode('SourceType').Text = 'CSV_File' then begin
      if DefXMLdoc.DocumentElement.ChildNodes.FindNode('Destination').ChildNodes.FindNode('BusinessObject').Text = 'TTimeSheet' then begin//CreateTimeSheetObject
        TS.Name := 'TimeSheetObj';
        TS.SilentMode := true;
        TS.Connection := MyDacDataConnection;
        TMyDacDataConnection(TS.Connection).MyDacConnection := DBConnection;
        TMyDacDataConnection(TS.Connection).MyDacConnection.StartTransaction;
        ReqXMLdoc.Options := [doNodeAutoIndent];
        ImportCSV_XML := GetImportCSVFileXML;
        if ImportCSV_XML = '' then begin
          TMyDacDataConnection(TS.Connection).MyDacConnection.Rollback;
          ResXMLdoc.Options := [doNodeAutoIndent];
          ResXMLdoc.Active := true;
          ResXMLdoc.Version := XMLDocVersion;
          ResXMLdoc.Encoding := XMLDocEncoding;
          ResXMLdoc.AddChild(XMLDocRoot);
          ResXMLdoc.DocumentElement.AddChild('ERPXMLResponse');
          ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').Attributes['RequestID'] := RequestID;
          ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').Attributes['RequestType'] := 'Add';
          ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').Attributes['StatusCode'] := 360;
          ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').Attributes['StatusSeverity'] := 'Error';
          ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').AddChild('DetailMessage');
          ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').ChildNodes.FindNode('DetailMessage').NodeValue := 'CSV File corrupt';
          ResXMLdoc.SaveToXML(responseXML);
          Result := false;
          Exit;
        end;
        ReqXMLDoc.LoadFromXML(ImportCSV_XML);
        RequestID := FastFuncs.StrToInt(ReqXMLdoc.DocumentElement.ChildNodes.FindNode(XMLDocRequest).Attributes['RequestID']);
        RecCount := ReqXMLdoc.DocumentElement.ChildNodes.FindNode(XMLDocRequest).ChildNodes.Count;
        ProgressDialog.MaxValue := RecCount;
        ProgressDialog.Execute;
        TempXMLdoc.Options := [doNodeAutoIndent];
        TempXMLdoc.Active := true;
        for i := 0 to RecCount - 1 do begin
          Total := Total + 1;
          if ReqXMLdoc.DocumentElement.ChildNodes.FindNode(XMLDocRequest).Attributes['Type'] = 'Add' then begin
            TempXMLDoc.DocumentElement := ReqXMLdoc.DocumentElement.ChildNodes.First.ChildNodes.Nodes[i];
            TS.ResultStatus.Clear;
            TS.New;
            TempXMLDoc.SaveToXML(tempXML);
            TS.XML := TempXML;
            if TS.ValidateData then begin
              TS.Save;
              successful := successful + 1;
              RS.AddItem(true, rssInfo, 300, ' Line ' + IntToStr(i + 1) + ': - OK! (' + TS.EmployeeName + ')', false);//Messages.Add('Line ' + IntToStr(i+1) + ': - OK!');
            end else begin
              Result := false;
              RS.AddItem(false, rssWarning, 360, 'Line ' + IntToStr(i + 1) + ': - Error! (' + TS.EmployeeName + ')' + #13#10 + '     ' + TS.ResultStatus.Messages, false);
              TS.fbCustomImportDelete := true;
              TS.Delete;
              TS.fbCustomImportDelete := false;
              if StopOnError then begin
                ProgressDialog.CloseDialog;
                Break;
              end;
            end;
          end;
          ProgressDialog.StepIt;
        end;
        // DEFINITION xml document create
        ResXMLdoc.Options := [doNodeAutoIndent];
        ResXMLdoc.Active := true;
        ResXMLdoc.Version := XMLDocVersion;
        ResXMLdoc.Encoding := XMLDocEncoding;
        ResXMLdoc.AddChild(XMLDocRoot);
        ResXMLdoc.DocumentElement.AddChild('ERPXMLResponse');
        ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').Attributes['RequestID'] := RequestID;
        ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').Attributes['RequestType'] := 'Add';
        if Total = Successful then begin
          ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').Attributes['StatusCode'] := '0';
          ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').Attributes['StatusSeverity'] := 'Info';
          ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').Attributes['StatusMessage'] := IntToStr(Total) + ' Records added!';
          ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').AddChild('DetailMessage');
          ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').ChildNodes.FindNode('DetailMessage').NodeValue := RS.Messages;
          TMyDacDataConnection(TS.Connection).MyDacConnection.Commit;
        end else begin
          ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').Attributes['StatusCode'] := RS.GetFirstFatalStatusItem.Code;
          ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').Attributes['StatusSeverity'] := 'Error';//ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLRequest').Attributes['DetailMessage'] := RS.Messages;
          if StopOnError then begin
            TMyDacDataConnection(TS.Connection).MyDacConnection.Rollback;
            ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').AddChild('DetailMessage');
            ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').ChildNodes.FindNode('DetailMessage').NodeValue := RS.Messages;
            ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').Attributes['StatusMessage'] := IntToStr(Total) + ' Records processed, 0 added, ' + IntToStr(Total - successful) + ' error record(s)!' + #13#10;
          end
          else begin
            TMyDacDataConnection(TS.Connection).MyDacConnection.Commit;
            ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').AddChild('DetailMessage');
            ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').ChildNodes.FindNode('DetailMessage').NodeValue := RS.Messages;
            ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').Attributes['StatusMessage'] := IntToStr(Total) + ' Records processed, ' + IntToStr(successful) + '  added, ' + IntToStr(Total - successful) + ' rejected!' + #13#10;
          end;
        end;
        ResXMLdoc.SaveToXML(responseXML);
      end else begin
        Result := false;
      end;
    end;
  finally
    Processingcursor(False);
    FreeAndNil(RS);
    FreeAndNil(Messages);
    FreeAndNil(MyDacDataConnection);
    FreeAndNil(DBConnection);
    FreeAndNil(TS);
    FreeAndNil(ProgressDialog);
//    DefXMLdoc.Free;
//    ReqXMLdoc.Free;
//    ResXMLdoc.Free;
//    TempXMLdoc.Free;
  end;
end;

function TCustomImport.ImportFromXML(var responseXML: String): boolean;
var
  BusObj: TBusObj;
  BusClass: TPersistentClass;
  cNode: IXMLNode;
  ActionType: TActionType;
  TargetObject: string;
  StopOnError: boolean;
  Messages: TStringList;
  Index, RecCount: integer;
  TempXML: String;
  ProgressDialog: TProgressDialog;
  ReqXMLDoc, ResXMLDoc, TempXMLDoc: TXMLDocument;
  ResultStatus: TResultStatus;
  RequestID: integer;
  MyDacDataConnection :TMyDacDataConnection;
  DBConnection : TERPConnection;
begin
  Result := true;
  BusObj := nil;
  DBConnection := nil;
  MyDacDataConnection := nil;
  ResultStatus := TResultStatus.Create(TResultStatusItem);
  Messages := TStringList.Create;
  ReqXMLdoc := TXMLDocument.Create(nil);
  ResXMLdoc := TXMLDocument.Create(nil);
  TempXMLdoc := TXMLDocument.Create(nil);
  ProgressDialog := TProgressDialog.Create(Application.MainForm);

  try
    RequestID := 0;
    Total := 0;
    Successful := 0;
    ResultStatus.Clear;
    ProgressDialog.Caption := 'Please Wait .......';
    ProgressDialog.MinValue := 0;
    ProgressDialog.Step := 1;
    ProgressDialog.Value := ProgressDialog.MinValue;

    if XMLData <> '' then
    begin
      ReqXMLDoc.LoadFromXML(XMLData);

      // Get node attributes
      with ReqXMLDoc.DocumentElement do begin
        cNode := ChildNodes.FindNode(XMLDocRequest);
        StopOnError := (cNode.Attributes['OnError'] = 'Stop');

        if cNode.Attributes['Type'] = 'Add' then
          ActionType := atAdd
        else
          ActionType := atChange;

        TargetObject := cNode.Attributes['DataObject'];
        RequestID := StrToIntDef(cNode.Attributes['RequestID'], 0);
      end;

      if TargetObject <> '' then begin
        BusClass := FindClass(TargetObject);

        if Assigned(BusClass) then begin
          BusObj := TBusObj(TComponentClass(BusClass).Create(Application));
        end;
      end;

      if Assigned(BusObj) then begin
        BusObj.Name := 'BusObj';
        BusObj.SilentMode := true;
        MyDacDataConnection := TMyDacDataConnection.Create(BusObj);
        DBConnection := CommonDbLib.GetNewMyDacConnection(BusObj);
        BusObj.Connection := MyDacDataConnection;
        TMyDacDataConnection(BusObj.Connection).MyDacConnection := DBConnection;
        TMyDacDataConnection(BusObj.Connection).MyDacConnection.StartTransaction;

        RecCount := ReqXMLdoc.DocumentElement.ChildNodes.FindNode(XMLDocRequest).ChildNodes.Count;
        ProgressDialog.MaxValue := RecCount;
        ProgressDialog.Execute;
        TempXMLdoc.Options := [doNodeAutoIndent];
        TempXMLdoc.Active := true;
        Application.ProcessMessages;

        for Index := 0 to RecCount - 1 do begin
          Total := Total + 1;

          if ActionType = atAdd then begin
            TempXMLDoc.DocumentElement := ReqXMLdoc.DocumentElement.ChildNodes.First.ChildNodes.Nodes[Index];
            BusObj.ResultStatus.Clear;
            BusObj.New;
            TempXMLDoc.SaveToXML(TempXML);
            BusObj.XML := TempXML;

            if BusObj.ValidateData then begin
              BusObj.Save;
              Successful := Successful + 1;
              ResultStatus.AddItem(true, rssInfo, 300, ' Line ' + IntToStr(Index + 1) + ': - OK' , false);
            end else begin
              Result := false;
              ResultStatus.AddItem(false, rssWarning, 360, 'Line ' + IntToStr(Index + 1) + ': - Error' + #13#10 + '     ' + BusObj.ResultStatus.Messages, false);

              if BusObj is TTimeSheet then
              begin
                TTimeSheet(BusObj).fbCustomImportDelete := true;
                TTimeSheet(BusObj).Delete;
                TTimeSheet(BusObj).fbCustomImportDelete := false;
              end;

              if StopOnError then begin
                ProgressDialog.CloseDialog;
                Break;
              end;
            end;
          end;

          ProgressDialog.StepIt;
        end;

        ResXMLdoc.Options := [doNodeAutoIndent];
        ResXMLdoc.Active := true;
        ResXMLdoc.Version := XMLDocVersion;
        ResXMLdoc.Encoding := XMLDocEncoding;
        ResXMLdoc.AddChild(XMLDocRoot);
        ResXMLdoc.DocumentElement.AddChild('ERPXMLResponse');
        ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').Attributes['RequestID'] := RequestID;
        ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').Attributes['RequestType'] := 'Add';

        if Total = Successful then begin
          ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').Attributes['StatusCode'] := '0';
          ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').Attributes['StatusSeverity'] := 'Info';
          ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').Attributes['StatusMessage'] := IntToStr(Total) + ' Records added!';
          ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').AddChild('DetailMessage');
          ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').ChildNodes.FindNode('DetailMessage').NodeValue := ResultStatus.Messages;
          TMyDacDataConnection(BusObj.Connection).MyDacConnection.Commit;
        end else begin
          ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').Attributes['StatusCode'] := ResultStatus.GetFirstFatalStatusItem.Code;
          ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').Attributes['StatusSeverity'] := 'Error';//ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLRequest').Attributes['DetailMessage'] := ResultStatus.Messages;

          if StopOnError then begin
            TMyDacDataConnection(BusObj.Connection).MyDacConnection.Rollback;
            ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').AddChild('DetailMessage');
            ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').ChildNodes.FindNode('DetailMessage').NodeValue := ResultStatus.Messages;
            ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').Attributes['StatusMessage'] := IntToStr(Total) + ' Records processed, 0 added, ' + IntToStr(Total - successful) + ' error record(s)!' + #13#10;
          end
          else begin
            TMyDacDataConnection(BusObj.Connection).MyDacConnection.Commit;
            ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').AddChild('DetailMessage');
            ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').ChildNodes.FindNode('DetailMessage').NodeValue := ResultStatus.Messages;
            ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').Attributes['StatusMessage'] := IntToStr(Total) + ' Records processed, ' + IntToStr(successful) + '  added, ' + IntToStr(Total - successful) + ' rejected!' + #13#10;
          end;
        end;

        ResXMLdoc.SaveToXML(responseXML);
      end else begin
        Result := false;
      end;
    end
    else begin
      ResXMLdoc.Options := [doNodeAutoIndent];
      ResXMLdoc.Active := true;
      ResXMLdoc.Version := XMLDocVersion;
      ResXMLdoc.Encoding := XMLDocEncoding;
      ResXMLdoc.AddChild(XMLDocRoot);
      ResXMLdoc.DocumentElement.AddChild('ERPXMLResponse');
      ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').Attributes['RequestID'] := RequestID;
      ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').Attributes['RequestType'] := 'Add';
      ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').Attributes['StatusCode'] := 360;
      ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').Attributes['StatusSeverity'] := 'Error';
      ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').AddChild('DetailMessage');
      ResXMLdoc.DocumentElement.ChildNodes.FindNode('ERPXMLResponse').ChildNodes.FindNode('DetailMessage').NodeValue := 'CSV File corrupt';
      ResXMLdoc.SaveToXML(responseXML);
      Result := false;
    end;
  finally
    FreeandNil(ResultStatus);
    FreeandNil(Messages);
    FreeandNil(MyDacDataConnection);
    FreeandNil(DBConnection);
    FreeandNil(BusObj);
    FreeandNil(ProgressDialog);
  end;
end;

{===================== GET IMPORT CSV FILE XML ================================}

function TCustomImport.GetImportCSVFileXML: String;
var
  k, i: integer;// loop counters
  PropertyName, BusinessObject, OnError: string;
  FirstLineIsHeader: boolean;
  FirstDataLine: integer;
  slInputFile, slFieldsValues, slFieldsNames, slFieldsDataTypes: TStringList;
  od: TOpenDialog;
  ReqXMLdoc, DefXMLdoc: TXMLDocument;
  NewNode, TempNode, Node: IXMLNode;//for REQUEST
  dNode: IXMLNode;//for DEFINITION

begin
  Result := '';
  od := TOpenDialog.Create(nil);
  slFieldsValues := TStringList.Create;
  slInputFile := TStringList.Create;
  slFieldsNames := TStringList.Create;
  slFieldsDataTypes := TStringList.Create;
  DefXMLdoc := TXMLDocument.Create(nil);
  ReqXMLdoc := TXMLDocument.Create(nil);
  try//ASK USER TO PICK THE CSV FILE
    od.Filter      := 'CSV files|*.csv';
    od.FilterIndex := 0;
    if od.Execute then begin
      If FileExists(od.FileName) then
        slInputFile.LoadFromFile(od.FileName)
      else
        Exit;
    end else begin
      Exit;
    end;
    slFieldsValues.Clear;// DEFINITION xml document create
    DefXMLdoc.Options := [doNodeAutoIndent];
    DefXMLdoc.LoadFromXML(XMLDefinition);
    BusinessObject := DefXMLdoc.DocumentElement.ChildNodes.FindNode('Destination').ChildNodes.FindNode('BusinessObject').Text;
    BusinessObject := Copy(BusinessObject, 2, char_length(BusinessObject));
    OnError := DefXMLdoc.DocumentElement.ChildNodes.FindNode('Options').ChildNodes.FindNode('OnError').Text;
    FirstLineIsHeader := (DefXMLdoc.DocumentElement.ChildNodes.FindNode('Source').ChildNodes.FindNode('HasHeader').Text = 'Yes');//xmldoc.DOMVendor := DOMVendors.Find('MSXML');
    ReqXMLdoc.Options := [doNodeAutoIndent];
    ReqXMLdoc.Active := true;
    ReqXMLdoc.Version := XMLDocVersion;
    ReqXMLdoc.Encoding := XMLDocEncoding;
    node    := ReqXMLdoc.AddChild(XMLDocRoot);
    NewNode := node.AddChild(XMLDocRequest);
    NewNode.Attributes['onError'] := OnError;
    NewNode.Attributes['Type'] := 'Add';
    NewNode.Attributes['DataObject'] := BusinessObject;
    NewNode.Attributes['RequestID'] := 1;
    node    := NewNode;//GET FIELDS NAMES AND DATA TYPES
    slFieldsNames.Clear;
    slFieldsDataTypes.Clear;
    dNode := DefXMLdoc.DocumentElement.ChildNodes.FindNode('Source').ChildNodes.FindNode('Maping').ChildNodes.FindNode('InputFields');
    for i := 0 to dNode.ChildNodes.Count - 1 do begin
      slFieldsNames.Add(dNode.ChildNodes[i].ChildNodes.FindNode('Name').NodeValue);
      slFieldsDataTypes.Add(dNode.ChildNodes[i].ChildNodes.FindNode('Type').NodeValue);
    end;{for} if FirstLineIsHeader then begin// if CSV file has Header Line
      FirstDataLine := 1;
      slFieldsNames.Clear;
      slFieldsNames.CommaText := slInputFile.Strings[0];// Fist line is header, containing field names
    end {if}
    else begin
      FirstDataLine := 0;
    end;{else} for k := FirstDataLine to slInputFile.Count - 1 do begin
      slFieldsValues.Clear;
      slFieldsValues.CommaText := slInputFile.Strings[k];
      NewNode := node.AddChild(BusinessObject);
      dNode := DefXMLdoc.DocumentElement.ChildNodes.FindNode('Source').ChildNodes.FindNode('Maping').ChildNodes.FindNode('MAP');
      for i := 0 to dNode.ChildNodes.Count - 1 do begin
        PropertyName := dNode.ChildNodes[i].ChildNodes.FindNode('outField').NodeValue;//Data type can be used for Values checking in future, coment by now
        TempNode := NewNode.AddChild(PropertyName);
        if slFieldsValues.Count <> slFieldsNames.Count then begin
          Result := '';
          Exit;
        end;
        TempNode.NodeValue := slFieldsValues.Strings[slFieldsNames.IndexOf(dNode.ChildNodes[i].ChildNodes.FindNode('inField').NodeValue)];
      end;{for int}
    end;{for ext} ReqXMLdoc.SaveToXML(Result);
  finally
    FreeAndNil(od);
    FreeAndNil(slFieldsValues);
    FreeAndNil(slInputFile);
    FreeAndNil(slFieldsNames);
    FreeAndNil(slFieldsDataTypes);
    DefXMLdoc.Free;
    ReqXMLdoc.Free;
  end;
end;

Function TCustomImport.ImportFromXMLFile(FileName :String; MyConnection :TERPConnection= nil ):boolean;
var
    ImportDoc       : TXMLDocument;
    node            : IXMLNode;
    strClassName    : String;
    Obj             : Tcomponent;
    fsXMLOnError    : String;
    xRequest        : Integer;
    Classnodes      : IXMLNode;
    resultnode      : IXMLNode;
    fsDataversion   : String;
    bConnectionAssigned: boolean;


    Function FileValid :Boolean;
    begin
        Result := False;
        FileName := Trim(FileName);
        if FileName = '' then  begin
            resultnode.Attributes['Error'] := 'Please select the file to import';
            Exit;
        end;

        if FastFuncs.PosEx('.' , FileName ) = 0 then begin
            resultnode.Attributes['FileName'] := FileName;
            AddXMLNode(resultnode ,'Status' ,'Import Failed');
            resultnode := resultnode.Addchild('Error');
            AddXMLNode(resultnode ,'Description' ,'This module allows the import from XML file only');
            Exit;
        end;

        if uppercase(copy(FileName , FastFuncs.PosEx('.' , FileName) , char_length(FileName))) <> '.XML' then begin
            resultnode.Attributes['FileName'] := FileName;
            AddXMLNode(resultnode ,'Status' ,'Import Failed');
            resultnode := resultnode.Addchild('Error');
            AddXMLNode(resultnode ,'Description' , 'This module allows the import from XML file only');
            Exit;
        end;
        Result := True;
    end;
    Function ValidClassNode:Boolean;
    begin
        Result := False;
        if assigned(Classnodes) then begin

            Try
                strClassName := Classnodes.Attributes['DataObject'];
            Except
                on E: Exception do begin
                    {exception occurs when then attribute is not provided}
                    resultnode := NewResultNode('InvalidObjects');
                    ResultNode := ResultNode.Addchild('Object');
                    AddXMLNode(ResultNode ,'ObjectName' ,strClassName);
                    AddXMLNode(ResultNode ,'Status' ,'Import Failed');
                    ResultNode := ResultNode.Addchild('Error');
                    AddXMLNode(ResultNode ,'Description' ,'Object name not provided');
                    Exit;
                end;
            End;

            Try
                fsXMLOnError := Classnodes.Attributes['OnError'];
            Except
                {exception occurs when the attribute is not provided
                so kill the exception, onerror gets the default value}
                fsXMLOnError :=XMLDocRequestStopError;
            End;
        end;

        if strClassName = '' then begin
            resultnode := NewResultNode('InvalidObjects');
            ResultNode := ResultNode.Addchild('Object');
            AddXMLNode(ResultNode ,'ObjectName' ,strClassName);
            AddXMLNode(ResultNode ,'Status' ,'Import Failed');
            ResultNode := ResultNode.Addchild('Error');
            AddXMLNode(ResultNode ,'Description' ,'Object name not provided');
            Exit;
        end;
        Result := True;
    end;

    Function ValidClass :Boolean;
    begin
        Result := False;
        if not Assigned(Obj) then begin
            resultnode := NewResultNode('InvalidObjects');
            ResultNode := ResultNode.Addchild('Object');
            AddXMLNode(ResultNode ,'ObjectName' ,strClassName);
            AddXMLNode(ResultNode ,'Status' ,'Import Failed');
            ResultNode := ResultNode.Addchild('Error');
            AddXMLNode(ResultNode ,'Description' ,'Object not found in ERP');
            Exit;
        end;
        if not (obj is TBusObj) then begin
            resultnode := NewResultNode('InvalidObjects');
            ResultNode := ResultNode.Addchild('Object');
            AddXMLNode(ResultNode ,'ObjectName' ,strClassName);
            AddXMLNode(ResultNode ,'Status' ,'Import Failed');
            ResultNode := ResultNode.Addchild('Error');
            AddXMLNode(ResultNode ,'Description' ,'Not a valid ERP registered business object');
            Exit;
        end;
        Result := true;
    End;
    Procedure ImportClassRecords;
    var
      xClassNodes     : Integer;
      Classnode       : IXMLNode;
    begin
        TBusObj(obj).Connection := TMydacDataConnection.Create(TBusObj(obj));
        TMydacDataConnection(TBusObj(obj).Connection).MyDacConnection := MyConnection;
        TBusObj(Obj).XMLOnError := fsXMLOnError;
        for xClassNodes:= 0 to Classnodes.ChildNodes.Count -1 do begin
            Classnode := Classnodes.ChildNodes[xClassNodes];
            TBusObj(obj).Connection.BeginTransaction;
            Try
                Try
                    TBusObj(Obj).ResultStatus.Clear;
                    TBusObj(Obj).ImportingFromXMLFile := True;
                    TBusObj(Obj).REsultNode := ResultNode.AddChild('Record');
                    TBusObj(Obj).SilentMode := true;
                    TBusObj(Obj).ImportFromXML(Classnode);
                Except
                    on E:Exception do begin
                        TBusObj(Obj).ResultStatus.AddItem(false, rssWarning, 0,E.Message , false);
                        Exit;
                    end;
                end;
            Finally
                if TBusObj(Obj).ImportFailed = False then begin
                    TBusObj(Obj).Connection.CommitTransaction;
                    AddXMLNode(TBusObj(Obj).REsultNode , 'Status','Done');
                    REsult := True;
                end else begin
                    TBusObj(Obj).Connection.RollbackTransaction;
                    AddXMLNode(TBusObj(Obj).REsultNode , 'Status','Import Failed');
                    Result := False;
                end;
            End;
        end;
    end;
begin
  inherited;
    Result := False;
    bConnectionAssigned := false;
    strClassName:= '';
    InitResultXMLDoc;
    if MyConnection = nil then begin
      MyConnection := GetNewMyDacConnection(nil);
      bConnectionAssigned := true;
    end;
    resultnode := NewResultNode('ImportFrom');
    ImportDoc := TXMLDocument.Create('');
    Try
        if not fileValid then Exit;
        Try
            ImportDoc.LoadFromFile(FileName);
            node:= ImportDoc.ChildNodes.FindNode(XMLDocRoot);
            if not assigned(node) then begin
                resultnode.Attributes['FileName'] := FileName;
                AddXMLNode(ResultNode ,'Status' ,'Import Failed');
                ResultNode := ResultNode.Addchild('Error');
                AddXMLNode(ResultNode ,'Description' ,'Not a valid ERP data file -' + XMLDocRoot +' not found');
                Exit;
            end else begin
                resultnode.Attributes['FileName'] := FileName;
            end;
            {version cehcking}
            Try
                fsDataversion := node.Attributes['DataVersion'];
                if fsDataversion <> getUserVersion then begin
                    AddXMLNode(ResultNode ,'Status' ,'Import Failed');
                    ResultNode := ResultNode.Addchild('Error');
                    AddXMLNode(ResultNode ,'Description' , 'Version Incompatible');
                    AddXMLNode(ResultNode ,'ERPVersion' , getUserVersion);
                    AddXMLNode(ResultNode ,'ImportingDataVersion' , fsDataversion);
                    Exit;
                end;
            Except
                on E: Exception do begin
                    {exception occurs when then attribute is not provided}
                    AddXMLNode(ResultNode ,'Status' ,'Import Failed');
                    ResultNode := ResultNode.Addchild('Error');
                    AddXMLNode(ResultNode ,'Description' , 'Version Incompatible');
                    AddXMLNode(ResultNode ,'ERPVersion' , getUserVersion);
                    AddXMLNode(ResultNode ,'ImportingDataVersion' , '');
                    Exit;
                end;
            End;
            {Data import}
            for xRequest:= 0 to node.ChildNodes.Count -1 do begin
                Classnodes:= node.ChildNodes[xRequest];
                if ValidclassNode then begin
                    Obj := GetComponentByClassName(strClassName, true , nil , False , False);
                    Try
                        if ValidClass then begin
                            resultnode := NewResultNode(TBusObj(Obj).XMLNodeName);
                            //resultnode := NewResultNode('Object');
                            //resultnode := NewResultNode('Object');
                            //AddXMLNode(ResultNode ,'ObjectName' , TBusObj(Obj).XMLNodeName);
                            ImportClassREcords;
                        End;
                    Finally
                        FreeandNil(Obj);
                    end;
                end;
            end;
        Except
            On e:Exception do begin
                resultnode := NewResultNode('InvalidObjects');
                ResultNode := ResultNode.Addchild('Object');
                AddXMLNode(ResultNode ,'ObjectName' ,strClassName);
                AddXMLNode(ResultNode ,'Status' ,'Import Failed');
                ResultNode := ResultNode.Addchild('Error');
                AddXMLNode(ResultNode ,'Description' ,E.Message);
                Result := False;
                Exit;
            end;
        end;
        Result := True;
  finally
    ImportDoc.Free;

    if XMLImportResultDocName = '' then Begin
      SetXMLImportResultDocName(ExtractFilePath(FileName));
      if XMLImportResultDocName <> '' then begin
        strClassName := Copy(FileName , char_length(XMLImportResultDocName)+1 , char_length(FileName));
        strClassName := replaceStr(StrClassName , '.XML' , '_status' + FormatDatetime('yyyymmddhhnnss' , now)+'.XML');
      end;
    end;

    if Sysutils.SameText(XMLImportResultDocName,ExtractFilePath(FileName)) then
      SetXMLImportResultDocName(XMLImportResultDocName + strClassName);
    XMLImportResultDoc.XML.SaveToFile(XMLImportResultDocName);
    fsImportMsg := 'Please refer to ' + XMLImportResultDocName +' for the Import result';
    SetXMLImportResultDocName('');
    if bConnectionAssigned then begin
      MyConnection.Free;
      MyConnection := nil;
    end;
  end;
end;
end.






