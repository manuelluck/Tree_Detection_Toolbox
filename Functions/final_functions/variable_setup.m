function Info = variable_setup()
%% Info = variable_setup() is the main function of the Toolbox setup.
%   It takes the variables selected in the subfunction 'setup_dialog' and
%   puts them in the necessary Info structure. 
%
%   Variables:
%
% <b>Interface or fixed setup</b>
%     Info.setup                : 'interface' to use the gui
%                                 'fixed' to use the preselected parameters   
%     Info.QSM                  : 'yes'/'no' running the QSM by Raumonen et
%                                 al.
%     
% DTM generation
%     Info.iteration            : The amount of Iteration done in the Point
%                                 Classification/DTM generation.
%                                 10 results in 1024x1024 cells.
%     Info.slopefactor          : The slopefactor defines the range of
%                                 point considered as ground points,
%                                 depending on the cells extends.
%                                 steep terrain asks for high values (~10)
%                                 flat terrain works also with lower values
%     
% Voxel generation
%     Info.Voxel                : 'yes'/'no' whether to apply a
%                                  voxel generator
%     Info.voxel_height         : The height of the voxels
%     Info.VoxelSize            : min/max amount of points in each voxel
%     
% Filtering 4 Trunks
%     Info.stem_height          : min/max height for trunk detection
%     Info.stem_Easting         : min/max x
%     Info.stem_Northing        : min/max y
%     Info.stem_Intensity       : min/max intensity
%     Info.stem_RNNR            : min/max return number  
%     
% Trunk Clustering generation    
%     Info.trunk_max_edgeweight : maximal distance between two connected
%                                 nodes in the trunk detection graph
%     Info.trunk_weights        : weights for x,y,z
%     Info.trunk_min_cluster    : minimal amount of points in Trunk cluster
%     
% Filtering 4 Crowns    
%     Info.crown_height         : min/max height for tree separation
%     Info.crown_Easting        : min/max x
%     Info.crown_Northing       : min/max y
%     Info.crown_Intensity      : min/max intensity
%     Info.crown_RNNR           : min/max return number
%     
% Tree Separation    
%     Info.tree_max_edgeweight  : maximal distance between two connected
%                                 nodes in the tree separation graph
%     
% Patch Orientation
%     Info.Surrounding          : whether to include surrounding Patches
%     Info.Easting_Patches      : amount of patches in x
%     Info.Northing_Patches     : amount of patches in y  
%
% created by Manuel A. Luck (manuel.luck@gmail.com)

    
%% Code
    SetupData = setup_dialog;

% Interface or fixed setup
    Info.setup = cell2mat(SetupData{1,1});  % choose between 'interface' or 'fixed'
    Info.QSM   = cell2mat(SetupData{2,1});
    
% Setting for fixed setup
% DTM generation
    Info.iteration              = str2double(SetupData{3,1});
    Info.slopefactor            = str2double(SetupData{4,1});
    
% Voxel generation
    Info.Voxel                  = cell2mat(SetupData{19,1});
    Info.voxel_height           = str2double(SetupData{20,1});
    Info.VoxelSize              = [str2double(SetupData{21,1}),str2double(SetupData{21,2})];
    
% Filtering 4 Trunks
    Info.stem_height            = [str2double(SetupData{5,1}),str2double(SetupData{5,2})];
    Info.stem_Easting           = [str2double(SetupData{6,1}),str2double(SetupData{6,2})];
    Info.stem_Northing          = [str2double(SetupData{7,1}),str2double(SetupData{7,2})];
    Info.stem_Intensity         = [str2double(SetupData{8,1}),str2double(SetupData{8,2})];
    Info.stem_RNNR              = [str2double(SetupData{9,1}),str2double(SetupData{9,2})];  
    
% Trunk Clustering generation    
    Info.trunk_max_edgeweight   = str2double(SetupData{10,1});
    Info.trunk_weights          = [str2double(SetupData{11,1}),str2double(SetupData{11,2}),str2double(SetupData{11,3})];
    Info.trunk_min_cluster      = str2double(SetupData{12,1});
    
% Filtering 4 Crowns    
    Info.crown_height           = [str2double(SetupData{13,1}),str2double(SetupData{13,2})];
    Info.crown_Easting          = [str2double(SetupData{14,1}),str2double(SetupData{14,2})];
    Info.crown_Northing         = [str2double(SetupData{15,1}),str2double(SetupData{15,2})];
    Info.crown_Intensity        = [str2double(SetupData{16,1}),str2double(SetupData{16,2})];
    Info.crown_RNNR             = [str2double(SetupData{17,1}),str2double(SetupData{17,2})];   
    
% Tree Separation    
    Info.tree_max_edgeweight    = str2double(SetupData{18,1});
    
% Patch Orientation
    Info.Surrounding            = cell2mat(SetupData{24,1});
    Info.Easting_Patches        = str2double(SetupData{22,1});
    Info.Northing_Patches       = str2double(SetupData{23,1});   
    
end
