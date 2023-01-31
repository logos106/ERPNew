unit BusObjfringeBenefitsTax;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   23/07/07   1.00.01   A.   Initial Version.
   }


interface


uses BusObjBase, DB, Classes, BusObjBenefitsBase, XMLDoc, XMLIntf;


type
   TFBT = class(TBenefitsBase)
   private
      Function GetEmployeeid         :Integer   ;
      Function GetYearending         :TDatetime ;
      Function GetNotes              :String    ;
      Function GetAmount             :Double    ;
      Function GetFbtreportable      :Double    ;
      Function GetClassID            :Integer   ;
      Function GetClassname          :String    ;
      Function GetType               :Integer   ;
      Procedure SetEmployeeid         (Const Value :Integer   );
      Procedure SetYearending         (Const Value :TDatetime );
      Procedure SetNotes              (Const Value :String    );
      Procedure SetAmount             (Const Value :Double    );
      Procedure SetFbtreportable      (Const Value :Double    );
      Procedure setClassID            (Const Value :Integer   );
      Procedure SetClassname          (Const Value :String    );
      Procedure SetType               (Const Value :Integer   );
   Protected
      procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);   Override;
      procedure DoFieldOnChange(Sender: TField);                           Override;
      Function  GetSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
      Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean;            Override;
   Public
      class function GetIDField: string; override;
      class function GetBusObjectTablename: string; Override;
      Constructor  Create(AOwner: TComponent);                             override;
      Destructor   Destroy;                                                override;
      Procedure    LoadFromXMLNode(Const node: IXMLNode);                  override;
      Procedure    SaveToXMLNode(Const node: IXMLNode);                    override;
      Function     ValidateData :Boolean ;                                 Override;
      Function     Save :Boolean ;                                         Override;
      function     ValidateFBTBenefits :Boolean ;



      Property Employeeid          :Integer      Read getEmployeeid       Write SetEmployeeid   ;
      Property Yearending          :TDatetime    Read getYearending       Write SetYearending   ;
      Property Notes               :String       Read getNotes            Write SetNotes        ;
      Property Amount              :Double       Read getAmount           Write SetAmount       ;
      Property Fbtreportable       :Double       Read getFbtreportable    Write SetFbtreportable;
      Property Classid             :Integer      Read GetClassID          Write setClassID      ;
      Property DepartmentName      :String       Read getClassname        Write SetClassname    ;
      Property FBType              :Integer      Read getType             Write SetType         ;
   End;


implementation


uses BusObjEmployeePay,SysUtils,Variants,AppEnvironment,DnMLib,
  BusObjConst, CommonLib;


{========================================================
         TFBT
========================================================}
constructor TFBT.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   fSQL := 'SELECT * FROM tblfbt';
end;


  
destructor TFBT.Destroy;
begin
   inherited;
end;

Function  TFBT.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    if Assigned(Self.Owner) then
        if Self.Owner is TEmployeePay then begin
          EmployeeId := Temployeepay(Self.Owner).EmployeePaySettings.Employeeid;
          DepartmentName := Temployeepay(Self.Owner).EmployeeDetails.Defaultclassname;
        end;
    Result := inherited DoAfterInsert(Sender);            
end;

procedure   TFBT.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node,'Employeeid');
  SetDateTimePropertyFromNode(Node,'Yearending');
  SetPropertyFromNode(Node,'Notes');
  SetPropertyFromNode(Node,'Amount');
  SetPropertyFromNode(Node,'Fbtreportable');
  SetPropertyFromNode(Node,'Classid');
  SetPropertyFromNode(Node,'DepartmentName');
  SetPropertyFromNode(Node,'FBType');
end;


procedure   TFBT.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Employeeid' ,Employeeid);
  AddXMLNode(node,'Yearending' ,Yearending);
  AddXMLNode(node,'Notes' ,Notes);
  AddXMLNode(node,'Amount' ,Amount);
  AddXMLNode(node,'Fbtreportable' ,Fbtreportable);
  AddXMLNode(node,'Classid' ,Classid);
  AddXMLNode(node,'DepartmentName' ,DepartmentName);
  AddXMLNode(node,'FBType' ,FBType);
end;



function    TFBT.ValidateFBTBenefits :Boolean ;
begin
  if Self.Dataset.RecordCount = 0 then begin //Don't force them to have an Fringe benefit
     Result := True;
     exit;
   end;

   Result := False;
   // they have a benefit so validate it.
   if Yearending = 0 then begin
      Resultstatus.AddItem(False , rssError , BOR_EmployeePay_Err_FBTNoYearEnding,  'Year ending should not be blank' );
      self.SendEvent(IntToStr(BOR_EmployeePay_Err_FBTNoYearEnding),BusobjEventVal_FailedFringe_BenefitsValidateData);
      Exit;
   end;
   if Amount = 0 then begin
      Resultstatus.AddItem(False , rssError , BOR_EmployeePay_Err_FBTNoAmount,  'Amount should not be 0' );
      self.SendEvent(IntToStr(BOR_EmployeePay_Err_FBTNoAmount),BusobjEventVal_FailedFringe_BenefitsValidateData);
      Exit;
   end;
   if DepartmentName = '' then begin
      Resultstatus.AddItem(False , rssError , BOR_EmployeePay_Err_FBTNoDepartment,  'Department name should not be blank' );
      self.SendEvent(IntToStr(BOR_EmployeePay_Err_FBTNoDepartment),BusobjEventVal_FailedFringe_BenefitsValidateData);
      Exit;
   end;

   Result := True;
