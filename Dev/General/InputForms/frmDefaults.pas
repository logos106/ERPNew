unit frmDefaults;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusobjcolumnHeadings, BusObjBase, Mask, wwdbedit, wwdblook;

type
  TfmDefaults = class(TBaseInputGUI)
    Qrycolumnheadings: TERPQuery;
    QrycolumnheadingsGlobalRef: TWideStringField;
    QrycolumnheadingsColumnheadingsID: TIntegerField;
    QrycolumnheadingsFirstColumn: TWideStringField;
    QrycolumnheadingsSecondColumnName: TWideStringField;
    QrycolumnheadingsThirdColumnName: TWideStringField;
    QrycolumnheadingsPartColumnName: TWideStringField;
    QrycolumnheadingsCustomerColumnName: TWideStringField;
    QrycolumnheadingsSupplierColumnName: TWideStringField;
    QrycolumnheadingsProspectColumnName: TWideStringField;
    QrycolumnheadingsDefaultClass: TWideStringField;
    QrycolumnheadingsDefaultUOM: TWideStringField;
    QrycolumnheadingsClassHeading: TWideStringField;
    QrycolumnheadingsmsTimeStamp: TDateTimeField;
    QrycolumnheadingsmsUpdateSiteCode: TWideStringField;
    qryuom: TERPQuery;
    qryclass: TERPQuery;
    dscolumnheadings: TDataSource;
    qryBranchCode: TERPQuery;
    qryBranchCodeBEDefault: TWideStringField;
    qryBranchCodeSiteCode: TWideStringField;
    qryBranchCodeSiteDesc: TWideStringField;
    qryBranchCodeEmailAddressData: TWideStringField;
    qryBranchCodeEmailUsername: TWideStringField;
    qryBranchCodeEmailPassword: TWideStringField;
    qryBranchCodeConflictTodoUserId: TIntegerField;
    qryBranchCodeBackEndID: TAutoIncField;
    DSBranchCode: TDataSource;
    qryclassclassname: TWideStringField;
    qryclasssitecode: TWideStringField;
    DNMPanel4: TDNMPanel;
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel1: TDNMPanel;
    lbldefaultUOM: TLabel;
    lbldefaultclass: TLabel;
    edtSitecode: TwwDBEdit;
    cboUOM: TwwDBLookupCombo;
    cbodept: TwwDBLookupCombo;
    DNMPanel3: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    Label1: TLabel;
    lblmsg: TLabel;
    qryclassclassid: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure QrycolumnheadingsAfterOpen(DataSet: TDataSet);
    procedure cbodeptCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
      modified: Boolean);
    procedure cbodeptNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: string; var Accept: Boolean);
    procedure cboUOMNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: string; var Accept: Boolean);
    procedure edtSitecodeEnter(Sender: TObject);
    procedure cbodeptEnter(Sender: TObject);
    procedure cboUOMEnter(Sender: TObject);
    procedure cboUOMExit(Sender: TObject);
    procedure cbodeptExit(Sender: TObject);
    procedure edtSitecodeExit(Sender: TObject);
  private
    Columnheadings: Tcolumnheadings;
    function SaveRecord: Boolean;
    Function ValidateData:Boolean;
    function CreateUOMifmissing:Boolean;
    function CreateClassifmissing:Boolean;
    function getdefaultclass: String;
    function getdefaultuom: string;
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    Property defaultuom :string read getdefaultuom;
    Property defaultclass :String read getdefaultclass;
  end;


implementation

uses CommonLib, BusObjConst, AppEnvironment, BusobjUOM, BusObjStock,
  BusObjClass, LogLib, tcConst, DbSharedObjectsObj, BusObjProductClass,
  PreferancesLib;

{$R *.dfm}

procedure TfmDefaults.cbodeptCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  editdb(qryBranchCode);
  qryBranchCodeSiteCode.AsString:= qryclasssitecode.AsString;
  PostDb(qryBranchCode);
end;

