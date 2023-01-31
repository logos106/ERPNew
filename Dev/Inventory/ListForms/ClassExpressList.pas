unit ClassExpressList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TClassExpressListGUI = class(TBaseListingGUI)
    qryMainClassId: TIntegerField;
    qryMainClassname: TWideStringField;
    qryMainACtive: TWideStringField;
    procedure FormCreate(Sender: TObject);
  private
  Protected
    procedure SetGridColumns; Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    procedure ExtraSetupFormInPanel;override;
  public
  end;


implementation

uses CommonLib;

{$R *.dfm}

procedure TClassExpressListGUI.ExtraSetupFormInPanel;
begin
  inherited;
  btnRequery.visible := True;
  lblcustomReport.visible := True;
  cboCustomReports.visible := True;
  grpFilters.visible := True;
  grpFilters.Parent := pnlbuttons;
end;

procedure TClassExpressListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := False;
end;

procedure TClassExpressListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainclassId.fieldname);
end;

procedure TClassExpressListGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
end;

procedure TClassExpressListGUI.WriteGuiPrefExtra;
begin
  inherited;

end;

initialization
  RegisterClassOnce(TClassExpressListGUI);

end.
