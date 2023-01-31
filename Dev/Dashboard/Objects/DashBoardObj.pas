unit DashBoardObj;

interface

uses
  classes, GuiPrefsObj, XMLDoc, XMLIntf;
const
  Reportcount = 8;
Type
  TDashboardreport= class(TComponent)
  Private
    fWidth            : Integer;
    fVisible          : Boolean;
    fHeight           : Integer;
    fReportName       : String;
    fParentPanel      : String;
    fReportPanel      : String;
    fReportClassname  : String;
    freport           : TComponent;
    fDetailReportName : String;
  Public
    Property Width            :Integer    read fWidth             write fWidth;
    Property Height           :Integer    read fHeight            Write fHeight;
    Property Visible          :Boolean    Read fVisible           Write fVisible;
    Property ReportName       :String     Read fReportName        Write fReportName;
    Property DetailReportName :String     read fDetailReportName  write fDetailReportName;
    Property ReportPanel      :String     Read fReportPanel       Write fReportPanel;
    Property ParentPanel      :String     REad fParentPanel       Write fParentPanel;
    Property ReportClassname  :String     read fReportClassname   Write fReportClassname;
    Property Report           :TComponent Read freport            Write freport;
    constructor Create(aOwner: TComponent); override;
  Protected
  End;

  TDashBoardobj = class(TComponent)
  private
    fXMLDoc: TXMLDocument;
    fsDashBoardName: string;
    fsExtraPrefXML: String;

    function getReportClassname (Const Index: integer): String;
    function getReportPanel     (Const Index: integer): String;
    function getParentPanel     (const Index: integer): String;
    function getParentHeight    (const Index: integer): Integer;
    function getParentwidth     (const Index: integer): Integer;
    function getReportname      (const Index: integer): String;
    function getDetailReportName(const Index: Integer): String;
    function getPrefXML: String;
  Protected
    Procedure CreateGuiPrefIfnotFound;virtual;
    Procedure ReadGuiprefoptions(const node:IXMLNode);virtual;

  Public
    GuiPrefs: TFormGuiPrefs;
    Dashboardreports :Array of TDashboardreport;
    constructor Create(aOwner: TComponent); overload; override;
    constructor Create(aOwner: TComponent; Prefname:String ); reintroduce;overload;
    Property ReportClassname  [Const Index: integer]: String  read getReportClassname;
    Property Reportname       [Const Index: integer]: String  read getReportname;
    Property DetailReportName [Const Index: Integer]: String  REad getDetailReportName;
    Property ReportPanel      [Const Index: integer]: String  Read getReportPanel;
    Property ParentPanel      [Const Index: integer]: String  Read getParentPanel;
    Property Parentwidth      [Const Index: integer]: Integer Read getParentwidth;
    Property ParentHeight     [Const Index: integer]: Integer Read getParentHeight;
    function LocateReportname(const Value:String):Integer;
    function LocateParentPanel(const Value:String):Integer;
    function LocateReportClass(const Value:String):Integer;
    Procedure SavePrefs;
    Property PrefXML:String REad getPrefXML;
    Procedure CreateDefaultGuiPref; virtual;
    Procedure LoadGuipref(Aowner: TComponent);
    Property DashBoardName :string read fsDashBoardName write fsDashBoardName;
    Property ExtraPrefXML:string read fsExtraPrefXML write fsExtraPrefXML ;
  published

  end;
  TSalesDashBoardobj = class(TDashBoardobj)
  Private
    fdDAteTo: TdateTime;
    fdDAteFrom: TDatetime;
    fballemployees: Boolean;
    fiEmployeeId: Integer;
    fbIgnoredate: Boolean;
  Protected
    Procedure ReadGuiprefoptions(const node:IXMLNode);Override;
  Public
    Procedure CreateDefaultGuiPref; Override;
    Property employeeId:Integer   read fiEmployeeId   write fiEmployeeId;
    Property allemployees:Boolean read fballemployees write fballemployees;
    Property Ignoredate :Boolean  read fbIgnoredate   write fbIgnoredate;
    Property DAteFrom :TDatetime  read fdDAteFrom     write fdDAteFrom;
    Property DAteTo :TdateTime    read fdDAteTo       Write fdDAteTo;
  end;
  TMainDashBoardobj = Class(TDashBoardobj)
  Private
  Protected
  Public
    Procedure CreateDefaultGuiPref; Override;
  End;
implementation

