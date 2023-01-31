unit BusObjCashDrop;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  09/03/17  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TCashDrop = class(TMSBusObj)
  private
    function GetCashDropAt          : TDateTime ;
    function GetEmployeeId          : Integer   ;
    function GetTillID              : Integer   ;
    function GetEOP_ID              : Integer   ;
    function GetAmount              : Double    ;
    function GetEOPDOne             : Boolean   ;
    procedure SetCashDropAt          (const Value: TDateTime );
    procedure SetEmployeeId          (const Value: Integer   );
    procedure SetTillID              (const Value: Integer   );
    procedure SetEOP_ID              (const Value: Integer   );
    procedure SetAmount              (const Value: Double    );
    procedure SetEOPDOne             (const Value: Boolean   );
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
    Class function DoCashDrop(AOwner:Tcomponent; aAmount :double; iatillID:Integer; iaEmployeeId:Integer):Integer;
    Class Procedure OnEOP(AOwner:Tcomponent; aEOPID:Integer;aTillID :Integer);
  published
    property CashDropAt           :TDateTime   read GetCashDropAt         write SetCashDropAt      ;
    property EmployeeId           :Integer     read GetEmployeeId         write SetEmployeeId      ;
    property TillID               :Integer     read GetTillID             write SetTillID          ;
    property EOP_ID               :Integer     read GetEOP_ID             write SetEOP_ID          ;
    property Amount               :Double      read GetAmount             write SetAmount          ;
    property EOPDOne              :Boolean     read GetEOPDOne            write SetEOPDOne         ;
  end;


implementation


uses tcDataUtils, CommonLib, dateutils, sysutils;



  {TCashDrop}

constructor TCashDrop.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'CashDrop';
  fSQL := 'SELECT * FROM tblcashdrop';
end;


destructor TCashDrop.Destroy;
begin
  inherited;
end;


procedure TCashDrop.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetDateTimePropertyFromNode(node,'CashDropAt');
  SetPropertyFromNode(node,'EmployeeId');
  SetPropertyFromNode(node,'TillID');
  SetPropertyFromNode(node,'EOP_ID');
  SetPropertyFromNode(node,'Amount');
  SetBooleanPropertyFromNode(node,'EOPDOne');
end;


procedure TCashDrop.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'CashDropAt' ,CashDropAt);
  AddXMLNode(node,'EmployeeId' ,EmployeeId);
  AddXMLNode(node,'TillID' ,TillID);
  AddXMLNode(node,'EOP_ID' ,EOP_ID);
  AddXMLNode(node,'Amount' ,Amount);
  AddXMLNode(node,'EOPDOne' ,EOPDOne);
end;


function TCashDrop.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if CashDropAt = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'CashDropAt should not be blank' , True);
    Exit;
  end;
  if EmployeeId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'EmployeeId should not be 0' , True );
    Exit;
  end;
  if TillID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'TillID should not be 0' , True );
    Exit;
  end;
  Result := True;
end;


function TCashDrop.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TCashDrop.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


class procedure TCashDrop.OnEOP(AOwner:Tcomponent; aEOPID: Integer;aTillID :Integer);
var
  CashDrop : TCashDrop;
begin
  CashDrop := TCashDrop.CreateWithNewConn(AOwner);
  try
    CashDrop.loadSelect('TillID = ' + inttostr(aTillID)+' and EOPDOne ="F" ');
    if CashDrop.count > 0 then begin
      CashDrop.connection.beginTransaction;
      try
        CashDrop.first;
        While CashDrop.Eof =false do begin
          CashDrop.EOP_ID := aEOPID;
          CashDrop.EOPDOne := true;
          CashDrop.PostDB;
          CashDrop.Next;
        end;
        CashDrop.Connection.CommitTransaction;
      Except
        on E:Exception do begin
          CashDrop.Resultstatus.AddItem(False , rssError , 0,  'Saving CashDrop Failed : ' + E.message , True );
          CashDrop.Connection.RollbackTransaction;
        end;
      end;
    end;

  finally
    Freeandnil(CashDrop);
  end;
end;

procedure TCashDrop.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TCashDrop.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TCashDrop.GetIDField: string;
begin
  Result := 'ID'
end;


class function TCashDrop.GetBusObjectTablename: string;
begin
  Result:= 'tblcashdrop';
end;


function TCashDrop.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


class function TCashDrop.DoCashDrop(AOwner:Tcomponent; aAmount: double; iatillID: Integer;  iaEmployeeId:Integer): Integer;
var
  CashDrop : TCashDrop;
begin
  REsult := 0;
  CashDrop := TCashDrop.CreateWithNewConn(AOwner);
  try
    CashDrop.load(0);
    CashDrop.connection.beginTransaction;
    try
      CashDrop.New;
      CashDrop.CashDropAt := now;
      CashDrop.EmployeeId := iaEmployeeId;
      CashDrop.TillID :=iatillID;
      CashDrop.Amount := aAmount;
      CashDrop.EOPDOne := False;
      CashDrop.PostDb;
      CashDrop.Connection.CommitTransaction;
      Result := CashDrop.ID;
    Except
      on E:Exception do begin
        CashDrop.Resultstatus.AddItem(False , rssError , 0,  'Saving CashDrop Failed : ' + E.message , True );
        CashDrop.Connection.RollbackTransaction;
      end;
    end;

  finally
    Freeandnil(CashDrop);
  end;
end;

{Property Functions}
function  TCashDrop.GetCashDropAt      : TDateTime ; begin Result := GetDateTimeField('CashDropAt');end;
function  TCashDrop.GetEmployeeId      : Integer   ; begin Result := GetIntegerField('EmployeeId');end;
function  TCashDrop.GetTillID          : Integer   ; begin Result := GetIntegerField('TillID');end;
function  TCashDrop.GetEOP_ID          : Integer   ; begin Result := GetIntegerField('EOP_ID');end;
function  TCashDrop.GetAmount          : Double    ; begin Result := GetFloatField('Amount');end;
function  TCashDrop.GetEOPDOne         : Boolean   ; begin Result := GetBooleanField('EOPDOne');end;
procedure TCashDrop.SetCashDropAt      (const Value: TDateTime ); begin SetDateTimeField('CashDropAt'       , Value);end;
procedure TCashDrop.SetEmployeeId      (const Value: Integer   ); begin SetIntegerField('EmployeeId'       , Value);end;
procedure TCashDrop.SetTillID          (const Value: Integer   ); begin SetIntegerField('TillID'           , Value);end;
procedure TCashDrop.SetEOP_ID          (const Value: Integer   ); begin SetIntegerField('EOP_ID'           , Value);end;
procedure TCashDrop.SetAmount          (const Value: Double    ); begin SetFloatField('Amount'           , Value);end;
procedure TCashDrop.SetEOPDOne         (const Value: Boolean   ); begin SetBooleanField('EOPDOne'          , Value);end;


initialization
  RegisterClass(TCashDrop);


end.
