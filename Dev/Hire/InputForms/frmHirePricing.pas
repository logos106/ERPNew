unit frmHirePricing;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, Menus, ExtCtrls, StdCtrls, DBCtrls, Mask, wwdbedit, DNMPanel,
  DB, DBAccess, MyAccess, ERPdbComponents, MemDS, Grids, Wwdbigrd, Wwdbgrid,
  Buttons, wwdblook, Wwdotdot, Wwdbcomb , OnHireList , BaseListingForm, Shader,
  DNMSpeedButton;

type
  TfmHirePricing = class(TfrmBaseGUI)
    pnlHirePricing: TDNMPanel;
    dsPartHirePricing: TDataSource;
    dsPartHirePricingLines: TDataSource;
    Qryduration: TERPQuery;
    pnlPricing: TDNMPanel;
    edtMinHirePeriod: TwwDBEdit;
    Label1: TLabel;
    cboMinHirePeriodType: TwwDBComboBox;
    pnlhistoryTab: TDNMPanel;
    grdRates: TwwDBGrid;
    btnDelete: TwwIButton;
    cboDuration: TwwDBLookupCombo;
    MyConnection: TERPConnection;
    btncopyfromProduct: TDNMSpeedButton;
    pnlhistory: TDNMPanel;
    procedure btnDeleteClick(Sender: TObject);
    procedure cboDurationCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btncopyfromProductClick(Sender: TObject);
  private
    fHirePricingLinesDataset: Tdataset;
    fHirePricingdataset: Tdataset;
    fiEquipmentId: Integer;
    fiProductId: Integer;
    fOnHireListGUI : TBaseListingGUI;
    fOnCopyHirePricingFromProductCard: TNotifyEvent;



    procedure SetHirePricingLinesDataset(const Value: Tdataset);
    procedure SetHirePricingdataset(const Value: Tdataset);
(*    procedure setEquipmentId(const Value: Integer);
    procedure SetProductID(const Value: Integer);*)
    procedure OpenQueries;
    Procedure MakeOnHireList;
    function FormConnection :TERPConnection;

  public
    Property HirePricingLinesDataset :Tdataset read fHirePricingLinesDataset write SetHirePricingLinesDataset;
    Property HirePricingdataset :Tdataset read fHirePricingdataset write SetHirePricingdataset;
    Property EquipmentId :Integer read fiEquipmentId write fiEquipmentId;
    Property ProductId :Integer read fiProductId write fiProductId;
    property OnCopyHirePricingFromProductCard: TNotifyEvent read fOnCopyHirePricingFromProductCard write fOnCopyHirePricingFromProductCard;

    class Function  InstanceIt(AOwner:TComponent ;ParentPanel:TDNMPanel; aHirePricingdataset , aHirePricingLinesDataset :TDataset; aProductId ,aEquipmentId:Integer):TfmHirePricing;
  end;


implementation

uses
  CommonDbLib, CommonFormLib ,DbSharedObjectsObj, CommonLib;

{$R *.dfm}

{ TfmHirePricing }

procedure TfmHirePricing.btncopyfromProductClick(Sender: TObject);
var
  Qry :TERPQuery;
  fiHirePriceId :Integer;
  x: integer;
begin
  inherited;
  Qry := DbSharedObj.GetQuery(FormConnection);
  try
    closedb(Qry);
    Qry.SQL.Text :=' Select HirePriceId from  tblhirepricing where ifnull(ProductID,0)=' + inttostr(ProductID) +' and ifnull(EquipmentID,0)=0';
    Qry.open;
    fiHirePriceId := Qry.FieldByName('HirePriceId').AsInteger;
    closedb(Qry);
    if fiHirePriceId > 0 then begin
        x := HirePricingLinesDataset.RecordCount;
        Qry.SQL.Clear;
        Qry.SQL.Add('insert ignore into tblhirepricing (MinHirePeriod, minhirePeriodtype , ProductId , EquipmentID  ) '+
                      ' select MinHirePeriod, minhirePeriodtype , ProductId , ' + inttostr(EquipmentID) +' from tblhirepricing where HirEPriceId = ' + inttostr(fiHirePriceId )+';');
        Qry.SQL.Add('insert ignore into tblhirepricinglines (HirePriceId, DurationID, DurationName , Rate, Active  ) '+
                      ' Select (Select HirePriceID from tblhirepricing where ifnull(ProductID,0)=' + inttostr(ProductID) +' and ifnull(EquipmentID,0)= ' + inttostr(EquipmentID) +'), DurationID, DurationName , Rate, Active from tblhirepricinglines where HirePriceId = ' +inttostr(fiHirePriceId)+';');
        Qry.Execute;
        closedb(HirePricingdataset);
        OpenDb(HirePricingdataset);
        closedb(HirePricingLinesDataset);
        OpenDb(HirePricingLinesDataset);
        if x <> HirePricingLinesDataset.RecordCount then
          CommonLib.MessageDlgXP_Vista('Pricing Updated',mtInformation,[mbOk],0)
        else
          CommonLib.MessageDlgXP_Vista('No New Prices found on Product card to Add',mtInformation,[mbOk],0);
    end
    else begin
      CommonLib.MessageDlgXP_Vista('No Hire Pricing found on Product Card to copy from',mtInformation,[mbOk],0);
    end;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;
  if Assigned(fOnCopyHirePricingFromProductCard) then
    fOnCopyHirePricingFromProductCard(self);
