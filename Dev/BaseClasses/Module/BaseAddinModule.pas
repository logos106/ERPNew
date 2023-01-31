unit BaseAddinModule;
  { Create (inherit) an AddinModule for each main area of application
    functionality eg Manufacturing, Payroll and use it to declare and
    register Global Event handlers for that area.
    Create and Destroy each Addin Module in the units Initialization and
    Finalization sections}


interface

uses
  SysUtils, Classes;

type
  TdmBaseAddinModule = class(TDataModule)
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    // example Global Event handler
    //procedure BaseTransCreateHandler(Sender: TObject; EventName: string; Data: pointer);
  public
    { Public declarations }
  end;

var
  dmBaseAddinModule: TdmBaseAddinModule;

implementation

{$R *.dfm}

uses GlobalEventsObj;

procedure TdmBaseAddinModule.DataModuleCreate(Sender: TObject);
begin
  // Example registration of Global Event handler
  // GlobalEvents.RegisterNameHandler(Self,'TQuoteGUI','',GEVENT_FormCreate,BaseTransCreateHandler);
end;

procedure TdmBaseAddinModule.DataModuleDestroy(Sender: TObject);
begin
  // DeRegister any global event handlers registerd by children
  GlobalEvents.DeregisterHandlers(Self);
end;

end.
