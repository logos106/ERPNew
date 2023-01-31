unit frmCustomfieldList;

interface
{$I ERP.inc}
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  StdCtrls, Shader, DNMPanel, wwcheckbox, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  Mask, wwdbedit, Wwdotdot, Wwdbcomb, Busobjcustomfields, BusObjBase,
  DNMSpeedButton, ProgressDialog;

const
  SalesLinesCustomfields = 10;
  POLinesCustomfields =10;
  RepairPartsCustomfields =10;
type

  TfmCustomfieldList = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    QryCustomFieldList: TERPQuery;
    QryCustomFieldListGlobalref: TWideStringField;
    QryCustomFieldListCFID: TIntegerField;
    QryCustomFieldListDescription: TWideStringField;
    QryCustomFieldListisCombo: TWideStringField;
    QryCustomFieldListDatatype: TWideStringField;
    QryCustomFieldListmstimeStamp: TDateTimeField;
    grdmain: TwwDBGrid;
    dsCustomFieldList: TDataSource;
    DNMPanel4: TDNMPanel;
    grdDropDownText: TwwDBGrid;
    grdDropDownTextIButton: TwwIButton;
    DNMPanel5: TDNMPanel;
    chkisCombo: TwwCheckBox;
    cboDatatype: TwwDBComboBox;
    QrycustomfieldListdropdowns: TERPQuery;
    dsCustomfieldListdropdowns: TDataSource;
    QrycustomfieldListdropdownsGlobalRef: TWideStringField;
    QrycustomfieldListdropdownsDropDownID: TIntegerField;
    QrycustomfieldListdropdownsCustomFieldlistId: TLargeintField;
    QrycustomfieldListdropdownsText: TWideStringField;
    QrycustomfieldListdropdownsSeqno: TIntegerField;
    QrycustomfieldListdropdownsmsTimeStamp: TDateTimeField;
    btnClose: TDNMSpeedButton;
    btnCompleted: TDNMSpeedButton;
    QryCustomFieldListListType: TWideStringField;
    grdmainIButton: TwwIButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkisComboClick(Sender: TObject);
    procedure grdDropDownTextExit(Sender: TObject);
    procedure grdmainExit(Sender: TObject);
    procedure QryCustomFieldListAfterInsert(DataSet: TDataSet);
    procedure QryCustomFieldListBeforeInsert(DataSet: TDataSet);
    procedure grdDropDownTextIButtonClick(Sender: TObject);
    procedure grdmainIButtonClick(Sender: TObject);
  private
    AllLinesValid:Boolean;
    CustomFieldList :TCustomFieldList;
    ChangingISCOmbo :Boolean;
    fsListType: TListType;
    function SaveDAta:boolean;
    Procedure ValidateDatacallback(const Sender: TBusObj; var Abort: Boolean);
    procedure SetListType(const Value: TListType);
    function Gridtype: Boolean;
    Function ListtypeID(Const Lsttype:TListType):Integer;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    Property ListType :TListType REad fsListType write SetListType;
  end;


implementation

uses CommonLib, BusObjConst, CustomfieldonGrid, tcConst, BusObjDeletedItem;

{$R *.dfm}
procedure TfmCustomfieldList.btnCloseClick(Sender: TObject);
begin
  inherited;
  if fsModal in FormState then
    ModalResult := mrCancel
  else
    Self.Close;
end;

procedure TfmCustomfieldList.btnCompletedClick(Sender: TObject);
begin
  inherited;
  if not SaveData then exit;
  CustomFieldList.Connection.CommitTransaction;
  CustomFieldList.Dirty := False;
  if fsModal in FormState then
    ModalResult := mrOk 
  else
    Self.Close;
end;

