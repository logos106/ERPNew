unit frmAttachments;

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // ??/04/05  1.00.00 IJB  Initial version.
  // 28/04/05  1.00.01 IJB  Fixed bug in EnableAccept procedure.
  // 19/12/05  1.00.08  AL   Removed "Instance", added RegisterClass  *Task306*

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DataState, DBAccess, MyAccess,ERPdbComponents, SelectionDialog,
  AppEvnts, DB,  StdCtrls, Mask, DBCtrls, wwcheckbox, Buttons, DNMSpeedButton,
  ExtCtrls, DNMPanel, ActnList, ComCtrls,AdvOfficeStatusBar, ImgList, DMComps,
  wwclearbuttongroup, wwradiogroup, ToolWin, Menus, AdvMenus, Shader, dmGUIStylers,
  MemDS, ProgressDialog;

type
  TViewActiveMode = (vmActive,vmInactive,vmBoth);


  TfmAttachments = class(TBaseInputGUI)
    pnlBottom: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnDelete: TDNMSpeedButton;
    pnlTop: TDNMPanel;
    alMain: TActionList;
    actMainSave: TAction;
    actMainNew: TAction;
    actMainCancel: TAction;
    lvAttachments: TListView;
    DMTextTarget: TDMTextTarget;
    ilLarge: TImageList;
    ilSmall: TImageList;
    actDeleteAttachment: TAction;
    radView: TwwRadioGroup;
    Label121: TLabel;
    popAttachments: TAdvPopupMenu;
    View1: TMenuItem;
    LargeIcons1: TMenuItem;
    SmallIcons1: TMenuItem;
    N1: TMenuItem;
    Delete1: TMenuItem;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    actShowActive: TAction;
    actShowInactive: TAction;
    actShowBoth: TAction;
    ShowActive1: TMenuItem;
    ShowInactive1: TMenuItem;
    ShowActiveandInactive1: TMenuItem;
    actFlagActive: TAction;
    actFlagInactive: TAction;
    FlagasActive1: TMenuItem;
    FlagasInactive1: TMenuItem;
    N2: TMenuItem;
    FileOpen: TOpenDialog;
    N3: TMenuItem;
    Add1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure actMainSaveExecute(Sender: TObject);
    procedure actMainCancelExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure DMTextTargetDrop(Sender: TObject; Acceptor: TWinControl; const DropText: string; X, Y: integer);
    procedure radViewClick(Sender: TObject);
    procedure lvAttachmentsDblClick(Sender: TObject);
    procedure actDeleteAttachmentExecute(Sender: TObject);
    procedure lvAttachmentsSelectItem(Sender: TObject; Item: TListItem; Selected: boolean);
    procedure lvAttachmentsExit(Sender: TObject);
    procedure LargeIcons1Click(Sender: TObject);
    procedure SmallIcons1Click(Sender: TObject);
    procedure lvAttachmentsKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure DMTextTargetDragOver(Sender: TObject; Effect: TDropEffect; X, Y: integer);
    procedure lvAttachmentsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure actShowActiveExecute(Sender: TObject);
    procedure actShowInactiveExecute(Sender: TObject);
    procedure actShowBothExecute(Sender: TObject);
    procedure actFlagActiveExecute(Sender: TObject);
    procedure actFlagInactiveExecute(Sender: TObject);
    procedure lvAttachmentsAdvancedCustomDraw(Sender: TCustomListView;
      const ARect: TRect; Stage: TCustomDrawStage; var DefaultDraw: Boolean);
    procedure Add1Click(Sender: TObject);
  private
    { Private declarations }
    fTableName: string;
    fTableId: integer;
    fDBConnection: TERPConnection;
    AttachmentsChanged: boolean;
    ViewActiveMode: TViewActiveMode;
    fbDragnDropping: Boolean;
    fOnSave: TNotifyEvent;
    procedure GetImageForFileType(ListItem: TListItem);
    function SaveAttachment(const FileName, AttachmentName: string; const DoDeleteFile: boolean = false): integer;
    procedure DeleteAttachment(AttachmentId: integer);
    procedure UpdateButtons;
    procedure SetTableId(const Value: integer);
    procedure SetTableName(const Value: string);
    procedure EnableAccept;
    function FlagActive(AttachmentId: integer; Active: boolean): boolean;
  protected
    procedure AttachFiles(aList : TStrings);
  public
    { Public declarations }
    procedure UpdateMe; override;
    property TableName: string read fTableName write SetTableName;
    property TableId: integer read fTableId write SetTableId;
    function PopulateListView : integer;
    property DBConnection: TERPConnection read fDBConnection write fDBConnection;
    function SaveSelectedToTempFiles(aFileList: TStringList): boolean;
    Property DragnDropping :Boolean read fbDragnDropping write fbDragnDropping;
    Property OnSave :TNotifyEvent read fOnSave write fOnSave;
  end;

