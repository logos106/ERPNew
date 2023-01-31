unit ERPDocsDBObj;

interface

uses
  ERPDbComponents, LogMessageTypes, LogThreadBase, TableToFTPObj,FiletoFTP;

type
  TERPDocsDB = class(TERPDocs)
  private
    fServer: string;
    fConn: TERPConnection;
    fDbConn: TERPConnection;
    fERPDatabase: string;
    TableToFTP: TTableToFTP;
    procedure SetServer(const Value: string);
    function GetDbConn: TERPConnection;
  protected
    property DbConn: TERPConnection read GetDbConn;
  public
    constructor Create;
    destructor Destroy; override;
    property Server: string read fServer write SetServer;
    property ERPDatabase: string read fERPDatabase write fERPDatabase;
    property Connection: TERPConnection read fConn;
//    function UpdateVideoTableFromConfigFile(var msg: string; aConfigFileName: string): boolean;
    function UploadTasks: boolean;
    function DownloadTasks: boolean;
    function UploadERPOffices: boolean;
    function DownloadERPOffices: boolean;
    function UploadVideoTable: boolean;
    function UploadhelpdocTable: boolean;
    function DownloadVideoTable: boolean;
    function DownloadhelpdocTable: boolean;
  end;

const
  VIDEO_TABLE_NAME = 'tblVideos';
  VIDEOBLOB_TABLE_NAME = 'tblVideoBlobs';
  VIDEOPAGE_TABLE_NAME = 'tblVideosPages';
  TASKS_TABLE_NAME = 'tblTasks';
  TASKSPAGE_TABLE_NAME = 'tblTasksPages';

//  USER_TASKS_TABLE_NAME = 'tblerpusermessages';
  ERP_OFFICES_TABLE_NAME = 'tblErpOffices';
  HELPDOC_TABLE_NAME = 'tblhelpdocs';
  HELPDOCBLOB_TABLE_NAME = 'tblHelpdocBlobs';

implementation

uses
  DBUtils, DbConst, classes, SysUtils, DbSharedObjectsObj, IdFTP, ERPFTPConst,
  SystemLib, AbZipper, AbZipKit, AbBase, AbBrowse, AbZBrows, AbArcTyp,
  JsonObject, JsonToDatasetFuncs, InstallConst, FileDownloadFuncs, UpdaterConst,
  CipherUtils, IdFTPCommon, MySQLUtils;

