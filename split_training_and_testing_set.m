function [training_set_indx, testing_set_indx] = split_training_and_testing_set(hsi_destination_dir, rgb_destination_dir,index_dir, training_testing_dir)
%function [train_idx, test_idx] = split_tr_te(refl_dir, rgb_dir, nPixel, wv)

hsi_files = dir(fullfile(hsi_destination_dir, '*.mat'));
rgb_files = dir(fullfile(rgb_destination_dir, '*.mat'));

num_files = size(hsi_files, 1);

nPixel = 1;

%----------------------------------------------------------------------------------------------------------
%| Training and Testing set generation (Randomly selected ID)
%  Here 70% is taken as Training data and 30% is selected as testing data
%----------------------------------------------------------------------------------------------------------

training_set_indx = randperm(num_files, round(num_files * 0.70)); 

nTrainset = length(training_set_indx);

testing_set_indx = setdiff(1:num_files, training_set_indx)

nTestset = length(testing_set_indx);

%-------Storing the Traning and Testing data set index--------------------

filename=fullfile(index_dir, 'total_index.mat');

save(filename,'training_set_indx','testing_set_indx');


%----------------------------------------------------------------------------------------------------------
%| Here we are preparing the training data set an stored into an Array as
%  nPixel*nTrainset, nWV, Here we have ONE pixel for each sample, so we are
%  storing 29 x 1024 size of HSI and 29 x 3  size of RGB data. 
%  70% of 41 = 29 will be taken as Training set and 12
%  number of data will be considred as testing set.

% Total number of intensity points = 1024
%----------------------------------------------------------------------------------------------------------

refl_spec_tr = zeros(nTrainset, 1024);
rgb_img_tr = zeros(nTrainset, 3);

i = 1;

for j = 1:length(training_set_indx)
    
    k = training_set_indx(j); % the first training data if j=1
    
    %-----------------------------------------------------
    %| Reflection spectra/HSI are collected from the refl_dir |
    %-----------------------------------------------------
    refl_file = fullfile(hsi_destination_dir, hsi_files(k).name);
    load(refl_file);
    
    nor2 = reshape(nor_hsi_data, [], size(nor_hsi_data,2));
    nor= nor2;
    refl_spec_tr(i:i+nPixel-1,:) = nor;
    
    %-----------------------------------------------------
    %| RGB data are collected from the refl_dir          |
    %-----------------------------------------------------
    
    rgb_file = fullfile(rgb_destination_dir, rgb_files(k).name);
    load(rgb_file);
    rgb = nor_rgb_data;
   
    rgb2 = reshape(rgb, [], size(rgb,2));
    rgb_img_tr(i:i+nPixel-1,:) = rgb2;

    %-----------------------------------------------------
    %| Going for next data                                |
    %-----------------------------------------------------
    
    
    i = i + 1; % Since only ONE pixel information is processed each time
    
    %-----------------------------------------------------
    %| % Clear/Remove the hsi and rgb memory             |
    %-----------------------------------------------------
    
    clear nor_hsi_data;
    clear nor_rgb_data;
    
end

%----- Storing the training spectra ------------------------
filename1=fullfile(training_testing_dir, 'refl_spec_train.mat');
save (filename1, 'refl_spec_tr', '-v7.3'); 

%----- Storing the training RGB ----------------------------
filename2=fullfile(training_testing_dir, 'rgb_image_train.mat');
save (filename2,'rgb_img_tr', '-v7.3'); 








%----------------------------------------------------------------------------------------------------------
%| Here we are preparing the testing data set an stored into an Array as
%  nPixel*nTestset, nWV, Here we have ONE pixel for each sample, so we are
%  storing 12 x 1024 size of HSI and 12 x 3  size of RGB data. 
%  70% of 41 = 29 will be taken as Training set and 12
%  number of data will be considred as testing set.

% Total number of intensity points = 1024
%----------------------------------------------------------------------------------------------------------

refl_spec_te = zeros(nTestset, 1024);
rgb_img_te = zeros(nTestset, 3);

i = 1;

for j = 1:length(testing_set_indx)
    
    k = testing_set_indx(j); % the first training data if j=1
    
    %-----------------------------------------------------
    %| Reflection spectra/HSI are collected from the refl_dir |
    %-----------------------------------------------------
    refl_file = fullfile(hsi_destination_dir, hsi_files(k).name);
    load(refl_file);
    
    nor2 = reshape(nor_hsi_data, [], size(nor_hsi_data,2)); % reshape the matrix = 1 x 1024 for each pixel
    nor= nor2;
    refl_spec_te(i:i+nPixel-1,:) = nor;
    
    %-----------------------------------------------------
    %| RGB data are collected from the refl_dir          |
    %-----------------------------------------------------
    
    rgb_file = fullfile(rgb_destination_dir, rgb_files(k).name);
    load(rgb_file);
    rgb = nor_rgb_data;
   
    rgb2 = reshape(rgb, [], size(rgb,2)); % reshape the matrix = 1 x 3 for each pixel
    rgb_img_te(i:i+nPixel-1,:) = rgb2;

    %-----------------------------------------------------
    %| Going for next data                                |
    %-----------------------------------------------------
    
    
    i = i + 1; % Since only ONE pixel information is processed each time
    
    %-----------------------------------------------------
    %| % Clear/Remove the hsi and rgb memory             |
    %-----------------------------------------------------
    
    clear nor_hsi_data;
    clear nor_rgb_data;
    
end

%----- Storing the testing spectra ------------------------
filename1=fullfile(training_testing_dir, 'refl_spec_test.mat');
save (filename1, 'refl_spec_te', '-v7.3'); 

%----- Storing the testing RGB ----------------------------
filename2=fullfile(training_testing_dir, 'rgb_image_test.mat');
save (filename2,'rgb_img_te', '-v7.3'); 


end
