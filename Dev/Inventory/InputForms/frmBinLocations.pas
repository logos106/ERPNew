{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 30/01/06  1.00.01 BJ   Initial version
 29/05/06  1.00.02 BJ   changing the focus across the 2 panels should change the
                        Value of the radio buttons.
}
unit frmBinLocations;

interface

Uses TypesLib,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseInputForm, DataState, DBAccess, MyAccess,ERPdbComponents, SelectionDialog,
  AppEvnts, DB,  ExtCtrls, DNMPanel, StdCtrls, Buttons, DNMSpeedButton, wwcheckbox,
  MemDS, Mask, wwdbedit, ComCtrls,AdvOfficeStatusBar, Menus, AdvMenus, wwdblook,
  Forms, Shader, BusObjBase, BusObjProductbin, ImgList, ProgressDialog;

type
  TfmbinLocations = class(TBaseInputGUI)
    pnlHeader: TDNMPanel;
    pnlFooter: TDNMPanel;
    Label4: TLabel;
    wwCheckBox1: TwwCheckBox;
    btnCompleted: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    pnlGenerateBin: TDNMPanel;
    Label6: TLabel;
    Label1: TLabel;
    txtrowFrom: TEdit;
    Label7: TLabel;
    txtRowto: TEdit;
    Label5: TLabel;
    txtcolumnTo: TEdit;
    txtcolumnFrom: TEdit;
    Label8: TLabel;
    edtLocationPrefix: TEdit;
    edtVolume: TEdit;
    lblClass: TLabel;
    cboClassQry: TERPQuery;
    cboClassQryClassID: TIntegerField;
    cboClassQryClassName: TWideStringField;
    CboGroupclass: TwwDBLookupCombo;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMSpeedButton1: TDNMSpeedButton;
    qryBinLocations: TERPQuery;
    qryBinLocationsBinLocation: TWideStringField;
    qryBinLocationsBinNumber: TWideStringField;
    qryBinLocationsActive: TWideStringField;
    qryBinLocationsGlobalRef: TWideStringField;
    qryBinLocationsBinID: TIntegerField;
    qryBinLocationsClassId: TIntegerField;
    qryBinLocationsvolume: TFloatField;
    qryBinLocationsVolume_Used: TFloatField;
    dsBinLocations: TDataSource;
    Label10: TLabel;
    Bevel6: TBevel;
    Bevel1: TBevel;
    btnImport: TDNMSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure txtcolumnFromKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qryBinLocationsAfterInsert(DataSet: TDataSet);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
  private
    binDef : TProductBin;
    fiClassId :integer;
    fRefreshdet :TGeneralProc;
    Function Savebins:boolean;
    Function SavebinDefs:Boolean;
    Function GeneratefieldsBlank:Boolean;
    Procedure SetHint;
  Protected
    procedure SetFormColor(Const Value :Tcolor); override;

  public
    Property ClassId :Integer read fiClassId write fiClassId ;
    //Property FormColor :TColor write SetFormColor;
    Property Refreshdet :TGeneralProc read fRefreshdet  write fRefreshdet; 
  end;

implementation

uses FastFuncs, FormFactory,  CommonLib, AppEnvironment, frmBinLocation,
  frmImportoptionsFrm;

{$R *.dfm}

procedure TfmbinLocations.FormShow(Sender: TObject);
begin
  SetHint;
  DisableForm;
  try
    inherited;
    BinDef := TProductBin.Create(Self);
    BinDef.Connection := TMydacdataconnection.Create(BinDef);
    BinDef.Connection.Connection := MyConnection;
    binDef.Dataset := qryBinLocations;
    binDef.LoadSelect('binId = ' + IntToStr(KeyID));
    if cboClassQry.Active = False then cboClassQry.Open;
    if KeyID = 0 then begin
      BinDef.New;
      if FiClassId <> 0 then BinDef.ClassId := fiClassId;
      if ficlassId <> 0 then cboClassQry.Locate('ClassID' , ficlassId , [])
      else cboClassQry.Locate('ClassID' , appenv.defaultClass.ClassID, []);
      CboGroupclass.Text := cboClassQryClassName.asString;
    end;
  finally
    EnableForm;
  end;

end;

procedure TfmbinLocations.btnCompletedClick(Sender: TObject);
begin
  inherited;
  ExitFocus(self);
  if Savebins then Self.close;
end;

procedure TfmbinLocations.cmdNewClick(Sender: TObject);
begin
  inherited;
  if not Savebins then Exit;
  {if not binDef.ValidateData  then Exit;
  if not BinDef.Save then Exit;}
  BinDef.New;
  edtLocationPrefix.Text := '';
  txtrowFrom.Text := '';
  txtRowto.Text := '';
  txtcolumnFrom.Text := '';
  txtcolumnTo.Text := '';
  edtVolume.Text := '';
  if ficlassId <> 0 then BinDef.ClassId := fiClassId;
end;
procedure TfmbinLocations.SetFormColor(Const Value :Tcolor);
begin
  inherited;
  TitleShader.color := Value;
end;
Function TfmbinLocations.GeneratefieldsBlank:Boolean;
begin
    Result := (Trim(txtrowFrom.Text) = '') and
        (Trim(txtrowTo.Text) = '') and
        (Trim(txtcolumnTo.Text) = '') and
        (Trim(txtcolumnFrom.Text) = '') and
        (Trim(edtVolume.Text) = '') and
        (Trim(edtLocationPrefix.Text) = '');
