unit BusObjProductPic;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  02/05/08  1.00.01  RM.  Initial Version.
  }

interface


uses BusObjBase, DB, Classes, XMLIntf,MyAccess;

type
  Tpartspics = class(TMSBusObj)
  private
    Function GetpartID         : Integer   ;
    Function GetPicText       :String    ;
    Function GetPicField      :TBlobField;
    Procedure SetpartID         (const Value: Integer   );

  Protected
    Procedure OnDataIDChange(const ChangeType: TBusObjDataChangeType);  override;
    Procedure DoFieldOnChange(Sender: TField);                          override;
    Function  GetSQL                             : string;              override;
    Function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  Public
    Class Function  GetIDField                   : string;              override;
    Class Function  GetBusObjectTablename        : string;              override;
    Constructor  Create(AOwner: TComponent);                            override;
    Destructor   Destroy;                                               override;
    Procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    Procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    Function     ValidateData: Boolean ;                                override;
    Function     Save: Boolean ;                                        override;
    Procedure    SetPicText(const Value:String;PassedConnection:TMyConnection);
  Published
    property partID          :Integer     read GetpartID        write SetpartID     ;
    Property PicField        :TBlobField  Read getPicField;
    Property PicText :string Read getPicText;
  end;

implementation

uses tcDataUtils, CommonLib,SysUtils,CommonDbLib;


      {Tpartspics}

Constructor Tpartspics.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'partspics';
  fSQL := 'SELECT * FROM tblpartspics';
end;


Destructor Tpartspics.Destroy;
begin
  inherited;
end;

Function Tpartspics.GetPicField:TBlobField;
begin
  Result := TBlobField(self.Dataset.FindField('PartPic'));
end;


Procedure Tpartspics.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'partID');
  SetBlobPropertyFromNode(node,'PicField','PicField');
end;


Procedure Tpartspics.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'partID' ,partID);
end;


Function Tpartspics.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if partID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'partID should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


Function Tpartspics.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


Procedure Tpartspics.OnDataIDChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


Procedure Tpartspics.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


Function Tpartspics.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


Class Function Tpartspics.GetIDField: string;
begin
  Result := 'partpicID'
end;


Class Function Tpartspics.GetBusObjectTablename: string;
begin
  Result:= 'tblpartspics';
end;


Function Tpartspics.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
Function  Tpartspics.GetpartID     : Integer   ; begin Result := GetIntegerField('partID');end;

Function  Tpartspics.GetPicText :String ;
var
  strsql :string;
begin
  strsql := 'SELECT * ,Hex(PartPic) as PicText FROM tblpartspics' +
                ' WHERE PartID = ' + IntToStr(Self.PartID) + ' ;';
  With GetNewDataSet(strsql, True) do try
    Result  := fieldByname('PicText').asString;
  finally
    if active then close; 
  end;
End;

Procedure Tpartspics.SetPicText(Const Value :String;PassedConnection:TMyConnection);
var
   strsql:string;
   qry:TMyQuery;
begin
  strsql := 'INSERT INTO `tblpartspics` (`PartPic`) VALUES ( 0x' + Value +  ')';
  qry := TMyQuery.Create(nil);
  qry.Connection := PassedConnection;
  try
    qry.sql.clear;
    qry.sql.Add(strsql);
    qry.Execute;
  finally
    FreeAndNil(qry);
  end;
End;

Procedure Tpartspics.SetpartID     (const Value: Integer   ); begin SetIntegerField('partID'      , Value);end;


initialization
  RegisterClass(Tpartspics);


end.
