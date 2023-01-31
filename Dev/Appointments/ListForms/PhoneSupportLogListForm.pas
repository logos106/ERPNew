unit PhoneSupportLogListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListDetails, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, MyAccess,ERPdbComponents, MemDS, DBAccess,
  wwdbdatetimepicker, ProgressDialog,wwMemo,  wwdblook,
  Shader, kbmMemTable, DAScript, MyScript, CustomInputBox, wwcheckbox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TPhSupportLogListGUI = class(TBaseListDetailsGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainSupportLogID: TIntegerField;
    qryMainCompany: TWideStringField;
    qryMainContact: TWideStringField;
    qryMainDateCreated: TDateTimeField;
    qryMainModule: TWideStringField;
    qryMainCallTime: TWideStringField;
    qryMainFinished: TWideStringField;
    qryMainEnteredBy: TWideStringField;
    qryMainVersion: TWideStringField;
    qryMainCallSecs: TIntegerField;
    qryMainType: TWideStringField;
    qryMainIssue: TWideMemoField;
    qryMainSolution: TWideMemoField;
    MemoDialog: TwwMemoDialog;
    qryMainAssignedto: TWideStringField;
    qryMainStatus: TWideStringField;
    qryMainContactPhone: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure HandleInitDialog(Dialog : TwwMemoDlg);
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    Function ExpressDetailListName:String;Override;
    procedure ApplyQueryFilter; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  frmPhSupportLog, DateUtils, CommonLib, Forms, FastFuncs, AppEnvironment;

procedure TPhSupportLogListGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('txtfrom').asDateTime := FilterDatefrom;
  qryMain.Params.ParamByName('txtto').AsDateTime   := FilterDateTo;
  inherited;
end;

procedure TPhSupportLogListGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  DisableForm;
  try
    inherited;
    Form := GetComponentByClassName('TPhSupportLogGUI');
    if Assigned(Form) then begin
      with TPhSupportLogGUI(Form) do begin
        AttachObserver(Self);
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  finally
    EnableForm;
  end;    
end;

procedure TPhSupportLogListGUI.RefreshTotals;
var
  TotalCallTime: integer;
begin
  TotalCallTime := 0;
  with qryMain do begin
    First;
    while not Eof do begin
      TotalCallTime := TotalCallTime + qryMain.FieldByName('CallSecs').AsInteger;
      Next;
    end;
    First;
  end;
  grdMain.ColumnByName('CallTime').FooterValue := SecondsToTime(TotalCallTime);
end;

procedure TPhSupportLogListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.FieldByName('CallTime').Alignment := taRightJustify;
end;

procedure TPhSupportLogListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fbEnableWebSearch := true;
end;

procedure TPhSupportLogListGUI.grdMainDblClick(Sender: TObject);
begin
    if (grdMain.GetActiveField.FieldName = 'Issue') then begin
       MemoDialog.DataField := 'Issue';
       MemoDialog.OnInitDialog := HandleInitDialog;
       MemoDialog.Execute ;
    end else If (grdMain.GetActiveField.FieldName = 'Solution') then begin
       MemoDialog.DataField := 'Solution';
       MemoDialog.OnInitDialog := HandleInitDialog;
       MemoDialog.Execute
    end else inherited;
end;

procedure TPhSupportLogListGUI.HandleInitDialog(Dialog: TwwMemoDlg);
var
  BtnArray: TDNMSpeedButton;
begin
  with Dialog do begin
    BtnArray := TDNMSpeedButton.Create(Dialog);
    BtnArray.Parent := Dialog;
    BtnArray.Color := clWhite;
    BtnArray.HotTrackColor := clBtnShadow;
    BtnArray.SlowDecease := true;
    BtnArray.Style := bsModern;
    BtnArray.Visible := true;
    BtnArray.Left := OKBtn.Left;
    BtnArray.Top := OKBtn.Top;
    BtnArray.Width := OKBtn.Width;
    BtnArray.Height := OKBtn.Height;
    BtnArray.Font.Name := 'Arial';
    BtnArray.Font.Size := 9;
    BtnArray.Font.Style := [fsBold];
    BtnArray.Caption := OKBtn.Caption;
    BtnArray.Enabled := OKBtn.Enabled;
    BtnArray.Kind := bkOK;
    BtnArray.OnClick := OKBtn.OnClick;
    OKBtn.Hide;
    OKBtn := TButton(BtnArray);
  end;
end;


procedure TPhSupportLogListGUI.ApplyQueryFilter;
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin {All}
        GroupFilterString := '';
      end;
    1:
      begin { Status  = "Open Support"}
        GroupFilterString := '(Status = ' + QuotedStr('Open Support') + ')';
      end;
    2:
      begin {Finished}
        GroupFilterString := '(Finished = "T")';
      end;
    3:
      begin {Not Finised}
        GroupFilterString := '(Finished = "F")';
      end;
  end;
  inherited;
end;

procedure TPhSupportLogListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TPhSupportLogListGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TPhSupportLogListGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

function TPhSupportLogListGUI.ExpressDetailListName: String;
begin
  REsult := 'TPhoneSupportLogListExpressGUI';
end;

procedure TPhSupportLogListGUI.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('SupportLogID');
  cmdnew.Enabled := False;  // input form is opened from customer on suppport with the customer selected
end;

initialization
  RegisterClassOnce(TPhSupportLogListGUI);
end.
