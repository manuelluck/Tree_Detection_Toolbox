    function pointid2treeid = combining_multiple_point_ids(pointer,id,h)
        pointid2treeid(:,1)     = pointer(:);
        pointid2treeid(:,2)     = id;
        pointid2treeid(:,3)     = h;
    end