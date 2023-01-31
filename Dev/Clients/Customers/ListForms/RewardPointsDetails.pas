unit RewardPointsDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, RewardPoints, DAScript,
  MyScript;

type
  TRewardPointsDetailsGUI = class(TRewardPointsGUI)
    grpExtrafilter: TRadioGroup;
    Panel4: TPanel;
    Label5: TLabel;
    qryMaincategory: TLargeintField;
    btnRedeem: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnRedeemClick(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean;
      var Accept: Boolean);
    procedure grdMainTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdMainDblClick(Sender: TObject); Override;

  private
    AvailablePoints :double;
    AvailablePointValue:double;
    SelectedCategory:Integer;
    fsgetPointsfilter: String;
    fOnSelectPoints: TNotifyEvent;
    Procedure DoCalcfieldsforgroup;
    procedure SetgetPointsfilter(const Value: String);
    procedure setOnSelectPoints(const Value: TNotifyEvent=nil);


  Protected
    procedure RefreshTotals; override;
    Procedure CalcFooter; Override;
    procedure SetGridColumns;Override;
    function ExtraFilter:String ;Override;
  public
    Property getPointsfilter :String read fsgetPointsfilter write SetgetPointsfilter;
    Procedure RefreshQuery;Override;
    Property OnSelectPoints :TNotifyEvent Read fOnSelectPoints write setOnSelectPoints;
    class procedure GetPoints(const CustomerID: Integer;
                  const OnSelectPoints: TNotifyEvent; const SaleDate:TDateTime; const MyConnection :TERPConnection=nil);
  end;


implementation

uses
  CommonLib, CommonDbLib,dateutils, FastFuncs, tcConst,
  BusObjSaleBase, SalesConst;


{$R *.dfm}
{ TRewardPointsGUI }

class procedure TRewardPointsDetailsGUI.GetPoints(const CustomerID: Integer;
  const OnSelectPoints: TNotifyEvent; const SaleDate:TDateTime; const MyConnection :TERPConnection=nil);
var
  form :Tcomponent;
begin
  if FormStillOpen('TRewardPointsDetailsGUI') then begin
    form := GetComponentByClassName('TRewardPointsDetailsGUI');
    TRewardPointsDetailsGUI(form).close;
    freeandNil(form);
  end;

  form := GetComponentByClassName('TRewardPointsDetailsGUI');
  if TRewardPointsDetailsGUI(form).visible then begin
      CommonLib.MessageDlgXP_Vista('Reward points is already opened, please close it to choose the points to redeem' , mtInformation, [mbok], 0);
      exit;
  end;
  if not assigned(Form) then exit;
  TRewardPointsDetailsGUI(form).OnSelectPoints := OnSelectPoints;
  (*TRewardPointsDetailsGUI(form).getPointsfilter :='ClientID = ' + IntToStr(CustomerID) +
                                ' and ((Category=1) or  ((ExpiryDate = 0 or ExpiryDate is null or '+
                                        ' (   ExpiryDate >=' +QuotedStr(FormatdateTime(FormatSettings.ShortDateformat , SaleDate))+
                                        ' and ExpiryDAte >= ' + quotedStr(FormatdateTime(FormatSettings.ShortDateformat, Date))+' )) ' +
                                ' and AvailablePoints <> 0))';*)
  TRewardPointsDetailsGUI(form).Qrymain.parambyname('clientID').asInteger :=CustomerID;

  if SaleDate < date then TRewardPointsDetailsGUI(form).Qrymain.parambyname('SalesDate').asdateTime :=SaleDate
  else TRewardPointsDetailsGUI(form).Qrymain.parambyname('SalesDate').asdateTime :=Date;

  TRewardPointsDetailsGUI(form).getPointsfilter := ' ((Category=1) or (AvailablePoints <> 0))';

  if MyConnection <> nil then
    TRewardPointsDetailsGUI(form).Qrymain.connection :=  MyConnection;
  TRewardPointsDetailsGUI(form).grpFilters.visible := False;
  TRewardPointsDetailsGUI(form).Showmodal;
