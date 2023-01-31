unit frmERPVideo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase , busobjERPVideo, Mask, wwdbedit, wwdblook,
  ERPDbLookupCombo, wwcheckbox, Grids, Wwdbigrd, Wwdbgrid, Buttons;

type


  TfmERPVideo = class(TBaseInputGUI)
    Qryvideos: TERPQuery;
    dsvideos: TDataSource;
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    lblPartname: TLabel;
    edtPart: TwwDBEdit;
    wwDBEdit1: TwwDBEdit;
    Label1: TLabel;
    OpenDialog1: TOpenDialog;
    Label2: TLabel;
    wwDBEdit2: TwwDBEdit;
    btnchoosefile: TDNMSpeedButton;
    cboPagename: TwwDBLookupCombo;
    Label3: TLabel;
    QryPagenames: TERPQuery;
    QryPagenamesPagename: TWideStringField;
    QryvideosID: TIntegerField;
    QryvideosGlobalRef: TWideStringField;
    QryvideosSeqno: TIntegerField;
    QryvideosPagehint: TWideStringField;
    QryvideosPageCaption: TWideStringField;
    Qryvideosfilename: TWideStringField;
    QryvideosDateCreated: TDateField;
    QryvideosActive: TWideStringField;
    QryvideosmsTimeStamp: TDateTimeField;
    QryvideosVideotype: TWideStringField;
    chkActive: TwwCheckBox;
    lblHelp: TLabel;
    edtHelp: TwwDBEdit;
    QryvideosHelpContextID: TIntegerField;
    grdaccounts: TwwDBGrid;
    QryVideospages: TERPQuery;
    dsVideospages: TDataSource;
    QryVideospagesID: TIntegerField;
    QryVideospagesGlobalref: TWideStringField;
    QryVideospagesVideoID: TIntegerField;
    QryVideospagesPageName: TWideStringField;
    QryVideospagesActive: TWideStringField;
    QryVideospagesmsTimeStamp: TDateTimeField;
    QryVideospagesmsUpdateSiteCode: TWideStringField;
    wwDBGrid1IButton: TwwIButton;
    qryvideoblobs: TERPQuery;
    qryvideoblobsID: TIntegerField;
    qryvideoblobsGlobalRef: TWideStringField;
    qryvideoblobsVideo: TBlobField;
    qryvideoblobsmsTimeStamp: TDateTimeField;
    qryvideoblobsVideoTimeStamp: TDateTimeField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnchoosefileClick(Sender: TObject);
    procedure cboPagenameCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboPagenameNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: string; var Accept: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QryvideosAfterInsert(DataSet: TDataSet);
    procedure wwDBGrid1IButtonClick(Sender: TObject);
    procedure grdaccountsCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdaccountsDblClick(Sender: TObject);
    procedure QryvideosAfterScroll(DataSet: TDataSet);
    procedure edtPartDblClick(Sender: TObject);
  private
    fVideoType: TVideoType;
    function SaveRecord: Boolean;
    procedure loadImage(aFilename: String);
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    ERPVideoObj: TERPVideo;
    Property VideoType : TVideoType read fVideoType write fVideoType;
  end;


implementation

uses CommonLib, BusObjConst, FormFactory, (*Objvideos, *)ERPLib, ERPVideosLib;

{$R *.dfm}

procedure TfmERPVideo.cmdCancelClick(Sender: TObject);
begin
  inherited;
  if fsModal in FormState then modalresult := mrCancel else Self.Close;
end;

Function TfmERPVideo.SaveRecord :Boolean;
begin
  result:= False;
  if not(ERPVideoObj.Save) then exit;
  Result:= True;
end;

procedure TfmERPVideo.grdaccountsCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not ERPVideoObj.VideoPages.Active then AFont.Color := clDkGray;
end;

