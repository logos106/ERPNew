unit frmTaxScaleUSA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, AppEvnts, DB,  Buttons, DNMSpeedButton,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, Mask, wwdbedit,
  DBCtrls, ExtCtrls, DNMPanel, SelectionDialog, kbmMemTable, wwcheckbox,
  DBAccess, MyAccess,ERPdbComponents, DataState, Menus, AdvMenus, MemDS,
  BusObjTaxScales,BusObjBase,
  ImgList, ProgressDialog;

type
  TTaxScaleUSForm = class(TBaseInputGUI)
    grdScales: TwwDBGrid;
    grdScalesDelete: TwwIButton;
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
    qryTaxScalesLastUpdated: TDateField;
    qryTaxScalesScaleID: TIntegerField;
    qryTaxScalesGlobalRef: TWideStringField;
    qryTaxScalesScaleDescription: TWideStringField;
    qryTaxScalesEditedFlag: TWideStringField;
    Label4: TLabel;
    qryTaxScalesActive: TWideStringField;
    chkActive: TwwCheckBox;
    qryTaxScales: TERPQuery;
    qryTaxScalesRegionID: TIntegerField;
    qryTaxScalesMaximum: TFloatField;
    qryTaxUS: TERPQuery;
    dsTaxUS: TDataSource;
    qryTaxUSA: TFloatField;
    qryTaxUSB: TFloatField;
    qryTaxUSC: TFloatField;
    qryTaxUSD: TFloatField;
    qryTaxUSE: TFloatField;
    qryTaxUSTaxID: TIntegerField;
    qryTaxUSGlobalRef: TWideStringField;
    qryTaxUSScaleID: TIntegerField;
    qryTaxUSEditedFlag: TWideStringField;
    DBCheckBox1: TDBCheckBox;
    qryTaxScalesStandard: TWideStringField;
    procedure cmdCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdOKClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qryTaxScalesAfterInsert(DataSet: TDataSet);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure qryTaxUSAfterPost(DataSet: TDataSet);
    procedure grdScalesDeleteClick(Sender: TObject);

  private
    TaxScales: TTaxScales;
    function SaveData: Boolean;
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    { Public declarations }
    class procedure CloseMe; override;
  end;

implementation

uses FormFactory,  CommonLib, BusObjConst, BusObjTax, AppEnvironment, BusObjTax2 ;

  {$R *.dfm}

procedure TTaxScaleUSForm.FormCreate(Sender: TObject);
begin
  inherited;

  TaxScales := TTaxScales.Create(Self);
  TaxScales.Connection  := TMyDacDataConnection.Create(TaxScales);
  TMyDacDataConnection(TaxScales.Connection).MydacConnection  := Self.MyConnection;
  TaxScales.BusObjEvent := DoBusinessObjectEvent;
end;

procedure TTaxScaleUSForm.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;

  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TTaxScales  then
      TTaxScales(Sender).DataSet := qryTaxScales
    else if Sender is TTaxUS then
      TTaxUS(Sender).DataSet := qryTaxUS;
  end;
end;

procedure TTaxScaleUSForm.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.CloseMe;
end;

procedure TTaxScaleUSForm.FormShow(Sender: TObject);
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
      //TaxScales.Tax2;
      SetControlFocus(edtScale);
    end;
  finally
    EnableForm;
  end;  
end;

procedure TTaxScaleUSForm.grdScalesDeleteClick(Sender: TObject);
begin
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    qryTaxUS.Delete;
  end;
end;

procedure TTaxScaleUSForm.qryTaxUSAfterPost(DataSet: TDataSet);
begin
  inherited;
  if (qryTaxUSA.asFloat = 0) and (qryTaxUSB.asFloat = 0) and (qryTaxUSC.asFloat = 0) and (qryTaxUSD.asFloat = 0) and (qryTaxUSE.asFloat = 0) then begin
    qryTaxUS.Delete;
  end;
end;

procedure TTaxScaleUSForm.qryTaxScalesAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qryTaxScalesRegionID.asInteger := AppEnv.RegionalOptions.ID;
end;

function TTaxScaleUSForm.SaveData: Boolean;
begin
  Result:= False;

  TaxScales.PostDb;

  if TaxScales.Tax2.ScaleId = 0 then
    TaxScales.Tax2.ScaleId := qryTaxScalesScaleId.Value;

  TaxScales.Tax2.PostDb;

  if not TaxScales.Save then exit;

  Result:= True;
end;

class procedure TTaxScaleUSForm.CloseMe;
begin
  if FormStillOpen('TTaxScaleUSForm') then begin
      TTaxScaleUSForm(FindExistingComponent('TTaxScaleUSForm')).Close;
      Application.ProcessMessages;
  end;
end;

procedure TTaxScaleUSForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  notify;
  Action := caFree;
end;

procedure TTaxScaleUSForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
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

procedure TTaxScaleUSForm.cmdOKClick(Sender: TObject);
begin
  inherited;

  if not(Savedata) then exit;

  CommitTransaction;
  TaxScales.dirty := False;
  Self.Close;
end;

procedure TTaxScaleUSForm.cmdNewClick(Sender: TObject);
begin
  inherited;
  if not (Savedata) then exit;
  CommitTransaction;
  BeginTransaction;
  KeyID := 0;
  CloseQueries;
  FormShow(Sender);
end;


initialization
  RegisterClassOnce(TTaxScaleUSForm);
  FormFact.RegisterMe(TTaxScaleUSForm, 'TTaxScaleList1_*=ScaleID');
end.
