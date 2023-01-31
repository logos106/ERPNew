unit BusobjAwardClassificationDetail;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   10/08/07   1.00.01   A.   Initial Version.
   }
   {   BusObjAwardClassificationDetail
                        |____BusObjClassificationAllowances
                        |____BusObjClassificationDeductions
                        |____BusObjClassificationExtraPayrates
   }                     

interface


uses BusObjBase, DB, Classes, BusObjClassificationAllowances,BusObjClassificationDeductions,
   BusObjClassificationExtraPayrates,MyAccess,ERPdbComponents, XMLDoc, XMLIntf;


type
   Tawardclassificationdetails = class(TMSBusObj)
   private
      fClassificationValidationEnabled       :Boolean;
      (*fClassificationAllowances:Tclassificationallowances;
      fClassificationDeductions:Tclassificationdeductions;
      fClassificationExtraPayrates:Tclassificationextrapayrates;*)

      Function GetAwardid                      :Integer   ;
      Function GetClassification               :String    ;
      Function GetType                         :String    ;
      Function GetFulltime                     :Double    ;
      Function GetParttime                     :Double    ;
      Function GetCasual                       :Double    ;
      Function GetCasualloading                :Double    ;
      Function GetAdvanceid                    :Integer   ;
      Function GetFthourlyrate                 :Double    ;
      Function GetPthourlyrate                 :Double    ;
      Function GetChourlyrate                  :Double    ;
      Function GetAdvanceidname                :String    ;
      Function GetAdvancetoclassification      :String    ;
      Function GetClassificationAllowances     :Tclassificationallowances;
      Function GetClassificationDeductions     :Tclassificationdeductions;
      Function GetClassificationExtraPayrates  :Tclassificationextrapayrates;
      Procedure SetAwardid                      (Const Value :Integer   );
      Procedure SetClassification               (Const Value :String    );
      Procedure SetType                         (Const Value :String    );
      Procedure SetFulltime                     (Const Value :Double    );
      Procedure SetParttime                     (Const Value :Double    );
      Procedure SetCasual                       (Const Value :Double    );
      Procedure SetCasualloading                (Const Value :Double    );
      Procedure SetAdvanceid                    (Const Value :Integer   );
      Procedure SetFthourlyrate                 (Const Value :Double    );
      Procedure SetPthourlyrate                 (Const Value :Double    );
      Procedure SetChourlyrate                  (Const Value :Double    );
      Procedure SetAdvanceidname                (Const Value :String    );
      Procedure SetAdvancetoclassification      (Const Value :String    );

      procedure LoadSubObjs;
   Protected
      procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);   Override;
      procedure DoFieldOnChange(Sender: TField);                           Override;
      Function  GetSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
      Function  DoBeforeInsert(Sender :TDatasetBusObj ):Boolean;           Override;
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

      procedure Load(const fIsReadonly:boolean =False);override;
      Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean;            Override;


      Property Awardid                       :Integer      Read getAwardid                    Write SetAwardid                ;
      Property Classification                :String       Read getClassification             Write SetClassification         ;
      Property ClassificationType            :String       Read getType                       Write SetType                   ;
      Property Fulltime                      :Double       Read getFulltime                   Write SetFulltime               ;
      Property Parttime                      :Double       Read getParttime                   Write SetParttime               ;
      Property Casual                        :Double       Read getCasual                     Write SetCasual                 ;
      Property Casualloading                 :Double       Read getCasualloading              Write SetCasualloading          ;
      Property Advanceid                     :Integer      Read getAdvanceid                  Write SetAdvanceid              ;
      Property Fthourlyrate                  :Double       Read getFthourlyrate               Write SetFthourlyrate           ;
      Property Pthourlyrate                  :Double       Read getPthourlyrate               Write SetPthourlyrate           ;
      Property Chourlyrate                   :Double       Read getChourlyrate                Write SetChourlyrate            ;
      Property Advanceidname                 :String       Read getAdvanceidname              Write SetAdvanceidname          ;
      Property Advancetoclassification       :String       Read getAdvancetoclassification    Write SetAdvancetoclassification;

      Property ClassificationAllowances      :Tclassificationallowances Read getClassificationAllowances ;//Write fClassificationAllowances;
      Property ClassificationDeductions      :Tclassificationdeductions Read getClassificationDeductions ;//Write fClassificationDeductions;
      Property ClassificationExtraPayrates   :Tclassificationextrapayrates Read getClassificationExtraPayrates ;//Write fClassificationExtraPayrates;

      Property ClassificationValidationEnabled : Boolean read fClassificationValidationEnabled write fClassificationValidationEnabled;
   End;


