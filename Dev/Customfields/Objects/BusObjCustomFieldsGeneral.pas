unit BusObjCustomFieldsGeneral;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  17/05/16  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TCustomFields = class(TMSBusObj)
  private
    function GetCF1                 : Boolean   ;
    function GetCF2                 : Boolean   ;
    function GetCF3                 : Boolean   ;
    function GetCF4                 : Boolean   ;
    function GetCF5                 : Boolean   ;
    function GetCF6                 : Boolean   ;
    function GetCF7                 : Boolean   ;
    function GetCF8                 : Boolean   ;
    function GetCF9                 : Boolean   ;
    function GetCF10                : Boolean   ;
    function GetCF11                : Boolean   ;
    function GetCF12                : Boolean   ;
    function GetCF13                : Boolean   ;
    function GetCF14                : Boolean   ;
    function GetCF15                : Boolean   ;
    function GetCF16                : Boolean   ;
    function GetCF17                : Boolean   ;
    function GetCF18                : Boolean   ;
    function GetCFIsCombo1          : Boolean   ;
    function GetCFIsCombo2          : Boolean   ;
    function GetCFIsCombo3          : Boolean   ;
    function GetCFIsCombo4          : Boolean   ;
    function GetCFIsCombo5          : Boolean   ;
    function GetCFIsCombo6          : Boolean   ;
    function GetCFIsCombo7          : Boolean   ;
    function GetCFIsCombo8          : Boolean   ;
    function GetCFIsCombo9          : Boolean   ;
    function GetCFIsCombo10         : Boolean   ;
    function GetCFIsCombo11         : Boolean   ;
    function GetCFIsCombo12         : Boolean   ;
    function GetCFIsCombo13         : Boolean   ;
    function GetCFIsCombo14         : Boolean   ;
    function GetCFIsCombo15         : Boolean   ;
    function GetCFIsRequired1       : Boolean   ;
    function GetCFIsRequired2       : Boolean   ;
    function GetCFIsRequired3       : Boolean   ;
    function GetCFIsRequired4       : Boolean   ;
    function GetCFIsRequired5       : Boolean   ;
    function GetCFIsRequired6       : Boolean   ;
    function GetCFIsRequired7       : Boolean   ;
    function GetCFIsRequired8       : Boolean   ;
    function GetCFIsRequired9       : Boolean   ;
    function GetCFIsRequired10      : Boolean   ;
    function GetCFIsRequired11      : Boolean   ;
    function GetCFIsRequired12      : Boolean   ;
    function GetCFIsRequired13      : Boolean   ;
    function GetCFIsRequired14      : Boolean   ;
    function GetCFIsRequired15      : Boolean   ;
    function GetCFIsRequired16      : Boolean   ;
    function GetCFIsRequired17      : Boolean   ;
    function GetCFIsRequired18      : Boolean   ;
    function GetCFLabel1            : string    ;
    function GetCFLabel2            : string    ;
    function GetCFLabel3            : string    ;
    function GetCFLabel4            : string    ;
    function GetCFLabel5            : string    ;
    function GetCFLabel6            : string    ;
    function GetCFLabel7            : string    ;
    function GetCFLabel8            : string    ;
    function GetCFLabel9            : string    ;
    function GetCFLabel10           : string    ;
    function GetCFLabel11           : string    ;
    function GetCFLabel12           : string    ;
    function GetCFLabel13           : string    ;
    function GetCFLabel14           : string    ;
    function GetCFLabel15           : string    ;
    function GetCFLabel16           : string    ;
    function GetCFLabel17           : string    ;
    function GetCFLabel18           : string    ;

    procedure SetCF1                 (const Value: Boolean   );
    procedure SetCF2                 (const Value: Boolean   );
    procedure SetCF3                 (const Value: Boolean   );
    procedure SetCF4                 (const Value: Boolean   );
    procedure SetCF5                 (const Value: Boolean   );
    procedure SetCF6                 (const Value: Boolean   );
    procedure SetCF7                 (const Value: Boolean   );
    procedure SetCF8                 (const Value: Boolean   );
    procedure SetCF9                 (const Value: Boolean   );
    procedure SetCF10                (const Value: Boolean   );
    procedure SetCF11                (const Value: Boolean   );
    procedure SetCF12                (const Value: Boolean   );
    procedure SetCF13                (const Value: Boolean   );
    procedure SetCF14                (const Value: Boolean   );
    procedure SetCF15                (const Value: Boolean   );
    procedure SetCF16                (const Value: Boolean   );
    procedure SetCF17                (const Value: Boolean   );
    procedure SetCF18                (const Value: Boolean   );
    procedure SetCFIsCombo1          (const Value: Boolean   );
    procedure SetCFIsCombo2          (const Value: Boolean   );
    procedure SetCFIsCombo3          (const Value: Boolean   );
    procedure SetCFIsCombo4          (const Value: Boolean   );
    procedure SetCFIsCombo5          (const Value: Boolean   );
    procedure SetCFIsCombo6          (const Value: Boolean   );
    procedure SetCFIsCombo7          (const Value: Boolean   );
    procedure SetCFIsCombo8          (const Value: Boolean   );
    procedure SetCFIsCombo9          (const Value: Boolean   );
    procedure SetCFIsCombo10         (const Value: Boolean   );
    procedure SetCFIsCombo11         (const Value: Boolean   );
    procedure SetCFIsCombo12         (const Value: Boolean   );
    procedure SetCFIsCombo13         (const Value: Boolean   );
    procedure SetCFIsCombo14         (const Value: Boolean   );
    procedure SetCFIsCombo15         (const Value: Boolean   );
    procedure SetCFIsRequired1       (const Value: Boolean   );
    procedure SetCFIsRequired2       (const Value: Boolean   );
    procedure SetCFIsRequired3       (const Value: Boolean   );
    procedure SetCFIsRequired4       (const Value: Boolean   );
    procedure SetCFIsRequired5       (const Value: Boolean   );
    procedure SetCFIsRequired6       (const Value: Boolean   );
    procedure SetCFIsRequired7       (const Value: Boolean   );
    procedure SetCFIsRequired8       (const Value: Boolean   );
    procedure SetCFIsRequired9       (const Value: Boolean   );
    procedure SetCFIsRequired10      (const Value: Boolean   );
    procedure SetCFIsRequired11      (const Value: Boolean   );
    procedure SetCFIsRequired12      (const Value: Boolean   );
    procedure SetCFIsRequired13      (const Value: Boolean   );
    procedure SetCFIsRequired14      (const Value: Boolean   );
    procedure SetCFIsRequired15      (const Value: Boolean   );
    procedure SetCFIsRequired16      (const Value: Boolean   );
    procedure SetCFIsRequired17      (const Value: Boolean   );
    procedure SetCFIsRequired18      (const Value: Boolean   );
    procedure SetCFLabel1            (const Value: string    );
    procedure SetCFLabel2            (const Value: string    );
    procedure SetCFLabel3            (const Value: string    );
    procedure SetCFLabel4            (const Value: string    );
    procedure SetCFLabel5            (const Value: string    );
    procedure SetCFLabel6            (const Value: string    );
    procedure SetCFLabel7            (const Value: string    );
    procedure SetCFLabel8            (const Value: string    );
    procedure SetCFLabel9            (const Value: string    );
    procedure SetCFLabel10           (const Value: string    );
    procedure SetCFLabel11           (const Value: string    );
    procedure SetCFLabel12           (const Value: string    );
    procedure SetCFLabel13           (const Value: string    );
    procedure SetCFLabel14           (const Value: string    );
    procedure SetCFLabel15           (const Value: string    );
    procedure SetCFLabel16           (const Value: string    );
    procedure SetCFLabel17           (const Value: string    );
    procedure SetCFLabel18           (const Value: string    );

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    Function CustomFieldtype:String;Virtual;Abstract;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Class function CustomFieldObj(AOwner:TComponent; const Value :String) : TCustomFields;
  published
    property CF1              :Boolean     read GetCF1                write SetCF1         ;
    property CF2              :Boolean     read GetCF2                write SetCF2         ;
    property CF3              :Boolean     read GetCF3                write SetCF3         ;
    property CF4              :Boolean     read GetCF4                write SetCF4         ;
    property CF5              :Boolean     read GetCF5                write SetCF5         ;
    property CF6              :Boolean     read GetCF6                write SetCF6         ;
    property CF7              :Boolean     read GetCF7                write SetCF7         ;
    property CF8              :Boolean     read GetCF8                write SetCF8         ;
    property CF9              :Boolean     read GetCF9                write SetCF9         ;
    property CF10             :Boolean     read GetCF10               write SetCF10        ;
    property CF11             :Boolean     read GetCF11               write SetCF11        ;
    property CF12             :Boolean     read GetCF12               write SetCF12        ;
    property CF13             :Boolean     read GetCF13               write SetCF13        ;
    property CF14             :Boolean     read GetCF14               write SetCF14        ;
    property CF15             :Boolean     read GetCF15               write SetCF15        ;
    property CF16             :Boolean     read GetCF16               write SetCF16        ;
    property CF17             :Boolean     read GetCF17               write SetCF17        ;
    property CF18             :Boolean     read GetCF18               write SetCF18        ;
    property CFIsCombo1           :Boolean     read GetCFIsCombo1         write SetCFIsCombo1      ;
    property CFIsCombo2           :Boolean     read GetCFIsCombo2         write SetCFIsCombo2      ;
    property CFIsCombo3           :Boolean     read GetCFIsCombo3         write SetCFIsCombo3      ;
    property CFIsCombo4           :Boolean     read GetCFIsCombo4         write SetCFIsCombo4      ;
    property CFIsCombo5           :Boolean     read GetCFIsCombo5         write SetCFIsCombo5      ;
    property CFIsCombo6           :Boolean     read GetCFIsCombo6         write SetCFIsCombo6      ;
    property CFIsCombo7           :Boolean     read GetCFIsCombo7         write SetCFIsCombo7      ;
    property CFIsCombo8           :Boolean     read GetCFIsCombo8         write SetCFIsCombo8      ;
    property CFIsCombo9           :Boolean     read GetCFIsCombo9         write SetCFIsCombo9      ;
    property CFIsCombo10          :Boolean     read GetCFIsCombo10        write SetCFIsCombo10     ;
    property CFIsCombo11          :Boolean     read GetCFIsCombo11        write SetCFIsCombo11     ;
    property CFIsCombo12          :Boolean     read GetCFIsCombo12        write SetCFIsCombo12     ;
    property CFIsCombo13          :Boolean     read GetCFIsCombo13        write SetCFIsCombo13     ;
    property CFIsCombo14          :Boolean     read GetCFIsCombo14        write SetCFIsCombo14     ;
    property CFIsCombo15          :Boolean     read GetCFIsCombo15        write SetCFIsCombo15     ;
    property CFIsRequired1        :Boolean     read GetCFIsRequired1      write SetCFIsRequired1   ;
    property CFIsRequired2        :Boolean     read GetCFIsRequired2      write SetCFIsRequired2   ;
    property CFIsRequired3        :Boolean     read GetCFIsRequired3      write SetCFIsRequired3   ;
    property CFIsRequired4        :Boolean     read GetCFIsRequired4      write SetCFIsRequired4   ;
    property CFIsRequired5        :Boolean     read GetCFIsRequired5      write SetCFIsRequired5   ;
    property CFIsRequired6        :Boolean     read GetCFIsRequired6      write SetCFIsRequired6   ;
    property CFIsRequired7        :Boolean     read GetCFIsRequired7      write SetCFIsRequired7   ;
    property CFIsRequired8        :Boolean     read GetCFIsRequired8      write SetCFIsRequired8   ;
    property CFIsRequired9        :Boolean     read GetCFIsRequired9      write SetCFIsRequired9   ;
    property CFIsRequired10       :Boolean     read GetCFIsRequired10     write SetCFIsRequired10  ;
    property CFIsRequired11       :Boolean     read GetCFIsRequired11     write SetCFIsRequired11  ;
    property CFIsRequired12       :Boolean     read GetCFIsRequired12     write SetCFIsRequired12  ;
    property CFIsRequired13       :Boolean     read GetCFIsRequired13     write SetCFIsRequired13  ;
    property CFIsRequired14       :Boolean     read GetCFIsRequired14     write SetCFIsRequired14  ;
    property CFIsRequired15       :Boolean     read GetCFIsRequired15     write SetCFIsRequired15  ;
    property CFIsRequired16       :Boolean     read GetCFIsRequired16     write SetCFIsRequired16  ;
    property CFIsRequired17       :Boolean     read GetCFIsRequired17     write SetCFIsRequired17  ;
    property CFIsRequired18       :Boolean     read GetCFIsRequired18     write SetCFIsRequired18  ;
    property CFLabel1             :string      read GetCFLabel1           write SetCFLabel1        ;
    property CFLabel2             :string      read GetCFLabel2           write SetCFLabel2        ;
    property CFLabel3             :string      read GetCFLabel3           write SetCFLabel3        ;
    property CFLabel4             :string      read GetCFLabel4           write SetCFLabel4        ;
    property CFLabel5             :string      read GetCFLabel5           write SetCFLabel5        ;
    property CFLabel6             :string      read GetCFLabel6           write SetCFLabel6        ;
    property CFLabel7             :string      read GetCFLabel7           write SetCFLabel7        ;
    property CFLabel8             :string      read GetCFLabel8           write SetCFLabel8        ;
    property CFLabel9             :string      read GetCFLabel9           write SetCFLabel9        ;
    property CFLabel10            :string      read GetCFLabel10          write SetCFLabel10       ;
    property CFLabel11            :string      read GetCFLabel11          write SetCFLabel11       ;
    property CFLabel12            :string      read GetCFLabel12          write SetCFLabel12       ;
    property CFLabel13            :string      read GetCFLabel13          write SetCFLabel13       ;
    property CFLabel14            :string      read GetCFLabel14          write SetCFLabel14       ;
    property CFLabel15            :string      read GetCFLabel15          write SetCFLabel15       ;
    property CFLabel16            :string      read GetCFLabel16          write SetCFLabel16       ;
    property CFLabel17            :string      read GetCFLabel17          write SetCFLabel17       ;
    property CFLabel18            :string      read GetCFLabel18          write SetCFLabel18       ;
  end;
  TCustomFieldsCust = Class(TCustomFields)
    Protected
      Function CustomFieldtype:String;Override;
  End;
  TCustomFieldsEmp = Class(TCustomFields)
    Protected
      Function CustomFieldtype:String;Override;
  End;
  TCustomFieldsSupp = Class(TCustomFields)
    Protected
      Function CustomFieldtype:String;Override;
  End;
  TCustomFieldsOthr = Class(TCustomFields)
    Protected
      Function CustomFieldtype:String;Override;
  End;
  TCustomFieldsAssets = Class(TCustomFields)
    Protected
      Function CustomFieldtype:String;Override;
  End;
  TCustomFieldsAppointment = Class(TCustomFields)
    Protected
      Function CustomFieldtype:String;Override;
  End;
  TCustomFieldsRepairs = Class(TCustomFields)
    Protected
      Function CustomFieldtype:String;Override;
  End;
  TCustomFieldsProduct = Class(TCustomFields)
    Protected
      Function CustomFieldtype:String;Override;
  End;
  TCustomFieldsMC = Class(TCustomFields)
    Protected
      Function CustomFieldtype:String;Override;
  End;

