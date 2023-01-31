unit BusObjAccountPosting;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  13/06/08  1.00.00  A  Initial Version.
  }


interface


uses
  BusObjBase, DB, Classes, XMLDoc, XMLIntf, BusObjAccountPostingDetail, MyAccess,ERPdbComponents;


type

  TAccountPosting = class(TMSBusObj)
  private
    allLinesValid: boolean;
    debitSum,
    creditSum: double;
    function GetDate                : TDateTime ;
    function GetSourceName          : string    ;
    function GetSourceId            : Integer   ;
    function GetDescription         : string    ;
    function GetEmployeeId          : Integer   ;
    function GetEmployeeName        : string    ;
    function GetActive              : Boolean   ;
    procedure SetDate                (const Value: TDateTime );
    procedure SetSourceName          (const Value: string    );
    procedure SetSourceId            (const Value: Integer   );
    procedure SetDescription         (const Value: string    );
    procedure SetEmployeeId          (const Value: Integer   );
    procedure SetEmployeeName        (const Value: string    );
    procedure SetActive              (const Value: Boolean   );
    function GetLines: TAccountpostingDetail;
    Procedure ValidateLinesCallback(Const Sender: TBusObj; var Abort: boolean);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    procedure InitializeNewObject; override;
    function  GetId: integer; override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    property Lines: TAccountPostingDetail read GetLines;
    class procedure DeletePosting(const aSourceName: string; aSourceId: integer;Conn: TCustomMyConnection);

    procedure New; override;
    procedure AddPosting(const aCreditDebittype:String;  Const aDeptClassName, aAccountName: string;
                         Const aDebitAmount, aCreditAmount: double; Const aDescription: string = ''; (*aProductName :String='';*)aProductID :Integer=0; asourcelineID:Integer=0);
  published
    property Date                 :TDateTime   read GetDate               write SetDate            ;
    property SourceName           :string      read GetSourceName         write SetSourceName      ;
    property SourceId             :Integer     read GetSourceId           write SetSourceId        ;
    property Description          :string      read GetDescription        write SetDescription     ;
    property EmployeeId           :Integer     read GetEmployeeId         write SetEmployeeId      ;
    property EmployeeName         :string      read GetEmployeeName       write SetEmployeeName    ;
    property Active               :Boolean     read GetActive             write SetActive          ;
  end;

const
  AccountPostingSource_Manufacturing = 'Manufacturing';


implementation


uses MyScript, SysUtils, CommonLib, LogLib, DbSharedObjectsObj , Math;



  {TAccountPosting}

constructor TAccountPosting.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'AccountPosting';
  fSQL := 'SELECT * FROM tblaccountposting';
end;


destructor TAccountPosting.Destroy;
begin
  inherited;
end;


procedure TAccountPosting.LoadFromXMLNode(const node: IXMLNode);
var
  LinesNode: IXMLNode;
  x: integer;
begin
  inherited;
  SetDateTimePropertyFromNode(node,'Date');
  SetPropertyFromNode(node,'SourceName');
  SetPropertyFromNode(node,'SourceId');
  SetPropertyFromNode(node,'Description');
  SetPropertyFromNode(node,'EmployeeId');
  SetPropertyFromNode(node,'EmployeeName');
  SetBooleanPropertyFromNode(node,'Active');

  { delete existing lines if they exist }
  while Lines.Count > 0 do Lines.Delete;
  LinesNode := node.ChildNodes.FindNode('lines');
  if Assigned(LinesNode) then begin
    for x := 0 to LinesNode.ChildNodes.Count - 1 do begin
      Lines.New;
      Lines.LoadFromXMLNode(LinesNode.ChildNodes[x]);
      Lines.Postdb;
    end;
  end;
end;


procedure TAccountPosting.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Date' ,Date);
  AddXMLNode(node,'SourceName' ,SourceName);
  AddXMLNode(node,'SourceId' ,SourceId);
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'EmployeeId' ,EmployeeId);
  AddXMLNode(node,'EmployeeName' ,EmployeeName);
  AddXMLNode(node,'Active' ,Active);
  Lines.XMLPropertyNode := node.AddChild('lines');
  Lines.XMLPropertyName:= Lines.XMLNodeName;
  Lines.IterateRecords(GetPropertyXMLCallback);
end;


function TAccountPosting.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if Date = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Date should not be blank' , False );
    Exit;
  end;
  if SourceId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'SourceId should not be 0' , False );
    Exit;
  end;
  allLinesValid := true;
  debitSum:= 0;
  creditSum:= 0;
  Lines.IterateRecords(ValidateLinesCallback);
  if not allLinesValid then Exit;
  if not SameValue(CommonLib.Round(debitSum,RoundPlacesGeneral) , CommonLib.Round(creditSum,RoundPlacesGeneral), 0.00001) then begin
    Resultstatus.AddItem(False , rssError , 0,  'Posting is out of balance' , False );
    Exit;
  end;
  Result := True;
end;


function TAccountPosting.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TAccountPosting.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TAccountPosting.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TAccountPosting.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TAccountPosting.GetIDField: string;
begin
  Result := 'AccountPostingId'
end;


class function TAccountPosting.GetBusObjectTablename: string;
begin
  Result:= 'tblaccountposting';
end;


