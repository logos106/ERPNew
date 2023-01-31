unit CustomAccountsReportTree;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseTreeView, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, SelectionDialog, AppEvnts,
  Menus, ExtCtrls, StdCtrls, VirtualTrees, Shader, DNMSpeedButton,
  wwdbdatetimepicker, DNMPanel, wwcheckbox , CustomAccountsReportObj;

type
  TAccNodeData = class(TNodeData)
  private
  public
    Amount: double;
    SubTotal: double;
  end;
  TCustomAccountsReportTreeGUI = class(TBaseTreeViewGUI)
    chkTreeMode: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TreeDrawText(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
      Node: PVirtualNode; Column: TColumnIndex; const Text: string;
      const CellRect: TRect; var DefaultDraw: Boolean);
    procedure TreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure chkTreeModeClick(Sender: TObject);
  private
    ReportID:Integer;
    Tablename:String;
    highestLevel:Integer;
    LoadingTree:Boolean;
    Classcolumns :Integer;
    fCustomAccountsReportObj :TCustomAccountsReportObj;
    RefreshClassnodeRec: PNodeRec;
    QryRefreshClassnode :TERPQuery;

    procedure RefreshNode(RecordRec: PNodeRec; qry: TERPQuery;Levelno:Integer);
    procedure ReFreshReport(Sender: TObject);
    procedure initCustomAccountsReport(Sender: TObject);
    procedure setSelectedDepartments(const Value: String);
    Function CustomAccountsReportObj :TCustomAccountsReportObj;
    procedure InitcustomAccountsReportOptions(Sender: TObject);
    procedure Addclasscolumns(const Qry: TERPQuery);
    procedure RefreshClassnodes(const Qry: TERPQuery);
    function ClassFieldNo(const Qry: TERPQuery): Integer;
    procedure Formatcolumns;
    Function isclassSelected(const ClassID:Integer):Boolean;
    procedure ShowclassColumns(const Qry:TERPQuery);
    (*procedure logrec(RecordRec: PNodeRec);*)
  Protected
    procedure RefreshTree; override;
    Procedure Readguiprefs;override;
    Procedure WriteGuiPrefs;override;
    Function GuiprefName:String;override;
  public
    Property SelectedDepartments  : String  write setSelectedDepartments;
  end;


implementation

uses CommonLib, AppEnvironment, DbSharedObjectsObj, CommonDbLib,
  dateutils, CommonFormLib,
  FrmChartofAccountsReportTree, CustomAccountsReport, (*TimedHint,*)
  frmcustomAccountsReportOptions, tcConst, LogLib;

const
  cname = 0;

  cDebitsEx= 1;
  ccreditsEx= 2;
  cDebitsInc= 3;
  cCreditsInc= 4;
  cBalanceEx = 5;
  cBalanceInc = 6;
  cLevelno    = 7;
{$R *.dfm}

procedure TCustomAccountsReportTreeGUI.btnCustomizeClick(Sender: TObject);
begin
  inherited;
  OpenERPFormModal('TfmcustomAccountsReportOptions' , 0 , InitcustomAccountsReportOptions, true , Refreshreport);
end;
procedure TCustomAccountsReportTreeGUI.InitcustomAccountsReportOptions(Sender: TObject);
begin
   if not(Sender is TfmcustomAccountsReportOptions) then exit;
   TfmcustomAccountsReportOptions(Sender).CustomAccountsReportObj := CustomAccountsReportObj;
end;

function TCustomAccountsReportTreeGUI.isclassSelected(const ClassID: Integer): Boolean;
var
  st:TStringlist;
begin
  st:= TStringlist.Create;
  try
    st.commatext :=CustomAccountsReportObj.SelectedClasses;
    Result := st.indexof(inttostr(ClassID)) >=0;
  finally
    Freeandnil(st);
  end;
end;

procedure TCustomAccountsReportTreeGUI.chkTreeModeClick(Sender: TObject);
begin
  inherited;
    if Sender <> chkTreemode then exit;
    //if Assigned(fTimedHint) then  fTimedHint.HidehintformForm(Self);
    WriteGuiPrefs;
    GuiPrefs.SavePrefs;
    OpenERPForm('TCustomAccountsReportGUI' , 0 , nil, initCustomAccountsReport);
    Self.Close;
