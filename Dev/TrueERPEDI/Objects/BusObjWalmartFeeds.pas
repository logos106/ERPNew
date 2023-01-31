unit BusObjWalmartFeeds;

  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  12/02/19  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  Twalmartfeedstatuserrors = class(TMSBusObj)
  private
    function GetFeedId              : Integer   ;
    function GetFeedStatusID        : Integer   ;
    function GetErrorType           : string    ;
    function GetErrorCode           : string    ;
    function GetErrorField          : string    ;
    function GetErrorDescription    : string    ;
    procedure SetFeedId              (const Value: Integer   );
    procedure SetFeedStatusID        (const Value: Integer   );
    procedure SetErrorType           (const Value: string    );
    procedure SetErrorCode           (const Value: string    );
    procedure SetErrorField          (const Value: string    );
    procedure SetErrorDescription    (const Value: string    );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
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
    property FeedId               :Integer     read GetFeedId             write SetFeedId          ;
    property FeedStatusID         :Integer     read GetFeedStatusID       write SetFeedStatusID    ;
    property ErrorType            :string      read GetErrorType          write SetErrorType       ;
    property ErrorCode            :string      read GetErrorCode          write SetErrorCode       ;
    property ErrorField           :string      read GetErrorField         write SetErrorField      ;
    property ErrorDescription     :string      read GetErrorDescription   write SetErrorDescription;
  end;

  Twalmartfeedstatus = class(TMSBusObj)
  private
    function GetFeedId                : Integer   ;
    function GetStatusDate            : TDateTime ;
    function GetFeedStatus            : string    ;
    function GetShipNode              : string    ;
    function GetSubmittedBy           : string    ;
    function GetFeedSubmissionDate    : string    ;
    function GetItemsReceived         : Integer   ;
    function GetItemsSucceeded        : Integer   ;
    function GetItemsFailed           : Integer   ;
    function GetItemsProcessing       : Integer   ;
    function GetOffset                : Integer   ;
    function GetApilimit              : Integer   ;
    procedure SetFeedId                (const Value: Integer   );
    procedure SetStatusDate            (const Value: TDateTime );
    procedure SetFeedStatus            (const Value: string    );
    procedure SetShipNode              (const Value: string    );
    procedure SetSubmittedBy           (const Value: string    );
    procedure SetFeedSubmissionDate    (const Value: string    );
    procedure SetItemsReceived         (const Value: Integer   );
    procedure SetItemsSucceeded        (const Value: Integer   );
    procedure SetItemsFailed           (const Value: Integer   );
    procedure SetItemsProcessing       (const Value: Integer   );
    procedure SetOffset                (const Value: Integer   );
    procedure SetApilimit              (const Value: Integer   );
    function getwalmartfeedstatuserrors: Twalmartfeedstatuserrors;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
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
    property FeedId                 :Integer     read GetFeedId               write SetFeedId            ;
    property StatusDate             :TDateTime   read GetStatusDate           write SetStatusDate        ;
    property FeedStatus             :string      read GetFeedStatus           write SetFeedStatus        ;
    property ShipNode               :string      read GetShipNode             write SetShipNode          ;
    property SubmittedBy            :string      read GetSubmittedBy          write SetSubmittedBy       ;
    property FeedSubmissionDate     :string      read GetFeedSubmissionDate   write SetFeedSubmissionDate;
    property ItemsReceived          :Integer     read GetItemsReceived        write SetItemsReceived     ;
    property ItemsSucceeded         :Integer     read GetItemsSucceeded       write SetItemsSucceeded    ;
    property ItemsFailed            :Integer     read GetItemsFailed          write SetItemsFailed       ;
    property ItemsProcessing        :Integer     read GetItemsProcessing      write SetItemsProcessing   ;
    property Offset                 :Integer     read GetOffset               write SetOffset            ;
    property Apilimit               :Integer     read GetApilimit             write SetApilimit          ;
    Property walmartfeedstatuserrors :Twalmartfeedstatuserrors read getwalmartfeedstatuserrors;
  end;
  TWalmartFeeds = class(TMSBusObj)
  private
    function GetFeeddate            : TDateTime ;
    function GetFeedData            : string    ;
    function GetFeedID              : string    ;
    function GetFeedType            : string    ;
    function GetfeedSource          : string    ;
    function GetfeedStatus          : string    ;
    function GetpartnerId           : string    ;
    function GetitemsReceived       : Integer;
    function GetItemsSucceeded        : Integer   ;
    function GetItemsFailed           : Integer   ;
    function GetItemsProcessing       : Integer   ;
    function GetmodifiedDtm           : TDateTime ;
    procedure SetFeeddate            (const Value: TDateTime );
    procedure SetFeedData            (const Value: string    );
    procedure SetFeedID              (const Value: string    );
    procedure SetFeedType            (const Value: string    );
    procedure SetfeedSource          (const Value: string    );
    procedure SetfeedStatus          (const Value: string    );
    procedure SetpartnerId           (const Value: string    );
    procedure SetitemsReceived       (const Value: Integer    );
    procedure SetItemsSucceeded        (const Value: Integer   );
    procedure SetItemsFailed           (const Value: Integer   );
    procedure SetItemsProcessing       (const Value: Integer   );
    procedure SetmodifiedDtm           (const Value: TDateTime );
    function getwalmartfeedstatus: Twalmartfeedstatus;
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
    Class function newFeed(aOwner:Tcomponent;aFeedData:String;aFeedAcknowledge:String):Integer;
    Class function PartnerFeedResponse(aOwner:Tcomponent;aFeedID:String;aresponse:String):Boolean;
    Class function PartnerFeedResponses(aOwner:Tcomponent;aBusObjEvent:TBusObjEvent;aresponse:String):Boolean;

  published
    property Feeddate             :TDateTime   read GetFeeddate           write SetFeeddate        ;
    property FeedData             :string      read GetFeedData           write SetFeedData        ;
    property FeedID               :string      read GetFeedID             write SetFeedID          ;
    property FeedType             :string      read GetFeedType           write SetFeedType        ;
    property feedSource           :string      read GetfeedSource         write SetfeedSource      ;
    property feedStatus           :string      read GetfeedStatus         write SetfeedStatus      ;
    property partnerId            :string      read GetpartnerId          write SetpartnerId       ;
    property itemsReceived        :Integer     read GetitemsReceived      write SetitemsReceived   ;
    property ItemsSucceeded         :Integer     read GetItemsSucceeded       write SetItemsSucceeded    ;
    property ItemsFailed            :Integer     read GetItemsFailed          write SetItemsFailed       ;
    property ItemsProcessing        :Integer     read GetItemsProcessing      write SetItemsProcessing   ;
    property modifiedDtm            :TDateTime   read GetmodifiedDtm          write SetmodifiedDtm       ;
    Property walmartfeedstatus :Twalmartfeedstatus read getwalmartfeedstatus;
  end;


