function Info = select_data(Info)
%%  gui to select the data folder and afterwards the .las file
%  Saves the Folder and File names in the Info structure.
%
%  Info.Folder      : Folder directory
%  Info.Tile_Names  : Cells with the selected Tiles
%
% created by Manuel A. Luck (manuel.luck@gmail.com)

%% Code
% Selecting Folder & Tiles
    folder = uigetdir;

% Choosing Nr. of Tiles
    tile_selection(folder)

    Info.Folder = folder;

    %% --------------  Functions --------------- %%

    %% Tile Selection
    function tile_selection(folder)
        listing = dir(folder);

        name{1,1} = [];
        ii = 1;
        for idx5 = 1:size(listing,1)
            if listing(idx5).isdir == 0
                name{ii,1} = listing(idx5).name;
                ii = ii+1;
            end
        end

        clear listing i ii

        lo = false(size(name,1),1);
        lo = mat2cell(lo,ones(size(lo,1),1),1);
        n = name(:,1);
        in = [n,lo];

        Figure_CheckTable(in,'Tiles Selection');
    end

    function Figure_CheckTable(CheckTable, str)
        f = figure('Position',[120 80 550 600]);
        dat = CheckTable;
        cnames = {'Name','Selection'};
        t = uitable('Parent',f,...
            'Data',dat,...
            'ColumnName',cnames,...
            'ColumnWidth',{240 50},...
            'Position',[20 20 380 580],...
            'ColumnEditable',[false true]);
        btn = uicontrol('Style', 'pushbutton', 'String', 'Check & Close',...
            'Position', [420 480 100 40],...
            'Callback', {@Pushbutton1, dat, str, t});

        waitfor(f)

    end

    function Pushbutton1(src, event, dat, str, t)
        CheckTable1 = get(t,'Data');
        ii = 1;
        for idx6 = 1:size(CheckTable1,1)
            if CheckTable1{idx6,2} == 1
                names{ii} = CheckTable1{idx6,1};
                ii = ii+1;
            end
        end

        Info.Tile_Names = names;
        close

    end
end