implementation

{$R *.dfm}

uses
  DNMExceptions, ActiveX, DMUtil, ShellAPI, ShlObj, SystemLib, DnMLib, CommonLib,
  FastFuncs, Appenvironment, BusObjDeletedItem, DbSharedObjectsObj;

procedure TfmAttachments.FormCreate(Sender: TObject);
begin
  fOnSave := nil;
  DragnDropping := false;
  ViewActiveMode := vmActive;
  DBConnection := nil;
  inherited;
  // If user does not have access to this form so don't process any further
  if ErrorOccurred then Exit;

  // Register to accept the custom formats that Outlook supplies.
  // We've also included dtfCustom in AcceptTextFormats at design time.
  with DMTextTarget, CustomFormats do begin
    OverrideDropEffects[deMove] := deCopy;
    Add('FileGroupDescriptor');
    AddObject('FileContents', TObject(TYMED_ISTREAM));
  end;

  AttachmentsChanged := false;
end;

function TfmAttachments.FlagActive(AttachmentId: integer; Active: boolean): boolean;
var
  qry: TERPQuery;
  act: string;
begin
  if Active then act := '"T"'
  else act := '"F"';
  qry := DbSharedObj.GetQuery(DBConnection);
  try
    qry.SQL.Add('update tblAttachments');
    qry.SQL.Add('set Active = ' + act);
    qry.SQL.Add(',msUpdateSiteCode = "' + AppEnv.Branch.SiteCode + '"');
    qry.SQL.Add('where AttachmentId = ' + IntToStr(AttachmentId));
    qry.SQL.Add('and Active <> ' + act);
    qry.Execute;
    result := qry.RowsAffected > 0;
//    if qry.RowsAffected > 0 then
//      self.PopulateListView;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure TfmAttachments.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if AttachmentsChanged then Notify;

  inherited;
  //RollbackTransaction;
  Action := caFree;
end;

procedure TfmAttachments.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      if DBConnection = nil then DBConnection := MyConnection;

      // If user does not have access to this form don't process any further
      if ErrorOccurred then Exit;

      // set controlls based on access level
      { 1  - (Full Access)
        2  - (Full Access, No Delete)
        3  - (Create + Read)
        5  - (Read Only)
        6  - (No Access)  }

      //if Self.AccessLevel =



      //RollbackTransaction;
      //BeginTransaction;

      if not(DragnDropping) and (PopulateListView <= 0) then
      begin
        if FileOpen.Execute then
          AttachFiles(FileOpen.Files);
      end;
      UpdateButtons;



      //DataState.Activate;
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

// ---------- Main Actions -----------------------------------------------------

procedure TfmAttachments.actMainSaveExecute(Sender: TObject);
begin
  inherited;
  if assigned(fOnSave) then fOnSave(Self);
  Close;
end;

procedure TfmAttachments.actShowInactiveExecute(Sender: TObject);
begin
  inherited;
  self.ViewActiveMode := vmInactive;
  PopulateListView;
  UpdateButtons;
end;

procedure TfmAttachments.Add1Click(Sender: TObject);
begin
  inherited;
  if FileOpen.Execute then
    AttachFiles(FileOpen.Files);
end;

procedure TfmAttachments.AttachFiles(aList: TStrings);
var
  ix : integer;
  ListItem: TListItem;
begin
  if (TableName = '') or (TableId < 1) then Exit;

  for ix := 0 to aList.Count - 1 do begin
    ListItem := lvAttachments.Items.Add;
    ListItem.Caption := ExtractFileName(aList[ix]);
    GetImageForFileType(ListItem);
    ListItem.Data := Pointer(SaveAttachment(aList[ix], ListItem.Caption, false));
  end;
