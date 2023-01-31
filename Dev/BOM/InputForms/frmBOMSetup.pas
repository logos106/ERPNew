unit frmBOMSetup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, DNMSpeedButton, Shader, DNMPanel , frmBaseSetup, datManufacturingAddin , dmMainGUI,
  ComCtrls, HTMLabel, HTMLText;

type
  TfmBOMSetup = class(TfmBaseSetup)
    pnlResources: TDNMPanel;
    lblResources: TLabel;
    Label5: TLabel;
    pnlResourcesaction: TDNMPanel;
    Shader3: TShader;
    pnlResourceWF: TDNMPanel;
    Shader4: TShader;
    lblResourceWF: TLabel;
    pnlRoster: TDNMPanel;
    lblRoster: TLabel;
    Label8: TLabel;
    pnlRosterAction: TDNMPanel;
    Shader5: TShader;
    pnlRosterWF: TDNMPanel;
    Shader6: TShader;
    Label10: TLabel;
    pnlManufactureProduct: TDNMPanel;
    lblManufactureProduct: TLabel;
    Label11: TLabel;
    pnlManufactureProductAction: TDNMPanel;
    Shader7: TShader;
    pnlManufactureProductWF: TDNMPanel;
    Shader8: TShader;
    Label13: TLabel;
    pnlEmpnResRoster: TDNMPanel;
    lblEmpnResRoster: TLabel;
    Label15: TLabel;
    pnlEmpnResRosterAction: TDNMPanel;
    Shader9: TShader;
    pnlEmpnResRosterWF: TDNMPanel;
    Shader10: TShader;
    Label17: TLabel;
    pnlSetupDurations: TDNMPanel;
    lblProcessSteps: TLabel;
    Label3: TLabel;
    btnDurations: TDNMPanel;
    Shader1: TShader;
    btnDurationworkflow: TDNMPanel;
    Shader2: TShader;
    lblDurationworkflow: TLabel;
    pnlSalesOrderExpress: TDNMPanel;
    lblSalesOrderExpress: TLabel;
    Label19: TLabel;
    pnlSalesOrderExpressAction: TDNMPanel;
    Shader11: TShader;
    pnlSalesOrderExpressWF: TDNMPanel;
    Shader12: TShader;
    Label21: TLabel;
    pnlCapacityPlan: TDNMPanel;
    lblCapacityPlan: TLabel;
    Label23: TLabel;
    pnlCapacityPlanAction: TDNMPanel;
    Shader13: TShader;
    pnlCapacityPlanWF: TDNMPanel;
    Shader14: TShader;
    Label25: TLabel;
    pnlPreference: TDNMPanel;
    lblPreference: TLabel;
    Label4: TLabel;
    pnlPreferenceAction: TDNMPanel;
    Shader15: TShader;
    lblPreferences: TLabel;
    pnlPreferenceWF: TDNMPanel;
    Shader16: TShader;
    Label9: TLabel;
    btnprocessstepList: TDNMSpeedButton;
    btnResourceList: TDNMSpeedButton;
    btnEmpResProcRoster: TDNMSpeedButton;
    btnManufactureProductList: TDNMSpeedButton;
    btnSalesOrderExpressList: TDNMSpeedButton;
    btnCapacityPlanning: TDNMSpeedButton;
    btnEmpResProcRosternSchedule: TDNMSpeedButton;
    TabSheet2: TTabSheet;
    PageLevels: TPageControl;
    TabLevel1: TTabSheet;
    TabLevel2: TTabSheet;
    TabLevel3: TTabSheet;
    Tablevel4: TTabSheet;
    TabLevel5: TTabSheet;
    TabLevel6: TTabSheet;
    HTMLabel1: THTMLabel;
    sbLvl2: TScrollBox;
    htmlLvl2: THTMLabel;
    sbLvl1: TScrollBox;
    sbLvl3: TScrollBox;
    htmlLvl1: THTMLabel;
    sbLvl5: TScrollBox;
    sbLvl4: TScrollBox;
    sbLvl6: TScrollBox;
    htmlLvl3: THTMLabel;
    htmlLvl4: THTMLabel;
    htmlLvl5: THTMLabel;
    htmlLvl6: THTMLabel;
    DNMPanel1: TDNMPanel;
    shActiveForm: TShader;
    pnlActiveForm: TLabel;
    btnLevel1: TDNMSpeedButton;
    btnLevel2: TDNMSpeedButton;
    btnLevel3: TDNMSpeedButton;
    btnLevel4: TDNMSpeedButton;
    btnLevel5: TDNMSpeedButton;
    btnLevel6: TDNMSpeedButton;
    lblprocessstepList: TLabel;
    lblResourceList: TLabel;
    lblEmpResProcRoster: TLabel;
    lblManufactureProductList: TLabel;
    lblSalesOrderExpressList: TLabel;
    lblCapacityPlanning: TLabel;
    lblEmpResProcRosternSchedule: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure lblPreferencesClick(Sender: TObject);
    procedure lblDurationworkflowClick(Sender: TObject);
    procedure lblResourceWFClick(Sender: TObject);
    procedure Label10Click(Sender: TObject);
    procedure Label9Click(Sender: TObject);
    procedure Label21Click(Sender: TObject);
    procedure Label25Click(Sender: TObject);
    procedure Label17Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure MainPageResize(Sender: TObject);
    procedure PageLevelsResize(Sender: TObject);
    procedure LevelOptionclick(Sender: TObject);
    procedure PageLevelsChanging(Sender: TObject; var AllowChange: Boolean);
    procedure lblprocessstepListClick(Sender: TObject);
    procedure lblResourceListClick(Sender: TObject);
    procedure lblEmpResProcRosterClick(Sender: TObject);
    procedure lblManufactureProductListClick(Sender: TObject);
    procedure lblSalesOrderExpressListClick(Sender: TObject);
    procedure lblCapacityPlanningClick(Sender: TObject);
    procedure lblEmpResProcRosternScheduleClick(Sender: TObject);
  private
    Procedure BOMHTMLHelp(HTMLbl: THTMLabel; Heading:String; SubHEading1,SubHEading2:String;Steps:Array of String; Notes :Array of String;Pros:Array of String;cons:Array of String);
    procedure InitHelps;
    Procedure InitHelpPages;
  Protected
    procedure SetDefaultColor;Override;
  public
    { Public declarations }
  end;


