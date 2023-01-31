unit UOMList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  AdvSmoothToggleButton, wwclearbuttongroup, wwradiogroup;

type

  TUOMMergerec = Record
    ProductID :Integer;
    UOMIDsToMerge :String;
  End;

  TUOMListGUI = class(TBaseListingGUI)
    DNMSpeedButton1: TDNMSpeedButton;
    btnDelete: TDNMSpeedButton;
    DNMSpeedButton3: TDNMSpeedButton;
    btnshowtables: TDNMSpeedButton;
    btnAdjUOM: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure DNMSpeedButton3Click(Sender: TObject);
    procedure btnshowtablesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAdjUOMClick(Sender: TObject);
  private
    fsTablename:String;
    UOMfieldnames:TStringlist;
    uomnametomerge :String;
    UOMMergerecs : Array of TUOMMergerec;
    Procedure checkTableforUOM(const Tablename:String);
    procedure CheckforUOM(const Tablename, fieldname: String);
    procedure SelectUOMNameToMerge(Sender: TwwDBGrid);
    procedure PopulateUOMMergerecs;
    procedure PopulatefieldList(const Value:Boolean);
    function getshowTables: boolean;
    procedure setShowTables(const Value: boolean);
    procedure BackupUOMs;
    Property ShowTables:boolean read getshowTables write setShowTables;
  Protected
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, CommonDbLib, LogLib, tcConst, AppDatabase, CommonFormLib,BusobjUOM, MergeObj, MAIN, dmMainGUI, AppEnvironment, UserUtilsClientObj,
  DbSharedObjectsObj, DebugLib;

{$R *.dfm}

procedure TUOMListGUI.checkTableforUOM(const Tablename: String);
begin
  DoStepProgressbar(Tablename);
  TablefieldListProcess(tablename, 'UnitOfMeasureID,UOMID,TreePartUOMID',CheckforUOM);
end;

Procedure TUOMListGUI.PopulatefieldList(const Value:Boolean);
var
  ctr:Integer;
  function uomfieldname(const Value:String):String;
  begin
     result := copy(value , pos('_',value)+1 , length(value ));
  end;
  function UOMTablename(const Value:String):String ;
  begin
     result := copy(value ,1, pos('_',value)-1);
  end;
begin

  FieldList := TStringList.Create;
  try
//    AddGridSelectedfield('ListUOMID', 10, 'Unit #');
    AddGridSelectedfield('Partname', 20, 'Product');
    AddGridSelectedfield('unitname', 10, 'UOM');
    AddGridSelectedfield('Active', 1, 'Active ?');

    if Value then
    //if chkshowtables.checked then
      if  UOMfieldnames.count >0  then
        for ctr:= 0 to UOMfieldnames.count-1 do
          AddGridSelectedfield(UOMfieldnames[ctr], 10, uomfieldname(UOMfieldnames[ctr]) , UOMTablename(UOMfieldnames[ctr]));

    grdMain.Selected.Text := fieldlist.Text;
    grdMain.ApplySelected;
  finally
    FreeandNil(FieldList);
  end;
  grdMain.SetControlType('Active', fctCheckBox, 'T;F');
  if  UOMfieldnames.count >0  then
    for ctr:= 0 to UOMfieldnames.count-1 do
      grdMain.SetControlType(UOMfieldnames[ctr], fctCheckBox, 'T;F');

end;

procedure TUOMListGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  if grpFilters.ItemIndex = 2 then grpFilters.ItemIndex := 0;
  IterateProcno := 1;
  Iteraterecords;
end;
Procedure TUOMListGUI.BackupUOMs;
var
  aTablename:String;
begin
  aTableName := FixTableName('tblunitsofmeasure', '');
  ExecuteSQL('Create table if not exists ' + aTableName +' like   tblunitsofmeasure;' +
            'insert ignore into ' + aTableName +' Select * from tblunitsofmeasure;' );
end;

procedure TUOMListGUI.btnAdjUOMClick(Sender: TObject);
begin
  OpenERPForm('TfmAdjustUOM'            , 0);
  closeWait;
end;

procedure TUOMListGUI.btnDeleteClick(Sender: TObject);
begin
  inherited;
  BackupUOMs;
  Iterateprocno:= 2;
  scriptmain.SQL.Clear;
  IterateselectedRecords;
  if scriptmain.SQL.count >0 then begin
    showProgressbar('Deleting '+ inttostr(scriptmain.SQL.count) +' UOM records' , scriptmain.SQL.count);
    try
      scriptmain.Execute;
    finally
      HideProgressbar;
    end;
    RefreshQuery;
  end;
end;