const

    tblVideos_CREATE_SQL = ' CREATE TABLE ' + VIDEO_TABLE_NAME +' ( '+
          '			ID INT(11) NOT NULL AUTO_INCREMENT, '+
          '			GlobalRef VARCHAR(255) NULL DEFAULT NULL, '+
          '			SeqNo INT(11) NULL DEFAULT NULL, '+
          '			PageHint VARCHAR(255) NULL DEFAULT NULL, '+
          '			PageCaption VARCHAR(255) NULL DEFAULT NULL, '+
          '			FileName VARCHAR(255) NULL DEFAULT NULL, '+
          '			DateCreated DATE NULL DEFAULT NULL, '+
          '			Active ENUM("T","F") NULL DEFAULT "T", '+
          '			VideoType ENUM("vtNone","vtTraining","vtTask") NULL DEFAULT "vtNone", '+
          '			msTimeStamp TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, '+
          '			HelpContextID INT(11) NULL DEFAULT NULL, '+
          '			PRIMARY KEY (ID), '+
          '			UNIQUE INDEX PageIndexCaption (PageCaption, VideoType), '+
          '			INDEX PageCaption (PageCaption) '+
          '		) COMMENT="TableVersion 10" '+
          '		COLLATE="utf8_general_ci" '+
          '		ENGINE=InnoDB; ';

    tblVideoBlobss_CREATE_SQL = ' CREATE TABLE ' + VIDEOBLOB_TABLE_NAME +' ( '+
          '			ID INT(11) NOT NULL AUTO_INCREMENT, '+
          '			GlobalRef VARCHAR(255) NULL DEFAULT NULL, '+
          '			Video LONGBLOB NULL, '+
          '			msTimeStamp TIMESTAMP NULL DEFAULT NULL, '+
          '			VideoTimeStamp TIMESTAMP NULL DEFAULT NULL, '+
          '			PRIMARY KEY (ID) '+
          '		) COMMENT="TableVersion 9" '+
          '		COLLATE="utf8_general_ci" '+
          '		ENGINE=InnoDB; ';

    tblVideospages_CREATE_SQL =' CREATE TABLE tblvideospages ( '+
          '			ID INT(11) NOT NULL AUTO_INCREMENT, '+
          '			Globalref VARCHAR(255) NULL DEFAULT NULL, '+
          '			VideoID INT(11) NULL DEFAULT NULL, '+
          '			PageName VARCHAR(40) NULL DEFAULT NULL, '+
          '			Active ENUM("T","F") NULL DEFAULT "T", '+
          '			msTimeStamp TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, '+
          '			msUpdateSiteCode VARCHAR(3) NULL DEFAULT NULL, '+
          '			PRIMARY KEY (ID), '+
          '			UNIQUE INDEX VideoID_PageName (VideoID, PageName), '+
          '			INDEX VideoID (VideoID, Active) '+
          '		) COMMENT="TableVersion 9" '+
          '		COLLATE="utf8_general_ci" '+
          '		ENGINE=InnoDB; ';


  tbltasks_CREATE_SQL =
      '	CREATE TABLE tbltasks ( ' +
      '		GlobalRef VARCHAR(255) NULL DEFAULT NULL, ' +
      '		ID INT(10) NOT NULL AUTO_INCREMENT, ' +
      '		Tasktype VARCHAR(50) NULL DEFAULT NULL, ' +
      '		VersionNo VARCHAR(50) NULL DEFAULT NULL, ' +
      '		CreatedOn DATETIME NULL DEFAULT NULL, ' +
      '		EnteredByID INT(11) NULL DEFAULT "0", ' +
      '		EnteredBy VARCHAR(50) NULL DEFAULT NULL, ' +
      '		Subject VARCHAR(255) NULL DEFAULT NULL, ' +
      '		Details LONGTEXT NULL, ' +
      '   HyperlinkText VARCHAR(255) NULL ,'+
      '		EstimatedHrs DOUBLE NULL DEFAULT "0", ' +
      '		Percentagedone DOUBLE NULL DEFAULT "0", ' +
      '		mstimeStamp TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, ' +
      '		msUpdateSiteCode VARCHAR(3) NULL DEFAULT "", ' +
      '		HelpcontextID INT(11) NULL DEFAULT NULL, ' +
      '   Active ENUM("T","F") NULL DEFAULT "T", '   +
      '   CustomerName VARCHAR(100) NULL DEFAULT "", '+
      '   ClientCode VARCHAR(5) NULL DEFAULT "" ,'+
      '   Seqno INT(11) NULL ,'+
      '   TaskNo INT(11) NULL ,'+
      '		erphelpdocDesc VARCHAR(255)  NULL DEFAULT "", ' +
      '		PRIMARY KEY (ID), ' +
      '		INDEX Tasktype (Tasktype), ' +
      '		INDEX VersionNo (VersionNo), ' +
      '		INDEX Subject (Subject) ' +
      '	) ENGINE=InnoDB  COMMENT="TableVersion 12" ;';


  tblMessagepages_CREATE_SQL =
      '	CREATE TABLE tbltaskspages ( '+
      '		ID INT(11) NOT NULL AUTO_INCREMENT, '+
      '		Globalref VARCHAR(255) NULL DEFAULT NULL, '+
      '		TaskID INT(11) NULL DEFAULT NULL, '+
      '		PageName VARCHAR(40) NULL DEFAULT NULL, '+
      '		Active ENUM("T","F") NULL DEFAULT "T", '+
      '		msTimeStamp TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, '+
      '		msUpdateSiteCode VARCHAR(3) NULL DEFAULT NULL, '+
      '		PRIMARY KEY (ID), '+
      '		UNIQUE INDEX TaskID_PageName (TaskID, PageName) '+
      '	) ENGINE=InnoDB  COMMENT="TableVersion 7" ;';


  tblERPOffices_CREATE_SQL =
    'CREATE TABLE tblerpoffices ( '  + #10 +
      '	ID            INT(11)   NOT NULL AUTO_INCREMENT, '  + #10 +
      '	Location      VARCHAR(100)  NULL DEFAULT NULL, '    + #10 +
      '	Phone         VARCHAR(50)   NOT NULL, '             + #10 +
      '	Sunday        ENUM("T","F") NOT NULL DEFAULT "F", ' + #10 +
      '	Monday        ENUM("T","F") NOT NULL DEFAULT "T", ' + #10 +
      '	Tuesday       ENUM("T","F") NOT NULL DEFAULT "T", ' + #10 +
      '	WednesDay     ENUM("T","F") NOT NULL DEFAULT "T", ' + #10 +
      '	ThursDay      ENUM("T","F") NOT NULL DEFAULT "T", ' + #10 +
      '	Friday        ENUM("T","F") NOT NULL DEFAULT "T", ' + #10 +
      '	Saturday      ENUM("T","F") NOT NULL DEFAULT "F", ' + #10 +
      '	TimeZone      DOUBLE        NOT NULL DEFAULT "0", ' + #10 +
      '	StartsAt      TIME          NOT NULL DEFAULT "00:00:00", '  + #10 +
      '	StopsAt       TIME          NOT NULL DEFAULT "00:00:00", '  + #10 +
      '	ShortDay      ENUM("Mon","Tue","Wed","Thu","Fri","Sat","Sun") NOT NULL DEFAULT "Fri", '  + #10 +
      '	ShortDayStopAt TIME         NULL DEFAULT NULL, '    + #10 +
      '	WebAddress    VARCHAR(255)  NULL DEFAULT NULL, '    + #10 +
      '`msTimeStamp` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, '+
      '	PRIMARY KEY (ID) '  + #10 +
      ') ENGINE=InnoDB COMMENT="TableVersion 7";';

    tblhelpdocs_CREATE_SQL = ' CREATE TABLE ' + HELPDOC_TABLE_NAME +' ( '+
          ' ID int(11) NOT NULL AUTO_INCREMENT, '+
          ' Description varchar(255) NOT NULL DEFAULT "", '+
          ' Filetype enum("DOCX","DOC","PDF","RTF") NOT NULL DEFAULT "DOC", '+
          ' IsERPTaskItem enum("T","F") DEFAULT "F", '+
          ' Modulename varchar(255) null default null,'+
          ' FileName varchar(255) null default null,'+
          ' Active ENUM("T","F") NULL DEFAULT "T" ,'+
          '`msTimeStamp` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, '+
          ' PRIMARY KEY (ID), '+
          ' UNIQUE KEY Description (Description) '+
          ' )  COMMENT="TableVersion 3" ENGINE=InnoDB DEFAULT CHARSET=UTF8; ';

    tblHelpdocBLOBs_CREATE_SQL = ' CREATE TABLE ' + HELPDOCBLOB_TABLE_NAME +' ( '+
          ' ID INT(11) NOT NULL AUTO_INCREMENT, '+
          ' globalref VARCHAR(255) NOT NULL, '+
          ' HelpDoc LONGBLOB NOT NULL, '+
          ' msTimeStamp TIMESTAMP NULL DEFAULT Null, '+
          ' HelpDocTimeStamp TIMESTAMP NULL DEFAULT NULL, '+
          ' PRIMARY KEY (ID) '+
          ' ) COLLATE="utf8_general_ci"   COMMENT="TableVersion 2" ENGINE=INNODB ;';

