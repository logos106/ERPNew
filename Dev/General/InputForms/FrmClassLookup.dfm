inherited FmClassLookup: TFmClassLookup
  HelpContext = 1260002
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl: TPanel
    HelpContext = 1260003
    inherited Panel1: TPanel
      HelpContext = 1260004
      inherited cbo: TwwDBLookupCombo
        HelpContext = 1260003
      end
    end
  end
  inherited cboQry: TERPQuery
    SQL.Strings = (
      'SELECT ClassID id,ClassName name'
      'FROM tblClass'
      'WHERE tblClass.ClassName Is Not Null'
      
        'And (tblClass.Active<>'#39'F'#39'  or :ShowInactive ="T" or ClassId = :C' +
        'lassId )'
      'ORDER BY tblClass.ClassName;')
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ShowInactive'
      end
      item
        DataType = ftUnknown
        Name = 'ClassId'
      end>
  end
end
