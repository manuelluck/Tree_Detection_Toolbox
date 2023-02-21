function addtoolbox2path()
%% This function adds the 'Tree_Detection_Toolbox' folder to you matlab search path
%
%
%

    %% Code

    % get current directory
    currentFolder   = pwd;
    FolderName      = 'Tree_Detection_Toolbox';
    
    % find toolbox name
    k = strfind(currentFolder, FolderName);

    % add toolbox- and subfolders to the search path        
    addpath(genpath(currentFolder(1:k-1+length(FolderName))));
    
    fprintf('%s \nadded to the path.\n',currentFolder(1:k-1+length(FolderName)));
    
    
end