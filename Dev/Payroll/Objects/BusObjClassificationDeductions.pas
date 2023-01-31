unit BusObjClassificationDeductions;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   17/08/07   1.00.01   A.   Initial Version.
   }


interface


uses BusObjBase, DB, Classes, BusObjDeductions, XMLDoc, XMLIntf;


type
   Tclassificationdeductions = class(TMSBusObj)
   private
      fDeduction:TDeduction;
      Function GetClassificationid      :Integer   ;
      Function GetDeductid              :Integer   ;
      Function GetAmount                :Double    ;
      Function GetCalcby                :String   ;
      Function GetBasedonid             :Integer   ;
      Function GetAwardid               :Integer   ;
      Procedure SetClassificationid      (Const Value :Integer   );
      Procedure SetDeductid              (Const Value :Integer   );
      Procedure SetAmount                (Const Value :Double    );
      Procedure SetCalcby                (Const Value :String   );
      Procedure SetBasedonid             (Const Value :Integer   );
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
      procedure AddDeductionDetails;

      Property Classificationid       :Integer      Read getClassificationid    Write SetClassificationid;
      Property Deductid               :Integer      Read getDeductid            Write SetDeductid        ;
      Property Amount                 :Double       Read getAmount              Write SetAmount          ;
      Property Calcby                 :String      Read getCalcby              Write SetCalcby          ;
      Property Basedonid              :Integer      Read getBasedonid           Write SetBasedonid       ;
      Property Awardid                :Integer      Read getAwardid             Write SetAwardid         ;
   End;


implementation


uses BusObjAwardClassificationDetail,SysUtils,BusObjConst, CommonLib;


{========================================================
         Tclassificationdeductions
========================================================}
constructor Tclassificationdeductions.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   fSQL := 'SELECT * FROM tblclassificationdeductions';
   fDeduction := TDeduction.Create(Self);
end;


destructor Tclassificationdeductions.Destroy;
begin
   inherited;
end;

Function  Tclassificationdeductions.DoBeforeInsert(Sender :TDatasetBusObj ):Boolean;
begin
  Result := inherited DoBeforeInsert(Sender);
  if not ValidateData then begin
    SendEvent(BusobjEventVal_HandleIncompleteRecord,BusObjEvent_Change );
    Abort;
  end;
end;

procedure Tclassificationdeductions.AddDeductionDetails;
begin
  //DeductionID := PayCommon.GetDeductionID(Deduction);
  fDeduction.Load(DeductID);
  Amount := fDeduction.Amount;
  CalcBy := fDeduction.Calcby;
  BasedOnID := fDeduction.Basedonid;
end;

Function  Tclassificationdeductions.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    if Assigned(Self.Owner) then
        if Self.Owner is Tawardclassificationdetails then begin
          ClassificationId := Tawardclassificationdetails(Self.Owner).Id;
          AwardID :=  Tawardclassificationdetails(Self.Owner).Awardid;
        end;
    Result := inherited DoAfterInsert(Sender);
end;

procedure   Tclassificationdeductions.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node,'Classificationid');
  SetPropertyFromNode(Node,'Deductid');
  SetPropertyFromNode(Node,'Amount');
  SetPropertyFromNode(Node,'Calcby');
  SetPropertyFromNode(Node,'Basedonid');
  SetPropertyFromNode(Node,'Awardid');
end;


procedure   Tclassificationdeductions.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Classificationid' ,Classificationid);
  AddXMLNode(node,'Deductid' ,Deductid);
  AddXMLNode(node,'Amount' ,Amount);
  AddXMLNode(node,'Calcby' ,Calcby);
  AddXMLNode(node,'Basedonid' ,Basedonid);
  AddXMLNode(node,'Awardid' ,Awardid);
end;


function    Tclassificationdeductions.ValidateData :Boolean ;
begin
   if Self.Dataset.RecordCount = 0 then begin // don't force em to have a deduction
     Result := True;
     exit
   end;

   Result := False;
   Resultstatus.Clear;
  // if Classificationid = 0 then begin
//      Resultstatus.AddItem(False , rssError , 0,  'Classificationid should not be 0'  );
//      Exit;
//   end;
   if Deductid = 0 then begin
      Resultstatus.AddItem(False , rssError , BOR_ClassificationDeduction_Err_NoDeduction,  'Deductid should not be 0'  );
      Exit;
   end;
   if Amount = 0 then begin
      Resultstatus.AddItem(False , rssError , BOR_ClassificationDeduction_Err_NoAmount,  'Amount should not be 0' );
      Exit;
   end;
   if Basedonid = 0 then begin
      Resultstatus.AddItem(False , rssError , BOR_ClassificationDeduction_Err_NoBasedOn,  'Basedonid should not be 0' );
      Exit;
   end;
 //  if Awardid = 0 then begin
//      Resultstatus.AddItem(False , rssError , 0,  'Awardid should not be 0'  );
//      Exit;
//   end;
   Result := true;
end;


function    Tclassificationdeductions.Save :Boolean ;
begin
   Result := False;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;


procedure Tclassificationdeductions.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;


procedure Tclassificationdeductions.DoFieldOnChange(Sender: TField);
begin
   inherited;
   if Sysutils.SameText(Sender.FieldName , 'DeductID') then begin
     AddDeductionDetails;
   end;
end;


Function Tclassificationdeductions.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;


class function  Tclassificationdeductions.GetIDField : String;
begin
   Result := 'Deductionid'
end;

class function Tclassificationdeductions.GetBusObjectTablename: string;
begin
  Result := 'tblclassificationdeductions';
end;


Function  Tclassificationdeductions.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;


{Property functions}
Function  Tclassificationdeductions.GetClassificationid:Integer   ; begin Result := GetIntegerField('Classificationid');End;
Function  Tclassificationdeductions.GetDeductid        :Integer   ; begin Result := GetIntegerField('Deductid');End;
Function  Tclassificationdeductions.GetAmount          :Double    ; begin Result := GetFloatField('Amount');End;
Function  Tclassificationdeductions.GetCalcby          :String   ; begin Result := GetStringField('Calcby');End;
Function  Tclassificationdeductions.GetBasedonid       :Integer   ; begin Result := GetIntegerField('Basedonid');End;
Function  Tclassificationdeductions.GetAwardid         :Integer   ; begin Result := GetIntegerField('Awardid');End;
Procedure Tclassificationdeductions.SetClassificationid(Const Value :Integer   ); begin SetIntegerField('Classificationid' , Value);End;
Procedure Tclassificationdeductions.SetDeductid        (Const Value :Integer   ); begin SetIntegerField('Deductid'         , Value);End;
Procedure Tclassificationdeductions.SetAmount          (Const Value :Double    ); begin SetFloatField('Amount'           , Value);End;
Procedure Tclassificationdeductions.SetCalcby          (Const Value :String   ); begin SetStringField('Calcby'           , Value);End;
Procedure Tclassificationdeductions.SetBasedonid       (Const Value :Integer   ); begin SetIntegerField('Basedonid'        , Value);End;
Procedure Tclassificationdeductions.SetAwardid         (Const Value :Integer   ); begin SetIntegerField('Awardid'          , Value);End;


initialization
RegisterClassOnce(Tclassificationdeductions);


end.
