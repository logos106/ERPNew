unit BusobjRepairsExportConfig;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  22/03/10  1.00.00  BJ  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TRepairsExportConfigBase = class(TMSBusObj)
  private
    Defaultconfig:String;
    function GetManufactureId    : Integer   ;
    function GetF1               : string    ;
    function GetF2               : string    ;
    function GetF3               : string    ;
    function GetF4               : string    ;
    function GetF5               : string    ;
    function GetF6               : string    ;
    function GetF7               : string    ;
    function GetF8               : string    ;
    function GetF9               : string    ;
    function GetF10              : string    ;
    function GetF11              : string    ;
    function GetF12              : string    ;
    function GetF13              : string    ;
    function GetF14              : string    ;
    function GetF15              : string    ;
    function GetF16              : string    ;
    function GetF17              : string    ;
    function GetF18              : string    ;
    function GetF19              : string    ;
    function GetF20              : string    ;
    function GetF21              : string    ;
    function GetF22              : string    ;
    function GetF23              : string    ;
    function GetF24              : string    ;
    function GetF25              : string    ;
    function GetF26              : string    ;
    function GetF27              : string    ;
    function GetF28              : string    ;
    function GetF29              : string    ;
    function GetF30              : string    ;
    function GetF31              : string    ;
    function GetF32              : string    ;
    function GetF33              : string    ;
    function GetF34              : string    ;
    function GetF35              : string    ;
    function GetF36              : string    ;
    function GetF37              : string    ;
    function GetF38              : string    ;
    function GetF39              : string    ;
    function GetACTIVE           : Boolean   ;
    Function GetShowF1	:Boolean;
    Function GetShowF2	:Boolean;
    Function GetShowF3	:Boolean;
    Function GetShowF4	:Boolean;
    Function GetShowF5	:Boolean;
    Function GetShowF6	:Boolean;
    Function GetShowF7	:Boolean;
    Function GetShowF8	:Boolean;
    Function GetShowF9	:Boolean;
    Function GetShowF10	:Boolean;
    Function GetShowF11	:Boolean;
    Function GetShowF12	:Boolean;
    Function GetShowF13	:Boolean;
    Function GetShowF14	:Boolean;
    Function GetShowF15	:Boolean;
    Function GetShowF16	:Boolean;
    Function GetShowF17	:Boolean;
    Function GetShowF18	:Boolean;
    Function GetShowF19	:Boolean;
    Function GetShowF20	:Boolean;
    Function GetShowF21	:Boolean;
    Function GetShowF22	:Boolean;
    Function GetShowF23	:Boolean;
    Function GetShowF24	:Boolean;
    Function GetShowF25	:Boolean;
    Function GetShowF26	:Boolean;
    Function GetShowF27	:Boolean;
    Function GetShowF28	:Boolean;
    Function GetShowF29	:Boolean;
    Function GetShowF30	:Boolean;
    Function GetShowF31	:Boolean;
    Function GetShowF32	:Boolean;
    Function GetShowF33	:Boolean;
    Function GetShowF34	:Boolean;
    Function GetShowF35	:Boolean;
    Function GetShowF36	:Boolean;
    Function GetOrder1	:Integer;
    Function GetOrder2	:Integer;
    Function GetOrder3	:Integer;
    Function GetOrder4	:Integer;
    Function GetOrder5	:Integer;
    Function GetOrder6	:Integer;
    Function GetOrder7	:Integer;
    Function GetOrder8	:Integer;
    Function GetOrder9	:Integer;
    Function GetOrder10	:Integer;
    Function GetOrder11	:Integer;
    Function GetOrder12	:Integer;
    Function GetOrder13	:Integer;
    Function GetOrder14	:Integer;
    Function GetOrder15	:Integer;
    Function GetOrder16	:Integer;
    Function GetOrder17	:Integer;
    Function GetOrder18	:Integer;
    Function GetOrder19	:Integer;
    Function GetOrder20	:Integer;
    Function GetOrder21	:Integer;
    Function GetOrder22	:Integer;
    Function GetOrder23	:Integer;
    Function GetOrder24	:Integer;
    Function GetOrder25	:Integer;
    Function GetOrder26	:Integer;
    Function GetOrder27	:Integer;
    Function GetOrder28	:Integer;
    Function GetOrder29	:Integer;
    Function GetOrder30	:Integer;
    Function GetOrder31	:Integer;
    Function GetOrder32	:Integer;
    Function GetOrder33	:Integer;
    Function GetOrder34	:Integer;
    Function GetOrder35	:Integer;
    Function GetOrder36	:Integer;

    procedure SetManufactureId    (const Value: Integer   );
    procedure SetF1               (const Value: string    );
    procedure SetF2               (const Value: string    );
    procedure SetF3               (const Value: string    );
    procedure SetF4               (const Value: string    );
    procedure SetF5               (const Value: string    );
    procedure SetF6               (const Value: string    );
    procedure SetF7               (const Value: string    );
    procedure SetF8               (const Value: string    );
    procedure SetF9               (const Value: string    );
    procedure SetF10              (const Value: string    );
    procedure SetF11              (const Value: string    );
    procedure SetF12              (const Value: string    );
    procedure SetF13              (const Value: string    );
    procedure SetF14              (const Value: string    );
    procedure SetF15              (const Value: string    );
    procedure SetF16              (const Value: string    );
    procedure SetF17              (const Value: string    );
    procedure SetF18              (const Value: string    );
    procedure SetF19              (const Value: string    );
    procedure SetF20              (const Value: string    );
    procedure SetF21              (const Value: string    );
    procedure SetF22              (const Value: string    );
    procedure SetF23              (const Value: string    );
    procedure SetF24              (const Value: string    );
    procedure SetF25              (const Value: string    );
    procedure SetF26              (const Value: string    );
    procedure SetF27              (const Value: string    );
    procedure SetF28              (const Value: string    );
    procedure SetF29              (const Value: string    );
    procedure SetF30              (const Value: string    );
    procedure SetF31              (const Value: string    );
    procedure SetF32              (const Value: string    );
    procedure SetF33              (const Value: string    );
    procedure SetF34              (const Value: string    );
    procedure SetF35              (const Value: string    );
    procedure SetF36              (const Value: string    );
    procedure SetF37              (const Value: string    );
    procedure SetF38              (const Value: string    );
    procedure SetF39              (const Value: string    );
    procedure SetACTIVE           (const Value: Boolean   );
    Procedure SetShowF1	(Const Value :Boolean);
    Procedure SetShowF2	(Const Value :Boolean);
    Procedure SetShowF3	(Const Value :Boolean);
    Procedure SetShowF4	(Const Value :Boolean);
    Procedure SetShowF5	(Const Value :Boolean);
    Procedure SetShowF6	(Const Value :Boolean);
    Procedure SetShowF7	(Const Value :Boolean);
    Procedure SetShowF8	(Const Value :Boolean);
    Procedure SetShowF9	(Const Value :Boolean);
    Procedure SetShowF10	(Const Value :Boolean);
    Procedure SetShowF11	(Const Value :Boolean);
    Procedure SetShowF12	(Const Value :Boolean);
    Procedure SetShowF13	(Const Value :Boolean);
    Procedure SetShowF14	(Const Value :Boolean);
    Procedure SetShowF15	(Const Value :Boolean);
    Procedure SetShowF16	(Const Value :Boolean);
    Procedure SetShowF17	(Const Value :Boolean);
    Procedure SetShowF18	(Const Value :Boolean);
    Procedure SetShowF19	(Const Value :Boolean);
    Procedure SetShowF20	(Const Value :Boolean);
    Procedure SetShowF21	(Const Value :Boolean);
    Procedure SetShowF22	(Const Value :Boolean);
    Procedure SetShowF23	(Const Value :Boolean);
    Procedure SetShowF24	(Const Value :Boolean);
    Procedure SetShowF25	(Const Value :Boolean);
    Procedure SetShowF26	(Const Value :Boolean);
    Procedure SetShowF27	(Const Value :Boolean);
    Procedure SetShowF28	(Const Value :Boolean);
    Procedure SetShowF29	(Const Value :Boolean);
    Procedure SetShowF30	(Const Value :Boolean);
    Procedure SetShowF31	(Const Value :Boolean);
    Procedure SetShowF32	(Const Value :Boolean);
    Procedure SetShowF33	(Const Value :Boolean);
    Procedure SetShowF34	(Const Value :Boolean);
    Procedure SetShowF35	(Const Value :Boolean);
    Procedure SetShowF36	(Const Value :Boolean);
    Procedure SetOrder1	(Value :Integer);
    Procedure SetOrder2	(Value :Integer);
    Procedure SetOrder3	(Value :Integer);
    Procedure SetOrder4	(Value :Integer);
    Procedure SetOrder5	(Value :Integer);
    Procedure SetOrder6	(Value :Integer);
    Procedure SetOrder7	(Value :Integer);
    Procedure SetOrder8	(Value :Integer);
    Procedure SetOrder9	(Value :Integer);
    Procedure SetOrder10	(Value :Integer);
    Procedure SetOrder11	(Value :Integer);
    Procedure SetOrder12	(Value :Integer);
    Procedure SetOrder13	(Value :Integer);
    Procedure SetOrder14	(Value :Integer);
    Procedure SetOrder15	(Value :Integer);
    Procedure SetOrder16	(Value :Integer);
    Procedure SetOrder17	(Value :Integer);
    Procedure SetOrder18	(Value :Integer);
    Procedure SetOrder19	(Value :Integer);
    Procedure SetOrder20	(Value :Integer);
    Procedure SetOrder21	(Value :Integer);
    Procedure SetOrder22	(Value :Integer);
    Procedure SetOrder23	(Value :Integer);
    Procedure SetOrder24	(Value :Integer);
    Procedure SetOrder25	(Value :Integer);
    Procedure SetOrder26	(Value :Integer);
    Procedure SetOrder27	(Value :Integer);
    Procedure SetOrder28	(Value :Integer);
    Procedure SetOrder29	(Value :Integer);
    Procedure SetOrder30	(Value :Integer);
    Procedure SetOrder31	(Value :Integer);
    Procedure SetOrder32	(Value :Integer);
    Procedure SetOrder33	(Value :Integer);
    Procedure SetOrder34	(Value :Integer);
    Procedure SetOrder35	(Value :Integer);
    Procedure SetOrder36	(Value :Integer);
    function getDateformat: String;
    procedure setDateformat(const Value: String);
    function getReceiptNumberCaption: String;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    function  DoBeforeInsert(Sender:TDatasetBusObj) : Boolean;          override;
  public
    procedure DoFieldOnChange(Sender: TField);                          override;
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    Procedure New; override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Procedure loadForManufacture(Manufacture:Integer);
    Property ReceiptNumberCaption :String read getReceiptNumberCaption;
  published
    property ManufactureId     :Integer     read GetManufactureId   write SetManufactureId;
    property F1                :string      read GetF1              write SetF1           ;
    property F2                :string      read GetF2              write SetF2           ;
    property F3                :string      read GetF3              write SetF3           ;
    property F4                :string      read GetF4              write SetF4           ;
    property F5                :string      read GetF5              write SetF5           ;
    property F6                :string      read GetF6              write SetF6           ;
    property F7                :string      read GetF7              write SetF7           ;
    property F8                :string      read GetF8              write SetF8           ;
    property F9                :string      read GetF9              write SetF9           ;
    property F10               :string      read GetF10             write SetF10          ;
    property F11               :string      read GetF11             write SetF11          ;
    property F12               :string      read GetF12             write SetF12          ;
    property F13               :string      read GetF13             write SetF13          ;
    property F14               :string      read GetF14             write SetF14          ;
    property F15               :string      read GetF15             write SetF15          ;
    property F16               :string      read GetF16             write SetF16          ;
    property F17               :string      read GetF17             write SetF17          ;
    property F18               :string      read GetF18             write SetF18          ;
    property F19               :string      read GetF19             write SetF19          ;
    property F20               :string      read GetF20             write SetF20          ;
    property F21               :string      read GetF21             write SetF21          ;
    property F22               :string      read GetF22             write SetF22          ;
    property F23               :string      read GetF23             write SetF23          ;
    property F24               :string      read GetF24             write SetF24          ;
    property F25               :string      read GetF25             write SetF25          ;
    property F26               :string      read GetF26             write SetF26          ;
    property F27               :string      read GetF27             write SetF27          ;
    property F28               :string      read GetF28             write SetF28          ;
    property F29               :string      read GetF29             write SetF29          ;
    property F30               :string      read GetF30             write SetF30          ;
    property F31               :string      read GetF31             write SetF31          ;
    property F32               :string      read GetF32             write SetF32          ;
    property F33               :string      read GetF33             write SetF33          ;
    property F34               :string      read GetF34             write SetF34          ;
    property F35               :string      read GetF35             write SetF35          ;
    property F36               :string      read GetF36             write SetF36          ;
    property F37               :string      read GetF37             write SetF37          ;
    property F38               :string      read GetF38             write SetF38          ;
    property F39               :string      read GetF39             write SetF39          ;
    property ACTIVE            :Boolean     read GetACTIVE          write SetACTIVE       ;
    Property ShowF1	  :Boolean Read getShowF1	  Write SetShowF1	;
    Property ShowF2	  :Boolean Read getShowF2	  Write SetShowF2	;
    Property ShowF3	  :Boolean Read getShowF3	  Write SetShowF3	;
    Property ShowF4	  :Boolean Read getShowF4	  Write SetShowF4	;
    Property ShowF5	  :Boolean Read getShowF5	  Write SetShowF5	;
    Property ShowF6	  :Boolean Read getShowF6	  Write SetShowF6	;
    Property ShowF7	  :Boolean Read getShowF7	  Write SetShowF7	;
    Property ShowF8	  :Boolean Read getShowF8	  Write SetShowF8	;
    Property ShowF9	  :Boolean Read getShowF9	  Write SetShowF9	;
    Property ShowF10	:Boolean Read getShowF10	Write SetShowF10	;
    Property ShowF11	:Boolean Read getShowF11	Write SetShowF11	;
    Property ShowF12	:Boolean Read getShowF12	Write SetShowF12	;
    Property ShowF13	:Boolean Read getShowF13	Write SetShowF13	;
    Property ShowF14	:Boolean Read getShowF14	Write SetShowF14	;
    Property ShowF15	:Boolean Read getShowF15	Write SetShowF15	;
    Property ShowF16	:Boolean Read getShowF16	Write SetShowF16	;
    Property ShowF17	:Boolean Read getShowF17	Write SetShowF17	;
    Property ShowF18	:Boolean Read getShowF18	Write SetShowF18	;
    Property ShowF19	:Boolean Read getShowF19	Write SetShowF19	;
    Property ShowF20	:Boolean Read getShowF20	Write SetShowF20	;
    Property ShowF21	:Boolean Read getShowF21	Write SetShowF21	;
    Property ShowF22	:Boolean Read getShowF22	Write SetShowF22	;
    Property ShowF23	:Boolean Read getShowF23	Write SetShowF23	;
    Property ShowF24	:Boolean Read getShowF24	Write SetShowF24	;
    Property ShowF25	:Boolean Read getShowF25	Write SetShowF25	;
    Property ShowF26	:Boolean Read getShowF26	Write SetShowF26	;
    Property ShowF27	:Boolean Read getShowF27	Write SetShowF27	;
    Property ShowF28	:Boolean Read getShowF28	Write SetShowF28	;
    Property ShowF29	:Boolean Read getShowF29	Write SetShowF29	;
    Property ShowF30	:Boolean Read getShowF30	Write SetShowF30	;
    Property ShowF31	:Boolean Read getShowF31	Write SetShowF31	;
    Property ShowF32	:Boolean Read getShowF32	Write SetShowF32	;
    Property ShowF33	:Boolean Read getShowF33	Write SetShowF33	;
    Property ShowF34	:Boolean Read getShowF34	Write SetShowF34	;
    Property ShowF35	:Boolean Read getShowF35	Write SetShowF35	;
    Property ShowF36	:Boolean Read getShowF36	Write SetShowF36	;
    Property F1Order	  :Integer Read getOrder1	  Write SetOrder1	;
    Property F2Order	  :Integer Read getOrder2	  Write SetOrder2	;
    Property F3Order	  :Integer Read getOrder3	  Write SetOrder3	;
    Property F4Order	  :Integer Read getOrder4	  Write SetOrder4	;
    Property F5Order	  :Integer Read getOrder5	  Write SetOrder5	;
    Property F6Order	  :Integer Read getOrder6	  Write SetOrder6	;
    Property F7Order	  :Integer Read getOrder7	  Write SetOrder7	;
    Property F8Order	  :Integer Read getOrder8	  Write SetOrder8	;
    Property F9Order	  :Integer Read getOrder9	  Write SetOrder9	;
    Property F10Order	:Integer Read getOrder10	Write SetOrder10	;
    Property F11Order	:Integer Read getOrder11	Write SetOrder11	;
    Property F12Order	:Integer Read getOrder12	Write SetOrder12	;
    Property F13Order	:Integer Read getOrder13	Write SetOrder13	;
    Property F14Order	:Integer Read getOrder14	Write SetOrder14	;
    Property F15Order	:Integer Read getOrder15	Write SetOrder15	;
    Property F16Order	:Integer Read getOrder16	Write SetOrder16	;
    Property F17Order	:Integer Read getOrder17	Write SetOrder17	;
    Property F18Order	:Integer Read getOrder18	Write SetOrder18	;
    Property F19Order	:Integer Read getOrder19	Write SetOrder19	;
    Property F20Order	:Integer Read getOrder20	Write SetOrder20	;
    Property F21Order	:Integer Read getOrder21	Write SetOrder21	;
    Property F22Order	:Integer Read getOrder22	Write SetOrder22	;
    Property F23Order	:Integer Read getOrder23	Write SetOrder23	;
    Property F24Order	:Integer Read getOrder24	Write SetOrder24	;
    Property F25Order	:Integer Read getOrder25	Write SetOrder25	;
    Property F26Order	:Integer Read getOrder26	Write SetOrder26	;
    Property F27Order	:Integer Read getOrder27	Write SetOrder27	;
    Property F28Order	:Integer Read getOrder28	Write SetOrder28	;
    Property F29Order	:Integer Read getOrder29	Write SetOrder29	;
    Property F30Order	:Integer Read getOrder30	Write SetOrder30	;
    Property F31Order	:Integer Read getOrder31	Write SetOrder31	;
    Property F32Order	:Integer Read getOrder32	Write SetOrder32	;
    Property F33Order	:Integer Read getOrder33	Write SetOrder33	;
    Property F34Order	:Integer Read getOrder34	Write SetOrder34	;
    Property F35Order	:Integer Read getOrder35	Write SetOrder35	;
    Property F36Order	:Integer Read getOrder36	Write SetOrder36	;

    Property Dateformat        :String      read getDateformat      Write setDateformat; 
  end;

  TRepairsExportConfig = class(TRepairsExportConfigBase)
  Private
    function getBaseConfig: TRepairsExportConfigBase;
  Protected
  Public
    Property BaseConfig :TRepairsExportConfigBase REad getBaseConfig;
  end;

