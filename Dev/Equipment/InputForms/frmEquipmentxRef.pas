unit frmEquipmentxRef;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess,ERPdbComponents, StdCtrls,
  wwdblook, DNMSpeedButton, Buttons, Wwdbigrd, Grids, Wwdbgrid, Menus,
  AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  DNMPanel, BusObjEquipment, ImgList, Wwmemo, ProgressDialog, wwdbdatetimepicker, JSONObject;

const
  lkfields :Array [1..9, 1..3] of string= (('EquipmentName'     ,'EquipName'        , 'tString'   ),
                                           ('Model'             ,'model'            , 'tString'   ),
                                           ('Manufacture'       ,'Manufacture'      , 'tString'   ),
                                           ('Registration'      ,'Registration'     , 'Tstring'   ),
                                           ('Serialno'          ,'Serialno'         , 'tString'   ),
                                           ('WarantyFinishDate' ,'WarantyFinishDate', 'Tdatetime' ),
                                           ('WarantyStartDate'  ,'WarantyStartDate' , 'Tdatetime' ),
                                           ('WarantyPeriod'     ,'WarantyPeriod'    , 'tFloat'    ),
                                           ('Notes'             ,'Notes'            , 'tString'   ));

type

  TfmEquipmentxRef = class(TBaseInputGUI)
    cboEquipmentLookup: TERPQuery;
    cboEquipmentLookupEquipName: TWideStringField;
    cboEquipmentLookupmodel: TWideStringField;
    cboEquipmentLookupRegistration: TWideStringField;
    cboEquipmentLookupSerialno: TWideStringField;
    cboEquipmentLookupManufacture: TWideStringField;
    cboEquipmentLookupDescription: TWideStringField;
    cboEquipmentLookupEquipmentID: TIntegerField;
    cboEquipmentLookupWarantyPeriod: TFloatField;
    cboEquipmentLookupWarantyFinishDate: TDateTimeField;
    cboEquipmentLookupID: TIntegerField;
    dsEquipmentxRefs: TDataSource;
    pnlFooter: TDNMPanel;
    btnSave: TDNMSpeedButton;
    AdvPopupMenu1: TAdvPopupMenu;
    MenuItem1: TMenuItem;
    grdEquip: TwwDBGrid;
    cboEquipname: TwwDBLookupCombo;
    qryUnitOfMeasure: TERPQuery;
    qryUnitOfMeasureUnitID: TIntegerField;
    qryUnitOfMeasureUnitName: TWideStringField;
    qryUnitOfMeasureUnitDescription: TWideStringField;
    qryUnitOfMeasureMultiplier: TFloatField;
    qryUnitOfMeasureBaseUnitName: TWideStringField;
    cboUnitOfMeasure: TwwDBLookupCombo;
    cboEquipmentLookupProductId: TLargeintField;
    EquipNotesDialog1: TwwMemoDialog;
    grdEquipIButton: TwwIButton;
    cboEquipmentLookupWarantyStartDate: TDateTimeField;
    cboEquipmentLookupActive: TWideStringField;
    cboEquipmentLookupNotes: TWideMemoField;
    cboRepairFault: TwwDBLookupCombo;
    dtNextServiceDate: TwwDBDateTimePicker;
    tmrQLDRegisteredVehiclecheck: TTimer;
    mmnuQLDRegoCheck: TMenuItem;
    procedure cboEquipmentNameCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure FormShow(Sender: TObject);
    procedure cboEquipmentNameDropDown(Sender: TObject);
    procedure cboEquipmentNameNotInList(Sender: TObject;
      LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
    procedure grdEquipmentCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure grdEquipmentCalcTitleAttributes(Sender: TObject;
      AFieldName: String; AFont: TFont; ABrush: TBrush;
      var ATitleAlignment: TAlignment);
    procedure grdEquipmentExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure cboEquipnameDblClick(Sender: TObject);
    procedure grdEquipRowChanged(Sender: TObject);
    procedure grdEquipDblClick(Sender: TObject);
    procedure grdEquipIButtonClick(Sender: TObject);
    procedure grdEquipEnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EquipNotesDialog1UserButton1Click(Dialog: TwwMemoDlg;      Memo: TMemo);
    procedure cboRepairFaultNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: string; var Accept: Boolean);
    procedure cboRepairFaultDblClick(Sender: TObject);
    procedure tmrQLDRegisteredVehiclecheckTimer(Sender: TObject);
    procedure popCustomiseGridPopup(Sender: TObject);
    procedure DoQLDRegoCheck(Sender: TObject);

  private
    FEquipmentxRef: TEquipmentxRef;
    fLastComboText: string;
    fiClientId: Integer;
    jsonQLDRegoCheck:TJsonObject;
    procedure setclientId(const Value: Integer);
    Procedure SetGridColumns;
    Procedure RefreshUnitsQry;
    function Getclientform(attachtoObserver:Boolean; var Msg:String):TBaseInputGUI;
    procedure checkForQLDRegisteredVehicle;
    procedure ShowProgress(Sender: TObject);
    procedure DoSelectEquipment;

  Protected

  public
    Property  EquipmentxRef  : TEquipmentxRef  Read  FEquipmentxRef Write FEquipmentxRef;
    Property  ClientID         : Integer         Read  fiClientId       Write setclientId;
    procedure UpdateMe(const Canceled: Boolean; const aObject: TObject = nil);override;
    Procedure RefreshEquipmentLookup;
    class function  CreateEquipmentxRef(AOwner:TComponent; fDataset:TDataset; readonly :Boolean = False ; readonlymsg:String = ''; const fiClientId :Integer = 0; const itag :Integer = 99; FormbeforeShow:TNotifyEvent=nil):TfmEquipmentxRef;
  end;