implementation


uses tcDataUtils, CommonLib, sysutils, FeedAcknowledgement, CK_DLL_Const,
  PartnerFeedResponse, FeedRecordResponse, Walmart_Lib, tcConst, BusObjConst,Variants,
  LogLib;



  {TWalmartFeeds}

constructor TWalmartFeeds.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'WalmartFeeds';
  fSQL := 'SELECT * FROM tblwalmartfeeds';
end;


destructor TWalmartFeeds.Destroy;
begin
  inherited;
end;


procedure TWalmartFeeds.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetDateTimePropertyFromNode(node,'Feeddate');
  SetPropertyFromNode(node,'FeedData');
  SetPropertyFromNode(node,'FeedID');
  SetPropertyFromNode(node,'FeedType');
  SetPropertyFromNode(node,'feedSource');
  SetPropertyFromNode(node,'feedStatus');
  SetPropertyFromNode(node,'partnerId');
  SetPropertyFromNode(node,'itemsReceived');
  SetPropertyFromNode(node,'ItemsSucceeded');
  SetPropertyFromNode(node,'ItemsFailed');
  SetPropertyFromNode(node,'ItemsProcessing');
  SetDateTimePropertyFromNode(node,'modifiedDtm');
end;
class function TWalmartFeeds.PartnerFeedResponse(aOwner: Tcomponent; aFeedID,aresponse: String): Boolean;
var
  WalmartFeed :TWalmartFeeds;
    Doc: IXMLDocument;
    aItemStatusDetail :IXMLNode;
  //aItemStatusDetail :IXMLNode; //IXMLItemStatusDetail;
  //aPartnerFeedResponse: IXMLPartnerFeedResponse;
  ctr:Integer;
  function nodevalue(node :IXMLNode; nodename:String):Variant;
  var
    fs:String;
  begin
    fs:= '';
    try
      if node.ChildNodes.FindNode(nodename)<> nil then fs:= node.childnodes[nodename].NodeValue
      else if node.ChildNodes.FindNode(uppercase(nodename))<> nil then fs:= node.childnodes[uppercase(nodename)].NodeValue
      else if node.ChildNodes.FindNode(lowercase(nodename))<> nil then fs:= node.childnodes[lowercase(nodename)].NodeValue
      else fs := '';
    Except
      on E:EXception do begin
        logtext(NodeName +':' + E.Message+NL+
              node.xml);
      end;
    end;
    result := fs;
    logtext(NodeName +':' +result);
  end;
