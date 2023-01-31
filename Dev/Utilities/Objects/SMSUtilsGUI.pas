unit SMSUtilsGUI;

interface

procedure PlayMessages(const aCallMessageId: string);

implementation

uses
  ERPDbComponents, StringUtils, SystemLib, CommonDbLib, DB, ShellApi, SysUtils,
  CommonLib, windows, Dialogs;

procedure PlayMessages(const aCallMessageId: string);
var
  qry: TERPQuery;
  MessageId, FileName: string;

begin
  MessageId := StringUtils.StripQuotes(aCallMessageId);
  FileName := SystemLib.GetAppTempDir + '\' + MessageId; // + '.mp3';
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text := 'select * from tblvoicemessage where CallMessageId = ' + QuotedStr(MessageId);
    qry.Open;
    if not qry.IsEmpty then begin
      while not qry.Eof do begin

        if not FileExists(FileName+ '_' + IntToStr(qry.RecNo) + '.mp3') then
          TBlobField(qry.FieldByName('Data')).SaveToFile(FileName+ '_' + IntToStr(qry.RecNo) + '.mp3');
        ShellApi.ShellExecute(0,'open',PChar(FileName+ '_' + IntToStr(qry.RecNo) + '.mp3'),nil,nil,SW_NORMAL);
        qry.Next;
      end;
    end
    else begin
      CommonLib.MessageDlgXP_Vista('No message found for this call.',mtInformation,[mbok],0);
    end;
  finally
    qry.Free;
  end;
end;


end.
