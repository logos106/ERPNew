unit BusObjClassificationExtraPayrates;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   10/08/07   1.00.01   A.   Initial Version.
   }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
   Tclassificationextrapayrates = class(TMSBusObj)
   private
      Function GetClassificationid      :Integer   ;
      Function GetPayrate               :Integer   ;
      Function GetTypeid                :Integer   ;
      Function GetWorked                :Double    ;
      Function GetAmount                :Double    ;
      Function GetSuperinc              :Boolean   ;
      Function GetAwardid               :Integer   ;
      Procedure SetClassificationid      (Const Value :Integer   );
      Procedure SetPayrate               (Const Value :Integer   );
      Procedure SetTypeid                (Const Value :Integer   );
      Procedure SetWorked                (Const Value :Double    );
      Procedure SetAmount                (Const Value :Double    );
      Procedure SetSuperinc              (Const Value :Boolean   );
      Procedure SetAwardid               (Const Value :Integer   );
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
      Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean;            Override;
      Function  DoBeforeInsert(Sender :TDatasetBusObj ):Boolean;           Override;

      Property Classificationid       :Integer      Read getClassificationid    Write SetClassificationid;
      Property Payrate                :Integer      Read getPayrate             Write SetPayrate         ;
      Property Typeid                 :Integer      Read getTypeid              Write SetTypeid          ;
      Property Worked                 :Double       Read getWorked              Write SetWorked          ;
      Property Amount                 :Double       Read getAmount              Write SetAmount          ;
      Property Superinc               :Boolean      Read getSuperinc            Write SetSuperinc        ;
      Property Awardid                :Integer      Read getAwardid             Write SetAwardid         ;
   End;


implementation


uses BusObjAwardClassificationDetail,BusObjConst,PayCommon,SysUtils,
  CommonLib;


{========================================================
         Tclassificationextrapayrates
========================================================}
constructor Tclassificationextrapayrates.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   fSQL := 'SELECT * FROM tblclassificationextrapayrates';
end;


destructor Tclassificationextrapayrates.Destroy;
begin
   inherited;
end;

Function  Tclassificationextrapayrates.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    if Assigned(Self.Owner) then
        if Self.Owner is Tawardclassificationdetails then begin
                ClassificationId := Tawardclassificationdetails(Self.Owner).Id;
                AwardID :=  Tawardclassificationdetails(Self.Owner).Awardid;
              end;  
    Result := inherited DoAfterInsert(Sender);
end;

Function  Tclassificationextrapayrates.DoBeforeInsert(Sender :TDatasetBusObj ):Boolean;
begin
  Result := inherited DoBeforeInsert(Sender);
  if not ValidateData then begin
    SendEvent(BusobjEventVal_HandleIncompleteRecord,BusObjEvent_Change );
    Abort;
  end;
end;

procedure   Tclassificationextrapayrates.LoadFromXMLNode(Const node: IXMLNode);
begin
   inherited;
      Classificationid       :=GetXMLNodeIntegerValue(Node,'Classificationid');
      Payrate                :=GetXMLNodeIntegerValue(Node,'Payrate');
      Typeid                 :=GetXMLNodeIntegerValue(Node,'Typeid');
      Worked                 :=GetXMLNodeFloatValue(Node,'Worked');
      Amount                 :=GetXMLNodeFloatValue(Node,'Amount');
      Superinc               :=GetXMLNodeBooleanValue(Node,'Superinc');
      Awardid                :=GetXMLNodeIntegerValue(Node,'Awardid');
end;


procedure   Tclassificationextrapayrates.SaveToXMLNode(Const node: IXMLNode);
begin
   inherited;
      AddXMLNode(node,'Classificationid' ,Classificationid);
      AddXMLNode(node,'Payrate' ,Payrate);
      AddXMLNode(node,'Typeid' ,Typeid);
      AddXMLNode(node,'Worked' ,Worked);
      AddXMLNode(node,'Amount' ,Amount);
      AddXMLNode(node,'Superinc' ,Superinc);
      AddXMLNode(node,'Awardid' ,Awardid);
end;


function    Tclassificationextrapayrates.ValidateData :Boolean ;
begin
   if Self.Dataset.RecordCount = 0 then begin  //don't force em to have an extra payrate
     Result := True;
     exit;
   end;

   Result := False;
   Resultstatus.Clear;
