unit AwardClassificationsFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DNMPanel, BusObjAwards, wwdblook,
  StdCtrls, Mask, wwdbedit, Buttons, Wwdbigrd, Grids, Wwdbgrid, DB, MemDS,
  DBAccess, MyAccess,ERPdbComponents,DNMSpeedButton,BusObjBase, frmBase, Menus;

type
  TfrmAwardClassifications = class(TfrmBaseGUI)
    pnlAwardClassifications: TDNMPanel;
    Bevel1: TBevel;
    DSClassificationDetails: TDataSource;
    qryPayRateType: TERPQuery;
    qryAwardAdvance: TERPQuery;
    qryAwardAdvanceDescription: TWideStringField;
    qryAwardAdvanceAdvanceID: TAutoIncField;
    qryNextClassifications: TERPQuery;
    grdClassification: TwwDBGrid;
    btnClassification: TwwIButton;
    ClassificationType: TwwDBLookupCombo;
    cboAdvanceID: TwwDBLookupCombo;
    cboNextLevel: TwwDBLookupCombo;
    sbPrefs: TScrollBox;
    pnlButtons: TDNMPanel;
    MyConnection1: TERPConnection;
    procedure FormCreate(Sender: TObject);
    procedure grdClassificationRowChanged(Sender: TObject);
    procedure btnClassificationClick(Sender: TObject);

  private
    fSubAward:TAward;
    fPreventFinish: Boolean;
    fSourceForm: TForm;
    fPanelColor: TColor;
    ButtonCtr:Integer;
    function IsButtonShown(const ButtonIndex: Integer): Boolean;
    procedure AddButton(const ButtonCaption: string; const ButtonLeft: Integer);

    procedure MainButtonClick(Sender: TObject);

    function FindMainButton(const Caption: string): TDNMSpeedButton;
    procedure SetupConnections;
    procedure SetupActiveFrmBusObjs;
    procedure LoadPanels;
    procedure SetScrollBarIncrement;
    function IsPanelShown(const Panel: TDNMPanel): Boolean;
    function GetFormClassName(const ButtonCaption: string): string;
    function ValidateCurrentSubForm:boolean;
    procedure SetSubAward(Const Value :TAward);
  Protected
  public
    KeyID:integer;
    sActiveButtonCaption:string;

    procedure HandleAwardClassificationErrors;
    procedure AddMainButtons;
    procedure ShowSubForm(const ButtonName:String;const FormIndex:integer);
    procedure Initialise;
    procedure ClearScrollBox;
    procedure PostIfDirty;

    property SubAward:TAward read fSubAward write SetSubAward ;
    procedure DoAwardClassificationBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string); 
  end;


implementation

uses
  BusObjConst,CommonLib,AppEnvironment,GraphUtil,
  ClassificationAllowancesFrm,ClassificationDeductionFrm,ClassificationExtraPayratesFrm,
  MessageConst, BusobjAwardClassificationDetail, FastFuncs ;
  
procedure TfrmAwardClassifications.SetSubAward(Const Value :TAward);
begin
  fSubAward := Value;
end;
{$R *.dfm}

const
  cMainButtonWidth = 148;
  cMainButtonHeight = 28;
  cMainButtonGap = 1;
  cMainButtonLeft = 14;
  cButtontop = 3;
  cMainButtonTopStart = 5;
  cFormCount = 3;
  cMaxRange = 6000;
  cButtonCaptions: array[1..cFormCount] of string = ('Allowances',
                                                     'Deductions',
                                                     'Extra Payrates'

                                                     );

  cFormClassNames: array[1..cFormCount] of string = ('TfrmClassificationAllowances',
                                                     'TfrmClassificationDeductions',
                                                     'TfrmClassificationExtraPayRates'

                                                     );


procedure TfrmAwardClassifications.DoAwardClassificationBusinessObjectEvent(
  const Sender: TDatasetBusObj; const EventType, Value: string);
  begin
  if Eventtype = BusobjEventVal_HandleIncompleteRecord then begin
    HandleAwardClassificationErrors;
  end;
  if Eventtype = BusobjEventVal_HandleResetFocus then begin
    grdClassification.SetActiveField('Classification');
    SetControlFocus(grdClassification);
  end;

  
end;

