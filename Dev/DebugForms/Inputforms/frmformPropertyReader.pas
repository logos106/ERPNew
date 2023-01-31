unit frmformPropertyReader;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, CheckLst, DB, DBAccess, MyAccess, ERPdbComponents,
  MemDS, Mask, wwdbedit, Grids, Wwdbigrd, Wwdbgrid ,BaseInputForm, ComCtrls,
  ProgressDialog, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, DBCtrls, ActnList, DNMAction, DNMSpeedButton, dmMainGUI,ImageDLLLib;

type

  TERPDnMAction  = record
      fileName  :String ;
      ActionName :String ;
      Category :String ;
      Description  :String ;
      Caption  :String ;
      ImageIndex :Integer ;
      ClassExecute  :String ;
  end;
  TfmformPropertyReader = class(TBaseInputGUI)
    qryimageIndexes: TERPQuery;
    dsimageIndexes: TDataSource;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label3: TLabel;
    Label1: TLabel;
    edtProjectFile: TEdit;
    btnGetForms: TButton;
    lstForms: TCheckListBox;
    btnheckforNextImageIndex: TButton;
    memImages: TMemo;
    wwDBGrid1: TwwDBGrid;
    btnCheckAll: TButton;
    btnfind: TButton;
    edtNextno: TEdit;
    qryimageIndexesmultiused: TERPQuery;
    dsimageIndexesmultiused: TDataSource;
    wwDBGrid2: TwwDBGrid;
    Label2: TLabel;
    Label4: TLabel;
    DBMemo1: TDBMemo;
    qryimageIndexesImageIndex: TLargeintField;
    qryimageIndexesTimesUSed: TLargeintField;
    qryimageIndexesmultiusedImageIndex: TLargeintField;
    qryimageIndexesmultiusedTimesUSed: TLargeintField;
    qryimageIndexesmultiusedDetails: TWideStringField;
    ActionList1: TActionList;
    actTest: TDNMAction;
    qryimageIndexesmultiusedActionDetails: TWideStringField;
    procedure btnGetFormsClick(Sender: TObject);
    procedure btnheckforNextImageIndexClick(Sender: TObject);
    procedure btnCheckAllClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qryimageIndexesBeforeOpen(DataSet: TDataSet);
    procedure btnfindClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure qryimageIndexesmultiusedCalcFields(DataSet: TDataSet);
    procedure qryimageIndexesAfterScroll(DataSet: TDataSet);
    procedure actTestExecute(Sender: TObject);
  private
    sPAth:String;
    btnTest: TERPMainSwitchButton;
  public
  end;

var
  fmformPropertyReader: TfmformPropertyReader;

implementation

uses strutils, CommonLib, LogLib, tcConst ;

{$R *.dfm}

procedure TfmformPropertyReader.actTestExecute(Sender: TObject);
begin
  inherited;
//
end;

procedure TfmformPropertyReader.btnCheckAllClick(Sender: TObject);
begin
  lstForms.CheckAll(cbChecked);
end;

procedure TfmformPropertyReader.btnGetFormsClick(Sender: TObject);
var
  sl: TStringList;
  ss: TStringList;
  x:Integer;
  S:String;
begin
  lstForms.Visible := True;
  clog('');
  lstForms.Clear;
  if FileExists(edtProjectFile.text) then begin
    sl:= TStringList.Create;
    ss:= TStringList.Create;
    try
      sl.LoadFromFile(edtProjectFile.Text);
      if not SetCurrentDir(ExtractFilePath(edtProjectFile.Text)) then begin
        ShowMessage('Could not set current directory to dpr directory');
        exit;
      end;
      sPath:=ExtractFilePath(edtProjectFile.Text);
      for x:= 0 to sl.Count -1 do begin
        ss.CommaText:= trim(sl[x]);
        if ((ss.count = 5) or ((ss.count = 4) and (Copy(ss[3],Length(ss[3]),1) = ';')) or ((ss.count = 6) and (trim(ss[5]) = '') ) ) and
          (ss[1] = 'in') then begin
          s:= Copy(ss[2],2, Pos(ExtractFileExt(ss[2]),ss[2])-2) + '.dfm';
          lstForms.AddItem(s,nil);
        end else begin
          logtext(sl[x]);
        end;
      end;
    finally
      sl.Free;
      ss.Free;
    end;
  end;
