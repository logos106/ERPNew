unit HowtoUtils;

interface
uses
  SysUtils, Classes, Contnrs, Graphics, dmMainGui, ERPCustomStepComponent, ERPStepDisplay, ERPStepEdit;

type
  THowToDispalyClass = class of TCustomStepDisplay;

  THowToStepList = class(TObjectList)
  private
    fHeader: String;
    fHowToId: integer;
    fHeight: integer;
    FDeletedList: TObjectList;
    fAuthorName: string;
    fCompanyName: string;
    fFlows: integer;
    fActions: integer;
    fVideos: integer;
    fSteps: integer;
    procedure SetDeletedList(const Value: TObjectList);
    function GetSteps: integer;
  protected
    property DeletedList : TObjectList read FDeletedList write SetDeletedList;
  public
    function Add(AObject : TObject) : integer;
    procedure Delete(AObject : TStepEdit);

    constructor Create(aHowToId : integer);reintroduce;overload;//reintroduce;override;
    constructor Create;overload;
    destructor Destroy;override;
    procedure Load(AClass : THowToDispalyClass; AOwner : TComponent);
    procedure Save;
    property Header : String read fHeader write fHeader;
    property HowToId : integer read fHowToId write fHowToId;
    property Height : integer read fHeight write fHeight;
    property AuthorName : string read fAuthorName write fAuthorName;
    property CompanyName: string read fCompanyName write fCompanyName;
    property Steps : integer read GetSteps;
    property Flows : integer read fFlows;
    property Videos : integer read fVideos;
    property Actions : integer read fActions;
  end;



implementation
uses
  CommonDBLib, ERPdbComponents, AppEnvironment;
{ THowToStepList }

function THowToStepList.Add(AObject: TObject): integer;
begin
  Result := inherited;
  Height := Height + TCustomStepDisplay(AObject).Height;
end;

constructor THowToStepList.Create(aHowToId: integer);
const
{  csLoadQry =  'select h.HowToId, h.Description, h.EmployeeId,'#13#10 +
               'Trim(Concat(ifnull(e.FirstName, ""), " ", ifnull(e.LastName, ""))) as AuthorName,'#13#10+
               'ifnull(h.CompanyName, "") as CompanyName'#13#10+
               'from tblHowTo h'#13#10+
               'inner join tblEmployees e on e.Employeeid = h.employeeid'#13#10+
               'where HowToId=%d'#13#10+
               'union all'#13#10+
               'select h.HowToId, h.Description, h.EmployeeId, "" as AuthorName,'#13#10+
               'ifnull(h.CompanyName, "") as CompanyName'#13#10+
               'from tblHowTo h  where h.EmployeeId = 0 and HowToId = %d';
}
  csLoadQuery = 'select * from tblHowTo where HowToId=%d';
var
  qry : TERPQuery;
begin
  inherited Create(false);
  DeletedList := TObjectList.Create(true);

  // Defaults
  AuthorName := Appenv.Employee.EmployeeName;
  CompanyName := Appenv.CompanyInfo.CompanyName;

  HowToId := aHowToId;

  if HowToId = 0 then
    exit;

  qry := TempMyQuery;
  try
//    qry.sql.text := Format(csLoadQry, [aHowToId, aHowToId]);
    qry.SQL.Text := Format(csLoadQuery, [aHowToId]);
    qry.Open;
    if not qry.Eof  then
    begin
      Header := qry.FieldByName('Description').AsString;
//      EmployeeId := qry.FieldByName('EmployeeId').asInteger;
      AuthorName := qry.FieldByName('AuthorName').asString;
      CompanyName := qry.FieldByName('CompanyName').asString;
    end;
    (*
    else
    begin
//      EmployeeId := Appenv.Employee.EmployeeID;
      AuthorName := Appenv.Employee.EmployeeName;
      CompanyName := Appenv.CompanyInfo.CompanyName;
    end;
    *)
  finally
    qry.Free;
  end;

end;

constructor THowToStepList.Create;
begin
  Create(0);
end;

procedure THowToStepList.Delete(AObject: TStepEdit);
var
  idx : integer;
begin

  if not (AObject is TStepEdit) then
    exit;

  idx := IndexOf(AObject);
  if idx >= 0 then
  begin
    Items[idx] := nil;
    DeletedList.Add(AObject);
    Pack;
  end;
end;

destructor THowToStepList.Destroy;
begin
  FreeAndNil(fDeletedList);
  Self.OwnsObjects := true;
  inherited;
end;

function THowToStepList.GetSteps: integer;
begin
  Result := Count;
end;

procedure THowToStepList.Load(AClass: THowToDispalyClass; AOwner : TComponent);
var
  qry : TERPQuery;
  step : TCustomStepDisplay;
  lBitmap : TBitmap;