implementation


uses SysUtils,BusObjAwards,BusObjConst, CommonLib;


{========================================================
         Tawardclassificationdetails
========================================================}
constructor Tawardclassificationdetails.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   fSQL := 'SELECT * FROM tblawardclassificationdetails';
end;

constructor Tawardclassificationdetails.Create(AOwner: TComponent;PassedConnection:TERPConnection);
begin
   inherited Create(AOwner);
   Connection  := TMyDacDataConnection.Create(Self);
   TMyDacDataConnection(Connection).MydacConnection  := PassedConnection;

   (*fClassificationAllowances    := Tclassificationallowances.Create(Self);
   fClassificationAllowances.Connection := Self.Connection;
   fClassificationDeductions    := Tclassificationdeductions.Create(Self);
   fClassificationDeductions.Connection := Self.Connection;
   fClassificationExtraPayrates := Tclassificationextrapayrates.Create(Self);
   fClassificationExtraPayrates.Connection := Self.Connection;*)
end;

procedure   Tawardclassificationdetails.Load(const fIsReadonly:boolean =False);
begin
  inherited;
  LoadSubObjs;
end;


Function  Tawardclassificationdetails.DoBeforeInsert(Sender :TDatasetBusObj ):Boolean;
begin
  Result := inherited DoBeforeInsert(Sender);
  if not ValidateData then begin
    SendEvent(BusobjEventVal_HandleIncompleteRecord,BusObjEvent_Change );
    Abort;
  end;
end;

procedure   Tawardclassificationdetails.LoadSubObjs;
begin
  (*fClassificationAllowances.LoadSelect('ClassificationID = ' + IntToStr(Self.Id));
  fClassificationDeductions.LoadSelect('ClassificationID = ' + IntToStr(Self.Id));
  fClassificationExtraPayrates.LoadSelect('ClassificationID = ' + IntToStr(Self.Id));*)
end;
Function Tawardclassificationdetails.GetClassificationAllowances     :Tclassificationallowances;
begin
    Result := Tclassificationallowances(getContainerComponent(Tclassificationallowances, 'ClassificationID = ' + IntToStr(Self.Id)));
end;
Function Tawardclassificationdetails.GetClassificationDeductions     :Tclassificationdeductions;
begin
    Result := Tclassificationdeductions(getContainerComponent(Tclassificationdeductions, 'ClassificationID = ' + IntToStr(Self.Id)));
end;
Function Tawardclassificationdetails.GetClassificationExtraPayrates  :Tclassificationextrapayrates;
begin
    Result := Tclassificationextrapayrates(getContainerComponent(Tclassificationextrapayrates, 'ClassificationID = ' + IntToStr(Self.Id)));
end;


Function  Tawardclassificationdetails.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    if Assigned(Self.Owner) then
        if Self.Owner is TAward then
                AwardId := TAward(Self.Owner).Id;
    Result := inherited DoAfterInsert(Sender);
    PostDb;   //needed here; later checks if record exists to create allowances etc
end;

destructor Tawardclassificationdetails.Destroy;
begin
   inherited;
end;


procedure   Tawardclassificationdetails.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node,'Awardid');
  SetPropertyFromNode(Node,'Classification');
  SetPropertyFromNode(Node,'Type');
  SetPropertyFromNode(Node,'Fulltime');
  SetPropertyFromNode(Node,'Parttime');
  SetPropertyFromNode(Node,'Casual');
  SetPropertyFromNode(Node,'Casualloading');
  SetPropertyFromNode(Node,'Advanceid');
  SetPropertyFromNode(Node,'Fthourlyrate');
  SetPropertyFromNode(Node,'Pthourlyrate');
  SetPropertyFromNode(Node,'Chourlyrate');
  SetPropertyFromNode(Node,'Advanceidname');
  SetPropertyFromNode(Node,'Advancetoclassification');
end;