procedure TfmERPVideo.grdaccountsDblClick(Sender: TObject);
begin
  inherited;
  if not ERPVideoObj.VideoPages.Active  then begin
    if MessageDlgXP_vista('This Page is deleted for this Video. Do you want to restore it?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
    ERPVideoObj.VideoPages.Active := True;
    ERPVideoObj.VideoPages.PostDB;
  end;

end;

procedure TfmERPVideo.wwDBGrid1IButtonClick(Sender: TObject);
begin
  inherited;
  ERPVideoObj.VideoPages.PostDB;
  if ERPVideoObj.VideoPages.Count =0 then exit;
  if not ERPVideoObj.VideoPages.Active then exit;
  ERPVideoObj.VideoPages.Active := False;
  ERPVideoObj.VideoPages.PostDb;
end;

procedure TfmERPVideo.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  ERPVideoObj.dirty := False;
  ERPVideoObj.Connection.CommitTransaction;
  if fsModal in FormState then modalresult := mrOk else Self.Close;

end;

procedure TfmERPVideo.btnchoosefileClick(Sender: TObject);
var
  fsFilename:String;
begin
  inherited;
  if not OpenDialog1.Execute then exit;
  fsfilename := Opendialog1.FileName;
  loadImage(fsfilename);
  if devmode then begin
    if ERPVideoObj.PageCaption = '' then ERPVideoObj.PageCaption  := replacestr(replacestr(fsfilename , 'mp4' , ''), 'avi' , '');
    Setcontrolfocus(grdaccounts);
  end;

end;
procedure TfmERPVideo.loadImage(aFilename:String);
var
  filepath :String;
begin
  closedb(qryvideoblobs);
  qryvideoblobs.SQL.Text := 'SELECT * FROM erpdocumentaion.tblvideoblobs where ID = ' + inttostr(QryvideosID.AsInteger);
  opendb(qryvideoblobs);

  editDB(qryvideoblobs);
  TBlobfield(qryvideoblobsVideo).LoadFromFile(aFilename);
  postDB(qryvideoblobs);
  ERPVideoObj.EditDB;
  //TBlobfield(QryvideosVideo).LoadFromFile(aFilename);
  filepath := ExtractShortPathName(ExtractFilePath(aFilename));
  ERPVideoObj.filename :=ExtractFileName(aFilename);
  ERPVideoObj.PostDB;
  if not(Sametext(ExtractFilePath(aFilename) , VideoDirectory)) and not(Sametext(ExtractShortPathName(ExtractFilePath(aFilename)) , VideoDirectory))  then
    try
      CopyFile(pchar(aFilename ), pchar(VideoDirectory+ERPVideoObj.filename), true);
    Except
    end;
end;

procedure TfmERPVideo.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
     inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
             if Sender is TERPVideo   then TERPVideo(Sender).Dataset  := Qryvideos
        else if Sender is TVideoPages then TVideoPages(Sender).Dataset:= QryVideospages;
     end else if (Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_BeforeOpen) then begin
        if Sender is TERPVideo then doshowProgressbar(1 , 'Loading Video');
     end else if (Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterOpen) then begin
        if Sender is TERPVideo then doHideProgressbar;
     end;
end;

procedure TfmERPVideo.edtPartDblClick(Sender: TObject);
var
  fsfilename1, fsfilename2 :String  ;
begin
  inherited;
  if devmode then
    if Qryvideosfilename.asString = '' then begin
      fsfilename1 :='\\DEMO1-PC\Corporate\TrueERP KPI''s\2016\Binny to Load in ERP\Work Flows\Loaded now by Binny\'+QryvideosPageCaption.AsString+'.mp4';
      fsfilename2 :='\\DEMO1-PC\Corporate\TrueERP KPI''s\2016\Binny to Load in ERP\Work Flows\Loaded now by Binny\'+QryvideosPageCaption.AsString+'.mp4';
      loadImage(fsfilename1);
      MoveFileEx(PChar(fsfilename1),PChar(fsfilename2), MOVEFILE_REPLACE_EXISTING + MOVEFILE_WRITE_THROUGH);
    end;
end;

procedure TfmERPVideo.cboPagenameCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  //ERPVideoObj.Pageindex := QryPagenamesPageindex.asInteger;
end;

procedure TfmERPVideo.cboPagenameNotInList(
  Sender: TObject; LookupTable: TDataSet; NewValue: string;
  var Accept: Boolean);
begin
  inherited;
  //ERPVideoObj.Pageindex := 0;
end;

procedure TfmERPVideo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if fsModal in FormState then else action := caFree;
end;

procedure TfmERPVideo.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if ERPVideoObj.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveRecord then begin
            if fsModal in FormState then modalresult := mrOk ;
            CommitAndNotify;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          if fsModal in FormState then modalresult := mrCancel;
          ERPVideoObj.Dirty := false;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
          cmdCancel.Enabled := True;
        end;
    end;
  end else begin
    CanClose := true;
    Notify(false);
  end;

end;

procedure TfmERPVideo.FormCreate(Sender: TObject);
begin
  inherited;
  ERPVideoObj := TERPVideo.CreateWithNewConn(Self);
  ERPVideoObj.Connection.connection := Self.MyConnection;
  ERPVideoObj.BusObjEvent := DoBusinessObjectEvent;
  fVideoType := vtNone;
  if IsERPCustomEnabled then begin
    edtHelp.visible := True;
    lblHelp.visible := True;
  end else begin
    edtHelp.visible := False;
    lblHelp.visible := False;
  end;
  if devmode then
    opendialog1.InitialDir := 'W:\Development\Training videos';
end;
procedure TfmERPVideo.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen: Array Of String;
begin
  inherited;
  ERPVideoObj.Load(KeyID);
  ERPVideoObj.connection.BeginTransaction;
  if ERPVideoObj.count=0 then ERPVideoObj.new
  else VideoType := StringToVideoType(QryvideosVideotype.AsString);
  ERPVideoObj.VideoPages;
  Setlength(QueryNamesNotToOpen, 1);
  QueryNamesNotToOpen[0] := 'qryvideoblobs';
  openQueries(QueryNamesNotToOpen);
end;

procedure TfmERPVideo.QryvideosAfterInsert(DataSet: TDataSet);
begin
  inherited;
  QryvideosVideotype.AsString := VideoTypeToString(VideoType);
end;

procedure TfmERPVideo.QryvideosAfterScroll(DataSet: TDataSet);
begin
  inherited;
  (*closedb(qryvideoblobs);
  qryvideoblobs.SQL.Text := 'SELECT * FROM erpdocumentaion.tblvideoblobs where ID = ' + inttostr(QryvideosID.AsInteger);
  opendb(qryvideoblobs);*)
end;

initialization
  RegisterClassOnce(TfmERPVideo);
  with FormFact do
  begin
    RegisterMe(TfmERPVideo, 'TERPVideoConfigurationListGUI_*=ID');
  end;

end.

