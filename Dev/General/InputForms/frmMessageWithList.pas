unit frmMessageWithList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmMessageBase, ExtCtrls, frmBase, Grids, StdCtrls, DNMPanel ,db,
  Menus;

type
  TfmMessageWithList = class(TfmMessageBase)
    grd: TStringGrid;
    lblDetails: TLabel;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure grdDblClick(Sender: TObject);

  private
    fMsgDs: TDataset;
    fsdisplayLabels: String;
    fsFieldNames: String;
    fsDisplaywidths: String;
    fsMsgTExtForGrid: String;
    fsMsgTExtForGridDelim: String;
    fbHideinGridwhen0:Boolean;
    procedure setMsgDs(const Value: TDataset);
    procedure setMsgTExtForGrid(const Value: String);
  Protected
    Procedure InitMsgDlg;overload;Override;
  public
    class function MsgDlg:Integer;overload;Override;
    Property MsgDs :TDataset read fMsgDs write setMsgDs;
    Property FieldNames:String read fsFieldNames write fsFieldNames;
    Property displayLabels :String read fsdisplayLabels write fsdisplayLabels;
    Property Displaywidths :String read fsDisplaywidths write fsDisplaywidths;
    Property MsgTExtForGrid :String read fsMsgTExtForGrid Write setMsgTExtForGrid;
    Property MsgTExtForGridDelim :String read fsMsgTExtForGridDelim write fsMsgTExtForGriddelim ;
    Property HideinGridwhen0 :Boolean read fbHideinGridwhen0 write fbHideinGridwhen0;

  end;

implementation

uses CommonLib, tcConst;

{$R *.dfm}

{ TfmMessageWithList }

procedure TfmMessageWithList.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
canclose := True;
end;

procedure TfmMessageWithList.grdDblClick(Sender: TObject);
var
  s:String;
begin
  inherited;
  s:= grd.Cells[grd.Col, grd.Row];
  if s<> '' then TimerMsg(lblDetails , s, 20); //MessageDlgXP_vista(s, mtWarning, [mbOK], 0);
end;

procedure TfmMessageWithList.InitMsgDlg;
begin
  inherited;
  HideinGridwhen0 := PopupMsgParams.HideinGridwhen0;
  FieldNames    := PopupMsgParams.FieldNames;
  displayLabels := PopupMsgParams.displayLabels;
  Displaywidths := PopupMsgParams.Displaywidths;
  MsgDs         := PopupMsgParams.MsgDs;
  MsgTExtForGridDelim := PopupMsgParams.MsgTExtForGridDelim;
  MsgTExtForGrid := PopupMsgParams.MsgTExtForGrid;

end;

class function TfmMessageWithList.MsgDlg: Integer;
begin
With TfmMessageWithList.Create(nil) do try
  initMsgDlg;
  ShowModal;
  result :=  fiMsgResult;
finally
  Free;
end;

end;

procedure TfmMessageWithList.setMsgDs(const Value: TDataset);
var
  st:TStringlist;
  ctr:Integer;
begin

  fMsgDs := Value;
  if fMsgDS = nil then exit;
  if fMsgDS.active = False then fMsgDS.open;
  if fieldnames = '' then exit;

  st:= Tstringlist.create;
  try
    //St.commatext := displayLabels;
    St.strictDelimiter := True;
    St.Delimiter :=',';
    St.DelimitedText := displayLabels;
    grd.colcount := st.count;
    grd.FixedCols:= 0;
    grd.rowcount := 1;

    for ctr := 0 to st.count-1 do begin
      grd.Cells[ctr,0] := st[ctr];
      grd.ColWidths[ctr] := trunc(grd.Width /st.Count)-10;
    end;
    if Displaywidths <> '' then begin
      st.commatext := Displaywidths;
      for ctr := 0 to st.Count-1 do begin
        if ISInteger(st[ctr]) then
          grd.ColWidths[ctr] := strToint(st[ctr]);
      end;
    end;
    if fMsgDS.recordcount =0 then exit;
    fMsgDS.first;
    St.commatext := fieldnames;
    while fMsgDS.eof= False do begin
      grd.RowCount := grd.RowCount + 1;
      for ctr := 0 to st.count-1 do
        if HideinGridwhen0 and ((fMsgDS.findfield(st[ctr]) is TIntegerfield) or (fMsgDS.findfield(st[ctr]) is TFloatfield)) and (fMsgDS.findfield(st[ctr]).AsFloat =0) then
             grd.Cells[ctr,grd.rowcount-1] := ''
        else grd.Cells[ctr,grd.rowcount-1] := fMsgDS.Fieldbyname(st[ctr]).asString;
      fMsgDS.next;
    end;
  finally
    FreeandNil(st);
  end;
  if grd.RowCount>1 then grd.fixedrows:= 1;
end;

procedure TfmMessageWithList.setMsgTExtForGrid(const Value: String);
var
  st:TStringlist;
  ctr:Integer;
  st1, St2 :TStringlist;
  x,y:Integer;
begin
  fsMsgTExtForGrid := Value;

  if Value = '' then exit;
  //if pos(MsgTExtForGridDelim , Value ) = 0 then exit;


    if displayLabels = '' then exit;
    st:= Tstringlist.create;
    try

      st.QuoteChar:= '''';
      St.Delimiter:= ',';
      st.DelimitedText := displayLabels;
      grd.colcount := st.count;
      grd.FixedCols:= 0;
      grd.rowcount := 1;

      for ctr := 0 to st.count-1 do begin
        grd.Cells[ctr,0] := st[ctr];
        grd.ColWidths[ctr] := trunc(grd.Width /st.Count)-10;
      end;
      if Displaywidths <> '' then begin
        st.commatext := Displaywidths;
        for ctr := 0 to st.Count-1 do begin
          if (trim(st[ctr]) <>'' ) and ISInteger(st[ctr]) then
            grd.ColWidths[ctr] := strToint(st[ctr]);
        end;
      end;
    finally
      FreeandNil(st);
    end;


    st1:= TStringlist.Create;
    st2:= TStringlist.create;
    try
      StrtoStringlist(Value , MsgTExtForGridDelim, st1);
      for x:= 0 to st1.Count -1 do begin
        st2.Clear;
        st2.QuoteChar:= '''';
        St2.Delimiter:= ',';
        St2.StrictDelimiter:= True;
        st2.DelimitedText := St1[x];
        grd.RowCount := grd.RowCount + 1;
        for y := 0 to st2.Count-1 do begin
           grd.Cells[y,grd.rowcount-1] := st2[y];
        end;
      end;
    finally
      FreeAndnil(st1);
      Freeandnil(st2);
    end;
  if grd.RowCount>1 then grd.fixedrows:= 1;
end;

end.

