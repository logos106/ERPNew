unit BusobjWorkflow;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  19/05/14  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TWorkFlowLines = class(TMSBusObj)
  private
    function GeTWorkFlowID              : Integer   ;
    function GeTSeqno                   : Integer   ;
    function GetformName                : string    ;
    function GetFormclassname           : string    ;
    function GetControlName             : string    ;
    function GetControlclassname        : string    ;
    function GetMenuName                : string    ;
    function GetMenuClassName           : string    ;
    function GetHelpcontextID           : string    ;
    function GetbuttonActionName        : string    ;
    function GetEventName               : string    ;
    function GetControlParent           : string    ;
    function GetControlnMenu            : string    ;
    function Getfieldname               : string    ;
    function GetPropname                : string    ;
    function Geteventtype               : string    ;
    function getshowhint                : Boolean   ;
    function getAssignedGridDataSelect  : Boolean   ;
    function getShowPoint               : Boolean   ;
    function GetGridcomboname           : string    ;
    function Getvalue                   : string    ;
    procedure SeTWorkFlowID              (const Value: Integer   );
    procedure SeTSeqno                   (const Value: Integer   );
    procedure SetformName                (const Value: string    );
    procedure SetFormclassname           (const Value: string    );
    procedure SetControlName             (const Value: string    );
    procedure SetControlclassname        (const Value: string    );
    procedure SetMenuName                (const Value: string    );
    procedure SetMenuClassName           (const Value: string    );
    procedure SetHelpcontextID           (const Value: string    );
    procedure SetbuttonActionName        (const Value: string    );
    procedure SetEventName               (const Value: string    );
    procedure SetControlParent           (const Value: string    );
    //procedure SetControlnMenu            (const Value: string    );
    procedure Setfieldname               (const Value: string    );
    procedure SetPropname                (const Value: string    );
    procedure Seteventtype               (const Value: string    );Overload;
    procedure Seteventtype               (const fshowhint, fShowPoint :Boolean);Overload;
    Procedure SetShowhint                (const Value: Boolean   );
    Procedure SetShowPoint               (const Value: Boolean   );
    Procedure SetAssignedGridDataSelect  (Const Value: Boolean   );
    procedure SetGridcomboname           (const Value: string    );
    procedure Setvalue                   (const Value: string    );
    function getHintOnly: Boolean;
    function getIgnoreOnError: Boolean;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                                : string;           override;
    function  DoAfterPost(Sender:TDatasetBusObj)    : Boolean;          override;
    function  DoBeforePost(Sender:TDatasetBusObj)   : Boolean;          override;
    function  DoAfterInsert(Sender:TDatasetBusObj)  : Boolean;          override;
    function  DoAfterOpen(Sender:TDatasetBusObj)    : Boolean;          override;
    function  DoBeforeOpen(Sender:TDatasetBusObj)   : Boolean;          override;
    function  DoAfterClose(Sender:TDatasetBusObj)   : Boolean;          override;
    Function  DoCalcFields(Sender :TDatasetBusObj)  : Boolean;          override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    property eventtype         :string      read Geteventtype       write Seteventtype     ;
    Property HintOnly :Boolean read getHintOnly;
    Property IgnoreOnError :Boolean read getIgnoreOnError;

  published
    property WorkflowID               : Integer     read GeTWorkFlowID               Write SeTWorkFlowID   ;
    property Seqno                    : Integer     read GeTSeqno                    Write SeTSeqno        ;
    property formName                 : string      read GetformName                 Write SetformName     ;
    property Formclassname            : string      read GetFormclassname            Write SetFormclassname;
    property ControlName              : string      read GetControlName              Write SetControlName  ;
    property Controlclassname         : string      read GetControlclassname         Write SetControlclassname  ;
    property MenuName                 : string      read GetMenuName                 Write SetMenuName  ;
    property MenuClassName            : string      read GetMenuClassName            Write SetMenuClassName  ;
    property HelpcontextID            : string      read GetHelpcontextID            Write SetHelpcontextID  ;
    property buttonActionName         : string      read GetbuttonActionName         Write SetbuttonActionName ;
    property EventName                : string      read GetEventName                Write SetEventName    ;
    property ControlParent            : string      read GetControlParent            Write SetControlParent;
    property ControlnMenu             : string      read GetControlnMenu             (*Write SetControlnMenu*);
    property fieldname                : string      read Getfieldname                Write Setfieldname    ;
    property Propname                 : string      read GetPropname                 Write SetPropname     ;
    Property Showhint                 : Boolean     read getShowhint                 Write setShowhint     ;
    Property AssignedGridDataSelect   : Boolean     read getAssignedGridDataSelect   write setAssignedGridDataSelect     ;
    Property ShowPoint                : Boolean     read getShowPoint                Write setShowPoint    ;
    property Gridcomboname            : string      read GetGridcomboname            Write SetGridcomboname;
    property value                    : string      read Getvalue                    Write Setvalue        ;
  end;

  TWorkFlow = class(TMSBusObj)
  private
    fiLastSeqno:Integer;
    function GetDescription      : string    ;
    function GetCompanyName      : string    ;
    function GetVideoName        : string    ;
    function GetSkinsGroup       : string    ;
    function GetCategory         : string    ;
    function GetActive           : Boolean   ;
    function GetIsERpWorkflow    : Boolean   ;
    function GetCreatedBy        : Integer   ;
    function GetLanguageID       : Integer   ;
    function GetTabGroup         : Integer   ;
    Function GetCreatedByName    : String ;
    procedure SetDescription      (const Value: string    );
    procedure SetCompanyName      (const Value: string    );
    procedure SetVideoName        (const Value: string    );
    procedure SetSkinsGroup       (const Value: string    );
    procedure SetCategory         (const Value: string    );
    procedure SetActive           (const Value: Boolean   );
    procedure SetIsERpWorkflow    (const Value: Boolean   );
    procedure SetCreatedBy        (const Value: Integer   );
    procedure SetLanguageID       (const Value: Integer   );
    procedure SetTabGroup         (const Value: Integer   );
    Procedure SetCreatedByName    (Const Value: String    );
    function getLines: TWorkFlowLines;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoBeforePost(Sender:TDatasetBusObj): Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    function  DoAfterOpen(Sender:TDatasetBusObj)   : Boolean;           override;
    function  DoAfterClose(Sender:TDatasetBusObj)  : Boolean;           override;
    Function  DoBeforeDelete(Sender :TDatasetBusObj):Boolean;           override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Class Function WorkflowRecSQL(Const WFID:Integer):String;
  published
    property Description       :string      read GetDescription     write SetDescription  ;
    property CompanyName       :string      read GetCompanyName     write SetCompanyName  ;
    property VideoName         :string      read GetVideoName       write SetVideoName    ;
    property SkinsGroup        :string      read GetSkinsGroup      write SetSkinsGroup   ;
    property Category          :string      read GetCategory        write SetCategory     ;
    property Active            :Boolean     read GetActive          write SetActive       ;
    property IsERpWorkflow     :Boolean     read GetIsERpWorkflow   write SetIsERpWorkflow;
    property CreatedBy         :Integer     read GetCreatedBy       write SetCreatedBy    ;
    property LanguageID        :Integer     read GetLanguageID      write SetLanguageID  ;
    property TabGroup          :Integer     read GetTabGroup        write SetTabGroup    ;
    Property CreatedByName     :String      read getCreatedByName   write setCreatedByName;
    Property Lines :TWorkFlowLines Read getLines;
  end;


