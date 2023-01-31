unit StSConst;

interface

uses
  Messages;

const
    STS_ACTION_CHANGE_GROWTH_PHASE 	  = 'Change Growth Phase';
    STS_ACTION_CREATE_PLANTINGS		    = 'Create Plantings';
    STS_ACTION_DESTROY_PLANTS		      = 'Destroy Plants';
    STS_ACTION_RECORD_ADDITIVES		    = 'Record Additives';
    STS_ACTION_RECORD_WASTE		        = 'Record Waste';
    STS_ACTION_TRANSFER		            = 'Transfer';
    STS_ACTION_MANICURE_PLANTS		    = 'Manicure Plants';
    STS_ACTION_CREATE_PACKAGES_PRODUCT= 'Create Packages (Product)';
    STS_ACTION_Harvesting             = 'Harvesting';
    STS_ACTION_REPLACE_TAGS		        = 'Replace Tags';
    STS_ACTION_CHANGE_ROOMS		        = 'Change Rooms';
    STS_ACTION_Use_Plant_Tag          = 'Use Plant Tag';
    STS_ACTION_Use_Package_Tag        = 'Use Package Tag';
    STS_ACTION_Harvest_Plant_Tag      = 'Harvest Plant Tag';
    STS_ACTION_Make_Plant             = 'Make Plant';
    STS_ACTION_ReUse_Plant            = 'Reuse Plant';
    STS_ACTION_TRANSFER_PACKAGES      = 'Transfer Packages';
    //STS_ACTION_Use_Plant              = 'Use Plant';
    STS_CAPTION                       = 'Seed To Sale';
    STS_SOURCE_TYPE_New_Growth_Phase  = 'New Growth Phase';
    STS_SOURCE_TYPE_TransferTo        = 'Transfered';
    STS_SOURCE_TYPE_TransferFrom      = 'Transfering';
    STS_METRC_Supplier                = 'Metrc';
    STS_BioTrackTHC_Supplier          = 'BioTrackTHC';
    STS_PACKAGE_TAG_PRODUCT           = 'Package Tag';
    STS_PACKAGE_PRODUCT               = 'Package';
    STS_PLANT_TAG_PRODUCT             = 'Plant Tag';
    STS_PLANT_STOCK_ACCOUNT           = 'StS Plant Stock';

    // Window messages
    WM_FORM_SHOW_COMPLETE = WM_USER + 32000; // available range from WM_USER through 0x7FFF




implementation

end.
