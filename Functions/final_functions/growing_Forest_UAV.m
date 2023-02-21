function [Out,Info] = growing_Forest_UAV(in,Info)
    %% [Tree, Forest] = growing_Forest4voxel(in,max_d)
    % Uses shortes path within a build graph to separate Trees.

    %
    % manuel.luck@gmail.com

    %% Code
        switch Info.setup
            case 'interface'
                prompt          = {'Max Distance:'};
                dlgtitle        = 'Input';
                dims            = [1 35];
                definput        = {num2str(Info.tree_max_edgeweight)};
                answer          = inputdlg(prompt,dlgtitle,dims,definput);

                max_d           = str2double(answer{1,1});
                
                Info.tree_max_edgeweight = str2double(answer{1,1});
                
            case 'fixed'
                max_d           = Info.tree_max_edgeweight;
        end

        G = graph_creation(in, max_d);

    disp('Searching Stems')
        stem_ids = unique(in.Cluster_Nr);
        stem_ids(stem_ids == 0) = [];

    disp('Calculating Shortest Path')
        D = zeros(size(stem_ids,1),size(G.Nodes,1));
        for iv = 1:size(stem_ids,1)
            id_min = min(G.Nodes.cloud(G.Nodes.cloud(:,9) == stem_ids(iv),3));
            idx_g = find(G.Nodes.cloud(:,3)  == id_min &  G.Nodes.cloud(:,9) == stem_ids(iv,1));

            [~,D(iv,:)] = shortestpathtree(G,idx_g(1),'all');

        end

        [min_D,idx_shortest_Path] = min(D,[],1);

        idx = stem_ids(idx_shortest_Path);
        idx(min_D == inf) = 0;

        Out = idx;

end