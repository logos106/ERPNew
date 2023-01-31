unit frmClientEquipment;

interface

Uses TypesLib, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, BaseFormForm, wwdbdatetimepicker, StdCtrls, wwdblook, Buttons, Wwdbigrd, Grids, Wwdbgrid, ExtCtrls, DNMPanel,
  DB, MemDS, DBAccess, MyAccess, ERPdbComponents, BaseInputForm, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, BusObjBase,
  ActnList, DNMSpeedButton, BusObjClient, wwmemo, DBCtrls, ProgressDialog, ERPDbLookupCombo, pngimage, wwradiogroup,
  wwclearbuttongroup;

type
  TfmClientEquipment = class(TBaseInputGUI)
    qryEquip: TERPQuery;
    qryEquipDescription: TWideStringField;
    qryEquipNotes: TWideMemoField;
    qryEquipid: TAutoIncField;
    qryEquipEquipmentID: TIntegerField;
    qryEquipClientID: TIntegerField;
    qryEquipGlobalRef: TWideStringField;
    qryEquipManufacture: TWideStringField;
    qryEquipModel: TWideStringField;
    qryEquipSerialno: TWideStringField;
    qryEquipRegistration: TWideStringField;
    qryEquipWarantyPeriod: TFloatField;
    qryEquipWarantyFinishDate: TDateTimeField;
    qryEquipEquipName: TWideStringField;
    qryEquipUOM: TWideStringField;
    qryEquipUOMID: TLargeintField;
    qryEquipUOMMultiplier: TFloatField;
    qryEquipUOMQty: TFloatField;
    qryEquipQuantity: TFloatField;
    qryEquipWarantyStartDate: TDateTimeField;
    DSCustomerEquipment: TDataSource;
    cboEquipmentLookup: TERPQuery;
    cboEquipmentLookupEquipmentName: TWideStringField;
    cboEquipmentLookupEquipmentDescription: TWideStringField;
    cboEquipmentLookupEquipmentID: TIntegerField;
    cboEquipmentLookupProductID: TLargeintField;
    cboEquipmentLookupModel: TWideStringField;
    cboEquipmentLookupManufacture: TWideStringField;
    CustEquipDNMPanel: TDNMPanel;
    cboEquipment: TERPDBLookupCombo;
    cboUnitOfMeasure: TwwDBLookupCombo;
    dtEquipWarrantyFinishDate: TwwDBDateTimePicker;
    EquipNotesDialog1: TwwMemoDialog;
    qryUnitOfMeasure: TERPQuery;
    qryUnitOfMeasureUnitName: TWideStringField;
    qryUnitOfMeasureUnitID: TIntegerField;
    qryUnitOfMeasureUnitDescription: TWideStringField;
    qryUnitOfMeasureMultiplier: TFloatField;
    qryUnitOfMeasureBaseUnitName: TWideStringField;
    grdEquipment: TwwDBGrid;
    grdEquipmentIButton: TwwIButton;
    qryEquipActive: TWideStringField;
    Panel2: TPanel;
    grpFilters: TwwRadioGroup;
    pnlButtons: TPanel;
    qryEquipCUSTFLD1: TWideStringField;
    qryEquipCUSTFLD2: TWideStringField;
    qryEquipCUSTFLD3: TWideStringField;
    qryEquipCUSTFLD4: TWideStringField;
    qryEquipCUSTFLD5: TWideStringField;
    qryEquipCUSTFLD6: TWideStringField;
    qryEquipCUSTFLD7: TWideStringField;
    qryEquipCUSTFLD8: TWideStringField;
    qryEquipCUSTFLD9: TWideStringField;
    qryEquipCUSTFLD10: TWideStringField;
    btnHistory: TDNMSpeedButton;
    btnTransfer: TDNMSpeedButton;
    ActionList: TActionList;
    actHistory: TAction;
    actTransferEquipment: TAction;
    pnlright: TDNMPanel;
    qryEquipStreetMap: TBlobField;
    qryEquipBuildingMap: TBlobField;
    report1n2: TSplitter;
    qryEquipmsTimeStamp: TDateTimeField;
    qryEquipmsUpdateSiteCode: TWideStringField;
    qryEquipServiceDueDate: TDateTimeField;
    qryEquipStreetMaptype: TWideStringField;
    qryEquipBuildingMaptype: TWideStringField;
    pnlStreet: TDNMPanel;
    Label1: TLabel;
    imgStreet: TImage;
    pnlStreetType: TDNMPanel;
    DBText1: TDBText;
    Label3: TLabel;
    pnlBuilding: TDNMPanel;
    Label4: TLabel;
    imgBuilding: TImage;
    pnlBuildingType: TDNMPanel;
    DBText3: TDBText;
    Label6: TLabel;
    qryEquipService: TWideStringField;
    qryEquipCurrent: TWideStringField;
    procedure grdEquipment1CalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdEquipment1CalcTitleAttributes(Sender: TObject; AFieldName: string; AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
    procedure grdEquipment1ColEnter(Sender: TObject);
    procedure grdEquipment1DblClick(Sender: TObject);
    procedure grdEquipment1Exit(Sender: TObject);
    procedure grdEquipment1RowChanged(Sender: TObject);
    procedure cboEquipmentCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure cboEquipmentExit(Sender: TObject);
    (*procedure cboEquipmentNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);*)
    procedure qryEquipAfterScroll(DataSet: TDataSet);
    procedure qryEquipBeforePost(DataSet: TDataSet);
    procedure qryEquipNewRecord(DataSet: TDataSet);
