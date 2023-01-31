unit frmProdAttribPopulate;


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, ExtCtrls, DNMPanel, StdCtrls, wwdblook, DB, MemDS,
  DBAccess, MyAccess,ERPdbComponents, Grids, Wwdbigrd, Wwdbgrid, DNMSpeedButton, BusObjStock, busobjbase,
  ComCtrls, frmProdAttribBase ,BusObjProcess, Menus;

type
  TfmProdAttribPopulate = class(TfmProdAttribBase)
    SubForm: TDNMPanel;
    Label1: TLabel;
    cboTemplateProduct: TwwDBLookupCombo;
    qtyTemplateProducts: TERPQuery;
    DSGroupProducts: TDataSource;
    qtyTemplateProductsPartsId: TIntegerField;
    qtyTemplateProductsPartName: TWideStringField;
    grdGroupProducts: TwwDBGrid;
    QryGroupProducts: TERPQuery;
    QryGroupProductsPArtName: TWideStringField;
    QryGroupProductsPartsId: TIntegerField;
    LstProperties: TListBox;
    Label2: TLabel;
    btnCreate: TDNMSpeedButton;
    btnShowDetails: TDNMSpeedButton;
    Label3: TLabel;
    ProgressBar: TProgressBar;
    Label46: TLabel;
    chkSelectAll: TCheckBox;
    chkSekectAllProperties: TCheckBox;
    Label4: TLabel;
    lblProgressBar: TLabel;
    btncopyFromOther: TDNMSpeedButton;
    procedure cboTemplateProductCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure btnShowDetailsClick(Sender: TObject);
    procedure btnCreateClick(Sender: TObject);
    procedure grdGroupProductsKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LstPropertiesKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure chkSelectAllClick(Sender: TObject);
    procedure grdGroupProductsMultiSelectRecord(Grid: TwwDBGrid;
      Selecting: Boolean; var Accept: Boolean);
    procedure LstPropertiesKeyPress(Sender: TObject; var Key: Char);
    procedure LstPropertiesMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure chkSekectAllPropertiesClick(Sender: TObject);
    procedure grdGroupProductsMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btncopyFromOtherClick(Sender: TObject);
  private
    Product :TProduct;
    Products :TProduct;
    TemplateProductDetailXML:String;
    DetailstoBecopied :TStringList;
    ficopyFromOtherPartsID:Integer;
    Procedure updateDetails(const Sender: TBusObj; var Abort: Boolean);
    function getTransactionconnection: TERPConnection;
    function ProductSaved(PartsID:Integer):Boolean;
    function CopyDetails(const PartsID:Integer):Boolean;
    function GetProcTree(Product: TProduct): TProcTreeNode;
    procedure CopyBOM(const Sender: TBusobj; var abort: Boolean);
    procedure ShowProgressbar(const Cnt: Integer; ToShow: boolean=True);
    procedure Deletetree(const ProductID: Integer; Con: TCustomMyconnection);
    procedure beforeShowProdattribPartsList(Sender: TObject);
    procedure copyFromOther(Sender: TwwDbGrid);
  public
    procedure SetupForm;
    Function OnTabchange:Boolean;
    Property Transactionconnection :TERPConnection Read getTransactionconnection;
  end;

implementation

uses frmProdAttribMain, FastFuncs, frmPartsFrm,
  CommonLib, BaseInputForm, ProductAttributeLib, CommonDbLib, tcConst,
  CommonFormLib, ProdattribPartsList;

{$R *.dfm}

{ TProductAttributePopulateDetailsGUI }

procedure TfmProdAttribPopulate.SetupForm;
var
  fprops :TDoubleDimensionArray;
  i :Integer;
