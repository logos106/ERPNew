unit EmployeeSkillsFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, ExtCtrls, StdCtrls, Mask, wwdbedit, Wwdotdot, Wwdbcomb,
  wwdblook, Grids, Wwdbigrd, Wwdbgrid, DNMPanel, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, frmAttachments, BusObjEmployeePay, MessageConst, BusObjBase,
  ProgressDialog, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,BaseInputForm, ERPDbLookupCombo,
  DNMSpeedButton;

type
  TfmEmployeeSkills = class(TBaseInputGUI)
    dsemployeeskills: TDataSource;
    qryskills: TERPQuery;
    qryskillsSkill: TWideStringField;
    qryskillsSkillID: TIntegerField;
    pnlMain: TDNMPanel;
    qrySkillProvider: TERPQuery;
    qryskillsGlobalRef: TWideStringField;
    qryskillsEditedFlag: TWideStringField;
    qryskillsmsTimeStamp: TDateTimeField;
    qryskillsActive: TWideStringField;
    qryskillsmsUpdateSiteCode: TWideStringField;
    QryEmployeeskillLevels: TERPQuery;
    QryEmployeeskillLevelsId: TIntegerField;
    QryEmployeeskillLevelsName: TWideStringField;
    QryEmployeeskillLevelsDescription: TWideStringField;
    QryEmployeeskillLevelsIsDefault: TWideStringField;
    QryEmployeeskillLevelsActive: TWideStringField;
    qrySkillProviderclientId: TIntegerField;
    qrySkillProvidercompany: TWideStringField;
    pnlBottom: TDNMPanel;
    Bevel3: TBevel;
    Label1: TLabel;
    grdemployeeskills: TwwDBGrid;
    cboskills: TwwDBLookupCombo;
    cbosupplier: TwwDBLookupCombo;
    cboTestMethod: TwwDBComboBox;
    cboSkilllevel: TwwDBLookupCombo;
    cboRenewalOptions: TwwDBComboBox;
    Splitter1: TSplitter;
    pnlTop: TDNMPanel;
    Label64: TLabel;
    Label66: TLabel;
    Bevel2: TBevel;
    pnlAttachments: TPanel;
    Emailbtn: TDNMSpeedButton;
    procedure pnlAttachmentsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbosupplierCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cbosupplierBeforeDropDown(Sender: TObject);
    procedure cboskillsChange(Sender: TObject);
    procedure cboskillproviderNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: string; var Accept: Boolean);
    procedure cboskillsNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: string; var Accept: Boolean);
    procedure cboskillsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure cboSkilllevelDblClick(Sender: TObject);
    procedure cboSkilllevelNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
    procedure cboSkilllevelCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure FormCreate(Sender: TObject);
    (*procedure cboskillproviderBeforeOpenList(Sender: TObject);*)
    procedure cbosupplierNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
    procedure Splitter1Moved(Sender: TObject);
    procedure pnlMainResize(Sender: TObject);
    procedure EmailbtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fSubEmpPay: Temployeepay;
    AttachmentForm: TfmAttachments;
    fsSkillsupplierNotinList:String;
    AttachmentFileList: TStringList;
    procedure SetSubEmpPay(const Value: Temployeepay);
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
    procedure beforeSupplierSkillshow(Sender: TObject);
    procedure OnselectSupplierSkill(Sender: TwwDBGrid);
    procedure AdjustSplitter;
  Protected
    procedure InitPopupform(frmPopup:TBaseInputGUI);override;
  public
    procedure AddAttachmentsForm;
    Procedure RefreshLookup;
    property SubEmpPay:Temployeepay  read fSubEmpPay write SetSubEmpPay ;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);override;
    procedure ReadSubformGuiPrefs; override;
  end;

var
  fmEmployeeSkills: TfmEmployeeSkills;

implementation

{$R *.dfm}

uses
  CommonLib, BusObjConst, BusObjEmpSkills, frmSimpleTypes, tcconst,
  SupplierSkillList, CommonFormLib, frmSupplier, tcDataUtils,
  CommonDbLib, BusObjSupplierSkills, frmEmployeeCorrespondenceCreate, tcTypes;

{ TfmEmployeeSkills }

