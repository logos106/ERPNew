unit EmployeeCommissionsFrm;

interface

uses
  Windows, Forms, DB, StdCtrls, Mask, DBCtrls, wwcheckbox, Controls, ExtCtrls,
  Classes, DNMPanel,
  BusObjEmployeePay, frmBase, BusObjBase, wwclearbuttongroup, wwradiogroup,
  DNMSpeedButton, MemDS, DBAccess, MyAccess,ERPdbComponents, Grids, Wwdbigrd, Wwdbgrid,
  Buttons, wwdblook, graphics, ComCtrls, wwdbedit,BaseInputForm, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ProgressDialog;

type
  TfrmEmployeeCommissions = Class(TBaseInputGUI)
    DSEmployees: TDataSource;
    DNMPanel1: TDNMPanel;
    dsEmployeeProductCommission: TDataSource;
    qryParts: TERPQuery;
    dsProductcommission: TDataSource;
    dsEmpNoCommsProducts: TDataSource;
    pnlempSales: TDNMPanel;
    lblNote: TLabel;
    Label7: TLabel;
    wwDBEdit1: TwwDBEdit;
    pnlcommission: TDNMPanel;
    mainpage: TPageControl;
    tabEmployee: TTabSheet;
    DNMPanel2: TDNMPanel;
    Label4: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label2: TLabel;
    lblOHbase: TLabel;
    Label6: TLabel;
    lblformula: TLabel;
    chkUseEmpComm: TwwCheckBox;
    optCommissionOnPaid: TwwRadioGroup;
    optCommissionInvoiceExPrice: TwwRadioGroup;
    optCommissionOn: TwwRadioGroup;
    txtCommissionRate: TDBEdit;
    edtOverheadbaserate: TDBEdit;
    grdEmpNoCommsProducts: TwwDBGrid;
    grdEmpNoCommsProductsIButton: TwwIButton;
    DNMSpeedButton1: TDNMSpeedButton;
    btnExplain: TDNMSpeedButton;
    Tabproduct: TTabSheet;
    DNMPanel3: TDNMPanel;
    Label5: TLabel;
    btnProdList: TDNMSpeedButton;
    chkUseProdComm: TwwCheckBox;
    DNMSpeedButton2: TDNMSpeedButton;
    btnProdListForAllemp: TDNMSpeedButton;
    pnlAllemp: TDNMPanel;
    pnlEmp: TDNMPanel;
    Label1: TLabel;
    grdemployeeProductcommission: TwwDBGrid;
    grdemployeeProductcommissionIButton: TwwIButton;
    Label3: TLabel;
    grdProductcommission: TwwDBGrid;
    grdProductcommissionIButton: TwwIButton;
    procedure chkUseEmpCommClick(Sender: TObject);
    procedure chkUseProdCommClick(Sender: TObject);
    procedure chkUseAllCommClick(Sender: TObject);
    procedure SetSubEmpPay(Const Value :Temployeepay );
    procedure edtOverheadbaserateEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkUseEmpCommEnter(Sender: TObject);
    procedure optCommissionOnChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnProdListClick(Sender: TObject);
    procedure grdemployeeProductcommissionCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure grdemployeeProductcommissionDblClick(Sender: TObject);
    procedure grdProductcommissionCalcCellColors(Sender: TObject;
      Field: TField; State: TGridDrawState; Highlight: Boolean;
      AFont: TFont; ABrush: TBrush);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure PageControlDrawTab(Control: TCustomTabControl; TabIndex: integer; const Rect: TRect; Active: boolean);
    procedure pageControlChange(Sender: TObject);
    procedure TabSheetShow(Sender: TObject);
    procedure TabControlExit(Sender: TObject);
    procedure btnExplainClick(Sender: TObject);
    procedure grdEmpNoCommsProductsDblClick(Sender: TObject);
    procedure grdemployeeProductcommissionIButtonClick(Sender: TObject);
    procedure grdProductcommissionIButtonClick(Sender: TObject);
    procedure grdEmpNoCommsProductsIButtonClick(Sender: TObject);
    procedure optCommissionOnPaidChange(Sender: TObject);
    procedure optCommissionOnPaidClick(Sender: TObject);
    procedure optCommissionOnClick(Sender: TObject);
    procedure optCommissionInvoiceExPriceClick(Sender: TObject);
    procedure mainpageResize(Sender: TObject);
    procedure lblNoteDblClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    fSubEmpPay:Temployeepay;
    procedure SetCommissionControls;
    procedure setUSeSalesCommission(const Value: Boolean);
    Procedure NonCommissionProduct(Sender:TwwDBGrid);
    Procedure ExplainFormula;
    procedure ResizePanels;
  public
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);override;
    property SubEmpPay:Temployeepay  read fSubEmpPay write SetSubEmpPay ;
    Property USeSalesCommission:Boolean Write setUSeSalesCommission;
  end;

