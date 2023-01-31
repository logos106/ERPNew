unit QuickBooksTermsList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QuickBooksListBase, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TQuickBooksTermsListGUI = class(TQuickBooksListBaseGUI)
    qryMainName: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainType: TWideStringField;
    qryMainDueDays: TIntegerField;
    qryMainDiscountDays: TIntegerField;
    qryMaintermname: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure btntestClick(Sender: TObject);
  private
  Protected
    function GetJsonListName: String;Override;
    function QuickBooksListSearchDescription:String;Override;
    Procedure ERPTableFields;Override;
    Procedure ERPTable;Override;
  public
  end;

implementation

uses  JSONObject, CommonLib;



{$R *.dfm}

{ TQuickBooksTermsListGUI }

procedure TQuickBooksTermsListGUI.btntestClick(Sender: TObject);
begin
  inherited;
  LoaddataFromfile('i:\temp\to be deleted\Terms_List.json');
end;

procedure TQuickBooksTermsListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  QBitem.QBFieldList.Stringfields.Add('Name');
  QBitem.QBFieldList.Stringfields.Add('Type');
  QBitem.QBFieldList.Stringfields.Add('Id');
  QBitem.QBFieldList.IntegerFields.Add('DueDays');
  QBitem.QBFieldList.IntegerFields.Add('DiscountDays');

  QBitem.QBFieldList.Booleanfield.Add('Active');
end;

function TQuickBooksTermsListGUI.getjsonListName: String;
begin
    Result := SynchtypeTerm;
end;
function TQuickBooksTermsListGUI.QuickBooksListSearchDescription: String;
begin
  Result := Qrymainname.AsString;
end;
Procedure TQuickBooksTermsListGUI.ERPTableFields;
begin
  qrymain.sql.add('ERP.Terms AS termname,');
end;
Procedure TQuickBooksTermsListGUI.ERPTable;
begin
  qrymain.sql.add('LEFT JOIN tblterms ERP ON ERP.TermsID = ER.ERPID');
end;


initialization
  RegisterClassOnce(TQuickBooksTermsListGUI);

end.
