unit frmRewardPoint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ImgList, Menus, AdvMenus, DataState, DB,
  DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, ExtCtrls, Shader,
  wwdbdatetimepicker, StdCtrls, wwcheckbox, Mask, wwdbedit, wwdblook,
  DNMSpeedButton, DNMPanel, BusObjProductRewardPoints, BusObjBase, MemDS,
  ActnList, Grids, Wwdbigrd, Wwdbgrid, DBCtrls, ProgressDialog;

type
  TfmRewardPoint = class(TBaseInputGUI)
    pnlTop: TDNMPanel;
    pnlProductPoints: TDNMPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btnProdList: TDNMSpeedButton;
    edtValue: TwwDBEdit;
    edtPoints: TwwDBEdit;
    pnlBottom: TDNMPanel;
    Label50: TLabel;
    btnMail: TDNMSpeedButton;
    btnSave: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    qryProductPoints: TERPQuery;
    qryProductPointsProductRewardPointsId: TIntegerField;
    qryProductPointsPartsId: TIntegerField;
    qryProductPointsGlobalRef: TWideStringField;
    qryProductPointsPoints: TFloatField;
    qryProductPointsValue: TFloatField;
    qryProductPointsUseDate: TWideStringField;
    qryProductPointsDateFrom: TDateField;
    qryProductPointsDateTo: TDateField;
    qryProductPointsActive: TWideStringField;
    qryProductPointsDateCreated: TDateTimeField;
    dsProductPoints: TDataSource;
    qryProductPointsUseExpiryDate: TWideStringField;
    qryProductPointsRewardPointExpiresOn: TDateField;
    qryProductPointsmsTimeStamp: TDateTimeField;
    alMain: TActionList;
    actMainSave: TAction;
    actMainNew: TAction;
    actMainCancel: TAction;
    actProductList: TAction;
    actProduct: TAction;
    qryProductPointsPartname: TWideStringField;
    qryProductPointsUOMID: TIntegerField;
    qryProductPointsUOM: TWideStringField;
    qryUnitOfMeasure: TERPQuery;
    qryUnitOfMeasureUnitID: TIntegerField;
    qryUnitOfMeasureUnitName: TWideStringField;
    qryUnitOfMeasureUnitDescription: TWideStringField;
    qryUnitOfMeasureMultiplier: TFloatField;
    qryUnitOfMeasureBaseUnitName: TWideStringField;
    cboUnitOfMeasure: TwwDBLookupCombo;
    Label2: TLabel;
    chkUseDate: TwwCheckBox;
    lblFrom: TLabel;
    dtFrom: TwwDBDateTimePicker;
    lblTo: TLabel;
    dtTo: TwwDBDateTimePicker;
    wwDBDateTimePicker2: TwwDBDateTimePicker;
    Label6: TLabel;
    Label5: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    qryProductPointsUseUOM: TWideStringField;
    qryProductPointsUOMMultiplier: TFloatField;
    Label8: TLabel;
    wwCheckBox2: TwwCheckBox;
    Bevel3: TBevel;
    Label9: TLabel;
    Label10: TLabel;
    edtExpiresOnNoOfMonthsAfterPurchase: TwwDBEdit;
    qryProductPointsExpiresOnNoOfMonthsAfterPurchase: TIntegerField;
    wwDBLookupCombo1: TwwDBLookupCombo;
    QryParts: TERPQuery;
    QryPartsPartsId: TIntegerField;
    QryPartsPartName: TWideStringField;
    Bevel4: TBevel;
    btnGenerateBins: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    chkDiscontinued: TwwCheckBox;
    wwCheckBox1: TwwCheckBox;
    qryClientTypes: TERPQuery;
    Label7: TLabel;
    cboClientType: TwwDBLookupCombo;
    qryProductPointsClientTypeID: TLargeintField;
    procedure FormShow(Sender: TObject);
    procedure actMainSaveExecute(Sender: TObject);
    procedure actMainNewExecute(Sender: TObject);
    procedure actMainCancelExecute(Sender: TObject);
    procedure actProductListExecute(Sender: TObject);
    procedure actProductExecute(Sender: TObject);
    procedure btnMailClick(Sender: TObject);
    procedure cboPartNameDblClick(Sender: TObject);
    procedure btnGenerateBinsClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cboUnitOfMeasureCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboUnitOfMeasureEnter(Sender: TObject);
    procedure wwDBEdit1Enter(Sender: TObject);
    procedure wwCheckBox2Exit(Sender: TObject);
    procedure wwDBLookupCombo1CloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
  private
    PRP:TProductRewardPoints;
    procedure ProductGridDataSelect(Sender: TwwDbGrid);
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    { Public declarations }
  end;

