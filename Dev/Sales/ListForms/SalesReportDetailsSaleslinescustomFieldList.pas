unit SalesReportDetailsSaleslinescustomFieldList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, salesreportDetails, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup;

type
  TSalesReportDetailsSaleslinescustomFieldListGUI = class(TsalesreportDetailsGUI)
    qryMainSalesLinesCustField1: TWideStringField;
    qryMainSalesLinesCustField2: TWideStringField;
    qryMainSalesLinesCustField3: TWideStringField;
    qryMainSalesLinesCustField4: TWideStringField;
    qryMainSalesLinesCustField5: TWideStringField;
    qryMainSalesLinesCustField6: TWideStringField;
    qryMainSalesLinesCustField7: TWideStringField;
    qryMainSalesLinesCustField8: TWideStringField;
    qryMainSalesLinesCustField9: TWideStringField;
    qryMainSalesLinesCustField10: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  Protected
    procedure SetGridColumns; Override;
    procedure Extrafields;Override;
  public
    { Public declarations }
  end;


implementation

uses Busobjcustomfields, CommonLib;

{$R *.dfm}
procedure TSalesReportDetailsSaleslinescustomFieldListGUI.FormCreate(Sender: TObject);
begin
  NonSearchMode := True;
  inherited;
end;

procedure TSalesReportDetailsSaleslinescustomFieldListGUI.FormShow(Sender: TObject);
var
  SaleSLinesCustomFieldList :TSaleSLinesCustomFieldList;
  ctr:Integer;
begin
  inherited;
  TitleLabel.caption := 'Sales Lines Custom Fields';
  SaleSLinesCustomFieldList := TSaleSLinesCustomFieldList.CreateWithNewConn(self);
  try
    SaleSLinesCustomFieldList.Load;
    SaleSLinesCustomFieldList.First;
    for ctr:= 1 to 10 do begin
      if SaleSLinesCustomFieldList.Eof then begin
        GuiPrefs.DbGridElement[grdMain].RemoveField('SALESLINESCUSTFIELD'+trim(inttostr(ctr)));
      end else begin
        Qrymain.FindField('SALESLINESCUSTFIELD'+trim(inttostr(ctr))).DisplayLabel := SaleSLinesCustomFieldList.Description;
      end;
      SaleSLinesCustomFieldList.next;
    end;
  finally
    Freeandnil(SaleSLinesCustomFieldList);
  end;

end;

procedure TSalesReportDetailsSaleslinescustomFieldListGUI.SetGridColumns;
begin
  inherited;
end;
procedure TSalesReportDetailsSaleslinescustomFieldListGUI.Extrafields;
begin
  Qrymain.SQL.add('SL.SalesLinesCustField1	as	SalesLinesCustField1	,');
  Qrymain.SQL.add('SL.SalesLinesCustField2	as	SalesLinesCustField2	,');
  Qrymain.SQL.add('SL.SalesLinesCustField3	as	SalesLinesCustField3	,');
  Qrymain.SQL.add('SL.SalesLinesCustField4	as	SalesLinesCustField4	,');
  Qrymain.SQL.add('SL.SalesLinesCustField5	as	SalesLinesCustField5	,');
  Qrymain.SQL.add('SL.SalesLinesCustField6	as	SalesLinesCustField6	,');
  Qrymain.SQL.add('SL.SalesLinesCustField7	as	SalesLinesCustField7	,');
  Qrymain.SQL.add('SL.SalesLinesCustField8	as	SalesLinesCustField8	,');
  Qrymain.SQL.add('SL.SalesLinesCustField9	as	SalesLinesCustField9	,');
  Qrymain.SQL.add('SL.SalesLinesCustField10	as	SalesLinesCustField10	,');
end;

initialization
  RegisterClassOnce(TSalesReportDetailsSaleslinescustomFieldListGUI);

end.