end;
procedure TRewardPointsDetailsGUI.qryMainCalcFields(DataSet: TDataSet);
begin
 if (Qrymaincategory.asInteger =1 )  then begin
    DoCalcfieldsforgroup;
    qryMainAvailablePoints.asFloat     :=AvailablePoints;
    QrymainAvailablePointValue.asFloat :=AvailablePointValue;
  end else begin
    qryMainPointsExpired.asFloat  := 0;
    if (qryMainExpiresOnNoOfMonthsAfterPurchase.asInteger <> 0) or
        (qryMainPointExpiresOn.asDatetime <> 0) then begin
        qryMainPointExpiresOnM.asDatetime := IncMonth(qryMainSaleDate.asDateTime, qryMainExpiresOnNoOfMonthsAfterPurchase.asInteger);
        if qryMainExpiryDate.asDatetime < date then
          qryMainPointsExpired.asFloat := round(qryMainLinePoints.Asfloat - qryMainUsedPoints.asfloat,OtherRoundPlaces);
    end;
    qryMainAvailablePoints.asFloat     :=Round(qryMainLinePoints.Asfloat - qryMainUsedPoints.asfloat,OtherRoundPlaces) - qryMainPointsExpired.asFloat ;
    QrymainAvailablePointValue.asFloat :=qryMainAvailablePoints.asFloat * qryMainValueforRewardPoint.asFloat;
  end;


end;

procedure TRewardPointsDetailsGUI.btnRedeemClick(Sender: TObject);
var
  i:Integer;
begin
  if Assigned(fOnSelectPoints) then begin
    i:= grpExtrafilter.itemindex;
    try
        {if  summary record is Selected - internally selected all under it.
        there will be only 1 summary record in this mode as its filtered for the client}
        if grdMain.SelectedList.Count = 1 then begin
          qryMain.GotoBookmark(grdMain.SelectedList.Items[0]);
          if Qrymaincategory.asInteger =1 then begin
            grdMain.UnselectAll;
            if grpExtrafilter.itemindex = 0 then grpExtrafilter.itemindex := 1;
            Qrymain.First;
            while Qrymain.eof =false do begin
              if Qrymaincategory.asInteger <>1 then
                grdMain.SelectRecord;
              Qrymain.Next;
            end;
          end;
        end;
        fOnSelectPoints(grdmain);
    finally
      grpExtrafilter.itemindex := i;
    end;
    Self.Close;
  end ;
end;

procedure TRewardPointsDetailsGUI.CalcFooter;
begin
if ((grpExtrafilter.ItemIndex =0) or
      (QrymainCategory.asInteger> 1)) then
    inherited;

end;
procedure TRewardPointsDetailsGUI.DoCalcfieldsforgroup;
var
  PointsExpired:double;
  fdAvailablePoints:double;
begin
    AvailablePoints :=0;
    AvailablePointValue:=0;
    with tempMyQuery do try
      SQL.add('Select ' +
        ' `SP`.`ExpiresOnNoOfMonthsAfterPurchase` as `ExpiresOnNoOfMonthsAfterPurchase`, ' +
        ' `SP`.`PointExpiresOn` as `PointExpiresOn`, ' +
        ' Cast( if(sp.IsOpeningBalance="T", SP.OpeningBalanceAsOn ,S.SaleDate)  as DAteTime ) as SaleDate, ' +
        ' CAST(if(Ifnull(SP.PointExpiresOn,0)<> 0 , SP.PointExpiresOn ,  if(ifnull(SP.ExpiresOnNoOfMonthsAfterPurchase,0)  <> 0,  Date_Add(S.SaleDate , Interval   ExpiresOnNoOfMonthsAfterPurchase MONTH),NULL )) as DAteTime) as ExpiryDate , ' +
        ' `SP`.`LinePoints` as `LinePoints`, ' +
        '`SP`.`ValueforRewardPoint` as `ValueforRewardPoint`,'+
        ' ifnull(round(Sum(SRP.UsedPoints),2),0) UsedPoints  ' +
        ' from tblsaleslinespoints SP ' +
        ' inner join tblClients c on C.clientID = SP.clientID ' +
        ' Left Join tblsales AS S ON SP.SaleID = S.SaleID ' +
        ' Left join tblsalesredeempoints SRP on SRP.SalesLinesPointsId = SP.SalesLinesPointsId and SRP.active ="T" ' +
        ' where SP.active = "T" ' );
      SQL.add(' and SP.clientId = ' +QrymainclientID.asString);
      if QrymainCategory.asInteger = 2 then begin
        if QrymainProductID.asInteger > 0 then SQL.add(' and SP.ProductId = ' +QrymainProductID.asString) else SQL.add(' and SP.ProductId = 0' );
        if qrymainDeptID.asInteger    > 0 then SQL.add(' and SP.DeptID    = ' + qrymainDeptID.asString) else SQL.add(' and SP.DeptID = 0');
      end;
      SQL.add(' group by SP.SalesLinesPointsId');
      open;
      if recordcount =0 then exit;
      first;
      while eof = False do begin
          PointsExpired  := 0;
          if (fieldbyname('ExpiresOnNoOfMonthsAfterPurchase').asInteger <> 0) or
              (fieldbyname('PointExpiresOn').asDatetime <> 0) then begin
              if fieldbyname('ExpiryDate').asDatetime < date then
                PointsExpired := round(fieldbyname('LinePoints').Asfloat - fieldbyname('UsedPoints').asfloat,OtherRoundPlaces);
          end;
          fdAvailablePoints:= (Round(fieldbyname('LinePoints').Asfloat - fieldbyname('UsedPoints').asfloat,OtherRoundPlaces) - PointsExpired);
          AvailablePoints     :=AvailablePoints +fdAvailablePoints;
          AvailablePointValue :=AvailablePointValue +(fdAvailablePoints * fieldbyname('ValueforRewardPoint').asFloat);
        Next;
      end;
    finally
      close;
      free;
    end;