implementation


uses tcDataUtils, CommonLib, sysutils, AppEnvironment,tcConst, LanguageTranslationObj,
  ERPdbComponents, DbSharedObjectsObj, CommonDbLib, BusObjConst, Variants,
  BusObjEmployee;



  {TWorkFlow}

constructor TWorkFlow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'workflow';
  fSQL := 'SELECT * FROM tblworkflow';
  fiLastSeqno:=0;
end;


destructor TWorkFlow.Destroy;
begin
  inherited;
end;


procedure TWorkFlow.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Description');
  SetPropertyFromNode(node,'CompanyName');
  SetPropertyFromNode(node,'VideoName');
  SetPropertyFromNode(node,'SkinsGroup');
  SetPropertyFromNode(node,'Category');
  SetBooleanPropertyFromNode(node,'Active');
  SetBooleanPropertyFromNode(node,'IsERpWorkflow');
  SetPropertyFromNode(node,'CreatedBy');
  SetPropertyFromNode(node,'CreatedByName');
  SetPropertyFromNode(node,'LanguageID');
  SetPropertyFromNode(node,'TabGroup');
end;


procedure TWorkFlow.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'CompanyName' ,CompanyName);
  AddXMLNode(node,'VideoName' ,VideoName);
  AddXMLNode(node,'SkinsGroup' ,SkinsGroup);
  AddXMLNode(node,'Category' ,Category);
  AddXMLNode(node,'Active' ,Active);
  AddXMLNode(node,'IsERpWorkflow' ,IsERpWorkflow);
  AddXMLNode(node,'CreatedBy' ,CreatedBy);
  AddXMLNode(node,'CreatedByName' ,CreatedByName);
  AddXMLNode(node,'LanguageID' ,LanguageID);
  AddXMLNode(node,'TabGroup' ,TabGroup);