begin
  REsult := False;

  if trim(aFeedId) = '' then exit;
  doc:= TXMLDocument.Create(nil);
    doc.LoadFromXML(aresponse);
    doc.Active:= true;
    if doc.ChildNodes.FindNode('ItemStatusDetail') = nil then exit;
    aItemStatusDetail := doc.ChildNodes['ItemStatusDetail'];



  //aPartnerFeedResponse:= NewPartnerFeedResponse;
  //aItemStatusDetail := NewIItemStatusDetail;
  try
    //aPartnerFeedResponse := LoadXMLData(aresponse).GetDocBinding('ItemStatusDetail', TXMLPartnerFeedResponse, WALMART_TargetNameSpace) as IXMLPartnerFeedResponse;
    //aItemStatusDetail := LoadXMLData(aresponse).GetDocBinding('ItemStatusDetail', TXMLItemStatusDetail, WALMART_TargetNameSpace) ;

    //aPartnerFeedResponse := aItemStatusDetail.ItemStatusDetailMeta ;
(*    with aItemStatusDetail.ItemStatusDetailMeta do begin
      aPartnerFeedResponse :=LoadXMLData(XML).GetDocBinding('meta', TXMLItemStatusDetail, WALMART_TargetNameSpace) as IXMLItemStatusDetail;
    end;*)
  (*aPartnerFeedResponse := NewXMLDocument.GetDocBinding('meta',
                                          TXMLPartnerFeedResponse,
                                          WalmartTargetNamespace) as IXMLPartnerFeedResponse;*)

    //if aPartnerFeedResponse.feedid <> aFeedID then exit;
    if nodevalue(aItemStatusDetail.ChildNodes['meta'], 'feedId')<> afeedId then exit;

    WalmartFeed := TWalmartFeeds.CreateWithNewConn(aOwner);
    try
      WalmartFeed.loadselect('Feedid = '+Quotedstr(aFeedID));
      if WalmartFeed.count =0 then exit;

      WalmartFeed.connection.begintransaction;
      try
              if WalmartFeed.walmartfeedstatus.count =0 then begin
                WalmartFeed.walmartfeedstatus.New;
                WalmartFeed.walmartfeedstatus.StatusDate        := Now;
              end;
              WalmartFeed.walmartfeedstatus.FeedStatus        := nodevalue(aItemStatusDetail.ChildNodes['meta'],'feedStatus');
              WalmartFeed.walmartfeedstatus.ShipNode          := nodevalue(aItemStatusDetail.ChildNodes['meta'],'ShipNode');
              //WalmartFeed.walmartfeedstatus.SubmittedBy       := aItemStatusDetail.ChildNodes['meta'].ChildNodes['SubmittedBy'].NodeValue;
              //WalmartFeed.walmartfeedstatus.FeedSubmissionDate:= aItemStatusDetail.ChildNodes['meta'].ChildNodes['FeedSubmissionDate'].NodeValue;
              WalmartFeed.walmartfeedstatus.ItemsReceived     := nodevalue(aItemStatusDetail.ChildNodes['meta'],'itemsReceived');
              WalmartFeed.walmartfeedstatus.ItemsSucceeded    := nodevalue(aItemStatusDetail.ChildNodes['meta'],'itemsSucceeded');
              WalmartFeed.walmartfeedstatus.ItemsFailed       := nodevalue(aItemStatusDetail.ChildNodes['meta'],'itemsFailed');
              WalmartFeed.walmartfeedstatus.ItemsProcessing   := nodevalue(aItemStatusDetail.ChildNodes['meta'],'itemsProcessing');
              //WalmartFeed.walmartfeedstatus.Offset            := nodevalue(aItemStatusDetail.ChildNodes['meta'],'Offset');
              WalmartFeed.walmartfeedstatus.Apilimit          := nodevalue(aItemStatusDetail.ChildNodes['meta'],'limit');
              WalmartFeed.walmartfeedstatus.PostDB;
          if  aItemStatusDetail.ChildNodes['meta'].ChildNodes['ingestionErrors'].ChildNodes.count >0 then begin
            for ctr := 0 to aItemStatusDetail.ChildNodes['meta'].ChildNodes['ingestionErrors'].ChildNodes.count-1 do begin
              if not WalmartFeed.walmartfeedstatus.walmartfeedstatuserrors.locate('ErrorType;ErrorCode;ErrorField;ErrorDescription',
                          varArrayof([nodevalue(aItemStatusDetail.ChildNodes['meta'].ChildNodes['ingestionErrors'].childnodes[ctr],'type') ,
                                      nodevalue(aItemStatusDetail.ChildNodes['meta'].ChildNodes['ingestionErrors'].childnodes[ctr],'code') ,
                                      nodevalue(aItemStatusDetail.ChildNodes['meta'].ChildNodes['ingestionErrors'].childnodes[ctr],'Field'),
                                      nodevalue(aItemStatusDetail.ChildNodes['meta'].ChildNodes['ingestionErrors'].childnodes[ctr],'description')]), []) then begin
                  WalmartFeed.walmartfeedstatus.walmartfeedstatuserrors.New;
                  WalmartFeed.walmartfeedstatus.walmartfeedstatuserrors.ErrorType        := nodevalue(aItemStatusDetail.ChildNodes['meta'].ChildNodes['ingestionErrors'].childnodes[ctr],'type');
                  WalmartFeed.walmartfeedstatus.walmartfeedstatuserrors.ErrorCode        := nodevalue(aItemStatusDetail.ChildNodes['meta'].ChildNodes['ingestionErrors'].childnodes[ctr],'code');
                  WalmartFeed.walmartfeedstatus.walmartfeedstatuserrors.ErrorField       := nodevalue(aItemStatusDetail.ChildNodes['meta'].ChildNodes['ingestionErrors'].childnodes[ctr],'Field');
                  WalmartFeed.walmartfeedstatus.walmartfeedstatuserrors.ErrorDescription := nodevalue(aItemStatusDetail.ChildNodes['meta'].ChildNodes['ingestionErrors'].childnodes[ctr],'description');
                  WalmartFeed.walmartfeedstatus.walmartfeedstatuserrors.PostDB;
              end;
            end;
          end;
        WalmartFeed.connection.CommitTransaction;
      Except
        on E:Exception do begin
          WalmartFeed.connection.RollbackTransaction;
        end;
      end;
    finally
      Freeandnil(WalmartFeed);
    end;
  finally
     //Freeandnil(aFeedAcknowledgement);
  end;
