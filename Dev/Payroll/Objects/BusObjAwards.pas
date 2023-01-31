unit BusObjAwards;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   10/08/07   1.00.01   A.   Initial Version.
   }
   {   BusObjAwards
            |____BusObjAwardLeaves
            |____BusObjAwardShifts
            |____BusObjAwardClassificationDetail
            |           |____BusObjClassificationAllowances
            |           |____BusObjClassificationDeductions
            |           |____BusObjClassificationExtraPayrates


   }

interface


uses BusObjBase, DB, Classes, BusObjAwardShifts,
  BusObjAwardClassificationDetail,MyAccess,ERPdbComponents,
  BusObjAwardsLeave, XMLDoc, XMLIntf;
                                               
type
   TAward = class(TMSBusObj)
   private
      (*fAwardLeaves:TAwardLeaves;
      fAwardShifts:Tawardshifts;
      fClassificationDetails:Tawardclassificationdetails;*)

      Function GetAwardname                     :String    ;
      Function GetClassID                       :Integer   ;
      Function GetPayperiod                     :String    ;
      Function GetSupertype                     :String    ;
      Function GetArea                          :String    ;
      Function GetSupervalue                    :Double    ;
      Function GetAnnualleaveloading            :Double    ;
      Function GetActive                        :Boolean   ;
      Function GetMealbreakhours                :Double    ;
      Function GetMealbreakthreshold            :Double    ;
      Function GetPaysuperonleaveloading        :Boolean   ;
      Function GetUsecompanysuperthreshold      :Boolean   ;
      Function GetSuperthresholdamount          :Double    ;
      Function GetSickleavedaysthreshold        :Integer   ;
      Function getawardshifts                   :Tawardshifts;
      Function getAwardLeaves                   :TAwardLeaves;
      Function GetAwardWorkersCompRate          :Double;
      Function getawardclassificationdetails    :Tawardclassificationdetails;
      Procedure SetAwardname                     (Const Value :String    );
      Procedure setClassID                       (Const Value :Integer   );
      Procedure SetPayperiod                     (Const Value :String    );
      Procedure SetSupertype                     (Const Value :String    );
      Procedure SetArea                          (Const Value :String    );
      Procedure SetSupervalue                    (Const Value :Double    );
      Procedure SetAnnualleaveloading            (Const Value :Double    );
      Procedure SetActive                        (Const Value :Boolean   );
      Procedure SetMealbreakhours                (Const Value :Double    );
      Procedure SetMealbreakthreshold            (Const Value :Double    );
      Procedure SetPaysuperonleaveloading        (Const Value :Boolean   );
      Procedure SetUsecompanysuperthreshold      (Const Value :Boolean   );
      Procedure SetSuperthresholdamount          (Const Value :Double    );
      Procedure SetSickleavedaysthreshold        (Const Value :Integer   );
      Procedure SetAwardWorkersCompRate          (Const Value :Double    );  
   Protected
      procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);   Override;
      procedure DoFieldOnChange(Sender: TField);                           Override;
      Function  GetSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
      Function ExportsubClasses(Const node: IXMLNode):Boolean; Override;
   Public
      class function GetIDField: string; override;
      class function GetBusObjectTablename: string; Override;
      Constructor Create(AOwner: TComponent); overload;override;
      Constructor Create(AOwner: TComponent;PassedConnection:TERPConnection); reintroduce;overload;
      Destructor   Destroy;                                                override;
      Procedure    LoadFromXMLNode(Const node: IXMLNode);                  override;
      Procedure    SaveToXMLNode(Const node: IXMLNode);                    override;
      Function     ValidateData :Boolean ;                                 Override;
      Function     Save :Boolean ;                                         Override;
      procedure Load(Const aId: integer;const fIsReadonly:boolean =False);override;

      Property Awardname                      :String       Read getAwardname                   Write SetAwardname               ;
      Property Classid                        :Integer      Read GetClassID                     Write setClassID                 ;
      Property Payperiod                      :String       Read getPayperiod                   Write SetPayperiod               ;
      Property Supertype                      :String       Read getSupertype                   Write SetSupertype               ;
      Property Area                           :String       Read getArea                        Write SetArea                    ;
      Property Supervalue                     :Double       Read getSupervalue                  Write SetSupervalue              ;
      Property Annualleaveloading             :Double       Read getAnnualleaveloading          Write SetAnnualleaveloading      ;
      Property Active                         :Boolean      Read getActive                      Write SetActive                  ;
      Property Mealbreakhours                 :Double       Read getMealbreakhours              Write SetMealbreakhours          ;
      Property Mealbreakthreshold             :Double       Read getMealbreakthreshold          Write SetMealbreakthreshold      ;
      Property Paysuperonleaveloading         :Boolean      Read getPaysuperonleaveloading      Write SetPaysuperonleaveloading  ;
      Property Usecompanysuperthreshold       :Boolean      Read getUsecompanysuperthreshold    Write SetUsecompanysuperthreshold;
      Property Superthresholdamount           :Double       Read getSuperthresholdamount        Write SetSuperthresholdamount    ;
      Property Sickleavedaysthreshold         :Integer      Read getSickleavedaysthreshold      Write SetSickleavedaysthreshold  ;
      Property AwardLeaves                    :TAwardLeaves Read getAwardLeaves;//fAwardLeaves                   Write fAwardLeaves;
      Property AwardShifts                    :Tawardshifts Read getAwardShifts;//fAwardShifts                   Write fAwardShifts;
      Property AwardClassifications           :Tawardclassificationdetails Read getawardclassificationdetails;//fClassificationDetails Write fClassificationDetails;
      Property AwardWorkersCompRate           :double Read getawardWorkersCompRate     write SetAwardWorkersCompRate;
   End;

