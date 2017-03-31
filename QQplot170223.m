% In Jutras & Buffalo (2009, PNAS), you recorded activity in 131 hippocampal neurons.
% For each neuron, you have many recordings made over a 600 ms window when the stimulus was present.
% Half the time the stimulus was novel and half the time the stimulus was repeated (maybe it wasn’t
% half and half, but it doesn’t matter). For each session, you also have the mean and standard
% deviation of spike counts for an 800 ms background period. Thus, each spike count during the
% 600-ms stimulus presentation period could be normalized by:
% 
% normalized score  =  {(spikes-sub-i) minus (.75*background mean)} / (.75*background standard deviation)
% 
% where spikes-sub-i is the number of spikes observed during stimulus presentation on trial i, and
% the .75 multiplier is in there just to correct for the fact that the baseline period was longer
% than the stimulus recording period (i.e., 600/800 = .75).
% 
% Collapsing over all sessions, you’d have thousands of normalized spike counts for novel items and
% thousands of normalized spike counts for repeated items. These two distinct distributions of
% recordings (one for novel items and one for repeated items) are what we refer to as “omnibus”
% distributions, and the two omnibus distributions are plotted against each other to make a QQ plot.
% 
% If you have *exactly* the same number of observations for novel and repeated items (e.g., 10,173
% recordings for each), the QQ plot is really easy to do. You’d just make two columns of numbers,
% with one column being the 10,173 normalized recordings for novel items and the other being the
% 10,173 normalized recordings for repeated items. Next, you’d independently sort each column from
% smallest to largest, and then you’d plot one column against the other. That’s the empirical QQ plot
% (not to be confused with a theoretical QQ plot).
% 
% If the number of observations in each column is unequal (as is usually the case), then you can
% just use the qqplot function in MATLAB to make the plot. Of course, you can just use that function
% if the number of observations happens to be equal as well. 
% 
% Simple as that! As I said, you could just try it without normalizing the scores first, but I have 
% found normalized scores behave better. This plot may not reveal anything of note, but it has the
% potential to reveal interesting phenomena that would not otherwise be detected, which is why it
% seems worth doing to me.

% http://www.itl.nist.gov/div898/handbook/eda/section3/eda33o.htm

%%
% all visually responsive
rsplst = ['IW0604173.2b'; 'IW0604173.3a'; 'IW0604183.2a'; 'IW0604183.3a';
    'IW0604183.4a'; 'IW0604212.1a'; 'IW0604212.2a'; 'IW0604212.3a';
    'IW0604212.4a'; 'IW0606203.1a'; 'IW0606203.4a'; 'IW0606212.2a';
    'IW0606212.3a'; 'IW0606223.1a'; 'IW0606283.2a'; 'IW0606283.4a';
    'IW0606292.1a'; 'IW0606292.1b'; 'IW0606292.2a'; 'IW0606292.3b';
    'IW0606292.4a'; 'IW0607052.2a'; 'IW0607072.1a'; 'IW0607072.3a';
    'IW0607122.4a'; 'IW0607133.3a'; 'IW0607172.2a'; 'IW0607202.1a';
    'IW0607202.2a'; 'IW0607253.2a'; 'IW0607262.1b'; 'IW0607272.2a';
    'IW0608022.1b'; 'IW0608022.3a'; 'IW0608042.1a'; 'MP0702015.1a';
    'MP0702015.2a'; 'MP0702015.3a'; 'MP0702015.4a'; 'MP0702084.1a';
    'MP0702084.2a'; 'MP0702084.2b'; 'MP0702084.3a'; 'MP0702084.4a';
    'MP0702093.3a'; 'MP0702093.4a'; 'MP0702123.1a'; 'MP0702123.2a';
    'MP0702123.3a'; 'MP0702123.4a'; 'MP0702133.1a'; 'MP0702133.2a';
    'MP0702133.3a'; 'MP0702133.3b'; 'MP0702224.1a'; 'MP0702224.2a';
    'MP0702224.3a'; 'MP0702233.1a'; 'MP0702233.3a'; 'MP0702273.3a';
    'MP0704113.2a'; 'MP0704113.3a'; 'MP0704132.1a'; 'MP0704132.3a';
    'MP0704132.3b'; 'MP0704132.4a'; 'MP0704192.1a'; 'MP0704192.2a';
    'MP0704192.3a'; 'MP0704232.3a'; 'MP0705022.1a'; 'MP0705022.2a';
    'MP0705022.2b'; 'MP0705102.4a'; 'MP0705142.1a'; 'MP0705142.1c';
    'MP0705142.3a'; 'MP0705142.4a'; 'MP0803202.2a'; 'MP0803202.3a';
    'MP0803212.2a'; 'MP0803212.3a'; 'MP0803252.1a'; 'MP0803252.2a'];

