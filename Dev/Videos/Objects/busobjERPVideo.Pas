unit busobjERPVideo;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  05/11/14  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;

const
    vt_None ='vtNone';
    vt_Training ='vtTraining';
    vt_Task = 'vtTask';

type
  TVideoType = (vtNone =1, vtTraining=2, vtTask =3);

TVideoPages = class(TMSBusObj)
  private
    function GetVideoID             : Integer   ;
    function GetPageName            : string    ;
    Function GetActive              : Boolean;
    procedure SetVideoID             (const Value: Integer   );
    procedure SetPageName            (const Value: string    );
    Procedure SetActive              (Const Value :Boolean);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoBeforePost(Sender:TDatasetBusObj) : Boolean;            override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property VideoID              :Integer     read GetVideoID            write SetVideoID          ;
    property PageName             :string      read GetPageName           write SetPageName        ;
    Property Active               :Boolean     read getActive             write setActive;
  end;


  TERPVideo = class(TMSBusObj)
  private
    //function GetPageIndex           : Integer   ;
    function GetVideoID             : Integer   ;
    function GetSeqno               : Integer   ;
    //function GetPagename            : string    ;
    function GetPagehint            : string    ;
    function GetPageCaption         : string    ;
    function Getfilename            : string    ;
    function Getvideotype           : string    ;
    function GetDateCreated         : TDate ;
    function GetEditedFlag          : Boolean   ;
    function GetActive              : Boolean   ;
    //procedure SetPageIndex           (const Value: Integer   );
    procedure SetVideoID             (const Value: Integer   );
    procedure SetSeqno           (const Value: Integer   );
    //procedure SetPagename            (const Value: string    );
    procedure SetPagehint            (const Value: string    );
    procedure SetPageCaption         (const Value: string    );
    procedure Setfilename            (const Value: string    );
    procedure Setvideotype           (const Value: string    );
    procedure SetDateCreated         (const Value: TDate );
    procedure SetEditedFlag          (const Value: Boolean   );
    procedure SetActive              (const Value: Boolean   );
    //function nextPageIndex: Integer;
    function Getvideo_type: TVideoType;
    procedure Setvideo_type(const Value: TVideoType);
    function getVideoPages: TVideoPages;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoBeforePost(Sender:TDatasetBusObj) : Boolean;            override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    class function GetKeyStringField: string; Override;
    property Video_Type           :TVideoType  read Getvideo_type         write Setvideo_type        ;
  published
    //property PageIndex            :Integer     read GetPageIndex          write SetPageIndex       ;
    property VideoID              :Integer     read GetVideoID            write SetVideoID       ;
    //property Pagename             :string      read GetPagename           write SetPagename        ;
    property Seqno                :Integer     read GetSeqno              write SetSeqno       ;
    property Pagehint             :string      read GetPagehint           write SetPagehint        ;
    property PageCaption          :string      read GetPageCaption        write SetPageCaption     ;
    property filename             :string      read Getfilename           write Setfilename        ;
    property videotype            :string      read Getvideotype          write Setvideotype        ;
    property DateCreated          :TDate       read GetDateCreated        write SetDateCreated     ;
    property EditedFlag           :Boolean     read GetEditedFlag         write SetEditedFlag      ;
    property Active               :Boolean     read GetActive             write SetActive          ;
    property VideoPages           :TVideoPages read getVideoPages;
  end;

Function VideofilenamewithPath(Const filename:string=''):String;
Function VideoTypeToString(const Value:TVideoType ):String;
Function StringToVideoType(const Value: String):TVideoType;


implementation


uses tcDataUtils, CommonLib, BusObjectListObj, sysutils, SystemLib, tcConst;

function VideoTypeToString(const Value: TVideoType): String;
begin
       if Value = vtTraining  then Result := vt_Training
  else if Value = vtTask      then result:= vt_Task
  else result := vt_None;
end;
Function StringToVideoType(const Value: String):TVideoType;
begin
       if Value = vt_Training  then Result := vtTraining
  else if Value = vt_Task      then result:= vtTask
  else result := vtNone;
end;

Function VideofilenamewithPath(Const filename:string=''):String;
begin
 ForceDirectories((*SystemLib.ExeDir*)GetAllUserDocumentsDir + VIDEO_SUBDIR );
 result := (*SystemLib.ExeDir*)GetAllUserDocumentsDir + VIDEO_SUBDIR + filename;
