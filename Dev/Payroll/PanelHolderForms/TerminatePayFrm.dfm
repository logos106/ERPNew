inherited frmTerminatePay: TfrmTerminatePay
  Left = 234
  Top = 237
  HelpContext = 587000
  Caption = 'frmTerminatePay'
  ClientHeight = 446
  ClientWidth = 816
  OldCreateOrder = True
  ExplicitLeft = 234
  ExplicitTop = 237
  ExplicitWidth = 824
  ExplicitHeight = 473
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 446
    Width = 816
    ExplicitTop = 446
    ExplicitWidth = 816
    HelpContext = 587010
  end
  object DNMPanel1: TDNMPanel [3]
    Left = 0
    Top = 40
    Width = 799
    Height = 283
    HelpContext = 587001
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      799
      283)
    object Bevel1: TBevel
      Left = 8
      Top = 8
      Width = 783
      Height = 268
      HelpContext = 587002
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
    end
    object Label11: TLabel
      Left = 143
      Top = 19
      Width = 393
      Height = 49
      HelpContext = 587003
      AutoSize = False
      Caption = 
        'If the employee has not been paid for current work done, then pl' +
        'ease select "Pay Employee" below.  Otherwise select "Do not Pay ' +
        'Employee".'
      Transparent = True
      WordWrap = True
    end
    object Label40: TLabel
      Left = 143
      Top = 197
      Width = 393
      Height = 48
      HelpContext = 587004
      Alignment = taCenter
      AutoSize = False
      Caption = 
        'PLEASE NOTE: If this employee is paid by a timesheet then you wi' +
        'll be required to load their pay before continuing.  To do this ' +
        'now, then please click on the appropriate button below.'
      Transparent = True
      Visible = False
      WordWrap = True
    end
    object Bevel2: TBevel
      Left = 590
      Top = 16
      Width = 193
      Height = 252
      HelpContext = 587005
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
    end
    object lblPrepare: TLabel
      Left = 597
      Top = 80
      Width = 177
      Height = 60
      Alignment = taCenter
      AutoSize = False
      Caption = 
        'Please only adjust hours worked as the wizard will calculate the' +
        ' balance including leave.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      WordWrap = True
      HelpContext = 587011
    end
    object rgPayStatus: TwwRadioGroup
      Left = 143
      Top = 89
      Width = 393
      Height = 93
      HelpContext = 587006
      DisableThemes = False
      TransparentActiveItem = True
      Indents.TextX = 5
      Transparent = True
      Caption = 'Payments for Unpaid Work'
      DataField = 'IsPayEntitled'
      DataSource = DSEmpTerminate
      Items.Strings = (
        'Pay Employee'
        'Do Not Pay Employee')
      TabOrder = 0
      Values.Strings = (
        'T'
        'F')
      OnClick = rgPayStatusClick
    end
    object btnPrepare: TDNMSpeedButton
      Left = 632
      Top = 46
      Width = 105
      Height = 27
      HelpContext = 587007
      Caption = '&View/Edit Pay'
      DisableTransparent = False
      Enabled = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 1
      OnClick = btnPrepareClick
    end
    object btnLoadTimesheet: TDNMSpeedButton
      Left = 632
      Top = 160
      Width = 105
      Height = 27
      HelpContext = 587008
      Caption = '&Load Timesheet'
      DisableTransparent = False
      Enabled = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 2
      Visible = False
      OnClick = btnLoadTimesheetClick
    end
    object btnLoadRoster: TDNMSpeedButton
      Left = 632
      Top = 210
      Width = 105
      Height = 27
      HelpContext = 587009
      Caption = '&Load Roster'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 3
      Visible = False
      OnClick = btnLoadRosterClick
    end
  end
  object DSEmpTerminate: TDataSource
    Left = 512
  end
end
