drop table if exists `tclientconfig`;
create table `tclientconfig` (
  `id` int(11) not null auto_increment,
  `active` enum('T','F') default 'F',
  `name` varchar(255) default null,
  `datetime` datetime default null,
  `user` varchar(255) default null,
  `softwarereleasetype` varchar(255) default NULL,
  primary key  (`id`)
) ENGINE=InnoDB;

drop table if exists `tcomputer`;
create table `tcomputer` (
  `id` int(11) not null auto_increment,
  `clientid` int(11) default null,
  `active` enum('T','F') default 'F',
  `computername` varchar(255) default null,
  `notes` text,
  `datetime` datetime default null,
  `user` varchar(255) default null,
  primary key  (`id`),
  key `client_idx` (`clientid`)
) ENGINE=InnoDB;

drop table if exists `tcomputerconfig`;
create table `tcomputerconfig` (
  `id` int(11) not null auto_increment,
  `computerid` int(11) default null,
  `active` enum('T','F') default 'F',
  `text` text,
  `notes` text,
  `datetime` datetime default null,
  `user` varchar(255) default null,
  primary key  (`id`),
  key `computer_idx` (`computerid`)
) ENGINE=InnoDB;

drop table if exists `tsoftwarelicence`;
create table `tsoftwarelicence` (
  `id` int(11) not null auto_increment,
  `clientid` int(11) default null,
  `computerid` int(11) default null,
  `active` enum('T','F') default 'F',
  `softwarename` varchar(255) default null,
  `startdate` datetime default null,
  `expiredate` datetime default null,
  `concurrentusers` int(11) default null,
  `status` varchar(255) default null,
  `statusreason` varchar(255) default null,
  `datatext` text,
  `notes` text,
  `datetime` datetime default null,
  `user` varchar(255) default null,
  primary key  (`id`),
  key `client_idx` (`clientid`),
  key `computer_idx` (`computerid`)

) ENGINE=InnoDB;