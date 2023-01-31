unit busobjErpSetup;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  25/08/10  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TERPSetup = class(TMSBusObj)
  private
    function GetStep1           : Boolean   ;
    function GetStep2           : Boolean   ;
    function GetStep3           : Boolean   ;
    function GetStep4           : Boolean   ;
    function GetStep5           : Boolean   ;
    function GetStep6           : Boolean   ;
    function GetStep1Caption    : string    ;
    function GetStep2Caption    : string    ;
    function GetStep3Caption    : string    ;
    function GetStep4Caption    : string    ;
    function GetStep5Caption    : string    ;
    function GetStep6Caption    : string    ;
    procedure SetStep1           (const Value: Boolean   );
    procedure SetStep2           (const Value: Boolean   );
    procedure SetStep3           (const Value: Boolean   );
    procedure SetStep4           (const Value: Boolean   );
    procedure SetStep5           (const Value: Boolean   );
    procedure SetStep6           (const Value: Boolean   );
    procedure SetStep1Caption    (const Value: string    );
    procedure SetStep2Caption    (const Value: string    );
    procedure SetStep3Caption    (const Value: string    );
    procedure SetStep4Caption    (const Value: string    );
    procedure SetStep5Caption    (const Value: string    );
    procedure SetStep6Caption    (const Value: string    );

    function GetTrainingstep1           : Boolean   ;
    function GetTrainingstep2           : Boolean   ;
    function GetTrainingstep3           : Boolean   ;
    function GetTrainingstep4           : Boolean   ;
    function GetTrainingstep5           : Boolean   ;
    function GetTrainingstep6           : Boolean   ;
    function GetTrainingstep1Caption    : string    ;
    function GetTrainingstep2Caption    : string    ;
    function GetTrainingstep3Caption    : string    ;
    function GetTrainingstep4Caption    : string    ;
    function GetTrainingstep5Caption    : string    ;
    function GetTrainingstep6Caption    : string    ;
    procedure SetTrainingstep1           (const Value: Boolean   );
    procedure SetTrainingstep2           (const Value: Boolean   );
    procedure SetTrainingstep3           (const Value: Boolean   );
    procedure SetTrainingstep4           (const Value: Boolean   );
    procedure SetTrainingstep5           (const Value: Boolean   );
    procedure SetTrainingstep6           (const Value: Boolean   );
    procedure SetTrainingstep1Caption    (const Value: string    );
    procedure SetTrainingstep2Caption    (const Value: string    );
    procedure SetTrainingstep3Caption    (const Value: string    );
    procedure SetTrainingstep4Caption    (const Value: string    );
    procedure SetTrainingstep5Caption    (const Value: string    );
    procedure SetTrainingstep6Caption    (const Value: string    );

    function GetStep1VideoFilename    : string    ;
    function GetStep2VideoFilename    : string    ;
    function GetStep3VideoFilename    : string    ;
    function GetStep4VideoFilename    : string    ;
    function GetStep5VideoFilename    : string    ;
    function GetStep6VideoFilename    : string    ;
    function GetTrainingstep1VideoFilename    : string    ;
    function GetTrainingstep2VideoFilename    : string    ;
    function GetTrainingstep3VideoFilename    : string    ;
    function GetTrainingstep4VideoFilename    : string    ;
    function GetTrainingstep5VideoFilename    : string    ;
    function GetTrainingstep6VideoFilename    : string    ;


    procedure SetStep1VideoFilename    (const Value: string    );
    procedure SetStep2VideoFilename    (const Value: string    );
    procedure SetStep3VideoFilename    (const Value: string    );
    procedure SetStep4VideoFilename    (const Value: string    );
    procedure SetStep5VideoFilename    (const Value: string    );
    procedure SetStep6VideoFilename    (const Value: string    );
    procedure SetTrainingstep1VideoFilename    (const Value: string    );
    procedure SetTrainingstep2VideoFilename    (const Value: string    );
    procedure SetTrainingstep3VideoFilename    (const Value: string    );
    procedure SetTrainingstep4VideoFilename    (const Value: string    );
    procedure SetTrainingstep5VideoFilename    (const Value: string    );
    procedure SetTrainingstep6VideoFilename    (const Value: string    );
    function getCleanTrainingStep6: boolean;

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
    Property CleanTrainingStep6 :boolean read getCleanTrainingStep6;
  published
    property Step1            :Boolean     read GetStep1          write SetStep1       ;
    property Step2            :Boolean     read GetStep2          write SetStep2       ;
    property Step3            :Boolean     read GetStep3          write SetStep3       ;
    property Step4            :Boolean     read GetStep4          write SetStep4       ;
    property Step5            :Boolean     read GetStep5          write SetStep5       ;
    property Step6            :Boolean     read GetStep6          write SetStep6       ;
    property Step1Caption     :string      read GetStep1Caption   write SetStep1Caption;
    property Step2Caption     :string      read GetStep2Caption   write SetStep2Caption;
    property Step3Caption     :string      read GetStep3Caption   write SetStep3Caption;
    property Step4Caption     :string      read GetStep4Caption   write SetStep4Caption;
    property Step5Caption     :string      read GetStep5Caption   write SetStep5Caption;
    property Step6Caption     :string      read GetStep6Caption   write SetStep6Caption;
    property Trainingstep1            :Boolean     read GetTrainingstep1          write SetTrainingstep1       ;
    property Trainingstep2            :Boolean     read GetTrainingstep2          write SetTrainingstep2       ;
    property Trainingstep3            :Boolean     read GetTrainingstep3          write SetTrainingstep3       ;
    property Trainingstep4            :Boolean     read GetTrainingstep4          write SetTrainingstep4       ;
    property Trainingstep5            :Boolean     read GetTrainingstep5          write SetTrainingstep5       ;
    property Trainingstep6            :Boolean     read GetTrainingstep6          write SetTrainingstep6       ;
    property Trainingstep1Caption     :string      read GetTrainingstep1Caption   write SetTrainingstep1Caption;
    property Trainingstep2Caption     :string      read GetTrainingstep2Caption   write SetTrainingstep2Caption;
    property Trainingstep3Caption     :string      read GetTrainingstep3Caption   write SetTrainingstep3Caption;
    property Trainingstep4Caption     :string      read GetTrainingstep4Caption   write SetTrainingstep4Caption;
    property Trainingstep5Caption     :string      read GetTrainingstep5Caption   write SetTrainingstep5Caption;
    property Trainingstep6Caption     :string      read GetTrainingstep6Caption   write SetTrainingstep6Caption;
    property Step1VideoFilename     :string      read GetStep1VideoFilename   write SetStep1VideoFilename;
    property Step2VideoFilename     :string      read GetStep2VideoFilename   write SetStep2VideoFilename;
    property Step3VideoFilename     :string      read GetStep3VideoFilename   write SetStep3VideoFilename;
    property Step4VideoFilename     :string      read GetStep4VideoFilename   write SetStep4VideoFilename;
    property Step5VideoFilename     :string      read GetStep5VideoFilename   write SetStep5VideoFilename;
    property Step6VideoFilename     :string      read GetStep6VideoFilename   write SetStep6VideoFilename;
    property Trainingstep1VideoFilename     :string      read GetTrainingstep1VideoFilename   write SetTrainingstep1VideoFilename;
    property Trainingstep2VideoFilename     :string      read GetTrainingstep2VideoFilename   write SetTrainingstep2VideoFilename;
    property Trainingstep3VideoFilename     :string      read GetTrainingstep3VideoFilename   write SetTrainingstep3VideoFilename;
    property Trainingstep4VideoFilename     :string      read GetTrainingstep4VideoFilename   write SetTrainingstep4VideoFilename;
    property Trainingstep5VideoFilename     :string      read GetTrainingstep5VideoFilename   write SetTrainingstep5VideoFilename;
    property Trainingstep6VideoFilename     :string      read GetTrainingstep6VideoFilename   write SetTrainingstep6VideoFilename;
  end;


