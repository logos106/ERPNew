unit frmProdAttribProducts;

interface

uses
  Windows, frmBase, Classes, Controls, ExtCtrls, DNMPanel, StdCtrls, DB,
  MemDS, DBAccess, MyAccess,ERPdbComponents, kbmMemTable, Grids, Wwdbigrd, Wwdbgrid,
  wwdblook, Contnrs, Forms, Buttons, frmProdAttribBase, Graphics;

type
  TfmProdAttribProducts = class(TfmProdAttribBase)
    SubForm: TDNMPanel;
    qryAttribProducts: TERPQuery;
    DSAttribProducts: TDataSource;
    qryAttribProductsPAP_ID: TIntegerField;
    qryAttribProductsPAG_ID: TIntegerField;
    qryAttribProductsGroupName: TWideStringField;
    qryAttribProductsProductID: TIntegerField;
    qryAttribProductsProductName: TWideStringField;
    qryAttribProductsAttribName: TWideStringField;
    qryAttribProductsattribValue: TWideStringField;
    qryAttribProductsActive: TWideStringField;
    DSGrid: TDataSource;
    grdMemTable: TkbmMemTable;
    grdAttribProducts: TwwDBGrid;
    grdAttribProductsIButton: TwwIButton;
    Label1: TLabel;

    procedure FormShow(Sender: TObject);
    procedure grdAttribProductsExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdAttribProductsIButtonClick(Sender: TObject);
    procedure grdAttribProductsCalcCellColors(Sender: TObject;
      Field: TField; State: TGridDrawState; Highlight: Boolean;
      AFont: TFont; ABrush: TBrush);
    procedure grdAttribProductsDblClick(Sender: TObject);
  private
    { Private declarations }
    ComponentList :TComponentList;
    procedure LoadGrid;
    Procedure DeleteProduct(const Value:Boolean);
  public
    { Public declarations }
    procedure SaveGrid;
    procedure SetupGrid; 
    Function OnTabchange:Boolean;

  end;

implementation

uses
  CommonLib,BaseInputForm, frmProdAttribMain,
  BusobjAttribProduct, FastFuncs, SysUtils,
  ProductAttributeLib, BusObjStock, BusobjProdAttribGroup, BusObjBase,
  tcConst, CommonDbLib;

{$R *.dfm}

procedure TfmProdAttribProducts.FormShow(Sender: TObject);
begin
  inherited;
  SubForm.Color := TBaseInputGUI(Self.Owner).TabColor;
end;

procedure TfmProdAttribProducts.FormCreate(Sender: TObject);
begin
  inherited;
  qryAttribProducts.Connection := TBaseInputGUI(Self.Owner).MyConnection;
  ComponentList := TComponentList.Create(False);
end;

procedure TfmProdAttribProducts.FormDestroy(Sender: TObject);
Var
  Component: TComponent;
begin
  //###  TwwCustomDBGrid's CurrentCustomEdit is pointer to free Component. RedrawGrid nil it #####
  grdAttribProducts.Selected.Clear;
  grdAttribProducts.ControlType.Clear;
  grdAttribProducts.EditControlOptions :=  grdAttribProducts.EditControlOptions + [ecoDisableCustomControls];
  grdAttribProducts.RedrawGrid;
 //###
  While (ComponentList.Count > 0) do
    Begin
      Component := ComponentList.Items[0];
      ComponentList.Delete(0);
      Component.Free;
    end;

  ComponentList.Free;
  inherited;
end;

procedure TfmProdAttribProducts.grdAttribProductsExit(Sender: TObject);
begin
  inherited;
  If (grdAttribProducts.DataSource.DataSet.State in [dsInsert, dsEdit]) then
    grdAttribProducts.DataSource.DataSet.Post;
end;

procedure TfmProdAttribProducts.SetupGrid;
Var
  tmpStringList: TStringList;
  I:Integer;
  LookupSQL, LookupField : String;
  Component: TComponent;
  x:Integer;