implementation

uses CommonLib, frmCustomerFrm, BusObjClient, FastFuncs, AppEnvironment,
  frmRepairs, CommonDbLib, tcDataUtils, frmJob, frmSimpleTypes,
  tcconst, frmQLDTransRegoCheck, GridLib;

{$R *.dfm}

procedure TfmEquipmentxRef.cboEquipmentNameCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if Modified = false then Exit;
  inherited;
  DoSelectEquipment;
end;

procedure TfmEquipmentxRef.ShowProgress(Sender:TObject);
var
  x:Integer;
begin
  if sender is TfmQLDTransRegoCheck then begin
    if TfmQLDTransRegoCheck(Sender).BrowserProgresslevel = 4 then begin
        if jsonQLDRegoCheck.Count > 0 then
          for x:= 0 to jsonQLDRegoCheck.Count -1 do begin
            with jsonQLDRegoCheck.Items[x].Value.AsObject do begin
                   if sametext(S['Name'] , QLDVehiclefields[1]) then
              else if sametext(S['Name'] , QLDVehiclefields[2]) then EquipmentxRef.VehicleRego_IDNo         := S['Value']
              else if sametext(S['Name'] , QLDVehiclefields[3]) then EquipmentxRef.VehicleRego_Description  := S['Value']
              else if sametext(S['Name'] , QLDVehiclefields[4]) then EquipmentxRef.VehicleRego_PurposeOfUse := S['Value']
              else if sametext(S['Name'] , QLDVehiclefields[5]) then EquipmentxRef.VehicleRego_Status       := S['Value']
              else if sametext(S['Name'] , QLDVehiclefields[6]) then EquipmentxRef.VehicleRego_Expiry       := Dt['Value'];
            end;
          end;
        if EquipmentxRef.VehicleRego_IDNo ='' then
          MessageDlgXP_Vista('Registration not found', mtWarning, [mbOK], 0);
       jsonQLDRegoCheck.Free;
    end;
    StepProgressbar(TfmQLDTransRegoCheck(Sender).ProgressStatus);
    //try ProgressDialogInst.top := TfmQLDTransRegoCheck(Sender).top+TfmQLDTransRegoCheck(Sender).height; except end;
  end else StepProgressbar;
end;
procedure TfmEquipmentxRef.tmrQLDRegisteredVehiclecheckTimer(Sender: TObject);
begin
  inherited;
  ShowProgress(Sender);
