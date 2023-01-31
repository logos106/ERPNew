unit frmAreaCode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,  busobjareacodes, BusObjBase, Mask, wwdbedit, ComCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdblook;

type
  TfmAreaCode = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    QryAreacode: TERPQuery;
    dsAreaCode: TDataSource;
    Box20: TBevel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    QryAreacodeID: TIntegerField;
    QryAreacodeGlobalref: TWideStringField;
    QryAreacodeAreacode: TWideStringField;
    QryAreacodeAreaName: TWideStringField;
    QryAreacodeDescription: TWideStringField;
    QryAreacodeActive: TWideStringField;
    QryAreacodemsTimeStamp: TDateTimeField;
    QryAreacodemsUpdateSitecode: TWideStringField;
    Label1: TLabel;
    edtprocessStep: TwwDBEdit;
    wwDBEdit1: TwwDBEdit;
    Label2: TLabel;
    wwDBEdit2: TwwDBEdit;
    Label3: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    QryEmployees: TERPQuery;
    dsEmployees: TDataSource;
    dsCustomers: TDataSource;
    QryCustomers: TERPQuery;
    dsSuppliers: TDataSource;
    QrySuppliers: TERPQuery;
    dsProducts: TDataSource;
    QryProducts: TERPQuery;
    grdEmployees: TwwDBGrid;
    btnGrid: TwwIButton;
    QryEmployeesEmployeename: TWideStringField;
    QryEmployeesEmployeeID: TIntegerField;
    QryCustomersclientId: TIntegerField;
    QryCustomerscompany: TWideStringField;
    grdcustomers: TwwDBGrid;
    wwIButton1: TwwIButton;
    grdsuppliers: TwwDBGrid;
    wwIButton2: TwwIButton;
    QrySuppliersclientId: TIntegerField;
    QrySupplierscompany: TWideStringField;
    grdProducts: TwwDBGrid;
    wwIButton3: TwwIButton;
    QryProductsPartsId: TIntegerField;
    QryProductsPartName: TWideStringField;
    btnAssignEmployee: TDNMSpeedButton;
    btnAssignCustomer: TDNMSpeedButton;
    btnAssignSupplier: TDNMSpeedButton;
    btnAssignProducts: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAssignEmployeeClick(Sender: TObject);
    procedure btnAssignCustomerClick(Sender: TObject);
    procedure btnAssignSupplierClick(Sender: TObject);
    procedure btnAssignProductsClick(Sender: TObject);
  private
    AreaCodeObj: TAreacode;
    hasLockedrecords:Boolean;
    function SaveRecord: Boolean;
    procedure AssigncustArea(Sender: TwwDBGrid);
    procedure AssignSuppArea(Sender: TwwDBGrid);
    procedure AssignEmpArea(Sender: TwwDBGrid);
    procedure AssignProductArea(Sender: TwwDBGrid);
    function GridSelectedIDs(Sender: TwwDBGrid; const IdFieldName: String): String;
    procedure updateAreaCode(const Sender: TBusObj; var Abort: Boolean);
    procedure DoUpdate(Sender: TwwDBGrid; const objtype: TPersistentClass; IDfieldName: String;description:String);
  Protected
    function IDfromcombo(Combo :TwwDBLookupCombo):Integer;Override;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, BusObjConst, FormFactory, CommonFormLib, BaseListingForm, BusObjEmployee, BusObjClient, BusObjStock, CommonDbLib;

{$R *.dfm}
procedure TfmAreaCode.btnAssignEmployeeClick(Sender: TObject);begin  OpenERPListFormultiselectModal('TEmployeeExpresslistGUI', nil, AssignEmpArea     );end;
procedure TfmAreaCode.btnAssignProductsClick(Sender: TObject);begin  OpenERPListFormultiselectModal('TProductListExpressGUI' , nil, AssignProductArea );end;
procedure TfmAreaCode.btnAssignSupplierClick(Sender: TObject);begin  OpenERPListFormultiselectModal('TSupplierExpressListGUI', nil, AssignSuppArea  );end;
procedure TfmAreaCode.btnAssignCustomerClick(Sender: TObject);begin  OpenERPListFormultiselectModal('TCustomerExpressListGUI', nil, AssigncustArea  );end;
procedure TfmAreaCode.AssigncustArea    (Sender: TwwDBGrid);begin  DoUpdate(Sender, TCustomer, 'ClientID'  , 'Customer');CloseDB(QryCustomers);QryCustomers.ParamByName('Areacode').AsString :=AreaCodeObj.Areacode;Opendb(QryCustomers);end;
procedure TfmAreaCode.AssignSuppArea    (Sender: TwwDBGrid);begin  DoUpdate(Sender, TSupplier, 'ClientID'  , 'Supplier');CloseDB(QrySuppliers);QrySuppliers.ParamByName('Areacode').AsString :=AreaCodeObj.Areacode;Opendb(QrySuppliers);end;
procedure TfmAreaCode.AssignEmpArea     (Sender: TwwDBGrid);begin  DoUpdate(Sender, TEmployee, 'EmployeeID', 'Employee');CloseDB(QryEmployees);QryEmployees.ParamByName('Areacode').AsString :=AreaCodeObj.Areacode;Opendb(QryEmployees);end;
procedure TfmAreaCode.AssignProductArea (Sender: TwwDBGrid);begin  DoUpdate(Sender, TProduct , 'PartsID'   , 'Product' );CloseDB(QryProducts );QryProducts.ParamByName('Areacode').AsString :=AreaCodeObj.Areacode;Opendb(QryProducts );end;

