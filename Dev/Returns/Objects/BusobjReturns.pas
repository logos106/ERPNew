unit BusobjReturns;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  18/01/12  1.00.00  A.  Initial Version.
  }


interface

uses BusObjBase, DB, Classes, XMLIntf;

{$IFNDEF GUIAPP}
const
  tPTMonthly    = 'Monthly';
  tPTTwoMonthly = 'Two Monthly';
  tPTQuarterly  = 'Quarterly';
  tPTSixMonthly  = 'Six Monthly';
{$ENDIF}

type
  TReturnPage = (tRPBasTab1 = 1, tRPBASTab2 = 2, tRPBASTab3 = 3, tRPBASTab4 = 4, TRPNZ = 5, tRPVAT = 6);

  TReturnLines = class(TMSBusObj)
  private
    function GetTransGlobalref    : string    ;
    function GetTranstype         : string    ;
    function GetTransSeqno        : Integer   ;
    function GetAmount            : Double    ;
    function GetTransDate         : Tdatetime;
    procedure SetTransGlobalref    (const Value: string    );
    procedure SetTranstype         (const Value: string    );
    procedure SetTransSeqno        (const Value: Integer   );
    procedure SetAmount            (const Value: Double    );
    Procedure SetTransDate         (Const Value: TdateTime);
  protected
    function GetReportID          : Integer   ;Virtual;abstract;
    function GetReportCode        : string    ;Virtual;abstract;

    procedure SetReportID          (const Value: Integer   );Virtual;abstract;
    procedure SetReportCode        (const Value: string    );Virtual;abstract;

    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
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
    property ReportID           :Integer     read GetReportID         write SetReportID       ;
    property TransGlobalref     :string      read GetTransGlobalref   write SetTransGlobalref;
    property Transtype          :string      read GetTranstype        write SetTranstype     ;
    property TransSeqno         :Integer     read GetTransSeqno       write SetTransSeqno    ;
    property ReportCode         :string      read GetReportCode       write SetReportCode       ;
    property Amount             :Double      read GetAmount           write SetAmount        ;
    Property TransDate          :TDateTime   read GetTransDate        write setTransDate;
  end;

  TBASReturnLines = class(TReturnLines)
    Private
    Protected
      function GetReportID          : Integer   ;Override;
      function GetReportCode        : string    ;Override;
      procedure SetReportID          (const Value: Integer   );Override;
      procedure SetReportCode        (const Value: string    );Override;
    Public
  end;

  TNZReturnLines = class(TReturnLines)
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

  TReturns = class(TMSBusObj)
    Private
      function GetDone: Boolean;
      procedure SetDone(const Value: Boolean);
      function GetActive: Boolean;
      procedure SetActive(const Value: Boolean);
      function getSumTransDate: TDatetime;
      procedure setSumTransDate(const Value: TDatetime);
    Protected
      function getLines: TReturnLines;Virtual;abstract;
      function GetAccMethod       : string    ;Virtual;abstract;
      procedure SetAccMethod       (const Value: string    );Virtual;abstract;
      function GetClassID         : Integer   ;Virtual;abstract;
      procedure SetClassID         (const Value: Integer   );Virtual;abstract;
      function GetAllClass        : Boolean   ;Virtual;abstract;
      procedure SetAllClass        (const Value: Boolean   );Virtual;abstract;
      function getCodeFieldName: String;Virtual;
      function getHeaderIDFieldName: String;Virtual;
      function getHeaderDescfieldName: String;Virtual;
      function MonthOfCurrent(Period:String):String;
      function DateFromSQL(MonthfieldNAme, yearfieldname :String):String;
      function DateToSQL(MonthfieldNAme, yearfieldname,typefieldName: String): String;
      Function DateRangeValid(const MonthfieldName:String; const YearFieldName:String; const typefieldName:String; Const DateFrom :TDatetime; const DateTo:TDatetime):Boolean;
      function getdescription: String; virtual;
      procedure Setdescription(const Value: String);virtual;
      function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
      function  DoBeforePost(Sender:TDatasetBusObj) : Boolean;            override;

    Public
      procedure    SaveToXMLNode(const node: IXMLNode);                   override;
      procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
      Procedure DeleteAllLines(sCode:String);
      Property CodeFieldName :String read getCodeFieldName;
      Property HeaderIDFieldName :String read getHeaderIDFieldName;
      Property HeaderDescfieldName :String read getHeaderDescfieldName;
      function MonthNameToNumber(const Month: string): integer;
      function MonthNumberToName(const Month: Integer): String;
      Function LastReturn(var ReturnFrom :TDatetime ; Var Returnto:Tdatetime; var  Retunrtype:String;  ReturnPage :TReturnPage):Boolean;
      Function ValidateData:Boolean; override;
      Property Description :String read getdescription write Setdescription;
      procedure NextReturn(ReturnPage: TReturnPage; Changetype: boolean = True);Virtual;

    Published
      Property Lines :TReturnLines read getLines;
      property AccMethod        :string      read GetAccMethod      write SetAccMethod   ;
      property ClassID          :Integer     read GetClassID        write SetClassID     ;
      property AllClass         :Boolean     read GetAllClass       write SetAllClass    ;
      Property Done             :Boolean     Read GetDone           Write SetDone;
      property Active           :Boolean     read GetActive         write SetActive      ;
      Property SumTransDate    :TDatetime   read getSumTransDate    write setSumTransDate;

  end;

  TBASReturn = class(TReturns)
  private
    FromDate: TDateTime;
    ToDate: TDateTime;
    FromName: String;

    function GetTab1_Type       : string    ;
    function GetTab1_Month      : string    ;
    function GetTab1_Year       : Integer   ;
    function GetBasSheetDesc    : string    ;
    function GetG1              : Double    ;
    function GetG1Selected      : string    ;
    function GetG2              : Double    ;
    function GetG2Selected      : string    ;
    function GetG3              : Double    ;
    function GetG3Selected      : string    ;
    function GetG4              : Double    ;
    function GetG4Selected      : string    ;
    function GetG5              : Double    ;
    function GetG6              : Double    ;
    function GetG7              : Double    ;
    function GetG7Selected      : string    ;
    function GetG8              : Double    ;
    function GetG9              : Double    ;
    function GetG10             : Double    ;
    function GetG10Selected     : string    ;
    function GetG11             : Double    ;
    function GetG11Selected     : string    ;
    function GetG12             : Double    ;
    function GetG13             : Double    ;
    function GetG13Selected     : string    ;
    function GetG14             : Double    ;
    function GetG14Selected     : string    ;
    function GetG15             : Double    ;
    function GetG15Selected     : string    ;
    function GetG16             : Double    ;
    function GetG17             : Double    ;
    function GetG18             : Double    ;
    function GetG18Selected     : string    ;
    function GetG19             : Double    ;
    function GetG20             : Double    ;
    function GetTab2_Type       : string    ;
    function GetTab2_Month      : string    ;
    function GetTab2_Year       : Integer   ;
    function GetW1              : Double    ;
    function GetW1Selected      : string    ;
    function GetW2              : Double    ;
    function GetW2Selected      : string    ;
    function GetW3              : Double    ;
    function GetW3Selected      : string    ;
    function GetW4              : Double    ;
    function GetW4Selected      : string    ;
    function GetT1              : Double    ;
    function GetT1Selected      : string    ;
    function GetT2              : Double    ;
    function GetT3              : Double    ;
    function GetT4              : string    ;
    function GetF1              : Double    ;
    function GetF2              : Double    ;
    function GetF3              : Double    ;
    function GetF4              : string    ;
    function Get_1A             : Double    ;
    function Get_1B             : Double    ;
    function Get_1C             : Double    ;
    function Get_1CSelected     : string    ;
    function Get_1D             : Double    ;
    function Get_1DSelected     : string    ;
    function Get_1E             : Double    ;
    function Get_1ESelected     : string    ;
    function Get_1F             : Double    ;
    function Get_1FSelected     : string    ;
    function Get_1G             : Double    ;
    function Get_1GSelected     : string    ;
    function Get_2A             : Double    ;
    function Get_2B             : Double    ;
    function Get_3              : Double    ;
    function Get_4              : Double    ;
    function Get_5A             : Double    ;
    function Get_5B             : Double    ;
    function Get_6A             : Double    ;
    function Get_6B             : Double    ;
    function Get_7              : Double    ;
    function Get_7D             : Double    ;
    function Get_7DSelected     : string    ;
    function Get_8A             : Double    ;
    function Get_8B             : Double    ;
    function Get_9              : Double    ;
    function GetTab3_Type       : string    ;
    function GetTab3_Month      : string    ;
    function GetTab3_Year       : Integer   ;
    function GetTab4_Type       : string    ;
    function GetTab4_Month      : string    ;
    function GetTab4_Year       : Integer   ;
    function GetHAsTab1         : Boolean;
    function GetHasTab2         : Boolean;
    function GetHasTab3         : Boolean;
    function GetHasTab4         : Boolean;
    procedure SetTab1_Type       (const Value: string    );
    procedure SetTab1_Month      (const Value: string    );
    procedure SetTab1_Year       (const Value: Integer   );
    procedure SetBasSheetDesc    (const Value: string    );
    procedure SetG1              (const Value: Double    );
    procedure SetG1Selected      (const Value: string    );
    procedure SetG2              (const Value: Double    );
    procedure SetG2Selected      (const Value: string    );
    procedure SetG3              (const Value: Double    );
    procedure SetG3Selected      (const Value: string    );
    procedure SetG4              (const Value: Double    );
    procedure SetG4Selected      (const Value: string    );
    procedure SetG5              (const Value: Double    );
    procedure SetG6              (const Value: Double    );
    procedure SetG7              (const Value: Double    );
    procedure SetG7Selected      (const Value: string    );
    procedure SetG8              (const Value: Double    );
    procedure SetG9              (const Value: Double    );
    procedure SetG10             (const Value: Double    );
    procedure SetG10Selected     (const Value: string    );
    procedure SetG11             (const Value: Double    );
    procedure SetG11Selected     (const Value: string    );
    procedure SetG12             (const Value: Double    );
    procedure SetG13             (const Value: Double    );
    procedure SetG13Selected     (const Value: string    );
    procedure SetG14             (const Value: Double    );
    procedure SetG14Selected     (const Value: string    );
    procedure SetG15             (const Value: Double    );
    procedure SetG15Selected     (const Value: string    );
    procedure SetG16             (const Value: Double    );
    procedure SetG17             (const Value: Double    );
    procedure SetG18             (const Value: Double    );
    procedure SetG18Selected     (const Value: string    );
    procedure SetG19             (const Value: Double    );
    procedure SetG20             (const Value: Double    );
    procedure SetTab2_Type       (const Value: string    );
    procedure SetTab2_Month      (const Value: string    );
    procedure SetTab2_Year       (const Value: Integer   );
    procedure SetW1              (const Value: Double    );
    procedure SetW1Selected      (const Value: string    );
    procedure SetW2              (const Value: Double    );
    procedure SetW2Selected      (const Value: string    );
    procedure SetW3              (const Value: Double    );
    procedure SetW3Selected      (const Value: string    );
    procedure SetW4              (const Value: Double    );
    procedure SetW4Selected      (const Value: string    );
    procedure SetT1              (const Value: Double    );
    procedure SetT1Selected      (const Value: string    );
    procedure SetT2              (const Value: Double    );
    procedure SetT3              (const Value: Double    );
    procedure SetT4              (const Value: string    );
    procedure SetF1              (const Value: Double    );
    procedure SetF2              (const Value: Double    );
    procedure SetF3              (const Value: Double    );
    procedure SetF4              (const Value: string    );
    procedure Set_1A             (const Value: Double    );
    procedure Set_1B             (const Value: Double    );
    procedure Set_1C             (const Value: Double    );
    procedure Set_1CSelected     (const Value: string    );
    procedure Set_1D             (const Value: Double    );
    procedure Set_1DSelected     (const Value: string    );
    procedure Set_1E             (const Value: Double    );
    procedure Set_1ESelected     (const Value: string    );
    procedure Set_1F             (const Value: Double    );
    procedure Set_1FSelected     (const Value: string    );
    procedure Set_1G             (const Value: Double    );
    procedure Set_1GSelected     (const Value: string    );
    procedure Set_2A             (const Value: Double    );
    procedure Set_2B             (const Value: Double    );
    procedure Set_3              (const Value: Double    );
    procedure Set_4              (const Value: Double    );
    procedure Set_5A             (const Value: Double    );
    procedure Set_5B             (const Value: Double    );
    procedure Set_6A             (const Value: Double    );
    procedure Set_6B             (const Value: Double    );
    procedure Set_7              (const Value: Double    );
    procedure Set_7D             (const Value: Double    );
    procedure Set_7DSelected     (const Value: string    );
    procedure Set_8A             (const Value: Double    );
    procedure Set_8B             (const Value: Double    );
    procedure Set_9              (const Value: Double    );

    procedure SetTab3_Type       (const Value: string    );
    procedure SetTab3_Month      (const Value: string    );
    procedure SetTab3_Year       (const Value: Integer   );
    procedure SetTab4_Type       (const Value: string    );
    procedure SetTab4_Month      (const Value: string    );
    procedure SetTab4_Year       (const Value: Integer   );
    Procedure SetHasTab1         (Const Value: Boolean   );
    Procedure SetHasTab2         (Const Value: Boolean   );
    Procedure SetHasTab3         (Const Value: Boolean   );
    Procedure SetHasTab4         (Const Value: Boolean   );

    function geTBASReturnLines: TBASReturnLines;

    function GetTab1_From:  TDate;
    function GetTab1_To:    TDate;
    function GetTab2_From:  TDate;
    function GetTab2_To:    TDate;
    function GetTab3_From:  TDate;
    function GetTab3_To:    TDate;
    function GetTab4_From:  TDate;
    function GetTab4_To:    TDate;

    function ValidateTab1DateRange: Boolean;
    function ValidateTab2DateRange: Boolean;
    function ValidateTab3DateRange: Boolean;
    function ValidateTab4DateRange: Boolean;

    procedure InitPeriod;
    (* function NextPeriodFrom(stype: String; dtFrom: TDatetime): TDatetime; *)
    (*function PreviousPeriodFrom(stype: String; dtFrom: TDatetime): TDatetime;*)

    procedure Silent_OpenTaxSelect(AFromName: String; const ATab: Integer);
    procedure Calc;
    function TaxAmounts: Double;
    function AccountAmounts: Double;

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusobj):Boolean;             Override;
    function  GetLines: TReturnLines;Override;
    function  GetAccMethod       : string    ;override;
    procedure SetAccMethod       (const Value: string    );override;
    function  GetClassID         : Integer   ;override;
    procedure SetClassID         (const Value: Integer   );override;
    function  GetAllClass         : Boolean   ;override;
    procedure SetAllClass         (const Value: Boolean   );override;

    function  GetCodeFieldName: String;Override;
    function  GetHeaderIDFieldName: String;Override;
    function  GetHeaderDescfieldName: String;Override;
    function  Getdescription: String; Override;
    procedure Setdescription(const Value: String);Override;

  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Property Tab1_From :TDate read GetTab1_From;
    Property Tab1_To :TDate read GetTab1_To;
    Property Tab2_From :TDate read GetTab2_From;
    Property Tab2_To :TDate read GetTab2_To;
    Property Tab3_From :TDate read GetTab3_From;
    Property Tab3_To :TDate read GetTab3_To;
    Property Tab4_From :TDate read GetTab4_From;
    Property Tab4_To :TDate read GetTab4_To;
    procedure NextReturn(ReturnPage: TReturnPage; Changetype: Boolean = True); Override;

  published
    property Tab1_Type        :string      read GetTab1_Type      write SetTab1_Type   ;
    property Tab1_Month       :string      read GetTab1_Month     write SetTab1_Month  ;
    property Tab1_Year        :Integer     read GetTab1_Year      write SetTab1_Year   ;
    property BasSheetDesc     :string      read GetBasSheetDesc   write SetBasSheetDesc;
    property G1               :Double      read GetG1             write SetG1          ;
    property G1Selected       :string      read GetG1Selected     write SetG1Selected  ;
    property G2               :Double      read GetG2             write SetG2          ;
    property G2Selected       :string      read GetG2Selected     write SetG2Selected  ;
    property G3               :Double      read GetG3             write SetG3          ;
    property G3Selected       :string      read GetG3Selected     write SetG3Selected  ;
    property G4               :Double      read GetG4             write SetG4          ;
    property G4Selected       :string      read GetG4Selected     write SetG4Selected  ;
    property G5               :Double      read GetG5             write SetG5          ;
    property G6               :Double      read GetG6             write SetG6          ;
    property G7               :Double      read GetG7             write SetG7          ;
    property G7Selected       :string      read GetG7Selected     write SetG7Selected  ;
    property G8               :Double      read GetG8             write SetG8          ;
    property G9               :Double      read GetG9             write SetG9          ;
    property G10              :Double      read GetG10            write SetG10         ;
    property G10Selected      :string      read GetG10Selected    write SetG10Selected ;
    property G11              :Double      read GetG11            write SetG11         ;
    property G11Selected      :string      read GetG11Selected    write SetG11Selected ;
    property G12              :Double      read GetG12            write SetG12         ;
    property G13              :Double      read GetG13            write SetG13         ;
    property G13Selected      :string      read GetG13Selected    write SetG13Selected ;
    property G14              :Double      read GetG14            write SetG14         ;
    property G14Selected      :string      read GetG14Selected    write SetG14Selected ;
    property G15              :Double      read GetG15            write SetG15         ;
    property G15Selected      :string      read GetG15Selected    write SetG15Selected ;
    property G16              :Double      read GetG16            write SetG16         ;
    property G17              :Double      read GetG17            write SetG17         ;
    property G18              :Double      read GetG18            write SetG18         ;
    property G18Selected      :string      read GetG18Selected    write SetG18Selected ;
    property G19              :Double      read GetG19            write SetG19         ;
    property G20              :Double      read GetG20            write SetG20         ;
    property Tab2_Type        :string      read GetTab2_Type      write SetTab2_Type   ;
    property Tab2_Month       :string      read GetTab2_Month     write SetTab2_Month  ;
    property Tab2_Year        :Integer     read GetTab2_Year      write SetTab2_Year   ;
    property W1               :Double      read GetW1             write SetW1          ;
    property W1Selected       :string      read GetW1Selected     write SetW1Selected  ;
    property W2               :Double      read GetW2             write SetW2          ;
    property W2Selected       :string      read GetW2Selected     write SetW2Selected  ;
    property W3               :Double      read GetW3             write SetW3          ;
    property W3Selected       :string      read GetW3Selected     write SetW3Selected  ;
    property W4               :Double      read GetW4             write SetW4          ;
    property W4Selected       :string      read GetW4Selected     write SetW4Selected  ;
    property T1               :Double      read GetT1             write SetT1          ;
    property T1Selected       :string      read GetT1Selected     write SetT1Selected  ;
    property T2               :Double      read GetT2             write SetT2          ;
    property T3               :Double      read GetT3             write SetT3          ;
    property T4               :string      read GetT4             write SetT4          ;
    property F1               :Double      read GetF1             write SetF1          ;
    property F2               :Double      read GetF2             write SetF2          ;
    property F3               :Double      read GetF3             write SetF3          ;
    property F4               :string      read GetF4             write SetF4          ;
    property _1A              :Double      read Get_1A            write Set_1A         ;
    property _1B              :Double      read Get_1B            write Set_1B         ;
    property _1C              :Double      read Get_1C            write Set_1C         ;
    property _1CSelected      :string      read Get_1CSelected    write Set_1CSelected ;
    property _1D              :Double      read Get_1D            write Set_1D         ;
    property _1DSelected      :string      read Get_1DSelected    write Set_1DSelected ;
    property _1E              :Double      read Get_1E            write Set_1E         ;
    property _1ESelected      :string      read Get_1ESelected    write Set_1ESelected ;
    property _1F              :Double      read Get_1F            write Set_1F         ;
    property _1FSelected      :string      read Get_1FSelected    write Set_1FSelected ;
    property _1G              :Double      read Get_1G            write Set_1G         ;
    property _1GSelected      :string      read Get_1GSelected    write Set_1GSelected ;
    property _2A              :Double      read Get_2A            write Set_2A         ;
    property _2B              :Double      read Get_2B            write Set_2B         ;
    property _3               :Double      read Get_3             write Set_3          ;
    property _4               :Double      read Get_4             write Set_4          ;
    property _5A              :Double      read Get_5A            write Set_5A         ;
    property _5B              :Double      read Get_5B            write Set_5B         ;
    property _6A              :Double      read Get_6A            write Set_6A         ;
    property _6B              :Double      read Get_6B            write Set_6B         ;
    property _7               :Double      read Get_7             write Set_7          ;
    property _7D              :Double      read Get_7D            write Set_7D         ;
    property _7DSelected      :string      read Get_7DSelected    write Set_7DSelected ;
    property _8A              :Double      read Get_8A            write Set_8A         ;
    property _8B              :Double      read Get_8B            write Set_8B         ;
    property _9               :Double      read Get_9             write Set_9          ;
    property Tab3_Type        :string      read GetTab3_Type      write SetTab3_Type   ;
    property Tab3_Month       :string      read GetTab3_Month     write SetTab3_Month  ;
    property Tab3_Year        :Integer     read GetTab3_Year      write SetTab3_Year   ;
    property Tab4_Type        :string      read GetTab4_Type      write SetTab4_Type   ;
    property Tab4_Month       :string      read GetTab4_Month     write SetTab4_Month  ;
    property Tab4_Year        :Integer     read GetTab4_Year      write SetTab4_Year   ;
    Property HasTab1          :Boolean     read getHasTab1        write setHasTab1     ;
    Property HasTab2          :Boolean     read getHasTab2        write setHasTab2     ;
    Property HasTab3          :Boolean     read getHasTab3        write setHasTab3     ;
    Property HasTab4          :Boolean     read getHasTab4        write setHasTab4     ;
    property Lines: TBASReturnLines Read geTBASReturnLines;

  end;

  TNZReturn = class(TReturns)
  private
    function GetTab4_Type        : string    ;
    function GetTab4_Month       : string    ;
    function GetTab4_Year        : Integer   ;
    function GetBasSheetDesc     : string    ;
    function GetNZG5             : Double    ;
    function GetNZG5Selected     : string    ;
    function GetNZG6             : Double    ;
    function GetNZG6Selected     : string    ;
    function GetNZG7             : Double    ;
    function GetNZG8             : Double    ;
    function GetNZG9             : Double    ;
    function GetNZG10            : Double    ;
    function GetNZG11            : Double    ;
    function GetNZG11Selected    : string    ;
    function GetNZG12            : Double    ;
    function GetNZG13            : Double    ;
    function GetNZG14            : Double    ;
    function GetNZG15            : Double    ;
    function GetNZG16            : Double    ;
    function GetC1               : Double    ;
    function GetC2               : Double    ;
    function GetC3               : Double    ;
    function GetC4               : Double    ;
    function GetC5               : Double    ;
    function GetC6               : Double    ;
    function GetC7               : Double    ;
    function GetC8               : Double    ;
    function GetC9               : Double    ;
    function GetC10              : Double    ;
    function GetC11              : Double    ;
    function GetC12              : Double    ;
    function GetC13              : Double    ;
    procedure SetTab4_Type        (const Value: string    );
    procedure SetTab4_Month       (const Value: string    );
    procedure SetTab4_Year        (const Value: Integer   );
    procedure SetBasSheetDesc     (const Value: string    );
    procedure SetNZG5             (const Value: Double    );
    procedure SetNZG5Selected     (const Value: string    );
    procedure SetNZG6             (const Value: Double    );
    procedure SetNZG6Selected     (const Value: string    );
    procedure SetNZG7             (const Value: Double    );
    procedure SetNZG8             (const Value: Double    );
    procedure SetNZG9             (const Value: Double    );
    procedure SetNZG10            (const Value: Double    );
    procedure SetNZG11            (const Value: Double    );
    procedure SetNZG11Selected    (const Value: string    );
    procedure SetNZG12            (const Value: Double    );
    procedure SetNZG13            (const Value: Double    );
    procedure SetNZG14            (const Value: Double    );
    procedure SetNZG15            (const Value: Double    );
    procedure SetNZG16            (const Value: Double    );
    procedure SetC1               (const Value: Double    );
    procedure SetC2               (const Value: Double    );
    procedure SetC3               (const Value: Double    );
    procedure SetC4               (const Value: Double    );
    procedure SetC5               (const Value: Double    );
    procedure SetC6               (const Value: Double    );
    procedure SetC7               (const Value: Double    );
    procedure SetC8               (const Value: Double    );
    procedure SetC9               (const Value: Double    );
    procedure SetC10              (const Value: Double    );
    procedure SetC11              (const Value: Double    );
    procedure SetC12              (const Value: Double    );
    procedure SetC13              (const Value: Double    );
    function geTNZReturnLines: TNZReturnLines;
    function getTab4_From: TDate;
    function getTab4_To: TDate;
    function ValidateTab4DateRange: Boolean;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    Function  DoAfterInsert(sender:TDatasetBusobj):Boolean;             override;
    function getLines: TReturnLines;Override;
    function GetAccMethod        : string    ;Override;
    procedure SetAccMethod        (const Value: string    );Override;
    function GetClassID         : Integer   ;override;
    procedure SetClassID         (const Value: Integer   );override;
    function GetAllClass         : Boolean   ;override;
    procedure SetAllClass         (const Value: Boolean   );override;
    function getCodeFieldName: String;Override;
    function getHeaderIDFieldName: String;Override;
    function getHeaderDescfieldName: String;Override;
    function getdescription: String; Override;
    procedure Setdescription(const Value: String);Override;

  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Property Tab4_From :TDate read getTab4_From;
    Property Tab4_To :TDate read getTab4_To;
    procedure NextReturn(ReturnPage: TReturnPage; Changetype:boolean =True);Override;
  published
    property Tab4_Type         :string      read GetTab4_Type       write SetTab4_Type    ;
    property Tab4_Month        :string      read GetTab4_Month      write SetTab4_Month   ;
    property Tab4_Year         :Integer     read GetTab4_Year       write SetTab4_Year    ;
    property BasSheetDesc      :string      read GetBasSheetDesc    write SetBasSheetDesc ;
    property NZG5              :Double      read GetNZG5            write SetNZG5         ;
    property NZG5Selected      :string      read GetNZG5Selected    write SetNZG5Selected ;
    property NZG6              :Double      read GetNZG6            write SetNZG6         ;
    property NZG6Selected      :string      read GetNZG6Selected    write SetNZG6Selected ;
    property NZG7              :Double      read GetNZG7            write SetNZG7         ;
    property NZG8              :Double      read GetNZG8            write SetNZG8         ;
    property NZG9              :Double      read GetNZG9            write SetNZG9         ;
    property NZG10             :Double      read GetNZG10           write SetNZG10        ;
    property NZG11             :Double      read GetNZG11           write SetNZG11        ;
    property NZG11Selected     :string      read GetNZG11Selected   write SetNZG11Selected;
    property NZG12             :Double      read GetNZG12           write SetNZG12        ;
    property NZG13             :Double      read GetNZG13           write SetNZG13        ;
    property NZG14             :Double      read GetNZG14           write SetNZG14        ;
    property NZG15             :Double      read GetNZG15           write SetNZG15        ;
    property NZG16             :Double      read GetNZG16           write SetNZG16        ;
    property C1                :Double      read GetC1              write SetC1           ;
    property C2                :Double      read GetC2              write SetC2           ;
    property C3                :Double      read GetC3              write SetC3           ;
    property C4                :Double      read GetC4              write SetC4           ;
    property C5                :Double      read GetC5              write SetC5           ;
    property C6                :Double      read GetC6              write SetC6           ;
    property C7                :Double      read GetC7              write SetC7           ;
    property C8                :Double      read GetC8              write SetC8           ;
    property C9                :Double      read GetC9              write SetC9           ;
    property C10               :Double      read GetC10             write SetC10          ;
    property C11               :Double      read GetC11             write SetC11          ;
    property C12               :Double      read GetC12             write SetC12          ;
    property C13               :Double      read GetC13             write SetC13          ;
    property AccMethod         :string      read GetAccMethod       write SetAccMethod    ;
    property Lines: TNZReturnLines Read geTNZReturnLines;
  end;

