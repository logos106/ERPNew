unit DataImport;

interface

Uses ProgressDialog,Classes, busobjbase;

type
  TDataImport = class(TComponent)
  Private
    fsHeader  : String;

    Busobj    : Tbusobj;
    fsImportErrors: String;
    fsImportingFile: String;
    fProgressDialog :TProgressDialog;
    FileLinesCount:Integer;
    FiletoImport: TextFile;
    TextFileStrings: TStringList;
    fHeader  : TStringList;
    fDataLine: TStringList;

//    Procedure ImportLine;
    function Init:Boolean;
    function getDataline(Const Lineno:Integer):String;
    Function   ProgressDialog : TProgressDialog;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    Property ImportErrors     :String read fsImportErrors      write fsImportErrors;
    Property ImportingFile:String Read fsImportingFile Write fsImportingFile;
    Procedure CleanUp;
    Procedure Importdata;
    Procedure addLog(const Lineno:Integer; const ErrMsg:String );

  End;

implementation

uses TypInfo, Dialogs, CommonLib,  sysutils, FastFuncs, CommonDbLib;

{ TDataImport }

procedure TDataImport.addLog(const Lineno: Integer; const ErrMsg: String);
begin
  if fsImportErrors <> '' then fsImportErrors := fsImportErrors + chr(13);
  fsImportErrors := fsImportErrors + ErrMsg +' at line no :' + IntToStr(Lineno) ;
end;

procedure TDataImport.CleanUp;
begin
  FreeandNil(BusObj);
  fsHeader        := '';
end;

constructor TDataImport.Create(AOwner: TComponent);
begin
  inherited;
  CleanUp;
  fsImportingFile := '';
  TextFileStrings:= TStringList.create;
  fHeader  := TStringList.create;
end;

destructor TDataImport.Destroy;
begin
  cleanup;
  FreeandNil(fProgressDialog);
  FreeandNil(TextFileStrings);
  FreeandNil(fHeader);
  inherited;
end;

