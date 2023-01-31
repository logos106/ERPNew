unit DashBoard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, ExtCtrls, DNMPanel,  StdCtrls,
  Menus , DashBoardObj, DNMSpeedButton, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, SelectionDialog , GuiPrefsObj;

type
  TDashboardGUI = class(TBaseForm)
    pnl1        : TDNMPanel;
    Horizontal1 : TSplitter;
    pnl3        : TDNMPanel;
    Report2     : TDNMPanel;
    Report4: TDNMPanel;
    report3n4   : TSplitter;
    Report5: TDNMPanel;
    report4n5   : TSplitter;
    report6: TDNMPanel;
    report2n3: TSplitter;
    Report3: TDNMPanel;
    report1n2: TSplitter;
    Report1: TDNMPanel;
    DNMPanel1: TDNMPanel;
    btnCancel: TDNMSpeedButton;
    cmdExport: TDNMSpeedButton;
    qrycustomcharts: TERPQuery;
    qrycustomchartsChartName: TWideStringField;
    qrycustomchartsReportClassName: TWideStringField;
    qrycustomchartsGlobal: TWideStringField;
    qrycustomchartsDefaultChart: TWideStringField;
    qrycustomchartsX_LabelsField: TWideStringField;
    qrycustomchartsX_ChartedField: TWideStringField;
    qrycustomchartsY_ChartedField: TWideStringField;
    qrycustomchartsZ_ChartedField: TWideStringField;
    qrycustomchartsID: TIntegerField;
    qrycustomchartsCustomFilterID: TIntegerField;
    qrycustomchartsEmployeeID: TIntegerField;
    qrycustomchartsChartBlob: TBlobField;
    dlgSave: TSaveDialog;
    btnImport: TDNMSpeedButton;
    dlgOpen: TOpenDialog;
    pnlDonotshowonStartup: TDNMPanel;
    chkShowDashboard: TCheckBox;

    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure report1n2Moved(Sender: TObject);
    procedure report2n3Moved(Sender: TObject);
    procedure report3n4Moved(Sender: TObject);
    procedure report4n5Moved(Sender: TObject);
    procedure Horizontal1Moved(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
    procedure chkShowDashboardExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ReportForm:TBaseform;
    mnudEfaults : TMenuItem;
    mnuDetails : TMenuItem;
    procedure ShowReport(Const index:Integer; pnl:TDnmPanel=nil);
    Procedure makemenu;
    Procedure ResizePanel(sender:TDnmPanel);
    procedure OpenQueries;
    procedure menuClick(Sender: TObject);virtual;
  Protected
    customiseobj: TDashBoardObj;
    GuiPrefs: TFormGuiPrefs;
    function DateFrom: TDateTime;virtual;
    function Dateto: TDateTime;virtual;
    Procedure RefreshScreen;virtual;
    Procedure MakeCustomizeObj;Virtual;abstract;
    Procedure RefreshQuery(const Dashboardform:TComponent);Virtual;
    procedure ReadnApplyGuiPrefExtra; virtual;
    Procedure WriteGuiPrefExtra; virtual;
    Procedure SetDashboardfilter(const Dashboardform:TComponent;const Detailreportform:TComponent);Virtual;
  public
    { Public declarations }
  end;

implementation

uses CommonLib, CommonDbLib, tcDataUtils, BaseListingForm,
    DashBoardBase, FastFuncs, MainSwitchFrm2, AppEnvironment, tcConst , DateUtils,
  GraphUtil, CompanyPrefObj , BaseInputForm, XMLFuncLib,
  DbSharedObjectsObj;

{$R *.dfm}
procedure TDashboardGUI.FormShow(Sender: TObject);
var
  ctr:Integer;
begin
  chkShowDashboard.checked := not(Appenv.CompanyPrefs.ShowDashboard);
  inherited;
  MakeCustomizeObj;

  for ctr := 0 to ComponentCount-1 do
    if Components[ctr] is TDNMPanel then begin
      TDNMPanel(Components[ctr]).transparent := False;
      TDNMPanel(Components[ctr]).ParentColor:= true;
//      TDNMPanel(Components[ctr]).Color:= Self.color;
    end;
  try
  OpenQueries;
  ReadnApplyGuiPrefExtra;
  refreshScreen;
  try
    Self.Left   := mainswitch2.Left;
    Self.top    := mainswitch2.Top;
    Self.width  := mainswitch2.width;
    Self.height := mainswitch2.height;
  except
    //kill the exception if the main form doesn't exists - which should not happen
  end;


  Except
    //kill the exception
  end;

end;

procedure TDashboardGUI.btnImportClick(Sender: TObject);
var
  script :TERPScript;
  conn :TERPConnection;
begin
  inherited;
  if not dlgOpen.Execute then exit;
  if dlgOpen.filename = '' then exit;
  if MessageDlgXP_Vista('This will overwrite all the dashboard graphs. Do you want to continue?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;
  conn := GetNewMyDacConnection(Self);
  try
    script := DbSharedObj.GetScript(Conn);
    try
      Script.SQL.loadfromfile(dlgOpen.filename);
      if Script.SQL.count =0 then exit;
      conn.StartTransaction;
      try
          Script.Execute;
          conn.Commit;
          if assigned(mnudEfaults) then mnudEfaults.Click;
          MessageDlgXP_Vista('Charts are imported and the Dashboard is changed to the Default.', mtWarning, [mbOK], 0);
      except
        on E:Exception do begin
          MessageDlgXP_Vista('Importing Dashboard Charts failed.'+NL+E.Message, mtWarning, [mbOK], 0);
          Exit;
        end;
      end;
    finally
      DbSharedObj.ReleaseObj(script);
    end;
  finally
    FreeandNil(Conn);
  end;

end;

procedure TDashboardGUI.chkShowDashboardExit(Sender: TObject);
begin
  inherited;
  if Appenv.CompanyPrefs.ShowDashboard = chkShowDashboard.Checked then begin
      appenv.CompanyPrefs.ShowDashboard := not(chkShowDashboard.Checked);
  end;
end;

procedure TDashboardGUI.cmdExportClick(Sender: TObject);
var
  st:TStringlist;
  FileName:String;
begin
  inherited;
  opendb(qrycustomcharts);
  st:= TStringlist.create;
  try
    if qrycustomcharts.recordcount =0 then exit;
    qrycustomcharts.first;
    While qrycustomcharts.eof = False do begin
        st.Add('Delete from tblcustomcharts where ChartName = ' + Quotedstr(qrycustomcharts.fieldbyname('ChartName').AsString) +' and ReportClassName = ' + quotedstr(qrycustomcharts.fieldbyname('ReportClassName').AsString)+';');
        st.Add('INSERT IGNORE INTO `tblcustomcharts` (`ChartName`, `ReportClassName`, `Global`, `DefaultChart`, `ChartBlob`, `X_LabelsField`, `X_ChartedField`, `Y_ChartedField`, `Z_ChartedField`) ' +
              ' VALUES (' + Quotedstr(qrycustomcharts.fieldbyname('ChartName').AsString) +',' +
                            quotedStr(qrycustomcharts.fieldbyname('ReportClassName').AsString) +','+
                            quotedStr(qrycustomcharts.fieldbyname('Global').AsString) +','+
                            quotedStr(qrycustomcharts.fieldbyname('DefaultChart').AsString) +','+
                            //quotedStr(qrycustomcharts.fieldbyname('ChartBlob').AsString) +','+
                            QuotedStr(StringReplace(Trim(qrycustomcharts.fieldbyname('ChartBlob').asString),#13#10 , '\r\n', [rfReplaceAll, rfIgnoreCase])) +', ' +
                            quotedStr(qrycustomcharts.fieldbyname('X_LabelsField').AsString) +','+
                            quotedStr(qrycustomcharts.fieldbyname('X_ChartedField').AsString) +','+
                            quotedStr(qrycustomcharts.fieldbyname('Y_ChartedField').AsString) +','+
                            quotedStr(qrycustomcharts.fieldbyname('Z_ChartedField').AsString) +'); ');
      qrycustomcharts.Next;
    end;
    if st.count = 0 then begin
      MessageDlgXP_vista('No chart found for Dashboard', mtWarning, [mbOK], 0);
      Exit;
    end;
    FileName := '';
    if dlgSave.Execute then FileName := dlgSave.FileName;
    if FileName ='' then exit;
    St.saveToFile(FileName);
    MessageDlgXP_Vista('Dashboard Charts are exported to '+NL+Quotedstr(Filename)+'.', mtInformation, [mbOK], 0);
  finally
    Freeandnil(st);
  end;

end;

function TDashboardGUI.DateFrom: TDateTime;
begin
  Result:=   IncDay(AppEnv.CompanyPrefs.ClosingDate);
end;

function TDashboardGUI.Dateto: TDateTime;
begin
  result:= date;
end;

procedure TDashboardGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TDashboardGUI.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key = VK_ESCAPE then Begin
      Self.Close;
  end;
end;
procedure TDashboardGUI.SetDashboardfilter(const Dashboardform:TComponent;const Detailreportform: TComponent);
begin
  if Dashboardform is TDashBoardBaseGUI then
    TDashBoardBaseGUI(Dashboardform).SetDashboardfilter(Detailreportform);
end;

procedure TDashboardGUI.Showreport(const index: Integer; pnl:TDnmPanel=nil);
var
  fdim :Integer;
  ReportPanel :String;
  ReportClassname:String;
  Parentpnl:TDNMPanel;

begin
  ReportClassname := Trim(customiseobj.ReportClassname[Index]);
  if ReportClassname <> '' then begin
    ReportForm := TBaseForm(GetComponentByClassName(ReportClassname, true, self, False )) ;
    ReportPanel:= customiseobj.ReportPanel[Index];
    if ReportPanel<> '' then begin
      if ReportForm.FindComponent(ReportPanel) <> nil then begin
        if pnl <> nil then parentPnl := pnl else
        Parentpnl :=TDNMPanel(Self.Findcomponent(customiseobj.ParentPanel[Index]));
        if Parentpnl <> nil then begin
          if pnl = nil then begin
            fdim:=customiseobj.ParentWidth[Index]; if fDim <> 0 then Parentpnl.width := fDim;
            fdim:=customiseobj.Parentheight[Index];
            if fDim <> 0 then
              if parentpnl.parent is TDNMPanel then
                TDNMPanel(ParentPnl.parent).height :=fDim;
          end;
          if ReportForm.FindComponent(ReportPanel) is TDNMPanel then begin
            TDNMPanel(ReportForm.FindComponent(ReportPanel)).Transparent := False;
            TDNMPanel(ReportForm.FindComponent(ReportPanel)).Parentcolor:= True;
          end;
          TControl(ReportForm.FindComponent(ReportPanel)).Parent := ParentPnl;
          (*if ReportForm is TDashBoardBaseGUI then TDashBoardBaseGUI(ReportForm).RefreshQuery;*)
          RefreshQuery(ReportForm);
          customiseobj.Dashboardreports[Index].Visible := TRue;
        end;
        customiseobj.Dashboardreports[Index].report := reportform;
      end;
    end;
  end;
end;
procedure TDashboardGUI.ReadnApplyGuiPrefExtra;
begin

end;

procedure TDashboardGUI.WriteGuiPrefExtra;
begin

end;

Procedure TDashboardGUI.RefreshQuery(const Dashboardform:TComponent);
begin
  if Dashboardform is TDashBoardBaseGUI then TDashBoardBaseGUI(Dashboardform).RefreshQuery;
end;
procedure TDashboardGUI.makemenu;
var
  i1,i2:Integer;
  NewItem : TMenuItem;
begin
  try
    for i1 := low(customiseobj.Dashboardreports) to high(customiseobj.Dashboardreports) do
      if customiseobj.Dashboardreports[i1].Report <> nil then begin
        if TDashBoardBaseGUI(customiseobj.Dashboardreports[i1].Report).customisemenu.Items.count > 0 then
          TDashBoardBaseGUI(customiseobj.Dashboardreports[i1].Report).customisemenu.Items.Clear;
        {details}
        NewItem := TMenuItem.Create(TDashBoardBaseGUI(customiseobj.Dashboardreports[i1].Report).customisemenu);
        NewItem.Caption := 'Details';
        NewItem.OnClick := menuClick;
        TDashBoardBaseGUI(customiseobj.Dashboardreports[i1].Report).customisemenu.Items.Add(NewItem);
        mnuDetails :=NewItem;
        {separator}
        NewItem := TMenuItem.Create(TDashBoardBaseGUI(customiseobj.Dashboardreports[i1].Report).customisemenu);
        NewItem.Caption := '-';
        TDashBoardBaseGUI(customiseobj.Dashboardreports[i1].Report).customisemenu.Items.Add(NewItem);
        {separator}
        NewItem := TMenuItem.Create(TDashBoardBaseGUI(customiseobj.Dashboardreports[i1].Report).customisemenu);
        NewItem.Caption := 'Default';
        NewItem.OnClick := menuClick;
        TDashBoardBaseGUI(customiseobj.Dashboardreports[i1].Report).customisemenu.Items.Add(NewItem);
        mnuDefaults :=NewItem;
        {separator}
        NewItem := TMenuItem.Create(TDashBoardBaseGUI(customiseobj.Dashboardreports[i1].Report).customisemenu);
        NewItem.Caption := '-';
        TDashBoardBaseGUI(customiseobj.Dashboardreports[i1].Report).customisemenu.Items.Add(NewItem);
      end;
  Except

  end;

  for i1 := low(customiseobj.Dashboardreports) to high(customiseobj.Dashboardreports) do
    for i2 := low(customiseobj.Dashboardreports) to high(customiseobj.Dashboardreports) do begin
      if customiseobj.Dashboardreports[i2].Report<> nil then
        if customiseobj.Dashboardreports[i1].ReportName <> customiseobj.Dashboardreports[i2].reportname then
          if customiseobj.Dashboardreports[i2].visible = False then
            if customiseobj.Dashboardreports[i2].Report is TDashBoardBaseGUI then begin
              NewItem := TMenuItem.Create(TDashBoardBaseGUI(customiseobj.Dashboardreports[i1].Report).customisemenu);
              NewItem.Caption := ReinstateNonAlphaNumeric(customiseobj.Dashboardreports[i2].ReportName);
              NewItem.OnClick := menuClick;
              TDashBoardBaseGUI(customiseobj.Dashboardreports[i1].Report).customisemenu.Items.Add(NewItem);
            end;
    end;
end;

procedure TDashboardGUI.menuClick(Sender: TObject);
var
  index, oldIndex:Integer;
  curform:TDashBoardBaseGUI;
  ParentPnl:TDnmPanel;
  DetailReportForm :TComponent;
begin
  inherited;
  curform :=  TDashBoardBaseGUI(TPopupmenu(TMenuItem(Sender).owner).Owner);
  oldIndex:= customiseobj.LocateReportClass(Curform.Classname);
  if Sysutils.SameText(StringReplace(TMenuItem(Sender).Caption, '&' , '' , []) , 'Details') then begin
    if customiseobj.dashboardreports[oldindex].DetailreportName <> '' then begin
      DetailReportForm :=GetComponentByClassName(customiseobj.dashboardreports[oldindex].DetailreportName);
      if (Assigned(DetailReportForm)) then begin
        if (DetailReportForm  is TBaseListingGUI) then begin
            SetDashboardfilter(curform , DetailReportForm);
            TBaseListingGUI(DetailReportForm).FormStyle := fsMDIChild;
            TBaseListingGUI(DetailReportForm).DashboardDetail:= true;
            TBaseListingGUI(DetailReportForm).DtFrom.Date := DateFrom;
            TBaseListingGUI(DetailReportForm).DtTo.Date := Dateto;
            TBaseListingGUI(DetailReportForm).fbDateRangeSupplied := True;
            TBaseListingGUI(DetailReportForm).BringTofront;
            TBaseListingGUI(DetailReportForm).Refresh;
        end else if Detailreportform is TBaseInputGUI then begin
            TBaseInputGUI(DetailReportForm).FormStyle := fsMDIChild;
            TBaseInputGUI(DetailReportForm).BringTofront;
        end;
      end;
    end;
    Exit;
  end;
  if Sysutils.SameText(StringReplace(TMenuItem(Sender).Caption, '&' , '' , []) , 'Default') then begin
    customiseobj.CreateDefaultGuiPref;
    customiseobj.LoadGuipref(Self);
    refreshScreen;
    Exit;
  end;
  index:= customiseobj.LocateReportname(StringReplace(TMenuItem(Sender).Caption, '&' , '' , []));
  if index <0 then exit;
  if customiseobj.dashboardreports[index].visible = true then Exit;

  if oldIndex >=0 then begin
    customiseobj.dashboardreports[oldindex].Visible := false;
    customiseobj.dashboardreports[oldindex].ParentPanel := '';
  end;
  ParentPnl := TDnmPanel(curform.pnlmain.Parent );
  customiseobj.dashboardreports[index].ParentPanel:=ParentPnl.Name;
  customiseobj.dashboardreports[index].Width :=ParentPnl.width;
  customiseobj.dashboardreports[index].height:=ParentPnl.height;

  curform.pnlmain.Parent := curform;
  Showreport(Index , ParentPnl );
  makemenu;
end;

procedure TDashboardGUI.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  WriteGuiPrefExtra;
  customiseobj.SavePrefs;
end;

procedure TDashboardGUI.FormCreate(Sender: TObject);
begin
  //Self.Color := ColorAdjustLuma(GetGradientColor(Self.ClassName).Color,GetGradientColor(Self.ClassName).AdjLuma div 2 , False);;
  inherited;
  GuiPrefs := TFormGuiPrefs.Create(Self);
  GuiPrefs.Active := True;
end;

procedure TDashboardGUI.FormDestroy(Sender: TObject);
begin
  FreeAndNil(GuiPrefs);
  inherited;
end;

procedure TDashboardGUI.report1n2Moved(Sender: TObject);
begin
  ResizePanel(report1);
end;

procedure TDashboardGUI.report2n3Moved(Sender: TObject);
begin
  ResizePanel(report2);
end;

procedure TDashboardGUI.report3n4Moved(Sender: TObject);
begin
  ResizePanel(report4);
end;

procedure TDashboardGUI.ResizePanel(sender: TDnmPanel);
var
  Index:Integer;
begin
  inherited;
  index:= customiseobj.LocateParentPanel(Sender.name);
  if index <0 then Exit;
  customiseobj.DashBoardReports[index].width := Sender.Width;
  customiseobj.DashBoardReports[index].height := Sender.height;
end;

procedure TDashboardGUI.report4n5Moved(Sender: TObject);
begin
  inherited;
  ResizePanel(report5);
end;

procedure TDashboardGUI.Horizontal1Moved(Sender: TObject);
begin
  inherited;
  ResizePanel(report1);
  ResizePanel(report2);
  ResizePanel(report3);
end;

procedure TDashboardGUI.refreshScreen;
  Var
    ctr:Integer;
begin
  for ctr := Low(customiseobj.Dashboardreports) to high(customiseobj.Dashboardreports) do begin
    showreport(ctr);
  end;
  makemenu;
end;

procedure TDashboardGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  Self.close;
end;

procedure TDashboardGUI.OpenQueries;
var
  iIndex: integer;
begin
  iIndex        := 0;
      try
        ProcessingCursor;
        while iIndex < Self.ComponentCount do begin
          if Self.Components[iIndex] is TCustomMyDataSet then begin
            with Self.Components[iIndex] as TCustomMyDataSet do begin
              if connection = nil then connection := GetSharedMyDacConnection;
              try
                Open;
              except

              end;
            end;
          end;
          Inc(iIndex);
        end;
      finally
        ProcessingCursor(False);
      end;
end;


(*initialization
  RegisterClassOnce(TDashboardGUI);*)
end.
