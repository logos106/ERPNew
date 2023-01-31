unit WorkshopPrefs;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 03/05/07  1.00.01 DSP  First version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, wwdbedit, wwclearbuttongroup, wwradiogroup, Mask,
  Wwdbspin, wwcheckbox, ExtCtrls, DNMPanel, DB, DataSourcePrefs, DBAccess,
  MyAccess,ERPdbComponents, MessageConst, frmBase, BasePrefs, MemDS, wwdblook,
  Menus, DNMSpeedButton, wwdbdatetimepicker, ERPDbLookupCombo, DBCtrls,
  AdvScrollBox;

type
  TWorkshopPrefsGUI = class(TBasePrefsGUI)
    lblWidth: TLabel;
    MyConnection: TERPConnection;
    dsPrefs: TDataSourcePrefs;
    qryInvoiceStatus: TERPQuery;
    qrySalesOrderStatus: TERPQuery;
    QryStatusforInvoice: TERPQuery;
    QryStatusforInvoicename: TWideStringField;
    QryStatusforInvoiceid: TIntegerField;
    dsColumnHeadings: TDataSource;
    qryColumnHeadings: TERPQuery;
    DNMPanel2: TDNMPanel;
    Bevel2: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    wwDBEdit1: TwwDBEdit;
    wwDBEdit2: TwwDBEdit;
    DNMPanel1: TDNMPanel;
    Bevel1: TBevel;
    Label3: TLabel;
    Label6: TLabel;
    Label4: TLabel;
    wwDBLookupCombo1: TwwDBLookupCombo;
    wwDBLookupCombo2: TwwDBLookupCombo;
    wwCheckBox4: TwwCheckBox;
    memNewRepairNotes: TDBMemo;
    chkAddNotesToNewRepair: TwwCheckBox;
    DNMPanel4: TDNMPanel;
    Bevel4: TBevel;
    Label9: TLabel;
    Label8: TLabel;
    wwCheckBox6: TwwCheckBox;
    wwCheckBox2: TwwCheckBox;
    cboStatusforInvoice: TwwDBLookupCombo;
    DNMPanel3: TDNMPanel;
    Bevel3: TBevel;
    Label7: TLabel;
    wwCheckBox5: TwwCheckBox;
    wwCheckBox1: TwwCheckBox;
    chkRepairDoneOnConversion: TwwCheckBox;
    wwCheckBox3: TwwCheckBox;
    procedure FormShow(Sender: TObject);
  private
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
    procedure PerformFinish(var Msg: TMessage); message TX_PerformFinish;
  Protected
      procedure StartupProcess(var Msg: TMessage); Override;
      procedure FinishProcess(var Msg: TMessage); Override;
  public
    { Public declarations }
  end;

implementation

uses CommonLib, tcConst;

{$R *.dfm}

{ TWorkshopPrefsGUI }

procedure TWorkshopPrefsGUI.FormShow(Sender: TObject);
begin
  inherited;
//
end;


procedure TWorkshopPrefsGUI.PerformStartup(var Msg: TMessage);
begin
  DoPerformStartup(Msg);
end;

procedure TWorkshopPrefsGUI.StartupProcess(var Msg: TMessage);
begin
  inherited;
//
end;
procedure TWorkshopPrefsGUI.PerformFinish(var Msg: TMessage);
begin
  DoPrefformFinish(Msg);
end;
procedure TWorkshopPrefsGUI.FinishProcess(var Msg: TMessage);
begin
  if qryColumnHeadings.State in [dsEdit, dsInsert] then
    qryColumnHeadings.Post;
  editdB(dsPrefs.DataSet);
end;

initialization
  RegisterClassOnce(TWorkshopPrefsGUI);
finalization
  UnRegisterClass(TWorkshopPrefsGUI);
end.