implementation

uses SysUtils,AppEnvironment,BusObjConst,tcTypes, CommonLib;

{========================================================
         TAward
========================================================}
constructor TAward.Create(AOwner: TComponent;PassedConnection:TERPConnection);
begin
   inherited Create(AOwner);
   Connection  := TMyDacDataConnection.Create(Self);
   TMyDacDataConnection(Connection).MydacConnection  := PassedConnection;
end;

constructor TAward.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   fSQL := 'SELECT * FROM tblawards';
   (*fAwardLeaves            := TAwardLeaves.Create(Self);
   fAwardLeaves.Connection := Self.Connection;
   fAwardShifts            := Tawardshifts.Create(Self);
   fAwardShifts.Connection := Self.Connection;
   fClassificationDetails  := Tawardclassificationdetails.Create(Self,TERPConnection(connection.Connection)); //needs connection for sub busobjs*)
end;

destructor TAward.Destroy;
begin
   inherited;
end;

procedure   TAward.Load(Const aId: integer;const fIsReadonly:boolean =False);
begin
  inherited Load(aId , fIsReadonly);
(*  fAwardLeaves.LoadSelect('AwardID = ' + IntToStr(aID));
  fAwardShifts.LoadSelect('AwardID = ' + IntToStr(aID));
  fClassificationDetails.LoadSelect('AwardID = ' + IntToStr(aID));*)
end;

procedure   TAward.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node,'Awardname');
  SetPropertyFromNode(Node,'Classid');
  SetPropertyFromNode(Node,'Payperiod');
  SetPropertyFromNode(Node,'Supertype');
  SetPropertyFromNode(Node,'Area');
  SetPropertyFromNode(Node,'Supervalue');
  SetPropertyFromNode(Node,'Annualleaveloading');
  SetBooleanPropertyFromNode(Node,'Active');
  SetPropertyFromNode(Node,'Mealbreakhours');
  SetPropertyFromNode(Node,'Mealbreakthreshold');
  SetBooleanPropertyFromNode(Node,'Paysuperonleaveloading');
  SetBooleanPropertyFromNode(Node,'Usecompanysuperthreshold');
  SetPropertyFromNode(Node,'Superthresholdamount');
  SetPropertyFromNode(Node,'Sickleavedaysthreshold');
  SetPropertyFromNode(Node,'WorkersCompRate');

end;


procedure   TAward.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Awardname' ,Awardname);
  AddXMLNode(node,'Classid' ,Classid);
  AddXMLNode(node,'Payperiod' ,Payperiod);
  AddXMLNode(node,'Supertype' ,Supertype);
  AddXMLNode(node,'Area' ,Area);
  AddXMLNode(node,'Supervalue' ,Supervalue);
  AddXMLNode(node,'Annualleaveloading' ,Annualleaveloading);
  AddXMLNode(node,'Active' ,Active);
  AddXMLNode(node,'Mealbreakhours' ,Mealbreakhours);
  AddXMLNode(node,'Mealbreakthreshold' ,Mealbreakthreshold);
  AddXMLNode(node,'Paysuperonleaveloading' ,Paysuperonleaveloading);
  AddXMLNode(node,'Usecompanysuperthreshold' ,Usecompanysuperthreshold);
  AddXMLNode(node,'Superthresholdamount' ,Superthresholdamount);
  AddXMLNode(node,'Sickleavedaysthreshold' ,Sickleavedaysthreshold);
  AddXMLNode(node,'WorkersCompRate' ,AwardWorkersCompRate);


    {sub properties should be created only when exporting}
  if not SavingXMLTofile then exit;
  ExportsubClasses(Node);
