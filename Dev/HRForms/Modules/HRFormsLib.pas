unit HRFormsLib;

interface

uses BusObjHRForms ,classes, IntegerListObj, wwdbgrid, BaseFormForm,
  BusObjEmployeeHRForms, BusObjclientHRForms, BusObjBase;

Type
  TOutputtype = (otPrint =1 , otPreview = 2, otEmail = 3);

  TPrintHRForm   = class(TComponent)
  Private
    fHRFormObj: THRForms;
    fiHRFormID: Integer;
    fIds :TIntegerList;
    fEmployeeHrForms :TEmployeeHrForms;
    fClientHrForms :TClientHrForms;
    fiId: Integer;
    fOutputtype: TOutputtype;

    function getHRFormObj: THRForms;
    function getHRFormID: Integer;
    function ChooseCustomers: Boolean;
    function ChooseEmployees: Boolean;
    procedure SelectCustomers(Sender: twwdbgrid);
    procedure SelectEmployee(Sender: twwdbgrid);
    function EmployeeHrForms :TEmployeeHrForms;
    function ClientHrForms :TClientHrForms;
    procedure PrintTemplateCallback(const Sender: TBusObj; var Abort: Boolean);
    procedure PrintDoc;
    function doEmail: Boolean;
    function doPreview: Boolean;
    function doPrint: Boolean;
  Protected

  Public
    Constructor Create(AOwner:TComponent);Overload;Override;
    Constructor Create(AOwner:TComponent; aIds : TIntegerList;aID:Integer);reintroduce;Overload;
    destructor Destroy;Override;
    Property HRFormObj: THRForms read getHRFormObj write fHRFormObj;
    Property HRFormID : Integer read getHRFormID write fiHRFormID;
    class Procedure PrintTemplate(const ID:Integer;AOwner:TBaseForm;aHRFormObj: THRForms; aHRFormID:Integer; aOutputtype : TOutputtype); Overload;
    class Procedure PrintTemplate(const ID:Integer;AOwner:TBaseForm;aId:Integer; aHRIds :TIntegerList; aOutputtype :TOutputtype); Overload;
    Procedure PrintTemplate;Overload;
    Function PrintIt(aID:Integer):Boolean;
    Property Id :Integer read fiId write fiId;
    Property Outputtype : TOutputtype read fOutputtype write fOutputtype;
  end;
implementation

uses BaseInputForm, BaseListingForm, sysutils, AppEnvironment, CommonLib, CommonFormLib,
  TemplateReportsLib, CorrespondenceObj, tcDataUtils , Windows, dialogs,
  BusObjPrintDoc;

{ TPrintHRForm }


constructor TPrintHRForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fHRFormObj:= nil;
  fIds := TIntegerList.create;
  fEmployeeHrForms :=nil;
  fClientHrForms :=nil;
  Id:= 0;
end;
constructor TPrintHRForm.Create(AOwner: TComponent; aIds: TIntegerList;aId:Integer);
begin
  Create(AOwner);
  fIds.add(aId);
  fHRFormObj:= THRForms.CreateWithNewConn(Self);
  fHRFormObj.loadselect('Id in ( '+ aIds.CommaText+')' );
end;

destructor TPrintHRForm.destroy;
begin
  freeandnil(fIds);
  inherited;
end;


function TPrintHRForm.getHRFormID: Integer;
begin
  Result := fiHRFormID;
  if result = 0 then
      if fHRFormObj <>  nil then result := fHRFormObj.ID;
end;

function TPrintHRForm.getHRFormObj: THRForms;
begin
  if fHRFormObj = nil then begin
    fHRFormObj:= THRForms.CreateWithNewConn(Self);
    fHRFormObj.load(HRFormID);
  end;
  Result := fHRFormObj;
end;

Class procedure TPrintHRForm.PrintTemplate(const ID:Integer;AOwner:TBaseForm;aHRFormObj: THRForms; aHRFormID:Integer; aOutputtype :TOutputtype);
var
  PrintHRForm : TPrintHRForm;