implementation


uses tcDataUtils, CommonLib, CommonDbLib , SysUtils;



  {TCustomFields}

constructor TCustomFields.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'CustomFields';
  fSQL := 'SELECT * FROM tblcustomfields';
end;


class function TCustomFields.CustomFieldObj(AOwner:TComponent; const Value: String): TCustomFields;
begin
  REsult := nil;
       if Sametext(Value , 'Cust'       ) then REsult := TCustomFieldsCust.CreateWithNewConn(AOwner)
  else if Sametext(Value , 'Emp'        ) then REsult := TCustomFieldsEmp.CreateWithNewConn(AOwner)
  else if Sametext(Value , 'Supp'       ) then REsult := TCustomFieldsSupp.CreateWithNewConn(AOwner)
  else if Sametext(Value , 'Othr'       ) then REsult := TCustomFieldsOthr.CreateWithNewConn(AOwner)
  else if Sametext(Value , 'Assets'     ) then REsult := TCustomFieldsAssets.CreateWithNewConn(AOwner)
  else if Sametext(Value , 'Appointment') then REsult := TCustomFieldsAppointment.CreateWithNewConn(AOwner)
  else if Sametext(Value , 'Repairs'    ) then REsult := TCustomFieldsRepairs.CreateWithNewConn(AOwner)
  else if Sametext(Value , 'Product'    ) then REsult := TCustomFieldsProduct.CreateWithNewConn(AOwner)
  else if Sametext(Value , 'MC'         ) then REsult := TCustomFieldsMC.CreateWithNewConn(AOwner)
  else exit;
  Result.Load;
