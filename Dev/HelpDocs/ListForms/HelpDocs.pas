unit HelpDocs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  THelpDocsGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainDescription: TWideStringField;
    qryMainFiletype: TWideStringField;
    qryMainIsERPTaskItem: TWideStringField;
    btnDownloadAll: TDNMSpeedButton;
    qryMainmsTimeStamp: TDateTimeField;
    qryMainfilename: TWideStringField;
    qryMainHasBlob: TWideStringField;
    qryMainModulename: TWideStringField;
    procedure btnDownloadAllClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); override;
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
  Protected
    procedure SetGridColumns; Override;
  public
  end;


implementation

uses CommonLib, DbSharedObjectsObj, HelpDocLib, busobjERPHelpdoc, FilesLib;

{$R *.dfm}

{ TBaseListingGUI1 }

procedure THelpDocsGUI.btnDownloadAllClick(Sender: TObject);
var
  Qry :TERPQuery;
begin
  inherited;
  ProcessingCursor(True);
  try
    Qry := DbSharedObj.GetQuery(Qrymain.Connection);
    try
      closedb(Qry);
      Qry.SQL.Text :=' Select * from erpdocumentaion.tblHelpdocs order by description';
      Opendb(Qry);
      if Qry.RecordCount =0 then exit;
      DoShowProgressbar(Qry.RecordCount , 'Downloading Helpdocs');
      try
        Qry.First;
        While Qry.Eof =False do begin
          Try
            DownloadHelpdoc(Qry.FieldByName('ID').AsInteger );
            DoStepProgressbar(Qry.FieldByName('description').AsString);
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

procedure THelpDocsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := False;
end;

procedure THelpDocsGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if qryMainhasblob.asBoolean =False then
    Doredhighlight(AFont, ABrush);
end;

procedure THelpDocsGUI.grdMainDblClick(Sender: TObject);
var
  Filename:String;
begin
    if trim(QrymainFilename.asString) = '' then begin
      ListTimerMsg('Missing HelpDoc ');
    end else if DownloadHelpDoc(QrymainID.AsInteger)  then begin
      Filename := HelpdocfilenamewithPath(Qrymain.FieldByName('filename').asString);
      fileslib.Openfile(filename, self.Handle , 'HelpDoc');
    end else MessageDlgXP_Vista('Failed to Play the HelpDoc', mtWarning, [mbOK], 0);
  //inherited;

end;

procedure THelpDocsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(Qrymainid.fieldname);
  RemoveFieldfromGrid(qryMainFiletype.fieldname);
  RemoveFieldfromGrid(qryMainIsERPTaskItem.fieldname);
  RemoveFieldfromGrid(qryMainmsTimeStamp.fieldname);
  RemoveFieldfromGrid(qryMainfilename.fieldname);
  RemoveFieldfromGrid(qryMainHasBlob.fieldname);
end;
initialization
  RegisterClassOnce(THelpDocsGUI);

end.