end;

class function TWalmartFeeds.PartnerFeedResponses(aOwner: Tcomponent;  aBusObjEvent:TBusObjEvent;aresponse: String): Boolean;
var
  WalmartFeed :TWalmartFeeds;
  FeedRecordResponses: IXMLFeedRecordResponse;
  ctr:Integer;
begin
  result := False;
  FeedRecordResponses:= LoadXMLData(aresponse).GetDocBinding('list', TXMLFeedRecordResponse, WALMART_TargetNameSpace) as IXMLFeedRecordResponse;
  if FeedRecordResponses.Results.count =0 then exit;

  aBusObjEvent(nil, BusobjEvent_ToDo, BusobjEvent_ShowProgressbar);
  try
    for ctr := 0 to FeedRecordResponses.Results.count-1 do begin
      with FeedRecordResponses.Results.Feed[ctr] do begin
        if trim(feedid) <> '' then begin
          WalmartFeed := TWalmartFeeds.CreateWithNewConn(aOwner);
          try
            //WalmartFeed.BusObjEvent := aBusObjEvent;
            WalmartFeed.loadselect('FeedId = ' + quotedstr(feedID));
            WalmartFeed.connection.begintransaction;
            try
              if WalmartFeed.count =0 then begin
                WalmartFeed.New;
                WalmartFeed.Feedid := feedid;
                WalmartFeed.Feeddate:= Now;
              end;
              WalmartFeed.feedSource := feedSource;
              WalmartFeed.feedType := feedType;
              WalmartFeed.partnerId  := partnerId;
              WalmartFeed.itemsReceived := itemsReceived;
              WalmartFeed.itemsSucceeded := itemsSucceeded;
              WalmartFeed.itemsFailed := itemsFailed;
              WalmartFeed.itemsProcessing := itemsProcessing;
              WalmartFeed.feedStatus := feedStatus;
              WalmartFeed.feedDate := DateValue  (feedDate);
              WalmartFeed.modifiedDtm := DateValue  (modifiedDtm);
              WalmartFeed.Postdb;
              if not WalmartFeed.save then begin
                WalmartFeed.connection.RollbackTransaction;
                Exit;
              end;
              Result := true;
              WalmartFeed.connection.CommitTransaction;
            Except
              on E:Exception do begin
                WalmartFeed.connection.RollbackTransaction;
              end;
            end;
          finally
             Freeandnil(WalmartFeed);
          end;
        end;
      end;
      aBusObjEvent(nil, BusobjEvent_ToDo, BusobjEvent_ProgressbarProgress);
    end;


  finally
    aBusObjEvent(nil, BusobjEvent_ToDo, BusobjEvent_HideProgressbar);
  end;