% % all differentially responsive
% rsplst = ['IW0604173.2b'; 'IW0604183.4a'; 'IW0604212.1a'; 'IW0604212.3a';
%     'IW0606212.2a'; 'IW0606223.1a'; 'IW0606292.1b'; 'IW0606292.4a';
%     'IW0607052.2a'; 'IW0607133.3a'; 'IW0607272.2a'; 'IW0608022.1b';
%     'IW0608022.3a'; 'MP0702015.2a'; 'MP0702015.4a'; 'MP0702084.1a';
%     'MP0702084.2a'; 'MP0702084.3a'; 'MP0702093.3a'; 'MP0702123.1a';
%     'MP0702123.3a'; 'MP0702133.2a'; 'MP0702133.3a'; 'MP0704113.3a';
%     'MP0704132.4a'; 'MP0704192.1a'; 'MP0704192.3a'; 'MP0705142.3a';
%     'MP0803212.2a'; 'MP0803252.1a';];

datdir = 'R:\Mike\Matlab_analyzed_data_Emory_NHP\SUA-VPC\FTrate\090225\';

batch1 = [];
batch2 = [];
for fillop = 1:size(rsplst,1)
    fid = rsplst(fillop,1:9)
    cellid = rsplst(fillop,11:12)

%     % all presentations
%     f1 = load(fullfile(datdir,[fid 'fratenov.mat']));
%     f2 = load(fullfile(datdir,[fid 'fraterep.mat']));
    % only presentations without back-to-back repetitions
    f1 = load(fullfile(datdir,[fid 'fratenov_lag.mat']));
    f2 = load(fullfile(datdir,[fid 'fraterep_lag.mat']));

    spkind = strmatch('s',f1.timelock.label);
    spklab = cell2mat(f1.timelock.label(spkind));

    for chnlop = 1:length(spkind)

        if ismember([fid '.' spklab(chnlop,6:7)],rsplst,'rows')

            % determine baseline: mean # of spikes across trial baseline periods
            basetim1 = ft_nearest(f1.timelock.time,-0.8):ft_nearest(f1.timelock.time,-0.001);
            basetim2 = ft_nearest(f2.timelock.time,-0.8):ft_nearest(f2.timelock.time,-0.001);
            % total number of spikes in each baseline period (each trial)
            base1 = squeeze(sum(f1.timelock.trial(:,chnlop,basetim1),3));
            base2 = squeeze(sum(f2.timelock.trial(:,chnlop,basetim2),3));
            % mean # of spikes across 800 ms baseline periods
            basemean = mean([base1; base2]);
            basestd = std([base1; base2]);
            
            resp1tim = ft_nearest(f1.timelock.time,0.1):ft_nearest(f1.timelock.time,0.599);
            resp2tim = ft_nearest(f2.timelock.time,0.1):ft_nearest(f2.timelock.time,0.599);
            resp1trl = ~isnan(squeeze(f1.timelock.trial(:,chnlop,ft_nearest(f1.timelock.time,0.599))));
            resp2trl = ~isnan(squeeze(f2.timelock.trial(:,chnlop,ft_nearest(f2.timelock.time,0.599))));
            resp1 = squeeze(sum(f1.timelock.trial(resp1trl,chnlop,resp1tim),3));
            resp2 = squeeze(sum(f2.timelock.trial(resp2trl,chnlop,resp2tim),3));
            
            % normalized score  =  {(spikes-sub-i) minus (.75*background mean)} / (.75*background standard deviation)
            resp1norm = (resp1-0.625*basemean) / (0.625*basestd);
            resp2norm = (resp2-0.625*basemean) / (0.625*basestd);
            
            batch1 = [batch1; resp1norm];
            batch2 = [batch2; resp2norm];
            
        end
        
    end
    
