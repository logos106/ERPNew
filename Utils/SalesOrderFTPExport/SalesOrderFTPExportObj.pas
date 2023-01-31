unit SalesOrderFTPExportObj;

interface

uses
  classes;

type
  TSalesOrderFTPExport = class
  private
    fDatabaseName: string;
    fServerName: string;
    fFTPFolder: string;
    fFTPPass: string;
    fFTPHost: string;
    fFTPUser: string;
    fOutputToFile: boolean;
    fOutputToFTP: boolean;
    fOutputFolder: string;
    function FTPFile(aStream: TStream; aName: string; var msg: string): boolean;
  public
    constructor Create;
    destructor Destroy; override;
    property ServerName: string read fServerName write fServerName;
    property DatabaseName: string read fDatabaseName write fDatabaseName;
    property FTPHost: string read fFTPHost write fFTPHost;
    property FTPUser: string read fFTPUser write fFTPUser;
    property FTPPass: string read fFTPPass write fFTPPass;
    property FTPFolder: string read fFTPFolder write fFTPFolder;
    property OutputToFile: boolean read fOutputToFile write fOutputToFile;
    property OutputToFTP: boolean read fOutputToFTP write fOutputToFTP;
    property OutputFolder: string read fOutputFolder write fOutputFolder;
    function ExportSalesOrder(DocNo: string; var msg: string): boolean;
  end;

implementation

uses
  sysutils, ERPDbComponents, MySQLUtils, IdFTP;

const
  SepChar = '|';
  LineEnd = #13#10;

{ TSalesOrderFTPExport }

constructor TSalesOrderFTPExport.Create;
begin

end;

destructor TSalesOrderFTPExport.Destroy;
begin

  inherited;
end;

function TSalesOrderFTPExport.ExportSalesOrder(DocNo: string;
  var msg: string): boolean;
var
  stream: TStringStream;
  conn: TERPConnection;
  qryHead, qryLine: TERPQuery;
  sl: TStringList;
  s: string;
  x: integer;
begin
  result:= false;
  try
    if ServerName = '' then begin
      msg:= 'Database Server Name missing';
      exit;
    end;
    if DatabaseName = '' then begin
      msg:= 'Database Name missing';
      exit;
    end;
    if self.OutputToFTP then begin
      if FTPHost = '' then begin
        msg:= 'FTP Host Name missing';
        exit;
      end;
      if FTPUser = '' then begin
        msg:= 'FTP User Name missing';
        exit;
      end;
      if FTPPass = '' then begin
        msg:= 'FTP Password missing';
        exit;
      end;
    end;
    if self.OutputToFile then begin
      if OutputFolder = '' then begin
        msg:= 'Output Folder missing';
        exit;
      end;
    end;
    conn:= TERPConnection.Create(nil);
    qryHead:= TERPQuery.Create(nil);
    qryLine:= TERPQuery.Create(nil);
    try
      SetConnectionProps(conn,DatabaseName,ServerName);
      conn.Connect;
      qryHead.Connection:= conn;
      qryLine.Connection:= conn;
      qryHead.SQL.Add('select * from tblsales where InvoiceDocNumber = ' + QuotedStr(DocNo));
      qryHead.SQL.Add('and IsSalesOrder = "T"');
      qryHead.Open;
      if qryHead.IsEmpty then begin
        msg:= 'Sales Order not found for Sales Order Number: ' + DocNo;
        exit;
      end;
      qryLine.SQL.Add('select * from tblsaleslines where SaleID = ' + qryHead.FieldByName('SaleID').asString);
      qryLine.SQL.Add('order by SortId');
      qryLine.Open;
      if qryLine.IsEmpty then begin
        msg:= 'Sales Order not found for Sales Order Number: ' + DocNo;
        exit;
      end;
      stream:= TStringStream.Create;
      sl:= TStringList.Create;
      try
        stream.WriteString('H');
        stream.WriteString(SepChar);
        stream.WriteString(qryHead.FieldByName('InvoiceDocNumber').AsString);
        stream.WriteString(SepChar);
        stream.WriteString(SepChar);
        stream.WriteString(SepChar);
        stream.WriteString(FormatDateTime('yyyymmdd',qryHead.FieldByName('SaleDate').AsDateTime));
        stream.WriteString(SepChar);
        stream.WriteString(SepChar);
        stream.WriteString(qryHead.FieldByName('PONumber').AsString);
        stream.WriteString(SepChar);
        stream.WriteString(qryHead.FieldByName('CustomerName').AsString);
        stream.WriteString(SepChar);
        sl.Text:= qryHead.FieldByName('ShipTo').AsString;
        s:= '';
        if (sl.Count > 0) and SameText(Trim(sl[0]),qryHead.FieldByName('CustomerName').AsString) then
          sl.Delete(0);
        for x := 0 to sl.Count -1 do begin
          if x < sl.Count -1 then begin
            if (s <> '') then s:= s + '~';
            s:= s + sl[x];
          end
          else begin
            if Trim(sl[x]) <> '' then begin
              if (s <> '') then s:= s + '~';
              s:= s + sl[x];
            end;
          end;
        end;
        stream.WriteString(s);
        stream.WriteString(SepChar);
        stream.WriteString(LineEnd);

        while not qryLine.Eof do begin
          stream.WriteString('D');
          stream.WriteString(SepChar);
          stream.WriteString(IntToStr(qryLine.RecNo));
          stream.WriteString(SepChar);
          stream.WriteString(qryLine.FieldByName('ProductName').AsString);
          stream.WriteString(SepChar);
          stream.WriteString(qryLine.FieldByName('Product_Description').AsString);
          stream.WriteString(SepChar);
          stream.WriteString(qryLine.FieldByName('QtySold').AsString);
          stream.WriteString(SepChar);
          stream.WriteString(qryLine.FieldByName('UnitOfMeasureQtySold').AsString);
          stream.WriteString(LineEnd);
          qryLine.Next;
        end;

        if OutputToFile then
          stream.SaveToFile(OutputFolder + '\SalesOrder_' + DocNo + '.txt');
        if OutputToFTP then begin
          if not FTPFile(stream,'SalesOrder_' + DocNo + '.txt',msg) then begin
            exit;
          end;
        end;
        result:= true;
      finally
        sl.Free;
        stream.Free;
      end;
    finally
      qryHead.Free;
      qryLine.Free;
      conn.Free;
    end;
  except
    on e: exception do begin
      result:= false;
      msg:= e.Message;
    end;

  end;
end;

function TSalesOrderFTPExport.FTPFile(aStream: TStream; aName: string;
  var msg: string): boolean;
var
  ftp: TIdFTP;
  s: string;
begin
  result:= false;
  try
    ftp:= TIdFTP.Create(nil);
    try
      ftp.Host:= self.FTPHost;
      ftp.Username:= self.FTPUser;
      ftp.Password:= self.FTPPass;
      ftp.Connect;
      s:= self.FTPFolder;
      if s <> '' then s:= s + '/';
      s:= s + aName;

      ftp.Put(aStream,s);
      result:= true;
    finally
      ftp.Free;
    end;
  except
    on e: exception do begin
      msg:= e.Message;
    end;
  end;
end;

end.
