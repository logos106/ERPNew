unit CommissPopUp;

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 08/04/05  1.00.01 IJB  Changed query to MyDac, changed to also update
  //                        Sales Commission table.

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, BaseInputForm, DB,  ExtCtrls, DNMPanel, Buttons, DNMSpeedButton,
  MemDS, DBAccess, MyAccess,ERPdbComponents, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, ImgList;

type
  TfrmCommissPopUp = class(TBaseInputGUI)
    DSsales: TDataSource;
    DNMPanel1: TDNMPanel;
    Label1: TLabel;
    btnYes: TDNMSpeedButton;
    btnNo: TDNMSpeedButton;
    qrySales: TERPQuery;
    procedure btnYesClick(Sender: TObject);
    procedure btnNoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    
  end;

implementation

uses
  EmployeeReportListFrm, CommonDbLib, CommonLib;
{$R *.dfm}

procedure TfrmCommissPopUp.btnYesClick(Sender: TObject);
begin
  if TEmployeeReportGUI(Self.Owner).sSaleID <> '0' then begin
    qrySales.SQL.Text := 'UPDATE tblsales SET CommissionPaid = "T" WHERE SaleID = ' + TEmployeeReportGUI(Self.Owner).sSaleID;
    qrySales.Execute;
//    qrySales.SQL.Text := 'UPDATE tblSalesCommission SET IsPaid = "T" WHERE SaleID = ' + TEmployeeReportGUI(Self.Owner).sSaleID;
//    qrySales.Execute;
    qrySales.Close;
  end;
  self.Close;
end;

procedure TfrmCommissPopUp.btnNoClick(Sender: TObject);
begin
  if TEmployeeReportGUI(Self.Owner).sSaleID <> '0' then begin
    qrySales.SQL.Text := 'UPDATE tblsales SET CommissionPaid = "F" WHERE SaleID = ' + TEmployeeReportGUI(Self.Owner).sSaleID;
    qrySales.Execute;
//    qrySales.SQL.Text := 'UPDATE tblSalesCommission SET IsPaid = "F" WHERE SaleID = ' + TEmployeeReportGUI(Self.Owner).sSaleID;
//    qrySales.Execute;
    qrySales.Close;
  end;
  self.Close;
end;

procedure TfrmCommissPopUp.FormCreate(Sender: TObject);
begin
  inherited;
  qrySales.Connection := CommonDbLib.GetSharedMyDacConnection;
  self.Caption := '';
  self.Icon.Empty;
end;

procedure TfrmCommissPopUp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  qrySales.Close;
  Action := caFree;
  
  //Notify;
end;

Initialization
  RegisterClassOnce(TfrmCommissPopUp);

end.
