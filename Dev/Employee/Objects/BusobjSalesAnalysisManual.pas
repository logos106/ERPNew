unit BusobjSalesAnalysisManual;

  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  14/01/13  1.00.00  BJ  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TSalesAnalysisManualLines = class(TMSBusObj)
  private
    function GeTHeaderId            : Integer   ;
    function GetEmployeeId          : Integer   ;
    function GetEmployeeName        : string    ;
    function GetComments            : string    ;
    function GetDeleted             : Boolean   ;
    function GetColdCalls           : Integer   ;
    function GetContact             : Integer   ;
    function GetFirstDemo           : Integer   ;
    function GetSecondDemo          : Integer   ;
    function GetQuotes              : Integer   ;
    function GetSalesOrders         : Integer   ;
    function GetSales               : Integer   ;
    function getBudgetIncome        : double    ;
    function getBudgetcost          : double    ;
    procedure SeTHeaderId            (const Value: Integer   );
    procedure SetEmployeeId          (const Value: Integer   );
    procedure SetEmployeeName        (const Value: string    );
    procedure SetComments            (const Value: string    );
    procedure SetDeleted             (const Value: Boolean   );
    procedure SetColdCalls           (const Value: Integer   );
    procedure SetContact             (const Value: Integer   );
    procedure SetFirstDemo           (const Value: Integer   );
    procedure SetSecondDemo          (const Value: Integer   );
    procedure SetQuotes              (const Value: Integer   );
    procedure SetSalesOrders         (const Value: Integer   );
    procedure SetSales               (const Value: Integer   );
    Procedure SetBudgetIncome        (Const Value: double    );
    Procedure SetBudgetcost          (Const Value: double    );
    function Recordblank: Boolean;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoBeforeInsert(Sender:TDatasetBusObj) : Boolean;          override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    function  DoBeforePost(Sender:TDatasetBusObj) : Boolean;            override;
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
    property SalesAnalysisID      :Integer     read GeTHeaderId           write SeTHeaderId     ;
    property EmployeeId           :Integer     read GetEmployeeId         write SetEmployeeId      ;
    property EmployeeName         :string      read GetEmployeeName       write SetEmployeeName    ;
    property Comments             :string      read GetComments           write SetComments    ;
    property Deleted              :Boolean     read GetDeleted            write SetDeleted    ;
    property ColdCalls            :Integer     read GetColdCalls          write SetColdCalls       ;
    property Contact              :Integer     read GetContact            write SetContact         ;
    property FirstDemo            :Integer     read GetFirstDemo          write SetFirstDemo       ;
    property SecondDemo           :Integer     read GetSecondDemo         write SetSecondDemo      ;
    property Quotes               :Integer     read GetQuotes             write SetQuotes          ;
    property SalesOrders          :Integer     read GetSalesOrders        write SetSalesOrders     ;
    property Sales                :Integer     read GetSales              write SetSales           ;
    Property BudgetIncome         :double      read getBudgetIncome       write setBudgetIncome   ;
    Property Budgetcost           :double      read getBudgetcost         write setBudgetcost   ;
  end;
  TSalesAnalysisManual = class(TMSBusObj)
  private
    AllLinesValid:Boolean;
    function GetDateofReport        : TDateTime ;
    function GetDateFrom            : TDateTime ;
    function GetDateTo              : TDateTime ;
    function GetGooglevisitcount    : Integer   ;
    function GetCreatedby           : Integer   ;
    function GetCreatedOn           : TDateTime ;
    function GetComments            : String ;
    function GetActive              : Boolean ;
    procedure SetDateofReport        (const Value: TDateTime );
    procedure SetDateFrom            (const Value: TDateTime );
    procedure SetDateTo              (const Value: TDateTime );
    procedure SetGooglevisitcount    (const Value: Integer   );
    procedure SetCreatedby           (const Value: Integer   );
    procedure SetCreatedOn           (const Value: TDateTime );
    procedure SetComments            (const Value: String );
    procedure SetActive              (const Value: Boolean );
    function getLines: TSalesAnalysisManualLines;
    Procedure ValidateDatacallback(Const Sender: TBusObj; var Abort: boolean);
    function Googlecount: Integer;
    function DeleteFlaggedLines: boolean;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoBeforePost(Sender:TDatasetBusObj) : Boolean;            override;
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
    Property Lines :TSalesAnalysisManualLines Read getLines;
  published
    property DateofReport         :TDateTime   read GetDateofReport       write SetDateofReport    ;
    property DateFrom             :TDateTime   read GetDateFrom           write SetDateFrom        ;
    property DateTo               :TDateTime   read GetDateTo             write SetDateTo          ;
    property Createdby            :Integer     read GetCreatedby          write SetCreatedby       ;
    property Googlevisitcount     :Integer     read GetGooglevisitcount   write SetGooglevisitcount;
    property CreatedOn            :TDateTime   read GetCreatedOn          write SetCreatedOn       ;
    property Comments             :String      read GetComments           write SetComments       ;
    property Active               :Boolean     read GetActive             write SetActive       ;
  end;


