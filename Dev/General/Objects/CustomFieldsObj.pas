unit CustomFieldsObj;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 11/10/05  1.00.01 DSP  First version. The TCustomFields class creates a form
                        dynamically and allows the user to specify the labels
                        to be used for as many as 10 custom fields. The fields
                        can be selected for display by the use of check boxes.

}

interface

uses
  Classes, Controls, StdCtrls, Buttons, DNMSpeedButton, Graphics, SysUtils, MyAccess,ERPdbComponents,
  BaseFormForm, tcConst;

type
  TCustomRecord = record
    lblHeader: TLabel;
    chkCustom: array[1..cCustomFieldsMax] of TCheckBox;
  end;

  PtrCustomRecord = ^TCustomRecord;

  TCustomFields = class(TObject)
  private
    FFormType: string;
    FBitmapClass: string;
    FCustomForm: TBaseForm;
    FCheckBoxList: TList;
    FHeaderLeft: integer;
    procedure CustomFormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    function FormHasData: boolean;
    procedure LoadCustomFieldsData;
    procedure SaveCustomFieldsData;
  protected
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    lblCustom: array[1..cCustomFieldsMax] of TLabel;
    edtCustom: array[1..cCustomFieldsMax] of TEdit;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddColumn(const Header: string);
    procedure ShowModal(const Caption: TCaption);
    property FormType: string read FFormType write FFormType;
  end;

implementation

uses
  DataTreeObj, AppEnvironment, Forms, FastFuncs;

{ TCustomFields }

procedure TCustomFields.AddColumn(const Header: string);
var
  Index: integer;
  CheckBoxLeft: integer;
  CustomRecordPtr: PtrCustomRecord;
begin
  //
  // Create a new custom record pointer and set the default values for the
  // header label.
  //
  New(CustomRecordPtr);
  CustomRecordPtr.lblHeader := TLabel.Create(FCustomForm);
  CustomRecordPtr.lblHeader.Parent := FCustomForm;
  CustomRecordPtr.lblHeader.Caption := Header;
  CustomRecordPtr.lblHeader.Transparent := true;
  CustomRecordPtr.lblHeader.Left := FHeaderLeft;
  CustomRecordPtr.lblHeader.Top := 10;
  CustomRecordPtr.lblHeader.Font.Name := 'Arial';
  CustomRecordPtr.lblHeader.Font.Style := [fsBold];
  CustomRecordPtr.lblHeader.Font.Size := 9;

  //
  // Set the calculated values for the left position for the check boxes and
  // the header label.
  //
  CheckBoxLeft := FHeaderLeft + (CustomRecordPtr.lblHeader.Width div 2) - 7;
  FHeaderLeft := FHeaderLeft + CustomRecordPtr.lblHeader.Width + 10;

  //
  // Create the check boxes and set their default values.
  //
  for Index := 1 to cCustomFieldsMax do begin
    CustomRecordPtr.chkCustom[Index]         := TCheckBox.Create(FCustomForm);
    CustomRecordPtr.chkCustom[Index].Parent  := FCustomForm;
    CustomRecordPtr.chkCustom[Index].Caption := '';
    CustomRecordPtr.chkCustom[Index].Left    := CheckBoxLeft;
    CustomRecordPtr.chkCustom[Index].Top     := 5 + (Index * 30);
    CustomRecordPtr.chkCustom[Index].Width   := 15;
  end;

  //
  // Adjust the width of the form and placement of the 'OK' and 'Cancel'
  // buttons depending on how many columns of check boxes are required.
  //
  FCustomForm.Width := FHeaderLeft + 30;
  btnOK.Left := (FCustomForm.Width - 207) div 2;
  btnCancel.Left := btnOK.Left + 120;

  FCheckBoxList.Add(CustomRecordPtr);
end;

procedure TCustomFields.btnOKClick(Sender: TObject);
begin
  if FormHasData then SaveCustomFieldsData;
