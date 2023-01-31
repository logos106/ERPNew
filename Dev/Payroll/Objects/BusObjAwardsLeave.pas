unit BusObjAwardsLeave;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   10/08/07   1.00.01   A.   Initial Version.
   }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
   TAwardLeaves = class(TMSBusObj)
   private
      fOldPeriod:string;

      Function GetAwardid                :Integer   ;
      Function GetType                   :String    ;
      Function GetAccrueafterno          :Double    ;
      Function GetAccrueafterperiod      :String    ;
      Function GetAccrueno               :Double    ;
      Function GetAccrueperiod           :String    ;
      Function GetAccruehours            :Double    ;
      Function GetMaxhours               :Double    ;
      Function GetAwardstartdate         :TDatetime ;
      Function GetAwardenddate           :TDatetime ;
      Function GetUsestartenddates       :Boolean   ;
      Function GetLeaveloading           :Double    ;
      Procedure SetAwardid                (Const Value :Integer   );
      Procedure SetType                   (Const Value :String    );
      Procedure SetAccrueafterno          (Const Value :Double    );
      Procedure SetAccrueafterperiod      (Const Value :String    );
      Procedure SetAccrueno               (Const Value :Double    );
      Procedure SetAccrueperiod           (Const Value :String    );
      Procedure SetAccruehours            (Const Value :Double    );
      Procedure SetMaxhours               (Const Value :Double    );
      Procedure SetAwardstartdate         (Const Value :TDatetime );
      Procedure SetAwardenddate           (Const Value :TDatetime );
      Procedure SetUsestartenddates       (Const Value :Boolean   );
      Procedure SetLeaveloading           (Const Value :Double    );
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
      procedure Load(Const aId: integer;const fIsReadonly:boolean =False); override;

      Property Awardid                 :Integer      Read getAwardid              Write SetAwardid          ;
      Property AwardLeaveType          :String       Read getType                 Write SetType             ;
      Property Accrueafterno           :Double       Read getAccrueafterno        Write SetAccrueafterno    ;
      Property Accrueafterperiod       :String       Read getAccrueafterperiod    Write SetAccrueafterperiod;
      Property Accrueno                :Double       Read getAccrueno             Write SetAccrueno         ;
      Property Accrueperiod            :String       Read getAccrueperiod         Write SetAccrueperiod     ;
      Property Accruehours             :Double       Read getAccruehours          Write SetAccruehours      ;
      Property Maxhours                :Double       Read getMaxhours             Write SetMaxhours         ;
      Property Awardstartdate          :TDatetime    Read getAwardstartdate       Write SetAwardstartdate   ;
      Property Awardenddate            :TDatetime    Read getAwardenddate         Write SetAwardenddate     ;
      Property Usestartenddates        :Boolean      Read getUsestartenddates     Write SetUsestartenddates ;
      Property Leaveloading            :Double       Read getLeaveloading         Write SetLeaveloading     ;
   End;


implementation


uses BusObjAwards,BusObjConst, CommonLib,AppEnvironment,Dialogs,
  CompanyPrefObj,SysUtils;


{========================================================
         TAwardLeaves
========================================================}
constructor TAwardLeaves.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   fSQL := 'SELECT * FROM tblAwardsLeave';
end;

procedure   TAwardLeaves.Load(Const aId: integer;const fIsReadonly:boolean =False);
begin
  inherited Load(aid, fisReadonly);
  fOldPeriod := AccruePeriod;
end;

destructor TAwardLeaves.Destroy;
begin
   inherited;
end;

Function  TAwardLeaves.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    if Assigned(Self.Owner) then
      AccruePeriod := 'Pay'; {default to accrue on Pay}

        if Self.Owner is TAward then
                AwardId := TAward(Self.Owner).Id;
    Result := inherited DoAfterInsert(Sender);
end;

