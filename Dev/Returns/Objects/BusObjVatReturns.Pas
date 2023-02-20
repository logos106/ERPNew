unit BusObjVatReturns;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  22/02/08  1.00.01  A.  Initial Version.
  }


interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, BusobjReturns;

type

TVATReturnLines = class(TBASReturnLines)
    Private
    Protected
      function GetReportID          : Integer   ;Override;
      function GetReportCode        : string    ;Override;
      procedure SetReportID          (const Value: Integer   );Override;
      procedure SetReportCode        (const Value: string    );Override;
    Public
      class function  GetBusObjectTablename        : string;              override;
      Constructor  Create(AOwner: TComponent);              override;
  end;

TVATReturns = class(TReturns)
  private
    Function GetVATDesc         : string    ;
    Function GetType            : string    ;
    Function GetMonth           : string    ;
    Function GetYear            : Integer   ;
    Function GetVAT1            : Double    ;
    Function GetVAT1Selected    : string    ;
    Function GetVAT2            : Double    ;
    Function GetVAT2Selected    : string    ;
    Function GetVAT3            : Double    ;
    Function GetVAT3Selected    : string    ;
    Function GetVAT4            : Double    ;
    Function GetVAT4Selected    : string    ;
    Function GetVAT5            : Double    ;
    Function GetVAT5Per         : Double    ;
    Function GetVAT5Selected    : string    ;
    Function GetVAT6            : Double    ;
    Function GetVAT6Selected    : string    ;
    Function GetVAT7            : Double    ;
    Function GetVAT7Selected    : string    ;
    Function GetVAT8            : Double    ;
    Function GetVAT8Selected    : string    ;
    Function GetVAT9            : Double    ;
    Function GetVAT9Selected    : string    ;
    // Added for Roverto
    function GetHasTab1         : Boolean;
    function GetTab1Month       : String;
    function GetTab1Type        : String;
    function GetTab1Year        : Integer;
    function GetVAT1A           : Double;
    function GetVAT1ASelected   : String;
    function GetVAT2A           : Double;
    function GetVAT2ASelected   : String;
    function GetVAT4A           : Double;
    function GetVAT10           : Double;
    function GetVAT10Selected  : String;
    function GetVAT11           : Double;
    function GetVAT12           : Double;
    function GetVAT12Selected  : String;

    function GetHasTab2         : Boolean;
    function GetTab2Month       : String;
    function GetTab2Type        : String;
    function GetTab2Year        : Integer;
    function GetVAT14           : Double;
    function GetVAT14Selected   : String;
    function GetVAT14A          : Double;
    function GetVAT14ASelected  : String;
    function GetVAT15           : Double;
    function GetVAT15Selected   : String;
    function GetVAT15A          : Double;
    function GetVAT15ASelected  : String;
    function GetVAT16           : Double;
    function GetVAT16Selected   : String;
    function GetVAT17           : Double;
    function GetVAT17Selected   : String;
    function GetVAT18           : Double;
    function GetVAT18Selected   : String;

    function GetHasTab3         : Boolean;
    function GetTab3Month       : String;
    function GetTab3Type        : String;
    function GetTab3Year        : Integer;
    function GetVAT21           : Double;
    function GetVAT21Selected   : String;
    function GetVAT22           : Double;
    function GetVAT22Selected   : String;
    function GetVAT23Per        : Double;
    function GetVAT24Per        : Double;
    function GetVAT26           : Double;
    function GetVAT26Selected   : String;
    function GetVAT27           : Double;
    function GetVAT27Selected   : String;
    function GetVAT28Per        : Double;
    function GetVAT30           : Double;
    function GetVAT30Selected   : String;
    function GetVAT31           : Double;
    function GetVAT31Selected   : String;
    function GetVAT32Per        : Double;
    function GetVAT34           : Double;
    function GetVAT34Selected   : String;
    function GetVAT35           : Double;
    function GetVAT35Selected   : String;
    function GetVAT36Per        : Double;

    function GetHasTab4         : Boolean;
    function GetHasTab5         : Boolean;
    function GetPaymentRefNo    : String;
    function GetPenaltyInterest : Double;

    Procedure SetVATDesc         (const Value: string    );
    Procedure SetType            (const Value: string    );
    Procedure SetMonth           (const Value: string    );
    Procedure SetYear            (const Value: Integer   );
    Procedure SetVAT1            (const Value: Double    );
    Procedure SetVAT1Selected    (const Value: string    );
    Procedure SetVAT2            (const Value: Double    );
    Procedure SetVAT2Selected    (const Value: string    );
    Procedure SetVAT3            (const Value: Double    );
    Procedure SetVAT3Selected    (const Value: string    );
    Procedure SetVAT4            (const Value: Double    );
    Procedure SetVAT4Selected    (const Value: string    );
    Procedure SetVAT5            (const Value: Double    );
    Procedure SetVAT5Per         (const Value: Double    );
    Procedure SetVAT5Selected    (const Value: string    );
    Procedure SetVAT6            (const Value: Double    );
    Procedure SetVAT6Selected    (const Value: string    );
    Procedure SetVAT7            (const Value: Double    );
    Procedure SetVAT7Selected    (const Value: string    );
    Procedure SetVAT8            (const Value: Double    );
    Procedure SetVAT8Selected    (const Value: string    );
    Procedure SetVAT9            (const Value: Double    );
    Procedure SetVAT9Selected    (const Value: string    );
    // Added for Roverto
    Procedure SetHasTab1         (const Value: Boolean);
    Procedure SetTab1Month       (const Value: String);
    Procedure SetTab1Type        (const Value: String);
    Procedure SetTab1Year        (const Value: Integer);
    Procedure SetVAT1A           (const Value: Double);
    Procedure SetVAT1ASelected   (const Value: String);
    Procedure SetVAT2A           (const Value: Double);
    Procedure SetVAT2ASelected   (const Value: String);
    Procedure SetVAT4A           (const Value: Double);
    Procedure SetVAT10           (const Value: Double);
    Procedure SetVAT10Selected   (const Value: String);
    Procedure SetVAT11           (const Value: Double);
    Procedure SetVAT12           (const Value: Double);
    Procedure SetVAT12Selected    (const Value: String);

    Procedure SetHasTab2         (const Value: Boolean);
    Procedure SetTab2Month       (const Value: String);
    Procedure SetTab2Type        (const Value: String);
    Procedure SetTab2Year        (const Value: Integer);
    Procedure SetVAT14           (const Value: Double);
    Procedure SetVAT14Selected   (const Value: String);
    Procedure SetVAT14A          (const Value: Double);
    Procedure SetVAT14ASelected  (const Value: String);
    Procedure SetVAT15           (const Value: Double);
    Procedure SetVAT15Selected   (const Value: String);
    Procedure SetVAT15A          (const Value: Double);
    Procedure SetVAT15ASelected  (const Value: String);
    Procedure SetVAT16           (const Value: Double);
    Procedure SetVAT16Selected   (const Value: String);
    Procedure SetVAT17           (const Value: Double);
    Procedure SetVAT17Selected   (const Value: String);
    Procedure SetVAT18           (const Value: Double);
    Procedure SetVAT18Selected   (const Value: String);

    Procedure SetHasTab3         (const Value: Boolean);
    Procedure SetTab3Month       (const Value: String);
    Procedure SetTab3Type        (const Value: String);
    Procedure SetTab3Year        (const Value: Integer);
    Procedure SetVAT21           (const Value: Double);
    Procedure SetVAT21Selected   (const Value: String);
    Procedure SetVAT22           (const Value: Double);
    Procedure SetVAT22Selected   (const Value: String);
    Procedure SetVAT23Per        (const Value: Double);
    Procedure SetVAT24Per        (const Value: Double);
    Procedure SetVAT26           (const Value: Double);
    Procedure SetVAT26Selected   (const Value: String);
    Procedure SetVAT27           (const Value: Double);
    Procedure SetVAT27Selected   (const Value: String);
    Procedure SetVAT28Per        (const Value: Double);
    Procedure SetVAT30           (const Value: Double);
    Procedure SetVAT30Selected   (const Value: String);
    Procedure SetVAT31           (const Value: Double);
    Procedure SetVAT31Selected   (const Value: String);
    Procedure SetVAT32Per        (const Value: Double);
    Procedure SetVAT34           (const Value: Double);
    Procedure SetVAT34Selected   (const Value: String);
    Procedure SetVAT35           (const Value: Double);
    Procedure SetVAT35Selected   (const Value: String);
    Procedure SetVAT36Per        (const Value: Double);

    Procedure SetHasTab4         (const Value: Boolean);
    Procedure SetHasTab5         (const Value: Boolean);
    Procedure SetPaymentRefNo    (const Value: String);
    Procedure SetPenaltyInterest (const Value: Double);

    function getVATReturnLines: TVATReturnLines;
    function getVAT_From: TDate;
    function getVAT_To: TDate;
    function ValidateDateRange: Boolean;
    function GetSubmitted: boolean;
    procedure SetSubmitted(const Value: boolean);
    function GetObligationID: integer;
    procedure SetObligationID(const Value: integer);
    function GetPeriodKey: string;

  Protected
    Procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    Procedure DoFieldOnChange(Sender: TField);                          override;
    Function  GetSQL                             : string;              override;
    Function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender :TDatasetBusobj):Boolean;            Override;
    function getLines: TReturnLines;Override;
    function getCodeFieldName: String;Override;
    function getHeaderIDFieldName: String;Override;
    function getHeaderDescfieldName: String;Override;
    function getdescription: String; Override;
    procedure Setdescription(const Value: String);Override;
    function GetAccMethod       : string    ;override;
    procedure SetAccMethod       (const Value: string    );override;
    function GetClassID         : Integer   ;override;
    procedure SetClassID         (const Value: Integer   );override;
    function GetAllClass         : Boolean   ;override;
    procedure SetAllClass         (const Value: Boolean   );override;


  Public
    Class Function  GetIDField                   : string;              override;
    Class Function  GetBusObjectTablename        : string;              override;
    Constructor  Create(AOwner: TComponent);                            override;
    Destructor   Destroy;                                               override;
    Procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    Procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    Function     ValidateData: Boolean ;                                override;
    Function     Save: Boolean ;                                        override;
    Property VAT_From :TDate read getVAT_From;
    Property VAT_To :TDate read getVAT_To;
    procedure NextReturn(ReturnPage: TReturnPage; Changetype:boolean =True);Override;

  Published
    property VATDesc          :string      read GetVATDesc        write SetVATDesc     ;
    property VATType          :string      read GetType           write SetType        ;
    property Month            :string      read GetMonth          write SetMonth       ;
    property Year             :Integer     read GetYear           write SetYear        ;
    property VAT1             :Double      read GetVAT1           write SetVAT1        ;
    property VAT1Selected     :string      read GetVAT1Selected   write SetVAT1Selected;
    property VAT2             :Double      read GetVAT2           write SetVAT2        ;
    property VAT2Selected     :string      read GetVAT2Selected   write SetVAT2Selected;
    property VAT3             :Double      read GetVAT3           write SetVAT3        ;
    property VAT3Selected     :string      read GetVAT3Selected   write SetVAT3Selected;
    property VAT4             :Double      read GetVAT4           write SetVAT4        ;
    property VAT4Selected     :string      read GetVAT4Selected   write SetVAT4Selected;
    property VAT5             :Double      read GetVAT5           write SetVAT5        ;
    property VAT5Per          :Double      read GetVAT5Per        write SetVAT5Per     ;
    property VAT5Selected     :string      read GetVAT5Selected   write SetVAT5Selected;
    property VAT6             :Double      read GetVAT6           write SetVAT6        ;
    property VAT6Selected     :string      read GetVAT6Selected   write SetVAT6Selected;
    property VAT7             :Double      read GetVAT7           write SetVAT7        ;
    property VAT7Selected     :string      read GetVAT7Selected   write SetVAT7Selected;
    property VAT8             :Double      read GetVAT8           write SetVAT8        ;
    property VAT8Selected     :string      read GetVAT8Selected   write SetVAT8Selected;
    property VAT9             :Double      read GetVAT9           write SetVAT9        ;
    property VAT9Selected     :string      read GetVAT9Selected   write SetVAT9Selected;
    property Lines: TVATReturnLines Read getVATReturnLines;
    property Submitted: boolean read GetSubmitted write SetSubmitted;
    property ObligationID: integer read GetObligationID write SetObligationID;
    property PeriodKey: string read GetPeriodKey;

    // Added for Roverto
    property HasTab1          :Boolean      read GetHasTab1         write SetHasTab1;
    property Tab1Month        :String       read GetTab1Month       write SetTab1Month;
    property Tab1Type         :String       read GetTab1Type        write SetTab1Type;
    property Tab1Year         :Integer      read GetTab1Year        write SetTab1Year;
    property VAT1A             :Double      read GetVAT1A           write SetVAT1A        ;
    property VAT1ASelected     :string      read GetVAT1ASelected   write SetVAT1ASelected;
    property VAT2A            :Double       read GetVAT2A           write SetVAT2A        ;
    property VAT2ASelected    :String       read GetVAT2ASelected   write SetVAT2ASelected;
    property VAT4A            :Double       read GetVAT4A           write SetVAT4A        ;
    property VAT10            :Double       read GetVAT10           write SetVAT10        ;
    property VAT10Selected    :String       read GetVAT10Selected   write SetVAT10Selected;
    property VAT11            :Double       read GetVAT11           write SetVAT11        ;
    property VAT12            :Double       read GetVAT12           write SetVAT12        ;
    property VAT12ASelected   :String       read GetVAT12Selected   write SetVAT12Selected;

    property HasTab2          :Boolean      read GetHasTab2         write SetHasTab2;
    property Tab2Month        :String       read GetTab2Month       write SetTab2Month;
    property Tab2Type         :String       read GetTab2Type        write SetTab2Type;
    property Tab2Year         :Integer      read GetTab2Year        write SetTab2Year;
    property VAT14            :Double       read GetVAT14           write SetVAT14       ;
    property VAT14Selected    :String       read GetVAT14Selected   write SetVAT14Selected;
    property VAT14A           :Double       read GetVAT14A          write SetVAT14A       ;
    property VAT14ASelected   :String       read GetVAT14ASelected  write SetVAT14ASelected;
    property VAT15            :Double       read GetVAT15           write SetVAT15       ;
    property VAT15Selected    :String       read GetVAT15Selected   write SetVAT15Selected;
    property VAT15A           :Double       read GetVAT15A          write SetVAT15A       ;
    property VAT15ASelected   :String       read GetVAT15ASelected  write SetVAT15ASelected;
    property VAT16            :Double       read GetVAT16           write SetVAT16       ;
    property VAT16Selected    :String       read GetVAT16Selected   write SetVAT16Selected;
    property VAT17            :Double       read GetVAT17           write SetVAT17       ;
    property VAT17Selected    :String       read GetVAT17Selected   write SetVAT17Selected;
    property VAT18            :Double       read GetVAT18           write SetVAT18       ;
    property VAT18Selected    :String       read GetVAT18Selected   write SetVAT18Selected;

    property HasTab3          :Boolean      read GetHasTab3         write SetHasTab3;
    property Tab3Month        :String       read GetTab3Month       write SetTab3Month;
    property Tab3Type         :String       read GetTab3Type        write SetTab3Type;
    property Tab3Year         :Integer      read GetTab3Year        write SetTab3Year;
    property VAT21            :Double       read GetVAT21           write SetVAT21       ;
    property VAT21Selected    :String       read GetVAT21Selected   write SetVAT21Selected;
    property VAT22            :Double       read GetVAT22           write SetVAT22       ;
    property VAT22Selected    :String       read GetVAT22Selected   write SetVAT22Selected;
    property VAT23Per         :Double       read GetVAT23Per        write SetVAT23Per     ;
    property VAT24Per         :Double       read GetVAT24Per        write SetVAT24Per;
    property VAT26            :Double       read GetVAT26           write SetVAT26;
    property VAT26Selected    :String       read GetVAT26Selected   write SetVAT26Selected;
    property VAT27            :Double       read GetVAT27           write SetVAT27;
    property VAT27Selected    :String       read GetVAT27Selected   write SetVAT27Selected;
    property VAT28Per         :Double       read GetVAT28Per        write SetVAT28Per;
    property VAT30            :Double       read GetVAT30           write SetVAT30;
    property VAT30Selected    :String       read GetVAT30Selected   write SetVAT30Selected;
    property VAT31            :Double       read GetVAT31           write SetVAT31;
    property VAT31Selected    :String       read GetVAT31Selected   write SetVAT31Selected;
    property VAT32Per         :Double       read GetVAT32Per        write SetVAT32Per;
    property VAT34            :Double       read GetVAT34           write SetVAT34;
    property VAT34Selected    :String       read GetVAT34Selected   write SetVAT34Selected;
    property VAT35            :Double       read GetVAT35           write SetVAT35;
    property VAT35Selected    :String       read GetVAT35Selected   write SetVAT35Selected;
    property VAT36Per         :Double       read GetVAT36Per        write SetVAT36Per;

    property HasTab4          :Boolean      read GetHasTab4         write SetHasTab4;
    property HasTab5          :Boolean      read GetHasTab5         write SetHasTab5;
    property PaymentRefNo     :String       read GetPaymentRefNo    write SetPaymentRefNo;
    property PenaltyInterest  :Double       read GetPenaltyInterest write SetPenaltyInterest;
  end;

