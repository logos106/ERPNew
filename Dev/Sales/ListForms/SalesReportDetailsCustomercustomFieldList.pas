unit SalesReportDetailsCustomercustomFieldList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, salesreportDetails, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup;

type
  TSalesReportDetailsCustomercustomFieldListGUI = class(TsalesreportDetailsGUI)
    qryMainCUSTFLD1: TWideStringField;
    qryMainCUSTFLD2: TWideStringField;
    qryMainCUSTFLD3: TWideStringField;
    qryMainCUSTFLD4: TWideStringField;
    qryMainCUSTFLD5: TWideStringField;
    qryMainCUSTFLD6: TWideStringField;
    qryMainCUSTFLD7: TWideStringField;
    qryMainCUSTFLD8: TWideStringField;
    qryMainCUSTFLD9: TWideStringField;
    qryMainCUSTFLD10: TWideStringField;
    qryMainCUSTFLD11: TWideStringField;
    qryMainCUSTFLD12: TWideStringField;
    qryMainCUSTFLD13: TWideStringField;
    qryMainCUSTFLD14: TWideStringField;
    qryMainCUSTFLD15: TWideStringField;
    qryMainCUSTDATE1: TDateField;
    qryMainCUSTDATE2: TDateField;
    qryMainCUSTDATE3: TDateField;
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

uses CommonLib;

{$R *.dfm}
procedure TSalesReportDetailsCustomercustomFieldListGUI.FormCreate(Sender: TObject);
begin
  NonSearchMode := True;
  inherited;
end;

procedure TSalesReportDetailsCustomercustomFieldListGUI.FormShow(Sender: TObject);
begin
  inherited;
  TitleLabel.Caption := 'Customer Custom Fields'
end;

procedure TSalesReportDetailsCustomercustomFieldListGUI.SetGridColumns;
begin
  inherited;
  SetUpcustomFields('Cust');
end;
procedure TSalesReportDetailsCustomercustomFieldListGUI.Extrafields;
begin
  Qrymain.SQL.add('C.CUSTFLD1	as	CUSTFLD1	,  ');
  Qrymain.SQL.add('C.CUSTFLD2	as	CUSTFLD2	,');
  Qrymain.SQL.add('C.CUSTFLD3	as	CUSTFLD3	,');
  Qrymain.SQL.add('C.CUSTFLD4	as	CUSTFLD4	,');
  Qrymain.SQL.add('C.CUSTFLD5	as	CUSTFLD5	,');
  Qrymain.SQL.add('C.CUSTFLD6	as	CUSTFLD6	,');
  Qrymain.SQL.add('C.CUSTFLD7	as	CUSTFLD7	,');
  Qrymain.SQL.add('C.CUSTFLD8	as	CUSTFLD8	,');
  Qrymain.SQL.add('C.CUSTFLD9	as	CUSTFLD9	,');
  Qrymain.SQL.add('C.CUSTFLD10	as	CUSTFLD10	,');
  Qrymain.SQL.add('C.CUSTFLD11	as	CUSTFLD11	,');
  Qrymain.SQL.add('C.CUSTFLD12	as	CUSTFLD12	,');
  Qrymain.SQL.add('C.CUSTFLD13	as	CUSTFLD13	,');
  Qrymain.SQL.add('C.CUSTFLD14	as	CUSTFLD14	,');
  Qrymain.SQL.add('C.CUSTFLD15	as	CUSTFLD15	,');
  Qrymain.SQL.add('C.CUSTDATE1	as	CUSTDATE1	,');
  Qrymain.SQL.add('C.CUSTDATE2	as	CUSTDATE2	,');
  Qrymain.SQL.add('C.CUSTDATE3	as	CUSTDATE3	,');
end;

initialization
  RegisterClassOnce(TSalesReportDetailsCustomercustomFieldListGUI);

end.