uses Sysutils, DNMLib, FastFuncs, CommonLib, DateTimeUtils, XMLFuncLib;

{ TDashBoardobjn }
constructor TDashBoardobj.Create(aOwner: TComponent; Prefname:String );
begin
  DashBoardName:=Prefname;
  Create(AOwner);
end;

constructor TDashBoardobj.Create(Aowner: TComponent);
begin
  inherited Create(Aowner);
  GuiPrefs := TFormGuiPrefs.Create(self);
  GuiPrefs.PrefsName :=  DashBoardName ;//AOwner.Classname;
  GuiPrefs.UserPrefsOnly := False;
  GuiPrefs.Active := True;
  CreateGUIPrefifnotFound;
  Loadguipref(Aowner);
  fsExtraPrefXML:= '';
end;


Procedure TDashBoardobj.CreateDefaultGuiPref;
begin
      GuiPrefs.SavePrefs;
end;
procedure TDashBoardobj.CreateGuiPrefIfnotFound;
begin
  if (GuiPrefs.node.XML = '') or
    (GuiPrefs.node.XML = '<?xml version="1.0" encoding="UTF-8" ?><'  + DashBoardName + '></'  + DashBoardName + '>') then begin
    CreateDefaultGuiPref;
  end;
end;


function TDashBoardobj.getReportPanel(Const Index: integer): String;
begin
  if Length(Dashboardreports) >index then    REsult := Dashboardreports[index].ReportPanel;
end;
function TDashBoardobj.getParentPanel(Const Index: integer): String;
begin
  if Length(Dashboardreports) >index then    REsult := Dashboardreports[index].ParentPanel;
end;
function TDashBoardobj.getReportClassname(Const Index: integer):  String;
begin
  if Length(Dashboardreports) >index then    REsult := Dashboardreports[index].ReportClassname;
end;
function TDashBoardobj.getParentHeight(const Index: integer): Integer;
begin
  Result :=0;
  if Length(Dashboardreports) >index then    REsult := Dashboardreports[index].Height;
end;

function TDashBoardobj.getParentwidth(const Index: integer): Integer;
begin
  Result :=0;
  if Length(Dashboardreports) >index then    REsult := Dashboardreports[index].Width;
end;

function TDashBoardobj.getReportname(const Index: integer): String;
begin
  Result :='';
  if Length(Dashboardreports) >index then    REsult := Dashboardreports[index].ReportName;
end;

function TDashBoardobj.LocateReportname(const Value: String): Integer;
var
  ctr:Integer;
begin
  REsult := -1;
  for ctr := low(Dashboardreports) to high(Dashboardreports) do
    if Sysutils.SameText(Value, Dashboardreports[ctr].ReportName) then begin
        result := ctr;
        break;
    end;
end;

function TDashBoardobj.LocateReportClass(const Value: String): Integer;
var
  ctr:Integer;
begin
  REsult := -1;
  for ctr := low(Dashboardreports) to high(Dashboardreports) do
    if Sysutils.SameText(Value, Dashboardreports[ctr].ReportClassname) then begin
        result := ctr;
        break;
    end;
end;

function TDashBoardobj.getDetailReportName(const Index: Integer): String;
begin
  if Length(Dashboardreports) >index then    REsult := Dashboardreports[index].DetailReportName;
end;

procedure TDashBoardobj.SavePrefs;
begin
   GuiPrefs.Node.XML := Self.PrefXML;
   GuiPrefs.SavePrefs;
end;

function TDashBoardobj.getPrefXML: String;
var
  ctr:Integer;
  function nodevisible :String ; begin if DashboardReports[ctr].visible then result := 'T' else result := 'F'; end;
  function nodeWidth:String; begin if DashboardReports[ctr].width<> 0 then result := IntToStr(DashboardReports[ctr].width) else result := ''; end;
  function nodeHeight:String; begin if DashboardReports[ctr].Height<> 0 then result := IntToStr(DashboardReports[ctr].Height) else result := ''; end;
