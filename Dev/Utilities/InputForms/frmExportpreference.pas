unit frmExportpreference;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DADump, MyDump, Menus, AdvMenus, DataState, DB,
  DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, ExtCtrls, Grids, Wwdbigrd,
  Wwdbgrid, MemDS, DNMSpeedButton, XMLDoc, XMLIntf, StdCtrls, ImgList, DNMPanel,
  ComCtrls, wwriched, Mask, wwdbedit, ProgressDialog;

type
  TMovetype    = (TMovenext    = 1,tMovePrevious=2);

  TfmExportpreferences = class(TBaseInputGUI)
    MyDump1: TMyDump;
    qryMain: TERPQuery;
    dsmain: TDataSource;
    qryMainGlobalRef: TWideStringField;
    qryMainPreferenceID: TIntegerField;
    qryMainPackageID: TIntegerField;
    qryMainUserID: TIntegerField;
    qryMainPrefGroup: TWideStringField;
    qryMainPrefName: TWideStringField;
    qryMainPrefType: TWideStringField;
    qryMainPrefValue: TWideMemoField;
    qryMainPrefDesc: TWideStringField;
    qryMainmsTimeStamp: TDateTimeField;
    qryMainNewPrefname: TWideStringField;
    dsDBPref: TDataSource;
    QryDBPref: TERPQuery;
    QryDBPrefPrefID: TIntegerField;
    QryDBPrefPrefType: TWideStringField;
    QryDBPrefName: TWideStringField;
    QryDBPrefFieldType: TWideStringField;
    QryDBPrefFieldSize: TIntegerField;
    QryDBPrefFieldValue: TWideMemoField;
    QryDBPrefDefaultValue: TWideStringField;
    QryDBPrefGlobalRef: TWideStringField;
    QryDBPrefmsTimeStamp: TDateTimeField;
    DNMPanel3: TDNMPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    DNMPanel1: TDNMPanel;
    Edit1: TEdit;
    chk1User: TCheckBox;
    DNMSpeedButton1: TDNMSpeedButton;
    btngeenratescript: TDNMSpeedButton;
    memomain: TMemo;
    TabSheet2: TTabSheet;
    DNMPanel2: TDNMPanel;
    Edit2: TEdit;
    grdDbPref: TwwDBGrid;
    DNMSpeedButton2: TDNMSpeedButton;
    memodbPref: TMemo;
    wwDBEdit1: TwwDBEdit;
    wwDBEdit2: TwwDBEdit;
    wwDBEdit3: TwwDBEdit;
    wwDBEdit4: TwwDBEdit;
    wwDBEdit5: TwwDBEdit;
    wwDBEdit6: TwwDBEdit;
    details: TwwDBRichEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    wwDBEdit7: TwwDBEdit;
    PageControl2: TPageControl;
    TabPrehs: TTabSheet;
    grdMain: TwwDBGrid;
    TabTemplates: TTabSheet;
    grdTemplates: TwwDBGrid;
    qryTemplates: TERPQuery;
    dsTemplates: TDataSource;
    qryTemplatesTemplName: TWideStringField;
    qryTemplatesTemplateClass: TWideStringField;
    qryTemplatesSQLString: TWideMemoField;
    qryTemplatesDesignTimeSQLString: TWideMemoField;
    qryTemplatesEmployeeID: TIntegerField;
    qryTemplatesEditable: TWideStringField;
    qryTemplatesDefaultTemplate: TWideStringField;
    qryTemplatesTypeID: TIntegerField;
    qryTemplatesReport: TBlobField;
    qryTemplatesEditedFlag: TWideStringField;
    qryTemplatesmsTimeStamp: TDateTimeField;
    qryTemplatesActive: TWideStringField;
    TabSheet3: TTabSheet;
    edtfields: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    edtREplace: TEdit;
    opt: TRadioGroup;
    Label10: TLabel;
    edtSearch: TEdit;
    QryTemplate: TERPQuery;
    dsTemplate: TDataSource;
    wwDBGrid1: TwwDBGrid;
    DNMSpeedButton4: TDNMSpeedButton;
    edtScript: TMemo;
    TabSheet4: TTabSheet;
    qrycustomcharts: TERPQuery;
    dscustomcharts: TDataSource;
    qrycustomchartsID: TIntegerField;
    qrycustomchartsChartName: TWideStringField;
    qrycustomchartsReportClassName: TWideStringField;
    qrycustomchartsCustomFilterID: TIntegerField;
    qrycustomchartsEmployeeID: TIntegerField;
    qrycustomchartsGlobal: TWideStringField;
    qrycustomchartsDefaultChart: TWideStringField;
    qrycustomchartsChartBlob: TBlobField;
    qrycustomchartsX_LabelsField: TWideStringField;
    qrycustomchartsX_ChartedField: TWideStringField;
    qrycustomchartsY_ChartedField: TWideStringField;
    qrycustomchartsZ_ChartedField: TWideStringField;
    grdchart: TwwDBGrid;
    memchart: TMemo;
    DNMSpeedButton3: TDNMSpeedButton;
    DNMSpeedButton5: TDNMSpeedButton;
    DNMSpeedButton6: TDNMSpeedButton;
    TabSheet5: TTabSheet;
    edtTransSQL: TEdit;
    Label11: TLabel;
    memMisc: TMemo;
    btnTransSQL: TDNMSpeedButton;
    qrytable: TERPQuery;
    dsTable: TDataSource;
    TabSheet6: TTabSheet;
    lstTables: TListBox;
    Button2: TButton;
    btnmakeTableSQL: TButton;
    grdTablerecs: TwwDBGrid;
    Button3: TButton;
    memotablestructure: TMemo;
    edtTablename: TEdit;
    TabSheet7: TTabSheet;
    Button1: TButton;
    edtProductID: TEdit;
    qryMainIndustryId: TIntegerField;
    DNMSpeedButton7: TDNMSpeedButton;
    procedure btngeenratescriptClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdMainMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure grdMainKeyPress(Sender: TObject; var Key: Char);
    procedure btnEditPrefClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
