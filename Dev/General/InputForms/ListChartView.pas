unit ListChartView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ImageScroll, ExtCtrls, DNMPanel, Menus, AdvMenus,
  DataState, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, DB,
  DNMSpeedButton, StdCtrls, wwcheckbox, DataSourcePrefs,
  wwradiogroup, Mask, wwdbedit, Wwdotdot, Wwdbcomb, jpeg, GraphUtil, Shader,
  MemDS, ComCtrls,AdvOfficeStatusBar,ActnList,Wwdbgrid,
  MessageInterface,
  ChartViewDesigner,ChartViewPrintOptions,ChartViewSetup, GradientLabel,
  Contnrs, ImgList, DBCtrls, ProgressDialog;

type
  TListChartView = class(TBaseInputGUI)
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Bevel1: TBevel;
    Shader1: TShader;
    pnlActiveForm: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel1: TDNMPanel;
    ChartViewTabs: TPageControl;
    tabDesigner: TTabSheet;
    tabPrintOptions: TTabSheet;
    tabSetup: TTabSheet;
    qryCustomCharts: TERPQuery;
    btnNew: TDNMSpeedButton;
    Panel1: TPanel;
    sbButtons: TScrollBox;
    pnlButtons: TDNMPanel;
    sbCharts: TScrollBox;
    pnlCharts: TDNMPanel;
    btnPrint: TDNMSpeedButton;
    pnlBtnsTitle: TPanel;
    lblChartTemplateList: TGradientLabel;
    Bevel2: TBevel;
    qryCustomChartsID: TIntegerField;
    qryCustomChartsChartName: TWideStringField;
    qryCustomChartsReportClassName: TWideStringField;
    qryCustomChartsCustomFilterID: TIntegerField;
    qryCustomChartsGlobal: TWideStringField;
    qryCustomChartsDefaultChart: TWideStringField;
    qryCustomChartsChartBlob: TBlobField;
    qryCustomChartsX_LabelsField: TWideStringField;
    qryCustomChartsX_ChartedField: TWideStringField;
    qryCustomChartsY_ChartedField: TWideStringField;
    qryCustomChartsZ_ChartedField: TWideStringField;
    qryCustomChartsEmployeeID: TIntegerField;
    lblMsg: TLabel;
    btnExport: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure qryCustomChartsAfterScroll(DataSet: TDataSet);
    procedure qryCustomChartsChartNameChange(Sender: TField);
    procedure btnExportClick(Sender: TObject);
  private
    fChartDeleted:Boolean;
    SelectedChartName:string;
    FromFormName:String;
    FGrid: TwwDBGrid;
    (*FMsgHandler: TMsgHandler;*)
    ButtonCtr :Integer;
    TemplateButtonsList: TComponentList;
    Selectedbutton:TObject;
    procedure SetGrid(const Value: TwwDBGrid);
    procedure AddTabButtons;
    function AddButton(const ButtonCaption: string;
                        const ButtonTop: Integer;
                        const ParentPanel: TDNMPanel;
                        const OnClickEvent: TNotifyEvent;
                        Const ButtonColor: TColor = clWhite):TDNMSpeedButton;
    procedure MainButtonClick(Sender: TObject);
    procedure LoadChart;
    function newChartNameFortheClass: String;
    procedure Showchartname;
    procedure Lockchart;
    function userlockLockMessage: String;
    function LockChartofListtoshow(ReportClassName: String;
      var LockMsg: String): Boolean;

    procedure LockChartForm(LockMsg: String);

  Protected


  public

    FromFormClassName: String;
    Procedure AfterTranslate; Override;
    procedure TemplateButtonClick(Sender: TObject);
    procedure NewChart;
    procedure AddTemplateButtons;
    property Grid : TwwDBGrid read FGrid write SetGrid;
    property CurrentChartName:String read SelectedChartName write SelectedChartName; //may not be good to write: review later
    property ChartDeleted: Boolean read fChartDeleted write fChartDeleted;
    procedure ShowChartView(ds: TDataset; chartName:STring; ParentPnl:TDnmPanel; ReportClassname:String; Popupmenu :TPopupMenu = nil);   Overload;
    procedure OpenCustomCharts(ReportClassname:String);
    procedure unLockChartofList(ReportClassName:String);
    procedure SaveChart;
    class Function ShowChartView(charGrid : TwwDBGrid; ownerform :TForm; fSelectedChartName :String = ''):TListChartView; Overload;
    procedure PrintChart;

  published
    //##
    ChartDesigner: TChartDesigner;
    ChartPrintOptions: TChartPrintOptions;
    ChartSetup: TChartSetup;
    //##
     (*procedure ShowChartView(MsgObj: TMsgObj);Overload;*)

  end;

