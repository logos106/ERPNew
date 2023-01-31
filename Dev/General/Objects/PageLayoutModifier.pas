unit PageLayoutModifier;
{$I ERP.inc}
interface
uses
  Windows, SysUtils, Classes, Graphics, ERPLine, ERPDrawUtils;

type
  TModifierType = (mtButton, mtLink);
  TPageItemDesc = class //(TPageItemDesc)
  private
    fWidth: integer;
    fTop: integer;
    fHeight: integer;
    fLeft: integer;
    fEndActionName: string;
    fActionName: string;
    fNodeType: TModifierType;
    fLineWidth: integer;
    fLineHeads: integer;
    fLineColor: TColor;
    fSelectedColor: TColor;
    fMarkColor: TColor;
    fMarkSize: integer;
    fArrowColor: TColor;
    fLineStyle: TPenStyle;
    fArrow2Kind: TArrowKind;
    fArrow1Kind: TArrowKind;
  public
    property Left : integer read fLeft write fLeft;
    property Top : integer read fTop write fTop;
    property Width : integer read fWidth write fWidth;
    property Height: integer read fHeight write fHeight;
    property ActionName : string read fActionName write fActionName;  // Start for Links
    property EndActionName : string read fEndActionName write fEndActionName;
    property NodeType: TModifierType read fNodeType write fNodeType;
    property LineWidth : integer read fLineWidth write fLineWidth;
    property LineHeads : integer read fLineHeads write fLineHeads;
    property LineColor : TColor read fLineColor write fLineColor;
    property SelectedColor : TColor read fSelectedColor write fSelectedColor;
    property MarkColor : TColor read fMarkColor write fMarkColor;
    property MarkSize : integer read fMarkSize write fMarkSize;
    property ArrowColor : TColor read fArrowColor write fArrowColor;
    property LineStyle: TPenStyle read fLineStyle write fLineStyle;
    property Arrow1Kind: TArrowKind read fArrow1Kind write fArrow1Kind;
    property Arrow2Kind: TArrowKind read fArrow2Kind write fArrow2Kind;
  end;

//  TPageItem = class;

  TPageModifier = class
  private
    List : TStringList;
    fPageName: string;
    fOwner: TObject; //TPageItem;
    fId: integer;
    fButtonList: string;
    fTimeStamp: TDateTime;
    fActive: boolean;
    fIndustryName: string;
    fIndustryId: integer;
    function GetDescriptor(const ActName: string): TPageItemDesc;
    procedure SetDescriptor(const ActName: string; const Value: TPageItemDesc);
    function GetCount: integer;
    function GetItems(idx: integer): TPageItemDesc;
//    function GetDescriptor(const ActName: string;
//      AType: TModifierType): TPageItemDesc;
//    procedure SetDescriptor(const ActName: string; AType: TModifierType;
//      const Value: TPageItemDesc);
//  protected
  public
    property PageName : string read fPageName write fPageName;
  public
    constructor Create(AOwner : TObject);
    destructor Destroy;override;
    procedure Load(const APageName : string; AIndustryId : integer);
    procedure Save(*(const aButtonList : string)*);
    procedure Delete(idx : integer);
    procedure DeleteButton(const AName : string);
    procedure AddLinkDescriptor(ADesc : TPageItemDesc);
    property ButtonDescriptor[const ActName : string] : TPageItemDesc read GetDescriptor write SetDescriptor;
    property Items[idx : integer] : TPageItemDesc read GetItems;
    property Owner : TObject{TPageItem} read fOwner write fOwner;
    property Count : integer read GetCount;
    property Id : integer read fId write fId;
    property TimeSTamp : TDateTime read fTimeStamp;
    property Active : boolean read fActive write fActive;
    property IndustryId : integer read fIndustryId write fIndustryId;
    property IndustryName : string read fIndustryName write fIndustryName;
    // Can be different for different layouts
    property ButtonList: string read fButtonList write fButtonList;
  end;


implementation
uses
  ERPDbComponents, AppEnvironment, CommonDbLib;
{ TPageModifier }

procedure TPageModifier.AddLinkDescriptor(ADesc: TPageItemDesc);
begin
   {$IFDEF DevMode}
    exit;
   {$ENDIF}
  List.AddObject(ADesc.ActionName, ADesc);
