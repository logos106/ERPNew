unit frmTableSelector;

  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  xx/xx/xx  1.00.00 xxx  Initial Version.
  15/05/06  1.00.01 ijb  Changed to use TALXMLNode and LoadFromXMLNode to use
                         SetBooleanPropertyFromNode and SetDateTimePropertyFromNode.
  }


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, MyAccess, StdCtrls, ExtCtrls,
  DNMSpeedButton, wwdblook, Grids, Wwdbigrd, Wwdbgrid, Wwdatsrc;

const
  TC =  '  ';
  Version = '1.00.01';

type
  TForm1 = class(TForm)
    MyConnection: TMyConnection;
    txtFileName: TEdit;
    SpeedButton1: TDNMSpeedButton;
    Bevel2: TBevel;
    Bevel1: TBevel;
    LstTables: TListBox;
    SaveDialog1: TSaveDialog;
    btnCreate: TButton;
    dsTable: TMyQuery;
    tblUser: TMyQuery;
    tblUserFirstName: TStringField;
    tblUserMiddleName: TStringField;
    tblUserLastName: TStringField;
    wwDataSource1: TwwDataSource;
    wwDBGrid1: TwwDBGrid;
    Bevel3: TBevel;
    FieldList: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    Letter_Label: TLabel;
    Button1: TButton;
    Label3: TLabel;
    txtFormname: TEdit;
    DNMSpeedButton1: TDNMSpeedButton;
    Label4: TLabel;
    txtClassName: TEdit;
    Label5: TLabel;
    edtDatabase: TEdit;
    Button2: TButton;
    Procedure FormShow(Sender: TObject);
    Procedure SpeedButton1Click(Sender: TObject);
    Procedure btnCreateClick(Sender: TObject);
    Procedure LstTablesClick(Sender: TObject);
    Procedure Button1Click(Sender: TObject);
    Procedure DNMSpeedButton1Click(Sender: TObject);
    procedure edtDatabaseExit(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    sKeyField :STring;
    fifieldLength : Integer;
    Function ReplicateStr(Const Value :String; Count :Integer):String;
    Function AddSpace(const Data:String; ficount :Integer = 0):STring;
    Function isFileNameValid :Boolean;
    Function RequiredField(sFieldName :String):Boolean;
    Function ProperCase(Value :String):STring;
    Function ERPVersionnumber:String;

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses ClipBrd, StrUtils;

{$R *.dfm}
Function TForm1.ProperCase(Value :String):STring;
begin
    Value := Trim(Value);
    Result := '';
    if Value = '' then Exit;
    result:= Value;
    if (Length(Result) >= 2) and (copy(Result, Length(Result) - 1, 2) = 'id') then
      Result := Copy(Result, 1, Length(Result) - 2) + 'ID';
end;
Procedure TForm1.FormShow(Sender: TObject);
var
    ctr:Integer;

begin
    Caption:= 'BusObj Creater - ' + Version;
    fifieldLength := 0;
    if MyConnection.Connected = False then MyConnection.Connect;

    LstTables.Items.Clear;
    MyConnection.GetTableNames(LstTables.Items);
    ctr := 0;
    while ctr <= LstTables.Items.Count-1 do
        if (length(LstTables.Items[ctr]) > 4) and  (uppercase(copy(LstTables.Items[ctr] ,1 , 4)) = 'TMP_') then
            LstTables.Items.Delete(ctr) else ctr:= ctr+1;
    try
      if tblUser.Active = False then tblUser.Open;
    except

    end;
end;

Procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    txtFileName.Text := Propercase(SaveDialog1.FileName);
  isFileNameValid;

end;
Function TForm1.RequiredField(sFieldName :String):Boolean;
begin
    Result := (UpperCase(sFieldName) <> UpperCase(sKeyfield)) and
                (UpperCase(sFieldName) <> UpperCase('globalref' )) and
                (UpperCase(sFieldName) <> UpperCase('editedflag')) and
                (UpperCase(sFieldName) <> UpperCase('mstimestamp')) and
                (UpperCase(sFieldName) <> UpperCase('msupdatesitecode'));
end;


Function replaceStr(sString, oldStr, newStr:String):STring;
begin
    REsult :=  AnsiReplaceStr(sString, OldStr, newStr)
end;

Procedure TForm1.btnCreateClick(Sender: TObject);
var
    F: TextFile;
    ctr :Integer;
    fCtr :Integer;
    tableName :String;
    sFieldName :STring;
    sLine :STring;
    sClassName :String;

    Procedure AddLine( Value :STring);
    begin
        Writeln(F, Value );
    End;
    Function FieldType(fField :TField; ForceUpperCase: Boolean = False):String;
    begin
        Result := '';
        if fField = nil then Exit;
        if fField.DataType in [ftSmallint, ftInteger, ftWord, ftLargeint] then
            Result := 'Integer   '
        else if fField.DataType =   ftBoolean then
            Result := 'Boolean   '
        else if fField.DataType in [ftFloat	, ftCurrency, ftBCD	] then
            Result := 'Double    '
        else if fField.DataType in [ftDate	, ftTime	, ftDateTime	] then
            Result := 'TDateTime '
        else if (fField.Size= 1) and (fField.DataType = ftString) then // enum fields
             Result :='Boolean   '
        else if fField.DataType in [ftString,ftVarBytes, ftMemo, ftFmtMemo, ftWideString] then begin
          if ForceUpperCase then
            Result := 'String    '
          else
            Result := 'string    ';
        end;

    end;
    Function XMLType(fField :TField):String;
    begin
        Result := '';
        if fField = nil then Exit;
        if fField.DataType in [ftSmallint, ftInteger, ftWord, ftLargeint]  then
            Result := 'Integer'
        else if fField.DataType =   ftBoolean then
            Result := 'Boolean'
        else if fField.DataType in [ftFloat	, ftCurrency, ftBCD	] then
            Result :=  'Float'
        else if fField.DataType in [ftDate	, ftTime	, ftDateTime	] then
            Result :=  'DateTime'
        else if (fField.Size= 1) and (fField.DataType = ftString) then // enum fields then
            Result := 'Boolean'
        else if fField.DataType in [ftString,ftVarBytes, ftMemo, ftFmtMemo, ftWideString] then
            Result := 'String'
    end;
begin
    if not isFileNameValid then Exit;
    if LstTables.itemindex = -1 then Exit;
    tableName := LstTables.Items[LstTables.ItemIndex];
    sClassName:= txtClassName.Text;
    try
      AssignFile(F, txtFileName.Text);
      Rewrite(F);
      Try
        if dsTable.Active then dsTable.Close;
        dsTable.SQL.Clear;
        dsTable.SQL.add('Select * from ' + tableName);
        dsTable.Open;
        For ctr := 0 to dsTable.FieldCount-1 do begin
            //if dsTable.Fields[ctr].Datatype = ftAutoInc then
            if dsTable.Fields[ctr].AutoGenerateValue = arAutoInc then
                sKeyField :=Propercase(dsTable.Fields[ctr].FieldName);
            if fifieldLength < length(dsTable.Fields[ctr].FieldName) then
                fifieldLength := length(dsTable.Fields[ctr].FieldName);
        end;

        AddLine('unit ' + replaceStr(ExtractFileName(txtFileName.Text), '.pas', ';') );
        AddLine(TC+'{');
        AddLine(TC+' Date     Version  Who  What');
        AddLine(TC+'-------- -------- ---  ------------------------------------------------------');
        AddLine(TC+FormatDateTime('dd/mm/yy' , Date) + TC + '1.00.00' +TC+ copy(tblUserFirstName.asString,1,1) + copy(tblUserLastName.asString,1,1) +   TC+  'Initial Version.');
        AddLine(TC+'}');
        AddLine(Chr(13)+ chr(10));
        Addline('interface');
        AddLine(Chr(13)+ chr(10));
        Addline('uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;');
        AddLine(Chr(13)+ chr(10));
        Addline('type');
        Addline(TC+sClassName+   ' = class(TMSBusObj)');
        Addline(TC+'private');
        {get Functions }
        For ctr := 0 to dsTable.FieldCount-1 do begin
            sLine := '';
            sFieldName :=Propercase(dsTable.Fields[ctr].FieldName);
            if RequiredField(sFieldName) then begin
                sLine := FieldType(dsTable.Fields[ctr]);
                if sLine <> '' then
                  sLine := TC+TC+'function Get' +AddSpace(sFieldName) +Tc+TC+': '+sLine+';';
            end;
            if sLine <> '' then AddLine(sLine);
        end;
        {set Procedures}
        For ctr := 0 to dsTable.FieldCount-1 do begin
            sLine := '';
            sFieldName :=Propercase(dsTable.Fields[ctr].FieldName);
            if RequiredField(sFieldName) then begin
                sLine := FieldType(dsTable.Fields[ctr]);
                if sLine <> '' then
                  sLine := TC+TC+'procedure Set' +AddSpace(sFieldName) +Tc+TC+'(const Value: '+sLine+');';
            end;
            if sLine <> '' then AddLine(sLine);
        end;

        Addline(TC+'protected');
        Addline(TC+TC+'procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;');
        Addline(TC+TC+'procedure DoFieldOnChange(Sender: TField);                          override;');
        Addline(TC+TC+'function  GetSQL                             : string;              override;');
        Addline(TC+TC+'function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;');

        Addline(TC+'public');
        Addline(TC+TC+'class function  GetIDField                   : string;              override;');
        Addline(TC+TC+'class function  GetBusObjectTablename        : string;              override;');
        AddLine(TC+TC+'constructor  Create(AOwner: TComponent);                            override;');
        AddLine(TC+TC+'destructor   Destroy;                                               override;');
        AddLine(TC+TC+'procedure    LoadFromXMLNode(const node: IXMLNode);                 override;');
        AddLine(TC+TC+'procedure    SaveToXMLNode(const node: IXMLNode);                   override;');
        AddLine(TC+TC+'function     ValidateData: Boolean ;                                override;');
        AddLine(TC+TC+'function     Save: Boolean ;                                        override;');
        Addline(TC+'published');

        {Properties}
        For ctr := 0 to dsTable.FieldCount-1 do begin
            sLine := '';
            sFieldName :=Propercase(dsTable.Fields[ctr].FieldName);
            //if (sFieldName <> sKeyfield) and (sFieldName <> 'globalref' ) then begin
            if RequiredField(sFieldName) then begin
                sLine := FieldType(dsTable.Fields[ctr]);
                if sLine <> '' then
                  sLine := TC+TC+'property ' +AddSpace(sFieldName) +Tc+TC+' :'+sLine+TC+ 'read Get' + AddSpace(sFieldName) + TC + ' write Set' + AddSpace(sFieldName)+';' ;
            end;
            if sLine <> '' then AddLine(sLine);
        end;
        AddLine(TC+'end;');
        AddLine(Chr(13)+ chr(10));
        AddLine('implementation');
        AddLine(Chr(13)+ chr(10));
        AddLine('uses tcDataUtils, CommonLib;');
        AddLine(Chr(13)+ chr(10));
        AddLine('');
        AddLine(TC+ '{'+sClassName+'}');
        AddLine('');

        AddLine('constructor ' + sclassName +'.Create(AOwner: TComponent);');
        AddLine('begin');
        AddLine(TC+'inherited Create(AOwner);');
        AddLine(TC+'fBusObjectTypeDescription:= ' + '''' + Copy(sClassName,2,Length(sClassName)) + ''';');
        AddLine(TC+'fSQL := '+ QuotedStr('SELECT * FROM ' + tableName )+';');
        AddLine('end;');
        AddLine(Chr(13)+ chr(10));

        AddLine('destructor ' + sclassName +'.Destroy;');
        AddLine('begin');
        AddLine(TC+'inherited;');
        AddLine('end;');
        AddLine(Chr(13)+ chr(10));

        AddLine('procedure '+ SClassName +'.LoadFromXMLNode(const node: IXMLNode);');
        AddLine('begin');
        AddLine(TC+'inherited;');
        For ctr := 0 to dsTable.FieldCount-1 do begin
            sLine := '';
            sFieldName :=Propercase(dsTable.Fields[ctr].FieldName);
            if RequiredField(sFieldName) then begin
                sLine := XMLType(dsTable.Fields[ctr]);
                if sLine <> '' then begin
                  if sLine = 'Boolean' then
                    sLine := TC+ 'SetBooleanPropertyFromNode(node,''' + SFieldName+''');'
                  else if sLine = 'DateTime' then
                    sLine := TC+ 'SetDateTimePropertyFromNode(node,''' + SFieldName+''');'
                  else
                    sLine := TC+ 'SetPropertyFromNode(node,''' + SFieldName+''');';
                end;
            end;
            if sLine <> '' then AddLine(sLine);
        end;
        AddLine('end;');
        AddLine(Chr(13)+ chr(10));

        AddLine('procedure '+SClassName +'.SaveToXMLNode(Const node: IXMLNode);');
        AddLine('begin');
        AddLine(TC+'inherited;');
        For ctr := 0 to dsTable.FieldCount-1 do begin
            sLine := '';
            sFieldName :=Propercase(dsTable.Fields[ctr].FieldName);
            if RequiredField(sFieldName) then begin
                sLine := FieldType(dsTable.Fields[ctr]);
                if sLine <> '' then
                  sLine := TC+ 'AddXMLNode(node,'''+ SFieldName + ''' ,' + SFieldName + ');';
            end;
            if sLine <> '' then AddLine(sLine);
        end;
        AddLine('end;');
        AddLine(Chr(13)+ chr(10));

        AddLine('function ' + sClassname +'.ValidateData: Boolean ;');
        AddLine('begin');
        AddLine(TC+'Result := False;');
        AddLine(TC+'Resultstatus.Clear;');
        if FieldList.Selcount > 0 then begin
            for fCtr := 0 to FieldList.count -1 do begin
                if FieldList.Selected[fctr] then begin
                    sFieldName :=FieldList.Items[fctr];
                    sLine:= XMLType(dsTable.findfield(sFieldName));
                        if sLine = 'Integer' then begin
                            AddLine(TC+'if ' + sFieldName+ ' = 0 then begin');
                            AddLine(TC+TC+'Resultstatus.AddItem(False , rssError , 0,  ' + QuotedStr(sFieldname +' should not be 0') + ' , False );' );
                            AddLine(TC+TC+'Exit;');
                            AddLine(TC+'end;');
                        end else if sLine =  'Float' then begin
                            AddLine(TC+'if ' + sFieldName+ ' = 0 then begin');
                            AddLine(TC+TC+'Resultstatus.AddItem(False , rssError , 0,  ' + QuotedStr(sFieldname +' should not be 0') + ' , False );' );
                            AddLine(TC+TC+'Exit;');
                            AddLine(TC+'end;');
                        end else if sLine =  'DateTime' then begin
                            AddLine(TC+'if ' + sFieldName+ ' = 0 then begin');
                            AddLine(TC+TC+'Resultstatus.AddItem(False , rssError , 0,  ' + QuotedStr(sFieldname +' should not be blank') + ' , False );' );
                            AddLine(TC+TC+'Exit;');
                            AddLine(TC+'end;');
                        end else if sLine = 'string' then begin
                            AddLine(TC+'if ' + sFieldName+ ' = '''' then begin');
                            AddLine(TC+TC+'Resultstatus.AddItem(False , rssError , 0,  ' + QuotedStr(sFieldname +' should not be blank') + ' , False );' );
                            AddLine(TC+TC+'Exit;');
                            AddLine(TC+'end;');
                        end;
                end;
            end;
        end;
        AddLine(TC+'Result := True;');
        AddLine('end;');
        AddLine(Chr(13)+ chr(10));

        AddLine('function ' + sClassname +'.Save: Boolean ;');
        AddLine('begin');
        AddLine(TC+'Result := False;');
        AddLine(TC+'if not ValidateData then Exit;');
        AddLine(TC+'Result := inherited Save;');
        AddLine('end;');
        AddLine(Chr(13)+ chr(10));

        AddLine('procedure ' + sClassName +'.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);');
        AddLine('begin');
        AddLine(TC+'inherited;');
        AddLine('end;');
        AddLine(Chr(13)+ chr(10));

        AddLine('procedure ' + sClassName +'.DoFieldOnChange(Sender: TField);');
        AddLine('begin');
        AddLine(TC+'inherited;');
        AddLine('end;');
        AddLine(Chr(13)+ chr(10));

        AddLine('function ' + sClassName +'.GetSQL: string;');
        AddLine('begin');
        AddLine(TC+'Result := inherited GetSQL;');
        AddLine('end;');
        AddLine(Chr(13)+ chr(10));

        AddLine('class function ' + sClassName +'.GetIDField: string;');
        AddLine('begin');
        AddLine(TC+'Result := ' +quotedStr(sKeyField));
        AddLine('end;');
        AddLine(Chr(13)+ chr(10));

        AddLine('class function ' + sClassName +'.GetBusObjectTablename: string;');
        AddLine('begin');
        AddLine(TC+'Result:= ' + '''' + tableName + ''';');
        AddLine('end;');
        AddLine(Chr(13)+ chr(10));

        AddLine('function ' + sClassName + '.DoAfterPost(Sender: TDatasetBusObj): Boolean;');
        AddLine('begin');
        AddLine(TC+'Result := inherited DoAfterPost(Sender);');
        AddLine('end;');
        AddLine(Chr(13)+ chr(10));

        AddLine('{Property Functions}');

        For ctr := 0 to dsTable.FieldCount-1 do begin
            sLine := '';
            sFieldName :=Propercase(dsTable.Fields[ctr].FieldName);
            if RequiredField(sFieldName) then begin
                sLine := FieldType(dsTable.Fields[ctr]);
                if sLine <> '' then
                    sLine := 'function  ' + sClassName + '.Get' +AddSpace(sFieldName) +': ' + sLine +'; ' +
                             'begin Result := Get' + XMLType(dsTable.Fields[ctr])+'Field(' + QuotedStr(sfieldName) +');'+
                             'end;';
            end;
            if sLine <> '' then AddLine(sLine);
        end;
        For ctr := 0 to dsTable.FieldCount-1 do begin
            sLine := '';
            sFieldName :=Propercase(dsTable.Fields[ctr].FieldName);
            if RequiredField(sFieldName) then begin
                sLine := FieldType(dsTable.Fields[ctr]);
                if sLine <> '' then
                    sLine := 'procedure ' + sClassName + '.Set' +AddSpace(sFieldName) +'(const Value: ' + sLine +'); ' +
                             'begin Set' + XMLType(dsTable.Fields[ctr])+'Field(' + AddSpace(QuotedStr(sfieldName), fifieldLength+2) +' , Value);'+
                             'end;';
            end;
            if sLine <> '' then AddLine(sLine);
        end;
        AddLine(Chr(13)+ chr(10));
        AddLine('initialization');
        AddLine(TC+'RegisterClass(' + sClassName+ ');');
        AddLine(Chr(13)+ chr(10));
        AddLine('end.');
      Finally

        CloseFile(F);
        //Self.close;
      End;
    except
      on E: Exception do begin
        MessageDlg( E.Message, mtWarning, [mbOK], 0);
      end;
    end;
end;
Function tForm1.AddSpace(const Data:String; ficount :Integer = 0):STring;
begin
  result := data;
    if length(data) > fifieldLength then Exit;
    if ficount = 0 then ficount := fifieldLength;
    if fiCount <= 0 then Exit;
    Result := Copy(Data + replicatestr(' ' , fiCount) , 1, fiCount);
end;
Function TForm1.ReplicateStr(Const Value :String; Count :Integer):String;
var
    ctr :Integer;
begin
    Result := '';
    if count = 0 then Exit;
    if Value = '' then Exit;
    For ctr := 1 to Count do
        Result := Result+Value;
end;
Function TForm1.isFileNameValid :Boolean;
begin
  if txtFileName.Text <> '' then
    if pos('.' , txtFileName.Text) = 0 then txtFileName.Text := txtFileName.Text + '.pas'
    else if pos('.PAS' , UPPERCASE(txtFileName.Text)) = 0 then txtFileName.Text := copy(txtFileName.Text , 1,pos('.' , txtFileName.Text)) + '.pas';
    if fileExists(txtFileName.Text) then begin
        MessageDlg(Trim(txtFileName.Text) +' file already exists, can''t over write it' , mtError , [mbOK], 0);
        txtFileName.Text := '';
        Result := False;
        Exit;
    end;
    Result := true;
end;
Procedure TForm1.LstTablesClick(Sender: TObject);
var
    ctr:Integer;
    tableName :String;
    sFieldName :String;
begin
    if LstTables.itemindex = -1 then Exit;
    tableName := LstTables.Items[LstTables.ItemIndex];
    txtClassName.Text:= replaceStr(tableName , 'tbl' , 'T');
    if directoryexists('d:\temp\to be deleted') then
      txtFileName.Text := 'd:\temp\to be deleted\'+ tableName +'.pas';
    if dsTable.Active then dsTable.Close;
    dsTable.SQL.Clear;
    dsTable.SQL.add('Select * from ' + tableName);
    dsTable.Open;
    FieldList.Clear;
        For ctr := 0 to dsTable.FieldCount-1 do begin
            //if dsTable.Fields[ctr].Datatype = ftAutoInc then
            if dsTable.Fields[ctr].AutoGenerateValue = arAutoInc then
                sKeyField :=Propercase(dsTable.Fields[ctr].FieldName);
        end;

    For ctr := 0 to dsTable.FieldCount-1 do begin
            sFieldName :=Propercase(dsTable.Fields[ctr].FieldName);
            if RequiredField(sFieldName) then begin
                FieldList.Items.Add(sFieldName);
            end;
        end;
end;

Procedure TForm1.Button1Click(Sender: TObject);
var
    ctr :Integer;
    strSQL :STring;
    fStr:String;
    tablename :String;
    AlterTables: TextFile;
    Qry :TMyQuery;
    strfield :String;
begin
      AssignFile(AlterTables, 'c:\temp\Altertables.txt');
      Rewrite(AlterTables);
    qry :=TMyQuery.Create(Self);
    With Qry do try
        connection := MyConnection;

        For ctr := 0 to LstTables.Count-1 do begin
            if Active then Close;
            SQL.clear;
            tablename :=LstTables.items[ctr];
            SQL.add('SHOW CREATE TABLE ' + tableName);
            Open;
            fSTr := '';
            strSQL := '';
            if recordcount > 0 then begin
                strSQL := fields[1].asString;
                if strSQL <> '' then
                    strSQL := AnsiReplaceStr(strSQL, 'CREATE TABLE', '');
                    strSQL := AnsiReplaceStr(strSQL, '`' +tablename +'` (', '');
                    if pos(') TYPE=' , strSQL) > 0 then
                        strSQL := copy(strSQL, 1, pos(') TYPE=' , strSQL)-1);
                    if pos('PRIMARY KEY' , strSQL) > 1 then
                        strSQL := copy(strSQL, 1, pos('PRIMARY KEY' , strSQL)-1);
                    While strSQL <> '' do begin
                        if pos(',' , strSQL) > 0 then begin
                            strField := Trim(copy(strSQL , 1, pos(',' , strSQL)-1));
                            strSQL := Trim(copy(strSQL ,  pos(',' , strSQL)+1 , length(strSQL)))
                        end else begin
                            strField := trim(strSQL);
                            strSQL := '';
                        end;

                        if strField <> '' then
                            if (pos(' unsigned ' , strField) > 0) and (pos(' int(11)' , strField)>0) then begin
                                if fSTR <> '' then fstr := fSTR+',';
                                fstr := fStr + '  change ' + copy(strField , 1, pos(' int' , strField)) +
                                '   '  +  AnsiReplaceStr(strField, 'unsigned', ' ');
                            end;
                    End;
            end;

            if fStr<> '' then begin
                strSQL := strSQL + ' Alter table ' + tablename +   fStr+';';
                Writeln(AlterTables, strSQL );
            End;

            close;
        end;
    finally
        CloseFile(AlterTables);
        if Active then close;
    End;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  tableName:String;
  s :String;
begin
    if not isFileNameValid then Exit;
    if LstTables.itemindex = -1 then Exit;
    tableName := LstTables.Items[LstTables.ItemIndex];
    if tableName = '' then exit;
    s:= 'erpfix_'+tablename+  '_' + ERPVersionnumber;
    s := 'Drop table if exists ' + s+';' +chr(13)+
          'create table ' + s +' like '+ tablename +' ;' +chr(13)+
          'insert ignore into '+ s +' select * from  ' + tablename +' ;' +chr(13)+
          '/* truncate ' + tablename +';' +chr(13)+
          ' insert ignore into '+ tablename +' select * from  ' + s +' ;*/' ;
    While true do
    try
      Clipboard.asText := s;
      Exit;
    Except
      on E:Exception do begin
        if MessageDlg('Error :' +e.message+chr(13)+chr(13)+'Try Again?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;
      end;
    end;

end;

Procedure TForm1.DNMSpeedButton1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    txtFormname.Text := Propercase(SaveDialog1.FileName);
  isFileNameValid;
end;

procedure TForm1.edtDatabaseExit(Sender: TObject);
begin
  if not SameText(MyConnection.Database,edtDatabase.Text) then begin
    MyConnection.Disconnect;
    MyConnection.Database := edtDatabase.Text;
    self.FormShow(self);
  end;
end;

function TForm1.ERPVersionnumber: String;
var
  Qry :TMyQuery;
begin
     qry :=TMyQuery.Create(Self);
    With Qry do try
        connection := MyConnection;
        SQL.text := 'select VersionToNo(Version) as  Version from tblupdatedetails';
        open;
        result := fieldbyname('Version').AsString
    finally
      freeandnil(qry);
    end;

end;

end.

