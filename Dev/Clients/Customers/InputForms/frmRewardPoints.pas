unit frmRewardPoints;
{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 17/09/09  1.00.01 BJ  initial version 
}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Shader, wwdbdatetimepicker, StdCtrls, wwcheckbox,
  Mask, wwdbedit, DNMSpeedButton, ExtCtrls, DNMPanel, ImgList, Menus,
  AdvMenus, DataState, DB, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts,
  MemDS, Grids, Wwdbigrd, Wwdbgrid, ActnList, BusObjBase, DBCtrls, wwdblook,
  Buttons, ProgressDialog;

type
  TfmRewardPoints = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    pnlProductPoints: TDNMPanel;
    DNMPanel3: TDNMPanel;
    Label7: TLabel;
    Label8: TLabel;
    edtPoints: TwwDBEdit;
    wwDBEdit2: TwwDBEdit;
    pnlTop: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryParts: TERPQuery;
    qryPartsPArtname: TWideStringField;
    dsParts: TDataSource;
    t: TwwDBGrid;
    alMain: TActionList;
    actMainSave: TAction;
    actProductList: TAction;
    dsProductPointsGUI: TDataSource;
    qryProductPoints: TERPQuery;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    StringField1: TWideStringField;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    StringField2: TWideStringField;
    DateField1: TDateField;
    DateField2: TDateField;
    StringField3: TWideStringField;
    DateTimeField1: TDateTimeField;
    StringField5: TWideStringField;
    DateField3: TDateField;
    DateTimeField2: TDateTimeField;
    DataSource1: TDataSource;
    qryProductPointsPartname: TWideStringField;
    qryProductPointsUOMID: TIntegerField;
    qryProductPointsUOM: TWideStringField;
    qryProductPointsUseUOM: TWideStringField;
    qryProductPointsUOMMultiplier: TFloatField;

    qryProductPointsGUI: TERPQuery;
    qryProductPointsGUIProductRewardPointsId: TIntegerField;
    qryProductPointsGUIPartsId: TIntegerField;
    qryProductPointsGUIGlobalRef: TWideStringField;
    qryProductPointsGUIPoints: TFloatField;
    qryProductPointsGUIValue: TFloatField;
    qryProductPointsGUIUseDate: TWideStringField;
    qryProductPointsGUIDateFrom: TDateField;
    qryProductPointsGUIDateTo: TDateField;
    qryProductPointsGUIActive: TWideStringField;
    qryProductPointsGUIDateCreated: TDateTimeField;
    qryProductPointsGUIUseExpiryDate: TWideStringField;
    qryProductPointsGUIExpiresOnNoOfMonthsAfterPurchase: TIntegerField;
    qryProductPointsGUIRewardPointExpiresOn: TDateField;
    qryProductPointsGUImsTimeStamp: TDateTimeField;
    qryProductPointsGUIPartname: TWideStringField;
    qryProductPointsGUIUOMID: TIntegerField;
    qryProductPointsGUIUOM: TWideStringField;
    qryProductPointsGUIUseUOM: TWideStringField;
    qryProductPointsGUIUOMMultiplier: TFloatField;
    Label2: TLabel;
    chkUseDate: TwwCheckBox;
    lblFrom: TLabel;
    dtFrom: TwwDBDateTimePicker;
    lblTo: TLabel;
    dtTo: TwwDBDateTimePicker;
    Label5: TLabel;
    wwCheckBox1: TwwCheckBox;
    Bevel1: TBevel;
    Bevel2: TBevel;
    qryPartsUnitName: TWideStringField;
    qryPartsMultiplier: TFloatField;
    Label6: TLabel;
    Label10: TLabel;
    wwDBDateTimePicker2: TwwDBDateTimePicker;
    Label9: TLabel;
    edtExpiresOnNoOfMonthsAfterPurchase: TwwDBEdit;
    btnProdList: TDNMSpeedButton;
    Bevel3: TBevel;
    Bevel5: TBevel;
    qryClientTypes: TERPQuery;
    qryProductPointsGUIClientTypeID: TLargeintField;
    cboClientType: TwwDBLookupCombo;
    Label3: TLabel;
    qryPartsUnitID: TLargeintField;
    qryPartsPARTSID: TIntegerField;
    qryProductPointsExpiresOnNoOfMonthsAfterPurchase: TIntegerField;
    qryProductPointsClientTypeID: TLargeintField;
    pnlBottom: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    btnCreateSingle: TDNMSpeedButton;
    lblinvalid: TLabel;
    tIButton: TwwIButton;
    procedure ProducttDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCreateSingleClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dodatachanged(Sender: TObject);
    procedure actProductListExecute(Sender: TObject);
    procedure actMainSaveUpdate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actMainSaveExecute(Sender: TObject);
    procedure tIButtonClick(Sender: TObject);
  private
    datachanged :Boolean;
    fsTablename:String;
    function ValidtoGenerate:boolean;
    function RewardpointsUpdated(const Closewhendone:Boolean = False) :Boolean;
    procedure ProductGridDataSelect(Sender: TObject);
    Procedure REfreshPart(Ids:String);
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, FastFuncs, ProductListForm, frmRewardPoint, CommonDbLib,
BusObjProductRewardPoints, BusObjConst, tcConst, AppEnvironment;