implementation


uses tcDataUtils, CommonLib, sysutils,dateutils, AppEnvironment, MySQLConst;



  {TSalesAnalysisManual}

constructor TSalesAnalysisManual.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'Sales Analysis (Manual)';
  fSQL := 'SELECT * FROM tblSalesAnalysisManual';

end;


destructor TSalesAnalysisManual.Destroy;
begin
  inherited;
end;


procedure TSalesAnalysisManual.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetDateTimePropertyFromNode(node,'DateofReport');
  SetDateTimePropertyFromNode(node,'DateFrom');
  SetDateTimePropertyFromNode(node,'DateTo');
  SetPropertyFromNode(node,'Createdby');
  SetPropertyFromNode(node,'Googlevisitcount');
  SetDateTimePropertyFromNode(node,'CreatedOn');
  SetPropertyFromNode(node,'Comments');
  SetBooleanPropertyFromNode(node,'Active');
end;


procedure TSalesAnalysisManual.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'DateofReport' ,DateofReport);
  AddXMLNode(node,'DateFrom' ,DateFrom);
  AddXMLNode(node,'DateTo' ,DateTo);
  AddXMLNode(node,'Createdby' ,Createdby);
  AddXMLNode(node,'Googlevisitcount' ,Googlevisitcount);
  AddXMLNode(node,'CreatedOn' ,CreatedOn);
  AddXMLNode(node,'Comments' ,Comments);
  AddXMLNode(node,'Active' ,Active);
end;


function TSalesAnalysisManual.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if DateofReport = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Date of reporting  should not be blank' , True );
    Exit;
  end;
  if DateFrom = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Date from should not be blank' , True );
    Exit;
  end;
  if DateTo = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Date to should not be blank' , True );
    Exit;
  end;
  if Createdby = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Created By should not be 0' , True );
    Exit;
  end;
  if CreatedOn = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Created On should not be blank' , True );
    Exit;
  end;
  if dateFrom > dateTo then begin
    Resultstatus.AddItem(False , rssError , 0,  'Date from should be less than Date to' , True );
    Exit;
  end;
  if not IsUnique(ID ,'((DateFrom <= ' + QuotedStr(FormatDatetime(MySQLDateformat , DateFrom)) +' and dateTo >= ' + QuotedStr(FormatDatetime(MySQLDateformat , Dateto   )) +') or ' +
                      ' (dateFrom <= ' + QuotedStr(FormatDatetime(MySQLDateformat , DateFrom)) +' and DateTo >= ' + QuotedStr(FormatDatetime(MySQLDateformat , DateFrom )) +') or ' +
                      ' (dateFrom <= ' + QuotedStr(FormatDatetime(MySQLDateformat , DateTo  )) +' and DateTo >= ' + QuotedStr(FormatDatetime(MySQLDateformat , DateTo   )) +') or ' +
                      ' (dateFrom >= ' + QuotedStr(FormatDatetime(MySQLDateformat , DateFrom)) +' and DateTo <= ' + QuotedStr(FormatDatetime(MySQLDateformat , DateTo   )) +')) ' +
                      ' and (active = "T" )' , Self.Connection.Connection) then begin
    Resultstatus.AddItem(False , rssError , 0,  'A ''Sales Analysis (Manual)'' Entry exists with overlaping date range' , True );
    Exit;
  end;
  AllLinesValid:= True;
  Lines.IterateRecords(ValidateDatacallback);
  Result := True;
end;

Procedure TSalesAnalysisManual.ValidateDatacallback(Const Sender: TBusObj; var Abort: boolean);
begin
  if not(Sender is TSalesAnalysisManualLines) then exit;
  if not(TSalesAnalysisManualLines(Sender).ValidateData) then begin
    AllLinesValid:= False;
    Abort := True;
  end;
end;
function TSalesAnalysisManual.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
  DeleteFlaggedLines;
end;
function TSalesAnalysisManual.DeleteFlaggedLines: boolean;
var
  IsFiltered: boolean;
