%% LiDAR Treedection
% 
% This toolbox provides an opensource approach to detect and separate single
% trees from LiDAR point clouds. There is a interface version, where the all the
% steps can be manually controlled, and a fixed version in which the open parameters
% can be choosen in the beginning.

%% Adding Toolbox to Search Path
%
% In order to use the toolbox all functions need to be added to the search path.

addtoolbox2path();

%% Edit Parameter
%
% In this section the version and the parameters of the toolbox are defined
% and safed as structure "Info". Therefore the function variable_setup() works
% with a gui including uicontrol styles 'edit' and 'popup'.

Info = variable_setup();

%% Loading .las files
%
% The function select_data() uses the uigetdir() function to open a gui in which
% the .las files to be loaded can be marked. The selected files will be loaded
% and seperated individually. (if one works with a cluster you could apply parallel
% computing in this step for loop)

Info = select_data(Info);

%% Run over all selected Patches
%
for Patch_Nr = 1:size(Info.Tile_Names,2)
    try
        %% Loading the .las files
        %
        % If the surrounding Patches should be included, the files need to be name
        % with an ascending Patchnr directly before the .las ending. (eg. xy001.las, xy002.las)
        % The id should ascend in the Easting and then the Northing.
        %   007,008,009
        %   004,005,006
        %   001,002,003
        % otherwise the wrong Patches will be loaded.

        [Data,Info] = load_las(Info,Patch_Nr);

        %% Running the Quad approach to generate DTM and CHM and to determine Vegetation Points from Ground Points
        %
        % In this step the 'Data' variable is used as input for the point
        % classification function, which determines if a point is either
        % ground or vegetation. In the process a DTM is generated and saved
        % in the Output/Mat folder.
        %
        % Amount of iterations determine the resolution. The slopefactor
        % defines in combination with the cell resolution the threshold at 
        % at which a point is a ground- or a vegetation point.
        %
        % The Output structure PtCl contains the vegetation point cells and
        % the DTM Matrix. It is possible to add the ground point cells, the
        % highest points and the CHM by altering the lasDataVPGPClassifier
        % function.
        
        [PtCl,Info]             = lasDataVpGpClassifier(Data,Info);

        saveMat(PtCl.DTM,strcat('DTM_',num2str(Patch_Nr)),'Mat');
        
        clear Data

        %% Running a Voxel Filter over the Vegetation Points
        %
        % If one wants to reduce the amount of point, it is possible to run
        % the voxel generation function. 
        % The height of the voxel can be chosen in the gui for the
        % interface version, or in the setup for the fixed version.
        % If the voxelfilter is not applied the vegetation points are saved
        % as 'Voxel_Points'.
        
        [Voxel_Points,Info]     = lasDataVoxelGenerator(PtCl,Info);
        
        clear PtCl

        %% Filtering the Vegetation Points in order to detect the Trunks
        %
        % The goal of the first filtering process is to reduce the Point
        % Cloud to the points representing the stems. The output of the
        % function is saved in the Info structure as a binary array.

        Info = PtCl_filtering(Voxel_Points,Info,'stem');

        %% Clustering the individual Trunks
        %
        % The points which remained after the filtering in the step before
        % are now clustered. Therefore a graph is build and the connected
        % compartments of the graph are the new clusters. 
        %
        % The parameters of this step are the weights (xyz), which enable
        % the prioritizing of one direction, the maximal edge weight of the
        % graph, which determines the maximal distance whithin which two
        % points are connected and the minimal cluster size which enables
        % the filtering of the small cluster which do not represent a
        % trunk. All point whithin such a cluster receive an id.
        %
        % These clusters will later be used as seeds for the tree
        % separation.
        %
        % The clustered stems are saved as .mat in the Output/Mat folder.

        [Voxel_Points,Info] = trunk_clustering(Voxel_Points,Info);

        [Voxel_Points]      = trunkmeasures(Voxel_Points,Info);
        
        saveMat(Voxel_Points(Info.bin_Stems,:),strcat('Trunk_Cloud_',num2str(Patch_Nr)),'Mat'); 
        
        %% Displaying the clustered Trunks

        Plotting_data('Forest',Voxel_Points(Voxel_Points.Cluster_Nr > 0,:),{'Easting','Northing','AboveSea','Cluster_Nr'},'lines',Info)

        %% Filtering the Vegetation Points in the crown area
        %
        % The second filtering removes all points which should not be used
        % in the tree separation function. The goal is to remove all point
        % which do not represent a structural element of the trees.
        
        Info = PtCl_filtering(Voxel_Points,Info,'crown');

        %% Running the Graph Model to seperate the individual Trees
        % 
        % The growing_Forest_UAV function separates all output points from
        % the second filtering step using the seeds from the first
        % filtering and clustering step.
        % It again generates a graph with a maximal edgeweight (distance 
        % between two points) and then calculates the shortest path from 
        % each pointwithin this graph to all the seed points. The distances
        % will then be compared and the points are assigned to their
        % nearest seed.
        % It is possible to alter the edgeweight in order to favour smaller
        % jumps.

        Voxel_Points.Tree_Id(:) = 0;

        [Voxel_Points.Tree_Id(Info.bin_Crown|Info.bin_Stems),Info] = growing_Forest_UAV(Voxel_Points(Info.bin_Crown|Info.bin_Stems,:),Info);

        %% Filter the Trees by Height
        % In this step the separated trees are filtered by two parameters:
        % First their total height and second their lowest point. 
        % The total height is used to remove shrubs and the lowest points
        % to remove clusters of trees that are not connected to the ground.

        Forest = filtering_forest(Voxel_Points,10,1);
        saveMat(Forest,strcat('Forest_Cloud_',num2str(Patch_Nr)),'Mat');        
        
        Plotting_data('Forest',Forest(Forest.Tree_Id > 0,:),{'Easting','Northing','AboveSea','Tree_Id'},'lines',Info)    
        try
            assign2las(Info,Patch_Nr,Forest,'Scientifica_flat','flat');
            assign2las(Info,Patch_Nr,Forest,'Scientifica_org','org');
        catch
        end
        
        %% Calculating Measures
        % Calculating forest measures creates a structure for each tree
        % containing the information about the trunk position, the DBH, the
        % distance to the edge of the research area and the pointcloud.
        % The structure will then be save as in the Output/Temp folder.
        
        Forest_Measures = forest_measures(Forest,Voxel_Points);
        
        saveMat(Forest_Measures,strcat('Forest_Measures_',num2str(Patch_Nr)),'Temp');

        switch Info.QSM 
            % The QSM from Raumonen et al. (2013) can by applied on each
            % separated tree. Therefore the parameters of the QSM
            % generation have to be adjusted in the runRaumonen function.
            
            case 'yes'
                QSM = runRaumonen(Forest);
                saveMat(QSM,strcat('QSM_',num2str(Patch_Nr)),'QSM');
        end
    catch
    end
end

%% Combining all Patches
% The Forest Measures of each Patch are loaded and combined to the
% Forest_Patches. 
% In combining_Patches the trees with a minimal distance to the edge of the
% research site. In case that the surrounding patches are loaded the
% minimal distance is 10. If just one file is loaded the minimal distance
% can be chosen additionally.

Forest_Patches      = load_Forest_Patches;
[TreeData,Cloud]    = combining_Patches(Forest_Patches,Info,2);

Plotting_data('Forest',Cloud,{'Easting','Northing','AboveSea','Forest_Id'},'lines',Info);

%% saving Output



saveMat(Cloud,'Forest_Cloud','Mat');
saveMat(TreeData,'Tree_Data','Mat');