implementation

uses CommonFormLib, CommonLib, tcConst , Preferences, DNMLib, LogLib;

{$R *.dfm}
procedure TfmBOMSetup.InitHelpPages;
var
  ctr:Integer;
begin
  //PageLevels.ActivePageindex := 0;
  //LevelOptionclick(lblLevel1);
  for ctr:= 0 to PageLevels.pagecount-1 do TTabsheet(PageLevels.pages[ctr]).Tabvisible := False;
  ShowControlhint(btnLevel1,'Very Simple Manufacturing');
  ShowControlhint(btnLevel2,'Simple Manufacturing');
  ShowControlhint(btnLevel3,'Basic Manufacturing');
  ShowControlhint(btnLevel4,'Medium Manufacturing (Without Barcodes)');
  ShowControlhint(btnLevel5,'Medium Manufacturing (Using Barcodes)');
  ShowControlhint(btnLevel6,'Full Manufacturing');
end;

Procedure TfmBOMSetup.InitHelps;
Function NewLineExt(const Indent:Integer=70):String; begin result := '<br><IND x="' +inttostr(Indent) +'">'; end;
begin
  clog('');
  BOMHTMLHelp(htmlLvl1 , (*'Very Simple Manufacturing'*)'', '',
                         'Use related parts' ,
                         ['Make a Sales Order or Invoice.' ,
                                   'Select the related part and quantity required.'] ,
                         ['Stock is removed'],
                         ['Very Simple to setup and manage.'],
                         ['Customers can see all products used.' ,
                                   'No detail about machine or labour resources used to do the build.' ,
                                   'No detail about time taken to do the build.']);

  BOMHTMLHelp(htmlLvl2 , (*'Simple Manufacturing'*)'' , '',
                         'Use a BOM' ,
                         ['Make a Sales Order.' ,
                                   'Select the BOM and quantity required.' ,
                                   'Save.' ,
                                   'Open Sales Order when ready and select "Finalise Build" on the Sales Order.'] ,
                         ['Stock is removed from the raw materials.' ,
                                   'Invoice with Finished goods is produced automatically.'],
                         ['Simple to setup and manage.',
                                   'Customers only see finished goods, not raw materials. (1 Line)',
                                   'Raw materials are adjusted (Made Unavailable) at the time of making the Sales Order.'],
                         ['No detail about machine or labour resources used to do the build.' ,
                                   'No detail about time taken to do the build.']);

  BOMHTMLHelp(htmlLvl3 , (*'Basic Manufacturing' *)'', '',
                         'Use a BOM' ,
                         ['Sales person makes a Sales Order.' ,
                                   'Select the BOM and quantity required.' ,
                                   'Right mouse click on the BOM and Adjust as required per this build.' ,
                                   'Either Print the Job Card at this time or at step 7.' ,
                                   'Save.' ,
                                   'Production Manager opens the "Production Job Status" list.' ,
                                   'Select the Job or Sales Order and Print The Job Card using the "Print (Detail)" button.' ,
                                   'Once the BOM is built, the production manager opens the "Production Job Status" list and selects "Finalise".'] ,
                         ['Stock is removed from the raw materials.' ,
                                   'Invoice with Finished goods is produced automatically.'],
                         ['Simple to setup and manage.' ,
                                   'Customers only see finished goods, not raw materials. (1 Line).' ,
                                   'Raw materials are adjusted (Made Unavailable) at the time of making the Sales Order.'],
                         ['No detail about machine or labour resources used to do the build.' ,
                                   'No detail about time taken to do the build.']);

  BOMHTMLHelp(htmlLvl4 , (*'Medium Manufacturing (Without Barcodes)'*)'' , '',
                         'Use a BOM' ,
                         ['Sales person makes a Sales Order.',
                         'Select the BOM and quantity required.',
                         'Right mouse click on the BOM and Adjust as required per this build.',
                         'Either Print the Job Card at this time or a step 7.',
                         'Save.' + NewLineExt +'<B>'+
                         'At this point the Job is in the system and the stock has been made "Unavailable"' +NewLineExt +
                         'but it is not "Scheduled" to be worked on yet.</B>',
                         'Production Manager opens the "Production Job Status" icon or "Capacity Planning"' +NewLineExt +
                         'or "Production Scheduling" and selects "Schedule"' + NewLineExt +' <B>'+
                         'This will automatically allocate the job in the system based on resource availability ' +NewLineExt +
                         'and give you an expected completion date.</B>',
                         'Select a job and use the "Print Job Details" to produce a Job card or Traveller or ' +NewLineExt +
                         'Select a range of jobs and print the "Production Work Sheet" for the entire factory.',
                         'As each Process is completed, it can be flagged and its "Status" updated, from ' +NewLineExt +
                         '"Scheduled" to "Started", in "QA" to "Completed".  This will give you accurate times ' +NewLineExt +
                         'taken for each process and these times will reflect in most manufacturing reports ' +NewLineExt +
                         'like the "Build Profitability" etc.',
                         'Once all processes are completed, the Production Manager can either "Complete" ' +NewLineExt +
                         'and notify accounts that they can copy to invoice or simply select "Complete and ' +NewLineExt +
                         'Invoice" and create the invoice themselves.'] ,
                         [''],
                         ['Customers only see finished goods, not raw materials. (1 Line).',
                         'Raw materials are adjusted (Made Unavailable) at the time of making the Sales Order.',
                         'Machine and labour resources are tracked, that were used to do the build.',
                         'Times are tracked on how long each piece or resource took to make for each build.'],
                         ['Requires more manual input to track each stage.']);

  BOMHTMLHelp(htmlLvl5 , (*'Medium Manufacturing (Using Barcodes)'*)'' , '',
                         'Use a BOM' ,
                         ['Sales person makes a Sales Order.',
                         'Select the BOM and quantity required.',
                         'Right mouse click on the BOM and Adjust as required per this build.',
                         'Save.' +NewLineExt +
                         '<B>At this point the Job is in the system and the stock has been made "Unavailable" ' +NewLineExt +
                         'but it is not "Scheduled" to be worked on yet.</B>',
                         'Production Manager opens the "Production Job Status" icon or "Capacity Planning" ' +NewLineExt +
                         'or "Production Scheduling" and selects "Schedule".' +NewLineExt +
                         '<B>This will automatically allocate the job in the system based on resource availability ' +NewLineExt +
                         'and give you an expected completion date.</B>',
                         'Each Employee/Workstation will then log into the "Barcode Manufacturing" and' +NewLineExt +
                         'scan in their employee barcode.',
                         'They will either select the next job or scan the job card as allocated by the' +NewLineExt +
                         'production manager.',
                         'Using the control codes or the touch screen buttons, they will update the status of' +NewLineExt +
                         'each process.  ie "Started", "On Break", "Completed" etc. This will give you very ' +NewLineExt +
                         'accurate times taken for each process and these times will reflect in most ' +NewLineExt +
                         'manufacturing reports like the "Build Profitability" etc.',
                         'Once all processes are completed, the Production Manager can either "Complete"' +NewLineExt +
                         'and notify accounts that they can make the invoice or simply "Complete and Invoice".'] ,
                         [''],
                         ['Customers only see finished goods, not raw materials. (1 Line).',
                         'Raw materials are adjusted (Made Unavailable) at the time of making the Sales Order.',
                         'Machine and labour resources are tracked that were used to do the build.',
                         'Times are tracked on how long each piece or resource took to make for each build.',
                         'Employee logins are tracked and their Start and Stop times will update payroll hours. (If' +NewLineExt(40) +'required).',
                         'If an Employee has stopped the job or is on a break, this is tracked.',
                         'You can see real time, who is on what job and how long they have been working on it.'],
                         ['Requires more manual input to track each stage.']);

  BOMHTMLHelp(htmlLvl6 , (*'Full Manufacturing'*)'',
                         'Major step here from level 5 is that you would allocate all staff into the future, based on skills '+
                         'and availability. If staff or resource become unavailable the capacity will adjust to factor in for '+
                         'shortages.'+NewLineExt+ NewLineExt+
                         //'<Font   size="3" face="Arial" color ="Green"><center>'+
                         '<U>VERY ACCURATE TIMES, COSTS AND PROFITABILITY</U>.<BR>',
                         //'</center></Font>'+NewLineExt ,
                         'Use a BOM',
                         ['Sales person makes a Sales Order.',
                         'Select the BOM and quantity required.',
                         'Right mouse click on the BOM and Adjust as required per this build.',
                         'Save.' +NewLineExt +
                         '<B>At this point the Job is in the system and the stock has been made "Unavailable"' +NewLineExt +
                         'but it is not "Scheduled" to be worked on yet.</B>',
                         'Production Manager opens the "Production Job Status" icon or "Capacity Planning"' +NewLineExt +
                         'or "Production Scheduling" and selects "Schedule".' +NewLineExt +
                         '<B>This will automatically allocate the job in the system based on resource availability ' +NewLineExt +
                         'and give you an expected completion date.</B>',
                         'Each Employee/Workstation will then log into the "Barcode Manufacturing" and' +NewLineExt +
                         'scan in their employee barcode.',
                         'They will either select the next job or scan the job card as allocated by the' +NewLineExt +
                         'production manager.',
                         'Using the control codes or the touch screen buttons, they will update the status of' +NewLineExt +
                         'each process. ie "Started", "On Break", "Completed" etc. This will give you very' +NewLineExt +
                         'accurate times taken for each process and these times will reflect in most' +NewLineExt +
                         'manufacturing reports like the "Build Profitability" etc.',
                         'Once all processes are completed, the Production Manager can either "Complete"' +NewLineExt +
                         'and notify accounts that they can make the invoice or simply "Complete and ' +NewLineExt +
                         'Invoice".'] ,
                         [''],
                         ['Customers only see finished goods, not raw materials. (1 Line).',
                         'Raw materials are adjusted (Made Unavailable) at the time of making the Sales Order.',
                         'Machine and labour resources are tracked that were used to do the build.',
                         'Times are tracked on how long each piece or resource took to make for each build.',
                         'Employee logins are tracked and their Start and Stop times will update payroll hours. (If' +NewLineExt(40) +
                         'required).',
                         'If an Employee has stopped the job or is on a break, this is tracked.',
                         'You can see real time, who is on what job and how long they have been working on it.'],
                         ['Large setup with full understanding required.',
                         'Requires more manual input to track each stage.']);


