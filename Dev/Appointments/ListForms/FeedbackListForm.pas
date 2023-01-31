unit FeedbackListForm;

{

 Date     Version  Who  What
 -------- -------- ---  --------------------------------------------------------
 07/09/05  1.00.01 IJB  Modified to use new filtering on base listing.
 27/09/05  1.00.02 DSP  Added 'Notes' field to the display list.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, ExtCtrls, ComCtrls,AdvOfficeStatusBar, ImgList, Menus, AdvMenus, PrintDAT,
  ActnList, wwDialog, Wwlocate, SelectionDialog, DNMPanel, MemDS, DBAccess,
  MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog,  wwdblook,
  Shader, kbmMemTable, DAScript, MyScript;

type
  TFeedbackListGUI = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainType: TWideStringField;
    qryMainID: TIntegerField;
    qryMainCusID: TIntegerField;
    qryMainTrainerID: TIntegerField;
    qryMainDate: TDateTimeField;
    qryMainCompany: TWideStringField;
    qryMainFeedbackNotes: TWideStringField;
    qryMainRep: TWideStringField;
    qryMainCancellation: TWideStringField;
    qryMainClass: TWideStringField;
    qryMainNotes: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
    procedure SetGridColumns; override;
  public
    { Public declarations }
  end;

implementation

uses
  CommonLib, FastFuncs;

{$R *.dfm}

procedure TFeedbackListGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('txtfrom1').AsDate := dtFrom.DateTime;
  qryMain.Params.ParamByName('txtto1').AsDate := dtTo.DateTime;
  qryMain.Params.ParamByName('txtfrom2').AsDate := dtFrom.DateTime;
  qryMain.Params.ParamByName('txtto2').AsDate := dtTo.DateTime;
  inherited;
end;

procedure TFeedbackListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(Qrymainglobalref.fieldname);
  RemoveFieldfromGrid(QrymainId.fieldname);
  RemoveFieldfromGrid(QrymainCusID.fieldname);
  RemoveFieldfromGrid(QrymainTrainerId.fieldname);
end;

procedure TFeedbackListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin
        GroupFilterString := '(FeedbackNotes=Null)';
      end;
    1: 
      begin
        GroupFilterString := '(FeedbackNotes<>Null)';
      end;
    2: 
      begin
      end;
  end;
  inherited;
end;

procedure TFeedbackListGUI.FormShow(Sender: TObject);
begin
  inherited;
  if self.fbFormOpenedOk then begin
    grpFiltersClick(self);
  end;
end;

procedure TFeedbackListGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + Trim(qryMain.FieldByName('Type').AsString);
  inherited;
end;

procedure TFeedbackListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TFeedbackListGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TFeedbackListGUI.cmdNewClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TFeedbackListGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

initialization
  RegisterClassOnce(TFeedbackListGUI);
end.
