unit frmStSHarvest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase, ActnList, BusObjSeedToSale, wwdblook,
  wwdbdatetimepicker, Mask, wwdbedit, Grids, Wwdbigrd, Wwdbgrid,frmStSInputBase,
  ImageDLLLib, wwcheckbox, DNMAction;

type
  TfmStSHarvest = class(TfmStSInputBase)
    Actionlist: TActionList;
    QryStSHarvest: TERPQuery;
    dsStSHarvest: TDataSource;
    qryStSHarvestLines: TERPQuery;
    dsStSHarvestLines: TDataSource;
    qryStSHarvestLinesID: TIntegerField;
    qryStSHarvestLinesHarvestID: TIntegerField;
    qryStSHarvestLinesTagID: TIntegerField;
    qryStSHarvestLinesQty: TFloatField;
    qryStSHarvestLinesUOMQty: TFloatField;
    qryStSHarvestLinesStSActionID: TIntegerField;
    qryStSStrains: TERPQuery;
    qryStSStrainsStrainName: TWideStringField;
    qryStSStrainsID: TIntegerField;
    QryStSHarvestID: TIntegerField;
    QryStSHarvestDeptID: TIntegerField;
    QryStSHarvestBinID: TIntegerField;
    QryStSHarvestHarvestDate: TDateTimeField;
    QryStSHarvestStrainID: TIntegerField;
    QryStSHarvestStrainName: TWideStringField;
    QryStSHarvestUOMID: TIntegerField;
    QryStSHarvestUOM: TWideStringField;
    QryStSHarvestHarvestName: TWideStringField;
    QryStSHarvestUOMMultiplier: TFloatField;
    QryStSHarvestTotalQty: TFloatField;
    QryStSHarvestPackedQty: TFloatField;
    QryStSHarvestStSProductId: TIntegerField;
    QryStSHarvestmsTimeStamp: TDateTimeField;
    QryStSHarvestmsUpdateSiteCode: TWideStringField;
    QryClass: TERPQuery;
    QryClassClassID: TIntegerField;
    QryClassClassName: TWideStringField;
    qrybins: TERPQuery;
    qrybinsbinid: TIntegerField;
    qrybinsbindetails: TWideStringField;
    QryUOM: TERPQuery;
    QryUOMUnitID: TIntegerField;
    QryUOMUnitName: TWideStringField;
    QryUOMMultiplier: TFloatField;
    QryUOMUnitDescription: TWideStringField;
    QryUOMBaseUnitName: TWideStringField;
    QryUOMUOMDetails: TWideStringField;
    grdHarvestLines: TwwDBGrid;
    pnlHarvestsummary: TDNMPanel;
    Label3: TLabel;
    txtUOM: TDBText;
    edtTotalQty: TwwDBEdit;
    pnlHarvestHeader: TDNMPanel;
    Label4: TLabel;
    Label5: TLabel;
    wwDBLookupCombo1: TwwDBLookupCombo;
    cboUOM: TwwDBLookupCombo;
    pnlTagSelection: TDNMPanel;
    Label6: TLabel;
    Label2: TLabel;
    edtBarcode: TEdit;
    cboProductname: TwwDBEdit;
    qryStSHarvestLinesStsTag: TWideStringField;
    wwDBEdit1: TwwDBEdit;
    Label7: TLabel;
    wwCheckBox1: TwwCheckBox;
    QryStSHarvestDone: TWideStringField;
    actSerialnumbers: TDNMAction;
    Label1: TLabel;
    dtUsedOn: TwwDBDateTimePicker;
    actMakeMetrcHarvestname: TDNMAction;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QryUOMBeforeOpen(DataSet: TDataSet);
    procedure edtBarcodeKeyPress(Sender: TObject; var Key: Char);
    procedure edtBarcodeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtBarcodeExit(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure ChooseTags(Sender: TObject);
    procedure qrybinsBeforeOpen(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grdHarvestLinesCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdHarvestLinesEnter(Sender: TObject);
    procedure grdHarvestLinesRowChanged(Sender: TObject);
    procedure grdHarvestLinesColEnter(Sender: TObject);
    procedure actMakeMetrcHarvestnameUpdate(Sender: TObject);
    procedure actMakeMetrcHarvestnameExecute(Sender: TObject);
  private
    StSHarvestObj: TStSHarvest;
    ProcessingBarcode:Boolean;
    btnSerialnumbers : TERPMainSwitchButton;
    btnMakeHArvestname: TERPMainSwitchButton;
    function SaveRecord: Boolean;
    Procedure Openrec;
    procedure NewBusObjinstance;
    procedure NewRecord;
    procedure MakeQueries;
    Function ChooseTag(  aStSTag :TStSTags):Integer;Overload;
    procedure InitStSTagList(Sender: TObject);
    procedure onchoosetag(Sender: TwwDbGrid);
    procedure FocusGridandQty;
    procedure FocusGridQty;
  Protected
    procedure CommitAndNotify;override;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    procedure ChooseTag(aTag:String);Overload;
  end;


implementation

uses CommonLib, BusObjConst, AppEnvironment , StSUsedTags,
  BusObjClass, StSConst, tcConst, CommonFormLib, FormFactory, tcDataUtils;

{$R *.dfm}

Function TfmStSHarvest.SaveRecord :Boolean;
begin
  result:= False;
  StSHarvestObj.PostDB;
  if not(StSHarvestObj.Save) then exit;
  Result:= True;

end;


procedure TfmStSHarvest.CommitAndNotify;
begin
  inherited;
  CommitTransaction;
  Notify;
end;

procedure TfmStSHarvest.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
             if Sender is TStSHarvest      then TStSHarvest(Sender).Dataset     := QryStSHarvest
        else if Sender is TStSHarvestLines then TStSHarvestLines(Sender).Dataset:= qryStSHarvestLines;
     end else if (Eventtype = BusObjEvent_Change) and (Value = BusObjEvent_StSDupHarvestName) then begin
        SetcontrolFocus(edtBarcode);
     end else if (Eventtype = BusObjEvent_Change) and (Value = BusObjEvent_StSHarvestDept) then begin
        Closedb(qrybins);
        Opendb(qrybins);
     end else if (Eventtype = BusObjEvent_Change) and (Value = BusObjEvent_StsProductId) then begin
        Closedb(QryUOM);
        Opendb(QryUOM);
     end else if (Eventtype = BusObjEvent_Change) and (Value = BusObjEvent_StsStrain) then begin

     end;

end;

procedure TfmStSHarvest.edtBarcodeExit(Sender: TObject);
var
  keyChar: char;
begin
  inherited;
  if TEdit(Sender).Modified then begin
    TEdit(Sender).Modified:= false;
    keyChar:= chr(VK_RETURN);
    self.edtBarcodeKeyPress(edtBarcode, keyChar);
  end;
end;

procedure TfmStSHarvest.edtBarcodeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  edtBarcode.Modified:= true;

end;

procedure TfmStSHarvest.edtBarcodeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if not ProcessingBarcode then
    Try
      ProcessingBarcode := true;
      if (Key = Chr(VK_RETURN)) or (Key = Chr(VK_TAB)) then begin
        Key := #0;   // eat VK_RETURN
        ChooseTag(Uppercase(edtBarcode.Text));
        edtBarcode.Text := '';
      end;
    Finally
      ProcessingBarcode := False;
    end;
  if (Key = Chr(VK_RETURN)) or (Key = Chr(VK_TAB)) then
    Key := #0;
end;
procedure TfmStSHarvest.ChooseTag(aTag:String);
var
  aStSTag :TStSTags;
begin
  aTag := trim(aTag);
  if aTag = '' then exit;
  aStSTag := TStSTags.Create(Self);
  try
      aStSTag.connection :=   StSHarvestObj.connection;
      aStSTag.loadSelect('StSTag =' + quotedstr(aTag)+' and Plantcount - (ChangedCount +WastedCount+Destroycount+TransferedCount+UsedCount+HArvestcount)>0');
      if aStSTag.count =0 then
        aStSTag.loadSelect('StSTag =' + quotedstr(aTag));

      if aStSTag.count >=1 then begin
          if aStSTag.Activecount <=0 then begin
              MessageDlgXP_vista('Tag '+Quotedstr(aTag)+' is Phase Changed / Replaced / Wasted.', mtWarning, [mbOK], 0);
              SetcontrolFocus(edtBarcode);
              Exit;
          end;
          if aStSTag.StSPhase <> 'F' then begin
              MessageDlgXP_vista('Tag '+Quotedstr(aTag)+' is not in Flowring Phase.', mtWarning, [mbOK], 0);
              SetcontrolFocus(edtBarcode);
              Exit;
          end;
      end;
      ChooseTag( aStsTAg)
  finally
    FreeandNil(aStSTag);
    edtBarcode.Text := '';
  end;
//  if StSHarvestObj.Lines.
end;
Function TfmStSHarvest.ChooseTag(  aStSTag :TStSTags):Integer;
begin

      if  StSHarvestObj.Lines.Count =0 then begin
        StSHarvestObj.DeptID := aStSTag.DeptID;
        StSHarvestObj.StrainID := aStSTag.StrainId;
        StSHarvestObj.UOM := Appenv.companyprefs.StsConfig.StsDEfaultWeightUOM;
        StSHarvestObj.PostDB;
      end else begin
        if StSHarvestObj.Lines.Locate('TagID',aStSTag.ID, []) then begin
          MessageDlgXP_Vista('This Tag is Already Added', mtWarning, [mbOK], 0);
          Exit;
        end;
        if StSHarvestObj.StrainID <>aStSTag.StrainId then begin
              MessageDlgXP_vista('Tag '+Quotedstr(aStSTag.StsTag)+' is ' + quotedstr(aStSTag.Strainname)+' Strain.'+
                                  '  This Harvest is for  ' + quotedstr(StSHarvestObj.Strainname)+' Strain. Please Choose Tag of the Same Strain. ', mtWarning, [mbOK], 0);
              SetcontrolFocus(edtBarcode);
              Exit;
        end;
        if StSHarvestObj.DeptID <>aStSTag.DeptID then begin
              MessageDlgXP_vista('Tag '+Quotedstr(aStSTag.StsTag)+' is in ' + quotedstr(aStSTag.Dept)+' ' + Appenv.DEfaultclass.classheading + '. '+NL+
                                 'This Harvest is in  '+ TDeptClass.Idtoggle(StSHarvestObj.DeptID) +' ' + Appenv.DEfaultclass.classheading + '.'+NL+
                                 'Please Choose Tag in the same  ' + Appenv.DEfaultclass.classheading + '. '+NL+NL+
                                 'You Can Do  "Transfer" to Change ' + Appenv.DEfaultclass.classheading + ' of a Tag', mtWarning, [mbOK], 0);
              SetcontrolFocus(edtBarcode);
              Exit;
        end;
      end;
      aStSTag.StSTag_Actions.New;
      aStSTag.StSTag_Actions.StatusDate     := StSHarvestObj.HarvestDate;
      aStSTag.StSTag_Actions.StatusAction   := STS_ACTION_Harvesting;
      aStSTag.StSTag_Actions.ActionQty      := 0-aStSTag.ActiveCount;
      aStSTag.StSTag_Actions.StSProductID   := aStSTag.StSProductID;//StSHarvestObj.StSProductID;
      aStSTag.StSTag_Actions.StatusActionId := TStSTags.NewStsAction(STS_ACTION_Harvesting);
      aStSTag.StSTag_Actions.PostDB;

      aStSTag.Harvestcount :=aStSTag.Harvestcount + aStSTag.ActiveCount;
      aStSTag.PostDB;


      StSHarvestObj.Lines.New;
      StSHarvestObj.Lines.TagID   := aStSTag.ID;
      StSHarvestObj.Lines.StsTag  := aStSTag.StsTag;
      StSHarvestObj.Lines.UOMQty  :=1;
      StSHarvestObj.Lines.StSActionID := aStSTag.StSTag_Actions.ID;
      StSHarvestObj.Lines.PostDB;
      FocusGridandQty;
      REsult := StSHarvestObj.Lines.Id;
end;
procedure TfmStSHarvest.FocusGridandQty;
begin
  Application.processMessages;
  Setcontrolfocus(grdHarvestLines);
  FocusGridQty;
end;
procedure TfmStSHarvest.FocusGridQty;
begin
  grdHarvestLines.SetActivefield('UOMQty');
end;
procedure TfmStSHarvest.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := cafree;
end;

procedure TfmStSHarvest.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if StSHarvestObj.Dirty then begin
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
          StSHarvestObj.Dirty := false;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
        end;
    end;
  end else begin
    CanClose := true;
    Notify(false);
  end;

end;

procedure TfmStSHarvest.FormCreate(Sender: TObject);
begin
  inherited;
  btnSerialnumbers := nil;
  btnMakeHArvestname:= nil;
  FormColor := $0091C8FF; // this is to have Hervest metrc color for the form !
  NewBusObjinstance;
  edtBarcode.text := '';
  btnSerialnumbers := TERPMainSwitchButton.create(Self);
  with btnSerialnumbers do begin
    Name := MakeName(Self,'btnSerialnumbers');
    Parent := pnlTagSelection;
    width := (height+ Margins.left +Margins.right)*2;
    Align := alright;
    alignwithmargins := True;
    Margins.top := 7;
    Margins.right:= 7;
    Margins.bottom:= 7;
    //onclick := ChooseTags;
    Hint := 'Choose To Select Multiple Tags';
    Showhint := True;
    DnmAction := actSerialnumbers;
  end;
  btnMakeHArvestname := TERPMainSwitchButton.create(Self);
  with btnMakeHArvestname do begin
    Name := MakeName(Self,'btnMakeHArvestname');
    Parent := pnlHarvestsummary;
    width := 250;
    Align := alleft;
    alignwithmargins := True;
    Margins.top := 3;
    Margins.right:= 3;
    Margins.left:= 3;
    Margins.bottom:= 3;
    Font.size := 14;
    Font.Name := 'Arial';
    Hint := 'Make Harvest name Base on Metrc Nameing convenstion. ie: Strain + Date';
    Showhint := True;
    DnmAction := actMakeMetrcHarvestname;
  end;
  MakeQueries;
  ProcessingBarcode:= False;
end;
procedure TfmStSHarvest.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F9) then begin
    StSHarvestObj.PostDB;
    StSHarvestObj.Lines.PostDB;
    if (screen.activecontrol = edtBarcode) and (btnSerialnumbers<> nil)  then setcontrolfocus(btnSerialnumbers)
    else setcontrolfocus(edtBarcode);
  end;
end;

Procedure TfmStSHarvest.MakeQueries;
begin
  QryUOM.Sql.text := UOMForProductLookupSQL;
end;
procedure TfmStSHarvest.actMakeMetrcHarvestnameExecute(Sender: TObject);
begin
  inherited;
  StSHarvestObj.Harvestname := StSHarvestObj.DefaultHarvestname;//FormatDatetime('yyyy-mm-dd' , now) +'-'+ GetBinLocationnnumber(StSHarvestObj.Binid);
end;

procedure TfmStSHarvest.actMakeMetrcHarvestnameUpdate(Sender: TObject);
begin
  inherited;
  actMakeMetrcHarvestname.visible := Sametext(Appenv.companyprefs.StSconfig.StSSupplier, STS_METRC_Supplier) and (Keyid =0) and (StSHarvestObj.BinId<>0) and devmode;
end;

procedure TfmStSHarvest.btnCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;

end;

procedure TfmStSHarvest.btnCompletedClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  StSHarvestObj.Dirty := False;
  StSHarvestObj.Connection.CommitTransaction;
  Self.Close;

end;

procedure TfmStSHarvest.ChooseTags(Sender: TObject);
begin
    OpenERPListFormultiselectModal('TStSUsedTagsGUI', InitStSTagList, onchoosetag );
    FocusGridandQty;
end;
procedure TfmStSHarvest.InitStSTagList(Sender: TObject);
begin
  if sender is TStSUsedTagsGUI then begin
    TStSUsedTagsGUI(Sender).ExcludeTags := qryStSHarvestLines.groupconcat('TagID');
    TStSUsedTagsGUI(Sender).ShowFloweringTags;
  end;
end;
procedure TfmStSHarvest.onchoosetag(Sender: TwwDbGrid);
var
  i: integer;
  aStSTag :TStSTags;
  fifirstID:Integer;
  fi:Integer;
begin
  ShowProgressbar(WAITMSG, Sender.SelectedList.Count+3);
  try
    fifirstID := 0;
    try
        StepProgressbar;
        Sender.DataSource.DataSet.DisableControls;
        try
          for i := 0 to Sender.SelectedList.Count - 1 do begin
            Sender.DataSource.DataSet.GotoBookmark(Sender.SelectedList.Items[i]);
            StepProgressbar;
            aStSTag := TStSTags.create(Self);
            try
              aStSTag.connection := StSHarvestObj.Connection;
              aStSTag.Load(Sender.DataSource.DataSet.FieldByName('ID').AsInteger);
              if aStSTag.count =1 then fi:= ChooseTag(aStSTag );
              if fifirstID =0 then fifirstID := fi;
            finally
              Freeandnil(aStSTag);
            end;
          end;
        finally
          StepProgressbar;
          Sender.DataSource.DataSet.EnableControls;
        end;
    finally
        StSHarvestObj.Lines.Locate('ID' ,  fifirstID, []);
        FocusGridandQty;
        StepProgressbar;
    end;
  finally
    HideProgressbar;
  end;
end;
procedure TfmStSHarvest.FormShow(Sender: TObject);
begin
  inherited;
  OpenRec;
  Setcontrolfocus(cboProductname);
  begintransaction;
end;

procedure TfmStSHarvest.grdHarvestLinesCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if sametext(Field.fieldname ,  qryStSHarvestLinesStsTag.fieldname) then AFont.color := GridcolInactive;
end;

procedure TfmStSHarvest.grdHarvestLinesColEnter(Sender: TObject);
begin
  inherited;
  FocusGridQty;
end;

procedure TfmStSHarvest.grdHarvestLinesEnter(Sender: TObject);
begin
  inherited;
  FocusGridQty;
end;

procedure TfmStSHarvest.grdHarvestLinesRowChanged(Sender: TObject);
begin
  inherited;
  FocusGridQty;
end;

procedure TfmStSHarvest.NewBusObjinstance;
begin
  {$WARNINGS OFF}
  StSHarvestObj := TStSHarvest.CreateWithNewConn(Self);
  StSHarvestObj.Connection.connection := Self.MyConnection;
  StSHarvestObj.BusObjEvent := DoBusinessObjectEvent;
  {$WARNINGS ON}
end;

procedure TfmStSHarvest.NewRecord;
begin
    CloseQueries;
    KeyID:= 0;
    NewBusObjinstance;
    AccessLevel:= AppEnv.AccessLevels.GetEmployeeAccessLevel(Self.ClassName);
    self.BeginTransaction;
    OpenRec;
    Caption:= TitleLabel.Caption + AppEnv.AccessLevels.GetAccessLevelDescription(AccessLevel);
    //Setcontrolfocus(edtName);
end;

procedure TfmStSHarvest.Openrec;
begin
  StSHarvestObj.Load(KeyID);
  StSHarvestObj.connection.BeginTransaction;
  if StSHarvestObj.count=0 then StSHarvestObj.new;
  StSHarvestObj.Lines;
  openQueries;
  StSHarvestObj.Dirty := false;
  if accesslevel <5 then
    if (*StSHarvestObj.Harvestdone*)KeyID<>0 then begin
      accesslevel := 5;
      MessageDlgXP_Vista( 'You Cannot Change Saved Harvest Entries.  Access has been changed to read-only .', mtWarning, [mbOK], 0);
    end;
end;

procedure TfmStSHarvest.qrybinsBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qrybins.parambyname('ClassId').asInteger :=StSHarvestObj.DeptID;
end;

procedure TfmStSHarvest.QryUOMBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  QryUOM.Parambyname('xPartID').asInteger := StSHarvestObj.StsProductId;
end;

initialization
  RegisterClassOnce(TfmStSHarvest);
  with FormFact do
  begin
    RegisterMe(TfmStSHarvest, 'TStSHarvestListGUI_*=HarvestID');
  end;

end.

