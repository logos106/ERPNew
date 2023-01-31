unit VATObligations;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel, VATObligationObj;

type
  TVATObligationsGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainGlobalRef: TWideStringField;
    qryMainStartDate: TDateField;
    qryMainEndDate: TDateField;
    qryMainDueDate: TDateField;
    qryMainStatus: TWideStringField;
    qryMainActive: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    Obligation: TVATObligation;
  protected
    procedure RefreshQuery; override;
  public
    { Public declarations }
  end;

var
  VATObligationsGUI: TVATObligationsGUI;

implementation

{$R *.dfm}

{ TVATObligationsGUI }

procedure TVATObligationsGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  if Obligation.CheckObligations then
    RefreshQuery;
end;

procedure TVATObligationsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  Obligation := TVATObligation.Create;
  Obligation.AuthSuccessMessage := 'Click on "Get Obligations" to dowmload latest Obligation data.'
end;

procedure TVATObligationsGUI.FormDestroy(Sender: TObject);
begin
  inherited;
  Obligation.Free;
end;

procedure TVATObligationsGUI.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('Active');
end;

procedure TVATObligationsGUI.RefreshQuery;
begin
  qryMain.Close;
  if chkIgnoreDates.Checked then begin
    qryMain.ParamByName('DateFrom').AsDate := 0;
    qryMain.ParamByName('DateTo').AsDate := MaxDateTime;
  end
  else begin
    qryMain.ParamByName('DateFrom').AsDate := dtFrom.Date;
    qryMain.ParamByName('DateTo').AsDate := dtTo.Date;
  end;
  inherited;
end;

initialization
  RegisterClass(TVATObligationsGUI);

end.
