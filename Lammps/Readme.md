# LAMMPS Tutorial – Binary Lennard-Jones Fluid Simulation

This directory contains input and output files for a basic molecular dynamics simulation using [LAMMPS](https://lammps.sandia.gov/). The system models a **binary Lennard-Jones (LJ) fluid** with randomly distributed atoms of two types in a 3D periodic box.

📽️ This project is part of a tutorial video available on YouTube:  
**https://www.youtube.com/watch?v=Ohs1aVtOSOw** 

---

## 📁 Files Included

- `input.lammps.txt` – LAMMPS input script for simulation setup and execution  
- `energy.dat` – Thermodynamic data output (kinetic & potential energy)  
- `dump.lammpstrj` – Atom trajectory file for visualization  
- `README.md` – This file

---

## 📌 Simulation Overview

- **Simulation Type**: Molecular dynamics (Langevin + NVE)
- **Atom Types**:  
  - Type 1: 1500 atoms, ε = 1.0, σ = 1.0  
  - Type 2: 100 atoms, ε = 0.5, σ = 3.0  
- **Box Dimensions**: `-20 20` in x, y, z  
- **Pair Style**: `lj/cut 2.5`  
- **Boundary Conditions**: Periodic in all directions  
- **Timestep**: 0.005  
- **Run Length**: 10,000 steps  

---

## ⚙️ LAMMPS Commands Used

- `units lj`  
- `pair_style lj/cut`  
- `create_atoms`  
- `fix langevin`, `fix nve`  
- `dump`, `thermo`, `minimize`, `run`, `variable`, `neigh_modify`  

---

## 📊 Output

- **`energy.dat`**: Contains time-averaged kinetic and potential energy.  
- **`dump.lammpstrj`**: Can be visualized with tools like [OVITO](https://www.ovito.org/) or [VMD](https://www.ks.uiuc.edu/Research/vmd/).  

---

## 📚 Reference

This example is based on:

> Gravelle, S., Gissinger, J.R., & Kohlmeyer, A. (2025). *A Set of Tutorials for the LAMMPS Simulation Package*. [LiveCoMS Article](https://github.com/lammpstutorials/lammpstutorials-article)

---

## 🔧 Requirements

- LAMMPS (version ≥ 29Aug2024 recommended)  
- Optional: OVITO, VMD, or ParaView for visualization  
- Platform: Linux, macOS, or Windows

---

## 📥 Getting Started

To run the simulation:

```bash
lmp -in input.lammps.txt