end;

procedure TRewardPointsDetailsGUI.RefreshQuery;
begin
  inherited;
end;

procedure TRewardPointsDetailsGUI.RefreshTotals;
begin
  inherited;

end;


procedure TRewardPointsDetailsGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if (grpExtrafilter.visible) and (grpExtrafilter.Items.count>0) then begin
        GuiPrefs.Node['grpExtrafilter.ItemIndex'].asInteger:= grpExtrafilter.itemindex+1;
  end;
  inherited;
end;

procedure TRewardPointsDetailsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fOnSelectPoints := nil;
  fsgetPointsfilter := '';
end;

procedure TRewardPointsDetailsGUI.FormShow(Sender: TObject);
var
  x:Integer;
begin
  inherited;
      if (grpExtrafilter.visible) and (grpExtrafilter.Items.count>0) then begin
        x:= GuiPrefs.Node['grpExtrafilter.ItemIndex'].asInteger;
        if x > 0 then if grpExtrafilter.Items.count >= x then grpExtrafilter.itemindex := x-1;
      end;

end;

procedure TRewardPointsDetailsGUI.SetgetPointsfilter(const Value: String);
begin
  fsgetPointsfilter := Value;
  filterString:= value;
end;
procedure TRewardPointsDetailsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('DeptID');
  RemoveFieldfromGrid('Category');
end;
procedure TRewardPointsDetailsGUI.setOnSelectPoints(const Value: TNotifyEvent);
begin
  fOnSelectPoints := Value;
  btnRedeem.Enabled := assigned(Value);
  if Assigned(value)  then
    grdMain.options := grdMain.Options + [dgMultiselect];

end;

procedure TRewardPointsDetailsGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if (QrymainCategory.asInteger = 1)  then begin
    if grpExtrafilter.itemIndex = 1 then Afont.style := afont.style+[fsbold]
    else Afont.style := afont.style-[fsbold];
  end;
  if (SelectedCategory =1) and (QrymainCategory.asInteger=2) then
    Afont.Color := clRed;
end;

procedure TRewardPointsDetailsGUI.grdMainDblClick(Sender: TObject);
begin
  if  btnRedeem.Enabled  then begin
    btnRedeem.Click;
  end
  else begin
    if SameText(qryMain.Fields.FieldByName('TransType').AsString,'CashSale') then begin
      case TSalesBase.GetSaleType(qryMain.Fields.FieldByName('SaleID').AsInteger) of
        stPOS,
        stPOSLayby,
        stPOSLaybyPayment,
        stPOSCashSale: SubsequentID := Chr(95) + 'POS';
      end;
    end;
    inherited;
  end;
end;

procedure TRewardPointsDetailsGUI.grdMainMultiSelectRecord(Grid: TwwDBGrid;
  Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  Accept:= true;
  if not selecting then exit;
  if SelectedCategory = 0 then SelectedCategory := Qrymaincategory.asInteger
  else if grdMain.SelectedList.Count = 0 then SelectedCategory := Qrymaincategory.asInteger
  else if SelectedCategory <> QrymainCategory.asInteger then Accept := False;
end;

procedure TRewardPointsDetailsGUI.grdMainTitleButtonClick(Sender: TObject;
  AFieldName: string);
begin
//  inherited;

end;

function TRewardPointsDetailsGUI.ExtraFilter:String ;
var
  grpfilterString:String;
begin
  grpfilterString := '';
  if grpExtrafilter.itemindex = 0 then
    grpfilterString := grpfilterString + 'Category = 1 ';
  if fsgetPointsfilter <> '' then begin
    if grpfilterString <> '' then grpfilterString := '(' + grpfilterString +') and ';
    grpfilterString := grpfilterString +'(' + fsgetPointsfilter+')';
  end;
  REsult := grpfilterString;
end;

initialization
  RegisterClassOnce(TRewardPointsDetailsGUI);


end.