//    procedure qryEquipPostError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
    procedure btnDeleteDetailsClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cboEquipmentEnter(Sender: TObject);
    procedure cboUnitOfMeasureEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qryEquipAfterPost(DataSet: TDataSet);
    procedure WarrantyInfoChanged(Sender: TField);
    procedure grdEquipmentCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdEquipmentCalcTitleAttributes(Sender: TObject; AFieldName: string; AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
    procedure grdEquipmentColEnter(Sender: TObject);
    procedure grdEquipmentDblClick(Sender: TObject);
    procedure grdEquipmentExit(Sender: TObject);
    procedure grdEquipmentRowChanged(Sender: TObject);
    procedure qryEquipAfterInsert(DataSet: TDataSet);
    procedure grpFiltersClick(Sender: TObject);
    procedure grdEquipmentIButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actHistoryExecute(Sender: TObject);
    procedure actTransferEquipmentExecute(Sender: TObject);
    procedure ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure EquipNotesDialog1UserButton1Click(Dialog: TwwMemoDlg;
      Memo: TMemo);
    procedure imgStreetDblClick(Sender: TObject);
    procedure imgBuildingDblClick(Sender: TObject);
    procedure cboEquipmentLookupBeforeOpen(DataSet: TDataSet);
    procedure qryEquipAfterOpen(DataSet: TDataSet);
  private
    bEquipIsNewRecord: Boolean;
    ficlientID: Integer;
    fTransconn: TERPConnection;
    fUpdateClientObj: TGeneralProc;
    DoFieldChange: Boolean;
    NewEquipname:String;
    RegotoAdd :String;
    fCustomerEquipment: TCustomerEquipment;

    procedure RefreshUnitsQry;
    Function OpenEquipform(const Value: string):boolean;

    procedure setclientID(const Value: Integer);
//    function getCustEquipId(const EquipmentID: Integer; const Manufacture, Model, Registration, Serialno: string): Integer;
    procedure setTransconn(const Value: TERPConnection);
    procedure EquipmentBeforeshow(Sender: TObject);
    function REcordEmpty: boolean;
    procedure RefreshPic(DataSet: TDataSet);
    procedure cboCustomerBeforeOpenList(Sender: TObject);
    procedure selectcustomer(Sender: TwwDbGrid);
    procedure OnSelectEquip(Sender: TwwDbGrid);
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    (* procedure CustomFieldsRefresh; override;
      procedure CustomFieldRefreshExtra(const CustomfieldPrefix: string; const ctr: Integer); override; *)
  public

    procedure UpdateMe(const Cancelled: Boolean; const aObject: TObject = nil); override;
    procedure onOpen;
    procedure newEquip(const Value: string);
    procedure newRego(const Value: string);
    procedure LocateEquip(const customerEquipID: Integer);
    class function Newform(ClientID: Integer; Transconn: TERPConnection; AOwner: TComponent; AParent: Twincontrol; UpdateClientObj: TGeneralProc): TfmClientEquipment;
    property ClientID: Integer read ficlientID write setclientID;
    property Transconn: TERPConnection read fTransconn write setTransconn;
    property UpdateClientObj: TGeneralProc read fUpdateClientObj write fUpdateClientObj;
    function Save: Boolean;
    function canceldb: Boolean;
    Property CustomerEquipment :TCustomerEquipment read fCustomerEquipment ;
  end;

implementation

uses FastFuncs, AppEnvironment, CommonLib, (*frmEquipmentFrm, *)CommonDbLib, DNMLib, dAteUtils,
  CommonFormLib, BaseListingForm, BusObjConst, frmCustomerEquipmentTransfer,
  frmEquip , ImagesLib, BusObjPicture, tcConst, tcDataUtils;

{$R *.dfm}

procedure TfmClientEquipment.grdEquipment1CalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if (SysUtils.SameText(Field.fieldname, 'Manufacture')) or (SysUtils.SameText(Field.fieldname, 'Model')) then AFont.Color := clInactiveCaption;
end;

procedure TfmClientEquipment.grdEquipment1CalcTitleAttributes(Sender: TObject; AFieldName: string; AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
begin
  inherited;
  if (SysUtils.SameText(AFieldName, 'Manufacture')) or (SysUtils.SameText(AFieldName, 'Model')) then AFont.Color := clInactiveCaption;

end;

procedure TfmClientEquipment.grdEquipment1ColEnter(Sender: TObject);
begin
  inherited;
  if SameText(TField(grdEquipment.GetActiveField).fieldname, 'UOM') then
    if cboEquipmentLookupProductID.asInteger = 0 then grdEquipment.SetActiveField('UOMQty');

end;

procedure TfmClientEquipment.grdEquipment1DblClick(Sender: TObject);
begin
  inherited;
  if (grdEquipment.GetActiveField.fieldname = 'Notes') then begin
    if (not AppEnv.CompanyPrefs.EnforceNoModifyonNotes) or bEquipIsNewRecord then begin
      if EquipNotesDialog1.Execute then begin
        EditDB(qryEquip);
        PostDB(qryEquip);
      end;
    end;
  end;

end;

procedure TfmClientEquipment.grdEquipment1Exit(Sender: TObject);
begin
  inherited;
  PostDB(grdEquipment.DataSource.DataSet);

end;

procedure TfmClientEquipment.grdEquipment1RowChanged(Sender: TObject);
begin
  inherited;
  RefreshUnitsQry;

end;

procedure TfmClientEquipment.cboEquipmentCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
  EditDB(FillTable);
  qryEquipEquipName.AsString := cboEquipmentLookupEquipmentName.AsString;
  qryEquipDescription.AsString := cboEquipmentLookupEquipmentDescription.AsString;
  qryEquipEquipmentID.asInteger := cboEquipmentLookupEquipmentID.asInteger;
  qryEquipModel.AsString := cboEquipmentLookupModel.AsString;
  qryEquipManufacture.AsString := cboEquipmentLookupManufacture.AsString;
  PostDB(FillTable);
  RefreshUnitsQry;
end;

procedure TfmClientEquipment.cboEquipmentExit(Sender: TObject);
begin
  inherited;
  PostDB(grdEquipment.DataSource.DataSet);
end;

procedure TfmClientEquipment.cboEquipmentLookupBeforeOpen(DataSet: TDataSet);
begin
  inherited;
end;

(*procedure TfmClientEquipment.cboEquipmentNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
var
  option: Word;
begin
  inherited;
  option := MessageDlgXP_Vista('This equipment is not in the list.' + chr(13) + chr(13) + 'Do you wish to create this equipment?', mtConfirmation, [mbYes, mbCancel], 0, nil, '', '', False, nil);
  if option = mrYes then OpenEquipform(NewValue);
    { if OpenEquipform(NewValue) then begin
      Lookuptable.Close;
      LookupTable.Open;
      Accept := LookupTable.Locate('Equipmentname' , NewValue, []);
    end; }
end;*)

procedure TfmClientEquipment.RefreshPic(DataSet: TDataSet);
begin
  ImagesLib.RefreshDsImage(DataSet, 'StreetMap', 'StreetMaptype' , imgStreet,  pnlStreet , pnlStreetType);
  ImagesLib.RefreshDsImage(DataSet, 'BuildingMap', 'BuildingMaptype' , imgBuilding,  pnlBuilding , pnlBuildingType);
end;

procedure TfmClientEquipment.RefreshUnitsQry;
begin
  if qryUnitOfMeasure.active then qryUnitOfMeasure.close;
  if cboEquipmentLookup.active then
    if cboEquipmentLookupEquipmentID.asInteger <> qryEquipEquipmentID.asInteger then cboEquipmentLookup.Locate('EquipmentID', qryEquipEquipmentID.asInteger, []);
  qryUnitOfMeasure.ParamByName('xPartID').asInteger := cboEquipmentLookupProductID.asInteger;
  if qryUnitOfMeasure.active = False then qryUnitOfMeasure.open;
end;

procedure TfmClientEquipment.qryEquipAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if qryEquip.State in [dsInsert] then begin
    bEquipIsNewRecord := true;
  end else begin
    bEquipIsNewRecord := False;
  end;
  RefreshPic(dataset);
end;

procedure TfmClientEquipment.EquipmentBeforeshow(Sender:TObject);
begin
  if not(Sender is tfmEquip) then exit;
  tfmEquip(Sender).AttachObserver(Self);
  tfmEquip(Sender).NewName := NewEquipname;
end;

procedure TfmClientEquipment.EquipNotesDialog1UserButton1Click(
  Dialog: TwwMemoDlg; Memo: TMemo);
begin
  inherited;
  if Memo.Lines.Count > 0 then
    Memo.Lines[Memo.Lines.Count -1] := Memo.Lines[Memo.Lines.Count -1] + ' ' + DateToStr(Now)
  else
    Memo.Lines.Add(DateToStr(Now))
end;

Function TfmClientEquipment.OpenEquipform(const Value: string):Boolean;
begin
  fLastComboAccessed := cboEquipment;
  NewEquipname:= Value;
  REsult := OpenERPFormModal('tfmEquip' , 0, EquipmentBeforeshow)>=0;
  (* var
  frmToPopUp: TBaseInputGUI;
begin
  frmToPopUp := TfrmEquipment(GetComponentByClassName('TfrmEquipment'));
  frmToPopUp.AttachObserver(Self);
  Processingcursor(True);
  try
    TfrmEquipment(frmToPopUp).NewName := Value;
    TForm(frmToPopUp).ShowModal
  finally
    Processingcursor(False);
  end; *)
end;

procedure TfmClientEquipment.newEquip(const Value: string);
begin
  if not(qryEquip.Locate('Equipname', Value, [loCaseInsensitive])) then begin
    cboEquipment.TExt := Value;   {to refresh the equipment query with the equipment searching}
    cboEquipment.F6Search;
    if not(cboEquipmentLookup.Locate('EquipmentName', Value, [loCaseInsensitive])) then begin
      fLastComboAccessed := cboEquipment;
      qryEquip.append;
      qryEquip.FieldByName('EquipName').AsString := Value;
      OpenEquipform(Value);
    end else begin
      qryEquip.append;
      qryEquip.FieldByName('EquipName').AsString := Value;
      cboEquipmentCloseUp(cboEquipment, cboEquipment.LookupTable, grdEquipment.DataSource.DataSet, true);
      grdEquipment.SetActiveField('quantity');
    end;
  end;
end;
procedure TfmClientEquipment.OnSelectEquip(Sender: TwwDbGrid);
var
  CustomerEquipmentcopy: TCustomerEquipment;
begin
  if not (sender is TwwDBGrid) then exit;
  if TwwDBGrid(Sender).DataSource.DataSet.FindField('EquipmentId') = nil then exit;
  if TwwDBGrid(Sender).DataSource.DataSet.FindField('EquipmentId').AsInteger =0 then exit;

  if not tcdatautils.isQLDRegisteredVehicle(TwwDBGrid(Sender).DataSource.DataSet.FindField('EquipmentId').AsInteger) then
    if not fCustomerEquipment.Userlock.lock('tblequipment' ,TwwDBGrid(Sender).DataSource.DataSet.FindField('EquipmentId').AsInteger ) then
      MessageDlgXP_Vista('Selected Equipment is not a QLD Registered Vehicle.', mtInformation, [mbOK], 0)
    else if MessageDlg('Selected Equipment is not a QLD Registered Vehicle.'+NL+NL+'Do You Wish to Flag it as a QLD Registered Vehicle? ', mtConfirmation, [mbYes, mbNo], 0) = mryes then
      fCustomerEquipment.ExecuteSQL('update tblequipment Set isQLDRegisteredVehicle  ="T" Where EquipmentID = ' + inttostr(TwwDBGrid(Sender).DataSource.DataSet.FindField('EquipmentId').AsInteger) , true);



  fCustomerEquipment.new;
  fCustomerEquipment.EquipmentId :=TwwDBGrid(Sender).DataSource.DataSet.FindField('EquipmentId').AsInteger;
  fCustomerEquipment.clientId := Self.ClientID;
  fCustomerEquipment.Registration := RegotoAdd;
  fCustomerEquipment.postdb;

  (*fCustomerEquipment.Connection.BeginNestedTransaction;
  try
      CustomerEquipmentcopy:= TCustomerEquipment.Create(nil);
      try
        CustomerEquipmentcopy.Connection:= fCustomerEquipment.Connection;
        CustomerEquipmentcopy.Load(0);
        fCustomerEquipment.ObjInstanceToClone := CustomerEquipmentcopy;

        fCustomerEquipment.CloneBusObj('EquipmentId',TwwDBGrid(Sender).DataSource.DataSet.FindField('EquipmentId').AsInteger,false);
        CustomerEquipmentcopy.EquipmentID :=   TwwDBGrid(Sender).DataSource.DataSet.FindField('EquipmentId').AsInteger;
        CustomerEquipmentcopy.Active:= true;
        CustomerEquipmentcopy.PostDB;

        MessageDlgXP_Vista('Equipment ' + quotedstr(CustomerEquipmentcopy.EquipName) +' is transfererd to '+NL+
                           'Customer '+ quotedstr(CustomerEquipmentcopy.ClientName)+' and '+NL +
                        ' is made inactive for '+ quotedstr(fCustomerEquipment.ClientName)+'.', mtInformation, [mbOK], 0);
        fCustomerEquipment.Active := False;
        fCustomerEquipment.IsTransferingtoAnotehrclient := true;
        fCustomerEquipment.PostDB;

        fCustomerEquipment.Connection.CommitNestedTransaction;
        qryEquip.Close;
        qryEquip.Open;
      finally
        Freeandnil(CustomerEquipmentcopy);
        fCustomerEquipment.ObjInstanceToClone := nil;
      end;
  Except
    on E:Exception do begin
      MessageDlgXP_vista('Equipment Transfer Failed' + NL+  E.Message, mtWarning, [mbOK], 0);
      fCustomerEquipment.Connection.RollbackNestedTransaction;
    end;
  end;*)
end;
procedure TfmClientEquipment.newRego(const Value: string);
begin
  if not(qryEquip.Locate('Registration', Value, [loCaseInsensitive])) then begin
    RegotoAdd := Value;
    OpenERPListFormSingleselectModal('TEquipmentListGUI' , OnSelectEquip, nil , true);
  end;
end;
class function TfmClientEquipment.Newform(ClientID: Integer; Transconn: TERPConnection; AOwner: TComponent; AParent: Twincontrol; UpdateClientObj: TGeneralProc): TfmClientEquipment;
var
  Form: TComponent;
begin
  result := nil;
  Form := GetComponentByClassName('TfmClientEquipment', False, AOwner, False);
  if not assigned(Form) then Exit;
  result := TfmClientEquipment(Form);
  TfmClientEquipment(Form).Parent := AParent;
  TfmClientEquipment(Form).ClientID := ClientID;
  TfmClientEquipment(Form).Transconn := Transconn;
  TfmClientEquipment(Form).onOpen;
  TfmClientEquipment(Form).UpdateClientObj := UpdateClientObj;
  TfmClientEquipment(Form).show;
end;

procedure TfmClientEquipment.setclientID(const Value: Integer);
begin
  ficlientID := Value;
  if qryEquip.active then qryEquip.close;
  qryEquip.ParamByName('xclientId').asInteger := Value;
  fCustomerEquipment.LoadSelect('ClientID =' + inttostr(Value));
end;

procedure TfmClientEquipment.qryEquipBeforePost(DataSet: TDataSet);
begin
  inherited;
  if qryEquipSerialno.AsString <> '' then qryEquipQuantity.asInteger := 1; // serial no is for one item
  if REcordEmpty then begin
      qryEquip.Cancel;
      abort;
  end;
(*   if qryEquipEquipmentID.asInteger = 0 then begin
    if qryEquip.state = dsInsert then qryEquip.cancel
    else begin
      MessageDlgXP_Vista('Please Select the Equipment', mtWarning, [mbOK], 0);
      abort;
    end;
  end; *)
end;

procedure TfmClientEquipment.qryEquipNewRecord(DataSet: TDataSet);
begin
  inherited;
  qryEquip.FieldByName('ClientID').asInteger := ClientID;
end;

//procedure TfmClientEquipment.qryEquipPostError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
//var
//  CustEquipId: Integer;
//  str: string;
//begin
//  CustEquipId := getCustEquipId(qryEquipEquipmentID.asInteger, qryEquipManufacture.AsString, qryEquipModel.AsString, qryEquipRegistration.AsString, qryEquipSerialno.AsString);
//  if CustEquipId <> qryEquipid.asInteger then str := 'This Equipment already exists for the customer '
//  else str := 'Unknown error occured while posting the Equipment ';
//  str := str + chr(13) + 'Equipment Name : ' + qryEquipEquipName.AsString + chr(13) + 'Manufature     : ' + qryEquipManufacture.AsString + chr(13) + 'Model#         : ' + qryEquipModel.AsString +
//    chr(13) + 'Registration   : ' + qryEquipRegistration.AsString + chr(13) + 'Serial#        : ' + qryEquipSerialno.AsString + chr(13) + chr(13) + 'Please select a different combination .';
//  CommonLib.MessageDlgXP_Vista(str, mtInformation, [mbOK], 0);
//  Action := daAbort;
//
//end;

//function TfmClientEquipment.getCustEquipId(const EquipmentID: Integer; const Manufacture, Model, Registration, Serialno: string): Integer;
//begin
//  result := 0;
//  with CommonDbLib.TempMyQuery do
//    try
//      connection := qryEquip.connection;
//      SQL.add('select Id from tblcustomerequip ');
//      SQL.add('WHERE  EquipmentID = ' + IntToStr(EquipmentID));
//      SQL.add('AND  Manufacture = ' + Quotedstr(Manufacture));
//      SQL.add('AND  Model = ' + Quotedstr(Model));
//      SQL.add('AND  Registration = ' + Quotedstr(Registration));
//      SQL.add('AND  Serialno = ' + Quotedstr(Serialno));
//      SQL.add('AND  clientID = ' + IntToStr(ClientID));
//      open;
//      if recordcount = 0 then Exit;
//      result := FieldByName('ID').asInteger;
//    finally
//      if active then close;
//      Free;
//    end;
//
//end;

procedure TfmClientEquipment.LocateEquip(const customerEquipID: Integer);
begin
  qryEquip.Locate('ID', customerEquipID, []);
end;

procedure TfmClientEquipment.setTransconn(const Value: TERPConnection);
var
  ctr: Integer;
begin
  fTransconn := Value;
  for ctr := 0 to ComponentCount - 1 do
    if Components[ctr] is TERPQuery then begin
      if TERPQuery(Components[ctr]).active then TERPQuery(Components[ctr]).close;
      TERPQuery(Components[ctr]).connection := Value;
    end;
  fCustomerEquipment.Connection.Connection:= Value;
end;

procedure TfmClientEquipment.onOpen;
var
  ctr: Integer;
begin
  for ctr := 0 to ComponentCount - 1 do
    if Components[ctr] is TERPQuery then begin
      if TERPQuery(Components[ctr]).active = False then TERPQuery(Components[ctr]).open;
    end;
  { forces assignment of forms query to business object }
  fCustomerEquipment.Dataset;
end;

function TfmClientEquipment.Save: Boolean;
begin
  result:= fCustomerEquipment.ValidateDataList;
  if result then
    result:= fCustomerEquipment.Save;

//  result := False;
//
//  if qryEquip.active then
//    if not(qryEquip.State in [dsBrowse]) then begin
//      qryEquip.Post;
//      result := true;
//    end;
end;

procedure TfmClientEquipment.actHistoryExecute(Sender: TObject);
var
  ListForm: TBaseListingGUI;
begin
  inherited;
  CreateHistorylistForm('TRepairListEquipment' ,Self, ListForm);
  ListForm.FilterString:= 'EquipmentID = ' + self.qryEquipEquipmentID.AsString;
  ListForm.FormStyle:= fsMDIChild;
end;

procedure TfmClientEquipment.ActionListUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  self.actHistory.Enabled:= not qryEquip.IsEmpty;
  self.actTransferEquipment.Enabled:= (not qryEquip.IsEmpty) and (AccessLevel = 1);
end;
procedure TfmClientEquipment.selectcustomer(Sender: TwwDbGrid);
var
  CustomerEquipmentcopy: TCustomerEquipment;
begin
  if not (sender is TwwDBGrid) then exit;
  if TwwDBGrid(Sender).DataSource.DataSet.FindField('clientID') = nil then exit;
  if TwwDBGrid(Sender).DataSource.DataSet.FindField('clientID').AsInteger =0 then exit;
  fCustomerEquipment.Connection.BeginNestedTransaction;
  try
      CustomerEquipmentcopy:= TCustomerEquipment.Create(nil);
      try
        CustomerEquipmentcopy.Connection:= fCustomerEquipment.Connection;
        CustomerEquipmentcopy.Load(0);
        fCustomerEquipment.ObjInstanceToClone := CustomerEquipmentcopy;

        fCustomerEquipment.CloneBusObj('ClientID',TwwDBGrid(Sender).DataSource.DataSet.FindField('clientID').AsInteger,false);
        CustomerEquipmentcopy.clientID :=   TwwDBGrid(Sender).DataSource.DataSet.FindField('clientID').AsInteger;
        CustomerEquipmentcopy.Active:= true;
        CustomerEquipmentcopy.PostDB;

        MessageDlgXP_Vista('Equipment ' + quotedstr(CustomerEquipmentcopy.EquipName) +' is transfererd to '+NL+
                           'Customer '+ quotedstr(CustomerEquipmentcopy.ClientName)+' and '+NL +
                        ' is made inactive for '+ quotedstr(fCustomerEquipment.ClientName)+'.', mtInformation, [mbOK], 0);
        fCustomerEquipment.Active := False;
        fCustomerEquipment.IsTransferingtoAnotehrclient := true;
        fCustomerEquipment.PostDB;

        fCustomerEquipment.Connection.CommitNestedTransaction;
        qryEquip.Close;
        qryEquip.Open;
      finally
        Freeandnil(CustomerEquipmentcopy);
        fCustomerEquipment.ObjInstanceToClone := nil;
      end;
  Except
    on E:Exception do begin
      MessageDlgXP_vista('Equipment Transfer Failed' + NL+  E.Message, mtWarning, [mbOK], 0);
      fCustomerEquipment.Connection.RollbackNestedTransaction;
    end;
  end;
end;

procedure TfmClientEquipment.cboCustomerBeforeOpenList(Sender: TObject);
begin
  inherited;
  TBaseListingGUI(Sender).FilterString:= 'ClientID <> ' +  inttostr(fCustomerEquipment.ClientID)+ ' and Active = "T"';
  TBaseListingGUI(Sender).TimerMsg(TBaseListingGUI(Sender).FilterLabel , 'Please Choose the customer to Transfer the equipment to' , 20);
end;
procedure TfmClientEquipment.actTransferEquipmentExecute(Sender: TObject);
begin
  inherited;
  PostDB(qryEquip);
  if qryEquipActive.asBoolean =False then begin
    MessageDlgXP_vista('You cannot transfer an inactive Equipment', mtWarning, [mbOK], 0);
    Exit;
  end;
  OpenERPListFormultiselectModal('TCustomerExpressListGUI' ,cboCustomerBeforeOpenList , selectcustomer );

(*  if frmCustomerEquipmentTransfer.DoCustomerEquipmentTransfer(qryEquipid.AsInteger, TMyConnection(qryEquip.Connection)) then begin
    qryEquip.Close;
    qryEquip.Open;
  end;*)
end;

procedure TfmClientEquipment.btnDeleteDetailsClick(Sender: TObject);
begin
  inherited;
  DeleteRecord(qryEquip);
end;

function TfmClientEquipment.canceldb: Boolean;
begin
  result := False;
  if qryEquip.active then
    if qryEquip.State in [dsEdit, dsInsert] then begin
      qryEquip.Cancel;
      result := true;
    end;
end;

procedure TfmClientEquipment.FormDestroy(Sender: TObject);
begin
  GuiPrefs.Node['Options.verticalsplit'].asInteger := pnlright.Width ;
  Parent := nil;
  inherited;
end;

procedure TfmClientEquipment.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  else inherited;
end;

procedure TfmClientEquipment.FormShow(Sender: TObject);
begin
  inherited;
  if clientId =0 then fCustomerEquipment.load;
  CustomFieldRefresh('CFCust', CustEquipDNMPanel);
  GuiPrefs.DbGridElement[grdEquipment].RemoveField(qryEquipUOMID.FieldName);
  GuiPrefs.DbGridElement[grdEquipment].RemoveField(qryEquipGlobalRef.FieldName);
  GuiPrefs.DbGridElement[grdEquipment].RemoveField(qryEquipID.FieldName);
  GuiPrefs.DbGridElement[grdEquipment].RemoveField(qryEquipEquipmentID.FieldName);
  GuiPrefs.DbGridElement[grdEquipment].RemoveField(qryEquipclientID.FieldName);
  GuiPrefs.DbGridElement[grdEquipment].RemoveField(qryEquipStreetMap.FieldName);
  GuiPrefs.DbGridElement[grdEquipment].RemoveField(qryEquipBuildingMap.FieldName);
  GuiPrefs.DbGridElement[grdEquipment].RemoveField(qryEquipmsTimeStamp.FieldName);
  GuiPrefs.DbGridElement[grdEquipment].RemoveField(qryEquipmsUpdateSiteCode.FieldName);
end;

procedure TfmClientEquipment.UpdateMe(const Cancelled: Boolean; const aObject: TObject = nil);
begin
  inherited;
  if Cancelled then begin
    if SysUtils.SameText(fLastComboAccessed.Name, 'cboEquipment') then begin
      if qryEquip.State in [dsEdit, dsInsert] then qryEquip.Cancel;
    end;
  end else begin
    if assigned(fUpdateClientObj) then UpdateClientObj;
    if aObject is TBaseInputGUI then else Exit;
    if SysUtils.SameText(fLastComboAccessed.Name, 'cboEquipment') and Assigned(aObject) and (aObject is TfmEquip) then begin
      with fLastComboAccessed do begin
        LookupTable.close;
        if Text = '' then
          Text := TfmEquip(aObject).newName;
        LookupTable.open;
        (* LookupTable.Locate('EquipmentID', TBaseInputGUI(Form).KeyID, []);
        if not(qryEquip.State in [dsEdit, dsInsert]) then qryEquip.Edit;
        qryEquip.FieldByName('ClientID').asInteger := ficlientID;
        qryEquip.FieldByName('EquipmentID').asInteger := LookupTable.FieldByName('EquipmentID').asInteger;
        qryEquip.FieldByName('Description').AsString := LookupTable.FieldByName('EquipmentDescription').AsString; *)

        if LookupTable.Locate('EquipmentName', TfmEquip(aObject).newName, [loCaseInsensitive]) then begin
          if not(qryEquip.State in [dsEdit, dsInsert]) then qryEquip.Edit;
          qryEquip.FieldByName('ClientID').asInteger := ficlientID;
          qryEquip.FieldByName('EquipmentID').asInteger := LookupTable.FieldByName('EquipmentID').asInteger;
          qryEquip.FieldByName('Description').AsString := LookupTable.FieldByName('EquipmentDescription').AsString;
          cboEquipmentCloseUp(fLastComboAccessed, LookupTable, qryEquip, true);
        end else begin
          if qryEquip.State in [dsEdit, dsInsert] then qryEquip.Cancel;
        end;
      end
    end;
  end;
end;

procedure TfmClientEquipment.cboEquipmentEnter(Sender: TObject);
begin
  inherited;
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
end;

procedure TfmClientEquipment.cboUnitOfMeasureEnter(Sender: TObject);
begin
  inherited;
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
end;

procedure TfmClientEquipment.imgBuildingDblClick(Sender: TObject);
begin
  inherited;
  DisableForm;
  try
    SelectPicture(TpotCustomerEquipment,self, qryEquip , qryEquipid.fieldname, qryEquipBuildingMap.FieldName, False, qryEquipBuildingMapType.FieldName);
    PostDB(qryEquip);
  finally
    EnableForm;
    application.ProcessMessages;
  end;

end;

procedure TfmClientEquipment.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TCustomerEquipment then
      TCustomerEquipment(Sender).DataSet:= qryEquip;
  end
end;

(* procedure TfmClientEquipment.CustomFieldRefreshExtra(const CustomfieldPrefix: string; const ctr: Integer);
  var
  comp: TComponent;
  begin
  inherited;
  comp := FindComponent('qryEquip' + 'CUSTFLD' + Trim(IntToStr(ctr)));
  if assigned(comp) and (comp is TField) then begin
  TField(comp).displayLabel := QryCustomField.FieldByName('CFLabel' + Trim(IntToStr(ctr))).AsString;
  TField(comp).Readonly := not(QryCustomField.FieldByName(CustomfieldPrefix + Trim(IntToStr(ctr))).AsString = 'T');
  end;
  end; *)

(* procedure TfmClientEquipment.CustomFieldsRefresh;
  begin
  inherited;
  CustomFieldRefresh('CFCust', CustEquipDNMPanel);
  end; *)

procedure TfmClientEquipment.FormCreate(Sender: TObject);
var
  x:Integer;
begin
  RegotoAdd := '';
  AllowCustomiseGrid := true;
  inherited;
  fUpdateClientObj := nil;
  DoFieldChange := true;
  fbTabSettingEnabled := False;
  GuiPrefs.active := true;
  x := GuiPrefs.Node['Options.verticalsplit'].asInteger;  if x<=0 then x:= 267;  pnlright.width := x;
  fCustomerEquipment:= TCustomerEquipment.Create(self);
  fCustomerEquipment.Connection := TMyDacDataConnection.Create(fCustomerEquipment);
  fCustomerEquipment.Connection.MyDacConnection := MyConnection;
  fCustomerEquipment.BusObjEvent := DoBusinessObjectEvent;
end;
function TfmClientEquipment.RecordEmpty:boolean;
begin
    if (qryEquipDescription.asString = '') and (qryEquipNotes.asString = '') and
      (qryEquipEquipmentID.asInteger =0) and
      (qryEquipManufacture.asString = '') and
      (qryEquipModel.asString = '') and
      (qryEquipSerialno.asString = '') and
      (qryEquipRegistration.asString = '') and
      (qryEquipWarantyPeriod.asFloat =0) and
      (qryEquipWarantyFinishDate.asDatetime =0) and
      (qryEquipEquipName.asString = '')  then
        result := True else Result := False;
end;
procedure TfmClientEquipment.qryEquipAfterPost(DataSet: TDataSet);
begin
  inherited;
  if REcordEmpty then begin
    try
      if qryEquipActive.asBoolean = False then Exit;
      EditDB(qryEquip);
      qryEquipActive.asBoolean := False;
      PostDB(qryEquip);
    finally
      qryEquip.Refresh;
    end;
  end;
  RefreshPic(dataset);
  if assigned(fUpdateClientObj) then UpdateClientObj;
end;

procedure TfmClientEquipment.WarrantyInfoChanged(Sender: TField);
begin

  inherited;
  if not DoFieldChange then Exit;
  DoFieldChange := False;
  try
    if (SysUtils.SameText(Sender.fieldname, 'WarantyfinishDate')) then begin
      qryEquipWarantyFinishDate.asDatetime := DateOf(qryEquipWarantyFinishDate.asDatetime);
      if qryEquipWarantyStartDate.asDatetime <> 0 then qryEquipWarantyPeriod.asFloat := MonthsBetween(qryEquipWarantyFinishDate.asDatetime, qryEquipWarantyStartDate.asDatetime);
    end
    else if (SysUtils.SameText(Sender.fieldname, 'WarantyStartDate')) then begin
      qryEquipWarantyStartDate.asDatetime := DateOf(qryEquipWarantyStartDate.asDatetime);
      if qryEquipWarantyFinishDate.asDatetime <> 0 then qryEquipWarantyPeriod.asFloat := MonthsBetween(qryEquipWarantyFinishDate.asDatetime, qryEquipWarantyStartDate.asDatetime);
    end
    else if (SysUtils.SameText(Sender.fieldname, 'WarantyPeriod')) then begin
      try
        if qryEquipWarantyStartDate.asDatetime <> 0 then qryEquipWarantyFinishDate.asDatetime := IncMonth(qryEquipWarantyStartDate.asDatetime, System.round(qryEquipWarantyPeriod.asFloat))
        else if qryEquipWarantyFinishDate.asDatetime <> 0 then qryEquipWarantyStartDate.asDatetime := IncMonth(qryEquipWarantyFinishDate.asDatetime, 0 - System.round(qryEquipWarantyPeriod.asFloat));
      except
        on E: exception do begin
          MessageDlgXP_Vista('Invalid value.', mtConfirmation, [mbOK], 0);
          qryEquipWarantyPeriod.asFloat := 0;
        end;
      end;
    end;
  finally DoFieldChange := true;
  end;
end;

procedure TfmClientEquipment.grdEquipmentCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if (SysUtils.SameText(Field.fieldname, 'Manufacture')) or
     (SysUtils.SameText(Field.fieldname, 'Model')) or
     (qryEquipActive.asBoolean = False) then
   AFont.Color := clGray; //clInactiveCaption;

end;

procedure TfmClientEquipment.grdEquipmentCalcTitleAttributes(Sender: TObject; AFieldName: string; AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
begin
  inherited;
  if (SysUtils.SameText(AFieldName, 'Manufacture')) or
     (SysUtils.SameText(AFieldName, 'Model')) then
    AFont.Color := clGray; //clInactiveCaption;

end;

procedure TfmClientEquipment.grdEquipmentColEnter(Sender: TObject);
begin
  inherited;
  if SameText(TField(grdEquipment.GetActiveField).fieldname, 'UOM') then
    if cboEquipmentLookupProductID.asInteger = 0 then grdEquipment.SetActiveField('UOMQty');

end;

procedure TfmClientEquipment.grdEquipmentDblClick(Sender: TObject);
begin
  inherited;
  if (grdEquipment.GetActiveField.fieldname = 'Notes') then begin
    if (not AppEnv.CompanyPrefs.EnforceNoModifyonNotes) or bEquipIsNewRecord then begin
      if EquipNotesDialog1.Execute then begin
        EditDB(qryEquip);
        PostDB(qryEquip);
      end;
    end;
  end
  else if (grdEquipment.GetActiveField.fieldname = 'Active') then begin
    if qryEquipActive.asBoolean = False then begin
//      if CommonLib.MessageDlgXP_Vista(qryEquipEquipName.AsString + ' is Inactive. Do You Wish To Restore it?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
//        EditDB(qryEquip);
//        qryEquipActive.asBoolean := true;
//        PostDB(qryEquip);
//      end;
    end;
  end
  else begin
  end;
end;

procedure TfmClientEquipment.grdEquipmentExit(Sender: TObject);
begin
  inherited;
  PostDB(grdEquipment.DataSource.DataSet);

end;

procedure TfmClientEquipment.grdEquipmentRowChanged(Sender: TObject);
begin
  inherited;
  RefreshUnitsQry;

end;

procedure TfmClientEquipment.qryEquipAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qryEquipUOMQty.asFloat := 1;
  qryEquipActive.asBoolean := true;
end;

procedure TfmClientEquipment.qryEquipAfterOpen(DataSet: TDataSet);
begin
  inherited;
  RefreshPic(dataset);
end;

procedure TfmClientEquipment.grpFiltersClick(Sender: TObject);
begin
  inherited;
  if grpFilters.Itemindex = 0 then qryEquip.filter := 'Active =' + Quotedstr('T')
  else if grpFilters.Itemindex = 1 then qryEquip.filter := 'Active =' + Quotedstr('F')
  else if grpFilters.Itemindex = 2 then qryEquip.filter := '';
  qryEquip.Filtered := qryEquip.filter <> '';
end;

procedure TfmClientEquipment.imgStreetDblClick(Sender: TObject);
begin
  inherited;
  DisableForm;
  try
    SelectPicture(TpotCustomerEquipment,self, qryEquip ,qryEquipid.fieldname,qryEquipStreetMap.FieldName, False, qryEquipStreetMaptype.FieldName);
    PostDB(qryEquip);
  finally
    EnableForm;
    application.ProcessMessages;
  end;
end;

procedure TfmClientEquipment.grdEquipmentIButtonClick(Sender: TObject);
begin
  inherited;
  if qryEquip.recordcount = 0 then Exit;
  try
    if qryEquipActive.asBoolean = False then Exit;
    if CommonLib.MessageDlgXP_Vista('Do You Wish to Delete Equipment ' + qryEquipEquipName.AsString + '?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;
    EditDB(qryEquip);
    qryEquipActive.asBoolean := False;
    PostDB(qryEquip);
  finally qryEquip.Refresh;
  end;
end;

initialization

RegisterClassOnce(TfmClientEquipment);

end.
