object fmMain: TfmMain
  Left = 688
  Top = 214
  BorderStyle = bsSingle
  Caption = 'ERP Service Menu'
  ClientHeight = 565
  ClientWidth = 767
  Color = 16770790
  Constraints.MinHeight = 400
  Constraints.MinWidth = 773
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnMouseWheel = FormMouseWheel
  OnResize = FormResize
  OnShow = FormShow
  DesignSize = (
    767
    565)
  PixelsPerInch = 96
  TextHeight = 15
  object imgPrefs: TImage
    Left = 724
    Top = 56
    Width = 29
    Height = 459
    HelpContext = 436005
    Anchors = [akTop, akRight, akBottom]
    Stretch = True
    ExplicitLeft = 714
    ExplicitHeight = 449
  end
  object Label2: TLabel
    Left = 715
    Top = 37
    Width = 48
    Height = 15
    HelpContext = 436004
    Alignment = taCenter
    Anchors = [akTop, akRight]
    AutoSize = False
    Caption = 'Scroll'
    Transparent = True
    ExplicitLeft = 705
  end
  object Shader: TShader
    Left = 8
    Top = 14
    Width = 710
    Height = 30
    HelpContext = 436012
    Anchors = [akLeft, akTop, akRight]
    BevelOuter = bvNone
    TabOrder = 0
    FromColor = clBtnFace
    ToColor = clWhite
    FromColorMirror = clWhite
    ToColorMirror = clBtnFace
    Steps = 10
    Direction = False
    Version = '1.4.0.0'
    object pnlActiveForm: TLabel
      Left = 0
      Top = 0
      Width = 710
      Height = 30
      HelpContext = 436013
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Caption = 'ERP Service Menu'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      ExplicitWidth = 547
    end
  end
  object btnClose: TDNMSpeedButton
    Left = 340
    Top = 531
    Width = 87
    Height = 27
    Anchors = [akBottom]
    Cancel = True
    Caption = 'Close'
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 1
    AutoDisableParentOnclick = True
    OnClick = btnCloseClick
  end
  object sbPrefs: TAdvScrollBox
    Left = -1
    Top = 56
    Width = 710
    Height = 459
    HelpContext = 436006
    HorzScrollBar.Increment = 49
    HorzScrollBar.Style = ssFlat
    HorzScrollBar.Visible = False
    VertScrollBar.Increment = 37
    VertScrollBar.Position = 3
    VertScrollBar.Style = ssFlat
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelInner = bvNone
    BevelKind = bkSoft
    BorderStyle = bsNone
    DoubleBuffered = False
    Color = clBtnFace
    Ctl3D = True
    ParentColor = False
    ParentCtl3D = False
    ParentDoubleBuffered = False
    TabOrder = 2
    inline UtilsServerConfig: TfrUtilsServerConfig
      Left = 0
      Top = -3
      Width = 675
      Height = 460
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ExplicitTop = -3
      ExplicitHeight = 460
      inherited Bevel1: TBevel
        Height = 456
        ExplicitWidth = 692
        ExplicitHeight = 278
      end
      inherited dtUpdateCheckTime: TDateTimePicker
        OnExit = UtilsServerConfigdtUpdateCheckTimeExit
      end
      inherited rgLoggingLevel: TwwRadioGroup
        Top = 217
        ExplicitTop = 217
      end
      inherited btnShowLog: TDNMSpeedButton
        Left = 378
        Top = 14
        ExplicitLeft = 378
        ExplicitTop = 14
      end
      inherited btnCommsTest: TDNMSpeedButton
        Left = 570
        Top = 14
        ExplicitLeft = 570
        ExplicitTop = 14
      end
      inherited btnLogFile: TDNMSpeedButton
        Left = 474
        Top = 14
        ExplicitLeft = 474
        ExplicitTop = 14
      end
      inherited grdTaskList: TwwDBGrid
        Top = 273
        ExplicitTop = 273
      end
    end
  end
  object ImageScroll: TImageScroll
    Enabled = False
    Image = imgPrefs
    ScrollBox = sbPrefs
    Left = 1
    Top = 476
  end
end