end;

function TCustomAccountsReportTreeGUI.CustomAccountsReportObj: TCustomAccountsReportObj;
begin
        if fCustomAccountsReportObj = nil then begin
          fCustomAccountsReportObj := TCustomAccountsReportObj.create;
          fCustomAccountsReportObj.FormId := ReportID;
          fCustomAccountsReportObj.Tablename := Tablename;
          fCustomAccountsReportObj.GuiPrefs := GuiPrefs;
        end;
    Result :=fCustomAccountsReportObj;
end;

procedure TCustomAccountsReportTreeGUI.initCustomAccountsReport(Sender: TObject);
begin
    if not(Sender is TCustomAccountsReportGUI) then exit;
  TCustomAccountsReportGUI(Sender).dtTo.Date := DtTo.Date;
  TCustomAccountsReportGUI(Sender).SelectedDepartments := CustomAccountsReportObj.SelectedClasses;

end;
procedure TCustomAccountsReportTreeGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;
Function TCustomAccountsReportTreeGUI.ClassFieldNo(Const Qry :TERPQuery):Integer;
begin
  result := ((Qry.RecNo-1)*4) ;
end;
procedure TCustomAccountsReportTreeGUI.Addclasscolumns(Const Qry :TERPQuery);
begin
          AddColumn(Qry.fieldbyname('classname').asString + chr(13)+chr(10)+' Debits Ex'  , vtCurrency, 100); //1,5,9
          AddColumn(Qry.fieldbyname('classname').asString + chr(13)+chr(10)+' Credits Ex' , vtCurrency, 100); //2,6,10
          AddColumn(Qry.fieldbyname('classname').asString + chr(13)+chr(10)+' Debits Inc' , vtCurrency, 100); //3,7,11
          AddColumn(Qry.fieldbyname('classname').asString + chr(13)+chr(10)+' Credits Inc', vtCurrency, 100); //4,8,12
          Columns[cDebitsEx   + ClassFieldNo(Qry)].Alignment      := taRightJustify;
          Columns[cCreditsEx  + ClassFieldNo(Qry)].Alignment     := taRightJustify;
          Columns[cDebitsInc  + ClassFieldNo(Qry)].Alignment     := taRightJustify;
          Columns[cCreditsInc + ClassFieldNo(Qry)].Alignment    := taRightJustify;
          ShowClasscolumns(Qry);
          Tree.invalidate;
          Classcolumns := Classcolumns +4;
end;
procedure TCustomAccountsReportTreeGUI.FormCreate(Sender: TObject);
begin
  QryRefreshClassnode := nil;
  Classcolumns :=0;
  fCustomAccountsReportObj:= nil;
  ReportID:= AppEnv.AccessLevels.GetFormID('TCustomAccountsReportGUI');
  LoadingTree:=  False;
  dtTo.Date := Date;
  TableName := GetUserTemporaryTableName('CustomAccountReportTree');
  inherited;
  CustomAccountsReportObj;// form create created guiprefs and reportid just assigned
  AddColumn('Name', vtString, 300);
  Classcolumns := 0;
  CustomAccountsReportObj.IterateClassQuery(Addclasscolumns, false);

  AddColumn('Debits Ex', vtCurrency, 100); //13
  AddColumn('Credits Ex', vtCurrency, 100); //14

  AddColumn('Debits Inc', vtCurrency, 100); //15
  AddColumn('Credits Inc', vtCurrency, 100); //16

  AddColumn('Balance Ex', vtCurrency, 100); //17
  AddColumn('Balance Inc', vtCurrency, 100);//18

  (*if CustomAccountsReportObj.QryClasses.recordcount > 0 then begin
        CustomAccountsReportObj.QryClasses.first;
        while CustomAccountsReportObj.QryClasses.Eof = False do begin
          AddColumn(CustomAccountsReportObj.QryClasses.fieldbyname('classname').asString + ' Debits Ex', vtCurrency, 100);
          AddColumn(CustomAccountsReportObj.QryClasses.fieldbyname('classname').asString + ' Credits Ex', vtCurrency, 100);
          AddColumn(CustomAccountsReportObj.QryClasses.fieldbyname('classname').asString + ' Balance Ex', vtCurrency, 100);
          AddColumn(CustomAccountsReportObj.QryClasses.fieldbyname('classname').asString + ' Debits Inc', vtCurrency, 100);
          CustomAccountsReportObj.QryClasses.Next;
        end;
      end;*)

  AddColumn('Level No', vtInteger, 100); //19
  Columns[cDebitsEx   + Classcolumns].Alignment      := taRightJustify;
  Columns[cCreditsEx  + Classcolumns].Alignment      := taRightJustify;
  Columns[cDebitsInc  + Classcolumns].Alignment      := taRightJustify;
  Columns[cCreditsInc + Classcolumns].Alignment      := taRightJustify;
  Columns[cBalanceEx  + Classcolumns].Alignment      := taRightJustify;
  Columns[cBalanceInc + Classcolumns].Alignment      := taRightJustify;
  if not devmode then hidecolumn(cLevelno+Classcolumns);
  Formatcolumns;