function TableVersionFromCreateSQL(createSQL: string): integer;
var
  x: integer;
  s, sVer: string;
begin
  result := 0;
  x:= Pos('TableVersion',createSQL);
  if x > 0 then begin
    s := Copy(createSQL,x + Length('TableVersion'),Length(createSQL));
    sVer := '';
    for x := 1 to Length(s) do begin
      if CharInSet(s[x], [' ','0'..'9']) then
        sVer := sVer + s[x]
      else
        break;
    end;
    result := StrToIntDef(Trim(sVer),0);
  end;
end;

{ TERPDocsDB }

constructor TERPDocsDB.Create;
begin
  fConn := DBUtils.GetNewDbConnection();
end;

destructor TERPDocsDB.Destroy;
begin
  TableToFTP.Free;
  fConn.Free;
  fDBConn.Free;
  inherited;
end;

function TERPDocsDB.DownloadERPOffices: boolean;
begin
  if not Assigned(TableToFTP) then begin
    TableToFTP := TTableToFTP.Create;
    TableToFTP.OnLog := Log;
  end;
  TableToFTP.FTPServer := ERPFTPConst.TRUE_ERP_FTP_SERVER;
  TableToFTP.FTPUserName := ERPFTPConst.TRUE_ERP_FTP_USER;
  TableToFTP.FTPPassword := ERPFTPConst.TRUE_ERP_FTP_PASSWORD;
  TableToFTP.FTPPath := FTP_DOCUMENT_PATH;
  TableToFTP.Connection := self.Connection;
  result := TableToFTP.Download(ERP_OFFICES_TABLE_NAME);
