inherited DashBoardSalesRatioGUI: TDashBoardSalesRatioGUI
  Left = 388
  Top = 116
  HelpContext = 680000
  Caption = 'Sales Ratio'
  ClientHeight = 271
  ClientWidth = 363
  ExplicitLeft = 388
  ExplicitTop = 116
  ExplicitWidth = 371
  ExplicitHeight = 298
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 271
    Width = 363
    ExplicitTop = 271
    ExplicitWidth = 363
    HelpContext = 680031
  end
  inherited pnlmain: TDNMPanel
    Width = 363
    Height = 271
    HelpContext = 680001
    ExplicitWidth = 363
    ExplicitHeight = 271
    inherited pnlHeader: TDNMPanel
      Width = 361
      HelpContext = 680002
      Caption = 'Sales Ratio'
      ExplicitWidth = 361
    end
    inherited pnlDetails: TDNMPanel
      Width = 361
      Height = 246
      HelpContext = 680003
      ExplicitLeft = 2
      ExplicitTop = 31
      ExplicitWidth = 361
      ExplicitHeight = 246
      object pnlEmployee: TDNMPanel
        Left = 1
        Top = 1
        Width = 359
        Height = 244
        HelpContext = 680006
        Align = alClient
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        DesignSize = (
          359
          244)
        object DBText1: TDBText
          Left = 1
          Top = 1
          Width = 357
          Height = 17
          HelpContext = 680007
          Align = alTop
          Alignment = taCenter
          DataField = 'EmployeeName'
          DataSource = dsmain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          ExplicitWidth = 349
        end
        object Label1: TLabel
          Left = 63
          Top = 31
          Width = 35
          Height = 15
          HelpContext = 680008
          Alignment = taRightJustify
          Anchors = []
          Caption = 'Leads'
          WordWrap = True
        end
        object Label2: TLabel
          Left = 49
          Top = 60
          Width = 49
          Height = 15
          HelpContext = 680009
          Alignment = taRightJustify
          Anchors = []
          Caption = 'OverDue'
          WordWrap = True
        end
        object Label3: TLabel
          Left = 40
          Top = 89
          Width = 58
          Height = 15
          HelpContext = 680010
          Alignment = taRightJustify
          Anchors = []
          Caption = 'FollowUps'
          WordWrap = True
        end
        object Label4: TLabel
          Left = 218
          Top = 60
          Width = 54
          Height = 15
          HelpContext = 680011
          Alignment = taRightJustify
          Anchors = []
          Caption = 'Approved'
          WordWrap = True
        end
        object Label5: TLabel
          Left = 196
          Top = 31
          Width = 76
          Height = 15
          HelpContext = 680012
          Alignment = taRightJustify
          Anchors = []
          Caption = 'Not Approved'
        end
        object Label6: TLabel
          Left = 49
          Top = 176
          Width = 121
          Height = 15
          HelpContext = 680013
          Alignment = taRightJustify
          Anchors = []
          Caption = 'Approved Sales Ratio'
        end
        object Label7: TLabel
          Left = 68
          Top = 147
          Width = 102
          Height = 15
          HelpContext = 680014
          Alignment = taRightJustify
          Anchors = []
          Caption = 'Leads Sales Ratio'
        end
        object Label8: TLabel
          Left = 240
          Top = 89
          Width = 32
          Height = 15
          HelpContext = 680015
          Alignment = taRightJustify
          Anchors = []
          Caption = 'Sales'
          WordWrap = True
        end
        object Label9: TLabel
          Left = 46
          Top = 118
          Width = 124
          Height = 15
          HelpContext = 680016
          Alignment = taRightJustify
          Anchors = []
          Caption = 'Leads Approved Ratio'
        end
        object DBEdit1: TDBEdit
          Left = 107
          Top = 27
          Width = 62
          Height = 23
          HelpContext = 680017
          Anchors = []
          DataField = 'Leads'
          DataSource = dsmain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
        end
        object DBEdit2: TDBEdit
          Left = 107
          Top = 56
          Width = 62
          Height = 23
          HelpContext = 680018
          Anchors = []
          DataField = 'OverDue'
          DataSource = dsmain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
        end
        object DBEdit3: TDBEdit
          Left = 107
          Top = 85
          Width = 62
          Height = 23
          HelpContext = 680019
          Anchors = []
          DataField = 'FollowUps'
          DataSource = dsmain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
        end
        object DBEdit4: TDBEdit
          Left = 280
          Top = 56
          Width = 62
          Height = 23
          HelpContext = 680020
          Anchors = []
          DataField = 'Approved'
          DataSource = dsmain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
        end
        object DBEdit5: TDBEdit
          Left = 280
          Top = 85
          Width = 62
          Height = 23
          HelpContext = 680021
          Anchors = []
          DataField = 'Sales'
          DataSource = dsmain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
        end
        object DBEdit6: TDBEdit
          Left = 177
          Top = 114
          Width = 161
          Height = 23
          HelpContext = 680022
          Anchors = []
          DataField = 'LeadsApprovedRatio'
          DataSource = dsmain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
        end
        object DBEdit7: TDBEdit
          Left = 280
          Top = 27
          Width = 62
          Height = 23
          HelpContext = 680023
          Anchors = []
          DataField = 'NotApproved'
          DataSource = dsmain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
        end
        object DBEdit8: TDBEdit
          Left = 177
          Top = 172
          Width = 161
          Height = 23
          HelpContext = 680024
          Anchors = []
          DataField = 'ApprovedSalesRatio'
          DataSource = dsmain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 7
        end
        object DBEdit9: TDBEdit
          Left = 177
          Top = 143
          Width = 161
          Height = 23
          HelpContext = 680025
          Anchors = []
          DataField = 'LeadsSalesRatio'
          DataSource = dsmain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 8
        end
        object wwDBNavigator1: TwwDBNavigator
          Left = 1
          Top = 218
          Width = 357
          Height = 25
          HelpContext = 680026
          DataSource = dsmain
          RepeatInterval.InitialDelay = 500
          RepeatInterval.Interval = 100
          Align = alBottom
          object wwDBNavigator1First: TwwNavButton
            Left = 0
            Top = 0
            Width = 25
            Height = 25
            Hint = 'Move to first record'
            HelpContext = 680027
            ImageIndex = -1
            NumGlyphs = 2
            Spacing = 4
            Transparent = False
            Caption = 'wwDBNavigator1First'
            Enabled = False
            DisabledTextColors.ShadeColor = clGray
            DisabledTextColors.HighlightColor = clBtnHighlight
            Index = 0
            Style = nbsFirst
          end
          object wwDBNavigator1Prior: TwwNavButton
            Left = 25
            Top = 0
            Width = 25
            Height = 25
            Hint = 'Move to prior record'
            HelpContext = 680028
            ImageIndex = -1
            NumGlyphs = 2
            Spacing = 4
            Transparent = False
            Caption = 'wwDBNavigator1Prior'
            Enabled = False
            DisabledTextColors.ShadeColor = clGray
            DisabledTextColors.HighlightColor = clBtnHighlight
            Index = 1
            Style = nbsPrior
          end
          object wwDBNavigator1Next: TwwNavButton
            Left = 50
            Top = 0
            Width = 25
            Height = 25
            Hint = 'Move to next record'
            HelpContext = 680029
            ImageIndex = -1
            NumGlyphs = 2
            Spacing = 4
            Transparent = False
            Caption = 'wwDBNavigator1Next'
            Enabled = False
            DisabledTextColors.ShadeColor = clGray
            DisabledTextColors.HighlightColor = clBtnHighlight
            Index = 2
            Style = nbsNext
          end
          object wwDBNavigator1Last: TwwNavButton
            Left = 75
            Top = 0
            Width = 25
            Height = 25
            Hint = 'Move to last record'
            HelpContext = 680030
            ImageIndex = -1
            NumGlyphs = 2
            Spacing = 4
            Transparent = False
            Caption = 'wwDBNavigator1Last'
            Enabled = False
            DisabledTextColors.ShadeColor = clGray
            DisabledTextColors.HighlightColor = clBtnHighlight
            Index = 3
            Style = nbsLast
          end
        end
      end
    end
  end
  inherited Customisemenu: TPopupMenu
    HelpContext = 680034
    Left = 48
    Top = 65528
  end
  object qrymain: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tmp_tmp_DashBoard_SalesRatios_Admin_324707B0')
    Left = 8
  end
  object dsmain: TDataSource
    DataSet = qrymain
    Left = 80
  end
  object MyConnection: TERPConnection
    Port = 3309
    Options.UseUnicode = True
    Options.KeepDesignConnected = False
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    LoginPrompt = False
    Left = 274
    Top = 65534
  end
end
