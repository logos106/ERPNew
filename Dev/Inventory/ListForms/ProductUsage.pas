unit ProductUsage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TProductUsageGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainProductID: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainProductCode: TWideStringField;
    qryMainFirstColumn: TWideStringField;
    qryMainSecondColumn: TWideStringField;
    qryMainThirdColumn: TWideStringField;
    qryMainOnOrderQty: TFloatField;
    qryMainAvailableQty: TFloatField;
    qryMainTotalSoldQty: TFloatField;
    qryMainAverageMonthlyQty: TFloatField;
    qryMainMonth1Qty: TFloatField;
    qryMainMonth2Qty: TFloatField;
    qryMainMonth3Qty: TFloatField;
    qryMainMonth4Qty: TFloatField;
    qryMainMonth5Qty: TFloatField;
    qryMainMonth6Qty: TFloatField;
    qryMainMonth7Qty: TFloatField;
    qryMainMonth8Qty: TFloatField;
    qryMainMonth9Qty: TFloatField;
    qryMainMonth10Qty: TFloatField;
    qryMainMonth11Qty: TFloatField;
    qryMainMonth12Qty: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    TempTable: string;
    procedure PopulateTable;
    procedure RelableColumns;
  protected
    procedure RefreshQuery; override;
  public
    { Public declarations }
  end;

var
  ProductUsageGUI: TProductUsageGUI;

implementation

uses
  DbSharedObjectsObj, CommonDbLib, TempTableUtils, ProductQtyLib, PQALib,
  MySQLConst, DateUtils, GridFieldsObj, LogLib, tcConst;

{$R *.dfm}

procedure TProductUsageGUI.FormCreate(Sender: TObject);
begin
  TempTable := CreateUserTemporaryTable('tmp_productusage');
  qryMain.SQL.Text := 'select * from ' + TempTable;
  inherited;

end;

procedure TProductUsageGUI.FormDestroy(Sender: TObject);
begin
  inherited;
  DestroyUserTemporaryTable(CommonDbLib.GetSharedMyDacConnection, TempTable);
end;

procedure TProductUsageGUI.PopulateTable;
var
  //cmd: TERPCommand;
  dt: TDateTime;