implementation

uses
  FastFuncs, BaseListingForm, CommonLib, CommonDbLib,TeeStore, Chart,
  Clipbrd, AppEnvironment,frmReportSelectorFrm,MessageConst,  tcConst;

const
  cMainButtonWidth = 110;
  cMainButtonHeight = 28;
  cMainButtonGap = 10;
  cTemplateButtonGap = 5;
  cMainButtonLeft = 10;
  cMainButtonTopStart = 10;
  cTemplateButtonColor = $00BCF8FC; //clBtnFace

  cTabCount = 3;
  cMaxRange = 6000;

var
  cButtonCaptions: array[1..cTabCount] of string = ('Data Setup',
                                                    'Designer',
                                                    'Print Options');

  {$R *.dfm}


procedure TListChartView.SetGrid(const Value: TwwDBGrid);
begin
  FGrid := Value;
end;
procedure TListChartView.OpenCustomCharts(ReportClassname:String);
begin
    closedb(qryCustomCharts);
    qryCustomCharts.ParamByName('xEmployeeID').AsInteger := 0;
    qryCustomCharts.ParamByName('xClassName').asString := ReportClassname;
    qryCustomCharts.Open;
end;

procedure TListChartView.ShowChartView(ds: TDataset; chartName:STring; ParentPnl:TDnmPanel; ReportClassname:String; Popupmenu :TPopupMenu = nil);
begin
  OpenCustomCharts(ReportClassname);
  if qryCustomCharts.Locate('ChartName',chartName,[loCaseInsensitive]) then begin
    LoadChart;
    ChartDesigner.DBChart1.Parent := ParentPnl;
    ChartDesigner.DBChart1.Series[0].Datasource := ds;
    FromFormName := ds.Owner.ClassName;
    ChartDesigner.DBChart1.RefreshDataSet(ds,ChartDesigner.DBChart1.Series[0]);
    ChartDesigner.DBChart1.OnDblClick := nil;
    ChartDesigner.DBChart1.Popupmenu := Popupmenu;
    LockChart;
  end else begin
    ParentPnl.Caption := 'You have deleted the chart ' +quotedstr(chartname) +'.  Please contact ERP';
  end;
end;

procedure TListChartView.AddTemplateButtons;
var
  ButtonTop: Integer;
  bm :Tbookmark;
begin
  bm :=qryCustomCharts.GetBookmark;
  try
    While TemplateButtonsList.Count <> 0 do
      TemplateButtonsList.Items[0].Free;
    If not qryCustomCharts.Active then Exit;
    ButtonTop := cMainButtonTopStart;
    qryCustomCharts.First;
    While Not qryCustomCharts.Eof do begin
        TemplateButtonsList.Add(
          AddButton(qryCustomCharts.fieldByName('ChartName').AsString, ButtonTop,pnlCharts,TemplateButtonClick,cTemplateButtonColor));
        ButtonTop := ButtonTop + cMainButtonHeight + cTemplateButtonGap;
        qryCustomCharts.Next;
    end;
  finally
    qryCustomCharts.gotobookmark(bm);
    qryCustomCharts.Freebookmark(bm);

  end;
end;

procedure TListChartView.AfterTranslate;
begin
  inherited;
  if assigned(Selectedbutton) then
    if Selectedbutton is TDNMSpeedButton then
      pnlActiveForm.caption := TDNMSpeedButton(Selectedbutton).caption;

end;

procedure TListChartView.AddTabButtons;
var
  ButtonTop: Integer;
  ButtonIndex: Integer;
