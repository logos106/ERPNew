unit HelpDocConfigurationList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, HelpDocs, DAScript, MyScript, ERPdbComponents, DB, SelectionDialog,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT, ImgList,
  AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  THelpDocConfigurationListGUI = class(THelpDocsGUI)
    btnUpdate: TDNMSpeedButton;
    qryMainActive: TWideStringField;
    btnHowto: TDNMSpeedButton;
    btnDelete: TDNMSpeedButton;
    btnEdit: TDNMSpeedButton;
    procedure btnUpdateClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure btnHowtoClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);
    procedure qryMainAfterScroll(DataSet: TDataSet);
    procedure btnEditClick(Sender: TObject);
  private
  Protected
    procedure SetGridColumns; Override;
    function footerbuttonRightMargin: Integer;Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses ERPDocsDBObj, AppEnvironment, CommonLib, CommonFormLib, DocReaderObj,
  CommonDbLib, DbSharedObjectsObj, tcConst;

{$R *.dfm}

procedure THelpDocConfigurationListGUI.btnEditClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TFmERPHelpDoc' , qryMainID.asinteger);

end;

procedure THelpDocConfigurationListGUI.btnHowtoClick(Sender: TObject);
begin
  inherited;
  TDocReaderObj.ShowERPHelp(nil, Self, true, 'How to make and upload Help Doc');
end;

procedure THelpDocConfigurationListGUI.btnUpdateClick(Sender: TObject);
var
  ERPDocsDB : TERPDocsDB;
begin
  inherited;
  ERPDocsDB := TERPDocsDB.Create;
  try
    ERPDocsDB.Server := appEnv.AppDb.Server;
    ERPDocsDB.ERPDatabase := appEnv.AppDb.Database;
    if ERPDocsDB.UploadhelpdocTable then
      MessageDlgXP_vista('Help Docs Configuration is Uploaded', mtInformation, [mbOK], 0);
  finally
    FreeandNil(ERPDocsDB);
  end;
end;
procedure THelpDocConfigurationListGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TFmERPHelpDoc' , 0 );
end;

function THelpDocConfigurationListGUI.footerbuttonRightMargin: Integer;
begin
  Result := 2;
end;

procedure THelpDocConfigurationListGUI.btnDeleteClick(Sender: TObject);
var
  scr :TERPScript;
  s:String;
begin
  inherited;
    if qryMainActive.asBoolean then s:= 'Delete' else s := 'Restore';

    if UserLock.Lock('erpdocumentaion.tblhelpdocs' ,qryMainID.asInteger , 'Deleting HelpDoc') then try
      if MessageDlgXP_Vista('Do You wish To '+s+NL+ quotedstr(qryMainDescription.AsString)+' ?', mtConfirmation, [mbyes, mbno], 0) = mrno then exit;

      scr := DbSharedObj.GetScript(GetNewMyDacConnection(self));
      try
        if qryMainActive.asBoolean then
          scr.SQL.add('update  erpdocumentaion.tblhelpdocs Set Active ="F" where ID = ' +inttostr(qryMainID.asInteger))
        else scr.SQL.add('update  erpdocumentaion.tblhelpdocs Set Active ="T" where ID = ' +inttostr(qryMainID.asInteger));
        scr.Execute;

        MessageDlgXP_Vista(quotedstr(qryMainDescription.AsString)+' is '+ s+'d.', mtConfirmation, [mbOk], 0);
        RefreshQuery;
      finally
        DbSharedObj.ReleaseObj(scr);
      end;
    finally
      UserLock.UnLock('erpdocumentaion.tblhelpdocs' ,qryMainID.asInteger );
    end;
end;

procedure THelpDocConfigurationListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  if qryMainActive.asBoolean =False then
    DoGrayout(AFont, ABrush)
  else inherited;
end;

procedure THelpDocConfigurationListGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Active' , ['T','F',''], False);
  inherited;
end;

procedure THelpDocConfigurationListGUI.qryMainAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if qryMainActive.asBoolean then btnDelete.caption := 'Delete'
  else btnDelete.caption := 'Restore';
  btnDelete.Refresh;
end;

procedure THelpDocConfigurationListGUI.RefreshQuery;
begin
  Try
    inherited;
  Except
    on E:Exception do begin
      if pos('Unknown column ''HD.Modulename'' in ''field list''' , E.message) >0 then begin
        MessageDlgXP_vista('Your ERP Server is Being Updating.'+NL+
                            'Please Stop and Restart the ERP Service on the ERP Server Before Running This Report', mtWarning, [mbOK], 0);
        Exit;
      end else raise ;
    end;
  End;
end;

procedure THelpDocConfigurationListGUI.SetGridColumns;
begin
  inherited;
end;

initialization
  RegisterClassOnce(THelpDocConfigurationListGUI);

end.