end;

  {TERPVideo}

constructor TERPVideo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'ERPVideo';
  fSQL := 'SELECT * FROM erpdocumentaion.tblvideos';
end;


destructor TERPVideo.Destroy;
begin
  inherited;
end;


procedure TERPVideo.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  //SetPropertyFromNode(node,'PageIndex');
  SetPropertyFromNode(node,'VideoID');
  SetPropertyFromNode(node,'Seqno');
//  SetPropertyFromNode(node,'Pagename');
  SetPropertyFromNode(node,'Pagehint');
  SetPropertyFromNode(node,'PageCaption');
  SetPropertyFromNode(node,'filename');
  SetPropertyFromNode(node,'videotype');
  SetDateTimePropertyFromNode(node,'DateCreated');
  SetBooleanPropertyFromNode(node,'EditedFlag');
  SetBooleanPropertyFromNode(node,'Active');
end;


procedure TERPVideo.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  //AddXMLNode(node,'PageIndex' ,PageIndex);
  AddXMLNode(node,'VideoID' ,VideoID);
  AddXMLNode(node,'Seqno' ,Seqno);
  //AddXMLNode(node,'Pagename' ,Pagename);
  AddXMLNode(node,'Pagehint' ,Pagehint);
  AddXMLNode(node,'PageCaption' ,PageCaption);
  AddXMLNode(node,'filename' ,filename);
  AddXMLNode(node,'videotype' ,videotype);
  AddXMLNode(node,'DateCreated' ,DateCreated);
  AddXMLNode(node,'EditedFlag' ,EditedFlag);
  AddXMLNode(node,'Active' ,Active);
end;


function TERPVideo.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if filename = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'Filename should not be blank' , true );
    Exit;
  end;
(*  if Pagename = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'Pagename should not be blank' , true );
    Exit;
  end;*)
  if PageCaption = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'caption should not be blank' , true );
    Exit;
  end;
  (*if pageindex =0 then
    Pageindex := nextPageIndex;*)
  Result := True;
end;

(*function TERPVideo.nextPageIndex:Integer;
begin
  With getnewdataset('select Max(Pageindex) as Pageindex from tblvideos ' , true) do try
    result := fieldbyname('Pageindex').asInteger +1;
  finally
    if active then close;
    free;
  end;
end;*)
function TERPVideo.Save: Boolean ;
begin
  Result := False;
  PostDB;
  VideoPages.PostDb;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TERPVideo.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TERPVideo.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TERPVideo.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TERPVideo.GetIDField: string;
begin
  Result := 'ID'
end;


class function TERPVideo.GetKeyStringField: string;
begin
  REsult := 'filename';
end;

class function TERPVideo.GetBusObjectTablename: string;
begin
  Result:= 'erpdocumentaion.tblvideos';
end;


function TERPVideo.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  Datecreated := now;
  EditedFlag := TRue;
  Active := TRue;
end;

function TERPVideo.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


function TERPVideo.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoBeforePost(Sender);
  if not result then exit;
  EditedFlag := True;
end;

{Property Functions}
//function  TERPVideo.GetPageIndex       : Integer   ; begin Result := GetIntegerField('PageIndex');end;
function  TERPVideo.GetVideoID         : Integer   ; begin Result := GetIntegerField('ID');end;
function TERPVideo.getVideoPages: TVideoPages;
begin
  Result := TVideoPages(Getcontainercomponent(TVideoPages, 'VideoID = ' + IntToStr(Self.ID)))
end;

