unit CommonFormLib;

interface

uses BaseListingForm, frmBase,classes , forms, DnMPanel , ExtCtrls, stdctrls, Controls,ERPdbComponents;

function OpenERPForm(const FormClassname: string; KeyID: Integer; Aftershow: TNotifyEvent = nil;Beforeshow: TNotifyEvent = nil; BringTofrontIfAlreadyShown: boolean = False; SingleInstance: boolean = true; IsReadOnly: boolean = false): Boolean;
function OpenERPForminPanel(const FormClassname: string;Owner:TComponent; ParentPanel :TDnMPanel; Beforeshow: TNotifyEvent = nil; Aftershow: TNotifyEvent = nil): TComponent;
function OpenERPFormModal(const FormClassname :String ; KeyID:Integer; Beforeshow: TNotifyEvent = nil;  ignoreAccesslevel :boolean = False; OnResultOk :TNotifyEvent = nil):Integer;
Function Openedrecordno(const formclassname, Recordtype :String):String;
Function isformClosed(const FormClassName:STring):boolean;
function OpenERPListForm(const FormClassName:string;BeforeShow:TNotifyEvent=nil;AfterShow:TNotifyEvent=nil; closeifListempty:Boolean =False; OnListcose:TNotifyEvent=nil):Boolean;
function CreatenOpenERPListForm(const FormClassName:string;BeforeShow:TNotifyEvent=nil; SingleInstance: boolean = true;AfterShow:TNotifyEvent=nil; OnListcose:TNotifyEvent=nil; aConnection :TERPConnection=nil):Tcomponent;
function OpenERPListFormultiselect(const FormClassName:string;BeforeShow:TNotifyEvent=nil; SingleInstance: boolean = true;OnSelect:TOnGridDataSelect=nil; aConnection :TERPConnection=nil):Boolean;
function OpenERPListFormultiselectModal   (const FormClassName:string;BeforeShow:TNotifyEvent=nil;OnSelect:TOnGridDataSelect=nil; aConnection :TERPConnection=nil; ignoreAccesslevel :boolean = False ):Boolean;
Procedure OpenERPListFormSingleselectModal(const FormClassName:string;OnSelect:TOnGridDataSelect;BeforeShow:TNotifyEvent=nil;IgnoreAccesslevel:Boolean=False; aConnection :TERPConnection=nil);
Procedure OpenERPListFormSingleselect     (const FormClassName:string;OnSelect:TOnGridDataSelect;BeforeShow:TNotifyEvent=nil;AfterShow:TNotifyEvent=nil; SingleInstance: boolean = true; aConnection :TERPConnection=nil);
Procedure OpenERPListFormModal(const FormClassName:string;OnSelect:TOnGridDataSelect;BeforeShow:TNotifyEvent=nil; aConnection :TERPConnection=nil; SingleInstance: boolean = true );
procedure SetSourceFrmButtons(SourceForm:TfrmBaseGUI);
Function ISMdiParentvisible:Boolean;
procedure CreateHistorylistform(HistorylistformName: String;
  AOwner:TComponent; var HistoryListform: TBaseListingGUI; Searchfield:String='';
  SearchValue: String=''; doInitListofSubform:TNotifyEvent = nil;
  CheckAccessLevels: boolean = false);
Procedure ShowERPHint(const Value:String; AOwner:Tform);
Procedure ShowUpdateBatchHint(AOwner:TForm; fwidth:Integer=0;ftop:Integer=0;fLeft:Integer=0);
Procedure HideERPHint(AOwner:TForm);
Procedure StretchImage(Img :TImage ; Value:Boolean);
Function PrintReport(Const CheckBox:TcheckBox):Boolean;
Procedure Largefont(acontrols : array of Tcontrol);
function CloseformifOpen(const FormClassName:string):Boolean;
Procedure ShowInLowerHalf(aForm :Tform);
Procedure ShowInUpperHalf(aForm :Tform);
implementation