end;

constructor TPageModifier.Create(AOwner : TObject); //TPageItem);
begin
  inherited Create;
  List := TStringList.Create;
  List.CaseSensitive := false;
  List.Duplicates := dupAccept;
  List.Sorted := true;
  Owner := AOwner;
//  if assigned(Owner) then
//    PageName := trim(Owner.PageName);
end;

procedure TPageModifier.Delete(idx: integer);
begin
   {$IFDEF DevMode}
    exit;
   {$ENDIF}
  if (idx >= 0) and (idx < List.Count) then
  begin
    List.Objects[idx].Free;
    List.Delete(idx);
  end;
end;

procedure TPageModifier.DeleteButton(const AName: string);
var
  idx : integer;
begin
   {$IFDEF DevMode}
    exit;
   {$ENDIF}
  for idx := 0 to List.Count - 1 do
    if items[idx].NodeType = mtButton then
      if SameText(Items[idx].ActionName, AName) then
      begin
        Delete(idx);
        exit;
      end;
end;

destructor TPageModifier.Destroy;
var
  idx : integer;
begin
  for idx := List.Count - 1 downto 0 do
  begin
    List.Objects[idx].Free;
    List.Objects[idx] := nil;
  end;
  inherited;
end;

function TPageModifier.GetCount: integer;
begin
  Result := List.Count;
end;

function TPageModifier.GetDescriptor(const ActName: string) : TPageItemDesc;
//  AType: TModifierType): TPageItemDesc;
var
  idx : integer;
begin
  idx := List.IndexOf(ActName);
  (*
  if idx > 0 then
    Result := TPageItemDesc(List.Objects[idx])
  else
    Result := nil;
  *)
  if idx < 0 then
  begin
    Result := nil;
    exit;
  end;

  while (idx < List.Count) and SameText(TPageItemDesc(List.Objects[idx]).ActionName, ActName) do
    if (TPageItemDesc(List.Objects[idx]).NodeType = mtButton) then
    begin
      Result := TPageItemDesc(List.Objects[idx]);
      exit;
    end
    else
      idx := idx + 1;

  Result := nil;
end;

function TPageModifier.GetItems(idx: integer): TPageItemDesc;
begin
  Result := TPageItemDesc(List.Objects[idx]);
end;

procedure TPageModifier.Load(const APageName: string; AIndustryId : integer);
var
  qry : TERPQuery;
  item : TPageItemDesc;
begin
   {$IFDEF DevMode}
    exit;
   {$ENDIF}

  PageName := trim(APageName);
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := GetSharedMyDacConnection;
    if id = 0 then
    begin
      qry.SQL.Text := 'select * from tblPageLayout inner join tblIndustries on (tblIndustries.IndustryId=tblPageLayout.IndustryId)';
      qry.sql.Add('where UserId = ' + IntToStr(AppEnv.Employee.EmployeeID) + ' and PageName="' + PageName+'" and Active="T"');
      if AIndustryId <> 0 then
