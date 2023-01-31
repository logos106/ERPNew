unit TaxScale;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, AppEvnts, DB,  Buttons, DNMSpeedButton,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, Mask, wwdbedit,
  DBCtrls, ExtCtrls, DNMPanel, SelectionDialog, kbmMemTable, wwcheckbox,
  DBAccess, MyAccess,ERPdbComponents, DataState, Menus, AdvMenus, MemDS,
  BusObjTaxScales,BusObjBase,
  ImgList, ProgressDialog, Wwdotdot, Wwdbcomb;

type
  TTaxScaleForm = class(TBaseInputGUI)
    grdThreshold: TwwDBGrid;
    wwDBGrid1IButton: TwwIButton;
    cmdOK: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    ScaleDesc: TwwDBEdit;
    edtScale: TwwDBEdit;
    Label2: TLabel;
    dtpLastUpdated: TwwDBDateTimePicker;
    Label1: TLabel;
    Label3: TLabel;
    pnlTitle: TDNMPanel;
    DSTaxScales: TDataSource;
    DSTax: TDataSource;
    qryTax: TERPQuery;
    qryTaxThreshold: TFloatField;
    qryTaxA: TFloatField;
    qryTaxB: TFloatField;
    qryTaxEditedFlag: TWideStringField;
    qryTaxScalesLastUpdated: TDateField;
    qryTaxScalesScaleID: TIntegerField;
    qryTaxScalesGlobalRef: TWideStringField;
    qryTaxScalesScaleDescription: TWideStringField;
    qryTaxScalesEditedFlag: TWideStringField;
    Label4: TLabel;
    qryTaxScalesActive: TWideStringField;
    chkActive: TwwCheckBox;
    Bevel1: TBevel;
    qryTaxScales: TERPQuery;
    qryTaxScaleID: TIntegerField;
    qryTaxTaxID: TIntegerField;
    qryTaxScalesRegionID: TIntegerField;
    qryTaxScalesMaximum: TFloatField;
    Label5: TLabel;
    edtMaximum: TwwDBEdit;
    cboCategory: TwwDBComboBox;
    cboOption: TwwDBComboBox;
    cboSTSL: TwwDBComboBox;
    cboMLS: TwwDBComboBox;
    cboMLE: TwwDBComboBox;
    cboMLR: TwwDBComboBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    qryTaxScalesTT_Category: TWideStringField;
    qryTaxScalesTT_Option: TWideStringField;
    qryTaxScalesTT_STSL: TWideStringField;
    qryTaxScalesTT_MLS: TWideStringField;
    qryTaxScalesTT_MLE: TWideStringField;
    qryTaxScalesTT_MLR: TWideStringField;
    Bevel2: TBevel;
    Label6: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    procedure cmdCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdOKClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qryTaxBeforePost(DataSet: TDataSet);
    procedure qryTaxScalesAfterInsert(DataSet: TDataSet);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure qryTaxAfterPost(DataSet: TDataSet);
    procedure cboCategoryChange(Sender: TObject);
    procedure cboOptionChange(Sender: TObject);
  private
    TaxScales:TTaxScales;
    function SaveData:Boolean;
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    { Public declarations }
    class procedure CloseMe; override;
  end;

implementation

uses FormFactory,  CommonLib,BusObjConst,BusObjTax, AppEnvironment;

  {$R *.dfm}

procedure TTaxScaleForm.FormCreate(Sender: TObject);
begin
  inherited;
  TaxScales := TTaxScales.Create(Self);
  TaxScales.Connection  := TMyDacDataConnection.Create(TaxScales);
  TMyDacDataConnection(TaxScales.Connection).MydacConnection  := Self.MyConnection;
  TaxScales.BusObjEvent := DoBusinessObjectEvent;
end;

procedure TTaxScaleForm.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited ;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
             if Sender is TTaxScales  then TTaxScales(Sender).DataSet := qryTaxScales
        else if Sender is TTax        then TTax(Sender).DataSet       := qryTax;
  end;
end;

procedure TTaxScaleForm.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.CloseMe;
end;

procedure TTaxScaleForm.FormShow(Sender: TObject);
(*var
  tmpID:integer;*)
