{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 30/01/06  1.00.01 BJ   Initial version
 29/05/06  1.00.02 BJ   changing the focus across the 2 panels should change the
                        Value of the radio buttons.
}
unit frmBinLocation;

interface

Uses TypesLib,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseInputForm, DataState, DBAccess, MyAccess,ERPdbComponents, SelectionDialog,
  AppEvnts, DB,  ExtCtrls, DNMPanel, StdCtrls, Buttons, DNMSpeedButton, wwcheckbox,
  MemDS, Mask, wwdbedit, ComCtrls,AdvOfficeStatusBar, Menus, AdvMenus, wwdblook,
  Forms, Shader, BusObjBase, BusObjProductbin, ImgList, ProgressDialog;

type
  TfmbinLocation = class(TBaseInputGUI)
    pnlHeader: TDNMPanel;
    pnlsingleBin: TDNMPanel;
    pnlFooter: TDNMPanel;
    Label4: TLabel;
    wwCheckBox1: TwwCheckBox;
    btnCompleted: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    dsBinLocations: TDataSource;
    qryBinLocations: TERPQuery;
    qryBinLocationsBinLocation: TWideStringField;
    qryBinLocationsBinNumber: TWideStringField;
    qryBinLocationsActive: TWideStringField;
    lblbinlocation: TLabel;
    lblBinnumber: TLabel;
    edtBinLocation: TwwDBEdit;
    edtBinnumber: TwwDBEdit;
    Label32: TLabel;
    chkActive: TwwCheckBox;
    qryBinLocationsGlobalRef: TWideStringField;
    qryBinLocationsBinID: TIntegerField;
    qryBinLocationsClassId: TIntegerField;
    qryBinLocationsvolume: TFloatField;
    qryBinLocationsVolume_Used: TFloatField;
    Label10: TLabel;
    Label11: TLabel;
    edtBinVolume: TwwDBEdit;
    edtbinVolume_used: TwwDBEdit;
    lblClass: TLabel;
    cboClassQry: TERPQuery;
    cboClassQryClassID: TIntegerField;
    cboClassQryClassName: TWideStringField;
    cboClass: TwwDBLookupCombo;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnGenerateBins: TDNMSpeedButton;
    btnImport: TDNMSpeedButton;
    qryBinLocationsClassName: TWideStringField;
    DNMSpeedButton1: TDNMSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure qryBinLocationsAfterInsert(DataSet: TDataSet);
    procedure btnGenerateBinsClick(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DNMSpeedButton1Click(Sender: TObject);
  private
    binDef : TProductBin;
    fiClassId :integer;
    fRefreshdet :TGeneralProc;
    fsBinLocation: String;
    fsBinnumber: String;
    fsBinlocationCaption: String;
    Function Savebins:boolean;
    procedure NewRecord;
    procedure NewBusObjinstance;
    procedure initBinUsageReport(Sender: TObject);
    procedure setBinlocationCaption(const Value: String);
  Protected
    procedure SetFormColor(Const Value :Tcolor); override;
    procedure CommitAndNotify;override;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string); override;
    procedure AftershowPopupform(frmPopup: TBaseInputGUI); Override;
  public
    Property ClassId :Integer read fiClassId write fiClassId  ;
    //Property FormColor :TColor write SetFormColor;
    Property Refreshdet  : TGeneralProc read fRefreshdet    write fRefreshdet;
    Property BinLocation : String       read fsBinLocation write fsBinLocation;
    Property BinNumber   : String       read fsBinNumber write fsBinNumber;
    Property BinlocationCaption :String read fsBinlocationCaption write setBinlocationCaption;
    Procedure MakeBinforClass(aClassID:Integer; abinLocation, aBinnumber:String);
  end;

implementation

uses FastFuncs, FormFactory,  CommonLib, AppEnvironment, frmBinLocations,
  frmImportoptionsFrm, BaseFormForm, BusObjConst, frmBinUsageReportGUI,
  CommonFormLib;

{$R *.dfm}

procedure TfmbinLocation.FormShow(Sender: TObject);
var
    strbinlocation :String;
    strbinnumber :String;