procedure TfmEmployeeSkills.AddAttachmentsForm;
begin
  if not Assigned(SubEmpPay) then exit;
  If not Assigned(AttachmentForm) then Begin
    AttachmentForm := TfmAttachments(GetComponentByClassName('TfmAttachments',True,Self,True,True,SubEmpPay.EmployeeDetails.ID));
    TfmAttachments(AttachmentForm).DBConnection  := TERPConnection(TMyDacDataConnection(SubEmpPay.Connection).MyDacConnection );; //don't use busobj for blob fields
    TfmAttachments(AttachmentForm).AttachObserver(Self);
    TfmAttachments(AttachmentForm).TableName := 'tblemployees';
    TfmAttachments(AttachmentForm).TableId := SubEmpPay.EmployeeDetails.ID;
    TfmAttachments(AttachmentForm).Tag := SubEmpPay.EmployeeDetails.ID;
    TfmAttachments(AttachmentForm).lvAttachments.Parent := pnlAttachments;
    TfmAttachments(AttachmentForm).lvAttachments.Align := alClient;
    TfmAttachments(AttachmentForm).lvAttachments.BringToFront;
    TfmAttachments(AttachmentForm).PopulateListView;
  end;
end;

procedure TfmEmployeeSkills.cboSkilllevelCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  SubEmpPay.employeeskills.skillLevel := cboSkilllevel.lookuptable.fieldbyname('ID').asInteger ;
end;

procedure TfmEmployeeSkills.cboSkilllevelDblClick(Sender: TObject);
begin
  inherited;
  TfmSimpleTypes.DoSimpleTypesEdit(SimpleTypes_EmployeeSkillLevel, cboSkilllevel.Datasource.dataset.fieldbyname('skillLevel').asString);

end;

procedure TfmEmployeeSkills.cboSkilllevelNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('Selection NOT in list, Create New?', mtconfirmation, [mbyes, mbno], 0) = mrYes then begin
    TfmSimpleTypes.DoSimpleTypesEdit(SimpleTypes_EmployeeSkillLevel, NewValue, Self);
  end;
  Accept := False;
end;

procedure TfmEmployeeSkills.cbosupplierBeforeDropDown(Sender: TObject);
begin
  inherited;
  RefreshLookup;
end;


procedure TfmEmployeeSkills.cbosupplierCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  SubEmpPay.employeeskills.ProviderName := qrySkillProvidercompany.asString;
  SubEmpPay.employeeskills.ProviderId := qrySkillProviderclientId.asinteger;
end;
procedure TfmEmployeeSkills.OnselectSupplierSkill(Sender :TwwDBGrid);
begin
  if Sender.DataSource.DataSet.FieldByName('skillID').AsInteger  <>  SubEmpPay.employeeskills.Skillid then begin
    CommonLib.MessageDlgXP_Vista('Supplier Selected ' + Quotedstr(Sender.DataSource.DataSet.FieldByName('Company').AsString) +' doesn''t provide ' + quotedstr(SubEmpPay.employeeskills.SkillName)  , mtInformation, [mbok], 0);
    Exit;
  end;
  closedb(qrySkillProvider);
  opendb(qrySkillProvider);
  if qrySkillProvider.Locate('company' , Sender.DataSource.DataSet.FieldByName('Company').AsString , []) then begin
    SubEmpPay.employeeskills.ProviderName := qrySkillProvidercompany.asString;
    SubEmpPay.employeeskills.ProviderId := qrySkillProviderclientId.asinteger;
    SubEmpPay.employeeskills.PostDB;
  end;
