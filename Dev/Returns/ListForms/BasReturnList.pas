unit BasReturnList;

{ Date     Version Who  What
 -------- -------- ---  --------------------------------------------------------
 07/09/05  1.00.01 IJB  Modified to use new filtering on base listing.
 }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList,
  Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, DNMPanel, DBAccess,
  MyAccess,ERPdbComponents, MemDS, wwdbdatetimepicker, ProgressDialog, 
  wwdblook, Shader, kbmMemTable, ReturnListBase, DAScript, MyScript, wwcheckbox, CustomInputBox;

type
  TBasReturnListGUI = class(TReturnListBaseGUI)
    DNMSpeedButton1: TDNMSpeedButton;
    qryMainID: TIntegerField;
    qryMainBasSheetDesc: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainTab1_type: TWideStringField;
    qryMainTab2_type: TWideStringField;
    qryMainTab3_type: TWideStringField;
    grpOptions: TRadioGroup;
    qryMainDone: TWideStringField;
    qryMainTab1From: TWideStringField;
    qryMainTab1To: TWideStringField;
    qryMainTab2From: TWideStringField;
    qryMainTab2To: TWideStringField;
    qryMainTab3From: TWideStringField;
    qryMainTab3To: TWideStringField;
    qryMainTab4_type: TWideStringField;
    qryMainTab4From: TWideStringField;
    qryMainTab4To: TWideStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdNewClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure btndeleteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  public
  end;

implementation

uses BaseInputForm, CommonLib, AppEnvironment, BASTransReturnList,
  CommonFormLib, CommonDbLib, tcConst, SharedObjs;

{$R *.dfm}

procedure TBasReturnListGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
  
end;

procedure TBasReturnListGUI.FormShow(Sender: TObject);
begin
  inherited;
  btndelete.visible := devmode;
end;

procedure TBasReturnListGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  DisableForm;
  try
    inherited;
    Form := GetComponentByClassName('TfmBASReturn');
    if Assigned(Form) then begin
      with TBaseInputGUI(Form) do begin
        AttachObserver(Self);
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  finally
    EnableForm;
  end;    
end;

procedure TBasReturnListGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Active' , ['T','F','']);
  inherited;
end;



procedure TBasReturnListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TBasReturnListGUI.btndeleteClick(Sender: TObject);
var
  Option:Word;
  fstablename :String;
begin
  inherited;
  Option := MessageDlgXP_Vista('Select the delete option', mtConfirmation, [], 0 , nil , '' , '' , False, nil, 'All from Summary, All Selected, All , Cancel');
  if option = 103 then exit;
  with CommonDbLib.TempMyScript do try
      fsTablename := ERPFIXTablenameforCurVersion('tblbasreports');
      SQL.Add('Create table if not exists    ' + fsTablename +' like tblbasreports;');
      SQL.Add('insert ignore into    ' + fsTablename +' select * from tblbasreports;');

      fsTablename := ERPFIXTablenameforCurVersion('tblbasreportlines');
      SQL.Add('create table  if not exists    ' + fsTablename +' like tblbasreportlines;');
      SQL.Add('insert ignore into    ' + fsTablename +' select * from tblbasreportlines;');

    if option = 100 then begin
      SQL.Add('delete from    tblbasreports where ID in (Select BasID from tblbasreportlines);');
      SQL.Add('delete from    tblbasreports where Active ="F";');
      SQL.Add('truncate       tblbasreportlines;');
    end else if option = 101 then begin
      if SelectedIDs('ID') = '' then exit;
      SQL.Add('delete from    tblbasreports where ID in (' + SelectedIDs('ID') + ');');
      SQL.Add('delete from    tblbasreportlines where BasID  not in (Select id from tblbasreports);');
    end else begin
      SQL.Add('truncate tblbasreports ;');
      SQL.Add('truncate tblbasreportlines;');
    end;
      showProgressbar(waitMSG, 3);
      try
        stepProgressbar;
        execute;
        stepProgressbar;
        btnRequery.Click;
      finally
        HideProgressbar;
      end;
  finally
    free;
 end;
end;

procedure TBasReturnListGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TBasReturnListGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TBasReturnListGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  OpenErpListform('TBASTransReturnListGUI' , beforeOpenDetails);
end;
initialization
  RegisterClassOnce(TBasReturnListGUI);
end.
