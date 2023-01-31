unit SalesRepairList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton;

type
  TSalesRepairListGUI = class(TBaseListingGUI)
    qryMainRepairID: TIntegerField;
    qryMainCreationDate: TDateField;
    qryMainDone: TWideStringField;
    qryMainJobDueDate: TDateTimeField;
    qryMainConverted: TWideStringField;
    qryMainStatus: TWideStringField;
    qryMainSOGlobalRef: TWideStringField;
    qryMainQuoteGlobalRef: TWideStringField;
    qryMaindescription: TWideStringField;
    qryMainCustomerDetails: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fiSaleId: Integer;
    fsSalestype: String;
    { Private declarations }
  public
    Property SaleID:Integer Read fiSaleId write fiSaleID;
    Property Salestype :String read fsSalestype write fsSalestype;
    Procedure RefreshQuery;override;
  end;


implementation

uses CommonLib;

{$R *.dfm}

procedure TSalesRepairListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fiSaleID:= 0;
end;

procedure TSalesRepairListGUI.FormShow(Sender: TObject);
begin
  inherited;
  Self.Caption := 'Repairs of ' +Salestype +' # ' + inttostr(SaleID);
  TitleLabel.Caption := 'Repairs of ' +Salestype +' # ' + inttostr(SaleID);
end;

procedure TSalesRepairListGUI.RefreshQuery;
begin
  Qrymain.Parambyname('SaleID').asInteger := fiSaleID;
  inherited;
end;

initialization
  RegisterClassOnce(TSalesRepairListGUI);

end.

