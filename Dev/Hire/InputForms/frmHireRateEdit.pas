unit frmHireRateEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, DNMSpeedButton, Shader, DNMPanel, AdvEdit;

type
  TfmHireRateEdit = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    edtRate: TAdvEdit;
    Label1: TLabel;
    edtAssetName: TEdit;
    edtDurationName: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    procedure btnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    fDurationID: integer;
    FAssetName: string;
    procedure SetAssetName(const Value: string);
    procedure SetDurationID(const Value: integer);
    function UpdateHireItems: boolean;
  protected
    property AssetName: string read FAssetName write SetAssetName;
    property DurationID: integer read fDurationID write SetDurationID;
  public
    { Public declarations }
  end;

  function AddNewHireRate(aAssetName: string; aDurationId: integer): boolean;

implementation

{$R *.dfm}

uses
  BusObjDuration, DbSharedObjectsObj, CommonDbLib, BusObjAssetHire, CommonLib,
  DnmLib;

function AddNewHireRate(aAssetName: string; aDurationId: integer): boolean;
var
  form: TfmHireRateEdit;
begin
  result := false;
  form := TfmHireRateEdit.Create(nil);
  try
    if form.AccessLevel = 6 then begin
      CommonLib.MessageDlgXP_Vista('You do not have Access to ' + GetFormDescription(form.ClassName),mtInformation,[mbOk],0);
      exit;
    end;
    form.AssetName := aAssetName;
    form.DurationID := aDurationID;
    result := form.ShowModal = mrOk;
  finally
    form.Free;
  end;
end;

{ TfmHireRateEdit }

procedure TfmHireRateEdit.btnSaveClick(Sender: TObject);
begin
  inherited;
  if UpdateHireItems then
    ModalResult := mrOk;
end;

procedure TfmHireRateEdit.FormCreate(Sender: TObject);
begin
  inherited;
  edtRate.Precision := FormatSettings.CurrencyDecimals;
end;

procedure TfmHireRateEdit.SetAssetName(const Value: string);
begin
  FAssetName := Value;
  edtAssetName.Text := Value;
end;

procedure TfmHireRateEdit.SetDurationID(const Value: integer);
begin
  fDurationID := Value;
  edtDurationName.Text := TDuration.IDToggle(Value);
end;

function TfmHireRateEdit.UpdateHireItems: boolean;
var
  qry: TERPQuery;
  AssetHire: TAssetHire;
begin
  result := false;
  qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Add('select tblfixedassets.AssetID, tblfixedassets.AssetName, tblfixedassets.AssetCode, tblassethire.AssetHireId');
    qry.SQL.Add('from tblfixedassets');
    qry.SQL.Add('inner join tblassethire on tblassethire.AssetId = tblfixedassets.AssetID');
    qry.SQL.Add('where tblfixedassets.AssetName = ' + QuotedStr(AssetName));
    qry.Open;
    AssetHire := TAssetHire.CreateWithNewConn(nil);
    try
      AssetHire.Connection.BeginTransaction;
      while not qry.eof do begin
        AssetHire.Load(qry.FieldByName('AssetHireId').AsInteger);
        AssetHire.ResultStatus.Clear;
        if AssetHire.PriceLines.Locate('DurationId',DurationId,[]) then begin
          if AssetHire.PriceLines.Rate <> edtRate.FloatValue then begin
            AssetHire.PriceLines.Rate := edtRate.FloatValue;
            AssetHire.PriceLines.Active := true;
            AssetHire.PriceLines.PostDb;
            if not AssetHire.ValidateData then exit;
            if not AssetHire.Save then exit;
          end;
        end
        else begin
          AssetHire.PriceLines.New;
          AssetHire.PriceLines.AssetHireID := qry.FieldByName('AssetHireId').AsInteger;
          AssetHire.PriceLines.DurationID := DurationID;
          AssetHire.PriceLines.Rate := edtRate.FloatValue;
          AssetHire.PriceLines.Active := true;
          AssetHire.PriceLines.PostDb;
          if not AssetHire.ValidateData then exit;
          if not AssetHire.Save then exit;
        end;
        qry.Next;
      end;
      AssetHire.Connection.CommitTransaction;
    finally
      AssetHire.Connection.RollbackTransaction;
      AssetHire.Free;
    end;
    result := true;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

end.
