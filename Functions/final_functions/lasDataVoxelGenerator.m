function [Voxel_Points,Info] = lasDataVoxelGenerator(PtCl,Info)
%% Voxel generator uses the cells from the quad approach to generate voxels
% All cells are binned in equal height intervalls and the points in those
% voxels are combined to a voxel_point representing them. 
    switch Info.Voxel
        case 'yes'
            Cells = PtCl.vp;
            
            switch Info.setup
                case 'interface'
                    prompt              = {'Enter Voxel Height [m]:'};
                    dlgtitle            = 'Input';
                    dims                = [1 35];
                    definput            = {num2str(Info.voxel_height)};
                    h = str2double(inputdlg(prompt,dlgtitle,dims,definput));
                    Info.voxel_height   = h;
                case 'fixed'
                    h = Info.voxel_height;
            end		

            Cells = cellfun(@(C1) createvoxelfromcells_cellfun(C1,h),Cells,'UniformOutput',false);
            Cells = Cells(~cellfun('isempty',Cells));
            Voxel_Points = cat(1,Cells{1:end});
        case 'no'
            Voxel_Points = vpcell2table(PtCl);
    end
    
%% 
% Internal functions '_voxel_points = createvoxelfromcells_cellfun(pc,h)'_

    function voxel_points = createvoxelfromcells_cellfun(pc,h)
            pc(pc(:,5)==1,:) = [];
            voxel_points = [];
            if size(pc,1) >= 2
                    h_min       = min(pc(:,3));
                    h_max       = max(pc(:,3));
                    heights     = [h_min:h:h_max,h_max];

                    [~,~,bin]   = histcounts(pc(:,3),'BinEdges',heights);

                    [~,~,idx]   = unique(bin,'stable');
                    
                    Easting     = accumarray(idx,pc(:,1),[],@mean);
                    Northing    = accumarray(idx,pc(:,2),[],@mean);
                    AboveSea    = accumarray(idx,pc(:,8),[],@mean);
                    AboveDTM    = accumarray(idx,pc(:,3),[],@mean);
                    RNNR        = accumarray(idx,pc(:,7),[],@min);
                    Intensity   = accumarray(idx,pc(:,6),[],@max);
                    
                    Ids         = accumarray(idx,pc(:,4),[],@(x) {x});
                    
                    voxel_points= table(Easting,Northing,AboveSea,Intensity,AboveDTM,RNNR,Ids);
                    voxel_points.VoxelSize = cell2mat(cellfun(@(C) length(C), Ids,'UniformOutput',false));
                     
            elseif size(pc,1) == 1
                    Easting     = pc(:,1);
                    Northing    = pc(:,2);
                    AboveSea    = pc(:,8);
                    AboveDTM    = pc(:,3);
                    RNNR        = pc(:,7);
                    Intensity   = pc(:,6);
                    
                    Ids         = {pc(:,4)};
                    
                    voxel_points= table(Easting,Northing,AboveSea,Intensity,AboveDTM,RNNR,Ids);
                    voxel_points.VoxelSize(:) = 1;
            end
    end

    function voxel_points = vpcell2table(PtCl)
        
        pc = cell2mat(PtCl.vp(:));
        
        Easting     = pc(:,1);
        Northing    = pc(:,2);
        AboveSea    = pc(:,8);
        AboveDTM    = pc(:,3);
        RNNR        = pc(:,7);
        Intensity   = pc(:,6);

        Ids         = pc(:,4);

        voxel_points= table(Easting,Northing,AboveSea,Intensity,AboveDTM,RNNR,Ids);   
        voxel_points.VoxelSize(:) = 1;
    end
        
end