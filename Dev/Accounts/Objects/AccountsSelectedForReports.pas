unit AccountsSelectedForReports;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  17/03/09  1.00.00  BJ  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TSelectedAccountsforReports = class(TMSBusObj)
  private

    function GetAccounttypeID    : Integer   ;
    function GetAccountType      : string    ;
    function GetAccountId        : Integer   ;
    function GetAccountname      : string    ;
    procedure SetAccounttypeID    (const Value: Integer   );
    procedure SetAccountType      (const Value: string    );
    procedure SetAccountId        (const Value: Integer   );
    procedure SetAccountname      (const Value: string    );
  protected
    fsObjAcountType: String;
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    Procedure DeleteAllsubAccounts;
    Function HasHeaderSelected:Boolean;

  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    function     AllAccountIds:String;

    class Function NewObjInstance :TSelectedAccountsforReports;virtual; abstract;
  published
    property AccounttypeID     :Integer     read GetAccounttypeID   write SetAccounttypeID;
    property AccountType       :string      read GetAccountType     write SetAccountType  ;
    property AccountId         :Integer     read GetAccountId       write SetAccountId    ;
    property Accountname       :string      read GetAccountname     write SetAccountname  ;
    Property ObjAcountType     :String      Read fsObjAcountType;
  end;

  TIncomeConfigAccounts  =Class(TSelectedAccountsforReports)
    Protected
    Public
      class Function NewObjInstance :TSelectedAccountsforReports; override;
      constructor  Create(AOwner: TComponent); override;

  End;
  TExpenseConfigAccounts  =Class(TSelectedAccountsforReports)
    Protected
    Public
      class Function NewObjInstance :TSelectedAccountsforReports; override;
      constructor  Create(AOwner: TComponent); override;
  End;
  TCOGSConfigAccounts  =Class(TSelectedAccountsforReports)
    Protected
    Public
      class Function NewObjInstance :TSelectedAccountsforReports; override;
      constructor  Create(AOwner: TComponent); override;
  End;
  TAssetConfigAccounts  =Class(TSelectedAccountsforReports)
    Protected
    Public
      class Function NewObjInstance :TSelectedAccountsforReports; override;
      constructor  Create(AOwner: TComponent); override;
  End;
  TLiabilityConfigAccounts  =Class(TSelectedAccountsforReports)
    Protected
    Public
      class Function NewObjInstance :TSelectedAccountsforReports; override;
      constructor  Create(AOwner: TComponent); override;
  End;


implementation


uses tcDataUtils, CommonLib, FastFuncs, sysutils;



  {TSelectedAccountsforReports}

constructor TSelectedAccountsforReports.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'IncomeExpenseConfigAccounts';
  fSQL := 'SELECT * FROM tblSelectedAccountsforReprots';
  if fsObjAcountType <> '' then fSQL:= fSQL + ' where  accounttype  in ('+ fsObjAcountType+')' ;
end;

procedure TSelectedAccountsforReports.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'AccounttypeID');
  SetPropertyFromNode(node,'AccountType');
  SetPropertyFromNode(node,'AccountId');
  SetPropertyFromNode(node,'Accountname');
end;


procedure TSelectedAccountsforReports.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'AccounttypeID' ,AccounttypeID);
  AddXMLNode(node,'AccountType' ,AccountType);
  AddXMLNode(node,'AccountId' ,AccountId);
  AddXMLNode(node,'Accountname' ,Accountname);
end;


function TSelectedAccountsforReports.ValidateData: Boolean ;
begin
(*  Result := False;*)
  Resultstatus.Clear;
  Result := True;
end;


function TSelectedAccountsforReports.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TSelectedAccountsforReports.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;
function TSelectedAccountsforReports.HasHeaderSelected: Boolean;
var
  strSQL:string;
begin
  strSQL:= 'Select IEA.ID ' +
          ' from   tblchartofaccounts COA ' +
          ' inner join tblchartofaccounts MA on    ' +
          ' (MA.AccountName = COA.Level1 or  MA.AccountName = COA.Level2 or  MA.AccountName = COA.Level3 or  MA.AccountName = COA.Level4 ) and MA.AccountId <> COA.accountID ' +
          ' inner join tblSelectedAccountsforReprots IEA on    ' +
          ' IEA.AccountId = MA.accountId  and IEA.accountType in ('+ fsObjAcountType+')' +
          ' where COA.AccountId =  ' +IntToStr(AccountID);
  With getNewDataset(strSQL, true) do try
       REsult := Recordcount > 0;
  finally
      if active then Close;
      free;
  end;

end;
procedure TSelectedAccountsforReports.DeleteAllsubAccounts;
var
  strSql:String;
begin
  strSql:= 'Select IEA.ID from  ' +
            ' tblchartofaccounts COA ' +
            ' inner join tblchartofaccounts SA on  ' +
            ' (SA.Level1 = COA.AccountName or ' +
            ' SA.Level2 = COA.AccountName or ' +
            ' SA.Level3 = COA.AccountName or ' +
            ' SA.Level4 = COA.AccountName ) and SA.AccountId <> COA.accountID ' +
            ' inner join tblSelectedAccountsforReprots IEA on  ' +
            ' IEA.AccountId = SA.accountId  and IEA.accountType in ('+ fsObjAcountType+')' +
            ' where COA.AccountId =  ' +IntToStr(AccountID);
  With getNewDataset(strSQL, true) do try
       if recordcount = 0 then exit;
       First;
       while Eof = False do begin
        if Dataset.Locate('ID' , FieldByname('ID').asInteger , []) then Self.Delete;
        Next;
       end;
  finally
      if active then Close;
      free;
  end;


end;