Procedure TfmAreaCode.DoUpdate(Sender: TwwDBGrid; Const objtype: TPersistentClass;IdFieldName:String;description:String);
var
  busobj :TComponent;
  IDsToUpdate:String;
begin
  IDsToUpdate   := GridSelectedIDs(Sender,IDFieldName);
  if IDsToUpdate='' then exit;

  busobj :=GetComponentByClassType(objtype, true , Self);
  try
    if not(Assigned(busobj)) then exit;
    if not(busobj is TMSBusObj) then exit;
    with TMSBusObj(busobj) do begin
      Connection:= AreaCodeObj.Connection;
      LoadSelect(IDFieldName+' in (' + IdstoUpdate+')');
      hasLockedrecords:= False;
      connection.BeginNestedTransaction;
      try
        Iteraterecords(updateAreaCode);
        Connection.CommitNestedTransaction;
      Except
        on E:Exception do begin
          connection.RollbackNestedTransaction;
        end;
      end;
    end;
    if hasLockedrecords then
      MessageDlgXP_Vista('Some of the ' + description +'  selected where locked which are not linked to this area. Please try again', mtInformation, [mbOK], 0);
  finally
    FreeandNil(busobj);
  end;
end;
Function TfmAreaCode.GridSelectedIDs(Sender: TwwDBGrid; const IdFieldName:String):String;
begin
   result:= '';
   if sender = nil then exit;
   if not(Assigned(Sender.Owner)) then exit;
   if not(Sender.Owner is TBaseListingGUI) then exit;
   Result := TBaseListingGUI(Sender.Owner).SelectedIDs(IDFieldName);
end;
function TfmAreaCode.IDfromcombo(Combo: TwwDBLookupCombo): Integer;
begin
  if Combo.Lookuptable.findfield('ID') <> nil then
    result :=Combo.Lookuptable.findfield('ID').asInteger
  else begin
    with TempMyquery do try
      SQL.add('Select Id from tblareacodes where Areacode = ' +quotedstr(combo.text));
      open;
      result := fieldbyname('ID').asInteger;
    finally
      closenFree;
    end;
  end;
end;

procedure TfmAreaCode.updateAreaCode(const Sender: TBusObj; var Abort: Boolean);
begin
  if not Sender.Lock then begin
    hasLockedrecords:= True;
    exit;
  end;
  SetObjectProperty(Sender, 'Area' , AreaCodeObj.Areacode);
  Sender.PostDb;
end;
procedure TfmAreaCode.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

Function TfmAreaCode.SaveRecord :Boolean;
begin
  result:= False;
  if not(AreaCodeObj.Save) then exit;
  Result:= True;

end;

procedure TfmAreaCode.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  AreaCodeObj.Connection.CommitTransaction;
  notify(False);
  Self.Close;
end;

procedure TfmAreaCode.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
      inherited;
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TAreaCode then TAreaCode(Sender).Dataset  := qryAreaCode;
     end;
end;

procedure TfmAreaCode.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TfmAreaCode.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if AreaCodeObj.Dirty then begin
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
          AreaCodeObj.Dirty := false;
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

procedure TfmAreaCode.FormCreate(Sender: TObject);
begin
  inherited;
  {$WARNINGS OFF}
  AreaCodeObj := TAreaCode.CreateWithNewConn(Self);
  AreaCodeObj.Connection.connection := Self.MyConnection;
  AreaCodeObj.BusObjEvent := DoBusinessObjectEvent;
  {$WARNINGS ON}
end;
procedure TfmAreaCode.FormShow(Sender: TObject);
begin
  inherited;
  AreaCodeObj.Load(KeyID);
  UserLock.Enabled:= True;
  if KeyID>0 then
    if not(AreaCodeObj.Lock) then AccessLevel:= 5;
  if AccessLevel = 1 then begin
    AreaCodeObj.connection.BeginTransaction;
    if AreaCodeObj.count=0 then AreaCodeObj.new;
  end;
  QryEmployees.ParamByName('Areacode').AsString :=AreaCodeObj.Areacode;
  QryCustomers.ParamByName('Areacode').AsString :=AreaCodeObj.Areacode;
  QrySuppliers.ParamByName('Areacode').AsString :=AreaCodeObj.Areacode;
  QryProducts.ParamByName('Areacode').AsString :=AreaCodeObj.Areacode;
  openQueries;
end;

initialization
  RegisterClassOnce(TfmAreaCode);
  with FormFact do begin
    RegisterControl(TfmAreaCode, '*_cboAreaCode=AreaCode');
    RegisterControl(TfmAreaCode, '*_cboLinesAreaCode=AreaCode');
    RegisterMe(TfmAreaCode, 'TAreacodesGUI_*=ID');
  end;
end.

