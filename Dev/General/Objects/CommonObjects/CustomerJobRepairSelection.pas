unit CustomerJobRepairSelection;

interface
uses
  MyAccess,ERPdbComponents, db,Wwdbgrid, wwdblook;

type
  TCustomerJobSelection = (tnone=0,tCustomernJob= 1,tJobOnly=2);

  TCustomerJobRepairObj = Class(TObject)
  Private
    fiClientID: Integer;
    fiRepairID: integer;
    fsRepairIdField: String;
    fsclassNameField: String;
    fsJobnameField: String;
    fsClassIdfield: String;
    fsEquipmentNameField: String;
    fiCustomerEquipIDField: String;
    fsJobIDField: String;
    fcurSelection: TCustomerJobSelection;
    fgrid: TwwDBGrid;
    fRepairCombo: TwwDBLookupcombo;
    fJobcombo: TwwDBLookupcombo;
    procedure setClientID(const Value: Integer);
    procedure setRepairID(const Value: integer);
    function getDataset: Tdataset;
    function getjobLookup: Tdataset;
    function getrepairLookup: Tdataset;
  Public
    Property grid                :TwwDBGrid             read fgrid                  write fgrid;
    Property Jobcombo            :TwwDBLookupcombo      read fJobcombo              write fJobcombo;
    Property RepairCombo         :TwwDBLookupcombo      read fRepairCombo           write fRepairCombo;
    Property JobIDField          :String                read fsJobIDField           write fsJobIDField;
    Property JobnameField        :String                read fsJobnameField         Write fsJobnameField;
    Property RepairIdField       :String                read fsRepairIdField        Write fsRepairIdField;
    Property CustomerEquipIDField:String                read fiCustomerEquipIDField write fiCustomerEquipIDField;
    Property EquipmentNameField  :String                read fsEquipmentNameField   Write fsEquipmentNameField;
    Property ClassIdfield        :String                read fsClassIdfield         write fsClassIdfield;
    Property classNameField      :String                read fsclassNameField       Write fsclassNameField;
    Property curSelection        :TCustomerJobSelection read fcurSelection          write fcurSelection;
    Property ClientID            :Integer               read fiClientID             write setClientID;
    Property RepairID            :integer               read fiRepairID             write setRepairID;
    Property Dataset             :Tdataset              read getDataset;
    Property repairLookup        :Tdataset              read getrepairLookup;
    Property jobLookup           :Tdataset              read getjobLookup;

    Procedure JobCustomerSetUp;
    Procedure SetUpRepair;
    procedure RepairCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure JobCustomerSetUpCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    Procedure rowchanged;

  end;

implementation

uses AppEnvironment, CommonLib, DNMLib, tcDataUtils;

{ TCustomerJobRepairRec }

function TCustomerJobRepairObj.getDataset: Tdataset;
begin
  result := Grid.datasource.dataset;
end;

function TCustomerJobRepairObj.getjobLookup: Tdataset;
begin
  result := Jobcombo.LookupTable;
end;

function TCustomerJobRepairObj.getrepairLookup: Tdataset;
begin
  result := RepairCombo.LookupTable;
end;

procedure TCustomerJobRepairObj.JobCustomerSetUp;
var
    fieldnames :Array [1..2] of string;
    fieldindex:Integer;
    strSQL:String;
    xindex:Integer;
    xcurSelection :TCustomerJobSelection;

    Procedure nextOption;
    begin
        if curSelection = tCustomernJob     then curSelection := tJobonly
        else if curSelection = tJobonly    then curSelection :=  tCustomernJob;
    end;
    Procedure moveTonextoption;
    begin
      if curSelection = tnone then begin
        if AppEnv.CompanyPrefs.ShowCustomerJobNoByDefault then
          curSelection := tjobonly
        else curSelection := tCustomernJob;
      end else begin
        nextOption;
      end;
      if curSelection = tCustomernJob     then fieldindex := 1
      else if curSelection = tJobonly    then fieldindex := 2;
    end;
    Function getPrevfield:Tfield;
    begin
      result := nil;
      if (curSelection = tcustomernjob) or (curSelection =  tJobonly)  then result := dataset.findfield(JobnameField)
      else if curSelection = tNone then
        if (curSelection = tcustomernjob) or (curSelection =  tJobonly)  then result := dataset.findfield(JobnameField);
    end;
    function CurIndex       :Integer ;begin
      try
        result := getPrevfield.index;
      except
        result :=0;
      end;
    end;
    function curdisplaywidth:Integer ;begin
      try
        result := getPrevfield.displaywidth;
      except
        result :=0;
      end;
    end;