implementation


uses tcDataUtils, CommonLib;



  {TERPSetup}

constructor TERPSetup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'ERPSetup';
  fSQL := 'SELECT * FROM tblerpsetup';
end;


destructor TERPSetup.Destroy;
begin
  inherited;
end;


procedure TERPSetup.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetBooleanPropertyFromNode(node,'Step1');
  SetBooleanPropertyFromNode(node,'Step2');
  SetBooleanPropertyFromNode(node,'Step3');
  SetBooleanPropertyFromNode(node,'Step4');
  SetBooleanPropertyFromNode(node,'Step5');
  SetBooleanPropertyFromNode(node,'Step6');
  SetPropertyFromNode(node,'Step1Caption');
  SetPropertyFromNode(node,'Step2Caption');
  SetPropertyFromNode(node,'Step3Caption');
  SetPropertyFromNode(node,'Step4Caption');
  SetPropertyFromNode(node,'Step5Caption');
  SetPropertyFromNode(node,'Step6Caption');

  SetBooleanPropertyFromNode(node,'Trainingstep1');
  SetBooleanPropertyFromNode(node,'Trainingstep2');
  SetBooleanPropertyFromNode(node,'Trainingstep3');
  SetBooleanPropertyFromNode(node,'Trainingstep4');
  SetBooleanPropertyFromNode(node,'Trainingstep5');
  SetBooleanPropertyFromNode(node,'Trainingstep6');
  SetPropertyFromNode(node,'Trainingstep1Caption');
  SetPropertyFromNode(node,'Trainingstep2Caption');
  SetPropertyFromNode(node,'Trainingstep3Caption');
  SetPropertyFromNode(node,'Trainingstep4Caption');
  SetPropertyFromNode(node,'Trainingstep5Caption');
  SetPropertyFromNode(node,'Trainingstep6Caption');
  SetPropertyFromNode(node,'Step1VideoFilename');
  SetPropertyFromNode(node,'Step2VideoFilename');
  SetPropertyFromNode(node,'Step3VideoFilename');
  SetPropertyFromNode(node,'Step4VideoFilename');
  SetPropertyFromNode(node,'Step5VideoFilename');
  SetPropertyFromNode(node,'Step6VideoFilename');
  SetPropertyFromNode(node,'Trainingstep1VideoFilename');
  SetPropertyFromNode(node,'Trainingstep2VideoFilename');
  SetPropertyFromNode(node,'Trainingstep3VideoFilename');
  SetPropertyFromNode(node,'Trainingstep4VideoFilename');
  SetPropertyFromNode(node,'Trainingstep5VideoFilename');
  SetPropertyFromNode(node,'Trainingstep6VideoFilename');