{$R *.dfm}
procedure TfmRewardPoints.ProductGridDataSelect(Sender: TObject);
var
  IdStr: string;
  i: integer;
  ProgressDialog: TProgressDialog;
begin
  IdStr := '';
ProgressDialog:= TProgressDialog.create(self);
TwwDBGrid(Sender).datasource.dataset.disablecontrols;
try
  With TwwDBGrid(Sender).datasource.dataset do begin
          ProgressDialog.Caption := 'Please Wait .......';
      ProgressDialog.MinValue := 0;
      ProgressDialog.MaxValue := TwwDBGrid(Sender).SelectedList.Count;
      ProgressDialog.Step := 1;
      ProgressDialog.Execute;

    for i := 0 to TwwDBGrid(Sender).SelectedList.Count - 1 do begin
      GotoBookmark(TwwDBGrid(Sender).SelectedList.Items[i]);
      if fieldbyname('PARTSID').AsInteger <> 0 then begin
        if IdStr <> '' then IdStr := IdStr + ',';
        IdStr := IdStr + Trim(fieldbyname('PARTSID').AsString);
      end;
      ProgressDialog.Stepit;
    end;
  end;

  if IDstr <> '' then begin
    REfreshPart(IDstr);

    dodatachanged(nil);
  end;
finally
    TwwDBGrid(Sender).datasource.dataset.enablecontrols;
    Freeandnil(ProgressDialog);
end;
end;

procedure TfmRewardPoints.ProducttDblClick(Sender: TObject);
var
  PartsID:String;
begin
  inherited;
  if qryPartsPartsId.asInteger = 0 then exit;
  
  if CommonLib.MessageDlgXP_Vista('Do you want to remove ' +qryPartsPArtname.asString +'?' , mtconfirmation , [mbyes, mbno] , 0 ) = mryes then begin
    qryParts.DisableControls;
    try
      PartsId := qryPartsPartsId.asString;
      if Qryparts.active then Qryparts.close;
      Qryparts.SQL.text := StringReplace(Qryparts.SQL.text , Trim(PartsID) +',' , '' , [rfIgnoreCase]);
      Qryparts.SQL.text := StringReplace(Qryparts.SQL.text , ','+ Trim(PartsID) , '' , [rfIgnoreCase]);
      Qryparts.Open;
    finally
        qryParts.EnableControls;
    end;
  end;
end;

procedure TfmRewardPoints.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen: array of string;
begin
  inherited;
  REfreshPart('');
  Setlength(QueryNamesNotToOpen, 1);
  QueryNamesNotToOpen[0] := 'qryProductPoints';
  OpenQueries(QueryNamesNotToOpen);
  qryProductPointsGUI.append;
  qryProductPointsGUIUseExpiryDate.asBoolean := true;
  qryProductPointsGUIExpiresOnNoOfMonthsAfterPurchase.asInteger := appenv.CompanyPrefs.ExpiresOnNoOfMonthsAfterPurchase;

