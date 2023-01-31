unit BusObjDeductions;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   04/07/07   1.00.01      Initial Version.
   }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
   TDeduction = class(TMSBusObj)

   private
      Function GetDescription      :String    ;
      Function GetTaxexempt         :Boolean   ;
      Function GetTaxexemptFederal  :Boolean   ;
      Function GetTaxexemptState    :Boolean   ;
      Function GetTaxexemptSocial   :Boolean   ;
      Function GetTaxexemptMedicare :Boolean   ;
      Function GetIsWorkPlacegiving:Boolean   ;
      Function GetUnionfees        :Boolean   ;
      Function GetDisplayin        :String    ;
      Function GetAmount           :Double    ;
      Function GetCalcby           :String   ;
      Function GetArea             :String   ;
      Function GetPercentage       :Double    ;
      Function GetBasedonid        :Integer   ;
      Function GetBox12CodeId      :Integer   ;
      Function GetActive           :Boolean   ;
      Function GetAccountid        :Integer   ;
      Function GetAccountname      :String    ;
      Function GetDType            :String    ;
      Function GetSuperInc         :Boolean   ;
      Function GetWorkCover        :Boolean   ;

      Procedure SetDescription      (Const Value :String    );
      Procedure SetTaxexempt        (Const Value :Boolean   );
      Procedure SetTaxexemptFederal  (Const Value :Boolean   );
      Procedure SetTaxexemptState    (Const Value :Boolean   );
      Procedure SetTaxexemptSocial   (Const Value :Boolean   );
      Procedure SetTaxexemptMedicare (Const Value :Boolean   );
      Procedure SetIsWorkPlacegiving(Const Value :Boolean   );
      Procedure SetUnionfees        (Const Value :Boolean   );
      Procedure SetDisplayin        (Const Value :String    );
      Procedure SetAmount           (Const Value :Double    );
      Procedure SetCalcby           (Const Value :String    );
      Procedure SetArea             (Const Value :String    );
      Procedure SetPercentage       (Const Value :Double    );
      Procedure SetBasedonid        (Const Value :Integer   );
      Procedure SetBox12CodeId      (Const Value :Integer   );
      Procedure SetActive           (Const Value :Boolean   );
      Procedure SetAccountid        (Const Value :Integer   );
      Procedure SetAccountname      (Const Value :String    );
      Procedure SetDType            (Const Value :String    );
      Procedure SetSuperInc         (Const Value :Boolean   );
      Procedure SetWorkCover        (Const Value :Boolean   );

   Protected
      procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);   Override;
      procedure DoFieldOnChange(Sender: TField);                           Override;
      Function  GetSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;

   Public
      class function GetIDField: string; override;
      class function GetBusObjectTablename: string; Override;
      Constructor  Create(AOwner: TComponent);                             override;
      Destructor   Destroy;                                                override;
      Procedure    LoadFromXMLNode(Const node: IXMLNode);                  override;
      Procedure    SaveToXMLNode(Const node: IXMLNode);                    override;

      Function     ValidateData :Boolean ;                                 Override;
      Function     Save :Boolean ;                                         Override;

   published
      Property Description       :String       Read getDescription    Write SetDescription;
      Property Taxexempt         :Boolean      Read getTaxexempt      Write SetTaxexempt  ;
      Property TaxexemptFederal       :Boolean      Read getTaxexemptFederal    Write SetTaxexemptFederal  ;
      Property TaxexemptState         :Boolean      Read getTaxexemptState      Write SetTaxexemptState  ;
      Property TaxexemptSocial        :Boolean      Read getTaxexemptSocial     Write SetTaxexemptSocial  ;
      Property TaxexemptMedicare      :Boolean      Read getTaxexemptMedicare   Write SetTaxexemptMedicare  ;
      Property IsWorkPlacegiving :Boolean      Read getIsWorkPlacegiving Write SetIsWorkPlacegiving  ;
      Property Unionfees         :Boolean      Read getUnionfees      Write SetUnionfees  ;
      Property Displayin         :String       Read getDisplayin      Write SetDisplayin  ;
      Property Amount            :Double       Read getAmount         Write SetAmount     ;
      Property Calcby            :String       Read getCalcby         Write SetCalcby     ;
      Property Area              :String       Read getArea           Write SetArea     ;
      Property Percentage        :Double       Read getPercentage     Write SetPercentage ;
      Property Basedonid         :Integer      Read getBasedonid      Write SetBasedonid  ;
      Property Box12CodeId       :Integer      Read getBox12CodeId    Write SetBox12CodeId  ;
      Property Active            :Boolean      Read getActive         Write SetActive     ;
      Property Accountid         :Integer      Read getAccountid      Write SetAccountid  ;
      Property Accountname       :String       Read getAccountname    Write SetAccountname;
      Property DeductionType     :String       Read GetDType          Write SetDType;
      Property SuperInc          :Boolean      Read GetSuperInc       Write SetSuperInc  ;
      Property WorkCoverExempt   :Boolean      Read GetWorkCover      Write SetWorkCover  ;

   End;