implementation

{$R *.dfm}
uses
   BaseClassFuncs, CommonLib, ProductListForm , dialogs, BusObjConst,
  Variants, busobjProductcommission, frmProductCommission,
  frmProductCommissions, ProductListExpressForm,
  FrmProductCommissionOptions, BusObjEmployeeDetails, sysutils, tcDataUtils, DNMLib,
  CommonFormLib, Preferences;

procedure TfrmEmployeeCommissions.SetSubEmpPay(Const Value :Temployeepay);
begin
  fSubEmpPay := Value;
end;

procedure TfrmEmployeeCommissions.chkUseEmpCommClick(Sender: TObject);
begin
SetCommissionControls;
(*  if not Assigned(SubEmpPay) then exit;
//  if not (SubEmpPay.EmployeeDetails.Dataset.State in [dsEdit, dsInsert]) then Exit;

  if chkUseEmpComm.Checked then begin
    SubEmpPay.EmployeeDetails.Commissionuseprod  := false;
    SubEmpPay.EmployeeDetails.Commissionuseboth  := false;
  end;*)
end;

procedure TfrmEmployeeCommissions.chkUseProdCommClick(Sender: TObject);
begin
  SetCommissionControls;
(*  if chkUseProdComm.Checked then
    if screen.activecontrol = chkUseProdComm then begin
      // show the roduct form so user can edit product commissions
      with TProductListGUI(BaseClassFuncs.GetBaseListingByClassName('TProductListGUI', true)) do begin
        FormStyle := fsMdiChild;
        Productlistmode :=   tCommissionList;
        BringToFront;
      end;
    end;*)
end;

procedure TfrmEmployeeCommissions.chkUseAllCommClick(Sender: TObject);
begin
(*  if not Assigned(SubEmpPay) then exit;
//  if not (EmpPay.EmployeeDetails.Dataset.State in [dsEdit, dsInsert]) then Exit;
  SetCommissionControls;
  if chkUseAllComm.Checked then begin
    SubEmpPay.EmployeeDetails.Commissionuseemp  := false;
    SubEmpPay.EmployeeDetails.Commissionuseprod := false;
    // show the roduct form so user can edit product commissions
    with BaseClassFuncs.GetBaseListingByClassName('TProductListGUI', true) do begin
      FormStyle := fsMdiChild;
      BringToFront;
    end;
  end;*)
end;

procedure TfrmEmployeeCommissions.SetCommissionControls;
var
  IsEnabled: boolean;
begin
  IsEnabled := chkUseEmpComm.Checked ;

  optCommissionOn.Enabled := IsEnabled;
  optCommissionInvoiceExPrice.Enabled := IsEnabled;
  txtCommissionRate.Enabled := IsEnabled;

  IsEnabled := chkUseEmpComm.Checked or chkUseProdComm.Checked ;
  optCommissionOnPaid.Enabled := IsEnabled;
  edtOverheadbaserate.Enabled := IsEnabled;
  optCommissionOnChange(optCommissionOn);
  lblformula.Enabled := isEnabled;