procedure TfmDefaults.cbodeptEnter(Sender: TObject);
begin
  inherited;
  TimerMsg(lblmsg, 'Either Select from Dropdown or Type in to Create New');
end;

procedure TfmDefaults.cbodeptExit(Sender: TObject);
begin
  inherited;
  tmrProcessMessageTimer(tmrProcessMessage);
end;

procedure TfmDefaults.cbodeptNotInList(Sender: TObject; LookupTable: TDataSet;
  NewValue: string; var Accept: Boolean);
begin
  inherited;
  Accept:= True;
end;

procedure TfmDefaults.cboUOMEnter(Sender: TObject);
begin
  inherited;
  TimerMsg(lblmsg, 'Either Select from Dropdown or Type in to Create New');
end;

procedure TfmDefaults.cboUOMExit(Sender: TObject);
begin
  inherited;
  tmrProcessMessageTimer(tmrProcessMessage);
end;

procedure TfmDefaults.cboUOMNotInList(Sender: TObject; LookupTable: TDataSet;
  NewValue: string; var Accept: Boolean);
begin
  inherited;
  Accept:= True;
end;

procedure TfmDefaults.cmdCancelClick(Sender: TObject);
begin
  inherited;
  if MessageDlgXP_Vista('You cannot start ERP before setting the company defaults.'+
                        ' Cancelling here will terminate ERP. Do you want to Cancel? ', mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;
  RollbackTransaction;
  Columnheadings.Dirty := false;
  if fsModal in formstate then Modalresult := mrcancel else self.Close;
end;

Function TfmDefaults.SaveRecord :Boolean;
begin
  Columnheadings.PostDB;
  PostDB(qryBranchCode);
  result := False;
  Columnheadings.Connection.BeginNestedTransaction;
  try
    if not(self.ValidateData) then exit;

      if not(CreateUOMifmissing) then Exit;
      if not(Createclassifmissing) then  Exit;
      Columnheadings.Dirty := False;
      Result := true;
  finally
    if not result then
      Columnheadings.Connection.RollbackNestedTransaction;
  end;


  if not(Columnheadings.Save) then exit;
  Result:= True;

end;

function TfmDefaults.ValidateData: Boolean;
begin
  Result := False;
  if cboUOM.Text = '' then begin
    MessageDlgXP_vista('Default Unit of measure cannot be blank', mtWarning, [mbOK], 0);
    SetcontrolFocus(cboUOM);
    Exit;
  end;

  if cbodept.Text = '' then begin
    MessageDlgXP_vista('Default '+ Appenv.DefaultClass.ClassHeading  +' cannot be blank', mtWarning, [mbOK], 0);
    SetcontrolFocus(cbodept);
    Exit;
  end;

  if edtSitecode.Text = '' then begin
    MessageDlgXP_vista('Default '+ Appenv.DefaultClass.ClassHeading  +' cannot be blank', mtWarning, [mbOK], 0);
    SetcontrolFocus(cbodept);
    Exit;
  end;

  if Qryclass.locate('classname' , cbodept.text , []) then begin
    if not(TDeptClass.SiteCodeUnique(edtSitecode.text ,qryclassclassID.asInteger ,Columnheadings.Connection.connection)) then begin
      MessageDlgXP_vista('Site Code selected doesn''t belong to the '+ Appenv.DefaultClass.ClassHeading  +' ' + Quotedstr(cboDept.text)+'.', mtWarning, [mbOK], 0);
      SetcontrolFocus(cbodept);
      Exit;
    end;
  end else begin
    if not(TDeptClass.SiteCodeUnique(edtSitecode.text ,0 ,Columnheadings.Connection.connection)) then begin
      MessageDlgXP_vista('Site Code selected ' +quotedstr(edtsitecode.text) +' is already assigned to another '+ Appenv.DefaultClass.ClassHeading  +'.  Sitecode should be unique. ', mtWarning, [mbOK], 0);
      SetcontrolFocus(cbodept);
      Exit;
    end;
  end;

  Result := True;

end;

procedure TfmDefaults.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  PreferancesLib.DoPrefAuditTrail;
  Columnheadings.Connection.CommitTransaction;
  Appenv.CompanyPrefs.CompanyDefaultsSelected := True;
  Appenv.DefaultClass.PopulateMe;
  if fsModal in formstate then Modalresult := mrOk else self.Close;
end;

function TfmDefaults.CreateClassifmissing: Boolean;
var
  classobj :TDeptClass;
  fScript :TERPScript;
  PC,PC1, PC2 :TProductclass;
begin
DoShowProgressbar(20, 'Updating for new Default '+ Appenv.DefaultClass.ClassHeading);
try
  result := true;

  {create new class if not ecists }
  Classobj := TDeptClass.Create(Self);
  try
    DoStepProgressbar('Check and create '+ Appenv.DefaultClass.ClassHeading+' ' +defaultclass);
    classobj.Connection:= Columnheadings.Connection;
    classobj.Loadselect('ClassName =' +quotedstr(defaultclass));
    if classobj.count >0 then begin
      if classobj.active =False then classobj.active := True;
      classobj.postdb;
    end else begin
      classobj.New;
      classobj.DeptClassName:= defaultclass;
      classobj.SiteCode := edtSitecode.Text ;
      classobj.Active := True;
      classobj.postdb;
      if not classobj.save then begin
        REsult := False;
        Exit;
      end;
    end;


    try
      if not (sametext(appenv.DefaultClass.DefaultClassName , classobj.DeptClassName)) then begin
          DoStepProgressbar('updating Product classes');
          PC  := TProductclass.Create(Self);
          PC1 := TProductclass.Create(Self);
          PC2 := TProductclass.Create(Self);
          try
            if not(sametext(appenv.DefaultClass.DefaultClassName ,  classobj.DeptClassName)) then begin
                PC.Connection := classobj.Connection;
                PC1.Connection := classobj.Connection;
                PC2.Connection := classobj.Connection;
                PC1.LoadSelect('classname =' + quotedStr(appenv.DefaultClass.DefaultClassName));
                if PC1.count =0 then exit;
                PC2.LoadSelect('classname =' + quotedStr(classobj.DeptClassName));
                PC1.First;
                PC2.AddNewinLoadFromXML := False;

                While PC1.Eof  =False do begin
                  DoStepProgressbar(PC1.ProductName);
                  if PC1.DeptID <> 0 then begin
                    if not PC2.locate('ProductId' ,Pc1.ProductId , [] ) then begin
                      PC2.New;
                      PC2.XML := PC1.XML;
                      PC2.DeptName :=classobj.DeptClassName;
                      PC2.PostDB;
                    end;
                  end;
                  (*PC1.Active := False;
                  PC1.PostDB;*)
                  PC1.Next;
                end;
            end;
          Except
            on E:Exception do begin
              columnheadings.Resultstatus.addItem(False, rsswarning, 0, 'Failed to create ' + appenv.DefaultClass.Classheading+' for ' + appenv.DefaultClass.PartColumn +' ' +quotedstr(PC2.Productname)+NL+E.message);
              Result := False;
              Exit;
            end;
          end;
      end;
    finally
      FreeandNil(PC);
      FreeandNil(PC1);
      FreeandNil(PC2);
    end;
    fScript := DbSharedObj.GetScript(classobj.Connection.Connection);
    try
      fScript.SQL.Text := 'update tblemployees '+
                          ' Set DefaultClassID ='+ inttostr(Classobj.ID)+' ,  '+
                          ' DefaultClassName =' + Quotedstr(classobj.DeptClassName)+'  '+
                          ' where Defaultclassname =' +QuotedStr(appenv.DefaultClass.DefaultClassName)+';';
      fScript.SQL.Add('delete from tblclass  where classname <> ' +Quotedstr(classobj.DeptClassName)+';');
      fScript.SQL.Add('delete from tblproductclasses  where classId not in (select Classid from tblclass); ');
      fScript.SQL.Add('delete from tblpartsclasspreferences  where classId not in (select Classid from tblclass); ');
      fScript.Execute;
    finally
      DbSharedObj.ReleaseObj(fScript);
    end;

    (*try
        classobj.LoadSelect('classname =' +quotedstr(appenv.DefaultClass.DefaultClassName));
        if classobj.count =1 then begin
          classobj.Active := False;
          classobj.PostDB;
        end;
    Except
        on E:Exception do begin
          columnheadings.Resultstatus.addItem(False, rsswarning, 0, 'Failed to inactivate default class  ' + quotedstr(classobj.DeptClassName)+NL+E.message);
          Result := False;
          Exit;
        end;
    end;*)

    Result := True;
  finally
    Freeandnil(classobj);
  end;
finally
  DoHideProgressbar;
end;

end;

function TfmDefaults.CreateUOMifmissing: Boolean;
var
  uom, uomlist1, uomlist2 :TUnitOfMeasure;
begin
DoShowProgressbar(20, 'Updating for new Default '+ Appenv.DefaultClass.ClassHeading);
try
  Result := true;
  uom := TUnitOfMeasure.Create(Self);
  try
    DoStepProgressbar('Check and create UOM ' +defaultuom);
    uom.Connection := Columnheadings.Connection;
    uom.LoadSelect('UnitName =' +quotedstr(defaultuom) +' and ifnull(PartID,0)=0');
    if uom.Count >0 then begin
      if uom.Multiplier<> 1 then begin
        Result := False;
        MessageDlgXP_vista(defaultuom +' already exists with a multiplier '+floattoStr(uom.Multiplier)+'. Default UOM should have multiplier 1', mtWarning, [mbOK], 0);
        Exit;
      end;
      if not uom.Active then begin
        uom.Active := true;
        uom.PostDb;
      end;

      result := True;
    end else begin
      uom.New;
      uom.UOMName:= defaultuom;
      uom.Multiplier:= 1;
      uom.Postdb;
      if not uom.Save then begin
        result := False;
        Exit;
      end;
    end;



    Try
      DoStepProgressbar('updating Product UOMs');
      uomlist1 := TUnitOfMeasure.Create(Self);
      uomlist2 := TUnitOfMeasure.Create(Self);
      try
        uomlist1.Connection := uom.Connection;
        uomlist2.Connection := uom.Connection;
        uomlist1.LoadSelect('unitname =' + quotedStr(appenv.DefaultClass.DefaultUOM));
        if uomlist1.count =0 then exit;
        uomlist2.LoadSelect('unitname =' + quotedStr(defaultuom));
        uomlist1.First;
        While uomlist1.Eof  =False do begin
          DoStepProgressbar('updating '+ uomlist1.ProductName);
          if uomlist1.PartId <> 0 then begin
            if not uomlist2.locate('PartID' ,uomlist1.PartId , [] ) then
              uomlist2.New;
            uomlist2.XML := Uom.XML;
            uomlist2.PartId :=uomlist1.PartId;
            uomlist2.SalesDefault := true;
            uomlist2.PurchasesDefault := true;
            uomlist2.PostDB;
          end;
          if defaultuom <> appenv.DefaultClass.DefaultUOM then begin
            uomlist1.Active := False;
            uomlist1.PostDB;
          end;
          uomlist1.Next;
        end;
      Except
        on E:Exception do begin
          columnheadings.Resultstatus.addItem(False, rsswarning, 0, 'Failed to create Unit of Measure for ' + appenv.DefaultClass.PartColumn +' ' +quotedstr(uomlist2.Productname)+NL+E.message);
          Result := False;
          Exit;
        end;
      end;

      UOM.executeSQL('update tblproctree PT  '+
                     ' inner join tblunitsofmeasure UOM on PT.PartsId = UOM.PartID and UOM.UnitName = '+quotedstr(defaultuom) + '  '+
                     ' Set PT.TreePartUOMID = UOM.UnitID, PT.TreePartUOM = UOM.UnitName  '+
                     ' where PT.TreePartUOM <> '+quotedstr(defaultuom) + ';' , true);
      UOM.ExecuteSQL(
        'Update tblunitsofmeasure set Active = "F" where UnitName <> ' + QuotedStr(defaultuom) +';',
        true
      );

    finally
      FreeandNil(uomlist1);
      FreeandNil(uomlist2);
    end;
    result := True;
  finally
    freeandnil(uom);
  end;
finally
  DoHideProgressbar;
end;

end;

procedure TfmDefaults.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
      inherited;
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is Tcolumnheadings then Tcolumnheadings(Sender).Dataset  := Qrycolumnheadings;
     end;
end;

procedure TfmDefaults.edtSitecodeEnter(Sender: TObject);
begin
  inherited;
  if sametext(cbodept.Text,  qryclassClassname.AsString)  then
    TimerMsg(lblmsg, 'Sitecode cannot be changed as the ' + Appenv.DefaultClass.ClassHeading+' already exists')
  else if (trim(cbodept.Text) ='') then
    TimerMsg(lblmsg, 'Please select the ' + Appenv.DefaultClass.ClassHeading+' before changing the sitecode');
  edtSitecode.ReadOnly := sametext(cbodept.Text,  qryclassClassname.AsString)  or (trim(cbodept.Text) ='');
end;

procedure TfmDefaults.edtSitecodeExit(Sender: TObject);
begin
  inherited;
  tmrProcessMessageTimer(tmrProcessMessage);
end;

procedure TfmDefaults.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if Columnheadings.Dirty then begin
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
          Columnheadings.Dirty := false;
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

procedure TfmDefaults.FormCreate(Sender: TObject);
begin
  inherited;
  {$WARNINGS OFF}
  Columnheadings := Tcolumnheadings.CreateWithNewConn(Self);
  Columnheadings.Connection.connection := Self.MyConnection;
  Columnheadings.BusObjEvent := DoBusinessObjectEvent;
  {$WARNINGS ON}
end;
procedure TfmDefaults.FormShow(Sender: TObject);
begin
  inherited;
  Columnheadings.Load;
  openQueries;
  Columnheadings.connection.BeginTransaction;
  if Columnheadings.count=0 then begin
    Columnheadings.new;
    Columnheadings.FirstColumn          := 'Manufacture';
    Columnheadings.SecondColumnName     := 'Type';
    Columnheadings.ThirdColumnName      := 'Dept';
    Columnheadings.PartColumnName       := 'Product';
    Columnheadings.CustomerColumnName   := 'Customer';
    Columnheadings.SupplierColumnName   := 'Supplier';
    Columnheadings.ProspectColumnName   := 'Prospect';
    Columnheadings.DefaultClass         := Qryclassclassname.AsString;
    Columnheadings.ClassHeading         := 'Department';
(*    Columnheadings.ComField1Name        := '';
    Columnheadings.ComField2Name        := '';
    Columnheadings.ComField3Name        := '';
    Columnheadings.ComField4Name        := '';
    Columnheadings.CommAgg1             := '+';
    Columnheadings.CommAgg2             := 'X';
    Columnheadings.CommAgg3             := '-';
    Columnheadings.CommAgg4             := '/';*)
    Columnheadings.PostDB;
    Appenv.DefaultClass.PopulateMe;
  end;
  qryclass.Locate('classname' , Columnheadings.DefaultClass , []);
end;

function TfmDefaults.getdefaultclass: String;
begin
    result := cbodept.Text;
end;

function TfmDefaults.getdefaultuom: string;
begin
  Result := cboUOM.Text;
end;

procedure TfmDefaults.QrycolumnheadingsAfterOpen(DataSet: TDataSet);
begin
  inherited;
logtext(dataset.Name);
end;

(*initialization
  RegisterClassOnce(TfmDefaults);*)

end.