uses Graphics, DNMSpeedButton, Wwdbigrd,  BaseInputForm, BaseFormForm, CommonLib,
  QueryManipulationObj, sysutils, AppEnvironment, Dialogs , frmERPhint, tcConst, MAIN;

Procedure CreateHistorylistform(HistorylistformName: String; AOwner: TComponent;
  var HistoryListform: TBaseListingGUI; Searchfield: String='';
  SearchValue: String=''; doInitListofSubform: TNotifyEvent=nil;
  CheckAccessLevels: boolean=false);
var
  QueryManipulationObj: TQueryManipulationObj;
begin
  if not(Assigned(HistoryListform)) then
    HistoryListform := TBaseListingGUI(getcomponentbyClassname(HistorylistformName, False, AOwner, CheckAccessLevels));

  if Assigned(HistoryListform) then begin
    HistoryListform.Tag := 99;
    HistoryListform.InitListofSubform := doInitListofSubform;
    if not HistoryListform.ListManRunOnce then begin
      if (searchField <> '') and (SearchValue <> '') then begin
        QueryManipulationObj := TQueryManipulationObj.Create(HistoryListform.qryMain.SQL.Text);
        try
          QueryManipulationObj.ProcessSearch(Searchfield, SearchValue);
          HistoryListform.qryMain.SQL.Text := QueryManipulationObj.ModifiedSQL;
          HistoryListform.RefreshOrignalSQL;
          HistoryListform.ListManRunOnce := true;
        finally
          FreeandNil(QueryManipulationObj);
        end;
      end;
    end;
  end;
end;

Procedure OpenERPListFormModal(const FormClassName:string;OnSelect:TOnGridDataSelect;BeforeShow:TNotifyEvent=nil; aConnection :TERPConnection=nil;SingleInstance: boolean = true );
var
  Form : TComponent;
begin

    if FormClassname = '' then exit;
    if SingleInstance then
      if FormStillOpen(FormClassname) then begin
          Form := GetComponentByClassName(FormClassname);
          if assigned(Form) and  ((aConnection=nil) or (aConnection = TBaseListingGUI(Form).Listconnection)) then begin
            TBaseForm(Form).BringToFront;
            Exit;
          end;
      end;

    Form := GetComponentByClassName(FormClassname , SingleInstance);

    if Assigned(Form) then begin //if has acess
      if (aconnection <> nil) and (aconnection.connected) then TBaseListingGUI(form).PassedConnection :=aconnection;
      If Assigned(BeforeShow) then BeforeShow(Form);
      if form is TBaseListingGUI then TBaseListingGUI(form).OnGridDataSelect := OnSelect;
      if form is TBaseForm then
        With TBaseForm(Form) do begin
            ShowModal;
        end;
    end;
end;
Procedure OpenERPListFormSingleselectModal(const FormClassName:string;OnSelect:TOnGridDataSelect;BeforeShow:TNotifyEvent=nil;IgnoreAccesslevel:Boolean=False; aConnection :TERPConnection=nil);
var
  Form : TComponent;
begin
  Form := nil;
  try
    if FormClassname = '' then exit;
    if FormStillOpen(FormClassname) then begin
        Form := GetComponentByClassName(FormClassname);
        if not(fsmodal in TBaseForm(Form).formstate) then begin
          TBaseForm(Form).close;
          Freeandnil(form);
          Application.ProcessMessages;
        end else begin
        	if assigned(Form) and  ((aConnection=nil) or (aConnection = TBaseListingGUI(Form).Listconnection)) then begin
          		TBaseForm(Form).BringToFront;
          		Exit;
        	end;
		end;
    end;
    Form := GetComponentByClassName(FormClassname, true, nil , not(IgnoreAccesslevel));
    if Assigned(Form) then begin //if has acess
      if form is TBaseListingGUI then begin
        if (aconnection <> nil) and (aconnection.connected) then TBaseListingGUI(form).PassedConnection :=aconnection;
        TBaseListingGUI(form).grdMain.Options:=TBaseListingGUI(form).grdMain.Options - [dgMultiSelect];
        TBaseListingGUI(form).grdMain.Options:=TBaseListingGUI(form).grdMain.Options + [dgRowSelect];
        TBaseListingGUI(form).CloseOnRecSelect:= True;
        TBaseListingGUI(form).OnGridDataSelect := OnSelect;
      end;
      If Assigned(BeforeShow) then BeforeShow(Form);
      if form is TBaseForm then TBaseForm(Form).Showmodal;
    end;
  Finally
      Freeandnil(form);
  end;
  (* OpenERPListFormSingleselect(FormClassName,OnSelect,BeforeShow);
  While not(isformClosed(FormClassName)) do; *)
