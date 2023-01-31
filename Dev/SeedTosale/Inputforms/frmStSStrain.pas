unit frmStSStrain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase, ActnList , BusobjStSStrain, Wwdbspin,
  wwdblook, wwcheckbox, Mask, wwdbedit, ComCtrls, AdvProgr, Grids, Wwdbigrd,
  Wwdbgrid, ERPDbLookupCombo, wwclearbuttongroup, wwradiogroup;

type
  TfmStSStrain = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    DNMPanel3: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    Actionlist: TActionList;
    dsStS_Strain: TDataSource;
    QryStS_Strain: TERPQuery;
    lblProductPrintName: TLabel;
    chkTested: TwwCheckBox;
    cboClientLookup: TERPQuery;
    cboClientLookupCompany: TWideStringField;
    cboClientLookupClientID: TIntegerField;
    cboClientLookupForeignExchangeSellCode: TWideStringField;
    Label1: TLabel;
    chkTestedInHouse: TwwCheckBox;
    Label2: TLabel;
    cboTestedBy: TwwDBLookupCombo;
    Shape1: TShape;
    Label3: TLabel;
    Shape2: TShape;
    Label4: TLabel;
    Label5: TLabel;
    edtTHC_Content: TwwDBSpinEdit;
    edtCBD_Content: TwwDBSpinEdit;
    Label7: TLabel;
    edtIndica: TwwDBSpinEdit;
    Label8: TLabel;
    edtsativa: TwwDBSpinEdit;
    prgIndica: TAdvProgress;
    prgSativa: TAdvProgress;
    edtImmatureProduct: TEdit;
    edtVegetativeProduct: TEdit;
    TitleLabel: TLabel;
    lblTimerMsg: TLabel;
    Label6: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    QryStS_StrainID: TIntegerField;
    QryStS_StrainGlobalRef: TWideStringField;
    QryStS_StrainStrainName: TWideStringField;
    QryStS_StrainTested: TWideStringField;
    QryStS_StrainTestedInHouse: TWideStringField;
    QryStS_StrainTestedByID: TIntegerField;
    QryStS_StrainTestedBy: TWideStringField;
    QryStS_StrainTHC_Content: TFloatField;
    QryStS_StrainCBD_Content: TFloatField;
    QryStS_StrainIndica: TFloatField;
    QryStS_StrainSativa: TFloatField;
    QryStS_StrainImmatureProductID: TIntegerField;
    QryStS_StrainFloweringProductID: TIntegerField;
    QryStS_StrainHarvestProductId: TIntegerField;
    QryStS_Strainmstimestamp: TDateTimeField;
    QryStS_Strainmsupdatesitecode: TWideStringField;
    edtStrainName: TwwDBEdit;
    edtFloweringProduct: TEdit;
    Shape3: TShape;
    Shape4: TShape;
    btnImmatureProduct: TDNMSpeedButton;
    btnVegetativeProduct: TDNMSpeedButton;
    btnFloweringProduct: TDNMSpeedButton;
    btnInitDefaults: TDNMSpeedButton;
    Label9: TLabel;
    edtHarvestProduct: TEdit;
    btnHarvestProduct: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdNewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cboTestedByCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
      modified: Boolean);
    procedure chkTestedInHouseEnter(Sender: TObject);
    procedure cboTestedByEnter(Sender: TObject);
    procedure QryStS_StrainAfterOpen(DataSet: TDataSet);
    procedure btnImmatureProductClick(Sender: TObject);
    procedure btnVegetativeProductClick(Sender: TObject);
    procedure btnFloweringProductClick(Sender: TObject);
    procedure btnHarvestProductClick(Sender: TObject);
    procedure btnInitDefaultsClick(Sender: TObject);

  private
    StSStrainObj: TStSStrain;
    function SaveRecord: Boolean;
    Procedure Openrec;
    procedure NewBusObjinstance;
    procedure NewRecord;
    function checkfortested: Boolean;
    procedure REfreshProducts(const changedfield:Integer);
    procedure ChooseImmatureProduct(Sender: TwwDBGrid);
    procedure ChooseFloweringProduct(Sender: TwwDBGrid);
    procedure ChooseVegetativeProduct(Sender: TwwDBGrid);
    procedure ChooseHarvestProduct(Sender: TwwDBGrid);
    procedure initProductList(Sender: TObject);
    procedure initProductListForHArvest(Sender :TObject);
  Protected
    procedure CommitAndNotify;override;
  public
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  end;