end;

Function TAward.ExportsubClasses(Const node: IXMLNode):Boolean;
begin
    self.AwardLeaves.XMLPropertyNode := node.AddChild('AwardLeaves');
    self.AwardLeaves.XMLPropertyName:= 'AwardLeaves';
    self.AwardLeaves.IterateRecords(GetPropertyXMLCallback);

    self.AwardShifts.XMLPropertyNode := node.AddChild('AwardShifts');
    self.AwardShifts.XMLPropertyName:= 'AwardShifts';
    self.AwardShifts.IterateRecords(GetPropertyXMLCallback);

    self.AwardClassifications.XMLPropertyNode := node.AddChild('AwardClassifications');
    self.AwardClassifications.XMLPropertyName:= 'AwardClassifications';
    self.AwardClassifications.IterateRecords(GetPropertyXMLCallback);

    Result := True;
end;


function    TAward.ValidateData :Boolean ;
begin
   Result := False;
   Resultstatus.Clear;
   if Awardname = '' then begin
      Resultstatus.AddItem(False , rssError , BOR_Award_Err_NoDescription,  'Award name should not be blank' );
      Exit;
   end;
   if Classid = 0 then begin
      Resultstatus.AddItem(False , rssError , BOR_Award_Err_NoDepartment,  'Department name should not be blank' );
      Exit;
   end;
   if Payperiod = '' then begin
      Resultstatus.AddItem(False , rssError , BOR_Award_Err_NoPayPeriod,  'Pay period should not be blank' );
      Exit;
   end;
   if Supertype = '' then begin
      Resultstatus.AddItem(False , rssError , BOR_Award_Err_NoSuperType,  'Supertype should not be blank' );
      Exit;
   end;
   if Supervalue = 0 then begin
      Resultstatus.AddItem(False , rssError , BOR_Award_Err_NoSuperValue,  'Super value should not be 0' );
      Exit;
   end;
   if Mealbreakhours = 0 then begin
      Resultstatus.AddItem(False , rssError , BOR_Award_Err_NoMealBreakHrs,  'Meal break hours should not be 0' );
      Exit;
   end;
   if Mealbreakthreshold = 0 then begin
      Resultstatus.AddItem(False , rssError , BOR_Award_Err_NoMealBreakThreshold ,  'Meal break threshold should not be 0');
      Exit;
   end;
//   if Superthresholdamount = 0 then begin
//      Resultstatus.AddItem(False , rssError , 0,  'Superthresholdamount should not be 0' , False );
//      Exit;
//   end;
 //  if Sickleavedaysthreshold = 0 then begin
//      Resultstatus.AddItem(False , rssError , BOR_Award_Err_NoSickLeaveThreshold,  'Sick leave days threshold should not be 0'  );
//      Exit;
//   end;
   Result := true;
end;

function    TAward.Save :Boolean ;
begin
   Result := False;
   if not AwardLeaves.Save then exit;
   if not AwardShifts.Save then exit;
   if not AwardClassifications.Save then exit;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;


procedure TAward.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;


procedure TAward.DoFieldOnChange(Sender: TField);
begin
   inherited;
   if not (Self.Dataset.State in [dsEdit, dsInsert]) then Exit;

   if Sysutils.SameText(Sender.FieldName , 'SuperType') then begin
    // if SuperType = 'Percentage' then begin
//       //tblAwardsSuperValue.DisplayFormat := '###0.00%';
//
//     end;
   end;
   if Sysutils.SameText(Sender.FieldName , 'AwardName') then begin
     Self.PostDB;  
   end;
end;


Function TAward.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;


class function  TAward.GetIDField : String;
begin
   Result := 'Awardid'
end;

class function TAward.GetBusObjectTablename: string;
begin
  Result := 'tblawards';
end;

Function  TAward.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;
Function TAward.getawardshifts:Tawardshifts;
begin
    Result := Tawardshifts(getContainerComponent(Tawardshifts, 'AwardID = ' + IntToStr(ID)));
