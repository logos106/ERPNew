unit AssessmentTypeGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB, StdCtrls,
  Mask, DBCtrls, Buttons, DNMSpeedButton, ExtCtrls, DNMPanel,
  kbmMemTable, wwdblook,
  DBAccess, MyAccess,ERPdbComponents, DataState, wwcheckbox, Menus, AdvMenus, MemDS, Grids, Wwdbigrd,
  Wwdbgrid, Shader, ImgList;

type
  TAssessmentTypeGUI = class(TBaseInputGUI)
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    lblActive: TLabel;
    chkActive: TwwCheckBox;
    tblMaster: TERPQuery;
    DSMaster: TDataSource;
    tblDetails: TERPQuery;
    DSDetails: TDataSource;
    lblName: TLabel;
    edtType: TDBEdit;
    grdData: TwwDBGrid;
    Bevel1: TBevel;
    Label1: TLabel;
    tblDetailsTypeDetailsID: TIntegerField;
    tblDetailsTypeID: TIntegerField;
    tblDetailsLabelID: TIntegerField;
    tblDetailsLabel: TWideStringField;
    tblMasterTypeID: TIntegerField;
    tblMasterTypeName: TWideStringField;
    tblMasterActive: TWideStringField;
    cboLabels: TwwDBLookupCombo;
    qrycboLabels: TERPQuery;
    qrycboLabelsLabelId: TIntegerField;
    qrycboLabelsLabel: TWideStringField;
    qrycboLabelsActive: TWideStringField;
    cboProduct: TwwDBLookupCombo;
    Label2: TLabel;
    cboProductQry: TERPQuery;
    cboProductQryManuf: TWideStringField;
    cboProductQryType: TWideStringField;
    cboProductQryDept: TWideStringField;
    cboProductQryPARTNAME: TWideStringField;
    cboProductQryPARTSID: TIntegerField;
    cboProductQryPARTTYPE: TWideStringField;
    cboProductQryPARTSDESCRIPTION: TWideStringField;
    tblMasterProductID: TIntegerField;
    grdData2: TwwDBGrid;
    cboLabels2: TwwDBLookupCombo;
    Label3: TLabel;
    qrycboLabels2: TERPQuery;
    tblDetails2: TERPQuery;
    DSDetails2: TDataSource;
    tblDetails2TypeOtherDetailsID: TLargeintField;
    tblDetails2TypeID: TIntegerField;
    tblDetails2LabelID: TIntegerField;
    tblDetails2Label: TWideStringField;
    qrycboLabels2Labelid: TIntegerField;
    qrycboLabels2Label: TWideStringField;
    qrycboLabels2Active: TWideStringField;
    grdDataIButton: TwwIButton;
    grdData2IButton: TwwIButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;    
    tblMasterDefaultTemplateID: TLargeintField;
    tblDetailsCategory: TWideStringField;
    cboInvoiceTemplate: TwwDBLookupCombo;
    Label20: TLabel;
    qryTemplates: TERPQuery;
    qrycboLabelsCategory: TWideStringField;
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure tblDetailsBeforePost(DataSet: TDataSet);
    procedure tblDetailsLabelChange(Sender: TField);
    procedure cboLabelsNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
    procedure cboProductQryAfterOpen(DataSet: TDataSet);
    procedure qrycboLabelsAfterOpen(DataSet: TDataSet);
    procedure qrycboLabels2AfterOpen(DataSet: TDataSet);
    procedure tblDetails2BeforePost(DataSet: TDataSet);
    procedure tblDetails2LabelChange(Sender: TField);
    procedure grdDataIButtonClick(Sender: TObject);
    procedure grdData2IButtonClick(Sender: TObject);
  private
    { Private declarations }
    function SaveData: Boolean;
  protected
  public
    { Public declarations }
  end;


implementation

uses
  FormFactory, DNMExceptions, CommonLib;

{$R *.dfm}

procedure TAssessmentTypeGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TAssessmentTypeGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  Action := caFree;
end;

procedure TAssessmentTypeGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;

      if tblDetails2.Active then begin
        if not (tblDetails2.State in [dsBrowse]) then tblDetails2.Post;
      end;

      if tblDetails.Active then begin
        if not (tblDetails.State in [dsBrowse]) then tblDetails.Post;
      end;

      if tblMaster.Active then begin
        if not (tblMaster.State in [dsBrowse]) then begin
          tblMaster.Post;
          Notify;
        end;
        CloseQueries;
      end;

      tblMaster.Params.ParamByName('xID').asInteger  := KeyID;
      tblDetails.Params.ParamByName('xID').asInteger := KeyID;
      tblDetails2.Params.ParamByName('xID').asInteger := KeyID;
      OpenQueries;

      BeginTransaction;

      if KeyID = 0 then begin
        tblMaster.Insert;
      end else begin
        EditNoAbort(tblMaster);
      end;

    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;
