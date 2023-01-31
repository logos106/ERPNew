unit EmailExtraUtils;
interface
uses
  Dialogs, Controls, ERPDbComponents, classes, TaskDialog;

type
  TSendEmailMode = (smNone,
    smSend,             // send as configured - for Email Client
    smSendEdit,         // Select Reference
    smSilent,           // Use Secret, No edit
    smSilentEdit        // Use secret, reference
    );

  TEmailIntegrationType = (eiNone, eiClient, eiServer);

  function EmailSendMode(ACount : integer; const aButtons : boolean = true;fiMsgOption:Integer=104;ShowDoNotAsk:Boolean=False;fDoOnDoNotAsk :TTaskDialogVerifyClickEvent=nil) : TSendEmailMode;
  function PrepareMailText(aMode: TSendEmailMode; const aDefaultText : string): string;
  function CheckEmailAddresses(qry : TERPQuery; const AName : string; const ANameField, AEmailField : string) : integer;
  function EmailSilentSecret(ACount : integer; const AButtons : boolean;  var aSilent, aSecret : boolean) : boolean;
  function EmailIntegrationType : TEmailIntegrationType;
  function EmailShortSendMode(var aSilent, aSecret : boolean;fMessageOption:Integer = 104;fDoNotAskMsg:Boolean = False; fDoOnDoNotAsk :TTaskDialogVerifyClickEvent=nil) : boolean;

implementation

uses
  SystemLib, SysUtils,
  BusObjEmailConfig, AppEnvironment, CommonLib, frmEmailReferenceTask, tcConst, Vista_MessageDlg;

function EmailSendMode(ACount : integer; const aButtons : boolean = true;fiMsgOption:Integer=104;ShowDoNotAsk:Boolean=False; fDoOnDoNotAsk :TTaskDialogVerifyClickEvent=nil) : TSendEmailMode;
var
  lEmailConfig : TEmailConfig;
  lCount : integer;
  Procedure saveMsgOption;
  var
    MessageDlgXP_VistaOption : TMessageDlgXP_VistaOption;
  begin
     if not Assigned(fDoOnDoNotAsk) then exit;
     MessageDlgXP_VistaOption := TMessageDlgXP_VistaOption.create;
     try
       MessageDlgXP_VistaOption.MsgOption := lcount;
       fDoOnDoNotAsk(MessageDlgXP_VistaOption , False);
     finally
       Freeandnil(MessageDlgXP_VistaOption);
     end;
  end;
  function InttoSMMode(const Value:Integer):TSendEmailMode;
  begin
    Result := smNone;
          case Value  of
            {myes}    100 : Result := smSend;
            {mrNo}    101 : Result := smSendEdit;
            {mrOK}    102 : Result := smSilent;
            {mrRetry} 103 : Result := smSilentEdit;
            {mrIgnore}104 : Result := smNone;
          end;
  end;
begin

  Result := InttoSMMode(fiMsgOption);
  if (fiMsgOption <> 0) and (Result <>  smNone) and (ShowDoNotAsk) then begin
          case fiMsgOption  of
            {myes}    100 : Result := smSend;
            {mrNo}    101 : Result := smSendEdit;
            {mrOK}    102 : Result := smSilent;
            {mrRetry} 103 : Result := smSilentEdit;
            {mrIgnore}104 : Result := smNone;
          end;
          Exit;
  end;
    //ShowDoNotAsk := Assigned( fDoOnDoNotAsk);
      lEmailConfig := TEmailConfig.CreateWithSharedConn(nil);
      if AppEnv.Employee.UseEmpEmailAsFromAddress then
        lEmailConfig.LoadSelect('EntityName = ' + QuotedStr(AppEnv.Employee.EmployeeName))
      else
        lEmailConfig.LoadSelect('EntityName = "Company"');
      try
        if SameText(lEmailConfig.IntegrationType, 'Email Client') or SameText(lEmailConfig.IntegrationType, 'Server')  then begin
          if AButtons then begin
            if aCount > 1 then
              lCount := (*MessageDlgXPEx*)MessageDlgXP_Vista('The Program Set Up To Use Your Local Email Client. It Means You Will Get ' + IntToStr(aCount) +
                                 ' Email Pop-Ups.'+NL+NL+'Do You Want To', mtWarning,
                                  //[mbYes, mbNo, mbOk, mbRetry, mbIgnore],
                                  [],  0, nil, '' , 'Do Not Show Again' , ShowDoNotAsk, fDoOnDoNotAsk, 'Send,Edit && Send,Silent,Edit && Silent,Cancel'  )
            else
              lCount := (*MessageDlgXPEx*)MessageDlgXP_Vista('The Program Set Up To Use Your Local Email Client. It Means You Will Get' +
                                 ' Email Pop-Up.'+NL+NL+'Do You Want To', mtWarning,
                                  //[mbYes, mbNo, mbOk, mbRetry, mbIgnore],
                                  [],  0, nil, '' ,  'Do Not Show Again' , ShowDoNotAsk, fDoOnDoNotAsk, 'Send,Edit && Send,Silent,Edit && Silent,Cancel');
          saveMsgOption;
          case lCount  of
            {myes}    100 : Result := smSend;
            {mrNo}    101 : Result := smSendEdit;
            {mrOK}    102 : Result := smSilent;
            {mrRetry} 103 : Result := smSilentEdit;
            {mrIgnore}104 : Result := smNone;
          end;
          end else begin
            lCount := (*MessageDlgXPEx*)MessageDlgXP_Vista('TrueERP is Set Up to Use Your Local Email Program.'+NL+NL+'If You Select "Send" You will get a Email '+
                               'Pop-up Per Transaction/Client.'+NL+NL+'If You Select "Silent" Nothing will Show and All Emails will be Sent in the Background.',
                                mtWarning,
                                //[mbYes, mbOk, mbIgnore],
                                [],  0, nil, '' , 'Do Not Show Again' , (*ShowDoNotAsk*)False, fDoOnDoNotAsk, 'Send,Silent,Cancel');
          saveMsgOption;
          case lCount  of
            {myes}    100 : Result := smSend;
            {mrNo}    101 : Result := smSilent;
            {mrRetry} 102 : Result := smNone;
          end;
          end;
        end
        else
        begin
          if AButtons then
          begin
            lCount := MessageDlgXP_Vista('Do You Want To Edit Email Or Send It As It Is?', mtWarning,
                                 //[mbOk, mbNo, mbCancel],
                                 [],  0, nil, '' ,  'Do Not Show Again' , (*ShowDoNotAsk*)False, fDoOnDoNotAsk, 'Send,Edit,Cancel');
            saveMsgOption;
            case lCount of
              100 : Result := smSilent;
              101 : Result := smSilentEdit;
              102 : Result := smNone;
            end;
          end
          else
            Result := smSilent;
        end;
      finally
        lEmailConfig.Free;
      end;
