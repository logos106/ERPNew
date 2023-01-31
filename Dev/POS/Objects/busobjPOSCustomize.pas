unit busobjPOSCustomize;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   14/05/07   1.00.01   BS   Initial Version.
   }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
   TPOSFunctions = class(TMSBusObj)
   private
      Function GetFunctionname          :String    ;
      Function GetDescription           :String    ;
      Function GetHint                  :String    ;
      Function GetCaptionline1          :String    ;
      Function GetCaptionline2          :String    ;
      Function GetFontcolour            :Integer   ;
      Function GetFontname              :String    ;
      Function GetFontsize              :Integer   ;
      Function GetFontbold              :Boolean   ;
      Function GetFontitalic            :Boolean   ;
      Function GetFontunderline         :Boolean   ;
      Function GetBackgroundcolour      :Integer   ;
      Function GetTopmargin             :Integer   ;
      Function GetActive                :Boolean   ;
      Procedure SetFunctionname          (Const Value :String    );
      Procedure SetDescription           (Const Value :String    );
      Procedure SetHint                  (Const Value :String    );
      Procedure SetCaptionline1          (Const Value :String    );
      Procedure SetCaptionline2          (Const Value :String    );
      Procedure SetFontcolour            (Const Value :Integer   );
      Procedure SetFontname              (Const Value :String    );
      Procedure SetFontsize              (Const Value :Integer   );
      Procedure SetFontbold              (Const Value :Boolean   );
      Procedure SetFontitalic            (Const Value :Boolean   );
      Procedure SetFontunderline         (Const Value :Boolean   );
      Procedure SetBackgroundcolour      (Const Value :Integer   );
      Procedure SetTopmargin             (Const Value :Integer   );
      Procedure SetActive                (Const Value :Boolean   );


   Protected
      procedure     OnDataIdChange(Const ChangeType: TBusObjDataChangeType);   Override;
      procedure     DoFieldOnChange(Sender: TField);                           Override;
      Function      GetSQL : STring;                                           Override;
      Function      DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
   Public
      class function GetIDField: string; override;
      class function GetBusObjectTablename: string; Override;
      Constructor   Create(AOwner: TComponent);                             override;
      Destructor    Destroy;                                                override;
      Procedure     LoadFromXMLNode(Const node: IXMLNode);                  override;
      Procedure     SaveToXMLNode(Const node: IXMLNode);                    override;
      Function      ValidateData :Boolean ;                                 Override;
      Function      Save :Boolean ;                                         Override;

  Published
      Property Functionname           :String       Read getFunctionname        Write SetFunctionname    ;
      Property Description            :String       Read getDescription         Write SetDescription     ;
      Property Hint                   :String       Read getHint                Write SetHint            ;
      Property Captionline1           :String       Read getCaptionline1        Write SetCaptionline1    ;
      Property Captionline2           :String       Read getCaptionline2        Write SetCaptionline2    ;
      Property Fontcolour             :Integer      Read getFontcolour          Write SetFontcolour      ;
      Property Fontname               :String       Read getFontname            Write SetFontname        ;
      Property Fontsize               :Integer      Read getFontsize            Write SetFontsize        ;
      Property Fontbold               :Boolean      Read getFontbold            Write SetFontbold        ;
      Property Fontitalic             :Boolean      Read getFontitalic          Write SetFontitalic      ;
      Property Fontunderline          :Boolean      Read getFontunderline       Write SetFontunderline   ;
      Property Backgroundcolour       :Integer      Read getBackgroundcolour    Write SetBackgroundcolour;
      Property Topmargin              :Integer      Read getTopmargin           Write SetTopmargin       ;
      Property Active                 :Boolean      Read getActive              Write SetActive          ;
   End;

//   TFuncRooms = class(TMSBusObj)
//   private
//      Function GetName              :String    ;
//      Function GetCapacity          :Integer   ;
//      Function GetResettime         :TDatetime ;
//      Function GetPerday            :Double    ;
//      Function GetPerhalfday        :Double    ;
//      Function GetPerhour           :Double    ;
//      Function GetParentroomid      :Integer   ;
//      Function GetActive            :Boolean   ;
//      Procedure SetFuncRoomName      (Const Value :String    );
//      Procedure SetCapacity          (Const Value :Integer   );
//      Procedure SetResettime         (Const Value :TDatetime );
//      Procedure SetPerday            (Const Value :Double    );
//      Procedure SetPerhalfday        (Const Value :Double    );
//      Procedure SetPerhour           (Const Value :Double    );
//      Procedure SetParentroomid      (Const Value :Integer   );
//      Procedure SetActive            (Const Value :Boolean   );
//   Protected
//      procedure     OnDataIdChange(Const ChangeType: TBusObjDataChangeType);   Override;
//      procedure     DoFieldOnChange(Sender: TField);                           Override;
//      Function      GetSQL : STring;                                           Override;
//      Function      DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
//   Public
//      class function GetIDField: string; override;
//      class function GetBusObjectTablename: string; Override;
//      Constructor   Create(AOwner: TComponent);                             override;
//      Destructor    Destroy;                                                override;
//      Procedure     LoadFromXMLNode(Const node: IXMLNode);                  override;
//      Procedure     SaveToXMLNode(Const node: IXMLNode);                    override;
//      Function      ValidateData :Boolean ;                                 Override;
//      Function      Save :Boolean ;                                         Override;
//
//  Published
//      Property Name               :String       Read getName            Write SetFuncRoomName;
//      Property Capacity           :Integer      Read getCapacity        Write SetCapacity    ;
//      Property Resettime          :TDatetime    Read getResettime       Write SetResettime   ;
//      Property Perday             :Double       Read getPerday          Write SetPerday      ;
//      Property Perhalfday         :Double       Read getPerhalfday      Write SetPerhalfday  ;
//      Property Perhour            :Double       Read getPerhour         Write SetPerhour     ;
//      Property Parentroomid       :Integer      Read getParentroomid    Write SetParentroomid;
//      Property Active             :Boolean      Read getActive          Write SetActive      ;
//   End;

