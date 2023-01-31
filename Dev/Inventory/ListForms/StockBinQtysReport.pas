unit StockBinQtysReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StockQtysLocationsBase, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TStockBinQtysReportGUI = class(TStockQtysLocationsBaseGUI)
    procedure FormCreate(Sender: TObject);
  private
  Protected
    procedure PopulateData;Override;
    procedure MakeQryMain;Override;
    Function ExpressDetailListName:String;Override;
    Procedure RefreshTotals;Override;

  public
  end;

implementation

uses CommonLib, CommonDbLib;

{$R *.dfm}

function TStockBinQtysReportGUI.ExpressDetailListName: String;
begin
  REsult := 'TStockQtysLocationsReportGUI';
end;

procedure TStockBinQtysReportGUI.FormCreate(Sender: TObject);
begin
  inherited;
  AddCalcColumn(qryMainInstockUOMQty.fieldname, False);
  AddCalcColumn(qryMainAvailableUOMQty.fieldname, False);
  AddCalcColumn(qryMainUOMTotalAvailableVolume.fieldname, False);
  AddCalcColumn(qryMainUOMTotalinstockVolume.fieldname, False);
  AddCalcColumn(qryMainInstockQty.fieldname, False);
  AddCalcColumn(qryMainAvailableQty.fieldname, False);
end;

procedure TStockBinQtysReportGUI.MakeQryMain;
begin
  inherited;
end;

procedure TStockBinQtysReportGUI.PopulateData;
begin
  inherited;
  with Scriptmain do begin
    SQL.text :=      'Delete from ' + tablename +' where ifnull(Binlocation, "") ="";' +
              'Delete from ' + tablename +' where GLevel <> 3;' ;
    Execute;
  end;
end;

procedure TStockBinQtysReportGUI.RefreshTotals;
begin
  inherited;
  CalcnShowFooter;
end;

initialization
  RegisterClassOnce(TStockBinQtysReportGUI);

end.