end;

function    TFBT.ValidateData :Boolean ;
begin
   Result := False;
   Resultstatus.Clear;
   if Employeeid = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Employeeid should not be 0' , true );
      Exit;
   end;
   if Yearending = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Yearending should not be blank' , true );
      Exit;
   end;
   if Notes = '' then begin
      Resultstatus.AddItem(False , rssError , 0,  'Notes should not be blank' , true );
      Exit;
   end;
   if Amount = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Amount should not be 0' , true );
      Exit;
   end;
   if Fbtreportable = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Fbtreportable should not be 0' , true );
      Exit;
   end;
   if Classid = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Classid should not be 0' , true );
      Exit;
   end;
   if DepartmentName = '' then begin
      Resultstatus.AddItem(False , rssError , 0,  'Department name should not be blank' , true );
      Exit;
   end;
   if FBType = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'FBType should not be 0' , true );
      Exit;
   end;
   Result := true;
end;


function    TFBT.Save :Boolean ;
begin
   Result := False;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;


procedure TFBT.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;

procedure TFBT.DoFieldOnChange(Sender: TField);
var
  dAmount, dBenefit,dGrossUpRate: double;
begin
  inherited;
  if (Sysutils.SameText(Sender.FieldName , 'Amount')) or (Sysutils.SameText(Sender.FieldName , 'FBType'))
  then begin
    if VarIsNull(Amount) then begin
      dBenefit := 0;
    end else begin
      dBenefit := Amount;
    end;
    // Ensure that the FBT Types are valid.
    if FBType < 1 then begin
      FBType := 1;
    end;
    if FBType > 2 then begin
      FBType := 2;
    end;
    dGrossUpRate := 0;

    case FBtype of
      1:
        begin
          dGrossUpRate :=  divzer((AppEnv.CompanyPrefs.FBTTaxRate + (100 * GetTaxRate('GST'))),(1 - (AppEnv.CompanyPrefs.FBTTaxRate/100)) * (1 + GetTaxRate('GST')) * AppEnv.CompanyPrefs.FBTTaxRate);
        end;
      2:
        begin
          dGrossUpRate := 1/(1 - (AppEnv.CompanyPrefs.FBTTaxRate/100));
        end;
    end;
    dAmount := dGrossUpRate * dBenefit;
    FBTReportable := dAmount;
  end;
end;
          
Function TFBT.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;


class function  TFBT.GetIDField : String;
begin
   Result := 'Fbtid'
end;
class function TFBT.GetBusObjectTablename: string;
begin
  Result := 'tblfbt';
end;

Function  TFBT.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;


{Property functions}
Function  TFBT.GetEmployeeid   :Integer   ; begin Result := GetIntegerField('Employeeid');End;
Function  TFBT.GetYearending   :TDatetime ; begin Result := GetDatetimeField('Yearending');End;
Function  TFBT.GetNotes        :String    ; begin Result := GetStringField('Notes');End;
Function  TFBT.GetAmount       :Double    ; begin Result := GetFloatField('Amount');End;
Function  TFBT.GetFbtreportable:Double    ; begin Result := GetFloatField('Fbtreportable');End;
Function  TFBT.GetClassID      :Integer   ; begin Result := GetIntegerField('Classid');End;
Function  TFBT.GetClassname    :String    ; begin Result := GetStringField('Classname');End;
Function  TFBT.GetType         :Integer   ; begin Result := GetIntegerField('Type');End;
Procedure TFBT.SetEmployeeid   (Const Value :Integer   ); begin SetIntegerField('Employeeid'    , Value);End;
Procedure TFBT.SetYearending   (Const Value :TDatetime ); begin SetDatetimeField('Yearending'    , Value);End;
Procedure TFBT.SetNotes        (Const Value :String    ); begin SetStringField('Notes'         , Value);End;
Procedure TFBT.SetAmount       (Const Value :Double    ); begin SetFloatField('Amount'        , Value);End;
Procedure TFBT.SetFbtreportable(Const Value :Double    ); begin SetFloatField('Fbtreportable' , Value);End;
Procedure TFBT.setClassID      (Const Value :Integer   ); begin SetIntegerField('Classid'       , Value);End;
Procedure TFBT.SetClassname    (Const Value :String    ); begin SetStringField('Classname'     , Value);End;
Procedure TFBT.SetType         (Const Value :Integer   ); begin SetIntegerField('Type'          , Value);End;


initialization
RegisterClassOnce(TFBT);


end.
