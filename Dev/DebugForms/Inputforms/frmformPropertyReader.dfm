inherited fmformPropertyReader: TfmformPropertyReader
  Left = 421
  Top = 120
  HelpContext = 1307002
  Caption = 'fmformPropertyReader'
  ClientHeight = 648
  ClientWidth = 994
  Font.Charset = DEFAULT_CHARSET
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  ExplicitLeft = 421
  ExplicitTop = 120
  ExplicitWidth = 1010
  ExplicitHeight = 687
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 648
    Width = 994
    HelpContext = 1307003
    ExplicitTop = 648
    ExplicitWidth = 994
  end
  object PageControl1: TPageControl [5]
    Left = 0
    Top = 0
    Width = 994
    Height = 648
    HelpContext = 1307004
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      HelpContext = 1307005
      Caption = 'Image Index'
      DesignSize = (
        986
        620)
      object Label3: TLabel
        Left = 59
        Top = 31
        Width = 80
        Height = 13
        HelpContext = 1307006
        Caption = 'Project File (dpr)'
      end
      object Label1: TLabel
        Left = 697
        Top = 33
        Width = 156
        Height = 23
        HelpContext = 1307007
        Caption = 'Next Image to Use'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 333
        Top = 68
        Width = 81
        Height = 13
        HelpContext = 1307008
        Caption = 'Available Images'
        Visible = False
      end
      object Label4: TLabel
        Left = 445
        Top = 68
        Width = 82
        Height = 13
        HelpContext = 1307009
        Caption = 'Duplicate Images'
        Visible = False
      end
      object wwDBGrid1: TwwDBGrid
        Left = 330
        Top = 87
        Width = 132
        Height = 429
        HelpContext = 1307010
        Selected.Strings = (
          'ImageIndex'#9'15'#9'ImageIndex'#9#9)
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        DataSource = dsimageIndexes
        KeyOptions = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
        TabOrder = 5
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        TitleLines = 1
        TitleButtons = False
        Visible = False
      end
      object edtProjectFile: TEdit
        Left = 145
        Top = 28
        Width = 401
        Height = 21
        HelpContext = 1307011
        ReadOnly = True
        TabOrder = 0
        Text = 'C:\dev\ERP\DEv\ERP.dpr'
      end
      object btnGetForms: TButton
        Left = 688
        Top = -5
        Width = 113
        Height = 25
        HelpContext = 1307012
        Caption = 'Get Forms List'
        TabOrder = 1
        Visible = False
        OnClick = btnGetFormsClick
      end
      object lstForms: TCheckListBox
        Left = 8
        Top = 67
        Width = 316
        Height = 214
        HelpContext = 1307013
        ItemHeight = 13
        TabOrder = 2
        Visible = False
      end
      object btnheckforNextImageIndex: TButton
        Left = 870
        Top = -2
        Width = 113
        Height = 25
        HelpContext = 1307014
        Caption = 'Check for Images'
        TabOrder = 3
        Visible = False
        OnClick = btnheckforNextImageIndexClick
      end
      object memImages: TMemo
        Left = 8
        Top = 287
        Width = 316
        Height = 229
        HelpContext = 1307015
        ScrollBars = ssBoth
        TabOrder = 4
        Visible = False
      end
      object btnCheckAll: TButton
        Left = 807
        Top = -5
        Width = 113
        Height = 25
        HelpContext = 1307016
        Caption = 'Check All'
        TabOrder = 6
        Visible = False
        OnClick = btnCheckAllClick
      end
      object btnfind: TButton
        Left = 552
        Top = 3
        Width = 130
        Height = 63
        HelpContext = 1307017
        Caption = 'Find '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -35
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        OnClick = btnfindClick
      end
      object edtNextno: TEdit
        Left = 859
        Top = 29
        Width = 121
        Height = 31
        HelpContext = 1307018
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
      end
      object wwDBGrid2: TwwDBGrid
        Left = 468
        Top = 87
        Width = 514
        Height = 429
        HelpContext = 1307019
        Selected.Strings = (
          'ImageIndex'#9'15'#9'ImageIndex'#9#9
          'TimesUSed'#9'15'#9'TimesUSed'#9#9)
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        Anchors = [akLeft, akTop, akRight]
        DataSource = dsimageIndexesmultiused
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        KeyOptions = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
        ParentFont = False
        TabOrder = 7
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        TitleLines = 1
        TitleButtons = False
        Visible = False
      end
      object DBMemo1: TDBMemo
        Left = 8
        Top = 522
        Width = 729
        Height = 96
        HelpContext = 1307020
        Anchors = [akLeft, akTop, akRight]
        DataField = 'Details'
        DataSource = dsimageIndexesmultiused
        TabOrder = 10
        Visible = False
      end
    end
  end
  inherited MyConnection: TERPConnection
    Connected = True
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C0101020038014C0110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object qryimageIndexes: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select  Allnumbers.ImageIndex , count(UsedNumbers.imageIndex) as' +
        ' TimesUSed  from ('
      'Select 1 as ImageIndex'
      'union all Select 2 as ImageIndex'
      'union all Select 3 as ImageIndex'
      'union all Select 4 as ImageIndex'
      'union all Select 5 as ImageIndex'
      'union all Select 6 as ImageIndex'
      'union all Select 7 as ImageIndex'
      'union all Select 8 as ImageIndex'
      'union all Select 9 as ImageIndex'
      'union all Select 10 as ImageIndex'
      'union all Select 11 as ImageIndex'
      'union all Select 12 as ImageIndex'
      'union all Select 13 as ImageIndex'
      'union all Select 14 as ImageIndex'
      'union all Select 15 as ImageIndex'
      'union all Select 16 as ImageIndex'
      'union all Select 17 as ImageIndex'
      'union all Select 18 as ImageIndex'
      'union all Select 19 as ImageIndex'
      'union all Select 20 as ImageIndex'
      'union all Select 21 as ImageIndex'
      'union all Select 22 as ImageIndex'
      'union all Select 23 as ImageIndex'
      'union all Select 24 as ImageIndex'
      'union all Select 25 as ImageIndex'
      'union all Select 26 as ImageIndex'
      'union all Select 27 as ImageIndex'
      'union all Select 28 as ImageIndex'
      'union all Select 29 as ImageIndex'
      'union all Select 30 as ImageIndex'
      'union all Select 31 as ImageIndex'
      'union all Select 32 as ImageIndex'
      'union all Select 33 as ImageIndex'
      'union all Select 34 as ImageIndex'
      'union all Select 35 as ImageIndex'
      'union all Select 36 as ImageIndex'
      'union all Select 37 as ImageIndex'
      'union all Select 38 as ImageIndex'
      'union all Select 39 as ImageIndex'
      'union all Select 40 as ImageIndex'
      'union all Select 41 as ImageIndex'
      'union all Select 42 as ImageIndex'
      'union all Select 43 as ImageIndex'
      'union all Select 44 as ImageIndex'
      'union all Select 45 as ImageIndex'
      'union all Select 46 as ImageIndex'
      'union all Select 47 as ImageIndex'
      'union all Select 48 as ImageIndex'
      'union all Select 49 as ImageIndex'
      'union all Select 50 as ImageIndex'
      'union all Select 51 as ImageIndex'
      'union all Select 52 as ImageIndex'
      'union all Select 53 as ImageIndex'
      'union all Select 54 as ImageIndex'
      'union all Select 55 as ImageIndex'
      'union all Select 56 as ImageIndex'
      'union all Select 57 as ImageIndex'
      'union all Select 58 as ImageIndex'
      'union all Select 59 as ImageIndex'
      'union all Select 60 as ImageIndex'
      'union all Select 61 as ImageIndex'
      'union all Select 62 as ImageIndex'
      'union all Select 63 as ImageIndex'
      'union all Select 64 as ImageIndex'
      'union all Select 65 as ImageIndex'
      'union all Select 66 as ImageIndex'
      'union all Select 67 as ImageIndex'
      'union all Select 68 as ImageIndex'
      'union all Select 69 as ImageIndex'
      'union all Select 70 as ImageIndex'
      'union all Select 71 as ImageIndex'
      'union all Select 72 as ImageIndex'
      'union all Select 73 as ImageIndex'
      'union all Select 74 as ImageIndex'
      'union all Select 75 as ImageIndex'
      'union all Select 76 as ImageIndex'
      'union all Select 77 as ImageIndex'
      'union all Select 78 as ImageIndex'
      'union all Select 79 as ImageIndex'
      'union all Select 80 as ImageIndex'
      'union all Select 81 as ImageIndex'
      'union all Select 82 as ImageIndex'
      'union all Select 83 as ImageIndex'
      'union all Select 84 as ImageIndex'
      'union all Select 85 as ImageIndex'
      'union all Select 86 as ImageIndex'
      'union all Select 87 as ImageIndex'
      'union all Select 88 as ImageIndex'
      'union all Select 89 as ImageIndex'
      'union all Select 90 as ImageIndex'
      'union all Select 91 as ImageIndex'
      'union all Select 92 as ImageIndex'
      'union all Select 93 as ImageIndex'
      'union all Select 94 as ImageIndex'
      'union all Select 95 as ImageIndex'
      'union all Select 96 as ImageIndex'
      'union all Select 97 as ImageIndex'
      'union all Select 98 as ImageIndex'
      'union all Select 99 as ImageIndex'
      'union all Select 100 as ImageIndex'
      'union all Select 101 as ImageIndex'
      'union all Select 102 as ImageIndex'
      'union all Select 103 as ImageIndex'
      'union all Select 104 as ImageIndex'
      'union all Select 105 as ImageIndex'
      'union all Select 106 as ImageIndex'
      'union all Select 107 as ImageIndex'
      'union all Select 108 as ImageIndex'
      'union all Select 109 as ImageIndex'
      'union all Select 110 as ImageIndex'
      'union all Select 111 as ImageIndex'
      'union all Select 112 as ImageIndex'
      'union all Select 113 as ImageIndex'
      'union all Select 114 as ImageIndex'
      'union all Select 115 as ImageIndex'
      'union all Select 116 as ImageIndex'
      'union all Select 117 as ImageIndex'
      'union all Select 118 as ImageIndex'
      'union all Select 119 as ImageIndex'
      'union all Select 120 as ImageIndex'
      'union all Select 121 as ImageIndex'
      'union all Select 122 as ImageIndex'
      'union all Select 123 as ImageIndex'
      'union all Select 124 as ImageIndex'
      'union all Select 125 as ImageIndex'
      'union all Select 126 as ImageIndex'
      'union all Select 127 as ImageIndex'
      'union all Select 128 as ImageIndex'
      'union all Select 129 as ImageIndex'
      'union all Select 130 as ImageIndex'
      'union all Select 131 as ImageIndex'
      'union all Select 132 as ImageIndex'
      'union all Select 133 as ImageIndex'
      'union all Select 134 as ImageIndex'
      'union all Select 135 as ImageIndex'
      'union all Select 136 as ImageIndex'
      'union all Select 137 as ImageIndex'
      'union all Select 138 as ImageIndex'
      'union all Select 139 as ImageIndex'
      'union all Select 140 as ImageIndex'
      'union all Select 141 as ImageIndex'
      'union all Select 142 as ImageIndex'
      'union all Select 143 as ImageIndex'
      'union all Select 144 as ImageIndex'
      'union all Select 145 as ImageIndex'
      'union all Select 146 as ImageIndex'
      'union all Select 147 as ImageIndex'
      'union all Select 148 as ImageIndex'
      'union all Select 149 as ImageIndex'
      'union all Select 150 as ImageIndex'
      'union all Select 151 as ImageIndex'
      'union all Select 152 as ImageIndex'
      'union all Select 153 as ImageIndex'
      'union all Select 154 as ImageIndex'
      'union all Select 155 as ImageIndex'
      'union all Select 156 as ImageIndex'
      'union all Select 157 as ImageIndex'
      'union all Select 158 as ImageIndex'
      'union all Select 159 as ImageIndex'
      'union all Select 160 as ImageIndex'
      'union all Select 161 as ImageIndex'
      'union all Select 162 as ImageIndex'
      'union all Select 163 as ImageIndex'
      'union all Select 164 as ImageIndex'
      'union all Select 165 as ImageIndex'
      'union all Select 166 as ImageIndex'
      'union all Select 167 as ImageIndex'
      'union all Select 168 as ImageIndex'
      'union all Select 169 as ImageIndex'
      'union all Select 170 as ImageIndex'
      'union all Select 171 as ImageIndex'
      'union all Select 172 as ImageIndex'
      'union all Select 173 as ImageIndex'
      'union all Select 174 as ImageIndex'
      'union all Select 175 as ImageIndex'
      'union all Select 176 as ImageIndex'
      'union all Select 177 as ImageIndex'
      'union all Select 178 as ImageIndex'
      'union all Select 179 as ImageIndex'
      'union all Select 180 as ImageIndex'
      'union all Select 181 as ImageIndex'
      'union all Select 182 as ImageIndex'
      'union all Select 183 as ImageIndex'
      'union all Select 184 as ImageIndex'
      'union all Select 185 as ImageIndex'
      'union all Select 186 as ImageIndex'
      'union all Select 187 as ImageIndex'
      'union all Select 188 as ImageIndex'
      'union all Select 189 as ImageIndex'
      'union all Select 190 as ImageIndex'
      'union all Select 191 as ImageIndex'
      'union all Select 192 as ImageIndex'
      'union all Select 193 as ImageIndex'
      'union all Select 194 as ImageIndex'
      'union all Select 195 as ImageIndex'
      'union all Select 196 as ImageIndex'
      'union all Select 197 as ImageIndex'
      'union all Select 198 as ImageIndex'
      'union all Select 199 as ImageIndex'
      'union all Select 200 as ImageIndex'
      'union all Select 201 as ImageIndex'
      'union all Select 202 as ImageIndex'
      'union all Select 203 as ImageIndex'
      'union all Select 204 as ImageIndex'
      'union all Select 205 as ImageIndex'
      'union all Select 206 as ImageIndex'
      'union all Select 207 as ImageIndex'
      'union all Select 208 as ImageIndex'
      'union all Select 209 as ImageIndex'
      'union all Select 210 as ImageIndex'
      'union all Select 211 as ImageIndex'
      'union all Select 212 as ImageIndex'
      'union all Select 213 as ImageIndex'
      'union all Select 214 as ImageIndex'
      'union all Select 215 as ImageIndex'
      'union all Select 216 as ImageIndex'
      'union all Select 217 as ImageIndex'
      'union all Select 218 as ImageIndex'
      'union all Select 219 as ImageIndex'
      'union all Select 220 as ImageIndex'
      'union all Select 221 as ImageIndex'
      'union all Select 222 as ImageIndex'
      'union all Select 223 as ImageIndex'
      'union all Select 224 as ImageIndex'
      'union all Select 225 as ImageIndex'
      'union all Select 226 as ImageIndex'
      'union all Select 227 as ImageIndex'
      'union all Select 228 as ImageIndex'
      'union all Select 229 as ImageIndex'
      'union all Select 230 as ImageIndex'
      'union all Select 231 as ImageIndex'
      'union all Select 232 as ImageIndex'
      'union all Select 233 as ImageIndex'
      'union all Select 234 as ImageIndex'
      'union all Select 235 as ImageIndex'
      'union all Select 236 as ImageIndex'
      'union all Select 237 as ImageIndex'
      'union all Select 238 as ImageIndex'
      'union all Select 239 as ImageIndex'
      'union all Select 240 as ImageIndex'
      'union all Select 241 as ImageIndex'
      'union all Select 242 as ImageIndex'
      'union all Select 243 as ImageIndex'
      'union all Select 244 as ImageIndex'
      'union all Select 245 as ImageIndex'
      'union all Select 246 as ImageIndex'
      'union all Select 247 as ImageIndex'
      'union all Select 248 as ImageIndex'
      'union all Select 249 as ImageIndex'
      'union all Select 250 as ImageIndex'
      'union all Select 251 as ImageIndex'
      'union all Select 252 as ImageIndex'
      'union all Select 253 as ImageIndex'
      'union all Select 254 as ImageIndex'
      'union all Select 255 as ImageIndex'
      'union all Select 256 as ImageIndex'
      'union all Select 257 as ImageIndex'
      'union all Select 258 as ImageIndex'
      'union all Select 259 as ImageIndex'
      'union all Select 260 as ImageIndex'
      'union all Select 261 as ImageIndex'
      'union all Select 262 as ImageIndex'
      'union all Select 263 as ImageIndex'
      'union all Select 264 as ImageIndex'
      'union all Select 265 as ImageIndex'
      'union all Select 266 as ImageIndex'
      'union all Select 267 as ImageIndex'
      'union all Select 268 as ImageIndex'
      'union all Select 269 as ImageIndex'
      'union all Select 270 as ImageIndex'
      'union all Select 271 as ImageIndex'
      'union all Select 272 as ImageIndex'
      'union all Select 273 as ImageIndex'
      'union all Select 274 as ImageIndex'
      'union all Select 275 as ImageIndex'
      'union all Select 276 as ImageIndex'
      'union all Select 277 as ImageIndex'
      'union all Select 278 as ImageIndex'
      'union all Select 279 as ImageIndex'
      'union all Select 280 as ImageIndex'
      'union all Select 281 as ImageIndex'
      'union all Select 282 as ImageIndex'
      'union all Select 283 as ImageIndex'
      'union all Select 284 as ImageIndex'
      'union all Select 285 as ImageIndex'
      'union all Select 286 as ImageIndex'
      'union all Select 287 as ImageIndex'
      'union all Select 288 as ImageIndex'
      'union all Select 289 as ImageIndex'
      'union all Select 290 as ImageIndex'
      'union all Select 291 as ImageIndex'
      'union all Select 292 as ImageIndex'
      'union all Select 293 as ImageIndex'
      'union all Select 294 as ImageIndex'
      'union all Select 295 as ImageIndex'
      'union all Select 296 as ImageIndex'
      'union all Select 297 as ImageIndex'
      'union all Select 298 as ImageIndex'
      'union all Select 299 as ImageIndex'
      'union all Select 300 as ImageIndex'
      'union all Select 301 as ImageIndex'
      'union all Select 302 as ImageIndex'
      'union all Select 303 as ImageIndex'
      'union all Select 304 as ImageIndex'
      'union all Select 305 as ImageIndex'
      'union all Select 306 as ImageIndex'
      'union all Select 307 as ImageIndex'
      'union all Select 308 as ImageIndex'
      'union all Select 309 as ImageIndex'
      'union all Select 310 as ImageIndex'
      'union all Select 311 as ImageIndex'
      'union all Select 312 as ImageIndex'
      'union all Select 313 as ImageIndex'
      'union all Select 314 as ImageIndex'
      'union all Select 315 as ImageIndex'
      'union all Select 316 as ImageIndex'
      'union all Select 317 as ImageIndex'
      'union all Select 318 as ImageIndex'
      'union all Select 319 as ImageIndex'
      'union all Select 320 as ImageIndex'
      'union all Select 321 as ImageIndex'
      'union all Select 322 as ImageIndex'
      'union all Select 323 as ImageIndex'
      'union all Select 324 as ImageIndex'
      'union all Select 325 as ImageIndex'
      'union all Select 326 as ImageIndex'
      'union all Select 327 as ImageIndex'
      'union all Select 328 as ImageIndex'
      'union all Select 329 as ImageIndex'
      'union all Select 330 as ImageIndex'
      'union all Select 331 as ImageIndex'
      'union all Select 332 as ImageIndex'
      'union all Select 333 as ImageIndex'
      'union all Select 334 as ImageIndex'
      'union all Select 335 as ImageIndex'
      'union all Select 336 as ImageIndex'
      'union all Select 337 as ImageIndex'
      'union all Select 338 as ImageIndex'
      'union all Select 339 as ImageIndex'
      'union all Select 340 as ImageIndex'
      'union all Select 341 as ImageIndex'
      'union all Select 342 as ImageIndex'
      'union all Select 343 as ImageIndex'
      'union all Select 344 as ImageIndex'
      'union all Select 345 as ImageIndex'
      'union all Select 346 as ImageIndex'
      'union all Select 347 as ImageIndex'
      'union all Select 348 as ImageIndex'
      'union all Select 349 as ImageIndex'
      'union all Select 350 as ImageIndex'
      'union all Select 351 as ImageIndex'
      'union all Select 352 as ImageIndex'
      'union all Select 353 as ImageIndex'
      'union all Select 354 as ImageIndex'
      'union all Select 355 as ImageIndex'
      'union all Select 356 as ImageIndex'
      'union all Select 357 as ImageIndex'
      'union all Select 358 as ImageIndex'
      'union all Select 359 as ImageIndex'
      'union all Select 360 as ImageIndex'
      'union all Select 361 as ImageIndex'
      'union all Select 362 as ImageIndex'
      'union all Select 363 as ImageIndex'
      'union all Select 364 as ImageIndex'
      'union all Select 365 as ImageIndex'
      'union all Select 366 as ImageIndex'
      'union all Select 367 as ImageIndex'
      'union all Select 368 as ImageIndex'
      'union all Select 369 as ImageIndex'
      'union all Select 370 as ImageIndex'
      'union all Select 371 as ImageIndex'
      'union all Select 372 as ImageIndex'
      'union all Select 373 as ImageIndex'
      'union all Select 374 as ImageIndex'
      'union all Select 375 as ImageIndex'
      'union all Select 376 as ImageIndex'
      'union all Select 377 as ImageIndex'
      'union all Select 378 as ImageIndex'
      'union all Select 379 as ImageIndex'
      'union all Select 380 as ImageIndex'
      'union all Select 381 as ImageIndex'
      'union all Select 382 as ImageIndex'
      'union all Select 383 as ImageIndex'
      'union all Select 384 as ImageIndex'
      'union all Select 385 as ImageIndex'
      'union all Select 386 as ImageIndex'
      'union all Select 387 as ImageIndex'
      'union all Select 388 as ImageIndex'
      'union all Select 389 as ImageIndex'
      'union all Select 390 as ImageIndex'
      'union all Select 391 as ImageIndex'
      'union all Select 392 as ImageIndex'
      'union all Select 393 as ImageIndex'
      'union all Select 394 as ImageIndex'
      'union all Select 395 as ImageIndex'
      'union all Select 396 as ImageIndex'
      'union all Select 397 as ImageIndex'
      'union all Select 398 as ImageIndex'
      'union all Select 399 as ImageIndex'
      'union all Select 400 as ImageIndex'
      'union all Select 401 as ImageIndex'
      'union all Select 402 as ImageIndex'
      'union all Select 403 as ImageIndex'
      'union all Select 404 as ImageIndex'
      'union all Select 405 as ImageIndex'
      'union all Select 406 as ImageIndex'
      'union all Select 407 as ImageIndex'
      'union all Select 408 as ImageIndex'
      'union all Select 409 as ImageIndex'
      'union all Select 410 as ImageIndex'
      'union all Select 411 as ImageIndex'
      'union all Select 412 as ImageIndex'
      'union all Select 413 as ImageIndex'
      'union all Select 414 as ImageIndex'
      'union all Select 415 as ImageIndex'
      'union all Select 416 as ImageIndex'
      'union all Select 417 as ImageIndex'
      'union all Select 418 as ImageIndex'
      'union all Select 419 as ImageIndex'
      'union all Select 420 as ImageIndex'
      'union all Select 421 as ImageIndex'
      'union all Select 422 as ImageIndex'
      'union all Select 423 as ImageIndex'
      'union all Select 424 as ImageIndex'
      'union all Select 425 as ImageIndex'
      'union all Select 426 as ImageIndex'
      'union all Select 427 as ImageIndex'
      'union all Select 428 as ImageIndex'
      'union all Select 429 as ImageIndex'
      'union all Select 430 as ImageIndex'
      'union all Select 431 as ImageIndex'
      'union all Select 432 as ImageIndex'
      'union all Select 433 as ImageIndex'
      'union all Select 434 as ImageIndex'
      'union all Select 435 as ImageIndex'
      'union all Select 436 as ImageIndex'
      'union all Select 437 as ImageIndex'
      'union all Select 438 as ImageIndex'
      'union all Select 439 as ImageIndex'
      'union all Select 440 as ImageIndex'
      'union all Select 441 as ImageIndex'
      'union all Select 442 as ImageIndex'
      'union all Select 443 as ImageIndex'
      'union all Select 444 as ImageIndex'
      'union all Select 445 as ImageIndex'
      'union all Select 446 as ImageIndex'
      'union all Select 447 as ImageIndex'
      'union all Select 448 as ImageIndex'
      'union all Select 449 as ImageIndex'
      'union all Select 450 as ImageIndex'
      'union all Select 451 as ImageIndex'
      'union all Select 452 as ImageIndex'
      'union all Select 453 as ImageIndex'
      'union all Select 454 as ImageIndex'
      'union all Select 455 as ImageIndex'
      'union all Select 456 as ImageIndex'
      'union all Select 457 as ImageIndex'
      'union all Select 458 as ImageIndex'
      'union all Select 459 as ImageIndex'
      'union all Select 460 as ImageIndex'
      'union all Select 461 as ImageIndex'
      'union all Select 462 as ImageIndex'
      'union all Select 463 as ImageIndex'
      'union all Select 464 as ImageIndex'
      'union all Select 465 as ImageIndex'
      'union all Select 466 as ImageIndex'
      'union all Select 467 as ImageIndex'
      'union all Select 468 as ImageIndex'
      'union all Select 469 as ImageIndex'
      'union all Select 470 as ImageIndex'
      'union all Select 471 as ImageIndex'
      'union all Select 472 as ImageIndex'
      'union all Select 473 as ImageIndex'
      'union all Select 474 as ImageIndex'
      'union all Select 475 as ImageIndex'
      'union all Select 476 as ImageIndex'
      'union all Select 477 as ImageIndex'
      'union all Select 478 as ImageIndex'
      'union all Select 479 as ImageIndex'
      'union all Select 480 as ImageIndex'
      'union all Select 481 as ImageIndex'
      'union all Select 482 as ImageIndex'
      'union all Select 483 as ImageIndex'
      'union all Select 484 as ImageIndex'
      'union all Select 485 as ImageIndex'
      'union all Select 486 as ImageIndex'
      'union all Select 487 as ImageIndex'
      'union all Select 488 as ImageIndex'
      'union all Select 489 as ImageIndex'
      'union all Select 490 as ImageIndex'
      'union all Select 491 as ImageIndex'
      'union all Select 492 as ImageIndex'
      'union all Select 493 as ImageIndex'
      'union all Select 494 as ImageIndex'
      'union all Select 495 as ImageIndex'
      'union all Select 496 as ImageIndex'
      'union all Select 497 as ImageIndex'
      'union all Select 498 as ImageIndex'
      'union all Select 499 as ImageIndex'
      'union all Select 500 as ImageIndex'
      'union all Select 501 as ImageIndex'
      'union all Select 502 as ImageIndex'
      'union all Select 503 as ImageIndex'
      'union all Select 504 as ImageIndex'
      'union all Select 505 as ImageIndex'
      'union all Select 506 as ImageIndex'
      'union all Select 507 as ImageIndex'
      'union all Select 508 as ImageIndex'
      'union all Select 509 as ImageIndex'
      'union all Select 510 as ImageIndex'
      'union all Select 511 as ImageIndex'
      'union all Select 512 as ImageIndex'
      'union all Select 513 as ImageIndex'
      'union all Select 514 as ImageIndex'
      'union all Select 515 as ImageIndex'
      'union all Select 516 as ImageIndex'
      'union all Select 517 as ImageIndex'
      'union all Select 518 as ImageIndex'
      'union all Select 519 as ImageIndex'
      'union all Select 520 as ImageIndex'
      'union all Select 521 as ImageIndex'
      'union all Select 522 as ImageIndex'
      'union all Select 523 as ImageIndex'
      'union all Select 524 as ImageIndex'
      'union all Select 525 as ImageIndex'
      'union all Select 526 as ImageIndex'
      'union all Select 527 as ImageIndex'
      'union all Select 528 as ImageIndex'
      'union all Select 529 as ImageIndex'
      'union all Select 530 as ImageIndex'
      'union all Select 531 as ImageIndex'
      'union all Select 532 as ImageIndex'
      'union all Select 533 as ImageIndex'
      'union all Select 534 as ImageIndex'
      'union all Select 535 as ImageIndex'
      'union all Select 536 as ImageIndex'
      'union all Select 537 as ImageIndex'
      'union all Select 538 as ImageIndex'
      'union all Select 539 as ImageIndex'
      'union all Select 540 as ImageIndex'
      'union all Select 541 as ImageIndex'
      'union all Select 542 as ImageIndex'
      'union all Select 543 as ImageIndex'
      'union all Select 544 as ImageIndex'
      'union all Select 545 as ImageIndex'
      'union all Select 546 as ImageIndex'
      'union all Select 547 as ImageIndex'
      'union all Select 548 as ImageIndex'
      'union all Select 549 as ImageIndex'
      'union all Select 550 as ImageIndex'
      'union all Select 551 as ImageIndex'
      'union all Select 552 as ImageIndex'
      'union all Select 553 as ImageIndex'
      'union all Select 554 as ImageIndex'
      'union all Select 555 as ImageIndex'
      'union all Select 556 as ImageIndex'
      'union all Select 557 as ImageIndex'
      'union all Select 558 as ImageIndex'
      'union all Select 559 as ImageIndex'
      'union all Select 560 as ImageIndex'
      'union all Select 561 as ImageIndex'
      'union all Select 562 as ImageIndex'
      'union all Select 563 as ImageIndex'
      'union all Select 564 as ImageIndex'
      'union all Select 565 as ImageIndex'
      'union all Select 566 as ImageIndex'
      'union all Select 567 as ImageIndex'
      'union all Select 568 as ImageIndex'
      'union all Select 569 as ImageIndex'
      'union all Select 570 as ImageIndex'
      'union all Select 571 as ImageIndex'
      'union all Select 572 as ImageIndex'
      'union all Select 573 as ImageIndex'
      'union all Select 574 as ImageIndex'
      'union all Select 575 as ImageIndex'
      'union all Select 576 as ImageIndex'
      'union all Select 577 as ImageIndex'
      'union all Select 578 as ImageIndex'
      'union all Select 579 as ImageIndex'
      'union all Select 580 as ImageIndex'
      'union all Select 581 as ImageIndex'
      'union all Select 582 as ImageIndex'
      'union all Select 583 as ImageIndex'
      'union all Select 584 as ImageIndex'
      'union all Select 585 as ImageIndex'
      'union all Select 586 as ImageIndex'
      'union all Select 587 as ImageIndex'
      'union all Select 588 as ImageIndex'
      'union all Select 589 as ImageIndex'
      'union all Select 590 as ImageIndex'
      'union all Select 591 as ImageIndex'
      'union all Select 592 as ImageIndex'
      'union all Select 593 as ImageIndex'
      'union all Select 594 as ImageIndex'
      'union all Select 595 as ImageIndex'
      'union all Select 596 as ImageIndex'
      'union all Select 597 as ImageIndex'
      'union all Select 598 as ImageIndex'
      'union all Select 599 as ImageIndex'
      'union all Select 600 as ImageIndex'
      'union all Select 601 as ImageIndex'
      'union all Select 602 as ImageIndex'
      'union all Select 603 as ImageIndex'
      'union all Select 604 as ImageIndex'
      'union all Select 605 as ImageIndex'
      'union all Select 606 as ImageIndex'
      'union all Select 607 as ImageIndex'
      'union all Select 608 as ImageIndex'
      'union all Select 609 as ImageIndex'
      'union all Select 610 as ImageIndex'
      'union all Select 611 as ImageIndex'
      'union all Select 612 as ImageIndex'
      'union all Select 613 as ImageIndex'
      'union all Select 614 as ImageIndex'
      'union all Select 615 as ImageIndex'
      'union all Select 616 as ImageIndex'
      'union all Select 617 as ImageIndex'
      'union all Select 618 as ImageIndex'
      'union all Select 619 as ImageIndex'
      'union all Select 620 as ImageIndex'
      'union all Select 621 as ImageIndex'
      'union all Select 622 as ImageIndex'
      'union all Select 623 as ImageIndex'
      'union all Select 624 as ImageIndex'
      'union all Select 625 as ImageIndex'
      'union all Select 626 as ImageIndex'
      'union all Select 627 as ImageIndex'
      'union all Select 628 as ImageIndex'
      'union all Select 629 as ImageIndex'
      'union all Select 630 as ImageIndex'
      'union all Select 631 as ImageIndex'
      'union all Select 632 as ImageIndex'
      'union all Select 633 as ImageIndex'
      'union all Select 634 as ImageIndex'
      'union all Select 635 as ImageIndex'
      'union all Select 636 as ImageIndex'
      'union all Select 637 as ImageIndex'
      'union all Select 638 as ImageIndex'
      'union all Select 639 as ImageIndex'
      'union all Select 640 as ImageIndex'
      'union all Select 641 as ImageIndex'
      'union all Select 642 as ImageIndex'
      'union all Select 643 as ImageIndex'
      'union all Select 644 as ImageIndex'
      'union all Select 645 as ImageIndex'
      'union all Select 646 as ImageIndex'
      'union all Select 647 as ImageIndex'
      'union all Select 648 as ImageIndex'
      'union all Select 649 as ImageIndex'
      'union all Select 650 as ImageIndex'
      'union all Select 651 as ImageIndex'
      'union all Select 652 as ImageIndex'
      'union all Select 653 as ImageIndex'
      'union all Select 654 as ImageIndex'
      'union all Select 655 as ImageIndex'
      'union all Select 656 as ImageIndex'
      'union all Select 657 as ImageIndex'
      'union all Select 658 as ImageIndex'
      'union all Select 659 as ImageIndex'
      'union all Select 660 as ImageIndex'
      'union all Select 661 as ImageIndex'
      'union all Select 662 as ImageIndex'
      'union all Select 663 as ImageIndex'
      'union all Select 664 as ImageIndex'
      'union all Select 665 as ImageIndex'
      'union all Select 666 as ImageIndex'
      'union all Select 667 as ImageIndex'
      'union all Select 668 as ImageIndex'
      'union all Select 669 as ImageIndex'
      'union all Select 670 as ImageIndex'
      'union all Select 671 as ImageIndex'
      'union all Select 672 as ImageIndex'
      'union all Select 673 as ImageIndex'
      'union all Select 674 as ImageIndex'
      'union all Select 675 as ImageIndex'
      'union all Select 676 as ImageIndex'
      'union all Select 677 as ImageIndex'
      'union all Select 678 as ImageIndex'
      'union all Select 679 as ImageIndex'
      'union all Select 680 as ImageIndex'
      'union all Select 681 as ImageIndex'
      'union all Select 682 as ImageIndex'
      'union all Select 683 as ImageIndex'
      'union all Select 684 as ImageIndex'
      'union all Select 685 as ImageIndex'
      'union all Select 686 as ImageIndex'
      'union all Select 687 as ImageIndex'
      'union all Select 688 as ImageIndex'
      'union all Select 689 as ImageIndex'
      'union all Select 690 as ImageIndex'
      'union all Select 691 as ImageIndex'
      'union all Select 692 as ImageIndex'
      'union all Select 693 as ImageIndex'
      'union all Select 694 as ImageIndex'
      'union all Select 695 as ImageIndex'
      'union all Select 696 as ImageIndex'
      'union all Select 697 as ImageIndex'
      'union all Select 698 as ImageIndex'
      'union all Select 699 as ImageIndex'
      'union all Select 700 as ImageIndex'
      'union all Select 701 as ImageIndex'
      'union all Select 702 as ImageIndex'
      'union all Select 703 as ImageIndex'
      'union all Select 704 as ImageIndex'
      'union all Select 705 as ImageIndex'
      'union all Select 706 as ImageIndex'
      'union all Select 707 as ImageIndex'
      'union all Select 708 as ImageIndex'
      'union all Select 709 as ImageIndex'
      'union all Select 710 as ImageIndex'
      'union all Select 711 as ImageIndex'
      'union all Select 712 as ImageIndex'
      'union all Select 713 as ImageIndex'
      'union all Select 714 as ImageIndex'
      'union all Select 715 as ImageIndex'
      'union all Select 716 as ImageIndex'
      'union all Select 717 as ImageIndex'
      'union all Select 718 as ImageIndex'
      'union all Select 719 as ImageIndex'
      'union all Select 720 as ImageIndex'
      'union all Select 721 as ImageIndex'
      'union all Select 722 as ImageIndex'
      'union all Select 723 as ImageIndex'
      'union all Select 724 as ImageIndex'
      'union all Select 725 as ImageIndex'
      'union all Select 726 as ImageIndex'
      'union all Select 727 as ImageIndex'
      'union all Select 728 as ImageIndex'
      'union all Select 729 as ImageIndex'
      'union all Select 730 as ImageIndex'
      'union all Select 731 as ImageIndex'
      'union all Select 732 as ImageIndex'
      'union all Select 733 as ImageIndex'
      'union all Select 734 as ImageIndex'
      'union all Select 735 as ImageIndex'
      'union all Select 736 as ImageIndex'
      'union all Select 737 as ImageIndex'
      'union all Select 738 as ImageIndex'
      'union all Select 739 as ImageIndex'
      'union all Select 740 as ImageIndex'
      'union all Select 741 as ImageIndex'
      'union all Select 742 as ImageIndex'
      'union all Select 743 as ImageIndex'
      'union all Select 744 as ImageIndex'
      'union all Select 745 as ImageIndex'
      'union all Select 746 as ImageIndex'
      'union all Select 747 as ImageIndex'
      'union all Select 748 as ImageIndex'
      'union all Select 749 as ImageIndex'
      'union all Select 750 as ImageIndex'
      'union all Select 751 as ImageIndex'
      'union all Select 752 as ImageIndex'
      'union all Select 753 as ImageIndex'
      'union all Select 754 as ImageIndex'
      'union all Select 755 as ImageIndex'
      'union all Select 756 as ImageIndex'
      'union all Select 757 as ImageIndex'
      'union all Select 758 as ImageIndex'
      'union all Select 759 as ImageIndex'
      
        ')  Allnumbers   Left join ( Select 0 as ImageIndex ,  '#39'Appointme' +
        'nts\InputForms\frmAppointments.ActUpdateRepairs=0'#39' as ActionDeta' +
        'ils union all  Select 0 as ImageIndex ,  '#39'BaseClasses\InputForms' +
        '\Cash.actcheckdiscount=0'#39' as ActionDetails union all  Select 322' +
        ' as ImageIndex ,  '#39'Budgets\Module\datBudgetAddin.actBudgetDefini' +
        'tion=322'#39' as ActionDetails union all  Select 347 as ImageIndex ,' +
        '  '#39'Budgets\Module\datBudgetAddin.actBudget=347'#39' as ActionDetails' +
        ' union all  Select 314 as ImageIndex ,  '#39'Budgets\Module\datBudge' +
        'tAddin.actBudgetVariation=314'#39' as ActionDetails union all  Selec' +
        't 350 as ImageIndex ,  '#39'Budgets\Module\datBudgetAddin.actBudgetA' +
        'ccountList=350'#39' as ActionDetails union all  Select 169 as ImageI' +
        'ndex ,  '#39'Budgets\Module\datBudgetAddin.actBudgetvsActual=169'#39' as' +
        ' ActionDetails union all  Select 307 as ImageIndex ,  '#39'Budgets\M' +
        'odule\datBudgetAddin.actReportsBudget=307'#39' as ActionDetails unio' +
        'n all  Select 323 as ImageIndex ,  '#39'Budgets\Module\datBudgetAddi' +
        'n.actBudgetDefinitionList=323'#39' as ActionDetails union all  Selec' +
        't 348 as ImageIndex ,  '#39'Budgets\Module\datBudgetAddin.actBudgetL' +
        'ist=348'#39' as ActionDetails union all  Select 267 as ImageIndex , ' +
        ' '#39'Budgets\Module\datBudgetAddin.actBudgetProfitAndLossReport=267' +
        #39' as ActionDetails union all  Select 311 as ImageIndex ,  '#39'Budge' +
        'ts\Module\datBudgetAddin.actJobBudgetVsActual=311'#39' as ActionDeta' +
        'ils union all  Select 0 as ImageIndex ,  '#39'Inventory\InputForms\f' +
        'rmPartsFrm.actEquipment=0'#39' as ActionDetails union all  Select 0 ' +
        'as ImageIndex ,  '#39'Inventory\ListForms\ProductListForm.actSelectA' +
        'll=0'#39' as ActionDetails union all  Select 0 as ImageIndex ,  '#39'Pay' +
        'ments\InputForms\frmCustPayments.actSave=0'#39' as ActionDetails uni' +
        'on all  Select 0 as ImageIndex ,  '#39'Payments\InputForms\frmCustPa' +
        'yments.actapplyDiscount=0'#39' as ActionDetails union all  Select 0 ' +
        'as ImageIndex ,  '#39'Payments\InputForms\frmCustPayments.actNew=0'#39' ' +
        'as ActionDetails union all  Select 0 as ImageIndex ,  '#39'Payments\' +
        'InputForms\frmCustPayments.actPrintReceipt=0'#39' as ActionDetails u' +
        'nion all  Select 0 as ImageIndex ,  '#39'Payments\InputForms\frmCust' +
        'Payments.actEmail=0'#39' as ActionDetails union all  Select 0 as Ima' +
        'geIndex ,  '#39'Payments\InputForms\frmCustPayments.actCancel=0'#39' as ' +
        'ActionDetails union all  Select 0 as ImageIndex ,  '#39'Payments\Inp' +
        'utForms\frmSuppPayments.actSave=0'#39' as ActionDetails union all  S' +
        'elect 0 as ImageIndex ,  '#39'Payments\InputForms\frmSuppPayments.ac' +
        'tNew=0'#39' as ActionDetails union all  Select 0 as ImageIndex ,  '#39'P' +
        'ayments\InputForms\frmSuppPayments.actPrintcheque=0'#39' as ActionDe' +
        'tails union all  Select 0 as ImageIndex ,  '#39'Payments\InputForms\' +
        'frmSuppPayments.actEmail=0'#39' as ActionDetails union all  Select 0' +
        ' as ImageIndex ,  '#39'Payments\InputForms\frmSuppPayments.actCancel' +
        '=0'#39' as ActionDetails union all  Select 0 as ImageIndex ,  '#39'Purch' +
        'ases\ListForms\SmartOrderListForm.actSelectREcord=0'#39' as ActionDe' +
        'tails union all  Select 0 as ImageIndex ,  '#39'Sales\InputForms\frm' +
        'Invoice.actCopyInvoice=0'#39' as ActionDetails union all  Select 0 a' +
        's ImageIndex ,  '#39'Sales\InputForms\frmQuote.actVariation=0'#39' as Ac' +
        'tionDetails union all  Select 0 as ImageIndex ,  '#39'Sales\InputFor' +
        'ms\frmRefund.actSelectSales=0'#39' as ActionDetails union all  Selec' +
        't 0 as ImageIndex ,  '#39'Sales\InputForms\frmSalesOrder.actCopyOrde' +
        'r [17]=0'#39' as ActionDetails union all  Select 0 as ImageIndex ,  ' +
        #39'Sales\InputForms\frmSalesOrder.actTakeFromStock=0'#39' as ActionDet' +
        'ails union all  Select 0 as ImageIndex ,  '#39'Sales\InputForms\frmS' +
        'alesOrder.actPartialInvoice=0'#39' as ActionDetails union all  Selec' +
        't 0 as ImageIndex ,  '#39'Sales\InputForms\frmSalesOrder.actcomplnIn' +
        'voice=0'#39' as ActionDetails union all  Select 0 as ImageIndex ,  '#39 +
        'Sales\ListForms\SalesOrderListForm.actInvoice=0'#39' as ActionDetail' +
        's union all  Select 0 as ImageIndex ,  '#39'Sales\ListForms\SalesOrd' +
        'erReportForm.actInvoice=0'#39' as ActionDetails union all  Select 0 ' +
        'as ImageIndex ,  '#39'Utilities\InputForms\frmMessages.actLead=0'#39' as' +
        ' ActionDetails union all  Select 0 as ImageIndex ,  '#39'Utilities\I' +
        'nputForms\frmMessages.actSupport=0'#39' as ActionDetails union all  ' +
        'Select 0 as ImageIndex ,  '#39'Utilities\InputForms\Preferences.actS' +
        'ave=0'#39' as ActionDetails union all  Select 0 as ImageIndex ,  '#39'Ut' +
        'ilities\InputForms\Preferences.actCancel=0'#39' as ActionDetails uni' +
        'on all  Select 0 as ImageIndex ,  '#39'Manufacturing\InputForms\frmP' +
        'rocCapacityPlanning.actOrderStatus=0'#39' as ActionDetails union all' +
        '  Select 0 as ImageIndex ,  '#39'Manufacturing\InputForms\frmProcCap' +
        'acityPlanning.actRoster=0'#39' as ActionDetails union all  Select 0 ' +
        'as ImageIndex ,  '#39'Manufacturing\InputForms\frmProcCapacityPlanni' +
        'ng.actLogTree=0'#39' as ActionDetails union all  Select 0 as ImageIn' +
        'dex ,  '#39'Manufacturing\InputForms\frmProcCapacityPlanning.actStow' +
        'Away=0'#39' as ActionDetails union all  Select 0 as ImageIndex ,  '#39'M' +
        'anufacturing\InputForms\frmProcCapacityPlanning.actPrintJobDetai' +
        'ls=0'#39' as ActionDetails union all  Select 0 as ImageIndex ,  '#39'Man' +
        'ufacturing\InputForms\frmProcCapacityPlanning.actPQAllocation=0'#39 +
        ' as ActionDetails union all  Select 0 as ImageIndex ,  '#39'Manufact' +
        'uring\InputForms\frmProcCapacityPlanning.actallocPickingSlip=0'#39' ' +
        'as ActionDetails union all  Select 0 as ImageIndex ,  '#39'Manufactu' +
        'ring\InputForms\frmProcCapacityPlanning.actPartialInvoice=0'#39' as ' +
        'ActionDetails union all  Select 330 as ImageIndex ,  '#39'PriceSchem' +
        'e\Module\datPriceSchemeAddin.actPriceSchemeList=330'#39' as ActionDe' +
        'tails union all  Select 326 as ImageIndex ,  '#39'PriceScheme\Module' +
        '\datPriceSchemeAddin.actPriceLists=326'#39' as ActionDetails union a' +
        'll  Select 309 as ImageIndex ,  '#39'PriceScheme\Module\datPriceSche' +
        'meAddin.actPriceSchemeReports=309'#39' as ActionDetails union all  S' +
        'elect 57 as ImageIndex ,  '#39'Marketing\Module\datMarketing.actCont' +
        'actSelectionRange=57'#39' as ActionDetails union all  Select 274 as ' +
        'ImageIndex ,  '#39'Marketing\Module\datMarketing.actContactSelection' +
        'RangeList=274'#39' as ActionDetails union all  Select 331 as ImageIn' +
        'dex ,  '#39'Marketing\Module\datMarketing.actsalesAnalysisGraph=331'#39 +
        ' as ActionDetails union all  Select 268 as ImageIndex ,  '#39'Market' +
        'ing\Module\datMarketing.actMarketing=268'#39' as ActionDetails union' +
        ' all  Select 269 as ImageIndex ,  '#39'Marketing\Module\datMarketing' +
        '.actMarketingList=269'#39' as ActionDetails union all  Select 310 as' +
        ' ImageIndex ,  '#39'Marketing\Module\datMarketing.actMarketingContac' +
        't=310'#39' as ActionDetails union all  Select 318 as ImageIndex ,  '#39 +
        'Marketing\Module\datMarketing.actMarketingContactList=318'#39' as Ac' +
        'tionDetails union all  Select 304 as ImageIndex ,  '#39'Marketing\Mo' +
        'dule\datMarketing.actMarketingContactSummary=304'#39' as ActionDetai' +
        'ls union all  Select 282 as ImageIndex ,  '#39'Marketing\Module\datM' +
        'arketing.actLeadList=282'#39' as ActionDetails union all  Select 341' +
        ' as ImageIndex ,  '#39'Marketing\Module\datMarketing.actLead=341'#39' as' +
        ' ActionDetails union all  Select 305 as ImageIndex ,  '#39'Marketing' +
        '\Module\datMarketing.actMarketingReports=305'#39' as ActionDetails u' +
        'nion all  Select 288 as ImageIndex ,  '#39'Marketing\Module\datMarke' +
        'ting.actReminderPrn=288'#39' as ActionDetails union all  Select 283 ' +
        'as ImageIndex ,  '#39'Marketing\Module\datMarketing.actMarketingCont' +
        'actListDetail=283'#39' as ActionDetails union all  Select 291 as Ima' +
        'geIndex ,  '#39'Marketing\Module\datMarketing.actMarketingContactPro' +
        'duct=291'#39' as ActionDetails union all  Select 297 as ImageIndex ,' +
        '  '#39'Marketing\Module\datMarketing.actMarketingContactcontact=297'#39 +
        ' as ActionDetails union all  Select 298 as ImageIndex ,  '#39'Market' +
        'ing\Module\datMarketing.actProductProcessList=298'#39' as ActionDeta' +
        'ils union all  Select 98 as ImageIndex ,  '#39'Marketing\Module\datM' +
        'arketing.actClientnMarketingList=98'#39' as ActionDetails union all ' +
        ' Select 299 as ImageIndex ,  '#39'Marketing\Module\datMarketing.actL' +
        'eadActionType=299'#39' as ActionDetails union all  Select 111 as Ima' +
        'geIndex ,  '#39'Inventory\InputForms\frmBarcodeAfterPacked.actPrintD' +
        'eldocket=111'#39' as ActionDetails union all  Select 188 as ImageInd' +
        'ex ,  '#39'Inventory\InputForms\frmBarcodeAfterPacked.actPrintCNote=' +
        '188'#39' as ActionDetails union all  Select 211 as ImageIndex ,  '#39'In' +
        'ventory\InputForms\frmBarcodeAfterPacked.actPrintPick=211'#39' as Ac' +
        'tionDetails union all  Select 150 as ImageIndex ,  '#39'Inventory\In' +
        'putForms\frmBarcodeAfterPacked.actPrintsale=150'#39' as ActionDetail' +
        's union all  Select 134 as ImageIndex ,  '#39'Inventory\InputForms\f' +
        'rmBarcodeAfterPacked.actPrintDespatchBarcode=134'#39' as ActionDetai' +
        'ls union all  Select 0 as ImageIndex ,  '#39'Manufacturing\ListForms' +
        '\ProductionJobStatus.actfinalise=0'#39' as ActionDetails union all  ' +
        'Select 0 as ImageIndex ,  '#39'Manufacturing\ListForms\ProductionJob' +
        'Status.actSmartOrder=0'#39' as ActionDetails union all  Select 0 as ' +
        'ImageIndex ,  '#39'Manufacturing\ListForms\ProductionPartsStatus.act' +
        'SelectAll=0'#39' as ActionDetails union all  Select 0 as ImageIndex ' +
        ',  '#39'Inventory\ListForms\ManufactureProductList.actSelectAll=0'#39' a' +
        's ActionDetails union all  Select 0 as ImageIndex ,  '#39'Inventory\' +
        'ListForms\UnitsOfMeasureBaseList.ActLinktoMultipleProducts=0'#39' as' +
        ' ActionDetails union all  Select 0 as ImageIndex ,  '#39'Manufacturi' +
        'ng\ListForms\ProductionJobStatusbase.actfinalise=0'#39' as ActionDet' +
        'ails union all  Select 29 as ImageIndex ,  '#39'Manufacturing\InputF' +
        'orms\frmBarCodeManufacturing.actEmployees=29'#39' as ActionDetails u' +
        'nion all  Select 19 as ImageIndex ,  '#39'Manufacturing\InputForms\f' +
        'rmBarCodeManufacturing.actJobs=19'#39' as ActionDetails union all  S' +
        'elect 394 as ImageIndex ,  '#39'Manufacturing\InputForms\frmBarCodeM' +
        'anufacturing.actStart=394'#39' as ActionDetails union all  Select 17' +
        '0 as ImageIndex ,  '#39'Manufacturing\InputForms\frmBarCodeManufactu' +
        'ring.actSchedule=170'#39' as ActionDetails union all  Select 107 as ' +
        'ImageIndex ,  '#39'Manufacturing\InputForms\frmBarCodeManufacturing.' +
        'actStop=107'#39' as ActionDetails union all  Select 257 as ImageInde' +
        'x ,  '#39'Manufacturing\InputForms\frmBarCodeManufacturing.actStopAl' +
        'l=257'#39' as ActionDetails union all  Select 335 as ImageIndex ,  '#39 +
        'Manufacturing\InputForms\frmBarCodeManufacturing.actComplete=335' +
        #39' as ActionDetails union all  Select 169 as ImageIndex ,  '#39'Manuf' +
        'acturing\InputForms\frmBarCodeManufacturing.actUnschedule=169'#39' a' +
        's ActionDetails union all  Select 292 as ImageIndex ,  '#39'Manufact' +
        'uring\InputForms\frmBarCodeManufacturing.actOpenSale=292'#39' as Act' +
        'ionDetails union all  Select 208 as ImageIndex ,  '#39'Manufacturing' +
        '\InputForms\frmBarCodeManufacturing.actTree=208'#39' as ActionDetail' +
        's union all  Select 241 as ImageIndex ,  '#39'Manufacturing\InputFor' +
        'ms\frmBarCodeManufacturing.actPicking=241'#39' as ActionDetails unio' +
        'n all  Select 200 as ImageIndex ,  '#39'Manufacturing\InputForms\frm' +
        'BarCodeManufacturing.actWorksheet=200'#39' as ActionDetails union al' +
        'l  Select 15 as ImageIndex ,  '#39'Manufacturing\InputForms\frmBarCo' +
        'deManufacturing.actInvoice=15'#39' as ActionDetails union all  Selec' +
        't 205 as ImageIndex ,  '#39'Manufacturing\InputForms\frmBarCodeManuf' +
        'acturing.actPrintcontrolcodes=205'#39' as ActionDetails union all  S' +
        'elect 0 as ImageIndex ,  '#39'Manufacturing\InputForms\frmBarCodeMan' +
        'ufacturing.actSelectall=0'#39' as ActionDetails union all  Select 26' +
        '1 as ImageIndex ,  '#39'Manufacturing\InputForms\frmBarCodeManufactu' +
        'ring.actQA=261'#39' as ActionDetails union all  Select 37 as ImageIn' +
        'dex ,  '#39'Manufacturing\InputForms\frmBarCodeManufacturing.actAllo' +
        'cation=37'#39' as ActionDetails union all  Select 238 as ImageIndex ' +
        ',  '#39'Manufacturing\InputForms\frmBarCodeManufacturing.actLogOff=2' +
        '38'#39' as ActionDetails union all  Select 448 as ImageIndex ,  '#39'Man' +
        'ufacturing\InputForms\frmBarCodeManufacturing.actBreak=448'#39' as A' +
        'ctionDetails union all  Select 27 as ImageIndex ,  '#39'Manufacturin' +
        'g\InputForms\frmBarCodeManufacturing.actHistory=27'#39' as ActionDet' +
        'ails union all  Select 380 as ImageIndex ,  '#39'Manufacturing\Input' +
        'Forms\frmBarCodeManufacturing.actComments=380'#39' as ActionDetails ' +
        'union all  Select 141 as ImageIndex ,  '#39'Training\modules\datTrai' +
        'ning.actTrainingAssignment=141'#39' as ActionDetails union all  Sele' +
        'ct 673 as ImageIndex ,  '#39'Training\modules\datTraining.actTrainin' +
        'gRoster=673'#39' as ActionDetails union all  Select 328 as ImageInde' +
        'x ,  '#39'Training\modules\datTraining.actTrainingProgresschart=328'#39 +
        ' as ActionDetails union all  Select 325 as ImageIndex ,  '#39'Traini' +
        'ng\modules\datTraining.actTrainingStatus=325'#39' as ActionDetails u' +
        'nion all  Select 244 as ImageIndex ,  '#39'Training\modules\datTrain' +
        'ing.actTrainingModule=244'#39' as ActionDetails union all  Select 25' +
        '9 as ImageIndex ,  '#39'Training\modules\datTraining.actSetupTrainin' +
        'g=259'#39' as ActionDetails union all  Select 249 as ImageIndex ,  '#39 +
        'Training\modules\datTraining.actVideos=249'#39' as ActionDetails uni' +
        'on all  Select 289 as ImageIndex ,  '#39'Training\modules\datTrainin' +
        'g.actCustomisetraining=289'#39' as ActionDetails union all  Select 2' +
        '87 as ImageIndex ,  '#39'Training\modules\datTraining.actSetupcompan' +
        'y=287'#39' as ActionDetails union all  Select 230 as ImageIndex ,  '#39 +
        'Training\modules\datTraining.actTrainingList=230'#39' as ActionDetai' +
        'ls union all  Select 0 as ImageIndex ,  '#39'DebugForms\Inputforms\f' +
        'rmdebugExtra.DNMAction1=0'#39' as ActionDetails union all  Select 1 ' +
        'as ImageIndex ,  '#39'DebugForms\Inputforms\frmdebugExtra.DNMAction2' +
        '=1'#39' as ActionDetails union all  Select 0 as ImageIndex ,  '#39'Debug' +
        'Forms\Inputforms\frmdebugExtra.DNMAction3=0'#39' as ActionDetails un' +
        'ion all  Select 1 as ImageIndex ,  '#39'DebugForms\Inputforms\frmdeb' +
        'ugExtra.DNMAction4=1'#39' as ActionDetails union all  Select 0 as Im' +
        'ageIndex ,  '#39'Repairs\InputForms\frmPadRepairs.actInvoice=0'#39' as A' +
        'ctionDetails union all  Select 0 as ImageIndex ,  '#39'Repairs\Input' +
        'Forms\frmPadRepairs.DNMAction1=0'#39' as ActionDetails union all  Se' +
        'lect 197 as ImageIndex ,  '#39'Repairs\Module\datRepairs.actNewRepai' +
        'r=197'#39' as ActionDetails union all  Select 198 as ImageIndex ,  '#39 +
        'Repairs\Module\datRepairs.actRepairsLsit=198'#39' as ActionDetails u' +
        'nion all  Select 43 as ImageIndex ,  '#39'Repairs\Module\datRepairs.' +
        'actRepairsExpressLsit=43'#39' as ActionDetails union all  Select 353' +
        ' as ImageIndex ,  '#39'Repairs\Module\datRepairs.actRepairListInvoci' +
        'e=353'#39' as ActionDetails union all  Select 162 as ImageIndex ,  '#39 +
        'Repairs\Module\datRepairs.actRepairfaults=162'#39' as ActionDetails ' +
        'union all  Select 158 as ImageIndex ,  '#39'Repairs\Module\datRepair' +
        's.actNewRepairfault=158'#39' as ActionDetails union all  Select 118 ' +
        'as ImageIndex ,  '#39'Repairs\Module\datRepairs.actmanufacture=118'#39' ' +
        'as ActionDetails union all  Select 136 as ImageIndex ,  '#39'Repairs' +
        '\Module\datRepairs.actManufactureList=136'#39' as ActionDetails unio' +
        'n all  Select 180 as ImageIndex ,  '#39'Repairs\Module\datRepairs.ac' +
        'tRepairStatusChoice=180'#39' as ActionDetails union all  Select 194 ' +
        'as ImageIndex ,  '#39'Repairs\Module\datRepairs.actEmpCalendar=194'#39' ' +
        'as ActionDetails union all  Select 0 as ImageIndex ,  '#39'Utilities' +
        '\InputForms\frmTasks.actVideo=0'#39' as ActionDetails union all  Sel' +
        'ect 174 as ImageIndex ,  '#39'Manufacturing\Module\datManufacturingA' +
        'ddin.actResource=174'#39' as ActionDetails union all  Select 332 as ' +
        'ImageIndex ,  '#39'Manufacturing\Module\datManufacturingAddin.actRes' +
        'ourceList=332'#39' as ActionDetails union all  Select 338 as ImageIn' +
        'dex ,  '#39'Manufacturing\Module\datManufacturingAddin.actResourceAv' +
        'ailability=338'#39' as ActionDetails union all  Select 117 as ImageI' +
        'ndex ,  '#39'Manufacturing\Module\datManufacturingAddin.actProcessSt' +
        'eps=117'#39' as ActionDetails union all  Select 52 as ImageIndex ,  ' +
        #39'Manufacturing\Module\datManufacturingAddin.actCapacityPlanning=' +
        '52'#39' as ActionDetails union all  Select 139 as ImageIndex ,  '#39'Man' +
        'ufacturing\Module\datManufacturingAddin.actProcessJobListing=139' +
        #39' as ActionDetails union all  Select 165 as ImageIndex ,  '#39'Manuf' +
        'acturing\Module\datManufacturingAddin.actManufacturingReports=16' +
        '5'#39' as ActionDetails union all  Select 159 as ImageIndex ,  '#39'Manu' +
        'facturing\Module\datManufacturingAddin.actProcPreferences=159'#39' a' +
        's ActionDetails union all  Select 96 as ImageIndex ,  '#39'Manufactu' +
        'ring\Module\datManufacturingAddin.actProductionPartsList=96'#39' as ' +
        'ActionDetails union all  Select 132 as ImageIndex ,  '#39'Manufactur' +
        'ing\Module\datManufacturingAddin.actOrdersFromStock=132'#39' as Acti' +
        'onDetails union all  Select 217 as ImageIndex ,  '#39'Manufacturing\' +
        'Module\datManufacturingAddin.actProductionOrders=217'#39' as ActionD' +
        'etails union all  Select 104 as ImageIndex ,  '#39'Manufacturing\Mod' +
        'ule\datManufacturingAddin.actProcJobListing=104'#39' as ActionDetail' +
        's union all  Select 142 as ImageIndex ,  '#39'Manufacturing\Module\d' +
        'atManufacturingAddin.actProcProductionPartsList=142'#39' as ActionDe' +
        'tails union all  Select 175 as ImageIndex ,  '#39'Manufacturing\Modu' +
        'le\datManufacturingAddin.actManufactureProductList=175'#39' as Actio' +
        'nDetails union all  Select 335 as ImageIndex ,  '#39'Manufacturing\M' +
        'odule\datManufacturingAddin.actBarCodeManufacturing=335'#39' as Acti' +
        'onDetails union all  Select 28 as ImageIndex ,  '#39'Manufacturing\M' +
        'odule\datManufacturingAddin.actProductionJobStatusDetails=28'#39' as' +
        ' ActionDetails union all  Select 183 as ImageIndex ,  '#39'Manufactu' +
        'ring\Module\datManufacturingAddin.actManufactureSubProductListGU' +
        'I=183'#39' as ActionDetails union all  Select 242 as ImageIndex ,  '#39 +
        'Manufacturing\Module\datManufacturingAddin.actWastagereport=242'#39 +
        ' as ActionDetails union all  Select 241 as ImageIndex ,  '#39'Manufa' +
        'cturing\Module\datManufacturingAddin.actOrderStatus=241'#39' as Acti' +
        'onDetails union all  Select 235 as ImageIndex ,  '#39'Manufacturing\' +
        'Module\datManufacturingAddin.actprocessstepList=235'#39' as ActionDe' +
        'tails union all  Select 225 as ImageIndex ,  '#39'Manufacturing\Modu' +
        'le\datManufacturingAddin.actBOMSalesList=225'#39' as ActionDetails u' +
        'nion all  Select 220 as ImageIndex ,  '#39'Manufacturing\Module\datM' +
        'anufacturingAddin.actProductionjobstatusdetailsList=220'#39' as Acti' +
        'onDetails union all  Select 240 as ImageIndex ,  '#39'Manufacturing\' +
        'Module\datManufacturingAddin.actCapacityPlanningonGanttchart=240' +
        #39' as ActionDetails union all  Select 343 as ImageIndex ,  '#39'Manuf' +
        'acturing\Module\datManufacturingAddin.actRosterWithManProcess=34' +
        '3'#39' as ActionDetails union all  Select 351 as ImageIndex ,  '#39'Manu' +
        'facturing\Module\datManufacturingAddin.actStowAwayList=351'#39' as A' +
        'ctionDetails union all  Select 16 as ImageIndex ,  '#39'Manufacturin' +
        'g\Module\datManufacturingAddin.actRosterBreakList=16'#39' as ActionD' +
        'etails union all  Select 229 as ImageIndex ,  '#39'Manufacturing\Mod' +
        'ule\datManufacturingAddin.actEmployeeJobStatus=229'#39' as ActionDet' +
        'ails union all  Select 352 as ImageIndex ,  '#39'Manufacturing\Modul' +
        'e\datManufacturingAddin.actUnallocatedBatchSalesList=352'#39' as Act' +
        'ionDetails union all  Select 349 as ImageIndex ,  '#39'Manufacturing' +
        '\Module\datManufacturingAddin.actBOMJobs=349'#39' as ActionDetails u' +
        'nion all  Select 0 as ImageIndex ,  '#39'Manufacturing\ListForms\BOM' +
        'OrderStatus.actSmartOrder=0'#39' as ActionDetails union all  Select ' +
        '0 as ImageIndex ,  '#39'GoogleAnalysis\ListForms\GoogleanalysisCost.' +
        'actMakeBill=0'#39' as ActionDetails union all  Select 0 as ImageInde' +
        'x ,  '#39'Manufacturing\ListForms\BomreportBase.actSmartOrder=0'#39' as ' +
        'ActionDetails union all  Select 0 as ImageIndex ,  '#39'Manufacturin' +
        'g\ListForms\BomreportBase.actUnGroup=0'#39' as ActionDetails union a' +
        'll  Select 0 as ImageIndex ,  '#39'Accounts\ListForms\PnLAreaEmploye' +
        'eReport.actGrpupReport=0'#39' as ActionDetails union all  Select 312' +
        ' as ImageIndex ,  '#39'DebugForms\Inputforms\frmviewimages.acttest=3' +
        '12'#39' as ActionDetails union all  Select 333 as ImageIndex ,  '#39'ERP' +
        '\Modules\datERP.actERPClientList=333'#39' as ActionDetails union all' +
        '  Select 334 as ImageIndex ,  '#39'ERP\Modules\datERP.actClientTreeL' +
        'ist=334'#39' as ActionDetails union all  Select 0 as ImageIndex ,  '#39 +
        'ERP\Modules\datERP.actMasterSMSConfig=0'#39' as ActionDetails union ' +
        'all  Select 0 as ImageIndex ,  '#39'ERP\Modules\datERP.actGetClientM' +
        'essageData=0'#39' as ActionDetails union all  Select 0 as ImageIndex' +
        ' ,  '#39'ERP\Modules\datERP.actClientServerLog=0'#39' as ActionDetails u' +
        'nion all  Select 0 as ImageIndex ,  '#39'ERP\Modules\datERP.actMessa' +
        'geCostList=0'#39' as ActionDetails union all  Select 0 as ImageIndex' +
        ' ,  '#39'ERP\Modules\datERP.actCreateSO=0'#39' as ActionDetails union al' +
        'l  Select 0 as ImageIndex ,  '#39'ERP\Modules\datERP.actERPOffices=0' +
        #39' as ActionDetails union all  Select 0 as ImageIndex ,  '#39'ERP\Mod' +
        'ules\datERP.actTraining_Videos=0'#39' as ActionDetails union all  Se' +
        'lect 0 as ImageIndex ,  '#39'BaseClasses\InputForms\Sales.actCreateJ' +
        'ob=0'#39' as ActionDetails union all  Select 0 as ImageIndex ,  '#39'Bas' +
        'eClasses\InputForms\Sales.actcheckdiscount=0'#39' as ActionDetails u' +
        'nion all  Select 0 as ImageIndex ,  '#39'BaseClasses\InputForms\Sale' +
        's.actManifestList=0'#39' as ActionDetails union all  Select 0 as Ima' +
        'geIndex ,  '#39'ExpenseClaim\InputForms\frmExpenseClaim.actPreview=0' +
        #39' as ActionDetails union all  Select 116 as ImageIndex ,  '#39'workF' +
        'low\Modules\datWorkflow.actStartRecording=116'#39' as ActionDetails ' +
        'union all  Select 97 as ImageIndex ,  '#39'workFlow\Modules\datWorkf' +
        'low.actStoprecording=97'#39' as ActionDetails union all  Select 90 a' +
        's ImageIndex ,  '#39'workFlow\Modules\datWorkflow.actCancelrecording' +
        '=90'#39' as ActionDetails union all  Select 64 as ImageIndex ,  '#39'wor' +
        'kFlow\Modules\datWorkflow.actWorkflows=64'#39' as ActionDetails unio' +
        'n all  Select 45 as ImageIndex ,  '#39'workFlow\Modules\datWorkflow.' +
        'actImportWorkflow=45'#39' as ActionDetails union all  Select 129 as ' +
        'ImageIndex ,  '#39'workFlow\Modules\datWorkflow.actExportAllWorkflow' +
        's=129'#39' as ActionDetails union all  Select 0 as ImageIndex ,  '#39'Pu' +
        'rchases\InputForms\frmSmartOrderFrm.actSelectRecord=0'#39' as Action' +
        'Details union all  Select 0 as ImageIndex ,  '#39'Purchases\InputFor' +
        'ms\frmSmartOrderFrm.actSummary=0'#39' as ActionDetails union all  Se' +
        'lect 361 as ImageIndex ,  '#39'General\Module\dmMainGUI.actStockTran' +
        'sferEntryBin=361'#39' as ActionDetails union all  Select 428 as Imag' +
        'eIndex ,  '#39'General\Module\dmMainGUI.actStockTransferEntryListBin' +
        '=428'#39' as ActionDetails union all  Select 319 as ImageIndex ,  '#39'G' +
        'eneral\Module\dmMainGUI.actStockTransferEntrySN=319'#39' as ActionDe' +
        'tails union all  Select 312 as ImageIndex ,  '#39'General\Module\dmM' +
        'ainGUI.actStockTransferEntryListSN=312'#39' as ActionDetails union a' +
        'll  Select 281 as ImageIndex ,  '#39'General\Module\dmMainGUI.actRep' +
        'ortsPOS=281'#39' as ActionDetails union all  Select 401 as ImageInde' +
        'x ,  '#39'General\Module\dmMainGUI.actStockTransferEntryBatch=401'#39' a' +
        's ActionDetails union all  Select 418 as ImageIndex ,  '#39'General\' +
        'Module\dmMainGUI.actStockTransferEntryListBAtch=418'#39' as ActionDe' +
        'tails union all  Select 594 as ImageIndex ,  '#39'General\Module\dmM' +
        'ainGUI.actInventStockStockAdjustmentbatch=594'#39' as ActionDetails ' +
        'union all  Select 280 as ImageIndex ,  '#39'General\Module\dmMainGUI' +
        '.actInventStockStockAdjustmentList=280'#39' as ActionDetails union a' +
        'll  Select 296 as ImageIndex ,  '#39'General\Module\dmMainGUI.actInv' +
        'entStockStockAdjustment=296'#39' as ActionDetails union all  Select ' +
        '246 as ImageIndex ,  '#39'General\Module\dmMainGUI.actStockAdjustEnt' +
        'ryflat=246'#39' as ActionDetails union all  Select 571 as ImageIndex' +
        ' ,  '#39'General\Module\dmMainGUI.actInventStockStockAdjustmentsnLsi' +
        't=571'#39' as ActionDetails union all  Select 224 as ImageIndex ,  '#39 +
        'General\Module\dmMainGUI.actInventStockStockTake=224'#39' as ActionD' +
        'etails union all  Select 264 as ImageIndex ,  '#39'General\Module\dm' +
        'MainGUI.actStockTakeList=264'#39' as ActionDetails union all  Select' +
        ' 568 as ImageIndex ,  '#39'General\Module\dmMainGUI.actStockTransfer' +
        'EntryTree=568'#39' as ActionDetails union all  Select 633 as ImageIn' +
        'dex ,  '#39'General\Module\dmMainGUI.actInventStockStockAdjustmentbi' +
        'nList=633'#39' as ActionDetails union all  Select 346 as ImageIndex ' +
        ',  '#39'General\Module\dmMainGUI.actCashFlowStatement=346'#39' as Action' +
        'Details union all  Select 281 as ImageIndex ,  '#39'General\Module\d' +
        'mMainGUI.actReportsUtilities=281'#39' as ActionDetails union all  Se' +
        'lect 292 as ImageIndex ,  '#39'General\Module\dmMainGUI.actUtilsEmai' +
        'ledReport=292'#39' as ActionDetails union all  Select 74 as ImageInd' +
        'ex ,  '#39'General\Module\dmMainGUI.SOBOList=74'#39' as ActionDetails un' +
        'ion all  Select 546 as ImageIndex ,  '#39'General\Module\dmMainGUI.a' +
        'ctInventStockStockTransfer=546'#39' as ActionDetails union all  Sele' +
        'ct 84 as ImageIndex ,  '#39'General\Module\dmMainGUI.SOBOListExpress' +
        '=84'#39' as ActionDetails union all  Select 429 as ImageIndex ,  '#39'Ge' +
        'neral\Module\dmMainGUI.actScheduledReports=429'#39' as ActionDetails' +
        ' union all  Select 140 as ImageIndex ,  '#39'General\Module\dmMainGU' +
        'I.actProfitandLossPeriodCompare=140'#39' as ActionDetails union all ' +
        ' Select 73 as ImageIndex ,  '#39'General\Module\dmMainGUI.INVBOList=' +
        '73'#39' as ActionDetails union all  Select 47 as ImageIndex ,  '#39'Gene' +
        'ral\Module\dmMainGUI.INVBOListExpress=47'#39' as ActionDetails union' +
        ' all  Select 125 as ImageIndex ,  '#39'General\Module\dmMainGUI.actF' +
        'ileNewCompany=125'#39' as ActionDetails union all  Select 281 as Ima' +
        'geIndex ,  '#39'General\Module\dmMainGUI.actReportsEmployee=281'#39' as ' +
        'ActionDetails union all  Select 143 as ImageIndex ,  '#39'General\Mo' +
        'dule\dmMainGUI.actFileOpenCompany=143'#39' as ActionDetails union al' +
        'l  Select 234 as ImageIndex ,  '#39'General\Module\dmMainGUI.actFile' +
        'ImportData=234'#39' as ActionDetails union all  Select 357 as ImageI' +
        'ndex ,  '#39'General\Module\dmMainGUI.actInventProductsProductCommis' +
        'sion=357'#39' as ActionDetails union all  Select 83 as ImageIndex , ' +
        ' '#39'General\Module\dmMainGUI.actFileImportTemplates=83'#39' as ActionD' +
        'etails union all  Select 214 as ImageIndex ,  '#39'General\Module\dm' +
        'MainGUI.actFileImportTNTClientRates=214'#39' as ActionDetails union ' +
        'all  Select 27 as ImageIndex ,  '#39'General\Module\dmMainGUI.actFil' +
        'eImportTNTPostcodeToRating=27'#39' as ActionDetails union all  Selec' +
        't 114 as ImageIndex ,  '#39'General\Module\dmMainGUI.actAccountsTerm' +
        's=114'#39' as ActionDetails union all  Select 156 as ImageIndex ,  '#39 +
        'General\Module\dmMainGUI.actFileExportData=156'#39' as ActionDetails' +
        ' union all  Select 153 as ImageIndex ,  '#39'General\Module\dmMainGU' +
        'I.actFileExportTemplates=153'#39' as ActionDetails union all  Select' +
        ' 192 as ImageIndex ,  '#39'General\Module\dmMainGUI.actCustomerProfi' +
        'tability=192'#39' as ActionDetails union all  Select 21 as ImageInde' +
        'x ,  '#39'General\Module\dmMainGUI.actApptMainCalendar=21'#39' as Action' +
        'Details union all  Select 177 as ImageIndex ,  '#39'General\Module\d' +
        'mMainGUI.actApptsPrintAppointments=177'#39' as ActionDetails union a' +
        'll  Select 8 as ImageIndex ,  '#39'General\Module\dmMainGUI.actAppts' +
        'NewAppointment=8'#39' as ActionDetails union all  Select 71 as Image' +
        'Index ,  '#39'General\Module\dmMainGUI.actIncomeandExpenditurereport' +
        '=71'#39' as ActionDetails union all  Select 9 as ImageIndex ,  '#39'Gene' +
        'ral\Module\dmMainGUI.actApptsAppointmentsList=9'#39' as ActionDetail' +
        's union all  Select 26 as ImageIndex ,  '#39'General\Module\dmMainGU' +
        'I.actApptsNewSource=26'#39' as ActionDetails union all  Select 95 as' +
        ' ImageIndex ,  '#39'General\Module\dmMainGUI.actApptsSourceList=95'#39' ' +
        'as ActionDetails union all  Select 196 as ImageIndex ,  '#39'General' +
        '\Module\dmMainGUI.actApptsNewJob=196'#39' as ActionDetails union all' +
        '  Select 200 as ImageIndex ,  '#39'General\Module\dmMainGUI.actAppts' +
        'JobList=200'#39' as ActionDetails union all  Select 59 as ImageIndex' +
        ' ,  '#39'General\Module\dmMainGUI.actApptsPhoneSupport=59'#39' as Action' +
        'Details union all  Select 67 as ImageIndex ,  '#39'General\Module\dm' +
        'MainGUI.actInventProductsProductsList=67'#39' as ActionDetails union' +
        ' all  Select 69 as ImageIndex ,  '#39'General\Module\dmMainGUI.actIn' +
        'ventProductPictureProductsList=69'#39' as ActionDetails union all  S' +
        'elect 281 as ImageIndex ,  '#39'General\Module\dmMainGUI.actReportsG' +
        'eneral=281'#39' as ActionDetails union all  Select 41 as ImageIndex ' +
        ',  '#39'General\Module\dmMainGUI.actApptsFeedbackReport=41'#39' as Actio' +
        'nDetails union all  Select 237 as ImageIndex ,  '#39'General\Module\' +
        'dmMainGUI.actApptsAppointmentsReport=237'#39' as ActionDetails union' +
        ' all  Select 135 as ImageIndex ,  '#39'General\Module\dmMainGUI.actA' +
        'pptsPhoneSupportLogList=135'#39' as ActionDetails union all  Select ' +
        '285 as ImageIndex ,  '#39'General\Module\dmMainGUI.actBarcodeAction=' +
        '285'#39' as ActionDetails union all  Select 191 as ImageIndex ,  '#39'Ge' +
        'neral\Module\dmMainGUI.actApptsCustomersOnSupportList=191'#39' as Ac' +
        'tionDetails union all  Select 189 as ImageIndex ,  '#39'General\Modu' +
        'le\dmMainGUI.actSalesCustomersNewCustomer=189'#39' as ActionDetails ' +
        'union all  Select 29 as ImageIndex ,  '#39'General\Module\dmMainGUI.' +
        'actSalesCustomersCustomerList=29'#39' as ActionDetails union all  Se' +
        'lect 402 as ImageIndex ,  '#39'General\Module\dmMainGUI.actProfitand' +
        'LossByPeriod=402'#39' as ActionDetails union all  Select 303 as Imag' +
        'eIndex ,  '#39'General\Module\dmMainGUI.actSalesCustomersCustomerAcc' +
        'ountNoSetup=303'#39' as ActionDetails union all  Select 22 as ImageI' +
        'ndex ,  '#39'General\Module\dmMainGUI.actSalesCustomersClientType=22' +
        #39' as ActionDetails union all  Select 23 as ImageIndex ,  '#39'Genera' +
        'l\Module\dmMainGUI.actSalesCustomersClientTypeList=23'#39' as Action' +
        'Details union all  Select 376 as ImageIndex ,  '#39'General\Module\d' +
        'mMainGUI.actSalesCustomersCustomerSummary=376'#39' as ActionDetails ' +
        'union all  Select 186 as ImageIndex ,  '#39'General\Module\dmMainGUI' +
        '.actSalesCustomersCustomerDetailsList=186'#39' as ActionDetails unio' +
        'n all  Select 53 as ImageIndex ,  '#39'General\Module\dmMainGUI.actS' +
        'alesCRMOtherContacts=53'#39' as ActionDetails union all  Select 54 a' +
        's ImageIndex ,  '#39'General\Module\dmMainGUI.actSalesCRMOtherContac' +
        'tsList=54'#39' as ActionDetails union all  Select 340 as ImageIndex ' +
        ',  '#39'General\Module\dmMainGUI.actSalesCRMPhoneContact=340'#39' as Act' +
        'ionDetails union all  Select 339 as ImageIndex ,  '#39'General\Modul' +
        'e\dmMainGUI.actSalesCRMPhoneContactList=339'#39' as ActionDetails un' +
        'ion all  Select 372 as ImageIndex ,  '#39'General\Module\dmMainGUI.a' +
        'ctSalesCRMCanvasser=372'#39' as ActionDetails union all  Select 375 ' +
        'as ImageIndex ,  '#39'General\Module\dmMainGUI.actSalesCRMCanvasserL' +
        'ist=375'#39' as ActionDetails union all  Select 164 as ImageIndex , ' +
        ' '#39'General\Module\dmMainGUI.actSalesCRMLoyaltyProgram=164'#39' as Act' +
        'ionDetails union all  Select 51 as ImageIndex ,  '#39'General\Module' +
        '\dmMainGUI.actSalesCRMMailMerge=51'#39' as ActionDetails union all  ' +
        'Select 193 as ImageIndex ,  '#39'General\Module\dmMainGUI.actSalesJo' +
        'bsJobAnalysisBalanceReport=193'#39' as ActionDetails union all  Sele' +
        'ct 501 as ImageIndex ,  '#39'General\Module\dmMainGUI.actSalesJobsJo' +
        'bProfitability=501'#39' as ActionDetails union all  Select 392 as Im' +
        'ageIndex ,  '#39'General\Module\dmMainGUI.actSalesQuotesQuote=392'#39' a' +
        's ActionDetails union all  Select 78 as ImageIndex ,  '#39'General\M' +
        'odule\dmMainGUI.actSalesQuotesQuoteList=78'#39' as ActionDetails uni' +
        'on all  Select 394 as ImageIndex ,  '#39'General\Module\dmMainGUI.ac' +
        'tSalesQuotesQuoteExpressList=394'#39' as ActionDetails union all  Se' +
        'lect 226 as ImageIndex ,  '#39'General\Module\dmMainGUI.actSalesSale' +
        'sOrdersSalesOrder=226'#39' as ActionDetails union all  Select 263 as' +
        ' ImageIndex ,  '#39'General\Module\dmMainGUI.actSalesPOSPOSScreen=26' +
        '3'#39' as ActionDetails union all  Select 406 as ImageIndex ,  '#39'Gene' +
        'ral\Module\dmMainGUI.actSalesSalesOrdersSalesOrderList=406'#39' as A' +
        'ctionDetails union all  Select 85 as ImageIndex ,  '#39'General\Modu' +
        'le\dmMainGUI.actSalesSalesOrdersSalesOrderExpressList=85'#39' as Act' +
        'ionDetails union all  Select 233 as ImageIndex ,  '#39'General\Modul' +
        'e\dmMainGUI.actSalesSalesOrdersSalesOrderReport=233'#39' as ActionDe' +
        'tails union all  Select 130 as ImageIndex ,  '#39'General\Module\dmM' +
        'ainGUI.actSalesSalesCashSale=130'#39' as ActionDetails union all  Se' +
        'lect 77 as ImageIndex ,  '#39'General\Module\dmMainGUI.actSalesSales' +
        'Refunds=77'#39' as ActionDetails union all  Select 150 as ImageIndex' +
        ' ,  '#39'General\Module\dmMainGUI.actSalesSalesInvoice=150'#39' as Actio' +
        'nDetails union all  Select 178 as ImageIndex ,  '#39'General\Module\' +
        'dmMainGUI.actSalesSalesInvoiceList=178'#39' as ActionDetails union a' +
        'll  Select 151 as ImageIndex ,  '#39'General\Module\dmMainGUI.actSal' +
        'esSalesInvoiceExpressList=151'#39' as ActionDetails union all  Selec' +
        't 152 as ImageIndex ,  '#39'General\Module\dmMainGUI.actCustomerRetu' +
        'rnList=152'#39' as ActionDetails union all  Select 398 as ImageIndex' +
        ' ,  '#39'General\Module\dmMainGUI.actCustomerReturns=398'#39' as ActionD' +
        'etails union all  Select 250 as ImageIndex ,  '#39'General\Module\dm' +
        'MainGUI.actSalesSalesBackOrders=250'#39' as ActionDetails union all ' +
        ' Select 113 as ImageIndex ,  '#39'General\Module\dmMainGUI.actSalesS' +
        'alesSalesList=113'#39' as ActionDetails union all  Select 432 as Ima' +
        'geIndex ,  '#39'General\Module\dmMainGUI.actSalesPOSCustomisePOS=432' +
        #39' as ActionDetails union all  Select 106 as ImageIndex ,  '#39'Gener' +
        'al\Module\dmMainGUI.actSalesPOSBarTabList=106'#39' as ActionDetails ' +
        'union all  Select 255 as ImageIndex ,  '#39'General\Module\dmMainGUI' +
        '.actSalesPOSVouchersList=255'#39' as ActionDetails union all  Select' +
        ' 160 as ImageIndex ,  '#39'General\Module\dmMainGUI.actSalesPOSTillS' +
        'ummaryReport=160'#39' as ActionDetails union all  Select 245 as Imag' +
        'eIndex ,  '#39'General\Module\dmMainGUI.actSalesPOSTrafficList=245'#39' ' +
        'as ActionDetails union all  Select 188 as ImageIndex ,  '#39'General' +
        '\Module\dmMainGUI.actSalesPOSTrafficSummaryReport=188'#39' as Action' +
        'Details union all  Select 232 as ImageIndex ,  '#39'General\Module\d' +
        'mMainGUI.actSalesPOSOrderProcessList=232'#39' as ActionDetails union' +
        ' all  Select 427 as ImageIndex ,  '#39'General\Module\dmMainGUI.actS' +
        'alesManifestManifestAllocationList=427'#39' as ActionDetails union a' +
        'll  Select 184 as ImageIndex ,  '#39'General\Module\dmMainGUI.actSal' +
        'esManifestManifest=184'#39' as ActionDetails union all  Select 185 a' +
        's ImageIndex ,  '#39'General\Module\dmMainGUI.actSalesManifestManife' +
        'stList=185'#39' as ActionDetails union all  Select 216 as ImageIndex' +
        ' ,  '#39'General\Module\dmMainGUI.actSalesManifestManifestVehicle=21' +
        '6'#39' as ActionDetails union all  Select 218 as ImageIndex ,  '#39'Gene' +
        'ral\Module\dmMainGUI.actSalesManifestManifestVehicleList=218'#39' as' +
        ' ActionDetails union all  Select 187 as ImageIndex ,  '#39'General\M' +
        'odule\dmMainGUI.actSalesManifestManifestRoute=187'#39' as ActionDeta' +
        'ils union all  Select 219 as ImageIndex ,  '#39'General\Module\dmMai' +
        'nGUI.actSalesManifestManifestRouteList=219'#39' as ActionDetails uni' +
        'on all  Select 190 as ImageIndex ,  '#39'General\Module\dmMainGUI.ac' +
        'tSalesPrintInvoices=190'#39' as ActionDetails union all  Select 503 ' +
        'as ImageIndex ,  '#39'General\Module\dmMainGUI.actSalesPrintSalesOrd' +
        'ers=503'#39' as ActionDetails union all  Select 100 as ImageIndex , ' +
        ' '#39'General\Module\dmMainGUI.actPurchasesSuppliersSupplier=100'#39' as' +
        ' ActionDetails union all  Select 91 as ImageIndex ,  '#39'General\Mo' +
        'dule\dmMainGUI.actPurchasesSuppliersSupplierList=91'#39' as ActionDe' +
        'tails union all  Select 101 as ImageIndex ,  '#39'General\Module\dmM' +
        'ainGUI.actPurchasesSuppliersSupplierExpressList=101'#39' as ActionDe' +
        'tails union all  Select 92 as ImageIndex ,  '#39'General\Module\dmMa' +
        'inGUI.actPurchasesSmartOrdersSmartOrder=92'#39' as ActionDetails uni' +
        'on all  Select 93 as ImageIndex ,  '#39'General\Module\dmMainGUI.act' +
        'PurchasesSmartOrdersSmartOrderList=93'#39' as ActionDetails union al' +
        'l  Select 290 as ImageIndex ,  '#39'General\Module\dmMainGUI.actPurc' +
        'hasesPurchaseOrdersPurchaseOrder=290'#39' as ActionDetails union all' +
        '  Select 481 as ImageIndex ,  '#39'General\Module\dmMainGUI.actPurch' +
        'asesPurchaseOrdersPurchaseOrderList=481'#39' as ActionDetails union ' +
        'all  Select 60 as ImageIndex ,  '#39'General\Module\dmMainGUI.actPur' +
        'chasesPurchaseOrdersPurchaseOrderExpressList=60'#39' as ActionDetail' +
        's union all  Select 279 as ImageIndex ,  '#39'General\Module\dmMainG' +
        'UI.actPurchasesPurchaseOrdersBackOrders=279'#39' as ActionDetails un' +
        'ion all  Select 19 as ImageIndex ,  '#39'General\Module\dmMainGUI.ac' +
        'tPurchasesBillsBill=19'#39' as ActionDetails union all  Select 284 a' +
        's ImageIndex ,  '#39'General\Module\dmMainGUI.actPurchasesBillsBillR' +
        'efund=284'#39' as ActionDetails union all  Select 370 as ImageIndex ' +
        ',  '#39'General\Module\dmMainGUI.actPurchasesBillsBillList=370'#39' as A' +
        'ctionDetails union all  Select 371 as ImageIndex ,  '#39'General\Mod' +
        'ule\dmMainGUI.actPurchasesBillsBillDetailsList=371'#39' as ActionDet' +
        'ails union all  Select 396 as ImageIndex ,  '#39'General\Module\dmMa' +
        'inGUI.actPurchasesReturnAuthorityReturnAuthority=396'#39' as ActionD' +
        'etails union all  Select 397 as ImageIndex ,  '#39'General\Module\dm' +
        'MainGUI.actPurchasesReturnAuthorityReturnAuthorityList=397'#39' as A' +
        'ctionDetails union all  Select 247 as ImageIndex ,  '#39'General\Mod' +
        'ule\dmMainGUI.actbinLocation=247'#39' as ActionDetails union all  Se' +
        'lect 243 as ImageIndex ,  '#39'General\Module\dmMainGUI.actBinLocati' +
        'onList=243'#39' as ActionDetails union all  Select 66 as ImageIndex ' +
        ',  '#39'General\Module\dmMainGUI.actInventProductsProduct=66'#39' as Act' +
        'ionDetails union all  Select 272 as ImageIndex ,  '#39'General\Modul' +
        'e\dmMainGUI.actInventProductsProductsExpressList=272'#39' as ActionD' +
        'etails union all  Select 273 as ImageIndex ,  '#39'General\Module\dm' +
        'MainGUI.actInventProductsProductsExpressBatchbinSNList=273'#39' as A' +
        'ctionDetails union all  Select 252 as ImageIndex ,  '#39'General\Mod' +
        'ule\dmMainGUI.actInventProductsProductCommissionList=252'#39' as Act' +
        'ionDetails union all  Select 559 as ImageIndex ,  '#39'General\Modul' +
        'e\dmMainGUI.actInventProductsProductRewardPoints=559'#39' as ActionD' +
        'etails union all  Select 374 as ImageIndex ,  '#39'General\Module\dm' +
        'MainGUI.actInventProductsProductRewardPointsList=374'#39' as ActionD' +
        'etails union all  Select 253 as ImageIndex ,  '#39'General\Module\dm' +
        'MainGUI.actInventProductsBatchProductCreator=253'#39' as ActionDetai' +
        'ls union all  Select 228 as ImageIndex ,  '#39'General\Module\dmMain' +
        'GUI.actInventProductsBatchProductCodeAbbreviator=228'#39' as ActionD' +
        'etails union all  Select 565 as ImageIndex ,  '#39'General\Module\dm' +
        'MainGUI.actInventStockStockTransferList=565'#39' as ActionDetails un' +
        'ion all  Select 589 as ImageIndex ,  '#39'General\Module\dmMainGUI.a' +
        'ctInventStockStockAdjustmentbin=589'#39' as ActionDetails union all ' +
        ' Select 573 as ImageIndex ,  '#39'General\Module\dmMainGUI.actInvent' +
        'StockStockAdjustmentsn=573'#39' as ActionDetails union all  Select 6' +
        '30 as ImageIndex ,  '#39'General\Module\dmMainGUI.actInventStockStoc' +
        'kAdjustmentbatchList=630'#39' as ActionDetails union all  Select 547' +
        ' as ImageIndex ,  '#39'General\Module\dmMainGUI.actInventPriceUpdate' +
        '=547'#39' as ActionDetails union all  Select 548 as ImageIndex ,  '#39'G' +
        'eneral\Module\dmMainGUI.actoldInventPriceUpdate=548'#39' as ActionDe' +
        'tails union all  Select 356 as ImageIndex ,  '#39'General\Module\dmM' +
        'ainGUI.actInventAutoReOrder=356'#39' as ActionDetails union all  Sel' +
        'ect 221 as ImageIndex ,  '#39'General\Module\dmMainGUI.actInventCust' +
        'omerTypePriceList=221'#39' as ActionDetails union all  Select 65 as ' +
        'ImageIndex ,  '#39'General\Module\dmMainGUI.actInventPrintPickSlips=' +
        '65'#39' as ActionDetails union all  Select 134 as ImageIndex ,  '#39'Gen' +
        'eral\Module\dmMainGUI.actInventBarcodePickingAssembly=134'#39' as Ac' +
        'tionDetails union all  Select 133 as ImageIndex ,  '#39'General\Modu' +
        'le\dmMainGUI.actInventBarcodePickingAssemblyList=133'#39' as ActionD' +
        'etails union all  Select 478 as ImageIndex ,  '#39'General\Module\dm' +
        'MainGUI.actInventPickedSalesList=478'#39' as ActionDetails union all' +
        '  Select 480 as ImageIndex ,  '#39'General\Module\dmMainGUI.actInven' +
        'tPickSlipManifest=480'#39' as ActionDetails union all  Select 270 as' +
        ' ImageIndex ,  '#39'General\Module\dmMainGUI.actInventProductSales=2' +
        '70'#39' as ActionDetails union all  Select 562 as ImageIndex ,  '#39'Gen' +
        'eral\Module\dmMainGUI.actInventProductSalesnotSold=562'#39' as Actio' +
        'nDetails union all  Select 211 as ImageIndex ,  '#39'General\Module\' +
        'dmMainGUI.actInventUnitsOfMeasure=211'#39' as ActionDetails union al' +
        'l  Select 182 as ImageIndex ,  '#39'General\Module\dmMainGUI.actInve' +
        'ntUnitsOfMeasureList=182'#39' as ActionDetails union all  Select 30 ' +
        'as ImageIndex ,  '#39'General\Module\dmMainGUI.actPaymentsCustomerPa' +
        'yment=30'#39' as ActionDetails union all  Select 31 as ImageIndex , ' +
        ' '#39'General\Module\dmMainGUI.actPaymentsCustomerPaymentList=31'#39' as' +
        ' ActionDetails union all  Select 172 as ImageIndex ,  '#39'General\M' +
        'odule\dmMainGUI.actPaymentsCustomerPrepayment=172'#39' as ActionDeta' +
        'ils union all  Select 173 as ImageIndex ,  '#39'General\Module\dmMai' +
        'nGUI.actPaymentsCustomerPrepaymentList=173'#39' as ActionDetails uni' +
        'on all  Select 534 as ImageIndex ,  '#39'General\Module\dmMainGUI.ac' +
        'tPaymentsBulkPaySuppliers=534'#39' as ActionDetails union all  Selec' +
        't 231 as ImageIndex ,  '#39'General\Module\dmMainGUI.actPaymentsRece' +
        'ivedBulkPayments=231'#39' as ActionDetails union all  Select 102 as ' +
        'ImageIndex ,  '#39'General\Module\dmMainGUI.actPaymentsSupplierPayme' +
        'nt=102'#39' as ActionDetails union all  Select 103 as ImageIndex ,  ' +
        #39'General\Module\dmMainGUI.actPaymentsSupplierPaymentList=103'#39' as' +
        ' ActionDetails union all  Select 167 as ImageIndex ,  '#39'General\M' +
        'odule\dmMainGUI.actPaymentsSupplierPrepayment=167'#39' as ActionDeta' +
        'ils union all  Select 181 as ImageIndex ,  '#39'General\Module\dmMai' +
        'nGUI.actPaymentsSuppPrepaymentList=181'#39' as ActionDetails union a' +
        'll  Select 24 as ImageIndex ,  '#39'General\Module\dmMainGUI.actPaym' +
        'entsDepositEntry=24'#39' as ActionDetails union all  Select 76 as Im' +
        'ageIndex ,  '#39'General\Module\dmMainGUI.actPaymentsToBeDeposited=7' +
        '6'#39' as ActionDetails union all  Select 276 as ImageIndex ,  '#39'Gene' +
        'ral\Module\dmMainGUI.actPaymentsDepositedList=276'#39' as ActionDeta' +
        'ils union all  Select 25 as ImageIndex ,  '#39'General\Module\dmMain' +
        'GUI.actPaymentsCheque=25'#39' as ActionDetails union all  Select 170' +
        ' as ImageIndex ,  '#39'General\Module\dmMainGUI.actPaymentsChequeLis' +
        't=170'#39' as ActionDetails union all  Select 488 as ImageIndex ,  '#39 +
        'General\Module\dmMainGUI.actPaymentsChequeDetailsList=488'#39' as Ac' +
        'tionDetails union all  Select 75 as ImageIndex ,  '#39'General\Modul' +
        'e\dmMainGUI.actPaymentsReconcile=75'#39' as ActionDetails union all ' +
        ' Select 494 as ImageIndex ,  '#39'General\Module\dmMainGUI.actPaymen' +
        'tsReconciliationList=494'#39' as ActionDetails union all  Select 261' +
        ' as ImageIndex ,  '#39'General\Module\dmMainGUI.actPaymentsStatement' +
        's=261'#39' as ActionDetails union all  Select 147 as ImageIndex ,  '#39 +
        'General\Module\dmMainGUI.actPaymentsPrintStatements=147'#39' as Acti' +
        'onDetails union all  Select 3 as ImageIndex ,  '#39'General\Module\d' +
        'mMainGUI.actPaymentsAccountsPayableReport=3'#39' as ActionDetails un' +
        'ion all  Select 4 as ImageIndex ,  '#39'General\Module\dmMainGUI.act' +
        'PaymentsAccountsReceivableReport=4'#39' as ActionDetails union all  ' +
        'Select 278 as ImageIndex ,  '#39'General\Module\dmMainGUI.actPayment' +
        'sBankAccountReport=278'#39' as ActionDetails union all  Select 329 a' +
        's ImageIndex ,  '#39'General\Module\dmMainGUI.actPaymentsTransaction' +
        'Journal=329'#39' as ActionDetails union all  Select 58 as ImageIndex' +
        ' ,  '#39'General\Module\dmMainGUI.actEmployeePayrollPayStaff=58'#39' as ' +
        'ActionDetails union all  Select 55 as ImageIndex ,  '#39'General\Mod' +
        'ule\dmMainGUI.actEmployeePayrollPayHistory=55'#39' as ActionDetails ' +
        'union all  Select 56 as ImageIndex ,  '#39'General\Module\dmMainGUI.' +
        'actEmployeePayslist=56'#39' as ActionDetails union all  Select 354 a' +
        's ImageIndex ,  '#39'General\Module\dmMainGUI.actEmployeePayrollNewA' +
        'llowance=354'#39' as ActionDetails union all  Select 6 as ImageIndex' +
        ' ,  '#39'General\Module\dmMainGUI.actEmployeePayrollAllowances=6'#39' as' +
        ' ActionDetails union all  Select 11 as ImageIndex ,  '#39'General\Mo' +
        'dule\dmMainGUI.actEmployeePayrollNewAward=11'#39' as ActionDetails u' +
        'nion all  Select 360 as ImageIndex ,  '#39'General\Module\dmMainGUI.' +
        'actEmployeePayrollAwards=360'#39' as ActionDetails union all  Select' +
        ' 362 as ImageIndex ,  '#39'General\Module\dmMainGUI.actEmployeePayro' +
        'llNewBankCode=362'#39' as ActionDetails union all  Select 13 as Imag' +
        'eIndex ,  '#39'General\Module\dmMainGUI.actEmployeePayrollBankCodes=' +
        '13'#39' as ActionDetails union all  Select 33 as ImageIndex ,  '#39'Gene' +
        'ral\Module\dmMainGUI.actEmployeePayrollNewDeduction=33'#39' as Actio' +
        'nDetails union all  Select 34 as ImageIndex ,  '#39'General\Module\d' +
        'mMainGUI.actEmployeePayrollDeductions=34'#39' as ActionDetails union' +
        ' all  Select 163 as ImageIndex ,  '#39'General\Module\dmMainGUI.actE' +
        'mployeePayrollNewPayRate=163'#39' as ActionDetails union all  Select' +
        ' 535 as ImageIndex ,  '#39'General\Module\dmMainGUI.actEmployeePayro' +
        'llPayRates=535'#39' as ActionDetails union all  Select 46 as ImageIn' +
        'dex ,  '#39'General\Module\dmMainGUI.actEmployeePayrollNewTaxScale=4' +
        '6'#39' as ActionDetails union all  Select 306 as ImageIndex ,  '#39'Gene' +
        'ral\Module\dmMainGUI.actEmployeePayrollTaxScales=306'#39' as ActionD' +
        'etails union all  Select 251 as ImageIndex ,  '#39'General\Module\dm' +
        'MainGUI.actEmployeePayrollImportTaxScales=251'#39' as ActionDetails ' +
        'union all  Select 108 as ImageIndex ,  '#39'General\Module\dmMainGUI' +
        '.actEmployeePayrollLeaveAccruedList=108'#39' as ActionDetails union ' +
        'all  Select 161 as ImageIndex ,  '#39'General\Module\dmMainGUI.actEm' +
        'ployeePayrollLeaveTakenList=161'#39' as ActionDetails union all  Sel' +
        'ect 207 as ImageIndex ,  '#39'General\Module\dmMainGUI.actEmployeePa' +
        'yrollPayrollJobsList=207'#39' as ActionDetails union all  Select 265' +
        ' as ImageIndex ,  '#39'General\Module\dmMainGUI.actEmployeePayrollEm' +
        'ployeeServices=265'#39' as ActionDetails union all  Select 368 as Im' +
        'ageIndex ,  '#39'General\Module\dmMainGUI.actEmployeePayrollPAYGSumm' +
        'ary=368'#39' as ActionDetails union all  Select 404 as ImageIndex , ' +
        ' '#39'General\Module\dmMainGUI.actEmployeeRep=404'#39' as ActionDetails ' +
        'union all  Select 81 as ImageIndex ,  '#39'General\Module\dmMainGUI.' +
        'actEmployeeRepList=81'#39' as ActionDetails union all  Select 111 as' +
        ' ImageIndex ,  '#39'General\Module\dmMainGUI.actEmployeeToDo=111'#39' as' +
        ' ActionDetails union all  Select 38 as ImageIndex ,  '#39'General\Mo' +
        'dule\dmMainGUI.actEmployeeEmployee=38'#39' as ActionDetails union al' +
        'l  Select 405 as ImageIndex ,  '#39'General\Module\dmMainGUI.actEmpl' +
        'oyeeEmployeeAnalysis=405'#39' as ActionDetails union all  Select 39 ' +
        'as ImageIndex ,  '#39'General\Module\dmMainGUI.actEmployeeEmployeeLi' +
        'st=39'#39' as ActionDetails union all  Select 107 as ImageIndex ,  '#39 +
        'General\Module\dmMainGUI.actEmployeeTerminateEmployee=107'#39' as Ac' +
        'tionDetails union all  Select 42 as ImageIndex ,  '#39'General\Modul' +
        'e\dmMainGUI.actEmployeeGlobalList=42'#39' as ActionDetails union all' +
        '  Select 82 as ImageIndex ,  '#39'General\Module\dmMainGUI.actEmploy' +
        'eeRepServices=82'#39' as ActionDetails union all  Select 482 as Imag' +
        'eIndex ,  '#39'General\Module\dmMainGUI.actEmployeeRoster=482'#39' as Ac' +
        'tionDetails union all  Select 239 as ImageIndex ,  '#39'General\Modu' +
        'le\dmMainGUI.actEmployeeRosterList=239'#39' as ActionDetails union a' +
        'll  Select 155 as ImageIndex ,  '#39'General\Module\dmMainGUI.actEmp' +
        'loyeeClockOn=155'#39' as ActionDetails union all  Select 208 as Imag' +
        'eIndex ,  '#39'General\Module\dmMainGUI.actEmployeeResetPersonalTabs' +
        '=208'#39' as ActionDetails union all  Select 124 as ImageIndex ,  '#39'G' +
        'eneral\Module\dmMainGUI.actFixedAssetsFixedAsset=124'#39' as ActionD' +
        'etails union all  Select 48 as ImageIndex ,  '#39'General\Module\dmM' +
        'ainGUI.actFixedAssetsFixedAssetsList=48'#39' as ActionDetails union ' +
        'all  Select 126 as ImageIndex ,  '#39'General\Module\dmMainGUI.actFi' +
        'xedAssetsFixedAssetType=126'#39' as ActionDetails union all  Select ' +
        '127 as ImageIndex ,  '#39'General\Module\dmMainGUI.actFixedAssetsFix' +
        'edAssetTypesList=127'#39' as ActionDetails union all  Select 128 as ' +
        'ImageIndex ,  '#39'General\Module\dmMainGUI.actFixedAssetsCheckWarra' +
        'ntiesInsurancePolicy=128'#39' as ActionDetails union all  Select 123' +
        ' as ImageIndex ,  '#39'General\Module\dmMainGUI.actFixedAssetsServic' +
        'eLog=123'#39' as ActionDetails union all  Select 120 as ImageIndex ,' +
        '  '#39'General\Module\dmMainGUI.actFixedAssetsServiceLogList=120'#39' as' +
        ' ActionDetails union all  Select 1 as ImageIndex ,  '#39'General\Mod' +
        'ule\dmMainGUI.actAccountsAccount=1'#39' as ActionDetails union all  ' +
        'Select 2 as ImageIndex ,  '#39'General\Module\dmMainGUI.actAccountsA' +
        'ccountsList=2'#39' as ActionDetails union all  Select 12 as ImageInd' +
        'ex ,  '#39'General\Module\dmMainGUI.actAccountsAccountTypeList=12'#39' a' +
        's ActionDetails union all  Select 277 as ImageIndex ,  '#39'General\' +
        'Module\dmMainGUI.actAccountsDepartment=277'#39' as ActionDetails uni' +
        'on all  Select 202 as ImageIndex ,  '#39'General\Module\dmMainGUI.ac' +
        'tAccountsDepartmentsList=202'#39' as ActionDetails union all  Select' +
        ' 166 as ImageIndex ,  '#39'General\Module\dmMainGUI.actAccountsTaxCo' +
        'de=166'#39' as ActionDetails union all  Select 572 as ImageIndex ,  ' +
        #39'General\Module\dmMainGUI.actAccountsTaxCodeList=572'#39' as ActionD' +
        'etails union all  Select 105 as ImageIndex ,  '#39'General\Module\dm' +
        'MainGUI.actAccountsTermsList=105'#39' as ActionDetails union all  Se' +
        'lect 157 as ImageIndex ,  '#39'General\Module\dmMainGUI.actAccountsS' +
        'hipping=157'#39' as ActionDetails union all  Select 179 as ImageInde' +
        'x ,  '#39'General\Module\dmMainGUI.actAccountsShippingList=179'#39' as A' +
        'ctionDetails union all  Select 145 as ImageIndex ,  '#39'General\Mod' +
        'ule\dmMainGUI.actAccountsForeignExchangeRate=145'#39' as ActionDetai' +
        'ls union all  Select 36 as ImageIndex ,  '#39'General\Module\dmMainG' +
        'UI.actAccountsForeignExchangeRatesList=36'#39' as ActionDetails unio' +
        'n all  Select 215 as ImageIndex ,  '#39'General\Module\dmMainGUI.act' +
        'AccountsForeignExchangeHistoryList=215'#39' as ActionDetails union a' +
        'll  Select 176 as ImageIndex ,  '#39'General\Module\dmMainGUI.actAcc' +
        'ountsMemorisedTransactionList=176'#39' as ActionDetails union all  S' +
        'elect 49 as ImageIndex ,  '#39'General\Module\dmMainGUI.actAccountsJ' +
        'ournalEntry=49'#39' as ActionDetails union all  Select 89 as ImageIn' +
        'dex ,  '#39'General\Module\dmMainGUI.actAccountsJournalEntryList=89'#39 +
        ' as ActionDetails union all  Select 467 as ImageIndex ,  '#39'Genera' +
        'l\Module\dmMainGUI.actAccountsTrialBalance=467'#39' as ActionDetails' +
        ' union all  Select 363 as ImageIndex ,  '#39'General\Module\dmMainGU' +
        'I.actAccountsBalanceSheet=363'#39' as ActionDetails union all  Selec' +
        't 390 as ImageIndex ,  '#39'General\Module\dmMainGUI.actAccountsProf' +
        'itAndLoss=390'#39' as ActionDetails union all  Select 391 as ImageIn' +
        'dex ,  '#39'General\Module\dmMainGUI.actAccountsjobProfitAndLoss=391' +
        #39' as ActionDetails union all  Select 70 as ImageIndex ,  '#39'Genera' +
        'l\Module\dmMainGUI.actAccountsProfitAndLossByPeriod=70'#39' as Actio' +
        'nDetails union all  Select 63 as ImageIndex ,  '#39'General\Module\d' +
        'mMainGUI.actAccountsElectronicFundsTransfer=63'#39' as ActionDetails' +
        ' union all  Select 248 as ImageIndex ,  '#39'General\Module\dmMainGU' +
        'I.actAccountsRefreshBatchTransaction=248'#39' as ActionDetails union' +
        ' all  Select 281 as ImageIndex ,  '#39'General\Module\dmMainGUI.actR' +
        'eportsAccounts=281'#39' as ActionDetails union all  Select 281 as Im' +
        'ageIndex ,  '#39'General\Module\dmMainGUI.actReportsAppointments=281' +
        #39' as ActionDetails union all  Select 281 as ImageIndex ,  '#39'Gener' +
        'al\Module\dmMainGUI.actReportsBanking=281'#39' as ActionDetails unio' +
        'n all  Select 301 as ImageIndex ,  '#39'General\Module\dmMainGUI.act' +
        'EmployeeEmployeeSummary=301'#39' as ActionDetails union all  Select ' +
        '281 as ImageIndex ,  '#39'General\Module\dmMainGUI.actReportsFixedAs' +
        'sets=281'#39' as ActionDetails union all  Select 281 as ImageIndex ,' +
        '  '#39'General\Module\dmMainGUI.actReportsHospitality=281'#39' as Action' +
        'Details union all  Select 281 as ImageIndex ,  '#39'General\Module\d' +
        'mMainGUI.actReportsInventory=281'#39' as ActionDetails union all  Se' +
        'lect 281 as ImageIndex ,  '#39'General\Module\dmMainGUI.actReportsPa' +
        'yments=281'#39' as ActionDetails union all  Select 281 as ImageIndex' +
        ' ,  '#39'General\Module\dmMainGUI.actReportsPayroll=281'#39' as ActionDe' +
        'tails union all  Select 281 as ImageIndex ,  '#39'General\Module\dmM' +
        'ainGUI.actReportsPurchases=281'#39' as ActionDetails union all  Sele' +
        'ct 281 as ImageIndex ,  '#39'General\Module\dmMainGUI.actReportsSale' +
        's=281'#39' as ActionDetails union all  Select 324 as ImageIndex ,  '#39 +
        'General\Module\dmMainGUI.actReportsTemplates=324'#39' as ActionDetai' +
        'ls union all  Select 32 as ImageIndex ,  '#39'General\Module\dmMainG' +
        'UI.actReportsCustomReports=32'#39' as ActionDetails union all  Selec' +
        't 413 as ImageIndex ,  '#39'General\Module\dmMainGUI.actWindowTiled=' +
        '413'#39' as ActionDetails union all  Select 412 as ImageIndex ,  '#39'Ge' +
        'neral\Module\dmMainGUI.actWindowCascade=412'#39' as ActionDetails un' +
        'ion all  Select 411 as ImageIndex ,  '#39'General\Module\dmMainGUI.a' +
        'ctWindowArrangeIcons=411'#39' as ActionDetails union all  Select 171' +
        ' as ImageIndex ,  '#39'General\Module\dmMainGUI.actWindowCustomiseTo' +
        'olbar=171'#39' as ActionDetails union all  Select 50 as ImageIndex ,' +
        '  '#39'General\Module\dmMainGUI.actUtilsLocations=50'#39' as ActionDetai' +
        'ls union all  Select 14 as ImageIndex ,  '#39'General\Module\dmMainG' +
        'UI.actUtilsDbUtilsBackup=14'#39' as ActionDetails union all  Select ' +
        '61 as ImageIndex ,  '#39'General\Module\dmMainGUI.actUtilsDbUtilsRes' +
        'tore=61'#39' as ActionDetails union all  Select 256 as ImageIndex , ' +
        ' '#39'General\Module\dmMainGUI.actUtilsDbUtilsCopy=256'#39' as ActionDet' +
        'ails union all  Select 555 as ImageIndex ,  '#39'General\Module\dmMa' +
        'inGUI.actUtilsDbUtilsCopyRO=555'#39' as ActionDetails union all  Sel' +
        'ect 257 as ImageIndex ,  '#39'General\Module\dmMainGUI.actUtilsDbUti' +
        'lsRemove=257'#39' as ActionDetails union all  Select 491 as ImageInd' +
        'ex ,  '#39'General\Module\dmMainGUI.actUtilsDbUtilsOptimise=491'#39' as ' +
        'ActionDetails union all  Select 426 as ImageIndex ,  '#39'General\Mo' +
        'dule\dmMainGUI.actUtilsSetupDocsPath=426'#39' as ActionDetails union' +
        ' all  Select 18 as ImageIndex ,  '#39'General\Module\dmMainGUI.actUt' +
        'ilsPublicHolidays=18'#39' as ActionDetails union all  Select 62 as I' +
        'mageIndex ,  '#39'General\Module\dmMainGUI.actUtilsPreferences=62'#39' a' +
        's ActionDetails union all  Select 149 as ImageIndex ,  '#39'General\' +
        'Module\dmMainGUI.actUtilsCompanyInformation=149'#39' as ActionDetail' +
        's union all  Select 433 as ImageIndex ,  '#39'General\Module\dmMainG' +
        'UI.actUtilsCurrentUsers=433'#39' as ActionDetails union all  Select ' +
        '144 as ImageIndex ,  '#39'General\Module\dmMainGUI.actUtilsFaxJobsFa' +
        'xSpoolList=144'#39' as ActionDetails union all  Select 138 as ImageI' +
        'ndex ,  '#39'General\Module\dmMainGUI.actUtilsFaxJobsPurgeOldFaxJobs' +
        '=138'#39' as ActionDetails union all  Select 148 as ImageIndex ,  '#39'G' +
        'eneral\Module\dmMainGUI.actUtilsAuditTrailAuditTrailList=148'#39' as' +
        ' ActionDetails union all  Select 236 as ImageIndex ,  '#39'General\M' +
        'odule\dmMainGUI.actUtilsAuditTrailPurgeAuditTrail=236'#39' as Action' +
        'Details union all  Select 486 as ImageIndex ,  '#39'General\Module\d' +
        'mMainGUI.actUtilsAuditTrailExportAuditTrail=486'#39' as ActionDetail' +
        's union all  Select 336 as ImageIndex ,  '#39'General\Module\dmMainG' +
        'UI.actAboutUpdateNotes=336'#39' as ActionDetails union all  Select 5' +
        '81 as ImageIndex ,  '#39'General\Module\dmMainGUI.actAboutAbout=581'#39 +
        ' as ActionDetails union all  Select 0 as ImageIndex ,  '#39'General\' +
        'Module\dmMainGUI.actFileExit=0'#39' as ActionDetails union all  Sele' +
        'ct 316 as ImageIndex ,  '#39'General\Module\dmMainGUI.actReportsQuot' +
        'eStatus=316'#39' as ActionDetails union all  Select 321 as ImageInde' +
        'x ,  '#39'General\Module\dmMainGUI.actReportsSalesOrderStatus=321'#39' a' +
        's ActionDetails union all  Select 295 as ImageIndex ,  '#39'General\' +
        'Module\dmMainGUI.actReportsUnPaidBills=295'#39' as ActionDetails uni' +
        'on all  Select 327 as ImageIndex ,  '#39'General\Module\dmMainGUI.ac' +
        'tReportsStockStatus=327'#39' as ActionDetails union all  Select 496 ' +
        'as ImageIndex ,  '#39'General\Module\dmMainGUI.actReportsProductSale' +
        'sSummary=496'#39' as ActionDetails union all  Select 550 as ImageInd' +
        'ex ,  '#39'General\Module\dmMainGUI.actReportsTransactionJournal=550' +
        #39' as ActionDetails union all  Select 227 as ImageIndex ,  '#39'Gener' +
        'al\Module\dmMainGUI.actReportsGeneralLedger=227'#39' as ActionDetail' +
        's union all  Select 302 as ImageIndex ,  '#39'General\Module\dmMainG' +
        'UI.actReportsJobProfitability=302'#39' as ActionDetails union all  S' +
        'elect 300 as ImageIndex ,  '#39'General\Module\dmMainGUI.actReportsS' +
        'upplier=300'#39' as ActionDetails union all  Select 68 as ImageIndex' +
        ' ,  '#39'General\Module\dmMainGUI.actReportsBAS=68'#39' as ActionDetails' +
        ' union all  Select 168 as ImageIndex ,  '#39'General\Module\dmMainGU' +
        'I.actReportsBASList=168'#39' as ActionDetails union all  Select 266 ' +
        'as ImageIndex ,  '#39'General\Module\dmMainGUI.actReportsAccountsSum' +
        'mary=266'#39' as ActionDetails union all  Select 260 as ImageIndex ,' +
        '  '#39'General\Module\dmMainGUI.actUtilsExportToReportDB=260'#39' as Act' +
        'ionDetails union all  Select 99 as ImageIndex ,  '#39'General\Module' +
        '\dmMainGUI.actCustomImports=99'#39' as ActionDetails union all  Sele' +
        'ct 10 as ImageIndex ,  '#39'General\Module\dmMainGUI.actEmployeeTran' +
        'sferDetails=10'#39' as ActionDetails union all  Select 558 as ImageI' +
        'ndex ,  '#39'General\Module\dmMainGUI.actPaymentsPrintRecipientCreat' +
        'edStatement=558'#39' as ActionDetails union all  Select 112 as Image' +
        'Index ,  '#39'General\Module\dmMainGUI.actEmployeeToDoList=112'#39' as A' +
        'ctionDetails union all  Select 0 as ImageIndex ,  '#39'General\Modul' +
        'e\dmMainGUI.actEmployeeAccessLevels=0'#39' as ActionDetails union al' +
        'l  Select 146 as ImageIndex ,  '#39'General\Module\dmMainGUI.actEmpl' +
        'oyeePersonalPreferences=146'#39' as ActionDetails union all  Select ' +
        '517 as ImageIndex ,  '#39'General\Module\dmMainGUI.actCompanyTypes=5' +
        '17'#39' as ActionDetails union all  Select 495 as ImageIndex ,  '#39'Gen' +
        'eral\Module\dmMainGUI.actFollowupTypes=495'#39' as ActionDetails uni' +
        'on all  Select 137 as ImageIndex ,  '#39'General\Module\dmMainGUI.ac' +
        'tFollowupResultTypes=137'#39' as ActionDetails union all  Select 115' +
        ' as ImageIndex ,  '#39'General\Module\dmMainGUI.actReminders=115'#39' as' +
        ' ActionDetails union all  Select 40 as ImageIndex ,  '#39'General\Mo' +
        'dule\dmMainGUI.actBinUsageReport=40'#39' as ActionDetails union all ' +
        ' Select 308 as ImageIndex ,  '#39'General\Module\dmMainGUI.actReport' +
        'sSalesSummary=308'#39' as ActionDetails union all  Select 294 as Ima' +
        'geIndex ,  '#39'General\Module\dmMainGUI.actPaymentsChequePrn=294'#39' a' +
        's ActionDetails union all  Select 275 as ImageIndex ,  '#39'General\' +
        'Module\dmMainGUI.actPaymentsEFT=275'#39' as ActionDetails union all ' +
        ' Select 582 as ImageIndex ,  '#39'General\Module\dmMainGUI.actAboutS' +
        'howManual=582'#39' as ActionDetails union all  Select 364 as ImageIn' +
        'dex ,  '#39'General\Module\dmMainGUI.actPaymentsAccountsReceivableNo' +
        'tes=364'#39' as ActionDetails union all  Select 195 as ImageIndex , ' +
        ' '#39'General\Module\dmMainGUI.actApptsCancellationReasons=195'#39' as A' +
        'ctionDetails union all  Select 313 as ImageIndex ,  '#39'General\Mod' +
        'ule\dmMainGUI.POBOList=313'#39' as ActionDetails union all  Select 5' +
        '66 as ImageIndex ,  '#39'General\Module\dmMainGUI.POBOExpressList=56' +
        '6'#39' as ActionDetails union all  Select 500 as ImageIndex ,  '#39'Gene' +
        'ral\Module\dmMainGUI.actSalesPrintPickSlips=500'#39' as ActionDetail' +
        's union all  Select 315 as ImageIndex ,  '#39'General\Module\dmMainG' +
        'UI.actCustomExport=315'#39' as ActionDetails union all  Select 281 a' +
        's ImageIndex ,  '#39'General\Module\dmMainGUI.actReportsCRM=281'#39' as ' +
        'ActionDetails union all  Select 281 as ImageIndex ,  '#39'General\Mo' +
        'dule\dmMainGUI.actReportsJobs=281'#39' as ActionDetails union all  S' +
        'elect 342 as ImageIndex ,  '#39'General\Module\dmMainGUI.actEquipmen' +
        'tList=342'#39' as ActionDetails union all  Select 254 as ImageIndex ' +
        ',  '#39'General\Module\dmMainGUI.actEquipment=254'#39' as ActionDetails ' +
        'union all  Select 258 as ImageIndex ,  '#39'General\Module\dmMainGUI' +
        '.actProductFormulaEntry=258'#39' as ActionDetails union all  Select ' +
        '552 as ImageIndex ,  '#39'General\Module\dmMainGUI.actProductFormula' +
        'Creator=552'#39' as ActionDetails union all  Select 317 as ImageInde' +
        'x ,  '#39'General\Module\dmMainGUI.actProductFormulaList=317'#39' as Act' +
        'ionDetails union all  Select 119 as ImageIndex ,  '#39'General\Modul' +
        'e\dmMainGUI.actEmployeePayrollATO=119'#39' as ActionDetails union al' +
        'l  Select 595 as ImageIndex ,  '#39'General\Module\dmMainGUI.actPurc' +
        'hasesExpenseClaimList=595'#39' as ActionDetails union all  Select 56' +
        '3 as ImageIndex ,  '#39'General\Module\dmMainGUI.actPaymentsApproval' +
        'ReminderList=563'#39' as ActionDetails union all  Select 385 as Imag' +
        'eIndex ,  '#39'General\Module\dmMainGUI.actWorkOrderStatusList=385'#39' ' +
        'as ActionDetails union all  Select 417 as ImageIndex ,  '#39'General' +
        '\Module\dmMainGUI.actDeliveryDocketList=417'#39' as ActionDetails un' +
        'ion all  Select 20 as ImageIndex ,  '#39'General\Module\dmMainGUI.ac' +
        'tEmployeeTerminationList=20'#39' as ActionDetails union all  Select ' +
        '549 as ImageIndex ,  '#39'General\Module\dmMainGUI.actAccountsIntras' +
        'tatDeclaration=549'#39' as ActionDetails union all  Select 551 as Im' +
        'ageIndex ,  '#39'General\Module\dmMainGUI.actAccountsIntrastatList=5' +
        '51'#39' as ActionDetails union all  Select 131 as ImageIndex ,  '#39'Gen' +
        'eral\Module\dmMainGUI.actSource=131'#39' as ActionDetails union all ' +
        ' Select 345 as ImageIndex ,  '#39'General\Module\dmMainGUI.actCashFl' +
        'owForecast=345'#39' as ActionDetails union all  Select 0 as ImageInd' +
        'ex ,  '#39'General\Module\dmMainGUI.actGeneralLedger=0'#39' as ActionDet' +
        'ails union all  Select 400 as ImageIndex ,  '#39'General\Module\dmMa' +
        'inGUI.actUnpaidBillGUI=400'#39' as ActionDetails union all  Select 5' +
        '96 as ImageIndex ,  '#39'General\Module\dmMainGUI.actCustomerBalance' +
        'Detail=596'#39' as ActionDetails union all  Select 597 as ImageIndex' +
        ' ,  '#39'General\Module\dmMainGUI.actCustomerNotesReport=597'#39' as Act' +
        'ionDetails union all  Select 598 as ImageIndex ,  '#39'General\Modul' +
        'e\dmMainGUI.actEmployeeReportByPeriod=598'#39' as ActionDetails unio' +
        'n all  Select 599 as ImageIndex ,  '#39'General\Module\dmMainGUI.act' +
        'ForeignSalesList=599'#39' as ActionDetails union all  Select 600 as ' +
        'ImageIndex ,  '#39'General\Module\dmMainGUI.actActionAuthorisationsL' +
        'ist=600'#39' as ActionDetails union all  Select 601 as ImageIndex , ' +
        ' '#39'General\Module\dmMainGUI.actCombinedAnalysisList=601'#39' as Actio' +
        'nDetails union all  Select 602 as ImageIndex ,  '#39'General\Module\' +
        'dmMainGUI.actCommissionReport=602'#39' as ActionDetails union all  S' +
        'elect 603 as ImageIndex ,  '#39'General\Module\dmMainGUI.actEmployee' +
        'sFixedAssetsList=603'#39' as ActionDetails union all  Select 604 as ' +
        'ImageIndex ,  '#39'General\Module\dmMainGUI.actSalesCommissionList=6' +
        '04'#39' as ActionDetails union all  Select 35 as ImageIndex ,  '#39'Gene' +
        'ral\Module\dmMainGUI.actAssetRegisterList=35'#39' as ActionDetails u' +
        'nion all  Select 605 as ImageIndex ,  '#39'General\Module\dmMainGUI.' +
        'actFixedAssetsDetails=605'#39' as ActionDetails union all  Select 60' +
        '6 as ImageIndex ,  '#39'General\Module\dmMainGUI.actProductSalesSumm' +
        'aryByColumn=606'#39' as ActionDetails union all  Select 607 as Image' +
        'Index ,  '#39'General\Module\dmMainGUI.actStockStatusRoling=607'#39' as ' +
        'ActionDetails union all  Select 608 as ImageIndex ,  '#39'General\Mo' +
        'dule\dmMainGUI.actStockQtysLocationsReport=608'#39' as ActionDetails' +
        ' union all  Select 609 as ImageIndex ,  '#39'General\Module\dmMainGU' +
        'I.actSupplierProductReport=609'#39' as ActionDetails union all  Sele' +
        'ct 610 as ImageIndex ,  '#39'General\Module\dmMainGUI.actUnAllocated' +
        'BinsReport=610'#39' as ActionDetails union all  Select 611 as ImageI' +
        'ndex ,  '#39'General\Module\dmMainGUI.actUnbalancedBinQty=611'#39' as Ac' +
        'tionDetails union all  Select 612 as ImageIndex ,  '#39'General\Modu' +
        'le\dmMainGUI.actCustomerJobFollowupList=612'#39' as ActionDetails un' +
        'ion all  Select 613 as ImageIndex ,  '#39'General\Module\dmMainGUI.a' +
        'ctProfitLossSummary=613'#39' as ActionDetails union all  Select 544 ' +
        'as ImageIndex ,  '#39'General\Module\dmMainGUI.actProdAttribTemplate' +
        'Fields=544'#39' as ActionDetails union all  Select 545 as ImageIndex' +
        ' ,  '#39'General\Module\dmMainGUI.actProdAttribTemplateFieldsdetails' +
        '=545'#39' as ActionDetails union all  Select 542 as ImageIndex ,  '#39'G' +
        'eneral\Module\dmMainGUI.actProductAttributes=542'#39' as ActionDetai' +
        'ls union all  Select 614 as ImageIndex ,  '#39'General\Module\dmMain' +
        'GUI.actAccountsPayableNotes=614'#39' as ActionDetails union all  Sel' +
        'ect 615 as ImageIndex ,  '#39'General\Module\dmMainGUI.actExpenseCla' +
        'imList=615'#39' as ActionDetails union all  Select 616 as ImageIndex' +
        ' ,  '#39'General\Module\dmMainGUI.actForeignPurchaseList=616'#39' as Act' +
        'ionDetails union all  Select 617 as ImageIndex ,  '#39'General\Modul' +
        'e\dmMainGUI.actSupplierStatement=617'#39' as ActionDetails union all' +
        '  Select 618 as ImageIndex ,  '#39'General\Module\dmMainGUI.actUnInv' +
        'oicedPurchasesList=618'#39' as ActionDetails union all  Select 619 a' +
        's ImageIndex ,  '#39'General\Module\dmMainGUI.actUnInvoicedPurchItem' +
        'List=619'#39' as ActionDetails union all  Select 620 as ImageIndex ,' +
        '  '#39'General\Module\dmMainGUI.actQuoteDetailsReport=620'#39' as Action' +
        'Details union all  Select 621 as ImageIndex ,  '#39'General\Module\d' +
        'mMainGUI.actSalesReport=621'#39' as ActionDetails union all  Select ' +
        '622 as ImageIndex ,  '#39'General\Module\dmMainGUI.actSalesRewardPoi' +
        'ntsList=622'#39' as ActionDetails union all  Select 623 as ImageInde' +
        'x ,  '#39'General\Module\dmMainGUI.actSoldProductsReport=623'#39' as Act' +
        'ionDetails union all  Select 358 as ImageIndex ,  '#39'General\Modul' +
        'e\dmMainGUI.actTransactionList=358'#39' as ActionDetails union all  ' +
        'Select 505 as ImageIndex ,  '#39'General\Module\dmMainGUI.actMarketi' +
        'ngRatios=505'#39' as ActionDetails union all  Select 201 as ImageInd' +
        'ex ,  '#39'General\Module\dmMainGUI.actSalesRatios=201'#39' as ActionDet' +
        'ails union all  Select 533 as ImageIndex ,  '#39'General\Module\dmMa' +
        'inGUI.actLeadStatusType1=533'#39' as ActionDetails union all  Select' +
        ' 518 as ImageIndex ,  '#39'General\Module\dmMainGUI.actSalesPipeline' +
        '=518'#39' as ActionDetails union all  Select 377 as ImageIndex ,  '#39'G' +
        'eneral\Module\dmMainGUI.actSerialNumberList=377'#39' as ActionDetail' +
        's union all  Select 94 as ImageIndex ,  '#39'General\Module\dmMainGU' +
        'I.actShippingContainerStatus=94'#39' as ActionDetails union all  Sel' +
        'ect 525 as ImageIndex ,  '#39'General\Module\dmMainGUI.actShippingCo' +
        'ntainer=525'#39' as ActionDetails union all  Select 527 as ImageInde' +
        'x ,  '#39'General\Module\dmMainGUI.actShipContainerList=527'#39' as Acti' +
        'onDetails union all  Select 37 as ImageIndex ,  '#39'General\Module\' +
        'dmMainGUI.actBatches=37'#39' as ActionDetails union all  Select 365 ' +
        'as ImageIndex ,  '#39'General\Module\dmMainGUI.actMailMergeHistory=3' +
        '65'#39' as ActionDetails union all  Select 7 as ImageIndex ,  '#39'Gener' +
        'al\Module\dmMainGUI.actTimesheetEntry=7'#39' as ActionDetails union ' +
        'all  Select 366 as ImageIndex ,  '#39'General\Module\dmMainGUI.actEm' +
        'ployeeTimesheetList=366'#39' as ActionDetails union all  Select 281 ' +
        'as ImageIndex ,  '#39'General\Module\dmMainGUI.actReportsWorkShop=28' +
        '1'#39' as ActionDetails union all  Select 238 as ImageIndex ,  '#39'Gene' +
        'ral\Module\dmMainGUI.actClientEquipmentlist=238'#39' as ActionDetail' +
        's union all  Select 382 as ImageIndex ,  '#39'General\Module\dmMainG' +
        'UI.actVidoes=382'#39' as ActionDetails union all  Select 395 as Imag' +
        'eIndex ,  '#39'General\Module\dmMainGUI.actincomeExpenseConfig=395'#39' ' +
        'as ActionDetails union all  Select 271 as ImageIndex ,  '#39'General' +
        '\Module\dmMainGUI.actmainDashboard=271'#39' as ActionDetails union a' +
        'll  Select 561 as ImageIndex ,  '#39'General\Module\dmMainGUI.actsal' +
        'esDashboard=561'#39' as ActionDetails union all  Select 485 as Image' +
        'Index ,  '#39'General\Module\dmMainGUI.actSerialJobnumber=485'#39' as Ac' +
        'tionDetails union all  Select 519 as ImageIndex ,  '#39'General\Modu' +
        'le\dmMainGUI.actAutoAdjustbin=519'#39' as ActionDetails union all  S' +
        'elect 457 as ImageIndex ,  '#39'General\Module\dmMainGUI.actSalesLis' +
        'twithCommision=457'#39' as ActionDetails union all  Select 461 as Im' +
        'ageIndex ,  '#39'General\Module\dmMainGUI.actCashSaleDepositGUI=461'#39 +
        ' as ActionDetails union all  Select 213 as ImageIndex ,  '#39'Genera' +
        'l\Module\dmMainGUI.actAdjustUOM=213'#39' as ActionDetails union all ' +
        ' Select 121 as ImageIndex ,  '#39'General\Module\dmMainGUI.actReward' +
        'Points=121'#39' as ActionDetails union all  Select 122 as ImageIndex' +
        ' ,  '#39'General\Module\dmMainGUI.actRewardPointsDueToExpireGUI=122'#39 +
        ' as ActionDetails union all  Select 386 as ImageIndex ,  '#39'Genera' +
        'l\Module\dmMainGUI.actAppointmentStatusList=386'#39' as ActionDetail' +
        's union all  Select 590 as ImageIndex ,  '#39'General\Module\dmMainG' +
        'UI.actRepAbilityList=590'#39' as ActionDetails union all  Select 472' +
        ' as ImageIndex ,  '#39'General\Module\dmMainGUI.actRepAbility=472'#39' a' +
        's ActionDetails union all  Select 381 as ImageIndex ,  '#39'General\' +
        'Module\dmMainGUI.actTransactionwith0Qty=381'#39' as ActionDetails un' +
        'ion all  Select 379 as ImageIndex ,  '#39'General\Module\dmMainGUI.a' +
        'ctCustomerExpressList=379'#39' as ActionDetails union all  Select 46' +
        '9 as ImageIndex ,  '#39'General\Module\dmMainGUI.actShippingAgent=46' +
        '9'#39' as ActionDetails union all  Select 222 as ImageIndex ,  '#39'Gene' +
        'ral\Module\dmMainGUI.actShippingAgentlist=222'#39' as ActionDetails ' +
        'union all  Select 373 as ImageIndex ,  '#39'General\Module\dmMainGUI' +
        '.actMessages=373'#39' as ActionDetails union all  Select 0 as ImageI' +
        'ndex ,  '#39'General\Module\dmMainGUI.actCustomise=0'#39' as ActionDetai' +
        'ls union all  Select 624 as ImageIndex ,  '#39'General\Module\dmMain' +
        'GUI.DNMAction2=624'#39' as ActionDetails union all  Select 0 as Imag' +
        'eIndex ,  '#39'General\Module\dmMainGUI.actProductListwithUOM=0'#39' as ' +
        'ActionDetails union all  Select 526 as ImageIndex ,  '#39'General\Mo' +
        'dule\dmMainGUI.actRegionList=526'#39' as ActionDetails union all  Se' +
        'lect 528 as ImageIndex ,  '#39'General\Module\dmMainGUI.actRegion=52' +
        '8'#39' as ActionDetails union all  Select 403 as ImageIndex ,  '#39'Gene' +
        'ral\Module\dmMainGUI.actProductBarcodes=403'#39' as ActionDetails un' +
        'ion all  Select 110 as ImageIndex ,  '#39'General\Module\dmMainGUI.a' +
        'ctClientList=110'#39' as ActionDetails union all  Select 506 as Imag' +
        'eIndex ,  '#39'General\Module\dmMainGUI.actContactList=506'#39' as Actio' +
        'nDetails union all  Select 508 as ImageIndex ,  '#39'General\Module\' +
        'dmMainGUI.actMarketingContactcontactList=508'#39' as ActionDetails u' +
        'nion all  Select 509 as ImageIndex ,  '#39'General\Module\dmMainGUI.' +
        'actProductClassList=509'#39' as ActionDetails union all  Select 463 ' +
        'as ImageIndex ,  '#39'General\Module\dmMainGUI.actOtherfollowups=463' +
        #39' as ActionDetails union all  Select 203 as ImageIndex ,  '#39'Gener' +
        'al\Module\dmMainGUI.actProductgroupdiscount=203'#39' as ActionDetail' +
        's union all  Select 205 as ImageIndex ,  '#39'General\Module\dmMainG' +
        'UI.actProductSpecificationList=205'#39' as ActionDetails union all  ' +
        'Select 206 as ImageIndex ,  '#39'General\Module\dmMainGUI.actProduct' +
        'ExtrabuyPrices=206'#39' as ActionDetails union all  Select 514 as Im' +
        'ageIndex ,  '#39'General\Module\dmMainGUI.actProductExtraSellPrices=' +
        '514'#39' as ActionDetails union all  Select 515 as ImageIndex ,  '#39'Ge' +
        'neral\Module\dmMainGUI.actProductforeignBuyPrice=515'#39' as ActionD' +
        'etails union all  Select 209 as ImageIndex ,  '#39'General\Module\dm' +
        'MainGUI.actproductForeignSellPrice=209'#39' as ActionDetails union a' +
        'll  Select 210 as ImageIndex ,  '#39'General\Module\dmMainGUI.actRel' +
        'atedProducts=210'#39' as ActionDetails union all  Select 516 as Imag' +
        'eIndex ,  '#39'General\Module\dmMainGUI.actrelatedcustomers=516'#39' as ' +
        'ActionDetails union all  Select 520 as ImageIndex ,  '#39'General\Mo' +
        'dule\dmMainGUI.actShippingMethods=520'#39' as ActionDetails union al' +
        'l  Select 521 as ImageIndex ,  '#39'General\Module\dmMainGUI.actSpec' +
        'ialProducts=521'#39' as ActionDetails union all  Select 510 as Image' +
        'Index ,  '#39'General\Module\dmMainGUI.actLanguages=510'#39' as ActionDe' +
        'tails union all  Select 512 as ImageIndex ,  '#39'General\Module\dmM' +
        'ainGUI.actkills=512'#39' as ActionDetails union all  Select 204 as I' +
        'mageIndex ,  '#39'General\Module\dmMainGUI.actSkillList=204'#39' as Acti' +
        'onDetails union all  Select 513 as ImageIndex ,  '#39'General\Module' +
        '\dmMainGUI.actEmployeeSkillList=513'#39' as ActionDetails union all ' +
        ' Select 634 as ImageIndex ,  '#39'General\Module\dmMainGUI.actProduc' +
        'tGroupList=634'#39' as ActionDetails union all  Select 631 as ImageI' +
        'ndex ,  '#39'General\Module\dmMainGUI.actPickingSlipList=631'#39' as Act' +
        'ionDetails union all  Select 393 as ImageIndex ,  '#39'General\Modul' +
        'e\dmMainGUI.actSalesQuotesPadQuote=393'#39' as ActionDetails union a' +
        'll  Select 0 as ImageIndex ,  '#39'General\Module\dmMainGUI.actWebAP' +
        'ITest=0'#39' as ActionDetails union all  Select 458 as ImageIndex , ' +
        ' '#39'General\Module\dmMainGUI.actSubTaxcodes=458'#39' as ActionDetails ' +
        'union all  Select 459 as ImageIndex ,  '#39'General\Module\dmMainGUI' +
        '.actSubTaxcode=459'#39' as ActionDetails union all  Select 484 as Im' +
        'ageIndex ,  '#39'General\Module\dmMainGUI.actNotesAuditTrial=484'#39' as' +
        ' ActionDetails union all  Select 567 as ImageIndex ,  '#39'General\M' +
        'odule\dmMainGUI.actImportDataMapping=567'#39' as ActionDetails union' +
        ' all  Select 408 as ImageIndex ,  '#39'General\Module\dmMainGUI.actI' +
        'mportDataMappingList=408'#39' as ActionDetails union all  Select 470' +
        ' as ImageIndex ,  '#39'General\Module\dmMainGUI.actDeldocketList=470' +
        #39' as ActionDetails union all  Select 223 as ImageIndex ,  '#39'Gener' +
        'al\Module\dmMainGUI.actSalesListOutstanding=223'#39' as ActionDetail' +
        's union all  Select 479 as ImageIndex ,  '#39'General\Module\dmMainG' +
        'UI.actPrintPurchaseOrders=479'#39' as ActionDetails union all  Selec' +
        't 536 as ImageIndex ,  '#39'General\Module\dmMainGUI.actPurchaseOrde' +
        'rAudit=536'#39' as ActionDetails union all  Select 502 as ImageIndex' +
        ' ,  '#39'General\Module\dmMainGUI.actSalesJobQuoteList=502'#39' as Actio' +
        'nDetails union all  Select 464 as ImageIndex ,  '#39'General\Module\' +
        'dmMainGUI.actTask=464'#39' as ActionDetails union all  Select 531 as' +
        ' ImageIndex ,  '#39'General\Module\dmMainGUI.actTaskList=531'#39' as Act' +
        'ionDetails union all  Select 465 as ImageIndex ,  '#39'General\Modul' +
        'e\dmMainGUI.actClientPhoneList=465'#39' as ActionDetails union all  ' +
        'Select 532 as ImageIndex ,  '#39'General\Module\dmMainGUI.actPhoneSu' +
        'pportLogListExpress=532'#39' as ActionDetails union all  Select 380 ' +
        'as ImageIndex ,  '#39'General\Module\dmMainGUI.actCustlistWithDetail' +
        's=380'#39' as ActionDetails union all  Select 522 as ImageIndex ,  '#39 +
        'General\Module\dmMainGUI.actPhoneSupportTypeList=522'#39' as ActionD' +
        'etails union all  Select 523 as ImageIndex ,  '#39'General\Module\dm' +
        'MainGUI.actPhoneSupportVersionList=523'#39' as ActionDetails union a' +
        'll  Select 199 as ImageIndex ,  '#39'General\Module\dmMainGUI.actUnA' +
        'llocatedQty=199'#39' as ActionDetails union all  Select 483 as Image' +
        'Index ,  '#39'General\Module\dmMainGUI.actProductPurchaseMovementLis' +
        't=483'#39' as ActionDetails union all  Select 367 as ImageIndex ,  '#39 +
        'General\Module\dmMainGUI.actNumberSequenceList=367'#39' as ActionDet' +
        'ails union all  Select 492 as ImageIndex ,  '#39'General\Module\dmMa' +
        'inGUI.actLinkTo=492'#39' as ActionDetails union all  Select 477 as I' +
        'mageIndex ,  '#39'General\Module\dmMainGUI.actGoogleAnalysisReport_L' +
        'anguage=477'#39' as ActionDetails union all  Select 490 as ImageInde' +
        'x ,  '#39'General\Module\dmMainGUI.actGoogleAnalysisReport_Location=' +
        '490'#39' as ActionDetails union all  Select 462 as ImageIndex ,  '#39'Ge' +
        'neral\Module\dmMainGUI.actGoogleAnalysisReport_Keyword=462'#39' as A' +
        'ctionDetails union all  Select 504 as ImageIndex ,  '#39'General\Mod' +
        'ule\dmMainGUI.actGoogleAnalysisReport_Campaign=504'#39' as ActionDet' +
        'ails union all  Select 460 as ImageIndex ,  '#39'General\Module\dmMa' +
        'inGUI.actGoogleAnalysisReport_Browser=460'#39' as ActionDetails unio' +
        'n all  Select 449 as ImageIndex ,  '#39'General\Module\dmMainGUI.act' +
        'GoogleAnalysisReport_DayofWeek=449'#39' as ActionDetails union all  ' +
        'Select 650 as ImageIndex ,  '#39'General\Module\dmMainGUI.actGoogleA' +
        'nalyticReport_Language=650'#39' as ActionDetails union all  Select 6' +
        '51 as ImageIndex ,  '#39'General\Module\dmMainGUI.actGoogleAnalyticR' +
        'eport_Location=651'#39' as ActionDetails union all  Select 649 as Im' +
        'ageIndex ,  '#39'General\Module\dmMainGUI.actGoogleAnalyticReport_Ke' +
        'yword=649'#39' as ActionDetails union all  Select 652 as ImageIndex ' +
        ',  '#39'General\Module\dmMainGUI.actGoogleAnalyticReport_Campaign=65' +
        '2'#39' as ActionDetails union all  Select 648 as ImageIndex ,  '#39'Gene' +
        'ral\Module\dmMainGUI.actGoogleAnalyticReport_Browser=648'#39' as Act' +
        'ionDetails union all  Select 645 as ImageIndex ,  '#39'General\Modul' +
        'e\dmMainGUI.actGoogleAnalyticReport_DayofWeek=645'#39' as ActionDeta' +
        'ils union all  Select 281 as ImageIndex ,  '#39'General\Module\dmMai' +
        'nGUI.actreportsGoogle=281'#39' as ActionDetails union all  Select 44' +
        '3 as ImageIndex ,  '#39'General\Module\dmMainGUI.actAnalyicreports=4' +
        '43'#39' as ActionDetails union all  Select 489 as ImageIndex ,  '#39'Gen' +
        'eral\Module\dmMainGUI.actAnalyticsSummaryList=489'#39' as ActionDeta' +
        'ils union all  Select 675 as ImageIndex ,  '#39'General\Module\dmMai' +
        'nGUI.actAnalyticsDetailList=675'#39' as ActionDetails union all  Sel' +
        'ect 499 as ImageIndex ,  '#39'General\Module\dmMainGUI.actGoogleAnal' +
        'ysisReport_Summary=499'#39' as ActionDetails union all  Select 674 a' +
        's ImageIndex ,  '#39'General\Module\dmMainGUI.actGoogleAnalytic_Summ' +
        'ary=674'#39' as ActionDetails union all  Select 466 as ImageIndex , ' +
        ' '#39'General\Module\dmMainGUI.actFaq=466'#39' as ActionDetails union al' +
        'l  Select 453 as ImageIndex ,  '#39'General\Module\dmMainGUI.actGoog' +
        'leanalysisCost=453'#39' as ActionDetails union all  Select 421 as Im' +
        'ageIndex ,  '#39'General\Module\dmMainGUI.actProductSalesReport=421'#39 +
        ' as ActionDetails union all  Select 543 as ImageIndex ,  '#39'Genera' +
        'l\Module\dmMainGUI.actVoucher=543'#39' as ActionDetails union all  S' +
        'elect 639 as ImageIndex ,  '#39'General\Module\dmMainGUI.actsalesAna' +
        'lysisGraph=639'#39' as ActionDetails union all  Select 399 as ImageI' +
        'ndex ,  '#39'General\Module\dmMainGUI.actEmailList=399'#39' as ActionDet' +
        'ails union all  Select 541 as ImageIndex ,  '#39'General\Module\dmMa' +
        'inGUI.actEmailPurge=541'#39' as ActionDetails union all  Select 585 ' +
        'as ImageIndex ,  '#39'General\Module\dmMainGUI.actSalesAnalysisManua' +
        'l=585'#39' as ActionDetails union all  Select 588 as ImageIndex ,  '#39 +
        'General\Module\dmMainGUI.actSalesAnalysisManualList=588'#39' as Acti' +
        'onDetails union all  Select 154 as ImageIndex ,  '#39'General\Module' +
        '\dmMainGUI.actvoucherInvoice=154'#39' as ActionDetails union all  Se' +
        'lect 497 as ImageIndex ,  '#39'General\Module\dmMainGUI.actProfitnLo' +
        'sschart=497'#39' as ActionDetails union all  Select 86 as ImageIndex' +
        ' ,  '#39'General\Module\dmMainGUI.actProfitnLosschartCompareGross=86' +
        #39' as ActionDetails union all  Select 407 as ImageIndex ,  '#39'Gener' +
        'al\Module\dmMainGUI.actProfitnLosschartCompareGrossMonth=407'#39' as' +
        ' ActionDetails union all  Select 409 as ImageIndex ,  '#39'General\M' +
        'odule\dmMainGUI.actProfitnLosschartCompareGrossQuarter=409'#39' as A' +
        'ctionDetails union all  Select 410 as ImageIndex ,  '#39'General\Mod' +
        'ule\dmMainGUI.actProfitnLosschartCompareGrossYear=410'#39' as Action' +
        'Details union all  Select 430 as ImageIndex ,  '#39'General\Module\d' +
        'mMainGUI.actProfitnLosschartCompareRevenue=430'#39' as ActionDetails' +
        ' union all  Select 431 as ImageIndex ,  '#39'General\Module\dmMainGU' +
        'I.actProfitnLosschartCompareRevenueMonth=431'#39' as ActionDetails u' +
        'nion all  Select 455 as ImageIndex ,  '#39'General\Module\dmMainGUI.' +
        'actProfitnLosschartCompareRevenuequarter=455'#39' as ActionDetails u' +
        'nion all  Select 456 as ImageIndex ,  '#39'General\Module\dmMainGUI.' +
        'actProfitnLosschartCompareRevenueYear=456'#39' as ActionDetails unio' +
        'n all  Select 414 as ImageIndex ,  '#39'General\Module\dmMainGUI.act' +
        'ProfitnLosschartCompareNI=414'#39' as ActionDetails union all  Selec' +
        't 415 as ImageIndex ,  '#39'General\Module\dmMainGUI.actProfitnLossc' +
        'hartCompareNIMonth=415'#39' as ActionDetails union all  Select 424 a' +
        's ImageIndex ,  '#39'General\Module\dmMainGUI.actProfitnLosschartCom' +
        'pareNIQuarter=424'#39' as ActionDetails union all  Select 425 as Ima' +
        'geIndex ,  '#39'General\Module\dmMainGUI.actProfitnLosschartCompareN' +
        'IYear=425'#39' as ActionDetails union all  Select 383 as ImageIndex ' +
        ',  '#39'General\Module\dmMainGUI.actProfitnLosschartgrossProfit=383'#39 +
        ' as ActionDetails union all  Select 560 as ImageIndex ,  '#39'Genera' +
        'l\Module\dmMainGUI.actSmartorderListDetails=560'#39' as ActionDetail' +
        's union all  Select 576 as ImageIndex ,  '#39'General\Module\dmMainG' +
        'UI.actTaxSummaryDetailReport=576'#39' as ActionDetails union all  Se' +
        'lect 537 as ImageIndex ,  '#39'General\Module\dmMainGUI.actrosterRep' +
        'ort=537'#39' as ActionDetails union all  Select 538 as ImageIndex , ' +
        ' '#39'General\Module\dmMainGUI.actRosterReportDetails=538'#39' as Action' +
        'Details union all  Select 586 as ImageIndex ,  '#39'General\Module\d' +
        'mMainGUI.actSiteIntegrationReport=586'#39' as ActionDetails union al' +
        'l  Select 422 as ImageIndex ,  '#39'General\Module\dmMainGUI.actAppr' +
        'ovalLevelList=422'#39' as ActionDetails union all  Select 344 as Ima' +
        'geIndex ,  '#39'General\Module\dmMainGUI.actApprovalList=344'#39' as Act' +
        'ionDetails union all  Select 637 as ImageIndex ,  '#39'General\Modul' +
        'e\dmMainGUI.actHourlySalesReport=637'#39' as ActionDetails union all' +
        '  Select 0 as ImageIndex ,  '#39'General\Module\dmMainGUI.actEmailRe' +
        'ferenceList=0'#39' as ActionDetails union all  Select 0 as ImageInde' +
        'x ,  '#39'General\Module\dmMainGUI.actLetterReferenceList=0'#39' as Acti' +
        'onDetails union all  Select 423 as ImageIndex ,  '#39'General\Module' +
        '\dmMainGUI.actAccountrunningBalance=423'#39' as ActionDetails union ' +
        'all  Select 384 as ImageIndex ,  '#39'General\Module\dmMainGUI.actCa' +
        'shProfitandLoss=384'#39' as ActionDetails union all  Select 638 as I' +
        'mageIndex ,  '#39'General\Module\dmMainGUI.actPnLEmployeereport=638'#39 +
        ' as ActionDetails union all  Select 539 as ImageIndex ,  '#39'Genera' +
        'l\Module\dmMainGUI.actAreaCode=539'#39' as ActionDetails union all  ' +
        'Select 556 as ImageIndex ,  '#39'General\Module\dmMainGUI.actAreacod' +
        'es=556'#39' as ActionDetails union all  Select 577 as ImageIndex ,  ' +
        #39'General\Module\dmMainGUI.actProductstoExcludeDefaultTaxCode=577' +
        #39' as ActionDetails union all  Select 569 as ImageIndex ,  '#39'Gener' +
        'al\Module\dmMainGUI.actEBayOrders=569'#39' as ActionDetails union al' +
        'l  Select 570 as ImageIndex ,  '#39'General\Module\dmMainGUI.actEBay' +
        'SalesOrders=570'#39' as ActionDetails union all  Select 387 as Image' +
        'Index ,  '#39'General\Module\dmMainGUI.actAuseParcelconf=387'#39' as Act' +
        'ionDetails union all  Select 435 as ImageIndex ,  '#39'General\Modul' +
        'e\dmMainGUI.actSalesTaxReport=435'#39' as ActionDetails union all  S' +
        'elect 592 as ImageIndex ,  '#39'General\Module\dmMainGUI.actCleanDat' +
        'abase=592'#39' as ActionDetails union all  Select 640 as ImageIndex ' +
        ',  '#39'General\Module\dmMainGUI.actWeeklysalesreport=640'#39' as Action' +
        'Details union all  Select 473 as ImageIndex ,  '#39'General\Module\d' +
        'mMainGUI.actFxTrading=473'#39' as ActionDetails union all  Select 47' +
        '5 as ImageIndex ,  '#39'General\Module\dmMainGUI.actFxTradingList=47' +
        '5'#39' as ActionDetails union all  Select 593 as ImageIndex ,  '#39'Gene' +
        'ral\Module\dmMainGUI.actummarySheets=593'#39' as ActionDetails union' +
        ' all  Select 591 as ImageIndex ,  '#39'General\Module\dmMainGUI.actS' +
        'ummarySheets=591'#39' as ActionDetails union all  Select 476 as Imag' +
        'eIndex ,  '#39'General\Module\dmMainGUI.actcolorPrefs=476'#39' as Action' +
        'Details union all  Select 262 as ImageIndex ,  '#39'General\Module\d' +
        'mMainGUI.actSMSList=262'#39' as ActionDetails union all  Select 635 ' +
        'as ImageIndex ,  '#39'General\Module\dmMainGUI.actEmailedReports=635' +
        #39' as ActionDetails union all  Select 320 as ImageIndex ,  '#39'Gener' +
        'al\Module\dmMainGUI.actProductReportByPeriod=320'#39' as ActionDetai' +
        'ls union all  Select 471 as ImageIndex ,  '#39'General\Module\dmMain' +
        'GUI.actCAR=471'#39' as ActionDetails union all  Select 468 as ImageI' +
        'ndex ,  '#39'General\Module\dmMainGUI.actCarList=468'#39' as ActionDetai' +
        'ls union all  Select 389 as ImageIndex ,  '#39'General\Module\dmMain' +
        'GUI.actPayHoursList=389'#39' as ActionDetails union all  Select 625 ' +
        'as ImageIndex ,  '#39'General\Module\dmMainGUI.actStockValue=625'#39' as' +
        ' ActionDetails union all  Select 378 as ImageIndex ,  '#39'General\M' +
        'odule\dmMainGUI.actProductBuyPriceList=378'#39' as ActionDetails uni' +
        'on all  Select 580 as ImageIndex ,  '#39'General\Module\dmMainGUI.DN' +
        'MAction1=580'#39' as ActionDetails union all  Select 436 as ImageInd' +
        'ex ,  '#39'General\Module\dmMainGUI.actRefundSalesList=436'#39' as Actio' +
        'nDetails union all  Select 511 as ImageIndex ,  '#39'General\Module\' +
        'dmMainGUI.actSupplierSkillList=511'#39' as ActionDetails union all  ' +
        'Select 369 as ImageIndex ,  '#39'General\Module\dmMainGUI.actEmploye' +
        'eTaxList=369'#39' as ActionDetails union all  Select 359 as ImageInd' +
        'ex ,  '#39'General\Module\dmMainGUI.actPaymentMethodList=359'#39' as Act' +
        'ionDetails union all  Select 564 as ImageIndex ,  '#39'General\Modul' +
        'e\dmMainGUI.actPaymentMethod=564'#39' as ActionDetails union all  Se' +
        'lect 636 as ImageIndex ,  '#39'General\Module\dmMainGUI.actClientMai' +
        'nContacts=636'#39' as ActionDetails union all  Select 286 as ImageIn' +
        'dex ,  '#39'General\Module\dmMainGUI.actShippingList=286'#39' as ActionD' +
        'etails union all  Select 677 as ImageIndex ,  '#39'General\Module\dm' +
        'MainGUI.actSalesAddressLabelPrn=677'#39' as ActionDetails union all ' +
        ' Select 678 as ImageIndex ,  '#39'General\Module\dmMainGUI.actsingle' +
        'SalesAddressLabelPrn=678'#39' as ActionDetails union all  Select 579' +
        ' as ImageIndex ,  '#39'General\Module\dmMainGUI.actPOsInvoicedBefore' +
        'Order=579'#39' as ActionDetails union all  Select 557 as ImageIndex ' +
        ',  '#39'General\Module\dmMainGUI.actExpenseClaimRequest=557'#39' as Acti' +
        'onDetails union all  Select 641 as ImageIndex ,  '#39'General\Module' +
        '\dmMainGUI.actSmartOrderRFQs=641'#39' as ActionDetails union all  Se' +
        'lect 419 as ImageIndex ,  '#39'General\Module\dmMainGUI.actImportSto' +
        'ckAdjustment=419'#39' as ActionDetails union all  Select 420 as Imag' +
        'eIndex ,  '#39'General\Module\dmMainGUI.actExportStockAdjustment=420' +
        #39' as ActionDetails union all  Select 416 as ImageIndex ,  '#39'Gener' +
        'al\Module\dmMainGUI.actInventoryAssetVsStockStauts=416'#39' as Actio' +
        'nDetails union all  Select 629 as ImageIndex ,  '#39'General\Module\' +
        'dmMainGUI.actInventoryAsset=629'#39' as ActionDetails union all  Sel' +
        'ect 293 as ImageIndex ,  '#39'General\Module\dmMainGUI.actAreaPOLine' +
        'sDetailsList=293'#39' as ActionDetails union all  Select 578 as Imag' +
        'eIndex ,  '#39'General\Module\dmMainGUI.actUOMList=578'#39' as ActionDet' +
        'ails union all  Select 437 as ImageIndex ,  '#39'General\Module\dmMa' +
        'inGUI.actInt_ATO=437'#39' as ActionDetails union all  Select 438 as ' +
        'ImageIndex ,  '#39'General\Module\dmMainGUI.actInt_AustPostParcel=43' +
        '8'#39' as ActionDetails union all  Select 647 as ImageIndex ,  '#39'Gene' +
        'ral\Module\dmMainGUI.actInt_CanadaPost=647'#39' as ActionDetails uni' +
        'on all  Select 447 as ImageIndex ,  '#39'General\Module\dmMainGUI.ac' +
        'tInt_CustomerPortal=447'#39' as ActionDetails union all  Select 643 ' +
        'as ImageIndex ,  '#39'General\Module\dmMainGUI.actInt_Cytrack=643'#39' a' +
        's ActionDetails union all  Select 434 as ImageIndex ,  '#39'General\' +
        'Module\dmMainGUI.actInt_Ebay=434'#39' as ActionDetails union all  Se' +
        'lect 440 as ImageIndex ,  '#39'General\Module\dmMainGUI.actInt_Eftpo' +
        's=440'#39' as ActionDetails union all  Select 454 as ImageIndex ,  '#39 +
        'General\Module\dmMainGUI.actInt_FedEx=454'#39' as ActionDetails unio' +
        'n all  Select 442 as ImageIndex ,  '#39'General\Module\dmMainGUI.avt' +
        'Int_Fuel=442'#39' as ActionDetails union all  Select 444 as ImageInd' +
        'ex ,  '#39'General\Module\dmMainGUI.actInt_GoogleCalendar=444'#39' as Ac' +
        'tionDetails union all  Select 448 as ImageIndex ,  '#39'General\Modu' +
        'le\dmMainGUI.actInt_GoogleAnalytics=448'#39' as ActionDetails union ' +
        'all  Select 439 as ImageIndex ,  '#39'General\Module\dmMainGUI.actIn' +
        't_PNET=439'#39' as ActionDetails union all  Select 441 as ImageIndex' +
        ' ,  '#39'General\Module\dmMainGUI.actInt_OPOS=441'#39' as ActionDetails ' +
        'union all  Select 446 as ImageIndex ,  '#39'General\Module\dmMainGUI' +
        '.actInt_ShoppingCart=446'#39' as ActionDetails union all  Select 451' +
        ' as ImageIndex ,  '#39'General\Module\dmMainGUI.actInt_SMS=451'#39' as A' +
        'ctionDetails union all  Select 646 as ImageIndex ,  '#39'General\Mod' +
        'ule\dmMainGUI.actInt_Telstra=646'#39' as ActionDetails union all  Se' +
        'lect 642 as ImageIndex ,  '#39'General\Module\dmMainGUI.actInt_TNT=6' +
        '42'#39' as ActionDetails union all  Select 450 as ImageIndex ,  '#39'Gen' +
        'eral\Module\dmMainGUI.actInt_UPS=450'#39' as ActionDetails union all' +
        '  Select 452 as ImageIndex ,  '#39'General\Module\dmMainGUI.actInt_U' +
        'SPS=452'#39' as ActionDetails union all  Select 445 as ImageIndex , ' +
        ' '#39'General\Module\dmMainGUI.actInt_Web=445'#39' as ActionDetails unio' +
        'n all  Select 644 as ImageIndex ,  '#39'General\Module\dmMainGUI.act' +
        'Int_XML=644'#39' as ActionDetails union all  Select 755 as ImageInde' +
        'x ,  '#39'General\Module\dmMainGUI.actInt_WalMart=755'#39' as ActionDeta' +
        'ils union all  Select 756 as ImageIndex ,  '#39'General\Module\dmMai' +
        'nGUI.actInt_Target=756'#39' as ActionDetails union all  Select 757 a' +
        's ImageIndex ,  '#39'General\Module\dmMainGUI.actInt_Sony=757'#39' as Ac' +
        'tionDetails union all  Select 758 as ImageIndex ,  '#39'General\Modu' +
        'le\dmMainGUI.actInt_Seagate=758'#39' as ActionDetails union all  Sel' +
        'ect 759 as ImageIndex ,  '#39'General\Module\dmMainGUI.actInt_Erico=' +
        '759'#39' as ActionDetails union all  Select 529 as ImageIndex ,  '#39'Ge' +
        'neral\Module\dmMainGUI.actCustomAccountsReport=529'#39' as ActionDet' +
        'ails union all  Select 530 as ImageIndex ,  '#39'General\Module\dmMa' +
        'inGUI.actCustomAccountsReportTree=530'#39' as ActionDetails union al' +
        'l  Select 540 as ImageIndex ,  '#39'General\Module\dmMainGUI.actCloc' +
        'kedOnList=540'#39' as ActionDetails union all  Select 553 as ImageIn' +
        'dex ,  '#39'General\Module\dmMainGUI.actRosterBreakList=553'#39' as Acti' +
        'onDetails union all  Select 587 as ImageIndex ,  '#39'General\Module' +
        '\dmMainGUI.actProductPriceList=587'#39' as ActionDetails union all  ' +
        'Select 0 as ImageIndex ,  '#39'General\Module\dmMainGUI.actERPTip=0'#39 +
        ' as ActionDetails union all  Select 628 as ImageIndex ,  '#39'Genera' +
        'l\Module\dmMainGUI.actsalesdispatch=628'#39' as ActionDetails union ' +
        'all  Select 632 as ImageIndex ,  '#39'General\Module\dmMainGUI.actSa' +
        'lesDispatches=632'#39' as ActionDetails union all  Select 584 as Ima' +
        'geIndex ,  '#39'General\Module\dmMainGUI.actSalesDispatchBatches=584' +
        #39' as ActionDetails union all  Select 388 as ImageIndex ,  '#39'Gener' +
        'al\Module\dmMainGUI.actProjectInstallations=388'#39' as ActionDetail' +
        's) as UsedNumbers on Allnumbers.ImageIndex= UsedNumbers.imageInd' +
        'ex   group by Allnumbers.ImageIndex   having TimesUSed =0 Order ' +
        'by ImageIndex')
    BeforeOpen = qryimageIndexesBeforeOpen
    AfterScroll = qryimageIndexesAfterScroll
    Left = 728
    Top = 360
    object qryimageIndexesImageIndex: TLargeintField
      DisplayWidth = 15
      FieldName = 'ImageIndex'
    end
    object qryimageIndexesTimesUSed: TLargeintField
      DisplayWidth = 15
      FieldName = 'TimesUSed'
      Visible = False
    end
  end
  object dsimageIndexes: TDataSource
    DataSet = qryimageIndexes
    Left = 768
    Top = 360
  end
  object qryimageIndexesmultiused: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select  Allnumbers.ImageIndex , count(UsedNumbers.imageIndex) as' +
        ' TimesUSed , GROUP_CONCAT(ActionDetails) as ActionDetails from (' +
        'Select 1 as ImageIndex'
      'union all Select 2 as ImageIndex'
      'union all Select 3 as ImageIndex'
      'union all Select 4 as ImageIndex'
      'union all Select 5 as ImageIndex'
      'union all Select 6 as ImageIndex'
      'union all Select 7 as ImageIndex'
      'union all Select 8 as ImageIndex'
      'union all Select 9 as ImageIndex'
      'union all Select 10 as ImageIndex'
      'union all Select 11 as ImageIndex'
      'union all Select 12 as ImageIndex'
      'union all Select 13 as ImageIndex'
      'union all Select 14 as ImageIndex'
      'union all Select 15 as ImageIndex'
      'union all Select 16 as ImageIndex'
      'union all Select 17 as ImageIndex'
      'union all Select 18 as ImageIndex'
      'union all Select 19 as ImageIndex'
      'union all Select 20 as ImageIndex'
      'union all Select 21 as ImageIndex'
      'union all Select 22 as ImageIndex'
      'union all Select 23 as ImageIndex'
      'union all Select 24 as ImageIndex'
      'union all Select 25 as ImageIndex'
      'union all Select 26 as ImageIndex'
      'union all Select 27 as ImageIndex'
      'union all Select 28 as ImageIndex'
      'union all Select 29 as ImageIndex'
      'union all Select 30 as ImageIndex'
      'union all Select 31 as ImageIndex'
      'union all Select 32 as ImageIndex'
      'union all Select 33 as ImageIndex'
      'union all Select 34 as ImageIndex'
      'union all Select 35 as ImageIndex'
      'union all Select 36 as ImageIndex'
      'union all Select 37 as ImageIndex'
      'union all Select 38 as ImageIndex'
      'union all Select 39 as ImageIndex'
      'union all Select 40 as ImageIndex'
      'union all Select 41 as ImageIndex'
      'union all Select 42 as ImageIndex'
      'union all Select 43 as ImageIndex'
      'union all Select 44 as ImageIndex'
      'union all Select 45 as ImageIndex'
      'union all Select 46 as ImageIndex'
      'union all Select 47 as ImageIndex'
      'union all Select 48 as ImageIndex'
      'union all Select 49 as ImageIndex'
      'union all Select 50 as ImageIndex'
      'union all Select 51 as ImageIndex'
      'union all Select 52 as ImageIndex'
      'union all Select 53 as ImageIndex'
      'union all Select 54 as ImageIndex'
      'union all Select 55 as ImageIndex'
      'union all Select 56 as ImageIndex'
      'union all Select 57 as ImageIndex'
      'union all Select 58 as ImageIndex'
      'union all Select 59 as ImageIndex'
      'union all Select 60 as ImageIndex'
      'union all Select 61 as ImageIndex'
      'union all Select 62 as ImageIndex'
      'union all Select 63 as ImageIndex'
      'union all Select 64 as ImageIndex'
      'union all Select 65 as ImageIndex'
      'union all Select 66 as ImageIndex'
      'union all Select 67 as ImageIndex'
      'union all Select 68 as ImageIndex'
      'union all Select 69 as ImageIndex'
      'union all Select 70 as ImageIndex'
      'union all Select 71 as ImageIndex'
      'union all Select 72 as ImageIndex'
      'union all Select 73 as ImageIndex'
      'union all Select 74 as ImageIndex'
      'union all Select 75 as ImageIndex'
      'union all Select 76 as ImageIndex'
      'union all Select 77 as ImageIndex'
      'union all Select 78 as ImageIndex'
      'union all Select 79 as ImageIndex'
      'union all Select 80 as ImageIndex'
      'union all Select 81 as ImageIndex'
      'union all Select 82 as ImageIndex'
      'union all Select 83 as ImageIndex'
      'union all Select 84 as ImageIndex'
      'union all Select 85 as ImageIndex'
      'union all Select 86 as ImageIndex'
      'union all Select 87 as ImageIndex'
      'union all Select 88 as ImageIndex'
      'union all Select 89 as ImageIndex'
      'union all Select 90 as ImageIndex'
      'union all Select 91 as ImageIndex'
      'union all Select 92 as ImageIndex'
      'union all Select 93 as ImageIndex'
      'union all Select 94 as ImageIndex'
      'union all Select 95 as ImageIndex'
      'union all Select 96 as ImageIndex'
      'union all Select 97 as ImageIndex'
      'union all Select 98 as ImageIndex'
      'union all Select 99 as ImageIndex'
      'union all Select 100 as ImageIndex'
      'union all Select 101 as ImageIndex'
      'union all Select 102 as ImageIndex'
      'union all Select 103 as ImageIndex'
      'union all Select 104 as ImageIndex'
      'union all Select 105 as ImageIndex'
      'union all Select 106 as ImageIndex'
      'union all Select 107 as ImageIndex'
      'union all Select 108 as ImageIndex'
      'union all Select 109 as ImageIndex'
      'union all Select 110 as ImageIndex'
      'union all Select 111 as ImageIndex'
      'union all Select 112 as ImageIndex'
      'union all Select 113 as ImageIndex'
      'union all Select 114 as ImageIndex'
      'union all Select 115 as ImageIndex'
      'union all Select 116 as ImageIndex'
      'union all Select 117 as ImageIndex'
      'union all Select 118 as ImageIndex'
      'union all Select 119 as ImageIndex'
      'union all Select 120 as ImageIndex'
      'union all Select 121 as ImageIndex'
      'union all Select 122 as ImageIndex'
      'union all Select 123 as ImageIndex'
      'union all Select 124 as ImageIndex'
      'union all Select 125 as ImageIndex'
      'union all Select 126 as ImageIndex'
      'union all Select 127 as ImageIndex'
      'union all Select 128 as ImageIndex'
      'union all Select 129 as ImageIndex'
      'union all Select 130 as ImageIndex'
      'union all Select 131 as ImageIndex'
      'union all Select 132 as ImageIndex'
      'union all Select 133 as ImageIndex'
      'union all Select 134 as ImageIndex'
      'union all Select 135 as ImageIndex'
      'union all Select 136 as ImageIndex'
      'union all Select 137 as ImageIndex'
      'union all Select 138 as ImageIndex'
      'union all Select 139 as ImageIndex'
      'union all Select 140 as ImageIndex'
      'union all Select 141 as ImageIndex'
      'union all Select 142 as ImageIndex'
      'union all Select 143 as ImageIndex'
      'union all Select 144 as ImageIndex'
      'union all Select 145 as ImageIndex'
      'union all Select 146 as ImageIndex'
      'union all Select 147 as ImageIndex'
      'union all Select 148 as ImageIndex'
      'union all Select 149 as ImageIndex'
      'union all Select 150 as ImageIndex'
      'union all Select 151 as ImageIndex'
      'union all Select 152 as ImageIndex'
      'union all Select 153 as ImageIndex'
      'union all Select 154 as ImageIndex'
      'union all Select 155 as ImageIndex'
      'union all Select 156 as ImageIndex'
      'union all Select 157 as ImageIndex'
      'union all Select 158 as ImageIndex'
      'union all Select 159 as ImageIndex'
      'union all Select 160 as ImageIndex'
      'union all Select 161 as ImageIndex'
      'union all Select 162 as ImageIndex'
      'union all Select 163 as ImageIndex'
      'union all Select 164 as ImageIndex'
      'union all Select 165 as ImageIndex'
      'union all Select 166 as ImageIndex'
      'union all Select 167 as ImageIndex'
      'union all Select 168 as ImageIndex'
      'union all Select 169 as ImageIndex'
      'union all Select 170 as ImageIndex'
      'union all Select 171 as ImageIndex'
      'union all Select 172 as ImageIndex'
      'union all Select 173 as ImageIndex'
      'union all Select 174 as ImageIndex'
      'union all Select 175 as ImageIndex'
      'union all Select 176 as ImageIndex'
      'union all Select 177 as ImageIndex'
      'union all Select 178 as ImageIndex'
      'union all Select 179 as ImageIndex'
      'union all Select 180 as ImageIndex'
      'union all Select 181 as ImageIndex'
      'union all Select 182 as ImageIndex'
      'union all Select 183 as ImageIndex'
      'union all Select 184 as ImageIndex'
      'union all Select 185 as ImageIndex'
      'union all Select 186 as ImageIndex'
      'union all Select 187 as ImageIndex'
      'union all Select 188 as ImageIndex'
      'union all Select 189 as ImageIndex'
      'union all Select 190 as ImageIndex'
      'union all Select 191 as ImageIndex'
      'union all Select 192 as ImageIndex'
      'union all Select 193 as ImageIndex'
      'union all Select 194 as ImageIndex'
      'union all Select 195 as ImageIndex'
      'union all Select 196 as ImageIndex'
      'union all Select 197 as ImageIndex'
      'union all Select 198 as ImageIndex'
      'union all Select 199 as ImageIndex'
      'union all Select 200 as ImageIndex'
      'union all Select 201 as ImageIndex'
      'union all Select 202 as ImageIndex'
      'union all Select 203 as ImageIndex'
      'union all Select 204 as ImageIndex'
      'union all Select 205 as ImageIndex'
      'union all Select 206 as ImageIndex'
      'union all Select 207 as ImageIndex'
      'union all Select 208 as ImageIndex'
      'union all Select 209 as ImageIndex'
      'union all Select 210 as ImageIndex'
      'union all Select 211 as ImageIndex'
      'union all Select 212 as ImageIndex'
      'union all Select 213 as ImageIndex'
      'union all Select 214 as ImageIndex'
      'union all Select 215 as ImageIndex'
      'union all Select 216 as ImageIndex'
      'union all Select 217 as ImageIndex'
      'union all Select 218 as ImageIndex'
      'union all Select 219 as ImageIndex'
      'union all Select 220 as ImageIndex'
      'union all Select 221 as ImageIndex'
      'union all Select 222 as ImageIndex'
      'union all Select 223 as ImageIndex'
      'union all Select 224 as ImageIndex'
      'union all Select 225 as ImageIndex'
      'union all Select 226 as ImageIndex'
      'union all Select 227 as ImageIndex'
      'union all Select 228 as ImageIndex'
      'union all Select 229 as ImageIndex'
      'union all Select 230 as ImageIndex'
      'union all Select 231 as ImageIndex'
      'union all Select 232 as ImageIndex'
      'union all Select 233 as ImageIndex'
      'union all Select 234 as ImageIndex'
      'union all Select 235 as ImageIndex'
      'union all Select 236 as ImageIndex'
      'union all Select 237 as ImageIndex'
      'union all Select 238 as ImageIndex'
      'union all Select 239 as ImageIndex'
      'union all Select 240 as ImageIndex'
      'union all Select 241 as ImageIndex'
      'union all Select 242 as ImageIndex'
      'union all Select 243 as ImageIndex'
      'union all Select 244 as ImageIndex'
      'union all Select 245 as ImageIndex'
      'union all Select 246 as ImageIndex'
      'union all Select 247 as ImageIndex'
      'union all Select 248 as ImageIndex'
      'union all Select 249 as ImageIndex'
      'union all Select 250 as ImageIndex'
      'union all Select 251 as ImageIndex'
      'union all Select 252 as ImageIndex'
      'union all Select 253 as ImageIndex'
      'union all Select 254 as ImageIndex'
      'union all Select 255 as ImageIndex'
      'union all Select 256 as ImageIndex'
      'union all Select 257 as ImageIndex'
      'union all Select 258 as ImageIndex'
      'union all Select 259 as ImageIndex'
      'union all Select 260 as ImageIndex'
      'union all Select 261 as ImageIndex'
      'union all Select 262 as ImageIndex'
      'union all Select 263 as ImageIndex'
      'union all Select 264 as ImageIndex'
      'union all Select 265 as ImageIndex'
      'union all Select 266 as ImageIndex'
      'union all Select 267 as ImageIndex'
      'union all Select 268 as ImageIndex'
      'union all Select 269 as ImageIndex'
      'union all Select 270 as ImageIndex'
      'union all Select 271 as ImageIndex'
      'union all Select 272 as ImageIndex'
      'union all Select 273 as ImageIndex'
      'union all Select 274 as ImageIndex'
      'union all Select 275 as ImageIndex'
      'union all Select 276 as ImageIndex'
      'union all Select 277 as ImageIndex'
      'union all Select 278 as ImageIndex'
      'union all Select 279 as ImageIndex'
      'union all Select 280 as ImageIndex'
      'union all Select 281 as ImageIndex'
      'union all Select 282 as ImageIndex'
      'union all Select 283 as ImageIndex'
      'union all Select 284 as ImageIndex'
      'union all Select 285 as ImageIndex'
      'union all Select 286 as ImageIndex'
      'union all Select 287 as ImageIndex'
      'union all Select 288 as ImageIndex'
      'union all Select 289 as ImageIndex'
      'union all Select 290 as ImageIndex'
      'union all Select 291 as ImageIndex'
      'union all Select 292 as ImageIndex'
      'union all Select 293 as ImageIndex'
      'union all Select 294 as ImageIndex'
      'union all Select 295 as ImageIndex'
      'union all Select 296 as ImageIndex'
      'union all Select 297 as ImageIndex'
      'union all Select 298 as ImageIndex'
      'union all Select 299 as ImageIndex'
      'union all Select 300 as ImageIndex'
      'union all Select 301 as ImageIndex'
      'union all Select 302 as ImageIndex'
      'union all Select 303 as ImageIndex'
      'union all Select 304 as ImageIndex'
      'union all Select 305 as ImageIndex'
      'union all Select 306 as ImageIndex'
      'union all Select 307 as ImageIndex'
      'union all Select 308 as ImageIndex'
      'union all Select 309 as ImageIndex'
      'union all Select 310 as ImageIndex'
      'union all Select 311 as ImageIndex'
      'union all Select 312 as ImageIndex'
      'union all Select 313 as ImageIndex'
      'union all Select 314 as ImageIndex'
      'union all Select 315 as ImageIndex'
      'union all Select 316 as ImageIndex'
      'union all Select 317 as ImageIndex'
      'union all Select 318 as ImageIndex'
      'union all Select 319 as ImageIndex'
      'union all Select 320 as ImageIndex'
      'union all Select 321 as ImageIndex'
      'union all Select 322 as ImageIndex'
      'union all Select 323 as ImageIndex'
      'union all Select 324 as ImageIndex'
      'union all Select 325 as ImageIndex'
      'union all Select 326 as ImageIndex'
      'union all Select 327 as ImageIndex'
      'union all Select 328 as ImageIndex'
      'union all Select 329 as ImageIndex'
      'union all Select 330 as ImageIndex'
      'union all Select 331 as ImageIndex'
      'union all Select 332 as ImageIndex'
      'union all Select 333 as ImageIndex'
      'union all Select 334 as ImageIndex'
      'union all Select 335 as ImageIndex'
      'union all Select 336 as ImageIndex'
      'union all Select 337 as ImageIndex'
      'union all Select 338 as ImageIndex'
      'union all Select 339 as ImageIndex'
      'union all Select 340 as ImageIndex'
      'union all Select 341 as ImageIndex'
      'union all Select 342 as ImageIndex'
      'union all Select 343 as ImageIndex'
      'union all Select 344 as ImageIndex'
      'union all Select 345 as ImageIndex'
      'union all Select 346 as ImageIndex'
      'union all Select 347 as ImageIndex'
      'union all Select 348 as ImageIndex'
      'union all Select 349 as ImageIndex'
      'union all Select 350 as ImageIndex'
      'union all Select 351 as ImageIndex'
      'union all Select 352 as ImageIndex'
      'union all Select 353 as ImageIndex'
      'union all Select 354 as ImageIndex'
      'union all Select 355 as ImageIndex'
      'union all Select 356 as ImageIndex'
      'union all Select 357 as ImageIndex'
      'union all Select 358 as ImageIndex'
      'union all Select 359 as ImageIndex'
      'union all Select 360 as ImageIndex'
      'union all Select 361 as ImageIndex'
      'union all Select 362 as ImageIndex'
      'union all Select 363 as ImageIndex'
      'union all Select 364 as ImageIndex'
      'union all Select 365 as ImageIndex'
      'union all Select 366 as ImageIndex'
      'union all Select 367 as ImageIndex'
      'union all Select 368 as ImageIndex'
      'union all Select 369 as ImageIndex'
      'union all Select 370 as ImageIndex'
      'union all Select 371 as ImageIndex'
      'union all Select 372 as ImageIndex'
      'union all Select 373 as ImageIndex'
      'union all Select 374 as ImageIndex'
      'union all Select 375 as ImageIndex'
      'union all Select 376 as ImageIndex'
      'union all Select 377 as ImageIndex'
      'union all Select 378 as ImageIndex'
      'union all Select 379 as ImageIndex'
      'union all Select 380 as ImageIndex'
      'union all Select 381 as ImageIndex'
      'union all Select 382 as ImageIndex'
      'union all Select 383 as ImageIndex'
      'union all Select 384 as ImageIndex'
      'union all Select 385 as ImageIndex'
      'union all Select 386 as ImageIndex'
      'union all Select 387 as ImageIndex'
      'union all Select 388 as ImageIndex'
      'union all Select 389 as ImageIndex'
      'union all Select 390 as ImageIndex'
      'union all Select 391 as ImageIndex'
      'union all Select 392 as ImageIndex'
      'union all Select 393 as ImageIndex'
      'union all Select 394 as ImageIndex'
      'union all Select 395 as ImageIndex'
      'union all Select 396 as ImageIndex'
      'union all Select 397 as ImageIndex'
      'union all Select 398 as ImageIndex'
      'union all Select 399 as ImageIndex'
      'union all Select 400 as ImageIndex'
      'union all Select 401 as ImageIndex'
      'union all Select 402 as ImageIndex'
      'union all Select 403 as ImageIndex'
      'union all Select 404 as ImageIndex'
      'union all Select 405 as ImageIndex'
      'union all Select 406 as ImageIndex'
      'union all Select 407 as ImageIndex'
      'union all Select 408 as ImageIndex'
      'union all Select 409 as ImageIndex'
      'union all Select 410 as ImageIndex'
      'union all Select 411 as ImageIndex'
      'union all Select 412 as ImageIndex'
      'union all Select 413 as ImageIndex'
      'union all Select 414 as ImageIndex'
      'union all Select 415 as ImageIndex'
      'union all Select 416 as ImageIndex'
      'union all Select 417 as ImageIndex'
      'union all Select 418 as ImageIndex'
      'union all Select 419 as ImageIndex'
      'union all Select 420 as ImageIndex'
      'union all Select 421 as ImageIndex'
      'union all Select 422 as ImageIndex'
      'union all Select 423 as ImageIndex'
      'union all Select 424 as ImageIndex'
      'union all Select 425 as ImageIndex'
      'union all Select 426 as ImageIndex'
      'union all Select 427 as ImageIndex'
      'union all Select 428 as ImageIndex'
      'union all Select 429 as ImageIndex'
      'union all Select 430 as ImageIndex'
      'union all Select 431 as ImageIndex'
      'union all Select 432 as ImageIndex'
      'union all Select 433 as ImageIndex'
      'union all Select 434 as ImageIndex'
      'union all Select 435 as ImageIndex'
      'union all Select 436 as ImageIndex'
      'union all Select 437 as ImageIndex'
      'union all Select 438 as ImageIndex'
      'union all Select 439 as ImageIndex'
      'union all Select 440 as ImageIndex'
      'union all Select 441 as ImageIndex'
      'union all Select 442 as ImageIndex'
      'union all Select 443 as ImageIndex'
      'union all Select 444 as ImageIndex'
      'union all Select 445 as ImageIndex'
      'union all Select 446 as ImageIndex'
      'union all Select 447 as ImageIndex'
      'union all Select 448 as ImageIndex'
      'union all Select 449 as ImageIndex'
      'union all Select 450 as ImageIndex'
      'union all Select 451 as ImageIndex'
      'union all Select 452 as ImageIndex'
      'union all Select 453 as ImageIndex'
      'union all Select 454 as ImageIndex'
      'union all Select 455 as ImageIndex'
      'union all Select 456 as ImageIndex'
      'union all Select 457 as ImageIndex'
      'union all Select 458 as ImageIndex'
      'union all Select 459 as ImageIndex'
      'union all Select 460 as ImageIndex'
      'union all Select 461 as ImageIndex'
      'union all Select 462 as ImageIndex'
      'union all Select 463 as ImageIndex'
      'union all Select 464 as ImageIndex'
      'union all Select 465 as ImageIndex'
      'union all Select 466 as ImageIndex'
      'union all Select 467 as ImageIndex'
      'union all Select 468 as ImageIndex'
      'union all Select 469 as ImageIndex'
      'union all Select 470 as ImageIndex'
      'union all Select 471 as ImageIndex'
      'union all Select 472 as ImageIndex'
      'union all Select 473 as ImageIndex'
      'union all Select 474 as ImageIndex'
      'union all Select 475 as ImageIndex'
      'union all Select 476 as ImageIndex'
      'union all Select 477 as ImageIndex'
      'union all Select 478 as ImageIndex'
      'union all Select 479 as ImageIndex'
      'union all Select 480 as ImageIndex'
      'union all Select 481 as ImageIndex'
      'union all Select 482 as ImageIndex'
      'union all Select 483 as ImageIndex'
      'union all Select 484 as ImageIndex'
      'union all Select 485 as ImageIndex'
      'union all Select 486 as ImageIndex'
      'union all Select 487 as ImageIndex'
      'union all Select 488 as ImageIndex'
      'union all Select 489 as ImageIndex'
      'union all Select 490 as ImageIndex'
      'union all Select 491 as ImageIndex'
      'union all Select 492 as ImageIndex'
      'union all Select 493 as ImageIndex'
      'union all Select 494 as ImageIndex'
      'union all Select 495 as ImageIndex'
      'union all Select 496 as ImageIndex'
      'union all Select 497 as ImageIndex'
      'union all Select 498 as ImageIndex'
      'union all Select 499 as ImageIndex'
      'union all Select 500 as ImageIndex'
      'union all Select 501 as ImageIndex'
      'union all Select 502 as ImageIndex'
      'union all Select 503 as ImageIndex'
      'union all Select 504 as ImageIndex'
      'union all Select 505 as ImageIndex'
      'union all Select 506 as ImageIndex'
      'union all Select 507 as ImageIndex'
      'union all Select 508 as ImageIndex'
      'union all Select 509 as ImageIndex'
      'union all Select 510 as ImageIndex'
      'union all Select 511 as ImageIndex'
      'union all Select 512 as ImageIndex'
      'union all Select 513 as ImageIndex'
      'union all Select 514 as ImageIndex'
      'union all Select 515 as ImageIndex'
      'union all Select 516 as ImageIndex'
      'union all Select 517 as ImageIndex'
      'union all Select 518 as ImageIndex'
      'union all Select 519 as ImageIndex'
      'union all Select 520 as ImageIndex'
      'union all Select 521 as ImageIndex'
      'union all Select 522 as ImageIndex'
      'union all Select 523 as ImageIndex'
      'union all Select 524 as ImageIndex'
      'union all Select 525 as ImageIndex'
      'union all Select 526 as ImageIndex'
      'union all Select 527 as ImageIndex'
      'union all Select 528 as ImageIndex'
      'union all Select 529 as ImageIndex'
      'union all Select 530 as ImageIndex'
      'union all Select 531 as ImageIndex'
      'union all Select 532 as ImageIndex'
      'union all Select 533 as ImageIndex'
      'union all Select 534 as ImageIndex'
      'union all Select 535 as ImageIndex'
      'union all Select 536 as ImageIndex'
      'union all Select 537 as ImageIndex'
      'union all Select 538 as ImageIndex'
      'union all Select 539 as ImageIndex'
      'union all Select 540 as ImageIndex'
      'union all Select 541 as ImageIndex'
      'union all Select 542 as ImageIndex'
      'union all Select 543 as ImageIndex'
      'union all Select 544 as ImageIndex'
      'union all Select 545 as ImageIndex'
      'union all Select 546 as ImageIndex'
      'union all Select 547 as ImageIndex'
      'union all Select 548 as ImageIndex'
      'union all Select 549 as ImageIndex'
      'union all Select 550 as ImageIndex'
      'union all Select 551 as ImageIndex'
      'union all Select 552 as ImageIndex'
      'union all Select 553 as ImageIndex'
      'union all Select 554 as ImageIndex'
      'union all Select 555 as ImageIndex'
      'union all Select 556 as ImageIndex'
      'union all Select 557 as ImageIndex'
      'union all Select 558 as ImageIndex'
      'union all Select 559 as ImageIndex'
      'union all Select 560 as ImageIndex'
      'union all Select 561 as ImageIndex'
      'union all Select 562 as ImageIndex'
      'union all Select 563 as ImageIndex'
      'union all Select 564 as ImageIndex'
      'union all Select 565 as ImageIndex'
      'union all Select 566 as ImageIndex'
      'union all Select 567 as ImageIndex'
      'union all Select 568 as ImageIndex'
      'union all Select 569 as ImageIndex'
      'union all Select 570 as ImageIndex'
      'union all Select 571 as ImageIndex'
      'union all Select 572 as ImageIndex'
      'union all Select 573 as ImageIndex'
      'union all Select 574 as ImageIndex'
      'union all Select 575 as ImageIndex'
      'union all Select 576 as ImageIndex'
      'union all Select 577 as ImageIndex'
      'union all Select 578 as ImageIndex'
      'union all Select 579 as ImageIndex'
      'union all Select 580 as ImageIndex'
      'union all Select 581 as ImageIndex'
      'union all Select 582 as ImageIndex'
      'union all Select 583 as ImageIndex'
      'union all Select 584 as ImageIndex'
      'union all Select 585 as ImageIndex'
      'union all Select 586 as ImageIndex'
      'union all Select 587 as ImageIndex'
      'union all Select 588 as ImageIndex'
      'union all Select 589 as ImageIndex'
      'union all Select 590 as ImageIndex'
      'union all Select 591 as ImageIndex'
      'union all Select 592 as ImageIndex'
      'union all Select 593 as ImageIndex'
      'union all Select 594 as ImageIndex'
      'union all Select 595 as ImageIndex'
      'union all Select 596 as ImageIndex'
      'union all Select 597 as ImageIndex'
      'union all Select 598 as ImageIndex'
      'union all Select 599 as ImageIndex'
      'union all Select 600 as ImageIndex'
      'union all Select 601 as ImageIndex'
      'union all Select 602 as ImageIndex'
      'union all Select 603 as ImageIndex'
      'union all Select 604 as ImageIndex'
      'union all Select 605 as ImageIndex'
      'union all Select 606 as ImageIndex'
      'union all Select 607 as ImageIndex'
      'union all Select 608 as ImageIndex'
      'union all Select 609 as ImageIndex'
      'union all Select 610 as ImageIndex'
      'union all Select 611 as ImageIndex'
      'union all Select 612 as ImageIndex'
      'union all Select 613 as ImageIndex'
      'union all Select 614 as ImageIndex'
      'union all Select 615 as ImageIndex'
      'union all Select 616 as ImageIndex'
      'union all Select 617 as ImageIndex'
      'union all Select 618 as ImageIndex'
      'union all Select 619 as ImageIndex'
      'union all Select 620 as ImageIndex'
      'union all Select 621 as ImageIndex'
      'union all Select 622 as ImageIndex'
      'union all Select 623 as ImageIndex'
      'union all Select 624 as ImageIndex'
      'union all Select 625 as ImageIndex'
      'union all Select 626 as ImageIndex'
      'union all Select 627 as ImageIndex'
      'union all Select 628 as ImageIndex'
      'union all Select 629 as ImageIndex'
      'union all Select 630 as ImageIndex'
      'union all Select 631 as ImageIndex'
      'union all Select 632 as ImageIndex'
      'union all Select 633 as ImageIndex'
      'union all Select 634 as ImageIndex'
      'union all Select 635 as ImageIndex'
      'union all Select 636 as ImageIndex'
      'union all Select 637 as ImageIndex'
      'union all Select 638 as ImageIndex'
      'union all Select 639 as ImageIndex'
      'union all Select 640 as ImageIndex'
      'union all Select 641 as ImageIndex'
      'union all Select 642 as ImageIndex'
      'union all Select 643 as ImageIndex'
      'union all Select 644 as ImageIndex'
      'union all Select 645 as ImageIndex'
      'union all Select 646 as ImageIndex'
      'union all Select 647 as ImageIndex'
      'union all Select 648 as ImageIndex'
      'union all Select 649 as ImageIndex'
      'union all Select 650 as ImageIndex'
      'union all Select 651 as ImageIndex'
      'union all Select 652 as ImageIndex'
      'union all Select 653 as ImageIndex'
      'union all Select 654 as ImageIndex'
      'union all Select 655 as ImageIndex'
      'union all Select 656 as ImageIndex'
      'union all Select 657 as ImageIndex'
      'union all Select 658 as ImageIndex'
      'union all Select 659 as ImageIndex'
      'union all Select 660 as ImageIndex'
      'union all Select 661 as ImageIndex'
      'union all Select 662 as ImageIndex'
      'union all Select 663 as ImageIndex'
      'union all Select 664 as ImageIndex'
      'union all Select 665 as ImageIndex'
      'union all Select 666 as ImageIndex'
      'union all Select 667 as ImageIndex'
      'union all Select 668 as ImageIndex'
      'union all Select 669 as ImageIndex'
      'union all Select 670 as ImageIndex'
      'union all Select 671 as ImageIndex'
      'union all Select 672 as ImageIndex'
      'union all Select 673 as ImageIndex'
      'union all Select 674 as ImageIndex'
      'union all Select 675 as ImageIndex'
      'union all Select 676 as ImageIndex'
      'union all Select 677 as ImageIndex'
      'union all Select 678 as ImageIndex'
      'union all Select 679 as ImageIndex'
      'union all Select 680 as ImageIndex'
      'union all Select 681 as ImageIndex'
      'union all Select 682 as ImageIndex'
      'union all Select 683 as ImageIndex'
      'union all Select 684 as ImageIndex'
      'union all Select 685 as ImageIndex'
      'union all Select 686 as ImageIndex'
      'union all Select 687 as ImageIndex'
      'union all Select 688 as ImageIndex'
      'union all Select 689 as ImageIndex'
      'union all Select 690 as ImageIndex'
      'union all Select 691 as ImageIndex'
      'union all Select 692 as ImageIndex'
      'union all Select 693 as ImageIndex'
      'union all Select 694 as ImageIndex'
      'union all Select 695 as ImageIndex'
      'union all Select 696 as ImageIndex'
      'union all Select 697 as ImageIndex'
      'union all Select 698 as ImageIndex'
      'union all Select 699 as ImageIndex'
      'union all Select 700 as ImageIndex'
      'union all Select 701 as ImageIndex'
      'union all Select 702 as ImageIndex'
      'union all Select 703 as ImageIndex'
      'union all Select 704 as ImageIndex'
      'union all Select 705 as ImageIndex'
      'union all Select 706 as ImageIndex'
      'union all Select 707 as ImageIndex'
      'union all Select 708 as ImageIndex'
      'union all Select 709 as ImageIndex'
      'union all Select 710 as ImageIndex'
      'union all Select 711 as ImageIndex'
      'union all Select 712 as ImageIndex'
      'union all Select 713 as ImageIndex'
      'union all Select 714 as ImageIndex'
      'union all Select 715 as ImageIndex'
      'union all Select 716 as ImageIndex'
      'union all Select 717 as ImageIndex'
      'union all Select 718 as ImageIndex'
      'union all Select 719 as ImageIndex'
      'union all Select 720 as ImageIndex'
      'union all Select 721 as ImageIndex'
      'union all Select 722 as ImageIndex'
      'union all Select 723 as ImageIndex'
      'union all Select 724 as ImageIndex'
      'union all Select 725 as ImageIndex'
      'union all Select 726 as ImageIndex'
      'union all Select 727 as ImageIndex'
      'union all Select 728 as ImageIndex'
      'union all Select 729 as ImageIndex'
      'union all Select 730 as ImageIndex'
      'union all Select 731 as ImageIndex'
      'union all Select 732 as ImageIndex'
      'union all Select 733 as ImageIndex'
      'union all Select 734 as ImageIndex'
      'union all Select 735 as ImageIndex'
      'union all Select 736 as ImageIndex'
      'union all Select 737 as ImageIndex'
      'union all Select 738 as ImageIndex'
      'union all Select 739 as ImageIndex'
      'union all Select 740 as ImageIndex'
      'union all Select 741 as ImageIndex'
      'union all Select 742 as ImageIndex'
      'union all Select 743 as ImageIndex'
      'union all Select 744 as ImageIndex'
      'union all Select 745 as ImageIndex'
      'union all Select 746 as ImageIndex'
      'union all Select 747 as ImageIndex'
      'union all Select 748 as ImageIndex'
      'union all Select 749 as ImageIndex'
      'union all Select 750 as ImageIndex'
      'union all Select 751 as ImageIndex'
      'union all Select 752 as ImageIndex'
      'union all Select 753 as ImageIndex'
      'union all Select 754 as ImageIndex'
      'union all Select 755 as ImageIndex'
      'union all Select 756 as ImageIndex'
      'union all Select 757 as ImageIndex'
      'union all Select 758 as ImageIndex'
      'union all Select 759 as ImageIndex'
      
        ')  Allnumbers   Left join ( Select 0 as ImageIndex ,  '#39'Appointme' +
        'nts\InputForms\frmAppointments.ActUpdateRepairs=0'#39' as ActionDeta' +
        'ils union all  Select 0 as ImageIndex ,  '#39'BaseClasses\InputForms' +
        '\Cash.actcheckdiscount=0'#39' as ActionDetails union all  Select 322' +
        ' as ImageIndex ,  '#39'Budgets\Module\datBudgetAddin.actBudgetDefini' +
        'tion=322'#39' as ActionDetails union all  Select 347 as ImageIndex ,' +
        '  '#39'Budgets\Module\datBudgetAddin.actBudget=347'#39' as ActionDetails' +
        ' union all  Select 314 as ImageIndex ,  '#39'Budgets\Module\datBudge' +
        'tAddin.actBudgetVariation=314'#39' as ActionDetails union all  Selec' +
        't 350 as ImageIndex ,  '#39'Budgets\Module\datBudgetAddin.actBudgetA' +
        'ccountList=350'#39' as ActionDetails union all  Select 169 as ImageI' +
        'ndex ,  '#39'Budgets\Module\datBudgetAddin.actBudgetvsActual=169'#39' as' +
        ' ActionDetails union all  Select 307 as ImageIndex ,  '#39'Budgets\M' +
        'odule\datBudgetAddin.actReportsBudget=307'#39' as ActionDetails unio' +
        'n all  Select 323 as ImageIndex ,  '#39'Budgets\Module\datBudgetAddi' +
        'n.actBudgetDefinitionList=323'#39' as ActionDetails union all  Selec' +
        't 348 as ImageIndex ,  '#39'Budgets\Module\datBudgetAddin.actBudgetL' +
        'ist=348'#39' as ActionDetails union all  Select 267 as ImageIndex , ' +
        ' '#39'Budgets\Module\datBudgetAddin.actBudgetProfitAndLossReport=267' +
        #39' as ActionDetails union all  Select 311 as ImageIndex ,  '#39'Budge' +
        'ts\Module\datBudgetAddin.actJobBudgetVsActual=311'#39' as ActionDeta' +
        'ils union all  Select 0 as ImageIndex ,  '#39'Inventory\InputForms\f' +
        'rmPartsFrm.actEquipment=0'#39' as ActionDetails union all  Select 0 ' +
        'as ImageIndex ,  '#39'Inventory\ListForms\ProductListForm.actSelectA' +
        'll=0'#39' as ActionDetails union all  Select 0 as ImageIndex ,  '#39'Pay' +
        'ments\InputForms\frmCustPayments.actSave=0'#39' as ActionDetails uni' +
        'on all  Select 0 as ImageIndex ,  '#39'Payments\InputForms\frmCustPa' +
        'yments.actapplyDiscount=0'#39' as ActionDetails union all  Select 0 ' +
        'as ImageIndex ,  '#39'Payments\InputForms\frmCustPayments.actNew=0'#39' ' +
        'as ActionDetails union all  Select 0 as ImageIndex ,  '#39'Payments\' +
        'InputForms\frmCustPayments.actPrintReceipt=0'#39' as ActionDetails u' +
        'nion all  Select 0 as ImageIndex ,  '#39'Payments\InputForms\frmCust' +
        'Payments.actEmail=0'#39' as ActionDetails union all  Select 0 as Ima' +
        'geIndex ,  '#39'Payments\InputForms\frmCustPayments.actCancel=0'#39' as ' +
        'ActionDetails union all  Select 0 as ImageIndex ,  '#39'Payments\Inp' +
        'utForms\frmSuppPayments.actSave=0'#39' as ActionDetails union all  S' +
        'elect 0 as ImageIndex ,  '#39'Payments\InputForms\frmSuppPayments.ac' +
        'tNew=0'#39' as ActionDetails union all  Select 0 as ImageIndex ,  '#39'P' +
        'ayments\InputForms\frmSuppPayments.actPrintcheque=0'#39' as ActionDe' +
        'tails union all  Select 0 as ImageIndex ,  '#39'Payments\InputForms\' +
        'frmSuppPayments.actEmail=0'#39' as ActionDetails union all  Select 0' +
        ' as ImageIndex ,  '#39'Payments\InputForms\frmSuppPayments.actCancel' +
        '=0'#39' as ActionDetails union all  Select 0 as ImageIndex ,  '#39'Purch' +
        'ases\ListForms\SmartOrderListForm.actSelectREcord=0'#39' as ActionDe' +
        'tails union all  Select 0 as ImageIndex ,  '#39'Sales\InputForms\frm' +
        'Invoice.actCopyInvoice=0'#39' as ActionDetails union all  Select 0 a' +
        's ImageIndex ,  '#39'Sales\InputForms\frmQuote.actVariation=0'#39' as Ac' +
        'tionDetails union all  Select 0 as ImageIndex ,  '#39'Sales\InputFor' +
        'ms\frmRefund.actSelectSales=0'#39' as ActionDetails union all  Selec' +
        't 0 as ImageIndex ,  '#39'Sales\InputForms\frmSalesOrder.actCopyOrde' +
        'r [17]=0'#39' as ActionDetails union all  Select 0 as ImageIndex ,  ' +
        #39'Sales\InputForms\frmSalesOrder.actTakeFromStock=0'#39' as ActionDet' +
        'ails union all  Select 0 as ImageIndex ,  '#39'Sales\InputForms\frmS' +
        'alesOrder.actPartialInvoice=0'#39' as ActionDetails union all  Selec' +
        't 0 as ImageIndex ,  '#39'Sales\InputForms\frmSalesOrder.actcomplnIn' +
        'voice=0'#39' as ActionDetails union all  Select 0 as ImageIndex ,  '#39 +
        'Sales\ListForms\SalesOrderListForm.actInvoice=0'#39' as ActionDetail' +
        's union all  Select 0 as ImageIndex ,  '#39'Sales\ListForms\SalesOrd' +
        'erReportForm.actInvoice=0'#39' as ActionDetails union all  Select 0 ' +
        'as ImageIndex ,  '#39'Utilities\InputForms\frmMessages.actLead=0'#39' as' +
        ' ActionDetails union all  Select 0 as ImageIndex ,  '#39'Utilities\I' +
        'nputForms\frmMessages.actSupport=0'#39' as ActionDetails union all  ' +
        'Select 0 as ImageIndex ,  '#39'Utilities\InputForms\Preferences.actS' +
        'ave=0'#39' as ActionDetails union all  Select 0 as ImageIndex ,  '#39'Ut' +
        'ilities\InputForms\Preferences.actCancel=0'#39' as ActionDetails uni' +
        'on all  Select 0 as ImageIndex ,  '#39'Manufacturing\InputForms\frmP' +
        'rocCapacityPlanning.actOrderStatus=0'#39' as ActionDetails union all' +
        '  Select 0 as ImageIndex ,  '#39'Manufacturing\InputForms\frmProcCap' +
        'acityPlanning.actRoster=0'#39' as ActionDetails union all  Select 0 ' +
        'as ImageIndex ,  '#39'Manufacturing\InputForms\frmProcCapacityPlanni' +
        'ng.actLogTree=0'#39' as ActionDetails union all  Select 0 as ImageIn' +
        'dex ,  '#39'Manufacturing\InputForms\frmProcCapacityPlanning.actStow' +
        'Away=0'#39' as ActionDetails union all  Select 0 as ImageIndex ,  '#39'M' +
        'anufacturing\InputForms\frmProcCapacityPlanning.actPrintJobDetai' +
        'ls=0'#39' as ActionDetails union all  Select 0 as ImageIndex ,  '#39'Man' +
        'ufacturing\InputForms\frmProcCapacityPlanning.actPQAllocation=0'#39 +
        ' as ActionDetails union all  Select 0 as ImageIndex ,  '#39'Manufact' +
        'uring\InputForms\frmProcCapacityPlanning.actallocPickingSlip=0'#39' ' +
        'as ActionDetails union all  Select 0 as ImageIndex ,  '#39'Manufactu' +
        'ring\InputForms\frmProcCapacityPlanning.actPartialInvoice=0'#39' as ' +
        'ActionDetails union all  Select 330 as ImageIndex ,  '#39'PriceSchem' +
        'e\Module\datPriceSchemeAddin.actPriceSchemeList=330'#39' as ActionDe' +
        'tails union all  Select 326 as ImageIndex ,  '#39'PriceScheme\Module' +
        '\datPriceSchemeAddin.actPriceLists=326'#39' as ActionDetails union a' +
        'll  Select 309 as ImageIndex ,  '#39'PriceScheme\Module\datPriceSche' +
        'meAddin.actPriceSchemeReports=309'#39' as ActionDetails union all  S' +
        'elect 57 as ImageIndex ,  '#39'Marketing\Module\datMarketing.actCont' +
        'actSelectionRange=57'#39' as ActionDetails union all  Select 274 as ' +
        'ImageIndex ,  '#39'Marketing\Module\datMarketing.actContactSelection' +
        'RangeList=274'#39' as ActionDetails union all  Select 331 as ImageIn' +
        'dex ,  '#39'Marketing\Module\datMarketing.actsalesAnalysisGraph=331'#39 +
        ' as ActionDetails union all  Select 268 as ImageIndex ,  '#39'Market' +
        'ing\Module\datMarketing.actMarketing=268'#39' as ActionDetails union' +
        ' all  Select 269 as ImageIndex ,  '#39'Marketing\Module\datMarketing' +
        '.actMarketingList=269'#39' as ActionDetails union all  Select 310 as' +
        ' ImageIndex ,  '#39'Marketing\Module\datMarketing.actMarketingContac' +
        't=310'#39' as ActionDetails union all  Select 318 as ImageIndex ,  '#39 +
        'Marketing\Module\datMarketing.actMarketingContactList=318'#39' as Ac' +
        'tionDetails union all  Select 304 as ImageIndex ,  '#39'Marketing\Mo' +
        'dule\datMarketing.actMarketingContactSummary=304'#39' as ActionDetai' +
        'ls union all  Select 282 as ImageIndex ,  '#39'Marketing\Module\datM' +
        'arketing.actLeadList=282'#39' as ActionDetails union all  Select 341' +
        ' as ImageIndex ,  '#39'Marketing\Module\datMarketing.actLead=341'#39' as' +
        ' ActionDetails union all  Select 305 as ImageIndex ,  '#39'Marketing' +
        '\Module\datMarketing.actMarketingReports=305'#39' as ActionDetails u' +
        'nion all  Select 288 as ImageIndex ,  '#39'Marketing\Module\datMarke' +
        'ting.actReminderPrn=288'#39' as ActionDetails union all  Select 283 ' +
        'as ImageIndex ,  '#39'Marketing\Module\datMarketing.actMarketingCont' +
        'actListDetail=283'#39' as ActionDetails union all  Select 291 as Ima' +
        'geIndex ,  '#39'Marketing\Module\datMarketing.actMarketingContactPro' +
        'duct=291'#39' as ActionDetails union all  Select 297 as ImageIndex ,' +
        '  '#39'Marketing\Module\datMarketing.actMarketingContactcontact=297'#39 +
        ' as ActionDetails union all  Select 298 as ImageIndex ,  '#39'Market' +
        'ing\Module\datMarketing.actProductProcessList=298'#39' as ActionDeta' +
        'ils union all  Select 98 as ImageIndex ,  '#39'Marketing\Module\datM' +
        'arketing.actClientnMarketingList=98'#39' as ActionDetails union all ' +
        ' Select 299 as ImageIndex ,  '#39'Marketing\Module\datMarketing.actL' +
        'eadActionType=299'#39' as ActionDetails union all  Select 111 as Ima' +
        'geIndex ,  '#39'Inventory\InputForms\frmBarcodeAfterPacked.actPrintD' +
        'eldocket=111'#39' as ActionDetails union all  Select 188 as ImageInd' +
        'ex ,  '#39'Inventory\InputForms\frmBarcodeAfterPacked.actPrintCNote=' +
        '188'#39' as ActionDetails union all  Select 211 as ImageIndex ,  '#39'In' +
        'ventory\InputForms\frmBarcodeAfterPacked.actPrintPick=211'#39' as Ac' +
        'tionDetails union all  Select 150 as ImageIndex ,  '#39'Inventory\In' +
        'putForms\frmBarcodeAfterPacked.actPrintsale=150'#39' as ActionDetail' +
        's union all  Select 134 as ImageIndex ,  '#39'Inventory\InputForms\f' +
        'rmBarcodeAfterPacked.actPrintDespatchBarcode=134'#39' as ActionDetai' +
        'ls union all  Select 0 as ImageIndex ,  '#39'Manufacturing\ListForms' +
        '\ProductionJobStatus.actfinalise=0'#39' as ActionDetails union all  ' +
        'Select 0 as ImageIndex ,  '#39'Manufacturing\ListForms\ProductionJob' +
        'Status.actSmartOrder=0'#39' as ActionDetails union all  Select 0 as ' +
        'ImageIndex ,  '#39'Manufacturing\ListForms\ProductionPartsStatus.act' +
        'SelectAll=0'#39' as ActionDetails union all  Select 0 as ImageIndex ' +
        ',  '#39'Inventory\ListForms\ManufactureProductList.actSelectAll=0'#39' a' +
        's ActionDetails union all  Select 0 as ImageIndex ,  '#39'Inventory\' +
        'ListForms\UnitsOfMeasureBaseList.ActLinktoMultipleProducts=0'#39' as' +
        ' ActionDetails union all  Select 0 as ImageIndex ,  '#39'Manufacturi' +
        'ng\ListForms\ProductionJobStatusbase.actfinalise=0'#39' as ActionDet' +
        'ails union all  Select 29 as ImageIndex ,  '#39'Manufacturing\InputF' +
        'orms\frmBarCodeManufacturing.actEmployees=29'#39' as ActionDetails u' +
        'nion all  Select 19 as ImageIndex ,  '#39'Manufacturing\InputForms\f' +
        'rmBarCodeManufacturing.actJobs=19'#39' as ActionDetails union all  S' +
        'elect 394 as ImageIndex ,  '#39'Manufacturing\InputForms\frmBarCodeM' +
        'anufacturing.actStart=394'#39' as ActionDetails union all  Select 17' +
        '0 as ImageIndex ,  '#39'Manufacturing\InputForms\frmBarCodeManufactu' +
        'ring.actSchedule=170'#39' as ActionDetails union all  Select 107 as ' +
        'ImageIndex ,  '#39'Manufacturing\InputForms\frmBarCodeManufacturing.' +
        'actStop=107'#39' as ActionDetails union all  Select 257 as ImageInde' +
        'x ,  '#39'Manufacturing\InputForms\frmBarCodeManufacturing.actStopAl' +
        'l=257'#39' as ActionDetails union all  Select 335 as ImageIndex ,  '#39 +
        'Manufacturing\InputForms\frmBarCodeManufacturing.actComplete=335' +
        #39' as ActionDetails union all  Select 169 as ImageIndex ,  '#39'Manuf' +
        'acturing\InputForms\frmBarCodeManufacturing.actUnschedule=169'#39' a' +
        's ActionDetails union all  Select 292 as ImageIndex ,  '#39'Manufact' +
        'uring\InputForms\frmBarCodeManufacturing.actOpenSale=292'#39' as Act' +
        'ionDetails union all  Select 208 as ImageIndex ,  '#39'Manufacturing' +
        '\InputForms\frmBarCodeManufacturing.actTree=208'#39' as ActionDetail' +
        's union all  Select 241 as ImageIndex ,  '#39'Manufacturing\InputFor' +
        'ms\frmBarCodeManufacturing.actPicking=241'#39' as ActionDetails unio' +
        'n all  Select 200 as ImageIndex ,  '#39'Manufacturing\InputForms\frm' +
        'BarCodeManufacturing.actWorksheet=200'#39' as ActionDetails union al' +
        'l  Select 15 as ImageIndex ,  '#39'Manufacturing\InputForms\frmBarCo' +
        'deManufacturing.actInvoice=15'#39' as ActionDetails union all  Selec' +
        't 205 as ImageIndex ,  '#39'Manufacturing\InputForms\frmBarCodeManuf' +
        'acturing.actPrintcontrolcodes=205'#39' as ActionDetails union all  S' +
        'elect 0 as ImageIndex ,  '#39'Manufacturing\InputForms\frmBarCodeMan' +
        'ufacturing.actSelectall=0'#39' as ActionDetails union all  Select 26' +
        '1 as ImageIndex ,  '#39'Manufacturing\InputForms\frmBarCodeManufactu' +
        'ring.actQA=261'#39' as ActionDetails union all  Select 37 as ImageIn' +
        'dex ,  '#39'Manufacturing\InputForms\frmBarCodeManufacturing.actAllo' +
        'cation=37'#39' as ActionDetails union all  Select 238 as ImageIndex ' +
        ',  '#39'Manufacturing\InputForms\frmBarCodeManufacturing.actLogOff=2' +
        '38'#39' as ActionDetails union all  Select 448 as ImageIndex ,  '#39'Man' +
        'ufacturing\InputForms\frmBarCodeManufacturing.actBreak=448'#39' as A' +
        'ctionDetails union all  Select 27 as ImageIndex ,  '#39'Manufacturin' +
        'g\InputForms\frmBarCodeManufacturing.actHistory=27'#39' as ActionDet' +
        'ails union all  Select 380 as ImageIndex ,  '#39'Manufacturing\Input' +
        'Forms\frmBarCodeManufacturing.actComments=380'#39' as ActionDetails ' +
        'union all  Select 141 as ImageIndex ,  '#39'Training\modules\datTrai' +
        'ning.actTrainingAssignment=141'#39' as ActionDetails union all  Sele' +
        'ct 673 as ImageIndex ,  '#39'Training\modules\datTraining.actTrainin' +
        'gRoster=673'#39' as ActionDetails union all  Select 328 as ImageInde' +
        'x ,  '#39'Training\modules\datTraining.actTrainingProgresschart=328'#39 +
        ' as ActionDetails union all  Select 325 as ImageIndex ,  '#39'Traini' +
        'ng\modules\datTraining.actTrainingStatus=325'#39' as ActionDetails u' +
        'nion all  Select 244 as ImageIndex ,  '#39'Training\modules\datTrain' +
        'ing.actTrainingModule=244'#39' as ActionDetails union all  Select 25' +
        '9 as ImageIndex ,  '#39'Training\modules\datTraining.actSetupTrainin' +
        'g=259'#39' as ActionDetails union all  Select 249 as ImageIndex ,  '#39 +
        'Training\modules\datTraining.actVideos=249'#39' as ActionDetails uni' +
        'on all  Select 289 as ImageIndex ,  '#39'Training\modules\datTrainin' +
        'g.actCustomisetraining=289'#39' as ActionDetails union all  Select 2' +
        '87 as ImageIndex ,  '#39'Training\modules\datTraining.actSetupcompan' +
        'y=287'#39' as ActionDetails union all  Select 230 as ImageIndex ,  '#39 +
        'Training\modules\datTraining.actTrainingList=230'#39' as ActionDetai' +
        'ls union all  Select 0 as ImageIndex ,  '#39'DebugForms\Inputforms\f' +
        'rmdebugExtra.DNMAction1=0'#39' as ActionDetails union all  Select 1 ' +
        'as ImageIndex ,  '#39'DebugForms\Inputforms\frmdebugExtra.DNMAction2' +
        '=1'#39' as ActionDetails union all  Select 0 as ImageIndex ,  '#39'Debug' +
        'Forms\Inputforms\frmdebugExtra.DNMAction3=0'#39' as ActionDetails un' +
        'ion all  Select 1 as ImageIndex ,  '#39'DebugForms\Inputforms\frmdeb' +
        'ugExtra.DNMAction4=1'#39' as ActionDetails union all  Select 0 as Im' +
        'ageIndex ,  '#39'Repairs\InputForms\frmPadRepairs.actInvoice=0'#39' as A' +
        'ctionDetails union all  Select 0 as ImageIndex ,  '#39'Repairs\Input' +
        'Forms\frmPadRepairs.DNMAction1=0'#39' as ActionDetails union all  Se' +
        'lect 197 as ImageIndex ,  '#39'Repairs\Module\datRepairs.actNewRepai' +
        'r=197'#39' as ActionDetails union all  Select 198 as ImageIndex ,  '#39 +
        'Repairs\Module\datRepairs.actRepairsLsit=198'#39' as ActionDetails u' +
        'nion all  Select 43 as ImageIndex ,  '#39'Repairs\Module\datRepairs.' +
        'actRepairsExpressLsit=43'#39' as ActionDetails union all  Select 353' +
        ' as ImageIndex ,  '#39'Repairs\Module\datRepairs.actRepairListInvoci' +
        'e=353'#39' as ActionDetails union all  Select 162 as ImageIndex ,  '#39 +
        'Repairs\Module\datRepairs.actRepairfaults=162'#39' as ActionDetails ' +
        'union all  Select 158 as ImageIndex ,  '#39'Repairs\Module\datRepair' +
        's.actNewRepairfault=158'#39' as ActionDetails union all  Select 118 ' +
        'as ImageIndex ,  '#39'Repairs\Module\datRepairs.actmanufacture=118'#39' ' +
        'as ActionDetails union all  Select 136 as ImageIndex ,  '#39'Repairs' +
        '\Module\datRepairs.actManufactureList=136'#39' as ActionDetails unio' +
        'n all  Select 180 as ImageIndex ,  '#39'Repairs\Module\datRepairs.ac' +
        'tRepairStatusChoice=180'#39' as ActionDetails union all  Select 194 ' +
        'as ImageIndex ,  '#39'Repairs\Module\datRepairs.actEmpCalendar=194'#39' ' +
        'as ActionDetails union all  Select 0 as ImageIndex ,  '#39'Utilities' +
        '\InputForms\frmTasks.actVideo=0'#39' as ActionDetails union all  Sel' +
        'ect 174 as ImageIndex ,  '#39'Manufacturing\Module\datManufacturingA' +
        'ddin.actResource=174'#39' as ActionDetails union all  Select 332 as ' +
        'ImageIndex ,  '#39'Manufacturing\Module\datManufacturingAddin.actRes' +
        'ourceList=332'#39' as ActionDetails union all  Select 338 as ImageIn' +
        'dex ,  '#39'Manufacturing\Module\datManufacturingAddin.actResourceAv' +
        'ailability=338'#39' as ActionDetails union all  Select 117 as ImageI' +
        'ndex ,  '#39'Manufacturing\Module\datManufacturingAddin.actProcessSt' +
        'eps=117'#39' as ActionDetails union all  Select 52 as ImageIndex ,  ' +
        #39'Manufacturing\Module\datManufacturingAddin.actCapacityPlanning=' +
        '52'#39' as ActionDetails union all  Select 139 as ImageIndex ,  '#39'Man' +
        'ufacturing\Module\datManufacturingAddin.actProcessJobListing=139' +
        #39' as ActionDetails union all  Select 165 as ImageIndex ,  '#39'Manuf' +
        'acturing\Module\datManufacturingAddin.actManufacturingReports=16' +
        '5'#39' as ActionDetails union all  Select 159 as ImageIndex ,  '#39'Manu' +
        'facturing\Module\datManufacturingAddin.actProcPreferences=159'#39' a' +
        's ActionDetails union all  Select 96 as ImageIndex ,  '#39'Manufactu' +
        'ring\Module\datManufacturingAddin.actProductionPartsList=96'#39' as ' +
        'ActionDetails union all  Select 132 as ImageIndex ,  '#39'Manufactur' +
        'ing\Module\datManufacturingAddin.actOrdersFromStock=132'#39' as Acti' +
        'onDetails union all  Select 217 as ImageIndex ,  '#39'Manufacturing\' +
        'Module\datManufacturingAddin.actProductionOrders=217'#39' as ActionD' +
        'etails union all  Select 104 as ImageIndex ,  '#39'Manufacturing\Mod' +
        'ule\datManufacturingAddin.actProcJobListing=104'#39' as ActionDetail' +
        's union all  Select 142 as ImageIndex ,  '#39'Manufacturing\Module\d' +
        'atManufacturingAddin.actProcProductionPartsList=142'#39' as ActionDe' +
        'tails union all  Select 175 as ImageIndex ,  '#39'Manufacturing\Modu' +
        'le\datManufacturingAddin.actManufactureProductList=175'#39' as Actio' +
        'nDetails union all  Select 335 as ImageIndex ,  '#39'Manufacturing\M' +
        'odule\datManufacturingAddin.actBarCodeManufacturing=335'#39' as Acti' +
        'onDetails union all  Select 28 as ImageIndex ,  '#39'Manufacturing\M' +
        'odule\datManufacturingAddin.actProductionJobStatusDetails=28'#39' as' +
        ' ActionDetails union all  Select 183 as ImageIndex ,  '#39'Manufactu' +
        'ring\Module\datManufacturingAddin.actManufactureSubProductListGU' +
        'I=183'#39' as ActionDetails union all  Select 242 as ImageIndex ,  '#39 +
        'Manufacturing\Module\datManufacturingAddin.actWastagereport=242'#39 +
        ' as ActionDetails union all  Select 241 as ImageIndex ,  '#39'Manufa' +
        'cturing\Module\datManufacturingAddin.actOrderStatus=241'#39' as Acti' +
        'onDetails union all  Select 235 as ImageIndex ,  '#39'Manufacturing\' +
        'Module\datManufacturingAddin.actprocessstepList=235'#39' as ActionDe' +
        'tails union all  Select 225 as ImageIndex ,  '#39'Manufacturing\Modu' +
        'le\datManufacturingAddin.actBOMSalesList=225'#39' as ActionDetails u' +
        'nion all  Select 220 as ImageIndex ,  '#39'Manufacturing\Module\datM' +
        'anufacturingAddin.actProductionjobstatusdetailsList=220'#39' as Acti' +
        'onDetails union all  Select 240 as ImageIndex ,  '#39'Manufacturing\' +
        'Module\datManufacturingAddin.actCapacityPlanningonGanttchart=240' +
        #39' as ActionDetails union all  Select 343 as ImageIndex ,  '#39'Manuf' +
        'acturing\Module\datManufacturingAddin.actRosterWithManProcess=34' +
        '3'#39' as ActionDetails union all  Select 351 as ImageIndex ,  '#39'Manu' +
        'facturing\Module\datManufacturingAddin.actStowAwayList=351'#39' as A' +
        'ctionDetails union all  Select 16 as ImageIndex ,  '#39'Manufacturin' +
        'g\Module\datManufacturingAddin.actRosterBreakList=16'#39' as ActionD' +
        'etails union all  Select 229 as ImageIndex ,  '#39'Manufacturing\Mod' +
        'ule\datManufacturingAddin.actEmployeeJobStatus=229'#39' as ActionDet' +
        'ails union all  Select 352 as ImageIndex ,  '#39'Manufacturing\Modul' +
        'e\datManufacturingAddin.actUnallocatedBatchSalesList=352'#39' as Act' +
        'ionDetails union all  Select 349 as ImageIndex ,  '#39'Manufacturing' +
        '\Module\datManufacturingAddin.actBOMJobs=349'#39' as ActionDetails u' +
        'nion all  Select 0 as ImageIndex ,  '#39'Manufacturing\ListForms\BOM' +
        'OrderStatus.actSmartOrder=0'#39' as ActionDetails union all  Select ' +
        '0 as ImageIndex ,  '#39'GoogleAnalysis\ListForms\GoogleanalysisCost.' +
        'actMakeBill=0'#39' as ActionDetails union all  Select 0 as ImageInde' +
        'x ,  '#39'Manufacturing\ListForms\BomreportBase.actSmartOrder=0'#39' as ' +
        'ActionDetails union all  Select 0 as ImageIndex ,  '#39'Manufacturin' +
        'g\ListForms\BomreportBase.actUnGroup=0'#39' as ActionDetails union a' +
        'll  Select 0 as ImageIndex ,  '#39'Accounts\ListForms\PnLAreaEmploye' +
        'eReport.actGrpupReport=0'#39' as ActionDetails union all  Select 312' +
        ' as ImageIndex ,  '#39'DebugForms\Inputforms\frmviewimages.acttest=3' +
        '12'#39' as ActionDetails union all  Select 333 as ImageIndex ,  '#39'ERP' +
        '\Modules\datERP.actERPClientList=333'#39' as ActionDetails union all' +
        '  Select 334 as ImageIndex ,  '#39'ERP\Modules\datERP.actClientTreeL' +
        'ist=334'#39' as ActionDetails union all  Select 0 as ImageIndex ,  '#39 +
        'ERP\Modules\datERP.actMasterSMSConfig=0'#39' as ActionDetails union ' +
        'all  Select 0 as ImageIndex ,  '#39'ERP\Modules\datERP.actGetClientM' +
        'essageData=0'#39' as ActionDetails union all  Select 0 as ImageIndex' +
        ' ,  '#39'ERP\Modules\datERP.actClientServerLog=0'#39' as ActionDetails u' +
        'nion all  Select 0 as ImageIndex ,  '#39'ERP\Modules\datERP.actMessa' +
        'geCostList=0'#39' as ActionDetails union all  Select 0 as ImageIndex' +
        ' ,  '#39'ERP\Modules\datERP.actCreateSO=0'#39' as ActionDetails union al' +
        'l  Select 0 as ImageIndex ,  '#39'ERP\Modules\datERP.actERPOffices=0' +
        #39' as ActionDetails union all  Select 0 as ImageIndex ,  '#39'ERP\Mod' +
        'ules\datERP.actTraining_Videos=0'#39' as ActionDetails union all  Se' +
        'lect 0 as ImageIndex ,  '#39'BaseClasses\InputForms\Sales.actCreateJ' +
        'ob=0'#39' as ActionDetails union all  Select 0 as ImageIndex ,  '#39'Bas' +
        'eClasses\InputForms\Sales.actcheckdiscount=0'#39' as ActionDetails u' +
        'nion all  Select 0 as ImageIndex ,  '#39'BaseClasses\InputForms\Sale' +
        's.actManifestList=0'#39' as ActionDetails union all  Select 0 as Ima' +
        'geIndex ,  '#39'ExpenseClaim\InputForms\frmExpenseClaim.actPreview=0' +
        #39' as ActionDetails union all  Select 116 as ImageIndex ,  '#39'workF' +
        'low\Modules\datWorkflow.actStartRecording=116'#39' as ActionDetails ' +
        'union all  Select 97 as ImageIndex ,  '#39'workFlow\Modules\datWorkf' +
        'low.actStoprecording=97'#39' as ActionDetails union all  Select 90 a' +
        's ImageIndex ,  '#39'workFlow\Modules\datWorkflow.actCancelrecording' +
        '=90'#39' as ActionDetails union all  Select 64 as ImageIndex ,  '#39'wor' +
        'kFlow\Modules\datWorkflow.actWorkflows=64'#39' as ActionDetails unio' +
        'n all  Select 45 as ImageIndex ,  '#39'workFlow\Modules\datWorkflow.' +
        'actImportWorkflow=45'#39' as ActionDetails union all  Select 129 as ' +
        'ImageIndex ,  '#39'workFlow\Modules\datWorkflow.actExportAllWorkflow' +
        's=129'#39' as ActionDetails union all  Select 0 as ImageIndex ,  '#39'Pu' +
        'rchases\InputForms\frmSmartOrderFrm.actSelectRecord=0'#39' as Action' +
        'Details union all  Select 0 as ImageIndex ,  '#39'Purchases\InputFor' +
        'ms\frmSmartOrderFrm.actSummary=0'#39' as ActionDetails union all  Se' +
        'lect 361 as ImageIndex ,  '#39'General\Module\dmMainGUI.actStockTran' +
        'sferEntryBin=361'#39' as ActionDetails union all  Select 428 as Imag' +
        'eIndex ,  '#39'General\Module\dmMainGUI.actStockTransferEntryListBin' +
        '=428'#39' as ActionDetails union all  Select 319 as ImageIndex ,  '#39'G' +
        'eneral\Module\dmMainGUI.actStockTransferEntrySN=319'#39' as ActionDe' +
        'tails union all  Select 312 as ImageIndex ,  '#39'General\Module\dmM' +
        'ainGUI.actStockTransferEntryListSN=312'#39' as ActionDetails union a' +
        'll  Select 281 as ImageIndex ,  '#39'General\Module\dmMainGUI.actRep' +
        'ortsPOS=281'#39' as ActionDetails union all  Select 401 as ImageInde' +
        'x ,  '#39'General\Module\dmMainGUI.actStockTransferEntryBatch=401'#39' a' +
        's ActionDetails union all  Select 418 as ImageIndex ,  '#39'General\' +
        'Module\dmMainGUI.actStockTransferEntryListBAtch=418'#39' as ActionDe' +
        'tails union all  Select 594 as ImageIndex ,  '#39'General\Module\dmM' +
        'ainGUI.actInventStockStockAdjustmentbatch=594'#39' as ActionDetails ' +
        'union all  Select 280 as ImageIndex ,  '#39'General\Module\dmMainGUI' +
        '.actInventStockStockAdjustmentList=280'#39' as ActionDetails union a' +
        'll  Select 296 as ImageIndex ,  '#39'General\Module\dmMainGUI.actInv' +
        'entStockStockAdjustment=296'#39' as ActionDetails union all  Select ' +
        '246 as ImageIndex ,  '#39'General\Module\dmMainGUI.actStockAdjustEnt' +
        'ryflat=246'#39' as ActionDetails union all  Select 571 as ImageIndex' +
        ' ,  '#39'General\Module\dmMainGUI.actInventStockStockAdjustmentsnLsi' +
        't=571'#39' as ActionDetails union all  Select 224 as ImageIndex ,  '#39 +
        'General\Module\dmMainGUI.actInventStockStockTake=224'#39' as ActionD' +
        'etails union all  Select 264 as ImageIndex ,  '#39'General\Module\dm' +
        'MainGUI.actStockTakeList=264'#39' as ActionDetails union all  Select' +
        ' 568 as ImageIndex ,  '#39'General\Module\dmMainGUI.actStockTransfer' +
        'EntryTree=568'#39' as ActionDetails union all  Select 633 as ImageIn' +
        'dex ,  '#39'General\Module\dmMainGUI.actInventStockStockAdjustmentbi' +
        'nList=633'#39' as ActionDetails union all  Select 346 as ImageIndex ' +
        ',  '#39'General\Module\dmMainGUI.actCashFlowStatement=346'#39' as Action' +
        'Details union all  Select 281 as ImageIndex ,  '#39'General\Module\d' +
        'mMainGUI.actReportsUtilities=281'#39' as ActionDetails union all  Se' +
        'lect 292 as ImageIndex ,  '#39'General\Module\dmMainGUI.actUtilsEmai' +
        'ledReport=292'#39' as ActionDetails union all  Select 74 as ImageInd' +
        'ex ,  '#39'General\Module\dmMainGUI.SOBOList=74'#39' as ActionDetails un' +
        'ion all  Select 546 as ImageIndex ,  '#39'General\Module\dmMainGUI.a' +
        'ctInventStockStockTransfer=546'#39' as ActionDetails union all  Sele' +
        'ct 84 as ImageIndex ,  '#39'General\Module\dmMainGUI.SOBOListExpress' +
        '=84'#39' as ActionDetails union all  Select 429 as ImageIndex ,  '#39'Ge' +
        'neral\Module\dmMainGUI.actScheduledReports=429'#39' as ActionDetails' +
        ' union all  Select 140 as ImageIndex ,  '#39'General\Module\dmMainGU' +
        'I.actProfitandLossPeriodCompare=140'#39' as ActionDetails union all ' +
        ' Select 73 as ImageIndex ,  '#39'General\Module\dmMainGUI.INVBOList=' +
        '73'#39' as ActionDetails union all  Select 47 as ImageIndex ,  '#39'Gene' +
        'ral\Module\dmMainGUI.INVBOListExpress=47'#39' as ActionDetails union' +
        ' all  Select 125 as ImageIndex ,  '#39'General\Module\dmMainGUI.actF' +
        'ileNewCompany=125'#39' as ActionDetails union all  Select 281 as Ima' +
        'geIndex ,  '#39'General\Module\dmMainGUI.actReportsEmployee=281'#39' as ' +
        'ActionDetails union all  Select 143 as ImageIndex ,  '#39'General\Mo' +
        'dule\dmMainGUI.actFileOpenCompany=143'#39' as ActionDetails union al' +
        'l  Select 234 as ImageIndex ,  '#39'General\Module\dmMainGUI.actFile' +
        'ImportData=234'#39' as ActionDetails union all  Select 357 as ImageI' +
        'ndex ,  '#39'General\Module\dmMainGUI.actInventProductsProductCommis' +
        'sion=357'#39' as ActionDetails union all  Select 83 as ImageIndex , ' +
        ' '#39'General\Module\dmMainGUI.actFileImportTemplates=83'#39' as ActionD' +
        'etails union all  Select 214 as ImageIndex ,  '#39'General\Module\dm' +
        'MainGUI.actFileImportTNTClientRates=214'#39' as ActionDetails union ' +
        'all  Select 27 as ImageIndex ,  '#39'General\Module\dmMainGUI.actFil' +
        'eImportTNTPostcodeToRating=27'#39' as ActionDetails union all  Selec' +
        't 114 as ImageIndex ,  '#39'General\Module\dmMainGUI.actAccountsTerm' +
        's=114'#39' as ActionDetails union all  Select 156 as ImageIndex ,  '#39 +
        'General\Module\dmMainGUI.actFileExportData=156'#39' as ActionDetails' +
        ' union all  Select 153 as ImageIndex ,  '#39'General\Module\dmMainGU' +
        'I.actFileExportTemplates=153'#39' as ActionDetails union all  Select' +
        ' 192 as ImageIndex ,  '#39'General\Module\dmMainGUI.actCustomerProfi' +
        'tability=192'#39' as ActionDetails union all  Select 21 as ImageInde' +
        'x ,  '#39'General\Module\dmMainGUI.actApptMainCalendar=21'#39' as Action' +
        'Details union all  Select 177 as ImageIndex ,  '#39'General\Module\d' +
        'mMainGUI.actApptsPrintAppointments=177'#39' as ActionDetails union a' +
        'll  Select 8 as ImageIndex ,  '#39'General\Module\dmMainGUI.actAppts' +
        'NewAppointment=8'#39' as ActionDetails union all  Select 71 as Image' +
        'Index ,  '#39'General\Module\dmMainGUI.actIncomeandExpenditurereport' +
        '=71'#39' as ActionDetails union all  Select 9 as ImageIndex ,  '#39'Gene' +
        'ral\Module\dmMainGUI.actApptsAppointmentsList=9'#39' as ActionDetail' +
        's union all  Select 26 as ImageIndex ,  '#39'General\Module\dmMainGU' +
        'I.actApptsNewSource=26'#39' as ActionDetails union all  Select 95 as' +
        ' ImageIndex ,  '#39'General\Module\dmMainGUI.actApptsSourceList=95'#39' ' +
        'as ActionDetails union all  Select 196 as ImageIndex ,  '#39'General' +
        '\Module\dmMainGUI.actApptsNewJob=196'#39' as ActionDetails union all' +
        '  Select 200 as ImageIndex ,  '#39'General\Module\dmMainGUI.actAppts' +
        'JobList=200'#39' as ActionDetails union all  Select 59 as ImageIndex' +
        ' ,  '#39'General\Module\dmMainGUI.actApptsPhoneSupport=59'#39' as Action' +
        'Details union all  Select 67 as ImageIndex ,  '#39'General\Module\dm' +
        'MainGUI.actInventProductsProductsList=67'#39' as ActionDetails union' +
        ' all  Select 69 as ImageIndex ,  '#39'General\Module\dmMainGUI.actIn' +
        'ventProductPictureProductsList=69'#39' as ActionDetails union all  S' +
        'elect 281 as ImageIndex ,  '#39'General\Module\dmMainGUI.actReportsG' +
        'eneral=281'#39' as ActionDetails union all  Select 41 as ImageIndex ' +
        ',  '#39'General\Module\dmMainGUI.actApptsFeedbackReport=41'#39' as Actio' +
        'nDetails union all  Select 237 as ImageIndex ,  '#39'General\Module\' +
        'dmMainGUI.actApptsAppointmentsReport=237'#39' as ActionDetails union' +
        ' all  Select 135 as ImageIndex ,  '#39'General\Module\dmMainGUI.actA' +
        'pptsPhoneSupportLogList=135'#39' as ActionDetails union all  Select ' +
        '285 as ImageIndex ,  '#39'General\Module\dmMainGUI.actBarcodeAction=' +
        '285'#39' as ActionDetails union all  Select 191 as ImageIndex ,  '#39'Ge' +
        'neral\Module\dmMainGUI.actApptsCustomersOnSupportList=191'#39' as Ac' +
        'tionDetails union all  Select 189 as ImageIndex ,  '#39'General\Modu' +
        'le\dmMainGUI.actSalesCustomersNewCustomer=189'#39' as ActionDetails ' +
        'union all  Select 29 as ImageIndex ,  '#39'General\Module\dmMainGUI.' +
        'actSalesCustomersCustomerList=29'#39' as ActionDetails union all  Se' +
        'lect 402 as ImageIndex ,  '#39'General\Module\dmMainGUI.actProfitand' +
        'LossByPeriod=402'#39' as ActionDetails union all  Select 303 as Imag' +
        'eIndex ,  '#39'General\Module\dmMainGUI.actSalesCustomersCustomerAcc' +
        'ountNoSetup=303'#39' as ActionDetails union all  Select 22 as ImageI' +
        'ndex ,  '#39'General\Module\dmMainGUI.actSalesCustomersClientType=22' +
        #39' as ActionDetails union all  Select 23 as ImageIndex ,  '#39'Genera' +
        'l\Module\dmMainGUI.actSalesCustomersClientTypeList=23'#39' as Action' +
        'Details union all  Select 376 as ImageIndex ,  '#39'General\Module\d' +
        'mMainGUI.actSalesCustomersCustomerSummary=376'#39' as ActionDetails ' +
        'union all  Select 186 as ImageIndex ,  '#39'General\Module\dmMainGUI' +
        '.actSalesCustomersCustomerDetailsList=186'#39' as ActionDetails unio' +
        'n all  Select 53 as ImageIndex ,  '#39'General\Module\dmMainGUI.actS' +
        'alesCRMOtherContacts=53'#39' as ActionDetails union all  Select 54 a' +
        's ImageIndex ,  '#39'General\Module\dmMainGUI.actSalesCRMOtherContac' +
        'tsList=54'#39' as ActionDetails union all  Select 340 as ImageIndex ' +
        ',  '#39'General\Module\dmMainGUI.actSalesCRMPhoneContact=340'#39' as Act' +
        'ionDetails union all  Select 339 as ImageIndex ,  '#39'General\Modul' +
        'e\dmMainGUI.actSalesCRMPhoneContactList=339'#39' as ActionDetails un' +
        'ion all  Select 372 as ImageIndex ,  '#39'General\Module\dmMainGUI.a' +
        'ctSalesCRMCanvasser=372'#39' as ActionDetails union all  Select 375 ' +
        'as ImageIndex ,  '#39'General\Module\dmMainGUI.actSalesCRMCanvasserL' +
        'ist=375'#39' as ActionDetails union all  Select 164 as ImageIndex , ' +
        ' '#39'General\Module\dmMainGUI.actSalesCRMLoyaltyProgram=164'#39' as Act' +
        'ionDetails union all  Select 51 as ImageIndex ,  '#39'General\Module' +
        '\dmMainGUI.actSalesCRMMailMerge=51'#39' as ActionDetails union all  ' +
        'Select 193 as ImageIndex ,  '#39'General\Module\dmMainGUI.actSalesJo' +
        'bsJobAnalysisBalanceReport=193'#39' as ActionDetails union all  Sele' +
        'ct 501 as ImageIndex ,  '#39'General\Module\dmMainGUI.actSalesJobsJo' +
        'bProfitability=501'#39' as ActionDetails union all  Select 392 as Im' +
        'ageIndex ,  '#39'General\Module\dmMainGUI.actSalesQuotesQuote=392'#39' a' +
        's ActionDetails union all  Select 78 as ImageIndex ,  '#39'General\M' +
        'odule\dmMainGUI.actSalesQuotesQuoteList=78'#39' as ActionDetails uni' +
        'on all  Select 394 as ImageIndex ,  '#39'General\Module\dmMainGUI.ac' +
        'tSalesQuotesQuoteExpressList=394'#39' as ActionDetails union all  Se' +
        'lect 226 as ImageIndex ,  '#39'General\Module\dmMainGUI.actSalesSale' +
        'sOrdersSalesOrder=226'#39' as ActionDetails union all  Select 263 as' +
        ' ImageIndex ,  '#39'General\Module\dmMainGUI.actSalesPOSPOSScreen=26' +
        '3'#39' as ActionDetails union all  Select 406 as ImageIndex ,  '#39'Gene' +
        'ral\Module\dmMainGUI.actSalesSalesOrdersSalesOrderList=406'#39' as A' +
        'ctionDetails union all  Select 85 as ImageIndex ,  '#39'General\Modu' +
        'le\dmMainGUI.actSalesSalesOrdersSalesOrderExpressList=85'#39' as Act' +
        'ionDetails union all  Select 233 as ImageIndex ,  '#39'General\Modul' +
        'e\dmMainGUI.actSalesSalesOrdersSalesOrderReport=233'#39' as ActionDe' +
        'tails union all  Select 130 as ImageIndex ,  '#39'General\Module\dmM' +
        'ainGUI.actSalesSalesCashSale=130'#39' as ActionDetails union all  Se' +
        'lect 77 as ImageIndex ,  '#39'General\Module\dmMainGUI.actSalesSales' +
        'Refunds=77'#39' as ActionDetails union all  Select 150 as ImageIndex' +
        ' ,  '#39'General\Module\dmMainGUI.actSalesSalesInvoice=150'#39' as Actio' +
        'nDetails union all  Select 178 as ImageIndex ,  '#39'General\Module\' +
        'dmMainGUI.actSalesSalesInvoiceList=178'#39' as ActionDetails union a' +
        'll  Select 151 as ImageIndex ,  '#39'General\Module\dmMainGUI.actSal' +
        'esSalesInvoiceExpressList=151'#39' as ActionDetails union all  Selec' +
        't 152 as ImageIndex ,  '#39'General\Module\dmMainGUI.actCustomerRetu' +
        'rnList=152'#39' as ActionDetails union all  Select 398 as ImageIndex' +
        ' ,  '#39'General\Module\dmMainGUI.actCustomerReturns=398'#39' as ActionD' +
        'etails union all  Select 250 as ImageIndex ,  '#39'General\Module\dm' +
        'MainGUI.actSalesSalesBackOrders=250'#39' as ActionDetails union all ' +
        ' Select 113 as ImageIndex ,  '#39'General\Module\dmMainGUI.actSalesS' +
        'alesSalesList=113'#39' as ActionDetails union all  Select 432 as Ima' +
        'geIndex ,  '#39'General\Module\dmMainGUI.actSalesPOSCustomisePOS=432' +
        #39' as ActionDetails union all  Select 106 as ImageIndex ,  '#39'Gener' +
        'al\Module\dmMainGUI.actSalesPOSBarTabList=106'#39' as ActionDetails ' +
        'union all  Select 255 as ImageIndex ,  '#39'General\Module\dmMainGUI' +
        '.actSalesPOSVouchersList=255'#39' as ActionDetails union all  Select' +
        ' 160 as ImageIndex ,  '#39'General\Module\dmMainGUI.actSalesPOSTillS' +
        'ummaryReport=160'#39' as ActionDetails union all  Select 245 as Imag' +
        'eIndex ,  '#39'General\Module\dmMainGUI.actSalesPOSTrafficList=245'#39' ' +
        'as ActionDetails union all  Select 188 as ImageIndex ,  '#39'General' +
        '\Module\dmMainGUI.actSalesPOSTrafficSummaryReport=188'#39' as Action' +
        'Details union all  Select 232 as ImageIndex ,  '#39'General\Module\d' +
        'mMainGUI.actSalesPOSOrderProcessList=232'#39' as ActionDetails union' +
        ' all  Select 427 as ImageIndex ,  '#39'General\Module\dmMainGUI.actS' +
        'alesManifestManifestAllocationList=427'#39' as ActionDetails union a' +
        'll  Select 184 as ImageIndex ,  '#39'General\Module\dmMainGUI.actSal' +
        'esManifestManifest=184'#39' as ActionDetails union all  Select 185 a' +
        's ImageIndex ,  '#39'General\Module\dmMainGUI.actSalesManifestManife' +
        'stList=185'#39' as ActionDetails union all  Select 216 as ImageIndex' +
        ' ,  '#39'General\Module\dmMainGUI.actSalesManifestManifestVehicle=21' +
        '6'#39' as ActionDetails union all  Select 218 as ImageIndex ,  '#39'Gene' +
        'ral\Module\dmMainGUI.actSalesManifestManifestVehicleList=218'#39' as' +
        ' ActionDetails union all  Select 187 as ImageIndex ,  '#39'General\M' +
        'odule\dmMainGUI.actSalesManifestManifestRoute=187'#39' as ActionDeta' +
        'ils union all  Select 219 as ImageIndex ,  '#39'General\Module\dmMai' +
        'nGUI.actSalesManifestManifestRouteList=219'#39' as ActionDetails uni' +
        'on all  Select 190 as ImageIndex ,  '#39'General\Module\dmMainGUI.ac' +
        'tSalesPrintInvoices=190'#39' as ActionDetails union all  Select 503 ' +
        'as ImageIndex ,  '#39'General\Module\dmMainGUI.actSalesPrintSalesOrd' +
        'ers=503'#39' as ActionDetails union all  Select 100 as ImageIndex , ' +
        ' '#39'General\Module\dmMainGUI.actPurchasesSuppliersSupplier=100'#39' as' +
        ' ActionDetails union all  Select 91 as ImageIndex ,  '#39'General\Mo' +
        'dule\dmMainGUI.actPurchasesSuppliersSupplierList=91'#39' as ActionDe' +
        'tails union all  Select 101 as ImageIndex ,  '#39'General\Module\dmM' +
        'ainGUI.actPurchasesSuppliersSupplierExpressList=101'#39' as ActionDe' +
        'tails union all  Select 92 as ImageIndex ,  '#39'General\Module\dmMa' +
        'inGUI.actPurchasesSmartOrdersSmartOrder=92'#39' as ActionDetails uni' +
        'on all  Select 93 as ImageIndex ,  '#39'General\Module\dmMainGUI.act' +
        'PurchasesSmartOrdersSmartOrderList=93'#39' as ActionDetails union al' +
        'l  Select 290 as ImageIndex ,  '#39'General\Module\dmMainGUI.actPurc' +
        'hasesPurchaseOrdersPurchaseOrder=290'#39' as ActionDetails union all' +
        '  Select 481 as ImageIndex ,  '#39'General\Module\dmMainGUI.actPurch' +
        'asesPurchaseOrdersPurchaseOrderList=481'#39' as ActionDetails union ' +
        'all  Select 60 as ImageIndex ,  '#39'General\Module\dmMainGUI.actPur' +
        'chasesPurchaseOrdersPurchaseOrderExpressList=60'#39' as ActionDetail' +
        's union all  Select 279 as ImageIndex ,  '#39'General\Module\dmMainG' +
        'UI.actPurchasesPurchaseOrdersBackOrders=279'#39' as ActionDetails un' +
        'ion all  Select 19 as ImageIndex ,  '#39'General\Module\dmMainGUI.ac' +
        'tPurchasesBillsBill=19'#39' as ActionDetails union all  Select 284 a' +
        's ImageIndex ,  '#39'General\Module\dmMainGUI.actPurchasesBillsBillR' +
        'efund=284'#39' as ActionDetails union all  Select 370 as ImageIndex ' +
        ',  '#39'General\Module\dmMainGUI.actPurchasesBillsBillList=370'#39' as A' +
        'ctionDetails union all  Select 371 as ImageIndex ,  '#39'General\Mod' +
        'ule\dmMainGUI.actPurchasesBillsBillDetailsList=371'#39' as ActionDet' +
        'ails union all  Select 396 as ImageIndex ,  '#39'General\Module\dmMa' +
        'inGUI.actPurchasesReturnAuthorityReturnAuthority=396'#39' as ActionD' +
        'etails union all  Select 397 as ImageIndex ,  '#39'General\Module\dm' +
        'MainGUI.actPurchasesReturnAuthorityReturnAuthorityList=397'#39' as A' +
        'ctionDetails union all  Select 247 as ImageIndex ,  '#39'General\Mod' +
        'ule\dmMainGUI.actbinLocation=247'#39' as ActionDetails union all  Se' +
        'lect 243 as ImageIndex ,  '#39'General\Module\dmMainGUI.actBinLocati' +
        'onList=243'#39' as ActionDetails union all  Select 66 as ImageIndex ' +
        ',  '#39'General\Module\dmMainGUI.actInventProductsProduct=66'#39' as Act' +
        'ionDetails union all  Select 272 as ImageIndex ,  '#39'General\Modul' +
        'e\dmMainGUI.actInventProductsProductsExpressList=272'#39' as ActionD' +
        'etails union all  Select 273 as ImageIndex ,  '#39'General\Module\dm' +
        'MainGUI.actInventProductsProductsExpressBatchbinSNList=273'#39' as A' +
        'ctionDetails union all  Select 252 as ImageIndex ,  '#39'General\Mod' +
        'ule\dmMainGUI.actInventProductsProductCommissionList=252'#39' as Act' +
        'ionDetails union all  Select 559 as ImageIndex ,  '#39'General\Modul' +
        'e\dmMainGUI.actInventProductsProductRewardPoints=559'#39' as ActionD' +
        'etails union all  Select 374 as ImageIndex ,  '#39'General\Module\dm' +
        'MainGUI.actInventProductsProductRewardPointsList=374'#39' as ActionD' +
        'etails union all  Select 253 as ImageIndex ,  '#39'General\Module\dm' +
        'MainGUI.actInventProductsBatchProductCreator=253'#39' as ActionDetai' +
        'ls union all  Select 228 as ImageIndex ,  '#39'General\Module\dmMain' +
        'GUI.actInventProductsBatchProductCodeAbbreviator=228'#39' as ActionD' +
        'etails union all  Select 565 as ImageIndex ,  '#39'General\Module\dm' +
        'MainGUI.actInventStockStockTransferList=565'#39' as ActionDetails un' +
        'ion all  Select 589 as ImageIndex ,  '#39'General\Module\dmMainGUI.a' +
        'ctInventStockStockAdjustmentbin=589'#39' as ActionDetails union all ' +
        ' Select 573 as ImageIndex ,  '#39'General\Module\dmMainGUI.actInvent' +
        'StockStockAdjustmentsn=573'#39' as ActionDetails union all  Select 6' +
        '30 as ImageIndex ,  '#39'General\Module\dmMainGUI.actInventStockStoc' +
        'kAdjustmentbatchList=630'#39' as ActionDetails union all  Select 547' +
        ' as ImageIndex ,  '#39'General\Module\dmMainGUI.actInventPriceUpdate' +
        '=547'#39' as ActionDetails union all  Select 548 as ImageIndex ,  '#39'G' +
        'eneral\Module\dmMainGUI.actoldInventPriceUpdate=548'#39' as ActionDe' +
        'tails union all  Select 356 as ImageIndex ,  '#39'General\Module\dmM' +
        'ainGUI.actInventAutoReOrder=356'#39' as ActionDetails union all  Sel' +
        'ect 221 as ImageIndex ,  '#39'General\Module\dmMainGUI.actInventCust' +
        'omerTypePriceList=221'#39' as ActionDetails union all  Select 65 as ' +
        'ImageIndex ,  '#39'General\Module\dmMainGUI.actInventPrintPickSlips=' +
        '65'#39' as ActionDetails union all  Select 134 as ImageIndex ,  '#39'Gen' +
        'eral\Module\dmMainGUI.actInventBarcodePickingAssembly=134'#39' as Ac' +
        'tionDetails union all  Select 133 as ImageIndex ,  '#39'General\Modu' +
        'le\dmMainGUI.actInventBarcodePickingAssemblyList=133'#39' as ActionD' +
        'etails union all  Select 478 as ImageIndex ,  '#39'General\Module\dm' +
        'MainGUI.actInventPickedSalesList=478'#39' as ActionDetails union all' +
        '  Select 480 as ImageIndex ,  '#39'General\Module\dmMainGUI.actInven' +
        'tPickSlipManifest=480'#39' as ActionDetails union all  Select 270 as' +
        ' ImageIndex ,  '#39'General\Module\dmMainGUI.actInventProductSales=2' +
        '70'#39' as ActionDetails union all  Select 562 as ImageIndex ,  '#39'Gen' +
        'eral\Module\dmMainGUI.actInventProductSalesnotSold=562'#39' as Actio' +
        'nDetails union all  Select 211 as ImageIndex ,  '#39'General\Module\' +
        'dmMainGUI.actInventUnitsOfMeasure=211'#39' as ActionDetails union al' +
        'l  Select 182 as ImageIndex ,  '#39'General\Module\dmMainGUI.actInve' +
        'ntUnitsOfMeasureList=182'#39' as ActionDetails union all  Select 30 ' +
        'as ImageIndex ,  '#39'General\Module\dmMainGUI.actPaymentsCustomerPa' +
        'yment=30'#39' as ActionDetails union all  Select 31 as ImageIndex , ' +
        ' '#39'General\Module\dmMainGUI.actPaymentsCustomerPaymentList=31'#39' as' +
        ' ActionDetails union all  Select 172 as ImageIndex ,  '#39'General\M' +
        'odule\dmMainGUI.actPaymentsCustomerPrepayment=172'#39' as ActionDeta' +
        'ils union all  Select 173 as ImageIndex ,  '#39'General\Module\dmMai' +
        'nGUI.actPaymentsCustomerPrepaymentList=173'#39' as ActionDetails uni' +
        'on all  Select 534 as ImageIndex ,  '#39'General\Module\dmMainGUI.ac' +
        'tPaymentsBulkPaySuppliers=534'#39' as ActionDetails union all  Selec' +
        't 231 as ImageIndex ,  '#39'General\Module\dmMainGUI.actPaymentsRece' +
        'ivedBulkPayments=231'#39' as ActionDetails union all  Select 102 as ' +
        'ImageIndex ,  '#39'General\Module\dmMainGUI.actPaymentsSupplierPayme' +
        'nt=102'#39' as ActionDetails union all  Select 103 as ImageIndex ,  ' +
        #39'General\Module\dmMainGUI.actPaymentsSupplierPaymentList=103'#39' as' +
        ' ActionDetails union all  Select 167 as ImageIndex ,  '#39'General\M' +
        'odule\dmMainGUI.actPaymentsSupplierPrepayment=167'#39' as ActionDeta' +
        'ils union all  Select 181 as ImageIndex ,  '#39'General\Module\dmMai' +
        'nGUI.actPaymentsSuppPrepaymentList=181'#39' as ActionDetails union a' +
        'll  Select 24 as ImageIndex ,  '#39'General\Module\dmMainGUI.actPaym' +
        'entsDepositEntry=24'#39' as ActionDetails union all  Select 76 as Im' +
        'ageIndex ,  '#39'General\Module\dmMainGUI.actPaymentsToBeDeposited=7' +
        '6'#39' as ActionDetails union all  Select 276 as ImageIndex ,  '#39'Gene' +
        'ral\Module\dmMainGUI.actPaymentsDepositedList=276'#39' as ActionDeta' +
        'ils union all  Select 25 as ImageIndex ,  '#39'General\Module\dmMain' +
        'GUI.actPaymentsCheque=25'#39' as ActionDetails union all  Select 170' +
        ' as ImageIndex ,  '#39'General\Module\dmMainGUI.actPaymentsChequeLis' +
        't=170'#39' as ActionDetails union all  Select 488 as ImageIndex ,  '#39 +
        'General\Module\dmMainGUI.actPaymentsChequeDetailsList=488'#39' as Ac' +
        'tionDetails union all  Select 75 as ImageIndex ,  '#39'General\Modul' +
        'e\dmMainGUI.actPaymentsReconcile=75'#39' as ActionDetails union all ' +
        ' Select 494 as ImageIndex ,  '#39'General\Module\dmMainGUI.actPaymen' +
        'tsReconciliationList=494'#39' as ActionDetails union all  Select 261' +
        ' as ImageIndex ,  '#39'General\Module\dmMainGUI.actPaymentsStatement' +
        's=261'#39' as ActionDetails union all  Select 147 as ImageIndex ,  '#39 +
        'General\Module\dmMainGUI.actPaymentsPrintStatements=147'#39' as Acti' +
        'onDetails union all  Select 3 as ImageIndex ,  '#39'General\Module\d' +
        'mMainGUI.actPaymentsAccountsPayableReport=3'#39' as ActionDetails un' +
        'ion all  Select 4 as ImageIndex ,  '#39'General\Module\dmMainGUI.act' +
        'PaymentsAccountsReceivableReport=4'#39' as ActionDetails union all  ' +
        'Select 278 as ImageIndex ,  '#39'General\Module\dmMainGUI.actPayment' +
        'sBankAccountReport=278'#39' as ActionDetails union all  Select 329 a' +
        's ImageIndex ,  '#39'General\Module\dmMainGUI.actPaymentsTransaction' +
        'Journal=329'#39' as ActionDetails union all  Select 58 as ImageIndex' +
        ' ,  '#39'General\Module\dmMainGUI.actEmployeePayrollPayStaff=58'#39' as ' +
        'ActionDetails union all  Select 55 as ImageIndex ,  '#39'General\Mod' +
        'ule\dmMainGUI.actEmployeePayrollPayHistory=55'#39' as ActionDetails ' +
        'union all  Select 56 as ImageIndex ,  '#39'General\Module\dmMainGUI.' +
        'actEmployeePayslist=56'#39' as ActionDetails union all  Select 354 a' +
        's ImageIndex ,  '#39'General\Module\dmMainGUI.actEmployeePayrollNewA' +
        'llowance=354'#39' as ActionDetails union all  Select 6 as ImageIndex' +
        ' ,  '#39'General\Module\dmMainGUI.actEmployeePayrollAllowances=6'#39' as' +
        ' ActionDetails union all  Select 11 as ImageIndex ,  '#39'General\Mo' +
        'dule\dmMainGUI.actEmployeePayrollNewAward=11'#39' as ActionDetails u' +
        'nion all  Select 360 as ImageIndex ,  '#39'General\Module\dmMainGUI.' +
        'actEmployeePayrollAwards=360'#39' as ActionDetails union all  Select' +
        ' 362 as ImageIndex ,  '#39'General\Module\dmMainGUI.actEmployeePayro' +
        'llNewBankCode=362'#39' as ActionDetails union all  Select 13 as Imag' +
        'eIndex ,  '#39'General\Module\dmMainGUI.actEmployeePayrollBankCodes=' +
        '13'#39' as ActionDetails union all  Select 33 as ImageIndex ,  '#39'Gene' +
        'ral\Module\dmMainGUI.actEmployeePayrollNewDeduction=33'#39' as Actio' +
        'nDetails union all  Select 34 as ImageIndex ,  '#39'General\Module\d' +
        'mMainGUI.actEmployeePayrollDeductions=34'#39' as ActionDetails union' +
        ' all  Select 163 as ImageIndex ,  '#39'General\Module\dmMainGUI.actE' +
        'mployeePayrollNewPayRate=163'#39' as ActionDetails union all  Select' +
        ' 535 as ImageIndex ,  '#39'General\Module\dmMainGUI.actEmployeePayro' +
        'llPayRates=535'#39' as ActionDetails union all  Select 46 as ImageIn' +
        'dex ,  '#39'General\Module\dmMainGUI.actEmployeePayrollNewTaxScale=4' +
        '6'#39' as ActionDetails union all  Select 306 as ImageIndex ,  '#39'Gene' +
        'ral\Module\dmMainGUI.actEmployeePayrollTaxScales=306'#39' as ActionD' +
        'etails union all  Select 251 as ImageIndex ,  '#39'General\Module\dm' +
        'MainGUI.actEmployeePayrollImportTaxScales=251'#39' as ActionDetails ' +
        'union all  Select 108 as ImageIndex ,  '#39'General\Module\dmMainGUI' +
        '.actEmployeePayrollLeaveAccruedList=108'#39' as ActionDetails union ' +
        'all  Select 161 as ImageIndex ,  '#39'General\Module\dmMainGUI.actEm' +
        'ployeePayrollLeaveTakenList=161'#39' as ActionDetails union all  Sel' +
        'ect 207 as ImageIndex ,  '#39'General\Module\dmMainGUI.actEmployeePa' +
        'yrollPayrollJobsList=207'#39' as ActionDetails union all  Select 265' +
        ' as ImageIndex ,  '#39'General\Module\dmMainGUI.actEmployeePayrollEm' +
        'ployeeServices=265'#39' as ActionDetails union all  Select 368 as Im' +
        'ageIndex ,  '#39'General\Module\dmMainGUI.actEmployeePayrollPAYGSumm' +
        'ary=368'#39' as ActionDetails union all  Select 404 as ImageIndex , ' +
        ' '#39'General\Module\dmMainGUI.actEmployeeRep=404'#39' as ActionDetails ' +
        'union all  Select 81 as ImageIndex ,  '#39'General\Module\dmMainGUI.' +
        'actEmployeeRepList=81'#39' as ActionDetails union all  Select 111 as' +
        ' ImageIndex ,  '#39'General\Module\dmMainGUI.actEmployeeToDo=111'#39' as' +
        ' ActionDetails union all  Select 38 as ImageIndex ,  '#39'General\Mo' +
        'dule\dmMainGUI.actEmployeeEmployee=38'#39' as ActionDetails union al' +
        'l  Select 405 as ImageIndex ,  '#39'General\Module\dmMainGUI.actEmpl' +
        'oyeeEmployeeAnalysis=405'#39' as ActionDetails union all  Select 39 ' +
        'as ImageIndex ,  '#39'General\Module\dmMainGUI.actEmployeeEmployeeLi' +
        'st=39'#39' as ActionDetails union all  Select 107 as ImageIndex ,  '#39 +
        'General\Module\dmMainGUI.actEmployeeTerminateEmployee=107'#39' as Ac' +
        'tionDetails union all  Select 42 as ImageIndex ,  '#39'General\Modul' +
        'e\dmMainGUI.actEmployeeGlobalList=42'#39' as ActionDetails union all' +
        '  Select 82 as ImageIndex ,  '#39'General\Module\dmMainGUI.actEmploy' +
        'eeRepServices=82'#39' as ActionDetails union all  Select 482 as Imag' +
        'eIndex ,  '#39'General\Module\dmMainGUI.actEmployeeRoster=482'#39' as Ac' +
        'tionDetails union all  Select 239 as ImageIndex ,  '#39'General\Modu' +
        'le\dmMainGUI.actEmployeeRosterList=239'#39' as ActionDetails union a' +
        'll  Select 155 as ImageIndex ,  '#39'General\Module\dmMainGUI.actEmp' +
        'loyeeClockOn=155'#39' as ActionDetails union all  Select 208 as Imag' +
        'eIndex ,  '#39'General\Module\dmMainGUI.actEmployeeResetPersonalTabs' +
        '=208'#39' as ActionDetails union all  Select 124 as ImageIndex ,  '#39'G' +
        'eneral\Module\dmMainGUI.actFixedAssetsFixedAsset=124'#39' as ActionD' +
        'etails union all  Select 48 as ImageIndex ,  '#39'General\Module\dmM' +
        'ainGUI.actFixedAssetsFixedAssetsList=48'#39' as ActionDetails union ' +
        'all  Select 126 as ImageIndex ,  '#39'General\Module\dmMainGUI.actFi' +
        'xedAssetsFixedAssetType=126'#39' as ActionDetails union all  Select ' +
        '127 as ImageIndex ,  '#39'General\Module\dmMainGUI.actFixedAssetsFix' +
        'edAssetTypesList=127'#39' as ActionDetails union all  Select 128 as ' +
        'ImageIndex ,  '#39'General\Module\dmMainGUI.actFixedAssetsCheckWarra' +
        'ntiesInsurancePolicy=128'#39' as ActionDetails union all  Select 123' +
        ' as ImageIndex ,  '#39'General\Module\dmMainGUI.actFixedAssetsServic' +
        'eLog=123'#39' as ActionDetails union all  Select 120 as ImageIndex ,' +
        '  '#39'General\Module\dmMainGUI.actFixedAssetsServiceLogList=120'#39' as' +
        ' ActionDetails union all  Select 1 as ImageIndex ,  '#39'General\Mod' +
        'ule\dmMainGUI.actAccountsAccount=1'#39' as ActionDetails union all  ' +
        'Select 2 as ImageIndex ,  '#39'General\Module\dmMainGUI.actAccountsA' +
        'ccountsList=2'#39' as ActionDetails union all  Select 12 as ImageInd' +
        'ex ,  '#39'General\Module\dmMainGUI.actAccountsAccountTypeList=12'#39' a' +
        's ActionDetails union all  Select 277 as ImageIndex ,  '#39'General\' +
        'Module\dmMainGUI.actAccountsDepartment=277'#39' as ActionDetails uni' +
        'on all  Select 202 as ImageIndex ,  '#39'General\Module\dmMainGUI.ac' +
        'tAccountsDepartmentsList=202'#39' as ActionDetails union all  Select' +
        ' 166 as ImageIndex ,  '#39'General\Module\dmMainGUI.actAccountsTaxCo' +
        'de=166'#39' as ActionDetails union all  Select 572 as ImageIndex ,  ' +
        #39'General\Module\dmMainGUI.actAccountsTaxCodeList=572'#39' as ActionD' +
        'etails union all  Select 105 as ImageIndex ,  '#39'General\Module\dm' +
        'MainGUI.actAccountsTermsList=105'#39' as ActionDetails union all  Se' +
        'lect 157 as ImageIndex ,  '#39'General\Module\dmMainGUI.actAccountsS' +
        'hipping=157'#39' as ActionDetails union all  Select 179 as ImageInde' +
        'x ,  '#39'General\Module\dmMainGUI.actAccountsShippingList=179'#39' as A' +
        'ctionDetails union all  Select 145 as ImageIndex ,  '#39'General\Mod' +
        'ule\dmMainGUI.actAccountsForeignExchangeRate=145'#39' as ActionDetai' +
        'ls union all  Select 36 as ImageIndex ,  '#39'General\Module\dmMainG' +
        'UI.actAccountsForeignExchangeRatesList=36'#39' as ActionDetails unio' +
        'n all  Select 215 as ImageIndex ,  '#39'General\Module\dmMainGUI.act' +
        'AccountsForeignExchangeHistoryList=215'#39' as ActionDetails union a' +
        'll  Select 176 as ImageIndex ,  '#39'General\Module\dmMainGUI.actAcc' +
        'ountsMemorisedTransactionList=176'#39' as ActionDetails union all  S' +
        'elect 49 as ImageIndex ,  '#39'General\Module\dmMainGUI.actAccountsJ' +
        'ournalEntry=49'#39' as ActionDetails union all  Select 89 as ImageIn' +
        'dex ,  '#39'General\Module\dmMainGUI.actAccountsJournalEntryList=89'#39 +
        ' as ActionDetails union all  Select 467 as ImageIndex ,  '#39'Genera' +
        'l\Module\dmMainGUI.actAccountsTrialBalance=467'#39' as ActionDetails' +
        ' union all  Select 363 as ImageIndex ,  '#39'General\Module\dmMainGU' +
        'I.actAccountsBalanceSheet=363'#39' as ActionDetails union all  Selec' +
        't 390 as ImageIndex ,  '#39'General\Module\dmMainGUI.actAccountsProf' +
        'itAndLoss=390'#39' as ActionDetails union all  Select 391 as ImageIn' +
        'dex ,  '#39'General\Module\dmMainGUI.actAccountsjobProfitAndLoss=391' +
        #39' as ActionDetails union all  Select 70 as ImageIndex ,  '#39'Genera' +
        'l\Module\dmMainGUI.actAccountsProfitAndLossByPeriod=70'#39' as Actio' +
        'nDetails union all  Select 63 as ImageIndex ,  '#39'General\Module\d' +
        'mMainGUI.actAccountsElectronicFundsTransfer=63'#39' as ActionDetails' +
        ' union all  Select 248 as ImageIndex ,  '#39'General\Module\dmMainGU' +
        'I.actAccountsRefreshBatchTransaction=248'#39' as ActionDetails union' +
        ' all  Select 281 as ImageIndex ,  '#39'General\Module\dmMainGUI.actR' +
        'eportsAccounts=281'#39' as ActionDetails union all  Select 281 as Im' +
        'ageIndex ,  '#39'General\Module\dmMainGUI.actReportsAppointments=281' +
        #39' as ActionDetails union all  Select 281 as ImageIndex ,  '#39'Gener' +
        'al\Module\dmMainGUI.actReportsBanking=281'#39' as ActionDetails unio' +
        'n all  Select 301 as ImageIndex ,  '#39'General\Module\dmMainGUI.act' +
        'EmployeeEmployeeSummary=301'#39' as ActionDetails union all  Select ' +
        '281 as ImageIndex ,  '#39'General\Module\dmMainGUI.actReportsFixedAs' +
        'sets=281'#39' as ActionDetails union all  Select 281 as ImageIndex ,' +
        '  '#39'General\Module\dmMainGUI.actReportsHospitality=281'#39' as Action' +
        'Details union all  Select 281 as ImageIndex ,  '#39'General\Module\d' +
        'mMainGUI.actReportsInventory=281'#39' as ActionDetails union all  Se' +
        'lect 281 as ImageIndex ,  '#39'General\Module\dmMainGUI.actReportsPa' +
        'yments=281'#39' as ActionDetails union all  Select 281 as ImageIndex' +
        ' ,  '#39'General\Module\dmMainGUI.actReportsPayroll=281'#39' as ActionDe' +
        'tails union all  Select 281 as ImageIndex ,  '#39'General\Module\dmM' +
        'ainGUI.actReportsPurchases=281'#39' as ActionDetails union all  Sele' +
        'ct 281 as ImageIndex ,  '#39'General\Module\dmMainGUI.actReportsSale' +
        's=281'#39' as ActionDetails union all  Select 324 as ImageIndex ,  '#39 +
        'General\Module\dmMainGUI.actReportsTemplates=324'#39' as ActionDetai' +
        'ls union all  Select 32 as ImageIndex ,  '#39'General\Module\dmMainG' +
        'UI.actReportsCustomReports=32'#39' as ActionDetails union all  Selec' +
        't 413 as ImageIndex ,  '#39'General\Module\dmMainGUI.actWindowTiled=' +
        '413'#39' as ActionDetails union all  Select 412 as ImageIndex ,  '#39'Ge' +
        'neral\Module\dmMainGUI.actWindowCascade=412'#39' as ActionDetails un' +
        'ion all  Select 411 as ImageIndex ,  '#39'General\Module\dmMainGUI.a' +
        'ctWindowArrangeIcons=411'#39' as ActionDetails union all  Select 171' +
        ' as ImageIndex ,  '#39'General\Module\dmMainGUI.actWindowCustomiseTo' +
        'olbar=171'#39' as ActionDetails union all  Select 50 as ImageIndex ,' +
        '  '#39'General\Module\dmMainGUI.actUtilsLocations=50'#39' as ActionDetai' +
        'ls union all  Select 14 as ImageIndex ,  '#39'General\Module\dmMainG' +
        'UI.actUtilsDbUtilsBackup=14'#39' as ActionDetails union all  Select ' +
        '61 as ImageIndex ,  '#39'General\Module\dmMainGUI.actUtilsDbUtilsRes' +
        'tore=61'#39' as ActionDetails union all  Select 256 as ImageIndex , ' +
        ' '#39'General\Module\dmMainGUI.actUtilsDbUtilsCopy=256'#39' as ActionDet' +
        'ails union all  Select 555 as ImageIndex ,  '#39'General\Module\dmMa' +
        'inGUI.actUtilsDbUtilsCopyRO=555'#39' as ActionDetails union all  Sel' +
        'ect 257 as ImageIndex ,  '#39'General\Module\dmMainGUI.actUtilsDbUti' +
        'lsRemove=257'#39' as ActionDetails union all  Select 491 as ImageInd' +
        'ex ,  '#39'General\Module\dmMainGUI.actUtilsDbUtilsOptimise=491'#39' as ' +
        'ActionDetails union all  Select 426 as ImageIndex ,  '#39'General\Mo' +
        'dule\dmMainGUI.actUtilsSetupDocsPath=426'#39' as ActionDetails union' +
        ' all  Select 18 as ImageIndex ,  '#39'General\Module\dmMainGUI.actUt' +
        'ilsPublicHolidays=18'#39' as ActionDetails union all  Select 62 as I' +
        'mageIndex ,  '#39'General\Module\dmMainGUI.actUtilsPreferences=62'#39' a' +
        's ActionDetails union all  Select 149 as ImageIndex ,  '#39'General\' +
        'Module\dmMainGUI.actUtilsCompanyInformation=149'#39' as ActionDetail' +
        's union all  Select 433 as ImageIndex ,  '#39'General\Module\dmMainG' +
        'UI.actUtilsCurrentUsers=433'#39' as ActionDetails union all  Select ' +
        '144 as ImageIndex ,  '#39'General\Module\dmMainGUI.actUtilsFaxJobsFa' +
        'xSpoolList=144'#39' as ActionDetails union all  Select 138 as ImageI' +
        'ndex ,  '#39'General\Module\dmMainGUI.actUtilsFaxJobsPurgeOldFaxJobs' +
        '=138'#39' as ActionDetails union all  Select 148 as ImageIndex ,  '#39'G' +
        'eneral\Module\dmMainGUI.actUtilsAuditTrailAuditTrailList=148'#39' as' +
        ' ActionDetails union all  Select 236 as ImageIndex ,  '#39'General\M' +
        'odule\dmMainGUI.actUtilsAuditTrailPurgeAuditTrail=236'#39' as Action' +
        'Details union all  Select 486 as ImageIndex ,  '#39'General\Module\d' +
        'mMainGUI.actUtilsAuditTrailExportAuditTrail=486'#39' as ActionDetail' +
        's union all  Select 336 as ImageIndex ,  '#39'General\Module\dmMainG' +
        'UI.actAboutUpdateNotes=336'#39' as ActionDetails union all  Select 5' +
        '81 as ImageIndex ,  '#39'General\Module\dmMainGUI.actAboutAbout=581'#39 +
        ' as ActionDetails union all  Select 0 as ImageIndex ,  '#39'General\' +
        'Module\dmMainGUI.actFileExit=0'#39' as ActionDetails union all  Sele' +
        'ct 316 as ImageIndex ,  '#39'General\Module\dmMainGUI.actReportsQuot' +
        'eStatus=316'#39' as ActionDetails union all  Select 321 as ImageInde' +
        'x ,  '#39'General\Module\dmMainGUI.actReportsSalesOrderStatus=321'#39' a' +
        's ActionDetails union all  Select 295 as ImageIndex ,  '#39'General\' +
        'Module\dmMainGUI.actReportsUnPaidBills=295'#39' as ActionDetails uni' +
        'on all  Select 327 as ImageIndex ,  '#39'General\Module\dmMainGUI.ac' +
        'tReportsStockStatus=327'#39' as ActionDetails union all  Select 496 ' +
        'as ImageIndex ,  '#39'General\Module\dmMainGUI.actReportsProductSale' +
        'sSummary=496'#39' as ActionDetails union all  Select 550 as ImageInd' +
        'ex ,  '#39'General\Module\dmMainGUI.actReportsTransactionJournal=550' +
        #39' as ActionDetails union all  Select 227 as ImageIndex ,  '#39'Gener' +
        'al\Module\dmMainGUI.actReportsGeneralLedger=227'#39' as ActionDetail' +
        's union all  Select 302 as ImageIndex ,  '#39'General\Module\dmMainG' +
        'UI.actReportsJobProfitability=302'#39' as ActionDetails union all  S' +
        'elect 300 as ImageIndex ,  '#39'General\Module\dmMainGUI.actReportsS' +
        'upplier=300'#39' as ActionDetails union all  Select 68 as ImageIndex' +
        ' ,  '#39'General\Module\dmMainGUI.actReportsBAS=68'#39' as ActionDetails' +
        ' union all  Select 168 as ImageIndex ,  '#39'General\Module\dmMainGU' +
        'I.actReportsBASList=168'#39' as ActionDetails union all  Select 266 ' +
        'as ImageIndex ,  '#39'General\Module\dmMainGUI.actReportsAccountsSum' +
        'mary=266'#39' as ActionDetails union all  Select 260 as ImageIndex ,' +
        '  '#39'General\Module\dmMainGUI.actUtilsExportToReportDB=260'#39' as Act' +
        'ionDetails union all  Select 99 as ImageIndex ,  '#39'General\Module' +
        '\dmMainGUI.actCustomImports=99'#39' as ActionDetails union all  Sele' +
        'ct 10 as ImageIndex ,  '#39'General\Module\dmMainGUI.actEmployeeTran' +
        'sferDetails=10'#39' as ActionDetails union all  Select 558 as ImageI' +
        'ndex ,  '#39'General\Module\dmMainGUI.actPaymentsPrintRecipientCreat' +
        'edStatement=558'#39' as ActionDetails union all  Select 112 as Image' +
        'Index ,  '#39'General\Module\dmMainGUI.actEmployeeToDoList=112'#39' as A' +
        'ctionDetails union all  Select 0 as ImageIndex ,  '#39'General\Modul' +
        'e\dmMainGUI.actEmployeeAccessLevels=0'#39' as ActionDetails union al' +
        'l  Select 146 as ImageIndex ,  '#39'General\Module\dmMainGUI.actEmpl' +
        'oyeePersonalPreferences=146'#39' as ActionDetails union all  Select ' +
        '517 as ImageIndex ,  '#39'General\Module\dmMainGUI.actCompanyTypes=5' +
        '17'#39' as ActionDetails union all  Select 495 as ImageIndex ,  '#39'Gen' +
        'eral\Module\dmMainGUI.actFollowupTypes=495'#39' as ActionDetails uni' +
        'on all  Select 137 as ImageIndex ,  '#39'General\Module\dmMainGUI.ac' +
        'tFollowupResultTypes=137'#39' as ActionDetails union all  Select 115' +
        ' as ImageIndex ,  '#39'General\Module\dmMainGUI.actReminders=115'#39' as' +
        ' ActionDetails union all  Select 40 as ImageIndex ,  '#39'General\Mo' +
        'dule\dmMainGUI.actBinUsageReport=40'#39' as ActionDetails union all ' +
        ' Select 308 as ImageIndex ,  '#39'General\Module\dmMainGUI.actReport' +
        'sSalesSummary=308'#39' as ActionDetails union all  Select 294 as Ima' +
        'geIndex ,  '#39'General\Module\dmMainGUI.actPaymentsChequePrn=294'#39' a' +
        's ActionDetails union all  Select 275 as ImageIndex ,  '#39'General\' +
        'Module\dmMainGUI.actPaymentsEFT=275'#39' as ActionDetails union all ' +
        ' Select 582 as ImageIndex ,  '#39'General\Module\dmMainGUI.actAboutS' +
        'howManual=582'#39' as ActionDetails union all  Select 364 as ImageIn' +
        'dex ,  '#39'General\Module\dmMainGUI.actPaymentsAccountsReceivableNo' +
        'tes=364'#39' as ActionDetails union all  Select 195 as ImageIndex , ' +
        ' '#39'General\Module\dmMainGUI.actApptsCancellationReasons=195'#39' as A' +
        'ctionDetails union all  Select 313 as ImageIndex ,  '#39'General\Mod' +
        'ule\dmMainGUI.POBOList=313'#39' as ActionDetails union all  Select 5' +
        '66 as ImageIndex ,  '#39'General\Module\dmMainGUI.POBOExpressList=56' +
        '6'#39' as ActionDetails union all  Select 500 as ImageIndex ,  '#39'Gene' +
        'ral\Module\dmMainGUI.actSalesPrintPickSlips=500'#39' as ActionDetail' +
        's union all  Select 315 as ImageIndex ,  '#39'General\Module\dmMainG' +
        'UI.actCustomExport=315'#39' as ActionDetails union all  Select 281 a' +
        's ImageIndex ,  '#39'General\Module\dmMainGUI.actReportsCRM=281'#39' as ' +
        'ActionDetails union all  Select 281 as ImageIndex ,  '#39'General\Mo' +
        'dule\dmMainGUI.actReportsJobs=281'#39' as ActionDetails union all  S' +
        'elect 342 as ImageIndex ,  '#39'General\Module\dmMainGUI.actEquipmen' +
        'tList=342'#39' as ActionDetails union all  Select 254 as ImageIndex ' +
        ',  '#39'General\Module\dmMainGUI.actEquipment=254'#39' as ActionDetails ' +
        'union all  Select 258 as ImageIndex ,  '#39'General\Module\dmMainGUI' +
        '.actProductFormulaEntry=258'#39' as ActionDetails union all  Select ' +
        '552 as ImageIndex ,  '#39'General\Module\dmMainGUI.actProductFormula' +
        'Creator=552'#39' as ActionDetails union all  Select 317 as ImageInde' +
        'x ,  '#39'General\Module\dmMainGUI.actProductFormulaList=317'#39' as Act' +
        'ionDetails union all  Select 119 as ImageIndex ,  '#39'General\Modul' +
        'e\dmMainGUI.actEmployeePayrollATO=119'#39' as ActionDetails union al' +
        'l  Select 595 as ImageIndex ,  '#39'General\Module\dmMainGUI.actPurc' +
        'hasesExpenseClaimList=595'#39' as ActionDetails union all  Select 56' +
        '3 as ImageIndex ,  '#39'General\Module\dmMainGUI.actPaymentsApproval' +
        'ReminderList=563'#39' as ActionDetails union all  Select 385 as Imag' +
        'eIndex ,  '#39'General\Module\dmMainGUI.actWorkOrderStatusList=385'#39' ' +
        'as ActionDetails union all  Select 417 as ImageIndex ,  '#39'General' +
        '\Module\dmMainGUI.actDeliveryDocketList=417'#39' as ActionDetails un' +
        'ion all  Select 20 as ImageIndex ,  '#39'General\Module\dmMainGUI.ac' +
        'tEmployeeTerminationList=20'#39' as ActionDetails union all  Select ' +
        '549 as ImageIndex ,  '#39'General\Module\dmMainGUI.actAccountsIntras' +
        'tatDeclaration=549'#39' as ActionDetails union all  Select 551 as Im' +
        'ageIndex ,  '#39'General\Module\dmMainGUI.actAccountsIntrastatList=5' +
        '51'#39' as ActionDetails union all  Select 131 as ImageIndex ,  '#39'Gen' +
        'eral\Module\dmMainGUI.actSource=131'#39' as ActionDetails union all ' +
        ' Select 345 as ImageIndex ,  '#39'General\Module\dmMainGUI.actCashFl' +
        'owForecast=345'#39' as ActionDetails union all  Select 0 as ImageInd' +
        'ex ,  '#39'General\Module\dmMainGUI.actGeneralLedger=0'#39' as ActionDet' +
        'ails union all  Select 400 as ImageIndex ,  '#39'General\Module\dmMa' +
        'inGUI.actUnpaidBillGUI=400'#39' as ActionDetails union all  Select 5' +
        '96 as ImageIndex ,  '#39'General\Module\dmMainGUI.actCustomerBalance' +
        'Detail=596'#39' as ActionDetails union all  Select 597 as ImageIndex' +
        ' ,  '#39'General\Module\dmMainGUI.actCustomerNotesReport=597'#39' as Act' +
        'ionDetails union all  Select 598 as ImageIndex ,  '#39'General\Modul' +
        'e\dmMainGUI.actEmployeeReportByPeriod=598'#39' as ActionDetails unio' +
        'n all  Select 599 as ImageIndex ,  '#39'General\Module\dmMainGUI.act' +
        'ForeignSalesList=599'#39' as ActionDetails union all  Select 600 as ' +
        'ImageIndex ,  '#39'General\Module\dmMainGUI.actActionAuthorisationsL' +
        'ist=600'#39' as ActionDetails union all  Select 601 as ImageIndex , ' +
        ' '#39'General\Module\dmMainGUI.actCombinedAnalysisList=601'#39' as Actio' +
        'nDetails union all  Select 602 as ImageIndex ,  '#39'General\Module\' +
        'dmMainGUI.actCommissionReport=602'#39' as ActionDetails union all  S' +
        'elect 603 as ImageIndex ,  '#39'General\Module\dmMainGUI.actEmployee' +
        'sFixedAssetsList=603'#39' as ActionDetails union all  Select 604 as ' +
        'ImageIndex ,  '#39'General\Module\dmMainGUI.actSalesCommissionList=6' +
        '04'#39' as ActionDetails union all  Select 35 as ImageIndex ,  '#39'Gene' +
        'ral\Module\dmMainGUI.actAssetRegisterList=35'#39' as ActionDetails u' +
        'nion all  Select 605 as ImageIndex ,  '#39'General\Module\dmMainGUI.' +
        'actFixedAssetsDetails=605'#39' as ActionDetails union all  Select 60' +
        '6 as ImageIndex ,  '#39'General\Module\dmMainGUI.actProductSalesSumm' +
        'aryByColumn=606'#39' as ActionDetails union all  Select 607 as Image' +
        'Index ,  '#39'General\Module\dmMainGUI.actStockStatusRoling=607'#39' as ' +
        'ActionDetails union all  Select 608 as ImageIndex ,  '#39'General\Mo' +
        'dule\dmMainGUI.actStockQtysLocationsReport=608'#39' as ActionDetails' +
        ' union all  Select 609 as ImageIndex ,  '#39'General\Module\dmMainGU' +
        'I.actSupplierProductReport=609'#39' as ActionDetails union all  Sele' +
        'ct 610 as ImageIndex ,  '#39'General\Module\dmMainGUI.actUnAllocated' +
        'BinsReport=610'#39' as ActionDetails union all  Select 611 as ImageI' +
        'ndex ,  '#39'General\Module\dmMainGUI.actUnbalancedBinQty=611'#39' as Ac' +
        'tionDetails union all  Select 612 as ImageIndex ,  '#39'General\Modu' +
        'le\dmMainGUI.actCustomerJobFollowupList=612'#39' as ActionDetails un' +
        'ion all  Select 613 as ImageIndex ,  '#39'General\Module\dmMainGUI.a' +
        'ctProfitLossSummary=613'#39' as ActionDetails union all  Select 544 ' +
        'as ImageIndex ,  '#39'General\Module\dmMainGUI.actProdAttribTemplate' +
        'Fields=544'#39' as ActionDetails union all  Select 545 as ImageIndex' +
        ' ,  '#39'General\Module\dmMainGUI.actProdAttribTemplateFieldsdetails' +
        '=545'#39' as ActionDetails union all  Select 542 as ImageIndex ,  '#39'G' +
        'eneral\Module\dmMainGUI.actProductAttributes=542'#39' as ActionDetai' +
        'ls union all  Select 614 as ImageIndex ,  '#39'General\Module\dmMain' +
        'GUI.actAccountsPayableNotes=614'#39' as ActionDetails union all  Sel' +
        'ect 615 as ImageIndex ,  '#39'General\Module\dmMainGUI.actExpenseCla' +
        'imList=615'#39' as ActionDetails union all  Select 616 as ImageIndex' +
        ' ,  '#39'General\Module\dmMainGUI.actForeignPurchaseList=616'#39' as Act' +
        'ionDetails union all  Select 617 as ImageIndex ,  '#39'General\Modul' +
        'e\dmMainGUI.actSupplierStatement=617'#39' as ActionDetails union all' +
        '  Select 618 as ImageIndex ,  '#39'General\Module\dmMainGUI.actUnInv' +
        'oicedPurchasesList=618'#39' as ActionDetails union all  Select 619 a' +
        's ImageIndex ,  '#39'General\Module\dmMainGUI.actUnInvoicedPurchItem' +
        'List=619'#39' as ActionDetails union all  Select 620 as ImageIndex ,' +
        '  '#39'General\Module\dmMainGUI.actQuoteDetailsReport=620'#39' as Action' +
        'Details union all  Select 621 as ImageIndex ,  '#39'General\Module\d' +
        'mMainGUI.actSalesReport=621'#39' as ActionDetails union all  Select ' +
        '622 as ImageIndex ,  '#39'General\Module\dmMainGUI.actSalesRewardPoi' +
        'ntsList=622'#39' as ActionDetails union all  Select 623 as ImageInde' +
        'x ,  '#39'General\Module\dmMainGUI.actSoldProductsReport=623'#39' as Act' +
        'ionDetails union all  Select 358 as ImageIndex ,  '#39'General\Modul' +
        'e\dmMainGUI.actTransactionList=358'#39' as ActionDetails union all  ' +
        'Select 505 as ImageIndex ,  '#39'General\Module\dmMainGUI.actMarketi' +
        'ngRatios=505'#39' as ActionDetails union all  Select 201 as ImageInd' +
        'ex ,  '#39'General\Module\dmMainGUI.actSalesRatios=201'#39' as ActionDet' +
        'ails union all  Select 533 as ImageIndex ,  '#39'General\Module\dmMa' +
        'inGUI.actLeadStatusType1=533'#39' as ActionDetails union all  Select' +
        ' 518 as ImageIndex ,  '#39'General\Module\dmMainGUI.actSalesPipeline' +
        '=518'#39' as ActionDetails union all  Select 377 as ImageIndex ,  '#39'G' +
        'eneral\Module\dmMainGUI.actSerialNumberList=377'#39' as ActionDetail' +
        's union all  Select 94 as ImageIndex ,  '#39'General\Module\dmMainGU' +
        'I.actShippingContainerStatus=94'#39' as ActionDetails union all  Sel' +
        'ect 525 as ImageIndex ,  '#39'General\Module\dmMainGUI.actShippingCo' +
        'ntainer=525'#39' as ActionDetails union all  Select 527 as ImageInde' +
        'x ,  '#39'General\Module\dmMainGUI.actShipContainerList=527'#39' as Acti' +
        'onDetails union all  Select 37 as ImageIndex ,  '#39'General\Module\' +
        'dmMainGUI.actBatches=37'#39' as ActionDetails union all  Select 365 ' +
        'as ImageIndex ,  '#39'General\Module\dmMainGUI.actMailMergeHistory=3' +
        '65'#39' as ActionDetails union all  Select 7 as ImageIndex ,  '#39'Gener' +
        'al\Module\dmMainGUI.actTimesheetEntry=7'#39' as ActionDetails union ' +
        'all  Select 366 as ImageIndex ,  '#39'General\Module\dmMainGUI.actEm' +
        'ployeeTimesheetList=366'#39' as ActionDetails union all  Select 281 ' +
        'as ImageIndex ,  '#39'General\Module\dmMainGUI.actReportsWorkShop=28' +
        '1'#39' as ActionDetails union all  Select 238 as ImageIndex ,  '#39'Gene' +
        'ral\Module\dmMainGUI.actClientEquipmentlist=238'#39' as ActionDetail' +
        's union all  Select 382 as ImageIndex ,  '#39'General\Module\dmMainG' +
        'UI.actVidoes=382'#39' as ActionDetails union all  Select 395 as Imag' +
        'eIndex ,  '#39'General\Module\dmMainGUI.actincomeExpenseConfig=395'#39' ' +
        'as ActionDetails union all  Select 271 as ImageIndex ,  '#39'General' +
        '\Module\dmMainGUI.actmainDashboard=271'#39' as ActionDetails union a' +
        'll  Select 561 as ImageIndex ,  '#39'General\Module\dmMainGUI.actsal' +
        'esDashboard=561'#39' as ActionDetails union all  Select 485 as Image' +
        'Index ,  '#39'General\Module\dmMainGUI.actSerialJobnumber=485'#39' as Ac' +
        'tionDetails union all  Select 519 as ImageIndex ,  '#39'General\Modu' +
        'le\dmMainGUI.actAutoAdjustbin=519'#39' as ActionDetails union all  S' +
        'elect 457 as ImageIndex ,  '#39'General\Module\dmMainGUI.actSalesLis' +
        'twithCommision=457'#39' as ActionDetails union all  Select 461 as Im' +
        'ageIndex ,  '#39'General\Module\dmMainGUI.actCashSaleDepositGUI=461'#39 +
        ' as ActionDetails union all  Select 213 as ImageIndex ,  '#39'Genera' +
        'l\Module\dmMainGUI.actAdjustUOM=213'#39' as ActionDetails union all ' +
        ' Select 121 as ImageIndex ,  '#39'General\Module\dmMainGUI.actReward' +
        'Points=121'#39' as ActionDetails union all  Select 122 as ImageIndex' +
        ' ,  '#39'General\Module\dmMainGUI.actRewardPointsDueToExpireGUI=122'#39 +
        ' as ActionDetails union all  Select 386 as ImageIndex ,  '#39'Genera' +
        'l\Module\dmMainGUI.actAppointmentStatusList=386'#39' as ActionDetail' +
        's union all  Select 590 as ImageIndex ,  '#39'General\Module\dmMainG' +
        'UI.actRepAbilityList=590'#39' as ActionDetails union all  Select 472' +
        ' as ImageIndex ,  '#39'General\Module\dmMainGUI.actRepAbility=472'#39' a' +
        's ActionDetails union all  Select 381 as ImageIndex ,  '#39'General\' +
        'Module\dmMainGUI.actTransactionwith0Qty=381'#39' as ActionDetails un' +
        'ion all  Select 379 as ImageIndex ,  '#39'General\Module\dmMainGUI.a' +
        'ctCustomerExpressList=379'#39' as ActionDetails union all  Select 46' +
        '9 as ImageIndex ,  '#39'General\Module\dmMainGUI.actShippingAgent=46' +
        '9'#39' as ActionDetails union all  Select 222 as ImageIndex ,  '#39'Gene' +
        'ral\Module\dmMainGUI.actShippingAgentlist=222'#39' as ActionDetails ' +
        'union all  Select 373 as ImageIndex ,  '#39'General\Module\dmMainGUI' +
        '.actMessages=373'#39' as ActionDetails union all  Select 0 as ImageI' +
        'ndex ,  '#39'General\Module\dmMainGUI.actCustomise=0'#39' as ActionDetai' +
        'ls union all  Select 624 as ImageIndex ,  '#39'General\Module\dmMain' +
        'GUI.DNMAction2=624'#39' as ActionDetails union all  Select 0 as Imag' +
        'eIndex ,  '#39'General\Module\dmMainGUI.actProductListwithUOM=0'#39' as ' +
        'ActionDetails union all  Select 526 as ImageIndex ,  '#39'General\Mo' +
        'dule\dmMainGUI.actRegionList=526'#39' as ActionDetails union all  Se' +
        'lect 528 as ImageIndex ,  '#39'General\Module\dmMainGUI.actRegion=52' +
        '8'#39' as ActionDetails union all  Select 403 as ImageIndex ,  '#39'Gene' +
        'ral\Module\dmMainGUI.actProductBarcodes=403'#39' as ActionDetails un' +
        'ion all  Select 110 as ImageIndex ,  '#39'General\Module\dmMainGUI.a' +
        'ctClientList=110'#39' as ActionDetails union all  Select 506 as Imag' +
        'eIndex ,  '#39'General\Module\dmMainGUI.actContactList=506'#39' as Actio' +
        'nDetails union all  Select 508 as ImageIndex ,  '#39'General\Module\' +
        'dmMainGUI.actMarketingContactcontactList=508'#39' as ActionDetails u' +
        'nion all  Select 509 as ImageIndex ,  '#39'General\Module\dmMainGUI.' +
        'actProductClassList=509'#39' as ActionDetails union all  Select 463 ' +
        'as ImageIndex ,  '#39'General\Module\dmMainGUI.actOtherfollowups=463' +
        #39' as ActionDetails union all  Select 203 as ImageIndex ,  '#39'Gener' +
        'al\Module\dmMainGUI.actProductgroupdiscount=203'#39' as ActionDetail' +
        's union all  Select 205 as ImageIndex ,  '#39'General\Module\dmMainG' +
        'UI.actProductSpecificationList=205'#39' as ActionDetails union all  ' +
        'Select 206 as ImageIndex ,  '#39'General\Module\dmMainGUI.actProduct' +
        'ExtrabuyPrices=206'#39' as ActionDetails union all  Select 514 as Im' +
        'ageIndex ,  '#39'General\Module\dmMainGUI.actProductExtraSellPrices=' +
        '514'#39' as ActionDetails union all  Select 515 as ImageIndex ,  '#39'Ge' +
        'neral\Module\dmMainGUI.actProductforeignBuyPrice=515'#39' as ActionD' +
        'etails union all  Select 209 as ImageIndex ,  '#39'General\Module\dm' +
        'MainGUI.actproductForeignSellPrice=209'#39' as ActionDetails union a' +
        'll  Select 210 as ImageIndex ,  '#39'General\Module\dmMainGUI.actRel' +
        'atedProducts=210'#39' as ActionDetails union all  Select 516 as Imag' +
        'eIndex ,  '#39'General\Module\dmMainGUI.actrelatedcustomers=516'#39' as ' +
        'ActionDetails union all  Select 520 as ImageIndex ,  '#39'General\Mo' +
        'dule\dmMainGUI.actShippingMethods=520'#39' as ActionDetails union al' +
        'l  Select 521 as ImageIndex ,  '#39'General\Module\dmMainGUI.actSpec' +
        'ialProducts=521'#39' as ActionDetails union all  Select 510 as Image' +
        'Index ,  '#39'General\Module\dmMainGUI.actLanguages=510'#39' as ActionDe' +
        'tails union all  Select 512 as ImageIndex ,  '#39'General\Module\dmM' +
        'ainGUI.actkills=512'#39' as ActionDetails union all  Select 204 as I' +
        'mageIndex ,  '#39'General\Module\dmMainGUI.actSkillList=204'#39' as Acti' +
        'onDetails union all  Select 513 as ImageIndex ,  '#39'General\Module' +
        '\dmMainGUI.actEmployeeSkillList=513'#39' as ActionDetails union all ' +
        ' Select 634 as ImageIndex ,  '#39'General\Module\dmMainGUI.actProduc' +
        'tGroupList=634'#39' as ActionDetails union all  Select 631 as ImageI' +
        'ndex ,  '#39'General\Module\dmMainGUI.actPickingSlipList=631'#39' as Act' +
        'ionDetails union all  Select 393 as ImageIndex ,  '#39'General\Modul' +
        'e\dmMainGUI.actSalesQuotesPadQuote=393'#39' as ActionDetails union a' +
        'll  Select 0 as ImageIndex ,  '#39'General\Module\dmMainGUI.actWebAP' +
        'ITest=0'#39' as ActionDetails union all  Select 458 as ImageIndex , ' +
        ' '#39'General\Module\dmMainGUI.actSubTaxcodes=458'#39' as ActionDetails ' +
        'union all  Select 459 as ImageIndex ,  '#39'General\Module\dmMainGUI' +
        '.actSubTaxcode=459'#39' as ActionDetails union all  Select 484 as Im' +
        'ageIndex ,  '#39'General\Module\dmMainGUI.actNotesAuditTrial=484'#39' as' +
        ' ActionDetails union all  Select 567 as ImageIndex ,  '#39'General\M' +
        'odule\dmMainGUI.actImportDataMapping=567'#39' as ActionDetails union' +
        ' all  Select 408 as ImageIndex ,  '#39'General\Module\dmMainGUI.actI' +
        'mportDataMappingList=408'#39' as ActionDetails union all  Select 470' +
        ' as ImageIndex ,  '#39'General\Module\dmMainGUI.actDeldocketList=470' +
        #39' as ActionDetails union all  Select 223 as ImageIndex ,  '#39'Gener' +
        'al\Module\dmMainGUI.actSalesListOutstanding=223'#39' as ActionDetail' +
        's union all  Select 479 as ImageIndex ,  '#39'General\Module\dmMainG' +
        'UI.actPrintPurchaseOrders=479'#39' as ActionDetails union all  Selec' +
        't 536 as ImageIndex ,  '#39'General\Module\dmMainGUI.actPurchaseOrde' +
        'rAudit=536'#39' as ActionDetails union all  Select 502 as ImageIndex' +
        ' ,  '#39'General\Module\dmMainGUI.actSalesJobQuoteList=502'#39' as Actio' +
        'nDetails union all  Select 464 as ImageIndex ,  '#39'General\Module\' +
        'dmMainGUI.actTask=464'#39' as ActionDetails union all  Select 531 as' +
        ' ImageIndex ,  '#39'General\Module\dmMainGUI.actTaskList=531'#39' as Act' +
        'ionDetails union all  Select 465 as ImageIndex ,  '#39'General\Modul' +
        'e\dmMainGUI.actClientPhoneList=465'#39' as ActionDetails union all  ' +
        'Select 532 as ImageIndex ,  '#39'General\Module\dmMainGUI.actPhoneSu' +
        'pportLogListExpress=532'#39' as ActionDetails union all  Select 380 ' +
        'as ImageIndex ,  '#39'General\Module\dmMainGUI.actCustlistWithDetail' +
        's=380'#39' as ActionDetails union all  Select 522 as ImageIndex ,  '#39 +
        'General\Module\dmMainGUI.actPhoneSupportTypeList=522'#39' as ActionD' +
        'etails union all  Select 523 as ImageIndex ,  '#39'General\Module\dm' +
        'MainGUI.actPhoneSupportVersionList=523'#39' as ActionDetails union a' +
        'll  Select 199 as ImageIndex ,  '#39'General\Module\dmMainGUI.actUnA' +
        'llocatedQty=199'#39' as ActionDetails union all  Select 483 as Image' +
        'Index ,  '#39'General\Module\dmMainGUI.actProductPurchaseMovementLis' +
        't=483'#39' as ActionDetails union all  Select 367 as ImageIndex ,  '#39 +
        'General\Module\dmMainGUI.actNumberSequenceList=367'#39' as ActionDet' +
        'ails union all  Select 492 as ImageIndex ,  '#39'General\Module\dmMa' +
        'inGUI.actLinkTo=492'#39' as ActionDetails union all  Select 477 as I' +
        'mageIndex ,  '#39'General\Module\dmMainGUI.actGoogleAnalysisReport_L' +
        'anguage=477'#39' as ActionDetails union all  Select 490 as ImageInde' +
        'x ,  '#39'General\Module\dmMainGUI.actGoogleAnalysisReport_Location=' +
        '490'#39' as ActionDetails union all  Select 462 as ImageIndex ,  '#39'Ge' +
        'neral\Module\dmMainGUI.actGoogleAnalysisReport_Keyword=462'#39' as A' +
        'ctionDetails union all  Select 504 as ImageIndex ,  '#39'General\Mod' +
        'ule\dmMainGUI.actGoogleAnalysisReport_Campaign=504'#39' as ActionDet' +
        'ails union all  Select 460 as ImageIndex ,  '#39'General\Module\dmMa' +
        'inGUI.actGoogleAnalysisReport_Browser=460'#39' as ActionDetails unio' +
        'n all  Select 449 as ImageIndex ,  '#39'General\Module\dmMainGUI.act' +
        'GoogleAnalysisReport_DayofWeek=449'#39' as ActionDetails union all  ' +
        'Select 650 as ImageIndex ,  '#39'General\Module\dmMainGUI.actGoogleA' +
        'nalyticReport_Language=650'#39' as ActionDetails union all  Select 6' +
        '51 as ImageIndex ,  '#39'General\Module\dmMainGUI.actGoogleAnalyticR' +
        'eport_Location=651'#39' as ActionDetails union all  Select 649 as Im' +
        'ageIndex ,  '#39'General\Module\dmMainGUI.actGoogleAnalyticReport_Ke' +
        'yword=649'#39' as ActionDetails union all  Select 652 as ImageIndex ' +
        ',  '#39'General\Module\dmMainGUI.actGoogleAnalyticReport_Campaign=65' +
        '2'#39' as ActionDetails union all  Select 648 as ImageIndex ,  '#39'Gene' +
        'ral\Module\dmMainGUI.actGoogleAnalyticReport_Browser=648'#39' as Act' +
        'ionDetails union all  Select 645 as ImageIndex ,  '#39'General\Modul' +
        'e\dmMainGUI.actGoogleAnalyticReport_DayofWeek=645'#39' as ActionDeta' +
        'ils union all  Select 281 as ImageIndex ,  '#39'General\Module\dmMai' +
        'nGUI.actreportsGoogle=281'#39' as ActionDetails union all  Select 44' +
        '3 as ImageIndex ,  '#39'General\Module\dmMainGUI.actAnalyicreports=4' +
        '43'#39' as ActionDetails union all  Select 489 as ImageIndex ,  '#39'Gen' +
        'eral\Module\dmMainGUI.actAnalyticsSummaryList=489'#39' as ActionDeta' +
        'ils union all  Select 675 as ImageIndex ,  '#39'General\Module\dmMai' +
        'nGUI.actAnalyticsDetailList=675'#39' as ActionDetails union all  Sel' +
        'ect 499 as ImageIndex ,  '#39'General\Module\dmMainGUI.actGoogleAnal' +
        'ysisReport_Summary=499'#39' as ActionDetails union all  Select 674 a' +
        's ImageIndex ,  '#39'General\Module\dmMainGUI.actGoogleAnalytic_Summ' +
        'ary=674'#39' as ActionDetails union all  Select 466 as ImageIndex , ' +
        ' '#39'General\Module\dmMainGUI.actFaq=466'#39' as ActionDetails union al' +
        'l  Select 453 as ImageIndex ,  '#39'General\Module\dmMainGUI.actGoog' +
        'leanalysisCost=453'#39' as ActionDetails union all  Select 421 as Im' +
        'ageIndex ,  '#39'General\Module\dmMainGUI.actProductSalesReport=421'#39 +
        ' as ActionDetails union all  Select 543 as ImageIndex ,  '#39'Genera' +
        'l\Module\dmMainGUI.actVoucher=543'#39' as ActionDetails union all  S' +
        'elect 639 as ImageIndex ,  '#39'General\Module\dmMainGUI.actsalesAna' +
        'lysisGraph=639'#39' as ActionDetails union all  Select 399 as ImageI' +
        'ndex ,  '#39'General\Module\dmMainGUI.actEmailList=399'#39' as ActionDet' +
        'ails union all  Select 541 as ImageIndex ,  '#39'General\Module\dmMa' +
        'inGUI.actEmailPurge=541'#39' as ActionDetails union all  Select 585 ' +
        'as ImageIndex ,  '#39'General\Module\dmMainGUI.actSalesAnalysisManua' +
        'l=585'#39' as ActionDetails union all  Select 588 as ImageIndex ,  '#39 +
        'General\Module\dmMainGUI.actSalesAnalysisManualList=588'#39' as Acti' +
        'onDetails union all  Select 154 as ImageIndex ,  '#39'General\Module' +
        '\dmMainGUI.actvoucherInvoice=154'#39' as ActionDetails union all  Se' +
        'lect 497 as ImageIndex ,  '#39'General\Module\dmMainGUI.actProfitnLo' +
        'sschart=497'#39' as ActionDetails union all  Select 86 as ImageIndex' +
        ' ,  '#39'General\Module\dmMainGUI.actProfitnLosschartCompareGross=86' +
        #39' as ActionDetails union all  Select 407 as ImageIndex ,  '#39'Gener' +
        'al\Module\dmMainGUI.actProfitnLosschartCompareGrossMonth=407'#39' as' +
        ' ActionDetails union all  Select 409 as ImageIndex ,  '#39'General\M' +
        'odule\dmMainGUI.actProfitnLosschartCompareGrossQuarter=409'#39' as A' +
        'ctionDetails union all  Select 410 as ImageIndex ,  '#39'General\Mod' +
        'ule\dmMainGUI.actProfitnLosschartCompareGrossYear=410'#39' as Action' +
        'Details union all  Select 430 as ImageIndex ,  '#39'General\Module\d' +
        'mMainGUI.actProfitnLosschartCompareRevenue=430'#39' as ActionDetails' +
        ' union all  Select 431 as ImageIndex ,  '#39'General\Module\dmMainGU' +
        'I.actProfitnLosschartCompareRevenueMonth=431'#39' as ActionDetails u' +
        'nion all  Select 455 as ImageIndex ,  '#39'General\Module\dmMainGUI.' +
        'actProfitnLosschartCompareRevenuequarter=455'#39' as ActionDetails u' +
        'nion all  Select 456 as ImageIndex ,  '#39'General\Module\dmMainGUI.' +
        'actProfitnLosschartCompareRevenueYear=456'#39' as ActionDetails unio' +
        'n all  Select 414 as ImageIndex ,  '#39'General\Module\dmMainGUI.act' +
        'ProfitnLosschartCompareNI=414'#39' as ActionDetails union all  Selec' +
        't 415 as ImageIndex ,  '#39'General\Module\dmMainGUI.actProfitnLossc' +
        'hartCompareNIMonth=415'#39' as ActionDetails union all  Select 424 a' +
        's ImageIndex ,  '#39'General\Module\dmMainGUI.actProfitnLosschartCom' +
        'pareNIQuarter=424'#39' as ActionDetails union all  Select 425 as Ima' +
        'geIndex ,  '#39'General\Module\dmMainGUI.actProfitnLosschartCompareN' +
        'IYear=425'#39' as ActionDetails union all  Select 383 as ImageIndex ' +
        ',  '#39'General\Module\dmMainGUI.actProfitnLosschartgrossProfit=383'#39 +
        ' as ActionDetails union all  Select 560 as ImageIndex ,  '#39'Genera' +
        'l\Module\dmMainGUI.actSmartorderListDetails=560'#39' as ActionDetail' +
        's union all  Select 576 as ImageIndex ,  '#39'General\Module\dmMainG' +
        'UI.actTaxSummaryDetailReport=576'#39' as ActionDetails union all  Se' +
        'lect 537 as ImageIndex ,  '#39'General\Module\dmMainGUI.actrosterRep' +
        'ort=537'#39' as ActionDetails union all  Select 538 as ImageIndex , ' +
        ' '#39'General\Module\dmMainGUI.actRosterReportDetails=538'#39' as Action' +
        'Details union all  Select 586 as ImageIndex ,  '#39'General\Module\d' +
        'mMainGUI.actSiteIntegrationReport=586'#39' as ActionDetails union al' +
        'l  Select 422 as ImageIndex ,  '#39'General\Module\dmMainGUI.actAppr' +
        'ovalLevelList=422'#39' as ActionDetails union all  Select 344 as Ima' +
        'geIndex ,  '#39'General\Module\dmMainGUI.actApprovalList=344'#39' as Act' +
        'ionDetails union all  Select 637 as ImageIndex ,  '#39'General\Modul' +
        'e\dmMainGUI.actHourlySalesReport=637'#39' as ActionDetails union all' +
        '  Select 0 as ImageIndex ,  '#39'General\Module\dmMainGUI.actEmailRe' +
        'ferenceList=0'#39' as ActionDetails union all  Select 0 as ImageInde' +
        'x ,  '#39'General\Module\dmMainGUI.actLetterReferenceList=0'#39' as Acti' +
        'onDetails union all  Select 423 as ImageIndex ,  '#39'General\Module' +
        '\dmMainGUI.actAccountrunningBalance=423'#39' as ActionDetails union ' +
        'all  Select 384 as ImageIndex ,  '#39'General\Module\dmMainGUI.actCa' +
        'shProfitandLoss=384'#39' as ActionDetails union all  Select 638 as I' +
        'mageIndex ,  '#39'General\Module\dmMainGUI.actPnLEmployeereport=638'#39 +
        ' as ActionDetails union all  Select 539 as ImageIndex ,  '#39'Genera' +
        'l\Module\dmMainGUI.actAreaCode=539'#39' as ActionDetails union all  ' +
        'Select 556 as ImageIndex ,  '#39'General\Module\dmMainGUI.actAreacod' +
        'es=556'#39' as ActionDetails union all  Select 577 as ImageIndex ,  ' +
        #39'General\Module\dmMainGUI.actProductstoExcludeDefaultTaxCode=577' +
        #39' as ActionDetails union all  Select 569 as ImageIndex ,  '#39'Gener' +
        'al\Module\dmMainGUI.actEBayOrders=569'#39' as ActionDetails union al' +
        'l  Select 570 as ImageIndex ,  '#39'General\Module\dmMainGUI.actEBay' +
        'SalesOrders=570'#39' as ActionDetails union all  Select 387 as Image' +
        'Index ,  '#39'General\Module\dmMainGUI.actAuseParcelconf=387'#39' as Act' +
        'ionDetails union all  Select 435 as ImageIndex ,  '#39'General\Modul' +
        'e\dmMainGUI.actSalesTaxReport=435'#39' as ActionDetails union all  S' +
        'elect 592 as ImageIndex ,  '#39'General\Module\dmMainGUI.actCleanDat' +
        'abase=592'#39' as ActionDetails union all  Select 640 as ImageIndex ' +
        ',  '#39'General\Module\dmMainGUI.actWeeklysalesreport=640'#39' as Action' +
        'Details union all  Select 473 as ImageIndex ,  '#39'General\Module\d' +
        'mMainGUI.actFxTrading=473'#39' as ActionDetails union all  Select 47' +
        '5 as ImageIndex ,  '#39'General\Module\dmMainGUI.actFxTradingList=47' +
        '5'#39' as ActionDetails union all  Select 593 as ImageIndex ,  '#39'Gene' +
        'ral\Module\dmMainGUI.actummarySheets=593'#39' as ActionDetails union' +
        ' all  Select 591 as ImageIndex ,  '#39'General\Module\dmMainGUI.actS' +
        'ummarySheets=591'#39' as ActionDetails union all  Select 476 as Imag' +
        'eIndex ,  '#39'General\Module\dmMainGUI.actcolorPrefs=476'#39' as Action' +
        'Details union all  Select 262 as ImageIndex ,  '#39'General\Module\d' +
        'mMainGUI.actSMSList=262'#39' as ActionDetails union all  Select 635 ' +
        'as ImageIndex ,  '#39'General\Module\dmMainGUI.actEmailedReports=635' +
        #39' as ActionDetails union all  Select 320 as ImageIndex ,  '#39'Gener' +
        'al\Module\dmMainGUI.actProductReportByPeriod=320'#39' as ActionDetai' +
        'ls union all  Select 471 as ImageIndex ,  '#39'General\Module\dmMain' +
        'GUI.actCAR=471'#39' as ActionDetails union all  Select 468 as ImageI' +
        'ndex ,  '#39'General\Module\dmMainGUI.actCarList=468'#39' as ActionDetai' +
        'ls union all  Select 389 as ImageIndex ,  '#39'General\Module\dmMain' +
        'GUI.actPayHoursList=389'#39' as ActionDetails union all  Select 625 ' +
        'as ImageIndex ,  '#39'General\Module\dmMainGUI.actStockValue=625'#39' as' +
        ' ActionDetails union all  Select 378 as ImageIndex ,  '#39'General\M' +
        'odule\dmMainGUI.actProductBuyPriceList=378'#39' as ActionDetails uni' +
        'on all  Select 580 as ImageIndex ,  '#39'General\Module\dmMainGUI.DN' +
        'MAction1=580'#39' as ActionDetails union all  Select 436 as ImageInd' +
        'ex ,  '#39'General\Module\dmMainGUI.actRefundSalesList=436'#39' as Actio' +
        'nDetails union all  Select 511 as ImageIndex ,  '#39'General\Module\' +
        'dmMainGUI.actSupplierSkillList=511'#39' as ActionDetails union all  ' +
        'Select 369 as ImageIndex ,  '#39'General\Module\dmMainGUI.actEmploye' +
        'eTaxList=369'#39' as ActionDetails union all  Select 359 as ImageInd' +
        'ex ,  '#39'General\Module\dmMainGUI.actPaymentMethodList=359'#39' as Act' +
        'ionDetails union all  Select 564 as ImageIndex ,  '#39'General\Modul' +
        'e\dmMainGUI.actPaymentMethod=564'#39' as ActionDetails union all  Se' +
        'lect 636 as ImageIndex ,  '#39'General\Module\dmMainGUI.actClientMai' +
        'nContacts=636'#39' as ActionDetails union all  Select 286 as ImageIn' +
        'dex ,  '#39'General\Module\dmMainGUI.actShippingList=286'#39' as ActionD' +
        'etails union all  Select 677 as ImageIndex ,  '#39'General\Module\dm' +
        'MainGUI.actSalesAddressLabelPrn=677'#39' as ActionDetails union all ' +
        ' Select 678 as ImageIndex ,  '#39'General\Module\dmMainGUI.actsingle' +
        'SalesAddressLabelPrn=678'#39' as ActionDetails union all  Select 579' +
        ' as ImageIndex ,  '#39'General\Module\dmMainGUI.actPOsInvoicedBefore' +
        'Order=579'#39' as ActionDetails union all  Select 557 as ImageIndex ' +
        ',  '#39'General\Module\dmMainGUI.actExpenseClaimRequest=557'#39' as Acti' +
        'onDetails union all  Select 641 as ImageIndex ,  '#39'General\Module' +
        '\dmMainGUI.actSmartOrderRFQs=641'#39' as ActionDetails union all  Se' +
        'lect 419 as ImageIndex ,  '#39'General\Module\dmMainGUI.actImportSto' +
        'ckAdjustment=419'#39' as ActionDetails union all  Select 420 as Imag' +
        'eIndex ,  '#39'General\Module\dmMainGUI.actExportStockAdjustment=420' +
        #39' as ActionDetails union all  Select 416 as ImageIndex ,  '#39'Gener' +
        'al\Module\dmMainGUI.actInventoryAssetVsStockStauts=416'#39' as Actio' +
        'nDetails union all  Select 629 as ImageIndex ,  '#39'General\Module\' +
        'dmMainGUI.actInventoryAsset=629'#39' as ActionDetails union all  Sel' +
        'ect 293 as ImageIndex ,  '#39'General\Module\dmMainGUI.actAreaPOLine' +
        'sDetailsList=293'#39' as ActionDetails union all  Select 578 as Imag' +
        'eIndex ,  '#39'General\Module\dmMainGUI.actUOMList=578'#39' as ActionDet' +
        'ails union all  Select 437 as ImageIndex ,  '#39'General\Module\dmMa' +
        'inGUI.actInt_ATO=437'#39' as ActionDetails union all  Select 438 as ' +
        'ImageIndex ,  '#39'General\Module\dmMainGUI.actInt_AustPostParcel=43' +
        '8'#39' as ActionDetails union all  Select 647 as ImageIndex ,  '#39'Gene' +
        'ral\Module\dmMainGUI.actInt_CanadaPost=647'#39' as ActionDetails uni' +
        'on all  Select 447 as ImageIndex ,  '#39'General\Module\dmMainGUI.ac' +
        'tInt_CustomerPortal=447'#39' as ActionDetails union all  Select 643 ' +
        'as ImageIndex ,  '#39'General\Module\dmMainGUI.actInt_Cytrack=643'#39' a' +
        's ActionDetails union all  Select 434 as ImageIndex ,  '#39'General\' +
        'Module\dmMainGUI.actInt_Ebay=434'#39' as ActionDetails union all  Se' +
        'lect 440 as ImageIndex ,  '#39'General\Module\dmMainGUI.actInt_Eftpo' +
        's=440'#39' as ActionDetails union all  Select 454 as ImageIndex ,  '#39 +
        'General\Module\dmMainGUI.actInt_FedEx=454'#39' as ActionDetails unio' +
        'n all  Select 442 as ImageIndex ,  '#39'General\Module\dmMainGUI.avt' +
        'Int_Fuel=442'#39' as ActionDetails union all  Select 444 as ImageInd' +
        'ex ,  '#39'General\Module\dmMainGUI.actInt_GoogleCalendar=444'#39' as Ac' +
        'tionDetails union all  Select 448 as ImageIndex ,  '#39'General\Modu' +
        'le\dmMainGUI.actInt_GoogleAnalytics=448'#39' as ActionDetails union ' +
        'all  Select 439 as ImageIndex ,  '#39'General\Module\dmMainGUI.actIn' +
        't_PNET=439'#39' as ActionDetails union all  Select 441 as ImageIndex' +
        ' ,  '#39'General\Module\dmMainGUI.actInt_OPOS=441'#39' as ActionDetails ' +
        'union all  Select 446 as ImageIndex ,  '#39'General\Module\dmMainGUI' +
        '.actInt_ShoppingCart=446'#39' as ActionDetails union all  Select 451' +
        ' as ImageIndex ,  '#39'General\Module\dmMainGUI.actInt_SMS=451'#39' as A' +
        'ctionDetails union all  Select 646 as ImageIndex ,  '#39'General\Mod' +
        'ule\dmMainGUI.actInt_Telstra=646'#39' as ActionDetails union all  Se' +
        'lect 642 as ImageIndex ,  '#39'General\Module\dmMainGUI.actInt_TNT=6' +
        '42'#39' as ActionDetails union all  Select 450 as ImageIndex ,  '#39'Gen' +
        'eral\Module\dmMainGUI.actInt_UPS=450'#39' as ActionDetails union all' +
        '  Select 452 as ImageIndex ,  '#39'General\Module\dmMainGUI.actInt_U' +
        'SPS=452'#39' as ActionDetails union all  Select 445 as ImageIndex , ' +
        ' '#39'General\Module\dmMainGUI.actInt_Web=445'#39' as ActionDetails unio' +
        'n all  Select 644 as ImageIndex ,  '#39'General\Module\dmMainGUI.act' +
        'Int_XML=644'#39' as ActionDetails union all  Select 755 as ImageInde' +
        'x ,  '#39'General\Module\dmMainGUI.actInt_WalMart=755'#39' as ActionDeta' +
        'ils union all  Select 756 as ImageIndex ,  '#39'General\Module\dmMai' +
        'nGUI.actInt_Target=756'#39' as ActionDetails union all  Select 757 a' +
        's ImageIndex ,  '#39'General\Module\dmMainGUI.actInt_Sony=757'#39' as Ac' +
        'tionDetails union all  Select 758 as ImageIndex ,  '#39'General\Modu' +
        'le\dmMainGUI.actInt_Seagate=758'#39' as ActionDetails union all  Sel' +
        'ect 759 as ImageIndex ,  '#39'General\Module\dmMainGUI.actInt_Erico=' +
        '759'#39' as ActionDetails union all  Select 529 as ImageIndex ,  '#39'Ge' +
        'neral\Module\dmMainGUI.actCustomAccountsReport=529'#39' as ActionDet' +
        'ails union all  Select 530 as ImageIndex ,  '#39'General\Module\dmMa' +
        'inGUI.actCustomAccountsReportTree=530'#39' as ActionDetails union al' +
        'l  Select 540 as ImageIndex ,  '#39'General\Module\dmMainGUI.actCloc' +
        'kedOnList=540'#39' as ActionDetails union all  Select 553 as ImageIn' +
        'dex ,  '#39'General\Module\dmMainGUI.actRosterBreakList=553'#39' as Acti' +
        'onDetails union all  Select 587 as ImageIndex ,  '#39'General\Module' +
        '\dmMainGUI.actProductPriceList=587'#39' as ActionDetails union all  ' +
        'Select 0 as ImageIndex ,  '#39'General\Module\dmMainGUI.actERPTip=0'#39 +
        ' as ActionDetails union all  Select 628 as ImageIndex ,  '#39'Genera' +
        'l\Module\dmMainGUI.actsalesdispatch=628'#39' as ActionDetails union ' +
        'all  Select 632 as ImageIndex ,  '#39'General\Module\dmMainGUI.actSa' +
        'lesDispatches=632'#39' as ActionDetails union all  Select 584 as Ima' +
        'geIndex ,  '#39'General\Module\dmMainGUI.actSalesDispatchBatches=584' +
        #39' as ActionDetails union all  Select 388 as ImageIndex ,  '#39'Gener' +
        'al\Module\dmMainGUI.actProjectInstallations=388'#39' as ActionDetail' +
        's) as UsedNumbers on Allnumbers.ImageIndex= UsedNumbers.imageInd' +
        'ex   group by Allnumbers.ImageIndex  having TimesUSed > 1  Order' +
        ' by ImageIndex , TimesUSed')
    BeforeOpen = qryimageIndexesBeforeOpen
    OnCalcFields = qryimageIndexesmultiusedCalcFields
    Left = 840
    Top = 360
    object qryimageIndexesmultiusedImageIndex: TLargeintField
      DisplayWidth = 15
      FieldName = 'ImageIndex'
    end
    object qryimageIndexesmultiusedTimesUSed: TLargeintField
      DisplayWidth = 15
      FieldName = 'TimesUSed'
    end
    object qryimageIndexesmultiusedActionDetails: TWideStringField
      FieldName = 'ActionDetails'
      Size = 341
    end
    object qryimageIndexesmultiusedDetails: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Details'
      Size = 255
      Calculated = True
    end
  end
  object dsimageIndexesmultiused: TDataSource
    DataSet = qryimageIndexesmultiused
    Left = 880
    Top = 360
  end
  object ActionList1: TActionList
    Left = 604
    Top = 208
    object actTest: TDNMAction
      Category = 'DNMAction'
      OnExecute = actTestExecute
      buttoncolor = clWhite
    end
  end
end
