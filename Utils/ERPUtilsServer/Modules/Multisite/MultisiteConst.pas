unit MultisiteConst;

interface

type

  TMultisiteStatus = (msInactive, msActive, msStarting, msStopping, msRestarting);
  TDataSynchronizeType = (dstReadFromRemote, dstWriteToRemote);


const
  MS_Change_Log_Table = 'tblMSChangeLog';
  Remote_MS_Change_Log_Table = 'tblRemoteMSChangeLog';


implementation

end.
