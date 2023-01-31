unit VS1DefaultList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TVS1DefaultListGUI = class(TBaseListingGUI)
    qryMainTablename: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainRegionname: TWideStringField;
    qryMainKeyvalue: TWideStringField;
    procedure FormCreate(Sender: TObject);
  private
    Procedure MakeQrymain;
  Protected
    procedure SetGridColumns; Override;
  public
    { Public declarations }
  end;

implementation

uses CommonLib, AppEnvironment;

{$R *.dfm}
{ TVS1DefaultListGUI }

procedure TVS1DefaultListGUI.FormCreate(Sender: TObject);
begin
  makeQrymain;
  inherited;
  HaveDateRangeSelection := False;
end;

procedure TVS1DefaultListGUI.MakeQrymain;
begin
  qrymain.sql.Clear;
  qrymain.sql.add('SELECT DISTINCT');
  qrymain.sql.add('Tablename as Tablename,');
  qrymain.sql.add('if(tablename="tblchartofaccounts"  , "Accounts", '+
                  'if(tablename="tblclients"          , "Customers / Suppliers", '+
                  'if(tablename="tblparts"            , '+ quotedstr(AppEnv.DefaultClass.PartColumn)+', '+
                  'if(tablename="tblpaymentmethods"   , "Payment Methods", '+
                  'if(tablename="tbltaxcodes"         , "Taxcodes", '+
                  'if(tablename="tblterms"            , "Terms", '+
                  'Tablename)))))) AS Description, ');
  qrymain.sql.add('Regionname as Regionname,');
  qrymain.sql.add('Keyvalue as Keyvalue');
  qrymain.sql.add('FROM tblnewvs1dbdefaults');
qrymain.sql.add('ORDER BY Description');
end;

procedure TVS1DefaultListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainTablename.fieldname);
end;

initialization
  RegisterClassOnce(TVS1DefaultListGUI);

end.
