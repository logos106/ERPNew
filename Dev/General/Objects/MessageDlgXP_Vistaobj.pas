unit MessageDlgXP_Vistaobj;

interface

//uses Dialogs , taskdialog , classes;
uses Dialogs, taskdialog ;

Type


  TMessageDlgXP_Vista = Class(TObject)
  Private
    fiHelpCtx         : Longint;
    fsMsg             : string;
    fsSoundfilename   : String;
    fiMsgBoxWidth     : Integer;
    fsCustomButtonsStr: String;
    fDlgType          : TMsgDlgType;
    fsVerifyText      : string;
    fbVerifyChecked   : boolean;
    fOnVerifyClick    : TTaskDialogVerifyClickEvent;
    fsInstruction     : string;
    fButtons          : TMsgDlgButtons;
  Protected
  public
        constructor Create;
        Property Msg                : string                       read fsMsg               write fsMsg;
        Property DlgType            : TMsgDlgType                  read fDlgType            write fDlgType;
        Property Buttons            : TMsgDlgButtons               read fButtons            write fButtons;
        Property HelpCtx            : Longint                      read fiHelpCtx           write fiHelpCtx;
        Property Instruction        : string                       read fsInstruction       write fsInstruction;
        Property VerifyText         : string                       read fsVerifyText        write fsVerifyText;
        Property VerifyChecked      : boolean                      read fbVerifyChecked     write fbVerifyChecked;
        Property OnVerifyClick      : TTaskDialogVerifyClickEvent  read fOnVerifyClick      write fOnVerifyClick;
        Property CustomButtonsStr   : String                       read fsCustomButtonsStr  write fsCustomButtonsStr;
        Property Soundfilename      : String                       read fsSoundfilename     write fsSoundfilename;
        Property MsgBoxWidth        : Integer                      read fiMsgBoxWidth       write fiMsgBoxWidth;

        Function DoCallMessageDlgXP_Vista:Word;
        Class Function NewMessageDlgXP_Vista(const aMsg: string;
                                             const aDlgType: TMsgDlgType;
                                             const aButtons: TMsgDlgButtons;
                                             const aHelpCtx: Longint;
                                             const aInstruction: string = '';
                                             const aVerifyText: string = '';
                                             const aVerifyChecked: boolean = false;
                                             const aOnVerifyClick: TTaskDialogVerifyClickEvent = nil;
                                             const aCustomButtonsStr :String = '' ;
                                             const aSoundfilename:String = '';
                                             const aMsgBoxWidth:Integer=0): TMessageDlgXP_Vista;


  End;

implementation

uses CommonLib;

//uses CommonLib, Preferences;

{ TMessageDlgXP_Vista }
constructor TMessageDlgXP_Vista.Create;
begin
        Instruction     := '';
        VerifyText      := '';
        VerifyChecked   := False;
        OnVerifyClick   := nil;
        CustomButtonsStr:= '';
        Soundfilename   := '';
        MsgBoxWidth     := 0;
end;
Class Function TMessageDlgXP_Vista.NewMessageDlgXP_Vista(const aMsg: string;
                                             const aDlgType: TMsgDlgType;
                                             const aButtons: TMsgDlgButtons;
                                             const aHelpCtx: Longint;
                                             const aInstruction: string = '';
                                             const aVerifyText: string = '';
                                             const aVerifyChecked: boolean = false;
                                             const aOnVerifyClick: TTaskDialogVerifyClickEvent = nil;
                                             const aCustomButtonsStr :String = '' ;
                                             const aSoundfilename:String = '';
                                             const aMsgBoxWidth:Integer=0): TMessageDlgXP_Vista;
begin
  Result := TMessageDlgXP_Vista.create;
  Result.Msg             := aMsg;
  Result.DlgType         := aDlgType;
  Result.Buttons         := aButtons;
  Result.HelpCtx         := aHelpCtx;
  Result.Instruction     := aInstruction;
  Result.VerifyText      := aVerifyText;
  Result.VerifyChecked   := aVerifyChecked;
  Result.OnVerifyClick   := aOnVerifyClick;
  Result.CustomButtonsStr:= aCustomButtonsStr;
  Result.Soundfilename   := aSoundfilename;
  Result.MsgBoxWidth     := aMsgBoxWidth;
end;

Function TMessageDlgXP_Vista.DoCallMessageDlgXP_Vista:Word;
begin
  Result := MessageDlgXP_Vista(Msg,DlgType,Buttons,HelpCtx,nil,Instruction,VerifyText,VerifyChecked,OnVerifyClick,CustomButtonsStr,Soundfilename,MsgBoxWidth);
end;


end.