begin
    Result :='<?xml version="1.0" encoding="UTF-8" ?>' +'<'  + DashBoardName + '><Panels>' ;
    for ctr := low(DashboardReports) to high(DashBoardreports) do begin
      Result := result + '<Report>';
      REsult := result + '<Visible>'          + nodevisible                           +'</Visible>';
      REsult := result + '<ReportName>'       + DashboardReports[ctr].ReportName      +'</ReportName>';
      REsult := result + '<ReportClassname>'  + DashboardReports[ctr].ReportClassname +'</ReportClassname>';
      REsult := result + '<DetailReportName>' + DashboardReports[ctr].Detailreportname+'</DetailReportName>' ;
      REsult := result + '<ReportPanel>'      + DashboardReports[ctr].ReportPanel     +'</ReportPanel>' ;
      REsult := result + '<ParentPanel>'      + DashboardReports[ctr].ParentPanel     +'</ParentPanel>';
      REsult := result + '<Width>'            + nodewidth                             +'</Width>';
      REsult := result + '<Height>'           + nodeHeight                            +'</Height>';
      REsult := result + '</Report>' ;
    end;
    result := result + '</Panels>' ;
    result := result +ExtraPrefXML;
    result := result +'</'  + DashBoardName + '>';
end;


function TDashBoardobj.LocateParentPanel(const Value: String): Integer;
var
  ctr:Integer;
begin
  REsult := -1;
  for ctr := low(Dashboardreports) to high(Dashboardreports) do
    if Sysutils.SameText(Value, Dashboardreports[ctr].ParentPanel) then begin
        result := ctr;
        break;
    end;
end;

procedure TDashBoardobj.LoadGuipref(Aowner: TComponent);
var
  ctr:Integer;
  XMLNode, reportnode, optionsnode, panelsnode:IXMLNode;
begin
  fXMLDoc := TXMLDocument.Create(self);
  fXMLDoc.LoadFromXML(GuiPrefs.Node.XML);
  XMLNode :=fXMLDoc.ChildNodes.FindNode(Aowner.Classname); if XMLNode = nil then exit;
  optionsnode :=  XMLNode.Childnodes.FindNode('Options');
  panelsnode  := XMLNode.Childnodes.FindNode('Panels');
    if panelsnode <> nil then
      try
        for ctr := 0 to panelsnode.ChildNodes.count-1 do
          try
            Setlength(Dashboardreports , ctr+1);
            reportnode :=panelsnode.Childnodes[ctr];
            Dashboardreports[ctr] :=TDashboardreport.create(Self);
            if IsNumeric(ReportNode.Childnodes.findNode('Width').Text)                then Dashboardreports[ctr].Width  :=  strtoint(ReportNode.Childnodes.findNode('Width').Text);
            if IsNumeric(ReportNode.Childnodes.findNode('Height').Text)               then Dashboardreports[ctr].height :=  strtoint(ReportNode.Childnodes.findNode('Height').Text);
            if Sysutils.SameText(ReportNode.Childnodes.findNode('Visible').Text,'T') then Dashboardreports[ctr].Visible:=  true;
            if ReportNode.Childnodes.findNode('ReportName')       <> nil then Dashboardreports[ctr].ReportName        :=  ReinstateNonAlphaNumeric(Trim(ReportNode.Childnodes.findNode('ReportName').Text));
            if ReportNode.Childnodes.findNode('ReportPanel')      <> nil then Dashboardreports[ctr].ReportPanel       :=  ReinstateNonAlphaNumeric(Trim(ReportNode.Childnodes.findNode('ReportPanel').Text));
            if ReportNode.Childnodes.findNode('ParentPanel')      <> nil then Dashboardreports[ctr].ParentPanel       :=  ReinstateNonAlphaNumeric(Trim(ReportNode.Childnodes.findNode('ParentPanel').Text));
            if ReportNode.Childnodes.findNode('ReportClassname')  <> nil then Dashboardreports[ctr].ReportClassname   :=  ReinstateNonAlphaNumeric(Trim(ReportNode.Childnodes.findNode('ReportClassname').Text));
            if ReportNode.Childnodes.findNode('DetailReportName') <> nil then Dashboardreports[ctr].DetailReportName  :=  ReinstateNonAlphaNumeric(Trim(ReportNode.Childnodes.findNode('DetailReportName').Text));
          Except
            continue;
              // kill the exception
          end;

    if optionsnode <> nil then begin
      ReadGuiprefoptions(optionsnode);
    end;
  Except
    //kill the exception
  end;
end;
Procedure TDashBoardobj.ReadGuiprefoptions(const node:IXMLNode);
begin

end;
{ TDashboardreport }

