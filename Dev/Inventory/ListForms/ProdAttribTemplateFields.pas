unit ProdAttribTemplateFields;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  MatrixObj,ProdAttribGroups, DBCtrls;

type
  TProdAttribTemplateFieldsGUI = class(TProdAttribGroupsGUI)
    QryTemplatefields: TERPQuery;
    QryTemplatefieldsID: TIntegerField;
    QryTemplatefieldsGroupname: TWideStringField;
    QryTemplatefieldsPAG_ID: TIntegerField;
    QryTemplatefieldsSeqno: TIntegerField;
    QryTemplatefieldsName: TWideStringField;
    QryTemplatefieldsValue: TWideStringField;
    QryTemplatefieldsIsX: TWideStringField;
    report1n2: TSplitter;
    dsTemplatefields: TDataSource;
    QryTemplatefieldsTemplatefieldName: TStringField;
    pnlSub: TDNMPanel;
    grdBOA: TwwDBGrid;
    wwIButton1: TwwIButton;
    Label2: TLabel;
    DBText1: TDBText;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure QryTemplatefieldsCalcFields(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
  private
    fMatrixsale : TMatrixsale;
    function Matrixsale :TMatrixsale;
  Protected
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, tcConst;

{$R *.dfm}
{ TProdAttribTemplateFieldsGUI }
procedure TProdAttribTemplateFieldsGUI.ReadnApplyGuiPrefExtra;
var
  x:Integer;
begin
  inherited;
  x := GuiPrefs.Node['Options.verticalsplit'].asInteger;
  if x<=0 then x:= 235;
  pnlSub.width := x;
end;
procedure TProdAttribTemplateFieldsGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.verticalsplit'].asInteger := pnlSub.Width ;
end;

procedure TProdAttribTemplateFieldsGUI.RefreshQuery;
begin
  inherited;
  closedb(QryTemplatefields);
  Matrixsale.EmptyTables;
  IterateprocNo := 1;
  IterateRecords(True, WAITMSG);
  opendb(QryTemplatefields);
end;


procedure TProdAttribTemplateFieldsGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);
begin
  inherited;
  if IterateprocNo = 1 then begin
    Matrixsale.NamesRec(QrymainPAG_ID.asInteger);
  end;
end;
procedure TProdAttribTemplateFieldsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fMatrixsale := nil;
end;

procedure TProdAttribTemplateFieldsGUI.FormDestroy(Sender: TObject);
begin
  FreeandNil(fMatrixsale);
  inherited;

end;

procedure TProdAttribTemplateFieldsGUI.FormShow(Sender: TObject);
begin
  Matrixsale.MakeMatrixTables;
  closedb(QryTemplatefields);
  QryTemplatefields.SQL.text :='select * from ' + Matrixsale.Matrixtablename+'names order by Seqno';
  inherited;
end;

function TProdAttribTemplateFieldsGUI.Matrixsale: TMatrixsale;
begin
  if fMatrixsale = nil then begin
    fMatrixsale := TMatrixsale.create(Self);
  end;
  result := fMatrixsale;
end;

procedure TProdAttribTemplateFieldsGUI.QryTemplatefieldsCalcFields(DataSet: TDataSet);
begin
  inherited;
  if QryTemplatefieldsSeqno.asInteger =0 then
        QryTemplatefieldsTemplatefieldName.asString :=    'xName'
  else  QryTemplatefieldsTemplatefieldName.asString :=    'ExValue' + trim(Inttostr(QryTemplatefieldsSeqno.asInteger));
end;

initialization
  RegisterClassOnce(TProdAttribTemplateFieldsGUI);

end.

