unit datPoolCareAddin;

{  This is a template for the addition of "Addin" functionality to Platinum1 using
   dynamically loaded packages.
  
   One of thes Addin units should be created for each Addin package.
   This DataModule is created when the Addin package is loaded and its job is
   to add the required user funcionality contained in the package to the main
   Platinum1 core application.


   Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   21/03/05  1.00.00 IJB  Initial verson.
   18/11/05  1.00.01 DLS
   29/11/05  1.00.02 DSP  Added AssignActionBitmap call to
                          actCustomerListExecute.
   11/01/06  1.00.03 BJ   menu option added for the profile list.
                          The customerlist was displayed before which is replaced by the
                          profile list
   16/01/06  1.00.04 BJ   Menu option for Pool Profile tEst list is added}
interface

uses
  
  SysUtils, Classes, ActnList, DNMAction, Menus, AdvMenus, DB, DBAccess, MyAccess,
  BaseGUIDatamodule, ActionsObj, wwDbGrid, ImgList, Controls;

type
  TdmPoolCareAddin = class(TdtmGUI)
    MainMenu: TAdvMainMenu;
    mnuPoolCare: TMenuItem;
    CustomerList2: TMenuItem;
    CustomerList1: TMenuItem;
    ActionList: TActionList;
    actPoolTestConfiguration: TDNMAction;
    actCustomerList: TDNMAction;
    MyConnection: TMyConnection;
    ImageList1: TImageList;
    PoolProfileTestList1: TMenuItem;
    procedure DataModuleCreate(Sender: TObject);
    procedure actCustomerListExecute(Sender: TObject);
  private
    { Private declarations }
    //Customerlistform: TBaseListingGUI;
    //procedure NewProfile(Sender: TObject);
    //procedure GetCustID(grdMain: TwwDbGrid);
  public
    { Public declarations }
    procedure AssociateClassNamesWithActions; override;

  published
    procedure GetAvailableCategories(var AList: TStrings; const StartFresh: boolean = true);
    function GetActionCategory(const ActionName: string; const ActionList: TActionList): string;
    procedure GetCategoriesActions(var AList: TStrings; var CategoryName: string);
    function GetAction(Const ItemName: string): TAction;
    function GetActionIndex(const i: integer): TAction;
    function GetItem(const ActionName: string): TActionHelperItem;
    function GetActionCount: integer;
  end;

var
  dmPoolCareAddin: TdmPoolCareAddin;

implementation

uses FastFuncs, AddinPackageInfoObj;

{$R *.dfm}

