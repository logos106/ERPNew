unit frmSimpleTypeEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, DNMSpeedButton, Shader, DNMPanel,
  BusObjSimpleTypes, BusObjBase, wwcheckbox, Mask, DBCtrls;

type
  TfmSimpleTypeEdit = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    qrySimpleTypes: TERPQuery;
    dsSimpleTypes: TDataSource;
    Name: TLabel;
    edtName: TDBEdit;
    Label1: TLabel;
    edtDescription: TDBEdit;
    chkDefault: TwwCheckBox;
    chkActive: TwwCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    SimpleType: TSimpleTypes;
    function GetTypeCode: string;
    procedure SetTypeCode(const Value: string);
  protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string); Override;
  public
    property TypeCode: string read GetTypeCode write SetTypeCode;
  end;

implementation

{$R *.dfm}

uses
  BusObjConst, DNMExceptions, CommonLib;

procedure TfmSimpleTypeEdit.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmSimpleTypeEdit.btnOKClick(Sender: TObject);
begin
  if not SimpleType.Save then exit;
  SimpleType.Connection.CommitTransaction;
  SimpleType.Dirty := False;
  Self.Close;
end;

procedure TfmSimpleTypeEdit.DoBusinessObjectEvent(const Sender: TDatasetBusObj;
  const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TSimpleTypes then TSimpleTypes(Sender).Dataset := qrySimpleTypes
  end;
end;

procedure TfmSimpleTypeEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmSimpleTypeEdit.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ErrorOccurred then Exit;

  CanClose := false;
  if SimpleType.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SimpleType.Save then begin
            SimpleType.Connection.CommitTransaction;
            SimpleType.Dirty := false;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          SimpleType.Dirty := false;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
        end;
    end;
  end else begin
    CanClose := true;
    Notify(false);
  end;
end;

procedure TfmSimpleTypeEdit.FormCreate(Sender: TObject);
begin
  inherited;
  SimpleType := TSimpleTypes.Create(self);
  SimpleType.Connection := TMyDacDataConnection.Create(SimpleType);
  SimpleType.Connection.Connection := Self.MyConnection;
  SimpleType.BusObjEvent := DoBusinessObjectEvent;

end;

procedure TfmSimpleTypeEdit.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;

      RollbackTransaction;

      BeginTransaction;
      SimpleType.Load(KeyId);

      if KeyID = 0 then begin
        edtName.ReadOnly := false;
      end
      else begin
        TitleLabel.Caption := TSimpleTypes.SimpleTypeTypeDesc(TypeCode);
        Caption := StringReplace(Caption,'fmSimpleTypeEdit',TitleLabel.Caption,[]);
        edtName.ReadOnly := true;
      end;

    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;
end;

function TfmSimpleTypeEdit.GetTypeCode: string;
begin
  result := SimpleType.TypeCode;
end;

procedure TfmSimpleTypeEdit.SetTypeCode(const Value: string);
begin
  SimpleType.New;
  SimpleType.TypeCode := Value;
  SimpleType.PostDB;
  TitleLabel.Caption := TSimpleTypes.SimpleTypeTypeDesc(TypeCode);
  Caption := StringReplace(Caption,'fmSimpleTypeEdit',TitleLabel.Caption,[]);
end;

initialization
  RegisterClass(TfmSimpleTypeEdit);


end.
