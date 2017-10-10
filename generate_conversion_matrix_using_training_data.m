function generate_conversion_matrix_using_training_data(training_testing_dir, conversion_matrix_dir, Pdegree)


filename=fullfile(training_testing_dir, 'rgb_image_train.mat');
var_name='rgb_img_tr';
%------------------------------------------------------------------------
%| Loading the data into different Variable name
%------------------------------------------------------------------------
rgb_data = load(filename,var_name);  % Function output form of LOAD
rgb_data = rgb_data.(var_name);


filename=fullfile(training_testing_dir, 'refl_spec_train.mat');
var_name='refl_spec_tr';
%------------------------------------------------------------------------
%| Loading the data into different Variable name
%------------------------------------------------------------------------
hsi_data = load(filename,var_name);  % Function output form of LOAD
hsi_data = hsi_data.(var_name);


v = rgb_data';

%------------------------------------------------------------------------
%| Based on the degree of Polynomial we will generate the v
%------------------------------------------------------------------------

if Pdegree == 2 
v = [ v(1,:).^2 ; v(2,:).^2 ; v(3,:).^2 ; v(1,:) ; v(2,:) ; v(3,:) ; ones(1, size(v,2)) ]; % Size= 7 x 29
elseif Pdegree == 3 
v = [ v(1,:).^3 ; v(2,:).^3 ; v(3,:).^3 ; v(1,:).^2 ; v(2,:).^2 ; v(3,:).^2 ; v(1,:) ; v(2,:) ; v(3,:) ; ones(1, size(v,2)) ]; % Size= 10 x 29
elseif Pdegree == 4
v = [ v(1,:).^4 ; v(2,:).^4 ; v(3,:).^4 ; v(1,:).^3 ; v(2,:).^3 ; v(3,:).^3 ; v(1,:).^2 ; v(2,:).^2 ; v(3,:).^2 ; v(1,:) ; v(2,:) ; v(3,:) ; ones(1, size(v,2)) ]; % % Size= 13 x 29
elseif Pdegree == 5
v = [ v(1,:).^5 ; v(2,:).^5 ; v(3,:).^5 ;v(1,:).^4 ; v(2,:).^4 ; v(3,:).^4 ; v(1,:).^3 ; v(2,:).^3 ; v(3,:).^3 ; v(1,:).^2 ; v(2,:).^2 ; v(3,:).^2 ; v(1,:) ; v(2,:) ; v(3,:) ; ones(1, size(v,2)) ]; % Size= 16 x 29
end


rgb_data = v'; 

%------------------------------------------------------------------------
%| % Use polynomial regression of different degree
%------------------------------------------------------------------------

T = rgb_data\hsi_data; % Size of T= 7 x 1024 for deg=2


filename=fullfile(conversion_matrix_dir, 'conv_matrix.mat');

save(filename, 'T');

msg=sprintf('Conversion matrix is created successfully with degree of ploynomial = %d', Pdegree);
disp(msg);

end
