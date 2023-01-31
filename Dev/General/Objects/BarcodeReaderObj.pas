unit BarcodeReaderObj;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 21/10/05  1.00.01 DSP  First version. This object's function is to allow the
                        association of items by the entry of a series of
                        barcodes.
 20/01/06  1.00.02 DSP  Modified to work only for job allocation (may make it
                        more generic in the future).
 27/01/06  1.00.03 DSP  Replaced 'job' with 'repair' in the dialog boxes and
                        the field 'Done' is now used in place of 'Active'.
 06/02/06  1.00.04 DSP  Moved Reset and Close buttons up to centralise them
                        vertically. 

}

interface

uses
  Classes, Windows, Controls, StdCtrls, Buttons, DNMSpeedButton, Contnrs, Graphics, Forms,
  SysUtils, DB, StrUtils, Dialogs, DNMPanel, BaseFormForm, MyAccess;

type
  TBarcodeReader = class(TComponent)
  private
    FBarcodeForm: TBaseForm;
    FTitlePanel: TDNMPanel;
    FContainerPanel: TDNMPanel;
    FResetBtn: TDNMSpeedButton;
    FCloseBtn: TDNMSpeedButton;
    FEmployeeLabel: TLabel;
    FJobLabel: TLabel;
    FActionLabel: TLabel;
    FEmployeeValue: TLabel;
    FJobValue: TLabel;
    FActionValue: TLabel;
    FBarcodeEdit: TEdit;
    FFieldList: TStrings;
    FActionList: TStrings;
    FActionIndex: Integer;
    FTableName: string;
    FQryTable: TMyQuery;
    function GetTitle: string;
    procedure SetTitle(const Value: string);
    procedure ProcessBarcode;
    procedure BarcodeKeyPress(Sender: TObject; var Key: char);
    procedure ResetBtnClick(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure ResetLabels;
    function MakeLabel(const LabelCaption: string; const LabelLeft: Integer;
                       const LabelTop: Integer; const FontColor: TColor = clBlack): TLabel;
    procedure AddLabels;
    procedure ProcessJobName(const JobName: string);
  protected
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PopulateForm; 
    procedure RefreshQuery(const MatchID: string); 
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Show;
    procedure ShowModal;
    procedure Hide;
    procedure AddAction(const LabelCaption: string; const FieldName: string; const Prefix: string);
    procedure ClearLabels;
    property Title: string read GetTitle write SetTitle;
    property TableName: string read FTableName write FTableName;
  end;

implementation

uses
  CommonLib, CommonDbLib, DNMLib, FastFuncs;

{ TBarcodeReader }

procedure TBarcodeReader.AddAction(const LabelCaption: string; const FieldName: string; const Prefix: string);

begin
  FActionList.Add(LabelCaption);
  FFieldList.Add(FieldName + '=' + Prefix);
end;

procedure TBarcodeReader.AddLabels;
begin
  FJobLabel := MakeLabel('Repair: ', 10, 25);
  FEmployeeLabel := MakeLabel('Employee: ', 10, 55);
  FActionLabel := MakeLabel('Action: ', 10, 85);
  FJobValue := MakeLabel('', 100, 25, clNavy);
  FEmployeeValue := MakeLabel('', 100, 55, clNavy);
  FActionValue := MakeLabel('', 100, 85, clBlue);
end;

procedure TBarcodeReader.BarcodeKeyPress(Sender: TObject; var Key: char);
begin
  if Ord(Key) = VK_RETURN then begin
    ProcessBarcode;
    Key := #0;
  end;
  if Ord(Key) = VK_ESCAPE then begin
    FBarcodeForm.Close;
    Exit;
  end;
end;

procedure TBarcodeReader.ClearLabels;
begin
  FFieldList.Clear;
  FActionList.Clear;
  FActionIndex := -1;
  FContainerPanel.Height := 132;
  FBarcodeForm.Height := 354;
end;

procedure TBarcodeReader.CloseBtnClick(Sender: TObject);
begin
  FBarcodeForm.Close;
end;

constructor TBarcodeReader.Create(AOwner: TComponent);
begin
  inherited;
  FActionIndex := 0;
  FTableName := '';
  FBarcodeForm := TBaseForm.Create(Self);
  FFieldList := TStringList.Create;
  FActionList := TStringList.Create;
  FQryTable := TMyQuery.Create(Self);
  FQryTable.Connection := GetSharedMyDacConnection;

  with FBarcodeForm do begin
    Width       := 546;
    Height      := 354;
    OnPaint     := FormPaint;
    OnClose     := FormClose;
    Caption     := 'Barcode Reader';
    BorderStyle := bsSingle;
    BorderIcons := BorderIcons - [biMaximize];
    Position    := poScreenCenter;
  end;

  PopulateForm;
end;

destructor TBarcodeReader.Destroy;
begin
  FreeandNil(FFieldList);
  FreeandNil(FActionList);
  inherited;
end;

procedure TBarcodeReader.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FActionIndex > 0 then begin
    if CommonLib.MessageDlgXP_Vista('Cancel barcode entry?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then Action := caNone;
  end;
end;

function TBarcodeReader.GetTitle: string;
begin
  Result := FTitlePanel.Caption;
end;

procedure TBarcodeReader.Hide;
begin
  FBarcodeForm.Hide;
end;

function TBarcodeReader.MakeLabel(const LabelCaption: string; const LabelLeft: Integer;
                                  const LabelTop: Integer; const FontColor: TColor = clBlack): TLabel;
begin
  Result := TLabel.Create(FBarcodeForm);

  with Result do begin
    Parent      := FContainerPanel;
    Caption     := LabelCaption;
    Left        := LabelLeft;
    Top         := LabelTop;
    Height      := 26;
    Transparent := True;
    Font.Name   := 'Arial';
    Font.Size   := 12;
    Font.Color  := FontColor;
    Font.Style  := [fsBold];
  end;
end;

procedure TBarcodeReader.PopulateForm;
begin
  FTitlePanel := TDNMPanel.Create(FBarcodeForm);

  with FTitlePanel do begin
    Parent     := FBarcodeForm;
    Caption    := 'Barcode Reader';
    Left       := 104;
    Top        := 4;
    Width      := 323;
    Height     := 39;
    Font.Name  := 'Arial';
    Font.Size  := 22;
    Font.Style := [fsBold];
  end;

  FBarcodeEdit := TEdit.Create(FBarcodeForm);

  with FBarcodeEdit do begin
    Parent     := FBarcodeForm;
    OnKeyPress := BarcodeKeyPress;
    Left       := 25;
    Top        := 71;
    Width      := 486;
    Height     := 50;
    Text       := '';
    Font.Name  := 'Arial';
    Font.Size  := 28;
  end;

  FContainerPanel := TDNMPanel.Create(FBarcodeForm);

  with FContainerPanel do begin
    Parent     := FBarcodeForm;
    Left       := 71;
    Top        := 138;
    Width      := 393;
    Height     := 132;
    Caption    := '';
    BevelOuter := bvLowered;
  end;

  FResetBtn := TDNMSpeedButton.Create(FBarcodeForm);

  with FResetBtn do begin
    Parent        := FBarcodeForm;
    Caption       := '&Reset';
    OnClick       := ResetBtnClick;
    Font.Name     := 'Arial';
    Font.Style    := [fsBold];
    Font.Size     := 9;
    Color         := clWhite;
    HotTrackColor := clBtnShadow;
    SlowDecease   := True;
    Style         := bsModern;
    Left          := 113;
    Top           := 285;
    Width         := 97;
    Height        := 29;
  end;

  FCloseBtn := TDNMSpeedButton.Create(FBarcodeForm);

  with FCloseBtn do begin
    Parent     := FBarcodeForm;
    Caption    := '&Close';
    OnClick    := CloseBtnClick;
    Font.Name  := 'Arial';
    Font.Style := [fsBold];
    Font.Size  := 9;
    Color         := clWhite;
    HotTrackColor := clBtnShadow;
    SlowDecease   := True;
    Style         := bsModern;
    Left       := 324;
    Top        := 285;
    Width      := 97;
    Height     := 29;
  end;

  AddLabels;
end;

procedure TBarcodeReader.ProcessBarcode;
var
  FieldName: string;
  BarcodeLength: Integer;
  BarcodeNumber: Integer;
  EmployeeID: Integer;
  EmployeeName: string;
  JobName: string;
  TimeTaken: TDateTime;
  Hours: Word;
  Minutes: Word;
  Seconds: Word;
  MSecs: Word;
begin
  FieldName := FFieldList.Names[FActionIndex];
  BarcodeLength := FastFuncs.StrLength(FBarcodeEdit.Text) - 4;
  BarcodeNumber := StrToIntDef(RightStr(FBarcodeEdit.Text, BarcodeLength), 0);

  if FastFuncs.SameText(LeftStr(FBarcodeEdit.Text, 4), FFieldList.Values[FieldName]) and
     (BarcodeNumber > 0) then begin

    if FActionIndex = 0 then begin
      RefreshQuery(RightStr(FBarcodeEdit.Text, BarcodeLength));
      JobName := GetJobName(BarcodeNumber);

      if JobName <> '' then begin
        if FQryTable.FieldByName('AllocatedEmployeeID').AsInteger > 0 then begin
          if FQryTable.FieldByName('Done').AsBoolean = False  then begin
            if CommonLib.MessageDlgXP_Vista('This repair is active. Has it been completed?',
                          mtInformation, [mbYes, mbNo], 0) = mrYes then begin
              with FQryTable do begin
                Edit;
                FieldByName('FinishDateTime').AsDateTime := Now;
                TimeTaken := FieldByName('FinishDateTime').AsDateTime - FieldByName('StartDateTime').AsDateTime;
                DecodeTime(TimeTaken, Hours, Minutes, Seconds, MSecs);
                Hours := Hours + (Trunc(TimeTaken) * 24);
                FieldByName('HoursTakenForRepair').AsString := Format('%d:%.2d:%.2d', [Hours, Minutes, Seconds]);
                FieldByName('Done').AsBoolean := True;
                Post;
              end;
            end
            else begin
              if CommonLib.MessageDlgXP_Vista('Do you want to replace the employee allocated?',
                            mtInformation, [mbYes, mbNo], 0) = mrYes then begin
                ProcessJobName(JobName);
              end;
            end;
          end
          else
            CommonLib.MessageDlgXP_Vista('This repair has been completed. Please enter another repair number.', mtInformation, [mbOK], 0);
        end
        else begin
          ProcessJobName(JobName);
        end;
      end
      else
        CommonLib.MessageDlgXP_Vista('This repair number does not exist. Please re-enter.', mtInformation, [mbOK], 0);
    end else begin
      EmployeeID := BarcodeNumber;
      EmployeeName := GetEmployeeName(EmployeeID);

      if EmployeeName <> '' then begin
        with FQryTable do begin
          Edit;

          if FieldByName(FFieldList.Names[FActionIndex]).AsInteger = 0 then
            FieldByName('StartDateTime').AsDateTime := Now;

          FieldByName(FFieldList.Names[FActionIndex]).AsInteger := EmployeeID;
        end;

        FEmployeeValue.Caption := EmployeeName;

        if FActionIndex < FActionList.Count then begin
          Inc(FActionIndex);

          if FActionIndex >= FActionList.Count then begin
            FActionIndex := 0;

            if FQryTable.State in [dsEdit, dsInsert] then FQryTable.Post;
          end;

          FActionValue.Caption := FActionList[FActionIndex];
        end;
      end
      else begin
        CommonLib.MessageDlgXP_Vista('This employee does not exist. Please re-enter.', mtInformation, [mbOK], 0);
      end;
    end;
  end else CommonLib.MessageDlgXP_Vista('Invalid barcode', mtInformation, [mbOK], 0);

  FBarcodeEdit.Text := '';
end;

procedure TBarcodeReader.ProcessJobName(const JobName: string);
begin
  FJobValue.Caption := JobName;
  FEmployeeValue.Caption := '';

  if FActionIndex < FActionList.Count then begin
    Inc(FActionIndex);

    if FActionIndex >= FActionList.Count then
      FActionIndex := 0;

    FActionValue.Caption := FActionList[FActionIndex];
  end;
end;

procedure TBarcodeReader.RefreshQuery(const MatchID: string);
begin
  if (not Empty(FTableName)) and (FFieldList.Count > 0) then begin
    with FQryTable do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM ' + FTableName);
      SQL.Add('WHERE ' + FFieldList.Names[0] + '=' + MatchID);
      Open;
    end;
  end;
end;

procedure TBarcodeReader.ResetBtnClick(Sender: TObject);
begin
  ResetLabels;
  SetControlFocus(FBarcodeEdit);
end;

procedure TBarcodeReader.ResetLabels;
begin
    FJobValue.Caption := '';
    FEmployeeValue.Caption := '';
    FActionIndex := 0;
    FActionValue.Caption := FActionList[FActionIndex];
end;

procedure TBarcodeReader.SetTitle(const Value: string);
begin
  if Value <> FTitlePanel.Caption then begin
    FBarcodeForm.Caption := Value;
    FTitlePanel.Caption  := Value;
  end;
end;

procedure TBarcodeReader.Show;
begin
  ResetLabels;
  FBarcodeForm.Show;
end;

procedure TBarcodeReader.ShowModal;
begin
  ResetLabels;
  FBarcodeForm.fbIgnoreAccessLevels := True;
  FBarcodeForm.ShowModal;
end;

initialization
  RegisterClassOnce(TBarcodeReader);
end.