(*    procedure SaveClick(Sender: TObject);*)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure chk1UserClick(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure grdDbPrefMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure grdDbPrefKeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure grdDbPrefCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure DNMSpeedButton2Click(Sender: TObject);
    procedure wwDBEdit3DblClick(Sender: TObject);
    procedure detailsExit(Sender: TObject);
    procedure DNMSpeedButton3Click(Sender: TObject);
    procedure DNMSpeedButton4Click(Sender: TObject);
    procedure DNMSpeedButton5Click(Sender: TObject);
    procedure DNMSpeedButton6Click(Sender: TObject);
    procedure btnTransSQLClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure lstTablesDblClick(Sender: TObject);
    procedure btnmakeTableSQLClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure edtTablenameExit(Sender: TObject);
    procedure DNMSpeedButton7Click(Sender: TObject);
  private
    fsSearchtext:String;
    fsSearchDBPref:String;
    ctr:Integer;
    fXMLDoc: TXMLDocument;
    node: IXMLNode;
    procedure makescript(Sender: TwwDbGrid);

    (*Procedure displaydetails;*)
 (*   Procedure Movenext(Movetype:TMovetype);*)
  public
    { Public declarations }
  end;

implementation

uses CommonLib, FastFuncs, CommonDbLib, Clipbrd, ProductQtyLib,  tcConst,
  TransactionsTableLib, MySQLUtils, LogLib, PQALib, DbSharedObjectsObj, DNMLib,
  AppEnvironment, CommonFormLib;

{$R *.dfm}
procedure TfmExportpreferences.btngeenratescriptClick(Sender: TObject);
var
  ctr:Integer;
begin
  inherited;
  memomain.Clear;

 if grdMain.SelectedList.Count > 0 then begin
   for ctr := 0 to grdMain.Selectedlist.count-1 do begin
    qryMain.GotoBookmark(grdMain.SelectedList.Items[ctr]);
    memomain.Lines.add('delete from tblpreferences '+
                            ' where PrefName = '+ QuotedStr(Trim(qryMainPrefName.asString))+' and IndustryId=' + qryMainIndustryId.asString + ';');
    memomain.Lines.add('INSERT INTO tblpreferences '+
                            ' (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue, PrefDesc, IndustryId) '+
                            '  VALUES '+
                            ' ( ' + IntToStr(qryMainPackageID.asInteger) +',' +
                            ' 0, '+QuotedStr(Trim(qryMainPrefGroup.asSTring)) +', ' +
                            QuotedStr(Trim(qryMainPrefName.asSTring)) +', ' +
                            QuotedStr(Trim(qryMainPrefType.asSTring)) +', ' +
                            QuotedStr(StringReplace(StringReplace(Trim(qryMainPrefValue.asSTring),#13#10 , '\r\n', [rfReplaceAll, rfIgnoreCase]),#10 , '\r\n', [rfReplaceAll, rfIgnoreCase])) +', ' +
                            QuotedStr(Trim(qryMainPrefDesc.asSTring)) +', ' +
                            qryMainIndustryId.asString +');');
    end;
    memomain.SetFocus;
    memomain.SelectAll;
    Clipboard.asText := memomain.Lines.text;
  end;
 if grdTemplates.SelectedList.Count > 0 then begin
   for ctr := 0 to grdTemplates.Selectedlist.count-1 do begin
    qryMain.GotoBookmark(grdTemplates.SelectedList.Items[ctr]);
    memomain.Lines.add('delete from tbltemplates '+
                            ' where TemplName = '+ QuotedStr(Trim(qryTemplatesTemplName.asString))+
                            ' and TypeID = ' + Trim(qryTemplatesTypeID.asString)+';');
    memomain.Lines.add('INSERT INTO tbltemplates '+
                            ' (TemplName, TemplateClass, EmployeeID, Editable, DefaultTemplate, TypeID, EditedFlag, Active, SQLString, DesignTimeSQLString, Report) '+
                            '  VALUES '+
                            ' ( ' +
                            QuotedStr(qryTemplatesTemplName.asString) +',' +
                            QuotedStr(qryTemplatesTemplateClass.asString) +',' +
                            qryTemplatesEmployeeID.AsString + ',' +
                            QuotedStr(qryTemplatesEditable.asString) +',' +
                            QuotedStr(qryTemplatesDefaultTemplate.asString) +',' +
                            qryTemplatesTypeID.AsString + ',' +
                            QuotedStr(qryTemplatesEditedFlag.asString) +',' +
                            QuotedStr(qryTemplatesActive.asString) +',' +
                            QuotedStr(StringReplace(Trim(qryTemplatesSQLString.asString),#13#10 , '\r\n', [rfReplaceAll, rfIgnoreCase])) +', ' +
                            QuotedStr(StringReplace(Trim(qryTemplatesDesignTimeSQLString.asString),#13#10 , '\r\n', [rfReplaceAll, rfIgnoreCase])) +', ' +
                            QuotedStr(StringReplace(Trim(qryTemplatesReport.asString),#13#10 , '\r\n', [rfReplaceAll, rfIgnoreCase])) +');');
    end;
  end;
  memomain.SetFocus;
  memomain.SelectAll;
  Clipboard.asText := memomain.Lines.text;
end;

procedure TfmExportpreferences.FormShow(Sender: TObject);
begin
  RealignTabControl(PageControl1, 1);
  PageControl1.tabIndex := 0;
  DisableForm;
  try
    inherited;
    if Qrymain.active         = False then Qrymain.open;
    if QryDBPref.active       = False then QryDBPref.open;
    if qryTemplates.Active    = False then qryTemplates.Open;
    if qrycustomcharts.Active = False then qrycustomcharts.Open;
    fsSearchtext := '';
    fsSearchDBPref:= '';
  finally
    EnableForm;
  end;
end;

procedure TfmExportpreferences.grdMainMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  fsSearchtext := '';
end;

procedure TfmExportpreferences.lstTablesDblClick(Sender: TObject);
begin
  inherited;
  closeDb(qrytable);
  qrytable.SQL.Text := 'Select * from ' +   lstTables.Items[lstTables.ItemIndex];
  opendb(qrytable);
end;

procedure TfmExportpreferences.grdMainKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  fsSearchtext := fsSearchtext + Key;
  Edit1.text :=fsSearchtext ;
  if not Qrymain.Locate('NewPrefname' ,Edit1.text, [loCaseInsensitive	, loPartialKey]) then
    Qrymain.Locate('Prefname' ,Edit1.text, [loCaseInsensitive	, loPartialKey]);

end;

procedure TfmExportpreferences.btnEditPrefClick(Sender: TObject);
begin
  inherited;
  if grdMain.SelectedList.Count <> 1 then Exit;
  qryMain.GotoBookmark(grdMain.SelectedList.Items[0]);
  If not Assigned(fXMLDoc) then Begin
    fXMLDoc := TXMLDocument.Create(self);
  end else Begin
    fXMLDoc.XML.Clear;
  end;
  fXMLDoc.LoadFromXML(qryMainPrefValue.asString);
  Node := fXMLDoc.ChildNodes.FindNode(qryMainPrefName.asString);
  if not (Assigned(node)) then exit;
  Node := node.ChildNodes.FindNode('grdMain');
  if not (Assigned(node)) then exit;
  Node := node.ChildNodes.FindNode('Columns');
  if not (Assigned(node)) then exit;
  ctr:= -1;
end;

procedure TfmExportpreferences.Button1Click(Sender: TObject);
var
  ProductID:Integer;
begin
  inherited;
  LogText(PQASQLWithLinks);
  ProductId :=0;
  if edtProductID.Text<> '' then
    if ISInteger(edtProductID.text) then
      ProductID := StrtoInt(edtProductID.text);
  LogText('none:' +SQL4ProductAvailableQty(0, '' , tsummary ,ProductID, 0 , '' , 0 , '' , '' , '' , tqtyNone));
  LogText('Instock:' +SQL4ProductAvailableQty(0, '' , tsummary ,ProductID, 0 , '' , 0 , '' , '' , '' , tInStock));
  LogText('Available:' +SQL4ProductAvailableQty(0, '' , tsummary ,ProductID, 0 , '' , 0 , '' , '' , '' , tAvailable));
  LogText('POBO:' +SQL4ProductAvailableQty(0, '' , tsummary ,ProductID, 0 , '' , 0 , '' , '' , '' , tPOBO));
  LogText('InvBo:' +SQL4ProductAvailableQty(0, '' , tsummary ,ProductID, 0 , '' , 0 , '' , '' , '' , tInvBO));
  LogText('So:' +SQL4ProductAvailableQty(0, '' , tsummary ,ProductID, 0 , '' , 0 , '' , '' , '' , tSO));
  LogText('sobo:' +SQL4ProductAvailableQty(0, '' , tsummary ,ProductID, 0 , '' , 0 , '' , '' , '' , tSOBO));
  LogText('Stock:' +SQL4ProductAvailableQty(0, '' , tsummary ,ProductID, 0 , '' , 0 , '' , '' , '' , tStockQty));
  LogText('Trans:' +SQL4ProductAvailableQty(0, '' , tsummary ,ProductID, 0 , '' , 0 , '' , '' , '' , tTransQty));
  LogText('instockMovement:' +SQL4ProductAvailableQty(0, '' , tsummary ,ProductID, 0 , '' , 0 , '' , '' , '' , tInStockMovement));
  LogText('OUTs:' +SQL4ProductAvailableQty(0, '' , tsummary ,ProductID, 0 , '' , 0 , '' , '' , '' , tOUTs));
  LogText('INs:' +SQL4ProductAvailableQty(0, '' , tsummary ,ProductID, 0 , '' , 0 , '' , '' , '' , tINs));
  LogText('Onbuild:' +SQL4ProductAvailableQty(0, '' , tsummary ,ProductID, 0 , '' , 0 , '' , '' , '' , tOnBuild));
  LogText('Building:' +SQL4ProductAvailableQty(0, '' , tsummary ,ProductID, 0 , '' , 0 , '' , '' , '' , tBuilding));
end;

procedure TfmExportpreferences.Button2Click(Sender: TObject);
begin
  inherited;
  GetSharedMyDacConnection.GetTableNames(lstTables.Items , false);
  lstTables.visible := true;
  btnmakeTableSQL.visible := true;
  grdTablerecs.visible := true;
end;

procedure TfmExportpreferences.Button3Click(Sender: TObject);
var
  s:String;
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    qry.sql.text := 'show create table ' + lstTables.Items[lstTables.ItemIndex];
    qry.open;
    s:= qry.fields[1].asString;
    s:= replacestr(s , ' DEFAULT ''0''' , ' DEFAULT 0');
    s:= replacestr(s , '''' , '"');
    s:= replacestr(s , chr(10), '''+' + chr(10) +'    '' ');
    s:= replacestr(s , '`' , '');
    s:= replacestr(s , '''  ', '''');

    memotablestructure.lines.clear;
    memotablestructure.lines.add(s);
    closedb(qry);
    qry.sql.text := 'Desc ' + lstTables.Items[lstTables.ItemIndex];
    Opendb(qry);
    memotablestructure.lines.add('=========================');
    memotablestructure.lines.add(Qry.GroupConcat('field'));
    memotablestructure.lines.add('=========================');
    memotablestructure.lines.add(Qry.GroupConcat('Type', '', false, ',' , '' , '' , False , True));
    Clipboard.asText := memotablestructure.lines.Text;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;

end;

procedure TfmExportpreferences.btnmakeTableSQLClick(Sender: TObject);
var
  s1, s2:String;
  ctr: integer;
  fsPrimaryKey: string;
  HasGlobalRef: boolean;


  function Productname:String;
  begin
    result := '';
    try
      with tempMyquery do try
        SQL.Text := 'Select Partname from tblparts where PartsId =' + inttostr(qrytable.FieldByName('partID').AsInteger);
        open;
        result := fieldbyname('Partname').AsString;
      finally
        closenFree;
      end;
    Except
      // kill exception
    end;
  end;
begin
  inherited;
  if Sametext (lstTables.Items[lstTables.ItemIndex], 'tblpartspics') then begin
    s1:= 'Insert ignore into tblpartspics (partID , partPic) Select (Select PartsId from tblparts where partname = ' +Quotedstr(ProductName) +' ) , ' +
            QuotedStr(StringReplace(StringReplace(Trim(qrytable.FieldByName('partPic').asSTring),#13#10 , '\r\n', [rfReplaceAll, rfIgnoreCase]),#10 , '\r\n', [rfReplaceAll, rfIgnoreCase]));
  end else begin
    fsPrimaryKey := MysqlTablePrimaryKey(lstTables.Items[lstTables.ItemIndex] , tMyConnection(GetSharedMyDacConnection), HasGlobalRef);
    s1:= '';    s2:= '';
    for ctr:= 0 to qrytable.fieldcount-1 do begin
      if sametext(qrytable.fields[ctr].FieldName ,fsPrimaryKey) or
          sametext(qrytable.fields[ctr].FieldName ,'globalref') or
          sametext(qrytable.fields[ctr].FieldName ,'mstimestamp') or
          sametext(qrytable.fields[ctr].FieldName ,'msUpdateSitecode') then
      else begin
          if s1 = '' then s1 := 'insert ignore into ' + lstTables.Items[lstTables.ItemIndex] +'(' else s1:= s1 +',';
          if s2 = '' then else s2:= s2 +',';
          s1:= s1 + qrytable.fields[ctr].FieldName;
          s2:= s2 + QuotedStr(StringReplace(StringReplace(Trim(qrytable.fields[ctr].asString),#13#10 , '\r\n', [rfReplaceAll, rfIgnoreCase]),#10 , '\r\n', [rfReplaceAll, rfIgnoreCase]));
      end;
    end;
    s1 := s1 + ') values (' + s2 +')';
  end;
  Clipboard.asText := s1;
  MessageDlgXP_Vista('The SQL is copied into the Clipboard and written into the log as well', mtInformation, [mbOK], 0);
end;

procedure TfmExportpreferences.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TfmExportpreferences.FormResize(Sender: TObject);
begin
  inherited;
  RealignTabControl(PageControl1, 1);
end;

procedure TfmExportpreferences.Edit1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  fsSearchtext := fsSearchtext + Key;
  if not Qrymain.Locate('NewPrefname' ,Edit1.text, [loCaseInsensitive	, loPartialKey]) then
    Qrymain.Locate('Prefname' ,Edit1.text, [loCaseInsensitive	, loPartialKey]);

end;

procedure TfmExportpreferences.chk1UserClick(Sender: TObject);
begin
  inherited;
  qryMain.filtered := chk1User.checked ;
end;

procedure TfmExportpreferences.Edit1Exit(Sender: TObject);
begin
  inherited;
  fsSearchtext := Edit1.text;
//  if not Qrymain.Locate('NewPrefname' ,fsSearchtext, [loCaseInsensitive	, loPartialKey]) then
//    if not Qrymain.Locate('Prefname' ,fsSearchtext, [loCaseInsensitive	, loPartialKey]) then
end;

procedure TfmExportpreferences.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if (pos(edit1.text , qryMainPrefName.asString)<> 0) or
    (pos(edit1.text , qryMainnewPrefName.asString)<> 0) then
      ABrush.Color := clGreen
    else abrush.Color := clWhite;
end;

procedure TfmExportpreferences.DNMSpeedButton1Click(Sender: TObject);
var
  strSQL:String;
begin
  inherited;
  strSQL:= 'delete from tblPreferences where prefname like ' +quotedstr('%' +fsSearchtext+'%') + ' and IndustryId=' + qryMainIndustryId.AsString ;
  with CommonDbLib.TempMyQuery do try
    connection := Qrymain.Connection;
    SQl.clear;
    SQl.add(strSQL);
    execute;
    CloseDB(Qrymain);
    openDB(Qrymain);
  finally
    if active then close;
    Free;
  end;

end;

procedure TfmExportpreferences.Edit2Exit(Sender: TObject);
begin
  inherited;
  fsSearchDBPref := Edit2.text;
//  if not QryDBPref.Locate('Name' ,fsSearchDBPref, [loCaseInsensitive	, loPartialKey]) then

end;

procedure TfmExportpreferences.grdDbPrefMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
   fsSearchDBPref := '';
end;

procedure TfmExportpreferences.grdDbPrefKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  fsSearchDBPref := fsSearchDBPref + Key;
    QryDBPref.Locate('name' ,fsSearchDBPref, [loCaseInsensitive	, loPartialKey]);
end;

procedure TfmExportpreferences.Edit2KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  fsSearchDBPref := fsSearchDBPref + Key;
  QryDBPref.Locate('name' ,fsSearchDBPref, [loCaseInsensitive	, loPartialKey]);

end;

procedure TfmExportpreferences.edtTablenameExit(Sender: TObject);
begin
  inherited;
  lstTables.ItemIndex := lstTables.Items.indexof(edtTablename.text);
end;

procedure TfmExportpreferences.grdDbPrefCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if (pos(fsSearchDBPref , QryDBPrefname.asString)<> 0)  then
      ABrush.Color := clGreen
    else abrush.Color := clWhite;

end;

procedure TfmExportpreferences.DNMSpeedButton2Click(Sender: TObject);
var
  ctr:Integer;
begin
  inherited;
  if QryDBPref.State in [dsEdit] then QryDBPref.post;
  memodbPref.Clear;

 if grdDbPref.SelectedList.Count > 0 then begin
   for ctr := 0 to grdDbPref.Selectedlist.count-1 do begin
    QryDBPref.GotoBookmark(grdDbPref.SelectedList.Items[ctr]);
    memodbPref.Lines.add('delete from tbldbpreferences '+
                            ' where Name = '+ QuotedStr(Trim(QryDBPrefName.asString))+';');
    memodbPref.Lines.add('INSERT INTO `tbldbpreferences` (`PrefType`,FieldSize , `Name`,`FieldType`,DefaultValue , `FieldValue`) VALUES '+
                            ' ( ' +QuotedStr(Trim(QryDBPrefPrefType.asSTring)) +', ' +
                            IntToStr(QryDBPrefFieldSize.asInteger) +',' +
                            QuotedStr(Trim(QryDBPrefName.asSTring)) +', ' +
                            QuotedStr(Trim(QryDBPrefFieldType.asSTring)) +', ' +
                            QuotedStr(Trim(QryDBPrefDefaultValue.asString)) + ',' +
                            QuotedStr(StringReplace(Trim(QryDBPrefFieldValue.asSTring),#13#10 , '\r\n', [rfReplaceAll, rfIgnoreCase])) +');');
    end;
    memodbPref.SetFocus;
    memodbPref.SelectAll;
    Clipboard.asText := memodbPref.Lines.text;
  end;
end;

procedure TfmExportpreferences.DNMSpeedButton3Click(Sender: TObject);
var
  s:String;
begin
  inherited;
  if opt.ItemIndex = 0 then s := edtREplace.Text + edtfields.text
  else s :=  edtfields.text + edtREplace.Text;
  s:= 'Select * from tbltemplates ' + NL +
      ' where SQLString like ''%' +EdtREplace.Text +'%'' ' + NL +
      ' and not(SQLString like ''%' +s +'%'')  ' + NL +
      ' and SQLString like ''%' + edtSearch.Text +'%''  ';
  QryTemplate.DisableControls;
  try
     closeDb(QryTemplate);
     QryTemplate.SQL.Clear;
     QryTemplate.SQL.Add(s);
     QryTemplate.Open;
     edtScript.Text := s;
  finally
    QryTemplate.EnableControls;
  end;
end;

procedure TfmExportpreferences.DNMSpeedButton4Click(Sender: TObject);
var
  s:String;
begin
  inherited;
  if opt.ItemIndex = 0 then s := edtREplace.Text + edtfields.text
  else s :=  edtfields.text + edtREplace.Text;
  edtScript.Lines.Clear;
  edtScript.Lines.Add('drop table if exists tmp_1; ' );
  edtScript.Lines.Add('create table tmp_1 Select templID from tbltemplates   where   SQLString like ''%' + edtREplace.Text+'%''  and SQLString like ''%' + edtSearch.Text +'%''  and not(SQLstring  like ''%' + s +'%'' ; ' );
  edtScript.Lines.Add('UPDATE tbltemplates SET SQLString = REPLACE(SQLstring,'+
                                                    'SubString(SQLString , '+
                                                                      'POSITION('+ Quotedstr(edtREplace.Text) +' IN SQLString) , length('+Quotedstr(edtREplace.Text) +')),'+
                                                   quotedstr(s) +') WHERE TemplId IN (select TemplId from tmp_1); ' );
  edtScript.Lines.Add('drop table if exists tmp_1;' );
  edtScript.Text := s;
end;

procedure TfmExportpreferences.DNMSpeedButton5Click(Sender: TObject);
var
  ctr:Integer;
begin
  inherited;
  memchart.Lines.Clear;
  for ctr := 0 to grdchart.SelectedList.Count-1 do begin
    qrycustomcharts.GotoBookmark(grdchart.SelectedList.Items[ctr]);
    memchart.Lines.Add('Delete from tblcustomcharts where ChartName = ' + Quotedstr(qrycustomchartsChartName.AsString) +' and ReportClassName = ' + quotedstr(qrycustomchartsReportClassName.AsString)+';');
    memchart.Lines.Add('INSERT IGNORE INTO `tblcustomcharts` (`ChartName`, `ReportClassName`, `Global`, `DefaultChart`, `ChartBlob`, `X_LabelsField`, `X_ChartedField`, `Y_ChartedField`, `Z_ChartedField`) ' +
          ' VALUES (' + Quotedstr(qrycustomchartsChartName.AsString) +',' +
                        quotedStr(qrycustomchartsReportClassName.AsString) +','+
                        quotedStr(qrycustomchartsGlobal.AsString) +','+
                        quotedStr(qrycustomchartsDefaultChart.AsString) +','+
                        //quotedStr(qrycustomchartsChartBlob.AsString) +','+
                        QuotedStr(StringReplace(Trim(qrycustomchartsChartBlob.asString),#13#10 , '\r\n', [rfReplaceAll, rfIgnoreCase])) +', ' +
                        quotedStr(qrycustomchartsX_LabelsField.AsString) +','+
                        quotedStr(qrycustomchartsX_ChartedField.AsString) +','+
                        quotedStr(qrycustomchartsY_ChartedField.AsString) +','+
                        quotedStr(qrycustomchartsZ_ChartedField.AsString) +'); ');
  end;
  memchart.SetFocus;
  memchart.SelectAll;
  Clipboard.asText := memchart.Lines.text;
end;

procedure TfmExportpreferences.DNMSpeedButton6Click(Sender: TObject);
begin
  inherited;
  With TempMyquery do try
    SQL.add('Select concat("(Name: ''General'';Color: $" , (Select fieldvalue From tbldbpreferences where  name = "colourGeneral") , "; AdjLuma: " , (Select fieldvalue From tbldbpreferences where  name = "GradIntensityGeneral") , "),") details  union');
    SQL.add('Select concat("(Name: ''Google'';Color: $" , (Select fieldvalue From tbldbpreferences where  name = "colourGoogle") , "; AdjLuma: " , (Select fieldvalue From tbldbpreferences where  name = "GradIntensityGoogle") , "),") details  union');
    SQL.add('Select concat("(Name: ''Appointments'';Color: $" , (Select fieldvalue From tbldbpreferences where  name = "colourAppointments") , "; AdjLuma: " , (Select fieldvalue From tbldbpreferences where  name = "GradIntensityAppointments") , "),") details union');
    SQL.add('Select concat("(Name: ''Accounts'';Color: $" , (Select fieldvalue From tbldbpreferences where  name = "colourAccounts") , "; AdjLuma: " , (Select fieldvalue From tbldbpreferences where  name = "GradIntensityAccounts") , "),") details union');
    SQL.add('Select concat("(Name: ''CRM'';Color: $" , (Select fieldvalue From tbldbpreferences where  name = "colourCRM") , "; AdjLuma: " , (Select fieldvalue From tbldbpreferences where  name = "GradIntensityCRM") , "),") details union');
    SQL.add('Select concat("(Name: ''Employee'';Color: $" , (Select fieldvalue From tbldbpreferences where  name = "colourEmployee") , "; AdjLuma: " , (Select fieldvalue From tbldbpreferences where  name = "GradIntensityEmployee") , "),") details union');
    SQL.add('Select concat("(Name: ''SalesOrder'';Color: $" , (Select fieldvalue From tbldbpreferences where  name = "colourSalesOrder") , "; AdjLuma: " , (Select fieldvalue From tbldbpreferences where  name = "GradIntensitySalesOrder") , "),") details union');
    SQL.add('Select concat("(Name: ''Purchases'';Color: $" , (Select fieldvalue From tbldbpreferences where  name = "colourPurchases") , "; AdjLuma: " , (Select fieldvalue From tbldbpreferences where  name = "GradIntensityPurchases") , "),") details union');
    SQL.add('Select concat("(Name: ''FixedAssets'';Color: $" , (Select fieldvalue From tbldbpreferences where  name = "colourFixedAssets") , "; AdjLuma: " , (Select fieldvalue From tbldbpreferences where  name = "GradIntensityFixedAssets") , "),") details union');
    SQL.add('Select concat("(Name: ''Sales'';Color: $" , (Select fieldvalue From tbldbpreferences where  name = "colourSales") , "; AdjLuma: " , (Select fieldvalue From tbldbpreferences where  name = "GradIntensitySales") , "),") details union');
    SQL.add('Select concat("(Name: ''Miscellaneous'';Color: $" , (Select fieldvalue From tbldbpreferences where  name = "colourMiscellaneous") , "; AdjLuma: " , (Select fieldvalue From tbldbpreferences where  name = "GradIntensityMiscellaneous") , "),") details union');
    SQL.add('Select concat("(Name: ''Returns'';Color: $" , (Select fieldvalue From tbldbpreferences where  name = "colourReturns") , "; AdjLuma: " , (Select fieldvalue From tbldbpreferences where  name = "GradIntensityReturns") , "),") details union');
    SQL.add('Select concat("(Name: ''Manufacturing'';Color: $" , (Select fieldvalue From tbldbpreferences where  name = "colourManufacturing") , "; AdjLuma: " , (Select fieldvalue From tbldbpreferences where  name = "GradIntensityManufacturing") , "),") details union');
    SQL.add('Select concat("(Name: ''Payroll'';Color: $" , (Select fieldvalue From tbldbpreferences where  name = "colourPayroll") , "; AdjLuma: " , (Select fieldvalue From tbldbpreferences where  name = "GradIntensityPayroll") , "),") details union');
    SQL.add('Select concat("(Name: ''Inventory'';Color: $" , (Select fieldvalue From tbldbpreferences where  name = "colourInventory") , "; AdjLuma: " , (Select fieldvalue From tbldbpreferences where  name = "GradIntensityInventory") , "),") details union');
    SQL.add('Select concat("(Name: ''Utilities'';Color: $" , (Select fieldvalue From tbldbpreferences where  name = "colourUtilities") , "; AdjLuma: " , (Select fieldvalue From tbldbpreferences where  name = "GradIntensityUtilities") , "),") details union');
    SQL.add('Select concat("(Name: ''MainBackground'';Color: $" , (Select fieldvalue From tbldbpreferences where  name = "colourMainBackground") , "; AdjLuma: " , (Select fieldvalue From tbldbpreferences where  name = "GradIntensityMainBackground") , "),") details union');
    SQL.add('Select concat("(Name: ''Training'';Color: $" , (Select fieldvalue From tbldbpreferences where  name = "colourTraining") , "; AdjLuma: " , (Select fieldvalue From tbldbpreferences where  name = "GradIntensityTraining") , "),") details union');
    SQL.add('Select concat("(Name: ''Banking'';Color: $" , (Select fieldvalue From tbldbpreferences where  name = "colourBanking") , "; AdjLuma: " , (Select fieldvalue From tbldbpreferences where  name = "GradIntensityBanking") , "),") details union');
    SQL.add('Select concat("(Name: ''Delivery'';Color: $" , (Select fieldvalue From tbldbpreferences where  name = "colourDelivery") , "; AdjLuma: " , (Select fieldvalue From tbldbpreferences where  name = "GradIntensityDelivery") , "),") details union');
    SQL.add('Select concat("(Name: ''Payments'';Color: $" , (Select fieldvalue From tbldbpreferences where  name = "colourPayments") , "; AdjLuma: " , (Select fieldvalue From tbldbpreferences where  name = "GradIntensityPayments") , "),") details union');
    SQL.add('Select concat("(Name: ''POS'';Color: $" , (Select fieldvalue From tbldbpreferences where  name = "colourPOS") , "; AdjLuma: " , (Select fieldvalue From tbldbpreferences where  name = "GradIntensityPOS") , "),") details union');
    SQL.add('Select concat("(Name: ''Repairs'';Color: $" , (Select fieldvalue From tbldbpreferences where  name = "colourRepairs") , "; AdjLuma: " , (Select fieldvalue From tbldbpreferences where  name = "GradIntensityRepairs") , "),")');
    open;
    memodbPref.Lines.Clear;
    first;
    while eof = False do begin
      memodbPref.Lines.add(fieldbyname('Details').AsString);
      Next;
    end;
    memodbPref.SetFocus;
    memodbPref.SelectAll;
    Clipboard.asText := memodbPref.Lines.text;
    MessageDlgXP_Vista('Paste this in to ''TcConst: cColorMapping: ', mtInformation, [mbOK], 0);
  finally
    closenFree;
  end;
end;
procedure TfmExportpreferences.makescript(Sender: TwwDbGrid);
begin
  memomain.Clear;
  if sender = nil then begin
    memomain.Lines.add('INSERT IGNORE INTO `tbldbpreferences` (`PrefType`, `Name`, `FieldType`, `FieldSize`, `FieldValue`, `DefaultValue`) VALUES ('+NL+
                  '''----PREF TYPE----'', '+NL+
                  '''----PREF NAME----'', '+NL+
                  '''----FIELDTYPE----'', '+NL+
                  '''----FIELD SIZE----'', '+NL+
                  '''----FIELDVALUE----'', '+NL+
                  '''----DEFAULT VALUE----'');'+NL+
            'INSERT IGNORE INTO `tbldbpreference_description` (Preftype,PrefID, `Page`, `Name`, `Description`, `GroupDesc`) VALUES  ('+NL+
                  '''----PREF TYPE----'', (Select PrefId from tbldbpreferences where name = '+NL+
                  '''----PREF NAME----''),  '+NL+
                  '''----FORM NAME----'', '+NL+
                  '''----PREF NAME----'', '+NL+
                  '''----CAPTION----'', '+NL+
                  '''----GROUP CAPTION----'');');
  end else begin
    memomain.Lines.add('INSERT IGNORE INTO `tbldbpreferences` (`PrefType`, `Name`, `FieldType`, `FieldSize`, `FieldValue`, `DefaultValue`) VALUES ('+
          Quotedstr(Sender.Datasource.Dataset.Fieldbyname('PrefType').asString)+','+
          Quotedstr(Sender.Datasource.Dataset.Fieldbyname('Name').asString)+','+
          Quotedstr(Sender.Datasource.Dataset.Fieldbyname('FieldType').asString)+','+
          Quotedstr(Sender.Datasource.Dataset.Fieldbyname('FieldSize').asString)+','+
          Quotedstr(Sender.Datasource.Dataset.Fieldbyname('FieldValue').asString)+','+
          Quotedstr(Sender.Datasource.Dataset.Fieldbyname('DefaultValue').asString)+ ');'+NL+
            'INSERT IGNORE INTO `tbldbpreference_description` (Preftype,PrefID,  `Name`,`Page`, `Description`, `GroupDesc`) VALUES  ('+
             Quotedstr(Sender.Datasource.Dataset.Fieldbyname('PrefType').asString)+','+
             '(Select PrefId from tbldbpreferences where name = '+Quotedstr(Sender.Datasource.Dataset.Fieldbyname('Name').asString)+'), '+
               Quotedstr(Sender.Datasource.Dataset.Fieldbyname('Name').asString)+', '+NL+
               '''----FORM NAME----'',  '+NL+
               '''----CAPTION----'', '+NL+
               '''----GROUP CAPTION----'');');
  end;
  Clipboard.asText := memomain.Lines.text;
end;
procedure TfmExportpreferences.DNMSpeedButton7Click(Sender: TObject);
begin
  inherited;
  memomain.Clear;
  OpenERPListFormSingleselectModal('TDBPreferencesListGUI', makescript);
  if memomain.Lines.count =0 then  makescript(nil);

end;

procedure TfmExportpreferences.btnTransSQLClick(Sender: TObject);
var
  Trans: TTransactionTableExtra;
begin
  inherited;
  if not(isInteger(edtTransSQL.Text)) then exit;

  MemMisc.Clear;
  Trans:= TTransactionTableExtra.create;
  try
    MemMisc.Lines.Add(trans.TransactionSummarySQL(strtoint(edtTransSQL.Text)));
  finally
    Freeandnil(trans);
  end;
end;

procedure TfmExportpreferences.wwDBEdit3DblClick(Sender: TObject);
begin
  inherited;
  details.Datasource:= twwDbEdit(sender).datasource;
  details.Datafield := twwDbEdit(sender).Datafield;
  details.visible := true;

end;

procedure TfmExportpreferences.detailsExit(Sender: TObject);
begin
  inherited;
  details.visible := False;
end;

initialization
  RegisterClassOnce(TfmExportpreferences);

end.