end;

procedure TfmAttachments.actShowActiveExecute(Sender: TObject);
begin
  inherited;
  self.ViewActiveMode := vmActive;
  PopulateListView;
  UpdateButtons;
end;

procedure TfmAttachments.actShowBothExecute(Sender: TObject);
begin
  inherited;
  self.ViewActiveMode := vmBoth;
  PopulateListView;
  UpdateButtons;
end;

procedure TfmAttachments.actFlagActiveExecute(Sender: TObject);
var
  item: TListItem;
  changed: boolean;
begin
  inherited;
  changed := false;
  Item := lvAttachments.Selected;
  if not Assigned(Item) then Exit;

  if FlagActive(integer(Item.Data),true) then changed := true;;
  Item := lvAttachments.GetNextItem(Item,sdAll,[isSelected]);
  while Assigned(Item) do begin
    if FlagActive(integer(Item.Data),true) then changed := true;;
    Item := lvAttachments.GetNextItem(Item,sdAll,[isSelected]);
  end;
  if changed then
    self.PopulateListView;
end;

procedure TfmAttachments.actFlagInactiveExecute(Sender: TObject);
var
  item: TListItem;
  changed: boolean;
begin
  inherited;
  changed := false;
  Item := lvAttachments.Selected;
  if not Assigned(Item) then Exit;

  if FlagActive(integer(Item.Data),false) then changed := true;;
  Item := lvAttachments.GetNextItem(Item,sdAll,[isSelected]);
  while Assigned(Item) do begin
    if FlagActive(integer(Item.Data),false) then changed := true;;
    Item := lvAttachments.GetNextItem(Item,sdAll,[isSelected]);
  end;
  if changed then
    self.PopulateListView;
end;

procedure TfmAttachments.actMainCancelExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

// ---------- Form Methods/Functions -------------------------------------------

procedure TfmAttachments.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  inherited;
  if ErrorOccurred then Exit;
  CanClose := true;
end;

procedure TfmAttachments.UpdateMe;
begin
  // Close/re-open queryies to refresh data
end;

procedure TfmAttachments.GetImageForFileType(ListItem: TListItem);
var
  LargeIcon, SmallIcon: HICON;
  iconBig, iconSmall: TIcon;
  x: integer;
  ext: string;
begin
  iconBig        := TIcon.Create;
  iconSmall      := TIcon.Create;
  Try
    // do we already have an image for this extention type
    ext := ExtractFileExt(ListItem.Caption);
    if ext = '' then Exit;

    for x := 0 to lvAttachments.Items.Count - 1 do begin
      if ListItem.Index <> x then begin
        if ExtractFileExt(lvAttachments.Items[x].Caption) = ext then begin
          ListItem.ImageIndex := lvAttachments.Items[x].ImageIndex;
          Exit;
        end;
      end;
    end;

    // not same extension so get new icon
    LargeIcon := GetAssociatedIcon(ext, false);
    SmallIcon := GetAssociatedIcon(ext, true);
    if (LargeIcon <> 0) then begin
      iconBig.Handle := LargeIcon;
      //ListItem.ImageIndex:= LargeImageList.AddIcon(icon);
    end;
    if SmallIcon <> 0 then begin
      iconSmall.Handle := SmallIcon;
      //ListItem.ImageIndex:= LargeImageList.AddIcon(icon);
    end;
    if Assigned(iconBig) and Assigned(iconSmall) then begin
      // both icons found so add to list
      ListItem.ImageIndex := ilLarge.AddIcon(iconBig);
      ilSmall.AddIcon(iconSmall);
    end else begin
      //none or only one found so use default images
      // free icons
      ListItem.ImageIndex := 0;
    end;
  Finally
    if Assigned(iconBig) then
      FreeandNil(iconBig);
    if Assigned(iconSmall) then
      FreeandNil(iconSmall);
  end;
end;

procedure TfmAttachments.DMTextTargetDragOver(Sender: TObject; Effect: TDropEffect; X, Y: integer);
begin
  inherited;
  //
end;