end;

destructor TCustomFields.Destroy;
begin
  inherited;
end;


procedure TCustomFields.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetBooleanPropertyFromNode(node,'CF' + CustomFieldtype +'1');
  SetBooleanPropertyFromNode(node,'CF' + CustomFieldtype +'2');
  SetBooleanPropertyFromNode(node,'CF' + CustomFieldtype +'3');
  SetBooleanPropertyFromNode(node,'CF' + CustomFieldtype +'4');
  SetBooleanPropertyFromNode(node,'CF' + CustomFieldtype +'5');
  SetBooleanPropertyFromNode(node,'CF' + CustomFieldtype +'6');
  SetBooleanPropertyFromNode(node,'CF' + CustomFieldtype +'7');
  SetBooleanPropertyFromNode(node,'CF' + CustomFieldtype +'8');
  SetBooleanPropertyFromNode(node,'CF' + CustomFieldtype +'9');
  SetBooleanPropertyFromNode(node,'CF' + CustomFieldtype +'10');
  SetBooleanPropertyFromNode(node,'CF' + CustomFieldtype +'11');
  SetBooleanPropertyFromNode(node,'CF' + CustomFieldtype +'12');
  SetBooleanPropertyFromNode(node,'CF' + CustomFieldtype +'13');
  SetBooleanPropertyFromNode(node,'CF' + CustomFieldtype +'14');
  SetBooleanPropertyFromNode(node,'CF' + CustomFieldtype +'15');
  SetBooleanPropertyFromNode(node,'CF' + CustomFieldtype +'16');
  SetBooleanPropertyFromNode(node,'CF' + CustomFieldtype +'17');
  SetBooleanPropertyFromNode(node,'CF' + CustomFieldtype +'18');
  SetBooleanPropertyFromNode(node,'CFIsCombo1');
  SetBooleanPropertyFromNode(node,'CFIsCombo2');
  SetBooleanPropertyFromNode(node,'CFIsCombo3');
  SetBooleanPropertyFromNode(node,'CFIsCombo4');
  SetBooleanPropertyFromNode(node,'CFIsCombo5');
  SetBooleanPropertyFromNode(node,'CFIsCombo6');
  SetBooleanPropertyFromNode(node,'CFIsCombo7');
  SetBooleanPropertyFromNode(node,'CFIsCombo8');
  SetBooleanPropertyFromNode(node,'CFIsCombo9');
  SetBooleanPropertyFromNode(node,'CFIsCombo10');
  SetBooleanPropertyFromNode(node,'CFIsCombo11');
  SetBooleanPropertyFromNode(node,'CFIsCombo12');
  SetBooleanPropertyFromNode(node,'CFIsCombo13');
  SetBooleanPropertyFromNode(node,'CFIsCombo14');
  SetBooleanPropertyFromNode(node,'CFIsCombo15');
  SetBooleanPropertyFromNode(node,'CFIsRequired1');
  SetBooleanPropertyFromNode(node,'CFIsRequired2');
  SetBooleanPropertyFromNode(node,'CFIsRequired3');
  SetBooleanPropertyFromNode(node,'CFIsRequired4');
  SetBooleanPropertyFromNode(node,'CFIsRequired5');
  SetBooleanPropertyFromNode(node,'CFIsRequired6');
  SetBooleanPropertyFromNode(node,'CFIsRequired7');
  SetBooleanPropertyFromNode(node,'CFIsRequired8');
  SetBooleanPropertyFromNode(node,'CFIsRequired9');
  SetBooleanPropertyFromNode(node,'CFIsRequired10');
  SetBooleanPropertyFromNode(node,'CFIsRequired11');
  SetBooleanPropertyFromNode(node,'CFIsRequired12');
  SetBooleanPropertyFromNode(node,'CFIsRequired13');
  SetBooleanPropertyFromNode(node,'CFIsRequired14');
  SetBooleanPropertyFromNode(node,'CFIsRequired15');
  SetBooleanPropertyFromNode(node,'CFIsRequired16');
  SetBooleanPropertyFromNode(node,'CFIsRequired17');
  SetBooleanPropertyFromNode(node,'CFIsRequired18');
  SetPropertyFromNode(node,'CFLabel1');
  SetPropertyFromNode(node,'CFLabel2');
  SetPropertyFromNode(node,'CFLabel3');
  SetPropertyFromNode(node,'CFLabel4');
  SetPropertyFromNode(node,'CFLabel5');
  SetPropertyFromNode(node,'CFLabel6');
  SetPropertyFromNode(node,'CFLabel7');
  SetPropertyFromNode(node,'CFLabel8');
  SetPropertyFromNode(node,'CFLabel9');
  SetPropertyFromNode(node,'CFLabel10');
  SetPropertyFromNode(node,'CFLabel11');
  SetPropertyFromNode(node,'CFLabel12');
  SetPropertyFromNode(node,'CFLabel13');
  SetPropertyFromNode(node,'CFLabel14');
  SetPropertyFromNode(node,'CFLabel15');
  SetPropertyFromNode(node,'CFLabel16');
  SetPropertyFromNode(node,'CFLabel17');
  SetPropertyFromNode(node,'CFLabel18');