implementation

uses
  Sysutils, PayCommon,BusObjConst, CommonLib;



{========================================================
         TDeduction
========================================================}
constructor TDeduction.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   fSQL := 'SELECT * FROM tbldeductions';
end;


destructor TDeduction.Destroy;
begin
   inherited;
end;

procedure   TDeduction.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node,'Description');
  SetBooleanPropertyFromNode(Node,'Taxexempt');
  SetBooleanPropertyFromNode(Node,'IsWorkPlacegiving');
  SetBooleanPropertyFromNode(Node,'Unionfees');
  SetPropertyFromNode(Node,'Displayin');
  SetPropertyFromNode(Node,'Amount');
  SetPropertyFromNode(Node,'Calcby');
  SetPropertyFromNode(Node,'Area');
  SetPropertyFromNode(Node,'Percentage');
  SetPropertyFromNode(Node,'Basedonid');
  GetXMLNodeBooleanValue(Node,'Active');
  SetPropertyFromNode(Node,'Accountid');
  SetPropertyFromNode(Node,'Accountname');
end;


procedure   TDeduction.SaveToXMLNode(Const node: IXMLNode);
begin
   inherited;
      AddXMLNode(node,'Description' ,Description);
      AddXMLNode(node,'Taxexempt' ,Taxexempt);
      AddXMLNode(node,'IsWorkPlacegiving' ,IsWorkPlacegiving);
      AddXMLNode(node,'Unionfees' ,Unionfees);
      AddXMLNode(node,'Displayin' ,Displayin);
      AddXMLNode(node,'Amount' ,Amount);
      AddXMLNode(node,'Calcby' ,Calcby);
      AddXMLNode(node,'Area' ,Area);
      AddXMLNode(node,'Percentage' ,Percentage);
      AddXMLNode(node,'Basedonid' ,Basedonid);
      AddXMLNode(node,'Active' ,Active);
      AddXMLNode(node,'Accountid' ,Accountid);
      AddXMLNode(node,'Accountname' ,Accountname);
end;


function    TDeduction.ValidateData :Boolean ;
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
//   if Percentage = 0 then begin
//      Resultstatus.AddItem(False , rssError , 0,  'Percentage should not be 0' );
//      Exit;
//   end;
   if Basedonid = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Basedonid should not be 0'  );
      Exit;
   end;
   if Accountid = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Accountid should not be 0'  );
      Exit;
   end;
   if Accountname = '' then begin
      Resultstatus.AddItem(False , rssError , 0,  'Account name should not be blank' , );
      Exit;
   end;
   Result := true;
end;


function    TDeduction.Save :Boolean ;
begin
   Result := False;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;

procedure TDeduction.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;

procedure TDeduction.DoFieldOnChange(Sender: TField);
begin
  inherited;
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

Function TDeduction.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;


class function  TDeduction.GetIDField : String;
begin
   Result := 'Deductionid'
end;

class function TDeduction.GetBusObjectTablename: string;
begin
  Result := 'tbldeductions';
end;

Function  TDeduction.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;