procedure TfmAttachments.DMTextTargetDrop(Sender: TObject; Acceptor: TWinControl; const DropText: string; X, Y: integer);
var
  hasFormats: boolean;
  S, t: string;
  nFiles: DWORD;
  aFd: TFileDescriptor;
  j: integer;
  anIstream: IStream;
  tempFileName: string;
  ListItem: TListItem;
  ix: integer;
begin
  inherited;
  if (TableName = '') or (TableId < 1) then Exit;


  with (Sender as TDMTextTarget) do begin
    if (DroppedTextFormat = dtfFiles) then begin
      // It's a plain list of files - do the "usual" thing
      for ix := 0 to DroppedLines.Count - 1 do begin
        ListItem := lvAttachments.Items.Add;
        ListItem.Caption := ExtractFileName(DroppedLines[ix]);
        GetImageForFileType(ListItem);
        ListItem.Data := Pointer(SaveAttachment(DroppedLines[ix], ListItem.Caption, false));
      end;
    end else begin
      // It's not simple files, but MS Outlook's combination of a FileGroupDescriptor
      // and FileContents on an IStream.  We have to go get the attachments and then
      // put them on files ourselves.  It appears that Outlook 97 also puts a copy
      // of this file in the TEMP directory, but we ignore that here so we can
      // demonstrate the principles.

      // Do we have fgd?
      hasFormats := DataObjectHasFormat('FileGroupDescriptor');

      // Global override for tymed - reset automatically by calls to
      // DataObjectHasFormat and DataObjectGetFormat
      DataObjectTymed := TYMED_ISTREAM;
      // Do we have fc?  Do the call first, so we're guaranteed that it won't
      // be short-circuited, so that the global tymed and lindex get reset properly.
      hasFormats := DataObjectHasFormat('FileContents') and hasFormats;

      if hasFormats then begin
        // Get the file group descriptors
        s := string(DataObjectGetFormat('FileGroupDescriptor'));
        // How many fgd's in the returned data?  That's a DWORD at the head
        // of the string-encoded data
        nFiles := DecodeDWORDFromString(AnsiString(s));

        // Process them all
        for j := 1 to nFiles do // Iterate
        begin
          // Get the j'th file descriptor.  It starts after the initial DWORD,
          // and has the length of a TFileDescriptor.
          System.Move(s[SizeOf(DWORD) + 1 + (j - 1) * SizeOf(TFileDescriptor)], aFd,
            SizeOf(TFileDescriptor));

          // Its content is on an IStream, at lindex j-1
          // Global overrides for lindex and tymed
          DataObjectLindex := j - 1;
          DataObjectTymed := TYMED_ISTREAM;
          t := string(DataObjectGetFormat('FileContents'));

          // Watch out for nothing at that index...
          if (t <> '') then begin
            // Don't use "anIStream := IStream(DecodeDWORDFromString(s));" since that
            // would add another reference, due to Delphi's automatic reference handling.
            // Alternatively, do it that way, but immediately call anIStream._Release;
            DWORD(anIStream) := DecodeDWORDFromString(AnsiString(t));

            // Now, we have a singly-referenced Istream interface that we can read from.
            // We put it on a file somewhere.  For this example, we're using a
            // temporary file name that begins with 'dmx' and has the same extension
            // as the original and also adding it to the list.  Note that
            // GetTempFileNameEx also creates the file, so we rename it immediately.
            tempFileName := GetTempFileName(ExtractFileName(aFd.cFileName), ExtractFileExt(aFd.cFileName));
            ListItem := lvAttachments.Items.Add;
            SaveIStreamToFile(anIstream, tempFileName);
            ListItem.Caption := aFd.cFileName;
            GetImageForFileType(ListItem);
            ListItem.Data := Pointer(SaveAttachment(tempFileName, ListItem.Caption, true));
          end;
        end;    // for
      end;      // if hasFormats
    end         // if (DroppedTextFormat = dtfFiles)
  end;          // with
end;

procedure TfmAttachments.radViewClick(Sender: TObject);
begin
  inherited;
  case radView.ItemIndex of
    0: lvAttachments.ViewStyle := vsIcon;
    1: lvAttachments.ViewStyle := vsSmallIcon;
    2: lvAttachments.ViewStyle := vsList;
    3: lvAttachments.ViewStyle := vsReport;
  end;