implementation

uses
  CommonLib, sysutils, {$IFDEF GUIAPP}ReturnObj,{$ENDIF} dateutils, AppEnvironment, CommonDbLib,
  BusObjConst, tcConst, ErpDbComponents;

 {TVATReturns}

Constructor TVATReturns.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'VATReturn';
  fSQL := 'SELECT * FROM tblvatreturns';
end;


Destructor TVATReturns.Destroy;
begin
  inherited;
end;


Procedure TVATReturns.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'VATDesc');
  SetPropertyFromNode(node,'VATType');
  SetPropertyFromNode(node,'Month');
  SetPropertyFromNode(node,'Year');
  SetPropertyFromNode(node,'AccMethod');
  SetPropertyFromNode(node,'AllClass');
  SetPropertyFromNode(node,'ClassID');
  SetPropertyFromNode(node,'VAT1');
  SetPropertyFromNode(node,'VAT1Selected');
  SetPropertyFromNode(node,'VAT2');
  SetPropertyFromNode(node,'VAT2Selected');
  SetPropertyFromNode(node,'VAT3');
  SetPropertyFromNode(node,'VAT3Selected');
  SetPropertyFromNode(node,'VAT4');
  SetPropertyFromNode(node,'VAT4Selected');
  SetPropertyFromNode(node,'VAT5');
  SetPropertyFromNode(node,'VAT5Selected');
  SetPropertyFromNode(node,'VAT6');
  SetPropertyFromNode(node,'VAT6Selected');
  SetPropertyFromNode(node,'VAT7');
  SetPropertyFromNode(node,'VAT7Selected');
  SetPropertyFromNode(node,'VAT8');
  SetPropertyFromNode(node,'VAT8Selected');
  SetPropertyFromNode(node,'VAT9');
  SetPropertyFromNode(node,'VAT9Selected');