end;
Procedure OpenERPListFormSingleselect(const FormClassName:string;OnSelect:TOnGridDataSelect;BeforeShow:TNotifyEvent=nil;AfterShow:TNotifyEvent=nil; SingleInstance: boolean = true; aConnection :TERPConnection=nil);
var
  Form : TComponent;
begin
  form:= CreatenOpenERPListForm(FormClassname , BeforeShow , SingleInstance ,nil, nil, aconnection);
  if form = nil then exit;
  if form is TBaseListingGUI then begin
    TBaseListingGUI(form).grdMain.Options:=TBaseListingGUI(form).grdMain.Options - [dgMultiSelect];
    TBaseListingGUI(form).grdMain.Options:=TBaseListingGUI(form).grdMain.Options + [dgRowSelect];
    (*TBaseListingGUI(form).grdMain.OnDblClick := OnSelect;*)
    TBaseListingGUI(form).CloseOnRecSelect:= True;
    TBaseListingGUI(form).OnGridDataSelect := OnSelect;
  end;
  If Assigned(AfterShow) then AfterShow(Form);
end;
function CloseformifOpen(const FormClassName:string):Boolean;
var
  Form : TComponent;
begin
    result:= False;
    if FormClassname = '' then exit;
    if FormStillOpen(FormClassname) then begin
      Form :=  FindExistingComponent(FormClassname);
      TForm(Form).BringtoFront;
      TForm(Form).Close;
      Application.ProcessMessages;
    end;
end;


function OpenERPListFormultiselectModal(const FormClassName:string;BeforeShow:TNotifyEvent=nil;OnSelect:TOnGridDataSelect=nil; aConnection :TERPConnection=nil; ignoreAccesslevel :boolean = False):Boolean;
var
  Form : TComponent;
begin
  result:= False;
    if FormClassname = '' then exit;
    if FormStillOpen(FormClassname) then begin
      Form :=  FindExistingComponent(FormClassname);
      TForm(Form).BringtoFront;
      TForm(Form).Close;
      Application.ProcessMessages;
    end;
    if FormStillOpen(FormClassname) then exit;

    Form := GetComponentByClassName(FormClassname, true, nil , not(IgnoreAccesslevel));
    if Assigned(Form) then begin //if has acess
      if (aconnection <> nil) and (aconnection.connected) then TBaseListingGUI(form).PassedConnection :=aconnection;
      If Assigned(BeforeShow) then BeforeShow(Form);
      if form is TBaseListingGUI then begin
        TBaseListingGUI(form).cmdNew.enabled := false;
        TBaseListingGUI(form).grdMain.Options:=TBaseListingGUI(form).grdMain.Options + [dgMultiSelect];
        TBaseListingGUI(form).grdMain.MultiSelectOptions := [msoAutoUnselect,msoShiftSelect];
        TBaseListingGUI(form).OnGridDataSelect:= onSelect;
        TBaseListingGUI(form).showmodal;
        REsult:= TRue;
      end;
    end;

end;
function OpenERPListFormultiselect(const FormClassName:string;BeforeShow:TNotifyEvent=nil; SingleInstance: boolean = true;OnSelect:TOnGridDataSelect=nil; aConnection :TERPConnection=nil):Boolean;
var
  Form : TComponent;
