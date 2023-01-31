inherited frmTerminationHint: TfrmTerminationHint
  Left = 281
  Top = 469
  Width = 457
  Height = 237
  VertScrollBar.Visible = False
  BorderStyle = bsSizeToolWin
  Caption = 'Hint'
  Color = 15785701
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 357000
  inherited Label1: TLabel
    Left = 29
    Top = 186
    HelpContext = 357001
  end
  object Label2: TLabel [1]
    Left = 175
    Top = 186
    Width = 124
    Height = 12
    Anchors = [akLeft, akBottom]
    Caption = 'Apply size position to all hints'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    HelpContext = 357008
  end
  inherited chkDontShowHint: TwwCheckBox
    Left = 5
    Top = 184
    HelpContext = 357002
  end
  inherited Panel1: TPanel
    Width = 434
    Height = 172
    HelpContext = 357003
    inherited HintMemo: TMemo
      Width = 376
      Height = 130
      ScrollBars = ssVertical
      HelpContext = 357006
    end
    inherited HintHeader: TLabel
      HelpContext = 357004
    end
    inherited Image1: TImage
      HelpContext = 357005
    end
  end
  inherited btnClose: TDNMSpeedButton
    Left = 364
    Top = 184
    Anchors = [akRight, akBottom]
    OnClick = btnCloseClick
    HelpContext = 357007
  end
  object chkApplyToAll: TwwCheckBox
    Left = 157
    Top = 184
    Width = 16
    Height = 17
    AlwaysTransparent = True
    Frame.Enabled = True
    Frame.Transparent = True
    Frame.FocusBorders = []
    Frame.NonFocusBorders = []
    ValueChecked = 'True'
    ValueUnchecked = 'False'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Anchors = [akLeft, akBottom]
    TabOrder = 3
    HelpContext = 357009
  end
  object qryHints: TERPQuery
    Left = 24
    Top = 192
  end
end
