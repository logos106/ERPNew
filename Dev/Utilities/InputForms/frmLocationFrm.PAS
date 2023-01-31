unit frmLocationFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, StdCtrls, Mask, DBCtrls, ExtCtrls,   BaseInputForm,
  Buttons, DNMSpeedButton, kbmMemTable, wwdbdatetimepicker, DNMPanel,
  MemDS, DBAccess, MyAccess,ERPdbComponents, Shader, Menus, AdvMenus, DataState,
  SelectionDialog, AppEvnts, ImgList, wwdblook, ProgressDialog;

type
  TfrmLocation = class(TBaseInputGUI)
    frmLocationSrc: TDataSource;
    Suburb: TDBEdit;
    lblSuburb: TLabel;
    State: TDBEdit;
    lblState: TLabel;
    Postcode: TDBEdit;
    lblPostCode: TLabel;
    CreationDate_Label: TLabel;
    qryLocations: TERPQuery;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    memQryLocations: TkbmMemTable;
    wwDBDateTimePicker1: TwwDBDateTimePicker;
    Bevel1: TBevel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    lblCountry: TLabel;
    cbocountry: twwDBLookupcombo;
    Label1: TLabel;
    Code: TDBEdit;
    qryCountry: TERPQuery;
    qryCountryCountryId: TIntegerField;
    qryCountryCountry: TWideStringField;
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure qryLocationsAfterOpen(DataSet: TDataSet);
    procedure cbocountryCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cbocountryExit(Sender: TObject);
    procedure cbocountryEnter(Sender: TObject);
  private
    fNewSuburb: string;
  Protected
  public
    procedure UpdateMe(const Cancelled: boolean; const aObject: TObject = nil); override;
  published
    property NewSuburb: string read fNewSuburb write fNewSuburb;
  end;

implementation

uses CommonDbLib, DNMLib, AuditObj, FormFactory, CommonLib, DNMExceptions,
      AppEnvironment;

{$R *.DFM}

procedure TfrmLocation.cmdCloseClick(Sender: TObject);
begin
  try
    if not Empty(Suburb.Text) then begin
      ProcessEditedFlag('Main', Self, memqryLocations, qryLocations, nil);
      qryLocations.Edit;
      qryLocations.FieldByName('RegionID').AsInteger := AppEnv.RegionalOptions.ID;
      qryLocations.Post;
      KeyID := qryLocations.FieldByName('LocationID').AsInteger;
      Notify(False);
      Self.Close;
    end else begin
      CommonLib.MessageDlgXP_Vista('City/Suburb cannot be blank.', mtWarning, [mbOK], 0);
      SetControlFocus(Suburb);
    end;
  except
    on e: Exception do begin
      Audit.AddEntry(e, Self);
      CommonLib.MessageDlgXP_Vista(e.Message + Chr(13) + 'Errors occured in ' + Self.ClassName, mtWarning, [mbOK], 0);
      Self.Close; {Don't open the form if errors occur, too risky!!}
    end;
  end;
end;

procedure TfrmLocation.cbocountryEnter(Sender: TObject);
begin
  inherited;
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
end;

procedure TfrmLocation.cbocountryExit(Sender: TObject);
begin
  inherited;
  fLastComboAccessed:= nil;
end;

procedure TfrmLocation.cmdCancelClick(Sender: TObject);
begin
  Self.Close;
end;


procedure TfrmLocation.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      if qryLocations.Active then begin
        qryLocations.Post;
        Notify;
        CloseQueries;
      end;

      qryLocations.ParamByName('LID').asInteger := KeyID;
      OpenQueries;

      if KeyID > 0 then begin
        qryLocations.Edit;
      end else begin
        qryLocations.Insert;
        qryLocations.FieldByName('CreationDate').AsDateTime := Now;
        if NewSuburb <> '' then
          qryLocations.FieldByName('City_sub').AsString := NewSuburb;
        qryLocations.FieldByName('Country').AsString:=
          Appenv.RegionalOptions.Region;

      end;
      SetControlFocus(Suburb);
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do begin
        HandleNoAccessException(e);
      end;
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmLocation.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  inherited;
end;

procedure TfrmLocation.FormCreate(Sender: TObject);
begin
  fNewSuburb:= '';
  inherited;
  qryLocations.Connection := CommonDbLib.GetSharedMyDacConnection;
end;


procedure TfrmLocation.qryLocationsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  LoadEditedFlagMemTable(qryLocations, memqryLocations);
end;

procedure TfrmLocation.UpdateMe(const Cancelled: boolean; const aObject: TObject);
begin
  inherited;
  if Cancelled then begin
    if Assigned(fLastComboAccessed) then begin
      fLastComboAccessed.Text := '';
      closenopendb(fLastComboAccessed.LookupTable);
    end;
  end
  else begin
    if assigned(fLastComboAccessed) then begin
      if Sysutils.SameText(fLastComboAccessed.Name, 'cbocountry') then begin
        closenopendb(fLastComboAccessed.LookupTable);
        if cbocountry.text<> '' then
          if not qryCountry.locate('country' ,cbocountry.text , []) then
            cbocountry.text := '';
      end;
    end;
  end;
end;

procedure TfrmLocation.cbocountryCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  qryLocations.fieldByname('countryID').asInteger :=  qryCountryCountryId.asInteger;
end;

initialization
  RegisterClassOnce(TfrmLocation);
  with FormFact do begin
    RegisterMe(TfrmLocation, 'TLocationListGUI_*=LocationID');
    RegisterControl(TfrmLocation, '*_cboBillSuburb=LocationID');
    RegisterControl(TfrmLocation, '*_BillSuburb=LocationID');
    RegisterControl(TfrmLocation, '*_Suburb=LocationID');
    RegisterControl(TfrmLocation, '*_Suburb1=LocationID');
    RegisterControl(TfrmLocation, '*_txtCity  =LocationID');
    RegisterControl(TfrmLocation, '*_cboSuburb=LocationID');
    RegisterControl(TfrmLocation, '*_cboPortOfLoading=LocationID');
    RegisterControl(TfrmLocation, '*_cboPortOfDischarge=LocationID');
    RegisterControl(TfrmLocation, '*_cboFinalDestination=LocationID');
    RegisterControl(TfrmLocation, '*_cboIncoPlace=LocationID');
  end;
end.
