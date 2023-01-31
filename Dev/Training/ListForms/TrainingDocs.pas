unit TrainingDocs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg, DADump, MyDump;

type
  TTrainingDocsGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainDescription: TWideStringField;
    qryMaintype: TWideStringField;
    qryMainDoctype: TWideStringField;
    DumpTrainingDocs: TMyDump;
    conerpdocumentaion: TERPConnection;
    btnExportTofile: TDNMSpeedButton;
    qryMainModulename: TWideStringField;
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure btnExportTofileClick(Sender: TObject);
  private
    procedure ExportasScript;
    procedure DoExporintoFile;
  Protected
    procedure IterateselectedRecordsCallback(var Abort: boolean;SelIndex: Integer);Override;
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, DocReaderObj, tcConst, CommonFormLib,  ShellAPI, LogLib,
  SystemLib, DbSharedObjectsObj, CommonDbLib;

{$R *.dfm}

{ TTrainingDocsGUI }

procedure TTrainingDocsGUI.cmdExportClick(Sender: TObject);
begin
  if devmode then begin
    if SelectedRecords > 0 then begin
      iterateProcNo:= 1;
      IterateSelectedRecords;
      Exit;
    end else if QrymainId.asInteger <>0 then begin
      ExportasScript;
      Exit;
    end;
  end;
  inherited;
end;
Procedure TTrainingDocsGUI.DoExporintoFile;
var
  fsfilename: String;
  bs:TStream;
  Qry :TERPQuery;
begin
  if not devmode then exit;
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    qry.SQL.Text := 'Select * from erpdocumentaion.tblhelpdocs where ID =' + inttostr(QrymainID.asInteger);
    qry.open;
    if qry.recordcount = 1 then begin
        fsfilename:= '\\erp-svr1\Data\Corporate\PDF How Tos\Uploaded Docs\'+ ValidFileName(trim(qry.Fieldbyname('description').asString)) +'.' +Qry.fieldbyname('Filetype').AsString;
        logtext(fsfilename);
        if FileExists(fsfilename) then begin
          SysUtils.DeleteFile(fsfilename);
          sleep(500);
          logtext('file Deleted');
        end;
        bs := Qry.CreateBlobStream((Qry.findfield('HelpDoc') as TBlobField), bmRead);
        try
            with TFileStream.Create(fsfilename, fmCreate) do
              try
                CopyFrom(bs, bs.Size);
                logtext('File Created');
              finally
                Free
              end;
              sleep(500);
        finally
          Freeandnil(bs);
        end;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;


end;
procedure TTrainingDocsGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer);
begin
  if iterateProcNo = 1 then begin
    ExportasScript;
    Exit;
  end else if iterateProcNo = 2 then begin
    DoExporintoFile;
  end;
  inherited;
end;

procedure TTrainingDocsGUI.RefreshQuery;
begin
  Try
    inherited;
  Except
    on E:Exception do begin
      if pos('Unknown column ''Modulename'' in ''field list''' , E.message) >0 then begin
        MessageDlgXP_vista('Your ERP Server is Being Updating.'+NL+
                            'Please Stop and Restart the ERP Service on the ERP Server Before Running This Report', mtWarning, [mbOK], 0);
        Exit;
      end else raise ;
    end;
  End;
end;

procedure TTrainingDocsGUI.ExportasScript;
var
  s:String;
  fs:String;
  ctr:Integer;
begin
    DumpTrainingDocs.Connection := conerpdocumentaion;
    DumpTrainingDocs.BackupQuery('select * from erpdocumentaion.tblhelpdocs where ID = '+inttostr(qrymainid.AsInteger));
    for ctr := DumpTrainingDocs.SQL.count-1 downto 0 do
           if trim(DumpTrainingDocs.SQL[ctr]) = '' then DumpTrainingDocs.SQL.delete(ctr)
      else if pos('/*!' ,DumpTrainingDocs.SQL[ctr])=1 then DumpTrainingDocs.SQL.delete(ctr);
    s:=trim(DumpTrainingDocs.SQL.Text);
    s:= replacestr(s , 'INSERT INTO tblhelpdocs(', 'INSERT IGNORE INTO erpdocumentaion.tblhelpdocs(');
    s:= replacestr(s , ') VALUES (', ') Select ');
    s:=copy(s, 1, length(s)-2) +' from Dual where ucase(database()) = '+quotedstr(uppercase('ERPNEWDB'))+';';
    fs:= 'U:\SQL\'+ inttostr(qrymainID.asInteger)+'.SQL';
    clog(s , fs);
    ShellExecute(Handle, 'Open', PChar(fs), '', '', SW_SHOWNORMAL);
end;

procedure TTrainingDocsGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TfmHowToEdit' , 0);
end;

procedure TTrainingDocsGUI.btnExportTofileClick(Sender: TObject);
begin
  inherited;
  clog('');
  iterateprocno := 2;
  iteraterecords(true);
  MessageDlgXP_vista('File Export Finished', mtInformation, [mbOK], 0);
end;

procedure TTrainingDocsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := false;
  if conerpdocumentaion.connected then conerpdocumentaion.connected := False;
  conerpdocumentaion.Database := 'erpdocumentaion';
  conerpdocumentaion.Server := Qrymain.connection.server;
  conerpdocumentaion.Connected := True;
end;

procedure TTrainingDocsGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not Highlight then
    if qryMaintype.asString ='H' then
         Abrush.Color := GridColhighLightGreen
    else Abrush.Color := GridColhighLightYellow1;
end;

procedure TTrainingDocsGUI.grdMainDblClick(Sender: TObject);
begin
  if sametext(qryMaintype.asString , 'P') then begin
    TDocReaderObj.ShowERPHelp(nil, Self, true, qryMainDescription.asString);
    Exit;
  end else if sametext(qryMaintype.asString , 'H') then begin
    inherited;
  end;
end;

procedure TTrainingDocsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymainid.fieldname);
  RemoveFieldfromGrid(qryMaintype.fieldname);
end;
initialization
  RegisterClassOnce(TTrainingDocsGUI);

end.
