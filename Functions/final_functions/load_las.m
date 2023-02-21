function [PointCloud,Info] = load_las(Info,Patch_Nr)
%% load_las(Info,Patch_Nr) loads the previously selected .las files with lasdata() and readlas().
%  lasdata is used to load xyz and intensity.
%  readlas is used to add the RNNR values.
%
% created by Manuel A. Luck (manuel.luck@gmail.com)

%% Code
    % If the Surrounding Patches should be loaded
    switch Info.Surrounding
        case 'no'
            % if not, the foldesname and filename will be combined and
            % loaded. Depending on MAC or Windows '/' or '\' needs to be
            % used.
            % The lasdata creates an object containing all information in
            % the lasfile, extept the Return Numbers, these need to be
            % added with the readlas() function.
            
            if Info.Folder(1) == '/'
                Data_main = lasdata(strcat(Info.Folder,'/',Info.Tile_Names{1,Patch_Nr}));
                Data_main.get_intensity;

                if size(unique(Data_main.wave_return_point),1) <= 0
                    file                    = readlas(strcat(Info.Folder,'/',Info.Tile_Names{1,Patch_Nr}));
                    Data_main.wave_return_point  = file.rnnr;
                end
            else
                Data_main = lasdata(strcat(Info.Folder,'\',Info.Tile_Names{1,Patch_Nr}));
                Data_main.get_intensity;

                if size(unique(Data_main.wave_return_point),1) <= 0
                    file                    = readlas(strcat(Info.Folder,'\',Info.Tile_Names{1,Patch_Nr}));
                    Data_main.wave_return_point  = file.rnnr;
                end
            end
            
            % Checking for the Return Number
            if isempty(Data_main.wave_return_point)
                Data_main.wave_return_point(1:size(Data_main.x),1) = 0;
            end
            
            % the Return Number is adjusted in how many returns are left in
            % each ray. 11 22 33 are all combined to 0, 21 32 ... are
            % combined to 1 ...
            last_digit                  = mod(Data_main.wave_return_point,10);
            first_digit                 = (Data_main.wave_return_point-last_digit)./10;
            Data_main.wave_return_point = first_digit-last_digit;   
            
            % Save as Point Cloud:
            x                               = Data_main.x;
            y                               = Data_main.y;
            z                               = Data_main.z;
            intensity                       = Data_main.intensity;
            wave_return_point               = Data_main.wave_return_point;
            
            PointCloud                      = table(x,y,z,intensity,wave_return_point);
            PointCloud.id(:)                = 1:size(PointCloud.x,1);
            
        case 'yes'
        % find the names of the surrounding patches (specific file names needed!)  
            id_matrix           = [Info.Easting_Patches-1,Info.Easting_Patches,Info.Easting_Patches+1;...
                                   -1,0,1;...
                                   -(Info.Easting_Patches+1),-(Info.Easting_Patches),-(Info.Easting_Patches-1)];
                               
            filesuffix          = '.las';
            k                   = strfind(Info.Tile_Names{1,Patch_Nr}, filesuffix);
            file_id             = str2double(Info.Tile_Names{1,Patch_Nr}(k-3:k-1));
            ids                 = file_id + id_matrix;
            if mod(ids(2,2),Info.Easting_Patches) == 1
                ids(:,1) = 0;
            elseif mod(ids(2,2),Info.Easting_Patches) == 0
                ids(:,3) = 0;
            end
            filename{size(ids,1),size(ids,2)} = {};
            
        % create the file names 
            for i = 1:size(ids,1)
                for j = 1:size(ids,2)
                    if ids(i,j) < 10 && ids(i,j) > 0
                        filename{i,j} =  strcat({Info.Tile_Names{1,Patch_Nr}(1:k-4)},'00',num2str(ids(i,j)),'.las');
                        if Info.Folder(1) == '/'
                            filename{i,j} = strcat(Info.Folder,'/',filename{i,j});
                        else
                            filename{i,j} = strcat(Info.Folder,'\',filename{i,j});
                        end      
                    elseif ids(i,j) < 100 && ids(i,j) > 0
                        filename{i,j} =  strcat({Info.Tile_Names{1,Patch_Nr}(1:k-4)},'0',num2str(ids(i,j)),'.las');
                        if Info.Folder(1) == '/'
                            filename{i,j} = strcat(Info.Folder,'/',filename{i,j});
                        else
                            filename{i,j} = strcat(Info.Folder,'\',filename{i,j});
                        end
                    elseif ids(i,j) < 1000 && ids(i,j) > 0
                        filename{i,j} =  strcat({Info.Tile_Names{1,Patch_Nr}(1:k-4)},num2str(ids(i,j)),'.las');
                        if Info.Folder(1) == '/'
                            filename{i,j} = strcat(Info.Folder,'/',filename{i,j});
                        else
                            filename{i,j} = strcat(Info.Folder,'\',filename{i,j});
                        end
                    end
                end
            end

        %% Checking if the big file already exists
        
            big_file        = strcat(filename{2,2}{1,1}(1:end-4),'big.las');
            
       % if it does not exist 
       % loading main_file
       
            if exist(big_file,'file') == 0
                Data_main = lasdata(filename{2,2}{1,1},'loadall');

                if size(unique(Data_main.wave_return_point),1) <= 1
                    file                            = readlas(filename{2,2}{1,1});
                    Data_main.wave_return_point     = file.rnnr;
                end           

                filename{2,2}   = [];

                boundries_main(1,:)     = min([Data_main.x,Data_main.y])-10;
                boundries_main(2,:)     = max([Data_main.x,Data_main.y])+10; 
                
        % prepare for loading surrounding
        
                x                   = [];
                y                   = [];
                z                   = [];
                red                 = [];
                green               = [];
                blue                = [];
                intensity           = [];
                classification      = [];
                bits                = [];
                user_data           = [];
                scan_angle          = [];
                gps_time            = [];
                wave_return_point   = [];  
                
        % load surrounding files
        
                for i = 1:size(ids,1)
                    for j = 1:size(ids,2)
                        try 
                            %%
                            Data_sub = lasdata(filename{i,j}{1,1},'loadall');

                            if size(unique(Data_sub.wave_return_point),1) <= 1
                                file                        = readlas(filename{i,j}{1,1});
                                Data_sub.wave_return_point  = file.rnnr;
                            end                     

                            bin         = Data_sub.x > boundries_main(1,1) & Data_sub.x < boundries_main(2,1) & ...
                                          Data_sub.y > boundries_main(1,2) & Data_sub.y < boundries_main(2,2);

                            x           = [x;Data_sub.x(bin)];
                            y           = [y;Data_sub.y(bin)];
                            z           = [z;Data_sub.z(bin)];
                            intensity   = [intensity;Data_sub.intensity(bin)];

                            try
                                red                 = [red;Data_sub.red(bin)];
                            catch
                            end

                            try
                                green               = [green;Data_sub.green(bin)];
                            catch
                            end

                            try
                                blue                = [blue;Data_sub.blue(bin)];
                            catch
                            end

                            try
                                bits                = [bits;Data_sub.bits(bin)];
                            catch
                            end

                            try
                                classification      = [classification;Data_sub.classification(bin)];
                            catch
                            end

                            try
                                user_data           = [user_data;Data_sub.user_data(bin)];
                            catch
                            end

                            try
                                scan_angle          = [scan_angle;Data_sub.scan_angle(bin)];
                            catch
                            end

                            try
                                gps_time            = [gps_time;Data_sub.gps_time(bin)];
                            catch
                            end


                            try
                                wave_return_point   = [wave_return_point;Data_sub.wave_return_point(bin)];
                            catch
                            end
                            %%
                        catch
                        end
                    end
                end
                
        % combine all files
        
                Data_main.x                 = [Data_main.x;x];
                Data_main.z                 = [Data_main.z;z];
                Data_main.y                 = [Data_main.y;y];
                Data_main.intensity         = [Data_main.intensity;intensity];
                Data_main.bits              = [Data_main.bits;bits];
                Data_main.classification    = [Data_main.classification;classification];
                Data_main.user_data         = [Data_main.user_data;user_data];
                Data_main.scan_angle        = [Data_main.scan_angle;scan_angle];
                Data_main.gps_time          = [Data_main.gps_time;gps_time];
                Data_main.red               = [Data_main.red;red];
                Data_main.green             = [Data_main.green;green];
                Data_main.blue              = [Data_main.blue;blue];
                Data_main.wave_return_point = [Data_main.wave_return_point;wave_return_point];
                Data_main.selection         = true(size(Data_main.x));
                
        % add a Point id 
        
                Data_main.extendedvariables = uint64(1:size(Data_main.x))';
                
        % write bigfile
                
                Data_main.write_las(big_file);
                
        % if bigfile exists
        
            else
                Data_main = lasdata(big_file);
                Data_main.get_intensity;
                if size(unique(Data_main.wave_return_point),1) <= 1
                    file                            = readlas(big_file);
                    Data_main.wave_return_point     = file.rnnr;
                end                  
            end

        % Check for Return Number

            if isempty(Data_main.wave_return_point)
                Data_main.wave_return_point(1:size(Data_main.x),1) = 0;
            end

            last_digit                      = mod(Data_main.wave_return_point,10);
            first_digit                     = (Data_main.wave_return_point-last_digit)./10;
            Data_main.wave_return_point     = first_digit-last_digit;  
            
        % adding id
            if isempty(Data_main.extendedvariables)
                Data_main.extendedvariables = uint64(1:size(Data_main.x))';
            end
            
        % Save as PointCloud
        
            x                               = Data_main.x;
            y                               = Data_main.y;
            z                               = Data_main.z;
            intensity                       = Data_main.intensity;
            wave_return_point               = Data_main.wave_return_point;
            id                              = Data_main.extendedvariables;
            
            PointCloud                      = table(x,y,z,intensity,wave_return_point,id);
            
            Info.BigFiles{Patch_Nr}         = big_file;
    end
end