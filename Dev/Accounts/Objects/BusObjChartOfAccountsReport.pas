unit BusObjChartOfAccountsReport;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  06/02/15  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TChartOfAccountsReportTree = class(TMSBusObj)
  private
    function GetAccountId          : Integer   ;
    function GetReportID           : Integer   ;
    function GetCategory           : string    ;
    function GetReportCaption      : string    ;
    function Getshowinthereport    : Boolean   ;
    function GetLevel1ID           : Integer   ;
    function GetLevel2ID           : Integer   ;
    function GetLevel3ID           : Integer   ;
    function GetLevel4ID           : Integer   ;
    function GetSortOrder          : Integer   ;
    procedure SetAccountId          (const Value: Integer   );
    procedure SetReportID           (const Value: Integer   );
    procedure SetCategory           (const Value: string    );
    procedure SetReportCaption      (const Value: string    );
    procedure Setshowinthereport    (const Value: Boolean   );
    procedure SetLevel1ID           (const Value: Integer   );
    procedure SetLevel2ID           (const Value: Integer   );
    procedure SetLevel3ID           (const Value: Integer   );
    procedure SetLevel4ID           (const Value: Integer   );
    procedure SetSortOrder          (const Value: Integer   );
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
  published
    property AccountId           :Integer     read GetAccountId         write SetAccountId      ;
    property ReportID            :Integer     read GetReportID          write SetReportID       ;
    property Category            :string      read GetCategory          write SetCategory       ;
    property ReportCaption       :string      read GetReportCaption     write SetReportCaption  ;
    property showinthereport     :Boolean     read Getshowinthereport   write Setshowinthereport;
    property Level1ID            :Integer     read GetLevel1ID          write SetLevel1ID       ;
    property Level2ID            :Integer     read GetLevel2ID          write SetLevel2ID       ;
    property Level3ID            :Integer     read GetLevel3ID          write SetLevel3ID       ;
    property Level4ID            :Integer     read GetLevel4ID          write SetLevel4ID       ;
    property SortOrder           :Integer     read GetSortOrder         write SetSortOrder      ;
  end;


implementation


uses tcDataUtils, CommonLib;



  {TChartOfAccountsReportTree}

constructor TChartOfAccountsReportTree.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'ChartOfAccountsReportTree';
  fSQL := 'SELECT * FROM tblchartofaccountsreporttree';
end;


destructor TChartOfAccountsReportTree.Destroy;
begin
  inherited;
end;


procedure TChartOfAccountsReportTree.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'AccountId');
  SetPropertyFromNode(node,'ReportID');
  SetPropertyFromNode(node,'Category');
  SetPropertyFromNode(node,'ReportCaption');
  SetBooleanPropertyFromNode(node,'showinthereport');
  SetPropertyFromNode(node,'Level1ID');
  SetPropertyFromNode(node,'Level2ID');
  SetPropertyFromNode(node,'Level3ID');
  SetPropertyFromNode(node,'Level4ID');
  SetPropertyFromNode(node,'SortOrder');
end;


procedure TChartOfAccountsReportTree.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'AccountId' ,AccountId);
  AddXMLNode(node,'ReportID' ,ReportID);
  AddXMLNode(node,'Category' ,Category);
  AddXMLNode(node,'ReportCaption' ,ReportCaption);
  AddXMLNode(node,'showinthereport' ,showinthereport);
  AddXMLNode(node,'Level1ID' ,Level1ID);
  AddXMLNode(node,'Level2ID' ,Level2ID);
  AddXMLNode(node,'Level3ID' ,Level3ID);
  AddXMLNode(node,'Level4ID' ,Level4ID);
  AddXMLNode(node,'SortOrder' ,SortOrder);
end;


function TChartOfAccountsReportTree.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if AccountId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'AccountId should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function TChartOfAccountsReportTree.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TChartOfAccountsReportTree.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TChartOfAccountsReportTree.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TChartOfAccountsReportTree.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TChartOfAccountsReportTree.GetIDField: string;
begin
  Result := 'ID'
end;


class function TChartOfAccountsReportTree.GetBusObjectTablename: string;
begin
  Result:= 'tblchartofaccountsreporttree';
end;


function TChartOfAccountsReportTree.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TChartOfAccountsReportTree.GetAccountId      : Integer   ; begin Result := GetIntegerField('AccountId');end;
function  TChartOfAccountsReportTree.GetReportID       : Integer   ; begin Result := GetIntegerField('ReportID');end;
function  TChartOfAccountsReportTree.GetCategory       : string    ; begin Result := GetStringField('Category');end;
function  TChartOfAccountsReportTree.GetReportCaption  : string    ; begin Result := GetStringField('ReportCaption');end;
function  TChartOfAccountsReportTree.Getshowinthereport: Boolean   ; begin Result := GetBooleanField('showinthereport');end;
function  TChartOfAccountsReportTree.GetLevel1ID       : Integer   ; begin Result := GetIntegerField('Level1ID');end;
function  TChartOfAccountsReportTree.GetLevel2ID       : Integer   ; begin Result := GetIntegerField('Level2ID');end;
function  TChartOfAccountsReportTree.GetLevel3ID       : Integer   ; begin Result := GetIntegerField('Level3ID');end;
function  TChartOfAccountsReportTree.GetLevel4ID       : Integer   ; begin Result := GetIntegerField('Level4ID');end;
function  TChartOfAccountsReportTree.GetSortOrder      : Integer   ; begin Result := GetIntegerField('SortOrder');end;
procedure TChartOfAccountsReportTree.SetAccountId      (const Value: Integer   ); begin SetIntegerField('AccountId'       , Value);end;
procedure TChartOfAccountsReportTree.SetReportID       (const Value: Integer   ); begin SetIntegerField('ReportID'       , Value);end;
procedure TChartOfAccountsReportTree.SetCategory       (const Value: string    ); begin SetStringField('Category'        , Value);end;
procedure TChartOfAccountsReportTree.SetReportCaption  (const Value: string    ); begin SetStringField('ReportCaption'   , Value);end;
procedure TChartOfAccountsReportTree.Setshowinthereport(const Value: Boolean   ); begin SetBooleanField('showinthereport' , Value);end;
procedure TChartOfAccountsReportTree.SetLevel1ID       (const Value: Integer   ); begin SetIntegerField('Level1ID'        , Value);end;
procedure TChartOfAccountsReportTree.SetLevel2ID       (const Value: Integer   ); begin SetIntegerField('Level2ID'        , Value);end;
procedure TChartOfAccountsReportTree.SetLevel3ID       (const Value: Integer   ); begin SetIntegerField('Level3ID'        , Value);end;
procedure TChartOfAccountsReportTree.SetLevel4ID       (const Value: Integer   ); begin SetIntegerField('Level4ID'        , Value);end;
procedure TChartOfAccountsReportTree.SetSortOrder      (const Value: Integer   ); begin SetIntegerField('SortOrder'       , Value);end;


initialization
  RegisterClass(TChartOfAccountsReportTree);


end.
