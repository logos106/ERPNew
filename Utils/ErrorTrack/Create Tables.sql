DROP TABLE IF EXISTS exceptions;

CREATE TABLE exceptions (
  Id int(11) NOT NULL auto_increment,
  DateTime datetime default NULL,
  VersionNo varchar(255) default NULL,
  Company varchar(255) default NULL,
  User varchar(255) default NULL,
  PCName varchar(255) default NULL,
  FocusedForm varchar(255) default NULL,
  FocusedControl varchar(255) default NULL,
  ErrorType varchar(255) default NULL,
  ExceptionName varchar(255) default NULL,
  ModuleName varchar(255) default NULL,
  ErrorText longtext default NULL,
  Notes text default NULL,
  IsFixed enum("T","F") NOT NULL default "F",
  PRIMARY KEY  (Id),
  KEY VersionIdx (VersionNo)
) ENGINE=MyISAM;
