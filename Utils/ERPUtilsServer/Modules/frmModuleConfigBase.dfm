object fmModuleConfigBase: TfmModuleConfigBase
  Left = 309
  Top = 396
  Caption = 'fmModuleConfigBase'
  ClientHeight = 448
  ClientWidth = 772
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 15
  object pnlMain: TPanel
    Left = 0
    Top = 55
    Width = 772
    Height = 393
    Align = alClient
    BevelOuter = bvNone
    Color = clActiveBorder
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      772
      393)
    object pnlTitle: TDNMPanel
      Left = 106
      Top = 12
      Width = 559
      Height = 35
      Anchors = [akTop]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 557
        Height = 33
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
        object lblTitle: TLabel
          Left = 0
          Top = 0
          Width = 557
          Height = 33
          Align = alClient
          Alignment = taCenter
          AutoSize = False
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
  end
  object pnlModuleButtons: TPanel
    Left = 0
    Top = 0
    Width = 772
    Height = 55
    Align = alTop
    Color = clActiveBorder
    TabOrder = 1
    object btnModule: TSpeedButton
      Left = 0
      Top = 0
      Width = 72
      Height = 55
      Caption = 'Config Main'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        C2040000424DC204000000000000420000002800000018000000180000000100
        10000300000080040000202E0000202E00000000000000000000007C0000E003
        00001F000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
        FF7FFF7FFF7FBF7BFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
        FF7FFF7FFF7FFF7FFF7FFF7FBF77FB5EBB5A5A4E99351525733178529E77FF7F
        FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FDA7F947B927F6E7F6C77D4413508
        73105410751493144E080E0052293353DC73FF7FFF7FDE7FB57A30728D750969
        CF610977627B237B437F01736E317810D620F62016251625F11C721CEE14E105
        E519575FFF7F9C7B63680068436C2364004C8572A77F477B677F2677B03DD918
        1625162516251525F120B3203021661E6001A411DD77BE7F096D656CE870A768
        8658C776A77F477B677F0573D03DD81C36253625362535251221B32050218622
        A30D061EDD77DF7F6C71646CE770A76C87580877C67F247F667F257FD041F91C
        36293629372936291221D3247125A61EC20D071EDD77FF7F8E718468E76CE86C
        A758C5582D6EB373485B0657D1351A29572D572D572D372D3125F3249025C722
        03122822DD77FF7FF075866CE970086DE758024C5069FF6BCB1AE71AF1293931
        773177317731562D3225F424B129E82624164822DD77FF7F3276A6700975096D
        E8588450AE69FE73EC2AE726F1313935773177317735763153291429B22DC826
        23128826DD77FF7F7376A6702971296D08598450CF69FF770D33072B32365A35
        9735973598359835522D132DB22DC92A4516892ADD77FF7F957AA7702A752A71
        0959A550D069FE770E37092F32367A39B839B839B839B7357331332DB3350B33
        6412671EDD77FF7FB57AC86C2B754B71295DA654F16DFE770E370A33533A9A39
        B839B839B839B73993315535B335E8264002A926DE7BFF7FB576E86C4A754B71
        2959C654116AFF77303B2A33353E7E41B939D839D93DD939B4351325932D0C37
        0F3FDC73FF7FFF7FB47A08716B796B752A5DC654116AFF77303F2D3BAF36F435
        DA3D9A39793578351221732D1B67FE7FFF7FFF7FFF7FFF7FD57A09758C796C75
        2A5DA654326EFF7B0E3BEF3E0B33C312324B3F6FDC5A394A784E9D73FF7FFF7F
        FF7FFF7FFF7FFF7FD67A2B758D798D754B5DE754536EFF7F524FCD3AC9264002
        5047FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FB67A2A75AD79AD75
        4B5DE854536EFF7FFF7FBA6B30473047BB6FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
        FF7FFF7FFF7FFF7FD67AE7748D79CE756B5DE754736AFF7FFF7FFF7FFF7FFF7F
        FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F9C7F117A4C794B75
        0859A550946AFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
        FF7FFF7FFF7FFF7FFF7FFF7F7C7F7376326A1873DE7BFF7FFF7FFF7FFF7FFF7F
        FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
        FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
        FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
        FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
        FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
        FF7FFF7FFF7F}
      Layout = blGlyphTop
      ParentFont = False
      OnClick = btnModuleClick
    end
  end
end