implementation


uses tcDataUtils, CommonLib, sysutils, BusObjConst, DateUtils, ERPdbComponents,
  AppEnvironment, CommonDbLib, MySQLConst, {$IFDEF GUIAPP}ReturnObj,{$ENDIF} tcConst,
  CashBasis, LogLib;

  {TBASReturn}

constructor TBASReturn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'BasReturn';
  fSQL := 'SELECT * FROM tblbasreports';
end;

destructor TBASReturn.Destroy;
begin
  inherited;
end;

procedure TBASReturn.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Tab1_Type');
  SetPropertyFromNode(node,'Tab1_Month');
  SetPropertyFromNode(node,'Tab1_Year');
  SetPropertyFromNode(node,'BasSheetDesc');
  SetPropertyFromNode(node,'G1');
  SetPropertyFromNode(node,'G1Selected');
  SetPropertyFromNode(node,'G2');
  SetPropertyFromNode(node,'G2Selected');
  SetPropertyFromNode(node,'G3');
  SetPropertyFromNode(node,'G3Selected');
  SetPropertyFromNode(node,'G4');
  SetPropertyFromNode(node,'G4Selected');
  SetPropertyFromNode(node,'G5');
  SetPropertyFromNode(node,'G6');
  SetPropertyFromNode(node,'G7');
  SetPropertyFromNode(node,'G7Selected');
  SetPropertyFromNode(node,'G8');
  SetPropertyFromNode(node,'G9');
  SetPropertyFromNode(node,'G10');
  SetPropertyFromNode(node,'G10Selected');
  SetPropertyFromNode(node,'G11');
  SetPropertyFromNode(node,'G11Selected');
  SetPropertyFromNode(node,'G12');
  SetPropertyFromNode(node,'G13');
  SetPropertyFromNode(node,'G13Selected');
  SetPropertyFromNode(node,'G14');
  SetPropertyFromNode(node,'G14Selected');
  SetPropertyFromNode(node,'G15');
  SetPropertyFromNode(node,'G15Selected');
  SetPropertyFromNode(node,'G16');
  SetPropertyFromNode(node,'G17');
  SetPropertyFromNode(node,'G18');
  SetPropertyFromNode(node,'G18Selected');
  SetPropertyFromNode(node,'G19');
  SetPropertyFromNode(node,'G20');
  SetPropertyFromNode(node,'Tab2_Type');
  SetPropertyFromNode(node,'Tab2_Month');
  SetPropertyFromNode(node,'Tab2_Year');
  SetPropertyFromNode(node,'W1');
  SetPropertyFromNode(node,'W1Selected');
  SetPropertyFromNode(node,'W2');
  SetPropertyFromNode(node,'W2Selected');
  SetPropertyFromNode(node,'W3');
  SetPropertyFromNode(node,'W3Selected');
  SetPropertyFromNode(node,'W4');
  SetPropertyFromNode(node,'W4Selected');
  SetPropertyFromNode(node,'T1');
  SetPropertyFromNode(node,'T1Selected');
  SetPropertyFromNode(node,'T2');
  SetPropertyFromNode(node,'T3');
  SetPropertyFromNode(node,'T4');
  SetPropertyFromNode(node,'F1');
  SetPropertyFromNode(node,'F2');
  SetPropertyFromNode(node,'F3');
  SetPropertyFromNode(node,'F4');
  SetPropertyFromNode(node,'_1A');
  SetPropertyFromNode(node,'_1B');
  SetPropertyFromNode(node,'_1C');
  SetPropertyFromNode(node,'_1CSelected');
  SetPropertyFromNode(node,'_1D');
  SetPropertyFromNode(node,'_1DSelected');
  SetPropertyFromNode(node,'_1E');
  SetPropertyFromNode(node,'_1ESelected');
  SetPropertyFromNode(node,'_1F');
  SetPropertyFromNode(node,'_1FSelected');
  SetPropertyFromNode(node,'_1G');
  SetPropertyFromNode(node,'_1GSelected');
  SetPropertyFromNode(node,'_2A');
  SetPropertyFromNode(node,'_2B');
  SetPropertyFromNode(node,'_3');
  SetPropertyFromNode(node,'_4');
  SetPropertyFromNode(node,'_5A');
  SetPropertyFromNode(node,'_5B');
  SetPropertyFromNode(node,'_6A');
  SetPropertyFromNode(node,'_6B');
  SetPropertyFromNode(node,'_7');
  SetPropertyFromNode(node,'_7D');
  SetPropertyFromNode(node,'_7DSelected');
  SetPropertyFromNode(node,'_8A');
  SetPropertyFromNode(node,'_8B');
  SetPropertyFromNode(node,'_9');
  SetPropertyFromNode(node,'Tab3_Type');
  SetPropertyFromNode(node,'Tab3_Month');
  SetPropertyFromNode(node,'Tab3_Year');
  SetPropertyFromNode(node,'Tab4_Type');
  SetPropertyFromNode(node,'Tab4_Month');
  SetPropertyFromNode(node,'Tab4_Year');
  SetBooleanPropertyFromnode(node , 'HasTab1');
  SetBooleanPropertyFromnode(node , 'HasTab2');
  SetBooleanPropertyFromnode(node , 'HasTab3');
  SetBooleanPropertyFromnode(node , 'HasTab4');
end;