begin
  if qtyTemplateProducts.Active then qtyTemplateProducts.close;
  qtyTemplateProducts.Connection := Transactionconnection;
  qtyTemplateProducts.ParamByName('GroupID').asInteger := AttributeGroups.Id;
  qtyTemplateProducts.Open;

  if QryGroupProducts.Active then QryGroupProducts.close;
  QryGroupProducts.Connection := Transactionconnection;
  QryGroupProducts.ParamByName('GroupID').asInteger := AttributeGroups.Id;
  QryGroupProducts.Open;

  with TProduct.Create(Mainform) do try
    load(0);
    fprops := TemplateProductProps;
  finally
      free;
  end;
  if (fprops = nil) or (high(fprops) = 0) then exit;
  for i :=  low(fprops[1]) to high(fprops[1]) do
    if LstProperties.Items.IndexOf(fprops[1,i]) = -1 then LstProperties.Items.append(fprops[1,i]);
  fprops := nil;
end;

procedure TfmProdAttribPopulate.cboTemplateProductCloseUp(
  Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  QryGroupProducts.FilterSQL := 'PartsId <> ' + IntToStr(qtyTemplateProductsPartsId.asInteger);
end;

procedure TfmProdAttribPopulate.btnShowDetailsClick(Sender: TObject);
var
  form :  TBaseInputGUI;
  ProductId:Integer;
begin
  inherited;
  if cboTemplateProduct.text = '' then exit;
  if not TfmProdAttribMain(Self.Owner).ProductSaved(qtyTemplateProductsPartsId.asInteger) then begin
     if commonlib.MessageDlgXP_Vista('Do you want to Save?' , mtConfirmation , [mbyes, mbno] , 0) = mrno then
        exit;
     If not TfmProdAttribMain(Self.Owner).Save then Exit;
     if Transactionconnection.InTransaction then Transactionconnection.Commit;
  end;
  if not Transactionconnection.InTransaction then Transactionconnection.StartTransaction;
  form := TBaseInputGUI(getcomponentbyClassname('TfrmParts' , false , self));
  if assigned(Form) then begin
    form.KeyID := qtyTemplateProductsPartsID.asInteger;
    TfrmParts(Form).NewPart := True;
    form.Showmodal;
    if form.modalresult = mrOk then begin
      ProductId := qtyTemplateProductsPartsId.asInteger;
      if qtyTemplateProducts.active then qtyTemplateProducts.close;
      qtyTemplateProducts.Open;
      qtyTemplateProducts.Locate('PartsId' , ProductID , []);
      cboTemplateProduct.text := qtyTemplateProductsPartName.asString;
    end;
  end;
end;
Procedure TfmProdAttribPopulate.ShowProgressbar(const Cnt:Integer; ToShow:boolean = true);
begin
  if toshow then begin
    ProgressBar.Max :=cnt;
    ProgressBar.Position := 1;
    ProgressBar.visible := True;
    lblProgressBar.Caption := '0 of ' +IntToStr(ProgressBar.Max);
    lblProgressBar.visible := True;
    btnCreate.visible := False;
  end else begin
    ProgressBar.visible := False;
    lblProgressBar.visible := false;
    btnCreate.visible := true;
  end;
end;
procedure TfmProdAttribPopulate.btncopyFromOtherClick(Sender: TObject);
begin
  inherited;
  ficopyFromOtherPartsID:= 0;
  OpenERPListFormSingleselectModal('TProdattribPartsListGUI' ,copyFromOther , beforeShowProdattribPartsList );
  if ficopyFromOtherPartsID <> 0 then CopyDetails(ficopyFromOtherPartsID);
end;
procedure TfmProdAttribPopulate.beforeShowProdattribPartsList(Sender: TObject);
begin
   if not(Sender is TProdattribPartsListGUI) then exit;
   TProdattribPartsListGUI(Sender).groupID :=AttributeGroups.Id;
end;
procedure TfmProdAttribPopulate.copyFromOther(Sender: TwwDbGrid);
begin
  Try
    ficopyFromOtherPartsID := Sender.DataSource.DataSet.FieldByName('PartsID').AsInteger;
  Except
    // kill the exception;
  End;
end;
procedure TfmProdAttribPopulate.btnCreateClick(Sender: TObject);
begin
  if cboTemplateProduct.Text = '' then begin
    commonlib.MessageDlgXP_Vista('Select the Template Product' , mtInformation , [mbok],0);
    exit;
  end;

  if not ProductSaved(qtyTemplateProductsPartsId.asInteger) then exit;

  CopyDetails(qtyTemplateProductsPartsId.asInteger);
end;
function TfmProdAttribPopulate.CopyDetails(const PartsID:Integer):Boolean;
var
  i :Integer;
  strSQL:String;
  s:String;
  //Tree: TProcTreeNode;
  Procedure GetDetailstoBecopied;
  var
    x:Integer;
  begin
    DetailstoBecopied :=TStringList.create;
    for x := 0 to LstProperties.count-1 do
      if LstProperties.Selected[x] then
        DetailstoBecopied.add(LstProperties.items[x]);
  end;
begin
  REsult := false;
  inherited;
  {if the product is inactive and any of the sopying product got qty, the Property
  will be ignored and the rest of the information will be updated. DENE
  Warning message is not displayed as the object is in silentMode}


  if not Transactionconnection.InTransaction then Transactionconnection.StartTransaction;


  if grdGroupProducts.SelectedList.Count = 0 then
    if commonlib.MessageDlgXP_Vista('None of the Products are selected to update. Do you wish to update all products? ' , mtconfirmation , [mbyes, mbno] , 0) = mrno then
      exit
    else grdGroupProducts.SelectAll;


  if LstProperties.SelCount = 0 then begin
    if commonlib.MessageDlgXP_Vista('None of the Details are selected to copy. Do you wish to copy All? ' , mtconfirmation , [mbyes, mbno] , 0) = mrno then
      exit
    else LstProperties.SelectAll;
  end;

    strSQL:= '';
    s:= '';
    for i := grdGroupProducts.SelectedList.Count - 1 downto 0 do begin
      QryGroupProducts.GotoBookmark(grdGroupProducts.SelectedList.Items[i]);
      if UserLock.lock('tblparts' , QryGroupProductsPartsId.asInteger) then begin
        if strSQL<>'' then strSQL:= strSQL+',';
        strSQL:= strSQL+IntToStr(QryGroupProductsPartsId.asInteger);
      end else begin
        grdGroupProducts.UnselectRecord;
        if s<> '' then s:= s + NL;
        s:=s+ #9 + QryGroupProductsPArtName.AsString;
      end;
    end;
    if s<> '' then
      commonlib.MessageDlgXP_Vista('Following product(s) selected are already locked by other users / processes which cannot be updated. ' +NL+ s+ NL+NL +'These products are removed from the selection' , mtInformation , [mbok], 0);

    if strSQL = '' then begin
      commonlib.MessageDlgXP_Vista('Select the products to be updated' , mtInformation , [mbok], 0);
      exit;
    end;

    if commonlib.MessageDlgXP_Vista('Copying the selected details on the right hand side will overwrite the details within the Products selected on the left hand side. Do you wish to continue?' , mtConfirmation , [mbYes, mbno],0) = mrNo then exit;
    strSQL    := 'PartsId in (' +strSQL +')';
    Product   := TProduct.Create(Mainform);
    Products  := TProduct.Create(Mainform);
    Try
      Product.Connection := TMyDacDataConnection.create(Product);
      Products.Connection := TMyDacDataConnection.create(Products);
      Product.Connection.Connection :=Transactionconnection;
      Products.Connection.Connection :=Transactionconnection;
      Product.Load((*qtyTemplateProductsPartsId.ASInteger*)PartsID);
      if Product.count = 0 then exit;
      Products.LoadSelect(strSQL);
      if Products.count = 0 then Exit;
      try
        TemplateProductDetailXML := Product.TemplateProductDetails;

      except
          on e:Exception do begin
              showmessage(E.message);
              Exit;
          end;
      end;
      GetDetailstoBecopied;
      Products.TemplateDetailstocopy  := DetailstoBecopied;

      Products.SilentMode := True;
      Products.DoFieldChangewhenDisabled := true;
      try
          ShowProgressbar(Products.count);
          try
            Products.IterateRecords(updateDetails);
          finally
            ShowProgressbar(Products.count , False);
          end;

          ShowProgressbar(2);
          try
            if Products.IsSelectedToCopy('Pictures') then begin
               strSQL := ' insert IGNORE into tblpartspics (PartID, PartPic) ' +
                    ' select partsID , PP.PartPic ' +
                    ' from  tblpartspics   PP, tblparts P ' +
                    ' where ' +strSQL   +
                    ' and PP.PartID = ' +IntToStr(Product.ID) +
                    ' and P.PartSId not in  ' +
                    '(select PartID from    tblpartspics  PPP  ' +
                    ' where  PP.PartPic = PPP.PartPic and PPP.PartId <> ' + IntToStr(Product.ID) +' ) ' +
                    ' Order by partsID';
               Products.GetNewdataset(strSQL, true);
            end;
          finally
            ShowProgressbar(2,False);
          end;

          ShowProgressbar(Products.count);
          try
            if Products.IsSelectedToCopy('BOM') then begin
              Products.IterateRecords(CopyBOM);
            end;
          finally
            ShowProgressbar(Products.count,false);
          end;
      finally
        DetailstoBecopied:= nil;
        cboTemplateProduct.TEXT:='';
        grdGroupProducts.UnselectAll;
        for i:= 0 to LstProperties.Items.Count-1 do
          LstProperties.Selected[i] := False;
      end;
    finally
      FreeandNil(Product);
      FreeandNil(Products);
    end;
  Result:= true;
end;
function TfmProdAttribPopulate.GetProcTree(Product:TProduct): TProcTreeNode;
begin
  result:= TProductProcTree(Product.Container.ItemByClass(TProductProcTree));
end;
Procedure TfmProdAttribPopulate.CopyBOM(const Sender:TBusobj; var abort:Boolean);
var
  Tree: TProcTreeNode;
begin
  {binny :BOM handled separatly}
  if Products.isOktoSet('BOM') then begin
    Tree:= GetProcTree(Product);
    if assigned(Tree) then begin
      Deletetree(Products.ID, Products.Connection.Connection);
      Tree.ClearIds;
      Tree.PartsId := Products.Id;
      Tree.MasterID := Products.Id;
      Tree.Caption := Products.Productname;
      Tree.SaveNoCheck;
    end;
  end;
  ProgressBar.StepIt;
end;

procedure TfmProdAttribPopulate.Deletetree(const ProductID:Integer;Con :TCustomMyconnection);
var
  s:String;
  ProcTreeIds, ProctreePartIDs:String;
begin
  inherited;

  ProcTreeIds:='';
  ProctreePartIDs:='';

  with TempMyquery(TERPConnection(Con)) do try
    s:= 'SELECT `ProcTreeId` FROM `tblProcTree` WHERE mastertype = "mtProduct" and `MasterId` = ' + IntToStr(ProductID);
    ProcTreeIds:= OpennGroupconcat(s , 'ProcTreeId');
    if ProcTreeIds <> '' then begin
      s:= 'Select  ProctreePartID from `tblProctreePart`  WHERE `ProcTreeId` IN   (' + ProcTreeIds +')';
      ProctreePartIDs:= OpennGroupconcat(s, 'ProctreePartID');
    end;
    s:= '';
    if ProctreePartIDs  <> '' then  s:= s+ 'Delete from tblProctreePart  where ProctreePartID  in (' + ProctreePartIDs +');';
    if ProcTreeIds      <> '' then  s:= s+ 'Delete from tblproctree      where ProctreeId  in (' + ProcTreeIds +');';
    if s<>'' then  begin
      if active then close;
      SQL.Clear;
      SQL.Add(s);
      Execute;
    end;
  finally
    if Active then close;
    Free;
  end;
end;

procedure TfmProdAttribPopulate.updateDetails(const Sender: TBusObj; var Abort: Boolean);
begin
  ProgressBar.StepIt;
  lblProgressBar.Caption := IntToStr(ProgressBar.position )+ ' of ' +IntToStr(ProgressBar.Max);
  lblProgressBar.Refresh;
  TProduct(Sender).TemplateProductDetails := TemplateProductDetailXML;
  TProduct(Sender).PostDB;
  {product will not show the messages as its in silent mode.
  so any validation messges will be displayed}
  if (TProduct(Sender).ResultStatus.HasError) or (TProduct(Sender).ResultStatus.HasWarning) then
      MessageDlgXP_Vista(TProduct(Sender).ResultStatus.Messages, mtInformation , [mbok], 0);
  TProduct(Sender).ContainerList.Clear;
  TProduct(Sender).ResultStatus.Clear;

end;
function TfmProdAttribPopulate.getTransactionconnection: TERPConnection;
begin
  REsult := TfmProdAttribMain(Self.Owner).MyConnection;
end;

function TfmProdAttribPopulate.ProductSaved(PartsID: Integer): Boolean;
begin
  result := False;
  if not TfmProdAttribMain(Self.Owner).ProductSaved((*qtyTemplateProductsPartsId.asInteger*)PartsID) then begin
     if commonlib.MessageDlgXP_Vista('Do you want to Save?' , mtConfirmation , [mbyes, mbno] , 0) = mrno then
        exit;
     If not TfmProdAttribMain(Self.Owner).Save then Exit;
     if Transactionconnection.InTransaction then Transactionconnection.Commit;
  end;
  REsult := True;
end;

procedure TfmProdAttribPopulate.grdGroupProductsKeyUp(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if ((Shift = [ssCtrl]) and ((Chr(Key)='A') or (Chr(Key)='a'))) then
      grdGroupProducts.SelectAll
  else MultiSelectRecord(Sender,grdGroupProducts , chkSelectAll );
end;

procedure TfmProdAttribPopulate.LstPropertiesKeyUp(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if ((Shift = [ssCtrl]) and ((Chr(Key)='A') or (Chr(Key)='a'))) then
      LstProperties.SelectAll;
  chkSekectAllProperties.Checked :=LstProperties.Count = LstProperties.SelCount;
end;

Function TfmProdAttribPopulate.OnTabchange:Boolean;
var
  Msgoption:word;
begin
  IF cboTemplateProduct.TEXT <> '' then
    if (grdGroupProducts.Selected.Count <> 0) or (LstProperties.SelCount<> 0) then begin
      Msgoption:= CommonLib.MessageDlgXP_Vista('You haven''t copied the details.'+
                                      (*chr(13) +'Please select the "Copy Details" option to copy.'+*)
                                      chr(13) +chr(13) +'Do you wish to  "Copy Details" before change ?' , mtconfirmation, [mbyes, mbNo, mbCancel], 0);
      if Msgoption = mrCancel then begin
         REsult := false;
         Exit;
      end else if Msgoption = mrYes then begin
        if not CopyDetails(qtyTemplateProductsPartsId.asInteger) then begin
         REsult := false;
         Exit;
        end;
      end;
    end;
  Result := True;
end;

procedure TfmProdAttribPopulate.chkSelectAllClick(Sender: TObject);
begin
  inherited;
  if screen.activecontrol <> sender then exit;
  MultiSelectRecord(chkSelectAll,grdGroupProducts , chkSelectAll );
end;

procedure TfmProdAttribPopulate.grdGroupProductsMultiSelectRecord(
  Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  MultiSelectRecord(Grid,grdGroupProducts , chkSelectAll );
end;

procedure TfmProdAttribPopulate.LstPropertiesKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  chkSekectAllProperties.Checked := LstProperties.SelCount> 0;
end;

procedure TfmProdAttribPopulate.LstPropertiesMouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,Y: Integer);
begin
  inherited;
  chkSekectAllProperties.Checked :=LstProperties.Count = LstProperties.SelCount;
end;

procedure TfmProdAttribPopulate.chkSekectAllPropertiesClick(Sender: TObject);
var
  i:Integer;
begin
  inherited;
  for i:= 0 to LstProperties.Items.Count-1 do
      LstProperties.Selected[i] :=chkSekectAllProperties.Checked ;
end;

procedure TfmProdAttribPopulate.grdGroupProductsMouseUp(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  MultiSelectRecord(Sender,grdGroupProducts , chkSelectAll );
end;


end.


