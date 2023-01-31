unit frmRepairsInventoryVerify;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmInventoryVerify, DB, ActnList, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls, Grids, Wwdbigrd,
  BusObjSmartOrder, Wwdbgrid, Shader, DNMPanel, DNMSpeedButton, StdCtrls;

type
  TfmRepairsInventoryVerify = class(TfmInventoryVerify)
    QrymainSmartOrderedQty: TFloatField;
  private
  Protected
    Function TransTableSQL:String; override;
    Function TransLineIDfieldName:String; override;
    Function TransLineQtyfieldName:String; override;
    Function Extrafields:String;override;
    Procedure InitProductinSOLine(const SOLine :TsmartOrderLine);Override;
  public
  end;


implementation

uses CommonDbLib, CommonLib;

{$R *.dfm}
{ TfmRepairsInventoryVerify }


{ TfmRepairsInventoryVerify }

function TfmRepairsInventoryVerify.Extrafields: String;
begin
  result:=  'Alter table ' +fsTablename +' add column SmartOrderedQty Double ;' +
            'update ' +fsTablename +' T Set SmartOrderedQty  = (Select sum(RP.Qty)'+
                    ' from tblrepairParts RP '+
                    ' inner join tblsmartorderlines SL on SL.RepairId = RP.repairID and SL.PARTSID = rp.PARTSid '+
                    ' where RP.RepairPartsID = T.TransLineID) ;';
end;

procedure TfmRepairsInventoryVerify.InitProductinSOLine(const SOLine: TsmartOrderLine);
begin
  inherited;
  SOLine.PARTSNAME      := TransLineDataset.FieldByName('PartName').AsString;
  SOLine.UnitofMeasure  := TransLineDataset.FieldByName('UnitofMeasure').AsString;
end;
function TfmRepairsInventoryVerify.TransLineIDfieldName: String;
begin
  REsult:= 'RP.RepairPartsID';
end;

function TfmRepairsInventoryVerify.TransLineQtyfieldName: String;
begin
  REsult := 'RP.UOMQty';
end;

function TfmRepairsInventoryVerify.TransTableSQL: String;
begin
  result:= ' INNER JOIN tblrepairParts RP on RP.partsID = P.PartsId and RP.RepairID =  ' +inttoStr(TransLineDataset.FieldByName('RepairID').AsInteger);
end;

initialization
  RegisterClassOnce(TfmRepairsInventoryVerify);

end.