//   TPOSKeyPadCustomize = class(TMSBusObj)
//   private
//      fPOSFunctions                     :TPOSFunctions;
//      fPOSFuncRooms                     :TFuncRooms;
//      Function GetKeypadid              :Integer   ;
//      Function GetKeyname               :String    ;
//      Function GetQuickkey              :Boolean   ;
//      Function GetCaptionline1          :String    ;
//      Function GetCaptionline2          :String    ;
//      Function GetFontcolour            :Integer   ;
//      Function GetFontname              :String    ;
//      Function GetFontsize              :Integer   ;
//      Function GetFontbold              :Boolean   ;
//      Function GetFontitalic            :Boolean   ;
//      Function GetFontunderline         :Boolean   ;
//      Function GetBackgroundcolour      :Integer   ;
//      Function GetTopmargin             :Double    ;
//      Function GetPartid                :Integer   ;
//      Function GetFunctionno            :Integer   ;
//      Function GetFunctiontype          :Integer   ;
//      Function GetFunctionname          :String    ;
//      Function GetHint                  :String    ;
//      Function GetRoomid                :Integer   ;
//      Function GetMemo                  :String    ;
//      Function getPOSFunction           :TPOSFunctions;
//      Function geTFuncRooms             :TFuncRooms;
//      Function GetActive                :Boolean;
//      Procedure SetKeypadid             (Const Value :Integer   );
//      Procedure SetKeyname              (Const Value :String    );
//      Procedure SetQuickkey             (Const Value :Boolean   );
//      Procedure SetCaptionline1         (Const Value :String    );
//      Procedure SetCaptionline2         (Const Value :String    );
//      Procedure SetFontcolour           (Const Value :Integer   );
//      Procedure SetFontname             (Const Value :String    );
//      Procedure SetFontsize             (Const Value :Integer   );
//      Procedure SetFontbold             (Const Value :Boolean   );
//      Procedure SetFontitalic           (Const Value :Boolean   );
//      Procedure SetFontunderline        (Const Value :Boolean   );
//      Procedure SetBackgroundcolour     (Const Value :Integer   );
//      Procedure SetTopmargin            (Const Value :Double    );
//      Procedure SetPartid               (Const Value :Integer   );
//      Procedure SetFunctionno           (Const Value :Integer   );
//      Procedure SetFunctiontype         (Const Value :Integer   );
//      Procedure SetFunctionname         (Const Value :String    );
//      Procedure SetHint                 (Const Value :String    );
//      Procedure SetRoomid               (Const Value :Integer   );
//      Procedure SetMemo                 (Const Value :String    );
//   Protected
//      procedure     OnDataIdChange(Const ChangeType: TBusObjDataChangeType);   Override;
//      procedure     DoFieldOnChange(Sender: TField);                           Override;
//      Function      GetSQL : STring;                                           Override;
//      Function      DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
//      Function      DoAfterInsert(Sender :TDatasetBusObj ):Boolean;            Override;
//      Function      ValidateXMLData(Const node :IXMLNode) :Boolean ;            override;
//   Public
//      class function GetIDField: string; override;
//      class function GetBusObjectTablename: string; Override;
//      Constructor   Create(AOwner: TComponent);                             override;
//      Destructor    Destroy;                                                override;
//      Procedure     LoadFromXMLNode(Const node: IXMLNode);                  override;
//      Procedure     SaveToXMLNode(Const node: IXMLNode);                    override;
//      Function      ValidateData :Boolean ;                                 Override;
//      Function      Save :Boolean ;                                         Override;
//
//  Published
//      Property Keypadid               :Integer      Read getKeypadid            Write SetKeypadid        ;
//      Property Keyname                :String       Read getKeyname             Write SetKeyname         ;
//      Property Quickkey               :Boolean      Read getQuickkey            Write SetQuickkey        ;
//      Property Captionline1           :String       Read getCaptionline1        Write SetCaptionline1    ;
//      Property Captionline2           :String       Read getCaptionline2        Write SetCaptionline2    ;
//      Property Fontcolour             :Integer      Read getFontcolour          Write SetFontcolour      ;
//      Property Fontname               :String       Read getFontname            Write SetFontname        ;
//      Property Fontsize               :Integer      Read getFontsize            Write SetFontsize        ;
//      Property Fontbold               :Boolean      Read getFontbold            Write SetFontbold        ;
//      Property Fontitalic             :Boolean      Read getFontitalic          Write SetFontitalic      ;
//      Property Fontunderline          :Boolean      Read getFontunderline       Write SetFontunderline   ;
//      Property Backgroundcolour       :Integer      Read getBackgroundcolour    Write SetBackgroundcolour;
//      Property Topmargin              :Double       Read getTopmargin           Write SetTopmargin       ;
//      Property Partid                 :Integer      Read getPartid              Write SetPartid          ;
//      Property Functionno             :Integer      Read getFunctionno          Write SetFunctionno      ;
//      Property Functiontype           :Integer      Read getFunctiontype        Write SetFunctiontype    ;
//      Property Functionname           :String       Read getFunctionname        Write SetFunctionname    ;
//      Property Hint                   :String       Read getHint                Write SetHint            ;
//      Property Roomid                 :Integer      Read getRoomid              Write SetRoomid          ;
//      Property Memo                   :String       Read getMemo                Write SetMemo            ;
//      Property POSFunction            :TPOSFunctions Read getPOSFunction        Write fPOSFunctions      ;
//      Property POSFuncRooms           :TFuncRooms    Read geTFuncRooms          Write fPOSFuncRooms;
//      Property Active                 :Boolean       REad getActive;
//   End;

