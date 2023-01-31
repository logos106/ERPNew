unit MarketingContactSelectionRangeList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls,
  DNMPanel, ComCtrls,AdvOfficeStatusBar, ProgressDialog,  wwdblook, Shader,
  kbmMemTable;

type
  TMarketingContactSelectionRangeListGUI = class(TBaseListingGUI)
    qryMainRangeSelectionId: TIntegerField;
    qryMainRangeDescription: TWideStringField;
    qryMainXMLData: TWideMemoField;
    qryMainActive: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainmsTimeStamp: TDateTimeField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override; 
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RefreshQuery; override;
  end;

implementation

{$R *.dfm}

uses frmMarketingContactSelectionRange, CommonLib;

procedure TMarketingContactSelectionRangeListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  DefaultMaxGridColumnWidth := 0;
  qryMain.ParamByName('Active').AsString := grpFilters.Items[grpFilters.ItemIndex];
end;

procedure TMarketingContactSelectionRangeListGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TMarketingContactSelectionRangeListGUI.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('XMLData');
end;

procedure TMarketingContactSelectionRangeListGUI.RefreshQuery;
begin
  inherited;
  //
end;


procedure TMarketingContactSelectionRangeListGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfmMarketingContactSelectionRange');
  if Assigned(Form) then begin
    with TfmMarketingContactSelectionRange(Form) do begin
      KeyId := 0;
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;  
end;

procedure TMarketingContactSelectionRangeListGUI.grpFiltersClick(Sender: TObject);
begin
  inherited;
  qryMain.Close;
  qryMain.ParamByName('Active').AsString := grpFilters.Items[grpFilters.ItemIndex];
  qryMain.Open;
end;

initialization
  RegisterClassOnce(TMarketingContactSelectionRangeListGUI);
end.
