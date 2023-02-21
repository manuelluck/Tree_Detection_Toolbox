function [Voxel_Points] = trunkmeasures(Voxel_Points,Info)

    trunkIds                    = unique(Voxel_Points.Cluster_Nr);
    newIds                      = 0:size(trunkIds,1)-1;
    Voxel_Points.Cluster_Nr     = arrayfun(@(X) newIds(trunkIds==X),Voxel_Points.Cluster_Nr);

    for trunk = 2:length(unique(Voxel_Points.Cluster_Nr))

        Cloud               = Voxel_Points(Voxel_Points.Cluster_Nr == newIds(trunk),:);
        Cloud.AboveSea      = Cloud.AboveSea./2;

        G                   = graph_creation(Cloud, Info.trunk_max_edgeweight); 
        G.Nodes.Cluster     = conncomp(G)';
        G.Nodes.Betweeness  = centrality(G,'betweenness');

        iter = 1;       

        while iter < 10 && length(unique(G.Nodes.Cluster)) == 1
            G.Nodes.Betweeness  = centrality(G,'betweenness');

            [bins,binsizes]     = conncomp(G);
            bins(binsizes == 1) = 1;
            G.Nodes.Cluster     = bins';
            edgebetweeness      = sum(G.Nodes.Betweeness(G.Edges.EndNodes),2).*G.Edges.Weight;   
            [~,idx]             = maxk(edgebetweeness,1);   
            G                   = rmedge(G,idx);

            iter = iter+1;

        end

        if length(unique(G.Nodes.Cluster)) ~= 1  
            Cloud.Cluster_Nr(G.Nodes.Cluster == bins(min(binsizes))) = max(Voxel_Points.Cluster_Nr) + 1;
        end 

        for clu = 1:length(binsizes)
            new_Clusters = Cloud(G.Nodes.Cluster == clu,:); 
            if size(new_Clusters,1) < Info.trunk_min_cluster || min(new_Clusters.AboveDTM) > min(table2array(Voxel_Points(Voxel_Points.Cluster_Nr > 0,'AboveDTM'))) + 0.3
                Cloud(G.Nodes.Cluster == clu,'Cluster_Nr') = table(zeros(size(new_Clusters,1),1)); 
            end
        end
        Voxel_Points(Voxel_Points.Cluster_Nr == newIds(trunk),'Cluster_Nr') = Cloud(:,'Cluster_Nr'); 
    end

end