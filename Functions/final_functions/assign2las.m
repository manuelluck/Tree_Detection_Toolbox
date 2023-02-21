function assign2las(Info,Patch_Nr,Forest,Namen,flatness)

%     creating pointer to assign the Classification and the Above Ground
%     height to the original points.
    if sum(Forest.VoxelSize) == 0    
        Pointer4Classification.Pointer      = Forest.Ids;
        Pointer4Classification.Value_id     = Forest.Tree_Id;
        Pointer4Classification.Value_h      = Forest.AboveDTM;
    else
        pointer                             = Forest.Ids;
        id                                  = arrayfun(@(C) {C} ,Forest.Tree_Id);
        h                                   = arrayfun(@(C) {C} ,Forest.AboveDTM);
        
        pointid2treeid                      = cell2mat(cellfun(@(a,b,c) combining_multiple_point_ids(a,b,c),pointer,id,h,'UniformOutput',false));
        
        Pointer4Classification.Pointer      = pointid2treeid(:,1);
        Pointer4Classification.Value_id     = pointid2treeid(:,2);
        Pointer4Classification.Value_h      = pointid2treeid(:,3);    
    end
        

%     As the classification is a uint8 we only have 255 values
    while max(Pointer4Classification.Value_id,[],1) > 255
        Pointer4Classification.Value_id(Pointer4Classification.Value_id >= 255) = abs(Pointer4Classification.Value_id(Pointer4Classification.Value_id >= 255) - 254);
    end
      
%     Loading the original file
    switch Info.Surrounding
        case 'no'
            if Info.Folder(1) == '/'
                Data = lasdata(strcat(Info.Folder,'/',Info.Tile_Names{Patch_Nr}),'loadall');

            else
                Data = lasdata(strcat(Info.Folder,'\',Info.Tile_Names{Patch_Nr}),'loadall');

            end
        case 'yes'
            if Info.Folder(1) == '/'
                Data = lasdata(Info.BigFiles{Patch_Nr} ,'loadall');

            else
                Data = lasdata(Info.BigFiles{Patch_Nr} ,'loadall');

            end
    end
    
%     Adding the tree_id to the classification    
    Data.classification(:)  = 0;
    Data.classification(Pointer4Classification.Pointer,1)   = Pointer4Classification.Value_id;
    
%     switch between the to height measures as main height (displayed in Meshroom etc)  
    switch flatness
        case 'flat'
            Data.Zt                                     = Data.z;
            Data.z(Pointer4Classification.Pointer,1)    = Pointer4Classification.Value_h;                       
        case 'org'
            Data.Zt                                     = Data.z;
            Data.Zt(Pointer4Classification.Pointer,1)   = Pointer4Classification.Value_h;           
    end

%     using the whole value range for the intensity values    
    Data.intensity = Data.intensity - min(Data.intensity);
    factor = 65535/max(Data.intensity);
    Data.intensity = Data.intensity.*factor;
    
%     remove all the points that do not have a tree id
    Data.selection        = Data.classification ~= 0;
    Data.x                = Data.x(Data.selection);
    Data.y                = Data.y(Data.selection);
    Data.z                = Data.z(Data.selection);
    Data.intensity        = Data.intensity(Data.selection);
    Data.bits             = Data.bits(Data.selection);
    Data.classification   = Data.classification(Data.selection);
    Data.user_data        = Data.user_data(Data.selection);
    Data.Zt               = Data.Zt(Data.selection);

    try
        Data.scan_angle       = Data.scan_angle(Data.selection);
    catch
    end
    
    try
        Data.point_source_id  = Data.point_source_id(Data.selection);
    catch
    end
    
    try    
        Data.gps_time         = Data.gps_time(Data.selection);
    catch
    end
    
    try    
        Data.red              = Data.red(Data.selection);
    catch
    end
    
    try    
        Data.green            = Data.green(Data.selection);
    catch
    end
    
    try    
        Data.blue             = Data.blue(Data.selection);
    catch
    end
    
    Data.selection        = Data.selection(Data.selection);

%     Save the object with a chosen suffix
    currentFolder   = pwd;
    FolderName      = 'Tree_Detection_Toolbox';
    k = strfind(currentFolder, FolderName);
    if currentFolder(1) == '/'
        Data.write_las(strcat(currentFolder(1:k-1+length(FolderName)),'/Output/Las/',Info.Tile_Names{Patch_Nr}(1:end-4),'_',Namen,'.las'))
    else
        Data.write_las(strcat(currentFolder(1:k-1+length(FolderName)),'\Output\Las\',Info.Tile_Names{Patch_Nr}(1:end-4),'_',Namen,'.las'))
    end   
end