end;


procedure TERPSetup.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Step1' ,Step1);
  AddXMLNode(node,'Step2' ,Step2);
  AddXMLNode(node,'Step3' ,Step3);
  AddXMLNode(node,'Step4' ,Step4);
  AddXMLNode(node,'Step5' ,Step5);
  AddXMLNode(node,'Step6' ,Step6);
  AddXMLNode(node,'Step1Caption' ,Step1Caption);
  AddXMLNode(node,'Step2Caption' ,Step2Caption);
  AddXMLNode(node,'Step3Caption' ,Step3Caption);
  AddXMLNode(node,'Step4Caption' ,Step4Caption);
  AddXMLNode(node,'Step5Caption' ,Step5Caption);
  AddXMLNode(node,'Step6Caption' ,Step6Caption);

   AddXMLNode(node,'Trainingstep1' ,Trainingstep1);
  AddXMLNode(node,'Trainingstep2' ,Trainingstep2);
  AddXMLNode(node,'Trainingstep3' ,Trainingstep3);
  AddXMLNode(node,'Trainingstep4' ,Trainingstep4);
  AddXMLNode(node,'Trainingstep5' ,Trainingstep5);
  AddXMLNode(node,'Trainingstep6' ,Trainingstep6);
  AddXMLNode(node,'Trainingstep1Caption' ,Trainingstep1Caption);
  AddXMLNode(node,'Trainingstep2Caption' ,Trainingstep2Caption);
  AddXMLNode(node,'Trainingstep3Caption' ,Trainingstep3Caption);
  AddXMLNode(node,'Trainingstep4Caption' ,Trainingstep4Caption);
  AddXMLNode(node,'Trainingstep5Caption' ,Trainingstep5Caption);
  AddXMLNode(node,'Trainingstep6Caption' ,Trainingstep6Caption);
  AddXMLNode(node,'Step1VideoFilename' ,Step1VideoFilename);
  AddXMLNode(node,'Step2VideoFilename' ,Step2VideoFilename);
  AddXMLNode(node,'Step3VideoFilename' ,Step3VideoFilename);
  AddXMLNode(node,'Step4VideoFilename' ,Step4VideoFilename);
  AddXMLNode(node,'Step5VideoFilename' ,Step5VideoFilename);
  AddXMLNode(node,'Step6VideoFilename' ,Step6VideoFilename);
  AddXMLNode(node,'Trainingstep1VideoFilename' ,Trainingstep1VideoFilename);
  AddXMLNode(node,'Trainingstep2VideoFilename' ,Trainingstep2VideoFilename);
  AddXMLNode(node,'Trainingstep3VideoFilename' ,Trainingstep3VideoFilename);
  AddXMLNode(node,'Trainingstep4VideoFilename' ,Trainingstep4VideoFilename);
  AddXMLNode(node,'Trainingstep5VideoFilename' ,Trainingstep5VideoFilename);
  AddXMLNode(node,'Trainingstep6VideoFilename' ,Trainingstep6VideoFilename);