end;
procedure TfmBOMSetup.BOMHTMLHelp(HTMLbl: THTMLabel; Heading, SubHEading1,SubHEading2: String; Steps, Notes, Pros, cons: Array of String);
var
  i:Integer;
  //function HalfLine:String; begin result := '<hr style="height:10px; visibility:hidden;" />';end;
begin
  With HTMLbl do begin
    top :=3;
    Left := 3;
    Width := Parent.Width-6;
    Height := 360; if (Length(Steps) + Length(Notes) + Length(Pros) + Length(Cons)) > 7 then Height := Height  + ((Length(Steps) + Length(Notes) + Length(Pros) + Length(Cons)) - 7) *50;
    HTMLText.Clear;
    HTMLText.Add('<FONT  size="3" face="Arial">');

    if Heading     <> '' then HTMLText.Add('<B>'+Heading+'</B>  <BR>');
    if SubHEading1 <> '' then HTMLText.Add('<B>'+SubHEading1+'</B>  <BR>');
    if SubHEading2 <> '' then HTMLText.Add('<B>'+SubHEading2+'</B>  <BR>');
    HTMLText.Add('<BR>');

    HTMLText.Add('<B><IND x="20">Steps </B><BR><BR> ');    if Length(Steps) >0 then      for i := Low(Steps) to high(Steps) do HTMLText.Add('<IND x="40">'+inttostr(i+1)+'.   '+ Steps[i] +'<BR> ');    HTMLText.Add('<BR>');
    HTMLText.Add(' ');                                     if Length(Notes) >0 then      for i := Low(Notes) to high(Notes) do HTMLText.Add('<IND x="20">'                     + Notes[i] +'<BR> ');    HTMLText.Add('<BR>');
    HTMLText.Add('<B><IND x="20">Pros  </B><BR><BR> ');    if Length(Pros)  >0 then      for i := Low(Pros)  to high(Pros)  do HTMLText.Add('<IND x="40">'                     + Pros[i]  +'<BR> ');    HTMLText.Add('<BR>');
    HTMLText.Add('<B><IND x="20">Cons  </B><BR><BR> ');    if Length(Cons)  >0 then      for i := Low(cons)  to high(Cons)  do HTMLText.Add('<IND x="40">'                     + Cons[i]  +'<BR> ');    HTMLText.Add('<BR>');
    //HTMLText.Add('<BR><center>----------------END----------------</center>');
    HTMLText.Add('</FONT');
    Logtext(HTMLText.text);
  end;