begin
  result:= true;
  Lines.Dataset.DisableControls;
  IsFiltered := Lines.Dataset.Filtered;
  Lines.Dataset.Filtered := false;
  { if this is a new trans allow deleting of lines }
  try
    if Lines.Count > 0 then begin
      Lines.First;
      while not Lines.Dataset.Eof do begin
        if Lines.Deleted then begin
          if not Lines.Delete then begin
            result:= false;
            exit;
          end;
        end else begin
          Lines.Dataset.Next;
        end;
      end;
    end;
  finally
    Lines.Dataset.Filtered := IsFiltered;
    Lines.Dataset.EnableControls;
  end;
end;

procedure TSalesAnalysisManual.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TSalesAnalysisManual.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if sametext(Sender.FieldName , 'DateFrom') then begin
    if dateTo =0 then
      DAteTo := incday(DateFrom , 6);
  end;
end;


function TSalesAnalysisManual.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TSalesAnalysisManual.GetIDField: string;
begin
  Result := 'ID'
end;


function TSalesAnalysisManual.getLines: TSalesAnalysisManualLines;
begin
  Result := TSalesAnalysisManualLines(getcontainercomponent(TSalesAnalysisManualLines , 'SalesAnalysisID = ' + IntToStr(ID) , true , true));
end;

class function TSalesAnalysisManual.GetBusObjectTablename: string;
begin
  Result:= 'tblSalesAnalysisManual';
end;


function TSalesAnalysisManual.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
function TSalesAnalysisManual.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not result then exit;
  if Googlevisitcount = 0 then
    Googlevisitcount :=Googlecount;

end;
function  TSalesAnalysisManual.Googlecount:Integer;
begin
  with getNewdataset('select Cast(sum(ifnull(vtblTGaDataSum.NewVisits,0)) as Signed)   NewVisits '+
          ' from vtblTGaDataSum ' +
          ' where vtblTGaDataSum.Date between ' + Quotedstr(FormatDateTime(MySQLdateTimeFormat , Datefrom)) +' and ' + Quotedstr(FormatDateTime(MySQLdateTimeFormat , Datefrom)) , true) do try
      REsult := Fieldbyname('NewVisits').AsInteger;
  finally
    if active then close;
    Free;
  end;
end;

function  TSalesAnalysisManual.DoAfterInsert(Sender:TDatasetBusObj) : Boolean;
var
  fxID:Integer;
begin
  Result := inherited DoAfterInsert(Sender);
  if not(result) then exit;
  With getnewDataset('Select iD, DateFrom , dateto from tblSalesAnalysisManual where active = "T" and dateTo in  (Select Max(DateTo) DateTo from tblSalesAnalysisManual where active = "T")', true) do try
      if recordcount > 0 then begin
        DateFrom:= incday(FieldByname('DateTo').AsDateTime, 1);
        DAteTo := incday(DateFrom , DaysBetween(FieldByname('Datefrom').AsDateTime, FieldByname('DateTo').AsDateTime));
        fxID := fieldByname('ID').AsInteger;
        if fxID > 0 then begin
          PostDB;
          Close;
          SQL.Clear;
          SQL.Add('Select EmployeeId, employeename from tblSalesAnalysisManuallines  where SalesAnalysisID = ' + inttostr(fxID));
          open;
          if recordcount > 0 then begin
            First;
            While eof = False do begin
              Lines.New;
              Lines.EmployeeId := FieldByname('EmployeeId').AsInteger;
              Lines.EmployeeName := FieldByname('employeeName').AsString;
              Lines.PostDb;
              next;
            end;
          end;
        end;
      end else begin
        DateTo := date;
        DateFrom:= incDay(dateto , -6);
      end;
  finally
    if active then close;
    free;
  end;
  DateofReport:=date;
  CreatedOn:= date;
  Createdby:= Appenv.Employee.EmployeeID;