end;

function TfmAttachments.SaveAttachment(const FileName, AttachmentName: string;
  const DoDeleteFile: boolean = false): integer;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry. Connection := DBConnection;
    qry.SQL.Text   := 'SELECT * FROM tblAttachments WHERE AttachmentId = 0';
    qry.Open;
    qry.Insert;
    qry.FieldByName('TableName').AsString      := Self.TableName;
    qry.FieldByName('TableId').AsInteger       := self.TableId;
    qry.FieldByName('AttachmentName').AsString := AttachmentName;
    qry.FieldByName('msUpdateSiteCode').AsString := AppEnv.Branch.SiteCode;
    try
      TBlobField(qry.FieldByName('Attachment')).LoadFromFile(FileName);
    except
      on e: exception do begin
        CommonLib.MessageDlgXP_Vista(e.Message, mtInformation, [mbOk], 0);
        qry.Cancel;
        exit;
      end;
    end;
    qry.Post;
//    Result := DnMLib.GetLastRecordPostID('tblAttachments',)
    Result := DnMLib.GetLastRecordPostID('tblAttachments', qry.Connection);
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('update tblAttachments set GlobalRef = ' + QuotedStr(AppEnv.Branch.SiteCode + IntToStr(result)));
    qry.SQL.Add('where AttachmentId = ' + IntToStr(result));
    qry.Execute;
    if DoDeleteFile then DeleteFile(FileName);
  finally
    FreeAndNil(qry);
  end;
  AttachmentsChanged := true;
end;

function TfmAttachments.SaveSelectedToTempFiles(
  aFileList: TStringList): boolean;
var
  qry: TERPQuery;
  Item: TListItem;

  procedure AddFile(aId: integer);
  var
    tempFileName: string;
  begin
    qry.ParamByName('Id').AsInteger := aId;
    qry.Open;
    tempFileName := qry.FieldByName('AttachmentName').AsString;
    tempFileName := GetTempFileName(ChangeFileExt(tempFileName,''), ExtractFileExt(tempFileName));
    TBlobField(qry.FieldByName('Attachment')).SaveToFile(tempFileName);
    aFileList.Add(tempFileName);
    qry.Close;
  end;

begin
  result := lvAttachments.SelCount > 0;
  if not result then exit;
  Item := lvAttachments.Selected;

  qry := DbSharedObj.GetQuery(DBConnection);
  try
    qry.Connection := DBConnection;
    qry.SQL.Text   := 'SELECT Attachment, AttachmentName FROM tblAttachments WHERE AttachmentId = :Id';

    AddFile(integer(Item.Data));
    Item := lvAttachments.GetNextItem(Item,sdAll,[isSelected]);
    while Assigned(Item) do begin
      AddFile(integer(Item.Data));
      Item := lvAttachments.GetNextItem(Item,sdAll,[isSelected]);
    end;


  finally
    DbSharedObj.ReleaseObj(qry);
  end;

end;

function TfmAttachments.PopulateListView : integer;
var
  qry: TERPQuery;
  Item: TListItem;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := DBConnection;
    lvAttachments.Clear;
    qry.SQL.Text := 'SELECT AttachmentId, AttachmentName' + ' FROM tblAttachments WHERE TableId = ' +
      IntToStr(Self.TableId) + ' AND TableName = ' + QuotedStr(Self.TableName);
    case ViewActiveMode of
      vmActive: qry.SQL.Add('and Active = "T"');
      vmInactive: qry.SQL.Add('and Active = "F"');
      vmBoth: ;
    end;
    qry.Open;
    Result := qry.RecordCount;
    while not qry.Eof do begin
      Item := lvAttachments.Items.Add;
      Item.Data := Pointer(TObject(qry.FieldByName('AttachmentId').AsInteger));
      Item.Caption := qry.FieldByName('AttachmentName').AsString;
      GetImageForFileType(Item);
      qry.Next;
    end;

  finally
    FreeAndNil(qry);
  end;
  DMTextTarget.AcceptorControl := nil;
  DMTextTarget.AcceptorControl := lvAttachments;
end;