procedure   TAwardLeaves.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node,'Awardid');
  SetPropertyFromNode(Node,'Type');
  SetPropertyFromNode(Node,'Accrueafterno');
  SetPropertyFromNode(Node,'Accrueafterperiod');
  SetPropertyFromNode(Node,'Accrueno');
  SetPropertyFromNode(Node,'Accrueperiod');
  SetPropertyFromNode(Node,'Accruehours');
  SetPropertyFromNode(Node,'Maxhours');
  SetDateTimePropertyFromNode(Node,'Awardstartdate');
  SetDateTimePropertyFromNode(Node,'Awardenddate');
  SetBooleanPropertyFromNode(Node,'Usestartenddates');
  SetPropertyFromNode(Node,'Leaveloading');
end;


procedure   TAwardLeaves.SaveToXMLNode(Const node: IXMLNode);
begin
   inherited;
      AddXMLNode(node,'Awardid' ,Awardid);
      AddXMLNode(node,'Type' ,AwardLeaveType);
      AddXMLNode(node,'Accrueafterno' ,Accrueafterno);
      AddXMLNode(node,'Accrueafterperiod' ,Accrueafterperiod);
      AddXMLNode(node,'Accrueno' ,Accrueno);
      AddXMLNode(node,'Accrueperiod' ,Accrueperiod);
      AddXMLNode(node,'Accruehours' ,Accruehours);
      AddXMLNode(node,'Maxhours' ,Maxhours);
      AddXMLNode(node,'Awardstartdate' ,Awardstartdate);
      AddXMLNode(node,'Awardenddate' ,Awardenddate);
      AddXMLNode(node,'Usestartenddates' ,Usestartenddates);
      AddXMLNode(node,'Leaveloading' ,Leaveloading);
end;


function    TAwardLeaves.ValidateData :Boolean ;
begin
   if Self.Dataset.RecordCount = 0 then begin  //don't force em to have a leave
     Result := True;
     exit;
   end;
     
   Result := False;
   Resultstatus.Clear;
   //if Awardid = 0 then begin
//      AddResult(False , rssError , BOR_AwardLeaves_Err_NoLeave,  'Award should not be blank.'  );
//      Exit;
//   end;
   if AwardLeaveType = '' then begin
      AddResult(False , rssError , BOR_AwardLeaves_Err_NoLeave,  'Type should not be blank' );
      Exit;
   end;
//   if Accrueafterno = 0  then begin
//      AddResult(False , rssError , BOR_AwardLeaves_Err_NoAccrueAfterNo,  'Accrue after number should not be blank'  );
//      Exit;
//   end;
   if Accrueafterperiod = '' then begin
      AddResult(False , rssError , BOR_AwardLeaves_Err_NoAfterPeriod,  'Accrue after period should not be blank' );
      Exit;
   end;
   if Accrueno = 0 then begin
      AddResult(False , rssError , BOR_AwardLeaves_Err_NoAccrueNo,  'Accrue number should not be 0'  );
      Exit;
   end;
   if Accrueperiod = '' then begin
      AddResult(False , rssError , BOR_AwardLeaves_Err_NoAccruePeriod,  'Accrue period should not be blank' );
      Exit;
   end;
   if Accruehours = 0 then begin
      AddResult(False , rssError , BOR_AwardLeaves_Err_NoAccrueHours,  'Accrue hours should not be 0'  );
      Exit;
   end;
   if UseStartEndDates = True then begin
     if Awardstartdate = 0 then begin
       AddResult(False , rssError , BOR_AwardLeaves_Err_NoStartDate,  'Award start date should not be blank when using dates'  );
       Exit;
     end;
     if Awardenddate = 0 then begin
       AddResult(False , rssError , BOR_AwardLeaves_Err_NoEndDate,  'Award end date should not be blank when using dates'  );
       Exit;
     end;
   end;


//   if Maxhours = 0 then begin
//      AddResult(False , rssError , 0,  'Max hours should not be 0'  );
//      Exit;
//   end;

//   if Leaveloading = 0 then begin
//      AddResult(False , rssError , 0,  'Leave loading should not be 0'  );
//      Exit;
//   end;
   Result := true;
end;

function    TAwardLeaves.Save :Boolean ;
begin
   Result := False;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;