end;

procedure TfmHirePricing.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if HirePricingLinesDataset.state = dsInsert then HirePricingLinesDataset.Cancel
  else HirePricingLinesDataset.delete;
end;

procedure TfmHirePricing.cboDurationCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  PostDb(HirePricingLinesDataset);

end;

function TfmHirePricing.FormConnection: TERPConnection;
begin
  Result := nil;
  if Assigned(fHirePricingdataset) then
    result := TERPConnection(TERPQuery(fHirePricingdataset).connection);
end;

procedure TfmHirePricing.FormCreate(Sender: TObject);
begin
  inherited;
  fiEquipmentId:= 0;
  fiProductId:=0;
end;
procedure TfmHirePricing.FormDestroy(Sender: TObject);
begin
  dsPartHirePricingLines.dataset:= nil;
  dsPartHirePricing.dataset:= nil;
  FreeandNil(fOnHireListGUI);
  pnlHirePricing.Parent := Self;
  inherited;

end;

Procedure  TfmHirePricing.MakeOnHireList;
begin
  CreateHistorylistform('TOnHireListGUI' ,Self, fOnHireListGUI,(*'ProductID = ' , IntToStr(ProductID)+' and'*) 'EquipmentId  ' , inttostr(EquipmentId));
        if Assigned(fOnHireListGUI) then begin
          fOnHireListGUI.Parent := pnlhistory;
          fOnHireListGUI.align := alclient;
          fOnHireListGUI.BorderStyle := bsNone;
          fOnHireListGUI.fbIgnoreQuerySpeed := true;
          fOnHireListGUI.HaveDateRangeSelection:=False;
          fOnHireListGUI.HeaderPanel.Height := fOnHireListGUI.HeaderPanel.Height + 1;
          fOnHireListGUI.HeaderPanel.Height := fOnHireListGUI.HeaderPanel.Height - 1;
          try
            fOnHireListGUI.Show;
            fOnHireListGUI.Invalidate;
          except
            FreeAndNil(fOnHireListGUI);
          end;
        end;
end;

Procedure TfmHirePricing.OpenQueries;
var
  ctr:Integer;
begin
  for ctr := 0 to componentcount-1 do begin
    if components[ctr] is TERPQuery then begin
      try
        closedb(TERPQuery(components[ctr]));
        TERPQuery(components[ctr]).connection := TERPQuery(HirePricingLinesDataset).Connection;
        Opendb(TERPQuery(components[ctr]));
      except
        //
      end;
    end;
  end;

end;
class Function  TfmHirePricing.InstanceIt(AOwner: TComponent; ParentPanel:TDNMPanel; aHirePricingdataset , aHirePricingLinesDataset: TDataset; aProductId ,aEquipmentId:Integer):TfmHirePricing;
begin
  REsult :=  TfmHirePricing.create(AOwner);
  With result do begin
     pnlHirePricing.Parent := ParentPanel;
     HirePricingdataset := aHirePricingdataset;
     HirePricingLinesDataset := aHirePricingLinesDataset;
     ProductId := aProductId;
     EquipmentId:= aEquipmentId;
     btncopyfromProduct.visible := aEquipmentId <>0;
     closedb(Qryduration);
     OpenQueries;
     MakeOnHireList;
  end;
end;


procedure TfmHirePricing.SetHirePricingdataset(const Value: Tdataset);
begin
  fHirePricingdataset := Value;
  dsPartHirePricing.dataset := Value;
end;
procedure TfmHirePricing.SetHirePricingLinesDataset(const Value: Tdataset);
begin
  fHirePricingLinesDataset := Value;
  dsPartHirePricingLines.dataset := Value;
end;

(*procedure TfmHirePricing.setEquipmentId(const Value: Integer);
begin
  fiEquipmentId := Value;
  closedb(Qryhirehistory);
  Qryhirehistory.parambyname('EquipmentId').asInteger := Value;
end;

procedure TfmHirePricing.SetProductID(const Value: Integer);
begin
  fiProductId := Value;
  closedb(Qryhirehistory);
  Qryhirehistory.parambyname('ProductId').asInteger := Value;
end;*)

end.
