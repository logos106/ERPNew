unit QuickBooksAccountsList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QuickBooksListBase, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel,JSONObject,QuickBooksIDListObj ;

type
  TQuickBooksAccountsListGUI = class(TQuickBooksListBaseGUI)
    qryMainFullyQualifiedName: TWideStringField;
    qryMainName: TWideStringField;
    qryMainClassification: TWideStringField;
    qryMainAccountSubType: TWideStringField;
    qryMainAccountType: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainSubAccount: TWideStringField;
    qryMainCurrencyRef: TWideStringField;
    qryMainCurrencyvalue: TWideStringField;
    qryMainaccountname: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure btntestClick(Sender: TObject);
  private
  Protected
    function GetJsonListName: String;Override;
    procedure Extrafields(const Value: TJsonObject);Override;
    function FieldsSQL(QBFieldList:TQBFieldList): String;Override;
    function QuickBooksListSearchDescription:String;Override;
    Procedure ERPTableFields;Override;
    Procedure ERPTable;Override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib;

{$R *.dfm}

{ TQuickBooksAccountsListGUI }
function TQuickBooksAccountsListGUI.getjsonListName: String;
begin
  Result := SynchtypeAccount;
end;

function TQuickBooksAccountsListGUI.QuickBooksListSearchDescription: String;
begin
  Result := Qrymainname.AsString;
end;

procedure TQuickBooksAccountsListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  QBitem.QBFieldList.Stringfields.Add('FullyQualifiedName');
  QBitem.QBFieldList.Stringfields.Add('Name');
  QBitem.QBFieldList.Stringfields.Add('Classification');
  QBitem.QBFieldList.Stringfields.Add('AccountSubType');
  QBitem.QBFieldList.Stringfields.Add('AccountType');
  QBitem.QBFieldList.Stringfields.Add('Id');

  QBitem.QBFieldList.Booleanfield.Add('Active');
  QBitem.QBFieldList.Booleanfield.Add('SubAccount');

end;

function TQuickBooksAccountsListGUI.fieldsSQL(QBFieldList:TQBFieldList): String;
begin
  Result := inherited fieldsSQL(QBFieldList);
  result := result +'CurrencyRef varchar(255) null default null ,'+
                    'Currencyvalue varchar(255) null default null ,';
end;

procedure TQuickBooksAccountsListGUI.btntestClick(Sender: TObject);
begin
  inherited;
  LoaddataFromfile('i:\temp\to be deleted\temp.json');
end;

procedure TQuickBooksAccountsListGUI.Extrafields(const Value: TJsonObject);
begin
  inherited;
  with scriptmain do begin
     SQL.add('CurrencyRef =' + QuotedStr(Value.O['CurrencyRef'].S['name'])+',');
     SQL.add('Currencyvalue =' + QuotedStr(Value.O['CurrencyRef'].S['value']) +',');
  end;
end;
Procedure TQuickBooksAccountsListGUI.ERPTableFields;
begin
  qrymain.sql.add('ERP.accountname AS accountname,');
end;
Procedure TQuickBooksAccountsListGUI.ERPTable;
begin
  qrymain.sql.add('LEFT JOIN tblchartofaccounts ERP ON ERP.accountid = ER.ERPID');
end;

initialization
  RegisterClassOnce(TQuickBooksAccountsListGUI);

end.
