unit frmStSCreateImmaturePlant;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmStSProduction, DB, ProgressDialog, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, wwdbedit, wwdbdatetimepicker, StdCtrls, Mask, Wwdbspin,
  wwclearbuttongroup, wwradiogroup, Shader, DNMSpeedButton, DNMPanel, Grids,
  Wwdbigrd, Wwdbgrid;

type
  TfmStSCreateImmaturePlant = class(TfmStSProduction)
    EdtTag: TEdit;
    Label4: TLabel;
    procedure btnChooseTagsClick(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure choosetags(Sender: TwwDBGRid);
    procedure InitStSTags(Sender: TObject);
    procedure Showtag;
  Protected
    procedure SetTagForProduct(const Value: String);Override;
  public
  end;

implementation

uses CommonFormLib, StSTags, BusObjSeedToSale, CommonLib;

{$R *.dfm}

procedure TfmStSCreateImmaturePlant.btnChooseTagsClick(Sender: TObject);
begin
  inherited;
  if fiProductTagID <> 0 then begin
    MessageDlgXP_Vista('Tag Already Selected', mtWarning, [mbOK], 0);
    Exit;
  end;
  OpenERPListFormSingleselectModal('TStSTagsGUI',  choosetags , InitStSTags,False, TERPConnection(MyDAcDataconnection.connection));
end;
procedure TfmStSCreateImmaturePlant.btnCloseClick(Sender: TObject);
begin
  inherited;
  ModalREsult := mrCancel;
end;

procedure TfmStSCreateImmaturePlant.btnCompletedClick(Sender: TObject);
begin
  if StSTagProduct.Productcount <=0 then begin
    if MessageDlgXP_vista('Plant Should Not be blank, Change it to 1? ', mtconfirmation, [mbyes,mbno], 0) = mrno then exit;
    StSTagProduct.Productcount := 1;
  end;
  if StSTagProduct.ProductionDate =0 then begin
    if MessageDlgXP_vista('Date should not be blankc, Change to Today? ', mtconfirmation, [mbyes,mbno], 0) = mrno then exit;
    StSTagProduct.ProductionDate := Now;
  end;
  if optTagForProduct.itemindex <0 then begin
    MessageDlgXP_vista('Please Choose The Plant Type', mtWarning, [mbOK], 0);
    Exit;
  end;
  if TagForProduct = '' then begin
    MessageDlgXP_vista('Please Choose the Tag', mtWarning, [mbOK], 0);
    Setcontrolfocus(btnChooseTags);
    Exit;
  end;
  StSTagProduct.PostDB;
  ModalREsult := mrOK;
end;

procedure TfmStSCreateImmaturePlant.choosetags(Sender :TwwDBGRid);
begin
  if Sender.Owner is  TStSTagsGUI then begin
    TagForProduct := TStSTagsGUI(Sender.Owner).SelectedTag;
    TagProductID :=TStSTagsGUI(Sender.Owner).SelectedProductID;
  end;
end;
procedure TfmStSCreateImmaturePlant.FormCreate(Sender: TObject);
begin
  inherited;
  FormColor := $0091C8FF;
end;

procedure TfmStSCreateImmaturePlant.FormShow(Sender: TObject);
begin
  inherited;

  with TitleShader do begin
    FromColor       := clWhite;
    FromColorMirror := clWhite;
    ToColor         := clWhite;
    ToColorMirror   := clWhite;
  end;

  ShowTag;
end;
procedure TfmStSCreateImmaturePlant.SetTagForProduct(const Value: String);
begin
  inherited;
  Showtag;
end;

Procedure TfmStSCreateImmaturePlant.Showtag;
begin
  //EdtTag.visible := trim(TagForProduct)<>'';
  EdtTag.Text  := trim(TagForProduct);
end;

procedure TfmStSCreateImmaturePlant.InitStSTags(Sender: TObject);
begin
  if sender is TStSTagsGUI then begin
    with TStSTagsGUI(Sender) do begin
        FilterString := '('+AvailableTagsFilter+') ';
      grpFilters.itemindex := grpFilters.items.count-1;
      grpFilters.visible := False;
      InitDisplayCaption('Choose Immature Tag');
    end;
  end;
end;

end.