end;
{Property Functions}
function  TSalesAnalysisManual.GetDateofReport    : TDateTime ; begin Result := GetDateTimeField('DateofReport')    ;end;
function  TSalesAnalysisManual.GetDateFrom        : TDateTime ; begin Result := GetDateTimeField('DateFrom')        ;end;
function  TSalesAnalysisManual.GetDateTo          : TDateTime ; begin Result := GetDateTimeField('DateTo')          ;end;
function  TSalesAnalysisManual.GetCreatedby       : Integer   ; begin Result := GetIntegerField('Createdby')        ;end;
function  TSalesAnalysisManual.GetGooglevisitcount: Integer   ; begin Result := GetIntegerField('Googlevisitcount') ;end;
function  TSalesAnalysisManual.GetCreatedOn       : TDateTime ; begin Result := GetDateTimeField('CreatedOn')       ;end;
function  TSalesAnalysisManual.GetComments        : String    ; begin Result := GetStringField('Comments')          ;end;
function  TSalesAnalysisManual.GetActive          : Boolean   ; begin Result := GetBooleanField('Active')           ;end;
procedure TSalesAnalysisManual.SetDateofReport    (const Value: TDateTime ); begin SetDateTimeField('DateofReport'    , Value);end;
procedure TSalesAnalysisManual.SetDateFrom        (const Value: TDateTime ); begin SetDateTimeField('DateFrom'        , Value);end;
procedure TSalesAnalysisManual.SetDateTo          (const Value: TDateTime ); begin SetDateTimeField('DateTo'          , Value);end;
procedure TSalesAnalysisManual.SetCreatedby       (const Value: Integer   ); begin SetIntegerField('Createdby'        , Value);end;
procedure TSalesAnalysisManual.SetGooglevisitcount(const Value: Integer   ); begin SetIntegerField('Googlevisitcount' , Value);end;
procedure TSalesAnalysisManual.SetCreatedOn       (const Value: TDateTime ); begin SetDateTimeField('CreatedOn'       , Value);end;
procedure TSalesAnalysisManual.SetComments        (const Value: String    ); begin SetStringField('Comments'          , Value);end;
procedure TSalesAnalysisManual.SetActive          (const Value: Boolean   ); begin SetBooleanField('Active'           , Value);end;

  {TSalesAnalysisManualLines}
constructor TSalesAnalysisManualLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'Sales Analysis (Manual) Lines';
//  fSQL := 'SELECT * FROM tblSalesAnalysisManuallines';
  fSQL := 'SELECT SL.*, ((SL.Sales / SL.ColdCalls) * 100) as Ratio,'#13#10 +
          '(ifnull(budgetcost, 0)  / ifnull(SL.Sales, 1)) as COS'#13#10 +
          'FROM tblSalesAnalysisManualLines SL';
end;

destructor TSalesAnalysisManualLines.Destroy;
begin
  inherited;
end;
procedure TSalesAnalysisManualLines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'SalesAnalysisID');
  SetPropertyFromNode(node,'EmployeeId');
  SetPropertyFromNode(node,'EmployeeName');
  SetPropertyFromNode(node,'Comments');
  SetBooleanPropertyFromNode(node,'Deleted');
  SetPropertyFromNode(node,'ColdCalls');
  SetPropertyFromNode(node,'Contact');
  SetPropertyFromNode(node,'FirstDemo');
  SetPropertyFromNode(node,'SecondDemo');
  SetPropertyFromNode(node,'Quotes');
  SetPropertyFromNode(node,'SalesOrders');
  SetPropertyFromNode(node,'Sales');
  SetPropertyFromNode(node , 'BudgetIncome');
  SetPropertyFromNode(node , 'Budgetcost');
end;


procedure TSalesAnalysisManualLines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'SalesAnalysisID' ,SalesAnalysisID);
  AddXMLNode(node,'EmployeeId' ,EmployeeId);
  AddXMLNode(node,'EmployeeName' ,EmployeeName);
  AddXMLNode(node,'Comments' ,Comments);
  AddXMLNode(node,'Deleted' ,Deleted);
  AddXMLNode(node,'ColdCalls' ,ColdCalls);
  AddXMLNode(node,'Contact' ,Contact);
  AddXMLNode(node,'FirstDemo' ,FirstDemo);
  AddXMLNode(node,'SecondDemo' ,SecondDemo);
  AddXMLNode(node,'Quotes' ,Quotes);
  AddXMLNode(node,'SalesOrders' ,SalesOrders);
  AddXMLNode(node,'Sales' ,Sales);
  AddXMLNode(node , 'BudgetIncome' , 'BudgetIncome');
  AddXMLNode(node , 'Budgetcost' , 'Budgetcost');
end;


function TSalesAnalysisManualLines.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if EmployeeId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Employee should not be 0' , True );
    Exit;
  end;
  Result := True;
end;


function TSalesAnalysisManualLines.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TSalesAnalysisManualLines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TSalesAnalysisManualLines.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;




function TSalesAnalysisManualLines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TSalesAnalysisManualLines.GetIDField: string;
begin
  Result := 'ID'
end;


class function TSalesAnalysisManualLines.GetBusObjectTablename: string;
begin
  Result:= 'tblSalesAnalysisManuallines';
end;


function TSalesAnalysisManualLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
function  TSalesAnalysisManualLines.DoBeforeInsert(Sender:TDatasetBusObj) : Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not(result) then exit;
end;
function  TSalesAnalysisManualLines.DoAfterInsert(Sender:TDatasetBusObj) : Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not(result) then exit;
  if Assigned(Owner) then
    if Owner is TSalesAnalysisManual then
      SalesAnalysisID := TSalesAnalysisManual(Owner).ID;
