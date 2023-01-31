unit ProctreePartFix;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  BusObjBase, CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TProctreePartFixGUI = class(TBaseListingGUI)
    btnFix: TDNMSpeedButton;
    qryMainsaleId: TIntegerField;
    qryMaincustomername: TWideStringField;
    qryMaintotalamountinc: TFloatField;
    qryMainsaleDate: TDateField;
    procedure btnFixClick(Sender: TObject);
  private
    procedure ProcesscheckCallback(const Sender: TBusObj; var Abort: Boolean);
  Protected
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
  public
    { Public declarations }
  end;


implementation

uses
  CommonLib, BusObjSales, SalesConst,  CommonDbLib, AppEnvironment, AppDatabase,
  ERPVersionConst;

{$R *.dfm}

procedure TProctreePartFixGUI.btnFixClick(Sender: TObject);
var
  fixtablename :String;
begin
  inherited;
  With ScriptMain do begin
    SQL.clear;
    fixtablename:= 'ERPFIX_PTP' + replacestr(TABLE_VERSION, '.' , '');
    if not (Tableexists(fixtablename)) then begin
      SQL.Add('create table ' + fixtablename +' like tblprocesspart;');
      SQL.Add('insert ignore into ' + fixtablename +' select * from tblprocesspart;' );
      execute;
    end;
  end;
  IterateProcNo := 1;
  IterateselectedRecords(True);
end;

procedure TProctreePartFixGUI.ProcesscheckCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not (Sender is TSalesorderline) then exit;
  if TSalesorderline(Sender).HasProcess then begin
     TSalesorderline(Sender).DoContainerEvent(TSalesorderline(Sender), evSalesLineQtyChange);
     TSalesorderline(Sender).PostDB;
  end;

end;
procedure TProctreePartFixGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);
var
  SO:TSalesOrder;
begin
  inherited;
  if IterateProcNo = 1 then begin
    SO:= TSalesOrder.CreateWithNewConn(Self);
    try
      So.Load(QrymainSaleID.asInteger);
      So.Accessmanager.AccessLevel:= 1;
      SO.InstantiateAllTrees;
      So.Lines.IterateRecords(ProcesscheckCallback);
    finally
      Freeandnil(SO);
    end;
  end;
end;

initialization
  RegisterClassOnce(TProctreePartFixGUI);

end.

