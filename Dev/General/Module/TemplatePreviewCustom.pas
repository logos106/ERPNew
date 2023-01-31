{
binny :
When template reports are printed for multiple records inside a loop
this provides an additionion button on the preview bar of the report template to cancel printing and terminate teh loop in between
To use it
  before loop begin Set PrintTemplate.CancelPreviewAll to False
  inside loop,
    PrintTemplateReport(...,...,..,.,.,. True for ShowCancelPreviewBtninReportPreview)
    if PrintTemplate.CancelPreviewAll then exit;
}
unit TemplatePreviewCustom;

interface

uses
  ppPreview,
  ppTBX,
  ppToolResources,
  Dialogs;

type

  TTemplatePreviewCustomOptions = class(TppPreview)
  private
    FNewButton: TppTBXItem;
  protected
    procedure CreateToolbarItems; override;
  public
    property NewButton: TppTBXItem read FNewButton;
  end;


implementation

{------------------------------------------------------------------------------}

procedure TTemplatePreviewCustomOptions.CreateToolbarItems;
begin
  inherited;

  Toolbar.BeginUpdate;
  Toolbar.AddSeparator();
  FNewButton := Toolbar.AddButton();
  FNewButton.Caption:= 'Cancel All';
  FNewButton.Tag := 0; // this tag is set to 99 when clicked
  FNewButton.name := 'btnCancelPreviewAll';
  FNewButton.visible:= False;
  Toolbar.EndUpdate;
end;

initialization
  TppPreviewPlugIn.Register(TTemplatePreviewCustomOptions);

finalization
  TppPreviewPlugIn.UnRegister(TTemplatePreviewCustomOptions);

end.

