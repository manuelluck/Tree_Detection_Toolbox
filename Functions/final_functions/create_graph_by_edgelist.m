function G = create_graph_by_edgelist(in,max_d,nodes)
        %% G = create_graph_by_edgelist(in,max_d)
        % creates graph with an edgelist connecting all points within max_d of
        % eachother.
        % input:    in:     PointCloud(x,y,z)
        %           max_d:  Maximal Distance (d)
        %
        %%
        % output:   G:      Graph with logrithmic edgeweight

        disp('building Tree')
        Mdl = KDTreeSearcher(in);

        disp('kNN-Search')
        [IdxNN_a,D_a] = rangesearch(Mdl,in,max_d);

        disp('Edgelist')

        edgelist  = cellfun(@(C1,C2) create_edgelist_cellfun(C1,C2),IdxNN_a,D_a,'UniformOutput',false);
        edgelist   = cell2mat(edgelist(:));

        G = graph(edgelist(:,1),edgelist(:,2),2.^(edgelist(:,3)+1),nodes);

        function edgelist = create_edgelist_cellfun(IdxNN,D)
                % using rangesearch outputs to create edgelist
                Idx = IdxNN(IdxNN >= IdxNN(1,1));
                d   = D(IdxNN >= IdxNN(1,1));

                if size(IdxNN,2) >= 1
                        edgelist = zeros(size(Idx,2),3);
                        for idx13 = 1:size(Idx,2)
                                edgelist(idx13,:) =  [Idx(1,1),Idx(1,idx13),d(1,idx13)];
                        end
                end
        end
end