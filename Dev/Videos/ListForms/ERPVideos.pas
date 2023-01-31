unit ERPVideos;
{TERPVideosGUI
      |-----TERPVideoConfigurationListGUI
          |-----TShowMeVideoListGUI}

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
  TERPVideosGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainPagename: TWideStringField;
    qryMainSeqno: TIntegerField;
    qryMainPagehint: TWideStringField;
    qryMainfilename: TWideStringField;
    qryMainPagecaption: TWideStringField;
    qryMainVideotype: TWideStringField;
    qryMainTaskId: TIntegerField;
    qryMainPlayVideo: TStringField;
    qryMainHelpContextID: TIntegerField;
    qryMainWorkflowID: TIntegerField;
    qryMainOpenHelp: TStringField;
    qryMainOpenWF: TStringField;
    qryMaintasktype: TWideStringField;
    qryMainVersionNo: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormCreate(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
  private
    fiVideoId: Integer;
  Protected
    CanOpenEditform:boolean;
    procedure SetGridColumns; Override;
    procedure InitFilter;Virtual;
  public
    Property VideoId:Integer read fiVideoId write fiVideoId;
  end;


implementation

uses CommonDbLib, CommonLib, SystemLib, tcConst, DbSharedObjectsObj,ShellAPI,
  busobjERPVideo, CommonFormLib, WebHelpObj, frmWorkflowPlay, ERPMessageTypes  ,
  FilesLib, ERPVideosLib;

{$R *.dfm}

{ TERPVideosGUI }



procedure TERPVideosGUI.FormCreate(Sender: TObject);
begin
  inherited;
  CanOpenEditform := true;
  BaseIndexfields:= 'PageName';
  fiVideoId:= 0;
end;

procedure TERPVideosGUI.grdMainDblClick(Sender: TObject);
var
  filename:String;
begin
  if DoOnGridDataSelect(grdmain) then exit;

  {play video}
  if Sametext(ActiveFieldname , qryMainPlayVideo.FieldName) then begin
    if trim(QrymainFilename.asString) = '' then begin
      ListTimerMsg('Missing Video ');
    end else if DownloadVideo(QrymainID.AsInteger)  then begin
      Filename := VideofilenamewithPath(Qrymain.FieldByName('filename').asString);
      Openfile(filename, self.Handle , 'Training video');
    end else MessageDlgXP_Vista('Failed to Play the Video', mtWarning, [mbOK], 0);
    Exit;
  end;

  {HELP}
  if Sametext(ActiveFieldname , qryMainOpenHelp.fieldname) then begin
    if qryMainHelpContextID.AsInteger =0 then begin
      ListTimerMsg('Missing Help Context ');
    end else begin
      try
        WebHelpObjInst.GotoHelpContext(qryMainHelpContextID.AsInteger);
      Except
        on E:Exception do begin
          MessageDlgXP_Vista('Failed to Open Help.' + iif(DEvmode , NL+NL+ E.Message , ''), mtWarning, [mbOK], 0);
        end;
      end;
    end;
    Exit;
  end;

  {Workflow}
  if Sametext(ActiveFieldname , qryMainOpenWF.fieldname) then begin
    if QrymainworkflowID.AsInteger =0 then begin
      ListTimerMsg('Missing Workflow');
    end else begin
      try
        WorkflowPlayForm.Playworkflow(QrymainworkflowID.AsInteger);
      Except
        on E:Exception do begin
          MessageDlgXP_Vista('Failed to Open Workflow.' + iif(DEvmode , NL+NL+ E.Message , ''), mtWarning, [mbOK], 0);
        end;
      end;
     Exit;
    end;
  end;

  if not CanOpenEditform then exit;// Showme videolist shouldn't open the editform

  if QrymainTaskId.AsInteger<>0 then begin
    openERPform('TfmTasks' , QrymainTaskId.AsInteger);
    Exit;
  end;

  if QrymainId.AsInteger <> 0 then begin
    openERPform('TfmERPVideo' , QrymainId.AsInteger);
    Exit;
  end;

  inherited;

end;
procedure TERPVideosGUI.InitFilter;
begin
  InitGroupfilterString('VideoType' , [vt_Training,vt_Task ,vt_Task ] , False);
       if grpfilters.itemindex =1 then groupfilterstring := groupfilterstring + ' and  Tasktype  = ' + Quotedstr(ERPMESSAGE_TIP)
  else if grpfilters.itemindex =2 then groupfilterstring := groupfilterstring + ' and  (Tasktype  = ' + Quotedstr(ERPMESSAGE_Bug)+' OR  Tasktype  = ' + Quotedstr(ERPMESSAGE_FEATURE)+')';
end;
procedure TERPVideosGUI.grpFiltersClick(Sender: TObject);
begin
  InitFilter;
  inherited;
end;

procedure TERPVideosGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if VideoID<> 0 then begin
    if Locate('ID' , vararrayof([VideoID]) , [])  then grdMain.SetActiveField(qryMainPagecaption.FieldName);
    VideoId :=0;
  end;
end;

procedure TERPVideosGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryMainPlayVideo.AsString := iif(qryMainfilename.asString       <> '' ,  ' . . .' , '');
  qryMainOpenHelp.AsString  := iif(QrymainhelpcontextID.AsInteger <> 0 ,  ' . . .' , '');
  qryMainOpenWF.AsString    := iif(qryMainWorkflowID.AsInteger    <> 0 ,  ' . . .' , '');
end;

procedure TERPVideosGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainID.FieldName);
  RemoveFieldfromGrid(qryMainSeqno.FieldName);
  RemoveFieldfromGrid(qryMainVideotype.FieldName);
  RemoveFieldfromGrid(qryMainTaskId.FieldName);
  RemoveFieldfromGrid(qryMainHelpContextID.FieldName);
  RemoveFieldfromGrid(qryMainWorkflowID.FieldName);
  RemoveFieldfromGrid(qryMainTasktype.FieldName);
end;

initialization
  RegisterClassOnce(TERPVideosGUI);
end.
