unit frmMailMergeHistory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript,
  CustomInputBox, wwcheckbox;

type
  TfrmMailMergeHistoryList = class(TBaseListingGUI)
    qryMainMailMergeID: TIntegerField;
    qryMainRecipientID: TIntegerField;
    qryMainMMGroup: TWideStringField;
    qryMainDateSent: TDateTimeField;
    qryMainDocumentName: TWideStringField;
    qryMainSuccess: TWideStringField;
    qryRecipientLookup: TERPQuery;
    qryMainRecipientName: TWideStringField;
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
  public
    { Public declarations }
  end; 

implementation

uses
  CommonLib;
{$R *.dfm}

procedure TfrmMailMergeHistoryList.RefreshQuery;
begin
  qryMain.Params.ParamByName('dtFrom').AsDate := dtFrom.DateTime;
  qryMain.Params.ParamByName('dtTo').AsDate := dtTo.DateTime;
  inherited;
end;

procedure TfrmMailMergeHistoryList.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmMailMergeHistoryList.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmMailMergeHistoryList.cmdNewClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmMailMergeHistoryList.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

initialization
  RegisterClassOnce(TfrmMailMergeHistoryList);

end.
