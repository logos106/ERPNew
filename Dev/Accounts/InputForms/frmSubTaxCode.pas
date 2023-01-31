unit frmSubTaxCode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  StdCtrls, Shader, DNMPanel, DNMSpeedButton, wwcheckbox, Mask, wwdbedit , BusObjTaxCodes , BusObjBase, wwclearbuttongroup, wwradiogroup, ProgressDialog;

type
  TfmSubTaxCode = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnCompleted: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    edtCode: TwwDBEdit;
    edtDescription: TwwDBEdit;
    Label3: TLabel;
    chkActive: TwwCheckBox;
    Qrysubtaxcode: TERPQuery;
    dssubtaxcode: TDataSource;
    QrysubtaxcodeID: TIntegerField;
    QrysubtaxcodeGlobalRef: TWideStringField;
    QrysubtaxcodeCode: TWideStringField;
    QrysubtaxcodeDescription: TWideStringField;
    QrysubtaxcodeActive: TWideStringField;
    QrysubtaxcodeRegionID: TSmallintField;
    Qrysubtaxcodemstimestamp: TDateTimeField;
    cmdNew: TDNMSpeedButton;
    QrysubtaxcodeCategory: TWideStringField;
    wwRadioGroup1: TwwRadioGroup;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdNewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  Protected
    function SaveOrCancelChanges: boolean;override;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  private
    SubTaxCode :TSubTaxCode;
  public

  end;


implementation

uses CommonLib , BusObjConst, FormFactory;

{$R *.dfm}

procedure TfmSubTaxCode.btnCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfmSubTaxCode.btnCompletedClick(Sender: TObject);
begin
  inherited;
  if not(SubTaxCode.Save) then exit;
  SubTaxCode.Connection.CommitTransaction;
  SubTaxCode.Dirty := False;
  Self.Close;
end;

procedure TfmSubTaxCode.cmdNewClick(Sender: TObject);
begin
  inherited;
  if  not(SubTaxCode.Save) then exit;
  SubTaxCode.Connection.CommitTransaction;
  SubTaxCode.connection.BeginTransaction;
  SubTaxCode.New;
  edtCode.ReadOnly := False;
  Setcontrolfocus(edtCode);
end;

procedure TfmSubTaxCode.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TSubTaxCode then TSubTaxCode(Sender).Dataset  := Qrysubtaxcode;
  end;
end;

procedure TfmSubTaxCode.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := CaFree;
  inherited;

end;

procedure TfmSubTaxCode.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if SubTaxCode.dirty then begin
    bringToFront;
    Canclose:= SaveOrCancelChanges;
  end else begin
    RollbackTransaction;
    Canclose:= True;
  end;
end;

procedure TfmSubTaxCode.FormCreate(Sender: TObject);
begin
  inherited;
  SubTaxCode := TSubTaxCode.Create(Self);
  SubTaxCode.connection := TMyDacDataconnection.create(SubTaxCode);
  SubTaxCode.connection.connection  := self.MyConnection;
  SubTaxCode.BusobjEvent := DoBusinessObjectEvent;
end;

procedure TfmSubTaxCode.FormShow(Sender: TObject);
begin
  inherited;
  SubTaxCode.Load(KeyID);
  edtCode.ReadOnly := KeyID<> 0;
  SubTaxCode.Connection.BeginTransaction;
  if KeyId =0 then SubTaxCode.New;
end;

function TfmSubTaxCode.SaveOrCancelChanges: boolean;
var
  ExitResult: Word;
begin
  Result := True;
   ExitResult := CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0);
          case ExitResult of
            mrYes: begin
                  result := SubTaxCode.Save;
                  if result then Notify(False);
                  end;
            mrNo: begin
                    RollbackTransaction;
                    REsult := True;
                    Notify(TRue);
                  end;
            mrCancel: begin
                    result:= false;
                  end;
          end;


end;

initialization
  RegisterClass(TfmSubTaxCode);
  with FormFact do begin
    RegisterMe(TfmSubTaxCode, 'TSubTaxcodesGUI_*=ID');
  end;

end.