//   if Classificationid = 0 then begin
//      Resultstatus.AddItem(False , rssError , 0,  'Classificationid should not be 0'  );
//      Exit;
//   end;
   if Payrate = 0 then begin
      Resultstatus.AddItem(False , rssError , BOR_ClassificationExtraPayRates_Err_NoPayRate,  'Payrate should not be blank.'  );
      Exit;
   end;
   if Typeid = 0 then begin
      Resultstatus.AddItem(False , rssError , BOR_ClassificationExtraPayRates_Err_NoType,  'Type should not be blank.'  );
      Exit;
   end;
   if Worked = 0 then begin
      Resultstatus.AddItem(False , rssError , BOR_ClassificationExtraPayRates_Err_NoWorked,  'Hours should not be 0' );
      Exit;
   end;
   if Amount = 0 then begin
      Resultstatus.AddItem(False , rssError , BOR_ClassificationExtraPayRates_Err_NoAmount,  'Amount should not be 0' );
      Exit;
   end;
 //  if Awardid = 0 then begin
//      Resultstatus.AddItem(False , rssError , 0,  'Awardid should not be 0'  );
//      Exit;
//   end;
   Result := true;
end;


function    Tclassificationextrapayrates.Save :Boolean ;
begin
   Result := False;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;


procedure Tclassificationextrapayrates.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;

procedure Tclassificationextrapayrates.DoFieldOnChange(Sender: TField);
begin
   inherited;
   if Sysutils.SameText(Sender.FieldName , 'PayRate') then begin
     { Assume basis of payment is full time; at this point impossible to know what employee this will be applied to}
     Amount := GetPayRateMultiplier(PayRate) *  Tawardclassificationdetails(Self.Owner).Fulltime;
   end;
end;

Function Tclassificationextrapayrates.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;


class function  Tclassificationextrapayrates.GetIDField : String;
begin
   Result := 'Rateid'
end;

class function Tclassificationextrapayrates.GetBusObjectTablename: string;
begin
  Result := 'tblclassificationextrapayrates';
end;


Function  Tclassificationextrapayrates.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;


{Property functions}
Function  Tclassificationextrapayrates.GetClassificationid:Integer   ; begin Result := GetIntegerField('Classificationid');End;
Function  Tclassificationextrapayrates.GetPayrate         :Integer   ; begin Result := GetIntegerField('Payrate');End;
Function  Tclassificationextrapayrates.GetTypeid          :Integer   ; begin Result := GetIntegerField('Typeid');End;
Function  Tclassificationextrapayrates.GetWorked          :Double    ; begin Result := GetFloatField('Worked');End;
Function  Tclassificationextrapayrates.GetAmount          :Double    ; begin Result := GetFloatField('Amount');End;
Function  Tclassificationextrapayrates.GetSuperinc        :Boolean   ; begin Result := GetBooleanField('Superinc');End;
Function  Tclassificationextrapayrates.GetAwardid         :Integer   ; begin Result := GetIntegerField('Awardid');End;
Procedure Tclassificationextrapayrates.SetClassificationid(Const Value :Integer   ); begin SetIntegerField('Classificationid' , Value);End;
Procedure Tclassificationextrapayrates.SetPayrate         (Const Value :Integer   ); begin SetIntegerField('Payrate'          , Value);End;
Procedure Tclassificationextrapayrates.SetTypeid          (Const Value :Integer   ); begin SetIntegerField('Typeid'           , Value);End;
Procedure Tclassificationextrapayrates.SetWorked          (Const Value :Double    ); begin SetFloatField('Worked'           , Value);End;
Procedure Tclassificationextrapayrates.SetAmount          (Const Value :Double    ); begin SetFloatField('Amount'           , Value);End;
Procedure Tclassificationextrapayrates.SetSuperinc        (Const Value :Boolean   ); begin SetBooleanField('Superinc'         , Value);End;
Procedure Tclassificationextrapayrates.SetAwardid         (Const Value :Integer   ); begin SetIntegerField('Awardid'          , Value);End;


initialization
RegisterClassOnce(Tclassificationextrapayrates);


end.