end;

class Function TWalmartFeeds.newFeed(aOwner:Tcomponent;aFeedData, aFeedAcknowledge:String):Integer;
var
  WalmartFeed :TWalmartFeeds;
  aFeedAcknowledgement: IXMLFeedAcknowledgement;
begin
  REsult := 0;

  aFeedAcknowledgement:= NewFeedAcknowledgement;
  try
    aFeedAcknowledgement := LoadXMLData(aFeedAcknowledge).GetDocBinding('FeedAcknowledgement', TXMLFeedAcknowledgement, WALMART_TargetNameSpace) as IXMLFeedAcknowledgement;

    if trim(aFeedAcknowledgement.FeedId) = '' then exit;


    WalmartFeed := TWalmartFeeds.CreateWithNewConn(aOwner);
    try
      WalmartFeed.load(0);
      WalmartFeed.connection.begintransaction;
      try
        WalmartFeed.New;
        WalmartFeed.Feeddate:= Now;
        WalmartFeed.FeedData:= aFeedData;
        WalmartFeed.FeedID:= trim(aFeedAcknowledgement.FeedId);
        WalmartFeed.FeedType:= aFeedAcknowledgement.AdditionalAttributes.Type_;
        WalmartFeed.Postdb;
        if not WalmartFeed.save then begin
          WalmartFeed.connection.RollbackTransaction;
          Exit;
        end;
        Result := WalmartFeed.ID;
        WalmartFeed.connection.CommitTransaction;
      Except
        on E:Exception do begin
          WalmartFeed.connection.RollbackTransaction;
        end;
      end;
    finally
      Freeandnil(WalmartFeed);
    end;
  finally
     //Freeandnil(aFeedAcknowledgement);
  end;
end;

procedure TWalmartFeeds.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Feeddate' ,Feeddate);
  AddXMLNode(node,'FeedData' ,FeedData);
  AddXMLNode(node,'FeedID' ,FeedID);
  AddXMLNode(node,'FeedType' ,FeedType);
  AddXMLNode(node,'feedSource' ,feedSource);
  AddXMLNode(node,'feedStatus' ,feedStatus);
  AddXMLNode(node,'partnerId' ,partnerId);
  AddXMLNode(node,'itemsReceived' ,itemsReceived);
  AddXMLNode(node,'ItemsSucceeded' ,ItemsSucceeded);
  AddXMLNode(node,'ItemsFailed' ,ItemsFailed);
  AddXMLNode(node,'ItemsProcessing' ,ItemsProcessing);
  AddXMLNode(node,'modifiedDtm' ,modifiedDtm);
end;


function TWalmartFeeds.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if Feeddate = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Feeddate should not be blank' , False );
    Exit;
  end;
  Result := True;
end;


function TWalmartFeeds.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TWalmartFeeds.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;




procedure TWalmartFeeds.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TWalmartFeeds.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


function TWalmartFeeds.getwalmartfeedstatus: Twalmartfeedstatus;
begin
  Result := Twalmartfeedstatus(Getcontainercomponent(Twalmartfeedstatus, 'FeedId =  ' + IntToStr(Self.ID)));
end;

class function TWalmartFeeds.GetIDField: string;
begin
  Result := 'ID'
end;


class function TWalmartFeeds.GetBusObjectTablename: string;
begin
  Result:= 'tblwalmartfeeds';
end;