procedure TAwardLeaves.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;


procedure TAwardLeaves.DoFieldOnChange(Sender: TField);   
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
  if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if (Sysutils.SameText(Sender.FieldName , 'AccruePeriod')) then begin
  //  dOldHoursPerPeriod := AccrueHours;
    if AccruePeriod = 'Hour' then begin
      if fOldPeriod = 'Pay' then begin


      end else if fOldPeriod = 'Hour' then begin


      end else if fOldPeriod = 'Week' then begin


      end;
    end;
    fOldPeriod := AccruePeriod;
  end;

  if (Sysutils.SameText(Sender.FieldName , 'Type')) or (Sysutils.SameText(Sender.FieldName , 'Accrueperiod'))then begin
    if TAward(Self.Owner).Payperiod = 'Weekly' then begin
      if AwardLeaveType = 'Annual Leave' then begin
        if Accrueperiod = 'Pay' then
          AccrueHours := AppEnv.CompanyPrefs.ALeaveWeeks/52 * AppEnv.CompanyPrefs.HoursPerWeek
        else if Accrueperiod = 'Hour' then
          AccrueHours := AppEnv.CompanyPrefs.ALeaveWeeks/52;
        if Accrueperiod = 'Week' then
          AccrueHours := AppEnv.CompanyPrefs.ALeaveWeeks/52 * AppEnv.CompanyPrefs.HoursPerWeek;
      //end else if AwardLeaveType = 'Sick Leave' then begin
      end else if AwardLeaveType =  Appenv.RegionalOptions.SLName  then begin
        AccrueHours := AppEnv.CompanyPrefs.SickLeaveDays/52/7  * AppEnv.CompanyPrefs.HoursPerWeek;
      end else if AwardLeaveType = 'Long Service' then begin
        if Accrueperiod = 'Pay' then
          AccrueHours := divzer(AppEnv.CompanyPrefs.LSLWeeks/52, AppEnv.CompanyPrefs.LSLCommenceYears)
        else if Accrueperiod = 'Hour' then
          AccrueHours := AppEnv.CompanyPrefs.ALeaveWeeks/52
        else if Accrueperiod = 'Week' then
          AccrueHours := divzer(AppEnv.CompanyPrefs.LSLWeeks/52, AppEnv.CompanyPrefs.LSLCommenceYears);
      end;
    end else if TAward(Self.Owner).Payperiod = 'Fortnightly' then begin
      if AwardLeaveType = 'Annual Leave' then begin
        if Accrueperiod = 'Pay' then
          AccrueHours := AppEnv.CompanyPrefs.ALeaveWeeks/52 * 2 * AppEnv.CompanyPrefs.HoursPerWeek
        else if Accrueperiod = 'Hour' then
           AccrueHours := AppEnv.CompanyPrefs.ALeaveWeeks/52 * 2
        else if Accrueperiod = 'Week' then
          AccrueHours := AppEnv.CompanyPrefs.ALeaveWeeks/52 * AppEnv.CompanyPrefs.HoursPerWeek * 2
      //end else if AwardLeaveType = 'Sick Leave' then begin
      end else if AwardLeaveType =  Appenv.RegionalOptions.SLName  then begin
        if Accrueperiod = 'Pay' then
          AccrueHours := AppEnv.CompanyPrefs.SickLeaveDays/52/7 * 2 * AppEnv.CompanyPrefs.HoursPerWeek
        else if Accrueperiod = 'Hour' then
           AccrueHours := AppEnv.CompanyPrefs.SickLeaveDays/52/7 * 2
        else if Accrueperiod = 'Week' then
          AccrueHours := AppEnv.CompanyPrefs.SickLeaveDays/52/7 * 2 * AppEnv.CompanyPrefs.HoursPerWeek;
      end else if AwardLeaveType = 'Long Service' then
       if Accrueperiod = 'Pay' then
         AccrueHours := divzer(AppEnv.CompanyPrefs.LSLWeeks/52 * 2, AppEnv.CompanyPrefs.LSLCommenceYears)
       else if Accrueperiod = 'Hour' then
         AccrueHours := divzer(divzer(AppEnv.CompanyPrefs.LSLWeeks/52 * 2, AppEnv.CompanyPrefs.LSLCommenceYears),AppEnv.CompanyPrefs.HoursPerWeek)
       else if Accrueperiod = 'Week' then
          AccrueHours := divzer(AppEnv.CompanyPrefs.LSLWeeks/52 * 2, AppEnv.CompanyPrefs.LSLCommenceYears);
    end else if TAward(Self.Owner).Payperiod = 'Monthly' then begin
      if AwardLeaveType = 'Annual Leave' then
        if Accrueperiod = 'Pay' then
          AccrueHours := AppEnv.CompanyPrefs.ALeaveWeeks/52 * AppEnv.CompanyPrefs.HoursPerWeek * 4.3333
        else if Accrueperiod = 'Hour' then
          AccrueHours := AppEnv.CompanyPrefs.ALeaveWeeks/52 *  4.3333
        else if Accrueperiod = 'Week' then
          AccrueHours := AppEnv.CompanyPrefs.ALeaveWeeks/52 * AppEnv.CompanyPrefs.HoursPerWeek * 4.3333
      //else if AwardLeaveType = 'Sick Leave' then
      else if AwardLeaveType =  Appenv.RegionalOptions.SLName  then
        if Accrueperiod = 'Pay' then
          AccrueHours := AppEnv.CompanyPrefs.SickLeaveDays/52/7 * AppEnv.CompanyPrefs.HoursPerWeek * 4.3333
        else if Accrueperiod = 'Hour' then
          AccrueHours := AppEnv.CompanyPrefs.SickLeaveDays/52/7  * 4.3333
        else if Accrueperiod = 'Week' then
          AccrueHours := AppEnv.CompanyPrefs.SickLeaveDays/52/7 * AppEnv.CompanyPrefs.HoursPerWeek * 4.3333
      else if AwardLeaveType = 'Long Service' then
       if Accrueperiod = 'Pay' then
         AccrueHours := divzer(AppEnv.CompanyPrefs.LSLWeeks/52, AppEnv.CompanyPrefs.LSLCommenceYears)* 4.3333
       else if Accrueperiod = 'Hour' then
         AccrueHours := divzer(AppEnv.CompanyPrefs.LSLWeeks/52, AppEnv.CompanyPrefs.LSLCommenceYears)* 4.3333
       else if Accrueperiod = 'Week' then
         AccrueHours := divzer(AppEnv.CompanyPrefs.LSLWeeks/52, AppEnv.CompanyPrefs.LSLCommenceYears)* 4.3333;
    end else if TAward(Self.Owner).Payperiod = 'Bi-Monthly' then begin
      if AwardLeaveType = 'Annual Leave' then
        if Accrueperiod = 'Pay' then
          AccrueHours := AppEnv.CompanyPrefs.ALeaveWeeks/52 * AppEnv.CompanyPrefs.HoursPerWeek * 2.667
        else if Accrueperiod = 'Hour' then
          AccrueHours := AppEnv.CompanyPrefs.ALeaveWeeks/52  * 2.667
        else if Accrueperiod = 'Week' then
          AccrueHours := AppEnv.CompanyPrefs.ALeaveWeeks/52 * AppEnv.CompanyPrefs.HoursPerWeek * 2.667
      //else if AwardLeaveType = 'Sick Leave' then
      else if AwardLeaveType =  Appenv.RegionalOptions.SLName  then
        AccrueHours := AppEnv.CompanyPrefs.SickLeaveDays/52/7 * AppEnv.CompanyPrefs.HoursPerWeek * 2.667
      else if AwardLeaveType = 'Long Service' then
       if Accrueperiod = 'Pay' then
         AccrueHours := divzer(AppEnv.CompanyPrefs.LSLWeeks/52, AppEnv.CompanyPrefs.LSLCommenceYears) * 2.667
       else if Accrueperiod = 'Hour' then
         AccrueHours := divzer(AppEnv.CompanyPrefs.LSLWeeks/52, AppEnv.CompanyPrefs.LSLCommenceYears)* 4.3333
       else if Accrueperiod = 'Week' then
         AccrueHours := divzer(AppEnv.CompanyPrefs.LSLWeeks/52, AppEnv.CompanyPrefs.LSLCommenceYears) * 2.667;
    end;
  end;
