unit MarketingContacts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, CustomInputBox, wwcheckbox;

type
  TMarketingContactGUI = class(TBaseListingGUI)
    qryMaincompany: TWideStringField;
    qryMainFirstName: TWideStringField;
    qryMainLastName: TWideStringField;
    qryMainCompanyTypeName: TWideStringField;
    qryMainSUBURB: TWideStringField;
    qryMainSTATE: TWideStringField;
    qryMainCountry: TWideStringField;
    qryMainPOSTCODE: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainSource: TWideStringField;
    qryMainURL: TWideStringField;
    qryMainEmail: TWideStringField;
    qryMainLastLeadDone: TDateTimeField;
    qryMainFollowupDate: TDateTimeField;
    qryMainRep: TWideStringField;
    qryMainLastRep: TWideStringField;
    qryMainAction: TWideStringField;
    qryMainId: TIntegerField;
    qryMainLeadID: TLargeintField;
    qryMainISLEad: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure chkIgnoreDatesClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); override;
  private
    tablename :String;
    reptablename :String;
    ProgressDialog: TProgressDialog;
    tablecreated:Boolean;
    procedure doBeforeExecute(Sender: TObject; var SQL: String;
      var Omit: Boolean);
    Procedure CreateTemptable;
  public
    Procedure RefreshQuery; override;

  end;


implementation

uses CommonLib, CommonDbLib, FastFuncs, frmMarketingContact;

{$R *.dfm}

{ TMarketingContactGUI }

procedure TMarketingContactGUI.RefreshQuery;
begin
  (*CreateTempTable;*)
  Qrymain.DisableControls;
  try
    if Qrymain.active then Qrymain.close;
    if chkIgnoreDates.checked then
         qrymain.Params.ParamByName('IgnoreDate').asString := 'T'
    else qrymain.Params.ParamByName('IgnoreDate').asString := 'F';
    qrymain.Params.ParamByName('Datefrom').asDateTime :=FilterDateFrom;
    qrymain.Params.ParamByName('dateTo').asDateTime :=FilterDateTo;
    inherited;
    TDatetimefield(qrymain.fieldByname('LastLeadDone')).DisplayFormat := FormatSettings.ShortDateformat;
    TDatetimefield(qrymain.fieldByname('FollowupDate')).DisplayFormat := FormatSettings.ShortDateformat;
  finally
      qrymain.EnableControls;
  end;
end;

procedure TMarketingContactGUI.FormCreate(Sender: TObject);
begin
  inherited;
  IgnoreQuerySpeed := TRue;
  tablename := 'tmp_mc' + GetTemporaryTableNameSuffix;
  repTablename := 'tmp_mcr' + GetTemporaryTableNameSuffix;
  tablecreated := False;
  CreateTempTable;
end;

procedure TMarketingContactGUI.doBeforeExecute(Sender: TObject;
  var SQL: String; var Omit: Boolean);
begin
  inherited;
  ProgressDialog.StepIt;
end;