procedure TfmAttachments.lvAttachmentsAdvancedCustomDraw(
  Sender: TCustomListView; const ARect: TRect; Stage: TCustomDrawStage;
  var DefaultDraw: Boolean);
var
  x, y, x1, y1: integer;
  text, text2: string;

  function TxtHeight(fontSize: integer; aText: string): integer;
  begin
    Sender.Canvas.Font.Size := fontSize;
    result := Sender.Canvas.TextHeight(aText);
  end;

  function TxtWidth(fontSize: integer; aText: string): integer;
  begin
    Sender.Canvas.Font.Size := fontSize;
    result := Sender.Canvas.TextWidth(aText);
  end;

begin
  inherited;
  DefaultDraw := true;

  if (Stage = cdPrePaint) or (Stage = cdPostPaint) then begin
    Sender.Canvas.Font.Color := clMoneyGreen;
    text := 'Active';
    text2 := 'Right click for details';
    case self.ViewActiveMode of
      vmActive:
        begin
          text := 'Active';
          y := Trunc((Sender.ClientHeight - TxtHeight(80,text)) / 2);
          y := y - TxtHeight(16,text2);
          x := Trunc((Sender.ClientWidth - TxtWidth(80,text)) / 2);
          y1 := y + TxtHeight(80,text) - TxtHeight(16,text2) +10;
          x1 := Trunc((Sender.ClientWidth - TxtWidth(16,text2)) / 2);
          Sender.Canvas.Font.Size := 80;
          Sender.Canvas.TextOut(x,y,text);
          Sender.Canvas.Font.Size := 16;
          Sender.Canvas.TextOut(x1,y1,text2);
        end;
      vmInactive:
        begin
          text := 'Inactive';
          y := Trunc((Sender.ClientHeight - TxtHeight(80,text)) / 2);
          y := y - TxtHeight(16,text2);
          x := Trunc((Sender.ClientWidth - TxtWidth(80,text)) / 2);
          y1 := y + TxtHeight(80,text) - TxtHeight(16,text2) +10;
          x1 := Trunc((Sender.ClientWidth - TxtWidth(16,text2)) / 2);
          Sender.Canvas.Font.Size := 80;
          Sender.Canvas.TextOut(x,y,text);
          Sender.Canvas.Font.Size := 16;
          Sender.Canvas.TextOut(x1,y1,text2);
        end;
      vmBoth:
        begin
          text := 'Active & Inactive';
          y := Trunc((Sender.ClientHeight - TxtHeight(60,text)) / 2);
          y := y - TxtHeight(16,text2);
          x := Trunc((Sender.ClientWidth - TxtWidth(60,text)) / 2);
          y1 := y + TxtHeight(60,text) - TxtHeight(16,text2) +10;
          x1 := Trunc((Sender.ClientWidth - TxtWidth(16,text2)) / 2);
          Sender.Canvas.Font.Size := 60;
          Sender.Canvas.TextOut(x,y,text);
          Sender.Canvas.Font.Size := 16;
          Sender.Canvas.TextOut(x1,y1,text2);
        end;
    end;
  end;


end;

procedure TfmAttachments.lvAttachmentsDblClick(Sender: TObject);
var
  Item: TListItem;
  qry: TERPQuery;
  tempFileName: string;
begin
  inherited;
  // open an item from the list
  Item := lvAttachments.Selected;
  if not Assigned(Item) then Exit;

  qry := TERPQuery.Create(nil);
  try
    qry.Connection := DBConnection;
    qry.SQL.Text   := 'SELECT Attachment FROM tblAttachments WHERE AttachmentId = ' + IntToStr(integer(Item.Data));
    qry.Open;
    if not qry.IsEmpty then begin
      tempFileName := GetTempFileName(ExtractFileName(Item.Caption), ExtractFileExt(Item.Caption));
      TBlobField(qry.FieldByName('Attachment')).SaveToFile(tempFileName);

      //SystemLib.ExecNewProcess(newFileName, false);
      ShellExecute(Handle, 'Open', PChar(tempFileName),
        '', '', SW_SHOWNORMAL);
    end;
    qry.Close;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TfmAttachments.DeleteAttachment(AttachmentId: integer);
var
  cmd: TERPCommand;
  qry: TERPQuery;
  msg: string;
