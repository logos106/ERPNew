unit frmEquip;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  StdCtrls, Shader, DNMPanel, DBCtrls, wwcheckbox, DNMSpeedButton, ComCtrls,
  BusObjEquipment, BusObjBase, Mask, wwdbedit, wwdblook, Grids, Wwdbigrd,
  Wwdbgrid, wwSpeedButton, wwDBNavigator, wwclearpanel, Busobjcustomfields,
  frmAttachments, ProgressDialog, {frmHirePricing,} pngimage, ERPDbLookupCombo,
  Wwdbspin, wwradiogroup, wwclearbuttongroup;

type
  TfmEquip = class(TBaseInputGUI)
    qryEquipment: TERPQuery;
    qryEquipmentGlobalRef: TWideStringField;
    qryEquipmentEquipmentID: TIntegerField;
    qryEquipmentEquipmentName: TWideStringField;
    qryEquipmentEquipmentDescription: TWideStringField;
    qryEquipmentEditedFlag: TWideStringField;
    qryEquipmentActive: TWideStringField;
    qryEquipmentmsTimeStamp: TDateTimeField;
    qryEquipmentProductId: TLargeintField;
    qryEquipmentManufacture: TWideStringField;
    qryEquipmentModel: TWideStringField;
    qryEquipmentManufactureID: TIntegerField;
    qryEquipmentProductname: TWideStringField;
    DSEquipment: TDataSource;
    QryEquipmentParts: TERPQuery;
    QryEquipmentPartsProductName: TWideStringField;
    QryEquipmentPartsPARTSDESCRIPTION: TWideStringField;
    QryEquipmentPartsActive: TWideStringField;
    QryEquipmentPartsGlobalref: TWideStringField;
    QryEquipmentPartsID: TIntegerField;
    QryEquipmentPartsEquipmentId: TIntegerField;
    QryEquipmentPartsEquipmentname: TWideStringField;
    QryEquipmentPartsProductId: TIntegerField;
    QryEquipmentPartsmstimestamp: TDateTimeField;
    dsEquipmentParts: TDataSource;
    pnlHeader: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    pnlButtons: TDNMPanel;
    Label36: TLabel;
    cmdOk: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    cmdPrint: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    TabCtl20: TPageControl;
    tabMain: TTabSheet;
    tabEquip: TTabSheet;
    Custom_Fields: TTabSheet;
    tabMap: TTabSheet;
    tabParts: TTabSheet;
    tabAttachments: TTabSheet;
    qryManufacture: TERPQuery;
    qryManufactureName: TWideStringField;
    qryManufactureID: TIntegerField;
    qryModel: TERPQuery;
    qryParts: TERPQuery;
    qryPartsPARTSID: TIntegerField;
    qryPartsPARTNAME: TWideStringField;
    DNMPanel1: TDNMPanel;
    lblProduct: TLabel;
    cboProduct: TwwDBLookupCombo;
    Label2: TLabel;
    edDescription: TwwDBEdit;
    Label4: TLabel;
    cboManufacture: TwwDBLookupCombo;
    Label5: TLabel;
    cboModel: TwwDBLookupCombo;
    pnlEquips: TDNMPanel;
    pnlcustomfieldList: TDNMPanel;
    pnlMap: TDNMPanel;
    DNMPanel5: TDNMPanel;
    DNMPanel6: TDNMPanel;
    grdSpareParts: TwwDBGrid;
    Label6: TLabel;
    cboProductR: TwwDBLookupCombo;
    QryLinkedProduct: TERPQuery;
    QryLinkedProductPARTSID: TIntegerField;
    QryLinkedProductPARTNAME: TWideStringField;
    QryEquipmentPicture: TERPQuery;
    dsEquipmentPicture: TDataSource;
    dsEquipmentImages: TDataSource;
    QryEquipmentImages: TERPQuery;
    pnlPicHeader: TDNMPanel;
    btnAddPic: TDNMSpeedButton;
    btnStretch: TDNMSpeedButton;
    navPartPic: TwwDBNavigator;
    navPartPicFirst: TwwNavButton;
    navPartPicPriorPage: TwwNavButton;
    navPartPicPrior: TwwNavButton;
    navPartPicNext: TwwNavButton;
    navPartPicLast: TwwNavButton;
    navPartPicDelete: TwwNavButton;
    QryEquipmentPictureID: TIntegerField;
    QryEquipmentPictureGlobalref: TWideStringField;
    QryEquipmentPictureEquipmentID: TIntegerField;
    QryEquipmentPictureEquipImage: TBlobField;
    QryEquipmentPictureEquipMap: TBlobField;
    QryEquipmentPicturemsTimeStamp: TDateTimeField;
    QryEquipmentPicturemsUpdateSiteCode: TWideStringField;
    QryEquipmentImagesID: TIntegerField;
    QryEquipmentImagesGlobalref: TWideStringField;
    QryEquipmentImagesEquipmentID: TIntegerField;
    QryEquipmentImagesEquipImage: TBlobField;
    QryEquipmentImagesmsTimeStamp: TDateTimeField;
    QryEquipmentImagesmsUpdateSiteCode: TWideStringField;
    mnuEquipImages: TAdvPopupMenu;
    mitAddImage: TMenuItem;
    mnuEquipPicture: TAdvPopupMenu;
    MenuItem1: TMenuItem;
    mnuEquipmentMap: TAdvPopupMenu;
    MenuItem2: TMenuItem;
    qryEquipmentEquipmentDetails: TWideMemoField;
    Label1: TLabel;
    wwDBEdit1: TwwDBEdit;
    qryEquipmentComments: TWideMemoField;
    pnlAttachments: TPanel;
    StrechImage1: TMenuItem;
    StretchImage2: TMenuItem;
    QrySerialno: TERPQuery;
    QrySerialnoPartsId: TIntegerField;
    QrySerialnoDepartmentID: TIntegerField;
    QrySerialnoUOM: TWideStringField;
    QrySerialnoUOMMultiplier: TFloatField;
    QrySerialnogLevel: TLargeintField;
    QrySerialnoProductName: TWideStringField;
    QrySerialnoProductColumn1: TWideStringField;
    QrySerialnoProductColumn2: TWideStringField;
    QrySerialnoProductColumn3: TWideStringField;
    QrySerialnoClassname: TWideStringField;
    QrySerialnoBatchnumber: TWideStringField;
    QrySerialnocBatchExpiryDate: TWideStringField;
    QrySerialnoBatchExpiryDate: TDateTimeField;
    QrySerialnobinLocation: TWideStringField;
    QrySerialnoBinnumber: TWideStringField;
    QrySerialnoSerialnumber: TWideStringField;
    QrySerialnoAlloctype: TWideStringField;
    QrySerialnoDescription: TWideStringField;
    dsSerialno: TDataSource;
    TabSerial: TTabSheet;
    DNMPanel3: TDNMPanel;
    grpFilters: TwwRadioGroup;
    pnlSerials: TDNMPanel;
    Label7: TLabel;
    grdSerials: TwwDBGrid;
    QryEquipmentImagesEquipImagetype: TWideStringField;
    QryEquipmentPictureEquipImagetype: TWideStringField;
    QryEquipmentPictureEquipMaptype: TWideStringField;
    QryEquipmentPartsQuantity: TFloatField;
    Label3: TLabel;
    pnlImage: TDNMPanel;
    pnlPicturetype: TDNMPanel;
    DBText1: TDBText;
    Label8: TLabel;
    ImgEquip: TImage;
    ImgEquips: TImage;
    pnlPicturetypes: TDNMPanel;
    DBText2: TDBText;
    Label9: TLabel;
    ImgEquipMap: TImage;
    pnlMaptype: TDNMPanel;
    DBText3: TDBText;
    Label10: TLabel;
    qryPartsPARTSDESCRIPTION: TWideStringField;
    QrySerialnoPartsDescription: TWideStringField;
    qryEquipmentmsUpdateSiteCode: TWideStringField;
    qryEquipmentOnHire: TWideStringField;
    qryEquipmentSerialNumber: TWideStringField;
    dlgSerialSelect: TSelectionDialog;
    lblMsg: TLabel;
    Label12: TLabel;
    edtName: TwwDBEdit;
    Shader1: TShader;
    pnlActiveForm: TLabel;
    DBText4: TDBText;
    qryEquipmentHireIncomeAccountID: TIntegerField;
    qryEquipmentHireIncomeAccountName: TWideStringField;
    qryEquipmentOnHireQty: TFloatField;
    edtDuration: TwwDBEdit;
    Label11: TLabel;
    QryLinkedProductDefaultWarrantyDuration: TFloatField;
    qryDuration: TERPQuery;
    dsDuration: TDataSource;
    qryDurationPARTSID: TIntegerField;
    qryDurationDefaultWarrantyDuration: TFloatField;
    qryEquipmentisQLDRegisteredVehicle: TWideStringField;
    wwCheckBox1: TwwCheckBox;
    Label13: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure cboManufactureCloseUp(Sender: TObject; LookupTable,FillTable: TDataSet; modified: Boolean);
    procedure cboManufactureNotInList(Sender: TObject; LookupTable: TDataSet;NewValue: String; var Accept: Boolean);
    procedure cboModelNotInList(Sender: TObject; LookupTable: TDataSet;NewValue: string; var Accept: Boolean);
    procedure cboProductCloseUp(Sender: TObject; LookupTable,FillTable: TDataSet; modified: Boolean);
    procedure cboProductRCloseUp(Sender: TObject; LookupTable,FillTable: TDataSet; modified: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdSparePartsExit(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdOkClick(Sender: TObject);
    procedure btnAddPicClick(Sender: TObject);
    procedure btnStretchClick(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure qryEquipmentAfterOpen(DataSet: TDataSet);
    procedure StretchImage2Click(Sender: TObject);
    procedure StrechImage1Click(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);
    procedure TabCtl20Change(Sender: TObject);
    procedure QryEquipmentPictureAfterScroll(DataSet: TDataSet);
    procedure QryEquipmentPictureAfterOpen(DataSet: TDataSet);
    procedure QryEquipmentPictureAfterPost(DataSet: TDataSet);
    procedure QryEquipmentImagesAfterOpen(DataSet: TDataSet);
    procedure QryEquipmentImagesAfterPost(DataSet: TDataSet);
    procedure QryEquipmentImagesAfterScroll(DataSet: TDataSet);
    procedure grdSerialsCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure QrySerialnoAfterOpen(DataSet: TDataSet);
//    procedure chooseSerialNumber(Sender: TObject);
    procedure TabCtl20Changing(Sender: TObject; var AllowChange: Boolean);
//    procedure qryIncomeAccountLookupBeforeOpen(DataSet: TDataSet);
//    procedure cboHireIncomeAccountNameBeforeOpenList(Sender: TObject);
//    procedure chkIsOnHireClick(Sender: TObject);
//    procedure lblDeleteSerialnumberClick(Sender: TObject);
  private
    fNewName:string;
    Equipment: TEquipment;
    fAttachmentForm : TfmAttachments;
//    HirePricingform :TfmHirePricing;
    fOnSaveEquip: TNotifyEvent;
    function AttachmentForm : TfmAttachments;
    function SaveEquip: boolean;
    Procedure ReadGuipref;
    Procedure WriteGuiPref;
    procedure OnTabSerial(Sender: TObject);
    Procedure RefreshEquipImage;
    Procedure RefreshEquipImages;
//    procedure LoadSerials;
//    function IsHired: Boolean;
//    procedure showHireTabinPartsform(Sender: TObject);
//    procedure DoOnCopyHirePricingFromProductCard(Sender: TObject);
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    function GetReportTypeID: integer;Override;
    (*Procedure LinkToEquipment(Sender:TObject);*)
  public
    property NewName: string read fNewName write fNewName;
    Function CustomFieldExtenderListtype:TListType; Override;
    Property OnSaveEquip :TNotifyEvent read fOnSaveEquip write fOnSaveEquip;
  end;


implementation

uses CommonLib, FormFactory, BusObjConst, BusObjManufacture, BusObjModel, jpeg,
  ImagesLib , AppEnvironment, SystemLib, BusObjStock, ProductQtyLib, tcConst, busobjPQA, BusObjPicture,
  tcDataUtils, CommonDbLib, DbSharedObjectsObj, CommonFormLib, frmPartsFrm,
  LogLib, BaseListingForm, BusobjProduct;

{$R *.dfm}
Function TfmEquip.SaveEquip:boolean;
begin
  result := False;
  Equipment.PostDB;
  Equipment.Equipmentparts.PostDB;
  if not Equipment.ValidateData then exit;
  if qryDuration.State in [dsEdit, dsInsert] then
    qryDuration.Post;
  REsult := Equipment.Save;
end;
procedure TfmEquip.StrechImage1Click(Sender: TObject);
begin
  inherited;
  {imgPicture}ImgEquip.Stretch := not({imgPicture}ImgEquip.Stretch);
end;

procedure TfmEquip.StretchImage2Click(Sender: TObject);
begin
  inherited;
  DisableForm;
  try
    {ImgMap}ImgEquipMap.Stretch := not({ImgMap}ImgEquipMap.Stretch);
  finally
    EnableForm;
  end;

end;

procedure TfmEquip.TabCtl20Change(Sender: TObject);
begin
  inherited;
  if (TabCtl20.ActivePage = TTabSheet(TabSerial))         then OnTabSerial(sender)
end;

procedure TfmEquip.TabCtl20Changing(Sender: TObject; var AllowChange: Boolean);
begin
  inherited;
  Equipment.PostDB;
  Allowchange := Equipment.ID<>0
end;

procedure TfmEquip.WriteGuiPref;
begin
  GuiPrefs.Node['Options.PictureStrech'].AsString      := BooleanToStr({imgPicture}ImgEquip.Stretch);
  GuiPrefs.Node['Options.ImageStrech'].AsString        := BooleanToStr({ImgMap}ImgEquipMap.Stretch);
  GuiPrefs.Node['Options.ImagesStrech'].AsString       := BooleanToStr({ImgImages}ImgEquips.Stretch);
end;

procedure TfmEquip.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  WriteGuiPref;
  inherited;
  Closequeries;
  Action := caFree;
end;

procedure TfmEquip.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    bringTofront;
    if not Equipment.Dirty then begin
        canclose := True;
        Exit;
    end;
    case CommonLib.MessageDlgXP_Vista('Do you wish to keep these changes you have made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
    mrYes:
        begin
          if SaveEquip then begin
            CommitTransaction;
            Notify(False);
            CanClose := True;
          end else Canclose := False;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          Equipment.Dirty := false;
          CanClose := True;
          Notify(True);
        end;
      mrCancel:
        begin
          CanClose := false;
        end;
    end;

end;

procedure TfmEquip.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.Active:= True;
  TabCtl20.ActivePage := tabMain;
  BeginTransaction;
  Equipment.Load(KeyID);
  edtName.Enabled := KeyId =0;
  if Self.KeyID = 0 then begin
    Equipment.New;
    Equipment.PostDB;
    Equipment.EditDB;
    Self.KeyID := Equipment.ID;
    if fNewName <> '' then Equipment.EquipmentName:= NewName;
  end;
  cboProduct.enabled := Equipment.cleanproductId =0;
  lblProduct.enabled := Equipment.cleanproductId =0;

  Equipment.EquipmentParts;
  Equipment.EquipmentImages;
  Equipment.EquipmentPicture;
//  Equipment.HirePricing;
//  Equipment.HirePricing.Lines;
  ReadGuiPref;
  Openqueries;
  (*if KeyId <> 0 then
    //qryDuration.Locate('PartsId', QryLinkedProductPARTSID.Value, [])
  else
    edtDuration.Enabled := false;*)

  if not Equipment.Lock then begin
    Self.caption :=  self.Caption + '     {Read-Only}';
    Accesslevel  := 5;
  end;

end;

//Function TfmEquip.IsHired:Boolean;
//var
//  Qry:TERPQuery;
//begin
//  Result := False;
//  if Trim(Equipment.cleanSerialnumber) ='' then exit;
//  Qry := DbSharedObj.GetQuery(self.MyConnection);
//  try
//    closedb(qry);
//    Qry.SQL.Text := 'Select * from tblHireLines where EquipmentId = ' + inttostr(Equipment.ID);
//    Qry.open;
//    result := Qry.recordcount >0;
//  finally
//    DbSharedObj.ReleaseObj(Qry);
//  end;
//end;

function TfmEquip.AttachmentForm: TfmAttachments;
begin
  Equipment.PostDB;
  If not Assigned(fAttachmentForm) then Begin
    fAttachmentForm := TfmAttachments(GetComponentByClassName('TfmAttachments',False,Self,True,True, Equipment.ID));
    fAttachmentForm.DBConnection := MyConnection;
    fAttachmentForm.AttachObserver(Self);
    fAttachmentForm.TableName := 'tblEquipment';
    fAttachmentForm.TableId := Equipment.ID;
    fAttachmentForm.Tag := Equipment.ID;
    fAttachmentForm.lvAttachments.Parent := pnlAttachments;
    fAttachmentForm.lvAttachments.Align := alClient;
    fAttachmentForm.PopulateListView;
  end;
  REsult := fAttachmentForm;
end;

procedure TfmEquip.btnAddPicClick(Sender: TObject);
begin
  DisableForm;
  try
    SelectPicture(TpotEquipmentImages, self, QryEquipmentImages   , QryEquipmentPictureID.fieldname, QryEquipmentImagesEquipImage.FieldName, True, QryEquipmentImagesEquipImageType.FieldName, true);
    PostDb(QryEquipmentImages);
  finally
    EnableForm;
    navPartPic.visible := False;
    navPartPic.visible := TRue;
    application.ProcessMessages;
  end;
end;

//procedure TfmEquip.showHireTabinPartsform(Sender: TObject);
//begin
//  if not (sender is TfrmParts ) then exit;
//  TfrmParts(Sender).pageControl.ActivePage := TfrmParts(Sender).Miscellaneous;
//  TfrmParts(Sender).MiscPageControl.ActivePage := TfrmParts(Sender).tabHire;
//  TfrmParts(Sender).MiscPageControl.OnChange(TfrmParts(Sender).MiscPageControl);
//end;

//procedure TfmEquip.LoadSerials;//(const PartsID, ClassID: integer);
//var
//  qryTemp: TERPQuery;
//begin
//  qryTemp := TERPQuery.Create(nil);
//  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
//  with qryTemp do try
//      Sql.Clear;
//      SQL.add(StockQtyDetailswithSno(True, Equipment.ProductId  , 0 ));
//      Open;
//      dlgSerialSelect.Items.Clear;
//      if not IsEmpty then begin
//        First;
//        while not Eof do begin
//          if FieldByName('SerialNumber').AsString <> '' then dlgSerialSelect.Items.Add(FieldByName('SerialNumber').AsString);
//          Next;
//        end;
//      end;
//    finally
//      FreeAndNil(qryTemp);
//    end;
//end;

procedure TfmEquip.btnStretchClick(Sender: TObject);
begin
  DisableForm;
  try
    {ImgImages}ImgEquips.Stretch := not({ImgImages}ImgEquips.Stretch);
  finally
    EnableForm;
  end;
end;

//procedure TfmEquip.cboHireIncomeAccountNameBeforeOpenList(Sender: TObject);
//begin
//  inherited;
////
//  TBaseListingGUI(Sender).FilterString:= 'Type = "Income" and Active = "T"';// and IsHeader="F"';
//  TBaseListingGUI(Sender).qryMain.ParamByName('ExcludeHeaderAccounts').AsString := 'T';
//  TBaseListingGUI(Sender).TimerMsg(TBaseListingGUI(Sender).FilterLabel , 'Please Choose the Account to use' , 20);
//
//end;

procedure TfmEquip.cboManufactureCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if not modified then exit;
  inherited;
  Equipment.ManufactureID := qryManufactureID.asInteger;
  Equipment.Manufacture   := qryManufactureName.AsString;
end;

procedure TfmEquip.cboManufactureNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('This value not found in the list. Do you want to create a new one?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
  begin
    Accept := false;
    Exit;
  end;
  if TERPQuery(cboManufacture.datasource.Dataset).State in [dsEdit, dsInsert] then
  else TERPQuery(cboManufacture.datasource.Dataset).Edit;
  TERPQuery(cboManufacture.datasource.Dataset).FieldByName('Manufacture').AsString := NewValue;
  TManufacture.newManufacture(NewValue);
  Closedb(qryManufacture);
  OpenDb(qryManufacture);
  if qryManufacture.Locate('name' , newValue , []) then
     cboManufactureCloseUp(cboManufacture , qryManufacture , qryEquipment , true);
end;

procedure TfmEquip.cboModelNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
var
  msg: string;
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('This value not found in the list. Do you want to create a new one?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then begin
    Accept := false;
    Exit;
  end
  else begin
    if TModel.AddNewModel(cboModel.Text,msg) then
      Accept:= true
    else begin
      Accept:= false;
      CommonLib.MessageDlgXP_Vista('Could not create new Model: ' + msg, mtWarning, [mbOk], 0);
    end;
  end;

end;

procedure TfmEquip.FormCreate(Sender: TObject);
begin
  fOnSaveEquip := nil;
  AllowCustomiseGrid := False;
  inherited;
  Equipment:= TEquipment.create(Self);
  Equipment.connection := TMyDacDataConnection.create(Equipment);
  Equipment.Connection.Connection := Self.MyConnection;
  Equipment.BusObjEvent := DoBusinessObjectEvent;

(*  ImgEquipMap.Visible := true; ImgEquipMap.align:= alclient;  ImgMap.datasource    := nil; ImgMap.datafield    := '';ImgMap.Visible     := False; ImgMap.align    := alright; pnlMaptype.Visible      := true;
  ImgEquips.Visible   := true; ImgEquips.align  := alclient;  ImgImages.datasource := nil; ImgImages.datafield := '';ImgImages.Visible  := False; ImgImages.align := alright; pnlPicturetypes.Visible := true;
  ImgEquip.Visible    := true; ImgEquip.align   := alclient;  imgPicture.datasource:= nil; imgPicture.datafield:= '';imgPicture.Visible := False; imgPicture.align:= alright; pnlPicturetype.Visible  := true;*)

end;

procedure TfmEquip.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
         if Sender is TEquipment          then TEquipment(Sender).Dataset       := QryEquipment
    else if Sender is TEquipmentImages    then TEquipmentImages(Sender).Dataset := QryEquipmentImages
    else if Sender is TEquipmentPicture   then TEquipmentPicture(Sender).Dataset:= QryEquipmentPicture
    else if Sender is TEquipmentParts     then TEquipmentParts(Sender).Dataset  := qryEquipmentParts
    else if Sender is TProductSimple      then TProductSimple(Sender).Dataset   := qryDuration;
  end else if (Eventtype = BusObjEvent_Dataset) and (Sender.IsdataIdchangeEvent(Value)) then begin
    if Sender is TEquipmentImages    then   RefreshEquipImages;
  end else if (Eventtype = BusobjEvent_ToDo) and (Value = BusobjEvent_IDChange) then begin
    cboProduct.enabled := Equipment.cleanproductId =0;
    lblProduct.enabled := Equipment.cleanproductId =0;
  end else if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_ProductChanged) and (Sender is TEquipment ) then begin
    Equipment.Product; // to open the product qry for Default Warranty
  end else if (EventType = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterOpen)  and (Sender is TEquipment ) then begin
    Equipment.Product; // to open the product qry for Default Warranty
  end else if (EventType = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterOpen)  and (Sender is TProductSimple ) then begin
    if TProductSimple(Sender).count =0 then exit;
    if not TProductSimple(Sender).lock then edtDuration.enabled := False else edtDuration.enabled :=  Accesslevel <= 3;
  end;
end;
procedure TfmEquip.cboProductRCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if not modified then exit;
  inherited;
  Equipment.EquipmentParts.ProductId := qryPartsPARTSID.asInteger;
  Equipment.EquipmentParts.PARTSDESCRIPTION := qrypartsPARTSDESCRIPTION.asString;
end;

//procedure TfmEquip.chkIsOnHireClick(Sender: TObject);
//begin
//  inherited;
//end;

//procedure TfmEquip.chooseSerialNumber(Sender: TObject);
//begin
//  inherited;
//  if Equipment.HasHirehistory  then begin
//    MessageDlgXP_vista('This Equipment is Already Used in Hire. You cannot Change the Serial Number', mtWarning, [mbOK], 0);
//    Exit;
//  end;
// DisableForm;
//  try
//    inherited;
//    LoadSerials;
//    dlgSerialSelect.MultiSelect := false;
//    if (dlgSerialSelect.Items.Count > 0) then begin
//      if dlgSerialSelect.Execute then begin
//        Equipment.SerialNumber := Trim(dlgSerialSelect.SelectedItems.Text);
//      end;
//    end else begin
//      CommonLib.MessageDlgXP_Vista('There Are No Serial Numbers For This Product On This ' + AppEnv.DefaultClass.ClassHeading, mtInformation, [mbOK], 0);
//    end;
//  finally
//    EnableForm;
//  end;
//end;

procedure TfmEquip.cmdCancelClick(Sender: TObject);
begin
  inherited;
  if fsModal in FormState then  Modalresult := mrcancel else Close;
end;

procedure TfmEquip.cmdNewClick(Sender: TObject);
begin
  inherited;
  if not SaveEquip then exit;
  Equipment.Dirty := False;
  CommitTransaction;
  KeyID    := 0;
  fNewName := '';
  FormShow(nil);

end;

procedure TfmEquip.cmdOkClick(Sender: TObject);
begin
  inherited;
  if not SaveEquip then exit;
  Equipment.Dirty := False;
  CommitTransaction;
  Notify(false);
  if Assigned(fOnSaveEquip) then
      fOnSaveEquip(Self);
  if fsModal in FormState then  modalresult := mrOk else Close;
end;

procedure TfmEquip.cmdPrintClick(Sender: TObject);
var
  s:String;
  ReportToPrint:String;
begin
  if not SaveEquip then exit;
  Equipment.Dirty := False;
  CommitTransaction;
  s:= '~|||~ Where EquipmentID = ' +inttostr(Equipment.ID) +
      '~|||~ Where EquipmentID = ' +inttostr(Equipment.ID) +
      '~|||~ Where EquipmentID = ' +inttostr(Equipment.ID) +
      '~|||~ Where CFV.MasterID = ' +inttostr(Equipment.ID) ;
  ReportToPrint := tcdatautils.GetDefaultReport(GetReportTypeID);
  PrintTemplateReport(ReportToPrint , S , not(AppEnv.Employee.ShowPreview) , 0);
  Notify(false);
  if fsModal in FormState then  modalresult := mrOk else Close;

end;
function TfmEquip.GetReportTypeID: integer;
begin
  Result := 104;
end;

function TfmEquip.CustomFieldExtenderListtype: TListType;
begin
  Result := ltEquipment;
end;

procedure TfmEquip.grdSerialsCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if Trim(Equipment.SerialNumber)<> '' then begin
    if SameTExt(Equipment.SerialNumber ,QrySerialnoSerialnumber.asString ) then begin
      ABrush.color := GridColhighLightGreen;
      AFont.color := Clblack;
    end;
  end;
end;

procedure TfmEquip.grdSparePartsExit(Sender: TObject);
begin
  inherited;
  Equipment.EquipmentParts.PostDB;
end;

procedure TfmEquip.grpFiltersClick(Sender: TObject);
begin
  inherited;
       if grpFilters.ItemIndex =0 then QrySerialno.filter := '(alloctype = '+ quotedStr('In-Stock') + ' or alloctype = ' + quotedStr('New')+ ')'
  else if grpFilters.ItemIndex =1 then QrySerialno.filter := 'alloctype = '+ quotedStr('Sold') +' or alloctype = '+ quotedStr('transferred') +' or alloctype = '+ quotedStr('Used in BOM')
  else if grpFilters.ItemIndex =2 then QrySerialno.filter := 'alloctype = '+ quotedStr('SO')
  else if grpFilters.ItemIndex =3 then QrySerialno.filter := 'alloctype = '+ quotedStr('Fixed Asset')
  else QrySerialno.filter := '';
  QrySerialno.filtered := grpFilters.ItemIndex <> 4;

end;

procedure TfmEquip.MenuItem1Click(Sender: TObject);
begin
  DisableForm;
  try
    SelectPicture(TpotEquipmentPicture, self, TERPQuery(Equipment.EquipmentPicture.Dataset ), Equipment.EquipmentPicture.IDfieldname, QryEquipmentPictureEquipImage.FieldName, False, QryEquipmentPictureEquipImageType.FieldName);
    Equipment.EquipmentPicture.PostDB;
  finally
    EnableForm;
    application.ProcessMessages;
  end;
end;

procedure TfmEquip.MenuItem2Click(Sender: TObject);
begin
  DisableForm;
  try
    SelectPicture(TpotEquipmentPicture, self, TERPQuery(Equipment.EquipmentPicture.Dataset ) , Equipment.EquipmentPicture.IDfieldname,QryEquipmentPictureEquipMap.FieldName, False,QryEquipmentPictureEquipMapType.FieldName);
    Equipment.EquipmentPicture.PostDB;
  finally
    EnableForm;
    application.ProcessMessages;
  end;

end;


procedure TfmEquip.qryEquipmentAfterOpen(DataSet: TDataSet);
begin
  inherited;
    AttachmentForm;
end;

procedure TfmEquip.QryEquipmentImagesAfterOpen(DataSet: TDataSet);
begin
  inherited;
  RefreshEquipImages;
end;

procedure TfmEquip.QryEquipmentImagesAfterPost(DataSet: TDataSet);
begin
  inherited;
  RefreshEquipImages;
end;

procedure TfmEquip.QryEquipmentImagesAfterScroll(DataSet: TDataSet);
begin
  inherited;
  RefreshEquipImages;
end;

procedure TfmEquip.QryEquipmentPictureAfterOpen(DataSet: TDataSet);
begin
  inherited;
  RefreshEquipImage;
end;

procedure TfmEquip.QryEquipmentPictureAfterPost(DataSet: TDataSet);
begin
  inherited;
  RefreshEquipImage;
end;

procedure TfmEquip.QryEquipmentPictureAfterScroll(DataSet: TDataSet);
begin
  inherited;
  RefreshEquipImage;
end;

//procedure TfmEquip.qryIncomeAccountLookupBeforeOpen(DataSet: TDataSet);
//begin
//  inherited;
//  clog(qryIncomeAccountLookup.SQLtext);
//end;

procedure TfmEquip.ReadGuipref;
begin
  {imgPicture}ImgEquip.Stretch  := StrToBoolean(GuiPrefs.Node['Options.PictureStrech'].AsString);
  {ImgMap}ImgEquipMap.Stretch      := StrToBoolean(GuiPrefs.Node['Options.ImageStrech'].AsString);
  {ImgImages}ImgEquips.Stretch   := StrToBoolean(GuiPrefs.Node['Options.ImagesStrech'].AsString);
end;

procedure TfmEquip.RefreshEquipImage;
begin
  ImagesLib.RefreshDsImage(QryEquipmentPicture, 'EquipImage', 'EquipImagetype' , ImgEquip,  pnlImage , pnlPicturetype);
  ImagesLib.RefreshDsImage(QryEquipmentPicture, 'EquipMap', 'EquipMaptype' , ImgEquipMap,  pnlMap , pnlMaptype);
end;

procedure TfmEquip.RefreshEquipImages;
begin
  ImagesLib.RefreshDsImage(QryEquipmentImages, 'EquipImage', 'EquipImagetype' , ImgEquips,  pnlEquips , pnlPicturetypes);
end;

(*procedure TfmEquip.LinkToEquipment(Sender: TObject);
begin
  with TwwDBGrid(Sender).Datasource.dataset do begin
    if RecordCount = 0 then exit;
    if findfield('PartsId') = nil then exit;
    if fieldByname('PartsID').asInteger = 0 then exit;
    Equipment.ProductID :=  fieldByname('PartsID').asInteger;
    Equipment.PostDB;
  end;
end;*)

procedure TfmEquip.cboProductCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then exit;
  inherited;
  Equipment.ProductId := QryLinkedProductPARTSID.asInteger;
  //qryDuration.Locate('PartsId', QryLinkedProductPARTSID.Value, []);
  //edtDuration.Enabled := true;
end;

//procedure TfmEquip.DoOnCopyHirePricingFromProductCard(Sender: TObject);
//begin
//  Equipment.OnHire := true;
//end;

Procedure TfmEquip.OnTabSerial(Sender :TObject);
var
  fiProductID:Integer;
begin
  fiProductID:= Equipment.ProductId;

  With TProduct.CreateWithNewConn(Self) do try
    Load(fiProductID);
    QrySerialnoBatchnumber.visible      :=   Batch;
    QrySerialnoBatchExpiryDate.visible  :=   Batch;
    QrySerialnobinLocation.visible      :=   multipleBins;
    QrySerialnobinnumber.visible        :=   multipleBins;
    QrySerialno.DisableControls;
    try
      if QrySerialno.active then QrySerialno.Close;
      QrySerialno.SQL.clear;
      QrySerialno.SQL.add(Serialnumberlist(Id , 0 , 0, 0, 0, False));
      QrySerialno.SQL.add('Union');
      QrySerialno.SQL.add('SELECT distinct P.PartsId,');
      QrySerialno.SQL.add('S.ClassId as DepartmentID,');
      QrySerialno.SQL.add('0 as UOMID,');
      QrySerialno.SQL.add(Quotedstr(AppEnv.DefaultClass.DefaultUOM) +' as UOM,');
      QrySerialno.SQL.add('1 as UOMMultiplier,');
      QrySerialno.SQL.add('3 as gLevel,');
      QrySerialno.SQL.add('P.PartName as ProductName ,');
      QrySerialno.SQL.add(FirstColumn  +' as ProductColumn1,');
      QrySerialno.SQL.add(Secondcolumn +' as ProductColumn2,');
      QrySerialno.SQL.add(Thirdcolumn  +' as ProductColumn3,');
      QrySerialno.SQL.add('PartsDescription,');
      QrySerialno.SQL.add('S.ClassName,');
      QrySerialno.SQL.add('"" as Batchnumber,');
      QrySerialno.SQL.add('"" as TruckLoadNo,');
      QrySerialno.SQL.add('NULL  as dBatchExpiryDate,');
      QrySerialno.SQL.add('NULL  as BatchExpiryDate,');
      QrySerialno.SQL.add('"" as BinLocation,');
      QrySerialno.SQL.add('"" as BinNumber,');
      QrySerialno.SQL.add('SerialNo as SerialNumber,');
      QrySerialno.SQL.add('"" as Descxription,');
      QrySerialno.SQL.add('NULL as TransDate,');
      QrySerialno.SQL.add('"New" as allocType');
      QrySerialno.SQL.add('FROM tblSerialnumbers S');
      QrySerialno.SQL.add('inner join tblParts P on P.PartsId = S.ProductID');
      QrySerialno.SQL.add('Where  S.Active = "T"');
      QrySerialno.SQL.add('and Serialno not in (Select Value from tblPQADetails where PQAType = ' +quotedStr(TPQASN.PQADetailType)+' and productId = ' + IntToStr(ID)+')');
      QrySerialno.SQL.add('and S.ProductID =' + IntToStr(Id));
      QrySerialno.open;
      grpFiltersClick(grpFilters);
    finally
      QrySerialno.EnableControls;
    end;
  finally
    Free;
  end;
end;
procedure TfmEquip.QrySerialnoAfterOpen(DataSet: TDataSet);
begin
  inherited;
  lblMsg.visible := Trim(Equipment.Serialnumber )<> '';
  lblMsg.color := GridColhighLightGreen;
end;
initialization
  RegisterClassOnce(TfmEquip);
  with FormFact do begin
    RegisterMe(TfmEquip, 'TEquipmentListGUI_*=EquipmentID');
    RegisterMe(TfmEquip, 'THireEquipmentsGUI_*=EquipmentID');
    RegisterMe(TfmEquip, 'TEquipmentsparePartsGUI_*=EquipmentID');
    RegisterMe(TfmEquip, 'TClientEquipmentlist_*=EquipmentID');
    RegisterControl(TfmEquip, '*_cboEquipment=EquipmentID');
    RegisterControl(TfmEquip, '*_cboEquipmentName=EquipmentID');
    RegisterMe(TfmEquip, 'THireEquipmentListGUI_*=EquipmentID');
  end;
end.

