inherited fmSupplier: TfmSupplier
  Left = 289
  Top = 252
  HelpContext = 355000
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Anchors = []
  Caption = 'Supplier'
  ClientHeight = 563
  ClientWidth = 832
  Font.Charset = DEFAULT_CHARSET
  Font.Style = []
  OldCreateOrder = True
  ExplicitLeft = 8
  ExplicitWidth = 838
  ExplicitHeight = 592
  DesignSize = (
    832
    563)
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel6: TBevel [0]
    Left = 733
    Top = 382
    Width = 97
    Height = 54
    HelpContext = 355002
    Anchors = [akTop, akRight]
  end
  object Label141: TLabel [1]
    Left = 753
    Top = 321
    Width = 56
    Height = 33
    HelpContext = 355003
    Alignment = taCenter
    Anchors = [akTop, akRight]
    AutoSize = False
    Caption = 'Supplier is Active'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label4: TLabel [2]
    Left = 738
    Top = 387
    Width = 85
    Height = 18
    HelpContext = 355004
    Alignment = taCenter
    Anchors = [akTop, akRight]
    AutoSize = False
    Caption = 'Convert To'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  inherited lblSkingroupMsg: TLabel
    Top = 563
    Width = 832
    HelpContext = 355193
    ExplicitTop = 480
    ExplicitWidth = 832
  end
  object lblIntrastat: TLabel [4]
    Left = 745
    Top = 448
    Width = 72
    Height = 33
    HelpContext = 355005
    Alignment = taCenter
    Anchors = [akTop, akRight]
    AutoSize = False
    Caption = 'Include on Intrastat'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  inherited imgGridWatermark: TImage
    HelpContext = 355001
  end
  object cmdPrint: TDNMSpeedButton [9]
    Left = 736
    Top = 251
    Width = 87
    Height = 27
    Hint = '"Print This Supplier"'
    HelpContext = 355011
    Anchors = [akTop, akRight]
    Caption = 'Prin&t'
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    AutoDisableParentOnclick = True
    OnClick = cmdPrintClick
  end
  object Button1: TDNMSpeedButton [10]
    Left = 738
    Top = 404
    Width = 87
    Height = 27
    Hint = '"Convert To Customer"'
    HelpContext = 355012
    Anchors = [akTop, akRight]
    Caption = 'Customer'
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    AutoDisableParentOnclick = True
    OnClick = Button1Click
  end
  object cmdShipping: TDNMSpeedButton [11]
    Left = 736
    Top = 183
    Width = 87
    Height = 27
    Hint = '"Add Shipping Addresses For This Customer"'
    HelpContext = 355013
    Anchors = [akTop, akRight]
    Caption = 'Shippin&g'
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    AutoDisableParentOnclick = True
    OnClick = cmdShippingClick
  end
  object btnPO: TDNMSpeedButton [12]
    Left = 736
    Top = 285
    Width = 87
    Height = 27
    Hint = 
      'Press this button to create a purchase order using this supplier' +
      '.'
    HelpContext = 355014
    Anchors = [akTop, akRight]
    Caption = 'P/O'
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    AutoDisableParentOnclick = True
    OnClick = btnPOClick
  end
  object TabCtl20: TPageControl [13]
    Left = 7
    Top = 82
    Width = 722
    Height = 474
    HelpContext = 355015
    ActivePage = Address
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    MultiLine = True
    ParentFont = False
    RaggedRight = True
    TabHeight = 25
    TabOrder = 0
    TabWidth = 143
    OnChange = TabCtl20Change
    OnChanging = TabCtl20Changing
    OnResize = TabCtl20Resize
    object Supplier_Info: TTabSheet
      HelpContext = 355016
      Caption = 'Su&pplier Info'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic, fsUnderline]
      ParentFont = False
      object DNMPanel1: TDNMPanel
        Left = 0
        Top = 0
        Width = 714
        Height = 414
        HelpContext = 355017
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Transparent = False
        DesignSize = (
          714
          414)
        object Bevel5: TBevel
          Left = 34
          Top = 188
          Width = 647
          Height = 222
          HelpContext = 355018
          Anchors = [akLeft, akTop, akRight, akBottom]
          ExplicitHeight = 139
        end
        object Box70: TBevel
          Left = 359
          Top = 5
          Width = 322
          Height = 177
          HelpContext = 355019
        end
        object Box69: TBevel
          Left = 34
          Top = 5
          Width = 322
          Height = 177
          HelpContext = 355020
        end
        object lblCompany: TLabel
          Left = 80
          Top = 155
          Width = 89
          Height = 15
          HelpContext = 355021
          Alignment = taRightJustify
          Caption = 'Company Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label27: TLabel
          Left = 104
          Top = 53
          Width = 65
          Height = 18
          HelpContext = 355022
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Mr./Mrs/...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label74: TLabel
          Left = 81
          Top = 87
          Width = 88
          Height = 18
          HelpContext = 355023
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'First Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label78: TLabel
          Left = 96
          Top = 121
          Width = 73
          Height = 18
          HelpContext = 355024
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Last Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label31: TLabel
          Left = 394
          Top = 12
          Width = 92
          Height = 18
          HelpContext = 355025
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
        object Label76: TLabel
          Left = 410
          Top = 41
          Width = 76
          Height = 18
          HelpContext = 355026
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Fax Number'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label33: TLabel
          Left = 373
          Top = 70
          Width = 113
          Height = 18
          HelpContext = 355027
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Alt. Phone Number'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label8: TLabel
          Left = 64
          Top = 197
          Width = 39
          Height = 15
          HelpContext = 355028
          Caption = 'Notes :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label13: TLabel
          Left = 373
          Top = 99
          Width = 113
          Height = 18
          HelpContext = 355029
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
        object Label29: TLabel
          Left = 415
          Top = 128
          Width = 71
          Height = 15
          HelpContext = 355194
          Alignment = taRightJustify
          Caption = 'Skype Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label43: TLabel
          Left = 391
          Top = 157
          Width = 95
          Height = 17
          HelpContext = 355278
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Supplier Code'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblClientPrintNameHeading: TLabel
          Left = 106
          Top = 19
          Width = 63
          Height = 15
          HelpContext = 355286
          Alignment = taRightJustify
          Caption = 'Print Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object txtCompany: TDBEdit
          Left = 176
          Top = 151
          Width = 160
          Height = 23
          HelpContext = 355030
          TabStop = False
          DataField = 'Company'
          DataSource = frmSupplierSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object txtContactTitle: TDBEdit
          Left = 176
          Top = 49
          Width = 160
          Height = 23
          HelpContext = 355031
          DataField = 'Title'
          DataSource = frmSupplierSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object txtContactFirstName: TDBEdit
          Left = 176
          Top = 83
          Width = 160
          Height = 23
          HelpContext = 355032
          DataField = 'FirstName'
          DataSource = frmSupplierSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object txtContactLastName: TDBEdit
          Left = 176
          Top = 117
          Width = 160
          Height = 23
          HelpContext = 355033
          DataField = 'LastName'
          DataSource = frmSupplierSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object txtPhoneNumber: TwwDBEdit
          Left = 491
          Top = 10
          Width = 169
          Height = 23
          HelpContext = 355034
          DataField = 'Phone'
          DataSource = frmSupplierSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          MaxLength = 20
          ParentFont = False
          TabOrder = 5
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object txtFaxNumber: TwwDBEdit
          Left = 491
          Top = 38
          Width = 169
          Height = 23
          HelpContext = 355035
          DataField = 'FaxNumber'
          DataSource = frmSupplierSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          MaxLength = 20
          ParentFont = False
          TabOrder = 6
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object txtAltPhone: TwwDBEdit
          Left = 491
          Top = 67
          Width = 169
          Height = 23
          HelpContext = 355036
          DataField = 'AltPhone'
          DataSource = frmSupplierSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          MaxLength = 20
          ParentFont = False
          TabOrder = 7
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object edtNotes: TDBMemo
          Left = 112
          Top = 195
          Width = 548
          Height = 178
          HelpContext = 355037
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataField = 'Notes'
          DataSource = frmSupplierSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
        end
        object txtMobile: TwwDBEdit
          Left = 491
          Top = 96
          Width = 169
          Height = 23
          HelpContext = 355038
          DataField = 'Mobile'
          DataSource = frmSupplierSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          MaxLength = 20
          ParentFont = False
          TabOrder = 8
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object btnAddDateTime: TDNMSpeedButton
          Left = 304
          Top = 378
          Width = 105
          Height = 27
          HelpContext = 355039
          Anchors = [akBottom]
          Caption = 'Add Date && Time'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 11
          AutoDisableParentOnclick = True
          OnClick = btnAddDateTimeClick
        end
        object btnOtherPhones: TDNMSpeedButton
          Left = 662
          Top = 10
          Width = 13
          Height = 23
          Hint = 'Other Phones'
          HelpContext = 355040
          Caption = '+'
          DisableTransparent = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 12
          AutoDisableParentOnclick = True
          OnClick = btnOtherPhonesClick
        end
        object edtSkypeName: TDBEdit
          Left = 491
          Top = 125
          Width = 169
          Height = 23
          HelpContext = 355195
          AutoSelect = False
          AutoSize = False
          DataField = 'skypename'
          DataSource = frmSupplierSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
        end
        object DBEdit19: TDBEdit
          Left = 491
          Top = 154
          Width = 78
          Height = 23
          HelpContext = 355279
          DataField = 'clientCode'
          DataSource = frmSupplierSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 13
        end
        object edtPrintName: TDBEdit
          Left = 176
          Top = 16
          Width = 160
          Height = 23
          HelpContext = 355287
          DataField = 'PrintName'
          DataSource = frmSupplierSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = edtPrintNameChange
          OnExit = edtPrintNameExit
        end
      end
    end
    object Address: TTabSheet
      HelpContext = 355041
      Caption = '&Address Info'
      ImageIndex = 6
      object pcAddress: TPageControl
        Left = 0
        Top = 0
        Width = 714
        Height = 414
        HelpContext = 355288
        ActivePage = tsEDI
        Align = alClient
        TabOrder = 0
        OnChange = pcAddressChange
        object tsSupplierAddress: TTabSheet
          HelpContext = 355289
          Caption = 'Supplier Address'
          object pnlAddress: TDNMPanel
            Left = 0
            Top = 0
            Width = 706
            Height = 384
            HelpContext = 355042
            Align = alClient
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            Transparent = False
            object DNMPanel5: TDNMPanel
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 346
              Height = 378
              HelpContext = 355263
              Align = alLeft
              BevelOuter = bvNone
              BorderWidth = 1
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              object Bevel12: TBevel
                AlignWithMargins = True
                Left = 4
                Top = 4
                Width = 338
                Height = 370
                HelpContext = 355264
                Align = alClient
                ExplicitLeft = 18
                ExplicitTop = 12
                ExplicitWidth = 349
                ExplicitHeight = 256
              end
              object Label2: TLabel
                Left = 20
                Top = 47
                Width = 66
                Height = 18
                HelpContext = 355053
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
              object Label39: TLabel
                Left = 92
                Top = 21
                Width = 104
                Height = 18
                HelpContext = 355052
                AutoSize = False
                Caption = 'Physical Address'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
                WordWrap = True
              end
              object Label180: TLabel
                Left = 20
                Top = 86
                Width = 66
                Height = 18
                HelpContext = 355051
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
              object Label20: TLabel
                Left = 20
                Top = 125
                Width = 66
                Height = 18
                HelpContext = 355060
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
              object lblSuburb: TLabel
                Left = 20
                Top = 164
                Width = 66
                Height = 18
                HelpContext = 355054
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
              object lblState: TLabel
                Left = 20
                Top = 203
                Width = 66
                Height = 18
                HelpContext = 355056
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
              object lblPostCode: TLabel
                Left = 20
                Top = 242
                Width = 66
                Height = 18
                HelpContext = 355055
                Alignment = taRightJustify
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
              object Label14: TLabel
                Left = 20
                Top = 281
                Width = 66
                Height = 18
                HelpContext = 355057
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
              object Street: TDBEdit
                Left = 92
                Top = 45
                Width = 237
                Height = 23
                HelpContext = 355067
                DataField = 'Street'
                DataSource = frmSupplierSrc
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 0
              end
              object Street2: TDBEdit
                Left = 92
                Top = 84
                Width = 237
                Height = 23
                HelpContext = 355068
                DataField = 'Street2'
                DataSource = frmSupplierSrc
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 1
              end
              object Street3: TDBEdit
                Left = 92
                Top = 123
                Width = 237
                Height = 23
                HelpContext = 355076
                DataField = 'Street3'
                DataSource = frmSupplierSrc
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 2
              end
              object Suburb: TwwDBLookupCombo
                Left = 92
                Top = 162
                Width = 237
                Height = 23
                HelpContext = 355071
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                DropDownAlignment = taLeftJustify
                Selected.Strings = (
                  'City_sub'#9'20'#9'Suburb'#9'T'
                  'State'#9'4'#9'State'#9'T'
                  'Postcode'#9'10'#9'Postcode'#9'T')
                DataField = 'Suburb'
                DataSource = frmSupplierSrc
                LookupTable = SuburbQry
                LookupField = 'City_sub'
                ParentFont = False
                TabOrder = 3
                AutoDropDown = True
                ShowButton = True
                UseTFields = False
                PreciseEditRegion = False
                AllowClearKey = False
                OnCloseUp = SuburbCloseUp
                OnEnter = SuburbEnter
              end
              object State: TDBEdit
                Left = 92
                Top = 201
                Width = 89
                Height = 23
                HelpContext = 355069
                DataField = 'State'
                DataSource = frmSupplierSrc
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 4
              end
              object Postcode: TDBEdit
                Left = 92
                Top = 240
                Width = 89
                Height = 23
                HelpContext = 355070
                DataField = 'Postcode'
                DataSource = frmSupplierSrc
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 5
              end
              object Country: TDBEdit
                Left = 92
                Top = 279
                Width = 237
                Height = 23
                HelpContext = 355073
                DataField = 'Country'
                DataSource = frmSupplierSrc
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 6
              end
              object cmdCopy: TDNMSpeedButton
                Left = 257
                Top = 238
                Width = 72
                Height = 26
                Hint = 
                  '"Copy the Details in the Physical Address to the Bill To Details' +
                  ' "'
                HelpContext = 355072
                Caption = 'Cop&y ==>'
                DisableTransparent = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                HotTrackFont.Charset = DEFAULT_CHARSET
                HotTrackFont.Color = clWindowText
                HotTrackFont.Height = -12
                HotTrackFont.Name = 'Arial'
                HotTrackFont.Style = []
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                TabOrder = 7
                AutoDisableParentOnclick = True
                OnClick = cmdCopyClick
              end
            end
            object DNMPanel7: TDNMPanel
              AlignWithMargins = True
              Left = 355
              Top = 3
              Width = 348
              Height = 378
              HelpContext = 355265
              Align = alClient
              BevelOuter = bvNone
              BorderWidth = 1
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
              object Bevel15: TBevel
                AlignWithMargins = True
                Left = 4
                Top = 4
                Width = 340
                Height = 370
                HelpContext = 355266
                Align = alClient
                ExplicitLeft = 0
                ExplicitTop = 16
                ExplicitWidth = 50
                ExplicitHeight = 50
              end
              object Label38: TLabel
                Left = 89
                Top = 24
                Width = 42
                Height = 16
                HelpContext = 355044
                AutoSize = False
                Caption = 'Bill To'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
                WordWrap = True
              end
              object Label42: TLabel
                Left = 26
                Top = 48
                Width = 56
                Height = 18
                HelpContext = 355045
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
              object Label187: TLabel
                Left = 16
                Top = 86
                Width = 66
                Height = 18
                HelpContext = 355046
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
              object Label21: TLabel
                Left = 16
                Top = 125
                Width = 66
                Height = 18
                HelpContext = 355061
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
              object lblBillSuburb: TLabel
                Left = 53
                Top = 164
                Width = 29
                Height = 18
                HelpContext = 355047
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
              object lblBillState: TLabel
                Left = 44
                Top = 203
                Width = 38
                Height = 18
                HelpContext = 355048
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
              object lblBillPostcode: TLabel
                Left = 20
                Top = 242
                Width = 62
                Height = 18
                HelpContext = 355049
                Alignment = taRightJustify
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
              object Label15: TLabel
                Left = 16
                Top = 281
                Width = 66
                Height = 18
                HelpContext = 355058
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
              object txtBillAddress: TDBEdit
                Left = 88
                Top = 46
                Width = 237
                Height = 23
                HelpContext = 355062
                DataField = 'BillStreet'
                DataSource = frmSupplierSrc
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 0
              end
              object txtBillAddress2: TDBEdit
                Left = 88
                Top = 84
                Width = 237
                Height = 23
                HelpContext = 355063
                DataField = 'BillStreet2'
                DataSource = frmSupplierSrc
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 1
              end
              object txtBillAddress3: TDBEdit
                Left = 88
                Top = 123
                Width = 237
                Height = 23
                HelpContext = 355077
                DataField = 'BillStreet3'
                DataSource = frmSupplierSrc
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 2
              end
              object BillSuburb: TwwDBLookupCombo
                Left = 88
                Top = 162
                Width = 237
                Height = 23
                HelpContext = 355066
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                DropDownAlignment = taLeftJustify
                Selected.Strings = (
                  'City_sub'#9'20'#9'Suburb'#9'T'
                  'State'#9'4'#9'State'#9'T'
                  'Postcode'#9'10'#9'Postcode'#9'T')
                DataField = 'BillSuburb'
                DataSource = frmSupplierSrc
                LookupTable = SuburbQry
                LookupField = 'City_sub'
                ParentFont = False
                TabOrder = 3
                AutoDropDown = True
                ShowButton = True
                UseTFields = False
                PreciseEditRegion = False
                AllowClearKey = False
                OnCloseUp = BillSuburbCloseUp
                OnEnter = SuburbEnter
              end
              object BillState: TDBEdit
                Left = 88
                Top = 201
                Width = 89
                Height = 23
                HelpContext = 355064
                DataField = 'BillState'
                DataSource = frmSupplierSrc
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 4
              end
              object BillPostcode: TDBEdit
                Left = 88
                Top = 240
                Width = 89
                Height = 23
                HelpContext = 355065
                DataField = 'BillPostcode'
                DataSource = frmSupplierSrc
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 5
              end
              object txtBillCountry: TDBEdit
                Left = 88
                Top = 279
                Width = 237
                Height = 23
                HelpContext = 355074
                DataField = 'BillCountry'
                DataSource = frmSupplierSrc
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 6
              end
            end
          end
        end
        object tsEDI: TTabSheet
          HelpContext = 355290
          Caption = 'EDI'
          ImageIndex = 1
          object DNMPanel8: TDNMPanel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 700
            Height = 378
            HelpContext = 355267
            Align = alClient
            BevelOuter = bvNone
            BorderWidth = 1
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object DNMPanel2: TDNMPanel
              AlignWithMargins = True
              Left = 324
              Top = 4
              Width = 372
              Height = 370
              Align = alClient
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              object Label50: TLabel
                Left = 71
                Top = 40
                Width = 72
                Height = 15
                Alignment = taRightJustify
                Caption = 'Vendor Code'
              end
              object Label25: TLabel
                Left = 92
                Top = 73
                Width = 51
                Height = 15
                Alignment = taRightJustify
                Caption = 'FTP User'
              end
              object Label45: TLabel
                Left = 90
                Top = 105
                Width = 53
                Height = 15
                Alignment = taRightJustify
                Caption = 'FTP Pass'
              end
              object Label49: TLabel
                Left = 81
                Top = 138
                Width = 62
                Height = 15
                Alignment = taRightJustify
                Caption = 'FTP Server'
              end
              object Label51: TLabel
                Left = 71
                Top = 170
                Width = 72
                Height = 15
                Alignment = taRightJustify
                Caption = 'FTP Send Dir'
              end
              object lblPOReceiveDir: TLabel
                Left = 55
                Top = 203
                Width = 88
                Height = 15
                Alignment = taRightJustify
                Caption = 'FTP Receive Dir'
              end
              object lblPOReceiveArchiveDir: TLabel
                Left = 9
                Top = 235
                Width = 134
                Height = 15
                Alignment = taRightJustify
                Caption = 'FTP Receive Archive Dir'
              end
              object lblPOFTPPort: TLabel
                Left = 95
                Top = 268
                Width = 48
                Height = 15
                Alignment = taRightJustify
                Caption = 'FTP Port'
              end
              object Label53: TLabel
                Left = 45
                Top = 300
                Width = 98
                Height = 15
                Alignment = taRightJustify
                Caption = 'Local Receive Dir'
              end
              object DBCheckBox3: TDBCheckBox
                Left = 150
                Top = 8
                Width = 203
                Height = 15
                HelpContext = 355275
                Caption = '  Send X12 POs Using CoreEDI'
                DataField = 'X12_POSendActive'
                DataSource = dsCoreEDIConfig
                TabOrder = 0
                ValueChecked = 'T'
                ValueUnchecked = 'F'
                OnClick = DBCheckBox2Click
              end
              object edtEDIVendorCode: TEdit
                Left = 150
                Top = 36
                Width = 203
                Height = 23
                HelpContext = 355272
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 1
                Text = 'edtEDIVendorCode'
                OnChange = edtEDIVendorCodeChange
              end
              object edtPOSendUser: TEdit
                Left = 150
                Top = 68
                Width = 203
                Height = 23
                HelpContext = 355272
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 2
                Text = 'edtPOSendUser'
                OnChange = edtPOSendUserChange
              end
              object edtPOSendPass: TEdit
                Left = 150
                Top = 101
                Width = 203
                Height = 23
                HelpContext = 355273
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 3
                Text = 'edtPOSendPass'
                OnChange = edtPOSendPassChange
              end
              object edtPOSendServer: TEdit
                Left = 150
                Top = 133
                Width = 203
                Height = 23
                HelpContext = 355274
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 4
                Text = 'edtPOSendServer'
                OnChange = edtPOSendServerChange
              end
              object edtPOSendDir: TEdit
                Left = 150
                Top = 166
                Width = 203
                Height = 23
                HelpContext = 355274
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 5
                Text = 'edtPOSendDir'
                OnChange = edtPOSendDirChange
              end
              object edtPOReceiveDir: TEdit
                Left = 150
                Top = 198
                Width = 203
                Height = 23
                HelpContext = 355274
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 9
                Text = 'edtPOReceiveDir'
                OnChange = edtPOReceiveDirChange
              end
              object edtPOReceiveArchiveDir: TEdit
                Left = 150
                Top = 231
                Width = 203
                Height = 23
                HelpContext = 355274
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 6
                Text = 'edtPOReceiveArchiveDir'
                OnChange = edtPOReceiveArchiveDirChange
              end
              object edtPOFTPPort: TEdit
                Left = 150
                Top = 263
                Width = 203
                Height = 23
                HelpContext = 355274
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 7
                Text = 'edtPOFTPPort'
                OnChange = edtPOFTPPortChange
              end
              object edtLocalReceiveDir: TEdit
                Left = 150
                Top = 296
                Width = 203
                Height = 23
                HelpContext = 355274
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 8
                Text = 'edtPOFTPPort'
                OnChange = edtLocalReceiveDirChange
              end
              object DNMSpeedButton1: TDNMSpeedButton
                Left = 150
                Top = 333
                Width = 203
                Height = 23
                Caption = 'Test Credentials'
                DisableTransparent = False
                HotTrackFont.Charset = DEFAULT_CHARSET
                HotTrackFont.Color = clWindowText
                HotTrackFont.Height = -12
                HotTrackFont.Name = 'Arial'
                HotTrackFont.Style = []
                TabOrder = 10
                AutoDisableParentOnclick = True
                OnClick = DNMSpeedButton1Click
              end
            end
            object DNMPanel9: TDNMPanel
              AlignWithMargins = True
              Left = 4
              Top = 4
              Width = 314
              Height = 370
              Align = alLeft
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
              object DNMPanel10: TDNMPanel
                AlignWithMargins = True
                Left = 4
                Top = 4
                Width = 306
                Height = 151
                Align = alTop
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
                object Label32: TLabel
                  Left = 57
                  Top = 56
                  Width = 35
                  Height = 15
                  HelpContext = 355091
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
                object Label41: TLabel
                  Left = 36
                  Top = 85
                  Width = 56
                  Height = 15
                  HelpContext = 355197
                  Caption = 'XMLEmail'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = 'Arial'
                  Font.Style = [fsBold]
                  ParentFont = False
                  Transparent = True
                end
                object Label16: TLabel
                  Left = 15
                  Top = 114
                  Width = 77
                  Height = 15
                  HelpContext = 355059
                  Caption = 'Web Address'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = 'Arial'
                  Font.Style = [fsBold]
                  ParentFont = False
                  Transparent = True
                end
                object DBCheckBox1: TDBCheckBox
                  AlignWithMargins = True
                  Left = 98
                  Top = 27
                  Width = 197
                  Height = 15
                  HelpContext = 355200
                  Caption = '  Send XML POs on PO Run '
                  DataField = 'SendXMLPOs'
                  DataSource = frmSupplierSrc
                  TabOrder = 0
                  ValueChecked = 'T'
                  ValueUnchecked = 'F'
                  OnClick = DBCheckBox1Click
                end
                object edtURL: TDBEdit
                  Left = 98
                  Top = 110
                  Width = 197
                  Height = 23
                  HelpContext = 355075
                  DataField = 'URL'
                  DataSource = frmSupplierSrc
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlue
                  Font.Height = -12
                  Font.Name = 'Arial'
                  Font.Style = [fsUnderline]
                  ParentFont = False
                  TabOrder = 1
                  OnDblClick = edtURLDblClick
                end
                object XMLEmail: TDBEdit
                  Left = 98
                  Top = 81
                  Width = 197
                  Height = 23
                  HelpContext = 355199
                  DataField = 'EmailPOXML'
                  DataSource = frmSupplierSrc
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = 'Arial'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 2
                end
                object Email: TDBEdit
                  Left = 98
                  Top = 52
                  Width = 197
                  Height = 23
                  HelpContext = 355106
                  DataField = 'Email'
                  DataSource = frmSupplierSrc
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = 'Arial'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 3
                end
              end
              object DNMPanel11: TDNMPanel
                AlignWithMargins = True
                Left = 4
                Top = 161
                Width = 306
                Height = 151
                Align = alTop
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 1
                object Label47: TLabel
                  Left = 45
                  Top = 45
                  Width = 51
                  Height = 15
                  HelpContext = 355269
                  Caption = 'FTP User'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = 'Arial'
                  Font.Style = [fsBold]
                  ParentFont = False
                  Transparent = True
                end
                object Label48: TLabel
                  Left = 43
                  Top = 74
                  Width = 53
                  Height = 15
                  HelpContext = 355270
                  Caption = 'FTP Pass'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = 'Arial'
                  Font.Style = [fsBold]
                  ParentFont = False
                  Transparent = True
                end
                object Label46: TLabel
                  Left = 24
                  Top = 103
                  Width = 72
                  Height = 15
                  HelpContext = 355271
                  Caption = 'FTP Address'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = 'Arial'
                  Font.Style = [fsBold]
                  ParentFont = False
                  Transparent = True
                end
                object DBCheckBox2: TDBCheckBox
                  Left = 100
                  Top = 19
                  Width = 197
                  Height = 15
                  HelpContext = 355275
                  Caption = '  Send FTP XML POs on PO Run '
                  DataField = 'SendFTPXMLPOs'
                  DataSource = frmSupplierSrc
                  TabOrder = 0
                  ValueChecked = 'T'
                  ValueUnchecked = 'F'
                  OnClick = DBCheckBox2Click
                end
                object FTPUserName: TDBEdit
                  Left = 100
                  Top = 41
                  Width = 197
                  Height = 23
                  HelpContext = 355272
                  DataField = 'FTPUserName'
                  DataSource = frmSupplierSrc
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = 'Arial'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 1
                end
                object FTPAddress: TDBEdit
                  Left = 100
                  Top = 99
                  Width = 197
                  Height = 23
                  HelpContext = 355274
                  DataField = 'FTPAddress'
                  DataSource = frmSupplierSrc
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = 'Arial'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 2
                end
                object FTPPassword: TDBEdit
                  Left = 100
                  Top = 70
                  Width = 197
                  Height = 23
                  HelpContext = 355273
                  DataField = 'FTPPassword'
                  DataSource = frmSupplierSrc
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = 'Arial'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 3
                end
              end
            end
          end
        end
      end
    end
    object General: TTabSheet
      HelpContext = 355078
      Caption = 'General'
      ImageIndex = 7
      object DNMPanel6: TDNMPanel
        Left = 0
        Top = 0
        Width = 714
        Height = 414
        HelpContext = 355079
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        Transparent = False
        object Bevel17: TBevel
          Left = 550
          Top = 5
          Width = 156
          Height = 50
          HelpContext = 355083
        end
        object Bevel3: TBevel
          Left = 322
          Top = 319
          Width = 219
          Height = 34
          HelpContext = 355087
        end
        object Bevel16: TBevel
          Left = 322
          Top = 106
          Width = 219
          Height = 118
          HelpContext = 355085
        end
        object Bevel13: TBevel
          Left = 550
          Top = 219
          Width = 156
          Height = 97
          HelpContext = 355080
        end
        object Box71: TBevel
          Left = 11
          Top = 5
          Width = 305
          Height = 109
          HelpContext = 355086
        end
        object Bevel1: TBevel
          Left = 322
          Top = 5
          Width = 219
          Height = 50
          HelpContext = 355252
        end
        object Bevel11: TBevel
          Left = 550
          Top = 165
          Width = 156
          Height = 50
          HelpContext = 355253
        end
        object Bevel9: TBevel
          Left = 11
          Top = 120
          Width = 305
          Height = 103
          HelpContext = 355081
        end
        object Bevel4: TBevel
          Left = 11
          Top = 228
          Width = 305
          Height = 125
          HelpContext = 355082
        end
        object Bevel8: TBevel
          Left = 550
          Top = 58
          Width = 156
          Height = 50
          HelpContext = 355254
        end
        object Label9: TLabel
          Left = 62
          Top = 236
          Width = 94
          Height = 15
          HelpContext = 355084
          Alignment = taRightJustify
          Caption = 'Shipping Method'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Bevel7: TBevel
          Left = 322
          Top = 57
          Width = 219
          Height = 47
          HelpContext = 355255
        end
        object Box76: TBevel
          Left = 322
          Top = 228
          Width = 219
          Height = 87
          HelpContext = 355256
        end
        object Label56: TLabel
          Left = 46
          Top = 15
          Width = 71
          Height = 16
          HelpContext = 355088
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Account No'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label52: TLabel
          Left = 67
          Top = 50
          Width = 50
          Height = 16
          HelpContext = 355089
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Terms'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label65: TLabel
          Left = 326
          Top = 63
          Width = 24
          Height = 15
          HelpContext = 355090
          Caption = 'ABN'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label163: TLabel
          Left = 326
          Top = 12
          Width = 86
          Height = 15
          HelpContext = 355092
          Caption = 'Representative '
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
          Left = 554
          Top = 61
          Width = 98
          Height = 15
          HelpContext = 355093
          Caption = 'Correspondence:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label7: TLabel
          Left = 18
          Top = 267
          Width = 176
          Height = 15
          HelpContext = 355094
          Caption = 'Normal Shipping Time (In Days)'
          Transparent = True
        end
        object Label10: TLabel
          Left = 18
          Top = 129
          Width = 129
          Height = 16
          HelpContext = 355095
          AutoSize = False
          Caption = 'Bank Account Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object lblBSB: TLabel
          Left = 20
          Top = 175
          Width = 24
          Height = 15
          HelpContext = 355096
          Caption = 'BSB'
          Transparent = True
        end
        object Label12: TLabel
          Left = 99
          Top = 175
          Width = 65
          Height = 15
          HelpContext = 355097
          Caption = 'Account No'
          Transparent = True
        end
        object Bevel10: TBevel
          Left = 550
          Top = 111
          Width = 156
          Height = 50
          HelpContext = 355098
        end
        object Label17: TLabel
          Left = 554
          Top = 114
          Width = 95
          Height = 15
          HelpContext = 355099
          Caption = 'Payment Method'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label18: TLabel
          Left = 214
          Top = 175
          Width = 89
          Height = 16
          HelpContext = 355100
          AutoSize = False
          Caption = 'Bank Code'
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
          Left = 554
          Top = 167
          Width = 97
          Height = 15
          HelpContext = 355101
          Caption = 'Foreign Currency'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label5: TLabel
          Left = 39
          Top = 299
          Width = 115
          Height = 15
          HelpContext = 355102
          Caption = 'Default PO Template'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label23: TLabel
          Left = 18
          Top = 331
          Width = 138
          Height = 15
          HelpContext = 355201
          Caption = 'Show in Ship Containers'
        end
        object Label24: TLabel
          Left = 326
          Top = 235
          Width = 71
          Height = 15
          HelpContext = 355257
          Caption = 'BPAY Details'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          Transparent = True
        end
        object Label26: TLabel
          Left = 326
          Top = 263
          Width = 61
          Height = 15
          HelpContext = 355258
          Caption = 'Biller Code'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label28: TLabel
          Left = 328
          Top = 293
          Width = 59
          Height = 15
          HelpContext = 355259
          Caption = 'Reference'
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
          Left = 554
          Top = 220
          Width = 65
          Height = 15
          HelpContext = 355202
          Caption = 'Call Priority'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label11: TLabel
          Left = 554
          Top = 273
          Width = 132
          Height = 15
          HelpContext = 355203
          Caption = 'Default Contact Method'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label30: TLabel
          Left = 326
          Top = 111
          Width = 120
          Height = 15
          HelpContext = 355204
          Caption = 'Purchase Comments'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label36: TLabel
          Left = 24
          Top = 86
          Width = 93
          Height = 15
          HelpContext = 355205
          Alignment = taRightJustify
          Caption = 'Credit Limit ($'#39's)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblArea: TLabel
          Left = 343
          Top = 328
          Width = 75
          Height = 15
          HelpContext = 355206
          Alignment = taRightJustify
          Caption = 'Area Number'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblAccount: TLabel
          Left = 554
          Top = 8
          Width = 112
          Height = 15
          HelpContext = 355207
          Caption = 'Default A/P Account'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label44: TLabel
          Left = 199
          Top = 129
          Width = 113
          Height = 16
          HelpContext = 355276
          AutoSize = False
          Caption = 'Bank Lodgment Ref'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Bevel19: TBevel
          Left = 550
          Top = 319
          Width = 156
          Height = 34
          HelpContext = 355284
        end
        object lblContractor: TLabel
          Left = 208
          Top = 86
          Width = 73
          Height = 15
          HelpContext = 355293
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Contractor'
        end
        object cboShipping: TwwDBLookupCombo
          Left = 162
          Top = 232
          Width = 139
          Height = 23
          Hint = '"Select The Shipping Method For This Supplier"'
          HelpContext = 355103
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'ShippingMethod'#9'20'#9'ShippingMethod'#9#9)
          DataField = 'ShippingMethod'
          DataSource = frmSupplierSrc
          LookupTable = cboShippingQry
          LookupField = 'ShippingMethod'
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnEnter = cboShippingEnter
        end
        object AccountNo: TDBEdit
          Left = 123
          Top = 12
          Width = 180
          Height = 23
          HelpContext = 355104
          DataField = 'ClientNo'
          DataSource = frmSupplierSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnKeyPress = AccountNoKeyPress
        end
        object ABN: TDBEdit
          Left = 326
          Top = 78
          Width = 163
          Height = 23
          HelpContext = 355105
          DataField = 'ABN'
          DataSource = frmSupplierSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          MaxLength = 14
          ParentFont = False
          TabOrder = 12
        end
        object Terms: TwwDBLookupCombo
          Left = 123
          Top = 47
          Width = 180
          Height = 23
          Hint = '"What Are Your Trading Terms For This Supplier"'
          HelpContext = 355107
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Terms'#9'30'#9'Terms'#9'F')
          DataField = 'TermsID'
          DataSource = frmSupplierSrc
          LookupTable = cboTermsQry
          LookupField = 'TermsID'
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnCloseUp = TermsCloseUp
        end
        object cboCorrespondence: TwwDBComboBox
          Left = 554
          Top = 77
          Width = 146
          Height = 23
          HelpContext = 355108
          ShowButton = True
          Style = csDropDown
          MapList = False
          AllowClearKey = False
          AutoDropDown = True
          DataField = 'CorrespondenceMethod'
          DataSource = frmSupplierSrc
          DropDownCount = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 15
          Items.Strings = (
            'Fax'
            'Email'
            'Post')
          ParentFont = False
          Sorted = False
          TabOrder = 18
          UnboundDataType = wwDefault
        end
        object cboRep: TwwDBLookupCombo
          Left = 326
          Top = 27
          Width = 193
          Height = 23
          Hint = '"Who Is The Rep For This Customer"'
          HelpContext = 355109
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'EmployeeName'#9'46'#9'EmployeeName'#9'F'#9)
          DataField = 'RepID'
          DataSource = frmSupplierSrc
          LookupTable = qryEmpID
          LookupField = 'EmployeeID'
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 11
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnChange = cboRepChange
        end
        object edtNormShipTime: TwwDBSpinEdit
          Left = 235
          Top = 264
          Width = 66
          Height = 23
          HelpContext = 355110
          Increment = 1.000000000000000000
          MaxValue = 999.000000000000000000
          DataField = 'ShipTime'
          DataSource = frmSupplierSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
          UnboundDataType = wwDefault
        end
        object edtBankAccName: TwwDBEdit
          Left = 16
          Top = 146
          Width = 175
          Height = 23
          HelpContext = 355111
          DataField = 'BankAccountName'
          DataSource = frmSupplierSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object edtBankAccBSB: TwwDBEdit
          Left = 18
          Top = 193
          Width = 75
          Height = 23
          HelpContext = 355112
          DataField = 'BankAccountBSB'
          DataSource = frmSupplierSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          MaxLength = 7
          ParentFont = False
          Picture.PictureMaskFromDataSet = False
          Picture.AutoFill = False
          Picture.AllowInvalidExit = True
          TabOrder = 4
          UnboundDataType = wwDefault
          WantReturns = True
          WordWrap = False
        end
        object cboPaymentMethod: TwwDBLookupCombo
          Left = 554
          Top = 130
          Width = 146
          Height = 23
          HelpContext = 355113
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taRightJustify
          Selected.Strings = (
            'Name'#9'30'#9'Name'#9'F')
          DataField = 'PayMethodID'
          DataSource = frmSupplierSrc
          LookupTable = qryPayMethod
          LookupField = 'PayMethodID'
          Style = csDropDownList
          DropDownCount = 5
          DropDownWidth = 150
          ParentFont = False
          TabOrder = 19
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = True
        end
        object cboBankCode: TwwDBLookupCombo
          Left = 214
          Top = 193
          Width = 98
          Height = 23
          HelpContext = 355114
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'BankCode'#9'4'#9'Bank Code'#9'F'
            'BankName'#9'30'#9'BankName'#9'F')
          DataField = 'BankCode'
          DataSource = frmSupplierSrc
          LookupTable = qryBankCodes
          LookupField = 'BankCode'
          DropDownWidth = 300
          ParentFont = False
          TabOrder = 6
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnEnter = cboBankCodeEnter
        end
        object cboForeignCurrencyCode: TwwDBLookupCombo
          Left = 554
          Top = 183
          Width = 146
          Height = 26
          HelpContext = 355115
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Code'#9'5'#9'Code'#9'F'
            'Country'#9'25'#9'Country'#9'F'#9
            'Currency'#9'15'#9'Currency'#9'F')
          DataField = 'ForeignExchangeSellCode'
          DataSource = frmSupplierSrc
          LookupTable = qryForeignCurrency
          LookupField = 'Code'
          Style = csDropDownList
          ParentFont = False
          TabOrder = 20
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
        object wwDBLookupCombo1: TwwDBLookupCombo
          Left = 160
          Top = 296
          Width = 139
          Height = 23
          Hint = '"Select The Shipping Method For This Supplier"'
          HelpContext = 355117
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'TemplName'#9'30'#9'TemplName'#9'T')
          DataField = 'DefaultPurchaseOrderTemplateID'
          DataSource = frmSupplierSrc
          LookupTable = qryTemplates
          LookupField = 'TemplID'
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 9
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = True
          OnEnter = cboShippingEnter
        end
        object chkShowInShipContainers: TwwCheckBox
          Left = 162
          Top = 330
          Width = 17
          Height = 17
          HelpContext = 355208
          DisableThemes = False
          AlwaysTransparent = False
          ValueChecked = 'T'
          ValueUnchecked = 'F'
          DisplayValueChecked = 'T'
          DisplayValueUnchecked = 'F'
          NullAndBlankState = cbUnchecked
          DataField = 'ShowInShipContainers'
          DataSource = frmSupplierSrc
          TabOrder = 10
        end
        object edtBPAYBiller: TDBEdit
          Left = 398
          Top = 259
          Width = 121
          Height = 23
          HelpContext = 355209
          DataField = 'BPAYBillerCode'
          DataSource = frmSupplierSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 15
        end
        object edtBPAYReference: TDBEdit
          Left = 398
          Top = 289
          Width = 137
          Height = 23
          HelpContext = 355210
          DataField = 'BPAYReference'
          DataSource = frmSupplierSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 16
        end
        object edtBankAccNo: TwwDBEdit
          Left = 99
          Top = 193
          Width = 110
          Height = 23
          HelpContext = 355116
          AutoSelect = False
          AutoSize = False
          DataField = 'BankAccountNo'
          DataSource = frmSupplierSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          MaxLength = 7
          ParentFont = False
          TabOrder = 5
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          OnMouseUp = edtBankAccNoMouseUp
        end
        object wwDBComboBox1: TwwDBComboBox
          Left = 554
          Top = 236
          Width = 146
          Height = 23
          HelpContext = 355211
          ShowButton = True
          Style = csDropDownList
          MapList = True
          AllowClearKey = False
          AutoDropDown = True
          AutoFillDate = False
          DataField = 'CallPriority'
          DataSource = frmSupplierSrc
          DropDownCount = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 0
          Items.Strings = (
            '10 - High'#9'10'
            '9'#9'9'
            '8'#9'8'
            '7'#9'7'
            '6'#9'6'
            '5  - Standard'#9'5'
            '4'#9'4'
            '3'#9'3'
            '2'#9'2'
            '1'#9'1'
            '0  - Low'#9'0')
          ParentFont = False
          Sorted = False
          TabOrder = 21
          UnboundDataType = wwDefault
          UnboundAlignment = taCenter
        end
        object cboDefaultContactMethod: TwwDBComboBox
          Left = 554
          Top = 289
          Width = 146
          Height = 23
          HelpContext = 355212
          ShowButton = True
          Style = csDropDownList
          MapList = False
          AllowClearKey = False
          DataField = 'DefaultContactMethod'
          DataSource = frmSupplierSrc
          DropDownCount = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 0
          Items.Strings = (
            'Email'
            'Fax'
            'Print'
            'Phone'
            'Mobile'
            'Visit')
          ParentFont = False
          Sorted = False
          TabOrder = 22
          UnboundDataType = wwDefault
        end
        object memoSalesComments: TDBMemo
          Left = 326
          Top = 129
          Width = 210
          Height = 93
          HelpContext = 355213
          DataField = 'POComment'
          DataSource = frmSupplierSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 14
        end
        object wwCheckBox1: TwwCheckBox
          Left = 478
          Top = 110
          Width = 57
          Height = 17
          HelpContext = 355214
          DisableThemes = False
          AlwaysTransparent = True
          Frame.Enabled = True
          Frame.Transparent = True
          Frame.FocusBorders = []
          Frame.NonFocusBorders = []
          ValueChecked = 'T'
          ValueUnchecked = 'F'
          DisplayValueChecked = 'T'
          DisplayValueUnchecked = 'F'
          NullAndBlankState = cbUnchecked
          Caption = 'PopUp'
          DataField = 'POCommentPopup'
          DataSource = frmSupplierSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 13
        end
        object CreditLimit: TwwDBEdit
          Left = 123
          Top = 82
          Width = 79
          Height = 23
          HelpContext = 355215
          DataField = 'SupplierCreditLimit'
          DataSource = frmSupplierSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object cboAreaCode: TwwDBLookupCombo
          Left = 424
          Top = 324
          Width = 88
          Height = 23
          HelpContext = 355216
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'AreaCode'#9'10'#9'code'#9'F'
            'AreaName'#9'20'#9'Name'#9'F')
          DataField = 'Area'
          DataSource = frmSupplierSrc
          LookupTable = QryAreaCodes
          LookupField = 'AreaCode'
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 17
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
        object cboDefaultAPAccountName: TwwDBLookupCombo
          Left = 554
          Top = 25
          Width = 146
          Height = 23
          HelpContext = 355217
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          DataField = 'DefaultAPAccountName'
          DataSource = frmSupplierSrc
          LookupTable = QryAPAccounts
          LookupField = 'AccountName'
          ParentFont = False
          TabOrder = 23
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnCloseUp = cboDefaultAPAccountNameCloseUp
        end
        object edtBankLodgementRef: TwwDBEdit
          Left = 197
          Top = 146
          Width = 115
          Height = 23
          HelpContext = 355277
          DataField = 'BankLodgementRef'
          DataSource = frmSupplierSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 24
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object chkIgnoreSupplierforProductLatestCost: TDBCheckBox
          Left = 554
          Top = 322
          Width = 146
          Height = 30
          HelpContext = 355285
          Caption = 'Ignore Purchases for Product Latest Cost'
          DataField = 'IgnoreSupplierforProductLatestCost'
          DataSource = frmSupplierSrc
          TabOrder = 25
          ValueChecked = 'T'
          ValueUnchecked = 'F'
          WordWrap = True
        end
        object wwCheckBox2: TwwCheckBox
          Left = 287
          Top = 85
          Width = 17
          Height = 17
          HelpContext = 355294
          DisableThemes = False
          AlwaysTransparent = False
          ValueChecked = 'T'
          ValueUnchecked = 'F'
          DisplayValueChecked = 'T'
          DisplayValueUnchecked = 'F'
          NullAndBlankState = cbUnchecked
          DataField = 'Contractor'
          DataSource = frmSupplierSrc
          TabOrder = 26
        end
      end
    end
    object History: TTabSheet
      HelpContext = 355118
      Caption = '&History'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic, fsUnderline]
      ParentFont = False
      object pnlHistory: TDNMPanel
        Left = 0
        Top = 0
        Width = 714
        Height = 414
        HelpContext = 355119
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Transparent = False
        object grpHistory: TRadioGroup
          Left = 0
          Top = 0
          Width = 714
          Height = 41
          HelpContext = 355120
          Align = alTop
          Color = 13296639
          Columns = 5
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Items.Strings = (
            'Supp Statement'
            'Purchase Orders'
            'Bills'
            'Cheques'
            'Payments')
          ParentColor = False
          ParentFont = False
          TabOrder = 0
          OnClick = grpHistoryClick
        end
      end
    end
    object Contacts: TTabSheet
      HelpContext = 355121
      Caption = 'Co&ntacts'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic, fsUnderline]
      ParentFont = False
      object DNMPanel3: TDNMPanel
        Left = 0
        Top = 0
        Width = 714
        Height = 414
        HelpContext = 355122
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Transparent = False
        DesignSize = (
          714
          414)
        object Bevel2: TBevel
          Left = 0
          Top = 8
          Width = 712
          Height = 405
          HelpContext = 355123
          Anchors = [akLeft, akTop, akRight, akBottom]
          ExplicitHeight = 322
        end
        object Label22: TLabel
          Left = 28
          Top = 390
          Width = 133
          Height = 15
          HelpContext = 355218
          Anchors = [akLeft, akBottom]
          Caption = 'Show inactive Contacts'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitTop = 307
        end
        object letterflag: TCheckBox
          Left = 592
          Top = 71
          Width = 11
          Height = 11
          HelpContext = 355127
          TabStop = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic, fsUnderline]
          ParentFont = False
          TabOrder = 7
          Visible = False
        end
        object Faxflag: TCheckBox
          Left = 593
          Top = 104
          Width = 11
          Height = 11
          HelpContext = 355128
          TabStop = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic, fsUnderline]
          ParentFont = False
          TabOrder = 8
          Visible = False
        end
        object Emailflag: TCheckBox
          Left = 431
          Top = 137
          Width = 17
          Height = 16
          HelpContext = 355129
          TabStop = False
          Anchors = [akTop, akRight]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic, fsUnderline]
          ParentFont = False
          TabOrder = 9
          Visible = False
        end
        object chkShowAll: TCheckBox
          Left = 8
          Top = 388
          Width = 15
          Height = 17
          HelpContext = 355131
          Anchors = [akLeft, akBottom]
          Color = 13559295
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          TabOrder = 6
          OnClick = chkShowAllClick
        end
        object CNewbtn: TDNMSpeedButton
          Left = 590
          Top = 183
          Width = 119
          Height = 27
          Hint = '"Add A New Contact"'
          HelpContext = 355132
          Anchors = [akTop, akRight]
          Caption = 'New'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10485760
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          AutoDisableParentOnclick = True
          OnClick = CNewbtnClick
        end
        object Emailbtn: TDNMSpeedButton
          Left = 590
          Top = 92
          Width = 119
          Height = 27
          Hint = '"Emai To The Selected Contact"'
          HelpContext = 355133
          Anchors = [akTop, akRight]
          Caption = 'E-Mail'
          DisableTransparent = False
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4210688
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          AutoDisableParentOnclick = True
          OnClick = EmailbtnClick
        end
        object Faxbtn: TDNMSpeedButton
          Left = 590
          Top = 59
          Width = 119
          Height = 27
          Hint = '"Fax The Selected Contact"'
          HelpContext = 355134
          Anchors = [akTop, akRight]
          Caption = '&Fax'
          DisableTransparent = False
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4210688
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          AutoDisableParentOnclick = True
          OnClick = FaxbtnClick
        end
        object Letterbtn: TDNMSpeedButton
          Left = 590
          Top = 26
          Width = 119
          Height = 27
          Hint = '"Write To The Selected Contact"'
          HelpContext = 355135
          Anchors = [akTop, akRight]
          Caption = '&Letter'
          DisableTransparent = False
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4210688
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          AutoDisableParentOnclick = True
          OnClick = LetterbtnClick
        end
        object Editbtn: TDNMSpeedButton
          Left = 590
          Top = 150
          Width = 119
          Height = 27
          Hint = '"Edit The Selected Contact"'
          HelpContext = 355136
          Anchors = [akTop, akRight]
          Caption = '&Edit'
          DisableTransparent = False
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10485760
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          AutoDisableParentOnclick = True
          OnClick = EditbtnClick
        end
        object grdContact: TwwDBGrid
          Left = 6
          Top = 15
          Width = 580
          Height = 365
          HelpContext = 355219
          ControlType.Strings = (
            'UseOnRun;CheckBox;T;F'
            'isPrimarycontact;CheckBox;T;F'
            'IsPrimarycontact;CheckBox;T;F')
          Selected.Strings = (
            'ContactName'#9'20'#9'Contact'#9'T'
            'ContactPH'#9'13'#9'Phone'#9'T'
            'ContactFax'#9'13'#9'Fax'#9'T'
            'ContactMOB'#9'13'#9'Mobile'#9'T'
            'isPrimarycontact'#9'1'#9'Primary Contact?'#9'F')
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          OnRowChanged = grdContactRowChanged
          FixedCols = 0
          ShowHorzScrollBar = True
          Anchors = [akLeft, akTop, akRight, akBottom]
          Color = clWhite
          DataSource = DSContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          KeyOptions = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
          ParentFont = False
          TabOrder = 0
          TitleAlignment = taCenter
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = False
          UseTFields = False
          OnDblClick = EditbtnClick
          OnKeyUp = grdContactKeyUp
          OnFieldChanged = grdContactFieldChanged
          object wwIButton1: TwwIButton
            Left = 0
            Top = 0
            Width = 22
            Height = 22
            Hint = 'Click this button to Deactivate the selected contact'
            HelpContext = 355220
            AllowAllUp = True
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
            NumGlyphs = 2
            ParentShowHint = False
            ShowHint = True
            OnClick = btnInactiveClick
          end
        end
      end
    end
    object Documents: TTabSheet
      HelpContext = 355137
      Caption = '&Documents'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic, fsUnderline]
      ParentFont = False
      object pnlDocuments: TDNMPanel
        Left = 0
        Top = 0
        Width = 714
        Height = 377
        HelpContext = 355221
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Transparent = False
        DesignSize = (
          714
          377)
        object Label66: TLabel
          Left = 885
          Top = 256
          Width = 183
          Height = 14
          HelpContext = 355222
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = 'Drag and drop attachments into list'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object pnlDocumentsInner: TDNMPanel
          Left = 3
          Top = 6
          Width = 708
          Height = 520
          HelpContext = 355223
          Anchors = [akLeft, akTop, akRight, akBottom]
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Splitter1: TSplitter
            Left = 0
            Top = 156
            Width = 708
            Height = 3
            Cursor = crVSplit
            HelpContext = 355224
            Align = alTop
            ExplicitTop = 177
            ExplicitWidth = 225
          end
          object pnlDocumentsList: TDNMPanel
            Left = 0
            Top = 0
            Width = 708
            Height = 156
            HelpContext = 355225
            Align = alTop
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            DesignSize = (
              708
              156)
            object Label96: TLabel
              Left = 120
              Top = 6
              Width = 147
              Height = 15
              HelpContext = 355226
              Caption = 'Show inactive Documents'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label37: TLabel
              Left = 528
              Top = 9
              Width = 178
              Height = 13
              HelpContext = 355227
              Alignment = taRightJustify
              Anchors = [akTop, akRight]
              Caption = 'Double click to open correspondence'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object grdCorrespondence: TwwDBGrid
              Left = 1
              Top = 31
              Width = 705
              Height = 124
              HelpContext = 355228
              ControlType.Strings = (
                'active;CheckBox;T;F'
                'Active;CheckBox;T;F')
              Selected.Strings = (
                'Ref_Date'#9'12'#9'Date'#9'F'
                'Contact'#9'16'#9'Contact'#9'F'
                'Ref_type'#9'10'#9'Type'#9'F'
                'Referencetxt'#9'20'#9'Reference'#9'F'
                'MessageFrom'#9'15'#9'From'#9'F'
                'MessageTo'#9'15'#9'To'#9'F'
                'active'#9'1'#9'Active'#9'F')
              IniAttributes.Delimiter = ';;'
              TitleColor = clWhite
              OnRowChanged = grdCorrespondenceRowChanged
              FixedCols = 0
              ShowHorzScrollBar = True
              Anchors = [akLeft, akTop, akRight, akBottom]
              Color = clWhite
              DataSource = DSDocuments
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              KeyOptions = []
              Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
              ParentFont = False
              ReadOnly = True
              TabOrder = 0
              TitleAlignment = taLeftJustify
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -12
              TitleFont.Name = 'Arial'
              TitleFont.Style = [fsBold]
              TitleLines = 1
              TitleButtons = False
              UseTFields = False
              OnDblClick = grdCorrespondenceDblClick
              OnFieldChanged = grdCorrespondenceFieldChanged
              FooterColor = clWhite
              FooterCellColor = clWhite
              object grdDocsIButton: TwwIButton
                Left = 0
                Top = 0
                Width = 18
                Height = 22
                HelpContext = 355229
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
                OnClick = grdDocsIButtonClick
              end
            end
            object btnGetEmails: TButton
              Left = 1
              Top = 1
              Width = 75
              Height = 25
              HelpContext = 355230
              Caption = 'Get Emails'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
              OnClick = btnGetEmailsClick
            end
            object chkdocuments: TCheckBox
              Left = 99
              Top = 5
              Width = 15
              Height = 17
              HelpContext = 355231
              Color = 14867920
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
              TabOrder = 2
              OnClick = chkdocumentsClick
            end
          end
          object pnlDocumentsMessage: TDNMPanel
            Left = 0
            Top = 159
            Width = 708
            Height = 361
            HelpContext = 355232
            Align = alClient
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            DesignSize = (
              708
              361)
            object HtmlViewer: THtmlViewer
              Left = 1
              Top = 2
              Width = 704
              Height = 157
              HelpContext = 355233
              TabOrder = 0
              Anchors = [akLeft, akTop, akRight, akBottom]
              BorderStyle = htFocused
              CharSet = DEFAULT_CHARSET
              DefBackground = clWhite
              DefFontName = 'Arial'
              DefFontSize = 9
              DefPreFontName = 'Courier New'
              HistoryMaxCount = 0
              NoSelect = False
              PrintMarginBottom = 2.000000000000000000
              PrintMarginLeft = 2.000000000000000000
              PrintMarginRight = 2.000000000000000000
              PrintMarginTop = 2.000000000000000000
              PrintScale = 1.000000000000000000
              QuirksMode = qmDetect
              OnHotSpotClick = HtmlViewerHotSpotClick
              OnImageRequest = HtmlViewerImageRequest
            end
            object lvAttachments: TListView
              Left = 1
              Top = 162
              Width = 705
              Height = 49
              HelpContext = 355234
              Anchors = [akLeft, akRight, akBottom]
              Columns = <>
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              ViewStyle = vsSmallIcon
              OnDblClick = lvAttachmentsDblClick
            end
          end
        end
      end
      object pnlDocsBottom: TDNMPanel
        Left = 0
        Top = 377
        Width = 714
        Height = 37
        HelpContext = 355280
        Align = alBottom
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object lblDocumentPath: TDBText
          Left = 217
          Top = 12
          Width = 492
          Height = 15
          HelpContext = 355281
          DataField = 'cDocumentPath'
          DataSource = frmSupplierSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object btnOpenDocumentPath: TDNMSpeedButton
          Left = 6
          Top = 6
          Width = 93
          Height = 27
          HelpContext = 355282
          Caption = 'Open Doc Path'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 0
          AutoDisableParentOnclick = True
          OnClick = btnOpenDocumentPathClick
        end
        object btnSetDocumentPath: TDNMSpeedButton
          Left = 113
          Top = 6
          Width = 93
          Height = 27
          HelpContext = 355283
          Caption = 'Set Doc Path'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 1
          AutoDisableParentOnclick = True
          OnClick = btnSetDocumentPathClick
        end
      end
    end
    object Custom_Fields: TTabSheet
      HelpContext = 355143
      Caption = 'Custom Fields'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic, fsUnderline]
      ParentFont = False
      object pgCustomFields: TPageControl
        Left = 0
        Top = 0
        Width = 714
        Height = 414
        HelpContext = 355235
        ActivePage = TabSheet1
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        TabWidth = 355
        object tabCustomFields: TTabSheet
          HelpContext = 355236
          Caption = 'Customisable List'
          object pnlcustomfieldList: TDNMPanel
            Left = 0
            Top = 0
            Width = 706
            Height = 384
            HelpContext = 355237
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object DNMPanel4: TDNMPanel
              Left = 1
              Top = 1
              Width = 704
              Height = 34
              HelpContext = 355238
              Align = alTop
              Caption = 'Customisable List'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clMaroon
              Font.Height = -19
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
            end
          end
        end
        object TabSheet1: TTabSheet
          HelpContext = 355239
          Caption = 'Customisable Fields'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          ImageIndex = 1
          ParentFont = False
          object pnlCustFields: TDNMPanel
            Left = 0
            Top = 0
            Width = 706
            Height = 384
            HelpContext = 355144
            Align = alClient
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            Transparent = False
            object Box181: TBevel
              Left = 4
              Top = 52
              Width = 703
              Height = 245
              HelpContext = 355145
            end
            object Bevel14: TBevel
              Left = 276
              Top = 8
              Width = 206
              Height = 32
              HelpContext = 355146
              Style = bsRaised
            end
            object CUSTLBL1: TLabel
              Left = 98
              Top = 68
              Width = 3
              Height = 15
              HelpContext = 355147
              Alignment = taRightJustify
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object CUSTLBL2: TLabel
              Left = 98
              Top = 102
              Width = 3
              Height = 15
              HelpContext = 355148
              Alignment = taRightJustify
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object CUSTLBL3: TLabel
              Left = 98
              Top = 137
              Width = 3
              Height = 15
              HelpContext = 355149
              Alignment = taRightJustify
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object CUSTLBL4: TLabel
              Left = 98
              Top = 172
              Width = 3
              Height = 15
              HelpContext = 355150
              Alignment = taRightJustify
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object CUSTLBL5: TLabel
              Left = 98
              Top = 206
              Width = 3
              Height = 15
              HelpContext = 355151
              Alignment = taRightJustify
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object CUSTLBL6: TLabel
              Left = 100
              Top = 239
              Width = 3
              Height = 15
              HelpContext = 355152
              Alignment = taRightJustify
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object CUSTLBL7: TLabel
              Left = 332
              Top = 69
              Width = 3
              Height = 15
              HelpContext = 355153
              Alignment = taRightJustify
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object CUSTLBL8: TLabel
              Left = 332
              Top = 104
              Width = 3
              Height = 15
              HelpContext = 355154
              Alignment = taRightJustify
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object CUSTLBL9: TLabel
              Left = 332
              Top = 138
              Width = 3
              Height = 15
              HelpContext = 355155
              Alignment = taRightJustify
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object CUSTLBL10: TLabel
              Left = 332
              Top = 172
              Width = 3
              Height = 15
              HelpContext = 355156
              Alignment = taRightJustify
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object CUSTLBL11: TLabel
              Left = 332
              Top = 204
              Width = 3
              Height = 15
              HelpContext = 355157
              Alignment = taRightJustify
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object CUSTLBL12: TLabel
              Left = 332
              Top = 240
              Width = 3
              Height = 15
              HelpContext = 355158
              Alignment = taRightJustify
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object CUSTLBL13: TLabel
              Left = 566
              Top = 69
              Width = 3
              Height = 15
              HelpContext = 355159
              Alignment = taRightJustify
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object CUSTLBL14: TLabel
              Left = 566
              Top = 102
              Width = 3
              Height = 15
              HelpContext = 355160
              Alignment = taRightJustify
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object CUSTLBL15: TLabel
              Left = 566
              Top = 137
              Width = 3
              Height = 15
              HelpContext = 355161
              Alignment = taRightJustify
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label34: TLabel
              Left = 285
              Top = 12
              Width = 193
              Height = 26
              HelpContext = 355162
              AutoSize = False
              Caption = 'Customisable Fields'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -19
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object CUSTLBL16: TLabel
              Left = 564
              Top = 171
              Width = 3
              Height = 15
              HelpContext = 355163
              Alignment = taRightJustify
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object CUSTLBL17: TLabel
              Left = 564
              Top = 205
              Width = 3
              Height = 15
              HelpContext = 355164
              Alignment = taRightJustify
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object CUSTLBL18: TLabel
              Left = 564
              Top = 239
              Width = 3
              Height = 15
              HelpContext = 355165
              Alignment = taRightJustify
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object cmdCustomLabelsOld: TDNMSpeedButton
              Left = 323
              Top = 266
              Width = 87
              Height = 27
              Hint = '"Add A New Customised Field For All Employee'#39's"'
              HelpContext = 355166
              Caption = '&Add Labels'
              DisableTransparent = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              HotTrackFont.Charset = DEFAULT_CHARSET
              HotTrackFont.Color = clWindowText
              HotTrackFont.Height = -12
              HotTrackFont.Name = 'Arial'
              HotTrackFont.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 18
              AutoDisableParentOnclick = True
              OnClick = cmdCustomLabelsOldClick
            end
            object CUSTFLD1: TwwDBComboBox
              Left = 103
              Top = 64
              Width = 130
              Height = 23
              HelpContext = 355167
              ShowButton = True
              Style = csDropDown
              MapList = False
              AllowClearKey = False
              DataField = 'CUSTFLD1'
              DataSource = frmSupplierSrc
              DropDownCount = 8
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ButtonWidth = -1
              ItemHeight = 0
              ParentFont = False
              Sorted = False
              TabOrder = 0
              UnboundDataType = wwDefault
            end
            object CUSTFLD2: TwwDBComboBox
              Left = 103
              Top = 98
              Width = 130
              Height = 23
              HelpContext = 355168
              ShowButton = True
              Style = csDropDown
              MapList = False
              AllowClearKey = False
              DataField = 'CUSTFLD2'
              DataSource = frmSupplierSrc
              DropDownCount = 8
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ButtonWidth = -1
              ItemHeight = 0
              ParentFont = False
              Sorted = False
              TabOrder = 1
              UnboundDataType = wwDefault
            end
            object CUSTFLD3: TwwDBComboBox
              Left = 103
              Top = 133
              Width = 130
              Height = 23
              HelpContext = 355169
              ShowButton = True
              Style = csDropDown
              MapList = False
              AllowClearKey = False
              DataField = 'CUSTFLD3'
              DataSource = frmSupplierSrc
              DropDownCount = 8
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ButtonWidth = -1
              ItemHeight = 0
              ParentFont = False
              Sorted = False
              TabOrder = 2
              UnboundDataType = wwDefault
            end
            object CUSTFLD4: TwwDBComboBox
              Left = 103
              Top = 167
              Width = 130
              Height = 23
              HelpContext = 355170
              ShowButton = True
              Style = csDropDown
              MapList = False
              AllowClearKey = False
              DataField = 'CUSTFLD4'
              DataSource = frmSupplierSrc
              DropDownCount = 8
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ButtonWidth = -1
              ItemHeight = 0
              ParentFont = False
              Sorted = False
              TabOrder = 3
              UnboundDataType = wwDefault
            end
            object CUSTFLD5: TwwDBComboBox
              Left = 103
              Top = 201
              Width = 130
              Height = 23
              HelpContext = 355171
              ShowButton = True
              Style = csDropDown
              MapList = False
              AllowClearKey = False
              DataField = 'CUSTFLD5'
              DataSource = frmSupplierSrc
              DropDownCount = 8
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ButtonWidth = -1
              ItemHeight = 0
              ParentFont = False
              Sorted = False
              TabOrder = 4
              UnboundDataType = wwDefault
            end
            object CUSTFLD10: TwwDBComboBox
              Left = 336
              Top = 167
              Width = 130
              Height = 23
              HelpContext = 355172
              ShowButton = True
              Style = csDropDown
              MapList = False
              AllowClearKey = False
              DataField = 'CUSTFLD10'
              DataSource = frmSupplierSrc
              DropDownCount = 8
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ButtonWidth = -1
              ItemHeight = 0
              ParentFont = False
              Sorted = False
              TabOrder = 9
              UnboundDataType = wwDefault
            end
            object CUSTFLD9: TwwDBComboBox
              Left = 336
              Top = 133
              Width = 130
              Height = 23
              HelpContext = 355173
              ShowButton = True
              Style = csDropDown
              MapList = False
              AllowClearKey = False
              DataField = 'CUSTFLD9'
              DataSource = frmSupplierSrc
              DropDownCount = 8
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ButtonWidth = -1
              ItemHeight = 0
              ParentFont = False
              Sorted = False
              TabOrder = 8
              UnboundDataType = wwDefault
            end
            object CUSTFLD8: TwwDBComboBox
              Left = 336
              Top = 98
              Width = 130
              Height = 23
              HelpContext = 355174
              ShowButton = True
              Style = csDropDown
              MapList = False
              AllowClearKey = False
              DataField = 'CUSTFLD8'
              DataSource = frmSupplierSrc
              DropDownCount = 8
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ButtonWidth = -1
              ItemHeight = 0
              ParentFont = False
              Sorted = False
              TabOrder = 7
              UnboundDataType = wwDefault
            end
            object CUSTFLD7: TwwDBComboBox
              Left = 336
              Top = 64
              Width = 130
              Height = 23
              HelpContext = 355175
              ShowButton = True
              Style = csDropDown
              MapList = False
              AllowClearKey = False
              DataField = 'CUSTFLD7'
              DataSource = frmSupplierSrc
              DropDownCount = 8
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ButtonWidth = -1
              ItemHeight = 0
              ParentFont = False
              Sorted = False
              TabOrder = 6
              UnboundDataType = wwDefault
            end
            object CUSTFLD6: TwwDBComboBox
              Left = 104
              Top = 235
              Width = 130
              Height = 23
              HelpContext = 355176
              ShowButton = True
              Style = csDropDown
              MapList = False
              AllowClearKey = False
              DataField = 'CUSTFLD6'
              DataSource = frmSupplierSrc
              DropDownCount = 8
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ButtonWidth = -1
              ItemHeight = 0
              ParentFont = False
              Sorted = False
              TabOrder = 5
              UnboundDataType = wwDefault
            end
            object CUSTFLD11: TwwDBComboBox
              Left = 336
              Top = 201
              Width = 130
              Height = 23
              HelpContext = 355177
              ShowButton = True
              Style = csDropDown
              MapList = False
              AllowClearKey = False
              DataField = 'CUSTFLD11'
              DataSource = frmSupplierSrc
              DropDownCount = 8
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ButtonWidth = -1
              ItemHeight = 0
              ParentFont = False
              Sorted = False
              TabOrder = 10
              UnboundDataType = wwDefault
            end
            object CUSTFLD12: TwwDBComboBox
              Left = 336
              Top = 235
              Width = 130
              Height = 23
              HelpContext = 355178
              ShowButton = True
              Style = csDropDown
              MapList = False
              AllowClearKey = False
              DataField = 'CUSTFLD12'
              DataSource = frmSupplierSrc
              DropDownCount = 8
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ButtonWidth = -1
              ItemHeight = 0
              ParentFont = False
              Sorted = False
              TabOrder = 11
              UnboundDataType = wwDefault
            end
            object CUSTFLD13: TwwDBComboBox
              Left = 570
              Top = 64
              Width = 130
              Height = 23
              HelpContext = 355179
              ShowButton = True
              Style = csDropDown
              MapList = False
              AllowClearKey = False
              DataField = 'CUSTFLD13'
              DataSource = frmSupplierSrc
              DropDownCount = 8
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ButtonWidth = -1
              ItemHeight = 0
              ParentFont = False
              Sorted = False
              TabOrder = 12
              UnboundDataType = wwDefault
            end
            object CUSTFLD14: TwwDBComboBox
              Left = 570
              Top = 98
              Width = 130
              Height = 23
              HelpContext = 355180
              ShowButton = True
              Style = csDropDown
              MapList = False
              AllowClearKey = False
              DataField = 'CUSTFLD14'
              DataSource = frmSupplierSrc
              DropDownCount = 8
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ButtonWidth = -1
              ItemHeight = 0
              ParentFont = False
              Sorted = False
              TabOrder = 13
              UnboundDataType = wwDefault
            end
            object CUSTFLD15: TwwDBComboBox
              Left = 570
              Top = 133
              Width = 130
              Height = 23
              HelpContext = 355181
              ShowButton = True
              Style = csDropDown
              MapList = False
              AllowClearKey = False
              DataField = 'CUSTFLD15'
              DataSource = frmSupplierSrc
              DropDownCount = 8
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ButtonWidth = -1
              ItemHeight = 0
              ParentFont = False
              Sorted = False
              TabOrder = 14
              UnboundDataType = wwDefault
            end
            object CUSTFLD16: TwwDBDateTimePicker
              Left = 570
              Top = 167
              Width = 130
              Height = 23
              HelpContext = 355182
              CalendarAttributes.Font.Charset = DEFAULT_CHARSET
              CalendarAttributes.Font.Color = clWindowText
              CalendarAttributes.Font.Height = -11
              CalendarAttributes.Font.Name = 'MS Sans Serif'
              CalendarAttributes.Font.Style = []
              DataField = 'CUSTDATE1'
              DataSource = frmSupplierSrc
              Epoch = 1950
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              ShowButton = True
              TabOrder = 15
            end
            object CUSTFLD17: TwwDBDateTimePicker
              Left = 570
              Top = 201
              Width = 130
              Height = 23
              HelpContext = 355183
              CalendarAttributes.Font.Charset = DEFAULT_CHARSET
              CalendarAttributes.Font.Color = clWindowText
              CalendarAttributes.Font.Height = -11
              CalendarAttributes.Font.Name = 'MS Sans Serif'
              CalendarAttributes.Font.Style = []
              DataField = 'CUSTDATE2'
              DataSource = frmSupplierSrc
              Epoch = 1950
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              ShowButton = True
              TabOrder = 16
            end
            object CUSTFLD18: TwwDBDateTimePicker
              Left = 570
              Top = 235
              Width = 130
              Height = 23
              HelpContext = 355184
              CalendarAttributes.Font.Charset = DEFAULT_CHARSET
              CalendarAttributes.Font.Color = clWindowText
              CalendarAttributes.Font.Height = -11
              CalendarAttributes.Font.Name = 'MS Sans Serif'
              CalendarAttributes.Font.Style = []
              DataField = 'CUSTDATE3'
              DataSource = frmSupplierSrc
              Epoch = 1950
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              ShowButton = True
              TabOrder = 17
            end
          end
        end
      end
    end
    object tabEquip: TTabSheet
      HelpContext = 355185
      Caption = '&Equipment'
      ImageIndex = 7
      object CustEquipDNMPanel: TDNMPanel
        Left = 0
        Top = 0
        Width = 714
        Height = 414
        HelpContext = 355240
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 1
        BorderStyle = bsSingle
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
    end
    object tabAttachments: TTabSheet
      HelpContext = 355241
      Caption = 'Attachments'
      ImageIndex = 8
      object pnlAttach: TDNMPanel
        Left = 0
        Top = 0
        Width = 714
        Height = 414
        HelpContext = 355186
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        Transparent = False
        DesignSize = (
          714
          414)
        object Label3: TLabel
          Left = 8
          Top = 7
          Width = 79
          Height = 16
          HelpContext = 355140
          AutoSize = False
          Caption = 'Attachments'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object pnlAttachments: TPanel
          Left = 8
          Top = 29
          Width = 700
          Height = 384
          HelpContext = 355242
          Anchors = [akLeft, akTop, akRight, akBottom]
          BevelOuter = bvNone
          Color = clWhite
          TabOrder = 0
        end
      end
    end
    object tabFollowUps: TTabSheet
      HelpContext = 355243
      Caption = 'Follow Ups / Skills'
      ImageIndex = 9
      object pnlFollowUps: TDNMPanel
        Left = 0
        Top = 0
        Width = 714
        Height = 414
        HelpContext = 355260
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        Transparent = False
        DesignSize = (
          714
          414)
        object Label35: TLabel
          Left = 8
          Top = 7
          Width = 79
          Height = 16
          HelpContext = 355261
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Caption = 'Follow Ups'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label40: TLabel
          Left = 10
          Top = 170
          Width = 79
          Height = 16
          HelpContext = 355262
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Caption = 'Skills Provided'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object grdSkills: TwwDBGrid
          Left = 10
          Top = 189
          Width = 700
          Height = 223
          HelpContext = 355244
          ControlType.Strings = (
            'Renewed;CheckBox;T;F'
            'Skillname;CustomEdit;cboskills;F'
            'Active;CheckBox;T;F')
          Selected.Strings = (
            'Skillname'#9'45'#9'Skill Name'#9'F'
            'Active'#9'1'#9'Active'#9'F')
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          FixedCols = 0
          ShowHorzScrollBar = True
          EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataSource = dsSkillProviderskills
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          TitleAlignment = taCenter
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = True
          UseTFields = False
          FooterColor = clWhite
          object wwIButton3: TwwIButton
            Left = -1
            Top = 0
            Width = 25
            Height = 20
            HelpContext = 355245
            AllowAllUp = True
            Glyph.Data = {
              DE010000424DDE01000000000000760000002800000024000000120000000100
              0400000000006801000000000000000000001000000000000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
              333333333333333333333333000033337733333333333333333F333333333333
              0000333911733333973333333377F333333F3333000033391117333911733333
              37F37F333F77F33300003339111173911117333337F337F3F7337F3300003333
              911117111117333337F3337F733337F3000033333911111111733333337F3337
              3333F7330000333333911111173333333337F333333F73330000333333311111
              7333333333337F3333373333000033333339111173333333333337F333733333
              00003333339111117333333333333733337F3333000033333911171117333333
              33337333337F333300003333911173911173333333373337F337F33300003333
              9117333911173333337F33737F337F33000033333913333391113333337FF733
              37F337F300003333333333333919333333377333337FFF730000333333333333
              3333333333333333333777330000333333333333333333333333333333333333
              0000}
            NumGlyphs = 2
            OnClick = wwIButton3Click
          end
        end
        object grdFollowUp: TwwDBGrid
          Left = 8
          Top = 24
          Width = 700
          Height = 140
          HelpContext = 355187
          ControlType.Strings = (
            'FollowUpDate;CustomEdit;dtpDatePicker;T'
            'EmployeeID;CustomEdit;cboEmployee;T'
            'Done;CheckBox;T;F'
            'EmployeeName;CustomEdit;cboEmployee;T')
          Selected.Strings = (
            'FollowUpDate'#9'13'#9'Follow Up Date'#9'F'
            'Notes'#9'49'#9'Notes'#9'F'
            'EmployeeName'#9'24'#9'Employee'#9'F'
            'Done'#9'4'#9'Done'#9'F')
          MemoAttributes = [mSizeable, mWordWrap, mGridShow, mDisableDialog]
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          FixedCols = 0
          ShowHorzScrollBar = True
          EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
          Anchors = [akLeft, akTop, akRight]
          Color = clWhite
          DataSource = dsOtherFollowUp
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          KeyOptions = [dgAllowInsert]
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgProportionalColResize, dgFixedProportionalResize]
          ParentFont = False
          TabOrder = 0
          TitleAlignment = taLeftJustify
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = False
          UseTFields = False
          OnColEnter = grdFollowUpColEnter
          OnColExit = grdFollowUpColExit
          OnDblClick = grdFollowUpDblClick
          OnFieldChanged = grdFollowUpFieldChanged
          FooterColor = clWhite
          FooterCellColor = clWhite
          object wwIButton2: TwwIButton
            Left = 0
            Top = 0
            Width = 25
            Height = 22
            HelpContext = 355246
            AllowAllUp = True
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
            NumGlyphs = 2
            OnClick = btnInactiveFollowUpClick
          end
        end
        object cboEmployee: TwwDBLookupCombo
          Left = 408
          Top = 64
          Width = 144
          Height = 23
          HelpContext = 355247
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'EmployeeName'#9'47'#9'EmployeeName'#9#9)
          DataField = 'EmployeeName'
          DataSource = dsOtherFollowUp
          LookupTable = qryEmpID
          LookupField = 'EmployeeID'
          TabOrder = 2
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
        object dtpDatePicker: TwwDBDateTimePicker
          Left = 80
          Top = 80
          Width = 88
          Height = 23
          HelpContext = 355248
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'MS Sans Serif'
          CalendarAttributes.Font.Style = []
          Epoch = 1950
          ShowButton = True
          TabOrder = 1
        end
        object cboskills: TwwDBLookupCombo
          Left = 192
          Top = 232
          Width = 121
          Height = 23
          HelpContext = 355249
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Skill'#9'20'#9'Skill'#9'F')
          DataField = 'Skillname'
          DataSource = dsSkillProviderskills
          LookupTable = qryskills
          LookupField = 'Skill'
          TabOrder = 3
          AutoDropDown = False
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnCloseUp = cboskillsCloseUp
        end
        object btnAddfollowupnotedate: TDNMSpeedButton
          Left = 628
          Top = 6
          Width = 75
          Height = 18
          HelpContext = 355250
          Caption = 'Add Date'
          DisableTransparent = False
          Font.Charset = ANSI_CHARSET
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
          TabOrder = 5
          AutoDisableParentOnclick = True
          OnClick = btnAddfollowupnotedateClick
        end
      end
    end
  end
  object chkActive: TwwCheckBox [14]
    Left = 774
    Top = 352
    Width = 16
    Height = 18
    HelpContext = 355188
    DisableThemes = False
    AlwaysTransparent = True
    Frame.Enabled = True
    Frame.Transparent = True
    Frame.FocusBorders = []
    Frame.NonFocusBorders = []
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Anchors = [akTop, akRight]
    Caption = 'chkActive'
    DataField = 'Active'
    DataSource = frmSupplierSrc
    TabOrder = 8
    OnClick = chkActiveClick
  end
  object pnlTitle: TDNMPanel [15]
    Left = 248
    Top = 3
    Width = 238
    Height = 39
    HelpContext = 355189
    Anchors = [akTop]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 12
    object TitleShader: TShader
      Left = 1
      Top = 1
      Width = 236
      Height = 37
      HelpContext = 355190
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
        Width = 236
        Height = 37
        HelpContext = 355191
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Supplier'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitWidth = 234
        ExplicitHeight = 35
      end
    end
  end
  object chkIntrastat: TwwCheckBox [16]
    Left = 774
    Top = 479
    Width = 16
    Height = 18
    HelpContext = 355192
    DisableThemes = False
    AlwaysTransparent = True
    Frame.Enabled = True
    Frame.Transparent = True
    Frame.FocusBorders = []
    Frame.NonFocusBorders = []
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Anchors = [akTop, akRight]
    Caption = 'chkActive'
    DataField = 'IncludeOnIntrastat'
    DataSource = frmSupplierSrc
    TabOrder = 10
    OnClick = chkActiveClick
  end
  object cmdOk: TDNMSpeedButton [17]
    Left = 737
    Top = 83
    Width = 87
    Height = 25
    HelpContext = 355007
    Anchors = [akTop, akRight]
    Caption = '&Save'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
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
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    ModalResult = 1
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 1
    AutoDisableParentOnclick = True
    OnClick = cmdOkClick
  end
  object edtCompany: TDBMemo [18]
    Left = 52
    Top = 45
    Width = 630
    Height = 29
    HelpContext = 355006
    TabStop = False
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    DataField = 'Company'
    DataSource = frmSupplierSrc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 11
  end
  object cmdCancel: TDNMSpeedButton [19]
    Left = 736
    Top = 114
    Width = 87
    Height = 27
    HelpContext = 355008
    Anchors = [akTop, akRight]
    Caption = '&Cancel'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
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
    ModalResult = 2
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 2
    AutoDisableParentOnclick = True
    OnClick = cmdCancelClick
  end
  object cmdNew: TDNMSpeedButton [20]
    Left = 736
    Top = 148
    Width = 87
    Height = 27
    Hint = '"Add A New Supplier"'
    HelpContext = 355009
    Anchors = [akTop, akRight]
    Caption = 'Ne&w'
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    AutoDisableParentOnclick = True
    OnClick = cmdNewClick
  end
  object cmdNotes: TDNMSpeedButton [21]
    Left = 736
    Top = 217
    Width = 87
    Height = 27
    Hint = '"Go To The Notes Field"'
    HelpContext = 355010
    Anchors = [akTop, akRight]
    Caption = 'N&otes'
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    AutoDisableParentOnclick = True
    OnClick = cmdNotesClick
  end
  inherited ApplicationEvents1: TApplicationEvents
    OnException = ApplicationEvents1Exception
  end
  inherited MyConnection: TERPConnection
    Server = 'Localhost'
    Connected = True
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102003401440210001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 218
    Top = 48
  end
  object frmSupplierSrc: TDataSource
    DataSet = qrySupplier
    Left = 296
    Top = 80
  end
  object qrySupplier: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      '* '
      'FROM tblclients'
      'WHERE Supplier='#39'T'#39' AND ClientID = :KeyID;')
    AfterOpen = qrySupplierAfterOpen
    AfterInsert = qrySupplierAfterInsert
    AfterPost = qrySupplierAfterPost
    OnCalcFields = qrySupplierCalcFields
    Left = 296
    Top = 48
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'KeyID'
      end>
    object qrySupplierPhone: TWideStringField
      FieldName = 'Phone'
      Origin = 'tblclients.Phone'
      EditMask = '## #### ####;0;_'
    end
    object qrySupplierFaxNumber: TWideStringField
      FieldName = 'FaxNumber'
      Origin = 'tblclients.FaxNumber'
      EditMask = '## #### ####;0;_'
    end
    object qrySupplierMobile: TWideStringField
      FieldName = 'Mobile'
      Origin = 'tblclients.Mobile'
      EditMask = '#### ### ###;0;_'
    end
    object qrySupplierAltPhone: TWideStringField
      FieldName = 'AltPhone'
      Origin = 'tblclients.AltPhone'
      EditMask = '## #### ####;0;_'
    end
    object qrySupplierContact1Phone: TWideStringField
      FieldName = 'Contact1Phone'
      Origin = 'tblclients.Contact1Phone'
      EditMask = '## #### ####;0;_'
    end
    object qrySupplierContact2Phone: TWideStringField
      FieldName = 'Contact2Phone'
      Origin = 'tblclients.Contact2Phone'
      EditMask = '## #### ####;0;_'
    end
    object qrySupplierClientID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'ClientID'
      Origin = 'tblclients.ClientID'
      ReadOnly = True
    end
    object qrySupplierCompany: TWideStringField
      FieldName = 'Company'
      Origin = 'tblclients.Company'
      OnSetText = qrySupplierCompanySetText
      Size = 80
    end
    object qrySupplierABN: TWideStringField
      FieldName = 'ABN'
      Origin = 'tblclients.ABN'
      EditMask = '## ### ### ###;0;_'
      Size = 15
    end
    object qrySupplierFirstName: TWideStringField
      FieldName = 'FirstName'
      Origin = 'tblclients.FirstName'
      OnChange = qrySupplierFirstNameChange
      Size = 40
    end
    object qrySupplierMiddleName: TWideStringField
      FieldName = 'MiddleName'
      Origin = 'tblclients.MiddleName'
      Size = 40
    end
    object qrySupplierLastName: TWideStringField
      FieldName = 'LastName'
      Origin = 'tblclients.LastName'
      OnChange = qrySupplierLastNameChange
      Size = 40
    end
    object qrySupplierPosition: TWideStringField
      FieldName = 'Position'
      Origin = 'tblclients.Position'
      Size = 30
    end
    object qrySupplierEmail: TWideStringField
      FieldName = 'Email'
      Origin = 'tblclients.Email'
      Size = 80
    end
    object qrySupplierAltContact: TWideStringField
      FieldName = 'AltContact'
      Origin = 'tblclients.AltContact'
      Size = 50
    end
    object qrySupplierContact1: TWideStringField
      FieldName = 'Contact1'
      Origin = 'tblclients.Contact1'
      Size = 50
    end
    object qrySupplierPhoneSupportTill: TDateField
      FieldName = 'PhoneSupportTill'
      Origin = 'tblclients.PhoneSupportTill'
    end
    object qrySupplierContact2: TWideStringField
      FieldName = 'Contact2'
      Origin = 'tblclients.Contact2'
      Size = 50
    end
    object qrySupplierNotes: TWideMemoField
      FieldName = 'Notes'
      Origin = 'tblclients.Notes'
      BlobType = ftWideMemo
    end
    object qrySupplierMedTypeID: TIntegerField
      FieldName = 'MedTypeID'
      Origin = 'tblclients.MedTypeID'
    end
    object qrySupplierTYPE: TWideStringField
      FieldName = 'TYPE'
      Origin = 'tblclients.TYPE'
      Size = 50
    end
    object qrySupplierCreditLimit: TFloatField
      FieldName = 'CreditLimit'
      Origin = 'tblclients.CreditLimit'
    end
    object qrySupplierBalance: TFloatField
      FieldName = 'Balance'
      Origin = 'tblclients.Balance'
    end
    object qrySupplierTERMS: TWideStringField
      FieldName = 'TERMS'
      Origin = 'tblclients.TERMS'
      Size = 30
    end
    object qrySupplierTermsID: TIntegerField
      FieldName = 'TermsID'
      Origin = 'tblclients.TermsID'
    end
    object qrySupplierShippingMethod: TWideStringField
      FieldName = 'ShippingMethod'
      Origin = 'tblclients.ShippingMethod'
      Size = 30
    end
    object qrySupplierShippingID: TIntegerField
      FieldName = 'ShippingID'
      Origin = 'tblclients.ShippingID'
    end
    object qrySupplierDiscount: TFloatField
      FieldName = 'Discount'
      Origin = 'tblclients.Discount'
    end
    object qrySupplierSpecialDiscount: TFloatField
      FieldName = 'SpecialDiscount'
      Origin = 'tblclients.SpecialDiscount'
    end
    object qrySupplierJobName: TWideStringField
      FieldName = 'JobName'
      Origin = 'tblclients.JobName'
      Size = 39
    end
    object qrySupplierIsJob: TWideStringField
      FieldName = 'IsJob'
      Origin = 'tblclients.IsJob'
      FixedChar = True
      Size = 1
    end
    object qrySupplierPayMethodID: TIntegerField
      FieldName = 'PayMethodID'
      Origin = 'tblclients.PayMethodID'
    end
    object qrySupplierFeedback: TWideStringField
      FieldName = 'Feedback'
      Origin = 'tblclients.Feedback'
      FixedChar = True
      Size = 1
    end
    object qrySupplierCustomer: TWideStringField
      FieldName = 'Customer'
      Origin = 'tblclients.Customer'
      FixedChar = True
      Size = 1
    end
    object qrySupplierSupplier: TWideStringField
      FieldName = 'Supplier'
      Origin = 'tblclients.Supplier'
      FixedChar = True
      Size = 1
    end
    object qrySupplierOtherContact: TWideStringField
      FieldName = 'OtherContact'
      Origin = 'tblclients.OtherContact'
      FixedChar = True
      Size = 1
    end
    object qrySupplierOtherContactType: TIntegerField
      FieldName = 'OtherContactType'
      Origin = 'tblclients.OtherContactType'
    end
    object qrySupplierRepID: TIntegerField
      FieldName = 'RepID'
      Origin = 'tblclients.RepID'
      OnChange = qrySupplierRepIDChange
    end
    object qrySupplierGlobal: TWideStringField
      FieldName = 'Global'
      Origin = 'tblclients.Global'
      FixedChar = True
      Size = 1
    end
    object qrySupplierDone: TWideStringField
      FieldName = 'Done'
      Origin = 'tblclients.Done'
      FixedChar = True
      Size = 1
    end
    object qrySupplierActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblclients.Active'
      FixedChar = True
      Size = 1
    end
    object qrySupplierEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblclients.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qrySupplierCorrespondenceMethod: TWideStringField
      FieldName = 'CorrespondenceMethod'
      Origin = 'tblclients.CorrespondenceMethod'
      Size = 30
    end
    object qrySupplierShipTime: TWordField
      FieldName = 'ShipTime'
      Origin = 'tblclients.ShipTime'
    end
    object qrySupplierClientNo: TWideStringField
      FieldName = 'ClientNo'
      Origin = 'tblclients.ClientNo'
      Size = 50
    end
    object qrySupplierBankAccountName: TWideStringField
      FieldName = 'BankAccountName'
      Origin = 'tblclients.BankAccountName'
      Size = 255
    end
    object qrySupplierBankAccountBSB: TWideStringField
      FieldName = 'BankAccountBSB'
      Origin = 'tblclients.BankAccountBSB'
      EditMask = '000-000;1;_'
      Size = 30
    end
    object qrySupplierBankAccountNo: TWideStringField
      FieldName = 'BankAccountNo'
      Origin = 'tblclients.BankAccountNo'
      EditMask = '000000000;0;_'
      Size = 30
    end
    object qrySupplierTAXID: TIntegerField
      FieldName = 'TAXID'
      Origin = 'tblclients.TAXID'
    end
    object qrySupplierTitle: TWideStringField
      FieldName = 'Title'
      Origin = 'tblclients.Title'
      Size = 32
    end
    object qrySupplierURL: TWideStringField
      FieldName = 'URL'
      Origin = 'tblclients.URL'
      Size = 255
    end
    object qrySupplierRequired: TWideStringField
      FieldName = 'Required'
      Origin = 'tblclients.Required'
      FixedChar = True
      Size = 1
    end
    object qrySupplierRepName: TWideStringField
      FieldName = 'RepName'
      Origin = 'tblclients.RepName'
      Size = 255
    end
    object qrySupplierBankCode: TWideStringField
      FieldName = 'BankCode'
      Origin = 'tblclients.BankCode'
      FixedChar = True
      Size = 3
    end
    object qrySupplierForeignExchangeSellCode: TWideStringField
      FieldName = 'ForeignExchangeSellCode'
      Origin = 'tblclients.ForeignExchangeSellCode'
      FixedChar = True
      Size = 3
    end
    object qrySupplierStreet: TWideStringField
      FieldName = 'Street'
      Origin = 'tblclients.Street'
      Size = 255
    end
    object qrySupplierStreet2: TWideStringField
      FieldName = 'Street2'
      Origin = 'tblclients.Street2'
      Size = 255
    end
    object qrySupplierSuburb: TWideStringField
      FieldName = 'Suburb'
      Origin = 'tblclients.Suburb'
      Size = 255
    end
    object qrySupplierState: TWideStringField
      FieldName = 'State'
      Origin = 'tblclients.State'
      Size = 255
    end
    object qrySupplierCountry: TWideStringField
      FieldName = 'Country'
      Origin = 'tblclients.Country'
      Size = 255
    end
    object qrySupplierPostcode: TWideStringField
      FieldName = 'Postcode'
      Origin = 'tblclients.Postcode'
      Size = 255
    end
    object qrySupplierBillStreet: TWideStringField
      FieldName = 'BillStreet'
      Origin = 'tblclients.BillStreet'
      Size = 255
    end
    object qrySupplierBillStreet2: TWideStringField
      FieldName = 'BillStreet2'
      Origin = 'tblclients.BillStreet2'
      Size = 255
    end
    object qrySupplierBillSuburb: TWideStringField
      FieldName = 'BillSuburb'
      Origin = 'tblclients.BillSuburb'
      Size = 255
    end
    object qrySupplierBillState: TWideStringField
      FieldName = 'BillState'
      Origin = 'tblclients.BillState'
      Size = 255
    end
    object qrySupplierBillCountry: TWideStringField
      FieldName = 'BillCountry'
      Origin = 'tblclients.BillCountry'
      Size = 255
    end
    object qrySupplierBillPostcode: TWideStringField
      FieldName = 'BillPostcode'
      Origin = 'tblclients.BillPostcode'
      Size = 255
    end
    object qrySupplierPOBox: TWideStringField
      FieldName = 'POBox'
      Origin = 'tblclients.POBox'
      Size = 255
    end
    object qrySupplierPOSuburb: TWideStringField
      FieldName = 'POSuburb'
      Origin = 'tblclients.POSuburb'
      Size = 255
    end
    object qrySupplierPOState: TWideStringField
      FieldName = 'POState'
      Origin = 'tblclients.POState'
      Size = 255
    end
    object qrySupplierPOCountry: TWideStringField
      FieldName = 'POCountry'
      Origin = 'tblclients.POCountry'
      Size = 255
    end
    object qrySupplierPOPostcode: TWideStringField
      FieldName = 'POPostcode'
      Origin = 'tblclients.POPostcode'
      Size = 255
    end
    object qrySupplierCUSTFLD1: TWideStringField
      FieldName = 'CUSTFLD1'
      Origin = 'tblclients.CUSTFLD1'
      Size = 255
    end
    object qrySupplierCUSTFLD2: TWideStringField
      FieldName = 'CUSTFLD2'
      Origin = 'tblclients.CUSTFLD2'
      Size = 255
    end
    object qrySupplierCUSTFLD3: TWideStringField
      FieldName = 'CUSTFLD3'
      Origin = 'tblclients.CUSTFLD3'
      Size = 255
    end
    object qrySupplierCUSTFLD4: TWideStringField
      FieldName = 'CUSTFLD4'
      Origin = 'tblclients.CUSTFLD4'
      Size = 255
    end
    object qrySupplierCUSTFLD5: TWideStringField
      FieldName = 'CUSTFLD5'
      Origin = 'tblclients.CUSTFLD5'
      Size = 255
    end
    object qrySupplierCUSTFLD6: TWideStringField
      FieldName = 'CUSTFLD6'
      Origin = 'tblclients.CUSTFLD6'
      Size = 255
    end
    object qrySupplierCUSTFLD7: TWideStringField
      FieldName = 'CUSTFLD7'
      Origin = 'tblclients.CUSTFLD7'
      Size = 255
    end
    object qrySupplierCUSTFLD8: TWideStringField
      FieldName = 'CUSTFLD8'
      Origin = 'tblclients.CUSTFLD8'
      Size = 255
    end
    object qrySupplierCUSTFLD9: TWideStringField
      FieldName = 'CUSTFLD9'
      Origin = 'tblclients.CUSTFLD9'
      Size = 255
    end
    object qrySupplierCUSTFLD10: TWideStringField
      FieldName = 'CUSTFLD10'
      Origin = 'tblclients.CUSTFLD10'
      Size = 255
    end
    object qrySupplierCUSTFLD11: TWideStringField
      FieldName = 'CUSTFLD11'
      Origin = 'tblclients.CUSTFLD11'
      Size = 255
    end
    object qrySupplierCUSTFLD12: TWideStringField
      FieldName = 'CUSTFLD12'
      Origin = 'tblclients.CUSTFLD12'
      Size = 255
    end
    object qrySupplierCUSTFLD13: TWideStringField
      FieldName = 'CUSTFLD13'
      Origin = 'tblclients.CUSTFLD13'
      Size = 255
    end
    object qrySupplierCUSTFLD14: TWideStringField
      FieldName = 'CUSTFLD14'
      Origin = 'tblclients.CUSTFLD14'
      Size = 255
    end
    object qrySupplierCUSTFLD15: TWideStringField
      FieldName = 'CUSTFLD15'
      Origin = 'tblclients.CUSTFLD15'
      Size = 255
    end
    object qrySupplierCreationDate: TDateField
      FieldName = 'CreationDate'
      Origin = 'tblclients.CreationDate'
    end
    object qrySupplierCUSTDATE1: TDateField
      FieldName = 'CUSTDATE1'
      Origin = 'tblclients.CUSTDATE1'
    end
    object qrySupplierCUSTDATE2: TDateField
      FieldName = 'CUSTDATE2'
      Origin = 'tblclients.CUSTDATE2'
    end
    object qrySupplierCUSTDATE3: TDateField
      FieldName = 'CUSTDATE3'
      Origin = 'tblclients.CUSTDATE3'
    end
    object qrySupplierDefaultPurchaseOrderTemplateID: TIntegerField
      FieldName = 'DefaultPurchaseOrderTemplateID'
      Origin = 'tblclients.DefaultPurchaseOrderTemplateID'
    end
    object qrySupplierStreet3: TWideStringField
      FieldName = 'Street3'
      Origin = 'tblclients.Street3'
      Size = 255
    end
    object qrySupplierBillStreet3: TWideStringField
      FieldName = 'BillStreet3'
      Origin = 'tblclients.BillStreet3'
      Size = 255
    end
    object qrySupplierIncludeOnIntrastat: TWideStringField
      FieldName = 'IncludeOnIntrastat'
      Origin = 'tblclients.IncludeOnIntrastat'
      FixedChar = True
      Size = 1
    end
    object qrySupplierShowInShipContainers: TWideStringField
      FieldName = 'ShowInShipContainers'
      Origin = 'tblclients.ShowInShipContainers'
      FixedChar = True
      Size = 1
    end
    object qrySupplierGlobalref: TWideStringField
      FieldName = 'Globalref'
      Origin = 'tblclients.GlobalRef'
      Size = 255
    end
    object qrySupplierBPAYBillerCode: TWideStringField
      FieldName = 'BPAYBillerCode'
      Origin = 'tblclients.BPAYBillerCode'
      Size = 255
    end
    object qrySupplierBPAYReference: TWideStringField
      FieldName = 'BPAYReference'
      Origin = 'tblclients.BPAYReference'
      Size = 255
    end
    object qrySupplierLastUpdated: TDateTimeField
      FieldName = 'LastUpdated'
      Origin = 'tblclients.LastUpdated'
    end
    object qrySupplierCallPriority: TIntegerField
      FieldName = 'CallPriority'
      Origin = 'tblclients.CallPriority'
    end
    object qrySupplierDefaultContactMethod: TWideStringField
      FieldName = 'DefaultContactMethod'
      Origin = 'tblclients.DefaultContactMethod'
    end
    object qrySupplierskypename: TWideStringField
      FieldName = 'skypename'
      Origin = 'tblclients.SkypeName'
      Size = 100
    end
    object qrySupplierPOCommentPopup: TWideStringField
      FieldName = 'POCommentPopup'
      Origin = 'tblclients.POCommentPopup'
      FixedChar = True
      Size = 1
    end
    object qrySupplierPOComment: TWideMemoField
      FieldName = 'POComment'
      Origin = 'tblclients.POComment'
      BlobType = ftWideMemo
    end
    object qrySupplierClientTypeID: TIntegerField
      FieldName = 'ClientTypeID'
      Origin = 'tblclients.ClientTypeID'
    end
    object qrySupplierSupplierCreditLimit: TFloatField
      FieldName = 'SupplierCreditLimit'
      Origin = 'tblclients.SupplierCreditLimit'
    end
    object qrySupplierArea: TWideStringField
      FieldName = 'Area'
    end
    object qrySupplierSendXMLPOs: TWideStringField
      FieldName = 'SendXMLPOs'
      FixedChar = True
      Size = 1
    end
    object qrySupplierEmailPOXML: TWideStringField
      FieldName = 'EmailPOXML'
      Size = 255
    end
    object qrySupplierDefaultAPAccountID: TIntegerField
      FieldName = 'DefaultAPAccountID'
    end
    object qrySupplierDefaultAPAccountName: TWideStringField
      FieldName = 'DefaultAPAccountName'
      Size = 100
    end
    object qrySupplierBankLodgementRef: TWideStringField
      FieldName = 'BankLodgementRef'
      Size = 255
    end
    object qrySupplierSendFTPXMLPOs: TWideStringField
      FieldName = 'SendFTPXMLPOs'
      FixedChar = True
      Size = 1
    end
    object qrySupplierFTPAddress: TWideStringField
      FieldName = 'FTPAddress'
      Size = 255
    end
    object qrySupplierFTPUserName: TWideStringField
      FieldName = 'FTPUserName'
      Size = 255
    end
    object qrySupplierFTPPassword: TWideStringField
      FieldName = 'FTPPassword'
      Size = 255
    end
    object qrySupplierDocumentPath: TWideStringField
      FieldName = 'DocumentPath'
      Size = 255
    end
    object qrySuppliercDocumentPath: TStringField
      FieldKind = fkCalculated
      FieldName = 'cDocumentPath'
      Size = 255
      Calculated = True
    end
    object qrySupplierclientCode: TWideStringField
      FieldName = 'clientCode'
      Size = 5
    end
    object qrySupplierIgnoreSupplierforProductLatestCost: TWideStringField
      FieldName = 'IgnoreSupplierforProductLatestCost'
      FixedChar = True
      Size = 1
    end
    object qrySupplierPrintName: TWideStringField
      FieldName = 'PrintName'
      Size = 255
    end
    object qrySupplierContractor: TWideStringField
      FieldName = 'Contractor'
      FixedChar = True
      Size = 1
    end
    object qrySupplierAddressValid: TWideStringField
      FieldName = 'AddressValid'
      FixedChar = True
      Size = 1
    end
    object qrySupplierBillAddressValid: TWideStringField
      FieldName = 'BillAddressValid'
      FixedChar = True
      Size = 1
    end
    object qrySupplierUpdateDate: TDateField
      FieldName = 'UpdateDate'
    end
    object qrySupplierDateInactive: TDateField
      FieldName = 'DateInactive'
    end
    object qrySupplierTaxname: TWideStringField
      FieldName = 'Taxname'
      Size = 100
    end
    object qrySupplierARBalance: TFloatField
      FieldName = 'ARBalance'
    end
    object qrySupplierAPBalance: TFloatField
      FieldName = 'APBalance'
    end
    object qrySupplierSOBalance: TFloatField
      FieldName = 'SOBalance'
    end
    object qrySupplierPrintJobName: TWideStringField
      FieldName = 'PrintJobName'
      Size = 255
    end
    object qrySupplierJobRegistration: TWideStringField
      FieldName = 'JobRegistration'
      Size = 50
    end
    object qrySupplierWarrantyFinishDate: TDateTimeField
      FieldName = 'WarrantyFinishDate'
    end
    object qrySupplierHoursTakenForJob: TFloatField
      FieldName = 'HoursTakenForJob'
    end
    object qrySupplierIsInternal: TWideStringField
      FieldName = 'IsInternal'
      FixedChar = True
      Size = 1
    end
    object qrySupplierAction: TDateTimeField
      FieldName = 'Action'
    end
    object qrySupplierDateEntered: TDateField
      FieldName = 'DateEntered'
    end
    object qrySupplierDontContact: TWideStringField
      FieldName = 'DontContact'
      FixedChar = True
      Size = 1
    end
    object qrySupplierCompletionDate: TDateField
      FieldName = 'CompletionDate'
    end
    object qrySupplierParentClientID: TIntegerField
      FieldName = 'ParentClientID'
    end
    object qrySupplierGracePeriod: TWordField
      FieldName = 'GracePeriod'
    end
    object qrySupplierLastContactDate: TDateField
      FieldName = 'LastContactDate'
    end
    object qrySupplierLoyaltyValue: TFloatField
      FieldName = 'LoyaltyValue'
    end
    object qrySupplierLastSaleDate: TDateField
      FieldName = 'LastSaleDate'
    end
    object qrySupplierAccountNo: TWideStringField
      FieldName = 'AccountNo'
      Size = 50
    end
    object qrySupplierCombinedInvoiceBOID: TWideStringField
      FieldName = 'CombinedInvoiceBOID'
      Size = 255
    end
    object qrySupplierCombinedPurchaseBOID: TWideStringField
      FieldName = 'CombinedPurchaseBOID'
      Size = 255
    end
    object qrySupplierCombinedSaleOrderBOID: TWideStringField
      FieldName = 'CombinedSaleOrderBOID'
      Size = 255
    end
    object qrySupplierStopCredit: TWideStringField
      FieldName = 'StopCredit'
      FixedChar = True
      Size = 1
    end
    object qrySupplierSecurityLevel: TIntegerField
      FieldName = 'SecurityLevel'
    end
    object qrySupplierForcePOOnBooking: TWideStringField
      FieldName = 'ForcePOOnBooking'
      FixedChar = True
      Size = 1
    end
    object qrySupplierForcePOOnInvoice: TWideStringField
      FieldName = 'ForcePOOnInvoice'
      FixedChar = True
      Size = 1
    end
    object qrySupplierForcePOOnSalesOrder: TWideStringField
      FieldName = 'ForcePOOnSalesOrder'
      FixedChar = True
      Size = 1
    end
    object qrySupplierForcePOOnCustomer: TWideStringField
      FieldName = 'ForcePOOnCustomer'
      FixedChar = True
      Size = 1
    end
    object qrySupplierPickingPriority: TIntegerField
      FieldName = 'PickingPriority'
    end
    object qrySupplierJobNumber: TIntegerField
      FieldName = 'JobNumber'
    end
    object qrySupplierDefaultInvoiceTemplateID: TIntegerField
      FieldName = 'DefaultInvoiceTemplateID'
    end
    object qrySupplierDefaultSalesOrderTemplateID: TIntegerField
      FieldName = 'DefaultSalesOrderTemplateID'
    end
    object qrySupplierDefaultDeliveryTemplateID: TIntegerField
      FieldName = 'DefaultDeliveryTemplateID'
    end
    object qrySupplierLoyaltyDateSaleDays: TDateField
      FieldName = 'LoyaltyDateSaleDays'
    end
    object qrySupplierLoyaltyDateAmount: TDateField
      FieldName = 'LoyaltyDateAmount'
    end
    object qrySupplierLoyaltyDateAppointDays: TDateField
      FieldName = 'LoyaltyDateAppointDays'
    end
    object qrySupplierGroupDiscountOverridesAll: TWideStringField
      FieldName = 'GroupDiscountOverridesAll'
      FixedChar = True
      Size = 1
    end
    object qrySupplierCardNumber: TWideStringField
      FieldName = 'CardNumber'
      Size = 255
    end
    object qrySupplierDefaultClass: TWideStringField
      FieldName = 'DefaultClass'
      Size = 255
    end
    object qrySupplierDischargeDate: TDateField
      FieldName = 'DischargeDate'
    end
    object qrySupplierJobTitle: TWideStringField
      FieldName = 'JobTitle'
      Size = 255
    end
    object qrySupplierUseInvBase: TWideStringField
      FieldName = 'UseInvBase'
      FixedChar = True
      Size = 1
    end
    object qrySupplierInvBaseNumber: TIntegerField
      FieldName = 'InvBaseNumber'
    end
    object qrySupplierApprovalFromDate: TDateTimeField
      FieldName = 'ApprovalFromDate'
    end
    object qrySupplierApprovalToDate: TDateTimeField
      FieldName = 'ApprovalToDate'
    end
    object qrySupplierTasks: TWideMemoField
      FieldName = 'Tasks'
      BlobType = ftWideMemo
    end
    object qrySupplierReminderDateTime: TDateTimeField
      FieldName = 'ReminderDateTime'
    end
    object qrySupplierSpecialInstructions: TWideMemoField
      FieldName = 'SpecialInstructions'
      BlobType = ftWideMemo
    end
    object qrySupplierSerialNumber: TWideStringField
      FieldName = 'SerialNumber'
      Size = 255
    end
    object qrySupplierModelNumber: TWideStringField
      FieldName = 'ModelNumber'
      Size = 255
    end
    object qrySupplierManufacture: TWideStringField
      FieldName = 'Manufacture'
      Size = 255
    end
    object qrySupplierParentRelatedClientID: TIntegerField
      FieldName = 'ParentRelatedClientID'
    end
    object qrySupplierDeliveryNotes: TWideMemoField
      FieldName = 'DeliveryNotes'
      BlobType = ftWideMemo
    end
    object qrySupplierCreditCardNumber: TWideStringField
      FieldName = 'CreditCardNumber'
      Size = 255
    end
    object qrySupplierCreditCardExpiryDate: TWideStringField
      FieldName = 'CreditCardExpiryDate'
      Size = 255
    end
    object qrySupplierCreditCardCardHolderName: TWideStringField
      FieldName = 'CreditCardCardHolderName'
      Size = 40
    end
    object qrySupplierCreditCardNotes: TWideStringField
      FieldName = 'CreditCardNotes'
      Size = 255
    end
    object qrySupplierCreditCardCVC: TWideStringField
      FieldName = 'CreditCardCVC'
      Size = 50
    end
    object qrySupplierCompanyTypeId: TIntegerField
      FieldName = 'CompanyTypeId'
    end
    object qrySupplierCreditCardType: TWideStringField
      FieldName = 'CreditCardType'
      Size = 255
    end
    object qrySupplierWarrantyPeriod: TFloatField
      FieldName = 'WarrantyPeriod'
    end
    object qrySupplierCustomerJobNumber: TWideStringField
      FieldName = 'CustomerJobNumber'
    end
    object qrySupplierhours: TFloatField
      FieldName = 'hours'
    end
    object qrySupplierEmailXML: TWideStringField
      FieldName = 'EmailXML'
      Size = 80
    end
    object qrySupplierInvoiceComment: TWideMemoField
      FieldName = 'InvoiceComment'
      BlobType = ftWideMemo
    end
    object qrySupplierrepairComment: TWideMemoField
      FieldName = 'repairComment'
      BlobType = ftWideMemo
    end
    object qrySupplierInvoiceCommentPopup: TWideStringField
      FieldName = 'InvoiceCommentPopup'
      FixedChar = True
      Size = 1
    end
    object qrySupplierRepairCommentPopUp: TWideStringField
      FieldName = 'RepairCommentPopUp'
      FixedChar = True
      Size = 1
    end
    object qrySupplierSendXMLInvoices: TWideStringField
      FieldName = 'SendXMLInvoices'
      FixedChar = True
      Size = 1
    end
    object qrySupplierSendFTPXMLInvoices: TWideStringField
      FieldName = 'SendFTPXMLInvoices'
      FixedChar = True
      Size = 1
    end
    object qrySupplierForcePOOnRepair: TWideStringField
      FieldName = 'ForcePOOnRepair'
      FixedChar = True
      Size = 1
    end
    object qrySupplierManufactureID: TIntegerField
      FieldName = 'ManufactureID'
    end
    object qrySupplierSpecialProductPriceOverridesAll: TWideStringField
      FieldName = 'SpecialProductPriceOverridesAll'
      FixedChar = True
      Size = 1
    end
    object qrySupplierPortOfLanding: TWideStringField
      FieldName = 'PortOfLanding'
      Size = 100
    end
    object qrySupplierPortOfDischarge: TWideStringField
      FieldName = 'PortOfDischarge'
      Size = 100
    end
    object qrySupplierFinalDestination: TWideStringField
      FieldName = 'FinalDestination'
      Size = 100
    end
    object qrySupplierIncoPlace: TWideStringField
      FieldName = 'IncoPlace'
      Size = 100
    end
    object qrySupplierShippingAgentID: TIntegerField
      FieldName = 'ShippingAgentID'
    end
    object qrySupplierDefaultStatementTemplateId: TIntegerField
      FieldName = 'DefaultStatementTemplateId'
    end
    object qrySupplierTeamviewerID: TWideStringField
      FieldName = 'TeamviewerID'
      Size = 9
    end
    object qrySupplierInsuranceCompanyName: TWideStringField
      FieldName = 'InsuranceCompanyName'
      Size = 255
    end
    object qrySupplierClaimNumber: TWideStringField
      FieldName = 'ClaimNumber'
      Size = 255
    end
    object qrySupplierStormLocation: TWideStringField
      FieldName = 'StormLocation'
      Size = 255
    end
    object qrySupplierStormDate: TDateField
      FieldName = 'StormDate'
    end
    object qrySupplierYear: TDateField
      FieldName = 'Year'
    end
    object qrySupplierColour: TWideStringField
      FieldName = 'Colour'
      Size = 255
    end
    object qrySupplierBodyType: TWideStringField
      FieldName = 'BodyType'
      Size = 255
    end
    object qrySupplierAssessorsName: TWideStringField
      FieldName = 'AssessorsName'
      Size = 255
    end
    object qrySupplierExcessAmount: TFloatField
      FieldName = 'ExcessAmount'
    end
    object qrySupplierBailmentNumber: TWideStringField
      FieldName = 'BailmentNumber'
      Size = 255
    end
    object qrySupplierBailmentAmountEx: TFloatField
      FieldName = 'BailmentAmountEx'
    end
    object qrySupplierStockReceivedDate: TDateField
      FieldName = 'StockReceivedDate'
    end
    object qrySupplierNewOrUsed: TWideStringField
      FieldName = 'NewOrUsed'
      Size = 255
    end
    object qrySuppliermsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
    object qrySupplierDefaultARAccountID: TIntegerField
      FieldName = 'DefaultARAccountID'
    end
    object qrySupplierDefaultARAccountName: TWideStringField
      FieldName = 'DefaultARAccountName'
      Size = 100
    end
    object qrySupplierExpiryDate: TDateField
      FieldName = 'ExpiryDate'
    end
    object qrySupplierExternalRef: TWideStringField
      FieldName = 'ExternalRef'
      Size = 255
    end
    object qrySupplierClientPaysShippment: TWideStringField
      FieldName = 'ClientPaysShippment'
      FixedChar = True
      Size = 1
    end
    object qrySupplierClientShipperAccountNo: TWideStringField
      FieldName = 'ClientShipperAccountNo'
      Size = 255
    end
  end
  object qryDocuments: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      'tblReference.RefID, '
      'tblReference.Ref_Date, '
      'tblReference.Ref_type,'
      'tblReference.Referencetxt, '
      'tblReference.CusID, '
      'tblReference.ContactID,'
      
        'Concat_WS('#39' '#39',tblContacts.ContactFirstName,tblContacts.ContactSu' +
        'rname) as Contact  , '
      'tblReference.Active,'
      'tblReference.MessageId,'
      'tblReference.ReferenceData,'
      'tblReference.MessageFrom,'
      'tblReference.MessageTo,'
      'tblReference.Status'
      'FROM tblReference'
      'LEFT JOIN tblClients ON tblReference.CusID=tblClients.ClientID'
      
        'LEFT JOIN tblContacts ON tblReference.ContactID=tblContacts.Cont' +
        'actID'
      'WHERE tblReference.CusID=:SupID'
      'ORDER BY tblReference.Ref_Date DESC;')
    Filtered = True
    Filter = 'Active ='#39'T'#39
    Left = 408
    Top = 48
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SupID'
      end>
    object qryDocumentsRefID: TIntegerField
      FieldName = 'RefID'
    end
    object qryDocumentsRef_Date: TDateTimeField
      FieldName = 'Ref_Date'
    end
    object qryDocumentsRef_type: TWideStringField
      FieldName = 'Ref_type'
      Size = 50
    end
    object qryDocumentsReferencetxt: TWideStringField
      FieldName = 'Referencetxt'
      Size = 50
    end
    object qryDocumentsCusID: TIntegerField
      FieldName = 'CusID'
    end
    object qryDocumentsContactID: TIntegerField
      FieldName = 'ContactID'
    end
    object qryDocumentsContact: TWideStringField
      FieldName = 'Contact'
      Size = 61
    end
    object qryDocumentsActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryDocumentsMessageId: TWideStringField
      FieldName = 'MessageId'
      Size = 255
    end
    object qryDocumentsReferenceData: TBlobField
      FieldName = 'ReferenceData'
    end
    object qryDocumentsMessageFrom: TWideStringField
      FieldName = 'MessageFrom'
      Size = 255
    end
    object qryDocumentsMessageTo: TWideStringField
      FieldName = 'MessageTo'
      Size = 255
    end
  end
  object qryContacts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT * , Concat_WS('#39' '#39', ContactFirstName, ContactSurName) AS C' +
        'ontactName'
      'FROM tblContacts'
      'WHERE ClientID = :SupID')
    AfterOpen = qryContactsAfterOpen
    Left = 333
    Top = 48
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SupID'
      end>
    object qryContactsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryContactsContactID: TIntegerField
      FieldName = 'ContactID'
    end
    object qryContactsCompany: TWideStringField
      FieldName = 'Company'
      Size = 50
    end
    object qryContactsContactTitle: TWideStringField
      FieldName = 'ContactTitle'
      Size = 32
    end
    object qryContactsContactFirstName: TWideStringField
      FieldName = 'ContactFirstName'
      Size = 30
    end
    object qryContactsContactSurName: TWideStringField
      FieldName = 'ContactSurName'
      Size = 30
    end
    object qryContactsContactAddress: TWideStringField
      FieldName = 'ContactAddress'
      Size = 255
    end
    object qryContactsContactAddress2: TWideStringField
      FieldName = 'ContactAddress2'
      Size = 255
    end
    object qryContactsContactAddress3: TWideStringField
      FieldName = 'ContactAddress3'
      Size = 255
    end
    object qryContactsContactCity: TWideStringField
      FieldName = 'ContactCity'
      Size = 255
    end
    object qryContactsContactState: TWideStringField
      FieldName = 'ContactState'
      Size = 255
    end
    object qryContactsContactPcode: TWideStringField
      FieldName = 'ContactPcode'
      Size = 255
    end
    object qryContactsContactCountry: TWideStringField
      FieldName = 'ContactCountry'
      Size = 255
    end
    object qryContactsContactPH: TWideStringField
      FieldName = 'ContactPH'
      Size = 255
    end
    object qryContactsContactAltPH: TWideStringField
      FieldName = 'ContactAltPH'
      Size = 255
    end
    object qryContactsContactMOB: TWideStringField
      FieldName = 'ContactMOB'
      Size = 255
    end
    object qryContactsContactFax: TWideStringField
      FieldName = 'ContactFax'
      Size = 255
    end
    object qryContactsContactEmail: TWideStringField
      FieldName = 'ContactEmail'
      Size = 255
    end
    object qryContactsNotes: TWideStringField
      FieldName = 'Notes'
      Size = 255
    end
    object qryContactsEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryContactsActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryContactsCardNumber: TWideStringField
      FieldName = 'CardNumber'
      Size = 255
    end
    object qryContactsAccountNo: TWideStringField
      FieldName = 'AccountNo'
      Size = 255
    end
    object qryContactsJobTitle: TWideStringField
      FieldName = 'JobTitle'
      Size = 255
    end
    object qryContactsUseOnRun: TWideStringField
      FieldName = 'UseOnRun'
      FixedChar = True
      Size = 1
    end
    object qryContactsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryContactsLogMeInComputerIPAddress: TWideStringField
      FieldName = 'LogMeInComputerIPAddress'
    end
    object qryContactsLogMeInEmailPassword: TWideStringField
      FieldName = 'LogMeInEmailPassword'
      Size = 100
    end
    object qryContactsLogMeInUserName: TWideStringField
      FieldName = 'LogMeInUserName'
      Size = 100
    end
    object qryContactsLogMeInPassword: TWideStringField
      FieldName = 'LogMeInPassword'
      Size = 100
    end
    object qryContactsLogMeInERPUserName: TWideStringField
      FieldName = 'LogMeInERPUserName'
      Size = 100
    end
    object qryContactsLogMeInERPPassword: TWideStringField
      FieldName = 'LogMeInERPPassword'
      Size = 100
    end
    object qryContactsLogMeIncomputerPassword: TWideStringField
      FieldName = 'LogMeIncomputerPassword'
      Size = 100
    end
    object qryContactsIsPrimarycontact: TWideStringField
      FieldName = 'IsPrimarycontact'
      FixedChar = True
      Size = 1
    end
    object qryContactsTeamviewerID: TWideStringField
      FieldName = 'TeamviewerID'
      Size = 9
    end
    object qryContactsContactName: TWideStringField
      FieldName = 'ContactName'
      Size = 61
    end
    object qryContactsClientID: TIntegerField
      FieldName = 'ClientID'
    end
    object qryContactsClientName: TWideStringField
      FieldName = 'ClientName'
      Size = 255
    end
  end
  object DSContacts: TDataSource
    DataSet = qryContacts
    Left = 333
    Top = 80
  end
  object DSDocuments: TDataSource
    DataSet = qryDocuments
    Left = 408
    Top = 80
  end
  object WordApplication1: TWordApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    Left = 640
    Top = 8
  end
  object dsOtherFollowUp: TDataSource
    DataSet = tbOtherFollowUp
    Left = 370
    Top = 80
  end
  object memqrySupplier: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'ClientID'
        DataType = ftAutoInc
      end
      item
        Name = 'Company'
        DataType = ftString
        Size = 80
      end
      item
        Name = 'ABN'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'Title'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'FirstName'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'MiddleName'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'LastName'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Position'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Street'
        DataType = ftString
        Size = 38
      end
      item
        Name = 'Street2'
        DataType = ftString
        Size = 38
      end
      item
        Name = 'Suburb'
        DataType = ftString
        Size = 27
      end
      item
        Name = 'State'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'Country'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Postcode'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'BillStreet'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'BillStreet2'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'BillSuburb'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'BillState'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'BillCountry'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'BillPostcode'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'POBox'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'POSuburb'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'POState'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'POCountry'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'POPostcode'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'Phone'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'FaxNumber'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Mobile'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Email'
        DataType = ftString
        Size = 80
      end
      item
        Name = 'AltContact'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'AltPhone'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Contact1'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'PhoneSupportTill'
        DataType = ftDate
      end
      item
        Name = 'Contact2'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'Contact1Phone'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Contact2Phone'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Notes'
        DataType = ftWideMemo
      end
      item
        Name = 'ClientNo'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'MedTypeID'
        DataType = ftInteger
      end
      item
        Name = 'TYPE'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'TAXID'
        DataType = ftInteger
      end
      item
        Name = 'CreditLimit'
        DataType = ftFloat
      end
      item
        Name = 'Balance'
        DataType = ftFloat
      end
      item
        Name = 'TERMS'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'TermsID'
        DataType = ftInteger
      end
      item
        Name = 'ShippingMethod'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'ShippingID'
        DataType = ftInteger
      end
      item
        Name = 'Discount'
        DataType = ftFloat
      end
      item
        Name = 'SpecialDiscount'
        DataType = ftFloat
      end
      item
        Name = 'JobName'
        DataType = ftString
        Size = 39
      end
      item
        Name = 'IsJob'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'CUSTFLD1'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD2'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD3'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD4'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD5'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD6'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD7'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD8'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD9'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD10'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD11'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD12'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD13'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD14'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD15'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'PayMethodID'
        DataType = ftInteger
      end
      item
        Name = 'Feedback'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'Customer'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'Supplier'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'OtherContact'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'OtherContactType'
        DataType = ftInteger
      end
      item
        Name = 'RepID'
        DataType = ftInteger
      end
      item
        Name = 'Global'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'Done'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'Active'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'EditedFlag'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'CorrespondenceMethod'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'ShipTime'
        DataType = ftWord
      end
      item
        Name = 'BankAccountName'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'BankAccountBSB'
        DataType = ftString
        Size = 7
      end
      item
        Name = 'BankAccountNo'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'URL'
        DataType = ftString
        Size = 255
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '6.51.00 Standard Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 109
    Top = 48
  end
  object memqryContacts: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'GlobalRef'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'ContactID'
        Attributes = [faReadonly, faFixed]
        DataType = ftAutoInc
      end
      item
        Name = 'CusID'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'SupID'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'EmployeeID'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'Company'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'ContactTitle'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'ContactFirstName'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'ContactSurName'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'ContactAddress'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'ContactCity'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'ContactState'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'ContactPcode'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'ContactPH'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ContactAltPH'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ContactMOB'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ContactFax'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ContactEmail'
        DataType = ftString
        Size = 80
      end
      item
        Name = 'Notes'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'EditedFlag'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'ContactAddress2'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'Active'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'ContactName'
        Attributes = [faReadonly]
        DataType = ftString
        Size = 61
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '6.51.00 Standard Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 146
    Top = 48
  end
  object memtbOtherFollowUp: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '6.51.00 Standard Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 184
    Top = 48
  end
  object qryDocPath: TERPQuery
    SQL.Strings = (
      'Select DPID, DocumentPath '
      'FROM tblDocPath;')
    Options.LongStrings = False
    Left = 792
    Top = 48
  end
  object qryCustomFields: TERPQuery
    SQL.Strings = (
      'SELECT'
      'CFLabel1,CFCust1, CFEmpl1, CFSupp1, CFLabel2,'
      'CFCust2, CFEmpl2, CFSupp2, CFLabel3, CFCust3, CFEmpl3,'
      'CFSupp3, CFLabel4, CFCust4, CFEmpl4, CFSupp4, CFLabel5,'
      'CFCust5, CFEmpl5, CFSupp5, CFLabel6, CFCust6, CFEmpl6,'
      'CFSupp6, CFLabel7, CFCust7, CFEmpl7, CFSupp7, CFLabel8,'
      'CFCust8, CFEmpl8, CFSupp8, CFLabel9, CFCust9, CFEmpl9,'
      'CFSupp9, CFLabel10, CFCust10, CFEmpl10, CFSupp10, CFLabel11,'
      'CFCust11, CFEmpl11, CFSupp11, CFLabel12, CFCust12, CFEmpl12,'
      'CFSupp12, CFLabel13, CFCust13, CFEmpl13, CFSupp13, CFLabel14,'
      'CFCust14, CFEmpl14, CFSupp14, CFLabel15, CFCust15, CFEmpl15,'
      
        'CFSupp15, EditedFlag, CFOthr1, CFOthr2, CFOthr3, CFOthr4, CFOthr' +
        '5,'
      
        'CFOthr6, CFOthr7, CFOthr8, CFOthr9, CFOthr10, CFOthr11, CFOthr12' +
        ','
      
        'CFOthr13, CFOthr14, CFOthr15, CFLabel16, CFCust16, CFEmpl16, CFS' +
        'upp16,'
      
        'CFLabel17, CFCust17, CFEmpl17, CFSupp17, CFLabel18, CFCust18, CF' +
        'Empl18,'
      'CFSupp18'
      'FROM tblcustomfields;')
    Options.LongStrings = False
    Left = 760
    Top = 48
  end
  object subfrmSupRefdocsQry: TERPQuery
    SQL.Strings = (
      
        'SELECT tblReference.RefID, tblReference.Ref_Date, Concat(tblCont' +
        'acts.ContactFirstName , '#39' '#39' , tblContacts.ContactSurName) AS Con' +
        'tact, tblContacts.SupID, tblReference.Ref_type, tblReference.Ref' +
        'erencetxt '
      'FROM tblContacts '
      
        'INNER JOIN tblReference ON tblContacts.ContactID=tblReference.Co' +
        'ntactID '
      
        'GROUP BY tblReference.RefID, tblReference.Ref_Date, Concat(tblCo' +
        'ntacts.ContactFirstName , '#39' '#39' , tblContacts.ContactSurName) , tb' +
        'lContacts.SupID, tblReference.Ref_type, tblReference.Referencetx' +
        't;')
    Options.LongStrings = False
    Left = 728
    Top = 48
  end
  object qryForeignCurrency: TERPQuery
    SQL.Strings = (
      'SELECT CurrencyID, Country, Currency, Code, BuyRate, Active  '
      'FROM tblcurrencyconversion'
      'Where active = '#39'T'#39' ;')
    Options.LongStrings = False
    Left = 696
    Top = 48
  end
  object cboShippingQry: TERPQuery
    SQL.Strings = (
      'SELECT tblShippingMethods.ShippingMethodID, '
      'tblShippingMethods.ShippingMethod '
      'FROM tblShippingMethods '
      'GROUP BY tblShippingMethods.ShippingMethodID, '
      'tblShippingMethods.ShippingMethod '
      'ORDER BY tblShippingMethods.ShippingMethod; '
      '')
    Options.LongStrings = False
    Left = 664
    Top = 48
  end
  object qryPayMethod: TERPQuery
    SQL.Strings = (
      
        'SELECT PayMethodID, Name, IsCreditCard FROM tblpaymentmethods wh' +
        'ere Active ="T";')
    Options.LongStrings = False
    Left = 624
    Top = 48
  end
  object cboTermsQry: TERPQuery
    SQL.Strings = (
      'SELECT tblTerms.TermsID, tblTerms.Terms, tblTerms.TermsAmount,'
      'tblTerms.EOM, tblTerms.EOMPlus, tblTerms.Active '
      'FROM tblTerms WHERE (((tblTerms.Active)<>'#39'F'#39')) '
      'ORDER BY tblTerms.Terms; '
      '')
    Options.LongStrings = False
    Left = 592
    Top = 48
  end
  object SuburbQry: TERPQuery
    SQL.Strings = (
      'SELECT LocationID, City_sub, State, Postcode, Country'
      'FROM tblLocations'
      'Where RegionID= :xRegionID'
      'ORDER BY City_sub;')
    BeforeOpen = SuburbQryBeforeOpen
    Options.LongStrings = False
    Left = 552
    Top = 48
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xRegionID'
      end>
  end
  object qryBankCodes: TERPQuery
    SQL.Strings = (
      'Select CodeID,BankCode,BankName'
      'FROM tblBankCodes '
      'Where (RegionId = :XRegionID) or (BankCode = :BankCode)'
      'Order by BankCode;')
    BeforeOpen = qryBankCodesBeforeOpen
    Options.LongStrings = False
    Left = 520
    Top = 48
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'XRegionID'
      end
      item
        DataType = ftUnknown
        Name = 'BankCode'
      end>
  end
  object qryEmpID: TERPQuery
    SQL.Strings = (
      
        'SELECT EmployeeID, Concat(Firstname, '#39' '#39', LastName) AS EmployeeN' +
        'ame, Active'
      'FROM tblEmployees '
      'WHERE Concat(Firstname, '#39' '#39', LastName)>" " And Active<>'#39'F'#39' '
      'ORDER BY Concat(Firstname, '#39' '#39', LastName); ')
    Options.LongStrings = False
    Left = 488
    Top = 48
  end
  object tbOtherFollowUp: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * '
      'FROM tblotherfollowup'
      'WHERE ClientID= :xClientID;')
    AfterOpen = tbOtherFollowUpAfterOpen
    AfterInsert = tbOtherFollowUpAfterInsert
    AfterScroll = tbOtherFollowUpAfterScroll
    Left = 370
    Top = 48
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xClientID'
      end>
    object tbOtherFollowUpFollowUpDate: TDateTimeField
      DisplayLabel = 'Follow Up Date'
      DisplayWidth = 12
      FieldName = 'FollowUpDate'
    end
    object tbOtherFollowUpEmployeeName: TWideStringField
      DisplayLabel = 'Employee'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'EmployeeName'
      LookupDataSet = qryEmpID
      LookupKeyFields = 'EmployeeID'
      LookupResultField = 'EmployeeName'
      KeyFields = 'EmployeeID'
      Lookup = True
    end
    object tbOtherFollowUpDone: TWideStringField
      DisplayWidth = 4
      FieldName = 'Done'
      FixedChar = True
      Size = 1
    end
    object tbOtherFollowUpEmployeeID: TIntegerField
      DisplayLabel = 'Employee'
      DisplayWidth = 13
      FieldName = 'EmployeeID'
      Visible = False
    end
    object tbOtherFollowUpFollowUpID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'FollowUpID'
      ReadOnly = True
      Visible = False
    end
    object tbOtherFollowUpOtherContactID: TIntegerField
      DisplayWidth = 10
      FieldName = 'OtherContactID'
      Visible = False
    end
    object tbOtherFollowUpRepairID: TIntegerField
      DisplayWidth = 10
      FieldName = 'RepairID'
      Visible = False
    end
    object tbOtherFollowUpEditedFlag: TWideStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tbOtherFollowUpAppearDays: TIntegerField
      DisplayWidth = 10
      FieldName = 'AppearDays'
      Visible = False
    end
    object tbOtherFollowUpCreationDate: TDateTimeField
      DisplayWidth = 18
      FieldName = 'CreationDate'
      Visible = False
    end
    object tbOtherFollowUpClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
      Visible = False
    end
    object tbOtherFollowUpIsSupplier: TWideStringField
      DisplayWidth = 1
      FieldName = 'IsSupplier'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tbOtherFollowUpIsOtherContact: TWideStringField
      DisplayWidth = 1
      FieldName = 'IsOtherContact'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tbOtherFollowUpGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object tbOtherFollowUpUpdateDate: TDateField
      FieldName = 'UpdateDate'
      Visible = False
    end
    object tbOtherFollowUpIsCustomer: TWideStringField
      FieldName = 'IsCustomer'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tbOtherFollowUpLeadLineID: TIntegerField
      DisplayWidth = 10
      FieldName = 'LeadLineID'
    end
    object tbOtherFollowUpNotes: TWideMemoField
      FieldName = 'Notes'
      BlobType = ftWideMemo
    end
  end
  object qryTemplates: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT TemplID, TemplName '
      'FROM tbltemplates  '
      'WHERE TypeID = '#39'19'#39)
    Left = 448
    Top = 48
    object qryTemplatesTemplName: TWideStringField
      DisplayWidth = 30
      FieldName = 'TemplName'
      Size = 30
    end
    object qryTemplatesTemplID: TIntegerField
      DisplayWidth = 10
      FieldName = 'TemplID'
      Visible = False
    end
  end
  object qryEquip: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblcustomerequip'
      'WHERE ClientID=:xClientID')
    Left = 259
    Top = 48
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xClientID'
      end>
    object qryEquipDescription: TWideStringField
      DisplayWidth = 25
      FieldName = 'Description'
      Origin = 'tblcustomerequip.Description'
      Size = 255
    end
    object qryEquipNotes: TWideMemoField
      DisplayLabel = 'Notes   (Double Click to Enter)'
      DisplayWidth = 40
      FieldName = 'Notes'
      Origin = 'tblcustomerequip.Notes'
      BlobType = ftWideMemo
      GraphicHeader = False
    end
    object qryEquipid: TAutoIncField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'id'
      Origin = 'tblcustomerequip.id'
      ReadOnly = True
      Visible = False
    end
    object qryEquipEquipmentID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EquipmentID'
      Origin = 'tblcustomerequip.EquipmentID'
      Visible = False
    end
    object qryEquipClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
      Origin = 'tblcustomerequip.ClientID'
      Visible = False
    end
    object qryEquipGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblcustomerequip.GlobalRef'
      Size = 255
    end
    object qryEquipManufacture: TWideStringField
      FieldName = 'Manufacture'
      Origin = 'tblcustomerequip.Manufacture'
      Size = 100
    end
    object qryEquipModel: TWideStringField
      FieldName = 'Model'
      Origin = 'tblcustomerequip.model'
      Size = 100
    end
    object qryEquipSerialno: TWideStringField
      FieldName = 'Serialno'
      Origin = 'tblcustomerequip.Serialno'
      Size = 100
    end
    object qryEquipRegistration: TWideStringField
      FieldName = 'Registration'
      Origin = 'tblcustomerequip.Registration'
      Size = 100
    end
    object qryEquipWarantyPeriod: TFloatField
      FieldName = 'WarantyPeriod'
      Origin = 'tblcustomerequip.WarantyPeriod'
    end
    object qryEquipWarantyFinishDate: TDateTimeField
      FieldName = 'WarantyFinishDate'
      Origin = 'tblcustomerequip.WarantyFinishDate'
    end
    object qryEquipEquipName: TWideStringField
      FieldName = 'EquipName'
      Origin = 'tblcustomerequip.EquipName'
      Size = 255
    end
    object qryEquipUOM: TWideStringField
      FieldName = 'UOM'
      Origin = 'tblcustomerequip.UOM'
      Size = 50
    end
    object qryEquipUOMID: TLargeintField
      FieldName = 'UOMID'
      Origin = 'tblcustomerequip.UOMID'
    end
    object qryEquipUOMMultiplier: TFloatField
      FieldName = 'UOMMultiplier'
      Origin = 'tblcustomerequip.UOMMultiplier'
    end
    object qryEquipUOMQty: TFloatField
      FieldName = 'UOMQty'
      Origin = 'tblcustomerequip.UOMQty'
    end
    object qryEquipQuantity: TFloatField
      FieldName = 'Quantity'
      Origin = 'tblcustomerequip.Quantity'
    end
    object qryEquipWarantyStartDate: TDateTimeField
      FieldName = 'WarantyStartDate'
    end
  end
  object DSCustomerEquipment: TDataSource
    DataSet = qryEquip
    Left = 259
    Top = 81
  end
  object QryAreaCodes: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select AreaCode, AreaName from tblAreaCodes where active ="T" or' +
        'der by Areacode')
    Left = 79
    Top = 45
    object QryAreaCodesAreaCode: TWideStringField
      DisplayLabel = 'code'
      DisplayWidth = 10
      FieldName = 'AreaCode'
      Size = 50
    end
    object QryAreaCodesAreaName: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 20
      FieldName = 'AreaName'
      Size = 100
    end
  end
  object QrySupplierskills: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblSupplierskills'
      'WHERE ProviderID= :xClientID;')
    AfterOpen = QrySupplierskillsAfterOpen
    AfterInsert = QrySupplierskillsAfterInsert
    Left = 490
    Top = 81
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xClientID'
      end>
    object QrySupplierskillsglobalref: TWideStringField
      FieldName = 'globalref'
      Size = 255
    end
    object QrySupplierskillsID: TIntegerField
      FieldName = 'ID'
    end
    object QrySupplierskillsProviderID: TIntegerField
      FieldName = 'ProviderID'
    end
    object QrySupplierskillsskillid: TIntegerField
      FieldName = 'skillid'
    end
    object QrySupplierskillsActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object QrySupplierskillsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object QrySupplierskillsSkillname: TWideStringField
      FieldName = 'Skillname'
      Size = 100
    end
  end
  object dsSkillProviderskills: TDataSource
    DataSet = QrySupplierskills
    Left = 455
    Top = 81
  end
  object qryskills: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblskills')
    Left = 527
    Top = 81
    object qryskillsSkill: TWideStringField
      DisplayWidth = 20
      FieldName = 'Skill'
      Size = 255
    end
    object qryskillsSkillID: TIntegerField
      FieldName = 'SkillID'
      Visible = False
    end
  end
  object memQrySupplierskills: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '6.51.00 Standard Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 40
    Top = 40
  end
  object QryAPAccounts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT AccountID, AccountName'
      'FROM tblchartofaccounts'
      'WHERE AccountType = '#39'AP'#39' and Active='#39'T'#39';')
    Options.LongStrings = False
    Left = 228
    Top = 358
    object QryAPAccountsAccountID: TIntegerField
      FieldName = 'AccountID'
    end
    object QryAPAccountsAccountName: TWideStringField
      FieldName = 'AccountName'
      Size = 50
    end
  end
  object dsCoreEDIConfig: TDataSource
    DataSet = qryCoreEDIConfig
    Left = 576
    Top = 104
  end
  object qryCoreEDIConfig: TERPQuery
    SQL.Strings = (
      'Select * from tblCoreEDIConfig')
    Left = 568
    Top = 88
  end
end