end;


procedure TCustomFields.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'CF' + CustomFieldtype +'1' ,CF1);
  AddXMLNode(node,'CF' + CustomFieldtype +'2' ,CF2);
  AddXMLNode(node,'CF' + CustomFieldtype +'3' ,CF3);
  AddXMLNode(node,'CF' + CustomFieldtype +'4' ,CF4);
  AddXMLNode(node,'CF' + CustomFieldtype +'5' ,CF5);
  AddXMLNode(node,'CF' + CustomFieldtype +'6' ,CF6);
  AddXMLNode(node,'CF' + CustomFieldtype +'7' ,CF7);
  AddXMLNode(node,'CF' + CustomFieldtype +'8' ,CF8);
  AddXMLNode(node,'CF' + CustomFieldtype +'9' ,CF9);
  AddXMLNode(node,'CF' + CustomFieldtype +'10' ,CF10);
  AddXMLNode(node,'CF' + CustomFieldtype +'11' ,CF11);
  AddXMLNode(node,'CF' + CustomFieldtype +'12' ,CF12);
  AddXMLNode(node,'CF' + CustomFieldtype +'13' ,CF13);
  AddXMLNode(node,'CF' + CustomFieldtype +'14' ,CF14);
  AddXMLNode(node,'CF' + CustomFieldtype +'15' ,CF15);
  AddXMLNode(node,'CF' + CustomFieldtype +'16' ,CF16);
  AddXMLNode(node,'CF' + CustomFieldtype +'17' ,CF17);
  AddXMLNode(node,'CF' + CustomFieldtype +'18' ,CF18);
  AddXMLNode(node,'CFIsCombo1' ,CFIsCombo1);
  AddXMLNode(node,'CFIsCombo2' ,CFIsCombo2);
  AddXMLNode(node,'CFIsCombo3' ,CFIsCombo3);
  AddXMLNode(node,'CFIsCombo4' ,CFIsCombo4);
  AddXMLNode(node,'CFIsCombo5' ,CFIsCombo5);
  AddXMLNode(node,'CFIsCombo6' ,CFIsCombo6);
  AddXMLNode(node,'CFIsCombo7' ,CFIsCombo7);
  AddXMLNode(node,'CFIsCombo8' ,CFIsCombo8);
  AddXMLNode(node,'CFIsCombo9' ,CFIsCombo9);
  AddXMLNode(node,'CFIsCombo10' ,CFIsCombo10);
  AddXMLNode(node,'CFIsCombo11' ,CFIsCombo11);
  AddXMLNode(node,'CFIsCombo12' ,CFIsCombo12);
  AddXMLNode(node,'CFIsCombo13' ,CFIsCombo13);
  AddXMLNode(node,'CFIsCombo14' ,CFIsCombo14);
  AddXMLNode(node,'CFIsCombo15' ,CFIsCombo15);
  AddXMLNode(node,'CFIsRequired1' ,CFIsRequired1);
  AddXMLNode(node,'CFIsRequired2' ,CFIsRequired2);
  AddXMLNode(node,'CFIsRequired3' ,CFIsRequired3);
  AddXMLNode(node,'CFIsRequired4' ,CFIsRequired4);
  AddXMLNode(node,'CFIsRequired5' ,CFIsRequired5);
  AddXMLNode(node,'CFIsRequired6' ,CFIsRequired6);
  AddXMLNode(node,'CFIsRequired7' ,CFIsRequired7);
  AddXMLNode(node,'CFIsRequired8' ,CFIsRequired8);
  AddXMLNode(node,'CFIsRequired9' ,CFIsRequired9);
  AddXMLNode(node,'CFIsRequired10' ,CFIsRequired10);
  AddXMLNode(node,'CFIsRequired11' ,CFIsRequired11);
  AddXMLNode(node,'CFIsRequired12' ,CFIsRequired12);
  AddXMLNode(node,'CFIsRequired13' ,CFIsRequired13);
  AddXMLNode(node,'CFIsRequired14' ,CFIsRequired14);
  AddXMLNode(node,'CFIsRequired15' ,CFIsRequired15);
  AddXMLNode(node,'CFIsRequired16' ,CFIsRequired16);
  AddXMLNode(node,'CFIsRequired17' ,CFIsRequired17);
  AddXMLNode(node,'CFIsRequired18' ,CFIsRequired18);
  AddXMLNode(node,'CFLabel1' ,CFLabel1);
  AddXMLNode(node,'CFLabel2' ,CFLabel2);
  AddXMLNode(node,'CFLabel3' ,CFLabel3);
  AddXMLNode(node,'CFLabel4' ,CFLabel4);
  AddXMLNode(node,'CFLabel5' ,CFLabel5);
  AddXMLNode(node,'CFLabel6' ,CFLabel6);
  AddXMLNode(node,'CFLabel7' ,CFLabel7);
  AddXMLNode(node,'CFLabel8' ,CFLabel8);
  AddXMLNode(node,'CFLabel9' ,CFLabel9);
  AddXMLNode(node,'CFLabel10' ,CFLabel10);
  AddXMLNode(node,'CFLabel11' ,CFLabel11);
  AddXMLNode(node,'CFLabel12' ,CFLabel12);
  AddXMLNode(node,'CFLabel13' ,CFLabel13);
  AddXMLNode(node,'CFLabel14' ,CFLabel14);
  AddXMLNode(node,'CFLabel15' ,CFLabel15);
  AddXMLNode(node,'CFLabel16' ,CFLabel16);
  AddXMLNode(node,'CFLabel17' ,CFLabel17);
  AddXMLNode(node,'CFLabel18' ,CFLabel18);

