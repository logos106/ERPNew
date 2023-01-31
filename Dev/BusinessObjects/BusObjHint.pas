unit BusObjHint;

interface

uses BusObjBase;

Type
    TBusObjHint = class(TBusObj)
    Private
      Function GetShowHint	:	Boolean	;
      Function GetScreenLeft	:	Integer	;
      Function GetScreenTop	:	Integer	;
      Function GetScreenWidth	:	Integer	;
      Function GetScreenHeight:	Integer	;
      Function getUserId     :   Integer;
      Procedure SetShowHint(Const     Value :	Boolean	);
      Procedure SetScreenLeft(Const   Value :	Integer	);
      Procedure SetScreenTop(Const    Value :	Integer	);
      Procedure SetScreenWidth(Const  Value :	Integer	);
      Procedure SetScreenHeight(Const Value :	Integer	);
      Procedure SetUserId(Const      Value : Integer);
    Protected
      Function    GetSQL      : string; override;
      Function    GetIDField  : String; Override;
      Function    getId       : integer;override;
    Public
    Published
      Property	ShowHint	:	Boolean	Read GetShowHint	    Write SetShowHint;
      Property	ScreenLeft	:	Integer	Read GetScreenLeft	    Write SetScreenLeft;
      Property	ScreenTop	:	Integer	Read GetScreenTop	    Write SetScreenTop;
      Property	ScreenWidth	:	Integer	Read GetScreenWidth	    Write SetScreenWidth;
      Property	ScreenHeight:	Integer	Read GetScreenHeight	Write SetScreenHeight;
      Property  UserId      :   Integer Read GetUserId          Write SetUserId;
    End;

    TBusObjHelpNotes = class(TBusObj)
    Private
		    Function GetShowHint	:	Boolean	;
        Function getComponentname     :   String;
        Function getHeading     :   String;
        Function getParentName     :   String;

        Procedure SetComponentname(Const      Value : String);
        Procedure SetHeading(Const      Value : String);
        Procedure SetParentName(Const      Value : String);
        Procedure SetShowHint(Const      Value : Boolean);
    Protected
        Function    GetSQL      : string; override;
        Function    GetIDField  : String; Override;
        Function    getId       : integer;override;
    Public
        Procedure Hidealloftheform;
    Published
        Property    Componentname     :   String  Read GetComponentname         Write SetComponentname;
        Property    Heading     :   String  Read GetHeading         Write SetHeading;
        Property    ParentName     :   String  Read GetParentName         Write SetParentName;
        Property    ShowHint     :   Boolean  Read GetShowHint         Write SetShowHint;
    End;

implementation

uses FastFuncs,Sysutils,  db, AppEnvironment;


Function TBusObjHint.GetShowHint:Boolean;
	//Result := getBooleanField('ShowHint');
    //Result := employeeObj.employee.ShowHint;
var
    strSql :String ;
begin
	//SetBooleanField('ShowHint',Value);
    strSql := 'Select ShowHints from tblpersonalpreferences  ' ;
    strSql := strSql + ' where employeeId = ' + FastFuncs.IntToStr(AppEnv.Employee.EmployeeID);
    with getNewDataset(strSQL) do try
        REsult := fieldByname('Showhints').asBoolean;
    finally
        Close;
        Free;
    end;

end;
Function TBusObjHint.GetScreenLeft:Integer;
begin
	Result := getIntegerField('ScreenLeft');
end;
Function TBusObjHint.GetScreenTop:Integer;
begin
	Result := getIntegerField('ScreenTop');
end;
Function TBusObjHint.GetScreenWidth:Integer;
begin
	Result := getIntegerField('ScreenWidth');
end;
Function TBusObjHint.GetScreenHeight:Integer;
begin
	Result := getIntegerField('ScreenHeight');
end;

Procedure TBusObjHint.SetShowHint(Const Value :Boolean);
var
    strSql :String ;
