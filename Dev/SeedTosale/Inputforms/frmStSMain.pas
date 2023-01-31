unit frmStSMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,ImageDLLLib, BaseInputForm, DNMSpeedButton, StdCtrls, Shader,
  ExtCtrls, DNMPanel, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  BusObjSeedToSale, Menus, ActnList, DNMAction, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, BusObjBase,BusObjEmployeeDetails, BusObjClass , IntegerListObj,
  frmStSInputBase, Mask, wwdbedit, ComCtrls ,wwDBDateTimePicker, StSConst, frmStSCreatePackage;

type
  TStrProc = Procedure (Value :String) of Object;
  TIntProc = Procedure (Value :Integer) of Object;

  TfmStSMain = class(TfmStSInputBase)
    pnlOptions: TDNMPanel;
    c: TActionList;
    act_ChangePhase             : TDNMAction;
    act_CreatePlantings         : TDNMAction;
    act_DestroyPlant            : TDNMAction;
    act_RECORD_ADDITIVES        : TDNMAction;
    act_RECORD_WASTE            : TDNMAction;
    act_TRANSFER                : TDNMAction;
    act_MANICURE_PLANTS         : TDNMAction;
    act_REPLACE_TAGS            : TDNMAction;
    act_CHANGE_ROOMS            : TDNMAction;
    actEmployees                : TDNMAction;
    actClass                    : TDNMAction;
    actSerialnumbers            : TDNMAction;
    actTopAction1               : TDNMAction;
    actTopAction2               : TDNMAction;
    act_CREATE_PACKAGES_PRODUCT : TDNMAction;

    QryEmployee: TERPQuery;
    QryEmployeeEmployeeNo: TIntegerField;
    QryEmployeeEmployeeID: TIntegerField;
    dsEmployee: TDataSource;
    qryststags: TERPQuery;
    qryststagsID: TIntegerField;
    qryststagsGlobalRef: TWideStringField;
    qryststagsStsTag: TWideStringField;
    qryststagsTagProductID: TIntegerField;
    qryststagsSourceTagID: TIntegerField;
    qryststagsSourceTag: TWideStringField;
    qryststagsSourcetype: TWideStringField;
    qryststagsDeptID: TIntegerField;
    qryststagsDept: TWideStringField;
    qryststagsUOMID: TIntegerField;
    qryststagsPlanttype: TWideStringField;
    qryststagsUsedOn: TDateTimeField;
    qryststagsStrainID: TIntegerField;
    qryststagsStrainName: TWideStringField;
    qryststagsPlantcount: TIntegerField;
    qryststagsChangedCount: TIntegerField;
    qryststagsWastedCount: TIntegerField;
    qryststagsDestroycount: TIntegerField;
    qryststagsTransferedCount: TIntegerField;
    qryststagsUsedCount: TIntegerField;
    qryststagsStSPhase: TWideStringField;
    qryststagsStSProductID: TIntegerField;
    qryststagsmstimeStamp: TDateTimeField;
    qryststagsmsUpdateSiteCode: TWideStringField;
    qryststagsStSPPhaseDesc: TWideStringField;
    QryEmployeeEmployeeName: TWideStringField;
    qryStSTag_Actions: TERPQuery;
    qryStSTag_ActionsID: TIntegerField;
    qryStSTag_ActionsGlobalRef: TWideStringField;
    qryStSTag_ActionsTagID: TIntegerField;
    qryStSTag_ActionsStatusDate: TDateTimeField;
    qryStSTag_ActionsStatusActionId: TIntegerField;
    qryStSTag_ActionsStatusAction: TWideStringField;
    qryStSTag_ActionsDescription: TWideStringField;
    qryStSTag_ActionsChangeToRoomID: TIntegerField;
    qryStSTag_ActionsReplaceTagId: TIntegerField;
    qryStSTag_Actionsmstimestamp: TDateTimeField;
    qryStSTag_ActionsmsUpdateSiteCode: TWideStringField;
    qryMain: TERPQuery;
    dsMain: TDataSource;
    qryMainID: TIntegerField;
    qryMainStsTag: TWideStringField;
    qryMainSourceTag: TWideStringField;
    qryMainSourcetype: TWideStringField;
    qryMainDept: TWideStringField;
    qryMainUsedOn: TDateTimeField;
    qryMainStrainName: TWideStringField;
    qryMainPlantcount: TIntegerField;
    qryMainStSPhase: TWideStringField;
    qryMainTagReplaceto: TWideStringField;
    qryMainStSPhaseDesc: TWideStringField;
    QrymainChangedCount: TIntegerField;
    QrymainWastedCount: TIntegerField;
    QrymainDestroycount: TIntegerField;
    QrymainTransferedCount: TIntegerField;
    QrymainUsedCount: TIntegerField;

    qryststagsEmployeeId: TIntegerField;
    qryststagsReplacedByTagID: TIntegerField;
    lblmsg: TLabel;
    pnlLeftTop: TDNMPanel;
    pnlRightTop: TDNMPanel;
    DNMPanel2: TDNMPanel;
    Label1: TLabel;
    edtBarcodeInput: TEdit;
    grdTags: TwwDBGrid;
    qryststagsBinID: TIntegerField;
    qryMainActivecount: TIntegerField;
    qryStSTag_ActionsSMLLineID: TIntegerField;
    qryStSTag_ActionsActionQty: TIntegerField;
    QryDeptClass: TERPQuery;
    dsDeptClass: TDataSource;
    QryDeptClassClassID: TIntegerField;
    QryDeptClassClassName: TWideStringField;
    DNMPanel1: TDNMPanel;
    grdDeptClasss: TwwDBGrid;
    wwIButton2: TwwIButton;
    grdEmployees: TwwDBGrid;
    wwIButton1: TwwIButton;
    DNMPanel3: TDNMPanel;
    DNMPanel4: TDNMPanel;
    DNMPanel5: TDNMPanel;
    Label2: TLabel;
    Label3: TLabel;
    wwDBEdit1: TwwDBEdit;
    wwDBEdit2: TwwDBEdit;
    qryStSTag_ActionsTagProductID: TIntegerField;
    qryStSTag_ActionsStSProductID: TIntegerField;
    qryMainHarvestCount: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtBarcodeInputExit(Sender: TObject);
    procedure edtBarcodeInputKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtBarcodeInputKeyPress(Sender: TObject; var Key: Char);
    procedure btnCloseClick(Sender: TObject);

    procedure act_ChangePhaseUpdate             (Sender: TObject);
    procedure act_CreatePlantingsUpdate         (Sender: TObject);
    procedure act_DestroyPlantUpdate            (Sender: TObject);
    procedure act_RECORD_ADDITIVESUpdate        (Sender: TObject);
    procedure act_RECORD_WASTEUpdate            (Sender: TObject);
    procedure act_TRANSFERUpdate                (Sender: TObject);
    procedure act_MANICURE_PLANTSUpdate         (Sender: TObject);
    procedure act_CREATE_PACKAGES_PRODUCTUpdate (Sender: TObject);
    procedure act_REPLACE_TAGSUpdate            (Sender: TObject);
    procedure act_CHANGE_ROOMSUpdate            (Sender: TObject);

    procedure act_ChangePhaseExecute            (Sender: TObject);
    procedure act_CreatePlantingsExecute        (Sender: TObject);
    procedure act_DestroyPlantExecute           (Sender: TObject);
    procedure act_RECORD_ADDITIVESExecute       (Sender: TObject);
    procedure act_RECORD_WASTEExecute           (Sender: TObject);
    procedure act_TRANSFERExecute               (Sender: TObject);
    procedure act_MANICURE_PLANTSExecute        (Sender: TObject);
    procedure act_CREATE_PACKAGES_PRODUCTExecute(Sender: TObject);
    procedure act_REPLACE_TAGSExecute           (Sender: TObject);
    procedure act_CHANGE_ROOMSExecute           (Sender: TObject);

    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure qryststagsBeforeOpen(DataSet: TDataSet);
    procedure grdTagsCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure actEmployeesExecute(Sender: TObject);
    procedure actClassExecute(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure qryMainBeforeOpen(DataSet: TDataSet);
    procedure btnCompletedClick(Sender: TObject);
    procedure actSerialnumbersExecute(Sender: TObject);
    procedure actSerialnumbersUpdate(Sender: TObject);
    procedure actTopAction1Execute(Sender: TObject);
    procedure actTopAction1Update(Sender: TObject);
    procedure actTopAction2Execute(Sender: TObject);
    procedure actTopAction2Update(Sender: TObject);
    procedure qryststagsAfterScroll(DataSet: TDataSet);
    procedure qryststagsAfterPost(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    btn_01  : TERPMainSwitchButton;
    btn_02  : TERPMainSwitchButton;
    btn_03  : TERPMainSwitchButton;
    btn_04  : TERPMainSwitchButton;
    btn_05  : TERPMainSwitchButton;
    btn_06  : TERPMainSwitchButton;
    btn_07  : TERPMainSwitchButton;
    btn_08  : TERPMainSwitchButton;
    btn_09  : TERPMainSwitchButton;
    btn_10  : TERPMainSwitchButton;
    BtnRighttop_1  : TERPMainSwitchButton;
    BtnRighttop_2  : TERPMainSwitchButton;
    BtnRighttop_3 : TERPMainSwitchButton;
    BtnRighttop_4 : TERPMainSwitchButton;
    BtnRighttop_5 : TERPMainSwitchButton;
    fiTransferToClassID:Integer;
    fiTransferToBinID:Integer;
    fdTransferDate :TDatetime;

    employeeId:Integer;
    fEmployee:TEmployeeDetails;
    DeptClassId:Integer;
    fDeptClass:TDeptClass;

    ProcessingBarcode:Boolean;
    SelectedTagIds:TIntegerList;
    fStSTag:TStSTags;
    fsChooseclassMsg:String;
    ///<summary> Controls the action and caption of button "Record Waste" </summary>
    ///<remarks> "Record Waste" if set True and "Recover from Waste" if set False </remarks>
    FDoRecordWaste: Boolean;
    ///<summary> Controls the action and caption of button "Destroy Plants" </summary>
    ///<remarks> "Destroy Plants" if set True and "Recover from Destroyed" if set False </remarks>
    FDoDestroyPlant: Boolean;
    procedure initSelectFromList(Sender: TObject);
    procedure OnSelectfromSelectFromList(Sender: TObject);
    procedure initInputText(Sender: TObject);
    function IsTagSelected: Boolean;
    function IsEmployeeSelected: Boolean;

    Function ChangePhaseProc(aBusobj:Tbusobj):Boolean;
    Function CreatePackageFunc(aBusobj:Tbusobj):Boolean;
    function CreateHarvestPackage(aObjPackage: TStSPackage; aGuiPackage: TfmStSInputBase): Boolean;
    function CreatePiecePackage(aObjPackage: TStSPackage; aGuiPackage: TfmStSInputBase): Boolean;

    procedure WMFormShowComplete(var aMsg: TMessage); message WM_FORM_SHOW_COMPLETE;

    var
      SelectFromListDatePnl :TDnmPanel;
      SelectFromListDate :TwwDBDateTimePicker;
    //SelectedtagNames :TStringList;
    //Selectedtags :String;

    procedure MakeButtons;
    procedure ProcessBarcode(const codeStr: string);
    Procedure ProcessEmployee(aEmployeeID:String);
    Procedure ProcessDeptClass(aDeptClassID:String);
    function Employee:TEmployeeDetails;
    function DeptClass:TDeptClass;
    Function StSTagcount :Integer;
    function ValidforStatusAction: Boolean;
    procedure OnchooseTag(aTag: String; aProcessTag:TIntProc; CreateForPhase:String='';openEditformAnyway :boolean = False;DoSave:Boolean =False);
    Function MyDAcDataconnection : TMyDAcDataconnection;
    Procedure RefreshTagList;
    procedure AddtagIDforTag(aStSTag:TStSTags);
    procedure ChooseTagIDForTag(aTAg:Integer);
    function QryStsTagWhere :String;
    function QryStsTagListWhere :String;
    function TagExists(aTag: String): Boolean;
    function getSelectedRecords(grd: TwwDBGrid): Boolean;
    procedure ChooseEmployee(Sender: TwwDBGrid);
    procedure ChooseStsClass(Sender: TwwDBGrid);
    procedure InitStSTags(Sender: TObject);
    procedure choosetag(Sender: TwwDBGrid);
    Procedure TimedMsg(Const Value:String);

    function TagAssigned(aTag: String): Boolean;
    procedure CleanForm;
    function isTagActive: Boolean;
    Function StSTag:TStSTags;
    function isPackageTag(const aTag: String): Boolean;
    function isPlantTag(const aTag: String): Boolean;
    function NewStsAction(const Value: String): Integer;
    procedure AssignProductTag(Value: Integer);
    Procedure ChooseClass(const msg: String);
    procedure beforeclaslistshow(Sender: TObject);
    procedure onchooseclass(Sender: TwwDbGrid);
    procedure LocateDept;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    procedure BeginTransaction; Override;
    procedure CommitTransaction; Override;
    procedure RollbackTransaction; Override;
  public
    procedure BeginNestedTransaction;
    procedure CommitNestedTransaction;
    procedure RollbackNestedTransaction;
    function  ProcessCreatePackage(aForm: TfmStSCreatePackage; aPackage: TStSPackage): Boolean;
    Property SelectedRecords[grd :TwwDBGrid] :Boolean Read getSelectedRecords;

  end;


implementation

uses CommonLib, ButtonsLib, Barcodeconst, FastFuncs,  BusObjConst, frmStSTag,
  DbSharedObjectsObj, CommonFormLib, frmMessageWithList, wwradiogroup,
  frmMessageBase, tcConst, StSLib, LogLib, CommonDbLib, frmStSChangePhase,
  MainSwitchFrm2, BaseListingForm, BusObjSimpleTypes, frmStSCreateImmaturePlant,
  AppEnvironment, StSClassBinList, FrmInputText,
  FrmSelectFromList, frmStSChangePhaseSimple, frmStSChangePhaseDetail, StSEmployeeExpressList, StSTags;

{$R *.dfm}
const
  ButtonsCount = 10;
  // Messages
  cChooseTag       = 'Please Choose a Tag to Change the Phase';
  cChooseEmployee  = 'Please Select an Employee';

procedure TfmStSMain.act_ChangePhaseUpdate              (Sender: TObject);begin   act_ChangePhase.Enabled             := True;  end;
procedure TfmStSMain.act_CreatePlantingsUpdate          (Sender: TObject);begin   act_CreatePlantings.Enabled         := True;  end;
procedure TfmStSMain.act_DestroyPlantUpdate             (Sender: TObject);begin   act_DestroyPlant.Enabled            := True;  end;
procedure TfmStSMain.act_RECORD_ADDITIVESUpdate         (Sender: TObject);begin   act_RECORD_ADDITIVES.Enabled        := True;  end;
procedure TfmStSMain.act_RECORD_WASTEUpdate             (Sender: TObject);begin   act_RECORD_WASTE.Enabled            := True;  end;
procedure TfmStSMain.act_TRANSFERUpdate                 (Sender: TObject);begin   act_TRANSFER.Enabled                := True;  end;
procedure TfmStSMain.act_MANICURE_PLANTSUpdate          (Sender: TObject);begin   act_MANICURE_PLANTS.Enabled         := True;  end;
procedure TfmStSMain.act_CREATE_PACKAGES_PRODUCTUpdate  (Sender: TObject);begin   act_CREATE_PACKAGES_PRODUCT.Enabled := True;  end;
procedure TfmStSMain.act_REPLACE_TAGSUpdate             (Sender: TObject);begin   act_REPLACE_TAGS.Enabled            := True;  end;
procedure TfmStSMain.act_CHANGE_ROOMSUpdate             (Sender: TObject);begin   act_CHANGE_ROOMS.Enabled            := True;  end;

procedure TfmStSMain.BeginTransaction         ; begin Inherited; end;
procedure TfmStSMain.RollbackTransaction      ; begin Inherited; end;
procedure TfmStSMain.CommitTransaction        ; begin Inherited; end;

procedure TfmStSMain.BeginNestedTransaction   ; begin MyDAcDataconnection.BeginNestedTransaction    ; end;
procedure TfmStSMain.RollbackNestedTransaction; begin MyDAcDataconnection.RollbackNestedTransaction ; end;
procedure TfmStSMain.CommitNestedTransaction  ; begin MyDAcDataconnection.CommitNestedTransaction   ; end;
procedure TfmStSMain.RefreshTagList;
begin
  showProgressbar(WAITMSG, 5);
  try
      StepProgressbar;
      if Pos( QryStsTagWhere, uppercase(qryststags.SQL.text))=0 then begin
        closedb(qryststags);
        qryststags.SQL.Text := 'Select * from tblststags '+ QryStsTagWhere;
        StepProgressbar;
        Opendb(qryststags);
      end;
      StepProgressbar;
      if Pos( QryStsTagListWhere, uppercase(Qrymain.SQL.text))=0 then begin
        closedb(Qrymain);
        qryststags.SQL.Text := 'Select * from tblststags '+ QryStsTagWhere;
        StepProgressbar;
        Opendb(Qrymain);
      end;
  finally
    HideProgressbar;
  end;
end;
procedure TfmStSMain.btnCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfmStSMain.btnCompletedClick(Sender: TObject);
begin
  inherited;
  CommitTransaction;
  Self.close;
end;

procedure TfmStSMain.edtBarcodeInputExit(Sender: TObject);
var
  keyChar: char;
begin
  inherited;
  if TEdit(Sender).Modified then begin
    TEdit(Sender).Modified:= false;
    keyChar:= chr(VK_RETURN);
    self.edtBarcodeInputKeyPress(edtBarcodeInput, keyChar);
  end;
end;
procedure TfmStSMain.edtBarcodeInputKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  edtBarcodeInput.Modified:= true;
end;

procedure TfmStSMain.edtBarcodeInputKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not ProcessingBarcode then
    Try
      ProcessingBarcode := true;
      if (Key = Chr(VK_RETURN)) or (Key = Chr(VK_TAB)) then begin
        Key := #0;   // eat VK_RETURN
        ProcessBarcode(Uppercase(edtBarcodeInput.Text));
        edtBarcodeInput.Text := '';
        SetControlfocus(edtBarcodeInput);
      end;
    Finally
      ProcessingBarcode := False;
    end;
  if (Key = Chr(VK_RETURN)) or (Key = Chr(VK_TAB)) then
    Key := #0;

end;

procedure TfmStSMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  action := cafree;
end;

procedure TfmStSMain.FormCreate(Sender: TObject);
begin
  inherited;
  fsChooseclassMsg:='';
  fStSTag := nil;
  //Selectedtags :='';
  //SelectedtagNames:= TStringList.create;
  SelectedTagIds :=TIntegerList.Create;
  //SelectedTagIds.Add(0);
  ProcessingBarcode := false;
  fEmployee:=nil;
  fDeptClass:=nil;
  FDoDestroyPlant := True;
  FDoRecordWaste  := True;
  MakeButtons;
end;

procedure TfmStSMain.FormDestroy(Sender: TObject);
begin
  FreeandNil(SelectedTagIds);
  Freeandnil(fStSTag);
  inherited;
end;

procedure TfmStSMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
       if key = VK_F2 then  act_ChangePhaseExecute(act_ChangePhase)
  else if key = VK_F3 then  act_CreatePlantingsExecute(act_CreatePlantings)
  else if key = VK_F4 then  act_DestroyPlantExecute(act_DestroyPlant)
  else if key = VK_F5 then  act_RECORD_ADDITIVESExecute(act_RECORD_ADDITIVES)
  else if key = VK_F6 then  act_RECORD_WASTEExecute(act_RECORD_WASTE)
  else if key = VK_F7 then  act_TRANSFERExecute(act_TRANSFER)
  else if key = VK_F9 then  act_MANICURE_PLANTSExecute(act_MANICURE_PLANTS);

end;

procedure TfmStSMain.FormShow(Sender: TObject);
var
  Keychar: Char;
begin
  inherited;
  Employee;
  LocateDept;
  Openqueries;
  BeginTransaction;
  if self.height < MainSwitch2.height then  begin
    self.height :=  MainSwitch2.height;
    self.top :=  MainSwitch2.top;
  end;
  Setcontrolfocus(edtBarcodeInput);

  edtBarcodeInput.text := Barcode_Prefix_Employee + '-' + IntToStr(EmployeeID);
  Keychar := chr(VK_RETURN);
  self.edtBarcodeInputKeyPress(edtBarcodeInput, Keychar);

  PostMessage(Handle, WM_FORM_SHOW_COMPLETE, 0, 0);
end;

function TfmStSMain.getSelectedRecords(grd: TwwDBGrid): Boolean;
begin
   grd.SelectedList.Count;
   Result := False;
end;

procedure TfmStSMain.grdTagsCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  Afont.color := ClBlack;
       if qrymainStSPhase.asString = 'I' then Abrush.color := Phase_color_Immature
  else if qrymainStSPhase.asString = 'V' then Abrush.color := Phase_color_Vegetative
  else if qrymainStSPhase.asString = 'F' then Abrush.color := Phase_color_Flowering
  else if qrymainStSPhase.asString = 'H' then Abrush.color := Phase_color_Harvest
  else if qrymainStSPhase.asString = 'P' then Abrush.color := Phase_color_Product
  else if qrymainStSPhase.asString = 'D' then Abrush.color := Phase_color_Destroy   ;

end;

procedure TfmStSMain.MakeButtons;
var
  btnWidth :Integer;
  btnTop  :Integer;
  btnheight :Integer;
begin
    act_ChangePhase.caption     := STS_ACTION_CHANGE_GROWTH_PHASE;
    act_CreatePlantings.caption := STS_ACTION_CREATE_PLANTINGS;
    act_DestroyPlant.caption    := STS_ACTION_DESTROY_PLANTS;
    act_RECORD_ADDITIVES.caption := STS_ACTION_RECORD_ADDITIVES;
    act_RECORD_WASTE.caption := STS_ACTION_RECORD_WASTE;
    act_TRANSFER.caption := STS_ACTION_TRANSFER;
    act_MANICURE_PLANTS.caption := STS_ACTION_MANICURE_PLANTS;
    act_CREATE_PACKAGES_PRODUCT.caption := STS_ACTION_CREATE_PACKAGES_PRODUCT;
    act_REPLACE_TAGS.caption := STS_ACTION_REPLACE_TAGS;
    act_CHANGE_ROOMS.caption := STS_ACTION_CHANGE_ROOMS;

    btnWidth  := trunc((pnlOptions.width-4-(ButtonsCount*2))/10);// 110;
    btnheight := 91;
    btnTop := trunc((pnlOptions.height -btnheight)/2)-1;
    btn_01 := TERPMainSwitchButton.create(Self);  With btn_01  do begin  Name := MakeName(Self,'btn_01'); Parent := pnlOptions;width := btnWidth;Height := btnHeight;Left := btnleft(ButtonsCount, btnWidth , 1, pnlOptions);Top := btnTop; DnmAction := act_ChangePhase            ;end;
    btn_02 := TERPMainSwitchButton.create(Self);  With btn_02  do begin  Name := MakeName(Self,'btn_02'); Parent := pnlOptions;width := btnWidth;Height := btnHeight;Left := btnleft(ButtonsCount, btnWidth , 2, pnlOptions);Top := btnTop; DnmAction := act_CreatePlantings        ;end;
    btn_03 := TERPMainSwitchButton.create(Self);  With btn_03  do begin  Name := MakeName(Self,'btn_03'); Parent := pnlOptions;width := btnWidth;Height := btnHeight;Left := btnleft(ButtonsCount, btnWidth , 3, pnlOptions);Top := btnTop; DnmAction := act_DestroyPlant           ;end;
    btn_04 := TERPMainSwitchButton.create(Self);  With btn_04  do begin  Name := MakeName(Self,'btn_04'); Parent := pnlOptions;width := btnWidth;Height := btnHeight;Left := btnleft(ButtonsCount, btnWidth , 4, pnlOptions);Top := btnTop; DnmAction := act_RECORD_ADDITIVES       ;end;
    btn_05 := TERPMainSwitchButton.create(Self);  With btn_05  do begin  Name := MakeName(Self,'btn_05'); Parent := pnlOptions;width := btnWidth;Height := btnHeight;Left := btnleft(ButtonsCount, btnWidth , 5, pnlOptions);Top := btnTop; DnmAction := act_RECORD_WASTE           ;end;
    btn_06 := TERPMainSwitchButton.create(Self);  With btn_06  do begin  Name := MakeName(Self,'btn_06'); Parent := pnlOptions;width := btnWidth;Height := btnHeight;Left := btnleft(ButtonsCount, btnWidth , 6, pnlOptions);Top := btnTop; DnmAction := act_TRANSFER               ;end;
    btn_07 := TERPMainSwitchButton.create(Self);  With btn_07  do begin  Name := MakeName(Self,'btn_07'); Parent := pnlOptions;width := btnWidth;Height := btnHeight;Left := btnleft(ButtonsCount, btnWidth , 7, pnlOptions);Top := btnTop; DnmAction := act_MANICURE_PLANTS        ;end;
    btn_08 := TERPMainSwitchButton.create(Self);  With btn_08  do begin  Name := MakeName(Self,'btn_08'); Parent := pnlOptions;width := btnWidth;Height := btnHeight;Left := btnleft(ButtonsCount, btnWidth , 8, pnlOptions);Top := btnTop; DnmAction := act_CREATE_PACKAGES_PRODUCT;end;
    btn_09 := TERPMainSwitchButton.create(Self);  With btn_09  do begin  Name := MakeName(Self,'btn_08'); Parent := pnlOptions;width := btnWidth;Height := btnHeight;Left := btnleft(ButtonsCount, btnWidth , 9, pnlOptions);Top := btnTop; DnmAction := act_REPLACE_TAGS           ;end;
    btn_10 := TERPMainSwitchButton.create(Self);  With btn_10  do begin  Name := MakeName(Self,'btn_10'); Parent := pnlOptions;width := btnWidth;Height := btnHeight;Left := btnleft(ButtonsCount, btnWidth ,10, pnlOptions);Top := btnTop; DnmAction := act_CHANGE_ROOMS           ;end;

    BtnRighttop_1	:= TERPMainSwitchButton.create(Self);  With BtnRighttop_1  do begin Name := MakeName(Self,'BtnRighttop_1'); Parent := pnlleftTop;   Left := btnleft(3, btnWidth ,3, pnlLeftTop );Top := btnTop;Width := btnWidth;Height := btnHeight;visible := true;DnmAction := actEmployees    ;end;
    BtnRighttop_2	:= TERPMainSwitchButton.create(Self);  With BtnRighttop_2  do begin Name := MakeName(Self,'BtnRighttop_2'); Parent := pnlleftTop;   Left := btnleft(3, btnWidth ,2, pnlLeftTop );Top := btnTop;Width := btnWidth;Height := btnHeight;visible := true;DnmAction := actclass        ;end;
    BtnRighttop_3	:= TERPMainSwitchButton.create(Self);  With BtnRighttop_3  do begin Name := MakeName(Self,'BtnRighttop_3'); Parent := pnlRightTop;  Left := btnleft(3, btnWidth ,1, pnlRightTop);Top := btnTop;Width := btnWidth;Height := btnHeight;visible := true;DnmAction := actSerialnumbers;end;
    BtnRighttop_4	:= TERPMainSwitchButton.create(Self);  With BtnRighttop_4  do begin Name := MakeName(Self,'BtnRighttop_4'); Parent := pnlRightTop;  Left := btnleft(3, btnWidth ,2, pnlRightTop);Top := btnTop;Width := btnWidth;Height := btnHeight;visible := true;DnmAction := actTopAction1   ;end;
    BtnRighttop_5	:= TERPMainSwitchButton.create(Self);  With BtnRighttop_5  do begin Name := MakeName(Self,'BtnRighttop_5'); Parent := pnlRightTop;  Left := btnleft(3, btnWidth ,3, pnlRightTop);Top := btnTop;Width := btnWidth;Height := btnHeight;visible := true;DnmAction := actTopAction2   ;end;
    grdEmployees.Margins.Bottom := btntop;
    grdDeptClasss.Margins.Bottom := btntop;
end;
function TfmStSMain.MyDAcDataconnection: TMyDAcDataconnection;
begin
  REsult := Employee.Connection;
end;

procedure TfmStSMain.DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
             if Sender is TEmployeeDetails then TEmployeeDetails(Sender).Dataset:= QryEmployee
        else if Sender is TDeptClass then TDeptClass(Sender).Dataset:= QryDeptClass
        else if Sender is TStSTag_Actions  then TStSTag_Actions(Sender).Dataset := qryStSTag_Actions
  end else   if (Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterInsert) and (Sender is TStSTags) then begin
    TStSTags(Sender).EmployeeID := employeeId;
    TStSTags(Sender).DeptID := DeptClassId;
  end else   if (Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterInsert) and (Sender is TStSTagProduct) then begin
    TStSTagProduct(Sender).EmployeeID := employeeId;
  end else if (Eventtype = BusobjEvent_Event) and (Value = BusobjEvent_OnREdUserLock) and (Sender is TDatasetBusObj) then begin
    TDatasetBusObj(Sender).UserLock := UserLock;
  end else   if (Eventtype = BusObjEvent_Change) and (Value = BusObjEventVal_DeptChanged) and (Sender is TStSTags) then begin
    Deptclassid := TStSTags(Sender).DeptID;
  end else begin
    inherited;
  end;
end;
function TfmStSMain.Employee:TEmployeeDetails;
begin
  if fEmployee = nil then begin
    fEmployee:=TEmployeeDetails.Create(Self);
    fEmployee.connection := TMyDacDataConnection.create(fEmployee);
    fEmployee.connection.connection := MyConnection;
    fEmployee.BusObjEvent := DoBusinessObjectEvent;

    if EmployeeID = 0 then begin
      fEmployee.Load;
      EmployeeID := fEmployee.ID;
      fEmployee.Close;
    end;
  end;
  if fEmployee.ID <> EmployeeId then
    fEmployee.load(EmployeeID);
  Result :=fEmployee;
end;
function TfmStSMain.DeptClass:TDeptClass;
begin
  if fDeptClass = nil then begin
    fDeptClass:=TDeptClass.Create(Self);
    fDeptClass.connection := TMyDacDataConnection.create(fDeptClass);
    fDeptClass.connection.connection := MyConnection;
    fDeptClass.BusObjEvent := DoBusinessObjectEvent;
    fDeptClass.Load(DeptClassId);
  end;
  if DeptClassId =0 then DeptClassId := AppEnv.CompanyPrefs.StSConfig.StsDefaultclassId;//Appenv.defaultclass.ClassId;
  if fDeptClass.ID <> DeptClassId then
    fDeptClass.load(DeptClassId);
  Result :=fDeptClass;
end;

Procedure TfmStSMain.ProcessEmployee(aEmployeeID:String);
begin
  EmployeeId := 0;
  if ISInteger(aEmployeeID) then begin
    EmployeeId := StrToInt(aEmployeeId);
    if Employee.Count =0 then begin
      MessageDlgXP_vista('Employee Login Failed.', mtWarning, [mbOK], 0);
      SetcontrolFocus(edtBarcodeInput);
      Exit;
    end;
  end;
end;
Procedure TfmStSMain.ProcessDeptClass(aDeptClassID:String);
begin
  DeptClassId := 0;
  if ISInteger(aDeptClassID) then begin
    DeptClassId := StrToInt(aDeptClassId);
    if DeptClass.Count =0 then begin
      MessageDlgXP_vista('Selected ' + Appenv.defaultclass.classheading+' is invalid, Set to the Default  ' + Appenv.defaultclass.classheading+'.', mtWarning, [mbOK], 0);
      ProcessDeptClass(inttostr(AppEnv.CompanyPrefs.StSConfig.StsDefaultclassId(*Appenv.defaultclass.ClassId*)));
      Exit;
    end;
  end;
end;

procedure TfmStSMain.qryMainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qrymain.SQL.Text := 'SELECT Tags.ID, '+
                      ' Tags.StsTag, '+
                      ' Tags.SourceTag, '+
                      ' Tags.sourcetype, '+
                      ' Tags.Dept, '+
                      ' Tags.UsedOn, '+
                      ' Tags.StrainName, '+
                      ' Tags.Plantcount, '+
                      ' Tags.ChangedCount, '+
                      ' Tags.WastedCount, '+
                      ' Tags.Destroycount, '+
                      ' Tags.TransferedCount, '+
                      ' Tags.HarvestCount, '+
                      ' Tags.UsedCount, '+
                      ' Tags.StSPhase, '+
                      ' ReplTags.StSTag as tagreplaceto'+
                      ' FROM '+
                      ' tblststags Tags '+
                      ' LEFT JOIN tblststags ReplTags ON Tags.REplacedByTagID = ReplTags.ID '+
                      QryStsTagListWhere;
end;

procedure TfmStSMain.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
       if qrymainStSPhase.asString ='I' then qryMainStSPhaseDesc.AsString := 'Immature'
  else if qrymainStSPhase.asString ='V' then qryMainStSPhaseDesc.AsString := 'Vegetative'
  else if qrymainStSPhase.asString ='F' then qryMainStSPhaseDesc.AsString := 'Flowering'
  else if qrymainStSPhase.asString ='H' then qryMainStSPhaseDesc.AsString := 'Harvest'
  else if qrymainStSPhase.asString ='P' then qryMainStSPhaseDesc.AsString := 'Product'
  else if qrymainStSPhase.asString ='D' then qryMainStSPhaseDesc.AsString := 'Destory'
  else qryMainStSPhaseDesc.AsString := '';
  Qrymainactivecount.asInteger := QrymainPlantcount.asInteger - (QrymainChangedCount.asInteger +
                                                                 QrymainWastedCount.asInteger+
                                                                 QrymainDestroycount.asInteger+
                                                                 QrymainTransferedCount.asInteger+
                                                                 QrymainHarvestCount.asInteger+
                                                                 QrymainUsedCount.asInteger);
end;

procedure TfmStSMain.qryststagsAfterPost(DataSet: TDataSet);
begin
  inherited;
  LocateDept;
end;
procedure TfmStSMain.LocateDept;
begin
  if (qryststagsID.asInteger <>0) and (qryststagsDeptID.asInteger <> 0) then begin
    DeptclassId :=qryststagsDeptID.asInteger;
    BtnRighttop_5.visible := False;
    ActClass.visible := False;
  end else begin
    DeptclassId :=AppEnv.CompanyPrefs.StSConfig.StsDefaultclassId;//Appenv.defaultclass.ClassId;
    BtnRighttop_5.visible := True;
    ActClass.visible := True;
  end;
    DeptClass;
end;
procedure TfmStSMain.qryststagsAfterScroll(DataSet: TDataSet);
begin
  inherited;
  LocateDept;
end;

procedure TfmStSMain.qryststagsBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  //qryststags.SQL.Text := 'Select * from tblststags '+ QryStsTagWhere;
end;

Function TfmStSMain.StSTagcount :Integer;
begin
  result := 0;
  try
    Result := SelectedTagIds.Count;
  Except
  end;
end;
Function TfmStSMain.ValidforStatusAction:Boolean;
begin
  Result := False;
  try
    if employeeId =0 then exit;
    if DeptClassId =0 then exit;
    if StSTagcount =0 then exit;
    Result := True;
  Except
    //
  end;
end;

procedure TfmStSMain.WMFormShowComplete(var aMsg: TMessage);
begin
  actSerialnumbersExecute(nil);
end;

function TfmStSMain.TagAssigned(aTag:String):Boolean;
var
  Qry:TERPQuery;
begin
  Qry := Employee.SharedQuery;
  try
    Qry.sql.text := 'SELECT * FROM tblststags where StSTag = '+quotedstr(aTag);
    Qry.open;
    result := Qry.Recordcount>0;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
function TfmStSMain.TagExists(aTag:String):Boolean;
var
  Qry:TERPQuery;
begin
  Qry := Employee.SharedQuery;
  try
    Qry.sql.text := 'SELECT distinct pqa.productname, pqa.productID , pqa.uomid, pqa.uom, PQAB.BinID '+
                    ' FROM tblpqadetails PQASN '+
                    ' Left join tblpqadetails  PQAB on PQAB.Globalref = PQASN.ParentRef and PQAB.PQAType = "Bin" ' +
                    ' INNER JOIN tblpqa pqa ON pqasn.pqaid = pqa.pqaid '+
                    ' WHERE PQASN.PQAType ="SN" '+
                    ' AND pqasn.value = '+quotedstr(aTag);

    Qry.open;
    result := Qry.Recordcount>0;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
procedure TfmStSMain.TimedMsg(const Value: String);
begin
  TimerMsg(lblMsg, Value);
end;

procedure TfmStSMain.OnchooseTag(aTag:String; aProcessTag:TIntProc; CreateForPhase:String='';openEditformAnyway :boolean = False;DoSave:Boolean =False);
var
  StSTagform :TfmStSTag;
  aStSTag:TStSTags;
begin
    {tag as a serial number exists }
    if not(TagExists(aTag)) then begin
      MessageDlgXP_vista('Invalid Tag '+Quotedstr(aTag)+'.', mtWarning, [mbOK], 0);
      SetcontrolFocus(edtBarcodeInput);
      Exit;
    end;

    {if tag already assigned }
    aStSTag:= TStSTags.create(self);
    try
      aStSTag.BusObjEvent := DoBusinessObjectEvent;
      aStSTag.Connection := fEmployee.connection;

      {when tag is transfered, the transfered from will have 0 active count and transfered to can have available qty}
      aStSTag.loadSelect('StSTag =' + quotedstr(aTag)+' and Plantcount - (ChangedCount +WastedCount+Destroycount+TransferedCount+UsedCount)>0');
      if aStSTag.count =0 then
        aStSTag.loadSelect('StSTag =' + quotedstr(aTag));

      if aStSTag.count >=1 then begin
          //if not aStSTag.Locate('PhaseChanged;TagReplaced;TagWasted', vararrayof(['F','F','F']), []) then begin
          if aStSTag.Activecount <=0 then begin
              MessageDlgXP_vista('Tag '+Quotedstr(aTag)+' is Phase Changed / Replaced / Wasted.', mtWarning, [mbOK], 0);
              SetcontrolFocus(edtBarcodeInput);
          end;

        if Assigned(aProcessTag) then aProcessTag(aStSTag.ID); // aStSTag.ID is tblststags.ID
        //ChooseTagIDForTag(aStSTag);
        if not openEditformAnyway then begin
          if DoSave then begin
            aStSTag.PostDB;
            if not aStSTag.Save then begin
              // Save shouldn't fail
              // save creates the stock movements
            end;
          end;
          Exit;
        end;
      end;
    finally
      Freeandnil(aStSTag);
    end;


    StSTagform := TfmStSTag.Create(self, MyDAcDataconnection,aTag);
    try
      if CreateForPhase <> '' then StSTagform.CreateForPhase := CreateForPhase;
      if StSTagform.Showmodal = mrok then begin
        if Assigned(aProcessTag) then aProcessTag(StSTagform.StSTagObj.ID);
        //ChooseTagIDForTag(StSTagform.StSTagObj);
      end else begin
        RollbackTransaction;
        //RefreshTagList;
      end;
    finally
      FreeandNil(StSTagform);
    end;
    cleanform;
end;

procedure TfmStSMain.ChooseTagIDForTag(aTAg:Integer);
var
  aStSTag:TStSTags;
begin
    aStSTag:= TStSTags.create(self);
    try
      aStSTag.BusObjEvent := DoBusinessObjectEvent;
      aStSTag.Connection := fEmployee.connection;
      aStSTag.Load(aTAg);
      if aStSTag.ID<>0 then
        if SelectedTagIds.indexof(aStSTag.ID) <0 then begin
          SelectedTagIds.clear;
          SelectedTagIds.Add(aStSTag.ID);
          RefreshTagList;

      end;
    finally
      Freeandnil(aStSTag);
    end;
end;
procedure TfmStSMain.AddtagIDforTag(aStSTag:TStSTags);
begin
  if aStSTag.ID<>0 then
    if SelectedTagIds.indexof(aStSTag.ID) <0 then begin
      SelectedTagIds.Add(aStSTag.ID);
      RefreshTagList;
    end;
end;
procedure TfmStSMain.ProcessBarcode(const codeStr: string);
var
  sl: TStringList;
begin
  if codeStr ='' then exit;
  sl:= TStringList.Create;
  try
    fastfuncs.Split(codeStr,Barcode_SepChar,sl);
    if (sl.Count > 1) and (sl[0] = Barcode_Prefix_Employee) then begin
        ProcessEmployee(sl[1]);
    end else if (sl.Count > 1) and (sl[0] = Barcode_Prefix_DeptClass) then begin
        ProcessDeptClass(sl[1]);
    end else if codeStr = STS_ACTION_CHANGE_GROWTH_PHASE		  then begin if not(ValidforStatusAction) then exit;  act_ChangePhaseExecute(act_ChangePhase);
    end else if codeStr = STS_ACTION_CREATE_PLANTINGS		      then begin if not(ValidforStatusAction) then exit;  act_CreatePlantingsExecute(act_CreatePlantings);
    end else if codeStr = STS_ACTION_DESTROY_PLANTS		        then begin if not(ValidforStatusAction) then exit;  act_DestroyPlantExecute(act_DestroyPlant);
    end else if codeStr = STS_ACTION_RECORD_ADDITIVES		      then begin if not(ValidforStatusAction) then exit;  act_RECORD_ADDITIVESExecute(act_RECORD_ADDITIVES);
    end else if codeStr = STS_ACTION_RECORD_WASTE		          then begin if not(ValidforStatusAction) then exit;  act_RECORD_WASTEExecute(act_RECORD_WASTE);
    end else if codeStr = STS_ACTION_TRANSFER		              then begin if not(ValidforStatusAction) then exit;  act_TRANSFERExecute(act_TRANSFER);
    end else if codeStr = STS_ACTION_MANICURE_PLANTS		      then begin if not(ValidforStatusAction) then exit;  act_MANICURE_PLANTSExecute(act_MANICURE_PLANTS);
    end else if codeStr = STS_ACTION_CREATE_PACKAGES_PRODUCT	then begin if not(ValidforStatusAction) then exit;  act_CREATE_PACKAGES_PRODUCTExecute(act_CREATE_PACKAGES_PRODUCT);
    end else if codeStr = STS_ACTION_REPLACE_TAGS		          then begin if not(ValidforStatusAction) then exit;  act_REPLACE_TAGSExecute(act_REPLACE_TAGS);
    end else if codeStr = STS_ACTION_CHANGE_ROOMS		          then begin if not(ValidforStatusAction) then exit;  act_CHANGE_ROOMSExecute(act_CHANGE_ROOMS);
    end else begin // assume its tags
      if Employee.id = 0 then begin
        CommonLib.MessageDlgXP_Vista('Please Select an Employee' , mtWarning, [mbOk], 0);
        Exit;
      end;
      if DeptClass.id = 0 then begin
        CommonLib.MessageDlgXP_Vista('Please Select a  ' + Appenv.defaultclass.classheading+'.' , mtWarning, [mbOk], 0);
        Exit;
      end;
      OnchooseTag(codeStr, ChooseTagIDForTag);
    end;
  finally
    Freeandnil(sl);
  end;
end;

function TfmStSMain.ProcessCreatePackage(aForm: TfmStSCreatePackage; aPackage: TStSPackage): Boolean;
var
  objPackage: TStSPackage;
begin
  Result := False;

  Assert(aForm <> nil, 'Expected aForm <> nil');

  if aPackage <> nil then
    objPackage := aPackage
  else
    objPackage := aForm.StsPackage;


  try
    BeginTransaction;

    // what Package type used?
    case aForm.PackageType of

      pkgImmature, pkgVegetative, pkgPackage:
        Result := CreatePiecePackage(objPackage, aForm);

      pkgHarvest:
        Result := CreateHarvestPackage(objPackage, aForm);
    end;

    if Result then begin
      CommitTransaction;
      MessageDlgXP_Vista('Package created', mtInformation, [mbOK], 0);
    end else
      RollbackTransaction;

  except
    on E: Exception do
    begin
      RollbackTransaction;
      MessageDlgXP_Vista('Failed to create package', mtError, [mbOK], 0);
      Logtext(Format('TfmStSMain.CreatePackageFunc exception: [%s] %s', [E.Classname, E.Message]),'', True);
    end;
  end;
end;

function TfmStSMain.QryStsTagWhere :String;
var
  s:String;
begin
  s:=SelectedTagIds.commatext;
  if s='' then s := '0';
	Result := 'Where ID in (' + s+')';
end;
function TfmStSMain.QryStsTagListWhere :String;
var
  s:String;
begin
  s:=SelectedTagIds.commatext;
  if s='' then s := '0';
	Result := 'Where Tags.ID in (' + s+')';
end;
procedure TfmStSMain.actEmployeesExecute(Sender: TObject);
begin
  inherited;
  OpenERPListFormSingleselectModal('TfmStsEmployeeExpressList', ChooseEmployee);
end;
procedure TfmStSMain.actClassExecute(Sender: TObject);
begin
  OpenERPListFormSingleselectModal('TStSClassListGUI', ChooseStsClass);
end;
procedure TfmStSMain.ChooseEmployee(Sender:TwwDBGrid);
var
  Keychar: Char;
begin
  if Sender.datasource.dataset.fieldbyname('employeeID').asInteger =0 then exit;
  edtBarcodeInput.text := Barcode_Prefix_Employee + '-'+trim(inttostr(Sender.datasource.dataset.fieldbyname('employeeID').asInteger));
  Keychar := chr(VK_RETURN);
  self.edtBarcodeInputKeyPress(edtBarcodeInput, Keychar);
  TimedMsg(Employee.employeename +' has logged In');
end;
procedure TfmStSMain.ChooseStsClass(Sender:TwwDBGrid);
var
  Keychar: Char;
begin
  if Sender.datasource.dataset.fieldbyname('ClassID').asInteger =0 then exit;
  edtBarcodeInput.text := Barcode_Prefix_DeptClass +'-'+ trim(inttostr(Sender.datasource.dataset.fieldbyname('ClassID').asInteger));
  Keychar := chr(VK_RETURN);
  self.edtBarcodeInputKeyPress(edtBarcodeInput, Keychar);
end;

Procedure TfmStSMain.InitStSTags(Sender:TObject);
var
  grpExtrafilters: TwwRadioGroup;
  fmListingGUI: TBaseListingGUI;
begin
  Assert(Sender is TBaseListingGUI, 'Expected Sender is TBaseListingGUI');
  fmListingGUI := Sender as TBaseListingGUI;

  // pass DepartmentID
  (fmListingGUI as TStSTagsGUI).ClassID := DeptclassId;

  // Change the availability of filter options. Use only 'Plant Tags'  because Package Tags cannot be used in this form.
  grpExtrafilters := fmListingGUI.FindComponent('grpExtrafilters') as TwwRadioGroup;
  if Assigned(grpExtrafilters) then
    grpExtrafilters.Items.Text := 'Plant Tags';
end;

Procedure TfmStSMain.choosetag(Sender:TwwDBGrid);
var
  fstablename :String;
  fs:String;
  Qry:TERPQuery;
  StSTagform :TfmStSTag;
  aStSTags :TStSTags;
  fmListingGUI: TBaseListingGUI;
begin
  fmListingGUI := TBaseListingGUI(Sender.Owner);

  // Set captions of buttons "Destroy Plants" and "Record Waste"
  FDoDestroyPlant := (fmListingGUI.grpFilters.ItemIndex <> 2);
  FDoRecordWaste  := (fmListingGUI.grpFilters.ItemIndex <> 3);

  if FDoDestroyPlant then
    act_DestroyPlant.Caption := 'Destroy Plants'
  else
    act_DestroyPlant.Caption := 'Recover from Destroyed';

  if FDoRecordWaste then
    act_RECORD_WASTE.Caption := 'Record Waste'
  else
    act_RECORD_WASTE.Caption := 'Recover from Wasted';

  fs := fmListingGUI.SelectedData['Serialnumber'];
  fstablename  := '';
  fs := StSTagList(fstablename , fs);
  clog(fs);
  Qry := Employee.sharedQuery;
  try
    Qry.SQL.text := fs;
    Qry.Execute;
    Qry.SQL.text := 'SELECT PartsId, departmentId, uomid, uom, Productname, serialnumber, description, alloctype, tagID,Strainname, plantcount FROM '+ fstablename;
    Qry.Open;
    if Qry.recordcount >0 then begin
      if Qry.locate('Tagid' , 0, []) then begin
        BegintransAction;
        StSTagform := TfmStSTag.Create(self, MyDAcDataconnection, Qry.fieldbyname('serialnumber').asString);
        try
          if StSTagform.Showmodal = mrok then begin
            if Qry.active then Qry.close;
            Qry.SQL.text := fs;
            Qry.Execute;
            Qry.SQL.text := 'SELECT PartsId, departmentId, uomid, uom, Productname, serialnumber, description, alloctype, tagID,Strainname, plantcount FROM '+ fstablename;
            Qry.Open;
            if Qry.recordcount >0 then begin
              Qry.First;
            //SelectedTags:= '';
            //SelectedtagNames.clear;
              SelectedTagIds.clear;
              While Qry.EOF = False do begin
                if Qry.fieldbyname('TagID').asInteger =StSTagform.StSTagObj.Id then
                  Logtext(  Qry.fieldbyname('serialnumber').asString+' :Altready Assigned')
                else if Qry.fieldbyname('TagID').asInteger <>0 then
                  Logtext(  Qry.fieldbyname('serialnumber').asString+' : edited in the form')
                else begin
                   Logtext(  Qry.fieldbyname('serialnumber').asString+' :New');
                   aStSTags :=TStSTags.create(nil); // self is not the owner - cannot use the form's dataset
                   try
                    aStSTags.BusObjEvent := DoBusinessObjectEvent;
                    aStSTags.connection :=StSTagform.StSTagObj.Connection;
                    aStSTags.Load(0);
                    aStSTags.New;
                    aStSTags.StsTag       := Qry.fieldbyname('serialnumber').asString;
                    aStSTags.TagProductID := StSTagform.StSTagObj.TagProductID;
                    aStSTags.DeptID       := StSTagform.StSTagObj.DeptID;
                    aStSTags.Dept         := StSTagform.StSTagObj.Dept;
                    aStSTags.UsedOn       := StSTagform.StSTagObj.UsedOn;
                    aStSTags.StrainID     := StSTagform.StSTagObj.StrainID;
                    aStSTags.StrainName   := StSTagform.StSTagObj.StrainName;
                    aStSTags.Plantcount   := StSTagform.StSTagObj.Plantcount;
                    aStSTags.StSProductID := StSTagform.StSTagObj.StSProductID;
                    aStSTags.StSPhase     := StSTagform.StSTagObj.StSPhase;
                    aStSTags.EmployeeId   := StSTagform.StSTagObj.EmployeeId;
                    aStSTags.PostDB;
                    aStSTags.Save;
                   finally
                    Freeandnil(aStSTags);
                   end;
                end;
                
                SelectedTagIds.Add(Qry.fieldbyname('TagId').asInteger);
                Qry.Next;
              end;
            end;
          end else begin
            RollbackTransaction;
          end;
        finally
          FreeandNil(StSTagform);
          cleanform;
        end;
      end else begin
        SelectedTagIds.clear;
        SelectedTagIds.Add(Qry.fieldbyname('TagId').asInteger);
        RefreshTagList;
      end;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    DestroyUserTemporaryTable(fsTablename);
    DestroyUserTemporaryTable(fsTablename+'1');
  end;

end;
Function TfmStSMain.ChangePhaseProc(aBusobj:Tbusobj):Boolean;
var
  StSChangePhase :TfmStSChangePhase;
  isPChangePhaseOk:Boolean;
  fs:String;
  aStsTAg: TStsTAgs;
const
  cWasteTagWarning = 'Changing the phase from Immature to Vegetative will require the use of a new tag. Proceed?';
begin
      Result := False;
      isPChangePhaseOk := false;
      if aBusobj is TStsTAgs then aStsTAg:= TStsTAgs(aBusobj)
      else Exit;

      if aStsTag.StsPhase ='I' then
        if CommonLib.MessageDlgXP_Vista(cWasteTagWarning, mtConfirmation, mbOKCancel, 0) = mrCancel then Exit;

        fs :=qryMainStSTag.AsString;
        if appenv.companyprefs.StSSimpleMode then
             StSChangePhase := TfmStSChangePhaseSimple.Create(self, MyDAcDataconnection, aStsTAg.ID)
        else StSChangePhase := TfmStSChangePhaseDetail.Create(self, MyDAcDataconnection, aStsTAg.ID);

        try
          StSChangePhase.title := aStsTAg.StsTAg+' ('+ qryMainStSPhaseDesc.AsString+')';
          StSChangePhase.StSTagPhases := aStsTAg.StSTagPhases;
          StSChangePhase.StSTag_Actions := aStsTAg.StSTag_Actions;
          if StSChangePhase.Showmodal = mrok then begin
            SelectedTagIDs.commatext := StSChangePhase.NewTagIds.commatext;
            RefreshTagList;
            isPChangePhaseOk := (StSChangePhase.NewPhaseSelected <> 'H') and (StSChangePhase.NewPhaseSelected <> 'P');
            Result := TRue;
          end;
        finally
          FreeandNil(StSChangePhase);
          if isPChangePhaseOk then begin
            if (fs =qryMainStSTag.AsString) and (qryMain.recordcount =1) then
                   fs:= 'Tag ' + quotedstr(fs) +'''s Phase is changed to ' + Quotedstr(qryMainStsPhaseDesc.asString)+'.'
            else fs:= 'Tag ' + quotedstr(fs) +'''s Phase is changed to ' + Quotedstr(qryMainStsPhaseDesc.asString)+', and Assigned to '+ inttostr(qrymain.recordcount) +' Tags.';
            MessageDlgXP_Vista(fs, mtInformation, [mbOK], 0);
          end;
          //CleanForm;
        end;
end;

function TfmStSMain.IsEmployeeSelected: Boolean;
begin
  Result := (Employee.id > 0);

  if not Result then begin
    CommonLib.MessageDlgXP_Vista(cChooseEmployee , mtWarning, [mbOk], 0);
    actEmployeesExecute(nil);
  end;
end;

function TfmStSMain.IsTagSelected: Boolean;
begin
  Result := (qryMain.recordcount = 1);

  if not Result then begin
    MessageDlgXP_Vista(cChooseTag, mtWarning, [mbOK], 0);
    actSerialnumbersExecute(nil);
  end;
end;

function TfmStSMain.CreateHarvestPackage(aObjPackage: TStSPackage; aGuiPackage: TfmStSInputBase): Boolean;
var
  iPkgProductID, iNewStsTagsID, iPrevDeptClassId: Integer;
  objHarvest: TStSHarvest;
  objStsTags: TStSTags;
  guiPackage: TfmStSCreatePackage;
begin
  Result := False;

  Assert(aGuiPackage is TfmStSCreatePackage, 'Expecting aGuiPackage is TfmStSCreatePackage in TfmStSMain.CreateHarvestPackage');
  guiPackage := aGUIPackage as TfmStSCreatePackage;

  iPrevDeptClassId := DeptClassId; // global DeptClassId used to get DeptClass.DeptClassName
  try
    DeptClassId := aObjPackage.InitDeptID;
    if DeptClassId = 0 then
      DeptClassId := guiPackage.StsPackage.InitDeptID;


      { When you are about to create a package, you take the "Not_Used" tag  from the PackageTags pool created in the Purchase Order.
        The next time you create a package, a temporary table will be created and the current PackageTag will not be included in this table.  }

      {  meaning of:

          StsTag = 100006 related to Plant:

          TagProductID = 39 - is tblparts.PartsID "Plant Tag"
          StsProductID = 42 - is tblparts.PartsID "Vegetative - Strain-1"


          StsTag = PAK-0001 related to Package:

            "Package" product:
              TagProductID = 49 - is tblparts.PartsID "Package"
              StsProductID = 49 - is tblparts.PartsID "Package"

            "Package Tag" product:
              TagProductID = 40 - is tblparts.PartsID "Package Tag"
              StsProductID = 0 -
      }

    // You have "Package Tag" product - not-used Package tags
    // and "Package" product - completed packages which you mark with "Package Tag" tags.
    // At the end of this operation, you will have 1 item of "Package product" more and 1 item of "Package tag" less.

    // process "Package" product
    objStsTags := TStSTags.CreateWithSharedConn(nil);
    try
      iPkgProductID := aObjPackage.ProductID;
      // insert Package tag into tblststags
      with objStsTags do begin
        New;
        StsTag       := guiPackage.cbbNewPackg.Text;
        TagProductID := iPkgProductID;
        StsProductID := iPkgProductID;
        DeptID       := DeptClassId;
        Dept         := DeptClass.DeptClassName;
        UOMID        := guiPackage.UOMID;
        Plantcount   := 0;
        UsedOn       := Now;
        StSPhase     := '';
        StrainName   := '';
        EmployeeID   := Employee.ID;
        PostDb;
        iNewStsTagsID := ID;

        // prepare action
        StSTag_Actions.New;
        StSTag_Actions.StatusDate     := guiPackage.dtpPackgDate.Date;
        StSTag_Actions.StatusAction   := STS_ACTION_CREATE_PACKAGES_PRODUCT;
        StSTag_Actions.ActionQty      := 1;
        StSTag_Actions.TagProductID   := iPkgProductID;
        StSTag_Actions.StSProductID   := iPkgProductID;
        StSTag_Actions.StatusActionId := TStSTags.NewStsAction(STS_ACTION_CREATE_PACKAGES_PRODUCT);
        StSTag_Actions.PostDB;

        Result := SavePackage; // execute prepared actions -> creates records in tblpqa, tblpqadetails
      end;
    finally
      FreeAndNil(objStsTags);
    end;

    if not Result then Exit(False);

    // insert objPackage
    with aObjPackage do begin
      New;
      StsTagsID     := iNewStsTagsID;
      PackageName   := guiPackage.edtPackgName.Text;
      PackageDate   := guiPackage.dtpPackgDate.DateTime;
      PackageType   := guiPackage.PackageType;
      HarvestID     := guiPackage.HarvestID;
      UOMID         := guiPackage.UOMID;
      UOM           := guiPackage.UOM;
      UOMMultiplier := guiPackage.PackageUOMMultiplier;
      PackedQty     := guiPackage.PackedQty;
      Done          := 'T';
      PostDb;
    end;

    // create Harvest busobj
    objHarvest := TStSHarvest.CreateWithSharedConn(nil);
    try
      // update Harvest.PackedQty
      with objHarvest do begin
        Load(guiPackage.HarvestID);
        if DatasetActive then
        begin
          if TotalQty < (PackedQty + guiPackage.PackedQty) then
            raise Exception.Create('Trying to pack more than Harvest has');

          PackedQty := PackedQty + guiPackage.PackedQty;
          PostDb;
        end;
      end;
    finally
      FreeAndNil(objHarvest);
    end;

    // process "Package Tag" product
    objStsTags := TStSTags.CreateWithSharedConn(nil);
    try
      with objStsTags do begin
        New;
        StsTag       := guiPackage.cbbNewPackg.Text;
        TagProductID := StSPackageTagProductID;
        StsProductID := 0;
        DeptID       := DeptClassId;
        Dept         := DeptClass.DeptClassName;
        UOMID        := guiPackage.UOMID;
        Plantcount   := 0;
        UsedOn       := Now;
        StSPhase     := '';
        StrainName   := '';
        EmployeeID   := Employee.ID;
        PostDB;

        // UsePackageTag reduces "Package Tag" product qty
        if UsePackageTag then Result := SavePackage;

      end;
    finally
      FreeAndNil(objStsTags);
    end;
  finally
    DeptClassId := iPrevDeptClassId;
  end;
end;

function TfmStSMain.CreatePiecePackage(aObjPackage: TStSPackage; aGuiPackage: TfmStSInputBase): Boolean;   // maybe rename to CreatePiecePackage
var
  I, iPkgProductID, iNewStsTagsID, iPrevDeptClassId: Integer;
  objHarvest: TStSHarvest;
  objStsTags: TStSTags;
  guiPackage: TfmStSCreatePackage;
  lineItems: TPackageLineItems;
begin
  Result := False;

  Assert(aGuiPackage is TfmStSCreatePackage, 'Expecting aGuiPackage is TfmStSCreatePackage');
  guiPackage := aGUIPackage as TfmStSCreatePackage;

  iPrevDeptClassId := DeptClassId;  // global DeptClassId used to get DeptClass.DeptClassName
  try
    DeptClassId := aObjPackage.InitDeptID;
    if DeptClassId = 0 then
      DeptClassId := guiPackage.StsPackage.InitDeptID;

    // process "Package" product
    objStsTags := TStSTags.CreateWithSharedConn(nil);
    try
      iPkgProductID := aObjPackage.ProductID;
      // insert Package tag into tblststags
      with objStsTags do begin
        New;
        StsTag       := guiPackage.cbbNewPackg.Text;
        TagProductID := iPkgProductID;
        StsProductID := iPkgProductID;
        DeptID       := DeptClassId;
        Dept         := DeptClass.DeptClassName;
        UOMID        := guiPackage.UOMID;
        Plantcount   := 0; // Maybe better use 1 instead 0? This workaround can help to prevent EDivByZero in TStSTags.StSTagsSaveCallback. Plantcount is used as StSTagSM.Lines.UOMMultiplier, next step this UOMMultiplier is used in StSTagSM.Lines.Qty/StSTagSM.Lines.UOMMultiplier
        UsedOn       := Now;
        StSPhase     := '';
        StrainName   := '';
        EmployeeID   := Employee.ID;
        PostDb;
        iNewStsTagsID := ID;

        // prepare action
        StSTag_Actions.New;
        StSTag_Actions.StatusDate     := guiPackage.dtpPackgDate.Date;
        StSTag_Actions.StatusAction   := STS_ACTION_CREATE_PACKAGES_PRODUCT;
        StSTag_Actions.ActionQty      := 1; // increase qty of "Package" product
        StSTag_Actions.TagProductID   := iPkgProductID;
        StSTag_Actions.StSProductID   := iPkgProductID;
        StSTag_Actions.StatusActionId := TStSTags.NewStsAction(STS_ACTION_CREATE_PACKAGES_PRODUCT);
        StSTag_Actions.PostDB;

        if not SavePackage then Exit(False);
      end;
    finally
      FreeAndNil(objStsTags);
    end;

    // process objPackage
    with aObjPackage do begin
      New;
      StsTagsID     := iNewStsTagsID;
      PackageName   := guiPackage.edtPackgName.Text;
      PackageDate   := guiPackage.dtpPackgDate.Date;
      PackageType   := guiPackage.PackageType;
      UOMID         := guiPackage.UOMID;
      UOM           := guiPackage.UOM;
      UOMMultiplier := guiPackage.PackageUOMMultiplier;
      Done          := 'T';
      PostDb;

      // process Lines
      objStsTags := TStSTags.CreateWithSharedConn(nil);
      try
        lineItems := guiPackage.LineItems; //array of tags data selected by user to place them in Package
        for I := Low(lineItems) to High(lineItems) do begin
          with Lines do begin
            objStsTags.Load(lineItems[I].TagID);
            New;
            StsTagsID    := lineItems[I].TagID;
            StSProductId := objStsTags.StSProductId;
            Qty          := lineItems[I].ActiveCount;
            UOMQty       := 1;
            StSActionID  := TStSTags.NewStsAction(STS_ACTION_CREATE_PACKAGES_PRODUCT);
            PostDB;
          end;
          // in case "Create a package from another package" update the Package.ParentPkgID contained in the lineItems[I]
          if  lineItems[I].PackageID <> 0 then // means lineItems[I] contains TStsPackage data
            with TStSPackage.CreateWithSharedConn(nil) do begin
              Load(lineItems[I].PackageID);
              ParentPkgID := aObjPackage.ID;
              PostDB;
              Free;
            end;
        end;
      finally
        FreeAndNil(objStsTags);
      end;

      // update the inventory data of the tags contained in Lines
      if not Save then Exit(False);

      // The Lines are created, you can now calculate the PackedQty using the Lines data
      CalcNSetTotalPackedQty;
    end;

    // process "Package Tag" product
    objStsTags := TStSTags.CreateWithSharedConn(nil);
    try
      with objStsTags do begin
        New;
        StsTag       := guiPackage.cbbNewPackg.Text;
        TagProductID := StSPackageTagProductID;
        StsProductID := 0;
        DeptID       := DeptClassId;
        Dept         := DeptClass.DeptClassName;
        UOMID        := guiPackage.UOMID;
        Plantcount   := 0;
        UsedOn       := Now;
        StSPhase     := '';
        StrainName   := '';
        EmployeeID   := Employee.ID;
        PostDB;

        // UsePackageTag reduces "Package Tag" product qty
        if UsePackageTag then Result := SavePackage;

      end;
    finally
      FreeAndNil(objStsTags);
    end;
  finally
    DeptClassId := iPrevDeptClassId;
  end;
end;

function TfmStSMain.CreatePackageFunc(aBusobj: Tbusobj): Boolean;
var
  objPackage: TStSPackage;
  guiPackage: TfmStSCreatePackage;
begin
  Result := False;

  if aBusobj is TStSPackage then objPackage := TStsPackage(aBusobj)
  else Exit;

  objPackage.InitDeptID := DeptClassId;
  guiPackage := TfmStSCreatePackage.Create(nil, StsTag);

  try
    guiPackage.title := 'Create Package';
    Result := (guiPackage.Showmodal = mrok);

    if Result then
      Result := ProcessCreatePackage(guiPackage, objPackage);

  finally
    FreeAndNil(guiPackage);
  end;

end;

Procedure TfmStSMain.act_ChangePhaseExecute(Sender:TObject);
var
  //StSChangePhase :TfmStSChangePhase;
  fs:String;
  fiStsTAgID:Integer;
  //fiActionID :Integer;
  //isPChangePhaseOk:Boolean;
begin
    if not IsTagSelected then Exit;

    if not IsEmployeeSelected then Exit;


    //isPChangePhaseOk := false;
    //STS_ACTION_CHANGE_GROWTH_PHASE
    if not isTagActive then exit;

//    if (qryMainStSPhase.asString <>'I') and (qryMainStSPhase.asString<> 'V')  then begin
//      MessageDlgXP_Vista('Its not possible to Change the Phase as this Tag ('+quotedstr(qryMainStSTag.asString)+') is in '+quotedstr(qryMainStSPhaseDesc.asString)+' Phase', mtWarning, [mbOK], 0);
//      Exit;
//    end;

    CommitTransaction;
    BeginTransaction;
    if StsTAg.NewPhase(TDnmAction(Sender).caption,ChangePhaseProc) then begin
        CleanForm;
    end;

    (*fs:= qryMainStSTag.asString;
    fiStsTAgID:= qryMainID.asInteger;

    fiActionID := NewStsAction(TDnmAction(Sender).caption);
    if fiActionID <> 0 then begin
      With StsTAg do begin
        ChangeGrowthPhase(0, 0); // makes the action record with 0 qty


        StSTagPhases.new;
        StSTagPhases.PostDB;
        if appenv.companyprefs.StSSimpleMode then
          StSChangePhase := TfmStSChangePhaseSimple.Create(self, MyDAcDataconnection, fiStsTAgID)
        else StSChangePhase := TfmStSChangePhaseDetail.Create(self, MyDAcDataconnection, fiStsTAgID);
        try
          StSChangePhase.title := fs+' ('+ qryMainStSPhaseDesc.AsString+')';
          StSChangePhase.StSTagPhases := StSTagPhases;
          StSChangePhase.StSTag_Actions := StSTag_Actions;
          if StSChangePhase.Showmodal = mrok then begin
            SelectedTagIDs.commatext := StSChangePhase.NewTagIds.commatext;
            RefreshTagList;
            isPChangePhaseOk := true;
          end;
          Save;
        finally
          FreeandNil(StSChangePhase);
          if isPChangePhaseOk then begin
            if (fs =qryMainStSTag.AsString) and (qryMain.recordcount =1) then
                   fs:= 'Tag ' + quotedstr(fs) +'''s Phase is changed to ' + Quotedstr(qryMainStsPhaseDesc.asString)+'.'
            else fs:= 'Tag ' + quotedstr(fs) +'''s Phase is changed to ' + Quotedstr(qryMainStsPhaseDesc.asString)+', and Assigned to '+ inttostr(qrymain.recordcount) +' Tags.';
            MessageDlgXP_Vista(fs, mtInformation, [mbOK], 0);
          end;
          CleanForm;
        end;
      end;
    end;*)
end;
Procedure TfmStSMain.CleanForm;
begin
  CommitTransaction;
  closeQueries;
  SelectedTagIds.clear;
  RefreshTagList;
  Openqueries;
  LocateDept;
  BeginTransaction;
  Setcontrolfocus(edtBarcodeInput);
end;
Procedure TfmStSMain.AssignProductTag(Value:Integer);
begin

end;
Procedure TfmStSMain.act_CreatePlantingsExecute(Sender:TObject);
var
  CreateImmaturePlant :TfmStSCreateImmaturePlant;
  fs:String;
  fiActionID :Integer;
  aStsTag:TStSTags;
begin
    if not IsTagSelected then Exit;

    if not IsEmployeeSelected then Exit;

  //CREATE_PLANTINGS

    if not isTagActive then exit;

    fs:= qryMainStSTag.asString;

    fiActionID := NewStsAction(TDnmAction(Sender).caption);
    if fiActionID <> 0 then begin
      BeginnestedTransaction;
      try
            With StsTAg do begin
              StSTag_Actions.New;
              StSTag_Actions.StatusDate := Now;
              StSTag_Actions.StatusAction := TDnmAction(Sender).caption;
              StSTag_Actions.StatusActionId := fiActionID;
              StSTag_Actions.PostDB;

              CreateImmaturePlant := TfmStSCreateImmaturePlant.Create(self, MyDAcDataconnection, (*fs*)qryMainID.asinteger);
              try

                StSTagProduct.New;
                CreateImmaturePlant.StSTagProduct := StSTagProduct;
                CreateImmaturePlant.title         := fs+' - Create Planting';
                if CreateImmaturePlant.Showmodal = mrok then begin
                  StSTag_Actions.StatusDate :=   CreateImmaturePlant.dtProductionDate.datetime;
                  StSTag_Actions.PostDB;
                  StSTagProduct.PostDB;
                  if CreateImmaturePlant.TagForProduct <> '' then begin
                      aStsTag:= TStSTags.create(nil); // not owned by self - as
                      try
                        aStsTag.BusObjEvent := DoBusinessObjectEvent;
                        aStsTag.connection := Connection;
                        aStsTag.LoadSelect('StsTag =' +quotedstr(CreateImmaturePlant.TagForProduct));
                        if aStsTag.count = 0 then begin
                          aStsTag.New;
                          aStsTag.StsTag        := CreateImmaturePlant.TagForProduct;
                          aStsTag.TagProductID  := CreateImmaturePlant.TagProductID;
                          aStsTag.SourceTagID   := ID;
                          aStsTag.UsedOn        := CreateImmaturePlant.dtProductionDate.datetime;
                          aStsTag.SourceTag     := StsTag;
                          aStsTag.sourcetype    := StSTagProduct.StSProducttype;
                          aStsTag.StSTagPhaseID := StsTagPhases.ID;
                          aStsTag.StSActionID   := StSTag_Actions.ID;
                          aStsTag.DeptID        := DeptID;
                          aStsTag.EmployeeId    := EmployeeId;
                          aStsTag.Dept          := Dept;
                          aStsTag.Planttype     := StSTagProduct.StSProducttype;
                          aStsTag.Plantcount    := StSTagProduct.Productcount;
                          aStsTag.UsedOn        := StSTagProduct.ProductionDate;
                          aStSTag.StrainID      := StrainID;
                          aStSTag.StrainName    := StrainName;
                          aStsTag.PostDB;
                          Self.OnchooseTag(CreateImmaturePlant.TagForProduct ,  AssignProductTag , '' , False, true);//, 'I');
                          aStsTag.RefreshDb;
                        end;
                        //if aStsTag.PhaseChanged or aStsTag.Tagwasted or aStsTag.TagReplaced then begin
                        if aStSTag.Activecount <=0 then begin
                            MessageDlgXP_Vista('Tag is not Active', mtWarning, [mbOK], 0);
                            Exit;
                        end;
                        StSTagProduct.TagId := Id;
                        StSTagProduct.ProductTagID := aStsTag.Id;
                        StSTagProduct.PostDB;
                        MessageDlgXP_Vista('Created Tag '+ quotedStr(CreateImmaturePlant.TagForProduct)+' for the Product', mtInformation, [mbOK], 0);
                      finally
                        FreeandNil(aStsTag);
                      end;
                      CommitnestedTransaction;
                  end else begin
                      RollbacknestedTransaction;
                  end;
                  RefreshTagList;
                end else begin
                  RollbacknestedTransaction;
                  RefreshTagList;
                end;
              finally
                FreeandNil(CreateImmaturePlant);
                CleanForm;
              end;
            end;
      Except
        on E:Exception do begin
          RollbacknestedTransaction;
        end;
      end;
    end;

end;
Procedure TfmStSMain.act_DestroyPlantExecute(Sender:TObject);
var
  sMsg: string;
const
  cMsg = ' Tag is %s';
begin
  if not IsTagSelected then Exit;

  if not IsEmployeeSelected then Exit;


  With StsTAg do begin
      if not DestroyPlant(FDoDestroyPlant) then exit;
      CommitnestedTransaction;
      if FDoDestroyPlant then
        sMsg := Format(cMsg, ['Destroyed'])
      else
        sMsg := Format(cMsg, ['Recovered']);

      MessageDlgXP_Vista(Quotedstr(StSTag)+sMsg, mtInformation, [mbOK], 0);
  end;
(*var
  fiActionID:Integer;
begin
  //DESTROY_PLANTS
  if not isTagActive then exit;
  fiActionID := NewStsAction(TDnmAction(Sender).caption);
  if fiActionID <> 0 then
    With StsTAg do begin
      if count =0 then exit;
        if activecount+wastedCount <> plantcount then begin
          MessageDlgXP_Vista(Quotedstr(StSTag)+' Tag is already Started Processing. It is not Possible to Destroy it', mtInformation, [mbOK], 0);
          Exit;
        end;

        StSTag_Actions.New;
        StSTag_Actions.StatusDate     := Now;
        StSTag_Actions.StatusAction   := TDnmAction(Sender).caption;
        StSTag_Actions.ActionQty      := ActiveCount;
        StSTag_Actions.StatusActionId := fiActionID;
        StSTag_Actions.PostDB;

        StsPhase    := 'D';
        UsedOn      := Now;
        //PhaseChanged:= True;
        Destroycount := Destroycount + ActiveCount;
        PostDB;
        if not Save then exit;
        CommitnestedTransaction;
        MessageDlgXP_Vista(Quotedstr(StSTag)+' Tag is Destroyed', mtInformation, [mbOK], 0);
    end;*)
  CleanForm;
end;

Procedure TfmStSMain.initInputText(Sender:TObject);
var
  fmInput: TFmInputText;
begin
  if sender is TFmInputText then begin
    fmInput := TFmInputText(Sender);

    with fmInput do begin
      Color          := $0091C8FF;
      memInput.Color := clWhite;
      // look at TDateTimePicker.Format description. "MM" means month but "mm" means minute. "HH" means the two-digit hour in 24-hour format. Single-digit values are preceded by a zero.
      dtInput.Format := StringReplace(FormatSettings.ShortDateFormat, 'mm', 'MM', []) + ' HH:mm:ss';

      with TitleShader do begin
        FromColor       := clWhite;
        FromColorMirror := clWhite;
        ToColor         := clWhite;
        ToColorMirror   := clWhite;
      end;
    end;

  end;
end;

Procedure TfmStSMain.act_RECORD_ADDITIVESExecute(Sender:TObject);
var
  fiActionID:Integer;
  fs:String;
  fdt:TDatetime;
begin
  if not IsTagSelected then Exit;

  if not IsEmployeeSelected then Exit;

  if not isTagActive then exit;
  fiActionID := NewStsAction(TDnmAction(Sender).caption);
  if fiActionID <> 0 then begin
    fdt := now;
    if ModalInputTextnDate(TDnmAction(Sender).caption, '','Additive Details',fs,fdt,initInputText) then begin
      With StsTAg do begin
        StSTag_Actions.New;
        StSTag_Actions.StatusDate := fdt;
        StSTag_Actions.StatusAction := TDnmAction(Sender).caption;
        StSTag_Actions.StatusActionId := fiActionID;
        StSTag_Actions.Description := fs;
        StSTag_Actions.PostDB;
        if Save then begin
          CleanForm;
        end;
    end;
    end;
  end;
end;
Function TfmStSMain.NewStsAction(const Value:String):Integer;
begin
  Result :=TStSTags.NewStsAction(Value);// TSimpleTypes.ChecknMakeSimpleType(TStSAction.SimpleTypecode,Value);
end;

Procedure TfmStSMain.act_RECORD_WASTEExecute(Sender:TObject);
var
  fiWastecount:Integer;
  sMsg: string;
const
  cMsgW = '[ %d ] Plants Wasted from Tag "%s".' +NL+NL+ '[ %d ] Plants Remaining.';
  cMsgR = '[ %d ] Plants Recovered in Tag "%s".' +NL+NL+ '[ %d ] Plants Wasted.';
begin
  if not IsTagSelected then Exit;

  if not IsEmployeeSelected then Exit;

  if FDoRecordWaste and not isTagActive then exit;

   with StSTag do begin
     if FDoRecordWaste then
       fiWastecount:= CustomInputInteger('Wasting Plants', 'No Of Plants Wasted', inttostr(ActiveCount),0)
     else
       fiWastecount:= CustomInputInteger('Recover Plants', 'No Of Plants Recovered', inttostr(WastedCount),0);


     if not RecordWastage(fiWastecount, FDoRecordWaste) then exit;

     if FDoRecordWaste then
       sMsg := Format(cMsgW, [fiWastecount, StSTag, ActiveCount])
     else
       sMsg := Format(cMsgR, [fiWastecount, StSTag, WastedCount]);
   end;

     MessageDlgXP_Vista(sMsg, mtInformation, [mbOK], 0);
   CleanForm;
(*var
  fiActionID:Integer;
  fiWastecount:Integer;
begin
  //RECORD_WASTE
  if not isTagActive then exit;
  fiActionID := NewStsAction(TDnmAction(Sender).caption);
  if fiActionID <> 0 then begin
    With StsTAg do begin
      fiWastecount :=0;
      if ActiveCount >1 then begin
        fiWastecount:= CustomInputInteger('Wasting Plants', 'No Of Plants Wasted', inttostr(ActiveCount),0);
        if fiWastecount > ActiveCount then fiWastecount :=  ActiveCount;
      end else begin
        fiWastecount := ActiveCount;
      end;
      if fiWastecount =0 then exit;
      StSTag_Actions.New;
      StSTag_Actions.ActionQty := fiWastecount;
      StSTag_Actions.StatusDate := Now;
      StSTag_Actions.StatusAction := TDnmAction(Sender).caption;
      StSTag_Actions.StatusActionId := fiActionID;
      StSTag_Actions.PostDB;

      //StsPhase    := 'W';
      //UsedOn      := Now;
      //PhaseChanged:= True;
      Wastedcount := Wastedcount + fiWastecount;
      PostDB;
      if Save then begin
        MessageDlgXP_Vista('[ '+inttostr(fiWastecount) +' ] Plants Wasted from Tag ' + Quotedstr(StSTag)+'.'+NL+NL+
                           '[ '+ inttostr(ActiveCount) +' ] Plants Remaining.', mtInformation, [mbOK], 0);
        CleanForm;
      end;
    end;
  end;*)
end;
Procedure TfmStSMain.ChooseClass(const msg:String);
begin
  //OpenERPListFormSingleselectModal('TStSClassListGUI' ,onchooseclass ,beforeclaslistshow, true);
  //OpenERPListFormSingleselectModal('TStSClassBinListGUI' ,onchooseclass ,beforeclaslistshow, true);
  fsChooseclassMsg:= Msg;
  try
  TFmSelectFromList.SelectFromList(self, 'TStSClassBinListGUI',  'Classid' , initSelectFromList, OnSelectfromSelectFromList, true);
  finally
    fsChooseclassMsg:='';
  end;
end;

Procedure TfmStSMain.OnSelectfromSelectFromList(Sender:TObject);
begin
  if sender is  TFmSelectFromList then
    if TFmSelectFromList(Sender).Listfrom is TStSClassBinListGUI then begin
      fiTransferToClassID := TStSClassBinListGUI(TFmSelectFromList(Sender).Listfrom).qryMainClassID.asInteger;
      fiTransferToBinID := TStSClassBinListGUI(TFmSelectFromList(Sender).Listfrom).qryMainBinId.asInteger;
      fdTransferDate := SelectFromListDate.DateTime;
    end;
end;

Procedure TfmStSMain.initSelectFromList(Sender:TObject);
begin
  if sender is  TFmSelectFromList then begin
    if TFmSelectFromList(Sender).Listfrom is TStSClassBinListGUI then begin
      StepProgressbar;
      // only packages can be moved between the Departments so use filter that the user can select another Room in the same Department
      TStSClassBinListGUI(TFmSelectFromList(Sender).Listfrom).filterString := Format('(Classid = %d) AND (BinID <> %d)', [StsTag.DeptID, StsTag.BinID]);
      StepProgressbar;
      SelectFromListDatePnl := nil;
      SelectFromListDate:= TFmSelectFromList(Sender).AddDateinput('Date ' , Now, True, True, SelectFromListDatePnl);
    end;

    TFmSelectFromList(Sender).Color := $0091C8FF;

    with TFmSelectFromList(Sender).TitleShader do begin
      FromColor       := clWhite;
      FromColorMirror := clWhite;
      ToColor         := clWhite;
      ToColorMirror   := clWhite;
    end;
  end;
end;
Procedure TfmStSMain.onchooseclass(Sender: TwwDbGrid);
begin
  (*if sender.Owner is TStSClassListGUI then begin
    fiTransferToClassID := TStSClassListGUI(sender.Owner).qryMainClassID.asInteger;
    fiTransferToBinID := TStSClassListGUI(sender.Owner).qryMainBinId.asInteger;
  end;*)
  if sender.Owner is TStSClassBinListGUI then begin
    fiTransferToClassID := TStSClassBinListGUI(sender.Owner).qryMainClassID.asInteger;
    fiTransferToBinID := TStSClassBinListGUI(sender.Owner).qryMainBinId.asInteger;
  end;
  StepProgressbar;
end;
Procedure TfmStSMain.beforeclaslistshow(Sender:TObject);
begin
  (*if sender is TStSClassListGUI then begin
    TStSClassListGUI(Sender).filterString :=  'Classid <> ' + inttostr(StsTAg.DeptID)
  end;*)
  if sender is TStSClassBinListGUI then begin
    StepProgressbar;
    TStSClassBinListGUI(Sender).filterString :=  'Classid <> ' + inttostr(StsTAg.DeptID);
    StepProgressbar;
  end;
end;
Procedure TfmStSMain.act_TRANSFERExecute(Sender:TObject);
begin
  if not IsTagSelected then Exit;

  if not IsEmployeeSelected then Exit;

  //RECORD_Transfer
  if not isTagActive then exit;
    With StsTAg do begin

      if ActiveCount =0 then exit;

      ProcessingCursor(true);
      try
        ShowProgressbar(WAITMSG, 5);
        try
          ChooseClass('Choose ' + Appenv.defaultclass.classheading+' to Transfer ' + stsTag +' with [' +inttostr(ActiveCount)+'] Plants');
          if fiTransferToClassID =0 then exit;
          if TransferTagto(fiTransferToclassID, fiTransferToBinID, employeeId, fdTransferDate) then begin
            StepProgressbar;
            CommitTransaction;
            StepProgressbar;
            CleanForm;
            StepProgressbar;
          end;
        finally
          HideProgressbar;
        end;
      finally
        Processingcursor(False);
      end;

    end;
end;
Procedure TfmStSMain.act_MANICURE_PLANTSExecute(Sender:TObject);
var
  fiActionID:Integer;
  fs:String;
  fdt:TDatetime;
begin
  if not IsTagSelected then Exit;

  if not IsEmployeeSelected then Exit;

  if not isTagActive then exit;
  fiActionID := NewStsAction(TDnmAction(Sender).caption);
  if fiActionID <> 0 then begin
  fdt := now;fs:= ''; fs:= '';
  if ModalInputTextnDate(TDnmAction(Sender).caption, '','Manicure Details',fs,fdt, initInputText) then begin
    With StsTAg do begin
      StSTag_Actions.New;
      StSTag_Actions.StatusDate := fdt;
      StSTag_Actions.StatusAction := TDnmAction(Sender).caption;
      StSTag_Actions.StatusActionId := fiActionID;
      StSTag_Actions.Description := fs;
      StSTag_Actions.PostDB;
      if Save then begin
        CleanForm;
      end;
    end;
  end;
  end;
end;

Procedure TfmStSMain.act_CREATE_PACKAGES_PRODUCTExecute(Sender:TObject);
var
  stsPackg: TstsPackage;
begin
  if not IsTagSelected then Exit;

  if not IsEmployeeSelected then Exit;

  if DeptClass.id = 0 then begin
    CommonLib.MessageDlgXP_Vista('Please Select a  ' + Appenv.defaultclass.classheading + '.' , mtWarning, [mbOk], 0);
    Exit;
  end;

  if not isTagActive then exit;

  // provide connection for stsPackg
  stsPackg := TStSPackage.CreateWithSharedConn(nil);
  try
    if stsPackg.CreatePackage(TDnmAction(Sender).caption, CreatePackageFunc) then
      CleanForm;
  finally
    FreeAndNil(stsPackg);
  end;
end;

Procedure TfmStSMain.act_REPLACE_TAGSExecute(Sender:TObject);
begin
  //REPLACE_TAGS
  if not IsTagSelected then Exit;

  if not IsEmployeeSelected then Exit;
end;
Procedure TfmStSMain.act_CHANGE_ROOMSExecute(Sender:TObject);
begin
  //CHANGE_ROOMS
  if not IsTagSelected then Exit;

  if not IsEmployeeSelected then Exit;
end;
Function TfmStSMain.isPackageTag(const aTag:String):Boolean;
var
  Qry:TERPQuery;
begin
  Qry := Employee.SharedQuery;
  try
    Qry.sql.text := 'SELECT * FROM tblststags where StSTag = '+quotedstr(aTag);
    Qry.open;
    result := Qry.Recordcount>0;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
Function TfmStSMain.isPlantTag(const aTag:String):Boolean;
begin
   Result := False;
end;
Function TfmStSMain.isTagActive:Boolean;
var
  fs:String;
begin
    Result := False;
    qryMain.first;
    fs:= qryMainStSTag.asString;
    if fs = '' then exit;
    Result := True;
    Result := StsTag.isTagActive;
end;
function TfmStSMain.StSTag: TStSTags;
begin
  if fStSTag = nil then begin
    fStSTag := TStSTags.create(Self);
    fStSTag.BusObjEvent := DoBusinessObjectEvent;
    fStSTag.connection := Employee.connection;
    fStSTag.Load(0);
  end;
  //if fStSTag.StsTag <> QrymainStstag.asString then begin
  if fStSTag.ID <> qryMainID.asInteger then begin
    //fStSTag.LoadSelect('StsTag =' + quotedstr(QrymainStstag.asString));
    fStSTag.Load(qryMainID.asInteger);
  end;
  result := fStSTag;
end;
procedure TfmStSMain.actSerialnumbersExecute(Sender: TObject);
begin
  inherited;
  CommitTransaction;
  try
    OpenERPListFormSingleselectModal('TStSTagsGUI', choosetag , InitStSTags, False, TERPConnection(MyDAcDataconnection.connection));
  finally
      BegintransAction;
  end;
end;
procedure TfmStSMain.actSerialnumbersUpdate(Sender: TObject);
begin
  inherited;
  //actSerialnumbers.caption := inttostr(SelectedTagscount)+' Tag(s) Selcted'+NL+'Choose Tags';
end;
procedure TfmStSMain.actTopAction1Update(Sender: TObject);
begin
  inherited;
  actTopAction1.Enabled := devmode;
end;
procedure TfmStSMain.actTopAction1Execute(Sender: TObject);
begin
  //
end;
procedure TfmStSMain.actTopAction2Update(Sender: TObject);
begin
  inherited;
  actTopAction2.Enabled := devmode;
end;
procedure TfmStSMain.actTopAction2Execute(Sender: TObject);
begin
  //
end;

initialization
  RegisterClassOnce(TfmStSMain);
end.
