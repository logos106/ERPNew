unit BusObjAllowances;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   10/08/07   1.00.01   A.   Initial Version.
   }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
   TAllowance = class(TMSBusObj)

   Private
      Function GetDescription           :String    ;
      Function GetSuperinc              :Boolean   ;
      Function GetTaxexempt             :Boolean   ;
      Function GetPayrolltaxexempt      :Boolean   ;
      Function GetWorkcoverexempt       :Boolean   ;
      Function GetDisplayin             :String    ;
      Function GetAmount                :Double    ;
      Function GetCalcby                :String   ;
      Function GetArea                  :String   ;
      Function GetPercentage            :Double    ;
      Function GetBasedonid             :Integer   ;
      Function GetActive                :Boolean   ;
      Function GetAccountid             :Integer   ;
      Function GetAccountname           :String    ;
      Function GetDisplayName           :String    ;
      Procedure SetDescription           (Const Value :String    );
      Procedure SetSuperinc              (Const Value :Boolean   );
      Procedure SetTaxexempt             (Const Value :Boolean   );
      Procedure SetPayrolltaxexempt      (Const Value :Boolean   );
      Procedure SetWorkcoverexempt       (Const Value :Boolean   );
      Procedure SetDisplayin             (Const Value :String    );
      Procedure SetAmount                (Const Value :Double    );
      Procedure SetCalcby                (Const Value :String   );
      Procedure SetArea                  (Const Value :String   );
      Procedure SetPercentage            (Const Value :Double    );
      Procedure SetBasedonid             (Const Value :Integer   );
      Procedure SetActive                (Const Value :Boolean   );
      Procedure SetAccountid             (Const Value :Integer   );
      Procedure SetAccountname           (Const Value :String    );
      Procedure SetDisplayName           (Const Value :String    );

    function GetAllowanceType: string;
    procedure SetAllowanceType(const value: string);

    function GetAllowanceCode: string;
    procedure SetAllowanceCode(const value: string);


   Protected
      procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);   Override;
      procedure DoFieldOnChange(Sender: TField);                           Override;
      Function  GetSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;


   Public
      class function GetIDField: string; override;
      class function GetBusObjectTablename: string; Override;
      Constructor Create(AOwner: TComponent); override;

      Destructor   Destroy;                                                override;
      Procedure    LoadFromXMLNode(Const node: IXMLNode);                  override;
      Procedure    SaveToXMLNode(Const node: IXMLNode);                    override;
      Function     ValidateData :Boolean ;                                 Override;
      Function     Save :Boolean ;                                         Override;


  Published
      Property Description            :String       Read getDescription         Write SetDescription     ;
      Property Superinc               :Boolean      Read getSuperinc            Write SetSuperinc        ;
      Property Taxexempt              :Boolean      Read getTaxexempt           Write SetTaxexempt       ;
      Property Payrolltaxexempt       :Boolean      Read getPayrolltaxexempt    Write SetPayrolltaxexempt;
      Property Workcoverexempt        :Boolean      Read getWorkcoverexempt     Write SetWorkcoverexempt ;
      { One of 'Allowances','Gross','Do Not Display' }
      Property DisplayIn              :String       Read GetDisplayIn           Write SetDisplayIn       ;
      Property Amount                 :Double       Read getAmount              Write SetAmount          ;
      Property Calcby                 :String       Read getCalcby              Write SetCalcby          ;
      Property Area                   :String       Read getArea                Write SetArea          ;
      Property Percentage             :Double       Read getPercentage          Write SetPercentage      ;
      Property Basedonid              :Integer      Read getBasedonid           Write SetBasedonid       ;
      Property Active                 :Boolean      Read getActive              Write SetActive          ;
      Property Accountid              :Integer      Read getAccountid           Write SetAccountid       ;
      Property Accountname            :String       Read getAccountname         Write SetAccountname     ;
      { ATO allowance categorisation, one of
          Car, Transport, Laundry, Meals, Travel, Other }
      property AllowanceType: string read GetAllowanceType write SetAllowanceType;
      property AllowanceCode: string read GetAllowanceCode write SetAllowanceCode;
      property DisplayName: String read GetDisplayName write SetDisplayName;
   End;


implementation
uses
  Sysutils, PayCommon,BusObjConst, CommonLib;