function TDataImport.getDataline(const Lineno: Integer): String;
begin
 Result:= TextFileStrings[Lineno];
 Result:= StripQuotes(Result);
 result:= Commonlib.ReplaceStr(Result, #9, #44);
end;

procedure TDataImport.Importdata;
var
  I:Integer;
  x:Integer;
  PropList: PPropList ;
  Propcount:Integer;
  Index :Integer;
  Procedure findproperty;
    var ctr:Integer;
  begin
    index:= -1;
    for ctr:= 0 to Propcount-1 do begin
        if SysUtils.Sametext(string(Proplist[ctr].name) ,fHeader[x]) then begin
            index := ctr;
            exit;
        end;
    end;
  end;
begin
  CleanUp;
  if fsImportingFile = '' then begin
    CommonLib.MessageDlgXP_Vista('Please provide the name of the file to be imported' , mtWarning, [mbok], 0);
    exit;
  end;
  if not IsDir(ExtractFileDir(fsImportingFile)) then begin
    CommonLib.MessageDlgXP_Vista('Directory "' + ExtractFileDir(fsImportingFile) + '"' + #13 + ' Does Not Exist !', mtWarning, [mbOK], 0);
    Exit;
  end;
  if not IsFile(fsImportingFile) then begin
    CommonLib.MessageDlgXP_Vista('File "' + fsImportingFile + '"' + #13 + 'Does Not Exist !', mtWarning, [mbOK], 0);
    Exit;
  end;
  Init;
  Propcount:= GetPropList(PTypeInfo(Busobj.ClassInfo) , PropList);

  Busobj.Connection.BeginTransaction;
  try
    fDataLine:= TStringList.create;
    try
      ProgressDialog.Value := 0;
      ProgressDialog.Caption := 'Please Wait .......Importing';
      for I := 1 to  TextFileStrings.count-2 do begin
        ProgressDialog.stepIt;
        Split(getDataline(i), ',' , fDataLine);
        busobj.Connection.BeginNestedTransaction;
        try
          busobj.AddNewifMissing(fHeader, fDataline);
          for x := 1 to fHeader.count-1 do begin
            try
              Findproperty;
              if index <0 then begin
                addLog(0, Busobj.classname +':Invalid property name ->' + fHeader[x] );
                Continue;
              end else begin
                if (proplist^[Index].Proptype^.Kind = tkEnumeration) then
                  SetPropValue(Busobj, fHeader[x] ,strToboolean(fDataLine[x]))
                else
                  SetPropValue(Busobj, fHeader[x] ,fDataLine[x]);
              end;
            except
              on E:EPropertyError do begin
                addLog(I, 'Invalid property :' + fHeader[x] + '=' + fDataLine[x]);
                Continue;
              end;
              on E:EPropertyConvertError do begin
                addLog(I, 'Property converting Error:' + fHeader[x] +'=' + fDataLine[x]);
                Busobj.OnSetpropErrors(fHeader[x] ,fDataLine[x]);
                Continue;
              end;
            end;
          end;
          busobj.ResultStatus.clear;
          if not busobj.Save then begin
            busobj.Canceldb;
            addLog(I,busobj.ResultStatus.Messages );
            busobj.Connection.RollbackNestedTransaction;
            Continue;
          end;
          busobj.Connection.CommitNestedTransaction;
        except

          on E:Exception do begin
            addLog(I, e.Message);
            busobj.Connection.RollbackNestedTransaction;
            Continue;
          end;
        end;
      end;
    finally
        Freeandnil( fDataLine);
        FreeandNil(fProgressDialog);
    end;
    Busobj.Connection.CommitTransaction;
  Except
      on E:Exception do begin
        addLog(0, e.Message);
        busobj.Connection.RollbackTransaction
      end;
  end;

end;

function TDataImport.Init: Boolean;
var
  i:Integer;
  objectname:String;
  obj:TComponent;
  fsDataLine: String;
begin
  result := false;
  FileLinesCount := LineCount(fsImportingFile);
  if FileLinesCount =0 then exit;

  if FileLinesCount <= 2 then begin
    CommonLib.MessageDlgXP_Vista('File "' + fsImportingFile + '"' + #13 + 'is Empty !', mtWarning, [mbOK], 0);
    exit;
  end;

  AssignFile(FiletoImport, fsImportingFile);
  try
    {$I-}
    Reset(FiletoImport);
    {$I+}
    IOResult;
  except
    CommonLib.MessageDlgXP_Vista('File is Already in Use!', mtWarning, [mbOK], 0);
  end;
  ProgressDialog.Caption := 'Please Wait .......loading data';
  ProgressDialog.MinValue := 0;
  ProgressDialog.Step := 1;
  ProgressDialog.MaxValue := FileLinesCount;
  ProgressDialog.Execute;
  TextFileStrings.clear;
  for I := 1 to FileLinesCount do begin
    ProgressDialog.stepit;
    Readln(FiletoImport, fsDataLine);
    fsDataLine := Trim(fsDataLine);
    if not empty(fsDataLine) then TextFileStrings.Add(fsDataLine);
  end;
  closefile(FiletoImport);


  if TextFileStrings.count<=2 then begin
    CommonLib.MessageDlgXP_Vista('File "' + fsImportingFile + '"' + #13 + 'is Empty !', mtWarning, [mbOK], 0);
    exit;
  end;


  fsHeader := getDataLine(0);
  Split(fsHeader, ',' , fHeader);

  objectname :=Trim(fHeader[0]);
  if objectname = '' then begin
    CommonLib.MessageDlgXP_Vista('File ' + fsImportingFile + '  has no object definition !', mtWarning, [mbOK], 0);
    exit;
  end;

  Objectname := StringReplace(objectname , '$' , 'T' , []);
  Obj := getcomponentbyclassname(objectname);
  if not assigned(obj) then begin
    CommonLib.MessageDlgXP_Vista('File ' + fsImportingFile + ' has invalid object - ' +objectname+'!', mtWarning, [mbOK], 0);
    exit;
  end;
  if not (Obj is TBusObj) then begin
    CommonLib.MessageDlgXP_Vista(objectname+' in File ' + fsImportingFile + ' is not a valid ERP object!', mtWarning, [mbOK], 0);
    exit;
  end;

  Busobj := Tbusobj(Obj);
  Busobj.SilentMode:= true;
  Busobj.connection := TMyDacDataConnection.create(Busobj);
  Busobj.Connection.Connection := GetNewMyDacConnection(self);
  REsult := true;
end;


function TDataImport.ProgressDialog: TProgressDialog;
begin
if fProgressDialog = nil then
  fProgressDialog := TProgressDialog.Create(nil);
result :=fProgressDialog;
end;

end.
