inherited frmPaySummary: TfrmPaySummary
  Left = 443
  Top = 439
  HelpContext = 323000
  Caption = 'Pay Summary'
  ClientWidth = 1004
  OldCreateOrder = True
  ExplicitLeft = 443
  ExplicitTop = 439
  ExplicitWidth = 1020
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 460
    Width = 1004
    HelpContext = 323056
    ExplicitTop = 463
    ExplicitWidth = 1004
  end
  inherited FilterLabel: TLabel
    Top = 460
    Width = 1004
    HelpContext = 323001
    ExplicitTop = 460
  end
  inherited pnlGraph: TDNMPanel
    Width = 1004
    Height = 331
    HelpContext = 323057
    ExplicitWidth = 1004
    ExplicitHeight = 331
  end
  inherited HeaderPanel: TPanel
    Width = 1004
    HelpContext = 323030
    Color = 15785701
    ExplicitWidth = 1004
    DesignSize = (
      1004
      129)
    inherited lblFrom: TLabel
      Left = 779
      HelpContext = 323031
      Visible = False
      ExplicitLeft = 779
    end
    inherited lblTo: TLabel
      Left = 902
      HelpContext = 323032
      Visible = False
      ExplicitLeft = 902
    end
    inherited imgReportTablesMsg: TImage
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
    end
    inherited cboDateRange: TComboBox
      Left = 815
      HelpContext = 323053
      ExplicitLeft = 815
    end
    inherited pnlHeader: TPanel
      Top = 7
      Width = 478
      HelpContext = 323033
      Font.Color = 14221420
      ExplicitTop = 7
      ExplicitWidth = 478
      inherited TitleShader: TShader
        Width = 476
        HelpContext = 323034
        TabOrder = 1
        ExplicitWidth = 476
        inherited TitleLabel: TLabel
          Width = 476
          HelpContext = 323035
          Caption = 'Pay Summary'
          ExplicitWidth = 554
        end
      end
      object btnClearAll: TDNMSpeedButton
        Left = 389
        Top = 15
        Width = 75
        Height = 25
        HelpContext = 323036
        Caption = 'Clear All'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 14221420
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ParentFont = False
        TabOrder = 0
        AutoDisableParentOnclick = True
        OnClick = btnClearAllClick
      end
    end
    inherited Panel2: TPanel
      Width = 1004
      HelpContext = 323037
      ExplicitWidth = 1004
      inherited grpFilters: TwwRadioGroup
        Width = 394
        HelpContext = 323038
        ItemIndex = 0
        Items.Strings = (
          'Pay'
          'Do Not Pay'
          'All Pays')
        ExplicitWidth = 394
      end
      inherited pnlButtons: TPanel
        HelpContext = 323039
        inherited lblcustomReport: TLabel
          HelpContext = 323040
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 323041
        end
        inherited btnExecute: TDNMSpeedButton
          Left = 111
          Top = 7
          HelpContext = 323042
          ExplicitLeft = 111
          ExplicitTop = 7
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 323043
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 323044
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 323045
        end
      end
      inherited pnlIncludehistory: TDNMPanel
        Left = 847
        HelpContext = 323058
        ExplicitLeft = 847
      end
    end
    inherited Panel3: TPanel
      Width = 1004
      HelpContext = 323046
      ExplicitWidth = 1004
      DesignSize = (
        1004
        33)
      inherited lblFilter: TLabel
        Left = 2
        HelpContext = 323047
        ExplicitLeft = 2
      end
      inherited lblSearchoptions: TLabel
        Left = 283
        HelpContext = 323048
        ExplicitLeft = 283
      end
      inherited lblSearchMode: TLabel
        Left = 588
        ExplicitLeft = 588
      end
      inherited cboFilter: TComboBox
        Left = 94
        HelpContext = 323049
        ExplicitLeft = 94
      end
      inherited edtSearch: TEdit
        Left = 443
        HelpContext = 323050
        OnEnter = edtSearchEnter
        ExplicitLeft = 443
      end
      inherited grpView: TwwRadioGroup
        Left = 839
        ExplicitLeft = 839
      end
      inherited btnEditCahrt: TDNMSpeedButton
        Left = 749
        ExplicitLeft = 749
      end
      inherited btnShowMultiSelectSelectionList: TDNMSpeedButton
        Left = 608
        ExplicitLeft = 608
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      Left = 815
      Height = 22
      HelpContext = 323051
      Visible = False
      ExplicitLeft = 815
      ExplicitHeight = 22
    end
    inherited dtTo: TwwDBDateTimePicker
      Left = 919
      Height = 22
      HelpContext = 323052
      Visible = False
      ExplicitLeft = 919
      ExplicitHeight = 22
    end
    inherited chkIgnoreDates: TCheckBox
      Left = 747
      ExplicitLeft = 747
    end
  end
  inherited Panel1: TPanel
    Width = 1004
    Height = 331
    HelpContext = 323054
    ExplicitWidth = 1004
    ExplicitHeight = 331
    inherited lblDateComments: TLabel
      Top = 315
      Width = 1004
      HelpContext = 323059
      ExplicitTop = 315
    end
    inherited lblTimerMsg: TLabel
      Top = 299
      Width = 1004
      HelpContext = 323060
      ExplicitTop = 299
    end
    inherited splMultiSelectList: TSplitter
      Left = 741
      Height = 130
      HelpContext = 323061
      ExplicitLeft = 741
      ExplicitHeight = 132
    end
    inherited grdMain: TwwDBGrid
      Width = 741
      Height = 130
      HelpContext = 323055
      ControlType.Strings = (
        'Pay;CustomEdit;chkPay;F'
        'Paid;CustomEdit;chkPaid;F'
        'DatePaid;CustomEdit;cboDatePaid;F'
        'ExtraDetails;CustomEdit;wwExpandButton2;F'
        'Prepared;CheckBox;T;F')
      Selected.Strings = (
        'EmpName'#9'50'#9'Employee Name'#9'T'
        'PayDate'#9'10'#9'PayDate'#9'T'
        'DatePaid'#9'10'#9'LastPaid'#9'T'
        'PayPeriod'#9'11'#9'Period'#9'T'
        'Wages'#9'10'#9'Wages'#9'T'
        'Commission'#9'10'#9'Commission'#9'T'
        'Deductions'#9'10'#9'Deductions'#9'T'
        'Allowances'#9'10'#9'Allowances'#9'T'
        'Sundries'#9'10'#9'Sundries'#9'T'
        'Superannuation'#9'10'#9'Superannuation'#9'T'
        'CDEPGross'#9'10'#9'CDEP'#9'T'
        'Gross'#9'10'#9'Gross'#9'T'
        'ExtraDetails'#9'12'#9'Extra Details'#9'T'
        'Tax'#9'10'#9'Tax'#9'T'
        'Net'#9'10'#9'Net'#9'T'
        'Paid'#9'1'#9'Paid'#9'T'
        'Pay'#9'6'#9'Pay'#9#9
        'Class'#9'128'#9'Class'#9'T'
        'PayPeriods'#9'10'#9'Pay Periods'#9'T'
        'EmployeeNo'#9'10'#9'EmployeeNo'#9'T'
        'FirstName'#9'40'#9'FirstName'#9'T'
        'LastName'#9'40'#9'LastName'#9'T'
        'Email'#9'80'#9'Email'#9'T'
        'SendPaySlipViaEmail'#9'1'#9'SendPaySlipViaEmail'#9'T'
        'LastPaid'#9'10'#9'LastPaid'#9'T'
        'Prepared'#9'1'#9'Prepared'#9'T')
      TitleColor = clWhite
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgShowFooter, dgRowResize]
      TitleAlignment = taCenter
      OnCalcTitleAttributes = grdMainCalcTitleAttributes
      OnExit = grdMainExit
      OnCheckValue = grdMainCheckValue
      FooterColor = 15785701
      ExplicitWidth = 741
      ExplicitHeight = 130
    end
    inherited mem_Note: TMemo
      Width = 1004
      HelpContext = 323062
      TabOrder = 6
      ExplicitWidth = 1004
    end
    inherited pnlMultiSelectList: TDNMPanel
      Left = 743
      Height = 130
      HelpContext = 323063
      TabOrder = 7
      ExplicitLeft = 743
      ExplicitHeight = 130
      inherited chkhideMultiSelectSelectionList: TCheckBox
        Top = 111
        ExplicitTop = 111
      end
    end
    object chkPaid: TwwCheckBox
      Left = 458
      Top = 160
      Width = 14
      Height = 15
      HelpContext = 323064
      DisableThemes = False
      AlwaysTransparent = False
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      DynamicCaption = True
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'Yes'
      DisplayValueUnchecked = 'No'
      NullAndBlankState = cbUnchecked
      Caption = 'No'
      Color = clWhite
      DataField = 'Paid'
      ParentColor = False
      TabOrder = 1
    end
    object chkPay: TwwCheckBox
      Left = 398
      Top = 160
      Width = 15
      Height = 14
      HelpContext = 323065
      DisableThemes = False
      AlwaysTransparent = False
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      DynamicCaption = True
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'Yes'
      DisplayValueUnchecked = 'No'
      NullAndBlankState = cbUnchecked
      Caption = 'No'
      Color = clWhite
      DataField = 'Pay'
      DataSource = dsMain
      ParentColor = False
      TabOrder = 2
      OnClick = chkPayClick
      OnExit = chkPayExit
    end
    object cboDatePaid: TwwDBDateTimePicker
      Left = 95
      Top = 31
      Width = 105
      Height = 23
      HelpContext = 323066
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'DatePaid'
      DataSource = dsMain
      Epoch = 1950
      ButtonWidth = -1
      ShowButton = True
      TabOrder = 3
      UnboundDataType = wwDTEdtDate
    end
    object wwExpandButton2: TwwExpandButton
      Left = 297
      Top = 27
      Width = 70
      Height = 12
      HelpContext = 323067
      DisableThemes = False
      Grid = grdExtraDetails
      OnBeforeExpand = wwExpandButton2BeforeExpand
      Caption = 'wwExpandButton2'
      Color = clWhite
      DataField = 'ExtraDetails'
      DataSource = dsMain
      ParentColor = False
      ShowAsButton = True
      TabOrder = 4
      ButtonAlignment = taCenter
    end
    object grdExtraDetails: TwwDBGrid
      Left = 311
      Top = 224
      Width = 475
      Height = 177
      HelpContext = 323068
      Selected.Strings = (
        'description'#9'15'#9'Description'#9'F'#9
        'leaveloading'#9'5'#9'Loading %'#9'F'#9
        'Amount'#9'8'#9'Rate'#9'F'#9
        'Qty'#9'8'#9'Qty'#9'F'#9
        'LineTotal'#9'10'#9'Line Total'#9'F'#9
        'SuperInc'#9'1'#9'Super Inc'#9'F'#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = True
      Ctl3D = False
      DataSource = DSPayExtraDetails
      KeyOptions = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
      ParentCtl3D = False
      TabOrder = 5
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      Visible = False
    end
  end
  inherited FooterPanel: TDNMPanel
    Top = 475
    Width = 1004
    Height = 88
    HelpContext = 323002
    Color = 15785701
    Font.Color = 15785701
    ExplicitTop = 475
    ExplicitWidth = 1004
    ExplicitHeight = 88
    DesignSize = (
      1004
      88)
    object Bevel1: TBevel [0]
      Left = 409
      Top = 15
      Width = 130
      Height = 20
      HelpContext = 323020
      Anchors = [akLeft, akBottom]
    end
    inherited Label3: TLabel
      Top = 43
      HelpContext = 323003
      Visible = False
      ExplicitTop = 43
    end
    inherited lblTotal: TLabel
      Visible = False
    end
    inherited lblNote: TLabel
      Left = 398
      Top = 0
      Height = 15
      HelpContext = 323005
      Visible = False
      ExplicitLeft = 393
      ExplicitTop = 0
      ExplicitHeight = 15
    end
    inherited lblTimeLabel: TLabel
      Left = 720
      Top = 17
      HelpContext = 323006
      ExplicitLeft = 715
      ExplicitTop = 17
    end
    object Label4: TLabel [5]
      Left = 437
      Top = 18
      Width = 99
      Height = 14
      HelpContext = 323021
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'Preview Payslips'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    inherited lblTime: TLabel
      Left = 801
      Top = 17
      HelpContext = 323007
      ExplicitLeft = 801
      ExplicitTop = 17
    end
    object chkPreviewPaySlips: TCheckBox [7]
      Left = 418
      Top = 19
      Width = 13
      Height = 15
      HelpContext = 323022
      Anchors = [akLeft, akBottom]
      TabOrder = 14
    end
    inherited cmdExport: TDNMSpeedButton [8]
      Left = 357
      Top = 40
      HelpContext = 323011
      TabOrder = 1
      ExplicitLeft = 357
      ExplicitTop = 40
    end
    inherited cmdNew: TDNMSpeedButton [9]
      Left = 236
      Top = 8
      HelpContext = 323009
      TabOrder = 0
      Visible = False
      ExplicitLeft = 236
      ExplicitTop = 8
    end
    inherited cmdPrint: TDNMSpeedButton [10]
      Left = 702
      Top = 40
      HelpContext = 323010
      TabOrder = 4
      ExplicitLeft = 702
      ExplicitTop = 40
    end
    inherited barStatus: TAdvOfficeStatusBar [11]
      Top = 71
      Width = 1004
      HelpContext = 323019
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
      ExplicitTop = 71
      ExplicitWidth = 1004
    end
    object btnPayStaff: TDNMSpeedButton [12]
      Left = 472
      Top = 38
      Width = 87
      Height = 27
      Hint = 'Process Pays'
      HelpContext = 323023
      Anchors = [akBottom]
      Caption = 'Pa&y Staff'
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnPayStaffClick
    end
    object btnLoadRoster: TDNMSpeedButton [13]
      Left = 669
      Top = -8
      Width = 92
      Height = 27
      Hint = '"Load Hours for this Pay from Roster"'
      HelpContext = 323024
      Anchors = [akBottom]
      Caption = '&Load Roster'
      DisableTransparent = False
      Enabled = False
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
      ModalResult = 1
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      TabStop = False
      Visible = False
      AutoDisableParentOnclick = True
    end
    object DNMPanel1: TDNMPanel [14]
      Left = 8
      Top = 36
      Width = 93
      Height = 29
      HelpContext = 323025
      Anchors = [akBottom]
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 9
      object lblEFT: TLabel
        Left = 18
        Top = 8
        Width = 66
        Height = 15
        HelpContext = 323026
        Caption = 'Add to E.F.T.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object chkAddToEft: TCheckBox
        Left = 1
        Top = 8
        Width = 14
        Height = 16
        HelpContext = 323027
        TabOrder = 0
      end
    end
    inherited cmdClose: TDNMSpeedButton
      Left = 817
      Top = 40
      TabOrder = 10
      ExplicitLeft = 817
      ExplicitTop = 40
    end
    inherited btnCustomize: TDNMSpeedButton [16]
      Left = 127
      Top = 40
      TabOrder = 11
      ExplicitLeft = 127
      ExplicitTop = 40
    end
    inherited chkAdvancedPrinting: TCheckBox
      TabOrder = 13
    end
    inherited pnlAdvPrinting: TDNMPanel [18]
      Left = 728
      Top = 7
      HelpContext = 323013
      TabOrder = 7
      ExplicitLeft = 728
      ExplicitTop = 7
      inherited LblChooseTemplate: TLabel
        HelpContext = 323014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 323015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 323016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 323017
      end
    end
    inherited chkShowEmailOptions: TCheckBox
      Left = 910
      Height = 43
      HelpContext = 323069
      ExplicitLeft = 910
      ExplicitHeight = 43
    end
    object btnLoadTimesheet: TDNMSpeedButton
      Left = 242
      Top = 40
      Width = 87
      Height = 27
      Hint = '"Load Hours for employees from the timesheet"'
      HelpContext = 323028
      Anchors = [akBottom]
      Caption = 'Load T/S&heet'
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
      ModalResult = 1
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnLoadTimesheetClick
    end
    object btnPayslipReport: TDNMSpeedButton
      Left = 585
      Top = 40
      Width = 91
      Height = 27
      Hint = 'Process Pays'
      HelpContext = 323029
      Anchors = [akBottom]
      Caption = 'Payslip &Report'
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnPayslipReportClick
    end
  end
  inherited imgPopup: TImageList
    Bitmap = {
      494C01010800E4004C0110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited CloseModalTimer: TTimer
    Left = 121
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'SELECT'
      
        'tblPays.PayID, tblPays.EmployeeID, tblPays.EmpName, tblPays.PayD' +
        'ate, '
      
        'tblPays.DatePaid, tblPays.Wages, tblPays.Commission, tblPays.Ded' +
        'uctions, '
      
        'tblPays.Allowances, tblPays.Sundries, tblPays.PayPeriods, tblPay' +
        's.Superannuation,'
      
        'tblPays.Gross, tblPays.Tax, tblPays.Net, tblPays.Paid, tblPays.P' +
        'ay, tblPays.PayPeriod, '
      'tblPays.CDEPGross, tblPays.Class,tblPays.Prepared, '
      'tblemployees.EmployeeNo,'
      'tblemployees.FirstName,tblemployees.LastName,'
      
        'tblemployees.Email,tblemployees.SendPaySlipViaEmail,tblemployees' +
        '.LastPaid'
      ''
      'FROM tblPays'
      
        'INNER JOIN tblemployees ON tblPays.EmployeeID=tblemployees.Emplo' +
        'yeeID'
      'WHERE tblPays.Paid <> '#39'T'#39' AND tblPays.Deleted = '#39'F'#39
      'AND tblPays.EmpName <> '#39#39
      'and tblemployees.Active <> '#39'F'#39
      'GROUP BY tblPays.EmployeeID'
      'ORDER BY tblPays.EmpName')
    Options.StrictUpdate = False
    Left = 115
    Top = 336
    object qryMainEmployeeName: TWideStringField
      DisplayLabel = 'Employee Name'
      DisplayWidth = 50
      FieldName = 'EmpName'
      Origin = 'tblPays.EmpName'
      ReadOnly = True
      Size = 50
    end
    object qryMainPayDate: TDateField
      DisplayWidth = 10
      FieldName = 'PayDate'
      Origin = 'tblPays.PayDate'
      ReadOnly = True
    end
    object qryMainPayPeriod: TWideStringField
      DisplayLabel = 'Period'
      DisplayWidth = 11
      FieldName = 'PayPeriod'
      Origin = 'tblPays.PayPeriod'
      ReadOnly = True
      Size = 255
    end
    object qryMainWages: TFloatField
      DisplayWidth = 10
      FieldName = 'Wages'
      Origin = 'tblPays.Wages'
      ReadOnly = True
      currency = True
    end
    object qryMainCommission: TFloatField
      DisplayWidth = 10
      FieldName = 'Commission'
      Origin = 'tblPays.Commission'
      ReadOnly = True
      currency = True
    end
    object qryMainDeductions: TFloatField
      DisplayWidth = 10
      FieldName = 'Deductions'
      Origin = 'tblPays.Deductions'
      ReadOnly = True
      currency = True
    end
    object qryMainAllowances: TFloatField
      DisplayWidth = 10
      FieldName = 'Allowances'
      Origin = 'tblPays.Allowances'
      ReadOnly = True
      currency = True
    end
    object qryMainSundries: TFloatField
      DisplayWidth = 10
      FieldName = 'Sundries'
      Origin = 'tblPays.Sundries'
      ReadOnly = True
      currency = True
    end
    object qryMainSuperannuation: TFloatField
      DisplayWidth = 10
      FieldName = 'Superannuation'
      Origin = 'tblPays.Superannuation'
      ReadOnly = True
      currency = True
    end
    object qryMainCDEPGross: TFloatField
      DisplayLabel = 'CDEP'
      DisplayWidth = 10
      FieldName = 'CDEPGross'
      Origin = 'tblPays.CDEPGross'
      ReadOnly = True
      currency = True
    end
    object qryMainGross: TFloatField
      DisplayWidth = 10
      FieldName = 'Gross'
      Origin = 'tblPays.Gross'
      ReadOnly = True
      currency = True
    end
    object qryMainExtraDetails: TWideStringField
      DisplayLabel = 'Extra Details'
      DisplayWidth = 12
      FieldKind = fkCalculated
      FieldName = 'ExtraDetails'
      Size = 255
      Calculated = True
    end
    object qryMainTax: TFloatField
      DisplayWidth = 10
      FieldName = 'Tax'
      Origin = 'tblPays.Tax'
      ReadOnly = True
      currency = True
    end
    object qryMainNet: TFloatField
      DisplayWidth = 10
      FieldName = 'Net'
      Origin = 'tblPays.Net'
      ReadOnly = True
      currency = True
    end
    object qryMainPaid: TWideStringField
      DisplayWidth = 1
      FieldName = 'Paid'
      Origin = 'tblPays.Paid'
      ReadOnly = True
      FixedChar = True
      Size = 1
    end
    object qryMainPay: TWideStringField
      DisplayWidth = 6
      FieldName = 'Pay'
      Origin = 'tblPays.Pay'
      FixedChar = True
      Size = 1
    end
    object qryMainClass: TWideStringField
      DisplayWidth = 128
      FieldName = 'Class'
      Origin = 'tblPays.Class'
      ReadOnly = True
      Size = 255
    end
    object qryMainPayPeriods: TWordField
      DisplayLabel = 'Pay Periods'
      DisplayWidth = 10
      FieldName = 'PayPeriods'
      Origin = 'tblPays.PayPeriods'
      ReadOnly = True
    end
    object qryMainEmployeeNo: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeNo'
    end
    object qryMainFirstName: TWideStringField
      DisplayWidth = 40
      FieldName = 'FirstName'
      Size = 40
    end
    object qryMainLastName: TWideStringField
      DisplayWidth = 40
      FieldName = 'LastName'
      Size = 40
    end
    object qryMainEmail: TWideStringField
      DisplayWidth = 80
      FieldName = 'Email'
      Size = 80
    end
    object qryMainSendPaySlipViaEmail: TWideStringField
      DisplayWidth = 1
      FieldName = 'SendPaySlipViaEmail'
      FixedChar = True
      Size = 1
    end
    object qryMainLastPaid: TDateField
      DisplayWidth = 10
      FieldName = 'LastPaid'
    end
    object qryMainPrepared: TWideStringField
      DisplayWidth = 1
      FieldName = 'Prepared'
      Origin = 'tblPays.Prepared'
      FixedChar = True
      Size = 1
    end
    object qryMainPayID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'PayID'
      Origin = 'tblPays.PayID'
      ReadOnly = True
      Visible = False
    end
    object qryMainEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Origin = 'tblPays.EmployeeID'
      ReadOnly = True
      Visible = False
    end
    object qryMainDatePaid: TDateTimeField
      FieldName = 'DatePaid'
    end
  end
  inherited qryPersonalPrefs: TERPQuery
    Left = 90
    Top = 32
  end
  inherited MyConnection1: TERPConnection
    Database = 'payroll_usa'
  end
  inherited dlgSave: TSaveDialog
    Left = 265
    Top = 176
  end
  object MyConnection2: TERPConnection
    Port = 3309
    Options.UseUnicode = True
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    LoginPrompt = False
    Left = 56
    Top = 64
  end
  object qryPayExtraDetails: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'Select '
      'tblpayrates.description,'
      'tblpayrates.IsLeave,'
      'tblleave.leaveloading,'
      'if(tblpayrates.IsLeave = '#39'T'#39', 1 ,0) ,'
      'PR.PayrateID,'
      'PR.PayId,'
      'PR.Amount,'
      'PR.Qty,'
      'PR.LineTotal,'
      '#PR.SuperInc,'
      'if(PR.SuperInc = '#39'T'#39','#39'Yes'#39','#39'No'#39') as SuperInc,'
      ''
      'P.PayID,'
      'P.EmployeeID'
      ''
      'FROM tblpays P'
      'inner JOIN tblpayspayrates PR on P.PayID = PR.PayID'
      'inner JOIN tblpayrates  on PR.PayrateID = tblpayrates.Rateid'
      
        'left join tblleave on ((tblleave.employeeid = P.Employeeid) and ' +
        '(tblleave.type = tblpayrates.description ))'
      'where P.PayId = :xPayID')
    Left = 520
    Top = 288
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xPayID'
      end>
    object qryPayExtraDetailsdescription: TWideStringField
      DisplayLabel = 'Description'
      DisplayWidth = 15
      FieldName = 'description'
      Size = 100
    end
    object qryPayExtraDetailsleaveloading: TFloatField
      DisplayLabel = 'Loading %'
      DisplayWidth = 5
      FieldName = 'leaveloading'
    end
    object qryPayExtraDetailsAmount: TFloatField
      DisplayLabel = 'Rate'
      DisplayWidth = 8
      FieldName = 'Amount'
      currency = True
    end
    object qryPayExtraDetailsQty: TFloatField
      DisplayWidth = 8
      FieldName = 'Qty'
    end
    object qryPayExtraDetailsLineTotal: TFloatField
      DisplayLabel = 'Line Total'
      DisplayWidth = 10
      FieldName = 'LineTotal'
      currency = True
    end
    object qryPayExtraDetailsSuperInc: TWideStringField
      DisplayLabel = 'Super Inc'
      DisplayWidth = 1
      FieldName = 'SuperInc'
      FixedChar = True
      Size = 1
    end
    object qryPayExtraDetailsiftblpayratesIsLeaveT10: TLargeintField
      DisplayWidth = 15
      FieldName = 'if(tblpayrates.IsLeave = '#39'T'#39', 1 ,0)'
      Visible = False
    end
  end
  object DSPayExtraDetails: TDataSource
    DataSet = qryPayExtraDetails
    Left = 520
    Top = 208
  end
end