end

figure;qqplot(batch1,batch2)
xlabel('Novel Image Quantiles')
ylabel('Repeat Image Quantiles')

%% separate based on whether cells show increased or decreased firing rel. to baseline

frate = load('R:\Mike\Matlab_analyzed_data_Emory_NHP\MATfiles_from_MATLABfolder_random\frateSUA.mat');
clear rsplst

datdir = 'R:\Mike\Matlab_analyzed_data_Emory_NHP\SUA-VPC\FTrate\090225\';

% increased firing rate
batch1 = [];
batch2 = [];
for fillop = 1:size(frate.inclist,1)
    fid = frate.inclist(fillop,1:9)
    cellid = frate.inclist(fillop,11:12)

%     % all presentations
%     f1 = load(fullfile(datdir,[fid 'fratenov.mat']));
%     f2 = load(fullfile(datdir,[fid 'fraterep.mat']));
    % only presentations without back-to-back repetitions
    f1 = load(fullfile(datdir,[fid 'fratenov_lag.mat']));
    f2 = load(fullfile(datdir,[fid 'fraterep_lag.mat']));

    spkind = strmatch('s',f1.timelock.label);
    spklab = cell2mat(f1.timelock.label(spkind));

    for chnlop = 1:length(spkind)

        if ismember([fid '.' spklab(chnlop,6:7)],frate.inclist,'rows')

            % determine baseline: mean # of spikes across trial baseline periods
            basetim1 = ft_nearest(f1.timelock.time,-0.8):ft_nearest(f1.timelock.time,-0.001);
            basetim2 = ft_nearest(f2.timelock.time,-0.8):ft_nearest(f2.timelock.time,-0.001);
            % total number of spikes in each baseline period (each trial)
            base1 = squeeze(sum(f1.timelock.trial(:,chnlop,basetim1),3));
            base2 = squeeze(sum(f2.timelock.trial(:,chnlop,basetim2),3));
            % mean # of spikes across 800 ms baseline periods
            basemean = mean([base1; base2]);
            basestd = std([base1; base2]);
            
            resp1tim = ft_nearest(f1.timelock.time,0.1):ft_nearest(f1.timelock.time,0.599);
            resp2tim = ft_nearest(f2.timelock.time,0.1):ft_nearest(f2.timelock.time,0.599);
            resp1trl = ~isnan(squeeze(f1.timelock.trial(:,chnlop,ft_nearest(f1.timelock.time,0.599))));
            resp2trl = ~isnan(squeeze(f2.timelock.trial(:,chnlop,ft_nearest(f2.timelock.time,0.599))));
            resp1 = squeeze(sum(f1.timelock.trial(resp1trl,chnlop,resp1tim),3));
            resp2 = squeeze(sum(f2.timelock.trial(resp2trl,chnlop,resp2tim),3));
            
            % normalized score  =  {(spikes-sub-i) minus (.75*background mean)} / (.75*background standard deviation)
            resp1norm = (resp1-0.625*basemean) / (0.625*basestd);
            resp2norm = (resp2-0.625*basemean) / (0.625*basestd);
            
            batch1 = [batch1; resp1norm];
            batch2 = [batch2; resp2norm];
            
        end
        
    end
    
end

figure;qqplot(batch1,batch2)
xlabel('Novel Image Quantiles')
ylabel('Repeat Image Quantiles')
title('"Enhanced": Cells that fire faster to image onset')

% decreased firing rate
batch1 = [];
batch2 = [];
for fillop = 1:size(frate.declist,1)
    fid = frate.declist(fillop,1:9)
    cellid = frate.declist(fillop,11:12)

