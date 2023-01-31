unit frmVs1ClientModulerenew;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, SelectionDialog, Menus, ExtCtrls, StdCtrls, DNMPanel, BusObjVS1_Cloud,
  Shader, DB, Mask, DBCtrls, DNMSpeedButton, wwdbdatetimepicker;

type
  TfmVs1ClientModulerenew = class(TBaseForm)
    dsvs1_clientmodules: TDataSource;
    DNMPanel1: TDNMPanel;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel2: TDNMPanel;
    lblClientPrintNameHeading: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtLicenseLevel: TDBEdit;
    edtModuleName: TDBEdit;
    edtcleanLicenseFrom: TwwDBDateTimePicker;
    edtcleanLicenseUntil: TwwDBDateTimePicker;
    edtLicenseFrom: TwwDBDateTimePicker;
    edtLicenseUntil: TwwDBDateTimePicker;
    DNMPanel3: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    chkDontContact: TDBCheckBox;
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
  private
    fVS1_ClientModule: TVS1_ClientModules;
    procedure SetVS1_ClientModule(const Value: TVS1_ClientModules);
  public
    Property VS1_ClientModule : TVS1_ClientModules read fVS1_ClientModule write SetVS1_ClientModule;
  end;

implementation

uses CommonLib;

{$R *.dfm}

{ TfmVs1ClientModulerenew }

procedure TfmVs1ClientModulerenew.cmdCancelClick(Sender: TObject);
begin
  inherited;
  VS1_ClientModule.CancelDB;
  VS1_ClientModule.connection.RollbackNestedTransaction;
  CloseIt(False);
end;

procedure TfmVs1ClientModulerenew.cmdCloseClick(Sender: TObject);
begin
  inherited;
  VS1_ClientModule.PostDB;
  VS1_ClientModule.connection.commitNestedTransaction;
  CloseIt(true);
end;

procedure TfmVs1ClientModulerenew.FormShow(Sender: TObject);
begin
  inherited;
  VS1_ClientModule.connection.BeginNestedTransaction;
  if VS1_ClientModule.CleanLicensefrom =0 then else edtcleanLicenseFrom.Date :=  VS1_ClientModule.CleanLicensefrom;
  if VS1_ClientModule.CleanLicenseUntil   =0 then else edtcleanLicenseUntil.Date :=  VS1_ClientModule.CleanLicenseUntil;
  Setcontrolfocus(cmdClose);
end;

procedure TfmVs1ClientModulerenew.SetVS1_ClientModule(const Value: TVS1_ClientModules);
begin
  fVS1_ClientModule := Value;
  dsvs1_clientmodules.Dataset := Value.Dataset;
end;

end.
