unit frmWorkflowhint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmWorkflowPlayPointer, ExtCtrls, StdCtrls, pngimage, Menus, GIFImg;

type
  TfmWorkflowhint = class(TfmWorkflowPlayPointer)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
  Protected
    procedure setWorkflowMsg(Value: String);Override;
  public
  end;
implementation

{$R *.dfm}

procedure TfmWorkflowhint.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmWorkflowhint.FormCreate(Sender: TObject);
begin
  inherited;
  //Spacing:='';
end;

procedure TfmWorkflowhint.setWorkflowMsg(Value: String);
begin
  inherited;
end;

end.

