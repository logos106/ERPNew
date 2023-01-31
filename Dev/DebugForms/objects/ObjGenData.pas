unit ObjGenData;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  21/07/10  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TGenData = class(TBusObj)
  private
    function GetDescription    : string    ;
    function GetValue1         : string    ;
    function GetValue2         : string    ;
    function GetValue3         : string    ;
    function GetValue4         : string    ;
    function GetValue5         : string    ;
    function GetEmployeeId     : Integer   ;
    procedure SetDescription    (const Value: string    );
    procedure SetValue1         (const Value: string    );
    procedure SetValue2         (const Value: string    );
    procedure SetValue3         (const Value: string    );
    procedure SetValue4         (const Value: string    );
    procedure SetValue5         (const Value: string    );
    procedure SetEmployeeId     (const Value: Integer   );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Class Procedure NewRec(xDescription:String = '' ;xValue1:String = '' ;xValue2:String = '' ;xValue3:String = '' ;xValue4:String = '' ;xValue5:String = '');
  published
    property Description     :string      read GetDescription   write SetDescription;
    property Value1          :string      read GetValue1        write SetValue1     ;
    property Value2          :string      read GetValue2        write SetValue2     ;
    property Value3          :string      read GetValue3        write SetValue3     ;
    property Value4          :string      read GetValue4        write SetValue4     ;
    property Value5          :string      read GetValue5        write SetValue5     ;
    property EmployeeId      :Integer     read GetEmployeeId    write SetEmployeeId ;
  end;


implementation


uses sysutils, tcDataUtils, CommonLib, CommonDbLib, AppEnvironment,
  FastFuncs;



  {TGenData}

constructor TGenData.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'GenData';
  fSQL := 'SELECT * FROM tblgendata';
end;


destructor TGenData.Destroy;
begin
  inherited;
end;


procedure TGenData.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Description');
  SetPropertyFromNode(node,'Value1');
  SetPropertyFromNode(node,'Value2');
  SetPropertyFromNode(node,'Value3');
  SetPropertyFromNode(node,'Value4');
  SetPropertyFromNode(node,'Value5');
  SetPropertyFromNode(node,'EmployeeId');
end;


procedure TGenData.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'Value1' ,Value1);
  AddXMLNode(node,'Value2' ,Value2);
  AddXMLNode(node,'Value3' ,Value3);
  AddXMLNode(node,'Value4' ,Value4);
  AddXMLNode(node,'Value5' ,Value5);
  AddXMLNode(node,'EmployeeId' ,EmployeeId);
end;


function TGenData.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function TGenData.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TGenData.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TGenData.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TGenData.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TGenData.GetIDField: string;
begin
  Result := 'ID'
end;


class function TGenData.GetBusObjectTablename: string;
begin
  Result:= 'tblgendata';
end;


function TGenData.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TGenData.GetDescription: string    ; begin Result := GetStringField('Description');end;
function  TGenData.GetValue1     : string    ; begin Result := GetStringField('Value1');end;
function  TGenData.GetValue2     : string    ; begin Result := GetStringField('Value2');end;
function  TGenData.GetValue3     : string    ; begin Result := GetStringField('Value3');end;
function  TGenData.GetValue4     : string    ; begin Result := GetStringField('Value4');end;
function  TGenData.GetValue5     : string    ; begin Result := GetStringField('Value5');end;
function  TGenData.GetEmployeeId : Integer   ; begin Result := GetIntegerField('EmployeeId');end;
procedure TGenData.SetDescription(const Value: string    ); begin SetStringField('Description' , Value);end;
procedure TGenData.SetValue1     (const Value: string    ); begin SetStringField('Value1'      , Value);end;
procedure TGenData.SetValue2     (const Value: string    ); begin SetStringField('Value2'      , Value);end;
procedure TGenData.SetValue3     (const Value: string    ); begin SetStringField('Value3'      , Value);end;
procedure TGenData.SetValue4     (const Value: string    ); begin SetStringField('Value4'      , Value);end;
procedure TGenData.SetValue5     (const Value: string    ); begin SetStringField('Value5'      , Value);end;
procedure TGenData.SetEmployeeId (const Value: Integer   ); begin SetIntegerField('EmployeeId'      , Value);end;


class procedure TGenData.NewRec(xDescription:String = '' ;xValue1:String = '' ;xValue2:String = '' ;xValue3:String = '' ;
  xValue4:String = '' ;xValue5: String='');
begin
  With CommonDbLib.TempMyScript do try
    SQL.add('insert into tblGenData (Description,Value1,Value2,Value3,Value4,Value5,EmployeeId) '+
    ' Values (' + QuotedStr(xDescription)+',' +
    QuotedStr(xValue1)+',' +
    QuotedStr(xValue2)+',' +
    QuotedStr(xValue3)+',' +
    QuotedStr(xValue4)+',' +
    QuotedStr(xValue5)+ ','+
    IntToStr(Appenv.Employee.EmployeeID)+')');
    Execute;
  finally
      Free;
  end;
end;

initialization
  RegisterClass(TGenData);
end.
