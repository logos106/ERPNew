unit frmAnalyticsSummaryList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GoogleAnalysisReportBase, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript,
  BaseListingForm, CustomInputBox, wwcheckbox;

type
  TfmAnalyticsSummaryList = class(TGoogleAnalysisReportBaseGUI)
    qryMainAccountName: TWideStringField;
    qryMainTitle: TWideStringField;
    qryMainImpressions: TFloatField;
    qryMainDate: TDateField;
    qryMainquarter: TIntegerField;
    qryMainmonth: TIntegerField;
    qryMainWeek: TIntegerField;
    qryMainmonthname: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);override;
    procedure FormCreate(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
  private
    tablename:String;
  protected
    procedure RefreshQuery; override;
    procedure SetGridColumns; Override;
    (*procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;*)
    (*procedure SetupFormInPanel; Override;*)
  public
    { Public declarations }
  end;


implementation

uses CommonDbLib, MySQLConst;

{$R *.dfm}

{ TfmAnalyticsSummaryList }

procedure TfmAnalyticsSummaryList.FormCreate(Sender: TObject);
begin
  Tablename := commondblib.GetUserTemporaryTableName('googlesummary');
  Qrymain.SQL.Text := 'Select * from '+tablename ;
  inherited;
end;

procedure TfmAnalyticsSummaryList.grpFiltersClick(Sender: TObject);
begin
  RefreshQuery;
end;

procedure TfmAnalyticsSummaryList.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
(*  if QryTGaProfile.Active then QryTGaProfile.close;
  QryTGaProfile.Connection := Qrymain.Connection;
  QryTGaProfile.Open;

  if QryAccountname.Active then QryAccountname.close;
  QryAccountname.Connection := Qrymain.Connection;
  QryAccountname.Open;


  lblTitle.Caption :=Qrymaintitle.DisplayLabel;
  lblAccount.Caption :=QryMainAccountname.DisplayLabel;*)
end;


procedure TfmAnalyticsSummaryList.RefreshQuery;
begin
  {Sql in qry main : had issues with the datatype of Qurter/week/month for different grpfitler options , so creating a temp table}
  with TempMyScript do try
    Sql.Add('drop table if exists ' +tablename +';');
    (*Sql.Add('Create table ' +tablename +' ');*)
    SQL.add('CREATE TABLE '+tablename +' ( ' +
            'ID int(11) NOT NULL AUTO_INCREMENT,' +
            ' Description varchar(100) NOT NULL DEFAULT "", ' +
            '   AccountName varchar(255) DEFAULT NULL, ' +
            '   Title varchar(255) DEFAULT NULL, ' +
            '   quarter int(1) NOT NULL DEFAULT "0", ' +
            '   month int(2) NOT NULL DEFAULT "0", ' +
            '   monthname varchar(9) DEFAULT NULL, ' +
            '   Week int(2) NOT NULL DEFAULT "0", ' +
            '   Date date DEFAULT NULL, ' +
            '   Visits Double DEFAULT NULL, ' +
            '   NewVisits Double DEFAULT NULL, ' +
            '   PageViews Double DEFAULT NULL, ' +
            '   TimeOnSite Double DEFAULT NULL, ' +
            '   Impressions Double DEFAULT NULL, ' +
            '   FTimeonSite text,'+
            '  PRIMARY KEY (ID) ' +
            ' ) ENGINE=MyISAM DEFAULT CHARSET=utf8;' );

    SQL.add('insert into ' +tablename +'( AccountName,Title,quarter,month,monthname,Week,Date,Visits,NewVisits,PageViews,TimeOnSite,Impressions) ');
    Sql.Add('select');
    Sql.Add('tblTGaAccount.AccountName,');
    Sql.Add('tblTGaProfile.Title,');
    Sql.Add('Cast(ifnull(quarter(vtblTGaDataSum.Date),0) as Signed) quarter,');
    Sql.Add('Cast(ifnull(Month(vtblTGaDataSum.Date),0) as Signed) month,');
    Sql.Add('MONTHname(vtblTGaDataSum.Date) as monthname,');
    Sql.Add('Cast(ifnull(Week(vtblTGaDataSum.Date),0) as Signed) Week,');
    Sql.Add('vtblTGaDataSum.Date,');
    Sql.Add('Cast(sum(ifnull(vtblTGaDataSum.Visits,0)) as Signed) Visits,');
    Sql.Add('Cast(sum(ifnull(vtblTGaDataSum.NewVisits,0)) as Signed) NewVisits,');
    Sql.Add('Cast(sum(ifnull(vtblTGaDataSum.PageViews,0)) as Signed) PageViews,');
    Sql.Add('Cast(sum(ifnull(vtblTGaDataSum.TimeOnSite,0)) as Signed) TimeOnSite,');
    Sql.Add('Cast(sum(ifnull(tblTGaSumm.Impressions,0)) as Signed) Impressions');
    Sql.Add('from tblTGaAccount');
    Sql.Add('inner join tblTGaProfile on tblTGaProfile.Ref_TGAAccount = tblTGaAccount.UId');
    Sql.Add('inner join vtblTGaDataSum on vtblTGaDataSum.ProfileId = tblTGaProfile.ProfileId');
    Sql.Add('  and vtblTGaDataSum.Date between ' + quotedstr(formatdateTime(MySQLdatetimeformat , FilterDatefrom)) +'  and ' + quotedstr(formatdateTime(MySQLdatetimeformat , FilterDateTo)) +' ');
    Sql.Add('left join tblTGaSumm on tblTGaSumm.ProfileId = tblTGaProfile.ProfileId');
    Sql.Add(' and tblTGaSumm.Date = vtblTGaDataSum.Date');
    Sql.Add(' and tblTGaSumm.Date between ' + quotedstr(formatdateTime(MySQLdatetimeformat , FilterDatefrom)) +'  and ' + quotedstr(formatdateTime(MySQLdatetimeformat , FilterDateTo)) +' ');
    Sql.Add(' Where  ifnull(tblTGaProfile.title,"") <>""');

    if chktitles.checked =False then
      if cbotitle.Text <> '' then
        Sql.Add(' and  tblTGaProfile.title = ' +quotedstr(cbotitle.Text));

    if chkAccountname.checked =False then
      if cboAccountname.Text <> '' then
        Sql.Add(' and  tblTGaAccount.AccountName = ' +quotedstr(cboAccountname.Text));

    Sql.Add('group by tblTGaAccount.AccountName, tblTGaProfile.Title');
         if grpFilters.ItemIndex =0 then Sql.Add(',vtblTGaDataSum.Date')
    else if grpFilters.ItemIndex =1 then Sql.Add(', Week(vtblTGaDataSum.Date)')
    else if grpFilters.ItemIndex =2 then Sql.Add(', Month(vtblTGaDataSum.Date)')
    else if grpFilters.ItemIndex =3 then Sql.Add(',quarter(vtblTGaDataSum.Date)');
    Sql.Add('order by vtblTGaDataSum.Date DESC, tblTGaAccount.AccountName, tblTGaProfile.Title');
    Execute;
  finally
    Free;
  end;
  inherited;
end;

procedure TfmAnalyticsSummaryList.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainDate.FieldName);
  RemoveFieldfromGrid(qryMainFTimeonSite.FieldName);
  RemoveFieldfromGrid(qryMainDescription.FieldName);
  RemoveFieldfromGrid(qryMainquarter.FieldName);
  RemoveFieldfromGrid(qryMainmonthname.FieldName);
  RemoveFieldfromGrid(qryMainmonth.FieldName);
  RemoveFieldfromGrid(qryMainWeek.FieldName);
       if grpfilters.ItemIndex=0 then AddFieldtoGrid(qryMainDate.FieldName)
  else if grpfilters.ItemIndex=1 then AddFieldtoGrid(qryMainWeek.FieldName)
  else if grpfilters.ItemIndex=2 then AddFieldtoGrid(qryMainmonthname.FieldName)
  else if grpfilters.ItemIndex=3 then AddFieldtoGrid(qryMainquarter.FieldName);
       if grpfilters.ItemIndex=0 then qryMainDate.index:= 2
  else if grpfilters.ItemIndex=1 then qryMainWeek.index:= 2
  else if grpfilters.ItemIndex=2 then qryMainmonthname.index:= 2
  else if grpfilters.ItemIndex=3 then qryMainquarter.index:= 2;
