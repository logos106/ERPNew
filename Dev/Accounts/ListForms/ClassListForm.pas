unit ClassListForm;

{ Date     Version Who  What
 -------- -------- ---  --------------------------------------------------------
 07/09/05  1.00.01 IJB  Modified to use new filtering on base listing.
 }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, ExtCtrls, ComCtrls,AdvOfficeStatusBar, ImgList, Menus, AdvMenus, PrintDAT,
  Forms, ActnList, wwDialog, Wwlocate, SelectionDialog, DNMPanel,
  wwcheckbox, MemDS, DBAccess, MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog,
   wwdblook, kbmMemTable, Shader, DAScript, MyScript, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TClassListGUI = class(TBaseListingGUI)
    chkTreeMode: TwwCheckBox;
    qryMainGlobalRef: TWideStringField;
    qryMainClassID: TIntegerField;
    qryMainHeaderClass: TWideStringField;
    qryMainClassName: TWideStringField;
    qryMainFullClassName: TWideStringField;
    qryMainClassTree: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainSiteCode: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainUseaddress: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure cmdNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkTreeModeClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdPrintClick(Sender: TObject);
  private
    fsclassIds :STring;
    fiTransferfromclass :Integer;
    procedure SetClassLevelField;
    Procedure SetStockautoTransferClassFromfilter;
    procedure CleanUpLevelFields;
    procedure UpdateLevels(const ClassID: integer; const Level1, Level2, Level3, Level4: string);
  public
    Property SelectedClassIDs :String   read   fsclassIds           write fsclassIds;
    Property Transferfromclass :Integer read   fiTransferfromclass    Write fiTransferfromclass;
  protected
    procedure RefreshQuery; override;
    procedure SetGridColumns; override;
  end;


implementation

{$R *.dfm}

uses FastFuncs,frmClassFrm,  CommonDbLib, CommonLib, AppEnvironment;

procedure TClassListGUI.grpFiltersClick(Sender: TObject);
begin
    if fiTransferfromclass <> 0 then
      GroupFilterString := 'classId <> ' + IntToStr(fiTransferfromclass)
    else
      GroupFilterString := '';

  case grpFilters.ItemIndex of
    0:
      begin
        if GroupFilterString <> '' then
          GroupFilterString := GroupFilterString + ' and ' ;

        GroupFilterString := GroupFilterString + 'Active = ' + QuotedStr('T');
      end;
    1:
      begin
        if GroupFilterString <> '' then
          GroupFilterString := GroupFilterString + ' and ' ;
          
        GroupFilterString := GroupFilterString + 'Active = ' + QuotedStr('F');
      end;
    2:
      begin
      end;
  end;

  SetClassLevelField;  
  inherited;
end;

procedure TClassListGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  DisableForm;
  try
    Form := GetComponentByClassName('TfrmClass');
    if Assigned(Form) then begin
      with TfrmClass(Form) do begin
        AttachObserver(Self);
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  finally
    EnableForm;
  end;
end;

procedure TClassListGUI.FormCreate(Sender: TObject);
begin
  inherited;
    fsclassIds :='';
    fiTransferfromclass :=0;
  SetClassLevelField;
  Caption := AppEnv.DefaultClass.ClassHeading + ' Listing'
end;

procedure TClassListGUI.CleanUpLevelFields;
var
  qryTemp: TERPQuery;
begin
  (*qryTemp := TERPQuery.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try*)
  QryTemp := commonDBlib.TempMyQuery;
  try
    qryTemp.Sql.Add('UPDATE tblclass SET Level1 = ClassName , Level2 =NULL , Level3 =NULL , Level4 =NULL ');
    qryTemp.Execute;
  finally
    FreeAndNil(qryTemp);
  end;
end;
procedure TClassListGUI.SetStockautoTransferClassFromfilter;
begin
    if fiTransferfromclass <> 0 then begin
        Qrymain.filtered := false;
        Qrymain.filter := 'classId <> ' + IntToStr(fiTransferfromclass);
        Qrymain.filtered := True;
    end;
