unit ProductlisttorecalcAvgCost;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, StdCtrls, Buttons, Wwdbigrd,
  Grids, Wwdbgrid, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader;

type
  TProductlisttorecalcAvgCostGUI = class(TBaseListingGUI)
    qryMainPartsId: TIntegerField;
    qryMainPartname: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainCost1: TFloatField;
    qryMaincostinc1: TFloatField;
    qryMainCost2: TFloatField;
    qryMaincostinc2: TFloatField;
    qryMainCost3: TFloatField;
    qryMaincostinc3: TFloatField;
    qryMainAvgCost: TFloatField;
    btnRecalc: TDNMSpeedButton;
    qryMainoldAvgcost: TFloatField;
    qryMainAvgcostdiff: TFloatField;
    procedure btnRecalcClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormShow(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grpFiltersClick(Sender: TObject);override;
  private
    Procedure createProductbackup;
    Procedure ChangeQuery;
  Protected
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
    procedure SetGridColumns; Override;
  public
    { Public declarations }
  end;

implementation

uses CommonLib, BusObjStock, CommonDbLib;

{$R *.dfm}
procedure TProductlisttorecalcAvgCostGUI.btnRecalcClick(Sender: TObject);
begin
  inherited;
  if qrymain.RecordCount=0 then exit;

  if grdmain.SelectedList.Count =0 then
    if MessageDlgXP_Vista('No Product selected for recalculation. Do you wish to select aal products?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit
    else grdmain.selectall;

  createProductbackup;
  IterateProcno:= 1;
  IterateselectedRecords(true);
  changeQuery;
  RefreshQuery;
end;

procedure TProductlisttorecalcAvgCostGUI.ChangeQuery;
begin
  if tableexists('erpfix_partsavgcost') then begin
    Qrymain.DisableControls;
    try
      closedb(Qrymain);
      Qrymain.SQL.clear;
      Qrymain.SQL.Add('select');
      Qrymain.SQL.Add('P.PartsId as PartsId,');
      Qrymain.SQL.Add('P.Partname  as Partname,');
      Qrymain.SQL.Add('P.Active as Active,');
      Qrymain.SQL.Add('P.Cost1 as Cost1,');
      Qrymain.SQL.Add('P.costinc1 as costinc1,');
      Qrymain.SQL.Add('P.Cost2 as Cost2,');
      Qrymain.SQL.Add('P.costinc2 as costinc2 ,');
      Qrymain.SQL.Add('P.Cost3 as Cost3,');
      Qrymain.SQL.Add('P.costinc3 as costinc3,');
      Qrymain.SQL.Add('P.AvgCost as AvgCost,');
      Qrymain.SQL.Add('T.AvgCost as oldAvgcost');
      Qrymain.SQL.Add('from tblParts P ');
      Qrymain.SQL.Add('left join   erpfix_partsavgcost t on P.partsId = t.partsId');
      Qrymain.SQL.Add('where P.Parttype = "INV"');
      Qrymain.SQL.Add('order by partname');
      RefreshOrignalSQL;
      GuiPrefs.DbGridElement[grdMain].AddFields('oldAvgcost');
    finally
      Qrymain.EnableControls;
    end;
  end;
end;

procedure TProductlisttorecalcAvgCostGUI.createProductbackup;
begin
  if Tableexists('erpfix_partsavgcost') and (MessageDlgXP_Vista('Do you wish to re-create the backup table?', mtConfirmation, [mbYes, mbNo], 0)= mrno) then exit;

  With TempMyScript do try
    (*SQL.add('CREATE TABLE if not exists `erpfix_partsavgcost` ( 	`PartsId` INT(10) NULL, 	`Avgcost` DOUBLE NULL, 	`DtUpdated` Date NULL, 	PRIMARY KEY (`PartsId`)  ) COLLATE="utf8_general_ci" ENGINE=MyISAM;');
    SQL.add('insert into erpfix_partsavgcost select partsId , AvgCost , curDate() from tblparts where parttype = "INV" ON DUPLICATE KEY UPDATE DtUpdated =curdate() ,erpfix_partsavgcost.Avgcost = tblparts.Avgcost ;');*)
    SQL.add('Drop table if exists erpfix_partsavgcost;');
    SQL.add('create table erpfix_partsavgcost like tblparts;');
    SQL.add('insert into erpfix_partsavgcost select * from tblparts;');
    execute;
  finally
    Free;
  end;
end;

procedure TProductlisttorecalcAvgCostGUI.FormShow(Sender: TObject);
begin
  ChangeQuery;
  inherited;

end;

procedure TProductlisttorecalcAvgCostGUI.grdMainCalcCellColors(Sender: TObject;Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;ABrush: TBrush);
begin
  inherited;
  if Qrymainavgcost.asFloat <> qrymainoldAvgcost.asfloat then
    Afont.Color:= clGreen;
end;

procedure TProductlisttorecalcAvgCostGUI.grpFiltersClick(Sender: TObject);
begin
  if grpfilters.ItemIndex =0 then
    GroupFilterString := 'Avgcostdiff <> 0'
  else
    GroupFilterString := '';
  inherited;
end;

procedure TProductlisttorecalcAvgCostGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);
begin
  inherited;
  if IterateProcno = 1 then begin
    With   TProduct.CreateWithNewConn(Self) do try
      Load(Qrymainpartsid.AsInteger);
      if count= 1 then begin
        AverageCost:= AvgCost;
        postDB;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TProductlisttorecalcAvgCostGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryMainAvgcostdiff.AsFloat := abs(Qrymainavgcost.asFloat - qrymainoldAvgcost.asfloat);
end;

procedure TProductlisttorecalcAvgCostGUI.SetGridColumns;
begin
  inherited;
  //RemoveFieldfromGrid(qryMainoldAvgcost.fieldname);
end;

initialization
  RegisterClassOnce(TProductlisttorecalcAvgCostGUI);

end.

