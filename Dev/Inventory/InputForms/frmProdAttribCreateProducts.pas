unit frmProdAttribCreateProducts;

interface

uses
  Windows, frmBase, Classes, Controls, ExtCtrls, DNMPanel, StdCtrls,
  DNMSpeedButton, Grids, Wwdbigrd, Wwdbgrid, DB, kbmMemTable,
  Contnrs, wwdblook, Menus, AdvMenus, Forms, frmProdAttribBase, BusObjBase,
  ComCtrls;

type
  TfmProdAttribCreateProducts = class(TfmProdAttribBase)
    SubForm: TDNMPanel;
    grdMemTable: TkbmMemTable;
    DSGrid: TDataSource;
    dbgAttribNewProducts: TwwDBGrid;
    btnCreate: TDNMSpeedButton;
    mnuOptions: TAdvPopupMenu;
    SelectAll1: TMenuItem;
    DeselectAll1: TMenuItem;
    chkSelectAll: TCheckBox;
    Label46: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCreateClick(Sender: TObject);
    procedure SelectAll1Click(Sender: TObject);
    procedure DeselectAll1Click(Sender: TObject);
    procedure chkSelectAllClick(Sender: TObject);
    procedure dbgAttribNewProductsMultiSelectRecord(Grid: TwwDBGrid;
      Selecting: Boolean; var Accept: Boolean);
    procedure dbgAttribNewProductsMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure dbgAttribNewProductsKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    ComponentList :TComponentList;
    sPavFields, sPapFields, sPavTables, sPapTables, sPavWhere, sPapWhere, sDesc , sAttribfields, sAttribwhere ,sAttribfieldNamesDetail , sFieldNames:String;
    ctr:Integer;
    procedure ComboNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
    procedure LoadGrid;
    Procedure makeQueryString(const Sender: TBusObj; var Abort: Boolean);
    function CreateProducts: Boolean;
  public
    { Public declarations }
    procedure SetupGrid;
    Function OnTabchange:Boolean ;
    Procedure ClearSelection;
  end;

implementation

uses
  CommonLib,BaseInputForm, ProductAttributeLib, frmProdAttribMain,
  MyAccess,ERPdbComponents, SysUtils, Dialogs, BusobjAttribProduct, BusObjStock,
  BusObjGLAccount, AppEnvironment, ProgressDialog,
  BusobjProdAttribGroup, FastFuncs, CommonDbLib;

{$R *.dfm}

procedure TfmProdAttribCreateProducts.FormShow(Sender: TObject);
begin
  inherited;
  SubForm.Color := TBaseInputGUI(Self.Owner).TabColor;
end;

procedure TfmProdAttribCreateProducts.ComboNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
begin
  inherited;
  Accept := True;
  TwwDBLookupCombo(Sender).DataSource.DataSet.FieldByName(TwwDBLookupCombo(Sender).DataField).AsString := NewValue;
end;

procedure TfmProdAttribCreateProducts.SetupGrid;
Var
  LookupSQL, LookupField : String;
  Component: TComponent;
  x:Integer;
