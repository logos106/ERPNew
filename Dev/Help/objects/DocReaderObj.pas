unit DocReaderObj;

interface

uses ERPdbComponents, classes;

type
  TDocReaderObj = Class(TComponent)
  Private
    fsFilenamePrefix:String;
  Public
    Class Function ShowERPHelp(qryERPHelpDocs :TERPQuery;AOwner :TComponent;  Openform:boolean; HelpdDescription :String):Boolean ;
    Function DoShowERPHelp(qryERPHelpDocs :TERPQuery;Openform:boolean; HelpdDescription :String):Boolean;

    Class Procedure ShowHRForm(qryHRForm :TERPQuery;AOwner :TComponent;  RefID:Integer; Filetype:String);
    Procedure DoShowHRForm(qryHRForm :TERPQuery;RefID:Integer; Filetype:String);

    Destructor Destroy;Override;
    constructor  Create(AOwner:TComponent); Override;
  End;




implementation

uses
  DbSharedObjectsObj, DBTables, CommonDbLib, sysutils,
  SystemLib, db , ShellAPI, windows, DNMLib, ERPPDFDocs, ERPUDHelpDocs,
  HelpDocLib, tcDataUtils, RandomUtils;

constructor TDocReaderObj.Create(AOwner: TComponent);
begin
  inherited;
  fsFilenamePrefix :='ERPHelpDoc_' +  GetTemporaryTableNameSuffix+'_';
end;

destructor TDocReaderObj.Destroy;
begin
  inherited;
  DeleteFiles(Wintempdir,fsFilenamePrefix+'*.*');
end;

Class Function TDocReaderObj.ShowERPHelp(qryERPHelpDocs :TERPQuery;AOwner :TComponent;  Openform:boolean; HelpdDescription :String):Boolean;
var
  fDocReaderObj : TDocReaderObj;
begin
    fDocReaderObj := TDocReaderObj(AOwner.FindComponent('DocReaderObj_ERPHelp'));
    if not(Assigned(fDocReaderObj)) then begin
      fDocReaderObj := TDocReaderObj.Create(AOwner);
      fDocReaderObj.Name := 'DocReaderObj_ERPHelp_' + MakeRandomString(8);
      fDocReaderObj.fsFilenamePrefix :='ERPHelpDoc_' + GetTemporaryTableNameSuffix+'_';
    end;
    Result := fDocReaderObj.DoShowERPHelp(qryERPHelpDocs , OpenForm, HelpdDescription);
end;


Function TDocReaderObj.DoShowERPHelp(qryERPHelpDocs :TERPQuery;Openform:boolean; HelpdDescription :String):Boolean;
var
  fsfilename:String;
//  s:STring;
  bs:TStream;
  Qry :TERPQuery;
  Procedure OpenHelpfile(blobFieldName:String);
  begin
      fsfilename:= HelpdocfilenamewithPath(Qry.FieldByName('filename').asString);
      if FileExists(fsfilename) then else begin
        bs := Qry.CreateBlobStream((Qry.findfield(blobFieldName) as TBlobField), bmRead);
        try
            with TFileStream.Create(fsfilename, fmCreate) do
              try
                CopyFrom(bs, bs.Size)
              finally
                Free
              end;
              sleep(500);
        finally
          Freeandnil(bs);
        end;
      end;
      ShellExecute(0,'open',PChar(fsFilename),nil,nil,SW_NORMAL);
  end;