begin
  DisableForm;
  try
    inherited;
    BeginTransaction;
    chkActive.Enabled := (AccessLevel = 1);
    TaxScales.Load(KeyID);
    if KeyID <> 0 then begin
      edtScale.Enabled := false;
    end else begin
      edtScale.Enabled := true;
      TaxScales.New;
      TaxScales.Tax;
(*      TaxScales.PostDb;
      tmpID := TaxScales.ScaleID;
      TaxScales.Load(tmpID);*)
      SetControlFocus(edtScale);
    end;
  finally
    EnableForm;
  end;  
end;

procedure TTaxScaleForm.qryTaxAfterPost(DataSet: TDataSet);
begin
  inherited;
  if (qryTaxThreshold.asFloat = 0) and (qryTaxA.asFloat =0) and (qryTaxB.asFloat =0) then begin
    qryTax.Delete;
  end;

end;

procedure TTaxScaleForm.qryTaxBeforePost(DataSet: TDataSet);
begin
  inherited;
  if (qryTaxThreshold.asFloat = 0) and (qryTaxA.asFloat =0) and (qryTaxB.asFloat =0) then begin
    qryTaxThreshold.asFloat   := qryTaxThreshold.OldValue;
    qryTaxA.asFloat           := qryTaxA.OldValue;
    qryTaxB.asFloat           := qryTaxB.OldValue;
  end;
  if (qryTaxThreshold.asFloat = 0)  then begin
    qryTaxThreshold.asFloat   := qryTaxThreshold.OldValue;
  end;
end;

procedure TTaxScaleForm.qryTaxScalesAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qryTaxScalesRegionID.asInteger := AppEnv.RegionalOptions.ID;
end;

function TTaxScaleForm.SaveData: Boolean;
begin
  Result:= False;
  TaxScales.PostDb;
  if TaxScales.Tax.ScaleId = 0 then
    TaxScales.Tax.ScaleId := qryTaxScalesScaleId.Value;
  TaxScales.Tax.PostDb;
  if not TaxScales.Save then exit;
  Result:= True;
end;



class procedure TTaxScaleForm.CloseMe;
begin
  if FormStillOpen('TTaxScaleForm') then begin
      TTaxScaleForm(FindExistingComponent('TTaxScaleForm')).Close;
      Application.ProcessMessages;
  end;
end;

procedure TTaxScaleForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  notify;
  Action := caFree;
end;

procedure TTaxScaleForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if TaxScales.Dirty then begin
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
          Canclose:= False;
          Exit;
        end;
    end;
  end;

end;

procedure TTaxScaleForm.cmdOKClick(Sender: TObject);
begin
  inherited;
    if not(Savedata) then exit;
    CommitTransaction;
    TaxScales.dirty := False;
    Self.Close;
end;

procedure TTaxScaleForm.cmdNewClick(Sender: TObject);
begin
  inherited;
  if not (Savedata) then exit;
  CommitTransaction;
  BeginTransaction;
  KeyID := 0;
  CloseQueries;
  FormShow(Sender);
end;