begin
  EnableProgressbar(true , 11);
  try
    Application.ProcessMessages;
    //###  TwwCustomDBGrid's CurrentCustomEdit is pointer to free Component. RedrawGrid nil it #####
    dbgAttribNewProducts.Selected.Clear;
    dbgAttribNewProducts.ControlType.Clear;
    dbgAttribNewProducts.EditControlOptions :=  dbgAttribNewProducts.EditControlOptions + [ecoDisableCustomControls];
    dbgAttribNewProducts.RedrawGrid;
    StepProgress;
    //###
    While (ComponentList.Count > 0) do
      Begin
        Component := ComponentList.Items[0];
        ComponentList.Delete(0);
        Component.Free;
      end;
    StepProgress;
    SetupMemTable(grdMemTable,AttributeGroups);
    dbgAttribNewProducts.RemoveField('AutoID');
    dbgAttribNewProducts.EditControlOptions :=  dbgAttribNewProducts.EditControlOptions - [ecoDisableCustomControls];
    dbgAttribNewProducts.BeginUpdate;
    StepProgress;
    Try
      dbgAttribNewProducts.ControlType.Clear;
      LookupSQL :=  'SELECT DISTINCT tblparts.PARTSID,tblparts.PARTNAME AS ProductName FROM tblparts WHERE tblparts.Active = "T" Order By ProductName;';
      LookupField := 'ProductName';
      With CreateLookupCombo(ComponentList,Self,dbgAttribNewProducts,TfmProdAttribMain(Self.Owner).MyConnection ,'cbo'+LookupField, LookupSQL, LookupField) Do Begin
        OnNotInList := ComboNotInList;
        AutoSelect := False;
        AutoDropDown := False;
      end;
      dbgAttribNewProducts.ControlType.Add(LookupField+';CustomEdit;cbo'+LookupField+';F');
      StepProgress;
    finally
      dbgAttribNewProducts.EndUpdate(True);
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
    StepProgress;
    for x := 0 to grdMemTable.Fields.count -1 do
      if Sysutils.SameText(grdMemTable.fields[x].fieldname , 'ProductName') then else
      if Sysutils.SameText(grdMemTable.fields[x].fieldname , 'ProductDesc') then else
      TField(grdMemTable.fields[x]).displaywidth := 10;
    if grdMemTable.findfield('Active') <> nil then
      grdMemTable.FieldByName('Active').index := grdMemTable.Fields.count -1;
  finally
      EnableProgressbar(false,0);
  end;
  StepProgress;
end;

procedure TfmProdAttribCreateProducts.FormCreate(Sender: TObject);
begin
  inherited;
  ComponentList := TComponentList.Create(False);
end;

procedure TfmProdAttribCreateProducts.FormDestroy(Sender: TObject);
Var
  Component: TComponent;
begin
  //###  TwwCustomDBGrid's CurrentCustomEdit is pointer to free Component. RedrawGrid nil it #####
  dbgAttribNewProducts.Selected.Clear;
  dbgAttribNewProducts.ControlType.Clear;
  dbgAttribNewProducts.EditControlOptions :=  dbgAttribNewProducts.EditControlOptions + [ecoDisableCustomControls];
  dbgAttribNewProducts.RedrawGrid;
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
Procedure TfmProdAttribCreateProducts.makeQueryString(const Sender: TBusObj; var Abort: Boolean);
var
  tblAlias:String;
begin
    tblAlias := 'v' + Trim(IntToStr(ctr));
    if sPavTables <> '' then sPavTables := sPavTables + ',';
    sPavTables := sPavTables + ' tblproductattributevalues  as ' +tblAlias;

    if sPavFields <> '' then sPavFields := sPavFields +',';
    sPavFields := sPavFields + tblAlias +'.Abbreviation ';

    if sAttribfields <> '' then sAttribfields := sAttribfields +',';
    sAttribfields := sAttribfields + tblAlias +'.Value as `' + TProdAtribName(Sender).AttribName +'`';

    if sAttribfieldNamesDetail <> '' then sAttribfieldNamesDetail := sAttribfieldNamesDetail +',';
    sAttribfieldNamesDetail := sAttribfieldNamesDetail + '`' + TProdAtribName(Sender).AttribName +'` Varchar(255)';

    if sFieldNames <> '' then sFieldNames := sFieldNames +',';
    sFieldNames := sFieldNames + '`' + TProdAtribName(Sender).AttribName +'` ';



    if sDesc <> '' then sDesc := sDesc +', ' +QuotedStr(', ')+',';
    sDesc := sDesc + QuotedStr(TProdAtribName(Sender).AttribName) +',' +quotedStr(':') +',' + tblAlias +'.Value ';

    if sPavWhere <> '' then sPavWhere := sPavWhere  +' and ';
    sPavWhere  := sPavWhere  + tblalias+'.PAN_ID = ' + IntToStr(Sender.ID);


    tblAlias := 'pap' + Trim(IntToStr(ctr));
    if sPapTables <> '' then sPapTables := sPapTables + ',';
    sPapTables := sPapTables + ' tblproductattributeproducts  as ' +tblAlias;

    if sPapFields <> '' then sPapFields := sPapFields +',';
    sPapFields := sPapFields + tblAlias +'.AttribValue as  `' + TProdAtribName(Sender).AttribName +'`';

    if sPapWhere <> '' then sPapWhere := sPapWhere  +' and ';
    sPapWhere  := sPapWhere  + tblalias+'.ProductID = pap.ProductID ' +
                  ' and ' + tblalias+'.Attribname = ' + QuotedStr(TProdAtribName(Sender).AttribName) +
                  ' and ' + tblalias+'.pag_id = ' +IntToStr(TProdAtribName(Sender).Pag_id);

    if sAttribwhere <> '' then sAttribwhere := sAttribwhere  +' and ';
    sAttribwhere := sAttribwhere + 't1.`' + TProdAtribName(Sender).AttribName +'` = t2.`' + TProdAtribName(Sender).AttribName +'`';


    ctr:= ctr+1;
