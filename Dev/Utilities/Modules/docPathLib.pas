unit docPathLib;

interface

uses ERPdbComponents;

function DocumentPath(Qry:TERPQuery):String;
Procedure SetDocPath(Qry:TERPQuery);
Procedure OpenDocPath(Qry:TERPQuery);
Function  cDocumentPath(Qry:TERPQuery):String;

implementation

uses AppEnvironment , {$WARNINGS OFF}FileCtrl{$WARNINGS ON}, CommonDbLib, CommonLib , ShellAPI , Windows, Dialogs , Sysutils,
  tcConst, CommonFormLib, tcDataUtils;

function DocumentPath(Qry:TERPQuery):String;
begin
  try
    result := Qry.fieldbyname('DocumentPath').AsString;
  Except
    // kill the exception
  end;
  if result = '' then result := Appenv.DocPath.DocumentPath;
end;
procedure SetDocPath(Qry: TERPQuery);
var
  aDir: string;
begin
  aDir := DocumentPath(Qry);
  if SelectDirectory('Select Directory', '', aDir) then begin
    EditDb(Qry);
    Qry.FieldByName('DocumentPath').AsString := aDir;
    Qry.Post;
  end;
end;
Procedure OpenDocPath(Qry:TERPQuery);
var
  fipartsID:Integer;
  Function Productname :String;
  begin
    if Qry.findfield('PARTNAME')<> nil then result := Qry.findfield('PARTNAME').asString
    else if Qry.findfield('Productname')<> nil then result := Qry.findfield('Productname').asString
    else if Qry.findfield('PartsId')<> nil then result := GetProduct(Qry.findfield('PartsId').asInteger)
    else result := '';
  end;
begin
      if  (trim(Qry.fieldbyname('DocumentPath').AsString) = '') OR
          not(DirectoryExists(trim(Qry.fieldbyname('DocumentPath').AsString)))  then begin
        if CommonLib.MessageDlgXP_Vista('Selected Path of '+quotedstr(Productname)+ ' is ' +
                              iif(trim(Qry.fieldbyname('DocumentPath').AsString) ='', 'Blank', quotedstr(trim(Qry.fieldbyname('DocumentPath').AsString))+' that Doesn''t Exists')+'.' ,
                                          mtInformation,[mbCancel],0 ,nil, '' , '' , False, nil ,
               iif((Qry.FindField('PartsId')<> nil) and  (Qry.FindField('PartsId').AsInteger<> 0),  'Open Product Card of '+quotedstr(Productname) +' to Change The Path', '') ) = 100 then
             if OpenERPFormModal('TfrmParts',Qry.FindField('PartsId').AsInteger)>0 then begin
                fipartsID:=Qry.FindField('PartsId').AsInteger;
                closedb(Qry);
                opendb(Qry);
                if Qry.FindField('PartsId').AsInteger <> fipartsID then
                  Qry.Locate('PartsID' ,fipartsID  , []);
                if Qry.FindField('PartsId').AsInteger = fipartsID then OpenDocPath(Qry);
                Exit;
             end;
        Exit;
      end;

  if trim(Qry.fieldbyname('DocumentPath').AsString) <> '' then begin
    try
      ShellAPI.ShellExecute(0,'open',PChar(Qry.fieldbyname('DocumentPath').AsString),nil,nil,SW_SHOWNORMAL);
    Except
      on E:Exception do begin
        CommonLib.MessageDlgXP_Vista('Error Opening the Path ' + quotedstr(trim(Qry.fieldbyname('DocumentPath').AsString))+'.'+NL+NL+
                                      E.message,mtInformation,[mbOk],0);
      end;
    end;
  end else begin
    CommonLib.MessageDlgXP_Vista('The Document Path has not been set for this product.',mtInformation,[mbOk],0);
  end;
end;
Function  cDocumentPath(Qry:TERPQuery):String;
begin
  Result  := Qry.fieldbyname('DocumentPath').AsString;
  if Result = '' then Result := 'Not Set';
end;
end.