%     % all presentations
%     f1 = load(fullfile(datdir,[fid 'fratenov.mat']));
%     f2 = load(fullfile(datdir,[fid 'fraterep.mat']));
    % only presentations without back-to-back repetitions
    f1 = load(fullfile(datdir,[fid 'fratenov_lag.mat']));
    f2 = load(fullfile(datdir,[fid 'fraterep_lag.mat']));

    spkind = strmatch('s',f1.timelock.label);
    spklab = cell2mat(f1.timelock.label(spkind));

    for chnlop = 1:length(spkind)

        if ismember([fid '.' spklab(chnlop,6:7)],frate.declist,'rows')

            % determine baseline: mean # of spikes across trial baseline periods
            basetim1 = ft_nearest(f1.timelock.time,-0.8):ft_nearest(f1.timelock.time,-0.001);
            basetim2 = ft_nearest(f2.timelock.time,-0.8):ft_nearest(f2.timelock.time,-0.001);
            % total number of spikes in each baseline period (each trial)
            base1 = squeeze(sum(f1.timelock.trial(:,chnlop,basetim1),3));
            base2 = squeeze(sum(f2.timelock.trial(:,chnlop,basetim2),3));
            % mean # of spikes across 800 ms baseline periods
            basemean = mean([base1; base2]);
            basestd = std([base1; base2]);
            
            resp1tim = ft_nearest(f1.timelock.time,0.1):ft_nearest(f1.timelock.time,0.599);
            resp2tim = ft_nearest(f2.timelock.time,0.1):ft_nearest(f2.timelock.time,0.599);
            resp1trl = ~isnan(squeeze(f1.timelock.trial(:,chnlop,ft_nearest(f1.timelock.time,0.599))));
            resp2trl = ~isnan(squeeze(f2.timelock.trial(:,chnlop,ft_nearest(f2.timelock.time,0.599))));
            resp1 = squeeze(sum(f1.timelock.trial(resp1trl,chnlop,resp1tim),3));
            resp2 = squeeze(sum(f2.timelock.trial(resp2trl,chnlop,resp2tim),3));
            
            % normalized score  =  {(spikes-sub-i) minus (.75*background mean)} / (.75*background standard deviation)
            resp1norm = (resp1-0.625*basemean) / (0.625*basestd);
            resp2norm = (resp2-0.625*basemean) / (0.625*basestd);
            
            batch1 = [batch1; resp1norm];
            batch2 = [batch2; resp2norm];
            
        end
        
    end
    
end

figure;qqplot(batch1,batch2)
xlabel('Novel Image Quantiles')
ylabel('Repeat Image Quantiles')
title('"Depressed": Cells that fire slower to image onset')

%% all visually responsive, but take absolute value of normalized firing rates

rsplst = ['IW0604173.2b'; 'IW0604173.3a'; 'IW0604183.2a'; 'IW0604183.3a';
    'IW0604183.4a'; 'IW0604212.1a'; 'IW0604212.2a'; 'IW0604212.3a';
    'IW0604212.4a'; 'IW0606203.1a'; 'IW0606203.4a'; 'IW0606212.2a';
    'IW0606212.3a'; 'IW0606223.1a'; 'IW0606283.2a'; 'IW0606283.4a';
    'IW0606292.1a'; 'IW0606292.1b'; 'IW0606292.2a'; 'IW0606292.3b';
    'IW0606292.4a'; 'IW0607052.2a'; 'IW0607072.1a'; 'IW0607072.3a';
    'IW0607122.4a'; 'IW0607133.3a'; 'IW0607172.2a'; 'IW0607202.1a';
    'IW0607202.2a'; 'IW0607253.2a'; 'IW0607262.1b'; 'IW0607272.2a';
    'IW0608022.1b'; 'IW0608022.3a'; 'IW0608042.1a'; 'MP0702015.1a';
    'MP0702015.2a'; 'MP0702015.3a'; 'MP0702015.4a'; 'MP0702084.1a';
    'MP0702084.2a'; 'MP0702084.2b'; 'MP0702084.3a'; 'MP0702084.4a';
    'MP0702093.3a'; 'MP0702093.4a'; 'MP0702123.1a'; 'MP0702123.2a';
    'MP0702123.3a'; 'MP0702123.4a'; 'MP0702133.1a'; 'MP0702133.2a';
    'MP0702133.3a'; 'MP0702133.3b'; 'MP0702224.1a'; 'MP0702224.2a';
    'MP0702224.3a'; 'MP0702233.1a'; 'MP0702233.3a'; 'MP0702273.3a';
    'MP0704113.2a'; 'MP0704113.3a'; 'MP0704132.1a'; 'MP0704132.3a';
    'MP0704132.3b'; 'MP0704132.4a'; 'MP0704192.1a'; 'MP0704192.2a';
    'MP0704192.3a'; 'MP0704232.3a'; 'MP0705022.1a'; 'MP0705022.2a';
    'MP0705022.2b'; 'MP0705102.4a'; 'MP0705142.1a'; 'MP0705142.1c';
    'MP0705142.3a'; 'MP0705142.4a'; 'MP0803202.2a'; 'MP0803202.3a';
    'MP0803212.2a'; 'MP0803212.3a'; 'MP0803252.1a'; 'MP0803252.2a'];

