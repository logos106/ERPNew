unit ERPVideoConfigurationList;
{TERPVideosGUI
      |-----TERPVideoConfigurationListGUI
          |-----TShowMeVideoListGUI}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ERPVideos, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,
  CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList,
  AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TERPVideoConfigurationListLISt = class(TERPVideosGUI)
    btnDownloadAll: TDNMSpeedButton;
    btnUpdate: TDNMSpeedButton;
    procedure btnDownloadAllClick(Sender: TObject);
    procedure HeaderPanelDblClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
  private
    procedure initERPVideo(Sender: TObject);
  Protected
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
  public
  end;


implementation

uses DbSharedObjectsObj, tcConst, SystemLib, CommonLib, CommonDbLib, LogLib,
  busobjERPVideo, CommonFormLib, frmERPVideo, ERPDocsDBObj, AppEnvironment,
  ERPVideosLib;

{$R *.dfm}

procedure TERPVideoConfigurationListLISt.btnDownloadAllClick(Sender: TObject);
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

procedure TERPVideoConfigurationListLISt.btnUpdateClick(Sender: TObject);
var
  ERPDocsDB : TERPDocsDB;
begin
  inherited;
  ERPDocsDB := TERPDocsDB.Create;
  try
    ERPDocsDB.Server := appEnv.AppDb.Server;
    ERPDocsDB.ERPDatabase := appEnv.AppDb.Database;
    if ERPDocsDB.UploadTasks and ERPDocsDB.UploadVideoTable then
      MessageDlgXP_vista('ERP Video Configuration is Uploaded', mtInformation, [mbOK], 0);

  finally
    FreeandNil(ERPDocsDB);
  end;

end;

procedure TERPVideoConfigurationListLISt.cmdNewClick(Sender: TObject);
begin
  inherited;
  if grpfilters.itemindex = 0 then
    OpenERPForm('TfmERPVideo' , 0 , nil , initERPVideo)
  else OpenERPForm('TfmTasks' , 0 , nil  );
end;
procedure TERPVideoConfigurationListLISt.initERPVideo(Sender:TObject);
begin
  if not(Sender is  TfmERPVideo) then exit;
  TfmERPVideo(Sender).videotype := vtTraining;
end;
procedure TERPVideoConfigurationListLISt.HeaderPanelDblClick(Sender: TObject);
begin
  inherited;
  if not(devmode) then exit;
  Iteraterecords(true);
end;

procedure TERPVideoConfigurationListLISt.IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);
var
  fsfilename:String;
begin
  inherited;
  fsFilename := VideofilenamewithPath(Qrymain.FieldByName('filename').asString);
  if fileExists(fsfilename) then begin
      With TempMyQuery do try
        SQl.Text :='Select * from  erpdocumentaion.tblvideoblobs where id = ' + inttostr(QrymainId.AsInteger);
        open;
        edit;
        TBlobfield(fieldbyname('Video')).LoadFromFile(fsfilename);
        post;
      finally
        ClosenFree;
      end;
  end else begin
    logtext(fsFilename + ' file not found');
    ListTimerMsg(fsFilename + ' file not found');
  end;
end;

initialization
  RegisterClassOnce(TERPVideoConfigurationListLISt);


end.