end;
procedure TfmProdAttribCreateProducts.LoadGrid;
var
  I:Integer;
  tmpStringList: TStringList;
  attributename,qrySQL:String;
  tmpComponentList: TComponentList;
  Qrylookup: TERPQuery;
  tmp_pap1, tmp_pap2:String;
//  Existing :TDataset;

  Function makeQuery:String;
  var
    strSQL:string;
    fsfilename1, fsfilename2 :String;
  begin
    tmp_pap1:=GetUserTemporaryTableName('pap1');
    tmp_pap2:=GetUserTemporaryTableName('pap2');

    sPavFields:='';    sPapFields:='';
    sPavTables:= '';   sPapTables:='';
    sPavWhere :='';    spapWhere := ''; sAttribwhere:='';

    sDesc:= '';
    sAttribfields:='';
    sAttribfieldNamesDetail := '';
    sFieldNames := '';
    ctr:= 1;
    AttributeGroups.AttributeNames.Iteraterecords(makeQueryString);
    if sAttribfieldNamesDetail <> '' then sAttribfieldNamesDetail := ',' + sAttribfieldNamesDetail;
    if sFieldNames <> '' then sFieldNames := ',' +sFieldNames;
    
    strSQL:= 'drop table if exists ' +tmp_pap1+';'+chr(13) ;
    strSQL:= strSQL+ 'drop table if exists ' +tmp_pap2+';'+chr(13) ;
    strSQL:= strSQL +'CREATE TABLE `' +tmp_pap1+'` ( ' +
                                  '`Partname` varchar(62) default NULL,'+
                                  '`ProductDesc` longtext'+
                                  sAttribfieldNamesDetail+
                                ') ENGINE=InnoDB ;';

    strSQL:= strSQL +'CREATE TABLE `' +tmp_pap2+'` ( ' +
                                  '`productID` int(11) default NULL,'+
                                  '`productName` varchar(255) default NULL'+
                                  sAttribfieldNamesDetail+
                                ') ENGINE=InnoDB ;';

    With commondbLib.TempMyScript do try
      SQL.text := strSQL;
      Execute;
    finally
        free;
    end;

    strSQL:= '';
    strSQL:= STRSQL+CreateTemporaryTableusingfile('' ,
            ' Select ' +
              ' concat(' + quotedStr(AttributeGroups.GroupName)+ ' ,' + sPavFields+' ) as Partname, '+
              'concat(' + quotedStr(AttributeGroups.ProdDesc)+ ' ,'+ quotedStr(' (') +',' + sDesc+',' + quotedStr(')')+  ' ) as ProductDesc, '+
              sAttribfields+
              ' from ' + sPavTables +
              ' where ' +sPavWhere  , 'Partname ,ProductDesc ' + sFieldNames , tmp_pap1 , fsfilename1);

    strSQL:= STRSQL+CreateTemporaryTableusingfile('' ,
           ' Select  distinct pap.productID, pap.productName,' +  sPapFields +
              ' from tblproductattributeproducts pap, ' +sPapTables+
              ' where  '+sPapWhere , 'productID ,productName ' + sFieldNames , tmp_pap2 , fsfilename2);
    (*AppEnv.UtilsClient.DeleteServerFiles(replaceStr(fsfilename1, '.tmp' , '*.tmp'));
    AppEnv.UtilsClient.DeleteServerFiles(replaceStr(fsfilename2, '.tmp' , '*.tmp'));*)
    With commondbLib.TempMyScript do try
      Connection :=AttributeGroups.connection.connection;
      SQL.text := strSQL;
      Execute;
    finally
      free;
      AppEnv.UtilsClient.DeleteServerFiles(replaceStr(fsfilename1, '.tmp' , '*.tmp'));
      AppEnv.UtilsClient.DeleteServerFiles(replaceStr(fsfilename2, '.tmp' , '*.tmp'));
    end;

    Result :=   'Select  t1.*'+
      ' from ' + tmp_pap1 + ' as t1 left join ' + tmp_pap2 + ' as t2 on ' +  sAttribwhere +
      ' where ifnull(t2.productID,0) = 0';

  end;
  
