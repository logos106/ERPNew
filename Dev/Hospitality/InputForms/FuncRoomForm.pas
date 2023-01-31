unit FuncRoomForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB,  StdCtrls,
  Mask, DBCtrls, Buttons, DNMSpeedButton, ExtCtrls, DNMPanel, wwcheckbox, wwdbedit,
  wwdblook, Wwdbspin, wwdbdatetimepicker, DBAccess, MyAccess,ERPdbComponents, DataState,
  Menus, AdvMenus, MemDS, Shader, ImgList;

type
  TfrmFuncRoomGUI = class(TBaseInputGUI)
    dsFuncRooms: TDataSource;
    DNMPanel2: TDNMPanel;
    lblRoomName: TLabel;
    cmdOk: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    lblResetTime: TLabel;
    Label1: TLabel;
    lblPerHalfDay: TLabel;
    lblPerHour: TLabel;
    Label2: TLabel;
    chkActive: TwwCheckBox;
    edtPerHour: TwwDBEdit;
    edtPerHalfDay: TwwDBEdit;
    edtPerDay: TwwDBEdit;
    edtRoomName: TwwDBEdit;
    DNMPanel3: TDNMPanel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label3: TLabel;
    edtCapacity: TwwDBSpinEdit;
    Label4: TLabel;
    cboParentRoom: TwwDBLookupCombo;
    qryParentRooms: TERPQuery;
    qryFuncRooms: TERPQuery;
    qryFuncRoomsRoomID: TAutoIncField;
    qryFuncRoomsActive: TWideStringField;
    qryFuncRoomsName: TWideStringField;
    qryFuncRoomsPerHour: TFloatField;
    qryFuncRoomsPerHalfDay: TFloatField;
    qryFuncRoomsPerDay: TFloatField;
    qryFuncRoomsResetTime: TTimeField;
    qryFuncRoomsCapacity: TIntegerField;
    qryFuncRoomsParentRoomID: TIntegerField;
    dtpResetTime: TwwDBDateTimePicker;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdOkClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  FormFactory, DNMExceptions, 
  CommonLib;

{$R *.dfm}

procedure TfrmFuncRoomGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      // Inherit from our Base Input Class.
      inherited;

      // Is the qryFuncRooms Active?
      if qryFuncRooms.Active then begin
        // Is qryFuncRooms State not in Browse mode?
        if not (qryFuncRooms.State in [dsBrowse]) then begin
          // No, then post.
          qryFuncRooms.Post;
          // Send Notification.
          Notify;
        end;
        // close the Queries
        CloseQueries;
      end;

      // Setup our Parameters
      qryFuncRooms.ParamByName('xRoomID').asInteger := KeyID;
      qryParentRooms.ParamByName('xRoomID').asInteger := KeyID;

      // Open our Queries.
      //Setlength(DonotOpenQueries, 1);
      //DonotOpenQueries[0] := 'qryParentRooms';
      OpenQueries;

      // Are we creating a new record?
      if KeyID = 0 then begin
        // Yes, Setup new record if we have data present.
        if edtRoomName.Text <> '' then begin
          qryFuncRooms.Insert;
        end;
      end else begin
        // Otherwise we are going to edit the record.
        qryFuncRooms.Edit;
      end;
      // Exception Handler
    except
      // Handle these known exceptions.
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmFuncRoomGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  // Close down our query controls.
  CloseQueries;
  // Free form from memory.
  Action := caFree;
  // NIL our Form Object.
//  frmFuncRoomGUI := nil;
end;

procedure TfrmFuncRoomGUI.cmdOkClick(Sender: TObject);
begin
  try
    // Ensure the user has provided a roomname.
    if not Empty(edtRoomName.Text) then begin
      if not (qryFuncRooms.State in [dsBrowse]) then begin
        //qryFuncRooms.Edit;
        qryFuncRooms.Post;
        Notify;
      end;
      // Close our form down.
      Self.Close;
    end else begin
      CommonLib.MessageDlgXP_Vista('You must provide a Room Name', mtWarning, [mbOK], 0);
      SetControlFocus(edtRoomName);
    end;
  except
    // Handle Exceptions
    on EAbort do HandleEAbortException;
    else raise;
  end;
end;

procedure TfrmFuncRoomGUI.cmdCancelClick(Sender: TObject);
begin
  inherited;
  // Close down our form.
  Self.Close;
end;

procedure TfrmFuncRoomGUI.cmdNewClick(Sender: TObject);
begin
  try
    inherited;
    if not (qryFuncRooms.State in [dsBrowse]) then begin
      // State that we are setting a new record.
      KeyID := 0;
      FormShow(nil);
      // Set focus on our roomname DB Aware control.
      SetControlFocus(edtRoomName);
    end;
  except
    // Handle these known exceptions.
    on EAbort do HandleEAbortException;
    else raise;
  end;
end;

initialization
  RegisterClassOnce(TfrmFuncRoomGUI);
  with FormFact do begin
    RegisterMe(TfrmFuncRoomGUI, 'TfrmFuncRoomListGUI_*=RoomID');
  end;
end.