//   TPOSKeyPads = class(TMSBusObj)
//   private
//      fKeyPadCustomize :TPOSKeyPadCustomize;
//      Function GetDescription      :String    ;
//      Function GetActive           :Boolean   ;
//      Procedure SetDescription      (Const Value :String    );
//      Procedure SetActive           (Const Value :Boolean   );
//      Function getKeyPadCustomize  :TPOSKeyPadCustomize;
//   Protected
//      procedure     OnDataIdChange(Const ChangeType: TBusObjDataChangeType);    Override;
//      procedure     DoFieldOnChange(Sender: TField);                            Override;
//      Function      GetSQL : STring;                                            Override;
//      Function      DoAfterPost(Sender :TDatasetBusObj ):Boolean;               Override;
//      Function      ExportsubClasses(Const node: IXMLNode):Boolean;             Override;
//      Function      ImportsubClasses(const node: IXMLNode):Boolean;             Override;
//   Public
//      class function GetIDField: string; override;
//      class function GetBusObjectTablename: string; Override;
//      Constructor   Create(AOwner: TComponent);                                 override;
//      Destructor    Destroy;                                                    override;
//      Procedure     LoadFromXMLNode(Const node: IXMLNode);                      override;
//      Procedure     SaveToXMLNode(Const node: IXMLNode);                        override;
//      Function      ValidateData :Boolean ;                                     Override;
//      Function      Save :Boolean ;                                             Override;
//
//  Published
//      Property Description       :String       Read getDescription    Write SetDescription;
//      Property Active            :Boolean      Read getActive         Write SetActive     ;
//      Property KeyPadCustomize   :TPOSKeyPadCustomize REad getKeyPadCustomize Write fKeyPadCustomize;
//   End;



implementation


uses FastFuncs,tcDataUtils, Sysutils, CommonLib;


{========================================================
         TFuncRooms
========================================================}
//constructor TFuncRooms.Create(AOwner: TComponent);
//begin
//   inherited Create(AOwner)
//end;
//
//
//destructor TFuncRooms.Destroy;
//begin
//   inherited;
//end;
//
//
//procedure   TFuncRooms.LoadFromXMLNode(Const node: IXMLNode);
//begin
//   inherited;
//    SetPropertyFromNode(Node,'Name');
//    SetPropertyFromNode(Node,'Capacity');
//    SetDateTimePropertyFromNode(Node,'Resettime');
//    SetPropertyFromNode(Node,'Perday');
//    SetPropertyFromNode(Node,'Perhalfday');
//    SetPropertyFromNode(Node,'Perhour');
//    SetPropertyFromNode(Node,'Parentroomid');
//    SetBooleanPropertyFromNode(Node,'Active');
//end;
//
//
//procedure   TFuncRooms.SaveToXMLNode(Const node: IXMLNode);
//begin
//   inherited;
//      AddXMLNode(node,'Name' ,Name);
//      AddXMLNode(node,'Capacity' ,Capacity);
//      AddXMLNode(node,'Resettime' ,Resettime);
//      AddXMLNode(node,'Perday' ,Perday);
//      AddXMLNode(node,'Perhalfday' ,Perhalfday);
//      AddXMLNode(node,'Perhour' ,Perhour);
//      AddXMLNode(node,'Parentroomid' ,Parentroomid);
//      AddXMLNode(node,'Active' ,Active);
//end;
//
//
//function    TFuncRooms.ValidateData :Boolean ;
//begin
//   Result := False;
//   Resultstatus.Clear;
//   if Name = '' then begin
//      Resultstatus.AddItem(False , rssError , 0,  'Name should not be blank' , False );
//      Exit;
//   end;
//   Result := true;
//end;
//
//
//function    TFuncRooms.Save :Boolean ;
//begin
//   Result := False;
//   if not ValidateData then Exit;
//   Result := Inherited Save;
//end;
//
//
//procedure TFuncRooms.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
//begin
//   inherited;
//end;
//
//
//procedure TFuncRooms.DoFieldOnChange(Sender: TField);
//begin
//   inherited;
//end;
//
//
//Function TFuncRooms.GetSQL: String ;
//begin
//   fSQL := 'SELECT * FROM tblfuncrooms';
//   Result := Inherited GetSQL;
//end;
//
//
//class function  TFuncRooms.GetIDField : String;
//begin
//   Result := 'Roomid'
//end;
//
//class function TFuncRooms.GetBusObjectTablename: string;
//begin
//  Result := 'tblfuncrooms';
//end;
//
//
//Function  TFuncRooms.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
//begin
//   Result := inherited DoAfterPost(sender);
//End;
//
//
//{Property functions}
//Function  TFuncRooms.GetName        :String    ; begin Result := GetStringField('Name');End;
//Function  TFuncRooms.GetCapacity    :Integer   ; begin Result := GetIntegerField('Capacity');End;
//Function  TFuncRooms.GetResettime   :TDatetime ; begin Result := GetDatetimeField('Resettime');End;
//Function  TFuncRooms.GetPerday      :Double    ; begin Result := GetFloatField('Perday');End;
//Function  TFuncRooms.GetPerhalfday  :Double    ; begin Result := GetFloatField('Perhalfday');End;
//Function  TFuncRooms.GetPerhour     :Double    ; begin Result := GetFloatField('Perhour');End;
//Function  TFuncRooms.GetParentroomid:Integer   ; begin Result := GetIntegerField('Parentroomid');End;
//Function  TFuncRooms.GetActive      :Boolean   ; begin Result := GetBooleanField('Active');End;
//Procedure TFuncRooms.SetFuncRoomName(Const Value :String    ); begin SetStringField('Name'         , Value);End;
//Procedure TFuncRooms.SetCapacity    (Const Value :Integer   ); begin SetIntegerField('Capacity'     , Value);End;
//Procedure TFuncRooms.SetResettime   (Const Value :TDatetime ); begin SetDatetimeField('Resettime'    , Value);End;
//Procedure TFuncRooms.SetPerday      (Const Value :Double    ); begin SetFloatField('Perday'       , Value);End;
//Procedure TFuncRooms.SetPerhalfday  (Const Value :Double    ); begin SetFloatField('Perhalfday'   , Value);End;
//Procedure TFuncRooms.SetPerhour     (Const Value :Double    ); begin SetFloatField('Perhour'      , Value);End;
//Procedure TFuncRooms.SetParentroomid(Const Value :Integer   ); begin SetIntegerField('Parentroomid'      , Value);End;
//Procedure TFuncRooms.SetActive      (Const Value :Boolean   ); begin SetBooleanField('Active'       , Value);End;


