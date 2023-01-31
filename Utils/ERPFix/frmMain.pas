unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBAccess, MyAccess, ERPdbComponents, StdCtrls, Shader, ExtCtrls,
  DNMSpeedButton, DNMPanel, ActnList, DNMAction, DAScript, MyScript, MemDS;

type
  TfmMain = class(TForm)
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    MyConnection: TERPConnection;
    pnlDetails: TDNMPanel;
    btnclose: TDNMSpeedButton;
    ActionList1: TActionList;
    actcheckconnection: TDNMAction;
    btndelete: TDNMSpeedButton;
    Label3: TLabel;
    Script: TERPScript;
    Query: TERPQuery;
    lblMsg: TLabel;
    DNMPanel1: TDNMPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtServer: TEdit;
    edtDatabase: TEdit;
    btnTest: TDNMSpeedButton;
    Imgcorrect: TImage;
    ImgWrong: TImage;
    procedure btnTestClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtDatabaseChange(Sender: TObject);
    procedure edtServerChange(Sender: TObject);
    procedure btndeleteClick(Sender: TObject);
    procedure btncloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    fbconnected:Boolean;
    function connected: Boolean;
    function ERPDB: boolean;
    procedure showMessage(const Value: String);
    procedure HideMessage;
    procedure enabledisable;
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

procedure TfmMain.enabledisable;
begin
  pnlDetails.Enabled  := fbconnected;
  ImgWrong.Visible    := fbconnected=False;
  Imgcorrect.Visible  := fbconnected;
  if fbconnected then HideMessage else showMessage('Provide the Server name and database name and connect before selecting the Fix Option');

end;
function TfmMain.ERPDB:boolean;
begin
  try
    With Query do begin
      if active then close;
      connection := Myconnection;
      SQL.Add('Select * from tblupdatedetails');
      open;
      result:= recordcount =1;
    end;
  except
    result:= False;
  end;
end;
function TfmMain.connected:Boolean;
begin
  fbconnected:= FAlse;
  try
    if MyConnection.Connected and (MyConnection.server = edtServer.Text) and (MyConnection.Database = edtdatabase.Text) then begin
      fbconnected:= True;
      exit;
    end;
    MyConnection.Server   := edtServer.Text;
    MyConnection.Database := edtDatabase.Text;
    try
        MyConnection.Connect;
        if not ERPDB then begin
          MessageDlg(quotedstr(edtDatabase.text) +' is not a valid ERP database', mtWarning, [mbOK], 0);
          exit;
        end;
        fbconnected:= True;
    except
      on E:Exception do begin
        MessageDlg('Server / database combination is not valid'+#13+#10+'E.Message', mtWarning, [mbOK], 0);
      end;
    end;
  finally
    result:= fbconnected;
  end;
end;

procedure TfmMain.btncloseClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfmMain.btndeleteClick(Sender: TObject);
begin
  if not connected then exit;

  if MessageDlg('Are you sure you want to delete all the New Returns including the summary?', mtConfirmation, [mbYes, mbNo], 0) = mryes then begin
  With Script do begin
    connection := Myconnection;
    SQl.Add('drop   table   if exists erpfix_tblbasreports;');
    SQl.Add('Create table   erpfix_tblbasreports like tblbasreports;');
    SQl.Add('insert into    erpfix_tblbasreports select * from tblbasreports;');
    SQl.Add('drop   table   if exists erpfix_tblbasreportlines;');
    SQl.Add('create table   erpfix_tblbasreportlines like tblbasreportlines;');
    SQl.Add('insert into    erpfix_tblbasreportlines select * from tblbasreportlines;');
    SQl.Add('delete from    tblbasreports where ID in (Select BasID from tblbasreportlines);');
    SQl.Add('delete from    tblbasreports where Active ="F";');
    SQl.Add('truncate       tblbasreportlines;');

    SQl.Add('drop   table   if exists erpfix_tblnzreturns;');
    SQl.Add('Create table   erpfix_tblnzreturns like tblnzreturns;');
    SQl.Add('insert into    erpfix_tblnzreturns select * from tblnzreturns;');
    SQl.Add('drop   table   if exists erpfix_tblnzreportlines;');
    SQl.Add('create table   erpfix_tblnzreportlines like tblnzreportlines;');
    SQl.Add('insert into    erpfix_tblnzreportlines select * from tblnzreportlines;');
    SQl.Add('delete from    tblnzreturns where ID in (Select NZID from tblnzreportlines);');
    SQl.Add('delete from    tblnzreturns where Active ="F";');
    SQl.Add('truncate       tblnzreportlines;');

    SQl.Add('drop   table   if exists erpfix_tblvatreturns;');
    SQl.Add('Create table   erpfix_tblvatreturns like tblvatreturns;');
    SQl.Add('insert into    erpfix_tblvatreturns select * from tblvatreturns;');
    SQl.Add('drop   table   if exists erpfix_tblvatreportlines;');
    SQl.Add('create table   erpfix_tblvatreportlines like tblvatreportlines;');
    SQl.Add('insert into    erpfix_tblvatreportlines select * from tblvatreportlines;');
    SQl.Add('delete from    tblvatreturns where ID in (Select VATID from tblvatreportlines);');
    SQl.Add('delete from    tblvatreturns where Active ="F";');
    SQl.Add('truncate       tblvatreportlines;');
    showMessage('Deleting Returns');
    try
      Screen.Cursor:= crHourGlass;
      Execute;
    finally
      HideMessage;
      Screen.Cursor:= crArrow;
    end;
  end;
  end;
end;
procedure TfmMain.HideMessage;
begin
  lblMsg.Visible:= False;
end;
procedure TfmMain.showMessage(Const Value:String);
begin
  lblMsg.Caption := Value;
  lblMsg.Visible:= True;
end;
procedure TfmMain.btnTestClick(Sender: TObject);
begin
  connected;
  enabledisable;
end;

procedure TfmMain.edtDatabaseChange(Sender: TObject);
begin
  fbconnected:= False;
  enabledisable;
end;

procedure TfmMain.edtServerChange(Sender: TObject);
begin
  fbconnected := False;
  enabledisable;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  fbconnected:= False;
end;

procedure TfmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then Application.Terminate;
end;

procedure TfmMain.FormShow(Sender: TObject);
begin
  enabledisable;
end;

end.

