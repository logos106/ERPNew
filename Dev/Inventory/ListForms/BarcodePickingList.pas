unit BarcodePickingList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, MemDS, DBAccess, MyAccess,
  wwdbdatetimepicker, ProgressDialog, CustomInputBox, wwdblook, Shader,
  kbmMemTable;

type
  TBarcodePickingListGUI = class(TBaseListingGUI)
    procedure grpFiltersClick(Sender: TObject); override;
    procedure grdMainDblClick(Sender: TObject); override;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Function PickingDuration :String;
    function PickToPackDuration :String;
    function PAckingDuration:String;
  protected
    procedure RefreshQuery; override;
  public
    { Public declarations }
  end;

implementation

uses FastFuncs, AppEnvironment, CommonLib,DateUtils, tcConst;

{$R *.dfm}
  Function TBarcodePickingListGUI.PickingDuration :String; begin
    REsult := 'TIME_FORMAT(SEC_TO_TIME( TIME_TO_SEC(FinishedPickingTime)-TIME_TO_SEC(StartPickingTime)),"%T")';
  end;
  function TBarcodePickingListGUI.PickToPackDuration :String; begin
    Result := 'TIME_FORMAT(SEC_TO_TIME( TIME_TO_SEC(StartPackingTime)-TIME_TO_SEC(FinishedPickingTime) ),"%T")';
  end;
  function TBarcodePickingListGUI.PAckingDuration:String; begin
      Result := 'TIME_FORMAT(SEC_TO_TIME( TIME_TO_SEC(FinishedPackingTime)-TIME_TO_SEC(StartPackingTime)),"%T")';
  end;

