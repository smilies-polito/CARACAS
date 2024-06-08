
%% Vehicle Body
mass= 1611; %kg
fr_area= 2.22; %m2
drag_coeff= 0.23;
Tire_rad= 0.33435;
rolling_res_coeff= 0.01;
Gear_ratio=9; % 9:1

%% Battery Parameters
Vnom= 360; %V
Capacity= 52.4; %kWh
Rated_Cap= 145.5; % (Ah) (50*1000)/360=138.89 
R_internal= 0.001; %ohm
V1=324; %V 0.9*Vnom
AH1= 72.75; %hr.A (rated_cap/2) Charge AH1 when no-load volts are V1
AH0=0.7*Rated_Cap;
Cdc= 1e-3; %F
SOC0= 1;
Vcdc0=342; %V 0.95*Vnom initial capacitor  voltage
load ee_hv_battery_charge_discharge_Idc.mat;
%% Motor Parameters
P_rated= 150; %kW (201 hp)
P_peak= 211;  %kW 
T_rated= 350; %Nm
T_peak= 450; %Nm
Tc= 0.02; %torque control time constant
Resistance= 0.001; %ohm
efficiency= 90; % 
w_eff= 4096; %rpm
T_eff= 350; %nm
J= 0.03; % kg.m^2 (rotor inertia)
R_damp= 1e-5; % N*m/(rad/s)

%% CAN Messages
db = canDatabase("can_ecu.dbc");
message1 = canMessage(db,'Motor_Torque');
message2 = canMessage(db,'Velocity_Feedback');
message3 = canMessage(db,'Velocity_Reference');
message4 = canMessage(db,'Acceleration_Cmd_Message');
message5 = canMessage(db,'Decel_Cmd_Message');
message6 = canMessage(db,'SOC');

%% Initialize the chosen value outside the loop
chosen_cycle = 0;
t_sim=0;

ch = canChannel("MathWorks", "Virtual 1", 1) % Create a CAN channel connection using the specified device.

if ch.InitializationAccess  % If the channel has full control of the device, set the bus speed.
    configBusSpeed(ch, 500000)
end

db = canDatabase("C:\Users\Sadek\Desktop\asdf\pmsm general motor_updated_2\pmsm general motor\can_ecu.dbc") % Open the DBC-file for use.

ch.Database = db % Attach the database directly to the channel. Definitions from this database are applied automatically to decode incoming messages and signals.
start(ch) % Start the channel to establish an online connection.
%pause(10) % Wait for Messages to Accumulate on the Bus ( to be adjusted)


% Loop to prompt the user for input until a valid number is chosen
while chosen_cycle < 1 || chosen_cycle > 4
    chosen_cycle = input('Enter the number of the desired driver cycle-choose: \n 1 for Artemis Motorway Driving cycle \n 2 for WHVC \n 3 for ECE urban driving cycle \n 4 for cruise control \n');

    % Check if the chosen value is within the valid range
    if chosen_cycle < 1 || chosen_cycle > 4
        disp('You chose a wrong value. Please choose again between 1 and 3.');
    end
end

% Display the chosen value after a valid input is provided
if  chosen_cycle== 1
disp(['You chose Artemis Motorway driving cycle']);
t_sim=1068;
open_system('PMSM_gm_can_outside_Trq_attack')
simOut = sim('PMSM_gm_can_outside_Trq_attack.slx');
msgs = receive(ch, Inf, "OutputFormat", "timetable") % Receive all available messages from the channel.

stop(ch) % Disconnect the channel. 
sigs = canSignalTimetable(msgs) % Convert received messages into individual timetables

elseif  chosen_cycle==2
 disp(['You chose World harmonized vehicle driving cycle']);
 t_sim=900;
 open_system('PMSM_gm_can_outside_Trq_attack')
 simOut = sim('PMSM_gm_can_outside_Trq_attack.slx');
 msgs = receive(ch, Inf, "OutputFormat", "timetable") % Receive all available messages from the channel.
stop(ch) % Disconnect the channel. 
sigs = canSignalTimetable(msgs) % Convert received messages into individual timetables

elseif chosen_cycle==3
 disp(['You chose Extra Urban driving cycle']);
 t_sim=400;
 open_system('PMSM_gm_can_outside_Trq_attack')
 simOut = sim('PMSM_gm_can_outside_Trq_attack.slx');
 msgs = receive(ch, Inf, "OutputFormat", "timetable") % Receive all available messages from the channel.
stop(ch) % Disconnect the channel. 
sigs = canSignalTimetable(msgs) % Convert received messages into individual signal value timetables
elseif chosen_cycle==4
disp(['You chose Cruise Control']);
 t_sim=1000;
 open_system('PMSM_gm_can_outside_Trq_attack')
 simOut = sim('PMSM_gm_can_outside_Trq_attack.slx');
 msgs = receive(ch, Inf, "OutputFormat", "timetable") % Receive all available messages from the channel.
stop(ch) % Disconnect the channel. 
sigs = canSignalTimetable(msgs) % Convert received messages into individual signal value timetables

end

clear ch db %Clear unneeded variables.



Time = simOut.tout; % Time vector

T = simOut.T_measured.Data; 
Torque_measured= reshape(T, 1, []); % Actual Measured Torque
Tmes_Array = double(Torque_measured);

Torque_Requested = simOut.T_req.Data; % Requested Torque
Treq_Array = double(Torque_Requested);

SOC_measured = simOut.SOC.Data; % state of charge
SOC_Array = double(SOC_measured);


Velocity_reference = simOut.V_reference.Data; % reference velocity
Vref_Array = double(Velocity_reference);

V= simOut.V_feedback.Data; % velocity measured
Velocity_measured= reshape(V, 1, []); % Actual Measured Torque
Vmes_Array = double(Velocity_measured);


a= simOut.acc.Data; % acceleration command
acc_Array = double(a);

d= simOut.dec.Data; % deceleration command
dec_Array = double(d);

timeArray = double(Time);

%% Plots


 ModelName='PMSM_gm_can_outside_Trq_attack';     % your simulink model name
 % to open this scoppe :
 open_system('PMSM_gm_can_outside_Trq_attack/TRQ_CAN')
 open_system('PMSM_gm_can_outside_Trq_attack/Velocity_CAN')


figure;
plot(timeArray,Treq_Array,'b',LineWidth=1);
hold on,grid on
plot(timeArray,Tmes_Array,'r',LineWidth=1);
legend('Torque Requested', 'Torque Measured');
xlabel('Time(s)','FontSize',14,'FontWeight','bold');
ylabel('Torque(Nm)','FontSize',14,'FontWeight','bold');
title('Plot of Torque vs Time','FontWeight','bold');

figure;
plot(timeArray,Vref_Array,'b',LineWidth=1);
hold on,grid on
plot(timeArray,Vmes_Array,'r',LineWidth=1);
legend('Velocity Reference', 'Velocity obtained');
xlabel('Time(s)','FontSize',14,'FontWeight','bold');
ylabel('Velocity(m/s)','FontSize',14,'FontWeight','bold');
title('Plot of Velocity vs Time','FontWeight','bold');


figure;
plot(timeArray,acc_Array,'b',LineWidth=1);
hold on,grid on
plot(timeArray,dec_Array,'r',LineWidth=1);
legend('acceleration', 'deceleration');
xlabel('Time','FontSize',14,'FontWeight','bold');
ylabel('Normalized acc vs dec commands','FontSize',14,'FontWeight','bold');
title('Plot of acc and dec vs Time','FontWeight','bold');