{========================================================
         TPOSKeyPadCustomize
========================================================}
//constructor TPOSKeyPadCustomize.Create(AOwner: TComponent);
//begin
//   inherited Create(AOwner)
//end;
//
//
//destructor TPOSKeyPadCustomize.Destroy;
//begin
//   inherited;
//end;
//
//Function TPOSKeyPadCustomize.ValidateXMLData(Const node :IXMLNode) :Boolean ;
//var
//    iKeypadid :Integer;
//    iFunctionno :Integer;
//    iProductId :Integer;
//    iRoomID :Integer;
//begin
//    Result := inherited ValidateXMLData(node);
//    if not Result then Exit;
//    if not ImportingFromXMLFile then Exit;
//    XMLSearchRecordDesc :='KeyName = ' + GetXMLNodeStringValue(Node,'KeyName')  ;
//    if GetXMLNodeStringValue(Node,'ProductName') <> '' then
//        XMLSearchRecordDesc :='ProductName = ' + GetXMLNodeStringValue(node, 'ProductName')  ;
//    if GetXMLNodeStringValue(Node,'Functionname') <> '' then
//        XMLSearchRecordDesc :='Functionname = ' + GetXMLNodeStringValue(node, 'Functionname')  ;
//
//
//    Result := False;
//{Foreign key validation}
//    if GetXMLNodeStringValue(Node,'ProductName') <> '' then begin
//        iProductId := tcDataUtils.GetProduct(GetXMLNodeStringValue(Node,'ProductName'));
//        if iProductID = 0 then begin
//            ErrRecordNotfound('ProductName' , GetXMLNodeStringValue(Node, 'ProductName'));
//            Exit;
//        end;
//    end;
//    if GetXMLNodeStringValue(Node,'Roomname') <> '' then begin
//        iRoomId := tcDataUtils.getFuncRoomID(GetXMLNodeStringValue(Node,'roomName'));
//        if iRoomId = 0 then begin
//            ErrRecordNotfound('RoomName' , GetXMLNodeStringValue(Node, 'roomname'));
//            Exit;
//        end;
//    end;
//    if (Assigned(Self.Owner))  and (Self.Owner is TPOSKeyPads) then begin
//        iKeyPadId :=TPOSKeyPads(Self.Owner).Id;
//    end else begin
//        ikeyPadId := tcdatautils.getPOSkeyPADID(GetXMLNodeStringValue(Node, 'KeyName'));
//    end;
//    if ikeyPadId = 0 then begin
//            ErrRecordNotfound('KeyName' , GetXMLNodeStringValue(Node, 'KeyName'));
//            Exit;
//    end;
//    if GetXMLNodeStringValue(Node,'functionname') <> '' then begin
//        ifunctionno := tcDataUtils.GetProduct(GetXMLNodeStringValue(Node,'functionname'));
//        if ifunctionno = 0 then begin
//            ErrRecordNotfound('functionname' , GetXMLNodeStringValue(Node, 'functionname'));
//            Exit;
//        end;
//    end;
//
//    Result := True;
//    {search on the globalref if exists, otherwise on Id}
//    if GetXMLNodeStringValue(Node, 'Globalref') <> '' then
//        XMLSearchRecord := 'globalref = ' + quotedstr(GetXMLNodeStringValue(Node, 'Globalref'));
//    LocateXMLRecord;
//end;
//
//procedure   TPOSKeyPadCustomize.LoadFromXMLNode(Const node: IXMLNode);
//begin
//  inherited;
//  if not ImportingFromXMLFile then begin
//    SetPropertyFromNode(Node,'Keypadid');
//    SetPropertyFromNode(Node,'Functionno');
//    SetPropertyFromNode(Node,'Partid');
//    SetPropertyFromNode(Node,'Roomid');
//  end else begin
//    if GetXMLNodeStringValue(Node,'ProductName')    <> ''       then Partid     :=tcDatautils.GetProduct(GetXMLNodeStringValue(Node,'ProductName'));
//    if GetXMLNodeStringValue(Node,'FunctionName')   <> ''       then Functionno := tcDataUtils.GetProduct(GetXMLNodeStringValue(Node,'FunctionName'));
//    if GetXMLNodeStringValue(Node,'RoomName')       <> ''       then roomId     := tcDataUtils.getFuncRoomID(GetXMLNodeStringValue(Node,'RoomName'));
//    if (Assigned(Self.Owner))  and (Self.Owner is TPOSKeyPads)  then Keypadid   :=TPOSKeyPads(Self.Owner).Id
//    else if GetXMLNodeStringValue(Node, 'KeyName')  <> ''       then Keypadid   := tcdatautils.getPOSkeyPADID(GetXMLNodeStringValue(Node, 'KeyName'));
//  end;
//  SetPropertyFromNode(Node,'Keyname');
//  SetBooleanPropertyFromNode(Node,'Quickkey');
//  SetPropertyFromNode(Node,'Captionline1');
//  SetPropertyFromNode(Node,'Captionline2');
//  SetPropertyFromNode(Node,'Fontcolour');
//  SetPropertyFromNode(Node,'Fontname');
//  SetPropertyFromNode(Node,'Fontsize');
//  SetBooleanPropertyFromNode(Node,'Fontbold');
//  SetBooleanPropertyFromNode(Node,'Fontitalic');
//  SetBooleanPropertyFromNode(Node,'Fontunderline');
//  SetPropertyFromNode(Node,'Backgroundcolour');
//  SetPropertyFromNode(Node,'Topmargin');
//  SetPropertyFromNode(Node,'Functiontype');
//  SetPropertyFromNode(Node,'Functionname');
//  SetPropertyFromNode(Node,'Hint');
//  SetPropertyFromNode(Node,'Memo');
//end;
//
//
//procedure   TPOSKeyPadCustomize.SaveToXMLNode(Const node: IXMLNode);
//begin
//   inherited;
//      if not SavingXMLTofile then begin
//          AddXMLNode(node,'Keypadid'    ,Keypadid);
//          AddXMLNode(node,'Functionno'  ,Functionno);
//          AddXMLNode(node,'Partid'      ,Partid);
//          AddXMLNode(node,'Roomid'      ,Roomid);
//      end else begin
//          AddXMLNode(node,'ProductName' ,tcDatautils.getproduct(Partid));
//          AddXMLNode(node,'Roomname'    ,tcDatautils.getFuncRoomName(RoomId));
//          if Partid <> 0 then
//                AddXMLNode(node,'UnitOfMeasure'    ,tcDatautils.GetUOMName(Functiontype))
//          else  AddXMLNode(node,'UnitOfMeasure'    ,'')
//      end;
//      AddXMLNode(node,'Keyname'         ,Keyname);
//      AddXMLNode(node,'Quickkey'        ,Quickkey);
//      AddXMLNode(node,'Captionline1'    ,Captionline1);
//      AddXMLNode(node,'Captionline2'    ,Captionline2);
//      AddXMLNode(node,'Fontcolour'      ,Fontcolour);
//      AddXMLNode(node,'RGBFontcolour'   ,getRGB(Fontcolour));
//      AddXMLNode(node,'Fontname'        ,Fontname);
//      AddXMLNode(node,'Fontsize'        ,Fontsize);
//      AddXMLNode(node,'Fontbold'        ,Fontbold);
//      AddXMLNode(node,'Fontitalic'      ,Fontitalic);
//      AddXMLNode(node,'Fontunderline'   ,Fontunderline);
//      AddXMLNode(node,'Backgroundcolour',Backgroundcolour);
//      AddXMLNode(node,'RGBBackgroundcolour' ,getRGB(Backgroundcolour));
//      AddXMLNode(node,'Topmargin'       ,Topmargin);
//      AddXMLNode(node,'Functiontype'    ,Functiontype);
//      AddXMLNode(node,'Functionname'    ,Functionname);
//      AddXMLNode(node,'Hint'            ,Hint);
//      AddXMLNode(node,'Memo'            ,Memo);
//      AddXMLNode(node,'Active'          ,Active);
//end;
//
//function    TPOSKeyPadCustomize.ValidateData :Boolean ;
//begin
//   Result := False;
//   Resultstatus.Clear;
//   if Keypadid = 0 then begin
//      Resultstatus.AddItem(False , rssError , 0,  'Keypadid should not be 0' , False );
//      Exit;
//   end;
//   if Keyname = '' then begin
//      Resultstatus.AddItem(False , rssError , 0,  'Keyname should not be blank' , False );
//      Exit;
//   end;
//   Result := true;
//end;
//
//
//function    TPOSKeyPadCustomize.Save :Boolean ;
//begin
//   Result := False;
//   if not ValidateData then Exit;
//   Result := Inherited Save;
//end;
//
//
//procedure TPOSKeyPadCustomize.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
//begin
//   inherited;
//end;
//
//
//procedure TPOSKeyPadCustomize.DoFieldOnChange(Sender: TField);
//begin
//      if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
//        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
//      inherited;
//      if Sysutils.SameText(Sender.fieldName , 'Keyname') then begin
//          KeyPadId := TcdataUtils.getPOSKeyPadID(Sender.Value);
//          DoFieldOnChange(dataset.findfield('KeyPadID'));
//      end else if Sysutils.SameText(Sender.fieldname , 'functionname') then begin
//          functionno := tcDatautils.getPOSFunctionID(sender.Value);
//          DoFieldOnChange(dataset.findfield('functionNo'));
//      end;
//end;
//
//
//Function TPOSKeyPadCustomize.GetSQL: String ;
//begin
//   fSQL := 'SELECT * FROM tblposkeypadcustomize';
//   Result := Inherited GetSQL;
//end;
//
//
//class function  TPOSKeyPadCustomize.GetIDField : String;
//begin
//   Result := 'Keyid'
//end;
//
//class function TPOSKeyPadCustomize.GetBusObjectTablename: string;
//begin
//  Result := 'tblposkeypadcustomize';
//end;
//
//Function  TPOSKeyPadCustomize.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
//begin
//   Result := inherited DoAfterPost(sender);
//End;
//Function TPOSKeyPadCustomize.geTFuncRooms          :TFuncRooms;
//begin
//    if not (Assigned(fPOSFuncRooms)) then begin
//        fPOSFuncRooms := TFuncRooms.Create(SElf);
//    end;
//    if (fPOSFuncRooms.SQLSelect <> 'RoomId = ' + IntToStr(RoomId)) or (fPOSFuncRooms.Dataset.Active = False) then begin
//        fPOSFuncRooms.LoadSelect('RoomId = ' + IntToStr(RoomId));
//    end;
//    Result :=fPOSFuncRooms;
//end;
//Function TPOSKeyPadCustomize.getPOSFunction           :TPOSFunctions;
//begin
//    if not (Assigned(fPOSFunctions)) then begin
//        fPOSFunctions := TPOSFunctions.Create(SElf);
//    end;
//    if (fPOSFunctions.SQLSelect <> 'functionId = ' + IntToStr(FunctionNO)) or (fPOSFunctions.Dataset.Active = False) then begin
//        fPOSFunctions.LoadSelect('functionId = ' + IntToStr(FunctionNO));
//    end;
//    Result :=fPOSFunctions;
//end;
//Function TPOSKeyPadCustomize.getActive:Boolean;
//begin
//    Result :=  ((PartID>0) or (Functionno > 0));
//end;
//{Property functions}
//Function  TPOSKeyPadCustomize.GetTopmargin       :Double    ; begin Result := GetFloatField('Topmargin');End;
//Function  TPOSKeyPadCustomize.GetKeypadid        :Integer   ; begin Result := GetIntegerField('Keypadid');End;
//Function  TPOSKeyPadCustomize.GetFontcolour      :Integer   ; begin Result := GetIntegerField('Fontcolour');End;
//Function  TPOSKeyPadCustomize.GetBackgroundcolour:Integer   ; begin Result := GetIntegerField('Backgroundcolour');End;
//Function  TPOSKeyPadCustomize.GetPartid          :Integer   ; begin Result := GetIntegerField('Partid');End;
//Function  TPOSKeyPadCustomize.GetFunctionno      :Integer   ; begin Result := GetIntegerField('Functionno');End;
//Function  TPOSKeyPadCustomize.GetFunctiontype    :Integer   ; begin Result := GetIntegerField('Functiontype');End;
//Function  TPOSKeyPadCustomize.GetRoomid          :Integer   ; begin Result := GetIntegerField('Roomid');End;
//Function  TPOSKeyPadCustomize.GetFontsize        :Integer   ; begin Result := GetIntegerField('Fontsize');End;
//Function  TPOSKeyPadCustomize.GetQuickkey        :Boolean   ; begin Result := GetBooleanField('Quickkey');End;
//Function  TPOSKeyPadCustomize.GetFontbold        :Boolean   ; begin Result := GetBooleanField('Fontbold');End;
//Function  TPOSKeyPadCustomize.GetFontunderline   :Boolean   ; begin Result := GetBooleanField('Fontunderline');End;
//Function  TPOSKeyPadCustomize.GetFontitalic      :Boolean   ; begin Result := GetBooleanField('Fontitalic');End;
//Function  TPOSKeyPadCustomize.GetFontname        :String    ; begin Result := GetStringField('Fontname');End;
//Function  TPOSKeyPadCustomize.GetMemo            :String    ; begin Result := GetStringField('Memo');End;
//Function  TPOSKeyPadCustomize.GetKeyname         :String    ; begin Result := GetStringField('Keyname');End;
//Function  TPOSKeyPadCustomize.GetCaptionline1    :String    ; begin Result := GetStringField('Captionline1');End;
//Function  TPOSKeyPadCustomize.GetFunctionname    :String    ; begin Result := GetStringField('Functionname');End;
//Function  TPOSKeyPadCustomize.GetHint            :String    ; begin Result := GetStringField('Hint');End;
//Function  TPOSKeyPadCustomize.GetCaptionline2    :String    ; begin Result := GetStringField('Captionline2');End;
//Procedure TPOSKeyPadCustomize.SetTopmargin       (Const Value :Double    ); begin SetFloatField('Topmargin'        , Value);End;
//Procedure TPOSKeyPadCustomize.SetKeypadid        (Const Value :Integer   ); begin SetIntegerField('Keypadid'         , Value);End;
//Procedure TPOSKeyPadCustomize.SetFontcolour      (Const Value :Integer   ); begin SetIntegerField('Fontcolour'       , Value);End;
//Procedure TPOSKeyPadCustomize.SetFontsize        (Const Value :Integer   ); begin SetIntegerField('Fontsize'         , Value);End;
//Procedure TPOSKeyPadCustomize.SetBackgroundcolour(Const Value :Integer   ); begin SetIntegerField('Backgroundcolour'    , Value);End;
//Procedure TPOSKeyPadCustomize.SetPartid          (Const Value :Integer   ); begin SetIntegerField('Partid'           , Value);End;
//Procedure TPOSKeyPadCustomize.SetFunctionno      (Const Value :Integer   ); begin SetIntegerField('Functionno'       , Value);End;
//Procedure TPOSKeyPadCustomize.SetFunctiontype    (Const Value :Integer   ); begin SetIntegerField('Functiontype'     , Value);End;
//Procedure TPOSKeyPadCustomize.SetRoomid          (Const Value :Integer   ); begin SetIntegerField('Roomid'           , Value);End;
//Procedure TPOSKeyPadCustomize.SetFontname        (Const Value :String    ); begin SetStringField('Fontname'         , Value);End;
//Procedure TPOSKeyPadCustomize.SetFunctionname    (Const Value :String    ); begin SetStringField('Functionname'     , Value);End;
//Procedure TPOSKeyPadCustomize.SetHint            (Const Value :String    ); begin SetStringField('Hint'             , Value);End;
//Procedure TPOSKeyPadCustomize.SetMemo            (Const Value :String    ); begin SetStringField('Memo'             , Value);End;
//Procedure TPOSKeyPadCustomize.SetKeyname         (Const Value :String    ); begin SetStringField('Keyname'          , Value);End;
//Procedure TPOSKeyPadCustomize.SetCaptionline1    (Const Value :String    ); begin SetStringField('Captionline1'     , Value);End;
//Procedure TPOSKeyPadCustomize.SetCaptionline2    (Const Value :String    ); begin SetStringField('Captionline2'     , Value);End;
//Procedure TPOSKeyPadCustomize.SetQuickkey        (Const Value :Boolean   ); begin SetBooleanField('Quickkey'         , Value);End;
//Procedure TPOSKeyPadCustomize.SetFontbold        (Const Value :Boolean   ); begin SetBooleanField('Fontbold'         , Value);End;
//Procedure TPOSKeyPadCustomize.SetFontitalic      (Const Value :Boolean   ); begin SetBooleanField('Fontitalic'       , Value);End;
//Procedure TPOSKeyPadCustomize.SetFontunderline   (Const Value :Boolean   ); begin SetBooleanField('Fontunderline'    , Value);End;