begin
  REsult := False;
  if Openform then begin

    {for User Defined help files - its from the local table}
    if (qryERPHelpDocs <> nil) and (qryERPHelpDocs.findfield('document')<> nil) then begin
        qry := qryERPHelpDocs;
       Openhelpfile('document');
       Exit;
    end;

    if qryERPHelpDocs <> nil then Qry := qryERPHelpDocs
    (*else if (Assigned(Owner)) and (owner is TERPUDHelpDocsGUI) then qry := TERPUDHelpDocsGUI(Owner).Qrymain
    else if (Assigned(Owner)) and (owner is TERPPDFDocsGUI) then qry := TERPPDFDocsGUI(Owner).Qrymain*)
    else Qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    try
      if not DownloadHelpdoc(HelpdocID(HelpdDescription) ,Qry) then exit;

      (*if (Qry.Active =False) or (not(Sametext(Qry.FieldByName('Description').AsString , HelpdDescription))) then begin
          Closedb(Qry);
          Qry.SQL.Text := 'Select * from erpdocumentaion.tblhelpdocs where Description =' + quotedstr(HelpdDescription);
          OpenDB(Qry);
      end;
      if Qry.recordcount =0 then exit;
      if Qry.fieldbyname'HelpDoc').asString = '' then begin
        MessageDlgXP_Vista(quotedstr(Qry.FieldByName('filename').asString)+' is Missing. ERP Synchronizes the Help Doc files Hourly. Please Try Again Later', mtInformation, [mbOK], 0);
        Exit;
      end;
      fsfilename:= Wintempdir+ fsFilenamePrefix+FormatdateTime('hhnnsszzz', now)+'.' +Qry.fieldbyname('Filetype').AsString;
      While FileExists(fsfilename) do fsfilename := replacestr(fsfilename, '.' , 'a.');
      *)

      (*fsfilename:= HelpdocfilenamewithPath(Qry.FieldByName('filename').asString);
      if FileExists(fsfilename) then else begin
        bs := Qry.CreateBlobStream((Qry.findfield('HelpDoc') as TBlobField), bmRead);
        try
            with TFileStream.Create(fsfilename, fmCreate) do
              try
                CopyFrom(bs, bs.Size)
              finally
                Free
              end;
              sleep(500);
        finally
          Freeandnil(bs);
        end;
      end;
      ShellExecute(0,'open',PChar(fsFilename),nil,nil,SW_NORMAL);*)
      Openhelpfile('HelpDoc');

      Result := True;
    finally
      if Qry <> qryERPHelpDocs then DbSharedObjectsObj.DbSharedObj.ReleaseObj(Qry);
    end;
  end;
end;


Class Procedure TDocReaderObj.ShowHRForm(qryHRForm :TERPQuery;AOwner :TComponent; RefID:Integer; Filetype:String);
var
  fDocReaderObj : TDocReaderObj;
begin
  fDocReaderObj := TDocReaderObj(AOwner.FindComponent('DocReader_ShowHRForm'));
    if not(Assigned(fDocReaderObj)) then begin
      fDocReaderObj := TDocReaderObj.Create(AOwner);
      fDocReaderObj.name := 'DocReader_ShowHRForm';
      fDocReaderObj.fsFilenamePrefix :='HRForm_' + GetTemporaryTableNameSuffix+'_';
    end;
  fDocReaderObj.DoShowHRForm(qryHRForm , RefID , Filetype);
end;


Procedure TDocReaderObj.DoShowHRForm(qryHRForm :TERPQuery;RefID:Integer; Filetype:String);
var
  fsfilename:String;
//  s:STring;
  bs:TStream;
  Qry :TERPQuery;
begin
    if qryHRForm <> nil then Qry := qryHRForm
    else     Qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    try

      if (Qry.Active =False) or (Qry.FieldByName('RefID').asInteger <> refid) then begin
          Closedb(Qry);
          Qry.SQL.Text := 'Select * from tblreference where RefID =' + inttostr(RefID);
          OpenDB(Qry);
      end;
      if Qry.recordcount =0 then exit;
      fsfilename:= Wintempdir+ fsFilenamePrefix+FormatdateTime('hhnnsszzz', now)+'.' +Filetype;
      While FileExists(fsfilename) do fsfilename := replacestr(fsfilename, '.' , 'a.');
      bs := Qry.CreateBlobStream((Qry.findfield('ReferenceData') as TBlobField), bmRead);
      try
          with TFileStream.Create(fsfilename, fmCreate) do
            try
              CopyFrom(bs, bs.Size)
            finally
              Free
            end;
            sleep(1500);
      finally
        Freeandnil(bs);
      end;
      ShellExecute(0,'open',PChar(fsFilename),nil,nil,SW_NORMAL)
    finally
      if Qry <> qryHRForm then DbSharedObjectsObj.DbSharedObj.ReleaseObj(Qry);
    end;
end;

end.