procedure TTaxScaleForm.cboCategoryChange(Sender: TObject);
begin
   inherited;

      cboOption.Items.Clear;
      cboOption.Items.Add('(Default)' + #9 + '');

      cboSTSL.Items.Clear;
      cboSTSL.Items.Add('(Default)' + #9 + '');

      cboMLS.Items.Clear;
      cboMLS.Items.Add('(Default)' + #9 + '');

      cboMLE.Items.Clear;
      cboMLE.Items.Add('(Default)' + #9 + '');

      cboMLR.Items.Clear;
      cboMLR.Items.Add('(Default)' + #9 + '');


   if cboCategory.Text = 'Regular' then
   begin
      cboOption.Items.Add('Daily casuals' + #9 + 'D');
      cboOption.Items.Add('No tax-free threshold' + #9 + 'N');
      cboOption.Items.Add('Tax-free threshold' + #9 + 'T');
      cboOption.ApplyList;

//      cboSTSL.Items.Clear;
      cboSTSL.Items.Add('Has STSL' + #9 + 'S');
      cboSTSL.Items.Add('No STSL' + #9 + 'X');
      cboSTSL.ApplyList;

//      cboMLS.Items.Clear;
      cboMLS.Items.Add('No surcharge' + #9 + 'X');
      cboMLS.Items.Add('Tier 1' + #9 + '1');
      cboMLS.Items.Add('Tier 2' + #9 + '2');
      cboMLS.Items.Add('Tier 3' + #9 + '3');
      cboMLS.ApplyList;

//      cboMLE.Items.Clear;
      cboMLE.Items.Add('Half' + #9 + 'H');
      cboMLE.Items.Add('Full' + #9 + 'F');
      cboMLE.Items.Add('No exemption' + #9 + 'X');
      cboMLE.ApplyList;

//      cboMLR.Items.Clear;
      cboMLR.Items.Add('1 dependant' + #9 + '1');
      cboMLR.Items.Add('2 dependants' + #9 + '2');
      cboMLR.Items.Add('3 dependants' + #9 + '3');
      cboMLR.Items.Add('4 dependants' + #9 + '4');
      cboMLR.Items.Add('5 dependants' + #9 + '5');
      cboMLR.Items.Add('6 dependants' + #9 + '6');
      cboMLR.Items.Add('7 dependants' + #9 + '7');
      cboMLR.Items.Add('8 dependants' + #9 + '8');
      cboMLR.Items.Add('9 dependants' + #9 + '9');
      cboMLR.Items.Add('10 or more dependants' + #9 + 'A');
      cboMLR.Items.Add('No reduction' + #9 + 'X');
      cboMLR.Items.Add('Spouse only' + #9 + '0');
      cboMLR.ApplyList;

   end
   else if cboCategory.Text = 'Actors' then
   begin
//      cboOption.Items.Clear;
      cboOption.Items.Add('3 or less performances per week' + #9 + 'D');
      cboOption.Items.Add('No tax-free threshold' + #9 + 'N');
      cboOption.Items.Add('Promotional' + #9 + 'P');
      cboOption.Items.Add('Tax-free threshold' + #9 + 'T');
      cboOption.ApplyList;

      cboSTSL.Items.Clear;
      cboSTSL.Items.Add('No STSL' + #9 + 'X');
      cboSTSL.ApplyList;
//      cboSTSL.SetSelText('No STSL');

      cboMLS.Items.Clear;
      cboMLS.Items.Add('No surcharge' + #9 + 'X');
      cboMLS.ApplyList;

      cboMLE.Items.Clear;
      cboMLE.Items.Add('No exemption' + #9 + 'X');
      cboMLE.ApplyList;

      cboMLR.Items.Clear;
      cboMLR.Items.Add('No reduction' + #9 + 'X');
      cboMLR.ApplyList;


   end
   else if cboCategory.Text = 'Horticulturalists and Shearers' then
   begin
//      cboOption.Items.Clear;
      cboOption.Items.Add('Foreign resident' + #9 + 'F');
      cboOption.Items.Add('Tax-free threshold' + #9 + 'T');
      cboOption.ApplyList;

      cboSTSL.Items.Clear;
      cboSTSL.Items.Add('No STSL' + #9 + 'X');
      cboSTSL.ApplyList;

      cboMLS.Items.Clear;
      cboMLS.Items.Add('No surcharge' + #9 + 'X');
      cboMLS.ApplyList;

      cboMLE.Items.Clear;
      cboMLE.Items.Add('No exemption' + #9 + 'X');
      cboMLE.ApplyList;

      cboMLR.Items.Clear;
      cboMLR.Items.Add('No reduction' + #9 + 'X');
      cboMLR.ApplyList;


   end
   else if cboCategory.Text = 'Seniors and Pensioners' then
   begin
//      cboOption.Items.Clear;
      cboOption.Items.Add('Illness separated' + #9 + 'I');
      cboOption.Items.Add('Member of a couple' + #9 + 'M');
      cboOption.Items.Add('Single' + #9 + 'S');
      cboOption.ApplyList;

//      cboSTSL.Items.Clear;
      cboSTSL.Items.Add('Has STSL' + #9 + 'S');
      cboSTSL.Items.Add('No STSL' + #9 + 'X');
      cboSTSL.ApplyList;

//      cboMLS.Items.Clear;
      cboMLS.Items.Add('No surcharge' + #9 + 'X');
      cboMLS.Items.Add('Tier 1' + #9 + '1');
      cboMLS.Items.Add('Tier 2' + #9 + '2');
      cboMLS.Items.Add('Tier 3' + #9 + '3');
      cboMLS.ApplyList;

//      cboMLE.Items.Clear;
      cboMLE.Items.Add('Half' + #9 + 'H');
      cboMLE.Items.Add('Full' + #9 + 'F');
      cboMLE.Items.Add('No exemption' + #9 + 'X');
      cboMLE.ApplyList;

//      cboMLR.Items.Clear;
      cboMLR.Items.Add('1 dependant' + #9 + '1');
      cboMLR.Items.Add('2 dependants' + #9 + '2');
      cboMLR.Items.Add('3 dependants' + #9 + '3');
      cboMLR.Items.Add('4 dependants' + #9 + '4');
      cboMLR.Items.Add('5 dependants' + #9 + '5');
      cboMLR.Items.Add('6 dependants' + #9 + '6');
      cboMLR.Items.Add('7 dependants' + #9 + '7');
      cboMLR.Items.Add('8 dependants' + #9 + '8');
      cboMLR.Items.Add('9 dependants' + #9 + '9');
      cboMLR.Items.Add('10 or more dependants' + #9 + 'A');
      cboMLR.Items.Add('No reduction' + #9 + 'X');
      cboMLR.Items.Add('Spouse only' + #9 + '0');
      cboMLR.ApplyList;


   end
   else if cboCategory.Text = 'Working Holiday Makers' then
   begin
//      cboOption.Items.Clear;
      cboOption.Items.Add('No TFN - foreign resident' + #9 + 'F');
      cboOption.Items.Add('Registered employer' + #9 + 'R');
      cboOption.Items.Add('Unregistered employer' + #9 + 'U');
      cboOption.ApplyList;

      cboSTSL.Items.Clear;
      cboSTSL.Items.Add('No STSL' + #9 + 'X');
      cboSTSL.ApplyList;

      cboMLS.Items.Clear;
      cboMLS.Items.Add('No surcharge' + #9 + 'X');
      cboMLS.ApplyList;

      cboMLE.Items.Clear;
      cboMLE.Items.Add('No exemption' + #9 + 'X');
      cboMLE.ApplyList;

      cboMLR.Items.Clear;
      cboMLR.Items.Add('No reduction' + #9 + 'X');
      cboMLR.ApplyList;


   end
   else if cboCategory.Text = 'Seasonal Worker Programme' then
   begin
      cboOption.Items.Clear;
      cboOption.Items.Add('Seasonal Worker Programme' + #9 + 'P');
      cboOption.ApplyList;

      cboSTSL.Items.Clear;
      cboSTSL.Items.Add('No STSL' + #9 + 'X');
      cboSTSL.ApplyList;

      cboMLS.Items.Clear;
      cboMLS.Items.Add('No surcharge' + #9 + 'X');
      cboMLS.ApplyList;

      cboMLE.Items.Clear;
      cboMLE.Items.Add('No exemption' + #9 + 'X');
      cboMLE.ApplyList;

      cboMLR.Items.Clear;
      cboMLR.Items.Add('No reduction' + #9 + 'X');
      cboMLR.ApplyList;


   end
   else if cboCategory.Text = 'Foreign Resident' then
   begin
      cboOption.Items.Clear;
      cboOption.Items.Add('Foreign resident' + #9 + 'F');
      cboOption.ApplyList;

//      cboSTSL.Items.Clear;
      cboSTSL.Items.Add('Has STSL' + #9 + 'S');
      cboSTSL.Items.Add('No STSL' + #9 + 'X');
      cboSTSL.ApplyList;

      cboMLS.Items.Clear;
      cboMLS.Items.Add('No surcharge' + #9 + 'X');
      cboMLS.ApplyList;

      cboMLE.Items.Clear;
      cboMLE.Items.Add('No exemption' + #9 + 'X');
      cboMLE.ApplyList;

      cboMLR.Items.Clear;
      cboMLR.Items.Add('No reduction' + #9 + 'X');
      cboMLR.ApplyList;


   end
   else if cboCategory.Text = 'No TFN' then
   begin
//      cboOption.Items.Clear;
      cboOption.Items.Add('Australian resident' + #9 + 'A');
      cboOption.Items.Add('Foreign resident' + #9 + 'F');
      cboOption.ApplyList;

      cboSTSL.Items.Clear;
      cboSTSL.Items.Add('No STSL' + #9 + 'X');
      cboSTSL.ApplyList;

      cboMLS.Items.Clear;
      cboMLS.Items.Add('No surcharge' + #9 + 'X');
      cboMLS.ApplyList;

      cboMLE.Items.Clear;
      cboMLE.Items.Add('No exemption' + #9 + 'X');
      cboMLE.ApplyList;

      cboMLR.Items.Clear;
      cboMLR.Items.Add('No reduction' + #9 + 'X');
      cboMLR.ApplyList;


   end
   else if cboCategory.Text = 'ATO-Defined' then
   begin
//      cboOption.Items.Clear;
      cboOption.Items.Add('Death beneficiaries' + #9 + 'B');
      cboOption.Items.Add('Downwards variation' + #9 + 'V');
      cboOption.Items.Add('Non-employee' + #9 + 'Z');
      cboOption.ApplyList;

      cboSTSL.Items.Clear;
      cboSTSL.Items.Add('No STSL' + #9 + 'X');
      cboSTSL.ApplyList;

      cboMLS.Items.Clear;
      cboMLS.Items.Add('No surcharge' + #9 + 'X');
      cboMLS.ApplyList;

      cboMLE.Items.Clear;
      cboMLE.Items.Add('No exemption' + #9 + 'X');
      cboMLE.ApplyList;

      cboMLR.Items.Clear;
      cboMLR.Items.Add('No reduction' + #9 + 'X');
      cboMLR.ApplyList;


   end
   else if cboCategory.Text = 'Voluntary Agreement' then
   begin
//      cboOption.Items.Clear;
      cboOption.Items.Add('Commissioner’s instalment Rate' + #9 + 'C');
      cboOption.Items.Add('No Commissioner’s Instalment Rate' + #9 + 'O');
      cboOption.ApplyList;

      cboSTSL.Items.Clear;
      cboSTSL.Items.Add('No STSL' + #9 + 'X');
      cboSTSL.ApplyList;

      cboMLS.Items.Clear;
      cboMLS.Items.Add('No surcharge' + #9 + 'X');
      cboMLS.ApplyList;

      cboMLE.Items.Clear;
      cboMLE.Items.Add('No exemption' + #9 + 'X');
      cboMLE.ApplyList;

      cboMLR.Items.Clear;
      cboMLR.Items.Add('No reduction' + #9 + 'X');
      cboMLR.ApplyList;

   end;

//   cboOption.ItemIndex := 0;
//   cboSTSL.ItemIndex := 0;
//   cboMLS.ItemIndex := 0;
//   cboMLE.ItemIndex := 0;
//   cboMLR.ItemIndex := 0;


end;


procedure TTaxScaleForm.cboOptionChange(Sender: TObject);
begin
  inherited;

   if cboOption.Text = 'Daily casuals' then
   begin

      cboSTSL.Items.Clear;
      cboSTSL.Items.Add('No STSL' + #9 + 'X');
      cboSTSL.ApplyList;

      cboMLS.Items.Clear;
      cboMLS.Items.Add('No surcharge' + #9 + 'X');
      cboMLS.ApplyList;

      cboMLE.Items.Clear;
      cboMLE.Items.Add('No exemption' + #9 + 'X');
      cboMLE.ApplyList;

      cboMLR.Items.Clear;
      cboMLR.Items.Add('No reduction' + #9 + 'X');
      cboMLR.ApplyList;

   end;

//   cboSTSL.ItemIndex := 0;
//   cboMLS.ItemIndex := 0;
//   cboMLE.ItemIndex := 0;
//   cboMLR.ItemIndex := 0;

end;




initialization
  RegisterClassOnce(TTaxScaleForm);
  FormFact.RegisterMe(TTaxScaleForm, 'TTaxScaleList_*=ScaleID');
end.