end;
Procedure TCustomAccountsReportTreeGUI.Formatcolumns;
var
  ctr:Integer;
begin
  for ctr:= 0 to Tree.Header.Columns.Count -1 do begin
    Tree.Header.Columns[ctr].options := Tree.Header.Columns[ctr].options  + [coWrapCaption];
  end;
end;
procedure TCustomAccountsReportTreeGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(Tablename);
  Freeandnil(fCustomAccountsReportObj);
  inherited;

end;

procedure TCustomAccountsReportTreeGUI.FormShow(Sender: TObject);
begin
  inherited;
  Expandall;
  btnCustomize.hint :=  'Please ''Customise'' to choose the accounts for the report';
  //ShowTimedHint(btnCustomize ,  btnCustomize.hint , true );
  //Showclasscolumns;
end;
function TCustomAccountsReportTreeGUI.GuiprefName: String;
begin
  REsult := TCustomAccountsReportObj.GuiprefName;
end;

Procedure TCustomAccountsReportTreeGUI.ShowclassColumns(const Qry:TERPQuery);
begin
  if isclassSelected(Qry.FieldByName('ClassID').AsInteger) then begin
      unhidecolumn(cDebitsEx   + ClassFieldNo(Qry));
      unhidecolumn(cCreditsEx  + ClassFieldNo(Qry));
      unhidecolumn(cDebitsInc  + ClassFieldNo(Qry));
      unhidecolumn(cCreditsInc + ClassFieldNo(Qry));
  end else begin
      hidecolumn(cDebitsEx   + ClassFieldNo(Qry));
      hidecolumn(cCreditsEx  + ClassFieldNo(Qry));
      hidecolumn(cDebitsInc  + ClassFieldNo(Qry));
      hidecolumn(cCreditsInc + ClassFieldNo(Qry));
  end;
end;
procedure TCustomAccountsReportTreeGUI.Readguiprefs;
begin
  inherited;
  CustomAccountsReportObj.Hidetotals :=  GuiPrefs.Node['Options.Hidetotals'].asBoolean;
  CustomAccountsReportObj.USeGroupcolours :=  GuiPrefs.Node['Options.USeGroupcolours'].AsBoolean;
  CustomAccountsReportObj.BlankWhen0      :=  GuiPrefs.Node['Options.Blankwhen0'].AsBoolean;
  CustomAccountsReportObj.SelectedClasses := GuiPrefs.Node['Options.SelectedDepartments'].asString;