(*  procedure LoopQryValues(Const IndexNo: Integer);
  Var
    CurrentQry :TERPQuery;
    I:Integer;
  Begin
    CurrentQry := TERPQuery(tmpComponentList[IndexNo]);
    CurrentQry.First;
    While Not CurrentQry.Eof do Begin
      grdMemTable.FieldByName(CurrentQry.Name).AsString := CurrentQry.fieldByName('Value').asString;
      If ((tmpComponentList.count-1)>IndexNo) then
        LoopQryValues(IndexNo+1)
      else begin
        FilterStr := AttributeGroups.groupName;
        ProductDesc := AttributeGroups.prodDesc+' (';//FilterStr;
        For I := 0 to tmpComponentList.count-1 do begin
          FilterStr := FilterStr + TERPQuery(tmpComponentList[I]).fieldByName('Abbreviation').asString;
          if ProductDesc <> AttributeGroups.prodDesc+' (' then ProductDesc := ProductDesc + ', ';
          ProductDesc := ProductDesc +TERPQuery(tmpComponentList[I]).fieldByName('Name').asString +':' +  TERPQuery(tmpComponentList[I]).fieldByName('Value').asString;
        end;
        ProductDesc := ProductDesc + ')';
        If (FilterStr <> AttributeGroups.groupName) then begin
          grdMemTable.FieldByName('ProductName').AsString := FilterStr;
          grdMemTable.FieldByName('ProductDesc').AsString := ProductDesc;
        end;
        grdMemTable.Post;
        grdMemTable.Append;
        For I := 0 to tmpComponentList.count-2 do
          grdMemTable.FieldByName(tmpComponentList[I].Name).AsString := TERPQuery(tmpComponentList[I]).fieldByName('Value').asString;
      end;
      CurrentQry.Next;
    end;
  end;*)