begin
  PrintHRForm := TPrintHRForm.create(AOwner);
  try
    if aHRFormObj <> nil then PrintHRForm.HRFormObj := aHRFormObj;
    if aHRFormID  <> 0   then PrintHRForm.HRFormID := aHRFormId;
    PrintHRForm.Id := ID;
    PrintHRForm.Outputtype := aOutputtype;
    PrintHRForm.PrintTemplate;
  finally
    Freeandnil(PrintHRForm);
  end;
end;
class procedure TPrintHRForm.PrintTemplate(const ID:Integer;AOwner: TBaseForm;aId: Integer; aHRIds: TIntegerList; aOutputtype : TOutputtype);
var
  PrintHRForm : TPrintHRForm;
begin
  PrintHRForm := TPrintHRForm.create(AOwner , aHRIds , aId);
  try
    PrintHRForm.Id := ID;
    PrintHRForm.Outputtype := aOutputtype;
    PrintHRForm.PrintTemplate;
  finally
    Freeandnil(PrintHRForm);
  end;

end;

procedure TPrintHRForm.PrintTemplate;
begin
  if HRFormObj.Count =0 then exit;
  HRFormObj.Iteraterecords(PrintTemplateCallback);
  fIds.clear;
end;

procedure TPrintHRForm.PrintTemplateCallback(const Sender: TBusObj; var Abort: Boolean);
var
  ctr:Integer;
  SavedPrintDialogPref:Boolean;
begin
  inherited;
  if not Assigned(Owner) then exit;
  if not (Owner is TBaseInputGUI) and not(Owner is TBaseListingGUI)  then exit;


    try
      if fIds.count =0 then begin
        if  HRFormObj.formtype ='E' then         if not ChooseEmployees then exit;
        if  HRFormObj.formtype ='C' then         if not ChooseCustomers then exit;
      end;
      if fIds.count =0 then exit;

      SavedPrintDialogPref := AppEnv.Employee.ShowPrintDialog;
      try
        EmployeeHrForms ;
        ClientHrForms   ;
        try
          EmployeeHrForms.connection.begintransaction;
          ClientHrForms.connection := EmployeeHrForms.connection;
          try

            for ctr := 0 to fIds.count-1 do begin
              if not Printit(fids[ctr] ) then break;
              AppEnv.Employee.ShowPrintDialog := False;
            end;
            EmployeeHrForms.connection.CommitTransaction;
          Except
            on E:Exception do begin
              EmployeeHrForms.connection.RollbackTransaction;
            end;
          end;
        finally
          Freeandnil(fClientHrForms);
          Freeandnil(fEmployeeHrForms);
        end;
      finally
        AppEnv.Employee.ShowPrintDialog:= SavedPrintDialogPref;
      end;
    finally
      //fIds.clear;
    end;
end;

(*procedure TPrintHRForm.PrintformID(aDoPrint: Boolean);
var
  SavedPrintDialogPref:Boolean;
  ctr:Integer;
begin
      if fIds.count =0 then exit;

      SavedPrintDialogPref := AppEnv.Employee.ShowPrintDialog;
      try
        EmployeeHrForms ;
        ClientHrForms   ;
        try
          EmployeeHrForms.connection.begintransaction;
          ClientHrForms.connection := EmployeeHrForms.connection;
          try
            EmployeeHrForms.Load(0);
            ClientHrForms.Load(0);
            for ctr := 0 to fIds.count-1 do begin
              Printit(fids[tr]);
              AppEnv.Employee.ShowPrintDialog := False;
            end;
            EmployeeHrForms.connection.CommitTransaction;
          Except
            on E:Exception do begin
              EmployeeHrForms.connection.RollbackTransaction;
            end;
          end;
        finally
          Freeandnil(fClientHrForms);
          Freeandnil(fEmployeeHrForms);
        end;
      finally
        AppEnv.Employee.ShowPrintDialog:= SavedPrintDialogPref;
      end;
    finally
      fIds.clear;
    end;

end;*)

