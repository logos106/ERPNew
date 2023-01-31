unit BusobjWebAPIRequestLog;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  17/12/20  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TWebAPIRequestLog = class(TMSBusObj)
  private
    function GetDatenTimeStart    : TDateTime ;
    function GetDatenTimeEnd      : TDateTime ;
    function GetRequest           : string    ;
    procedure SetDatenTimeStart    (const Value: TDateTime );
    procedure SetDatenTimeEnd      (const Value: TDateTime );
    procedure SetRequest           (const Value: string    );
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
    Class Function NewEntry(aOwner:TComponent; aDatenTimeStart, aDatenTimeEnd:TDateTime; aRequest:String):Integer;
    Class Procedure  UpdateEntry(aOwner:TComponent; aID:Integer;aDatenTimeEnd:TDateTime);
    Class Procedure  ClearLog;
  published
    property DatenTimeStart     :TDateTime   read GetDatenTimeStart   write SetDatenTimeStart;
    property DatenTimeEnd       :TDateTime   read GetDatenTimeEnd     write SetDatenTimeEnd  ;
    property Request            :string      read GetRequest          write SetRequest       ;
  end;


implementation


uses tcDataUtils, CommonLib, sysutils, LogLib, CommonDbLib, AppEnvironment;



  {TWebAPIRequestLog}

class procedure TWebAPIRequestLog.ClearLog;
begin
  commondblib.ExecuteSQL('Truncate tblwebapirequestlog;');
end;

constructor TWebAPIRequestLog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'webapirequestlog';
  fSQL := 'SELECT * FROM tblwebapirequestlog';
end;


destructor TWebAPIRequestLog.Destroy;
begin
  inherited;
end;


procedure TWebAPIRequestLog.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetDateTimePropertyFromNode(node,'DatenTimeStart');
  SetDateTimePropertyFromNode(node,'DatenTimeEnd');
  SetPropertyFromNode(node,'Request');
end;


class function TWebAPIRequestLog.NewEntry(aOwner:TComponent; aDatenTimeStart,  aDatenTimeEnd: TDateTime; aRequest: String): Integer;
begin
try
  if not Appenv.companyprefs.EnableWebAPILoging then exit;

  With TWebAPIRequestLog.CreateWithNewConn(aOwner) do try
    Load(0);
    New;
    DatenTimeStart:= aDatenTimeStart;
    DatenTimeEnd:= aDatenTimeEnd;
    Request:= aRequest;
    PostDB;
    result := ID;
  finally
    Free;
  end;
Except
  on E : Exception do begin
    // ignore the exception
    logtext(E.message);
  end;
end;
end;

procedure TWebAPIRequestLog.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'DatenTimeStart' ,DatenTimeStart);
  AddXMLNode(node,'DatenTimeEnd' ,DatenTimeEnd);
  AddXMLNode(node,'Request' ,Request);
end;


function TWebAPIRequestLog.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TWebAPIRequestLog.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TWebAPIRequestLog.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TWebAPIRequestLog.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TWebAPIRequestLog.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TWebAPIRequestLog.GetIDField: string;
begin
  Result := 'ID'
end;


class function TWebAPIRequestLog.GetBusObjectTablename: string;
begin
  Result:= 'tblwebapirequestlog';
end;


function TWebAPIRequestLog.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TWebAPIRequestLog.GetDatenTimeStart: TDateTime ; begin Result := GetDateTimeField('DatenTimeStart');end;
function  TWebAPIRequestLog.GetDatenTimeEnd  : TDateTime ; begin Result := GetDateTimeField('DatenTimeEnd');end;
function  TWebAPIRequestLog.GetRequest       : string    ; begin Result := GetStringField('Request');end;
procedure TWebAPIRequestLog.SetDatenTimeStart(const Value: TDateTime ); begin SetDateTimeField('DatenTimeStart' , Value);end;
procedure TWebAPIRequestLog.SetDatenTimeEnd  (const Value: TDateTime ); begin SetDateTimeField('DatenTimeEnd'   , Value);end;
procedure TWebAPIRequestLog.SetRequest       (const Value: string    ); begin SetStringField('Request'        , Value);end;


class procedure TWebAPIRequestLog.UpdateEntry(aOwner: TComponent; aID: Integer;aDatenTimeEnd: TDateTime);
begin
  try
      if not Appenv.companyprefs.EnableWebAPILoging then exit;
      With TWebAPIRequestLog.CreateWithNewConn(aOwner) do try
        Load(aid);
        if count = 1 then begin
          DatenTimeEnd:= aDatenTimeEnd;
          PostDB;
        end;
      finally
        Free;
      end;
  Except
    on E : Exception do begin
      // ignore the exception
      logtext(E.message);
    end;
  end;
end;

initialization
  RegisterClass(TWebAPIRequestLog);


end.

