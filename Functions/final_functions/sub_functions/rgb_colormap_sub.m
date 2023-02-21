function colormaps = rgb_colormap_sub(color1,color2,nr,type)
        % color distribution
        switch type
                case 'linear'
                        step = (color2-color1)./(nr);
                        colormaps = color1;
                        for idx = 1:(nr-1)
                                colormaps = cat(1,colormaps,colormaps(idx,:)+step);
                        end
                case 'log'
                        disp('Needs improvement');
                        colormaps = color1;
                        for idx = 1:(nr-1)
                                step = (color2-colormaps(idx,:))./((nr)-idx);
                                colormaps = cat(1,colormaps,colormaps(idx,:)+step);
                        end
        end
end