{========================================================
         TPOSKeyPads
========================================================}
//constructor TPOSKeyPads.Create(AOwner: TComponent);
//begin
//   inherited Create(AOwner)
//end;
//
//
//destructor TPOSKeyPads.Destroy;
//begin
//   inherited;
//end;
//
//
//procedure   TPOSKeyPads.LoadFromXMLNode(Const node: IXMLNode);
//begin
//  inherited;
//  SetPropertyFromNode(Node,'Description');
//  SetBooleanPropertyFromNode(Node,'Active');
//end;
//
//
//procedure   TPOSKeyPads.SaveToXMLNode(Const node: IXMLNode);
//begin
//   inherited;
//      AddXMLNode(node,'Description' ,Description);
//      AddXMLNode(node,'Active' ,Active);
//      ExportsubClasses(Node);
//end;
//
//
//function    TPOSKeyPads.ValidateData :Boolean ;
//begin
//   Result := False;
//   Resultstatus.Clear;
//   if Description = '' then begin
//      Resultstatus.AddItem(False , rssError , 0,  'Description should not be blank' , False );
//      Exit;
//   end;
//   Result := true;
//end;
//
//
//function    TPOSKeyPads.Save :Boolean ;
//begin
//   Result := False;
//   if not ValidateData then Exit;
//   Result := Inherited Save;
//end;
//
//
//procedure TPOSKeyPads.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
//begin
//   inherited;
//end;
//
//
//procedure TPOSKeyPads.DoFieldOnChange(Sender: TField);
//begin
//   inherited;
//end;
//
//
//Function TPOSKeyPads.GetSQL: String ;
//begin
//   fSQL := 'SELECT * FROM tblposkeypads';
//   Result := Inherited GetSQL;
//end;
//
//
//class function  TPOSKeyPads.GetIDField : String;
//begin
//   Result := 'Keypadid'
//end;
//
//class function TPOSKeyPads.GetBusObjectTablename: string;
//begin
//  Result := 'tblposkeypads';
//end;
//
//Function TPOSKeyPads.ImportsubClasses(const node: IXMLNode):Boolean;
//var
//    x:Integer;
//    Singlerec :IXMLNode;
//begin
//    Result := False;
//    ImportFailed := False;
//    XMLPropertyName :=self.KeyPadCustomize.XMLNodeName;
//    XMLPropertyNode := node.ChildNodes.FindNode(XMLPropertyName);
//    if Assigned(XMLPropertyNode) then begin
//        for x := 0 to XMLPropertyNode.ChildNodes.Count - 1 do begin
//            KeyPadCustomize.ImportingFromXMLFile := True;
//            Singlerec:= XMLPropertyNode.ChildNodes[x];
//            KeyPadCustomize.ImportFromXML(SingleRec);
//            ImportFailed :=KeyPadCustomize.ImportFailed;
//            if Error then Exit;
//        end;
//    end;
//    Result := True;
//end;
//Function TPOSKeyPads.ExportsubClasses(Const node: IXMLNode):Boolean;
//begin
//    self.KeyPadCustomize.XMLPropertyNode := node.AddChild(self.KeyPadCustomize.XMLNodeName);
//    self.KeyPadCustomize.XMLPropertyName:= 'Customization';
//    self.KeyPadCustomize.IterateRecords(GetPropertyXMLCallback);
//    Result := True;
//end;
//Function  TPOSKeyPads.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
//begin
//   Result := inherited DoAfterPost(sender);
//End;
//Function TPOSKeyPads.getKeyPadCustomize  :TPOSKeyPadCustomize;
//begin
//    if not (Assigned(fKeyPadCustomize)) then begin
//        fKeyPadCustomize := TPOSKeyPadCustomize.create(Self);
//        if Assigned(Self.Connection) then KeyPadCustomize.connection := Self.connection;
//    end;
//    if (fKeyPadCustomize.SQLSelect <> 'KeyPadId = ' + IntToStr(ID)) or (fKeyPadCustomize.Dataset.Active = False) then begin
//        fKeyPadCustomize.LoadSelect('KeyPadId = ' + IntToStr(ID));
//    end;
//    Result :=fKeyPadCustomize;
//end;
//{Property functions}
//Function  TPOSKeyPads.GetDescription:String    ; begin Result := GetStringField('Description');End;
//Function  TPOSKeyPads.GetActive     :Boolean   ; begin Result := GetBooleanField('Active');End;
//Procedure TPOSKeyPads.SetDescription(Const Value :String    ); begin SetStringField('Description' , Value);End;
//Procedure TPOSKeyPads.SetActive     (Const Value :Boolean   ); begin SetBooleanField('Active'      , Value);End;