end;

(*procedure TfmAnalyticsSummaryList.SetupFormInPanel;
begin
  inherited;
  pnlOptions.Align    := altop;
  pnlOptions.height := 30;
  HeaderPanel.Height  := HeaderPanel.Height  +pnlOptions.height;
  pnlOptions.visible := True;
  lblAccount.Left     := chktitles.Left + chktitles.Width +10;
  cboAccountname.Left := lblAccount.Left +lblAccount.Width +10;
  chkAccountname.Left :=cboAccountname.Left + cboAccountname.width +10;
  lblcustomReport.Visible    := False;
  cboCustomReports.Visible   := False;
  SetOnsameLineOneafterOther(cboFilter,label2);
  SetOnsameLineOneafterOther(label2,edtSearch,2 );
  SetOnsameLineOneafterOther(edtSearch,lblFrom, 5);
  SetOnsameLineOneafterOther(lblFrom , dtFrom,5);
  SetOnsameLineOneafterOther(dtFrom, lblto, 5);
  SetOnsameLineOneafterOther(lblto, dtto,5);

  lblTitle.Left := 1;
  lblTitle.Top := 1;
  lblTitle.height :=cbotitle.Height;
  lblTitle.Left :=label1.Left ;
  SetOnsameLineOneafterOther(lblTitle , cbotitle,10);
  SetOnsameLineOneafterOther(cbotitle , chktitles,10);
  SetOnsameLineOneafterOther(chktitles, lblAccount, 50);
  SetOnsameLineOneafterOther(lblAccount , cboAccountname,10);
  SetOnsameLineOneafterOther(cboAccountname, chkAccountname,10);

end;*)

(*procedure TfmAnalyticsSummaryList.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.Title'].asString := cbotitle.Text;
end;

procedure TfmAnalyticsSummaryList.ReadnApplyGuiPrefExtra;
begin
  inherited;
  cbotitle.Text  := GuiPrefs.Node['Options.Title'].AsString;
  chktitles.Checked := cbotitle.Text='';
end;*)

initialization
  RegisterClass(TfmAnalyticsSummaryList);

end.
