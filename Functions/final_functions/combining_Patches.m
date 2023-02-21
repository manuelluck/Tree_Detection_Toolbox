function [TreeData,Cloud] = combining_Patches(Forest_Measures, Info, edgesdistance)
    
    switch Info.Surrounding
        case 'yes'
            edgesdistance = 10;
    end

    counter             = 1;

    for patch = 1:length(Forest_Measures)
        for tree = 1:length(Forest_Measures{patch}.Tree)
            if Forest_Measures{patch}.Tree{tree}.Distance2Edge >= edgesdistance  
                if Forest_Measures{patch}.Tree{tree}.height >= 5
                    TreeData.Position(counter,1:3)            = Forest_Measures{patch}.Tree{tree}.Position; 
                    TreeData.DBH(counter,1)                   = Forest_Measures{patch}.Tree{tree}.DBH;
                    TreeData.Height(counter,1)                = Forest_Measures{patch}.Tree{tree}.height;
                    TreeData.Cloud{counter,1}                 = Forest_Measures{patch}.Tree{tree}.Cloud;
                    TreeData.Cloud{counter,1}.Forest_Id(:)    = counter;
                    counter = counter + 1;
                end
            end
        end
    end

    clear patch tree counter

    distMatrix  = pdist2(TreeData.Position(:,1:2),TreeData.Position(:,1:2));

    [pairs(:,1),pairs(:,2)] = find(distMatrix > 0 & distMatrix < 0.3);

    counter = 1;

    while size(pairs,1) > 0
        trees2combine{counter,1} = {[pairs(1,1),pairs(pairs(:,1) == pairs(1,1),2)']}; 
        pairs(pairs(:,1) == pairs(1,1),:) = [];
        counter = counter + 1;   

    end
    clear pairs counter distMatrix row i 
    %%
    try
        for i = 1:length(trees2combine)
            for ii = 2:length(trees2combine{i}{1,1})
                TreeData.Cloud{trees2combine{i}{1,1}(ii),1}.Forest_Id(:) = TreeData.Cloud{trees2combine{i}{1,1}(1),1}.Forest_Id(1);
            end
        end
    catch
    end
    Cloud = cat(1,TreeData.Cloud{:,1});
end
    