end;

function TERPDocsDB.DownloadTasks: boolean;
begin
  if not Assigned(TableToFTP) then begin
    TableToFTP := TTableToFTP.Create;
    TableToFTP.OnLog := Log;
  end;
  TableToFTP.FTPServer := ERPFTPConst.TRUE_ERP_FTP_SERVER;
  TableToFTP.FTPUserName := ERPFTPConst.TRUE_ERP_FTP_USER;
  TableToFTP.FTPPassword := ERPFTPConst.TRUE_ERP_FTP_PASSWORD;
  TableToFTP.FTPPath := FTP_DOCUMENT_PATH;
  TableToFTP.Connection := self.Connection;
  result := TableToFTP.Download(TASKS_TABLE_NAME) and
    TableToFTP.Download(TASKSPAGE_TABLE_NAME);
end;

function TERPDocsDB.DownloadVideoTable: boolean;
begin
  if not Assigned(TableToFTP) then begin
    TableToFTP := TTableToFTP.Create;
    TableToFTP.OnLog := Log;
  end;
  TableToFTP.FTPServer := ERPFTPConst.TRUE_ERP_FTP_SERVER;
  TableToFTP.FTPUserName := ERPFTPConst.TRUE_ERP_FTP_USER;
  TableToFTP.FTPPassword := ERPFTPConst.TRUE_ERP_FTP_PASSWORD;
  TableToFTP.FTPPath := FTP_DOCUMENT_PATH;
  TableToFTP.Connection := self.Connection;
  result := TableToFTP.Download(VIDEO_TABLE_NAME) and
    TableToFTP.Download(VIDEOPAGE_TABLE_NAME);
end;

function TERPDocsDB.GetDbConn: TERPConnection;
begin
  if not Assigned(fDbConn) then
    fDbConn := DBUtils.GetNewDbConnection();
  if (fDbConn.Server <> fServer) or (fDbConn.Database <> fERPDatabase)  then begin
    fDbConn.Disconnect;
    fDbConn.Server := fServer;
    fDbConn.Database := fERPDatabase;
  end;
  if not fDbConn.Connected then
    fDbConn.Connect;
  result := fDbConn;
