unit BusobjRangeSelection;

  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  21/02/08  1.00.01  Binny  Initial Version.
  }

interface


uses BusObjBase, DB, Classes,  XMLDataObj, XMLDoc, XMLIntf;


type
  TRangeSeselectionMessages = class(TMSBusObj)
  private
    function GetRangeSelectionID       : Integer   ;
    function GetMessage                : string    ;
    function GetActive                 : Boolean   ;
    procedure SetRangeSelectionID       (const Value: Integer   );
    procedure SetMessage                (const Value: string    );
    procedure SetActive                 (const Value: Boolean   );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);   override;
    procedure DoFieldOnChange(Sender: TField);                           override;
    function  GetSQL: string;                                            override;
    function  DoAfterPost(Sender: TDatasetBusObj): Boolean;              override;
    function  DoAfterInsert(Sender: TDatasetBusObj): Boolean;            override;
  public
    constructor      Create(AOwner: TComponent);                         override;
    destructor       Destroy;                                            override;
    procedure        LoadFromXMLNode(const node: IXMLNode);              override;
    procedure        SaveToXMLNode(const node: IXMLNode);                override;
    function         ValidateData: Boolean;                              override;
    function         Save: Boolean;                                      override;
    Class function   GetIDField              : string;                   override;
    Class function   GetKeyStringField       : string;                   override;
    Class function   GetBusObjectTablename   : string;                   override;
  published
    property RangeSelectionID        :Integer     read GetRangeSelectionID      write SetRangeSelectionID   ;
    property Message                 :string      read GetMessage               write SetMessage            ;
    property Active                  :Boolean     read GetActive                write SetActive             ;
  end;

  TRangeSelection = class(TMSBusObj)
  private
    fXMLDataValidateObj: TXMLData;
    function GetRangeDescription       : string    ;
    function GetXMLData                : string    ;
    function GetActive                 : Boolean   ;
    Function GetLines                  : TRangeSeselectionMessages;
    Function XMLValidateData           : boolean;
    procedure SetRangeDescription       (const Value: string    );
    procedure SetXMLData                (const Value: string    );
    procedure SetActive                 (const Value: Boolean   );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);   override;
    procedure DoFieldOnChange(Sender: TField);                           override;
    function  GetSQL: string;                                            override;
    function  DoAfterPost(Sender: TDatasetBusObj): Boolean;              override;
    function  DoAfterInsert(Sender: TDatasetBusObj): Boolean;            override;
    function  DoBeforeInsert(Sender: TDatasetBusObj): Boolean;            override;
  public
    constructor      Create(AOwner: TComponent);                         override;
    destructor       Destroy;                                            override;
    procedure        LoadFromXMLNode(const node: IXMLNode);              override;
    procedure        SaveToXMLNode(const node: IXMLNode);                override;
    function         ValidateData: Boolean;                              override;
    function         Save: Boolean;                                      override;
    Class function   GetIDField              : string;                   override;
    Class function   GetKeyStringField       : string;                   override;
    Class function   GetBusObjectTablename   : string;                   override;

    Property Lines              : TRangeSeselectionMessages Read GetLines;
    Property XMLDataValidateObj : TXMLData                  Read fXMLDataValidateObj  Write fXMLDataValidateObj;
  published
    property RangeDescription        :string      read GetRangeDescription      write SetRangeDescription   ;
    property XMLData                 :string      read GetXMLData               write SetXMLData            ;
    property Active                  :Boolean     read GetActive                write SetActive             ;
  end;


implementation


uses CommonLib, FastFuncs ;



{ TRangeSelection }

constructor TRangeSelection.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'MarketingRangeSelection';
  fSQL := 'SELECT * FROM tblmarketingrangeselection';
end;


Class function TRangeSelection.GetIDField: string;
begin
  Result := 'RangeSelectionId'
end;


Class function TRangeSelection.GetKeyStringField: string;
begin
  Result := ''
end;


Class function TRangeSelection.GetBusObjectTablename: string;
begin
  Result := 'tblmarketingrangeselection'
end;


destructor TRangeSelection.Destroy;
begin
  inherited;
end;


procedure TRangeSelection.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'RangeDescription');
  SetPropertyFromNode(node,'XMLData');
  SetPropertyFromNode(node,'Active');
end;


procedure TRangeSelection.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'RangeDescription' ,RangeDescription);
  AddXMLNode(node,'XMLData' ,XMLData);
  AddXMLNode(node,'Active' ,Active);
end;

Function TRangeSelection.XMLValidateData:Boolean;
var
    x:Integer;
    operator: string;