procedure TfrmAwardClassifications.SetupActiveFrmBusObjs;
begin
  if fSourceform.ClassName = 'TfrmClassificationAllowances' then begin
    with TfrmClassificationAllowances(fSourceForm) do begin
      SubSubAward := SubAward;   
      DSAllowances2.DataSet := SubAward.AwardClassifications.ClassificationAllowances.Dataset;
      qryAllowances.Open;
      qryBasedOn.Open;
    end;
  end;

  if fSourceform.ClassName = 'TfrmClassificationDeductions' then begin
    with TfrmClassificationDeductions(fSourceForm) do begin
      SubSubAward := SubAward;
      DSClassDeductions.DataSet := SubAward.AwardClassifications.ClassificationDeductions.Dataset;
      qryDeductions.Open;
      qryBasedOn.Open;
    end;
  end;
  
  if fSourceform.ClassName = 'TfrmClassificationExtraPayRates' then begin
    with TfrmClassificationExtraPayRates(fSourceForm) do begin
      SubSubAward := SubAward;
      DSExtraRates.DataSet := SubAward.AwardClassifications.ClassificationExtraPayrates.Dataset;
      qryExtraPayrates.Open;
      qryPayRateType.Open;
    end;
  end;
end;


procedure TfrmAwardClassifications.PostIfDirty;
begin
  if not Assigned(fSourceform) then exit;
  if fSourceform.ClassName = 'TfrmClassificationAllowances' then begin
    with TfrmClassificationAllowances(fSourceForm) do begin
     if SubAward.AwardClassifications.ClassificationAllowances.Dirty then SubAward.AwardClassifications.ClassificationAllowances.PostDb;
    end;
  end;

  if fSourceform.ClassName = 'TfrmClassificationDeductions' then begin
    if SubAward.AwardClassifications.ClassificationDeductions.Dirty then SubAward.AwardClassifications.ClassificationDeductions.PostDb;
  end;

  if fSourceform.ClassName = 'TfrmClassificationExtraPayRates' then begin
    if SubAward.AwardClassifications.ClassificationExtraPayrates.Dirty then SubAward.AwardClassifications.ClassificationExtraPayrates.PostDb;
  end;
end;

procedure TfrmAwardClassifications.Initialise;
begin
  sActiveButtonCaption := 'Allowances';
  ShowSubForm('Allowances',1);
end;


function TfrmAwardClassifications.ValidateCurrentSubForm:boolean;
begin
  //VALIDATE FIELDS ON INDIVIDUAL FORMS so can force data entry before form change or Save
  Result := False;

  if not Assigned(SubAward) then exit;
  if not Assigned(fSourceform) then exit;
  if fSourceform.ClassName = 'TfrmClassificationDeductions' then begin
    with SubAward.AwardClassifications.ClassificationDeductions do begin
      with TfrmClassificationDeductions(fSourceForm) do begin
        DataSet.First;
        while not Dataset.Eof do begin
          if not ValidateData then begin
            HandleClassificationDeductErrors;
            Result := False;
            exit;
          end;
          Dataset.Next;
        end;
      end;
    end;
  end;

  if fSourceform.ClassName = 'TfrmClassificationAllowances' then begin
    with SubAward.AwardClassifications.ClassificationAllowances do begin
      with TfrmClassificationAllowances(fSourceForm) do begin
        DataSet.First;
        while not Dataset.Eof do begin
          if not ValidateData then begin
            HandleClassificationAllowErrors;
            Result := False;
            exit;
          end;  
          Dataset.Next;
        end;
      end;
    end;
  end;

  if fSourceform.ClassName = 'TfrmClassificationExtraPayRates' then begin
    with SubAward.AwardClassifications.ClassificationExtraPayrates do begin
      with TfrmClassificationExtraPayRates(fSourceForm) do begin
        DataSet.First;
        while not Dataset.Eof do begin
          if not ValidateData then begin
            HandleClassificationExtraErrors;
            Result := False;
            exit;
          end;
          Dataset.Next;
        end;
      end;
    end;
  end;

  Result := True;
end;