end;
procedure TCustomAccountsReportTreeGUI.RefreshClassnodes(Const Qry :TERPQuery);
begin
        RefreshClassnodeRec^.Data.celldata[cDebitsEx   + ClassFieldNo(Qry)].value := QryRefreshClassnode.FieldByName(CustomAccountsReportObj.DebitsExField).asString;
        RefreshClassnodeRec^.Data.celldata[cCreditsEx  + ClassFieldNo(Qry)].value := QryRefreshClassnode.FieldByName(CustomAccountsReportObj.CreditsExfield).asString;
        RefreshClassnodeRec^.Data.celldata[cDebitsInc  + ClassFieldNo(Qry)].value := QryRefreshClassnode.FieldByName(CustomAccountsReportObj.DebitsIncfield).asString;
        RefreshClassnodeRec^.Data.celldata[cCreditsInc + ClassFieldNo(Qry)].value := QryRefreshClassnode.FieldByName(CustomAccountsReportObj.CreditsIncfield).asString;
end;
(*procedure TCustomAccountsReportTreeGUI.logrec(RecordRec: PNodeRec);
var
  ctr:Integer;
  s:String;
begin
  s:= '';
  for ctr := 0 to columns.count -1 do begin
    if s<> '' then s := s +',' ;
    s:= s +Tree.header.columns[ctr].text;
  end;

  s:= '';
  for ctr := 0 to columns.count -1 do begin
    if s<> '' then s := s +',' ;
    s:= s + RecordRec^.Data.celldata[ctr].value;
  end;
end;*)
procedure TCustomAccountsReportTreeGUI.RefreshNode(RecordRec: PNodeRec; qry: TERPQuery;Levelno:Integer);
begin
        RecordRec^.Data                             := TAccNodeData.Create(Self.Columns);
        RecordRec^.Data.Id                          := Qry.fieldbyname('AccountID').asInteger;
        RecordRec^.Data.KeyStr                      := Qry.fieldbyname('Category').asString;
        RecordRec^.Data.celldata[cname].value       := qry.FieldByName('Accountname').AsString;
        RefreshClassnodeRec := RecordRec;
        QryRefreshClassnode := Qry;
        CustomAccountsReportObj.IterateClassQuery(RefreshClassnodes, False);
        QryRefreshClassnode := nil;
        RecordRec^.Data.celldata[cDebitsEx   + Classcolumns].value   := qry.FieldByName('DebitsEx').asString;
        RecordRec^.Data.celldata[cCreditsEx  + Classcolumns].value  := qry.FieldByName('CreditsEx').asString;
        RecordRec^.Data.celldata[cDebitsInc  + Classcolumns].value  := qry.FieldByName('DebitsInc').asString;
        RecordRec^.Data.celldata[cCreditsInc + Classcolumns].value := qry.FieldByName('CreditsInc').asString;

        RecordRec^.Data.celldata[cBalanceEx +Classcolumns].value  := floatToStr(qry.FieldByName('BalanceEx').asFloat );
        RecordRec^.Data.celldata[cBalanceInc +Classcolumns].value := floatToStr(qry.FieldByName('BalanceInc').asFloat );

        RecordRec^.Data.celldata[cLevelno+Classcolumns].value    := inttostr(qry.FieldByName('Levelno').asInteger );//inttostr(Levelno);
end;
procedure TCustomAccountsReportTreeGUI.RefreshTree;
var
  qry: TERPQuery;
  Rec: PNodeRec;
  aNode: PVirtualNode;
  //subcount:Integer;
  Levelno:Integer;
  function GetSubAccounts(AccountID:Integer; const Category: string; const aParentNode: PVirtualNode; xLevelno:Integer):Integer;
  var
    SubQry :TERPQuery;
    xRec: PNodeRec;
    xNode: PVirtualNode;
    (*childcount:Integer;*)
    SubLevelno :Integer;
  begin
    SubLevelno:= xLevelno+1;
    Result := 0;
    //childcount :=0;
     subQry:= DbSharedObj.GetQuery(GetSharedMyDacConnection);
     try
      subQry.SQL.text := Qry.SQl.text;
      subQry.Parambyname('ParentID').asInteger :=AccountID;
      subQry.Parambyname('category').asString := Category;
      SubQry.open;
      if SubQry.recordcount =0 then exit;
      if highestLevel < sublevelno then highestLevel :=sublevelno;
      SubQry.First;
      while not subqry.Eof do begin
            xNode:= Tree.AddChild(aParentNode);
            xRec := Tree.GetNodeData(xNode);

            RefreshNode(xrec, subQry , SubLevelno );
            (*childcount := *)GetSubAccounts(subQry.fieldbyname('accountId').asInteger, subQry.fieldbyname('category').asString, xNode, SubLevelno);
            Result := REsult+1;
            subqry.Next;
            if not subqry.Eof  then
              if sametext(subqry.FieldByName('recordtype').asString , 'Total') then begin
                    xNode:= Tree.AddChild(aParentNode);
                    xRec := Tree.GetNodeData(xNode);
                    RefreshNode(xrec, subQry , SubLevelno );
                    xRec^.Data.KeyStr := xRec^.Data.KeyStr +'TOTAL';
                    subqry.Next;
              end;
      end;
     finally
       if SubQry.active then SubQry.close;
       DbSharedObj.ReleaseObj(subQry);
     end;
  end;
