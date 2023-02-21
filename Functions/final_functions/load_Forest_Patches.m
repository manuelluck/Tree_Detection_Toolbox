function Forest_Patches = load_Forest_Patches

    currentFolder   = pwd;
    FolderName      = 'Tree_Detection_Toolbox';
    k = strfind(currentFolder, FolderName);
    if currentFolder(1) == '/'    
        files = dir(strcat(currentFolder(1:k-1+length(FolderName)),'/Output/Temp/*.mat'));
    else
        files = dir(strcat(currentFolder(1:k-1+length(FolderName)),'\Output\Temp\*.mat'));
    end

    Forest_Patches{length(files)} = [];
    for patch = 1:length(files)
        disp(strcat('Patch_',num2str(patch),' loaded'))
        if currentFolder(1) == '/'    
            Forest_Patches(patch) = struct2cell(load(strcat(files(patch,1).folder,'/',files(patch,1).name)));
        else
            Forest_Patches(patch) = struct2cell(load(strcat(files(patch,1).folder,'\',files(patch,1).name)));
        end
    end
end