unit PreferencesList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TPreferencesListGUI = class(TBaseListingGUI)
    qryMainSearchValue: TWideStringField;
    procedure FormCreate(Sender: TObject);
  private
    fsPreferencetoLocate: String;
    Tablename :String;
    procedure SetValues(const Value: TStrings);
  Protected
    procedure OnScriptExecuteProgressCancel(Sender: TObject);Override;
  public
    Property PreferencetoLocate :String read fsPreferencetoLocate write fsPreferencetoLocate;
    Property Values :TStrings Write SetValues;
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonDbLib, CommonLib, tcConst, LogLib;

{$R *.dfm}

{ TPreferencesListGUI }

procedure TPreferencesListGUI.FormCreate(Sender: TObject);
begin
  tablename := GetUserTemporaryTableName('PreferencesList');
  With ScriptMain do try
    SQL.add('Drop table if exists ' + tablename+';');
    SQL.add('CREATE TABLE  ' + tablename+' (');
    SQL.add('	ID                INT(10)       NOT NULL AUTO_INCREMENT,');
    SQL.add('	SearchValue       VARCHAR(255)  NULL DEFAULT 0,');
    SQL.add('	PRIMARY KEY (ID), UNIQUE INDEX `SearchValue` (`SearchValue`))');
    SQL.add('ENGINE=MyISAM;');
    Execute;
  finally
    SQL.clear;
  end;
  Qrymain.SQL.Clear;
  Qrymain.SQL.Add('Select *');
  Qrymain.SQL.Add('from ' +tablename);
  Qrymain.SQL.Add('order by SearchValue');
//  Qrymain.SQL.Text := 'Select * from ' +tablename+ ' order by SearchValue';
  inherited;
  SearchMode:= smFullList;
  //NonSearchReport := True;
end;

procedure TPreferencesListGUI.RefreshQuery;
begin
  inherited;
  if PreferencetoLocate <> '' then begin
    edtSearch.Text := PreferencetoLocate;
    SearchMode := smSearchEngineLike;
    GoSearch;
    if Qrymain.Locate('SearchValue' , PreferencetoLocate , []) then
    else Qrymain.Locate('SearchValue' ,PreferencetoLocate , [loCaseInsensitive,loPartialKey]);
  end;
  PreferencetoLocate := ''
end;
procedure TPreferencesListGUI.OnScriptExecuteProgressCancel(Sender: TObject);
begin
  //inherited;
  // Binny : inherited will breakexecute the script, as the  Procedure 'SetValues' has the progress bar and if the SQL is partially populated when cancelling, it should run it
end;
procedure TPreferencesListGUI.SetValues(const Value: TStrings);
var
  ctr:Integer;
  s:string;
  fiIndex:Integer;
begin
  With ScriptMain do try
    SQL.Add('truncate ' +tablename +';');

    ShowProgressbar(WAITMSG , Value.Count*2);
    try
      if Value.Count >0 then begin
        SQL.Add('Insert ignore into  ' + tablename +' (SearchValue)  values ');
        fiIndex:= SQL.count;
        for ctr := 0 to Value.Count-1 do begin
          if fiIndex < SQL.count then s:= ',' else s:= '';
          s:=s + '(' +quotedstr(Value[ctr]) +')';
          SQL.Add(s);
          stepProgressbar;
          if IsProgressbarCancelled then begin
            ListTimerMsg('List Not Populated Completely .. User Aborted');
            break;
          end;
        end;
      end;
      stepProgressbar('Populate List');
      clog(SQL.text);
      Execute;
    finally
      HideProgressbar;
    end;
  finally
    SQL.clear;
  end;
end;
initialization
  RegisterClassOnce(TPreferencesListGUI);

end.