end;


procedure TERPDocsDB.SetServer(const Value: string);
var
  sl: TStringList;
  qry: TERPQuery;
  sql: string;
begin
  fServer := Value;
  if fConn.Connected then fConn.Disconnect;
  //fConn.Server := fServer;
  MySQLUtils.SetConnectionServer(fConn,Value);
  fConn.Database := DbConst.MYSQL_DATABASE;
  fConn.Connect;
  sl := TStringList.Create;
  try
    sl.CaseSensitive := false;
    fConn.GetDatabaseNames(sl);
    if sl.IndexOf(ErpDocumentationDBName) < 0 then begin
      fConn.ExecSQL('create database ' + ErpDocumentationDBName,[]);
    end;
    fConn.Disconnect;
    fConn.Database := ErpDocumentationDBName;
    fConn.Connect;
    fConn.GetTableNames(sl);

    if sl.IndexOf(VIDEO_TABLE_NAME) < 0 then begin
      fConn.ExecSQL(tblVideos_CREATE_SQL,[]);
    end
    else begin
      qry := TERPQuery.Create(nil);
      try
        qry.Connection := fConn;
        qry.SQL.Text := 'show create table ' + VIDEO_TABLE_NAME;
        qry.Open;
        sql := qry.Fields[1].AsString;
        if TableVersionFromCreateSQL(sql) < TableVersionFromCreateSQL(tblVideos_CREATE_SQL) then begin
          fConn.ExecSQL('drop table ' + VIDEO_TABLE_NAME,[]);
          fConn.ExecSQL(tblVideos_CREATE_SQL,[]);
        end;
      finally
        qry.Free;
      end;
    end;

    if sl.IndexOf(VIDEOBLOB_TABLE_NAME) < 0 then begin
      fConn.ExecSQL(tblVideoBlobss_CREATE_SQL,[]);
    end
    else begin
      qry := TERPQuery.Create(nil);
      try
        qry.Connection := fConn;
        qry.SQL.Text := 'show create table ' + VIDEOBLOB_TABLE_NAME;
        qry.Open;
        sql := qry.Fields[1].AsString;
        if TableVersionFromCreateSQL(sql) < TableVersionFromCreateSQL(tblVideoBlobss_CREATE_SQL) then begin
          fConn.ExecSQL('drop table ' + VIDEOBLOB_TABLE_NAME,[]);
          fConn.ExecSQL(tblVideoBlobss_CREATE_SQL,[]);
        end;
      finally
        qry.Free;
      end;
    end;


    if sl.IndexOf(VIDEOPAGE_TABLE_NAME) < 0 then begin
      fConn.ExecSQL(tblVideospages_CREATE_SQL,[]);
    end
    else begin
      qry := TERPQuery.Create(nil);
      try
        qry.Connection := fConn;
        qry.SQL.Text := 'show create table ' + VIDEOPAGE_TABLE_NAME;
        qry.Open;
        sql := qry.Fields[1].AsString;
        if TableVersionFromCreateSQL(sql) < TableVersionFromCreateSQL(tblVideospages_CREATE_SQL) then begin
          fConn.ExecSQL('drop table ' + VIDEOPAGE_TABLE_NAME,[]);
          fConn.ExecSQL(tblVideospages_CREATE_SQL,[]);
        end;
      finally
        qry.Free;
      end;
    end;

    if sl.IndexOf(TASKS_TABLE_NAME) < 0 then begin
      fConn.ExecSQL(tbltasks_CREATE_SQL,[]);
    end
    else begin
      qry := TERPQuery.Create(nil);
      try
        qry.Connection := fConn;
        qry.SQL.Text := 'show create table ' + TASKS_TABLE_NAME;
        qry.Open;
        sql := qry.Fields[1].AsString;
        if TableVersionFromCreateSQL(sql) < TableVersionFromCreateSQL(tbltasks_CREATE_SQL) then begin
          fConn.ExecSQL('drop table ' + TASKS_TABLE_NAME,[]);
          fConn.ExecSQL(tbltasks_CREATE_SQL,[]);
        end;
      finally
        qry.Free;
      end;
    end;

    if sl.IndexOf(TASKSPAGE_TABLE_NAME) < 0 then begin
      fConn.ExecSQL(tblMessagepages_CREATE_SQL,[]);
    end
    else begin
      qry := TERPQuery.Create(nil);
      try
        qry.Connection := fConn;
        qry.SQL.Text := 'show create table ' + TASKSPAGE_TABLE_NAME;
        qry.Open;
        sql := qry.Fields[1].AsString;
        if TableVersionFromCreateSQL(sql) < TableVersionFromCreateSQL(tblMessagepages_CREATE_SQL) then begin
          fConn.ExecSQL('drop table ' + TASKSPAGE_TABLE_NAME,[]);
          fConn.ExecSQL(tblMessagepages_CREATE_SQL,[]);
        end;
      finally
        qry.Free;
      end;
    end;

    if sl.IndexOf(ERP_OFFICES_TABLE_NAME) < 0 then begin
      fConn.ExecSQL(tblERPOffices_CREATE_SQL,[]);
    end
    else begin
      qry := TERPQuery.Create(nil);
      try
        qry.Connection := fConn;
        qry.SQL.Text := 'show create table ' + ERP_OFFICES_TABLE_NAME;
        qry.Open;
        sql := qry.Fields[1].AsString;
        if TableVersionFromCreateSQL(sql) < TableVersionFromCreateSQL(tblERPOffices_CREATE_SQL) then begin
          fConn.ExecSQL('drop table ' + ERP_OFFICES_TABLE_NAME,[]);
          fConn.ExecSQL(tblERPOffices_CREATE_SQL,[]);
        end;
      finally
        qry.Free;
      end;
    end;

    if sl.IndexOf(HELPDOC_TABLE_NAME) < 0 then begin
      fConn.ExecSQL(tblhelpdocs_CREATE_SQL,[]);
    end
    else begin
      qry := TERPQuery.Create(nil);
      try
        qry.Connection := fConn;
        qry.SQL.Text := 'show create table ' + HELPDOC_TABLE_NAME;
        qry.Open;
        sql := qry.Fields[1].AsString;
        if TableVersionFromCreateSQL(sql) < TableVersionFromCreateSQL(tblhelpdocs_CREATE_SQL) then begin
          fConn.ExecSQL('drop table ' + HELPDOC_TABLE_NAME,[]);
          fConn.ExecSQL(tblhelpdocs_CREATE_SQL,[]);
        end;
      finally
        qry.Free;
      end;
    end;
    if sl.IndexOf(HELPDOCBLOB_TABLE_NAME) < 0 then begin
      fConn.ExecSQL(tblHelpdocBLOBs_CREATE_SQL,[]);
    end
    else begin
      qry := TERPQuery.Create(nil);
      try
        qry.Connection := fConn;
        qry.SQL.Text := 'show create table ' + HELPDOCBLOB_TABLE_NAME;
        qry.Open;
        sql := qry.Fields[1].AsString;
        if TableVersionFromCreateSQL(sql) < TableVersionFromCreateSQL(tblHelpdocBLOBs_CREATE_SQL) then begin
          fConn.ExecSQL('drop table ' + HELPDOCBLOB_TABLE_NAME,[]);
          fConn.ExecSQL(tblHelpdocBLOBs_CREATE_SQL,[]);
        end;
      finally
        qry.Free;
      end;
    end;




  finally
    sl.Free;
  end;