procedure   Tawardclassificationdetails.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Awardid' ,Awardid);
  AddXMLNode(node,'Classification' ,Classification);
  AddXMLNode(node,'Type' ,ClassificationType);
  AddXMLNode(node,'Fulltime' ,Fulltime);
  AddXMLNode(node,'Parttime' ,Parttime);
  AddXMLNode(node,'Casual' ,Casual);
  AddXMLNode(node,'Casualloading' ,Casualloading);
  AddXMLNode(node,'Advanceid' ,Advanceid);
  AddXMLNode(node,'Fthourlyrate' ,Fthourlyrate);
  AddXMLNode(node,'Pthourlyrate' ,Pthourlyrate);
  AddXMLNode(node,'Chourlyrate' ,Chourlyrate);
  AddXMLNode(node,'Advanceidname' ,Advanceidname);
  AddXMLNode(node,'Advancetoclassification' ,Advancetoclassification);

        {sub properties should be created only when exporting}
  if not SavingXMLTofile then exit;
  ExportsubClasses(Node);
end;

Function Tawardclassificationdetails.ExportsubClasses(Const node: IXMLNode):Boolean;
begin
    self.ClassificationAllowances.XMLPropertyNode := node.AddChild('ClassificationAllowances');
    self.ClassificationAllowances.XMLPropertyName:= 'ClassificationAllowances';
    self.ClassificationAllowances.IterateRecords(GetPropertyXMLCallback);

    self.ClassificationDeductions.XMLPropertyNode := node.AddChild('ClassificationDeductions');
    self.ClassificationDeductions.XMLPropertyName:= 'ClassificationDeductions';
    self.ClassificationDeductions.IterateRecords(GetPropertyXMLCallback);

    self.ClassificationExtraPayrates.XMLPropertyNode := node.AddChild('ClassificationExtraPayRates');
    self.ClassificationExtraPayrates.XMLPropertyName:= 'ClassificationExtraPayRates';
    self.ClassificationExtraPayrates.IterateRecords(GetPropertyXMLCallback);

    Result := True;
end;

function  Tawardclassificationdetails.ValidateData :Boolean ;
begin
   if Self.Dataset.RecordCount = 0 then begin // don't force em to have a classification
     Result := True;
     exit;
   end;

   Result := False;
   Resultstatus.Clear;
  // if Awardid = 0 then begin
//      Resultstatus.AddItem(False , rssError , 0,  'Award id should not be 0'  );
//      Exit;
//   end;
   if Classification = '' then begin
      Resultstatus.AddItem(False , rssError , BOR_AwardClassification_Err_NoDescription,  'Classification should not be blank' );
      Exit;
   end;
   if ClassificationType = '' then begin
      Resultstatus.AddItem(False , rssError , BOR_AwardClassification_Err_NoType,  'Classification Type should not be blank' );
      Exit;
   end;
   if Fulltime = 0 then begin
      Resultstatus.AddItem(False , rssError , BOR_AwardClassification_Err_NoFtHourlyRate,  'Full time should not be 0'  );
      Exit;
   end;
   if Parttime = 0 then begin
      Resultstatus.AddItem(False , rssError , BOR_AwardClassification_Err_NoPtHourlyRate,  'Part time should not be 0'  );
      Exit;
   end;
   if Casual = 0 then begin
      Resultstatus.AddItem(False , rssError , BOR_AwardClassification_Err_NoCHourlyRate,  'Casual should not be 0' );
      Exit;
   end;
//   if Casualloading = 0 then begin
//      Resultstatus.AddItem(False , rssError , 0,  'Casualloading should not be 0' );
//      Exit;
//   end;
//   if Advanceid = 0 then begin
//      Resultstatus.AddItem(False , rssError , 0,  'Advance id should not be 0' );
//      Exit;
//   end;
//   if Fthourlyrate = 0 then begin
//      Resultstatus.AddItem(False , rssError , BOR_AwardClassification_Err_NoFtHourlyRate,  'Full time hourly rate should not be 0' );
//      Exit;
//   end;
//   if Pthourlyrate = 0 then begin
//      Resultstatus.AddItem(False , rssError , BOR_AwardClassification_Err_NoPtHourlyRate,  'Part time hourly rate should not be 0'  );
//      Exit;
//   end;
//   if Chourlyrate = 0 then begin
//      Resultstatus.AddItem(False , rssError , BOR_AwardClassification_Err_NoCHourlyRate,  'Casual hourly rate should not be 0'  );
//      Exit;
//   end;
   if Advanceidname = '' then begin
      Resultstatus.AddItem(False , rssError , BOR_AwardClassification_Err_NoAdvanceID,  'Advance name should not be blank' );
      Exit;
   end;
 //  if Advancetoclassification = '' then begin
//      Resultstatus.AddItem(False , rssError , 0,  'Advancetoclassification should not be blank' );
//      Exit;
//   end;
   Result := true;