end;
procedure TClassListGUI.SetClassLevelField;
var
  qryLevelsTemp: TERPQuery;
begin
  CleanUpLevelFields;
  (*qryLevelsTemp := TERPQuery.Create(nil);
  qryLevelsTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try*)
  qryLevelsTemp := commonDBlib.TempMyQuery;
  try
    qryLevelsTemp.Sql.Add('SELECT ClassID, ');
    qryLevelsTemp.Sql.Add(SplitField('', 'Concat_WS("^",ClassGroup,ClassName)' , 1) +' as Level1, ');
    qryLevelsTemp.Sql.Add(SplitField('', 'Concat_WS("^",ClassGroup,ClassName)' , 2) +' as Level2, ');
    qryLevelsTemp.Sql.Add(SplitField('', 'Concat_WS("^",ClassGroup,ClassName)' , 3) +' as Level3, ');
    qryLevelsTemp.Sql.Add(SplitField('', 'Concat_WS("^",ClassGroup,ClassName)' , 4) +' as Level4 ');
    qryLevelsTemp.Sql.Add('FROM tblclass Where char_length(ClassGroup) > 0 ; ');
    qryLevelsTemp.Active := true;

    if not qryLevelsTemp.IsEmpty then begin
      qryLevelsTemp.First;
      while not qryLevelsTemp.Eof do begin
        UpdateLevels(qryLevelsTemp.FieldByName('ClassID').AsInteger, qryLevelsTemp.FieldByName('Level1').AsString,
          qryLevelsTemp.FieldByName('Level2').AsString, qryLevelsTemp.FieldByName('Level3').AsString,
          qryLevelsTemp.FieldByName('Level4').AsString);
        qryLevelsTemp.Next;
      end;
    end;
  finally
    FreeandNil(qryLevelsTemp);
  end;
end;

procedure TClassListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainUseaddress.fieldname);
  RemoveFieldfromGrid(qryMainGlobalRef.fieldname);
  RemoveFieldfromGrid(qryMainClassID.fieldname);
end;

procedure TClassListGUI.UpdateLevels(const ClassID: integer; const Level1, Level2, Level3, Level4: string);
var
  qryTemp: TERPQuery;
begin
  (*qryTemp := TERPQuery.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try*)
  QryTemp := commonDBlib.TempMyQuery;
  try
    qryTemp.Sql.Add('UPDATE tblclass SET Level1 ="' + Level1 + '" , Level2 ="' + Level2 +
      '" , Level3 ="' + Level3 + '" , Level4 ="' + Level4 + '" ');
    qryTemp.Sql.Add('WHERE ClassID =' + IntToStr(ClassID) + ';');
    qryTemp.Execute;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TClassListGUI.chkTreeModeClick(Sender: TObject);
begin
  inherited;
  if chkTreeMode.Checked then begin
    UseSortinSearch         := false;
    grdMain.OnTitleButtonClick := nil;
    qryMain.IndexFieldNames := 'FullClassName ASC CIS';
  end else begin
    UseSortinSearch := true;
    grdMain.OnTitleButtonClick := grdMainTitleButtonClick;
  end;
end;

procedure TClassListGUI.RefreshQuery;
begin
  SetClassLevelField;
  SetStockautoTransferClassFromfilter;
  inherited;
end;

procedure TClassListGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
    i:Integer;
begin
  inherited;
  fsclassIds := '';
  if grdMain.SelectedList.Count > 0 then begin
      for i := 0 to grdMain.SelectedList.Count - 1 do begin
        qryMain.GotoBookmark(grdMain.SelectedList.Items[i]);
        if fsclassIds <> '' then fsclassIds := fsclassIds + ',' ;
        fsclassIds := fsclassIds + IntToStr(Qrymain.fieldByname('classId').asInteger);
      end;
      if fsclassIds <> '' then fsclassIds := '(' + fsclassIds + ')' ;
  end;
end;

procedure TClassListGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

initialization
  RegisterClassOnce(TClassListGUI);
end.