begin
  (*cmd := DbSharedObj.GetCommand(CommonDbLib.GetSharedMyDacConnection);
  try*)
  With ScriptMain do begin
    SQL.clear;
    SQL.add('truncate ' + TempTable+';');

    SQL.Add('Insert into ' + TempTable +
        ' (ProductID,ProductName,ProductCode,FirstColumn,SecondColumn,ThirdColumn) '+
        ' select P.PartsID, P.PartName, ProductCode,'+
          FirstColumn+ ','+
          SecondColumn + ','+
          ThirdColumn+
        ' from tblparts P'+
        ' where P.PartType = "INV" and P.Active = "T";');

    SQL.Add('update ' + TempTable + ' T'+
           ' inner join tblpqa PQA on PQA.ProductID = T.ProductID'+
           ' set T.OnOrderQty = ' + SQL4QtyField(tPOBO) + ','+
           ' AvailableQty = ' + SQL4QtyField(tAvailable)+';');


    dt := FilterDateTo;
    qryMainMonth12Qty.DisplayLabel := FormatDateTime('mmm yyyy',dt);
    SQL.Add('create table ' + TempTable + '_1 as');
    SQL.Add('(select T.ProductId');
    SQL.Add(',sum(' + SQL4QtyField(tTotSales,'PQA','If(PQA.TransDate between '+ QuotedStr(FormatDateTime(MysqlDateTimeFormat,StartOfTheMonth(dt))) +' and ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,EndOfTheDay  (dt))) +',PQA.Qty,0)') + ') as m12');    dt := IncMonth(dt, -1);
    SQL.Add(',sum(' + SQL4QtyField(tTotSales,'PQA','If(PQA.TransDate between '+ QuotedStr(FormatDateTime(MysqlDateTimeFormat,StartOfTheMonth(dt))) +' and ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,EndOfTheMonth(dt))) +',PQA.Qty,0)') + ') as m11');    dt := IncMonth(dt, -1);
    SQL.Add(',sum(' + SQL4QtyField(tTotSales,'PQA','If(PQA.TransDate between '+ QuotedStr(FormatDateTime(MysqlDateTimeFormat,StartOfTheMonth(dt))) +' and ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,EndOfTheMonth(dt))) +',PQA.Qty,0)') + ') as m10');    dt := IncMonth(dt, -1);
    SQL.Add(',sum(' + SQL4QtyField(tTotSales,'PQA','If(PQA.TransDate between '+ QuotedStr(FormatDateTime(MysqlDateTimeFormat,StartOfTheMonth(dt))) +' and ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,EndOfTheMonth(dt))) +',PQA.Qty,0)') + ') as m9');     dt := IncMonth(dt, -1);
    SQL.Add(',sum(' + SQL4QtyField(tTotSales,'PQA','If(PQA.TransDate between '+ QuotedStr(FormatDateTime(MysqlDateTimeFormat,StartOfTheMonth(dt))) +' and ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,EndOfTheMonth(dt))) +',PQA.Qty,0)') + ') as m8');     dt := IncMonth(dt, -1);
    SQL.Add(',sum(' + SQL4QtyField(tTotSales,'PQA','If(PQA.TransDate between '+ QuotedStr(FormatDateTime(MysqlDateTimeFormat,StartOfTheMonth(dt))) +' and ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,EndOfTheMonth(dt))) +',PQA.Qty,0)') + ') as m7');     dt := IncMonth(dt, -1);
    SQL.Add(',sum(' + SQL4QtyField(tTotSales,'PQA','If(PQA.TransDate between '+ QuotedStr(FormatDateTime(MysqlDateTimeFormat,StartOfTheMonth(dt))) +' and ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,EndOfTheMonth(dt))) +',PQA.Qty,0)') + ') as m6');     dt := IncMonth(dt, -1);
    SQL.Add(',sum(' + SQL4QtyField(tTotSales,'PQA','If(PQA.TransDate between '+ QuotedStr(FormatDateTime(MysqlDateTimeFormat,StartOfTheMonth(dt))) +' and ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,EndOfTheMonth(dt))) +',PQA.Qty,0)') + ') as m5');     dt := IncMonth(dt, -1);
    SQL.Add(',sum(' + SQL4QtyField(tTotSales,'PQA','If(PQA.TransDate between '+ QuotedStr(FormatDateTime(MysqlDateTimeFormat,StartOfTheMonth(dt))) +' and ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,EndOfTheMonth(dt))) +',PQA.Qty,0)') + ') as m4');     dt := IncMonth(dt, -1);
    SQL.Add(',sum(' + SQL4QtyField(tTotSales,'PQA','If(PQA.TransDate between '+ QuotedStr(FormatDateTime(MysqlDateTimeFormat,StartOfTheMonth(dt))) +' and ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,EndOfTheMonth(dt))) +',PQA.Qty,0)') + ') as m3');     dt := IncMonth(dt, -1);
    SQL.Add(',sum(' + SQL4QtyField(tTotSales,'PQA','If(PQA.TransDate between '+ QuotedStr(FormatDateTime(MysqlDateTimeFormat,StartOfTheMonth(dt))) +' and ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,EndOfTheMonth(dt))) +',PQA.Qty,0)') + ') as m2');     dt := IncMonth(dt, -1);
    SQL.Add(',sum(' + SQL4QtyField(tTotSales,'PQA','If(PQA.TransDate between '+ QuotedStr(FormatDateTime(MysqlDateTimeFormat,StartOfTheMonth(dt))) +' and ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,EndOfTheMonth(dt))) +',PQA.Qty,0)') + ') as m1');
    SQL.Add('from ' + TempTable + ' T');
    SQL.Add('inner join tblpqa PQA on PQA.ProductID = T.ProductID');
    SQL.Add('group by T.ProductID)'+';');

    SQL.Add('update ' + TempTable + ' T'+
           ' inner join ' + TempTable + '_1 T1 on T.ProductId = T1.ProductID'+
           ' set T.Month1Qty = T1.m1'+
           ' ,T.Month2Qty = T1.m2'+
           ' ,T.Month3Qty = T1.m3'+
           ' ,T.Month4Qty = T1.m4'+
           ' ,T.Month5Qty = T1.m5'+
           ' ,T.Month6Qty = T1.m6'+
           ' ,T.Month7Qty = T1.m7'+
           ' ,T.Month8Qty = T1.m8'+
           ' ,T.Month9Qty = T1.m9'+
           ' ,T.Month10Qty = T1.m10'+
           ' ,T.Month11Qty = T1.m11'+
           ' ,T.Month12Qty = T1.m12'+';');

    SQL.add( 'drop table if exists ' + TempTable + '_1;');

    SQL.Add('update ' + TempTable + ' T'+
           ' Set T.TotalSoldQty = T.Month1Qty + T.Month2Qty + T.Month3Qty + T.Month4Qty + T.Month5Qty + T.Month6Qty + T.Month7Qty + ' +
                'T.Month8Qty + T.Month9Qty + T.Month10Qty + T.Month11Qty + T.Month12Qty'+';');

    SQL.Add('update ' + TempTable + ' T'+
           ' Set T.AverageMonthlyQty = T.TotalSoldQty / 12'+';');

    doshowProgressbar(SQL.count ,WAITMSG);
    try
      clog(sql.text);
      SQL.text := ChangeQuery(SQL.Text);
      Execute;
    finally
      DoHideProgressbar;
    end;

  (*finally
    DbSharedObj.ReleaseObj(cmd);
  end;*)
  end;
