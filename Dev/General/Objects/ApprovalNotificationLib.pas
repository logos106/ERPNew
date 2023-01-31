unit ApprovalNotificationLib;

interface

uses
  BaseInputForm;

type
  TApprovalNotificationType = (anRequiresApproval,anApproved,anNotApproved,anCreated);

  TApprovalNotification = class(TObject)
  public
    class procedure Notify(aType: TApprovalNotificationType; aTransName,
      aGuiClassName, aDesc: string; aTransID, aToEmployeeID, aTransEmpID: integer;
      aTransDate: TDateTime; aGUI: TBaseInputGUI; ShowEmailSentMessage: boolean = false); overload;
    class procedure Notify(aGUI: TBaseInputGUI; ShowEmailSentMessage: boolean = false); overload;
  end;

implementation

uses
  BusObjEmployee, CommonLib, BusObjToDo, CorrespondenceObj, SysUtils,
  AppEnvironment, tcConst, Dialogs, ERPDbComponents, CommonDbLib, BusObjBase,
  DB;

{ TApprovalNotification }

class procedure TApprovalNotification.Notify(aType: TApprovalNotificationType;
  aTransName, aGuiClassName, aDesc: string; aTransID, aToEmployeeID, aTransEmpID: integer;
  aTransDate: TDateTime; aGUI: TBaseInputGUI; ShowEmailSentMessage: boolean);
var
  email: string;
  subject, body, link: string;
  ToDo: TToDo;
  cmd: TERPCommand;
  ToDoDeleteDesc: string;
begin
  ToDoDeleteDesc := '';
  email := TEmployee.EmailForEmployeeID(aToEmployeeID);

  case aType of
    anRequiresApproval:
      begin
        subject := aTransName + ' # ' + IntToStr(aTransID) + ' ' + APPROVALREQUESTDESC;
        body := 'The Following ' + aTransName + ' Requires Your Approval:' + #13#10;

      end;
    anApproved:
      begin
        subject := aTransName + ' # ' + IntToStr(aTransID) + ' ' + APPROVEDDESC;
        body := 'The Following ' + aTransName + ' Has Been Approved:' + #13#10;
        ToDoDeleteDesc := APPROVALREQUESTDESC;
      end;
    anNotApproved:
      begin
        subject := aTransName + ' # ' + IntToStr(aTransID) + ' ' + NOTAPPROVEDREMINDERDESC;
        body := 'The Following ' + aTransName + ' Has Not Been Approved:' + #13#10;
        ToDoDeleteDesc := APPROVALREQUESTDESC;
      end;
    anCreated:
      begin
        subject := aTransName + ' # ' + IntToStr(aTransID) + ' ' + HASBEENCREATEDDESC;
        body := 'The Following ' + aTransName + ' Has Been Created:' + #13#10;

      end;
  end;
  body := body + 'No: ' + IntToStr(aTransID) + #13#10;
  if aDesc <> '' then
    body := body + 'Description: ' + aDesc + #13#10;

  if AppEnv.CompanyPrefs.ErpApiEnabled then begin
    link := '<a href="http://'+'localhost'+':' +
      IntToStr(AppEnv.CompanyPrefs.ErpApiPort) +
      '/trueerp?OpenForm='+aGuiClassName+'&KeyID=' + IntToStr(aTransID) + '">'+aTransName+' '+IntToStr(aTransID)+'</a>';
    body := body +
      'Link: ' + link + #13#10;
  end;
  body := body +
    'Creation Date: ' + DateToStr(aTransDate) + #13#10 +
    'Employee: ' + TEmployee.IDToggle(aTransEmpID);

  if email <> '' then begin
    if ShowEmailSentMessage then begin
      CommonLib.MessageDlgXP_Vista('Sending Email to Employee ' +
         TEmployee.IDToggle(aToEmployeeID), mtInformation,[mbOk],0);
    end;
    TCorrespondenceGui.EmailEmployee(
      email,
      subject,
      body,
      aToEmployeeID,
      true, aGUI.MessageOption , aGUI.DoNotAskMsg ,aGUI.DoOnDoNotAskMsgCheck);
  end
  else begin
    CommonLib.MessageDlgXP_Vista('There is no Email Address configured for Employee ' +
       TEmployee.IDToggle(aToEmployeeID), mtInformation,[mbOk],0);
  end;


  ToDo := TToDo.CreateWithSharedConn(nil);
  try
    ToDo.New;
    ToDo.ToDoByDate := now;
    ToDo.Description := subject;
    ToDo.EmployeeID := aToEmployeeID;
    ToDo.LinkTo := aTransName;
    ToDo.LinkToID := aTransID;
    ToDo.Save;
  finally
    ToDo.Free;
  end;

  if ToDoDeleteDesc <> '' then begin
    cmd := TERPCommand.Create(nil);
    try
      cmd.Connection := CommonDBLib.GetSharedMyDacConnection;
      cmd.SQL.Add('update tblToDo set Completed = "T"');
      cmd.SQL.Add('where LinkTo = ' + QuotedStr(aTransName));
      cmd.SQL.Add('and LinkToID = ' + IntToStr(aTransID));
      cmd.SQL.Add('and Description like "%' + ToDoDeleteDesc+ '"');
      try
        cmd.Execute;
      except
        on e: exception do begin
          CommonLib.MessageDlgXP_Vista('Could not Flag the ToDo Items as Done.',mtInformation,[mbOk],0);
        end;
      end;
    finally
      cmd.Free;
    end;
  end;
