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

If you find this work useful, please consider reading and citing our paper: 

[CARACAS: vehiCular ArchitectuRe for detAiled
Can Attacks Simulation](https://doi.org/10.1109/ISCC61673.2024.10733705)

### BibTex

```BibTex
@inproceedings{kirdi2024caracas,
  author={Kirdi, Sadek Misto and Scarano, Nicola and Oberti, Franco and Mannella, Luca and Di Carlo, Stefano and Savino, Alessandro},
  booktitle={2024 IEEE Symposium on Computers and Communications (ISCC)},
  title={{CARACAS: vehiCular ArchitectuRe for detAiled Can Attacks Simulation}},
  year={2024},
  month={June},
  pages={1--6},
  doi={10.1109/ISCC61673.2024.10733705},
  ISSN={2642-7389},
  keywords={Analytical models;Torque;Systematics;Torque control;Electric vehicles;Data models;Trajectory;Torque measurement;Computer security;Synthetic data;Automotive Security;Battery Electric Vehicles;CAN attacks;Cybersecurity;Vehicular Systems},
  abstract={
    Modern vehicles are increasingly vulnerable to attacks that exploit network infrastructures, particularly the Controller Area Network (CAN) networks. To effectively counter such threats using contemporary tools like Intrusion Detection Systems (IDSs) based on data analysis and classification, large datasets of CAN messages become imperative.This paper delves into the feasibility of generating synthetic datasets by harnessing the modeling capabilities of simulation frameworks such as Simulink coupled with a robust representation of attack models to present CARACAS, a vehicular model, including component control via CAN messages and attack injection capabilities. CARACAS showcases the efficacy of this methodology, including a Battery Electric Vehicle (BEV) model, and focuses on attacks targeting torque control in two distinct scenarios.
  },
}
```

## License 