end;

function PrepareMailText(aMode: TSendEmailMode; const aDefaultText : string): string;
var
  Form : TfmEmailReferenceTask;
begin
  case aMode of
    smSend: begin  // Send without editing - default mail text
       Result := aDefaultText;
      end;
    smSilentEdit,
    smSendEdit: begin  // Select Reference
      form := TfmEmailReferenceTask.Create(nil);
      try
        if Form.ShowModal=mrOk then
        begin
          Result := Form.EmailTemplate;
        end;
      finally
        form.Free;
      end;
      end;
    smSilent: begin
        Result := '';
      end;
  end;
end;

function CheckEmailAddresses(qry : TERPQuery; const AName : string; const ANameField, AEmailField : string) : integer;
var
 s : string;
begin
  qry.First;
  Result := 0;
  s := '';
  while not qry.Eof do
  begin
    if qry.FieldByName(AEmailField).AsString = '' then
    begin
      if s = '' then
        s := qry.FieldByName(ANameField).AsString
      else
        s := s + ', ' + qry.FieldByName(ANameField).AsString;
    end
    else
      Result := Result + 1;
    qry.Next;
  end;

//  if qry.recordcount =0 then
  if Result = 0 then
  begin
    MessageDlgXP_Vista('None of The ' + AName + ' Has Email Address Provided', mtWarning, [mbOK], 0);
    Exit;
  end;

  if s <> '' then
    MessageDlgXP_Vista('Following ' + AName + 's:'+NL+  s + NL+'Do Not Have Email Provided', mtWarning, [mbOk], 0);

end;

function EmailSilentSecret(ACount : integer; const AButtons : boolean;  var aSilent, aSecret : boolean) : boolean;
begin
  Result := true;
  case EmailSendMode(ACount, AButtons) of
    smNone: begin
      Result := false;
      Exit;
      end;
    smSend: begin
      aSilent := AButtons; // if buttons disabled, then not silent. This is for the shipping container
      aSecret := false;
      end;
    smSendEdit: begin
      aSilent := false;
      aSecret := false;
      end;
    smSilent: begin
      aSilent := true;
      aSecret := true;
      end;
    smSilentEdit: begin
      aSilent := false;
      aSecret := true;
      end;
    end;
end;

function EmailIntegrationType : TEmailIntegrationType;
var
  lConfig : TEmailConfig;
begin
 lConfig := TEmailConfig.CreateWithSharedConn(nil);
 try
   if AppEnv.Employee.UseEmpEmailAsFromAddress then
     lConfig.LoadSelect('EntityName = ' + QuotedStr(AppEnv.Employee.EmployeeName))
   else
     lConfig.LoadSelect('EntityName = "Company"');
   if lConfig.IntegrationType = '' then
     Result := eiNone
   else if SameText(lConfig.IntegrationType, 'Email Client') then
     Result := eiClient
   else
     Result := eiServer;
 finally
   lConfig.Free;
 end;

end;

function EmailShortSendMode(var aSilent, aSecret : boolean;fMessageOption:Integer = 104;fDoNotAskMsg:Boolean = False; fDoOnDoNotAsk :TTaskDialogVerifyClickEvent=nil) : boolean;
begin
  Result := true;
  case EmailIntegrationType() of
    eiNone : begin
      ASecret := false;
      ASilent := false;
    end;
    eiClient,eiServer : begin
      if fDoNotAskMsg then begin
            ASecret := true;
            ASilent := true;
      end else
        case EmailSendMode(1, false, fMessageOption, true , fDoOnDoNotAsk) of
          smSilent : begin
            ASecret := true;
            ASilent := true;
          end;
          smSend : begin
            ASecret := false;
            ASilent := false;
          end;
          smNone : Result := false;
        end;
    end;
    (*eiServer : begin
      ASecret := true;
      ASilent := true;
    end;*)
  end;
end;

end.