end;
procedure TfmEmployeeSkills.cboskillproviderNotInList(Sender: TObject;  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
(*var
  Provider: TSkillProvider;
begin
  inherited;
  Accept:= False;
  if newValue = '' then exit;
  if cboSkills.Text <> '' then begin
    if CommonLib.MessageDlgXP_Vista('Selection NOT in list, Create New?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
      Provider := TSkillProvider.Create(nil);
      try
        Provider.Connection := TMyDacDataConnection.Create(Provider);
        Provider.Connection.Connection := TMyQuery(grdemployeeskills.DataSource.Dataset).Connection;
        Provider.Connection.BeginNestedTransaction;
        Provider.New;
        Provider.SkillProviderName := NewValue;
        Provider.PostDb;
        Provider.Skills.New;
        Provider.Skills.SkillName := cboSkills.Text;
        Provider.Skills.PostDb;
        if Provider.Save then begin
          Provider.Connection.CommitNestedTransaction;
          Accept:= true;
          LookupTable.Refresh;
          cboskillprovider.DataSource.DataSet.FieldByName(cboskillprovider.DataField).AsString := NewValue;
          LookupTable.Locate('SkillProviderName', NewValue, [loCaseInsensitive]);
        end
        else begin
          Provider.Connection.RollbackNestedTransaction;
          CommonLib.MessageDlgXP_Vista(Provider.ResultStatus.Messages, mtConfirmation, [mbOk], 0);
        end;
      finally
        Provider.Free;
      end;
    end
    else begin
      CommonLib.MessageDlgXP_Vista('Please enter a Skill first.', mtConfirmation, [mbOk], 0);
    end;
  end;*)
end;

procedure TfmEmployeeSkills.cboskillsChange(Sender: TObject);
begin
  inherited;
(*  RefreshLookup;
  if (cboSkills.Text <> '') and QrySkillProvider.IsEmpty then begin
    CommonLib.MessageDlgXP_Vista('There are currently no providers for this skill, please add one', mtInformation, [mbOk],0);
    grdemployeeskills.SelectedField := dsemployeeskills.DataSet.FieldByName('ProviderName');
  end;*)
end;

procedure TfmEmployeeSkills.cboskillsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  SubEmpPay.employeeskills.Skillid := qryskillsSkillID.asInteger;
  SubEmpPay.employeeskills.Skillname := qryskillsSkill.asString;
  RefreshLookup;
  if (cboSkills.Text <> '') and QrySkillProvider.IsEmpty then begin
    CommonLib.MessageDlgXP_Vista('There are currently no providers for this skill, please add one', mtInformation, [mbOk],0);
    grdemployeeskills.SelectedField := dsemployeeskills.DataSet.FieldByName('ProviderName');
  end;

end;

procedure TfmEmployeeSkills.cboskillsNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
var
  Skill: TSkills;
  Conn: TMyConnection;
begin
  inherited;
  Accept:= False;
  if newValue = '' then exit;
  if CommonLib.MessageDlgXP_Vista('Selection NOT in list, Create New?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    Skill:= TSkills.Create(nil);
    Conn := CommonDbLib.GetNewMyDacConnection(nil);
    try
      Skill.Connection := TMyDacDataConnection.Create(Skill);
      Skill.Connection.Connection := Conn; //TMyQuery(grdemployeeskills.DataSource.Dataset).Connection;
      Skill.Connection.BeginTransaction; //  BeginNestedTransaction;
      Skill.New;
      Skill.Skill := NewValue;
      Skill.PostDb;
      if Skill.Save then begin
        Skill.Connection.CommitTransaction; //  CommitNestedTransaction;
        Accept:= true;
        LookupTable.Refresh;
        cboskills.DataSource.DataSet.FieldByName(cboskills.DataField).AsString := NewValue;
        LookupTable.Locate('Skill', NewValue, [loCaseInsensitive]);
      end
      else begin
        Skill.Connection.RollbackTransaction; //  RollbackNestedTransaction;
        CommonLib.MessageDlgXP_Vista(Skill.ResultStatus.Messages, mtConfirmation, [mbOk], 0);
      end;
    finally
      Skill.Free;
      Conn.Free;
    end;
  end;
end;

procedure TfmEmployeeSkills.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if Value = BusobjEventVal_FailedDocumentsValidateData then begin
    // HandleEmployeeCommissionErrors; {No Need For Error Handling Yet ?? }
  end;
end;

procedure TfmEmployeeSkills.EmailbtnClick(Sender: TObject);
begin
  inherited;
  AttachmentFileList.Clear;

  if self.AttachmentForm.SaveSelectedToTempFiles(AttachmentFileList) then begin

    empCreateCorrespondence(ctEmail,nil,AttachmentFileList, SubEmpPay.EmployeeDetails.EmployeeName);
  end;

end;

procedure TfmEmployeeSkills.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Assigned(AttachmentForm) then FreeAndNil(AttachmentForm);
end;

procedure TfmEmployeeSkills.FormCreate(Sender: TObject);
begin
  AllowCustomiseGrid := true;
  AllowGridSorting := True;
  inherited;
  fsSkillsupplierNotinList:='';
  AttachmentFileList := TStringList.Create;
end;

procedure TfmEmployeeSkills.FormDestroy(Sender: TObject);
begin
  inherited;
  AttachmentFileList.Free;
end;

procedure TfmEmployeeSkills.InitPopupform(frmPopup: TBaseInputGUI);
begin
  inherited;
end;

procedure TfmEmployeeSkills.PerformStartup(var Msg: TMessage);
begin
  if QrySkillProvider.active = false then QrySkillProvider.open;
  if qryskills.active = false then qryskills.open;
  if QryEmployeeskillLevels.active = false then QryEmployeeskillLevels.open;
  RefreshLookup;
end;

procedure TfmEmployeeSkills.pnlAttachmentsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  inherited;
  Accept := True;
end;

procedure TfmEmployeeSkills.pnlMainResize(Sender: TObject);
begin
  inherited;
  AdjustSplitter;
end;

procedure TfmEmployeeSkills.ReadSubformGuiPrefs;
var
  x: Integer;
begin
  inherited;
  x := GuiPrefs.Node['Options.pnlBottomHeight'].asInteger;
  if x <> 0 then pnlBottom.Height := x;
end;

procedure TfmEmployeeSkills.RefreshLookup;
begin
  if (QrySkillProvider.parambyname('skillid').asInteger =  SubEmpPay.employeeskills.skillid) and (QrySkillProvider.active ) then exit;
  if QrySkillProvider.active then QrySkillProvider.close;
  QrySkillProvider.parambyname('skillid').asInteger := SubEmpPay.employeeskills.skillid;
  QrySkillProvider.open;
end;

procedure TfmEmployeeSkills.SetSubEmpPay(const Value: Temployeepay);
begin
  fSubEmpPay := Value;
end;

procedure TfmEmployeeSkills.Splitter1Moved(Sender: TObject);
begin
  inherited;
  AdjustSplitter;

  GuiPrefs.Node['Options.pnlBottomHeight'].asInteger := pnlBottom.Height;
end;

procedure TfmEmployeeSkills.cbosupplierNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
var
  qrySupplier: TERPQuery;
  SuppSkill: TSupplierSkill;
begin
  inherited;
  if cboSkills.Text <> '' then begin
    qrySupplier := TERPQuery.Create(nil);
    try
      qrySupplier.Connection := commonDbLib.GetSharedMyDacConnection;
      qrySupplier.SQL.Add('select * from tblClients where Supplier = "T"');
      qrySupplier.SQL.Add('and Company = ' + QuotedStr(cbosupplier.Text));
      qrySupplier.Open;
      if qrySupplier.RecordCount = 1 then begin
        { supplier exists but is not linked to this skill }
        if CommonLib.MessageDlgXP_Vista('Would you like to make this supplier a provider for this skill?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
          SuppSkill := TSupplierSkill.Create(nil);
          try
            SuppSkill.Connection := TMyDacDataConnection.Create(SuppSkill);
            SuppSkill.Connection.Connection := CommonDbLib.GetNewMyDacConnection(SuppSkill);
            SuppSkill.SilentMode := true;
            SuppSkill.Connection.BeginTransaction;
            SuppSkill.New;
            SuppSkill.SkillName := cboSkills.Text;
            SuppSkill.ProviderName := qrySupplier.FieldByName('Company').AsString;
            SuppSkill.Active := true;
            if SuppSkill.Save then begin
              SuppSkill.Connection.CommitTransaction;
              LookupTable.Refresh;
              Accept := true;
              exit;
            end
            else begin
              SuppSkill.Connection.RollbackTransaction;
              CommonLib.MessageDlgXP_Vista('Could not create Supplier/Skill link: ' + SuppSkill.ResultStatus.Messages,mtWarning,[mbOk],0);
              exit;
            end;
          finally
           SuppSkill.Free;
          end;
        end;
      end;
    finally
      qrySupplier.Free;
    end;
  end;

  fsSkillsupplierNotinList:=cbosupplier.Text;
  try
    Accept := False;
    if CommonLib.MessageDlgXP_Vista('Selection NOT in list, Do you want to see the list of suppliers for this skill?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
    OpenERPListFormSingleselectModal('TSupplierSkillListGUI' , OnselectSupplierSkill, beforeSupplierSkillshow);
  finally
    fsSkillsupplierNotinList:= '';
  end;
end;
procedure TfmEmployeeSkills.AdjustSplitter;
begin
  if (pnlTop.Height < 120) or ((pnlBottom.Height + Splitter1.Height + pnlTop.Height) > pnlMain.ClientHeight) then begin
    pnlBottom.Height := pnlMain.ClientHeight - Splitter1.Height - 120;
  end;
  if pnlBottom.Height < 120 then begin
    pnlBottom.Height := 120;
  end;

end;

procedure TfmEmployeeSkills.beforeSupplierSkillshow(Sender:TObject);
begin
  if not(Sender is TSupplierSkillListGUI) then exit;
  TSupplierSkillListGUI(Sender).showAllsuppliers := True;
  TSupplierSkillListGUI(Sender).SkillIDforlist:=   SubEmpPay.employeeskills.Skillid;
  TSupplierSkillListGUI(Sender).SupplierSearching:=fsSkillsupplierNotinList;
end;

(*procedure TfmEmployeeSkills.cboskillproviderBeforeOpenList(Sender: TObject);
begin
  inherited;
  if not (Sender is TSupplierSkillListGUI) then exit;
  TSupplierSkillListGUI(Sender).filterString := 'skillId = ' + inttostr(SubEmpPay.employeeskills.Skillid);
end;*)

initialization

RegisterClass(TfmEmployeeSkills);

end.