end;  

procedure TAssessmentTypeGUI.btnNewClick(Sender: TObject);
begin
  try
    inherited;
    if not SaveData then Exit;
    KeyID := 0;
    FormShow(nil);
  except
    on EAbort do HandleEAbortException;
    else raise;
  end;
end;

procedure TAssessmentTypeGUI.btnSaveClick(Sender: TObject);
begin
  inherited;
  if not SaveData then Exit;
  Close;
end;

function TAssessmentTypeGUI.SaveData: Boolean;
begin
  Result := true;
  try
    if tblDetails2.Active then begin
      if not (tblDetails2.State in [dsBrowse]) then begin
        tblDetails2.Post;
      end;
    end;
    if tblDetails.Active then begin
      if not (tblDetails.State in [dsBrowse]) then begin
        tblDetails.Post;
      end;
    end;
    if tblMaster.Active then begin
      if not (tblMaster.State in [dsBrowse]) then begin
        tblMaster.Post;
        Notify;
      end;
    end;
    CommitTransaction;
  except
    Result := false;
  end;
end;

procedure TAssessmentTypeGUI.tblDetailsBeforePost(DataSet: TDataSet);
begin
  inherited;
  if tblMasterTypeID.AsInteger = 0 then begin
    if not (tblMaster.State in [dsBrowse]) then begin
      tblMaster.Post;
    end;
    EditNoAbort(tblMaster);
  end;
  tblDetailsTypeID.AsInteger := tblMasterTypeID.AsInteger;
  tblDetailsCategory.AsString := qrycboLabelsCategory.AsString;

end;

procedure TAssessmentTypeGUI.tblDetailsLabelChange(Sender: TField);
begin
  inherited;
  if qrycboLabels.Active then if qrycboLabels.Locate('Label',
      tblDetailsLabel.AsString, [loCaseInsensitive]) then begin
      tblDetailsLabelID.AsInteger := qrycboLabelsLabelId.AsInteger;
  end;
end;

procedure TAssessmentTypeGUI.cboLabelsNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
  //  inherited;
  Accept := false;
end;

procedure TAssessmentTypeGUI.cboProductQryAfterOpen(DataSet: TDataSet);
begin
  inherited;
  cboProductQry.IndexFieldNames := 'PARTNAME ASC CIS';
end;

procedure TAssessmentTypeGUI.qrycboLabelsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qrycboLabels.IndexFieldNames := 'Label ASC CIS';
end;

procedure TAssessmentTypeGUI.qrycboLabels2AfterOpen(DataSet: TDataSet);
begin
  inherited;
  qrycboLabels2.IndexFieldNames := 'Label ASC CIS';
end;

procedure TAssessmentTypeGUI.tblDetails2BeforePost(DataSet: TDataSet);
begin
  inherited;
  if tblMasterTypeID.AsInteger = 0 then begin
    if not (tblMaster.State in [dsBrowse]) then begin
      tblMaster.Post;
    end;
    EditNoAbort(tblMaster);
  end;
  tblDetails2TypeID.AsInteger := tblMasterTypeID.AsInteger;
end;

procedure TAssessmentTypeGUI.tblDetails2LabelChange(Sender: TField);
begin
  inherited;
  if qrycboLabels2.Active then if qrycboLabels2.Locate('Label',
      tblDetails2Label.AsString, [loCaseInsensitive]) then begin
      tblDetails2LabelID.AsInteger := qrycboLabels2Labelid.AsInteger;
  end;
end;

procedure TAssessmentTypeGUI.grdDataIButtonClick(Sender: TObject);
begin
  inherited;
  tblDetails.Delete;
end;

procedure TAssessmentTypeGUI.grdData2IButtonClick(Sender: TObject);
begin
  inherited;
  tblDetails2.Delete;
end;

initialization
  RegisterClassOnce(TAssessmentTypeGUI);
  with FormFact do begin
    RegisterMe(TAssessmentTypeGUI, 'TAssessmentTypeListGUI_*=TypeID');
  end;
end.