implementation


uses tcDataUtils, CommonLib, sysutils , Variants;



  {TRepairsExportConfigBase}

constructor TRepairsExportConfigBase.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'RepairsExportConfig';
  fSQL := 'SELECT * FROM tblrepairsexportconfig';
  fSQLOrder := 'ManufactureId Desc';
end;


destructor TRepairsExportConfigBase.Destroy;
begin
  inherited;
end;


procedure TRepairsExportConfigBase.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ManufactureId');
  SetPropertyFromNode(node,'F1');
  SetPropertyFromNode(node,'F2');
  SetPropertyFromNode(node,'F3');
  SetPropertyFromNode(node,'F4');
  SetPropertyFromNode(node,'F5');
  SetPropertyFromNode(node,'F6');
  SetPropertyFromNode(node,'F7');
  SetPropertyFromNode(node,'F8');
  SetPropertyFromNode(node,'F9');
  SetPropertyFromNode(node,'F10');
  SetPropertyFromNode(node,'F11');
  SetPropertyFromNode(node,'F12');
  SetPropertyFromNode(node,'F13');
  SetPropertyFromNode(node,'F14');
  SetPropertyFromNode(node,'F15');
  SetPropertyFromNode(node,'F16');
  SetPropertyFromNode(node,'F17');
  SetPropertyFromNode(node,'F18');
  SetPropertyFromNode(node,'F19');
  SetPropertyFromNode(node,'F20');
  SetPropertyFromNode(node,'F21');
  SetPropertyFromNode(node,'F22');
  SetPropertyFromNode(node,'F23');
  SetPropertyFromNode(node,'F24');
  SetPropertyFromNode(node,'F25');
  SetPropertyFromNode(node,'F26');
  SetPropertyFromNode(node,'F27');
  SetPropertyFromNode(node,'F28');
  SetPropertyFromNode(node,'F29');
  SetPropertyFromNode(node,'F30');
  SetPropertyFromNode(node,'F31');
  SetPropertyFromNode(node,'F32');
  SetPropertyFromNode(node,'F33');
  SetPropertyFromNode(node,'F34');
  SetPropertyFromNode(node,'F35');
  SetPropertyFromNode(node,'F36');
  SetPropertyFromNode(node,'F37');
  SetPropertyFromNode(node,'F38');
  SetPropertyFromNode(node,'F39');
  SetPropertyFromNode(node,'F1Order');
  SetPropertyFromNode(node,'F2Order');
  SetPropertyFromNode(node,'F3Order');
  SetPropertyFromNode(node,'F4Order');
  SetPropertyFromNode(node,'F5Order');
  SetPropertyFromNode(node,'F6Order');
  SetPropertyFromNode(node,'F7Order');
  SetPropertyFromNode(node,'F8Order');
  SetPropertyFromNode(node,'F9Order');
  SetPropertyFromNode(node,'F10Order');
  SetPropertyFromNode(node,'F11Order');
  SetPropertyFromNode(node,'F12Order');
  SetPropertyFromNode(node,'F13Order');
  SetPropertyFromNode(node,'F14Order');
  SetPropertyFromNode(node,'F15Order');
  SetPropertyFromNode(node,'F16Order');
  SetPropertyFromNode(node,'F17Order');
  SetPropertyFromNode(node,'F18Order');
  SetPropertyFromNode(node,'F19Order');
  SetPropertyFromNode(node,'F20Order');
  SetPropertyFromNode(node,'F21Order');
  SetPropertyFromNode(node,'F22Order');
  SetPropertyFromNode(node,'F23Order');
  SetPropertyFromNode(node,'F24Order');
  SetPropertyFromNode(node,'F25Order');
  SetPropertyFromNode(node,'F26Order');
  SetPropertyFromNode(node,'F27Order');
  SetPropertyFromNode(node,'F28Order');
  SetPropertyFromNode(node,'F29Order');
  SetPropertyFromNode(node,'F30Order');
  SetPropertyFromNode(node,'F31Order');
  SetPropertyFromNode(node,'F32Order');
  SetPropertyFromNode(node,'F33Order');
  SetPropertyFromNode(node,'F34Order');
  SetPropertyFromNode(node,'F35Order');
  SetPropertyFromNode(node,'F36Order');
  SetPropertyFromNode(node,'F37Order');
  SetPropertyFromNode(node,'F38Order');
  SetPropertyFromNode(node,'F39Order');
  SetPropertyFromNode(node,'Dateformat');
  SetBooleanPropertyFromNode(node,'ACTIVE');