end;


procedure TVATReturns.NextReturn(ReturnPage: TReturnPage; Changetype:boolean =True);
var
  dtFrom , dtTo:TDatetime;
  stype:String;
begin
  if LastReturn(dtFrom, dtTo,  sType , ReturnPage) then begin
    Dtfrom := incDay(dtTo);

    if Dtfrom <= Appenv.Companyprefs.SummarisedTransDate then Dtfrom := incDay(Dtfrom);
    if Changetype or (VatType = '') then VATtype := stype;
    Month:= MonthnumberToName(monthof(DtFrom));
    Year := yearof(dtFrom);
    postdb;
  end else begin
    if Changetype or (VatType = '') then VatType := tPTQuarterly;
    Month:=  MonthOfcurrent(VatType);
    year := yearof(now);
    postdb;
  end;
end;

Procedure TVATReturns.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'VATDesc' ,VATDesc);
  AddXMLNode(node,'VATType' ,VATType);
  AddXMLNode(node,'Month' ,Month);
  AddXMLNode(node,'Year' ,Year);
  AddXMLNode(node,'AccMethod' ,AccMethod);
  AddXMLNode(node,'AllClass' ,AllClass);
  AddXMLNode(node,'ClassID' ,ClassID);
  AddXMLNode(node,'VAT1' ,VAT1);
  AddXMLNode(node,'VAT1Selected' ,VAT1Selected);
  AddXMLNode(node,'VAT2' ,VAT2);
  AddXMLNode(node,'VAT2Selected' ,VAT2Selected);
  AddXMLNode(node,'VAT3' ,VAT3);
  AddXMLNode(node,'VAT3Selected' ,VAT3Selected);
  AddXMLNode(node,'VAT4' ,VAT4);
  AddXMLNode(node,'VAT4Selected' ,VAT4Selected);
  AddXMLNode(node,'VAT5' ,VAT5);
  AddXMLNode(node,'VAT5Selected' ,VAT5Selected);
  AddXMLNode(node,'VAT6' ,VAT6);
  AddXMLNode(node,'VAT6Selected' ,VAT6Selected);
  AddXMLNode(node,'VAT7' ,VAT7);
  AddXMLNode(node,'VAT7Selected' ,VAT7Selected);
  AddXMLNode(node,'VAT8' ,VAT8);
  AddXMLNode(node,'VAT8Selected' ,VAT8Selected);
  AddXMLNode(node,'VAT9' ,VAT9);
  AddXMLNode(node,'VAT9Selected' ,VAT9Selected);
