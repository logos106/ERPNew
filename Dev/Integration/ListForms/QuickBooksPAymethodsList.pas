unit QuickBooksPaymethodsList;

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
  TQuickBooksPaymethodsListGUI = class(TQuickBooksListBaseGUI)
    qryMainName: TWideStringField;
    qryMainType: TWideStringField;
    qryMaindomain: TWideStringField;
    qryMainActive: TWideStringField;
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
  end;


implementation

uses CommonLib;

{$R *.dfm}

{ TQuickBooksPaymethodsListGUI }

procedure TQuickBooksPaymethodsListGUI.btntestClick(Sender: TObject);
begin
  inherited;
  LoaddataFromfile('i:\temp\to be deleted\PaymentMethod_List.Json');
end;

procedure TQuickBooksPaymethodsListGUI.ERPTable;
begin
  qrymain.sql.add('LEFT JOIN tblpaymentmethods ERP ON ERP.PayMethodID = ER.ERPID');
end;

procedure TQuickBooksPaymethodsListGUI.ERPTableFields;
begin
  qrymain.sql.add('ERP.NAME AS PaymentMethodName,');
end;

procedure TQuickBooksPaymethodsListGUI.Extrafields(const Value: TJsonObject);
begin
  inherited;

end;

function TQuickBooksPaymethodsListGUI.fieldsSQL(
  QBFieldList: TQBFieldList): String;
begin
  Result := inherited fieldsSQL(QBFieldList);
end;

procedure TQuickBooksPaymethodsListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  QBitem.QBFieldList.Stringfields.Add('Name');
  QBitem.QBFieldList.Stringfields.Add('Type');
  QBitem.QBFieldList.Stringfields.Add('domain');
  QBitem.QBFieldList.Stringfields.Add('Id');

  QBitem.QBFieldList.Booleanfield.Add('Active');
end;

function TQuickBooksPaymethodsListGUI.getjsonListName: String;
begin
  Result := SynchtypePaymethod;
end;

function TQuickBooksPaymethodsListGUI.QuickBooksListSearchDescription: String;
begin
  Result := Qrymainname.AsString;
end;
initialization
  RegisterClassOnce(TQuickBooksPaymethodsListGUI);

end.
