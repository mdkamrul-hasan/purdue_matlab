function spliting_hsi_mat_file_data2(hsi_data_source_dir, hsi_mat_file_name, hsi_data_var_name,hsi_destination_dir)

%######################################################################################################
% Since we got the normalized data of RGB and Hyper Spectral Intensity
% (HSI) together, we need to split those MAT files as individual NOR files.
% Here each individual NOR file is kept inside the "hsi_destination_dir" and
% 
%                   In this Matlab code, I have split the HSI data 
%######################################################################################################
clc;

dir_name=hsi_data_source_dir;
mat_file=hsi_mat_file_name;
var_name=hsi_data_var_name;

filename=fullfile(dir_name, mat_file);

%------------------------------------------------------------------------
%| Loading the data into different Variable name
%------------------------------------------------------------------------
hsi_data = load(filename,var_name);  % Function output form of LOAD
hsi_data = hsi_data.(var_name);

no_files=size(hsi_data,2); % The matrxi size is 1024 x 41

nor_hsi_data=[];

for indx=1:no_files
   
    %------------------------------------------------------------------------
    %|Splitting the HSI information
    %------------------------------------------------------------------------
    mat_file = sprintf('nor_hsi_%d.mat', indx);
    filename=fullfile(hsi_destination_dir, mat_file);
 
    %------------------------------------------------------------------------
    %| Taking each captured HSI and storing individually
    %------------------------------------------------------------------------
    hsi_data_T=hsi_data'; % HSI matrix is 1024 x 41 so we need to Transpose the matrix to make it 41 x 1024
    nor_hsi_data = hsi_data_T(indx,:);
    save(filename,'nor_hsi_data');
    nor_hsi_data=[];
    
end