function godiff_fun(subDir)

    % Compute visual image differences.
   
    tic;
    %dbstop if error

    path(path,'util/'); % Help functions

    % pr = readtable('./allnew_29jul.csv');

    players = {'02','03','04','05','06','07','08','09','10'};
    rounds = 1:30;

    % SSIM params.
    K = [0.05 0.05];
    window = ones(8);
    L = 1;


    imgsDir = './imgs/';

    headers = {
        'session', ...
        'com', ...
        'coo', ...
        'choice', ...
        'rand', ...
        'p.number', ...
        'round', ...
        'img.div.corr', ...
        'img.div.ssim', ...
        'img.div.ssim.idx', ...
        'img.div.ssim.L1', ...
        'img.div.surf.distN', ...
        'img.div.surf.distTot', ...
        'img.div.surf.point.count', ...
        'img.inn', ...
        'img.change'
    };

    outFile = 'imgdiff.csv';

    % This function overwrites exiting files.
    %write_csv_headers(outFile, headers);

    fid = fopen(outFile, 'a');

    dirPath = [imgsDir subDir];

    % compute session, com, choice.
    if (strcmp(subDir, 'com_rand_25_jan_2013'))
        com = 1;
        coo = 0;
        choice = 0;
        rand = 1;
        session = 1;
    elseif (strcmp(subDir, 'com_choice_25_jan_2013'))
        com = 1;
        coo = 0;
        choice = 1;
        rand = 0;
        session = 2;


    elseif (strcmp(subDir, 'coo_rand_30_jan_2013'))
        com = 0;
        coo = 1;
        choice = 0;
        rand = 1;
        session = 3; 
    elseif (strcmp(subDir, 'coo_choice_30_jan_2013'))
        com = 0;
        coo = 1;
        choice = 1;
        rand = 0;
        session = 4;                 


    elseif (strcmp(subDir, 'com_choice_31_jan_2013'))
        com = 1;
        coo = 0;
        choice = 1;
        rand = 0;
        session = 5;
    elseif (strcmp(subDir, 'coo_rand_31_jan_2013'))
        com = 0;
        coo = 1;
        choice = 0;
        rand = 1;
        session = 6;


    elseif (strcmp(subDir, 'com_rand_1_feb_2013'))
        com = 1;
        coo = 0;
        choice = 0;
        rand = 1;
        session = 7;       
    elseif (strcmp(subDir, 'coo_choice_1_feb_2013'))
        com = 0;
        coo = 1;
        choice = 1;
        rand = 0;
        session = 8;          


    elseif (strcmp(subDir, 'com_rand_4_feb_2013'))
        com = 1;
        coo = 0;
        choice = 0;
        rand = 1;
        session = 9;                     
    elseif (strcmp(subDir, 'coo_rand_4_feb_2013'))
        com = 0;
        coo = 1;
        choice = 0;
        rand = 1;
        session = 10;    

    elseif (strcmp(subDir, 'coo_choice_6_feb_2013'))
        com = 0;
        coo = 1;
        choice = 1;
        rand = 0;
        session = 11;   
    elseif (strcmp(subDir, 'com_choice_6_feb_2013'))
        com = 1;
        coo = 0;
        choice = 1;
        rand = 0;
        session = 12;

    elseif (strcmp(subDir, 'com_rand_7_feb_2013'))
        com = 1;
        coo = 0;
        choice = 0;
        rand = 1;
        session = 13;
    elseif (strcmp(subDir, 'coo_rand_7_feb_2013'))
        com = 0;
        coo = 1;
        choice = 0;
        rand = 1;
        session = 14;


    elseif (strcmp(subDir, 'com_choice_8_feb_2013'))
        com = 1;
        coo = 0;
        choice = 1;
        rand = 0;
        session = 15;
    elseif (strcmp(subDir, 'coo_choice_8_feb_2013'))
        com = 0;
        coo = 1;
        choice = 1;
        rand = 0;
        session = 16;

    else
        subDir
        error('AH');

    end

    for r = 1:length(rounds)

        round = int2str(rounds(r));

        if (strcmp(subDir, 'coo_rand_7_feb_2013'))
            if (rounds(r) > 26)
                continue;
            end
        end

        for p = 1:length(players)

            player = players{p};

            imgA = imread([ dirPath '/' player '_' round '.pgm' ]);
            % hisA = histImage(imgA);

            divCorr2 = 0;
            divEMD = 0;
            divSSIM = 0;
            divSSIM_idx = 0;
            divSSIM_L1 = 0;
            divSURF_distN = 0;
            divSURF_distTot = 0;
            divSURF_pointCount = 0;

            for p2 = 1:length(players)
                if (p2 ~= p)
                    playerB = players{p2};
                    imgB = imread([ dirPath '/' playerB '_' round '.pgm' ]);

                    % hisB = histImage(imgB);

                    mycorr = corr2(imgA, imgB);

                    divCorr2 = divCorr2 + mycorr;
                    % divEMD = divEMD + hcompare_EMD(hisA, hisB);
                    divSSIM = divSSIM + ssim(imgB, imgA);                    
                    divSSIM_idx = divSSIM_idx + ssim_index(imgB, imgA);

                    divSSIM_L1 = divSSIM_L1 + ssim(imgB, imgA, K, window, L);

                    [divSURF_distN_tmp divSURF_distTot_tmp] = surf_dist(imgB, imgA, 30);
                    
                    divSURF_distN = divSURF_distN + divSURF_distN_tmp;
                    divSURF_distTot = divSURF_distTot + divSURF_distTot_tmp;

                    divSURF_pointCount = divSURF_pointCount + surf_countpoints(imgB, imgA);

                end
            end


            divCorr2 = divCorr2 / (length(players) - 1);
            % divEMD = divEMD / (length(players) - 1);
            divEMD = 'NA';
            divSSIM = divSSIM / (length(players) - 1);
            divSSIM_idx = divSSIM_idx / (length(players) - 1);
            divSSIM_L1 = divSSIM_L1 / (length(players) - 1);

            divSURF_distN = divSURF_distN / (length(players) - 1);
            divSURF_distTot = divSURF_distTot / (length(players) - 1);
            
            divSURF_pointCount = divSURF_pointCount / (length(players) - 1);

            str = sprintf('%u,%u,%u,%u,%u,%u,%s,%.4f,%.4f,%.4f,%.4f,%.4f,%.4f,%.4f,%s,%s', ...
                           session, com, coo, choice, rand, ...
                           (p+1), round, divCorr2, ...
                           divSSIM, divSSIM_idx, divSSIM_L1, ...
                           divSURF_distN, divSURF_distTot, divSURF_pointCount, ...
                           'NA', 'NA');

            fprintf(fid, '%s\n', str);

        end


    end

    fclose(fid);
    toc
end

