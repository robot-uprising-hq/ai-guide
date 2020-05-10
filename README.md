# Micro Invaders

Micro Invaders is a strategic robot battle, where two teams are playing capture the flag stylish game against each other. Each team has 2 autonomous robots. The aim is to collect energy cores, i.e. balls, into their own goals before the opponent does. The robots have access to a top down video stream that can be used to find the locations of the energy cores and robots. The robots are allowed to communicate to external computers.

In software side, there are no technology restrictions, in other words AI can be made based on rules or machine learning models. To train machine learning models in a real physical environment is often too time consuming, which is why we have built a simulation environment.

## Simulation Environment


The simulation environment is designated to train agents, i.e. robots, with reinforcement learning. The simulation can also be used to test rule-based agents. The environment is built so that the same ml models, which are trained in the simulation, can be transferred to a physical environment.

The simulation is running on [Unity](https://unity.com/) (version 2019.3.0f6). The training framework is [Unity ml-agents](https://github.com/Unity-Technologies/ml-agents) (version 0.14.0). Under the ml-agent is running [TensorFlow](https://www.tensorflow.org/). 

Windows, MacOs and Linux (Ubuntu 16, 18, CentOS 7) are supported.


### Components

The simulation environment consists of a few different components.

[Micro AI Simulation](https://github.com/robot-uprising-hq/artificial-invaders-ai-unity-simulator) includes the simulation environment. The environment is used to run the simulation, and also, it used to train the agents.

[Brain Server](https://github.com/robot-uprising-hq/artificial-invaders-ai-unity-brain-server) is used to act as a brain of trained agents. When an agent has been trained with Unity ml-agents, the trained model is saved to a “brain file”. This repository works as a server that runs those brain files. Brain server can be used in the simulated environment and in the physical one. In simulated environment, AI Simulation hosts the simulated environment and the agents decide their actions by fetching actions from Brain Sever. In physical environment, Robot Backend fetches robot's actions from Brain Server. The communicaton is happening though gRPC protocol.

[Robot Backend](https://github.com/robot-uprising-hq/artificial-invaders-ai-robot-backend) is a critical middle piece that connects the trained model with the real world, in other words it connects Brain Server with Robot Frontend. Backend can also be used with the simulation. Backend has multiplte tasks: it sends commands to robots (real or simulated), fetches actions from Brain Server, and calculates the required data points such as robot coordinates by using image recognition.

[Video Streamer](https://github.com/robot-uprising-hq/artificial-invaders-ai-video-streamer) is used to send the video stream of the Raspberry Pi camera to Robot Backend. The physical game (and also simulated one) has a top down view camera that can be used to find relevant coordinates, such as locations of the robots and energy cores. This is only required if streaming through Rasberry Pi. 

[Robot Frontend](https://github.com/robot-uprising-hq/artificial-invaders-ai-robot-frontend) is used only in a real environment. Frontend listens to commands from Backend, and converts the commands to motor commands. In other words, nothing intelligent is done in Frontend.