Function TPrintHRForm.PrintIt(aID: Integer):Boolean ;
var
  s:String;
  Corres: TCorrespondenceGui;
  OutGoingFileName:String;
begin
            result := TRue;
      if Id =0 then begin
                s:= companyInfoSQL('companyInfo') + '~|||~{Details}';
                if  HRFormObj.formtype ='E' then         s:= s + 'Select * from tblEmployees where ' + HRFormObj.SQLPortion[aID];
                if  HRFormObj.formtype ='C' then         s:= s + 'Select * from tblclients   where ' + HRFormObj.SQLPortion[aID];
                if owner is TBaseInputGUI then begin
                  TBaseInputGUI(Owner).fbReportSQLSupplied := true;

                  TBaseInputGUI(Owner).SaveTemplateReport(HRFormObj.Template   , s , DoPrint , 'PDF','EmailReport' (*, Json*));
                  if not doEmail then TBaseInputGUI(Owner).PrintTemplateReport(HRFormObj.Template   , s , DoPrint , 1, nil , '' , True);

                  if TBaseInputGUI(Owner).CancelPreviewAll then Result := false;
                end else if owner is TBaseListingGUI then begin
                  TBaseListingGUI(Owner).ReportSQLSupplied := True;
                  TBaseListingGUI(Owner).SaveTemplateReport (HRFormObj.Template , s , DoPrint , 'PDF','EmailReport' (*, Json*));
                  if not doEmail then TBaseListingGUI(Owner).PrintTemplateReport(HRFormObj.Template , s , DoPrint , 1, nil ,'', True);
                  if TBaseListingGUI(Owner).CancelPreviewAll then Result := false;
                end;


                   OutGoingFileName := getOutGoingFileName('',' ' + HRFormObj.FormName + ' #' + inttostr(aid), '.PDF');
                    if not FileExists(Commonlib.TempDir +  'EmailReport.PDF') then begin
                      CommonLib.MessageDlgXP_Vista('Can''t Find Attachment'+#13+#10+#13+#10+'Email Failed !', mtWarning, [mbOK], 0);
                      Exit;
                    end;
                if  HRFormObj.formtype ='E'  then begin
                    EmployeeHrForms.New;
                    EmployeeHrForms.EmployeeId  := aID;
                    EmployeeHrForms.HRformID    := HRFormObj.Id;
                    EmployeeHrForms.HRFormname  := HRFormObj.FormName;
                    EmployeeHrForms.TemplateName:= HRFormObj.Template;
                    EmployeeHrForms.PostDB;
                end else if  HRFormObj.formtype ='C'  then begin
                    ClientHrForms.New;
                    ClientHrForms.ClientId    := aID;
                    ClientHrForms.HRformID    := HRFormObj.Id;
                    ClientHrForms.HRFormname  := HRFormObj.FormName;
                    ClientHrForms.TemplateName:= HRFormObj.Template;
                    ClientHrForms.PostDB;
                end;
                    Corres := TCorrespondenceGui.Create;
                    try
                                    Corres.Clear;
                                    if  HRFormObj.formtype ='C' then Corres.CustomerId := aid;
                                    if  HRFormObj.formtype ='E' then Corres.EmployeeId := aID;
                                    Corres.Subject := HRFormObj.FormName;
                                    Corres.RecipientType := rtHrform;
                                    if doEmail then Corres.CorrespondenceType := ctEmail else Corres.CorrespondenceType := ctHRForm;


                                    if  HRFormObj.formtype ='C' then Corres.RecipientList := clientemail(aId);
                                    if  HRFormObj.formtype ='E' then Corres.RecipientList := getEmployeeEmail(aId);

                                     if  HRFormObj.formtype ='E'  then begin
                                        Corres.HRFormId := EmployeeHrForms.Id;
                                    end else if  HRFormObj.formtype ='C'  then begin
                                        Corres.HRFormId := ClientHrForms.ID;
                                    end;

                                    Corres.MessageText := HRFormObj.FormName + ' has been sent to you from ' +GetCompanyName;
                                    Copyfile(PChar(Commonlib.TempDir + 'EmailReport.PDF'), PChar(Commonlib.TempDir  + OutGoingFileName), false);
                                    Corres.REferenceDatafile:= Commonlib.TempDir  + OutGoingFileName;
                                    result := Corres.Execute();
                    finally
                      Corres.Free;
                    end;


      end else begin
        if  HRFormObj.formtype ='E'  then begin
            EmployeeHrForms.Load(ID);
        end else if  HRFormObj.formtype ='C'  then begin
            ClientHrForms.Load(ID);
        end;

      end;
      PrintDoc;
end;

function TPrintHRForm.doPrint   :Boolean;   begin    result := Outputtype= otPrint  ;  end;
function TPrintHRForm.doPreview :Boolean;   begin    result := Outputtype= otPreview;  end;
function TPrintHRForm.doEmail   :Boolean;   begin    result := Outputtype= otEmail  ;  end;


Procedure TPrintHRForm.PrintDoc;
var
  fPrintDoc : TBusObjPrintDoc;
  Function PrintedFrom :String;begin  result :='';  if Assigned(Owner) then    Result := Owner.ClassName;end;
  Function DocumentOutputtype :TdocumentOutputtype;
  begin
      result := dotPreview;
           if doEmail then result := dotEmail
      else if doPrint then result := dotPrint
      else if doPreview then result := dotPreview;
  end;
begin
  fPrintDoc := TBusObjPrintDoc.Create(self);
  Try
        if  HRFormObj.formtype ='E'  then begin
            fPrintDoc.Printdoc(EmployeeHrForms.Classname,   EmployeeHrForms.ID, dtMain, PrintedFrom ,DocumentOutputtype , HRFormObj.Template);
        end else if  HRFormObj.formtype ='C'  then begin
            fPrintDoc.Printdoc(ClientHrForms.Classname,   ClientHrForms.ID, dtMain, PrintedFrom ,DocumentOutputtype , HRFormObj.Template);
        end;

  finally
    Freeandnil(fPrintDoc);
  end;

end;

function TPrintHRForm.ChooseCustomers: Boolean;begin  OpenERPListFormultiselectModal('TCustomerExpressListGUI' , nil, SelectCustomers);  result :=  fIds.count >0;end;
function TPrintHRForm.ChooseEmployees: Boolean;begin  OpenERPListFormultiselectModal('TEmployeeExpresslistGUI' , nil, SelectEmployee );  result :=  fIds.count >0;end;
Procedure TPrintHRForm.SelectEmployee (Sender: twwdbgrid);begin  CommonLib.SelectedIDs(TBaseListingGUI(Sender.Owner).grdMain, 'employeeID' ,fIds, true);end;
Procedure TPrintHRForm.SelectCustomers(Sender: twwdbgrid);begin  CommonLib.SelectedIDs(TBaseListingGUI(Sender.Owner).grdmain, 'clientID'    ,fIds, true);end;
function TPrintHRForm.EmployeeHrForms: TEmployeeHrForms;
begin
  if fEmployeeHrForms = nil then begin
    fEmployeeHrForms := TEmployeeHrForms.CreateWithNewConn(Self);
    fEmployeeHrForms.Load(0);
  end;
  result := fEmployeeHrForms;
end;

function TPrintHRForm.ClientHrForms: TClientHrForms;
begin
  if fClientHrForms = nil then begin
    fClientHrForms := TClientHrForms.Create(Self);
    fClientHrForms.Connection := employeeHrForms.Connection;
    fClientHrForms.Load(0);
  end;
  result := fClientHrForms;

end;


end.
