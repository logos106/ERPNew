unit SimpleTypes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TSimpleTypesGUI = class(TBaseListingGUI)
    qryMaintypecode: TWideStringField;
    qryMaintypecodeDEsc: TWideStringField;
    qryMainID: TIntegerField;
    qryMainDetails: TLargeintField;
    qryMainName: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainIsDefault: TWideStringField;
    qryMainActive: TWideStringField;
    pnlHidewithnoNames: TDNMPanel;
    chkHidewithnoNames: TCheckBox;
    btnFullList: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);override;
    procedure grpFiltersClick(Sender: TObject);override;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure chkHidewithnoNamesClick(Sender: TObject);
    procedure btnFullListClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
  private
    fTypeCode: string;
    Procedure MakeQrymain;
  Protected
    procedure SetGridColumns; Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
  public
    Procedure RefreshQuery; Override;
    property TypeCode: string read fTypeCode write fTypeCode;

    Class Function	SimpleTypesCompanyTypeList                  (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;
    Class Function	SimpleTypesFollowUpTypeList                 (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;
    Class Function	SimpleTypesFollowUpResultTypeList           (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;
    Class Function	SimpleTypesStatusTypeList                   (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;
    Class Function	SimpleTypesLeadStatusTypeList               (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;
    Class Function	SimpleTypesPhSupportStatusTypeList          (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;
    Class Function	SimpleTypesCustomerReturnStatusList         (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;
    Class Function	SimpleTypesShippingContainerStatusTypeList  (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;
    Class Function	SimpleTypesAppointmentStatusTypeList        (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;
    Class Function	SimpleTypesAppointmentCancellationTypeList  (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;
    Class Function	SimpleTypesSalesCategoryList                (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;
    Class Function	SimpleTypesSalesDelDelayReasonList          (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;
    Class Function	SimpleTypesPhoneSupportTypeList             (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;
    Class Function	SimpleTypesPhoneSupportVersionList          (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;
    Class Function	SimpleTypesRepairFaultList                  (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;
    Class Function	SimpleTypesCAR_ActiontypeList               (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;
    Class Function	SimpleTypesCAR_ProductionbuildList          (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;
    Class Function	SimpleTypesCAR_ActionRequiredList           (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;
    Class Function	SimpleTypesCAR_PreventiveActionCommentsList (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;
    Class Function	SimpleTypesOrderStatusList                  (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;
    Class Function	SimpleTypesReturnAuthorityList              (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;
    Class Function	SimpleTypesCreditList                       (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;
    Class Function	SimpleTypesBillList                         (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;
    Class Function	SimpleTypeschequeList                       (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;
    Class Function	SimpleTypesRosterBreaksList                 (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;
    Class Function	SimpleTypesLeadActionTypeList               (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;
    Class Function	SimpleTypesBOM_WastageReasonList            (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;
    Class	Function	SimpleTypesProcresourceColourList           (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;
    Class Function	SimpleTypesEmployeeSkillLevelList           (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;
    Class Function	SimpleTypesMessageTypeList                  (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;

    Class Function	OpenSimpletypeListfor(aTypeCode:String;const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;

  end;

implementation

uses
  BusObjSimpleTypes, tcConst, frmSimpleTypes, CommonLib, CommonDbLib,
  frmSimpleTypeEdit;

{$R *.dfm}

procedure TSimpleTypesGUI.btnFullListClick(Sender: TObject);
var
  s1, s2:String;
begin
  inherited;
  filterString := '';
  cmdNew.Enabled := false;
  s1:= Qrymaintypecode.asString;
  s2:= QrymainName.asString;

  TitleLabel.caption := 'Type Codes';
  caption := TitleLabel.caption;
  btnFullList.visible := False;
  pnlHidewithnoNames.visible := TRue;

  RefreshQuery;
  Qrymain.locate('typecode;Name' , vararrayof([s1,s2]) , []);
end;

procedure TSimpleTypesGUI.chkHidewithnoNamesClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TSimpleTypesGUI.cmdNewClick(Sender: TObject);
var
  EditForm: TfmSimpleTypeEdit;
begin
  EditForm := TfmSimpleTypeEdit(CommonLib.GetComponentByClassName('TfmSimpleTypeEdit'));
  if not Assigned(EditForm) then exit;
  EditForm.KeyID := qryMainID.AsInteger;
  EditForm.FormStyle := fsMDIChild ;
  EditForm.BringToFront;
  EditForm.TypeCode := TypeCode;
end;

procedure TSimpleTypesGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := False;
  SearchMode:= smFullList;
end;

procedure TSimpleTypesGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin

  if (Qrymaindetails.asInteger =1) and (grpfilters.ItemIndex =1 ) then Afont.Style := Afont.Style+[fsBold]
  else if (Qrymaindetails.asInteger =2)  then
    if sametext(field.fieldname , qryMaintypecodeDEsc.fieldname ) then Afont.color := ABrush.color;
  inherited;
end;

procedure TSimpleTypesGUI.grdMainDblClick(Sender: TObject);
var
  EditForm: TfmSimpleTypeEdit;
begin
  inherited;
  if assigned(fOnGridDataSelect) then exit;

  if qryMainID.AsInteger < 1 then exit;

  EditForm := TfmSimpleTypeEdit(CommonLib.GetComponentByClassName('TfmSimpleTypeEdit'));
  if not Assigned(EditForm) then exit;
  EditForm.KeyID := qryMainID.AsInteger;
  EditForm.FormStyle := fsMDIChild ;
  EditForm.BringToFront;
end;

procedure TSimpleTypesGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Details' , ['1'], true);
  inherited;
end;

procedure TSimpleTypesGUI.MakeQrymain;

  Function SQLforSimpleType(const Typecode:String):String;
  begin
    Result := 'select distinct '      +NL+
               'SimpleTypetoDesc(' +quotedstr(Typecode  )+' ) as typecodeDEsc,'+NL+
               quotedstr(Typecode )+'  as typecode , '+NL+
               ' Null as ID, '+NL+
               ' 1 as Details , '+ NL +
               ' null as Name, '+NL+
               ' Null as Description , '+ Nl +
               ' null as IsDefault,' +NL +
               ' Null  as Active  ' + NL+
               iif(chkHidewithnoNames.checked and pnlHidewithnoNames.visible , ' From  tblsimpletypes where  typecode = ' +quotedstr(Typecode  )+' ' ,  ' From Dual');
  end;
begin
    Closedb(qrymain);
    Qrymain.sql.clear;
    Qrymain.sql.AdD(SQLforSimpleType(SimpleTypes_CompanyType                 ));Qrymain.sql.AdD('Union');
    Qrymain.sql.AdD(SQLforSimpleType(SimpleTypes_FollowUpType                ));Qrymain.sql.AdD('Union');
    Qrymain.sql.AdD(SQLforSimpleType(SimpleTypes_FollowUpResultType          ));Qrymain.sql.AdD('Union');
    Qrymain.sql.AdD(SQLforSimpleType(SimpleTypes_StatusType                  ));Qrymain.sql.AdD('Union');
    Qrymain.sql.AdD(SQLforSimpleType(SimpleTypes_LeadStatusType              ));Qrymain.sql.AdD('Union');
    Qrymain.sql.AdD(SQLforSimpleType(SimpleTypes_PhSupportStatusType         ));Qrymain.sql.AdD('Union');
    Qrymain.sql.AdD(SQLforSimpleType(SimpleTypes_CustomerReturnStatus        ));Qrymain.sql.AdD('Union');
    Qrymain.sql.AdD(SQLforSimpleType(SimpleTypes_ShippingContainerStatusType ));Qrymain.sql.AdD('Union');
    Qrymain.sql.AdD(SQLforSimpleType(SimpleTypes_AppointmentStatusType       ));Qrymain.sql.AdD('Union');
    Qrymain.sql.AdD(SQLforSimpleType(SimpleTypes_AppointmentCancellationType ));Qrymain.sql.AdD('Union');
    Qrymain.sql.AdD(SQLforSimpleType(SimpleTypes_SalesCategory               ));Qrymain.sql.AdD('Union');
    Qrymain.sql.AdD(SQLforSimpleType(SimpleTypes_SalesDelDelayReason         ));Qrymain.sql.AdD('Union');
    Qrymain.sql.AdD(SQLforSimpleType(SimpleTypes_PhoneSupportType            ));Qrymain.sql.AdD('Union');
    Qrymain.sql.AdD(SQLforSimpleType(SimpleTypes_PhoneSupportVersion         ));Qrymain.sql.AdD('Union');
    Qrymain.sql.AdD(SQLforSimpleType(SimpleTypes_RepairFault                 ));Qrymain.sql.AdD('Union');
    Qrymain.sql.AdD(SQLforSimpleType(simpletypes_CAR_Actiontype              ));Qrymain.sql.AdD('Union');
    Qrymain.sql.AdD(SQLforSimpleType(simpletypes_CAR_Productionbuild         ));Qrymain.sql.AdD('Union');
    Qrymain.sql.AdD(SQLforSimpleType(simpletypes_CAR_ActionRequired          ));Qrymain.sql.AdD('Union');
    Qrymain.sql.AdD(SQLforSimpleType(simpletypes_CAR_PreventiveActionComments));Qrymain.sql.AdD('Union');
    Qrymain.sql.AdD(SQLforSimpleType(SimpleTypes_OrderStatus                 ));Qrymain.sql.AdD('Union');
    Qrymain.sql.AdD(SQLforSimpleType(SimpleTypes_ReturnAuthority             ));Qrymain.sql.AdD('Union');
    Qrymain.sql.AdD(SQLforSimpleType(SimpleTypes_Credit                      ));Qrymain.sql.AdD('Union');
    Qrymain.sql.AdD(SQLforSimpleType(SimpleTypes_Bill                        ));Qrymain.sql.AdD('Union');
    Qrymain.sql.AdD(SQLforSimpleType(SimpleTypes_cheque                      ));Qrymain.sql.AdD('Union');
    Qrymain.sql.AdD(SQLforSimpleType(SimpleTypes_RosterBreaks                ));Qrymain.sql.AdD('Union');
    Qrymain.sql.AdD(SQLforSimpleType(SimpleTypes_LeadActionType              ));Qrymain.sql.AdD('Union');
    Qrymain.sql.AdD(SQLforSimpleType(SimpleTypes_BOM_WastageReason           ));Qrymain.sql.AdD('Union');
    Qrymain.sql.AdD(SQLforSimpleType(SimpleTypes_ProcresourceColour          ));Qrymain.sql.AdD('Union');
    Qrymain.sql.AdD(SQLforSimpleType(SimpleTypes_EmployeeSkillLevel          ));Qrymain.sql.AdD('Union');
    Qrymain.sql.AdD(SQLforSimpleType(SimpleTypes_MessageType                 ));Qrymain.sql.AdD('Union');
    Qrymain.sql.add('select');
    Qrymain.sql.add('SimpleTypetoDesc(typecode) as typecodeDEsc,');
    Qrymain.sql.add('typecode as typecode,');
    Qrymain.sql.add('ID as ID,');
    Qrymain.sql.add('2 as Details,');
    Qrymain.sql.add('Name as Name ,');
    Qrymain.sql.add('Description as Description ,');
    Qrymain.sql.add('IsDefault as IsDefault,');
    Qrymain.sql.add('Active  as Active         ');
    Qrymain.sql.add(' from tblsimpletypes');
    Qrymain.sql.add(' Order by typecodeDEsc , details, name ');
    RefreshOrignalSQL(False);
end;

procedure TSimpleTypesGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if GuiPrefs.Node.Exists('Options.HidewithnoNames') then
      chkHidewithnoNames.checked :=  GuiPrefs.Node['Options.HidewithnoNames'].asBoolean;
end;

procedure TSimpleTypesGUI.RefreshQuery;
begin
  MakeQrymain;
  inherited;
end;

procedure TSimpleTypesGUI.SetGridColumns;
begin
  inherited;

  RemoveFieldfromGrid(qryMainID.fieldname);
  if not devmode then begin
    RemoveFieldfromGrid(qryMainDetails.fieldname);
    RemoveFieldfromGrid(qryMaintypecode.fieldname);
  end;
end;

procedure TSimpleTypesGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.HidewithnoNames'].asBoolean := chkHidewithnoNames.checked;
end;
Class	Function	TSimpleTypesGUI.SimpleTypesCompanyTypeList                 (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;	begin Result := TSimpleTypesGUI.OpenSimpletypeListfor(SimpleTypes_CompanyType                 ,OpenModel, OnSelect); end;
Class	Function	TSimpleTypesGUI.SimpleTypesFollowUpTypeList                (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;	begin Result := TSimpleTypesGUI.OpenSimpletypeListfor(SimpleTypes_FollowUpType                ,OpenModel, OnSelect); end;
Class	Function	TSimpleTypesGUI.SimpleTypesFollowUpResultTypeList          (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;	begin Result := TSimpleTypesGUI.OpenSimpletypeListfor(SimpleTypes_FollowUpResultType          ,OpenModel, OnSelect); end;
Class	Function	TSimpleTypesGUI.SimpleTypesStatusTypeList                  (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;	begin Result := TSimpleTypesGUI.OpenSimpletypeListfor(SimpleTypes_StatusType                  ,OpenModel, OnSelect); end;
Class	Function	TSimpleTypesGUI.SimpleTypesLeadStatusTypeList              (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;	begin Result := TSimpleTypesGUI.OpenSimpletypeListfor(SimpleTypes_LeadStatusType              ,OpenModel, OnSelect); end;
Class	Function	TSimpleTypesGUI.SimpleTypesPhSupportStatusTypeList         (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;	begin Result := TSimpleTypesGUI.OpenSimpletypeListfor(SimpleTypes_PhSupportStatusType         ,OpenModel, OnSelect); end;
Class	Function	TSimpleTypesGUI.SimpleTypesCustomerReturnStatusList        (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;	begin Result := TSimpleTypesGUI.OpenSimpletypeListfor(SimpleTypes_CustomerReturnStatus        ,OpenModel, OnSelect); end;
Class	Function	TSimpleTypesGUI.SimpleTypesShippingContainerStatusTypeList (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;	begin Result := TSimpleTypesGUI.OpenSimpletypeListfor(SimpleTypes_ShippingContainerStatusType ,OpenModel, OnSelect); end;
Class	Function	TSimpleTypesGUI.SimpleTypesAppointmentStatusTypeList       (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;	begin Result := TSimpleTypesGUI.OpenSimpletypeListfor(SimpleTypes_AppointmentStatusType       ,OpenModel, OnSelect); end;
Class	Function	TSimpleTypesGUI.SimpleTypesAppointmentCancellationTypeList (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;	begin Result := TSimpleTypesGUI.OpenSimpletypeListfor(SimpleTypes_AppointmentCancellationType ,OpenModel, OnSelect); end;
Class	Function	TSimpleTypesGUI.SimpleTypesSalesCategoryList               (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;	begin Result := TSimpleTypesGUI.OpenSimpletypeListfor(SimpleTypes_SalesCategory               ,OpenModel, OnSelect); end;
Class	Function	TSimpleTypesGUI.SimpleTypesSalesDelDelayReasonList         (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;	begin Result := TSimpleTypesGUI.OpenSimpletypeListfor(SimpleTypes_SalesDelDelayReason         ,OpenModel, OnSelect); end;
Class	Function	TSimpleTypesGUI.SimpleTypesPhoneSupportTypeList            (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;	begin Result := TSimpleTypesGUI.OpenSimpletypeListfor(SimpleTypes_PhoneSupportType            ,OpenModel, OnSelect); end;
Class	Function	TSimpleTypesGUI.SimpleTypesPhoneSupportVersionList         (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;	begin Result := TSimpleTypesGUI.OpenSimpletypeListfor(SimpleTypes_PhoneSupportVersion         ,OpenModel, OnSelect); end;
Class	Function	TSimpleTypesGUI.SimpleTypesRepairFaultList                 (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;	begin Result := TSimpleTypesGUI.OpenSimpletypeListfor(SimpleTypes_RepairFault                 ,OpenModel, OnSelect); end;
Class	Function	TSimpleTypesGUI.SimpleTypesCAR_ActiontypeList              (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;	begin Result := TSimpleTypesGUI.OpenSimpletypeListfor(SimpleTypes_CAR_Actiontype              ,OpenModel, OnSelect); end;
Class	Function	TSimpleTypesGUI.SimpleTypesCAR_ProductionbuildList         (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;	begin Result := TSimpleTypesGUI.OpenSimpletypeListfor(SimpleTypes_CAR_Productionbuild         ,OpenModel, OnSelect); end;
Class	Function	TSimpleTypesGUI.SimpleTypesCAR_ActionRequiredList          (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;	begin Result := TSimpleTypesGUI.OpenSimpletypeListfor(SimpleTypes_CAR_ActionRequired          ,OpenModel, OnSelect); end;
Class	Function	TSimpleTypesGUI.SimpleTypesCAR_PreventiveActionCommentsList(const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;	begin Result := TSimpleTypesGUI.OpenSimpletypeListfor(SimpleTypes_CAR_PreventiveActionComments,OpenModel, OnSelect); end;
Class	Function	TSimpleTypesGUI.SimpleTypesOrderStatusList                 (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;	begin Result := TSimpleTypesGUI.OpenSimpletypeListfor(SimpleTypes_OrderStatus                 ,OpenModel, OnSelect); end;
Class	Function	TSimpleTypesGUI.SimpleTypesReturnAuthorityList             (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;	begin Result := TSimpleTypesGUI.OpenSimpletypeListfor(SimpleTypes_ReturnAuthority             ,OpenModel, OnSelect); end;
Class	Function	TSimpleTypesGUI.SimpleTypesCreditList                      (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;	begin Result := TSimpleTypesGUI.OpenSimpletypeListfor(SimpleTypes_Credit                      ,OpenModel, OnSelect); end;
Class	Function	TSimpleTypesGUI.SimpleTypesBillList                        (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;	begin Result := TSimpleTypesGUI.OpenSimpletypeListfor(SimpleTypes_Bill                        ,OpenModel, OnSelect); end;
Class	Function	TSimpleTypesGUI.SimpleTypeschequeList                      (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;	begin Result := TSimpleTypesGUI.OpenSimpletypeListfor(SimpleTypes_cheque                      ,OpenModel, OnSelect); end;
Class	Function	TSimpleTypesGUI.SimpleTypesRosterBreaksList                (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;	begin Result := TSimpleTypesGUI.OpenSimpletypeListfor(SimpleTypes_RosterBreaks                ,OpenModel, OnSelect); end;
Class	Function	TSimpleTypesGUI.SimpleTypesLeadActionTypeList              (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;	begin Result := TSimpleTypesGUI.OpenSimpletypeListfor(SimpleTypes_LeadActionType              ,OpenModel, OnSelect); end;
Class	Function	TSimpleTypesGUI.SimpleTypesBOM_WastageReasonList           (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;	begin Result := TSimpleTypesGUI.OpenSimpletypeListfor(SimpleTypes_BOM_WastageReason           ,OpenModel, OnSelect); end;
Class	Function	TSimpleTypesGUI.SimpleTypesProcresourceColourList          (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;	begin Result := TSimpleTypesGUI.OpenSimpletypeListfor(SimpleTypes_ProcresourceColour          ,OpenModel, OnSelect); end;
Class	Function	TSimpleTypesGUI.SimpleTypesEmployeeSkillLevelList          (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;	begin Result := TSimpleTypesGUI.OpenSimpletypeListfor(SimpleTypes_EmployeeSkillLevel          ,OpenModel, OnSelect); end;
Class	Function	TSimpleTypesGUI.SimpleTypesMessageTypeList                 (const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;	begin Result := TSimpleTypesGUI.OpenSimpletypeListfor(SimpleTypes_MessageType                 ,OpenModel, OnSelect); end;

Class Function  TSimpleTypesGUI.OpenSimpletypeListfor(aTypeCode:String;const OpenModel:Boolean=False;OnSelect:TOnGridDataSelect=nil):Integer;
var
  Form : TComponent;
begin
    result := 0;
    Form := GetComponentByClassName('TSimpleTypesGUI',True);
    TSimpleTypesGUI(Form).TypeCode := aTypeCode;
    if Assigned(Form) then begin //if has acess
        With TSimpleTypesGUI(Form) do begin
            FilterString := 'typecode =' +quotedstr(typecode);
            TitleLabel.caption := TSimpleTypes.SimpleTypeTypeDesc(aTypeCode)+' List';
            caption := TitleLabel.caption;
            btnFullList.visible := true;
            pnlHidewithnoNames.visible := False;
            grpfilters.itemindex := 1;
            if OpenModel  then begin
                TSimpleTypesGUI(Form).grdMain.Options:=TSimpleTypesGUI(Form).grdMain.Options - [dgMultiSelect];
                TSimpleTypesGUI(Form).grdMain.Options:=TSimpleTypesGUI(Form).grdMain.Options + [dgRowSelect];
                TSimpleTypesGUI(Form).CloseOnRecSelect:= True;
                TSimpleTypesGUI(Form).OnGridDataSelect := OnSelect;
                if Showmodal = mrok then begin
                  REsult := TSimpleTypesGUI(Form).qryMainID.asInteger;
                end;
            end else begin
              FormStyle := fsMDIChild;
              BringToFront;
            end;
        end;
    end else begin
      MessageDlgXP_Vista('You Don''t Have Access to Open This List', mtWarning, [mbOK], 0);
    end;
end;

initialization
  RegisterClassOnce( TSimpleTypesGUI);

end.