implementation

uses CommonLib, frmPartsFrm, ProductListExpressForm, BusObjConst,
  FormFactory, frmMailMergeFrm, frmRewardPoints;

{$R *.dfm}
procedure TfmRewardPoint.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TProductRewardPoints then TProductRewardPoints(Sender).Dataset:= qryProductPoints;
  end;
end;

procedure TfmRewardPoint.FormShow(Sender: TObject);
begin
  inherited;
  PRP:= TProductRewardPoints.create(Self);
  PRP.connection := TMyDacDataConnection.create(PRP);
  PRP.connection.Connection := MyConnection;
  PRP.BusObjEvent := DoBusinessObjectEvent;
  PRP.Load(KeyID);
  PRP.Connection.BeginTransaction;
  if KeyId = 0 then begin
      PRP.New;
      btnProdList.Action := actProductList;
  end else begin
      btnProdList.Action := actProduct;
  end;
  openQueries;
end;

procedure TfmRewardPoint.actMainSaveExecute(Sender: TObject);
begin
  inherited;
  if not PRP.Save then Exit;
  PRP.connection.CommitTransaction;
  Notify;
  Close;
end;

procedure TfmRewardPoint.actMainNewExecute(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    if PRP.Dirty then begin
      case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
        mrYes:
          begin
            if not PRP.Save then Exit
            else begin
              PRP.connection.CommitTransaction;
              Notify;
            end;
          end;
        mrNo:
          begin
            PRP.connection.RollbackTransaction;
          end;
        mrCancel:
          begin
            Exit;
          end;
      end;
    end;
    PRP.connection.BeginTransaction;
    PRP.New;
    btnProdList.Action := actProductList;
  finally
    EnableForm;
  end;
end;

procedure TfmRewardPoint.actMainCancelExecute(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfmRewardPoint.actProductListExecute(Sender: TObject);
Var Form : TComponent;
begin
    if not FormStillOpen('TProductListExpressGUI') then begin
      Form := GetComponentByClassName('TProductListExpressGUI');
      if Assigned(Form) then begin
        with TProductListExpressGUI(Form) do begin
            OnGridDataSelect := ProductGridDataSelect;
            FormStyle        := fsMdiChild;
            BringToFront;
        end;
      end;  
    end;
end;

procedure TfmRewardPoint.actProductExecute(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfrmParts');
  if Assigned(Form) then begin
    with TfrmParts(Form) do begin
      KeyId     := qryProductPointsPartsId.AsInteger;
      FormStyle := fsMdiChild;
      BringToFront;
    end;
  end;
end;

procedure TfmRewardPoint.ProductGridDataSelect(Sender: TwwDbGrid);
begin
    PRP.PArtsId:= Sender.DataSource.DataSet.FieldByName('PartsId').AsInteger;
    PRP.Partname:= Sender.DataSource.DataSet.FieldByName('ProductName').asString;
    if qryUnitOfMeasure.Params.Parambyname('xPartID').asInteger <> PRP.PartsID then begin
        CloseDB(qryUnitOfMeasure);
        qryUnitOfMeasure.Params.Parambyname('xPartID').asInteger := PRP.PartsID;
        opendb(qryUnitOfMeasure);
    end;
end;

procedure TfmRewardPoint.btnMailClick(Sender: TObject);
Var Form : TComponent;
begin
  DisableForm;
  try
    inherited;
    Form := GetComponentByClassName('TfrmMailMerge');
    if Assigned(Form) then begin
      with TfrmMailMerge(Form) do begin
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
    Self.Close;
  finally
    EnableForm;
  end;  

end;

procedure TfmRewardPoint.cboPartNameDblClick(Sender: TObject);
begin
  inherited;
  btnProdList.Click;
end;

procedure TfmRewardPoint.btnGenerateBinsClick(Sender: TObject);
var
  Form:TComponent;
  msgOpt:word;
begin
    if qryProductPoints.State in [dsEdit,dsInsert] then begin
        msgOpt := CommonLib.MessageDlgXP_Vista('Do you wish to Save these changes?' , mtConfirmation , [mbYes, mbNo, mbCancel], 0);
             if msgOpt = mrCancel then Exit
        else if msgopt = mrno     then begin
          PRP.cancel;
          PRP.Connection.RollbackTransaction;
        end else if msgOpt = mrYes    then begin
               if not PRP.Save then Exit;
               PRP.Connection.CommitTransaction;
        end;
    end;

    PRP.Dirty := False;
    if not FormStillOpen('TfmRewardPoints') then begin
      Form := GetComponentByClassName('TfmRewardPoints');
      if Assigned(Form) then begin
        with TfmRewardPoints(Form) do begin
            FormStyle := fsMDIChild;
            BringToFront;
        end;
      end;
    end else TfmRewardPoints(FindExistingComponent('TfmRewardPoints')).show;
    Application.ProcessMessages;
    Self.Close;
end;

procedure TfmRewardPoint.FormDestroy(Sender: TObject);
begin
  Freeandnil(PRP);
  inherited;
end;

procedure TfmRewardPoint.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TfmRewardPoint.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  ExitResult: Word;
begin
  inherited;
  if PRP.Dirty then begin
    ExitResult := CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0);
    case ExitResult of
            mrYes:
              if not PRP.Save then CanClose:= false else canclose := TRue;
            mrNo:
              begin
                PRP.cancel;
                PRP.Connection.RollbackTransaction;
                canclose := TRue;
              end;
            mrCancel:
              CanClose:= false;
          end;
  end else begin
    RollbackTransaction;
    canclose := TRue;
  end;
end;

procedure TfmRewardPoint.cboUnitOfMeasureCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then Exit;
  inherited;
  PRP.UOMID := qryUnitOfMeasureUnitID.asInteger;
end;

procedure TfmRewardPoint.cboUnitOfMeasureEnter(Sender: TObject);
begin
  inherited;
  if PRP.PartsId = 0 then begin
    SetControlFocus(btnProdList);
    Exit;
  end;

end;

procedure TfmRewardPoint.wwDBEdit1Enter(Sender: TObject);
begin
  inherited;
  SetControlFocus(btnProdList);
end;

procedure TfmRewardPoint.wwCheckBox2Exit(Sender: TObject);
begin
  inherited;
  if PRP.USeUOM = False then cboUnitOfMeasure.text := '';
end;

procedure TfmRewardPoint.wwDBLookupCombo1CloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then Exit;
  inherited;
    PRP.PArtsId:= QryPartsPartsId.asInteger;
    PRP.Partname:= QryPartsPartName.asString;
    if qryUnitOfMeasure.Params.Parambyname('xPartID').asInteger <> PRP.PartsID then begin
        CloseDB(qryUnitOfMeasure);
        qryUnitOfMeasure.Params.Parambyname('xPartID').asInteger := PRP.PartsID;
        opendb(qryUnitOfMeasure);
    end;
end;

initialization
  RegisterClassOnce(TfmRewardPoint);
  with FormFact do begin
    RegisterMe(TfmRewardPoint, 'TProductRewardPointsGUI_*=ProductRewardPointsId');
    (*RegisterMe(TfmRewardPoint, 'TRemindersListGUI_*_Loyalty=ID');*)
    RegisterMe(TfmRewardPoint, 'TReminderListGUI_*_Loyalty=ID');
  end;

end.