end;


Function TAwardLeaves.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;


class function  TAwardLeaves.GetIDField : String;
begin
   Result := 'Leaveid'
end;

class function TAwardLeaves.GetBusObjectTablename: string;
begin
  Result := 'tblawardsleave';
end;


Function  TAwardLeaves.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;


{Property functions}
Function  TAwardLeaves.GetAwardid          :Integer   ; begin Result := GetIntegerField('Awardid');End;
Function  TAwardLeaves.GetType             :String    ; begin Result := GetStringField('Type');End;
Function  TAwardLeaves.GetAccrueafterno    :Double    ; begin Result := GetFloatField('Accrueafterno');End;
Function  TAwardLeaves.GetAccrueafterperiod:String    ; begin Result := GetStringField('Accrueafterperiod');End;
Function  TAwardLeaves.GetAccrueno         :Double    ; begin Result := GetFloatField('Accrueno');End;
Function  TAwardLeaves.GetAccrueperiod     :String    ; begin Result := GetStringField('Accrueperiod');End;
Function  TAwardLeaves.GetAccruehours      :Double    ; begin Result := GetFloatField('Accruehours');End;
Function  TAwardLeaves.GetMaxhours         :Double    ; begin Result := GetFloatField('Maxhours');End;
Function  TAwardLeaves.GetAwardstartdate   :TDatetime ; begin Result := GetDatetimeField('Awardstartdate');End;
Function  TAwardLeaves.GetAwardenddate     :TDatetime ; begin Result := GetDatetimeField('Awardenddate');End;
Function  TAwardLeaves.GetUsestartenddates :Boolean   ; begin Result := GetBooleanField('Usestartenddates');End;
Function  TAwardLeaves.GetLeaveloading     :Double    ; begin Result := GetFloatField('Leaveloading');End;
Procedure TAwardLeaves.SetAwardid          (Const Value :Integer   ); begin SetIntegerField('Awardid'           , Value);End;
Procedure TAwardLeaves.SetType             (Const Value :String    ); begin SetStringField('Type'              , Value);End;
Procedure TAwardLeaves.SetAccrueafterno    (Const Value :Double    ); begin SetFloatField('Accrueafterno'     , Value);End;
Procedure TAwardLeaves.SetAccrueafterperiod(Const Value :String    ); begin SetStringField('Accrueafterperiod' , Value);End;
Procedure TAwardLeaves.SetAccrueno         (Const Value :Double    ); begin SetFloatField('Accrueno'          , Value);End;
Procedure TAwardLeaves.SetAccrueperiod     (Const Value :String    ); begin SetStringField('Accrueperiod'      , Value);End;
Procedure TAwardLeaves.SetAccruehours      (Const Value :Double    ); begin SetFloatField('Accruehours'       , Value);End;
Procedure TAwardLeaves.SetMaxhours         (Const Value :Double    ); begin SetFloatField('Maxhours'          , Value);End;
Procedure TAwardLeaves.SetAwardstartdate   (Const Value :TDatetime ); begin SetDatetimeField('Awardstartdate'    , Value);End;
Procedure TAwardLeaves.SetAwardenddate     (Const Value :TDatetime ); begin SetDatetimeField('Awardenddate'      , Value);End;
Procedure TAwardLeaves.SetUsestartenddates (Const Value :Boolean   ); begin SetBooleanField('Usestartenddates'  , Value);End;
Procedure TAwardLeaves.SetLeaveloading     (Const Value :Double    ); begin SetFloatField('Leaveloading'      , Value);End;


initialization
RegisterClassOnce(TAwardLeaves);


end.

