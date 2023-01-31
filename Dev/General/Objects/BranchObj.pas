unit BranchObj;

interface

uses
  Classes;

type
  TBranchObj = class(TObject)
  private
    fiBackEndID: integer;
    fsSiteCode: string;
    fsSiteDesc: string;
    fiSentID: integer;
    fdSentStamp: TDateTime;
    fiReceivedID: integer;
    fdReceivedStamp: TDateTime;
    fsEmailAddressData: string;
    fsEmailUsername: string;
    fsEmailPassword: string;
    fsConflictTodoUserId: integer;
    procedure SetSentID(const Value: integer);
    function GetSentID: integer;
    procedure SetSentStamp(const Value: TDateTime);
    function GetSentStamp: TDateTime;
    procedure SetReceivedID(const Value: integer);
    function GetReceivedID: integer;
    procedure SetReceivedStamp(const Value: TDateTime);
    function GetReceivedStamp: TDateTime;
    procedure UpdateMe(const aFieldName, aValue: string);
    function GetEmailAddressData: string;
    function GetEmailUserName: string;
    function GetEmailPassword: string;
    function GetConflictTodoUserId: integer;
  public
    constructor Create; 
    procedure PopulateMe;
    property BackEndID: integer read fiBackEndID write fiBackEndID;
    property SiteCode: string read fsSiteCode write fsSiteCode;
    property SiteDesc: string read fsSiteDesc write fsSiteDesc;
    // reading and writing following properties
    // automatically access the database
    property SentID: integer read GetSentID write SetSentID;
    property SentStamp: TDateTime read GetSentStamp write SetSentStamp;
    property ReceivedID: integer read GetReceivedID write SetReceivedID;
    property ReceivedStamp: TDateTime read GetReceivedStamp write SetReceivedStamp;
    property EmailAddressData: string read GetEmailAddressData;
    property EmailUserName: string read GetEmailUserName;
    property EmailPassword: string read GetEmailPassword;
    property ConflictTodoUserId: integer read GetConflictTodoUserId;
  end;

implementation

uses
  SysUtils, MyAccess,ERPdbComponents, CommonDbLib;

constructor TBranchObj.Create;
begin
  inherited;
  PopulateMe;
end;

procedure TBranchObj.PopulateMe;
begin
  with TERPQuery.Create(nil) do try
      Connection := CommonDbLib.GetSharedMyDacConnection;
      Sql.Add('SELECT BackEndID, SiteCode, SiteDesc, ' +
        'SentID, ReceivedID, SentStamp, ReceivedStamp, ' +
        'EmailAddressData, EmailUserName, EmailPassword, ConflictTodoUserId ' +
        'FROM tblmsBackEndID WHERE BEDefault = "T"');
      Open;
      Self.fiBackEndID := FieldByName('BackEndID').AsInteger;
      Self.fsSiteCode := FieldByName('SiteCode').AsString;
      Self.fsSiteDesc := FieldByName('SiteDesc').AsString;
      Self.fiSentID := FieldByName('SentID').AsInteger;
      Self.fiReceivedID := FieldByName('ReceivedID').AsInteger;
      Self.fdSentStamp := FieldByName('SentStamp').AsDateTime;
      Self.fdReceivedStamp := FieldByName('ReceivedStamp').AsDateTime;
      Self.fsEmailAddressData := FieldByName('EmailAddressData').AsString;
      Self.fsEmailUserName := FieldByName('EmailUserName').AsString;
      Self.fsEmailPassword := FieldByName('EmailPassword').AsString;
      Self.fsConflictTodoUserId := FieldByName('ConflictTodoUserId').AsInteger;
      Close;
    finally
      Free;
    end;
end;

procedure TBranchObj.UpdateMe(const aFieldName, aValue: string);
begin
  with TERPCommand.Create(nil) do try
      Connection := CommonDbLib.GetSharedMyDacConnection;
      Sql.Add('UPDATE tblmsBackEndID SET ' + aFieldName + ' = "' + aValue + '" ' + 'WHERE BEDefault = "T"');
      Execute;
    finally
      Free;
    end;
end;

procedure TBranchObj.SetSentID(const Value: integer);
begin
  fiSentID := Value;
  UpdateMe('SentID', IntToStr(Value));
end;

function TBranchObj.GetSentID: integer;
begin
  PopulateMe;
  Result := fiSentID;
end;

procedure TBranchObj.SetReceivedID(const Value: integer);
begin
  fiSentID := Value;
  UpdateMe('ReceivedID', IntToStr(Value));
end;

function TBranchObj.GetReceivedID: integer;
begin
  PopulateMe;
  Result := fiReceivedID;
end;

procedure TBranchObj.SetSentStamp(const Value: TDateTime);
begin
  fdSentStamp := Value;
  UpdateMe('SentStamp', FormatDateTime('yyyy-mm-dd hh:mm:ss', Value));
end;

function TBranchObj.GetSentStamp: TDateTime;
begin
  PopulateMe;
  Result := fdSentStamp;
end;

procedure TBranchObj.SetReceivedStamp(const Value: TDateTime);
begin
  fdReceivedStamp := Value;
  UpdateMe('ReceivedStamp', FormatDateTime('yyyy-mm-dd hh:mm:ss', Value));
end;

function TBranchObj.GetReceivedStamp: TDateTime;
begin
  PopulateMe;
  Result := fdReceivedStamp;
end;

function TBranchObj.GetConflictTodoUserId: integer;
begin
  PopulateMe;
  Result := fsConflictTodoUserId;
end;

function TBranchObj.GetEmailAddressData: string;
begin
  PopulateMe;
  Result := fsEmailAddressData;
end;

function TBranchObj.GetEmailPassword: string;
begin
  PopulateMe;
  Result := fsEmailPassword;
end;

function TBranchObj.GetEmailUserName: string;
begin
  PopulateMe;
  Result := fsEmailUsername;
end;

end.