begin
  StepProgress;
  tmpComponentList := TComponentList.Create(True);
  tmpStringList := AttributeGroups.GetAttributeNames;
  Try
    If tmpStringList.Count=0 then Exit;
    for I := 0 to tmpStringList.Count-1 do Begin
      attributename := tmpStringList[I];
      qrySQL :=  'SELECT DISTINCT tblproductattributenames.Name, tblproductattributevalues.Value, tblproductattributevalues.Abbreviation '+
                    'FROM  tblproductattributevalues  '+
                    'Inner Join tblproductattributenames ON tblproductattributenames.PAN_ID = tblproductattributevalues.PAN_ID '+
                    'Inner Join tblproductattributegroups ON tblproductattributegroups.PAG_ID = tblproductattributenames.PAG_ID '+
                    'WHERE tblproductattributegroups.Active = "T" AND tblproductattributenames.Active = "T" AND tblproductattributevalues.Active = "T" '+
                    'AND tblproductattributegroups.Name =  "'+AttributeGroups.GroupName+'" '+
                    'AND tblproductattributenames.Name =  "'+attributename+'";';
      qrylookup := TERPQuery.Create(nil);
      qrylookup.Name := 'a' + StringReplace(attributename,' ','_',[rfReplaceAll]);
      qrylookup.Connection := TfmProdAttribMain(Self.Owner).MyConnection;
      qrylookup.SQL.Text := qrySQL;
      qrylookup.Open;
      tmpComponentList.add(qrylookup);
    end;
    StepProgress;
    // Create All Instances
    grdMemTable.Disablecontrols;
    Try
      if AttributeGroups.AttributeNames.count > 0 then 
      (*grdMemTable.LoadFromDataSet(AttributeGroups.GetNewDataset(makeQuery, true), [mtcpoStructure, mtcpoProperties, mtcpoFieldIndex]);*)
      With AttributeGroups.GetNewDataset(makeQuery, true) do try
        if recordcount > 0 then begin
            First;
            While eof = False do begin
              grdMemTable.Append;
              grdMemTable.fieldByname('ProductName').asString := fieldByname('PartName').asString;
              grdMemTable.fieldByname('ProductDesc').asString := fieldByname('ProductDesc').asString;
              grdMemTable.fieldByname('Active').asString :='T';
              for I := 0 to tmpStringList.Count-1 do begin
                grdMemTable.fieldByname(tmpStringList[I]).asString :=fieldByname(tmpStringList[I]).asString;
              end;
              grdMemTable.Post;
              next;
            end;
        end;
      finally
        if active then close;
        free;
      end;
      StepProgress;


      (*grdMemTable.Append;
      LoopQryValues(0);
      grdMemTable.Cancel;

      // Remove All Existing
      Existing := TfmProdAttribMain(Self.Owner).ProductAttributeProducts.grdMemTable;
      Existing.First;
      While Not Existing.Eof do Begin
        FilterStr := '';
        for I := 0 to tmpStringList.Count-1 do begin
          if Existing.findfield(tmpStringList[I]) <> nil then begin
            if FilterStr <> '' then FilterStr := FilterStr + ' and ' ;
            FilterStr := FilterStr + tmpStringList[I] + ' = ' + QuotedStr(Existing.FieldByName(tmpStringList[I]).asString);
          end;
        end;
        if FilterStr <> '' then begin
          grdMemTable.Filter := FilterStr;
          grdMemTable.Filtered := true;
          If grdMemTable.RecordCount>0 then
            grdMemTable.Delete;
          {grdMemTable.Filtered := false;
          grdMemTable.Filter := '';}
        end;
        Existing.Next;
      end;*)
    finally
        grdMemTable.Enablecontrols;
    end;
  finally
    grdMemTable.Filtered := false;
    grdMemTable.Filter := '';
    tmpStringList.Free;
    tmpComponentList.Free;
  end;
  StepProgress;
  for I := 0 to grdMemTable.FieldCount-1  do Begin
    grdMemTable.Fields[I].ReadOnly := True;
  end;
  grdMemTable.FieldByName('ProductName').ReadOnly := False;

  grdMemTable.First;
  If grdMemTable.RecordCount>0 then
    grdMemTable.Edit
  else
    grdMemTable.Insert;
  StepProgress;
end;


procedure TfmProdAttribCreateProducts.btnCreateClick(Sender: TObject);
begin
  CreateProducts;
end;

Function TfmProdAttribCreateProducts.CreateProducts:Boolean;
Var
  I,J: Integer;
  tmpStringList: TStringList;
  BusObj: TProductAttributes;
  ProdBusObj: TProduct;
  ProgressDialog   : TProgressDialog;
  strSQL:String;
