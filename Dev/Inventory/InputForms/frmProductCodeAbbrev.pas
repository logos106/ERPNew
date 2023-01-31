unit frmProductCodeAbbrev;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, StdCtrls, Buttons, DNMSpeedButton, Mask, DBCtrls, ExtCtrls,
  DNMPanel, SelectionDialog, AppEvnts, DB,  Grids, Wwdbigrd, Wwdbgrid,
  DBAccess, MyAccess,ERPdbComponents, MemDS, DataState, Menus, AdvMenus, Shader, ImgList,
  ProgressDialog;

type
  TProductCodeAbbrevGUI = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    Label2: TLabel;
    DBCheckBox1: TDBCheckBox;
    edtTitle: TDBEdit;
    cmdCancel: TDNMSpeedButton;
    cmdOK: TDNMSpeedButton;
    Label1: TLabel;
    wwDBGrid1: TwwDBGrid;
    wwDBGrid2: TwwDBGrid;
    tblMaster: TERPQuery;
    DSMaster: TDataSource;
    tblDetails: TERPQuery;
    DSDetails: TDataSource;
    tblMasterDescriptionAttribID: TAutoIncField;
    tblMasterComboName: TWideStringField;
    tblMasterActive: TWideStringField;
    tblMasterEditedFlag: TWideStringField;
    tblMasterGlobalRef: TWideStringField;
    tblDetailsDescriptionAttribLineID: TAutoIncField;
    tblDetailsDescriptionAttribID: TIntegerField;
    tblDetailsEditedFlag: TWideStringField;
    tblDetailsGlobalRef: TWideStringField;
    tblDetailsDescriptionAttribValue: TWideStringField;
    tblDetailsDescriptionAttribAbbrev: TWideStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure cmdCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure wwDBGrid2Exit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tblDetailsBeforePost(DataSet: TDataSet);
    procedure tblMasterAfterScroll(DataSet: TDataSet);
    procedure cmdOKClick(Sender: TObject);
    procedure tblDetailsPostError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
  private
    { Private declarations }
    procedure RefreshDetailsGrid;
  public
    { Public declarations }
    bSetCancelMove: boolean;
    
  end;

implementation

uses
  frmBatchPartsCreator, CommonLib;
  
{$R *.dfm}

{ TProductCodeAbbrevGUI }

procedure TProductCodeAbbrevGUI.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TProductCodeAbbrevGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  Action := caFree;
end;

procedure TProductCodeAbbrevGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    OpenQueries;
    RefreshDetailsGrid;
  finally
    EnableForm;
  end;  
end;

procedure TProductCodeAbbrevGUI.RefreshDetailsGrid;
begin
  tblDetails.Close;
  tblDetails.ParamByName('ID').AsInteger := tblMasterDescriptionAttribID.AsInteger;
  tblDetails.Open;
end;

procedure TProductCodeAbbrevGUI.wwDBGrid2Exit(Sender: TObject);
begin
  inherited;
  tblDetails.Edit;
  tblDetails.Post;
  tblDetails.Edit;

  tblMaster.Edit;
  tblMaster.Post;
  tblMaster.Edit;
end;

procedure TProductCodeAbbrevGUI.FormCreate(Sender: TObject);
begin
  fbIgnoreAccessLevels := true;
  inherited;
  // Set this to false so we can use tab features on form.
  fbTabSettingEnabled := false;

  tblMaster.Connection := MyConnection;
  tblDetails.Connection := MyConnection;
  MyConnection.Connected := true;
  if not MyConnection.intransaction then begin
    BeginTransaction;
  end;
  bSetCancelMove := false;
end;

procedure TProductCodeAbbrevGUI.tblDetailsBeforePost(DataSet: TDataSet);
begin
  inherited;
  tblDetails.Edit;
  tblDetailsDescriptionAttribID.AsInteger := tblMasterDescriptionAttribID.AsInteger;
end;

procedure TProductCodeAbbrevGUI.tblMasterAfterScroll(DataSet: TDataSet);
begin
  inherited;
  RefreshDetailsGrid;
end;

procedure TProductCodeAbbrevGUI.cmdOKClick(Sender: TObject);
begin
  inherited;
  try
    if (MyConnection.intransaction) then begin
      if DSDetails.State = dsEdit then begin
        tblDetails.Post;
      end;
       
      tblMaster.Edit;
      tblMaster.Post;
      CommitTransaction;
    end;
  except
    RollbackTransaction;
  end;