begin
  ButtonTop := cMainButtonTopStart+10;
  for ButtonIndex := 1 to cTabCount do begin
      AddButton(cButtonCaptions[ButtonIndex], ButtonTop,pnlButtons,MainButtonClick);
      ButtonTop := ButtonTop + cMainButtonHeight + cMainButtonGap;
  end;
  sbButtons.Height := ButtonTop + cMainButtonGap;
end;

Function TListChartView.AddButton(const ButtonCaption: string; const ButtonTop: Integer; Const ParentPanel: TDNMPanel;
          Const OnClickEvent: TNotifyEvent; Const ButtonColor: TColor = clWhite):TDNMSpeedButton;
var
  Button: TDNMSpeedButton;
begin
  Button := TDNMSpeedButton.Create(Self);
  with Button do begin
    Left := cMainButtonLeft;
    Top := ButtonTop;
    Width := cMainButtonWidth;
    Height := cMainButtonHeight;
    Caption := ButtonCaption;
    Parent := ParentPanel;
    Alignment := taCenter;
    Color := ButtonColor;
    HotTrackColor := clBtnShadow;
    SlowDecease := True;
    Style := bsModern;
    OnClick := OnClickEvent;
    inc(ButtonCtr);
    hint := ButtonCaption;
    name := 'mainbutton'+inttostr(ButtonCtr);
    WordWrap := true;
  end;
  result := Button;
end;

procedure TListChartView.FormCreate(Sender: TObject);
begin
  inherited;
  Selectedbutton:=nil;
  ButtonCtr := 0;
  (*FMsgHandler := TMsgHandler.Create(Self);*)
  TemplateButtonsList := TComponentList.Create;
  pnlButtons.Color := TabColor;
  pnlCharts.Color := TabColor;
  pnlBtnsTitle.Color := TabColor;
(*  Shader1.FromColor := GetGradientColor(Self.ClassName).Color;
  Shader1.ToColorMirror := Shader1.FromColor;*)
  lblChartTemplateList.Color := Shader1.FromColor;
  AddTabButtons;
  ChartDesigner := TChartDesigner.Create(Self);
  ChartPrintOptions := TChartPrintOptions.Create(Self);
  ChartSetup := TChartSetup.Create(Self);
  ChartDesigner.SubForm.Parent := tabDesigner;
  ChartPrintOptions.SubForm.Parent := tabPrintOptions;
  ChartSetup.SubForm.Parent := tabSetup;
end;

procedure TListChartView.FormDestroy(Sender: TObject);
begin
  While TemplateButtonsList.Count <> 0 do
    TemplateButtonsList.Items[0].Free;
  FreeAndNil(TemplateButtonsList);
  { the following should not be freeed, they are owned by self }
//  FreeAndNil(ChartDesigner);
//  FreeAndNil(ChartPrintOptions);
//  FreeAndNil(ChartSetup);
  (*FreeAndNil(FMsgHandler);*)
  if Assigned(Grid) and (Grid.Owner is TBaseListingGUI) then
    TBaseListingGUI(Grid.Owner).Close;
  inherited;
end;

procedure TListChartView.btnCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TListChartView.btnExportClick(Sender: TObject);
var
  s: String;