procedure TBASReturn.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Tab1_Type' ,Tab1_Type);
  AddXMLNode(node,'Tab1_Month' ,Tab1_Month);
  AddXMLNode(node,'Tab1_Year' ,Tab1_Year);
  AddXMLNode(node,'BasSheetDesc' ,BasSheetDesc);
  AddXMLNode(node,'G1' ,G1);
  AddXMLNode(node,'G1Selected' ,G1Selected);
  AddXMLNode(node,'G2' ,G2);
  AddXMLNode(node,'G2Selected' ,G2Selected);
  AddXMLNode(node,'G3' ,G3);
  AddXMLNode(node,'G3Selected' ,G3Selected);
  AddXMLNode(node,'G4' ,G4);
  AddXMLNode(node,'G4Selected' ,G4Selected);
  AddXMLNode(node,'G5' ,G5);
  AddXMLNode(node,'G6' ,G6);
  AddXMLNode(node,'G7' ,G7);
  AddXMLNode(node,'G7Selected' ,G7Selected);
  AddXMLNode(node,'G8' ,G8);
  AddXMLNode(node,'G9' ,G9);
  AddXMLNode(node,'G10' ,G10);
  AddXMLNode(node,'G10Selected' ,G10Selected);
  AddXMLNode(node,'G11' ,G11);
  AddXMLNode(node,'G11Selected' ,G11Selected);
  AddXMLNode(node,'G12' ,G12);
  AddXMLNode(node,'G13' ,G13);
  AddXMLNode(node,'G13Selected' ,G13Selected);
  AddXMLNode(node,'G14' ,G14);
  AddXMLNode(node,'G14Selected' ,G14Selected);
  AddXMLNode(node,'G15' ,G15);
  AddXMLNode(node,'G15Selected' ,G15Selected);
  AddXMLNode(node,'G16' ,G16);
  AddXMLNode(node,'G17' ,G17);
  AddXMLNode(node,'G18' ,G18);
  AddXMLNode(node,'G18Selected' ,G18Selected);
  AddXMLNode(node,'G19' ,G19);
  AddXMLNode(node,'G20' ,G20);
  AddXMLNode(node,'Tab2_Type' ,Tab2_Type);
  AddXMLNode(node,'Tab2_Month' ,Tab2_Month);
  AddXMLNode(node,'Tab2_Year' ,Tab2_Year);
  AddXMLNode(node,'W1' ,W1);
  AddXMLNode(node,'W1Selected' ,W1Selected);
  AddXMLNode(node,'W2' ,W2);
  AddXMLNode(node,'W2Selected' ,W2Selected);
  AddXMLNode(node,'W3' ,W3);
  AddXMLNode(node,'W3Selected' ,W3Selected);
  AddXMLNode(node,'W4' ,W4);
  AddXMLNode(node,'W4Selected' ,W4Selected);
  AddXMLNode(node,'T1' ,T1);
  AddXMLNode(node,'T1Selected' ,T1Selected);
  AddXMLNode(node,'T2' ,T2);
  AddXMLNode(node,'T3' ,T3);
  AddXMLNode(node,'T4' ,T4);
  AddXMLNode(node,'F1' ,F1);
  AddXMLNode(node,'F2' ,F2);
  AddXMLNode(node,'F3' ,F3);
  AddXMLNode(node,'F4' ,F4);
  AddXMLNode(node,'_1A' ,_1A);
  AddXMLNode(node,'_1B' ,_1B);
  AddXMLNode(node,'_1C' ,_1C);
  AddXMLNode(node,'_1CSelected' ,_1CSelected);
  AddXMLNode(node,'_1D' ,_1D);
  AddXMLNode(node,'_1DSelected' ,_1DSelected);
  AddXMLNode(node,'_1E' ,_1E);
  AddXMLNode(node,'_1ESelected' ,_1ESelected);
  AddXMLNode(node,'_1F' ,_1F);
  AddXMLNode(node,'_1FSelected' ,_1FSelected);
  AddXMLNode(node,'_1G' ,_1G);
  AddXMLNode(node,'_1GSelected' ,_1GSelected);
  AddXMLNode(node,'_2A' ,_2A);
  AddXMLNode(node,'_2B' ,_2B);
  AddXMLNode(node,'_3' ,_3);
  AddXMLNode(node,'_4' ,_4);
  AddXMLNode(node,'_5A' ,_5A);
  AddXMLNode(node,'_5B' ,_5B);
  AddXMLNode(node,'_6A' ,_6A);
  AddXMLNode(node,'_6B' ,_6B);
  AddXMLNode(node,'_7' ,_7);
  AddXMLNode(node,'_7D' ,_7D);
  AddXMLNode(node,'_7DSelected' ,_7DSelected);
  AddXMLNode(node,'_8A' ,_8A);
  AddXMLNode(node,'_8B' ,_8B);
  AddXMLNode(node,'_9' ,_9);
  AddXMLNode(node,'Tab3_Type' ,Tab3_Type);
  AddXMLNode(node,'Tab3_Month' ,Tab3_Month);
  AddXMLNode(node,'Tab3_Year' ,Tab3_Year);
  AddXMLNode(node,'Tab4_Type' ,Tab4_Type);
  AddXMLNode(node,'Tab4_Month' ,Tab4_Month);
  AddXMLNode(node,'Tab4_Year' ,Tab4_Year);
  AddXMLNode(node, 'HasTab1' , HasTab1);
  AddXMLNode(node, 'HasTab2' , HasTab2);
  AddXMLNode(node, 'HasTab3' , HasTab3);
  AddXMLNode(node, 'HasTab4' , HasTab4);
end;

function TBASReturn.ValidateData: Boolean ;
begin
  Result := inherited ValidateData;
  if not result then exit;
end;

function TBASReturn.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TBASReturn.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  SendEvent(BusobjEvent_ToDo, BusobjEvent_IDChange, self);
end;

Function TBASReturn.ValidateTab1DateRange: Boolean;
begin
  (* REsult := DateRangeValid('Tab1_Month' , 'Tab1_Year' , 'Tab1_type' ,   Tab1_From ,Tab1_To) or
            DateRangeValid('Tab2_Month' , 'Tab2_Year' , 'Tab2_type' ,   Tab2_From ,Tab2_To) or
            DateRangeValid('Tab3_Month' , 'Tab3_Year' , 'Tab3_type' ,   Tab3_From ,Tab3_To); *)
  Result := True;
end;

Function TBASReturn.ValidateTab2DateRange:Boolean;
begin
  (* REsult := DateRangeValid('Tab1_Month' , 'Tab1_Year' , 'Tab1_type' ,   Tab1_From ,Tab1_To) or
            DateRangeValid('Tab2_Month' , 'Tab2_Year' , 'Tab2_type' ,   Tab2_From ,Tab2_To) or
            DateRangeValid('Tab3_Month' , 'Tab3_Year' , 'Tab3_type' ,   Tab3_From ,Tab3_To); *)
  Result := TRue;
end;

Function TBASReturn.ValidateTab3DateRange:Boolean;
begin
  (* REsult := DateRangeValid('Tab1_Month' , 'Tab1_Year' , 'Tab1_type' ,   Tab1_From ,Tab1_To) or
            DateRangeValid('Tab2_Month' , 'Tab2_Year' , 'Tab2_type' ,   Tab2_From ,Tab2_To) or
            DateRangeValid('Tab3_Month' , 'Tab3_Year' , 'Tab3_type' ,   Tab3_From ,Tab3_To); *)
  Result := TRue;
end;
Function TBASReturn.ValidateTab4DateRange:Boolean;
begin
  (* REsult := DateRangeValid('Tab1_Month' , 'Tab1_Year' , 'Tab1_type' ,   Tab1_From ,Tab1_To) or
            DateRangeValid('Tab2_Month' , 'Tab2_Year' , 'Tab2_type' ,   Tab2_From ,Tab2_To) or
            DateRangeValid('Tab3_Month' , 'Tab3_Year' , 'Tab3_type' ,   Tab3_From ,Tab3_To); *)
  Result := TRue;
end;

procedure TBASReturn.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.

  inherited;

  if SameText(Sender.Fieldname , 'Tab1_Type') then begin
    if not ValidateTab1DateRange then CancelDB;
    SendEvent(BusobjEvent_ToDo, BusobjEvent_DateRangeChange+'tab1', self);
  end else if SameText(Sender.Fieldname , 'Tab1_Month') then begin
    if not ValidateTab1DateRange then CancelDB;
    SendEvent(BusobjEvent_ToDo, BusobjEvent_DateRangeChange+'tab1', self);
  end else if SameText(Sender.Fieldname , 'Tab1_Year') then begin
    if not ValidateTab1DateRange then CancelDB;
    SendEvent(BusobjEvent_ToDo, BusobjEvent_DateRangeChange+'tab1', self);
  end else if SameText(Sender.Fieldname , 'Tab2_Type') then begin
    if not ValidateTab2DateRange then CancelDB;
    SendEvent(BusobjEvent_ToDo, BusobjEvent_DateRangeChange+'tab2', self);
  end else if SameText(Sender.Fieldname , 'Tab2_Month') then begin
    if not ValidateTab2DateRange then CancelDB;
    SendEvent(BusobjEvent_ToDo, BusobjEvent_DateRangeChange+'tab2', self);
  end else if SameText(Sender.Fieldname , 'Tab2_Year') then begin
    if not ValidateTab2DateRange then CancelDB;
    SendEvent(BusobjEvent_ToDo, BusobjEvent_DateRangeChange+'tab2', self);
  end else if SameText(Sender.Fieldname , 'Tab3_Type') then begin
    if not ValidateTab3DateRange then CancelDB;
    SendEvent(BusobjEvent_ToDo, BusobjEvent_DateRangeChange+'tab3', self);
  end else if SameText(Sender.Fieldname , 'Tab3_Month') then begin
    if not ValidateTab3DateRange then CancelDB;
    SendEvent(BusobjEvent_ToDo, BusobjEvent_DateRangeChange+'tab3', self);
  end else if SameText(Sender.Fieldname , 'Tab3_Year') then begin
    if not ValidateTab3DateRange then CancelDB;
    SendEvent(BusobjEvent_ToDo, BusobjEvent_DateRangeChange+'tab3', self);
  end else if SameText(Sender.Fieldname , 'Tab4_Type') then begin
    if not ValidateTab4DateRange then CancelDB;
    SendEvent(BusobjEvent_ToDo, BusobjEvent_DateRangeChange+'tab4', self);
  end else if SameText(Sender.Fieldname , 'Tab4_Month') then begin
    if not ValidateTab4DateRange then CancelDB;
    SendEvent(BusobjEvent_ToDo, BusobjEvent_DateRangeChange+'tab4', self);
  end else if SameText(Sender.Fieldname , 'Tab4_Year') then begin
    if not ValidateTab4DateRange then CancelDB;
    SendEvent(BusobjEvent_ToDo, BusobjEvent_DateRangeChange+'tab4', self);
  end;

{$IFNDEF GUIAPP}

  // Wang to insert line
  if SameText(Sender.Fieldname, 'G1') then
    Silent_OpenTaxSelect('G1', 1)
  else if SameText(Sender.Fieldname, 'G2') then
    Silent_OpenTaxSelect('G2', 1)
  else if SameText(Sender.Fieldname, 'G3') then
    Silent_OpenTaxSelect('G3', 1)
  else if SameText(Sender.Fieldname, 'G4') then
    Silent_OpenTaxSelect('G4', 1)
  else if SameText(Sender.Fieldname, 'G7') then
    Silent_OpenTaxSelect('G7', 1)
  else if SameText(Sender.Fieldname, 'G1') then
    Silent_OpenTaxSelect('G10', 1)
  else if SameText(Sender.Fieldname, 'G1') then
    Silent_OpenTaxSelect('G11', 1)
  else if SameText(Sender.Fieldname, 'G3') then
    Silent_OpenTaxSelect('G13', 1)
  else if SameText(Sender.Fieldname, 'G4') then
    Silent_OpenTaxSelect('G14', 1)
  else if SameText(Sender.Fieldname, 'G5') then
    Silent_OpenTaxSelect('G15', 1)
  else if SameText(Sender.Fieldname, 'G18') then
    Silent_OpenTaxSelect('G18', 1)
  else if SameText(Sender.Fieldname, 'W1') then
    Silent_OpenTaxSelect('W1', 2)
  else if SameText(Sender.Fieldname, 'W2') then
    Silent_OpenTaxSelect('W2', 21)
  else if SameText(Sender.Fieldname, 'W3') then
    Silent_OpenTaxSelect('W3', 2)
  else if SameText(Sender.Fieldname, 'W4') then
    Silent_OpenTaxSelect('W4', 2)
  else if SameText(Sender.Fieldname, 'T1') then
    Silent_OpenTaxSelect('T1', 3)
  else if SameText(Sender.Fieldname, '1C') then
    Silent_OpenTaxSelect('_1C', 4)
  else if SameText(Sender.Fieldname, '_1E') then
    Silent_OpenTaxSelect('_1E', 4)
  else if SameText(Sender.Fieldname, '_1D') then
    Silent_OpenTaxSelect('_1D', 41)
  else if SameText(Sender.Fieldname, '_1F') then
    Silent_OpenTaxSelect('_1F', 4)
  else if SameText(Sender.Fieldname, '_1G') then
    Silent_OpenTaxSelect('_1G', 4)
  else if SameText(Sender.Fieldname, '_7D') then
    Silent_OpenTaxSelect('_7D', 4)

{$ENDIF}

end;

function TBASReturn.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TBASReturn.GetIDField: string;
begin
  Result := 'ID'
end;

class function TBASReturn.GetBusObjectTablename: string;
begin
  Result:= 'tblbasreports';
end;

Procedure TBASReturn.NextReturn(ReturnPage: TReturnPage; Changetype:boolean =True);
var
  dtFrom , dtTo:TDatetime;
  stype:String;
begin
  if LastReturn(dtFrom, dtTo,  sType , ReturnPage) then begin
    if ReturnPage = tRPBasTab1  then begin
      if dtTo <> 0 then Dtfrom := incDay(dtTo);
      if Dtfrom <= Appenv.Companyprefs.SummarisedTransDate then Dtfrom := incDay(Appenv.Companyprefs.SummarisedTransDate);
      if Changetype or (Tab1_type = '') then Tab1_type := stype;
      Tab1_Month:= MonthnumberToName(monthof(DtFrom));
      Tab1_Year := yearof(dtFrom);
      postdb;
    end else if ReturnPage = tRPBASTab2  then begin
      if dtTo <> 0 then Dtfrom := incDay(dtTo);
      if dtFrom =0 then dtFrom := Tab1_From;
      if stype = '' then stype := Tab1_type;
      if Dtfrom <= Appenv.Companyprefs.SummarisedTransDate then Dtfrom := incDay(Appenv.Companyprefs.SummarisedTransDate);
      if Changetype  or (Tab2_type = '') then Tab2_type := stype;
      Tab2_Month:= MonthnumberToName(monthof(DtFrom));
      Tab2_Year := yearof(dtFrom);
      postdb;
    end else if ReturnPage = tRPBASTab3  then begin
      if dtTo <> 0 then Dtfrom := incDay(dtTo);
      if dtFrom =0 then dtFrom := Tab1_From;
      if dtFrom =0 then dtFrom := Tab2_From;
      if stype = '' then stype := Tab1_type;
      if stype = '' then stype := Tab2_type;
      if Dtfrom <= Appenv.Companyprefs.SummarisedTransDate then Dtfrom := incDay(Appenv.Companyprefs.SummarisedTransDate);
      if Changetype  or (Tab3_type = '') then Tab3_type := stype;
      Tab3_Month:= MonthnumberToName(monthof(DtFrom));
      Tab3_Year := yearof(dtFrom);
      postdb;
    end else if ReturnPage = tRPBASTab4  then begin
      if dtTo <> 0 then Dtfrom := incDay(dtTo);
      if dtFrom =0 then dtFrom := Tab1_From;
      if dtFrom =0 then dtFrom := Tab2_From;
      if stype = '' then stype := Tab1_type;
      if stype = '' then stype := Tab2_type;
      if Dtfrom <= Appenv.Companyprefs.SummarisedTransDate then Dtfrom := incDay(Appenv.Companyprefs.SummarisedTransDate);
      if Changetype  or (Tab4_type = '') then Tab4_type := stype;
      Tab4_Month:= MonthnumberToName(monthof(DtFrom));
      Tab4_Year := yearof(dtFrom);
      postdb;
    end;
  end else  begin
    if ReturnPage = tRPBasTab1  then begin
      if Changetype  or (Tab1_type = '') then Tab1_type := tPTQuarterly;
      Tab1_Month:=  MonthOfcurrent(Tab1_type);
      Tab1_Year := yearof(now);
      postdb;
    end else if ReturnPage = tRPBASTab2  then begin
      if Changetype  or (Tab2_type = '') then Tab2_type := tPTQuarterly;
      Tab2_Month:=  MonthOfcurrent(Tab2_type);
      Tab2_Year := yearof(now);
      postdb;
    end else if ReturnPage = tRPBASTab3  then begin
      if Changetype  or (Tab3_type = '') then Tab3_type := tPTQuarterly;
      Tab3_Month:=  MonthOfcurrent(Tab3_type);
      Tab3_Year := yearof(now);
      postdb;
    end else if ReturnPage = tRPBASTab4  then begin
      if Changetype  or (Tab4_type = '') then Tab4_type := tPTQuarterly;
      Tab4_Month:=  MonthOfcurrent(Tab4_type);
      Tab4_Year := yearof(now);
      postdb;
    end;
  end;
