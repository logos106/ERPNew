inherited fmTrainingAssignment: TfmTrainingAssignment
  Left = 119
  Top = 233
  HelpContext = 781001
  Caption = 'Training Setup'
  ClientWidth = 996
  ExplicitLeft = 119
  ExplicitTop = 233
  ExplicitWidth = 1012
  DesignSize = (
    996
    532)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Width = 996
    HelpContext = 781056
    ExplicitTop = 501
    ExplicitWidth = 998
  end
  inherited shapehint: TShape
    Left = 12
    ExplicitLeft = 12
  end
  object Label6: TLabel [3]
    Left = 24
    Top = 184
    Width = 38
    Height = 15
    HelpContext = 781002
    Caption = 'Label6'
  end
  object Label7: TLabel [4]
    Left = 24
    Top = 216
    Width = 38
    Height = 15
    HelpContext = 781003
    Caption = 'Label7'
  end
  inherited shapehintextra1: TShape
    Left = 56
    ExplicitLeft = 56
  end
  inherited pnlForm: TDNMPanel
    Width = 996
    HelpContext = 781057
    ExplicitWidth = 996
    inherited pnlTop: TDNMPanel
      Width = 994
      HelpContext = 781058
      ExplicitWidth = 994
      DesignSize = (
        994
        63)
      object Label11: TLabel
        Left = 791
        Top = 8
        Width = 82
        Height = 15
        HelpContext = 781004
        Anchors = [akTop, akRight]
        Caption = 'Training Group'
      end
      object pnlTitle: TDNMPanel
        Left = 252
        Top = 9
        Width = 489
        Height = 39
        HelpContext = 781005
        Caption = 'Invoice'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Locked = True
        ParentFont = False
        TabOrder = 0
        object TitleShader: TShader
          Left = 1
          Top = 1
          Width = 487
          Height = 37
          HelpContext = 781006
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          FromColor = clBtnFace
          ToColor = clWhite
          FromColorMirror = clWhite
          ToColorMirror = clBtnFace
          Steps = 10
          Direction = False
          Version = '1.4.0.0'
          object TitleLabel: TLabel
            Left = 0
            Top = 0
            Width = 487
            Height = 37
            HelpContext = 781007
            Align = alClient
            Alignment = taCenter
            AutoSize = False
            Caption = 'Training Setup'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -29
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
        end
      end
      object cboTraining: TwwDBLookupCombo
        Left = 791
        Top = 29
        Width = 192
        Height = 23
        HelpContext = 781008
        Anchors = [akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Description'#9'40'#9'Description'#9'F')
        LookupTable = qryTrainingLookup
        LookupField = 'Description'
        Style = csDropDownList
        ParentFont = False
        TabOrder = 1
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnCloseUp = cboTrainingCloseUp
      end
      object chkIgnoreTrainingAtStartup: TwwCheckBox
        Left = 11
        Top = 24
        Width = 198
        Height = 17
        HelpContext = 781059
        DisableThemes = False
        AlwaysTransparent = False
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        DisplayValueChecked = 'True'
        DisplayValueUnchecked = 'False'
        NullAndBlankState = cbUnchecked
        Caption = 'Ignore Training at Startup'
        TabOrder = 2
        OnClick = chkIgnoreTrainingAtStartupClick
      end
    end
    inherited pnlbottom: TDNMPanel
      Top = 478
      Width = 994
      Height = 53
      HelpContext = 781060
      ExplicitTop = 478
      ExplicitWidth = 994
      ExplicitHeight = 53
      DesignSize = (
        994
        53)
      object btnCompleted: TDNMSpeedButton
        Left = 38
        Top = 14
        Width = 87
        Height = 27
        HelpContext = 781009
        Anchors = [akTop, akRight]
        Caption = '&Save'
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
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 0
        TabStop = False
        AutoDisableParentOnclick = True
        OnClick = btnCompletedClick
      end
      object btnStatus: TDNMSpeedButton
        Left = 143
        Top = 14
        Width = 87
        Height = 27
        HelpContext = 781010
        Anchors = [akTop, akRight]
        Caption = 'Status'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ParentFont = False
        TabOrder = 1
        TabStop = False
        AutoDisableParentOnclick = True
        OnClick = btnStatusClick
      end
      object btnEmployees: TDNMSpeedButton
        Left = 386
        Top = 14
        Width = 200
        Height = 27
        HelpContext = 781011
        Anchors = [akTop, akRight]
        Caption = 'Choose Employees For Training'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ParentFont = False
        TabOrder = 2
        TabStop = False
        AutoDisableParentOnclick = True
        OnClick = btnEmployeesClick
      end
      object btnPrint: TDNMSpeedButton
        Left = 766
        Top = 14
        Width = 87
        Height = 27
        HelpContext = 781012
        Anchors = [akTop, akRight]
        Caption = '&Print'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ParentFont = False
        TabOrder = 3
        TabStop = False
        AutoDisableParentOnclick = True
        OnClick = btnPrintClick
      end
      object btnClose: TDNMSpeedButton
        Left = 868
        Top = 14
        Width = 87
        Height = 27
        HelpContext = 781013
        Anchors = [akTop, akRight]
        Caption = '&Cancel'
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
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 4
        TabStop = False
        AutoDisableParentOnclick = True
        OnClick = btnCloseClick
      end
      object btnAutoSchedule: TDNMSpeedButton
        Left = 601
        Top = 14
        Width = 145
        Height = 27
        HelpContext = 781014
        Anchors = [akTop, akRight]
        Caption = 'Auto Schedule'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ParentFont = False
        TabOrder = 5
        TabStop = False
        AutoDisableParentOnclick = True
        OnClick = btnAutoScheduleClick
      end
      object btnTrainingModules: TDNMSpeedButton
        Left = 251
        Top = 14
        Width = 115
        Height = 27
        HelpContext = 781015
        Anchors = [akTop, akRight]
        Caption = 'Training Modules'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ParentFont = False
        TabOrder = 6
        TabStop = False
        AutoDisableParentOnclick = True
        OnClick = btnTrainingModulesClick
      end
    end
    inherited pnlmain: TDNMPanel
      Width = 994
      Height = 414
      HelpContext = 781061
      ExplicitWidth = 994
      ExplicitHeight = 414
      object pgmain: TPageControl
        Left = 1
        Top = 1
        Width = 992
        Height = 412
        HelpContext = 781016
        ActivePage = tabSetup
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabHeight = 30
        TabOrder = 0
        TabWidth = 328
        OnChange = pgmainChange
        object tabSetup: TTabSheet
          HelpContext = 781017
          Caption = 'Setup'
          ImageIndex = 2
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object DNMPanel2: TDNMPanel
            Left = 0
            Top = 0
            Width = 984
            Height = 372
            HelpContext = 781018
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object Label5: TLabel
              Left = 16
              Top = 70
              Width = 70
              Height = 15
              HelpContext = 781019
              Caption = 'Day Start At '
            end
            object Label4: TLabel
              Left = 242
              Top = 70
              Width = 63
              Height = 15
              HelpContext = 781020
              Caption = 'Day End At '
            end
            object Label9: TLabel
              Left = 166
              Top = 346
              Width = 105
              Height = 15
              HelpContext = 781021
              Caption = 'Total Time in a Day'
            end
            object lblTraining: TGradientLabel
              Left = 1
              Top = 1
              Width = 982
              Height = 30
              HelpContext = 781022
              Align = alTop
              Alignment = taCenter
              AutoSize = False
              Caption = 'Select Times For Normal Working Day'
              Color = clYellow
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -24
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
              Layout = tlCenter
              WordWrap = True
              ColorTo = clInfoBk
              EllipsType = etNone
              GradientType = gtFullVertical
              GradientDirection = gdLeftToRight
              Indent = 0
              LineWidth = 2
              Orientation = goHorizontal
              TransparentText = False
              VAlignment = vaTop
              Version = '1.1.1.0'
              ExplicitWidth = 986
            end
            object Label12: TLabel
              Left = 18
              Top = 40
              Width = 109
              Height = 15
              HelpContext = 781062
              Caption = 'Total Training Days '
            end
            object cboDayStart: TComboBox
              Left = 130
              Top = 66
              Width = 100
              Height = 23
              HelpContext = 781023
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              Text = 'cboDayStart'
              OnChange = cboDayStartCloseUp
              OnDropDown = cboDayStartDropDown
              Items.Strings = (
                '12:00:00 AM'
                '12:30:00 AM'
                '01:00:00 AM'
                '01:30:00 AM'
                '02:00:00 AM'
                '02:30:00 AM'
                '03:00:00 AM'
                '03:30:00 AM'
                '04:00:00 AM'
                '04:30:00 AM'
                '05:00:00 AM'
                '05:30:00 AM'
                '06:00:00 AM'
                '06:30:00 AM'
                '07:00:00 AM'
                '07:30:00 AM'
                '08:00:00 AM'
                '08:30:00 AM'
                '09:00:00 AM'
                '09:30:00 AM'
                '10:00:00 AM'
                '10:30:00 AM'
                '11:00:00 AM'
                '11:30:00 AM'
                '12:00:00 PM'
                '12:30:00 PM'
                '01:00:00 PM'
                '01:30:00 PM'
                '02:00:00 PM'
                '02:30:00 PM'
                '03:00:00 PM'
                '03:30:00 PM'
                '04:00:00 PM'
                '04:30:00 PM'
                '05:00:00 PM'
                '05:30:00 PM'
                '06:00:00 PM'
                '06:30:00 PM'
                '07:00:00 PM'
                '07:30:00 PM'
                '08:00:00 PM'
                '08:30:00 PM'
                '09:00:00 PM'
                '09:30:00 PM'
                '10:00:00 PM'
                '10:30:00 PM'
                '11:00:00 PM'
                '11:30:00 PM'
                '')
            end
            object cboDayEnd: TComboBox
              Left = 311
              Top = 66
              Width = 100
              Height = 23
              HelpContext = 781024
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              Text = 'ComboBox1'
              OnChange = cboDayEndCloseUp
              OnDropDown = cboDayEndDropDown
              Items.Strings = (
                '12:00:00 AM'
                '12:30:00 AM'
                '01:00:00 AM'
                '01:30:00 AM'
                '02:00:00 AM'
                '02:30:00 AM'
                '03:00:00 AM'
                '03:30:00 AM'
                '04:00:00 AM'
                '04:30:00 AM'
                '05:00:00 AM'
                '05:30:00 AM'
                '06:00:00 AM'
                '06:30:00 AM'
                '07:00:00 AM'
                '07:30:00 AM'
                '08:00:00 AM'
                '08:30:00 AM'
                '09:00:00 AM'
                '09:30:00 AM'
                '10:00:00 AM'
                '10:30:00 AM'
                '11:00:00 AM'
                '11:30:00 AM'
                '12:00:00 PM'
                '12:30:00 PM'
                '01:00:00 PM'
                '01:30:00 PM'
                '02:00:00 PM'
                '02:30:00 PM'
                '03:00:00 PM'
                '03:30:00 PM'
                '04:00:00 PM'
                '04:30:00 PM'
                '05:00:00 PM'
                '05:30:00 PM'
                '06:00:00 PM'
                '06:30:00 PM'
                '07:00:00 PM'
                '07:30:00 PM'
                '08:00:00 PM'
                '08:30:00 PM'
                '09:00:00 PM'
                '09:30:00 PM'
                '10:00:00 PM'
                '10:30:00 PM'
                '11:00:00 PM'
                '11:30:00 PM'
                '')
            end
            object wwDBGrid1: TwwDBGrid
              Left = 16
              Top = 95
              Width = 395
              Height = 240
              HelpContext = 781025
              ControlType.Strings = (
                'Active;CheckBox;T;F'
                'TimeFrom;CustomEdit;cbotimefrom;F'
                'TimeTo;CustomEdit;cboTimeto;F')
              Selected.Strings = (
                'Description'#9'20'#9'Description'#9#9
                'TimeFrom'#9'12'#9'From'#9#9
                'TimeTo'#9'12'#9'To'#9#9
                'Active'#9'1'#9'Active'#9#9)
              IniAttributes.Delimiter = ';;'
              TitleColor = clWhite
              FixedCols = 0
              ShowHorzScrollBar = True
              EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
              DataSource = dsTrainingDay
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
              TitleAlignment = taLeftJustify
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -12
              TitleFont.Name = 'Arial'
              TitleFont.Style = [fsBold]
              TitleLines = 2
              TitleButtons = False
              FooterColor = clWhite
            end
            object cbotimefrom: TwwDBComboBox
              Left = 172
              Top = 110
              Width = 94
              Height = 23
              HelpContext = 781026
              ShowButton = True
              Style = csDropDown
              MapList = False
              AllowClearKey = False
              DataField = 'TimeFrom'
              DataSource = dsTrainingDay
              DropDownCount = 8
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ItemHeight = 0
              Items.Strings = (
                '00:00:00 AM'
                '00:30:00 AM'
                '01:00:00 AM'
                '01:30:00 AM'
                '02:00:00 AM'
                '02:30:00 AM'
                '03:00:00 AM'
                '03:30:00 AM'
                '04:00:00 AM'
                '04:30:00 AM'
                '05:00:00 AM'
                '05:30:00 AM'
                '06:00:00 AM'
                '06:30:00 AM'
                '07:00:00 AM'
                '07:30:00 AM'
                '08:00:00 AM'
                '08:30:00 AM'
                '09:00:00 AM'
                '09:30:00 AM'
                '10:00:00 AM'
                '10:30:00 AM'
                '11:00:00 AM'
                '11:30:00 AM'
                '12:00:00 PM'
                '12:30:00 PM'
                '01:00:00 PM'
                '01:30:00 PM'
                '02:00:00 PM'
                '02:30:00 PM'
                '03:00:00 PM'
                '03:30:00 PM'
                '04:00:00 PM'
                '04:30:00 PM'
                '05:00:00 PM'
                '05:30:00 PM'
                '06:00:00 PM'
                '06:30:00 PM'
                '07:00:00 PM'
                '07:30:00 PM'
                '08:00:00 PM'
                '08:30:00 PM'
                '09:00:00 PM'
                '09:30:00 PM'
                '10:00:00 PM'
                '10:30:00 PM'
                '11:00:00 PM'
                '11:30:00 PM'
                '12:00:00 AM'
                '12:30:00 AM')
              ItemIndex = 24
              ParentFont = False
              Sorted = False
              TabOrder = 3
              UnboundDataType = wwDefault
            end
            object cboTimeto: TwwDBComboBox
              Left = 262
              Top = 110
              Width = 93
              Height = 23
              HelpContext = 781027
              ShowButton = True
              Style = csDropDown
              MapList = False
              AllowClearKey = False
              DataField = 'TimeTo'
              DataSource = dsTrainingDay
              DropDownCount = 8
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ItemHeight = 0
              Items.Strings = (
                '00:00:00 AM'
                '00:30:00 AM'
                '01:00:00 AM'
                '01:30:00 AM'
                '02:00:00 AM'
                '02:30:00 AM'
                '03:00:00 AM'
                '03:30:00 AM'
                '04:00:00 AM'
                '04:30:00 AM'
                '05:00:00 AM'
                '05:30:00 AM'
                '06:00:00 AM'
                '06:30:00 AM'
                '07:00:00 AM'
                '07:30:00 AM'
                '08:00:00 AM'
                '08:30:00 AM'
                '09:00:00 AM'
                '09:30:00 AM'
                '10:00:00 AM'
                '10:30:00 AM'
                '11:00:00 AM'
                '11:30:00 AM'
                '12:00:00 PM'
                '12:30:00 PM'
                '01:00:00 PM'
                '01:30:00 PM'
                '02:00:00 PM'
                '02:30:00 PM'
                '03:00:00 PM'
                '03:30:00 PM'
                '04:00:00 PM'
                '04:30:00 PM'
                '05:00:00 PM'
                '05:30:00 PM'
                '06:00:00 PM'
                '06:30:00 PM'
                '07:00:00 PM'
                '07:30:00 PM'
                '08:00:00 PM'
                '08:30:00 PM'
                '09:00:00 PM'
                '09:30:00 PM'
                '10:00:00 PM'
                '10:30:00 PM'
                '11:00:00 PM'
                '11:30:00 PM'
                '12:00:00 AM'
                '12:30:00 AM')
              ItemIndex = 26
              ParentFont = False
              Sorted = False
              TabOrder = 4
              UnboundDataType = wwDefault
            end
            object wwDBEdit2: TwwDBEdit
              Left = 290
              Top = 342
              Width = 121
              Height = 23
              HelpContext = 781028
              DataField = 'HoursInADay'
              DataSource = dsTraining
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 5
              UnboundDataType = wwDefault
              WantReturns = False
              WordWrap = False
            end
            object edtTotalTrainingDays: TwwDBEdit
              Left = 130
              Top = 37
              Width = 100
              Height = 23
              HelpContext = 781063
              DataField = 'TotalTrainingDays'
              DataSource = dsTraining
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 6
              UnboundDataType = wwDefault
              WantReturns = False
              WordWrap = False
            end
          end
        end
        object tabSchedule: TTabSheet
          HelpContext = 781029
          Caption = 'Schedule'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object BevelTrainingCalender: TBevel
            Left = 14
            Top = 44
            Width = 397
            Height = 344
            HelpContext = 781030
          end
          object Bevel1: TBevel
            Left = 416
            Top = 44
            Width = 197
            Height = 50
            HelpContext = 781031
          end
          object Bevel2: TBevel
            Left = 619
            Top = 44
            Width = 364
            Height = 325
            HelpContext = 781032
          end
          object Label1: TLabel
            Left = 626
            Top = 53
            Width = 129
            Height = 15
            HelpContext = 781033
            Caption = 'Training Scheduled For'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label8: TLabel
            Left = 731
            Top = 336
            Width = 127
            Height = 30
            HelpContext = 781034
            Alignment = taRightJustify
            Caption = 'Number of Days Scheduled for Training'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            WordWrap = True
          end
          object Label10: TLabel
            Left = 420
            Top = 56
            Width = 61
            Height = 30
            HelpContext = 781035
            Alignment = taRightJustify
            Caption = 'Total Time in a Day'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            WordWrap = True
          end
          object lblEmployee: TGradientLabel
            Left = 0
            Top = 0
            Width = 984
            Height = 30
            HelpContext = 781036
            Align = alTop
            Alignment = taCenter
            AutoSize = False
            Caption = 'Select Days For Training (Minimum 8 Days)'
            Color = clYellow
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -24
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Layout = tlCenter
            WordWrap = True
            ColorTo = clInfoBk
            EllipsType = etNone
            GradientType = gtFullVertical
            GradientDirection = gdLeftToRight
            Indent = 0
            LineWidth = 2
            Orientation = goHorizontal
            TransparentText = False
            VAlignment = vaTop
            Version = '1.1.1.0'
            ExplicitWidth = 988
          end
          object TrainingCalender: TMonthCalendar
            Left = 15
            Top = 50
            Width = 394
            Height = 320
            HelpContext = 781037
            MultiSelect = True
            Date = 40387.604470324080000000
            EndDate = 40387.000000000000000000
            MaxSelectRange = 62
            ParentShowHint = False
            PopupMenu = MnuCalendar
            ShowHint = False
            ShowToday = False
            ShowTodayCircle = False
            TabOrder = 0
            OnClick = TrainingCalenderClick
            OnDblClick = TrainingCalenderDblClick
          end
          object grdTrainingSchedule: TwwDBGrid
            Left = 623
            Top = 71
            Width = 358
            Height = 263
            HelpContext = 781038
            Selected.Strings = (
              'TrainingDate'#9'27'#9'Date'#9'F'
              'StartTime'#9'8'#9'From'#9#9
              'EndTime'#9'8'#9'To'#9#9)
            IniAttributes.Delimiter = ';;'
            TitleColor = clWhite
            FixedCols = 0
            ShowHorzScrollBar = True
            DataSource = dsTrainingDays
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            KeyOptions = []
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
            ParentFont = False
            TabOrder = 1
            TitleAlignment = taLeftJustify
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Arial'
            TitleFont.Style = [fsBold]
            TitleLines = 1
            TitleButtons = False
            OnDblClick = grdTrainingScheduleDblClick
            FooterColor = clWhite
            object grdTrainingScheduleIButton: TwwIButton
              Left = 0
              Top = 0
              Width = 22
              Height = 22
              HelpContext = 781039
              AllowAllUp = True
              Glyph.Data = {
                26040000424D2604000000000000360000002800000012000000120000000100
                180000000000F0030000120B0000120B00000000000000000000FFFFFFFFFFFF
                636393525293FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF555591616191FFFFFFFFFFFF0000FDFDFD6060820000D20000DA3F3F
                7DF4F4F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F741417D0000CC00
                00CE5B5B80FBFBFB00009292A40000A40000C80000F60000BA30307BE7E7E7FF
                FFFFFFFFFFFFFFFFFFFFFFE7E7E734347C0000B20000FC0000D40000A28D8DA1
                000062628D0000BE0000D80000F80000F80000BA1F1F79DBDBDBFFFFFFFFFFFF
                D9D9D91C1C790000B00000FF1717FF0000F40000CA5C5C8900007979A90000CC
                0000D20000D60000F80000F40000B0131375DFDFDFDEDEDE1212750000B00000
                FA0F0FFF0000EA0000E40000E47373AB0000EAEAEC3F3FB30000CC0000D20000
                D80000F20000EE0000A812126B11116B0000A80000F60303FF0000E80000E200
                00DE3F3FBDEAEAEC0000FFFFFFFFFFFF4949B30000CC0000CE0000CC0000E400
                00DC00008A00008A0000DE0000EE0000E00000DE0000DC5252B6FFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFF6464AF0000D00000E00000E20000F60000D60000D6
                0000F40000DC0000D40000D26A6AB4FFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFF8888BB0101F60303FF0000F80000FC0000FC0000FC0505FF0303
                E89696BEFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFABAB
                AB0202910000E40000FC0000F80000F80000FC0000E2050592C7C7C7FFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFF94949C00005800007C0000D607
                07FF0000FC0000FC0707FF0000CC00007600004EAEAEB2FFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFF8E8E960000540000840000E00F0FFF0303FF1111FF0F0FFF
                0303FF0F0FFF0000D600007C00004CB1B1B3FFFFFFFFFFFF0000FFFFFF93939B
                00004E00007C0000EA1F1FFF1111FF1F1FFF0505EC0000F21F1FFF0F0FFF1F1F
                FF0000DC000078000044B3B3B7FFFFFF0000E0E0E100004400007E0000EC2D2D
                FF1919FF2F2FFF0101FCD8D8DDC5C5CF0B0BFF2D2DFF1919FF2929FF0000E000
                007A151547FBFBFB0000C7C7C80000820000F63535FF2525FF3D3DFF0202FFCA
                CAD3FFFFFFFFFFFFACACC11515FF3939FF2525FF3535FF0000EA00006EEAEAEA
                0000E0E0E20000EA5757FF2F2FFF4949FF0707FFCACAD3FFFFFFFFFFFFFFFFFF
                FFFFFFA6A6BF1B1BFF4343FF3333FF5151FF1414D9F7F7F70000FFFFFFB6B6CD
                1B1BFF6565FF1212FFC9C9D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFACAC
                C22929FF6565FF1616FAD3D3DCFFFFFF0000FFFFFFFFFFFFAFAFC43333E6CCCC
                D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9898BE3737E4E0
                E0E3FFFFFFFFFFFF0000}
              OnClick = grdTrainingScheduleIButtonClick
            end
          end
          object pnlMultiSelectOption: TDNMPanel
            Left = 416
            Top = 99
            Width = 197
            Height = 271
            HelpContext = 781040
            BevelInner = bvRaised
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
            DesignSize = (
              197
              271)
            object Panel1: TPanel
              Left = 8
              Top = 37
              Width = 182
              Height = 112
              HelpContext = 781041
              Anchors = [akLeft, akTop, akRight]
              BevelInner = bvLowered
              BevelOuter = bvLowered
              Color = clWhite
              TabOrder = 0
              DesignSize = (
                182
                112)
              object Label2: TLabel
                Left = 6
                Top = 6
                Width = 98
                Height = 15
                HelpContext = 781042
                Caption = 'If Day is Saturday'
              end
              object rgSaturday: TRadioGroup
                Left = 3
                Top = 21
                Width = 178
                Height = 89
                HelpContext = 781043
                Anchors = [akLeft, akTop, akRight, akBottom]
                Color = clWhite
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ItemIndex = 1
                Items.Strings = (
                  'Post'
                  'Drop'
                  'Shift After')
                ParentColor = False
                ParentFont = False
                TabOrder = 0
              end
            end
            object Panel2: TPanel
              Left = 8
              Top = 154
              Width = 182
              Height = 112
              HelpContext = 781044
              Anchors = [akLeft, akTop, akRight]
              BevelInner = bvLowered
              BevelOuter = bvLowered
              Color = clWhite
              TabOrder = 1
              DesignSize = (
                182
                112)
              object Label3: TLabel
                Left = 6
                Top = 6
                Width = 89
                Height = 15
                HelpContext = 781045
                Caption = 'If Day is Sunday'
              end
              object rgSunday: TRadioGroup
                Left = 3
                Top = 21
                Width = 178
                Height = 89
                HelpContext = 781046
                Anchors = [akLeft, akTop, akRight, akBottom]
                Color = clWhite
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ItemIndex = 1
                Items.Strings = (
                  'Post'
                  'Drop'
                  'Shift After')
                ParentColor = False
                ParentFont = False
                TabOrder = 0
              end
            end
            object DNMSpeedButton1: TDNMSpeedButton
              Left = 31
              Top = 5
              Width = 140
              Height = 27
              HelpContext = 781047
              Anchors = [akLeft, akTop, akRight]
              Caption = 'Select Dates'
              DisableTransparent = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              HotTrackFont.Charset = DEFAULT_CHARSET
              HotTrackFont.Color = clWindowText
              HotTrackFont.Height = -11
              HotTrackFont.Name = 'MS Sans Serif'
              HotTrackFont.Style = []
              ParentFont = False
              TabOrder = 2
              TabStop = False
              AutoDisableParentOnclick = True
              OnClick = DNMSpeedButton1Click
            end
          end
          object wwDBEdit1: TwwDBEdit
            Left = 878
            Top = 339
            Width = 103
            Height = 23
            HelpContext = 781048
            DataField = 'Days'
            DataSource = dsDaysforTraining
            ReadOnly = True
            TabOrder = 3
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
          end
          object wwDBEdit3: TwwDBEdit
            Left = 488
            Top = 60
            Width = 121
            Height = 23
            HelpContext = 781049
            DataField = 'HoursInADay'
            DataSource = dsTraining
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
          end
        end
        object tabEmployees: TTabSheet
          HelpContext = 781050
          Caption = 'Employees For Training'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object DNMPanel1: TDNMPanel
            Left = 0
            Top = 0
            Width = 984
            Height = 372
            HelpContext = 781051
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            object GradientLabel1: TGradientLabel
              Left = 1
              Top = 1
              Width = 982
              Height = 30
              HelpContext = 781052
              Align = alTop
              Alignment = taCenter
              AutoSize = False
              Caption = 'Select Employees To Be Trained'
              Color = clYellow
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -24
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
              Layout = tlCenter
              WordWrap = True
              ColorTo = clInfoBk
              EllipsType = etNone
              GradientType = gtFullVertical
              GradientDirection = gdLeftToRight
              Indent = 0
              LineWidth = 2
              Orientation = goHorizontal
              TransparentText = False
              VAlignment = vaTop
              Version = '1.1.1.0'
              ExplicitWidth = 986
            end
            object grdTrainingEmployeeModules: TwwDBGrid
              Left = 1
              Top = 31
              Width = 982
              Height = 340
              HelpContext = 781053
              ControlType.Strings = (
                'Accounts;CheckBox;T;F'
                'BasicFeatures;CheckBox;T;F'
                'Employee;CheckBox;T;F'
                'Inventory_Basics;CheckBox;T;F'
                'FileMaintenance;CheckBox;T;F'
                'Purchase;CheckBox;T;F'
                'CRM;CheckBox;T;F'
                'Marketing;CheckBox;T;F'
                'Sales;CheckBox;T;F'
                'Pos;CheckBox;T;F'
                'CustomerPayments;CheckBox;T;F'
                'SupplierPayments;CheckBox;T;F'
                'Banking;CheckBox;T;F'
                'Reports;CheckBox;T;F'
                'General;CheckBox;T;F'
                'Utilities;CheckBox;T;F'
                'Inventory_Advanced;CheckBox;T;F'
                'Manufacturing;CheckBox;T;F'
                'Appointments;CheckBox;T;F'
                'Payroll;CheckBox;T;F'
                'FixedAssets;CheckBox;T;F'
                'Workshop;CheckBox;T;F'
                'budgets;CheckBox;T;F'
                'Delivery;CheckBox;T;F'
                'Matrix;CheckBox;T;F'
                'MoreTraining;CheckBox;T;F'
                'DataImport;CheckBox;T;F'
                'ERPSetup;CheckBox;T;F'
                'Purchase_FX;CheckBox;T;F'
                'General_Templates;CheckBox;T;F'
                'How_To;CheckBox;T;F'
                'Hire;CheckBox;T;F')
              Selected.Strings = (
                'EmployeeName'#9'15'#9'Employee~(Dbl Click)'#9#9
                'ERPSetup'#9'1'#9'Setup'#9'F'#9
                'DataImport'#9'9'#9'Data Import'#9#9
                'BasicFeatures'#9'8'#9'Basic~Features'#9'F'#9
                'Employee'#9'10'#9'Employee'#9#9
                'Accounts'#9'10'#9'Accounts'#9#9
                'Inventory_Basics'#9'7'#9'Inventory~Basics'#9#9
                'Purchase'#9'10'#9'Purchase'#9#9
                'Sales'#9'10'#9'Sales'#9#9
                'CustomerPayments'#9'8'#9'Customer~Payments'#9#9
                'SupplierPayments'#9'8'#9'Supplier~Payments'#9#9
                'Banking'#9'10'#9'Banking'#9#9
                'Reports'#9'10'#9'Reports'#9#9
                'Appointments'#9'11'#9'Appointments'#9#9
                'General_Templates'#9'1'#9'General~Templates'#9'F'
                'Utilities'#9'10'#9'Utilities'#9#9
                'Inventory_Advanced'#9'8'#9'Inventory~Advanced'#9#9
                'Manufacturing'#9'11'#9'Manufacturing'#9#9
                'FileMaintenance'#9'10'#9'File~Maintenance'#9#9
                'How_To'#9'1'#9'How~To'#9'F'
                'Payroll'#9'10'#9'Payroll'#9#9
                'CRM'#9'10'#9'CRM'#9#9
                'Marketing'#9'10'#9'Marketing'#9#9
                'budgets'#9'10'#9'Budgets'#9#9
                'Purchase_FX'#9'10'#9'Purchase FX'#9'F'#9
                'Matrix'#9'10'#9'Matrix'#9#9
                'Pos'#9'10'#9'POS'#9'F'#9
                'Hire'#9'1'#9'Hire'#9'F'#9
                'Workshop'#9'10'#9'Workshop'#9#9
                'FixedAssets'#9'5'#9'Fixed~Assets'#9#9
                'Delivery'#9'10'#9'Delivery'#9#9
                'MoreTraining'#9'6'#9'More~Training'#9#9
                'MoreTrainingDetails'#9'20'#9'More Training~Details'#9#9
                'FieldName'#9'10'#9'FieldName'#9'F'#9
                'msUpdateSiteCode'#9'3'#9'msUpdateSiteCode'#9'F'#9)
              IniAttributes.Delimiter = ';;'
              TitleColor = clWhite
              FixedCols = 1
              ShowHorzScrollBar = True
              EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
              Align = alClient
              DataSource = dsTrainingEmployeeModules
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              KeyOptions = []
              ParentFont = False
              TabOrder = 0
              TitleAlignment = taLeftJustify
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -12
              TitleFont.Name = 'Arial'
              TitleFont.Style = [fsBold]
              TitleLines = 2
              TitleButtons = False
              OnCalcCellColors = grdTrainingEmployeeModulesCalcCellColors
              OnDblClick = grdTrainingEmployeeModulesDblClick
              FooterColor = clWhite
            end
          end
        end
      end
    end
  end
  object QryTrainingDays: TERPQuery [13]
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tbltrainingDays')
    Filtered = True
    Filter = 'Active ='#39'T'#39
    AfterOpen = QryTrainingDaysAfterOpen
    AfterPost = QryTrainingDaysAfterPost
    Left = 656
    Top = 232
    object QryTrainingDaysTrainingDate: TDateField
      DisplayLabel = 'Date'
      DisplayWidth = 27
      FieldName = 'TrainingDate'
      Origin = 'tbltrainingDays.TrainingDate'
    end
    object QryTrainingDaysStartTime: TDateTimeField
      DisplayLabel = 'From'
      DisplayWidth = 8
      FieldName = 'StartTime'
      Origin = 'tbltrainingDays.StartTime'
      DisplayFormat = 'hh:nn am/pm'
    end
    object QryTrainingDaysEndTime: TDateTimeField
      DisplayLabel = 'To'
      DisplayWidth = 8
      FieldName = 'EndTime'
      Origin = 'tbltrainingDays.EndTime'
      DisplayFormat = 'hh:nn am/pm'
    end
    object QryTrainingDaysTrainingID: TLargeintField
      DisplayWidth = 15
      FieldName = 'TrainingID'
      Origin = 'tbltrainingDays.TrainingID'
      Visible = False
    end
    object QryTrainingDaysActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tbltrainingDays.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object QryTrainingDaysGlobalref: TWideStringField
      DisplayWidth = 255
      FieldName = 'Globalref'
      Origin = 'tbltrainingDays.Globalref'
      Visible = False
      Size = 255
    end
    object QryTrainingDaysTrainingdayID: TLargeintField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 15
      FieldName = 'TrainingdayID'
      Origin = 'tbltrainingDays.TrainingdayID'
      Visible = False
    end
    object QryTrainingDaysmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tbltrainingDays.msTimeStamp'
      Visible = False
    end
  end
  object QryTrainingEmployeeModules: TERPQuery [14]
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblTrainingEmployeeModules')
    Left = 691
    Top = 232
    object QryTrainingEmployeeModulesEmployeeName: TWideStringField
      DisplayLabel = 'Employee~(Dbl Click)'
      DisplayWidth = 15
      FieldName = 'EmployeeName'
      Origin = 'tblTrainingEmployeeModules.EmployeeName'
      Size = 100
    end
    object QryTrainingEmployeeModulesERPSetup: TWideStringField
      DisplayLabel = 'Setup'
      DisplayWidth = 1
      FieldName = 'ERPSetup'
      Origin = 'tblTrainingEmployeeModules.ERPSetup'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesDataImport: TWideStringField
      DisplayLabel = 'Data Import'
      DisplayWidth = 9
      FieldName = 'DataImport'
      Origin = 'tblTrainingEmployeeModules.DataImport'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesBasicFeatures: TWideStringField
      DisplayLabel = 'Basic~Features'
      DisplayWidth = 8
      FieldName = 'BasicFeatures'
      Origin = 'tblTrainingEmployeeModules.BasicFeatures'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesEmployee: TWideStringField
      DisplayWidth = 10
      FieldName = 'Employee'
      Origin = 'tblTrainingEmployeeModules.Employee'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesAccounts: TWideStringField
      DisplayWidth = 10
      FieldName = 'Accounts'
      Origin = 'tblTrainingEmployeeModules.Accounts'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesInventory_Basics: TWideStringField
      DisplayLabel = 'Inventory~Basics'
      DisplayWidth = 7
      FieldName = 'Inventory_Basics'
      Origin = 'tblTrainingEmployeeModules.Inventory_Basics'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesPurchase: TWideStringField
      DisplayWidth = 10
      FieldName = 'Purchase'
      Origin = 'tblTrainingEmployeeModules.Purchase'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesSales: TWideStringField
      DisplayWidth = 10
      FieldName = 'Sales'
      Origin = 'tblTrainingEmployeeModules.Sales'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesCustomerPayments: TWideStringField
      DisplayLabel = 'Customer~Payments'
      DisplayWidth = 8
      FieldName = 'CustomerPayments'
      Origin = 'tblTrainingEmployeeModules.CustomerPayments'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesSupplierPayments: TWideStringField
      DisplayLabel = 'Supplier~Payments'
      DisplayWidth = 8
      FieldName = 'SupplierPayments'
      Origin = 'tblTrainingEmployeeModules.SupplierPayments'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesBanking: TWideStringField
      DisplayWidth = 10
      FieldName = 'Banking'
      Origin = 'tblTrainingEmployeeModules.Banking'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesReports: TWideStringField
      DisplayWidth = 10
      FieldName = 'Reports'
      Origin = 'tblTrainingEmployeeModules.Reports'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesAppointments: TWideStringField
      DisplayWidth = 11
      FieldName = 'Appointments'
      Origin = 'tblTrainingEmployeeModules.Appointments'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesGeneral_Templates: TWideStringField
      DisplayLabel = 'General~Templates'
      DisplayWidth = 1
      FieldName = 'General_Templates'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesUtilities: TWideStringField
      DisplayWidth = 10
      FieldName = 'Utilities'
      Origin = 'tblTrainingEmployeeModules.Utilities'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesInventory_Advanced: TWideStringField
      DisplayLabel = 'Inventory~Advanced'
      DisplayWidth = 8
      FieldName = 'Inventory_Advanced'
      Origin = 'tblTrainingEmployeeModules.Inventory_Advanced'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesManufacturing: TWideStringField
      DisplayWidth = 11
      FieldName = 'Manufacturing'
      Origin = 'tblTrainingEmployeeModules.Manufacturing'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesFileMaintenance: TWideStringField
      DisplayLabel = 'File~Maintenance'
      DisplayWidth = 10
      FieldName = 'FileMaintenance'
      Origin = 'tblTrainingEmployeeModules.FileMaintenance'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesHow_To: TWideStringField
      DisplayLabel = 'How~To'
      DisplayWidth = 1
      FieldName = 'How_To'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesPayroll: TWideStringField
      DisplayWidth = 10
      FieldName = 'Payroll'
      Origin = 'tblTrainingEmployeeModules.Payroll'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesCRM: TWideStringField
      DisplayWidth = 10
      FieldName = 'CRM'
      Origin = 'tblTrainingEmployeeModules.CRM'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesMarketing: TWideStringField
      DisplayWidth = 10
      FieldName = 'Marketing'
      Origin = 'tblTrainingEmployeeModules.Marketing'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesbudgets: TWideStringField
      DisplayLabel = 'Budgets'
      DisplayWidth = 10
      FieldName = 'budgets'
      Origin = 'tblTrainingEmployeeModules.budgets'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesPurchase_FX: TWideStringField
      DisplayLabel = 'Purchase FX'
      DisplayWidth = 10
      FieldName = 'Purchase_FX'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesMatrix: TWideStringField
      DisplayWidth = 10
      FieldName = 'Matrix'
      Origin = 'tblTrainingEmployeeModules.Matrix'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesPos: TWideStringField
      DisplayLabel = 'POS'
      DisplayWidth = 10
      FieldName = 'Pos'
      Origin = 'tblTrainingEmployeeModules.Pos'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesHire: TWideStringField
      DisplayWidth = 1
      FieldName = 'Hire'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesWorkshop: TWideStringField
      DisplayWidth = 10
      FieldName = 'Workshop'
      Origin = 'tblTrainingEmployeeModules.Workshop'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesFixedAssets: TWideStringField
      DisplayLabel = 'Fixed~Assets'
      DisplayWidth = 5
      FieldName = 'FixedAssets'
      Origin = 'tblTrainingEmployeeModules.FixedAssets'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesDelivery: TWideStringField
      DisplayWidth = 10
      FieldName = 'Delivery'
      Origin = 'tblTrainingEmployeeModules.Delivery'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesMoreTraining: TWideStringField
      DisplayLabel = 'More~Training'
      DisplayWidth = 6
      FieldName = 'MoreTraining'
      Origin = 'tblTrainingEmployeeModules.MoreTraining'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesMoreTrainingDetails: TWideStringField
      DisplayLabel = 'More Training~Details'
      DisplayWidth = 20
      FieldName = 'MoreTrainingDetails'
      Origin = 'tblTrainingEmployeeModules.MoreTrainingDetails'
      Size = 255
    end
    object QryTrainingEmployeeModulesFieldName: TWordField
      DisplayWidth = 10
      FieldName = 'FieldName'
    end
    object QryTrainingEmployeeModulesmsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
    object QryTrainingEmployeeModulesTrainingID: TLargeintField
      DisplayWidth = 15
      FieldName = 'TrainingID'
      Origin = 'tblTrainingEmployeeModules.TrainingID'
      Visible = False
    end
    object QryTrainingEmployeeModulesGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblTrainingEmployeeModules.GlobalRef'
      Visible = False
      Size = 255
    end
    object QryTrainingEmployeeModulesTrainingEmployeeModuleID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'TrainingEmployeeModuleID'
      Origin = 'tblTrainingEmployeeModules.TrainingEmployeeModuleID'
      Visible = False
    end
    object QryTrainingEmployeeModulesEmployeeId: TIntegerField
      FieldName = 'EmployeeId'
      Origin = 'tblTrainingEmployeeModules.EmployeeId'
      Visible = False
    end
    object QryTrainingEmployeeModulesDateCreated: TDateTimeField
      FieldName = 'DateCreated'
      Origin = 'tblTrainingEmployeeModules.DateCreated'
      Visible = False
    end
    object QryTrainingEmployeeModulesEnteredby: TIntegerField
      FieldName = 'Enteredby'
      Origin = 'tblTrainingEmployeeModules.Enteredby'
      Visible = False
    end
    object QryTrainingEmployeeModulesmstimestamp: TDateTimeField
      FieldName = 'mstimestamp'
      Origin = 'tblTrainingEmployeeModules.mstimestamp'
      Visible = False
    end
  end
  object dsTrainingEmployeeModules: TDataSource [15]
    DataSet = QryTrainingEmployeeModules
    Left = 691
    Top = 200
  end
  object dsTrainingDays: TDataSource [16]
    DataSet = QryTrainingDays
    Left = 656
    Top = 200
  end
  object qryTraining: TERPQuery [17]
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblTraining')
    Left = 726
    Top = 232
    object ERPQuery1GlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblTraining.GlobalRef'
      Size = 255
    end
    object ERPQuery1TrainingID: TLargeintField
      AutoGenerateValue = arAutoInc
      FieldName = 'TrainingID'
      Origin = 'tblTraining.TrainingID'
    end
    object ERPQuery1Description: TWideStringField
      FieldName = 'Description'
      Origin = 'tblTraining.Description'
      Size = 100
    end
    object ERPQuery1TrainingDate: TDateField
      FieldName = 'TrainingDate'
      Origin = 'tblTraining.TrainingDate'
    end
    object ERPQuery1msTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblTraining.msTimeStamp'
    end
    object qryTrainingMinutesInADay: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'MinutesInADay'
      Calculated = True
    end
    object qryTrainingHoursInADay: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'HoursInADay'
      Calculated = True
    end
    object qryTrainingStartOfTheDay: TTimeField
      FieldName = 'StartOfTheDay'
      Origin = 'tblTraining.StartOfTheDay'
      DisplayFormat = 'HH:NN:SS AM/PM'
    end
    object qryTrainingEndOftheDay: TTimeField
      FieldName = 'EndOftheDay'
      Origin = 'tblTraining.EndOftheDay'
      DisplayFormat = 'HH:NN:SS AM/PM'
    end
    object qryTrainingTotalHours: TFloatField
      FieldName = 'TotalHours'
      Origin = 'tblTraining.TotalHours'
    end
    object qryTrainingTotalTrainingDays: TIntegerField
      FieldName = 'TotalTrainingDays'
    end
    object qryTrainingmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
  end
  object dsTraining: TDataSource [18]
    DataSet = qryTraining
    Left = 726
    Top = 200
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102003800740010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00E00FFDFF00000000E00FF8FF00000000
      E00FF8FF00000000F00FF87F00000000F00FF81F00000000F80FF80F00000000
      F007F00F00000000F007E00F00000000F007E00F00000000F00FE00F00000000
      F01FF01F00000000F81FF00F00000000FE1FF00F00000000FF1FF00700000000
      FF1FF00700000000FFBFF0070000000000000000000000000000000000000000
      000000000000}
  end
  inherited Timer11: TTimer
    Left = 192
    Top = 8
  end
  object MnuCalendar: TAdvPopupMenu
    AutoHotkeys = maManual
    OnPopup = MnuCalendarPopup
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 832
    Top = 200
    object SelectDatesforTraining1: TMenuItem
      Caption = 'Select Dates for Training'
      HelpContext = 781054
      OnClick = SelectDatesforTraining1Click
    end
    object mnuautoSelectDays: TMenuItem
      Caption = 'Auto Select 3+3+2 days From here'
      HelpContext = 781055
      OnClick = mnuautoSelectDaysClick
    end
  end
  object qryTrainingDay: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblTrainingDay')
    AfterPost = qryTrainingDayAfterPost
    Left = 761
    Top = 232
    object qryTrainingDayDescription: TWideStringField
      DisplayWidth = 20
      FieldName = 'Description'
      Origin = 'tbltrainingday.Description'
      Size = 50
    end
    object qryTrainingDayTimeFrom: TWideStringField
      DisplayLabel = 'From'
      DisplayWidth = 12
      FieldName = 'TimeFrom'
      Origin = 'tbltrainingday.TimeFrom'
      Size = 50
    end
    object qryTrainingDayTimeTo: TWideStringField
      DisplayLabel = 'To'
      DisplayWidth = 12
      FieldName = 'TimeTo'
      Origin = 'tbltrainingday.TimeTo'
      Size = 50
    end
    object qryTrainingDayActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tbltrainingday.Active'
      FixedChar = True
      Size = 1
    end
    object qryTrainingDayID: TLargeintField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 15
      FieldName = 'ID'
      Origin = 'tbltrainingday.ID'
      Visible = False
    end
    object qryTrainingDayGlobalref: TWideStringField
      DisplayWidth = 255
      FieldName = 'Globalref'
      Origin = 'tbltrainingday.Globalref'
      Visible = False
      Size = 255
    end
    object qryTrainingDaymsTimestamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimestamp'
      Origin = 'tbltrainingday.msTimestamp'
      Visible = False
    end
    object qryTrainingDayTrainingID: TIntegerField
      DisplayWidth = 10
      FieldName = 'TrainingID'
      Origin = 'tbltrainingday.TrainingID'
      Visible = False
    end
    object qryTrainingDaytTimeFrom: TTimeField
      FieldName = 'tTimeFrom'
      Origin = 'tbltrainingday.tTimeFrom'
      Visible = False
    end
    object qryTrainingDaytTimeTo: TTimeField
      FieldName = 'tTimeTo'
      Origin = 'tbltrainingday.tTimeTo'
      Visible = False
    end
  end
  object dsTrainingDay: TDataSource
    DataSet = qryTrainingDay
    Left = 761
    Top = 200
  end
  object qryDaysforTraining: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select TRainingId, count(*) as Days from tblTrainingDays where a' +
        'ctive ="T" group by TRainingId')
    Left = 796
    Top = 232
    object qryDaysforTrainingDays: TLargeintField
      FieldName = 'Days'
      Origin = '.Days'
    end
  end
  object dsDaysforTraining: TDataSource
    DataSet = qryDaysforTraining
    Left = 796
    Top = 200
  end
  object qryTrainingLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblTraining')
    Left = 726
    Top = 296
    object WideStringField2: TWideStringField
      DisplayWidth = 40
      FieldName = 'Description'
      Origin = 'tblTraining.Description'
      Size = 100
    end
    object WideStringField1: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblTraining.GlobalRef'
      Visible = False
      Size = 255
    end
    object LargeintField1: TLargeintField
      AutoGenerateValue = arAutoInc
      FieldName = 'TrainingID'
      Origin = 'tblTraining.TrainingID'
      Visible = False
    end
    object DateField1: TDateField
      FieldName = 'TrainingDate'
      Origin = 'tblTraining.TrainingDate'
      Visible = False
    end
    object DateTimeField1: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblTraining.msTimeStamp'
      Visible = False
    end
    object IntegerField1: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'MinutesInADay'
      Visible = False
      Calculated = True
    end
    object WideStringField3: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'HoursInADay'
      Visible = False
      Calculated = True
    end
    object TimeField1: TTimeField
      FieldName = 'StartOfTheDay'
      Origin = 'tblTraining.StartOfTheDay'
      Visible = False
      DisplayFormat = 'HH:NN:SS AM/PM'
    end
    object TimeField2: TTimeField
      FieldName = 'EndOftheDay'
      Origin = 'tblTraining.EndOftheDay'
      Visible = False
      DisplayFormat = 'HH:NN:SS AM/PM'
    end
    object FloatField1: TFloatField
      FieldName = 'TotalHours'
      Origin = 'tblTraining.TotalHours'
      Visible = False
    end
  end
end
