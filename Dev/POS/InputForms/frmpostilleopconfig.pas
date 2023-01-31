unit frmpostilleopconfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase , BusObjPOSTillEOPConfig, Grids, Wwdbigrd,
  Wwdbgrid, Mask, wwdbedit, Wwdotdot, Wwdbcomb, wwdblook;

type
  Tfmpostilleopconfig = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    qryconfig: TERPQuery;
    wwDBGrid1: TwwDBGrid;
    dsconfig: TDataSource;
    qryconfigID: TIntegerField;
    qryconfigGlobalRef: TWideStringField;
    qryconfigAmount: TIntegerField;
    qryconfigAmountType: TWideStringField;
    qryconfigmsTimeStamp: TDateTimeField;
    qryconfigmsUpdateSiteCode: TWideStringField;
    qryamtTypes: TERPQuery;
    cboAmttype: TwwDBLookupCombo;
    qryamtTypesDescription: TWideStringField;
    qryamtTypescode: TWideStringField;
    qryconfigcAmttype: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdNewClick(Sender: TObject);
    procedure qryconfigCalcFields(DataSet: TDataSet);
    procedure cboAmttypeChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    BusObjPOSTillEOPConfigObj: TPosTilleopConfig;
    function SaveRecord: Boolean;
    Procedure Openrec;
    procedure NewBusObjinstance;
    procedure NewRecord;
  Protected
    procedure CommitAndNotify;override;
    procedure DoFormSize(ChangeSize: Boolean);override;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, BusObjConst, AppEnvironment;

{$R *.dfm}

procedure Tfmpostilleopconfig.cboAmttypeChange(Sender: TObject);
var
  s:String;
begin
  inherited;
  s:= qryamtTypescode.AsString;
  if s <> BusObjPOSTillEOPConfigObj.Amounttype  then begin
    BusObjPOSTillEOPConfigObj.Amounttype  := s;
    BusObjPOSTillEOPConfigObj.PostDB;
  end;
end;

procedure Tfmpostilleopconfig.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

Function Tfmpostilleopconfig.SaveRecord :Boolean;
begin
  result:= False;
  BusObjPOSTillEOPConfigObj.PostDB;
  if not(BusObjPOSTillEOPConfigObj.Save) then exit;
  Result:= True;

end;

procedure Tfmpostilleopconfig.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  BusObjPOSTillEOPConfigObj.Connection.CommitTransaction;
  Self.Close;

end;
procedure Tfmpostilleopconfig.DoFormSize(ChangeSize: Boolean);
begin
  //inherited;
  Self.WindowState := wsNormal;
  SizeMode := 'N';
end;

procedure Tfmpostilleopconfig.cmdNewClick(Sender: TObject);
begin
  inherited;
  // If user does not have access to this form don't process any further
  DisableForm;
  try
    if BusObjPOSTillEOPConfigObj.Dirty then begin
      case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
        mrYes:
          begin
            if SaveRecord then begin
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

procedure Tfmpostilleopconfig.CommitAndNotify;
begin
  inherited;
  CommitTransaction;
  Notify;
end;

procedure Tfmpostilleopconfig.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
     inherited ;
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TPosTilleopConfig then TPosTilleopConfig(Sender).Dataset  := qryconfig;
     end;
end;

procedure Tfmpostilleopconfig.FormActivate(Sender: TObject);
begin
  inherited;
  WindowState := wsnormal;
end;

procedure Tfmpostilleopconfig.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure Tfmpostilleopconfig.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if BusObjPOSTillEOPConfigObj.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveRecord then begin
            CommitAndNotify;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          BusObjPOSTillEOPConfigObj.Dirty := false;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
          cmdCancel.Enabled := True;
        end;
    end;
  end else begin
    CanClose := true;
    Notify(false);
  end;

end;

procedure Tfmpostilleopconfig.FormCreate(Sender: TObject);
begin
  inherited;
   NewBusObjinstance;
   (*cboAmttype.Items.Clear;
   cboAmttype.Items.Add(Appenv.RegionalOptions.WholeCurrencyName);
   cboAmttype.Items.Add(Appenv.RegionalOptions.DecimalCurrencyName);*)
   closedb(qryamtTypes);
   qryamtTypes.SQL.text := 'Select ' + Quotedstr(Appenv.RegionalOptions.WholeCurrencyName) + ' as Description , "N" as Code ' +
                            ' union all ' +
                            'Select ' + Quotedstr(Appenv.RegionalOptions.DecimalCurrencyName) + ' as Description , "C" as Code ';
end;
procedure Tfmpostilleopconfig.FormShow(Sender: TObject);
begin
  inherited;
  Opendb(qryamtTypes);
  OpenRec;
  Self.WindowState := wsNormal;
end;

procedure Tfmpostilleopconfig.NewBusObjinstance;
begin
  {$WARNINGS OFF}
  BusObjPOSTillEOPConfigObj := TPosTilleopConfig.CreateWithNewConn(Self);
  BusObjPOSTillEOPConfigObj.Connection.connection := Self.MyConnection;
  BusObjPOSTillEOPConfigObj.BusObjEvent := DoBusinessObjectEvent;
  {$WARNINGS ON}

end;

procedure Tfmpostilleopconfig.NewRecord;
begin
    CloseQueries;
    KeyID:= 0;
    NewBusObjinstance;
    AccessLevel:= AppEnv.AccessLevels.GetEmployeeAccessLevel(Self.ClassName);
    self.BeginTransaction;
    OpenRec;
    Caption:= TitleLabel.Caption + AppEnv.AccessLevels.GetAccessLevelDescription(AccessLevel);
    //Setcontrolfocus(edtName);
end;

procedure Tfmpostilleopconfig.Openrec;
begin
  BusObjPOSTillEOPConfigObj.Load;
  BusObjPOSTillEOPConfigObj.connection.BeginTransaction;
  openQueries;
  BusObjPOSTillEOPConfigObj.Dirty := false;
end;

procedure Tfmpostilleopconfig.qryconfigCalcFields(DataSet: TDataSet);
begin
  inherited;
  //qryconfigcAmountType.asString := iif(qryconfigAmountType.asString ='C' , Appenv.RegionalOptions.DecimalCurrencyName , Appenv.RegionalOptions.WholeCurrencyName);
end;

initialization
  RegisterClassOnce(Tfmpostilleopconfig);

end.

