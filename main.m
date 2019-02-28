% Design Of Strip Footing
clc
clear

load input.mat
load value.mat

disp("Design of Strip Footing")
disp("\n")

%Loads on Footing
Load_on_Wall = Load;
printf("Load_on_Wall = %d KN \n", Load_on_Wall)

Assume_the_Self_Weight_of_Footing = Self_Weight;
printf("Assume_the_Self_Weight_of_Footing = %d %% \n", Assume_the_Self_Weight_of_Footing)

Self_weight_of_Footing = (Self_Weight/100)*Load_on_Wall;
printf("Self_weight_of_Footing = %d KN \n", Self_weight_of_Footing)
Total_Load_on_Footing = Load_on_Wall + Self_weight_of_Footing;
printf("Total_Load_on_Footing = %d KN \n", Total_Load_on_Footing)

% Size of Footing
Width_of_Footing = (Total_Load_on_Footing/Soil_Pressure);
printf("Width_of_Footing = %d m \n", Width_of_Footing)

disp("\n")
Net_Upward_Pressure = Load_on_Wall/Width_of_Footing;
printf("Net_Upward_Pressure = %d KN/m^2/m \n", Net_Upward_Pressure)
disp("\n")

disp("Maximum Bending Moment occur at (Width_of_Wall/4) from the Center of the wall")
Moment = ((Net_Upward_Pressure/8)*(Width_of_Footing - Thickness_of_Wall)*(Width_of_Footing-(Thickness_of_Wall/4)))*1000000;
printf("Moment = %d Nmm \n", Moment)

Factored_Moment = 1.5*Moment;
printf("Factored_Moment = %d Nmm \n", Factored_Moment)

xu_max_by_d = (700)/(1100+0.87*Fy);
Ru = (0.36*Fck*xu_max_by_d*(1-0.416*xu_max_by_d));

disp("\n")
Effective_Depth_of_Footing = round(sqrt((Factored_Moment)/(Ru*1000))/10)*10;
printf("Effective_Depth_of_Footing = %d mm \n",Effective_Depth_of_Footing)

Overall_Depth_on_the_basis_of_bending = round((Effective_Depth_of_Footing + Clear_Cover)/100)*100;
printf("Overall_Depth_on_the_basis_of_bending = %d mm \n",Overall_Depth_on_the_basis_of_bending)

disp("\n")
% Depth on the Basis of one way shear
Percentage_of_Steel = Steel_Percentage;
printf("Percentage_of_Steel_for_under_Reinforced_section = %d %% \n",Percentage_of_Steel)

tc = interp2 (tables,tables,tables,Fck,Percentage_of_Steel);
k = interp1 (table(:,1),table(:,2),Overall_Depth_on_the_basis_of_bending);

Permissible_Shear_Stress = (k * tc);
printf("Permissible_Shear_Stress = %d N/mm^2 \n",Permissible_Shear_Stress)

Depth_on_the_basis_of_one_way_shear = round(((0.5*Net_Upward_Pressure*1000*(Width_of_Footing-Thickness_of_Wall))/(tc*667 + Net_Upward_Pressure))/10)*10;
printf("Depth_on_the_basis_of_one_way_shear = %d mm \n",Depth_on_the_basis_of_one_way_shear)

Overall_Depth_on_the_basis_of_one_way_shear = Depth_on_the_basis_of_one_way_shear + Clear_Cover;
printf("Overall_Depth_on_the_basis_of_one_way_shear = %d mm \n",Overall_Depth_on_the_basis_of_one_way_shear)

disp("\n")

% Design of Reinforcement
disp("Design of Reinforcement")
Area_of_Steel = ceil(((0.5*Fck)/Fy)*(1-sqrt(1-((4.6*Factored_Moment)/(Fck*1000*Depth_on_the_basis_of_one_way_shear*Depth_on_the_basis_of_one_way_shear))))*(1000*Depth_on_the_basis_of_one_way_shear));
printf("Area_of_Steel = %d mm^2 \n",Area_of_Steel)

Area_of_one_bar = ceil((pi/4)*(dia*dia));
printf("Area_of_one_bar = %d mm^2 \n",Area_of_one_bar)

Spacing_of_bars = ceil(((1000*Area_of_one_bar)/(Area_of_Steel))/10)*10;
printf("Spacing_of_bars = %d mm c/c \n",Spacing_of_bars)

disp("\n")
disp("Design of Longitudinal Reinforcement")
Area_of_longitudinal_reinforcement = ceil(0.0012*1000*Overall_Depth_on_the_basis_of_one_way_shear);
printf("Area_of_longitudinal_reinforcement = %d mm^2 \n",Area_of_longitudinal_reinforcement)

Area_of_1_bar = ceil((pi/4)*(dia_8*dia_8));
printf("Area_of_one_bar = %d mm \n",Area_of_1_bar)

Spacing = round(((1000*Area_of_1_bar)/(Area_of_longitudinal_reinforcement))/10)*10;
printf("Spacing = %d mm c/c \n",Spacing)

disp("\n")
% Check for Development Lenght

tbd = interp1 (tab(:,1),tab(:,2),Fck_for_column);
Ld= round((Fy*dia)/(4*tbd*1.6)/10)*10;
printf("Development_Lenght = %d mm \n", Ld )

Length_of_Bars = (0.5)*(Width_of_Footing*1000 - Thickness_of_Wall*1000)-(Side_Cover);
printf("Length_of_Bars = %d mm \n",Length_of_Bars)

if(Ld<Length_of_Bars)
disp("Hence Safe in Development Lenght")
elseif(Ld>Length_of_Bars)
disp("Hence Not Safe in Development Lenght")

endif
