constructor TDashboardreport.Create(aOwner: TComponent);
begin
  inherited;
  Width            :=0;
  Height           :=0;
  Visible          :=False;
  ReportName       :='';
  ReportPanel      :='';
  ParentPanel      :='';
  ReportClassname  :='' ;
  DetailReportName :='';
  Report           := nil;

end;

procedure TSalesDashBoardobj.CreateDefaultGuiPref;
begin
    GuiPrefs.node.XML := '<?xml version="1.0" encoding="UTF-8" ?>' +
                            '<'  + DashBoardName + '><Panels>' +
                            '<Report>' + '<Visible>T</Visible>' + '<ReportName>Reminders        </ReportName>' + '<ReportClassname>TSalesDashBoardReminderGUI</ReportClassname>'      + '<DetailReportName>TReminderListGUI</DetailReportName>'          + '<ReportPanel>pnlmain</ReportPanel>' + '<ParentPanel>Report1</ParentPanel>' + '<Width>180</Width>' + '<Height>260</Height>' + '</Report>' +
                            '<Report>' + '<Visible>T</Visible>' + '<ReportName>I n E            </ReportName>' + '<ReportClassname>TsalesDashBoardPnLGUI</ReportClassname>'           + '<DetailReportName>TSalesDashboardPnLdetailsGUI</DetailReportName>'   + '<ReportPanel>pnlmain</ReportPanel>' + '<ParentPanel>Report2</ParentPanel>' + '<Width>450</Width>' + '<Height>260</Height>' + '</Report>' +
                            '<Report>' + '<Visible>F</Visible>' + '<ReportName>Sales Analysis (Manual)      </ReportName>' + '<ReportClassname>TSalesdashBoardsaleaAnalysisManualGUI</ReportClassname>'    + '<DetailReportName>TSalesAnalysisManualGUI</DetailReportName>'       + '<ReportPanel>pnlmain</ReportPanel>' + '<ParentPanel>Report3</ParentPanel>' + '<Width>335</Width>' + '<Height>295</Height>' + '</Report>' +
                            '<Report>' + '<Visible>T</Visible>' + '<ReportName>Top 10 Customers </ReportName>' + '<ReportClassname>TsalesDashboardTopTenCustomerGUI</ReportClassname>'+ '<DetailReportName>TSalesDashBoardTopTenCustomersDetailsGUI</DetailReportName>' + '<ReportPanel>pnlmain</ReportPanel>' + '<ParentPanel>Report4</ParentPanel>' + '<Width>335</Width>' + '<Height>295</Height>' + '</Report>' +
                            '<Report>' + '<Visible>T</Visible>' + '<ReportName>Top 10 Products  </ReportName>' + '<ReportClassname>TSalesDashBoardTopTenProductsGUI</ReportClassname>'+ '<DetailReportName>TSalesDashBoardTopTenProductsDetailsGUI</DetailReportName>'         + '<ReportPanel>pnlmain</ReportPanel>' + '<ParentPanel>Report5</ParentPanel>' + '<Width>335</Width>' + '<Height>295</Height>' + '</Report>' +
                            '<Report>' + '<Visible>T</Visible>' + '<ReportName>Top 10 Salesmen  </ReportName>' + '<ReportClassname>TSalesDashBoardTopTenSalesmenGUI</ReportClassname>'+ '<DetailReportName>TSalesDashBoardTopTenSalesManDetailsGUI</DetailReportName>'         + '<ReportPanel>pnlmain</ReportPanel>' + '<ParentPanel>Report6</ParentPanel>' + '<Width>335</Width>' + '<Height>295</Height>' + '</Report>' +
                            //'<Report>' + '<Visible>F</Visible>' + '<ReportName>A n L            </ReportName>' + '<ReportClassname>TSalesDashBoardAnLGUI</ReportClassname>'           + '<DetailReportName>TBalanceSheetGUI</DetailReportName>'           + '<ReportPanel>pnlmain</ReportPanel>' + '<ParentPanel> </ParentPanel>'        + '<Width>300</Width>' + '<Height>260</Height>' + '</Report>' +
                            '</Panels>' + '</'  + DashBoardName + '>';
  inherited;
end;


{ TMainDashBoardobj }