end;

procedure TfmBOMSetup.FormCreate(Sender: TObject);
begin
  inherited;
  (*1*)InitDescLabel(pnlSetupDurations ,btnDurations,btnDurationworkflow, lblProcessSteps,'Choose to Create Process steps.'+NL+
                                                                                          'Process Steps will let you choose the Employees who can do the Process');
  (*2*)InitDescLabel(pnlResources, pnlResourcesaction ,pnlResourceWF ,  lblResources,     'Choose to Create Resources which is always linked to at least one Process Step.'+NL+
                                                                                          'Each Resource can have Multiple Instances - Each One is identical.');
  (*3*)InitDescLabel(pnlRoster,pnlRosteraction, pnlRosterwf, lblRoster, 'Choose to Create a Weekly Roster for all Employees on a weekly Basis.'+NL+
                                                                        'Auto Schedule Will Refer to This for the Availability of the Resource/Employee.'+NL+NL+
                                                                        'You can Either Assign Current Employees Or Create An Employee Simply as a Reference.'+NL+'ie: Make an Employee Called "Resource 1"');
  (*4*)InitDescLabel(pnlManufactureProduct,pnlManufactureProductAction, pnlManufactureProductwf, lblManufactureProduct, 'Choose to Make a BOM within a Product. This will be your Template that You will Use On Sales Order / Work Orders'+NL+
                                                                                                                        'Here You Will Choose "Processes" to be Used in this Product');
  (*5*)InitDescLabel(pnlPreference , pnlPreferenceAction, pnlPreferenceWF, lblPreference, 'Define and Customise How Manufacturing will Display and Work.');
  (*6*)InitDescLabel(pnlSalesOrderExpress, pnlSalesOrderExpressaction, pnlSalesOrderExpressWF, lblSalesOrderExpress, 'Create a New Sales Order / Work Order That will Use the BOM that You Created Earlier'+NL+
                                                                                                                      'As a JOB in Your Manufacturing Processes and Screens');
  (*7*)InitDescLabel(pnlCapacityPlan,pnlCapacityPlanaction, pnlCapacityPlanWF, lblCapacityPlan, 'Choose to Create / View / Change Schedules of Sales Order / Work Order / Jobs');
  (*8*)InitDescLabel(pnlEmpnResRoster,pnlEmpnResRosteraction, pnlEmpnResRosterWF, lblEmpnResRoster, 'Choose to Create / View / Change Schedules of Sales Order / Work Order / Jobs in a Planner');