end;


procedure TRepairsExportConfigBase.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ManufactureId' ,ManufactureId);
  AddXMLNode(node,'F1' ,F1);
  AddXMLNode(node,'F2' ,F2);
  AddXMLNode(node,'F3' ,F3);
  AddXMLNode(node,'F4' ,F4);
  AddXMLNode(node,'F5' ,F5);
  AddXMLNode(node,'F6' ,F6);
  AddXMLNode(node,'F7' ,F7);
  AddXMLNode(node,'F8' ,F8);
  AddXMLNode(node,'F9' ,F9);
  AddXMLNode(node,'F10' ,F10);
  AddXMLNode(node,'F11' ,F11);
  AddXMLNode(node,'F12' ,F12);
  AddXMLNode(node,'F13' ,F13);
  AddXMLNode(node,'F14' ,F14);
  AddXMLNode(node,'F15' ,F15);
  AddXMLNode(node,'F16' ,F16);
  AddXMLNode(node,'F17' ,F17);
  AddXMLNode(node,'F18' ,F18);
  AddXMLNode(node,'F19' ,F19);
  AddXMLNode(node,'F20' ,F20);
  AddXMLNode(node,'F21' ,F21);
  AddXMLNode(node,'F22' ,F22);
  AddXMLNode(node,'F23' ,F23);
  AddXMLNode(node,'F24' ,F24);
  AddXMLNode(node,'F25' ,F25);
  AddXMLNode(node,'F26' ,F26);
  AddXMLNode(node,'F27' ,F27);
  AddXMLNode(node,'F28' ,F28);
  AddXMLNode(node,'F29' ,F29);
  AddXMLNode(node,'F30' ,F30);
  AddXMLNode(node,'F31' ,F31);
  AddXMLNode(node,'F32' ,F32);
  AddXMLNode(node,'F33' ,F33);
  AddXMLNode(node,'F34' ,F34);
  AddXMLNode(node,'F35' ,F35);
  AddXMLNode(node,'F36' ,F36);
  AddXMLNode(node,'F37' ,F37);
  AddXMLNode(node,'F38' ,F38);
  AddXMLNode(node,'F39' ,F39);
  AddXMLNode(node,'F1Order' ,F1Order);
  AddXMLNode(node,'F2Order' ,F2Order);
  AddXMLNode(node,'F3Order' ,F3Order);
  AddXMLNode(node,'F4Order' ,F4Order);
  AddXMLNode(node,'F5Order' ,F5Order);
  AddXMLNode(node,'F6Order' ,F6Order);
  AddXMLNode(node,'F7Order' ,F7Order);
  AddXMLNode(node,'F8Order' ,F8Order);
  AddXMLNode(node,'F9Order' ,F9Order);
  AddXMLNode(node,'F10Order' ,F10Order);
  AddXMLNode(node,'F11Order' ,F11Order);
  AddXMLNode(node,'F12Order' ,F12Order);
  AddXMLNode(node,'F13Order' ,F13Order);
  AddXMLNode(node,'F14Order' ,F14Order);
  AddXMLNode(node,'F15Order' ,F15Order);
  AddXMLNode(node,'F16Order' ,F16Order);
  AddXMLNode(node,'F17Order' ,F17Order);
  AddXMLNode(node,'F18Order' ,F18Order);
  AddXMLNode(node,'F19Order' ,F19Order);
  AddXMLNode(node,'F20Order' ,F20Order);
  AddXMLNode(node,'F21Order' ,F21Order);
  AddXMLNode(node,'F22Order' ,F22Order);
  AddXMLNode(node,'F23Order' ,F23Order);
  AddXMLNode(node,'F24Order' ,F24Order);
  AddXMLNode(node,'F25Order' ,F25Order);
  AddXMLNode(node,'F26Order' ,F26Order);
  AddXMLNode(node,'F27Order' ,F27Order);
  AddXMLNode(node,'F28Order' ,F28Order);
  AddXMLNode(node,'F29Order' ,F29Order);
  AddXMLNode(node,'F30Order' ,F30Order);
  AddXMLNode(node,'F31Order' ,F31Order);
  AddXMLNode(node,'F32Order' ,F32Order);
  AddXMLNode(node,'F33Order' ,F33Order);
  AddXMLNode(node,'F34Order' ,F34Order);
  AddXMLNode(node,'F35Order' ,F35Order);
  AddXMLNode(node,'F36Order' ,F36Order);
  AddXMLNode(node,'Dateformat' ,Dateformat);
  AddXMLNode(node,'ACTIVE' ,ACTIVE);