begin
  DisableForm;
  try
    inherited;
    strbinLocation := edtBinLocation.Text;
    strbinnumber := edtBinnumber.Text;
    //binDef.Dataset := qryBinLocations;
    binDef.LoadSelect('binId = ' + IntToStr(KeyID));
    if cboClassQry.Active = False then cboClassQry.Open;
    if KeyID = 0 then begin
      NewRecord;
      if strbinLocation <> '' then begin
          edtBinLocation.Text := strbinLocation;
          BinDef.BinLocation := strbinLocation;
      End else if binLocation <> '' then begin
          edtBinLocation.Text := binLocation;
          BinDef.BinLocation := binLocation;
      End;
      if strBinnumber <> '' then begin
          edtBinnumber.Text := strBinnumber;
          BinDef.Binnumber := strBinnumber;
      end else if Binnumber <> '' then begin
          edtBinnumber.Text := Binnumber;
          BinDef.Binnumber := Binnumber;
      end;
      if screen.Activecontrol <> edtBinLocation then
          SetControlFocus(edtBinLocation);
    end;
    btnGenerateBins.Visible := not ( fsModal	in Self.formstate);
    btnGenerateBins.enabled := AccessLevel<5;
  finally
    EnableForm;
  end;   
end;

procedure TfmbinLocation.btnCompletedClick(Sender: TObject);
begin
  inherited;
  ExitFocus(self);
  if Savebins then begin
    Notify(False);
    BinDef.Connection.CommitTransaction;
    BinDef.Dirty := False;
    if fsModal in FormState then begin
      {current bin's details}
      fsbinlocation :=BinDef.Binlocation;
      fsBinnumber := BinDef.Binnumber;
      Modalresult := mrOk;
    end else begin
      Self.close;
    end;
  end;
end;
procedure TfmbinLocation.CommitAndNotify;
begin
  inherited;
  CommitTransaction;
  Notify;
end;

procedure TfmbinLocation.cmdNewClick(Sender: TObject);
begin
  inherited;
  inherited;
  // If user does not have access to this form don't process any further
  DisableForm;
  try
    if BinDef.Dirty then begin
      case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
        mrYes:
          begin
            if Savebins then begin
               CommitAndNotify;  // current record should be commited before inserting new reocrd
            end else Exit;
          end;
        mrNo:
          begin
            // Cancel edits and Rollback changes
            RollbackTransaction;
          end;
        mrCancel:
          begin
            Exit;
          end;
      end;
    end;
    KeyID := 0;
    NewRecord;
  finally
    EnableForm;
  end;
end;
procedure TfmbinLocation.NewRecord;
begin
  BinDef.New;
  if ficlassId <> 0 then BinDef.ClassId := fiClassId;
end;
procedure TfmbinLocation.SetFormColor(Const Value :Tcolor);
begin
  inherited;
  TitleShader.color := Value;
end;
Function TfmbinLocation.Savebins:boolean;
begin
  Result := False;
    BinDef.ResultStatus.Clear;
    if not binDef.ValidateData  then begin
        if screen.Activecontrol <> edtBinLocation then
            SetControlFocus(edtBinLocation);
        Exit;
    end;
    if not BinDef.Save then Exit;
    KeyId := BinDef.ID;
    if Assigned(fRefreshdet) then fRefreshdet;
    Result := true;
end;

procedure TfmbinLocation.setBinlocationCaption(const Value: String);
function changeBinCaption(Const bincaption:String):String;
begin
  result := replaceStr(bincaption, 'Bin' , Value);
end;
begin
  fsBinlocationCaption    := Value;
  if Value ='' then exit;
  TitleLabel.Caption      := changeBinCaption(TitleLabel.Caption);
  Self.Caption            := changeBinCaption(self.Caption);
  lblbinlocation.Caption  := changeBinCaption(lblbinlocation.Caption);
  lblBinnumber.Caption    := changeBinCaption(lblBinnumber.Caption);
  btnGenerateBins.visible := False;
end;

procedure TfmbinLocation.AftershowPopupform(frmPopup: TBaseInputGUI);
begin
  inherited;
end;

procedure TfmbinLocation.btnCloseClick(Sender: TObject);
begin
  inherited;
  Notify(true);
  if fsModal in FormState then begin
    ModalResult := mrCancel;
  end else begin
    Self.close;
  end;
end;

procedure TfmbinLocation.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if qryBinLocations.State in [dsEdit,dsInsert] then qryBinLocations.Cancel;
  CloseQueries;
  if assigned(binDef) then Freeandnil(BinDef);
  Action := caFree;
end;

procedure TfmbinLocation.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if BinDef.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if Savebins then begin
            CommitAndNotify;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          BinDef.Dirty := false;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
          btnClose.Enabled := True;
        end;
    end;
  end else begin
    CanClose := true;
    Notify(false);
  end;
end;
procedure TfmbinLocation.NewBusObjinstance;
begin
  {$WARNINGS OFF}
    BinDef := TProductBin.Create(Self);
    BinDef.Connection := TMydacdataconnection.Create(BinDef);
    BinDef.Connection.Connection := MyConnection;
    BinDef.BusObjEvent := DoBusinessObjectEvent;
  {$WARNINGS ON}
end;

procedure TfmbinLocation.FormCreate(Sender: TObject);
begin
  inherited;
  fiClassId := 0;
  fRefreshdet := nil;
  fsBinLocation:='';
  fsBinnumber:='';
  NewBusObjinstance;
end;
procedure TfmbinLocation.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  OpenERPListFormModal('TfrmBinUsageReport', nil, initBinUsageReport);
end;
procedure TfmbinLocation.initBinUsageReport(Sender: TObject);
begin
  if sender is TfrmBinUsageReport then begin
    TfrmBinUsageReport(Sender).binId := qryBinLocationsBinID.asInteger;
    TfrmBinUsageReport(Sender).grpfilters.visible := true;
    TfrmBinUsageReport(Sender).grpfilters.itemindex := 1;
  end;
end;
procedure TfmbinLocation.MakeBinforClass(aClassID: Integer; abinLocation,aBinnumber: String);
begin
  BinDef.loadselect('ClassId =' + inttostr(aClassid)+' and BinLocation =' + quotedstr(abinLocation)+' and (BinNumber =' + quotedstr(aBinnumber)+' or ' +quotedstr(aBinnumber)+'="")');
  if BinDef.count =0 then begin
    BinDef.New;
    BinDef.ClassId := aClassId;
    BinDef.Binlocation := aBinlocation;
    BinDef.binnumber := aBinnumber;
    BinDef.PostDB;
  end;
  KeyId := BinDef.ID;
  BinDef.EditDB;
end;

procedure TfmbinLocation.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TProductBin         then TProductBin(Sender).DataSet     := qryBinLocations;
  end;

end;
procedure TfmbinLocation.qryBinLocationsAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qryBinLocationsActive.asString := 'T';
    chkActive.checked := true;
    SetControlFocus(edtBinLocation);
end;

procedure TfmbinLocation.btnGenerateBinsClick(Sender: TObject);
Var
  Form : TComponent;
  msgOpt :Integer;
begin
  if qryBinLocations.State in [dsEdit,dsInsert] then begin
    if (qryBinLocationsBinLocation.asString = '') and (qryBinLocationsBinNumber.AsString = '') then begin
        qryBinLocations.Cancel;
    end else begin
        msgOpt := CommonLib.MessageDlgXP_Vista('Do you wish to Save these changes?' , mtConfirmation , [mbYes, mbNo, mbCancel], 0);
             if msgOpt = mrCancel then Exit
        else if msgopt = mrno     then qryBinLocations.Cancel
        else if msgOpt = mrYes    then
               if not binDef.ValidateData then Exit
          else if not binDef.Save         then Exit;
    end;
  end;
  if not FormStillOpen('TfmbinLocations') then begin
    Form := GetComponentByClassName('TfmbinLocations');
    if Assigned(Form) then begin
      with TfmbinLocations(Form) do begin
          classId   := fiClassId;
          if fformcolor <> 0 then formcolor := self.formColor;
          FormStyle := fsMDIChild;
          BringToFront;
      end;
    end;
  end else TfmbinLocations(FindExistingComponent('TfmbinLocations')).show;
  Application.ProcessMessages;
  Self.Close;
end;

procedure TfmbinLocation.btnImportClick(Sender: TObject);
var
   form :TBaseInputGUI;
begin
  DisableForm;
  try
    inherited;
    if MessageDlgXP_Vista('Do you wish to close this form and open the Data Import form?' , mtconfirmation, [mbyes,mbNo], 0) = mrYEs then begin
      if not Savebins then Exit;
      form := TBaseInputGUI(GetComponentByClassName('TfrmImportoptions'));
      if not assigned(Form) then exit;
      form.FormStyle := fsMDIChild;
      form.BringToFront;
      Self.Close;
    end;
  finally
    EnableForm;
  end;
end;

initialization
  RegisterClassOnce(TfmbinLocation);
  with FormFact do
  begin
    RegisterMe(TfmbinLocation, 'TBinLocationListGUI_*=BINID');
    RegisterMe(TfmbinLocation, 'TStSRoomsGUI_*=BINID');
    RegisterControl(TfmbinLocation, '*_cbobinLocation=BinID');
    RegisterControl(TfmbinLocation, '*_cbobinNumber=BinID');
    RegisterControl(TfmbinLocation, '*_cboDefaultBin4class=BinID');
    RegisterControl(TfmbinLocation, '*_cboDefaultBin=BinID');

  end;

finalization
  UnRegisterClass(TfmbinLocation);

end.