implementation

uses CommonLib, BusObjConst, AppEnvironment , BusobjProduct, CommonFormLib,
  FormFactory, ProductListExpressForm, tcConst;

{$R *.dfm}


procedure TfmStSStrain.cboTestedByCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  StSStrainObj.TestedByID :=  cboClientLookupClientID.AsInteger;
end;


procedure TfmStSStrain.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

Function TfmStSStrain.SaveRecord :Boolean;
begin
  result:= False;
  StSStrainObj.PostDB;
  if not(StSStrainObj.Save) then exit;
  Result:= True;
end;


procedure TfmStSStrain.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  StSStrainObj.Connection.CommitTransaction;
  Self.Close;

end;

procedure TfmStSStrain.cmdNewClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  StSStrainObj.Connection.CommitTransaction;
  NewRecord;
end;

procedure TfmStSStrain.CommitAndNotify;
begin
  inherited;
  CommitTransaction;
  Notify;
end;



procedure TfmStSStrain.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
             if Sender is TStSStrain then TStSStrain(Sender).Dataset  := QryStS_Strain;
    end else if (Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterOpen) then begin
      if sender = StSStrainObj then begin
        prgIndica.Position := trunc(StSStrainObj.Indica);
        prgSativa.Position := trunc(StSStrainObj.Sativa);
      end;
    end else if (Eventtype = BusObjEvent_Change) and (Value =BusObjEventVal_sts_Indica) then begin
      prgIndica.Position := trunc(StSStrainObj.Indica);
    end else if (Eventtype = BusObjEvent_Change) and (Value =BusObjEventVal_sts_Sativa) then begin
      prgSativa.Position := trunc(StSStrainObj.Sativa);
    end;
end;

procedure TfmStSStrain.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := cafree;
end;

procedure TfmStSStrain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if StSStrainObj.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveRecord then begin
            CommitAndNotify;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          StSStrainObj.Dirty := false;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
          cmdCancel.Enabled := True;
        end;
    end;
  end else begin
    CanClose := true;
    Notify(false);
  end;

end;

procedure TfmStSStrain.FormCreate(Sender: TObject);
begin
  inherited;
  StSStrainObj := nil;
  NewBusObjinstance;
end;
procedure TfmStSStrain.FormShow(Sender: TObject);
begin
  inherited;
  openrec;
end;

procedure TfmStSStrain.NewBusObjinstance;
begin
  {$WARNINGS OFF}
  if StSStrainObj <> nil then freeandnil(StSStrainObj);
  StSStrainObj := TStSStrain.CreateWithNewConn(Self);
  StSStrainObj.Connection.connection := Self.MyConnection;
  StSStrainObj.BusObjEvent := DoBusinessObjectEvent;
  {$WARNINGS ON}
end;

procedure TfmStSStrain.NewRecord;
begin
    KeyID:= 0;
    CloseQueries;
    self.BeginTransaction;
    NewBusObjinstance;
    AccessLevel:= AppEnv.AccessLevels.GetEmployeeAccessLevel(Self.ClassName);
    OpenRec;
    Caption:= TitleLabel.caption + AppEnv.AccessLevels.GetAccessLevelDescription(AccessLevel);
    Setcontrolfocus(edtStrainName);
end;

procedure TfmStSStrain.Openrec;
begin
  StSStrainObj.Load(KeyID);
  StSStrainObj.connection.BeginTransaction;
  if StSStrainObj.count=0 then StSStrainObj.new;
  openQueries;
  StSStrainObj.Dirty := false;
