# CARACAS



## Getting started
The following MATLAB code contains the main parameters of the BEV model which was used to simulate the injection of malicious signals into the CAN network of the vehicle. 

It is mainly split into 6 modules as following:

1. Vehicle Body parameters
2. Battery parameters
3. Motor parameters
4. CAN messages that we are interested in monitoring
5. Simulation of different driving cycles where the user can choose between 4 different driving cycles : 
-  Artemis Motorway Driving cycle 
-  WHVC 
-  ECE urban driving cycle 
-  cruise control 
6. Data extraction from simulink

## Launching the Simulation
To launch the simulation, run the "pmsm_g".m file where a user prompt will be shown in the command window thats asks to choose which driving cycle to simulate. Once you choose the number associated to the driving cycle, the simulation will start and at the end all the scopes relative to the results will be shown automatically.
You can also adjust the simulation parameters inside the "pmsm_g".m file to simulate different scenarios and BEV types.
## Reference  
if you find this work useful in your research, please consider citing our paper.

[CARACAS: vehiCular ArchitectuRe for detAiled
Can Attacks Simulation](link to paper) 

## License 







