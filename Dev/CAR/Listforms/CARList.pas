unit CARList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TCarListGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainComplaintFrom: TWideStringField;
    qryMaincontactName: TWideStringField;
    qryMainComplaintType: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainEnteredBy: TWideStringField;
    qryMainReportedDate: TDateTimeField;
    qryMainSalesID: TIntegerField;
    qryMainProductionBuild: TWideStringField;
    qryMainProductionBuildDesc: TWideStringField;
    qryMainSupplierName: TWideStringField;
    qryMainPOID: TIntegerField;
    qryMainDescriptionofProblem: TWideStringField;
    qryMainImprovementSuggestion: TWideStringField;
    qryMainRep: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
  private
    { Private declarations }
  Protected
    procedure SetGridColumns; override;
  public
    Procedure RefreshQuery;Override;
  end;

implementation

uses CommonLib, CommonFormLib;

{$R *.dfm}
{ TCarListGUI }

procedure TCarListGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenerpForm('TfmCAR' , 0);
end;

procedure TCarListGUI.RefreshQuery;
begin
  Qrymain.ParamByName('DateFrom').AsDateTime:= filterDateFrom;
  Qrymain.ParamByName('DateTo').AsDateTime:= filterDateTo;
  inherited;

end;

procedure TCarListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainID.FieldName);
end;

initialization
  RegisterClassOnce(TCarListGUI);

end.