end;


function TWorkFlow.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := False;
  if Description = '' then begin
    ResultStatus.AddItem(False, rssWarning, 0 , 'Description should not be blank', true);
    Exit;
  end;

  if  (SkinsGroup = '') then begin
    ResultStatus.AddItem(False, rssWarning, 0 , 'Cateogry should not be blank', true);
    Exit;
  end;
  //if LanguageID =0 then LanguageID :=TLanguageTranslationObj.Inst.UserLanguageId;
  Result := True;
end;


class function TWorkFlow.WorkflowRecSQL(const WFID: Integer): String;
var
  s:String;
  sDesc :String;
  Qry:TERPQuery;
begin
  result :='';
  if WFID =0 then exit;
//  With SharedQryObj('Select * from tblworkflow where Id = ' + inttostr(WFID )) do begin
    Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
    try
      if Qry.Active then Qry.Close;
      Qry.SQL.Text := 'Select * from tblworkflow where Id = ' + inttostr(WFID );
      Qry.Open;
      With Qry do begin
          if recordcount =0 then exit;
          sDesc := Fieldbyname('Description').asString ;
          result := 'delete from tblworkflowlines where WorkflowID in (Select Id from tblworkflow where Description = ' +quotedstr(sDesc)+');' +NL;
          result := result + 'delete from tblworkflow where      Description   =' +quotedstr(sDesc   )+';' +NL+
                    'insert ignore into tblworkflow Set Description   =' +quotedstr(sDesc   )+',' +
                                                    //' CompanyName   =' +quotedstr(Fieldbyname('CompanyName').asString     )+',' +
                                                      ' VideoName     =' +quotedstr(Fieldbyname('VideoName').asString     )+',' +
                                                      ' Active        =' +quotedstr(Fieldbyname('Active').asString        )+',' +
                                                      ' IsERpWorkflow =' +quotedstr(Fieldbyname('IsERpWorkflow').asString )+',' +
                                                      ' CreatedByname =' +quotedstr(Fieldbyname('CreatedByname').asString )+',' +
                                                      ' LanguageID    =' +inttostr (Fieldbyname('LanguageID').asInteger     )+',' +
                                                      ' TabGroup      =' +inttostr (Fieldbyname('TabGroup').asInteger     )+',' +
                                                      ' SkinsGroup    =' +quotedstr(Fieldbyname('SkinsGroup').asString    )+',' +
                                                      ' Category      =' +quotedstr(Fieldbyname('Category').asString      )+';'+NL;

          //With SharedQryObj('Select * from tblworkflowlines where WorkflowID in (Select Id from tblworkflow where Description = ' +quotedstr(sDesc)+')') do begin
          s:= 'Select * from tblworkflowlines where WorkflowID ='+inttostr(Fieldbyname('ID').asInteger) ;

          if active then close;
          SQL.Clear;
          SQL.Add(s);
          open;
          if recordcount =0 then exit;
          first;
          While Eof = False do begin
            result := result +'insert ignore into tblworkflowlines (WorkflowID , Seqno , FormClassName , formName , Controlname , buttonActionName , HelpcontextID , '+
                                                                      'ControlParent , fieldname , Gridcomboname , Propname , value , EventName , eventtype ) '+
                              ' Select  Id , ' +inttostr (Fieldbyname('Seqno').asInteger          )+','+
                                                Quotedstr(Fieldbyname('FormClassName').asString   ) +','+
                                                Quotedstr(Fieldbyname('formName').asString        ) +','+
                                                Quotedstr(Fieldbyname('Controlname').asString     ) +','+
                                                Quotedstr(Fieldbyname('buttonActionName').asString) +','+
                                                Quotedstr(Fieldbyname('HelpcontextID').asString  ) +','+
                                                Quotedstr(Fieldbyname('ControlParent').asString   ) +','+
                                                Quotedstr(Fieldbyname('fieldname').asString       ) +','+
                                                Quotedstr(Fieldbyname('Gridcomboname').asString   ) +','+
                                                Quotedstr(Fieldbyname('Propname').asString        ) +','+
                                                Quotedstr(Fieldbyname('value').asString           ) +','+
                                                Quotedstr(Fieldbyname('EventName').asString       ) +','+
                                                Quotedstr(Fieldbyname('eventtype').asString       ) +' '+
                               ' from   tblworkflow   where Description = ' +quotedstr(sDesc)+';' +NL;
            Next;
        end;
      end;
    finally
      dbsharedObj.releaseobj(Qry);
    end;