end;
procedure TfmStSStrain.QryStS_StrainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  REfreshProducts(0);
end;
procedure TfmStSStrain.REfreshProducts(const changedfield:Integer);
begin
  if (changedfield =0) or (changedfield=1) then edtImmatureProduct.Text  := TProductsimple.IDToggle(StSStrainObj.ImmatureProductID  , StSStrainObj.Connection.Connection);
  if (changedfield =0) or (changedfield=2) then edtVegetativeProduct.Text:= TProductsimple.IDToggle(StSStrainObj.VegetativeProductId, StSStrainObj.Connection.Connection);
  if (changedfield =0) or (changedfield=3) then edtFloweringProduct.Text := TProductsimple.IDToggle(StSStrainObj.FloweringProductID , StSStrainObj.Connection.Connection);
  if (changedfield =0) or (changedfield=4) then edtHarvestProduct.Text   := TProductsimple.IDToggle(StSStrainObj.HarvestProductId   , StSStrainObj.Connection.Connection);
end;
Function TfmStSStrain.checkfortested:Boolean;
begin
  REsult := False;
  if not StSStrainObj.Tested  then begin
    TimerMsg(lblTimerMsg , 'Strain is not Tested Yet');
    Setcontrolfocus(chkTested);
    Exit;
  end;
  Result := True;
end;

procedure TfmStSStrain.chkTestedInHouseEnter (Sender: TObject);begin  inherited;checkfortested; end;
procedure TfmStSStrain.cboTestedByEnter      (Sender: TObject);begin  inherited;checkfortested;end;

procedure TfmStSStrain.btnInitDefaultsClick(Sender: TObject);
var
  fs1, fs2, fs3, fs4:String;
begin
  inherited;
  if StSStrainObj.StrainName = '' then begin
    MessageDlgXP_Vista('Please Provide the Strain Name', mtWarning, [mbOK], 0);
    Exit;
  end;

  fs1:='';
  fs2:='';
  fs3:='';
  fs4:='';
  if (StSStrainObj.ImmatureProductID=0) or Devmode then
    fs1:= CustomInputString('Name' , 'Immature Strain Product for ' + quotedstr(trim(StSStrainObj.StrainName)) ,  'Immature - '+trim(StSStrainObj.StrainName));
(*    if fs<> '' then begin
      if TProductSimple.MakeProduct(fs,nil,False,Appenv.Companyprefs.StSUsesBins,true,False, '', 'Immature^'+StSStrainObj.StrainName) then begin
        edtImmatureProduct.text := fs;
        StSStrainObj.ImmatureProductID := TProductSimple.idtoggle(fs);
      end;
    end;*)

  if (StSStrainObj.VegetativeProductID=0) or Devmode then
    fs2:= CustomInputString('Name' , 'Vegetative Strain Product for ' + quotedstr(trim(StSStrainObj.StrainName)) ,  'Vegetative - '+trim(StSStrainObj.StrainName));
(*    if fs<> '' then begin
      if TProductSimple.MakeProduct(fs,nil,False,Appenv.Companyprefs.StSUsesBins,true,False, '', 'Vegetative^'+StSStrainObj.StrainName) then begin
        edtVegetativeProduct.text := fs;
        StSStrainObj.VegetativeProductID := TProductSimple.idtoggle(fs);
      end;
    end;*)

  if (StSStrainObj.FloweringProductID=0) or Devmode then
    fs3:= CustomInputString('Name' , 'Flowering Strain Product for ' + quotedstr(trim(StSStrainObj.StrainName)) ,  'Flowering - '+trim(StSStrainObj.StrainName));
(*    if fs<> '' then begin
      if TProductSimple.MakeProduct(fs,nil,False,Appenv.Companyprefs.StSUsesBins,true,False, '', 'Flowering^'+StSStrainObj.StrainName) then begin
        edtFloweringProduct.text := fs;
        StSStrainObj.FloweringProductID := TProductSimple.idtoggle(fs);
      end;
    end;*)

  if (StSStrainObj.HarvestProductId=0) or Devmode then
    fs4:= CustomInputString('Name' , 'Harvest Strain Product for ' + quotedstr(trim(StSStrainObj.StrainName)) ,  'Harvest - '+trim(StSStrainObj.StrainName));