end;





Function TAward.getAwardLeaves :TAwardLeaves;
begin
    Result := TAwardLeaves(getContainerComponent(TAwardLeaves, 'AwardID = ' + IntToStr(ID)));
end;
Function TAward.getawardclassificationdetails :Tawardclassificationdetails;
begin
    Result := Tawardclassificationdetails(getContainerComponent(Tawardclassificationdetails, 'AwardID = ' + IntToStr(ID)));
end;

{Property functions}
Function  TAward.GetAwardname               :String    ; begin Result := GetStringField('Awardname');End;
Function  TAward.GetClassID                 :Integer   ; begin Result := GetIntegerField('Classid');End;
Function  TAward.GetPayperiod               :String    ; begin Result := GetStringField('Payperiod');End;
Function  TAward.GetSupertype               :String    ; begin Result := GetStringField('Supertype');End;
Function  TAward.GetArea                    :String    ; begin Result := GetStringField('Area');End;
Function  TAward.GetSupervalue              :Double    ; begin Result := GetFloatField('Supervalue');End;
Function  TAward.GetAnnualleaveloading      :Double    ; begin Result := GetFloatField('Annualleaveloading');End;
Function  TAward.GetActive                  :Boolean   ; begin Result := GetBooleanField('Active');End;
Function  TAward.GetMealbreakhours          :Double    ; begin Result := GetFloatField('Mealbreakhours');End;
Function  TAward.GetMealbreakthreshold      :Double    ; begin Result := GetFloatField('Mealbreakthreshold');End;
Function  TAward.GetPaysuperonleaveloading  :Boolean   ; begin Result := GetBooleanField('Paysuperonleaveloading');End;
Function  TAward.GetUsecompanysuperthreshold:Boolean   ; begin Result := GetBooleanField('Usecompanysuperthreshold');End;
Function  TAward.GetSuperthresholdamount    :Double    ; begin Result := GetFloatField('Superthresholdamount');End;
Function  TAward.GetSickleavedaysthreshold  :Integer   ; begin Result := GetIntegerField('Sickleavedaysthreshold');End;

Function  TAward.GetAwardWorkersCompRate    :Double    ; begin Result := GetFloatField('WorkersCompRate');End;

Procedure TAward.SetAwardname               (Const Value :String    ); begin SetStringField('Awardname'                , Value);End;
Procedure TAward.setClassID                 (Const Value :Integer   ); begin SetIntegerField('Classid'                  , Value);End;
Procedure TAward.SetPayperiod               (Const Value :String    ); begin SetStringField('Payperiod'                , Value);End;
Procedure TAward.SetSupertype               (Const Value :String    ); begin SetStringField('Supertype'                , Value);End;
Procedure TAward.SetArea                    (Const Value :String    ); begin SetStringField('Area'                    , Value);End;
Procedure TAward.SetSupervalue              (Const Value :Double    ); begin SetFloatField('Supervalue'               , Value);End;
Procedure TAward.SetAnnualleaveloading      (Const Value :Double    ); begin SetFloatField('Annualleaveloading'       , Value);End;
Procedure TAward.SetActive                  (Const Value :Boolean   ); begin SetBooleanField('Active'                   , Value);End;
Procedure TAward.SetMealbreakhours          (Const Value :Double    ); begin SetFloatField('Mealbreakhours'           , Value);End;
Procedure TAward.SetMealbreakthreshold      (Const Value :Double    ); begin SetFloatField('Mealbreakthreshold'       , Value);End;
Procedure TAward.SetPaysuperonleaveloading  (Const Value :Boolean   ); begin SetBooleanField('Paysuperonleaveloading'   , Value);End;
Procedure TAward.SetUsecompanysuperthreshold(Const Value :Boolean   ); begin SetBooleanField('Usecompanysuperthreshold' , Value);End;
Procedure TAward.SetSuperthresholdamount    (Const Value :Double    ); begin SetFloatField('Superthresholdamount'     , Value);End;
Procedure TAward.SetSickleavedaysthreshold  (Const Value :Integer   ); begin SetIntegerField('Sickleavedaysthreshold'   , Value);End;
Procedure TAward.SetAwardWorkersCompRate    (Const Value :Double    ); begin SetFloatField('WorkersCompRate'               , Value);End;

initialization
RegisterClassOnce(TAward);


end.