begin
  inherited;
  s:=   'Delete from tblcustomcharts where ChartName = ' + Quotedstr(qrycustomchartsChartName.AsString) +' and ReportClassName = ' + quotedstr(qrycustomchartsReportClassName.AsString)+';'+NL+
        'INSERT IGNORE INTO `tblcustomcharts` (`ChartName`, `ReportClassName`, `Global`, `DefaultChart`, `ChartBlob`, `X_LabelsField`, `X_ChartedField`, `Y_ChartedField`, `Z_ChartedField`) ' +
        ' VALUES (' + Quotedstr(qrycustomchartsChartName.AsString) +',' +
                        quotedStr(qrycustomchartsReportClassName.AsString) +','+
                        quotedStr(qrycustomchartsGlobal.AsString) +','+
                        quotedStr(qrycustomchartsDefaultChart.AsString) +','+
                        QuotedStr(StringReplace(Trim(qrycustomchartsChartBlob.asString),#13#10 , '\r\n', [rfReplaceAll, rfIgnoreCase])) +', ' +
                        quotedStr(qrycustomchartsX_LabelsField.AsString) +','+
                        quotedStr(qrycustomchartsX_ChartedField.AsString) +','+
                        quotedStr(qrycustomchartsY_ChartedField.AsString) +','+
                        quotedStr(qrycustomchartsZ_ChartedField.AsString) +'); ';
  Clipboard.asText := s;
end;

procedure TListChartView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  unLockChartofList(FromFormName);
  inherited;
  if MyConnection.InTransaction then
    MyConnection.Rollback;
  Action := cafree;
end;

procedure TListChartView.MainButtonClick(Sender: TObject);
begin
  if Sender is TDNMSpeedButton then begin
    if not Sysutils.SameText(EnglishCaption(TDNMSpeedButton(Sender)), pnlActiveForm.Caption) then begin
      Selectedbutton:= sender;
      // Change Tabs
      If Sysutils.SameText(EnglishCaption(TDNMSpeedButton(Sender)),'Designer') then Begin
          ChartViewTabs.ActivePage := tabDesigner;
          pnlActiveForm.Caption := 'Designer';
          ChartDesigner.SubForm.Invalidate;
      end;
      If Sysutils.SameText(EnglishCaption(TDNMSpeedButton(Sender)),'Print Options') then Begin
          ChartViewTabs.ActivePage := tabPrintOptions;
          pnlActiveForm.Caption := 'Print Options';
          ChartPrintOptions.SubForm.Invalidate;
      end;
      If Sysutils.SameText(EnglishCaption(TDNMSpeedButton(Sender)),'Data Setup') then Begin
          ChartViewTabs.ActivePage := tabSetup;
          pnlActiveForm.Caption := 'Data Setup';
          ChartSetup.EnableSeriesDataChange;
          ChartSetup.SubForm.Invalidate;
      end;
    end;
  end;
end;

(*Procedure TListChartView.Newchart;
begin
  qryCustomCharts.Append;
  qryCustomChartschartname.asString := 'New chart';
  postDb(qryCustomCharts);
end;*)
procedure TListChartView.TemplateButtonClick(Sender: TObject);
begin
  if Sender is TDNMSpeedButton then begin
    If Sysutils.SameText(EnglishCaption(TDNMSpeedButton(Sender)),qryCustomCharts.FieldbyName('ChartName').AsString) then Exit;
    SaveChart;
    if qryCustomCharts.Locate('ChartName',EnglishCaption(TDNMSpeedButton(Sender)),[loCaseInsensitive]) then begin
      LoadChart;
    end;
    ChartSetup.EnableSeriesDataChange;
  end;
end;

procedure TListChartView.FormShow(Sender: TObject);
begin
  inherited;
  btnExport.Visible := devmode;
  if Grid.Owner is TfrmReportSelectorGUI then begin
    qryCustomCharts.ParamByName('xClassName').AsString := Grid.DataSource.Dataset.FieldByName('ReportClassName').asString;
  end else if Grid.Owner is TBaseListingGUI then begin
    qryCustomCharts.ParamByName('xClassName').AsString := Grid.Owner.ClassName;
  end;

  qryCustomCharts.ParamByName('xEmployeeID').AsInteger := Appenv.Employee.EmployeeID;
  qryCustomCharts.Open;
  qryCustomCharts.IndexFieldNames := QuotedStr('DefaultChart') + ' DESC CIS ; ' + QuotedStr('ChartName') + ' ASC CIS';
  if qryCustomCharts.RecordCount=0 then Newchart;
  //else if (Grid.Owner is TBaseListingGUI ) and (SelectedChartName = '') then Newchart;
  AddTemplateButtons;
  if (SelectedChartName <> '') then qryCustomCharts.Locate('Chartname' , SelectedChartName , []);
  ChartViewTabs.ActivePage := tabDesigner;
  pnlActiveForm.Caption := 'Designer';
  ChartDesigner.FormShow(nil);
  ChartPrintOptions.FormShow(nil);
  LoadChart;
  //qryCustomCharts.First; //"reset" the template buttons
  ChartSetup.FormShow(nil);
  if not MyConnection.InTransaction then
    MyConnection.StartTransaction;
  if (Grid.Owner is TBaseListingGUI ) and (SelectedChartName = '') then Newchart;
  Lockchart;
end;

Procedure TListChartView.Lockchart;
var
  bm :Tbookmark;
  LockMsg:String;
begin
  try
    userlock.Enabled:= True;
    bm :=qryCustomCharts.GetBookmark;
    try
      if Accesslevel <5 then begin
        qryCustomCharts.First;
        While Not qryCustomCharts.Eof do begin
              if not userlock.Lock('tblcustomcharts' , qryCustomChartsId.AsInteger ,'Chart View') then begin
                AccessLevel :=5;
                userlock.UnlockAllCurrentInstance;
                Exit;
              end;
            qryCustomCharts.Next;
        end;
      end;
    finally
      qryCustomCharts.gotobookmark(bm);
      qryCustomCharts.Freebookmark(bm);
    end;
  finally
    if Accesslevel <> 1 then begin
      Lockchartform(userlockLockMessage);
    end;
  end;
  if Accesslevel =1 then
    if not(LockChartofListtoshow(FromFormName, LockMsg)) then
      Lockchartform(LockMsg);
end;
Procedure TListChartView.LockChartForm(LockMsg:String);
var
  ctr:Integer;
begin
  timerMsg(lblMsg ,LockMsg  , 10);
  ChartDesigner.Enabled:= False;
  ChartSetup.Enabled:= False;
  ChartPrintOptions.Enabled:= False;

  For ctr:= 0 to ComponentCount-1 do
    if Components[ctr] is TControl then
      if (TControl(Components[ctr]) <> btnPrint)
          and (TControl(Components[ctr]) <>btnCancel)
          and (TControl(Components[ctr]) <> lblMsg)
          and (TControl(Components[ctr]) <> TitleLabel)
          and (TControl(Components[ctr]) <> pnlActiveForm) then
        TControl(Components[ctr]).Enabled:= False;
end;
Function TListChartView.userlockLockMessage:String;
begin
  result := userlock.LockMessage;
  result := replacestr(result,'Unable to update data.' , 'Chart(s) of ' + AppEnv.AccessLevels.GetFormDescription(FromFormClassName) +' are read-only.');
  result := replacestr(result,'this record' ,'Chart(s) of ' + AppEnv.AccessLevels.GetFormDescription(FromFormClassName) );
  result := replacestr(result,'Record' ,'Chart');
end;
procedure TListChartView.btnNewClick(Sender: TObject);
begin
  inherited;
  NewChart;
end;

procedure TListChartView.btnSaveClick(Sender: TObject);
var
  frm:TComponent;
begin
  inherited;

  SaveChart;
  if MyConnection.InTransaction then
    MyConnection.Commit;

  frm := nil;
  if ChartDeleted then begin
    if FormStillOpen('TfrmReportSelectorGUI') then frm := FindExistingComponent('TfrmReportSelectorGUI');
    if Assigned(frm) then PostMessage(TForm(frm).Handle, SX_CustomChartDeleted, 0, 0);
  end;
  Self.Close;
end;

procedure TListChartView.PrintChart;
begin
  ChartViewTabs.ActivePage := tabPrintOptions;
  pnlActiveForm.Caption := 'Print Options';
  ChartPrintOptions.BPrint.Click;
end;

procedure TListChartView.qryCustomChartsAfterScroll(DataSet: TDataSet);
begin
  inherited;
  showchartName;
end;

procedure TListChartView.qryCustomChartsChartNameChange(Sender: TField);
begin
  inherited;
  Showchartname;
end;
Procedure TListChartView.Showchartname;
begin
  if qryCustomCharts.ControlsDisabled then exit;
  if qryCustomCharts.Active and (qryCustomChartschartname.AsString <> '') then
    TitleLabel.Caption := qryCustomChartschartname.AsString
  else  TitleLabel.Caption := 'Chart View';
end;

procedure TListChartView.btnPrintClick(Sender: TObject);
begin
  inherited;
  PrintChart;
end;
function TListChartView.newChartNameFortheClass:String;
begin
  result := SeparateWords(copy(FromFormName , 1 , Length(FromFormName))) + ' New Chart';
  While  ( qryCustomCharts.Locate('ChartName' , result , [])) do result := result + '1';
end;

procedure TListChartView.NewChart;
var
  NewChartName:String;
begin
  NewChartname := NewChartnameFortheclass;
  qryCustomCharts.Append;
  qryCustomCharts.FieldByName('Global').AsString := 'T';
  qryCustomChartschartName.AsString := Newchartname;
  ChartViewTabs.ActivePage := tabSetup;
  pnlActiveForm.Caption := 'Data Setup';
  ChartDesigner.CreateNewChart;
  ChartSetup.EnableSeriesDataChange;
  PostDB(qryCustomCharts);
end;

procedure TListChartView.LoadChart;
var
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    qryCustomChartsChartBlob.SaveToStream(ms);
    ms.Position := 0;
    If ms.Size <>0 then Begin
      ChartDesigner.LoadChart(ms);
    end else
      ChartDesigner.CreateNewChart;
  finally
    FreeandNil(ms);
  end;
end;

procedure TListChartView.SaveChart;
var
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    If qryCustomChartsChartName.IsNull then Exit;
    if not (qryCustomCharts.State in [dsInsert, dsEdit]) then
      qryCustomCharts.Edit;
    TeeStore.SaveChartToStream(ChartDesigner.DBChart1,ms,True,True);
    ms.Position := 0;
    qryCustomChartsChartBlob.LoadFromStream(ms);
    qryCustomCharts.Post;
  finally
    FreeandNil(ms);
  end;
end;

Class function  TListChartView.ShowChartView(charGrid : TwwDBGrid; ownerform :TForm; fSelectedChartName :String = ''):TListChartView;
var
  LockMsg:String;
begin
  Result:= nil;
  result:= TListChartView(GetComponentByClassName('TListChartView', False , ownerform, False));
  if not(result.LockChartofListtoshow(charGrid.Owner.ClassName , LockMsg)) then begin
    MessageDlgXP_Vista(LockMsg, mtWarning, [mbOK], 0);
    freeandnil(Result);
    Exit;
  end;
  with result do begin

    Grid := charGrid;
    ChartSetup.ChartDataset := charGrid.DataSource.DataSet;
    if charGrid.Owner is TBaseListingGUI then begin
      FromFormName := TBaseListingGUI(charGrid.Owner).TitleLabel.Caption;
      FromFormClassName := TBaseListingGUI(charGrid.Owner).ClassName;
      SelectedChartName := TBaseListingGUI(charGrid.Owner).CustomChartToView;
    end else if charGrid.Owner is TfrmReportSelectorGUI then begin
      FromFormName := TfrmReportSelectorGUI(charGrid.Owner).TitleLabel.Caption;
      FromFormClassName := charGrid.DataSource.Dataset.FieldByName('ReportClassName').asString;
      SelectedChartName :=fSelectedChartName;
    end else begin
      SelectedChartName := fSelectedChartName;
    end;



    FormStyle := fsMDIChild;
    TitleLabel.caption := TitleLabel.Caption +' ('+FromFormName+')';

    BringToFront;

    if charGrid.Owner is TfrmReportSelectorGUI then begin
      if qryCustomCharts.Locate('ChartName',SelectedChartName,[loCaseInsensitive]) then begin
        LoadChart;
      end;
      ChartSetup.EnableSeriesDataChange;
    end;
  end;
end;

function TListChartView.LockChartofListtoshow(ReportClassName:String; var LockMsg:String):Boolean;
begin
  if UserLock.enabled =False then UserLock.enabled := True;
  result := UserLock.Lock(Reportclassname , 0 , 'chartview');
  if not result then begin
    LockMsg :=UserLock.LockMessage;
    LockMsg := replacestr(LockMsg , 'Unable to update data.' , 'Unable to view chart.');
    LockMsg := replacestr(LockMsg , 'this record' ,'this chart');
    LockMsg := replacestr(LockMsg , 'record' ,'chart');
  end;
end;
Procedure TListChartView.unLockChartofList(ReportClassName:String);
begin
  if UserLock.enabled =False then UserLock.enabled := True;
  UserLock.unLock(Reportclassname);
end;
initialization
  RegisterClassOnce(TListChartView);
end.


