unit BusObjHowTo;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  30/01/17  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  THowToLines = class(TMSBusObj)
  private
    function GetHowToId           : Integer   ;
    function GetStepNo            : Integer   ;
    function GetHeader            : string    ;
    function GetDescription       : string    ;
    function GetFormText          : string    ;
    function GetFormClassName     : string    ;
    function GetFlowText          : string    ;
    function GetFlowId            : Integer   ;
    function GetFormImageIndex    : Integer   ;
    function GetVideoFile         : string    ;
    function GetVideoText         : string    ;
    procedure SetHowToId           (const Value: Integer   );
    procedure SetStepNo            (const Value: Integer   );
    procedure SetHeader            (const Value: string    );
    procedure SetDescription       (const Value: string    );
    procedure SetFormText          (const Value: string    );
    procedure SetFormClassName     (const Value: string    );
    procedure SetFlowText          (const Value: string    );
    procedure SetFlowId            (const Value: Integer   );
    procedure SetFormImageIndex    (const Value: Integer   );
    procedure SetVideoFile         (const Value: string    );
    procedure SetVideoText         (const Value: string    );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
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
    property HowToId            :Integer     read GetHowToId          write SetHowToId       ;
    property StepNo             :Integer     read GetStepNo           write SetStepNo        ;
    property Header             :string      read GetHeader           write SetHeader        ;
    property Description        :string      read GetDescription      write SetDescription   ;
    property FormText           :string      read GetFormText         write SetFormText      ;
    property FormClassName      :string      read GetFormClassName    write SetFormClassName ;
    property FlowText           :string      read GetFlowText         write SetFlowText      ;
    property FlowId             :Integer     read GetFlowId           write SetFlowId        ;
    property FormImageIndex     :Integer     read GetFormImageIndex   write SetFormImageIndex;
    property VideoFile          :string      read GetVideoFile        write SetVideoFile     ;
    property VideoText          :string      read GetVideoText        write SetVideoText     ;
  end;


  THowTo = class(TMSBusObj)
  private
    function GetDescription    : string    ;
    function GetCompanyName    : string    ;
    function GetAuthorName     : string    ;
    procedure SetDescription    (const Value: string    );
    procedure SetCompanyName    (const Value: string    );
    procedure SetAuthorName     (const Value: string    );
    function getLines: THowToLines;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Class Function HowtoRecSQL(Const HTID:Integer):String;
  published
    property Description     :string      read GetDescription   write SetDescription;
    property CompanyName     :string      read GetCompanyName   write SetCompanyName;
    property AuthorName      :string      read GetAuthorName    write SetAuthorName ;
    Property Lines           :THowToLines read getLines;
  end;


implementation


uses ERPdbComponents, tcDataUtils, CommonLib, DbSharedObjectsObj, CommonDbLib, sysutils,
  tcConst;



  {THowTo}

constructor THowTo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'HowTo';
  fSQL := 'SELECT * FROM tblhowto';
end;


destructor THowTo.Destroy;
begin
  inherited;
end;


procedure THowTo.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Description');
  SetPropertyFromNode(node,'CompanyName');
  SetPropertyFromNode(node,'AuthorName');
end;


procedure THowTo.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'CompanyName' ,CompanyName);
  AddXMLNode(node,'AuthorName' ,AuthorName);
end;


function THowTo.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function THowTo.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure THowTo.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure THowTo.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function THowTo.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function THowTo.HowtoRecSQL(const HTID: Integer): String;
var
  s:String;
  sDesc :String;
  Qry:TERPQuery;