begin
  inherited;
  Result := True;
  if (Appenv.CompanyPrefs.DefaultPurchaseTaxCode = '') or (Appenv.CompanyPrefs.DefaultSalesTaxCode = '') then begin
    CommonLib.MessageDlgXP_Vista('The Detault sales and Purchase Tax codes are not selected in the Preferences. Product can be  created only if you have the defaults.', mtInformation, [mbOK], 0);
    Result := False;
    Exit;
  end;
  if dbgAttribNewProducts.SelectedList.Count = 0 then begin
    CommonLib.MessageDlgXP_Vista('No products have been selected.', mtInformation, [mbOK], 0);
    Result := False;
    Exit;
  end;
  if AppEnv.AccessLevels.GetEmployeeAccessLevel(TProduct.Classname) >= 5 then begin
    CommonLib.MessageDlgXP_Vista('You Don''t Have Access To Create Product.', mtInformation, [mbOK], 0);
    Result := False;
    Exit;
  end;

  ProgressDialog := TProgressDialog.Create(Self);
  BusObj := TfmProdAttribMain(Self.Owner).AttributeProducts;
  ProdBusObj := TProduct.Create(nil);
  ProdBusObj.connection := TMyDacDataconnection.Create(ProdBusObj);
  ProdBusObj.Connection.connection := BusObj.Connection.Connection;

  TmpStringList := AttributeGroups.GetAttributeNames;
  Try
    ProgressDialog.Caption := 'Please Wait .......';
    ProgressDialog.MinValue := 0;
    ProgressDialog.MaxValue := dbgAttribNewProducts.SelectedList.Count;
    ProgressDialog.Step := 1;
    ProgressDialog.Execute;
    for J := 0 to dbgAttribNewProducts.SelectedList.Count - 1 do begin
      ProgressDialog.StepIt;
      if not grdMemTable.BookmarkValid(dbgAttribNewProducts.SelectedList.Items[J]) then Continue;
      grdMemTable.GotoBookmark(dbgAttribNewProducts.SelectedList.Items[J]);
      // Create Product
      ProdBusObj.LoadSelect('Partname = ' +quotedStr(grdMemTable.FieldByName('ProductName').AsString));
      if ProdBusObj.count = 0 then begin
        ProdBusObj.New;
        ProdBusObj.ProductType := AttributeGroups.PartType;//  'INV';
        ProdBusObj.ProductName := grdMemTable.FieldByName('ProductName').AsString;
        ProdBusObj.ProductPrintName := grdMemTable.FieldByName('ProductName').AsString;
        ProdBusObj.PurchaseDescription := grdMemTable.FieldByName('ProductDesc').AsString;
        ProdBusObj.SalesDescription := grdMemTable.FieldByName('ProductDesc').AsString;
        ProdBusObj.DateCreated := Now();
        ProdBusObj.Active := True;
        ProdBusObj.PostDb;
        ProdBusObj.Save;
      end else begin
        strSQL:= 'SELECT * FROM tblproductattributeproducts ' +
                  ' WHERE  ProductID =  ' + IntToStr(ProdBusObj.ID) (*+
                  ' and (PAG_ID<> ' +IntToStr(AttributeGroups.ID) +
                  ' or groupname <> '+ QuotedStr(grdMemTable.FieldByName('ProductName').AsString) +
                  ' or  AttribName <> ' + QuotedStr(tmpStringList[I]) +
                  ' and attribValue <> '+ QuotedStr(grdMemTable.FieldByName(tmpStringList[I]).AsString)+')'*) ;
        with ProdBusObj.getnewDataset(strSQL,true) do try
          if recordcount > 0 then begin
              strSQL:=    grdMemTable.FieldByName('ProductName').AsString + ' belongs to another group/Attribute' + chr(13) +
                          #9+'Group Name   : ' + FieldByname('Groupname').asSTring+chr(13) +
                          #9+'Attrib Name    : ' + FieldByname('AttribName').asSTring+chr(13) +
                          #9+'Atrrib Value    : ' + FieldByname('attribValue').asSTring +chr(13)+chr(13) +
                          'It is not possible to have one product for different group(s)/Attribute(s)';
              MessageDlgXP_Vista(strSQL, mtInformation , [mbok] , 0);
              continue; {this product cannot be processed - so skip it}
          end else begin
            ProdBusObj.PurchaseDescription := grdMemTable.FieldByName('ProductDesc').AsString;
            ProdBusObj.SalesDescription := grdMemTable.FieldByName('ProductDesc').AsString;
            ProdBusObj.PostDB;
          end;
        finally
          if active then close;
          Free;
        end;

      end;
      // Create Link
      for I := 0 to tmpStringList.Count-1 do Begin
        BusObj.New;
        BusObj.GroupName := AttributeGroups.groupName;
        BusObj.ProductName := grdMemTable.FieldByName('ProductName').AsString;
        BusObj.AttribName := tmpStringList[I];
        BusObj.attribValue := grdMemTable.FieldByName(tmpStringList[I]).AsString;
        if ProdBusObj.Active then Busobj.Active := True else  Busobj.Active := False;
        BusObj.postDB;
      end;
    end;
  finally
    AttributeGroups.dirty:= true;
    TmpStringList.Free;
    ProdBusObj.Free;
    ProgressDialog.Free;
    dbgAttribNewProducts.UnselectAll;
    TfmProdAttribMain(Self.Owner).ProductAttributeProducts.SetupGrid;
    SetupGrid;
  end;