begin
  Result := False;
  form:= CreatenOpenERPListForm(FormClassname , BeforeShow, SingleInstance, nil, nil, aConnection);
  if form = nil then exit;
  if form is TBaseListingGUI then begin
    TBaseListingGUI(form).grdMain.Options:=TBaseListingGUI(form).grdMain.Options + [dgMultiSelect];
    TBaseListingGUI(form).grdMain.MultiSelectOptions := [msoAutoUnselect,msoShiftSelect];
    TBaseListingGUI(form).OnGridDataSelect:= onSelect;
    result := true;
  end;
end;

function OpenERPListForm(const FormClassName:string;BeforeShow:TNotifyEvent=nil;AfterShow:TNotifyEvent=nil; closeifListempty:Boolean =False; OnListcose:TNotifyEvent=nil):Boolean;
var
  Form : TComponent;
begin
  form  := CreatenOpenERPListForm(FormClassname , BeforeShow, true, AfterShow ,OnListcose);
  if form <> nil then
    if closeifListempty then
      if form is TBaseListingGUI then
        if TBaseListingGUI(form).qryMain.RecordCount =0 then begin
          TBaseListingGUI(form).closingifListempty := True;
          TBaseListingGUI(form).Close;
        end;

  result := form<> nil;
end;

function CreatenOpenERPListForm(const FormClassName:string;BeforeShow:TNotifyEvent=nil; SingleInstance: boolean = true;AfterShow:TNotifyEvent=nil; OnListcose:TNotifyEvent=nil; aConnection :TERPConnection=nil):Tcomponent;
var
  Form : TComponent;
begin
  Form := nil;
  result:= nil;
  try
    if FormClassname = '' then exit;
    if SingleInstance and FormStillOpen(FormClassname)  then begin
        Form := GetComponentByClassName(FormClassname);
        if assigned(Form) and  ((aConnection=nil) or (aConnection = TBaseListingGUI(Form).Listconnection)) then begin
          TBaseForm(Form).BringToFront;
          Exit;
        end;
    end;

    Form := GetComponentByClassName(FormClassname,SingleInstance);
    if Assigned(Form) then begin //if has acess
      if (aconnection <> nil) and (aconnection.connected) then TBaseListingGUI(form).PassedConnection :=aconnection;
      If Assigned(BeforeShow) then BeforeShow(Form);
      if form is TBaseListingGUI then TBaseListingGUI(form).OnListcose := OnListcose;
      if form is TBaseForm then
        With TBaseForm(Form) do begin
            FormStyle := fsMDIChild;
            BringToFront;
            If Assigned(AfterShow) then AfterShow(Form);
        end;
    end;
  Finally
      REsult := form;
  end;
end;
Function isformClosed(const FormClassName:STring):boolean;
begin
  Result := True;
  if FormStillOpen(FormClassName) then begin
    Sleep(100);
    Application.ProcessMessages;
    result := False;
  end;
end;
Function Openedrecordno(const formclassname, Recordtype :String):String;
var
  Form : TComponent;
begin
  Form :=  FindExistingComponent(formclassname);
  if assigned(Form) then result := Recordtype + ' # ' +inttostr(TBaseInputGUI(Form).keyID)
  else result:= 'another ' +Recordtype;
end;

function OpenERPFormModal(const FormClassname :String ; KeyID:Integer; Beforeshow:TNotifyEvent = nil; ignoreAccesslevel :boolean = False; OnResultOk :TNotifyEvent = nil ):Integer;
var
  Form : TComponent;
  AccessLevel: integer;
