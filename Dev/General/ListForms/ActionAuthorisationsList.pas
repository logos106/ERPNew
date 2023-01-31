unit ActionAuthorisationsList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, wwcheckbox,  wwdblook,
  Shader, kbmMemTable, DAScript, MyScript;

type
  TfrmActionAuthorisationsList = class(TBaseListingGUI)
    qryMainAuthorisationID: TIntegerField;
    qryMainType: TWideStringField;
    qryMainWho: TWideStringField;
    qryMainDate: TDateTimeField;
    qryMainActionSuccess: TWideStringField;
    chkSuccess: TwwCheckBox;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure actRefreshQryExecute(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;

  public
    { Public declarations }
  end;


implementation

uses CommonLib;

{$R *.dfm}
procedure TfrmActionAuthorisationsList.grpFiltersClick(Sender: TObject);
begin
  inherited;
    GroupFilterString := '';
  case grpFilters.ItemIndex of
    1:
      begin
        GroupFilterString := 'ActionSuccess=' + QuotedStr('T');
      end;
    2:
      begin
        GroupFilterString := 'ActionSuccess=' + QuotedStr('F');
      end;
  end;
  inherited;
end;

procedure TfrmActionAuthorisationsList.actRefreshQryExecute(
  Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfrmActionAuthorisationsList.RefreshQuery;
begin
  qryMain.Close;
  qryMain.ParambyName('dtFrom').AsDateTime := dtFrom.Date;
  qryMain.ParambyName('dtTo').AsDateTime := dtTo.Date + 0.999;



  inherited;
end;

initialization
  RegisterClassOnce(TfrmActionAuthorisationsList);
end.
