unit BusObjPOSTillEOPConfig;

    {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  05/01/17  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TPOSTillEOPConfig = class(TMSBusObj)
  private
    function GetAmount              : Integer   ;
    function GetAmountType          : String   ;
    procedure SetAmount              (const Value: Integer   );
    procedure SetAmountType          (const Value: String   );

    Function Multi(const amtNo:Integer):Double;
    Function Amt    (const amtNo:Integer):Integer;
    Function IsNote(const amtNo:Integer):Boolean ;
    Function IsActive(const amtNo:Integer):Boolean ;
    Function AmtCaption(const amtNo:Integer):String;
    Function Amttype(const amtNo:Integer):String;
    //Function AmttypeSymbol(const amtNo:Integer):String;


    Function GetMultiplier1          :Double  ;
    Function GetMultiplier2          :Double  ;
    Function GetMultiplier3          :Double  ;
    Function GetMultiplier4          :Double  ;
    Function GetMultiplier5          :Double  ;
    Function GetMultiplier6          :Double  ;
    Function GetMultiplier7          :Double  ;
    Function GetMultiplier8          :Double  ;
    Function GetMultiplier9          :Double  ;
    Function GetMultiplier10         :Double  ;
    Function GetMultiplier11         :Double  ;
    Function GetMultiplier12         :Double  ;
    Function GetMultiplier13         :Double  ;

    Function GetAmount1              :Integer ;
    Function GetAmount2              :Integer ;
    Function GetAmount3              :Integer ;
    Function GetAmount4              :Integer ;
    Function GetAmount5              :Integer ;
    Function GetAmount6              :Integer ;
    Function GetAmount7              :Integer ;
    Function GetAmount8              :Integer ;
    Function GetAmount9              :Integer ;
    Function GetAmount10             :Integer ;
    Function GetAmount11             :Integer ;
    Function GetAmount12             :Integer ;
    Function GetAmount13             :Integer ;

    Function GetIs1Note              :Boolean ;
    Function GetIs2Note              :Boolean ;
    Function GetIs3Note              :Boolean ;
    Function GetIs4Note              :Boolean ;
    Function GetIs5Note              :Boolean ;
    Function GetIs6Note              :Boolean ;
    Function GetIs7Note              :Boolean ;
    Function GetIs8Note              :Boolean ;
    Function GetIs9Note              :Boolean ;
    Function GetIs10Note             :Boolean ;
    Function GetIs11Note             :Boolean ;
    Function GetIs12Note             :Boolean ;
    Function GetIs13Note             :Boolean ;

    Function GetIs1Active              :Boolean ;
    Function GetIs2Active              :Boolean ;
    Function GetIs3Active              :Boolean ;
    Function GetIs4Active              :Boolean ;
    Function GetIs5Active              :Boolean ;
    Function GetIs6Active              :Boolean ;
    Function GetIs7Active              :Boolean ;
    Function GetIs8Active              :Boolean ;
    Function GetIs9Active              :Boolean ;
    Function GetIs10Active             :Boolean ;
    Function GetIs11Active             :Boolean ;
    Function GetIs12Active             :Boolean ;
    Function GetIs13Active             :Boolean ;

    Function GetAmtCaption1              :String ;
    Function GetAmtCaption2              :String ;
    Function GetAmtCaption3              :String ;
    Function GetAmtCaption4              :String ;
    Function GetAmtCaption5              :String ;
    Function GetAmtCaption6              :String ;
    Function GetAmtCaption7              :String ;
    Function GetAmtCaption8              :String ;
    Function GetAmtCaption9              :String ;
    Function GetAmtCaption10             :String ;
    Function GetAmtCaption11             :String ;
    Function GetAmtCaption12             :String ;
    Function GetAmtCaption13             :String ;
    function AmtToStr(AmtNo: Integer): String;
    function AmtDigits               : Integer;

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoBeforeInsert(Sender:TDatasetBusObj) : Boolean;          override;
    function  DoAfterOpen(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    procedure DoFieldOnChange(Sender: TField);                          override;

    property Multiplier1      :Double  Read GetMultiplier1;
    property Multiplier2      :Double  Read GetMultiplier2;
    property Multiplier3      :Double  Read GetMultiplier3;
    property Multiplier4      :Double  Read GetMultiplier4;
    property Multiplier5      :Double  Read GetMultiplier5;
    property Multiplier6      :Double  Read GetMultiplier6;
    property Multiplier7      :Double  Read GetMultiplier7;
    property Multiplier8      :Double  Read GetMultiplier8;
    property Multiplier9      :Double  Read GetMultiplier9;
    property Multiplier10     :Double  Read GetMultiplier10;
    property Multiplier11     :Double  Read GetMultiplier11;
    property Multiplier12     :Double  Read GetMultiplier12;
    property Multiplier13     :Double  Read GetMultiplier13;

    property Amount1          :Integer     read GetAmount1;
    property Amount2          :Integer     read GetAmount2;
    property Amount3          :Integer     read GetAmount3;
    property Amount4          :Integer     read GetAmount4;
    property Amount5          :Integer     read GetAmount5;
    property Amount6          :Integer     read GetAmount6;
    property Amount7          :Integer     read GetAmount7;
    property Amount8          :Integer     read GetAmount8;
    property Amount9          :Integer     read GetAmount9;
    property Amount10         :Integer     read GetAmount10;
    property Amount11         :Integer     read GetAmount11;
    property Amount12         :Integer     read GetAmount12;
    property Amount13         :Integer     read GetAmount13;


    property AmtCaption1          :String     read GetAmtCaption1;
    property AmtCaption2          :String     read GetAmtCaption2;
    property AmtCaption3          :String     read GetAmtCaption3;
    property AmtCaption4          :String     read GetAmtCaption4;
    property AmtCaption5          :String     read GetAmtCaption5;
    property AmtCaption6          :String     read GetAmtCaption6;
    property AmtCaption7          :String     read GetAmtCaption7;
    property AmtCaption8          :String     read GetAmtCaption8;
    property AmtCaption9          :String     read GetAmtCaption9;
    property AmtCaption10         :String     read GetAmtCaption10;
    property AmtCaption11         :String     read GetAmtCaption11;
    property AmtCaption12         :String     read GetAmtCaption12;
    property AmtCaption13         :String     read GetAmtCaption13;

    property Is1Note          :Boolean     Read GetIs1Note;
    property Is2Note          :Boolean     Read GetIs2Note;
    property Is3Note          :Boolean     Read GetIs3Note;
    property Is4Note          :Boolean     Read GetIs4Note;
    property Is5Note          :Boolean     Read GetIs5Note;
    property Is6Note          :Boolean     Read GetIs6Note;
    property Is7Note          :Boolean     Read GetIs7Note;
    property Is8Note          :Boolean     Read GetIs8Note;
    property Is9Note          :Boolean     Read GetIs9Note;
    property Is10Note         :Boolean     Read GetIs10Note;
    property Is11Note         :Boolean     Read GetIs11Note;
    property Is12Note         :Boolean     Read GetIs12Note;
    property Is13Note         :Boolean     Read GetIs13Note;

    property Is1Active          :Boolean     Read GetIs1Active;
    property Is2Active          :Boolean     Read GetIs2Active;
    property Is3Active          :Boolean     Read GetIs3Active;
    property Is4Active          :Boolean     Read GetIs4Active;
    property Is5Active          :Boolean     Read GetIs5Active;
    property Is6Active          :Boolean     Read GetIs6Active;
    property Is7Active          :Boolean     Read GetIs7Active;
    property Is8Active          :Boolean     Read GetIs8Active;
    property Is9Active          :Boolean     Read GetIs9Active;
    property Is10Active         :Boolean     Read GetIs10Active;
    property Is11Active         :Boolean     Read GetIs11Active;
    property Is12Active         :Boolean     Read GetIs12Active;
    property Is13Active         :Boolean     Read GetIs13Active;

  published
    property Amount               :Integer     read GetAmount             write SetAmount          ;
    property AmountType           :String      read GetAmountType         write SetAmountType      ;

  end;


implementation


uses tcDataUtils, CommonLib, AppEnvironment ,math , ERPdbComponents,
  DbSharedObjectsObj, POSConst , sysutils;



  {TPOSTillEOPConfig}

constructor TPOSTillEOPConfig.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'POSTillEOPConfig';
  fSQL := 'SELECT * FROM tblpostilleopconfig';
end;


destructor TPOSTillEOPConfig.Destroy;
begin
  inherited;
end;


procedure TPOSTillEOPConfig.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Amount');
  SetPropertyFromNode(node,'AmountType');
end;


procedure TPOSTillEOPConfig.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Amount' ,Amount);
  AddXMLNode(node,'AmountType' ,AmountType);
end;


function TPOSTillEOPConfig.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function TPOSTillEOPConfig.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TPOSTillEOPConfig.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TPOSTillEOPConfig.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TPOSTillEOPConfig.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TPOSTillEOPConfig.GetIDField: string;
begin
  Result := 'ID'
end;


class function TPOSTillEOPConfig.GetBusObjectTablename: string;
begin
  Result:= 'tblpostilleopconfig';
end;


function TPOSTillEOPConfig.DoAfterOpen(Sender: TDatasetBusObj): Boolean;
var
  qry: TERPQuery;
begin
  Result := inherited DoAfterOpen(Sender);
  if not result then Exit;
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Self.Connection.Connection);
  try
    qry.SQL.Text :='Select * from ' + BusObjectTableName;
    qry.Open;
    if qry.recordcount =0 then begin
      new;Amount := 100;AmountType := 'N';Postdb;
      new;Amount := 50 ;AmountType := 'N';Postdb;
      new;Amount := 20 ;AmountType := 'N';Postdb;
      new;Amount := 10 ;AmountType := 'N';Postdb;
      new;Amount := 5  ;AmountType := 'N';Postdb;
      new;Amount := 2  ;AmountType := 'N';Postdb;
      new;Amount := 1  ;AmountType := 'N';Postdb;
      new;Amount := 50 ;AmountType := 'C';Postdb;
      new;Amount := 20 ;AmountType := 'C';Postdb;
      new;Amount := 10 ;AmountType := 'C';Postdb;
      new;Amount := 5  ;AmountType := 'C';Postdb;
      new;Amount := 2  ;AmountType := 'C';Postdb;
      new;Amount := 1  ;AmountType := 'C';Postdb;
    end;
    while Count < NotesncoinsCount do new; // there are 13 records at the moment

  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

function TPOSTillEOPConfig.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


function TPOSTillEOPConfig.DoBeforeInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforeInsert(Sender);
  if not result then Exit;
end;

{Property Functions}
function  TPOSTillEOPConfig.GetAmount          : Integer   ; begin Result := GetIntegerField('Amount');end;
function  TPOSTillEOPConfig.GetAmountType      : String   ; begin Result := GetStringField('AmountType');end;
procedure TPOSTillEOPConfig.SetAmount          (const Value: Integer   ); begin SetIntegerField('Amount'           , Value);end;
procedure TPOSTillEOPConfig.SetAmountType      (const Value: String   ); begin SetStringField('AmountType'       , Value);end;

Function TPOSTillEOPConfig.Multi(const amtNo:Integer):Double;
begin
  result := 0;
  if count >=amtNo then begin
    if TERPQuery(dataset).gotoRecno(amtNo) then
      if IsNote(amtNo) then
        result := Amount
      else result := amount/Power(10 , appenv.RegionalOptions.DecimalPlaces);
  end;
end;

Function TPOSTillEOPConfig.Amt(const amtNo:Integer):Integer;
begin
  result := 0;
  if count >=amtNo then begin
    if TERPQuery(dataset).gotoRecno(amtNo) then
        result := Amount
  end;
end;

Function TPOSTillEOPConfig.IsNote(const amtNo:Integer):Boolean;
begin
  result := False;
  if count >=amtNo then begin
    if TERPQuery(dataset).gotoRecno(amtNo) then
        result := Amounttype='N';
  end;
end;
Function TPOSTillEOPConfig.AmtDigits :Integer;
begin
  Result := Length(trim(Inttostr(Amt(0))));
end;

Function TPOSTillEOPConfig.AmtToStr(AmtNo:Integer) :String;
var
  fi:Integer;
begin
  Result := trim(Inttostr(Amt(amtNo)));
  fi := AmtDigits+2;
  Result := ReplicateStr(' ' ,fi ) + Result;
  Result := copy(result , length(result)-(fi-1) , fi);
end;
Function TPOSTillEOPConfig.AmtCaption(const amtNo:Integer):String;
begin
  Result := '*****';
  if IsActive(amtNo) then
    Result := AmtToStr(AmtNo) +' ' +Amttype(amtNo)
end;
function TPOSTillEOPConfig.Amttype(const amtNo: Integer): String;
begin
  Result := '';
  if count >=amtNo then begin
    if TERPQuery(dataset).gotoRecno(amtNo) then
        if Amounttype='C' then result :=Appenv.RegionalOptions.DecimalCurrencyName else result :=Appenv.RegionalOptions.WholeCurrencyName;
  end;
end;
(*Function TPOSTillEOPConfig.AmttypeSymbol(const amtNo:Integer):String;
begin
  Result := '';
  if count >=amtNo then begin
    if TERPQuery(dataset).gotoRecno(amtNo) then
        if Amounttype='C' then result :=Appenv.RegionalOptions.DecimalCurrencyName else result :=Appenv.RegionalOptions.CurrencySymbol;
  end;

end;*)

Function TPOSTillEOPConfig.IsActive(const amtNo:Integer):Boolean;
begin
  result := False;
  if count >=amtNo then begin
    if TERPQuery(dataset).gotoRecno(amtNo) then
        result := Amount<>0;
  end;
end;
Function TPOSTillEOPConfig.GetMultiplier1          :Double  ; begin result :=Multi(1);end;
Function TPOSTillEOPConfig.GetMultiplier2          :Double  ; begin result :=Multi(2);end;
Function TPOSTillEOPConfig.GetMultiplier3          :Double  ; begin result :=Multi(3);end;
Function TPOSTillEOPConfig.GetMultiplier4          :Double  ; begin result :=Multi(4);end;
Function TPOSTillEOPConfig.GetMultiplier5          :Double  ; begin result :=Multi(5);end;
Function TPOSTillEOPConfig.GetMultiplier6          :Double  ; begin result :=Multi(6);end;
Function TPOSTillEOPConfig.GetMultiplier7          :Double  ; begin result :=Multi(7);end;
Function TPOSTillEOPConfig.GetMultiplier8          :Double  ; begin result :=Multi(8);end;
Function TPOSTillEOPConfig.GetMultiplier9          :Double  ; begin result :=Multi(9);end;
Function TPOSTillEOPConfig.GetMultiplier10         :Double  ; begin result :=Multi(10);end;
Function TPOSTillEOPConfig.GetMultiplier11         :Double  ; begin result :=Multi(11);end;
Function TPOSTillEOPConfig.GetMultiplier12         :Double  ; begin result :=Multi(12);end;
Function TPOSTillEOPConfig.GetMultiplier13         :Double  ; begin result :=Multi(13);end;

Function TPOSTillEOPConfig.GetAmount1              :Integer ; begin result :=Amt(1);end;
Function TPOSTillEOPConfig.GetAmount2              :Integer ; begin result :=Amt(2);end;
Function TPOSTillEOPConfig.GetAmount3              :Integer ; begin result :=Amt(3);end;
Function TPOSTillEOPConfig.GetAmount4              :Integer ; begin result :=Amt(4);end;
Function TPOSTillEOPConfig.GetAmount5              :Integer ; begin result :=Amt(5);end;
Function TPOSTillEOPConfig.GetAmount6              :Integer ; begin result :=Amt(6);end;
Function TPOSTillEOPConfig.GetAmount7              :Integer ; begin result :=Amt(7);end;
Function TPOSTillEOPConfig.GetAmount8              :Integer ; begin result :=Amt(8);end;
Function TPOSTillEOPConfig.GetAmount9              :Integer ; begin result :=Amt(9);end;
Function TPOSTillEOPConfig.GetAmount10             :Integer ; begin result :=Amt(10);end;
Function TPOSTillEOPConfig.GetAmount11             :Integer ; begin result :=Amt(11);end;
Function TPOSTillEOPConfig.GetAmount12             :Integer ; begin result :=Amt(12);end;
Function TPOSTillEOPConfig.GetAmount13             :Integer ; begin result :=Amt(13);end;

Function TPOSTillEOPConfig.GetAmtCaption1              :String ; begin result :=AmtCaption(1);end;
Function TPOSTillEOPConfig.GetAmtCaption2              :String ; begin result :=AmtCaption(2);end;
Function TPOSTillEOPConfig.GetAmtCaption3              :String ; begin result :=AmtCaption(3);end;
Function TPOSTillEOPConfig.GetAmtCaption4              :String ; begin result :=AmtCaption(4);end;
Function TPOSTillEOPConfig.GetAmtCaption5              :String ; begin result :=AmtCaption(5);end;
Function TPOSTillEOPConfig.GetAmtCaption6              :String ; begin result :=AmtCaption(6);end;
Function TPOSTillEOPConfig.GetAmtCaption7              :String ; begin result :=AmtCaption(7);end;
Function TPOSTillEOPConfig.GetAmtCaption8              :String ; begin result :=AmtCaption(8);end;
Function TPOSTillEOPConfig.GetAmtCaption9              :String ; begin result :=AmtCaption(9);end;
Function TPOSTillEOPConfig.GetAmtCaption10             :String ; begin result :=AmtCaption(10);end;
Function TPOSTillEOPConfig.GetAmtCaption11             :String ; begin result :=AmtCaption(11);end;
Function TPOSTillEOPConfig.GetAmtCaption12             :String ; begin result :=AmtCaption(12);end;
Function TPOSTillEOPConfig.GetAmtCaption13             :String ; begin result :=AmtCaption(13);end;


Function TPOSTillEOPConfig.GetIs1Note              :Boolean ; begin result :=IsNote(1);end;
Function TPOSTillEOPConfig.GetIs2Note              :Boolean ; begin result :=IsNote(2);end;
Function TPOSTillEOPConfig.GetIs3Note              :Boolean ; begin result :=IsNote(3);end;
Function TPOSTillEOPConfig.GetIs4Note              :Boolean ; begin result :=IsNote(4);end;
Function TPOSTillEOPConfig.GetIs5Note              :Boolean ; begin result :=IsNote(5);end;
Function TPOSTillEOPConfig.GetIs6Note              :Boolean ; begin result :=IsNote(6);end;
Function TPOSTillEOPConfig.GetIs7Note              :Boolean ; begin result :=IsNote(7);end;
Function TPOSTillEOPConfig.GetIs8Note              :Boolean ; begin result :=IsNote(8);end;
Function TPOSTillEOPConfig.GetIs9Note              :Boolean ; begin result :=IsNote(9);end;
Function TPOSTillEOPConfig.GetIs10Note             :Boolean ; begin result :=IsNote(10);end;
Function TPOSTillEOPConfig.GetIs11Note             :Boolean ; begin result :=IsNote(11);end;
Function TPOSTillEOPConfig.GetIs12Note             :Boolean ; begin result :=IsNote(12);end;
Function TPOSTillEOPConfig.GetIs13Note             :Boolean ; begin result :=IsNote(13);end;

Function TPOSTillEOPConfig.GetIs1Active              :Boolean ; begin result :=IsActive(1);end;
Function TPOSTillEOPConfig.GetIs2Active              :Boolean ; begin result :=IsActive(2);end;
Function TPOSTillEOPConfig.GetIs3Active              :Boolean ; begin result :=IsActive(3);end;
Function TPOSTillEOPConfig.GetIs4Active              :Boolean ; begin result :=IsActive(4);end;
Function TPOSTillEOPConfig.GetIs5Active              :Boolean ; begin result :=IsActive(5);end;
Function TPOSTillEOPConfig.GetIs6Active              :Boolean ; begin result :=IsActive(6);end;
Function TPOSTillEOPConfig.GetIs7Active              :Boolean ; begin result :=IsActive(7);end;
Function TPOSTillEOPConfig.GetIs8Active              :Boolean ; begin result :=IsActive(8);end;
Function TPOSTillEOPConfig.GetIs9Active              :Boolean ; begin result :=IsActive(9);end;
Function TPOSTillEOPConfig.GetIs10Active             :Boolean ; begin result :=IsActive(10);end;
Function TPOSTillEOPConfig.GetIs11Active             :Boolean ; begin result :=IsActive(11);end;
Function TPOSTillEOPConfig.GetIs12Active             :Boolean ; begin result :=IsActive(12);end;
Function TPOSTillEOPConfig.GetIs13Active             :Boolean ; begin result :=IsActive(13);end;

initialization
  RegisterClass(TPOSTillEOPConfig);

(*  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  05/01/17  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TPosTilleopConfig = class(TMSBusObj)
  private
    function GetAmount1             : Integer   ;
    function GetAmount2             : Integer   ;
    function GetAmount3             : Integer   ;
    function GetAmount4             : Integer   ;
    function GetAmount5             : Integer   ;
    function GetAmount6             : Integer   ;
    function GetAmount7             : Integer   ;
    function GetAmount8             : Integer   ;
    function GetAmount9             : Integer   ;
    function GetAmount10            : Integer   ;
    function GetAmount11            : Integer   ;
    function GetAmount12            : Integer   ;
    function GetAmount13            : Integer   ;
    function GetAmountType1         : Boolean   ;
    function GetAmountType2         : Boolean   ;
    function GetAmountType3         : Boolean   ;
    function GetAmountType4         : Boolean   ;
    function GetAmountType5         : Boolean   ;
    function GetAmountType6         : Boolean   ;
    function GetAmountType7         : Boolean   ;
    function GetAmountType8         : Boolean   ;
    function GetAmountType9         : Boolean   ;
    function GetAmountType10        : Boolean   ;
    function GetAmountType11        : Boolean   ;
    function GetAmountType12        : Boolean   ;
    function GetAmountType13        : Boolean   ;
    function GetMultiplier1         : Double    ;
    function GetMultiplier2         : Double    ;
    function GetMultiplier3         : Double    ;
    function GetMultiplier4         : Double    ;
    function GetMultiplier5         : Double    ;
    function GetMultiplier6         : Double    ;
    function GetMultiplier7         : Double    ;
    function GetMultiplier8         : Double    ;
    function GetMultiplier9         : Double    ;
    function GetMultiplier10        : Double    ;
    function GetMultiplier11        : Double    ;
    function GetMultiplier12        : Double    ;
    function GetMultiplier13        : Double    ;

    procedure SetAmount1             (const Value: Integer   );
    procedure SetAmount2             (const Value: Integer   );
    procedure SetAmount3             (const Value: Integer   );
    procedure SetAmount4             (const Value: Integer   );
    procedure SetAmount5             (const Value: Integer   );
    procedure SetAmount6             (const Value: Integer   );
    procedure SetAmount7             (const Value: Integer   );
    procedure SetAmount8             (const Value: Integer   );
    procedure SetAmount9             (const Value: Integer   );
    procedure SetAmount10            (const Value: Integer   );
    procedure SetAmount11            (const Value: Integer   );
    procedure SetAmount12            (const Value: Integer   );
    procedure SetAmount13            (const Value: Integer   );
    procedure SetAmountType1         (const Value: Boolean   );
    procedure SetAmountType2         (const Value: Boolean   );
    procedure SetAmountType3         (const Value: Boolean   );
    procedure SetAmountType4         (const Value: Boolean   );
    procedure SetAmountType5         (const Value: Boolean   );
    procedure SetAmountType6         (const Value: Boolean   );
    procedure SetAmountType7         (const Value: Boolean   );
    procedure SetAmountType8         (const Value: Boolean   );
    procedure SetAmountType9         (const Value: Boolean   );
    procedure SetAmountType10        (const Value: Boolean   );
    procedure SetAmountType11        (const Value: Boolean   );
    procedure SetAmountType12        (const Value: Boolean   );
    procedure SetAmountType13        (const Value: Boolean   );
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
    property Multiplier1              :Double  Read GetMultiplier1;
    property Multiplier2              :Double  Read GetMultiplier2;
    property Multiplier3              :Double  Read GetMultiplier3;
    property Multiplier4              :Double  Read GetMultiplier4;
    property Multiplier5              :Double  Read GetMultiplier5;
    property Multiplier6              :Double  Read GetMultiplier6;
    property Multiplier7              :Double  Read GetMultiplier7;
    property Multiplier8              :Double  Read GetMultiplier8;
    property Multiplier9              :Double  Read GetMultiplier9;
    property Multiplier10             :Double  Read GetMultiplier10;
    property Multiplier11             :Double  Read GetMultiplier11;
    property Multiplier12             :Double  Read GetMultiplier12;
    property Multiplier13             :Double  Read GetMultiplier13;

  published
    property Amount1              :Integer     read GetAmount1            write SetAmount1         ;
    property Amount2              :Integer     read GetAmount2            write SetAmount2         ;
    property Amount3              :Integer     read GetAmount3            write SetAmount3         ;
    property Amount4              :Integer     read GetAmount4            write SetAmount4         ;
    property Amount5              :Integer     read GetAmount5            write SetAmount5         ;
    property Amount6              :Integer     read GetAmount6            write SetAmount6         ;
    property Amount7              :Integer     read GetAmount7            write SetAmount7         ;
    property Amount8              :Integer     read GetAmount8            write SetAmount8         ;
    property Amount9              :Integer     read GetAmount9            write SetAmount9         ;
    property Amount10             :Integer     read GetAmount10           write SetAmount10        ;
    property Amount11             :Integer     read GetAmount11           write SetAmount11        ;
    property Amount12             :Integer     read GetAmount12           write SetAmount12        ;
    property Amount13             :Integer     read GetAmount13           write SetAmount13        ;
    property AmountType1          :Boolean     read GetAmountType1        write SetAmountType1     ;
    property AmountType2          :Boolean     read GetAmountType2        write SetAmountType2     ;
    property AmountType3          :Boolean     read GetAmountType3        write SetAmountType3     ;
    property AmountType4          :Boolean     read GetAmountType4        write SetAmountType4     ;
    property AmountType5          :Boolean     read GetAmountType5        write SetAmountType5     ;
    property AmountType6          :Boolean     read GetAmountType6        write SetAmountType6     ;
    property AmountType7          :Boolean     read GetAmountType7        write SetAmountType7     ;
    property AmountType8          :Boolean     read GetAmountType8        write SetAmountType8     ;
    property AmountType9          :Boolean     read GetAmountType9        write SetAmountType9     ;
    property AmountType10         :Boolean     read GetAmountType10       write SetAmountType10    ;
    property AmountType11         :Boolean     read GetAmountType11       write SetAmountType11    ;
    property AmountType12         :Boolean     read GetAmountType12       write SetAmountType12    ;
    property AmountType13         :Boolean     read GetAmountType13       write SetAmountType13    ;
  end;


implementation


uses tcDataUtils, CommonLib, AppEnvironment , math;



  {TPosTilleopConfig}

constructor TPosTilleopConfig.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'PosTilleopConfig';
  fSQL := 'SELECT * FROM tblpostilleopconfig';
end;


destructor TPosTilleopConfig.Destroy;
begin
  inherited;
end;


procedure TPosTilleopConfig.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Amount1');
  SetPropertyFromNode(node,'Amount2');
  SetPropertyFromNode(node,'Amount3');
  SetPropertyFromNode(node,'Amount4');
  SetPropertyFromNode(node,'Amount5');
  SetPropertyFromNode(node,'Amount6');
  SetPropertyFromNode(node,'Amount7');
  SetPropertyFromNode(node,'Amount8');
  SetPropertyFromNode(node,'Amount9');
  SetPropertyFromNode(node,'Amount10');
  SetPropertyFromNode(node,'Amount11');
  SetPropertyFromNode(node,'Amount12');
  SetPropertyFromNode(node,'Amount13');
  SetBooleanPropertyFromNode(node,'AmountType1');
  SetBooleanPropertyFromNode(node,'AmountType2');
  SetBooleanPropertyFromNode(node,'AmountType3');
  SetBooleanPropertyFromNode(node,'AmountType4');
  SetBooleanPropertyFromNode(node,'AmountType5');
  SetBooleanPropertyFromNode(node,'AmountType6');
  SetBooleanPropertyFromNode(node,'AmountType7');
  SetBooleanPropertyFromNode(node,'AmountType8');
  SetBooleanPropertyFromNode(node,'AmountType9');
  SetBooleanPropertyFromNode(node,'AmountType10');
  SetBooleanPropertyFromNode(node,'AmountType11');
  SetBooleanPropertyFromNode(node,'AmountType12');
  SetBooleanPropertyFromNode(node,'AmountType13');
end;


procedure TPosTilleopConfig.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Amount1' ,Amount1);
  AddXMLNode(node,'Amount2' ,Amount2);
  AddXMLNode(node,'Amount3' ,Amount3);
  AddXMLNode(node,'Amount4' ,Amount4);
  AddXMLNode(node,'Amount5' ,Amount5);
  AddXMLNode(node,'Amount6' ,Amount6);
  AddXMLNode(node,'Amount7' ,Amount7);
  AddXMLNode(node,'Amount8' ,Amount8);
  AddXMLNode(node,'Amount9' ,Amount9);
  AddXMLNode(node,'Amount10' ,Amount10);
  AddXMLNode(node,'Amount11' ,Amount11);
  AddXMLNode(node,'Amount12' ,Amount12);
  AddXMLNode(node,'Amount13' ,Amount13);
  AddXMLNode(node,'AmountType1' ,AmountType1);
  AddXMLNode(node,'AmountType2' ,AmountType2);
  AddXMLNode(node,'AmountType3' ,AmountType3);
  AddXMLNode(node,'AmountType4' ,AmountType4);
  AddXMLNode(node,'AmountType5' ,AmountType5);
  AddXMLNode(node,'AmountType6' ,AmountType6);
  AddXMLNode(node,'AmountType7' ,AmountType7);
  AddXMLNode(node,'AmountType8' ,AmountType8);
  AddXMLNode(node,'AmountType9' ,AmountType9);
  AddXMLNode(node,'AmountType10' ,AmountType10);
  AddXMLNode(node,'AmountType11' ,AmountType11);
  AddXMLNode(node,'AmountType12' ,AmountType12);
  AddXMLNode(node,'AmountType13' ,AmountType13);
end;


function TPosTilleopConfig.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TPosTilleopConfig.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TPosTilleopConfig.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TPosTilleopConfig.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TPosTilleopConfig.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TPosTilleopConfig.GetIDField: string;
begin
  Result := 'ID'
end;


function TPosTilleopConfig.GetMultiplier1 : Double;begin  Result := Amount1  / iif(AmountType1 ='C' , Power(10 , Appenv.RegionalOptions.DecimalPlaces) , 1);end;
function TPosTilleopConfig.GetMultiplier2 : Double;begin  Result := Amount2  / iif(AmountType2 ='C' , Power(10 , Appenv.RegionalOptions.DecimalPlaces) , 1);end;
function TPosTilleopConfig.GetMultiplier3 : Double;begin  Result := Amount3  / iif(AmountType3 ='C' , Power(10 , Appenv.RegionalOptions.DecimalPlaces) , 1);end;
function TPosTilleopConfig.GetMultiplier4 : Double;begin  Result := Amount4  / iif(AmountType4 ='C' , Power(10 , Appenv.RegionalOptions.DecimalPlaces) , 1);end;
function TPosTilleopConfig.GetMultiplier5 : Double;begin  Result := Amount5  / iif(AmountType5 ='C' , Power(10 , Appenv.RegionalOptions.DecimalPlaces) , 1);end;
function TPosTilleopConfig.GetMultiplier6 : Double;begin  Result := Amount6  / iif(AmountType6 ='C' , Power(10 , Appenv.RegionalOptions.DecimalPlaces) , 1);end;
function TPosTilleopConfig.GetMultiplier7 : Double;begin  Result := Amount7  / iif(AmountType7 ='C' , Power(10 , Appenv.RegionalOptions.DecimalPlaces) , 1);end;
function TPosTilleopConfig.GetMultiplier8 : Double;begin  Result := Amount8  / iif(AmountType8 ='C' , Power(10 , Appenv.RegionalOptions.DecimalPlaces) , 1);end;
function TPosTilleopConfig.GetMultiplier9 : Double;begin  Result := Amount9  / iif(AmountType9 ='C' , Power(10 , Appenv.RegionalOptions.DecimalPlaces) , 1);end;
function TPosTilleopConfig.GetMultiplier10: Double;begin  Result := Amount10 / iif(AmountType10='C' , Power(10 , Appenv.RegionalOptions.DecimalPlaces) , 1);end;
function TPosTilleopConfig.GetMultiplier11: Double;begin  Result := Amount11 / iif(AmountType11='C' , Power(10 , Appenv.RegionalOptions.DecimalPlaces) , 1);end;
function TPosTilleopConfig.GetMultiplier12: Double;begin  Result := Amount12 / iif(AmountType12='C' , Power(10 , Appenv.RegionalOptions.DecimalPlaces) , 1);end;
function TPosTilleopConfig.GetMultiplier13: Double;begin  Result := Amount13 / iif(AmountType13='C' , Power(10 , Appenv.RegionalOptions.DecimalPlaces) , 1);end;

class function TPosTilleopConfig.GetBusObjectTablename: string;
begin
  Result:= 'tblpostilleopconfig';
end;


function TPosTilleopConfig.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TPosTilleopConfig.GetAmount1         : Integer   ; begin Result := GetIntegerField('Amount1');end;
function  TPosTilleopConfig.GetAmount2         : Integer   ; begin Result := GetIntegerField('Amount2');end;
function  TPosTilleopConfig.GetAmount3         : Integer   ; begin Result := GetIntegerField('Amount3');end;
function  TPosTilleopConfig.GetAmount4         : Integer   ; begin Result := GetIntegerField('Amount4');end;
function  TPosTilleopConfig.GetAmount5         : Integer   ; begin Result := GetIntegerField('Amount5');end;
function  TPosTilleopConfig.GetAmount6         : Integer   ; begin Result := GetIntegerField('Amount6');end;
function  TPosTilleopConfig.GetAmount7         : Integer   ; begin Result := GetIntegerField('Amount7');end;
function  TPosTilleopConfig.GetAmount8         : Integer   ; begin Result := GetIntegerField('Amount8');end;
function  TPosTilleopConfig.GetAmount9         : Integer   ; begin Result := GetIntegerField('Amount9');end;
function  TPosTilleopConfig.GetAmount10        : Integer   ; begin Result := GetIntegerField('Amount10');end;
function  TPosTilleopConfig.GetAmount11        : Integer   ; begin Result := GetIntegerField('Amount11');end;
function  TPosTilleopConfig.GetAmount12        : Integer   ; begin Result := GetIntegerField('Amount12');end;
function  TPosTilleopConfig.GetAmount13        : Integer   ; begin Result := GetIntegerField('Amount13');end;
function  TPosTilleopConfig.GetAmountType1     : Boolean   ; begin Result := GetBooleanField('AmountType1');end;
function  TPosTilleopConfig.GetAmountType2     : Boolean   ; begin Result := GetBooleanField('AmountType2');end;
function  TPosTilleopConfig.GetAmountType3     : Boolean   ; begin Result := GetBooleanField('AmountType3');end;
function  TPosTilleopConfig.GetAmountType4     : Boolean   ; begin Result := GetBooleanField('AmountType4');end;
function  TPosTilleopConfig.GetAmountType5     : Boolean   ; begin Result := GetBooleanField('AmountType5');end;
function  TPosTilleopConfig.GetAmountType6     : Boolean   ; begin Result := GetBooleanField('AmountType6');end;
function  TPosTilleopConfig.GetAmountType7     : Boolean   ; begin Result := GetBooleanField('AmountType7');end;
function  TPosTilleopConfig.GetAmountType8     : Boolean   ; begin Result := GetBooleanField('AmountType8');end;
function  TPosTilleopConfig.GetAmountType9     : Boolean   ; begin Result := GetBooleanField('AmountType9');end;
function  TPosTilleopConfig.GetAmountType10    : Boolean   ; begin Result := GetBooleanField('AmountType10');end;
function  TPosTilleopConfig.GetAmountType11    : Boolean   ; begin Result := GetBooleanField('AmountType11');end;
function  TPosTilleopConfig.GetAmountType12    : Boolean   ; begin Result := GetBooleanField('AmountType12');end;
function  TPosTilleopConfig.GetAmountType13    : Boolean   ; begin Result := GetBooleanField('AmountType13');end;
procedure TPosTilleopConfig.SetAmount1         (const Value: Integer   ); begin SetIntegerField('Amount1'          , Value);end;
procedure TPosTilleopConfig.SetAmount2         (const Value: Integer   ); begin SetIntegerField('Amount2'          , Value);end;
procedure TPosTilleopConfig.SetAmount3         (const Value: Integer   ); begin SetIntegerField('Amount3'          , Value);end;
procedure TPosTilleopConfig.SetAmount4         (const Value: Integer   ); begin SetIntegerField('Amount4'          , Value);end;
procedure TPosTilleopConfig.SetAmount5         (const Value: Integer   ); begin SetIntegerField('Amount5'          , Value);end;
procedure TPosTilleopConfig.SetAmount6         (const Value: Integer   ); begin SetIntegerField('Amount6'          , Value);end;
procedure TPosTilleopConfig.SetAmount7         (const Value: Integer   ); begin SetIntegerField('Amount7'          , Value);end;
procedure TPosTilleopConfig.SetAmount8         (const Value: Integer   ); begin SetIntegerField('Amount8'          , Value);end;
procedure TPosTilleopConfig.SetAmount9         (const Value: Integer   ); begin SetIntegerField('Amount9'          , Value);end;
procedure TPosTilleopConfig.SetAmount10        (const Value: Integer   ); begin SetIntegerField('Amount10'         , Value);end;
procedure TPosTilleopConfig.SetAmount11        (const Value: Integer   ); begin SetIntegerField('Amount11'         , Value);end;
procedure TPosTilleopConfig.SetAmount12        (const Value: Integer   ); begin SetIntegerField('Amount12'         , Value);end;
procedure TPosTilleopConfig.SetAmount13        (const Value: Integer   ); begin SetIntegerField('Amount13'         , Value);end;
procedure TPosTilleopConfig.SetAmountType1     (const Value: Boolean   ); begin SetBooleanField('AmountType1'      , Value);end;
procedure TPosTilleopConfig.SetAmountType2     (const Value: Boolean   ); begin SetBooleanField('AmountType2'      , Value);end;
procedure TPosTilleopConfig.SetAmountType3     (const Value: Boolean   ); begin SetBooleanField('AmountType3'      , Value);end;
procedure TPosTilleopConfig.SetAmountType4     (const Value: Boolean   ); begin SetBooleanField('AmountType4'      , Value);end;
procedure TPosTilleopConfig.SetAmountType5     (const Value: Boolean   ); begin SetBooleanField('AmountType5'      , Value);end;
procedure TPosTilleopConfig.SetAmountType6     (const Value: Boolean   ); begin SetBooleanField('AmountType6'      , Value);end;
procedure TPosTilleopConfig.SetAmountType7     (const Value: Boolean   ); begin SetBooleanField('AmountType7'      , Value);end;
procedure TPosTilleopConfig.SetAmountType8     (const Value: Boolean   ); begin SetBooleanField('AmountType8'      , Value);end;
procedure TPosTilleopConfig.SetAmountType9     (const Value: Boolean   ); begin SetBooleanField('AmountType9'      , Value);end;
procedure TPosTilleopConfig.SetAmountType10    (const Value: Boolean   ); begin SetBooleanField('AmountType10'     , Value);end;
procedure TPosTilleopConfig.SetAmountType11    (const Value: Boolean   ); begin SetBooleanField('AmountType11'     , Value);end;
procedure TPosTilleopConfig.SetAmountType12    (const Value: Boolean   ); begin SetBooleanField('AmountType12'     , Value);end;
procedure TPosTilleopConfig.SetAmountType13    (const Value: Boolean   ); begin SetBooleanField('AmountType13'     , Value);end;


initialization
  RegisterClass(TPosTilleopConfig);*)


end.
