unit ERPTrainingVideos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TERPTrainingVideosGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainPagecaption: TWideStringField;
    qryMainPagehint: TWideStringField;
    qryMainFilename: TWideStringField;
    btnDownloadAll: TDNMSpeedButton;
    btnViewall: TDNMSpeedButton;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure btnDownloadAllClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnViewallClick(Sender: TObject);
  private
    fPageName: string;
    procedure SetPageName(const Value: string);
  Protected
    procedure SetGridColumns; Override;
    procedure HowtoAfterShow(Sender : TObject);
//    procedure DownloadAllAfterShow(Sender : TObject);
    procedure RefreshQuery;override;
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
  public
    procedure SelectMode;
    property PageName : string read fPageName write SetPageName;

  end;


implementation

uses CommonLib, CommonFormLib, ERPVideosLib, busobjERPVideo, FilesLib,
     HowToListFrm, {ShowMeCustomVideoList,} dbSharedObjectsObj, LogLib;

{$R *.dfm}

const
  csMainQuery = 'Select V.ID as ID, V.PageCaption as Pagecaption, V.Pagehint as Pagehint ,'#13#10 +
                'V.Filename as Filename from erpdocumentaion.tblvideos V '#13#10 +
                'where Videotype ="vtTraining" and V.active ="T" order by V.PageCaption';
  csFilterQuery = 'Select V.ID as ID, V.PageCaption as Pagecaption, V.Pagehint as Pagehint ,'#13#10 +
                'V.Filename as Filename from erpdocumentaion.tblvideos V '#13#10 +
                'inner join erpdocumentaion.tblvideospages VP on V.ID = VP.VideoId and VP.active ="T" '#13#10 +
                'where Videotype ="vtTraining" and V.active ="T"'#13#10 +
                'and PageName="%s" order by V.PageCaption';

{ TERPTrainingVideosGUI }

procedure TERPTrainingVideosGUI.btnDownloadAllClick(Sender: TObject);
var
  Qry :TERPQuery;
begin
  inherited;
  ProcessingCursor(True);
  try
    Qry := DbSharedObj.GetQuery(Qrymain.Connection);
    try
      closedb(Qry);
      Qry.SQL.Text :=' Select ID, Pagecaption,filename , mstimeStamp from erpdocumentaion.tblvideos';
      Opendb(Qry);
      if Qry.RecordCount =0 then exit;
      DoShowProgressbar(Qry.RecordCount , 'Downloading Videos');
      try
        Qry.First;
        While Qry.Eof =False do begin
          Try
            DownloadVideo(Qry.FieldByName('ID').AsInteger );
            DoStepProgressbar(Qry.FieldByName('Pagecaption').AsString);
          Except
            // kill the exception
          End;
          Qry.Next;
        end;
      finally
        DoHideProgressbar;
      end;
    finally
      DbSharedObj.ReleaseObj(Qry);
    end;
  finally
    Processingcursor(False);
  end;
end;
(*
procedure TERPTrainingVideosGUI.DownloadAllAfterShow(Sender: TObject);
var
  lForm : TShowMeCustomVideoListGUI;
begin
  if Sender is TShowMeCustomVideoListGUI then
  begin
    lForm := Sender as TShowMeCustomVideoListGUI;
    lForm.HeaderPanel.Visible := true;
    lForm.FooterPanel.Visible := true;
    lForm.Width := 488;
    lForm.pnlButtons.Visible := false;
//    lForm.TitlePanel.
//    lForm.btnDownloadAllClick(Self);
    Close;
  end;
end;
*)
procedure TERPTrainingVideosGUI.btnViewallClick(Sender: TObject);
begin
  inherited;
  EnableMultiselect('');
  try
    grdmain.selectAll;
    clog('update erpdocumentaion.tblvideos Set Active ="F"  where ', 'd:\erp.log') ;
    IterateProcno := 1;
    IterateselectedRecords
  finally
    grdMain.Options := grdMain.Options - [dgMultiselect];
  end;

end;
procedure TERPTrainingVideosGUI.IterateselectedRecordsCallback(  var Abort: boolean; SelIndex: Integer);
begin
  inherited;
  if IterateProcno = 1 then begin
    grdmaindblclick(grdmain);
    if MessageDlgXP_Vista('Log SQL? ', mtConfirmation, [mbYes,mbNo], 0) = mryes then
      Logtext('(Pagecaption = ' + quotedstr(QrymainPagecaption.asString) + ' and Pagehint = ' + quotedstr(QrymainPagehint.asString) + ' ) OR', 'd:\erp.log');
  end;

end;

procedure TERPTrainingVideosGUI.FormCreate(Sender: TObject);
begin
  inherited;
  qryMain.SQL.Text := csMainQuery;
  btnViewall.visible := Devmode;
end;

procedure TERPTrainingVideosGUI.FormShow(Sender: TObject);
begin
  inherited;
  grpfilters.itemindex := 0;
end;

procedure TERPTrainingVideosGUI.grdMainDblClick(Sender: TObject);
var
  Filename:String;
begin
    if trim(QrymainFilename.asString) = '' then begin
      ListTimerMsg('Missing Video ');
    end else if DownloadVideo(QrymainID.AsInteger)  then begin
      Filename := VideofilenamewithPath(Qrymain.FieldByName('filename').asString);
      fileslib.Openfile(filename, self.Handle , 'Training video');
    end else MessageDlgXP_Vista('Failed to Play the Video', mtWarning, [mbOK], 0);
  //inherited;
end;

procedure TERPTrainingVideosGUI.grpFiltersClick(Sender: TObject);
begin
  try
    if not(ISGrpfiltersfocussed) then exit;
  Except
    on E:Exception do begin
      Exit;
    end;
  end;

  SelectMode;
end;

procedure TERPTrainingVideosGUI.HowtoAfterShow(Sender: TObject);
begin
  if Sender is THowToListGUI then
    (Sender as THowToListGUI).SetGrpFilters;
end;

procedure TERPTrainingVideosGUI.RefreshQuery;
begin
  inherited;

end;

procedure TERPTrainingVideosGUI.SelectMode;
begin
           if (grpFilters.itemindex =0)  then  exit;
       if (grpFilters.itemindex =1) then OpenERPListForm('TERPChangesGUI', nil)
  else if (grpFilters.itemindex =2) then OpenERPListForm('TERPWebSiteChangesGUI', nil)
  else if (grpFilters.itemindex =3) then OpenERPListForm('TERPTabletChangesGUI', nil)
  else if (grpFilters.itemindex =4) then OpenERPListForm('TERPTipsGUI', nil)
  else if (grpFilters.itemindex =5) then OpenERPListForm('TERPPopupsGUI', nil)
  else if (grpFilters.ItemIndex =6) then OpenERPListForm('THowToListGUI', nil, HowToAfterShow)
  else exit;
  Self.close;
end;

procedure TERPTrainingVideosGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainID.FieldName);
  RemoveFieldfromGrid(qryMainFileName.FieldName);
end;

procedure TERPTrainingVideosGUI.SetPageName(const Value: string);
begin
  if Value = '' then
    exit;
  fPageName := Value;
  qryMain.SQL.Text := Format(csFilterQuery, [Value]);
  RefreshQuery;
end;

initialization
  RegisterClassOnce(TERPTrainingVideosGUI);
end.
