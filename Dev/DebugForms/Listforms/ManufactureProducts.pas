unit ManufactureProducts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, StdCtrls, Buttons, Wwdbigrd,
  Grids, Wwdbgrid, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader, wwcheckbox;

type
  TManufactureProductsGUI = class(TBaseListingGUI)
    cmdfix: TDNMSpeedButton;
    qryMainPARTSID: TIntegerField;
    qryMainPARTTYPE: TWideStringField;
    qryMainPARTNAME: TWideStringField;
    qryMainPARTSDESCRIPTION: TWideStringField;
    qryMainTreeId: TIntegerField;
    procedure cmdfixClick(Sender: TObject);
  private
    procedure createSalesbackup;
  Protected
    procedure IterateselectedRecordsCallback(var Abort: boolean;SelIndex: Integer);override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, BusObjProcess, CommonDbLib;

{$R *.dfm}

procedure TManufactureProductsGUI.cmdfixClick(Sender: TObject);
begin
  inherited;
  if qrymain.RecordCount=0 then exit;

  if grdmain.SelectedList.Count =0 then
    if MessageDlgXP_Vista('No Product selected for recalculation. Do you wish to select aal products?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit
    else grdmain.selectall;

  if grdmain.SelectedList.Count =0 then Exit;

  createSalesbackup;

  IterateProcno:= 1;
  IterateselectedRecords(true);

end;
procedure TManufactureProductsGUI.createSalesbackup;
begin
  if Tableexists('erpfix_proctree') and (MessageDlgXP_Vista('Do you wish to re-create the backup tables?', mtConfirmation, [mbYes, mbNo], 0)= mrno) then exit;
  TimerMsg(lblNote , 'Backing up tables', 30 );
  With TempMyScript do try

    SQL.add('Drop table if exists erpfix_proctree;');
    SQL.add('create table erpfix_proctree like tblproctree;');
    SQL.add('insert into erpfix_proctree select * from tblproctree;');

    SQL.add('Drop table if exists erpfix_processpart;');
    SQL.add('create table erpfix_processpart like tblprocesspart;');
    SQL.add('insert into erpfix_processpart select * from tblprocesspart;');

    execute;
  finally
    Free;
  end;

end;
procedure TManufactureProductsGUI.IterateselectedRecordsCallback(  var Abort: boolean; SelIndex: Integer);
var
  TempNode : TProcTreeNode;
begin
  inherited;
  if IterateProcno = 1 then begin
    TimerMsg(lblNote , inttostr(qrymain.RecNo) +' of ' +inttostr(qrymain.RecordCount) );
    TempNode := TProcTreeNode.Create(nil);
  try
                TempNode.ProcTreeId := QrymainTreeID.asInteger;
                TempNode.LoadTree;
                TempNode.CalcQty;
                TempNode.SaveNoCheck;
  finally
    FreeandNil(TempNode);
  end;
  end;
end;
initialization
  RegisterClassOnce(TManufactureProductsGUI);

end.

