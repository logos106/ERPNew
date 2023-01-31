unit FrmProductQtyAdjOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, Shader, DNMPanel, DNMSpeedButton, BaseListingForm , ProductQtyAdjLib,
  wwcheckbox, wwdbdatetimepicker, wwdblook;

type
  TFmProductQtyAdjOptions = class(TBaseInputGUI)
    pnlProductList: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnClose: TDNMSpeedButton;
    btnSelectAllProducts: TDNMSpeedButton;
    pnlClasses: TDNMPanel;
    report1n2: TSplitter;
    btnSelectAllClasses: TDNMSpeedButton;
    MnuAdjustAllocationAll: TDNMSpeedButton;
    MnuEmptyAllocationAll: TDNMSpeedButton;
    Label1: TLabel;
    btnEmptyStock: TDNMSpeedButton;
    pnlDetails: TDNMPanel;
    lblStockDate: TLabel;
    cboDBStockDate: TwwDBDateTimePicker;
    chkAdjustmentOnInstock: TwwCheckBox;
    lblAdjustmentOnInstock: TLabel;
    btnHowTo: TDNMSpeedButton;
    lblChooseProducts: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure report1n2Moved(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnSelectAllProductsClick(Sender: TObject);
    procedure btnSelectAllClassesClick(Sender: TObject);
    procedure MnuEmptyAllocationAllClick(Sender: TObject);
    procedure MnuAdjustAllocationAllClick(Sender: TObject);
    procedure btnEmptyStockClick(Sender: TObject);
    procedure pnlProductListResize(Sender: TObject);
  private
    fiProductId: Integer;
    fiClassId: Integer;
    ClassListform: TBaseListingGUI;
    fProductQtyAdjobj :TProductQtyAdjObj;
    procedure ReadGuiprefs;
    procedure WriteGuiprefs;
    function ProductQtyAdjobj : TProductQtyAdjObj;
    function ProdnClassSelected(var ProductIds, ClassIds: String): Boolean;
//    procedure SetProductListSizes;
  protected
    ProductListform: TBaseListingGUI;
    procedure Resize;override;
  public
    Property ProductId :Integer read fiProductId write fiProductId;
    Property ClassId :Integer read fiClassId write fiClassId;
  end;

implementation

uses ProductListExpressForm, CommonLib, CommonFormLib, ClassExpressList,
  tcConst, AppEnvironment;

{$R *.dfm}

function TFmProductQtyAdjOptions.ProductQtyAdjobj: TProductQtyAdjObj;
begin
  if fProductQtyAdjobj = nil then fProductQtyAdjobj := TProductQtyAdjObj.Create(Self);
  Result := fProductQtyAdjobj;
end;

procedure TFmProductQtyAdjOptions.btnCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TFmProductQtyAdjOptions.btnSelectAllClassesClick(Sender: TObject);
begin
  inherited;
  ClassListform.selectall;
end;

procedure TFmProductQtyAdjOptions.btnSelectAllProductsClick(Sender: TObject);
begin
  inherited;
  ProductListform.selectall;
end;

procedure TFmProductQtyAdjOptions.btnEmptyStockClick(Sender: TObject);
var
  ProductIds, ClassIds:String;
  //Option :Word;
begin
  inherited;
  if not(ProdnclassSelected(ProductIds, ClassIds)) then exit;

(*  Option := MessageDlgxp_vISTA('Do you Wish to empty the stock Based on ''Available Qty'' or ''Instock Qty''', mtConfirmation, [], 0 , nil, '' , '', False, nil , 'Available Qty,Instock Qty,Cancel');
  if Option  = 102 then exit;*)

  if MessageDlgXP_Vista('Do you wish to Empty the ' + iif(chkAdjustmentOnInstock.checked , 'In-Stock' , 'Available')+' Quantity '+NL+
                          '   of All Selected ' + AppEnv.DefaultClass.PartColumn + '(s)  '+NL+
                          '   in All selected ' + AppEnv.DefaultClass.ClassHeading + '(s) '+NL+
                          '   as on  ' + FormatDatetime(FormatSettings.shortdateformat , cboDBStockDate.DateTime)+'?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;

  if ProductQtyAdjobj.EmptyStock(cboDBStockDate.DateTime , chkAdjustmentOnInstock.Checked,  ProductIds, ClassIds ) then
    Self.Close;

end;

procedure TFmProductQtyAdjOptions.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  inherited;
  WriteGuiprefs;
  action := caFree;
end;

procedure TFmProductQtyAdjOptions.FormCreate(Sender: TObject);
begin
  inherited;
  fiProductId:= 0;
  fiClassId:= 0;
  btnClose.caption                := 'Close';
  btnSelectAllProducts.caption    := 'Select All'+NL+'Products';
  btnSelectAllClasses.caption     := 'Select All'+NL+'Classes';
  MnuAdjustAllocationAll.caption  := 'Empty Product''s'+NL+'Bins';
  MnuEmptyAllocationAll.caption   := 'Adjust Product''s'+NL+'Bin-Batch';
  btnEmptyStock.caption           := 'Empty Product''s'+NL+'Stock';

end;

procedure TFmProductQtyAdjOptions.FormShow(Sender: TObject);
var
  lForm : TProductListExpressGUI;
begin
  inherited;
          cboDBStockDate.DateTime := Now;
          ReadGuiprefs;
          CreateHistorylistform('TProductListExpressGUI' ,Self, ProductListform , 'Parttype ="INV"');
          ProductListform.istoDoAfterallSelected := False;
          ProductListform.Parent := pnlProductList;
          ProductListform.align := alclient;
          ProductListform.BorderStyle := bsNone;
          ProductListform.fbIgnoreQuerySpeed := true;
          ProductListform.EnableMultiSelect('');
          //ProductListform.lblcustomReport.Visible := false;
          //ProductListform.cboCustomReports.Visible := false;
          try
            ProductListform.Show;
            productlistform.HeaderPanel.Height := 68;
            productlistform.Panel3.Visible := true;
            productlistform.Panel3.Top := 0;

            productlistform.grpFilters.Align := alRight;
            productlistform.grpFilters.Width := 300;
//            productlistform.lblCustomReport.Left := productlistform.btnRequery.Left + productlistform.btnRequery.Width + 5;
//            productlistform.cboCustomReports.Parent := productlistform.lblCustomReport.Parent;
//            productlistform.cboCustomReports.Visible := true;
//            productlistform.cboCustomReports.Align := alNone;
//            productlistform.cboCustomReports.Anchors := [akLeft,akTop];
//            productlistform.cboCustomReports.Width := 187;
//            productlistform.cboCustomReports.Left := productlistform.lblCustomReport.Left + productlistform.lblCustomReport.Width + 3;

            lForm := TProductListExpressGUI(productlistForm);
            lForm.btnUpdateAvgcost.Visible := false;
            lForm.btnqtyver.Visible := false;
            lform.lblFilter.Parent := lForm.Panel3;
            lForm.lblFilter.Left := 4;
            lForm.lblFilter.Caption := 'Col&umn';
            lForm.lblFilter.Width := 47;
            lform.cboFilter.Parent := lForm.Panel3;
            lForm.cboFilter.Left := lForm.lblFilter.Left + lForm.lblFilter.Width + 4;
            lForm.cboFilter.Width := 137;
            lform.lblsearchoptions.Parent := lForm.Panel3;
            lForm.lblSearchOptions.Width := 131;
            lForm.edtSearch.Parent := lForm.Panel3;
            lForm.edtSearch.Width := 137;

            lForm.edtSearch.Left := lForm.Panel3.Width - lForm.edtSearch.Width - 2;
            lform.lblsearchoptions.Left :=lForm.edtSearch.Left - 2 - lform.lblsearchoptions.width;

            lForm.pnlSearchbuttons.Parent := lForm.Panel3;
            lForm.pnlSearchbuttons.Left := lForm.edtSearch.Left - 2 - lForm.pnlSearchbuttons.Width;
          except
            FreeAndNil(ProductListform);
          end;

          CreateHistorylistform('TClassExpressListGUI' ,Self, ClassListform );
          ClassListform.istoDoAfterallSelected := False;
          ClassListform.Parent := pnlClasses;
          ClassListform.align := alclient;
          ClassListform.BorderStyle := bsNone;
          ClassListform.fbIgnoreQuerySpeed := true;
          ClassListform.EnableMultiSelect('');
          try
            ClassListform.Show;
          except
            FreeAndNil(ClassListform);
          end;
          TallerForm;

end;

Function TFmProductQtyAdjOptions.ProdnClassSelected(var ProductIds:String;var ClassIds:String):Boolean;
var
    option :Word;
begin
  REsult := False;
  if ProductListform.Qrymain.RecordCount=0 then begin
      MessageDlgXP_Vista('Product List is Empty. Please Refresh the list to have products to select', mtInformation, [mbOK], 0);
      Exit;
  end;
  if ClassListform.Qrymain.RecordCount=0 then begin
      MessageDlgXP_Vista('Department List is Empty. Please Refresh the list to have products to select', mtInformation, [mbOK], 0);
      Exit;
  end;

  ProductIds := ProductListform.SelectedIDs('PartsID' , true);
  if ProductIds = '' then begin
    Option := MessageDlgXP_vista('You haven''t Selected any product to Adjust.  Do you Wish to Adjust All products? ', mtConfirmation, [], 0 , nil, '' , '', False, nil , 'Select All, Cancel');
    if Option = 101 then exit else if Option = 100 then ProductListform.selectall;
    ProductIds := ProductListform.SelectedIDs('PartsID' , true);
    if ProductIds = '' then Exit;
  end;

  ClassIds := ClassListform.SelectedIDs('ClassID' , true);
  if ClassIds = '' then begin
    Option := MessageDlgXP_vista('You haven''t Selected any Class to Adjust.  Do you Wish to Adjust All Classs? ', mtConfirmation, [], 0 , nil, '' , '', False, nil , 'Select All, Cancel');
    if Option = 101 then exit else if Option = 100 then ClassListform.selectall;
    ClassIds := ClassListform.SelectedIDs('ClassID' , true);
    if ClassIds = '' then Exit;
  end;
  result := (ClassIds <>'') and (ProductIDs<>'');
end;
procedure TFmProductQtyAdjOptions.MnuAdjustAllocationAllClick(Sender: TObject);
var
  ProductIds, ClassIds:String;
begin
  inherited;
  if not(ProdnclassSelected(ProductIds, ClassIds)) then exit;

  if ProductQtyAdjobj.AutoAdjustBin(ProductIds, ClassIds,'',True ) then
    Self.Close;

end;

procedure TFmProductQtyAdjOptions.MnuEmptyAllocationAllClick(Sender: TObject);
var
  ProductIds, ClassIds:String;
begin
  inherited;
  if not(ProdnclassSelected(ProductIds, ClassIds)) then exit;

  if ProductQtyAdjobj.AutoAdjustBin(ProductIds, ClassIds,'',False ) then
    Self.Close;
end;

procedure TFmProductQtyAdjOptions.pnlProductListResize(Sender: TObject);
begin
  inherited;
  if not Assigned(ProductListForm) then exit;

  ProductListForm.cboCustomReports.Width := 187;

  //TProductListExpressGUI(ProductListForm).grpExtraFilters.Visible := false;

  ProductListForm.lblFilter.Left := 3;
  ProductListForm.cboFilter.Width := 188;
  ProductListForm.cboFilter.Left := ProductListForm.lblFilter.Left + ProductListForm.lblFilter.Width + 3;

  ProductListForm.lblSearchoptions.Left := ProductListForm.cboFilter.Left + ProductListForm.cboFilter.Width + 10;
  ProductListForm.edtSearch.Width := 137;
  ProductListForm.edtSearch.Left := ProductListForm.lblSearchoptions.Left +ProductListForm.lblSearchoptions.width + 3;
  ProductListForm.lblSearchMode.Left := ProductListForm.edtSearch.Left + ProductListForm.edtSearch.Width + 3;
end;

procedure TFmProductQtyAdjOptions.ReadGuiprefs;
begin
  if not (GuiPrefs.Active) then GuiPrefs.Active := True;

  if GuiPrefs.Node.Exists('Options.ClasspanelWidth') then pnlClasses.width := GuiPrefs.Node['Options.ClasspanelWidth'].asInteger;
  if GuiPrefs.Node.Exists('Options.Adjdate')         then cboDBStockDate.datetime := GuiPrefs.Node['Options.Adjdate'].asDatetime;
  if GuiPrefs.Node.Exists('Options.Instock')         then chkAdjustmentOnInstock.checked := GuiPrefs.Node['Options.Instock'].AsBoolean;

end;

procedure TFmProductQtyAdjOptions.report1n2Moved(Sender: TObject);
begin
  inherited;
  GuiPrefs.Node['Options.ClasspanelWidth'].asInteger := pnlClasses.width;
end;

procedure TFmProductQtyAdjOptions.Resize;
begin
  inherited;
end;
(*
procedure TFmProductQtyAdjOptions.SetProductListSizes;
begin

//  ProductListForm.Top := lblChooseProducts.Top + lblChooseProducts.Height + 2;
//  ProductListForm.Height := pnlProductList.Height -ProductListForm.Top - 1;
//  ProductListForm.Width := pnlProductList.Width;
//  lblChooseProducts.Left := (pnlProductList.Width - lblChooseProducts.Width) div 2;
//  if (ProductListForm.btnF5.Parent <> pnlProductList) then
//  begin
//    ProductListForm.btnF5.Parent := pnlProductList;
//    ProductListForm.btnF6.Parent := pnlProductList;
//    ProductListForm.btnF7.Parent := pnlProductList;
//  end;
//  ProductListForm.Anchors := [akLeft, akTop, akBottom, akRight];
//  ProductListForm.btnF5.Left := pnlProductList;
//  ProductListForm.btnF6.Left := pnlProductList;
//  ProductListForm.btnF7.Left := pnlProductList;

end;
*)
procedure TFmProductQtyAdjOptions.WriteGuiprefs;
begin
  GuiPrefs.Node['Options.ClasspanelWidth'].asInteger := pnlClasses.width ;
  GuiPrefs.Node['Options.Adjdate'].asDatetime := cboDBStockDate.datetime;
  GuiPrefs.Node['Options.Instock'].AsBoolean := chkAdjustmentOnInstock.checked ;
end;

initialization
  RegisterClassOnce(TFmProductQtyAdjOptions);

end.
