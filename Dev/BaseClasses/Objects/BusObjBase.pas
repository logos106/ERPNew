unit BusObjBase;

{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 27/04/05  1.00.00 IJB  Initial version.
 19/05/05  1.00.01 IJB  Added basic Dataset method wrappers
                        (eg first, last etc) to TDatasetBusObj.
 11/07/05  1.00.02 IJB  Fixed ReleaseFieldEvents and ReleaseDatasetEvents
                        (was causing access violation in PO when user clicked
                         on New from existing PO).
 27/07/05  1.00.03 BJ   New class(TMyDacDataConnection) for ADO connection
                        New event for the dataset-beforedelete
 03/08/05  1.00.04 IJB  Added BusObjectTypeDescription and BusObjectTable to be
                        used in decendants with UserLock. Added Loging.
 12/09/05  1.00.05 BJ   classes registered and published properties defined.
 15/10/05  1.00.06 IJB  Replaced TOpResp with TResultStatus.
 18/10/05  1.00.07 IJB  Modified GetSQL to allow for WHERE statements in fSQL.
 19/10/05  1.00.08 BJ   ValidateData is moved to public from private
                        ResultStatus.IgnoreDuplicatemsg is introduced to ignore
                        Saving the msg when the an existing message is given.
 20/10/05  1.00.09 IJB  Added Events (AddEvent, SendEvent, SendAllEvents) to
                        allow a business object to send events to form etc.
                        Added Get/SetXML and XMLRequest virtual functions.
 24/10/05  1.00.10 IJB  Added fDatasetEventsCaptured flag and changed
                        DatasetLoad, DatasetNew to call CaptureDatasetEvents
                        (this was previously only being called when a forms
                        dataset was asigned to the busines object, which does
                        not happen when the object is created outside a form).
                        Modified DatasetNew to add LIMIT 0 to sql.
 24/10/05  1.00.11 AL   Added parameter "var Success: boolean" to XMLRequest virtual
                        function in TMSBusObj to know if we need to commit or
                        rollback transactions
 24/10/05  1.00.12 IJB  Added TBusObj.InitializeNewObject virtual procedure;
 27/10/05  1.00.13 IJB  Removed XMLRequest, this should be handled at a higher
                        level ie by object that is creating Business object and
                        controlling transaction etc.
                        Added Code to TResultStatusItem, codes should be defined
                        in new BusObjConst unit.
 01/12/05  1.00.14  BJ  Introduced a flag to say whether Executing an event from
                        event list or not.
 12/12/05  1.00.15  BJ  Resultstatus.GetAllmessages - functin receives a code and returns
                        All the messages of the object where the Code is matching
 16/12/05  1.00.16 IJB  Added DBConnection to TDataConnection
 04/01/06  1.00.17 IJB  Removed logic from FieldOnChange that was comparing a
                        fields old value with new, this was not working as
                        expected.
 05/01/06  1.00.18 IJB  Changed TDatasetBusObj.GetSilentMode to get mode from
                        Owner business object if not silent.
 22/02/06  1.00.19 DSP  Added test for 'Sender.Id <> 0' in
                        TMyDacDataConnection.DatasetSave and
                        TMyDacDataConnection.DatasetSave.
 16/03/06  1.00.20 BJ  Load(ID) verison of the lad function was not generating the
                        SQL where statement - corected.
 Note : ClonebusObj copies the current record to a new record
        (1) Obj.Create Should intialise FieldsNottoCopy with the fields which should be ignored while copeying.
        (2) virtual function ClonePropertyObjects should be overridden in the object for the busobj properties(like lines)
        (3) Busobjtrans.DoProductallocation is a Procedure property of the object. This gets executed for the new record(cloned)
            If bin-batch allocation or serial number allocation need to be done, the procedure can be defined in the
            call from the object
 11/04/06  1.00.21 BJ  Notification nullifies the dataset while Destroying.
 21/04/06  1.00.22 BJ  Notification call while Destroying the object is disabled for the time being .
 10/05/06  1.00.23 DSP Added FieldByName fcuntion to TDatasetBusObj.
 25/05/06  1.00.24 BJ  1. BeforeInsert event procedure introduced for dataset of the object
                       2. SaveXMLTOfile procedure to Save the XML of the object into an external file
                       3. Iteraterecords was setting the bookmark after removing the filter. Removing
                          the filter repositions the record pointer to the first record. changed to
                          Set the bookmark before removing the filter.
 08/06/06  1.00.25 BJ Importing XML is introduced. XML Data can be imported to add a new record,
                        amend an exeisting record or to delete the record(make inactive).
                        1. XMLNodeName is a new property. This gets the class name with out the 'T' prefix.
                        2. SavingXMLTofile :Stores the XML of the object into the file.
                        3. ImportingFromXMLFile stores true when the data is being imported. When this is
                            true the XML is supposed to have the 'descriptive value' for all the foreign keys
                        4. Importfailed property will be true if the import from  XML is failed.
                        5. To do the importing, the businees object class should override the following virtual methods
                            a. ValidateXMLData : Validates the foreign keys in the XML. The record cannot
                                be imported if any of the foreign key doesn't exists. this function also
                                locates the record if the record already exists.
                            b.  ImportSubClasses : this proc handles all the 'busobj' properties of the
                                object. eg : TProduct.Importsubclasses in BusobjStock
                            c.  Deleterecord : this is to make the rcord inactive. The virtual function
                                in  this module make the 'Active' field to False. Override the function only
                                if the fieldName is not 'Active' or if anu other procesing or updation required
                                for deletion
 26/06/06 1.00.25 BJ  Procedures for the import/export functionality
                        SaveToXMLNode
                        LoadFromXMLNode
                        ValidateXMLData : this function should do the locaterecord at the end
                        ImportsubClasses(only if obj has object properties);
 04/07/06 1.00.26 BJ  Introduced a dataset event OnNewRecord.
 04/08/06 1.00.27 BJ  ID property returns the Id from the table, but when assigning to this
                        Property was storing the data in a memory variable and not used anywhere
                        So made the ID property readonly as its usually the autoincremented field
 07/08/06 1.00.28 BJ  1)IterateRecords : variable name 'continue' was making confusion in the object
                        as the varible is called 'abort' there, so its changed to 'Abort' here too.
                        2)Speed issue : SQL is stored in the OLdSQL property when the object is loaded.
                        When dataset is active and trying to load the object with the same SQL,
                        ignores the loading as its already loaded.
                        3)OnDataIdChange was called from the Load procedure and is removed
                        because its called from afterscroll which gets triggered after the load.
                        4)SavetoXMLNode checks the recordcount and stores the values only if dataset has records.
 10/08/06 1.00.29 BJ  The objectName attribute was called 'TargetObject' when importing and 'sourceObject' when exporting
                        This is changed to 'DataObject' and is same while importing and exporting
 15/08/06 1.00.30 BJ  1) new dataset events added : BeforeOpen and BeforeEdit - mainly for the accesslevel checking
                        2) New properties : AccessManager :DNMAccessManager - initialised to the
                           form's variable if the object belong to Baseinputform
                           IgnoreAccessleves : used when the object should not check accesslevel.
                           eg: client in the invoice should ignore it as the invoice is checking for it
                        3) Dataset.. procedures are changed to normal private procedures , the
                           descendants are supposed to override the Do... procedures
                        4) Dataset events calls the Accessmanager's event proc to find out the access level
 16/08/06 1.00.31 BJ  if AccessManager owned by the object(Self), checks for the accesslevels.
                        tblexportobjectlist contains the formId of the GUI associated with the object.
 21/08/06 1.00.32 BJ  Eventlist gets the ID of the object which is adding the event and also a done
                      Status variable which is set to False when the event is added and set to true after
                      the event is called.
 23/08/06 1.00.33 BJ  DatasetNew : 'Insert' was adding a record which tries to add the record in
                      in the current position. The sequesnce in transaction tables (sales lines etc)
                      table is important (SortID). Copying a transaction to another calles 'New' from the cloneobj
                        causes reversing the line records. so is changed to 'Append' instead of 'Insert'
 12/09/06 1.00.34 DSP Added FreeNotification call and Notification method to
                      TDataSetBusObj.
 18/09/06 1.00.35 BJ  DsWriteOK functin checks for the dsCalcFields state of the dataset before
                      changing to edit mode
 23/01/07 1.00.36 BJ  Proeprty Querylist for the batchupdation SQLs
                      Procedures for the batchupdation are added.

}

interface

{$I ERP.inc}

uses
  MyAccess,ERPdbComponents,  Classes, DB, UserLockObj, XMLDoc,
  DNMAccessManager , BusObjGeneral, dialogs, Contnrs, SyncObjs,
  tcConst, ValueListObj, XMLIntf, JsonObject, ExtCtrls, DelayLib,
  ProgressInfoObj, EParser  , TypesLib , Progressdialog;


Type

  TProcWithConnection   = Procedure (Connection :TCustomMyconnection) of Object;

  TResultStatusSeverity = (rssNone, rssInfo, rssWarning, rssError);
  TResultStatusSeveritySet = set of TResultStatusSeverity;

  TBusObjDataChangeType = (dcLoad, dcDelete, dcNew, dcSave, dcClose);


  function DataChangeTypeToStr(aChangeType: TBusObjDataChangeType): string;

type
  TMyDacDataConnection = class;

  TBusObj = class;
  TBusDatasource = class;
  TBusObjCallbackProc = Procedure(Const Sender: TBusObj; var Abort: boolean) of Object;
  TBusObjProc = Procedure(Sender: TBusObj) of Object;
  TBusObjBoolFunc = Function(Sender: TBusObj):Boolean of Object;


  TResultStatusItem = class;
  TResultStatus = class(TCollection)
  private
    fSilentMode         : boolean;
    fsIgnoreduplicateMsg  : Boolean;
    fResultPrefix: string;
    fResultSuffix: string;
    function GetMessaages   : string;
    function GetOperationOk : boolean;
    function GetSeveritySet : TResultStatusSeveritySet;
    function GetSilentMode  : boolean;
    procedure SetSilentMode(const Value: boolean);
    function GetHasError: boolean;
    function getHasWarning: Boolean;
    function getHasAnyMessage: Boolean;
    function getHasinfo: Boolean;
  public
    constructor Create(ItemClass: TCollectionItemClass);
    destructor Destroy; override;
    Function FindItem(const aOperationOk: boolean;
                      const aSeverity: TResultStatusSeverity;
                      const aCode: integer;
                      const aMessage: string) :Integer;
    procedure AddItem(const aOperationOk: boolean;
                      const aSeverity: TResultStatusSeverity;
                      const aCode: integer;
                      const aMessage: string;
                      const ShowMessage: boolean = true);
    Function GetAllMessages(const aCode: integer; const Delimiter :String = chr(13)) :String;
    function GetPrefixedMessages(const Prefix: string): string;
    procedure Reset;
    property SilentMode: boolean read GetSilentMode write SetSilentMode;
    property OperationOk: boolean read GetOperationOk;
    property SeveritySet: TResultStatusSeveritySet read GetSeveritySet;
    property Messages: string read GetMessaages;
    property IgnoreduplicateMsg :Boolean read fsIgnoreduplicateMsg write fsIgnoreduplicateMsg;
    function GetLastFatalStatusItem: TResultStatusItem;
    function GetLastStatusItem: TResultStatusItem;
    function GetFirstFatalStatusItem: TResultStatusItem;
    Procedure AddMessageToXMLNode(const ParentNode :IXMLNode);
    procedure AddItems(aResultStatus: TResultStatus);
    property HasError: boolean read GetHasError;
    Property HasWarning:Boolean read getHasWarning;
    Property HasInfo:Boolean read getHasinfo;
    Property HasanyMessage:Boolean read getHasAnyMessage;
    function HasCode(const aCode: integer): boolean;
    function ReadMessages(Strings: TStrings; Indent: string = ''): boolean;
    function Allmessages :String;
    property ResultPrefix: string read fResultPrefix write fResultPrefix;
    property ResultSuffix: string read fResultSuffix write fResultSuffix;
  end;

  TResultStatusItem = class(TCollectionItem)
  private
    fOPerationOk: boolean;
    fSeverity: TResultStatusSeverity;
    fMessage: string;
    fCode: Integer;
    function GetMessaage: string;
    function GetOperationOk: boolean;
    function GetSeverity: TResultStatusSeverity;
    procedure SetMessage(const Value: string);
    procedure SetOperationOk(const Value: boolean);
    procedure SetSeverity(const Value: TResultStatusSeverity);
    function GetCode: integer;
    procedure SetCode(const Value: integer);
    function GetText: string;
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
    property OperationOk: boolean read GetOperationOk write SetOperationOk;
    property Severity: TResultStatusSeverity read GetSeverity write SetSeverity;
    property Code: integer read GetCode write SetCode;
    property Message: string read GetMessaage write SetMessage;
    property Text: string read GetText;
  end;

  TEventType = (OnChange, OnGetText, OnSetText, OnValidate, AfterOpen, AfterClose, BeforeClose, BeforeDelete , Beforepost, Afterpost, AfterInsert, CalcFields, BeforeInsert, NewRecord , BeforeOpen , BeforeEdit);

  TEventRec = record
    EventType: TEventType;
    Name: string;
    Code, Data: Pointer;
  end;

  TBusObjEventList = class(TCollection)
  private
  public
  end;

  TDatasetBusObj        = class;
  TBusObjBase = class;

  TBusObjEventListItem  = class(TCollectionItem)
  private
    fEventType  : string;
    fEventValue : string;
    fObjectId   : Integer;
    fProcessing : Boolean;
    fDone       : Boolean;
    fEventObj   : TDatasetBusObj;
  public
    property EventType  : string         read fEventType    write fEventType;
    property EventValue : string         read fEventValue   write fEventValue;
    Property EventObj   : TDatasetBusObj Read fEventObj     Write fEventObj;
    property ObjectID   : Integer        read fObjectID     write fObjectID;
    Property Done       : Boolean        read fDone         write fDone;
    Property Processing : Boolean        read fProcessing   write fProcessing;
  end;

  TBusObjBaseClass = class of TBusObjBase;
  TProcBusObjBase = Procedure (Sender : TBusObjBase; const EventType: integer) of Object;

  TERPComponent = class(TComponent)
  Private
//    Procedure Logit(const Value:String);
  Protected
  Public
    function heirarchyname(includeDsName:Boolean =true): String; Virtual;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;
  TBusObjContainer = Class(TERPComponent)
  private
    fList: TObjectList;
    fId: integer;
    function GetItem(Const index: integer): TComponent;
    function GetCount: integer;
    function GetDirty: boolean;
    procedure SetDirty(Const Value: boolean);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ItemByClass(Const aComponentClass: TComponentClass; Const CreateIfNotInList: boolean = true): TComponent;
    function Exists(Const aComponentClass: TComponentClass): boolean;
    function Add(Const aComponent: TComponent): integer;
    procedure Delete(Const index: integer);
    procedure FreeAndDelete(Const obj: TComponent);
    procedure DoEvent(const Sender: TObject; const EventType: integer; const Data: TObject = nil; Proc : TProcBusObjBase= nil);
    procedure Clear; overload;
    procedure Clear(Const aComponentClass: TComponentClass); overload;
    Function ContainerNames:String;
    property Count: integer read GetCount;
    property Item[Const index: integer]: TComponent read GetItem; default;
    property Dirty: boolean read GetDirty write SetDirty;
    property List: TObjectList read fList;
   Published
    property Id: integer read fId write fId;
  end;

  TBusObjContainerList = Class(TERPComponent)
  private
    fList: TObjectList;
    fContainerWithZeroId: boolean;
    function GetItem(Const index: integer): TBusObjContainer;
    function GetCount: integer;
    function GetDirty: Boolean;
    procedure SetDirty(const Value: Boolean);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Container(const Id: integer; const CreateIfNotInList: boolean = true): TBusObjContainer;
    procedure Delete(Const Id: integer);
    procedure DoSetId(Const aId: integer);
    procedure DoCancel;
    procedure Clear;
    property Dirty: Boolean read GetDirty write SetDirty;
    property Count: integer read GetCount;
    property Item[Const index: integer]: TBusObjContainer read GetItem; default;

  end;


  {  Base business object class that all others decend from }

  TBusObjOptions = (opSave, opValidateData, opLoad, opNew, opEdit, opDelete, opCancel, opDirty, opXML);
  TBusObjOptionsSet = Set of TBusObjOptions;


  TBusObjBase = Class(TERPComponent)
  private
    fResultStatus            : TResultStatus;
    fClearContainerListOnLoad: boolean;
    fExportExcludeList: TStringList;
    fImportFieldsPriorityList: TStringList;
    fFieldChangetoIgnoreInRawModeList: TStringList;
    fTimer: TTimer;
    fDelayProcedureList: TObjectList;
    fRawMode: boolean;
    fProgressInfo: TProgressInfo;
    fProgressInfolocal :TProgressInfo;
    fClearContainerListOnNew: Boolean;
    function GetResultStatus: TResultStatus;
    function GetSilentMode: boolean;
    procedure SetSilentMode(const Value: boolean);
    function GetContainer: TBusObjContainer;
    procedure DoOnTimer(Sender: TObject);
    function GetRawMode: boolean;
    function getTProgressInfo: TProgressInfo;
    procedure DoParserGetVar(const VariableName: string; var Value: Variant);
    Function IsFieldChangetoIgnoreInRawMode(const Fieldname :String):Boolean;

  protected
    fbIsReadonly: boolean;
    function GetId: integer; virtual; abstract;
    function getContainerComponentifExists(Const ComponentClassType: TComponentClass) :  TComponent;
    function getContainerComponent(Const ComponentClassType: TComponentClass;
                                    Const ObjWhereClause :STring = '';
                                    const aSetSilentMode :Boolean = True;
                                    const aSetconnection :Boolean = True;
                                    const aSetLockgroup :Boolean = True ;
                                    const AlternativeObjWhereClause :String = '';
                                    const fIsReadonly :Boolean = False ) :  TComponent;   Overload;

    function getContainerComponent(Const ComponentClassType: TComponentClass;
                                    Const aId: integer;
                                    Const aIDfieldname :String ;
                                    const aSetSilentMode :Boolean = True;
                                    const aSetconnection :Boolean = True;
                                    const aSetLockgroup :Boolean = True ;
                                    const AlternativeObjWhereClause :String = '';
                                    const fIsReadonly :Boolean = False ) :  TComponent;   Overload;

    function getContainerComponent(Const ComponentClassType: TComponentClass;
                                    Const aName:String;
                                    Const aNamefieldname :String ;
                                    const aSetSilentMode :Boolean = True;
                                    const aSetconnection :Boolean = True;
                                    const aSetLockgroup :Boolean = True ;
                                    const AlternativeObjWhereClause :String = '';
                                    const fIsReadonly :Boolean = False ) :  TComponent;   Overload;

    function GetObjectUserName: string; virtual;
    procedure setIsReadonly(const Value: boolean); virtual;
    function getIsReadonly: boolean;virtual;
  public
    Options: TBusObjOptionsSet;
    ContainerList: TBusObjContainerList;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DoDelayObjectProcedure(Proc: TObjectProcedure; DelayMilliSecs: integer; aDescription:String = '');

    property ResultStatus: TResultStatus read GetResultStatus;
    procedure AddResult(const aOperationOk: boolean;
                      const aSeverity: TResultStatusSeverity;
                      const aCode: integer;
                      const aMessage: string;
                      const ShowMessage: boolean = true);
    property SilentMode: boolean read GetSilentMode write SetSilentMode;
    function ValidateData: boolean; virtual;
    function ValidateDataList: boolean; virtual;
    procedure Load(const fIsReadonly: boolean = False); overload; virtual;
    procedure Load(Const aId: integer; const fIsReadonly:boolean = False); overload; virtual;
    procedure Load(Const aGlobalRef: string; const fIsReadonly: boolean = False); overload; virtual;
    function Save: boolean; virtual;
    procedure New; virtual;
    procedure Edit; virtual;
    function Delete: boolean; virtual;
    procedure Cancel; virtual;
    property Container: TBusObjContainer read GetContainer;
    procedure DoEvent(const Sender: TObject; const EventType: integer; const Data: TObject = nil; Proc : TProcBusObjBase= nil); virtual;
    procedure DoContainerEvent(const Sender: TObject; const EventType: integer; const Data: TObject = nil; Proc : TProcBusObjBase= nil); virtual;
    property ClearContainerListOnLoad: boolean read fClearContainerListOnLoad write fClearContainerListOnLoad;
    property ObjectUserName: string read GetObjectUserName;
    Property IsReadonly:boolean read getIsReadonly write setIsReadonly;
    procedure Log(const msg: string; msgType: string = 'None');
    class function _Schema: string; virtual;
    function InspectObj:String;
    property RawMode: boolean read GetRawMode write fRawMode;
    property ProgressInfo :TProgressInfo REad getTProgressInfo Write fProgressInfo;
    procedure HideProgress;
    procedure showProgress(Progressbarcaption: string; Progresscount: integer = 0);
    procedure stepProgress(Const ProgressbarMsg :String = '');
    function Parse(exp: string): boolean;
    property ClearContainerListOnNew: boolean read fClearContainerListOnNew write fClearContainerListOnNew;
    Function LastErrorMsgFromREsultStatus:String;
    Procedure FreeContainerObjects;
    procedure Assign(Source: TPersistent); override;
    Procedure FieldChangetoIgnoreInRawMode(const Fieldname :String);
    Procedure OnAfterJsonToBusObjectNew ;virtual;

//    function StructAsJson: string;
  published
    property ExportExcludeList: TStringList read fExportExcludeList;
    property ImportFieldsPriorityList: TStringList read fImportFieldsPriorityList;
    //property FieldChangetoIgnoreInRawModeList: TStringList read fFieldChangetoIgnoreInRawModeList;
  end;

  IBusObjXML = interface(IInterface)
    function GetXML: string;
    function GetXMLDoc: TXMLDocument;
    procedure SetXML(const Value: string);
    property XML: string read GetXML write SetXML;
    property XMLDoc: TXMLDocument read GetXMLDoc;
    procedure SaveToXMLNode(const node: IXMLNode);
    Procedure LoadFromXMLNode(const node: IXMLNode);
    { Specify load select (FilterName) sql to uses and paramater value(s),
      assumes the following XML format:
      <Filter FilterName=[FilterName]>
        <[ParamName1]>[Param1_Value]</[ParamName1]>
        <[ParamName2]>[Param2_Value]</[ParamName2]>
        ..
      </Filter>
    }
    procedure FilterSelect(FilterNode: IXMLNode);
  end;

  // Multi-Site functionality
  IMSBusObj = interface(IInterface)
    function GetGlobalRef: string;
    procedure SetGlobalRef(const Value: string);
    procedure AssignGlobalRef;
    property GlobalRef: string read GetGlobalRef write SetGlobalRef;
    procedure FlagAsUpdated(aTimeStamp: TDateTime = 0);
    procedure DoUpdateSiteCode;
  end;

  { Base class to store business object tempory variables in the objects
    container i.e. data such as 'Dirty' that is not saved in the database
    but needs to be persisted as the dataset scrolls through records. }
  TBusObjVarsClass = class of TBusObjVars;
  TBusObjVars = Class(TERPComponent)
  private
    fValues: TValueList;
  protected
  public
    Dirty: boolean;
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    property Values: TValueList read fValues;
  end;



  TBusObjEvent = procedure (const Sender: TDatasetBusObj; const EventType, Value: string) of object;

  TDatasetBusObjClass = class of TDatasetBusObj;
  TDatasetBusObj = class(TBusObjBase)
  private
    fDataset                 : TCustomMyDataset;
    EventList                : TList;
    fDoSavedFieldEvents      : boolean;
    fDoCurrentFieldSavedEvent: boolean;
    fRoundPlacesGeneral      : word;
    fCurrencyRoundPlaces       : word;
    fConnection              : TMyDacDataConnection;
    fInteractiveMode         : boolean;
    fExternalDatasetAssigned : boolean;
    fDatasetEventsCaptured   : boolean;
    fDatasetFldEventsCaptured: boolean;
    fIsNew                   : boolean;
    fUserLock                : TUserLock;
    fBusObjEvent             : TBusObjEvent;
    fEventList               : TBusObjEventList;
    fbRunningEventListEvents : boolean;
    fbNullWhenDateIs0        : Boolean;
    fsXMLSearchRecord        : String;
    fsXMLSearchRecordDesc    : String;
    fbIgnoreAccesslevel      : Boolean;
    fsCustomFieldIdentifier  : String;
    fLimitCount              : Integer;
    fLimitFrom               : Integer;
    fbDoFieldChangewhenDisabled :Boolean; // this is to enable the field onchange when importing leaving the dataaset disabled.
    fbImportingFromXMLFile :Boolean ;
    XMLFieldNodeExists :Boolean;
    fbExcludeInactive        : Boolean;
    fLastScrollID            : Integer;
    fInContainer             : Boolean;
    fLoadParamList: TStringList;
    FNoRightReason: String;
    fiObjPropcount: Integer;
    fLastFieldName: string;
    fDoFieldChange: boolean;
    fTempQry: TERPQuery;
    fbCalcFields :Boolean;
    fsCheck4FieldErrorMsg: String;
    fbEnablePropertySetWhenREadonly: Boolean;
    fdopentime :TDatetime;
    fProgressDialogobj: TProgressDialog;
    fbnewRec :Boolean;
    fbDoInitFloatFieldDisplayFormat :boolean;

    function GetDataset: TCustomMyDataset;
    procedure CaptureFieldEvents;
    procedure ReleaseFieldEvents;
    function GetEventRec(var EventRec: TEventRec; const Name: string; EventType: TEventType; const RemoveFromList: boolean = false): Boolean;
    function GetConnection: TMyDacDataConnection;
    //procedure SetId(const Value: integer);
    function GetBOF: boolean;
    function GetEOF: boolean;
    function GetNonContainerComponentsDirty: Boolean;
    procedure SetNonContainerComponentsDirty(const Value: Boolean);
    procedure SetDirty(const Value: boolean);
    procedure SetAnyDirty(const Value: boolean);
    procedure DatasetAfterOpen(Dataset: TDataset);
    procedure DatasetAfterClose(Dataset: TDataset);
    procedure DatasetBeforeClose(Dataset: TDataset);
    procedure DatasetAfterInsert(Dataset: TDataset);
    Procedure DatasetCalcFields(Dataset:TDataset) ;
    procedure DatasetBeforeDelete(Dataset: TDataset);
    procedure DatasetBeforeInsert(Dataset: TDataset);
    procedure DatasetBeforeOpen(Dataset: TDataset);
    procedure DatasetBeforepost(Dataset: TDataset);
    procedure DatasetBeforeEdit(Dataset: TDataset);
    procedure DatasetAfterpost(Dataset: TDataset);
    procedure DatasetNewRecord(Dataset: TDataset);
    Procedure DatasetBeforeScroll(Dataset :TDataset);
    Procedure DatasetAfterScroll(Dataset :TDataset);
    procedure DatasetAfterDelete(Dataset: TDataset);
    function GetCanCreate: boolean;
    function GetCanDelete: boolean;
    function GetCanRead: boolean;
    function GetCanUpdate: boolean;
    function GetLoadParamList: TStringList;
    function getRoundPlacesTotals: word;
    Procedure LogSQL;
    function DetailedName(Sender: TComponent): String;
    procedure SetIsList(const Value: boolean);
    procedure SetMsTimeStamp(const Value: TDateTime);
    procedure SetDoFieldChange(const Value: boolean);
    function GetObjectProperties: TBusobj;
    function getIsEmpty: Boolean;
    function getIgnoreAccesslevel: Boolean;
    procedure check4FieldError(Fieldname:String ; fCurDBField: TField);
    function getRecno: Integer;
    procedure ScriptBeforeExecuteProgress(Sender: TObject; var SQL: string;var Omit: Boolean);
    procedure SetAccessManager(const Value: TDNMAccessManager);
    procedure InitFloatFieldDisplayFormat;
    function getDoInitFloatFieldDisplayFormat: boolean;



  protected
    fsOldSQL                 : String;
    fSQL,
    fSQLSelect,
    fSQLGroup,
    fSQLOrder: string;
    fAccessManager           : TDNMAccessManager;
    //fId: integer;
    fBusObjectTypeDescription: string;
    VarsClassName: string;
    fPropnames :TStringlist;
    //fLastDBField: TField;
    DatasetScrolling: boolean;
    DatasetPosting: boolean;
    fIsList: boolean;
    fIsChild: boolean;
    fiProgresscount :Integer;
    fsProgressMsg :String;
    aProgressMsg :String;
    function GetDirty: boolean; virtual;
    function GetAnyDirty: boolean; virtual;
    Function GetUserLock :TUSerLock; virtual;
    function GetMsTimeStamp: TDateTime; virtual;
    procedure SetConnection(const Value: TMyDacDataConnection); virtual;
    function GetCount: integer; virtual;
    function GetSQL: string; virtual;
    function GetId: integer; override;
    function GetKeyString: string;

    procedure FieldOnChange(Sender: TField);
    procedure DoFieldOnChange(Sender: TField); virtual;
    Procedure LogDoFieldchange(Sender :TField);virtual;

    Function  DoBeforeDelete(Sender :TDatasetBusObj ):Boolean; virtual;
    Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean; virtual;
    Function  DoAfterClose(Sender :TDatasetBusObj ):Boolean; virtual;
    Function  DoBeforeClose(Sender :TDatasetBusObj ):Boolean; virtual;
    Function  DoCalcFields(Sender :TDatasetBusObj):Boolean;virtual;
    Function  DoBeforePost(Sender :TDatasetBusObj ):Boolean; virtual;
    Function  DoBeforeEdit(Sender :TDatasetBusObj ):Boolean; virtual;
    Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean; virtual;
    Function  DoNewRecord(Sender :TDatasetBusObj ):Boolean; virtual;
    Function  DoBeforeInsert(Sender :TDatasetBusObj ):Boolean; virtual;
    Function  DoBeforeOpen(Sender :TDatasetBusObj ):Boolean;Overload;virtual;
    Function  DoBeforeOpen(Sender :TDataset):Boolean;Overload;virtual;
    Function  DoAfterDelete(Sender :TDatasetBusObj ):Boolean; virtual;
    Function  DoAfterOpen(Sender :TDatasetBusObj ):Boolean; virtual;

    function GetDefaultConnection: TMyDacDataConnection;
    procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); virtual;
    procedure OnBeforeDataIdChange;virtual;
    procedure SetDataset(const Value: TCustomMyDataset);
    // helper functions
    function DSWriteOk: boolean;
    function DSReadOk: boolean;
    function GetStringField(const FieldName: string): string;
    function GetFloatField(const FieldName: string): double;
    function GetIntegerField(const FieldName: string): Integer;
    function GetLargeintField(const FieldName: string): Largeint;
    function GetBooleanField(const FieldName: string): Boolean;
    function GetDateTimeField(const FieldName: string): TDateTime;
    procedure SetStringField(const FieldName: string; const Value: string);
    procedure SetFloatField(const FieldName: string; const Value: double);
    procedure SetIntegerField(const FieldName: string; const Value: Integer);
    procedure SetLargeintField(const FieldName: string; const Value: Largeint);
    procedure SetBooleanField(const FieldName: string; const Value: Boolean);
    procedure SetDateTimeField(const FieldName: string; const Value: TDateTime);
    procedure CallSavedFieldEvent(Field: TField; EventType: TEventType);
    procedure AfterDatasetCreated; overload; virtual;
    function TopLevelBusObj: TDatasetBusObj;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    property CustomFieldIdentifier: string read fsCustomFieldIdentifier write fsCustomFieldIdentifier;
    property RunningEventListEvents :Boolean read fbRunningEventListEvents write fbRunningEventListEvents;
    property BusObjEventList :TBusObjEventList read fEventList;
    Function GetCleanID :Integer; virtual; abstract;
    function  GetXMLNodeStringValue  (const Node: IXMLNode; const aNodeName: string): string;
    function  GetXMLNodeFloatValue   (const Node: IXMLNode; const aNodeName: string): double;
    function  GetXMLNodeIntegerValue (const Node: IXMLNode; const aNodeName: string): integer;
    function  GetXMLNodeBooleanValue (const Node: IXMLNode; const aNodeName: string): boolean;
    function  GetXMLNodeDateTimeValue(const Node: IXMLNode; const aNodeName: string): TDateTime;
    procedure SetPropertyFromNode(const aNode: IXMLNode; const aPropertyName, aNodeName: string; const Obj: TObject = nil); overload;
    procedure SetPropertyFromNode(const aNode: IXMLNode; const aPropertyName: string; const Obj: TObject = nil); overload;
    procedure SetDateTimePropertyFromNode(const aNode: IXMLNode; const aPropertyName, aNodeName: string; const Obj: TObject = nil); overload;
    procedure SetDateTimePropertyFromNode(const aNode: IXMLNode; const aPropertyName: string; const Obj: TObject = nil); overload;
    procedure SetBooleanPropertyFromNode(const aNode: IXMLNode; const aPropertyName, aNodeName: string; const Obj: TObject = nil); overload;
    procedure SetBooleanPropertyFromNode(const aNode: IXMLNode; const aPropertyName: string; const Obj: TObject = nil); overload;
    property NonContainerComponentsDirty: Boolean read GetNonContainerComponentsDirty write SetNonContainerComponentsDirty;
    function GetVars: TBusObjVars;
    property Vars: TBusObjVars read GetVars;
    Function GetAccessManager :TDNMAccessManager; virtual;
    procedure SetIsNew(const Value: boolean); virtual;
    function GetIsList: boolean; virtual;
    procedure SetFieldtoNull(const FieldName: string);
    procedure Repostcallback(Const Sender: TBusObj; var Abort: boolean) ; virtual;
    function GetMsUpdateSiteCode: string; virtual;
    procedure SetMsUpdateSiteCode(const Value: string); virtual;
    function FieldExists(const fieldname:String):Boolean;
    function GetKeyValue: string; virtual;
    procedure CaptureDatasetEvents;virtual;
    procedure ReleaseDatasetEvents;virtual;
    function TempQry(sql: string = ''): TERPQuery;
    Procedure LoadPropnames;virtual;
    function GetBusObjectTypeDescription: string; virtual;
  public
    property DoFieldChange: boolean read fDoFieldChange write SetDoFieldChange ;
    Function NoRigtsMsg(const NoRightsfor:String):String;
    class Function GetIDField :String ; Virtual; abstract;
    class function GetKeyStringField: string; virtual;
    class function GetBusObjectTablename: string; virtual;abstract;
    class function SetNextIdNumber(const nextId: integer; Connection: TMyConnection): boolean;
    class function GetMaxIdNumber(Connection : TMyConnection) : integer;
    constructor Create(AOwner: TComponent); Overload;override;
    constructor Create(AOwner: TComponent; aObjSQL:string); Overload;
    destructor Destroy; override;
    class function GetKeyStringProperty: string; virtual;
    procedure Reset;
    Property SQLSelect :String read fSQLSelect;
    Property SQLOrder  :String read fSQLOrder Write fSQLOrder;
    Property SQLGroup :String read fSQLGroup write fSQLGroup;
    property InteractiveMode: boolean read fInteractiveMode write fInteractiveMode; // yet to be implemented
    property BusObjectTableName: string read GetBusObjectTablename;
    property BusObjectTypeDescription: string read GetBusObjectTypeDescription;
    property CanRead: boolean read GetCanRead;
    property CanUpdate: boolean read GetCanUpdate;
    property CanCreate: boolean read GetCanCreate;
    property CanDelete: boolean read GetCanDelete;
    Property XMLSearchRecord : String read fsXMLSearchRecord Write fsXMLSearchRecord;
    Property XMLSearchRecordDesc : String read fsXMLSearchRecordDesc Write fsXMLSearchRecordDesc;
    Property NoRightReason :String  read FNoRightReason write FNoRightReason;
    Property ObjectProperties :TBusobj read GetObjectProperties;
    function ValidateData: boolean ;Override;
    function ValidateDataList: boolean; override;
    procedure Load(const fIsReadonly:boolean =False); override;
    procedure Load(Const aId: integer;const fIsReadonly:boolean =False); override;
    procedure Load(Const aGlobalRef: string; const fIsReadonly: boolean = False); override;
    procedure LoadCount(Const Limitcount: integer; const LimitFrom: integer = -1);
    property LoadParamList: TStringList read GetLoadParamList;
    function Save: boolean; override;
    procedure PostDb; virtual;
    Procedure PostnEditDB;virtual;
    Procedure EditnPostDB;
    Procedure CancelDb;
    function Locate(const KeyFields: string; const KeyValues: variant;Options: TLocateOptions): boolean; virtual;
    function LocateId(const aId: integer): boolean;
    function LocateBarcode(const aBarcode: string): boolean;
    procedure New; Overload; override;
    procedure New(DoInsert: Boolean); reintroduce; Overload;
    property IsNew: boolean read fIsNew write SetIsNew;
    procedure Edit; override;
    function Delete: boolean; overload; override;
    procedure DeleteCallback(Const Sender: TBusObj; var Abort: boolean) ; overload;
    procedure Cancel; override;
    procedure Close(const doReset: boolean = false);
    Function DataasetStateStr:String;

    procedure First;
    procedure Next;
    procedure Prior;
    procedure Last;
    property EOF: boolean read GetEOF;
    property BOF: boolean read GetBOF;
    property Dirty: boolean read GetDirty write SetDirty;
    property AnyDirty: boolean read GetAnyDirty write SetAnyDirty;
    property DoSavedFieldEvents: boolean read fDoSavedFieldEvents write fDoSavedFieldEvents;
    property DoCurrentFieldSavedEvent: boolean read fDoCurrentFieldSavedEvent write fDoCurrentFieldSavedEvent;
    property RoundPlacesGeneral: word read fRoundPlacesGeneral write fRoundPlacesGeneral;
    property CurrencyRoundPlaces: word read getRoundPlacesTotals write fCurrencyRoundPlaces;
    Property UserLock :TUserLock read GetUserLock write fUserLock;
    Property NullWhenDateIs0 :Boolean read fbNullWhenDateIs0 write fbNullWhenDateIs0;
    function Lock :Boolean ; Overload; virtual;
    function LockInUse :Boolean ; virtual;
    function LockAll(const ADatasetName: string; const Lockgroup:String) :Boolean ; Overload; virtual;
    function Lock(const Lockgroup:String) :Boolean ; Overload; virtual;
    function UnLock :Boolean ;
    function IsLocked: boolean;
//    Function ValidateCustomFields :Boolean;
    property BusObjEvent: TBusObjEvent read fBusObjEvent write fBusObjEvent;
    Property IgnoreAccesslevel :Boolean read getIgnoreAccesslevel write fbIgnoreAccesslevel;
    property AccessManager: TDNMAccessManager read getAccessManager Write SetAccessManager;
    procedure AddEvent(const aEventType, aEventValue: string ;aObjectId :Integer; aEventObj :TDatasetBusObj = nil);
    procedure SendEvent(const aEventType, aEventValue: string; aEventObj :TDatasetBusObj = nil);
    procedure SendAllEvents;
    Procedure ClearAllEvents;
    procedure EditDB;
    function GetNewDataSet(Const strSql :String; Const InTransaction :Boolean = False ) :TCustomMyDataset;overload;
    function GetSharedDataSet(Const strSql :String; Const InTransaction :Boolean = False ) :TERPQuery;
    Function getSharedScript(Const strSql :String; Const InTransaction :Boolean = False ) :TERPScript;
    Class function GetNewDataSet(Const strSql :String; Conn: TCustomMyConnection  ) :TCustomMyDataset;overload;
    function GetNewDataSet(Const QrySql :TStringList; Const InTransaction :Boolean = False ) :TCustomMyDataset;overload;
    procedure ExecuteSQL(Const QrySql :TStringList; Const InTransaction :Boolean = False ); Overload;
    procedure ExecuteSQL(Const QrySql :String; Const InTransaction :Boolean = False );Overload;
    function FieldByName(const AFieldName: string): TField;
    Property CleanID :Integer REad GetCleanID;
    Property DoFieldChangewhenDisabled :Boolean read fbDoFieldChangewhenDisabled Write fbDoFieldChangewhenDisabled;
    property ExternalDatasetAssigned: boolean read fExternalDatasetAssigned;
    function ConnectionAssigned: Boolean;
    function DatasetAssigned: Boolean;
    Class function IDToggle(const ID: Integer; Connection: TCustomMyConnection = nil; const AndSQL: string = ''): string; overload; virtual;
    Class function IDToggle(const KeyString: string; Connection: TCustomMyConnection = nil; const AndSQL: string = ''): Integer; overload; virtual;
    Class function IDToggle(ToggleKeyStringField:String;  const KeyString: string; Connection: TCustomMyConnection = nil; const AndSQL: string = ''): Integer; overload; virtual;
    Class function IDToggle(const KeyString: string; CreateNewifnotfound:boolean ;Cls: TPersistentClass;Connection: TCustomMyConnection = nil; const AndSQL: string = ''): Integer; overload; virtual;

    Class Function XMLNodeName :String; virtual;
    Class function IDGlobalRefToggle(const ID: Integer; Connection: TCustomMyConnection = nil): string; overload;
    Class function IDGlobalRefToggle(const GlobalRef: string; Connection: TCustomMyConnection = nil): integer; overload;
    Property ImportingFromXMLFile :Boolean REad fbImportingFromXMLFile Write fbImportingFromXMLFile;
    Property ExcludeInactive :Boolean Read fbExcludeInactive Write fbExcludeInactive;
    property LimitCount: integer read fLimitCount write fLimitCount;
    property LimitFrom: integer read fLimitFrom write fLimitFrom;
    property Connection: TMyDacDataConnection read GetConnection write SetConnection;
    property SQL: string read GetSQL write fSQL;
    Property Dataset :TCustomMyDataset read getDataSet write SetDataset;
    procedure LoadSelect(Const SelectStatement: string;const fIsReadonly:boolean =False);Virtual;
    property IsList: boolean read GetIsList write SetIsList;
    property IsChild: boolean read fIsChild;
    Property ObjPropcount:Integer read fiObjPropcount write fiObjPropcount;
    class function _Schema: string; override;
    function PropertyNameToFieldName(aPropName: string): string; virtual;
    function heirarchyname(includeDsName:Boolean =true): String;Override;
    function datasetname:String;
    function ValidateObjectProperties: Boolean;
    function fielddisplaylabel(const FieldName:String):String;
    Function GetBookmark:TBookmark;
    Procedure GotoBookmark(bm :TBookmark);
    Procedure FreeBookmark(bm :TBookmark);
    function Propnames :TStringlist;
    Property Progresscount :Integer read fiProgresscount;
    Property ProgressMsg :String read fsProgressMsg;
    Property ProgressDialogobj : TProgressDialog read fProgressDialogobj write fProgressDialogobj;
    function datasetheirarchyname: String; virtual;
    function APIListDefaultProperties: string; virtual;
    class function FieldData(const aId: integer; FieldCommaList: string; Conn: TCustomMyConnection = nil): TJsonObject;
    Property check4fieldErrorMsg:String read fsCheck4FieldErrorMsg write fsCheck4FieldErrorMsg;
    Property EnablePropertySetWhenREadonly :Boolean read fbEnablePropertySetWhenREadonly write fbEnablePropertySetWhenREadonly;
    function IsdataIdchangeEvent(aEventValue: String): Boolean;
    procedure ShowRec(aId: Integer; ainfo: String; showheader:Boolean = false);
    function GroupConcat(const concatField:String; const Datasetfilter:String = ''; const Disablefilter:boolean = False; Delim:String=',' ;PrefixStr:String = ''; SufixStr:String = '';Quoteeach:Boolean =False; GroupDistinct:Boolean = False):String;
    Procedure ExecuteWithProgressbar(Const Script :TERPScript; aProgCaption:String = '');
    Property DoInitFloatFieldDisplayFormat :boolean read getDoInitFloatFieldDisplayFormat write fbDoInitFloatFieldDisplayFormat;
    Procedure GotoRecord(const aRecno:Integer);
    Procedure TruncateTable;
    property KeyString: string read GetKeyString;
  published
    property ID: integer read GetId ;//write SetId;
    property MsTimeStamp: TDateTime read GetMsTimeStamp write SetMsTimeStamp;
    property MsUpdateSiteCode: string read GetMsUpdateSiteCode write SetMsUpdateSiteCode;
    property KeyValue: string read GetKeyValue;
    procedure DLLLoadSelect(Const SelectStatement: string);
    property Count: integer read GetCount;
    Property Recno :Integer read getRecno;
    Property ISEmpty :Boolean read getIsEmpty;
    function DLLSave:Boolean;
    function DLLDelete:Boolean;
    Procedure DLLNew;
    Procedure DLLPostDB;
    Property IDFieldName :String read GetIDField;
    property KeyStringFieldName: string read GetKeyStringField;


  end;

  TBookmarkRec = record
    Bookmark      : TBookmark;
    Abort         : Boolean;
    IsFiltered    : Boolean;
    EmptyDataset  : Boolean;
    fDisableFilter: Boolean;
  end;

//===============================================================\\
  TBusObjClass = class of TBusObj;
  TBusObj = class(TDatasetBusObj, IBusObjXML)
  private
    FDataSources    :TObjectList;
    fLogChangesOnSave: boolean;
    fsFieldsnotToclone : String;
    fbSavingXMLTofile :Boolean;
    fbImportFailed :Boolean;
    fsXMLDataVersion :String;
    fsXMLOnError :String;
    fsXMLType :String;
    fsXMLSourceObject :String;
    fiRecordcount :Integer;
    fiTranscount :Integer;
    fiLocateXMLRecordID:Integer;
    fsLocateXMLRecordglobalRef:String;
    foREsultNode    :IXMLNode;
    foREsultNodeParent:IXMLNode;
    fsLockGroupName :String;
    fsTableName :String;
    fsMappedfields4copy :string;
    fsMappedValues4copy :String;

    //fsDetailMappings:string;
    fUserVersion :String;
    fbValidated :Boolean;
    fPostList :TPostList;
    fAssignedPostList: TPostList;
    fLimitXMLFieldsOnSave: boolean;
    fbCopyingTrans :Boolean;
    fsProgressbarmsg: String;
    fAllSubObjectsValid: boolean;
    fTempData: TJsonObject;
    fsIteraterecordProgressbarMsg: String;
    fbAddNewWhenCloning: Boolean;
    fbLoadXMLinLoad: Boolean;
    fMyDAcDataconnection: TMyDAcDataconnection;
    isAllRecValid:Boolean;
    fsAuditLogDetails: String;

    Function getConfirmFromGui  : TGeneralconfirm;
    Procedure SetActive(Const Value :Boolean);
    procedure RemoveDataSource(Const DataSource: TBusDataSource);
    procedure AddDataSource(Const DataSource: TBusDataSource);
    function GetXMLDoc: TXMLDocument;
    function GetCleanXMLDoc: TXMLDocument;
    ////Function getSrNoTransObj : TSrNoTrans;
//    class Function getXMLNodeName :String;
    Function getResultNode:IXMLNode;
    Procedure UnlockTables;
    function Searchnode(const node :IXMLNode ; const Tagname:String ; const xNodeValue : Variant) :IXMLNode;
    Function getTableName :String;
    Procedure MoveField(const FromField, Tofield:TField);overload;
    Procedure MoveField(const Tofield:TField; const FieldValue :Variant); overload ;
    function GetLimitXMLFieldsOnSave: boolean;
    procedure SetLimitXMLFieldsOnSave(const Value: boolean);
    procedure SetPostList(const Value: TPostList);
    function GetActive: Boolean;
    function getCopyingTrans: Boolean;
    procedure setCopyingTrans(const Value: Boolean);
    function getTransactionName: String;
    procedure SetFieldsToClone(const Value: String);
    procedure ValidateSubObjectCallbackProc (Const Sender: TBusObj; var Abort: Boolean);
    function GetOwnerTempData: TJsonObject;
    function GetTempData: TJsonObject;
    function getFilter: String;
    function getFiltered: Boolean;
    procedure setfilter(const Value: String);
    procedure setfiltered(const Value: Boolean);
    function getIteraterecordProgressbarMsg: String;

    function getAllIDs: String;
    procedure AllIdsCallback(const Sender: TBusObj; var Abort: boolean);
    function getLoadXMLinLoad: Boolean;
    procedure ValidateDataCallback(const Sender: TBusObj; var Abort: boolean);
    Procedure initAuditTrailDetails(Const Value:String);

  protected

    fCleanXMLDoc: TXMLDocument;
    fXMLDoc: TXMLDocument;
    fbObjectCopied :Boolean;
    fConfirmFromGUI:TGeneralconfirm;
    fLoadingCleanXML: boolean;
    LockGroupNamesofCopiedObjs:array of String;
    fsAllIds:String;
    ObjInstanceToCloneisLocal:Boolean;
    function GetLoadingCleanXML: boolean;
    ////fbSrNoTransObj : TSrNoTrans;
    function ExcludeFromclone:String; virtual;
    Function GetCleanID :Integer; override;
    Procedure AfterDatasetCreated;Override;
    function GetXML: string;
    procedure SetXML(const Value: string);
    procedure InitializeNewObject; virtual;


    function CompareXMLNodes(Const n1, n2: IXMLNode; var DiffList: TStringList; const Heirarchy:Integer): boolean;
    function GetCleanXMLNode: IXMLNode; virtual;
    Procedure CreateInstance; Virtual;
    Procedure ClonePropertyObjects; virtual;
    Procedure CopyPropertyObjects(const Mappedfields :STring); virtual;
    Function ValidateXMLData(const node :IXMLNode) :Boolean ; Virtual;
    Function ForeignKeysValid(const node: IXMLNode):Boolean; Virtual;
    Function ImportsubClasses(const node: IXMLNode):Boolean; Virtual;
    Function ExportsubClasses(const node: IXMLNode):Boolean; Virtual;
    Procedure LocateXMLRecord;
    Procedure ErrRecordNotfound(const Keyname, KeyValue:String);
    procedure AddXMLHeaderNode(const node: IXMLNode); Virtual;
    Function getconversiontype :String;
    procedure AddXMLNode(Const Node : IXMLNode; Const sNodeName :String; Const Value : OleVariant; Const XMLTagsinLowercase :Boolean = True);
//    procedure AddXMLBlobNode(Const Node : IXMLNode; Const sNodeName :String; Const Value : OleVariant; Const XMLTagsinLowercase :Boolean = True);
    procedure AddXMLCDataNode(Const Node : IXMLNode; Const sNodeName :String; Const Value : OleVariant; Const XMLTagsinLowercase :Boolean = True);
    Function getPostList: TPostList;
    Procedure getCleanFromPArent(obj :TBusObj; fClean : TXMLDocument; var node: IXMLNode);
    function Validtocommit:Boolean; virtual;
    Procedure AssignProgressdialog(const xPostList: TPostList);virtual;
    function ValidateSubObject(SubObj: TBusObj): boolean;
    Procedure AfterCloneBusObj; virtual;
    procedure setIsReadonly(const Value: boolean); override;
    function getIsReadonly: boolean; override;
    procedure InactivateAllCallback(const Sender: TBusObj; var Abort: boolean); virtual;
    procedure CustomiseauditInfo(sl:TStringlist);virtual;
    procedure HideProgressbar;
    procedure showProgressbar(aProgresscount:Integer; aProgressMsg:String = '');
    procedure stepProgressbar(const aProgressMsg:String = '');
    Procedure OnReGenerateNumber; virtual;
    function BusobjMessageDlg(const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint;
        const Owner: TComponent=nil;
        const CustomButtonsStr :String = ''): Word;

  public
    ObjInstanceToClone :TBusObj;
    CloneSource: TBusObj;
    XMLPropertyNode: IXMLNode;
    XMLPropertyName :STring;
    function ValidateDataList: boolean; override;
    property TempData: TJsonObject read GetTempData;
    property OwnerTempData: TJsonObject read GetOwnerTempData;
    function CompareXMLDocs(Const d1, d2: TXMLDocument): boolean;
    Constructor Create(AOwner: TComponent); override;
    Constructor CreateWithNewConn(AOwner: TComponent;aConnection: TERPConnection=nil);
    Constructor CreateWithSharedConn(AOwner: TComponent);
    Destructor Destroy; override;
    Property AddNewWhenCloning:Boolean read fbAddNewWhenCloning write fbAddNewWhenCloning default True;
    Class Function XMLBranchName :String; virtual;
    Class Function ExportHeader :String;// virtual;
    Class Function ExportFooter :String;// virtual;
    Function Error :Boolean;
    procedure SaveXMLToFile(const FileName: string);
    Property FieldsnotToclone : String Read fsFieldsnotToclone Write SetFieldsToClone;
    Procedure Opendb;
    Procedure RefreshDB;
    Procedure Closedb; virtual;
    function GetBookmarkRec(var Rec: TBookmarkRec; DisableFilter: Boolean = False): Boolean;
    procedure RestoreBookmarkRec(const Rec: TBookmarkRec; Const Abort:Boolean);
    procedure RunProc(CallbackFunc: TBusObjProc; DisableFilter: boolean = false);
    procedure IterateRecords(CallbackFunc: TBusObjCallbackProc; DisableFilter: boolean = false; doShowProgressbar:boolean = False);
    procedure IterateRecordsReverse(CallbackFunc: TBusObjCallbackProc; DisableFilter: boolean = false);
    procedure BusObjCopy(Const Sender: TBusObj; var Abort: boolean); virtual;

    Function  DeleteAll(AddDeletedItem: boolean = false): Boolean; virtual;
    procedure SaveToXMLNode(const node: IXMLNode); virtual;
    Procedure LoadFromXMLNode(const node: IXMLNode); Virtual;
    Procedure DeleteRecord(const Value :Boolean = True) ;
    procedure InactivateAll;virtual;
    property XML: string read GetXML write SetXML;
    property XMLDoc: TXMLDocument read GetXMLDoc;
    property CleanXMLDoc: TXMLDocument read GetCleanXMLDoc;
    property CleanXMLNode: IXMLNode read GetCleanXMLNode;
    procedure Load(const fIsReadonly:boolean =False); override;
    function Save: boolean; override;
    //procedure Linecopy(Sender: TBusObj; var Abort: boolean);
    Function CopyTrans(const Changefield :String; const ChangeValue :Variant; const SaveAfterCopy :boolean = True; const FilterFields :String = ''):TBusObj;
    Function CloneBusObj(const Changefield :String; const ChangeValue :Variant; const SaveAfterCopy : Boolean = True; const FilterFields :String = ''):TBusObj; Overload;virtual;
    function CopyUsingTransactionMaper(const CopyToType:String; const SaveAfterCopy : Boolean = True):TBusObj;
    Procedure UnlockAfterCopyUsingTransactionMaper(const Copiedobj :TBusobj);
    procedure GetPropertyXMLCallback(Const Sender: TBusObj; var Abort: boolean); virtual;
    function getUserVersion:String;

    //Property XMLNodeName : String read getXMLNodeName;
    Property LoadXMLinLoad:Boolean read getLoadXMLinLoad write fbLoadXMLinLoad;
    Property SavingXMLTofile :Boolean Read fbSavingXMLTofile Write fbSavingXMLTofile;
    Property ImportFailed   :Boolean read fbImportFailed write fbImportFailed;
    Property XMLOnError     :String read fsXMLOnError write fsXMLOnError;
    Property XMLDataVersion :String read fsXMLDataVersion;
    Property XMLType        :String read fsXMLType;
    Property XMLSourceObject:String read fsXMLSourceObject;
    Property Transcount :Integer Read fiTransCount Write fiTranscount;
    Property REsultNode :IXMLNode REad getREsultNode Write foREsultNode;
    Property REsultNodeParent :IXMLNode REad foREsultNodeParent Write foREsultNodeParent;
    Property LockGroupName  :String Read fsLockGroupName Write fsLockGroupName;
    Property PostList :TPostList read getPostList write SetPostList;
    Property confirmFromGUI :TGeneralconfirm REad getConfirmFromGui Write fconfirmfromGui;
    Property Mappedfields4copy :String read fsMappedfields4copy write fsMappedfields4copy;
    Property MappedValues4copy :String read fsMappedValues4copy Write fsMappedValues4copy;
    Property Validated :Boolean REad fbValidated Write fbValidated;
    Function ImportFromXML(const node: IXMLNode):Boolean;
    class function IsUnique(const RecordID: Integer; const UniqueCheckStatement: string; Connection: TCustomMyConnection = nil): Boolean;
    Property TableName      :String REad getTableName write fsTablename;
    Property Convertiontype :String read getconversiontype;
    property LogChangesOnSave: boolean read fLogChangesOnSave write fLogChangesOnSave;
    ////Property SrNoTransObj : TSrNoTrans read getSrNoTransObj Write fbSrNoTransObj;
    Procedure AfterCopy; virtual;
    property LimitXMLFieldsOnSave: boolean read GetLimitXMLFieldsOnSave write SetLimitXMLFieldsOnSave;

    procedure FilterSelect(FilterNode: IXMLNode);
    procedure FilterAdd(FilterNode: IXMLNode);
  //published
    property DatasetActive  : Boolean      read GetActive    write SetActive;
    Property CopyingTrans :Boolean Read getCopyingTrans write setCopyingTrans;
    Property TransactionName :String Read getTransactionName;
    property LoadingCleanXML: boolean read GetLoadingCleanXML write fLoadingCleanXML;
    Procedure AddNewifMissing(const fHeader,fDataline:TStringList);virtual;
    Procedure OnSetpropErrors(const Propname, Value:String); virtual;
    Property Progressbarmsg:String read fsProgressbarmsg write fsProgressbarmsg;
    Property Filter :String read getFilter write setfilter;
    Property Filtered :Boolean read getFiltered write setfiltered;
    Function PropertyExists(Const PropName:String):Boolean;
    Property IteraterecordProgressbarMsg:String read getIteraterecordProgressbarMsg write fsIteraterecordProgressbarMsg;
    Property AllIds:String read getAllIDs;
    procedure copyobjRec(Changefield: String; const ChangeValue: Variant; TargetObj: TBusObj);
    function GetSharedMyDAcDataconnection: TMyDAcDataconnection;
    Property AuditLogDetails :String read fsAuditLogDetails;
    procedure DoFieldOnChange(Sender: TField); Override;
    procedure ReGenerateNumber(aFieldName: String; aGAP: Integer);

  end;


//===============================================================\\


  // Multi-Site Business Object
  TMSBusObjClass = class of TMSBusObj;
  TMSBusObj = class(TBusObj, IMSBusObj)
  private
  protected
    function GetGlobalRef: string; virtual;
    procedure SetGlobalRef(const Value: string); virtual;
    Function  DoAfterPost(Sender :TDatasetBusObj): Boolean; Override;
    Function  DoBeforePost(Sender :TDatasetBusObj): Boolean; Override;
    procedure AddXMLHeaderNode(const node: IXMLNode); Override;
  public
    procedure AssignGlobalRef;
    procedure FlagAsUpdated(aTimeStamp: TDateTime = 0); {overload;} virtual;
//    procedure FlagAsUpdated(aTimeStamp: TDateTime = 0; aUpdateSiteCode: string = ''); overload; virtual;
    procedure DoUpdateSiteCode;
    function Save: boolean; override;
    constructor Create(aOwner: TComponent); overload; override;
    constructor Create(aOwner: TComponent; DbConnection: TCustomMyConnection); reintroduce;overload;
    Function SharedQuery:TERPQuery;
  published
    property GlobalRef: string read GetGlobalRef write SetGlobalRef;
  end;
//===============================================================\\

  TDataConnection = Class(TERPComponent)
  private
    FBusobj    :TObjectList;
    function GetConnected: boolean; virtual; abstract;
    procedure SetConnected(const Value: boolean); virtual; abstract;
    procedure RemoveBusObj(BusObj: TDatasetBusObj);
    procedure AddBusObj(BusObj: TDatasetBusObj);
  protected
    function GetDBConnection: TCustomConnection; virtual; abstract;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Connected: boolean read GetConnected write SetConnected;

    procedure BeginTransaction; virtual; abstract;
    procedure CommitTransaction; virtual; abstract;
    procedure RollbackTransaction; virtual; abstract;

    Procedure BeginNestedTransaction; virtual; abstract;
    procedure CommitNestedTransaction; virtual; abstract;
    procedure RollbackNestedTransaction; virtual; abstract;

    Procedure BeginTransOrNestedTrans(CleanInTrans:Boolean); virtual; abstract;
    procedure CommitTransOrNestedTrans(CleanInTrans:Boolean); virtual; abstract;
    procedure RollbackTransOrNestedTrans(CleanInTrans:Boolean); virtual; abstract;

    function GetDataset(Sender: TDatasetBusObj): TCustomMyDataset;  virtual; abstract;
    procedure DatasetLoad(Sender: TDatasetBusObj); virtual; abstract;
    procedure DatasetSave(Sender: TDatasetBusObj); virtual; abstract;
    procedure DatasetNew(Sender: TDatasetBusObj); virtual; abstract;
    procedure DatasetEdit(Sender: TDatasetBusObj); virtual; abstract;
    procedure DatasetDelete(Sender: TDatasetBusObj); virtual; abstract;
    procedure DatasetCancel(Sender: TDatasetBusObj); virtual; abstract;
    property DBConnection: TCustomConnection read GetDBConnection;
    function InTransaction: boolean; virtual; abstract;
  end;

  TMyDacDataConnection = class(TDataConnection)
  private
    fThreadId: Cardinal;
    ActiveSavePointList: TStringList;
    function GetConnected: boolean; override;
    procedure SetConnected(const Value: boolean); override;
    function getcondetails: String;
  protected
    function GetDBConnection: TCustomConnection; override;
  public
    MyDacConnection: TCustomMyConnection;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure BeginTransaction; override;
    procedure CommitTransaction; override;
    procedure RollbackTransaction; override;

    procedure BeginNestedTransaction; override;
    procedure CommitNestedTransaction; override;
    procedure RollbackNestedTransaction; override;

    Procedure BeginTransOrNestedTrans(CleanInTrans:Boolean); Override;
    procedure CommitTransOrNestedTrans(CleanInTrans:Boolean); Override;
    procedure RollbackTransOrNestedTrans(CleanInTrans:Boolean); Override;

    function GetDataset(Sender: TDatasetBusObj): TCustomMyDataset; override;
    procedure DatasetLoad(Sender: TDatasetBusObj); override;
    procedure DatasetSave(Sender: TDatasetBusObj); override;
    procedure DatasetNew(Sender: TDatasetBusObj;DoInsert :Boolean); reintroduce; Overload;
    procedure DatasetNew(Sender: TDatasetBusObj); Overload;override;
    procedure DatasetEdit(Sender: TDatasetBusObj); override;
    procedure DatasetDelete(Sender: TDatasetBusObj); override;
    procedure DatasetCancel(Sender: TDatasetBusObj); override;
    function InTransaction: boolean; override;
    Property condetails :String read getcondetails;
  Published
    property ThreadId: Cardinal read fThreadId write fThreadId;
    Property Connection : TCustomMyConnection read   MyDacConnection write MyDacConnection;
  end;

  TBusDatasource = class(TDatasource)
  private
    fBusObj         :TBusObj;
    fBusObjAssigned :Boolean;
    Procedure  setbusObj(Const value :TBusObj);
    Procedure SetDataset(fbDataset :TDataset);
  Public
    constructor Create(AOwner :TComponent);Override;
    destructor  Destroy; override;
  published
    Property    BusObj :TBusObj read fBusObj write setBusObj;
  end;


  TSharedDataConnectionList = class(TObjectList)
  private
    function GetSharedDataConn(const ThreadId: Cardinal): TMyDacDataConnection;
  public
    procedure RemoveSharedDataConnInstance;
    property SharedDataConnection[Const ThreadId: Cardinal]:TMyDacDataConnection read GetSharedDataConn;
  end;

  function GetSharedDataConnection: TMyDacDataConnection;

  function LoadFilterParamsFromNode(Obj: TBusObjBase;
                                    FilterNode: IXMLNode;
                                    ParamList: TStringList;
                                    var sql: string): boolean;

const
  { Dataset Event constants }
  evDSOnChange     = faGenDataSet + 0;
  evDSOnGetText    = faGenDataSet + 1;
  evDSOnSetText    = faGenDataSet + 2;
  evDSOnValidate   = faGenDataSet + 3;
  evDSAfterOpen    = faGenDataSet + 4;
  evDSAfterClose   = faGenDataSet + 5;
  evDSBeforeClose  = faGenDataSet + 17;
  evDSBeforeDelete = faGenDataSet + 6;
  evDSBeforePost   = faGenDataSet + 7;
  evDSAfterPost    = faGenDataSet + 8;
  evDSAfterInsert  = faGenDataSet + 9;
  evDSCalcFields   = faGenDataSet + 10;
  evDSBeforeInsert = faGenDataSet + 11;
  evDSNewRecord    = faGenDataSet + 12;
  evDSBeforeOpen   = faGenDataSet + 13;
  evDSBeforeEdit   = faGenDataSet + 14;
  evDSAfterAssignDataset = faGenDataSet + 15;
  evDSAfterCreate  = faGenDataSet + 16;

var
  SharedDataConnList :TSharedDataConnectionList;

//===============================================================\\



implementation

uses
  Forms, CommonDbLib,   Controls, Variants,
  BusObjAudit, frmDelayMessageDlg, Windows, MyScript,
  CommonLib, BusObjConst,
  tcDataUtils,
  TypInfo, AppEnvironment, ClassExtenderListObj,
  BusObjNDSBase, XMLRequestConst,  //CustomFieldConfigObj,
  EmployeeObj, CustomPropConfigObj, JsonToBusObj,  sysutils,
  AuditTrialTreeLib, LogThreadLib, MySQLConst, XMLFuncLib, strutils, types,
  busobjobjectproperties, SystemLib, DbSharedObjectsObj, BusObjDeletedItem,
  JsonToDatasetFuncs, Dateutils , DAScript  , LogLib; //, FixedAssetsServiceLogList;

Type
  PEventRec = ^TEventRec;

const
  DoMsgLogging = true;

var
  SharedDataConnLock :TCriticalSection;

procedure DoLog(Const msg: string);
begin
  if DoMsgLogging = true then
      Log(Msg, 'Debug');
end;


//  TBusObjDataChangeType = (dcLoad, dcDelete, dcNew, dcSave, dcClose);
function DataChangeTypeToStr(aChangeType: TBusObjDataChangeType): string;
begin
  case aChangeType of
    dcLoad:    result := 'Load';
    dcDelete:  result := 'Delete';
    dcNew:     result := 'New';
    dcSave:    result := 'Save';
    dcClose:   result := 'Close';
    else raise Exception.Create('DataChangeTypeToStr - Unknown change type: ' + IntToStr(Ord(aChangeType)));
  end;
end;

function LoadFilterParamsFromNode(Obj: TBusObjBase;
                                  FilterNode: IXMLNode;
                                  ParamList: TStringList;
                                  var sql: string): boolean;
var
  qry: TERPQuery;
  fn: string;
  paramNode: IXMLNode;
  filterStr: string;
begin
  result:= true;
  if VarIsNull(FilterNode.Attributes[XMLAttFilterName]) then begin
    result:= false;
    obj.ResultStatus.AddItem(false,rssError,0,'FilterName missing');
    exit;
  end;
  fn:= FilterNode.Attributes[XMLAttFilterName];
  if fn = '' then begin
    result:= false;
    obj.ResultStatus.AddItem(false,rssError,0,'filterName is blank');
    exit;
  end;
  qry:= CommonDbLib.TempMyQuery;
  try
    qry.SQL.Add('Select * from tblBusObjFilter f');
    qry.SQL.Add('left join tblbusobjfilterparam fp on fp.BusObjFilterId = f.BusObjFilterId');
    qry.SQL.Add('where f.ClassName = ' + QuotedStr(obj.ClassName));
    qry.SQL.Add('and f.FilterName = ' + QuotedStr(fn));
    qry.Open;
    if qry.RecordCount = 0 then begin
      result:= false;
      obj.ResultStatus.AddItem(false,rssError,0,'The Filter "' + fn + '" does not exist');
      exit;
    end;
    sql:= qry.FieldByName('SQLString').AsString;
    while not qry.Eof do begin
      if qry.FieldByName('ParamName').IsNull then
        { no params supplied (some filters non't have params) }
        break;
      ParamNode:= FilterNode.ChildNodes.FindNode(qry.FieldByName('ParamName').AsString);
      if not Assigned(ParamNode) then begin
        result:= false;
        obj.ResultStatus.AddItem(false,rssError,0,'The parameter "' +
          qry.FieldByName('ParamName').AsString + '" for Filter "' + fn + '" does not exist');
        exit;
      end;
      filterStr:= '';
      if ParamNode.HasChildNodes and (ParamNode.ChildNodes[0].NodeType = ntCData) then
        filterStr:= ParamNode.ChildNodes[0].NodeValue
      else
        filterStr:= ParamNode.NodeValue;

      if filterStr = '' then begin
        result:= false;
        obj.ResultStatus.AddItem(false,rssError,0,'The value for parameter "' +
          qry.FieldByName('ParamName').AsString + '", for Filter "' + fn + '" is blank');
        exit;
      end;
      ParamList.Values[qry.FieldByName('ParamName').AsString]:= filterStr;
      qry.Next;
    end;
  finally
    qry.Free;
  end;
end;


{ TBusObjBase }

constructor TBusObjBase.Create(AOwner: TComponent);
//var
//  CustPropConfig: TCustomPropConfig;
begin
  inherited;
  fClearContainerListOnNew := true;
  fbIsReadonly := False;
  fRawMode:= false;
  fExportExcludeList:= TStringList.Create;
  fImportFieldsPriorityList:= TStringList.Create;
  fFieldChangetoIgnoreInRawModeList:= TStringList.Create;
  fExportExcludeList.Add('tag');
  fExportExcludeList.Add('name');
  fExportExcludeList.Add('count');
  fExportExcludeList.Add('IDfieldname');
  ContainerList:= TBusObjContainerList.Create(self);
  fClearContainerListOnLoad:= true;
//  CustPropConfig:= CustomPropConfigObj.CustPropConfigForObject(self);
//  if Assigned(CustPropConfig) then begin
//    CustPropConfig.AddDisabledPropsToList(self.fExportExcludeList);
//    CustPropConfig.Free;
//  end;
  TCustomPropConfig.AddDisabledPropsToList(self);
  fDelayProcedureList:= TObjectList.Create;
end;
function TDatasetBusObj.datasetheirarchyname: String;
var
  obj:Tcomponent;
begin
  REsult := Self.ClassName +'.' + dataset.Name;
  obj := dataset.Owner;
  while obj<> nil do begin
    REsult := obj.ClassName + '->' +  result;
    obj := obj.Owner;
  end;

end;

destructor TBusObjBase.Destroy;
begin
  FreeAndNil(fDelayProcedureList);
  if Assigned(fResultStatus) then FreeAndNil(fResultStatus);
  fExportExcludeList.Free;
  fImportFieldsPriorityList.Free;
  fFieldChangetoIgnoreInRawModeList.Free;
  FreeAndNil(fProgressInfolocal);
  FreeAndNil(ContainerList);
  inherited;
end;

function TBusObjBase.Delete: boolean;
var x: integer;
begin
  result:= true;
  if Assigned(Container) then begin
    for x:= 0 to Container.Count -1 do begin
      if Container[x] is TBusObjBase then begin
        if opDelete in TBusObjBase(Container[x]).Options then
        TBusObjBase(Container[x]).Delete;
      end;
    end;
  end;

end;

procedure TBusObjBase.Edit;
var x: integer;
begin
  if Assigned(Container) then begin
    for x:= 0 to Container.Count -1 do begin
      if Container[x] is TBusObjBase then begin
        if opEdit in TBusObjBase(Container[x]).Options then
          TBusObjBase(Container[x]).Edit;
      end;
    end;
  end;
end;

procedure TBusObjBase.FieldChangetoIgnoreInRawMode(const Fieldname: String);
begin
  fFieldChangetoIgnoreInRawModeList.add(uppercase(Fieldname));
end;

procedure TBusObjBase.FreeContainerObjects;
var x: integer;
begin
  if Assigned(Container) then begin
    for x:= Container.Count -1 downto 0 do begin
      if Container[x] is TBusObjBase then begin
        Container.Delete(x);
      end;
    end;
  end;

end;

function TBusObjBase.GetRawMode: boolean;
begin
  if Assigned(Owner) and (Owner is TBusObjBase) then
    result:= TBusObjBase(Owner).RawMode
  else
    Result := fRawMode;
end;

function TBusObjBase.GetResultStatus: TResultStatus;
begin
  if Assigned(Owner) and (Owner is TBusObjBase) then
    result:= TBusObjBase(Owner).ResultStatus
  else begin
    if not Assigned(fResultStatus) then
      fResultStatus:= TResultStatus.Create(TResultStatusItem);
    result:= fResultStatus
  end;
end;

function TBusObjBase.GetSilentMode: boolean;
begin
  result:= self.ResultStatus.SilentMode;
end;

function TBusObjBase.getTProgressInfo: TProgressInfo;
begin
  if assigned(fProgressInfo)  then result := fProgressInfo
  else begin
    if (not Assigned(fProgressInfolocal)) then
      fProgressInfolocal:= TProgressInfo.Create;
    Result := fProgressInfolocal;
  end;
end;

procedure TBusObjBase.HideProgress;
begin
  if appenv.appdb.apimode then exit;
try
   if fProgressInfo <> nil then fProgressInfo.CloseDialog
   else if self is TDatasetBusObj then TDatasetBusObj(Self).SendEvent(BusobjEvent_ToDo, BusobjEvent_HideProgressbar, TDatasetBusObj(Self));
except
  if self is TDatasetBusObj then TDatasetBusObj(Self).SendEvent(BusobjEvent_ToDo, BusobjEvent_HideProgressbar, TDatasetBusObj(Self));
end;

end;

function TBusObjBase.InspectObj: String;
var
  PropEntrylist :TObjectList;
begin
  PropEntrylist:= TObjectList.Create(false);
  try
  AuditTrialTreeLib.InspectObj(Self ,PropEntrylist);
  finally
    Freeandnil(PropEntrylist);
  end;
end;

function TBusObjBase.IsFieldChangetoIgnoreInRawMode(const Fieldname: String): Boolean;
begin
  Result := False;
  if fFieldChangetoIgnoreInRawModeList.count =0 then exit;
  if not RawMode then exit;
  Result := fFieldChangetoIgnoreInRawModeList.indexof(uppercase(fieldname)) >=0 ;
end;

procedure TBusObjBase.Load(const aId: integer;const fIsReadonly:boolean =False);
begin

end;

function TBusObjBase.LastErrorMsgFromREsultStatus: String;
begin
  result := '';
  if REsultStatus.GetLastFatalStatusItem <> nil then begin
    result := REsultStatus.GetLastFatalStatusItem.Message;
    Exit;
  end;
  if REsultStatus.GetLastStatusItem <> nil then begin
    result := REsultStatus.GetLastStatusItem.Message;
    Exit;
  end;

end;

procedure TBusObjBase.Load(const aGlobalRef: string;
  const fIsReadonly: boolean);
begin

end;

procedure TBusObjBase.Log(const msg: string; msgType: string);
begin
  LogLib.Log(msg, msgType);
end;

procedure TBusObjBase.Load(const fIsReadonly:boolean =False);
begin
  if fClearContainerListOnLoad then
    ContainerList.Clear;
  if fIsReadonly then IsReadonly :=fIsReadonly;
end;

procedure TBusObjBase.New;
begin
  if ClearContainerListOnNew then
    ContainerList.Clear;
end;

function TBusObjBase.Parse(exp: string): boolean;
var
  Parser: TFEParser;
begin
  Parser := TFEParser.Create;
  try
    Parser.OnGetVar:= DoParserGetVar;
    Parser.Expr := exp;
    result := Parser.Get_Result;
  finally
    Parser.Free;
  end;
end;

function TBusObjBase.Save: boolean;
var x: integer;
begin
  result:= true;
  if Assigned(Container) then begin
    for x:= 0 to Container.Count -1 do begin
      if Container[x] is TBusObjBase then begin
        if opSave in TBusObjBase(Container[x]).Options then begin
          result:= TBusObjBase(Container[x]).Save;
          if not result then
            break;
        end;
      end;
    end;
  end;
end;

procedure TBusObjBase.Assign(Source: TPersistent);
var
  count, x: integer;
  PropList: PPropList;
  propName: string;
  PropInfo: PPropInfo;
begin
  Count := GetPropList(Source.ClassInfo, tkProperties, nil);
  GetMem(PropList, Count * SizeOf(PPropInfo));
  try
    GetPropList(Source.ClassInfo, tkProperties, PropList);
    for x := 0 to Count -1 do begin

      propName:=String(PropList[x].Name);
      if SameText(propName,'Id') or SameText(propName,'KeyValue') or SameText(propName,'GlobalRef') or SameText(propName,'MsTimeStamp') or SameText(propName,'MsUpdateSiteCode') then
        continue;
     if not Assigned(PropList[x].GetProc) then
       continue;
     PropInfo := GetPropInfo(self,PropName);
     if (not Assigned(PropInfo)) or (not Assigned(PropInfo.SetProc)) then
       continue;

      case PropList[x].PropType^.Kind of
        tkEnumeration,
        tkInteger,
        tkInt64,
        tkFloat,
        tkChar,
        tkString,
        tkWChar,
        tkLString,
        tkWString,
        tkUString : SetPropValue(self,PropName,GetPropValue(Source,PropName));

        tkSet,
        tkMethod,
        tkVariant,
        tkArray,
        tkRecord,
        tkInterface,
        tkUnknown,
        tkDynArray,
        tkClass:
          begin
          end;
      end;
    end;
  finally
    FreeMem(PropList, Count * SizeOf(PPropInfo));
  end;
end;

procedure TBusObjBase.Cancel;
var x: integer;
begin
  if Assigned(Container) then begin
    for x:= 0 to Container.Count -1 do begin
      if Container[x] is TBusObjBase then begin
        if opCancel in TBusObjBase(Container[x]).Options then
          TBusObjBase(Container[x]).Cancel;
      end;
    end;
  end;
end;


procedure TBusObjBase.SetSilentMode(const Value: boolean);
begin
  self.ResultStatus.SilentMode := Value;
end;

procedure TBusObjBase.showProgress(Progressbarcaption: string;  Progresscount: integer);
begin
  if appenv.appdb.apimode then exit;
  try
   if fProgressInfo <> nil then begin
    fProgressInfo.MinValue:= 1;
    fProgressInfo.MaxValue := Progresscount;
    fProgressInfo.caption := Progressbarcaption;
    fProgressInfo.Execute;
   end else begin
     if self is TDatasetBusObj then begin
      TDatasetBusObj(Self).fsProgressMsg := Progressbarcaption;
      TDatasetBusObj(Self).fiProgresscount :=  Progresscount;
      TDatasetBusObj(Self).SendEvent(BusobjEvent_ToDo, BusobjEvent_ShowProgressbar, TDatasetBusObj(Self));
     end;
   end;
  except
    if self is TDatasetBusObj then TDatasetBusObj(Self).SendEvent(BusobjEvent_ToDo, BusobjEvent_ShowProgressbar, TDatasetBusObj(Self));
  end;
end;

procedure TBusObjBase.stepProgress(const ProgressbarMsg: String);
begin
  if appenv.appdb.apimode then exit;
  try
   if fProgressInfo <> nil then  begin
    fProgressInfo.Message :=ProgressbarMsg;
    fProgressInfo.StepIt;
   end
  else  if self is TDatasetBusObj then begin
    TDatasetBusObj(Self).fsProgressMsg := ProgressbarMsg;
    TDatasetBusObj(Self).SendEvent(BusobjEvent_ToDo, BusobjEvent_ProgressbarProgress, TDatasetBusObj(Self));
  end;
  except
    if self is TDatasetBusObj then TDatasetBusObj(Self).SendEvent(BusobjEvent_ToDo, BusobjEvent_ProgressbarProgress, TDatasetBusObj(Self));
  end;

end;

function TBusObjBase.ValidateData: boolean;
var
  x: integer;
begin
  result:= true;
  if Assigned(Container) then begin
    for x:= 0 to Container.Count -1 do begin
      if Container[x] is TBusObjBase then begin
        if opValidateData in TBusObjBase(Container[x]).Options then begin
          if not TBusObjBase(Container[x]).ValidateData then
            result:= false;
        end;
      end;
    end;
  end;
end;

function TBusObjBase.GetContainer: TBusObjContainer;
begin
//  result:= nil;
//  if GetId > 0 then
    result:= ContainerList.Container(GetId, true);
end;
function TBusObjBase.getContainerComponentifExists(const ComponentClassType: TComponentClass): TComponent;
begin
  result := Container.ItemByClass(ComponentClassType, false);
end;
function TBusObjBase.getContainerComponent(Const ComponentClassType: TComponentClass;
                                    Const aName:String;
                                    Const aNamefieldname :String ;
                                    const aSetSilentMode :Boolean = True;
                                    const aSetconnection :Boolean = True;
                                    const aSetLockgroup :Boolean = True ;
                                    const AlternativeObjWhereClause :String = '';
                                    const fIsReadonly :Boolean = False ) :  TComponent;
begin
    result := Container.ItemByClass(ComponentClassType, false);
    if Assigned(result) then begin
      if (result is TDatasetBusObj) then
      with TDatasetBusObj(REsult) do begin
        if DatasetAssigned and fdataset.active then
        if (aNamefieldname <> '' ) and (fdataset.recordcount =1) and (fdataset.fieldbyname(aNamefieldname).asString= aName) then begin
          if isreadonly <>  fIsReadonly then isreadonly := fIsReadonly;
          Exit;
        end;
      end;
    end;
    result := getContainerComponent(ComponentClassType,aNamefieldname +' = ' +quotedstr(aName) ,aSetSilentMode,aSetconnection,aSetLockgroup,AlternativeObjWhereClause,fIsReadonly);
end;

function TBusObjBase.getContainerComponent(Const ComponentClassType: TComponentClass;
                                    Const aId: integer;
                                    Const aIDfieldname :String ;
                                    const aSetSilentMode :Boolean = True;
                                    const aSetconnection :Boolean = True;
                                    const aSetLockgroup :Boolean = True ;
                                    const AlternativeObjWhereClause :String = '';
                                    const fIsReadonly :Boolean = False ) :  TComponent;
begin
    result := Container.ItemByClass(ComponentClassType, false);
    if Assigned(result) then begin
      if (result is TDatasetBusObj) then
      with TDatasetBusObj(REsult) do begin
        if DatasetAssigned and fdataset.active then
        if (IDFieldName <> '' ) and (fdataset.recordcount =1) and (fdataset.fieldbyname(IDFieldName).asInteger = aid) then begin
          if isreadonly <>  fIsReadonly then isreadonly := fIsReadonly;
          Exit;
        end;
      end;
    end;
    result := getContainerComponent(ComponentClassType,aIDfieldname +' = ' +inttostr(aId),aSetSilentMode,aSetconnection,aSetLockgroup,AlternativeObjWhereClause,fIsReadonly);
end;

function TBusObjBase.getContainerComponent(Const ComponentClassType: TComponentClass;
                                           Const ObjWhereClause :String = '';
                                           Const aSetSilentMode :Boolean = True;
                                           Const aSetconnection :Boolean = True;
                                           Const aSetLockgroup  :Boolean = True;
                                           const AlternativeObjWhereClause :String = '';
                                           const fIsReadonly :Boolean = False) :  TComponent;
begin
  Result := Container.ItemByClass(ComponentClassType, False);

  if not Assigned(Result) then begin
    if (Self is TDatasetBusObj) and (TDatasetBusObj(Self).ID = 0) and (not fIsReadonly) and (TDatasetBusObj(Self).Dataset.State <> dsCalcFields) then
      TDatasetBusObj(Self).PostDB;
    Result := TComponentClass(ComponentClassType).Create(nil);
    Container.Add(Result);
    if Result is TBusobj then Tbusobj(REsult).LogChangesOnSave := False;

    if aSetLockgroup then
      if (Result is TBusObj) and (self is TBusObj) then
        TBusObj(result).LockGroupName:= TBusObj(self).LockGroupName;

    if aSetconnection then begin
      if (result is TDatasetBusObj) and (Self is TDatasetBusObj) then
        if TDatasetBusObj(Self).ConnectionAssigned then
          TDatasetBusObj(result).Connection := TDatasetBusObj(Self).Connection;
    end else begin
      TDatasetBusObj(result).Connection := GetSharedDataConnection;
    end;

    if aSetSilentMode then
      if (result is TDatasetBusObj) and (self is TDatasetBusObj) then
        if TDatasetBusObj(Self).SilentMode then
          TDatasetBusObj(result).SilentMode := True;
  end;

  if Assigned(Result) then
//  if ObjWhereClause <> '' then begin
      if (Result is TDatasetBusObj) and (TDatasetBusObj(Result).DatasetAssigned) then
        if TDatasetBusObj(Result).Dataset.Active then
          if TDatasetBusObj(Result).SQLSelect = ObjWhereClause then Exit
          else if (TDatasetBusObj(Result).SQLSelect = AlternativeObjWhereClause)
             and (AlternativeObjWhereClause<>'') then Exit;
        TDatasetBusObj(Result).LoadSelect(ObjWhereClause, fIsReadonly);
//  end;
end;

procedure TBusObjBase.DoDelayObjectProcedure(Proc: TObjectProcedure;
  DelayMilliSecs: integer; aDescription :String = '');
var
  Rec: TDelayProcedureRec;
begin
  Rec:= TDelayProcedureRec.Create;
  Rec.Proc:= Proc;
  Rec.ExecTime:= now + (DelayMilliSecs * (1/24/60/60/1000));
  Rec.description := aDescription ;
  fDelayProcedureList.Add(Rec);
  if not Assigned(fTimer) then begin
    fTimer:= TTimer.Create(self);
    fTimer.Interval:= 5;
    fTimer.OnTimer:= DoOnTimer;
  end;
  fTimer.Enabled:= true;
end;

procedure TBusObjBase.DoContainerEvent(const Sender: TObject; const EventType: integer; const Data: TObject = nil; Proc : TProcBusObjBase= nil);
begin
  Container.Doevent(Sender ,Eventtype, Data, Proc);
end;

procedure TBusObjBase.DoEvent(const Sender: TObject;  const EventType: integer; const Data: TObject= nil; Proc : TProcBusObjBase= nil);
var
  Cntr: TBusObjContainer;
begin
  case EventType of
    evDSBeforeDelete:
      begin
        if GetId > 0 then begin
          Cntr:= ContainerList.Container(GetId, false);
          if Assigned(Cntr) then
            ContainerList.Delete(GetId);
        end;
      end;
  end;
end;

procedure TBusObjBase.DoOnTimer(Sender: TObject);
var
  x: integer;
begin
  x:= 0;
  fTimer.Enabled:= false;
  try
    while x < fDelayProcedureList.Count do begin
      if TDelayProcedureRec(fDelayProcedureList[x]).ExecTime <= now then begin
        TDelayProcedureRec(fDelayProcedureList[x]).Proc;
        fDelayProcedureList.Delete(x);
      end
      else
        Inc(x);
    end;
  finally
    if fDelayProcedureList.Count > 0 then
      fTimer.Enabled:= true;
  end;
end;

procedure TBusObjBase.DoParserGetVar(const VariableName: string;
  var Value: Variant);
var
  x: integer;
  strArray: TStringDynArray;
  obj: TObject;
  val: Variant;
begin
  strArray := SplitString(VariableName,'.');
  obj := self;
  for x := Low(strArray) to High(strArray) do begin
    case PropType(obj,strArray[x]) of
      tkInteger: Value := GetOrdProp(obj,strArray[x]);
      tkInt64: Value := GetInt64Prop(obj,strArray[x]);
      tkEnumeration:
        begin
          val := GetPropValue(obj, strArray[x]);
          if GetPropInfo(obj,strArray[x]).PropType^.Name = 'Boolean' then begin
            if (not VarIsNull(val)) and (Val = 'True') then
              Value := 'True'
            else
              Value := 'False';
          end
          else
            Value := val;
        end;
      tkFloat:
        begin
          if GetPropInfo(obj,strArray[x]).PropType^.Name = 'TDateTime' then
            Value := FormatDateTime(JsonDateTimeFormat,GetFloatProp(obj,strArray[x]))
          else
            Value := GetFloatProp(obj,strArray[x]);
        end;
      tkChar,
      tkString,
      tkWChar,
      tkLString,
      tkWString,
      tkUString: Value := GetStrProp(obj,strArray[x]);
      tkClass: obj := GetObjectProp(obj,strArray[x]);
      tkUnknown,
      tkPointer,
      tkProcedure,
      tkDynArray,
      tkVariant,
      tkArray,
      tkRecord,
      tkMethod,
      tkSet,
      tkClassRef,
      tkInterface: raise Exception.Create('Error reading property ' + strArray[x]);
    end;
  end;
end;

function TBusObjBase.GetObjectUserName: string;
begin
  result:= SeparateWords(Copy(Self.ClassName,2,255));
end;

procedure TBusObjBase.AddResult(const aOperationOk: Boolean;
  const aSeverity: TResultStatusSeverity; const aCode: Integer;
  const aMessage: string; const ShowMessage: Boolean);
begin
  ResultStatus.AddItem(aOperationOk,aSeverity, aCode,
    ResultStatus.ResultPrefix + aMessage + ResultStatus.ResultSuffix + NL+
    '(' + ObjectUserName + ') ', ShowMessage);
end;

function TBusObjBase.ValidateDataList: boolean;
begin
  result:= true;
end;

class function TBusObjBase._Schema: string;
begin
  result:= '{"type":"' + self.ClassName + '"}';
end;

function TBusObjBase.getIsReadonly: boolean;
begin
  REsult := False;
  if fbIsReadonly then result :=fbIsReadonly
  else begin
    if (assigned(Owner)) and (Owner is  TBusObjBase) then
      result := TBusObjBase(Owner).IsReadonly;
  end;
end;

procedure TBusObjBase.setIsReadonly(const Value: boolean);
begin
  if fbIsReadonly = value then exit;
  fbIsReadonly := Value;
end;
procedure TBusObjBase.OnAfterJsonToBusObjectNew;
begin

end;

{ TDatasetBusObj }
procedure TDatasetBusObj.CaptureDatasetEvents;
var
  PER: PEventRec;
begin
  if fDatasetEventsCaptured then exit;
  if Assigned(fDataset.AfterOpen) then begin
    // Save the existing AfterOpen
    System.New(PER);
    PER^.EventType:= AfterOpen;
    PER^.Name:= fDataset.Name;
    PER^.Data:= TMethod(fDataset.AfterOpen).Data;
    PER^.Code:= TMethod(fDataset.AfterOpen).Code;
    EventList.Add(PER);
  end;
  // assign new AfterOpen event handler
  fDataset.AfterOpen:= Self.DatasetAfterOpen;

  if Assigned(fDataset.AfterClose) then begin
    System.New(PER);
    PER^.EventType:= AfterClose;
    PER^.Name:= fDataset.Name;
    PER^.Data:= TMethod(fDataset.AfterClose).Data;
    PER^.Code:= TMethod(fDataset.AfterClose).Code;
    EventList.Add(PER);
  end;
  fDataset.AfterClose:= Self.DatasetAfterClose;

  if Assigned(fDataset.BeforeClose) then begin
    System.New(PER);
    PER^.EventType:= BeforeClose;
    PER^.Name:= fDataset.Name;
    PER^.Data:= TMethod(fDataset.BeforeClose).Data;
    PER^.Code:= TMethod(fDataset.BeforeClose).Code;
    EventList.Add(PER);
  end;
  fDataset.BeforeClose:= Self.DatasetBeforeClose;

  if Assigned(fDataset.BeforeDelete) then begin
    System.New(PER);
    PER^.EventType:= BeforeDelete;
    PER^.Name:= fDataset.Name;
    PER^.Data:= TMethod(fDataset.BeforeDelete).Data;
    PER^.Code:= TMethod(fDataset.BeforeDelete).Code;
    EventList.Add(PER);
  end;
  fDataset.BeforeDelete:= Self.DatasetBeforeDelete;

  if Assigned(fDataset.BeforeEdit) then begin
    System.New(PER);
    PER^.EventType:= BeforeEdit;
    PER^.Name:= fDataset.Name;
    PER^.Data:= TMethod(fDataset.BeforeEdit).Data;
    PER^.Code:= TMethod(fDataset.BeforeEdit).Code;
    EventList.Add(PER);
  end;
  fDataset.BeforeEdit:= Self.DatasetBeforeEdit;

  if Assigned(fDataset.Beforepost) then begin
    System.New(PER);
    PER^.EventType:= Beforepost;
    PER^.Name:= fDataset.Name;
    PER^.Data:= TMethod(fDataset.Beforepost).Data;
    PER^.Code:= TMethod(fDataset.Beforepost).Code;
    EventList.Add(PER);
  end;
  fDataset.Beforepost:= Self.DatasetBeforepost;

  if Assigned(fDataset.Afterpost) then begin
    System.New(PER);
    PER^.EventType:= Afterpost;
    PER^.Name:= fDataset.Name;
    PER^.Data:= TMethod(fDataset.Afterpost).Data;
    PER^.Code:= TMethod(fDataset.Afterpost).Code;
    EventList.Add(PER);
  end;
  fDataset.AfterPost:= Self.DatasetAfterpost;

  if Assigned(fDataset.OnNewrecord) then begin
    System.New(PER);
    PER^.EventType:= Newrecord;
    PER^.Name:= fDataset.Name;
    PER^.Data:= TMethod(fDataset.OnNewrecord).Data;
    PER^.Code:= TMethod(fDataset.OnNewrecord).Code;
    EventList.Add(PER);
  end;
  fDataset.OnNewrecord:= Self.DatasetNewrecord;



  if Assigned(fDataset.BeforeOpen) then begin
    System.New(PER);
    PER^.EventType:= BeforeOpen;
    PER^.Name:= fDataset.Name;
    PER^.Data:= TMethod(fDataset.BeforeOpen).Data;
    PER^.Code:= TMethod(fDataset.BeforeOpen).Code;
    EventList.Add(PER);
  end;
  fDataset.BeforeOpen:= Self.DatasetBeforeOpen;

  if Assigned(fDataset.BeforeInsert) then begin
    System.New(PER);
    PER^.EventType:= BeforeInsert;
    PER^.Name:= fDataset.Name;
    PER^.Data:= TMethod(fDataset.BeforeInsert).Data;
    PER^.Code:= TMethod(fDataset.BeforeInsert).Code;
    EventList.Add(PER);
  end;
  fDataset.BeforeInsert:= Self.DatasetBeforeInsert;

  if Assigned(fDataset.AfterInsert) then begin
    System.New(PER);
    PER^.EventType:= AfterInsert;
    PER^.Name:= fDataset.Name;
    PER^.Data:= TMethod(fDataset.AfterInsert).Data;
    PER^.Code:= TMethod(fDataset.AfterInsert).Code;
    EventList.Add(PER);
  end;
  fDataset.AfterInsert  := Self.DatasetAfterInsert;

  if Assigned(fDataset.onCalcFields) then begin
    System.New(PER);
    PER^.EventType:= CalcFields;
    PER^.Name:= fDataset.Name;
    PER^.Data:= TMethod(fDataset.onCalcFields).Data;
    PER^.Code:= TMethod(fDataset.onCalcFields).Code;
    EventList.Add(PER);
  end;
  fDataset.onCalcFields := Self.DatasetCalcFields;

  fDataset.BeforeScroll := Self.DatasetBeforeScroll;
  fDataset.AfterScroll  := Self.DatasetAfterScroll;
  fDataset.AfterDelete  := Self.DatasetAfterDelete;

  fDatasetEventsCaptured:= true;

end;

procedure TDatasetBusObj.CaptureFieldEvents;
var
  x: integer;
  PER: PEventRec;
begin
  if fDatasetFldEventsCaptured then exit;
  for x:= 0 to fDataset.FieldCount -1 do begin
    if Assigned(fDataset.Fields[x].OnChange) then begin
      // Save old handler in list
      System.New(PER);
      PER^.EventType:= OnChange;
      PER^.Name:= fDataset.Fields[x].FieldName;
      PER^.Data:= TMethod(fDataset.Fields[x].OnChange).Data;
      PER^.Code:= TMethod(fDataset.Fields[x].OnChange).Code;
      EventList.Add(PER);
    end;
    // asign new event handler
    fDataset.Fields[x].OnChange:= FieldOnChange;
  end;
  fDatasetFldEventsCaptured:= true;
end;
constructor TDatasetBusObj.Create(AOwner: TComponent; aObjSQL:string);
begin
  Create (AOwner);;
  if aObjSQL <> '' then begin
    fSQL := aObjSQL;
  end;
end;
constructor TDatasetBusObj.Create(AOwner: TComponent);
begin
  inherited;
  fbDoInitFloatFieldDisplayFormat := False;
  fProgressDialogobj := nil;
  fdopentime := 0;
  EnablePropertySetWhenREadonly := False;
  fbCalcFields := False;
  fPropnames :=nil;
  fSQL                      := '';
  fLimitCount               := -1;
  fLimitFrom                := -1;
  fbRunningEventListEvents  := False;
  fbIgnoreAccesslevel       := False;
  fDataset                  := nil;
  fBusObjectTypeDescription := self.ClassName;
  fExternalDatasetAssigned  := false;
  EventList                 := TList.Create;
  fDoSavedFieldEvents       := true;
  DoFieldChange             := true;
  fRoundPlacesGeneral       := tcConst.GeneralRoundPlaces;
  //fCurrencyRoundPlaces        := tcConst.CurrencyRoundPlaces;
  fCurrencyRoundPlaces        := 0;
  fConnection               := nil;
  fDatasetEventsCaptured    := false;
  fDatasetFldEventsCaptured := false;
  fEventList                := TBusObjEventList.Create(TBusObjEventListItem);
  NullWhenDateIs0           := True;
  fsCustomFieldIdentifier   := '';
  DatasetScrolling:= false;
  DatasetPosting:= false;
  fIsList:= false;
  fIsChild:= false;
  Reset;
end;

procedure TDatasetBusObj.Reset;
begin
  fSQLSelect                := '';
  fSQLORder                 :='';
  fSQLGroup                 := '';
  fIsNew                    := false;
  fsOldSQL                  := '';
  fbExcludeInactive         := False;
end;

procedure TDatasetBusObj.DatasetBeforeDelete(Dataset: TDataset);
var
  EventRec: TEventRec;
  DatasetNotifyEvent: TDatasetNotifyEvent;
begin
//  Log(self.ClassName + '.BeforeDelete');
  if (not (IgnoreAccesslevel)) and (ID = CleanID) then
      if not AccessManager.DoBeforeDelete(dataset) then begin
        self.ResultStatus.AddItem(false, rssError, 0, NoRigtsMsg('delete'));
        Abort;
      end;
  if (not CanDelete) then
  begin
    self.ResultStatus.AddItem(false, rssError, 0, NoRigtsMsg('delete'));
    Abort;
  end;

  Self.DoBeforeDelete(Self);
  // find and call any saved event handlers
  Try
    if  Self.GetEventRec(EventRec, Dataset.Name, BeforeDelete) then
    begin
      TMethod(DatasetNotifyEvent).Data:= EventRec.Data;
      TMethod(DatasetNotifyEvent).Code:= EventRec.Code;
      DatasetNotifyEvent(Dataset);
    end;
  Except
    on E:Exception do begin
	  end;
  End;
end;


procedure TDatasetBusObj.DatasetBeforeEdit(Dataset: TDataset);
var
  EventRec: TEventRec;
  DatasetNotifyEvent: TDatasetNotifyEvent;
begin
//  Log(self.ClassName + '.BeforeEdit');
   if not IgnoreAccesslevel then
      if not AccessManager.DoBeforeEdit(Dataset) then begin
        self.ResultStatus.AddItem(false, rssError, 0,NoRigtsMsg('Edit'));
        Abort;
        Exit;
      end;

  Self.DoBeforeEdit(Self);
  // find and call any saved event handlers
  try
  if Self.GetEventRec(EventRec, Dataset.Name, BeforeEdit) then
  begin
    TMethod(DatasetNotifyEvent).Data:= EventRec.Data;
    TMethod(DatasetNotifyEvent).Code:= EventRec.Code;
    DatasetNotifyEvent(Dataset);
  end;
  Except
    on E:Exception do begin
	  end;
  End;
end;

procedure TDatasetBusObj.DatasetBeforePost(Dataset: TDataset);
var
  EventRec: TEventRec;
  DatasetNotifyEvent: TDatasetNotifyEvent;
begin
//  Log(self.ClassName + '.BeforePost');
  if not IgnoreAccesslevel then
      if not AccessManager.DoBeforePost(Dataset) then begin
        self.ResultStatus.AddItem(false, rssError, 0, NoRigtsMsg('Post'));
        Abort;
      end;


  if IsNew then
  begin
    if (not CanCreate) then
    begin
      self.ResultStatus.AddItem(false, rssError, 0, NoRigtsMsg('Update New'));
      Abort;
      exit;
    end
  end
  else
  begin
    if (not CanUpdate) then
    begin
      self.ResultStatus.AddItem(false, rssError, 0, NoRigtsMsg('Update'));
      Abort;
      exit;
    end
  end;

  Self.DoBeforePost(Self);
  // find and call any saved event handlers
  try
  if Self.GetEventRec(EventRec, Dataset.Name, BeforePost) then
  begin
    TMethod(DatasetNotifyEvent).Data:= EventRec.Data;
    TMethod(DatasetNotifyEvent).Code:= EventRec.Code;
    DatasetNotifyEvent(Dataset);
  end;
  Except
    on E:Exception do begin
	  end;
  End;
  if fbnewRec then begin
    fbnewRec :=False;
    SendEvent(BusobjEvent_Event , BusObjEventDataset_BeforePostNew , self);
  end;
  SendEvent(BusobjEvent_Event , BusObjEventDataset_BeforePost , self);

end;



procedure TDatasetBusObj.DatasetAfterPost(Dataset: TDataset);
var
  EventRec: TEventRec;
  DatasetNotifyEvent: TDatasetNotifyEvent;
begin
//  Log(self.ClassName + '.AfterPost');
  // implement Access rights
  ContainerList.DoSetId(self.Id);
  Self.DoAfterPost(Self);

  // find and call any saved event handlers
  try
  if Self.GetEventRec(EventRec, Dataset.Name, AfterPost) then
  begin
    TMethod(DatasetNotifyEvent).Data:= EventRec.Data;
    TMethod(DatasetNotifyEvent).Code:= EventRec.Code;
    DatasetNotifyEvent(Dataset);
  end;
  Except
    on E:Exception do begin
	  end;

  End;
  if fbnewRec then begin
    fbnewRec :=False;
    SendEvent(BusobjEvent_Event , BusObjEventDataset_AfterPostNew , self);
  end;
  SendEvent(BusobjEvent_Event , BusObjEventDataset_AfterPost , self);
end;

procedure TDatasetBusObj.DatasetNewRecord(Dataset: TDataset);
var
  EventRec: TEventRec;
  DatasetNotifyEvent: TDatasetNotifyEvent;
begin
//  Log(self.ClassName + '.NewRecord');
  Self.DoNewRecord(Self);
  // find and call any saved event handlers
  try
  if Self.GetEventRec(EventRec, Dataset.Name, NewRecord) then
  begin
    TMethod(DatasetNotifyEvent).Data:= EventRec.Data;
    TMethod(DatasetNotifyEvent).Code:= EventRec.Code;
    DatasetNotifyEvent(Dataset);
  end;
  Except
    on E:Exception do begin
	  end;

  End;
end;


procedure TDatasetBusObj.DatasetBeforeOpen(Dataset: TDataset);
var
  EventRec: TEventRec;
  DatasetNotifyEvent: TDatasetNotifyEvent;
begin
  fdopentime := now;
  if not IgnoreAccesslevel then
      if not AccessManager.DoBeforeOpen(Dataset) then begin
        self.ResultStatus.AddItem(false, rssError, 0, NoRigtsMsg('Open'));
        Abort;
      end;
  { Turn this off for now, see notes in DatasetAfterOpen }
//  if not self.IsReadonly then
//    TCustomMyDataset(Dataset).Options.DefaultValues := True;// Sets the defaultExpression in the fields
  Self.DoBeforeOpen(Dataset);
  Self.DoBeforeOpen(Self);
  InitFloatFieldDisplayFormat;
  // find and call any saved event handlers
  try
  if Self.GetEventRec(EventRec, Dataset.Name, BeforeOpen) then
  begin
    TMethod(DatasetNotifyEvent).Data:= EventRec.Data;
    TMethod(DatasetNotifyEvent).Code:= EventRec.Code;
    DatasetNotifyEvent(Dataset);
  end;
  Except
    on E:Exception do begin
	  end;

  End;
  SendEvent(BusobjEvent_Event , BusObjEventDataset_BeforeOpen , self);
end;



procedure TDatasetBusObj.DatasetBeforeInsert(Dataset: TDataset);
var
  EventRec: TEventRec;
  DatasetNotifyEvent: TDatasetNotifyEvent;
begin
//  Log(self.ClassName + '.BeforeInsert');
  if not IgnoreAccesslevel then
      if not AccessManager.DoBeforeInsert(Dataset) then begin
        self.ResultStatus.AddItem(false, rssError, 0, NoRigtsMsg('Insert'));
        Abort;
      end;
  DoFieldChange:= False; // sets for the default values
  Self.DoBeforeInsert(Self);
  // find and call any saved event handlers
  Try
    if Self.GetEventRec(EventRec, Dataset.Name, BeforeInsert) then
    begin
      TMethod(DatasetNotifyEvent).Data:= EventRec.Data;
      TMethod(DatasetNotifyEvent).Code:= EventRec.Code;
      DatasetNotifyEvent(Dataset);
    end;
  Except
    on E:Exception do begin
      abort;
	  end;
  End;
end;


function TDatasetBusObj.DataasetStateStr: String;
begin
  Result := '';
  if not datasetassigned then exit;
  if fdataset.active = false then Result := 'Inactive'
  else if fdataset.state = dsEdit then Result :='Edit'
  else if fdataset.state = dsInsert then Result :='Insert'
  else if fdataset.state = dsbrowse then Result :='browse'
  else result := 'unknown';
end;

procedure TDatasetBusObj.DatasetAfterClose(Dataset: TDataset);
var
  EventRec: TEventRec;
  DatasetNotifyEvent: TDatasetNotifyEvent;
begin
  //Logbusobj(name, classname, inttostr(integer(self)) ,SQL,  'D');
//  Log(self.ClassName + '.AfterClose');
  DoFieldChange:= false;
  // return field event hanlers
  Self.DoAfterClose(Self);
  Self.ReleaseFieldEvents;
  // find and call any saved event handlers
  try
    if Self.GetEventRec(EventRec, Dataset.Name, AfterClose) then
    begin
      TMethod(DatasetNotifyEvent).Data:= EventRec.Data;
      TMethod(DatasetNotifyEvent).Code:= EventRec.Code;
      DatasetNotifyEvent(Dataset);
    end;
  Except
    on E:Exception do begin
	  end;
  End;
  SendEvent(BusobjEvent_Event , BusObjEventDataset_AfterClose , self);
end;
procedure TDatasetBusObj.DatasetBeforeClose(Dataset: TDataset);
var
  EventRec: TEventRec;
  DatasetNotifyEvent: TDatasetNotifyEvent;
begin
  //Logbusobj(name, classname, inttostr(integer(self)) ,SQL,  'D');
//  Log(self.ClassName + '.BeforeClose');
  DoFieldChange:= false;
  // return field event hanlers
  Self.DoBeforeClose(Self);
  Self.ReleaseFieldEvents;
  // find and call any saved event handlers
  try
    if Self.GetEventRec(EventRec, Dataset.Name, BeforeClose) then
    begin
      TMethod(DatasetNotifyEvent).Data:= EventRec.Data;
      TMethod(DatasetNotifyEvent).Code:= EventRec.Code;
      DatasetNotifyEvent(Dataset);
    end;
  Except
    on E:Exception do begin
	  end;
  End;
  SendEvent(BusobjEvent_Event , BusObjEventDataset_BeforeClose , self);
end;
procedure TDatasetBusObj.InitFloatFieldDisplayFormat;
var
  iIndex:Integer;
  tmpField: TField;
begin
  if not DoInitFloatFieldDisplayFormat then exit;
  if not(datasetassigned) then exit;

  for iIndex := 0 to fdataset.FieldCount - 1 do begin
    tmpField := fdataset.fields[iIndex];
    if tmpField = nil then continue;
    if tmpfield is TFloatfield then
      if TFloatfield(tmpfield).Displayformat = '' then
        if TFloatfield(tmpfield).currency then
             TFloatfield(tmpfield).Displayformat := AppEnv.RegionalOptions.CurrencySymbol + DOUBLE_FIELD_MASK
        else TFloatfield(tmpfield).Displayformat := DOUBLE_FIELD_MASK;
  end;
end;
procedure TDatasetBusObj.DatasetAfterOpen(Dataset: TDataset);
var
  EventRec: TEventRec;
  DatasetNotifyEvent: TDatasetNotifyEvent;
  qry: TMyQuery;
  fld: TField;

  function IsStringField: boolean;
  begin
    result:= (Pos('enum',qry.FieldByName('Type').AsString) = 1) or
      (Pos('varchar',qry.FieldByName('Type').AsString) = 1);
  end;

begin
  LogSQL;
  { The following is a tempory solution to get db default field,
    setting MyQuery.Options.DefaultValues = true makes opening
    of query much to slow. }
  if (not IsReadonly) and (BusObjectTableName <> '') then  begin
    qry:= TMyQuery.Create(nil);
    try
      qry.Connection:= self.Connection.Connection;
      if BusObjectTableName <> '' then begin{Temporary GUI objects' tables are dynamically created and class function doesn't know about it}
        qry.SQL.Text:= 'show columns from ' + BusObjectTableName + ' where `Default` <> "(NULL)"';
        qry.Open;
        while not qry.Eof do begin
          fld:= self.fDataset.FindField(qry.FieldByName('Field').AsString);
          if Assigned(fld) then begin
            if IsStringField then
              fld.DefaultExpression:= QuotedStr(qry.FieldByName('Default').AsString)
            else
              fld.DefaultExpression:= qry.FieldByName('Default').AsString;
          end;
          qry.Next;
        end;
      end;
    finally
      qry.Free;
    end;
  end;

  Self.CaptureFieldEvents;
  DoFieldChange:= true;
  Self.DoAfterOpen(self);
  if Self is TBusobj then
    if TBusobj(Self).FieldsnotToclone = '' then
        TBusobj(Self).FieldsnotToclone := TBusobj(Self).ExcludeFromclone;
  // find and call any saved event handlers
  Try
    if Self.GetEventRec(EventRec, Dataset.Name, AfterOpen) then
    begin
      TMethod(DatasetNotifyEvent).Data:= EventRec.Data;
      TMethod(DatasetNotifyEvent).Code:= EventRec.Code;
      DatasetNotifyEvent(Dataset);
    end;
  Except
    on E:Exception do begin
	  end;

  End;
  SendEvent(BusobjEvent_Event , BusObjEventDataset_AfterOpen , self);

end;

destructor TDatasetBusObj.Destroy;
begin
  if Assigned(fDataset) then begin
    ReleaseDatasetEvents;
    ReleaseFieldEvents;
  end;
  if fPropnames <> nil then freeandnil(fPropnames);
  if EventList <> nil then
      while EventList.Count > 0 do begin
          Dispose(EventList.Items[0]);
          EventList.Delete(0);
      end;

  FreeAndNil(EventList);

  FreeAndNil(fEventList);

  if Assigned(fDataset) and (not fExternalDatasetAssigned) then begin
    Try   // Ianos Last Resort Fix
      //Logbusobj(fDataset.Name , Self.ClassName , inttostr(Integer(self)) +'-'+  inttostr(Integer(fDataset))  , fDataset.SQL.text , 'D');
      FreeAndNil(fDataset);
    except
    end;
  end;
  FreeAndNil(fLoadParamList);

  if Assigned(fConnection) and (fConnection.Owner = Self) then
    FreeAndNil(fConnection);
  inherited;
end;

Function TDatasetBusObj.DoBeforeDelete(Sender :TDatasetBusObj ):Boolean;
begin
  result:= true;
  if Assigned(Container) then begin
    Container.DoEvent(Self, evDSBeforeDelete);
    ContainerList.Delete(Id);
  end;
    // override in decendants
end;
procedure TDatasetBusObj.DoFieldOnChange(Sender: TField);
begin
//  TLogger.Inst.Log('TDatasetBusObj.DoFieldOnChange - ' + Sender.FieldName);
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled = False then Exit;

  try
    if (KeyStringFieldName <> '' ) and (Sysutils.SameText(Sender.FieldName , KeyStringFieldName)) then
      if Sender.AsString <> Trim(Sender.AsString) then
        Sender.AsString := Trim(Sender.AsString);
  Except
    // kill exception
  end;

   if Sysutils.SameText(Sender.FieldName , 'Deleted') then
    if Dataset.Fieldbyname('Deleted').asBoolean then
        if (not (IgnoreAccesslevel)) and (ID = CleanID) and (ID <> 0) then
            if AccessManager.accesslevel <> 1 then begin
                    self.ResultStatus.AddItem(false, rssError, 0, NoRigtsMsg('Delete'));
                EditDB;
                Dataset.Fieldbyname('Deleted').asBoolean := False;
            end;

end;
function TDatasetBusObj.GetId: integer;
begin
    Result := 0;
    if Assigned(fDataset) then
        if IDFIeldName <> '' then
            if Dataset.Findfield(IDFieldName) <> nil then begin
                Result := getIntegerField(IDFieldName);
            end;
end;

function TDatasetBusObj.getIgnoreAccesslevel: Boolean;
begin
  Result := fbIgnoreAccesslevel;
  if result then exit;
  if Assigned(Owner) then
    if owner is TDatasetBusObj then
      result := TDatasetBusObj(Owner).IgnoreAccesslevel;
end;

function TDatasetBusObj.GetKeyString: string;
begin
  Result := '';
  if Assigned(fDataset) and (KeyStringFieldName <> '') and (Dataset.Findfield(IDFieldName) <> nil) then
    Result := GetStringField(KeyStringFieldName);
end;

Function TDatasetBusObj.DoBeforePost(Sender :TDatasetBusObj ):Boolean;
begin
//  TLogger.Inst.Log('TDatasetBusObj.DoBeforePost  ' + Sender.ClassName);
    Result := True;
    // override in decendants
end;

Function TDatasetBusObj.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
    Result := True;
    //Override in decendants
end;
Function TDatasetBusObj.DoNewRecord(Sender :TDatasetBusObj ):Boolean;
begin
    Result := True;
    //Override in decendants
end;

Function TDatasetBusObj.DoBeforeEdit(Sender :TDatasetBusObj ):Boolean;
begin
    Result := True;
    //Override in decendants
end;
Function  TDatasetBusObj.DoAfterDelete(Sender :TDatasetBusObj ):Boolean;
begin
    Result := True;
end;
Function  TDatasetBusObj.DoAfterOpen(Sender :TDatasetBusObj ):Boolean;
begin
  Result := True;
  if Assigned(Container) then
    Container.DoEvent(self, evDSAfterOpen);
end;
Function TDatasetBusObj.DoBeforeOpen(Sender :TDatasetBusObj ):Boolean;
begin
    Result := True;
    //Override in decendants
end;
Function  TDatasetBusObj.DoBeforeOpen(Sender :TDataset):Boolean;
begin
    Result := True;
    //Override in decendants
end;
Function TDatasetBusObj.DoBeforeInsert(Sender :TDatasetBusObj ):Boolean;
begin
  Result := True;
    //Override in decendants
end;

//Function TDatasetBusObj.ValidateCustomFields :Boolean;
//var
//  CustFldObj: TCustFieldConfigList;
//  FldTyp:  TCustFieldType;
//  fld: TField;
//  x: integer;
//
//begin
//    {custom field validation
//    Descendants where the custom fields are applicable should intialise CustomFieldIdentifier in the Constructor
//    Employees doesn't have the date fields - so only 1 to 15 applicable and hire has 20 fields (5 date fields)}
//
//  result:= true;
//  x:= 1;
//  fld:= Dataset.FindField('CUSTFLD' + IntToStr(x));
//  if Assigned(fld) then begin
//    FldTyp:= cftUnknown;
//    if self.ClassNameIs('TEmployee') then FldTyp:= cftEmployee
//    else if self.ClassNameIs('TCustomer') then FldTyp:= cftCustomer
//    else if self.ClassNameIs('TSupplier') then FldTyp:= cftSupplier
//    else if self.ClassNameIs('TOtherContact') then FldTyp:= cftProspect
////    else if self.ClassNameIs('TAsset') then FldTyp:= cftAsset
//    else if self.ClassNameIs('TAppointment') then FldTyp:= cftAppointment
//    else if self.ClassNameIs('TProduct') then FldTyp:= cftProduct;
//
//    CustFldObj:= TCustFieldConfigList.Create(FldTyp);
//    try
//      while Assigned(fld) do begin
//        if CustFldObj[x].Required and (fld.AsString = '') then begin
//          result:= false;
//          Resultstatus.AddItem(False , rssError , 0 , 'Custom field: "' +
//             CustFldObj.FieldCaption(x) + '" (' + fld.FieldName + ') should not be blank' );
//          break;
//        end;
//        inc(x);
//        fld:= Dataset.FindField('CUSTFLD' + IntToStr(x));
//      end;
//
//    finally
//      CustFldObj.Free;
//    end;
//  end;
//end;

function TDatasetBusObj.ValidateData: boolean;
begin
  result:= inherited ValidateData;
  if result then
  result:= CustomPropConfigObj.ValidateCustomFields(self);
  if result = False then exit;
  Result := ValidateObjectProperties;
end;
function TdatasetBusobj.ValidateObjectProperties:Boolean;
begin
  REsult:= True;
    if self is TObjectProperties then else begin
    with TObjectProperties(ObjectProperties) do begin
      if count> 0 then begin
        first;
        While eof = False do begin
          if Required then begin
            if (PropType(Self ,PropertyName) in [tkUString , tkString,tkLString , tkWString]) and
              (GetstrProp(Self, PropertyName) = '') then begin
              self.ResultStatus.AddItem(false, rssError, 0, PropertyUserName + ' should not be blank.');
              Result:= False;
              exit;
            end else if (PropType(Self ,PropertyName) in [tkInteger, tkInt64]) and
              (GetInt64Prop(Self, PropertyName) = 0) then begin
              self.ResultStatus.AddItem(false, rssError, 0, PropertyUserName + ' should not be blank.');
              Result:= False;
              exit;
            end else if (PropType(Self ,PropertyName) in [tkFloat]) and
              (GetFloatProp(Self, PropertyName) = 0) then begin
              self.ResultStatus.AddItem(false, rssError, 0, PropertyUserName + ' should not be blank.');
              Result:= False;
              exit;
            end;
          end;
          Next;
        end;
      end;
    end;
  end;

end;

function TDatasetBusObj.ValidateDataList: boolean;
var
  bm: TBookmark;
begin
  result:= true;
  if not Assigned(fDataset) or not fDataset.Active then Exit;
  bm:= fDataset.GetBookmark;
  try
    fDataset.First;
    while not fDataset.Eof do begin
      if not ValidateData then begin
        result:= false;
        break;
      end;
      fDataset.Next;
    end;
    fDataset.GotoBookmark(bm);
  finally
    fDataset.FreeBookmark(bm);
  end;
end;

Function TDatasetbusObj.DoCalcFields(sender :TDatasetBusObj):Boolean;
begin
    Result := true;
end;
Function TDatasetBusObj.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
  result:= true;
end;


procedure TDatasetBusObj.FieldOnChange(Sender: TField);
(*var
  t:TDatetime;*)
begin
  // Called by OnChange Event from all fields.

  { Only process events when tha data has actually changed.}
  if (Sender.FieldKind = fkData) then
  begin
    if IsNew then
    begin
      if (not CanCreate) then
      begin
        self.ResultStatus.AddItem(false, rssError, 0, NoRigtsMsg('Update New'));
        Abort;
        exit;
      end
    end
    else
    begin
      if (not CanUpdate) then
      begin
        self.ResultStatus.AddItem(false, rssError, 0, NoRigtsMsg('Update'));
        Abort;
        exit;
      end
    end;
  end;

  Dirty:= true;
  Logdofieldchange(Sender);
  if not DoFieldChange then Exit;
  DoFieldChange:= false;
  try
    DoCurrentFieldSavedEvent:= true;

    if IsFieldChangetoIgnoreInRawMode(Sender.FieldName) then exit;
    // Child objects should override DoFieldOnChange, perform their on OnChange
    // handling.                                                    `
        Self.DoFieldOnChange(Sender);
//    Log(self.ClassName + '.DoFieldOnChange - END Field: ' + Sender.FieldName);

    { send any events added during OnChange processing }
    SendAllEvents;

    if DoSavedFieldEvents and DoCurrentFieldSavedEvent then begin
      // find and call any saved event handler

      self.CallSavedFieldEvent(Sender, OnChange);
    end;
  finally
    DoFieldChange:= true;
  end;
end;

function TDatasetBusObj.GetDefaultConnection: TMyDacDataConnection;
begin
  if Assigned(Owner) and (Owner is TDatasetBusObj) then begin
    if Assigned(TDatasetBusObj(Owner).Connection) then begin
      result:= TDatasetBusObj(Owner).Connection;
    end
    else begin
      result:= GetSharedDataConnection;
      //Result := nil;
    end;
  end
  else begin
    result:= GetSharedDataConnection;
  end;
end;
Procedure TDatasetBusObj.ExecuteSQL(Const QrySQL :TStringList; Const InTransaction :Boolean = False ) ;
begin
  ExecuteSQL( QrySQL.text ,  InTransaction);
end;
procedure TDatasetBusObj.ScriptBeforeExecuteProgress(Sender: TObject;  var SQL: string; var Omit: Boolean);
begin
  StepProgress;
end;
procedure TDatasetBusObj.ExecuteWithProgressbar(const Script: TERPScript; aProgCaption:String = '');
var
  be:TBeforeStatementExecuteEvent;
begin
  be := Script.BeforeExecute;
  try
    Script.BeforeExecute := ScriptBeforeExecuteProgress;
    if aProgCaption ='' then aProgCaption :=WAITMSG;
    showProgress(aProgCaption, Script.SQL.count);
    try
      fsProgressMsg :='';
      Script.Execute;
    finally
      HideProgress;
    end;
  finally
    Script.BeforeExecute := be;
  end;
end;

procedure TDatasetBusObj.ExecuteSQL(const QrySql: String;  const InTransaction: Boolean);
var
    qryScript :TERPScript;
begin
    logtext(Qrysql);
    if Intransaction then
      if not Assigned(Self.Connection) then Self.Connection:= GetDefaultConnection;

    if Intransaction then qryScript := DbSharedObj.GetScript(Self.Connection.connection)
    else qryScript := DbSharedObj.GetScript(GetSharedMyDacConnection);
    //qryScript := TERPScript.Create(Self);
    Try
        (*if not Intransaction then
          qryScript.connection := GetSharedMyDacConnection
        else
          qryScript.connection :=Self.Connection.connection ;*)
        qryScript.SQL.text := QrySQL;
        qryScript.Execute;
    finally
        DbSharedObj.ReleaseObj(qryScript);
    end;
end;


function TDatasetBusObj.GetNewDataSet(Const QrySql :TStringList; Const InTransaction :Boolean = False ) :TCustomMyDataset;
begin
    REsult := GetNewDataSet(QrySql.Text ,InTransaction);
end;
Class function TDatasetBusObj.GetNewDataSet(Const strSql :String; Conn: TCustomMyConnection  ) :TCustomMyDataset;
var
  qryExecute :TERPCommand;
begin
    REsult := nil;
   if uppercase(copy(Trim(strSql),1,6)) = 'SELECT' then begin
      Result := TERPQuery.Create(nil);  // Leave As Nil
      Result.Options.FlatBuffers := True;
      Result.connection := conn;
      Result.SQL.add(strSql);
      Result.Open;
  end else begin
    qryExecute := TERPCommand.Create(nil);
    Try
        qryExecute.connection := conn;
        qryExecute.SQL.text := strSql;
        qryExecute.Execute;
    finally
        FreeAndNil(qryExecute);
    end;
  end;
end;
Function TDatasetBusObj.getSharedScript(Const strSql :String; Const InTransaction :Boolean = False ) :TERPScript;
begin
  if InTransaction then REsult := DbSharedObj.GetScript(Self.connection.connection )
  else REsult := DbSharedObj.GetScript(CommonDbLib.GetSharedMyDacConnection);
  REsult.SQL.text := strSQL;
end;
function TDatasetBusObj.GetSharedDataSet(Const strSql :String; Const InTransaction :Boolean = False ) :TERPQuery;
begin
  if InTransaction then REsult := DbSharedObj.GetQuery(Self.connection.connection )
  else REsult := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  closeDb(REsult);
  if strSQL <> '' then begin
    REsult.SQL.text := strSQL;
    OpenDB(REsult);
  end;
end;

Function TDatasetBusObj.GetNewDataSet(Const strSql :String; Const InTransaction :Boolean = False ) :TCustomMyDataset;
var
  Conn :TCustomMyConnection;
begin
    if Intransaction then begin
        if not Assigned(Self.Connection) then Self.Connection:= GetDefaultConnection;
        Conn :=TERPConnection(Self.connection.Connection);
    end else Conn := GetSharedMyDacConnection;
    REsult := GetNewDataSet(strSQl , Conn);
end;

function TDatasetBusObj.GetDataset: TCustomMyDataset;
begin
  if not Assigned(fDataset) then
    SendEvent( BusObjEvent_Dataset,BusObjEvent_AssignDataset, self);

  // Default behaviour is to use an objects parents connection.
  if not Assigned(fDataset) then begin

    if not Assigned(Self.Connection) then begin
      Self.Connection:= GetDefaultConnection;
    end;
    fExternalDatasetAssigned := false;
    fDataset :=TCustomMyDataset(Connection.GetDataset(Self));
    if fDataset <> nil then begin
      FreeNotification(fDataSet);
       AfterDatasetCreated;

      if Assigned(fDataset) then begin
        Connection.DatasetLoad(Self);
      end;
    end;
  end;
  if Assigned(fDataset) then
    if fDataset.Active then
        if not fDatasetFldEventsCaptured then
            CaptureFieldEvents;
  result:= fDataset;
end;

function TDatasetBusObj.GetEventRec(var EventRec: TEventRec; Const Name: string; EventType: TEventType; const RemoveFromList: boolean = false): Boolean;
var
  x: integer;
begin
  result:= False;
  try
  if not Assigned(EventList) then exit;

  for x:= 0 to EventList.Count -1 do begin
    if (PEventRec(EventList.Items[x])^.EventType = EventType) and (PEventRec(EventList.Items[x])^.Name = Name) then begin
      result:= true;
      EventRec:= PEventRec(EventList.Items[x])^;
      if RemoveFromList then begin
        Dispose(EventList.Items[x]);
        EventList.Delete(x);
      end;
      Break;
    end;
  end;
  except
      on E:Exception do begin
          //resultStatus.addItem(False, rssWarning, 0,E.message + chr(13) + Self.Classname );
      end;
  end;
end;


procedure TDatasetBusObj.ReleaseDatasetEvents;
var
  EventRec: TEventRec;
  DatasetNotifyEvent: TDatasetNotifyEvent;
begin
  if not fDatasetEventsCaptured then exit;
  if Self.GetEventRec(EventRec, fDataset.Name, AfterOpen, true) then
  begin
      TMethod(DatasetNotifyEvent).Data:= EventRec.Data;
      TMethod(DatasetNotifyEvent).Code:= EventRec.Code;
      fDataset.AfterOpen:= DatasetNotifyEvent;
  end
  else
    fDataset.AfterOpen:= nil;

  if Self.GetEventRec(EventRec, fDataset.Name, AfterClose, true) then
  begin
      TMethod(DatasetNotifyEvent).Data:= EventRec.Data;
      TMethod(DatasetNotifyEvent).Code:= EventRec.Code;
      fDataset.AfterClose:= DatasetNotifyEvent;
  end
  else
    fDataset.AfterClose:= nil;

  if Self.GetEventRec(EventRec, fDataset.Name, BeforeClose, true) then
  begin
      TMethod(DatasetNotifyEvent).Data:= EventRec.Data;
      TMethod(DatasetNotifyEvent).Code:= EventRec.Code;
      fDataset.BeforeClose:= DatasetNotifyEvent;
  end
  else
    fDataset.BeforeClose:= nil;

  if Self.GetEventRec(EventRec, fDataset.Name, BeforeDelete, true) then
  begin
      TMethod(DatasetNotifyEvent).Data:= EventRec.Data;
      TMethod(DatasetNotifyEvent).Code:= EventRec.Code;
      fDataset.BeforeDelete:= DatasetNotifyEvent;
  end
  else
    fDataset.BeforeDelete:= nil;


  if Self.GetEventRec(EventRec, fDataset.Name, BeforeEdit, true) then
  begin
      TMethod(DatasetNotifyEvent).Data:= EventRec.Data;
      TMethod(DatasetNotifyEvent).Code:= EventRec.Code;
      fDataset.BeforeEdit:= DatasetNotifyEvent;
  end
  else
    fDataset.BeforeEdit:= nil;

  if Self.GetEventRec(EventRec, fDataset.Name, Beforepost, true) then
  begin
      TMethod(DatasetNotifyEvent).Data:= EventRec.Data;
      TMethod(DatasetNotifyEvent).Code:= EventRec.Code;
      fDataset.Beforepost:= DatasetNotifyEvent;
  end
  else
    fDataset.Beforepost:= nil;

  if Self.GetEventRec(EventRec, fDataset.Name, AfterPost, true) then
  begin
      TMethod(DatasetNotifyEvent).Data:= EventRec.Data;
      TMethod(DatasetNotifyEvent).Code:= EventRec.Code;
      fDataset.AfterPost:= DatasetNotifyEvent;
  end
  else
    fDataset.AfterPost:= nil;


  if Self.GetEventRec(EventRec, fDataset.Name, NewRecord, true) then
  begin
      TMethod(DatasetNotifyEvent).Data:= EventRec.Data;
      TMethod(DatasetNotifyEvent).Code:= EventRec.Code;
      fDataset.OnNewrecord:= DatasetNotifyEvent;
  end
  else
    fDataset.OnNewrecord:= nil;

  if Self.GetEventRec(EventRec, fDataset.Name, BeforeOpen, true) then
  begin
      TMethod(DatasetNotifyEvent).Data:= EventRec.Data;
      TMethod(DatasetNotifyEvent).Code:= EventRec.Code;
      fDataset.BeforeOpen:= DatasetNotifyEvent;
  end
  else
    fDataset.BeforeOpen:= nil;



  if Self.GetEventRec(EventRec, fDataset.Name, BeforeInsert, true) then
  begin
      TMethod(DatasetNotifyEvent).Data:= EventRec.Data;
      TMethod(DatasetNotifyEvent).Code:= EventRec.Code;
      fDataset.BeforeInsert:= DatasetNotifyEvent;
  end
  else
    fDataset.BeforeInsert:= nil;

  if Self.GetEventRec(EventRec, fDataset.Name, AfterInsert, true) then
  begin
      TMethod(DatasetNotifyEvent).Data:= EventRec.Data;
      TMethod(DatasetNotifyEvent).Code:= EventRec.Code;
      fDataset.AfterInsert:= DatasetNotifyEvent;
  end
  else
    fDataset.AfterInsert:= nil;

  if Self.GetEventRec(EventRec, fDataset.Name, Calcfields, true) then
  begin
      TMethod(DatasetNotifyEvent).Data:= EventRec.Data;
      TMethod(DatasetNotifyEvent).Code:= EventRec.Code;
      fDataset.onCalcfields:= DatasetNotifyEvent;
  end
  else
    fDataset.onCalcfields:= nil;

  fDataset.AfterScroll:= nil;
  fDataset.BeforeScroll:= nil;
  fDataset.AfterDelete:= nil;

  fDatasetEventsCaptured:= false;
end;

procedure TDatasetBusObj.ReleaseFieldEvents;
var
  EventRec: TEventRec;
  x: integer;
  FieldNotifyEvent: TFieldNotifyEvent;
begin
  if not fDatasetFldEventsCaptured then exit;
  try
    for x:= 0 to fDataset.FieldCount - 1 do begin
      if Self.GetEventRec(EventRec, fDataset.Fields[x].FieldName, OnChange, true) then
      begin
        // return saved event handler

        TMethod(FieldNotifyEvent).Data:= EventRec.Data;
        TMethod(FieldNotifyEvent).Code:= EventRec.Code;
        fDataset.Fields[x].OnChange:= FieldNotifyEvent;

  //      FieldNotifyEvent:= fDataset.Fields[x].OnChange;
  //      TMethod(FieldNotifyEvent).Data:= EventRec.Data;
  //      TMethod(FieldNotifyEvent).Code:= EventRec.Code;
      end
      else
        fDataset.Fields[x].OnChange:= nil;
    end;
  Except
    // kill the exception
  end;
  fDatasetFldEventsCaptured:= false;
end;

procedure TDatasetBusObj.Repostcallback(const Sender: TBusObj;  var Abort: boolean);
begin
  Sender.EditnPostDB;
end;

procedure TDatasetBusObj.SetDataset(const Value: TCustomMyDataset);
begin
    if Value = fDataset then exit;
  if Value = nil then begin
    fDataSet := nil;
    Exit;
  end;
  if Assigned(fDataset) then begin
    Self.ReleaseFieldEvents;
    Self.ReleaseDatasetEvents;
    if not fExternalDatasetAssigned then
      FreeAndNil(fDataset);
  end;
  fDataset := Value;

  if (not Assigned(fConnection)) and (Assigned(fDataset.connection)) then begin
    fconnection := TMyDacDataConnection.Create(Self);
    TMyDacDataConnection(fConnection).MyDacConnection := fDataset.Connection;
  end;

  FreeNotification(fDataSet);
  fExternalDatasetAssigned := true;
  CaptureDatasetEvents;

  if (fDataset.Active) and Assigned(Container) then
    Container.DoEvent(self, evDSAfterAssignDataset);

end;

function TDatasetBusObj.GetBusObjectTypeDescription: string;
begin
  if fBusObjectTypeDescription <> '' then
    result:= fBusObjectTypeDescription
  else  if (Assigned(Self.Owner)) and (Self.Owner is TDatasetBusObj) then
       REsult := TDatasetBusObj(Self.Owner).BusObjectTypeDescription
  else result := SeparateWords(TBusobj(Self).XMLNodeName);
end;

function TDatasetBusObj.GetConnection: TMyDacDataConnection;
begin
    if Self = nil then Result := nil else result:= fConnection;
end;

procedure TDatasetBusObj.SetConnection(const Value: TMyDacDataConnection);
begin
  fConnection:= Value;
  if Value <> nil then
      Value.AddBusObj(TDatasetBusObj(Self));
end;

Procedure TDatasetBusObj.AfterDatasetCreated;
begin

end;

function TDatasetBusObj.APIListDefaultProperties: string;
begin
  result := 'Id,MsTimeStamp,MsUpdateSiteCode,GlobalRef';
end;

procedure TDatasetBusObj.Edit;
begin
  if IsNew then
  begin
    if (not CanCreate) then
    begin
      self.ResultStatus.AddItem(false, rssError, 0,NoRigtsMsg('Edit New') );
      exit;
    end
  end
  else
  begin
    if (not CanUpdate) then
    begin
      self.ResultStatus.AddItem(false, rssError, 0, NoRigtsMsg('Update'));
      exit;
    end
  end;

  if Assigned(fConnection) then begin
    Connection.DatasetEdit(Self);
    inherited;
  end
  else if Assigned(fDataset) then begin
    fDataset.Edit;
    inherited;
  end;
end;
procedure TDatasetBusObj.New;
begin
  New(False);
end;

procedure TDatasetBusObj.New(DoInsert: Boolean);
begin
  if not CanCreate then
  begin
    self.ResultStatus.AddItem(false, rssError, 0, NoRigtsMsg('Create New'));
    exit;
  end;
  inherited new;{inherited should becalled before adding the new record as it clears the container of the current record}
  if Assigned(fConnection) then begin
    Connection.DatasetNew(Self, DoInsert );
  end
  else if Assigned(fDataset) then begin
    fDataset.Insert;
  end
  else begin
    Dataset.Insert;
  end;
  IsNew := true;
  OnDataIdChange(dcNew);
  fsOldSQL := '';
end;

procedure TDatasetBusObj.Cancel;
begin
  inherited;
  if Assigned(fConnection) then begin
    Connection.DatasetCancel(Self);
  end
  else if Assigned(fDataset) then begin
    if fDataset.State in [dsEdit, dsInsert] then begin
      fDataset.Cancel;
    end;
  end;
  Dirty:= false;
end;
Procedure TDatasetBusObj.CancelDb;
begin
    if not assigned(fDataset) then Exit;
    if fDataset.State = dsInactive then Exit;

    if fDataset.State in [dsEdit,dsInsert] then
        fDataset.cancel;
end;
procedure TDatasetBusObj.PostnEditDB;
begin
    if not assigned(fDataset) then Exit;
    if fDataset.State = dsInactive then Exit;
    PostDB;
    EditDB;
end;

Procedure TDatasetBusObj.PostDb;
var
  s:String;
begin
    if not assigned(fDataset) then Exit;
    if fDataset.State = dsInactive then Exit;
    if DatasetPosting then exit;
    DatasetPosting:= true;
    try
      if fDataset.State in [dsEdit,dsInsert] then
        try
          fDataset.Post;
        except
          on e: exception do begin
            if e is EAbort then
              raise
            else begin
              e.Message:= Self.ClassName + ' ' + e.Message;
              if Pos('Duplicate entry', e.Message) > 0 then
                raise
              else begin
                s:=   e.ClassName + ' Error: ' + e.Message +
                          chr(13) + 'Name :' +fdataset.name+
                          chr(13) + 'SQL  : ' + fDataset.SQL.Text+
                          chr(13) + 'Active :' +BooleantoString(fdataset.active);
                if fdataset.active then begin
                  if ID<> 0 then s:= s + chr(13)+' ID: ' + inttostr(ID);
                  s:= s + chr(13) + ' RecordCount :' +inttostr(fdataset.recordcount);
                  if fdataset.findfield('Deleted')<>nil then s:= s + chr(13)+' Deleted :' +fDataset.FieldByname('Deleted').asString;
                  if fdataset.findfield('Active')<>nil then s:= s + chr(13)+' Active :' +fDataset.FieldByname('Active').asString;
                end;
                raise Exception.Create(s);
              end;
            end;
          end;
        end;
    finally
      DatasetPosting:= false;
    end;
end;

function TDatasetBusObj.Save: boolean;
begin
//  TLogger.Inst.Log('Saving: ' + ClassName + '   Id: ' + IntToStr(ID) + '   ' + self.Dataset.SQL.Text);
  result:= false;
  if IsNew then
  begin
    if (not CanCreate) then
    begin
      self.ResultStatus.AddItem(false, rssError, 0, NoRigtsMsg('Create New'));
      exit;
    end
  end
  else
  begin
    if (not CanUpdate) then
    begin
      self.ResultStatus.AddItem(false, rssError, 0, NoRigtsMsg('Update'));
      exit;
    end
  end;

//  if Dirty and (not RawMode) then begin
//    DoUpdateSiteCode;
//  end;
  if Assigned(fConnection) then begin
    try
      Connection.DatasetSave(Self);
    except
      on e: exception do begin
        result:= false;
        self.ResultStatus.AddItem(false, rssError, 0, e.Message);
        exit;
      end;
    end;
    result:= inherited Save;
    if not result then
      exit;
  end
  else if Assigned(fDataset) then begin
    if fDataset.State in [dsEdit, dsInsert] then begin
      PostDB;
      result:= inherited Save;
      if not result then
        exit;
    end;
  end;
  {Note: High level object should Save sub items as required  }
//  for x:= 0 to Self.ComponentCount-1 do begin
//    if Self.Components[x] is TDatasetBusObj then begin
//      TDatasetBusObj(Self.Components[x]).Save;
//    end;
//  end;
  Vars.Dirty:= false;
  IsNew:= false;
  result:= true;
end;

procedure TDatasetBusObj.Close(const doReset: boolean = false);
begin
  if Assigned(fDataset) then
    if  fDataset.Active then begin
        fDataset.Close;
    OnDataIdChange(dcClose);
  end;
  if doReset then
    Reset;
end;

Function TDatasetBusObj.getAccessManager :TDNMAccessManager ;
var
    Obj :TComponent;
begin
//    Log('TDatasetBusObj.getAccessManager - Start');
    Try
      try
        if not Assigned(fAccessManager) then begin
            obj := Self.Owner;
            while not((Obj is TForm) or (Obj = nil ) or (Obj is TDatasetBusObj)) do
                Obj :=Obj.Owner;

            if (obj <> nil) then begin
              if (Obj is TForm) then begin
                if Assigned(GetPropInfo(Obj, 'AccessManager')) then
                  fAccessManager:= TDNMAccessManager(TypInfo.GetObjectProp(Obj,'AccessManager'))
                else begin
                  if Assigned(TForm(obj).Owner) and (TForm(obj).Owner is TForm) then begin
                     if Assigned(GetPropInfo(TForm(TForm(obj).Owner), 'AccessManager')) then
                       fAccessManager:= TDNMAccessManager(TypInfo.GetObjectProp(TForm(obj).Owner,'AccessManager'))
                  end;

                end;
              end
              else if (Obj is TDatasetBusObj) then begin
                fAccessManager:= TDatasetBusObj(Obj).AccessManager;
              end;
            end;
            if not Assigned(fAccessManager) then
                if assigned(Self.Owner) then if Self.Owner is TBusobj then fAccessManager := TBusObj(Self.Owner).AccessManager;

            if not Assigned(fAccessManager) then  begin
                fAccessManager := TDNMAccessManager.Create(Self);
                fAccessManager.Accesslevel := AppEnv.AccessLevels.GetBusobjAccessLevel(Self.ClassName);
            end;
        end;
      except
        on e: exception do begin
          Log('TDatasetBusObj.getAccessManager - Exception: ' + e.Message);
          raise;
        end;
      end;
    Finally
        Result := fAccessManager;
    End;
//    Log('TDatasetBusObj.getAccessManager - End');
end;

procedure TDatasetBusObj.Load(const fIsReadonly:boolean =False);
var
    fsExcludeInactive : String;
begin
    if (not CanRead) then
    begin
      self.ResultStatus.AddItem(false, rssError, 0, NoRigtsMsg('Read'));
      exit;
    end;
    {if the SQL is not changed and the dataset is still active then should not do the load again }
    if SameText(SQL , fsOldSQL) then
      if Dataset.Active then begin
  //      TLogger.Inst.Log('TDatasetBusObj.Load - SQL has not changed', ltDetail);
        Exit;
      end;
    inherited;
    fsExcludeInactive := '';
    if ExcludeInactive then
        if Dataset.findfield('Active') <> nil then fsExcludeInactive := ' Active <> ''F'''
        else if Dataset.findfield('Deleted') <> nil then fsExcludeInactive := ' Deleted <> ''T''';
    if fsExcludeInactive <> '' then
      if fSQLSelect <> '' then fSQLSelect :='(' + fSQLSelect + ' ) and ' + fsExcludeInactive
      else fSQLSelect :=fsExcludeInactive;

  //  TLogger.Inst.Log('TDatasetBusObj.Load - fSQLSelect: ' + fSQLSelect, ltDetail);

    if not Assigned(fConnection) then
      Self.Connection:= GetDefaultConnection;
    if Connection is TMyDacDataConnection then
      TMyDacDataConnection(Connection).DatasetLoad(Self)
    else
      Connection.DatasetLoad(Self);

    IsNew:= false;
    Dirty:= false;
    fsOldSQL := SQL;
end;

procedure TDatasetBusObj.Load(Const aId: integer;const fIsReadonly:boolean =False);
begin
  //Id:= aId;
  if DatasetAssigned and fdataset.active then
    if (IDFieldName <> '' ) and (fdataset.recordcount =1) and (fdataset.fieldbyname(IDFieldName).asInteger = aid) then begin
      if isreadonly <>  fIsReadonly then isreadonly := fIsReadonly;
      Exit;
    end;

  if IDFieldName <> '' then
    fSQLSelect := IDFieldName + ' = ' + IntToStr(aid);
  Load(fIsReadonly);

end;

procedure TDatasetBusObj.Load(const aGlobalRef: string;  const fIsReadonly: boolean);
begin
  if DatasetAssigned and fdataset.active then
    if  (fdataset.recordcount =1) and sametext(fdataset.fieldbyname('GlobalRef').asString , aGlobalRef) then begin
      if isreadonly <>  fIsReadonly then isreadonly := fIsReadonly;
      Exit;
    end;

  LoadSelect('GlobalRef = ' + QuotedStr(aGlobalRef), fIsReadonly);
end;

procedure TDatasetBusObj.LoadCount(Const Limitcount: integer; const LimitFrom: integer = -1);
begin
  fLimitCount := Limitcount;
  fLimitFrom := LimitFrom;
  Load;
end;

procedure TDatasetBusObj.LoadPropnames;
begin

end;

procedure TDatasetBusObj.LoadSelect(Const SelectStatement: string;const fIsReadonly:boolean =False);
begin
  fSQLSelect := SelectStatement;
  Load(fIsReadonly);
end;

procedure TDatasetBusObj.DatasetBeforeScroll(Dataset: TDataset);
begin
  DatasetScrolling:= true;
  OnBeforeDataIdChange;
end;

procedure TDatasetBusObj.DatasetAfterScroll(Dataset: TDataset);
begin
//  Log(self.ClassName + '.AfterScroll');
  DatasetScrolling:= false;
  IsNew:= false;
  fbnewRec := False;
  if fDataset.Recordcount = 0 then if not (fDataset.State in [dsEdit,dsInsert]) then Exit;

  if (Id <> fLastScrollID) or (Id = 0) then begin
    fLastScrollID := Id;
    if (fDataset.State = dsInsert) then
      OnDataIdChange(dcNew)
    else
      OnDataIdChange(dcLoad);
  end;
end;

procedure TDatasetBusObj.DeleteCallback(Const Sender: TBusObj; var Abort: boolean) ;
begin
    Sender.Delete;
end;

function TDatasetBusObj.Delete: boolean;
begin
//  Log(Self.ClassName + '.Delete');
  if (not CanDelete) then
  begin
    self.ResultStatus.AddItem(false, rssError, 0, NoRigtsMsg('Delete'));
      Result := False;
    exit;
  end;
  result:= inherited Delete;
  if not result then
    exit;
  if Assigned(fConnection) then begin
    Connection.DatasetDelete(Self);
  end
  else if Assigned(fDataset) then begin
    fDataset.Delete;
  end;
  OnDataIdChange(dcDelete);
//  Dirty:= false;
  IsNew:= false;
end;

function TDatasetBusObj.DSWriteOk: boolean;
Begin

  Result := False;
  If IsNew Then Begin
    If (Not CanCreate) Then Begin
      self.ResultStatus.AddItem(False, rssError, 0,NoRigtsMsg('Edit New') );
      Exit;
    End;
    if IsReadonly then begin
      self.ResultStatus.AddItem(False, rssError, 0,Self.BusObjectTypeDescription+' is Read-Only.  ' + NoRigtsMsg('Edit New') );
      Exit;
    end;
  End Else Begin
    If (Not CanUpdate) Then Begin
      self.ResultStatus.AddItem(False, rssError, 0, NoRigtsMsg('Update'));
      Exit;
    End;
    if IsReadonly and (fDataset.State <> dsCalcFields) then begin
      self.ResultStatus.AddItem(False, rssError, 0,Self.BusObjectTypeDescription+' is Read-Only.  ' + NoRigtsMsg('Update'));
      Exit;
    end;
  End;
  If Assigned(fDataset) And fDataset.Active Then Begin
    If Not (fDataset.State In [dsEdit, dsInsert, dsCalcFields]) Then Begin
      fDataset.Edit;
    End;
    Result := True;
  End;
End;

function TDatasetBusObj.DSReadOk: boolean;
Begin
  Result := False;
  If (Not CanRead) Then Begin
    self.ResultStatus.AddItem(False, rssError, 0, NoRigtsMsg('Read'));
    Exit;
  End;
  If Assigned(fDataset) And fDataset.Active Then Result := True;
End;

function TDatasetBusObj.GetSQL: string;
var
  s: string;
//  sl: TStringList;
begin
  s:= '';
  if (FSQL = '') and (BusobjectTablename <> '') then fSQL := 'SELECT * from ' + BusObjectTableName;
  if fSQL <> '' then
    s:= fSQL;
  if fSQLSelect <> '' then
  begin
    if Pos('WHERE', uppercase(fSQL)) > 0 then
      s:= s + ' AND ' + fSQLSelect
    else
      s:= s + ' WHERE ' + fSQLSelect;
  end;
  if fSQLGroup <> '' then begin
    if Pos('GROUP BY', Uppercase(fSQL)) > 0 then
      s:= s + ' , ' + fSQLGroup
    else
      s:= s + ' Group BY ' + fSQLGroup;
  end;
  if fSQLOrder <> '' then
  begin
    if Pos('ORDER BY', Uppercase(fSQL)) > 0 then
      s:= s + ' , ' + fSQLOrder
    else
      s:= s + ' ORDER BY ' + fSQLOrder;
  end;
  if fLimitCount >= 0 then begin
    s:= s + ' Limit ';
    if fLimitFrom >= 0 then
      s:= s + IntToStr(fLimitFrom) + ', ';
    s:= s + IntToStr(fLimitCount);
  end;
  result:= s;
end;

Procedure TDatasetBusObj.check4FieldError(Fieldname:String;fCurDBField: TField);
begin
  if devmode and (fCurDBField = Nil)  then begin
    if not(datasetassigned) or (fDataset.active =False) then exit;
    fsCheck4fieldErrorMsg := Fieldname +' Doesn''t exists in  ' +  heirarchyname(true) + NL + SQL;
    try
      SendEvent(BusobjEvent_ToDo , BusobjEvent_check4FieldErrorMsg , self);
      //logtext (replacestr(check4FieldErrorMsg  , NL , ' - '));
    finally
      fsCheck4fieldErrorMsg := '';
    end;
  end;
end;

function TDatasetBusObj.GetFloatField(const FieldName: string): double;
var
  fCurDBField: TField;
Begin
  fCurDBField := Nil;
  Result := 0.0;
  If DSReadOk Then fCurDBField := Dataset.FindField(FieldName);
  check4FieldError(Fieldname,fCurDBField);
  If fCurDBField <> Nil Then Result := fCurDBField.AsFloat;
  if Assigned(fCurDBField) then fLastFieldName := fCurDBField.FieldName
  else fLastFieldName := '';
//  else Log(fieldName +' : field not found --> ' + Self.Classname , LogType_Error);
End;

function TDatasetBusObj.GetIntegerField(const FieldName: string): Integer;
var
  fCurDBField: TField;
Begin
  fCurDBField := Nil;
  Result := 0;
  If DSReadOk Then fCurDBField := Dataset.FindField(FieldName);
  check4FieldError(Fieldname,fCurDBField);
  If fCurDBField <> Nil Then Result := fCurDBField.AsInteger;
  if Assigned(fCurDBField) then fLastFieldName := fCurDBField.FieldName
  else fLastFieldName := '';
//  else Log(fieldName +' : field not found --> ' + Self.Classname , LogType_Error);
End;

function TDatasetBusObj.getIsEmpty: Boolean;
begin
  result := Assigned(fdataset) and (fdataset.active) and  (fdataset.isEmpty);
end;

function TDatasetBusObj.GetIsList: boolean;
begin
  result:= fIsList;
end;

function TDatasetBusObj.GetStringField(const FieldName: string): string;
var
  fCurDBField: TField;
Begin
  fCurDBField := Nil;
  Result := '';
  If DSReadOk Then fCurDBField := Dataset.FindField(FieldName);
  check4FieldError(Fieldname,fCurDBField);
  If fCurDBField <> Nil Then Result := fCurDBField.AsString;
  if Assigned(fCurDBField) then fLastFieldName := fCurDBField.FieldName
  else fLastFieldName := '';
//  else Log(fieldName +' : field not found --> ' + Self.Classname , LogType_Error);
End;

procedure TDatasetBusObj.SetFloatField(const FieldName: string; const Value: double);
var
  fCurDBField: TField;
  fbFieldReadonly:Boolean;
Begin
  fCurDBField := Nil;
  If DSWriteOk Then fCurDBField := Dataset.FindField(FieldName);
  check4FieldError(Fieldname,fCurDBField);
  //If fCurDBField <> Nil Then fCurDBField.AsFloat := Value;
  If fCurDBField <> Nil Then begin
    fbFieldReadonly :=fCurDBField.Readonly;
    try
      if EnablePropertySetWhenReadonly and fCurDBField.Readonly then fCurDBField.Readonly := False;
      if fCurDBField.Readonly then Exit;
      if (fCurDBField.AsFloat <> Value)  OR ((fCurDBField.value = null) and (Value = 0))  then
        fCurDBField.AsFloat := Value;
    finally
      fCurDBField.Readonly := fbFieldReadonly;
    end;
  end;

//  else Log(fieldName +' : field not found --> ' + Self.Classname , LogType_Error);
End;

procedure TDatasetBusObj.SetIntegerField(const FieldName: string; const Value: Integer);
var
  fCurDBField: TField;
  fbFieldReadonly:Boolean;
Begin
  fCurDBField := Nil;
  If DSWriteOk Then    fCurDBField := Dataset.FindField(FieldName);
  check4FieldError(Fieldname,fCurDBField);
  //If fCurDBField <> Nil Then    fCurDBField.AsInteger := Value
  If fCurDBField <> Nil Then begin
    fbFieldReadonly :=fCurDBField.Readonly;
    try
      if EnablePropertySetWhenReadonly and fCurDBField.Readonly then fCurDBField.Readonly := False;
      if fCurDBField.Readonly then Exit;
      if (fCurDBField.AsInteger <>  Value)  OR ((fCurDBField.value = null) and (Value = 0))  then
        fCurDBField.AsInteger := Value;
    finally
      fCurDBField.Readonly := fbFieldReadonly;
    end;
  end;
//  else Log(fieldName +' : field not found --> ' + Self.Classname , LogType_Error);
End;

procedure TDatasetBusObj.SetStringField(const FieldName, Value: string);
var
  fCurDBField: TField;
  fbFieldReadonly:Boolean;
Begin
  fCurDBField := Nil;
  If DSWriteOk Then    fCurDBField := Dataset.FindField(FieldName);
  check4FieldError(Fieldname,fCurDBField);
  //If fCurDBField <> Nil Then fCurDBField.AsString := Value
  If fCurDBField <> Nil Then begin
    fbFieldReadonly :=fCurDBField.Readonly;
    try
      if EnablePropertySetWhenReadonly and fCurDBField.Readonly then fCurDBField.Readonly := False;
      if fCurDBField.Readonly then Exit;
      if (fCurDBField.asString <> Value) OR ((fCurDBField.value = null) and (Value = '')) then
        fCurDBField.asString := Value;
    finally
      fCurDBField.Readonly := fbFieldReadonly;
    end;
  end;
//  else Log(fieldName +' : field not found --> ' + Self.Classname , LogType_Error)
End;

procedure TDatasetBusObj.ShowRec(aId: Integer; ainfo: String; showheader:Boolean = false);
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Connection.Connection);
  try
    qry.sql.text := sql;
    qry.open;
    if (qry.locate(IDFieldname , aid, [])) then
      if (qry.recordcount <> count)  then
        LogDsData(qry , ainfo, showheader)
      else LogDsData(qry , ainfo, showheader);
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

function TDatasetBusObj.GetBookmark: TBookmark;
begin
  Result := nil;
  if DatasetAssigned then result := fDataset.GetBookmark;
end;
procedure TDatasetBusObj.FreeBookmark(bm: TBookmark);
begin
  if DatasetAssigned then fDataset.FreeBookmark(bm);
end;
procedure TDatasetBusObj.GotoBookmark(bm: TBookmark);
begin
  if DatasetAssigned then fDataset.GotoBookmark(bm);
end;

procedure TDatasetBusObj.GotoRecord(const aRecno: Integer);
begin
  if Assigned(fDataset) then
    if aRecno-recno <> 0 then
      fDataset.Moveby(aRecno-recno);
end;

function TDatasetBusObj.GroupConcat(const concatField, Datasetfilter: String;const Disablefilter: boolean; Delim, PrefixStr, SufixStr: String; Quoteeach,GroupDistinct: Boolean): String;
begin
  REsult := '';
  if not(datasetAssigned) then exit;
  Result := TERPQuery(Dataset).GroupConcat(concatField, Datasetfilter,Disablefilter,Delim, PrefixStr, SufixStr,Quoteeach,GroupDistinct);
end;

function TDatasetBusObj.GetBooleanField(const FieldName: string): Boolean;
var
  fCurDBField: TField;
Begin
  fCurDBField := Nil;
  Result := False;
  If DSReadOk Then fCurDBField := Dataset.FindField(FieldName);
  check4FieldError(Fieldname,fCurDBField);
  If fCurDBField <> Nil Then Result := fCurDBField.AsBoolean;
  if Assigned(fCurDBField) then fLastFieldName := fCurDBField.FieldName
  else fLastFieldName := '';
//  else Log(fieldName +' : field not found --> ' + Self.Classname , LogType_Error);
End;

procedure TDatasetBusObj.SetBooleanField(const FieldName: string; const Value: Boolean);
var
  fCurDBField: TField;
  fbFieldReadonly:Boolean;
Begin
  fCurDBField := Nil;
  If DSWriteOk Then fCurDBField := Dataset.FindField(FieldName);
  check4FieldError(Fieldname,fCurDBField);
  //If fCurDBField <> Nil Then fCurDBField.AsBoolean := Value
  If fCurDBField <> Nil Then begin
    fbFieldReadonly :=fCurDBField.Readonly;
    try
      if EnablePropertySetWhenReadonly and fCurDBField.Readonly then fCurDBField.Readonly := False;
      if fCurDBField.Readonly then Exit;
      if fCurDBField.AsBoolean <>  Value then
        fCurDBField.AsBoolean := Value;
    finally
      fCurDBField.Readonly := fbFieldReadonly;
    end;
  end;
//  else Log(fieldName +' : field not found --> ' + Self.Classname , LogType_Error);
End;

procedure TDatasetBusObj.CallSavedFieldEvent(Field: TField; EventType: TEventType);
var
  EventRec: TEventRec;
  FieldNotifyEvent: TFieldNotifyEvent;
begin
try
  // find and call any saved event handlers
  if Self.GetEventRec(EventRec, Field.FieldName, EventType) then
  begin
    TMethod(FieldNotifyEvent).Data:= EventRec.Data;
    TMethod(FieldNotifyEvent).Code:= EventRec.Code;
    FieldNotifyEvent(Field);
  end;
Except
    on E:Exception do begin
	  end;

end;
end;

function TDatasetBusObj.GetDateTimeField(const FieldName: string): TDateTime;
var
  fCurDBField: TField;
begin
  fCurDBField := Nil;
  result:= 0;
  if DSReadOk then fCurDBField:= Dataset.FindField(FieldName);
  if fCurDBField<> nil then result:= Dataset.FieldByName(FieldName).AsDateTime;
  if Assigned(fCurDBField) then fLastFieldName := fCurDBField.FieldName
  else fLastFieldName := '';
//  else Log(fieldName +' : field not found --> ' + Self.Classname , LogType_Error);
end;

procedure TDatasetBusObj.SetDateTimeField(const FieldName: string; const Value: TDateTime);
var
  fCurDBField: TField;
  fbFieldReadonly:Boolean;
Begin
  fCurDBField := Nil;
  If DSWriteOk Then fCurDBField := Dataset.FindField(FieldName);
  check4FieldError(Fieldname,fCurDBField);
  (*If fCurDBField <> Nil Then begin
    If (Value = 0) And (NullWhenDateIs0) Then fCurDBField.Value := Null
    Else fCurDBField.AsDateTime := Value;
  end*)

  If fCurDBField <> Nil Then begin
    fbFieldReadonly :=fCurDBField.Readonly;
    try
      if EnablePropertySetWhenReadonly and fCurDBField.Readonly then fCurDBField.Readonly := False;
      if fCurDBField.Readonly then Exit;
      If (Value = 0) And (NullWhenDateIs0) and (fCurDBField.Value <> null) Then fCurDBField.Value := Null
      Else if fCurDBField.AsDateTime <>  Value then
        fCurDBField.AsDateTime := Value;
    finally
      fCurDBField.Readonly := fbFieldReadonly;
    end;
  end;

//  else Log(fieldName +' : field not found --> ' + Self.Classname , LogType_Error);
End;

procedure TDatasetBusObj.SetFieldtoNull(const FieldName: string);
var
  fCurDBField: TField;
  fbFieldReadonly:Boolean;
Begin
  fCurDBField := Nil;
  If DSWriteOk Then fCurDBField := Dataset.FindField(FieldName);
  check4FieldError(Fieldname,fCurDBField);
  (*If fCurDBField <> Nil Then begin
    fCurDBField.Value := Null
  end*)
  If fCurDBField <> Nil Then begin
    fbFieldReadonly :=fCurDBField.Readonly;
    try
      if EnablePropertySetWhenReadonly and fCurDBField.Readonly then fCurDBField.Readonly := False;
      if fCurDBField.Readonly then Exit;
      fCurDBField.Value := Null;
    finally
      fCurDBField.Readonly := fbFieldReadonly;
    end;
  end;

//  else Log(fieldName +' : field not found --> ' + Self.Classname , LogType_Error);
End;


procedure TDatasetBusObj.DatasetAfterDelete(Dataset: TDataset);
begin
//  Log(self.ClassName + '.AfterDelete');
  inherited;
    if Self.DoAfterDelete(Self) = true then begin
        Dirty:= True;
    end;
end;

procedure TDatasetBusObj.DatasetCalcFields(Dataset: TDataset);
var
  EventRec: TEventRec;
  DatasetNotifyEvent: TDatasetNotifyEvent;
begin
    if fbCalcFields then exit;
    fbCalcFields := True;
    try
    //  Log(self.ClassName + '.CalcFields');
        Self.DoCalcFields(Self);
      // find and call any saved event handlers
      Try
        if Self.GetEventRec(EventRec, Dataset.Name, CalcFields) then
        begin
          TMethod(DatasetNotifyEvent).Data:= EventRec.Data;
          TMethod(DatasetNotifyEvent).Code:= EventRec.Code;
          DatasetNotifyEvent(Dataset);
        end;
      Except
        on E:Exception do begin
        end;

      End;
      SendEvent(BusObjEvent_Dataset,BusObjEvent_CalcFields, Self);
    finally
      fbCalcFields:= false;
    end;
end;

function TDatasetBusObj.datasetname: String;
var
  obj:Tcomponent;
begin
  Result:= '';
  if not assigned(fDataset) then exit;
  Result := fDataset.Name;
  obj := fDataset.Owner;
  while obj<> nil do begin
    if obj.name <> '' then
         Result := obj.Name + '->' +  result
    else Result := obj.ClassName + '->' +  result;
    obj := obj.Owner;
  end;
end;

procedure TDatasetBusObj.DatasetAfterInsert(Dataset: TDataset);
var
  EventRec: TEventRec;
  DatasetNotifyEvent: TDatasetNotifyEvent;
begin
//  Log(self.ClassName + '.AfterInsert');
  DoFieldChange:= True; // was set to false in before insert for the default values
  fbnewRec :=true;
  Self.DoAfterInsert(Self);
  // find and call any saved event handlers
  try
    if Self.GetEventRec(EventRec, Dataset.Name, AfterInsert) then
    begin
      TMethod(DatasetNotifyEvent).Data:= EventRec.Data;
      TMethod(DatasetNotifyEvent).Code:= EventRec.Code;
      DatasetNotifyEvent(Dataset);
    end;
  Except
    on E:Exception do begin
	  end;
  End;
  SendEvent(BusobjEvent_Event , BusObjEventDataset_AfterInsert , self);
end;


procedure TDatasetBusObj.First;
begin
  if Assigned(fDataset) then
    fDataset.First;
end;


function TDatasetBusObj.GetCount: integer;
begin
  result:= 0;
  if Assigned(fDataset) then
    result:= fDataset.RecordCount;
end;

procedure TDatasetBusObj.Last;
begin
  if Assigned(fDataset) then
    fDataset.Last;
end;

procedure TDatasetBusObj.Next;
begin
  if Assigned(fDataset) then
    fDataset.Next;
end;

procedure TDatasetBusObj.Prior;
begin
  if Assigned(fDataset) then
    fDataset.Prior;
end;

function TDatasetBusObj.PropertyNameToFieldName(aPropName: string): string;
begin
  fLastFieldName:= '';
  case PropType(self,aPropName) of
    tkInteger,
    tkEnumeration: GetOrdProp(self,aPropName);
    tkChar,
    tkString: GetStrProp(self,aPropName);
    tkWChar,
    tkWString: GetWideStrProp(self,aPropName);
    tkLString: GetAnsiStrProp(self,aPropName);
    tkVariant: GetVariantProp(self,aPropName);
    tkInt64: GetInt64Prop(self,aPropName);
    tkUString: GetUnicodeStrProp(self,aPropName);
    tkFloat: GetFloatProp(self,aPropName);
    tkUnknown, tkSet, tkClass,
    tkArray, tkRecord, tkInterface, tkDynArray,
    tkClassRef, tkPointer, tkProcedure,
    tkMethod: ;
  end;
  result:= fLastFieldName;
end;

function TDatasetBusObj.Propnames: TStringlist;
begin
  if fPropnames =nil then begin
    fPropnames :=TStringlist.create;
    LoadPropnames;
  end;
  result :=fPropnames;
end;

function TDatasetBusObj.GetBOF: boolean;
begin
  result:= true;
  if Assigned(fDataset) then
    result:= fDataset.Bof;
end;

function TDatasetBusObj.GetEOF: boolean;
begin
  result:= true;
  if Assigned(fDataset) then
    result:= fDataset.Eof;
end;


procedure TDatasetBusObj.OnBeforeDataIdChange;
begin
  SendEvent(BusObjEvent_Dataset , BusObjEventDataset_beforedataIdchange , self);
end;
procedure TDatasetBusObj.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  { Clear all status messages. }
  if Assigned(fResultStatus) then
    fResultStatus.Reset;
  // implemented in decendants
  //SendEvent(BusObjEvent_Dataset , BusObjEventDataset_dataIdchange , self);
         if ChangeType = dcLoad then SendEvent(BusObjEvent_Dataset , BusObjEventDataset_dataIdchange_dcLoad , self)
    else if ChangeType = dcDelete then SendEvent(BusObjEvent_Dataset , BusObjEventDataset_dataIdchange_dcDelete , self)
    else if ChangeType = dcNew then SendEvent(BusObjEvent_Dataset , BusObjEventDataset_dataIdchange_dcNew , self)
    else if ChangeType = dcSave then SendEvent(BusObjEvent_Dataset , BusObjEventDataset_dataIdchange_dcSave , self)
    else if ChangeType = dcClose then SendEvent(BusObjEvent_Dataset , BusObjEventDataset_dataIdchange_dcClose , self);
  SendEvent(BusObjEvent_Dataset, BusObjEvent_OnDataIDChange, self);
end;
Function TDatasetBusObj.IsdataIdchangeEvent(aEventValue:String):Boolean;
begin
  REsult := sametext(aEventValue ,   BusObjEventDataset_dataIdchange_dcLoad) Or
            sametext(aEventValue ,   BusObjEventDataset_dataIdchange_dcDelete) Or
            sametext(aEventValue ,   BusObjEventDataset_dataIdchange_dcNew) Or
            sametext(aEventValue ,   BusObjEventDataset_dataIdchange_dcSave) Or
            sametext(aEventValue ,   BusObjEventDataset_dataIdchange_dcClose) ;

end;
function TDatasetBusObj.GetNonContainerComponentsDirty: Boolean;
var
  x: Integer;
  lComp: TComponent;
begin
  Result := False;
  for x:= ComponentCount - 1 downto 0 do begin
    lComp := Components[x];
    if ((lComp is TDatasetBusObj) and not TDatasetBusObj(lComp).fInContainer and TDatasetBusObj(lComp).AnyDirty) or
       ((lComp is TBusObjNDS) and TBusObjNDS(lComp).Dirty) then begin
      Result := True;
      Exit;
    end;
  end;
end;

function TDatasetBusObj.GetObjectProperties: TBusobj;
begin
  Result := TObjectProperties(getcontainercomponent(TObjectProperties , 'ObjClassname = ' + quotedstr(self.classname) , true , true));
end;

function TDatasetBusObj.getRecno: Integer;
begin
  result:= 0;
  if Assigned(fDataset) then
    result:= fDataset.recno;

end;

function TDatasetBusObj.getRoundPlacesTotals: word;
begin
  if fCurrencyRoundPlaces =0 then fCurrencyRoundPlaces := CommonLib.CurrencyRoundPlaces;
  result := fCurrencyRoundPlaces;
end;

procedure TDatasetBusObj.SetNonContainerComponentsDirty(const Value: Boolean);
var
  x: Integer;
  lComp: TComponent;
begin
  for x:= ComponentCount - 1 downto 0 do begin
    lComp := Components[x];
    if (lComp is TDatasetBusObj) and not TDatasetBusObj(lComp).fInContainer then
      TDatasetBusObj(lComp).anyDirty := Value
    else if lComp is TBusObjNDS then
      TBusObjNDS(lComp).Dirty := Value;
  end;
end;

function TDatasetBusObj.GetDirty: boolean;
begin
  Result := Container.Dirty;
  if not Result then
    Result := NonContainerComponentsDirty;
end;

function TDatasetBusObj.getDoInitFloatFieldDisplayFormat: boolean;
begin
  if fbDoInitFloatFieldDisplayFormat then result := fbDoInitFloatFieldDisplayFormat
  else if assigned(Owner) and (owner is TDatasetBusObj) then
       Result := TDatasetBusObj(Owner).DoInitFloatFieldDisplayFormat
  else Result := fbDoInitFloatFieldDisplayFormat;
end;

procedure TDatasetBusObj.SetDirty(const Value: boolean);
begin
  if Value then
    Vars.Dirty := True
  else begin
    Container.Dirty := False;
    NonContainerComponentsDirty := False;
  end;
end;

procedure TDatasetBusObj.SetDoFieldChange(const Value: boolean);
begin
  fDoFieldChange := Value;
end;

function TDatasetBusObj.GetAnyDirty: boolean;
begin
  Result := ContainerList.Dirty;
  if not Result then
    Result := NonContainerComponentsDirty;
end;

procedure TDatasetBusObj.SetAccessManager(const Value: TDNMAccessManager);
begin
  fAccessManager := Value;
end;

procedure TDatasetBusObj.SetAnyDirty(const Value: boolean);
begin
  if not Value then begin
    ContainerList.Dirty := False;
    NonContainerComponentsDirty := False;
  end;
end;

function TDatasetBusObj.GetUserLock :TUserLock;
var
  fs:String;
begin
  SendEvent(BusobjEvent_Event, BusobjEvent_OnREdUserLock, Self); // use if want to assign userlock from the form
  if Assigned(fUserLock) then
    Result :=fUserLock
  else if (Assigned(Owner) and (Owner is   TDatasetBusObj)) then
    Result := TDatasetBusObj(Owner).UserLock
  else begin
        fUserLock := TUSerLock.Create(Self);
        Result := fUserLock;
  end;
end;
function TDatasetBusObj.LockAll(const ADatasetName: string; const Lockgroup:String) :Boolean ;
begin
  UserLock.Enabled:= true;
  result:= UserLock.LockAll(ADatasetName,Lockgroup);
end;
function TDatasetBusObj.DetailedName(Sender:TComponent):String;
begin
  if Assigned(Sender.Owner)  and (Sender.Owner is TComponent) then begin
    result := DetailedName(Sender.Owner);
    if Sender.name <> '' then REsult := result + Sender.name else REsult := result + Sender.Classname;
  end else begin
    if Sender.name <> '' then result := Sender.name else result := Sender.Classname;
  end;
end;
procedure TDatasetBusObj.LogDoFieldchange(Sender: TField);
begin

end;


function IAmAConsoleApp: Boolean;
var
  Stdout: THandle;
begin
  Stdout := GetStdHandle(Std_Output_Handle);
  {$Warnings Off}
  Win32Check(Stdout <> Invalid_Handle_Value);
  {$Warnings On}
  Result := Stdout <> 0;
end;

procedure TDatasetBusObj.LogSQL;
var
  s:String;
begin
  if not devmode then exit;
  if IAmAConsoleApp then exit;
  if pos('where ' , sql )<> 0 then exit;
  if pos('WHERE ' , sql )<> 0 then exit;
  if sametext(sql , 'SELECT * FROM tblerpsetup') then exit;
  s:= DetailedName(self);
  if Classnameis('TProduct')
      or classnameis('TSalesOrder')
      or classnameis('TPurchaseOrder')
      or classnameis('TInvoice')
      or classnameis('TQuote')
      or classnameis('TCashSAle')
      or classnameis('TRefundSale')
      or classnameis('TCheque')
      or classnameis('TReturnauthority')
      or classnameis('TBill')
      or classnameis('TCredit') then
      MessageDlgXP_Vista('DEVMODE Msg for Programmer -> obj has no ''WHERE'' clause' +NL+
                          s+ NL +NL +
                          Classname +'->'+SQL, mtWarning, [mbOK], 0);
end;

function TDatasetBusObj.Lock: Boolean;
begin
  result := LockInUse;
end;
function TDatasetBusObj.LockInUse :Boolean ;
begin
  UserLock.Enabled:= true;
  result:= UserLock.Lock(BusObjectTableName,Id, BusObjectTypeDescription);
end;

function TDatasetBusObj.UnLock: Boolean;
begin
  result:= true;
  UserLock.UnlockAllCurrentInstance;
end;

function TDatasetBusObj.IsLocked: boolean;
begin
  result:= UserLock.IsLocked(BusObjectTableName,Id, BusObjectTypeDescription);
end;



procedure TDatasetBusObj.AddEvent(const aEventType, aEventValue: string;aObjectId :Integer; aEventObj :TDatasetBusObj = nil);
var
  x: integer;
  exists: boolean;
  //BO: TDatasetBusObj;
begin
  if not assigned(aEventObj) then aEventObj := self;
  if Assigned(fBusObjEvent) then begin
      exists:= false;
      for x:= 0 to fEventList.Count -1 do
      begin
        if (TBusObjEventListItem(fEventList.Items[x]).EventType = aEventType) and
            (TBusObjEventListItem(fEventList.Items[x]).ObjectID = aObjectID) and
            (TBusObjEventListItem(fEventList.Items[x]).EventObj = aEventObj) and
          (TBusObjEventListItem(fEventList.Items[x]).EventValue = aEventValue) then
        begin
          exists:= true;
          Break;
        end;
      end;

      if not exists then
        with TBusObjEventListItem(fEventList.Add) do
        begin
          EventType := aEventType;
          EventValue:= aEventValue;
          EventObj  := aEventObj;
          ObjectId  := aObjectID;
          Done      := False;
          Processing:= False;
        end;
        Exit;
  end else if Assigned(Self.Owner) and (Self.Owner is TDatasetBusObj) then
    TDatasetBusObj(Self.Owner).AddEvent(aEventType, aEventValue,aObjectId,aEventObj);

end;
Procedure TDatasetBusObj.EditDB;
begin
    if Assigned(fDataset) then
        if not (Dataset.state in [dsEdit,dsInsert])  then
            Dataset.Edit;
end;

procedure TDatasetBusObj.EditnPostDB;
begin
    if not assigned(fDataset) then Exit;
    if fDataset.State = dsInactive then Exit;
    EditDB;
    PostDB;
end;

Procedure TDatasetBusObj.ClearAllEvents;
begin

  if Assigned(fBusObjEvent) then begin
      fEventList.Clear;
      exit;
  end else if Assigned(Self.Owner) and (Self.Owner is TDatasetBusObj) then
    TDatasetBusObj(Self.Owner).ClearAllEvents;
  exit;
end;
procedure TDatasetBusObj.SendAllEvents;
var
  x: integer;
  //BO: TDatasetBusObj;
  item: TBusObjEventListItem;
begin
  if fbRunningEventListEvents then Exit;
  fbRunningEventListEvents := True;
  try
    if Assigned(fBusObjEvent) then begin
        Try
            for x:= 0 to fEventList.Count -1 do begin
              item:= TBusObjEventListItem(fEventList.Items[x]);
              if (not item.done) and (not item.Processing) then begin
                item.Processing  := true;
                fBusObjEvent(item.EventObj, item.EventType, item.EventValue);
                item.Done:= true;
              end;
            end;
            x:= 0;
            while x < fEventList.Count do begin
              if (TBusObjEventListItem(fEventList.Items[x]).Done) and
                  (TBusObjEventListItem(fEventList.Items[x]).Processing) then begin
                fEventList.Delete(x)
              end
              else
                Inc(x);
            end;

  //          for x:= fEventList.Count -1 downto 0 do
  //            if (TBusObjEventListItem(fEventList.Items[x]).Done) and
  //                (TBusObjEventListItem(fEventList.Items[x]).Processing) then
  //                    fEventList.Delete(x);
        Except
          on E:Exception do begin
            log('exeption:'+e.message);
          end;
        End;
    end else if Assigned(Self.Owner) and (Self.Owner is TDatasetBusObj) then
      TDatasetBusObj(Self.Owner).SendAllEvents;

  finally
    fbRunningEventListEvents := False;
  end;
end;

procedure TDatasetBusObj.SendEvent(const aEventType, aEventValue: string; aEventObj :TDatasetBusObj = nil);
begin


  if not Assigned(aEventObj) then aEventObj := Self;

  if Assigned(fBusObjEvent) then begin

    try


      fBusObjEvent(aEventObj, aEventType, aEventValue );

    except
//       on E: Exception do  ShowMessage('event error: ' + E.Message)     ;
//
    end;

    exit;


  end else if Assigned(Self.Owner) and (Self.Owner is TDatasetBusObj) then
    TDatasetBusObj(Self.Owner).SendEvent(aEventType, aEventValue,aEventObj )
  else if (aEventType = BusobjEvent_ToDo) and (aEventValue= BusobjEvent_ProgressbarProgress ) and  assigned(fProgressDialogobj) then begin
    if fsProgressMsg <> '' then fProgressDialogobj.Message := fsProgressMsg;
    fProgressDialogobj.stepit;
  end else if (aEventType = BusobjEvent_ToDo) and (aEventValue= BusobjEvent_ShowProgressbar ) and  assigned(fProgressDialogobj) then begin
    if fsProgressMsg <> '' then fProgressDialogobj.Message := fsProgressMsg;
    if fiProgresscount > fProgressDialogobj.Maxvalue then fProgressDialogobj.Maxvalue :=fiProgresscount;
    fProgressDialogobj.stepit;
  end;


end;

function TDatasetBusObj.TempQry(sql: string): TERPQuery;
begin
  if not Assigned(fTempQry) then begin
    fTempQry := TERPQuery.Create(self);
    fTempQry.Connection := self.Connection.Connection;
  end;
  if fTempQry.Active then fTempQry.Close;
  if SQL <> '' then
    fTempQry.SQL.Text := SQL;
  result := fTempQry;
end;

function TDatasetBusObj.TopLevelBusObj: TDatasetBusObj;
begin
  result:= self;
  while Assigned(result.Owner) and (result.Owner is TDatasetBusObj) do
    result:= TDatasetBusObj(result.Owner);
end;
procedure TDatasetBusObj.TruncateTable;
var
  cmd :TERPCommand;
begin
  try
    if BusObjectTableName = '' then exit;
  Except

  end;
  {outside transaction as truncate commits}
  cmd := DbSharedObj.Getcommand(commondblib.GetSharedMyDacConnection);
  try
    cmd.SQL.text := 'Truncate ' +BusObjectTableName ;
    try
      cmd.Execute;
    Except

    end;
  finally
    DbSharedObj.ReleaseObj(cmd);
  end;
end;

function  TDatasetBusObj.GetXMLNodeStringValue(const Node: IXMLNode; const aNodeName: string): string;
begin
    REsult := commonlib.GetXMLNodeStringValue(Node,aNodeName,XMLFieldNodeExists);
end;

function TDatasetBusObj.heirarchyname(includeDsName:Boolean =true): String;
var
  obj:Tcomponent;
  s:String;
begin
  result := inherited heirarchyname(includeDsName);
  if includeDsName then
    if datasetassigned then begin
      s:= fDataset.name;
      obj := fdataset.owner;
      while obj<> nil do begin
        s := obj.ClassName  + '->' +  s;
        obj := obj.Owner;
      end;
      if fDataset.active  then s:= s +' Active = True' else s:= s +' Active = False';
      if s<> '' then result := result +NL+'(' + s +')';
    end;
end;

function  TDatasetBusObj.GetXMLNodeFloatValue(const Node: IXMLNode; const aNodeName: string): double;
begin
   REsult := commonlib.GetXMLNodeFloatValue(Node,aNodeName,XMLFieldNodeExists);
end;
function  TDatasetBusObj.GetXMLNodeIntegerValue(const Node: IXMLNode; const aNodeName: string): integer;
begin
   REsult := commonlib.GetXMLNodeIntegerValue(Node,aNodeName,XMLFieldNodeExists);
end;
function  TDatasetBusObj.GetXMLNodeBooleanValue (const Node: IXMLNode; const aNodeName: string): boolean;
begin
    REsult := commonlib.GetXMLNodeBooleanValue(Node,aNodeName,XMLFieldNodeExists);
end;
function  TDatasetBusObj.GetXMLNodeDateTimeValue(const Node: IXMLNode; const aNodeName: string): TDateTime;
begin
   REsult := commonlib.GetXMLNodeDateTimeValue(Node,aNodeName,XMLFieldNodeExists);
end;

procedure TDatasetBusObj.SetPropertyFromNode(Const aNode: IXMLNode; Const aPropertyName, aNodeName: string; Const Obj: TObject);
var
  ValNode: IXMLNode;
  PropInfo: PPropInfo;
begin
  ValNode := aNode.ChildNodes.FindNode(LowerCase(aNodeName));
  if Assigned(ValNode) then begin
    try
      { make sure this property is not read only }
      if Assigned(Obj) then
        PropInfo:= GetPropInfo(obj,aPropertyName)
      else
        PropInfo:= GetPropInfo(self,aPropertyName);
      if (not Assigned(PropInfo)) or (not Assigned(Propinfo.SetProc)) then
        exit;

      if ValNode.HasChildNodes and (ValNode.ChildNodes[0].NodeType = ntCData) then begin
        { node has CData sub node }
        if Assigned(Obj) then
          SetPropValue(Obj, aPropertyName, ValNode.ChildNodes[0].NodeValue)
        else
          SetPropValue(self, aPropertyName, ValNode.ChildNodes[0].NodeValue);
      end
      else if (not VarIsNull(ValNode.NodeValue)) then begin
        if Assigned(Obj) then
          SetPropValue(Obj, aPropertyName, ValNode.NodeValue)
        else
          SetPropValue(self, aPropertyName, ValNode.NodeValue);
      end;
    except
      on E: Exception do begin

        raise Exception.Create('Error setting property: ' +
          Self.BusObjectTypeDescription +  ' - ' + aPropertyName + ': ' + E.Message);
      end;
    end;
  end;
end;


procedure TDatasetBusObj.SetPropertyFromNode(Const aNode: IXMLNode; Const aPropertyName: string; Const Obj: TObject);
begin
  SetPropertyFromNode(aNode, aPropertyName, aPropertyName, Obj);
end;

procedure TDatasetBusObj.SetDateTimePropertyFromNode(Const aNode: IXMLNode; Const aPropertyName, aNodeName: string; Const Obj: TObject);
var
  ValNode: IXMLNode;
  dt: TDateTime;
  s, saveDateFormat, saveTimeFormat: string;
begin
  ValNode := aNode.ChildNodes.FindNode(LowerCase(aNodeName));
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then begin
    try
      saveDateFormat := FormatSettings.ShortDateformat;
      saveTimeFormat := FormatSettings.LongTimeFormat;

      FormatSettings.LongTimeFormat := MysqlTimeFormat;
      FormatSettings.LongTimeFormat := replaceStr(FormatSettings.LongTimeFormat , ':' , FormatSettings.TimeSeparator);

      FormatSettings.ShortDateformat := MysqlDateFormat;
      FormatSettings.ShortDateformat := replaceStr(FormatSettings.ShortDateformat , '-' , FormatSettings.DateSeparator);

      try
        s :=ValNode.NodeValue;
        s := replaceStr(s , ':' , FormatSettings.TimeSeparator);
        s := replaceStr(s , '-' , FormatSettings.DateSeparator);
        dt := StrToDateTime(s);
        if Assigned(Obj) then
          SetFloatProp(Obj, aPropertyName, dt)
        else
          SetFloatProp(self, aPropertyName, dt);

      finally
        FormatSettings.ShortDateformat := saveDateFormat;
        FormatSettings.LongTimeFormat  := saveTimeFormat;
      end;
    except
      on E: Exception do begin
        raise Exception.Create('Error setting property: ' +
          Self.BusObjectTypeDescription +  ' - ' + aPropertyName + ': ' + E.Message);
      end;
    end;
  end;
end;

procedure TDatasetBusObj.SetDateTimePropertyFromNode(Const aNode: IXMLNode;  Const aPropertyName: string; Const Obj: TObject);
begin
  SetDateTimePropertyFromNode(aNode, aPropertyName, aPropertyName, Obj);
end;


procedure TDatasetBusObj.SetBooleanPropertyFromNode(Const aNode: IXMLNode; Const aPropertyName, aNodeName: string; Const Obj: TObject);
var
  ValNode: IXMLNode;
begin
  ValNode := aNode.ChildNodes.FindNode(LowerCase(aNodeName));
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then begin
    try
      if Assigned(Obj) then
        SetEnumProp(Obj, aPropertyName, ValNode.NodeValue)
      else
        SetEnumProp(self, aPropertyName, ValNode.NodeValue);
    except
      on E: Exception do begin
        raise Exception.Create('Error setting property: ' +
          Self.BusObjectTypeDescription +  ' - ' + aPropertyName + ': ' + E.Message);
      end;
    end;
  end;
end;

procedure TDatasetBusObj.SetBooleanPropertyFromNode(Const aNode: IXMLNode;  Const aPropertyName: string; Const Obj: TObject);
begin
  SetBooleanPropertyFromNode(aNode, aPropertyName, aPropertyName, Obj);
end;

function TDatasetBusObj.FieldByName(const AFieldName: string): TField;
begin
  if Assigned(fDataSet) then
    Result := fDataSet.FieldByName(AFieldName)
  else
    Result := nil;
end;

class function TDatasetBusObj.FieldData(const aId: integer;
  FieldCommaList: string; Conn: TCustomMyConnection): TJsonObject;
var
  qry: TERPQuery;
begin
  result := JO;
  if Assigned(Conn) then
    qry := DbSharedObj.GetQuery(Conn)
  else
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    if trim(FieldCommaList) = '' then FieldCommaList := '*';
    qry.SQL.Add('select ' + FieldCommaList);
    qry.SQL.Add('from ' + self.GetBusObjectTablename);
    qry.SQL.Add('where ' + self.GetIDField + ' = ' + IntToStr(aId));
    qry.Open;

    DatasetToJson(qry,result.O['Fields']);
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

function TDatasetBusObj.fielddisplaylabel(const FieldName: String): String;
begin
  result := fieldname;
  if not(DatasetAssigned) then exit;
  if dataset.findfield(fieldname) = nil then exit;
  result :=dataset.findfield(fieldname).displaylabel;
end;

function TDatasetBusObj.FieldExists(const fieldname: String): Boolean;
begin
  result:= False;
  try
    if not(Datasetassigned) then exit;
    result:= fDataset.findfield(fieldName)<> nil;
  Except
    // kill the exception
  end;
end;

procedure TDatasetBusObj.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;

  if (AComponent = fDataSet) and (Operation = opRemove) then
    fDataSet := nil;
end;

// -----------------------------------------------------------------------------
{ TBusObj }
// -----------------------------------------------------------------------------

constructor TBusObj.Create(AOwner: TComponent);
begin
  ObjInstanceToCloneisLocal:= False;
  fsAuditLogDetails := '';
  fbLoadXMLinLoad := True;
  fbAddNewWhenCloning := True;
  fiProgresscount := 0;
  fsIteraterecordProgressbarMsg:= '';
  fLoadingCleanXML:= false;
  fsMappedfields4copy :='';
  fsMappedValues4copy := '';
  fsProgressbarmsg:= '';
  //fsDetailMappings:='';
  fsTableName := '';
  fUserVersion := '';
  inherited;
  fTempData:= nil;
  SavingXMLTofile := False;
  ImportingFromXMLFile := False;
  ImportFailed := False;
  FDataSources := TObjectList.Create;
  fCleanXMLDoc:= TXMLDocument.Create(self);
  fCleanXMLDoc.Active := true;
  fLogChangesOnSave:= AppEnv.CompanyPrefs.UseAuditTrail;
  ObjInstanceToClone := nil;
  fsFieldsnotToclone := '';
  fiTranscount := 0;
  foResultNodeParent := nil;
  foResultNode:= nil;
  fConfirmFromGUI := nil;
  DoFieldChangewhenDisabled := False;
  Setlength(LockGroupNamesofCopiedObjs,0);
  fLimitXMLFieldsOnSave:= false;
  if AOwner is TBusObj then fsLockGroupName := TBusobj(AOwner).LockGroupName
  else fsLockGroupName := XMLNodeName;

  {all the property objects should inherit this property from the owner object if the owner is a busobj}
  if Assigned(Self.Owner) then
    if Self.Owner is TBusObj then begin
        XMLOnError := TBusObj(Self.Owner).XMLOnError ;
        fbImportingFromXMLFile  := TBusObj(Self.Owner).ImportingFromXMLFile;
        fbSavingXMLTofile       := TBusObj(Self.Owner).SavingXMLTofile;
    End;
end;

destructor TBusObj.Destroy;
var
    Obj :TComponent;
begin
  try
    if ObjInstanceToCloneisLocal then
      if assigned(ObjInstanceToClone) then
        if ObjInstanceToClone.owner =nil then begin
            Logtext('free Local ObjInstanceToClone :' + classname);
            Freeandnil(ObjInstanceToClone);
        end;
  Except
    // kill exception if ObjInstanceToClone is already freed
  end;
    if fMyDAcDataconnection <> nil then Freeandnil(fMyDAcDataconnection);
    UnlockTables;

      if Assigned(Self.Connection) then
          Connection.RemoveBusObj(TDatasetBusObj(Self));

      if FDataSources <> nil then
        while FDataSources.Count > 0 do
          RemoveDataSource(TBusDataSource(FDataSources.Last));
      if Assigned(fDataset) then begin
          obj := Self;
          while not((Obj is TForm ) or (obj is TDatamodule)  or (Obj = nil )) do
              Obj :=Obj.Owner;
          if Obj <> nil then

            if (Obj.findcomponent(fdataset.name) <> nil) and (not self.fExternalDatasetAssigned) then begin
          end;
      end;
      if Assigned(fConnection) then
        if fConnection.Owner = self then
          Freeandnil(fConnection);

    FreeAndNil(FDataSources);
    fTempData.Free;
    if Assigned(ObjInstanceToClone) then
      if Assigned(ObjInstanceToClone.owner) then else
        try
          Freeandnil(ObjInstanceToClone);
        Except
        end;
    inherited;
end;

procedure TBusObj.DoFieldOnChange(Sender: TField);
begin
  inherited;
  initAuditTrailDetails( ''); // changing any field will set AuditLogDetails to blank
end;

function TBusObj.GetLoadingCleanXML: boolean;
var obj: TBusObj;
begin
  obj:= nil;
  if Assigned(Owner) and (Owner is TBusObj) then begin
    Obj:= TBusObj(Owner);
    while Assigned(obj.Owner) and (obj.Owner is TBusObj) do
      Obj:= TBusObj(Obj.Owner);
  end;
  if Assigned(Obj) then
    result:= Obj.LoadingCleanXML
  else
    result:= fLoadingCleanXML;
end;

function TBusObj.GetOwnerTempData: TJsonObject;
begin
  result:= nil;
  if Assigned(Owner) and (Owner is TBusObj) then
    result:= TBusObj(Owner).TempData;
end;

Procedure TBusObj.UnlockTables;
begin
  if Assigned(fUserLock) then
    UserLock.Unlock(LockGroupName);
end;
Function TBusobj.GetCleanID:Integer;
begin
  Result := GetXMLNodeIntegerValue(CleanXMLNode, IDTagInXML);
end;

function TBusObj.GetBookmarkRec(var Rec: TBookmarkRec; DisableFilter: Boolean=False): Boolean;
begin
  Result := False;
  if Assigned(fDataset) and fDataset.Active then begin
    try
      PostDB;
    except
      Exit;
    end;
    Rec.IsFiltered:= fDataset.Filtered;
    Rec.EmptyDataset := (fDataset.Recordcount = 0);
    Rec.Bookmark:= fDataset.GetBookmark;
    try
      fDataset.DisableControls;
      if DisableFilter then begin
        Rec.fDisableFilter := True;
        fDataset.Filtered := False;
// NOTE: this was removed as it was causing container to be Destroyed and
//       recreated during Save of business object, don't think we need to
//       close open table just because filtering is turned on/off
//        RefreshDB;
      end;
      Result := True;
    except
      on E: Exception do RestoreBookmarkRec(Rec,False);
    end;
  end;
end;
procedure TBusObj.RestoreBookmarkRec(const Rec: TBookmarkRec; Const Abort:Boolean);
begin
  try
    if Assigned(fDataset) and fDataset.Active then begin
      try
        fDataset.EnableControls;
      except
      end;
      if not Rec.EmptyDataset then begin
        try
          if fDataset.BookmarkValid(Rec.Bookmark) then
            If not Abort then fDataset.GotoBookmark(Rec.Bookmark);
          fDataset.FreeBookmark(Rec.Bookmark);
        except
        end;
      end;
      if Rec.fDisableFilter then
          fDataset.Filtered := Rec.IsFiltered;
    end;
  except
  end;
end;

Function  TBusObj.DeleteAll(AddDeletedItem: boolean):Boolean;
var
  msg: string;
begin
  Result:= True;
  try
    if (fDataset.Recordcount < 1) then Exit;
    fDataset.First;
    while not fDataset.EOF do begin
      SendEvent(BusobjEvent_Event, BusObjEventVal_Deleted,self );
      if AddDeletedItem then begin
        if not TDeletedItem.AddDeleted(self,msg) then begin
          result := false;
          ResultStatus.AddItem(false,rssError,0,msg);
          exit;
        end;
        fDataset.First;
      end
      else
        fDataset.Delete;
    end;
    REsult := TRue;
  Except
    on E:Exception do begin
      Result:= False;
    end;
  end;
end;
Procedure TBusObj.ReGenerateNumber(aFieldName:String; aGAP :Integer);
var
  qry: TERPQuery;
//  ino :Integer;
begin
  if  dataset.findfield(afieldname) = nil then exit;
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Connection.Connection);
  try

    qry.SQL.text :=  'Select @rownum:=@rownum+ '+inttostr(aGAP)+', ' +IDfieldname +' , ' + aFieldName +
                      ' from '+ Busobjecttablename +', (SELECT @rownum:=0) r ' +
                      ' Where ' + SQLSelect +
                      ' order by '+ aFieldName ;
    qry.open;
    qry.Close; // the @rownum variable some times doesn't populate the first time , but does second time :(
    qry.Open;
    if qry.recordcount >1 then begin

      qry.First;
      While qry.EOF = False do begin
        if dataset.locate(IDfieldname , qry.fieldbyname(IDfieldname).asInteger , []) then begin
          EditDB;
          dataset.fieldbyname(afieldname).asInteger :=Qry.fields[0].asInteger;
          if Dataset.State in [dsEdit,dsInsert] then Dataset.Post;
          OnReGenerateNumber;
        end;
        qry.Next;
      end;

    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;



procedure TBusObj.RunProc(CallbackFunc :TBusObjProc; DisableFilter: boolean = false);
var
  bm: TBookmarkRec;
begin
  if GetBookmarkRec(bm, DisableFilter) then try
    if Assigned(CallbackFunc) then CallbackFunc(Self);
  finally
    RestoreBookmarkRec(bm,False);
  end;
end;


{this procedure is calling the object's procedure with 2
Parameters - the object and a boolean variable to stop the iteration if any
thing wrong with the current record. the variable was called 'continue' here
and the object calling it as 'Abort' and the object is seting this to 'True'
here checking for False to stop the looping. so changed the variable name here
to 'Abort' and stoped when its false. Please change it if u find any object
using it the otherway}
procedure TBusObj.IterateRecords(CallbackFunc: TBusObjCallbackProc; DisableFilter: boolean = false; doShowProgressbar:boolean = False);
var
  bm: TBookmarkRec;
  Abort: boolean;
begin
  if not Assigned(fDataset) or not fDataset.Active  then
    Exit;
  if (fDataset.Recordcount < 1) then Exit;

  if GetBookmarkRec(bm, DisableFilter) then try
    fDataset.First;
    SendEvent(BusobjEvent_Event, BusobjEvent_IteratereRecords, Self);
    //if doShowProgressbar then ShowProgressbar;
    while not fDataset.EOF do begin
      //Continue:= true;
      Abort := False;
      //if Assigned(CallbackFunc) then CallbackFunc(Self, Continue);
      if Assigned(CallbackFunc) then CallbackFunc(Self, Abort);
      SendEvent(BusobjEvent_Event, BusobjEvent_IteratereRecordLoop, Self);
      //if doShowProgressbar then StepProgressbar;
      //if not Continue then Break;
      if Abort then Break;
      fDataset.Next;
    end;
  finally
    //if doShowProgressbar then hideProgressbar;
    RestoreBookmarkRec(bm,Abort);
    SendEvent(BusobjEvent_Event, BusobjEvent_IteratereRecordDone, Self);
  end;
end;
procedure TBusObj.IterateRecordsReverse(CallbackFunc: TBusObjCallbackProc; DisableFilter: boolean = false);
var
  bm: TBookmarkRec;
  Abort: boolean;
begin
  if not Assigned(fDataset) or not fDataset.Active  then
    Exit;
  if (fDataset.Recordcount < 1) then Exit;

  if GetBookmarkRec(bm, DisableFilter) then try
    fDataset.Last;
    SendEvent(BusobjEvent_Event, BusobjEvent_IteratereRecords, Self);
    while not fDataset.BOF do begin
      //Continue:= true;
      Abort := False;
      //if Assigned(CallbackFunc) then CallbackFunc(Self, Continue);
      if Assigned(CallbackFunc) then CallbackFunc(Self, Abort);
      SendEvent(BusobjEvent_Event, BusobjEvent_IteratereRecordLoop, Self);
      //if not Continue then Break;
      if Abort then Break;
      fDataset.Prior;
    end;
  finally
    RestoreBookmarkRec(bm,Abort);
    SendEvent(BusobjEvent_Event, BusobjEvent_IteratereRecordDone, Self);
  end;
end;

function TBusObj.GetXMLDoc: TXMLDocument;
var
  node: IXMLNode;
//  json: TJsonObject;
//  t1,t2: TDateTime;
begin
//  t1:= now;
  If not Assigned(fXMLDoc) then Begin
    fXMLDoc := TXMLDocument.Create(self);
  end else Begin
    fXMLDoc.XML.Clear;
  end;

    fXMLDoc.Active := true;
    fXMLDoc.Version := XMLDocVersion;
    fXMLDoc.Encoding := XMLDocEncoding;
    { NOTE: Do not use doNodeAutoIndent option as this stuffs up XML
           comparison in business objects (indents are returned as Text nodes) }
    //doc.Options := doc.Options + [doNodeAutoIndent];
    node:= fXMLDoc.AddChild(XMLDocRoot);
    node.Attributes['DataVersion'] := getUserVersion;
    node := node.Addchild(XMLDocRequest);
    //node.Attributes['OnError'] := XMLDocRequestStopError;
    node.Attributes['DataObject'] := Copy(ClassName,2,Length(ClassName));
    node:= node.AddChild(XMLNodeName);
    if Dataset.REcordcount > 0 then
      SaveToXMLNode(node); // IF RECORDSET IS BLANK , THERE IS NOTHING TO BE STORED
    result:= fXMLDoc;
//  t1:= now - t1;
//  t2:= now;
//  json:= TJsonObject.Create;
//  try
//    JsonToBusObj.BusObjectToJson(self,json,true);
//    t2:= now-t2;
//    json.S['Time-XML']:= FormatDateTime('hh:nn:ss-zzz',t1);
//    json.S['Time-JSON']:= FormatDateTime('hh:nn:ss-zzz',t2);
//    json.SaveToFile('c:\temp\JSON_' + Self.ClassName + '_' + IntToStr(Id) + '.txt');
//  finally
//    json.Free;
//  end;
end;


procedure TBusObj.HideProgressbar;
begin
  SendEvent(BusobjEvent_ToDo, BusobjEvent_HideProgressbar, Self);
end;
procedure TBusObj.showProgressbar(aProgresscount:Integer; aProgressMsg:String = '');
begin
  fiProgresscount := aProgresscount;
  fsProgressMsg := aProgressMsg;
  SendEvent(BusobjEvent_ToDo, BusobjEvent_ShowProgressbar, Self);
end;
procedure TBusObj.stepProgressbar(const aProgressMsg:String = '');
begin
  fsProgressMsg := aProgressMsg;
  SendEvent(BusobjEvent_ToDo, BusobjEvent_ProgressbarProgress, Self);
end;

function TBusObj.GetXML: string;
begin
  result:= XMLDoc.XML.Text;
end;

procedure TBusObj.SetXML(const Value: string);
var
  Doc: IXMLDocument;
  node: IXMLNode;
begin
  node := nil;
  doc:= TXMLDocument.Create(nil);
  try
    doc.LoadFromXML(Value);
    doc.Active:= true;
//    node:= doc.ChildNodes.FindNode(XMLDocRoot);
//    if Assigned(node) then
//    begin
//      node:= node.ChildNodes.FindNode(Copy(Self.ClassName,2,Length(ClassName)));
//      if Assigned(node) then
//        LoadFromXMLNode(node);
//    end;
    if doc.ChildNodes.FindNode(XMLDocRoot) <> nil then begin
       node:= doc.ChildNodes.FindNode(XMLDocRoot);
        if node.AttributeNodes.FindNode('DataVersion')<> nil  then
            fsXMLDataVersion    := node.Attributes['DataVersion'];
    end;
    fsXMLOnError := 'Stop';
    if node.ChildNodes.FindNode(XMLDocRequest) <> nil then begin
        node:= node.ChildNodes.FindNode(XMLDocRequest);
        if node.AttributeNodes.FindNode('OnError')<> nil  then
            fsXMLOnError        := node.Attributes['OnError'];
        if node.AttributeNodes.FindNode('DataObject')<> nil  then
            fsXMLSourceObject   := node.Attributes['DataObject'];
    end;
    node:= node.ChildNodes.FindNode(XMLNodeName);
    {XML should have the root , xml request before the actual note. }
    if not Assigned(node) then begin
        Resultstatus.AddItem(False , rssError , BOR_XMLImport_ObjectNodeNotfound, XMLNodeName + ': Invalid XML format' , False);
        Exit;
    end;

    //LoadFromXMLNode(node);
    ImportFromXML(node);

  finally
//    Doc.free;
  end;
end;



Procedure TBusObj.LoadFromXMLNode(const node: IXMLNode);
begin

end;

Function TBusObj.ImportsubClasses(const node: IXMLNode):Boolean;
begin
  REsult := True;
end;

Function TBusObj.ExportsubClasses(const node: IXMLNode):Boolean;
begin
  REsult := True;
end;

Procedure TBusObj.LocateXMLRecord;
    Procedure SearchRecord(const whereClause :String);
    var
      strSQL :String;
    begin
        strSQl := uppercase(SQL);
        if Pos('WHERE' , strSQL ) <> 0 then strSQL := copy(strSQL , 1, Pos('WHERE' , strSQL )-1)
        else if Pos('GROUP' , strSQL ) <> 0 then strSQL := copy(strSQL , 1, Pos('GROUP' , strSQL )-1)
        else if Pos('ORDER' , strSQL ) <> 0 then strSQL := copy(strSQL , 1, Pos('ORDER' , strSQL )-1)
        else if Pos(';' , strSQL ) <> 0 then strSQL := copy(strSQL , 1, Pos(';' , strSQL )-1);
        strSQL := strSQL + ' WHERE ' + whereClause;
        With getNewDataset(strSQL) do try
            fiRecordcount := REcordcount;
        Finally
            Close;
            Free;
        end;
    end;
begin
    fiRecordcount := 0;
    {search for the global ref instead of ID}
    if fsLocateXMLRecordglobalRef <> '' then begin
        SearchRecord('globalRef = ' + QuotedStr(fsLocateXMLRecordglobalRef));
        if fiREcordcount <> 0 then Exit;
    end;
    {if XML has the ID, then should be searched on the ID}
    if fiLocateXMLRecordID <> 0 then begin
        SearchREcord(IDFieldName + '='  + IntToStr(fiLocateXMLRecordID));
        if fiRecordcount <> 0 then Exit;
    end;
    {if Id doesn;t exists or the record not found for the Id, then search for the search string}
    if XMLSearchRecord = '' then Exit;
    SearchRecord(XMLSearchRecord );
end;

Procedure TBusObj.ErrRecordNotfound(const Keyname, KeyValue:String);
var
    s :String;
begin
    if KeyValue = '' then
        s := 'Foreign Key '+KeyName + '(' + QuotedStr(KeyValue) + ') is blank.'
    else
        s := 'Foreign Key '+KeyName + '(' + QuotedStr(KeyValue) + ') doesn''t exist.';
    self.ResultStatus.AddItem(false, rssError, BOR_XMLImport_RecordNotFound, s , False);

end;

class function TBusObj.IsUnique(const RecordID: Integer;
                                const UniqueCheckStatement: string;
                                Connection: TCustomMyConnection = nil): Boolean;
var
  qry: TMyQuery;
begin
  qry:= TMyQuery.Create(nil);
  try
    if Assigned(Connection) then qry.Connection:= Connection
    else qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select ' + GetIDField + ' from ' + GetBusObjectTablename);
    qry.SQL.Add('where ' + UniqueCheckStatement);
    qry.SQL.Add('and ' + GetIDField + ' <> ' + IntToStr(RecordID));
    qry.Open;
    result:= qry.IsEmpty;
  finally
    qry.Free;
  end;
end;

Function  TBusObj.ImportFromXML(const node: IXMLNode):Boolean;
var
    s:String;
    IDValue : String;
begin
    REsult := False;
    ImportFailed :=False;
    if not importingfromXMLFile then begin
        LoadFromXMLNode(node);
        Exit;
    end;

    {xml Validation}
//    fsXMLType           := node.Attributes['Type'];
    if node.Attributes['Type'] <> null then fsXMLType           := node.Attributes['Type'];
    if fsXMLType = '' then fsXMLType := XMLCommandNew; // if type not given its add new
    if REsultNode <> nil then
        AddXMLNode(ResultNode ,'RecordType' , fsXMLType);
        //REsultNode.Attributes['RecordType']  := fsXMLType;
    ResultStatus.Clear;
    Try


        if node.childNodes.findNode(IDTagInXML) <> nil then IDValue := IDFieldName +':' + GetXMLNodeStringValue(Node, IDTagInXML);

            {Export type documents cannot be imported}
        if XMLType = XMLCommandExport then begin
            s :='Type should be ' + QuotedStr(XMLCommandNew) + ', ' + QuotedStr(XMLCommandModify) + ' or ' + QuotedStr(XMLCommandDelete) +'.';
            Resultstatus.AddItem(False , rssWarning , BOR_XMLImport_Wrongtype, s , False);
            ImportFailed := True;
            Exit;
        end;

        {any type other than add or edit or delete to import should be ignored}
        if (XMLType <> XMLCommandNew) and (XMLType <> XMLCommandModify) and (XMLType <> XMLCommandDelete) then begin
            s:= 'Unknown Type.  Type should be ' + QuotedStr(XMLCommandNew) + ', ' + QuotedStr(XMLCommandModify) + ' or ' + QuotedStr(XMLCommandDelete) +'.';
            Resultstatus.AddItem(False , rssWarning , BOR_XMLImport_UnknownType, s , False);
            ImportFailed := True;
            Exit;
        end;

        {check for the access level}
        if (XMLType = XMLCommandNew) or (XMLType = XMLCommandUpdate) then
            if AccessManager.AccessLevel > 3 then begin
                s := 'No Access';
                Resultstatus.AddItem(False , rssWarning , BOR_XMLImport_UnknownType, s , False);
                ImportFailed := True;
                Exit;
            end;
        if XMLType = XMLCommandModify then
            if AccessManager.AccessLevel >= 3  then begin
                s := 'No Access';
                Resultstatus.AddItem(False , rssWarning , BOR_XMLImport_UnknownType, s , False);
                ImportFailed := True;
                Exit;
            end;

        if (XMLType = XMLCommandDelete) then
            if AccessManager.AccessLevel >= 2  then begin
                s := 'No Access';
                Resultstatus.AddItem(False , rssWarning , BOR_XMLImport_UnknownType, s , False);
                ImportFailed := True;
                Exit;
            end;

        if not ImportFailed then
            ImportFailed := not ValidateXMLData(node);
        if XMLSearchRecordDesc <> '' then
            AddXMLNode(REsultNode , 'Identification',XMLSearchRecordDesc);
        if ImportFailed then Exit;

        Connection.BeginNestedTransaction;
        Try
            if XMLType = XMLCommandNew then begin
                if fiRecordcount > 0 then begin
                    s := 'Record already Exists' ;
                    Resultstatus.AddItem(False , rssWarning , BOR_XMLImport_RecordalreadyExists, s , False);
                    ImportFailed := True;
                    Exit;
                end;
                New;
                //if Assigned(node.ChildNodes.FindNode(XMLNodeName)) then
                LoadFromXMLNode(node);
            end;
            if XMLType = XMLCommandUpdate then begin
                    if fiRecordcount = 0 then New
                    Else LoadSelect(fsXMLSearchRecord);
                LoadFromXMLNode(node);
            end;
            if XMLType = XMLCommandModify then begin
                    if fiRecordcount = 0 then begin
                        s := XMLNodeName + '(' +XMLSearchRecord + '): Record not found to change' ;
                        //AddXMLNode(REsultNode , 'ImportError','Record not found to change');
                        Resultstatus.AddItem(False , rssWarning , BOR_XMLImport_RecordNotFound, s , False);
                        ImportFailed := True;
                        Exit;
                    end;
                LoadSelect(fsXMLSearchRecord);
                LoadFromXMLNode(node);
            end;
            if (XMLType = XMLCommandDelete) or (XMLType = XMLCommandRestore) then begin
                    if fiRecordcount = 0 then begin
                        s := XMLNodeName + '(' +XMLSearchRecord  +'): Record not found to Delete' ;
                        //AddXMLNode(REsultNode , 'ImportError','Record not found to Delete');
                        Resultstatus.AddItem(False , rssWarning , BOR_XMLImport_RecordNotFound, s , False);
                        ImportFailed := True;
                        Exit;
                    end;
                LoadFromXMLNode(node);
                LoadSelect(fsXMLSearchRecord);
                DeleteRecord(XMLType = XMLCommandDelete);
            end;
            Try
                if ValidateData then
                    PostDB
                Else
                    ImportFailed := True;
            Except
                on E:Exception do begin
                    Resultstatus.AddItem(False , rssWarning , 0 , XMLNodeName + '(' +XMLSearchRecord  +'):' + E.Message , False);
                    //AddXMLNode(REsultNode , 'ImportError',E.Message);
                    Exit;
                end;
            end;

            {handle the sub classes}
            if ImportFailed then Exit;
            ImportsubClasses(node);

            {Save if everything is ok}
            Try
                if Save then REsult := True else ImportFailed := true;
            Except
                on E:Exception do begin
                    Resultstatus.AddItem(False , rssError , 0 , XMLNodeName + '(' +XMLSearchRecord  +'):' + E.Message , False);
                    //AddXMLNode(REsultNode , 'ImportError',E.Message);
                end;
            end;
        Finally
            if ImportFailed then connection.RollbackNestedTransaction;
        end;
    Finally
       Resultstatus.AddMessageToXMLNode(ResultNode);
    End;
end;
procedure TBusObj.InactivateAll;
begin
  IterateRecordsReverse(InactivateAllCallback, true);
end;
Procedure TBusObj.InactivateAllCallback(Const Sender: TBusObj; var Abort: boolean);
begin
  stepProgress;
  DeleteRecord(true);
end;
procedure TBusObj.initAuditTrailDetails(const Value: String);
begin
  fsAuditLogDetails:= Value;
  SendEvent(BusobjEvent_Event , BusObjEvent_onauditTrail , self);
end;

Procedure TBusObj.DeleteRecord(Const Value :Boolean = true) ;
begin
    if not dataset.Active then Exit;
    if Dataset.findField('Active') <> nil then begin
      postdb;
      if Dataset.REcordcount = 0 then Exit;
      EditDB;
      Dataset.fieldByname('Active').asBoolean := not Value;
      PostDB;
    end;
    if Dataset.findField('Deleted') <> nil then begin
      postdb;
      if Dataset.REcordcount = 0 then Exit;
      EditDB;
      Dataset.fieldByname('Deleted').asBoolean := Value;
      PostDB;
    end;
end;

procedure TBusObj.AddXMLHeaderNode(const node: IXMLNode);
begin
  Try
    {Setting the property for the sub properties like PriceMatrix in ProductObj}
    if Assigned(Self.Owner) then
      if Self.Owner is TBusObj then
          Self.SavingXMLTofile            := TBusObj(Self.Owner).SavingXMLTofile;
//    node.Attributes['Type']               := XMLCommandExport;
    //if not SavingXMLTofile then // Id should exists for the modifcation purpose when it gets back
      //node.AddChild(IDTagInXML).NodeValue   := ID;
      AddXMLNode(node,IDTagInXML,ID);
  Except
      // business objects are supposed to have an Id field,
      // failing which will create an exception and kill that exception
      // this will happen if an obect of TBusObj is created. TbusObj is supposed to be
      // an abstract class and should not create any object of it.
  end;
end;

procedure TBusObj.SaveToXMLNode(const node: IXMLNode);
begin
  AddXMLHeaderNode(node);
end;

procedure TBusObj.InitializeNewObject;
begin
  { Override in descendants to initilise data. }
end;

procedure TBusObj.RemoveDataSource(Const DataSource: TBusDataSource);
begin
  FDataSources.Remove(DataSource);
  DataSource.Dataset := nil;
  DataSource.BusObj := nil;
end;


procedure TBusObj.AddDataSource(Const DataSource: TBusDataSource);
begin
  FDataSources.Add(DataSource);
end;

Procedure TBusObj.RefreshDB;
begin
  ResultStatus.Clear;
  Closedb;
  ReleaseFieldEvents;
  ReleaseDatasetEvents;
  OpenDB;
end;

Procedure TBusObj.Opendb;
begin
    Load;
    OnDataIdChange(dcLoad);
end;

function TBusObj.PropertyExists(const PropName: String): Boolean;
begin
  REsult := Assigned(GetPropInfo(Self,Propname));
end;

Procedure TBusObj.Closedb;
begin
  if DatasetActive then begin
    fDataSet.Close;
    ResultStatus.Clear;
    OnDataIdChange(dcClose);
  end;
end;

Procedure TBusObj.SetActive(Const Value :Boolean);
begin
  if Value then
    OpenDB
  else
    CloseDB;
end;

function TBusObj.GetActive: Boolean;
begin
  result:= false;
  if Assigned(fDataset) then
    result:= fDataset.Active;
end;

function TBusObj.getAllIDs: String;
begin
  fsAllIds:= '';
  Iteraterecords(AllIdsCallback);
  result:= fsAllIds;
end;
Procedure TBusObj.AllIdsCallback(Const Sender: TBusObj; var Abort: boolean);
begin
     if fsAllIds <> '' then fsAllIds := fsAllIds +',';
     fsAllIds := fsAllIds + inttostr(ID);
end;
Procedure TBusObj.AfterDatasetCreated;
var
    i:Integer;
begin
    if FDataSources.Count > 0 then
    for i:= 0 to  FDataSources.Count -1 do
        TBusDatasource(FDataSources[i]).SetDataset(fDataset);
end;

function TBusObj.GetCleanXMLDoc: TXMLDocument;
begin
  result:= fCleanXMLDoc;
end;
Class Function TBusObj.XMLBranchName :String;
begin
  result:= LowerCase(Copy(self.classname,2,Length(self.classname))+'s');
end;

Function TBusObj.getResultNode:IXMLNode;
begin
    Result := nil;
    if assigned(foResultNode) then begin
        Result := foREsultNode ;
        Exit;
    end;
    if not Assigned(foREsultNodeParent) then begin
        if assigned(Self.Owner) then
            if Self.Owner is TBusObj then
                if assigned(TBusobj(self.Owner).REsultNode) then
                    foREsultNodeParent :=TBusobj(self.Owner).REsultNode;
    end;
    if Assigned(foREsultNodeParent) then begin
        foREsultNode := foREsultNodeParent.Addchild(Self.XMLNodeName);
        REsult := foREsultNode;
        Exit;
    end;
end;

function TBusObj.GetSharedMyDAcDataconnection: TMyDAcDataconnection;
begin
  if Assigned(Owner) and (Owner is TBusObj) then begin
    result := TBusObj(Owner).GetSharedMyDAcDataconnection;
  end else begin
      if fMyDAcDataconnection = nil then begin
        fMyDAcDataconnection := TMyDAcDataconnection.Create(Self);
        fMyDAcDataconnection.connection := GetSharedMyDacConnection;
      end;
      result := fMyDAcDataconnection;
  end;
end;

procedure TBusObj.Load(const fIsReadonly:boolean = False);
begin
  inherited;

  if ResultStatus.HasError then begin
    raise Exception.Create(XMLNodeName + ' ' + ResultStatus.Messages);
  end;
  {this loads the clean fields after load}
  {XML should be loaded only for the main object }
  if IsReadonly then begin
  end else if not(LoadXMLinLoad) then begin
  end else
    if (Assigned(Self.Owner)) and (Self.Owner is TBusobj) then
    else
        Try
          if assigned(fCleanXMLDoc) then fCleanXMLDoc.ChildNodes.Clear;
          LoadingCleanXML:= true;
          try
            fCleanXMLDoc.XML.Text:= XMLDoc.XML.Text;
            fCleanXMLDoc.Active:= true;
//            fCleanXMLDoc.SaveToFile('c:\temp\temp.xml');
          finally
            LoadingCleanXML:= false;
          end;
        Except
            // Creates an exception if the object doesn;t have an Id
            // eg: object of TBusObj directly.
        end;
end;


function TBusObj.Save: boolean;
begin
  result:= inherited Save;
  try
  if fLogChangesOnSave then
    CompareXMLDocs(CleanXMLDoc, XMLDoc);
  Except
    on E:EXception do begin
      if devmode then
        ResultStatus.AddItem(False, rsswarning, 0 , 'Auditing Failed: ' + E.Message);
      // ignore the exception
    end;
  end;
end;

Function TBusObj.CopyTrans(const Changefield :String; const ChangeValue :Variant; const SaveAfterCopy :boolean = True; const FilterFields :String = ''):TBusObj;
begin
    CopyingTrans := True;
    try
        Result := Self.CloneBusObj(ChangeField,ChangeValue, SaveAfterCopy,FilterFields) ;
    finally
        CopyingTrans:= False;
    end;
end;

procedure TBusObj.GetPropertyXMLCallback(Const Sender: TBusObj; var Abort: boolean);
var
    aNode :IXMLNode;
begin
  Try
    aNode :=TBusObj(Sender).XMLPropertyNode;
    aNode := anode.AddChild(TBusObj(Sender).XMLPropertyName);
    Sender.SaveToXMLNode(aNode);
  Except
    on E:Exception do begin
        ResultStatus.AddItem(False, rssError , 0 , E.Message );
    end;
  End;
End;

function TBusObj.getUserVersion:String;
begin
  If (fUserVersion='') then Begin
    With GetNewDataset('SELECT Version  FROM tblUpdateDetails where Current = "T" ') do Try
        if Recordcount > 0 then
            fUserVersion := FieldByname('Version').asString;
    Finally
        Close;
        Free;
    End;
  end;
  Result := fUserVersion;
end;

Procedure TBusObj.CopyPropertyObjects(const Mappedfields :STring);
begin
    //descendants should implement if applicable
end;

Procedure TBusObj.AfterCopy;
begin
    //descendants should implement if applicable
end;

procedure TBusObj.BusObjCopy(Const Sender: TBusObj; var Abort: boolean);
var
    ctr:Integer;
    lst: TStringList;
    FromField, Tofield :TField;
    fiPartsId :Integer;
    fiClassId :Integer;
    SourceObj, TargetObj :TBusObj;
begin
    Try
      if not Assigned(ObjInstanceToClone) then Exit;
      lst := TStringList.Create;
      try
          SourceObj := Sender;
          TargetObj := Sender.ObjInstanceToClone;

          lst.commaText:= SourceObj.Mappedfields4copy;
          if TargetObj.dataset.active = False then TargetObj.Load(0);
          if TargetObj.accessmanager.accesslevel = 3 then TargetObj.accessmanager.accesslevel:= 2;
          TargetObj.New;
          TargetObj.IgnoreAccesslevel := True;
//          TargetObj.silentMode := true;

          {mapped fields}
          for ctr := 0 to lst.Count - 1 do begin
              Tofield       :=TargetObj.Dataset.FindField(ExtractStrPortion(lst.Strings[ctr], '=', 2));
              FromField     :=SourceObj.Dataset.FindField(lst.Names[ctr]);
              TargetObj.Editdb;
              Movefield(FromField, Tofield);
          end;



//          {get the accountId default from companypref}
//          if TargetObj.Dataset.FindField('AccountID') <> nil then begin
//            TargetObj.EditDB;
//            TargetObj.Dataset.fieldbyname('AccountID').AsInteger := AppEnv.CompanyPrefs.DefaultSalesAccount;
//          end;

          {product properties default value from parts}
          if SourceObj.Dataset.FindField('PartsId') <> nil then  fiPartsId := SourceObj.Dataset.fieldbyname('PartsId').AsInteger
          else if SourceObj.Dataset.FindField('productId') <> nil then fiPartsID := SourceObj.Dataset.fieldByname('ProductId').AsInteger
          else fiPartsId := 0;
          if fiPartsID <> 0 then
              with getNewDataset('SELECT IncomeAccnt, AssetAccnt, COGSAccnt, PartType, PreferedSupp ' +
                                  ' FROM tblParts WHERE PartsID =' + IntToStr(fiPartsID)) do try
                  if recordcount > 0 then begin
                      if TargetObj.Dataset.FindField('IncomeAccnt') <> nil then begin
                        TargetObj.EditDB;
                        TargetObj.Dataset.fieldbyname('IncomeAccnt').asString := fieldByname('IncomeAccnt').asString;
                      end;
                      if TargetObj.Dataset.FindField('AssetAccnt') <> nil then begin
                        TargetObj.EditDB;
                        TargetObj.Dataset.fieldbyname('AssetAccnt').asString := fieldByname('AssetAccnt').asString;
                      end;
                      if TargetObj.Dataset.FindField('COGSAccnt') <> nil then begin
                        TargetObj.EditDB;
                        TargetObj.Dataset.fieldbyname('COGSAccnt').asString := fieldByname('COGSAccnt').asString;
                      end;
                      if TargetObj.Dataset.FindField('PartType') <> nil then begin
                        TargetObj.EditDB;
                        TargetObj.Dataset.fieldbyname('PartType').asString := fieldByname('PartType').asString;
                      end;
                      if TargetObj.Dataset.FindField('SupplierID') <> nil then begin
                        if TargetObj.ClassNameIs('TSmartOrderLine') then begin
                          { ensure only active suppliers on Smart Order }
                          if SourceObj.Dataset.FindField('supplierID') <> nil then begin
                            if TcDataUtils.ClientIsActive(SourceObj.Dataset.fieldByname('SupplierId').AsInteger) then begin
                              TargetObj.EditDB;
                              TargetObj.Dataset.fieldbyname('supplierId').AsInteger := SourceObj.Dataset.fieldByname('SupplierId').AsInteger;
                            end;
                          end
                          else if FieldByname('PreferedSupp').asString <> '' then begin
                            TargetObj.EditDB;
                            TargetObj.Dataset.fieldbyname('supplierId').AsInteger := tcdatautils.GetClientID(FieldByname('PreferedSupp').asString,true);
                          end;
                        end
                        else begin
                          if SourceObj.Dataset.FindField('supplierID') <> nil then begin
                            TargetObj.EditDB;
                            TargetObj.Dataset.fieldbyname('supplierId').AsInteger := SourceObj.Dataset.fieldByname('SupplierId').AsInteger;
                          end
                          else if FieldByname('PreferedSupp').asString <> '' then begin
                            TargetObj.EditDB;
                            TargetObj.Dataset.fieldbyname('supplierId').AsInteger := tcdatautils.getclientID(FieldByname('PreferedSupp').asString);
                          end;
                        end;
                      end;
                  end;
              finally
                  if Active then Close;
                  Free;
              end;
          {default classid from preference}
          ficlassId:= 0;
          if TargetObj.Dataset.FindField('ClassId') <> nil then begin
              if SourceObj.Dataset.FindField('classId') <> nil then fiClassId := SourceObj.Dataset.fieldByname('ClassId').AsInteger
              else if ficlassId = 0 then fiClassId := AppEnv.DefaultClass.ClassID;
              TargetObj.EditDB;
              TargetObj.Dataset.fieldbyname('ClassId').AsInteger := fiClassId;
          end;
          {mapped values - runtime substitution}
          lst.Commatext := SourceObj.MappedValues4copy;
          for ctr := 0 to lst.Count - 1 do begin
              Tofield   :=TargetObj.Dataset.FindField(lst.Names[ctr]);
              TargetObj.Editdb;
              Movefield(Tofield, ExtractStrPortion(lst.Strings[ctr], '=', 2));
          end;

          TargetObj.PostDB;

          {source object is converted}

          if SourceObj.Dataset.FindField('converted') <> nil then begin
            if SourceObj.FieldByName('converted').AsBoolean = False then begin
              SourceObj.EditDB;
              SourceObj.FieldByName('converted').AsBoolean := true;
              SourceObj.PostDB;
            end;
          end;
      finally
          freeandNil(lst);
      end;
    except
      on E:Exception do begin
          Abort := True;
      end;
    end;
end;

function TBusObj.BusobjMessageDlg(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Integer; const Owner: TComponent;
  const CustomButtonsStr: String): Word;
begin
  result := 0;
  if SilentMode then
    SendEvent(BusobjEvent_MsgLog , Self.classname +':'+ Msg , self)
  else result := MessageDlgXP_Vista(Msg,DlgType,Buttons,HelpCtx,Owner,'','',false,nil,CustomButtonsStr);
end;

function TBusObj.CopyUsingTransactionMaper(const CopyToType:String; const SaveAfterCopy : Boolean = True):TBusObj;
var
    strSQL :STring;
    bAbort :boolean;
begin
    Result := nil;
    ObjInstanceToClone := TMsbusobj(GetComponentByClassName(CopyTotype, False, nil , False));

    if ObjInstanceToClone.Accessmanager.Accesslevel >2 then begin
      ResultStatus.additem(True, rssError ,0,'Conversion of ' + replacestr(Self.BusObjectTypeDescription,' Object' , '') +' to ' + REplacestr(ObjInstanceToClone.BusObjectTypeDescription,' Object' , '')+' failed.' + NL+NL+
                              ObjInstanceToClone.NoRigtsMsg('Create New'));
      exit;
    end;

    ObjInstanceToClone.connection := Self.Connection;
    strSQL := ' SELECT MasterMappings, DetailMappings ' +
              ' FROM tblTransactionMapper  ' +
              ' WHERE (FromTranType =' + QuotedStr(convertiontype) + ')' +
              ' and (ToTranType = ' +  QuotedStr(TBusObj(ObjInstanceToClone).XMLNodeName) +')';
    With getnewDataset(strSQL) do try
        Mappedfields4copy:=FieldByName('MasterMappings').AsString;
        Dataset.first;
        while Dataset.Eof = False do begin
            BusObjCopy(self , bAbort);
            if bAbort then Exit;
            CopyPropertyObjects(FieldByName('DetailMappings').AsString);
            Dataset.Next;
        end;
        ObjInstanceToClone.AfterCopy;
        if SaveAfterCopy then begin
          ObjInstanceToClone.Save;
          Setlength(LockGroupNamesofCopiedObjs , Length(LockGroupNamesofCopiedObjs)+1);
          LockGroupNamesofCopiedObjs[high(LockGroupNamesofCopiedObjs)]:=ObjInstanceToClone.LockGroupname;
        end;
    finally
        if active then close;
        Free;
    end;
    REsult := ObjInstanceToClone;
end;

Procedure TBusObj.MoveField(const Tofield:TField; const FieldValue :Variant);
begin
  if Tofield.AsVariant <> FieldValue then
  If (Tofield.Datatype in [db.ftLargeint , db.ftInteger , db.ftSmallint])   then Begin
    Tofield.AsInteger := FieldValue;
  end else if (Tofield.DataType in [db.ftFloat, db.ftCurrency] )	then begin
      Tofield.AsFloat := FieldValue;
  end else if (Tofield.DataType in [db.ftDate, db.ftdatetime] )	then begin
      Tofield.asDatetime := FieldValue;
  end else Tofield.AsVariant := FieldValue;
end;

Procedure TBusObj.MoveField(const FromField, Tofield:TField);
begin
    if  (FromField<> nil ) and (Tofield <> nil) then begin
      if Tofield.AsVariant <> FromField.AsVariant then Begin
        If (FromField.Datatype in [db.ftLargeint , db.ftInteger , db.ftSmallint])   then Begin
          Tofield.AsInteger := FromField.AsInteger;
        end else if (FromField.DataType in [db.ftFloat, db.ftCurrency] )	then begin
            Tofield.AsFloat := FromField.AsFloat;
        end else if (FromField.DataType in [db.ftDate, db.ftdatetime] )	then begin
            Tofield.asDatetime := FromField.asDatetime;
        end else Tofield.AsVariant := FromField.AsVariant;
      end;
    end;
end;
Function TBusObj.ExcludeFromclone:String;
var
    ctr :integer;
    Procedure Addfield(const fsFieldName:String);
    begin
        if result <> '' then result := result + ',';
        REsult := result + QuotedStr(fsFieldName);
    end;
begin
    Result := '';
    if datasetAssigned= False then exit;
    Addfield(IDFieldName);
    Addfield('globalref');
    for ctr := 0 to fdataset.FieldCount-1 do
        if fdataset.fields[ctr].FieldKind = fkCalculated then Addfield(fdataset.fields[ctr].fieldName);
end;

Procedure TBusObj.copyobjRec(Changefield :String; const ChangeValue :Variant; TargetObj :TBusObj);
var
  iIndex, Propcount: integer;
  PropList: PPropList ;
  procedure SetObjectProperty(aObj: TObject; aPropName: string; aValue: Variant);
  var PropInfo: PPropInfo;
  begin
    PropInfo:= GetPropInfo(aObj,aPropName);
    if Assigned(PropInfo) then begin
      SetPropValue(aObj, aPropName, aValue);
    end
    else begin
    end;
  end;
begin
  Propcount := GetPropList(PTypeInfo(Self.ClassInfo), PropList);
  ObjPropcount := Propcount;
  { remove this for now as it is slowing things down too much
  StartCloneBusobj;  }
  if (not(Assigned(PropList))) or (Propcount = 0) then Exit;
  for iIndex := 0 to Propcount - 1 do begin
    try
      if (SameText(string(Proplist[iIndex].name), 'GlobalRef')) or (SameText(string(Proplist[iIndex].name), IDFieldName)) or (Sametext(string(Proplist[iIndex].name) , 'msTimeStamp')) or (SameText(string(Proplist[iIndex].name), 'msUpdateSiteCode')) then
      else begin
        if Sysutils.SameText(String(Proplist[iIndex].name), changefield) then begin
          SetObjectProperty(TargetObj , String(Proplist[iIndex].name) , ChangeValue);
        end else if (not (PropType(Self, String(Proplist[iIndex].name)) in [tkClass, tkMethod, tkArray, tkRecord, tkInterface])) and
          (*(assigned(Proplist[iIndex].setproc))  and*)
          (Assigned(getPropInfo(TargetObj,String(Proplist[iIndex].name))) and  Assigned(getPropInfo(TargetObj,String(Proplist[iIndex].name)).setproc ) ) and
          (Pos('''' + uppercase(String(Proplist[iIndex].name)) + '''', uppercase(fsFieldsnotToclone)) = 0) then
            try
              if not(proplist^[iIndex].Proptype^.Kind = tkClass) then begin
                SetObjectProperty(TargetObj, String(Proplist[iIndex].name), GetPropValue(Self, String(Proplist[iIndex].name)));
                Log(String(Proplist[iIndex].name));
              end else begin
                Log('Non-writable:' + String(Proplist[iIndex].name), LogType_Error);
              end;
            Except

            end;
      end;
    Except
      on E:Exception do begin
  //                            Log(String(Proplist[iIndex].name) + '-' + E.Message , LogType_Error);
      end;
    end;
     { remove this for now as it is slowing things down too much
       StepCloneBusobj; }
  end;
end;

Function TBusObj.CloneBusObj(const Changefield :String; const ChangeValue :Variant; const SaveAfterCopy : Boolean = True; const FilterFields :String = ''):TBusObj;
begin
    Result := Nil;
    if Self.Dataset.Active = False then begin
      Self.ResultStatus.AddItem(false, rssError, BOR_Obj_Err_Objectclosed,'The dataset of this object is closed');
      Exit;
    end;
    if Self.Dataset.RecordCount = 0 then begin
      Self.ResultStatus.AddItem(false, rssError, BOR_Obj_Err_Objectclosed,'No record found to copy');
      exit;
    End;
    // creates the new object as a child of the parent object if applicable . eg: saleslines
    CreateInstance;
    if not Assigned(ObjInstanceToClone) then begin
      ObjInstanceToClone := TBusObj(GetComponentByClassType(getClass(Self.ClassName), False));
      if Assigned(self.Connection) then ObjInstanceToClone.connection := Self.Connection;
      ObjInstanceToClone.Load(0); // this is to avoid loading the whole table
      ObjInstanceToCloneisLocal := True;
    end;
    if ObjInstanceToClone = nil then begin
      Self.ResultStatus.AddItem(false, rssError, BOR_Obj_Err_Not_Registered, Self.Classname +' is not registered to do this process');
      Exit;
    end;
    ObjInstanceToClone.CloneSource := Self;
    ObjInstanceToClone.CopyingTrans := Self.CopyingTrans;
    try
      ObjInstanceToClone.SilentMode := True; // as cloning is done internally, it should be in silinetmode
      Try
        ObjInstanceToClone.IgnoreAccesslevel := True;
        if fbAddNewWhenCloning then ObjInstanceToClone.New;
        ObjInstanceToClone.DoFieldChange := False;
        Try
          copyobjRec(Changefield ,ChangeValue ,ObjInstanceToClone);
          AfterCloneBusObj;
          ObjInstanceToClone.Postdb;
          fbObjectCopied := True;
          ClonePropertyObjects;
        Finally
            ObjInstanceToClone.DoFieldChange := True;
        end;
        Result := nil;
        if fbObjectCopied then
          if SaveAfterCopy then begin
            if ObjInstanceToClone.Save then  begin
              ObjInstanceToClone.XMLDoc;
              Result := ObjInstanceToClone;
            end;
          end else
            Result := ObjInstanceToClone;
      finally
          ObjInstanceToClone.CopyingTrans := False;
      end;
    Except
      on E:EXception do begin
        Self.ResultStatus.AddItem(false, rssError, BOR_Obj_Err_CopyFailed, Self.Classname +' Copying Failed. ' + E.Message)
      end;
    end;
end;

function TBusObj.CompareXMLDocs(Const d1, d2: TXMLDocument): boolean;
var
  sl: TStringList;
  n1, n2, IDNode: IXMLNode;
  fsGlobalref:String;
  TransType: string;
  Procedure DoAddAudit;
  var
    Audit:  TAudit;
  begin
          Audit:= TAudit.Create(nil);
          try
            Audit.Load(0);
            Audit.New;
            Audit.TransType:= TransType;
            Audit.DataDescription:= 'Main';
            Audit.AuditDate:= now;
            Audit.TransGlobalref := fsGlobalref;
            Audit.ChangeDescription:= sl.Text;
            Audit.LogDetails(sl);
            initAuditTrailDetails(Sl.text);
            try
                Audit.Save;
            Except
                // kill the exception when ChangeDescription is more than 255 chars
            end;

          finally
            FreeandNil(Audit);
          end;
  end;
begin
    result:= true;

    {no change}
    try
      if not(Assigned(d1)) and not(Assigned(d2)) then exit;
      if sametext(d1.xml.text , d2.xml.text) then exit;
    Except
    end;

    {new record}
    if (trim(d1.xml.text) = '') and (trim(d2.xml.text) <> '') then begin
      sl:= TStringList.Create;
      try
        TransType :=XMLNodename;
        sl.add( 'Created');
        fsGlobalref := TMSBusObj(Self).Globalref;
        DoAddAudit;
        Exit;
      finally
        FreeandNil(sl);
      end;
    end;

    showProgressbar(10, XMLNodeName +' :  Audit Trail');
    try
      n1 := nil;
      n2 := nil;
      sl:= TStringList.Create;
      try

        if d1 <> nil then
            n1:= d1.ChildNodes.FindNode(XMLDocRoot);
        if n1 <> nil then
            n1:= n1.ChildNodes.FindNode(XMLDocRequest);
        stepProgressbar;
        if d2 <> nil then
            n2:= d2.ChildNodes.FindNode(XMLDocRoot);
        if n2 <> nil then
            n2:= n2.ChildNodes.FindNode(XMLDocRequest);
        stepProgressbar;
        {if one of them is nil and the other one is not nil then they are not eaual}
        if (n2 = nil) then begin
            Result := False;
            Exit;
        end;
        stepProgressbar;
        if n1 = nil then begin
            //sl.Add(Self.XMLNodename + ' - Added');
        end else begin
            {if the count of shild nodes are not equal then the XML is not equal}
            if n1.childNodes.count <> n2.childnodes.count then begin
                Result := False;
                Exit;
            end;

            {here we assume that there will be only 1 rec, but will fail when there are multiple records}
            if n1.ChildNodes.Count > 0 then
              n1:= n1.ChildNodes[0];
            if n2.ChildNodes.Count > 0 then
              n2:= n2.ChildNodes[0];
        end;
        stepProgressbar;
        if not CompareXMLNodes(n1,n2, sl,1 ) then  begin
          if sl.Count > 0 then begin
            if sl[0] = Self.XMLNodename then //sl.delete(0)
            else if sl[0] = self.XMLNodeName +' - Added' then sl[0] := 'Created';
            CustomiseauditInfo(sl);
          end;
          result:= false;
          fsGlobalref:= '';
          try
            if Assigned(n1) then begin
              TransType:= n1.NodeName;
              IDNode := n1.ChildNodes.FindNode(GlobalRefTagInXML);
              if Assigned(IDNode) then begin
                if VarIsNull(IDnode.NodeValue) then
                  fsGlobalref := ''
                else
                  fsGlobalref := IDnode.nodeValue;
              end;
            end else if Assigned(n2)  then begin
              {when n1 not assigned is a new record}
              TransType:= Self.XMLNodeName;
              if Self is TMSBusObj then
                if TMSBusObj(Self).GlobalRef = null then
                else fsGlobalref := TMSBusObj(Self).GlobalRef
            end;
          Except
              // kill the exception incase the globalref is missing .
          end;
          stepProgressbar;
          if fsGlobalref = '' then if Self is TMSBusObj then fsGlobalref := TMSBusObj(Self).GlobalRef;
          stepProgressbar;
          DoAddAudit;
        end;
         stepProgressbar;
      finally
        FreeandNil(sl);
      end;
    finally
      HideProgressbar;
    end;
end;

Function TBusObj.getconversiontype :String;
begin
    REsult := XMLNodename;
End;

Function TBusObj.getTableName;
var
    Pos1 :Integer;
begin
    Pos1:= 0;
    if fsTablename = ''         then begin
        if fSQL <> ''           then pos1        := Pos('FROM' , uppercase(fSQL));
        if pos1 <> 0            then fsTablename := Trim(copy(fSQL , pos1+4 , Length(fSQL)));
        if fsTablename <> ''    then pos1        := Pos(' ' , uppercase(fsTablename));
        if pos1 <> 0            then fsTablename := Trim(copy(fsTablename , 1, pos1)) else fsTableName := Trim(fsTablename);
    End;
    Result := fsTableName;
end;
function TBusObj.GetTempData: TJsonObject;
begin
  if not Assigned(fTempData) then
    fTempData:= TJsonObject.Create;
  result:= fTempData;
end;

////
Function TBusObj.getConfirmFromGui  : TGeneralconfirm;
begin
    if not Assigned(fConfirmFromGui) then
        if Assigned(Owner) and (Owner is TBusObj) then
            fConfirmFromGui:=  TBusObj(Owner).ConfirmFromGui;
    result:= fConfirmFromGui;
end;
Function TBusObj.getPostList: TPostList ;
begin
  if Assigned(fAssignedPostList) then
    result:= fAssignedPostList
  else if Assigned(Owner) and (Owner is TBusObj) then
    result:=  TBusObj(Owner).PostList
  else begin
    if not Assigned(fPostList) then begin
        fPostList := TPostList.Create(self);
        fPostList.DBConnection := Connection.DBConnection;
        AssignProgressdialog(fPostList);
    end;
    result := fPostList;
  end;
end;

procedure TBusObj.SetPostList(const Value: TPostList);
begin
  fAssignedPostList:= Value;
end;

function TBusObj.Searchnode(const node :IXMLNode; const Tagname:String; const xNodeValue : Variant):IXMLNode;
var
    x:Integer;
    xNode :IXMLNode ;
begin
    Result := nil;
    for x:= 0 to node.ChildNodes.Count -1 do begin
        if (not(node.ChildNodes[x].IsTextElement)) and
                  ( node.ChildNodes[x].HasChildNodes) then begin
            xNode :=node.ChildNodes[x];
            if Assigned(xNode) then xNode := xnode.Childnodes.findNode(Tagname);
            if Assigned(xnode) then
                if (xnode.IsTextElement) then
                    if xnode.NodeValue = xNodeValue then begin
                        REsult :=node.ChildNodes[x];
                        Exit;
                    end;

        end;
    end;
end;

function TBusObj.CompareXMLNodes(Const n1, n2: IXMLNode; var DiffList: TStringList; const Heirarchy:Integer): boolean;
var
  node: IXMLNode;
  s: string;
  x: integer;
  TransType: string;
begin
  stepProgressbar('Audit Trail');
  try
    result:= true;
    if not(Assigned(n1)) and not(Assigned(n2)) then exit;
    if Assigned(n1) and Assigned(n2) and sametext(n1.xml , n2.xml) then exit;
    TransType:= '';
    if Assigned(n1) then begin
      if not Assigned(n2) then begin
        s:= n1.NodeName + ' - Deleted';
        DiffList.Add(s);
        result:= false;
      end else begin
        if (n1.ChildNodes.Count = 0) and (n2.ChildNodes.Count > 0) then begin
            for x:= 0 to n2.ChildNodes.Count -1 do begin
              //stepProgressbar('Audit Trail');
              if n2.ChildNodes[x].IsTextElement or (not n2.ChildNodes[x].HasChildNodes) then begin
                  node:= n2.ChildNodes.FindNode(n2.ChildNodes[x].NodeName);
                  if not Assigned(node) then
                  else begin
                      { text element, so compare text element values }
                      try
                        if ((not VarIsNull(n2.ChildNodes[x].NodeValue)) ) then begin
                          if TransType = '' then begin
                            TransType:= n2.NodeName;
                            DiffList.Add(TransType);
                          end;
                          s:= ReplicateStr('  ' , Heirarchy) + n2.ChildNodes[x].NodeName ;
                          s:= s+ AuditTrialOldValue;
                          s:= s+ AuditTrialNewValue; if not VarIsNull(node.NodeValue) then s:= s + node.NodeValue + '' else s:= s + '';
                          DiffList.Add(s+';');
                          result:= false;
                        end;
                      except
                      end;
                  End;
              end else begin
                          node := n2.Childnodes.findNode(n2.Childnodes[x].NodeName);
                          if Assigned(node) then if not CompareXMLNodes(nil, node, DiffList , Heirarchy+1) then result:= false;
              end;
            end;
        end else begin
            for x:= 0 to n1.ChildNodes.Count -1 do begin
              //stepProgressbar('Audit Trail');
                { found node with same name in n2 }
                if n1.ChildNodes[x].IsTextElement or  (not n1.ChildNodes[x].HasChildNodes) then begin
                  node:= n2.ChildNodes.FindNode(n1.ChildNodes[x].NodeName);
                  if not Assigned(node) then begin
                    if (TransType = '') then begin
                      TransType:= n1.NodeName;
                      DiffList.Add(TransType);
                    end;
                    s:= ReplicateStr('  ' , Heirarchy) +n1.ChildNodes[x].NodeName + ' - Deleted';
                    DiffList.Add(s);
                    result:= false;
                  end else begin
                      { text element, so compare text element values }
                      try
                        if ((not VarIsNull(n1.ChildNodes[x].NodeValue)) or (not VarIsNull(n2.ChildNodes[x].NodeValue)))
                            and (n1.ChildNodes[x].NodeValue <> node.NodeValue) then begin
                          if TransType = '' then begin
                            TransType:= n1.NodeName;
                            DiffList.Add(TransType);
                          end;
                          s:=ReplicateStr('  ' , Heirarchy) + n1.ChildNodes[x].NodeName ;
                          s:= s+ AuditTrialOldValue; if not VarIsNull(n1.ChildNodes[x].NodeValue) then s:= s + n1.ChildNodes[x].NodeValue + '' else s:= s + ' ';
                          s:= s+ AuditTrialNewValue; if not VarIsNull(node.NodeValue) then s:= s + node.NodeValue + '' else s:= s + '';
                          DiffList.Add(s+';');
                          result:= false;
                        end;
                      except
                        // This is here to trap child nodes that dont have any children
                        //   eg Invoice Lines node without any lines
                      end;
                  End;
                end else begin
                  { not a text element }
                  //if nl1.IndexOf(Pointer(n1.ChildNodes[x])) < 0 then begin
                    { a non business object node (no ID) so compare }
                    node :=n1.Childnodes[x];
                    node := node.Childnodes.findNode(IDTagInXML);
                    if Assigned(node) then begin
                        node := Searchnode(n2, IDTagInXML , node.NodeValue);
                        if Assigned(node) then begin
                            if not CompareXMLNodes(n1.ChildNodes[x], node, DiffList, Heirarchy+1) then result:= false;
                        End else begin
                            s := n1.ChildNodes[x].Nodename + ' - Deleted';
                            DiffList.Add(s);
                            result:= false;
                        end;
                    End else begin
                        node := n2.Childnodes.findNode(n1.Childnodes[x].NodeName);
                        if Assigned(node) then begin
                            if not CompareXMLNodes(n1.ChildNodes[x], node, DiffList, Heirarchy+1) then result:= false;
                        End;

                    end;
                  //end;
                end;
              end;
            //end;

            for x:= 0 to n2.ChildNodes.Count -1 do begin
              //stepProgressbar('Audit Trail');
                if (not(n2.ChildNodes[x].IsTextElement)) and
                  ( n2.ChildNodes[x].HasChildNodes) then begin
                    node := n2.Childnodes[x].Childnodes.findNode(IDTagInXML);
                    if Assigned(node) then begin
                        if  not Assigned(Searchnode(n1, IDTagInXML , node.NodeValue)) then begin
                            s:= n2.Childnodes[x].NodeName + ' - Added';
                            DiffList.Add(s);
                            result:= false;
                            if not CompareXMLNodes(nil, n2.Childnodes[x], DiffList, Heirarchy+1) then result:= false;
                        End;
                    End;
                  End;
            end;
        End;
      end;
    end else if Assigned(n2) then begin
      { n2 has been added }
      for x:= 0 to n2.ChildNodes.Count -1 do begin
        //stepProgressbar('Audit Trail');
        if n2.ChildNodes[x].IsTextElement or (not n2.ChildNodes[x].HasChildNodes) then begin
            node:= n2.ChildNodes.FindNode(n2.ChildNodes[x].NodeName);
            if not Assigned(node) then
            else begin
                { text element, so compare text element values }
                try
                  if ((not VarIsNull(node.NodeValue)) ) then begin
                    s:= ReplicateStr('  ' , Heirarchy) +node.NodeName ;
                    s:= s+ AuditTrialOldValue;
                    s:= s+AuditTrialNewValue; if not VarIsNull(node.NodeValue) then s:= s + node.NodeValue + '' else s:= s + '';
                    DiffList.Add(s+';');
                    result:= false;
                  end;
                except
                end;
            End;
        end else begin
          node := n2.ChildNodes[x];
          if Assigned(node) then if not CompareXMLNodes(nil, node, DiffList, Heirarchy+1) then result:= false;
        end;
      end;
      //result:= false;
    end;
  Except
    on E:Exception  do begin
      result:= false;
    {$IFDEF DevMode}
      MessageDlgXP_Vista('Audit Trail : ' +E.Message, mtWarning, [mbOK], 0);
    {$ENDIF}
    end;
  end;
end;

Constructor TBusObj.CreateWithSharedConn(AOwner: TComponent);
begin
  Create(AOwner);
  connection := TMyDAcDataconnection.Create(Self);
  connection.Connection :=GetSharedMyDacConnection;
end;

procedure TBusObj.CustomiseauditInfo(sl: TStringlist);
begin

end;

Constructor TBusObj.CreateWithNewConn(AOwner: TComponent;aConnection: TERPConnection=nil);
begin
  Create(AOwner);
  connection := TMyDAcDataconnection.Create(Self);
  if aConnection <> nil then
    connection.Connection := aConnection
  else connection.Connection := GetNewMyDacConnection(self);
  fMyDAcDataconnection := nil;
end;

Procedure TBusObj.CreateInstance;
begin
    // descendant classes will have the proc defined
end;

Procedure TBusObj.ClonePropertyObjects;
begin
    // descendant classes will have the proc defined
end;

Function TBusObj.ForeignKeysValid(const node: IXMLNode):Boolean;
begin
    REsult := True;
end;

Function TBusObj.ValidateXMLData(const node :IXMLNode) :Boolean ;
begin
    {get ImportingFromXMLFile from the parent object - this is for the
    sub properties}
    if assigned(Self.Owner) then
        if Self.Owner is TBusObj then
            Self.ImportingFromXMLFile := TBusObj(self.Owner).ImportingFromXMLFile;
    fsXMLSearchRecord := '';
    fiLocateXMLRecordID := GetXMLNodeIntegerValue(Node, 'ID');
    fsLocateXMLRecordglobalRef := GetXMLNodeStringValue(Node, GlobalRefTagInXML);
    REsult := True;//not ImportingFromXMLFile;
end;

Procedure TBusObj.GetCleanFromParent(obj :TBusObj; fClean : TXMLDocument; var node: IXMLNode);
var
    LineNode, IDNode: IXMLNode;
    x:Integer;
begin
        if not Assigned(obj) then exit
        else if (Assigned(obj.Owner)) and (obj.owner is TBusobj) then begin
            GetCleanFromParent(TBusobj(obj.owner),fClean, node);
            if  Assigned(node) then begin
                node:= node.ChildNodes.FindNode(obj.XMLBranchname);
                if Assigned(node) then begin
                    if node.ChildNodes.count > 0 then
                        for x := 0 to node.ChildNodes.Count - 1 do begin
                            LineNode := node.ChildNodes[x];
                            IDNode := LineNode.ChildNodes.FindNode(LowerCase(IDTagInXML));
                            if Assigned(IDNode) and (IDNode.NodeValue = Obj.Id) then begin
                                node := LineNode;
                                break;
                            end;
                        end;
                end;
            end;
        end else
            if (Assigned(obj.fCleanXMLDoc)) then
                if obj.fCleanXMLDoc.ChildNodes.Count> 0 then begin
                    fClean:= obj.fCleanXMLDoc;
                    node:= fClean.ChildNodes.FindNode(XMLDocRoot);
                    if not Assigned(node) then node:= fClean.ChildNodes.FindNode(XMLDocRequest)
                    else     node:= node.ChildNodes.FindNode(XMLDocRequest);
                    if not Assigned(node) then node:= fClean.ChildNodes.FindNode(obj.XMLNodeName)
                    else node:= node.ChildNodes.FindNode(obj.XMLNodeName);
                    Exit;
                end;
end;

function TBusObj.GetCleanXMLNode: IXMLNode;
var
  node: IXMLNode;
begin
  Node := nil;
  getCleanFromPArent(Self , fCleanXMLDoc, node);
  Result := Node;
end;

procedure TBusObj.SaveXMLToFile(const FileName: string);
var
  Doc: IXMLDocument;
  node: IXMLNode;
begin
  doc:= TXMLDocument.Create(nil);
  try
  SavingXMLTofile := True;
  try
    doc.Active      := true;
    doc.Version     := XMLDocVersion;
    doc.Encoding    := XMLDocEncoding;
    node            := doc.AddChild(XMLDocRoot);
    node.Attributes['DataVersion']  := getUserVersion;
    node            := node.Addchild(XMLDocRequest);
    node.Attributes['OnError']      := XMLDocRequestStopError;
    node.Attributes['DataObject'] := Self.ClassName;
    XMLPropertyNode := node;
    XMLPropertyname := XMLNodeName;
    Self.IterateRecords(GetPropertyXMLCallback);
    Doc.XML.SaveToFile(FileName);
  finally
//    Doc.Free
  end;
Finally
  SavingXMLTofile := False;
End;
end;

function TBusObj.Error :Boolean;
begin
    Result := False;
    if ImportFailed then
        Result := XMLOnError = XMLDocRequestStopError;
end;

procedure TBusObj.AddXMLNode(const Node: IXMLNode; const sNodeName: String;
  const Value: OleVariant; Const XMLTagsinLowercase: Boolean);
Var
  NodeName :String;
  sValue: OleVariant;
begin
  if node = nil then Exit;
  if snodeName = '' then Exit;
  if XMLTagsinLowercase then NodeName := LowerCase(sNodeName)
  else NodeName :=sNodeName;
  if LimitXMLFieldsOnSave and
    ((not AppEnv.BusObjFieldList.ListEmpty(Self.ClassName)) and
     (not AppEnv.BusObjFieldList.InList(self.ClassName, NodeName))) then exit;
  sValue := Value;
  if vartype(Value) = VarDate then
      if Value = '12:00:00 AM' then Exit{ignore blank date}
          else sValue := FormatDateTime( MysqlDateTimeFormat, sValue); {dateTostr to convert the date into system date format}
  try
    Node.Addchild(NodeName).NodeValue := sValue;
  except
    on e: exception do begin
      if (Pos('invalid',Lowercase(e.Message)) > 0) and (Pos('character',Lowercase(e.Message)) > 0) then begin
        Node.Addchild(NodeName).NodeValue := RemoveIllegalCharacters(sValue);
      end
      else
        raise;
    end;
  end;
end;

procedure TBusObj.AddXMLCDataNode(const Node: IXMLNode; const sNodeName: String;
  const Value: OleVariant; Const XMLTagsinLowercase: Boolean);
Var
  NodeName :String;
  sValue: OleVariant;
  newNode, cDataNode: IXMLNode;
begin
  if node = nil then Exit;
  if snodeName = '' then Exit;
  if XMLTagsinLowercase then NodeName := LowerCase(sNodeName)
  else NodeName :=sNodeName;
  if LimitXMLFieldsOnSave and
    ((not AppEnv.BusObjFieldList.ListEmpty(Self.ClassName)) and
     (not AppEnv.BusObjFieldList.InList(self.ClassName, NodeName))) then exit;
  sValue := Value;
  if vartype(Value) = VarDate then
      if Value = '12:00:00 AM' then Exit{ignore blank date}
          else sValue := FormatDateTime( MysqlDateTimeFormat, sValue); {dateTostr to convert the date into system date format}
  newNode:= Node.Addchild(NodeName);
  cDataNode:= newNode.OwnerDocument.CreateNode(Value,ntCData);
//  cDataNode.NodeValue:= Value;
  newNode.ChildNodes.Add(cDataNode);
end;

procedure TBusObj.FilterSelect(FilterNode: IXMLNode);
var
  sql: string;
begin
  if LoadFilterParamsFromNode(self, FilterNode, self.LoadParamList, sql) then begin
    self.LoadSelect(sql);
  end;
end;

procedure TBusObj.FilterAdd(FilterNode: IXMLNode);
var
  sql: string;
begin
  if LoadFilterParamsFromNode(self, FilterNode, self.LoadParamList, sql) then begin
    if self.fSQLSelect = '' then
      self.fSQLSelect:= '(' + sql + ')'
    else
      self.fSQLSelect:= self.fSQLSelect + ' and (' + sql + ')';
  end;
end;

{ TMSBusObj }
//  Introduces Global Ref

procedure TMSBusObj.AddXMLHeaderNode(const node: IXMLNode);
begin
    inherited AddXMLHeaderNode(node);
    AddXMLNode(node,GlobalRefTagInXML     ,GlobalRef);
    AddXMLNode(node,xmlnodenameTagInXML   ,xmlnodename);
    AddXMLNode(node,busobjTypeDesTagInXML ,BusObjectTypeDescription);

end;

Function  TMSBusObj.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if Dataset.findField('Globalref') <> nil then
    if (self.Id > 0) and (GlobalRef = '') then begin
        AssignGlobalRef;
        if Dataset.State in [dsEdit,dsInsert] then
          Dataset.Post;
    end;
end;

function TMSBusObj.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
  if result then
    DoUpdateSiteCode;
end;

procedure TMSBusObj.DoUpdateSiteCode;
var
  cmd: TErpCommand;
begin
  if RawMode then
    exit;
  if Assigned(Dataset.FindField('msUpdateSiteCode')) then begin
    if MsUpdateSiteCode <> AppEnv.Branch.SiteCode then begin
      MsUpdateSiteCode:= AppEnv.Branch.SiteCode;
      if (MsUpdateSiteCode <> AppEnv.Branch.SiteCode) and (ID > 0) then begin
        cmd:= TErpCommand.Create(nil);
        try
          cmd.Connection:= Connection.Connection;
          cmd.SQL.Add('update ' + BusObjectTableName);
          cmd.SQL.Add('set msUpdateSiteCode = ' + QuotedStr(AppEnv.Branch.SiteCode));
          cmd.SQL.Add('where ' + self.IDFieldName + ' = ' +IntToStr(ID));
          cmd.Execute;
        finally
          cmd.Free;
        end;
      end;
    end;
  end
  else begin
    if (ID > 0) and (BusObjectTableName <> '') then begin
      cmd:= TErpCommand.Create(nil);
      try
        cmd.Connection:= Connection.Connection;
        cmd.SQL.Add('update ' + BusObjectTableName);
        cmd.SQL.Add('set msUpdateSiteCode = ' + QuotedStr(AppEnv.Branch.SiteCode));
        cmd.SQL.Add('where ' + self.IDFieldName + ' = ' +IntToStr(ID));
        try
          cmd.Execute;
        Except
        end;
      finally
        cmd.Free;
      end;
    end;
  end;
end;

procedure TMSBusObj.AssignGlobalRef;
begin
  try
    { Persistent field may be missing from some forms so skip error if field not found. }
    { SiteIntergration will set this value if missing }
    if MsUpdateSiteCode <> AppEnv.Branch.SiteCode then
      MsUpdateSiteCode := AppEnv.Branch.SiteCode;
  except

  end;
  if (self.Id > 0) and (GlobalRef = '') then begin
    GlobalRef:= AppEnv.Branch.SiteCode + IntToStr(Id);
  end;
end;

constructor TMSBusObj.Create(aOwner: TComponent);
begin
  inherited;

end;

constructor TMSBusObj.Create(aOwner: TComponent;
  DbConnection: TCustomMyConnection);
begin
  inherited Create(AOwner);
  self.Connection := TMyDacDataConnection.Create(self);
  self.Connection.Connection := DbConnection;
end;

procedure TMSBusObj.FlagAsUpdated(aTimeStamp: TDateTime = 0);
var
  Field: TField;
  cmd: TERPCommand;
  aTime: TDateTime;
begin
  aTime := aTimeStamp;
  if aTime = 0 then aTime := now;
  Field:= Dataset.FindField('msTimeStamp');
  if Assigned(Field) then begin
      EnablePropertySetWhenReadonly := True;
      try

        if ATime > GetDateTimeField('msTimeStamp') then SetDateTimeField('msTimeStamp', aTime);

        if not RawMode then begin
          Field:= Dataset.FindField('msUpdateSiteCode');
          if Assigned(Field) then if GetStringField('msUpdateSiteCode') <> AppEnv.Branch.SiteCode then SetStringField('msUpdateSiteCode', AppEnv.Branch.SiteCode);
        end;
      finally
        EnablePropertySetWhenReadonly := False;
      end;
  end else begin
    if TableName <> '' then begin
      cmd := DbSharedObj.GetCommand(connection.Connection);
      try
        cmd.Connection:= self.Connection.Connection;
        cmd.SQL.Add('update ' + TableName);
        cmd.SQL.Add('set msTimeStamp = ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,aTime)));
        if not RawMode then
          cmd.SQL.Add(', msUpdateSiteCode = ' + QuotedStr(AppEnv.Branch.SiteCode));
        cmd.SQL.Add('where ' + IDFieldName + ' = ' + IntToStr(ID));
        try
          cmd.Execute;
        Except
        end;
      finally
        DbSharedObj.ReleaseObj(cmd);
      end;
    end;
  end;
  if Assigned(Owner) and (Owner is TMSBusObj) then
    TMSBusObj(Owner).FlagAsUpdated(aTimeStamp);



//  Field:= Dataset.FindField('msTimeStamp');
//  if Assigned(Field) then begin
//    if aTimeStamp > 0 then begin
//      if (IDFieldName <> '') and (TableName <> '') and (ID > 0) then begin
//        cmd:= TERPCommand.Create(nil);
//        try
//          cmd.Connection:= self.Connection.Connection;
//          cmd.SQL.Add('update ' + TableName);
//          cmd.SQL.Add('set msTimeStamp = ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,aTimeStamp)));
//          if not RawMode then
//            cmd.SQL.Add(', msUpdateSiteCode = ' + QuotedStr(AppEnv.Branch.SiteCode));
//          cmd.SQL.Add('where ' + IDFieldName + ' = ' + IntToStr(ID));
//          try
//            cmd.Execute;
//          Except
//          end;
//        finally
//          cmd.Free;
//        end;
//      end;
//    end
//    else begin
//      SetDateTimeField('msTimeStamp', now);
//      if not RawMode then begin
//        try
//          self.MsUpdateSiteCode:= AppEnv.Branch.SiteCode;
//        except
//          if ID > 0 then begin
//            cmd:= TErpCommand.Create(nil);
//            try
//              cmd.Connection:= Connection.Connection;
//              cmd.SQL.Add('update ' + BusObjectTableName);
//              cmd.SQL.Add('set msUpdateSiteCode = ' + QuotedStr(AppEnv.Branch.SiteCode));
//              cmd.SQL.Add('where ' + self.IDFieldName + ' = ' +IntToStr(ID));
//              try
//                cmd.Execute;
//              Except
//              end;
//            finally
//              cmd.Free;
//            end;
//          end;
//        end;
//      end;
//    end;
//  end;
end;

function TMSBusObj.GetGlobalRef: string;
begin
  result:= GetStringField('GlobalRef');
end;

function TMSBusObj.Save: boolean;
begin
  if Dirty and (not RawMode) then begin
    DoUpdateSiteCode;
  end;
  result := inherited;

  if result then begin
//    if (self.IsList or self.IsChild) and Assigned(Owner) and (Owner is TMSBusObj) then
    if Assigned(Owner) and (Owner is TMSBusObj) then
      TMSBusObj(Owner).FlagAsUpdated;
  end;
end;

procedure TMSBusObj.SetGlobalRef(const Value: string);
begin
  SetStringField('GlobalRef', Value);
end;

function TMSBusObj.SharedQuery: TERPQuery;
begin
  REsult := DbSharedObjectsObj.DbSharedObj.GetQuery(connection.Connection);
  //DbSharedObj.ReleaseObj(qry);
end;

function TDatasetBusObj.GetLargeintField(const FieldName: string): Largeint;
var
  fCurDBField: TField;
Begin
  fCurDBField := Nil;
  Result := 0;
  If DSReadOk Then fCurDBField := Dataset.FindField(FieldName);
  check4FieldError(Fieldname,fCurDBField);
  If fCurDBField <> Nil Then Result := fCurDBField.AsLargeint;
  if Assigned(fCurDBField) then fLastFieldName := fCurDBField.FieldName
  else fLastFieldName := '';
end;

function TDatasetBusObj.GetLoadParamList: TStringList;
begin
  if not Assigned(fLoadParamList) then
    fLoadParamList:= TStringList.Create;
  result:= fLoadParamList;
end;

class function TDatasetBusObj.GetMaxIdNumber(
  Connection: TMyConnection): integer;
var
  qry: TMyQuery;
begin
  qry:= TMyQuery.Create(nil);
  try
    qry.Connection:= Connection;
    (*
    qry.SQL.Text:= 'select max(' + self.GetIDField + ') from ' + self.GetBusObjectTablename;
    qry.Open;
    *)
    qry.SQL.Text := 'select auto_increment from INFORMATION_SCHEMA.Tables where'#13#10+
       'TABLE_SCHEMA="' + qry.Connection.Database + '" and Table_name="' + self.GetBusObjectTablename + '"';
    qry.Open;
    Result := qry.Fields[0].asInteger;
  finally
    qry.Free;
  end;
end;

function TDatasetBusObj.GetMsTimeStamp: TDateTime;
begin
  result:= GetDateTimeField('msTimeStamp');
end;

function TDatasetBusObj.GetMsUpdateSiteCode: string;
begin
  result:= GetStringField('msUpdateSiteCode');
end;

function TDatasetBusObj.NoRigtsMsg(const NoRightsfor: String): String;
begin
  Result := 'No rights to ' + NoRightsfor +' '  + Self.BusObjectTypeDescription ;
  if NoRightReason <> '' then result := result + chr(13) +chr(13) + NoRightReason;
end;

procedure TDatasetBusObj.DLLLoadSelect(const SelectStatement: string);
begin
  LoadSelect(SelectStatement);
end;

function TDatasetBusObj.DLLSave: Boolean;
begin
  REsult := Save;
end;

procedure TDatasetBusObj.DLLNew;
begin
  New;
end;

procedure TDatasetBusObj.DLLPostDB;
begin
  PostDB;
end;

function TDatasetBusObj.DLLDelete: Boolean;
begin
  REsult := Delete;
end;

function TDatasetBusObj.Locate(const KeyFields: string;
  const KeyValues: variant; Options: TLocateOptions): boolean;
begin
  Result := Dataset.Locate(KeyFields, KeyValues,Options);
end;

function TDatasetBusObj.LocateBarcode(const aBarcode: string): boolean;
begin
  result := Locate('BarCode',aBarcode,[loCaseInsensitive]);
end;

function TDatasetBusObj.Lock(const Lockgroup: String): Boolean;
begin
  UserLock.Enabled:= true;
  result:= UserLock.Lock(BusObjectTableName,Id, Lockgroup);
end;

class function TDatasetBusObj.SetNextIdNumber(const nextId: integer;
  Connection: TMyConnection): boolean;
var
  qry: TMyQuery;
  script: TMyScript;
begin
  result:= false;
  qry:= TMyQuery.Create(nil);
  try
    qry.Connection:= Connection;
    qry.SQL.Text:= 'select max(' + self.GetIDField + ') from ' + self.GetBusObjectTablename;
    qry.Open;
    if (qry.Fields[0].AsInteger + 1) >= nextId then begin
      exit;
    end;
  finally
    qry.Free;
  end;
  script:= TMyScript.Create(nil);
  try
    script.Connection:= Connection;
    (* ??? What for such a complex stuff???  *)
    script.SQL.Add('insert into ' + self.GetBusObjectTablename +
      ' (' + self.GetIDField + ') values (' + IntToStr(nextId - 1) + ');');
    script.SQL.Add('delete from ' + self.GetBusObjectTablename);
    script.SQL.Add('where ' + self.GetIDField + ' = ' + IntToStr(nextId - 1) + ';');
    (* Don't do this because alter table will force a connection commit!
    script.sql.add('alter table ' + self.GetBusObjectTablename + ' AUTO_INCREMENT = ' + IntToStr(nextId));
    *)
    script.Execute;
    result:= true;
  finally
    script.Free;
  end;
end;

function TDatasetBusObj.LocateId(const aId: integer): boolean;
begin
  result:= Dataset.Locate(IDFieldName,aId,[]);
end;

function TDatasetBusObj.DoAfterClose(Sender: TDatasetBusObj): Boolean;
begin
  result:= true;
end;

function TDatasetBusObj.DoBeforeClose(Sender: TDatasetBusObj): Boolean;
begin
  result:= true;
end;

{ TMyDacDataConnection }
{transaction handling}
procedure TMyDacDataConnection.BeginTransaction;
begin
  inherited;
  if Assigned(MyDacConnection) then
     if MyDacConnection.InTransaction = False  then
        MyDacConnection.StartTransaction;
end;
procedure TMyDacDataConnection.CommitTransaction;
begin
  inherited;
  if Assigned(MyDacConnection) then
     if MyDacConnection.InTransaction = True then
        MyDacConnection.Commit;

  if not Assigned(Self.Owner) then Exit;
  if not (Self.Owner is TBusObj) then Exit;
  TBusObj(Self.Owner).Transcount := 0;
  TBusObj(Self.Owner).UnlockTables;

end;
procedure TMyDacDataConnection.RollbackTransaction;
var
  Audit:  TAudit;
begin
  inherited;
  if Self.Owner is TBusobj then
    if (TBusobj(SElf.Owner).cleanID =0) and (TBusobj(Self.Owner).ID<>0) then begin
      Audit:= TAudit.Create(nil);
      try
        Audit.Load(0);
        Audit.New;
        Audit.TransType:= TBusobj(Self.Owner).TransactionName;
//        Audit.TransID:= TBusobj(Self.Owner).ID;
        if Self.Owner is TMSBusObj then
          Audit.TransGlobalref:= TMSBusObj(Self.Owner).Globalref;
        Audit.DataDescription:= 'Cancellation ';
        Audit.AuditDate:= now;
        Audit.ChangeDescription:= Appenv.Employee.EmployeeName+  ' has cancelled ' +
                        TBusobj(Self.Owner).TransactionName +'#' + InttoStr(TBusobj(Self.Owner).ID) ;
        try
            Audit.Save;
        Except
            // kill the exception when ChangeDescription is more than 255 chars
        end;
      finally
        FreeandNil(Audit);
      end;
    end;
  if Assigned(MyDacConnection) then
     if MyDacConnection.InTransaction then
        MyDacConnection.Rollback;
end;
{nested Transactions}
procedure TMyDacDataConnection.BeginNestedTransaction;
var
    strSQL :String;
    s: string;
    qry :TERPQuery;
begin
    if not Assigned(Self.Owner) then Exit;
    if not (Self.Owner is TBusObj) then Exit;
    TBusObj(Self.Owner).Transcount := TBusObj(Self.Owner).Transcount + 1;
    BeginTransaction;
    s:= TBusObj(Self.Owner).XMLNodeName + '_' + IntToStr(Integer(Self.Owner)) + '_' +
      Trim(IntToStr(TBusObj(Self.Owner).Transcount));
    strSQl := 'SAVEPOINT ' + s;
    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(MyDacConnection);
    try
      with Qry do begin
        SQL.add(strSQL);
        Execute;
      end;
    Finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    End;
    ActiveSavePointList.Add(s);
end;

procedure TMyDacDataConnection.CommitNestedTransaction;
var
    strSQL :String;
    s: string;
    idx: integer;
begin
    if not Assigned(Self.Owner) then Exit;
    if not (Self.Owner is TBusObj) then Exit;
    if MyDacConnection.InTransaction = False  then Exit;

    s:= TBusObj(Self.Owner).XMLNodeName + '_' + IntToStr(Integer(Self.Owner)) + '_' +
      Trim(IntToStr(TBusObj(Self.Owner).Transcount));
    idx:= ActiveSavePointList.IndexOf(s);
    if idx < 0 then
      exit;
    strSQl := 'RELEASE SAVEPOINT ' + s;
    with TERPQuery.Create(nil) do Try
        Options.FlatBuffers := True;
        connection := MyDacConnection;
        SQL.add(strSQL);
        Execute;
    Finally
        Free;
    End;
    ActiveSavePointList.Delete(idx);
    TBusObj(Self.Owner).Transcount := TBusObj(Self.Owner).Transcount - 1;
end;

procedure TMyDacDataConnection.RollbackNestedTransaction;
var
    strSQL: string;
    s: string;
    idx: integer;
begin
    if not Assigned(Self.Owner) then Exit;
    if not (Self.Owner is TBusObj) then Exit;
    if MyDacConnection.InTransaction = False  then Exit;

    s:= TBusObj(Self.Owner).XMLNodeName + '_' + IntToStr(Integer(Self.Owner)) + '_' +
      Trim(IntToStr(TBusObj(Self.Owner).Transcount));
    idx:= ActiveSavePointList.IndexOf(s);
    if idx < 0 then
      exit;
    strSQl := 'ROLLBACK TO SAVEPOINT ' + s;
    with TERPQuery.Create(nil) do Try
        Options.FlatBuffers := True;
        connection := MyDacConnection;
        SQL.add(strSQL);
        Execute;
    Finally
        Free;
    End;
    ActiveSavePointList.Delete(idx);
    TBusObj(Self.Owner).Transcount := TBusObj(Self.Owner).Transcount - 1;
end;
{}
procedure TMyDacDataConnection.BeginTransOrNestedTrans(CleanInTrans:Boolean);
begin
  if CleanInTrans then
    BeginNestedTransaction
  else
    BeginTransaction;
end;
procedure TMyDacDataConnection.CommitTransOrNestedTrans(CleanInTrans:Boolean);
begin
  if CleanInTrans then
    CommitNestedTransaction
  else
    CommitTransaction;
end;
procedure TMyDacDataConnection.RollbackTransOrNestedTrans(CleanInTrans:Boolean);
begin
  if CleanInTrans then
    RollBackNestedTransaction
  else
    RollbackTransaction;
end;

constructor TMyDacDataConnection.Create(AOwner: TComponent);
begin
  inherited;
  MyDacConnection:= nil;
  ActiveSavePointList:= TStringList.Create;
end;

procedure TMyDacDataConnection.DatasetEdit(Sender: TDatasetBusObj);
begin
  inherited;
  Sender.Dataset.Edit;
end;
procedure TMyDacDataConnection.DatasetNew(Sender: TDatasetBusObj);
begin
  DatasetNew(Sender, false);
end;

procedure TMyDacDataConnection.DatasetNew(Sender: TDatasetBusObj;DoInsert :Boolean);
begin
  inherited;
  If Sender.Dataset.Active Then Begin
    If Sender.Dataset.State In [dsInsert, dsEdit] Then Sender.Dataset.Cancel;
    If Sysutils.SameText(Trim(TERPQuery(Sender.Dataset).SQL.Text), Trim(Sender.SQL)) Then Begin
      if DoInsert then Sender.Dataset.Insert
      else Sender.Dataset.Append;
      Exit;
    End Else Begin
      Sender.Dataset.Close;
    End;
  End;
  TERPQuery(Sender.Dataset).SQL.Text := Sender.SQL;
  Sender.CaptureDatasetEvents;
  Sender.Dataset.Open;
  if DoInsert then Sender.Dataset.Insert
  else Sender.Dataset.Append;
end;

procedure TMyDacDataConnection.DatasetLoad(Sender: TDatasetBusObj);
var
  x: integer;
  s:String;
begin
//  TLogger.Inst.Log('TMyDacDataConnection.DatasetLoad - Start fot ' + sender.ClassName, ltDetail);
  inherited;
  Try
    If Assigned(Sender.Dataset) Then Begin
      If Sender.Dataset.Active Then Begin
        If Sender.Dataset.State In [dsInsert, dsEdit] Then Self.DatasetSave(Sender);
        If Sysutils.SameText(Trim(TERPQuery(Sender.Dataset).SQL.Text), Trim(Sender.SQL)) Then Begin
//          TLogger.Inst.Log('TMyDacDataConnection.DatasetLoad - Same SQL, positioning to first record', ltDetail);
          TERPQuery(Sender.Dataset).First;
          Exit;
          End Else Begin
          Sender.Dataset.Close;
        End;
      End;
    End;
  Except
  End;
  If Sender.Dataset Is TERPQuery Then Begin
    If Trim(Sender.SQL) = '' Then Exit;
    With TERPQuery(Sender.Dataset) Do Begin
      If Trim(Sender.SQL) <> '' Then Begin
        SQL.Text := Sender.SQL;
        if sender.LoadParamList.Count > 0 then begin
          for x:= 0 to sender.LoadParamList.Count-1 do begin
            ParamByName(sender.LoadParamList.Names[x]).AsString:=
              sender.LoadParamList.Values[sender.LoadParamList.Names[x]];
          end;
//          TLogger.Inst.Log('TMyDacDataConnection.DatasetLoad - Param List:'+ sender.LoadParamList.Text, ltDetail);
        end;
        Sender.CaptureDatasetEvents;
//        TLogger.Inst.Log('TMyDacDataConnection.DatasetLoad - SQL:' + sql.Text, ltDetail);
        try
          Open;
        Except
          on E:Exception do begin
            if devmode then begin
              s:= Sender.Classname + NL +  TERPQuery(Sender.Dataset).Name + NL + TERPQuery(Sender.Dataset).SQL.Text +NL + E.classname +NL+ E.Message;
            end else begin
              s:= E.message;
            end;
            raise Exception.Create(s);
          end;
        end;
//        TLogger.Inst.Log('TMyDacDataConnection.DatasetLoad - Record count: ' + IntToStr(RecordCount), ltDetail);
      End;
    End;
  End;
End;

procedure TMyDacDataConnection.DatasetSave(Sender: TDatasetBusObj);
begin
  inherited;
    Sender.Postdb;
end;

procedure TMyDacDataConnection.DatasetDelete(Sender: TDatasetBusObj);
begin
  inherited;
  If (Sender.Dataset.RecordCount>0) then
    Sender.Dataset.Delete;
end;

procedure TMyDacDataConnection.DatasetCancel(Sender: TDatasetBusObj);
begin
  inherited;
  if Sender.Dataset.State in [dsEdit, dsInsert] then begin
    Sender.Dataset.Cancel;
  end;
end;

destructor TMyDacDataConnection.Destroy;
begin
  if Assigned(MyDacConnection) then MyDacConnection := nil;
  if FBusobj <> nil then
    while FBusobj.Count > 0 do
        RemoveBusObj(TDatasetBusObj(FBusobj.Last));
  ActiveSavePointList.Free;
  inherited;
end;

function TMyDacDataConnection.getcondetails: String;
begin
  REsult := '';
  if assigned(Connection) and (connection is TERPConnection) then begin
    REsult := 'Server   :' + TERPConnection(Connection).Server    + ',' +
              'Database :' + TERPConnection(Connection).Database  + ',' +
              'Port     :' + inttostr(TERPConnection(Connection).Port )     + ',' +
              'Username :' + TERPConnection(Connection).Username  + ',' +
              'Password :' + TERPConnection(Connection).Password;
  end;
end;

function TMyDacDataConnection.GetConnected: boolean;
begin
  if Assigned(MyDacConnection) then
    result:= MyDacConnection.Connected
  else
    result:= false;
end;

function TMyDacDataConnection.GetDataset(Sender: TDatasetBusObj): TCustomMyDataset;
var
    obj :TComponent;
    DatasetName :String;
    ctr:Integer;
    s:String;
begin
  result:= nil;
  if Sender = nil then Exit;

  if Assigned(MyDacConnection) then begin
    obj := Self;
    while not((Obj is TForm ) or (obj is TDatamodule)  or (Obj = nil )) do
         Obj :=Obj.Owner;
    DatasetName :=Trim(Sender.name) + '_Dataset';

    {Search for the dataset object in the form, if found then assign it
    It is the same is the component found with the same name and if the SQL
    of the object is same as the SQL of the component found.}
    if obj <> nil then
        if Obj.Findcomponent(DatasetName) <> nil then
            if Obj.Findcomponent(DatasetName) is TERPQuery then
                if TERPQuery(Obj.Findcomponent(DatasetName)).SQL.TEXt = Sender.SQL then begin
                    Result := TERPQuery(Obj.Findcomponent(DatasetName));
                    Sender.fExternalDatasetAssigned := True;
                    Exit;
                end;

    if obj = nil then
        result:= TERPQuery.Create(Sender)
    else
        result:= TERPQuery.Create(Obj);

    result.Options.FlatBuffers := True;
    result.Connection:= Self.Connection;
    if Obj <> nil then begin
       ctr:= 1;
       s:=DatasetName;
        While Obj.Findcomponent(DatasetName) <> nil do begin
            DatasetName := s + trim(inttostr(ctr));
            ctr:= ctr+1;
        end;
        result.Name := DatasetName;
    end;
  end;
end;


procedure TMyDacDataConnection.SetConnected(const Value: boolean);
begin
  inherited;
  if Assigned(MyDacConnection) then
    MyDacConnection.Connected:= Value;
end;

function TMyDacDataConnection.GetDBConnection: TCustomConnection;
begin
  result:= self.MyDacConnection;
end;

 function TMyDacDataConnection.InTransaction: boolean;
begin
  result:= Assigned(MyDacConnection) and MyDacConnection.InTransaction;
end;

{ TBusDatasource }

constructor TBusDatasource.Create(AOwner :TComponent);
begin
    fBusObjAssigned := False;
    inherited;
end;

Procedure TBusDatasource.SetBusObj(Const Value :TBusObj);
begin
    fBusObj := Value;
    if Value = Nil then begin
        Self.Dataset := Nil;
        fBusObjAssigned := False;
    end else begin
    if Assigned(Value.fDataset) then
        Self.Dataset := Value.Dataset;
    Value.AddDataSource(Self);
    fBusObjAssigned := True;
    end;
end;

destructor  TBusDatasource.Destroy;
begin
    if fBusObjAssigned then begin
        BusObj.RemoveDataSource(Self);
        Dataset := nil;
        BusObj := nil;
    end;
    inherited;
end;

Procedure TBusDatasource.SetDataset(fbDataset :TDataset);
begin
    Self.Dataset := fbDataset;
end;

 { TDataConnection }

constructor TDataConnection.Create(AOwner: TComponent);
begin
    FBusobj := TObjectList.Create(False);
    inherited;
end;

destructor TDataConnection.Destroy;
begin
  FreeAndNil(FBusobj);
  inherited;
end;

procedure TDataConnection.RemoveBusObj(BusObj: TDatasetBusObj);
begin
  Try
    If Assigned(BusObj) then Begin
        if Assigned(fBusObj) then
          fBusObj.Remove(BusObj);

        if Assigned(BusObj.Connection) and Assigned(BusObj.Connection.Owner) AND (BusObj.Connection.Owner <> BusObj) then
          BusObj.Connection := nil
        else if Assigned(BusObj.Connection) AND (BusObj.Connection.Owner = nil) AND (BusObj.Owner is  TBusObj)
                                            AND (TBusObj(BusObj.Owner).Connection = BusObj.Connection) then
          BusObj.Connection := nil;
    end;
  except
  end;
end;

procedure TDataConnection.AddBusObj(BusObj: TDatasetBusObj);
begin
  if FBusobj.IndexOf(BusObj) < 0 then Begin
    FBusObj.Add(BusObj);
  end;
end;


{ TResultStatus }

Function TResultStatus.FindItem(const aOperationOk: boolean;
                      const aSeverity: TResultStatusSeverity;
                      const aCode: integer;
                      const aMessage: string) :integer;
var
  x: integer;
begin
  result:= -1;
  for x:= 0 to self.Count -1 do
  begin
      if (TResultStatusItem(Items[x]).OperationOk = aOperationOk) and
        (TResultStatusItem(Items[x]).Severity = aSeverity) and
        (TResultStatusItem(Items[x]).Code = aCode) and
        (TResultStatusItem(Items[x]).Message = aMessage) then begin
          Result :=  x;
          Exit;
      end;
  end;
end;

Function TResultStatus.GetAllMessages(const aCode: integer; const Delimiter :String = chr(13)) :String;
var
  x: integer;
begin
  result:= '';
  for x:= 0 to self.Count -1 do
      if (TResultStatusItem(Items[x]).Code = aCode) then begin
        if Result <> '' then Result := Result + Delimiter;
        Result := Result + (TResultStatusItem(Items[x]).Message ) ;
      end;


end;
procedure TResultStatus.AddItem(const aOperationOk: boolean;
                                const aSeverity: TResultStatusSeverity;
                                const aCode: integer;
                                const aMessage: string;
                                const ShowMessage: boolean = true);
var
  msg: string;
begin
  msg := aMessage;
  if (ResultPrefix <> '') and (Pos(ResultPrefix, msg) < 1) then
    msg := ResultPrefix + msg;
  if (ResultSuffix <> '') and (Pos(ResultSuffix, msg) < 1) then
    msg := msg + ResultSuffix;
  if (fsIgnoreduplicateMsg= False ) or
   (FindItem (aOperationOk ,aSeverity , aCode, aMessage)= -1 ) then begin
    if ShowMessage and (not SilentMode)  and not(appenv.appdb.apimode)  then  begin
      case aSeverity of
        rssNone,
        rssInfo:    DelayMessageDlg(msg, mtInformation, [mbOK], 0);
        rssWarning: DelayMessageDlg(msg, mtWarning, [mbOK], 0);
        rssError:   DelayMessageDlg(msg, mtWarning, [mbOK], 0 , true);
      end;
    end
    else begin
      with TResultStatusItem(Add) do begin
          OperationOk:= aOperationOk;
          Severity:= aSeverity;
          Code:= aCode;
          Message:= msg;
      end;
    end;
  end;
end;

procedure TResultStatus.AddItems(aResultStatus: TResultStatus);
var
  i: Integer;
begin
  BeginUpdate;
  try
    for i := 0 to TCollection(aResultStatus).Count - 1 do
      Add.Assign(TCollection(aResultStatus).Items[i]);
  finally
    EndUpdate;
  end;
end;

constructor TResultStatus.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  fSilentMode:= false;
  fsIgnoreduplicateMsg := True;
end;

destructor TResultStatus.Destroy;
begin

  inherited;
end;
Procedure TResultStatus.AddMessageToXMLNode(const ParentNode :IXMLNode);
var
  x: integer;
  TmpNode : IXMLNode;
  oParentNode :IXMLNode;
begin
  if ParentNode = nil then Exit;
  if self.Count = 0 then Exit;
  oParentNode := ParentNode.Addchild('ObjectMessages');

  for x:= 0 to self.Count -1 do
      if TResultStatusItem(Items[x]).Severity = rssNone then begin
          if oParentNode.ChildNodes.FindNode('General') <> nil then
              TmpNode:= oParentNode.ChildNodes.FindNode('General')
          else TmpNode := oParentNode.Addchild('General');
          AddXMLNode(TmpNode , 'Description',TResultStatusItem(Items[x]).Message);
      end;
  for x:= 0 to self.Count -1 do
      if TResultStatusItem(Items[x]).Severity = rssInfo then begin
          if oParentNode.ChildNodes.FindNode('Information') <> nil then
              TmpNode:= oParentNode.ChildNodes.FindNode('Information')
          else TmpNode := oParentNode.Addchild('Information');
          AddXMLNode(TmpNode , 'Description',TResultStatusItem(Items[x]).Message);
      end;
  for x:= 0 to self.Count -1 do
      if TResultStatusItem(Items[x]).Severity = rssWarning then begin
          if oParentNode.ChildNodes.FindNode('Warning') <> nil then
              TmpNode:= oParentNode.ChildNodes.FindNode('Warning')
          else TmpNode := oParentNode.Addchild('Warning');
          AddXMLNode(TmpNode , 'Description',TResultStatusItem(Items[x]).Message);
      end;
  for x:= 0 to self.Count -1 do
      if TResultStatusItem(Items[x]).Severity = rssError then begin
          if oParentNode.ChildNodes.FindNode('Error') <> nil then
              TmpNode:= oParentNode.ChildNodes.FindNode('Error')
          else TmpNode := oParentNode.Addchild('Error');
          AddXMLNode(TmpNode , 'Description',TResultStatusItem(Items[x]).Message);
      end;
end;
function TResultStatus.Allmessages: String;
var
  st:TStringlist;
begin
  Result:= '';
  st:= TStringlist.Create;
  try
    if ReadMessages(st) then result := st.Text;
  finally
    Freeandnil(st);
  end;
end;

function TResultStatus.GetMessaages: string;
var
  x: integer;
begin
  result:= '';
  for x:= 0 to self.Count -1 do
  begin
    if x > 0 then
      result:= result + #13#10;
    case TResultStatusItem(Items[x]).Severity of
      rssNone: result:= result + 'None: ';
      rssInfo: result:= result + 'Info: ';
      rssWarning: result:= result + 'Warning: ';
      rssError: result:= result + 'Error: ';
    end;
    result:= result + TResultStatusItem(Items[x]).Message;
  end;
end;

function TResultStatus.HasCode(const aCode: integer): boolean;
var
  x: integer;
begin
  result:= false;
  for x:= 0 to self.Count -1 do begin
    if TResultStatusItem(Items[x]).Code = aCode then begin
      result:= true;
      break;
    end;
  end;
end;

function TResultStatus.GetPrefixedMessages(const Prefix: string): string;
var
  x: integer;
begin
  result:= '';
  for x:= 0 to self.Count -1 do
  begin
    if x > 0 then
      result:= result + #13#10;
    case TResultStatusItem(Items[x]).Severity of
      rssNone: result:= result + Prefix + 'None ';
      rssInfo: result:= result + Prefix + 'Info ';
      rssWarning: result:= result + Prefix + 'Warning ';
      rssError: result:= result + Prefix + 'Error ';
    end;
    result:= result + TResultStatusItem(Items[x]).Message;
  end;
end;

function TResultStatus.GetOperationOk: boolean;
var
  x: integer;
begin
  result:= true;
  for x:= 0 to self.Count -1 do
  begin
    if not TResultStatusItem(Items[x]).OperationOk then
    begin
      result:= false;
      Break;
    end;
  end;
end;

function TResultStatus.GetHasError: boolean;
var
  x: integer;
begin
  result:= false;
  for x:= 0 to self.Count -1 do begin
    if TResultStatusItem(Items[x]).Severity = rssError then begin
      result:= true;
      break;
    end;
  end;
end;

function TResultStatus.GetSeveritySet: TResultStatusSeveritySet;
var
  x: integer;
begin
  result:= [];
  for x:= 0 to self.Count -1 do
  begin
    if not (TResultStatusItem(Items[x]).Severity in result) then
      result:= result + [TResultStatusItem(Items[x]).Severity];
  end;
end;

function TResultStatus.GetSilentMode: boolean;
begin
  result:= fSilentMode;
end;

procedure TResultStatus.Reset;
begin
  self.Clear;
end;

procedure TResultStatus.SetSilentMode(const Value: boolean);
begin
  fSilentMode:= Value;
end;


function TResultStatus.ReadMessages(Strings: TStrings;
  Indent: string): boolean;
var
  x: integer;
begin
  for x:= 0 to Count -1 do begin
    case TResultStatusItem(Items[x]).Severity of
      rssNone: Strings.Add(Indent + TResultStatusItem(Items[x]).Message);
      rssInfo: Strings.Add(Indent + 'Info: ' + TResultStatusItem(Items[x]).Message);
      rssWarning: Strings.Add(Indent + 'Warning: ' + TResultStatusItem(Items[x]).Message);
      rssError: Strings.Add(Indent + 'Error: ' + TResultStatusItem(Items[x]).Message);
      else
        Strings.Add(Indent + TResultStatusItem(Items[x]).Message);
    end;
  end;
  result:= true;
end;

{ TResultStatusItem }

procedure TResultStatusItem.Assign(Source: TPersistent);
begin
  if Source is TResultStatusItem then begin
    Self.fOPerationOk := TResultStatusItem(Source).fOPerationOk;
    Self.fSeverity := TResultStatusItem(Source).fSeverity;
    Self.fCode := TResultStatusItem(Source).fCode;
    Self.fMessage := TResultStatusItem(Source).fMessage;
  end else
    inherited;
end;

constructor TResultStatusItem.Create(Collection: TCollection);
begin
    inherited;
  fOPerationOk:= true;
  fSeverity:= rssNone;
  fMessage:= '';
end;

function TResultStatusItem.GetCode: integer;
begin
  result:= fCode;
end;

function TResultStatusItem.GetMessaage: string;
begin
  result:= fMessage;
end;

function TResultStatusItem.GetOperationOk: boolean;
begin
  result:= fOperationOk;
end;

function TResultStatusItem.GetSeverity: TResultStatusSeverity;
begin
  result:= fSeverity;
end;

function TResultStatusItem.GetText: string;
begin
  case Severity of
    rssNone: result:= fMessage;
    rssInfo: result:= 'Info : ' + fMessage;
    rssWarning: result:= 'Warning : ' + fMessage;
    rssError: result:= 'Error : ' + fMessage;
    else result:= fMessage;
  end;
end;

procedure TResultStatusItem.SetCode(const Value: integer);
begin
  fCode:= Value;
end;

procedure TResultStatusItem.SetMessage(const Value: string);
begin
  fMessage:= Value;
end;

procedure TResultStatusItem.SetOperationOk(const Value: boolean);
begin
  fOperationOk:= Value;
end;

procedure TResultStatusItem.SetSeverity(const Value: TResultStatusSeverity);
begin
  fSeverity:= Value;
end;

function TResultStatus.GetFirstFatalStatusItem: TResultStatusItem;
var
  x: integer;
begin
  result:= nil;
  for x:= 0 to self.Count -1 do
  begin
    if not TResultStatusItem(Items[x]).OperationOk then
    begin
      result:= TResultStatusItem(Items[x]);
      Break;
    end;
  end;
end;

function TResultStatus.GetLastFatalStatusItem: TResultStatusItem;
var
  x: integer;
begin
  result:= nil;
  for x:= self.Count -1 downto 0 do
  begin
    if not TResultStatusItem(Items[x]).OperationOk then
    begin
      result:= TResultStatusItem(Items[x]);
      Break;
    end;
  end;
end;

function TResultStatus.GetLastStatusItem: TResultStatusItem;
begin
  if Count > 0 then
    result:= TResultStatusItem(Items[Count-1])
  else
    result:= nil;
end;

function TDatasetBusObj.ConnectionAssigned: Boolean;
begin
  Result := Assigned(fConnection);
end;

function TDatasetBusObj.DatasetAssigned: Boolean;
begin
  Result := Assigned(fDataset);
end;

function TDatasetBusObj.GetCanCreate: boolean;
begin
  Result := IgnoreAccesslevel or (AccessManager.AccessLevel in [1..3]);
  if result then
    if IsReadonly then
      result := False;
end;

function TDatasetBusObj.GetCanDelete: boolean;
begin
  Result := IgnoreAccesslevel or (AccessManager.AccessLevel = 1);
  if result then
    if IsReadonly then
      result := False;
end;

function TDatasetBusObj.GetCanRead: boolean;
begin
    try
         Result := IgnoreAccesslevel or (AccessManager.AccessLevel in [1..5]);
    Except
        on e:Exception do begin
            Result :=False;
            Resultstatus.AddItem(False , rsswarning , 0 , Self.Classname +':' +e.Message);
        end;
    end;
end;

function TDatasetBusObj.GetCanUpdate: boolean;
begin
  Result := IgnoreAccesslevel or
            (AccessManager.AccessLevel in [1..2]) or
            (DatasetAssigned and (fDataset.State = dsCalcFields));
  if result then
    if IsReadonly and (fDataset.State <> dsCalcFields) then
      result := False;
end;

function TDatasetBusObj.GetVars: TBusObjVars;
var
  Cls: TPersistentClass;
begin
  if Id > 0 then
    self.ContainerList.DoSetId(Id);
  result:= TBusObjVars(Container.ItemByClass(TBusObjVars,false));
  if not Assigned(result) then begin
    if VarsClassName = '' then
      result:= TBusObjVars.Create(nil)
    else begin
      Cls:= GetClass(VarsClassName);
      if Assigned(Cls) then
        result:= TBusObjVarsClass(Cls).Create(nil)
      else
        raise Exception.Create('TDatasetBusObj.GetVars - could not find specified TBusObjVars class: "' + VarsClassName + '"');
    end;
    Container.Add(result);
  end;
end;

class function TDatasetBusObj.IDToggle(const ID: Integer; Connection: TCustomMyConnection = nil; const AndSQL: string = ''): string;
var
  lQuery: TERPQuery;
  sl: TStringList;
  x: integer;
begin
  Result := '';
  if GetKeyStringField = '' then
    raise Exception.Create('KeyStringField not defined in ' + Self.ClassName);
  if ID = 0 then
    Exit;
  lQuery := TERPQuery.Create(nil);
  sl := TStringList.Create;
  try
    lQuery.Options.FlatBuffers := True;
    if Assigned(Connection) then
      lQuery.Connection := Connection
    else
      lQuery.Connection := CommonDBLib.GetSharedMyDacConnection;
    sl.CommaText:= GetKeyStringField;
    lQuery.SQL.Add('SELECT');
    for x := 0 to sl.Count -1 do begin
      if x = 0 then lQuery.SQL.Add('`' + sl[x] + '`')
      else lQuery.SQL.Add(',`' + sl[x] + '`')
    end;
    lQuery.SQL.Add('FROM ' + GetBusObjectTablename);
    lQuery.SQL.Add('WHERE ' + GetIDField + ' = ' + IntToStr(ID));
 //   lQuery.SQL.Text := Format('SELECT %s FROM %s WHERE %s = %d', [GetKeyStringField, GetBusObjectTablename, GetIDField, ID]);

    if AndSQL <> '' then
      lQuery.SQL.Add('AND ' + AndSQL);
    lQuery.Open;
    if not lQuery.Eof then begin
//      Result := lQuery.FieldByName(GetKeyStringField).AsString;
      sl.Clear;
      for x:= 0 to lQuery.FieldCount -1 do
        sl.Add(lQuery.Fields[x].AsString);
      if sl.Count = 1 then
        result:= sl[0]
      else
        result:= sl.CommaText;
    end;
  finally
    sl.Free;
    lQuery.Free;
  end;
end;

Class function TDatasetBusObj.XMLNodeName:String;
begin
  result:= Copy(self.classname,2,Length(self.classname));
end;

class function TDatasetBusObj._Schema: string;
begin
  with JO do begin
    AsString:= inherited;
    S['KeyStringProperty']:= GetKeyStringProperty;
    result:= AsString;
    free;
  end;
end;

class function TDatasetBusObj.IDGlobalRefToggle(const ID: Integer;
  Connection: TCustomMyConnection): string;
var
  qry: TERPQuery;
begin
  result:= '';
  if GetIDField = '' then
    raise Exception.Create('IDField not defined in ' + Self.ClassName);
  qry:= TERPQuery.Create(nil);
  try
    if Assigned(Connection) then
      qry.Connection:= Connection
    else
      qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select GlobalRef from ' + GetBusObjectTablename);
    qry.SQL.Add('where ' + GetIDField + ' = ' + IntToStr(ID));
    qry.Open;
    result:= qry.FieldByName('GlobalRef').AsString;
  finally
    qry.Free;
  end;
end;

class function TDatasetBusObj.IDGlobalRefToggle(const GlobalRef: string;
  Connection: TCustomMyConnection): integer;
var
  qry: TERPQuery;
begin
  if GetIDField = '' then
    raise Exception.Create('IDField not defined in ' + Self.ClassName);
  qry:= TERPQuery.Create(nil);
  try
    if Assigned(Connection) then
      qry.Connection:= Connection
    else
      qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select ' + GetIDField + ' from ' + GetBusObjectTablename);
    qry.SQL.Add('where GlobalRef = ' + QuotedStr(GlobalRef));
    qry.Open;
    result:= qry.FieldByName(GetIDField).AsInteger;
  finally
    qry.Free;
  end;
end;

Class function TDatasetBusObj.IDToggle(const KeyString: string; CreateNewifnotfound:boolean ;Cls: TPersistentClass;Connection: TCustomMyConnection = nil; const AndSQL: string = ''): Integer;
var
//  Qry:TERPQuery;
  obj :TDatasetBusObj;
begin
  Result :=TMSBusObjClass(Cls).IDToggle(KeyString,Connection,AndSQL);
  if (result =0) and (CreateNewifnotfound) and (TMSBusObjClass(cls).GetKeyStringField <> '') then begin

  if Cls <> nil then begin
    if (Connection <> nil) and (Connection <> GetSharedMyDacConnection) then begin
      obj := TMSBusObjClass(Cls).Create(nil);
      obj.connection := TMyDAcDataconnection.Create(obj);
      obj.connection.Connection := Connection;
    end else begin
      obj := TMSBusObjClass(Cls).CreateWithNewConn(nil);
    end;
    try
      obj.connection.BeginTransaction;
      try
        obj.LoadSelect(obj.KeyStringFieldName +' = ' + quotedstr(KeyString));
        if obj.count=0 then begin
          obj.New;
          obj.Editdb;
          obj.dataset.fieldbyname(obj.KeyStringFieldName).AsString :=KeyString;
          obj.PostDB;
          if obj.ValidateData =False then begin
            obj.connection.RollbackTransaction;
            Exit;
          end;
          if obj.Save =False then begin
            obj.connection.RollbackTransaction;
            Exit;
          end;
        end;
        obj.connection.CommitTransaction;
        result := obj.ID;
      Except
        on E:Exception do begin
          obj.connection.RollbackTransaction;
        end;
      end;
    finally
      Freeandnil(obj);
    end;

  end;
  (*    qry := DbSharedObj.GetQuery(connection );
    try
      qry.sql.text := 'Select * from '+ GetBusObjectTablename + ' where '  + GetIDField +' = 0';
      qry.open;
      qry.append;
      qry.fieldbyname(GetBusObjectTablename).asString := KeyString;
      qry.postDB;
    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    end;*)

  end;
end;
Class function TDatasetBusObj.IDToggle(ToggleKeyStringField:String;  const KeyString: string; Connection: TCustomMyConnection = nil; const AndSQL: string = ''): Integer;
var
  lQuery: TERPQuery;
  slFields, slKeys: TStringList;
  x: integer;
  s: string;
begin
  Result := 0;
  if ToggleKeyStringField = '' then ToggleKeyStringField := GetKeyStringField;

  if ToggleKeyStringField = '' then
    raise Exception.Create('KeyStringField not defined in ' + Self.ClassName);
  if KeyString = '' then
    Exit;

  lQuery := TERPQuery.Create(nil);
  slFields:= TStringList.Create;
  slKeys:= TStringList.Create;
  try
    lQuery.Options.FlatBuffers := True;
    if Assigned(Connection) then
      lQuery.Connection := Connection
    else
      lQuery.Connection := CommonDBLib.GetSharedMyDacConnection;

    slFields.CommaText:= ToggleKeyStringField;
    if slFields.Count = 1 then
      lQuery.SQL.Text := Format('SELECT %s FROM %s WHERE %s = %s', [GetIDField, GetBusObjectTablename, ToggleKeyStringField, QuotedStr(StringReplace(KeyString,'\','\\',[rfReplaceAll]))])
    else begin
      slKeys.CommaText:= KeyString;
      lQuery.SQL.Add('select ' + GetIDField + ' from  ' + GetBusObjectTablename + ' where');
      s:= '';
      for x := 0 to slFields.Count -1 do begin
        if slKeys[x] <> '' then begin
          if s <> '' then s:= s + ' and ';
          s:= s + '`' + slFields[x] + '` = ' + QuotedStr(StringReplace(slKeys[x],'\','\\',[rfReplaceAll]))
        end;
      end;
      lQuery.SQL.Add(s);
    end;

    if AndSQL <> '' then
      lQuery.SQL.Add('and ' + AndSQL);
    lQuery.Open;
    if not lQuery.Eof then
      Result := lQuery.FieldByName(GetIDField).AsInteger;
  finally
    slFields.Free;
    slKeys.Free;
    lQuery.Free;
  end;
end;

class function TDatasetBusObj.IDToggle(const KeyString: string; Connection: TCustomMyConnection = nil; const AndSQL: string = ''): Integer;
begin
  Result := 0;
  try
    if GetKeyStringField = '' then
         Result := IDToggle('Globalref', KeyString, Connection, AndSQL)
    else Result := IDToggle(GetKeyStringField, KeyString, Connection, AndSQL);
  except
    on E:Exception do begin
    end;
  end;
end;

class function TDatasetBusObj.GetKeyStringField: string;
begin
  Result := '';
end;

class function TDatasetBusObj.GetKeyStringProperty: string;
//var
//  s: string;
//  PropInfo: PPropInfo;
begin
  result:= '';
//  s:= Copy(ClassName,2,255) + 'Name';
//  PropInfo:= GetPropInfo(self,s);
//  if Assigned(PropInfo) then
//    result:= s;
end;

function TDatasetBusObj.GetKeyValue: string;
var
  slProp, slVal: TStringList;
  x: integer;
begin
  result:= '';
  if GetKeyStringProperty <> '' then begin
    slProp:= TStringList.Create;
    slVal:= TStringList.Create;
    try
      slProp.CommaText:= GetKeyStringProperty;
      if slProp.Count = 1 then result:= GetStrProp(self,slProp[0])
      else begin
        for x := 0 to slProp.Count -1 do begin
          slVal.Add(GetStrProp(self,slProp[x]));
        end;
        result:= slVal.CommaText;
      end;
    finally
      slProp.Free;
      slVal.Free;
    end;
  end;
end;

procedure TDatasetBusObj.SetIsList(const Value: boolean);
begin
  fIsList:= Value;
end;

procedure TDatasetBusObj.SetIsNew(const Value: boolean);
begin
  fIsNew := Value;
end;

procedure TDatasetBusObj.SetLargeintField(const FieldName: string;
  const Value: Largeint);
var
  fCurDBField: TField;
  fbFieldReadonly:Boolean;
Begin
  fCurDBField := Nil;
  If DSWriteOk Then    fCurDBField := Dataset.FindField(FieldName);
  check4FieldError(Fieldname,fCurDBField);
  //If fCurDBField <> Nil Then    fCurDBField.AsLargeint := Value
  If fCurDBField <> Nil Then begin
    fbFieldReadonly :=fCurDBField.Readonly;
    try
      if EnablePropertySetWhenReadonly and fCurDBField.Readonly then fCurDBField.Readonly := False;
      if fCurDBField.Readonly then Exit;
      if (fCurDBField.AsLargeint <>  Value)  OR ((fCurDBField.value = null) and (Value = 0))  then
        fCurDBField.AsLargeint := Value;
    finally
      fCurDBField.Readonly := fbFieldReadonly;
    end;
  end;
end;

procedure TDatasetBusObj.SetMsTimeStamp(const Value: TDateTime);
begin
  SetDateTimeField('msTimeStamp',Value);
end;

procedure TDatasetBusObj.SetMsUpdateSiteCode(const Value: string);
begin
  SetStringField('msUpdateSiteCode',Value);
end;

//procedure TDatasetBusObj.FilterSelect(const FilterName: string;
//  const Params: array of string);
//begin
//  Params
//end;

{ TSharedDataConnectionList }

function TSharedDataConnectionList.GetSharedDataConn(const ThreadId: Cardinal): TMyDacDataConnection;
Var
  tmpMyDacDataConnection :TMyDacDataConnection;
  I:Integer;
begin
  SharedDataConnLock.Acquire;
  Try
    If Self.Count>0 then
      for I := 0 to Self.Count-1 do begin
        tmpMyDacDataConnection := TMyDacDataConnection(Self.Items[I]);
        If (tmpMyDacDataConnection.fThreadId = ThreadId) Then Begin
          Result := tmpMyDacDataConnection;
          Exit;
        end;
    end;
    tmpMyDacDataConnection := TMyDacDataConnection.Create(nil);
    tmpMyDacDataConnection.MyDacConnection:= CommonDbLib.GetSharedMyDacConnection;

    tmpMyDacDataConnection.fThreadId := ThreadId;
    Result := tmpMyDacDataConnection;
    Self.Add(tmpMyDacDataConnection);
  Finally;
    SharedDataConnLock.Release;
  End;
end;

procedure TSharedDataConnectionList.RemoveSharedDataConnInstance;
Var
  tmpMyDacDataConnection :TMyDacDataConnection;
  I:Integer;
begin
  SharedDataConnLock.Acquire;
  Try
    If Self.Count>0 then
      for I := 0 to Self.Count-1 do begin
        tmpMyDacDataConnection := TMyDacDataConnection(Self.Items[I]);
        If (tmpMyDacDataConnection.ThreadId = GetCurrentThreadID) Then Begin
          Self.Remove(tmpMyDacDataConnection);
          Self.Pack;
          Exit;
        end;
      end;
  Finally;
    SharedDataConnLock.Release;
  End;
end;

function SharedDataConnection :TMyDacDataConnection;
Begin
  Result := SharedDataConnList.SharedDataConnection[GetCurrentThreadID];
//  result := TMyDacDataConnection(AppEnv.AppDb.Connection);
end;

function GetSharedDataConnection: TMyDacDataConnection;
begin
  result:= SharedDataConnection;
end;


{ TBusObjContainer }

constructor TBusObjContainer.Create(AOwner: TComponent);
begin
  inherited;
  fList:= TObjectList.Create(false);
end;

destructor TBusObjContainer.Destroy;
begin
  FreeandNil(fList);
  inherited;
end;

function TBusObjContainer.Add(Const aComponent: TComponent): integer;
begin
  if Assigned(Owner) and (aComponent.Owner <> Owner) then
    Owner.InsertComponent(aComponent);
  if aComponent is TDatasetBusObj then
    TDatasetBusObj(aComponent).fInContainer := True;
  result:= fList.Add(aComponent);
end;

function TBusObjContainer.GetItem(Const index: integer): TComponent;
begin
  result:= TBusObjBase(fList[index]);
end;

function TBusObjContainer.ItemByClass(Const aComponentClass: TComponentClass;
  Const CreateIfNotInList: boolean): TComponent;
var
  x: Integer;
begin
  Result := nil;
  for x := 0 to fList.Count - 1 do begin
    if fList[x] is aComponentClass then begin
      Result := TComponent(fList[x]);
      Break;
    end;
  end;

  if (Result = nil) and CreateIfNotInList then begin
    Result := aComponentClass.Create(Owner);
    fList.Add(Result);
    DoEvent(self.owner, evDSAfterCreate);
  end;
end;


function TBusObjContainer.GetCount: integer;
begin
  result:= fList.Count;
end;

procedure TBusObjContainer.Delete(Const index: integer);
begin
  try
    fList[index].Free;
  except
  end;
  fList.Delete(index);
end;

Function TBusObjContainer.ContainerNames:String;
var x: integer;
begin
  result := '';
  for x:= 0 to Count -1 do
    try
      if (Item[x] is TBusObjBase) then
        result := result +',' +TBusObjBase(Item[x]).classname;
    except
    end;


end;
procedure TBusObjContainer.DoEvent(const Sender: TObject;  const EventType: integer; const Data: TObject=nil; Proc : TProcBusObjBase= nil);
var x: integer;
begin
  for x:= 0 to Count -1 do
    try
      if (Item[x] is TBusObjBase) then
        TBusObjBase(Item[x]).DoEvent(Sender, EventType, Data ,Proc);
    except
    end;
end;

function TBusObjContainer.Exists(
  const aComponentClass: TComponentClass): boolean;
begin
  result := Assigned(self.ItemByClass(aComponentClass,false));
end;

procedure TBusObjContainer.FreeAndDelete(Const obj: TComponent);
var
  idx: integer;
begin
  idx:= fList.IndexOf(obj);
  if idx > -1 then begin
    fList[idx].Free;
    fList.Delete(idx);
  end;
end;

function TBusObjContainer.GetDirty: boolean;
var
  x: integer;
  lComp: TComponent;
  lVars: TBusObjVars;
begin
  Result := False;
  lVars := TBusObjVars(ItemByClass(TBusObjVars, False));
  if Assigned(lVars) and lVars.Dirty then
    Result := True
  else
    for x := Count - 1 downto 0 do begin
      lComp := Item[x];
      if ((lComp is TDatasetBusObj) and TDatasetBusObj(lComp).AnyDirty) or
         ((lComp is TBusObjNDS) and TBusObjNDS(lComp).Dirty) then begin
        Result := True;
        Break;
      end;
    end;
end;

procedure TBusObjContainer.SetDirty(const Value: boolean);
var
  x: integer;
  lComp: TComponent;
  lVars: TBusObjVars;
begin
  lVars := TBusObjVars(ItemByClass(TBusObjVars, False));
  if Assigned(lVars) then
    lVars.Dirty := Value;
  if not Value then begin
    for x := 0 to Count - 1 do begin
      lComp := Item[x];
      if lComp is TDatasetBusObj then
        TDatasetBusObj(lComp).AnyDirty := False
      else if lComp is TBusObjNDS then
        TBusObjNDS(lComp).Dirty:= False;
    end;
  end;
end;

procedure TBusObjContainer.Clear;
begin
  while fList.Count > 0 do
    self.Delete(0);
end;
procedure TBusObjContainer.Clear(Const aComponentClass: TComponentClass);
var
  x: integer;
begin
  for x:= 0 to fList.Count -1 do begin
    if fList[x] is aComponentClass then begin
      self.Delete(x);
      break;
    end;
  end;
end;
{ TBusObjContainerList }

constructor TBusObjContainerList.Create(AOwner: TComponent);
begin
  inherited;
  fList:= TObjectList.Create(false);
  fContainerWithZeroId:= false;
end;

destructor TBusObjContainerList.Destroy;
begin
  Clear;
  FreeandNil(fList);
  inherited;
end;

function TBusObjContainerList.Container(const Id: integer;
  const CreateIfNotInList: boolean): TBusObjContainer;
var
  x: integer;
  BusObjClass: TBusObjBaseClass;
  BusObj: TBusObjBase;
begin
  result:= nil;
  if Id = 0 then
    fContainerWithZeroId:= true;
  for x:= 0 to fList.Count -1 do begin
    if self.Item[x].Id = Id then begin
      result:= self.Item[x];
      break;
    end;
  end;
  if CreateIfNotInList and (not Assigned(result)) then begin
    result:= TBusObjContainer.Create(Owner);
    result.Id:= Id;
    fList.Add(result);
    { add extender business objects }
    for x:= 0 to ClassExtenderList.Count-1 do begin
      if (ClassExtenderList.ExtenderItem[x].ParentClassName = Owner.ClassName) then begin
        BusObjClass:= TBusObjBaseClass(GetClass(ClassExtenderList.ExtenderItem[x].ExtenderClassName));
        if Assigned(BusObjClass) then begin
          BusObj:= BusObjClass.Create(owner);
          Result.List.Add(BusObj);
        end;
      end
    end;
  end;
end;

function TBusObjContainerList.GetItem(Const index: integer): TBusObjContainer;
begin
  result:= TBusObjContainer(fList[index]);
end;

function TBusObjContainerList.GetCount: integer;
begin
  result := 0;
  if Assigned(fList) then
    result:= fList.Count;
end;

procedure TBusObjContainerList.Delete(Const Id: integer);
var
  x: integer;
  lItem: TBusObjContainer;
begin
  for x:= 0 to fList.Count-1 do begin
    lItem := Item[x];
    if lItem.Id = Id then begin
      while lItem.Count > 0 do
        lItem.Delete(0);
      fList[x].Free;
      fList.Delete(x);
      break;
    end;
  end;
end;

{ this should be called when a row with an unassigned id (zero) has its
  id  eg after cancel of a row that has been inserted but not yet posted }
procedure TBusObjContainerList.DoCancel;
begin
  if not fContainerWithZeroId then exit;
  Delete(0);
  fContainerWithZeroId:= false;
end;

{ this should be called when a container with an unassigned id (zero) has its
  id set eg after post }
procedure TBusObjContainerList.DoSetId(Const aId: integer);
var
  x, zeroIdx: integer;
  IdInList: boolean;
begin
  if not fContainerWithZeroId then exit;
  zeroIdx:= -1;
  IdInList:= false;
  for x:= 0 to fList.Count-1 do begin
    if Item[x].Id = 0 then
      zeroIdx:= x
    else if Item[x].Id = aId then begin
      IdInList:= true;
      break;
    end;
  end;
  if (not IdInList) and (zeroIdx > -1) then begin
    Item[zeroIdx].Id:= aId;
    fContainerWithZeroId:= false;
  end;
end;

function TBusObjContainerList.GetDirty: Boolean;
var
  x: Integer;
begin
  Result := False;
  for x := Count - 1 downto 0 do
    if Item[x].Dirty then begin
      Result := True;
      Break;
    end;
end;

procedure TBusObjContainerList.SetDirty(const Value: Boolean);
var
  x: Integer;
begin
  if not Value then
    for x := Count - 1 downto 0 do
      Item[x].Dirty := False;
end;

procedure TBusObjContainerList.Clear;
begin
  while Count > 0 do begin
    Item[0].Clear;
    fList[0].Free;
    fList.Delete(0);
  end;
end;

function TBusObj.GetLimitXMLFieldsOnSave: boolean;
begin
 if Assigned(Owner) and (Owner is TBusObj) then
   result:= TBusObj(Owner).LimitXMLFieldsOnSave
 else
   result:= fLimitXMLFieldsOnSave;
end;

procedure TBusObj.SetLimitXMLFieldsOnSave(const Value: boolean);
begin
 if Assigned(Owner) and (Owner is TBusObj) then
   TBusObj(Owner).LimitXMLFieldsOnSave:= Value
 else
   fLimitXMLFieldsOnSave:= Value;
end;

{ TBusObjVars }

constructor TBusObjVars.Create(aOwner: TComponent);
begin
  inherited;
  Dirty:= false;
  fValues:= TValueList.Create;
end;

destructor TBusObjVars.Destroy;
begin
  fValues.Free;
  inherited;
end;


function TBusObj.getCopyingTrans: Boolean;
begin
    if Self.Owner is TBusobj then result := TBusobj(Self.Owner).CopyingTrans
    else Result := fbCopyingTrans;
end;

function TBusObj.getLoadXMLinLoad: Boolean;
begin
  if Assigned(Owner) and (owner is  TBusObj) then result := TBusObj(owner).LoadXMLinLoad
  else Result := fbLoadXMLinLoad;
end;

function TBusObj.getFilter: String;
begin
  Result := '';
  if DatasetAssigned then
    Result := Dataset.Filter;
end;

function TBusObj.getFiltered: Boolean;
begin
  Result := False;
  if DatasetAssigned then
    Result := Dataset.Filtered;
end;

procedure TBusObj.setCopyingTrans(const Value: Boolean);
begin
    if Self.Owner is TBusobj then TBusobj(Self.Owner).CopyingTrans := Value
    else fbCopyingTrans := value;
end;

function TBusObj.getTransactionName: String;
begin
    if Self.Owner is TBusobj then Result := tBusobj(self.Owner).TransactionName
    else Result := self.XMLNodeName;
end;

class function TBusObj.ExportFooter: String;
begin
  REsult := 'FINAL' + Copy(Self.Classname , 1, Length(Self.Classname));
end;

class function TBusObj.ExportHeader: String;
begin
  REsult := '$' + Copy(Self.Classname , 1, Length(Self.Classname));
end;

function TBusObj.Validtocommit: Boolean;
begin
  Result := True;
  //descendants will override and use if necessary
end;


function TResultStatus.getHasWarning: Boolean;
var
  x: integer;
begin
  result:= false;
  for x:= 0 to self.Count -1 do begin
    if TResultStatusItem(Items[x]).Severity = rsswarning then begin
      result:= true;
      break;
    end;
  end;


end;

function TResultStatus.getHasAnyMessage: Boolean;
begin
  result := count <> 0;
end;

function TResultStatus.getHasinfo: Boolean;
var
  x: integer;
begin
  result:= false;
  for x:= 0 to self.Count -1 do begin
    if TResultStatusItem(Items[x]).Severity = rssinfo then begin
      result:= true;
      break;
    end;
  end;
end;

procedure TBusObj.SetFieldsToClone(const Value: String);
begin
  fsFieldsnotToclone := Value;
end;

procedure TBusObj.AddNewifMissing(const fHeader, fDataline: TStringList);
begin
  //descendants will overwrite for import option to search for the record before new
  New;
end;

procedure TBusObj.OnReGenerateNumber;
begin
  // descendants will override if required
end;

procedure TBusObj.OnSetpropErrors(const Propname, Value: String);
begin
  //descendants will override if required
end;

procedure TBusObj.UnlockAfterCopyUsingTransactionMaper(const Copiedobj :TBusobj);
var
  ctr:Integer;
begin
  for ctr := low(LockGroupNamesofCopiedObjs) to high(LockGroupNamesofCopiedObjs) do begin
    if LockGroupNamesofCopiedObjs[ctr] <> '' then
      if Copiedobj <> nil then
        Copiedobj.UserLock.Unlock(LockGroupNamesofCopiedObjs[ctr])
      else UserLock.Unlock(LockGroupNamesofCopiedObjs[ctr]);
  end;
end;

procedure TBusObj.AssignProgressdialog(const xPostList: TPostList);
begin
// descendants will override if required
// eg: busobjPayments
end;

procedure TBusObj.ValidateSubObjectCallbackProc(const Sender: TBusObj;
  var Abort: Boolean);
begin
  if not Sender.ValidateData then begin
    fAllSubObjectsValid:= false;
    Abort:= true;
  end;
end;

function TBusObj.ValidateDataList: boolean;
begin
   isAllRecValid:= True;
   IterateRecords(ValidateDataCallback);
   result := isAllRecValid;
end;
procedure TBusObj.ValidateDataCallback(Const Sender: TBusObj; var Abort: boolean) ;
begin
  if not Sender.ValidateData then begin
      isAllRecValid:= False;
      Abort := True;
  end;
end;

function TBusObj.ValidateSubObject(SubObj: TBusObj): boolean;
begin
  result:= true;
  if Assigned(SubObj) then begin
    fAllSubObjectsValid:= true;
    SubObj.IterateRecords(ValidateSubObjectCallbackProc);
    result:= fAllSubObjectsValid;
  end;
end;

procedure TBusObj.AfterCloneBusObj;
begin
// descendants will override if required
end;

procedure TBusObj.setfilter(const Value: String);
begin
  if DatasetAssigned then
    Dataset.Filter:= Value;
end;

procedure TBusObj.setfiltered(const Value: Boolean);
begin
  if DatasetAssigned then
    Dataset.Filtered:= Value;
end;

procedure TBusObj.setIsReadonly(const Value: boolean);
begin
  if fbIsReadonly = value then exit;
  inherited;
end;

function TBusObj.getIsReadonly: boolean;
begin
  result := inherited getIsReadonly;

end;

function TBusObj.getIteraterecordProgressbarMsg: String;
var
  obj :  TComponent;
begin
  Result := fsIteraterecordProgressbarMsg;
  if result = '' then begin
    obj := Self.owner;
    while obj is TBusObj do begin
      if TBusObj(Obj).fsIteraterecordProgressbarMsg<> '' then begin
        result:=TBusObj(Obj).fsIteraterecordProgressbarMsg;
        exit;
      end;
      obj:= obj.owner;
    end;
  end;
  if result = '' then result := WAITMSG;
end;

{ TERPComponent }

constructor TERPComponent.Create(AOwner: TComponent);begin  inherited;  (*Logit('Created :' + inttoStr(Integer(self))+',' + heirarchyname );*)end;
destructor  TERPComponent.Destroy;begin  (*Logit('Destoryed :' + inttoStr(Integer(self))+',' + heirarchyname); *) inherited;end;
// procedure   TERPComponent.Logit(const Value: String);begin  logtext(Value, replacestr(uppercase(Application.ExeName), '.EXE' ,'_ERPComponent.Log'));end;

function TERPComponent.heirarchyname(includeDsName: Boolean): String;
var
  obj:Tcomponent;
begin
  REsult := Self.ClassName +'.' + self.Name;
  obj := self.Owner;
  while obj<> nil do begin
    REsult := obj.ClassName + '->' +  result;
    obj := obj.Owner;
  end;
end;
{
var
  busobj :Tbusobj;
begin
  busobj := Tbusobj.CreateWithNewConn(Self);

  busobj := Tbusobj.Create(Self);
  busobj.connection :=TMyDacDataConnection.create(busobj);
  busobj.Connection.connection := Self.MyConnection;

  busobj.BusObjEvent := DoBusinessObjectEvent;
end;

}

initialization
  SharedDataConnList := TSharedDataConnectionList.Create;
  SharedDataConnLock := TCriticalSection.Create;
finalization
  FreeAndNil(SharedDataConnList);
  FreeAndNil(SharedDataConnLock);
end.













