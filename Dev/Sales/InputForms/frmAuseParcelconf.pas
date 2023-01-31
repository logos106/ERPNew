unit frmAuseParcelconf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase, AusPosteParcelObj, Mask, wwcheckbox;

type
  TfmAuseParcelconf = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    QryAusPostEParcelconf: TERPQuery;
    dsAusPostEParcelconf: TDataSource;
    Box20: TBevel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    QryAusPostEParcelconfID: TIntegerField;
    QryAusPostEParcelconfGlobalref: TWideStringField;
    QryAusPostEParcelconfPostAccountNumber: TWideStringField;
    QryAusPostEParcelconfChargeCode: TWideStringField;
    QryAusPostEParcelconfAddconsigneetoAddressBook: TWideStringField;
    QryAusPostEParcelconfmsTimeStamp: TDateTimeField;
    QryAusPostEParcelconfmsUpdateSiteCode: TWideStringField;
    Label1: TLabel;
    edtCompanyNumber: TDBEdit;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    Label3: TLabel;
    wwCheckBox1: TwwCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    AusPostEParcelconf: TAusPostEParcelconf;
    function SaveRecord: Boolean;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, BusObjConst;

{$R *.dfm}

procedure TfmAuseParcelconf.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

Function TfmAuseParcelconf.SaveRecord :Boolean;
begin
  result:= False;
  AusPostEParcelconf.PostDB;
  if not(AusPostEParcelconf.Save) then exit;
  Result:= True;
end;

procedure TfmAuseParcelconf.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  AusPostEParcelconf.Connection.CommitTransaction;
  Self.Close;

end;

procedure TfmAuseParcelconf.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
     inherited ;
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TAusPostEParcelconf then TAusPostEParcelconf(Sender).Dataset  := QryAusPostEParcelconf;
     end;
end;

procedure TfmAuseParcelconf.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmAuseParcelconf.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if AusPostEParcelconf.Dirty then begin
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
          AusPostEParcelconf.Dirty := false;
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

procedure TfmAuseParcelconf.FormCreate(Sender: TObject);
begin
  inherited;
  {$WARNINGS OFF}
  AusPostEParcelconf := TAusPostEParcelconf.CreateWithNewConn(Self);
  AusPostEParcelconf.Connection.connection := Self.MyConnection;
  AusPostEParcelconf.BusObjEvent := DoBusinessObjectEvent;
  {$WARNINGS ON}
end;
procedure TfmAuseParcelconf.FormShow(Sender: TObject);
begin
  inherited;
  AusPostEParcelconf.Load;
  AusPostEParcelconf.connection.BeginTransaction;
  if AusPostEParcelconf.count=0 then AusPostEParcelconf.new;
  openQueries;
end;

initialization
  RegisterClassOnce(TfmAuseParcelconf);

end.

