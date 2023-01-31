unit frmHireGroups;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DNMSpeedButton, StdCtrls, CheckComboBox, HireClasses, contnrs;

type
  TfmHireGroups = class(TForm)
    btnAdd: TDNMSpeedButton;
    btnDoNotAdd: TDNMSpeedButton;
    lblHeader1: TLabel;
    lblProduct: TLabel;
    lblHeader2: TLabel;
    cbGroups: TComboBox;
    btnCancel: TDNMSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function AskForHireGroup(AList : THireLineList; ANewRec : THireLineRec; var AExistingRec : THireLineRec) : integer;


implementation

{$R *.dfm}
type
  TGroupRecord = class
  private
    FHireFrom: TDateTime;
    FHireTo: TDateTime;
    FCount: integer;
    FLineNo: integer;
    procedure SetHireFrom(const Value: TDateTime);
    procedure SetCount(const Value: integer);
    procedure SetHireTo(const Value: TDateTime);
    procedure SetLineNo(const Value: integer);
  public
    property HireFrom : TDateTime read FHireFrom write SetHireFrom;
    property HireTo : TDateTime read FHireTo write SetHireTo;
    property Count : integer read FCount write SetCount;
    property LineNo : integer read FLineNo write SetLineNo;
  end;

  TGroupList = class
  private
    fList : TObjectList;
    function GetItem(idx: integer): TGroupRecord;
    procedure SetItem(idx: integer; const Value: TGroupRecord);
    function GetCount: integer;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Add(ARec : THireLineRec);
    property Item[idx : integer] : TGroupRecord read GetItem write SetItem; default;
    property Count : integer read GetCount;

  end;

function AskForHireGroup(AList : THireLineList; ANewRec : THireLineRec; var AExistingRec : THireLineRec) : integer;
var
  idx : integer;
  i : integer;
  frm : TfmHireGroups;
  lList : TGroupList;
  s : string;

begin
  result := -1;
  lList := TGroupList.Create;
  try
    for idx := 0 to aList.Count - 1 do
    begin
      if SameText(AList.Item[idx].AssetName, ANewRec.AssetName) and
         (ANewRec.HireId = AList.Item[idx].HireId) then
      begin
//      for I := 0 to Low to High do
        lList.Add(AList.Item[idx]);
      end;
    end;

    frm := TfmHireGroups.Create(nil);
    try
      if lList.Count = 1 then
        frm.lblHeader1.Caption  := 'You Already Have A Line For'
      else
        frm.lblHeader1.Caption  := 'You Already Have ' + IntToStr(lList.Count) + ' Lines For';

      frm.lblProduct.Caption := ANewRec.AssetName;

      if lList.Count = 1 then
        frm.lblHeader2.Caption  := 'Would You Like To Add To This Line Qty?'
      else
        frm.lblHeader2.Caption  := 'Would You Like To Add To Selected Line Qty?';
      frm.cbGroups.Clear;
      for idx := 0 to lList.Count - 1 do
      begin
//        s := 'Hire ' + FormatDateTime('dd/mm/yyyy hh:
        s := 'Hire: ' + FormatDateTime('ddddd hh:nn am/pm', lList.Item[idx].HireFrom) + ' To ' + FormatDateTime('ddddd hh:nn am/pm', lList.Item[idx].HireTo);
        frm.cbGroups.Items.AddObject(s, lList[idx]);
      end;
      frm.cbGroups.ItemIndex := 0;

//      Result := frm.ShowModal = mrOK;
      case frm.ShowModal of
//      if Result then
      mrOK :
        begin
          Result := 0;
          i := TGroupRecord(frm.cbGroups.Items.Objects[frm.cbGroups.ItemIndex]).LineNo;
          for idx := 0 to AList.Count - 1 do
            if AList.Item[idx].HireLineId = i then
            begin
              AExistingRec := AList.Item[idx];
              exit;
            end;
        end;
      mrIgnore : Result := 1;  // create new group
      mrCancel : Result := -1;
      end;
    finally
      frm.Free;
    end;
  finally
    lList.Free;
  end;
end;

{ TGroupRecord }

procedure TGroupRecord.SetCount(const Value: integer);
begin
  FCount := Value;
end;

procedure TGroupRecord.SetHireFrom(const Value: TDateTime);
begin
  FHireFrom := Value;
end;

procedure TGroupRecord.SetHireTo(const Value: TDateTime);
begin
  FHireTo := Value;
end;

procedure TGroupRecord.SetLineNo(const Value: integer);
begin
  FLineNo := Value;
end;

{ TGroupList }

procedure TGroupList.Add(ARec: THireLineRec);
var
  idx : integer;
  rec : TGroupRecord;
begin
  for idx := 0 to fList.Count - 1 do
    if Item[idx].LineNo = ARec.HireLineId  then
    begin
      Item[idx].Count := Item[idx].Count + 1;
      exit;
    end;
   Rec := TGroupRecord.Create;
   rec.HireFrom := ARec.HireFrom;
   Rec.HireTo := ARec.HireTo;
   Rec.LineNo := ARec.HireLineId;
   Rec.Count := 1;
   fList.Add(Rec);
end;

constructor TGroupList.Create;
begin
  inherited;
  fList := TObjectList.Create(true);
end;

destructor TGroupList.Destroy;
begin
  fList.Free;
  inherited;
end;

function TGroupList.GetCount: integer;
begin
  Result := fList.Count;
end;

function TGroupList.GetItem(idx: integer): TGroupRecord;
begin
  Result := TGroupRecord(fList.Items[idx]);
end;

procedure TGroupList.SetItem(idx: integer; const Value: TGroupRecord);
begin

end;

procedure TfmHireGroups.FormActivate(Sender: TObject);
begin
  lblHeader1.Width := lblHeader1.Canvas.TextWidth(lblHeader1.Caption + 'ww');
  lblHeader1.Left := (Self.ClientWidth - lblHeader1.Width) div 2;
  lblProduct.Width := lblProduct.Canvas.TextWidth(lblProduct.Caption + 'ww');
  lblProduct.Left := (Self.ClientWidth - lblProduct.Width) div 2;
  lblHeader2.Width := lblHeader2.Canvas.TextWidth(lblHeader2.Caption + 'ww');
  lblHeader2.Left := (Self.ClientWidth - lblHeader2.Width) div 2;
  cbGroups.Left := (Self.ClientWidth - cbGroups.Width) div 2;
end;

procedure TfmHireGroups.FormShow(Sender: TObject);
begin
  lblHeader1.Width := lblHeader1.Canvas.TextWidth(lblHeader1.Caption + 'ww');
  lblHeader1.Left := (Self.ClientWidth - lblHeader1.Width) div 2;
  lblProduct.Width := lblProduct.Canvas.TextWidth(lblProduct.Caption + 'ww');
  lblProduct.Left := (Self.ClientWidth - lblProduct.Width) div 2;
  lblHeader1.Width := lblHeader2.Canvas.TextWidth(lblHeader2.Caption + 'ww');
  lblHeader1.Left := (Self.ClientWidth - lblHeader2.Width) div 2;
  cbGroups.Left := (Self.ClientWidth - cbGroups.Width) div 2;
end;

end.