% % all differentially responsive
% rsplst = ['IW0604173.2b'; 'IW0604183.4a'; 'IW0604212.1a'; 'IW0604212.3a';
%     'IW0606212.2a'; 'IW0606223.1a'; 'IW0606292.1b'; 'IW0606292.4a';
%     'IW0607052.2a'; 'IW0607133.3a'; 'IW0607272.2a'; 'IW0608022.1b';
%     'IW0608022.3a'; 'MP0702015.2a'; 'MP0702015.4a'; 'MP0702084.1a';
%     'MP0702084.2a'; 'MP0702084.3a'; 'MP0702093.3a'; 'MP0702123.1a';
%     'MP0702123.3a'; 'MP0702133.2a'; 'MP0702133.3a'; 'MP0704113.3a';
%     'MP0704132.4a'; 'MP0704192.1a'; 'MP0704192.3a'; 'MP0705142.3a';
%     'MP0803212.2a'; 'MP0803252.1a';];

datdir = 'R:\Mike\Matlab_analyzed_data_Emory_NHP\SUA-VPC\FTrate\090225\';

batch1 = [];
batch2 = [];
for fillop = 1:size(rsplst,1)
    fid = rsplst(fillop,1:9)
    cellid = rsplst(fillop,11:12)

%     % all presentations
%     f1 = load(fullfile(datdir,[fid 'fratenov.mat']));
%     f2 = load(fullfile(datdir,[fid 'fraterep.mat']));
    % only presentations without back-to-back repetitions
    f1 = load(fullfile(datdir,[fid 'fratenov_lag.mat']));
    f2 = load(fullfile(datdir,[fid 'fraterep_lag.mat']));

    spkind = strmatch('s',f1.timelock.label);
    spklab = cell2mat(f1.timelock.label(spkind));

    for chnlop = 1:length(spkind)

        if ismember([fid '.' spklab(chnlop,6:7)],rsplst,'rows')

            % determine baseline: mean # of spikes across trial baseline periods
            basetim1 = ft_nearest(f1.timelock.time,-0.8):ft_nearest(f1.timelock.time,-0.001);
            basetim2 = ft_nearest(f2.timelock.time,-0.8):ft_nearest(f2.timelock.time,-0.001);
            % total number of spikes in each baseline period (each trial)
            base1 = squeeze(sum(f1.timelock.trial(:,chnlop,basetim1),3));
            base2 = squeeze(sum(f2.timelock.trial(:,chnlop,basetim2),3));
            % mean # of spikes across 800 ms baseline periods
            basemean = mean([base1; base2]);
            basestd = std([base1; base2]);
            
            resp1tim = ft_nearest(f1.timelock.time,0.1):ft_nearest(f1.timelock.time,0.599);
            resp2tim = ft_nearest(f2.timelock.time,0.1):ft_nearest(f2.timelock.time,0.599);
            resp1trl = ~isnan(squeeze(f1.timelock.trial(:,chnlop,ft_nearest(f1.timelock.time,0.599))));
            resp2trl = ~isnan(squeeze(f2.timelock.trial(:,chnlop,ft_nearest(f2.timelock.time,0.599))));
            resp1 = squeeze(sum(f1.timelock.trial(resp1trl,chnlop,resp1tim),3));
            resp2 = squeeze(sum(f2.timelock.trial(resp2trl,chnlop,resp2tim),3));
            
            % normalized score  =  {(spikes-sub-i) minus (.75*background mean)} / (.75*background standard deviation)
            resp1norm = abs((resp1-0.625*basemean) / (0.625*basestd));
            resp2norm = abs((resp2-0.625*basemean) / (0.625*basestd));
            
            batch1 = [batch1; resp1norm];
            batch2 = [batch2; resp2norm];
            
        end
        
    end
    