end;


function TCustomFields.ValidateData: Boolean ;
begin
//  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TCustomFields.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TCustomFields.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TCustomFields.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TCustomFields.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TCustomFields.GetIDField: string;
begin
  Result := 'ID'
end;


class function TCustomFields.GetBusObjectTablename: string;
begin
  Result:= 'tblcustomfields';
end;


function TCustomFields.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TCustomFields.GetCF1             : Boolean   ; begin Result := GetBooleanField('CF' + CustomFieldtype +'1');end;
function  TCustomFields.GetCF2             : Boolean   ; begin Result := GetBooleanField('CF' + CustomFieldtype +'2');end;
function  TCustomFields.GetCF3             : Boolean   ; begin Result := GetBooleanField('CF' + CustomFieldtype +'3');end;
function  TCustomFields.GetCF4             : Boolean   ; begin Result := GetBooleanField('CF' + CustomFieldtype +'4');end;
function  TCustomFields.GetCF5             : Boolean   ; begin Result := GetBooleanField('CF' + CustomFieldtype +'5');end;
function  TCustomFields.GetCF6             : Boolean   ; begin Result := GetBooleanField('CF' + CustomFieldtype +'6');end;
function  TCustomFields.GetCF7             : Boolean   ; begin Result := GetBooleanField('CF' + CustomFieldtype +'7');end;
function  TCustomFields.GetCF8             : Boolean   ; begin Result := GetBooleanField('CF' + CustomFieldtype +'8');end;
function  TCustomFields.GetCF9             : Boolean   ; begin Result := GetBooleanField('CF' + CustomFieldtype +'9');end;
function  TCustomFields.GetCF10            : Boolean   ; begin Result := GetBooleanField('CF' + CustomFieldtype +'10');end;
function  TCustomFields.GetCF11            : Boolean   ; begin Result := GetBooleanField('CF' + CustomFieldtype +'11');end;
function  TCustomFields.GetCF12            : Boolean   ; begin Result := GetBooleanField('CF' + CustomFieldtype +'12');end;
function  TCustomFields.GetCF13            : Boolean   ; begin Result := GetBooleanField('CF' + CustomFieldtype +'13');end;
function  TCustomFields.GetCF14            : Boolean   ; begin Result := GetBooleanField('CF' + CustomFieldtype +'14');end;
function  TCustomFields.GetCF15            : Boolean   ; begin Result := GetBooleanField('CF' + CustomFieldtype +'15');end;
function  TCustomFields.GetCF16            : Boolean   ; begin Result := GetBooleanField('CF' + CustomFieldtype +'16');end;
function  TCustomFields.GetCF17            : Boolean   ; begin Result := GetBooleanField('CF' + CustomFieldtype +'17');end;
function  TCustomFields.GetCF18            : Boolean   ; begin Result := GetBooleanField('CF' + CustomFieldtype +'18');end;
function  TCustomFields.GetCFIsCombo1      : Boolean   ; begin Result := GetBooleanField('CFIsCombo1');end;
function  TCustomFields.GetCFIsCombo2      : Boolean   ; begin Result := GetBooleanField('CFIsCombo2');end;
function  TCustomFields.GetCFIsCombo3      : Boolean   ; begin Result := GetBooleanField('CFIsCombo3');end;
function  TCustomFields.GetCFIsCombo4      : Boolean   ; begin Result := GetBooleanField('CFIsCombo4');end;
function  TCustomFields.GetCFIsCombo5      : Boolean   ; begin Result := GetBooleanField('CFIsCombo5');end;
function  TCustomFields.GetCFIsCombo6      : Boolean   ; begin Result := GetBooleanField('CFIsCombo6');end;
function  TCustomFields.GetCFIsCombo7      : Boolean   ; begin Result := GetBooleanField('CFIsCombo7');end;
function  TCustomFields.GetCFIsCombo8      : Boolean   ; begin Result := GetBooleanField('CFIsCombo8');end;
function  TCustomFields.GetCFIsCombo9      : Boolean   ; begin Result := GetBooleanField('CFIsCombo9');end;
function  TCustomFields.GetCFIsCombo10     : Boolean   ; begin Result := GetBooleanField('CFIsCombo10');end;
function  TCustomFields.GetCFIsCombo11     : Boolean   ; begin Result := GetBooleanField('CFIsCombo11');end;
function  TCustomFields.GetCFIsCombo12     : Boolean   ; begin Result := GetBooleanField('CFIsCombo12');end;
function  TCustomFields.GetCFIsCombo13     : Boolean   ; begin Result := GetBooleanField('CFIsCombo13');end;
function  TCustomFields.GetCFIsCombo14     : Boolean   ; begin Result := GetBooleanField('CFIsCombo14');end;
function  TCustomFields.GetCFIsCombo15     : Boolean   ; begin Result := GetBooleanField('CFIsCombo15');end;
function  TCustomFields.GetCFIsRequired1   : Boolean   ; begin Result := GetBooleanField('CFIsRequired1');end;
function  TCustomFields.GetCFIsRequired2   : Boolean   ; begin Result := GetBooleanField('CFIsRequired2');end;
function  TCustomFields.GetCFIsRequired3   : Boolean   ; begin Result := GetBooleanField('CFIsRequired3');end;
function  TCustomFields.GetCFIsRequired4   : Boolean   ; begin Result := GetBooleanField('CFIsRequired4');end;
function  TCustomFields.GetCFIsRequired5   : Boolean   ; begin Result := GetBooleanField('CFIsRequired5');end;
function  TCustomFields.GetCFIsRequired6   : Boolean   ; begin Result := GetBooleanField('CFIsRequired6');end;
function  TCustomFields.GetCFIsRequired7   : Boolean   ; begin Result := GetBooleanField('CFIsRequired7');end;
function  TCustomFields.GetCFIsRequired8   : Boolean   ; begin Result := GetBooleanField('CFIsRequired8');end;
function  TCustomFields.GetCFIsRequired10  : Boolean   ; begin Result := GetBooleanField('CFIsRequired10');end;
function  TCustomFields.GetCFIsRequired11  : Boolean   ; begin Result := GetBooleanField('CFIsRequired11');end;
function  TCustomFields.GetCFIsRequired12  : Boolean   ; begin Result := GetBooleanField('CFIsRequired12');end;
function  TCustomFields.GetCFIsRequired13  : Boolean   ; begin Result := GetBooleanField('CFIsRequired13');end;
function  TCustomFields.GetCFIsRequired14  : Boolean   ; begin Result := GetBooleanField('CFIsRequired14');end;
function  TCustomFields.GetCFIsRequired15  : Boolean   ; begin Result := GetBooleanField('CFIsRequired15');end;
function  TCustomFields.GetCFIsRequired16  : Boolean   ; begin Result := GetBooleanField('CFIsRequired16');end;
function  TCustomFields.GetCFIsRequired17  : Boolean   ; begin Result := GetBooleanField('CFIsRequired17');end;
function  TCustomFields.GetCFIsRequired18  : Boolean   ; begin Result := GetBooleanField('CFIsRequired18');end;
function  TCustomFields.GetCFIsRequired9   : Boolean   ; begin Result := GetBooleanField('CFIsRequired9');end;
function  TCustomFields.GetCFLabel1        : string    ; begin Result := GetStringField('CFLabel1');end;
function  TCustomFields.GetCFLabel2        : string    ; begin Result := GetStringField('CFLabel2');end;
function  TCustomFields.GetCFLabel3        : string    ; begin Result := GetStringField('CFLabel3');end;
function  TCustomFields.GetCFLabel4        : string    ; begin Result := GetStringField('CFLabel4');end;
function  TCustomFields.GetCFLabel5        : string    ; begin Result := GetStringField('CFLabel5');end;
function  TCustomFields.GetCFLabel6        : string    ; begin Result := GetStringField('CFLabel6');end;
function  TCustomFields.GetCFLabel7        : string    ; begin Result := GetStringField('CFLabel7');end;
function  TCustomFields.GetCFLabel8        : string    ; begin Result := GetStringField('CFLabel8');end;
function  TCustomFields.GetCFLabel9        : string    ; begin Result := GetStringField('CFLabel9');end;
function  TCustomFields.GetCFLabel10       : string    ; begin Result := GetStringField('CFLabel10');end;
function  TCustomFields.GetCFLabel11       : string    ; begin Result := GetStringField('CFLabel11');end;
function  TCustomFields.GetCFLabel12       : string    ; begin Result := GetStringField('CFLabel12');end;
function  TCustomFields.GetCFLabel13       : string    ; begin Result := GetStringField('CFLabel13');end;
function  TCustomFields.GetCFLabel14       : string    ; begin Result := GetStringField('CFLabel14');end;
function  TCustomFields.GetCFLabel15       : string    ; begin Result := GetStringField('CFLabel15');end;
function  TCustomFields.GetCFLabel16       : string    ; begin Result := GetStringField('CFLabel16');end;
function  TCustomFields.GetCFLabel17       : string    ; begin Result := GetStringField('CFLabel17');end;
function  TCustomFields.GetCFLabel18       : string    ; begin Result := GetStringField('CFLabel18');end;