end;

procedure TProductUsageGUI.RefreshQuery;
begin
  dtFrom.Date := 0;
  if qryMain.Active then qryMain.Close;
  PopulateTable;
  inherited;
  RelableColumns;
end;

procedure TProductUsageGUI.RelableColumns;
var
  dt: TDateTime;
  gfl: TGridFieldList;
begin
  dt := filterDateTo;
  gfl := TGridFieldList.Create;
  try
    gfl.LoadFromGrid(grdMain);
    gfl.ChangeDisplayLabel(qryMainMonth12Qty.FieldName, FormatDateTime('mmm yyyy',dt));

    dt := IncMonth(dt, -1);
    gfl.ChangeDisplayLabel(qryMainMonth11Qty.FieldName, FormatDateTime('mmm yyyy',dt));

    dt := IncMonth(dt, -1);
    gfl.ChangeDisplayLabel(qryMainMonth10Qty.FieldName, FormatDateTime('mmm yyyy',dt));

    dt := IncMonth(dt, -1);
    gfl.ChangeDisplayLabel(qryMainMonth9Qty.FieldName, FormatDateTime('mmm yyyy',dt));

    dt := IncMonth(dt, -1);
    gfl.ChangeDisplayLabel(qryMainMonth8Qty.FieldName, FormatDateTime('mmm yyyy',dt));

    dt := IncMonth(dt, -1);
    gfl.ChangeDisplayLabel(qryMainMonth7Qty.FieldName, FormatDateTime('mmm yyyy',dt));

    dt := IncMonth(dt, -1);
    gfl.ChangeDisplayLabel(qryMainMonth6Qty.FieldName, FormatDateTime('mmm yyyy',dt));

    dt := IncMonth(dt, -1);
    gfl.ChangeDisplayLabel(qryMainMonth5Qty.FieldName, FormatDateTime('mmm yyyy',dt));

    dt := IncMonth(dt, -1);
    gfl.ChangeDisplayLabel(qryMainMonth4Qty.FieldName, FormatDateTime('mmm yyyy',dt));

    dt := IncMonth(dt, -1);
    gfl.ChangeDisplayLabel(qryMainMonth3Qty.FieldName, FormatDateTime('mmm yyyy',dt));

    dt := IncMonth(dt, -1);
    gfl.ChangeDisplayLabel(qryMainMonth2Qty.FieldName, FormatDateTime('mmm yyyy',dt));

    dt := IncMonth(dt, -1);
    gfl.ChangeDisplayLabel(qryMainMonth1Qty.FieldName, FormatDateTime('mmm yyyy',dt));

    gfl.SaveToGrid(grdMain);
  finally
    gfl.Free;
  end;
end;

initialization
  RegisterClass(TProductUsageGUI);

end.