end;


Function TVATReturns.ValidateData: Boolean ;
begin
  Result := Inherited ValidateData;
  if not result then exit;
  result := false;
  if Year = 0 then begin
    AddResult(False , rssError , 0,  'Year should not be 0', True);
    Exit;
  end;
  if (not Active) and Submitted then begin
    AddResult(False , rssError , 0,  'This Return has already been submitted, it can not be mad inactive.', True);
    Exit;
  end;

  (* if VAT1 = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'VAT1 should not be 0', True);
    REsult := False;
    Exit;
  end;
  if VAT2 = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'VAT2 should not be 0', True);
    REsult := False;
    Exit;
  end;
  if VAT3 = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'VAT3 should not be 0', True);
    REsult := False;
    Exit;
  end;
  if VAT4 = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'VAT4 should not be 0', True);
    REsult := False;
    Exit;
  end;
  if VAT5 = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'VAT5 should not be 0', True);
    REsult := False;
    Exit;
  end;
  if VAT6 = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'VAT6 should not be 0', True);
    REsult := False;
    Exit;
  end;
  if VAT7 = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'VAT7 should not be 0', True);
    REsult := False;
    Exit;
  end;
  if VAT8 = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'VAT8 should not be 0', True);
    REsult := False;
    Exit;
  end;
  if VAT9 = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'VAT9 should not be 0', True);
    REsult := False;
    Exit;
  end; *)
  Result := True;
end;


Function TVATReturns.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


Procedure TVATReturns.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  SendEvent(BusobjEvent_ToDo, BusobjEvent_IDChange, self);
end;

Function TVATReturns.ValidateDateRange:Boolean;
begin
  //REsult := DateRangeValid('Month' , 'Year' , 'type' ,   VAT_From ,VAT_TO);
  Result := TRue;
end;
Procedure TVATReturns.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if SameText(Sender.Fieldname , 'Type') then begin
    if not ValidateDateRange then CancelDB;
    SendEvent(BusobjEvent_ToDo, BusobjEvent_DateRangeChange, self);
  end else if SameText(Sender.Fieldname , 'Month') then begin
    if not ValidateDateRange then CancelDB;
    SendEvent(BusobjEvent_ToDo, BusobjEvent_DateRangeChange, self);
  end else if SameText(Sender.Fieldname , 'Year') then begin
    if not ValidateDateRange then CancelDB;
    SendEvent(BusobjEvent_ToDo, BusobjEvent_DateRangeChange, self);
  end;
end;


Function TVATReturns.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


function TVATReturns.GetSubmitted: boolean;
begin
  result := GetBooleanField('Submitted');
end;

Class Function TVATReturns.GetIDField: string;
begin
  Result := 'ID'
end;


function TVATReturns.getLines: TReturnLines;
begin
  REsult :=getVATReturnLines;
  if Self.SilentMode then Result.SilentMode := True;
end;

Class Function TVATReturns.GetBusObjectTablename: string;
begin
  Result:= 'tblvatreturns';
end;