begin
//  TDeletedItem.AddDeleted('tblAttachments',)
  cmd := TERPCommand.Create(nil);
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := DBConnection;
    qry.SQL.Add('select GlobalRef from tblAttachments');
    qry.SQL.Add('where AttachmentId = ' + IntToStr(AttachmentID));
    qry.Open;
    if qry.FieldByName('GlobalRef').AsString <> '' then begin
      TDeletedItem.AddDeleted('tblAttachments','TAttachment',qry.FieldByName('GlobalRef').AsString,AttachmentID,DbConnection, msg, false);
    end;
    qry.Close;
    cmd.Connection := DBConnection;
    cmd.SQL.Text   := 'DELETE FROM tblAttachments WHERE AttachmentId = ' + IntToStr(AttachmentId);
    cmd.Execute;
  finally
    cmd.Free;
    qry.Free;
  end;
  AttachmentsChanged := true;
end;

procedure TfmAttachments.actDeleteAttachmentExecute(Sender: TObject);
var
  Item: TListItem;
begin
  inherited;
  Item := lvAttachments.Selected;
  if not Assigned(Item) then Exit;

  DeleteAttachment(integer(Item.Data));
  Item := lvAttachments.GetNextItem(Item,sdAll,[isSelected]);
  while Assigned(Item) do begin
    DeleteAttachment(integer(Item.Data));
    Item := lvAttachments.GetNextItem(Item,sdAll,[isSelected]);
  end;

  PopulateListView;
  UpdateButtons;
end;

procedure TfmAttachments.lvAttachmentsSelectItem(Sender: TObject; Item: TListItem; Selected: boolean);
begin
  inherited;
  UpdateButtons;
end;

procedure TfmAttachments.lvAttachmentsExit(Sender: TObject);
begin
  inherited;
  UpdateButtons;
end;

procedure TfmAttachments.LargeIcons1Click(Sender: TObject);
begin
  inherited;
  radView.ItemIndex := 0;
end;

procedure TfmAttachments.SmallIcons1Click(Sender: TObject);
begin
  inherited;
  radView.ItemIndex := 1;
end;

procedure TfmAttachments.lvAttachmentsKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_DELETE then btnDelete.Click;
end;

procedure TfmAttachments.UpdateButtons;
//var
//  Item: TListItem;
begin
//  Item := lvAttachments.Selected;
//  if not Assigned(Item) then Exit;
  btnDelete.Enabled := Assigned(lvAttachments.Selected);
  Delete1.Enabled := btnDelete.Enabled;
  self.actFlagActive.Enabled := btnDelete.Enabled;
  self.actFlagInactive.Enabled := btnDelete.Enabled;
  case ViewActiveMode of
    vmActive:
      begin
        actFlagActive.Enabled := false;
        actFlagInactive.Enabled := true;
        actShowActive.Enabled := false;
        actShowInactive.Enabled := true;
        actShowBoth.Enabled := true;
//        lvAttachments.Color := clWindow;
      end;
    vmInactive:
      begin
        actFlagActive.Enabled := true;
        actFlagInactive.Enabled := false;
        actShowActive.Enabled := true;
        actShowInactive.Enabled := false;
        actShowBoth.Enabled := true;
//        lvAttachments.Color := clInactiveCaption;
      end;
    vmBoth:
      begin
        actFlagActive.Enabled := true;
        actFlagInactive.Enabled := true;
        actShowActive.Enabled := true;
        actShowInactive.Enabled := true;
        actShowBoth.Enabled := false;
//        lvAttachments.Color := clWindow;
      end;
  end;
end;

procedure TfmAttachments.SetTableId(const Value: integer);
begin
  fTableId := Value;
  EnableAccept;
end;

procedure TfmAttachments.SetTableName(const Value: string);
begin
  fTableName := Value;
  EnableAccept;
end;

procedure TfmAttachments.EnableAccept;
begin
  if (fTableId < 1) or (fTableName = '') then begin
    DMTextTarget.AcceptorControl := nil;
  end else begin
    DMTextTarget.AcceptorControl := lvAttachments;
  end;
end;

procedure TfmAttachments.lvAttachmentsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  inherited;
  Accept := True;
end;

Initialization
  RegisterClassOnce(TfmAttachments);

end.
