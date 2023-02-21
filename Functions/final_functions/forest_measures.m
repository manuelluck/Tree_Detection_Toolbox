function Forest_Measures = forest_measures(Forest,Voxel_Points)
%  Forest_Measures = forest_measures(Forest)
% 
% 
    tree_ids        = unique(Forest.Tree_Id);
    Extremas(1,:)   = min(table2array(Forest(:,{'Easting','Northing'})),[],1);
    Extremas(2,:)   = max(table2array(Forest(:,{'Easting','Northing'})),[],1);
    
    Tree{size(tree_ids,1)-1} = [];
    
    for tree = 2:size(tree_ids,1)
        
        disp(tree)
        tree_PC = Forest(Forest.Tree_Id == tree_ids(tree,1),:);

% First Measure: Distance to Edge of Research Area
        Extremas_local(1,:) = min(table2array(tree_PC(:,{'Easting','Northing'})),[],1);
        Extremas_local(2,:) = max(table2array(tree_PC(:,{'Easting','Northing'})),[],1);
        distance2edges      = min(min(abs(Extremas(:,1:2)-Extremas_local(:,1:2))));
        
        Tree{tree-1}.Distance2Edge = distance2edges;
        
        subVoxel = Voxel_Points(Voxel_Points.Easting  <= Extremas_local(2,1)+0.2 &...
                                Voxel_Points.Easting  >= Extremas_local(1,1)-0.2 &...
                                Voxel_Points.Northing <= Extremas_local(2,2)+0.2 &...
                                Voxel_Points.Northing >= Extremas_local(1,2)-0.2, ...
                                :);
                            
        [ids,~]         = rangesearch(table2array(tree_PC(:,{'Easting','Northing','AboveSea'})),...
                                      table2array(subVoxel(:,{'Easting','Northing','AboveSea'})),0.2);
                            
        id_bin          = cell2mat(cellfun(@isempty,ids,'UniformOutput',false));
        
        enhancedCloud   = subVoxel(id_bin == 0,:);

% Second Measure: Stem Position
% 
% Extract all Points in the Trunk area.
% add forloop here for different height
        trunkPoints     = enhancedCloud(enhancedCloud.AboveDTM <= 2 & enhancedCloud.AboveDTM >= 1,:);
             
% Calculate mean position of all tunk points

        trunkPosition   = mean(table2array(trunkPoints(:,{'Easting','Northing','AboveDTM'})),1); 

% Third Measure: Diameter (~DBH)
% 
% Calculate the distances between trunk points and trunk position

        Tree{tree-1}.DBH            = max(mean(abs(trunkPoints.Easting-trunkPosition(1))), mean(abs(trunkPoints.Northing-trunkPosition(2))));   
        Tree{tree-1}.height         = max(enhancedCloud.AboveDTM);
        Tree{tree-1}.Position       = trunkPosition;
        enhancedCloud.Tree_Id(:)    = tree-1;
        enhancedCloud.Cluster_Nr    = [];
        enhancedCloud.Cluster_Size  = [];
        enhancedCloud.VoxelSize     = [];
        
        Tree{tree-1}.Cloud  = enhancedCloud;
        
    end
        
    Forest_Measures.Tree    = Tree;
end