end;

function TWorkFlow.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TWorkFlow.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TWorkFlow.DoFieldOnChange(Sender: TField);
var
  qry: TERPQuery;
  CleanVal: string;
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.FieldName , 'Description') then begin
    CleanVal := GetXMLNodeStringValue(CleanXMLNode, 'Description');
    if Description <> CleanVal then begin
      qry := DbSharedObj.GetQuery(Connection.Connection);
      try
        qry.SQL.Add('select * from ' + BusObjectTableName);
        qry.SQL.Add('where Description = ' + QuotedStr(Description));
        qry.Open;
        if not qry.IsEmpty then begin
          SendEvent(BusObjEvent_Error,BusObjEventVal_DuplicateDescription,self);
          if not VarIsNull(Sender.OldValue) then
            Sender.Value := Sender.OldValue
          else
            Description := '';
        end;
      finally
        DbSharedObj.ReleaseObj(qry);
      end;
    end;
  end else if Sysutils.SameText(Sender.FieldName , 'CreatedBy') then begin
    CreatedByName := TEmployee.IDToggle(CreatedBy, Connection.Connection);
  end else if Sysutils.SameText(Sender.FieldName , 'CreatedByName') then begin
    CreatedBy := TEmployee.IDToggle(CreatedByName, Connection.Connection);
  end;
end;


function TWorkFlow.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TWorkFlow.GetIDField: string;
begin
  Result := 'ID'
end;


class function TWorkFlow.GetBusObjectTablename: string;
begin
  Result:= 'tblworkflow';
end;