(*  btnprocessstepList.Layout          := blnone;
  btnResourceList.Layout             := blnone;
  btnEmpResProcRoster.Layout         := blnone;
  btnManufactureProductList.Layout   := blnone;
  btnSalesOrderExpressList.Layout    := blnone;
  btnCapacityPlanning.Layout         := blnone;
  btnEmpResProcRosternSchedule.Layout:= blnone;*)

  btnprocessstepList.Visible          := False;
  btnResourceList.Visible             := False;
  btnEmpResProcRoster.Visible         := False;
  btnManufactureProductList.Visible   := False;
  btnSalesOrderExpressList.Visible    := False;
  btnCapacityPlanning.Visible         := False;
  btnEmpResProcRosternSchedule.Visible:= False;

  lblprocessstepList.Caption          := btnprocessstepList.caption;
  lblResourceList.Caption             := btnResourceList.caption;
  lblEmpResProcRoster.Caption         := btnEmpResProcRoster.caption;
  lblManufactureProductList.Caption   := btnManufactureProductList.caption;
  lblSalesOrderExpressList.Caption    := btnSalesOrderExpressList.caption;
  lblCapacityPlanning.Caption         := btnCapacityPlanning.caption;
  lblEmpResProcRosternSchedule.Caption:= btnEmpResProcRosternSchedule.caption;

  InitHelps;