begin
  Application.ProcessMessages;
  //###  TwwCustomDBGrid's CurrentCustomEdit is pointer to free Component. RedrawGrid nil it #####
  grdAttribProducts.Selected.Clear;
  grdAttribProducts.ControlType.Clear;
  grdAttribProducts.EditControlOptions :=  grdAttribProducts.EditControlOptions + [ecoDisableCustomControls];
  grdAttribProducts.RedrawGrid;
  //###
  While (ComponentList.Count > 0) do
    Begin
      Component := ComponentList.Items[0];
      ComponentList.Delete(0);
      Component.Free;
    end;

  SetupMemTable(grdMemTable,AttributeGroups);
  grdAttribProducts.RemoveField('AutoID');
  grdAttribProducts.EditControlOptions :=  grdAttribProducts.EditControlOptions - [ecoDisableCustomControls];
  grdAttribProducts.BeginUpdate;
  Try
    grdAttribProducts.ControlType.Clear;
    LookupSQL :=  'SELECT DISTINCT tblparts.PARTSID,tblparts.PARTNAME AS ProductName FROM tblparts /*WHERE tblparts.Active = "T"*/ Order By ProductName;';
    LookupField := 'ProductName';
    CreateLookupCombo(ComponentList,Self,grdAttribProducts,qryAttribProducts.Connection,'cbo'+LookupField, LookupSQL, LookupField);
    grdAttribProducts.ControlType.Add(LookupField+';CustomEdit;cbo'+LookupField+';F');
    tmpStringList := AttributeGroups.GetAttributeNames;
    Try
      for I := 0 to tmpStringList.Count-1 do Begin
        LookupField := tmpStringList[I];
        LookupSQL :=  'SELECT DISTINCT tblproductattributevalues.Value as `'+LookupField+'` '+
                      'FROM  tblproductattributevalues  '+
                      'Inner Join tblproductattributenames ON tblproductattributenames.PAN_ID = tblproductattributevalues.PAN_ID '+
                      'Inner Join tblproductattributegroups ON tblproductattributegroups.PAG_ID = tblproductattributenames.PAG_ID '+
                      'WHERE tblproductattributegroups.Active = "T" AND tblproductattributenames.Active = "T" AND tblproductattributevalues.Active = "T" '+
                      'AND tblproductattributegroups.Name =  "'+AttributeGroups.GroupName+'" '+
                      'AND tblproductattributenames.Name =  "'+LookupField+'";';
        CreateLookupCombo(ComponentList,Self,grdAttribProducts,qryAttribProducts.Connection,'cbo'+LookupField, LookupSQL, LookupField);
        grdAttribProducts.ControlType.Add(LookupField+';CustomEdit;cbo'+LookupField+';F');
      end;
    finally
      tmpStringList.Free;
    end;
  finally
    grdAttribProducts.EndUpdate(True);
    LoadGrid;
  end;

  if grdMemTable.findfield('ProductName')<> nil then begin
    grdMemTable.FieldByName('ProductName').DisplayLabel := 'Product Name';
    grdMemTable.FieldByName('ProductName').DisplayWidth := 20;
  end;
  if grdMemTable.findfield('ProductDesc') <> nil then begin
    grdMemTable.FieldByName('ProductDesc').DisplayLabel := 'Description'  ;
    grdMemTable.FieldByName('ProductDesc').DisplayWidth := 40;
  end;

  for x := 0 to grdMemTable.Fields.count -1 do
    if Sysutils.SameText(grdMemTable.fields[x].fieldname , 'ProductName') then else
    if Sysutils.SameText(grdMemTable.fields[x].fieldname , 'ProductDesc') then else
    TField(grdMemTable.fields[x]).displaywidth := 10;

  if grdMemTable.findfield('Active')<> nil then
    grdMemTable.FieldByName('Active').visible := false;

end;


procedure TfmProdAttribProducts.SaveGrid;
Var
  I: Integer;
  tmpStringList: TStringList;
  BusObj: TProductAttributes;
  LoadSelectStr: String;