procedure TfrmAwardClassifications.MainButtonClick(Sender: TObject);
begin
  if Sender is TDNMSpeedButton then begin
    if SubAward.AwardClassifications.Dataset.RecordCount = 0 then begin
      CommonLib.MessageDlgXP_Vista('Classification must contain at least one record .', mtWarning, [mbOK], 0);
      grdClassification.SetActiveField('Classification');
      SetControlFocus(grdClassification);
      exit;
    end;

    if not Sysutils.SameText(sActiveButtonCaption,EnglishCaption(TDNMSpeedButton(Sender))) then begin
       if (EnglishCaption(TDNMSpeedButton(Sender)) = 'Allowances')
         or (EnglishCaption(TDNMSpeedButton(Sender)) = 'Deductions')
         or (EnglishCaption(TDNMSpeedButton(Sender)) = 'Extra Payrates') then begin

           if not SubAward.AwardClassifications.ValidateData then begin
             HandleAwardClassificationErrors;
             exit;
           end;
       end;

      PostIfDirty;
      if Assigned(fSourceForm) then if not ValidateCurrentSubForm then exit;
      sActiveButtonCaption := EnglishCaption(TDNMSpeedButton(Sender));

      ClearScrollBox;

      sbPrefs.VertScrollBar.Visible := True;
      fSourceForm := TForm(GetComponentByClassName(GetFormClassName(EnglishCaption(TDNMSpeedButton(Sender)))));

      AppEnv.RegionalOptions.ChangeForm(fSourceForm);
      SetupConnections;

      SetupActiveFrmBusObjs;

      LoadPanels;
      sbPrefs.Refresh;

      SetScrollBarIncrement;
      PostMessage(fSourceForm.Handle, TX_PerformStartup, Handle, 0);
    end;
  end;
end;

procedure TfrmAwardClassifications.ShowSubForm(const ButtonName: String; const FormIndex:integer);
begin
  if (ButtonName = 'Allowances')
    or (ButtonName = 'Deductions')
    or (ButtonName = 'Extra Payrates') then begin
      if SubAward.AwardClassifications.Dataset.RecordCount > 0 then begin   
        if SubAward.AwardClassifications.ClassificationValidationEnabled then begin
          if not SubAward.AwardClassifications.ValidateData then begin
            HandleAwardClassificationErrors;
            exit;
          end;
        end else begin
          SubAward.AwardClassifications.ClassificationValidationEnabled := True;
        end;
      end;
  end;

  ClearScrollBox;

  SetControlFocus(FindMainButton(ButtonName));

  if not fPreventFinish then begin
    sbPrefs.VertScrollBar.Visible := True;
    fSourceForm := TForm(GetComponentByClassName(cFormClassNames[FormIndex]));

    if Assigned(fSourceForm) then begin   
      AppEnv.RegionalOptions.ChangeForm(fSourceForm);
      SetupConnections;
      SetupActiveFrmBusObjs;

      LoadPanels;

      if fSourceform.ClassName = 'TfrmClassificationAllowances' then begin
        if SubAward.AwardClassifications.Dataset.RecordCount = 0 then begin //inital load with no awardclassification
          //TfrmClassificationAllowances(fSourceform).grdAllowances.Enabled := False;
        end else begin
          if TfrmClassificationAllowances(fSourceform).grdAllowances.Enabled = False then
         //   TfrmClassificationAllowances(fSourceform).grdAllowances.Enabled := True;
        end;
      end;

      sbPrefs.Refresh;

      SetScrollBarIncrement;
      SendMessage(fSourceForm.Handle, TX_PerformStartup, Handle, 0);

    end;
  end else  fPreventFinish := False;
end;


procedure TfrmAwardClassifications.SetupConnections;
var
  Index: Integer;
begin
  if Assigned(fSourceForm) then begin
    for Index := 0 to fSourceForm.ComponentCount - 1 do begin
      if fSourceForm.Components[Index] is TERPQuery then begin
        TERPQuery(fSourceForm.Components[Index]).Connection := MyConnection1;//TMyDacDataConnection(Self.Award.Connection).MydacConnection;
    //    TERPQuery(fSourceForm.Components[Index]).Open;
      end;
    end;
  end;
end;

function TfrmAwardClassifications.FindMainButton(const Caption: string): TDNMSpeedButton;
var
  Index: Integer;
  FoundButton: Boolean;