{========================================================
         TPOSFunctions
========================================================}
constructor TPOSFunctions.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   fSQL := 'SELECT * FROM tblPOSFunctions';
end;


destructor TPOSFunctions.Destroy;
begin
   inherited;
end;

procedure   TPOSFunctions.LoadFromXMLNode(Const node: IXMLNode);
begin
   inherited;
    SetPropertyFromNode(Node,'Functionname');
    SetPropertyFromNode(Node,'Description');
    SetPropertyFromNode(Node,'Hint');
    SetPropertyFromNode(Node,'Captionline1');
    SetPropertyFromNode(Node,'Captionline2');
    SetPropertyFromNode(Node,'Fontcolour');
    SetPropertyFromNode(Node,'Fontname');
    SetPropertyFromNode(Node,'Fontsize');
    SetBooleanPropertyFromNode(Node,'Fontbold');
    SetBooleanPropertyFromNode(Node,'Fontitalic');
    SetBooleanPropertyFromNode(Node,'Fontunderline');
    SetPropertyFromNode(Node,'Backgroundcolour');
    SetPropertyFromNode(Node,'Topmargin');
    SetBooleanPropertyFromNode(Node,'Active');
end;

procedure   TPOSFunctions.SaveToXMLNode(Const node: IXMLNode);
begin
   inherited;
      AddXMLNode(node,'Functionname' ,Functionname);
      AddXMLNode(node,'Description' ,Description);
      AddXMLNode(node,'Hint' ,Hint);
      AddXMLNode(node,'Captionline1' ,Captionline1);
      AddXMLNode(node,'Captionline2' ,Captionline2);
      AddXMLNode(node,'Fontcolour' ,Fontcolour);
      AddXMLNode(node,'RGBFontcolour' ,getRGB(Fontcolour));
      AddXMLNode(node,'Fontname' ,Fontname);
      AddXMLNode(node,'Fontsize' ,Fontsize);
      AddXMLNode(node,'Fontbold' ,Fontbold);
      AddXMLNode(node,'Fontitalic' ,Fontitalic);
      AddXMLNode(node,'Fontunderline' ,Fontunderline);
      AddXMLNode(node,'Backgroundcolour' ,Backgroundcolour);
      AddXMLNode(node,'RGBBackgroundcolour' ,getRGB(Backgroundcolour));
      AddXMLNode(node,'Topmargin' ,Topmargin);
      AddXMLNode(node,'Active' ,Active);