end;
procedure TfmEquipmentxRef.checkForQLDRegisteredVehicle;
begin
  if EquipmentxRef.CustomerEquipmentID =0 then exit;
  if not EquipmentxRef.isQLDRegisteredVehicle then Exit;
  jsonQLDRegoCheck:=JO;
  try
      showProgressbar(WAITMSG, 10);
      try
        ProgressDialogInst.top := ProgressDialogInst.top +200;
        tmrQLDRegisteredVehiclecheck.Enabled := true;
        TfmQLDTransRegoCheck.CheckRego(self, EquipmentxRef.Rego, ShowProgress , jsonQLDRegoCheck);
      finally
        tmrQLDRegisteredVehiclecheck.Enabled:= False;
        //SleepUntilFormshown('TfmQLDTransRegoCheck');
        HideProgressbar;
      end;
  finally
    //jsonQLDRegoCheck.Free;
  end;
end;

procedure TfmEquipmentxRef.FormShow(Sender: TObject);
begin
  grdEquip.SetControlType('EquipmentName' ,fctLookupCombo ,'cboEquipname'  );
  grdEquip.SetControlType('UOM' ,fctLookupCombo ,'cboUnitOfMeasure'  );
  grdEquip.SetControlType('Onsite', fctCheckBox, 'T;F');
  grdEquip.SetControlType('NextServiceDate', fctCustom, 'dtNextServiceDate');
  if grdEquip.Datasource.DataSet.Findfield('Repairfault') <> nil then
    grdEquip.SetControlType('Repairfault' ,fctLookupCombo ,'cboRepairFault'  )
  else cboRepairFault.visible := false;
  with dsEquipmentxREfs.Dataset do begin
    TField(Findfield('Model')).ReadOnly             := true;
    TField(Findfield('Serialno')).ReadOnly          := true;
    TField(Findfield('Registration')).ReadOnly      := true;
    TField(Findfield('WarantyPeriod')).ReadOnly     := true;
    TField(Findfield('Manufacture')).ReadOnly       := true;
    TField(Findfield('WarantystartDate')).ReadOnly  := true;
    TField(Findfield('WarantyFinishDate')).ReadOnly := true;
    //TField(Findfield('Notes')).ReadOnly             := true;
  end;

  GuiPrefs.Active := True;
  {binny:for the personal tabstop to work, otherwise in the grid, tab takes to next record instead of next column}
  try
    inherited;
  finally
    btnSave.Enabled := true;
  end;
  cboEquipmentLookup.ParamByName('ClientId').asInteger :=ClientID;
  OpenDB(cboEquipmentLookup);
  if AppEnv.CompanyPrefs.CodeHeader <> '' then
      grdEquip.ColumnByName('Code').DisplayLabel := AppEnv.CompanyPrefs.CodeHeader;
  if not assigned(EquipmentxRef) then begin
      CommonLib.MessageDlgXP_Vista('Properties not set properly, the data cannot be changed' , mtInformation, [mbOK],0);
      grdEquip.ReadOnly := True;
      Exit;
  end;
  SetGridColumns;
  SetControlFocus(cboEquipname);
end;
procedure TfmEquipmentxRef.cboEquipmentNameDropDown(Sender: TObject);
begin
  inherited;
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
  fLastComboText := TwwDBLookupCombo(Sender).Text;
end;
procedure TfmEquipmentxRef.DoQLDRegoCheck(Sender: TObject);
var
  form : TBaseInputGUI;
  Msg:String;
  fiEquipId:Integer;
