inherited CustomFieldValuesBaseGUI: TCustomFieldValuesBaseGUI
  Left = 452
  Top = 147
  HelpContext = 1569002
  Caption = 'Customisable List - '
  ExplicitLeft = 452
  ExplicitTop = 147
  PixelsPerInch = 96
  TextHeight = 13
  inherited HeaderPanel: TPanel
    HelpContext = 1569009
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
      Left = 198
      Width = 600
      HelpContext = 1569003
      ExplicitLeft = 198
      ExplicitWidth = 600
      inherited TitleShader: TShader
        Width = 598
        HelpContext = 1569004
        ExplicitWidth = 598
        inherited TitleLabel: TLabel
          Width = 598
          HelpContext = 1569005
          Caption = 'Customisable List - '
          ExplicitWidth = 598
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 1569010
      inherited lblcheck2: TLabel
        Left = 346
        ExplicitLeft = 346
      end
      inherited grpFilters: TwwRadioGroup
        Left = 350
        Width = 387
        HelpContext = 1569006
        ExplicitLeft = 350
        ExplicitWidth = 387
      end
      inherited pnlButtons: TPanel
        Width = 346
        HelpContext = 1569007
        ExplicitWidth = 346
        DesignSize = (
          346
          37)
        inherited cboCustomReports: TwwDBLookupCombo
          Width = 145
          HelpContext = 1569008
          Anchors = [akLeft, akTop, akRight]
          ExplicitWidth = 145
        end
      end
    end
  end
  inherited Panel1: TPanel
    HelpContext = 1569011
    inherited grdMain: TwwDBGrid
      GroupFieldName = 'MasterName'
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'Select '
      'CFVP.ID as ID, '
      'CFVP.masterID as MasterID, '
      'P.partname as MasterName , '
      'CFL.Description as Description , '
      'CFVP.Value as Value'
      'from '
      'tblcustomfieldvaluesproducts CFVP'
      'inner join tblparts P on CFVP.masterId = P.partsId '
      
        'inner join tblCustomfieldList CFL on CFL.CFID =  CFVP.CustomFiel' +
        'dlistId')
    object qryMainID: TIntegerField
      FieldName = 'ID'
    end
    object qryMainMasterID: TIntegerField
      FieldName = 'MasterID'
    end
    object qryMainMasterName: TWideStringField
      FieldName = 'MasterName'
      Size = 60
    end
    object qryMainDescription: TWideStringField
      FieldName = 'Description'
      Size = 255
    end
    object qryMainValue: TWideStringField
      FieldName = 'Value'
      Size = 255
    end
  end
  inherited MyConnection1: TERPConnection
    Server = 'Localhost'
  end
end