begin
  inherited;

  fSteps := 0;
  fFlows := 0;
  fActions := 0;
  fVideos := 0;

  if HowToId = 0  then
    exit;

  lBitmap := TBitmap.Create;

  try
    qry := TempMyQuery;
    try
      qry.SQL.Text := 'SELECT * FROM tblHowToLines where HowToId = ' + IntToStr(HowToId) + ' order by StepNo';
      qry.Open;
      while not qry.EOF do
      begin
        step := AClass.Create(AOwner);
        Step.StepNo := qry.FieldByName('StepNo').AsInteger;
        Step.WorkFlowText := qry.FieldByName('FlowText').AsString;
        Step.FormText := qry.FieldByName('FormText').AsString;
        Step.Description := qry.FieldByName('Description').AsString;
        Step.Header := qry.FieldByName('Header').AsString;
        Step.FormClassName := qry.FieldByName('FormClassName').AsString;
        if Step.FormClassName <> '' then
          fActions := fActions + 1;
        Step.WorkFlowId := qry.FieldByName('FlowId').AsInteger;
        if Step.WorkFlowId <> 0 then
          fFlows := fFlows + 1;
        Step.HowToLineId := qry.FieldByName('HowToLineId').AsInteger;
        Step.ImageIndex := qry.FieldByName('FormImageIndex').AsInteger;
        Step.VideoFile := qry.FieldByName('VideoFile').AsString;
        Step.VideoText := qry.FieldByName('VideoText').AsString;
        if Step.VideoFile <> '' then
          fVideos := fVideos + 1;
        if Step.ImageIndex >= 0 then
        begin
          dtmMainGUI.ImageListSmlIcons.GetBitmap(Step.ImageIndex, lBitmap);
          Step.FormGlyph := lBitmap;
        end;
        Add(Step);
        qry.Next;
      end;
    finally
      FreeAndNil(qry);
    end;
  finally
    lBitmap.Free;
  end;

end;

procedure THowToStepList.Save;
const
  csUpdateQuery = 'UPDATE tblHowTo SET'#13#10+
                  'Description="%s", AuthorName="%s", CompanyName="%s"'#13#10+
                  'WHERE HowToId=%d';
  csUpdateQueryNoCompany = 'UPDATE tblHowTo SET'#13#10+
                  'Description="%s", AuthorName="%s"'#13#10+
                  'WHERE HowToId=%d';
var
  qry : TERPQuery;
  idx : integer;
  lStep : TStepEdit; //TCustomStepDisplay;

  function StFormat(const aString : string) : string;inline;
  begin
    Result := '"' + aString + '",';
  end;

  function FileFormat(const aString : string) : string;
  var
    idx : integer;
  begin
    if aString = '' then
    begin
      Result := '""';
      exit;
    end;
    Result := '"';
    for idx := 1 to Length(aString) do
      if aString[idx] = '\' then
        Result := Result + '\\'
      else
        Result := Result + aString[idx];
    Result := Result + '"';
  end;

begin
  qry := TempMyQuery;
  try
    qry.Connection.StartTransaction;
    try
      if HowToId = 0 then
      begin
        qry.SQL.Clear;
        qry.SQL.Add('Select * from tblHowTo');
        qry.Open;
        qry.Append;
        qry.FieldByName('Description').AsString := Header;
        qry.FieldByName('AuthorName').AsString := AuthorName;
        qry.FieldByName('CompanyName').asString := CompanyName;
        qry.Post;
        HowToId := qry.FieldByName('HowToId').AsInteger;
      end
      else
      begin
        if CompanyName = '' then
          qry.SQL.Text := Format(csUpdateQueryNoCompany, [Header, AuthorName, HowToId])
        else
          qry.SQL.Text := Format(csUpdateQuery, [Header, AuthorName, CompanyName, HowToId]);
        qry.ExecSQL;
      end;


      if assigned(DeletedList) and (DeletedList.Count > 0) then
      begin
        qry.Close;
        qry.SQL.Clear;
        qry.SQL.Add('DELETE FROM tblHowToLines where HowToId = ' + intToStr(HowToId));
        qry.Execute;
        DeletedList.Free;
        DeletedList := TObjectList.Create(true);
      end;


      for idx := 0 to Count - 1 do
      begin
        lStep := TStepEdit(Items[idx]);
        qry.Close;
        qry.SQL.Clear;
        qry.SQL.Add('insert into tblHowToLines (StepNo, Header, Description, FormText, FlowText, FormClassName, FlowId, FormImageIndex, HowToId, VideoFile, VideoText) VALUES (');
        qry.SQL.Add(IntToStr(lStep.StepNo) + ',');
        qry.SQL.Add(StFormat(lStep.Header));
        qry.SQL.Add(StFormat(lStep.Description));
        qry.SQL.Add(StFormat(lStep.FormText));
        qry.SQL.Add(StFormat(lStep.WorkFlowText));
        if lStep.FormClassName = csFormClassName then
          qry.SQL.Add('"",')
        else
          qry.SQL.Add(StFormat(lStep.FormClassName));
        qry.SQL.Add(IntToStr(lStep.WorkFlowId) + ',');
        qry.SQL.Add(IntToStr(lStep.ImageIndex) + ',');
        qry.SQL.Add(IntToStr(HowToId)+ ',');
        lStep.HowToId := HowToId;

        qry.SQL.Add(FileFormat(lStep.VideoFile) + ',');
        if lStep.VideoText = '' then
          qry.SQL.Add('"")')
        else
          qry.SQL.Add('"' + lStep.VideoText + '")');

        qry.SQL.Add('ON DUPLICATE KEY UPDATE');
        qry.SQL.Add('Header=Values(Header), Description=Values(Description), FormText=Values(FormText), ');
        qry.SQL.Add('FlowText=Values(FlowText), FormClassName=Values(FormClassName), FlowId=Values(FlowId), FormImageIndex=Values(FormImageIndex),' +
                    'VideoFile=Values(VideoFile), VideoText=Values(VideoText);');
        qry.ExecSQL;
      end;

      qry.Close;
      qry.Connection.Commit;
    except
      qry.Connection.Rollback;
    end;
  finally
    qry.Free;
  end;
end;

procedure THowToStepList.SetDeletedList(const Value: TObjectList);
begin
  FDeletedList := Value;
end;

end.
