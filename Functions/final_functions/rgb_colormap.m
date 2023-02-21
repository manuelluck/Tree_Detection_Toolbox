function [colors] = rgb_colormap(distribution,type,inputnr,varargin)
        % function [colors] = rgb_colormap(distribution,type,inputnr,varargin)
        %
        %   This function creates colormaps from the input colors.
        %
        %       Distribution can either be 'linear' or 'manual'
        %       (distribution in decimals as input (e.g. 1, 0.5, 0).
        %
        %       Type describes the interpolation between the colors. It can either
        %       be 'linear' or 'log' (steps get smaller towards the 2nd value.
        %
        %       inputnr describes how many colors should be included in the
        %       colormap. Value between 2-5.
        %
        %       varargin takes 2-5 colors [R G B] and their position, if manual
        %       distribution is activated.
        %
        %   manuel.luck@gmail.com


        %% Error Conditions:

        if ~ischar(distribution)
                error('\n \n First input must be a char, not a %s. \nInput can either be automatic or manual. \n \n',class(distribution))
        else
                % fprintf('\n You selected a %s distribution. \n',distribution);
        end
        if ~ischar(type)
                error('\n \n Second input must be a char, not a %s. \nInput can either be linear or log. \n \n',class(type))
        else
                % fprintf('\n You selected a %s interpolation between the colors. \n',type);
        end
        if ~isnumeric(inputnr)
                error('\n \n Third input must be a double, not a %s. \nInput describes the amount of input colors. \n \n',class(inputnr))
        else
                % fprintf('\n You choose %d input colors. \n',inputnr);
        end

        outputnr = 255;

        switch distribution
                case 'linear'
                        if length(varargin) ~= inputnr
                                fprintf('\n You have to choose %d input colors. \n',inputnr)
                        else
                                colors = [];
                                for idx8 = 1:(inputnr-1)
                                        colors = cat(1,colors,rgb_colormap_sub(varargin{idx8},varargin{idx8+1},floor(outputnr/(inputnr-1)),type));
                                end
                        end
                case 'manual'
                        if length(varargin) ~= inputnr*2
                                fprintf('\n You have to choose %d input colors and the same amount of distibutions. \n',inputnr)
                        else
                                colors = [];
                                for idx9 = 1:2:((inputnr-1)*2)
                                        stepnr = outputnr*(varargin{idx9+3}-varargin{idx9+1});
                                        colors = cat(1,colors,rgb_colormap_sub(varargin{idx9},varargin{idx9+2},stepnr,type));
                                end

                        end
        end	
end