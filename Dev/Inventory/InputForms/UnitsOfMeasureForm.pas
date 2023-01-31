unit UnitsOfMeasureForm;


{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 30/08/05 1.00.01  DSP  Resized form back to its original size.
  1/11/05 1.00.02  DLS  Added RegisterClass

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB,   StdCtrls,
  Mask, DBCtrls, Buttons, DNMSpeedButton, ExtCtrls, DNMPanel, kbmMemTable, wwdblook,
  DBAccess, MyAccess,ERPdbComponents, DataState, wwcheckbox, Menus, AdvMenus, MemDS, Shader,
  ImgList, ProgressDialog, wwdbedit, Wwdbspin;

type
  TUnitsOfMeasureGUI = class(TBaseInputGUI)
    qryUnitsOfMeasure: TERPQuery;
    dsUnitsOfMeasure: TDataSource;
    qryUnitsOfMeasureUnitID: TAutoIncField;
    qryUnitsOfMeasureUnitName: TWideStringField;
    qryUnitsOfMeasureUnitDescription: TWideStringField;
    Label1: TLabel;
    edtUnit: TDBEdit;
    Label2: TLabel;
    edtDesc: TDBEdit;
    Bevel1: TBevel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    memQryUnitsOfMeasure: TkbmMemTable;
    edtMultipleir: TDBEdit;
    Label3: TLabel;
    qrycboUnitOfMeasure: TERPQuery;
    cboUnitOfMeasure: TwwDBLookupCombo;
    Label4: TLabel;
    qryUnitsOfMeasureMultiplier: TFloatField;
    qryUnitsOfMeasureGlobalRef: TWideStringField;
    qryUnitsOfMeasureEditedFlag: TWideStringField;
    qryUnitsOfMeasureBaseUnitName: TWideStringField;
    Label11: TLabel;
    chkActive: TwwCheckBox;
    qryUnitsOfMeasureActive: TWideStringField;
    Label5: TLabel;
    qryParts: TERPQuery;
    qryPartsPartsID: TIntegerField;
    qryPartsPartName: TWideStringField;
    qryUnitsOfMeasurePartID: TIntegerField;
    dsParts: TDataSource;
    qryUnitsOfMeasureBaseUnitID: TIntegerField;
    SalesDefault: TwwCheckBox;
    lblSalesDefault: TLabel;
    PurchasesDefault: TwwCheckBox;
    lblPurchasesDefault: TLabel;
    qryUnitsOfMeasureSalesDefault: TWideStringField;
    qryUnitsOfMeasurePurchasesDefault: TWideStringField;
    cboParts: TwwDBLookupCombo;
    qrycboUnitOfMeasureUnitName: TWideStringField;
    qrycboUnitOfMeasureMultiplier: TFloatField;
    qrycboUnitOfMeasureUnitDescription: TWideStringField;
    qrycboUnitOfMeasureBaseUnitName: TWideStringField;
    qrycboUnitOfMeasureUnitID: TIntegerField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Label121: TLabel;
    lblDimension: TLabel;
    Bevel2: TBevel;
    Label6: TLabel;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    Label7: TLabel;
    DBEdit4: TDBEdit;
    Label8: TLabel;
    qryUnitsOfMeasureHeight: TFloatField;
    qryUnitsOfMeasureWidth: TFloatField;
    qryUnitsOfMeasureLength: TFloatField;
    qryUnitsOfMeasureWeight: TFloatField;
    qryUnitsOfMeasureVolume: TFloatField;
    Label9: TLabel;
    DBEdit5: TDBEdit;
    Label10: TLabel;
    DBEdit6: TDBEdit;
    lblvolumeUOM: TLabel;
    lblvolumeUOM1: TLabel;
    lblWeightUOM: TLabel;
    Bevel3: TBevel;
    qryUnitsOfMeasureUnitProductKeyName: TWideStringField;
    qryUnitsOfMeasureNoOfBoxes: TIntegerField;
    Label12: TLabel;
    wwDBSpinEdit1: TwwDBSpinEdit;
    qryUnitsOfMeasureUseforAutoSplitQtyinSales: TWideStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure qryUnitsOfMeasureAfterOpen(DataSet: TDataSet);
    procedure qryUnitsOfMeasureMultiplierChange(Sender: TField);
    procedure FormCreate(Sender: TObject);
    procedure qryUnitsOfMeasureBaseUnitNameChange(Sender: TField);
    function IsUnique : boolean;
    procedure qryUnitsOfMeasurePartIDChange(Sender: TField);
    procedure cboPartsChange(Sender: TObject);
    procedure qryUnitsOfMeasureBeforePost(DataSet: TDataSet);
    procedure cboUnitOfMeasureNotInList(Sender: TObject;
      LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
    procedure cboPartsDblClick(Sender: TObject);
    procedure qryUnitsOfMeasureHeightChange(Sender: TField);
    procedure cboUnitOfMeasureCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    fiProductId :Integer;
    fbformshowing:Boolean;
    fbSaveClicked:Boolean;
    procedure ProductUnitDefault(Const bMode: Boolean);
    function GetProductUOMSalesDefault(PartID:integer):string;
    function GetProductUOMPurchDefault(PartID:integer):string;
    procedure UpdateGlobalRefs;
    Procedure setdimensions;
    function SaveUOM: Boolean;
  Protected
    procedure KeyIdChanged(const NewKeyId: integer); override;
  public
    Property ProductId :Integer read fiProductId Write fiProductID;

  end;


implementation

uses
  FormFactory, DNMExceptions, DNMLib, FastFuncs, AppEnvironment, CommonLib,
  tcConst, BaseFormForm, CompanyPrefObj, ProductQtyLib, CommonDbLib,
  BusObjProductProperties, BusobjUOM;

{$R *.dfm}

{ TUnitsOfMeasureGUI }

procedure TUnitsOfMeasureGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  Action := caFree;
end;

procedure TUnitsOfMeasureGUI.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  iExitResult: integer;
begin
  Canclose := true;
  if fbSaveClicked then Exit;

  iExitResult := CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
  case iExitResult of
    mrYes:
      begin
        Canclose := SaveUOM;
        if Canclose then begin
          CommitTransaction;
          Notify(False);
        end;
      end;
    mrNo:
      begin;
        RollbackTransaction;
        Notify(True);
        Canclose := true;
      end;
    mrCancel: Canclose := false;
  end;
end;

procedure TUnitsOfMeasureGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      Setdimensions;
      if qryUnitsOfMeasure.Active then begin
        if not (qryUnitsOfMeasure.State in [dsBrowse]) then begin
          qryUnitsOfMeasure.Post;
          Notify;
        end;
        CloseQueries;
      end;

      qryUnitsOfMeasure.ParamByName('xUnitID').asInteger := KeyID;
      OpenQueries;

      qrycboUnitOfMeasure.Close;
      qrycboUnitOfMeasure.ParamByName('xPartID').AsInteger := qryUnitsOfMeasurePartID.AsInteger;
      qrycboUnitOfMeasure.Open;


      if KeyID = 0 then begin
        qryUnitsOfMeasure.Insert;
        edtUnit.ReadOnly := false;
        qryUnitsOfMeasureUnitName.ReadOnly := false;
        if fiProductID <> 0 then
           if QryParts.Locate('PartsId' , fiProductId , []) then
              qryUnitsOfMeasurePartID.asInteger := fiProductId;
      end else begin
        if (Sysutils.SameText(qryUnitsOfMeasureUnitName.asString, AppEnv.DefaultClass.DefaultUOM)) and
          (qryUnitsOfMeasurePartID.asInteger = 0) and
          (qryUnitsOfMeasureMultiplier.asFloat = 1) then begin
          (*AccessLevel:= 5; // read only*)
          edtUnit.Readonly          := True;
          cboParts.Readonly         := True;
          edtMultipleir.Readonly    := True;
          cboUnitOfMeasure.Readonly := True;
          PurchasesDefault.Readonly := True;
          SalesDefault.Readonly     := True;
          chkActive.Readonly        := True;

          CommonLib.MessageDlgXP_Vista('This is the Default Unit of Measure.'+#13+#10+#13+#10+'Access has been changed to read-only .', mtWarning, [mbOK], 0);
        end else begin
          qryUnitsOfMeasure.Edit;
        end;
        edtUnit.ReadOnly := true;
        qryUnitsOfMeasureUnitName.ReadOnly := true;
      end;

      ProductUnitDefault(qryUnitsOfMeasurePartID.AsInteger<>0);

      qryUnitsOfMeasureMultiplierChange(nil);

      if qryUnitsOfMeasure.Active then begin
          CheckRecordUsage('tblunitsofmeasure' ,'BaseUnitName = ' + quotedstr(qryUnitsOfMeasureUnitName.asString) ,'UnitID' ,'In ''Unit of Measure'' as ''Base Unit''' );
      End;

    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
    cboUnitOfMeasure.Visible := (qryUnitsOfMeasureMultiplier.AsFloat <> 1);
    Label4.Visible := (qryUnitsOfMeasureMultiplier.AsFloat <> 1);
  finally
    fbformshowing := False;
    EnableForm;
  end;
end;
function TUnitsOfMeasureGUI.GetProductUOMPurchDefault(PartID:integer):string;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(Self);
  try
    qry.Connection := MyConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM tblunitsofmeasure WHERE PartID = ');
    qry.SQL.Add(IntToStr(PartID));
    qry.SQL.Add(' AND PurchasesDefault = ');
    qry.SQL.Add(QuotedStr('T'));
    qry.Open;

    if qry.RecordCount > 0 then begin
      result := qry.FieldByName('UnitName').AsString;
    end else begin
      result := '0';
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function TUnitsOfMeasureGUI.GetProductUOMSalesDefault(PartID:integer):string;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(Self);
  try
    qry.Connection := MyConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM tblunitsofmeasure WHERE PartID = ');
    qry.SQL.Add(IntToStr(PartID));
    qry.SQL.Add(' AND SalesDefault = ');
    qry.SQL.Add(QuotedStr('T'));
    qry.Open;

    if qry.RecordCount > 0  then begin
      result := qry.FieldByName('UnitName').AsString;
    end else begin
      result := '0';
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TUnitsOfMeasureGUI.btnSaveClick(Sender: TObject);
begin
  fbSaveClicked:= TRue;
   if not SaveUOM then exit;
   CommitTransaction;
   Self.Close;
end;
function TUnitsOfMeasureGUI.SaveUOM:Boolean;
var
  iPartID:integer;
begin
  REsult:= False;
  inherited;
  if not IsUnique then begin
    CommonLib.MessageDlgXP_Vista('A Unit of Measure with this name already exists!', mtWarning, [mbOK], 0);
    Exit;
  end;
  if qryUnitsOfMeasureMultiplier.asFloat <> 1 then
    if qryUnitsOfMeasureBaseUnitName.asString = '' then begin
      CommonLib.MessageDlgXP_Vista('Base ''Units of Measure'' should not be balnk when the multiplier is <> 1' , mtWarning, [mbOK], 0);
      SetControlFocus(cboUnitOfMeasure);
      Exit;
    end;
  if (qryUnitsOfMeasureMultiplier.asFloat > 1) and TUnitOfMeasure.IsParentUOM(qryUnitsOfMeasureUnitID.AsInteger) then begin
    CommonLib.MessageDlgXP_Vista('This UOM is used as the Base Unit for other UOM records so the Multiplier mut be 1' , mtWarning, [mbOK], 0);
    SetControlFocus(edtMultipleir);
    Exit;
  end;
  if SalesDefault.Checked then begin
    iPartID := cboParts.DataSource.DataSet.FieldByName('PartID').AsInteger;
    if (GetProductUOMSalesDefault(iPartID) <> '0') and (GetProductUOMSalesDefault(iPartID) <> edtUnit.Text)  then begin
      CommonLib.MessageDlgXP_Vista('Product already has ' + QuotedStr(GetProductUOMSalesDefault(iPartID)) + ' as the Sales default.' + #13 + #10 +
             'To change, edit ' + QuotedStr(GetProductUOMSalesDefault(iPartID)) + ' first,' , mtWarning, [mbOK], 0);
      Exit;
    end;
  end;

  if PurchasesDefault.Checked then begin
    iPartID := cboParts.DataSource.DataSet.FieldByName('PartID').AsInteger;
    if (GetProductUOMPurchDefault(iPartID) <> '0') and (GetProductUOMPurchDefault(iPartID) <> edtUnit.Text)  then begin
      CommonLib.MessageDlgXP_Vista('Product already has ' + QuotedStr(GetProductUOMPurchDefault(iPartID)) + ' as the Purchases default.' + #13 + #10 +
             'To change, edit ' + QuotedStr(GetProductUOMPurchDefault(iPartID)) + ' first,' , mtWarning, [mbOK], 0);
      Exit;
    end;
  end;

  try
    if not Empty(edtUnit.Text) then begin
      if not (qryUnitsOfMeasure.State in [dsBrowse]) then begin
        ProcessEditedFlag('Main', Self, memqryUnitsOfMeasure, qryUnitsOfMeasure, nil);
        qryUnitsOfMeasure.Edit;
        qryUnitsOfMeasure.Post;
        UpdateGlobalRefs;
        KeyID:= qryUnitsOfMeasureUnitID.AsInteger;
        Notify;
        Notify(false);
      end;
      REsult := True;
    end else begin
      CommonLib.MessageDlgXP_Vista('Unit name cannot be blank.', mtWarning, [mbOK], 0);
      SetControlFocus(edtUnit);
    end;
  except
    on EAbort do HandleEAbortException;
    else raise;
  end;
end;

procedure TUnitsOfMeasureGUI.btnNewClick(Sender: TObject);
begin
  inherited;
   if not SaveUOM then exit;
   CommitTransaction;
   KeyID := 0;
   FormShow(nil);
   edtUnit.ReadOnly := False;
   SetControlFocus(edtUnit);
(*  if not IsUnique then begin
    CommonLib.MessageDlgXP_Vista('A Unit of Measure with this name already exists!', mtWarning, [mbOK], 0);
    Exit;
  end;
  try
    if not Empty(edtUnit.Text) then begin
      if not (qryUnitsOfMeasure.State in [dsBrowse]) then begin
        ProcessEditedFlag('Main', Self, memqryUnitsOfMeasure, qryUnitsOfMeasure, nil);
        qryUnitsOfMeasure.Edit;
        qryUnitsOfMeasure.Post;
        UpdateGlobalRefs;
        KeyID:= qryUnitsOfMeasureUnitID.AsInteger;
        Notify;
        Notify(false);
      end;
      KeyID := 0;
      FormShow(nil);
      edtUnit.ReadOnly := False;
      SetControlFocus(edtUnit);
    end else begin
      CommonLib.MessageDlgXP_Vista('Unit name cannot be blank.', mtWarning, [mbOK], 0);
      SetControlFocus(edtUnit);
    end;
  except
    on EAbort do HandleEAbortException;
    else raise;
  end;*)
end;

procedure TUnitsOfMeasureGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TUnitsOfMeasureGUI.qryUnitsOfMeasureAfterOpen(DataSet: TDataSet);
begin
  inherited;
  LoadEditedFlagMemTable(qryUnitsOfMeasure, memqryUnitsOfMeasure);
end;

procedure TUnitsOfMeasureGUI.qryUnitsOfMeasureMultiplierChange(Sender: TField);
begin
  inherited;
  if fbformshowing then exit;
  cboUnitOfMeasure.Visible := (qryUnitsOfMeasureMultiplier.AsFloat <> 1);
  Label4.Visible := (qryUnitsOfMeasureMultiplier.AsFloat <> 1);
  if qryUnitsOfMeasureMultiplier.asfloat =1 then begin
    qryUnitsOfMeasureBaseUnitName.AsString:= '';
    qryUnitsOfMeasureBaseUnitID.AsInteger := 0;
  end;
end;

procedure TUnitsOfMeasureGUI.FormCreate(Sender: TObject);
begin
  fbSaveClicked := False;
  fbformshowing := true;
  inherited;
  fiProductID := 0;
  UserLock.Enabled := true;
end;

procedure TUnitsOfMeasureGUI.qryUnitsOfMeasureBaseUnitNameChange(
  Sender: TField);
begin
  inherited;
  if fbformshowing then exit;
  if qryUnitsOfMeasureBaseUnitID.Value <> qrycboUnitOfMeasureUnitID.Value then
    qryUnitsOfMeasureBaseUnitID.Value := qrycboUnitOfMeasureUnitID.Value;
end;

function TUnitsOfMeasureGUI.IsUnique: boolean;
Var qry : TERPQuery;
begin
  result := false;
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := MyConnection;
    qry.SQL.Text :=
     'SELECT UnitName'+
     ' FROM tblUnitsOfMeasure'+
     ' WHERE ifnull(PartID,0) = :xPartID AND Active = "T" AND UnitName = :xUnitName AND UnitID <> :xUnitID';
    qry.ParamByName('xUnitName').AsString := qryUnitsOfMeasureUnitName.AsString;
    qry.ParamByName('xPartID').AsInteger := qryUnitsOfMeasurePartID.AsInteger;
    qry.ParamByName('xUnitID').AsInteger := qryUnitsOfMeasureUnitID.AsInteger;
    qry.Open;
    if qry.RecordCount = 0 then
      Result := true;
  finally
    if Assigned(qry) then
      FreeAndNil(qry);
  end;
end;

procedure TUnitsOfMeasureGUI.ProductUnitDefault(const bMode: Boolean);
begin
  SalesDefault.Enabled := bMode;
  lblSalesDefault.Enabled := bMode;
  PurchasesDefault.Enabled := bMode;
  lblPurchasesDefault.Enabled := bMode;
end;

procedure TUnitsOfMeasureGUI.qryUnitsOfMeasurePartIDChange(Sender: TField);
begin
  inherited;
  if fbformshowing then exit;
  If qryUnitsOfMeasure.Active then
    ProductUnitDefault(qryUnitsOfMeasurePartID.AsInteger<>0);

  qrycboUnitOfMeasure.Close;
  qrycboUnitOfMeasure.ParamByName('xPartID').AsInteger := qryUnitsOfMeasurePartID.AsInteger;
  qrycboUnitOfMeasure.Open;
  cboUnitOfMeasure.Clear;
  qryUnitsOfMeasureBaseUnitName.Clear;
end;

procedure TUnitsOfMeasureGUI.cboPartsChange(Sender: TObject);
begin
  inherited;
  if fbformshowing then exit;
  If Empty(cboParts.text) AND qryUnitsOfMeasure.Active then begin
    If EditNoAbort(qryUnitsOfMeasure) then
      qryUnitsOfMeasurePartID.AsInteger := 0;
      qryUnitsOfMeasureSalesDefault.AsString := 'F';
      qryUnitsOfMeasurePurchasesDefault.AsString := 'F';
  end;
  if qryUnitsOfMeasurebaseUnitName.asString <> '' then
    qryUnitsOfMeasureBaseUnitID.AsInteger := TUnitOfMeasure.initBaseUnitId(qryUnitsOfMeasurebaseUnitName.asString , 1, qryUnitsOfMeasurePartID.AsInteger , 0 , TERPConnection(qryUnitsOfMeasure.Connection));
end;

procedure TUnitsOfMeasureGUI.qryUnitsOfMeasureBeforePost(DataSet: TDataSet);
var
    ErrMsg :STring;
begin
  inherited;
    qryUnitsOfMeasureUnitProductKeyName.asString := qryUnitsOfMeasureUnitNAme.asString +':' ;
    if qryUnitsOfMeasurePartID.asInteger <> 0 then qryUnitsOfMeasureUnitProductKeyName.asString := qryUnitsOfMeasureUnitProductKeyName.asString  +qryPartsPartname.asString;

    if (qryUnitsOfMeasureUnitID.asInteger > 0) and (KeyID<> 0) then
        if qryUnitsOfMeasureActive.AsBoolean = False then begin
            if  RecordinUse(ErrMsg) then begin
                // errmsg here has the list of tables where the current record is in use
                // but as the table name doesn;t make any sense to the user, not' displaying it.
                errMsg := 'This record can''t be made inactive as it is already used in other areas-'+chr(13)+errMsg;
                CommonLib.MessageDlgXP_Vista(ErrMsg , mtWarning , [mbOk] , 0);
                qryUnitsOfMeasureActive.Asboolean := True;
                Exit;
            End;
            with CommonDbLib.TempMyQuery do try
              SQL.add(SQL4ProductAvailableQty(0 , qryUnitsOfMeasureUnitName.asString));
              open;
              if recordcount > 0 then begin
                errmsg := '';
                  first;
                  While Eof = False do begin
                    if ((qryUnitsOfMeasurePartID.AsInteger = 0) or (qryUnitsOfMeasurePartID.AsInteger = FieldByName('PartsID').AsInteger)) and
                    ((fieldByname('Qty').asfloat <> 0) or (fieldByname('UOMQty').asfloat <> 0)) then begin
                      if errmsg <> '' then errmsg := errmsg +chr(13);
                      errMsg := errmsg + '      ' +fieldByname('Partname').asString;
                    end;
                    Next;
                  end;
                if errMsg <> '' then begin
                  errmsg := 'This record can''t be made inactive as Has Avaialble Stock For The Following Products:' +chr(13) +chr(13) +errmsg;
                  CommonLib.MessageDlgXP_Vista(ErrMsg , mtWarning , [mbOk] , 0);
                  qryUnitsOfMeasureActive.Asboolean := True;
                  Exit;
                end;
              end;
            finally
                if active then close;
                free;
            end;
        End;
end;

procedure TUnitsOfMeasureGUI.cboUnitOfMeasureCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if qryUnitsOfMeasurebaseUnitName.asString <> '' then
      qryUnitsOfMeasureBaseUnitID.AsInteger := TUnitOfMeasure.initBaseUnitId(qryUnitsOfMeasurebaseUnitName.asString , 1, qryUnitsOfMeasurePartID.AsInteger , 0, TERPConnection(qryUnitsOfMeasure.Connection));
end;

procedure TUnitsOfMeasureGUI.cboUnitOfMeasureNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
begin
//  inherited;
  Accept := false;
end;

procedure TUnitsOfMeasureGUI.cboPartsDblClick(Sender: TObject);
begin
//  inherited;

end;

procedure TUnitsOfMeasureGUI.UpdateGlobalRefs;
var cmd: TERPCommand;
begin
  cmd:= TERPCommand.Create(nil);
  try
    cmd.Connection:= self.MyConnection;
    cmd.SQL.Add('update tblunitsofmeasure set globalref = concat(' +
    QuotedStr(AppEnv.Branch.SiteCode) + ',unitid)');
    cmd.SQL.Add('where IsNull(globalref) or (globalref = "")');
    cmd.Execute;
  finally
    cmd.Free;
  end;
end;


procedure TUnitsOfMeasureGUI.KeyIdChanged(const NewKeyId: integer);
begin
  inherited;
  if UserLock.Enabled and (AccessLevel < 5) then begin
    // remove all existing locks
    UserLock.UnlockAllCurrentInstance;

    if (KeyId > 0) then begin
      if not UserLock.Lock('tblunitsofmeasure',KeyId,Self.Caption) then begin
        AccessLevel:= 5; // read only

        CommonLib.MessageDlgXP_Vista(UserLock.LockMessage+#13+#10+#13+#10+'Access has been changed to read-only.', mtWarning, [mbOK], 0);
      end else begin


      end;
    end;
  end;

end;

procedure TUnitsOfMeasureGUI.qryUnitsOfMeasureHeightChange(Sender: TField);
begin
  inherited;
  EditDB(qryUnitsOfMeasure);
  qryUnitsOfMeasureVolume.asfloat:=
    Round(qryUnitsOfMeasureHeight.asfloat *
    qryUnitsOfMeasureWidth.asfloat *
    qryUnitsOfMeasureLength.asfloat,GeneralRoundPlaces);
end;

procedure TUnitsOfMeasureGUI.setdimensions;
begin
      lblDimension.caption  := 'Dimension  in  ' +appenv.CompanyPrefs.UOMVolumeDimensionUOM;
      lblvolumeUOM.caption  := appenv.CompanyPrefs.UOMVolumeDimensionUOM;
      lblvolumeUOM1.top     := lblvolumeUOM.top - 3;
      lblvolumeUOM1.Left    := lblvolumeUOM.Left + lblvolumeUOM.width+1;
      lblWeightUOM.Caption  := appenv.CompanyPrefs.UOMWeightUOM;
end;

initialization
  RegisterClassOnce(TUnitsOfMeasureGUI);
  with FormFact do begin
    RegisterMe(TUnitsOfMeasureGUI, 'TUnitsOfMeasureListGUI_*=UnitID');
    RegisterMe(TUnitsOfMeasureGUI, 'TUnitsOfMeasuresummaryListGUI_*=UnitID');
    RegisterMe(TUnitsOfMeasureGUI, 'TUOMListGUI_*=ListUOMID');
    RegisterMe(TUnitsOfMeasureGUI, 'TUOMProductListGUI_PurchaseUOM=PurchaseUOMID');
    RegisterMe(TUnitsOfMeasureGUI, 'TUOMProductListGUI_SalesUOM=SalesUOMID');
    RegisterMe(TUnitsOfMeasureGUI, 'TUnitsOfMeasuresList_*=UnitID');
    RegisterControl(TUnitsOfMeasureGUI, '*_cboUnitOfMeasure=UnitID');
    RegisterControl(TUnitsOfMeasureGUI, '*_cboSalesUOM=UnitID');
  end;
end.