procedure TCustomFields.SetCF1             (const Value: Boolean   ); begin SetBooleanField('CF' + CustomFieldtype +'1' , Value);end;
procedure TCustomFields.SetCF2             (const Value: Boolean   ); begin SetBooleanField('CF' + CustomFieldtype +'2' , Value);end;
procedure TCustomFields.SetCF3             (const Value: Boolean   ); begin SetBooleanField('CF' + CustomFieldtype +'3' , Value);end;
procedure TCustomFields.SetCF4             (const Value: Boolean   ); begin SetBooleanField('CF' + CustomFieldtype +'4' , Value);end;
procedure TCustomFields.SetCF5             (const Value: Boolean   ); begin SetBooleanField('CF' + CustomFieldtype +'5' , Value);end;
procedure TCustomFields.SetCF6             (const Value: Boolean   ); begin SetBooleanField('CF' + CustomFieldtype +'6' , Value);end;
procedure TCustomFields.SetCF7             (const Value: Boolean   ); begin SetBooleanField('CF' + CustomFieldtype +'7' , Value);end;
procedure TCustomFields.SetCF8             (const Value: Boolean   ); begin SetBooleanField('CF' + CustomFieldtype +'8' , Value);end;
procedure TCustomFields.SetCF9             (const Value: Boolean   ); begin SetBooleanField('CF' + CustomFieldtype +'9' , Value);end;
procedure TCustomFields.SetCF10            (const Value: Boolean   ); begin SetBooleanField('CF' + CustomFieldtype +'10', Value);end;
procedure TCustomFields.SetCF11            (const Value: Boolean   ); begin SetBooleanField('CF' + CustomFieldtype +'11', Value);end;
procedure TCustomFields.SetCF12            (const Value: Boolean   ); begin SetBooleanField('CF' + CustomFieldtype +'12', Value);end;
procedure TCustomFields.SetCF13            (const Value: Boolean   ); begin SetBooleanField('CF' + CustomFieldtype +'13', Value);end;
procedure TCustomFields.SetCF14            (const Value: Boolean   ); begin SetBooleanField('CF' + CustomFieldtype +'14', Value);end;
procedure TCustomFields.SetCF15            (const Value: Boolean   ); begin SetBooleanField('CF' + CustomFieldtype +'15', Value);end;
procedure TCustomFields.SetCF16            (const Value: Boolean   ); begin SetBooleanField('CF' + CustomFieldtype +'16', Value);end;
procedure TCustomFields.SetCF17            (const Value: Boolean   ); begin SetBooleanField('CF' + CustomFieldtype +'17', Value);end;
procedure TCustomFields.SetCF18            (const Value: Boolean   ); begin SetBooleanField('CF' + CustomFieldtype +'18', Value);end;
procedure TCustomFields.SetCFIsCombo1      (const Value: Boolean   ); begin SetBooleanField('CFIsCombo1' , Value);end;
procedure TCustomFields.SetCFIsCombo2      (const Value: Boolean   ); begin SetBooleanField('CFIsCombo2' , Value);end;
procedure TCustomFields.SetCFIsCombo3      (const Value: Boolean   ); begin SetBooleanField('CFIsCombo3' , Value);end;
procedure TCustomFields.SetCFIsCombo4      (const Value: Boolean   ); begin SetBooleanField('CFIsCombo4' , Value);end;
procedure TCustomFields.SetCFIsCombo5      (const Value: Boolean   ); begin SetBooleanField('CFIsCombo5' , Value);end;
procedure TCustomFields.SetCFIsCombo6      (const Value: Boolean   ); begin SetBooleanField('CFIsCombo6' , Value);end;
procedure TCustomFields.SetCFIsCombo7      (const Value: Boolean   ); begin SetBooleanField('CFIsCombo7' , Value);end;
procedure TCustomFields.SetCFIsCombo8      (const Value: Boolean   ); begin SetBooleanField('CFIsCombo8' , Value);end;
procedure TCustomFields.SetCFIsCombo9      (const Value: Boolean   ); begin SetBooleanField('CFIsCombo9' , Value);end;
procedure TCustomFields.SetCFIsCombo10     (const Value: Boolean   ); begin SetBooleanField('CFIsCombo10', Value);end;
procedure TCustomFields.SetCFIsCombo11     (const Value: Boolean   ); begin SetBooleanField('CFIsCombo11', Value);end;
procedure TCustomFields.SetCFIsCombo12     (const Value: Boolean   ); begin SetBooleanField('CFIsCombo12', Value);end;
procedure TCustomFields.SetCFIsCombo13     (const Value: Boolean   ); begin SetBooleanField('CFIsCombo13', Value);end;
procedure TCustomFields.SetCFIsCombo14     (const Value: Boolean   ); begin SetBooleanField('CFIsCombo14', Value);end;
procedure TCustomFields.SetCFIsCombo15     (const Value: Boolean   ); begin SetBooleanField('CFIsCombo15', Value);end;
procedure TCustomFields.SetCFIsRequired1   (const Value: Boolean   ); begin SetBooleanField('CFIsRequired1'    , Value);end;
procedure TCustomFields.SetCFIsRequired2   (const Value: Boolean   ); begin SetBooleanField('CFIsRequired2'    , Value);end;
procedure TCustomFields.SetCFIsRequired3   (const Value: Boolean   ); begin SetBooleanField('CFIsRequired3'    , Value);end;
procedure TCustomFields.SetCFIsRequired4   (const Value: Boolean   ); begin SetBooleanField('CFIsRequired4'    , Value);end;
procedure TCustomFields.SetCFIsRequired5   (const Value: Boolean   ); begin SetBooleanField('CFIsRequired5'    , Value);end;
procedure TCustomFields.SetCFIsRequired6   (const Value: Boolean   ); begin SetBooleanField('CFIsRequired6'    , Value);end;
procedure TCustomFields.SetCFIsRequired7   (const Value: Boolean   ); begin SetBooleanField('CFIsRequired7'    , Value);end;
procedure TCustomFields.SetCFIsRequired8   (const Value: Boolean   ); begin SetBooleanField('CFIsRequired8'    , Value);end;
procedure TCustomFields.SetCFIsRequired9   (const Value: Boolean   ); begin SetBooleanField('CFIsRequired9'    , Value);end;
procedure TCustomFields.SetCFIsRequired10  (const Value: Boolean   ); begin SetBooleanField('CFIsRequired10'   , Value);end;
procedure TCustomFields.SetCFIsRequired11  (const Value: Boolean   ); begin SetBooleanField('CFIsRequired11'   , Value);end;
procedure TCustomFields.SetCFIsRequired12  (const Value: Boolean   ); begin SetBooleanField('CFIsRequired12'   , Value);end;
procedure TCustomFields.SetCFIsRequired13  (const Value: Boolean   ); begin SetBooleanField('CFIsRequired13'   , Value);end;
procedure TCustomFields.SetCFIsRequired14  (const Value: Boolean   ); begin SetBooleanField('CFIsRequired14'   , Value);end;
procedure TCustomFields.SetCFIsRequired15  (const Value: Boolean   ); begin SetBooleanField('CFIsRequired15'   , Value);end;
procedure TCustomFields.SetCFIsRequired16  (const Value: Boolean   ); begin SetBooleanField('CFIsRequired16'   , Value);end;
procedure TCustomFields.SetCFIsRequired17  (const Value: Boolean   ); begin SetBooleanField('CFIsRequired17'   , Value);end;
procedure TCustomFields.SetCFIsRequired18  (const Value: Boolean   ); begin SetBooleanField('CFIsRequired18'   , Value);end;
procedure TCustomFields.SetCFLabel1        (const Value: string    ); begin SetStringField('CFLabel1'   , Value);end;
procedure TCustomFields.SetCFLabel2        (const Value: string    ); begin SetStringField('CFLabel2'   , Value);end;
procedure TCustomFields.SetCFLabel3        (const Value: string    ); begin SetStringField('CFLabel3'   , Value);end;
procedure TCustomFields.SetCFLabel4        (const Value: string    ); begin SetStringField('CFLabel4'   , Value);end;
procedure TCustomFields.SetCFLabel5        (const Value: string    ); begin SetStringField('CFLabel5'   , Value);end;
procedure TCustomFields.SetCFLabel6        (const Value: string    ); begin SetStringField('CFLabel6'   , Value);end;
procedure TCustomFields.SetCFLabel7        (const Value: string    ); begin SetStringField('CFLabel7'   , Value);end;
procedure TCustomFields.SetCFLabel8        (const Value: string    ); begin SetStringField('CFLabel8'   , Value);end;
procedure TCustomFields.SetCFLabel9        (const Value: string    ); begin SetStringField('CFLabel9'   , Value);end;
procedure TCustomFields.SetCFLabel10       (const Value: string    ); begin SetStringField('CFLabel10'  , Value);end;
procedure TCustomFields.SetCFLabel11       (const Value: string    ); begin SetStringField('CFLabel11'  , Value);end;
procedure TCustomFields.SetCFLabel12       (const Value: string    ); begin SetStringField('CFLabel12'  , Value);end;
procedure TCustomFields.SetCFLabel13       (const Value: string    ); begin SetStringField('CFLabel13'  , Value);end;
procedure TCustomFields.SetCFLabel14       (const Value: string    ); begin SetStringField('CFLabel14'  , Value);end;
procedure TCustomFields.SetCFLabel15       (const Value: string    ); begin SetStringField('CFLabel15'  , Value);end;
procedure TCustomFields.SetCFLabel16       (const Value: string    ); begin SetStringField('CFLabel16'  , Value);end;
procedure TCustomFields.SetCFLabel17       (const Value: string    ); begin SetStringField('CFLabel17'  , Value);end;
procedure TCustomFields.SetCFLabel18       (const Value: string    ); begin SetStringField('CFLabel18'  , Value);end;