end;
function  TSalesAnalysisManualLines.DoBeforePost(Sender:TDatasetBusObj) : Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not(result) then exit;
  if Recordblank then deleted := True;
end;
function  TSalesAnalysisManualLines.Recordblank :Boolean;
begin
    result:= (EmployeeId =0) and (ColdCalls =0) and (Contact =0) and (FirstDemo =0) and (SecondDemo  =0) and (Quotes  =0) and (SalesOrders  =0);
end;
{Property Functions}
function  TSalesAnalysisManualLines.GeTHeaderId        : Integer   ; begin Result := GetIntegerField('SalesAnalysisID');end;
function  TSalesAnalysisManualLines.GetEmployeeId      : Integer   ; begin Result := GetIntegerField('EmployeeId');end;
function  TSalesAnalysisManualLines.GetEmployeeName    : string    ; begin Result := GetStringField('EmployeeName');end;
function  TSalesAnalysisManualLines.GetComments        : string    ; begin Result := GetStringField('Comments');end;
function  TSalesAnalysisManualLines.GetDeleted         : Boolean   ; begin Result := GetBooleanField('Deleted');end;
function  TSalesAnalysisManualLines.GetColdCalls       : Integer   ; begin Result := GetIntegerField('ColdCalls');end;
function  TSalesAnalysisManualLines.GetContact         : Integer   ; begin Result := GetIntegerField('Contact');end;
function  TSalesAnalysisManualLines.GetFirstDemo       : Integer   ; begin Result := GetIntegerField('FirstDemo');end;
function  TSalesAnalysisManualLines.GetSecondDemo      : Integer   ; begin Result := GetIntegerField('SecondDemo');end;
function  TSalesAnalysisManualLines.GetQuotes          : Integer   ; begin Result := GetIntegerField('Quotes');end;
function  TSalesAnalysisManualLines.GetSalesOrders     : Integer   ; begin Result := GetIntegerField('SalesOrders');end;
function  TSalesAnalysisManualLines.GetSales           : Integer   ; begin Result := GetIntegerField('Sales');end;
function TSalesAnalysisManualLines.getBudgetIncome     : double;begin result:= getFloatfield('BudgetIncome'); end;
function TSalesAnalysisManualLines.getBudgetcost       : double;begin result:= getFloatfield('Budgetcost'); end;
procedure TSalesAnalysisManualLines.SeTHeaderId        (const Value: Integer   ); begin SetIntegerField('SalesAnalysisID'       , Value);end;
procedure TSalesAnalysisManualLines.SetEmployeeId      (const Value: Integer   ); begin SetIntegerField('EmployeeId'       , Value);end;
procedure TSalesAnalysisManualLines.SetEmployeeName    (const Value: string    ); begin SetStringField('EmployeeName'     , Value);end;
procedure TSalesAnalysisManualLines.SetComments        (const Value: string    ); begin SetStringField('Comments'     , Value);end;
procedure TSalesAnalysisManualLines.SetDeleted         (const Value: Boolean   ); begin SetBooleanField('Deleted'     , Value);end;
procedure TSalesAnalysisManualLines.SetBudgetIncome    (const Value: double);begin  Setfloatfield('BudgetIncome' , value);end;
procedure TSalesAnalysisManualLines.SetBudgetcost      (const Value: double);begin  Setfloatfield('Budgetcost' , value);end;
procedure TSalesAnalysisManualLines.SetColdCalls       (const Value: Integer   ); begin SetIntegerField('ColdCalls'        , Value);end;
procedure TSalesAnalysisManualLines.SetContact         (const Value: Integer   ); begin SetIntegerField('Contact'          , Value);end;
procedure TSalesAnalysisManualLines.SetFirstDemo       (const Value: Integer   ); begin SetIntegerField('FirstDemo'        , Value);end;
procedure TSalesAnalysisManualLines.SetSecondDemo      (const Value: Integer   ); begin SetIntegerField('SecondDemo'       , Value);end;
procedure TSalesAnalysisManualLines.SetQuotes          (const Value: Integer   ); begin SetIntegerField('Quotes'           , Value);end;
procedure TSalesAnalysisManualLines.SetSalesOrders     (const Value: Integer   ); begin SetIntegerField('SalesOrders'      , Value);end;
procedure TSalesAnalysisManualLines.SetSales           (const Value: Integer   ); begin SetIntegerField('Sales'            , Value);end;


initialization
  RegisterClass(TSalesAnalysisManualLines);
  RegisterClass(TSalesAnalysisManual);


end.
