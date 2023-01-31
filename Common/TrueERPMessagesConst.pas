unit TrueERPMessagesConst;

interface

uses
  UpdaterConst, InstallConst;

const
  MessagesURL = UpdaterConst.WebUpdatesURL + 'server/custom/messages/';
  MessagesFilePrefix = 'messages_';

  function MessagesDir : string;

implementation
  function MessagesDir : string;
  begin
    Result := ERP_SERVER_ROOT_DIR + ERP_UTILITIES_DIR + 'Messages\';
  end;
end.