procedure TMainDashBoardobj.CreateDefaultGuiPref;
begin
    GuiPrefs.node.XML := '<?xml version="1.0" encoding="UTF-8" ?>' +
                            '<'  + DashBoardName + '><Panels>' +
                            '<Report>' + '<Visible>T</Visible>' + '<ReportName>Reminders        </ReportName>' + '<ReportClassname>TDashBoardReminderGUI</ReportClassname>'       + '<DetailReportName>TReminderListGUI</DetailReportName>'          + '<ReportPanel>pnlmain</ReportPanel>' + '<ParentPanel>Report1</ParentPanel>' + '<Width>180</Width>' + '<Height>260</Height>' + '</Report>' +
                            '<Report>' + '<Visible>T</Visible>' + '<ReportName>I n E            </ReportName>' + '<ReportClassname>TDashBoardPnLGUI</ReportClassname>'            + '<DetailReportName>TIncomeandExpenditureGUI</DetailReportName>'   + '<ReportPanel>pnlmain</ReportPanel>' + '<ParentPanel>Report2</ParentPanel>' + '<Width>450</Width>' + '<Height>260</Height>' + '</Report>' +
                            '<Report>' + '<Visible>F</Visible>' + '<ReportName>Sales Ratio      </ReportName>' + '<ReportClassname>TDashBoardSalesRatioGUI</ReportClassname>'     + '<DetailReportName>TfrmSalesRatioReport</DetailReportName>'       + '<ReportPanel>pnlmain</ReportPanel>' + '<ParentPanel>Report3</ParentPanel>' + '<Width>335</Width>' + '<Height>295</Height>' + '</Report>' +
                            '<Report>' + '<Visible>T</Visible>' + '<ReportName>Top 10 Customers </ReportName>' + '<ReportClassname>TDashboardTopTenCustomerGUI</ReportClassname>' + '<DetailReportName>TCustomerSummaryListingGUI</DetailReportName>' + '<ReportPanel>pnlmain</ReportPanel>' + '<ParentPanel>Report4</ParentPanel>' + '<Width>335</Width>' + '<Height>295</Height>' + '</Report>' +
                            '<Report>' + '<Visible>T</Visible>' + '<ReportName>Top 10 Products  </ReportName>' + '<ReportClassname>TDashboardTopTenProductsGUI</ReportClassname>' + '<DetailReportName>TProductSummaryGUI</DetailReportName>'         + '<ReportPanel>pnlmain</ReportPanel>' + '<ParentPanel>Report5</ParentPanel>' + '<Width>335</Width>' + '<Height>295</Height>' + '</Report>' +
                            '<Report>' + '<Visible>T</Visible>' + '<ReportName>Top 10 Salesmen  </ReportName>' + '<ReportClassname>TDashboardTopTenSalesmenGUI</ReportClassname>' + '<DetailReportName>TEmployeeReportGUI</DetailReportName>'         + '<ReportPanel>pnlmain</ReportPanel>' + '<ParentPanel>Report6</ParentPanel>' + '<Width>335</Width>' + '<Height>295</Height>' + '</Report>' +
                            '<Report>' + '<Visible>F</Visible>' + '<ReportName>A n L            </ReportName>' + '<ReportClassname>TDashBoardAnLGUI</ReportClassname>'            + '<DetailReportName>TBalanceSheetGUI</DetailReportName>'           + '<ReportPanel>pnlmain</ReportPanel>' + '<ParentPanel> </ParentPanel>'        + '<Width>300</Width>' + '<Height>260</Height>' + '</Report>' +
                            '</Panels>' + '</'  + DashBoardName + '>';
  inherited;
end;


procedure TSalesDashBoardobj.ReadGuiprefoptions(const node: IXMLNode);
var
  s:String;
begin
  inherited;
  s:= XMLFuncLib.ReinstateNonAlphaNumeric(Node.Childnodes.findNode('Ignoredate').Text)   ; if s <> '' then Ignoredate  := strtoBoolean(s);
  s:= XMLFuncLib.ReinstateNonAlphaNumeric(Node.Childnodes.findNode('Allemployees').Text) ; if s <> '' then Allemployees:= strtoBoolean(s);
  s:= XMLFuncLib.ReinstateNonAlphaNumeric(Node.Childnodes.findNode('employeeId').Text)   ; if s <> '' then EmployeeId  := strToInt(s);
  s:= XMLFuncLib.ReinstateNonAlphaNumeric(Node.Childnodes.findNode('DateFrom').Text)     ; if s <> '' then DateFrom    := strToDate(s);
  s:= XMLFuncLib.ReinstateNonAlphaNumeric(Node.Childnodes.findNode('Dateto').Text)       ; if s <> '' then Dateto      := strToDate(s);
end;
end.