end;

class procedure TApprovalNotification.Notify(aGUI: TBaseInputGUI; ShowEmailSentMessage: boolean);
var
  BusObj: TDatasetBusObj;
  x: integer;
  TransName: string;
  Desc: string;
  field: TField;
  ApproverID: integer;
  EmpID: integer;
  GuiClassName: string;
  Approved: boolean;
  TransDate: TDateTime;
begin
  BusObj := nil;
  for x := 0 to aGUI.ComponentCount - 1 do begin
    if aGUI.Components[x] is TDatasetBusObj then begin
      BusObj := TDatasetBusObj(aGUI.Components[x]);
      break;
    end;
  end;
  TransName := BusObj.BusObjectTypeDescription;

  Desc := '';
  field := BusObj.Dataset.FindField('SmartOrderDesc');
  if Assigned(Field) then
    Desc := Field.AsString
  else begin
    field := BusObj.Dataset.FindField('ClientPrintName');
    if Assigned(Field) then
      Desc := Field.AsString
    else begin

    end;
  end;
  field := BusObj.Dataset.FindField('ApproverID');
  if Assigned(field) then
    ApproverID := field.AsInteger
  else begin
    field := BusObj.Dataset.FindField('ApproverEmployeeID');
    if Assigned(field) then
      ApproverID := field.AsInteger;
  end;

  field := BusObj.Dataset.FindField('EmployeeID');
  if Assigned(field) then
    EmpID := field.AsInteger;

  field := BusObj.Dataset.FindField('Approved');
  if Assigned(field) then
    Approved := field.AsBoolean;

  field := BusObj.Dataset.FindField('OrderDate');
  if Assigned(field) then
    TransDate := field.AsDateTime
  else begin
    field := BusObj.Dataset.FindField('SateDate');
    if Assigned(field) then
      TransDate := field.AsDateTime
    else begin
      field := BusObj.Dataset.FindField('CreateDate');
      if Assigned(field) then
        TransDate := field.AsDateTime
      else
        field := BusObj.Dataset.FindField('CreationDate');
        if Assigned(field) then
          TransDate := field.AsDateTime
    end;
  end;


  GuiClassName := aGUI.ClassName;

  if AppEnv.Employee.EmployeeID = ApproverID then begin
    { this is approver sending back to creater }
    if Approved then begin
      TApprovalNotification.Notify(
        anApproved,
        BusObj.BusObjectTypeDescription,
        GuiClassName,
        Desc,
        BusObj.ID,
        EmpID,
        EmpID,
        TransDate,
        aGUI,
        ShowEmailSentMessage);
    end
    else begin
      { not approbed }
      TApprovalNotification.Notify(
        anNotApproved,
        BusObj.BusObjectTypeDescription,
        GuiClassName,
        Desc,
        BusObj.ID,
        EmpID,
        EmpID,
        TransDate,
        aGUI,
        ShowEmailSentMessage);
    end;

  end
  else begin
    { creater sending to approver }
    TApprovalNotification.Notify(
      anRequiresApproval,
      BusObj.BusObjectTypeDescription,
      GuiClassName,
      Desc,
      BusObj.ID,
      ApproverID,
      EmpID,
      TransDate,
      aGUI,
      ShowEmailSentMessage);
  end;
end;

end.
