unit frmPCCStarCardReport;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 29/08/06  1.00.01 DSP  Added a 'From' date picker and modified SQL.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DBAccess, MyAccess,
  SelectionDialog, AppEvnts, DB,  ExtCtrls, StdCtrls, wwdblook,
  ComCtrls, DNMSpeedButton, DNMPanel, Shader;

type
  TPCCStarCardReport = class(TBaseInputGUI)
    Bevel1: TBevel;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Label1: TLabel;
    dpFrom: TDateTimePicker;
    Label2: TLabel;
    dpTo: TDateTimePicker;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
    Function GetConfiguredStarCardCustomerCustomFieldNo(Var EqualTo : String) : integer;
  public
    { Public declarations }
  end;

var
  PCCStarCardReport: TPCCStarCardReport;

implementation

uses FastFuncs,CommonDbLib,  AppEnvironment, CommonLib;

{$R *.dfm}

procedure TPCCStarCardReport.FormCreate(Sender: TObject);
begin
  inherited;
  dpFrom.Date := Now;
  dpTo.Date := Now;
end;

procedure TPCCStarCardReport.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

function TPCCStarCardReport.GetConfiguredStarCardCustomerCustomFieldNo(
  var EqualTo: String): integer;
Var qryConf : TMyQuery;
begin
  result := 0;
  qryConf := TMyQuery.Create(nil);
  try
    qryConf.Options.FlatBuffers := True;
    qryConf.Connection := GetSharedMyDacConnection;
    qryConf.SQL.Text := 'SELECT IC.CustomerCustFieldNo, IC.CustFieldEqualTo'+
             ' FROM tblPCCImportConfigure IC '+
             ' WHERE IC.Active = "T" ';
    qryConf.Open;
    if qryConf.RecordCount > 0 then begin
      Result := qryConf.FieldByName('CustomerCustFieldNo').AsInteger;
      EqualTo := qryConf.FieldByName('CustFieldEqualTo').AsString;
    end;
  finally
    FreeAndNil(qryConf);
  end;
end;

procedure TPCCStarCardReport.btnOKClick(Sender: TObject);
Var CustFieldNo : integer;
    CustFieldEqualTo : string;
    sSQL : string;
begin
  inherited;
  CustFieldNo := GetConfiguredStarCardCustomerCustomFieldNo(CustFieldEqualTo);

  if (CustFieldNo > 0) then begin
    sSQL :=
    '  SELECT                                                                        '+
    ' CMaster.Company, CMaster.ABN, CMaster.Street, CMaster.Street2,                 '+
    ' CMaster.Suburb, CMaster.State, CMaster.Country,                                '+
    ' RC.ChildClientID, C.ClientID, C.CardNumber,                                    '+
    ' S.SaleDate, S.CustomerName, SL.ProductName,                                    '+
    ' SL.LinePriceInc, SL.UnitOfMeasureQtySold, SL.LineTax, SL.TotalLineAmountInc,   '+
    ' SL.SalesLinesCustField1, SL.SalesLinesCustField2, SL.SalesLinesCustField3,     '+
    ' SL.SalesLinesCustField4, SL.SalesLinesCustField5, SL.SalesLinesCustField6,     '+
    ' SL.SalesLinesCustField7, SL.SalesLinesCustField8, SL.SalesLinesCustField9,     '+
    ' SL.SalesLinesCustField10,                                                      '+
      QuotedStr(DateToStr(dpFrom.Date)) + ' AS DateFrom,                             '+
      QuotedStr(DateToStr(dpTo.Date)) + ' AS DateTo                                  '+
    ' FROM tblSales S                                                                '+
    ' INNER JOIN tblClients C ON S.CLientID = C.CLientID                             '+
    ' INNER JOIN tblSalesLines SL ON SL.SaleID = S.SaleID                            '+
    ' INNER JOIN tblrelatedclients RC ON RC.ChildClientID = C.ClientID               '+
    ' INNER JOIN tblClients CMaster ON RC.MasterClientID = CMaster.ClientID          '+
    ' WHERE S.Paid = "F"                                                             '+
    ' AND S.IsInvoice = "T"                                                          '+
    ' AND S.SaleDate BETWEEN ' + QuotedStr(FormatDateTime('yyyy-mm-dd', dpFrom.DateTime)) +
    ' AND ' + QuotedStr(FormatDateTime('yyyy-mm-dd', dpTo.DateTime)) +
    ' AND C.CustFld' + FastFuncs.IntToStr(CustFieldNo) + ' = ' + QuotedStr(CustFieldEqualTo)   +
    ' ORDER BY C.Company, S.SaleDate                                                 ';
    fbReportSQLSupplied := true;
    PrintTemplateReport('Starcard Invoice Statement',sSQL, not AppEnv.Employee.ShowPreview, 1);
  end  
  else begin
    CommonLib.MessageDlgXP_Vista('Custom field has not been defined for client.',mtInformation,[mbOk],0);
  end;
end;

procedure TPCCStarCardReport.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

initialization
  RegisterClassOnce(TPCCStarCardReport);

end.