//        qry.sql.add('and IndustryId=' + IntToStr(AppEnv.CompanyInfo.IndustryId));
        qry.sql.add(' and tblPageLayout.IndustryId=' + IntToStr(AIndustryId));
    end
    else
    begin
      qry.SQL.Text := 'select * from tblPageLayout P inner join tblIndustries I on I.IndustryId=P.IndustryId where Id=' + IntToStr(id);
    end;
    qry.Open;
    ButtonList := '';
    if qry.eof then
      exit;
    id := qry.FieldByName('ID').AsInteger;
    IndustryId :=  qry.FieldByName('IndustryId').AsInteger;
    IndustryName := qry.FieldByName('IndustryName').AsString;
    fTimeStamp := qry.FieldByName('msTimeStamp').asDateTime;
    Active := qry.FieldByName('Active').AsString = 'T';
    while not qry.Eof do
    begin
      item := TPageItemDesc.Create;
      item.Width := qry.FieldByName('Width').AsInteger;
      item.Height := qry.FieldByName('Height').AsInteger;
      item.Left := qry.FieldByName('TopLeft').AsInteger;
      item.Top := qry.FieldByName('Top').AsInteger;
      Item.ActionName := qry.FieldByName('ActionName').AsString;
      Item.EndActionName := qry.FieldByName('EndActionName').AsString;
      Item.NodeType := TModifierType(qry.FieldByName('NodeType').AsInteger);
      Item.LineWidth := qry.FieldByName('LineWidth').AsInteger;
      Item.LineHeads := qry.FieldByName('LineHeads').AsInteger;
      Item.LineColor := TColor(qry.FieldByName('LineColor').AsInteger);
      Item.SelectedColor := TColor(qry.FieldByName('SelectedColor').AsInteger);
      Item.MarkColor := TColor(qry.FieldByName('MarkColor').AsInteger);
      Item.MarkSize := qry.FieldByName('MarkSize').AsInteger;
      Item.LineStyle := TPenStyle(qry.FieldByName('LineStyle').asInteger);
      Item.ArrowColor := TColor(qry.FieldByName('ArrowColor').AsInteger);
      Item.Arrow1Kind := TArrowKind(qry.FieldByName('Arrow1Kind').AsInteger);
      Item.Arrow2Kind := TArrowKind(qry.FieldByName('Arrow2Kind').AsInteger);
      List.AddObject(Item.ActionName, Item);
      if Item.NodeType = mtButton then
        if ButtonList='' then
          ButtonList := Item.ActionName
        else
          ButtonList := ButtonList + ',' + Item.ActionName;
      qry.Next;
    end;
  finally
    qry.Free;
  end;
end;

procedure TPageModifier.Save(*(const aButtonList : string)*);
var
  scr : TERPScript;
  qry : TERPQuery;
  idx : integer;
//  k : integer;
//  sl : TStringList;
  d : TPageItemDesc;
begin
   {$IFDEF DevMode}
    exit;
   {$ENDIF}

  if List.Count = 0 then
    exit;
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := GetSharedMyDacConnection;
    qry.SQL.Text := 'select max(id) from tblPageLayout';
    qry.open();
    id := qry.Fields[0].AsInteger + 1;

    scr := TERPScript.Create(nil);
    try
      scr.Connection := qry.Connection;

      scr.SQL.Add(Format('update tblPageLayout set Active="F" where UserID=%d and PageName = "%s" and IndustryId=%d;',
                 [AppEnv.Employee.EmployeeID, PageName, AppEnv.CompanyInfo.IndustryId]));

    for idx := 0 to List.Count - 1 do
    begin
      d := TPageItemDesc(List.Objects[idx]);
      scr.sql.Add('insert into tblPageLayout (UserId, PageName, ActionName, EndActionName, TopLeft, Top, Width, Height, NodeType,');
      scr.SQL.Add('LineWidth, LineHeads, LineColor, SelectedColor, MarkColor, MarkSize, ArrowColor, LineStyle, Arrow1Kind, Arrow2Kind, Active, ID, IndustryId) values');
      scr.SQL.Add(Format('(%d, "%s", "%s", "%s", %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, "T", %d, %d);',
        [AppEnv.Employee.EmployeeID, PageName, d.ActionName, d.EndActionName, d.Left, d.Top, d.Width, d.Height, ord(d.NodeType),
         d.LineWidth, d.LineHeads, d.LineColor, d.SelectedColor, d.MarkColor, d.MarkSize, d.ArrowColor, ord(d.LineStyle), ord(d.Arrow1Kind), ord(d.Arrow2Kind), id, AppEnv.CompanyInfo.IndustryId ]));
    end;
    scr.Execute;
  finally
    scr.Free;
  end;
  finally
    qry.Free;
  end;
end;

//procedure TPageModifier.SetDescriptor(const ActName: string;
//  AType: TModifierType; const Value: TPageItemDesc);
procedure TPageModifier.SetDescriptor(const ActName: string;
  const Value: TPageItemDesc);
var
  idx : integer;
begin
  Value.NodeType := mtButton;
  idx := List.IndexOf(ActName);
  if idx < 0 then
    List.AddObject(ActName, Value)
  else if List.Objects[idx] <> Value then
  begin
    List.Objects[idx].Free;
    List.Objects[idx] := Value;
  end;
end;

end.
