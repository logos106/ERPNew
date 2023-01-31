object fmMemoDialog: TfmMemoDialog
  Left = 0
  Top = 0
  Caption = 'Data'
  ClientHeight = 482
  ClientWidth = 494
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 441
    Width = 494
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = 216
    ExplicitTop = 248
    ExplicitWidth = 185
    DesignSize = (
      494
      41)
    object btnSave: TButton
      Left = 117
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop]
      Caption = 'Save'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = False
      OnClick = btnSaveClick
    end
    object btnClose: TButton
      Left = 303
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop]
      Caption = 'Close'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ModalResult = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      TabStop = False
    end
    object btnOk: TButton
      Left = 210
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop]
      Caption = 'Ok'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ModalResult = 1
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      TabStop = False
    end
  end
  object memData: TMemo
    Left = 0
    Top = 0
    Width = 494
    Height = 441
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 1
    ExplicitWidth = 434
    ExplicitHeight = 295
  end
  object SaveDialog: TSaveDialog
    Filter = 'Text Files|*.txt|All Files|*.*'
    Left = 288
    Top = 80
  end
end
