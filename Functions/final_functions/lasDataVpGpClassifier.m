function [PtCl,Info] = lasDataVpGpClassifier(Data,Info)
%% lasDataVpGpClassifier(Data,Info) classifies the points into Ground- and Vegetation Point and creates a DTM.
%  Starts with one cell and iteratively divides each cell into 4 new cells.
%  All points in each cell are tested to be ground or vegetation points,
%  and the terrain height is adjusted accordingly.
%
% created by Manuel A. Luck (manuel.luck@gmail.com)

%% Code
% Saving the Point Cloud in the first cell. 

    org.cloud = {[double(Data.x),double(Data.y),double(Data.z),double(Data.id),double(zeros(size(Data.x,1),1)),double(Data.intensity),double(Data.wave_return_point)]};
    
% Calculating Boundries of the research area.

    org.min         = min(org.cloud{1,1}(:,1:3));
    
    org.max         = ceil(max(org.cloud{1,1}(:,1:3)));
    
    org.plotsize    = org.max - org.min;
    org.dtm         = {org.min(1,3)};
    org.dsm         = {org.max(1,3)};
    
    in              = org;
    
% GUI for the amount of interations and the slope factor

    switch Info.setup
        case 'interface'
            prompt          = {'Enter #Iterations:',...
                               'Enter Slopefactor:'};            
            dlgtitle        = 'Input';
            dims            = [1 35];
            definput        = {num2str(Info.iteration),num2str(Info.slopefactor)};
            
            answer = inputdlg(prompt,dlgtitle,dims,definput);
    
            var.iterations  = str2double(answer{1,1});
            var.slopefactor = str2double(answer{2,1});
            
            Info.iteration  = var.iterations;
            Info.slopefactor= var.slopefactor;
        case 'fixed'
            var.iterations  = Info.iteration;
            var.slopefactor = Info.slopefactor;            
    end
    
% Running the iterations

    for idx = 1:var.iterations

        disp(strcat('----- iteration',' ',num2str(idx),' ----- '))   

        if idx < var.iterations
            var.splitting_PC = 'no';
            var.smoothing    = 'no';
        else
            var.splitting_PC = 'yes';
            var.smoothing    = 'yes';
        end

        [in.cloud,in.dtm,in.dsm,~,in.vp,~] = dividePC_cellfun(in.cloud,in.dtm,in.dsm,org,var);

        disp(' ')

    end
 
% Saving the Data. The removed CHM X and Y can be added if wanted.

    disp('----- saving in table -----')

    disp(' ')
    
%     in.chm      = cellfun(@(a,b) chm_cellfun(a,b),in.dtm,in.dsm,'UniformOutput',false);

    [in.cloud]  = cellfun(@(C1,C2) substract_dtm_cellfun(C1,C2),in.cloud,in.dtm,'UniformOutput',false);
    [in.vp]     = cellfun(@(C1,C2) substract_dtm_cellfun(C1,C2),in.vp,in.dtm,'UniformOutput',false);
    DTM         = cell2mat(in.dtm);
%     CHM         = cell2mat(in.chm);
% 
%     cloud = cell2mat(in.cloud(:));

    
    PtCl.Cloud  = in.cloud;
    PtCl.vp     = in.vp;
    
    PtCl.DTM    = DTM;