function  TERPVideo.GetSeqno           : Integer   ; begin Result := GetIntegerField('Seqno');end;
//function  TERPVideo.GetPagename        : string    ; begin Result := GetStringField('Pagename');end;
function  TERPVideo.GetPagehint        : string    ; begin Result := GetStringField('Pagehint');end;
function  TERPVideo.GetPageCaption     : string    ; begin Result := GetStringField('PageCaption');end;
function  TERPVideo.Getfilename        : string    ; begin Result := GetStringField('filename');end;
function  TERPVideo.Getvideotype       : string    ; begin Result := GetStringField('videotype');end;
function TERPVideo.Getvideo_type       : TVideoType;begin  Result := StringToVideoType(Videotype);end;
function  TERPVideo.GetDateCreated     : TDate ; begin Result := GetDateTimeField('DateCreated');end;
function  TERPVideo.GetEditedFlag      : Boolean   ; begin Result := GetBooleanField('EditedFlag');end;
function  TERPVideo.GetActive          : Boolean   ; begin Result := GetBooleanField('Active');end;
//procedure TERPVideo.SetPageIndex       (const Value: Integer   ); begin SetIntegerField('PageIndex'     , Value);end;
procedure TERPVideo.SetVideoID         (const Value: Integer   ); begin SetIntegerField('ID'            , Value);end;
procedure TERPVideo.SetSeqno           (const Value: Integer   ); begin SetIntegerField('Seqno'         , Value);end;
//procedure TERPVideo.SetPagename        (const Value: string    ); begin SetStringField('Pagename'       , Value);end;
procedure TERPVideo.SetPagehint        (const Value: string    ); begin SetStringField('Pagehint'       , Value);end;
procedure TERPVideo.SetPageCaption     (const Value: string    ); begin SetStringField('PageCaption'    , Value);end;
procedure TERPVideo.Setfilename        (const Value: string    ); begin SetStringField('filename'       , Value);end;
procedure TERPVideo.Setvideotype       (const Value: string    ); begin SetStringField('videotype'       , Value);end;
procedure TERPVideo.Setvideo_type      (const Value: TVideoType); begin Videotype := VideoTypeToString(Value); end;
procedure TERPVideo.SetDateCreated     (const Value: TDate ); begin SetDateTimeField('DateCreated'      , Value);end;
procedure TERPVideo.SetEditedFlag      (const Value: Boolean   ); begin SetBooleanField('EditedFlag'    , Value);end;
procedure TERPVideo.SetActive          (const Value: Boolean   ); begin SetBooleanField('Active'        , Value);end;

  {TVideoPages}
constructor TVideoPages.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'Videospages';
  fSQL := 'SELECT * FROM erpdocumentaion.tblVideospages';
end;


destructor TVideoPages.Destroy;
begin
  inherited;
end;


procedure TVideoPages.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'VideoID');
  SetPropertyFromNode(node,'PageName');
  SetBooleanPropertyFromNode(node , 'Active');
end;


procedure TVideoPages.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'VideoID' ,VideoID);
  AddXMLNode(node,'PageName' ,PageName);
  AddXMLNode(node,'Active' ,Active);
end;


function TVideoPages.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if VideoID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'VideoID should not be 0' , False );
    Exit;
  end;
  if Pagename = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'Pagename should not be blank' , False );
    Exit;
  end;
  Result := True;
end;


function TVideoPages.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TVideoPages.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TVideoPages.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TVideoPages.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TVideoPages.GetIDField: string;
begin
  Result := 'ID'
end;


class function TVideoPages.GetBusObjectTablename: string;
begin
  Result:= 'erpdocumentaion.tblVideospages';
end;


function TVideoPages.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not(Result) then exit;
  if Assigned(Owner) then
    if Owner is TERPVideo then
      VideoID := TERPVideo(Owner).ID;
end;

function TVideoPages.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
function  TVideoPages.DoBeforePost(Sender:TDatasetBusObj) : Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not result then exit;
  if Pagename = '' then begin
      CancelDB;
      abort;
  end;
end;

{Property Functions}
function  TVideoPages.GetVideoID          : Integer   ; begin Result := GetIntegerField('VideoID');end;
function  TVideoPages.GetPageName        : string    ; begin Result := GetStringField('PageName');end;
function  TVideoPages.GetActive          : Boolean   ; begin Result := GetBooleanfield('Active');end;
procedure TVideoPages.SetVideoID          (const Value: Integer   ); begin SetIntegerField('VideoID'           , Value);end;
procedure TVideoPages.SetPageName        (const Value: string    ); begin SetStringField('PageName'         , Value);end;
Procedure TVideoPages.SetActive         (Const Value: Boolean   ); begin SetBooleanField('Active'          , Value);end;


initialization
  RegisterClass(TVideoPages);
  RegisterClass(TERPVideo);
  BusObjectListObj.TBusObjInfoList.Inst.Add('ERP videos','TERPVideo','', []);
end.