procedure TUOMListGUI.DNMSpeedButton3Click(Sender: TObject);
var
  s:String;
  ctr:Integer;
  UOM:TUnitOfMeasure;
  UOMList:TUnitOfMeasure;
  MergeObj : TMergeObj;
  msg:String;
  st:TStringlist;
  fqrySchema:TErpQuery;
  IdsMerged:String;
begin
  inherited;
  clog(formatDatetime('dd-mm-yy hh:nn:ss' , now));
  BackupUOMs;
  IdsMerged := '';
  if grdMain.SelectedList.Count < 1  then exit;

  if not AppEnv.UtilsClient.LockLogon(msg,AppEnv.AppDb.Database, 'Performing a Merge Unit of Measure') then begin
    if msg = USERS_IN_SYSTEM_MESSAGE then begin
      MainForm.GetCurrentUserCount;
      dtmMainGUI.dlgCurrentUsers.Caption := qryMain.Connection.Database + ' Merge Unit of Measure';
      dtmMainGUI.dlgCurrentUsers.Color := pnlHeader.Color;
      dtmMainGUI.dlgCurrentUsers.Message := 'The following user(s) must exit the system.';
      dtmMainGUI.dlgCurrentUsers.Execute;
    end else begin
      MessageDlgXP_Vista('Unable to merge Unit of Measure, Unable to Lock User Logon: ' + msg, mtInformation, [mbOk], 0);
    end;
  end;
  try
        uomnametomerge := '';
        OpenERPListFormSingleselectModal('TUOMSummaryListGUI' , SelectUOMNameToMerge , nil, true);
        if uomnametomerge = '' then exit;
        st:=TStringlist.Create;
        try
          showProgressbar(WAITMSG , 100);
          try
            PopulateUOMMergerecs;
            DoStepProgressbar('');
            if (Length(UOMMergerecs)=0) then exit;

            UOM:= TUnitOfMeasure.CreateWithNewConn(self);UOMList:= TUnitOfMeasure.Create(Self);MergeObj := TMergeObj.Create;
            try
              DoStepProgressbar;
              UOMlist.Connection := UOM.Connection;
              fqrySchema:= TErpQuery.Create(self);
              fqrySchema.Connection := UOM.Connection.Connection;
              try
                  for ctr:= low(UOMMergerecs) to high(UOMMergerecs) do begin
                      Logtext(inttostr(ctr)+' of ' + inttostr(high(UOMMergerecs))+ ':' +inttostr(UOMMergerecs[ctr].ProductID));
                      UOM.LoadSelect('PartID =' + inttostr(UOMMergerecs[ctr].ProductID)+' and Unitname = ' + quotedstr(uomnametomerge));
                      UOMlist.Loadselect('UnitID in (' +UOMMergerecs[ctr].UOMIDsToMerge+')');
                      if UOMlist.count =0 then Continue;
                      UOMlist.first;
                      if (UOM.count =0) or (UOM.active =False) then begin
                        UOM.Connection.BeginTransaction;
                        try
                          UOM.CreateNewUOM(UOMlist.PartId, uomnametomerge, UOMlist.Multiplier, UOMlist.UnitDescription, UOMlist.BaseUnitName);
                          if UOM.count =0 then begin
                            UOM.Connection.RollbackTransaction;
                            Continue;
                          end;
                          UOM.Connection.CommitTransaction;
                        Except
                          on E:Exception do begin
                            UOM.Connection.RollbackTransaction;
                          end;
                        end;
                      end;
                        while UOMList.EOF = False do begin
                            DoStepProgressbar(inttostr(ctr) +' / ' + inttostr(high(UOMMergerecs))+' - Merging : ' + UOMList.UnitProductKeyName + '-> ' + UOM.UnitProductKeyName);
                            if UOMList.Id  <> UOM.ID then
                              if not UOM.IsOkToMerge(TERPQuery(UOMList.dataset),msg) then
                                st.Add(UOMList.UnitProductKeyName + '-> ' + UOM.UnitProductKeyName +':' +MSG)
                              else begin
                                MergeObj.Merge(mUOM, UOM.UOMName, UOM.ID, UOMList.UOMName, UOMList.ID ,fqrySchema , inttostr(ctr) +' / ' + inttostr(high(UOMMergerecs))+' - Merging :' +UOMList.UnitProductKeyName + '-> ' + UOM.UnitProductKeyName);
                                if IdsMerged <> '' then IdsMerged:= IdsMerged +',';
                                IdsMerged:= IdsMerged + inttostr(UOMList.Id);
                                //if Qrymain.Locate('ListUOMID' , UOMList.Id, []) then grdMain.SelectRecord;
                              end;
                            UOMList.Next;
                        end;
                  end;
              finally
                Freeandnil(fqrySchema)
              end;
            finally
              Freeandnil(UOM);
              Freeandnil(UOMList);
              Freeandnil(MergeObj);
            end;
            s:= '';
            HideProgressbar;
            logtext(formatDatetime('dd-mm-yy hh:nn:ss' , now));
            if st.Count > 0 then
              MessageDlgXP_vista('The Following are not merged.'+Nl + St.Text , mtWarning , [mbok],0);

            //if grdMain.SelectedList.Count >= 1  then
            if IdsMerged <> '' then begin
              if MessageDlgXP_vista(inttostr(grdMain.SelectedList.Count) +' UOM(s) are merged into '+ quotedstr(uomnametomerge)+'. The original records are made inactive.'+
                                    NL+NL+'Do you want to physically delete these UOMs(s)?', mtConfirmation , [mbyes, mbNo] , 0) = mrYEs then
                  with Scriptmain do begin
                    SQL.clear;
                    SQL.add('delete from tblunitsofmeasure where UnitId in (' +IdsMerged+')');
                    Execute;
                  end;
              grdmain.UnselectAll;
              RefreshQuery;
            end;
          finally
            Freeandnil(st);
          end;
        finally
          HideProgressbar;

        end;
  finally
    AppEnv.UtilsClient.UnlockLogon;
  end;
