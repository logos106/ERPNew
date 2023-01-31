unit HireSalesList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  THireSalesListGUI = class(TBaseListingGUI)
    qryMainSaleID: TIntegerField;
    qryMainCustomerName: TWideStringField;
    qryMainSaleDate: TDateField;
    qryMainTotalAmountInc: TFloatField;
    qryMainType: TWideStringField;
    qryMainShipped: TFloatField;
    qryMainIsBO: TBooleanField;
    lblhireID: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
  private
    fsHireRef: String;
  Protected
    procedure SetGridColumns; Override;

  public
    Property HireRef:String read fsHireRef write fsHireRef;
    Procedure RefreshQuery;Override;
  end;

implementation

uses CommonLib, BusobjHire;

{$R *.dfm}
procedure THireSalesListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HireRef := '';
end;

procedure THireSalesListGUI.FormShow(Sender: TObject);
begin
  inherited;
  if HireRef <> '' then lblhireID.caption := 'Hire # ' + inttostr(THire.idToggle(HireRef));
end;

procedure THireSalesListGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMainType.asString;
  inherited;

end;

procedure THireSalesListGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryMainIsBO.AsBoolean   := qryMainShipped.AsFloat =0;
end;

procedure THireSalesListGUI.RefreshQuery;
begin
  closeDB(Qrymain);
  Qrymain.ParamByName('HireGlobalref').AsString :=  HireRef;
  inherited;
end;

procedure THireSalesListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('Shipped');

end;

initialization
  RegisterClassOnce(THireSalesListGUI);

end.