begin
  Index := 0;
  Result := nil;
  FoundButton := False;

  while (Index < ComponentCount) and (not FoundButton) do begin
    if (Components[Index] is TDNMSpeedButton) and (TDNMSpeedButton(Components[Index]).Caption = Caption) then begin
      Result := TDNMSpeedButton(Components[Index]);
      FoundButton := True;
    end
    else
      Inc(Index);
  end;
end;

procedure TfrmAwardClassifications.ClearScrollBox;
var
  Index: Integer;
begin
  if Assigned(fSourceForm) then begin
     if not fPreventFinish then begin
      for Index := sbPrefs.ControlCount - 1 downto 0 do
        sbPrefs.Controls[Index].Parent := fSourceForm;  

      fSourceForm.Release;
      fSourceForm := nil;
    end;
  end;
end;

function TfrmAwardClassifications.IsButtonShown(const ButtonIndex: Integer): Boolean;
begin
  Result := True;
end;

procedure TfrmAwardClassifications.AddButton(const ButtonCaption: string; const ButtonLeft: Integer);
var
  Button: TDNMSpeedButton;
begin
  Button := TDNMSpeedButton.Create(Self);

  with Button do begin
    Left := ButtonLeft;
    Top := cButtontop;
    Width := cMainButtonWidth - 20;
    Height := cMainButtonHeight;
    Caption := ButtonCaption;
    Parent := pnlButtons;
    Alignment := taCenter;
    Color := clWhite;
    HotTrackColor := clBtnShadow;
    SlowDecease := True;
    Style := bsModern;
    OnClick := MainButtonClick;
    inc(ButtonCtr);
    name := 'mainbutton'+inttostr(ButtonCtr);
  end;
end;

procedure TfrmAwardClassifications.AddMainButtons;
var
  ButtonLeft: Integer;
  ButtonIndex: Integer;
begin
  ButtonLeft :=cMainButtonTopStart;

  for ButtonIndex := 1 to cFormCount do begin
    if IsButtonShown(ButtonIndex) then begin
      AddButton(cButtonCaptions[ButtonIndex], ButtonLeft);
      ButtonLeft := ButtonLeft + cMainButtonWidth + cMainButtonGap;
    end;
  end;
end;

procedure TfrmAwardClassifications.HandleAwardClassificationErrors ;
var
  FatalStatusItem: TResultStatusItem;
begin
  try
    if not Assigned(SubAward) then exit;
    FatalStatusItem :=  SubAward.AwardClassifications.ResultStatus.GetLastFatalStatusItem;
    if Assigned(FatalStatusItem) then begin
      case FatalStatusItem.Code of
        BOR_AwardClassification_Err_NoDescription  : begin
                                                       grdClassification.SetActiveField('Classification');
                                                       exit;
                                                     end;
        BOR_AwardClassification_Err_NoType         : begin
                                                       grdClassification.SetActiveField('Type');
                                                       SetControlFocus(ClassificationType);
                                                       exit;
                                                     end;
        BOR_AwardClassification_Err_NoFtHourlyRate : begin
                                                       grdClassification.SetActiveField('FullTime');
                                                       exit;
                                                     end;
        BOR_AwardClassification_Err_NoPtHourlyRate : begin
                                                       grdClassification.SetActiveField('PartTime');
                                                       exit;
                                                     end;
        BOR_AwardClassification_Err_NoCHourlyRate  : begin
                                                       grdClassification.SetActiveField('Casual');
                                                       exit;
                                                     end;
        BOR_AwardClassification_Err_NoAdvanceID    : begin
                                                       grdClassification.SetActiveField('AdvanceIDName');
                                                       SetControlFocus(cboAdvanceID);
                                                       exit;
                                                     end;
      end;
    end;
  except
    on e: Exception do begin

     // Self.Close;
    end;
  end;  
end;