begin
  result := -1;
  if FormClassname = '' then exit;
  AccessLevel := AppEnv.AccessLevels.GetEmployeeAccessLevel(FormClassname);
  if not ignoreAccesslevel then begin
    if (AccessLevel = 6) then begin
      MessageDlgXP_Vista('You do not have Access to ' + AppEnv.AccessLevels.GetFormDescription(FormClassname), mtWarning	, [mbOK], 0);
      Exit;
    end;
  end;
  if FormStillOpen(FormClassname) then begin
      Form :=  FindExistingComponent(FormClassname);
      TForm(Form).BringtoFront;
      TForm(Form).Close;
      Application.ProcessMessages;
  end;
  if FormStillOpen(FormClassname) then exit;

  Form := GetComponentByClassName(FormClassname, true , nil , not(ignoreAccesslevel));
  try
    if Assigned(Form) then begin //if has acess
      if form is TBaseForm then
        TBaseForm(form).fbIgnoreAccessLevels := ignoreAccesslevel;

      if Form is TBaseInputGUI then
          TBaseInputGUI(Form).KeyID := KeyID;
      if form is TBaseForm then
        With TBaseForm(Form) do begin
            if assigned(Beforeshow) then Beforeshow(Form);
            if showmodal = mrOk then begin
              if Assigned(OnResultOk) then
                OnResultOk(form);
              if form is TBaseinputGUI then
                result := TBaseinputGUI(Form).KeyID
              else result:=0;
            end;
        end;
    end;
  finally
    Freeandnil(Form);
    //TForm(Form).Release;  {release causing issues when called the form multiple times wihtin a loop}
  end;
end;

function OpenERPForminPanel(const FormClassname: string;Owner:TComponent; ParentPanel :TDnMPanel; Beforeshow: TNotifyEvent = nil; Aftershow: TNotifyEvent = nil): TComponent;
begin
   result := GetComponentByClassName(FormClassname , true, Owner );
   if Assigned(Result) then begin
    if assigned(Beforeshow) then Beforeshow(result);
    if result is Tform then begin
      Tform(Result).Parent := ParentPanel;
      Tform(Result).Align := alclient;
    end;
    Tform(Result).bringtofront;
    if assigned(Aftershow) then Aftershow(result);
   end;
end;

function OpenERPForm(const FormClassname: string; KeyID: Integer;
  Aftershow: TNotifyEvent = nil; Beforeshow: TNotifyEvent = nil;
  BringTofrontIfalreadyshown: boolean = False;
  SingleInstance: boolean = true; IsReadOnly: boolean = false): Boolean;
var
  Form : TComponent;
  AccessLevel: integer;
begin
  result := False;
  if FormClassname = '' then exit;
  AccessLevel := AppEnv.AccessLevels.GetEmployeeAccessLevel(FormClassname);
  if AccessLevel = 6 then begin
    MessageDlgXP_Vista('You do not have Access to ' + AppEnv.AccessLevels.GetFormDescription(FormClassname), mtWarning	, [mbOK], 0);
    Exit;
  end;
  if singleInstance then begin
    if FormStillOpen(FormClassname) then begin
       Form :=  FindExistingComponent(FormClassname);
       if BringTofrontIfalreadyshown then begin
           TForm(Form).BringtoFront;
           exit;
       end;
        TForm(Form).Close;
        Application.ProcessMessages;
    end;
    if FormStillOpen(FormClassname) then exit;
  end;

  Form := GetComponentByClassName(FormClassname , singleInstance);
  if Assigned(Form) then begin //if has acess
    if Form is TBaseInputGUI then
        TBaseInputGUI(Form).KeyID := KeyID;
    if form is TBaseForm then
      With TBaseForm(Form) do begin
          if accesslevel = 6 then begin
            Freeandnil(Form);
            exit;
          end;
          if IsReadOnly then
            AccessLevel := 5;
          if assigned(Beforeshow) then Beforeshow(Form);
          if ISMdiParentvisible then begin
            FormStyle := fsMDIChild ;
            if assigned(Aftershow) then Aftershow(Form);
            BringToFront;
          end else begin
            Show;
            if assigned(Aftershow) then Aftershow(Form);
          end;

          result := true;
      end;
  end;
