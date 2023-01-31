unit frmSalesShipment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls, StdCtrls, Shader, DNMPanel , BusObjSales,
  Mask, wwdbedit, DNMSpeedButton, Buttons, Wwdbigrd, Grids, Wwdbgrid, GIFImg;

type
  TfmSalesShipment = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    DNMPanel4: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    dsSalesLines: TDataSource;
    wwDBEdit1: TwwDBEdit;
    Label1: TLabel;
    wwDBEdit2: TwwDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    wwDBEdit3: TwwDBEdit;
    dssaleslinesshipments: TDataSource;
    grdShippingaddresses: TwwDBGrid;
    btnDelete: TwwIButton;
    ERPQuery1: TERPQuery;
    FloatField1: TFloatField;
    WideStringField1: TWideStringField;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    IntegerField5: TIntegerField;
    WideStringField2: TWideStringField;
    FloatField2: TFloatField;
    FloatField3: TFloatField;
    WideStringField3: TWideStringField;
    DateTimeField1: TDateTimeField;
    WideStringField4: TWideStringField;
    btnCompleted: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    fPaintTimer: TTimer;
    lblMsg: TLabel;
    Label4: TLabel;
    edtTotalQtyAssigned: TEdit;
    Label5: TLabel;
    edtQtyTobeAssigned: TEdit;
    btnChoose: TDNMSpeedButton;
    Label6: TLabel;
    wwDBEdit6: TwwDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnChooseClick(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure grdShippingaddressesBeforePaint(Sender: TObject);
    procedure fPaintTimerTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdShippingaddressesColEnter(Sender: TObject);
    procedure grdShippingaddressesEnter(Sender: TObject);
  private
    fSalesObj :TSales;
    fiSalesLineId :Integer;
    DefaultQtyforShipment:Double;
    fbSelectAddresses:Boolean;
    procedure beforeshowShipAddressList(Sender: TObject);
    procedure SelectAddresses(Sender: TwwDBGrid);
    Function SalesLine :TSalesLine;
    procedure HandleGridPaint(var Msg: TMessage); message TX_GridPaint;
    procedure SetFocustoQty;
    function SaveShipments: Boolean;
  public
    Property SalesObj :Tsales read fSalesObj write fSalesObj;
    Property SalesLineId :Integer read fiSalesLineId  write fiSalesLineId ;
    Procedure RefreshTotalShipment;
  end;


implementation

uses CommonFormLib, ShipAddressListForm, CommonLib, tcConst;


{$R *.dfm}

procedure TfmSalesShipment.btnCloseClick(Sender: TObject);
begin
  inherited;
  modalresult := mrCancel;
end;
Function TfmSalesShipment.SaveShipments:Boolean;
var
  fd:Double;
begin
  result:= False;
  SalesLine.SalesLinesShipments.PostDB;
  fd:=SalesLine.TotalQtyShippedtoAddresses[0];
  if fd <> SalesLine.UOMQtyShipped then begin
    MessageDlgXP_Vista('The total Quantity allocated '+ Quotedstr(FloatToStrF(fd,ffGeneral, 15, 2))  +' doesn''t match with the Product''s Shipped Qty '+ Quotedstr(FloatToStrF(SalesLine.UOMQtyShipped, ffGeneral,15, 2))  +'.', mtInformation, [mbOK], 0);
    Exit;
  end;
  SalesLine.SalesLinesShipments.dirty := False;
  REsult:= True;
end;

procedure TfmSalesShipment.btnCompletedClick(Sender: TObject);
begin
  inherited;
  if not SaveShipments then exit;
  salesObj.connection.Commitnestedtransaction;
 modalresult := mrOk;
end;

procedure TfmSalesShipment.btnDeleteClick(Sender: TObject);
begin
  inherited;
  SalesLine.SalesLinesShipments.delete;
  RefreshTotalShipment;
end;

procedure TfmSalesShipment.btnChooseClick(Sender: TObject);
begin
  inherited;
  SalesLine.SalesLinesShipments.PostDB;
  if SalesLine.TotalQtyShippedtoAddresses[0] >= SalesLine.UOMQtyShipped then begin
    MessageDlgXP_Vista('You have already allocated the total Shipped Qty to differnt addresses. It is not possible to allocate more', mtInformation, [mbOK], 0);
    Exit;
  end;

  try
    OpenERPListFormultiselectModal('TShipAddressListGUI' , beforeshowShipAddressList , SelectAddresses);
  finally
    DefaultQtyforShipment:= 0;
  end;
end;
function TfmSalesShipment.SalesLine: TSalesLine;
begin
  REsult := TSalesLine(SalesObj.Lines);
end;

procedure TfmSalesShipment.SelectAddresses(Sender :TwwDBGrid);
var
  i: integer;
  fd:Double;
  Msgoption : Word;
  function Addressescanbeassigned :integer;
  var
    dValue:double;
  begin
    dValue := (SalesLine.UOMQtyShipped -fd)/ DefaultQtyforShipment;
    if trunc(dValue) = dValue then else dvalue := trunc(Dvalue)+1;
    REsult := trunc(dValue);
  end;
begin
 fbSelectAddresses:=True;
 try
  fd:= SalesLine.TotalQtyShippedtoAddresses[0];
  if fd >= SalesLine.UOMQtyShipped then begin
    MessageDlgXP_Vista('You have already allocated the total Shipped Qty to differnt addresses. It is not possible to allocate more', mtInformation, [mbOK], 0);
    Exit;
  end;

  if Sender.SelectedList.Count = 0 then exit;

  Msgoption := 100;
  DefaultQtyforShipment:= Round(Divzer((SalesLine.UOMQtyShipped - fd), Sender.SelectedList.Count), GeneralRoundPlaces) ;
  while True do begin
    DefaultQtyforShipment:= CustomInputFloat('Quantity' , 'Default Quantity in ' + Quotedstr(SalesLine.UnitOfMeasure) +' to Ship in all Addresses that you select' , floatTostrf(DefaultQtyforShipment,ffGeneral, 15,1));
    if DefaultQtyforShipment <0 then exit;

    if DefaultQtyforShipment =0 then  break
    else if Sender.SelectedList.Count*DefaultQtyforShipment +fd >  SalesLine.UOMQtyShipped  then begin
      Msgoption := MessageDlgXP_Vista('You have selected ' + Floattostrf(DefaultQtyforShipment, ffGeneral , 15,2) +
                            ' to be allcoated to each of  ' + inttostr(Sender.SelectedList.Count)+' shipping addresses selected, which is ' + FloatTostrF(DefaultQtyforShipment*Sender.SelectedList.Count, ffGeneral, 15,2) +' in total.' + NL+NL+
                            'The total Quantity left to be allocated is only ' + FloatTostrF(SalesLine.UOMQtyShipped - fd , ffGeneral, 15,2)+ '  which can be allocated to the first ' + inttostr(Addressescanbeassigned) + ' addresses selected.' , mtInformation, [], 0, nil , '' , '', False, nil,
                            'Allocate ''Qty to be allocated''   to '+ quotedstr(inttostr(Addressescanbeassigned)) +'  0f   ' + quotedstr(inttostr(Sender.SelectedList.Count))+'   addresses selected,Enter Another Qty, Cancel');
    end else if Sender.SelectedList.Count*DefaultQtyforShipment +fd <  SalesLine.UOMQtyShipped  then begin
      Msgoption := MessageDlgXP_Vista('You have selected ' + Floattostrf(DefaultQtyforShipment, ffGeneral , 15,2) +
                            ' to be allcoated to each of  ' + inttostr(Sender.SelectedList.Count)+' shipping addresses selected, which is ' + FloatTostrF(DefaultQtyforShipment*Sender.SelectedList.Count, ffGeneral, 15,2) +' in total.' + NL+NL+
                            'The total Quantity left to be allocated is ' + FloatTostrF(SalesLine.UOMQtyShipped - fd , ffGeneral, 15,2)+'.', mtInformation, [], 0, nil , '' , '', False, nil,
                            'Allocate it,Enter Another Qty, Cancel');
    end;
    if Msgoption = 102 then exit
    else if Msgoption =100 then break;
  end;



  showProgressbar(WAITMSG , Sender.Selected.Count);
  try
    if Sender.SelectedList.Count > 0 then begin
      for i := 0 to Sender.SelectedList.Count - 1 do begin
        Sender.DataSource.DataSet.GotoBookmark(sender.SelectedList.Items[i]);
        if fd >= SalesLine.UOMQtyShipped then begin
          HideProgressbar;
          if DefaultQtyforShipment <>0 then
            TimerMsg(lblMsg , 'Total Shipped Qty of '+floattostrf(SalesLine.UOMQtyShipped, ffGeneral, 15,2) +' has been allocated to '+ inttostr(i) + ' out of ' +inttostr(Sender.SelectedList.Count) +' addresses you have selected.');
          exit;
        end;
        if SalesLine.SalesLinesShipments.Locate('ShipAddressID' , Sender.DataSource.DataSet.FieldByName('ShipAddressID').AsInteger , []) = False then begin
          SalesLine.SalesLinesShipments.New;
          SalesLine.SalesLinesShipments.ShipAddressID := Sender.DataSource.DataSet.FieldByName('ShipAddressID').AsInteger;
          SalesLine.SalesLinesShipments.ShipAddressName := Sender.DataSource.DataSet.FieldByName('Company Name').asString;
          if (SalesLine.UOMQtyShipped - fd) > DefaultQtyforShipment then
            SalesLine.SalesLinesShipments.UOMQty := DefaultQtyforShipment
          else
            SalesLine.SalesLinesShipments.UOMQty := SalesLine.UOMQtyShipped - fd;

          fd:= fd+DefaultQtyforShipment;
          SalesLine.SalesLinesShipments.PostDB;
        end;
      end;
      HideProgressbar;
      if DefaultQtyforShipment <> 0 then
        TimerMsg(lblMsg , floattostrf(fd , ffgeneral, 15,2) +' of the Total Shipped Qty '+floattostrf(SalesLine.UOMQtyShipped, ffGeneral, 15,2) +' has been allocated to the addresses you have selected.')
    end;
  finally
    HideProgressbar;
  end;
 finally
   fbSelectAddresses:= False;
   RefreshTotalShipment;
 end;
end;
procedure TfmSalesShipment.beforeshowShipAddressList(Sender :TObject);
begin
   if not(Sender is TShipAddressListGUI) then exit;
   TShipAddressListGUI(Sender).filterString :='Customer_Id =' + inttostr(SalesObj.customerID);
   TShipAddressListGUI(Sender).ShipAddressIdsAlreadySelected := TERPQuery(salesline.SalesLinesShipments.dataset).GroupConcat('ShipAddressID');
end;
procedure TfmSalesShipment.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TfmSalesShipment.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := true;
  if SalesLine.SalesLinesShipments.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes: begin
        if not SaveShipments then  canclose:= False
        else SalesObj.Connection.CommitNestedTransaction;
      end;
      mrNo : SalesObj.Connection.RollbackNestedTransaction;
      mrCancel:CanClose := false;
    else
      CanClose := true;
    end;
  end;
end;

procedure TfmSalesShipment.FormCreate(Sender: TObject);
begin
  inherited;
  fbTabSettingEnabled := False;
  fSalesObj:= nil;
  DefaultQtyforShipment:= 0;
  fbSelectAddresses:=False;
end;

procedure TfmSalesShipment.FormShow(Sender: TObject);
begin
  SalesLine.Locate(SalesLine.IDFieldName , salesLineId , []);
  dsSalesLines.dataset := SalesLine.dataset;
  SalesLine.SalesLinesShipments;
  dssaleslinesshipments.dataset :=  SalesLine.SalesLinesShipments.dataset;
  RefreshTotalShipment;
  salesObj.connection.beginnestedTransaction;
  if SalesLine.TotalQtyShippedtoAddresses[0] >= SalesLine.UOMQtyShipped then
       (*TimerMsg(lblMsg , 'You have already allocated the total Shipped Qty to differnt addresses. It is not possible to allocate more')*)
  else btnChoose.Click;
  inherited;
end;
procedure TfmSalesShipment.fPaintTimerTimer(Sender: TObject);
begin
  inherited;
  if not(csDestroying in ComponentState) then begin
    grdShippingaddresses.OnBeforePaint := nil;
    grdShippingaddresses.Invalidate;
  end;
  fPaintTimer.enabled := false;

end;

procedure TfmSalesShipment.grdShippingaddressesBeforePaint(Sender: TObject);
begin
  inherited;
  PostMessage(Handle, TX_GridPaint, TwwDbGrid(Sender).Handle, 0);
end;
procedure TfmSalesShipment.grdShippingaddressesColEnter(Sender: TObject);
begin
  inherited;
  SetFocustoQty;
end;
procedure TfmSalesShipment.grdShippingaddressesEnter(Sender: TObject);
begin
  inherited;
  SetFocustoQty;
end;

procedure TfmSalesShipment.SetFocustoQty;
begin
  if sametext(TField(grdShippingaddresses.GetActiveField).fieldname , 'ShipAddressName') then
    grdShippingaddresses.SetActiveField('UOMQty');
end;

procedure TfmSalesShipment.HandleGridPaint(var Msg: TMessage);
var
  Min: integer;
  Max: integer;
  LeftPos: integer;
  TopPos: integer;
  TmpBitmap: TBitmap;
  ControlCanvas: TControlCanvas;
  ScrollBarVisible: boolean;
  ScrollBarAdjust: integer;
begin
  if not(csDestroying in ComponentState) then begin
    inherited;
    TmpBitmap := TBitmap.Create;
    ControlCanvas := TControlCanvas.Create;
    try
      GetScrollRange(grdShippingaddresses.Handle, SB_HORZ, Min, Max);
      ScrollBarVisible := (Min <> Max);
      if ScrollBarVisible then ScrollBarAdjust := 16
      else ScrollBarAdjust := 0;
      TmpBitmap.Transparent := True;
      TmpBitmap.TransparentColor := Self.Color;
      TmpBitmap.Width := grdShippingaddresses.Width;
      TmpBitmap.Height := grdShippingaddresses.Height;
      ControlCanvas.Control := grdShippingaddresses;
      TmpBitmap.Canvas.CopyRect(Rect(0, 0, grdShippingaddresses.Width, grdShippingaddresses.Height), ControlCanvas, Rect(0, 0, grdShippingaddresses.Width, grdShippingaddresses.Height));

      LeftPos := (grdShippingaddresses.Width - imgGridWatermark.Picture.Bitmap.Width - 20) div 2;
      TopPos := (grdShippingaddresses.Height - imgGridWatermark.Picture.Bitmap.Height + grdShippingaddresses.RowHeights[0] - ScrollBarAdjust) div 2;

      ControlCanvas.Draw(LeftPos, TopPos, imgGridWatermark.Picture.Bitmap);
      //
      // Paint the grid over the watermark
      //
      ControlCanvas.Draw(0, 0, TmpBitmap);
      grdShippingaddresses.OnBeforePaint := nil;

    finally
      FreeandNil(TmpBitmap);
      FreeandNil(ControlCanvas);
      fPaintTimer.enabled := True;
    end;

  end;

end;

procedure TfmSalesShipment.RefreshTotalShipment;
var
  fd:Double;
begin
  try
    if fbSelectAddresses then exit;
    fd:=SalesLine.TotalQtyShippedtoAddresses[0];
    edtTotalQtyAssigned.Text := FloatToStrF(fd, ffGeneral, 15, 2);
    edtQtyTobeAssigned.Text  := FloatToStrF(SalesLine.UOMQtyShipped - fd, ffGeneral, 15, 2);
  Except
    on E:Exception do begin
(*      if devmode then
        MessageDlgXP_vista(E.Message, mtWarning, [mbOK], 0);*)
    end;
  end;
end;

initialization
  RegisterClassOnce(TfmSalesShipment);

end.