begin
  if LoadingTree then exit;
  LoadingTree:= True;
  try
    Processingcursor(True);
    try
        clog('');
        highestLevel := 1;
        Levelno := 1;
        if CustomAccountsReportObj.ReportAsOn<> IncSecond(IncDay(dateof(dtTo.DateTime), 1), -1) then begin
          CustomAccountsReportObj.ReportAsOn:= IncSecond(IncDay(dateof(dtTo.DateTime), 1), -1);
          CustomAccountsReportObj.RefreshTable;
        end;

        Qry:= DbSharedObj.GetQuery(GetSharedMyDacConnection);
        try
            Qry.SQL.add( 'Select  ');
            Qry.SQL.add( 'ID as ID,');
            Qry.SQL.add( 'accountId as accountId,');
            Qry.SQL.add( 'category as category ,');
            Qry.SQL.add( 'recordtype,');
            Qry.SQL.add( 'concat(if(level4<> "", REPEAT("  ",16) , '+
                                    'if(level3<> "", REPEAT("  ",12) ,'+
                                    'if(level2<> "", REPEAT("  ",8) , '+
                                    'if(level1<> "", REPEAT("  ",4) , "")))),'+
                                    'if(ifnull(Reportcaption,"")="", Accountname, ReportCaption) ) as reportCaption,');
            Qry.SQL.add( 'trim(if(ifnull(Reportcaption,"")="", Accountname, ReportCaption)) as AccountName,');
            Qry.SQL.add( 'Levelno as Levelno,');

            Qry.SQL.add(CustomAccountsReportObj.ClassFields('"ClassIDFieldPrefix"DebitsEx as "ClassIDFieldPrefix"DebitsEx,'+
            '"ClassIDFieldPrefix"DebitsInc as "ClassIDFieldPrefix"DebitsInc,'+
            '"ClassIDFieldPrefix"CreditsEx as "ClassIDFieldPrefix"CreditsEx,'+
            '"ClassIDFieldPrefix"CreditsInc as "ClassIDFieldPrefix"CreditsInc,'));

            Qry.SQL.add( 'DebitsEx   as DebitsEx,');
            Qry.SQL.add( 'DebitsInc  as DebitsInc,');
            Qry.SQL.add( 'CreditsEx  as CreditsEx,');
            Qry.SQL.add( 'CreditsInc as CreditsInc,');


            Qry.SQL.add( 'BalanceEx as BalanceEx,');
            Qry.SQL.add( 'BalanceInc as BalanceInc');
            Qry.SQL.add( ' from ' + Tablename );
            Qry.SQL.add( ' where ifnull(ParentId,0)=:ParentID' );
            Qry.SQL.add( ' and (:ParentID=0 or ifnull(parentcategory,"")=:category)' );
            Qry.SQL.add( ' order by SortOrder');
            Qry.Parambyname('ParentID').asInteger :=0;
            Qry.Parambyname('category').asString := '';

            Qry.open;
            Tree.Clear;
            while not qry.Eof do begin

                  aNode:= Tree.AddChild(nil);
                  Rec := Tree.GetNodeData(aNode);
                  RefreshNode(rec, Qry , Levelno);
                  (*Subcount := *)GetSubAccounts(Qry.fieldbyname('accountId').asInteger, Qry.fieldbyname('category').asString, aNode, Levelno);
                  qry.Next;
                  if sametext(Qry.FieldByName('recordtype').asString , 'Total') then begin
                    aNode:= Tree.AddChild(nil);
                    Rec := Tree.GetNodeData(aNode);
                    RefreshNode(rec, Qry, Levelno );
                    Rec^.Data.KeyStr := Rec^.Data.KeyStr +'TOTAL';
                    qry.Next;
                  end;
            end;
        finally
          DbSharedObj.ReleaseObj(Qry);
        end;
        inherited;
        ExpandContractTree(not(btnExpandAll.Caption = 'Expand All'));
    finally
      Processingcursor(False);
    end;
  finally
    LoadingTree := False;
  end;