end;
(* function TBASReturn.NextPeriodFrom(stype:String;dtFrom :TDatetime):TDatetime;
begin
         if SameText(Tab1_Type , tPTMonthly) then dtFrom  := incMonth(dtFrom , 1)
  else if SameText(Tab1_Type , tPTQuarterly) then dtFrom := incMonth(dtFrom , 3)
  else if SameText(Tab1_Type , tPTTwoMonthly) then dtFrom := incMonth(dtFrom , 2)
  else if SameText(Tab1_Type , tPTSixMonthly) then dtFrom := incMonth(dtFrom , 6)
  else dtFrom :=Tab1_from;
  REsult := dtFrom;
end; *)
(*function TBASReturn.PreviousPeriodFrom(stype:String;dtFrom :TDatetime):TDatetime;
begin
         if SameText(Tab1_Type , tPTMonthly) then dtFrom  := incMonth(dtFrom , -1)
  else if SameText(Tab1_Type , tPTQuarterly) then dtFrom := incMonth(dtFrom , -3)
  else if SameText(Tab1_Type , tPTTwoMonthly) then dtFrom := incMonth(dtFrom , -2)
  else if SameText(Tab1_Type , tPTSixMonthly) then dtFrom := incMonth(dtFrom , -6)
  else dtFrom :=Tab1_from;
  REsult := dtFrom;
end;*)
Procedure TBASReturn.InitPeriod;
(*var
  dt:TDateTime;
  dtFrom :TDateTime;*)
begin
  if HasTab1 then NextReturn(tRPBasTab1);
  if HasTab2 then NextReturn(tRPBasTab2);
  if HasTab3 then NextReturn(tRPBasTab3);
  if HasTab4 then NextReturn(tRPBasTab4);
  (*dt:= Tab1_To;
  if Tab2_to < dt then dt:= Tab2_To;
  if Tab3_to < dt then dt:= Tab3_To;
  dtFrom := tab1_from;
  if dtFrom > dt then begin
    While   dtFrom > dt do dtFrom := PreviousPeriodFrom(Tab1_type , dtFrom);
    Tab1_month := MonthnumberToName(monthof(DtFrom));
    Tab1_year := yearof(DtFrom);
  end;
  dtFrom := Tab2_from;
  if dtFrom > dt then begin
    While   dtFrom > dt do dtFrom := PreviousPeriodFrom(Tab2_type , dtFrom);
    Tab2_month := MonthnumberToName(monthof(DtFrom));
    Tab2_year := yearof(DtFrom);
  end;
  dtFrom := Tab3_from;
  if dtFrom > dt then begin
    While   dtFrom > dt do dtFrom := PreviousPeriodFrom(Tab3_type , dtFrom);
    Tab3_month := MonthnumberToName(monthof(DtFrom));
    Tab3_year := yearof(DtFrom);
  end;*)
end;

procedure TBASReturn.Silent_OpenTaxSelect(AFromName: String; const ATab: Integer);
begin
  FromName := AFromName;

  if ATab = 1 then begin
    FromDate := Tab1_From;
    ToDate := Tab1_To;
  end else if ATab = 2 then begin
    FromDate := Tab2_From;
    ToDate := Tab2_To;
  end else if ATab = 3 then begin
    FromDate := Tab3_From;
    ToDate := Tab3_To;
  end else if ATab = 4 then begin
    FromDate := Tab4_From;
    ToDate := Tab4_To;
  end;

  Calc;
end;

procedure TBASReturn.Calc;
var
  Amount: Double;
begin
  Amount := 0.00;
           if Sametext(FromName , 'G1') then begin    Amount := TaxAmounts;
  end else if Sametext(FromName , 'G2') then begin    Amount := TaxAmounts;
  end else if Sametext(FromName , 'G3') then begin    Amount := TaxAmounts;
  end else if Sametext(FromName , 'G4') then begin    Amount := TaxAmounts;
  end else if Sametext(FromName , 'G7') then begin    Amount := TaxAmounts;
  end else if Sametext(FromName , 'G18') then begin   Amount := TaxAmounts;
  end else if Sametext(FromName , 'W1') then begin    Amount := -AccountAmounts;
  end else if Sametext(FromName , 'W2') then begin    Amount := -AccountAmounts;
  end else if Sametext(FromName , 'W3') then begin    Amount := AccountAmounts;
  end else if Sametext(FromName , 'W4') then begin    Amount := AccountAmounts;
  end else if Sametext(FromName , 'T1') then begin    Amount := AccountAmounts;
  end else if Sametext(FromName , '_1C') then begin   Amount := TaxAmounts;
  end else if Sametext(FromName , '_1E') then begin   Amount := AccountAmounts;
  end else if Sametext(FromName , '_1D') then begin   Amount := AccountAmounts;
  end else if Sametext(FromName , '_1F') then begin   Amount := AccountAmounts;
  end else if Sametext(FromName , '_1G') then begin   Amount := AccountAmounts;
  end else if Sametext(FromName , '_7D') then begin   Amount := -AccountAmounts;
  end else if Sametext(FromName , 'NZG5') then begin  Amount := TaxAmounts;
  end else if Sametext(FromName , 'NZG6') then begin  Amount := TaxAmounts;
  end else if Sametext(FromName , 'NZG11') then begin Amount := -TaxAmounts;
  end else if Sametext(FromName , 'G10') then begin if AccMethod <> 'Cash' then Amount := -TaxAmounts else Amount := TaxAmounts;
  end else if Sametext(FromName , 'G11') then begin if AccMethod <> 'Cash' then Amount := -TaxAmounts else Amount := TaxAmounts;
  end else if Sametext(FromName , 'G13') then begin if AccMethod <> 'Cash' then Amount := -TaxAmounts else Amount := TaxAmounts;
  end else if Sametext(FromName , 'G14') then begin if AccMethod <> 'Cash' then Amount := -TaxAmounts else Amount := TaxAmounts;
  end else if Sametext(FromName , 'G15') then begin if AccMethod <> 'Cash' then Amount := -TaxAmounts else Amount := TaxAmounts;
  end;
end;

