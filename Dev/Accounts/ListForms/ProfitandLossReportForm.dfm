inherited ProfitandLossGUI: TProfitandLossGUI
  Left = 720
  Top = 318
  HelpContext = 450000
  Caption = 'Profit and Loss'
  ClientWidth = 1016
  OldCreateOrder = True
  OnActivate = nil
  ExplicitWidth = 1022
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Width = 1016
    ExplicitTop = 462
    ExplicitWidth = 1250
  end
  inherited FilterLabel: TLabel
    Width = 1016
    HelpContext = 450001
  end
  inherited pnlGraph: TDNMPanel
    Width = 1016
    HelpContext = 450051
    ExplicitWidth = 1016
  end
  inherited HeaderPanel: TPanel
    Width = 1016
    HelpContext = 450020
    Color = 15199967
    ExplicitWidth = 1016
    DesignSize = (
      1016
      129)
    inherited lblFrom: TLabel
      Left = 790
      HelpContext = 450021
      ExplicitLeft = 1024
    end
    inherited lblTo: TLabel
      Left = 912
      HelpContext = 450022
      ExplicitLeft = 1146
    end
    inherited imgReportTablesMsg: TImage
      Left = 991
      Picture.Data = {
        0954474946496D6167654749463839611100120077000021F904010000FC002C
        0000000011001200870000000000330000660000990000CC0000FF002B00002B
        33002B66002B99002BCC002BFF0055000055330055660055990055CC0055FF00
        80000080330080660080990080CC0080FF00AA0000AA3300AA6600AA9900AACC
        00AAFF00D50000D53300D56600D59900D5CC00D5FF00FF0000FF3300FF6600FF
        9900FFCC00FFFF3300003300333300663300993300CC3300FF332B00332B3333
        2B66332B99332BCC332BFF3355003355333355663355993355CC3355FF338000
        3380333380663380993380CC3380FF33AA0033AA3333AA6633AA9933AACC33AA
        FF33D50033D53333D56633D59933D5CC33D5FF33FF0033FF3333FF6633FF9933
        FFCC33FFFF6600006600336600666600996600CC6600FF662B00662B33662B66
        662B99662BCC662BFF6655006655336655666655996655CC6655FF6680006680
        336680666680996680CC6680FF66AA0066AA3366AA6666AA9966AACC66AAFF66
        D50066D53366D56666D59966D5CC66D5FF66FF0066FF3366FF6666FF9966FFCC
        66FFFF9900009900339900669900999900CC9900FF992B00992B33992B66992B
        99992BCC992BFF9955009955339955669955999955CC9955FF99800099803399
        80669980999980CC9980FF99AA0099AA3399AA6699AA9999AACC99AAFF99D500
        99D53399D56699D59999D5CC99D5FF99FF0099FF3399FF6699FF9999FFCC99FF
        FFCC0000CC0033CC0066CC0099CC00CCCC00FFCC2B00CC2B33CC2B66CC2B99CC
        2BCCCC2BFFCC5500CC5533CC5566CC5599CC55CCCC55FFCC8000CC8033CC8066
        CC8099CC80CCCC80FFCCAA00CCAA33CCAA66CCAA99CCAACCCCAAFFCCD500CCD5
        33CCD566CCD599CCD5CCCCD5FFCCFF00CCFF33CCFF66CCFF99CCFFCCCCFFFFFF
        0000FF0033FF0066FF0099FF00CCFF00FFFF2B00FF2B33FF2B66FF2B99FF2BCC
        FF2BFFFF5500FF5533FF5566FF5599FF55CCFF55FFFF8000FF8033FF8066FF80
        99FF80CCFF80FFFFAA00FFAA33FFAA66FFAA99FFAACCFFAAFFFFD500FFD533FF
        D566FFD599FFD5CCFFD5FFFFFF00FFFF33FFFF66FFFF99FFFFCCFFFFFF000000
        000000000000000000084B0025081C48B0E0C07D08132A5C28709FC1870E2544
        7C4830E2448A0D33623CA851A144841C2576D43852E4C48B161B262429B265CA
        96255FA28CC9F2E54697374BDEB4B8B0E7CA9C050302003B}
      ExplicitLeft = 1225
    end
    inherited cboDateRange: TComboBox
      Left = 825
      HelpContext = 450043
      TabOrder = 9
      ExplicitLeft = 825
    end
    object Panel4: TPanel [5]
      Left = 7
      Top = 6
      Width = 268
      Height = 45
      HelpContext = 450044
      BevelInner = bvRaised
      BevelOuter = bvLowered
      ParentColor = True
      TabOrder = 3
      object lblClassTitle: TLabel
        Left = 10
        Top = 15
        Width = 67
        Height = 15
        HelpContext = 450045
        Alignment = taCenter
        Caption = 'Department'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 206
        Top = 15
        Width = 32
        Height = 15
        HelpContext = 450046
        Alignment = taCenter
        AutoSize = False
        Caption = 'All'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object chkAllClass: TwwCheckBox
        Left = 236
        Top = 14
        Width = 15
        Height = 17
        HelpContext = 450047
        DisableThemes = False
        AlwaysTransparent = True
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'All'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ShowText = False
        State = cbChecked
        TabOrder = 0
        OnClick = chkAllClassClick
      end
      object btnDeptSelect: TDNMSpeedButton
        Left = 83
        Top = 9
        Width = 103
        Height = 28
        HelpContext = 450052
        Caption = 'Select'
        DisableTransparent = False
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        TabOrder = 1
        AutoDisableParentOnclick = True
        OnClick = btnDeptSelectClick
      end
    end
    inherited pnlHeader: TPanel
      Left = 279
      Width = 457
      HelpContext = 450023
      Caption = 'Profit and Loss Report'
      ExplicitLeft = 279
      ExplicitWidth = 457
      inherited TitleShader: TShader
        Width = 455
        HelpContext = 450024
        ExplicitWidth = 455
        inherited TitleLabel: TLabel
          Width = 455
          HelpContext = 450025
          ExplicitWidth = 465
        end
      end
    end
    inherited Panel2: TPanel
      Width = 1016
      HelpContext = 450026
      ExplicitWidth = 1016
      inherited lblcheck2: TLabel
        Left = 479
        ExplicitLeft = 479
      end
      inherited grpFilters: TwwRadioGroup
        Left = 485
        Width = 168
        HelpContext = 450027
        ItemIndex = 0
        Align = alNone
        Items.Strings = (
          'Ex'
          'Inc'
          'Both')
        ExplicitLeft = 485
        ExplicitWidth = 168
      end
      object btnPnlByPeriodcomp: TDNMSpeedButton [2]
        AlignWithMargins = True
        Left = 909
        Top = 3
        Width = 104
        Height = 31
        HelpContext = 450035
        Align = alRight
        Caption = 'By Period (Comp)'
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
        WordWrap = True
        AutoDisableParentOnclick = True
        OnClick = btnPnlByPeriodcompClick
      end
      inherited pnlButtons: TPanel
        Width = 479
        HelpContext = 450028
        ExplicitWidth = 479
        inherited lblcustomReport: TLabel
          HelpContext = 450029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 450030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 450031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 450032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 450033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          Width = 249
          HelpContext = 450034
          ExplicitWidth = 249
        end
      end
      inherited pnlIncludehistory: TDNMPanel
        AlignWithMargins = True
        Left = 669
        Top = 3
        Height = 31
        HelpContext = 450057
        ExplicitLeft = 669
        ExplicitTop = 3
        ExplicitHeight = 31
        inherited chkIncludehistory: TwwCheckBox
          Top = 6
          ParentColor = True
          ExplicitTop = 6
        end
      end
      object DNMSpeedButton1: TDNMSpeedButton
        AlignWithMargins = True
        Left = 832
        Top = 3
        Width = 71
        Height = 31
        HelpContext = 450056
        Align = alRight
        Caption = 'By Period'
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
        TabOrder = 4
        AutoDisableParentOnclick = True
        OnClick = DNMSpeedButton1Click
      end
    end
    inherited Panel3: TPanel
      Width = 1016
      HelpContext = 450036
      ExplicitWidth = 1016
      DesignSize = (
        1016
        33)
      inherited lblFilter: TLabel
        Left = -6
        HelpContext = 450037
        ExplicitLeft = -6
      end
      inherited lblSearchoptions: TLabel
        Left = 214
        Top = 12
        HelpContext = 450038
        ExplicitLeft = 209
        ExplicitTop = 12
      end
      inherited lblSearchMode: TLabel
        Left = 523
        Top = 10
        ExplicitLeft = 512
        ExplicitTop = 10
      end
      object lblREfreshInfo: TLabel [3]
        Left = 173
        Top = 1
        Width = 191
        Height = 31
        HelpContext = 450053
        Align = alRight
        Alignment = taCenter
        Caption = 'Please Select Refresh Button to Apply the Selection Criteria'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
        WordWrap = True
        ExplicitHeight = 32
      end
      inherited cboFilter: TComboBox
        Left = 100
        Top = 8
        Width = 136
        HelpContext = 450039
        ExplicitLeft = 100
        ExplicitTop = 8
        ExplicitWidth = 136
      end
      inherited edtSearch: TEdit
        Left = 376
        Top = 8
        Width = 138
        HelpContext = 450040
        ExplicitLeft = 376
        ExplicitTop = 8
        ExplicitWidth = 138
      end
      inherited grpView: TwwRadioGroup
        Left = 598
        ExplicitLeft = 598
      end
      inherited pnlSearchbuttons: TDNMPanel
        Left = 245
        HelpContext = 450064
        TabOrder = 7
        ExplicitLeft = 245
      end
      object rgSummary: TwwRadioGroup [9]
        Left = 762
        Top = 1
        Width = 160
        Height = 31
        HelpContext = 450058
        DisableThemes = False
        ItemIndex = 0
        ShowGroupCaption = False
        Align = alRight
        Columns = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Items.Strings = (
          'Detail'
          'Summary')
        ParentFont = False
        TabOrder = 6
        OnClick = rgSummaryClick
      end
      inherited btnEditCahrt: TDNMSpeedButton
        Left = 367
        ExplicitLeft = 367
      end
      inherited btnShowMultiSelectSelectionList: TDNMSpeedButton
        Left = 460
        ExplicitLeft = 460
      end
      object btnCashPnl: TDNMSpeedButton
        AlignWithMargins = True
        Left = 925
        Top = 4
        Width = 87
        Height = 25
        HelpContext = 450059
        Align = alRight
        Caption = 'Cash P n L'
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
        AutoDisableParentOnclick = True
        OnClick = btnCashPnlClick
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      Left = 826
      Height = 23
      HelpContext = 450041
      TabOrder = 4
      ExplicitLeft = 826
      ExplicitHeight = 23
    end
    inherited dtTo: TwwDBDateTimePicker
      Left = 926
      Height = 23
      HelpContext = 450042
      TabOrder = 5
      ExplicitLeft = 926
      ExplicitHeight = 23
    end
    inherited chkIgnoreDates: TCheckBox
      Left = 758
      ExplicitLeft = 758
    end
    inherited btndec: TDNMSpeedButton
      Left = 72
      Top = 31
      Visible = False
      ExplicitLeft = 72
      ExplicitTop = 31
    end
    inherited btninc: TDNMSpeedButton
      Left = 33
      Top = 30
      Visible = False
      ExplicitLeft = 33
      ExplicitTop = 30
    end
  end
  inherited Panel1: TPanel
    Width = 1016
    HelpContext = 450049
    ExplicitWidth = 1016
    inherited lblDateComments: TLabel
      Top = 307
      Width = 1016
      ExplicitTop = 307
    end
    object lblMsg: TLabel [1]
      Left = 0
      Top = 290
      Width = 1016
      Height = 17
      HelpContext = 450060
      Align = alBottom
      Alignment = taCenter
      AutoSize = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
      WordWrap = True
      ExplicitTop = 15
      ExplicitWidth = 993
    end
    inherited lblTimerMsg: TLabel
      Top = 323
      Width = 1016
      ExplicitTop = 323
    end
    inherited splMultiSelectList: TSplitter
      Left = 753
      Height = 121
      HelpContext = 450061
      ExplicitLeft = 987
      ExplicitHeight = 100
    end
    inherited grdMain: TwwDBGrid
      Width = 753
      Height = 121
      HelpContext = 450050
      ControlType.Strings = (
        'HideTotal;CheckBox;True;False')
      PictureMasks.Strings = (
        'AmountColumnEx1'#9'$#'#9'T'#9'T')
      Selected.Strings = (
        'AccountID'#9'15'#9'Account ID'#9'F'#9
        'AccountType'#9'10'#9'Typezzz'#9'F'#9
        'AccountNo'#9'20'#9'Account No'#9'F'#9
        'AccountName'#9'20'#9'Account Name'#9'F'#9
        'FinalOrder'#9'15'#9'Final Order'#9'F'#9
        'AccountHeaderOrder'#9'15'#9'Account Header Order'#9'F'#9
        'AccountSub1Order'#9'15'#9'Account Sub1 Order'#9'F'#9
        'AccountSub2Order'#9'15'#9'Account Sub2 Order'#9'F'#9
        'AccountSub3Order'#9'15'#9'Account Sub3 Order'#9'F'#9
        'SubTotalInc'#9'10'#9'SubTotalInc'#9'F'#9
        'SubTotalEx'#9'10'#9'SubTotalEx'#9'F'#9
        'HideTotal'#9'1'#9'Hide Total'#9'F'#9
        'Account Type'#9'255'#9'Account Type'#9'F'#9
        'Seqno'#9'15'#9'Seqno'#9'F'#9)
      TitleColor = 15199967
      FixedCols = 3
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgFixedResizable, dgRowResize]
      TitleButtons = False
      ExplicitWidth = 753
      ExplicitHeight = 121
    end
    inherited mem_Note: TMemo
      Width = 1016
      Lines.Strings = (
        '1.  Property to set for Fixed filter    : FilterString'
        '2.  For totals in the Grid Footer      : '
        
          '                           In formcreate after inherited : AddCa' +
          'lcColumn'
        '(Fieldname,iscurrency);'
        
          '                           Override '#39'RefreshTotals'#39'  and Call  '#39 +
          'CalcnShowFooter'#39
        
          '                           for extra calculation -> CalcFooter (' +
          ' called inside the loop of  '
        'qrymain)'
        
          '3. In Formcreate after inherited : init fbSaveIndexFieldNames fo' +
          'r saving the Grid '
        'sortorder'
        ''
        '                                                       ')
      ExplicitWidth = 1016
    end
    inherited pnlMultiSelectList: TDNMPanel
      Left = 755
      Height = 121
      HelpContext = 450062
      ExplicitLeft = 755
      ExplicitHeight = 121
      inherited lblMultiSelectList: TLabel
        Width = 253
      end
      inherited chkhideMultiSelectSelectionList: TCheckBox
        Top = 102
        ExplicitTop = 102
      end
    end
  end
  inherited FooterPanel: TDNMPanel
    Width = 1016
    HelpContext = 450065
    Color = 15199967
    ExplicitWidth = 1016
    DesignSize = (
      1016
      80)
    inherited Label3: TLabel
      Top = 42
      ExplicitTop = 42
    end
    inherited lblTotal: TLabel
      Left = 79
      Top = 41
      Width = 7
      Height = 16
      HelpContext = 450054
      Alignment = taLeftJustify
      AutoSize = True
      ExplicitLeft = 79
      ExplicitTop = 41
      ExplicitWidth = 7
      ExplicitHeight = 16
    end
    inherited lblNote: TLabel
      Left = -94
      ExplicitLeft = -94
    end
    inherited lblTimeLabel: TLabel
      Left = 729
      ExplicitLeft = 906
    end
    inherited lblTime: TLabel
      Left = 811
      ExplicitLeft = 1001
    end
    inherited btnCustomize: TDNMSpeedButton
      Left = 83
      ExplicitLeft = 83
    end
    inherited cmdExport: TDNMSpeedButton
      Left = 353
      ExplicitLeft = 353
    end
    inherited cmdNew: TDNMSpeedButton
      Left = 498
      Top = 30
      Enabled = False
      ExplicitLeft = 498
      ExplicitTop = 30
    end
    inherited cmdPrint: TDNMSpeedButton
      Left = 638
      ExplicitLeft = 638
    end
    inherited cmdClose: TDNMSpeedButton
      Left = 810
      ExplicitLeft = 810
    end
    inherited pnlAdvPrinting: TDNMPanel
      Left = 377
      HelpContext = 450066
      TabOrder = 7
      ExplicitLeft = 377
    end
    inherited chkAdvancedPrinting: TCheckBox
      Left = 1
      Top = 21
      Checked = True
      State = cbChecked
      TabOrder = 5
      ExplicitLeft = 1
      ExplicitTop = 21
    end
    inherited barStatus: TAdvOfficeStatusBar
      Width = 1016
      Panels = <
        item
          AppearanceStyle = psLight
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
          Style = psText
          Text = 'Current Filter'
          TimeFormat = 'hh:mm:ss'
          Width = 80
          OfficeHint.Picture.Data = {}
        end
        item
          AppearanceStyle = psLight
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
          Style = psText
          TimeFormat = 'hh:mm:ss'
          Width = 700
          OfficeHint.Picture.Data = {}
        end
        item
          AppearanceStyle = psLight
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
          Style = psOwnerDraw
          TimeFormat = 'hh:mm:ss'
          Width = 50
          OfficeHint.Picture.Data = {}
        end>
      ExplicitWidth = 1016
    end
    inherited chkShowEmailOptions: TCheckBox
      Left = 922
      TabOrder = 10
      ExplicitLeft = 922
    end
    object cbkFreezeAccountname: TCheckBox
      Left = 1
      Top = 1
      Width = 153
      Height = 18
      HelpContext = 450055
      Anchors = [akLeft, akBottom]
      Caption = 'Lock Account Name'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 8
      OnClick = cbkFreezeAccountnameClick
    end
    object chkShowAllAccounts: TCheckBox
      Left = 859
      Top = 1
      Width = 153
      Height = 18
      HelpContext = 450063
      Anchors = [akTop, akRight]
      BiDiMode = bdRightToLeft
      Caption = 'Show All Accounts'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
      State = cbChecked
      TabOrder = 9
      OnClick = chkShowAllAccountsClick
    end
    object btnPnlCustom: TDNMSpeedButton
      AlignWithMargins = True
      Left = 213
      Top = 30
      Width = 98
      Height = 27
      HelpContext = 450035
      Anchors = [akBottom]
      Caption = 'Custom Layout'
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
      TabOrder = 11
      Visible = False
      WordWrap = True
      AutoDisableParentOnclick = True
      OnClick = btnPnlCustomClick
    end
    object DNMSpeedButton2: TDNMSpeedButton
      AlignWithMargins = True
      Left = 273
      Top = 30
      Width = 98
      Height = 27
      HelpContext = 450035
      Anchors = [akBottom]
      Caption = 'Custom Layout'
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
      TabOrder = 12
      WordWrap = True
      AutoDisableParentOnclick = True
      OnClick = DNMSpeedButton2Click
    end
  end
  inherited imgPopup: TImageList
    Left = 614
    Bitmap = {
      494C010108003401E40210001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007F7F7F000000000000000000000000007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      FF000000FF000000FF0000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000BFBFBF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000000000FFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      FF000000FF000000FF0000000000FFFFFF00000000000000000000FFFF000000
      00000000000000FFFF0000000000000000000000000000FFFF00000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000000000FFFF0000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      FF000000FF000000FF0000000000FFFFFF0000000000000000000000000000FF
      FF0000FFFF0000FFFF000000000000FFFF000000000000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000000000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000FFFFFF0000000000000000000000000000FF
      FF0000FFFF0000FFFF0000000000FFFFFF000000000000FFFF0000FFFF0000FF
      FF0000000000000000000000000000000000000000007F7F7F000000FF000000
      FF000000FF000000FF000000FF000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF007F7F7F0000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000FFFF0000FF
      FF0000FFFF0000000000FFFFFF007F7F7F00FFFFFF000000000000FFFF0000FF
      FF0000FFFF0000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00000000000000000000FFFF0000FF
      FF0000000000FFFFFF0000FFFF007F7F7F0000FFFF00FFFFFF000000000000FF
      FF0000FFFF0000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      00000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      00000000000000000000FFFFFF00FFFFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000FFFF00FFFFFF007F7F7F00FFFFFF0000FFFF000000000000FF
      FF0000FFFF0000FFFF0000FFFF000000000000000000000000000000FF000000
      FF000000FF000000FF000000000000FF000000000000FF000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      00000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000FFFFFF00000000000000000000FFFF0000FF
      FF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000000000FF
      FF0000FFFF00000000000000000000000000000000007F7F7F000000FF000000
      FF000000FF000000000000FF000000FF000000FF000000000000FF000000FF00
      0000FF0000007F7F7F0000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      00000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      000000000000FFFF000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF0000000000FFFFFF0000FFFF00FFFFFF000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      FF000000000000FF000000FF000000FF000000FF000000FF000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF0000FFFF0000000000000000000000000000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      0000FFFF0000FFFF000000000000FFFF00000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000FF000000FF000000FF000000FF000000FF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFF00000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00000000000000000000FFFF000000
      00000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000007F7F7F000000000000000000000000007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF00000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F000000000000000000000000007F7F7F000000000000FFFF007F7F7F000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000800000008000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F00000000000000000000FFFF000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF000000000000000000000000000000000000000000000000007F7F7F00FFFF
      FF00BFBFBF00FFFFFF00BFBFBF00FFFFFF007F7F7F0000000000000000000000
      000000000000000000000000000000000000000000007F7F7F000000FF000000
      FF0000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      8000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000007F7F7F007F7F7F00FFFFFF00BFBF
      BF00FFFFFF000000FF00FFFFFF00BFBFBF00FFFFFF007F7F7F007F7F7F000000
      0000000000000000000000000000000000007F7F7F000000FF00000000000000
      00000000000000000000000000000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      0000008080000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF0000000000000000000000000000000000000000007F7F7F00BFBFBF00FFFF
      FF00BFBFBF000000FF00BFBFBF00FFFFFF00BFBFBF007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000000000FF
      FF00000000000080800000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      000000000000000000000000000000000000000000007F7F7F00FFFFFF000000
      FF000000FF000000FF000000FF000000FF00FFFFFF007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      000000FFFF000000000000808000000000000000000000000000000000000000
      00000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      000000000000000000000000000000000000000000007F7F7F00BFBFBF00FFFF
      FF00BFBFBF000000FF00BFBFBF00FFFFFF00BFBFBF007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF000000000000FFFF0000808000008080000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000007F7F7F007F7F7F00FFFFFF00BFBF
      BF00FFFFFF000000FF00FFFFFF00BFBFBF00FFFFFF007F7F7F007F7F7F000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF00008080000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      00000000000000000000000000000000000000000000000000007F7F7F00FFFF
      FF00BFBFBF00FFFFFF00BFBFBF00FFFFFF007F7F7F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F000000000000000000000000007F7F7F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FDFF8000FEFFFFFFF8FF8000FC7FF83F
      F8FFC000FC7F1010F87FE000D837E00FF81FF000E00FC007F80FF800E00F8003
      F00FFC00C0078003E00F0600C0078003E00F070000018003E00F0180C0078003
      F01F0180C007C007F00F0060E00FE00FF00FC060E00F3018F007C060D837F83F
      F007F044FEFFFFFFF007F07EFEFFFFFFFFFDFFFF847FE00FFFF8FFFF00EFE00F
      FFF1F9FF31BFE00FFFE3F0FF39FFF00FFFC7F0FF993FF00FE08FE07FCA1FF80F
      C01FC07FF40FF007803F843F9C07F007001F1E3F9603F007001FFE1FCB01F00F
      001FFF1FFF80F01F001FFF8FF7C0F81F001FFFC7FFE0FE1F803FFFE3EFF0FF1F
      C07FFFF8FFF8FF1FE0FFFFFFFFFCFFBF00000000000000000000000000000000
      000000000000}
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'SELECT '
      '0 as AccountID,'
      'Space(255) as AccountType,'
      'Space(50) as AccountNo,'
      'Space(255) as AccountName,'
      '5 As FinalOrder,'
      'Space(255) as AccountHeaderOrder,'
      'Space(255) as AccountSub1Order,'
      'Space(255) as AccountSub2Order,'
      'Space(255) as AccountSub3Order,'
      '"T" as HideTotal,'
      '0 AS seqno,'
      'Space(255) as "Account Type",'
      '0.0 as TotalAmountInc,'
      '0.0 as TotalAmountEx,'
      '0.0 as SubTotalInc,'
      '0.0 as SubTotalEx,'
      'Space(50) as Level1,'
      'Space(50) as Level2,'
      'Space(50) as Level3,'
      'Space(50) as Level4,'
      'Space(50) as Level5,'
      'Space(50) as Level6,'
      'Space(50) as Level7,'
      'Space(50) as Level8,'
      'Space(50) as Level9,'
      'Space(50) as Level10,'
      '0.0 as AmountColumnInc1,'
      '0.0 as AmountColumnInc2,'
      '0.0 as AmountColumnInc3,'
      '0.0 as AmountColumnInc4,'
      '0.0 as AmountColumnInc5,'
      '0.0 as AmountColumnInc6,'
      '0.0 as AmountColumnInc7,'
      '0.0 as AmountColumnInc8,'
      '0.0 as AmountColumnInc9,'
      '0.0 as AmountColumnInc10,'
      '0.0 as AmountColumnInc11,'
      '0.0 as AmountColumnInc12,'
      '0.0 as AmountColumnInc13,'
      '0.0 as AmountColumnInc14,'
      '0.0 as AmountColumnInc15,'
      '0.0 as AmountColumnInc16,'
      '0.0 as AmountColumnInc17,'
      '0.0 as AmountColumnInc18,'
      '0.0 as AmountColumnInc19,'
      '0.0 as AmountColumnInc20,'
      '0.0 as AmountColumnInc21,'
      '0.0 as AmountColumnInc22,'
      '0.0 as AmountColumnInc23,'
      '0.0 as AmountColumnInc24,'
      '0.0 as AmountColumnInc25,'
      '0.0 as AmountColumnInc26,'
      '0.0 as AmountColumnInc27,'
      '0.0 as AmountColumnInc28,'
      '0.0 as AmountColumnInc29,'
      '0.0 as AmountColumnInc30,'
      '0.0 as AmountColumnInc31,'
      '0.0 as AmountColumnInc32,'
      '0.0 as AmountColumnInc33,'
      '0.0 as AmountColumnInc34,'
      '0.0 as AmountColumnInc35,'
      '0.0 as AmountColumnInc36,'
      '0.0 as AmountColumnInc37,'
      '0.0 as AmountColumnInc38,'
      '0.0 as AmountColumnInc39,'
      '0.0 as AmountColumnInc40,'
      '0.0 as AmountColumnEx1,'
      '0.0 as AmountColumnEx2,'
      '0.0 as AmountColumnEx3,'
      '0.0 as AmountColumnEx4,'
      '0.0 as AmountColumnEx5,'
      '0.0 as AmountColumnEx6,'
      '0.0 as AmountColumnEx7,'
      '0.0 as AmountColumnEx8,'
      '0.0 as AmountColumnEx9,'
      '0.0 as AmountColumnEx10,'
      '0.0 as AmountColumnEx11,'
      '0.0 as AmountColumnEx12,'
      '0.0 as AmountColumnEx13,'
      '0.0 as AmountColumnEx14,'
      '0.0 as AmountColumnEx15,'
      '0.0 as AmountColumnEx16,'
      '0.0 as AmountColumnEx17,'
      '0.0 as AmountColumnEx18,'
      '0.0 as AmountColumnEx19,'
      '0.0 as AmountColumnEx20,'
      '0.0 as AmountColumnEx21,'
      '0.0 as AmountColumnEx22,'
      '0.0 as AmountColumnEx23,'
      '0.0 as AmountColumnEx24,'
      '0.0 as AmountColumnEx25,'
      '0.0 as AmountColumnEx26,'
      '0.0 as AmountColumnEx27,'
      '0.0 as AmountColumnEx28,'
      '0.0 as AmountColumnEx29,'
      '0.0 as AmountColumnEx30,'
      '0.0 as AmountColumnEx31,'
      '0.0 as AmountColumnEx32,'
      '0.0 as AmountColumnEx33,'
      '0.0 as AmountColumnEx34,'
      '0.0 as AmountColumnEx35,'
      '0.0 as AmountColumnEx36,'
      '0.0 as AmountColumnEx37,'
      '0.0 as AmountColumnEx38,'
      '0.0 as AmountColumnEx39,'
      '0.0 as AmountColumnEx40')
    Left = 171
    Top = 320
    object qryMainAccountID: TLargeintField
      DisplayLabel = 'Account ID'
      DisplayWidth = 15
      FieldName = 'AccountID'
    end
    object qryMainAccountType: TWideStringField
      DisplayLabel = 'Typezzz'
      DisplayWidth = 10
      FieldName = 'AccountType'
      Size = 255
    end
    object qryMainAccountNo: TWideStringField
      DisplayLabel = 'Account No'
      DisplayWidth = 20
      FieldName = 'AccountNo'
      Size = 50
    end
    object qryMainAccountName: TWideStringField
      DisplayLabel = 'Account Name'
      DisplayWidth = 20
      FieldName = 'AccountName'
      Size = 255
    end
    object qryMainFinalOrder: TLargeintField
      DisplayLabel = 'Final Order'
      DisplayWidth = 15
      FieldName = 'FinalOrder'
    end
    object qryMainAccountHeaderOrder: TWideStringField
      DisplayLabel = 'Account Header Order'
      DisplayWidth = 15
      FieldName = 'AccountHeaderOrder'
      Size = 255
    end
    object qryMainAccountSub1Order: TWideStringField
      DisplayLabel = 'Account Sub1 Order'
      DisplayWidth = 15
      FieldName = 'AccountSub1Order'
      Size = 255
    end
    object qryMainAccountSub2Order: TWideStringField
      DisplayLabel = 'Account Sub2 Order'
      DisplayWidth = 15
      FieldName = 'AccountSub2Order'
      Size = 255
    end
    object qryMainAccountSub3Order: TWideStringField
      DisplayLabel = 'Account Sub3 Order'
      DisplayWidth = 15
      FieldName = 'AccountSub3Order'
      Size = 255
    end
    object qryMainSubTotalInc: TFloatField
      DisplayWidth = 10
      FieldName = 'SubTotalInc'
    end
    object qryMainSubTotalEx: TFloatField
      DisplayWidth = 10
      FieldName = 'SubTotalEx'
    end
    object qryMainHideTotal: TWideStringField
      DisplayLabel = 'Hide Total'
      DisplayWidth = 1
      FieldName = 'HideTotal'
      Size = 1
    end
    object qryMainAccountType2: TWideStringField
      DisplayWidth = 255
      FieldName = 'Account Type'
      Size = 255
    end
    object qryMainSeqno: TLargeintField
      DisplayWidth = 15
      FieldName = 'Seqno'
    end
  end
  inherited MyConnection1: TERPConnection
    Connected = True
  end
  inherited dlgSave: TSaveDialog
    Left = 432
  end
  inherited dsMain: TDataSource
    Left = 94
    Top = 319
  end
  object qryLayout: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT * FROM tblPnLLayout')
    Left = 664
    Top = 328
  end
  object qryDisplayReport: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT 0 as AccountID,'
      'Space(255) as AccountType,'
      'Space(255) as "Account Type",'
      'Space(255) as AccountName,'
      'Space(50) as Level1,'
      'Space(50) as Level2,'
      'Space(50) as Level3,'
      'Space(50) as Level4,'
      'Space(50) as Level5,'
      'Space(50) as Level6,'
      'Space(50) as Level7,'
      'Space(50) as Level8,'
      'Space(50) as Level9,'
      'Space(50) as Level10,'
      '0.0 as AmountColumnInc1,'
      '0.0 as AmountColumnInc2,'
      '0.0 as AmountColumnInc3,'
      '0.0 as AmountColumnInc4,'
      '0.0 as AmountColumnInc5,'
      '0.0 as AmountColumnInc6,'
      '0.0 as AmountColumnInc7,'
      '0.0 as AmountColumnInc8,'
      '0.0 as AmountColumnInc9,'
      '0.0 as AmountColumnInc10,'
      '0.0 as AmountColumnInc11,'
      '0.0 as AmountColumnInc12,'
      '0.0 as AmountColumnInc13,'
      '0.0 as AmountColumnInc14,'
      '0.0 as AmountColumnInc15,'
      '0.0 as AmountColumnInc16,'
      '0.0 as AmountColumnInc17,'
      '0.0 as AmountColumnInc18,'
      '0.0 as AmountColumnInc19,'
      '0.0 as AmountColumnInc20,'
      '0.0 as AmountColumnInc21,'
      '0.0 as AmountColumnInc22,'
      '0.0 as AmountColumnInc23,'
      '0.0 as AmountColumnInc24,'
      '0.0 as AmountColumnInc25,'
      '0.0 as AmountColumnInc26,'
      '0.0 as AmountColumnInc27,'
      '0.0 as AmountColumnInc28,'
      '0.0 as AmountColumnInc29,'
      '0.0 as AmountColumnInc30,'
      '0.0 as AmountColumnInc31,'
      '0.0 as AmountColumnInc32,'
      '0.0 as AmountColumnInc33,'
      '0.0 as AmountColumnInc34,'
      '0.0 as AmountColumnInc35,'
      '0.0 as AmountColumnInc36,'
      '0.0 as AmountColumnInc37,'
      '0.0 as AmountColumnInc38,'
      '0.0 as AmountColumnInc39,'
      '0.0 as AmountColumnInc40,'
      '0.0 as AmountColumnEx1,'
      '0.0 as AmountColumnEx2,'
      '0.0 as AmountColumnEx3,'
      '0.0 as AmountColumnEx4,'
      '0.0 as AmountColumnEx5,'
      '0.0 as AmountColumnEx6,'
      '0.0 as AmountColumnEx7,'
      '0.0 as AmountColumnEx8,'
      '0.0 as AmountColumnEx9,'
      '0.0 as AmountColumnEx10,'
      '0.0 as AmountColumnEx11,'
      '0.0 as AmountColumnEx12,'
      '0.0 as AmountColumnEx13,'
      '0.0 as AmountColumnEx14,'
      '0.0 as AmountColumnEx15,'
      '0.0 as AmountColumnEx16,'
      '0.0 as AmountColumnEx17,'
      '0.0 as AmountColumnEx18,'
      '0.0 as AmountColumnEx19,'
      '0.0 as AmountColumnEx20,'
      '0.0 as AmountColumnEx21,'
      '0.0 as AmountColumnEx22,'
      '0.0 as AmountColumnEx23,'
      '0.0 as AmountColumnEx24,'
      '0.0 as AmountColumnEx25,'
      '0.0 as AmountColumnEx26,'
      '0.0 as AmountColumnEx27,'
      '0.0 as AmountColumnEx28,'
      '0.0 as AmountColumnEx29,'
      '0.0 as AmountColumnEx30,'
      '0.0 as AmountColumnEx31,'
      '0.0 as AmountColumnEx32,'
      '0.0 as AmountColumnEx33,'
      '0.0 as AmountColumnEx34,'
      '0.0 as AmountColumnEx35,'
      '0.0 as AmountColumnEx36,'
      '0.0 as AmountColumnEx37,'
      '0.0 as AmountColumnEx38,'
      '0.0 as AmountColumnEx39,'
      '0.0 as AmountColumnEx40,'
      '0.0 as TotalAmountInc,'
      '0.0 as TotalAmountEx,'
      '0.0 as SubTotalInc,'
      '0.0 as SubTotalEx,'
      '5 As FinalOrder,'
      'Space(255) as AccountHeaderOrder,'
      'Space(255) as AccountSub1Order,'
      'Space(255) as AccountSub2Order,'
      'Space(255) as AccountSub3Order,'
      '"T" as HideTotal')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    BeforeOpen = qryMainBeforeOpen
    AfterOpen = qryMainAfterOpen
    AfterScroll = qryMainAfterScroll
    Left = 291
    Top = 328
    object qryDisplayReportAccountID: TLargeintField
      DisplayLabel = 'Account ID'
      DisplayWidth = 15
      FieldName = 'AccountID'
    end
    object qryDisplayReportAccountType: TWideStringField
      DisplayLabel = 'Type'
      DisplayWidth = 10
      FieldName = 'AccountType'
      Size = 255
    end
    object qryDisplayReportAccountType2: TWideStringField
      DisplayWidth = 20
      FieldName = 'Account Type'
      Size = 255
    end
    object qryDisplayReportAccountNo: TWideStringField
      DisplayLabel = 'Account No'
      DisplayWidth = 20
      FieldName = 'AccountNo'
      Size = 50
    end
    object qryDisplayReportAccountName: TWideStringField
      DisplayLabel = 'Account Name'
      DisplayWidth = 20
      FieldName = 'AccountName'
      Size = 255
    end
    object qryDisplayReportFinalOrder: TLargeintField
      DisplayLabel = 'Final Order'
      DisplayWidth = 15
      FieldName = 'FinalOrder'
    end
    object qryDisplayReportAccountHeaderOrder: TWideStringField
      DisplayLabel = 'Account Header Order'
      DisplayWidth = 15
      FieldName = 'AccountHeaderOrder'
      Size = 255
    end
    object qryDisplayReportAccountSub1Order: TWideStringField
      DisplayLabel = 'Account Sub1 Order'
      DisplayWidth = 15
      FieldName = 'AccountSub1Order'
      Size = 255
    end
    object qryDisplayReportAccountSub2Order: TWideStringField
      DisplayLabel = 'Account Sub2 Order'
      DisplayWidth = 15
      FieldName = 'AccountSub2Order'
      Size = 255
    end
    object qryDisplayReportAccountSub3Order: TWideStringField
      DisplayLabel = 'Account Sub3 Order'
      DisplayWidth = 15
      FieldName = 'AccountSub3Order'
      Size = 255
    end
    object qryDisplayReportSubTotalInc: TFloatField
      DisplayWidth = 10
      FieldName = 'SubTotalInc'
    end
    object qryDisplayReportSubTotalEx: TFloatField
      DisplayWidth = 10
      FieldName = 'SubTotalEx'
    end
    object qryDisplayReportHideTotal: TWideStringField
      DisplayLabel = 'Hide Total'
      DisplayWidth = 1
      FieldName = 'HideTotal'
      Size = 1
    end
    object qryDisplayReportSeqno: TLargeintField
      DisplayWidth = 15
      FieldName = 'Seqno'
    end
  end
  object qrySaveReport: TERPQuery
    Connection = MyConnection1
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    BeforeOpen = qryMainBeforeOpen
    AfterOpen = qryMainAfterOpen
    AfterScroll = qryMainAfterScroll
    Left = 131
    Top = 464
  end
  object dsDisplayReport: TDataSource
    DataSet = qryDisplayReport
    Left = 262
    Top = 455
  end
  object qryIndex: TERPQuery
    Connection = MyConnection1
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    BeforeOpen = qryMainBeforeOpen
    AfterOpen = qryMainAfterOpen
    AfterScroll = qryMainAfterScroll
    Left = 395
    Top = 328
  end
  object qryUpdateTotal: TERPQuery
    Connection = MyConnection1
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    BeforeOpen = qryMainBeforeOpen
    AfterOpen = qryMainAfterOpen
    AfterScroll = qryMainAfterScroll
    Left = 475
    Top = 336
  end
  object qryDeleteTotals: TERPQuery
    Connection = MyConnection1
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    BeforeOpen = qryMainBeforeOpen
    AfterOpen = qryMainAfterOpen
    AfterScroll = qryMainAfterScroll
    Left = 563
    Top = 328
  end
end