function TWalmartFeeds.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TWalmartFeeds.GetFeeddate        : TDateTime ; begin Result := GetDateTimeField('Feeddate');end;
function  TWalmartFeeds.GetFeedData        : string    ; begin Result := GetStringField('FeedData');end;
function  TWalmartFeeds.GetFeedID          : string    ; begin Result := GetStringField('FeedID');end;
function  TWalmartFeeds.GetFeedType        : string    ; begin Result := GetStringField('FeedType');end;
function  TWalmartFeeds.GetfeedSource      : string    ; begin Result := GetStringField('feedSource');end;
function  TWalmartFeeds.GetfeedStatus      : string    ; begin Result := GetStringField('feedStatus');end;
function  TWalmartFeeds.GetpartnerId       : string    ; begin Result := GetStringField('partnerId');end;
function  TWalmartFeeds.GetitemsReceived   : integer   ; begin Result := GetIntegerField('itemsReceived');end;
function  TWalmartFeeds.GetItemsSucceeded    : Integer   ; begin Result := GetIntegerField('ItemsSucceeded');end;
function  TWalmartFeeds.GetItemsFailed       : Integer   ; begin Result := GetIntegerField('ItemsFailed');end;
function  TWalmartFeeds.GetItemsProcessing   : Integer   ; begin Result := GetIntegerField('ItemsProcessing');end;
function  TWalmartFeeds.GetmodifiedDtm       : TDateTime ; begin Result := GetDateTimeField('modifiedDtm');end;

procedure TWalmartFeeds.SetFeeddate        (const Value: TDateTime ); begin SetDateTimeField('Feeddate'         , Value);end;
procedure TWalmartFeeds.SetFeedData        (const Value: string    ); begin SetStringField('FeedData'         , Value);end;
procedure TWalmartFeeds.SetFeedID          (const Value: string    ); begin SetStringField('FeedID'           , Value);end;
procedure TWalmartFeeds.SetFeedType        (const Value: string    ); begin SetStringField('FeedType'         , Value);end;
procedure TWalmartFeeds.SetfeedSource      (const Value: string    ); begin SetStringField('feedSource'      , Value);end;
procedure TWalmartFeeds.SetfeedStatus      (const Value: string    ); begin SetStringField('feedStatus'      , Value);end;
procedure TWalmartFeeds.SetpartnerId       (const Value: string    ); begin SetStringField('partnerId'      , Value);end;
procedure TWalmartFeeds.SetitemsReceived   (const Value: Integer   ); begin SetIntegerField('itemsReceived'      , Value);end;
procedure TWalmartFeeds.SetItemsSucceeded    (const Value: Integer   ); begin SetIntegerField('ItemsSucceeded'     , Value);end;
procedure TWalmartFeeds.SetItemsFailed       (const Value: Integer   ); begin SetIntegerField('ItemsFailed'        , Value);end;
procedure TWalmartFeeds.SetItemsProcessing   (const Value: Integer   ); begin SetIntegerField('ItemsProcessing'    , Value);end;
procedure TWalmartFeeds.SetmodifiedDtm       (const Value: TDateTime ); begin SetDateTimeField('modifiedDtm'         , Value);end;


{Twalmartfeedstatuserrors}

constructor Twalmartfeedstatuserrors.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'walmartfeedstatuserrors';
  fSQL := 'SELECT * FROM tblwalmartfeedstatuserrors';
end;


destructor Twalmartfeedstatuserrors.Destroy;
begin
  inherited;
end;


procedure Twalmartfeedstatuserrors.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'FeedId');
  SetPropertyFromNode(node,'FeedStatusID');
  SetPropertyFromNode(node,'ErrorType');
  SetPropertyFromNode(node,'ErrorCode');
  SetPropertyFromNode(node,'ErrorField');
  SetPropertyFromNode(node,'ErrorDescription');
end;


procedure Twalmartfeedstatuserrors.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'FeedId' ,FeedId);
  AddXMLNode(node,'FeedStatusID' ,FeedStatusID);
  AddXMLNode(node,'ErrorType' ,ErrorType);
  AddXMLNode(node,'ErrorCode' ,ErrorCode);
  AddXMLNode(node,'ErrorField' ,ErrorField);
  AddXMLNode(node,'ErrorDescription' ,ErrorDescription);
end;


function Twalmartfeedstatuserrors.ValidateData: Boolean ;
begin

  Resultstatus.Clear;
  Result := True;
end;


function Twalmartfeedstatuserrors.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Twalmartfeedstatuserrors.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Twalmartfeedstatuserrors.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Twalmartfeedstatuserrors.GetSQL: string;
begin
  Result := inherited GetSQL;
