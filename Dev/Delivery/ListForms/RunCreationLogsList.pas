// Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  //07/09/05  1.00.## ISB	Modified To Work With New Filtering on Baselisting.

unit RunCreationLogsList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, DB, DBAccess, MyAccess, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls,
  DNMPanel, ComCtrls, DateUtils, ProgressDialog, CustomInputBox, wwdblook,
  Shader, kbmMemTable;

type
  TRunCreationLogsListGUI = class(TBaseListingGUI)
    qryMainDetail: TIntegerField;
    qryMainRunDate: TDateField;
    qryMainState: TStringField;
    qryMainCompany: TStringField;
    qryMainContact: TStringField;
    qryMainDescription: TStringField;
    qryMainDespatchRunID: TIntegerField;
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
    procedure actExecuteFilterExecute(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject); override;
    procedure grdMainTitleButtonClick(Sender: TObject; AFieldName: string);

  private
    { Private declarations }

  public
    { Public declarations }
    procedure RefreshQuery; override;

  end;

  //var
  //  RunCreationLogsListGUI: TRunCreationLogsListGUI;

const
  LOG_TABLENAME = 'logs';

implementation

{$R *.dfm}

uses
  CommonDbLib, CommonLib;

{ TRunCreationLogsListGUI }

procedure TRunCreationLogsListGUI.RefreshQuery;
begin
  qryMain.SQL.Clear;
  qryMain.SQL.Add('SELECT * FROM `' + GetUserTemporaryTableName(LOG_TABLENAME) + '`');
  
  inherited;
end;

procedure TRunCreationLogsListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.IndexFieldNames := 'RunDate ASC CIS; DespatchRunID ASC CIS; Detail ASC';;
  BaseIndexFieldNames := 'RunDate ASC CIS; DespatchRunID ASC CIS; Detail ASC';;
  SwapBaseIndexFieldPriority := true;
end;

procedure TRunCreationLogsListGUI.FormCreate(Sender: TObject);
begin
  Self.fbIgnoreAccessLevels := true;
  inherited;
end;

procedure TRunCreationLogsListGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if qryMain.FieldByName('Detail').AsInteger = 0 then begin
    AFont.Style := [fsBold];
  end;
end;

procedure TRunCreationLogsListGUI.actExecuteFilterExecute(Sender: TObject);
begin
  if grpFilters.ItemIndex <= 1 then begin
    AppendFilter := '';
  end else begin
    AppendFilter := ' OR (Detail = 0)';
  end;

  inherited;
end;

procedure TRunCreationLogsListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin
        GroupFilterString := 'Detail = 0';
      end;

    1: 
      begin
        GroupFilterString := '(Detail = 0 AND DespatchRunID > 0)';
      end;

    2: 
      begin
        GroupFilterString := 'Detail <= 1';
        qryMain.IndexFieldNames := 'RunDate ASC CIS; DespatchRunID ASC CIS; Detail ASC';
        BaseIndexFieldNames := 'RunDate ASC CIS; DespatchRunID ASC CIS; Detail ASC';
        SwapBaseIndexFieldPriority := true;
      end;

    3: 
      begin
        GroupFilterString := '(DespatchRunID > 0 AND Detail <= 1)';
        qryMain.IndexFieldNames := 'RunDate ASC CIS; DespatchRunID ASC CIS; Detail ASC';;
        BaseIndexFieldNames := 'RunDate ASC CIS; DespatchRunID ASC CIS; Detail ASC';;
        SwapBaseIndexFieldPriority := true;
      end;
  end;
  inherited;
end;

procedure TRunCreationLogsListGUI.grdMainTitleButtonClick(Sender: TObject; AFieldName: string);
begin
  case grpFilters.ItemIndex of
    0: 
      begin
        BaseIndexFieldNames := '';
        SwapBaseIndexFieldPriority := false;
      end;

    1..3: 
      begin
        if SortColumnName <> AFieldName then begin
          qryMain.IndexFieldNames := 'RunDate ASC CIS; DespatchRunID ASC CIS; Detail ASC';;
          BaseIndexFieldNames := 'RunDate ASC CIS; DespatchRunID ASC CIS; Detail ASC';;
        end;
        SwapBaseIndexFieldPriority := true;
      end;
  end;

  inherited;
end;

initialization
  RegisterClassOnce(TRunCreationLogsListGUI);
end.
