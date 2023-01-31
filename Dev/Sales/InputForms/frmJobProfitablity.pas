unit frmJobProfitablity;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DNMSpeedButton, Shader, ExtCtrls, ProgressDialog, DB,
  MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus,
  DataState, SelectionDialog, AppEvnts, StdCtrls, DNMPanel, JobProfitabilityForm,
  Mask, wwdbedit;

type
  TfmJobProfitablity = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    DNMSpeedButton1: TDNMSpeedButton;
    lblApplyDate: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    edincome: TwwDBEdit;
    edcost: TwwDBEdit;
    edQuoted: TwwDBEdit;
    edlatestcost: TwwDBEdit;
    edlastcost: TwwDBEdit;
    wwDBEdit8: TwwDBEdit;
    wwDBEdit9: TwwDBEdit;
    wwDBEdit10: TwwDBEdit;
    wwDBEdit13: TwwDBEdit;
    wwDBEdit14: TwwDBEdit;
    wwDBEdit15: TwwDBEdit;
    wwDBEdit16: TwwDBEdit;
    Label10: TLabel;
    Label11: TLabel;
    wwDBEdit17: TwwDBEdit;
    Label12: TLabel;
    wwDBEdit18: TwwDBEdit;
    wwDBEdit19: TwwDBEdit;
    DataSource1: TDataSource;
    Label13: TLabel;
    wwDBEdit1: TwwDBEdit;
    Label14: TLabel;
    wwDBEdit4: TwwDBEdit;
    wwDBEdit7: TwwDBEdit;
    wwDBEdit12: TwwDBEdit;
    qryparts: TERPQuery;
    DataSource2: TDataSource;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Label15: TLabel;
    Label16: TLabel;
    Shape10: TShape;
    Shape11: TShape;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private

  public
    jobProfitabilityReport :TJobProfitabilityGUI;
  end;


implementation

uses CommonLib;

{$R *.dfm}

procedure TfmJobProfitablity.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  inherited;
  Action := cafree;
end;

procedure TfmJobProfitablity.FormShow(Sender: TObject);
begin
  inherited;
  DataSource1.dataset :=   jobProfitabilityReport.Qrymain;
  qryparts.Parambyname('ProductID').asInteger :=jobProfitabilityReport.QrymainProductID.asInteger;
  openQueries;
end;
initialization
  RegisterClassOnce(TfmJobProfitablity);

end.

