function G = graph_creation(cloud, edge_distance) 
% 
    DT      = delaunayTriangulation([cloud.Easting,cloud.Northing,cloud.AboveSea]);
    E       = edges(DT);
    X       = [cloud.Easting(E(:,1)),cloud.Northing(E(:,1)),cloud.AboveSea(E(:,1))];
    Y       = [cloud.Easting(E(:,2)),cloud.Northing(E(:,2)),cloud.AboveSea(E(:,2))];    
    D       = X-Y;
    E(:,3)  = sqrt(D(:,1).^2 + D(:,2).^2 + D(:,3).^2);
    
    E(E(:,3)> edge_distance,:) = [];
    
    G = graph(E(:,1),E(:,2),E(:,3),size(cloud,1));
    
    G.Nodes.cloud = table2array(cloud(:,{'Easting','Northing','AboveSea','Intensity','AboveDTM','RNNR','VoxelSize','Cluster_Size','Cluster_Nr'}));
    
end