procedure TMarketingContactGUI.CreateTemptable;
begin
if not tablecreated then begin
    with CommonDbLib.TempMyScript do try
        connection := qrymain.Connection;
        SQL.clear;
        SQL.add('drop table if exists ' + tablename+';');
        SQL.add('drop table if exists ' + reptablename+';');
        SQL.add('Create table ' + tablename+' Select Id , company  from tblmarketingcontacts;');
        SQL.add('ALTER TABLE ' + tablename+' ADD PRIMARY KEY (`Id`);');
        SQL.add('ALTER TABLE ' + tablename+' ADD INDEX `CompanyIDX` (`company`);');
        SQL.add('alter table ' + tablename+' add column LeadLineId int;');
        SQL.add('ALTER TABLE ' + tablename+' ADD INDEX `LineidIDX`  (`LeadLineId`);');
        SQL.add('update ' + tablename+' set LeadLineId = (Select max(LeadlineId) from tblmarketingleads inner join tblmarketingleadlines  on tblmarketingleads.LEADid =  tblmarketingleadlines.LeadId where tblmarketingleads.marketingcontactId = ' + tablename+'.ID) ;');
        SQL.add('drop table if exists ' +reptablename+';');
        SQL.add('create table ' +reptablename );
        SQL.add('SELECT T.Id, `T`.`company`,`MC`.`FirstName`,`MC`.`LastName`,`MC`.`CompanyTypeName`,');
        SQL.add('`MC`.`SUBURB`,`MC`.`STATE`,`MC`.`Country`,`MC`.`POSTCODE`,`MC`.`Phone`,`MC`.`Source`,');
        SQL.add('`MC`.`URL`,`MC`.`Email`,`MLL`.`UpdateDate` AS `LastLeadDone`,`MLL`.`FollowUpDate` AS `FollowupDate`,');
        SQL.add('concat_WS(" " , `MLE`.`Title`,`MLE`.`FirstName`,`MLE`.`MiddleName`,`MLE`.`LastName`) as Rep,');
        SQL.add('concat_WS(" " , `MLLE`.`Title`,`MLLE`.`FirstName`,`MLLE`.`MiddleName`,`MLLE`.`LastName`) as LastRep, ');
        SQL.add('`ActionLookup`.`Name` as Action, MLL.LeadID, MLL.IsLead');
        SQL.add('FROM');
        SQL.add( tablename+' AS `T`');
        SQL.add('Inner Join `tblmarketingleads` AS `ML` ON `ML`.`MarketingContactID` = `T`.`Id`');
        SQL.add('Inner Join `tblmarketingleadlines` AS `MLL` ON `MLL`.`LeadLineID` = `T`.`LeadLineId`');
        SQL.add('Inner Join `tblmarketingcontacts` AS `MC` ON `T`.`Id` = `MC`.`ID`');
        SQL.add('Inner Join `tblemployees` AS `MLE` ON `ML`.`RepID` = `MLE`.`EmployeeID`');
        SQL.add('Inner Join `tblemployees` AS `MLLE` ON `MLL`.`EmployeeID` = `MLLE`.`EmployeeID`');
        SQL.add('inner Join tblsimpletypes AS ActionLookup ON MLL.ActionType = ActionLookup.id');
        SQL.add('WHERE');
        SQL.add('ifnull(T.leadlineID,0) <>  0');
        SQL.add('union');
        SQL.add('SELECT T.Id, `T`.`company`,`MC`.`FirstName`,`MC`.`LastName`,`MC`.`CompanyTypeName`,');
        SQL.add('`MC`.`SUBURB`,`MC`.`STATE`,`MC`.`Country`,`MC`.`POSTCODE`,`MC`.`Phone`,');
        SQL.add('`MC`.`Source`,`MC`.`URL`,`MC`.`Email`,NULL AS `LastLeadDone`,');
        SQL.add('NULL AS `FollowupDate`,"", "" ,"", 0,"F"');
        SQL.add('FROM');
        SQL.add( tablename+' AS `T`');
        SQL.add('Inner Join `tblmarketingcontacts` AS `MC` ON `T`.`Id` = `MC`.`ID`');
        SQL.add('WHERE ifnull(T.leadlineID,0) =  0;');
        ProgressDialog := TProgressDialog.Create(nil);
        ProgressDialog.Caption := 'Please Wait .......';
        ProgressDialog.MinValue := 0;
        ProgressDialog.MaxValue :=11;
        ProgressDialog.Step := 1;
        ProgressDialog.Execute;
        BeforeExecute := doBeforeExecute;
        Execute;
        ProgressDialog.CloseDialog;
    finally
          free;
    end;
    if Qrymain.active then Qrymain.Close;
    Qrymain.SQL.text := StringReplace(Qrymain.SQL.text , 'tmp_2' , repTablename , [rfReplaceAll, rfIgnoreCase]);
    RefreshOrignalSQL;
    tablecreated := true;
  end;
end;

procedure TMarketingContactGUI.FormDestroy(Sender: TObject);
begin
  with CommonDbLib.TempMyScript do try
    connection := qrymain.connection;
    SQL.add('drop table if exists ' + tablename+';');
    SQL.add('drop table if exists ' + reptablename+';');
    Execute;
  finally
      free;
  end;
  inherited;

end;

procedure TMarketingContactGUI.grdMainDblClick(Sender: TObject);
begin
  if qryMainISLEad.AsBoolean then SubsequentID :='_Lead' else SubsequentID :='_Telemarketing';
  inherited;
end;

procedure TMarketingContactGUI.chkIgnoreDatesClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TMarketingContactGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfmMarketingContact');
  if Assigned(Form) then begin
    with TfmMarketingContact(Form) do begin
      KeyId := 0;
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

initialization
  RegisterClassOnce(TMarketingContactGUI);

end.