procedure TBarcodePickingListGUI.grpFiltersClick(Sender: TObject);
begin
  qryMain.Close;
  case grpFilters.ItemIndex of
    0:
      begin  {Printed}
        qryMain.SQL.clear;
        qryMain.SQL.add('SELECT ');
        qryMain.SQL.add('PA.GlobalRef         as GlobalRef, ');
        qryMain.SQL.add('"Picked"             as ID,');
        qryMain.SQL.add('PickingAssemblyID    as PickingAssemblyID,');
        qryMain.SQL.add('PA.SaleID            as InvoiceNo, ');
        qryMain.SQL.add('E.EmployeeName       as PickingEmployee, ');
        qryMain.SQL.add('StartPickingTime     as StartPickingTime,');
        qryMain.SQL.add('FinishedPickingTime  as FinishedPickingTime, ');
        qryMain.SQL.add(PickingDuration + '   as PickingDuration,');
        qryMain.SQL.add(PickToPackDuration+'  as PickingToPackingDuration, ');
        qryMain.SQL.add('E2.EmployeeName      as PackingEmployee, ');
        qryMain.SQL.add('StartPackingTime     as StartPackingTime,');
        qryMain.SQL.add('FinishedPackingTime  as FinishedPackingTime, ');
        qryMain.SQL.add(PackingDuration + '   as PackingDuration, ');
        qryMain.SQL.add('S.ConNote            as ConNote, ');
        qryMain.SQL.add('S.Shipping           as Via, ');
        qryMain.SQL.add('S.ShippingCost       as ShipCost ');
        qryMain.SQL.add('FROM tblpickingassembly PA ');
        qryMain.SQL.add('INNER JOIN tblSales S ON S.SaleId = PA.SaleID ');
        qryMain.SQL.add('LEFT JOIN tblemployees E ON E.EmployeeID = PA.PickingEmployeeID ');
        qryMain.SQL.add('LEFT JOIN tblemployees E2 ON E2.EmployeeID = PA.PackingEmployeeID ');
        qryMain.SQL.add('Where StartPicking = "F" ');
        qryMain.SQL.add('Order By PickingAssemblyID DESC; ');
      end;
    1:
      begin  {Picking}
        qryMain.SQL.clear;
        qryMain.SQL.add('SELECT ');
        qryMain.SQL.add('PA.GlobalRef         as GlobalRef, ');
        qryMain.SQL.add('"Picked"             as ID,');
        qryMain.SQL.add('PickingAssemblyID    as PickingAssemblyID,');
        qryMain.SQL.add('PA.SaleID            as InvoiceNo, ');
        qryMain.SQL.add('E.EmployeeName       as PickingEmployee, ');
        qryMain.SQL.add('StartPickingTime     as StartPickingTime,');
        qryMain.SQL.add('FinishedPickingTime  as FinishedPickingTime, ');
        qryMain.SQL.add(PickingDuration + '   as PickingDuration, ');
        qryMain.SQL.add(PickToPackDuration+'  as PickingToPackingDuration,');
        qryMain.SQL.add('E2.EmployeeName      as PackingEmployee, ');
        qryMain.SQL.add('StartPackingTime     as StartPackingTime,');
        qryMain.SQL.add('FinishedPackingTime  as FinishedPackingTime, ');
        qryMain.SQL.add(PackingDuration + '   as PackingDuration, ');
        qryMain.SQL.add('S.ConNote            as ConNote, ');
        qryMain.SQL.add('S.Shipping           as Via, ');
        qryMain.SQL.add('S.ShippingCost       as ShipCost');
        qryMain.SQL.add('FROM tblpickingassembly PA ');
        qryMain.SQL.add('INNER JOIN tblSales S ON S.SaleId = PA.SaleID ');
        qryMain.SQL.add('LEFT JOIN tblemployees E ON E.EmployeeID = PA.PickingEmployeeID ');
        qryMain.SQL.add('LEFT JOIN tblemployees E2 ON E2.EmployeeID = PA.PackingEmployeeID');
        qryMain.SQL.add('Where StartPicking = "T" AND FinishedPicking="F" AND  StartPacking = "F" AND FinishedPacking="F" ');
        qryMain.SQL.add('AND StartPickingTime Between ' +
                        quotedStr(formatDateTime(mySQLDateformat , DateUtils.StartOfTheDay(dtfrom.DateTime)))+
                        ' AND ' +
                        quotedStr(formatDateTime(mySQLDateformat , DateUtils.EndOfTheDay(dtto.DateTime))) );
        qryMain.SQL.add('Order By PickingAssemblyID DESC; ');

      end;
    2:
      begin  {Packing}
        qryMain.SQL.clear;
        qryMain.SQL.add('SELECT ');
        qryMain.SQL.add('PA.GlobalRef         as GlobalRef, ');
        qryMain.SQL.add('"Picked"             as ID,');
        qryMain.SQL.add('PickingAssemblyID    as PickingAssemblyID,');
        qryMain.SQL.add('PA.SaleID            as InvoiceNo, ');
        qryMain.SQL.add('E.EmployeeName       as PickingEmployee, ');
        qryMain.SQL.add('StartPickingTime     as StartPickingTime,');
        qryMain.SQL.add('FinishedPickingTime  as FinishedPickingTime, ');
        qryMain.SQL.add(PickingDuration + '   as PickingDuration, ');
        qryMain.SQL.add(PickToPackDuration+'  as PickingToPackingDuration, ');
        qryMain.SQL.add('E2.EmployeeName      as PackingEmployee, ');
        qryMain.SQL.add('StartPackingTime     as StartPackingTime,');
        qryMain.SQL.add('FinishedPackingTime  as FinishedPackingTime, ');
        qryMain.SQL.add(PackingDuration + '   as PackingDuration, ');
        qryMain.SQL.add('S.ConNote            as ConNote, ');
        qryMain.SQL.add('S.Shipping           as Via, ');
        qryMain.SQL.add('S.ShippingCost       as ShipCost ');
        qryMain.SQL.add('FROM tblpickingassembly PA ');
        qryMain.SQL.add('INNER JOIN tblSales S ON S.SaleId = PA.SaleID ');
        qryMain.SQL.add('LEFT JOIN tblemployees E ON E.EmployeeID = PA.PickingEmployeeID ');
        qryMain.SQL.add('LEFT JOIN tblemployees E2 ON E2.EmployeeID = PA.PackingEmployeeID ');
        qryMain.SQL.add('Where StartPicking = "T" AND FinishedPicking="T" AND  StartPacking = "T" AND FinishedPacking="F" ');
        qryMain.SQL.add('AND StartPickingTime Between ' +
                        quotedStr(formatDateTime(mySQLDateformat , DateUtils.StartOfTheDay(dtfrom.DateTime))) +
                        ' AND ' +
                        quotedStr(formatDateTime(mySQLDateformat , DateUtils.EndOfTheDay(dtto.DateTime))) );
        qryMain.SQL.add('Order By PickingAssemblyID DESC; ');

      end;
    3:
      begin  {Finished}
        qryMain.SQL.clear;
        qryMain.SQL.add('SELECT ');
        qryMain.SQL.add('PA.GlobalRef         as GlobalRef, ');
        qryMain.SQL.add('"Picked"             as ID,');
        qryMain.SQL.add('PickingAssemblyID    as PickingAssemblyID,');
        qryMain.SQL.add('PA.SaleID            as InvoiceNo, ');
        qryMain.SQL.add('E.EmployeeName       as PickingEmployee, ');
        qryMain.SQL.add('StartPickingTime     as StartPickingTime,');
        qryMain.SQL.add('FinishedPickingTime  as FinishedPickingTime, ');
        qryMain.SQL.add(PickingDuration + '   as PickingDuration, ');
        qryMain.SQL.add(PickToPackDuration+'  as PickingToPackingDuration, ');
        qryMain.SQL.add('E2.EmployeeName      as PackingEmployee, ');
        qryMain.SQL.add('StartPackingTime     as StartPackingTime,');
        qryMain.SQL.add('FinishedPackingTime  as FinishedPackingTime, ');
        qryMain.SQL.add(PackingDuration + '   as PackingDuration, ');
        qryMain.SQL.add('S.ConNote            as ConNote, ');
        qryMain.SQL.add('S.Shipping           as Via, ');
        qryMain.SQL.add('S.ShippingCost       as ShipCost ');
        qryMain.SQL.add('FROM tblpickingassembly PA ');
        qryMain.SQL.add('INNER JOIN tblSales S ON S.SaleId = PA.SaleID ');
        qryMain.SQL.add('LEFT JOIN tblemployees E ON E.EmployeeID = PA.PickingEmployeeID ');
        qryMain.SQL.add('LEFT JOIN tblemployees E2 ON E2.EmployeeID = PA.PackingEmployeeID ');
        qryMain.SQL.add('Where StartPicking = "T" AND FinishedPicking="T" AND  StartPacking = "T" AND FinishedPacking="T" ');
        qryMain.SQL.add('AND StartPickingTime Between ' +
                            quotedStr(formatDateTime(mySQLDateformat , DateUtils.StartOfTheDay(dtfrom.DateTime)))+
                            ' AND ' +
                            quotedStr(formatDateTime(mySQLDateformat , DateUtils.EndOfTheDay(dtto.DateTime))) );
        qryMain.SQL.add('Order By PickingAssemblyID DESC; ');
      end;
    4:
      begin  {Not Printed}
        qryMain.SQL.clear;
        if AppEnv.CompanyPrefs.BarcodePickingInSOMode then begin
          qryMain.SQL.add('SELECT ');
          qryMain.SQL.add('"SO-NotPicked"         as ID,');
          qryMain.SQL.add('SaleDate               as SaleDate,');
          qryMain.SQL.add('S.GlobalRef            as GlobalRef, ');
          qryMain.SQL.add('InvoiceDocNumber       as "SO Number",');
          qryMain.SQL.add('Company                as Company,');
          qryMain.SQL.add('ProductName            as ProductName, ');
          qryMain.SQL.add('Product_Description    as ProductDescription, ');
          qryMain.SQL.add('UnitofMeasureSaleLines as Units,');
          qryMain.SQL.add('UnitofMeasureShipped   as Qty,  ');
          qryMain.SQL.add('PickingPriority        as PickingPriority ,');
          qryMain.SQL.add('S.SaleID               as SaleID,  ');
          qryMain.SQL.add('S.ConNote              as ConNote, ');
          qryMain.SQL.add('S.Shipping             as Via, ');
          qryMain.SQL.add('S.ShippingCost         as ShipCost ');
          qryMain.SQL.add('FROM tblSales S INNER JOIN  ');
          qryMain.SQL.add('tblSalesLines SL Using(SaleID)  ');
          qryMain.SQL.add('INNER JOIN tblClients C  ON C.ClientID= S.ClientID LEFT JOIN  ');
          qryMain.SQL.add('tblpickingassembly PA ON S.SaleID=PA.SaleID ');
          qryMain.SQL.add('WHERE S.IsBarcodePicking="T" AND  ');
          qryMain.SQL.add('BarcodePickingDone="F" AND  ');
          qryMain.SQL.add('S.IsSalesOrder="T"  AND  ');
          qryMain.SQL.add('ISNULL(PA.SaleID)  ');
          qryMain.SQL.add('Order by PickingPriority Desc,SaleDate;');
        end else begin
          qryMain.SQL.add('SELECT ');
          qryMain.SQL.add('"INV-NotPicked"        as ID,');
          qryMain.SQL.add('SaleDate               as SaleDate,');
          qryMain.SQL.add('S.GlobalRef            as GlobalRef, ');
          qryMain.SQL.add('InvoiceDocNumber       as InvoiceNumber,');
          qryMain.SQL.add('Company                as Company ,');
          Qrymain.SQL.add('ProductName            as ProductName, ');
          qryMain.SQL.add('Product_Description    as ProductDescription, ');
          qryMain.SQL.add('UnitofMeasureSaleLines as Units,');
          qryMain.SQL.add('UnitofMeasureShipped   as Qty, ');
          qryMain.SQL.add('PickingPriority        as PickingPriority ,');
          qryMain.SQL.add('S.SaleID               as SaleID,  ');
          qryMain.SQL.add('S.ConNote              as ConNote, ');
          qryMain.SQL.add('S.Shipping             as Via, ');
          qryMain.SQL.add('S.ShippingCost         as ShipCost ');
          qryMain.SQL.add('FROM tblSales S INNER JOIN tblSalesLines SL Using(SaleID)  ');
          qryMain.SQL.add('INNER JOIN tblClients C  ON C.ClientID= S.ClientID LEFT JOIN  ');
          qryMain.SQL.add('tblpickingassembly PA ON S.SaleID=PA.SaleID ');
          qryMain.SQL.add('WHERE S.IsBarcodePicking="T" AND  ');
          qryMain.SQL.add('BarcodePickingDone="F" AND  ');
          qryMain.SQL.add('S.IsInvoice="T"  AND  ');
          qryMain.SQL.add('ISNULL(PA.SaleID)  ');
          qryMain.SQL.add('Order by PickingPriority Desc,SaleDate;');
        end;
      end;
  end;
  inherited;
  RefreshQuery;
  lblTotal.Caption := FastFuncs.IntToStr(qryMain.RecordCount);
