clc;
clear all;
%------------------------------------------------------------------------
%| Mat files source directory
%------------------------------------------------------------------------

hsi_data_source_dir='/Users/kamrul/Local_HDD/Research/Purdue_University/Kamrul Hasan/data/hsi';
rgb_data_source_dir='/Users/kamrul/Local_HDD/Research/Purdue_University/Kamrul Hasan/data/rgb';

%------------------------------------------------------------------------
%| Mat files destination dir
%------------------------------------------------------------------------
rgb_destination_dir='/Users/kamrul/Local_HDD/Research/Purdue_University/Kamrul Hasan/data/avg_data_rgb_hsi/avg_rgb';
hsi_destination_dir='/Users/kamrul/Local_HDD/Research/Purdue_University/Kamrul Hasan/data/avg_data_rgb_hsi/split_hsi';

%------------------------------------------------------------------------
%| Use the var name to load the mat file
%------------------------------------------------------------------------
rgb_data_var_name='hgn';
rgb_mat_file_name='nor-rgb.mat';

hsi_data_var_name='n1';
hsi_mat_file_name='nor-hsi.mat';
%------------------------------------------------------------------------
%| The rgb data in the given dir (rgb_destination_dir)
%------------------------------------------------------------------------
% To work on it, we should remove the comment from the next line
%------------------------------------------------------------------------

%spliting_rgb_mat_file_data(rgb_data_source_dir, rgb_mat_file_name, rgb_data_var_name, rgb_destination_dir);

%------------------------------------------------------------------------
%| The hsi data in the given dir (hsi_destination_dir)
%------------------------------------------------------------------------
% To work on it, we should remove the comment from the next line
%------------------------------------------------------------------------

%spliting_hsi_mat_file_data2(hsi_data_source_dir, hsi_mat_file_name, hsi_data_var_name, hsi_destination_dir);


%------------------------------------------------------------------------
% To work on it, we should remove the comment from the next line
%------------------------------------------------------------------------

index_dir='/Users/kamrul/Local_HDD/Research/Purdue_University/Kamrul Hasan/data/index_dir';

reconspec_dir = '/Users/kamrul/Local_HDD/Research/Purdue_University/Kamrul Hasan/data';

rgb_destination_dir='/Users/kamrul/Local_HDD/Research/Purdue_University/Kamrul Hasan/data/avg_data_rgb_hsi/avg_rgb';

hsi_destination_dir='/Users/kamrul/Local_HDD/Research/Purdue_University/Kamrul Hasan/data/avg_data_rgb_hsi/split_hsi';

training_testing_dir='/Users/kamrul/Local_HDD/Research/Purdue_University/Kamrul Hasan/data/training_testing_matfiles';

conversion_matrix_dir='/Users/kamrul/Local_HDD/Research/Purdue_University/Kamrul Hasan/data/conversion_matrix_dir';

image_dir='/Users/kamrul/Local_HDD/Research/Purdue_University/Kamrul Hasan/data/images_ori_est';

%wv = linspace(294.632,816.582,1024); 

%------------------------------------------------------------------------
% Here, we are creating two different mat files that contains the HSI
% spectra and RGB data of training and testing set.
%------------------------------------------------------------------------

[training_set_indx, testing_set_indx] = split_training_and_testing_set(hsi_destination_dir, rgb_destination_dir, index_dir, training_testing_dir);

%------------------------------------------------------------------------
% Here, we are now generating the conversion matrix using the training set
%------------------------------------------------------------------------

Pdegree=3;

generate_conversion_matrix_using_training_data(training_testing_dir, conversion_matrix_dir, Pdegree);

estimate_reflection_reconstruction_using_testing_data(training_testing_dir, conversion_matrix_dir, Pdegree)

display_comparing_with_original(training_testing_dir, index_dir, Pdegree, image_dir);