end;

procedure TUOMListGUI.PopulateUOMMergerecs;
var
  s:String;
  Qry :TERPQuery;
begin
  DoStepProgressbar('Populating UOM records to Merge');
  SetLength(UOMMergerecs , 0);

  s:= SelectedIds('listuomid');
  if s= '' then exit;

  //With SharedQryObj('select * from tblunitsofmeasure where unitId in (' + s + ') order by partId') do try
  Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
  try
      with Qry do begin
        SQL.Text :='select * from tblunitsofmeasure where unitId in (' + s + ') order by partId';
        if recordcount =0 then exit;
        open; 
        first;

        s:= '';
        while Eof = False do begin
          if (Length(UOMMergerecs)=0) then begin
            SetLength(UOMMergerecs , 1);
            UOMMergerecs[high(UOMMergerecs)].ProductID := fieldbyname('PartID').AsInteger;
            DoStepProgressbar(fieldbyname('UnitProductKeyName').AsString);
          end else if (UOMMergerecs[high(UOMMergerecs)].ProductID <> fieldbyname('PartID').AsInteger ) then begin
            SetLength(UOMMergerecs , Length(UOMMergerecs)+1);
            UOMMergerecs[high(UOMMergerecs)].ProductID := fieldbyname('PartID').AsInteger;
            DoStepProgressbar(fieldbyname('UnitProductKeyName').AsString);
          end;
          if UOMMergerecs[high(UOMMergerecs)].UOMIDsToMerge <> '' then UOMMergerecs[high(UOMMergerecs)].UOMIDsToMerge :=UOMMergerecs[high(UOMMergerecs)].UOMIDsToMerge +',';
          UOMMergerecs[high(UOMMergerecs)].UOMIDsToMerge := UOMMergerecs[high(UOMMergerecs)].UOMIDsToMerge + inttostr(fieldbyname('unitID').AsInteger);
          NExt;
        end;
      end;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;
end;
procedure TUOMListGUI.SelectUOMNameToMerge(Sender :TwwDBGrid);
begin
   uomnametomerge := Sender.DataSource.DataSet.FieldByName('UnitName').AsString;
end;

procedure TUOMListGUI.setShowTables(const Value: boolean);
begin
  if not Value then btnshowtables.Caption :=  'Show Tables' else btnshowtables.Caption :=  'Hide Tables';
  //PopulatefieldList(Value);
  RefreshQuery;
end;

procedure TUOMListGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.showtables'].asBoolean := ShowTables ;
end;

procedure TUOMListGUI.btnshowtablesClick(Sender: TObject);
begin
  inherited;
  ShowTables := not(ShowTables);
end;

procedure TUOMListGUI.CheckforUOM(const Tablename,fieldname:String);
var
  s:String;
begin
  DoStepProgressbar(Tablename+'.' +fieldname);
  if sametext(tablename , 'tblunitsofmeasure') then
    if not sametext(fieldname , 'BaseUnitID') then  exit;

  if userlock.Lock(tablename , 0) then begin(*try*)
    s:=StringReplace(tablename, 'tbl', '',[rfIgnoreCase])+'_'+fieldname;
    if UOMfieldnames.indexof(s) <0 then begin
      UOMfieldnames.add(s);
      Scriptmain.SQL.Add('Alter table '+fstablename +' Add column `' + s +'` enum("T","F") default "F";');
      Scriptmain.SQL.Add('update '+fsTablename +' T inner join '+tablename +' TR on T.listuomid = TR.'+fieldname+' Set T.'+s+' ="T";');
    end;