begin
  If AttributeGroups.GroupName='' then Exit;
  BusObj := TfmProdAttribMain(Self.Owner).AttributeProducts;
  if not busobj.dirty then exit;
  
  if not(grdMemTable.active) then exit;


  grdMemTable.First;
  EnableProgressbar(True, grdMemTable.recordcount);
  try
    While not grdMemTable.Eof Do Begin
      TmpStringList := AttributeGroups.GetAttributeNames;
    // Delete OLD
      LoadSelectStr := 'ProductID = ' + IntToStr(Tproduct.IDToggle(grdMemTable.FieldByName('ProductName').AsString, TfmProdAttribMain(Self.Owner).MyConnection)) + ' AND '+
        'PAG_ID = ' + IntToStr(TProdAttribGroups.IDToggle(AttributeGroups.GroupName, TfmProdAttribMain(Self.Owner).MyConnection));
      BusObj.LoadSelect(LoadSelectStr);
      BusObj.DeleteAll;
      StepProgress;
      Try
        for I := 0 to tmpStringList.Count-1 do Begin

          if grdMemTable.Findfield(tmpStringList[I]) <> nil then begin
            BusObj.New;
            BusObj.GroupName    := AttributeGroups.GroupName;
            BusObj.ProductName  := grdMemTable.FieldByName('ProductName').AsString;
            BusObj.AttribName   := tmpStringList[I];
            BusObj.attribValue  := grdMemTable.FieldByName(tmpStringList[I]).AsString;
            if grdMemTable.fieldByname('Active').AsString = 'T' then begin
              BusObj.Active       := TRue;
              TProduct.SetProductActive(Busobj.ProductID , True, Busobj.Connection.Connection);
            end else begin
              BusObj.Active       := False;
              TProduct.SetProductActive(Busobj.ProductID , False, Busobj.Connection.Connection);
            end;
            BusObj.postDB;

          end;
        end;
      finally
        TmpStringList.Free;
      end;
      grdMemTable.Next;
    end;
  finally
    EnableProgressbar(False, 0);
  end;
end;


procedure TfmProdAttribProducts.LoadGrid;
Var
  BusObj: TProductAttributes;
  tmpProductNames,tmpAttributeNamesList: TStringList;
  I,J:Integer;
  GroupName,LoadSelectStr:String;
  ffound :boolean;
  strSQL:String;
begin
  GroupName := AttributeGroups.GroupName;
  If GroupName='' then Exit;
  BusObj := TfmProdAttribMain(Self.Owner).AttributeProducts;

  tmpAttributeNamesList := AttributeGroups.GetAttributeNames;
  tmpProductNames := BusObj.GetProductNames(AttributeGroups.GroupName);
  try
    EnableProgressbar(True , tmpProductNames.Count);
    try
      for J := 0 to tmpProductNames.Count-1 do Begin
        ffound :=false;
        grdMemTable.Insert;
        grdMemTable.FieldByName('ProductName').AsString := tmpProductNames[J];
        strSQL:='Select PartsID, Active, PARTSDESCRIPTION from tblPArts where Partname = ' +quotedStr(tmpProductNames[J])+' Order by Active';{}
        With CommonDBLib.TempMyQuery do try
          Connection := TfmProdAttribMain(Self.Owner).MyConnection;
          SQL.add(strSQL);
          Open;
          for I := 0 to tmpAttributeNamesList.Count-1 do Begin
            LoadSelectStr := 'ProductID = ' + IntToStr(fieldByname('PartsID').asInteger) +
                ' AND PAG_ID = ' + IntToStr(AttributeGroups.ID(*TProdAttribGroups.IDToggle(GroupName, TfmProdAttribMain(Self.Owner).MyConnection)*)) +
                ' AND AttribName = '+ QuotedStr(tmpAttributeNamesList[I]);
            BusObj.LoadSelect(LoadSelectStr);
            If BusObj.Dataset.RecordCount >0 then begin
              grdMemTable.FieldByName(BusObj.AttribName).AsString := BusObj.attribValue;
              ffound := True;
            end else begin
              Continue;
            end;
          end;
          if ffound then begin
            grdMemTable.Fieldbyname('Active').asString := fieldbyname('Active').asString;
            grdMemTable.Fieldbyname('ProductDesc').asString := fieldbyname('PARTSDESCRIPTION').asString;
            If (grdMemTable.State in [dsInsert, dsEdit]) then grdMemTable.Post;
          end else grdMemTable.Cancel;
        finally
            if Active then Close;
            free;
        end;
        StepProgress;
      end;
    finally
      EnableProgressbar(False, 0);
    end;
  finally
    tmpAttributeNamesList.Free;
    tmpProductNames.Free;
    BusObj.LoadSelect('GroupName = ' + QuotedStr(GroupName));
    grdMemTable.First;
    If grdMemTable.RecordCount>0 then
      grdMemTable.Edit
    else
      grdMemTable.Insert;  
  end;