{========================================================
         TAllowance
========================================================}

constructor TAllowance.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   fSQL := 'SELECT * FROM tblallowances';
end;

destructor TAllowance.Destroy;
begin
   inherited;
end;


procedure   TAllowance.LoadFromXMLNode(Const node: IXMLNode);
begin
   inherited;
      SetPropertyFromNode(Node,'Description');
      SetBooleanPropertyFromNode(Node,'Superinc');
      SetBooleanPropertyFromNode(Node,'Taxexempt');
      SetBooleanPropertyFromNode(Node,'Payrolltaxexempt');
      SetBooleanPropertyFromNode(Node,'Workcoverexempt');
      SetPropertyFromNode(Node,'Displayin');
      SetPropertyFromNode(Node,'Amount');
      SetPropertyFromNode(Node,'Calcby');
      SetPropertyFromNode(Node,'Area');
      SetPropertyFromNode(Node,'Percentage');
      SetPropertyFromNode(Node,'Basedonid');
      SetBooleanPropertyFromNode(Node,'Active');
      SetPropertyFromNode(Node,'Accountid');
      SetPropertyFromNode(Node,'Accountname');
      SetPropertyFromNode(Node,'displayname');
end;


procedure   TAllowance.SaveToXMLNode(Const node: IXMLNode);
begin
   inherited;
      AddXMLNode(node,'Description' ,Description);
      AddXMLNode(node,'Superinc' ,Superinc);
      AddXMLNode(node,'Taxexempt' ,Taxexempt);
      AddXMLNode(node,'Payrolltaxexempt' ,Payrolltaxexempt);
      AddXMLNode(node,'Workcoverexempt' ,Workcoverexempt);
      AddXMLNode(node,'Displayin' ,Displayin);
      AddXMLNode(node,'Amount' ,Amount);
      AddXMLNode(node,'Calcby' ,Calcby);
      AddXMLNode(node,'Area' ,Area);
      AddXMLNode(node,'Percentage' ,Percentage);
      AddXMLNode(node,'Basedonid' ,Basedonid);
      AddXMLNode(node,'Active' ,Active);
      AddXMLNode(node,'Accountid' ,Accountid);
      AddXMLNode(node,'Accountname' ,Accountname);
      AddXMLNode(node,'displayname' ,Accountname);
end;



function    TAllowance.ValidateData :Boolean ;
begin
   Result := False;
   Resultstatus.Clear;
   if Description = '' then begin
      Resultstatus.AddItem(False , rssError , 0,  'Description should not be blank'  );
      Exit;
   end;
   if Displayin = '' then begin
      Resultstatus.AddItem(False , rssError , 0,  'Displayin should not be blank'  );
      Exit;
   end;
   if Amount = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Amount should not be 0'  );
      Exit;
   end;
   if CalcBy = '' then begin
      Resultstatus.AddItem(False , rssError , 0,  'CalcBy should not be blank' );
      Exit;
   end;
   if Basedonid = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Basedonid should not be 0' );
      Exit;
   end;
   if Accountid = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Accountid should not be 0' );
      Exit;
   end;
   if Accountname = '' then begin
      Resultstatus.AddItem(False , rssError , 0,  'Accountname should not be blank' );
      Exit;
   end;
   if SameText(DisplayIn, 'Allowances') and (AllowanceType = '') then begin
      Resultstatus.AddItem(False , rssError , 0,  'Allowance Type should not be blank when "Allowances" seleted for Reporting.' );
      Exit;
   end;
   Result := true;
end;


function    TAllowance.Save :Boolean ;
begin
   Result := False;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;


procedure TAllowance.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;


procedure TAllowance.DoFieldOnChange(Sender: TField);
begin
  if Self.Dataset.State =  dsInsert then exit;
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
  if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;

  if Sysutils.SameText(Sender.FieldName , 'CalcBy') then begin
    if FindInSet(GetBasedOnName(BasedOnID), 'None,Km,Items') then begin
      if CalcBy = '%' then  SendEvent(BusobjEventVal_HandleCalcByConflict,BusObjEvent_Change );
    end;
  end;
end;


Function TAllowance.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;


class function  TAllowance.GetIDField : String;
begin
   Result := 'Allowanceid'
end;