end;
Function TfmbinLocations.SavebinDefs:Boolean;
begin
    Result                          := False;
    BinDef.LocationFrom             := Trim(txtrowFrom.Text);
    BinDef.LocationTo               := Trim(txtRowTo.Text);
    if Trim(txtcolumnFrom.Text)     =  '' then BinDef.numberFrom     := 0
        else BinDef.numberFrom      := FastFuncs.StrToInt(Trim(txtcolumnFrom.Text));
    if Trim(txtcolumnTo.Text)       =  '' then BinDef.NumberTo       := 0
        else BinDef.NumberTo        := FastFuncs.StrToInt(Trim(txtcolumnTo.Text));
    BinDef.LocationPrefix           := Trim(edtLocationPrefix.Text);
    if Trim(edtVolume.Text)         = '' then binDef.LocationVolume  := 0
        else binDef.LocationVolume  := StrToFloat(Trim(edtVolume.Text));
    bindef.LocClassId               := cboClassQryClassID.asinteger;
    if BinDef.GenerateBins          =  False then Exit;
    KeyId                           := BinDef.ID;
    Result                          := True;
    if Assigned(fRefreshdet) then fRefreshdet;
end;

Function TfmbinLocations.Savebins:boolean;
var
    msgOpt :Integer;
begin
  Result := False;
    if GeneratefieldsBlank then Exit;
    if  not isnumeric(edtVolume.Text) then begin
        CommonLib.MessageDlgXP_Vista('Volume should be a numeric value. ' , mtWarning , [mbOK] , 0);
        SetcontrolFocus(edtVolume);
        Exit;
    end;

    msgOpt := CommonLib.MessageDlgXP_Vista('Do you wish to generate Bins for these given Range?' , mtConfirmation , [mbYes, mbNo, MbCancel], 0);
    Processingcursor(True);
    try
      if msgOpt = mrCancel then Exit
      else if msgOpt = mrno then Self.close
      else SavebinDefs;
    finally
        Processingcursor(False);
    end;
  Result := true;
end;

procedure TfmbinLocations.btnCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;
procedure TfmbinLocations.txtcolumnFromKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
    if ((Key <'0') or (Key > '9')) and  (Key <> #8 ) then Key := Chr(0);
end;
procedure TfmbinLocations.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if qryBinLocations.State in [dsEdit,dsInsert] then qryBinLocations.Cancel;
  CloseQueries;
  if assigned(binDef) then Freeandnil(BinDef);
  Action := caFree;
end;

procedure TfmbinLocations.FormDestroy(Sender: TObject);
begin
  Notify;
  inherited;
end;

procedure TfmbinLocations.FormCreate(Sender: TObject);
begin
  inherited;
  fiClassId := 0;
  fRefreshdet := nil;
  fbIgnoreAccessLevels:= true;
end;

procedure TfmbinLocations.qryBinLocationsAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qryBinLocationsActive.asString := 'T';
  SetControlFocus(edtLocationPrefix);
end;

procedure TfmbinLocations.DNMSpeedButton1Click(Sender: TObject);
var
    msgOpt :Integer;
  Form : TComponent;
begin
  inherited;
  if not (GeneratefieldsBlank) then begin
    msgOpt := CommonLib.MessageDlgXP_Vista('Do you wish to generate Bins for these given Range?' , mtConfirmation , [mbYes, mbNo, MbCancel], 0);
    if msgOpt = mrCancel then begin
      Exit;
    end else if msgOpt = mrno then begin
    end else begin
        if not SavebinDefs then begin
          Exit;
        end;
    end;
  end;

  if not FormStillOpen('TfmbinLocation') then begin
    Form := GetComponentByClassName('TfmbinLocation');
    if Assigned(Form) then begin
      with TfmbinLocation(Form) do begin
        ClassId   := fiClassId;
        if formcolor <> 0 then formcolor := self.FormColor;
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  end else TfmbinLocation(FindExistingComponent('TfmbinLocation')).show;
  Application.ProcessMessages;
  Self.Close;
end;

procedure TfmbinLocations.btnImportClick(Sender: TObject);
var
   form :TBaseInputGUI;
begin
  inherited;
  if MessageDlgXP_Vista('Do you wish to close this form and open the Data Import form?' , mtconfirmation, [mbyes,mbNo], 0) = mrYEs then begin
    if not GeneratefieldsBlank then if not Savebins then Exit;
    form := TBaseInputGUI(GetComponentByClassName('TfrmImportoptions'));
    if not assigned(Form) then exit;
    form.FormStyle := fsMDIChild;
    form.BringToFront;
    Self.Close;
  end;
end;

procedure TfmbinLocations.SetHint;
begin
    edtLocationPrefix.showhint:= true;
    txtrowFrom.showhint       := true;
    txtRowto.showhint         := true;
    txtcolumnFrom.showhint    := true;
    txtcolumnTo.showhint      := true;
    edtLocationPrefix.hint    := 'This will be the name prefixing the final Bin Name';
    txtrowFrom.hint           := 'Location is defined as single character. ie. A to K';
    txtRowto.hint             := 'Location is defined as single character. ie. A to K';
    txtcolumnFrom.hint        := 'The Bin Number is defined as a numeric value. ie. 1 to 10';
    txtcolumnTo.hint          := 'The Bin Number is defined as a numeric value. ie. 1 to 10';
end;

initialization
  RegisterClassOnce(TfmbinLocations);
finalization
  UnRegisterClass(TfmbinLocations);

end.