{Property functions}
Function  TDeduction.GetDescription:String    ; begin Result := GetStringField('Description');End;
Function  TDeduction.GetTaxexempt  :Boolean   ; begin Result := GetBooleanField('Taxexempt');End;
Function  TDeduction.GetTaxexemptFederal  :Boolean   ; begin Result := GetBooleanField('TaxexemptFederal');End;
Function  TDeduction.GetTaxexemptState    :Boolean   ; begin Result := GetBooleanField('TaxexemptState');End;
Function  TDeduction.GetTaxexemptSocial   :Boolean   ; begin Result := GetBooleanField('TaxexemptSocial');End;
Function  TDeduction.GetTaxexemptMedicare :Boolean   ; begin Result := GetBooleanField('TaxexemptMedicare');End;
Function  TDeduction.GetIsWorkPlacegiving  :Boolean   ; begin Result := GetBooleanField('IsWorkPlacegiving');End;
Function  TDeduction.GetUnionfees  :Boolean   ; begin Result := GetBooleanField('Unionfees');End;
Function  TDeduction.GetDisplayin  :String    ; begin Result := GetStringField('Displayin');End;
Function  TDeduction.GetAmount     :Double    ; begin Result := GetFloatField('Amount');End;
Function  TDeduction.GetCalcby     :String    ; begin Result := GetStringField('Calcby');End;
Function  TDeduction.GetArea       :String    ; begin Result := GetStringField('Area');End;
Function  TDeduction.GetPercentage :Double    ; begin Result := GetFloatField('Percentage');End;
Function  TDeduction.GetBasedonid  :Integer   ; begin Result := GetIntegerField('Basedonid');End;
Function  TDeduction.GetBox12CodeId  :Integer ; begin Result := GetIntegerField('Box12CodeID');End;
Function  TDeduction.GetActive     :Boolean   ; begin Result := GetBooleanField('Active');End;
Function  TDeduction.GetAccountid  :Integer   ; begin Result := GetIntegerField('Accountid');End;
Function  TDeduction.GetAccountname:String    ; begin Result := GetStringField('Accountname');End;
function  TDeduction.GetDType      :String    ; begin Result := GetStringField('DeductionType');End;
function  TDeduction.GetSuperInc   :Boolean   ; begin Result := GetBooleanField('SuperInc');End;
function  TDeduction.GetWorkCover  :Boolean   ; begin Result := GetBooleanField('WorkCoverExempt');End;

Procedure TDeduction.SetDescription(Const Value :String    ); begin SetStringField('Description' , Value);End;
Procedure TDeduction.SetTaxexempt  (Const Value :Boolean   ); begin SetBooleanField('Taxexempt'   , Value);End;
Procedure TDeduction.SetTaxexemptFederal  (Const Value :Boolean   ); begin SetBooleanField('TaxexemptFederal'   , Value);End;
Procedure TDeduction.SetTaxexemptState    (Const Value :Boolean   ); begin SetBooleanField('TaxexemptState'   , Value);End;
Procedure TDeduction.SetTaxexemptSocial   (Const Value :Boolean   ); begin SetBooleanField('TaxexemptSocial'   , Value);End;
Procedure TDeduction.SetTaxexemptMedicare (Const Value :Boolean   ); begin SetBooleanField('TaxexemptMedicare'   , Value);End;
Procedure TDeduction.SetIsWorkPlacegiving  (Const Value :Boolean   ); begin SetBooleanField('IsWorkPlacegiving'   , Value);End;
Procedure TDeduction.SetUnionfees  (Const Value :Boolean   ); begin SetBooleanField('Unionfees'   , Value);End;
Procedure TDeduction.SetDisplayin  (Const Value :String    ); begin SetStringField('Displayin'   , Value);End;
Procedure TDeduction.SetAmount     (Const Value :Double    ); begin SetFloatField('Amount'      , Value);End;
Procedure TDeduction.SetCalcby     (Const Value :String    ); begin SetStringField('Calcby'      , Value);End;
Procedure TDeduction.SetArea       (Const Value :String    ); begin SetStringField('Area'      , Value);End;
Procedure TDeduction.SetPercentage (Const Value :Double    ); begin SetFloatField('Percentage'  , Value);End;
Procedure TDeduction.SetBasedonid  (Const Value :Integer   ); begin SetIntegerField('Basedonid'   , Value);End;
Procedure TDeduction.SetBox12CodeId (Const Value :Integer   ); begin SetIntegerField('Box12CodeID', Value);End;
Procedure TDeduction.SetActive     (Const Value :Boolean   ); begin SetBooleanField('Active'      , Value);End;
Procedure TDeduction.SetAccountid  (Const Value :Integer   ); begin SetIntegerField('Accountid'   , Value);End;
Procedure TDeduction.SetAccountname(Const Value :String    ); begin SetStringField('Accountname' , Value);End;
procedure TDeduction.SetDType      (Const Value :String    ); begin SetStringField('DeductionType' , Value);End;
procedure TDeduction.SetSuperInc   (Const Value :Boolean   ); begin SetBooleanField('SuperInc'   , Value);End;
procedure TDeduction.SetWorkCover  (Const Value :Boolean   ); begin SetBooleanField('WorkCoverExempt'   , Value);End;


initialization

RegisterClassOnce(TDeduction);


end.
