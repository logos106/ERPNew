unit SalesStockTransferList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, wwcheckbox;

type
  TSalesStockTransferListGUI = class(TBaseListingGUI)
    qryMainSAleId: TIntegerField;
    qryMainType: TWideStringField;
    qryMainTransferEntryID: TIntegerField;
    qryMainProcessed: TWideStringField;
    qryMaintransferedfrom: TWideStringField;
    qryMainTransferedto: TWideStringField;
    qryMainUOM: TWideStringField;
    qryMainUOMTransferQty: TFloatField;
    qryMainBatchNoFrom: TWideStringField;
    qryMainexpiryDateFrom: TDateTimeField;
    qryMainBinLocationFrom: TWideStringField;
    qryMainBinNumberFrom: TWideStringField;
    qryMainBatchNoTo: TWideStringField;
    qryMainexpiryDateTo: TDateTimeField;
    qryMainBinLocationTo: TWideStringField;
    qryMainBinNumberTo: TWideStringField;
    qryMainTransferAllocatedQty: TFloatField;
    qryMainSerialNumber: TWideStringField;
    qryMainProductname: TWideStringField;
    procedure FormCreate(Sender: TObject);
  private
    fiSaleID: Integer;
    procedure SetSaleID(const Value: Integer);
    function AllRelatedSAleIDs(const Value: Integer): String;
  public
    Property SaleID:Integer read fiSaleID write SetSaleID;
  end;


implementation

uses tcDataUtils, ProductQtyLib, CommonDbLib, StoredProcedures, CommonLib;

{$R *.dfm}

procedure TSalesStockTransferListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fiSAleID:=0;
  CreateSP('SAleType');
  CreateSP('AllrelatedSaleIds');
end;


Function TSalesStockTransferListGUI.AllRelatedSAleIDs(const Value:Integer):String;
begin
  With TempMyQuery do try
    SQL.add('Select AllRelatedSAleIDs(' + inttostr(Value) +') as Value');
    Open;
    Result := fieldbyname('Value').asSTring;
    if result = '' then result := '0';
  finally
    ClosenFree;
  end;
end;
procedure TSalesStockTransferListGUI.SetSaleID(const Value: Integer);
begin
    fiSaleID := Value;
  Self.Caption := 'Stock Transfer list for ' + tcdatautils.SaleType(Value)+' #' + inttostr(Value);
  TitleLabel.Caption := 'Stock Transfer list for ' + tcdatautils.SaleType(Value)+' #' + inttostr(Value);
  closedb(Qrymain);
  Qrymain.SQL.clear;
  Qrymain.SQL.Add('Select');
  Qrymain.SQL.Add('distinct S.SAleId ,');
  Qrymain.SQL.Add('convert(SaleType(S.SAleID), char(50)) Type,');
  Qrymain.SQL.Add('ST.TransferEntryID ,');
  Qrymain.SQL.Add('ST.Processed ,');
  Qrymain.SQL.Add('ST.TransferFromClassName transferedfrom ,');
  Qrymain.SQL.Add('STL.ClassNameTo Transferedto ,');
  Qrymain.SQL.Add('STL.Productname , ');
  Qrymain.SQL.Add('concat(STL.UOM  , "(" , STL.UOMMultiplier , ")" ) UOM ,');
  Qrymain.SQL.Add('STL.UOMTransferQty ,');
  Qrymain.SQL.Add('STL.BatchNoFrom ,');
  Qrymain.SQL.Add('STL.expiryDateFrom ,');
  Qrymain.SQL.Add('STL.BinLocationFrom ,');
  Qrymain.SQL.Add('STL.BinNumberFrom ,');
  Qrymain.SQL.Add('STL.BatchNoTo ,');
  Qrymain.SQL.Add('STL.expiryDateTo ,');
  Qrymain.SQL.Add('STL.BinLocationTo ,');
  Qrymain.SQL.Add('STL.BinNumberTo ,');
  Qrymain.SQL.Add('STL.SerialNumber,');
  Qrymain.SQL.Add('STL.TransferAllocatedQty');
  Qrymain.SQL.Add('from tblsales S');
  Qrymain.SQL.Add('inner join tblsaleslines SL on s.SAleId = SL.SaleID');
  Qrymain.SQL.Add('inner join tblPQa PQA on PQa.transId = SL.saleID and PQA.transLineID = SL.SAlelineId and PQA.transtype in (' +SalesTransTypes +')');
  Qrymain.SQL.Add('inner join tblPQADetails PQAD on PQA.PQAID = PQAD.PQAID');
  Qrymain.SQL.Add('inner join tblpqadetailsclass PQADC on PQADC.PQADetailID = PQAD.PQADetailID');
  Qrymain.SQL.Add('inner join tblstocktransferentrylines STL on STL.PQADetailClassRef = PQADC.GlobalRef');
  Qrymain.SQL.Add('inner join tblstocktransferentry ST on ST.TransferEntryID = STL.TransferEntryID');
  Qrymain.SQL.Add('where s.SaleID in (' + AllRelatedSAleIDs(Value)+' )');
  Qrymain.SQL.Add('Order by SaleId , transferedfrom , Transferedto , TransferEntryID , Productname');
  RefreshOrignalSQL;
end;

initialization
    RegisterClassOnce(TSalesStockTransferListGUI);
end.