end;


function TRepairsExportConfigBase.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function TRepairsExportConfigBase.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TRepairsExportConfigBase.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TRepairsExportConfigBase.DoFieldOnChange(Sender: TField);
var
  x:Integer;
  ctr:Integer;
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
  inherited;
  if (Pos('order' , Lowercase(Sender.fieldName))>0) then begin
    if TIntegerField(Sender).OldValue <> null then begin
      x:= TIntegerField(Sender).OldValue;
      if x<> TIntegerField(Sender).Value then begin
        for ctr := 1 to 36 do
          if not(Sysutils.SameText('F' +trim(intToStr(ctr))+'Order' , Sender.fieldname)) then
            if Dataset.fieldbyname('F' +trim(intToStr(ctr))+'Order').asInteger = Sender.value then begin
              EditDB;
              Dataset.fieldbyname('F' +trim(intToStr(ctr))+'Order').asInteger:= x;
            end;
      end;
    end;
  end;

end;


function TRepairsExportConfigBase.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TRepairsExportConfigBase.GetIDField: string;
begin
  Result := 'ID'
end;


class function TRepairsExportConfigBase.GetBusObjectTablename: string;
begin
  Result:= 'tblrepairsexportconfig';
end;


function TRepairsExportConfigBase.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TRepairsExportConfigBase.GetManufactureId: Integer   ; begin Result := GetIntegerField('ManufactureId');end;
function  TRepairsExportConfigBase.GetF1           : string    ; begin Result := GetStringField('F1');end;
function  TRepairsExportConfigBase.GetF2           : string    ; begin Result := GetStringField('F2');end;
function  TRepairsExportConfigBase.GetF3           : string    ; begin Result := GetStringField('F3');end;
function  TRepairsExportConfigBase.GetF4           : string    ; begin Result := GetStringField('F4');end;
function  TRepairsExportConfigBase.GetF5           : string    ; begin Result := GetStringField('F5');end;
function  TRepairsExportConfigBase.GetF6           : string    ; begin Result := GetStringField('F6');end;
function  TRepairsExportConfigBase.GetF7           : string    ; begin Result := GetStringField('F7');end;
function  TRepairsExportConfigBase.GetF8           : string    ; begin Result := GetStringField('F8');end;
function  TRepairsExportConfigBase.GetF9           : string    ; begin Result := GetStringField('F9');end;
function  TRepairsExportConfigBase.GetF10          : string    ; begin Result := GetStringField('F10');end;
function  TRepairsExportConfigBase.GetF11          : string    ; begin Result := GetStringField('F11');end;
function  TRepairsExportConfigBase.GetF12          : string    ; begin Result := GetStringField('F12');end;
function  TRepairsExportConfigBase.GetF13          : string    ; begin Result := GetStringField('F13');end;
function  TRepairsExportConfigBase.GetF14          : string    ; begin Result := GetStringField('F14');end;
function  TRepairsExportConfigBase.GetF15          : string    ; begin Result := GetStringField('F15');end;
function  TRepairsExportConfigBase.GetF16          : string    ; begin Result := GetStringField('F16');end;
function  TRepairsExportConfigBase.GetF17          : string    ; begin Result := GetStringField('F17');end;
function  TRepairsExportConfigBase.GetF18          : string    ; begin Result := GetStringField('F18');end;
function  TRepairsExportConfigBase.GetF19          : string    ; begin Result := GetStringField('F19');end;
function  TRepairsExportConfigBase.GetF20          : string    ; begin Result := GetStringField('F20');end;
function  TRepairsExportConfigBase.GetF21          : string    ; begin Result := GetStringField('F21');end;
function  TRepairsExportConfigBase.GetF22          : string    ; begin Result := GetStringField('F22');end;
function  TRepairsExportConfigBase.GetF23          : string    ; begin Result := GetStringField('F23');end;
function  TRepairsExportConfigBase.GetF24          : string    ; begin Result := GetStringField('F24');end;
function  TRepairsExportConfigBase.GetF25          : string    ; begin Result := GetStringField('F25');end;
function  TRepairsExportConfigBase.GetF26          : string    ; begin Result := GetStringField('F26');end;
function  TRepairsExportConfigBase.GetF27          : string    ; begin Result := GetStringField('F27');end;
function  TRepairsExportConfigBase.GetF28          : string    ; begin Result := GetStringField('F28');end;
function  TRepairsExportConfigBase.GetF29          : string    ; begin Result := GetStringField('F29');end;
function  TRepairsExportConfigBase.GetF30          : string    ; begin Result := GetStringField('F30');end;
function  TRepairsExportConfigBase.GetF31          : string    ; begin Result := GetStringField('F31');end;
function  TRepairsExportConfigBase.GetF32          : string    ; begin Result := GetStringField('F32');end;
function  TRepairsExportConfigBase.GetF33          : string    ; begin Result := GetStringField('F33');end;
function  TRepairsExportConfigBase.GetF34          : string    ; begin Result := GetStringField('F34');end;
function  TRepairsExportConfigBase.GetF35          : string    ; begin Result := GetStringField('F35');end;
function  TRepairsExportConfigBase.GetF36          : string    ; begin Result := GetStringField('F36');end;
function  TRepairsExportConfigBase.GetF37          : string    ; begin Result := GetStringField('F37');end;
function  TRepairsExportConfigBase.GetF38          : string    ; begin Result := GetStringField('F38');end;
function  TRepairsExportConfigBase.GetF39          : string    ; begin Result := GetStringField('F39');end;
Function TRepairsExportConfigBase.GetShowF1	:Boolean; Begin Result := GetBooleanField('ShowF1'); end;
Function TRepairsExportConfigBase.GetShowF2	:Boolean; Begin Result := GetBooleanField('ShowF2'); end;
Function TRepairsExportConfigBase.GetShowF3	:Boolean; Begin Result := GetBooleanField('ShowF3'); end;
Function TRepairsExportConfigBase.GetShowF4	:Boolean; Begin Result := GetBooleanField('ShowF4'); end;
Function TRepairsExportConfigBase.GetShowF5	:Boolean; Begin Result := GetBooleanField('ShowF5'); end;
Function TRepairsExportConfigBase.GetShowF6	:Boolean; Begin Result := GetBooleanField('ShowF6'); end;
Function TRepairsExportConfigBase.GetShowF7	:Boolean; Begin Result := GetBooleanField('ShowF7'); end;
Function TRepairsExportConfigBase.GetShowF8	:Boolean; Begin Result := GetBooleanField('ShowF8'); end;
Function TRepairsExportConfigBase.GetShowF9	:Boolean; Begin Result := GetBooleanField('ShowF9'); end;
Function TRepairsExportConfigBase.GetShowF10	:Boolean; Begin Result := GetBooleanField('ShowF10'); end;
Function TRepairsExportConfigBase.GetShowF11	:Boolean; Begin Result := GetBooleanField('ShowF11'); end;
Function TRepairsExportConfigBase.GetShowF12	:Boolean; Begin Result := GetBooleanField('ShowF12'); end;
Function TRepairsExportConfigBase.GetShowF13	:Boolean; Begin Result := GetBooleanField('ShowF13'); end;
Function TRepairsExportConfigBase.GetShowF14	:Boolean; Begin Result := GetBooleanField('ShowF14'); end;
Function TRepairsExportConfigBase.GetShowF15	:Boolean; Begin Result := GetBooleanField('ShowF15'); end;
Function TRepairsExportConfigBase.GetShowF16	:Boolean; Begin Result := GetBooleanField('ShowF16'); end;
Function TRepairsExportConfigBase.GetShowF17	:Boolean; Begin Result := GetBooleanField('ShowF17'); end;
Function TRepairsExportConfigBase.GetShowF18	:Boolean; Begin Result := GetBooleanField('ShowF18'); end;
Function TRepairsExportConfigBase.GetShowF19	:Boolean; Begin Result := GetBooleanField('ShowF19'); end;
Function TRepairsExportConfigBase.GetShowF20	:Boolean; Begin Result := GetBooleanField('ShowF20'); end;
Function TRepairsExportConfigBase.GetShowF21	:Boolean; Begin Result := GetBooleanField('ShowF21'); end;
Function TRepairsExportConfigBase.GetShowF22	:Boolean; Begin Result := GetBooleanField('ShowF22'); end;
Function TRepairsExportConfigBase.GetShowF23	:Boolean; Begin Result := GetBooleanField('ShowF23'); end;
Function TRepairsExportConfigBase.GetShowF24	:Boolean; Begin Result := GetBooleanField('ShowF24'); end;
Function TRepairsExportConfigBase.GetShowF25	:Boolean; Begin Result := GetBooleanField('ShowF25'); end;
Function TRepairsExportConfigBase.GetShowF26	:Boolean; Begin Result := GetBooleanField('ShowF26'); end;
Function TRepairsExportConfigBase.GetShowF27	:Boolean; Begin Result := GetBooleanField('ShowF27'); end;
Function TRepairsExportConfigBase.GetShowF28	:Boolean; Begin Result := GetBooleanField('ShowF28'); end;
Function TRepairsExportConfigBase.GetShowF29	:Boolean; Begin Result := GetBooleanField('ShowF29'); end;
Function TRepairsExportConfigBase.GetShowF30	:Boolean; Begin Result := GetBooleanField('ShowF30'); end;
Function TRepairsExportConfigBase.GetShowF31	:Boolean; Begin Result := GetBooleanField('ShowF31'); end;
Function TRepairsExportConfigBase.GetShowF32	:Boolean; Begin Result := GetBooleanField('ShowF32'); end;
Function TRepairsExportConfigBase.GetShowF33	:Boolean; Begin Result := GetBooleanField('ShowF33'); end;
Function TRepairsExportConfigBase.GetShowF34	:Boolean; Begin Result := GetBooleanField('ShowF34'); end;
Function TRepairsExportConfigBase.GetShowF35	:Boolean; Begin Result := GetBooleanField('ShowF35'); end;
Function TRepairsExportConfigBase.GetShowF36	:Boolean; Begin Result := GetBooleanField('ShowF36'); end;
Function TRepairsExportConfigBase.GetOrder1	:Integer; Begin Result := GetIntegerField('F1Order'); end;
Function TRepairsExportConfigBase.GetOrder2	:Integer; Begin Result := GetIntegerField('F2Order'); end;
Function TRepairsExportConfigBase.GetOrder3	:Integer; Begin Result := GetIntegerField('F3Order'); end;
Function TRepairsExportConfigBase.GetOrder4	:Integer; Begin Result := GetIntegerField('F4Order'); end;
Function TRepairsExportConfigBase.GetOrder5	:Integer; Begin Result := GetIntegerField('F5Order'); end;
Function TRepairsExportConfigBase.GetOrder6	:Integer; Begin Result := GetIntegerField('F6Order'); end;
Function TRepairsExportConfigBase.GetOrder7	:Integer; Begin Result := GetIntegerField('F7Order'); end;
Function TRepairsExportConfigBase.GetOrder8	:Integer; Begin Result := GetIntegerField('F8Order'); end;
Function TRepairsExportConfigBase.GetOrder9	:Integer; Begin Result := GetIntegerField('F9Order'); end;
Function TRepairsExportConfigBase.GetOrder10	:Integer; Begin Result := GetIntegerField('F10Order'); end;
Function TRepairsExportConfigBase.GetOrder11	:Integer; Begin Result := GetIntegerField('F11Order'); end;
Function TRepairsExportConfigBase.GetOrder12	:Integer; Begin Result := GetIntegerField('F12Order'); end;
Function TRepairsExportConfigBase.GetOrder13	:Integer; Begin Result := GetIntegerField('F13Order'); end;
Function TRepairsExportConfigBase.GetOrder14	:Integer; Begin Result := GetIntegerField('F14Order'); end;
Function TRepairsExportConfigBase.GetOrder15	:Integer; Begin Result := GetIntegerField('F15Order'); end;
Function TRepairsExportConfigBase.GetOrder16	:Integer; Begin Result := GetIntegerField('F16Order'); end;
Function TRepairsExportConfigBase.GetOrder17	:Integer; Begin Result := GetIntegerField('F17Order'); end;
Function TRepairsExportConfigBase.GetOrder18	:Integer; Begin Result := GetIntegerField('F18Order'); end;
Function TRepairsExportConfigBase.GetOrder19	:Integer; Begin Result := GetIntegerField('F19Order'); end;
Function TRepairsExportConfigBase.GetOrder20	:Integer; Begin Result := GetIntegerField('F20Order'); end;
Function TRepairsExportConfigBase.GetOrder21	:Integer; Begin Result := GetIntegerField('F21Order'); end;
Function TRepairsExportConfigBase.GetOrder22	:Integer; Begin Result := GetIntegerField('F22Order'); end;
Function TRepairsExportConfigBase.GetOrder23	:Integer; Begin Result := GetIntegerField('F23Order'); end;
Function TRepairsExportConfigBase.GetOrder24	:Integer; Begin Result := GetIntegerField('F24Order'); end;
Function TRepairsExportConfigBase.GetOrder25	:Integer; Begin Result := GetIntegerField('F25Order'); end;
Function TRepairsExportConfigBase.GetOrder26	:Integer; Begin Result := GetIntegerField('F26Order'); end;
Function TRepairsExportConfigBase.GetOrder27	:Integer; Begin Result := GetIntegerField('F27Order'); end;
Function TRepairsExportConfigBase.GetOrder28	:Integer; Begin Result := GetIntegerField('F28Order'); end;
Function TRepairsExportConfigBase.GetOrder29	:Integer; Begin Result := GetIntegerField('F29Order'); end;
Function TRepairsExportConfigBase.GetOrder30	:Integer; Begin Result := GetIntegerField('F30Order'); end;
Function TRepairsExportConfigBase.GetOrder31	:Integer; Begin Result := GetIntegerField('F31Order'); end;
Function TRepairsExportConfigBase.GetOrder32	:Integer; Begin Result := GetIntegerField('F32Order'); end;
Function TRepairsExportConfigBase.GetOrder33	:Integer; Begin Result := GetIntegerField('F33Order'); end;
Function TRepairsExportConfigBase.GetOrder34	:Integer; Begin Result := GetIntegerField('F34Order'); end;
Function TRepairsExportConfigBase.GetOrder35	:Integer; Begin Result := GetIntegerField('F35Order'); end;
Function TRepairsExportConfigBase.GetOrder36	:Integer; Begin Result := GetIntegerField('F36Order'); end;
function TRepairsExportConfigBase.getDateformat: String;begin  REsult := getStringfield('Dateformat');end;
function  TRepairsExportConfigBase.GetACTIVE       : Boolean   ; begin Result := GetBooleanField('ACTIVE');end;
procedure TRepairsExportConfigBase.SetManufactureId(const Value: Integer   ); begin SetIntegerField('ManufactureId' , Value);end;
procedure TRepairsExportConfigBase.SetF1           (const Value: string    ); begin SetStringField('F1'            , Value);end;
procedure TRepairsExportConfigBase.SetF2           (const Value: string    ); begin SetStringField('F2'            , Value);end;
procedure TRepairsExportConfigBase.SetF3           (const Value: string    ); begin SetStringField('F3'            , Value);end;
procedure TRepairsExportConfigBase.SetF4           (const Value: string    ); begin SetStringField('F4'            , Value);end;
procedure TRepairsExportConfigBase.SetF5           (const Value: string    ); begin SetStringField('F5'            , Value);end;
procedure TRepairsExportConfigBase.SetF6           (const Value: string    ); begin SetStringField('F6'            , Value);end;
procedure TRepairsExportConfigBase.SetF7           (const Value: string    ); begin SetStringField('F7'            , Value);end;
procedure TRepairsExportConfigBase.SetF8           (const Value: string    ); begin SetStringField('F8'            , Value);end;
procedure TRepairsExportConfigBase.SetF9           (const Value: string    ); begin SetStringField('F9'            , Value);end;
procedure TRepairsExportConfigBase.SetF10          (const Value: string    ); begin SetStringField('F10'           , Value);end;
procedure TRepairsExportConfigBase.SetF11          (const Value: string    ); begin SetStringField('F11'           , Value);end;
procedure TRepairsExportConfigBase.SetF12          (const Value: string    ); begin SetStringField('F12'           , Value);end;
procedure TRepairsExportConfigBase.SetF13          (const Value: string    ); begin SetStringField('F13'           , Value);end;
procedure TRepairsExportConfigBase.SetF14          (const Value: string    ); begin SetStringField('F14'           , Value);end;
procedure TRepairsExportConfigBase.SetF15          (const Value: string    ); begin SetStringField('F15'           , Value);end;
procedure TRepairsExportConfigBase.SetF16          (const Value: string    ); begin SetStringField('F16'           , Value);end;
procedure TRepairsExportConfigBase.SetF17          (const Value: string    ); begin SetStringField('F17'           , Value);end;
procedure TRepairsExportConfigBase.SetF18          (const Value: string    ); begin SetStringField('F18'           , Value);end;
procedure TRepairsExportConfigBase.SetF19          (const Value: string    ); begin SetStringField('F19'           , Value);end;
procedure TRepairsExportConfigBase.SetF20          (const Value: string    ); begin SetStringField('F20'           , Value);end;
procedure TRepairsExportConfigBase.SetF21          (const Value: string    ); begin SetStringField('F21'           , Value);end;
procedure TRepairsExportConfigBase.SetF22          (const Value: string    ); begin SetStringField('F22'           , Value);end;
procedure TRepairsExportConfigBase.SetF23          (const Value: string    ); begin SetStringField('F23'           , Value);end;
procedure TRepairsExportConfigBase.SetF24          (const Value: string    ); begin SetStringField('F24'           , Value);end;
procedure TRepairsExportConfigBase.SetF25          (const Value: string    ); begin SetStringField('F25'           , Value);end;
procedure TRepairsExportConfigBase.SetF26          (const Value: string    ); begin SetStringField('F26'           , Value);end;
procedure TRepairsExportConfigBase.SetF27          (const Value: string    ); begin SetStringField('F27'           , Value);end;
procedure TRepairsExportConfigBase.SetF28          (const Value: string    ); begin SetStringField('F28'           , Value);end;
procedure TRepairsExportConfigBase.SetF29          (const Value: string    ); begin SetStringField('F29'           , Value);end;
procedure TRepairsExportConfigBase.SetF30          (const Value: string    ); begin SetStringField('F30'           , Value);end;
procedure TRepairsExportConfigBase.SetF31          (const Value: string    ); begin SetStringField('F31'           , Value);end;
procedure TRepairsExportConfigBase.SetF32          (const Value: string    ); begin SetStringField('F32'           , Value);end;
procedure TRepairsExportConfigBase.SetF33          (const Value: string    ); begin SetStringField('F33'           , Value);end;
procedure TRepairsExportConfigBase.SetF34          (const Value: string    ); begin SetStringField('F34'           , Value);end;
procedure TRepairsExportConfigBase.SetF35          (const Value: string    ); begin SetStringField('F35'           , Value);end;
procedure TRepairsExportConfigBase.SetF36          (const Value: string    ); begin SetStringField('F36'           , Value);end;
procedure TRepairsExportConfigBase.SetF37          (const Value: string    ); begin SetStringField('F37'           , Value);end;
procedure TRepairsExportConfigBase.SetF38          (const Value: string    ); begin SetStringField('F38'           , Value);end;
procedure TRepairsExportConfigBase.SetF39          (const Value: string    ); begin SetStringField('F39'           , Value);end;
Procedure TRepairsExportConfigBase.SetShowF1	(Const Value :Boolean); begin SetBooleanfield('ShowF1', Value); end;
Procedure TRepairsExportConfigBase.SetShowF2	(Const Value :Boolean); begin SetBooleanfield('ShowF2', Value); end;
Procedure TRepairsExportConfigBase.SetShowF3	(Const Value :Boolean); begin SetBooleanfield('ShowF3', Value); end;
Procedure TRepairsExportConfigBase.SetShowF4	(Const Value :Boolean); begin SetBooleanfield('ShowF4', Value); end;
Procedure TRepairsExportConfigBase.SetShowF5	(Const Value :Boolean); begin SetBooleanfield('ShowF5', Value); end;
Procedure TRepairsExportConfigBase.SetShowF6	(Const Value :Boolean); begin SetBooleanfield('ShowF6', Value); end;
Procedure TRepairsExportConfigBase.SetShowF7	(Const Value :Boolean); begin SetBooleanfield('ShowF7', Value); end;
Procedure TRepairsExportConfigBase.SetShowF8	(Const Value :Boolean); begin SetBooleanfield('ShowF8', Value); end;
Procedure TRepairsExportConfigBase.SetShowF9	(Const Value :Boolean); begin SetBooleanfield('ShowF9', Value); end;
Procedure TRepairsExportConfigBase.SetShowF10	(Const Value :Boolean); begin SetBooleanfield('ShowF10', Value); end;
Procedure TRepairsExportConfigBase.SetShowF11	(Const Value :Boolean); begin SetBooleanfield('ShowF11', Value); end;
Procedure TRepairsExportConfigBase.SetShowF12	(Const Value :Boolean); begin SetBooleanfield('ShowF12', Value); end;
Procedure TRepairsExportConfigBase.SetShowF13	(Const Value :Boolean); begin SetBooleanfield('ShowF13', Value); end;
Procedure TRepairsExportConfigBase.SetShowF14	(Const Value :Boolean); begin SetBooleanfield('ShowF14', Value); end;
Procedure TRepairsExportConfigBase.SetShowF15	(Const Value :Boolean); begin SetBooleanfield('ShowF15', Value); end;
Procedure TRepairsExportConfigBase.SetShowF16	(Const Value :Boolean); begin SetBooleanfield('ShowF16', Value); end;
Procedure TRepairsExportConfigBase.SetShowF17	(Const Value :Boolean); begin SetBooleanfield('ShowF17', Value); end;
Procedure TRepairsExportConfigBase.SetShowF18	(Const Value :Boolean); begin SetBooleanfield('ShowF18', Value); end;
Procedure TRepairsExportConfigBase.SetShowF19	(Const Value :Boolean); begin SetBooleanfield('ShowF19', Value); end;
Procedure TRepairsExportConfigBase.SetShowF20	(Const Value :Boolean); begin SetBooleanfield('ShowF20', Value); end;
Procedure TRepairsExportConfigBase.SetShowF21	(Const Value :Boolean); begin SetBooleanfield('ShowF21', Value); end;
Procedure TRepairsExportConfigBase.SetShowF22	(Const Value :Boolean); begin SetBooleanfield('ShowF22', Value); end;
Procedure TRepairsExportConfigBase.SetShowF23	(Const Value :Boolean); begin SetBooleanfield('ShowF23', Value); end;
Procedure TRepairsExportConfigBase.SetShowF24	(Const Value :Boolean); begin SetBooleanfield('ShowF24', Value); end;
Procedure TRepairsExportConfigBase.SetShowF25	(Const Value :Boolean); begin SetBooleanfield('ShowF25', Value); end;
Procedure TRepairsExportConfigBase.SetShowF26	(Const Value :Boolean); begin SetBooleanfield('ShowF26', Value); end;
Procedure TRepairsExportConfigBase.SetShowF27	(Const Value :Boolean); begin SetBooleanfield('ShowF27', Value); end;
Procedure TRepairsExportConfigBase.SetShowF28	(Const Value :Boolean); begin SetBooleanfield('ShowF28', Value); end;
Procedure TRepairsExportConfigBase.SetShowF29	(Const Value :Boolean); begin SetBooleanfield('ShowF29', Value); end;
Procedure TRepairsExportConfigBase.SetShowF30	(Const Value :Boolean); begin SetBooleanfield('ShowF30', Value); end;
Procedure TRepairsExportConfigBase.SetShowF31	(Const Value :Boolean); begin SetBooleanfield('ShowF31', Value); end;
Procedure TRepairsExportConfigBase.SetShowF32	(Const Value :Boolean); begin SetBooleanfield('ShowF32', Value); end;
Procedure TRepairsExportConfigBase.SetShowF33	(Const Value :Boolean); begin SetBooleanfield('ShowF33', Value); end;
Procedure TRepairsExportConfigBase.SetShowF34	(Const Value :Boolean); begin SetBooleanfield('ShowF34', Value); end;
Procedure TRepairsExportConfigBase.SetShowF35	(Const Value :Boolean); begin SetBooleanfield('ShowF35', Value); end;
Procedure TRepairsExportConfigBase.SetShowF36	(Const Value :Boolean); begin SetBooleanfield('ShowF36', Value); end;
Procedure TRepairsExportConfigBase.SetOrder1	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F1Order', Value); end;
Procedure TRepairsExportConfigBase.SetOrder2	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F2Order', Value); end;
Procedure TRepairsExportConfigBase.SetOrder3	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F3Order', Value); end;
Procedure TRepairsExportConfigBase.SetOrder4	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F4Order', Value); end;
Procedure TRepairsExportConfigBase.SetOrder5	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F5Order', Value); end;
Procedure TRepairsExportConfigBase.SetOrder6	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F6Order', Value); end;
Procedure TRepairsExportConfigBase.SetOrder7	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F7Order', Value); end;
Procedure TRepairsExportConfigBase.SetOrder8	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F8Order', Value); end;
Procedure TRepairsExportConfigBase.SetOrder9	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F9Order', Value); end;
Procedure TRepairsExportConfigBase.SetOrder10	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F10Order', Value); end;
Procedure TRepairsExportConfigBase.SetOrder11	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F11Order', Value); end;
Procedure TRepairsExportConfigBase.SetOrder12	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F12Order', Value); end;
Procedure TRepairsExportConfigBase.SetOrder13	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F13Order', Value); end;
Procedure TRepairsExportConfigBase.SetOrder14	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F14Order', Value); end;
Procedure TRepairsExportConfigBase.SetOrder15	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F15Order', Value); end;
Procedure TRepairsExportConfigBase.SetOrder16	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F16Order', Value); end;
Procedure TRepairsExportConfigBase.SetOrder17	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F17Order', Value); end;
Procedure TRepairsExportConfigBase.SetOrder18	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F18Order', Value); end;
Procedure TRepairsExportConfigBase.SetOrder19	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F19Order', Value); end;
Procedure TRepairsExportConfigBase.SetOrder20	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F20Order', Value); end;
Procedure TRepairsExportConfigBase.SetOrder21	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F21Order', Value); end;
Procedure TRepairsExportConfigBase.SetOrder22	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F22Order', Value); end;
Procedure TRepairsExportConfigBase.SetOrder23	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F23Order', Value); end;
Procedure TRepairsExportConfigBase.SetOrder24	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F24Order', Value); end;
Procedure TRepairsExportConfigBase.SetOrder25	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F25Order', Value); end;
Procedure TRepairsExportConfigBase.SetOrder26	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F26Order', Value); end;
Procedure TRepairsExportConfigBase.SetOrder27	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F27Order', Value); end;
Procedure TRepairsExportConfigBase.SetOrder28	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F28Order', Value); end;
Procedure TRepairsExportConfigBase.SetOrder29	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F29Order', Value); end;
Procedure TRepairsExportConfigBase.SetOrder30	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F30Order', Value); end;
Procedure TRepairsExportConfigBase.SetOrder31	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F31Order', Value); end;
Procedure TRepairsExportConfigBase.SetOrder32	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F32Order', Value); end;
Procedure TRepairsExportConfigBase.SetOrder33	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F33Order', Value); end;
Procedure TRepairsExportConfigBase.SetOrder34	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F34Order', Value); end;
Procedure TRepairsExportConfigBase.SetOrder35	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F35Order', Value); end;
Procedure TRepairsExportConfigBase.SetOrder36	(Value :Integer); begin if Value>36 then value:= 36 else if Value <1 then Value := 1;SetIntegerfield('F36Order', Value); end;
procedure TRepairsExportConfigBase.SetACTIVE       (const Value: Boolean   ); begin SetBooleanField('ACTIVE'        , Value);end;
procedure TRepairsExportConfigBase.setDateformat(const Value: String);begin  SetStringfield('Dateformat' , Value);end;
procedure TRepairsExportConfigBase.loadForManufacture(Manufacture: Integer);
begin
  LoadSelect( '(ifnull(ManufactureId,0) = ' +intToStr(manufacture) + ' or ifnull(ManufactureId,0) = 0 )');
end;




function TRepairsExportConfigBase.getReceiptNumberCaption: String;
begin
  Result := F1;
end;

function TRepairsExportConfigBase.DoAfterInsert(
  Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;
  XML := Defaultconfig;
  ManufactureId := 0;
  PostDB;
  editdb;
end;

function TRepairsExportConfigBase.DoBeforeInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoBeforeInsert(Sender);
  if not result then exit;
end;

procedure TRepairsExportConfigBase.New;
begin
  loadForManufacture(0);
  Defaultconfig := XML;
  closeDB;
  inherited New;
end;

{ TRepairsExportConfig }

function TRepairsExportConfig.getBaseConfig: TRepairsExportConfigBase;
begin
  result := TRepairsExportConfigBase(  getContainerComponent(TRepairsExportConfigBase , 'id = 1'));
end;

initialization
  RegisterClass(TRepairsExportConfigBase);


end.