class function TAllowance.GetBusObjectTablename: string;
begin
  Result := 'tblallowances';
end;

Function  TAllowance.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;


{Property functions}
Function  TAllowance.GetDescription     :String    ; begin Result := GetStringField('Description');End;
Function  TAllowance.GetSuperinc        :Boolean   ; begin Result := GetBooleanField('Superinc');End;
Function  TAllowance.GetTaxexempt       :Boolean   ; begin Result := GetBooleanField('Taxexempt');End;
Function  TAllowance.GetPayrolltaxexempt:Boolean   ; begin Result := GetBooleanField('Payrolltaxexempt');End;
Function  TAllowance.GetWorkcoverexempt :Boolean   ; begin Result := GetBooleanField('Workcoverexempt');End;
Function  TAllowance.GetDisplayin       :String    ; begin Result := GetStringField('Displayin');End;
Function  TAllowance.GetAmount          :Double    ; begin Result := GetFloatField('Amount');End;
Function  TAllowance.GetCalcby          :String    ; begin Result := GetStringField('Calcby');End;
Function  TAllowance.GetArea            :String    ; begin Result := GetStringField('Area');End;
Function  TAllowance.GetPercentage      :Double    ; begin Result := GetFloatField('Percentage');End;
Function  TAllowance.GetBasedonid       :Integer   ; begin Result := GetIntegerField('Basedonid');End;
Function  TAllowance.GetActive          :Boolean   ; begin Result := GetBooleanField('Active');End;

function TAllowance.GetAllowanceType: string;
begin
  result := GetStringField('AllowanceType');
end;

function TAllowance.GetAllowanceCode: string;
begin
  result := GetStringField('AllowanceCode');
end;



Function  TAllowance.GetAccountid       :Integer   ; begin Result := GetIntegerField('Accountid');End;
Function  TAllowance.GetAccountname     :String    ; begin Result := GetStringField('Accountname');End;
Function  TAllowance.GetDisplayName     :String    ; begin Result := GetStringField('displayname');End;

Procedure TAllowance.SetDescription     (Const Value :String    ); begin SetStringField('Description'      , Value);End;
Procedure TAllowance.SetSuperinc        (Const Value :Boolean   ); begin SetBooleanField('Superinc'         , Value);End;
Procedure TAllowance.SetTaxexempt       (Const Value :Boolean   ); begin SetBooleanField('Taxexempt'        , Value);End;
Procedure TAllowance.SetPayrolltaxexempt(Const Value :Boolean   ); begin SetBooleanField('Payrolltaxexempt' , Value);End;
Procedure TAllowance.SetWorkcoverexempt (Const Value :Boolean   ); begin SetBooleanField('Workcoverexempt'  , Value);End;
Procedure TAllowance.SetDisplayin       (Const Value :String    ); begin SetStringField('Displayin'        , Value);End;
Procedure TAllowance.SetAmount          (Const Value :Double    ); begin SetFloatField('Amount'           , Value);End;
Procedure TAllowance.SetCalcby          (Const Value :String    ); begin SetStringField('Calcby'           , Value);End;
Procedure TAllowance.SetArea            (Const Value :String    ); begin SetStringField('Area'           , Value);End;
Procedure TAllowance.SetPercentage      (Const Value :Double    ); begin SetFloatField('Percentage'       , Value);End;
Procedure TAllowance.SetBasedonid       (Const Value :Integer   ); begin SetIntegerField('Basedonid'        , Value);End;
Procedure TAllowance.SetActive          (Const Value :Boolean   ); begin SetBooleanField('Active'           , Value);End;

procedure TAllowance.SetAllowanceType(const value: string);
begin
  SetStringField('AllowanceType', value);
end;

procedure TAllowance.SetAllowanceCode(const value: string);
begin
  SetStringField('AllowanceCode', value);
end;


Procedure TAllowance.SetAccountid       (Const Value :Integer   ); begin SetIntegerField('Accountid'        , Value);End;
Procedure TAllowance.SetAccountname     (Const Value :String    ); begin SetStringField('Accountname'      , Value);End;
Procedure TAllowance.SetDisplayName     (Const Value :String    ); begin SetStringField('displayname'      , Value);End;


initialization

RegisterClassOnce(TAllowance);


end.