function TAccountPosting.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TAccountPosting.GetDate            : TDateTime ; begin Result := GetDateTimeField('Date');end;
function  TAccountPosting.GetSourceName      : string    ; begin Result := GetStringField('SourceName');end;
function  TAccountPosting.GetSourceId        : Integer   ; begin Result := GetIntegerField('SourceId');end;
function  TAccountPosting.GetDescription     : string    ; begin Result := GetStringField('Description');end;
function  TAccountPosting.GetEmployeeId      : Integer   ; begin Result := GetIntegerField('EmployeeId');end;
function  TAccountPosting.GetEmployeeName    : string    ; begin Result := GetStringField('EmployeeName');end;
function  TAccountPosting.GetActive          : Boolean   ; begin Result := GetBooleanField('Active');end;
procedure TAccountPosting.SetDate            (const Value: TDateTime ); begin SetDateTimeField('Date'             , Value);end;
procedure TAccountPosting.SetSourceName      (const Value: string    ); begin SetStringField('SourceName'       , Value);end;
procedure TAccountPosting.SetSourceId        (const Value: Integer   ); begin SetIntegerField('SourceId'         , Value);end;
procedure TAccountPosting.SetDescription     (const Value: string    ); begin SetStringField('Description'      , Value);end;
procedure TAccountPosting.SetEmployeeId      (const Value: Integer   ); begin SetIntegerField('EmployeeId'       , Value);end;
procedure TAccountPosting.SetEmployeeName    (const Value: string    ); begin SetStringField('EmployeeName'     , Value);end;
procedure TAccountPosting.SetActive          (const Value: Boolean   ); begin SetBooleanField('Active'           , Value);end;


function TAccountPosting.GetLines: TAccountPostingDetail;
begin
  result:= TAccountpostingDetail(Container.ItemByClass(TAccountpostingDetail,false));
  if not Assigned(result) then begin
    result:= TAccountpostingDetail.Create(nil);
    Container.Add(result);
    result.Connection:= self.Connection;
    result.LoadSelect('AccountPostingId = ' + IntToStr(self.ID));
  end
  else begin
    if not result.DatasetActive then
      result.LoadSelect('AccountPostingId = ' + IntToStr(self.ID));
  end;
end;

procedure TAccountPosting.ValidateLinesCallback(const Sender: TBusObj;
  var Abort: boolean);
begin
  if not Sender.ValidateData then begin
    Abort:= true;
    allLinesValid:= false;
  end
  else begin
    debitSum:= debitSum + TAccountPostingDetail(Sender).DebitAmount;
    creditSum:= creditSum + TAccountPostingDetail(Sender).CreditAmount;
  end;
end;
class procedure TAccountPosting.DeletePosting(const aSourceName: string;aSourceId: integer; Conn: TCustomMyConnection);
var
  script: TERPScript;
begin
  script:= DbSharedObj.GetScript(conn);
  try
    (*script.SQL.Add('delete from tblaccountpostingdetail');
    script.SQL.Add('where AccountPostingId = ');
    script.SQL.Add('(select AccountPostingId from tblaccountposting');
    script.SQL.Add('where SourceName = ' + QuotedStr(aSourceName));
    script.SQL.Add('and SourceId = ' + IntToStr(aSourceId) +');');

    script.SQL.Add('delete from tblaccountposting');
    script.SQL.Add('where SourceName = ' + QuotedStr(aSourceName));
    script.SQL.Add('and SourceId = ' + IntToStr(aSourceId) +';');*)
    script.SQL.clear;
    script.SQL.Add('delete  APD.* ' +
                  ' from tblaccountpostingdetail APD  ' +
                  ' inner join tblaccountposting AP on APD.AccountPostingId = AP.AccountPostingId  ' +
                  ' where AP.SourceName = ' + QuotedStr(aSourceName) +'  and AP.SourceId = ' + IntToStr(aSourceId) +';');
    script.SQL.Add('delete  AP.*   ' +
                  ' from tblaccountposting AP   ' +
                  ' where AP.SourceName = ' + QuotedStr(aSourceName) +'  and AP.SourceId = ' + IntToStr(aSourceId) +';');
    script.Execute;
  finally
    DbSharedObj.ReleaseObj(script);
  end;
end;

procedure TAccountPosting.InitializeNewObject;
begin
  inherited;
  if self.Id < 1 then
    self.PostDb;
end;

procedure TAccountPosting.New;
begin
  inherited;
  InitializeNewObject;
end;

function TAccountPosting.GetId: integer;
begin
  result:= GetIntegerField('AccountPostingId');
end;

procedure TAccountPosting.AddPosting(const aCreditDebittype:String;Const aDeptClassName, aAccountName: string;
                         Const aDebitAmount, aCreditAmount: double; Const aDescription: string = ''; (*aProductName :String='';*)aProductID :Integer=0; asourcelineID:Integer=0);
begin
  Lines.New;
  Lines.CreditDebittype := aCreditDebittype;
  Lines.DeptClassName:= aDeptClassName;
  Lines.AccountName:= aAccountName;
  Lines.DebitAmount:= aDebitAmount;
  Lines.CreditAmount:= aCreditAmount;
  Lines.ProductId := aProductId;
  if aDescription <> '' then Lines.Description:= aDescription;
  Lines.SourceLineID := aSourceLineID;
  Lines.PostDb;
end;

initialization
  RegisterClass(TAccountPosting);


end.
