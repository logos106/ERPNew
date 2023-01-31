unit FixedAssetsServiceLogList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, MemDS, DBAccess, MyAccess,ERPdbComponents,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox;

type
  TServiceLogListGUI = class(TBaseListingGUI)
    qryMainServiceID: TAutoIncField;
    qryMainGlobalRef: TWideStringField;
    qryMainAssetCode: TWideStringField;
    qryMainAssetName: TWideStringField;
    qryMainServiceProvider: TWideStringField;
    qryMainServiceDate: TDateField;
    qryMainNextServiceDate: TDateField;
    qryMainServiceNotes: TWideStringField;
    qryMainAssetID: TIntegerField;
    qryMainDone: TWideStringField;
    grpDateFilteroption: TRadioGroup;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdNewClick(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject); override;
    procedure grpDateFilteroptionClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure SetGridColumns; Override;
    procedure RefreshQuery; override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;

  public
    { Public declarations }
  end;

//var
//  ServiceLogListGUI: TServiceLogListGUI;

implementation
 
uses frmFixedAssetServiceLogGUI, CommonLib;
{$R *.dfm}

procedure TServiceLogListGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
//  ServiceLogListGUI := nil;
end;

procedure TServiceLogListGUI.grpDateFilteroptionClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TServiceLogListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:  GroupFilterString := 'Done = ' + QuotedStr('T');
    1:  GroupFilterString := 'done = ' + QuotedStr('F');
  end;
  inherited;
end;

procedure TServiceLogListGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  DisableForm;
  try
    inherited;
    Form := GetComponentByClassName('TServiceLogGUI');
    if Assigned(Form) then begin //if has acess
      with TServiceLogGUI(Form) do begin
        AttachObserver(Self);
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  finally
    EnableForm;
  end;    
end;

procedure TServiceLogListGUI.ReadnApplyGuiPrefExtra;
var
  x: integer;
begin
      if GuiPrefs.Node.Exists('grpDateFilteroption') then begin
        x := GuiPrefs.Node['grpDateFilteroption.ItemIndex'].asInteger;
        if x > 0 then if grpDateFilteroption.Items.Count >= x then grpDateFilteroption.ItemIndex := x - 1;
      end;
end;

procedure TServiceLogListGUI.RefreshQuery;
begin
  if chkIgnoreDates.Checked or (not chkIgnoreDates.Visible) then begin
    qryMain.Params.ParamByName('txtfrom').AsDate := 0;
    qryMain.Params.ParamByName('txtto').AsDate := MaxDateTime;
  end
  else begin
    qryMain.Params.ParamByName('txtfrom').AsDate := dtFrom.DateTime;
    qryMain.Params.ParamByName('txtto').AsDate := dtTo.DateTime;
  end;
  qryMain.Params.ParamByName('FilterOn').asInteger := grpDateFilteroption.itemindex;
  inherited;
end;

procedure TServiceLogListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainServiceID.fieldname);
  RemoveFieldfromGrid(qryMainGlobalRef.fieldname);
  RemoveFieldfromGrid(qryMainAssetID.fieldname);
end;

procedure TServiceLogListGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['grpDateFilteroption.ItemIndex'].asInteger := grpDateFilteroption.ItemIndex + 1;
end;

procedure TServiceLogListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TServiceLogListGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TServiceLogListGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

initialization
  RegisterClassOnce(TServiceLogListGUI);
end.
