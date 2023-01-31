unit BusobjTRansComments;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  10/06/15  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TTransComments = class(TMSBusObj)
  private
    FdLastSeqNo:Integer;
    function GetTransID             : Integer   ;
    function GetTranstype           : string    ;
    function GetCommentID           : Integer   ;
    function GetSeqno               : Integer   ;
    procedure SetTransID             (const Value: Integer   );
    procedure SetTranstype           (const Value: string    );
    procedure SetCommentID           (const Value: Integer   );
    procedure SetSeqno               (const Value: Integer   );
    function GetLastSeqNo: Integer;
    procedure LastSeqnoCallback(const Sender: TBusObj; var Abort: Boolean);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoBeforeInsert(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;             override;

  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property TransID              :Integer     read GetTransID            write SetTransID         ;
    property Transtype            :string      read GetTranstype          write SetTranstype       ;
    property CommentID            :Integer     read GetCommentID          write SetCommentID       ;
    property Seqno                :Integer     read GetSeqno              write SetSeqno           ;
    Property LastSeqNo            :Integer     read GetLastSeqNo;
  end;


implementation


uses tcDataUtils, CommonLib;



  {TTransComments}

constructor TTransComments.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'TransComments';
  fSQL := 'SELECT * FROM tbltranscomments';
  SQLOrder := 'Seqno';
end;


destructor TTransComments.Destroy;
begin
  inherited;
end;


procedure TTransComments.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'TransID');
  SetPropertyFromNode(node,'Transtype');
  SetPropertyFromNode(node,'CommentID');
  SetPropertyFromNode(node,'Seqno');
end;


procedure TTransComments.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'TransID' ,TransID);
  AddXMLNode(node,'Transtype' ,Transtype);
  AddXMLNode(node,'CommentID' ,CommentID);
  AddXMLNode(node,'Seqno' ,Seqno);
end;


function TTransComments.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if TransID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Trans# should not be 0' , False );
    Exit;
  end;
  if CommentID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Comment# should not be 0' , False );
    Exit;
  end;
  if Seqno = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Seqno should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function TTransComments.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TTransComments.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TTransComments.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TTransComments.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TTransComments.GetIDField: string;
begin
  Result := 'ID'
end;


class function TTransComments.GetBusObjectTablename: string;
begin
  Result:= 'tbltranscomments';
end;


function TTransComments.DoAfterinsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterinsert(Sender);
  if not result then exit;
  Seqno := FdLastSeqNo+1;
end;

function TTransComments.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


function TTransComments.DoBeforeInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoBeforeInsert(Sender);
  if not result then exit;
  FdLastSeqNo := LastSeqNo;
end;

{Property Functions}
function  TTransComments.GetTransID         : Integer   ; begin Result := GetIntegerField('TransID');end;
function  TTransComments.GetTranstype       : string    ; begin Result := GetStringField('Transtype');end;
function  TTransComments.GetCommentID       : Integer   ; begin Result := GetIntegerField('CommentID');end;
function  TTransComments.GetSeqno           : Integer   ; begin Result := GetIntegerField('Seqno');end;
procedure TTransComments.SetTransID         (const Value: Integer   ); begin SetIntegerField('TransID'          , Value);end;
procedure TTransComments.SetTranstype       (const Value: string    ); begin SetStringField('Transtype'        , Value);end;
procedure TTransComments.SetCommentID       (const Value: Integer   ); begin SetIntegerField('CommentID'        , Value);end;
procedure TTransComments.SetSeqno           (const Value: Integer   ); begin SetIntegerField('Seqno'            , Value);end;
Procedure TTransComments.LastSeqnoCallback(Const Sender: TBusObj; Var Abort: Boolean);
begin
  if not (Sender is TTransComments) then exit;
  If TTransComments(Sender).SeqNo <> 0 Then
    If TTransComments(Sender).SeqNo > FdLastSeqNo Then FdLastSeqNo := TTransComments(Sender).SeqNo;
end;
Function TTransComments.GetLastSeqNo: Integer;
begin
  FdLastSeqNo := 0;
  try
    IterateRecords(LastSeqnoCallback)
  finally
    result := FdLastSeqNo;
  end;
End;

initialization
  RegisterClass(TTransComments);


end.