end;



class function Twalmartfeedstatuserrors.GetIDField: string;
begin
  Result := 'ID'
end;


class function Twalmartfeedstatuserrors.GetBusObjectTablename: string;
begin
  Result:= 'tblwalmartfeedstatuserrors';
end;


function Twalmartfeedstatuserrors.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if assigned(Owner) then
    if owner is Twalmartfeedstatus then begin
        FeedID := Twalmartfeedstatus(Owner).FeedID;
        FeedStatusID := Twalmartfeedstatus(Owner).ID;
    end;
end;

function Twalmartfeedstatuserrors.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
{Property Functions}
function  Twalmartfeedstatuserrors.GetFeedId          : Integer   ; begin Result := GetIntegerField('FeedId');end;
function  Twalmartfeedstatuserrors.GetFeedStatusID    : Integer   ; begin Result := GetIntegerField('FeedStatusID');end;
function  Twalmartfeedstatuserrors.GetErrorType       : string    ; begin Result := GetStringField('ErrorType');end;
function  Twalmartfeedstatuserrors.GetErrorCode       : string    ; begin Result := GetStringField('ErrorCode');end;
function  Twalmartfeedstatuserrors.GetErrorField      : string    ; begin Result := GetStringField('ErrorField');end;
function  Twalmartfeedstatuserrors.GetErrorDescription: string    ; begin Result := GetStringField('ErrorDescription');end;
procedure Twalmartfeedstatuserrors.SetFeedId          (const Value: Integer   ); begin SetIntegerField('FeedId'           , Value);end;
procedure Twalmartfeedstatuserrors.SetFeedStatusID    (const Value: Integer   ); begin SetIntegerField('FeedStatusID'     , Value);end;
procedure Twalmartfeedstatuserrors.SetErrorType       (const Value: string    ); begin SetStringField('ErrorType'        , Value);end;
procedure Twalmartfeedstatuserrors.SetErrorCode       (const Value: string    ); begin SetStringField('ErrorCode'        , Value);end;
procedure Twalmartfeedstatuserrors.SetErrorField      (const Value: string    ); begin SetStringField('ErrorField'       , Value);end;
procedure Twalmartfeedstatuserrors.SetErrorDescription(const Value: string    ); begin SetStringField('ErrorDescription' , Value);end;


{Twalmartfeedstatus}

constructor Twalmartfeedstatus.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'walmartfeedstatus';
  fSQL := 'SELECT * FROM tblwalmartfeedstatus';
end;


destructor Twalmartfeedstatus.Destroy;
begin
  inherited;
end;


procedure Twalmartfeedstatus.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'FeedId');
  SetDateTimePropertyFromNode(node,'StatusDate');
  SetPropertyFromNode(node,'FeedStatus');
  SetPropertyFromNode(node,'ShipNode');
  SetPropertyFromNode(node,'SubmittedBy');
  SetPropertyFromNode(node,'FeedSubmissionDate');
  SetPropertyFromNode(node,'ItemsReceived');
  SetPropertyFromNode(node,'ItemsSucceeded');
  SetPropertyFromNode(node,'ItemsFailed');
  SetPropertyFromNode(node,'ItemsProcessing');
  SetPropertyFromNode(node,'Offset');
  SetPropertyFromNode(node,'Apilimit');
end;


procedure Twalmartfeedstatus.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'FeedId' ,FeedId);
  AddXMLNode(node,'StatusDate' ,StatusDate);
  AddXMLNode(node,'FeedStatus' ,FeedStatus);
  AddXMLNode(node,'ShipNode' ,ShipNode);
  AddXMLNode(node,'SubmittedBy' ,SubmittedBy);
  AddXMLNode(node,'FeedSubmissionDate' ,FeedSubmissionDate);
  AddXMLNode(node,'ItemsReceived' ,ItemsReceived);
  AddXMLNode(node,'ItemsSucceeded' ,ItemsSucceeded);
  AddXMLNode(node,'ItemsFailed' ,ItemsFailed);
  AddXMLNode(node,'ItemsProcessing' ,ItemsProcessing);
  AddXMLNode(node,'Offset' ,Offset);
  AddXMLNode(node,'Apilimit' ,Apilimit);
end;


function Twalmartfeedstatus.ValidateData: Boolean ;
begin

  Resultstatus.Clear;
  Result := True;
end;


