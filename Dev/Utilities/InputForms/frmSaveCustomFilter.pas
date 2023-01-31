unit frmSaveCustomFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DB, DBAccess, MyAccess,ERPdbComponents,
  SelectionDialog, AppEvnts, ExtCtrls, BusobjCustomfilter, DNMSpeedButton,
  StdCtrls, DBCtrls, Mask, DNMPanel, MemDS, wwcheckbox, 
  wwdbedit, Shader, busobjbase, ImgList, ProgressDialog;

type
  TButtonclick = procedure  of Object;
  TfmSaveCustomFilter = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    btnClose: TDNMSpeedButton;
    btnCompleted: TDNMSpeedButton;
    qryListReports: TERPQuery;
    qryListReportsID: TIntegerField;
    qryListReportsReportName: TWideStringField;
    qryListReportsFilterStatement: TWideMemoField;
    qryListReportsActive: TWideStringField;
    qryListReportsAllUsers: TWideStringField;
    qryListReportsUserID: TIntegerField;
    dsListReports: TDataSource;
    qryListReportsFilterName: TWideStringField;
    Label32: TLabel;
    chkActive: TwwCheckBox;
    Label3: TLabel;
    wwCheckBox1: TwwCheckBox;
    btnPreview: TDNMSpeedButton;
    wwDBEdit1: TwwDBEdit;
    Label4: TLabel;
    wwCheckBox2: TwwCheckBox;
    qryListReportsDefaultFilter: TWideStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    fCustomFilter :TCustomFilter;
    fPreviewreport :TButtonclick;
    fsReportName :String;
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    Property CustomFilter :TCustomFilter Read fCustomFilter Write fCustomFilter;
    Property PreviewReport :TButtonclick read fPreviewReport Write fPreviewreport;
    Property ReportName :String REad fsReportName Write fsReportName;
  end;

implementation

uses CommonLib, FormFactory, BusObjConst;

{$R *.dfm}

procedure TfmSaveCustomFilter.FormShow(Sender: TObject);
var
    FilterString :STring;
begin
  DisableForm;
  try
    inherited;
    FilterString := CustomFilter.filterStatement;
    if not Assigned(fCustomFilter) then CustomFilter := TCustomFilter.Create(Self);
    CustomFilter.Load(KeyId);
    if KeyId = 0 then CustomFilter.New;
    CustomFilter.filterStatement:= FilterString;
    CustomFilter.connection.BeginTransaction;
    Self.Caption := 'Custom Filter : ' + ReportName;
  finally
    EnableForm;
  end;  
end;

procedure TfmSaveCustomFilter.btnCompletedClick(Sender: TObject);
begin
  inherited;
    if CustomFilter.Save then begin
        CustomFilter.connection.CommitTransaction;
        Self.Close;
    end;
end;

procedure TfmSaveCustomFilter.FormCreate(Sender: TObject);
begin
  fbIgnoreAccessLevels := true;
  inherited;
  fPreviewreport := nil;
  fCustomFilter := TCustomFilter.Create(Self);
  fCustomFilter.connection := TMydacDataconnection.Create(CustomFilter);
  fCustomFilter.BusObjEvent :=DoBusinessObjectEvent;
  TMydacDataconnection(CustomFilter.Connection).MyDacconnection := Myconnection;
  (*CustomFilter.Dataset := qrylistreports;*)
  qrylistreports.Connection :=Myconnection;
end;

procedure TfmSaveCustomFilter.btnPreviewClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    if CustomFilter.Save then begin
        CustomFilter.connection.CommitTransaction;
        if Assigned(fPreviewreport) then fPreviewreport;
        Self.Close;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfmSaveCustomFilter.btnCloseClick(Sender: TObject);
begin
  inherited;
  Self.close;
end;

procedure TfmSaveCustomFilter.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := cafree;
  inherited;
end;

procedure TfmSaveCustomFilter.FormDestroy(Sender: TObject);
begin
  CustomFilter.connection.RollbackTransaction;
  inherited;
end;

procedure TfmSaveCustomFilter.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
    inherited ;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TCustomFilter then TCustomFilter(Sender).Dataset := qrylistreports;
    end;
end;

initialization
  RegisterClassOnce(TfmSaveCustomFilter);

  with FormFact do begin
    RegisterMe(TfmSaveCustomFilter, 'TCustomFiltersListGUI_*=ID');
  end;
end.