function TVATReturns.DoAfterInsert(Sender: TDatasetBusobj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
  AllClass := True;
  NextReturn(tRPVAT);

  {Set Default From Las Record If One}
  With commonDBlib.TempMyQuery do   try
    Sql.Clear;
    Sql.Add('SELECT AccMethod, ID, VAT1Selected, VAT2Selected, VAT3Selected, VAT4Selected, ');
    Sql.Add('VAT5Selected, VAT6Selected, VAT7Selected, VAT8Selected, VAT9Selected ');
    Sql.Add('FROM tblvatreturns Where Active = "T" ');
    Sql.Add('ORDER BY ID DESC Limit 1;');
    Open;
    if (RecordCount > 0) then begin
      First;
      AccMethod     := FieldByname('AccMethod').asString;
      VAT1Selected  := FieldByName('VAT1Selected').AsString;
      VAT2Selected  := FieldByName('VAT2Selected').AsString;
      VAT3Selected  := FieldByName('VAT3Selected').AsString;
      VAT4Selected  := FieldByName('VAT4Selected').AsString;
      VAT5Selected  := FieldByName('VAT5Selected').AsString;
      VAT6Selected  := FieldByName('VAT6Selected').AsString;
      VAT7Selected  := FieldByName('VAT7Selected').AsString;
      VAT8Selected  := FieldByName('VAT8Selected').AsString;
      VAT9Selected  := FieldByName('VAT9Selected').AsString;
    end else begin
      VAT1Selected  := 'S,E';
      VAT2Selected  := 'EP,EZ';
      VAT4Selected  := 'S,E,Z';
      VAT6Selected  := 'S,E';
      VAT7Selected  := 'S,E,Z';
      VAT8Selected  := 'EP,EZ';
      VAT9Selected  := 'EP,EZ';
    end;
  finally
    ClosenFree;
  end;
end;

Function TVATReturns.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{Property Functions}
Function  TVATReturns.GetVATDesc: string; begin Result := GetStringField('VATDesc'); end;

function TVATReturns.GetVATReturnLines: TVATReturnLines;
begin
  Result := TVATReturnLines(getcontainercomponent(TVATReturnLines, 'VATID = ' + IntToStr(ID)));
end;

function TVATReturns.getVAT_From: TDate;
begin
  result := 0;
  if year = 0 then exit;
  if month = '' then exit;
  Result := EncodeDate(year ,MonthNameToNumber(Month) , 1);
end;

function TVATReturns.getVAT_To: TDate;
begin
  Result := 0;
  if year = 0 then exit;
  if month = '' then exit;
       if SameText(VATType , tPTMonthly)     then Result := incday(incMonth(VAT_from , 1) , -1)
  else if SameText(VATType , tPTQuarterly)   then Result := incday(incMonth(VAT_from , 3) , -1)
  else if SameText(VATType , tPTTwoMonthly) then Result := incday(incMonth(VAT_from , 2) , -1)
  else if SameText(VATType , tPTSixMonthly) then Result := incday(incMonth(VAT_from , 6) , -1)
  else result :=VAT_from;
end;

Function  TVATReturns.GetType        : string    ; begin Result := GetStringField('Type');end;
Function  TVATReturns.GetMonth       : string    ; begin Result := GetStringField('Month');end;

function TVATReturns.GetObligationID: integer;
begin
  result := GetIntegerField('ObligationID');
end;

function TVATReturns.GetPeriodKey: string;
var
  qry: TERPQuery;
begin
  result := '';
  if ObligationID > 0 then begin
    qry := TERPQuery.Create(nil);
    try
      qry.Connection := Connection.Connection;
      qry.SQL.Text := 'select * from tblVATObligations where ID = ' + IntToStr(ObligationID);
      qry.Open;
      result := qry.FieldByName('PeriodKey').AsString;
    finally
      qry.Free;
    end;
  end;
end;

Function  TVATReturns.GetYear        : Integer   ; begin Result := GetIntegerField('Year');end;
Function  TVATReturns.GetAccMethod   : string    ; begin Result := GetStringField('AccMethod');end;
Function  TVATReturns.GetAllClass    : Boolean   ; begin Result := GetBooleanField('AllClass');end;
Function  TVATReturns.GetClassID     : Integer   ; begin Result := GetIntegerField('ClassID');end;
function TVATReturns.getCodeFieldName: String;
begin
  Result := 'VATCode';
end;
function TVATReturns.getdescription: String;
begin
  Result := VATDesc;
end;

function TVATReturns.getHeaderIDFieldName: String;
begin
  Result := 'VATID';
end;
function TVATReturns.getHeaderDescfieldName: String;
begin
  Result := 'VATDesc';
end;

Function  TVATReturns.GetVAT1        : Double    ; begin Result := GetFloatField('VAT1');end;
Function  TVATReturns.GetVAT1Selected: string    ; begin Result := GetStringField('VAT1Selected');end;
Function  TVATReturns.GetVAT2        : Double    ; begin Result := GetFloatField('VAT2');end;
Function  TVATReturns.GetVAT2Selected: string    ; begin Result := GetStringField('VAT2Selected');end;
Function  TVATReturns.GetVAT3        : Double    ; begin Result := GetFloatField('VAT3');end;
Function  TVATReturns.GetVAT3Selected: string    ; begin Result := GetStringField('VAT3Selected');end;
Function  TVATReturns.GetVAT4        : Double    ; begin Result := GetFloatField('VAT4');end;
Function  TVATReturns.GetVAT4Selected: string    ; begin Result := GetStringField('VAT4Selected');end;
Function  TVATReturns.GetVAT5        : Double    ; begin Result := GetFloatField('VAT5');end;
Function  TVATReturns.GetVAT5Per     : Double    ; begin Result := GetFloatField('VAT5Per');end;
Function  TVATReturns.GetVAT5Selected: string    ; begin Result := GetStringField('VAT5Selected');end;
Function  TVATReturns.GetVAT6        : Double    ; begin Result := GetFloatField('VAT6');end;
Function  TVATReturns.GetVAT6Selected: string    ; begin Result := GetStringField('VAT6Selected');end;
Function  TVATReturns.GetVAT7        : Double    ; begin Result := GetFloatField('VAT7');end;
Function  TVATReturns.GetVAT7Selected: string    ; begin Result := GetStringField('VAT7Selected');end;
Function  TVATReturns.GetVAT8        : Double    ; begin Result := GetFloatField('VAT8');end;
Function  TVATReturns.GetVAT8Selected: string    ; begin Result := GetStringField('VAT8Selected');end;
Function  TVATReturns.GetVAT9        : Double    ; begin Result := GetFloatField('VAT9');end;
Function  TVATReturns.GetVAT9Selected: string    ; begin Result := GetStringField('VAT9Selected');end;
// Added for Roverto
function  TVATReturns.GetHasTab1:       Boolean;  begin Result := GetBooleanField('HasTab1'); end;
function  TVATReturns.GetTab1Month:     String;   begin Result := GetStringField('Tab1Month'); end;
function  TVATReturns.GetTab1Type:      String;   begin Result := GetStringField('Tab1Type');  end;
function  TVATReturns.GetTab1Year:      Integer;  begin Result := GetIntegerField('Tab1Year');  end;
function  TVATReturns.GetHasTab2:       Boolean;  begin Result := GetBooleanField('HasTab2'); end;
function  TVATReturns.GetTab2Month:     String;   begin Result := GetStringField('Tab2Month'); end;
function  TVATReturns.GetTab2Type:      String;   begin Result := GetStringField('Tab2Type');  end;
function  TVATReturns.GetTab2Year:      Integer;  begin Result := GetIntegerField('Tab2Year');  end;
function  TVATReturns.GetHasTab3:       Boolean;  begin Result := GetBooleanField('HasTab3'); end;
function  TVATReturns.GetTab3Month:     String;   begin Result := GetStringField('Tab3Month'); end;
function  TVATReturns.GetTab3Type:      String;   begin Result := GetStringField('Tab2Type');  end;
function  TVATReturns.GetTab3Year:      Integer;  begin Result := GetIntegerField('Tab3Year');  end;
function  TVATReturns.GetHasTab4:       Boolean;  begin Result := GetBooleanField('HasTab4'); end;
function  TVATReturns.GetHasTab5:       Boolean;  begin Result := GetBooleanField('HasTab5'); end;

function  TVATReturns.GetVAT1A:         Double; begin Result := GetFloatField('VAT1A');end;
function  TVATReturns.GetVAT1ASelected: String; begin Result := GetStringField('VAT1ASelected');end;
function  TVATReturns.GetVAT2A:         Double; begin Result := GetFloatField('VAT2A');end;
function  TVATReturns.GetVAT2ASelected: String; begin Result := GetStringField('VAT2ASelected');end;
function  TVATReturns.GetVAT4A:         Double; begin Result := GetFloatField('VAT4A');end;
function  TVATReturns.GetVAT10:         Double; begin Result := GetFloatField('VAT10');end;
function  TVATReturns.GetVAT10Selected: String; begin Result := GetStringField('VAT10Selected');end;
function  TVATReturns.GetVAT11:         Double; begin Result := GetFloatField('VAT11');end;
function  TVATReturns.GetVAT12:         Double; begin Result := GetFloatField('VAT12');end;
function  TVATReturns.GetVAT12Selected: String; begin Result := GetStringField('VAT12Selected');end;

function  TVATReturns.GetVAT14:           Double; begin Result := GetFloatField('VAT14');end;
function  TVATReturns.GetVAT14Selected:   String; begin Result := GetStringField('VAT14Selected');end;
function  TVATReturns.GetVAT14A:          Double; begin Result := GetFloatField('VAT14A');end;
function  TVATReturns.GetVAT14ASelected:  String; begin Result := GetStringField('VAT14ASelected');end;
function  TVATReturns.GetVAT15:           Double; begin Result := GetFloatField('VAT15');end;
function  TVATReturns.GetVAT15Selected:   String; begin Result := GetStringField('VAT15Selected');end;
function  TVATReturns.GetVAT15A:          Double; begin Result := GetFloatField('VAT15A');end;
function  TVATReturns.GetVAT15ASelected:  String; begin Result := GetStringField('VAT15ASelected');end;
function  TVATReturns.GetVAT16:         Double; begin Result := GetFloatField('VAT16');end;
function  TVATReturns.GetVAT16Selected: String; begin Result := GetStringField('VAT16Selected');end;
function  TVATReturns.GetVAT17:         Double; begin Result := GetFloatField('VAT17');end;
function  TVATReturns.GetVAT17Selected: String; begin Result := GetStringField('VAT17Selected');end;
function  TVATReturns.GetVAT18:         Double; begin Result := GetFloatField('VAT18');end;
function  TVATReturns.GetVAT18Selected: String; begin Result := GetStringField('VAT18Selected');end;

function  TVATReturns.GetVAT21:         Double; begin Result := GetFloatField('VAT21');end;
function  TVATReturns.GetVAT21Selected: String; begin Result := GetStringField('VAT21Selected');end;
function  TVATReturns.GetVAT22:         Double; begin Result := GetFloatField('VAT22');end;
function  TVATReturns.GetVAT22Selected: String; begin Result := GetStringField('VAT22Selected');end;
function  TVATReturns.GetVAT23Per:      Double; begin Result := GetFloatField('VAT23Per');end;
function  TVATReturns.GetVAT24Per:      Double; begin Result := GetFloatField('VAT24Per');end;
function  TVATReturns.GetVAT26:         Double; begin Result := GetFloatField('VAT26');end;
function  TVATReturns.GetVAT26Selected: String; begin Result := GetStringField('VAT26Selected');end;
function  TVATReturns.GetVAT27:         Double; begin Result := GetFloatField('VAT27');end;
function  TVATReturns.GetVAT27Selected: String; begin Result := GetStringField('VAT27Selected');end;
function  TVATReturns.GetVAT28Per:      Double; begin Result := GetFloatField('VAT28Per');end;
function  TVATReturns.GetVAT30:         Double; begin Result := GetFloatField('VAT30');end;
function  TVATReturns.GetVAT30Selected: String; begin Result := GetStringField('VAT30Selected');end;
function  TVATReturns.GetVAT31:         Double; begin Result := GetFloatField('VAT31');end;
function  TVATReturns.GetVAT31Selected: String; begin Result := GetStringField('VAT31Selected');end;
function  TVATReturns.GetVAT32Per:      Double; begin Result := GetFloatField('VAT32Per');end;
function  TVATReturns.GetVAT34:         Double; begin Result := GetFloatField('VAT34');end;
function  TVATReturns.GetVAT34Selected: String; begin Result := GetStringField('VAT34Selected');end;
function  TVATReturns.GetVAT35:         Double; begin Result := GetFloatField('VAT35');end;
function  TVATReturns.GetVAT35Selected: String; begin Result := GetStringField('VAT35Selected');end;
function  TVATReturns.GetVAT36Per:      Double; begin Result := GetFloatField('VAT36Per');end;

function  TVATReturns.GetPaymentRefNo:    String; begin Result := GetStringField('PaymentRefNo');   end;
function  TVATReturns.GetPenaltyInterest: Double; begin Result := GetFloatField('PenaltyInterest'); end;

Procedure TVATReturns.SetVATDesc     (const Value: string    ); begin SetStringField('VATDesc'      , Value);end;
Procedure TVATReturns.SetType        (const Value: string    ); begin SetStringField('Type'         , Value);end;
procedure TVATReturns.Setdescription(const Value: String);
begin
  inherited;
  VATDesc:= Value;
end;

Procedure TVATReturns.SetMonth       (const Value: string    ); begin SetStringField('Month'        , Value);end;

procedure TVATReturns.SetObligationID(const Value: integer);
begin
  SetIntegerField('ObligationID', Value);
end;

procedure TVATReturns.SetSubmitted(const Value: boolean);
begin
  SetBooleanField('Submitted',Value);
end;

Procedure TVATReturns.SetYear        (const Value: Integer   ); begin SetIntegerField('Year'       , Value);end;
Procedure TVATReturns.SetAccMethod   (const Value: string    ); begin SetStringField('AccMethod'   , Value);end;
Procedure TVATReturns.SetAllClass    (const Value: Boolean   ); begin SetBooleanField('AllClass'   , Value);end;
Procedure TVATReturns.setClassID     (const Value: Integer   ); begin SetIntegerField('ClassID'    , Value);end;
Procedure TVATReturns.SetVAT1        (const Value: Double    ); begin SetFloatField('VAT1'         , Value);end;
Procedure TVATReturns.SetVAT1Selected(const Value: string    ); begin SetStringField('VAT1Selected', Value);end;
Procedure TVATReturns.SetVAT2        (const Value: Double    ); begin SetFloatField('VAT2'         , Value);end;
Procedure TVATReturns.SetVAT2Selected(const Value: string    ); begin SetStringField('VAT2Selected', Value);end;
Procedure TVATReturns.SetVAT3        (const Value: Double    ); begin SetFloatField('VAT3'         , Value);end;
Procedure TVATReturns.SetVAT3Selected(const Value: string    ); begin SetStringField('VAT3Selected', Value);end;
Procedure TVATReturns.SetVAT4        (const Value: Double    ); begin SetFloatField('VAT4'         , Value);end;
Procedure TVATReturns.SetVAT4Selected(const Value: string    ); begin SetStringField('VAT4Selected', Value);end;
Procedure TVATReturns.SetVAT5        (const Value: Double    ); begin SetFloatField('VAT5'         , Value);end;
Procedure TVATReturns.SetVAT5Per     (const Value: Double    ); begin SetFloatField('VAT5Per'      , Value);end;
Procedure TVATReturns.SetVAT5Selected(const Value: string    ); begin SetStringField('VAT5Selected', Value);end;
Procedure TVATReturns.SetVAT6        (const Value: Double    ); begin SetFloatField('VAT6'         , Value);end;
Procedure TVATReturns.SetVAT6Selected(const Value: string    ); begin SetStringField('VAT6Selected', Value);end;
Procedure TVATReturns.SetVAT7        (const Value: Double    ); begin SetFloatField('VAT7'         , Value);end;
Procedure TVATReturns.SetVAT7Selected(const Value: string    ); begin SetStringField('VAT7Selected', Value);end;
Procedure TVATReturns.SetVAT8        (const Value: Double    ); begin SetFloatField('VAT8'         , Value);end;
Procedure TVATReturns.SetVAT8Selected(const Value: string    ); begin SetStringField('VAT8Selected', Value);end;
Procedure TVATReturns.SetVAT9        (const Value: Double    ); begin SetFloatField('VAT9'         , Value);end;
Procedure TVATReturns.SetVAT9Selected(const Value: string    ); begin SetStringField('VAT9Selected', Value);end;
// Added for Roverto
procedure TVATReturns.SetHasTab1(const Value: Boolean);       begin SetBooleanField('HasTab1', Value);      end;
procedure TVATReturns.SetTab1Month(const Value: String);      begin SetStringField('Tab1Month', Value);     end;
procedure TVATReturns.SetTab1Type(const Value: String);       begin SetStringField('Tab1Type', Value);      end;
procedure TVATReturns.SetTab1Year(const Value: Integer);      begin SetIntegerField('Tab1Year', Value);     end;
procedure TVATReturns.SetVAT1A(const Value: Double);          begin SetFloatField('VAT1A', Value);          end;
procedure TVATReturns.SetVAT1ASelected(const Value: String);  begin SetStringField('VAT1ASelected', Value); end;
procedure TVATReturns.SetVAT2A(const Value: Double);          begin SetFloatField('VAT2A', Value);          end;
procedure TVATReturns.SetVAT2ASelected(const Value: String);  begin SetStringField('VAT2ASelected', Value); end;
procedure TVATReturns.SetVAT4A(const Value: Double);          begin SetFloatField('VAT4A', Value);          end;
procedure TVATReturns.SetVAT10(const Value: Double);          begin SetFloatField('VAT10', Value);          end;
procedure TVATReturns.SetVAT10Selected(const Value: String);  begin SetStringField('VAT10Selected', Value); end;
procedure TVATReturns.SetVAT11(const Value: Double);          begin SetFloatField('VAT11', Value);          end;
procedure TVATReturns.SetVAT12(const Value: Double);          begin SetFloatField('VAT12', Value);          end;
procedure TVATReturns.SetVAT12Selected(const Value: String);  begin SetStringField('VAT12Selected', Value); end;

procedure TVATReturns.SetHasTab2(const Value: Boolean); begin SetBooleanField('HasTab2', Value);    end;
procedure TVATReturns.SetTab2Month(const Value: String); begin SetStringField('Tab2Month', Value);  end;
procedure TVATReturns.SetTab2Type(const Value: String); begin SetStringField('Tab2Type', Value);  end;
procedure TVATReturns.SetTab2Year(const Value: Integer); begin SetIntegerField('Tab2Year', Value);  end;
procedure TVATReturns.SetVAT14(const Value: Double);          begin SetFloatField('VAT14', Value);          end;
procedure TVATReturns.SetVAT14Selected(const Value: String);  begin SetStringField('VAT14Selected', Value); end;
procedure TVATReturns.SetVAT14A(const Value: Double);          begin SetFloatField('VAT14A', Value);          end;
procedure TVATReturns.SetVAT14ASelected(const Value: String);  begin SetStringField('VAT14ASelected', Value); end;
procedure TVATReturns.SetVAT15(const Value: Double);          begin SetFloatField('VAT15', Value);          end;
procedure TVATReturns.SetVAT15Selected(const Value: String);  begin SetStringField('VAT15Selected', Value); end;
procedure TVATReturns.SetVAT15A(const Value: Double);          begin SetFloatField('VAT15A', Value);          end;
procedure TVATReturns.SetVAT15ASelected(const Value: String);  begin SetStringField('VAT15ASelected', Value); end;
procedure TVATReturns.SetVAT16(const Value: Double);          begin SetFloatField('VAT16', Value);          end;
procedure TVATReturns.SetVAT16Selected(const Value: String);  begin SetStringField('VAT16Selected', Value); end;
procedure TVATReturns.SetVAT17(const Value: Double);          begin SetFloatField('VAT17', Value);          end;
procedure TVATReturns.SetVAT17Selected(const Value: String);  begin SetStringField('VAT17Selected', Value); end;
procedure TVATReturns.SetVAT18(const Value: Double);          begin SetFloatField('VAT18', Value);          end;
procedure TVATReturns.SetVAT18Selected(const Value: String);  begin SetStringField('VAT18Selected', Value); end;

procedure TVATReturns.SetHasTab3(const Value: Boolean);       begin SetBooleanField('HasTab3', Value);      end;
procedure TVATReturns.SetTab3Month(const Value: String);      begin SetStringField('Tab3Month', Value);     end;
procedure TVATReturns.SetTab3Type(const Value: String);       begin SetStringField('Tab3Type', Value);      end;
procedure TVATReturns.SetTab3Year(const Value: Integer);      begin SetIntegerField('Tab3Year', Value);     end;
procedure TVATReturns.SetHasTab4(const Value: Boolean);       begin SetBooleanField('HasTab4', Value);      end;
procedure TVATReturns.SetHasTab5(const Value: Boolean);       begin SetBooleanField('HasTab5', Value);      end;
procedure TVATReturns.SetVAT21(const Value: Double);          begin SetFloatField('VAT21', Value);          end;
procedure TVATReturns.SetVAT21Selected(const Value: String);  begin SetStringField('VAT21Selected', Value); end;
procedure TVATReturns.SetVAT22(const Value: Double);          begin SetFloatField('VAT22', Value);          end;
procedure TVATReturns.SetVAT22Selected(const Value: String);  begin SetStringField('VAT22Selected', Value); end;
procedure TVATReturns.SetVAT23Per(const Value: Double);       begin SetFloatField('VAT23Per', Value);       end;
procedure TVATReturns.SetVAT24Per(const Value: Double);       begin SetFloatField('VAT24Per', Value);       end;
procedure TVATReturns.SetVAT26(const Value: Double);          begin SetFloatField('VAT26', Value);          end;
procedure TVATReturns.SetVAT26Selected(const Value: String);  begin SetStringField('VAT26Selected', Value); end;
procedure TVATReturns.SetVAT27(const Value: Double);          begin SetFloatField('VAT27', Value);          end;
procedure TVATReturns.SetVAT27Selected(const Value: String);  begin SetStringField('VAT27Selected', Value); end;
procedure TVATReturns.SetVAT28Per(const Value: Double);       begin SetFloatField('VAT28', Value);          end;
procedure TVATReturns.SetVAT30(const Value: Double);          begin SetFloatField('VAT30', Value);          end;
procedure TVATReturns.SetVAT30Selected(const Value: String);  begin SetStringField('VAT30Selected', Value); end;
procedure TVATReturns.SetVAT31(const Value: Double);          begin SetFloatField('VAT31', Value);          end;
procedure TVATReturns.SetVAT31Selected(const Value: String);  begin SetStringField('VAT31Selected', Value); end;
procedure TVATReturns.SetVAT32Per(const Value: Double);       begin SetFloatField('VAT32Per', Value);       end;
procedure TVATReturns.SetVAT34(const Value: Double);          begin SetFloatField('VAT34', Value);          end;
procedure TVATReturns.SetVAT34Selected(const Value: String);  begin SetStringField('VAT34Selected', Value); end;
procedure TVATReturns.SetVAT35(const Value: Double);          begin SetFloatField('VAT35', Value);          end;
procedure TVATReturns.SetVAT35Selected(const Value: String);  begin SetStringField('VAT35Selected', Value); end;
procedure TVATReturns.SetVAT36Per(const Value: Double);       begin SetFloatField('VAT36', Value);          end;

procedure TVATReturns.SetPaymentRefNo(const Value: String);     begin SetStringField('PaymentRefNo', Value);   end;
procedure TVATReturns.SetPenaltyInterest(const Value: Double);  begin SetFloatField('PenaltyInterest', Value); end;


{ TVATReturnLines }
constructor TVATReturnLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'VATReturnLine';
  fSQL := 'SELECT * FROM tblvatreportlines';
end;

class function TVATReturnLines.GetBusObjectTablename: string;
begin
  REsult := 'tblvatreportlines';
end;

function TVATReturnLines.GetReportCode: string ;begin Result := GetStringField('VATCode') ;end;
function TVATReturnLines.GetReportID  : Integer;begin REsult := getIntegerField('VATID')  ;end;
procedure TVATReturnLines.SetReportCode(const Value: string) ;begin SetStringField('VATCODE' , value);end;
procedure TVATReturnLines.SetReportID  (const Value: Integer);begin SetIntegerfield('VATID'  , Value);end;


initialization
  RegisterClassOnce(TVATReturns);


end.