begin
  result :='';
  if HTID =0 then exit;
    Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
    try
      if Qry.Active then Qry.Close;
      Qry.SQL.Text := 'Select * from tblhowto where HowToId = ' + inttostr(HTID );
      Qry.Open;
      With Qry do begin
          if recordcount =0 then exit;
          sDesc := Fieldbyname('Description').asString ;

          result := 'delete from tblhowtolines where HowToId in (Select HowToId from tblhowto where Description = ' +quotedstr(sDesc)+');' +NL;
          result := result + 'delete from tblhowto where      Description   =' +quotedstr(sDesc   )+';' +NL+
                    'insert ignore into tblhowto Set Description   =' +quotedstr(sDesc   )+',' +
                                                      ' CompanyName     =' +quotedstr(Fieldbyname('CompanyName').asString     )+',' +
                                                      ' AuthorName        =' +quotedstr(Fieldbyname('AuthorName').asString        )+';'+NL;

          s:= 'Select * from tblhowtolines where HowToId ='+inttostr(Fieldbyname('HowToId').asInteger) ;
          if active then close;          SQL.Clear;          SQL.Add(s);          open;          if recordcount =0 then exit;
          first;
          While Eof = False do begin
            result := result +'insert ignore into tblhowtolines (HowToId , StepNo , Header , Description , FormText , FormClassName , FlowId , FormImageIndex , VideoFile , VideoText) '+
                              ' Select  HowToId , ' +inttostr (Fieldbyname('StepNo').asInteger          )+','+
                                                Quotedstr(Fieldbyname('Header').asString   ) +','+
                                                Quotedstr(Fieldbyname('Description').asString        ) +','+
                                                Quotedstr(Fieldbyname('FormText').asString     ) +','+
                                                Quotedstr(Fieldbyname('FormClassName').asString) +','+
                                                //Quotedstr(Fieldbyname('FlowText').asString  ) +','+
                                                //inttostr(Fieldbyname('FlowId').asInteger   ) +','+
                                                '( SELECT id FROM tblworkflow WHERE Description = ' + Quotedstr(Fieldbyname('FlowText').asString  )  +'), ' +
                                                inttostr(Fieldbyname('FormImageIndex').asInteger       ) +','+
                                                Quotedstr(Fieldbyname('VideoFile').asString   ) +','+
                                                Quotedstr(Fieldbyname('VideoText').asString        )+' '+
                               ' from   tblhowto   where Description = ' +quotedstr(sDesc)+';' +NL;
            Next;
        end;
        result := result +'update tblhowtolines  HTL ' +
                          ' inner join  tblworkflow WF on HTL.FlowId =  WF.Id  ' +
                          ' Set HTL.FlowText =  WF.Description  ' +
                          ' where  HTL.HowToId in (Select  HowToId from   tblhowto   where Description = ' +quotedstr(sDesc)+');';
      end;
    finally
      dbsharedObj.releaseobj(Qry);
    end;

end;

class function THowTo.GetIDField: string;
begin
  Result := 'HowToId'
end;


function THowTo.getLines: THowToLines;
begin
  Result := THowToLines(getContainercomponent(THowToLines, 'HowToId = ' + inttostr(ID)));
end;

class function THowTo.GetBusObjectTablename: string;
begin
  Result:= 'tblhowto';
end;


function THowTo.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  THowTo.GetDescription: string    ; begin Result := GetStringField('Description');end;
function  THowTo.GetCompanyName: string    ; begin Result := GetStringField('CompanyName');end;
function  THowTo.GetAuthorName : string    ; begin Result := GetStringField('AuthorName');end;
procedure THowTo.SetDescription(const Value: string    ); begin SetStringField('Description' , Value);end;
procedure THowTo.SetCompanyName(const Value: string    ); begin SetStringField('CompanyName' , Value);end;
procedure THowTo.SetAuthorName (const Value: string    ); begin SetStringField('AuthorName' , Value);end;


  {THowToLines}

constructor THowToLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'HowToLines';
  fSQL := 'SELECT * FROM tblhowtolines';
end;


destructor THowToLines.Destroy;
begin
  inherited;
end;


