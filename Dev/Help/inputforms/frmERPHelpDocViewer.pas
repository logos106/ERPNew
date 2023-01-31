unit frmERPHelpDocViewer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOleContainerViewer, ProgressDialog, DB, MemDS, DBAccess,
  MyAccess, ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts,
  SelectionDialog, Menus, ExtCtrls, Shader, DNMSpeedButton, OleCtnrs, DNMPanel,
  StdCtrls, AdvScrollBox;

type
  TfmERPHelpDocViewer = class(TBaseOleContainerViewerGUI)
    dsERPHelpDocs: TDataSource;
    qryERPHelpDocs: TERPQuery;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdCancelClick(Sender: TObject);
    procedure Maximize1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    fsERPHelpDocDescription: String;
    fsFilenamePrefix:string;
    fsfilename:String;
  public
    Property ERPHelpDocDescription :String read fsERPHelpDocDescription write fsERPHelpDocDescription;
    function Load:Boolean;

    class Function  showERPHelpDoc(ParentPanel: TDNMPanel;    fERPHelpDocDescription: String) : TfmERPHelpDocViewer;Overload;
    Procedure showERPHelpDoc(fERPHelpDocDescription: String) ;Overload;
  end;


implementation

uses CommonLib, CommonDbLib, SystemLib, DNMLib, LogLib, shellapi;

{$R *.dfm}

{ TfmERPHelpDocViewer }

procedure TfmERPHelpDocViewer.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfmERPHelpDocViewer.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TfmERPHelpDocViewer.FormCreate(Sender: TObject);
begin
  inherited;
  fsFilenamePrefix:='ERPHelpDoc_' +  GetTemporaryTableNameSuffix+'_';
end;

procedure TfmERPHelpDocViewer.FormDestroy(Sender: TObject);
begin
  DeleteFiles(Wintempdir,fsFilenamePrefix+'*.*');
  inherited;

end;

function TfmERPHelpDocViewer.Load:Boolean;
var
  bs:TblobStream;
begin
  REsult := false;
  if (qryERPHelpDocs.Active =False) or (not(Sametext(qryERPHelpDocs.FieldByName('Description').AsString , ERPHelpDocDescription))) then begin
      Closedb(qryERPHelpDocs);
      qryERPHelpDocs.SQL.Text := 'Select * from erpdocumentaion.tblhelpdocs where Description =' + quotedstr(ERPHelpDocDescription);
      OpenDB(qryERPHelpDocs);
  end;
  if qryERPHelpDocs.recordcount =0 then exit;
  TitleLabel.caption :=qryERPHelpDocs.FieldByName('Description').AsString ;
  caption :=qryERPHelpDocs.FieldByName('Description').AsString ;
  bs := TBlobStream.Create ((qryERPHelpDocs.findfield('HelpDoc') as TBlobField), bmRead);
  //fsFilenamePrefix:=replacestr(Wintempdir+'\' + GetUserTemporaryFileName('ERPHelpDoc') , '.tmp' , '.' +qryERPHelpDocs.fieldbyname('Filetype').AsString);
  fsfilename:=Wintempdir+fsFilenamePrefix+FormatdateTime('hhnnsszzz', now)+'.' +qryERPHelpDocs.fieldbyname('Filetype').AsString;
  logtext(fsfilename);
  with TFileStream.Create(fsfilename, fmCreate) do
      try
        CopyFrom(bs, bs.Size)
      finally
        Free
      end;
  Container.CreateObjectFromFile(fsfilename, false);
  REsult := True;
end;

procedure TfmERPHelpDocViewer.Maximize1Click(Sender: TObject);
begin
  inherited;
  //TfmERPHelpDocViewer.showERPHelpDoc(nil , ERPHelpDocDescription);
  ShellExecute(0,'open',PChar(fsFilename),nil,nil,SW_NORMAL)
end;

procedure TfmERPHelpDocViewer.showERPHelpDoc(fERPHelpDocDescription: String);
begin
  ERPHelpDocDescription := fERPHelpDocDescription;
  Load;
end;

class Function  TfmERPHelpDocViewer.showERPHelpDoc(ParentPanel: TDNMPanel;    fERPHelpDocDescription: String) : TfmERPHelpDocViewer;
begin

  if assigned(ParentPanel) then begin
    Result := TfmERPHelpDocViewer(GetComponentByClassName('TfmERPHelpDocViewer' , False, ParentPanel.Owner , False));
    if not(Assigned(Result)) then exit;
    Result.pnlContainer.Parent :=ParentPanel;
    Result.showERPHelpDoc(fERPHelpDocDescription);
    Result.SetOpenOption;
  end else begin
    Result := TfmERPHelpDocViewer(GetComponentByClassName('TfmERPHelpDocViewer' , False, nil , False));
    if not(Assigned(Result)) then exit;
    Result.showERPHelpDoc(fERPHelpDocDescription);
    Result.formStyle := fsMdichild;
    Result.BringTofront;
  end;
  (*Result.ERPHelpDocDescription := fERPHelpDocDescription;
  Result.Load;
  Result.container.Parent :=ParentPanel;*)
end;

initialization
  RegisterClassOnce(TfmERPHelpDocViewer);

end.
