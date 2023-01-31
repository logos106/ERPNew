unit DbConst;

interface

{$IfDef VER220}
uses
  MyClasses;
{$EndIf}

const
  SYSDB_PASS = '1w$p&LD07';
  SYSDB_USER = 'P_One';
  SERVER_PORT = 3309;
  MYDAC_OPTIONS_COMPRESS = false;
  {$IfDef VER220}
  MYDAC_OPTIONS_PROTOCOL = mpDefault;
  {$EndIf}
  SERVICES_DATABASE = 'services';
  MYSQL_DATABASE = 'mysql';
  UPDATES_DATABASE = 'serverupdates';
  LANGUAGE_DATABASE = 'erplanguages';
  ErpDocumentationDBName = 'ERPDocumentaion';

  REPORTING_DB_SUFIX    = '_EXP_DB';//'ERP_Export';
  REPORTING_DB_USER    = 'Export';
  REPORTING_DB_USER_PASS = 'Export';

implementation

end.