procedure TSelectedAccountsforReports.DoFieldOnChange(Sender: TField);
var
  s:String;
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
    inherited;
    if Sysutils.SameText(Sender.FieldName , 'AccountID') then begin
      DeleteAllsubAccounts;
      if HasHeaderSelected then begin
          Cancel;
          Exit;
      end;
      s:= 'SELECT A.AccountType,A.AccountName,tblacctypedesc.TypeID ' +
            ' FROM tblchartofaccounts AS A  ' +
            ' Inner Join tblacctypedesc ON A.AccountType = tblacctypedesc.AccType  ' +
            ' where accountId = ' +IntToStr(AccountID);
       with GetNewdataset(s, true) do try
          AccounttypeID := fieldByname('TypeID').asInteger;
          AccountType   := fieldByname('AccountType').asSTring;
          Accountname   := fieldByname('Accountname').asString;
       finally
           if active then close;
           Free;
       end;
    end;

end;


function TSelectedAccountsforReports.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TSelectedAccountsforReports.GetIDField: string;
begin
  Result := 'ID'
end;


class function TSelectedAccountsforReports.GetBusObjectTablename: string;
begin
  Result:= 'tblSelectedAccountsforReprots';
end;


function TSelectedAccountsforReports.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TSelectedAccountsforReports.GetAccounttypeID: Integer   ; begin Result := GetIntegerField('AccounttypeID');end;
function  TSelectedAccountsforReports.GetAccountType  : string    ; begin Result := GetStringField('AccountType');end;
function  TSelectedAccountsforReports.GetAccountId    : Integer   ; begin Result := GetIntegerField('AccountId');end;
function  TSelectedAccountsforReports.GetAccountname  : string    ; begin Result := GetStringField('Accountname');end;
procedure TSelectedAccountsforReports.SetAccounttypeID(const Value: Integer   ); begin SetIntegerField( 'AccounttypeID', Value);end;
procedure TSelectedAccountsforReports.SetAccountType  (const Value: string    ); begin SetStringField('AccountType'   , Value);end;
procedure TSelectedAccountsforReports.SetAccountId    (const Value: Integer   ); begin SetIntegerField('AccountId'     , Value);end;
procedure TSelectedAccountsforReports.SetAccountname  (const Value: string    ); begin SetStringField('Accountname'   , Value);end;


function TSelectedAccountsforReports.AllAccountIds: String;
var
  strSQL:String;
begin
  strSQL:= 'Select group_Concat(AccountID) accountIDs  from tblchartofaccounts ' +
            ' where AccountName ='+QuotedStr(Accountname) +
            ' or Level1 = '+QuotedStr(Accountname) +
            ' or Level2 = '+QuotedStr(Accountname) +
            ' or LEVEL3 = '+QuotedStr(Accountname) +
            ' or Level4 = '+QuotedStr(Accountname) ;
  With getNewdataset(strSQL, true) do try
    Result := FieldByname('accountIDs').asString;
  finally
      if active then close;
      Free;
  end;
end;



{ TCOGSConfigAccounts }
constructor TCOGSConfigAccounts.Create(AOwner: TComponent);
begin
  fsObjAcountType :=QuotedStr('COGS');
  inherited;
end;


class function TCOGSConfigAccounts.NewObjInstance: TSelectedAccountsforReports;
begin
  result := TCOGSConfigAccounts(GetComponentByClassName('TCOGSConfigAccounts'));
  Result.Load;
end;

{ TExpenseConfigAccounts }

constructor TExpenseConfigAccounts.Create(AOwner: TComponent);
begin
  fsObjAcountType :=QuotedStr('EXP');
  inherited;
end;


class function TExpenseConfigAccounts.NewObjInstance: TSelectedAccountsforReports;
begin
  result := TExpenseConfigAccounts(GetComponentByClassName('TExpenseConfigAccounts'));
  Result.Load;
end;

{ TIncomeConfigAccounts }

constructor TIncomeConfigAccounts.Create(AOwner: TComponent);
begin
  fsObjAcountType :=QuotedStr('INC');
  inherited;
end;


class function TIncomeConfigAccounts.NewObjInstance: TSelectedAccountsforReports;
begin
  result := TIncomeConfigAccounts(GetComponentByClassName('TIncomeConfigAccounts'));
  Result.Load;
end;

{ TAssetConfigAccounts }

constructor TAssetConfigAccounts.Create(AOwner: TComponent);
begin
  fsObjAcountType :=Quotedstr('FIXASSET')+',' +Quotedstr('OCASSET')+',' +Quotedstr('EQUITY')+',' +Quotedstr('OASSET');
  inherited;

end;

class function TAssetConfigAccounts.NewObjInstance: TSelectedAccountsforReports;
begin
  result := TCOGSConfigAccounts(GetComponentByClassName('TAssetConfigAccounts'));
  Result.Load;
end;

{ TLiabilityConfigAccounts }

constructor TLiabilityConfigAccounts.Create(AOwner: TComponent);
begin
  fsObjAcountType :=Quotedstr('OCLIAB')+',' +Quotedstr('LTLIAB')+',' +Quotedstr('CCARD');
  inherited;
end;

class function TLiabilityConfigAccounts.NewObjInstance: TSelectedAccountsforReports;
begin
  result := TCOGSConfigAccounts(GetComponentByClassName('TLiabilityConfigAccounts'));
  Result.Load;
end;

initialization
  RegisterClass(TCOGSConfigAccounts);
  RegisterClass(TExpenseConfigAccounts);
  RegisterClass(TIncomeConfigAccounts);
  RegisterClass(TLiabilityConfigAccounts);
  RegisterClass(TAssetConfigAccounts);

end.

