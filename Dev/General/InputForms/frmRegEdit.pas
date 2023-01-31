unit frmRegEdit;

interface
{$I ERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, StdCtrls, Shader, ExtCtrls, DNMPanel, DB, MemDS,
  DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState,
  SelectionDialog, AppEvnts, ComCtrls, Grids, Wwdbigrd, Wwdbgrid, wwdblook,
  RegEdit, Mask, wwdbedit, Wwdotdot, Wwdbcomb, DNMSpeedButton, Buttons;

type
  TfmRegEdit = class(TBaseInputGUI)
    Label1: TLabel;
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    RegTreeView: TTreeView;
    QryRegEdit: TERPQuery;
    QryRegEditID: TIntegerField;
    QryRegEditKeyName: TWideMemoField;
    QryRegEditRegName: TWideStringField;
    QryRegEditRegValue: TWideStringField;
    dsRegEdit: TDataSource;
    CboRegEdit: TwwDBComboBox;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    grdRegEdit: TwwDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdRegEditRowChanged(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
    procedure grdRegEditEnter(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fsRegName: String;
    Tablename:String;
    RegEntries: TList;

    procedure setRegName(const Value: String);
    Procedure SetcomboforPort;
    function IsOktoSaveRegistry:Boolean;


  public
    Property RegName:String read fsRegName write setRegName;
  end;


implementation

uses CommonLib, CommonDbLib,types,StrUtils , BusObjAudit,
  AppEnvironment, tcConst;

{$R *.dfm}

{ TfmRegEdit }

procedure TfmRegEdit.btnCancelClick(Sender: TObject);
begin
  inherited;
  modalresult := mrcancel;
end;

procedure TfmRegEdit.btnSaveClick(Sender: TObject);
var
  regEditobj:TRegEdit;
begin
  PostDB(QryRegEdit);
  if not IsOktoSaveRegistry then exit;

  try
      regEditobj:=TRegEdit.Create(Self);
      try
        QryRegEdit.First;
        while QryRegEdit.Eof = False do begin
          RegEditobj.SavetoRegistry(OPOSRegPath+Regname, QryRegEditRegName.AsString , QryRegEditRegValue.AsString);
          QryRegEdit.Next;
        end;
      finally
        Freeandnil(REgEditobj);
      end;
  finally
    Modalresult := mrOK;
  end;

end;

procedure TfmRegEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := cafree;
end;

procedure TfmRegEdit.FormCreate(Sender: TObject);
begin
  inherited;
  Tablename:= CreateUserTemporaryTable('tmp_regedit');
  closeDB(QryRegEdit);
  QryRegEdit.SQL.Clear;
  QryRegEdit.SQL.Add('Select * from '+tablename);

  CboRegEdit.Items.Clear;
  CboRegEdit.Items.CommaText := Comports;
  RegTreeView.Visible:= False;
  {$IFDEF DevMode}
    RegTreeView.Visible:= True;
  {$ENDIF}

end;

procedure TfmRegEdit.FormDestroy(Sender: TObject);
begin
  FreeandNil(RegEntries);
  inherited;

end;

procedure TfmRegEdit.FormShow(Sender: TObject);
begin
  inherited;
  
  opendb(QryRegEdit);
end;

procedure TfmRegEdit.grdRegEditEnter(Sender: TObject);
begin
  inherited;
  SetcomboforPort;
end;

procedure TfmRegEdit.grdRegEditRowChanged(Sender: TObject);
begin
  inherited;
  SetcomboforPort;
end;

function TfmRegEdit.IsOktoSaveRegistry: Boolean;
var
  i:Integer;
  AuditMsg:String;
  Msg:String;
  s1, s2:String;

begin
  REsult := true;
  AuditMsg:= '';
  Msg:= '';
  try
  if RegEntries.Count>0  then begin
      for i := 0 to RegEntries.Count - 1 do begin
        s1:=pRegEntryItem(RegEntries.Items[i])^.Key;
        s2:=pRegEntryItem(RegEntries.Items[i])^.Name;
        if QryRegEdit.locate('Keyname;RegName' , VarArrayof([s1,s2]) , [])  then begin
          if not(SAmetext(pRegEntryItem(RegEntries.Items[i])^.Value , QryRegEdit.FieldByname('RegValue').asString)) then begin
            if AuditMsg<> '' then AuditMsg := AuditMsg + chr(13);
            if Msg <> '' then Msg := Msg +chr(13);
            AuditMsg:= 'Registry = ' +QryRegEdit.FieldByname('RegName').asString +
                        AuditTrialOldValue +pRegEntryItem(RegEntries.Items[i])^.Value +
                        AuditTrialNewValue + QryRegEdit.FieldByname('RegValue').asString;
            Msg:= QryRegEdit.FieldByname('RegName').asString +
                        AuditTrialOldValue +pRegEntryItem(RegEntries.Items[i])^.Value +
                        AuditTrialNewValue+ QryRegEdit.FieldByname('RegValue').asString;
          end;
        end;
      end;

      if AuditMsg<> '' then
        if CommonLib.MessageDlgXP_Vista('The Following Entries Are Changed in This Registry.'+
                        chr(13) +chr(13) +Msg +chr(13)+ chr(13)+
                        'It is not Possible to Revert After Saving.'+chr(13) +
                        'Are You Sure you Want To Save?', mtConfirmation, [mbyes,mbno], 0) = mrno then begin
                          result :=  False;
        end;
  end;
  finally
    if result and (AuditMsg<> '') then
      with TAudit.Create(nil) do try
        Load(0);
        New;
        TransType:= 'RegEdit';
        TransGlobalref:= '';
        DataDescription:= 'Editing Registry : '+RegName;
        AuditDate:= now;
        ChangeDescription:= AuditMsg;
        try
            Save;
        Except
            // kill the exception when ChangeDescription is more than 255 chars
        end;
      finally
        Free;
      end;
  end;



end;

procedure TfmRegEdit.SetcomboforPort;
begin
  grdRegEdit.ControlType.Clear;
  if SameText(QryRegEditRegName.asString,'Port') then begin
    grdRegEdit.ControlType.add('RegValue;CustomEdit;cboRegedit;F');
  end;
end;

procedure TfmRegEdit.setRegName(const Value: String);
var
  strArray: TStringDynArray;
  i:Integer;
  Level1: TTreeNode;

  fRegEdit:TRegEdit;
  s:String;

begin
  fsRegName := Value;
  RegTreeView.Items.Clear;
  Level1:= RegTreeView.Items.Add(nil,'HKEY_LOCAL_MACHINE');
  strArray:= SplitString(OPOSRegPath+Value, '\');
  for i := Low(strArray) to High(strArray) do begin
    Level1 := RegTreeView.Items.AddChild(Level1, strArray[i]);
  end;
  RegTreeView.FullExpand;


  fRegEdit:=TRegEdit.Create(self);
  RegEntries:=fRegEdit.ReadLocalMachineRegistry(OPOSRegPath+Value, False)  ;
  With CommonDbLib.TempMyScript do try
    SQL.Add('truncate '+tablename +';');
    if RegEntries.Count>0  then begin
      SQL.Add('insert into ' + tablename +'( Keyname , RegName , RegValue)  Values ' );
      s:= '';
      for i := 0 to RegEntries.Count - 1 do begin
        s:= s+'('+quotedstr(replacestr(pRegEntryItem(RegEntries.Items[i])^.Key,'\' , '\\'))+','+
                      quotedstr(pRegEntryItem(RegEntries.Items[i])^.Name)+','+
                      quotedstr(pRegEntryItem(RegEntries.Items[i])^.Value)+')';
        SQL.Add(s);
        s:= ',';
      end;
    end;
  finally
    execute;
    Free;
  end;
end;
initialization
  RegisterClassOnce(TfmRegEdit);

end.