end;

procedure TfrmEmployeeCommissions.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Change) and (Value = BusobjEventVal_ForAllEmployees) then begin
      if Sender is TProductCommission then
        TProductCommission(Sender).EmployeeId :=SubEmpPay.EmployeeDetails.ID;
  end;
end;

procedure TfrmEmployeeCommissions.edtOverheadbaserateEnter(
  Sender: TObject);
begin
  inherited;
  if      (optCommissionOn.Value <> 'GO')
      and (optCommissionOn.Value <> 'LO') then
    SetControlFocus(optCommissionOn);
  edtOverheadbaserate.Enabled := (optCommissionOn.Value = 'GO') or (optCommissionOn.Value = 'LO');
  lblOHbase.Enabled           := (optCommissionOn.Value = 'GO') or (optCommissionOn.Value = 'LO');
end;

procedure TfrmEmployeeCommissions.FormShow(Sender: TObject);
begin
  inherited;
  SetCommissionControls;
  mainpage.ActivePageIndex :=0;
end;

procedure TfrmEmployeeCommissions.chkUseEmpCommEnter(Sender: TObject);
begin
  inherited;
  SetCommissionControls;
end;

(*procedure TfrmEmployeeCommissions.Opencommissionform(Sender: TObject);
var
  form :Tcomponent ;
begin
  Form := GetComponentByClassName('TfmProductCommission' , True, Self);
  if not Assigned(Form) then exit;
  {strSQL:= 'Select ProductCommissionId from tblproductcommission where PartsId = ' + IntToStr()}
end;*)

procedure TfrmEmployeeCommissions.optCommissionOnChange(Sender: TObject);
begin
  inherited;
  edtOverheadbaserate.Enabled := (optCommissionOn.Value = 'GO') or (optCommissionOn.Value = 'LO');
  lblOHbase.Enabled           := (optCommissionOn.Value = 'GO') or (optCommissionOn.Value = 'LO');
end;

procedure TfrmEmployeeCommissions.setUSeSalesCommission(const Value: Boolean);
var
  ctr:Integer;
begin
  if not Value then begin
    lblNote.visible := true;
    for ctr := 0 to ComponentCount-1 do begin
      if Components[ctr] is TControl then
        (*if (TControl(Components[ctr]).Parent <> pnlempSales) and (TControl(Components[ctr]) <> DNMPanel1)  then*)
        if TControl(Components[ctr]).Parent = pnlcommission then
          TControl(Components[ctr]).enabled := False;
    end;
    lblNote.Enabled:= true;
  end;
end;

procedure TfrmEmployeeCommissions.FormCreate(Sender: TObject);
var
  Index, ControlIndex:Integer;
  procedure SetPanelProperties(const Panel: TDNMPanel);
  var
    fIndex: Integer;
  begin
    Panel.Transparent := False;
    Panel.Color := $00D7FFFF;

    for fIndex := 0 to Panel.ControlCount - 1 do begin
      if Panel.Controls[fIndex] is TDNMPanel then
        SetPanelProperties(TDNMPanel(Panel.Controls[fIndex]));
    end;
  end;

begin
  AllowCustomiseGrid := true;
  AllowGridSorting := True;
  inherited;
  (*optCommissionOn.hint              := Commissionhint;*)
  grdemployeeProductcommission.hint := 'Double click to edit details';
  grdProductcommission.hint         := 'Double click to edit details';
  grdemployeeProductcommission.showhint := true;
  (*optCommissionOn.showhint              := true;*)
  grdemployeeProductcommission.showhint := true;
  for Index := 0 to ComponentCount - 1 do begin
        if Components[Index] is TPageControl then begin
          TPageControl(Components[Index]).OwnerDraw := true;
        end else if Components[Index] is TTabSheet then begin
          for ControlIndex := 0 to TTabSheet(Components[Index]).ControlCount - 1 do begin
            if TTabSheet(Components[Index]).Controls[ControlIndex] is TDNMPanel then
              SetPanelProperties(TDNMPanel(TTabSheet(Components[Index]).Controls[ControlIndex]));
          end;
        end;
  end;