%     PtCl.CHM    = CHM;
%     PtCl.X = linspace(min(cloud(:,1)),max(cloud(:,1)),size(PtCl.DTM,1));
%     PtCl.Y = linspace(min(cloud(:,2)),max(cloud(:,2)),size(PtCl.DTM,1));  

    %% --------------  Functions --------------- %%
    
    function [cloud_out,dtm_out,dsm_out,gp,vp,hp] = dividePC_cellfun(cloud,dtm,dsm,input,var)
        %% [out,z_out] = dividePC(in,z_in)
        % Function to divide Point Clouds in four Subclouds each.
        %
        %
        % Input:
        %   in      -> cell() containing pointclouds (:,3)
        %   z_in  -> matrix or single value: same size as in containing the z_min
        %                 per cloud
        %   slope-> maximal slope accounted
        %
        % Output:
        %  out    -> cell() with divided pointclouds
        %  z_out-> matrix of same size as out, containing the min values of each
        %                 cloud
        %
        % manuel.luck@gmail.com

        % First: detecting size of input and creating the output variables
        treesize    = size(cloud);
        cloud       = make_M_greater(cloud,2);
        dtm_out     = make_M_greater(dtm,2);
        dsm_out     = make_M_greater(dsm,2);


        switch var.splitting_PC
            case 'no'
                gp= [];
                vp = [];
                hp = [];
        end

        % Second: getting Resolution and X,Y Coords

        res(1:2)    = double(input.plotsize(1,1:2))./(treesize(1:2)*2);
        xcoord      = input.min(1,1):res(1):input.max(1)-res(1);
        ycoord      = input.min(1,2):res(2):input.max(2)-res(2);

        threshold   =  max(res)*var.slopefactor;
        if threshold < 0.2
            threshold = 0.2;
        end

        [X,Y] = meshgrid(xcoord,ycoord);

        X = num2cell(X);
        Y = num2cell(Y);

        cloud_out = cellfun(@(C1,C2,C3) quad_cloud(C1,C2,C3,res),cloud,X,Y,'UniformOutput',false);

        [dtm_out,dsm_out] = cellfun(@(C1,C2,C3) dtm_dsm_cellfun(C1,C2,C3,threshold),cloud_out,dtm_out,dsm_out,'UniformOutput',false);

        switch var.splitting_PC
            case 'yes'
                [gp,vp,hp,cloud_out] = cellfun(@(C1,C2,C3) classi_gp_vp_hp_cellfun(C1,C2,threshold),cloud_out,dtm_out,'UniformOutput',false);
        end

        switch var.smoothing
            case 'yes'
                dtm_out = cell2mat(dtm_out);
                dtm4smooth = cat(1,dtm_out(1,:),dtm_out(1,:),dtm_out(1,:),...
                    dtm_out,...
                    dtm_out(end,:),dtm_out(end,:),dtm_out(end,:));
                dtm4smooth = cat(2,dtm4smooth(:,1),dtm4smooth(:,1),dtm4smooth(:,1),...
                    dtm4smooth,...
                    dtm4smooth(:,end),dtm4smooth(:,end),dtm4smooth(:,end));

                [ext1,ext2,~] =size(dtm_out);

                dtm4mean=....
                    cat(3,dtm_out,...
                    dtm4smooth(1:ext1,1:ext2),...
                    dtm4smooth(1+1:1+ext1,1+1:1+ext2),...
                    dtm4smooth(1+2:2+ext1,1+2:2+ext2),...
                    dtm4smooth(1+3:3+ext1,1+3:3+ext2),...
                    dtm4smooth(1+4:4+ext1,1+4:4+ext2),...
                    dtm4smooth(1+5:5+ext1,1+5:5+ext2),...
                    dtm4smooth(1+6:6+ext1,1+6:6+ext2),...
                    dtm4smooth(1+1:1+ext1,1:ext2),...
                    dtm4smooth(1+2:2+ext1,1:ext2),...
                    dtm4smooth(1+3:3+ext1,1:ext2),...
                    dtm4smooth(1+4:4+ext1,1:ext2),...
                    dtm4smooth(1+5:5+ext1,1:ext2),...
                    dtm4smooth(1+6:6+ext1,1:ext2),...
                    dtm4smooth(1:ext1,1+1:1+ext2),...
                    dtm4smooth(1:ext1,1+2:2+ext2),...
                    dtm4smooth(1:ext1,1+3:3+ext2),...
                    dtm4smooth(1:ext1,1+4:4+ext2),...
                    dtm4smooth(1:ext1,1+5:5+ext2),...
                    dtm4smooth(1:ext1,1+6:6+ext2));
                dtm_mean = mean(dtm4mean,3);
                dtm_std = std(dtm4mean,0,3);

                bin = abs(dtm_out-dtm_mean) < dtm_std;
                dtm_final(bin) = dtm_out(bin);
                dtm_final(bin==0) = dtm_mean(bin == 0);
                dtm_out = reshape(dtm_final,size(dtm_out,1),size(dtm_out,2));
                dtm_out = num2cell(dtm_out);
        end
    end

    function [gp,vp,hp,cloud] = classi_gp_vp_hp_cellfun(cloud,dtm,threshold)
    %[gp,vp,hp] = classi_gp_vp_hp_cellfun(cloud,dtm,threshold)
    %   

        if size(cloud,2) > 1                    
            vp = cloud(abs(cloud(:,3)-dtm) > threshold,:);
            cloud(abs(cloud(:,3)-dtm) > threshold,5) = 2;
            
            hp = cloud(cloud(:,3) == max(cloud(:,3)),:);
            cloud(cloud(:,3) == max(cloud(:,3)),5) = 3; 
            
            gp = cloud(abs(cloud(:,3)-dtm) <= threshold,:);
            cloud(abs(cloud(:,3)-dtm) <= threshold,5) = 1;

        else
            gp = [];
            hp = [];
            vp = [];
        end

    end


    function [out] = make_M_greater(in,multiplier)
        %% This function makes M great again!


        for idx7 = 1:size(in,1)
            for j = 1:size(in,2)
                out((idx7*multiplier+1)-multiplier:(idx7*multiplier),(j*multiplier+1)-multiplier:(j*multiplier)) = in (idx7,j);
            end
        end


    end

    function out = quad_cloud(cloud,X,Y,res)

        out = cloud(cloud(:,1) >= X & cloud(:,1) < X + res(1) &...
            cloud(:,2) >= Y & cloud(:,2) < Y + res(2),:);

    end

    function chm = chm_cellfun(dtm,dsm)
        %% chm = chm_cellfun(dtm,dsm)


        if dsm >= dtm
            chm = double(dsm-dtm);
        else
            chm = double(0);
        end
    end

    function [in_cloud] = substract_dtm_cellfun(in_cloud,in_dtm)
        %% [in_cloud] = substract_dtm_cellfun(in_cloud,in_dtm)



        [~,n,~] = size(in_cloud);
        if n > 1
            in_cloud(:,n+1) = in_cloud(:,3);
            in_cloud(:,3) = in_cloud(:,3) - in_dtm;
        end
    end

    function [dtm_out,dsm_out] = dtm_dsm_cellfun(cloud,dtm_in,dsm_in,threshold)

    if size(cloud,2) > 1
        mini = min(cloud(:,3));
        if abs(mini-dtm_in) <= threshold
            dtm_out = mini;
        else
            dtm_out = dtm_in;
        end
        dsm_out = max(cloud(:,3));
    else
        dtm_out = dtm_in;
        dsm_out = dsm_in;

    end
    end

end