function TCustomFieldsCust.CustomFieldtype        : String;begin Result :='Cust';end;
function TCustomFieldsEmp.CustomFieldtype         : String;begin Result :='Emp' ;end;
function TCustomFieldsSupp.CustomFieldtype        : String;begin Result :='Supp';end;
function TCustomFieldsOthr.CustomFieldtype        : String;begin Result :='Othr';end;
function TCustomFieldsAssets.CustomFieldtype      : String;begin Result :='Assets';end;
function TCustomFieldsAppointment.CustomFieldtype : String;begin Result :='Appointment';end;
function TCustomFieldsRepairs.CustomFieldtype     : String;begin Result :='Repairs';end;
function TCustomFieldsProduct.CustomFieldtype     : String;begin Result :='Product';end;
function TCustomFieldsMC.CustomFieldtype          : String;begin Result :='MC';end;


initialization
  RegisterClass(TCustomFieldsCust);
  RegisterClass(TCustomFieldsEmp);
  RegisterClass(TCustomFieldsSupp);
  RegisterClass(TCustomFieldsOthr);
  RegisterClass(TCustomFieldsAssets);
  RegisterClass(TCustomFieldsAppointment);
  RegisterClass(TCustomFieldsRepairs);
  RegisterClass(TCustomFieldsProduct);
  RegisterClass(TCustomFieldsMC);
end.