(*  finally
    Userlock.unlock(Tablename , 0);*)
  end;
end;

procedure TUOMListGUI.FormCreate(Sender: TObject);
begin
  fstablename := commondblib.GetUserTemporaryTableName('UOMList');
  Qrymain.SQL.clear;
  Qrymain.SQL.Add('Select ');
  Qrymain.SQL.Add('uom.*,');
  Qrymain.SQL.Add('P.partname as Partname');
  Qrymain.SQL.Add('from '+fstablename +' uom left join tblparts P on P.partsId = uom.partID order by Partname, unitname');
  UOMfieldnames:= TStringlist.create;
  //NonSearchMode:= true;
  inherited;
  SearchMode := smFullList;
end;

procedure TUOMListGUI.FormDestroy(Sender: TObject);
begin
  Freeandnil(UOMfieldnames);
  inherited;
end;

procedure TUOMListGUI.FormShow(Sender: TObject);
begin
  inherited;
  if grpFilters.ItemIndex <0 then grpFilters.ItemIndex := 0;
end;

function TUOMListGUI.getshowTables: boolean;
begin
  result := not(sametext(btnshowtables.Caption , 'Show Tables'));
end;

procedure TUOMListGUI.grpFiltersClick(Sender: TObject);
var
  ctr:Integer;
begin
  GroupFilterString:= '';
  if  UOMfieldnames.count >0  then
    if grpFilters.ItemIndex =1 then begin
        for ctr:= 0 to UOMfieldnames.count-1 do
          if GroupFilterString <> '' then GroupFilterString := GroupFilterString + ' and ' +UOMfieldnames[ctr] +' <> '+quotedstr('T')
          else GroupFilterString := UOMfieldnames[ctr] +' <> '+quotedstr('T');
    end else if grpFilters.ItemIndex =2 then begin
        for ctr:= 0 to UOMfieldnames.count-1 do
          if GroupFilterString <> '' then GroupFilterString := GroupFilterString + ' OR ' +UOMfieldnames[ctr] +' = '+quotedstr('T')
          else GroupFilterString := UOMfieldnames[ctr] +' = '+quotedstr('T');
    end;
  inherited;
end;

procedure TUOMListGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);
var
  ctr:Integer;
begin
  inherited;
  if IterateProcno = 1 then begin
    if  UOMfieldnames.count >0  then
      for ctr:= 0 to UOMfieldnames.count-1 do
        if Qrymain.fieldbyname(UOMfieldnames[ctr]).asBoolean then exit;
  end else if iterateprocno = 2 then begin
      if Sysutils.SameText(Qrymain.fieldByname('UnitName').asString, AppEnv.DefaultClass.DefaultUOM)
        and (Qrymain.fieldByname('PartID').asInteger=0) and (Qrymain.fieldByname('Multiplier').asFloat = 1) then exit;

    if  UOMfieldnames.count >0  then
      for ctr:= 0 to UOMfieldnames.count-1 do
        if Qrymain.fieldbyname(UOMfieldnames[ctr]).asBoolean then exit;
    scriptmain.SQL.Add('Delete from tblunitsofmeasure where UnitID = ' + inttostr(Qrymain.FieldByName('listuomid').AsInteger)+';');
  end;

  grdmain.selectrecord;
end;

procedure TUOMListGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  ShowTables :=  GuiPrefs.Node['Options.showtables'].asBoolean;
end;

procedure TUOMListGUI.RefreshQuery;
begin
  closedb(Qrymain);
  UOMfieldnames.clear;
  with Scriptmain do begin
      SQL.Clear;
      SQL.Add('drop table if exists '+fstablename+';');
      SQL.Add('CREATE TABLE '+fstablename+' ('+
                          ' id INT(11) NOT NULL AUTO_INCREMENT,'+
                          ' listuomid int(11),'+
                          ' Active enum ("T","F") default "F",'+
                          ' PartID int(11),'+
                          ' unitname VARCHAR(100) ,'+
                          ' Multiplier double,'+
                          ' PRIMARY KEY (id),'+
                          ' INDEX CombIdx (listuomid, PartId, unitname));');

      SQL.Add('insert ignore into '+fstablename+' (listuomid , PartId , unitname, active, Multiplier) '+
                                                     ' select unitId,     partId,  unitname, active, Multiplier from tblunitsofmeasure ;');
      showProgressbar('Checking for the UOM usage in different transaction tables', 100);
      try
          if showTables then TableListProcess(checkTableforUOM);
          //TableListProcess(checkTableforUOM);
          Execute;
          Userlock.UnlockAllCurrentInstance;
      finally
        HideProgressbar;
      end;

  end;

  inherited;
  Populatefieldlist(showTables);
end;
initialization
  RegisterClassOnce(TUOMListGUI);

end.