begin
    with dsEquipmentxREfs.Dataset do
      if (Findfield('CustomerEquipmentId')             = nil) or
         (FieldbyName('CustomerEquipmentId').asInteger =0 ) or
         (Findfield('Registration')                    = nil) or
         (FieldbyName('Registration').asString         ='') then begin
          MessageDlgXP_Vista('Please Choose a QLD Registered Vehicle to check the Registration', mtInformation, [mbOK], 0);
          exit;
      end;

  with dsEquipmentxREfs.Dataset do begin
    if (Findfield('CustomerEquipmentId') <> nil) and (FieldbyName('CustomerEquipmentId').asInteger >0) then begin
      if  (Findfield('Registration') = nil) or (FieldbyName('Registration').asString = '') then begin
        MessageDlgXP_Vista('The Equipment doesn''t have a Registration Number.', mtWarning, [mbOK], 0);
        Exit;
      end;
          fiEquipId:=EquipIdForCustomerEquipmentId(FieldbyName('CustomerEquipmentId').asInteger);
          if fiEquipId >0 then begin
              if not tcdatautils.isQLDRegisteredVehicle(fiEquipId) then
                  if not EquipmentxRef.Userlock.lock('tblequipment' ,fiEquipId ) then begin
                    MessageDlgXP_Vista('Selected Equipment is not a QLD Registered Vehicle.', mtInformation, [mbOK], 0);
                    exit;
                  end else if MessageDlgXP_Vista('Selected Equipment is not a QLD Registered Vehicle.'+NL+NL+'Do You Wish to Flag it as a QLD Registered Vehicle? ', mtConfirmation, [mbYes, mbNo], 0) = mryes then
                    EquipmentxRef.ExecuteSQL('update tblequipment Set isQLDRegisteredVehicle  ="T" Where EquipmentID = ' + inttostr(fiEquipId) , true)
                  else exit;
              checkForQLDRegisteredVehicle;
          end;
    end;
  end;
end;
procedure TfmEquipmentxRef.DoSelectEquipment;
begin
  EquipmentxRef.CustomerEquipmentid := cboEquipmentLookupID.asInteger;
  EquipmentxRef.Description :=cboEquipmentLookupDescription.asString;
  EquipmentxRef.Notes:= cboEquipmentLookupNotes.asString;
  EquipmentxRef.Quantity := 1;
  checkForQLDRegisteredVehicle;
  RefreshUnitsQry;
end;

procedure TfmEquipmentxRef.cboEquipmentNameNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
var
  form : TBaseInputGUI;
  Msg:String;
  MsgOption :Word;
begin
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
  fLastComboText := TwwDBLookupCombo(Sender).Text;
  form := getclientform(true,Msg);
  if not(Assigned(Form)) then begin
    MessageDlgXP_Vista('Equipmment Can be Only Created for Job and Client. ' + getClientName(Self.clientID)  +' is a ' +Msg+'.', mtInformation , [mbok],0);
    Accept := False;
    exit;
  end;
  MsgOption := CommonLib.MessageDlgXP_Vista('Selection NOT in list, Create New?',mtConfirmation, [], 0, nil, '' , '' , False, nil, 'New Equipment,New Rego,Cancel' );
  if MsgOption = 102 then exit;
  if MsgOption  = 100 then begin
    if form is TfrmCustomer then TfrmCustomer(form).EquipmenttoAdd:= NewValue
    else if form is TJobGUI then TJobGUI(form).EquipmenttoAdd:= NewValue;
  end else if MsgOption = 101 then begin
    if form is TfrmCustomer then TfrmCustomer(form).RegotoAdd:= NewValue
    else if form is TJobGUI then TJobGUI(form).RegotoAdd:= NewValue;
  end else begin
    Exit;
  end;
  form.Showmodal;

  Accept := False;
end;

procedure TfmEquipmentxRef.UpdateMe(const Canceled: Boolean;
  const aObject: TObject);
begin
  inherited;
  if Canceled then begin
  end
  else if fLastComboAccessed= nil then begin
  end
  else if Sysutils.SameText(fLastComboAccessed.Name, 'cboEquipname') then begin
    closenOpenDB(cboEquipname.Lookuptable);
//      if not cboEquipname.Lookuptable.Locate(cboEquipname.LookupField, cboEquipname.Text, [loCaseInsensitive])  then
    if cboEquipname.Lookuptable.Locate('EquipName', fLastComboText, [loCaseInsensitive]) then begin
      DoSelectEquipment;
    end
    else
      NotInListWarning(fLastComboAccessed);
  end;
end;

