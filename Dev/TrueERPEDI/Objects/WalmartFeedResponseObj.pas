unit WalmartFeedResponseObj;

interface

uses PartnerFeedResponse, XMLIntf , XMLDoc , PurchaseOrderV33;


Type
  IXMLPartnerFeedResponseList= interface(IXMLPartnerFeedResponse )
    ['{996F57E8-80EF-4826-8AB4-A7A97CFAFDAE}']
    function Get_TotalCount: Integer;
    function Get_NextCursor: UnicodeString;
    procedure Set_TotalCount(Value: Integer);
    procedure Set_NextCursor(Value: UnicodeString);
    { Methods & Properties }
    property TotalCount: Integer read Get_TotalCount write Set_TotalCount;
    property NextCursor: UnicodeString read Get_NextCursor write Set_NextCursor;
  end;
  IXMLItemStatusDetail= interface(IXMLNode)
  ['{1C3EB17B-BC53-4FA9-B315-3AE386D200CB}']
    { Property Accessors }
    Function get_ItemStatusDetailMeta :IXMLNode;

    { Methods & Properties }
    Property ItemStatusDetailMeta : IXMLNode read get_ItemStatusDetailMeta ;

  end;

  TXMLPartnerFeedResponseList = class(TXMLPartnerFeedResponse, IXMLPartnerFeedResponseList)
  Protected
    function Get_TotalCount: Integer;
    function Get_NextCursor: UnicodeString;
    procedure Set_TotalCount(Value: Integer);
    procedure Set_NextCursor(Value: UnicodeString);
  end;
  TXMLItemStatusDetail = class(TXMLNode, IXMLItemStatusDetail)
    Protected
      Function get_ItemStatusDetailMeta :IXMLNode;
  end;

  function NewIItemStatusDetail: IXMLItemStatusDetail;

implementation

uses CK_DLL_Const ;

function NewIItemStatusDetail: IXMLItemStatusDetail;
begin
  Result := NewXMLDocument.GetDocBinding('ItemStatusDetail',
                                          TXMLItemStatusDetail,
                                          WalmartTargetNamespace) as IXMLItemStatusDetail;
end;
{ TXMLItemStatusDetail }

function TXMLItemStatusDetail.get_ItemStatusDetailMeta: IXMLNode;
begin
    Result := ChildNodes['meta'] as IXMLNode;
end;
function TXMLPartnerFeedResponseList.Get_TotalCount: Integer;
begin
  Result := ChildNodes['totalCount'].NodeValue;
end;

procedure TXMLPartnerFeedResponseList.Set_TotalCount(Value: Integer);
begin
  ChildNodes['totalCount'].NodeValue := Value;
end;

function TXMLPartnerFeedResponseList.Get_NextCursor: UnicodeString;
begin
  Result := ChildNodes['nextCursor'].Text;
end;

procedure TXMLPartnerFeedResponseList.Set_NextCursor(Value: UnicodeString);
begin
  ChildNodes['nextCursor'].NodeValue := Value;
end;
end.
