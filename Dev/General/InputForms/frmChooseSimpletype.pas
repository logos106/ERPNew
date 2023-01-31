unit frmChooseSimpletype;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, Menus, ExtCtrls, StdCtrls, DBCtrls,
  Shader, DNMPanel, DNMSpeedButton, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ProgressDialog, ImgList, AdvMenus, DataState, AppEvnts;

type
  TfmChooseSimpletype = class(TBaseInputGUI)
    pnldescription: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel4: TDNMPanel;
    lblName: TLabel;
    lblDescription: TLabel;
    cmdOk: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    cboname: TComboBox;
    memDescription: TMemo;
    qrySimpleTypes: TERPQuery;
    qrySimpleTypesName: TWideStringField;
    qrySimpleTypesDescription: TWideStringField;
    qrySimpleTypesIsDefault: TWideStringField;
    qrySimpleTypesActive: TWideStringField;
    qrySimpleTypesGlobalRef: TWideStringField;
    qrySimpleTypesId: TIntegerField;
    qrySimpleTypesTypeCode: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure cmdOkClick(Sender: TObject);
    procedure cbonameExit(Sender: TObject);
  private
    fsSimpletypeCode: String;
    fsSimpletype: String;
    fsDescription: String;
    fbhasDescription: Boolean;
    { Private declarations }
  public
    Property SimpletypeCode   :String   read fsSimpletypeCode   write fsSimpletypeCode;
    Property Simpletype       :String   read fsSimpletype       write fsSimpletype;
    Property Description      :String   read fsDescription      write fsDescription;
    Property HasDescription   :Boolean  read fbhasDescription   write fbhasDescription;
    Procedure ChooseSimpletype(Var   aDescription  , aSimpletype:String ; const aSimpletypeCode:String; ahasDescription :Boolean);
    Class Procedure DoChooseSimpletype(AOwner:TComponent; Var   aDescription  , aSimpletype:String ; const aSimpletypeCode:String; ahasDescription :Boolean);
  end;


implementation

uses BusObjSimpleTypes, CommonDbLib, frmSimpleTypes;

{$R *.dfm}

procedure TfmChooseSimpletype.cmdOkClick(Sender: TObject);
begin
  inherited;
  Simpletype := cboname.Text ;
  Description := memDescription.Lines.TExt;
end;
procedure TfmChooseSimpletype.cbonameExit(Sender: TObject);
begin
  inherited;
  if cboname.items.indexof(cboname.text) <0 then begin
    TfmSimpleTypes.DoSimpleTypesEdit(SimpletypeCode, cboname.text , Self, True, true);
  end;
end;

Procedure TfmChooseSimpletype.ChooseSimpletype(Var   aDescription  , aSimpletype:String ; const aSimpletypeCode:String; ahasDescription :Boolean);
begin
  Description:= aDescription;
  Simpletype := aSimpletype;
  SimpletypeCode := aSimpletypeCode;
  hasDescription:= ahasDescription ;
  Showmodal;
  if modalresult = mrok then begin
    aDescription:= Self.Description;
    aSimpletype := Self.Simpletype;
  end;
end;
class procedure TfmChooseSimpletype.DoChooseSimpletype(AOwner:TComponent; var aDescription,  aSimpletype: String; const aSimpletypeCode: String; ahasDescription: Boolean);
var
  form :TfmChooseSimpletype;
begin
  form := TfmChooseSimpletype.Create(AOwner);
  try
      Form.ChooseSimpletype(aDescription,  aSimpletype, aSimpletypeCode, ahasDescription);
  finally
    Freeandnil(form);
  end;

end;

procedure TfmChooseSimpletype.FormShow(Sender: TObject);
begin
  inherited;
  if not HasDescription then begin
    Self.Height  := Self.Height   - pnldescription.Height;
    pnldescription.Visible := False;
  end else begin
    pnldescription.Visible := True;
  end;
  TitleLabel.Caption := TSimpleTypes.SimpleTypeTypeDesc(SimpletypeCode);
  Self.Caption :=TitleLabel.Caption;
  lblName.Caption :=TitleLabel.Caption;
  cboname.Text :=  Simpletype;
  closedb(qrySimpleTypes);
  qrySimpleTypes.ParamByName('Type').AsString := Simpletype;
  Opendb(qrySimpleTypes);
  cboname.Items.Clear;
  while NOT qrySimpleTypes.Eof do begin
   cboname.Items.Add(qrySimpleTypes.Fieldbyname('name').AsString);
   qrySimpleTypes.Next;
  end;
  memDescription.Lines.Clear;
  cboname.Text := Simpletype;
  memDescription.Lines.TExt:= Description;
end;

end.