//  if Assigned(frmBatchParts) then begin
    if FormStillOpen('TfrmBatchParts') then begin
    // Here we determine which panels are active and
    // what is not.  Process all 5 panels.
    //with frmBatchParts do begin
    with TfrmBatchParts(FindExistingComponent('TfrmBatchParts')) do begin
      if qryCatagory1.Active then begin
        qryCatagory1.Close;
        qryCatagory1.Open;
      end;

      if qryCatagory2.Active then begin
        qryCatagory2.Close;
        qryCatagory2.Open;
      end;

      if qryCatagory3.Active then begin
        qryCatagory3.Close;
        qryCatagory4.Open;
      end;

      if qryCatagory4.Active then begin
        qryCatagory4.Close;
        qryCatagory4.Open;
      end;

      if qryCatagory5.Active then begin
        qryCatagory5.Close;
        qryCatagory5.Open;
      end;

      iEnabledPanels := 0;
      qrySetupID.Close;
      qrySetupID.Open;

      // Start with Catagory #1
      if qrySetupID.FieldByName('Active').AsString = 'T' then begin
        qryCatagory1.Active := true;
        lblCatagory1.Caption := qrySetupID.FieldByName('CatagoryName').AsString;
        lblCatagory1.Enabled := true;
        DNMPanel9.Enabled := true;
        Inc(iEnabledPanels);
        btnSelectAll1.Enabled := true;
      end else begin
        DNMPanel9.Enabled := false;
        lblCatagory1.Enabled := false;
        lblCatagory1.Caption := '';
        qryCatagory1.Active := false;
        btnSelectAll1.Enabled := false;
      end;
      qrySetupID.Next;

      // Now Catagory #2
      if qrySetupID.FieldByName('Active').AsString = 'T' then begin
        qryCatagory2.Active := true;
        lblCatagory2.Caption := qrySetupID.FieldByName('CatagoryName').AsString;
        lblCatagory2.Enabled := true;
        DNMPanel8.Enabled := true;
        Inc(iEnabledPanels);
        btnSelectAll2.Enabled := true;
      end else begin
        DNMPanel8.Enabled := false;
        lblCatagory2.Enabled := false;
        lblCatagory2.Caption := '';
        qryCatagory2.Active := false;
        btnSelectAll2.Enabled := false;
      end;
      qrySetupID.Next;

      // Now Catagory #3
      if qrySetupID.FieldByName('Active').AsString = 'T' then begin
        qryCatagory3.Active := true;
        lblCatagory3.Caption := qrySetupID.FieldByName('CatagoryName').AsString;
        lblCatagory3.Enabled := true;
        DNMPanel7.Enabled := true;
        Inc(iEnabledPanels);
        btnSelectAll3.Enabled := true;
      end else begin
        DNMPanel7.Enabled := false;
        lblCatagory3.Enabled := false;
        lblCatagory3.Caption := '';
        qryCatagory3.Active := false;
        btnSelectAll3.Enabled := false;
      end;
      qrySetupID.Next;

      // Now Catagory #4
      if qrySetupID.FieldByName('Active').AsString = 'T' then begin
        qryCatagory4.Active := true;
        lblCatagory4.Caption := qrySetupID.FieldByName('CatagoryName').AsString;
        lblCatagory4.Enabled := true;
        DNMPanel6.Enabled := true;
        Inc(iEnabledPanels);
        btnSelectAll4.Enabled := true;
      end else begin
        DNMPanel6.Enabled := false;
        lblCatagory4.Enabled := false;
        lblCatagory4.Caption := '';
        qryCatagory4.Active := false;
        btnSelectAll4.Enabled := false;
      end;
      qrySetupID.Next;

      // Now Catagory #5
      if qrySetupID.FieldByName('Active').AsString = 'T' then begin
        qryCatagory5.Active := true;
        lblCatagory5.Caption := qrySetupID.FieldByName('CatagoryName').AsString;
        lblCatagory5.Enabled := true;
        DNMPanel5.Enabled := true;
        Inc(iEnabledPanels);
        btnSelectAll5.Enabled := true;
      end else begin
        DNMPanel5.Enabled := false;
        lblCatagory5.Enabled := false;
        lblCatagory5.Caption := '';
        qryCatagory5.Active := false;
        btnSelectAll5.Enabled := false;
      end;
    end;
  end;
  Self.Close;
end;

procedure TProductCodeAbbrevGUI.tblDetailsPostError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
begin
  inherited;
  CommonLib.MessageDlgXP_Vista(E.Message, mtWarning, [mbOK], 0);
  Abort;
end;

initialization
  RegisterClassOnce(TProductCodeAbbrevGUI);
end.
