inherited PhSupportLogGUI: TPhSupportLogGUI
  Left = 279
  Top = 122
  HelpContext = 415000
  Caption = 'Support Log'
  ClientHeight = 565
  ClientWidth = 996
  OldCreateOrder = True
  OnResize = FormResize
  ExplicitLeft = 279
  ExplicitTop = 122
  ExplicitWidth = 1012
  ExplicitHeight = 604
  DesignSize = (
    996
    565)
  PixelsPerInch = 96
  TextHeight = 15
  object Cus_contact1_Label: TLabel [0]
    Left = 34
    Top = 131
    Width = 55
    Height = 16
    HelpContext = 415005
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Contact'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Bevel2: TBevel [1]
    Left = 8
    Top = 49
    Width = 980
    Height = 30
    HelpContext = 415019
  end
  object lblCompany: TDBText [2]
    Left = 116
    Top = 50
    Width = 138
    Height = 29
    HelpContext = 415020
    Alignment = taCenter
    AutoSize = True
    Color = clBtnFace
    DataField = 'Company'
    DataSource = dsLog
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = True
  end
  object Label13: TLabel [3]
    Left = 27
    Top = 50
    Width = 64
    Height = 29
    HelpContext = 415027
    Caption = 'Name'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label15: TLabel [4]
    Left = 843
    Top = 24
    Width = 52
    Height = 15
    HelpContext = 415029
    Anchors = [akTop, akRight]
    Caption = 'Global ID:'
    Transparent = True
  end
  inherited lblSkingroupMsg: TLabel
    Top = 81
    Width = 996
    HelpContext = 415072
    ExplicitTop = 563
    ExplicitWidth = 736
  end
  inherited shapehint: TShape
    Left = 20
    ExplicitLeft = 12
  end
  inherited imgGridWatermark: TImage
    Left = 622
    Top = 359
    HelpContext = 415001
    ExplicitLeft = 622
    ExplicitTop = 359
  end
  inherited shapehintextra1: TShape
    Left = 77
    ExplicitLeft = 56
  end
  object lblRep: TDBText [10]
    Left = 66
    Top = 10
    Width = 242
    Height = 29
    HelpContext = 415026
    Color = clBtnFace
    DataField = 'RepName'
    DataSource = dsClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = True
  end
  object Label14: TLabel [11]
    Left = 8
    Top = 10
    Width = 52
    Height = 29
    HelpContext = 415028
    Caption = 'Rep:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object DBEdit1: TDBEdit [12]
    Left = 899
    Top = 20
    Width = 89
    Height = 23
    HelpContext = 415058
    Anchors = [akTop, akRight]
    Color = clWhite
    DataField = 'GlobalRef'
    DataSource = dsLog
    ReadOnly = True
    TabOrder = 2
  end
  object edtContact: TwwDBEdit [13]
    Left = 411
    Top = 6
    Width = 81
    Height = 23
    HelpContext = 415060
    DataField = 'Contact'
    DataSource = dsLog
    TabOrder = 1
    UnboundDataType = wwDefault
    Visible = False
    WantReturns = False
    WordWrap = False
  end
  object pnlTitle: TDNMPanel [14]
    Left = 334
    Top = 4
    Width = 328
    Height = 39
    HelpContext = 415061
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 324
      Height = 35
      HelpContext = 415062
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
        Width = 324
        Height = 35
        HelpContext = 415063
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Support Log'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitWidth = 234
      end
    end
  end
  object PageControlMain: TPageControl [15]
    Left = 0
    Top = 81
    Width = 996
    Height = 450
    HelpContext = 415086
    ActivePage = tsDetails
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabHeight = 25
    TabOrder = 4
    OnChange = PageControlMainChange
    OnChanging = PageControlMainChanging
    object tsDetails: TTabSheet
      HelpContext = 415087
      Caption = 'Details'
      object pnlDetails: TDNMPanel
        Left = 0
        Top = 0
        Width = 988
        Height = 415
        HelpContext = 415088
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 0
        Transparent = False
        object Bevel3: TBevel
          Left = 3
          Top = 192
          Width = 982
          Height = 224
          HelpContext = 415002
          Shape = bsFrame
        end
        object Bevel4: TBevel
          Left = 320
          Top = 203
          Width = 285
          Height = 23
          HelpContext = 415003
          Shape = bsFrame
        end
        object Bevel1: TBevel
          Left = 3
          Top = 2
          Width = 982
          Height = 194
          HelpContext = 415004
          Shape = bsFrame
        end
        object Cus_address_Label: TLabel
          Left = 37
          Top = 37
          Width = 51
          Height = 16
          HelpContext = 415006
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Address'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object lblAddress2: TLabel
          Left = 27
          Top = 64
          Width = 61
          Height = 16
          HelpContext = 415033
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Address 2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object lblAddress3: TLabel
          Left = 27
          Top = 90
          Width = 61
          Height = 16
          HelpContext = 415034
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Address 3'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Cus_city_sub_Label: TLabel
          Left = 59
          Top = 117
          Width = 29
          Height = 16
          HelpContext = 415007
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'City'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Cus_state_Label: TLabel
          Left = 52
          Top = 142
          Width = 36
          Height = 16
          HelpContext = 415008
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'State'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object lblCountry: TLabel
          Left = 37
          Top = 168
          Width = 51
          Height = 16
          HelpContext = 415035
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Country'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Cus_Pcode_Label: TLabel
          Left = 187
          Top = 141
          Width = 58
          Height = 16
          HelpContext = 415009
          AutoSize = False
          Caption = 'Postcode'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label6: TLabel
          Left = 407
          Top = 11
          Width = 59
          Height = 17
          HelpContext = 415010
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Phone Number'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label17: TLabel
          Left = 407
          Top = 37
          Width = 59
          Height = 17
          HelpContext = 415076
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Mobile'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Cus_Alt_PH_Label: TLabel
          Left = 407
          Top = 63
          Width = 59
          Height = 17
          HelpContext = 415011
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Alt Phone'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label19: TLabel
          Left = 378
          Top = 142
          Width = 88
          Height = 15
          HelpContext = 415077
          Alignment = taRightJustify
          Caption = 'Team Viewer ID'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label3: TLabel
          Left = 47
          Top = 206
          Width = 41
          Height = 15
          HelpContext = 415014
          Alignment = taRightJustify
          Caption = 'Module'
          Transparent = True
        end
        object Label7: TLabel
          Left = 57
          Top = 236
          Width = 31
          Height = 15
          HelpContext = 415017
          Alignment = taRightJustify
          Caption = 'Issue'
          Transparent = True
        end
        object lblDateCreated: TDBText
          Left = 433
          Top = 206
          Width = 84
          Height = 15
          HelpContext = 415021
          AutoSize = True
          DataField = 'DateCreated'
          DataSource = dsLog
          Transparent = True
        end
        object Label4: TLabel
          Left = 327
          Top = 206
          Width = 99
          Height = 15
          HelpContext = 415015
          Caption = 'Call Commenced:'
          Transparent = True
        end
        object Label10: TLabel
          Left = 856
          Top = 213
          Width = 52
          Height = 15
          HelpContext = 415023
          Alignment = taRightJustify
          Caption = 'Call Time'
          Transparent = True
        end
        object Label2: TLabel
          Left = 910
          Top = 195
          Width = 56
          Height = 15
          HelpContext = 415022
          Caption = 'hh:mm:ss'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label16: TLabel
          Left = 35
          Top = 301
          Width = 53
          Height = 15
          HelpContext = 415030
          Alignment = taRightJustify
          Caption = 'Assign to'
          Transparent = True
        end
        object Label8: TLabel
          Left = 42
          Top = 326
          Width = 46
          Height = 15
          HelpContext = 415018
          Alignment = taRightJustify
          Caption = 'Solution'
          Transparent = True
        end
        object lblFrom: TLabel
          Left = 284
          Top = 301
          Width = 83
          Height = 15
          HelpContext = 415031
          Alignment = taRightJustify
          Caption = 'Assigned from'
          Transparent = True
          Visible = False
        end
        object lblOn: TLabel
          Left = 584
          Top = 301
          Width = 16
          Height = 15
          HelpContext = 415032
          Alignment = taRightJustify
          Caption = 'On'
          Transparent = True
          Visible = False
        end
        object Label18: TLabel
          Left = 737
          Top = 4
          Width = 76
          Height = 15
          HelpContext = 415073
          Caption = 'Attachments:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label5: TLabel
          Left = 62
          Top = 391
          Width = 26
          Height = 15
          HelpContext = 415016
          Alignment = taRightJustify
          Caption = 'Type'
          Transparent = True
        end
        object Label12: TLabel
          Left = 324
          Top = 391
          Width = 43
          Height = 15
          HelpContext = 415025
          Alignment = taRightJustify
          Caption = 'Version'
          Transparent = True
        end
        object Label11: TLabel
          Left = 405
          Top = 115
          Width = 61
          Height = 15
          HelpContext = 415024
          Alignment = taRightJustify
          Caption = 'Entered By'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label1: TLabel
          Left = 424
          Top = 89
          Width = 42
          Height = 17
          HelpContext = 415013
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'E-mail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object lblStatus: TLabel
          Left = 563
          Top = 392
          Width = 37
          Height = 15
          HelpContext = 415089
          Alignment = taRightJustify
          Caption = 'Status'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object cboContactX: TwwDBLookupCombo
          Left = 92
          Top = 8
          Width = 188
          Height = 23
          HelpContext = 415050
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ControlType.Strings = (
            'StopCreditImage;ImageIndex;Shrink To Fit')
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Contact'#9'20'#9'Contact'#9'F'
            'StopCreditImage'#9'1'#9'Stop Credit'#9'T'#9
            'TeamviewerID'#9'12'#9'Team Viewer ID'#9'F')
          DataField = 'Contact'
          DataSource = dsLog
          LookupTable = qryContacts
          LookupField = 'Contact'
          Options = [loTitles]
          Style = csDropDownList
          ImageList = imgPopup
          ParentFont = False
          TabOrder = 0
          AutoDropDown = False
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnDblClick = cboContactXDblClick
          OnCloseUp = cboContactXCloseUp
          OnEnter = cboContactXEnter
          OnExit = cboContactXExit
          OnNotInList = cboContactXNotInList
        end
        object btnNewContact: TDNMSpeedButton
          Left = 283
          Top = 8
          Width = 46
          Height = 23
          HelpContext = 415051
          Caption = 'New ...'
          DisableTransparent = False
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = [fsBold]
          TabOrder = 1
          AutoDisableParentOnclick = True
          OnClick = btnNewContactClick
        end
        object edtAddress: TwwDBEdit
          Left = 92
          Top = 34
          Width = 237
          Height = 23
          HelpContext = 415042
          AutoSize = False
          Color = clWhite
          DataField = 'ContactAddress'
          DataSource = dsContacts
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object txtAddress2: TwwDBEdit
          Left = 92
          Top = 60
          Width = 237
          Height = 23
          HelpContext = 415069
          AutoSize = False
          Color = clWhite
          DataField = 'ContactAddress2'
          DataSource = dsContacts
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object txtAddress3: TwwDBEdit
          Left = 92
          Top = 86
          Width = 237
          Height = 23
          HelpContext = 415070
          AutoSize = False
          Color = clWhite
          DataField = 'ContactAddress3'
          DataSource = dsContacts
          Font.Charset = ANSI_CHARSET
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
        object edtCity: TwwDBEdit
          Left = 92
          Top = 112
          Width = 237
          Height = 23
          HelpContext = 415043
          AutoSize = False
          Color = clWhite
          DataField = 'ContactCity'
          DataSource = dsContacts
          Font.Charset = ANSI_CHARSET
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
        object edtPostCode: TwwDBEdit
          Left = 92
          Top = 138
          Width = 61
          Height = 23
          HelpContext = 415045
          AutoSize = False
          Color = clWhite
          DataField = 'ContactState'
          DataSource = dsContacts
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object txtCountry: TwwDBEdit
          Left = 92
          Top = 165
          Width = 237
          Height = 23
          HelpContext = 415071
          AutoSize = False
          Color = clWhite
          DataField = 'ContactCountry'
          DataSource = dsContacts
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 8
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object edtState: TwwDBEdit
          Left = 249
          Top = 138
          Width = 80
          Height = 23
          HelpContext = 415044
          AutoSize = False
          Color = clWhite
          DataField = 'ContactPcode'
          DataSource = dsContacts
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 7
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object edtPhone: TwwDBEdit
          Left = 472
          Top = 8
          Width = 139
          Height = 23
          HelpContext = 415046
          AutoSize = False
          Color = clWhite
          DataField = 'ContactPH'
          DataSource = dsContacts
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          TabOrder = 9
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object edtMobile: TwwDBEdit
          Left = 473
          Top = 34
          Width = 138
          Height = 23
          HelpContext = 415079
          AutoSize = False
          Color = clWhite
          DataField = 'ContactMOB'
          DataSource = dsContacts
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          TabOrder = 10
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object edtAltPhone: TwwDBEdit
          Left = 473
          Top = 60
          Width = 138
          Height = 23
          HelpContext = 415047
          AutoSize = False
          Color = clWhite
          DataField = 'ContactAltPH'
          DataSource = dsContacts
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 11
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object edtEmail: TwwDBEdit
          Left = 473
          Top = 86
          Width = 211
          Height = 23
          HelpContext = 415049
          AutoSize = False
          Color = clWhite
          DataField = 'ContactEmail'
          DataSource = dsContacts
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 12
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object wwDBEdit1: TwwDBEdit
          Left = 472
          Top = 138
          Width = 211
          Height = 23
          HelpContext = 415084
          AutoSize = False
          Color = clWhite
          DataField = 'TeamviewerID'
          DataSource = dsContacts
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 14
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object DNMSpeedButton1: TDNMSpeedButton
          Left = 473
          Top = 165
          Width = 85
          Height = 23
          HelpContext = 415078
          Caption = 'Log Me In'
          DisableTransparent = False
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = [fsBold]
          TabOrder = 15
          AutoDisableParentOnclick = True
          OnClick = DNMSpeedButton1Click
        end
        object btnTV: TDNMSpeedButton
          Left = 599
          Top = 165
          Width = 85
          Height = 23
          HelpContext = 415081
          Caption = 'Team Viewer'
          DisableTransparent = False
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = [fsBold]
          TabOrder = 16
          AutoDisableParentOnclick = True
          OnClick = btnTVClick
        end
        object cboModuleNAme: TERPDbLookupCombo
          Left = 92
          Top = 202
          Width = 185
          Height = 23
          HelpContext = 415085
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          DataField = 'Form'
          DataSource = dsLog
          LookupTable = qryForms
          LookupField = 'ModuleName'
          DropDownWidth = 625
          ParentFont = False
          TabOrder = 18
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnEnter = cboModuleNAmeEnter
          OnExit = cboModuleNAmeExit
          LookupFormClassName = 'TSupportModulesGUI'
          EditFormClassName = 'TfmSupportModule'
          LookupFormKeyStringFieldName = 'ModuleName'
          LookupComboType = ctSupportModule
          AllowFullListSearchMode = False
          DisableNotInList = False
          AllowMultipleSelectFromList = False
          OpenListinF6WhenNotinList = False
          DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
          LookupIDField = 'ID'
        end
        object cboForm: TwwDBLookupCombo
          Left = 217
          Top = 251
          Width = 40
          Height = 23
          HelpContext = 415036
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          DataField = 'Form'
          DataSource = dsLog
          LookupTable = qryForms
          LookupField = 'ModuleName'
          DropDownWidth = 625
          ParentFont = False
          TabOrder = 19
          Visible = False
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
        object edtTimer: TwwDBEdit
          Left = 910
          Top = 209
          Width = 65
          Height = 23
          HelpContext = 415053
          DataField = 'CallTime'
          DataSource = dsLog
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 20
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          OnExit = edtTimerExit
        end
        object edtIssue: TDBMemo
          Left = 92
          Top = 236
          Width = 883
          Height = 57
          HelpContext = 415040
          DataField = 'Issue'
          DataSource = dsLog
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 21
          OnExit = edtIssueExit
        end
        object cboToEmployeeID: TwwDBLookupCombo
          Left = 92
          Top = 297
          Width = 185
          Height = 23
          HelpContext = 415065
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'EmployeeName'#9'40'#9'EmployeeName'#9#9)
          DataField = 'ToEmployeeID'
          DataSource = dsLog
          LookupTable = qryEmployees
          LookupField = 'EmployeeID'
          DropDownWidth = 625
          ParentFont = False
          TabOrder = 22
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnExit = cboToEmployeeIDExit
        end
        object txtFromEmployee: TwwDBEdit
          Left = 371
          Top = 297
          Width = 185
          Height = 23
          HelpContext = 415083
          AutoSize = False
          Color = clWhite
          DataField = 'Fromemployee'
          DataSource = dsLog
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 23
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object txtFromDate: TwwDBEdit
          Left = 606
          Top = 297
          Width = 108
          Height = 23
          HelpContext = 415082
          AutoSize = False
          Color = clWhite
          DataField = 'FromDate'
          DataSource = dsLog
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 24
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object edtSolution: TDBMemo
          Left = 92
          Top = 326
          Width = 881
          Height = 57
          HelpContext = 415041
          DataField = 'Solution'
          DataSource = dsLog
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 26
          OnExit = edtSolutionExit
        end
        object pnlAttachments: TPanel
          Left = 737
          Top = 18
          Width = 241
          Height = 168
          HelpContext = 415074
          BevelOuter = bvNone
          BorderStyle = bsSingle
          Color = clWhite
          TabOrder = 17
        end
        object cboPhoneSupporttype: TwwDBLookupCombo
          Left = 92
          Top = 388
          Width = 185
          Height = 23
          HelpContext = 415075
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ControlInfoInDataset = False
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Name'#9'10'#9'Name'#9'F'
            'Description'#9'30'#9'Description'#9'F')
          DataField = 'Type'
          DataSource = dsLog
          LookupTable = QryPhoneSupporttype
          LookupField = 'Name'
          AutoSelect = False
          MaxLength = 255
          ParentFont = False
          TabOrder = 27
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          ShowMatchText = True
          OnDblClick = cboPhoneSupporttypeDblClick
          OnNotInList = cboPhoneSupporttypeNotInList
        end
        object cboVersion: TwwDBLookupCombo
          Left = 371
          Top = 388
          Width = 185
          Height = 23
          HelpContext = 415056
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Name'#9'10'#9'Name'#9'F'
            'Description'#9'30'#9'Description'#9'F')
          DataField = 'Version'
          DataSource = dsLog
          LookupTable = qryVersion
          LookupField = 'Name'
          ParentFont = False
          TabOrder = 28
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnDblClick = cboVersionDblClick
          OnNotInList = cboVersionNotInList
        end
        object txtEnteredByEmp: TEdit
          Left = 473
          Top = 112
          Width = 138
          Height = 23
          HelpContext = 415055
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 13
        end
        object DNMSpeedButton2: TDNMSpeedButton
          Left = 15
          Top = 347
          Width = 73
          Height = 23
          HelpContext = 415090
          Caption = 'Comments'
          DisableTransparent = False
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = [fsBold]
          TabOrder = 25
          AutoDisableParentOnclick = True
          OnClick = DNMSpeedButton2Click
        end
        object cboCurrentStatus: TwwDBLookupCombo
          Left = 606
          Top = 388
          Width = 185
          Height = 23
          HelpContext = 415091
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'name'#9'30'#9'name'#9'F')
          DataField = 'Status'
          DataSource = dsLog
          LookupTable = QryStatus
          LookupField = 'Name'
          ParentFont = False
          TabOrder = 29
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnDblClick = cboCurrentStatusDblClick
          OnNotInList = cboCurrentStatusNotInList
        end
        object btnEditContact: TDNMSpeedButton
          Left = 335
          Top = 8
          Width = 46
          Height = 23
          Caption = 'Edit'
          DisableTransparent = False
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = [fsBold]
          TabOrder = 30
          AutoDisableParentOnclick = True
          OnClick = btnEditContactClick
          HelpContext = 415103
        end
      end
    end
    object Comments: TTabSheet
      HelpContext = 415096
      Caption = 'Comments'
      ImageIndex = 2
      object DNMPanel2: TDNMPanel
        Left = 0
        Top = 0
        Width = 988
        Height = 415
        HelpContext = 415097
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object grdTransactions: TwwDBGrid
          Left = 1
          Top = 1
          Width = 986
          Height = 413
          HelpContext = 415098
          ControlType.Strings = (
            'EmployeeName;CustomEdit;cboEmployeeName;F'
            'Comments;CustomEdit;edtComments;F'
            'AssignTo;CustomEdit;cboAssignTo;F'
            'IsFollowupCall;CheckBox;T;F')
          Selected.Strings = (
            'Date'#9'15'#9'Date'#9#9
            'EmployeeName'#9'15'#9'Entered By'#9#9
            'Comments'#9'78'#9'Comments'#9'F'#9
            'AssignTo'#9'15'#9'Assign To'#9#9
            'IsFollowupCall'#9'1'#9'Follow-up?'#9'F'#9)
          MemoAttributes = [mSizeable, mWordWrap, mGridShow]
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          FixedCols = 0
          ShowHorzScrollBar = True
          EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
          Align = alClient
          DataSource = dsLogLines
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          KeyOptions = [dgAllowInsert]
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect, dgRowResize]
          ParentFont = False
          TabOrder = 2
          TitleAlignment = taLeftJustify
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = True
          FooterColor = clWhite
          FooterCellColor = clWhite
          PaintOptions.BackgroundOptions = [coBlendFixedRow]
        end
        object cboEmployeeName: TwwDBLookupCombo
          Left = 291
          Top = 102
          Width = 130
          Height = 24
          HelpContext = 415099
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'EmployeeName'#9'20'#9'EmployeeName'#9'F')
          DataField = 'EmployeeName'
          DataSource = dsLogLines
          LookupTable = Qryentered
          LookupField = 'EmployeeName'
          DropDownWidth = 625
          ParentFont = False
          TabOrder = 0
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
        object cboAssignTo: TwwDBLookupCombo
          Left = 427
          Top = 102
          Width = 130
          Height = 24
          HelpContext = 415100
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'EmployeeName'#9'20'#9'EmployeeName'#9'F')
          DataField = 'AssignTo'
          DataSource = dsLogLines
          LookupTable = QryAssignTo
          LookupField = 'EmployeeName'
          DropDownWidth = 625
          ParentFont = False
          TabOrder = 1
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
        object edtComments: TwwDBEdit
          Left = 352
          Top = 72
          Width = 121
          Height = 24
          HelpContext = 415101
          DataField = 'Comments'
          DataSource = dsLogLines
          TabOrder = 3
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
      end
    end
    object pgHistory: TTabSheet
      HelpContext = 415092
      Caption = 'History'
      ImageIndex = 1
      object pnlHistory: TDNMPanel
        Left = 0
        Top = 0
        Width = 988
        Height = 415
        HelpContext = 415093
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 0
        Transparent = False
      end
    end
  end
  object DNMPanel1: TDNMPanel [16]
    Left = 0
    Top = 531
    Width = 996
    Height = 34
    HelpContext = 415094
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    DesignSize = (
      996
      34)
    object btnSave: TDNMSpeedButton
      Left = 49
      Top = 3
      Width = 97
      Height = 27
      HelpContext = 415038
      Caption = 'Close Call'
      DisableTransparent = False
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      TabOrder = 0
      AutoDisableParentOnclick = True
      OnClick = btnSaveClick
    end
    object btnHold: TDNMSpeedButton
      Left = 156
      Top = 3
      Width = 97
      Height = 27
      HelpContext = 415052
      Caption = 'Hold Call'
      DisableTransparent = False
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333333333333333EEEEEEEEEEEEEEE333FFFFFFFFFFFFF3E00000000000
        00E337777777777777F3E0F77777777770E337F33333333337F3E0F333333333
        70E337F33333333337F3E0F33333333370E337F333FF3FF337F3E0F330030033
        70E337F3377F77F337F3E0F33003003370E337F3377F77F337F3E0F330030033
        70E337F3377F77F337F3E0F33003003370E337F3377F77F337F3E0F330030033
        70E337F33773773337F3E0F33333333370E337F33333333337F3E0F333333333
        70E337F33333333337F3E0FFFFFFFFFFF0E337FFFFFFFFFFF7F3E00000000000
        00E33777777777777733EEEEEEEEEEEEEEE33333333333333333}
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      TabOrder = 1
      AutoDisableParentOnclick = True
      OnClick = btnHoldClick
    end
    object btnEmail: TDNMSpeedButton
      Left = 263
      Top = 3
      Width = 97
      Height = 27
      HelpContext = 415064
      Caption = 'E-mail'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 2
      AutoDisableParentOnclick = True
      OnClick = btnEmailClick
    end
    object btnRepair: TDNMSpeedButton
      Left = 370
      Top = 3
      Width = 97
      Height = 27
      HelpContext = 415080
      Caption = 'Repair'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 3
      AutoDisableParentOnclick = True
      OnClick = btnRepairClick
    end
    object btnPrint: TDNMSpeedButton
      Left = 691
      Top = 3
      Width = 97
      Height = 27
      HelpContext = 415059
      Caption = 'Print...'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 4
      AutoDisableParentOnclick = True
      OnClick = btnPrintClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 798
      Top = 3
      Width = 97
      Height = 27
      HelpContext = 415039
      Cancel = True
      Caption = 'Cancel'
      DisableTransparent = False
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      TabOrder = 5
      AutoDisableParentOnclick = True
      OnClick = btnCancelClick
    end
    object chkFinished: TwwCheckBox
      Left = 918
      Top = 8
      Width = 71
      Height = 17
      HelpContext = 415095
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Anchors = [akRight, akBottom]
      Caption = 'Finished'
      DataField = 'Finished'
      DataSource = dsLog
      TabOrder = 6
    end
    object btnTask: TDNMSpeedButton
      Left = 477
      Top = 3
      Width = 97
      Height = 27
      HelpContext = 415102
      Caption = 'Task'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 7
      AutoDisableParentOnclick = True
      OnClick = btnTaskClick
    end
    object btnLineCustomFields: TDNMSpeedButton
      Left = 584
      Top = 3
      Width = 97
      Height = 27
      Caption = 'Custom Fields'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 8
      AutoDisableParentOnclick = True
      OnClick = btnLineCustomFieldsClick
      HelpContext = 415104
    end
  end
  object cboCompany: TwwDBLookupCombo [17]
    Left = 756
    Top = 19
    Width = 81
    Height = 23
    HelpContext = 415057
    Anchors = [akTop, akRight]
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'Company'#9'30'#9'Company'#9'F')
    DataField = 'ClientID'
    DataSource = dsLog
    LookupTable = qryCustomers
    LookupField = 'ClientID'
    TabOrder = 0
    Visible = False
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
  end
  inherited popSpelling: TPopupMenu
    Left = 784
    Top = 260
  end
  inherited tmrdelayMsg: TTimer
    Left = 816
    Top = 260
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 597
    Top = 260
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 659
    Top = 260
  end
  inherited MyConnection: TERPConnection
    Server = 'localhost'
    Left = 34
    Top = 260
  end
  inherited DataState: TDataState
    Left = 534
    Top = 260
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 690
    Top = 260
  end
  inherited imgsort: TImageList
    Left = 628
    Top = 260
    Bitmap = {
      494C010102000001C80110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited QryCustomField: TERPQuery
    Left = 190
    Top = 260
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 753
    Top = 260
  end
  inherited qryMemTrans: TERPQuery
    Left = 503
    Top = 260
  end
  object qryCustomers: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ClientID, Company'
      'FROM tblClients'
      'WHERE Company<>"" And Customer = '#39'T'#39' And Active = '#39'T'#39
      'ORDER BY tblClients.Company;')
    Left = 221
    Top = 260
  end
  object dsLog: TDataSource
    DataSet = qryLog
    Left = 65
    Top = 227
  end
  object qryLog: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblphonesupportlog'
      'WHERE SupportLogID = :xSupportLogID')
    AfterOpen = qryLogAfterOpen
    AfterPost = qryLogAfterPost
    OnCalcFields = qryLogCalcFields
    Left = 65
    Top = 260
    ParamData = <
      item
        DataType = ftString
        Name = 'xSupportLogID'
        Size = 255
      end>
    object qryLogGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryLogSupportLogID: TAutoIncField
      FieldName = 'SupportLogID'
      ReadOnly = True
    end
    object qryLogClientID: TIntegerField
      FieldName = 'ClientID'
    end
    object qryLogCompany: TWideStringField
      FieldName = 'Company'
      Size = 255
    end
    object qryLogEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
    end
    object qryLogDateCreated: TDateTimeField
      FieldName = 'DateCreated'
    end
    object qryLogForm: TWideStringField
      FieldName = 'Form'
      Size = 255
    end
    object qryLogIssue: TWideMemoField
      FieldName = 'Issue'
      BlobType = ftWideMemo
    end
    object qryLogType: TWideStringField
      FieldName = 'Type'
      OnChange = qryLogTypeChange
      Size = 255
    end
    object qryLogSolution: TWideMemoField
      FieldName = 'Solution'
      BlobType = ftWideMemo
    end
    object qryLogEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryLogActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryLogContact: TWideStringField
      FieldName = 'Contact'
      Size = 255
    end
    object qryLogCallSecs: TIntegerField
      FieldName = 'CallSecs'
    end
    object qryLogCallTime: TWideStringField
      FieldName = 'CallTime'
      EditMask = '!99:99:99;1;_'
      Size = 255
    end
    object qryLogFinished: TWideStringField
      FieldName = 'Finished'
      FixedChar = True
      Size = 1
    end
    object qryLogContactID: TIntegerField
      FieldName = 'ContactID'
    end
    object qryLogVersion: TWideStringField
      FieldName = 'Version'
      OnChange = qryLogVersionChange
      Size = 255
    end
    object qryLogEnteredBy: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'EnteredBy'
      Calculated = True
    end
    object qryLogToEmployeeID: TIntegerField
      FieldName = 'ToEmployeeID'
    end
    object qryLogFromEmployeeID: TIntegerField
      FieldName = 'FromEmployeeID'
    end
    object qryLogFromDate: TDateTimeField
      FieldName = 'FromDate'
    end
    object qryLogFromemployee: TStringField
      FieldKind = fkLookup
      FieldName = 'Fromemployee'
      LookupDataSet = qryFromemployee
      LookupKeyFields = 'EmployeeID'
      LookupResultField = 'EmployeeName'
      KeyFields = 'FromEmployeeID'
      Size = 100
      Lookup = True
    end
    object qryLogStatus: TWideStringField
      FieldName = 'Status'
      Size = 255
    end
    object qryLogTaskId: TIntegerField
      FieldName = 'TaskId'
    end
  end
  object qryClient: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'tblContacts.ContactPH,ContactFax,'
      'C.Phone,'
      'c.ClientID, '
      'C.Company As Company,'
      
        'CONCAT_WS(" ",tblcontacts.ContactFirstName,tblcontacts.ContactSu' +
        'rName) as Contact,'
      
        'C.Street, C.Street2, C.Street3, C.Suburb, C.State, C.PostCode, C' +
        '.Country,'
      ' C.AltPhone, C.FaxNumber, C.Mobile, C.Email,'
      'E.EmployeeName AS RepName,'
      'C.RepID'
      'FROM tblClients C'
      'LEFT JOIN  tblContacts on c.ClientID=tblContacts.ClientID'
      'LEFT JOIN tblemployees E ON RepID=E.EmployeeID'
      'WHERE C.ClientID = :xClientID')
    Left = 127
    Top = 260
    ParamData = <
      item
        DataType = ftString
        Name = 'xClientID'
        Size = 255
      end>
    object qryClientClientID: TAutoIncField
      FieldName = 'ClientID'
      ReadOnly = True
    end
    object qryClientCompany: TWideStringField
      FieldName = 'Company'
      Size = 80
    end
    object qryClientContact: TWideStringField
      FieldName = 'Contact'
      ReadOnly = True
      Size = 57
    end
    object qryClientStreet: TWideStringField
      FieldName = 'Street'
      Size = 38
    end
    object qryClientStreet2: TWideStringField
      FieldName = 'Street2'
      Size = 255
    end
    object qryClientStreet3: TWideStringField
      FieldName = 'Street3'
      Size = 255
    end
    object qryClientSuburb: TWideStringField
      FieldName = 'Suburb'
      Size = 27
    end
    object qryClientState: TWideStringField
      FieldName = 'State'
      FixedChar = True
      Size = 3
    end
    object qryClientPostCode: TWideStringField
      FieldName = 'PostCode'
      Size = 4
    end
    object qryClientCountry: TWideStringField
      FieldName = 'Country'
      Size = 255
    end
    object qryClientPhone: TWideStringField
      FieldName = 'Phone'
    end
    object qryClientAltPhone: TWideStringField
      FieldName = 'AltPhone'
    end
    object qryClientFaxNumber: TWideStringField
      FieldName = 'FaxNumber'
    end
    object qryClientMobile: TWideStringField
      FieldName = 'Mobile'
    end
    object qryClientEmail: TWideStringField
      FieldName = 'Email'
      Size = 80
    end
    object qryClientRepName: TWideStringField
      FieldName = 'RepName'
      Size = 255
    end
    object qryClientRepID: TIntegerField
      FieldName = 'RepID'
    end
    object qryClientContactPH: TWideStringField
      FieldName = 'ContactPH'
      Size = 255
    end
    object qryClientContactFax: TWideStringField
      FieldName = 'ContactFax'
      Size = 255
    end
  end
  object dsClient: TDataSource
    DataSet = qryClient
    Left = 125
    Top = 227
  end
  object qryForms: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      'Id, moduleName  '
      'FROM tblSupportModules'
      'Where (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and (ModuleName LIKE Concat(:SearchValue,"' +
        '%")))'
      
        'or ((:SearchMode = 2) and (ModuleName LIKE Concat("%",:SearchVal' +
        'ue,"%"))))'
      'and IfNull(:SearchValue,"") <> ""'
      'ORDER BY ModuleName')
    Left = 378
    Top = 260
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end>
  end
  object qryContacts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      '`C`.`ContactID`,'
      '`C`.`Company`,'
      'CONCAT_WS('#39' '#39',ContactFirstName,ContactSurName) AS `Contact`,'
      '`CL`.`StopCredit`,'
      'C.TeamviewerID as TeamviewerID, '
      '`C`.`ContactEmail`,'
      '`C`.`ContactPH`,'
      '`C`.`ContactAddress`,'
      '`C`.`ContactAddress2`,'
      '`C`.`ContactAddress3`,'
      '`C`.`ContactAltPH`,'
      '`C`.`ContactMOB`,'
      '`C`.`ContactCity`,'
      '`C`.`ContactState`,'
      '`C`.`ContactPcode`,'
      '`C`.`ContactCountry`,'
      '`C`.`ContactFax`,'
      'ifnull(CL.ClientCode,"") as ClientCode'
      'FROM'
      '`tblcontacts` AS `C`'
      
        'Inner Join `tblclients` AS `CL` ON `C`.`ClientID` = `CL`.`Client' +
        'ID`'
      'WHERE c.ClientID=:xCusID'
      'and C.Active  = '#39'T'#39' '
      'Order By Contact;')
    OnCalcFields = qryContactsCalcFields
    Left = 159
    Top = 260
    ParamData = <
      item
        DataType = ftString
        Name = 'xCusID'
        Size = 255
      end>
    object qryContactsContact: TWideStringField
      DisplayWidth = 20
      FieldName = 'Contact'
      Origin = '.Contact'
      ReadOnly = True
      Size = 61
    end
    object qryContactsStopCreditImage: TIntegerField
      DisplayLabel = 'Stop Credit'
      DisplayWidth = 1
      FieldKind = fkCalculated
      FieldName = 'StopCreditImage'
      Calculated = True
    end
    object qryContactsTeamviewerID: TWideStringField
      DisplayLabel = 'Team Viewer ID'
      DisplayWidth = 12
      FieldName = 'TeamviewerID'
      Size = 9
    end
    object qryContactsContactID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'ContactID'
      Origin = 'tblContacts.ContactID'
      ReadOnly = True
      Visible = False
    end
    object qryContactsCompany: TWideStringField
      FieldName = 'Company'
      Origin = 'tblContacts.Company'
      Visible = False
      Size = 50
    end
    object qryContactsContactEmail: TWideStringField
      FieldName = 'ContactEmail'
      Origin = 'tblContacts.ContactEmail'
      Visible = False
      Size = 255
    end
    object qryContactsStopCredit: TWideStringField
      FieldName = 'StopCredit'
      Origin = 'tblClients.StopCredit'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryContactsContactPH: TWideStringField
      FieldName = 'ContactPH'
      Visible = False
      Size = 255
    end
    object qryContactsContactAddress: TWideStringField
      FieldName = 'ContactAddress'
      Visible = False
      Size = 255
    end
    object qryContactsContactAddress2: TWideStringField
      FieldName = 'ContactAddress2'
      Visible = False
      Size = 255
    end
    object qryContactsContactAddress3: TWideStringField
      FieldName = 'ContactAddress3'
      Visible = False
      Size = 255
    end
    object qryContactsContactAltPH: TWideStringField
      FieldName = 'ContactAltPH'
      Visible = False
      Size = 255
    end
    object qryContactsContactMOB: TWideStringField
      FieldName = 'ContactMOB'
      Visible = False
      Size = 255
    end
    object qryContactsContactCity: TWideStringField
      FieldName = 'ContactCity'
      Visible = False
      Size = 255
    end
    object qryContactsContactState: TWideStringField
      FieldName = 'ContactState'
      Visible = False
      Size = 255
    end
    object qryContactsContactPcode: TWideStringField
      FieldName = 'ContactPcode'
      Visible = False
      Size = 255
    end
    object qryContactsContactCountry: TWideStringField
      FieldName = 'ContactCountry'
      Visible = False
      Size = 255
    end
    object qryContactsContactFax: TWideStringField
      FieldName = 'ContactFax'
      Visible = False
      Size = 255
    end
    object qryContactsClientCode: TWideStringField
      FieldName = 'ClientCode'
      Size = 5
    end
  end
  object tmrTime: TTimer
    Enabled = False
    OnTimer = tmrTimeTimer
    Left = 565
    Top = 260
  end
  object imgPopup: TImageList
    Left = 722
    Top = 260
    Bitmap = {
      494C01010200A4006C0110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800080808000000000000000000080808000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000080000000000080808000000000000000FF0000008000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000008000000080000080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF0000008000808080000000FF000000800000000000808080000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000008000000080000000800000808080008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000008000000080000000800080808000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000008000008000000000800000008000008080800080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008000000080008080800080808000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000008000008000000000FF0000008000000080000080808000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000008000000080000000800080808000808080000000
      00000000000000000000000000000000000000000000000000000000000000FF
      000000800000800000000000000000FF00000080000000800000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080000000FF0000008000808080000000FF0000008000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000800000008000008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000800000008000808080000000FF0000008000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF0000008000000080
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      000000000000000000000000FFFFFF00FFFFFFFF00000000FFFFFFFF00000000
      FFFFFFFF00000000FFFFFFFF00000000F98FF9FF00000000E10FF0FF00000000
      F01FE07F00000000F83FE03F00000000FC3FE01F00000000F81FE20F00000000
      F00FFF0700000000F00FFF8700000000FFFFFFFF00000000FFFFFFFF00000000
      FFFFFFFF00000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
  object qryVersion: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT Typecode,Name,Description FROM tblsimpletypes '
      
        'WHERE Typecode = '#39'SupportVersion'#39' and ((Active = "T") or (Name =' +
        ' :xName))'
      'ORDER BY Name')
    Left = 409
    Top = 260
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xName'
      end>
    object qryVersionName: TWideStringField
      DisplayWidth = 10
      FieldName = 'Name'
      Origin = 'tblsimpletypes.Name'
      Size = 255
    end
    object qryVersionDescription: TWideStringField
      DisplayWidth = 30
      FieldName = 'Description'
      Origin = 'tblsimpletypes.Description'
      Size = 255
    end
    object qryVersionTypecode: TWideStringField
      FieldName = 'Typecode'
      Origin = 'tblsimpletypes.TypeCode'
      Visible = False
      Size = 30
    end
  end
  object qryEmployees: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT EmployeeName, EmployeeID '
      'FROM tblEmployees'
      'WHERE Active = '#39'T'#39)
    Left = 315
    Top = 260
    object qryEmployeesEmployeeName: TWideStringField
      DisplayWidth = 40
      FieldName = 'EmployeeName'
      Size = 255
    end
    object qryEmployeesEmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Visible = False
    end
  end
  object dsContacts: TDataSource
    DataSet = qryContacts
    Left = 155
    Top = 227
  end
  object qryFromemployee: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT EmployeeName, EmployeeID '
      'FROM tblEmployees'
      'WHERE Active = '#39'T'#39)
    Left = 346
    Top = 260
    object qryFromemployeeEmployeeName: TWideStringField
      DisplayWidth = 40
      FieldName = 'EmployeeName'
      Size = 255
    end
    object qryFromemployeeEmployeeId: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Visible = False
    end
  end
  object QryPhoneSupporttype: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT Typecode,Name,Description FROM tblsimpletypes '
      
        'WHERE Typecode = '#39'SupportType'#39' and ((Active = "T") or (Name = :x' +
        'Name))'
      'ORDER BY Name')
    Left = 471
    Top = 260
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xName'
      end>
    object QryPhoneSupporttypeName: TWideStringField
      DisplayWidth = 10
      FieldName = 'Name'
      Size = 255
    end
    object QryPhoneSupporttypeDescription: TWideStringField
      DisplayWidth = 30
      FieldName = 'Description'
      Size = 255
    end
    object QryPhoneSupporttypeTypecode: TWideStringField
      FieldName = 'Typecode'
      Visible = False
      Size = 30
    end
  end
  object qryLogLines: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblphonesupportLogLines')
    BeforeOpen = qryLogLinesBeforeOpen
    OnCalcFields = qryContactsCalcFields
    IndexFieldNames = 'Date DESC'
    Left = 96
    Top = 260
    object qryLogLinesDate: TDateTimeField
      DisplayWidth = 15
      FieldName = 'Date'
      Origin = 'tblphonesupportloglines.Date'
    end
    object qryLogLinesEmployeeName: TWideStringField
      DisplayLabel = 'Entered By'
      DisplayWidth = 15
      FieldName = 'EmployeeName'
      Origin = 'tblphonesupportloglines.EmployeeName'
      Size = 50
    end
    object qryLogLinesComments: TWideMemoField
      DisplayWidth = 78
      FieldName = 'Comments'
      Origin = 'tblphonesupportloglines.Comments'
      BlobType = ftWideMemo
    end
    object qryLogLinesAssignTo: TWideStringField
      DisplayLabel = 'Assign To'
      DisplayWidth = 15
      FieldName = 'AssignTo'
      Origin = 'tblphonesupportloglines.AssignTo'
      Size = 100
    end
    object qryLogLinesIsFollowupCall: TWideStringField
      DisplayLabel = 'Follow-up?'
      DisplayWidth = 1
      FieldName = 'IsFollowupCall'
      FixedChar = True
      Size = 1
    end
    object qryLogLinesGlobalref: TWideStringField
      DisplayLabel = 'Global Ref'
      DisplayWidth = 10
      FieldName = 'Globalref'
      Visible = False
      Size = 255
    end
    object qryLogLinesDeleted: TWideStringField
      DisplayWidth = 1
      FieldName = 'Deleted'
      Origin = 'tblphonesupportloglines.Deleted'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryLogLinesActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblphonesupportloglines.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryLogLinesID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tblphonesupportloglines.ID'
      Visible = False
    end
    object qryLogLinesSupportID: TIntegerField
      FieldName = 'SupportID'
      Origin = 'tblphonesupportloglines.SupportID'
      Visible = False
    end
    object qryLogLinesEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Origin = 'tblphonesupportloglines.EmployeeID'
      Visible = False
    end
    object qryLogLinesAssignToID: TIntegerField
      FieldName = 'AssignToID'
      Origin = 'tblphonesupportloglines.AssignToID'
      Visible = False
    end
    object qryLogLinesmstimeStamp: TDateTimeField
      FieldName = 'mstimeStamp'
      Origin = 'tblphonesupportloglines.mstimeStamp'
      Visible = False
    end
    object qryLogLinesmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblphonesupportloglines.msUpdateSiteCode'
      Visible = False
      Size = 3
    end
    object qryLogLinesCustomField1: TWideStringCustField
      DisplayWidth = 15
      FieldName = 'CustomField1'
      Visible = False
      Size = 255
    end
    object qryLogLinesCustomField2: TWideStringCustField
      DisplayWidth = 15
      FieldName = 'CustomField2'
      Visible = False
      Size = 255
    end
    object qryLogLinesCustomField3: TWideStringCustField
      DisplayWidth = 15
      FieldName = 'CustomField3'
      Visible = False
      Size = 255
    end
    object qryLogLinesCustomField4: TWideStringCustField
      DisplayWidth = 15
      FieldName = 'CustomField4'
      Visible = False
      Size = 255
    end
    object qryLogLinesCustomField5: TWideStringCustField
      DisplayWidth = 15
      FieldName = 'CustomField5'
      Visible = False
      Size = 255
    end
    object qryLogLinesCustomField6: TWideStringCustField
      DisplayWidth = 15
      FieldName = 'CustomField6'
      Visible = False
      Size = 255
    end
    object qryLogLinesCustomField7: TWideStringCustField
      DisplayWidth = 15
      FieldName = 'CustomField7'
      Visible = False
      Size = 255
    end
    object qryLogLinesCustomField8: TWideStringCustField
      DisplayWidth = 15
      FieldName = 'CustomField8'
      Visible = False
      Size = 255
    end
    object qryLogLinesCustomField9: TWideStringCustField
      DisplayWidth = 15
      FieldName = 'CustomField9'
      Visible = False
      Size = 255
    end
    object qryLogLinesCustomField10: TWideStringCustField
      DisplayWidth = 15
      FieldName = 'CustomField10'
      Visible = False
      Size = 255
    end
  end
  object QryStatus: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT id,Typecode,name FROM tblsimpletypes '
      
        'WHERE Typecode = :TransStatustype and (Active ="T"  or name = :S' +
        'electedStatus)'
      'ORDER BY Name')
    BeforeOpen = QryStatusBeforeOpen
    Left = 440
    Top = 260
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TransStatustype'
      end
      item
        DataType = ftUnknown
        Name = 'SelectedStatus'
      end>
  end
  object dsLogLines: TDataSource
    DataSet = qryLogLines
    Left = 95
    Top = 227
  end
  object Qryentered: TERPQuery
    SQL.Strings = (
      'SELECT EmployeeName, EmployeeID '
      'FROM tblEmployees'
      'WHERE Active = '#39'T'#39)
    Left = 252
    Top = 260
    object QryenteredEmployeeName: TWideStringField
      DisplayWidth = 20
      FieldName = 'EmployeeName'
      Size = 255
    end
    object QryenteredEmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Visible = False
    end
  end
  object QryAssignTo: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT EmployeeName, EmployeeID '
      'FROM tblEmployees'
      'WHERE Active = '#39'T'#39)
    Left = 284
    Top = 260
    object WideStringField1: TWideStringField
      DisplayWidth = 20
      FieldName = 'EmployeeName'
      Size = 255
    end
    object IntegerField1: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Visible = False
    end
  end
end