end;


procedure TfmBOMSetup.Label10Click            (Sender: TObject);begin  Playworkflow('Employee Allocation')        ;end;
procedure TfmBOMSetup.Label17Click            (Sender: TObject);begin  Playworkflow('Production Scheduling')      ;end;
procedure TfmBOMSetup.Label21Click            (Sender: TObject);begin  Playworkflow('Sales - Sales Order')        ;end;
procedure TfmBOMSetup.Label25Click            (Sender: TObject);begin  Playworkflow('Capacity Planning')          ;end;
procedure TfmBOMSetup.Label9Click             (Sender: TObject);begin  Playworkflow('Preferences (Manufacturing)');end;

procedure TfmBOMSetup.lblDurationworkflowClick(Sender: TObject);begin  Playworkflow('Process Step')               ;end;


procedure TfmBOMSetup.lblResourceWFClick      (Sender: TObject);begin  Playworkflow('Resource')                   ;end;

procedure TfmBOMSetup.LevelOptionclick(Sender: TObject);
var
  Allowchange:Boolean;
begin
  inherited;
      PageLevelsChanging(PageLevels , Allowchange);
      if not Allowchange then exit;
      PageLevels.ActivePageIndex :=TDnMSpeedButton(Sender).Tag-1;
      TTabsheet(PageLevels.pages[TDnMSpeedButton(Sender).Tag-1]).Tabvisible := False;
      PageLevels.OnChange(PageLevels);
      pnlActiveForm.Caption :=trim(TDnMSpeedButton(Sender).Hint);
      pnlActiveForm.REfresh;
      Setcontrolfocus(PageLevels);
      HighlightControl(TDnMSpeedButton(Sender));
      sbLvl1.VertScrollBar.Position := 0;
      sbLvl2.VertScrollBar.Position := 0;
      sbLvl3.VertScrollBar.Position := 0;
      sbLvl4.VertScrollBar.Position := 0;
      sbLvl5.VertScrollBar.Position := 0;
      sbLvl6.VertScrollBar.Position := 0;