end;

procedure TfrmEmployeeCommissions.FormResize(Sender: TObject);
begin
  inherited;
  ResizePanels;
end;
Procedure TfrmEmployeeCommissions.ResizePanels;
begin
  pnlEmp.width := trunc(mainpage.width/2)-pnlEmp.margins.left-pnlEmp.margins.Right;

end;
procedure TfrmEmployeeCommissions.btnProdListClick(Sender: TObject);
begin
  inherited;
  if chkUseProdComm.checked = False then begin
      if CommonLib.MessageDlgXP_Vista('Do you wish to enable Product commission for this employee?' , mtConfirmation, [mbyes,mbno] , 0 ) = mrno then exit;
      SubEmpPay.EmployeeDetails.editdb;
      chkUseProdComm.checked:= True;
      SubEmpPay.EmployeeDetails.postdb;
  end;
  with TfmProductCommissions(BaseClassFuncs.GetBaseListingByClassName('TfmProductCommissions', true)) do begin
    Employeepay := SubEmpPay;
    ForAllEmployees := (sender = btnProdListForAllemp);
    FormStyle := fsMdiChild;
    BringToFront;
  end;
end;

procedure TfrmEmployeeCommissions.grdemployeeProductcommissionCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if SubEmpPay.EmployeeProductCommission.Active = False then begin
     AFont.Color := clInactiveCaption;
  end;
end;

procedure TfrmEmployeeCommissions.grdemployeeProductcommissionDblClick(
  Sender: TObject);
var
  ProductCommissionID:Integer;
  form :TComponent;
begin
  inherited;
  ProductCommissionID := TwwDBGrid(SendeR).Datasource.DAtaset.fieldbyname('ProductCommissionId').asInteger;
  if ProductCommissionID = 0 then exit;
  form := GetComponentByClassName('TfmProductCommission');
  if not assigned(Form) then exit;
  if TfmProductCommission(form).visible then begin
      CommonLib.MessageDlgXP_Vista('Product commission form is already opened. Please close it' , mtWarning, [mbok], 0);
      exit;
  end;
  TfmProductCommission(Form).KeyId := ProductCommissionID;
  TfmProductCommission(Form).btnProdList.visible := False;
  TfmProductCommission(Form).showModal;
  TwwDBGrid(SendeR).Datasource.DAtaset.close;
  TwwDBGrid(SendeR).Datasource.DAtaset.open;
end;

procedure TfrmEmployeeCommissions.grdProductcommissionCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState;
  Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if SubEmpPay.AllEmployeeProductCommission.Active = False then begin
     AFont.Color := clInactiveCaption;
  end;

end;