end;

constructor TCustomFields.Create;
var
  Index: integer;
begin
  Inherited;
  //
  // Set default values and create a list for the check boxes.
  //
  FBitmapClass := 'MarbleGrey';
  FFormType := 'Sales';
  FHeaderLeft := 320;
  FCheckBoxList := TList.Create;

  //
  // Create the form to be displayed and size and position it.
  //
  FCustomForm := TBaseForm.Create(nil);
  FCustomForm.Width := 370;
  FCustomForm.Height := 434;
  FCustomForm.BorderStyle := bsSingle;
  FCustomForm.BorderIcons := FCustomForm.BorderIcons - [biMaximize];
  FCustomForm.Position := poScreenCenter;
  FCustomForm.OnShow := CustomFormShow;

  //
  // Create and set default values for the 'OK' button.
  //
  btnOK := TDNMSpeedButton.Create(FCustomForm);
  btnOK.Parent := FCustomForm;
  btnOK.Caption := 'OK';
  btnOK.Kind := bkOK;
  btnOK.OnClick := btnOKClick;
  btnOK.Font.Name := 'Arial';
  btnOK.Font.Style := [fsBold];
  btnOK.Font.Size := 9;
  btnOK.Color := clWhite;
  btnOK.HotTrackColor := clBtnShadow;
  btnOK.SlowDecease := True;
  btnOK.Style := bsModern;
  btnOK.Left := 82;
  btnOK.Top := 360;
  btnOK.Width := 87;
  btnOK.Height := 27;

  //
  // Create and set default values for the 'Cancel' button.
  //
  btnCancel := TDNMSpeedButton.Create(FCustomForm);
  btnCancel.Parent := FCustomForm;
  btnCancel.Caption := 'Cancel';
  btnCancel.Kind := bkCancel;
  btnCancel.Font.Name := 'Arial';
  btnCancel.Font.Style := [fsBold];
  btnCancel.Font.Size := 9;
  btnCancel.Color := clWhite;
  btnCancel.HotTrackColor := clBtnShadow;
  btnCancel.SlowDecease := True;
  btnCancel.Style := bsModern;
  btnCancel.Left := 202;
  btnCancel.Top := 360;
  btnCancel.Width := 87;
  btnCancel.Height := 27;

  for Index := 1 to cCustomFieldsMax do begin
    //
    // Create and set default values for the 10 labels.
    //
    lblCustom[Index]           := TLabel.Create(FCustomForm);
    lblCustom[Index].Parent    := FCustomForm;
    lblCustom[Index].Transparent := true;
    lblCustom[Index].Caption   := 'Custom Label ' + IntToStr(Index);
    lblCustom[Index].Font.Name := 'Arial';
    lblCustom[Index].Font.Style := [fsBold];
    lblCustom[Index].Font.Size := 9;
    lblCustom[Index].AutoSize  := false;
    lblCustom[Index].Left      := 30;
    lblCustom[Index].Top       := 5 + (Index * 30);
    lblCustom[Index].Width     := 96;
    lblCustom[Index].Alignment := taRightJustify;

    //
    // Create and set default values for the 10 edit boxes.
    //
    edtCustom[Index]           := TEdit.Create(FCustomForm);
    edtCustom[Index].Parent    := FCustomForm;
    edtCustom[Index].Text      := '';
    edtCustom[Index].Font.Name := 'Arial';
    edtCustom[Index].Font.Style := [fsBold];
    edtCustom[Index].Font.Size := 9;
    edtCustom[Index].Left      := 134;
    edtCustom[Index].Top       := 1 + (Index * 30);
    edtCustom[Index].Width     := 172;
  end;
end;

procedure TCustomFields.CustomFormShow(Sender: TObject);
begin
  LoadCustomFieldsData;
end;