end;

procedure TfmBOMSetup.FormResize(Sender: TObject);
begin
  inherited;
  RealignTabControl(mainPage, 1);
  //RealignTabControl(PageLevels, 1);
end;

procedure TfmBOMSetup.FormShow(Sender: TObject);
begin
  inherited;
  RealignTabControl(mainPage, 1);
  mainPage.ActivePageIndex := 0;
  //LevelOptionclick(lblLevel1);
  inithelpPages;
  LevelOptionclick(btnLevel1);
end;

procedure TfmBOMSetup.MainPageResize(Sender: TObject);
begin
  inherited;
  RealignTabControl(mainPage, 1);
end;

procedure TfmBOMSetup.PageLevelsChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  inherited;
  AllowChange := TRue;
end;

procedure TfmBOMSetup.PageLevelsResize(Sender: TObject);
begin
  inherited;
  //RealignTabControl(PageLevels, 1);
end;

procedure TfmBOMSetup.SetDefaultColor;
begin
  inherited;
(*  shLevel1.FromColor := $00B7FFB7;        shLevel1.ToColorMirror := $0080FF80;
  shLevel2.FromColor := $00B7FFB7;        shLevel2.ToColorMirror := $0080FF80;
  shLevel3.FromColor := $00B7FFB7;        shLevel3.ToColorMirror := $0080FF80;
  shLevel4.FromColor := $00B7FFB7;        shLevel4.ToColorMirror := $0080FF80;
  shLevel5.FromColor := $00B7FFB7;        shLevel5.ToColorMirror := $0080FF80;
  shLevel6.FromColor := $00B7FFB7;        shLevel6.ToColorMirror := $0080FF80;
  shActiveForm.FromColor := $00CAFFFF;    shActiveForm.ToColorMirror := $00CAFFFF;*)
end;

procedure TfmBOMSetup.lblPreferencesClick (Sender: TObject);begin  OpenPrefform('Manufacturing', '' ,1 ,True, '')end;

procedure TfmBOMSetup.lblprocessstepListClick           (Sender: TObject);begin  btnprocessstepList.Click           ; end;
procedure TfmBOMSetup.lblResourceListClick              (Sender: TObject);begin  btnResourceList.Click              ; end;
procedure TfmBOMSetup.lblEmpResProcRosterClick          (Sender: TObject);begin  btnEmpResProcRoster.Click          ; end;
procedure TfmBOMSetup.lblEmpResProcRosternScheduleClick (Sender: TObject);begin  btnEmpResProcRosternSchedule.Click ; end;
procedure TfmBOMSetup.lblManufactureProductListClick    (Sender: TObject);begin  btnManufactureProductList.Click    ; end;
procedure TfmBOMSetup.lblSalesOrderExpressListClick     (Sender: TObject);begin  btnSalesOrderExpressList.Click     ; end;
procedure TfmBOMSetup.lblCapacityPlanningClick          (Sender: TObject);begin  btnCapacityPlanning.Click          ; end;

initialization
  RegisterClassOnce(TfmBOMSetup);

end.
