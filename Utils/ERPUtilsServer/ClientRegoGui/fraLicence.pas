unit fraLicence;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fraTreeFrameBase, JsonObject, StdCtrls, wwdbdatetimepicker, ExtCtrls,
  AdvEdit, DBAdvEd;

type
  TfrLicence = class(TfrTreeFrameBase)
    edtName: TEdit;
    lblID: TLabel;
    chkActive: TCheckBox;
    dtStartDate: TwwDBDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    dtExpireDate: TwwDBDateTimePicker;
    Label3: TLabel;
    cboStatus: TComboBox;
    edtUsers: TAdvEdit;
    Label4: TLabel;
    Label5: TLabel;
    edtStatusReason: TEdit;
    Label6: TLabel;
    edtNotes: TEdit;
  private
  protected
    procedure SetData(const Value: TJsonObject); override;
  public
  end;

var
  frLicence: TfrLicence;

implementation

{$R *.dfm}

{ TfrLicence }

procedure TfrLicence.SetData(const Value: TJsonObject);
begin
  inherited;
  Bindings.AddBinding('softwarename',valString,edtName);
  //Bindings.AddBinding('notes',valString,edtNotes);
  Bindings.AddBinding('active',valBoolean,chkActive);
  Bindings.AddBinding('id',valNumber,lblID);
  Bindings.AddBinding('startdate',valNumber,dtStartDate);
  Bindings.AddBinding('expiredate',valNumber,dtExpireDate);
  Bindings.AddBinding('status',valString,cboStatus);
  Bindings.AddBinding('concurrentusers',valNumber,edtUsers);
  Bindings.AddBinding('statusreason',valString,edtStatusReason);
  Bindings.AddBinding('notes',valString,edtNotes);
end;

end.