procedure TfmCustomfieldList.chkisComboClick(Sender: TObject);
begin
  inherited;
  if ChangingISCOmbo then exit;
  ChangingISCOmbo:= True;
  try
    if screen.activecontrol = chkisCombo then begin
     CustomFieldList.ISCOmbo := chkisCombo.checked;
     CustomFieldList.PostDB;

     if not CustomFieldList.ISCOmbo then begin
        CustomFieldList.Dropdown.DeleteAll;
        Setcontrolfocus(grdmain);
     end else
        Setcontrolfocus(grdDropDownText);
    end;
  finally
    ChangingISCOmbo:= False;
  end;
end;

procedure TfmCustomfieldList.DoBusinessObjectEvent(const Sender: TDatasetBusObj;  const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
         if Sender is TCustomFieldList          then TCustomFieldList(Sender).Dataset           := QryCustomFieldList
    else if Sender is TCustomFieldListDropDown then TCustomFieldListDropDown(Sender).Dataset  := QrycustomfieldListdropdowns;
  end;
end;

procedure TfmCustomfieldList.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  inherited;
  UserLock.UnlockAllCurrentInstance;
  Action := caFree;
end;

procedure TfmCustomfieldList.FormCloseQuery(Sender: TObject;  var CanClose: Boolean);
begin
  inherited;
  if CustomFieldList.Dirty then
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveData then begin
            self.CommitTransaction;
            CanClose:= true;
          end else begin
            CanClose:= false;
          end;
        end;
      mrNo:
        begin
          self.RollbackTransaction;
          CanClose:= true;
        end;
      mrCancel:
        begin
          Canclose := False;
          Exit;
        end;
    end;
end;

procedure TfmCustomfieldList.FormCreate(Sender: TObject);
begin
  inherited;
  ChangingISCOmbo:= False;
  CustomFieldList := TCustomFieldList.Create(self);
  CustomFieldList.Connection := TMyDacDataConnection.Create(CustomFieldList);
  CustomFieldList.connection.Connection := Self.MyConnection;
  CustomFieldList.busobjEvent := DoBusinessObjectEvent;
  fsListType := ltNone;
end;

procedure TfmCustomfieldList.FormShow(Sender: TObject);
var
  s:String;
begin
  inherited;
  CustomFieldList.LoadSelect('ListType = ' +quotedstr(ListTypetoString(ListType)));
  CustomFieldList.Dropdown;
  OpenQueries;
  CustomFieldList.Connection.BeginTransaction;
  {$IFDEF DevMode}
    QryCustomFieldListListType.visible := True;
  {$ELSE}
    QryCustomFieldListListType.visible := False;
  {$ENDIF}
  userlock.enabled := true;
  if not (UserLock.Lock('tblcustomfieldlist' , ListtypeID(ListType), Self.Caption)) then begin
    AccessLevel := 5;
    s:= UserLock.LockMessage;
    s:= replacestr(s , 'Unable to update data.' , 'Unable to change Custom field List');
    s:= replacestr(s , 'accessing this record' , 'accessing Custom Field list');
    CommonLib.MessageDlgXP_Vista(s + NL + NL +'Access has been changed to read-only.',mtWarning, [mbOK], 0);
  end;
end;

procedure TfmCustomfieldList.grdDropDownTextExit(Sender: TObject);
begin
  inherited;
  CustomFieldList.DropDown.PostDB;
end;

procedure TfmCustomfieldList.grdDropDownTextIButtonClick(Sender: TObject);
begin
  inherited;
  if not CustomFieldList.Dropdown.Delete then begin
    CommonLib.MessageDlgXP_Vista('Error deleting list item',mtError,[mbOk],0);
    exit;
  end;
  QrycustomfieldListdropdowns.Refresh;
  CustomFieldList.IsCombo := (CustomFieldList.Dropdown.count >0) ;
  CustomFieldList.postDb;
end;

procedure TfmCustomfieldList.grdmainExit(Sender: TObject);
begin
  inherited;
  CustomFieldList.PostDB;
end;


procedure TfmCustomfieldList.grdmainIButtonClick(Sender: TObject);
var
  msg: string;
  id: integer;
  cmd: TERPCommand;
begin
  inherited;
  id := self.QryCustomFieldListCFID.AsInteger;

  if TDeletedItem.AddDeleted('tblCustomFieldList','TCustomFieldList',QryCustomFieldListGlobalref.AsString,QryCustomFieldListCFID.AsInteger,QryCustomFieldList.Connection,msg,true) then begin
    // delete drop down values
    cmd := TERPCommand.Create(nil);
    try
      cmd.Connection := QryCustomFieldList.Connection;
      cmd.SQL.Add('delete from tblcustomfieldListdropdowns where CustomFieldListId = ' + IntToStr(id));
      cmd.Execute;
    finally
      cmd.Free;
    end;
    QryCustomFieldList.Refresh;
  end
  else begin
    CommonLib.MessageDlgXP_Vista('Could not delete custom field: '+ msg, mtWarning, [mbOk],0);

  end;
end;

procedure TfmCustomfieldList.QryCustomFieldListAfterInsert(DataSet: TDataSet);
begin
  inherited;
  CustomFieldList.LisTtype :=  ListTypetoString(ListType);
end;

procedure TfmCustomfieldList.QryCustomFieldListBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  if Listtype = ltSaleSLines then
    if CustomFieldList.Count >= SalesLinesCustomfields then begin abort; exit;end;
  if Listtype = ltOrderlines then
    if CustomFieldList.Count >= POLinesCustomfields then begin abort; exit;end;
  if Listtype = ltRepairparts then
    if CustomFieldList.Count >= RepairPartsCustomfields then begin abort; exit;end;
end;

function TfmCustomfieldList.SaveDAta: boolean;
begin
  REsult := False;
  AllLinesValid:=True;
  CustomFieldList.Iteraterecords(ValidateDatacallback);
  if not (AllLinesValid) then exit;
  REsult := TRue;
end;

function  TfmCustomfieldList.Gridtype:Boolean;
begin
  Result := (fsListType = ltsaleslines) or (fsListType = ltOrderlines);
end;

function TfmCustomfieldList.ListtypeID(const Lsttype: TListType): Integer;
begin
(*@@@@
  Result := 0;
       if Lsttype  = ltNone         then Result := 1
  else if Lsttype  = ltCustomer     then Result := 2
  else if Lsttype  = ltsaleslines   then Result := 3
  else if Lsttype  = ltOrderLines   then Result := 4
  else if Lsttype  = ltSupplier     then Result := 5
  else if Lsttype  = ltRepairparts  then Result := 6
  else if LstType  = ltEquipment    then Result := 7;
*)
  Result := ord(lstType) + 1;
end;

procedure TfmCustomfieldList.SetListType(const Value: TListType);
begin
  fsListType := Value;
//  if Gridtype then
//    if cboDatatype.Items.indexof('Date Time'#9'ftDateTime') >0 then
//     cboDatatype.Items.Delete(cboDatatype.Items.indexof('Date Time'#9'ftDateTime'));

       if Value = ltCustomer   then TitleLabel.Caption := 'Customer Custom Field List'
  else if Value = ltsupplier   then TitleLabel.Caption := 'Supplier Custom Field List'
  else if Value = ltsaleslines then TitleLabel.Caption := 'Sales Custom Field List'
  else if Value = ltOrderLines then TitleLabel.Caption := 'Purchase Custom Field List'
  else if Value = ltEquipment  then TitleLabel.Caption := 'Equipment Custom Field List'
  else if Value = ltCAR        then TitleLabel.Caption := 'CAR - Outcome Review Options List'
  else if Value = ltRepair     then TitleLabel.Caption := 'Repair Custom Field List'
  else if Value = ltLeads      then TitleLabel.Caption := 'Marketing Leads Field List'
  else if Value = ltSupportLines then TitleLabel.Caption := 'Support Comment Field List';


end;

procedure TfmCustomfieldList.ValidateDatacallback(const Sender: TBusObj;  var Abort: Boolean);
begin
  if not CustomFieldList.ValidateData then begin
    AllLinesValid:=False;
    Abort :=True;
  end;
end;

initialization
  RegisterClassOnce(TfmCustomfieldList);

end.

