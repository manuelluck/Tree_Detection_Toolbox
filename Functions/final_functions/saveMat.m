function saveMat(data,filename,Folder)


    currentFolder   = pwd;
    FolderName      = 'Tree_Detection_Toolbox';
    k = strfind(currentFolder, FolderName);
    feval(@() assignin('caller',filename,data));
    
    if currentFolder(1) == '/'
        save(strcat(currentFolder(1:k-1+length(FolderName)),'/Output/',Folder,'/',filename,'.mat'),filename,'-v7.3')
    else
        save(strcat(currentFolder(1:k-1+length(FolderName)),'\Output\',Folder,'\',filename,'.mat'),filename,'-v7.3')
    end
end
