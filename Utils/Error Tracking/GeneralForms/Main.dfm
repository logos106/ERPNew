inherited MainGUI: TMainGUI
  Left = 366
  Top = 182
  Width = 494
  Height = 241
  Caption = 'Error Tracking'
  Color = 16316664
  DefaultMonitor = dmDesktop
  DragMode = dmAutomatic
  Font.Name = 'Arial'
  FormStyle = fsMDIForm
  Menu = MainMenu
  OldCreateOrder = True
  Position = poDefault
  WindowState = wsMaximized
  WindowMenu = Window1
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object StatusBar: TAdvOfficeStatusBar
    Left = 0
    Top = 176
    Width = 486
    Height = 19
    AnchorHint = False
    Panels = <
      item
        DateFormat = 'mm/dd/yyyy'
        Progress.BackGround = clNone
        Progress.Indication = piPercentage
        Progress.Min = 0
        Progress.Max = 100
        Progress.Position = 0
        Progress.Level0Color = clLime
        Progress.Level0ColorTo = 14811105
        Progress.Level1Color = clYellow
        Progress.Level1ColorTo = 13303807
        Progress.Level2Color = 5483007
        Progress.Level2ColorTo = 11064319
        Progress.Level3Color = clRed
        Progress.Level3ColorTo = 13290239
        Progress.Level1Perc = 70
        Progress.Level2Perc = 90
        Progress.BorderColor = clBlack
        Progress.ShowBorder = False
        Progress.Stacked = False
        TimeFormat = 'hh:mm:ss'
        Width = 80
        AppearanceStyle = psLight
      end>
    SimplePanel = False
    URLColor = clBlue
    Styler = AdvOfficeStatusBarOfficeStyler1
    Version = '1.1.3.0'
  end
  object ImageList: TImageList
    Height = 32
    Width = 32
    Left = 64
    Top = 6
  end
  object MainMenu: TAdvMainMenu
    MenuStyler = AdvMenuFantasyStyler
    Version = '2.5.0.1'
    Left = 3
    Top = 5
    object File1: TMenuItem
      Caption = '&File'
      object Exit1: TMenuItem
        Caption = 'E&xit'
        OnClick = Exit1Click
      end
    end
    object ExceptionEmails1: TMenuItem
      Caption = 'Error Emails'
      object DownloadEmails1: TMenuItem
        Caption = 'Download Emails'
        OnClick = DownloadEmails1Click
      end
      object ExceptionEmailList1: TMenuItem
        Caption = 'Exception Email List'
        OnClick = ExceptionEmailList1Click
      end
    end
    object Users1: TMenuItem
      Caption = 'Users'
      object NewUser1: TMenuItem
        Caption = 'Add User'
        OnClick = NewUser1Click
      end
      object UserList1: TMenuItem
        Caption = 'User List'
        OnClick = UserList1Click
      end
      object UsersFilterList1: TMenuItem
        Caption = 'Users Filter List'
        OnClick = UsersFilterList1Click
      end
    end
    object Utilities1: TMenuItem
      Caption = 'Utilities'
      object Backup1: TMenuItem
        Caption = 'Backup'
        OnClick = Backup1Click
      end
      object Restore1: TMenuItem
        Caption = 'Restore'
        OnClick = Restore1Click
      end
    end
    object Window1: TMenuItem
      Caption = '&Window'
      object ile1: TMenuItem
        Caption = '&Tile'
        OnClick = ile1Click
      end
      object Cascade1: TMenuItem
        Caption = '&Cascade'
      end
      object ArrangeAll1: TMenuItem
        Caption = '&Arrange All'
      end
    end
  end
  object AdvMenuFantasyStyler: TAdvMenuFantasyStyler
    Style = fsArctic
    Background.Position = bpTiled
    Background.Color = clWindow
    Background.GradientDirection = gdHorizontal
    IconBar.Color = 15724527
    IconBar.ColorTo = clWhite
    IconBar.CheckColor = clNone
    IconBar.CheckBorder = clSilver
    IconBar.CheckGradientDirection = gdHorizontal
    IconBar.RadioColor = clNone
    IconBar.RadioBorder = clSilver
    IconBar.RadioGradientDirection = gdHorizontal
    IconBar.Size = 16
    SelectedItem.Color = clWhite
    SelectedItem.ColorTo = clSilver
    SelectedItem.BorderColor = clSilver
    SelectedItem.Font.Charset = ANSI_CHARSET
    SelectedItem.Font.Color = clBlack
    SelectedItem.Font.Height = -11
    SelectedItem.Font.Name = 'Arial'
    SelectedItem.Font.Style = []
    SelectedItem.UseSystemFont = False
    SelectedItem.CheckColor = clSilver
    SelectedItem.CheckColorTo = clWhite
    SelectedItem.CheckBorder = clSilver
    SelectedItem.CheckGradientDirection = gdHorizontal
    SelectedItem.RadioColor = clSilver
    SelectedItem.RadioColorTo = clWhite
    SelectedItem.RadioBorder = clSilver
    RootItem.Color = clWhite
    RootItem.ColorTo = clInactiveCaptionText
    RootItem.GradientDirection = gdVertical
    RootItem.Font.Charset = ANSI_CHARSET
    RootItem.Font.Color = clBlack
    RootItem.Font.Height = -11
    RootItem.Font.Name = 'Arial'
    RootItem.Font.Style = []
    RootItem.UseSystemFont = False
    RootItem.SelectedColor = clInactiveCaptionText
    RootItem.SelectedColorTo = clWhite
    RootItem.SelectedBorderColor = clSilver
    RootItem.SelectedTextColor = clBlack
    RootItem.HoverColor = clNone
    RootItem.HoverColorTo = clNone
    RootItem.HoverBorderColor = clNone
    RootItem.HoverTextColor = 7303023
    Glyphs.SubMenu.Data = {
      5A000000424D5A000000000000003E0000002800000004000000070000000100
      0100000000001C0000000000000000000000020000000200000000000000FFFF
      FF0070000000300000001000000000000000100000003000000070000000}
    Glyphs.Check.Data = {
      7E000000424D7E000000000000003E0000002800000010000000100000000100
      010000000000400000000000000000000000020000000200000000000000FFFF
      FF00FFFF0000FFFF0000FFFF0000FFFF0000FDFF0000F8FF0000F07F0000F23F
      0000F71F0000FF8F0000FFCF0000FFEF0000FFFF0000FFFF0000FFFF0000FFFF
      0000}
    Glyphs.Radio.Data = {
      7E000000424D7E000000000000003E0000002800000010000000100000000100
      010000000000400000000000000000000000020000000200000000000000FFFF
      FF00FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FC3F0000F81F0000F81F
      0000F81F0000F81F0000FC3F0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000}
    SideBar.Alignment = taCenter
    SideBar.Caption = 'TMS Menu'
    SideBar.Font.Charset = DEFAULT_CHARSET
    SideBar.Font.Color = clWhite
    SideBar.Font.Height = -19
    SideBar.Font.Name = 'Tahoma'
    SideBar.Font.Style = [fsBold, fsItalic]
    SideBar.VisibleIn = viFirstLevel
    SideBar.Image.Position = bpCenter
    SideBar.Image.Color = 15582889
    SideBar.Image.ColorTo = 6956042
    SideBar.Background.Position = bpCenter
    SideBar.Background.GradientDirection = gdHorizontal
    SideBar.Size = 6
    SideBar.SplitterColorTo = clBlack
    Separator.Color = clSilver
    Separator.ColorTo = clWhite
    Separator.GradientType = gtBoth
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    UseSystemFont = False
    MenuBorderColor = clSilver
    Left = 33
    Top = 5
  end
  object AdvOfficeStatusBarOfficeStyler1: TAdvOfficeStatusBarOfficeStyler
    Style = psOffice2003Classic
    BorderColor = 13226453
    PanelAppearanceLight.BorderColor = clNone
    PanelAppearanceLight.BorderColorHot = clGray
    PanelAppearanceLight.BorderColorDown = clBlack
    PanelAppearanceLight.Color = clWhite
    PanelAppearanceLight.ColorTo = 13226453
    PanelAppearanceLight.ColorHot = 13811126
    PanelAppearanceLight.ColorHotTo = 13811126
    PanelAppearanceLight.ColorDown = 14857624
    PanelAppearanceLight.ColorDownTo = 14857624
    PanelAppearanceLight.ColorMirror = clNone
    PanelAppearanceLight.ColorMirrorTo = clNone
    PanelAppearanceLight.ColorMirrorHot = 13811126
    PanelAppearanceLight.ColorMirrorHotTo = 13811126
    PanelAppearanceLight.ColorMirrorDown = clNone
    PanelAppearanceLight.ColorMirrorDownTo = clNone
    PanelAppearanceLight.TextColor = clBlack
    PanelAppearanceLight.TextColorHot = clBlack
    PanelAppearanceLight.TextColorDown = clBlack
    PanelAppearanceLight.TextStyle = []
    PanelAppearanceDark.BorderColor = clNone
    PanelAppearanceDark.BorderColorHot = clGray
    PanelAppearanceDark.BorderColorDown = clBlack
    PanelAppearanceDark.Color = clGray
    PanelAppearanceDark.ColorTo = clGray
    PanelAppearanceDark.ColorHot = 13811126
    PanelAppearanceDark.ColorHotTo = 13811126
    PanelAppearanceDark.ColorDown = 14857624
    PanelAppearanceDark.ColorDownTo = 14857624
    PanelAppearanceDark.ColorMirror = clNone
    PanelAppearanceDark.ColorMirrorTo = clNone
    PanelAppearanceDark.ColorMirrorHot = clNone
    PanelAppearanceDark.ColorMirrorHotTo = clNone
    PanelAppearanceDark.ColorMirrorDown = clNone
    PanelAppearanceDark.ColorMirrorDownTo = clNone
    PanelAppearanceDark.TextColor = clWhite
    PanelAppearanceDark.TextColorHot = clWhite
    PanelAppearanceDark.TextColorDown = clWhite
    PanelAppearanceDark.TextStyle = []
    Left = 1
    Top = 136
  end
end
