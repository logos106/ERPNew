unit CustomExport;
{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 17/08/06  1.00.01 BJ   checking for the access level of the object before exporting
}
interface

uses XMLDoc, XMLIntf, BusObjBase, ComCtrls,AdvOfficeStatusBar, stdCtrls;

type
  TCustomExport = class(TObject)
  private
    Doc             : IXMLDocument;
    CurNode         : IXMLNode;
    fsExportClasses : String;
    fProgressBar: TProgressBar;
    fRecordsProgressBar: TProgressBar;
    fMsgLabel: TLabel;
    fbExcludeInactive :Boolean;
    procedure   SaveXML(Const Sender: TBusObj;  var Abort: Boolean);
    Function getFileName :String;
    Procedure setFileName(const Value :STring);
  Public
    constructor Create;
    Property    ExportClasses   :String Read fsExportClasses Write fsExportClasses;
    Property    FileName        :String Read getFileName     Write setFileName;
    Property    ProgressBar     :TProgressBar Read fProgressBar Write fProgressBar;
    Property    RecordsProgressBar    :TProgressBar Read fRecordsProgressBar Write fRecordsProgressBar;
    Property    ExcludeInactive : boolean Read fbExcludeInactive Write fbExcludeInactive;
    Property    MsgLabel        : TLabel read fMsgLabel write fMsgLabel;

    Procedure ExportToXML;

  Protected

  End;


implementation

uses FastFuncs,CommonLib, Classes , Sysutils, BusObjConst,
    CommonDbLib , Forms, tcDataUtils, controls, DNMLib,SystemLib;
    
Procedure TCustomExport.setFileName(const Value :STring);
begin
    SetXMLExportResultDocName(Value);
end;
Function TCustomExport.getFileName :String;
begin
    if XMLExportResultDocName = '' then
        SetXMLExportResultDocName(SystemLib.ExeDir +'ERPData_' +FormatDatetime('yyyymmddhhnnss' , now) +'.XML');
    Result := XMLExportResultDocName;
end;

constructor TCustomExport.Create;
begin
    inherited;
    fsExportClasses := '';
    fProgressBar := nil;;
    fRecordsProgressBar := nil;
    fMsgLabel := nil;
    fbExcludeInactive := False;
end;

procedure TCustomExport.SaveXML(Const Sender: TBusObj;  var Abort: Boolean);
var
    ClassNode: IXMLNode;
begin
    if RecordsProgressBar <> nil then RecordsProgressBar.StepIT;
    ClassNode := CurNode.Addchild(Sender.XMLNodeName);
    Sender.SavingXMLTofile := true;
    Sender.SaveToXMLNode(ClassNode);
end;