end;

procedure TfmProdAttribCreateProducts.SelectAll1Click(Sender: TObject);
begin
  inherited;
  dbgAttribNewProducts.SelectAll;
end;

procedure TfmProdAttribCreateProducts.DeselectAll1Click(Sender: TObject);
begin
  inherited;
  dbgAttribNewProducts.UnselectAll;
end;

procedure TfmProdAttribCreateProducts.chkSelectAllClick(Sender: TObject);
begin
  if screen.activecontrol <> sender then exit;
(*  if chkSelectAll.Checked then begin
    dbgAttribNewProducts.SelectAll
  end else begin
    dbgAttribNewProducts.UnselectAll;
  end;*)
  MultiSelectRecord(chkSelectAll, dbgAttribNewProducts, chkSelectAll);

end;

Function TfmProdAttribCreateProducts.OnTabchange:boolean ;
begin

  if (dbgAttribNewProducts.SelectedList.Count = 0) and (AttributeGroups.AttributeProducts.count = 0 )  then
      if CommonLib.MessageDlgXP_Vista('No products have been selected. Do you wish to select Products?', mtconfirmation, [mbyes, mbNo], 0) = mrYes then begin
         REsult := false;
         Exit;
      end;
  Result := True;
  if dbgAttribNewProducts.SelectedList.Count > 0  then begin
      REsult := CreateProducts;
  end;

end;

procedure TfmProdAttribCreateProducts.dbgAttribNewProductsMultiSelectRecord(
  Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  chkSelectAll.Checked := Grid.selectedlist.count=Grid.Datasource.dataset.RecordCount;
end;

procedure TfmProdAttribCreateProducts.dbgAttribNewProductsMouseUp(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  MultiSelectRecord(Sender,dbgAttribNewProducts , chkSelectAll );
end;

procedure TfmProdAttribCreateProducts.dbgAttribNewProductsKeyUp(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if ((Shift = [ssCtrl]) and ((Chr(Key)='A') or (Chr(Key)='a'))) then
      dbgAttribNewProducts.SelectAll
  else MultiSelectRecord(Sender,dbgAttribNewProducts , chkSelectAll );

end;

procedure TfmProdAttribCreateProducts.ClearSelection;
begin
  dbgAttribNewProducts.UnselectAll;
end;

initialization
  RegisterClassOnce(TfmProdAttribCreateProducts);
end.