function Twalmartfeedstatus.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Twalmartfeedstatus.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Twalmartfeedstatus.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Twalmartfeedstatus.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Twalmartfeedstatus.GetIDField: string;
begin
  Result := 'ID'
end;


class function Twalmartfeedstatus.GetBusObjectTablename: string;
begin
  Result:= 'tblwalmartfeedstatus';
end;


function Twalmartfeedstatus.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if assigned(Owner) then
    if owner is Twalmartfeeds then begin
        FeedID := Twalmartfeeds(Owner).ID;
    end;
end;

function Twalmartfeedstatus.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

function Twalmartfeedstatus.getwalmartfeedstatuserrors: Twalmartfeedstatuserrors;
begin
  Result := Twalmartfeedstatuserrors(Getcontainercomponent(Twalmartfeedstatuserrors, 'FeedStatusID =  ' + IntToStr(Self.ID)));
end;

{Property Functions}
function  Twalmartfeedstatus.GetFeedId            : Integer   ; begin Result := GetIntegerField('FeedId');end;
function  Twalmartfeedstatus.GetStatusDate        : TDateTime ; begin Result := GetDateTimeField('StatusDate');end;
function  Twalmartfeedstatus.GetFeedStatus        : string    ; begin Result := GetStringField('FeedStatus');end;
function  Twalmartfeedstatus.GetShipNode          : string    ; begin Result := GetStringField('ShipNode');end;
function  Twalmartfeedstatus.GetSubmittedBy       : string    ; begin Result := GetStringField('SubmittedBy');end;
function  Twalmartfeedstatus.GetFeedSubmissionDate: string    ; begin Result := GetStringField('FeedSubmissionDate');end;
function  Twalmartfeedstatus.GetItemsReceived     : Integer   ; begin Result := GetIntegerField('ItemsReceived');end;
function  Twalmartfeedstatus.GetItemsSucceeded    : Integer   ; begin Result := GetIntegerField('ItemsSucceeded');end;
function  Twalmartfeedstatus.GetItemsFailed       : Integer   ; begin Result := GetIntegerField('ItemsFailed');end;
function  Twalmartfeedstatus.GetItemsProcessing   : Integer   ; begin Result := GetIntegerField('ItemsProcessing');end;
function  Twalmartfeedstatus.GetOffset            : Integer   ; begin Result := GetIntegerField('Offset');end;
function  Twalmartfeedstatus.GetApilimit          : Integer   ; begin Result := GetIntegerField('Apilimit');end;
procedure Twalmartfeedstatus.SetFeedId            (const Value: Integer   ); begin SetIntegerField('FeedId'             , Value);end;
procedure Twalmartfeedstatus.SetStatusDate        (const Value: TDateTime ); begin SetDateTimeField('StatusDate'         , Value);end;
procedure Twalmartfeedstatus.SetFeedStatus        (const Value: string    ); begin SetStringField('FeedStatus'         , Value);end;
procedure Twalmartfeedstatus.SetShipNode          (const Value: string    ); begin SetStringField('ShipNode'           , Value);end;
procedure Twalmartfeedstatus.SetSubmittedBy       (const Value: string    ); begin SetStringField('SubmittedBy'        , Value);end;
procedure Twalmartfeedstatus.SetFeedSubmissionDate(const Value: string    ); begin SetStringField('FeedSubmissionDate' , Value);end;
procedure Twalmartfeedstatus.SetItemsReceived     (const Value: Integer   ); begin SetIntegerField('ItemsReceived'      , Value);end;
procedure Twalmartfeedstatus.SetItemsSucceeded    (const Value: Integer   ); begin SetIntegerField('ItemsSucceeded'     , Value);end;
procedure Twalmartfeedstatus.SetItemsFailed       (const Value: Integer   ); begin SetIntegerField('ItemsFailed'        , Value);end;
procedure Twalmartfeedstatus.SetItemsProcessing   (const Value: Integer   ); begin SetIntegerField('ItemsProcessing'    , Value);end;
procedure Twalmartfeedstatus.SetOffset            (const Value: Integer   ); begin SetIntegerField('Offset'             , Value);end;
procedure Twalmartfeedstatus.SetApilimit          (const Value: Integer   ); begin SetIntegerField('Apilimit'           , Value);end;


initialization
  RegisterClass(Twalmartfeedstatus);
  RegisterClass(Twalmartfeedstatuserrors);
  RegisterClass(TWalmartFeeds);


end.