end;

procedure TfmRewardPoints.btnCreateSingleClick(Sender: TObject);
var
  Form:TComponent;
begin
  if datachanged then begin
    if CommonLib.MessageDlgXP_Vista('Do you wish to update the Products'' reward points before creating single?' , mtConfirmation , [mbYes, mbNo], 0) = mryes then begin
      if not ValidtoGenerate then begin
        CommonLib.MessageDlgXP_Vista('Update Failed - Insufficiant information.' , mtWarning, [mbok], 0);
        exit;
      end;
      if not RewardpointsUpdated then exit;

    end;
  end;

  if not FormStillOpen('TfmRewardPoint') then begin
    Form := GetComponentByClassName('TfmRewardPoint');
    if Assigned(Form) then begin
      with TfmRewardPoint(Form) do begin
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  end else TfmRewardPoint(FindExistingComponent('TfmRewardPoint')).show;
  Application.ProcessMessages;
  Self.Close;
end;

procedure TfmRewardPoints.FormCreate(Sender: TObject);
begin
  inherited;
  datachanged := False;
  fsTablename := CommonDbLib.CreateUserTemporaryTable('tblproductrewardpoints' , 'tmp_' , 'MYISAM');
  closeDB(qryProductPointsGUI);
  qryProductPointsGUI.SQL.text := StringReplace(qryProductPointsGUI.SQL.text ,'tblProductREwardPoints' , fsTablename , [rfIgnoreCase] );
end;

procedure TfmRewardPoints.dodatachanged(Sender: TObject);
begin
  inherited;
  datachanged := True;
end;

procedure TfmRewardPoints.actProductListExecute(Sender: TObject);
var
  Form:TComponent;
begin
  inherited;
  Form := getcomponentByclassname('TProductListGUI');
  if not Assigned(Form) then exit;
  if TProductListGUI(Form).visible then begin
    CommonLib.MessageDlgXP_Vista('Product List is already opened. Please close the List and select the option.' , mtInformation , [mbok], 0);
    Exit;
  end else begin
    TProductListGUI(Form).FormStyle := fsMdiChild;
    TProductListGUI(Form).ProductGridDataSelect:= ProductGridDataSelect;
    TProductListGUI(Form).Productlistmode :=   tSetPoints;
    TProductListGUI(Form).HighlightControl(TProductListGUI(Form).btnBarCodes);
    TProductListGUI(Form).BringToFront;
  end;
end;

procedure TfmRewardPoints.actMainSaveUpdate(Sender: TObject);
begin
  inherited;
  actMainSave.Enabled := ValidtoGenerate;
end;

function TfmRewardPoints.ValidtoGenerate: boolean;
begin
  REsult := False;
  if (qryparts.RecordCount = 0) then begin
    lblinvalid.caption := 'Select Product';
    exit;
  end;
  if (qryProductPointsGUIPoints.Asfloat=0) then begin
    lblinvalid.caption := 'Provide Points';
    exit;
  end;
  if (qryProductPointsGUIValue.Asfloat=0) then begin
    lblinvalid.caption := 'Provide Points Value';
    exit;
  end;
  if ((qryProductPointsGUIUseDate.asBoolean) and ((qryProductPointsGUIDateFrom.asDateTime= 0) or (qryProductPointsGUIDateto.asDatetime = 0))) then begin
    lblinvalid.caption := 'Provide "Date From" and "Date To"';
    exit;
  end;
  if ((qryProductPointsGUIUseDate.asBoolean=False) and ((qryProductPointsGUIDateFrom.asDateTime<>0) Or (qryProductPointsGUIDateto.asDatetime <> 0))) then begin
    lblinvalid.caption := '"Date From" and "Date To" should Be Blank';
    exit;
  end;
  if (qryProductPointsGUIUseExpiryDate.asBoolean) and ((qryProductPointsGUIRewardPointExpiresOn.asdatetime=0) and (qryProductPointsGUIExpiresOnNoOfMonthsAfterPurchase.asInteger=0)) then begin
    lblinvalid.caption := 'Either "Points Expires on" or "Expires no of months from Date of Purchase" Should Be Provided';
    exit;
  end;
  if (qryProductPointsGUIUseExpiryDate.asBoolean=false) and (qryProductPointsGUIRewardPointExpiresOn.asdatetime<>0) then begin
    lblinvalid.caption := '"Points Expires on" and "Expires no of months from Date of Purchase" Should Be Blank';
    exit;
  end;
  lblinvalid.caption := '';
  REsult := true;