{procedure TfrmEmployeeCommissions.ProductGridDataSelect(Sender: TwwDbGrid);
var
  IdStr: string;
  i: integer;
  ProgressDialog: TProgressDialog;
begin
  IdStr := '';
ProgressDialog:= TProgressDialog.create(self);
TwwDBGrid(Sender).datasource.dataset.disablecontrols;
try
  With TwwDBGrid(Sender).datasource.dataset do begin
          ProgressDialog.Caption := 'Please Wait .......';
      ProgressDialog.MinValue := 0;
      ProgressDialog.MaxValue := TwwDBGrid(Sender).SelectedList.Count;
      ProgressDialog.Step := 1;
      ProgressDialog.Execute;

    for i := 0 to TwwDBGrid(Sender).SelectedList.Count - 1 do begin
      GotoBookmark(TwwDBGrid(Sender).SelectedList.Items[i]);
      if fieldbyname('PARTSID').AsInteger <> 0 then begin
        (*if IdStr <> '' then IdStr := IdStr + ',';
        IdStr := IdStr + Trim(fieldbyname('PARTSID').AsString);
      end;
      ProgressDialog.Stepit;
    end;
  end;

  if IDstr <> '' then begin*)
    if not SubEmpPay.EmployeeProductCommission.Locate('PartsID;employeeId' , varArrayof([fieldbyname('PARTSID').asInteger,SubEmpPay.EmployeeDetails.ID]), []) then begin
      SubEmpPay.EmployeeProductCommission.NEw;
        SubEmpPay.EmployeeProductCommission.PartsId    := fieldbyname('PARTSID').asInteger;
        SubEmpPay.EmployeeProductCommission.employeeID := SubEmpPay.EmployeeDetails.ID;
        SubEmpPay.EmployeeProductCommission.ForAllEmployees := False;
    end;
      (*if SubEmpPay.EmployeeProductCommission.count > 0 then begin
        if SubEmpPay.EmployeeProductCommission.Lock = False then begin
            SubEmpPay.EmployeeProductCommission.ResultStatus.addItem(False, rssWarning , 0 , StringReplace(SubEmpPay.EmployeeProductCommission.UserLock.LockMessage , 'Unable to update data.' , 'Unable to update the Commission Rate of ' +qryMainProductName.asString +'.', [rfIgnoreCase]));
            Continue;
        end;
      end else begin
        SubEmpPay.EmployeeProductCommission.New;*)
      (*end;*)
      SubEmpPay.EmployeeProductCommission.CommissionRate := ;
      SubEmpPay.EmployeeProductCommission.IsPercentage := chkIsPercentage.checked;
      SubEmpPay.EmployeeProductCommission.PostDB;
      ProgressDialog.Stepit;
    end;
    end;
  end;
finally
    TwwDBGrid(Sender).datasource.dataset.enablecontrols;
    Freeandnil(ProgressDialog);
end;

end;    }

(*procedure TfrmEmployeeCommissions.RefreshCommission;
begin
  SubEmpPay.EmployeeProductCommission.refreshdb;
end;*)

procedure TfrmEmployeeCommissions.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
(*  with TProductListExpressGUI(BaseClassFuncs.GetBaseListingByClassName('TProductListExpressGUI', true)) do begin
        FormStyle := fsMdiChild;
        ExpresslistPopup('No Comms for Emp' , NonCommissionProduct);
        BringToFront;
  end;*)
  OpenERPListFormultiselectModal('TProductListExpressGUI' , nil , NonCommissionProduct)
end;

procedure TfrmEmployeeCommissions.NonCommissionProduct(Sender: TwwDBGrid);
var
  I:Integer;
  ds:TDataset;
  EmployeeID:Integer;
  PartsID:Integer;
begin
  ds:=TDataset(SubEmpPay.EmployeeNoCommissionProducts.dataset);
  EmployeeID := SubEmpPay.employeeDetails.ID;

  With Sender.Datasource.Dataset do begin
    for i := 0 to Sender.SelectedList.Count - 1 do begin
      GotoBookmark(Sender.SelectedList.Items[i]);
      PartsId :=fieldbyname('PARTSID').asInteger;
      if PartsId <> 0 then begin
        if not (ds.Locate('EmployeeId;ProductID' ,varArrayOf([EmployeeID, PartsId ]) , [])) then begin
          SubEmpPay.EmployeeNoCommissionProducts.New;
          SubEmpPay.EmployeeNoCommissionProducts.EmployeeID :=SubEmpPay.employeeDetails.ID;
          SubEmpPay.EmployeeNoCommissionProducts.ProductId :=fieldbyname('PARTSID').AsInteger ;
          SubEmpPay.EmployeeNoCommissionProducts.Productname :=fieldbyname('Productname').asString;
          SubEmpPay.EmployeeNoCommissionProducts.Postdb;
        end;
      end;
    end;
  end;
end;

procedure TfrmEmployeeCommissions.PageControlDrawTab(
  Control: TCustomTabControl; TabIndex: integer; const Rect: TRect;
  Active: boolean);