(*    if fs<> '' then begin
      if TProductSimple.MakeProduct(fs,nil,False,true,False,False, '', 'Harvest^'+StSStrainObj.StrainName) then begin
        edtHarvestProduct.text := fs;
        StSStrainObj.HarvestProductId := TProductSimple.idtoggle(fs);
      end;
    end;*)

  StSStrainObj.DoCreateDefaultProducts(False, fs1, fs2, fs3, fs4);
  edtImmatureProduct.text   := StSStrainObj.ImmatureProductname;
  edtVegetativeProduct.text := StSStrainObj.VegetativeProductname;
  edtFloweringProduct.text  := StSStrainObj.FloweringProductname;
  edtHarvestProduct.text    := StSStrainObj.HarvestProductname;
end;

procedure TfmStSStrain.btnImmatureProductClick (Sender: TObject);begin  OpenERPListFormSingleselect('TProductListExpressGUI' , ChooseImmatureProduct  ,initProductList );end;
procedure TfmStSStrain.btnVegetativeProductClick(Sender: TObject);begin  OpenERPListFormSingleselect('TProductListExpressGUI' , ChooseVegetativeProduct,initProductList);end;
procedure TfmStSStrain.btnFloweringProductClick(Sender: TObject);begin  OpenERPListFormSingleselect('TProductListExpressGUI' , ChooseFloweringProduct ,initProductList);end;
procedure TfmStSStrain.btnHarvestProductClick(Sender: TObject);begin  OpenERPListFormSingleselect('TProductListExpressGUI' , ChooseHarvestProduct   ,initProductListForHArvest);end;

procedure TfmStSStrain.ChooseImmatureProduct  (Sender :TwwDBGrid);begin  StSStrainObj.ImmatureProductID   := Sender.DataSource.DataSet.FieldByName('PARTSID').AsInteger;  REfreshProducts(1);end;
procedure TfmStSStrain.ChooseVegetativeProduct(Sender :TwwDBGrid);begin  StSStrainObj.VegetativeProductId := Sender.DataSource.DataSet.FieldByName('PARTSID').AsInteger;  REfreshProducts(2);end;
procedure TfmStSStrain.ChooseFloweringProduct (Sender :TwwDBGrid);begin  StSStrainObj.FloweringProductID  := Sender.DataSource.DataSet.FieldByName('PARTSID').AsInteger;  REfreshProducts(3);end;
procedure TfmStSStrain.ChooseHarvestProduct (Sender :TwwDBGrid);begin  StSStrainObj.HarvestProductId      := Sender.DataSource.DataSet.FieldByName('PARTSID').AsInteger;  REfreshProducts(4);end;

procedure TfmStSStrain.initProductList(Sender :TObject);
begin
  if sender is  TProductListExpressGUI then begin
      TProductListExpressGUI(Sender).filterString :=  'PartType ='          + Quotedstr('INV')+
                                                      ' and SNtracking ='   + Quotedstr('T')+
                                                      ' and Multiplebins = ' + iif(Appenv.Companyprefs.StSUsesBins , Quotedstr('T'), Quotedstr('F')) +
                                                      ' and Batch ='        + Quotedstr('F');
      TProductListExpressGUI(Sender).ListTimerMsg('This is the List of Inventory Products With ' +
                                iif(Appenv.Companyprefs.StSUsesBins ,'Bin and ' , '') +' Serial Number Tracking '+NL+
                                '('+  iif(Appenv.Companyprefs.StSUsesBins ,'' , 'Bin and')  +' Batch Disabled)');
  end;
end;
procedure TfmStSStrain.initProductListForHArvest(Sender :TObject);
begin
  if sender is  TProductListExpressGUI then begin
      TProductListExpressGUI(Sender).filterString :=  'PartType ='          + Quotedstr('INV')+
                                                      ' and SNtracking ='   + Quotedstr('F')+
                                                      ' and Multiplebins = ' +Quotedstr('T')+
                                                      ' and Batch ='        + Quotedstr('F');
      TProductListExpressGUI(Sender).ListTimerMsg('This is the List of Inventory Products With Bin ');
  end;
end;

initialization
  RegisterClassOnce(TfmStSStrain);
  with FormFact do begin
    RegisterMe(TfmStSStrain, 'TStSStrainsGUI_*=ID');
  end;
end.