end;


procedure TBarcodePickingListGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMain.Fields.FieldByName('ID').AsString;
  inherited;
end;

procedure TBarcodePickingListGUI.RefreshQuery;
begin
  (*if not (grpFilters.ItemIndex = 4) and not (grpFilters.ItemIndex = 0) then begin
    qryMain.Params.ParamByName('txtfrom').asDateTime := DateUtils.StartOfTheDay(dtfrom.DateTime);
    qryMain.Params.ParamByName('txtto').asDateTime   := DateUtils.EndOfTheDay(dtto.DateTime);
  end;*)
  inherited;
  TFloatField(qryMain.FieldByName('ShipCost')).currency:= true;
end;

procedure TBarcodePickingListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  qryMain.SQL.Add('SELECT ');
  qryMain.SQL.Add('"Picked"               as ID, ');
  qryMain.SQL.Add('PickingAssemblyID      as PickingAssemblyID,  ');
  qryMain.SQL.Add('PA.SaleID              as InvoiceNo, ');
  qryMain.SQL.Add('E.EmployeeName         as PickingEmployee,  ');
  qryMain.SQL.Add('StartPickingTime       as StartPickingTime, ');
  qryMain.SQL.Add('FinishedPickingTime    as FinishedPickingTime, '  );
  qryMain.SQL.Add(PickingDuration + '     as PickingDuration, '  );
  qryMain.SQL.Add(PickToPackDuration + '  as PickingToPackingDuration, ');
  qryMain.SQL.Add('E2.EmployeeName        as PackingEmployee,  ');
  qryMain.SQL.Add('StartPackingTime       as StartPackingTime, ');
  qryMain.SQL.Add('FinishedPackingTime    as FinishedPackingTime,  ');
  qryMain.SQL.Add(PackingDuration + '     as PackingDuration,  ');
  qryMain.SQL.Add('S.ConNote              as ConNote,  ');
  qryMain.SQL.Add('S.Shipping             as Via,  ');
  qryMain.SQL.Add('S.ShippingCost         as ShipCost   ');
  qryMain.SQL.Add('FROM tblpickingassembly PA   ');
  qryMain.SQL.Add('INNER JOIN tblSales S ON S.SaleId = PA.SaleID  ');
  qryMain.SQL.Add('LEFT JOIN tblemployees E ON E.EmployeeID = PA.PickingEmployeeID  ');
  qryMain.SQL.Add('LEFT JOIN tblemployees E2 ON E2.EmployeeID = PA.PackingEmployeeID  ');
  qryMain.SQL.Add('Where StartPicking = "F" AND FinishedPicking="F" AND  StartPacking = "F" AND FinishedPacking="F"  ');
  qryMain.SQL.Add('Order By PickingAssemblyID DESC;  ');
end;

initialization
  RegisterClassOnce(TbarcodePickingListGUI);
end.