var
  TmpRect: TRect;
  Bitmap: TBitmap;

  Function FindPageforTabIndex( pagecontrol: TPagecontrol; tabindex: Integer ): TTabSheet;
  Var
    i: Integer;
  Begin
    Assert( Assigned( pagecontrol ));
    Assert( (tabindex >= 0) and (tabindex < pagecontrol.pagecount ));
    Result := nil;
    For i:= 0 To pagecontrol.pagecount-1 Do
      If pagecontrol.pages[i].tabVisible Then Begin
        Dec( tabindex );
        If tabindex < 0 Then Begin
          result := pagecontrol.pages[i];
          break;
        End;
      End;
  end;


begin
  Bitmap := TBitmap.Create;
  try
    TmpRect    := Rect;
    Bitmap.Width := 300;
    Bitmap.Height := 300;
    Bitmap.Canvas.Brush.Color := $00D7FFFF;
    Bitmap.Canvas.FillRect(Classes.Rect(0, 0, 300, 300));

    Control.Canvas.Brush.Bitmap := Bitmap;
    TmpRect := Control.ClientRect;
    TmpRect.Left := ((TPageControl(Control).TabWidth * TPageControl(Control).PageCount) div TPageControl(Control).RowCount) + 4;
    TmpRect.Bottom := Rect.Bottom - 4;
    Control.Canvas.FillRect(TmpRect);
    TmpRect := Rect;
    TmpRect.Bottom := TmpRect.Bottom + 2;
    Control.Canvas.FillRect(TmpRect);
    TmpRect.Bottom := TmpRect.Bottom - 2;

    if Active then
        Control.Canvas.Font.Color := clNavy;

    Control.Canvas.Brush.Style := bsClear;

    DrawText(Control.Canvas.Handle, PChar(FindPageforTabIndex(TPageControl(Control),TabIndex).Caption), - 1, TmpRect, DT_SINGLELINE or DT_VCENTER or DT_CENTER);

  finally
    FreeAndNil(Bitmap);
  end;

end;

procedure TfrmEmployeeCommissions.pageControlChange(Sender: TObject);
begin
  PostMessage(Self.Handle, CM_FOCUSCHANGED,  0, 0);
  Application.ProcessMessages;
end;

procedure TfrmEmployeeCommissions.TabSheetShow(Sender: TObject);
var
  TabSheetRect: TRect;
  PageControlRect: TRect;
  Bitmap: TBitmap;
  fCanvas: TControlCanvas;
begin
  Bitmap := TBitmap.Create;
  fCanvas := TControlCanvas.Create;
  try
    Bitmap.Width := 300;
    Bitmap.Height := 300;
    Bitmap.Canvas.Brush.Color := $00D7FFFF;
    Bitmap.Canvas.FillRect(Rect(0, 0, 300, 300));
    TabSheetRect := TTabSheet(Sender).ClientRect;
    fCanvas.Control := TTabSheet(Sender);
    fCanvas.Brush.Bitmap := Bitmap;
    fCanvas.FillRect(TabSheetRect);
    fCanvas.Control := TTabSheet(Sender).PageControl;
    fCanvas.Brush.Bitmap := Bitmap;
    PageControlRect := fCanvas.Control.ClientRect;
    PageControlRect.Left := TTabSheet(Sender).Left - 2;
    PageControlRect.Top := TTabSheet(Sender).Top - 2;
    PageControlRect.Right := PageControlRect.Right - 2;
    PageControlRect.Bottom := PageControlRect.Bottom - 2;
    fCanvas.FillRect(PageControlRect);
  finally
    FreeAndNil(Bitmap);
    FreeAndNil(fCanvas);
  end;


end;

procedure TfrmEmployeeCommissions.TabControlExit(Sender: TObject);
begin
  if TPageControl(TTabSheet(Sender).Parent).ActivePage = Sender then
      if screen.activecontrol =  TPageControl(TTabSheet(Sender).Parent) then  begin
          PostMessage(Self.Handle, CM_FOCUSCHANGED,  0, 0);
          Application.ProcessMessages;
      end;