begin
	//SetBooleanField('ShowHint',Value);
    strSql := 'update tblpersonalpreferences Set ShowHints = ' ;
    if Value then StrSql := StrSql + '''T''' else StrSql := StrSql + '''F''' ;
    strSql := strSql + ' where employeeId = ' + FastFuncs.IntToStr(AppEnv.Employee.EmployeeID);
    getNewDataset(strSQL);
end;
Procedure TBusObjHint.SetScreenLeft(Const Value :Integer);
begin
	SetIntegerField('ScreenLeft',Value);
end;
Procedure TBusObjHint.SetScreenTop(Const Value :Integer);
begin
	SetIntegerField('ScreenTop',Value);
end;
Procedure TBusObjHint.SetScreenWidth(Const Value :Integer);
begin
	SetIntegerField('ScreenWidth',Value);
end;
Procedure TBusObjHint.SetScreenHeight(Const Value :Integer);
begin
	SetIntegerField('ScreenHeight',Value);
end;
Function TBusObjHint.GetSQL: string;
begin
  Result := '';
  if fSQL = '' then fSQL := 'Select * from tblHelpnotesScreenPosition';
  if fSQL <> '' then Result := fSQL;
  if fSQLSelect <> '' then Result := Result + ' WHERE ' + fSQLSelect;
end;
Function TBusObjHint.GetUserId:Integer;
begin
	Result := getIntegerField('UserId');
end;
Procedure TBusObjHint.SetUserID(Const Value :Integer );
begin
	SetIntegerField('UserId',Value);
end;
Procedure TBusObjHelpNotes.Hidealloftheform;
var
    dt :TDataset;
begin
    Showhint := False;
    postDb;
    (*strSql := 'Update   tblHelpNotes set Showhint = "F" where  ParentName = ' + quotedStr(Self.ParentName);
    GetNewDataSet(strSQL);    *)
    dt :=getNewDataset('select HelpNoteID, Showhint from tblHelpNotes where  ParentName = ' + quotedStr(Self.ParentName) + 'and HelpNoteID <>' + FastFuncs.IntToStr(self.ID) );
    With dt  do Try
        While Eof = False do begin
            Edit;
            FieldByname('Showhint').asString := 'F';
            Post;
            Next;
        end;
    Finally
        close;
        Free;
    end;
end;
Function TBusObjHint.GetIDField :String ;
begin
    Result := 'UserId';
end;

Function  TBusObjHint.getId: integer;
begin
    Result := getIntegerfield(IDFieldName);
end;

Function TBusObjHelpNotes.GetSQL: string;
begin
  Result := '';
  if fSQL = '' then fSQL := 'Select * from tblHelpNotes';
  if fSQL <> '' then Result := fSQL;
  if fSQLSelect <> '' then Result := Result + ' WHERE ' + fSQLSelect;
end;
Function TBusObjHelpNotes.GetIDField :String ;
begin
    Result := 'HelpNoteID';
end;
Function  TBusObjHelpNotes.getId: integer;
begin
    Result := getIntegerfield(IDFieldName);
end;
Function TBusObjHelpNotes.GetComponentname:String;
begin
	Result := getStringField('Componentname');
end;
Procedure TBusObjHelpNotes.SetComponentname(Const Value :String );
begin
	SetStringField('Componentname',Value);
end;
Function TBusObjHelpNotes.GetParentName:String;
begin
	Result := getStringField('ParentName');
end;
Procedure TBusObjHelpNotes.SetParentName(Const Value :String );
begin
	SetStringField('ParentName',Value);
end;
Function TBusObjHelpNotes.GetShowHint:Boolean;
begin
	Result := getBooleanField('ShowHint');
end;
Procedure TBusObjHelpNotes.SetShowHint(Const Value :Boolean );
begin
	SetBooleanField('ShowHint',Value);
end;
Function TBusObjHelpNotes.GetHeading:String;
begin
	Result := getStringField('Heading');
end;
Procedure TBusObjHelpNotes.SetHeading(Const Value :String );
begin
	SetStringField('Heading',Value);
end;
end.