end;
Function TfmProdAttribProducts.OnTabchange:Boolean;
begin
  REsult := True;
end;

procedure TfmProdAttribProducts.grdAttribProductsIButtonClick(  Sender: TObject);
(*var
  Abort:Boolean;*)
begin
  if grdMemTable.Fieldbyname('Active').asString = 'T' then   DeleteProduct(False);
    (*if AttributeGroups.AttributeProducts.Dataset.Locate('ProductName' , grdmemtable.fieldbyname('ProductName').AsString  , []) then begin
      AttributeGroups.LockParts(AttributeGroups.AttributeProducts , Abort);
      if not Abort then begin
        if grdMemTable.state in [dsEdit,dsInsert] then else grdMemTable.Edit;
        grdMemTable.Fieldbyname('Active').asString := 'F';
        if grdMemTable.state in [dsEdit,dsInsert] then grdMemTable.Post;
        AttributeGroups.Dirty :=  true;
      end;
    end;*)
end;

procedure TfmProdAttribProducts.grdAttribProductsCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState;
  Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if grdMemTable.Fieldbyname('Active').asString = 'F' then AFont.color := clInactiveCaption
  else AFont.color := clBlack;
end;

procedure TfmProdAttribProducts.grdAttribProductsDblClick(Sender: TObject);
(*var
  Abort:Boolean;*)
begin
  inherited;
  if grdMemTable.Fieldbyname('Active').asString = 'F' then DeleteProduct(TRue);
    (*if AttributeGroups.AttributeProducts.Dataset.Locate('ProductName' , grdmemtable.fieldbyname('ProductName').asInteger  , []) then begin
      AttributeGroups.LockParts(AttributeGroups.AttributeProducts , Abort);
      if not Abort then begin
          if grdMemTable.state in [dsEdit,dsInsert] then else grdMemTable.Edit;
          grdMemTable.Fieldbyname('Active').asString := 'T';
          if grdMemTable.state in [dsEdit,dsInsert] then grdMemTable.Post;
          AttributeGroups.Dirty :=  true;
      end;
    end;*)
end;

procedure TfmProdAttribProducts.DeleteProduct(const Value: Boolean);
(*var
  Abort:Boolean;*)
begin
  //if not(AttributeGroups.AttributeProducts.Dataset.Locate('ProductName' , grdmemtable.fieldbyname('ProductName').AsString  , [])) then exit;
  //if not AttributeGroups.LockProduct(TProduct.GetBusObjectTablename , AttributeGroups.AttributeProducts.ProductID,grdmemtable.fieldbyname('ProductName').AsString,  LockMsgDelPriceMtxProduct) then Exit;
  With TProduct.Create(nil) do try
    connection := AttributeGroups.Connection;
    LoadSelect('PartName =' +quotedStr(grdmemtable.fieldbyname('ProductName').AsString));
    if count = 0 then exit;
    if not AttributeGroups.LockProduct(TProduct.GetBusObjectTablename , ID,ProductName,  LockMsgDelPriceMtxProduct) then Exit;
    Active := Value;
    if Active = Value then begin
      PostDB;
      if grdMemTable.state in [dsEdit,dsInsert] then else grdMemTable.Edit;
      if Value then grdMemTable.Fieldbyname('Active').asString := 'T'
      else grdMemTable.Fieldbyname('Active').asString := 'F';
      if grdMemTable.state in [dsEdit,dsInsert] then grdMemTable.Post;
      AttributeGroups.Dirty :=  true;
    end;
  finally
    Free;
  end;
  (*if AttributeGroups.AttributeProducts.Dataset.Locate('ProductName' , grdmemtable.fieldbyname('ProductName').AsString  , []) then begin
  AttributeGroups.LockParts(AttributeGroups.AttributeProducts , Abort);


      if not Abort then begin
        if grdMemTable.state in [dsEdit,dsInsert] then else grdMemTable.Edit;
        if Value then grdMemTable.Fieldbyname('Active').asString := 'T'
        else grdMemTable.Fieldbyname('Active').asString := 'F';
        if grdMemTable.state in [dsEdit,dsInsert] then grdMemTable.Post;
        AttributeGroups.Dirty :=  true;
      end;
  end;         *)
end;

initialization
  RegisterClassOnce(TfmProdAttribProducts);
end.




