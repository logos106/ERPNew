unit FrameForeigncurrencyEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, frameGuiElementEdit,
  DB, MemDS, DBAccess, MyAccess,ERPdbComponents, Grids, Wwdbigrd, Wwdbgrid, StdCtrls,
  CheckLst, MessageInterface, ExtCtrls;

type
  TColumnListItem = class(TObject)
  private
    fCurrency: string;
    fcountry :String;
    fShowinthereport: boolean;
    fcurrencyID  :Integer;
    fID :Integer;
  public
    Constructor Create;
    Property Currency       : string    read fCurrency      write fCurrency;
    Property Showinthereport   : boolean   read fShowinthereport  write fShowinthereport;
    Property Country        : String    read fcountry       Write fcountry;
    Property CurrencyID     : Integer   read fcurrencyID    Write fcurrencyID;
    Property ID             : Integer   read fID            Write fID;
  end;


  TFrForeigncurrencyEdit = class(TfrGuiElementEdit)
    lstGridColumns: TCheckListBox;
    qryFCOnReport: TERPQuery;
    procedure lstGridColumnsClickCheck(Sender: TObject);
  private
    fMsgHandler : TMsgHandler;
    FlIST :array of TColumnListItem;
    procedure ClearColumnList;
    Procedure ShowColumns(fUserID:Integer =0);
  public
    constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;
    procedure DisplayGuiSettings(fUserID:Integer =0); override;
    //function Save :boolean;
  Published
    function Save(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
  end;


implementation

uses FastFuncs,CommonLib, CommonDbLib, tcDataUtils, AppEnvironment;

{$R *.dfm}
constructor TColumnListItem.Create;
begin
    inherited;
  fCurrency     := '';
  fShowinthereport := false;
end;

Procedure TFrForeigncurrencyEdit.ShowColumns(fUserID:Integer =0);
var
    x, idx: integer;
    ColItem: TColumnListItem;
    qry: TERPQuery;

    function FormatLine(Const fscurrency, fscountry :String): String;
    begin
        result :=fscurrency + ' - ' +  fscountry;
    end;
begin
    qryFCOnReport.Connection := GetSharedMyDacConnection;
    qryFCOnReport.SQL.clear;
    qryFCOnReport.SQL.add('SELECT FCR.ForeignCurrencyonReportID,CC.CurrencyID,');
    qryFCOnReport.SQL.add('CC.Currency , CC.country , ');
    qryFCOnReport.SQL.add('CC.CurrencyId, ifnull(FCR.Showinthereport, "F") as Showinthereport');
    qryFCOnReport.SQL.add('FROM tblcurrencyconversion CC');
    qryFCOnReport.SQL.add('left join tblforeigncurrencyonreport FCR ON FCR.CurrencyID = CC.CurrencyID ');
    qryFCOnReport.SQL.add('and FCR.userId = ' + IntToStr(fUserID));
    qryFCOnReport.SQL.add('and FCR.ListName = ' + QuotedStr(EditGuiPrefsForm.FormGuiPrefs.prefsname));
    qryFCOnReport.SQL.add('where    CC.Active = "T"');
    qryFCOnReport.SQL.add(' and CC.Code <> ' + quotedStr(Appenv.RegionalOptions.ForeignExDefault));

    qryFCOnReport.open;
    ClearColumnList;
    if qryFCOnReport.Recordcount = 0 then begin
      qry := TERPQuery.Create(nil);
      try
        qry.Connection := CommonDbLib.GetSharedMyDacConnection;
        qry.SQL.Text := 'select * from tblcurrencyconversion where Active = "T"';
        qry.Open;
        if qry.IsEmpty then begin
          TimerMsg('No FX Rates Selected. Go to "Accounts" (File menu) then select "Foreign Exchange Rates List" and select a rate that you wish to display.',40);
        end;

      finally
        qry.Free;
      end;

      Exit;
    end;
    qryFCOnReport.First;
    x := 0;
    while qryFCOnReport.Eof = False do begin
        x := x+1;
        Setlength(fList, x);
        ColItem                     := TColumnListItem.Create;
        ColItem.ID                  := qryFCOnReport.FieldByname('ForeignCurrencyonReportID').asInteger;
        ColItem.currencyID          := qryFCOnReport.FieldByname('CurrencyID').asInteger;
        ColItem.currency            := qryFCOnReport.fieldByname('Currency').AsString;
        ColItem.Country             := qryFCOnReport.fieldByname('Country').AsString;
        ColItem.Showinthereport     := qryFCOnReport.fieldByname('Showinthereport').asBoolean;
        fList[x-1]                  := ColItem;
        idx                         := lstGridColumns.Items.Add(FormatLine(qryFCOnReport.fieldByname('Currency').AsString , qryFCOnReport.fieldByname('Country').AsString));
        lstGridColumns.Checked[idx] := qryFCOnReport.fieldbyname('Showinthereport').asBoolean;
        qryFCOnReport.Next;
    end;
end;
procedure TFrForeigncurrencyEdit.DisplayGuiSettings(fUserID:Integer =0);
begin
    ShowColumns(fUserID);
end;
procedure TFrForeigncurrencyEdit.ClearColumnList;
begin
  while lstGridColumns.Count > 0 do begin
    lstGridColumns.Items.Objects[0].Free;
    lstGridColumns.Items.Delete(0);
  end;
end;

Destructor TFrForeigncurrencyEdit.Destroy;
begin
    Freeandnil( fMsgHandler);
    inherited;
end;
constructor TFrForeigncurrencyEdit.Create(AOwner: TComponent);
begin
    inherited;
   fMsgHandler := TMsgHandler.create(Self);
end;
procedure TFrForeigncurrencyEdit.lstGridColumnsClickCheck(Sender: TObject);
begin
  inherited;
  fList[lstGridColumns.ItemIndex].Showinthereport :=lstGridColumns.Checked[lstGridColumns.ItemIndex];
end;

function TFrForeigncurrencyEdit.Save(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
var
    x       :Integer;
    strSQL  :TSTringList;
    iformId :integer;
    str     :String;
begin

     Result := False;
     iformId := tcdatautils.getformID(EditGuiPrefsForm.FormGuiPrefs.prefsname);
     if iformId = 0 then Exit;

     strSQL := TSTringList.Create;
     strSQL.add('Delete from tblForeigncurrencyonReport ' +
                ' where  formID = ' + IntToStr(iformId) +
                ' and userID = ' + IntToStr(MsgObj.IntValue) + ';');
     for x:= Low(flist) to high(fList) do begin
            str :=' insert into tblForeigncurrencyonReport (CurrencyID , formID , ListName , Active, Showinthereport, userID)' +
                    ' Values (' + IntToStr(fList[x].currencyID) + ',' +
                                     IntToStr(iformId) + ',' +
                                     quotedStr(EditGuiPrefsForm.FormGuiPrefs.prefsname) +',' +
                                     '"T", ';
            if fList[x].Showinthereport then str:= str+ '"T" ' else str := str + '"F" ';
            str:= str+ ',' + IntToStr(MsgObj.IntValue) + ');';
            strSQL.add(str);
     end;
     if strSQL.count > 0 then begin
        if qryFCOnReport.Active then qryFCOnReport.close;
        qryFCOnReport.SQL.clear;
        qryFCOnReport.SQL.text := strSQL.text;
        qryFCOnReport.Execute;
     end;
     Result := True;
     MsgRet :=MsgObj;

     //Freeandnil(MsgObj);

end;
initialization
  RegisterClassOnce(TFrForeigncurrencyEdit);

finalization
  UnRegisterClass(TFrForeigncurrencyEdit);

end.
