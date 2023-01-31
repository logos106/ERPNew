inherited SalesdashBoardsaleaAnalysisManualGUI: TSalesdashBoardsaleaAnalysisManualGUI
  Left = 2242
  Top = 101
  HelpContext = 1002001
  Caption = 'SalesdashBoardsaleaAnalysisManualGUI'
  ClientHeight = 210
  ClientWidth = 335
  ExplicitWidth = 351
  ExplicitHeight = 249
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 210
    Width = 335
    HelpContext = 1002002
    ExplicitTop = 271
    ExplicitWidth = 363
  end
  inherited pnlmain: TDNMPanel
    Width = 335
    Height = 210
    HelpContext = 1002003
    ExplicitWidth = 335
    ExplicitHeight = 210
    inherited pnlHeader: TDNMPanel
      Width = 333
      HelpContext = 1002004
      Caption = 'Sales Analysis (Manual)'
      ExplicitWidth = 333
    end
    inherited pnlDetails: TDNMPanel
      Width = 333
      Height = 185
      HelpContext = 1002005
      ExplicitWidth = 333
      ExplicitHeight = 185
      DesignSize = (
        333
        185)
      object Bevel3: TBevel
        Left = 2
        Top = 78
        Width = 327
        Height = 52
        HelpContext = 1002006
        Anchors = [akLeft, akRight]
        Shape = bsFrame
      end
      object Bevel1: TBevel
        Left = 2
        Top = 22
        Width = 154
        Height = 52
        HelpContext = 1002007
        Anchors = [akLeft]
        Shape = bsFrame
      end
      object Bevel2: TBevel
        Left = 158
        Top = 22
        Width = 171
        Height = 52
        HelpContext = 1002008
        Anchors = [akRight]
        Shape = bsFrame
      end
      object bvl1: TBevel
        Left = 2
        Top = 134
        Width = 215
        Height = 47
        HelpContext = 1002009
        Anchors = [akLeft, akBottom]
        Shape = bsFrame
      end
      object DBText1: TDBText
        Left = 1
        Top = 1
        Width = 331
        Height = 17
        HelpContext = 1002010
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
      object lbl1: TLabel
        Left = 5
        Top = 24
        Width = 56
        Height = 15
        HelpContext = 1002011
        Anchors = [akLeft]
        Caption = 'Cold Calls'
      end
      object lbl2: TLabel
        Left = 81
        Top = 24
        Width = 51
        Height = 15
        HelpContext = 1002012
        Anchors = [akLeft]
        Caption = 'Contacts'
        WordWrap = True
      end
      object lbl3: TLabel
        Left = 163
        Top = 24
        Width = 68
        Height = 15
        HelpContext = 1002013
        Anchors = [akRight]
        Caption = 'First Demos'
      end
      object lbl4: TLabel
        Left = 240
        Top = 24
        Width = 86
        Height = 15
        HelpContext = 1002014
        Anchors = [akRight]
        Caption = 'Second Demos'
      end
      object lbl9: TLabel
        Left = 62
        Top = 137
        Width = 26
        Height = 15
        HelpContext = 1002015
        Alignment = taRightJustify
        Anchors = [akLeft]
        Caption = 'Cost'
      end
      object lbl8: TLabel
        Left = 10
        Top = 157
        Width = 40
        Height = 15
        HelpContext = 1002016
        Alignment = taRightJustify
        Anchors = [akLeft]
        Caption = 'Budget'
      end
      object lbl10: TLabel
        Left = 139
        Top = 137
        Width = 42
        Height = 15
        HelpContext = 1002017
        Alignment = taRightJustify
        Anchors = [akLeft]
        Caption = 'Income'
      end
      object lbl7: TLabel
        Left = 232
        Top = 80
        Width = 32
        Height = 15
        HelpContext = 1002018
        Alignment = taRightJustify
        Anchors = [akRight]
        Caption = 'Sales'
        WordWrap = True
      end
      object lbl6: TLabel
        Left = 118
        Top = 80
        Width = 75
        Height = 15
        HelpContext = 1002019
        Alignment = taRightJustify
        Anchors = []
        Caption = 'Sales Orders'
      end
      object lbl5: TLabel
        Left = 5
        Top = 80
        Width = 41
        Height = 15
        HelpContext = 1002020
        Alignment = taRightJustify
        Anchors = [akLeft]
        Caption = 'Quotes'
      end
      object DBEdit1: TDBEdit
        Left = 5
        Top = 45
        Width = 69
        Height = 23
        HelpContext = 1002021
        Anchors = [akLeft]
        DataField = 'coldcalls'
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
        Left = 81
        Top = 45
        Width = 69
        Height = 23
        HelpContext = 1002022
        Anchors = [akLeft]
        DataField = 'contact'
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
        Left = 163
        Top = 45
        Width = 69
        Height = 23
        HelpContext = 1002023
        Anchors = [akRight]
        DataField = 'firstdemo'
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
      object DBEdit6: TDBEdit
        Left = 240
        Top = 45
        Width = 69
        Height = 23
        HelpContext = 1002024
        Anchors = [akRight]
        DataField = 'seconddemo'
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
      object DBEdit9: TDBEdit
        Left = 62
        Top = 153
        Width = 62
        Height = 23
        HelpContext = 1002025
        Anchors = [akLeft]
        DataField = 'budgetcost'
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
      object DBEdit8: TDBEdit
        Left = 139
        Top = 153
        Width = 62
        Height = 23
        HelpContext = 1002026
        Anchors = [akLeft]
        DataField = 'budgetincome'
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
      object wwDBNavigator1: TwwDBNavigator
        Left = 226
        Top = 145
        Width = 100
        Height = 25
        HelpContext = 1002027
        DataSource = dsmain
        RepeatInterval.InitialDelay = 500
        RepeatInterval.Interval = 100
        Anchors = [akRight]
        object wwDBNavigator1First: TwwNavButton
          Left = 0
          Top = 0
          Width = 25
          Height = 25
          Hint = 'Move to first record'
          HelpContext = 1002028
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
          HelpContext = 1002029
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
          HelpContext = 1002030
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
          HelpContext = 1002031
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
      object DBEdit5: TDBEdit
        Left = 232
        Top = 98
        Width = 87
        Height = 23
        HelpContext = 1002032
        Anchors = [akRight]
        DataField = 'sales'
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
      object DBEdit4: TDBEdit
        Left = 118
        Top = 98
        Width = 87
        Height = 23
        HelpContext = 1002033
        Anchors = []
        DataField = 'salesorders'
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
      object DBEdit7: TDBEdit
        Left = 5
        Top = 98
        Width = 87
        Height = 23
        HelpContext = 1002034
        Anchors = [akLeft]
        DataField = 'quotes'
        DataSource = dsmain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 9
      end
    end
  end
  object qrymain: TERPQuery
    SQL.Strings = (
      'select * from tmp_tmp_DashBoard_SalesRatios_Admin_324707B0')
    Left = 8
    Top = 48
  end
  object dsmain: TDataSource
    DataSet = qrymain
    Left = 80
  end
end
