unit AppointmentLib;

interface

procedure NewAppointment(const ClientID: Integer; const Source: TObject; const RepairID: Integer;
  Notes: String = ''; const EmployeeID: Integer = 0);

implementation

uses MessageInterface, classes, sysutils, CommonLib, dialogs, AppContextObj,
  frmAppointments, forms, frmCalendar, frmRepairs;

procedure NewAppointment(const ClientID: Integer; const Source: TObject; const RepairID: Integer;
  Notes: String = ''; const EmployeeID: Integer = 0);
var
//  NewAppointment: TComponent;
//  MsgObj: TMsgObj;
//  fMsgHandler: TMsgHandler;

  AppForm: TAppointmentGUI;
  empId: integer;
  selDate: TDateTime;
begin
  if OpenCalenderAndSelectDate(empId,selDate) then begin

    AppForm := TAppointmentGUI(GetComponentByClassName('TAppointmentGUI',false));
    If not Assigned(AppForm) then Exit;
    AppForm.InitialClientId := ClientID;
    AppForm.InitialRepairID := RepairID;
    AppForm.InitialNotes := Notes;
    AppForm.InitialEmployeeID := empId;//EmployeeID;
    AppForm.InitialDate := selDate;
    AppForm.InitialStartTime := selDate;
    if Source is TRepairsGUI then
      AppForm.InitialInitCustomerDetails := TRepairsGUI(Source).tblMasterCustomerDetails.Text;

    AppForm.FormStyle := fsMDIChild;
    AppForm.BringToFront;
  end;


//  fMsgHandler := TMsgHandler.Create(Source);
//  try
//    MsgObj := TMsgObj.Create;
//    Try
//      MsgObj.SetAddress('TAppointmentGUI', 'CloseIfOpen');
//      if fMsgHandler.Send(MsgObj, MsgObj) then begin
//        Exit;
//      end;
//    Finally
//      FreeAndNil(MsgObj);
//    End;
//
//    Appcontext['Calenderform'].Varbyname['showing'] := 'T';
//    MsgObj := TMsgObj.Create;
//    Try
//      MsgObj.SetAddress('TCalendarGUI', 'IsPlacingAppointment');
//      if fMsgHandler.Send(MsgObj, MsgObj) then begin
//        CommonLib.MessageDlgXP_Vista('The last appointment has not been made. Please make it now.',
//          mtInformation, [mbOK], 0);
//        Exit;
//      end;
//    Finally
//      FreeAndNil(MsgObj);
//    End;
//
//    NewAppointment := GetComponentByClassName('TNewAppointment', False);
//    // NewAppointment.Name := GetUniqueName(NewAppointment.ClassName);
//    NewAppointment.Name := NewAppointment.ClassName + '_' + IntToStr(Integer(NewAppointment));
//    if Assigned(NewAppointment) then begin
//
//      MsgObj := TMsgObj.Create;
//      MsgObj.SetAddress('TNewAppointment', 'ClientID', NewAppointment.Name);
//      MsgObj.IntValue := ClientID;
//      fMsgHandler.Send(MsgObj, MsgObj);
//
//      MsgObj.SetAddress('TNewAppointment', 'RepairId', NewAppointment.Name);
//      MsgObj.IntValue := RepairID;
//      fMsgHandler.Send(MsgObj, MsgObj);
//
//      MsgObj.SetAddress('TNewAppointment', 'Note', NewAppointment.Name);
//      MsgObj.StrValue := Notes;
//      fMsgHandler.Send(MsgObj, MsgObj);
//
//      MsgObj.SetAddress('TNewAppointment', 'EmployeeId', NewAppointment.Name);
//      MsgObj.IntValue := EmployeeID;
//      fMsgHandler.Send(MsgObj, MsgObj);
//
//      MsgObj.MethodStr := 'CreateNewAppointment';
//      MsgObj.BoolValue := False; // appointment not required
//      fMsgHandler.Send(MsgObj);
//
//    end;
//  finally
//    FreeAndNil(fMsgHandler);
//  end;
end;

end.