end;

{ Assumes file names are messages_1.dat, messages_2.dat etc }
function TERPDocsDB.UploadERPOffices: boolean;
begin
  if not Assigned(TableToFTP) then begin
    TableToFTP := TTableToFTP.Create;
    TableToFTP.OnLog := Log;
  end;
  TableToFTP.FTPServer := ERPFTPConst.TRUE_ERP_FTP_SERVER;
  TableToFTP.FTPUserName := ERPFTPConst.TRUE_ERP_FTP_USER;
  TableToFTP.FTPPassword := ERPFTPConst.TRUE_ERP_FTP_PASSWORD;
  TableToFTP.FTPPath := FTP_DOCUMENT_PATH;
  TableToFTP.Connection := self.Connection;
  result := TableToFTP.Upload(ERP_OFFICES_TABLE_NAME, '', true);
end;

function TERPDocsDB.UploadTasks: boolean;
begin
  if not Assigned(TableToFTP) then begin
    TableToFTP := TTableToFTP.Create;
    TableToFTP.OnLog := Log;
  end;
  TableToFTP.FTPServer := ERPFTPConst.TRUE_ERP_FTP_SERVER;
  TableToFTP.FTPUserName := ERPFTPConst.TRUE_ERP_FTP_USER;
  TableToFTP.FTPPassword := ERPFTPConst.TRUE_ERP_FTP_PASSWORD;
  TableToFTP.FTPPath := FTP_DOCUMENT_PATH;
  TableToFTP.Connection := self.DbConn;
  result := TableToFTP.Upload(TASKS_TABLE_NAME) and
    TableToFTP.Upload(TASKSPAGE_TABLE_NAME);