end;

procedure TfrmEmployeeCommissions.btnExplainClick(Sender: TObject);
var
  Form:TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TFmProductCommissionOptions');
  if Assigned(Form) then begin
    with TFmProductCommissionOptions(Form) do begin
      Employeename := SubEmpPay.EmployeeDetails.Employeename;
      FormStyle := fsMDIChild;
      TForm(Self.dnmpanel1.parent.owner).Invalidate;
      TForm(Self.dnmpanel1.parent.owner).bringtofront;
      TForm(Self.dnmpanel1.parent.owner).Repaint;
      BringToFront;
    end;
  end;
end;

procedure TfrmEmployeeCommissions.grdEmpNoCommsProductsDblClick(
  Sender: TObject);
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('Do you wish to remove ' + SubEmpPay.EmployeeNoCommissionProducts.ProductName+
          ' from ''Products to Exclude from Sales commission for ' + SubEmpPay.EmployeeDetails.Employeename+'?' , mtConfirmation, [mbyes,mbno] , 0 ) = mrno then exit;
  SubEmpPay.EmployeeNoCommissionProducts.Delete;
end;

procedure TfrmEmployeeCommissions.grdemployeeProductcommissionIButtonClick(
  Sender: TObject);
begin
  inherited;
  if (SubEmpPay.EmployeeProductCommission.count = 0) or (SubEmpPay.EmployeeProductCommission.Partname = '') then exit;
  if SubEmpPay.EmployeeProductCommission.Active  then
  if CommonLib.MessageDlgXP_Vista('Do You Wish To Delete Product ' + SubEmpPay.EmployeeProductCommission.PartName +' From ' + SubEmpPay.EmployeeDetails.Employeename+'''s Commission Calculation?' , mtconfirmation, [mbyes, mbno] , 0) = mrno then exit;
  if not SubEmpPay.EmployeeProductCommission.Active  then
    if CommonLib.MessageDlgXP_Vista('Do You Wish To Add Product ' + SubEmpPay.EmployeeProductCommission.PartName +' From ' + SubEmpPay.EmployeeDetails.Employeename+'''s Commission Calculation?' , mtconfirmation, [mbyes, mbno] , 0) = mrno then exit;

  SubEmpPay.EmployeeProductCommission.Active := not(SubEmpPay.EmployeeProductCommission.Active);
  SubEmpPay.EmployeeProductCommission.PostDB;
end;

procedure TfrmEmployeeCommissions.grdProductcommissionIButtonClick(
  Sender: TObject);
begin
  inherited;
  if (SubEmpPay.AllemployeeProductcommission.count = 0) or (SubEmpPay.AllemployeeProductcommission.Partname = '') then exit;
  if SubEmpPay.AllemployeeProductcommission.Active then
  if CommonLib.MessageDlgXP_Vista('Do You Wish To Delete Product ' + SubEmpPay.AllemployeeProductcommission.PartName +' From All Employee''s Commission Calculation?' , mtconfirmation, [mbyes, mbno] , 0) = mrno then exit;
  if not SubEmpPay.AllemployeeProductcommission.Active then
    if CommonLib.MessageDlgXP_Vista('Do You Wish To Add Product ' + SubEmpPay.AllemployeeProductcommission.PartName +' From All Employee''s Commission Calculation?' , mtconfirmation, [mbyes, mbno] , 0) = mrno then exit;
  SubEmpPay.AllemployeeProductcommission.Active := not(SubEmpPay.AllemployeeProductcommission.Active);
  SubEmpPay.AllemployeeProductcommission.PostDB;
end;

procedure TfrmEmployeeCommissions.lblNoteDblClick(Sender: TObject);
begin
  inherited;
  OpenPrefform('Sales' ,  'chkUSeSalesCommission', 0 , True , 'Use Sales Commission');
end;

procedure TfrmEmployeeCommissions.mainpageResize(Sender: TObject);
begin
  inherited;
  try
    RealignTabControl(mainpage, 1);
  Except
    // kill the exception
  end;
end;

procedure TfrmEmployeeCommissions.grdEmpNoCommsProductsIButtonClick(
  Sender: TObject);
begin
  inherited;
  if (SubEmpPay.EmployeeNoCommissionProducts.count = 0) or (SubEmpPay.EmployeeNoCommissionProducts.ProductName = '') then exit;
  if CommonLib.MessageDlgXP_Vista('Do You Wish To Include Product ' + SubEmpPay.EmployeeNoCommissionProducts.ProductName +' For ' + SubEmpPay.EmployeeDetails.Employeename+'''s Commission Calculation?' , mtconfirmation, [mbyes, mbno] , 0) = mrno then exit;
  SubEmpPay.EmployeeNoCommissionProducts.Active := False;
  SubEmpPay.EmployeeNoCommissionProducts.PostDB;
end;
Procedure TfrmEmployeeCommissions.ExplainFormula;
  function SalesAmountDesc :String;
  begin
      if optCommissionInvoiceExPrice.Itemindex = 0 then
        result :='Sales Amount (ex)'
      else result :='Sales Amount (inc)';
  end;
  var
    formuladesc:String;
begin
(*
    if optCommissionOn.Itemindex  = 0 then begin
        formuladesc :=SalesAmountDesc +' * Commission Rate /100 ';
    end else if optCommissionOn.Itemindex  = 1 then begin
        formuladesc := '('+SalesAmountDesc +' - Total cost )* Commission Rate /100 ';
    end else if optCommissionOn.Itemindex  = 4 then begin
        formuladesc :='('+SalesAmountDesc +' - (Total Cost + ('+SalesAmountDesc +' * OH %age /100)))*Commission Rate /100  ';
    end else if optCommissionOn.Itemindex  = 3 then begin
        formuladesc := '(LandedCost + ('+SalesAmountDesc +' * OH %age/100)) *Commission Rate /100   ';
    end else if optCommissionOn.Itemindex  = 2 then begin
        formuladesc := 'LandedCost  *Commission Rate /100   ';
    end;
*)
    case optCommissionOn.Itemindex  of

      0: formuladesc := SalesAmountDesc +' * Commission Rate /100 ';
      1: formuladesc := '('+SalesAmountDesc +' - Total cost )* Commission Rate /100 ';
      2: formuladesc := 'LandedCost  *Commission Rate /100   ';
      3: formuladesc := '(LandedCost + ('+SalesAmountDesc +' * OH %age/100)) *Commission Rate /100   ';
      4: formuladesc := '('+SalesAmountDesc +' - (Total Cost + ('+SalesAmountDesc +' * OH %age /100)))*Commission Rate /100  ';
      5: formuladesc := '(Landed Cost + Latest Cost) * CommissionRate / 100  ';
    end;

    if formuladesc <> '' then
      if optCommissionOnPaid.itemindex = 1 then
        formuladesc := 'For Paid Sales  :  '+ formuladesc
      else formuladesc := 'For All Sales  :  '+ formuladesc;
    lblformula.Caption := formuladesc;
    lblformula.refresh;
end;
procedure TfrmEmployeeCommissions.optCommissionOnPaidChange(
  Sender: TObject);
begin
  inherited;
  ExplainFormula;
end;

procedure TfrmEmployeeCommissions.optCommissionOnPaidClick(
  Sender: TObject);
begin
  inherited;
  ExplainFormula;
end;

procedure TfrmEmployeeCommissions.optCommissionOnClick(Sender: TObject);
begin
  inherited;
  ExplainFormula;
end;

procedure TfrmEmployeeCommissions.optCommissionInvoiceExPriceClick(
  Sender: TObject);
begin
  inherited;
  ExplainFormula;
end;

initialization
RegisterClassOnce(TfrmEmployeeCommissions);
end.
