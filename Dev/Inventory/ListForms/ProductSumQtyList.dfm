inherited ProductSumQtyListGUI: TProductSumQtyListGUI
  Left = 421
  Top = 175
  Caption = 'Product Qty API List'
  ExplicitLeft = 421
  ExplicitTop = 175
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 1711002
  inherited HeaderPanel: TPanel
    HelpContext = 1711007
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
    inherited pnlHeader: TPanel
      Anchors = []
      HelpContext = 1711008
      inherited TitleShader: TShader
        inherited TitleLabel: TLabel
          Caption = 'Product Qty API List'
          HelpContext = 1711003
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 1711009
      inherited grpFilters: TwwRadioGroup
        ItemIndex = 1
        Columns = 2
        Items.Strings = (
          'With Quantity'
          'All')
        Visible = False
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      Height = 22
      ExplicitHeight = 22
      HelpContext = 1711004
    end
    inherited dtTo: TwwDBDateTimePicker
      Height = 22
      ExplicitHeight = 22
      HelpContext = 1711005
    end
  end
  inherited Panel1: TPanel
    HelpContext = 1711010
    inherited grdMain: TwwDBGrid
      Selected.Strings = (
        'partname'#9'20'#9'Product'
        'ClassName'#9'20'#9'Department'
        'UOM'#9'20'#9'UOM'
        'ason'#9'17'#9'Quantity As On'
        'Available'#9'10'#9'Available'
        'AllocatedSO'#9'10'#9'AllocatedSO'
        'InStock'#9'10'#9'InStock'
        'InvBO'#9'10'#9'AllocatedBO'
        'POBO'#9'10'#9'OnOrder'
        'OnBuild'#9'10'#9'OnBuild'
        'Building'#9'10'#9'Building'
        'OnTransitin'#9'10'#9'OnTransit'
        'OnTransitOut'#9'10'#9'OnTransit'
        'SOBO'#9'10'#9'SOBackOrders'
        'ProductId'#9'10'#9'ProductId')
      TitleLines = 2
    end
  end
  inherited FooterPanel: TDNMPanel
    HelpContext = 1711011
    inherited cmdNew: TDNMSpeedButton
      Enabled = False
    end
    inherited chkAdvancedPrinting: TCheckBox
      Anchors = [akLeft]
      Visible = False
    end
    object btnSnch: TDNMSpeedButton
      Left = 517
      Top = 30
      Width = 87
      Height = 27
      Anchors = [akBottom]
      Caption = 'Synch'
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
      TabOrder = 9
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnSnchClick
      HelpContext = 1711006
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'SELECT '
      'PQs.ProductId as ProductId,'
      'P.Partname AS partname, '
      'C.ClassName AS ClassName, '
      'CONCAT(UOM.UnitName , "(" , UOM.Multiplier, ")") AS UOM, '
      'PQs.InStock AS InStock,'
      'PQs.Available AS Available, '
      'PQs.AllocatedSO AS AllocatedSO, '
      'PQs.POBO AS POBO,'
      'PQs.SOBO AS SOBO, '
      'PQs.InvBO AS InvBO, '
      'PQs.OnBuild AS OnBuild, '
      'PQs.Building AS Building, '
      'PQs.OnTransitin + PQs.OnTransitOut AS OnTransit,'
      'PQs.msTimestamp AS ason '
      ' FROM '
      'tblProductQtySum PQS'
      'INNER  JOIN tblparts P ON P.partsId = PQS.productID'
      'INNER JOIN tblclass C ON C.classid = PQS.DepartmentId'
      'INNER JOIN tblunitsofmeasure UOM ON UOM.UnitID = PQS.UOMID'
      'ORDER BY Partname, classname,uom , ason DESC')
    object qryMainpartname: TWideStringField
      DisplayLabel = 'Product'
      DisplayWidth = 20
      FieldName = 'partname'
      Origin = 'P.PARTNAME'
      Size = 255
    end
    object qryMainClassName: TWideStringField
      DisplayLabel = 'Department'
      DisplayWidth = 20
      FieldName = 'ClassName'
      Origin = 'C.ClassName'
      Size = 60
    end
    object qryMainUOM: TWideStringField
      DisplayWidth = 20
      FieldName = 'UOM'
      Origin = 'UOM'
      Size = 39
    end
    object qryMainason: TDateTimeField
      DisplayLabel = 'Quantity As On'
      DisplayWidth = 17
      FieldName = 'ason'
      Origin = 'PQS.msTimestamp'
    end
    object qryMainAvailable: TFloatField
      DisplayWidth = 10
      FieldName = 'Available'
      Origin = 'PQS.Available'
    end
    object qryMainAllocatedSO: TFloatField
      DisplayWidth = 10
      FieldName = 'AllocatedSO'
      Origin = 'PQS.AllocatedSO'
    end
    object qryMainInStock: TFloatField
      DisplayWidth = 10
      FieldName = 'InStock'
      Origin = 'PQS.InStock'
    end
    object qryMainInvBO: TFloatField
      DisplayLabel = 'AllocatedBO'
      DisplayWidth = 10
      FieldName = 'InvBO'
      Origin = 'PQS.InvBO'
    end
    object qryMainPOBO: TFloatField
      DisplayLabel = 'OnOrder'
      DisplayWidth = 10
      FieldName = 'POBO'
      Origin = 'PQS.POBO'
    end
    object qryMainOnBuild: TFloatField
      DisplayWidth = 10
      FieldName = 'OnBuild'
      Origin = 'PQS.OnBuild'
    end
    object qryMainBuilding: TFloatField
      DisplayWidth = 10
      FieldName = 'Building'
      Origin = 'PQS.Building'
    end
    object qryMainOnTransit: TFloatField
      DisplayWidth = 10
      FieldName = 'OnTransit'
      Origin = 'OnTransit'
      Visible = False
    end
    object qryMainSOBO: TFloatField
      DisplayLabel = 'SOBackOrders'
      DisplayWidth = 10
      FieldName = 'SOBO'
      Origin = 'PQS.SOBO'
    end
    object qryMainProductId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductId'
      Origin = 'PQS.ProductId'
    end
  end
  object QryProgress: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      
        'SELECT ID, Progresscode,Progressmsg FROM tblProductQtySumProgres' +
        's ORDER BY id desc LIMIT 1;')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Left = 371
    Top = 328
    object QryProgressProgressmsg: TWideStringField
      FieldName = 'Progressmsg'
      Size = 255
    end
    object QryProgressID: TIntegerField
      FieldName = 'ID'
    end
    object QryProgressProgresscode: TIntegerField
      FieldName = 'Progresscode'
    end
  end
end