begin
    Result := True;
    x := 0;
    while XMLDataValidateObj.NodeExists('SQLSelect.Lines.Line' + IntToStr(x)) do begin
      with XMLDataValidateObj.Node['SQLSelect.Lines.Line' + IntToStr(x)] do begin
        if (Attribute['AndOr'].AsString = '') and (x > 0) then begin
          ResultStatus.AddItem(False, rssWarning , 0 , 'Please select AND / OR for this line');
          Result := false;
          Exit;
        end else if Attribute['FieldName'].AsString = '' then begin
          ResultStatus.AddItem(False, rssWarning , 0 , 'Please select a field for this line');
          Result := false;
          Exit;
        end else if Attribute['ConstantValue'].AsString = '' then begin
          operator := Attribute['Operator'].AsString;
          if (operator <> 'is blank') and (operator <> 'is not blank') and (operator <> 'all') then begin
            ResultStatus.AddItem(False, rssWarning , 0 , 'Please enter a value for this line');
            Result := false;
            Exit;
          end;
        end;
      end;
      Inc(x);
    end;

end;
function TRangeSelection.ValidateData: Boolean ;
begin
    Result := false;
    Resultstatus.Clear;
    if RangeDescription = '' then begin
        ResultStatus.AddItem(False, rssWarning , 0 , 'Description should not be blank');
        Exit;
    end;
    Result := XMLValidateData;
end;


function TRangeSelection.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  XMLData := XMLDataValidateObj.Text;
  PostDB;
  Result := inherited Save;
end;


procedure TRangeSelection.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TRangeSelection.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TRangeSelection.GetSQL: string;
begin
    Result := inherited GetSQL;
end;

function TRangeSelection.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
    Result := inherited DoAfterInsert(Sender);
end;
function TRangeSelection.DoBeforeInsert(Sender: TDatasetBusObj): Boolean;
begin
    Result := inherited DoBeforeInsert(Sender);
end;
function TRangeSelection.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
    Result := inherited DoAfterPost(Sender);
end;

Function TRangeSelection.GetLines : TRangeSeselectionMessages;
begin
    Result := TRangeSeselectionMessages(getContainerComponent(TRangeSeselectionMessages, ' RangeSelectionId = ' + IntToStr(Self.ID)));
end;
{Property functions}
function  TRangeSelection.GetRangeDescription   : string    ; begin Result := GetStringField('RangeDescription');end;
function  TRangeSelection.GetXMLData            : string    ; begin Result := GetStringField('XMLData');end;
function  TRangeSelection.GetActive             : Boolean   ; begin Result := GetBooleanField('Active');end;
procedure TRangeSelection.SetRangeDescription   (const Value: string    ); begin SetStringField('RangeDescription'    , Value);end;
procedure TRangeSelection.SetXMLData            (const Value: string    ); begin SetStringField('XMLData'             , Value);end;
procedure TRangeSelection.SetActive             (const Value: Boolean   ); begin SetBooleanField('Active'              , Value);end;


{ TRangeSeselectionMessages }

constructor TRangeSeselectionMessages.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'RangeSeselectionMessages';
  fSQL := 'SELECT * FROM tblmarketingrangeselectionmessages';
end;


Class function TRangeSeselectionMessages.GetIDField: string;
begin
  Result := 'MessageID'
end;


Class function TRangeSeselectionMessages.GetKeyStringField: string;
begin
  Result := ''
end;


Class function TRangeSeselectionMessages.GetBusObjectTablename: string;
begin
  Result := 'tblmarketingrangeselectionmessages'
end;


destructor TRangeSeselectionMessages.Destroy;
begin
  inherited;
end;


procedure TRangeSeselectionMessages.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'RangeSelectionID');
  SetPropertyFromNode(node,'Message');
  SetPropertyFromNode(node,'Active');
end;


procedure TRangeSeselectionMessages.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'RangeSelectionID' ,RangeSelectionID);
  AddXMLNode(node,'Message' ,Message);
  AddXMLNode(node,'Active' ,Active);
end;


function TRangeSeselectionMessages.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function TRangeSeselectionMessages.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TRangeSeselectionMessages.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TRangeSeselectionMessages.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TRangeSeselectionMessages.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


function TRangeSeselectionMessages.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
function TRangeSeselectionMessages.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
    Result := Inherited DoAfterInsert(Sender);
    if not result then exit;
    if assigned(Self.Owner) then
        if Self.Owner is TRangeSelection then
            RangeSelectionID :=   TRangeSelection(Self.Owner).Id;
end;
{Property functions}
function  TRangeSeselectionMessages.GetRangeSelectionID   : Integer   ; begin Result := GetIntegerField('RangeSelectionID');end;
function  TRangeSeselectionMessages.GetMessage            : string    ; begin Result := GetStringField('Message');end;
function  TRangeSeselectionMessages.GetActive             : Boolean   ; begin Result := GetBooleanField('Active');end;
procedure TRangeSeselectionMessages.SetRangeSelectionID   (const Value: Integer   ); begin SetIntegerField('RangeSelectionID'    , Value);end;
procedure TRangeSeselectionMessages.SetMessage            (const Value: string    ); begin SetStringField('Message'             , Value);end;
procedure TRangeSeselectionMessages.SetActive             (const Value: Boolean   ); begin SetBooleanField('Active'              , Value);end;


initialization
  RegisterClassOnce(TRangeSeselectionMessages);
  RegisterClassOnce(TRangeSelection);

end.