end; 

function    Tawardclassificationdetails.Save :Boolean ;
begin
   Result := False;
   if not ClassificationAllowances.Save then exit;
   if not ClassificationDeductions.Save then exit;
   if not ClassificationExtraPayrates.Save then exit;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;


procedure Tawardclassificationdetails.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
   LoadSubObjs;

end;


procedure Tawardclassificationdetails.DoFieldOnChange(Sender: TField);
begin
   inherited;
end;


Function Tawardclassificationdetails.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;


class function  Tawardclassificationdetails.GetIDField : String;
begin
   Result := 'Classificationid'
end;

class function Tawardclassificationdetails.GetBusObjectTablename: string;
begin
  Result := 'tblawardclassificationdetails';
end;


Function  Tawardclassificationdetails.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;


{Property functions}
Function  Tawardclassificationdetails.GetAwardid                :Integer   ; begin Result := GetIntegerField('Awardid');End;
Function  Tawardclassificationdetails.GetClassification         :String    ; begin Result := GetStringField('Classification');End;
Function  Tawardclassificationdetails.GetType                   :String    ; begin Result := GetStringField('Type');End;
Function  Tawardclassificationdetails.GetFulltime               :Double    ; begin Result := GetFloatField('Fulltime');End;
Function  Tawardclassificationdetails.GetParttime               :Double    ; begin Result := GetFloatField('Parttime');End;
Function  Tawardclassificationdetails.GetCasual                 :Double    ; begin Result := GetFloatField('Casual');End;
Function  Tawardclassificationdetails.GetCasualloading          :Double    ; begin Result := GetFloatField('Casualloading');End;
Function  Tawardclassificationdetails.GetAdvanceid              :Integer   ; begin Result := GetIntegerField('Advanceid');End;
Function  Tawardclassificationdetails.GetFthourlyrate           :Double    ; begin Result := GetFloatField('Fthourlyrate');End;
Function  Tawardclassificationdetails.GetPthourlyrate           :Double    ; begin Result := GetFloatField('Pthourlyrate');End;
Function  Tawardclassificationdetails.GetChourlyrate            :Double    ; begin Result := GetFloatField('Chourlyrate');End;
Function  Tawardclassificationdetails.GetAdvanceidname          :String    ; begin Result := GetStringField('Advanceidname');End;
Function  Tawardclassificationdetails.GetAdvancetoclassification:String    ; begin Result := GetStringField('Advancetoclassification');End;
Procedure Tawardclassificationdetails.SetAwardid                (Const Value :Integer   ); begin SetIntegerField('Awardid'                 , Value);End;
Procedure Tawardclassificationdetails.SetClassification         (Const Value :String    ); begin SetStringField('Classification'          , Value);End;
Procedure Tawardclassificationdetails.SetType                   (Const Value :String    ); begin SetStringField('Type'                    , Value);End;
Procedure Tawardclassificationdetails.SetFulltime               (Const Value :Double    ); begin SetFloatField('Fulltime'                , Value);End;
Procedure Tawardclassificationdetails.SetParttime               (Const Value :Double    ); begin SetFloatField('Parttime'                , Value);End;
Procedure Tawardclassificationdetails.SetCasual                 (Const Value :Double    ); begin SetFloatField('Casual'                  , Value);End;
Procedure Tawardclassificationdetails.SetCasualloading          (Const Value :Double    ); begin SetFloatField('Casualloading'           , Value);End;
Procedure Tawardclassificationdetails.SetAdvanceid              (Const Value :Integer   ); begin SetIntegerField('Advanceid'               , Value);End;
Procedure Tawardclassificationdetails.SetFthourlyrate           (Const Value :Double    ); begin SetFloatField('Fthourlyrate'            , Value);End;
Procedure Tawardclassificationdetails.SetPthourlyrate           (Const Value :Double    ); begin SetFloatField('Pthourlyrate'            , Value);End;
Procedure Tawardclassificationdetails.SetChourlyrate            (Const Value :Double    ); begin SetFloatField('Chourlyrate'             , Value);End;
Procedure Tawardclassificationdetails.SetAdvanceidname          (Const Value :String    ); begin SetStringField('Advanceidname'           , Value);End;
Procedure Tawardclassificationdetails.SetAdvancetoclassification(Const Value :String    ); begin SetStringField('Advancetoclassification' , Value);End;


initialization
RegisterClassOnce(Tawardclassificationdetails);


end.