procedure THowToLines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'HowToId');
  SetPropertyFromNode(node,'StepNo');
  SetPropertyFromNode(node,'Header');
  SetPropertyFromNode(node,'Description');
  SetPropertyFromNode(node,'FormText');
  SetPropertyFromNode(node,'FormClassName');
  SetPropertyFromNode(node,'FlowText');
  SetPropertyFromNode(node,'FlowId');
  SetPropertyFromNode(node,'FormImageIndex');
  SetPropertyFromNode(node,'VideoFile');
  SetPropertyFromNode(node,'VideoText');
end;


procedure THowToLines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'HowToId' ,HowToId);
  AddXMLNode(node,'StepNo' ,StepNo);
  AddXMLNode(node,'Header' ,Header);
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'FormText' ,FormText);
  AddXMLNode(node,'FormClassName' ,FormClassName);
  AddXMLNode(node,'FlowText' ,FlowText);
  AddXMLNode(node,'FlowId' ,FlowId);
  AddXMLNode(node,'FormImageIndex' ,FormImageIndex);
  AddXMLNode(node,'VideoFile' ,VideoFile);
  AddXMLNode(node,'VideoText' ,VideoText);
end;


function THowToLines.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function THowToLines.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure THowToLines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure THowToLines.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function THowToLines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function THowToLines.GetIDField: string;
begin
  Result := 'HowToLineId'
end;


class function THowToLines.GetBusObjectTablename: string;
begin
  Result:= 'tblhowtolines';
end;


function THowToLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  THowToLines.GetHowToId       : Integer   ; begin Result := GetIntegerField('HowToId');end;
function  THowToLines.GetStepNo        : Integer   ; begin Result := GetIntegerField('StepNo');end;
function  THowToLines.GetHeader        : string    ; begin Result := GetStringField('Header');end;
function  THowToLines.GetDescription   : string    ; begin Result := GetStringField('Description');end;
function  THowToLines.GetFormText      : string    ; begin Result := GetStringField('FormText');end;
function  THowToLines.GetFormClassName : string    ; begin Result := GetStringField('FormClassName');end;
function  THowToLines.GetFlowText      : string    ; begin Result := GetStringField('FlowText');end;
function  THowToLines.GetFlowId        : Integer   ; begin Result := GetIntegerField('FlowId');end;
function  THowToLines.GetFormImageIndex: Integer   ; begin Result := GetIntegerField('FormImageIndex');end;
function  THowToLines.GetVideoFile     : string    ; begin Result := GetStringField('VideoFile');end;
function  THowToLines.GetVideoText     : string    ; begin Result := GetStringField('VideoText');end;
procedure THowToLines.SetHowToId       (const Value: Integer   ); begin SetIntegerField('HowToId'        , Value);end;
procedure THowToLines.SetStepNo        (const Value: Integer   ); begin SetIntegerField('StepNo'         , Value);end;
procedure THowToLines.SetHeader        (const Value: string    ); begin SetStringField('Header'         , Value);end;
procedure THowToLines.SetDescription   (const Value: string    ); begin SetStringField('Description'    , Value);end;
procedure THowToLines.SetFormText      (const Value: string    ); begin SetStringField('FormText'       , Value);end;
procedure THowToLines.SetFormClassName (const Value: string    ); begin SetStringField('FormClassName' , Value);end;
procedure THowToLines.SetFlowText      (const Value: string    ); begin SetStringField('FlowText'       , Value);end;
procedure THowToLines.SetFlowId        (const Value: Integer   ); begin SetIntegerField('FlowId'         , Value);end;
procedure THowToLines.SetFormImageIndex(const Value: Integer   ); begin SetIntegerField('FormImageIndex' , Value);end;
procedure THowToLines.SetVideoFile     (const Value: string    ); begin SetStringField('VideoFile'      , Value);end;
procedure THowToLines.SetVideoText     (const Value: string    ); begin SetStringField('VideoText'      , Value);end;


initialization
  RegisterClass(THowToLines);
  RegisterClass(THowTo);


end.