destructor TCustomFields.Destroy;
begin
  //
  // Dispose of the allocated memory for the record pointers. The components
  // will be handled by their owner the form.
  //
  while FCheckBoxList.Count > 0 do begin
    Dispose(FCheckBoxList[0]);
    FCheckBoxList.Delete(0);
  end;

  FCustomForm.Release;
  inherited;
end;

function TCustomFields.FormHasData: boolean;
var
  Index: integer;
begin
  Result := false;
  Index := 1;

  //
  // Are there any values in the edit boxes?
  //
  while (Index <= cCustomFieldsMax) and (not Result) do begin
    Result := (edtCustom[Index].Text <> '');
    Inc(Index);
  end;
end;

procedure TCustomFields.LoadCustomFieldsData;
var
  FieldIndex: integer;
  ListIndex: integer;
  HeaderCaption: string;
  CustomNode: TDataTreeNode;
begin
  CustomNode := TDataTreeNode.Create;

  try
    if FCheckBoxList.Count > 0 then begin
      //
      // Load the data from tblpreferences.
      //
      CustomNode.Storer.Load(0, 0, cPrefGroupCustomFields, FormType, Appenv.CompanyInfo.IndustryId);

      //
      // Assign the values loaded to the edit boxes.
      //
      for FieldIndex := 1 to cCustomFieldsMax do edtCustom[FieldIndex].Text :=
          CustomNode['Defines.Field' + IntToStr(FieldIndex)].Value;

      //
      // Set the values of the header labels and the check boxes.
      //
      for ListIndex := 0 to FCheckBoxList.Count - 1 do begin
        for FieldIndex := 1 to cCustomFieldsMax do begin
          HeaderCaption := PtrCustomRecord(FCheckBoxList[ListIndex]).lblHeader.Caption;

          if CustomNode['Usage.' + HeaderCaption + '.Field' + IntToStr(FieldIndex)].Value = 'T' then
            PtrCustomRecord(FCheckBoxList[ListIndex]).chkCustom[FieldIndex].Checked := true
          else PtrCustomRecord(FCheckBoxList[ListIndex]).chkCustom[FieldIndex].Checked := false;
        end;
      end;
    end;
  finally
    FreeAndNil(CustomNode);
  end;
end;

procedure TCustomFields.SaveCustomFieldsData;
var
  FieldIndex: integer;
  ListIndex: integer;
  HeaderCaption: string;
  CustomNode: TDataTreeNode;
begin
  CustomNode := TDataTreeNode.Create;

  try
    begin
      CustomNode.NodeName := 'CustomFields';

      if FCheckBoxList.Count > 0 then begin
        //
        // Store the values of the custom fields
        //
        for FieldIndex := 1 to cCustomFieldsMax do CustomNode['Defines.Field' + IntToStr(FieldIndex)].Value :=
            edtCustom[FieldIndex].Text;

        //
        // Store the values of the header labels and the check box states.
        //
        for ListIndex := 0 to FCheckBoxList.Count - 1 do begin
          for FieldIndex := 1 to cCustomFieldsMax do begin
            HeaderCaption := PtrCustomRecord(FCheckBoxList[ListIndex]).lblHeader.Caption;

            if PtrCustomRecord(FCheckBoxList[ListIndex]).chkCustom[FieldIndex].Checked then
              CustomNode['Usage.' + HeaderCaption + '.Field' + IntToStr(FieldIndex)].Value := 'T'
            else CustomNode['Usage.' + HeaderCaption + '.Field' + IntToStr(FieldIndex)].Value := 'F';
          end;
        end;
      end;
    end;

    //
    // Save the data to tblpreferences.
    //
    CustomNode.Storer.Save(0, 0, cPrefGroupCustomFields, FormType, AppEnv.CompanyInfo.IndustryId);
  finally
    FreeAndNil(CustomNode);
  end;
end;

procedure TCustomFields.ShowModal(const Caption: TCaption);
begin
  FCustomForm.Caption := Caption;
  FCustomForm.ShowModal;
end;

end.