function TBASReturn.TaxAmounts: Double;
var
  qryTemp: TERPQuery;
  I: Integer;
  Amount: Double;
  FilterStr: String;
  SelectedStr: String;
  DebitsField: String;
  CreditsField: String;
  CashField: String;

  procedure InitValues;
  begin
    if not (AccMethod = 'Cash') then begin
      if (FromName = #95 + '1C') or (FromName = 'T1') then begin
        DebitsField := 'DebitsEx';  {Accrual Tax}
        CreditsField := 'CreditsEx';
      end else begin
        DebitsField := 'DebitsInc';  {Accrual}
        CreditsField := 'CreditsInc';
      end;
    end else begin
      if (FromName = #95 + '1C') or (FromName = #95 + '1D') or (FromName = #95 + '1E') or (FromName = #95 + '1F') or (FromName = #95 + '1G') or (FromName = #95 + '7D') then begin
        DebitsField := 'CASH_DebitsEx'; {Cash Tax}
        CreditsField := 'CASH_CreditsEx';
        CashField := 'TaxAmount';{Cash Tax}
      end else if  (FromName = 'T1') then begin
        DebitsField := 'CASH_DebitsEx'; {Cash Tax}
        CreditsField := 'CASH_CreditsEx';
        CashField := 'TaxableAmountEx';{Cash Tax}
      end else begin
        DebitsField := 'CASH_DebitsInc'; {Cash}
        CreditsField := 'CASH_CreditsInc';
        CashField := 'TaxableAmountInc'; {Cash}
      end;
    end;
  end;

begin
  Amount := 0;

  InitValues;

  SelectedStr := '';
  FilterStr := '1';

  qryTemp := TempMyQuery;
  try
//    if (fBMList.Count <> 0) then begin
//      for I := 0 to fBMList.Count- 1 do begin
//        qryMain.GotoBookmark(fBMList.Items[i]);
//        FilterStr := FilterStr + 'TaxCode =' + #39 + Trim(Copy(qryMain.Fields[0].AsString, 0, 5)) + #39 + ' OR ';
//        SelectedStr := SelectedStr + Trim(Copy(qryMain.Fields[0].AsString, 0, 5)) + #44;
//      end;

//      SelectedStr := Copy(SelectedStr, 0, char_length(SelectedStr) - 1);
//      FilterStr := Copy(FilterStr, 0, char_length(FilterStr) - 4);

      //Run Query
      qryTemp.SQL.Clear;

      if AccMethod <> 'Cash' then begin
        qryTemp.SQL.Add('SELECT T.Globalref, T.`Type`, T.SeqNo, T.Date, ROUND(SUM(' + CreditsField + ') - SUM(' + DebitsField + ') ');
        qryTemp.SQL.Add(' - IFNULL(' +
                      ' (SELECT SUM(RL.Amount) ' +
                      ' FROM ' + Self.Lines.GetBusObjectTablename + ' RL ' +
                      ' INNER JOIN ' + Self.GetBusObjectTablename + ' R ' +
                      ' ON RL.' + Self.HeaderIDFieldName + ' = R.ID AND R.Active = "T" ' +
                      ' AND R.Id <> ' + IntToStr(Self.ID) +
                      ' AND RL.' + Self.CodefieldName + ' = ' + QuotedStr(FromName) +
                      ' WHERE T.GlobalRef = RL.transglobalref AND T.type = RL.transtype AND T.Seqno = RL.TRansseqno ), 0) ' );
        qryTemp.SQL.Add(' , ' + IntToStr(GeneralRoundPlaces) + ') AS AmountInc ');
        qryTemp.SQL.Add('FROM tbltransactions T');
      end else begin
        qryTemp.SQL.Add('SELECT T.Globalref, T.`TransType` type, T.SeqNo, T.Date, ROUND(SUM(IF(IFNULL(TaxType, "")="INPUT" AND IFNULL(TransType, "") = "Journal Entry", 0 - ' + CashField + ', ' + CashField + '))  ');
        qryTemp.SQL.Add(' - IFNULL(' +
                      ' (SELECT SUM(RL.Amount) ' +
                      ' FROM ' + Self.Lines.GetBusObjectTablename + ' RL ' +
                      ' INNER JOIN ' + Self.GetBusObjectTablename + ' R ' +
                      ' ON RL.' + Self.HeaderIDFieldName + ' = R.ID and R.Active = "T" ' +
                      ' AND R.Id <> ' + IntToStr(Self.ID) +
                      ' AND RL.' + Self.CodefieldName + ' = ' + QuotedStr(FromName) +
                      ' WHERE T.GlobalRef = RL.transglobalref AND T.TransType = RL.transtype AND T.Seqno = RL.TRansseqno ), 0) ' );
        qryTemp.SQL.Add(' , ' + IntToStr(GeneralRoundPlaces) + ') AS AmountInc ');
        qryTemp.SQL.Add('FROM ' + CashBasisReturnTempTableName('BAS') + ' T ');
      end;

      qryTemp.Sql.Add('WHERE (' + FilterStr + ') ');
//      if not All then begin
//        qryTemp.Sql.Add('AND ClassID = ' + IntToStr(GetDeptID(Department)) + ' ');
//      end;

      qryTemp.SQL.Add('AND Date <= ' + Quotedstr(FormatDateTime(MysqlDateFormat, ToDate)) + ' ');
      //QryTemp.SQL.text := SyncReportObj.ChangeQuery(QryTemp.Sql.text, usingReportTables);
      qryTemp.SQL.Add('AND ifnull(T.Globalref , "")<>""');
      if AccMethod = 'Cash' then
        qryTemp.SQL.Add('GROUP BY Globalref, `TransType`, SeqNo ')
      else
        qryTemp.SQL.Add('GROUP BY Globalref, `Type`, SeqNo ');

      qryTemp.SQL.add('HAVING IFNULL(amountinc, 0) <> 0');

      if (fromDate> 0) or (toDate > 0) then begin
        qryTemp.SQL.Add('UNION ALL');
        qryTemp.SQL.Add('SELECT RL.transGlobalref , RL.transtype , RL.transseqno , RL.transDate,0-sum(RL.amount) Amountinc'+
                          ' FROM  ' + Self.Lines.GetBusObjectTablename +' RL'+
                          ' INNER JOIN ' + Self.GetBusObjectTablename+ ' R ' +
                          ' ON RL.' + Self.HeaderIDFieldName + ' = R.ID AND R.Active = "T" ' +
                          ' AND R.Id <> ' + inttostr(Self.ID)+
                          ' AND RL.' + Self.CodefieldName+' = ' + quotedstr(FromName) +
                          ' LEFT JOIN tbltransactions T ON T.globalref = RL.transglobalref AND T.type = RL.transtype AND T.Seqno = RL.TRansseqno');
        if TableExists('tbltransactionsummarydetails') then
          qryTemp.SQL.add('LEFT JOIN tbltransactionsummarydetails TD ON TD.globalref = RL.transglobalref AND TD.type = RL.transtype AND TD.Seqno = RL.TRansseqno');
        qryTemp.SQL.Add('WHERE IFNULL(T.TransID,0) = 0 ');
        if TableExists('tbltransactionsummarydetails') then
          qryTemp.SQL.add('AND IFNULL(TD.TransID, 0) = 0');

//        if not All then begin
//          qryTemp.Sql.Add('AND R.ClassID = ' + IntToStr(GetDeptID(Department)) + ' ');
//        end;

        qryTemp.SQL.Add('GROUP BY RL.transGlobalref, RL.transtype, RL.transseqno ');
        qryTemp.SQL.Add('HAVING IFNULL(amountinc, 0) <> 0');
      end;

      LogText(qryTemp.SQL.Text);

      qryTemp.Open;
      Self.DeleteAllLines(FromName);
      Amount := 0;

      qryTemp.First;
      for I := 0 to qryTemp.RecordCount - 1 do begin
        Amount := Amount + qryTemp.FieldByName('AmountInc').AsFloat;
        if qryTemp.FieldByName('AmountInc').AsFloat <> 0 then begin
          Self.Lines.New;
          Self.Lines.TransGlobalref:= qryTemp.FieldByName('Globalref').AsString;
          Self.Lines.Transtype:= qryTemp.FieldByName('type').AsString;
          Self.Lines.TransSeqno:= qryTemp.FieldByName('Seqno').AsInteger;
          Self.Lines.TransDate := QryTemp.FieldByName('date').AsDateTime;
          Self.Lines.ReportCode:= FromName;
          Self.Lines.Amount:= qryTemp.FieldByName('AmountInc').AsFloat;
          Self.Lines.PostDB;
        end;
        qryTemp.Next;
      end;
  finally
    Result := Round(Amount ,0);
    FreeAndNil(qryTemp);
  end;
end;

function TBASReturn.AccountAmounts: Double;
var
  qryTemp: TERPQuery; {if an accountslist is passed we are using the accounts already stored in the field;ie not selecting from the popup}
  I: Integer;
  Amount: Double;
  FilterStr: String;
  SelectedStr: String;
  DebitsField: String;
  CreditsField: String;
  CashField: String;

  procedure InitValues;
  begin
    if not (AccMethod = 'Cash') then begin
      if (FromName = #95 + '1C') or (FromName = 'T1') then begin
        DebitsField := 'DebitsEx';  {Accrual Tax}
        CreditsField := 'CreditsEx';
      end else begin
        DebitsField := 'DebitsInc';  {Accrual}
        CreditsField := 'CreditsInc';
      end;
    end else begin
      if (FromName = #95 + '1C') or (FromName = #95 + '1D') or (FromName = #95 + '1E') or (FromName = #95 + '1F') or (FromName = #95 + '1G') or (FromName = #95 + '7D') then begin
        DebitsField := 'CASH_DebitsEx'; {Cash Tax}
        CreditsField := 'CASH_CreditsEx';
        CashField := 'TaxAmount';{Cash Tax}
      end else if  (FromName = 'T1') then begin
        DebitsField := 'CASH_DebitsEx'; {Cash Tax}
        CreditsField := 'CASH_CreditsEx';
        CashField := 'TaxableAmountEx';{Cash Tax}
      end else begin
        DebitsField := 'CASH_DebitsInc'; {Cash}
        CreditsField := 'CASH_CreditsInc';
        CashField := 'TaxableAmountInc'; {Cash}
      end;
    end;
  end;

begin
  Amount := 0;

  InitValues;

  SelectedStr := '';
  FilterStr := '1';

  qryTemp := TempMyQuery;
  try
//    if (fBMList.Count <> 0) or (AccountsList <> nil) then begin
//      if Assigned(AccountsList) then begin
//        for I := 0 to AccountsList.Count - 1 do begin
//          FilterStr := FilterStr + 'T.AccountName = ' + QuotedStr(AccountsList.Strings[i]) + ' OR ';
//          SelectedStr := SelectedStr + AccountsList.Strings[i] + #44;
//        end;
//      end else begin
//        for I := 0 to fBMList.Count - 1 do begin
//          qryMain.GotoBookmark(fBMList.Items[i]);
//          FilterStr := FilterStr + 'T.AccountName =' + #39 + Trim(Copy(qryMain.Fields[0].AsString, 0, 50)) + #39 + ' OR ';
//          SelectedStr := SelectedStr + Trim(Copy(qryMain.Fields[0].AsString, 0, 50)) + #44;
//        end;
//      end;

//      SelectedStr := Copy(SelectedStr, 0, char_length(SelectedStr) - 1);
//      FilterStr := Copy(FilterStr, 0, char_length(FilterStr) - 4);

      qryTemp.SQL.Clear;
      qryTemp.SQL.Add('SELECT T.Globalref, T.`Type`, T.SeqNo, T.Date, ROUND(SUM(' + CreditsField + '-' + DebitsField + ')  ');

      qryTemp.SQL.Add(' - IFNULL(' +
                    ' (SELECT SUM(RL.Amount) ' +
                    ' FROM ' + Self.Lines.GetBusObjectTablename +
                    ' RL INNER JOIN ' + Self.GetBusObjectTablename+ ' R ' +
                    ' ON RL.' + Self.HeaderIDFieldName +'= R.ID AND R.Active = "T" ' +
                    ' AND R.Id <> ' + IntToStr(Self.ID)+
                    ' AND RL.' + Self.CodefieldName+' = ' + QuotedStr(FromName) +
                    ' WHERE T.GlobalRef = RL.transglobalref AND T.type = RL.transtype AND T.Seqno = RL.TRansseqno ), 0) ' );
      qryTemp.SQL.Add(' , ' + IntToStr(GeneralRoundPlaces) + ') AS AmountInc ');
      qryTemp.SQL.Add('FROM tbltransactions T');
      qryTemp.SQL.Add('WHERE (' + FilterStr + ') ');

//      if not All then begin
//        qryTemp.Sql.Add('AND ClassID = ' + IntToStr(GetDeptID(Department)) + ' ');
//      end;

      qryTemp.SQL.Add('AND Date <= ' + Quotedstr(FormatDateTime(MysqlDateFormat, ToDate)) + ' ');
      qryTemp.SQL.Add('AND IFNULL(T.Globalref, "") <> ""');
      qryTemp.SQL.Add('GROUP BY Globalref, `Type`, SeqNo ');
      qryTemp.SQL.Add('HAVING IFNULL(amountinc,0)<>0');
      qryTemp.SQL.Add('UNION ALL ');
      qryTemp.SQL.Add('SELECT RL.transGlobalref, RL.transtype, RL.transseqno, RL.transDate, 0 - SUM(RL.amount) Amountinc ' +
                      ' FROM  ' + Self.Lines.GetBusObjectTablename + ' RL'+
                      ' INNER JOIN ' + Self.GetBusObjectTablename + ' R ' +
                      ' ON RL.' + Self.HeaderIDFieldName + ' = R.ID AND R.Active = "T" ' +
                      ' AND R.Id <> ' + inttostr(Self.ID)+
                      ' AND RL.' + Self.CodefieldName + ' = ' + QuotedStr(FromName) +
                      ' LEFT JOIN tbltransactions T ON T.globalref = RL.transglobalref AND T.type = RL.transtype AND T.Seqno = RL.TRansseqno');
      if TableExists('tbltransactionsummarydetails') then
        qryTemp.SQL.Add('LEFT JOIN tbltransactionsummarydetails TD ON TD.globalref = RL.transglobalref AND TD.type = RL.transtype AND TD.Seqno = RL.TRansseqno');

      qryTemp.SQL.Add('WHERE IFNULL(T.TransID, 0) = 0 ');

      if TableExists('tbltransactionsummarydetails') then
        qryTemp.SQL.Add('AND IFNULL(TD.TransID, 0) = 0');

//      if not All then begin
//        qryTemp.SQL.Add('AND R.ClassID = ' + IntToStr(GetDeptID(Department)) + ' ');
//      end;

      qryTemp.SQL.Add('GROUP BY  RL.transGlobalref, RL.transtype, RL.transseqno ');
      qryTemp.SQL.add('HAVING IFNULL(amountinc, 0) <> 0');
      qryTemp.Open;

      Amount := 0;
      qryTemp.First;
      Self.DeleteAllLines(FromName);

      for I := 0 to qryTemp.RecordCount - 1 do begin
        Amount := Amount + qryTemp.FieldByName('AmountInc').AsFloat;
        if qryTemp.FieldByName('AmountInc').AsFloat <> 0 then begin
          Self.Lines.New;
          Self.Lines.TransGlobalref:= qryTemp.FieldByName('Globalref').asString;
          Self.Lines.Transtype:= qryTemp.FieldByName('type').asString;
          Self.Lines.TransSeqno:= qryTemp.FieldByName('Seqno').asInteger;
          Self.Lines.TransDate := QryTemp.FieldByName('date').AsDateTime;
          Self.Lines.ReportCode:= FromName;
          Self.Lines.Amount:= qryTemp.FieldByName('AmountInc').asFloat;
          Self.Lines.PostDB;
        end;
        qryTemp.Next;
      end;

  finally
    Result := Round(Amount, 0);
    FreeAndNil(qryTemp);
  end;
end;

function TBASReturn.DoAfterInsert(Sender: TDatasetBusobj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  AllClass    := true;
  AccMethod   := appenv.CompanyPrefs.DefaultAccountingMethod;//'Accrual';

  HasTab1:= True;
  HasTab2:= True;
  HasTab3:= False;
  HasTab4:= False;
  SendEvent(BusobjEvent_Event, BusobjEvent_AfterInsert, self);
  InitPeriod;

    With commonDBlib.TempMyQuery do try
      Sql.Add('SELECT AccMethod , ID, G1Selected, G2Selected, G3Selected, G4Selected, G7Selected, G10Selected, G11Selected, G13Selected,');
      Sql.Add('G14Selected, G15Selected, G18Selected, W1Selected, W2Selected, W3Selected, W4Selected, T1Selected, _1CSelected, ');
      Sql.Add('_1DSelected, _1ESelected, _1FSelected, _1GSelected, _7DSelected ');
      Sql.Add('FROM tblbasreports Where Active="T" ');
      Sql.Add('Order By ID desc Limit 1;');
      Open;
      if (RecordCount > 0) then begin
        First;
        //AccMethod   := FieldByname('AccMethod').asString;
        G1Selected  := FieldByName('G1Selected').asString;
        G2Selected  := FieldByName('G2Selected').asString;
        G3Selected  := FieldByName('G3Selected').asString;
        G4Selected  := FieldByName('G4Selected').asString;
        G7Selected  := FieldByName('G7Selected').asString;
        G10Selected := FieldByName('G10Selected').asString;
        G11Selected := FieldByName('G11Selected').asString;
        G13Selected := FieldByName('G13Selected').asString;
        G14Selected := FieldByName('G14Selected').asString;
        G15Selected := FieldByName('G15Selected').asString;
        G18Selected := FieldByName('G18Selected').asString;
        W1Selected  := FieldByName('W1Selected').asString;
        W2Selected  := FieldByName('W2Selected').asString;
        W3Selected  := FieldByName('W3Selected').asString;
        W4Selected  := FieldByName('W4Selected').asString;
        T1Selected  := FieldByName('T1Selected').asString;
        _1CSelected := FieldByName('_1CSelected').asString;
        _1DSelected := FieldByName('_1DSelected').asString;
        _1ESelected := FieldByName('_1ESelected').asString;
        _1FSelected := FieldByName('_1FSelected').asString;
        _1GSelected := FieldByName('_1GSelected').asString;
        _7DSelected := FieldByName('_7DSelected').asString;
      end;
    finally
      ClosenFree;
    end;
    if G1Selected  = '' then   G1Selected  := 'EXP,FRE,GST,INP,WC';
    if G2Selected  = '' then   G2Selected  := 'EXP';
    if G3Selected  = '' then   G3Selected  := 'FRE';
    if G4Selected  = '' then   G4Selected  := 'INP';
    if G7Selected  = '' then   G7Selected  := 'ADJ';
    if G10Selected = '' then   G10Selected := 'CAF,CAG,CAI';
    if G11Selected = '' then   G11Selected := 'NCG,NCF,NCI';
    if G13Selected = '' then   G13Selected := 'CAI,NCI';
    if G14Selected = '' then   G14Selected := 'CAF,NCF';
    if G15Selected = '' then   G15Selected := 'PRI';
    if G18Selected = '' then   G18Selected := 'ADJ';
    if _1CSelected = '' then   _1CSelected := 'WET';
    if w1Selected  = '' then   w1Selected  := 'Net Wages,PAYG Tax Paid';
    if w2Selected  = '' then   w2Selected  := 'PAYG Tax Paid';

end;

function TBASReturn.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{Property Functions}
function  TBASReturn.GetTab1_Type   : string    ; begin Result := GetStringField('Tab1_Type');end;
function  TBASReturn.GetTab1_Month  : string    ; begin Result := GetStringField('Tab1_Month');end;
function  TBASReturn.GetTab1_Year   : Integer   ; begin Result := GetIntegerField('Tab1_Year');end;
function  TBASReturn.GetBasSheetDesc: string    ; begin Result := GetStringField('BasSheetDesc');end;
function  TBASReturn.GetG1          : Double    ; begin Result := GetFloatField('G1');end;
function  TBASReturn.GetG1Selected  : string    ; begin Result := GetStringField('G1Selected');end;
function  TBASReturn.GetG2          : Double    ; begin Result := GetFloatField('G2');end;
function  TBASReturn.GetG2Selected  : string    ; begin Result := GetStringField('G2Selected');end;
function  TBASReturn.GetG3          : Double    ; begin Result := GetFloatField('G3');end;
function  TBASReturn.GetG3Selected  : string    ; begin Result := GetStringField('G3Selected');end;
function  TBASReturn.GetG4          : Double    ; begin Result := GetFloatField('G4');end;
function  TBASReturn.GetG4Selected  : string    ; begin Result := GetStringField('G4Selected');end;
function  TBASReturn.GetG5          : Double    ; begin Result := GetFloatField('G5');end;
function  TBASReturn.GetG6          : Double    ; begin Result := GetFloatField('G6');end;
function  TBASReturn.GetG7          : Double    ; begin Result := GetFloatField('G7');end;
function  TBASReturn.GetG7Selected  : string    ; begin Result := GetStringField('G7Selected');end;
function  TBASReturn.GetG8          : Double    ; begin Result := GetFloatField('G8');end;
function  TBASReturn.GetG9          : Double    ; begin Result := GetFloatField('G9');end;
function  TBASReturn.GetG10         : Double    ; begin Result := GetFloatField('G10');end;
function  TBASReturn.GetG10Selected : string    ; begin Result := GetStringField('G10Selected');end;
function  TBASReturn.GetG11         : Double    ; begin Result := GetFloatField('G11');end;
function  TBASReturn.GetG11Selected : string    ; begin Result := GetStringField('G11Selected');end;
function  TBASReturn.GetG12         : Double    ; begin Result := GetFloatField('G12');end;
function  TBASReturn.GetG13         : Double    ; begin Result := GetFloatField('G13');end;
function  TBASReturn.GetG13Selected : string    ; begin Result := GetStringField('G13Selected');end;
function  TBASReturn.GetG14         : Double    ; begin Result := GetFloatField('G14');end;
function  TBASReturn.GetG14Selected : string    ; begin Result := GetStringField('G14Selected');end;
function  TBASReturn.GetG15         : Double    ; begin Result := GetFloatField('G15');end;
function  TBASReturn.GetG15Selected : string    ; begin Result := GetStringField('G15Selected');end;
function  TBASReturn.GetG16         : Double    ; begin Result := GetFloatField('G16');end;
function  TBASReturn.GetG17         : Double    ; begin Result := GetFloatField('G17');end;
function  TBASReturn.GetG18         : Double    ; begin Result := GetFloatField('G18');end;
function  TBASReturn.GetG18Selected : string    ; begin Result := GetStringField('G18Selected');end;
function  TBASReturn.GetG19         : Double    ; begin Result := GetFloatField('G19');end;
function  TBASReturn.GetG20         : Double    ; begin Result := GetFloatField('G20');end;
function  TBASReturn.GetTab2_Type   : string    ; begin Result := GetStringField('Tab2_Type');end;
function  TBASReturn.GetTab2_Month  : string    ; begin Result := GetStringField('Tab2_Month');end;

function  TBASReturn.GetTab2_Year   : Integer   ; begin Result := GetIntegerField('Tab2_Year');end;
function  TBASReturn.GetW1          : Double    ; begin Result := GetFloatField('W1');end;
function  TBASReturn.GetW1Selected  : string    ; begin Result := GetStringField('W1Selected');end;
function  TBASReturn.GetW2          : Double    ; begin Result := GetFloatField('W2');end;
function  TBASReturn.GetW2Selected  : string    ; begin Result := GetStringField('W2Selected');end;
function  TBASReturn.GetW3          : Double    ; begin Result := GetFloatField('W3');end;
function  TBASReturn.GetW3Selected  : string    ; begin Result := GetStringField('W3Selected');end;
function  TBASReturn.GetW4          : Double    ; begin Result := GetFloatField('W4');end;
function  TBASReturn.GetW4Selected  : string    ; begin Result := GetStringField('W4Selected');end;
function  TBASReturn.GetT1          : Double    ; begin Result := GetFloatField('T1');end;
function  TBASReturn.GetT1Selected  : string    ; begin Result := GetStringField('T1Selected');end;
function  TBASReturn.GetT2          : Double    ; begin Result := GetFloatField('T2');end;
function  TBASReturn.GetT3          : Double    ; begin Result := GetFloatField('T3');end;
function  TBASReturn.GetT4          : string    ; begin Result := GetStringField('T4');end;

function TBASReturn.getTab1_From: TDate;
begin
  Result := 0;
  if Tab1_year=0 then exit;
  if Tab1_Month = '' then exit;
  Result := EncodeDate(Tab1_year ,MonthNameToNumber(Tab1_Month) , 1);
end;

function TBASReturn.getTab1_To: TDate;
begin
  Result := 0;
  if Tab1_year=0 then exit;
  if Tab1_Month = '' then exit;

       if SameText(Tab1_Type , tPTMonthly) then Result := incday(incMonth(Tab1_from , 1) , -1)
  else if SameText(Tab1_Type , tPTQuarterly) then Result := incday(incMonth(Tab1_from , 3), -1)
  else if SameText(Tab1_Type , tPTTwoMonthly) then Result := incday(incMonth(Tab1_from , 2), -1)
  else if SameText(Tab1_Type , tPTSixMonthly) then Result := incday(incMonth(Tab1_from , 6), -1)
  else result :=Tab1_from;
end;

function TBASReturn.getTab2_From: TDate;
begin
  Result := 0;
  if Tab2_year=0 then exit;
  if Tab2_Month = '' then exit;
  Result := EncodeDate(Tab2_year ,MonthNameToNumber(Tab2_Month) , 1);
end;

function TBASReturn.getTab2_To: TDate;
begin
  Result := 0;
  if Tab2_year=0 then exit;
  if Tab2_Month = '' then exit;
       if SameText(Tab2_Type , tPTMonthly)     then Result := incDay(incMonth(Tab2_from , 1), -1)
  else if SameText(Tab2_Type , tPTQuarterly)   then Result := incDay(incMonth(Tab2_from , 3), -1)
  else if SameText(Tab2_Type , tPTTwoMonthly)  then Result := incDay(incMonth(Tab2_from , 2), -1)
  else if SameText(Tab2_Type , tPTsixMonthly)  then Result := incDay(incMonth(Tab2_from , 6), -1)
  else result :=Tab2_from;
end;

function TBASReturn.getTab3_From: TDate;
begin
  Result := 0;
  if Tab3_year=0 then exit;
  if Tab3_Month = '' then exit;
  Result := EncodeDate(Tab3_year ,MonthNameToNumber(Tab3_Month) , 1);
end;

function TBASReturn.getTab3_To: TDate;
begin
  Result := 0;
  if Tab3_year=0 then exit;
  if Tab3_Month = '' then exit;
       if SameText(Tab3_Type , tPTMonthly)     then Result := incDay(incMonth(Tab3_from , 1),-1)
  else if SameText(Tab3_Type , tPTQuarterly)   then Result := incDay(incMonth(Tab3_from , 3),-1)
  else if SameText(Tab3_Type , tPTTwoMonthly) then Result := incDay(incMonth(Tab3_from , 2),-1)
  else if SameText(Tab3_Type , tPTSixMonthly) then Result := incDay(incMonth(Tab3_from , 6),-1)
  else result :=Tab3_from;
end;

function TBASReturn.getTab4_From: TDate;
begin
  Result := 0;
  if Tab4_Year = 0 then Exit;
  if Tab4_Month = '' then Exit;
  Result := EncodeDate(Tab4_Year, MonthNameToNumber(Tab4_Month), 1);
end;

function TBASReturn.GetTab4_To: TDate;
begin
  Result := 0;
  if Tab4_Year = 0 then Exit;
  if Tab4_Month = '' then Exit;

       if SameText(Tab4_Type, tPTMonthly)     then Result := IncDay(IncMonth(Tab4_From, 1),-1)
  else if SameText(Tab4_Type, tPTQuarterly)   then Result := IncDay(IncMonth(Tab4_From, 3),-1)
  else if SameText(Tab4_Type, tPTTwoMonthly)  then Result := IncDay(IncMonth(Tab4_From, 2),-1)
  else if SameText(Tab4_Type, tPTSixMonthly)  then Result := IncDay(IncMonth(Tab4_From, 6),-1)
  else Result := Tab4_From;
end;

function  TBASReturn.GetF1          : Double    ; begin Result := GetFloatField('F1');end;
function  TBASReturn.GetF2          : Double    ; begin Result := GetFloatField('F2');end;
function  TBASReturn.GetF3          : Double    ; begin Result := GetFloatField('F3');end;
function  TBASReturn.GetF4          : string    ; begin Result := GetStringField('F4');end;
function  TBASReturn.Get_1A         : Double    ; begin Result := GetFloatField('_1A');end;
function  TBASReturn.Get_1B         : Double    ; begin Result := GetFloatField('_1B');end;
function  TBASReturn.Get_1C         : Double    ; begin Result := GetFloatField('_1C');end;
function  TBASReturn.Get_1CSelected : string    ; begin Result := GetStringField('_1CSelected');end;
function  TBASReturn.Get_1D         : Double    ; begin Result := GetFloatField('_1D');end;
function  TBASReturn.Get_1DSelected : string    ; begin Result := GetStringField('_1DSelected');end;
function  TBASReturn.Get_1E         : Double    ; begin Result := GetFloatField('_1E');end;
function  TBASReturn.Get_1ESelected : string    ; begin Result := GetStringField('_1ESelected');end;
function  TBASReturn.Get_1F         : Double    ; begin Result := GetFloatField('_1F');end;
function  TBASReturn.Get_1FSelected : string    ; begin Result := GetStringField('_1FSelected');end;
function  TBASReturn.Get_1G         : Double    ; begin Result := GetFloatField('_1G');end;
function  TBASReturn.Get_1GSelected : string    ; begin Result := GetStringField('_1GSelected');end;
function  TBASReturn.Get_2A         : Double    ; begin Result := GetFloatField('_2A');end;
function  TBASReturn.Get_2B         : Double    ; begin Result := GetFloatField('_2B');end;
function  TBASReturn.Get_3          : Double    ; begin Result := GetFloatField('_3');end;
function  TBASReturn.Get_4          : Double    ; begin Result := GetFloatField('_4');end;
function  TBASReturn.Get_5A         : Double    ; begin Result := GetFloatField('_5A');end;
function  TBASReturn.Get_5B         : Double    ; begin Result := GetFloatField('_5B');end;
function  TBASReturn.Get_6A         : Double    ; begin Result := GetFloatField('_6A');end;
function  TBASReturn.Get_6B         : Double    ; begin Result := GetFloatField('_6B');end;
function  TBASReturn.Get_7          : Double    ; begin Result := GetFloatField('_7');end;
function  TBASReturn.Get_7D         : Double    ; begin Result := GetFloatField('_7D');end;
function  TBASReturn.Get_7DSelected : string    ; begin Result := GetStringField('_7DSelected');end;
function  TBASReturn.Get_8A         : Double    ; begin Result := GetFloatField('_8A');end;
function  TBASReturn.Get_8B         : Double    ; begin Result := GetFloatField('_8B');end;
function  TBASReturn.Get_9          : Double    ; begin Result := GetFloatField('_9');end;
function  TBASReturn.GetAccMethod   : string    ; begin Result := GetStringField('AccMethod');end;
function  TBASReturn.GetAllClass    : Boolean   ; begin Result := GetBooleanField('AllClass');end;
function  TBASReturn.geTBASReturnLines: TBASReturnLines;
begin
  Result := TBASReturnLines(getcontainercomponent(TBASReturnLines , 'BasID = ' + IntToStr(ID)));
end;

function  TBASReturn.GetClassID     : Integer   ; begin Result := GetIntegerField('ClassID');end;
function TBASReturn.getCodeFieldName: String;
begin
  Result := 'BASCode';
end;
function TBASReturn.getdescription: String;
begin
  Result := BasSheetDesc;
end;

function TBASReturn.getHeaderIDFieldName: String;
begin
  Result := 'BASID';
end;
function TBASReturn.getHeaderDescfieldName: String;
begin
  Result := 'BasSheetDesc';
end;

function  TBASReturn.GetTab3_Type   : string    ; begin Result := GetStringField('Tab3_Type');end;
function  TBASReturn.GetTab3_Month  : string    ; begin Result := GetStringField('Tab3_Month');end;
function  TBASReturn.GetTab3_Year   : Integer   ; begin Result := GetIntegerField('Tab3_Year');end;
function  TBASReturn.GetTab4_Type   : string    ; begin Result := GetStringField('Tab4_Type');end;
function  TBASReturn.GetTab4_Month  : string    ; begin Result := GetStringField('Tab4_Month');end;
function  TBASReturn.GetTab4_Year   : Integer   ; begin Result := GetIntegerField('Tab4_Year');end;
Function  TBasReturn.getHasTab1     : Boolean   ; begin Result := GetBooleanField('HasTab1');end;
Function  TBasReturn.getHasTab2     : Boolean   ; begin Result := GetBooleanField('HasTab2');end;
Function  TBasReturn.getHasTab3     : Boolean   ; begin Result := GetBooleanField('HasTab3');end;
Function  TBasReturn.getHasTab4     : Boolean   ; begin Result := GetBooleanField('HasTab4');end;
procedure TBASReturn.SetTab1_Type   (const Value: string    ); begin SetStringField('Tab1_Type'    , Value);end;
procedure TBASReturn.SetTab1_Month  (const Value: string    ); begin SetStringField('Tab1_Month'   , Value);end;
procedure TBASReturn.SetTab1_Year   (const Value: Integer   ); begin SetIntegerField('Tab1_Year'    , Value);end;
procedure TBASReturn.SetBasSheetDesc(const Value: string    ); begin SetStringField('BasSheetDesc' , Value);end;
procedure TBASReturn.SetG1          (const Value: Double    ); begin SetFloatField('G1'           , Value);end;
procedure TBASReturn.SetG1Selected  (const Value: string    ); begin SetStringField('G1Selected'   , Value);end;
procedure TBASReturn.SetG2          (const Value: Double    ); begin SetFloatField('G2'           , Value);end;
procedure TBASReturn.SetG2Selected  (const Value: string    ); begin SetStringField('G2Selected'   , Value);end;
procedure TBASReturn.SetG3          (const Value: Double    ); begin SetFloatField('G3'           , Value);end;
procedure TBASReturn.SetG3Selected  (const Value: string    ); begin SetStringField('G3Selected'   , Value);end;
procedure TBASReturn.SetG4          (const Value: Double    ); begin SetFloatField('G4'           , Value);end;
procedure TBASReturn.SetG4Selected  (const Value: string    ); begin SetStringField('G4Selected'   , Value);end;
procedure TBASReturn.SetG5          (const Value: Double    ); begin SetFloatField('G5'           , Value);end;
procedure TBASReturn.SetG6          (const Value: Double    ); begin SetFloatField('G6'           , Value);end;
procedure TBASReturn.SetG7          (const Value: Double    ); begin SetFloatField('G7'           , Value);end;
procedure TBASReturn.SetG7Selected  (const Value: string    ); begin SetStringField('G7Selected'   , Value);end;
procedure TBASReturn.SetG8          (const Value: Double    ); begin SetFloatField('G8'           , Value);end;
procedure TBASReturn.SetG9          (const Value: Double    ); begin SetFloatField('G9'           , Value);end;
procedure TBASReturn.SetG10         (const Value: Double    ); begin SetFloatField('G10'          , Value);end;
procedure TBASReturn.SetG10Selected (const Value: string    ); begin SetStringField('G10Selected' , Value);end;
procedure TBASReturn.SetG11         (const Value: Double    ); begin SetFloatField('G11'          , Value);end;
procedure TBASReturn.SetG11Selected (const Value: string    ); begin SetStringField('G11Selected' , Value);end;
procedure TBASReturn.SetG12         (const Value: Double    ); begin SetFloatField('G12'          , Value);end;
procedure TBASReturn.SetG13         (const Value: Double    ); begin SetFloatField('G13'          , Value);end;
procedure TBASReturn.SetG13Selected (const Value: string    ); begin SetStringField('G13Selected' , Value);end;
procedure TBASReturn.SetG14         (const Value: Double    ); begin SetFloatField('G14'          , Value);end;
procedure TBASReturn.SetG14Selected (const Value: string    ); begin SetStringField('G14Selected' , Value);end;
procedure TBASReturn.SetG15         (const Value: Double    ); begin SetFloatField('G15'          , Value);end;
procedure TBASReturn.SetG15Selected (const Value: string    ); begin SetStringField('G15Selected' , Value);end;
procedure TBASReturn.SetG16         (const Value: Double    ); begin SetFloatField('G16'          , Value);end;
procedure TBASReturn.SetG17         (const Value: Double    ); begin SetFloatField('G17'          , Value);end;
procedure TBASReturn.SetG18         (const Value: Double    ); begin SetFloatField('G18'          , Value);end;
procedure TBASReturn.SetG18Selected (const Value: string    ); begin SetStringField('G18Selected' , Value);end;
procedure TBASReturn.SetG19         (const Value: Double    ); begin SetFloatField('G19'          , Value);end;
procedure TBASReturn.SetG20         (const Value: Double    ); begin SetFloatField('G20'          , Value);end;
procedure TBASReturn.SetTab2_Type   (const Value: string    ); begin SetStringField('Tab2_Type'    , Value);end;
procedure TBASReturn.SetTab2_Month  (const Value: string    ); begin SetStringField('Tab2_Month'   , Value);end;
procedure TBASReturn.SetTab2_Year   (const Value: Integer   ); begin SetIntegerField('Tab2_Year'    , Value);end;
procedure TBASReturn.SetW1          (const Value: Double    ); begin SetFloatField('W1'           , Value);end;
procedure TBASReturn.SetW1Selected  (const Value: string    ); begin SetStringField('W1Selected'   , Value);end;
procedure TBASReturn.SetW2          (const Value: Double    ); begin SetFloatField('W2'           , Value);end;
procedure TBASReturn.SetW2Selected  (const Value: string    ); begin SetStringField('W2Selected'   , Value);end;
procedure TBASReturn.SetW3          (const Value: Double    ); begin SetFloatField('W3'           , Value);end;
procedure TBASReturn.SetW3Selected  (const Value: string    ); begin SetStringField('W3Selected'   , Value);end;
procedure TBASReturn.SetW4          (const Value: Double    ); begin SetFloatField('W4'           , Value);end;
procedure TBASReturn.SetW4Selected  (const Value: string    ); begin SetStringField('W4Selected'   , Value);end;
procedure TBASReturn.SetT1          (const Value: Double    ); begin SetFloatField('T1'           , Value);end;
procedure TBASReturn.SetT1Selected  (const Value: string    ); begin SetStringField('T1Selected'   , Value);end;
procedure TBASReturn.SetT2          (const Value: Double    ); begin SetFloatField('T2'           , Value);end;
procedure TBASReturn.SetT3          (const Value: Double    ); begin SetFloatField('T3'           , Value);end;
procedure TBASReturn.SetT4          (const Value: string    ); begin SetStringField('T4'           , Value);end;
procedure TBASReturn.SetF1          (const Value: Double    ); begin SetFloatField('F1'           , Value);end;
procedure TBASReturn.SetF2          (const Value: Double    ); begin SetFloatField('F2'           , Value);end;
procedure TBASReturn.SetF3          (const Value: Double    ); begin SetFloatField('F3'           , Value);end;
procedure TBASReturn.SetF4          (const Value: string    ); begin SetStringField('F4'           , Value);end;
procedure TBASReturn.Set_1A         (const Value: Double    ); begin SetFloatField('_1A'          , Value);end;
procedure TBASReturn.Set_1B         (const Value: Double    ); begin SetFloatField('_1B'          , Value);end;
procedure TBASReturn.Set_1C         (const Value: Double    ); begin SetFloatField('_1C'          , Value);end;
procedure TBASReturn.Set_1CSelected (const Value: string    ); begin SetStringField('_1CSelected' , Value);end;
procedure TBASReturn.Set_1D         (const Value: Double    ); begin SetFloatField('_1D'          , Value);end;
procedure TBASReturn.Set_1DSelected (const Value: string    ); begin SetStringField('_1DSelected' , Value);end;
procedure TBASReturn.Set_1E         (const Value: Double    ); begin SetFloatField('_1E'          , Value);end;
procedure TBASReturn.Set_1ESelected (const Value: string    ); begin SetStringField('_1ESelected' , Value);end;
procedure TBASReturn.Set_1F         (const Value: Double    ); begin SetFloatField('_1F'          , Value);end;
procedure TBASReturn.Set_1FSelected (const Value: string    ); begin SetStringField('_1FSelected' , Value);end;
procedure TBASReturn.Set_1G         (const Value: Double    ); begin SetFloatField('_1G'          , Value);end;
procedure TBASReturn.Set_1GSelected (const Value: string    ); begin SetStringField('_1GSelected' , Value);end;
procedure TBASReturn.Set_2A         (const Value: Double    ); begin SetFloatField('_2A'          , Value);end;
procedure TBASReturn.Set_2B         (const Value: Double    ); begin SetFloatField('_2B'          , Value);end;
procedure TBASReturn.Set_3          (const Value: Double    ); begin SetFloatField('_3'           , Value);end;
procedure TBASReturn.Set_4          (const Value: Double    ); begin SetFloatField('_4'           , Value);end;
procedure TBASReturn.Set_5A         (const Value: Double    ); begin SetFloatField('_5A'          , Value);end;
procedure TBASReturn.Set_5B         (const Value: Double    ); begin SetFloatField('_5B'          , Value);end;
procedure TBASReturn.Set_6A         (const Value: Double    ); begin SetFloatField('_6A'          , Value);end;
procedure TBASReturn.Set_6B         (const Value: Double    ); begin SetFloatField('_6B'          , Value);end;
procedure TBASReturn.Set_7          (const Value: Double    ); begin SetFloatField('_7'           , Value);end;
procedure TBASReturn.Set_7D         (const Value: Double    ); begin SetFloatField('_7D'          , Value);end;
procedure TBASReturn.Set_7DSelected (const Value: string    ); begin SetStringField('_7DSelected' , Value);end;
procedure TBASReturn.Set_8A         (const Value: Double    ); begin SetFloatField('_8A'          , Value);end;
procedure TBASReturn.Set_8B         (const Value: Double    ); begin SetFloatField('_8B'          , Value);end;
procedure TBASReturn.Set_9          (const Value: Double    ); begin SetFloatField('_9'           , Value);end;
procedure TBASReturn.SetAccMethod   (const Value: string    );
begin
  SetStringField('AccMethod'    , Value);
end;
procedure TBASReturn.SetAllClass    (const Value: Boolean   ); begin SetBooleanField('AllClass'     , Value);end;
procedure TBASReturn.SetClassID     (const Value: Integer   ); begin SetIntegerField('ClassID'      , Value);end;
procedure TBASReturn.Setdescription(const Value: String);
begin
  inherited;
  BasSheetDesc:= Value;
end;

procedure TBASReturn.SetTab3_Type   (const Value: string    ); begin SetStringField('Tab3_Type'    , Value);end;
procedure TBASReturn.SetTab3_Month  (const Value: string    ); begin SetStringField('Tab3_Month'   , Value);end;
procedure TBASReturn.SetTab3_Year   (const Value: Integer   ); begin SetIntegerField('Tab3_Year'    , Value);end;
procedure TBASReturn.SetTab4_Type   (const Value: string    ); begin SetStringField('Tab4_Type'    , Value);end;
procedure TBASReturn.SetTab4_Month  (const Value: string    ); begin SetStringField('Tab4_Month'   , Value);end;
procedure TBASReturn.SetTab4_Year   (const Value: Integer   ); begin SetIntegerField('Tab4_Year'    , Value);end;
Procedure TBasREturn.SetHasTab1     (Const Value: Boolean   ); begin SetBooleanField('HasTab1'      , Value);end;
Procedure TBasREturn.SetHasTab2     (Const Value: Boolean   ); begin SetBooleanField('HasTab2'      , Value);end;
Procedure TBasREturn.SetHasTab3     (Const Value: Boolean   ); begin SetBooleanField('HasTab3'      , Value);end;
Procedure TBasREturn.SetHasTab4     (Const Value: Boolean   ); begin SetBooleanField('HasTab4'      , Value);end;
function TBASReturn.getLines: TReturnLines;
begin
  Result := geTBASReturnLines;
  if Self.SilentMode then Result.SilentMode := True;
end;

 {TNZReturn}

constructor TNZReturn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'GSTReturn';
  fSQL := 'SELECT * FROM tblnzreturns';
end;


destructor TNZReturn.Destroy;
begin
  inherited;
end;


procedure TNZReturn.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Tab4_Type');
  SetPropertyFromNode(node,'Tab4_Month');
  SetPropertyFromNode(node,'Tab4_Year');
  SetPropertyFromNode(node,'BasSheetDesc');
  SetPropertyFromNode(node,'NZG5');
  SetPropertyFromNode(node,'NZG5Selected');
  SetPropertyFromNode(node,'NZG6');
  SetPropertyFromNode(node,'NZG6Selected');
  SetPropertyFromNode(node,'NZG7');
  SetPropertyFromNode(node,'NZG8');
  SetPropertyFromNode(node,'NZG9');
  SetPropertyFromNode(node,'NZG10');
  SetPropertyFromNode(node,'NZG11');
  SetPropertyFromNode(node,'NZG11Selected');
  SetPropertyFromNode(node,'NZG12');
  SetPropertyFromNode(node,'NZG13');
  SetPropertyFromNode(node,'NZG14');
  SetPropertyFromNode(node,'NZG15');
  SetPropertyFromNode(node,'NZG16');
  SetPropertyFromNode(node,'C1');
  SetPropertyFromNode(node,'C2');
  SetPropertyFromNode(node,'C3');
  SetPropertyFromNode(node,'C4');
  SetPropertyFromNode(node,'C5');
  SetPropertyFromNode(node,'C6');
  SetPropertyFromNode(node,'C7');
  SetPropertyFromNode(node,'C8');
  SetPropertyFromNode(node,'C9');
  SetPropertyFromNode(node,'C10');
  SetPropertyFromNode(node,'C11');
  SetPropertyFromNode(node,'C12');
  SetPropertyFromNode(node,'C13');
end;


procedure TNZReturn.NextReturn(ReturnPage: TReturnPage; Changetype:boolean =True);
var
  dtFrom , dtTo:TDatetime;
  stype:String;
begin
  if LastReturn(dtFrom, dtTo,  sType , ReturnPage) then begin
    Dtfrom := incDay(dtTo);
    if Changetype  or (Tab4_type = '') then Tab4_type := stype;
    Tab4_Month:= MonthnumberToName(monthof(DtFrom));
    Tab4_Year := yearof(dtFrom);
    postdb;
  end else begin
    if Changetype  or (Tab4_type = '') then Tab4_type := tPTTwoMonthly;
    Tab4_Month:=  MonthOfcurrent(Tab4_type);
    Tab4_Year := yearof(now);
    postdb;
  end;
end;

procedure TNZReturn.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Tab4_Type' ,Tab4_Type);
  AddXMLNode(node,'Tab4_Month' ,Tab4_Month);
  AddXMLNode(node,'Tab4_Year' ,Tab4_Year);
  AddXMLNode(node,'BasSheetDesc' ,BasSheetDesc);
  AddXMLNode(node,'NZG5' ,NZG5);
  AddXMLNode(node,'NZG5Selected' ,NZG5Selected);
  AddXMLNode(node,'NZG6' ,NZG6);
  AddXMLNode(node,'NZG6Selected' ,NZG6Selected);
  AddXMLNode(node,'NZG7' ,NZG7);
  AddXMLNode(node,'NZG8' ,NZG8);
  AddXMLNode(node,'NZG9' ,NZG9);
  AddXMLNode(node,'NZG10' ,NZG10);
  AddXMLNode(node,'NZG11' ,NZG11);
  AddXMLNode(node,'NZG11Selected' ,NZG11Selected);
  AddXMLNode(node,'NZG12' ,NZG12);
  AddXMLNode(node,'NZG13' ,NZG13);
  AddXMLNode(node,'NZG14' ,NZG14);
  AddXMLNode(node,'NZG15' ,NZG15);
  AddXMLNode(node,'NZG16' ,NZG16);
  AddXMLNode(node,'C1' ,C1);
  AddXMLNode(node,'C2' ,C2);
  AddXMLNode(node,'C3' ,C3);
  AddXMLNode(node,'C4' ,C4);
  AddXMLNode(node,'C5' ,C5);
  AddXMLNode(node,'C6' ,C6);
  AddXMLNode(node,'C7' ,C7);
  AddXMLNode(node,'C8' ,C8);
  AddXMLNode(node,'C9' ,C9);
  AddXMLNode(node,'C10' ,C10);
  AddXMLNode(node,'C11' ,C11);
  AddXMLNode(node,'C12' ,C12);
  AddXMLNode(node,'C13' ,C13);
end;


function TNZReturn.ValidateData: Boolean ;
begin
  Result := inherited ValidateData;
end;


function TNZReturn.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TNZReturn.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  SendEvent(BusobjEvent_ToDo, BusobjEvent_IDChange, self);
end;

Function TNZReturn.ValidateTab4DateRange:Boolean;
begin
  (* REsult := DateRangeValid('Tab4_Month' , 'Tab4_Year' , 'Tab4_Type' ,   Tab4_From ,Tab4_To); *)
  Result := TRue;
end;

procedure TNZReturn.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if SameText(Sender.Fieldname , 'Tab4_Type') then begin
    if not ValidateTab4DateRange then CancelDB;
    SendEvent(BusobjEvent_ToDo, BusobjEvent_DateRangeChange, self);
  end else if SameText(Sender.Fieldname , 'Tab4_Month') then begin
    if not ValidateTab4DateRange then CancelDB;
    SendEvent(BusobjEvent_ToDo, BusobjEvent_DateRangeChange, self);
  end else if SameText(Sender.Fieldname , 'Tab4_Year') then begin
    if not ValidateTab4DateRange then CancelDB;
    SendEvent(BusobjEvent_ToDo, BusobjEvent_DateRangeChange, self);
  end;

end;


function TNZReturn.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


function TNZReturn.getTab4_From: TDate;
begin
  result := 0;
  if Tab4_year = 0 then exit;
  if Tab4_Month = '' then exit;
  Result := EncodeDate(Tab4_year ,MonthNameToNumber(Tab4_Month) , 1);
end;
function TNZReturn.getTab4_To: TDate;
begin
  result := 0;
  if Tab4_year = 0 then exit;
  if Tab4_Month = '' then exit;
       if Tab4_Type = tPTMonthly     then Result := incDay(incMonth(Tab4_from , 1),-1)
  else if Tab4_Type = tPTQuarterly   then Result := incDay(incMonth(Tab4_from , 3),-1)
  else if Tab4_Type = tPTTwoMonthly then Result := incDay(incMonth(Tab4_from , 2),-1)
  else result :=Tab4_from;
end;

class function TNZReturn.GetIDField: string;
begin
  Result := 'ID'
end;


function TNZReturn.getLines: TReturnLines;
begin
  REsult :=geTNZReturnLines;
  if Self.SilentMode then Result.SilentMode := True;
end;

class function TNZReturn.GetBusObjectTablename: string;
begin
  Result:= 'tblnzreturns';
end;


function TNZReturn.DoAfterInsert(sender: TDatasetBusobj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;

  NextReturn(tRPnz);
  AllClass := true;
  AccMethod:= appenv.CompanyPrefs.DefaultAccountingMethod;//'Accrual';

    With CommonDBLib.tempMyQuery do try
      Sql.Add('SELECT AccMethod ,ID,NZG5Selected,NZG6Selected,NZG11Selected  ');
      Sql.Add('FROM tblnzreturns Where Active="T" ');
      Sql.Add('Order By ID desc Limit 1;');
      Open;
      if (RecordCount > 0) then begin
        First;
        AccMethod   := FieldByname('AccMethod').asString;
        NZG5Selected := FieldByName('NZG5Selected').AsString;
        NZG6Selected := FieldByName('NZG6Selected').AsString;
        NZG11Selected := FieldByName('NZG11Selected').AsString;
      end;
    finally
      ClosenFree;
    end;
    if NZG5Selected  = '' then NZG5Selected  := 'GST,EXP';
    if NZG6Selected  = '' then NZG6Selected  := 'FRE,EXP';
    if NZG11Selected = '' then NZG11Selected := 'GST';
end;

function TNZReturn.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TNZReturn.GetTab4_Type    : string    ; begin Result := GetStringField('Tab4_Type');end;
function  TNZReturn.GetTab4_Month   : string    ; begin Result := GetStringField('Tab4_Month');end;

function  TNZReturn.GetTab4_Year    : Integer   ; begin Result := GetIntegerField('Tab4_Year');end;
function  TNZReturn.GetBasSheetDesc : string    ; begin Result := GetStringField('BasSheetDesc');end;
function  TNZReturn.GetNZG5         : Double    ; begin Result := GetFloatField('NZG5');end;
function  TNZReturn.GetNZG5Selected : string    ; begin Result := GetStringField('NZG5Selected');end;
function  TNZReturn.GetNZG6         : Double    ; begin Result := GetFloatField('NZG6');end;
function  TNZReturn.GetNZG6Selected : string    ; begin Result := GetStringField('NZG6Selected');end;
function  TNZReturn.GetNZG7         : Double    ; begin Result := GetFloatField('NZG7');end;
function  TNZReturn.GetNZG8         : Double    ; begin Result := GetFloatField('NZG8');end;
function  TNZReturn.GetNZG9         : Double    ; begin Result := GetFloatField('NZG9');end;
function TNZReturn.geTNZReturnLines: TNZReturnLines;
begin
  REsult := TNZReturnLines(getcontainercomponent(TNZReturnLines , 'NZID = ' +inttostr(ID)));
end;

function  TNZReturn.GetNZG10        : Double    ; begin Result := GetFloatField('NZG10');end;
function  TNZReturn.GetNZG11        : Double    ; begin Result := GetFloatField('NZG11');end;
function  TNZReturn.GetNZG11Selected: string    ; begin Result := GetStringField('NZG11Selected');end;
function  TNZReturn.GetNZG12        : Double    ; begin Result := GetFloatField('NZG12');end;
function  TNZReturn.GetNZG13        : Double    ; begin Result := GetFloatField('NZG13');end;
function  TNZReturn.GetNZG14        : Double    ; begin Result := GetFloatField('NZG14');end;
function  TNZReturn.GetNZG15        : Double    ; begin Result := GetFloatField('NZG15');end;
function  TNZReturn.GetNZG16        : Double    ; begin Result := GetFloatField('NZG16');end;
function  TNZReturn.GetC1           : Double    ; begin Result := GetFloatField('C1');end;
function  TNZReturn.GetC2           : Double    ; begin Result := GetFloatField('C2');end;
function  TNZReturn.GetC3           : Double    ; begin Result := GetFloatField('C3');end;
function  TNZReturn.GetC4           : Double    ; begin Result := GetFloatField('C4');end;
function  TNZReturn.GetC5           : Double    ; begin Result := GetFloatField('C5');end;
function  TNZReturn.GetC6           : Double    ; begin Result := GetFloatField('C6');end;
function  TNZReturn.GetC7           : Double    ; begin Result := GetFloatField('C7');end;
function  TNZReturn.GetC8           : Double    ; begin Result := GetFloatField('C8');end;
function  TNZReturn.GetC9           : Double    ; begin Result := GetFloatField('C9');end;
function  TNZReturn.GetC10          : Double    ; begin Result := GetFloatField('C10');end;
function  TNZReturn.GetC11          : Double    ; begin Result := GetFloatField('C11');end;
function  TNZReturn.GetC12          : Double    ; begin Result := GetFloatField('C12');end;
function  TNZReturn.GetC13          : Double    ; begin Result := GetFloatField('C13');end;
function  TNZReturn.GetAccMethod    : string    ; begin Result := GetStringField('AccMethod');end;
function  TNZReturn.GetAllClass     : Boolean   ; begin Result := GetBooleanField('AllClass');end;
function  TNZReturn.GetClassID      : Integer   ; begin Result := GetIntegerField('ClassID');end;
function TNZReturn.getCodeFieldName: String;
begin
  Result := 'NZCode';
end;
function TNZReturn.getdescription: String;
begin
  REsult := BasSheetDesc;
end;

function TNZReturn.getHeaderIDFieldName: String;
begin
  Result := 'NZID';
end;
function TNZReturn.getHeaderDescfieldName: String;
begin
  Result := 'BasSheetDesc';
end;

procedure TNZReturn.SetTab4_Type    (const Value: string    ); begin SetStringField('Tab4_Type'     , Value);end;
procedure TNZReturn.SetTab4_Month   (const Value: string    ); begin SetStringField('Tab4_Month'    , Value);end;
procedure TNZReturn.SetTab4_Year    (const Value: Integer   ); begin SetIntegerField('Tab4_Year'     , Value);end;
procedure TNZReturn.SetBasSheetDesc (const Value: string    ); begin SetStringField('BasSheetDesc' , Value);end;
procedure TNZReturn.SetNZG5         (const Value: Double    ); begin SetFloatField('NZG5'          , Value);end;
procedure TNZReturn.SetNZG5Selected (const Value: string    ); begin SetStringField('NZG5Selected' , Value);end;
procedure TNZReturn.SetNZG6         (const Value: Double    ); begin SetFloatField('NZG6'          , Value);end;
procedure TNZReturn.SetNZG6Selected (const Value: string    ); begin SetStringField('NZG6Selected' , Value);end;
procedure TNZReturn.SetNZG7         (const Value: Double    ); begin SetFloatField('NZG7'          , Value);end;
procedure TNZReturn.SetNZG8         (const Value: Double    ); begin SetFloatField('NZG8'          , Value);end;
procedure TNZReturn.SetNZG9         (const Value: Double    ); begin SetFloatField('NZG9'          , Value);end;
procedure TNZReturn.SetNZG10        (const Value: Double    ); begin SetFloatField('NZG10'         , Value);end;
procedure TNZReturn.SetNZG11        (const Value: Double    ); begin SetFloatField('NZG11'         , Value);end;
procedure TNZReturn.SetNZG11Selected(const Value: string    ); begin SetStringField('NZG11Selected' , Value);end;
procedure TNZReturn.SetNZG12        (const Value: Double    ); begin SetFloatField('NZG12'         , Value);end;
procedure TNZReturn.SetNZG13        (const Value: Double    ); begin SetFloatField('NZG13'         , Value);end;
procedure TNZReturn.SetNZG14        (const Value: Double    ); begin SetFloatField('NZG14'         , Value);end;
procedure TNZReturn.SetNZG15        (const Value: Double    ); begin SetFloatField('NZG15'         , Value);end;
procedure TNZReturn.SetNZG16        (const Value: Double    ); begin SetFloatField('NZG16'         , Value);end;
procedure TNZReturn.SetC1           (const Value: Double    ); begin SetFloatField('C1'            , Value);end;
procedure TNZReturn.SetC2           (const Value: Double    ); begin SetFloatField('C2'            , Value);end;
procedure TNZReturn.SetC3           (const Value: Double    ); begin SetFloatField('C3'            , Value);end;
procedure TNZReturn.SetC4           (const Value: Double    ); begin SetFloatField('C4'            , Value);end;
procedure TNZReturn.SetC5           (const Value: Double    ); begin SetFloatField('C5'            , Value);end;
procedure TNZReturn.SetC6           (const Value: Double    ); begin SetFloatField('C6'            , Value);end;
procedure TNZReturn.SetC7           (const Value: Double    ); begin SetFloatField('C7'            , Value);end;
procedure TNZReturn.SetC8           (const Value: Double    ); begin SetFloatField('C8'            , Value);end;
procedure TNZReturn.SetC9           (const Value: Double    ); begin SetFloatField('C9'            , Value);end;
procedure TNZReturn.SetC10          (const Value: Double    ); begin SetFloatField('C10'           , Value);end;
procedure TNZReturn.SetC11          (const Value: Double    ); begin SetFloatField('C11'           , Value);end;
procedure TNZReturn.SetC12          (const Value: Double    ); begin SetFloatField('C12'           , Value);end;
procedure TNZReturn.SetC13          (const Value: Double    ); begin SetFloatField('C13'           , Value);end;
procedure TNZReturn.SetAccMethod    (const Value: string    ); begin SetStringField('AccMethod'     , Value);end;
procedure TNZReturn.SetAllClass     (const Value: Boolean   ); begin SetBooleanField('AllClass'      , Value);end;
procedure TNZReturn.SetClassID      (const Value: Integer   ); begin SetIntegerField('ClassID'       , Value);end;


procedure TNZReturn.Setdescription(const Value: String);
begin
  inherited;
  BasSheetDesc:= Value;
end;

{TReturnLines}

constructor TReturnLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'BasRturnLine';
  fSQL := 'SELECT * FROM tblBasReportLines';
end;


destructor TReturnLines.Destroy;
begin
  inherited;
end;


procedure TReturnLines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'BasID');
  SetPropertyFromNode(node,'TransGlobalref');
  SetPropertyFromNode(node,'Transtype');
  SetPropertyFromNode(node,'TransSeqno');
  SetPropertyFromNode(node,'ReportCode');
  SetPropertyFromNode(node,'Amount');
  SetDateTimePropertyFromNode(node , 'TransDate');
end;


procedure TReturnLines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ReportID' ,ReportID);
  AddXMLNode(node,'TransGlobalref' ,TransGlobalref);
  AddXMLNode(node,'Transtype' ,Transtype);
  AddXMLNode(node,'TransSeqno' ,TransSeqno);
  AddXMLNode(node,'ReportCode' ,ReportCode);
  AddXMLNode(node,'Amount' ,Amount);
  AddXMLNode(node,'TransDate' , TransDate);
end;


function TReturnLines.ValidateData: Boolean ;
begin
  Result := True;
end;


function TReturnLines.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TReturnLines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TReturnLines.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TReturnLines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TReturnLines.GetIDField: string;
begin
  Result := 'ID'
end;


class function TReturnLines.GetBusObjectTablename: string;
begin
  Result:= 'tblBasReportLines';
end;


function TReturnLines.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if assigned(Owner) then
    if Owner is TReturns then
      ReportID :=TReturns(Owner).ID;
end;

function TReturnLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TReturnLines.GetTransGlobalref: string    ; begin Result := GetStringField('TransGlobalref');end;
function  TReturnLines.GetTranstype     : string    ; begin Result := GetStringField('Transtype');end;
function  TReturnLines.GetTransSeqno    : Integer   ; begin Result := GetIntegerField('TransSeqno');end;
function  TReturnLines.GetAmount        : Double    ; begin Result := GetFloatField('Amount');end;
function  TReturnLines.GetTransDate     : TdateTime ; begin Result := GetDateTimeField('TransDate'); end;

procedure TReturnLines.SetTransGlobalref(const Value: string); begin SetStringField('TransGlobalref' , Value);end;
procedure TReturnLines.SetTranstype     (const Value: string); begin SetStringField('Transtype'      , Value);end;
procedure TReturnLines.SetTransSeqno    (const Value: Integer); begin SetIntegerField('TransSeqno'     , Value);end;
procedure TReturnLines.SetAmount        (const Value: Double); begin SetFloatField('Amount'         , Value);end;
Procedure TReturnLines.SetTransDate     (const Value: TDateTime); begin SetDateTimeField('TransDate' , Value);end;


{ TBASReturnLines }
function TBASReturnLines.GetReportCode: string ;begin Result := GetStringField('BASCode') ;end;
function TBASReturnLines.GetReportID  : Integer;begin REsult := getIntegerField('BASID')  ;end;
procedure TBASReturnLines.SetReportCode(const Value: string) ;begin SetStringField('BASCODE' , value);end;
procedure TBASReturnLines.SetReportID  (const Value: Integer);begin SetIntegerfield('BASID'  , Value);end;

{ TNZReturnLines }
constructor TNZReturnLines.Create(AOwner: TComponent);
begin
  inherited;
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'GSTReturnLine';
  fSQL := 'SELECT * FROM tblnzreportlines';
end;

class function TNZReturnLines.GetBusObjectTablename: string;
begin
  REsult := 'tblnzreportlines';
end;

function TNZReturnLines.GetReportCode: string ;begin Result := GetStringField('NZCode') ;end;
function TNZReturnLines.GetReportID  : Integer;begin REsult := getIntegerField('NZID')  ;end;
procedure TNZReturnLines.SetReportCode(const Value: string) ;begin SetStringField('NZCODE' , value);end;
procedure TNZReturnLines.SetReportID  (const Value: Integer);begin SetIntegerfield('NZID'  , Value);end;


{ TReturns }


{ TReturns }

function TReturns.DateFromSQL(MonthfieldNAme, yearfieldname: String): String;
begin
  REsult := 'STR_TO_DATE(concat("01/" , MonthNo('+monthfieldName+') , "/" , ' +yearfieldname+') ,"%d/%m/%Y")';
end;
function TReturns.DateRangeValid(const MonthfieldName, YearFieldName,  typefieldName: String; const DateFrom, DateTo: TDatetime): Boolean;
var
  s:String;
begin
  if (dateFrom =0) or (Dateto =0) then begin
    result := True;
    Exit;
  end;
  if (DateFrom <= Appenv.Companyprefs.SummarisedTransDate) or (DateTo <= Appenv.Companyprefs.SummarisedTransDate) then begin
    Result := False;
    Exit;
  end;

  s:= 'Select ID, ' ;
  if Self is TBasReturn then s := s + 'BasSheetDesc As Description, ' else if Self is TNZReturn then s := s + 'BasSheetDesc As Description , ' else s := s + 'VATDesc As Description , ';
  s:= s+   typefieldname +  ' REturnType, ' +  DateFromSQL(MonthFieldName , YearfieldName) +' as   Datefrom, ' +
        DateToSQL(MonthFieldName , YearfieldName , typefieldName) +' as  Dateto ' +
        ' from ' +  GetBusObjectTablename + ' where Active = "T" and ' +IDFieldName +' <> ' + inttostr(ID) + ' and ifnull(ClassId,0) = ' + inttostr(ClassID) + ' and ' +
        ' ( ' +
          ' ( ' + quotedstr(Formatdatetime(mysQLDatetimeformat , DateFrom)) +' <= ' + DateFromSQL(MonthFieldName , YearfieldName) + ' and ' + quotedstr(Formatdatetime(mysQLDatetimeformat , Dateto)) +' >= ' + DateFromSQL(MonthFieldName , YearfieldName) + ') or  ' +
          ' ( ' + quotedstr(Formatdatetime(mysQLDatetimeformat , DateFrom)) +' <= ' + DateToSQL(MonthFieldName , YearfieldName , typefieldName) + '  and ' + quotedstr(Formatdatetime(mysQLDatetimeformat , Dateto)) +' >= ' + DateToSQL(MonthFieldName , YearfieldName , typefieldName) + ')  or ' +
          ' ( ' + quotedstr(Formatdatetime(mysQLDatetimeformat , DateFrom)) +' >= ' + DateFromSQL(MonthFieldName , YearfieldName) + ' and ' + quotedstr(Formatdatetime(mysQLDatetimeformat , Dateto)) +' <= ' + DateToSQL(MonthFieldName , YearfieldName , typefieldName) + ')  or ' +
          ' (' + quotedstr(Formatdatetime(mysQLDatetimeformat , DateFrom)) +' <= ' + DateFromSQL(MonthFieldName , YearfieldName) + ' and ' + quotedstr(Formatdatetime(mysQLDatetimeformat , Dateto)) +' >= ' + DateToSQL(MonthFieldName , YearfieldName , typefieldName) + ')' +
        ')' ;
  With getNewDataset(s , true) do try
    if recordcount > 0 then begin
        s:= 'The Period you have selected ( From ' + Formatdatetime(FormatSettings.ShortDateFormat , DateFrom ) + ' to ' +  Formatdatetime(FormatSettings.ShortDateFormat , Dateto )  +') '+NL +
        'is Overlaping  in  ' + BusObjectTypeDescription + ' # ' + intTostr(FieldByname('ID').asInteger ) +' -  ' +NL+
        fieldbyname('Description').AsString + ' :  ' + fieldByname('REturnType').AsString +' from ' + FormatDatetime(FormatSettings.ShortDateFormat , fieldByname('Datefrom').asDAtetime) +'  to ' + FormatDatetime(FormatSettings.ShortDateFormat , fieldByname('DateTo').asDAtetime);
        Resultstatus.AddItem(False , rssError , 0,  s , True );
        Result := False;
    end else begin
      REsult := True;
    end;
  finally
      if active then close;
      Free;
  end;
end;

function TReturns.DateToSQL(MonthfieldNAme, yearfieldname, typefieldName: String): String;
begin
  REsult := 'Date_add(Date_add(' + DateFromSQL(monthfieldname, yearFieldname ) +'  , INTERVAL DateRangetypeToMonth(' + typefieldName +' ) Month) , INTERVAL -1 DAY)  ';
end;

procedure TReturns.DeleteAllLines(sCode: String);
var
  fsFilter:String;
begin
  if CodeFieldName = '' then exit;

  fsFilter:=Lines.filter;
  if Lines.filter <> '' then Lines.filter := '(' + Lines.filter +') and ';
  Lines.filter := '(' +CodeFieldName +' = ' + Quotedstr(sCode)+')';
  Lines.Filtered:= true;
  Try
    Lines.deleteAll;
  Finally
    Lines.filter:= fsfilter;
    Lines.filtered:= Lines.filter<> ''
  End;
end;

function TReturns.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  SumTransDate :=Appenv.Companyprefs.SummarisedTransDate ;
end;

function TReturns.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not result then exit;
  if SumTransDate <> Appenv.Companyprefs.SummarisedTransDate  then
    SumTransDate :=Appenv.Companyprefs.SummarisedTransDate ;
end;

function TReturns.GetActive: Boolean;begin Result := GetBooleanField('Active');end;
function TReturns.getCodeFieldName: String;
begin
  REsult := '';
end;


function TReturns.getdescription: String;
begin
  REsult := '';
end;

function TReturns.GetDone: Boolean;begin REsult := GetbooleanField('Done'); end;

function TReturns.getHeaderIDFieldName: String;
begin
  Result := '';
end;
function TReturns.getHeaderDescfieldName: String;
begin
  Result := '';
end;



function TReturns.getSumTransDate: TDatetime;
begin
  REsult:= GetDateTimefield('SummarisedTransDate');
end;

function TReturns.LastReturn(var ReturnFrom, Returnto: Tdatetime;  var  Retunrtype:String;  ReturnPage: TReturnPage):Boolean;
var
  Sql:String;
  function FieldPrefix:String;
  begin
    REsult := '';
         if ReturnPage = tRPBasTab1  then REsult := 'Tab1_'
    else if ReturnPage = tRPBASTab2  then REsult := 'Tab2_'
    else if ReturnPage = tRPBASTab3  then REsult := 'Tab3_'
    else if ReturnPage = TRPNZ       then REsult := 'Tab4_'
    else if ReturnPage = tRPBASTab4  then REsult := 'Tab4_'
    else if ReturnPage = tRPVAT      then REsult := '';
  end;
begin
  SQL:= 'Select ' +
        ' Date(concat(Header.'+FieldPrefix+'Year, "/" , Monthno(Header.'+FieldPrefix+'Month) , "/01" )) Datefrom , ' +
        ' header.'+FieldPrefix+'type  type' +
        ' from ' + GetBusObjectTablename  +' Header  ' +
        ' where Header.Active ="T" ';
  if ID<> 0 then  SQL:= SQL+' and Header.' +IDfieldname + ' < ' +inttostr(ID) ;
       if ReturnPage = tRPBasTab1 then SQL:= SQL+' and Header.HasTab1 = "T"'
  else if ReturnPage = tRPBasTab2 then SQL:= SQL+' and Header.HasTab2 = "T"'
  else if ReturnPage = tRPBasTab3 then SQL:= SQL+' and Header.HasTab3 = "T"'
  else if ReturnPage = tRPBasTab4 then SQL:= SQL+' and Header.HasTab4 = "T"';
  if ID <> 0 then SQL:= SQL+' and Header.' +IDFieldName + ' <> ' + inttostr(ID);
  SQL := SQL+ ' order by Datefrom desc limit 1';
  With getNewdataset(SQL , true) do try
    result := recordcount >0;
    Retunrtype :=Fieldbyname('type').asString;
    ReturnFrom := FieldByname('DateFrom').asDateTime;
         if Fieldbyname('type').asString = tPTMonthly     then  Returnto := incday(incmonth(ReturnFrom , 1),-1)
    else if Fieldbyname('type').asString = tPTTwoMonthly  then  Returnto := incday(incmonth(ReturnFrom , 2),-1)
    else if Fieldbyname('type').asString = tPTQuarterly   then  Returnto := incday(incmonth(ReturnFrom , 3),-1)
    else if Fieldbyname('type').asString = tPTSixMonthly   then  Returnto := incday(incmonth(ReturnFrom, 6),-1)
    else Returnto :=ReturnFrom;
  finally
    if active then close;
    Free;
  end;
end;

procedure TReturns.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'AccMethod');
  SetBooleanPropertyFromNode(node,'AllClass');
  SetPropertyFromNode(node,'ClassID');
  SetBooleanPropertyFromNode(node,'Active');
  SetBooleanPropertyFromNode(node,'Done');
end;
function TReturns.MonthNumberToName(const Month: Integer): String;
begin
           if Month = 1  then result := 'January'
  else if Month = 2  then result := 'February'
  else if Month = 3  then result := 'March'
  else if Month = 4  then result := 'April'
  else if Month = 5  then result := 'May'
  else if Month = 6  then result := 'June'
  else if Month = 7  then result := 'July'
  else if Month = 8  then result := 'August'
  else if Month = 9  then result := 'September'
  else if Month = 10 then result := 'October'
  else if Month = 11 then result := 'November'
  else if Month = 12 then result := 'December'
  else Result := '';
end;
function TReturns.MonthNameToNumber(const Month: string): integer;
begin
  if Month = 'January' then begin
    Result := 1;
  end else if Month = 'February' then begin
    Result := 2;
  end else if Month = 'March' then begin
    Result := 3;
  end else if Month = 'April' then begin
    Result := 4;
  end else if Month = 'May' then begin
    Result := 5;
  end else if Month = 'June' then begin
    Result := 6;
  end else if Month = 'July' then begin
    Result := 7;
  end else if Month = 'August' then begin
    Result := 8;
  end else if Month = 'September' then begin
    Result := 9;
  end else if Month = 'October' then begin
    Result := 10;
  end else if Month = 'November' then begin
    Result := 11;
  end else if Month = 'December' then begin
    Result := 12;
  end else begin
    Result := 0;
  end;
end;

function TReturns.MonthOfCurrent(Period: String): String;
var
  ctr:Integer;
begin
  ctr:=Monthof(Date);
  if Period = tPTMonthly    then begin
    Result  :=MonthNumberToName(ctr);
  end else if Period = tPTTwoMonthly then begin
    if ctr in [1,3,5,7,9,11] then result :=MonthNumberToName(ctr)
    else result :=MonthNumberToName(ctr-1);
  end else if Period = tPTQuarterly  then begin
    if ctr in [1,4,7,10] then result :=MonthNumberToName(ctr)
    else if ctr in [2,5,8,11] then result :=MonthNumberToName(ctr-1)
    else result :=MonthNumberToName(ctr-2);
  end else if Period = tPTSixMonthly  then begin
    if ctr <= 6 then result :=MonthNumberToName(1)
    else result :=MonthNumberToName(6);
  end;
end;

procedure TReturns.NextReturn(ReturnPage: TReturnPage; Changetype:boolean =True);
begin

end;

procedure TReturns.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'AccMethod' ,AccMethod);
  AddXMLNode(node,'AllClass' ,AllClass);
  AddXMLNode(node,'ClassID' ,ClassID);
  AddXMLNode(node,'Active' ,Active);
  AddXMLNode(node,'Done' ,Done);
end;

procedure TReturns.SetActive(const Value: Boolean);begin  SetBooleanField('Active' , value);end;

procedure TReturns.Setdescription(const Value: String);
begin

end;

procedure TReturns.SetDone(const Value: Boolean);begin SetBooleanfield('Done' , Value);end;


procedure TReturns.setSumTransDate(const Value: TDatetime);
begin
  SetDateTimefield('SummarisedTransDate', Value);
end;

function TReturns.ValidateData: Boolean;
begin
  Result := False;
  Resultstatus.Clear;
  if Description = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'Description should not be blank.' , True);
    Exit;
  end;
  if (ClassID = 0) and (Allclass=False) then begin
    Resultstatus.AddItem(False , rssError , 0,  appenv.DefaultClass.ClassHeading +' Should not be blank.' , True);
    Exit;
  end;
(*   if lines.count=0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'This is an Empty ' + QuotedStr(BusObjectTypeDescription) +'. Please make selections and calulate.' , True );
    Exit;
  end; *)
  Result := True;
end;

initialization
  RegisterClass(TBASReturnLines);
  RegisterClass(TNZReturn);
  RegisterClass(TBASReturn);


end.
