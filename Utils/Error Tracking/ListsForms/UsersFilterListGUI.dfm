inherited UsersFilterList: TUsersFilterList
  Left = 206
  Top = 120
  Caption = 'Users Filter List'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TDNMPanel
    inherited grdMain: TwwDBGrid
      ControlType.Strings = (
        'DefaultFilter;CheckBox;True;False')
      Selected.Strings = (
        'FilterName'#9'35'#9'Filter Name'#9#9
        'ListName'#9'35'#9'List Name'#9#9
        'Filter'#9'15'#9'Filter'#9#9
        'DefaultFilter'#9'5'#9'Default'#9#9)
      object grdMainIButton: TwwIButton
        Left = 0
        Top = 0
        Width = 22
        Height = 23
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
        OnClick = grdMainIButtonClick
      end
    end
  end
  inherited HeaderPanel: TDNMPanel
    inherited Label1: TLabel
      Visible = False
    end
    inherited cboCustomFilter: TwwDBLookupCombo
      Visible = False
    end
    inherited pnlHeader: TPanel
      Caption = 'Users Filter List'
    end
  end
  inherited FooterPanel: TDNMPanel
    inherited cmdNew: TDNMSpeedButton
      Enabled = False
    end
  end
  inherited qryListData: TMyQuery
    SQL.Strings = (
      'select customfilterid,filtername,listname,filter,defaultfilter'
      'from customfilters '
      'where userid= :xid;')
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xID'
      end>
  end
  inherited qryCustomFilter: TMyQuery
    Left = 149
  end
end