end;

procedure TfmRewardPoints.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(fstablename);
  inherited;

end;

function TfmRewardPoints.RewardpointsUpdated(const Closewhendone:Boolean = False) :Boolean;
var
  PRP:TProductRewardPoints;
  Ids:String;
  updatedone :Boolean;
  ProgressDialog: TProgressDialog;
  s:String;
begin
  updateDone :=False;
  REsult := False;
  if not ValidtoGenerate then Exit;
  ProgressDialog:= TProgressDialog.create(self);
  PRP:= TProductRewardPoints.create(Self);
  TRy
    PRP.connection := TMyDacDataConnection.create(PRP);
    PRP.connection.Connection := MyConnection;
    PRP.BusObjEvent := DoBusinessObjectEvent;
    PRP.Load(KeyID);
    PRP.Connection.BeginTransaction;
    PRP.SilentMode := true;
    Try
      qryParts.first;
      Ids := '0';

      ProgressDialog.Caption := 'Please Wait .......';
      ProgressDialog.MinValue := 0;
      ProgressDialog.MaxValue := qryParts.recordcount;
      ProgressDialog.Step := 1;
      ProgressDialog.Execute;
      s:= '';
      while qryParts.eof = False do begin
        ProgressDialog.StepIt;
        if not PRP.Locaterecord(qryPartsPartname.asString,qryProductPointsGUIUseDate.asBoolean,qryProductPointsGUIDateFrom.asDatetime,qryProductPointsGUIDateTo.asDateTime,qryProductPointsGUIClientTypeID.asInteger,qryProductPointsGUIUseUOM.asBoolean,qryProductPointsGUIUOMID.asInteger) then begin
          PRP.New;
          PRP.Partname            := qryPartsPartname.asString;
          PRP.UseDate             := qryProductPointsGUIUseDate.asBoolean;
          PRP.DateFrom            := qryProductPointsGUIDateFrom.asDatetime;
          PRP.DateTo              := qryProductPointsGUIDateTo.asDateTime;
          PRP.ClientTypeID        := qryProductPointsGUIClientTypeID.asInteger;
          if qryProductPointsGUIUseUOM.asBoolean then begin
            PRP.UseUOM := True;
            PRP.UOMID             := qryProductPointsGUIUOMID.asInteger;
            PRP.UOM               := qryProductPointsGUIUOM.asString;
          end else begin
            PRP.UseUOM := False;
          end;
        end;
        Prp.Points                := qryProductPointsGUIPoints.asFloat;
        PRP.Value                 := qryProductPointsGUIValue.asFloat;
        PRP.UseExpiryDate         := qryProductPointsGUIUseExpiryDate.asBoolean;
        PRP.RewardPointExpiresOn  := qryProductPointsGUIRewardPointExpiresOn.asDatetime;
        PRP.ExpiresOnNoOfMonthsAfterPurchase := qryProductPointsGUIExpiresOnNoOfMonthsAfterPurchase.asInteger;

        if PRP.ValidateData then begin
          PRP.PostDB;
          updateDone:= True;
        end else begin
            if s <> '' then s := s + chr(13);
            s:= PRP.ResultStatus.GetLastFatalStatusItem.Message;
            ids := ids +',';
            Ids := ids + qryPartsPartsId.AsString;
            if PRP.dataset.State = dsinsert then
              PRP.cancel
            else begin
              if PRP.dataset.State = dsEdit then
                PRP.Cancel;
              PRP.Delete;
            end;
        end;

        QryParts.Next;
      end;

      PRP.Connection.CommitTransaction;
      Result := true;

      if Ids<> '0' then begin
        (*lblTitle2.caption := 'Reward points are not created for the following products'*)
      end else begin
        datachanged := False;
        if updatedone and Closewhendone then begin
          CommonLib.MessageDlgXP_Vista('Reward Points Are Updated.' , mtWarning, [mbok], 0);
          Self.Close;
          exit;
        end else begin
          (*lblTitle2.caption :='Zero Products To Update';*)
          qryProductPointsGUI.delete;
          qryProductPointsGUI.Append;
        end;
      end;
      if Ids<> '0' then
        CommonLib.MessageDlgXP_Vista('Reward Points Update Failed for the products in the list box as there are already existing Reward Point record(s) for overlaping period.' ,  mtWarning, [mbok], 0)
      else if updatedone then
        CommonLib.MessageDlgXP_Vista('Reward Points Are Updated.' , mtWarning, [mbok], 0) ;
    Except
        on E:Exception do begin
            MessageDlgXP_Vista('Update failed :' +E.message , mtWarning , [mbOk], 0);
            PRP.Connection.RollbackTransaction;
        end;
    end;
    REfreshPart(Ids);
  finally
      Freeandnil(PRP);
      FreeandNil(ProgressDialog);
  end;
