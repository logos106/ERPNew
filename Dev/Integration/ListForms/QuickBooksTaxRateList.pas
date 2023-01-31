unit QuickBooksTaxRateList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QuickBooksListBase, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel,JSONObject,QuickBooksIDListObj;

type
  TQuickBooksTaxRateListGUI = class(TQuickBooksListBaseGUI)
    qryMainName: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainSpecialTaxType: TWideStringField;
    qryMainDisplayType: TWideStringField;
    qryMaindomain: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainRateValue: TFloatField;
    qryMainERPCode: TWideStringField;
    qryMainERPDescription: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure btntestClick(Sender: TObject);
  private
    //fsNametoSearch: String;
    //procedure setNametoSearch(const Value: String);
  Protected
    function  GetJsonListName: String;Override;
    function  QuickBooksListSearchDescription:String;Override;
    procedure Extrafields(const Value: TJsonObject);Override;
    function  FieldsSQL(QBFieldList:TQBFieldList): String;Override;
    Procedure ERPTableFields;Override;
    Procedure ERPTable;Override;
  public
    //Property NametoSearch  :String read fsNametoSearch  write setNametoSearch ;
  end;

implementation

uses CommonLib, BusObjTaxCodes, BusobjExternalXRef;

{$R *.dfm}

{ TQuickBooksTaxRateListGUI }

procedure TQuickBooksTaxRateListGUI.btntestClick(Sender: TObject);
begin
  inherited;
  LoaddataFromfile('i:\temp\to be deleted\TaxRate_List.json');
end;

procedure TQuickBooksTaxRateListGUI.Extrafields(const Value: TJsonObject);
begin
  inherited;
  with scriptmain do begin
     SQL.add('AgencyRef =' + QuotedStr(Value.O['AgencyRef'].S['Value'])+',');
  end;
end;

function TQuickBooksTaxRateListGUI.fieldsSQL(QBFieldList:TQBFieldList): String;
begin
  Result := inherited fieldsSQL(QBFieldList);
  result := result +'AgencyRef varchar(255) null default null ,';

end;

procedure TQuickBooksTaxRateListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  QBitem.QBFieldList.Stringfields.Add('Name');
  QBitem.QBFieldList.Stringfields.Add('Description');
  QBitem.QBFieldList.Stringfields.Add('Id');
  QBitem.QBFieldList.Stringfields.Add('SpecialTaxType');
  QBitem.QBFieldList.Stringfields.Add('DisplayType');
  QBitem.QBFieldList.Stringfields.Add('domain');

  QBitem.QBFieldList.Booleanfield.Add('Active');

  QBitem.QBFieldList.Doublefields.add('RateValue');
end;

function TQuickBooksTaxRateListGUI.getjsonListName: String;
begin
  Result := SynchtypeTaxRate;
//  result := 'TaxRate';
end;

function TQuickBooksTaxRateListGUI.QuickBooksListSearchDescription: String;
begin
  Result := Qrymainname.AsString;
end;

Procedure  TQuickBooksTaxRateListGUI.ERPTableFields;
begin
  Qrymain.SQL.add('ERP.code AS ERPCode,');
  Qrymain.SQL.add('ERP.Description AS ERPDescription,');
end;
Procedure  TQuickBooksTaxRateListGUI.ERPTable;
begin
  Qrymain.SQL.add('LEFT JOIN tblsubtaxcode ERP ON ERP.id = ER.ERPID');

end;

initialization
  RegisterClassOnce(TQuickBooksTaxRateListGUI);

end.

