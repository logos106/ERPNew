unit Marketing;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, BaseInputForm, DAScript, MyScript, wwcheckbox,
  CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TMarketingGUI = class(TBaseListingGUI)
    qryMainCOMPANY: TWideStringField;
    qryMainCompanyTypeName: TWideStringField;
    qryMainActionType: TWideStringField;
    qryMainActionDate: TDateTimeField;
    qryMainEmployeeName: TWideStringField;
    qryMainDuration: TWideStringField;
    qryMainIsLead: TWideStringField;
    qryMainLeadID: TIntegerField;
    qryMainLeadLineID: TIntegerField;
    qryMainDone: TWideStringField;
    qryMainStreet: TWideStringField;
    qryMainStreet2: TWideStringField;
    qryMainStreet3: TWideStringField;
    qryMainSUBURB: TWideStringField;
    qryMainSTATE: TWideStringField;
    qryMainCountry: TWideStringField;
    qryMainPOSTCODE: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainFaxNumber: TWideStringField;
    qryMainAltPhone: TWideStringField;
    qryMainMobile: TWideStringField;
    qryMainFirstName: TWideStringField;
    qryMainMiddleName: TWideStringField;
    qryMainLastName: TWideStringField;
    qryMainEmail: TWideStringField;
    chkOneLineOnly: TCheckBox;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure cmdNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkOneLineOnlyClick(Sender: TObject);
  private
    { Private declarations }
  Protected
    Procedure AssignKeyId(Popupform :TBaseInputGUI); override;
    procedure RefreshQuery; override;
    procedure ReadnApplyGuiPrefExtra; override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, frmMarketing, FastFuncs;

{$R *.dfm}

procedure TMarketingGUI.grpFiltersClick(Sender: TObject);
begin
    GroupFilterString := '';
    if grpFilters.ItemIndex     = 0 then GroupFilterString := 'Done = ' +quotedStr('T')
    else if grpFilters.ItemIndex= 1 then GroupFilterString := 'Done = ' +quotedStr('F');
    inherited;
end;
procedure TMarketingGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  chkOneLineOnly.Checked := GuiPrefs.Node['Options.OneLineOnly'].AsBoolean;
end;

procedure TMarketingGUI.RefreshQuery;
begin

  qryMain.SQL.Clear;
  qryMain.SQL.Add('SELECT');
  qryMain.SQL.Add('MC.COMPANY as company,');
  qryMain.SQL.Add('MC.CompanyTypeName as CompanyTypeName,');
  qryMain.SQL.Add('ST.Name AS ActionType,');
  qryMain.SQL.Add('MLL.CreationDate AS ActionDate,');
  qryMain.SQL.Add('MLL.EmployeeName as EmployeeName,');
  qryMain.SQL.Add('MLL.Duration as Duration ,');
  qryMain.SQL.Add('ML.IsLead as IsLead,');
  qryMain.SQL.Add('MLL.LeadID as LeadID,');
  qryMain.SQL.Add('MLL.LeadLineID as LeadLineID,');
  qryMain.SQL.Add('if(ifnull(MLL.LeadID,0)<>0,"T","F") AS Done,');
  qryMain.SQL.Add('MC.Street as Street,');
  qryMain.SQL.Add('MC.Street2 as Street2,');
  qryMain.SQL.Add('MC.Street3 as Street3 ,');
  qryMain.SQL.Add('MC.SUBURB as SUBURB,');
  qryMain.SQL.Add('MC.STATE as STATE,');
  qryMain.SQL.Add('MC.Country as Country,');
  qryMain.SQL.Add('MC.POSTCODE as POSTCODE,');
  qryMain.SQL.Add('MC.Phone as Phone,');
  qryMain.SQL.Add('MC.FaxNumber as FaxNumber ,');
  qryMain.SQL.Add('MC.AltPhone as AltPhone,');
  qryMain.SQL.Add('MC.Mobile as Mobile,');
  qryMain.SQL.Add('MC.FirstName as FirstName,');
  qryMain.SQL.Add('MC.MiddleName as MiddleName,');
  qryMain.SQL.Add('MC.LastName as LastName,');
  qryMain.SQL.Add('MC.Email as Email,');
  qryMain.SQL.Add('MC.Id as ID');
  qryMain.SQL.Add('FROM tblmarketingcontacts  MC');
  qryMain.SQL.Add('Left Join tblmarketingleads ML ON ML.MarketingContactID = MC.ID');
  qryMain.SQL.Add('Left Join  tblmarketingleadlines MLL ON MLL.LeadID = ML.LeadID');
  qryMain.SQL.Add('Left Join tblsimpletypes ST ON MLL.ActionType = ST.Id');
  qryMain.SQL.Add('where MLL.CreationDate between :DateFrom and :DateTo');
  if chkOneLineOnly.Checked then
    qryMain.SQL.Add('group by ML.LeadID');

  RefreshOrignalSQL;

  if chkIgnoreDates.Checked then begin
    qryMain.ParamByName('DateFrom').AsDate := 0;
    qryMain.ParamByName('DateTo').AsDate := MaxDateTime;
  end
  else begin
    qryMain.ParamByName('DateFrom').AsDate := dtFrom.Date;
    qryMain.ParamByName('DateTo').AsDate := dtTo.Date;
  end;


  inherited;

end;

Procedure TMarketingGUI.AssignKeyId(Popupform :TBaseInputGUI);
begin
    inherited;
    if Popupform.KeyId = 0 then
        if Sysutils.SameText(Popupform.classname , 'TfmMarketing') then
            TfmMarketing(popupform).MarketingContactName := qryMainCOMPANY.asString;

end;
procedure TMarketingGUI.chkOneLineOnlyClick(Sender: TObject);
begin
  inherited;
  if not chkOneLineOnly.Focused then exit;
  GuiPrefs.Node['Options.OneLineOnly'].AsBoolean := chkOneLineOnly.Checked;
  RefreshQuery;
end;

procedure TMarketingGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfmMarketing');
  if Assigned(Form) then begin
    with TfmMarketing(Form) do begin
      KeyId := 0;
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

procedure TMarketingGUI.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('LeadLineID,LeadID,ID');   
end;

procedure TMarketingGUI.FormCreate(Sender: TObject);
begin
  fbEnableWebSearch := true;
  //NoDateRange := true;
  inherited;

end;

initialization
  RegisterClassOnce(TMarketingGUI);

end.
