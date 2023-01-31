unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmMainBase, DB, DBAccess, MyAccess, StdCtrls, DNMSpeedButton,
  ExtCtrls, DAScript, MyScript, MemDS, kbmMemTable, Grids, DBGrids,
  PrintDAT, Wwdbigrd, Wwdbgrid, ComCtrls;

type
  TfmMain = class(TfmMainBase)
    Query: TMyQuery;
    Table: TkbmMemTable;
    TableSaleId: TIntegerField;
    TableDescription: TStringField;
    TableBackOrder: TFloatField;
    Datasource: TDataSource;
    TableTranstype: TStringField;
    btnPrint: TDNMSpeedButton;
    dlgPrint: TPdtPrintDAT;
    ProgressBar: TProgressBar;
    QryInvalid: TMyQuery;
    tableinvalid: TkbmMemTable;
    tableinvalidCategory: TStringField;
    tableinvalidSaleId: TIntegerField;
    tableinvalidDescription: TStringField;
    tableinvalidQtysold: TFloatField;
    tableinvalidShipped: TFloatField;
    tableinvalidBackorder: TFloatField;
    datasourceinvalid: TDataSource;
    grid: TwwDBGrid;
    InvalidGrid: TwwDBGrid;
    tableinvalidOriginalTrans: TStringField;
    Invalidgprint: TPdtPrintDAT;
    procedure btnStartUpdateClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure gridCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure ScriptBeforeExecute(Sender: TObject; var SQL: String;
      var Omit: Boolean);
    procedure ScriptError(Sender: TObject; E: Exception; SQL: String;
      var Action: TErrorAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    function SendEmailtoErp(Const Subject:String; Value:String;emaillogPrefix:String='emaillog'):boolean;
    Function GetDetails:String;
  protected
    function GetDescription: string; override;
    procedure StartUpdate; override;
//    function ConnectToServer: boolean; override;
    procedure UpdateDb(const Conn: TMyConnection); override;
  public
  end;
const
  SMTPHost     = 'mail.erpaustralia.com.au';
  SMTP3Port     = 25;
  SMTPUsername = 'erplog@erpaustralia.com.au';
  SMTPPassword = 'catforpetesdinner';

var
  fmMain: TfmMain;

implementation
uses
  Idmessage, IDSmtp;
{$R *.dfm}

{ TfmMain }

function TfmMain.GetDescription: string;
begin
  result:= 'Deleting Duplicate lines from the Sales/Purchase back order';
end;

procedure TfmMain.StartUpdate;
begin
  inherited;
end;

procedure TfmMain.UpdateDb(const Conn: TMyConnection);
var
  Version: string;
  str:String;
begin
  if self.IsERPDatabase(Conn, Version) then begin
    inherited; {to log databse we are looking at ..}
    if Version >= '7.4.6.8' then begin
      Script.Connection:= Conn;
      Try
        ProgressBar.Position := 1;
        Script.Execute;
        ProgressBar.Stepit;
        str:= '    Done!';

        {records fixed}
        if Query.active then Query.close;
        Query.connection := Script.connection;
        Query.open;
        if Query.recordcount = 0 then str := '            '+ 'No mismatch found....' + Str
        else str := '            '+ intToStr(Query.recordcount) + ' mismatch found....' + Str;
        Log(Str);
        if Query.recordcount > 0 then begin
          if table.active = false then table.Active := true;
          Table.Append;
          TableDescription.asString := Query.Connection.Database;
          table.post;
          Query.First;
          While Query.eof = False do begin
            Table.Append;
            TableTranstype.asString :=Query.fieldbyname('Description').asString;
            TableDescription.asString := Query.fieldbyname('ProductName').asString;
            if Query.FieldByname('Deleted').asBoolean then
              TableDescription.asString := TableDescription.asString +'(Duplicate)';
            TableSaleId.asInteger := Query.fieldbyname('Id').asInteger;
            TableBackOrder.asFloat :=Query.fieldbyname('Backorder').asFloat;
            table.post;
            Query.next;
          end;
        end;

        {invalid records remaining}
        if QryInvalid.active then QryInvalid.close;
        QryInvalid.connection := Script.connection;
        QryInvalid.open;
        if QryInvalid.recordcount > 0 then begin
          if tableinvalid.active = false then tableinvalid.Active := true;
          tableinvalid.Append;
          tableinvalidDescription.asString := QryInvalid.Connection.Database;
          tableinvalid.post;
          QryInvalid.First;
          While QryInvalid.eof = False do begin
            tableinvalid.Append;
            tableinvalidCategory.asString :=QryInvalid.fieldbyname('Category').asString;
            tableinvalidDescription.asString := QryInvalid.fieldbyname('ProductName').asString;
            tableinvalidSaleId.asInteger := QryInvalid.fieldbyname('Id').asInteger;
            tableinvalidBackOrder.asFloat :=QryInvalid.fieldbyname('UnitofMeasureBackorder').asFloat;
            tableinvalidShipped.asFloat :=QryInvalid.fieldbyname('UnitofMeasureShipped').asFloat;
            tableinvalidQtysold.asFloat :=QryInvalid.fieldbyname('UnitofMeasureQtySold').asFloat;
            tableinvalidOriginalTrans.asString := Qryinvalid.FieldByname('baseno').asString;
            tableinvalid.post;
            QryInvalid.next;
          end;
        end;

      Except
          on E:Exception do begin
              Log(Script.connection.database +  '-> Exception : ' +E.message);
          end;
      end;
    end
    else begin
      Log('    This database is version ' + Version + ' ... this update is only for version 7.4.6.8 and above.');
    end;
  end;
end;

procedure TfmMain.btnStartUpdateClick(Sender: TObject);
begin
  ProgressBar.visible := true;
  inherited;
    if table.active = False then Table.Open;
    if tableinvalid.active = False then tableinvalid.open;
    
   btnPrint.visible := (Table.recordcount > 0 ) or (tableinvalid.recordcount > 0 );
   
   ProgressBar.StepIt;
    Progressbar.Stepit;
   try
      SendEmailtoErp('Deleting Duplicate lines from the Sales/Purchase back order',
                memLog.Lines.Text +chr(13) +chr(13) + GetDetails);

   Except
       on E:Exception do begin
        MessageDlg('Emailing status back to ERP Failed'+chr(13) +chr(13) + E.message , mtInformation , [mbok] , 0);
       end;
   end;
   Progressbar.visible := False;;
end;

procedure TfmMain.btnPrintClick(Sender: TObject);
begin
  inherited;
  if Table.Active=False then Table.Open;
  if tableinvalid.active = False then tableinvalid.open;

  IF Table.recordcount > 0 then   dlgPrint.Print;
  if tableinvalid.recordcount > 0 then   Invalidgprint.Print;
end;

procedure TfmMain.gridCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if TableSaleId.asInteger = 0 then Afont.Style := Afont.Style +[fsBold];
end;

procedure TfmMain.ScriptBeforeExecute(Sender: TObject; var SQL: String;
  var Omit: Boolean);
begin
  inherited;
  Progressbar.Stepit;
end;

procedure TfmMain.ScriptError(Sender: TObject; E: Exception; SQL: String;
  var Action: TErrorAction);
begin
  inherited;
  Log(E.Message+'->' + SQL);
  Action :=eaContinue;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  inherited;
      ProgressBar.min := 1;
      ProgressBar.max := script.SQl.count+1;
end;

function TfmMain.SendEmailtoErp(Const Subject:String; Value:String;emaillogPrefix:String='emaillog'):boolean;
var
  exMessage: TIdMessage;
  exSMTP: TIdSMTP;
begin
  result := true;
  exMessage := TIdMessage.Create(nil);
  exSMTP := TIdSMTP.Create(nil);
  try
    try

      exSMTP.Host := SMTPHost;
      exSMTP.Port := SMTP3Port;
      exSMTP.AuthenticationType := atLogin;
      exSMTP.Username := SMTPUsername;
      exSMTP.Password := SMTPPassword;
      exMessage.From.Text := 'ERPLog <binny.jacobs@erpAustralia.com.au>';
      exMessage.Recipients.EMailAddresses := 'ERPLog <binny.jacobs@erpAustralia.com.au>';
      exMessage.Subject := Subject;
      exMessage.Body.Add(Value);
      Try
        exSMTP.Connect(5000);
      except
      end;

      if exSMTP.Connected then begin 
        exSMTP.Send(exMessage)
      end;
    except
      result:=False
    end;
  finally
    FreeAndNil(exMessage);
    FreeAndNil(exSMTP);
  end;

end;
function TfmMain.GetDetails: String;
begin
  result := '';
  if Table.recordcount > 0 then begin
    REsult := 'Updated records ' +chr(13);
    result := 'Description ' +chr(vk_tab) + 'Trans Type'  + chr(vk_tab)+ 'Trans Id' +chr(vk_tab)+ 'BackOrder Qty' ;
    result := result + chr(13);
    Table.first;
    while Table.Eof = False do begin
      result := result + TableDescription.asString +chr(vk_tab)+ TableTranstype.asString + chr(vk_tab)+ TableSaleId.AsString  +chr(vk_tab)+ TableBackOrder.AsString ;
      result := result + chr(13);
      Table.next;
    end;
  end;

  if tableinvalid.recordcount > 0 then begin
    REsult := 'Sales/PO with Broken Links' +chr(13);
    result :=result + chr(13)+ 'Description ' +
            chr(vk_tab) + 'Trans Type'  +
            chr(vk_tab)+ 'Trans Id' +
            chr(vk_tab)+ 'Original Sale' +
            chr(vk_tab)+ 'Sold' +
            chr(vk_tab)+ 'Shipped'+
            chr(vk_tab)+ 'BO'  ;
    result := result + chr(13);
    tableinvalid.first;
    while tableinvalid.Eof = False do begin
      result := result + tableinvalidDescription.asString +
              chr(vk_tab)+ tableinvalidCategory.asString +
              chr(vk_tab)+ tableinvalidSaleId.AsString  +
              chr(vk_tab)+ tableinvalidOriginalTrans.asString +
              chr(vk_tab)+ tableinvalidQtysold.AsString +
              chr(vk_tab)+ tableinvalidShipped.AsString +
              chr(vk_tab)+ tableinvalidBackOrder.AsString ;
      result := result + chr(13);
      tableinvalid.next;
    end;
  end;
end;

procedure TfmMain.FormShow(Sender: TObject);
begin
  inherited;
  PageControl.ActivePage := tabMain;
end;

end.