end;


function TERPSetup.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function TERPSetup.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TERPSetup.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TERPSetup.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TERPSetup.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TERPSetup.GetIDField: string;
begin
  Result := 'ID'
end;


class function TERPSetup.GetBusObjectTablename: string;
begin
  Result:= 'tblerpsetup';
end;


function TERPSetup.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TERPSetup.GetStep1       : Boolean   ; begin Result := GetBooleanField('Step1');end;
function  TERPSetup.GetStep2       : Boolean   ; begin Result := GetBooleanField('Step2');end;
function  TERPSetup.GetStep3       : Boolean   ; begin Result := GetBooleanField('Step3');end;
function  TERPSetup.GetStep4       : Boolean   ; begin Result := GetBooleanField('Step4');end;
function  TERPSetup.GetStep5       : Boolean   ; begin Result := GetBooleanField('Step5');end;
function  TERPSetup.GetStep6       : Boolean   ; begin Result := GetBooleanField('Step6');end;
function  TERPSetup.GetStep1Caption: string    ; begin Result := GetStringField('Step1Caption');end;
function  TERPSetup.GetStep2Caption: string    ; begin Result := GetStringField('Step2Caption');end;
function  TERPSetup.GetStep3Caption: string    ; begin Result := GetStringField('Step3Caption');end;
function  TERPSetup.GetStep4Caption: string    ; begin Result := GetStringField('Step4Caption');end;
function  TERPSetup.GetStep5Caption: string    ; begin Result := GetStringField('Step5Caption');end;
function  TERPSetup.GetStep6Caption: string    ; begin Result := GetStringField('Step6Caption');end;
procedure TERPSetup.SetStep1       (const Value: Boolean   ); begin SetBooleanField('Step1'        , Value);end;
procedure TERPSetup.SetStep2       (const Value: Boolean   ); begin SetBooleanField('Step2'        , Value);end;
procedure TERPSetup.SetStep3       (const Value: Boolean   ); begin SetBooleanField('Step3'        , Value);end;
procedure TERPSetup.SetStep4       (const Value: Boolean   ); begin SetBooleanField('Step4'        , Value);end;
procedure TERPSetup.SetStep5       (const Value: Boolean   ); begin SetBooleanField('Step5'        , Value);end;
procedure TERPSetup.SetStep6       (const Value: Boolean   ); begin SetBooleanField('Step6'        , Value);end;
procedure TERPSetup.SetStep1Caption(const Value: string    ); begin SetStringField('Step1Caption'        , Value);end;
procedure TERPSetup.SetStep2Caption(const Value: string    ); begin SetStringField('Step2Caption'        , Value);end;
procedure TERPSetup.SetStep3Caption(const Value: string    ); begin SetStringField('Step3Caption'        , Value);end;
procedure TERPSetup.SetStep4Caption(const Value: string    ); begin SetStringField('Step4Caption'        , Value);end;
procedure TERPSetup.SetStep5Caption(const Value: string    ); begin SetStringField('Step5Caption'        , Value);end;
procedure TERPSetup.SetStep6Caption(const Value: string    ); begin SetStringField('Step6Caption'        , Value);end;
function  TERPSetup.GetTrainingstep1       : Boolean   ; begin Result := GetBooleanField('Trainingstep1');end;
function  TERPSetup.GetTrainingstep2       : Boolean   ; begin Result := GetBooleanField('Trainingstep2');end;
function  TERPSetup.GetTrainingstep3       : Boolean   ; begin Result := GetBooleanField('Trainingstep3');end;
function  TERPSetup.GetTrainingstep4       : Boolean   ; begin Result := GetBooleanField('Trainingstep4');end;
function  TERPSetup.GetTrainingstep5       : Boolean   ; begin Result := GetBooleanField('Trainingstep5');end;
function  TERPSetup.GetTrainingstep6       : Boolean   ; begin Result := GetBooleanField('Trainingstep6');end;
function  TERPSetup.GetTrainingstep1Caption: string    ; begin Result := GetStringField('Trainingstep1Caption');end;
function  TERPSetup.GetTrainingstep2Caption: string    ; begin Result := GetStringField('Trainingstep2Caption');end;
function  TERPSetup.GetTrainingstep3Caption: string    ; begin Result := GetStringField('Trainingstep3Caption');end;
function  TERPSetup.GetTrainingstep4Caption: string    ; begin Result := GetStringField('Trainingstep4Caption');end;
function  TERPSetup.GetTrainingstep5Caption: string    ; begin Result := GetStringField('Trainingstep5Caption');end;
function  TERPSetup.GetTrainingstep6Caption: string    ; begin Result := GetStringField('Trainingstep6Caption');end;
procedure TERPSetup.SetTrainingstep1       (const Value: Boolean   ); begin SetBooleanField('Trainingstep1'        , Value);end;
procedure TERPSetup.SetTrainingstep2       (const Value: Boolean   ); begin SetBooleanField('Trainingstep2'        , Value);end;
procedure TERPSetup.SetTrainingstep3       (const Value: Boolean   ); begin SetBooleanField('Trainingstep3'        , Value);end;
procedure TERPSetup.SetTrainingstep4       (const Value: Boolean   ); begin SetBooleanField('Trainingstep4'        , Value);end;
procedure TERPSetup.SetTrainingstep5       (const Value: Boolean   ); begin SetBooleanField('Trainingstep5'        , Value);end;
procedure TERPSetup.SetTrainingstep6       (const Value: Boolean   ); begin SetBooleanField('Trainingstep6'        , Value);end;
procedure TERPSetup.SetTrainingstep1Caption(const Value: string    ); begin SetStringField('Trainingstep1Caption'        , Value);end;
procedure TERPSetup.SetTrainingstep2Caption(const Value: string    ); begin SetStringField('Trainingstep2Caption'        , Value);end;
procedure TERPSetup.SetTrainingstep3Caption(const Value: string    ); begin SetStringField('Trainingstep3Caption'        , Value);end;
procedure TERPSetup.SetTrainingstep4Caption(const Value: string    ); begin SetStringField('Trainingstep4Caption'        , Value);end;
procedure TERPSetup.SetTrainingstep5Caption(const Value: string    ); begin SetStringField('Trainingstep5Caption'        , Value);end;
procedure TERPSetup.SetTrainingstep6Caption(const Value: string    ); begin SetStringField('Trainingstep6Caption'        , Value);end;
function  TERPSetup.GetStep1VideoFilename: string    ; begin Result := GetStringField('Step1VideoFilename');end;
function  TERPSetup.GetStep2VideoFilename: string    ; begin Result := GetStringField('Step2VideoFilename');end;
function  TERPSetup.GetStep3VideoFilename: string    ; begin Result := GetStringField('Step3VideoFilename');end;
function  TERPSetup.GetStep4VideoFilename: string    ; begin Result := GetStringField('Step4VideoFilename');end;
function  TERPSetup.GetStep5VideoFilename: string    ; begin Result := GetStringField('Step5VideoFilename');end;
function  TERPSetup.GetStep6VideoFilename: string    ; begin Result := GetStringField('Step6VideoFilename');end;
function  TERPSetup.GetTrainingstep1VideoFilename: string    ; begin Result := GetStringField('Trainingstep1VideoFilename');end;
function  TERPSetup.GetTrainingstep2VideoFilename: string    ; begin Result := GetStringField('Trainingstep2VideoFilename');end;
function  TERPSetup.GetTrainingstep3VideoFilename: string    ; begin Result := GetStringField('Trainingstep3VideoFilename');end;
function  TERPSetup.GetTrainingstep4VideoFilename: string    ; begin Result := GetStringField('Trainingstep4VideoFilename');end;
function  TERPSetup.GetTrainingstep5VideoFilename: string    ; begin Result := GetStringField('Trainingstep5VideoFilename');end;
function  TERPSetup.GetTrainingstep6VideoFilename: string    ; begin Result := GetStringField('Trainingstep6VideoFilename');end;



