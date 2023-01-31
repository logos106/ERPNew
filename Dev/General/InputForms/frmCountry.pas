unit frmCountry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, StdCtrls, Mask, DBCtrls, DB, wwcheckbox,
  DNMSpeedButton, Shader, ExtCtrls, DNMPanel, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, BusobjCountries, BusObjBase, ProgressDialog;

type
  TfmCountry = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cmdOk: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    Label1: TLabel;
    chkActive: TwwCheckBox;
    qryCountry: TERPQuery;
    qryCountryCountryId: TIntegerField;
    qryCountryCountry: TWideStringField;
    qryCountryActive: TWideStringField;
    dsCountry: TDataSource;
    Description_Label: TLabel;
    edtcountry: TDBEdit;
    qryCountryCurrencyDesc: TWideStringField;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    procedure FormShow(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmdOkClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    countryObj :TCountries;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, FormFactory;

{$R *.dfm}
procedure TfmCountry.FormShow(Sender: TObject);
begin
  inherited;
  countryObj.Load(KeyID);
  countryObj.Connection.BeginTransaction;
end;

procedure TfmCountry.cmdNewClick(Sender: TObject);
begin
  inherited;
  if countryObj.dirty then
    if not countryObj.Save then exit;
  countryObj.Connection.CommitTransaction;
  countryObj.Connection.BeginTransaction;
  countryObj.New;
  SetControlFocus(edtcountry);
end;

procedure TfmCountry.FormCreate(Sender: TObject);
begin
  inherited;
  countryObj :=TCountries.Create(self);
  countryObj.Connection := TMyDacDataConnection.create(countryObj);
  countryObj.Connection.Connection := MyConnection;
  countryObj.BusObjEvent := DoBusinessObjectEvent;
end;

procedure TfmCountry.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
begin
  inherited;
  if sender is TCountries     then TCountries(Sender).dataset    := qryCountry;
end;

procedure TfmCountry.cmdOkClick(Sender: TObject);
begin
  inherited;
  if countryObj.Save then begin
      countryObj.Connection.CommitTransaction;
      notify;
      Self.Close;
  end;
end;

procedure TfmCountry.cmdCancelClick(Sender: TObject);
begin
  inherited;
  notify(true);
  Self.Close;
end;

procedure TfmCountry.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  (*countryObj.PostDB;*)
  if countryObj.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if countryObj.Save then begin
            countryObj.Connection.CommitTransaction;
            CanClose:= true;
          end
          else begin
            CanClose:= false;
          end;
        end;
      mrNo:
        begin
          countryObj.Connection.RollbackTransaction;
          CanClose:= true;
        end;
      mrCancel:
        begin
          Exit;
        end;
    end;
  end;
end;

procedure TfmCountry.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  inherited;

end;

initialization
  RegisterClassOnce(TfmCountry);
  with FormFact do begin
    RegisterMe(TfmCountry, 'TCountryListGUI_*=CountryId');
    RegisterControl(TfmCountry, '*_cbocountry=CountryId');
  end;
end.