end;


function    TPOSFunctions.ValidateData :Boolean ;
begin
   Result := False;
   Resultstatus.Clear;
   if Functionname = '' then begin
      Resultstatus.AddItem(False , rssError , 0,  'Functionname should not be blank' , False );
      Exit;
   end;
   Result := true;
end;


function    TPOSFunctions.Save :Boolean ;
begin
   Result := False;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;


procedure TPOSFunctions.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;


procedure TPOSFunctions.DoFieldOnChange(Sender: TField);
begin
   inherited;
end;


Function TPOSFunctions.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;


class function  TPOSFunctions.GetIDField : String;
begin
   Result := 'Functionid'
end;

class function TPOSFunctions.GetBusObjectTablename: string;
begin
  Result := 'tblPOSFunctions';
end;

Function  TPOSFunctions.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;


{Property functions}
Function  TPOSFunctions.GetFunctionname    :String    ; begin Result := GetStringField('Functionname');End;
Function  TPOSFunctions.GetDescription     :String    ; begin Result := GetStringField('Description');End;
Function  TPOSFunctions.GetHint            :String    ; begin Result := GetStringField('Hint');End;
Function  TPOSFunctions.GetCaptionline1    :String    ; begin Result := GetStringField('Captionline1');End;
Function  TPOSFunctions.GetCaptionline2    :String    ; begin Result := GetStringField('Captionline2');End;
Function  TPOSFunctions.GetFontcolour      :Integer   ; begin Result := GetIntegerField('Fontcolour');End;
Function  TPOSFunctions.GetFontname        :String    ; begin Result := GetStringField('Fontname');End;
Function  TPOSFunctions.GetFontsize        :Integer   ; begin Result := GetIntegerField('Fontsize');End;
Function  TPOSFunctions.GetFontbold        :Boolean   ; begin Result := GetBooleanField('Fontbold');End;
Function  TPOSFunctions.GetFontitalic      :Boolean   ; begin Result := GetBooleanField('Fontitalic');End;
Function  TPOSFunctions.GetFontunderline   :Boolean   ; begin Result := GetBooleanField('Fontunderline');End;
Function  TPOSFunctions.GetBackgroundcolour:Integer   ; begin Result := GetIntegerField('Backgroundcolour');End;
Function  TPOSFunctions.GetTopmargin       :Integer   ; begin Result := GetIntegerField('Topmargin');End;
Function  TPOSFunctions.GetActive          :Boolean   ; begin Result := GetBooleanField('Active');End;
Procedure TPOSFunctions.SetFunctionname    (Const Value :String    ); begin SetStringField('Functionname'     , Value);End;
Procedure TPOSFunctions.SetDescription     (Const Value :String    ); begin SetStringField('Description'      , Value);End;
Procedure TPOSFunctions.SetHint            (Const Value :String    ); begin SetStringField('Hint'             , Value);End;
Procedure TPOSFunctions.SetCaptionline1    (Const Value :String    ); begin SetStringField('Captionline1'     , Value);End;
Procedure TPOSFunctions.SetCaptionline2    (Const Value :String    ); begin SetStringField('Captionline2'     , Value);End;
Procedure TPOSFunctions.SetFontcolour      (Const Value :Integer   ); begin SetIntegerField('Fontcolour'       , Value);End;
Procedure TPOSFunctions.SetFontname        (Const Value :String    ); begin SetStringField('Fontname'         , Value);End;
Procedure TPOSFunctions.SetFontsize        (Const Value :Integer   ); begin SetIntegerField('Fontsize'         , Value);End;
Procedure TPOSFunctions.SetFontbold        (Const Value :Boolean   ); begin SetBooleanField('Fontbold'         , Value);End;
Procedure TPOSFunctions.SetFontitalic      (Const Value :Boolean   ); begin SetBooleanField('Fontitalic'       , Value);End;
Procedure TPOSFunctions.SetFontunderline   (Const Value :Boolean   ); begin SetBooleanField('Fontunderline'    , Value);End;
Procedure TPOSFunctions.SetBackgroundcolour(Const Value :Integer   ); begin SetIntegerField('Backgroundcolour' , Value);End;
Procedure TPOSFunctions.SetTopmargin       (Const Value :Integer   ); begin SetIntegerField('Topmargin'        , Value);End;
Procedure TPOSFunctions.SetActive          (Const Value :Boolean   ); begin SetBooleanField('Active'           , Value);End;


//function TPOSKeyPadCustomize.DoAfterInsert(  Sender: TDatasetBusObj): Boolean;
//begin
//  result := inherited DoAfterInsert(  Sender);
//  if not result then exit;
//end;

initialization
RegisterClassOnce(TPOSFunctions);
//RegisterClassOnce(TPOSKeyPads);
//RegisterClassOnce(TPOSKeyPadCustomize);
//RegisterClassOnce(TFuncRooms);


end.