end;
procedure TCustomAccountsReportTreeGUI.setSelectedDepartments(const Value: String);
begin
  CustomAccountsReportObj.SelectedClasses := Value;
  GuiPrefs.Node['Options.SelectedDepartmentList'].asString := Value;
end;

procedure TCustomAccountsReportTreeGUI.TreeDrawText(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  const Text: string; const CellRect: TRect; var DefaultDraw: Boolean);
var
  NodeData: PNodeRec;
begin
  if CustomAccountsReportObj.USeGroupcolours then begin
    NodeData := TRee.GetNodeData(Node);
    try
      if strtoInt(Nodedata^.Data.Celldata[cLevelno+Classcolumns].Value) = highestlevel-4 then begin
        TargetCanvas.Font.Color := clNavy;
      end else if strtoInt(Nodedata^.Data.Celldata[cLevelno+Classcolumns].Value) = highestlevel-3 then begin
        TargetCanvas.Font.Color := clBlack;
      end else if strtoInt(Nodedata^.Data.Celldata[cLevelno+Classcolumns].Value) = highestlevel-2 then begin
        TargetCanvas.Font.Color := clBlue;
      end else if strtoInt(Nodedata^.Data.Celldata[cLevelno+Classcolumns].Value) = highestlevel-1 then begin
        TargetCanvas.Font.Color := clGreen;
      end else if strtoInt(Nodedata^.Data.Celldata[cLevelno+Classcolumns].Value) = highestlevel then begin
        TargetCanvas.Font.Color := clRed;
      end;
    Except
      // kill the exception
    end;
  end;

end;

procedure TCustomAccountsReportTreeGUI.TreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;  var CellText: string);
begin
  inherited;
  if not(CustomAccountsReportObj.hidetotals) and (Node.ChildCount >0) and (column <> cname ) (*and (Column in [cDebitsEx   +Classcolumns,
                                                                                      cCreditsEx  +Classcolumns,
                                                                                      cDebitsinc  +Classcolumns,
                                                                                      cCreditsInc +Classcolumns,
                                                                                      cBalanceEx  +Classcolumns,
                                                                                      cBalanceInc +Classcolumns ])*)  then begin
    cellText :='';
  end;
end;

procedure TCustomAccountsReportTreeGUI.WriteGuiPrefs;
begin
  inherited;
  GuiPrefs.Node['Options.Hidetotals'].asBoolean         := CustomAccountsReportObj.Hidetotals;
  GuiPrefs.Node['Options.USeGroupcolours'].AsBoolean    := CustomAccountsReportObj.USeGroupcolours;
  GuiPrefs.Node['Options.Blankwhen0'].AsBoolean         := CustomAccountsReportObj.Blankwhen0;
  GuiPrefs.Node['Options.SelectedDepartments'].asString := CustomAccountsReportObj.SelectedClasses;
end;

procedure TCustomAccountsReportTreeGUI.ReFreshReport(Sender: TObject);
begin
  if not(formshown) then exit;
  RefreshTree;
  CustomAccountsReportObj.IterateClassQuery(ShowClasscolumns, False);
  Tree.invalidate;
end;

initialization
  RegisterClass(TCustomAccountsReportTreeGUI);

end.