procedure TfmEquipmentxRef.grdEquipmentCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if (TwwDBGrid(Sender).Datasource.Dataset.FieldbyName('WarantyStartDate').AsDateTime > 0) and
    (TwwDBGrid(Sender).Datasource.Dataset.FieldbyName('WarantyFinishDate').AsDateTime > 0) and
    (TwwDBGrid(Sender).Datasource.Dataset.FieldbyName('WarantyStartDate').AsDateTime <= now) and
    (TwwDBGrid(Sender).Datasource.Dataset.FieldbyName('WarantyFinishDate').AsDateTime >= now) then
//    ABrush.Color:= clRed;
    ABrush.Color:= $00C6C6FF//clRed //$008888FF;
  else if Field.ReadOnly then
    Afont.Color := clInactiveCaption;
end;

procedure TfmEquipmentxRef.grdEquipmentCalcTitleAttributes(
  Sender: TObject; AFieldName: String; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  inherited;
  if assigned(TwwDBGrid(Sender).Datasource.Dataset) then
    if TwwDBGrid(Sender).Datasource.Dataset.Findfield(AFieldName) <> nil then
      if TwwDBGrid(Sender).Datasource.Dataset.Findfield(AFieldName).REadonly then
        AFont.color := clInactiveCaption;
end;

procedure TfmEquipmentxRef.grdEquipmentExit(Sender: TObject);
begin
  inherited;
  EquipmentxRef.PostDB;
end;

procedure TfmEquipmentxRef.setclientId(const Value: Integer);
begin
  fiClientId := Value;
  if cboEquipmentLookup.ParamByName('ClientId').asInteger <> Value then begin
    closeDb(cboEquipmentLookup);
    cboEquipmentLookup.ParamByName('ClientId').asInteger :=ClientID;
  end;
end;

procedure TfmEquipmentxRef.FormCreate(Sender: TObject);
begin
  AllowCustomiseGrid := True;
  inherited;
  UseDefaultColor := False;
    fbTabSettingEnabled := false;
  if Self.Owner is TBaseInputGUI then Self.Color := TBaseInputGUI(Self.Owner).Color;
  (*if Assigned(grdEquip.PopupMenu) then begin
    NewMenuItem('QLD Rego Check' , DoQLDRegoCheck , False,  grdEquip.PopupMenu , '');
  end;*)
end;

procedure TfmEquipmentxRef.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
  else  inherited;
end;

procedure TfmEquipmentxRef.FormPaint(Sender: TObject);
begin
  inherited;
  grdEquip.SizeLastColumn;
end;

class function TfmEquipmentxRef.CreateEquipmentxRef(AOwner: TComponent;fDataset: TDataset; readonly :Boolean = False  ; readonlymsg:String = ''; const fiClientId :Integer = 0; const itag :Integer = 99; FormbeforeShow:TNotifyEvent=nil):TfmEquipmentxRef;
var
  form:TfmEquipmentxRef;
  index:Integer;
  factive:Boolean;
  sfld:TWideStringField;
  dFld:TDateTimeField;
  fFld:TFloatField;
  fld :Tfield;
begin
  form := TfmEquipmentxRef(GetComponentByClassName('TfmEquipmentxRef' , false, AOwner, False));
  form.tag := itag;
  form.ClientID := fiClientId;
  fActive := fDataset.active;
  if fDataset.active then  fDataset.close;
  try
    for index := Low(lkfields) to high(lkfields) do begin
      if fDataset.Findfield( lkfields[index, 1]) = nil then begin
        fld := nil;
        if Sysutils.SameText(lkfields[index, 3], 'tString') then begin
          sFld                   := TWideStringField.create(fDataset);
          fld:=sfld;
          fld.Size              := 100;
        end else if Sysutils.SameText(lkfields[index, 3], 'tDateTime') then begin
          dFld                   := TDateTimeField.create(fDataset);
          fld:=dfld;
        end else if Sysutils.SameText(lkfields[index, 3], 'tfloat') then begin
          fFld                   := TFloatField.create(fDataset);
          fld:=ffld;
        end;
        if fld<> nil then begin
          fld.FieldName         := lkfields[index, 1];
          fld.name              := fDataset.name + lkfields[index, 1];
          fld.FieldKind         := fkLookup;
          fld.KeyFields         := 'CustomerEquipmentID';
          fld.LookupDataset     := form.cboEquipmentLookup;
          fld.LookupKeyFields   := 'ID';
          fld.LookupResultField := lkfields[index, 2];
          fld.ReadOnly          := not Sysutils.SameText(lkfields[index, 1] , 'EquipmentName');
          fld.Dataset           := fDataset;
        end;
      end else begin
        fDataset.Findfield( lkfields[index, 1]).KeyFields         := 'CustomerEquipmentID';
        fDataset.Findfield( lkfields[index, 1]).LookupDataset     := form.cboEquipmentLookup;
        fDataset.Findfield( lkfields[index, 1]).LookupKeyFields   := 'ID';
        fDataset.Findfield( lkfields[index, 1]).LookupResultField := lkfields[index, 2];
      end;
    end;
  finally
      if factive then fDataset.open;
  end;
  if fDataset.Findfield('WarantyStartDate') <> nil then
    TDateTimeField(fDataset.Findfield('WarantyStartDate')).DisplayFormat := FormatSettings.ShortDateformat;
  if fDataset.Findfield('WarantyFinishDate') <> nil then
    TDateTimeField(fDataset.Findfield('WarantyFinishDate')).DisplayFormat := FormatSettings.ShortDateformat;


  form.dsEquipmentxRefs.DataSet := fDataset;
  if form.cboEquipmentLookup.active then form.cboEquipmentLookup.close;
  form.cboEquipmentLookup.connection := TERPQuery(fDataset).connection;
  form.cboEquipmentLookup.open;
  if readonly then begin
     Form.AccessLevel := 5;
     form.Caption := Readonlymsg
  end;
  if Assigned(FormbeforeShow) then FormbeforeShow(Form);
  Result := Form;
end;

procedure TfmEquipmentxRef.EquipNotesDialog1UserButton1Click(Dialog: TwwMemoDlg; Memo: TMemo);
begin
  inherited;
  Memo.Lines.add(formatDatetime(FormatSettings.ShortdateFormat, date));
end;

procedure TfmEquipmentxRef.btnSaveClick(Sender: TObject);
begin
  inherited;
  EquipmentxRef.PostDB;
  Self.close;
end;

procedure TfmEquipmentxRef.SetGridColumns;
begin
  GuiPrefs.DbGridElement[grdEquip].HideField('globalref');
  GuiPrefs.DbGridElement[grdEquip].HideField('ID');
  GuiPrefs.DbGridElement[grdEquip].HideField('RepairID');
  GuiPrefs.DbGridElement[grdEquip].HideField('editedflag');
  GuiPrefs.DbGridElement[grdEquip].HideField('saleId');
  GuiPrefs.DbGridElement[grdEquip].HideField('CustomerEquipmentId');
  GuiPrefs.DbGridElement[grdEquip].HideField('Qty');
  GuiPrefs.DbGridElement[grdEquip].HideField('CreationDate');
  GuiPrefs.DbGridElement[grdEquip].HideField('updateDate');
  GuiPrefs.DbGridElement[grdEquip].HideField('uomid');
  GuiPrefs.DbGridElement[grdEquip].HideField('uommultiplier');
  GuiPrefs.DbGridElement[grdEquip].HideField('invoiceID');
  GuiPrefs.DbGridElement[grdEquip].HideField('AppointmentID');
  GuiPrefs.DbGridElement[grdEquip].HideField('mstimeStamp');
  GuiPrefs.DbGridElement[grdEquip].HideField('onsite');
  GuiPrefs.DbGridElement[grdEquip].HideField('UOM');
  GuiPrefs.DbGridElement[grdEquip].HideField('Repairfault');
end;

procedure TfmEquipmentxRef.cboEquipnameDblClick(Sender: TObject);
var
  form : TfrmCustomer;
begin
  inherited;
  form :=TfrmCustomer(GetComponentByClassName('TfrmCustomer', True, self));
  if not assigned(form) then Exit;
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
  fLastComboText := TwwDBLookupCombo(Sender).Text;
  if form.Visible then begin
    if Form.KeyID <> Self.ClientID then begin
      CommonLib.MessageDlgXP_Vista('The Customer form is already opened, please close it to open it for ' + TClient.IDToggle(clientID) +' and create more equipment' , mtInformation , [mbOk] , 0);
      Exit;
    end else begin
      form.AttachObserver(Self);
    end;
  end else begin
    form.AttachObserver(Self);
    form.KeyId :=Self.ClientID;
    form.FormStyle := fsMDIChild;
  end;
  form.BringToFront;
  form.LocateEquip(EquipmentxRef.CustomerEquipmentid);
end;

procedure TfmEquipmentxRef.cboRepairFaultDblClick(Sender: TObject);
begin
  inherited;
  TfmSimpleTypes.DoSimpleTypesEdit(SimpleTypes_RepairFault, grdEquip.datasource.dataset.FieldbyName('Repairfault').AsString);
end;

procedure TfmEquipmentxRef.cboRepairFaultNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('Selection NOT in list, Create New?', mtconfirmation, [mbyes, mbno], 0) = mrYes then begin
    TfmSimpleTypes.DoSimpleTypesAddNew(SimpleTypes_RepairFault, NewValue);
    closenopendb(cboRepairFault.LookupTable);
    if cboRepairFault.LookupTable.Locate('Name', NewValue, []) then begin
           editDb(grdEquip.datasource.dataset);
           grdEquip.datasource.dataset.FieldbyName('Repairfault').AsString :=NewValue;
           PostDB(grdEquip.datasource.dataset);
           Accept:= True;
    end else begin
      Accept:= False;
    end;
  end;
end;

procedure TfmEquipmentxRef.RefreshUnitsQry;
begin
  closedb(qryUnitOfMeasure);
  if cboEquipname.Lookuptable.FieldbyName('ID').asInteger<>
     grdEquip.datasource.dataset.FieldbyName('CustomerEquipmentid').asInteger then
    cboEquipname.Lookuptable.Locate('ID',grdEquip.datasource.dataset.FieldbyName('CustomerEquipmentid').asInteger , []);
  qryUnitOfMeasure.ParamByName('xPartID').AsInteger := cboEquipname.Lookuptable.FieldbyName('ProductID').asInteger;
  OpenDB(qryUnitOfMeasure);
end;

procedure TfmEquipmentxRef.grdEquipRowChanged(Sender: TObject);
begin
  inherited;
  RefreshUnitsQry;
end;

procedure TfmEquipmentxRef.popCustomiseGridPopup(Sender: TObject);
begin
  inherited;
(*  mmnuQLDRegoCheck.visible :=sametext(GridLib.ActiveFieldName(grdEquip) ,'Registration');
  if mmnuQLDRegoCheck.visible then
    with dsEquipmentxREfs.Dataset do
      mmnuQLDRegoCheck.Enabled := (Findfield('CustomerEquipmentId')             <> nil) and
                                  (FieldbyName('CustomerEquipmentId').asInteger >0 ) and
                                  (Findfield('Registration')                    <> nil) and
                                  (FieldbyName('Registration').asString         <> '');*)
end;


procedure TfmEquipmentxRef.grdEquipDblClick(Sender: TObject);
var
  form :TBaseInputGUI;
  Msg:String;
begin
  inherited;

   (*if (grdEquip.GetActiveField.FieldName = 'Notes') then begin
      if EquipNotesDialog1.Execute then begin
        EditDB(grdEquip.datasource.dataset);
        PostDB(grdEquip.datasource.dataset);
      end;
   end else *)if (Sysutils.SameText(grdEquip.GetActiveField.FieldName , 'WarantystartDate' )) or
              (Sysutils.SameText(grdEquip.GetActiveField.FieldName , 'WarantyfinishDate' )) or
              (Sysutils.SameText(grdEquip.GetActiveField.FieldName , 'Notes' )) or
              (Sysutils.SameText(grdEquip.GetActiveField.FieldName , 'WarantyPerod' )) then begin
    form := getclientform(False, msg);
    if not(Assigned(Form)) then exit;
    if form is TfrmCustomer then TfrmCustomer(form).DefaultTab:= 'Equipment'
    else if form is TJobGUI then TJobGUI(form).DefaultTab:= 'Equipment';
    form.showmodal;
    closedb(cboEquipname.Lookuptable);
    openDB(cboEquipname.Lookuptable);
    if cboEquipname.Lookuptable.Locate('ID', dsEquipmentxREfs.dataset.FieldbyName('customerEquipmentID').asInteger , []) then begin
       cboEquipmentNameCloseUp(cboEquipname , cboEquipname.Lookuptable ,dsEquipmentxREfs.dataset , true);
    end;;
   end;
end;

procedure TfmEquipmentxRef.grdEquipIButtonClick(Sender: TObject);
begin
  inherited;
  if (grdEquip.datasource.Dataset.state <> dsInsert) and (grdEquip.datasource.Dataset.recordcount = 0 ) then Exit;
  if CommonLib.MessageDlgXP_Vista('Do you wish to delete this record? ' , mtConfirmation , [mbyes, mbno] , 0) =mryes then begin
    if grdEquip.datasource.Dataset.State = dsInsert then grdEquip.datasource.Dataset.cancel
    else grdEquip.datasource.Dataset.delete;
  end;
end;



procedure TfmEquipmentxRef.RefreshEquipmentLookup;
begin
  closeDb(cboEquipmentLookup);
  OpenDb(cboEquipmentLookup);

end;

procedure TfmEquipmentxRef.grdEquipEnter(Sender: TObject);
begin
  inherited;
  grdEquip.SelectedIndex := 0;
end;


function TfmEquipmentxRef.Getclientform(attachtoObserver:Boolean; var Msg:String): TBaseInputGUI;
var
  ct:TtClienttype;
  form :TBaseInputGUI;
  function formname:String;
  begin
    result := '';
         if ct = TtCustomer then result := 'Customer'
    else if ct = ttjob then result := 'Job'
    else if ct = TtSupplier then result := 'Supplier';
  end;
begin
  result := nil;
  Msg:= '';
  ct:= Clienttype(Self.ClientID);
  form := nil;
  if ct = ttCustomer then begin
    if FormStillOpen('TfrmCustomer') then begin
      TForm(FindExistingComponent('TfrmCustomer')).Close;
      Application.ProcessMessages;
    end;
    if FormStillOpen('TfrmCustomer') then begin
      MessageDlgXP_Vista('The Customer form is already opened, please close it and try again.', mtInformation , [mbOk] , 0);
      exit;
    end;
    form :=TBaseInputGUI(GetComponentByClassName('TfrmCustomer', True , self));
    Msg := 'Customer';
  end else if ct = ttJob then begin
    if FormStillOpen('TJobGUI') then begin
      TForm(FindExistingComponent('TJobGUI')).Close;
      Application.ProcessMessages;
    end;
    if FormStillOpen('TJobGUI') then begin
      MessageDlgXP_Vista('The Job form is already opened, please close it and try again.', mtInformation , [mbOk] , 0);
      exit;
    end;
    form :=TBaseInputGUI(GetComponentByClassName('TJobGUI', True, self));
    Msg := 'Job';
  end else if ct = ttSupplier then begin Msg := 'Supplier';
  end else if ct = ttOthercontact then begin Msg := 'Prospect';
  end else if ct = ttOthercontact then begin Msg := 'unknown';
  end;


  if not assigned(form) then Exit;
  if form.Visible then begin
      if Form.KeyID <> Self.ClientID then begin
        CommonLib.MessageDlgXP_Vista('The ' +formname +' form is already opened, please close it to open it for ' + TClient.IDToggle(clientID) +' and create more equipment' , mtInformation , [mbOk] , 0);
        Exit;
      end else begin
        if attachtoObserver then
          form.AttachObserver(Self);
      end;
  end else begin
    if attachtoObserver then
          form.AttachObserver(Self);
    form.KeyId :=Self.ClientID;
  end;
  result := Form;
end;

initialization
  RegisterClassOnce(TfmEquipmentxRef);

end.
