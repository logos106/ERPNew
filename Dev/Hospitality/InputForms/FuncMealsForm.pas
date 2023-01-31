unit FuncMealsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB,  StdCtrls,
  Grids, Wwdbigrd, Wwdbgrid, ExtCtrls, DNMPanel, Buttons, DNMSpeedButton, DBAccess,
  MyAccess, DataState, Menus, AdvMenus, MemDS, Shader;

type
  TFuncMealsGUI = class(TBaseInputGUI)
    grdMeals: TwwDBGrid;
    grdCourses: TwwDBGrid;
    qryMeals: TMyQuery;
    qryCourses: TMyQuery;
    dsMeals: TDataSource;
    dsCourses: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    btnCancel: TDNMSpeedButton;
    btnSave: TDNMSpeedButton;
    qryMealsFuncMealID: TAutoIncField;
    qryMealsMealName: TStringField;
    qryMealsMealOrder: TWordField;
    qryCoursesFuncCourseID: TAutoIncField;
    qryCoursesCourseName: TStringField;
    qryCoursesCourseOrder: TWordField;
    grdMealsIButton: TwwIButton;
    grdCoursesIButton: TwwIButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure qryCoursesCourseOrderChange(Sender: TField);
    procedure qryMealsMealOrderChange(Sender: TField);
    procedure btnCancelClick(Sender: TObject);
    procedure grdMealsIButtonClick(Sender: TObject);
    procedure grdCoursesIButtonClick(Sender: TObject);
  private
    { Private declarations }
    bCourseChangeInProgress: boolean;
    bMealChangeInProgress: boolean;
    function SaveData: boolean;
  public
    { Public declarations }
  end;

implementation

uses
   DNMExceptions, DNMLib, CommonLib;


{$R *.dfm}

{ TFuncMealsGUI }

procedure TFuncMealsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fbTabSettingEnabled := false;
  bCourseChangeInProgress := false;
  bMealChangeInProgress := false;
end;

procedure TFuncMealsGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not ErrorOccurred then begin
    CloseQueries;
  end;
  Action := caFree;
  inherited;
end;

procedure TFuncMealsGUI.FormShow(Sender: TObject);
begin
  try
    inherited;
    BeginTransaction;
    OpenQueries;
  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do begin
      HandleNoAccessException(e);
      Exit;
    end;
    else raise;
  end;
end;

procedure TFuncMealsGUI.btnSaveClick(Sender: TObject);
begin
  inherited;
  if SaveData() then begin
    self.Close;
  end;
end;

function TFuncMealsGUI.SaveData: boolean;
begin
  Result := false;
  try
    if qryMeals.Active and not (qryMeals.State in [dsBrowse]) then begin
      qryMeals.Post;
    end;

    if qryCourses.Active and not (qryCourses.State in [dsBrowse]) then begin
      qryCourses.Post;
    end;

    CommitTransaction;
    Notify;
    Result := true;
  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do begin
      HandleNoAccessException(e);
      Exit;
    end;
    else raise;
  end;
end;

procedure TFuncMealsGUI.qryCoursesCourseOrderChange(Sender: TField);
begin
  inherited;
  if not bCourseChangeInProgress then begin
    bCourseChangeInProgress := true;
    qryCourses.Post;
    qryCourses.Close;
    qryCourses.Open;
    qryCourses.Last;
    bCourseChangeInProgress := false;
  end;
end;

procedure TFuncMealsGUI.qryMealsMealOrderChange(Sender: TField);
begin
  inherited;
  if not bMealChangeInProgress then begin
    bMealChangeInProgress := true;
    qryMeals.Post;
    qryMeals.Close;
    qryMeals.Open;
    qryMeals.Last;
    bMealChangeInProgress := false;
  end;
end;

procedure TFuncMealsGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  RollbackTransaction;
  Self.Close;
end;

procedure TFuncMealsGUI.grdMealsIButtonClick(Sender: TObject);
begin
  inherited;
  DeleteRecord(qryMeals);
end;

procedure TFuncMealsGUI.grdCoursesIButtonClick(Sender: TObject);
begin
  inherited;
  DeleteRecord(qryCourses);
end;

initialization
  RegisterClassOnce(TFuncMealsGUI);
end.