begin
    if AppEnv.CompanyPrefs.JobNameHeader   <> '' then Fieldnames[1] := AppEnv.CompanyPrefs.JobNameHeader else Fieldnames[1] := 'Job Name';
    if AppEnv.CompanyPrefs.JobNumberHeader <> '' then Fieldnames[2] := AppEnv.CompanyPrefs.JobNumberHeader else Fieldnames[2] :='Job#';
    if curSelection = tnone then  SetUpRepair;
    xcurSelection := curSelection;
    moveTonextOption;
    if xcurSelection = curSelection then Exit; // no change

      strSQL:= 'SELECT ' +
              ' C.ClientID,C.Company,C.JobNumber,C.DefaultClass,C.Street,C.Street2,C.Suburb,C.State, ' +
              ' C.Country,C.Postcode,C.BillStreet,C.BillStreet2,C.BillSuburb,C.BillState,C.BillPostcode, ' +
              ' C.TERMS,C.ShippingMethod,C.ShippingID,C.ShipTime';
      strSQL:= strSQL +  ' FROM tblclients AS C';
      strSQL:= strSQL +  ' WHERE C.Active =  "T" AND C.Customer =  "T"';
      if fieldindex = 2 then strSQL:= strSQL +  ' AND ifnull(C.jobnumber,0) <> 0';
      strSQL:= strSQL+ ' and (((:SearchMode = 0) or IsNull(:SearchMode)) '+
            ' or ((:SearchMode = 1) and ((Company LIKE Concat(:SearchValue,"%")) or (JobNumber LIKE Concat(:SearchValue,"%")) ))'+
            ' or ((:SearchMode = 2) and ((Company LIKE Concat("%",:SearchValue,"%")) or (JobNumber LIKE Concat("%",:SearchValue,"%")) ))) ' +
            ' and IfNull(:SearchValue,"") <> "" ';
      strSQL := StrSQL +' order by Company';
      if jobLookup.active then jobLookup.close;
      TERPQuery(jobLookup).SQL.Clear;
      TERPQuery(jobLookup).SQL.add(strSQL);
      TERPQuery(jobLookup).open;
      jobcombo.Selected.Clear;
    if fieldindex = 2 then begin
      jobcombo.Selected.Add('Company'  + #9 + '30' + #9 + FieldNames[1]+#9+'T' + #9);
      jobcombo.Selected.Add('JobNumber'+ #9 + '10' + #9 + FieldNames[2]+#9+'T' + #9);
    end else if fieldindex = 1 then begin
      jobcombo.Selected.Add('Company'  + #9 + '30' + #9 + FieldNames[1]+#9+'T' + #9);
      jobcombo.Selected.Add('JobNumber'+ #9 + '10' + #9 + FieldNames[2]+#9+'T' + #9);
    end;
    xIndex := CurIndex;
    jobCOMBO.Text := TERPQuery(jobLookup).FieldByName('Company').AsString;
    if xcurSelection <> tnone then grid.Addfield(JobnameField);
    Dataset.FieldByName(JobnameField).Index := xIndex;
    Dataset.FieldByName(JobnameField).Displaywidth := curdisplaywidth;
    if curSelection = tcustomernjob then
      Dataset.fieldbyname(JobnameField).displaylabel := 'Customer/Job'
    else Dataset.fieldbyname(JobnameField).displayLabel := FieldNames[1];
end;

procedure TCustomerJobRepairObj.JobCustomerSetUpCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not modified then exit;

  if dataset.state in [dsEdit,dsInsert] then else dataset.edit;
  if Empty(TwwDBLookupcombo(Sender).text) then begin
    if Dataset.findfield(JobIDField)         <> nil then Dataset.Fieldbyname(JobIDField).asInteger          := 0;
    if Dataset.findfield(jobnamefield)       <> nil then Dataset.Fieldbyname(jobnamefield).asString         := '';
  end else begin
    if Dataset.findfield(JobIDField)         <> nil then Dataset.Fieldbyname(JobIDField).asInteger          := Lookuptable.fieldbyname('ClientID').asInteger;
    if Dataset.findfield(jobnamefield)       <> nil then Dataset.Fieldbyname(jobnamefield).asString         := Lookuptable.fieldbyname('Company').asString;
    if Lookuptable.fieldbyname('DefaultClass').asstring <> '' then begin
      if Dataset.findfield(Classnamefield)   <> nil then Dataset.Fieldbyname(Classnamefield).asString       := Lookuptable.fieldbyname('DefaultClass').asString;
      if Dataset.findfield(classIDField)     <> nil then Dataset.Fieldbyname(classIDField).asInteger        := GetDeptID(Lookuptable.fieldbyname('DefaultClass').asString);
    end;
  end;
  clientID  := Lookuptable.fieldbyname('ClientID').asInteger;
  if Dataset.state in [dsEdit, dsInsert] then Dataset.Post;
  if Dataset.state =dsBrowse then Dataset.edit;
end;

procedure TCustomerJobRepairObj.RepairCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; Modified: boolean);
begin
  if not modified then exit;
  if Dataset.state =dsBrowse then Dataset.edit;
  if Dataset.findfield(RepairIDfield)        <> nil then Dataset.Fieldbyname(RepairIDfield).asInteger       := Lookuptable.fieldbyname('RepairID').asInteger;
  if Dataset.findfield(CustomerEquipIDField) <> nil then Dataset.Fieldbyname(CustomerEquipIDField).asInteger:= Lookuptable.fieldbyname('CustomerEquipmentID').asInteger;
  if Dataset.findfield(EquipmentNameField)    <> nil then Dataset.Fieldbyname(EquipmentNameField).asString    := Lookuptable.fieldbyname('EquipmentName').asString;
  if Dataset.state in [dsEdit, dsInsert] then Dataset.Post;
  if Dataset.state =dsBrowse then Dataset.edit;

  (*RepairID := Lookuptable.fieldbyname('RepairID').asInteger;*)
  if repairLookup.fieldbyname('ClientId').asInteger <> dataset.FieldByName(JobIDField).asInteger then begin
    if dataset.state in [dsEdit,dsinsert] then else dataset.edit;
    dataset.FieldByName(JobIDField).asInteger :=repairLookup.fieldbyname('ClientId').asInteger;
    dataset.FieldByName(JobnameField).asString :=getClientName(dataset.FieldByName(JobIDField).asInteger);
    if dataset.state in [dsEdit,dsinsert] then dataset.Post;
  end;

end;

procedure TCustomerJobRepairObj.rowchanged;
begin
  clientId := dataset.fieldbyname(JobIDField).asInteger;
end;

procedure TCustomerJobRepairObj.setClientID(const Value: Integer);
begin
if fiClientID = Value then exit;
  fiClientID := Value;
  if jobLookup.active then
    if TERPQuery(repairLookup).ParamByName('ClientID').asInteger <> value then begin
      TERPQuery(repairLookup).close;
      TERPQuery(repairLookup).ParamByName('ClientID').asInteger := Value;
      TERPQuery(repairLookup).ParamByName('xClientID').asInteger := Value;
      TERPQuery(repairLookup).open;
      With dataset do begin
        if findfield(RepairIdField) = nil then exit;
        if not active then Exit;
        if  fieldbyname(CustomerEquipIDField).asInteger <> 0 then
          if not TERPQuery(repairLookup).locate('repairID' , fieldbyname(RepairIdField).asInteger , []) then begin
              if state =dsBrowse then edit;
              RepairCombo.text := '';
              if findfield(RepairIDfield)        <> nil then Fieldbyname(RepairIDfield).asInteger       := 0;
              if findfield(CustomerEquipIDField) <> nil then Fieldbyname(CustomerEquipIDField).asInteger:= 0;
              if findfield(EquipmentNameField)    <> nil then Fieldbyname(EquipmentNameField).asString    :='';
              if state in [dsEdit, dsInsert] then Post;
              if state =dsBrowse then edit;
          end;
      end;
    end;
  if TERPQuery(repairLookup).Params.Parambyname('ClientID').asInteger<> value then begin
    if repairLookup.active then repairLookup.close;;
    TERPQuery(repairLookup).Params.Parambyname('ClientID').asInteger:= Value;
    TERPQuery(repairLookup).Params.Parambyname('xClientID').asInteger:= Value;
    TERPQuery(repairLookup).open;
  end;
end;

procedure TCustomerJobRepairObj.setRepairID(const Value: integer);
begin
  fiRepairID := Value;
  if dataset.active = False then exit;

  if TERPQuery(repairLookup).Params.Parambyname('ID').asInteger<>Value then begin
    if repairLookup.active then repairLookup.close;;
    TERPQuery(repairLookup).Params.Parambyname('ID').asInteger:= Value;
    TERPQuery(repairLookup).Params.Parambyname('repairID').asInteger:= Value;
    TERPQuery(repairLookup).open;
  end;
end;

procedure TCustomerJobRepairObj.SetUpRepair;
var
    strSQL  : String;
begin
      strSQL:= 'SELECT distinct '+
          ' RE.CustomerEquipmentID,E.EquipmentName,RE.RepairID, '+
          ' CE.Serialno,CE.Manufacture,CE.model,CE.Registration, '+
          ' CE.WarantyPeriod,CE.WarantyFinishDate,CE.UOMQty as Quantity , CE.UOM,CE.ClientID'+
          ' FROM tblEquipmentxRef AS RE '+
          ' inner join tblrepairs as R on R.RepairID = RE.repairID ' +
          ' Inner Join tblcustomerequip AS CE ON RE.CustomerEquipmentID = CE.id '+
          ' Inner Join tblequipment AS E ON CE.EquipmentID = E.EquipmentID '+
          ' Where  (RE.RepairID= :ID or :RepairID=0) and (CE.ClientID=:ClientID or :xClientID= 0)'+
          ' and ifnull(R.done,"F" ) = "F"';
      if repairLookup.active then repairLookup.close;;
      TERPQuery(repairLookup).SQL.Clear;
      TERPQuery(repairLookup).SQL.add(strSQL);
      TERPQuery(repairLookup).Params.Parambyname('ID').asInteger:= RepairID;
      TERPQuery(repairLookup).Params.Parambyname('repairID').asInteger:= RepairID;
      TERPQuery(repairLookup).Params.Parambyname('ClientID').asInteger:= ClientID;
      TERPQuery(repairLookup).Params.Parambyname('xClientID').asInteger:= ClientID;
      TERPQuery(repairLookup).open;
(*      grid.Addfield(EquipmentNameField);*)
end;

end.