end

figure;qqplot(batch1,batch2)
xlabel('Novel Image Quantiles')
ylabel('Repeat Image Quantiles')

%% all NON-visually responsive

datdir = 'R:\Mike\Matlab_analyzed_data_Emory_NHP\SUA-VPC\FTrate\090225\';

% norsplst = [frate.badbas; frate.noresp];
norsplst = [frate.noresp];

batch1 = [];
batch2 = [];
for fillop = 1:size(norsplst,1)
    fid = norsplst(fillop,1:9)
    cellid = norsplst(fillop,11:12)

%     % all presentations
%     f1 = load(fullfile(datdir,[fid 'fratenov.mat']));
%     f2 = load(fullfile(datdir,[fid 'fraterep.mat']));
    % only presentations without back-to-back repetitions
    f1 = load(fullfile(datdir,[fid 'fratenov_lag.mat']));
    f2 = load(fullfile(datdir,[fid 'fraterep_lag.mat']));

    spkind = strmatch('s',f1.timelock.label);
    spklab = cell2mat(f1.timelock.label(spkind));

    for chnlop = 1:length(spkind)

        if ismember([fid '.' spklab(chnlop,6:7)],norsplst,'rows')

            % determine baseline: mean # of spikes across trial baseline periods
            basetim1 = ft_nearest(f1.timelock.time,-0.8):ft_nearest(f1.timelock.time,-0.001);
            basetim2 = ft_nearest(f2.timelock.time,-0.8):ft_nearest(f2.timelock.time,-0.001);
            % total number of spikes in each baseline period (each trial)
            base1 = squeeze(sum(f1.timelock.trial(:,chnlop,basetim1),3));
            base2 = squeeze(sum(f2.timelock.trial(:,chnlop,basetim2),3));
            % mean # of spikes across 800 ms baseline periods
            basemean = mean([base1; base2]);
            basestd = std([base1; base2]);
            
            resp1tim = ft_nearest(f1.timelock.time,0.1):ft_nearest(f1.timelock.time,0.599);
            resp2tim = ft_nearest(f2.timelock.time,0.1):ft_nearest(f2.timelock.time,0.599);
            resp1trl = ~isnan(squeeze(f1.timelock.trial(:,chnlop,ft_nearest(f1.timelock.time,0.599))));
            resp2trl = ~isnan(squeeze(f2.timelock.trial(:,chnlop,ft_nearest(f2.timelock.time,0.599))));
            resp1 = squeeze(sum(f1.timelock.trial(resp1trl,chnlop,resp1tim),3));
            resp2 = squeeze(sum(f2.timelock.trial(resp2trl,chnlop,resp2tim),3));
            
            % normalized score  =  {(spikes-sub-i) minus (.75*background mean)} / (.75*background standard deviation)
            resp1norm = (resp1-0.625*basemean) / (0.625*basestd);
            resp2norm = (resp2-0.625*basemean) / (0.625*basestd);
            
            batch1 = [batch1; resp1norm];
            batch2 = [batch2; resp2norm];
            
        end
        
    end
    
end

figure;qqplot(batch1,batch2)
xlabel('Novel Image Quantiles')
ylabel('Repeat Image Quantiles')