end;

function TERPDocsDB.UploadVideoTable: boolean;
begin
  if not Assigned(TableToFTP) then begin
    TableToFTP := TTableToFTP.Create;
    TableToFTP.OnLog := Log;
  end;
  TableToFTP.FTPServer := ERPFTPConst.TRUE_ERP_FTP_SERVER;
  TableToFTP.FTPUserName := ERPFTPConst.TRUE_ERP_FTP_USER;
  TableToFTP.FTPPassword := ERPFTPConst.TRUE_ERP_FTP_PASSWORD;
  TableToFTP.FTPPath := FTP_DOCUMENT_PATH;
  TableToFTP.Connection := self.Connection;
  result := TableToFTP.Upload(VIDEO_TABLE_NAME,'',true) and
    TableToFTP.Upload(VIDEOPAGE_TABLE_NAME,'',true);
end;
function TERPDocsDB.DownloadhelpdocTable: boolean;
begin
  if not Assigned(TableToFTP) then begin
    TableToFTP := TTableToFTP.Create;
    TableToFTP.OnLog := Log;
  end;
  TableToFTP.FTPServer := ERPFTPConst.TRUE_ERP_FTP_SERVER;
  TableToFTP.FTPUserName := ERPFTPConst.TRUE_ERP_FTP_USER;
  TableToFTP.FTPPassword := ERPFTPConst.TRUE_ERP_FTP_PASSWORD;
  TableToFTP.FTPPath := FTP_DOCUMENT_PATH;
  TableToFTP.Connection := self.Connection;
  result := TableToFTP.Download(HELPDOC_TABLE_NAME) ;
end;
function TERPDocsDB.UploadhelpdocTable: boolean;
begin
  if not Assigned(TableToFTP) then begin
    TableToFTP := TTableToFTP.Create;
    TableToFTP.OnLog := Log;
  end;
  TableToFTP.FTPServer := ERPFTPConst.TRUE_ERP_FTP_SERVER;
  TableToFTP.FTPUserName := ERPFTPConst.TRUE_ERP_FTP_USER;
  TableToFTP.FTPPassword := ERPFTPConst.TRUE_ERP_FTP_PASSWORD;
  TableToFTP.FTPPath := FTP_DOCUMENT_PATH;
  TableToFTP.Connection := self.Connection;
  result := TableToFTP.Upload(HELPDOC_TABLE_NAME,'',true) ;
end;


end.

