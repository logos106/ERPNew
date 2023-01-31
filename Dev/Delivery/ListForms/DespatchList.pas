{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 19/08/05  1.00.01 BJ   Spelling mistake corrected - Dispatch was spelled Despatch .
 07/09/05  1.00.## ISB	Modified To Work With New Filtering on Baselisting.
 }
unit DespatchList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls, StdCtrls, ExtCtrls, DNMPanel, MemDS, DBAccess, MyAccess,
  wwdbdatetimepicker, ProgressDialog, CustomInputBox, wwdblook, Shader,
  kbmMemTable;

type
  TDespatchRunListGUI = class(TBaseListingGUI)
    qryMainRunName: TStringField;
    qryMainRunID: TIntegerField;
    qryMainOperator: TStringField;
    qryMainRunDate: TDateField;
    qryMainClassName: TStringField;
    qryMainIsPublicHoliday: TStringField;
    qryMainInvoicesGenerated: TStringField;
    qryMainDone: TStringField;
    qryMainDespatchID: TIntegerField;
    qryMainRescheduled: TStringField;
    qryMainRescheduleDate: TDateField;
    qryMainGlobalRef: TStringField;
    procedure grpFiltersClick(Sender: TObject); override;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qryMainAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
  public
    { Public declarations }
  end;

//var
//  DespatchRunListGUI: TDespatchRunListGUI;

implementation

uses CommonLib;

{$R *.dfm}

procedure TDespatchRunListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin
        GroupFilterString := 'Done = ' + QuotedStr('F');
      end;
    1:
      begin
        GroupFilterString := 'Done = ' + QuotedStr('T');
      end;
  end;
  inherited;
end;

procedure TDespatchRunListGUI.RefreshQuery;
begin
  qryMain.Close;
  qryMain.Params.ParamByName('xDateFrom').AsDateTime := dtFrom.DateTime;
  qryMain.params.ParamByName('xDateTo').AsDateTime := dtTo.DateTime;
  LabelGridFromFieldNames := false;
  inherited;
end;

procedure TDespatchRunListGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TDespatchRunListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.IndexFieldNames := QuotedStr('RunName') + ' ASC CIS ; ' + QuotedStr('RunDate') + ' ASC CIS';
  BaseIndexFieldNames := QuotedStr('RunName') + ' ASC CIS';
end;
initialization
  RegisterClassOnce(TDespatchRunListGUI);

end.