procedure TfrmAwardClassifications.LoadPanels;
var
  TmpPanel: TDNMPanel;
  CurrentTop: Integer;
  PanelIndex: Integer;
  PanelList: TList;
  Bitmap: TBitmap;
  BitmapName: string;

  function GetPanel(Order: Integer): TDNMPanel;
  var
    Index: Integer;
  begin
    Result := nil;
    Index := 0;

    while (Index < fSourceForm.ControlCount) and (Result = nil) do begin
      if (fSourceForm.Controls[Index] is TDNMPanel) and
         (TDNMPanel(fSourceForm.Controls[Index]).TabOrder = Order) then
        Result := TDNMPanel(fSourceForm.Controls[Index])
      else
        Inc(Index);
    end;
  end;

  procedure SetPanelProperties(const Panel: TDNMPanel);
  begin
    Panel.BevelOuter := bvNone;
    Panel.Transparent := False;
    Panel.Color := fPanelColor;
    Panel.Left := 0;
    Panel.Top := CurrentTop;
    Panel.Parent := sbPrefs;
    Panel.Align := alclient;
  end;
begin
  PanelList := TList.Create;
  Bitmap := TBitmap.Create;

  try
    if FileExists(BitmapName) then
      Bitmap.LoadFromFile(BitmapName);

    PanelIndex := 0;
    TmpPanel := GetPanel(PanelIndex);

    while Assigned(TmpPanel) do begin
      if (IsPanelShown(TmpPanel)) and (TmpPanel.Category = '') then
        PanelList.Add(TmpPanel);


      Inc(PanelIndex);
      TmpPanel := GetPanel(PanelIndex);
    end;

    PanelIndex := 0;
    CurrentTop := 0;

    while PanelIndex < PanelList.Count do begin
      TmpPanel := TDNMPanel(PanelList[PanelIndex]);
      SetPanelProperties(TmpPanel);
      CurrentTop := CurrentTop + TmpPanel.Height;
      Inc(PanelIndex);
    end;
  finally
    FreeAndNil(PanelList);
    FreeAndNil(Bitmap);
  end;
end;

procedure TfrmAwardClassifications.SetScrollBarIncrement;
begin
  if (sbPrefs.VertScrollBar.Range > 0) and (sbPrefs.VertScrollBar.Range < cMaxRange) then
    sbPrefs.VertScrollBar.Increment := cMaxRange div sbPrefs.VertScrollBar.Range
  else
    sbPrefs.VertScrollBar.Increment := 1;
end;

procedure TfrmAwardClassifications.FormCreate(Sender: TObject);
begin
  inherited;
  ButtonCtr:= 0;
  fPanelColor := pnlButtons.Color;
  Self.Color := fPanelColor;
end;

function TfrmAwardClassifications.IsPanelShown(const Panel: TDNMPanel): Boolean;
begin
  Result := True;
end;

function TfrmAwardClassifications.GetFormClassName(const ButtonCaption: string): string;
var
  Index: Integer;
begin
  Index := 1;
  Result := '';

  while (Index <= cFormCount) and (Result = '') do begin
    if cButtonCaptions[Index] = ButtonCaption then
      Result := cFormClassNames[Index]
    else
      Inc(Index);
  end;
end;

procedure TfrmAwardClassifications.grdClassificationRowChanged(
  Sender: TObject);
begin
  //if (qryNextClassifications.State in [dsInsert, dsEdit]) then begin
    if qryNextClassifications.Active then qryNextClassifications.Close;
    qryNextClassifications.params.ParamByName('xAwardID').AsInteger := SubAward.Id;
    qryNextClassifications.params.ParamByName('xClassificationID').AsInteger := SubAward.AwardClassifications.Id;
    qryNextClassifications.Open;
    if not Assigned(fSourceForm) then exit;
    if fSourceForm.ClassName = 'TfrmClassificationAllowances' then begin


//      TfrmClassificationAllowances(fSourceForm).Award3.AwardClassifications.ClassificationAllowances.RefreshDB;
//      TfrmClassificationAllowances(fSourceForm).qryclassificationallowances.Close;
//      TfrmClassificationAllowances(fSourceForm).qryclassificationallowances.params.ParamByName('xAwardID').AsInteger := SubAward.Id;
//      TfrmClassificationAllowances(fSourceForm).qryclassificationallowances.params.ParamByName('xClassificationID').AsInteger := SubAward.AwardClassifications.Id;
//      TfrmClassificationAllowances(fSourceForm).qryclassificationallowances.Open;
    end;
  //end;
end;

procedure TfrmAwardClassifications.btnClassificationClick(Sender: TObject);
begin
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      SubAward.AwardClassifications.Delete;
    finally
    end;
  end;
end;

initialization
RegisterClassOnce(TfrmAwardClassifications);


end.