procedure TERPSetup.SetStep1VideoFilename(const Value: string    ); begin SetStringField('Step1VideoFilename'        , Value);end;
procedure TERPSetup.SetStep2VideoFilename(const Value: string    ); begin SetStringField('Step2VideoFilename'        , Value);end;
procedure TERPSetup.SetStep3VideoFilename(const Value: string    ); begin SetStringField('Step3VideoFilename'        , Value);end;
procedure TERPSetup.SetStep4VideoFilename(const Value: string    ); begin SetStringField('Step4VideoFilename'        , Value);end;
procedure TERPSetup.SetStep5VideoFilename(const Value: string    ); begin SetStringField('Step5VideoFilename'        , Value);end;
procedure TERPSetup.SetStep6VideoFilename(const Value: string    ); begin SetStringField('Step6VideoFilename'        , Value);end;
procedure TERPSetup.SetTrainingstep1VideoFilename(const Value: string    ); begin SetStringField('Trainingstep1VideoFilename'        , Value);end;
procedure TERPSetup.SetTrainingstep2VideoFilename(const Value: string    ); begin SetStringField('Trainingstep2VideoFilename'        , Value);end;
procedure TERPSetup.SetTrainingstep3VideoFilename(const Value: string    ); begin SetStringField('Trainingstep3VideoFilename'        , Value);end;
procedure TERPSetup.SetTrainingstep4VideoFilename(const Value: string    ); begin SetStringField('Trainingstep4VideoFilename'        , Value);end;
procedure TERPSetup.SetTrainingstep5VideoFilename(const Value: string    ); begin SetStringField('Trainingstep5VideoFilename'        , Value);end;
procedure TERPSetup.SetTrainingstep6VideoFilename(const Value: string    ); begin SetStringField('Trainingstep6VideoFilename'        , Value);end;



function TERPSetup.getCleanTrainingStep6: boolean;
begin
  REsult := GetXMLNodebooleanValue(Self.CleanXMLNOde,      'Trainingstep6');
end;

initialization
  RegisterClass(TERPSetup);


end.