end;

procedure TfmRewardPoints.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TProductRewardPoints then TProductRewardPoints(Sender).Dataset:= qryProductPoints;
  end;

end;

procedure TfmRewardPoints.REfreshPart(Ids: String);
begin
  if Ids = '' then IDS := '0';
  closedb(QryParts);
  QryParts.SQL.text := 'SELECT Distinct P.PARTSID,P.PARTNAME,' +
                      ' cast( ifnull(U.UnitID, Units.UnitID)  as  signed) as UnitID, ' +
                      ' ifnull(U.UnitName, Units.UnitName) as UnitName,' +
                      ' ifnull(U.Multiplier, Units.Multiplier) as Multiplier' +
                      ' FROM tblparts AS P ' +
                      ' Left Join tblunitsofmeasure AS U ON P.PARTSID = ifnull(U.PartID,0)     and U.SalesDefault="T" ' +
                      ' Left Join tblunitsofmeasure AS Units ON  Units.unitname = '+ QuotedStr(AppEnv.DefaultClass.DefaultUOM)+'  and Units.Multiplier = 1  and ifnull(Units.PartID,0)=0' +
                      ' WHERE' +
                      ' P.Active =  "T" AND' +
                      ' P.PARTSID IN  ( '+ Ids +')';
  openDB(QryParts);
end;

procedure TfmRewardPoints.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TfmRewardPoints.btnCancelClick(Sender: TObject);
begin
  inherited;
  Self.close;
end;

procedure TfmRewardPoints.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  ExitResult: Word;
begin
  inherited;
  if datachanged then begin
    ExitResult := CommonLib.MessageDlgXP_Vista('Do You Wish To Update the selected products ?', mtWarning, [mbYes, mbNo, mbCancel], 0);
    case ExitResult of
            mrYes:
                if not ValidtoGenerate then begin
                  canclose:= False;
                  CommonLib.MessageDlgXP_Vista('Update Failed - Insufficiant information.' , mtWarning, [mbok], 0);
                end else if not RewardpointsUpdated then canclose:= false
                else Canclose := True;
            mrNo:
              begin
                canclose := TRue;
              end;
            mrCancel:
              CanClose:= false;
          end;
  end else begin
    canclose := TRue;
  end;
end;

procedure TfmRewardPoints.actMainSaveExecute(Sender: TObject);
begin
  inherited;
  if not ValidtoGenerate then begin
    CommonLib.MessageDlgXP_Vista('Update Failed - Insufficiant information.' , mtWarning, [mbok], 0);
    exit;
  end;
  RewardpointsUpdated(true);
end;

procedure TfmRewardPoints.tIButtonClick(Sender: TObject);
begin
  ProducttDblClick(t);
end;

initialization
  RegisterClassOnce(TfmRewardPoints);
end.