function TWorkFlow.DoAfterClose(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoAfterClose(Sender);
  if not result then exit;
end;

function TWorkFlow.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoAfterInsert(Sender);
  if not result then exit;
  LanguageID := TLanguageTranslationObj.Inst.UserLanguageId;
  CreatedBy := Appenv.Employee.EmployeeID;
  Active := True;
  CompanyName := Appenv.CompanyInfo.CompanyName;
end;

function TWorkFlow.DoAfterOpen(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoAfterOpen(Sender);
  if not result then exit;
end;

function TWorkFlow.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not(Result) then exit;
  if fiLastSeqno =0 then begin
    Lines.last;
    fiLastSeqno := Lines.Seqno;
  end;
end;


function TWorkFlow.DoBeforeDelete(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoBeforeDelete(Sender);
  if not result then exit;
  Lines.DeleteAll;
end;

function TWorkFlow.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not result then exit;
end;

{Property Functions}
function  TWorkFlow.GetDescription  : string    ; begin Result := GetStringField('Description');end;
function  TWorkFlow.GetCompanyName  : string    ; begin Result := GetStringField('CompanyName');end;
function  TWorkFlow.GetVideoName    : string    ; begin Result := GetStringField('VideoName');end;
function  TWorkFlow.GetSkinsGroup   : string    ; begin Result := GetStringField('SkinsGroup');end;
function  TWorkFlow.GetCategory     : string    ; begin Result := GetStringField('Category');end;
function  TWorkFlow.GetActive       : Boolean   ; begin Result := GetBooleanField('Active');end;
function  TWorkFlow.GetIsERpWorkflow: Boolean   ; begin Result := GetBooleanField('IsERpWorkflow');end;
function  TWorkFlow.GetCreatedBy    : Integer   ; begin Result := GetIntegerField('CreatedBy');end;
function  TWorkFlow.GetLanguageID   : Integer   ; begin Result := GetIntegerField('LanguageID');end;
function  TWorkFlow.GetTabGroup     : Integer   ; begin Result := GetIntegerField('TabGroup');end;
function  TWorkFlow.getCreatedByName: String    ; begin result  := GetStringfield('CreatedByName'); end;
procedure TWorkFlow.SetDescription  (const Value: string    ); begin SetStringField('Description'   , Value);end;
procedure TWorkFlow.SetCompanyName  (const Value: string    ); begin SetStringField('CompanyName'   , Value);end;
procedure TWorkFlow.SetVideoName    (const Value: string    ); begin SetStringField('VideoName'   , Value);end;
procedure TWorkFlow.SetSkinsGroup   (const Value: string    ); begin SetStringField('SkinsGroup'   , Value);end;
procedure TWorkFlow.SetCategory     (const Value: string    ); begin SetStringField('Category'   , Value);end;
procedure TWorkFlow.SetActive       (const Value: Boolean   ); begin SetBooleanField('Active'        , Value);end;
procedure TWorkFlow.SetIsERpWorkflow(const Value: Boolean   ); begin SetBooleanField('IsERpWorkflow' , Value);end;
procedure TWorkFlow.SetCreatedBy    (const Value: Integer   ); begin SetIntegerField('CreatedBy'     , Value);end;
procedure TWorkFlow.SetLanguageID   (const Value: Integer   ); begin SetIntegerField('LanguageID'     , Value);end;
procedure TWorkFlow.SetTabGroup     (const Value: Integer   ); begin SetIntegerField('TabGroup'     , Value);end;
procedure TWorkFlow.SetCreatedByName(Const Value: String    ); begin SetStringfield('CreatedByName',Value);end;
function TWorkFlow.getLines: TWorkFlowLines;
begin
  Result := TWorkFlowLines(getContainercomponent(TWorkFlowLines, 'WorkflowID = ' + inttostr(ID)));
end;


  {TWorkFlowLines}

constructor TWorkFlowLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'workflowlines';
  fSQL := 'SELECT * , '+
          ' if(eventtype ="H" or eventtype="B" , "T" , "F") as showhint,  '+
          ' if(eventtype ="P" or eventtype="B" , "T" , "F") as showPoint,  '+
          ' concat_ws(".",controlParent,Menuname)           as ControlnMenu  '+
          ' FROM tblworkflowlines';
  fSQLOrder := 'Seqno';
end;


destructor TWorkFlowLines.Destroy;
begin
  inherited;
end;


procedure TWorkFlowLines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'WorkflowID');
  SetPropertyFromNode(node,'Seqno');
  SetPropertyFromNode(node,'formName');
  SetPropertyFromNode(node,'Formclassname');
  SetPropertyFromNode(node,'ControlName');
  SetPropertyFromNode(node,'Controlclassname');
  SetPropertyFromNode(node,'MenuName');
  SetPropertyFromNode(node,'MenuClassName');
  SetPropertyFromNode(node,'HelpcontextID');
  SetPropertyFromNode(node,'buttonActionName');
  SetPropertyFromNode(node,'EventName');
  SetPropertyFromNode(node,'ControlParent');
  SetPropertyFromNode(node,'ControlnMenu');
  SetPropertyFromNode(node,'fieldname');
  SetPropertyFromNode(node,'Propname');
  SetBooleanPropertyFromNode(node , 'Showhint');
  SetBooleanPropertyFromNode(node , 'ShowPoint');
  SetBooleanPropertyFromNode(node , 'AssignedGridDataSelect');
  SetPropertyFromNode(node,'Gridcomboname');
  SetPropertyFromNode(node,'value');
end;


procedure TWorkFlowLines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'WorkflowID' ,WorkflowID);
  AddXMLNode(node,'Seqno' ,Seqno);
  AddXMLNode(node,'formName' ,formName);
  AddXMLNode(node,'Formclassname' ,Formclassname);
  AddXMLNode(node,'ControlName' ,ControlName);
  AddXMLNode(node,'Controlclassname' ,Controlclassname);
  AddXMLNode(node,'MenuName' ,MenuName);
  AddXMLNode(node,'MenuClassName' ,MenuClassName);
  AddXMLNode(node,'HelpcontextID' ,HelpcontextID);
  AddXMLNode(node,'buttonActionName' ,buttonActionName);
  AddXMLNode(node,'EventName' ,EventName);
  AddXMLNode(node,'ControlParent' ,ControlParent);
  AddXMLNode(node,'ControlnMenu' ,ControlnMenu);
  AddXMLNode(node,'fieldname' ,fieldname);
  AddXMLNode(node,'Propname' ,Propname);
  AddXMLNode(node ,'Showhint' , Showhint);
  AddXMLNode(node ,'AssignedGridDataSelect' , AssignedGridDataSelect);
  AddXMLNode(node ,'ShowPoint' , ShowPoint);
  AddXMLNode(node,'Gridcomboname' ,Gridcomboname);
  AddXMLNode(node,'value' ,value);
end;


function TWorkFlowLines.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;



function TWorkFlowLines.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TWorkFlowLines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TWorkFlowLines.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TWorkFlowLines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TWorkFlowLines.GetIDField: string;
begin
  Result := 'ID'
end;


function TWorkFlowLines.getIgnoreOnError: Boolean;
begin
  Result := False;
  if sametext(formName , 'TfmSalesProductAutoSelectOptions') then begin
    REsult := True;
    Exit;
  end;
end;

class function TWorkFlowLines.GetBusObjectTablename: string;
begin
  Result:= 'tblworkflowlines';
end;


function TWorkFlowLines.DoAfterClose(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoAfterClose(Sender);
  if not result then exit;
end;

function TWorkFlowLines.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if Assigned(Owner) then
    if owner is TWorkFlow then begin
      WorkflowID := TWorkFlow(Owner).ID;
      Seqno      := TWorkFlow(Owner).fiLastSeqno+2;
    end;
end;

function TWorkFlowLines.DoAfterOpen(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoAfterOpen(Sender);
  if not result then exit;

(*var
  aDataset:TDataset;
begin
  REsult := inherited DoAfterOpen(Sender);
  if not result then exit;
  aDataset := Dataset;
  if aDataset.FindField('ControlnMenu') = nil then begin
    with TWideStringField.Create(aDataset) do begin
      fieldKind := fkCalculated;
      fieldname := 'ControlnMenu';
      DisplayLabel := 'Coding control Panel';
      size := 255;
      name := aDataset.name+'ControlnMenu';
      Dataset := aDataset;
    end;
  end;*)
end;

function TWorkFlowLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;
  if Assigned(Owner) then
    if owner is TWorkFlow then
      if TWorkFlow(Owner).fiLastSeqno < Seqno then TWorkFlow(Owner).fiLastSeqno := Seqno;
end;
function TWorkFlowLines.DoBeforeOpen(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoBeforeOpen(Sender);
  if not result then exit;
end;

function TWorkFlowLines.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not result then exit;
end;

function TWorkFlowLines.DoCalcFields(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoCalcFields(Sender);
  if not result then exit;
(*  ControlnMenu := controlParent;
  if Menuname <> '' then ControlnMenu := ControlnMenu +'.' +Menuname;*)
end;

function TWorkFlowLines.getHintOnly: Boolean;
begin
  Result := Showhint and not(ShowPoint);
end;


{Property Functions}
function  TWorkFlowLines.GeTWorkFlowID                 : Integer   ; begin Result := GetIntegerField('WorkflowID');end;
function  TWorkFlowLines.GeTSeqno                      : Integer   ; begin Result := GetIntegerField('Seqno');end;
function  TWorkFlowLines.GetformName                   : string    ; begin Result := GetStringField('formName');end;
function  TWorkFlowLines.GetFormclassname              : string    ; begin Result := GetStringField('Formclassname');end;
function  TWorkFlowLines.GetControlName                : string    ; begin Result := GetStringField('ControlName');end;
function  TWorkFlowLines.GetControlclassname           : string    ; begin Result := GetStringField('Controlclassname');end;
function  TWorkFlowLines.GetMenuName                   : string    ; begin Result := GetStringField('MenuName');end;
function  TWorkFlowLines.GetMenuClassName              : string    ; begin Result := GetStringField('MenuClassName');end;
function  TWorkFlowLines.GetHelpcontextID              : string    ; begin Result := GetStringField('HelpcontextID');end;
function  TWorkFlowLines.GetbuttonActionName           : string    ; begin Result := GetStringField('buttonActionName');end;
function  TWorkFlowLines.GetEventName                  : string    ; begin Result := GetStringField('EventName');end;
function  TWorkFlowLines.GetControlParent              : string    ; begin Result := GetStringField('ControlParent');end;
function  TWorkFlowLines.GetControlnMenu               : string    ; begin Result := GetStringField('ControlnMenu');end;
function  TWorkFlowLines.Getfieldname                  : string    ; begin Result := GetStringField('fieldname');end;
function  TWorkFlowLines.GetPropname                   : string    ; begin Result := GetStringField('Propname');end;
function  TWorkFlowLines.Geteventtype                  : string    ; begin Result := GetStringField('eventtype');end;
Function  TWorkFlowLines.GetShowhint                   : Boolean   ; begin Result := Getbooleanfield('Showhint');end;
Function  TWorkFlowLines.GetAssignedGridDataSelect     : Boolean   ; begin Result := Getbooleanfield('BaselistingGridDataSelectAssigned');end;
Function  TWorkFlowLines.GetShowPoint                  : Boolean   ; begin Result := Getbooleanfield('ShowPoint');end;
function  TWorkFlowLines.GetGridcomboname              : string    ; begin Result := GetStringField('Gridcomboname');end;
function  TWorkFlowLines.Getvalue                      : string    ; begin Result := GetStringField('value');end;
procedure TWorkFlowLines.SeTWorkFlowID                 (Const Value: Integer   ); begin SetIntegerField('WorkflowID'      , Value);end;
procedure TWorkFlowLines.SeTSeqno                      (Const Value: Integer   ); begin SetIntegerField('Seqno'           , Value);end;
procedure TWorkFlowLines.SetformName                   (Const Value: string    ); begin SetStringField('FormName'         , Value);end;
procedure TWorkFlowLines.SetFormclassname              (Const Value: string    ); begin SetStringField('Formclassname'    , Value);end;
procedure TWorkFlowLines.SetControlName                (Const Value: string    ); begin SetStringField('ControlName'      , Value);end;
procedure TWorkFlowLines.SetControlclassname           (Const Value: string    ); begin SetStringField('Controlclassname' , Value);end;
procedure TWorkFlowLines.SetMenuName                   (Const Value: string    ); begin SetStringField('MenuName'         , Value);end;
procedure TWorkFlowLines.SetMenuClassName              (Const Value: string    ); begin SetStringField('MenuClassName'    , Value);end;
procedure TWorkFlowLines.SetHelpcontextID              (Const Value: string    ); begin SetStringField('HelpcontextID'    , Value);end;
procedure TWorkFlowLines.SetbuttonActionName           (Const Value: string    ); begin SetStringField('buttonActionName' , Value);end;
procedure TWorkFlowLines.SetEventName                  (Const Value: string    ); begin SetStringField('EventName'        , Value);end;
procedure TWorkFlowLines.SetControlParent              (Const Value: string    ); begin SetStringField('ControlParent'    , Value);end;
//procedure TWorkFlowLines.SetControlnMenu               (Const Value: string    ); begin SetStringField('ControlnMenu'     , Value);end;
procedure TWorkFlowLines.Setfieldname                  (Const Value: string    ); begin SetStringField('fieldname'        , Value);end;
procedure TWorkFlowLines.SetPropname                   (Const Value: string    ); begin SetStringField('Propname'         , Value);end;
procedure TWorkFlowLines.Seteventtype                  (Const Value: string    ); begin SetStringField('eventtype'        , Value);end;
Procedure TWorkFlowLines.SetShowhint                   (Const Value: Boolean   ); begin SetEventtype(Value, ShowPoint  )  ;end;
Procedure TWorkFlowLines.SetShowPoint                  (Const Value: Boolean   ); begin SetEventtype(showhint, Value  )   ;end;
Procedure TWorkFlowLines.SetAssignedGridDataSelect     (Const Value: Boolean   ); begin SetBooleanfield('BaselistingGridDataSelectAssigned', value);        ;end;
procedure TWorkFlowLines.SetGridcomboname              (Const Value: string    ); begin SetStringField('Gridcomboname'    , Value);end;
procedure TWorkFlowLines.Setvalue                      (Const Value: string    ); begin SetStringField('value'            , Value);end;
procedure TWorkFlowLines.Seteventtype                  (Const fshowhint, fShowPoint: Boolean);
begin
       if fshowhint       and  fShowPoint       then EventType :='B'
  else if fshowhint       and  not(fShowPoint)  then EventType :='H'
  else if not(fshowhint)  and  fShowPoint       then EventType :='P'
  else EventType :='';
  PostDB;
end;


initialization
  RegisterClass(TWorkFlowLines);
  RegisterClass(TWorkFlow);


end.