end;

Function ISMdiParentvisible:Boolean;
begin
    Result := False;
    if Assigned(Application.mainform) then
      if Application.mainform.visible then
        if not(fsShowing in Application.mainform.FormState) then
          Result := True;

end;
procedure SetSourceFrmButtons(SourceForm:TfrmBaseGUI);
  var    //Source form is a dynamically loaded form (panel holder form)
    Index:integer;
  begin
    for Index := 0 to SourceForm.ComponentCount - 1 do begin
      if SourceForm.Components[Index] is TDNMSpeedButton then begin
            with TDNMSpeedButton(SourceForm.Components[Index]) do begin
              Alignment := taCenter;
              Color := clWhite;
              HotTrackColor := clBtnShadow;
              SlowDecease := true;
              Style := bsModern;
            end;
      end;
    end;
  end;
Procedure ShowERPHint(const Value:String; AOwner:Tform);
begin
  TfmERPHint.ShowERPHint(Value , AOwner);
end;
Procedure ShowUpdateBatchHint(AOwner:TForm; fwidth:Integer=0;ftop:Integer=0;fLeft:Integer=0);
var
  s:String;
begin
  s:= 'Windows may display "Not Responding"' +NL +
      'Please ignore as the process is working in the background' +NL+NL+
      'This Process Started at ' +Quotedstr(formatdatetime('hh:nn am/pm' , now)) +NL+'it may take up to 2 hours to run';
  TfmERPHint.ShowERPHint(s , AOwner, fwidth, ftop, fLeft);
end;

Procedure HideERPHint(AOwner: TForm);
var
//  Form :TfmERPHint;
  x: integer;
begin
  for x := 0 to AOwner.ComponentCount - 1 do begin
    if (AOwner.Components[x] is TfmERPHint) {and
        SameText(TfmERPHint(Application.Components[x]).formOwnerform,AOwner.Classname)} then begin
      TfmERPHint(AOwner.Components[x]).Close;
      break;
    end;
  end;

//  form := TfmERPHint(GetComponentByClassName('TfmERPHint'));
//  if Assigned(form) THEN begin
//    if form.formOwnerform = AOwner.Classname then begin
//      form.close;
//    end;
//  end;
end;

Procedure StretchImage(Img :TImage ; Value:Boolean);
begin
  Img.Stretch := Value;
  Img.Proportional := not(Value);
end;

Function PrintReport(Const CheckBox:TcheckBox):Boolean;
begin
  result := not(Devmode) and ((CheckBox = nil) or  not(CheckBox.Checked))
end;
Procedure Largefont(aControls : array of Tcontrol);
var
  ctr:Integer ;
const
    LARGE_FONT_SIZE = 18;
begin
  for ctr:= low(aControls) to high(aControls) do begin
    if aControls[ctr] is TLabel then begin
      TLabel(aControls[ctr]).Font.size := LARGE_FONT_SIZE;
      TLabel(aControls[ctr]).Autosize := True;
      TLabel(aControls[ctr]).Font.Style := TLabel(aControls[ctr]).Font.Style +[fsBold];
      TLabel(aControls[ctr]).Layout := tlcenter;
      TLabel(aControls[ctr]).alignment := taCenter;
    end;
  end;

end;
Procedure ShowInLowerHalf(aForm :Tform);
begin
  With aform do begin
    height :=trunc(mainform.Formheight/2)-2;
    Top := trunc(mainform.Formheight/2)+2;
    Left := 0;
    Width :=mainform.width;
    anchors :=[akLeft,akbottom,akright];
  end;
end;
Procedure ShowInUpperHalf(aForm :Tform);
begin
  With aform do begin
    Top := 0;
    height :=trunc(mainform.Formheight/2)-2;
    Left := 0;
    Width :=mainform.Clientwidth;
    anchors :=[akLeft,akbottom,akright];
  end;

end;

end.