{$M+}        {don't delete!}


//get action category for action name.
function TdmPoolCareAddin.GetActionCategory(const ActionName: string; const ActionList: TActionList): string;
var
  I: integer;
  Action: TAction;
begin
  Result := '';
  if ActionList.ActionCount > 0 then for I := 0 to ActionList.ActionCount - 1 do begin
      Action := TAction(ActionList.Actions[I]);
      if FastFuncs.SameText(Action.Name, ActionName) then begin
        Result := Action.Category;
        Break;
      end;
    end;
end;

{return list of categories from action list.}

procedure TdmPoolCareAddin.GetAvailableCategories(var AList: TStrings; const StartFresh: boolean = true);
var
  I: integer;
  Action: TAction;
begin
  if StartFresh then AList.Clear;
  if ActionList.ActionCount > 0 then for I := 0 to ActionList.ActionCount - 1 do begin
      Action := TAction(ActionList.Actions[I]);
      if AList.IndexOf(Action.Category) = -1 then AList.Add(Action.Category);
    end;
end;
{return list of actions}

procedure TdmPoolCareAddin.GetCategoriesActions(var AList: TStrings; var CategoryName: string);
var
  I: integer;
  Action: TAction;
begin
  AList.Clear;
  if ActionList.ActionCount > 0 then for I := 0 to ActionList.ActionCount - 1 do begin
      Action := TAction(ActionList.Actions[I]);
      if FastFuncs.SameText(Action.Category, CategoryName) then {same, so continue}
        if AList.IndexOf(Action.Name) = -1 then AList.Add(Action.Name);
    end;
end;
{get Action by Name}

function TdmPoolCareAddin.GetAction(Const ItemName: string): TAction;
var
  I: integer;
  Action: TAction;
begin
  Result := nil;
  if ActionList.ActionCount > 0 then for I := 0 to ActionList.ActionCount - 1 do begin
      Action := TAction(ActionList.Actions[I]);
      if FastFuncs.SameText(Action.Name, ItemName) then begin
        Result := Action;
        Break;
      end;
    end;
end;
{get action count}

function TdmPoolCareAddin.GetActionCount: integer;
begin
  Result := ActionList.ActionCount;
end;

{get Action based on index}
function TdmPoolCareAddin.GetActionIndex(const i: integer): TAction;
var
  Action: TAction;
begin
  Result := nil;
  if ActionList.ActionCount > 0 then begin
    Action := TAction(ActionList.Actions[I]);
    Result := Action;
  end;
end;
{get Action by Action name}

function TdmPoolCareAddin.GetItem(const ActionName: string): TActionHelperItem;
var
  I: integer;
begin
  Result := nil;
  if ActionHelper.Count > 0 then for I := 0 to ActionHelper.ActionCount - 1 do
      if FastFuncs.SameText(ActionHelper.Items[I].ActionName, ActionName) then begin
        Result := ActionHelper.Items[I];
        Break;
      end;
end;


{Add code to associate class with actions- This is a template}
procedure TdmPoolCareAddin.AssociateClassNamesWithActions;
var
  i: integer;
  Action: TDNMAction;
begin
  // here all actions need to be associated with its corresponding form class

  //Action names should be unique to differentiate between different packagages.
  //example
  for i := 0 to ActionList.Actioncount - 1 do begin
    Action := TDNMAction(ActionList.Actions[I]);
    ActionHelper.AssociateActionWithClassName(Action.Name, Action.ClassExecute, Action.Description);
  end;
end;
// ---------- Specific functionality -----------------------------------------------


procedure TdmPoolCareAddin.actCustomerListExecute(Sender: TObject);
begin
  {CustomerListForm := BaseClassFuncs.GetBaseListingByClassName('TCustomerListGUI', true);

  with CustomerListForm do begin
    AssignActionBitmap(Sender, CustomerListForm);
    OnGridDataSelect := GetCustID;
    OnNewbtnClick    := NewProfile;
    FormStyle        := fsMdiChild;
    BringToFront;
  end;}
end;

{procedure TdmPoolCareAddin.NewProfile(Sender: TObject);
begin
  with TfmPoolCustomer(GetComponentByClassName('TfmPoolCustomer')) do begin
    KeyId     := 0;
    CustId    := 0;
    FormStyle := fsMdiChild;
    BringToFront;
    Abort;
  end;
end;}

{procedure TdmPoolCareAddin.GetCustID(grdMain: TwwDbGrid);
var
  Qry: TMyQuery;
  CustId: integer;
  Key: integer;
begin
  Key := 0;
  CustId := grdMain.DataSource.DataSet.FieldByName('ClientID').AsInteger;
  if CustId <> 0 then begin
    qry := TMyQuery.Create(Self);
    with qry do begin
      Connection := TMyQuery(grdMain.Datasource.DataSet).Connection;
      Sql.add('Select PoolProfileID from  tblPoolProfile where ClientID = ' + FastFuncs.IntToStr(CustId));
      Active := true;
      if RecordCount > 0 then Key := FieldByName('PoolProfileID').AsInteger;
    end;
  end;
  if Key <> 0 then begin
    with TfmPoolCustomer(GetComponentByClassName('TfmPoolCustomer')) do begin
      KeyId := Key;
      FormStyle := fsMdiChild;
      BringToFront;
      Abort;
    end;
  end else begin
    with BaseClassFuncs.GetBaseInputByClassName('TfrmCustomer', false) do begin
      KeyId := grdMain.DataSource.DataSet.FieldByName('ClientID').AsInteger;
      FormStyle := fsMdiChild;
      BringToFront;
      Abort;
    end;
  end;
end;}
//---------------------------------------------------------------------------------

procedure TdmPoolCareAddin.DataModuleCreate(Sender: TObject);
begin
  inherited;
  PopulateActionHelper(Self.ActionList);
  AssociateClassNamesWithActions;
end;


initialization
  if Assigned(AddinInfo) then AddinInfo.GuiDataModuleClass := TdmPoolCareAddin;       {<-and here}
end.