end;

procedure TfmformPropertyReader.btnheckforNextImageIndexClick(Sender: TObject);
var
  x, ctr:Integer;
  ST :TStringList;
  s:String;
  ERPDnMActions : Array of TERPDnMAction;
  ProcessingAction:Boolean;
const
      sCategory = 'Category = ';
      sCaption = 'Caption = ';
      sImageIndex = 'ImageIndex =';
      sClassExecute = 'ClassExecute = ';
      sDescription = 'Description = ';

begin
  memImages.Visible := True;
  memImages.clear;
  for x:= 0 to lstForms.Count -1 do begin
    if lstForms.Checked[x] then begin
      ST := TStringlist.create;
      Try
        ST.loadFromfile(lstForms.Items[x]);
        if st.count >0 then begin
            ProcessingAction:=False;
            for ctr := 0 to st.count -1 do begin
              s:= trim(st[ctr]);
              if (sameText(trim(s) , 'end')) then begin
                ProcessingAction  := False;
              end else if ProcessingAction then begin
                    try
                      if StartsWith(s, sCategory     ) then ERPDnMActions[high(ERPDnMActions)].category      := replacestr(s ,sCategory , '');
                      if StartsWith(s , sCaption     ) then ERPDnMActions[high(ERPDnMActions)].Caption       := replacestr(s ,sCaption , '');
                      if StartsWith(s , sImageIndex  ) then
                        ERPDnMActions[high(ERPDnMActions)].ImageIndex    := strToInt(replacestr(s ,sImageIndex , ''));
                      if StartsWith(s , sClassExecute) then ERPDnMActions[high(ERPDnMActions)].ClassExecute  := replacestr(s ,sClassExecute , '');
                      if StartsWith(s , sDescription ) then ERPDnMActions[high(ERPDnMActions)].Description   := replacestr(s ,sDescription , '');
                    Except
                    end;
              end else if pos(': TDNMAction' , s) >0 then begin
                  SetLength(ERPDnMActions , length(ERPDnMActions)+1);
                  ProcessingAction := TRue;
                  ERPDnMActions[high(ERPDnMActions)].filename := replacestr(lstForms.Items[x] , '.dfm', '');
                  s:= replaceStr(s , 'object ' , ''); s:= replaceStr(s , 'inherited ' , '');s:= replaceStr(s , ': TDNMAction' , '');
                  ERPDnMActions[high(ERPDnMActions)].ActionName :=s;
              end;
            end;
          end;
      Finally
        Freeandnil(ST);
      End;
    end;
  end;
  memImages.Clear;
  s:= '';
  if qryimageIndexes.Active then qryimageIndexes.close;
  qryimageIndexes.SQL.text := 'Select 1 as ImageIndex';
  for ctr:= 2 to 761 do qryimageIndexes.SQL.add('union all Select ' + inttostr(ctr)+' as ImageIndex' );


  for ctr:= low(ERPDnMActions) to high(ERPDnMActions) do begin
    memImages.Lines.Add(ERPDnMActions[ctr].fileName +'.' + ERPDnMActions[ctr].Actionname+'=' +inttostr(ERPDnMActions[ctr].ImageIndex));
    if s<> '' then s:= s +' union all ';
    s:= s + ' Select ' + inttostr(ERPDnMActions[ctr].ImageIndex) + ' as ImageIndex ,  ' + quotedstr(ERPDnMActions[ctr].fileName +'.' + ERPDnMActions[ctr].Actionname+'=' +inttostr(ERPDnMActions[ctr].ImageIndex))+' as ActionDetails' ;
  end;

  qryimageIndexesmultiused.SQL.text :=  'Select  Allnumbers.ImageIndex , count(UsedNumbers.imageIndex) as TimesUSed , convert(GROUP_CONCAT(ActionDetails), char(255)) as ActionDetails'+
        ' from (' + qryimageIndexes.SQL.text +')  Allnumbers  '+
        ' Left join (' +s +') as UsedNumbers on Allnumbers.ImageIndex= UsedNumbers.imageIndex  '+
        ' group by Allnumbers.ImageIndex '  +
        ' having TimesUSed > 1  Order by ImageIndex , TimesUSed ';

  qryimageIndexes.SQL.text :=  'Select  Allnumbers.ImageIndex , count(UsedNumbers.imageIndex) as TimesUSed '+
        ' from (' + qryimageIndexes.SQL.text +')  Allnumbers  '+
        ' Left join (' +s +') as UsedNumbers on Allnumbers.ImageIndex= UsedNumbers.imageIndex  '+
        ' group by Allnumbers.ImageIndex  ' +
        ' having TimesUSed =0 Order by ImageIndex';

  clog(qryimageIndexes.SQL.text);
  logtext(qryimageIndexesmultiused.SQL.text);

  if not qryimageIndexes.Active then qryimageIndexes.Open;
  if not qryimageIndexesmultiused.Active then qryimageIndexesmultiused.Open;
  qryimageIndexes.first;
  qryimageIndexesmultiused.first;

  wwDBGrid1.Visible := True;
  wwDBGrid2.Visible := True;
  DBMemo1.Visible := True;
  Label2.Visible := True;
  Label4.Visible := True;
  btnTest.Visible := True;
  edtNextno.text := qryimageIndexes.fieldbyname('ImageIndex').asString;


