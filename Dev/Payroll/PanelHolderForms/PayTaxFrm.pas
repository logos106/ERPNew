unit PayTaxFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, Menus, ExtCtrls, StdCtrls,
  BusObjPayBase, DB, MemDS, DBAccess, MyAccess, ERPdbComponents, Grids,
  Wwdbigrd, Wwdbgrid, DNMPanel,frmPayFormsBase, ProgressDialog, ImgList,
  AdvMenus, DataState, AppEvnts, SelectionDialog;

type
  TfrmPayTax = Class(TfmPayFormsBase)
    pnlMain: TDNMPanel;
    Bevel1: TBevel;
    dsTaxList: TDataSource;
    qryTaxList: TERPQuery;
    qryTaxListTaxName: TWideStringField;
    qryTaxListEmpAmount: TFloatField;
    qryTaxListCoyAmount: TFloatField;
    grdTaxList: TwwDBGrid;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
  private
    fSubPay: TPayBase;
    procedure SetSubPay(const Value: TPayBase);
    procedure CalcTaxTotals;
  Protected
    Procedure InitForDefaultOptionsGrid;Override;
  public
    property SubPay:TPayBase  read fSubPay write SetSubPay ;
  end;

var
  frmPayTax: TfrmPayTax;

implementation

{$R *.dfm}

{ TfrmPayTax }

procedure TfrmPayTax.CalcTaxTotals;
var
  EmpAmount, CoyAmount: double;
begin
  EmpAmount := 0;
  CoyAmount := 0;
  qryTaxList.DisableControls;
  try
    qryTaxList.First;
    while not qryTaxList.Eof do begin
      EmpAmount := EmpAmount + qryTaxListEmpAmount.AsFloat;
      CoyAmount := CoyAmount + qryTaxListCoyAmount.AsFloat;
      qryTaxList.Next;
    end;
    qryTaxList.First;
  finally
    qryTaxList.EnableControls;
  end;
  grdTaxList.ColumnByName(qryTaxListEmpAmount.FieldName).FooterValue := FloatToStrF(EmpAmount,ffFixed,15,2);
  grdTaxList.ColumnByName(qryTaxListCoyAmount.FieldName).FooterValue := FloatToStrF(CoyAmount,ffFixed,15,2);
end;

procedure TfrmPayTax.InitForDefaultOptionsGrid;
begin
  inherited;
  IncludeForDefaultOptions(grdTaxList);
end;

procedure TfrmPayTax.SetSubPay(const Value: TPayBase);
begin
  fSubPay := Value;
  qryTaxList.Connection := fSubPay.Connection.Connection;
  qryTaxList.ParamByName('PayID').AsInteger := fSubPay.PayID;
  qryTaxList.Open;
  Timer1.Enabled := true;
end;

procedure TfrmPayTax.Timer1Timer(Sender: TObject);
begin
  inherited;
  Timer1.Enabled := false;
  CalcTaxTotals;
end;

initialization
  RegisterClass(TfrmPayTax);


end.
