// Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  //07/09/05  1.00.## ISB	Modified To Work With New Filtering on Baselisting.
  //20/10/05  1.00.01 DLS Added RegisterClass

unit FaxSpoolList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, DBAccess, MyAccess,ERPdbComponents, MemDS,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable;

type
  TFaxSpoolListingGUI = class(TBaseListingGUI)
    qryMainFaxSpoolID: TAutoIncField;
    qryMainSpooledAt: TDateTimeField;
    qryMainCurrentStatus: TWideStringField;
    qryMainFaxBy: TWideStringField;
    qryMainFaxTo: TWideStringField;
    qryMainFaxNumber: TWideStringField;
    qryMainStartedSending: TDateTimeField;
    qryMainCompletedSending: TDateTimeField;
    qryMainDialAttempts: TIntegerField;
    qryMainPriority: TIntegerField;
    qryMainCancelled: TWideStringField;
    qryMainSentOk: TWideStringField;
    qryMainTransType: TWideStringField;
    qryMainTransGlobal: TWideStringField;
    qryMainRetryWait: TIntegerField;
    qryMainGlobalRef: TWideStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure btnRefreshClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  FaxSpoolListingGUI: TFaxSpoolListingGUI;

implementation

uses
  CommonLib, AppEnvironment;

{$R *.dfm}

procedure TFaxSpoolListingGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
//  FaxSpoolListingGUI := nil;
end;

procedure TFaxSpoolListingGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin
        GroupFilterString := '(Cancelled <> ' + QuotedStr('T') + ') AND (SentOK <> ' + QuotedStr('T') + ')';
      end;
    1: 
      begin
        GroupFilterString := '(Cancelled = ' + QuotedStr('T') + ')';
      end;
    2: 
      begin
        GroupFilterString := '(SentOK = ' + QuotedStr('T') + ')';
      end;
  end;
  inherited;
end;

procedure TFaxSpoolListingGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMain.Fields.FieldByName('TransType').AsString;
  inherited;
end;

procedure TFaxSpoolListingGUI.btnRefreshClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

initialization
  RegisterClassOnce(TFaxSpoolListingGUI);
end.
