inherited frmContact: TfrmContact
  Left = 278
  Top = 186
  HelpContext = 252000
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Contact'
  ClientHeight = 652
  ClientWidth = 783
  Font.Charset = DEFAULT_CHARSET
  Font.Style = []
  ExplicitLeft = 278
  ExplicitTop = 186
  ExplicitWidth = 799
  ExplicitHeight = 691
  DesignSize = (
    783
    652)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 652
    Width = 783
    HelpContext = 252054
    ExplicitTop = 551
    ExplicitWidth = 606
  end
  inherited shapehint: TShape
    Left = 19
    ExplicitLeft = 20
  end
  inherited imgGridWatermark: TImage
    HelpContext = 252001
  end
  inherited shapehintextra1: TShape
    Left = 73
    ExplicitLeft = 77
  end
  object Label8: TLabel [5]
    Left = 324
    Top = 433
    Width = 88
    Height = 15
    HelpContext = 252025
    Caption = 'Team Viewer ID'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Bevel1: TBevel [6]
    Left = 597
    Top = 481
    Width = 151
    Height = 43
    HelpContext = 252055
  end
  object Bevel3: TBevel [7]
    Left = 600
    Top = 480
    Width = 50
    Height = 50
    HelpContext = 252056
  end
  inherited pnlTitle: TDNMPanel
    Left = 255
    TabOrder = 6
    ExplicitLeft = 255
    HelpContext = 252094
  end
  inherited TABCTL20: TPageControl
    Top = 89
    Width = 783
    HelpContext = 252057
    Font.Charset = DEFAULT_CHARSET
    Font.Style = []
    OwnerDraw = True
    ParentFont = False
    TabOrder = 0
    ExplicitTop = 89
    ExplicitWidth = 783
    inherited tsMain: TTabSheet
      Font.Charset = DEFAULT_CHARSET
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 4
      ExplicitTop = 29
      ExplicitWidth = 775
      ExplicitHeight = 474
      inherited MainPanel: TDNMPanel
        Width = 775
        HelpContext = 252058
        ExplicitWidth = 775
        DesignSize = (
          775
          474)
        inherited Box70: TBevel
          Top = 12
          ExplicitTop = 12
        end
        inherited Label27: TLabel
          Top = 47
          ExplicitTop = 47
        end
        inherited Label28: TLabel
          Top = 74
          ExplicitTop = 74
        end
        object Label10: TLabel [7]
          Left = 630
          Top = 408
          Width = 109
          Height = 33
          HelpContext = 252059
          AutoSize = False
          Caption = 'Do not use as any Main contact'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
        end
        inherited Label29: TLabel
          Top = 102
          ExplicitTop = 102
        end
        inherited Label31: TLabel
          Left = 339
          Top = 21
          ExplicitLeft = 339
          ExplicitTop = 21
        end
        inherited Label33: TLabel
          Top = 74
          ExplicitTop = 74
        end
        inherited Label34: TLabel
          Top = 47
          ExplicitTop = 47
        end
        inherited Label35: TLabel
          Top = 101
          ExplicitTop = 101
        end
        inherited Label59: TLabel
          Caption = 'Notes'
          HelpContext = 252095
        end
        inherited Label78: TLabel
          Left = 55
          ExplicitLeft = 55
        end
        inherited Label77: TLabel
          Left = 341
          Top = 128
          Caption = 'Email'
          ExplicitLeft = 341
          ExplicitTop = 128
          HelpContext = 252096
        end
        inherited Label1: TLabel
          Left = 41
          ExplicitLeft = 41
        end
        inherited Label2: TLabel
          Left = 25
          Top = 20
          ExplicitLeft = 25
          ExplicitTop = 20
        end
        inherited lblSuburb: TLabel
          Left = 82
          Caption = 'City'
          ExplicitLeft = 82
          HelpContext = 252097
        end
        inherited lblPostCode: TLabel
          Left = 49
          ExplicitLeft = 49
        end
        inherited lblState: TLabel
          Left = 73
          Caption = 'State'
          ExplicitLeft = 73
          HelpContext = 252098
        end
        inherited Label3: TLabel
          Left = 85
          Top = 157
          Width = 26
          Caption = 'Type'
          ExplicitLeft = 85
          ExplicitTop = 157
          ExplicitWidth = 26
          HelpContext = 252099
        end
        inherited lblCustType: TLabel
          Left = 116
          Top = 157
          ExplicitLeft = 116
          ExplicitTop = 157
        end
        inherited Label4: TLabel
          Left = 66
          Width = 45
          Caption = 'Card No'
          ExplicitLeft = 66
          ExplicitWidth = 45
          HelpContext = 252100
        end
        inherited Label5: TLabel
          Left = 345
          Top = 339
          ExplicitLeft = 345
          ExplicitTop = 339
        end
        inherited Label6: TLabel
          Left = 45
          Top = 129
          Caption = 'Job Title'
          ExplicitLeft = 45
          ExplicitTop = 129
          HelpContext = 252101
        end
        inherited Label7: TLabel
          Left = 41
          ExplicitLeft = 41
        end
        inherited lblCountry: TLabel
          Left = 49
          ExplicitLeft = 49
        end
        object Label11: TLabel [28]
          Left = 322
          Top = 368
          Width = 88
          Height = 15
          HelpContext = 252060
          Caption = 'Team Viewer ID'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        inherited ContactFax: TwwDBEdit
          Top = 72
          TabOrder = 7
          ExplicitTop = 72
        end
        inherited ContactMOB: TwwDBEdit
          Top = 45
          TabOrder = 6
          ExplicitTop = 45
        end
        inherited txtContactAltPH: TwwDBEdit
          Top = 98
          TabOrder = 8
          ExplicitTop = 98
        end
        inherited txtNotes: TDBMemo
          Height = 119
          HelpContext = 252061
          TabOrder = 18
          ExplicitHeight = 119
        end
        inherited txtContactAddress: TDBEdit
          TabOrder = 11
        end
        inherited txtContactEmail: TDBEdit
          Top = 125
          ExplicitTop = 125
        end
        inherited txtContactAddress2: TDBEdit
          TabOrder = 12
        end
        inherited txtCompany: TDBEdit
          Left = 116
          Top = 18
          TabOrder = 0
          ExplicitLeft = 116
          ExplicitTop = 18
        end
        inherited Postcode: TDBEdit
          TabOrder = 16
        end
        inherited Suburb: TwwDBLookupCombo
          TabOrder = 14
          OnEnter = SuburbEnter
        end
        inherited State: TDBEdit
          TabOrder = 15
        end
        inherited chkActive: TwwCheckBox
          Left = 605
          TabOrder = 25
          ExplicitLeft = 605
        end
        inherited edtCardNum: TwwDBEdit
          Left = 115
          Width = 465
          TabOrder = 21
          ExplicitLeft = 115
          ExplicitWidth = 465
          HelpContext = 252102
        end
        inherited wwDBEdit1: TwwDBEdit
          Left = 416
          Top = 335
          Width = 154
          HelpContext = 252062
          TabOrder = 19
          ExplicitLeft = 416
          ExplicitTop = 335
          ExplicitWidth = 154
        end
        inherited JobTitle: TDBEdit
          Left = 116
          Top = 127
          TabOrder = 4
          ExplicitLeft = 116
          ExplicitTop = 127
        end
        inherited txtContactAddress3: TDBEdit
          TabOrder = 13
        end
        inherited edtCountry: TwwDBEdit
          TabOrder = 17
        end
        inherited wwCheckBox1: TwwCheckBox
          Top = 156
          TabOrder = 10
          ExplicitTop = 156
        end
        inherited txtContactFirstName: TDBEdit
          Left = 116
          Top = 72
          TabOrder = 2
          ExplicitLeft = 116
          ExplicitTop = 72
        end
        inherited txtContactTitle: TDBEdit
          Left = 116
          Top = 45
          TabOrder = 1
          ExplicitLeft = 116
          ExplicitTop = 45
        end
        inherited txtContactSurName: TDBEdit
          Left = 116
          Top = 99
          TabOrder = 3
          ExplicitLeft = 116
          ExplicitTop = 99
        end
        inherited ContactPh: TwwDBEdit
          Top = 19
          TabOrder = 5
          ExplicitTop = 19
        end
        inherited chkDoNotContact: TwwCheckBox
          Left = 23
          Top = 455
          ExplicitLeft = 23
          ExplicitTop = 455
        end
        object edtTeamviewerID: TwwDBEdit
          Left = 416
          Top = 364
          Width = 154
          Height = 23
          HelpContext = 252053
          DataField = 'TeamviewerID'
          DataSource = dsContacts
          Picture.PictureMask = '#########[#][#][#][#][#][#]'
          TabOrder = 20
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object chkNotaMainContact: TwwCheckBox
          Left = 605
          Top = 416
          Width = 19
          Height = 17
          HelpContext = 252063
          DisableThemes = False
          AlwaysTransparent = False
          ValueChecked = 'T'
          ValueUnchecked = 'F'
          DisplayValueChecked = 'True'
          DisplayValueUnchecked = 'False'
          NullAndBlankState = cbUnchecked
          DataField = 'NotaMainContact'
          DataSource = dsContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 24
        end
        object pnlMainContact: TDNMPanel
          Left = 591
          Top = 7
          Width = 178
          Height = 395
          HelpContext = 252064
          Anchors = [akLeft, akTop, akRight]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 23
          object Label9: TLabel
            Left = 8
            Top = 8
            Width = 113
            Height = 15
            HelpContext = 252010
            Alignment = taRightJustify
            Caption = 'Primary contact for '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object chkMainContactforPOS: TwwCheckBox
            Left = 15
            Top = 144
            Width = 127
            Height = 17
            HelpContext = 252065
            DisableThemes = False
            AlwaysTransparent = False
            ValueChecked = 'T'
            ValueUnchecked = 'F'
            DisplayValueChecked = 'True'
            DisplayValueUnchecked = 'False'
            NullAndBlankState = cbUnchecked
            Caption = 'POS'
            DataField = 'MainContactforPOS'
            DataSource = dsContacts
            TabOrder = 5
          end
          object chkMainContactforVoucher: TwwCheckBox
            Left = 15
            Top = 353
            Width = 127
            Height = 17
            HelpContext = 252066
            DisableThemes = False
            AlwaysTransparent = False
            ValueChecked = 'T'
            ValueUnchecked = 'F'
            DisplayValueChecked = 'True'
            DisplayValueUnchecked = 'False'
            NullAndBlankState = cbUnchecked
            Caption = 'Voucher'
            DataField = 'MainContactforVoucher'
            DataSource = dsContacts
            TabOrder = 14
          end
          object chkMainContactforCashSale: TwwCheckBox
            Left = 15
            Top = 52
            Width = 127
            Height = 17
            HelpContext = 252067
            DisableThemes = False
            AlwaysTransparent = False
            ValueChecked = 'T'
            ValueUnchecked = 'F'
            DisplayValueChecked = 'True'
            DisplayValueUnchecked = 'False'
            NullAndBlankState = cbUnchecked
            Caption = 'Cash sale'
            DataField = 'MainContactforCashSale'
            DataSource = dsContacts
            TabOrder = 1
          end
          object chkMainContactforRefund: TwwCheckBox
            Left = 15
            Top = 214
            Width = 127
            Height = 17
            HelpContext = 252068
            DisableThemes = False
            AlwaysTransparent = False
            ValueChecked = 'T'
            ValueUnchecked = 'F'
            DisplayValueChecked = 'True'
            DisplayValueUnchecked = 'False'
            NullAndBlankState = cbUnchecked
            Caption = 'Refund'
            DataField = 'MainContactforRefund'
            DataSource = dsContacts
            TabOrder = 8
          end
          object chkMainContactforInvoice: TwwCheckBox
            Left = 15
            Top = 121
            Width = 127
            Height = 17
            HelpContext = 252069
            DisableThemes = False
            AlwaysTransparent = False
            ValueChecked = 'T'
            ValueUnchecked = 'F'
            DisplayValueChecked = 'True'
            DisplayValueUnchecked = 'False'
            NullAndBlankState = cbUnchecked
            Caption = 'Invoice'
            DataField = 'MainContactforInvoice'
            DataSource = dsContacts
            TabOrder = 4
          end
          object chkMainContactforSalesOrder: TwwCheckBox
            Left = 15
            Top = 283
            Width = 127
            Height = 17
            HelpContext = 252070
            DisableThemes = False
            AlwaysTransparent = False
            ValueChecked = 'T'
            ValueUnchecked = 'F'
            DisplayValueChecked = 'True'
            DisplayValueUnchecked = 'False'
            NullAndBlankState = cbUnchecked
            Caption = 'Sales Order'
            DataField = 'MainContactforSalesOrder'
            DataSource = dsContacts
            TabOrder = 11
          end
          object chkMainContactforStatements: TwwCheckBox
            Left = 15
            Top = 306
            Width = 127
            Height = 17
            HelpContext = 252071
            DisableThemes = False
            AlwaysTransparent = False
            ValueChecked = 'T'
            ValueUnchecked = 'F'
            DisplayValueChecked = 'True'
            DisplayValueUnchecked = 'False'
            NullAndBlankState = cbUnchecked
            Caption = 'Statements'
            DataField = 'MainContactforStatements'
            DataSource = dsContacts
            TabOrder = 12
          end
          object chkMainContactforQuote: TwwCheckBox
            Left = 15
            Top = 191
            Width = 127
            Height = 17
            HelpContext = 252072
            DisableThemes = False
            AlwaysTransparent = False
            ValueChecked = 'T'
            ValueUnchecked = 'F'
            DisplayValueChecked = 'True'
            DisplayValueUnchecked = 'False'
            NullAndBlankState = cbUnchecked
            Caption = 'Quote'
            DataField = 'MainContactforQuote'
            DataSource = dsContacts
            TabOrder = 7
          end
          object chkMainContactforCheque: TwwCheckBox
            Left = 15
            Top = 75
            Width = 127
            Height = 17
            HelpContext = 252073
            DisableThemes = False
            AlwaysTransparent = False
            ValueChecked = 'T'
            ValueUnchecked = 'F'
            DisplayValueChecked = 'True'
            DisplayValueUnchecked = 'False'
            NullAndBlankState = cbUnchecked
            Caption = 'Cheque'
            DataField = 'MainContactforCheque'
            DataSource = dsContacts
            TabOrder = 2
          end
          object chkMainContactforCredit: TwwCheckBox
            Left = 15
            Top = 98
            Width = 127
            Height = 17
            HelpContext = 252074
            DisableThemes = False
            AlwaysTransparent = False
            ValueChecked = 'T'
            ValueUnchecked = 'F'
            DisplayValueChecked = 'True'
            DisplayValueUnchecked = 'False'
            NullAndBlankState = cbUnchecked
            Caption = 'Credit'
            DataField = 'MainContactforCredit'
            DataSource = dsContacts
            TabOrder = 3
          end
          object chkMainContactforBill: TwwCheckBox
            Left = 15
            Top = 29
            Width = 127
            Height = 17
            HelpContext = 252075
            DisableThemes = False
            AlwaysTransparent = False
            ValueChecked = 'T'
            ValueUnchecked = 'F'
            DisplayValueChecked = 'True'
            DisplayValueUnchecked = 'False'
            NullAndBlankState = cbUnchecked
            Caption = 'Bill'
            DataField = 'MainContactforBill'
            DataSource = dsContacts
            TabOrder = 0
          end
          object chkMainContactforPO: TwwCheckBox
            Left = 15
            Top = 167
            Width = 127
            Height = 17
            HelpContext = 252076
            DisableThemes = False
            AlwaysTransparent = False
            ValueChecked = 'T'
            ValueUnchecked = 'F'
            DisplayValueChecked = 'True'
            DisplayValueUnchecked = 'False'
            NullAndBlankState = cbUnchecked
            Caption = 'Purchase Order'
            DataField = 'MainContactforPO'
            DataSource = dsContacts
            TabOrder = 6
          end
          object chkMainContactforRA: TwwCheckBox
            Left = 15
            Top = 260
            Width = 127
            Height = 17
            HelpContext = 252077
            DisableThemes = False
            AlwaysTransparent = False
            ValueChecked = 'T'
            ValueUnchecked = 'F'
            DisplayValueChecked = 'True'
            DisplayValueUnchecked = 'False'
            NullAndBlankState = cbUnchecked
            Caption = 'Return Authority'
            DataField = 'MainContactforRA'
            DataSource = dsContacts
            TabOrder = 10
          end
          object chkMainContactforRepair: TwwCheckBox
            Left = 15
            Top = 237
            Width = 127
            Height = 17
            HelpContext = 252078
            DisableThemes = False
            AlwaysTransparent = False
            ValueChecked = 'T'
            ValueUnchecked = 'F'
            DisplayValueChecked = 'True'
            DisplayValueUnchecked = 'False'
            NullAndBlankState = cbUnchecked
            Caption = 'Repair'
            DataField = 'MainContactforRepair'
            DataSource = dsContacts
            TabOrder = 9
          end
          object chkMainContactForSupplierPayment: TwwCheckBox
            Left = 15
            Top = 329
            Width = 127
            Height = 17
            HelpContext = 252079
            DisableThemes = False
            AlwaysTransparent = False
            ValueChecked = 'T'
            ValueUnchecked = 'F'
            DisplayValueChecked = 'True'
            DisplayValueUnchecked = 'False'
            NullAndBlankState = cbUnchecked
            Caption = 'Supplier Payment'
            DataField = 'MainContactForSupplierPayment'
            DataSource = dsContacts
            TabOrder = 13
          end
        end
      end
    end
    object CUSTOM_FIELDS: TTabSheet
      HelpContext = 252080
      Caption = 'Custom Fields'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic, fsUnderline]
      ParentFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object cmdCustomLabels: TDNMSpeedButton
        Left = 285
        Top = 425
        Width = 87
        Height = 27
        Hint = '"Add A New Customised Field For All Customers"'
        HelpContext = 252081
        Caption = '&Add Labels'
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
        TabOrder = 0
      end
      object pnlCustFieldsTab: TDNMPanel
        Left = 0
        Top = 0
        Width = 775
        Height = 474
        HelpContext = 252082
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Transparent = False
        object Label54: TLabel
          Left = 631
          Top = 215
          Width = 3
          Height = 15
          HelpContext = 252083
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label55: TLabel
          Left = 631
          Top = 247
          Width = 3
          Height = 15
          HelpContext = 252084
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object pgCustomFields: TPageControl
          Left = 0
          Top = 0
          Width = 775
          Height = 474
          HelpContext = 252085
          ActivePage = tabCustomFields
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          TabWidth = 387
          object tabCustomFields: TTabSheet
            HelpContext = 252086
            Caption = 'Customisable List'
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object pnlcustomfieldList: TDNMPanel
              Left = 0
              Top = 0
              Width = 767
              Height = 444
              HelpContext = 252087
              Align = alClient
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              object DNMPanel12: TDNMPanel
                Left = 1
                Top = 1
                Width = 765
                Height = 34
                HelpContext = 252088
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
        end
      end
    end
  end
  object ContactID: TDBEdit [10]
    Left = 26
    Top = 14
    Width = 36
    Height = 23
    HelpContext = 252039
    TabStop = False
    DataField = 'ContactID'
    TabOrder = 7
    Visible = False
  end
  object EditedFlag: TDBCheckBox [11]
    Left = 0
    Top = 0
    Width = 17
    Height = 16
    HelpContext = 252041
    TabStop = False
    DataField = 'EditedFlag'
    TabOrder = 8
    ValueChecked = 'True'
    ValueUnchecked = 'False'
    Visible = False
  end
  inherited cmdOk: TDNMSpeedButton
    Left = 88
    Top = 611
    Width = 110
    HelpContext = 252089
    TabOrder = 1
    OnClick = btnOkClick
    ExplicitLeft = 88
    ExplicitTop = 611
    ExplicitWidth = 110
  end
  inherited cmdNew: TDNMSpeedButton
    Top = 611
    Width = 110
    HelpContext = 252090
    TabOrder = 2
    OnClick = cmdAddNewRecordClick
    ExplicitTop = 611
    ExplicitWidth = 110
  end
  inherited cmOriginal: TDNMSpeedButton
    Left = 336
    Top = 611
    Width = 110
    HelpContext = 252091
    TabOrder = 3
    OnClick = cmOriginalClick
    ExplicitLeft = 336
    ExplicitTop = 611
    ExplicitWidth = 110
  end
  inherited cmdClose: TDNMSpeedButton
    Left = 585
    Top = 611
    Width = 110
    HelpContext = 252092
    OnClick = cmdCloseClick
    ExplicitLeft = 585
    ExplicitTop = 611
    ExplicitWidth = 110
  end
  object btnCopyShipping: TDNMSpeedButton [16]
    Left = 460
    Top = 611
    Width = 110
    Height = 27
    HelpContext = 252093
    Caption = 'Copy To Shipping'
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
    TabOrder = 4
    OnClick = btnCopyShippingClick
  end
  inherited popSpelling: TPopupMenu
    Left = 104
    Top = 24
  end
  inherited tmrdelayMsg: TTimer
    Left = 168
    Top = 8
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 147
    Top = 32
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C01010200B400F80010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 42
    Top = 184
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Top = 192
  end
  inherited qryMemTrans: TERPQuery
    Top = 24
  end
  inherited qryContacts: TERPQuery
    AfterOpen = qryContactsAfterOpen
    AfterPost = qryContactsAfterPost
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
      Size = 15
    end
    object qryContactsClientID: TIntegerField
      FieldName = 'ClientID'
    end
    object qryContactsClientName: TWideStringField
      FieldName = 'ClientName'
      Size = 255
    end
    object qryContactsmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
    object qryContactsMainContactforCashSale: TWideStringField
      FieldName = 'MainContactforCashSale'
      FixedChar = True
      Size = 1
    end
    object qryContactsMainContactforVoucher: TWideStringField
      FieldName = 'MainContactforVoucher'
      FixedChar = True
      Size = 1
    end
    object qryContactsMainContactforPOS: TWideStringField
      FieldName = 'MainContactforPOS'
      FixedChar = True
      Size = 1
    end
    object qryContactsMainContactforRefund: TWideStringField
      FieldName = 'MainContactforRefund'
      FixedChar = True
      Size = 1
    end
    object qryContactsMainContactforInvoice: TWideStringField
      FieldName = 'MainContactforInvoice'
      FixedChar = True
      Size = 1
    end
    object qryContactsMainContactforSalesOrder: TWideStringField
      FieldName = 'MainContactforSalesOrder'
      FixedChar = True
      Size = 1
    end
    object qryContactsMainContactforStatements: TWideStringField
      FieldName = 'MainContactforStatements'
      FixedChar = True
      Size = 1
    end
    object qryContactsMainContactforQuote: TWideStringField
      FieldName = 'MainContactforQuote'
      FixedChar = True
      Size = 1
    end
    object qryContactsMainContactforCheque: TWideStringField
      FieldName = 'MainContactforCheque'
      FixedChar = True
      Size = 1
    end
    object qryContactsMainContactforCredit: TWideStringField
      FieldName = 'MainContactforCredit'
      FixedChar = True
      Size = 1
    end
    object qryContactsMainContactforBill: TWideStringField
      FieldName = 'MainContactforBill'
      FixedChar = True
      Size = 1
    end
    object qryContactsMainContactforPO: TWideStringField
      FieldName = 'MainContactforPO'
      FixedChar = True
      Size = 1
    end
    object qryContactsMainContactforRA: TWideStringField
      FieldName = 'MainContactforRA'
      FixedChar = True
      Size = 1
    end
    object qryContactsNotaMainContact: TWideStringField
      FieldName = 'NotaMainContact'
      OnChange = qryContactsNotaMainContactChange
      FixedChar = True
      Size = 1
    end
    object qryContactsMainContactforRepair: TWideStringField
      FieldName = 'MainContactforRepair'
      FixedChar = True
      Size = 1
    end
    object qryContactsDoNotContact: TWideStringField
      FieldName = 'DoNotContact'
      FixedChar = True
      Size = 1
    end
    object qryContactsMainContactForSupplierPayment: TWideStringField
      FieldName = 'MainContactForSupplierPayment'
      FixedChar = True
      Size = 1
    end
  end
  object memqryContacts: TkbmMemTable
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
    Left = 244
    Top = 2
  end
  object qryCustomFields: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM'
      '`tblcustomfields` AS `CF`')
    Options.LongStrings = False
    Left = 666
    Top = 8
  end
end