Procedure TCustomExport.ExportToXML;
var
    ClassList :TStringList;
    x :Integer;
    xx:Integer;
    HeaderNode: IXMLNode;
    obj :TBusObj;
    strClassName :STring;
    strWhere :STring;
    SelectedRecs: Integer;

    Procedure RecordError(const objectName, statusMsg :STring);
    var
      Errornode: IXMLNode;
    begin
        if HeaderNode.ChildNodes.FindNode('InvalidObjects') <> nil then
            Errornode:= HeaderNode.ChildNodes.FindNode('InvalidObjects')
        else Errornode := HeaderNode.Addchild('InvalidObjects');
        Curnode := Errornode.Addchild('Object');
        AddXMLNode(Curnode ,'ObjectName' ,objectName);
        AddXMLNode(Curnode ,'Status' ,'Export Failed');
        Curnode := Curnode.Addchild('Error');
        AddXMLNode(Curnode ,'Description' ,statusMsg);
    end;
    Procedure   SaveXMLTofile;
    begin
        Try
            Doc.XML.SaveToFile(FileName);
        Except
            On E:Exception do begin
                RecordError( '' , E.message );
            end;
        End;
    End;

    Procedure   CreateHeader;
    begin
        doc.Active := true;
        doc.Version := XMLDocVersion;
        doc.Encoding := XMLDocEncoding;
        HeaderNode:= doc.AddChild(XMLDocRoot);
        HeaderNode.Attributes['DataVersion'] := getUserVersion;
    end;
    Function    ClassNameValid:Boolean;
    begin
        REsult := False;
        strClassName :=ClassList[X];
        xx := FastFuncs.PosEx('{' , strClassName);
        strwhere := '';
        if xx > 0 then  begin
            strwhere := copy(strClassName ,xx, char_length(strClassName));
            strClassName :=copy(strClassName , 1, xx-1);
        End;

        if  strClassName <> '' then begin
            Obj := TBusObj(GetComponentByClassName(strClassName , False , nil , True , False ));
            if obj = nil then
                RecordError(StrClassName , 'Class not found')
            else    Result := true;
        End;
        if not REsult then Exit;
        Obj.ExcludeInactive := ExcludeInactive;
        if Obj.Accessmanager.Accesslevel = 6 then begin
            RecordError(StrClassName , 'No access');
            REsult := False;
        end;
    End;
    Procedure   Exportclass;
    begin
        Try
            Try
                if MsgLabel <> nil then begin
                    MsgLabel.Caption := 'Exporting ' + strClassName;
                    MsgLabel.Refresh;
                end;
                Curnode := HeaderNode.Addchild(XMLDocRequest);
                Curnode.Attributes['OnError'] := XMLDocRequestStopError;
                Curnode.Attributes['DataObject'] := strClassName;
                TBusObj(obj).Connection := TMydacDataConnection.Create(TBusObj(obj));
                TMydacDataConnection(TBusObj(obj).Connection).MyDacConnection := GetNewMyDacConnection(TBusObj(obj));
                if strwhere <> '' then begin
                    xx:= FastFuncs.PosEx( '}', strWhere);
                    if xx > 0 then strwhere := copy(strwhere , 1, xx);
                    strWhere := replaceStr(strwhere , '|' , ''',''');
                    strWhere := replaceStr(strwhere , '{' , '');
                    strWhere := replaceStr(strwhere , '}' , '');
                    strwhere := 'Globalref in (''' +  strWhere + ''')';
                    Obj.LoadSelect(strwhere);
                end else Obj.Load;
                if RecordsProgressBar <> nil then begin
                    RecordsProgressBar.Max := Obj.Dataset.Recordcount;
                    RecordsProgressBar.Position := 0;
                end;
                Obj.IterateRecords(SaveXML);
            Except
                on e:Exception do begin
                    RecordError(StrClassName , E.Message)
                end;
            End;
        Finally
            Freeandnil(Obj);
        End;
    End;
    Procedure   InitExport;
    begin
      Processingcursor(True);
(*      if fProgressBar <> nil then
        ProgressBar.Visible := True;
      if fMsgLabel <> nil then
        MsgLabel.Visible := True;
      if fRecordsProgressBar <> nil then
        RecordsProgressBar.Visible := True;*)
      if fProgressBar <> nil then begin
        fProgressBar.Max :=SelectedRecs;
        fProgressBar.Position := 0;
      End;
    end;
    Procedure   EndExport;
    begin
(*        if fProgressBar <> nil then
            ProgressBar.Visible := False;
        if fRecordsProgressBar <> nil then
            RecordsProgressBar.Visible := False;
        if fMsgLabel <> nil then
            MsgLabel.Visible := False;*)
        Processingcursor(False);
    end;

begin
    if fsExportClasses = '' then Exit;
    ClassList := TStringList.Create;
    Try
        FastFuncs.Split(fsExportClasses , ',' , ClassList);
        SelectedRecs :=ClassList.Count;
        InitExport;
        doc:= TXMLDocument.Create(nil);
        try
            CreateHeader;
            for X := 0 to ClassList.Count - 1 do begin
                if fProgressBar <> nil then fProgressBar.StepIt;
                if ClassNameValid then ExportClass;
            End;
            SaveXMLtoFile;
        finally
//            Doc.Free;
        end;
    Finally
        FreeandNil(ClassList);
        EndExport;
    end;
end;
end.




