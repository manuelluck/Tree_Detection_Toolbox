function [raw,hdr] = readlas(fname)
        %  function [raw,hdr] = readlas(fname);
        %  load .las data
        disp('---------------------------');
        disp('----- Running Readlas -----');
        disp('---------------------------');
        disp(' ');

        hdr = readlas_hdr(fname);

        [fid] = fopen(fname,'r','l');
        dum = fread(fid,hdr.OffsetToPointData,'char');
        [raw] = rekpoints(fid,hdr);

        fclose(fid);


        %-------------------------------------------------------------------------
        function [raw] = rekpoints(fid,hdr)
                % function to reconstruct point data from point record

                num = hdr.NumberOfPointRecords;
                x = ones(1,num);raw.y = x;raw.z = x;raw.int = x;
                raw.x = x;

                if 1
                        disp('----- Loading Aquisition Properties -----');
                        raw.rnnr = x;raw.nrrt =x;
                        disp('      Number of Returns');
                        raw.ReturnNumber = x; raw.NumberOfReturns = x;

                end

                clear x;

                disp('----- Reading Header -----');
                skip = hdr.PointDataRecordLength;
                fseek(fid,hdr.OffsetToPointData,-1);

                raw.x = fread(fid,num,'long',skip-4);
                fseek(fid,hdr.OffsetToPointData,-1);fseek(fid,4,0);

                raw.y = fread(fid,num,'long',skip-4);
                fseek(fid,hdr.OffsetToPointData,-1);fseek(fid,8,0);

                raw.z = fread(fid,num,'long',skip-4);
                fseek(fid,hdr.OffsetToPointData,-1);fseek(fid,12,0);

                raw.int = fread(fid,num,'ushort',skip-2);
                disp('      Finished');
                disp(' ');

                if 1
                        disp('----- Reading Points -----');
                        disp('      Number of Returns');
                        fseek(fid,hdr.OffsetToPointData,-1);fseek(fid,14,0);
                        % Return Number and Number of Returns are coded with 3 bits each!
                        raw.rnnr = fread(fid,num,'*ubit3',((skip-1)*8)+5);

                        disp('      Number of Returns');
                        fseek(fid,hdr.OffsetToPointData,-1);fseek(fid,14,0);
                        %move three bits
                        fread(fid,1,'*ubit3');
                        raw.rnnr = fread(fid,num,'*ubit3',((skip-1)*8)+5)*10 + raw.rnnr;
                end

                disp('      Finished');
                disp(' ');
                disp('----- Scaling -----');

                raw.x = (raw.x * hdr.XScaleFactor) + hdr.XOffset;
                raw.y = (raw.y * hdr.YScaleFactor) + hdr.YOffset;
                raw.z = (raw.z * hdr.ZScaleFactor) + hdr.ZOffset;

                disp('      Finished');
                disp(' ');

                disp('----- Done -----');

                return
        end
end

function [hdr] = readlas_hdr(fname)
        % function [hdr] = readlas_hdr(fname);
        % Function for reading and parsing binary header od .las LIDAR data files

        hdr = mkhdr;
        fid = fopen(fname,'r','l');

        hdr.FileSignature = setstr(fread(fid,4,'char')');
        hdr.FileSourceID = fread(fid,1,'ushort');
        hdr.Reserved = fread(fid,1,'ushort');
        hdr.ProjectIDGUIDDATA1 = fread(fid,1,'ulong');
        hdr.ProjectIDGUIDDATA2 = fread(fid,1,'ushort');
        hdr.ProjectIDGUIDDATA3 = fread(fid,1,'ushort');
        hdr.ProjectIDGUIDDATA4 = setstr(fread(fid,8,'char')');
        hdr.VersionMajor = fread(fid,1,'char');
        hdr.VersionMinor = fread(fid,1,'char');
        hdr.SystemIdentifier = setstr(fread(fid,32,'char')');
        hdr.GeneratingSoftware = setstr(fread(fid,32,'char')');
        hdr.FileCreationDayofYear = fread(fid,1,'ushort');
        hdr.FileCreationYear = fread(fid,1,'ushort');
        hdr.HeaderSize = fread(fid,1,'ushort');
        hdr.OffsetToPointData = fread(fid,1,'ulong');
        hdr.NumberofVariableLengthRecords = fread(fid,1,'ulong');
        hdr.PointDataFormatID = fread(fid,1,'char');
        hdr.PointDataRecordLength = fread(fid,1,'ushort');
        hdr.NumberOfPointRecords = fread(fid,1,'ulong');
        hdr.NumberOfPointsbyReturn = fread(fid,5,'ulong');
        hdr.XScaleFactor = fread(fid,1,'float64');
        hdr.YScaleFactor = fread(fid,1,'float64');
        hdr.ZScaleFactor = fread(fid,1,'float64');
        hdr.XOffset = fread(fid,1,'float64');
        hdr.YOffset = fread(fid,1,'float64');
        hdr.ZOffset = fread(fid,1,'float64');
        hdr.MaxX = fread(fid,1,'float64');
        hdr.MinX = fread(fid,1,'float64');
        hdr.MaxY = fread(fid,1,'float64');
        hdr.MinY = fread(fid,1,'float64');
        hdr.MaxZ = fread(fid,1,'float64');
        hdr.MinZ = fread(fid,1,'float64');
        fclose(fid);
        %----------------------------------------------------------------------
        function hdr = mkhdr()
                % set up blank hdr structure

                hdr.FileSignature = [];
                hdr.FileSourceID = [];
                hdr.Reserved = [];
                hdr.ProjectIDGUIDDATA1 = [];
                hdr.ProjectIDGUIDDATA2 = [];
                hdr.ProjectIDGUIDDATA3 = [];
                hdr.ProjectIDGUIDDATA4 = [];
                hdr.VersionMajor = [];
                hdr.VersionMinor = [];
                hdr.SystemIdentifier = [];
                hdr.GeneratingSoftware = [];
                hdr.FileCreationDayofYear = [];
                hdr.FileCreationYear = [];
                hdr.HeaderSize = [];
                hdr.OffsetToPointData = [];
                hdr.NumberofVariableLengthRecords = [];
                hdr.PointDataFormatID = [];
                hdr.PointDataRecordLength = [];
                hdr.NumberOfPointRecords = [];
                hdr.NumberOfPointsbyReturn = [];
                hdr.XScaleFactor = [];
                hdr.YScaleFactor = [];
                hdr.ZScaleFactor = [];
                hdr.XOffset = [];
                hdr.YOffset = [];
                hdr.ZOffset = [];
                hdr.MaxX = [];
                hdr.MinX = [];
                hdr.MaxY = [];
                hdr.MinY = [];
                hdr.MaxZ = [];
                hdr.MinZ = [];
        end
end