end;

procedure TfmformPropertyReader.btnfindClick(Sender: TObject);
begin
  inherited;
  lstForms.Visible := False;
  memImages.Visible := False;
  wwDBGrid1.Visible := False;
  wwDBGrid2.Visible := False;
  DBMemo1.Visible := False;
  Label2.Visible := False;
  Label4.Visible := False;
  btnTest.Visible :=False;

  btnGetForms.click;
  btnCheckAll.click;
  btnheckforNextImageIndex.click;
  Setcontrolfocus(edtNextno);
end;

procedure TfmformPropertyReader.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmformPropertyReader.FormCreate(Sender: TObject);
begin
  edtProjectFile.text :=replacestr(Application.ExeName, '.EXE' ,'.DPR');
  btnTest:= TERPMainSwitchButton.Create(Self);
  btnTest.Name := MakeName(Self , 'btnTest');
  btnTest.Left :=  760;
  btnTest.Top :=  522;
  btnTest.Width :=  110;
  btnTest.Height :=  95;
  btnTest.Action :=  actTest;
(*  btnTest.DisableTransparent :=  False;
  btnTest.HotTrackFont.Charset :=  DEFAULT_CHARSET;
  btnTest.HotTrackFont.Color :=  clWindowText;
  btnTest.HotTrackFont.Height :=  -11;
  btnTest.HotTrackFont.Name :=  'Tahoma';
  btnTest.HotTrackFont.Style :=  [];*)
  btnTest.TabOrder :=  11;
  btnTest.Visible :=  False;
  btnTest.WordWrap :=  True;
  btnTest.Parent := TabSheet1;
end;

procedure TfmformPropertyReader.FormShow(Sender: TObject);
begin
  inherited;
  PageControl1.TabIndex:= 0;
  Setcontrolfocus(btnfind);
  Invalidate;
end;

procedure TfmformPropertyReader.qryimageIndexesAfterScroll(DataSet: TDataSet);
begin
  inherited;
  ActionList1.images     := dtmMainGUI.ImageList;
  btnTest.action := nil;
  actTest.imageindex :=  qryimageIndexes.fieldbyname('ImageIndex').asInteger-1;
  btnTest.action := actTest;
  btnTest.refresh;

end;

procedure TfmformPropertyReader.qryimageIndexesBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryimageIndexes.Connection:= MyConnection;
end;

procedure TfmformPropertyReader.qryimageIndexesmultiusedCalcFields(
  DataSet: TDataSet);
begin
  inherited;
  qryimageIndexesmultiusedDetails.asString := replacestr(qryimageIndexesmultiusedActionDetails.AsString , ',' , CHR(10 )+CHR(13));
end;

initialization

  RegisterClassOnce(TfmformPropertyReader);

end.
