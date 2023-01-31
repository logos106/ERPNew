unit frmProdAttribMain;

interface

uses
  Windows, BaseInputForm, DB, MemDS, DBAccess, MyAccess,ERPdbComponents, GradientLabel,
  Forms, ComCtrls, DNMPanel, StdCtrls, ExtCtrls, Shader, Controls,
  DNMSpeedButton, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  Graphics, Classes,Contnrs,SysUtils,wwcheckbox,BusObjBase,
  BusobjProdAttribGroup,BusobjAttribProduct,frmProdAttribSetUp,
  frmProdAttribProducts, frmProdAttribCreateProducts, frmProdAttribPopulate,
  frmProdAttribmatrix, ImgList,frmProdAttribImportCostnPrice, ProgressDialog, frmProdAttribCustomfields;

const
  tiSetUp           =1;
  tiCreateProducts  =2;
  tiLinkedProducts  =3;
  tiPopulateDetails =4;
  tiInStockreport   =5;
  tiImportCostnPrice=6;
  tiCustomFields    =7;
  
type


  TfmProdAttribMain = class(TBaseInputGUI)
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Bevel1: TBevel;
    Shader1: TShader;
    pnlActiveForm: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel1: TDNMPanel;
    Tabs: TPageControl;
    tabSetup: TTabSheet;
    btnNew: TDNMSpeedButton;
    Panel1: TPanel;
    sbButtons: TScrollBox;
    pnlButtons: TDNMPanel;
    tabProducts: TTabSheet;
    tabCreate: TTabSheet;
    qryDynButtons: TERPQuery;
    qryDynButtonsID: TIntegerField;
    qryDynButtonsButtonName: TWideStringField;
    tabPopulateDetails: TTabSheet;
    btnNext: TDNMSpeedButton;
    btnPrevious: TDNMSpeedButton;
    tabInStockReport: TTabSheet;
    tabImportCostnPrice: TTabSheet;
    btncopy: TDNMSpeedButton;
    ProgressBar: TProgressBar;
    DNMSpeedButton1: TDNMSpeedButton;
    TabCustomFields: TTabSheet;
    pnlChooseRpt: TDNMPanel;
    lblChooseRpt: TLabel;
    chkChooseRpt: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject); 
    procedure btnNewClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure NavigateActions(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btncopyClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
  private
    ActiveTabButton: TDNMSpeedButton;
    MainbuttonList: TComponentList;
    mainbuttonindex :Integer;
    ButtonCtr:Integer;
    procedure AddTabButtons;
    function AddButton(const ButtonCaption: string;
                        const ButtonTop: Integer;
                        const ParentPanel: TDNMPanel;
                        const OnClickEvent: TNotifyEvent;
                        Const ButtonColor: TColor = clWhite):TDNMSpeedButton;
    procedure MainButtonClick(Sender: TObject);
    procedure New;
    procedure Load;
    Procedure Startup;
    Procedure OnTabChange;
    function ButtonCaption(Const Index :Integer):String;
    function getAttributeProducts: TProductAttributes;
    Procedure updatecompanyPref;
    Function SaveAttributes:boolean;
    procedure HideTabs(const TabToshow:Integer =0);
    Procedure PrintMatrix;
    Procedure ReadGuiprefs;
    Procedure SaveGuiprefs;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    Function GetReportTypeID:Integer; override;
    procedure CustomFieldsRefresh;Override;

  public

    BusobjLoading           : Boolean;
    AttributeGroups         : TProdAttribGroups;

    ProductAttributeSetup   : TfmProdAttribSetUp;
    ProductAttributeProducts: TfmProdAttribProducts;
    ProductAttributeCreate  : TfmProdAttribCreateProducts;
    ProductAttributePopulate: TfmProdAttribPopulate;
    ProductAttributeMatrix  : TfmProdAttribmatrix;
    ProductAttributeImport  : TfmProdAttribImportCostnPrice;
    ProdAttribCustomfields  : TfmProdAttribCustomfields;
    Procedure AfterTranslate; Override;
    function ProductSaved(PartsID:Integer):Boolean;
    function  Save :Boolean;
    Function ValidateData :boolean ;
    Property AttributeProducts       : TProductAttributes read getAttributeProducts;
    Procedure EnableProgressbar(visible :Boolean; Max :Integer);
    Procedure StepProgress;
    Procedure OpenCustomFields; Override;
  published

  end;

implementation

uses
  FastFuncs, CommonDbLib, CommonLib, BusObjConst, ProductAttributeLib, Dialogs,
  FormFactory,  BaseFormForm, Preferences, AppEnvironment, PreferenceLib, tcDataUtils, AppEnvVirtualObj, MatrixObj;
const
  cTabCount                   = 7;
  cButtonCaptions: array[1..cTabCount] of string = ('1.Setup',
                                                    '2.Create Products ',
                                                    '3.Linked Products ',
                                                    '4.Populate Details',
                                                    '5.In-Stock Report',
                                                    '6.Import Values',
                                                    '7.Custom Fields');

{$R *.dfm}


procedure TfmProdAttribMain.AddTabButtons;
var
  ButtonTop: Integer;
  ButtonIndex: Integer;
  TabButton: TDNMSpeedButton;
begin
  ButtonTop := cButtonTopStart;
  for ButtonIndex := 1 to cTabCount do begin
      TabButton := AddButton(cButtonCaptions[ButtonIndex], ButtonTop,pnlButtons,MainButtonClick);
      MainbuttonList.Add(TabButton);
      If (ButtonIndex=1) AND not Assigned(ActiveTabButton) then
        ActiveTabButton := TabButton;
      ButtonTop := ButtonTop + cButtonHeight + cButtonGap;
  end;
  sbButtons.AutoScroll:=false;
  if buttontop  > pnlButtons.Height  then pnlButtons.Height := buttontop ;
  sbButtons.AutoScroll:=pnlButtons.Height > sbButtons.Height;
end;

procedure TfmProdAttribMain.AfterTranslate;
begin
  inherited;
  if assigned(ActiveTabbutton) then
    if ActiveTabbutton is TDNMSpeedButton then
      pnlActiveForm.caption := TDNMSpeedButton(ActiveTabbutton).caption;

end;

Function TfmProdAttribMain.AddButton(const ButtonCaption: string; const ButtonTop: Integer; Const ParentPanel: TDNMPanel;Const OnClickEvent: TNotifyEvent; Const ButtonColor: TColor = clWhite):TDNMSpeedButton;
begin
  inc(Buttonctr);
  REsult := ProductAttributeLib.AddButton(Self, ButtonCaption , buttontop ,cButtonLeft, cButtonWidth ,  cButtonHeight , ParentPanel , OnClickEvent, buttonctr, ButtonColor );
end;
Procedure TfmProdAttribMain.HideTabs(const TabToshow:Integer =0);
var
  ButtonIndex:Integer;
begin
    for ButtonIndex := Tabs.PageCount-1 downto 0 do
      TTabsheet(Tabs.pages[ButtonIndex]).Tabvisible := False;
    if TabToshow >=0 then begin
      Tabs.ActivePageIndex :=TabToshow;
      TTabsheet(Tabs.pages[TabToshow]).Tabvisible := False;
    end;
end;

procedure TfmProdAttribMain.FormCreate(Sender: TObject);
begin
  inherited;
  HideTabs(0);
  ButtonCtr:=0;
  BusobjLoading := False;
  ActiveTabButton := nil;
  MainbuttonList:= TComponentList.Create;
  pnlButtons.Color := TabColor;
(*  Shader1.FromColor := GetGradientColor(Self.ClassName).Color;
  Shader1.ToColorMirror := Shader1.FromColor;*)
  AddTabButtons;

  ProductAttributeMatrix                  := TfmProdAttribmatrix.create(Self);
  ProductAttributeMatrix.Subform.Parent   := tabInStockReport;

  ProductAttributeImport                  := TfmProdAttribImportCostnPrice.Create(Self);
  ProductAttributeImport.Subform.Parent   := tabImportCostnPrice;

  ProdAttribCustomfields                  := TfmProdAttribCustomfields.Create(Self);
  ProdAttribCustomfields.Subform.Parent   := TabCustomFields;


  ProductAttributeSetup                   := TfmProdAttribSetUp.Create(Self);
  ProductAttributeSetup.SubForm.Parent    := tabSetup;

  ProductAttributeProducts                := TfmProdAttribProducts.Create(Self);
  ProductAttributeProducts.SubForm.Parent := tabProducts;

  ProductAttributeCreate                  := TfmProdAttribCreateProducts.Create(Self);
  ProductAttributeCreate.SubForm.Parent   := tabCreate;

  ProductAttributePopulate                := TfmProdAttribPopulate.Create(Self);
  ProductAttributePopulate.SubForm.Parent := tabPopulateDetails;



  AttributeGroups                         := TProdAttribGroups.Create(Self);
  AttributeGroups.connection              := TMyDacDataconnection.Create(AttributeGroups);
  AttributeGroups.Connection.connection   := Myconnection;
  AttributeGroups.BusObjEvent             := DoBusinessObjectEvent;
  AttributeGroups.Progressbar             := Self.Progressbar;

end;

procedure TfmProdAttribMain.DNMSpeedButton1Click(Sender: TObject);
var
  sSQL:String;
begin
  inherited;
  if not SaveAttributes then exit;
    if REportToPrint = '' then
        if chkChooseRpt.Checked then begin
          LoadReportTypes;
          if dlgReportSelect.Execute =False then exit;
          ReportToPrint := dlgReportSelect.SelectedItems.Text;
        end;

    if REportToPrint = '' then ReportToPrint := tcdatautils.GetDefaultReport(GetReportTypeID);
    if REportToPrint = '' then Exit;
    if Assigned(StrPos(PChar(REportToPrint), PChar('(Matrix'))) then begin
      PrintMatrix;
      Exit;
    end;

  //if ReportToPrint = '' then ReportToPrint := 'Attribute Products';
  sSQL :='~|||~where PAG.PAG_ID=' + inttostr(AttributeGroups.ID) +
         '~|||~where PAG.PAG_ID=' + inttostr(AttributeGroups.ID) +' order by Partname' +
         '~|||~Where PAG.pag_ID=' + inttostr(AttributeGroups.ID) +' order by if(PAG.XAxisAttribute=PAN.PAN_ID , 1, if(PAG.YAxisAttribute=PAN.PAN_ID , 2, 3)) , name ';
  fbReportSQLSupplied := False;
  PrintTemplateReport(ReporttoPrint, sSql, not(Appenv.Employee.ShowPreview) , 1);
  Self.Close;
end;

procedure TfmProdAttribMain.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
    inherited;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TProdAttribGroups then
          TProdAttribGroups(Sender).Dataset       := ProductAttributeSetup.qrygroups
        else if Sender is TProdAtribName then
          TProdAtribName(Sender).Dataset        := ProductAttributeSetup.qrynames
        else if Sender is TProdAtribValue then
          TProdAtribValue(Sender).Dataset       := ProductAttributeSetup.qryvalues
        else if Sender is TProductAttributes then
          TProductAttributes(Sender).Dataset      := ProductAttributeProducts.qryAttribProducts;
    end;
end;


procedure TfmProdAttribMain.FormDestroy(Sender: TObject);
begin
  While MainbuttonList.Count <> 0 do
    MainbuttonList.Items[0].Free;
  FreeAndNil(MainbuttonList);

  ProductAttributeSetup.SubForm.Parent    := ProductAttributeSetup;
  ProductAttributeProducts.SubForm.Parent := ProductAttributeProducts;
  ProductAttributeCreate.SubForm.Parent   := ProductAttributeCreate;
  ProductAttributePopulate.SubForm.Parent := ProductAttributePopulate;
  ProductAttributeMatrix.Subform.Parent   := ProductAttributeMatrix;
  ProductAttributeImport.subForm.Parent   := ProductAttributeMatrix;
  ProdAttribCustomfields.subForm.Parent   := ProdAttribCustomfields;

  FreeAndNil(ProductAttributeSetup);
  FreeAndNil(ProductAttributeProducts);
  FreeAndNil(ProductAttributeCreate);
  FreeAndNil(ProductAttributePopulate);
  FreeAndNil(ProductAttributeMatrix);
  FreeandNil(ProductAttributeImport);
  FreeandNil(ProdAttribCustomfields);
  inherited;
end;

procedure TfmProdAttribMain.btnCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfmProdAttribMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  SaveGuiprefs;
  (*if MyConnection.InTransaction then
    MyConnection.Rollback;*)
  AttributeGroups.Userlock.Unlock(PRODATTRIGROUP);
  AttributeGroups.connection.RollbackTransaction;
  Action := cafree;

end;

procedure TfmProdAttribMain.MainButtonClick(Sender: TObject);
begin
ProcessingCursor(true);
try
  if Sender is TDNMSpeedButton then begin
    if not Sysutils.SameText(TDNMSpeedButton(Sender).Caption, pnlActiveForm.Caption) then begin
      if (fsShowing in Self.FormState) or (fsCreating in Self.FormState) then else
        If Assigned(ActiveTabButton) then Begin
          If Sysutils.SameText(ActiveTabButton.Caption,cButtonCaptions[tiSetUp]) then begin if not(ProductAttributeSetup.OnTabchange) then exit;
          end else If Sysutils.SameText(ActiveTabButton.Caption,cButtonCaptions[tiCreateProducts]) and
            (not Sysutils.SameText(EnglishCaption(TDNMSpeedButton(Sender)),cButtonCaptions[tiSetUp])) then begin if not( ProductAttributeCreate.OnTabchange) then exit;
          end else If Sysutils.SameText(ActiveTabButton.Caption,cButtonCaptions[tiLinkedProducts])    then begin if not(ProductAttributeProducts.OnTabchange) then exit;
          end else If Sysutils.SameText(ActiveTabButton.Caption,cButtonCaptions[tiPopulateDetails])   then begin if not(ProductAttributePopulate.OnTabchange) then exit;
          end else If Sysutils.SameText(ActiveTabButton.Caption,cButtonCaptions[tiInStockreport])     then begin if not(ProductAttributeMatrix.OnTabchange) then exit;
          end else if Sysutils.SameText(ActiveTabbutton.Caption,cButtonCaptions[tiImportCostnPrice])  then begin if not(ProductAttributeImport.Ontabchange) then Exit;
          end else if Sysutils.SameText(ActiveTabbutton.Caption,cButtonCaptions[tiCustomFields])      then begin if not(ProdAttribCustomfields.Ontabchange) then Exit;
          end;

          ActiveTabButton.Color := clWhite;
          ActiveTabButton.LightColor := cButtonLightColor;
          ActiveTabButton.ShadowColor := cButtonShadowColor;
          ActiveTabButton.HotTrackColor := cButtonHotTrackColor;
        end;
      ActiveTabButton := TDNMSpeedButton(Sender);
      ActiveTabButton.Color := cSelectedButtonColor;
      ActiveTabButton.LightColor := cSelectedButtonLightColor;
      ActiveTabButton.ShadowColor := cSelectedButtonShadowColor;
      ActiveTabButton.HotTrackColor := cSelectedButtonHotTrackColor;
      // Change Tabs
      If Sysutils.SameText(EnglishCaption(TDNMSpeedButton(Sender)),cButtonCaptions[tiSetUp]) then Begin
          Tabs.ActivePage := tabSetup;
            pnlActiveForm.Caption := ButtonCaption(tiSetUp);

          ProductAttributeSetup.SetupGrid;
          ProductAttributeSetup.SubForm.Invalidate;
          mainbuttonindex := tiSetUp;
      end;
      If Sysutils.SameText(EnglishCaption(TDNMSpeedButton(Sender)),cButtonCaptions[tiCreateProducts]) then Begin
          Tabs.ActivePage := tabCreate;
          PnlActiveForm.Caption := ButtonCaption(tiCreateProducts);
          ProductAttributeCreate.SetupGrid;
          ProductAttributeCreate.SubForm.Invalidate;
          mainbuttonindex := tiCreateProducts;
      end;
      If Sysutils.SameText(EnglishCaption(TDNMSpeedButton(Sender)),cButtonCaptions[tiLinkedProducts]) then Begin
          Tabs.ActivePage := tabProducts;
          pnlActiveForm.Caption := ButtonCaption(tiLinkedProducts);
          ProductAttributeProducts.SetupGrid;
          ProductAttributeProducts.SubForm.Invalidate;
          mainbuttonindex := tiLinkedProducts;
      end;

      If Sysutils.SameText(EnglishCaption(TDNMSpeedButton(Sender)),cButtonCaptions[tiPopulateDetails]) then Begin
          Tabs.ActivePage := tabPopulateDetails;
          pnlActiveForm.Caption := ButtonCaption(tiPopulateDetails);
          ProductAttributePopulate.SetupForm;
          ProductAttributePopulate.SubForm.Invalidate;
          mainbuttonindex := tiPopulateDetails;
      end;
      If Sysutils.SameText(EnglishCaption(TDNMSpeedButton(Sender)),cButtonCaptions[tiInStockreport]) then Begin
          if AttributeGroups.dirty then begin
            if MessageDlgXP_Vista('The changes will be saved before producing the ''InStock Report''. Do you wish to continue?' , mtconfirmation , [mbyes, mbno] , 0) = mrno then exit;
            if not SaveAttributes then Exit;
          end;
          if not MyConnection.InTransaction then MyConnection.StartTransaction;
          Tabs.ActivePage := tabInStockReport;
          pnlActiveForm.Caption := ButtonCaption(tiInStockreport);
          ProductAttributeMatrix.AttribGroupID := AttributeGroups.ID;
          ProductAttributeMatrix.SetupGrid;
          ProductAttributeMatrix.SubForm.Invalidate;
          mainbuttonindex := tiInStockreport;
      end;
      If Sysutils.SameText(EnglishCaption(TDNMSpeedButton(Sender)),cButtonCaptions[tiImportCostnPrice]) then Begin
          if AttributeGroups.dirty then begin
            if MessageDlgXP_Vista('The changes will be saved before producing the ''InStock Report''. Do you wish to continue?' , mtconfirmation , [mbyes, mbno] , 0) = mrno then exit;
            if not SaveAttributes then Exit;
          end;
          if not MyConnection.InTransaction then MyConnection.StartTransaction;
          Tabs.ActivePage := tabImportCostnPrice;
          pnlActiveForm.Caption := ButtonCaption(tiImportCostnPrice);
          ProductAttributeImport.AttribGroupID := AttributeGroups.ID;
          ProductAttributeImport.SetupGrid;
          ProductAttributeImport.SubForm.Invalidate;
          mainbuttonindex := tiImportCostnPrice;
      end;

      If Sysutils.SameText(EnglishCaption(TDNMSpeedButton(Sender)),cButtonCaptions[tiCustomFields]) then Begin
          Tabs.ActivePage := TabCustomFields;
          pnlActiveForm.Caption := ButtonCaption(tiCustomFields);
          ProdAttribCustomfields.SetupForm;
          ProdAttribCustomfields.SubForm.Invalidate;
          mainbuttonindex := tiCustomFields;
      end;


   end;
  end;
  if (fsShowing in Self.FormState) or (fsCreating in Self.FormState) then else OnTabChange;
finally
    ProcessingCursor(False);
end;
end;


procedure TfmProdAttribMain.FormShow(Sender: TObject);
begin
  DisableForm;
  (*ProcessingCursor(True);*)
  try
    inherited;
    mainbuttonindex := tiSetUp;
    ProductAttributeCreate.FormShow(nil);
    ProductAttributeProducts.FormShow(nil);
    ProductAttributeSetup.FormShow(nil);
    MainButtonClick(ActiveTabButton);
    (*if not MyConnection.InTransaction then
      MyConnection.StartTransaction;*)
    AttributeGroups.connection.BeginTransaction;
    Startup;
    CustomFieldsRefresh;
    ReadGuiprefs;
  finally
    EnableForm;
    (*ProcessingCursor(False);*)
  end;  
end;

procedure TfmProdAttribMain.btnNewClick(Sender: TObject);
begin
  inherited;
  New;
end;

procedure TfmProdAttribMain.btnSaveClick(Sender: TObject);
begin
  inherited;
  if not SaveAttributes then exit;
  Self.Close;
end;

procedure TfmProdAttribMain.New;
begin
  MainButtonClick(ActiveTabButton);
  if not SaveAttributes then exit;
  AttributeGroups.AttributeNames.ProductAttributeValues.close;
  AttributeGroups.AttributeNames.close;
  if not MyConnection.InTransaction then MyConnection.StartTransaction;
  AttributeGroups.New;
  MainButtonClick(MainbuttonList[0]);
  AttributeGroups.PostDB;
  AttributeGroups.AttributeNames.ProductAttributeValues;
  ProductAttributeProducts.SetupGrid;
  ProductAttributeCreate.SetupGrid;
end;
procedure TfmProdAttribMain.Load;
begin
  BusobjLoading := True;
  Try
    AttributeGroups.Load(KeyID);
    AttributeGroups.AttributeNames.ProductAttributeValues;

    if keyId = 0 then AttributeGroups.New;

    if NOT AttributeGroups.Lock then begin
        AccessLevel := 5; // read only
        CommonLib.MessageDlgXP_Vista(AttributeGroups.UserLock.LockMessage + #13 + #10 + #13 + #10 +
                  ' Access will be changed to read-only.', mtWarning, [mbOK], 0);
    end;
    if accesslevel =2 then
      if keyId =0 then AccessLevel := 1;

    ProductAttributeProducts.AccessLevel:= Self.AccessLevel;
    ProductAttributeCreate.AccessLevel  := Self.AccessLevel;
    ProductAttributePopulate.AccessLevel:= Self.AccessLevel;
    ProductAttributeSetup.AccessLevel   := Self.AccessLevel;

  (*  ProductAttributeProducts.SetupGrid;
    ProductAttributeCreate.SetupGrid;
    ProductAttributePopulate.SetupForm;*)

    ProductAttributeMatrix.AttribGroupID := AttributeGroups.ID;
(*    ProductAttributeMatrix.SetUpGrid;*)
  finally
    BusobjLoading := False;
  end;
  AttributeGroups.AttributeNames.ProductAttributeValues;
end;
function TfmProdAttribMain.ValidateData: boolean;
begin
  Result := False;
  if  not(AttributeGroups.Validatedata) then exit;
  Result := True;
end;
function TfmProdAttribMain.Save :Boolean;
begin
  REsult := False;
  {skip Save the first time }
  EnableProgressbar(true, 4);
  try
    if AttributeGroups.dirty then begin
      if not ValidateData then exit;
      StepProgress;
      If not AttributeGroups.Save then Exit;
      StepProgress;
      ProductAttributeProducts.SaveGrid;
      StepProgress;
      If not AttributeProducts.Save then Exit;
      StepProgress;
    end;
  finally
    AttributeGroups.ResultStatus.Clear;
    AttributeProducts.ResultStatus.Clear;
      EnableProgressbar(False, 0);
  end;
  Result := True;
end;

procedure TfmProdAttribMain.PrintMatrix;
var
  strSQL:String;
begin
  inherited;
      if REportToPrint = '' then exit;
      with TMatrixsale.Create(Self) do try
        MakeMatrixTable(Assigned(StrPos(PChar(REportToPrint), PChar('(Matrix-Y)'))));
        fbReportSQLSupplied := True;
        strSQL :=  MatrixReportSQL;
        PrintTemplateReport(REportToPrint, strSQL, False, 1);
      finally
        free;
      end;
end;

function TfmProdAttribMain.ProductSaved(
  PartsID: Integer): Boolean;
begin
  with CommonDbLib.TempMyQuery do try
    SQL.add('select partsId from tblParts where partsId = ' + IntToStr(PartsID));
    open;
    result := recordcount > 0;
  finally
      if active then close;
      free;
  end;
end;

procedure TfmProdAttribMain.ReadGuiprefs;
begin
  ActivateGuiPrefs(True);
  if GuiPrefs.Node.Exists('Options.Choosereport') then
    ChkChooseRpt.checked := GuiPrefs.Node['Options.Choosereport'].AsBoolean;
end;

procedure TfmProdAttribMain.Startup;
begin
  Load;
  if AttributeGroups.count = 0 then begin
    if Tabs.ActivePage <> tabSetup then  Tabs.ActivePage := tabSetup;
    SetControlFocus(ProductAttributeSetup.edtTitle);
    mainbuttonindex := tiSetUp;
    ProductAttributeSetup.SetupGrid;
  end;
  OnTabChange;
end;
procedure TfmProdAttribMain.NavigateActions(Sender: TObject);
begin
  inherited;
  if (Sender = btnPrevious) and (mainbuttonindex = 2) then begin
    ProductAttributeCreate.ClearSelection;
  end;

  if (Sender = btnPrevious) and (mainbuttonindex > 1) then  MainButtonClick(MainbuttonList[mainbuttonindex - 2])
  else if (Sender = btnNext) and (mainbuttonindex < MainbuttonList.Count) then MainButtonClick(MainbuttonList[mainbuttonindex]);

end;

procedure TfmProdAttribMain.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if AttributeGroups.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if Save then begin
            if MyConnection.InTransaction then MyConnection.Commit;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          if MyConnection.InTransaction then MyConnection.Rollback;
          AttributeGroups.Dirty := false;
          CanClose := true;
        end;
      mrCancel: 
        begin
          CanClose := false;
        end;
    end;
  end else begin
    CanClose := true;
  end;

end;

procedure TfmProdAttribMain.OnTabChange;
begin
    btnNext.enabled := mainbuttonindex <MainbuttonList.count ;
    btnPrevious.enabled := mainbuttonindex >1;
end;

procedure TfmProdAttribMain.OpenCustomFields;
begin
  inherited;
end;

function TfmProdAttribMain.ButtonCaption(const Index: Integer): String;
begin
  REsult := cButtonCaptions[index];
  result := StringReplace(REsult , '1.' , '' , []);
  result := StringReplace(REsult , '2.' , '' , []);
  result := StringReplace(REsult , '3.' , '' , []);
  result := StringReplace(REsult , '4.' , '' , []);
  result := StringReplace(REsult , '5.' , '' , []);
  result := StringReplace(REsult , '6.' , '' , []);
  result := StringReplace(REsult , '7.' , '' , []);
end;

procedure TfmProdAttribMain.CustomFieldsRefresh;
begin
  CustomFieldRefresh('CFProduct' ,ProdAttribCustomfields.pnlCustFields , ProdAttribCustomfields);
end;

function TfmProdAttribMain.getAttributeProducts: TProductAttributes;
begin
  REsult := AttributeGroups.AttributeProducts;
end;

function TfmProdAttribMain.GetReportTypeID: Integer;
begin
   result:= TemplateTypeID('Product Attribute');
end;

procedure TfmProdAttribMain.btncopyClick(Sender: TObject);
begin
  if not Save then exit;
  if MyConnection.InTransaction then MyConnection.Commit;
  if not MyConnection.InTransaction then    MyConnection.StartTransaction;
  if AttributeGroups.CloneBusObj('GroupName' ,AttributeGroups.GroupNAmeForthecopy , False) <> nil then begin
    KeyID := AttributeGroups.ObjInstanceToClone.ID;
    AttributeGroups.ObjInstanceToClone := nil;
    Load;
    Startup;
    AttributeGroups.dirty := TRue;
  end;
end;

procedure TfmProdAttribMain.updatecompanyPref;
var
  strSQL:String;
  option :Word;
  (* form :TComponent; *)
begin
  if (AttributeGroups.CleanId=0) and (not(Appenv.CompanyPrefs.ShowProductAttributes)) then begin
    strSQL:= 'SELECT * FROM tblproductattributegroups  where active = "T"';
    with AttributeGroups.getNewDataset(strSQL, true) do try
      if recordcount = 1 then begin
        option :=  MessageDlgXP_Vista('The attributes are not enabled.' +chr(13)+chr(13)+
                              'Do you wish to Enable the Attributes and ' +chr(13)+'Set ' + IntToStr(AttributeGroups.AttributeNames.count)+
                              ' to ''No of Attributes to be displayed'' ' +chr(13)+
                              '                           OR'+chr(13)+ 'Open the Preference form?',mtconfirmation, [mbYes, mbNo], 0, nil , '','', False, nil, 'Open Preference Form');
        if Option = mrYes then begin
          strSQL:= 'update tbldbpreferences Set FieldValue = ''T'' where Name = ''ShowProductAttributes'';' +
              'update tbldbpreferences Set FieldValue = ' + IntToStr(AttributeGroups.AttributeNames.count)+ ' where Name = ''NoOfAttribstodisplay'';' ;
          AttributeGroups.getNewDataset(strSQL, False);
          Appenv.CompanyPrefs.PopulateMe;
        end else if Option = 100 then begin
          (* Form := GetComponentByClassName('TPreferencesGUI');
          try
            if (Assigned(Form)) and (TPreferencesGUI(Form).AccessLevel<= 1) then begin //if has acess
                with TPreferencesGUI(Form) do begin
                  SingleButtonCaption := 'Inventory';
                  TextSearch          := 'Enable Attributes';
                  FocusControlName    := 'chkEnableAttributes';
                  FormStyle           := fsNormal;
                  Position            := poScreenCenter;
                  ShowModal;
                end;
            end else MessageDlgXP_Vista('You don''t have enough permission to change the Preferences.',mtWarning, [mbok], 0)
          finally
              FreeandNil(Form);
          end; *)
          OpenPrefform('Inventory' ,  'chkEnableAttributes', 0 , True , 'Enable Attributes');
        end;
        end;
    finally
        if Active then close;
        Free;
    end;
  end;

end;

Function TfmProdAttribMain.SaveAttributes:boolean ;
begin
  result := False;
  if not Save then exit;
  updatecompanyPref;
  if MyConnection.InTransaction then MyConnection.Commit;
  AttributeGroups.dirty := False;
  REsult := True;
end;

procedure TfmProdAttribMain.SaveGuiprefs;
begin
  GuiPrefs.Node['Options.Choosereport'].AsBoolean := ChkChooseRpt.checked;
end;

procedure TfmProdAttribMain.EnableProgressbar(visible: Boolean;
  Max: Integer);
begin
  if visible then begin
    Progressbar.Min := 1;
    Progressbar.Max := Max+1;
    Progressbar.Position := 1;
    Progressbar.step:= 1;
    Progressbar.visible := true;
  end else Progressbar.visible := False;
end;

procedure TfmProdAttribMain.StepProgress;
begin
  Progressbar.StepIt;
  if Progressbar.position > Progressbar.max then Progressbar.position := Progressbar.max;
end;

initialization
  RegisterClassOnce(TfmProdAttribMain);
with FormFact do
  begin
    RegisterMe(TfmProdAttribMain, 'TProdAttribGroupsGUI_*=PAG_ID');
  end;
end.


















